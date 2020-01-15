Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8402A13C31C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgAONcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:32:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40877 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728915AbgAONcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579095134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVM6eXdk88xRL6/zruvqTxY6Ku4TU/zNN3dS21Q4rik=;
        b=H4U9N9Qty163c7mnKNXSqw35b4xD5rpO5idMFPUxvCBdNVgsA52ryq3FnEoJ1R76PF5RsF
        Mq5tOKjs5SoejSIfaOxmML6So2LMwCU3FLm3AGiUFR7m3KpamrErfeREukMxmFBjedQKgF
        nXPHeGyWY5L6jMBf2T/NjCRJxR1yOak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-fbE4bbILN_espE6FpnQx1g-1; Wed, 15 Jan 2020 08:32:10 -0500
X-MC-Unique: fbE4bbILN_espE6FpnQx1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF5238024D2;
        Wed, 15 Jan 2020 13:32:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B31D55C28D;
        Wed, 15 Jan 2020 13:32:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 10/14] Add a general,
 global device notification watch list [ver #3]
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
Date:   Wed, 15 Jan 2020 13:32:04 +0000
Message-ID: <157909512494.20155.2812648243716525260.stgit@warthog.procyon.org.uk>
In-Reply-To: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
References: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

        pipe2(fds, O_NOTIFICATION_PIPE);
        ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);

and then a watch can be placed upon it using a system call:

        watch_devices(fds[1], 12, 0);

Unless the application wants to receive all events, it should employ
appropriate filters.  For example, to receive just USB notifications, it
could do:

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

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/watch_queue.rst               |   22 ++++++-
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/arm64/include/asm/unistd.h             |    2 -
 arch/arm64/include/asm/unistd32.h           |    2 +
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
 26 files changed, 152 insertions(+), 3 deletions(-)
 create mode 100644 drivers/base/watch.c

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index d8f70282d247..ed592700be0e 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -223,6 +223,25 @@ The ``id`` is the ID of the source object (such as the serial number on a key).
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
 
@@ -238,7 +257,8 @@ Any particular buffer can be fed from multiple sources.  Sources include:
   * WATCH_TYPE_BLOCK_NOTIFY
 
     Notifications of this type indicate block layer events, such as I/O errors
-    or temporary link loss.  Watches of this type are set on a global queue.
+    or temporary link loss.  Watches of this type are set on the global device
+    watch list.
 
 
 Event Filtering
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 8e13b0b2928d..3b355b0996a1 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -475,3 +475,4 @@
 543	common	fspick				sys_fspick
 544	common	pidfd_open			sys_pidfd_open
 # 545 reserved for clone3
+546	common	watch_devices			sys_watch_devices
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 6da7dc4d79cc..0f080cf44cc9 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -449,3 +449,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3
+436	common	watch_devices			sys_watch_devices
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 2629a68b8724..368761302768 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		436
+#define __NR_compat_syscalls		437
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 94ab29cf4f00..b5310789ce7a 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -879,6 +879,8 @@ __SYSCALL(__NR_fspick, sys_fspick)
 __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
+#define __NR_watch_devices 436
+__SYSCALL(__NR_watch_devices, sys_watch_devices)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 36d5faf4c86c..2f33f5db2fed 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -356,3 +356,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+436	common	watch_devices			sys_watch_devices
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index a88a285a0e5f..83e4e8784b88 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -435,3 +435,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+436	common	watch_devices			sys_watch_devices
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 09b0cd7dab0a..9a70a3be3b7b 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3
+436	common	watch_devices			sys_watch_devices
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index e7c5ab38e403..b39527fc32c9 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -374,3 +374,4 @@
 433	n32	fspick				sys_fspick
 434	n32	pidfd_open			sys_pidfd_open
 435	n32	clone3				__sys_clone3
+436	n32	watch_devices			sys_watch_devices
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 13cd66581f3b..a7f0c5e71768 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -350,3 +350,4 @@
 433	n64	fspick				sys_fspick
 434	n64	pidfd_open			sys_pidfd_open
 435	n64	clone3				__sys_clone3
