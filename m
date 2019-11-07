Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A143F2FD7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbfKGNhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:37:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389275AbfKGNhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWN9xgdKQeSkGU4ViuanEzg0T+7doUMvHiKsqWmECZ4=;
        b=AWsr6oTlLtR242flALmHJRdh44AI2fIzM9WbDg4/4eLMgp8N+2ZkeATFwd8wlpEsc4JaFz
        9BDJQTO0fR1qUK8NDQEZ5wkZY9WDlguX1hDGdzM/fAgTzbsH2e2iRvKMI4dfJe7XMX7wZt
        yJBhmxvcZJLAPz1oYHl46sMsvtN/DOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-c6iYBI16NOG2AIZZfXLyeA-1; Thu, 07 Nov 2019 08:37:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E4D0800C61;
        Thu,  7 Nov 2019 13:37:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91F7C600D1;
        Thu,  7 Nov 2019 13:37:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 12/14] usb: Add USB subsystem notifications [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Nov 2019 13:37:08 +0000
Message-ID: <157313382877.29677.8555697148149429709.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: c6iYBI16NOG2AIZZfXLyeA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a USB subsystem notification mechanism whereby notifications about
hardware events such as device connection, disconnection, reset and I/O
errors, can be reported to a monitoring process asynchronously.

Firstly, an event queue needs to be created:

=09pipe2(fds, O_NOTIFICATION_PIPE);
=09ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);

then a notification can be set up to report USB notifications via that
queue:

=09struct watch_notification_filter filter =3D {
=09=09.nr_filters =3D 1,
=09=09.filters =3D {
=09=09=09[0] =3D {
=09=09=09=09.type =3D WATCH_TYPE_USB_NOTIFY,
=09=09=09=09.subtype_filter[0] =3D UINT_MAX;
=09=09=09},
=09=09},
=09};
=09ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);
=09notify_devices(fds[1], 12);

After that, messages will be placed into the queue when events occur on a
USB device or bus.  Messages are of the following format:

=09struct usb_notification {
=09=09struct watch_notification watch;
=09=09__u32=09error;
=09=09__u32=09reserved;
=09=09__u8=09name_len;
=09=09__u8=09name[0];
=09} *n;

Where:

=09n->watch.type will be WATCH_TYPE_USB_NOTIFY

=09n->watch.subtype will be the type of notification, such as
=09NOTIFY_USB_DEVICE_ADD.

=09n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
=09message.

=09n->watch.info & WATCH_INFO_ID will be the second argument to
=09device_notify(), shifted.

=09n->error and n->reserved are intended to convey information such as
=09error codes, but are currently not used

=09n->name_len and n->name convey the USB device name as an
=09unterminated string.  This may be truncated - it is currently
=09limited to a maximum 63 chars.

Note that it is permissible for messages to be of variable length - or, at
least, the length may be dependent on the subtype.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: linux-usb@vger.kernel.org
---

 Documentation/watch_queue.rst    |    9 +++++++
 drivers/usb/core/Kconfig         |    9 +++++++
 drivers/usb/core/devio.c         |   47 ++++++++++++++++++++++++++++++++++=
++++
 drivers/usb/core/hub.c           |    4 +++
 include/linux/usb.h              |   18 +++++++++++++++
 include/uapi/linux/watch_queue.h |   28 ++++++++++++++++++++++-
 samples/watch_queue/watch_test.c |   29 +++++++++++++++++++++++
 7 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index f2299f631ae8..5321a9cb1ab2 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -12,6 +12,8 @@ opened by userspace.  This can be used in conjunction wit=
h::
=20
     * Block layer event notifications
=20
+    * USB subsystem event notifications
+
=20
 The notifications buffers can be enabled by:
=20
@@ -262,6 +264,13 @@ Any particular buffer can be fed from multiple sources=
.  Sources include:
     or temporary link loss.  Watches of this type are set on the global de=
vice
     watch list.
=20
+  * WATCH_TYPE_USB_NOTIFY
+
+    Notifications of this type indicate USB subsystem events, such as
+    attachment, removal, reset and I/O errors.  Separate events are genera=
ted
+    for buses and devices.  Watchpoints of this type are set on the global
+    device watch list.
+
=20
 Event Filtering
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index ecaacc8ed311..57e7b649e48b 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -102,3 +102,12 @@ config USB_AUTOSUSPEND_DELAY
 =09  The default value Linux has always had is 2 seconds.  Change
 =09  this value if you want a different delay and cannot modify
 =09  the command line or module parameter.
+
+config USB_NOTIFICATIONS
+=09bool "Provide USB hardware event notifications"
+=09depends on USB && DEVICE_NOTIFICATIONS
+=09help
+=09  This option provides support for getting hardware event notifications
+=09  on USB devices and interfaces.  This makes use of the
+=09  /dev/watch_queue misc device to handle the notification buffer.
+=09  device_notify(2) is used to set/remove watches.
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 3f899552f6e3..693a5657dba3 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -41,6 +41,7 @@
 #include <linux/dma-mapping.h>
 #include <asm/byteorder.h>
 #include <linux/moduleparam.h>
