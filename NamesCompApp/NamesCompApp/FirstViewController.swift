//
//  ViewController.swift
//  NamesCompApp
//
//  Created by Tikhon Bazar on 18.01.23.
//

import UIKit

class FirstViewController: UIViewController {

    
    @IBOutlet weak var partnerNameTF: UITextField!
    @IBOutlet weak var yourNameTF: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultViewController else { return }
        destinationVC.firstName = yourNameTF.text
        destinationVC.secondName = partnerNameTF.text
    }
    
    @IBAction func resultButtonTapped() {
        guard let firstName = yourNameTF.text, let secondName = partnerNameTF.text else {return}
        if firstName.isEmpty || secondName.isEmpty{
            showAlert(
                title: "Names are missing",
                message: "Please enter both names ☺️"
            )
            return
        }
        if isNumber(text: firstName) || isNumber(text: secondName){
            showAlert(title: "Number in the name", message: "Try again")
            return
        }
        performSegue(withIdentifier: "goToResult", sender: nil)
        
    }
    @IBAction func unwindSegueToFirstVC(segue: UIStoryboardSegue){
        yourNameTF.text = ""
        partnerNameTF.text = ""
    }
    
}
extension FirstViewController : UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == yourNameTF{
            partnerNameTF.becomeFirstResponder()
        }else{
            resultButtonTapped()
        }
        return true
    }
}
extension FirstViewController{
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    private func isNumber(text:String) -> Bool {
        let arr = text.components(separatedBy: "")
        for i in arr{
            if i == "0" || i == "1" || i == "2" || i == "3" || i == "4" || i == "5" || i == "6" || i == "7" || i == "8" || i == "9"{
                return true
            }
        }
        return false
    }
}
