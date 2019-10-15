Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C161ED82F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388974AbfJOVup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:50:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732448AbfJOVup (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:50:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21FD4308A98C;
        Tue, 15 Oct 2019 21:50:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 332655D9E2;
        Tue, 15 Oct 2019 21:50:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 19/21] usb: Add USB subsystem notifications
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Oct 2019 22:50:40 +0100
Message-ID: <157117624044.15019.15681888621457119329.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 15 Oct 2019 21:50:44 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a USB subsystem notification mechanism whereby notifications about
hardware events such as device connection, disconnection, reset and I/O
errors, can be reported to a monitoring process asynchronously.

Firstly, an event queue needs to be created:

	pipe2(fds, O_TMPFILE);
	ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);

then a notification can be set up to report USB notifications via that
queue:

	struct watch_notification_filter filter = {
		.nr_filters = 1,
		.filters = {
			[0] = {
				.type = WATCH_TYPE_USB_NOTIFY,
				.subtype_filter[0] = UINT_MAX;
			},
		},
	};
	ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);
	notify_devices(fds[1], 12);

After that, messages will be placed into the queue when events occur on a
USB device or bus.  Messages are of the following format:

	struct usb_notification {
		struct watch_notification watch;
		__u32	error;
		__u32	reserved;
		__u8	name_len;
		__u8	name[0];
	} *n;

Where:

	n->watch.type will be WATCH_TYPE_USB_NOTIFY

	n->watch.subtype will be the type of notification, such as
	NOTIFY_USB_DEVICE_ADD.

	n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
	message.

	n->watch.info & WATCH_INFO_ID will be the second argument to
	device_notify(), shifted.

	n->error and n->reserved are intended to convey information such as
	error codes, but are currently not used

	n->name_len and n->name convey the USB device name as an
	unterminated string.  This may be truncated - it is currently
	limited to a maximum 63 chars.

Note that it is permissible for messages to be of variable length - or, at
least, the length may be dependent on the subtype.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: linux-usb@vger.kernel.org
---

 Documentation/watch_queue.rst    |    9 +++++++
 drivers/usb/core/Kconfig         |    9 +++++++
 drivers/usb/core/devio.c         |   47 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/hub.c           |    4 +++
 include/linux/usb.h              |   18 +++++++++++++++
 include/uapi/linux/watch_queue.h |   28 ++++++++++++++++++++++-
 samples/watch_queue/watch_test.c |   29 +++++++++++++++++++++++
 7 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index f2299f631ae8..5321a9cb1ab2 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -12,6 +12,8 @@ opened by userspace.  This can be used in conjunction with::
 
     * Block layer event notifications
 
+    * USB subsystem event notifications
+
 
 The notifications buffers can be enabled by:
 
@@ -262,6 +264,13 @@ Any particular buffer can be fed from multiple sources.  Sources include:
     or temporary link loss.  Watches of this type are set on the global device
     watch list.
 
+  * WATCH_TYPE_USB_NOTIFY
+
+    Notifications of this type indicate USB subsystem events, such as
+    attachment, removal, reset and I/O errors.  Separate events are generated
+    for buses and devices.  Watchpoints of this type are set on the global
+    device watch list.
+
 
 Event Filtering
 ===============
diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index ecaacc8ed311..57e7b649e48b 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -102,3 +102,12 @@ config USB_AUTOSUSPEND_DELAY
 	  The default value Linux has always had is 2 seconds.  Change
 	  this value if you want a different delay and cannot modify
 	  the command line or module parameter.
+
+config USB_NOTIFICATIONS
+	bool "Provide USB hardware event notifications"
+	depends on USB && DEVICE_NOTIFICATIONS
+	help
+	  This option provides support for getting hardware event notifications
+	  on USB devices and interfaces.  This makes use of the
+	  /dev/watch_queue misc device to handle the notification buffer.
+	  device_notify(2) is used to set/remove watches.
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 3f899552f6e3..693a5657dba3 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -41,6 +41,7 @@
 #include <linux/dma-mapping.h>
 #include <asm/byteorder.h>
 #include <linux/moduleparam.h>