+#include <linux/watch_queue.h>
=20
 #include "usb.h"
=20
@@ -2748,13 +2749,59 @@ static void usbdev_remove(struct usb_device *udev)
 =09mutex_unlock(&usbfs_mutex);
 }
=20
+#ifdef CONFIG_USB_NOTIFICATIONS
+static noinline void post_usb_notification(const char *devname,
+=09=09=09=09=09   enum usb_notification_type subtype,
+=09=09=09=09=09   u32 error)
+{
+=09unsigned int name_len, n_len;
+=09u64 id =3D 0; /* We can put a device ID here for separate dev watches *=
/
+
+=09struct {
+=09=09struct usb_notification n;
+=09=09char more_name[USB_NOTIFICATION_MAX_NAME_LEN -
+=09=09=09       (sizeof(struct usb_notification) -
+=09=09=09=09offsetof(struct usb_notification, name))];
+=09} n;
+
+=09name_len =3D strlen(devname);
+=09name_len =3D min_t(size_t, name_len, USB_NOTIFICATION_MAX_NAME_LEN);
+=09n_len =3D offsetof(struct usb_notification, name) + name_len;
+
+=09memset(&n, 0, sizeof(n));
+=09memcpy(n.n.name, devname, n_len);
+
+=09n.n.watch.type=09=09=3D WATCH_TYPE_USB_NOTIFY;
+=09n.n.watch.subtype=09=3D subtype;
+=09n.n.watch.info=09=09=3D n_len;
+=09n.n.error=09=09=3D error;
+=09n.n.name_len=09=09=3D name_len;
+
+=09post_device_notification(&n.n.watch, id);
+}
+
+void post_usb_device_notification(const struct usb_device *udev,
+=09=09=09=09  enum usb_notification_type subtype, u32 error)
+{
+=09post_usb_notification(dev_name(&udev->dev), subtype, error);
+}
+
+void post_usb_bus_notification(const struct usb_bus *ubus,
+=09=09=09       enum usb_notification_type subtype, u32 error)
+{
+=09post_usb_notification(ubus->bus_name, subtype, error);
+}
+#endif
+
 static int usbdev_notify(struct notifier_block *self,
 =09=09=09       unsigned long action, void *dev)
 {
 =09switch (action) {
 =09case USB_DEVICE_ADD:
+=09=09post_usb_device_notification(dev, NOTIFY_USB_DEVICE_ADD, 0);
 =09=09break;
 =09case USB_DEVICE_REMOVE:
+=09=09post_usb_device_notification(dev, NOTIFY_USB_DEVICE_REMOVE, 0);
 =09=09usbdev_remove(dev);
 =09=09break;
 =09}
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 236313f41f4a..e8ebacc15a32 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -29,6 +29,7 @@
 #include <linux/random.h>
 #include <linux/pm_qos.h>
 #include <linux/kobject.h>
+#include <linux/watch_queue.h>
=20
 #include <linux/uaccess.h>
 #include <asm/byteorder.h>
@@ -4605,6 +4606,9 @@ hub_port_init(struct usb_hub *hub, struct usb_device =
*udev, int port1,
 =09=09=09=09(udev->config) ? "reset" : "new", speed,
 =09=09=09=09devnum, driver_name);
=20
+=09if (udev->config)
+=09=09post_usb_device_notification(udev, NOTIFY_USB_DEVICE_RESET, 0);
+
 =09/* Set up TT records, if needed  */
 =09if (hdev->tt) {
 =09=09udev->tt =3D hdev->tt;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index e656e7b4b1e4..93fa0666f95a 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -26,6 +26,7 @@
 struct usb_device;
 struct usb_driver;
 struct wusb_dev;
+enum usb_notification_type;
=20
 /*------------------------------------------------------------------------=
-*/
=20
@@ -2015,6 +2016,23 @@ extern void usb_led_activity(enum usb_led_event ev);
 static inline void usb_led_activity(enum usb_led_event ev) {}
 #endif
=20
+/*
+ * Notification functions.
+ */
+#ifdef CONFIG_USB_NOTIFICATIONS
+extern void post_usb_device_notification(const struct usb_device *udev,
+=09=09=09=09=09 enum usb_notification_type subtype,
+=09=09=09=09=09 u32 error);
+extern void post_usb_bus_notification(const struct usb_bus *ubus,
+=09=09=09=09      enum usb_notification_type subtype,
+=09=09=09=09      u32 error);
+#else
+static inline void post_usb_device_notification(const struct usb_device *u=
dev,
+=09=09=09=09=09=09unsigned int subtype, u32 error) {}
+static inline void post_usb_bus_notification(const struct usb_bus *ubus,
+=09=09=09=09=09     unsigned int subtype, u32 error) {}
+#endif
+
 #endif  /* __KERNEL__ */
=20
 #endif
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_qu=
eue.h
index 557771413242..ad1ae229674a 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -15,7 +15,8 @@ enum watch_notification_type {
 =09WATCH_TYPE_META=09=09=3D 0,=09/* Special record */
 =09WATCH_TYPE_KEY_NOTIFY=09=3D 1,=09/* Key change event notification */
 =09WATCH_TYPE_BLOCK_NOTIFY=09=3D 2,=09/* Block layer event notification */
-=09WATCH_TYPE__NR=09=09=3D 3
+=09WATCH_TYPE_USB_NOTIFY=09=3D 3,=09/* USB subsystem event notification */
+=09WATCH_TYPE__NR=09=09=3D 4
 };
=20
 enum watch_meta_notification_subtype {
@@ -129,4 +130,29 @@ struct block_notification {
 =09__u64=09sector;=09=09=09/* Affected sector */
 };
=20
+/*
+ * Type of USB layer notification.
+ */
+enum usb_notification_type {
+=09NOTIFY_USB_DEVICE_ADD=09=09=3D 0, /* USB device added */
+=09NOTIFY_USB_DEVICE_REMOVE=09=3D 1, /* USB device removed */
+=09NOTIFY_USB_DEVICE_RESET=09=09=3D 2, /* USB device reset */
+=09NOTIFY_USB_DEVICE_ERROR=09=09=3D 3, /* USB device error */
+};
+
+/*
+ * USB subsystem notification record.
+ * - watch.type =3D WATCH_TYPE_USB_NOTIFY
+ * - watch.subtype =3D enum usb_notification_type
+ */
+struct usb_notification {
+=09struct watch_notification watch; /* WATCH_TYPE_USB_NOTIFY */
+=09__u32=09error;
+=09__u32=09reserved;
+=09__u8=09name_len;=09=09/* Length of device name */
+=09__u8=09name[0];=09=09/* Device name (padded to __u64, truncated at 63 c=
hars) */
+};
+
+#define USB_NOTIFICATION_MAX_NAME_LEN 63
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_t=
est.c
index 55879531a7d5..37461295e825 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -84,6 +84,26 @@ static void saw_block_change(struct watch_notification *=
n, size_t len)
 =09       (unsigned long long)b->sector);
 }
=20
+static const char *usb_subtypes[256] =3D {
+=09[NOTIFY_USB_DEVICE_ADD]=09=09=3D "dev-add",
+=09[NOTIFY_USB_DEVICE_REMOVE]=09=3D "dev-remove",
+=09[NOTIFY_USB_DEVICE_RESET]=09=3D "dev-reset",
+=09[NOTIFY_USB_DEVICE_ERROR]=09=3D "dev-error",
+};
+
+static void saw_usb_event(struct watch_notification *n, size_t len)
+{
+=09struct usb_notification *u =3D (struct usb_notification *)n;
+
+=09if (len < sizeof(struct usb_notification))
+=09=09return;
+
+=09printf("USB %*.*s %s e=3D%x r=3D%x\n",
+=09       u->name_len, u->name_len, u->name,
+=09       usb_subtypes[n->subtype],
+=09       u->error, u->reserved);
+}
+
 /*
  * Consume and display events.
  */
@@ -160,6 +180,9 @@ static void consumer(int fd)
 =09=09=09case WATCH_TYPE_BLOCK_NOTIFY:
 =09=09=09=09saw_block_change(&n.n, len);
 =09=09=09=09break;
+=09=09=09case WATCH_TYPE_USB_NOTIFY:
+=09=09=09=09saw_usb_event(&n.n, len);
+=09=09=09=09break;
 =09=09=09default:
 =09=09=09=09printf("other type\n");
 =09=09=09=09break;
@@ -171,7 +194,7 @@ static void consumer(int fd)
 }
=20
 static struct watch_notification_filter filter =3D {
-=09.nr_filters=09=3D 2,
+=09.nr_filters=09=3D 3,
 =09.filters =3D {
 =09=09[0]=09=3D {
 =09=09=09.type=09=09=09=3D WATCH_TYPE_KEY_NOTIFY,
@@ -181,6 +204,10 @@ static struct watch_notification_filter filter =3D {
 =09=09=09.type=09=09=09=3D WATCH_TYPE_BLOCK_NOTIFY,
 =09=09=09.subtype_filter[0]=09=3D UINT_MAX,
 =09=09},
+=09=09[2]=09=3D {
+=09=09=09.type=09=09=09=3D WATCH_TYPE_USB_NOTIFY,
+=09=09=09.subtype_filter[0]=09=3D UINT_MAX,
+=09=09},
 =09},
 };
=20