+436	n64	watch_devices			sys_watch_devices
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 353539ea4140..6f378288598c 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -423,3 +423,4 @@
 433	o32	fspick				sys_fspick
 434	o32	pidfd_open			sys_pidfd_open
 435	o32	clone3				__sys_clone3
+436	o32	watch_devices			sys_watch_devices
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 285ff516150c..b64bbafa5919 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -433,3 +433,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3_wrapper
+436	common	watch_devices			sys_watch_devices
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 43f736ed47f2..0a503239ab5c 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -517,3 +517,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	nospu	clone3				ppc_clone3
+436	common	watch_devices			sys_watch_devices
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 3054e9c035a3..19b43c0d928a 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 433  common	fspick			sys_fspick			sys_fspick
 434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
 435  common	clone3			sys_clone3			sys_clone3
+436  common	watch_devices		sys_watch_devices		sys_watch_devices
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index b5ed26c4c005..b454e07c9372 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+436	common	watch_devices			sys_watch_devices
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 8c8cc7537fb2..8ef43c27457e 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -481,3 +481,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+436	common	watch_devices			sys_watch_devices
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 15908eb9b17e..bdf7e845d1f8 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -440,3 +440,4 @@
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
 434	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
 435	i386	clone3			sys_clone3			__ia32_sys_clone3
+436	i386	watch_devices		sys_watch_devices		__ia32_sys_watch_devices
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c29976eca4a8..29293d103829 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -357,6 +357,7 @@
 433	common	fspick			__x64_sys_fspick
 434	common	pidfd_open		__x64_sys_pidfd_open
 435	common	clone3			__x64_sys_clone3/ptregs
+436	common	watch_devices		__x64_sys_watch_devices
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 25f4de729a6d..243fa18b8d1e 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -406,3 +406,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3
+436	common	watch_devices			sys_watch_devices
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index c3b3b5c0b0da..d4ae1c1adf69 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 menu "Generic Driver Options"
 
+config DEVICE_NOTIFICATIONS
+	bool "Provide device event notifications"
+	depends on WATCH_QUEUE
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
index 000000000000..725aaa24275b
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
+#include <linux/device.h>
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
+EXPORT_SYMBOL(post_device_notification);
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
+	struct watch *watch = NULL;
+	long ret = -ENOMEM;
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
+		watch->info_id = (u32)watch_id << WATCH_INFO_ID__SHIFT;
+
+		ret = security_watch_devices();
+		if (ret < 0)
+			goto err_watch;
+
+		spin_lock(&device_watchers_lock);
+		ret = add_watch_to_object(watch, &device_watchers);
+		spin_unlock(&device_watchers_lock);
+		if (ret == 0)
+			watch = NULL;
+	} else {
+		spin_lock(&device_watchers_lock);
+		ret = remove_watch_from_object(&device_watchers, wqueue, 0,
+					       false);
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
index 96ff76731e93..f32de6466092 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -43,6 +43,7 @@ struct iommu_group;
 struct iommu_fwspec;
 struct dev_pin_info;
 struct iommu_param;
+struct watch_notification;
 
 struct bus_attribute {
 	struct attribute	attr;
@@ -1687,6 +1688,12 @@ void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
 
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
index 2960dedcfde8..393661015a30 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1000,6 +1000,7 @@ asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags)
 asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
+asmlinkage long sys_watch_devices(int watch_fd, int watch_id, unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1fc8faa6e973..4794d3c2afd7 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -850,9 +850,11 @@ __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
 #endif
+#define __NR_watch_devices 436
+__SYSCALL(__NR_watch_devices, sys_watch_devices)
 
 #undef __NR_syscalls
-#define __NR_syscalls 436
+#define __NR_syscalls 437
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 3b69a560a7ac..0e9b275260f8 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -51,6 +51,7 @@ COND_SYSCALL_COMPAT(io_pgetevents);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);
+COND_SYSCALL(watch_devices);
 
 /* fs/xattr.c */
 

