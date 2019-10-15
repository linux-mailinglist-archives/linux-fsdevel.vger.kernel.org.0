Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D759D82F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbfJOVug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:50:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfJOVug (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:50:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B0493086218;
        Tue, 15 Oct 2019 21:50:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F20610027AB;
        Tue, 15 Oct 2019 21:50:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 18/21] block: Add block layer notifications
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
Date:   Tue, 15 Oct 2019 22:50:31 +0100
Message-ID: <157117623165.15019.7188193153962358526.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 15 Oct 2019 21:50:35 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a block layer notification mechanism whereby notifications about
block-layer events such as I/O errors, can be reported to a monitoring
process asynchronously.

Firstly, an event queue needs to be created:

	pipe2(fds, O_TMPFILE);
	ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);

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
	ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);
	watch_devices(fds[1], 12);

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
	watch_devices(), shifted.

	n->dev will be the device numbers munged together.

	n->sector will indicate the affected sector (if appropriate for the
	event).

Note that it is permissible for event records to be of variable length -
or, at least, the length may be dependent on the subtype.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/watch_queue.rst    |    4 +++-
 block/Kconfig                    |    9 +++++++++
 block/blk-core.c                 |   29 ++++++++++++++++++++++++++++
 include/linux/blkdev.h           |   15 ++++++++++++++
 include/uapi/linux/watch_queue.h |   30 ++++++++++++++++++++++++++++-
 samples/watch_queue/watch_test.c |   40 +++++++++++++++++++++++++++++++++++++-
 6 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index ed592700be0e..f2299f631ae8 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -8,7 +8,9 @@ opened by userspace.  This can be used in conjunction with::
 
   * Key/keyring notifications
 
-  * General device event notifications
+  * General device event notifications, including::
+
+    * Block layer event notifications
 
 
 The notifications buffers can be enabled by:
diff --git a/block/Kconfig b/block/Kconfig
index 41c0917ce622..0906227a9431 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -177,6 +177,15 @@ config BLK_SED_OPAL
 	Enabling this option enables users to setup/unlock/lock
 	Locking ranges for SED devices using the Opal protocol.
 
+config BLK_NOTIFICATIONS
+	bool "Block layer event notifications"
+	depends on DEVICE_NOTIFICATIONS
+	help
+	  This option provides support for getting block layer event
+	  notifications.  This makes use of the /dev/watch_queue misc device to
+	  handle the notification buffer and provides the device_notify() system
+	  call to enable/disable watches.
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/block/blk-core.c b/block/blk-core.c
index d5e668ec751b..08e9b12ff5a5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -184,6 +184,22 @@ static const struct {
 	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
 };
 
+#ifdef CONFIG_BLK_NOTIFICATIONS
+static const
+enum block_notification_type blk_notifications[ARRAY_SIZE(blk_errors)] = {
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
@@ -224,6 +240,19 @@ static void print_req_error(struct request *req, blk_status_t status,
 		req->cmd_flags & ~REQ_OP_MASK,
 		req->nr_phys_segments,
 		IOPRIO_PRIO_CLASS(req->ioprio));
+
+#ifdef CONFIG_BLK_NOTIFICATIONS
+	if (blk_notifications[idx]) {
+		struct block_notification n = {
+			.watch.type	= WATCH_TYPE_BLOCK_NOTIFY,
+			.watch.subtype	= blk_notifications[idx],
+			.watch.info	= watch_sizeof(n),
+			.dev		= req->rq_disk ? disk_devt(req->rq_disk) : 0,
+			.sector		= blk_rq_pos(req),
+		};
+		post_block_notification(&n);
+	}
+#endif
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f3ea78b0c91c..477472c11815 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -27,6 +27,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
+#include <linux/watch_queue.h>
 
 struct module;
 struct scsi_ioctl_command;
@@ -1773,6 +1774,20 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+#ifdef CONFIG_BLK_NOTIFICATIONS
+static inline void post_block_notification(struct block_notification *n)
+{
+	u64 id = 0; /* Might want to allow dev# here. */
+
+	post_device_notification(&n->watch, id);
+}
+#else
+static inline void post_block_notification(struct block_notification *n)
+{
+}
+#endif
+
+
 #else /* CONFIG_BLOCK */
 
 struct block_device;
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 14fee36ec000..65b127ca272b 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -11,7 +11,8 @@
 enum watch_notification_type {
 	WATCH_TYPE_META		= 0,	/* Special record */
 	WATCH_TYPE_KEY_NOTIFY	= 1,	/* Key change event notification */
-	WATCH_TYPE___NR		= 2
+	WATCH_TYPE_BLOCK_NOTIFY	= 2,	/* Block layer event notification */
+	WATCH_TYPE___NR		= 3
 };
 
 enum watch_meta_notification_subtype {
@@ -98,4 +99,31 @@ struct key_notification {
 	__u32	aux;		/* Per-type auxiliary data */
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
+ * Block layer notification record.
+ * - watch.type = WATCH_TYPE_BLOCK_NOTIFY
+ * - watch.subtype = enum block_notification_type
+ */
+struct block_notification {
+	struct watch_notification watch; /* WATCH_TYPE_BLOCK_NOTIFY */
+	__u64	dev;			/* Device number */
+	__u64	sector;			/* Affected sector */
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
index 1ffed42bfece..263dbba59651 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -59,6 +59,32 @@ static void saw_key_change(struct watch_notification *n, size_t len)
 	       k->key_id, n->subtype, key_subtypes[n->subtype], k->aux);
 }
 
+static const char *block_subtypes[256] = {
+	[NOTIFY_BLOCK_ERROR_TIMEOUT]			= "timeout",
+	[NOTIFY_BLOCK_ERROR_NO_SPACE]			= "critical space allocation",
+	[NOTIFY_BLOCK_ERROR_RECOVERABLE_TRANSPORT]	= "recoverable transport",
+	[NOTIFY_BLOCK_ERROR_CRITICAL_TARGET]		= "critical target",
+	[NOTIFY_BLOCK_ERROR_CRITICAL_NEXUS]		= "critical nexus",
+	[NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM]		= "critical medium",
+	[NOTIFY_BLOCK_ERROR_PROTECTION]			= "protection",
+	[NOTIFY_BLOCK_ERROR_KERNEL_RESOURCE]		= "kernel resource",
+	[NOTIFY_BLOCK_ERROR_DEVICE_RESOURCE]		= "device resource",
+	[NOTIFY_BLOCK_ERROR_IO]				= "I/O",
+};
+
+static void saw_block_change(struct watch_notification *n, size_t len)
+{
+	struct block_notification *b = (struct block_notification *)n;
+
+	if (len < sizeof(struct block_notification))
+		return;
+
+	printf("BLOCK %08llx e=%u[%s] s=%llx\n",
+	       (unsigned long long)b->dev,
+	       n->subtype, block_subtypes[n->subtype],
+	       (unsigned long long)b->sector);
+}
+
 /*
  * Consume and display events.
  */
@@ -132,6 +158,9 @@ static void consumer(int fd)
 			case WATCH_TYPE_KEY_NOTIFY:
 				saw_key_change(&n.n, len);
 				break;
+			case WATCH_TYPE_BLOCK_NOTIFY:
+				saw_block_change(&n.n, len);
+				break;
 			default:
 				printf("other type\n");
 				break;
@@ -143,12 +172,16 @@ static void consumer(int fd)
 }
 
 static struct watch_notification_filter filter = {
-	.nr_filters	= 1,
+	.nr_filters	= 2,
 	.filters = {
 		[0]	= {
 			.type			= WATCH_TYPE_KEY_NOTIFY,
 			.subtype_filter[0]	= UINT_MAX,
 		},
+		[1]	= {
+			.type			= WATCH_TYPE_BLOCK_NOTIFY,
+			.subtype_filter[0]	= UINT_MAX,
+		},
 	},
 };
 
@@ -182,6 +215,11 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (syscall(__NR_watch_devices, fd, 0x04, 0) == -1) {
+		perror("watch_devices");
+		exit(1);
+	}
+
 	consumer(fd);
 	exit(0);
 }

