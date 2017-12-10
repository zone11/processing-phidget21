import com.phidgets.*;
import com.phidgets.event.*;

InterfaceKitPhidget ik;

void setupIKP() {
 try {
   println( Phidget.getLibraryVersion() );
   ik = new InterfaceKitPhidget();

   ik.addAttachListener(new AttachListener() {
     public void attached(AttachEvent ae) {
       println("attachment of " + ae);
     }
   });
   ik.addDetachListener(new DetachListener() {
     public void detached(DetachEvent de) {
       println("detachment of " + de);
     }
   });
   ik.addErrorListener(new ErrorListener() {
     public void error(ErrorEvent ee) {
       println("error event for " + ee);
     }
   });
   ik.addInputChangeListener(new InputChangeListener() {
     public void inputChanged(InputChangeEvent ie) {
       println("input event for " + ie);
     }
   });
   ik.addOutputChangeListener(new OutputChangeListener() {
     public void outputChanged(OutputChangeEvent oe) {
       println("output event for " + oe);
     }
   });
   ik.addSensorChangeListener(new SensorChangeListener() {
     public void sensorChanged(SensorChangeEvent se) {
       println("sensor event for " + se);
       try {
         background(color(map(ik.getSensorValue(7),0,999,0,255),100,map(ik.getSensorValue(6),0,999,0,255)));
       } catch (PhidgetException ex){}       
     }
   });

   ik.openAny();
   println("waiting for InterfaceKit attachment...");
   ik.waitForAttachment();

   println("Device"+ik.getDeviceName()+" is ready!");

 } catch (PhidgetException ex) {
   println(ex);
 }
}


void closeIKP(){
 try {
   print("closing...");
   ik.close();
   ik = null;
   println(" ok");
   if (false) {
     println("wait for finalization...");
     System.gc();
   }
 } catch (PhidgetException ex) {
   println(ex);
 }
}


void setup() {
 size(200,200);
 background(255);
 colorMode(HSB);
 setupIKP();
}


void draw() {
} 

void stop() {
  closeIKP();
  println("ByeBye!");
  exit(); 
}