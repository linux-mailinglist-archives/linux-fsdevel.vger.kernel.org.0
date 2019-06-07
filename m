Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F6038CBC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 16:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfFGOTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 10:19:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729571AbfFGOTE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:19:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 401E9F449F;
        Fri,  7 Jun 2019 14:18:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AE4B78566;
        Fri,  7 Jun 2019 14:18:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/13] Add a general,
 global device notification watch list [ver #4]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Jun 2019 15:18:56 +0100
Message-ID: <155991713667.15579.5847691136330923580.stgit@warthog.procyon.org.uk>
In-Reply-To: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 07 Jun 2019 14:19:04 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create a general, global watch list that can be used for the posting of
device notification events, for such things as device attachment,
detachment and errors on sources such as block devices and USB devices.
This can be enabled with:

	CONFIG_DEVICE_NOTIFICATIONS

To add a watch on this list, an event queue must be created and configured:

        fd = open("/dev/event_queue", O_RDWR);
        ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, page_size << n);

and then a watch can be placed upon it using a system call:

        watch_devices(fd, 12);

Unless the application wants to receive all events, it should employ
appropriate filters.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/watch_queue.rst          |   27 +++++++---
 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 drivers/base/Kconfig                   |    9 +++
 drivers/base/Makefile                  |    1 
 drivers/base/watch.c                   |   89 ++++++++++++++++++++++++++++++++
 include/linux/device.h                 |    7 +++
 include/linux/syscalls.h               |    1 
 include/linux/watch_queue.h            |    3 +
 kernel/sys_ni.c                        |    1 
 10 files changed, 133 insertions(+), 7 deletions(-)
 create mode 100644 drivers/base/watch.c

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index 0668c4a31710..e4b8233d5aa8 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -11,7 +11,7 @@ receive notifications from the kernel.  This can be used in conjunction with::
 
   * Superblock event notifications
 
-  * Block layer event notifications
+  * General device event notifications
 
 
 The notifications buffers can be enabled by:
@@ -292,6 +292,25 @@ The ``id`` is the ID of the source object (such as the serial number on a key).
 Only watches that have the same ID set in them will see this notification.
 
 
+Global Device Watch List
+========================
+
+There is a global watch list that hardware generated events, such as device
+connection, disconnection, failure and error can be posted upon.  It must be
+enabled using::
+
+	CONFIG_DEVICE_NOTIFICATIONS
+
+Watchpoints are set in userspace using the device_notify(2) system call.
+Within the kernel events are posted upon it using::
+
+	void post_device_notification(struct watch_notification *n, u64 id);
+
+where ``n`` is the formatted notification record to post.  ``id`` is an
+identifier that can be used to direct to specific watches, but it should be 0
+for general use on this queue.
+
+
 Watch Sources
 =============
 
@@ -317,12 +336,6 @@ Any particular buffer can be fed from multiple sources.  Sources include:
 
     See Documentation/security/keys/core.rst for more information.
 
-  * WATCH_TYPE_BLOCK_NOTIFY
-
-    Notifications of this type indicate block layer events, such as I/O errors
-    or temporary link loss.  Watchpoints of this type are set on a global
-    queue.
-
 
 Event Filtering
 ===============
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ef6035f71db4..5e69653cde96 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -441,3 +441,4 @@
 434	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
 435	i386	watch_mount		sys_watch_mount			__ia32_sys_watch_mount
 436	i386	watch_sb		sys_watch_sb			__ia32_sys_watch_sb
+437	i386	watch_devices		sys_watch_devices		__ia32_sys_watch_devices
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 072f5dbac6a3..19afaecef042 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -358,6 +358,7 @@
 434	common	fsinfo			__x64_sys_fsinfo
 435	common	watch_mount		__x64_sys_watch_mount
 436	common	watch_sb		__x64_sys_watch_sb
+437	common	watch_devices		__x64_sys_watch_devices
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index dc404492381d..63db34efb23b 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 menu "Generic Driver Options"
 
+config DEVICE_NOTIFICATIONS
+	bool "Provide device event notifications"
+	select WATCH_QUEUE
+	help
+	  This option provides support for getting hardware event notifications
+	  on devices, buses and interfaces.  This makes use of the
+	  /dev/watch_queue misc device to handle the notification buffer.
+	  device_notify(2) is used to set/remove watches.
+
 config UEVENT_HELPER
 	bool "Support for uevent helper"
 	help
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 157452080f3d..4db2e8f1a1f4 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -7,6 +7,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   attribute_container.o transport_class.o \
 			   topology.o container.o property.o cacheinfo.o \
 			   devcon.o swnode.o
+obj-$(CONFIG_DEVICE_NOTIFICATIONS) += watch.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-y			+= power/
 obj-$(CONFIG_ISA_BUS_API)	+= isa.o
