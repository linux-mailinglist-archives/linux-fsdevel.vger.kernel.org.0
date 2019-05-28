Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F4C2CB03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfE1QCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:02:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53581 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfE1QCp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:02:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42E6C6E772;
        Tue, 28 May 2019 16:02:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50D648082;
        Tue, 28 May 2019 16:02:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 6/7] block: Add block layer notifications
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 May 2019 17:02:39 +0100
Message-ID: <155905935953.7587.11815678364029606128.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 28 May 2019 16:02:45 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a block layer notification mechanism whereby notifications about
block-layer events such as I/O errors, can be reported to a monitoring
process asynchronously.

Firstly, an event queue needs to be created:

	fd = open("/dev/event_queue", O_RDWR);
	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, page_size << n);

then a notification can be set up to report block notifications via that
queue:

	struct watch_notification_filter filter = {
		.nr_filters = 1,
		.filters = {
			[0] = {
				.type = WATCH_TYPE_BLOCK_NOTIFY,
				.subtype_filter[0] = UINT_MAX;
			},
		},
	};
	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
	block_notify(fd, 12);

After that, records will be placed into the queue when, for example, errors
occur on a block device.  Records are of the following format:

	struct block_notification {
		struct watch_notification watch;
		__u64	dev;
		__u64	sector;
	} *n;

Where:

	n->watch.type will be WATCH_TYPE_BLOCK_NOTIFY

	n->watch.subtype will be the type of notification, such as
	NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM.

	n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
	record.

	n->watch.info & WATCH_INFO_ID will be the second argument to
	block_notify(), shifted.

	n->dev will be the device numbers munged together.

	n->sector will indicate the affected sector (if appropriate for the
	event).

Note that it is permissible for event records to be of variable length -
or, at least, the length may be dependent on the subtype.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 block/Kconfig                          |    9 +++
 block/Makefile                         |    1 
 block/blk-core.c                       |   28 +++++++++++
 block/blk-notify.c                     |   83 ++++++++++++++++++++++++++++++++
 include/linux/blkdev.h                 |   10 ++++
 include/linux/syscalls.h               |    1 
 include/uapi/linux/watch_queue.h       |   28 +++++++++++
 9 files changed, 162 insertions(+)
 create mode 100644 block/blk-notify.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 429416ce60e1..22793f77c5f1 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -441,3 +441,4 @@
 434	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
 435	i386	mount_notify		sys_mount_notify		__ia32_sys_mount_notify
 436	i386	sb_notify		sys_sb_notify			__ia32_sys_sb_notify
+437	i386	block_notify		sys_block_notify		__ia32_sys_block_notify
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 4ae146e472db..3f0b82272a9f 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -358,6 +358,7 @@
 434	common	fsinfo			__x64_sys_fsinfo
 435	common	mount_notify		__x64_sys_mount_notify
 436	common	sb_notify		__x64_sys_sb_notify
+437	common	block_notify		__x64_sys_block_notify
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/block/Kconfig b/block/Kconfig
index 1b220101a9cb..3b0a0ddb83ef 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -163,6 +163,15 @@ config BLK_SED_OPAL
 	Enabling this option enables users to setup/unlock/lock
 	Locking ranges for SED devices using the Opal protocol.
 
+config BLK_NOTIFICATIONS
+	bool "Block layer event notifications"
+	select WATCH_QUEUE
+	help
+	  This option provides support for getting block layer event
+	  notifications.  This makes use of the /dev/watch_queue misc device to
+	  handle the notification buffer and provides the block_notify() system
+	  call to enable/disable watches.
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/block/Makefile b/block/Makefile
index eee1b4ceecf9..2dca6273f8f3 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
+obj-$(CONFIG_BLK_NOTIFICATIONS)	+= blk-notify.o
diff --git a/block/blk-core.c b/block/blk-core.c
index 419d600e6637..8325e33f0bcc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -144,6 +144,21 @@ static const struct {
 	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
 };
 
+#ifdef CONFIG_BLK_NOTIFICATIONS
+static const enum block_notification_type blk_notifications[] = {
+	[BLK_STS_TIMEOUT]	= NOTIFY_BLOCK_ERROR_TIMEOUT,
+	[BLK_STS_NOSPC]		= NOTIFY_BLOCK_ERROR_NO_SPACE,
+	[BLK_STS_TRANSPORT]	= NOTIFY_BLOCK_ERROR_RECOVERABLE_TRANSPORT,
+	[BLK_STS_TARGET]	= NOTIFY_BLOCK_ERROR_CRITICAL_TARGET,
+	[BLK_STS_NEXUS]		= NOTIFY_BLOCK_ERROR_CRITICAL_NEXUS,
+	[BLK_STS_MEDIUM]	= NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM,
+	[BLK_STS_PROTECTION]	= NOTIFY_BLOCK_ERROR_PROTECTION,
+	[BLK_STS_RESOURCE]	= NOTIFY_BLOCK_ERROR_KERNEL_RESOURCE,
+	[BLK_STS_DEV_RESOURCE]	= NOTIFY_BLOCK_ERROR_DEVICE_RESOURCE,
+	[BLK_STS_IOERR]		= NOTIFY_BLOCK_ERROR_IO,
+};
+#endif
+
 blk_status_t errno_to_blk_status(int errno)
 {
 	int i;
@@ -179,6 +194,19 @@ static void print_req_error(struct request *req, blk_status_t status)
 				req->rq_disk ?  req->rq_disk->disk_name : "?",
 				(unsigned long long)blk_rq_pos(req),
 				req->cmd_flags);
