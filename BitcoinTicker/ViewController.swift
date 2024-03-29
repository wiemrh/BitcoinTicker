//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by WIEM REBAH on 30/09/2019.
//  Copyright © 2019 . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate  {
  
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
     let symboleArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var symbole = ""
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        print(symboleArray[row])
        symbole = symboleArray[row]
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        getBitcoinTickerData(url: finalURL)
    }
    
    

    
    
    
//    
//    //MARK: - Networking
//    /***************************************************************/
//    
    func getBitcoinTickerData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                    print("Sucess! Got the Bitcoin Ticker data")
                    let BitcoinTickerJSON : JSON = JSON(response.result.value!)
                    print(BitcoinTickerJSON)

                    self.updateBitcoinTickerData(json: BitcoinTickerJSON)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }

    
    
    
//
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func updateBitcoinTickerData(json : JSON) {

        if let BitcoinTickerResult = json["ask"].double {

            self.bitcoinPriceLabel.text = symbole + String(BitcoinTickerResult)
            
 }
        else {
            self.bitcoinPriceLabel.text = "Connection Issues"
        }
    }
    




}