diff --git a/drivers/base/watch.c b/drivers/base/watch.c
new file mode 100644
index 000000000000..af89eca12097
--- /dev/null
+++ b/drivers/base/watch.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Event notifications.
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/watch_queue.h>
+#include <linux/syscalls.h>
+#include <linux/init_task.h>
+#include <linux/security.h>
+
+/*
+ * Global queue for watching for device layer events.
+ */
+static struct watch_list device_watchers = {
+	.watchers	= HLIST_HEAD_INIT,
+	.lock		= __SPIN_LOCK_UNLOCKED(&device_watchers.lock),
+};
+
+static DEFINE_SPINLOCK(device_watchers_lock);
+
+/**
+ * post_device_notification - Post notification of a device event
+ * @n - The notification to post
+ * @id - The device ID
+ *
+ * Note that there's only a global queue to which all events are posted.  Might
+ * want to provide per-dev queues also.
+ */
+void post_device_notification(struct watch_notification *n, u64 id)
+{
+	post_watch_notification(&device_watchers, n, &init_cred, id);
+}
+
+/**
+ * sys_watch_devices - Watch for device events.
+ * @watch_fd: The watch queue to send notifications to.
+ * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
+ */
+SYSCALL_DEFINE2(watch_devices, int, watch_fd, int, watch_id)
+{
+	struct watch_queue *wqueue;
+	struct watch_list *wlist = &device_watchers;
+	struct watch *watch;
+	long ret = -ENOMEM;
+	u64 id = 0; /* Might want to allow dev# here. */
+
+	if (watch_id < -1 || watch_id > 0xff)
+		return -EINVAL;
+
+	wqueue = get_watch_queue(watch_fd);
+	if (IS_ERR(wqueue)) {
+		ret = PTR_ERR(wqueue);
+		goto err;
+	}
+
+	if (watch_id >= 0) {
+		watch = kzalloc(sizeof(*watch), GFP_KERNEL);
+		if (!watch)
+			goto err_wqueue;
+
+		init_watch(watch, wqueue);
+		watch->id	= id;
+		watch->info_id	= (u32)watch_id << WATCH_INFO_ID__SHIFT;
+
+		ret = security_watch_devices(watch);
+		if (ret < 0)
+			goto err_watch;
+
+		spin_lock(&device_watchers_lock);
+		ret = add_watch_to_object(watch, wlist);
+		spin_unlock(&device_watchers_lock);
+		if (ret == 0)
+			watch = NULL;
+	} else {
+		spin_lock(&device_watchers_lock);
+		ret = remove_watch_from_object(wlist, wqueue, id, false);
+		spin_unlock(&device_watchers_lock);
+	}
+
+err_watch:
+	kfree(watch);
+err_wqueue:
+	put_watch_queue(wqueue);
+err:
+	return ret;
+}
diff --git a/include/linux/device.h b/include/linux/device.h
index e85264fb6616..c947c078b1be 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -26,6 +26,7 @@
 #include <linux/uidgid.h>
 #include <linux/gfp.h>
 #include <linux/overflow.h>
+#include <linux/watch_queue.h>
 #include <asm/device.h>
 
 struct device;
@@ -1396,6 +1397,12 @@ struct device_link *device_link_add(struct device *consumer,
 void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
 
+#ifdef CONFIG_DEVICE_NOTIFICATIONS
+extern void post_device_notification(struct watch_notification *n, u64 id);
+#else
+static inline void post_device_notification(struct watch_notification *n, u64 id) {}
+#endif
+
 #ifndef dev_fmt
 #define dev_fmt(fmt) fmt
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 308141bc3f69..470028aef886 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1005,6 +1005,7 @@ asmlinkage long sys_watch_mount(int dfd, const char __user *path,
 				unsigned int at_flags, int watch_fd, int watch_id);
 asmlinkage long sys_watch_sb(int dfd, const char __user *path,
 			     unsigned int at_flags, int watch_fd, int watch_id);
+asmlinkage long sys_watch_devices(int watch_fd, int watch_id, unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 91777119db5e..8a5d586dfdf8 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -12,10 +12,12 @@
 
 #include <uapi/linux/watch_queue.h>
 #include <linux/kref.h>
+#include <linux/rcupdate.h>
 
 #ifdef CONFIG_WATCH_QUEUE
 
 struct watch_queue;
+struct cred;
 
 /*
  * Representation of a watch on an object.
@@ -53,6 +55,7 @@ extern void put_watch_queue(struct watch_queue *);
 extern void init_watch(struct watch *, struct watch_queue *);
 extern int add_watch_to_object(struct watch *, struct watch_list *);
 extern int remove_watch_from_object(struct watch_list *, struct watch_queue *, u64, bool);
+extern void post_device_notification(struct watch_notification *, u64);
 
 static inline void init_watch_list(struct watch_list *wlist,
 				   void (*release_watch)(struct watch *))
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 565d1e3d1bed..580374089f8d 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -51,6 +51,7 @@ COND_SYSCALL_COMPAT(io_pgetevents);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);
+COND_SYSCALL(device_notify);
 
 /* fs/xattr.c */
 