+#include <linux/watch_queue.h>
 
 #include "usb.h"
 
@@ -2748,13 +2749,59 @@ static void usbdev_remove(struct usb_device *udev)
 	mutex_unlock(&usbfs_mutex);
 }
 
+#ifdef CONFIG_USB_NOTIFICATIONS
+static noinline void post_usb_notification(const char *devname,
+					   enum usb_notification_type subtype,
+					   u32 error)
+{
+	unsigned int name_len, n_len;
+	u64 id = 0; /* We can put a device ID here for separate dev watches */
+
+	struct {
+		struct usb_notification n;
+		char more_name[USB_NOTIFICATION_MAX_NAME_LEN -
+			       (sizeof(struct usb_notification) -
+				offsetof(struct usb_notification, name))];
+	} n;
+
+	name_len = strlen(devname);
+	name_len = min_t(size_t, name_len, USB_NOTIFICATION_MAX_NAME_LEN);
+	n_len = offsetof(struct usb_notification, name) + name_len;
+
+	memset(&n, 0, sizeof(n));
+	memcpy(n.n.name, devname, n_len);
+
+	n.n.watch.type		= WATCH_TYPE_USB_NOTIFY;
+	n.n.watch.subtype	= subtype;
+	n.n.watch.info		= n_len;
+	n.n.error		= error;
+	n.n.name_len		= name_len;
+
+	post_device_notification(&n.n.watch, id);
+}
+
+void post_usb_device_notification(const struct usb_device *udev,
+				  enum usb_notification_type subtype, u32 error)
+{
+	post_usb_notification(dev_name(&udev->dev), subtype, error);
+}
+
+void post_usb_bus_notification(const struct usb_bus *ubus,
+			       enum usb_notification_type subtype, u32 error)
+{
+	post_usb_notification(ubus->bus_name, subtype, error);
+}
+#endif
+
 static int usbdev_notify(struct notifier_block *self,
 			       unsigned long action, void *dev)
 {
 	switch (action) {
 	case USB_DEVICE_ADD:
+		post_usb_device_notification(dev, NOTIFY_USB_DEVICE_ADD, 0);
 		break;
 	case USB_DEVICE_REMOVE:
+		post_usb_device_notification(dev, NOTIFY_USB_DEVICE_REMOVE, 0);
 		usbdev_remove(dev);
 		break;
 	}
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 236313f41f4a..e8ebacc15a32 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -29,6 +29,7 @@
 #include <linux/random.h>
 #include <linux/pm_qos.h>
 #include <linux/kobject.h>
+#include <linux/watch_queue.h>
 
 #include <linux/uaccess.h>
 #include <asm/byteorder.h>
@@ -4605,6 +4606,9 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 				(udev->config) ? "reset" : "new", speed,
 				devnum, driver_name);
 
