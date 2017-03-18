//
//  ViewController.swift
//  DemoLocalNotification
//
//  Created by Tuuu on 3/18/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *)
        {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in }
            center.delegate = self
        }
        else
        {
            
        }
    }

    func addNotificationWithTrigger(trigger: UNNotificationTrigger)
    {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Techmaster", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Học là có việc", arguments: nil)
        content.sound = UNNotificationSound.init(named: "test.aiff")
        
        content.badge = NSNumber(integerLiteral: UIApplication.shared.applicationIconBadgeNumber + 1);
        content.categoryIdentifier = "iOSSwift"
        if let path = Bundle.main.path(forResource: "ngoctrinh", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "ngoctrinh", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        
        let request = UNNotificationRequest.init(identifier: "FiveSecond", content: content, trigger: trigger)
        
        // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    @IBAction func removeNotification(_ sender: UIButton) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
    @IBAction func triggerNotification(_ sender: UIButton) {
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        addNotificationWithTrigger(trigger: trigger)
    }
    
    @IBAction func datePickerDidSelectNewDate(_ sender: UIDatePicker) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: sender.date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        addNotificationWithTrigger(trigger: trigger)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UNUserNotificationCenterDelegate
{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void)
    {
        print("??")
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void)
    {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

