Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D72C59FB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfF1Ptg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:49:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbfF1Ptf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:49:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93A5D59451;
        Fri, 28 Jun 2019 15:49:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A06D060BE0;
        Fri, 28 Jun 2019 15:49:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 6/9] Add a general,
 global device notification watch list [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:49:30 +0100
Message-ID: <156173697086.15137.9549379251509621554.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
References: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 28 Jun 2019 15:49:34 +0000 (UTC)
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

        watch_devices(fd, 12, 0);

Unless the application wants to receive all events, it should employ
appropriate filters.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/watch_queue.rst               |   22 ++++++-
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/ia64/kernel/syscalls/syscall.tbl       |    1 
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 
 arch/s390/kernel/syscalls/syscall.tbl       |    1 
 arch/sh/kernel/syscalls/syscall.tbl         |    1 
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 
 drivers/base/Kconfig                        |    9 +++
 drivers/base/Makefile                       |    1 
 drivers/base/watch.c                        |   90 +++++++++++++++++++++++++++
 include/linux/device.h                      |    7 ++
 include/linux/syscalls.h                    |    1 
 include/uapi/asm-generic/unistd.h           |    4 +
 kernel/sys_ni.c                             |    1 
 24 files changed, 149 insertions(+), 2 deletions(-)
 create mode 100644 drivers/base/watch.c

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index 6fb3aa3356d3..393905b904c8 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -276,6 +276,25 @@ The ``id`` is the ID of the source object (such as the serial number on a key).
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
 
@@ -291,7 +310,8 @@ Any particular buffer can be fed from multiple sources.  Sources include:
   * WATCH_TYPE_BLOCK_NOTIFY
 
     Notifications of this type indicate block layer events, such as I/O errors
-    or temporary link loss.  Watches of this type are set on a global queue.
+    or temporary link loss.  Watches of this type are set on the global device
+    watch list.
 
 
 Event Filtering
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 9e7704e44f6d..a3963f0434dc 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -473,3 +473,4 @@
 541	common	fsconfig			sys_fsconfig
 542	common	fsmount				sys_fsmount
 543	common	fspick				sys_fspick
+544	common	watch_devices			sys_watch_devices
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index aaf479a9e92d..af255f13c99b 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -447,3 +447,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	watch_devices			sys_watch_devices
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index e01df3f2f80d..7bb8ae23df85 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -354,3 +354,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	watch_devices			sys_watch_devices
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7e3d0734b2f3..631d760a3f9a 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -433,3 +433,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	watch_devices			sys_watch_devices
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 26339e417695..43442dab1720 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -439,3 +439,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	watch_devices			sys_watch_devices
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 0e2dd68ade57..d3b79b12a781 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -372,3 +372,4 @@
 431	n32	fsconfig			sys_fsconfig
 432	n32	fsmount				sys_fsmount
 433	n32	fspick				sys_fspick
+434	n32	watch_devices			sys_watch_devices
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 5eebfa0d155c..fd4886825ae9 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -348,3 +348,4 @@
 431	n64	fsconfig			sys_fsconfig
 432	n64	fsmount				sys_fsmount
 433	n64	fspick				sys_fspick
+434	n64	watch_devices			sys_watch_devices
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 3cc1374e02d0..9c47ba4a225c 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -421,3 +421,4 @@
 431	o32	fsconfig			sys_fsconfig
 432	o32	fsmount				sys_fsmount
 433	o32	fspick				sys_fspick
+434	o32	watch_devices			sys_watch_devices
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index c9e377d59232..3bf52203d272 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -430,3 +430,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	watch_devices			sys_watch_devices
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 103655d84b4b..2d2fc51a151f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -515,3 +515,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	watch_devices			sys_watch_devices
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index e822b2964a83..a7f13f3ff40c 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -436,3 +436,4 @@
 431  common	fsconfig		sys_fsconfig			sys_fsconfig
 432  common	fsmount			sys_fsmount			sys_fsmount
 433  common	fspick			sys_fspick			sys_fspick
+434	common	watch_devices		sys_watch_devices		sys_watch_devices
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 016a727d4357..54dd7f912148 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -436,3 +436,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	watch_devices			sys_watch_devices
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index e047480b1605..519c96cc6fec 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -479,3 +479,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	watch_devices			sys_watch_devices
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ad968b7bac72..75f92c016e3e 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
 432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
+434	i386	watch_devices		sys_watch_devices		__ia32_sys_watch_devices
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..76975ce78206 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+434	common	watch_devices		__x64_sys_watch_devices
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 5fa0ee1c8e00..fe726bbeb6e4 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -404,3 +404,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+434	common	watch_devices			sys_watch_devices
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
index 000000000000..00336607dc73
--- /dev/null
+++ b/drivers/base/watch.c
@@ -0,0 +1,90 @@
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
+ * @flags: Flags (reserved for future)
+ */
+SYSCALL_DEFINE3(watch_devices, int, watch_fd, int, watch_id, unsigned int, flags)
+{
+	struct watch_queue *wqueue;
+	struct watch_list *wlist = &device_watchers;
+	struct watch *watch;
+	long ret = -ENOMEM;
+	u64 id = 0; /* Might want to allow dev# here. */
+
+	if (watch_id < -1 || watch_id > 0xff || flags)
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
index e2870fe1be5b..abb5c8c3cd4b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -997,6 +997,7 @@ asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags)
 asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
+asmlinkage long sys_watch_devices(int watch_fd, int watch_id, unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a87904daf103..7477925e96ea 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_watch_devices 434
+__SYSCALL(__NR_watch_devices, sys_watch_devices)
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 435
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 4d9ae5ea6caf..b2fe8b2c1107 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -51,6 +51,7 @@ COND_SYSCALL_COMPAT(io_pgetevents);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);
+COND_SYSCALL(watch_devices);
 
 /* fs/xattr.c */
 