+	if (udev->config)
+		post_usb_device_notification(udev, NOTIFY_USB_DEVICE_RESET, 0);
+
 	/* Set up TT records, if needed  */
 	if (hdev->tt) {
 		udev->tt = hdev->tt;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index e656e7b4b1e4..93fa0666f95a 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -26,6 +26,7 @@
 struct usb_device;
 struct usb_driver;
 struct wusb_dev;
+enum usb_notification_type;
 
 /*-------------------------------------------------------------------------*/
 
@@ -2015,6 +2016,23 @@ extern void usb_led_activity(enum usb_led_event ev);
 static inline void usb_led_activity(enum usb_led_event ev) {}
 #endif
 
+/*
+ * Notification functions.
+ */
+#ifdef CONFIG_USB_NOTIFICATIONS
+extern void post_usb_device_notification(const struct usb_device *udev,
+					 enum usb_notification_type subtype,
+					 u32 error);
+extern void post_usb_bus_notification(const struct usb_bus *ubus,
+				      enum usb_notification_type subtype,
+				      u32 error);
+#else
+static inline void post_usb_device_notification(const struct usb_device *udev,
+						unsigned int subtype, u32 error) {}
+static inline void post_usb_bus_notification(const struct usb_bus *ubus,
+					     unsigned int subtype, u32 error) {}
+#endif
+
 #endif  /* __KERNEL__ */
 
 #endif
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 65b127ca272b..f6aa1e39ceea 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -12,7 +12,8 @@ enum watch_notification_type {
 	WATCH_TYPE_META		= 0,	/* Special record */
 	WATCH_TYPE_KEY_NOTIFY	= 1,	/* Key change event notification */
 	WATCH_TYPE_BLOCK_NOTIFY	= 2,	/* Block layer event notification */
-	WATCH_TYPE___NR		= 3
+	WATCH_TYPE_USB_NOTIFY	= 3,	/* USB subsystem event notification */
+	WATCH_TYPE___NR		= 4
 };
 
 enum watch_meta_notification_subtype {
@@ -126,4 +127,29 @@ struct block_notification {
 	__u64	sector;			/* Affected sector */
 };
 
+/*
+ * Type of USB layer notification.
+ */
+enum usb_notification_type {
+	NOTIFY_USB_DEVICE_ADD		= 0, /* USB device added */
+	NOTIFY_USB_DEVICE_REMOVE	= 1, /* USB device removed */
+	NOTIFY_USB_DEVICE_RESET		= 2, /* USB device reset */
+	NOTIFY_USB_DEVICE_ERROR		= 3, /* USB device error */
+};
+
+/*
+ * USB subsystem notification record.
+ * - watch.type = WATCH_TYPE_USB_NOTIFY
+ * - watch.subtype = enum usb_notification_type
+ */
+struct usb_notification {
+	struct watch_notification watch; /* WATCH_TYPE_USB_NOTIFY */
+	__u32	error;
+	__u32	reserved;
+	__u8	name_len;		/* Length of device name */
+	__u8	name[0];		/* Device name (padded to __u64, truncated at 63 chars) */
+};
+
+#define USB_NOTIFICATION_MAX_NAME_LEN 63
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
index 263dbba59651..ca3d55208852 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -85,6 +85,26 @@ static void saw_block_change(struct watch_notification *n, size_t len)
 	       (unsigned long long)b->sector);
 }
 
+static const char *usb_subtypes[256] = {
+	[NOTIFY_USB_DEVICE_ADD]		= "dev-add",
+	[NOTIFY_USB_DEVICE_REMOVE]	= "dev-remove",
+	[NOTIFY_USB_DEVICE_RESET]	= "dev-reset",
+	[NOTIFY_USB_DEVICE_ERROR]	= "dev-error",
+};
+
+static void saw_usb_event(struct watch_notification *n, size_t len)
+{
+	struct usb_notification *u = (struct usb_notification *)n;
+
+	if (len < sizeof(struct usb_notification))
+		return;
+
+	printf("USB %*.*s %s e=%x r=%x\n",
+	       u->name_len, u->name_len, u->name,
+	       usb_subtypes[n->subtype],
+	       u->error, u->reserved);
+}
+
 /*
  * Consume and display events.
  */
@@ -161,6 +181,9 @@ static void consumer(int fd)
 			case WATCH_TYPE_BLOCK_NOTIFY:
 				saw_block_change(&n.n, len);
 				break;
+			case WATCH_TYPE_USB_NOTIFY:
+				saw_usb_event(&n.n, len);
+				break;
 			default:
 				printf("other type\n");
 				break;
@@ -172,7 +195,7 @@ static void consumer(int fd)
 }
 
 static struct watch_notification_filter filter = {
-	.nr_filters	= 2,
+	.nr_filters	= 3,
 	.filters = {
 		[0]	= {
 			.type			= WATCH_TYPE_KEY_NOTIFY,
@@ -182,6 +205,10 @@ static struct watch_notification_filter filter = {
 			.type			= WATCH_TYPE_BLOCK_NOTIFY,
 			.subtype_filter[0]	= UINT_MAX,
 		},
+		[2]	= {
+			.type			= WATCH_TYPE_USB_NOTIFY,
+			.subtype_filter[0]	= UINT_MAX,
+		},
 	},
 };
 

