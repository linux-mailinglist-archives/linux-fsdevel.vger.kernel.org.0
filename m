Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9AA38CC8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 16:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfFGOTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 10:19:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbfFGOTW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:19:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C47323081252;
        Fri,  7 Jun 2019 14:19:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF59769600;
        Fri,  7 Jun 2019 14:19:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/13] usb: Add USB subsystem notifications [ver #4]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, dhowells@redhat.com, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Jun 2019 15:19:14 +0100
Message-ID: <155991715405.15579.10293116686588296857.stgit@warthog.procyon.org.uk>
In-Reply-To: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 07 Jun 2019 14:19:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a USB subsystem notification mechanism whereby notifications about
hardware events such as device connection, disconnection, reset and I/O
errors, can be reported to a monitoring process asynchronously.

Firstly, an event queue needs to be created:

	fd = open("/dev/event_queue", O_RDWR);
	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, page_size << n);

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
	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
	notify_devices(fd, 12);

After that, records will be placed into the queue when events occur on a
USB device or bus.  Records are of the following format:

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
	record.

	n->watch.info & WATCH_INFO_ID will be the second argument to
	device_notify(), shifted.

	n->error and n->reserved are intended to convey information such as
	error codes, but are currently not used

	n->name_len and n->name convey the USB device name as an
	unterminated string.  This may be truncated - it is currently
	limited to a maximum 63 chars.

Note that it is permissible for event records to be of variable length -
or, at least, the length may be dependent on the subtype.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: linux-usb@vger.kernel.org
---

 Documentation/watch_queue.rst    |    9 ++++++
 drivers/usb/core/Kconfig         |   10 +++++++
 drivers/usb/core/devio.c         |   55 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/hub.c           |    3 ++
 include/linux/usb.h              |   19 +++++++++++++
 include/uapi/linux/watch_queue.h |   30 ++++++++++++++++++++-
 6 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index c2954e191989..7ce5d4147fa9 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -15,6 +15,8 @@ receive notifications from the kernel.  This can be used in conjunction with::
 
     * Block layer event notifications
 
+    * USB subsystem event notifications
+
 
 The notifications buffers can be enabled by:
 
@@ -344,6 +346,13 @@ Any particular buffer can be fed from multiple sources.  Sources include:
     or temporary link loss.  Watchpoints of this type are set on the global
     device watch list.
 
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
index bdb6bd0b63a6..4be88368ab6b 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -103,3 +103,13 @@ config USB_AUTOSUSPEND_DELAY
 	  The default value Linux has always had is 2 seconds.  Change
 	  this value if you want a different delay and cannot modify
 	  the command line or module parameter.
+
+config USB_NOTIFICATIONS
+	bool "Provide USB hardware event notifications"
+	depends on USB
+	select DEVICE_NOTIFICATIONS
+	help
+	  This option provides support for getting hardware event notifications
+	  on USB devices and interfaces.  This makes use of the
+	  /dev/watch_queue misc device to handle the notification buffer.
+	  device_notify(2) is used to set/remove watches.
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index fa783531ee88..af7f339c35c5 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -41,6 +41,7 @@
 #include <linux/dma-mapping.h>
 #include <asm/byteorder.h>
 #include <linux/moduleparam.h>
+#include <linux/watch_queue.h>
 
 #include "usb.h"
 
@@ -2633,13 +2634,67 @@ static void usbdev_remove(struct usb_device *udev)
 	}
 }
 
+#ifdef CONFIG_USB_NOTIFICATIONS
+static noinline void post_usb_notification(const char *devname,
+					   enum usb_notification_type subtype,
+					   u32 error)
+{
+	unsigned int name_len, n_len;
+	u64 id = 0; /* Might want to put a dev# here. */
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
+	n_len = round_up(offsetof(struct usb_notification, name) + name_len,
+			 sizeof(__u64));
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
+		usbdev_remove(dev);
+		break;
+	case USB_BUS_ADD:
+		post_usb_bus_notification(dev, NOTIFY_USB_BUS_ADD, 0);
+		break;
+	case USB_BUS_REMOVE:
+		post_usb_bus_notification(dev, NOTIFY_USB_BUS_REMOVE, 0);
 		usbdev_remove(dev);
 		break;
 	}
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 2f94568ba385..722013d8142c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4596,6 +4596,9 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 				(udev->config) ? "reset" : "new", speed,
 				devnum, driver_name);
 
+	if (udev->config)
+		post_usb_device_notification(udev, NOTIFY_USB_DEVICE_RESET, 0);
+
 	/* Set up TT records, if needed  */
 	if (hdev->tt) {
 		udev->tt = hdev->tt;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index ae82d9d1112b..12687b55811d 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -2008,6 +2008,25 @@ extern void usb_led_activity(enum usb_led_event ev);
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
+						enum usb_notification_type subtype,
+						u32 error) {}
+static inline void post_usb_bus_notification(const struct usb_bus *ubus,
+					     enum usb_notification_type subtype,
+					     u32 error) {}
+#endif
+
 #endif  /* __KERNEL__ */
 
 #endif
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 22e3326b83a6..d596ac5a61e4 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -14,7 +14,8 @@ enum watch_notification_type {
 	WATCH_TYPE_SB_NOTIFY	= 2,	/* Superblock notification */
 	WATCH_TYPE_KEY_NOTIFY	= 3,	/* Key/keyring change notification */
 	WATCH_TYPE_BLOCK_NOTIFY	= 4,	/* Block layer notifications */
-#define WATCH_TYPE___NR 5
+	WATCH_TYPE_USB_NOTIFY	= 5,	/* USB subsystem notifications */
+#define WATCH_TYPE___NR 6
 };
 
 enum watch_meta_notification_subtype {
@@ -182,4 +183,31 @@ struct block_notification {
 	__u64	sector;			/* Affected sector */
 };
 
+/*
+ * Type of USB layer notification.
+ */
+enum usb_notification_type {
+	NOTIFY_USB_DEVICE_ADD		= 0, /* USB device added */
+	NOTIFY_USB_DEVICE_REMOVE	= 1, /* USB device removed */
+	NOTIFY_USB_BUS_ADD		= 2, /* USB bus added */
+	NOTIFY_USB_BUS_REMOVE		= 3, /* USB bus removed */
+	NOTIFY_USB_DEVICE_RESET		= 4, /* USB device reset */
+	NOTIFY_USB_DEVICE_ERROR		= 5, /* USB device error */
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