+
+#ifdef CONFIG_BLK_NOTIFICATIONS
+	if (blk_notifications[idx]) {
+		struct block_notification n = {
+			.watch.type	= WATCH_TYPE_BLOCK_NOTIFY,
+			.watch.subtype	= blk_notifications[idx],
+			.watch.info	= sizeof(n),
+			.dev		= req->rq_disk ? disk_devt(req->rq_disk) : 0,
+			.sector		= blk_rq_pos(req),
+		};
+		post_block_notification(&n);
+	}
+#endif
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
diff --git a/block/blk-notify.c b/block/blk-notify.c
new file mode 100644
index 000000000000..b310aaf37e7c
--- /dev/null
+++ b/block/blk-notify.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Block layer event notifications.
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/blkdev.h>
+#include <linux/watch_queue.h>
+#include <linux/syscalls.h>
+#include <linux/init_task.h>
+
+/*
+ * Global queue for watching for block layer events.
+ */
+static struct watch_list blk_watchers = {
+	.watchers	= HLIST_HEAD_INIT,
+	.lock		= __SPIN_LOCK_UNLOCKED(&blk_watchers.lock),
+};
+
+static DEFINE_SPINLOCK(blk_watchers_lock);
+
+/*
+ * Post superblock notifications.
+ *
+ * Note that there's only a global queue to which all events are posted.  Might
+ * want to provide per-dev queues also.
+ */
+void post_block_notification(struct block_notification *n)
+{
+	u64 id = 0; /* Might want to allow dev# here. */
+
+	post_watch_notification(&blk_watchers, &n->watch, &init_cred, id);
+}
+
+/**
+ * sys_block_notify - Watch for superblock events.
+ * @watch_fd: The watch queue to send notifications to.
+ * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
+ */
+SYSCALL_DEFINE2(block_notify, int, watch_fd, int, watch_id)
+{
+	struct watch_queue *wqueue;
+	struct watch_list *wlist = &blk_watchers;
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
+		spin_lock(&blk_watchers_lock);
+		ret = add_watch_to_object(watch, wlist);
+		spin_unlock(&blk_watchers_lock);
+		if (ret < 0)
+			kfree(watch);
+	} else {
+		spin_lock(&blk_watchers_lock);
+		ret = remove_watch_from_object(wlist, wqueue, id, false);
+		spin_unlock(&blk_watchers_lock);
+	}
+
+err_wqueue:
+	put_watch_queue(wqueue);
+err:
+	return ret;
+}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1aafeb923e7b..c28f8647a76d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -43,6 +43,7 @@ struct pr_ops;
 struct rq_qos;
 struct blk_queue_stats;
 struct blk_stat_callback;
+struct block_notification;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
@@ -1744,6 +1745,15 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+#ifdef CONFIG_BLK_NOTIFICATIONS
+extern void post_block_notification(struct block_notification *n);
+#else
+static inline void post_block_notification(struct block_notification *n)
+{
+}
+#endif
+
+
 #else /* CONFIG_BLOCK */
 
 struct block_device;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 204a6dbcc34a..77a9d84f1fbd 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1005,6 +1005,7 @@ asmlinkage long sys_mount_notify(int dfd, const char __user *path,
 				 unsigned int at_flags, int watch_fd, int watch_id);
 asmlinkage long sys_sb_notify(int dfd, const char __user *path,
 			      unsigned int at_flags, int watch_fd, int watch_id);
+asmlinkage long sys_block_notify(int watch_fd, int watch_id);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 3b5770889bba..fad276ffa2d0 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -44,6 +44,7 @@ struct watch_notification {
 #define WATCH_INFO_FLAG_6	0x00400000
 #define WATCH_INFO_FLAG_7	0x00800000
 #define WATCH_INFO_ID		0xff000000	/* ID of watchpoint */
+#define WATCH_INFO_ID__SHIFT	24
 };
 
 #define WATCH_LENGTH_SHIFT	3
@@ -154,4 +155,31 @@ struct superblock_error_notification {
 	__u32	error_cookie;
 };
 
+/*
+ * Type of block layer notification.
+ */
+enum block_notification_type {
+	NOTIFY_BLOCK_ERROR_TIMEOUT		= 1, /* Timeout error */
+	NOTIFY_BLOCK_ERROR_NO_SPACE		= 2, /* Critical space allocation error */
+	NOTIFY_BLOCK_ERROR_RECOVERABLE_TRANSPORT = 3, /* Recoverable transport error */
+	NOTIFY_BLOCK_ERROR_CRITICAL_TARGET	= 4, /* Critical target error */
+	NOTIFY_BLOCK_ERROR_CRITICAL_NEXUS	= 5, /* Critical nexus error */
+	NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM	= 6, /* Critical medium error */
+	NOTIFY_BLOCK_ERROR_PROTECTION		= 7, /* Protection error */
+	NOTIFY_BLOCK_ERROR_KERNEL_RESOURCE	= 8, /* Kernel resource error */
+	NOTIFY_BLOCK_ERROR_DEVICE_RESOURCE	= 9, /* Device resource error */
+	NOTIFY_BLOCK_ERROR_IO			= 10, /* Other I/O error */
+};
+
+/*
+ * Block notification record.
+ * - watch.type = WATCH_TYPE_BLOCK_NOTIFY
+ * - watch.subtype = enum block_notification_type
+ */
+struct block_notification {
+	struct watch_notification watch; /* WATCH_TYPE_SB_NOTIFY */
+	__u64	dev;			/* Device number */
+	__u64	sector;			/* Affected sector */
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */

