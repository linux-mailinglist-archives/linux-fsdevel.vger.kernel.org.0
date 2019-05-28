Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8692C9B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfE1PKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:10:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfE1PKg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:10:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C835C30C1208;
        Tue, 28 May 2019 15:10:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E712C611B4;
        Tue, 28 May 2019 15:10:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/7] General notification queue with user mmap()'able ring
 buffer [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:10:29 +0100
Message-ID: <155905622921.1304.8775688192987027250.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905621951.1304.5956310120238620025.stgit@warthog.procyon.org.uk>
References: <155905621951.1304.5956310120238620025.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 28 May 2019 15:10:35 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a misc device that implements a general notification queue as a
ring buffer that can be mmap()'d from userspace.

The way this is done is:

 (1) An application opens the device and indicates the size of the ring
     buffer that it wants to reserve in pages (this can only be set once):

	fd = open("/dev/watch_queue", O_RDWR);
	ioctl(fd, IOC_WATCH_QUEUE_NR_PAGES, nr_of_pages);

 (2) The application should then map the pages that the device has
     reserved.  Each instance of the device created by open() allocates
     separate pages so that maps of different fds don't interfere with one
     another.  Multiple mmap() calls on the same fd, however, will all work
     together.

	page_size = sysconf(_SC_PAGESIZE);
	mapping_size = nr_of_pages * page_size;
	char *buf = mmap(NULL, mapping_size, PROT_READ|PROT_WRITE,
			 MAP_SHARED, fd, 0);

The ring is divided into 8-byte slots.  Entries written into the ring are
variable size and can use between 1 and 63 slots.  A special entry is
maintained in the first two slots of the ring that contains the head and
tail pointers.  This is skipped when the ring wraps round.  Note that
multislot entries, therefore, aren't allowed to be broken over the end of
the ring, but instead "skip" entries are inserted to pad out the buffer.

Each entry has a 1-slot header that describes it:

	struct watch_notification {
		__u32	type:24;
		__u32	subtype:8;
		__u32	info;
	};

The type indicates the source (eg. mount tree changes, superblock events,
keyring changes, block layer events) and the subtype indicates the event
type (eg. mount, unmount; EIO, EDQUOT; link, unlink).  The info field
indicates a number of things, including the entry length, an ID assigned to
a watchpoint contributing to this buffer, type-specific flags and meta
flags, such as an overrun indicator.

Supplementary data, such as the key ID that generated an event, are
attached in additional slots.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/watch_queue.rst    |  311 +++++++++++++
 drivers/misc/Kconfig             |   13 +
 drivers/misc/Makefile            |    1 
 drivers/misc/watch_queue.c       |  877 ++++++++++++++++++++++++++++++++++++++
 include/linux/lsm_hooks.h        |   15 +
 include/linux/security.h         |   14 +
 include/linux/watch_queue.h      |   86 ++++
 include/uapi/linux/watch_queue.h |   82 ++++
 mm/interval_tree.c               |    2 
 mm/memory.c                      |    1 
 security/security.c              |    9 
 11 files changed, 1411 insertions(+)
 create mode 100644 Documentation/watch_queue.rst
 create mode 100644 drivers/misc/watch_queue.c
 create mode 100644 include/linux/watch_queue.h
 create mode 100644 include/uapi/linux/watch_queue.h

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
new file mode 100644
index 000000000000..01fe937092d6
--- /dev/null
+++ b/Documentation/watch_queue.rst
@@ -0,0 +1,311 @@
+============================
+Mappable notifications queue
+============================
+
+This is a misc device that acts as a mapped ring buffer by which userspace can
+receive notifications from the kernel.  This is can be used in conjunction
+with::
+
+  * Key/keyring notifications
+
+  * Mount topology change notifications
+
+  * Superblock event notifications
+
+
+The notifications buffers can be enabled by:
+
+	"Device Drivers"/"Misc devices"/"Mappable notification queue"
+	(CONFIG_WATCH_QUEUE)
+
+This document has the following sections:
+
+.. contents:: :local:
+
+
+Overview
+========
+
+This facility appears as a misc device file that is opened and then mapped and
+polled.  Each time it is opened, it creates a new buffer specific to the
+returned file descriptor.  Then, when the opening process sets watches, it
+indicates that particular buffer it wants notifications from that watch to be
+written into.  Note that there are no read() and write() methods (except for
+debugging).  The user is expected to access the ring directly and to use poll
+to wait for new data.
+
+If a watch is in place, notifications are only written into the buffer if the
+filter criteria are passed and if there's sufficient space available in the
+ring.  If neither of those is so, a notification will be discarded.  In the
+latter case, an overrun indicator will also be set.
+
+Note that when producing a notification, the kernel does not wait for the
+consumers to collect it, but rather just continues on.  This means that
+notifications can be generated whilst spinlocks are held and also protects the
+kernel from being held up indefinitely by a userspace malfunction.
+
+As far as the ring goes, the head index belongs to the kernel and the tail
+index belongs to userspace.  The kernel will refuse to write anything if the
+tail index becomes invalid.  Userspace *must* use appropriate memory barriers
+between reading or updating the tail index and reading the ring.
+
+
+Record Structure
+================
+
+Notification records in the ring may occupy a variable number of slots within
+the buffer, beginning with a 1-slot header::
+
+	struct watch_notification {
+		__u16	type;
+		__u16	subtype;
+		__u32	info;
+	};
+
+"type" indicates the source of the notification record and "subtype" indicates
+the type of record from that source (see the Watch Sources section below).  The
+type may also be "WATCH_TYPE_META".  This is a special record type generated
+internally by the watch queue driver itself.  There are two subtypes, one of
+which indicates records that should be just skipped (padding or metadata):
+
+    * WATCH_META_SKIP_NOTIFICATION
+    * WATCH_META_REMOVAL_NOTIFICATION
+
+The former indicates a record that should just be skipped and the latter
+indicates that an object on which a watchpoint was installed was removed or
+destroyed.
+
+"info" indicates a bunch of things, including:
+
+  * The length of the record (mask with WATCH_INFO_LENGTH).  This indicates the
+    size of the record, which may be between 1 and 63 slots.  Note that this is
+    placed appropriately within the info value so that no shifting is required
+    to convert number of occupied slots to byte length.
+
+  * The watchpoint ID (mask with WATCH_INFO_ID).  This indicates that caller's
+    ID of the watchpoint, which may be between 0 and 255.  Multiple watchpoints
+    may share a queue, and this provides a means to distinguish them.
+
+  * A buffer overrun flag (WATCH_INFO_OVERRUN flag).  If this is set in a
+    notification record, some of the preceding records were discarded.
+
+  * An ENOMEM-loss flag (WATCH_INFO_ENOMEM flag).  This is set to indicate that
+    an event was lost to ENOMEM.
+
+  * A recursive-change flag (WATCH_INFO_RECURSIVE flag).  This is set to
+    indicate that the change that happened was recursive - for instance
+    changing the attributes on an entire mount subtree.
+
+  * An exact-match flag (WATCH_INFO_IN_SUBTREE flag).  This is set if the event
+    didn't happen exactly at the watchpoint, but rather somewhere in the
+    subtree thereunder.
+
+  * Some type-specific flags (WATCH_INFO_TYPE_FLAGS).  These are set by the
+    notification producer to indicate some meaning to the kernel.
+
+Everything in info apart from the length can be used for filtering.
+
+
+Ring Structure
+==============
+
+The ring is divided into 8-byte slots.  The caller uses an ioctl() to set the
+size of the ring after opening and this must be a power-of-2 multiple of the
+system page size (so that the mask can be used with AND).
+
+The head and tail indices are stored in the first two slots in the ring, which
+are marked out as a skippable entry::
+
+	struct watch_queue_buffer {
+		union {
+			struct {
+				struct watch_notification watch;
+				volatile __u32	head;
+				volatile __u32	tail;
+				__u32		mask;
+			} meta;
+			struct watch_notification slots[0];
+		};
+	};
+
+In "meta.watch", type will be set to WATCH_TYPE_META and subtype to
+WATCH_META_SKIP_NOTIFICATION so that anyone processing the buffer will just
+skip this record.  Also, because this record is here, records cannot wrap round
+the end of the buffer, so a skippable padding element will be inserted at the
+end of the buffer if needed.  Thus the contents of a notification record in the
+buffer are always contiguous.
+
+"meta.mask" is an AND'able mask to turn the index counters into slots array
+indices.
+
+The buffer is empty if "meta.head" == "meta.tail".
+
+[!] NOTE that the ring indices "meta.head" and "meta.tail" are indices into
+"slots[]" not byte offsets into the buffer.
+
+[!] NOTE that userspace must never change the head pointer.  This belongs to
+the kernel and will be updated by that.  The kernel will never change the tail
+pointer.
+
+[!] NOTE that userspace must never AND-off the tail pointer before updating it,
+but should just keep adding to it and letting it wrap naturally.  The value
+*should* be masked off when used as an index into slots[].
+
+[!] NOTE that if the distance between head and tail becomes too great, the
+kernel will assume the buffer is full and write no more until the issue is
+resolved.
+
+
+Watch Sources
+=============
+
+Any particular buffer can be fed from multiple sources.  Sources include:
+
+  * WATCH_TYPE_MOUNT_NOTIFY
+
+    Notifications of this type indicate mount tree topology changes and mount
+    attribute changes.  A watchpoint can be set on a particular file or
+    directory and notifications from the path subtree rooted at that point will
+    be intercepted.
+
+  * WATCH_TYPE_SB_NOTIFY
+
+    Notifications of this type indicate superblock events, such as quota limits
+    being hit, I/O errors being produced or network server loss/reconnection.
+    Watchpoints of this type are set directly on superblocks.
+
+  * WATCH_TYPE_KEY_NOTIFY
+
+    Notifications of this type indicate changes to keys and keyrings, including
+    the changes of keyring contents or the attributes of keys.
+
+    See Documentation/security/keys/core.rst for more information.
+
+  * WATCH_TYPE_BLOCK_NOTIFY
+
+    Notifications of this type indicate block layer events, such as I/O errors
+    or temporary link loss.  Watchpoints of this type are set on a global
+    queue.
+
+
+Configuring Watchpoints
+=======================
+
+When a watchpoint is set up, the caller assigns an ID and can set filtering
+parameters.  The following structure is filled out and passed to the
+watchpoint creation system call::
+
+	struct watch_notification_filter {
+		__u64	subtype_filter[4];
+		__u32	info_filter;
+		__u32	info_mask;
+		__u32	info_id;
+		__u32	__reserved;
+	};
+
+"subtype_filter" is a bitmask indicating the subtypes that are of interest.  In
+this version of the structure, only the first 256 subtypes are supported.  Bit
+0 of subtype_filter[0] corresponds to subtype 0, bit 1 to subtype 1, and so on.
+
+"info_filter" and "info_mask" act as a filter on the info field of the
+notification record.  The notification is only written into the buffer if::
+
+	(watch.info & info_mask) == info_filter
+
+This can be used, for example, to ignore events that are not exactly on the
+watched point in a mount tree by specifying WATCH_INFO_IN_SUBTREE must be 0.
+
+"info_id" is OR'd into watch.info.  This indicates the watchpoint ID in the top
+8 bits.  All bits outside of WATCH_INFO_ID must be 0.
+
+"__reserved" must be 0.
+
+If the pointer to this structure is NULL, this indicates to the system call
+that the watchpoint should be removed.
+
+
+Polling
+=======
+
+The file descriptor that holds the buffer may be used with poll() and similar.
+POLLIN and POLLRDNORM are set if the buffer indices differ.  POLLERR is set if
+the buffer indices are further apart than the size of the buffer.  Wake-up
+events are only generated if the buffer is transitioned from an empty state.
+
+
+Example
+=======
+
+A buffer is created with something like the following::
+
+	fd = open("/dev/watch_queue", O_RDWR);
+
+	#define BUF_SIZE 4
+	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
+
+	page_size = sysconf(_SC_PAGESIZE);
+	buf = mmap(NULL, BUF_SIZE * page_size,
+		   PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+It can then be set to receive mount topology change notifications, keyring
+change notifications and superblock notifications::
+
+	memset(&filter, 0, sizeof(filter));
+	filter.subtype_filter[0] = ~0ULL;
+	filter.info_mask	 = WATCH_INFO_IN_SUBTREE;
+	filter.info_filter	 = 0;
+	filter.info_id		 = 0x01000000;
+
+	keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, &filter);
+
+	mount_notify(AT_FDCWD, "/", 0, fd, &filter);
+
+	sb_notify(AT_FDCWD, "/", 0, fd, &filter);
+
+The notifications can then be consumed by something like the following::
+
+	extern void saw_mount_change(struct watch_notification *n);
+	extern void saw_key_change(struct watch_notification *n);
+
+	static int consumer(int fd, struct watch_queue_buffer *buf)
+	{
+		struct watch_notification *n;
+		struct pollfd p[1];
+		unsigned int head, tail, mask = buf->meta.mask;
+
+		for (;;) {
+			p[0].fd = fd;
+			p[0].events = POLLIN | POLLERR;
+			p[0].revents = 0;
+
+			if (poll(p, 1, -1) == -1 || p[0].revents & POLLERR)
+				goto went_wrong;
+
+			while (head = _atomic_load_acquire(buf->meta.head),
+			       tail = buf->meta.tail,
+			       tail != head
+			       ) {
+				n = &buf->slots[tail & mask];
+				if ((n->info & WATCH_INFO_LENGTH) == 0)
+					goto went_wrong;
+
+				switch (n->type) {
+				case WATCH_TYPE_MOUNT_NOTIFY:
+					saw_mount_change(n);
+					break;
+				case WATCH_TYPE_KEY_NOTIFY:
+					saw_key_change(n);
+					break;
+				}
+
+				tail += (n->info & WATCH_INFO_LENGTH) >> WATCH_LENGTH_SHIFT;
+				_atomic_store_release(buf->meta.tail, tail);
+			}
+		}
+
+	went_wrong:
+		return 0;
+	}
+
+Note the memory barriers when loading the head pointer and storing the tail
+pointer!
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6a0365b2332c..19668c0ebe03 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -4,6 +4,19 @@
 
 menu "Misc devices"
 
+config WATCH_QUEUE
+	bool "Mappable notification queue"
+	default n
+	depends on MMU
+	help
+	  This is a general notification queue for the kernel to pass events to
+	  userspace through a mmap()'able ring buffer.  It can be used in
+	  conjunction with watches for mount topology change notifications,
+	  superblock change notifications and key/keyring change notifications.
+
+	  Note that in theory this should work fine with NOMMU, but I'm not
+	  sure how to make that work.
+
 config SENSORS_LIS3LV02D
 	tristate
 	depends on INPUT
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b9affcdaa3d6..bf16acd9f8cc 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -3,6 +3,7 @@
 # Makefile for misc devices that really don't fit anywhere else.
 #
 
+obj-$(CONFIG_WATCH_QUEUE)	+= watch_queue.o
 obj-$(CONFIG_IBM_ASM)		+= ibmasm/
 obj-$(CONFIG_IBMVMC)		+= ibmvmc.o
 obj-$(CONFIG_AD525X_DPOT)	+= ad525x_dpot.o
diff --git a/drivers/misc/watch_queue.c b/drivers/misc/watch_queue.c
new file mode 100644
index 000000000000..39a09ea15d97
--- /dev/null
+++ b/drivers/misc/watch_queue.c
@@ -0,0 +1,877 @@
+/* User-mappable watch queue
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ *
+ * See Documentation/watch_queue.rst
+ */
+
+#define pr_fmt(fmt) "watchq: " fmt
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/printk.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/poll.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+#include <linux/file.h>
+#include <linux/security.h>
+#include <linux/cred.h>
+#include <linux/watch_queue.h>
+
+#define DEBUG_WITH_WRITE /* Allow use of write() to record notifications */
+
+MODULE_DESCRIPTION("Watch queue");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+struct watch_type_filter {
+	enum watch_notification_type type;
+	__u32		subtype_filter[1];	/* Bitmask of subtypes to filter on */
+	__u32		info_filter;		/* Filter on watch_notification::info */
+	__u32		info_mask;		/* Mask of relevant bits in info_filter */
+};
+
+struct watch_filter {
+	union {
+		struct rcu_head	rcu;
+		unsigned long	type_filter[2];	/* Bitmask of accepted types */
+	};
+	u32		nr_filters;		/* Number of filters */
+	struct watch_type_filter filters[];
+};
+
+struct watch_queue {
+	struct rcu_head		rcu;
+	struct address_space	mapping;
+	const struct cred	*cred;		/* Creds of the owner of the queue */
+	struct watch_filter __rcu *filter;
+	wait_queue_head_t	waiters;
+	struct hlist_head	watches;	/* Contributory watches */
+	refcount_t		usage;
+	spinlock_t		lock;
+	bool			defunct;	/* T when queues closed */
+	u8			nr_pages;	/* Size of pages[] */
+	u8			flag_next;	/* Flag to apply to next item */
+#ifdef DEBUG_WITH_WRITE
+	u8			debug;
+#endif
+	u32			size;
+	struct watch_queue_buffer *buffer;	/* Pointer to first record */
+
+	/* The mappable pages.  The zeroth page holds the ring pointers. */
+	struct page		**pages;
+};
+
+/**
+ * post_one_notification - Post an event notification to one queue
+ * @wqueue: The watch queue to add the event to.
+ * @n: The notification record to post.
+ * @cred: The credentials to use in security checks.
+ *
+ * Post a notification of an event into an mmap'd queue and let the user know.
+ * Returns true if successful and false on failure (eg. buffer overrun or
+ * userspace mucked up the ring indices).
+ *
+ *
+ * The size of the notification should be set in n->flags & WATCH_LENGTH and
+ * should be in units of sizeof(*n).
+ */
+static bool post_one_notification(struct watch_queue *wqueue,
+				  struct watch_notification *n,
+				  const struct cred *cred)
+{
+	struct watch_queue_buffer *buf = wqueue->buffer;
+	unsigned int metalen = sizeof(buf->meta) / sizeof(buf->slots[0]);
+	unsigned int size = wqueue->size, mask = size - 1;
+	unsigned int len;
+	unsigned int ring_tail, tail, head, used, segment, h;
+
+	if (!buf)
+		return false;
+
+	len = (n->info & WATCH_INFO_LENGTH) >> WATCH_LENGTH_SHIFT;
+	if (len == 0)
+		return false;
+
+	spin_lock_bh(&wqueue->lock); /* Protect head pointer */
+
+	if (wqueue->defunct ||
+	    security_post_notification(wqueue->cred, cred, n) < 0)
+		goto out;
+
+	ring_tail = READ_ONCE(buf->meta.tail);
+	head = READ_ONCE(buf->meta.head);
+	used = head - ring_tail;
+
+	/* Check to see if userspace mucked up the pointers */
+	if (used >= size)
+		goto overrun;
+	tail = ring_tail & mask;
+	if (tail > 0 && tail < metalen)
+		goto overrun;
+
+	h = head & mask;
+	if (h >= tail) {
+		/* Head is at or after tail in the buffer.  There may then be
+		 * two segments: one to the end of buffer and one at the
+		 * beginning of the buffer between the metadata block and the
+		 * tail pointer.
+		 */
+		segment = size - h;
+		if (len > segment) {
+			/* Not enough space in the post-head segment; we need
+			 * to wrap.  When wrapping, we will have to skip the
+			 * metadata at the beginning of the buffer.
+			 */
+			if (len > tail - metalen)
+				goto overrun;
+
+			/* Fill the space at the end of the page */
+			buf->slots[h].type	= WATCH_TYPE_META;
+			buf->slots[h].subtype	= WATCH_META_SKIP_NOTIFICATION;
+			buf->slots[h].info	= segment << WATCH_LENGTH_SHIFT;
+			head += segment;
+			h = 0;
+			if (h >= tail)
+				goto overrun;
+		}
+	}
+
+	if (h == 0) {
+		/* Reset and skip the header metadata */
+		buf->meta.watch.type = WATCH_TYPE_META;
+		buf->meta.watch.subtype = WATCH_META_SKIP_NOTIFICATION;
+		buf->meta.watch.info = metalen << WATCH_LENGTH_SHIFT;
+		head += metalen;
+		h = metalen;
+		if (h >= tail)
+			goto overrun;
+	}
+
+	if (h < tail) {
+		/* Head is before tail in the buffer.  There may be one segment
+		 * between the two, but we may need to skip the metadata block.
+		 */
+		segment = tail - h;
+		if (len > segment)
+			goto overrun;
+	}
+
+	n->info |= wqueue->flag_next;
+	wqueue->flag_next = 0;
+	memcpy(buf->slots + h, n, len * sizeof(buf->slots[0]));
+	head += len;
+
+	smp_store_release(&buf->meta.head, head);
+	spin_unlock_bh(&wqueue->lock);
+	if (used == 0)
+		wake_up(&wqueue->waiters);
+	return true;
+
+overrun:
+	wqueue->flag_next = WATCH_INFO_OVERRUN;
+out:
+	spin_unlock_bh(&wqueue->lock);
+	return false;
+}
+
+/*
+ * Apply filter rules to a notification.
+ */
+static bool filter_watch_notification(const struct watch_filter *wf,
+				      const struct watch_notification *n)
+{
+	const struct watch_type_filter *wt;
+	int i;
+
+	if (!test_bit(n->type, wf->type_filter))
+		return false;
+
+	for (i = 0; i < wf->nr_filters; i++) {
+		wt = &wf->filters[i];
+		if (n->type == wt->type &&
+		    ((1U << n->subtype) & wt->subtype_filter[0]) &&
+		    (n->info & wt->info_mask) == wt->info_filter)
+			return true;
+	}
+
+	return false; /* If there is a filter, the default is to reject. */
+}
+
+/**
+ * __post_watch_notification - Post an event notification
+ * @wlist: The watch list to post the event to.
+ * @n: The notification record to post.
+ * @cred: The creds of the process that triggered the notification.
+ * @id: The ID to match on the watch.
+ *
+ * Post a notification of an event into a set of watch queues and let the users
+ * know.
+ *
+ * If @n is NULL then WATCH_INFO_LENGTH will be set on the next event posted.
+ *
+ * The size of the notification should be set in n->info & WATCH_INFO_LENGTH and
+ * should be in units of sizeof(*n).
+ */
+void __post_watch_notification(struct watch_list *wlist,
+			       struct watch_notification *n,
+			       const struct cred *cred,
+			       u64 id)
+{
+	const struct watch_filter *wf;
+	struct watch_queue *wqueue;
+	struct watch *watch;
+
+	rcu_read_lock();
+
+	hlist_for_each_entry_rcu(watch, &wlist->watchers, list_node) {
+		if (watch->id != id)
+			continue;
+		n->info &= ~(WATCH_INFO_ID | WATCH_INFO_OVERRUN);
+		n->info |= watch->info_id;
+
+		wqueue = rcu_dereference(watch->queue);
+		wf = rcu_dereference(wqueue->filter);
+		if (wf && !filter_watch_notification(wf, n))
+			continue;
+
+		post_one_notification(wqueue, n, cred);
+	}
+
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(__post_watch_notification);
+
+/*
+ * Allow the queue to be polled.
+ */
+static __poll_t watch_queue_poll(struct file *file, poll_table *wait)
+{
+	struct watch_queue *wqueue = file->private_data;
+	struct watch_queue_buffer *buf = wqueue->buffer;
+	unsigned int head, tail;
+	__poll_t mask = 0;
+
+	poll_wait(file, &wqueue->waiters, wait);
+
+	head = READ_ONCE(buf->meta.head);
+	tail = READ_ONCE(buf->meta.tail);
+	if (head != tail)
+		mask |= EPOLLIN | EPOLLRDNORM;
+	if (head - tail > wqueue->size)
+		mask |= EPOLLERR;
+	return mask;
+}
+
+static int watch_queue_set_page_dirty(struct page *page)
+{
+	SetPageDirty(page);
+	return 0;
+}
+
+static const struct address_space_operations watch_queue_aops = {
+	.set_page_dirty	= watch_queue_set_page_dirty,
+};
+
+static vm_fault_t watch_queue_fault(struct vm_fault *vmf)
+{
+	struct watch_queue *wqueue = vmf->vma->vm_file->private_data;
+	struct page *page;
+
+	page = wqueue->pages[vmf->pgoff];
+	get_page(page);
+	if (!lock_page_or_retry(page, vmf->vma->vm_mm, vmf->flags)) {
+		put_page(page);
+		return VM_FAULT_RETRY;
+	}
+	vmf->page = page;
+	return VM_FAULT_LOCKED;
+}
+
+static void watch_queue_map_pages(struct vm_fault *vmf,
+				  pgoff_t start_pgoff, pgoff_t end_pgoff)
+{
+	struct watch_queue *wqueue = vmf->vma->vm_file->private_data;
+	struct page *page;
+
+	rcu_read_lock();
+
+	do {
+		page = wqueue->pages[start_pgoff];
+		if (trylock_page(page)) {
+			vm_fault_t ret;
+			get_page(page);
+			ret = alloc_set_pte(vmf, NULL, page);
+			if (ret != 0)
+				put_page(page);
+
+			unlock_page(page);
+		}
+	} while (++start_pgoff < end_pgoff);
+
+	rcu_read_unlock();
+}
+
+static const struct vm_operations_struct watch_queue_vm_ops = {
+	.fault		= watch_queue_fault,
+	.map_pages	= watch_queue_map_pages,
+};
+
+/*
+ * Map the buffer.
+ */
+static int watch_queue_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct watch_queue *wqueue = file->private_data;
+
+	if (vma->vm_pgoff != 0 ||
+	    vma->vm_end - vma->vm_start > wqueue->nr_pages * PAGE_SIZE ||
+	    !(pgprot_val(vma->vm_page_prot) & pgprot_val(PAGE_SHARED)))
+		return -EINVAL;
+
+	vma->vm_ops = &watch_queue_vm_ops;
+
+	vma_interval_tree_insert(vma, &wqueue->mapping.i_mmap);
+	return 0;
+}
+
+/*
+ * Allocate the required number of pages.
+ */
+static long watch_queue_set_size(struct watch_queue *wqueue, unsigned long nr_pages)
+{
+	struct watch_queue_buffer *buf;
+	u32 len;
+	int i;
+
+	if (nr_pages == 0 ||
+	    nr_pages > 16 || /* TODO: choose a better hard limit */
+	    !is_power_of_2(nr_pages))
+		return -EINVAL;
+
+	wqueue->pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!wqueue->pages)
+		goto err;
+
+	for (i = 0; i < nr_pages; i++) {
+		wqueue->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!wqueue->pages[i])
+			goto err_some_pages;
+		wqueue->pages[i]->mapping = &wqueue->mapping;
+		SetPageUptodate(wqueue->pages[i]);
+	}
+
+	buf = vmap(wqueue->pages, nr_pages, VM_MAP, PAGE_SHARED);
+	if (!buf)
+		goto err_some_pages;
+
+	wqueue->buffer = buf;
+	wqueue->nr_pages = nr_pages;
+	wqueue->size = ((nr_pages * PAGE_SIZE) / sizeof(struct watch_notification));
+
+	/* The first four slots in the buffer contain metadata about the ring,
+	 * including the head and tail indices and mask.
+	 */
+	len = sizeof(buf->meta) / sizeof(buf->slots[0]);
+	buf->meta.watch.info	= len << WATCH_LENGTH_SHIFT;
+	buf->meta.watch.type	= WATCH_TYPE_META;
+	buf->meta.watch.subtype	= WATCH_META_SKIP_NOTIFICATION;
+	buf->meta.tail		= len;
+	buf->meta.mask		= wqueue->size - 1;
+	smp_store_release(&buf->meta.head, len);
+	return 0;
+
+err_some_pages:
+	for (i--; i >= 0; i--) {
+		ClearPageUptodate(wqueue->pages[i]);
+		wqueue->pages[i]->mapping = NULL;
+		put_page(wqueue->pages[i]);
+	}
+
+	kfree(wqueue->pages);
+	wqueue->pages = NULL;
+err:
+	return -ENOMEM;
+}
+
+/*
+ * Set the filter on a watch queue.
+ */
+static long watch_queue_set_filter(struct inode *inode,
+				   struct watch_queue *wqueue,
+				   struct watch_notification_filter __user *_filter)
+{
+	struct watch_notification_type_filter *tf;
+	struct watch_notification_filter filter;
+	struct watch_type_filter *q;
+	struct watch_filter *wfilter;
+	int ret, nr_filter = 0, i;
+
+	if (!_filter) {
+		/* Remove the old filter */
+		wfilter = NULL;
+		goto set;
+	}
+
+	/* Grab the user's filter specification */
+	if (copy_from_user(&filter, _filter, sizeof(filter)) != 0)
+		return -EFAULT;
+	if (filter.nr_filters == 0 ||
+	    filter.nr_filters > 16 ||
+	    filter.__reserved != 0)
+		return -EINVAL;
+
+	tf = memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
+	if (IS_ERR(tf))
+		return PTR_ERR(tf);
+
+	ret = -EINVAL;
+	for (i = 0; i < filter.nr_filters; i++) {
+		if ((tf[i].info_filter & ~tf[i].info_mask) ||
+		    tf[i].info_mask & WATCH_INFO_LENGTH)
+			goto err_filter;
+		/* Ignore any unknown types */
+		if (tf[i].type >= sizeof(wfilter->type_filter) * 8)
+			continue;
+		nr_filter++;
+	}
+
+	/* Now we need to build the internal filter from only the relevant
+	 * user-specified filters.
+	 */
+	ret = -ENOMEM;
+	wfilter = kzalloc(struct_size(wfilter, filters, nr_filter), GFP_KERNEL);
+	if (!wfilter)
+		goto err_filter;
+	wfilter->nr_filters = nr_filter;
+
+	q = wfilter->filters;
+	for (i = 0; i < filter.nr_filters; i++) {
+		if (tf[i].type >= sizeof(wfilter->type_filter) * BITS_PER_LONG)
+			continue;
+
+		q->type			= tf[i].type;
+		q->info_filter		= tf[i].info_filter;
+		q->info_mask		= tf[i].info_mask;
+		q->subtype_filter[0]	= tf[i].subtype_filter[0];
+		__set_bit(q->type, wfilter->type_filter);
+		q++;
+	}
+
+	kfree(tf);
+set:
+	rcu_swap_protected(wqueue->filter, wfilter,
+			   lockdep_is_held(&inode->i_rwsem));
+	if (wfilter)
+		kfree_rcu(wfilter, rcu);
+	return 0;
+
+err_filter:
+	kfree(tf);
+	return ret;
+}
+
+/*
+ * Set parameters.
+ */
+static long watch_queue_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct watch_queue *wqueue = file->private_data;
+	struct inode *inode = file_inode(file);
+	long ret;
+
+	switch (cmd) {
+	case IOC_WATCH_QUEUE_SET_SIZE:
+		if (wqueue->buffer)
+			return -EBUSY;
+		inode_lock(inode);
+		ret = watch_queue_set_size(wqueue, arg);
+		inode_unlock(inode);
+		return ret;
+
+	case IOC_WATCH_QUEUE_SET_FILTER:
+		inode_lock(inode);
+		ret = watch_queue_set_filter(
+			inode, wqueue,
+			(struct watch_notification_filter __user *)arg);
+		inode_unlock(inode);
+		return ret;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/*
+ * Open the file.
+ */
+static int watch_queue_open(struct inode *inode, struct file *file)
+{
+	struct watch_queue *wqueue;
+
+	wqueue = kzalloc(sizeof(*wqueue), GFP_KERNEL);
+	if (!wqueue)
+		return -ENOMEM;
+
+	wqueue->mapping.a_ops = &watch_queue_aops;
+	wqueue->mapping.i_mmap = RB_ROOT_CACHED;
+	init_rwsem(&wqueue->mapping.i_mmap_rwsem);
+	spin_lock_init(&wqueue->mapping.private_lock);
+
+	refcount_set(&wqueue->usage, 1);
+	spin_lock_init(&wqueue->lock);
+	init_waitqueue_head(&wqueue->waiters);
+	wqueue->cred = get_cred(file->f_cred);
+
+	file->private_data = wqueue;
+	return 0;
+}
+
+/**
+ * put_watch_queue - Dispose of a ref on a watchqueue.
+ * @wqueue: The watch queue to unref.
+ */
+void put_watch_queue(struct watch_queue *wqueue)
+{
+	if (refcount_dec_and_test(&wqueue->usage))
+		kfree_rcu(wqueue, rcu);
+}
+EXPORT_SYMBOL(put_watch_queue);
+
+static void free_watch(struct rcu_head *rcu)
+{
+	struct watch *watch = container_of(rcu, struct watch, rcu);
+
+	put_watch_queue(rcu_access_pointer(watch->queue));
+}
+
+/*
+ * Discard a watch.
+ */
+static void put_watch(struct watch *watch)
+{
+	if (refcount_dec_and_test(&watch->usage))
+		call_rcu(&watch->rcu, free_watch);
+}
+
+/**
+ * init_watch_queue - Initialise a watch
+ * @watch: The watch to initialise.
+ * @wqueue: The queue to assign.
+ *
+ * Initialise a watch and set the watch queue.
+ */
+void init_watch(struct watch *watch, struct watch_queue *wqueue)
+{
+	refcount_set(&watch->usage, 1);
+	INIT_HLIST_NODE(&watch->list_node);
+	INIT_HLIST_NODE(&watch->queue_node);
+	rcu_assign_pointer(watch->queue, wqueue);
+}
+
+/**
+ * add_watch_to_object - Add a watch on an object to a watch list
+ * @watch: The watch to add
+ * @wlist: The watch list to add to
+ *
+ * @watch->queue must have been set to point to the queue to post notifications
+ * to and the watch list of the object to be watched.
+ *
+ * The caller must pin the queue and the list both and must hold the list
+ * locked against racing watch additions/removals.
+ */
+int add_watch_to_object(struct watch *watch, struct watch_list *wlist)
+{
+	struct watch_queue *wqueue = rcu_access_pointer(watch->queue);
+	struct watch *w;
+
+	hlist_for_each_entry(w, &wlist->watchers, list_node) {
+		if (watch->id == w->id)
+			return -EBUSY;
+	}
+
+	rcu_assign_pointer(watch->watch_list, wlist);
+
+	spin_lock_bh(&wqueue->lock);
+	refcount_inc(&wqueue->usage);
+	hlist_add_head(&watch->queue_node, &wqueue->watches);
+	spin_unlock_bh(&wqueue->lock);
+
+	hlist_add_head(&watch->list_node, &wlist->watchers);
+	return 0;
+}
+EXPORT_SYMBOL(add_watch_to_object);
+
+/**
+ * remove_watch_from_object - Remove a watch or all watches from an object.
+ * @wlist: The watch list to remove from
+ * @wq: The watch queue of interest (ignored if @all is true)
+ * @id: The ID of the watch to remove (ignored if @all is true)
+ * @all: True to remove all objects
+ *
+ * Remove a specific watch or all watches from an object.  A notification is
+ * sent to the watcher to tell them that this happened.
+ */
+int remove_watch_from_object(struct watch_list *wlist, struct watch_queue *wq,
+			     u64 id, bool all)
+{
+	struct watch_notification n;
+	struct watch_queue *wqueue;
+	struct watch *watch;
+	int ret = -EBADSLT;
+
+	rcu_read_lock();
+
+again:
+	spin_lock(&wlist->lock);
+	hlist_for_each_entry(watch, &wlist->watchers, list_node) {
+		if (all ||
+		    (watch->id == id && rcu_access_pointer(watch->queue) == wq))
+			goto found;
+	}
+	spin_unlock(&wlist->lock);
+	goto out;
+
+found:
+	ret = 0;
+	hlist_del_init_rcu(&watch->list_node);
+	rcu_assign_pointer(watch->watch_list, NULL);
+	spin_unlock(&wlist->lock);
+
+	n.type = WATCH_TYPE_META;
+	n.subtype = WATCH_META_REMOVAL_NOTIFICATION;
+	n.info = watch->info_id | sizeof(n);
+
+	wqueue = rcu_dereference(watch->queue);
+	post_one_notification(wqueue, &n, wq ? wq->cred : NULL);
+
+	/* We don't need the watch list lock for the next bit as RCU is
+	 * protecting everything from being deallocated.
+	 */
+	if (wqueue) {
+		spin_lock_bh(&wqueue->lock);
+
+		if (!hlist_unhashed(&watch->queue_node)) {
+			hlist_del_init_rcu(&watch->queue_node);
+			put_watch(watch);
+		}
+
+		spin_unlock_bh(&wqueue->lock);
+	}
+
+	if (wlist->release_watch) {
+		rcu_read_unlock();
+		wlist->release_watch(wlist, watch);
+		rcu_read_lock();
+	}
+	put_watch(watch);
+
+	if (all && !hlist_empty(&wlist->watchers))
+		goto again;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+EXPORT_SYMBOL(remove_watch_from_object);
+
+/*
+ * Remove all the watches that are contributory to a queue.  This will
+ * potentially race with removal of the watches by the destruction of the
+ * objects being watched or the distribution of notifications.
+ */
+static void watch_queue_clear(struct watch_queue *wqueue)
+{
+	struct watch_list *wlist;
+	struct watch *watch;
+	bool release;
+
+	rcu_read_lock();
+	spin_lock_bh(&wqueue->lock);
+
+	/* Prevent new additions and prevent notifications from happening */
+	wqueue->defunct = true;
+
+	while (!hlist_empty(&wqueue->watches)) {
+		watch = hlist_entry(wqueue->watches.first, struct watch, queue_node);
+		hlist_del_init_rcu(&watch->queue_node);
+		spin_unlock_bh(&wqueue->lock);
+
+		/* We can't do the next bit under the queue lock as we need to
+		 * get the list lock - which would cause a deadlock if someone
+		 * was removing from the opposite direction at the same time or
+		 * posting a notification.
+		 */
+		wlist = rcu_dereference(watch->watch_list);
+		if (wlist) {
+			spin_lock(&wlist->lock);
+
+			release = !hlist_unhashed(&watch->list_node);
+			if (release) {
+				hlist_del_init_rcu(&watch->list_node);
+				rcu_assign_pointer(watch->watch_list, NULL);
+			}
+
+			spin_unlock(&wlist->lock);
+
+			if (release) {
+				if (wlist->release_watch) {
+					rcu_read_unlock();
+					/* This might need to call dput(), so
+					 * we have to drop all the locks.
+					 */
+					wlist->release_watch(wlist, watch);
+					rcu_read_lock();
+				}
+				put_watch(watch);
+			}
+		}
+
+		put_watch(watch);
+		spin_lock_bh(&wqueue->lock);
+	}
+
+	spin_unlock_bh(&wqueue->lock);
+	rcu_read_unlock();
+}
+
+/*
+ * Release the file.
+ */
+static int watch_queue_release(struct inode *inode, struct file *file)
+{
+	struct watch_filter *wfilter;
+	struct watch_queue *wqueue = file->private_data;
+	int i, pgref;
+
+	watch_queue_clear(wqueue);
+
+	if (wqueue->pages && wqueue->pages[0])
+		WARN_ON(page_ref_count(wqueue->pages[0]) != 1);
+
+	if (wqueue->buffer)
+		vfree(wqueue->buffer);
+	for (i = 0; i < wqueue->nr_pages; i++) {
+		ClearPageUptodate(wqueue->pages[i]);
+		wqueue->pages[i]->mapping = NULL;
+		pgref = page_ref_count(wqueue->pages[i]);
+		WARN(pgref != 1,
+		     "FREE PAGE[%d] refcount %d\n", i, page_ref_count(wqueue->pages[i]));
+		__free_page(wqueue->pages[i]);
+	}
+
+	wfilter = rcu_access_pointer(wqueue->filter);
+	if (wfilter)
+		kfree_rcu(wfilter, rcu);
+	kfree(wqueue->pages);
+	put_cred(wqueue->cred);
+	put_watch_queue(wqueue);
+	return 0;
+}
+
+#ifdef DEBUG_WITH_WRITE
+static ssize_t watch_queue_write(struct file *file,
+				 const char __user *_buf, size_t len, loff_t *pos)
+{
+	struct watch_notification *n;
+	struct watch_queue *wqueue = file->private_data;
+	ssize_t ret;
+
+	if (!wqueue->buffer)
+		return -ENOBUFS;
+
+	if (len & ~WATCH_INFO_LENGTH || len == 0 || !_buf)
+		return -EINVAL;
+
+	n = memdup_user(_buf, len);
+	if (IS_ERR(n))
+		return PTR_ERR(n);
+
+	ret = -EINVAL;
+	if ((n->info & WATCH_INFO_LENGTH) != len)
+		goto error;
+	n->info &= (WATCH_INFO_LENGTH | WATCH_INFO_TYPE_FLAGS | WATCH_INFO_ID);
+
+	if (post_one_notification(wqueue, n, file->f_cred))
+		wqueue->debug = 0;
+	else
+		wqueue->debug++;
+	ret = len;
+	if (wqueue->debug > 20)
+		ret = -EIO;
+
+error:
+	kfree(n);
+	return ret;
+}
+#endif
+
+static const struct file_operations watch_queue_fops = {
+	.owner		= THIS_MODULE,
+	.open		= watch_queue_open,
+	.release	= watch_queue_release,
+	.unlocked_ioctl	= watch_queue_ioctl,
+	.poll		= watch_queue_poll,
+	.mmap		= watch_queue_mmap,
+#ifdef DEBUG_WITH_WRITE
+	.write		= watch_queue_write,
+#endif
+	.llseek		= no_llseek,
+};
+
+/**
+ * get_watch_queue - Get a watch queue from its file descriptor.
+ * @fd: The fd to query.
+ */
+struct watch_queue *get_watch_queue(int fd)
+{
+	struct watch_queue *wqueue = ERR_PTR(-EBADF);
+	struct fd f;
+
+	f = fdget(fd);
+	if (f.file) {
+		wqueue = ERR_PTR(-EINVAL);
+		if (f.file->f_op == &watch_queue_fops) {
+			wqueue = f.file->private_data;
+			refcount_inc(&wqueue->usage);
+		}
+		fdput(f);
+	}
+
+	return wqueue;
+}
+EXPORT_SYMBOL(get_watch_queue);
+
+static struct miscdevice watch_queue_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "watch_queue",
+	.fops	= &watch_queue_fops,
+	.mode	= 0666,
+};
+
+static int __init watch_queue_init(void)
+{
+	int ret;
+
+	ret = misc_register(&watch_queue_dev);
+	if (ret < 0)
+		pr_err("Failed to register %d\n", ret);
+	return ret;
+}
+fs_initcall(watch_queue_init);
+
+static void __exit watch_queue_exit(void)
+{
+	misc_deregister(&watch_queue_dev);
+}
+module_exit(watch_queue_exit);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 2474c3f785ca..2f72ea80d4fe 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1420,6 +1420,13 @@
  *	@ctx is a pointer in which to place the allocated security context.
  *	@ctxlen points to the place to put the length of @ctx.
  *
+ * @post_notification:
+ *	Check to see if a watch notification can be posted to a particular
+ *	queue.
+ *	@q_cred: The credentials of the target watch queue.
+ *	@cred: The event-triggerer's credentials
+ *	@n: The notification being posted
+ *
  * Security hooks for using the eBPF maps and programs functionalities through
  * eBPF syscalls.
  *
@@ -1698,6 +1705,11 @@ union security_list_options {
 	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
+#ifdef CONFIG_WATCH_QUEUE
+	int (*post_notification)(const struct cred *q_cred,
+				 const struct cred *cred,
+				 struct watch_notification *n);
+#endif
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
@@ -1977,6 +1989,9 @@ struct security_hook_heads {
 	struct hlist_head inode_notifysecctx;
 	struct hlist_head inode_setsecctx;
 	struct hlist_head inode_getsecctx;
+#ifdef CONFIG_WATCH_QUEUE
+	struct hlist_head post_notification;
+#endif
 #ifdef CONFIG_SECURITY_NETWORK
 	struct hlist_head unix_stream_connect;
 	struct hlist_head unix_may_send;
diff --git a/include/linux/security.h b/include/linux/security.h
index 23c8b602c0ab..1df8d55de8da 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -58,6 +58,7 @@ struct fs_context;
 struct fs_parameter;
 enum fs_value_type;
 struct fsinfo_kparams;
+struct watch_notification;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -396,6 +397,11 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+#ifdef CONFIG_WATCH_QUEUE
+int security_post_notification(const struct cred *q_cred,
+			       const struct cred *cred,
+			       struct watch_notification *n);
+#endif
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1215,6 +1221,14 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 {
 	return -EOPNOTSUPP;
 }
+#ifdef CONFIG_WATCH_QUEUE
+static inline int security_post_notification(const struct cred *q_cred,
+					     const struct cred *cred,
+					     struct watch_notification *n)
+{
+	return 0;
+}
+#endif
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
new file mode 100644
index 000000000000..f200b68c799e
--- /dev/null
+++ b/include/linux/watch_queue.h
@@ -0,0 +1,86 @@
+/* User-mappable watch queue
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ *
+ * See Documentation/watch_queue.rst
+ */
+
+#ifndef _LINUX_WATCH_QUEUE_H
+#define _LINUX_WATCH_QUEUE_H
+
+#include <uapi/linux/watch_queue.h>
+
+#ifdef CONFIG_WATCH_QUEUE
+
+struct watch_queue;
+
+/*
+ * Representation of a watch on an object.
+ */
+struct watch {
+	union {
+		struct rcu_head	rcu;
+		u32		info_id;	/* ID to be OR'd in to info field */
+	};
+	struct watch_queue __rcu *queue;	/* Queue to post events to */
+	struct hlist_node	queue_node;	/* Link in queue->watches */
+	struct watch_list __rcu	*watch_list;
+	struct hlist_node	list_node;	/* Link in watch_list->watchers */
+	void			*private;	/* Private data for the watched object */
+	u64			id;		/* Internal identifier */
+	refcount_t		usage;
+};
+
+/*
+ * List of watches on an object.
+ */
+struct watch_list {
+	struct rcu_head		rcu;
+	struct hlist_head	watchers;
+	void (*release_watch)(struct watch_list *, struct watch *);
+	spinlock_t		lock;
+};
+
+extern void __post_watch_notification(struct watch_list *,
+				      struct watch_notification *,
+				      const struct cred *,
+				      u64);
+extern struct watch_queue *get_watch_queue(int);
+extern void put_watch_queue(struct watch_queue *);
+extern void put_watch_list(struct watch_list *);
+extern void init_watch(struct watch *, struct watch_queue *);
+extern int add_watch_to_object(struct watch *, struct watch_list *);
+extern int remove_watch_from_object(struct watch_list *, struct watch_queue *, u64, bool);
+
+static inline void init_watch_list(struct watch_list *wlist)
+{
+	INIT_HLIST_HEAD(&wlist->watchers);
+	spin_lock_init(&wlist->lock);
+}
+
+static inline void post_watch_notification(struct watch_list *wlist,
+					   struct watch_notification *n,
+					   const struct cred *cred,
+					   u64 id)
+{
+	if (unlikely(wlist))
+		__post_watch_notification(wlist, n, cred, id);
+}
+
+static inline void remove_watch_list(struct watch_list *wlist)
+{
+	if (wlist) {
+		remove_watch_from_object(wlist, NULL, 0, true);
+		kfree_rcu(wlist, rcu);
+	}
+}
+
+#endif
+
+#endif /* _LINUX_WATCH_QUEUE_H */
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
new file mode 100644
index 000000000000..01746982c2ba
--- /dev/null
+++ b/include/uapi/linux/watch_queue.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_WATCH_QUEUE_H
+#define _UAPI_LINUX_WATCH_QUEUE_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define IOC_WATCH_QUEUE_SET_SIZE	_IO('s', 0x01)	/* Set the size in pages */
+#define IOC_WATCH_QUEUE_SET_FILTER	_IO('s', 0x02)	/* Set the filter */
+
+enum watch_notification_type {
+	WATCH_TYPE_META		= 0,	/* Special record */
+	WATCH_TYPE_MOUNT_NOTIFY	= 1,	/* Mount notification record */
+	WATCH_TYPE_SB_NOTIFY	= 2,	/* Superblock notification */
+	WATCH_TYPE_KEY_NOTIFY	= 3,	/* Key/keyring change notification */
+	WATCH_TYPE_BLOCK_NOTIFY	= 4,	/* Block layer notifications */
+#define WATCH_TYPE___NR 5
+};
+
+enum watch_meta_notification_subtype {
+	WATCH_META_SKIP_NOTIFICATION	= 0,	/* Just skip this record */
+	WATCH_META_REMOVAL_NOTIFICATION	= 1,	/* Watched object was removed */
+};
+
+/*
+ * Notification record
+ */
+struct watch_notification {
+	__u32			type:24;	/* enum watch_notification_type */
+	__u32			subtype:8;	/* Type-specific subtype (filterable) */
+	__u32			info;
+#define WATCH_INFO_OVERRUN	0x00000001	/* Event(s) lost due to overrun */
+#define WATCH_INFO_ENOMEM	0x00000002	/* Event(s) lost due to ENOMEM */
+#define WATCH_INFO_RECURSIVE	0x00000004	/* Change was recursive */
+#define WATCH_INFO_LENGTH	0x000001f8	/* Length of record / sizeof(watch_notification) */
+#define WATCH_INFO_IN_SUBTREE	0x00000200	/* Change was not at watched root */
+#define WATCH_INFO_TYPE_FLAGS	0x00ff0000	/* Type-specific flags */
+#define WATCH_INFO_FLAG_0	0x00010000
+#define WATCH_INFO_FLAG_1	0x00020000
+#define WATCH_INFO_FLAG_2	0x00040000
+#define WATCH_INFO_FLAG_3	0x00080000
+#define WATCH_INFO_FLAG_4	0x00100000
+#define WATCH_INFO_FLAG_5	0x00200000
+#define WATCH_INFO_FLAG_6	0x00400000
+#define WATCH_INFO_FLAG_7	0x00800000
+#define WATCH_INFO_ID		0xff000000	/* ID of watchpoint */
+};
+
+#define WATCH_LENGTH_SHIFT	3
+
+struct watch_queue_buffer {
+	union {
+		/* The first few entries are special, containing the
+		 * ring management variables.
+		 */
+		struct {
+			struct watch_notification watch; /* WATCH_TYPE_SKIP */
+			volatile __u32	head;		/* Ring head index */
+			volatile __u32	tail;		/* Ring tail index */
+			__u32		mask;		/* Ring index mask */
+		} meta;
+		struct watch_notification slots[0];
+	};
+};
+
+/*
+ * Notification filtering rules (IOC_WATCH_QUEUE_SET_FILTER).
+ */
+struct watch_notification_type_filter {
+	__u32	type;			/* Type to apply filter to */
+	__u32	info_filter;		/* Filter on watch_notification::info */
+	__u32	info_mask;		/* Mask of relevant bits in info_filter */
+	__u32	subtype_filter[8];	/* Bitmask of subtypes to filter on */
+};
+
+struct watch_notification_filter {
+	__u32	nr_filters;		/* Number of filters */
+	__u32	__reserved;		/* Must be 0 */
+	struct watch_notification_type_filter filters[];
+};
+
+#endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/mm/interval_tree.c b/mm/interval_tree.c
index 27ddfd29112a..9a53ddf4bd62 100644
--- a/mm/interval_tree.c
+++ b/mm/interval_tree.c
@@ -25,6 +25,8 @@ INTERVAL_TREE_DEFINE(struct vm_area_struct, shared.rb,
 		     unsigned long, shared.rb_subtree_last,
 		     vma_start_pgoff, vma_last_pgoff,, vma_interval_tree)
 
+EXPORT_SYMBOL_GPL(vma_interval_tree_insert);
+
 /* Insert node immediately after prev in the interval tree */
 void vma_interval_tree_insert_after(struct vm_area_struct *node,
 				    struct vm_area_struct *prev,
diff --git a/mm/memory.c b/mm/memory.c
index 96f1d473c89a..9f2fa2138287 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3360,6 +3360,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(alloc_set_pte);
 
 
 /**
diff --git a/security/security.c b/security/security.c
index 3af886e8fced..af758dc71e24 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1929,6 +1929,15 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
+#ifdef CONFIG_WATCH_QUEUE
+int security_post_notification(const struct cred *q_cred,
+			       const struct cred *cred,
+			       struct watch_notification *n)
+{
+	return call_int_hook(post_notification, 0, q_cred, cred, n);
+}
+#endif
+
 #ifdef CONFIG_SECURITY_NETWORK
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)

