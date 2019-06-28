Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B55FC59FA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfF1PtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:49:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbfF1PtV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:49:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE3E730820C9;
        Fri, 28 Jun 2019 15:49:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69C3760A97;
        Fri, 28 Jun 2019 15:49:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/9] General notification queue with user mmap()'able ring
 buffer [ver #5]
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
Date:   Fri, 28 Jun 2019 16:49:10 +0100
Message-ID: <156173695061.15137.17196611619288074120.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
References: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 28 Jun 2019 15:49:20 +0000 (UTC)
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

 Documentation/ioctl/ioctl-number.txt |    1 
 Documentation/watch_queue.rst        |  429 ++++++++++++++++
 drivers/misc/Kconfig                 |   13 
 drivers/misc/Makefile                |    1 
 drivers/misc/watch_queue.c           |  890 ++++++++++++++++++++++++++++++++++
 include/linux/watch_queue.h          |   94 ++++
 include/uapi/linux/watch_queue.h     |   21 +
 7 files changed, 1449 insertions(+)
 create mode 100644 Documentation/watch_queue.rst
 create mode 100644 drivers/misc/watch_queue.c
 create mode 100644 include/linux/watch_queue.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index c9558146ac58..e7b2e56fcfdd 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -194,6 +194,7 @@ Code  Seq#(hex)	Include File		Comments
 'W'	00-1F	linux/wanrouter.h	conflict!		(pre 3.9)
 'W'	00-3F	sound/asound.h		conflict!
 'W'	40-5F   drivers/pci/switch/switchtec.c
+'W'	60-61	linux/watch_queue.h
 'X'	all	fs/xfs/xfs_fs.h		conflict!
 		and fs/xfs/linux-2.6/xfs_ioctl32.h
 		and include/linux/falloc.h
diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
new file mode 100644
index 000000000000..6fb3aa3356d3
--- /dev/null
+++ b/Documentation/watch_queue.rst
@@ -0,0 +1,429 @@
+============================
+Mappable notifications queue
+============================
+
+This is a misc device that acts as a mapped ring buffer by which userspace can
+receive notifications from the kernel.  This can be used in conjunction with::
+
+  * Key/keyring notifications
+
+  * General device event notifications
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
+indicates the particular buffer it wants notifications from that watch to be
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
+		__u32	type:24;
+		__u32	subtype:8;
+		__u32	info;
+	} __attribute__((aligned(WATCH_LENGTH_GRANULARITY)));
+
+"type" indicates the source of the notification record and "subtype" indicates
+the type of record from that source (see the Watch Sources section below).  The
+type may also be "WATCH_TYPE_META".  This is a special record type generated
+internally by the watch queue driver itself.  There are two subtypes, one of
+which indicates records that should be just skipped (padding or metadata):
+
+  * WATCH_META_SKIP_NOTIFICATION
+  * WATCH_META_REMOVAL_NOTIFICATION
+
+The former indicates a record that should just be skipped and the latter
+indicates that an object on which a watch was installed was removed or
+destroyed.
+
+"info" indicates a bunch of things, including:
+
+  * The length of the record in units of buffer slots (mask with
+    WATCH_INFO_LENGTH and shift by WATCH_INFO_LENGTH__SHIFT).  This indicates
+    the size of the record, which may be between 1 and 63 slots.  To turn this
+    into a number of bytes, multiply by WATCH_LENGTH_GRANULARITY.
+
+  * The watch ID (mask with WATCH_INFO_ID and shift by WATCH_INFO_ID__SHIFT).
+    This indicates that caller's ID of the watch, which may be between 0
+    and 255.  Multiple watches may share a queue, and this provides a means to
+    distinguish them.
+
+  * In the metadata header in slot 0, a flag (WATCH_INFO_NOTIFICATIONS_LOST)
+    that indicates that some notifications were lost for some reason, including
+    buffer overrun, insufficient memory and inconsistent tail index.
+
+  * A type-specific field (WATCH_INFO_TYPE_INFO).  This is set by the
+    notification producer to indicate some meaning specific to the type and
+    subtype.
+
+Everything in info apart from the length can be used for filtering.
+
+
+Ring Structure
+==============
+
+The ring is divided into slots of size WATCH_LENGTH_GRANULARITY (8 bytes).  The
+caller uses an ioctl() to set the size of the ring after opening and this must
+be a power-of-2 multiple of the system page size (so that the mask can be used
+with AND).
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
+Watch List (Notification Source) API
+====================================
+
+A "watch list" is a list of watchers that are subscribed to a source of
+notifications.  A list may be attached to an object (say a key or a superblock)
+or may be global (say for device events).  From a userspace perspective, a
+non-global watch list is typically referred to by reference to the object it
+belongs to (such as using KEYCTL_NOTIFY and giving it a key serial number to
+watch that specific key).
+
+To manage a watch list, the following functions are provided:
+
+  * ``void init_watch_list(struct watch_list *wlist,
+			   void (*release_watch)(struct watch *wlist));``
+
+    Initialise a watch list.  If ``release_watch`` is not NULL, then this
+    indicates a function that should be called when the watch_list object is
+    destroyed to discard any references the watch list holds on the watched
+    object.
+
+  * ``void remove_watch_list(struct watch_list *wlist);``
+
+    This removes all of the watches subscribed to a watch_list and frees them
+    and then destroys the watch_list object itself.
+
+
+Watch Queue (Notification Buffer) API
+=====================================
+
+A "watch queue" is the buffer allocated by or on behalf of the application that
+notification records will be written into.  The workings of this are hidden
+entirely inside of the watch_queue device driver, but it is necessary to gain a
+reference to it to place a watch.  These can be managed with:
+
+  * ``struct watch_queue *get_watch_queue(int fd);``
+
+    Since watch queues are indicated to the kernel by the fd of the character
+    device that implements the buffer, userspace must hand that fd through a
+    system call.  This can be used to look up an opaque pointer to the watch
+    queue from the system call.
+
+  * ``void put_watch_queue(struct watch_queue *wqueue);``
+
+    This discards the reference obtained from ``get_watch_queue()``.
+
+
+Watch Subscription API
+======================
+
+A "watch" is a subscription on a watch list, indicating the watch queue, and
+thus the buffer, into which notification records should be written.  The watch
+queue object may also carry filtering rules for that object, as set by
+userspace.  Some parts of the watch struct can be set by the driver::
+
+	struct watch {
+		union {
+			u32		info_id;	/* ID to be OR'd in to info field */
+			...
+		};
+		void			*private;	/* Private data for the watched object */
+		u64			id;		/* Internal identifier */
+		...
+	};
+
+The ``info_id`` value should be an 8-bit number obtained from userspace and
+shifted by WATCH_INFO_ID__SHIFT.  This is OR'd into the WATCH_INFO_ID field of
+struct watch_notification::info when and if the notification is written into
+the associated watch queue buffer.
+
+The ``private`` field is the driver's data associated with the watch_list and
+is cleaned up by the ``watch_list::release_watch()`` method.
+
+The ``id`` field is the source's ID.  Notifications that are posted with a
+different ID are ignored.
+
+The following functions are provided to manage watches:
+
+  * ``void init_watch(struct watch *watch, struct watch_queue *wqueue);``
+
+    Initialise a watch object, setting its pointer to the watch queue, using
+    appropriate barriering to avoid lockdep complaints.
+
+  * ``int add_watch_to_object(struct watch *watch, struct watch_list *wlist);``
+
+    Subscribe a watch to a watch list (notification source).  The
+    driver-settable fields in the watch struct must have been set before this
+    is called.
+
+  * ``int remove_watch_from_object(struct watch_list *wlist,
+				   struct watch_queue *wqueue,
+				   u64 id, false);``
+
+    Remove a watch from a watch list, where the watch must match the specified
+    watch queue (``wqueue``) and object identifier (``id``).  A notification
+    (``WATCH_META_REMOVAL_NOTIFICATION``) is sent to the watch queue to
+    indicate that the watch got removed.
+
+  * ``int remove_watch_from_object(struct watch_list *wlist, NULL, 0, true);``
+
+    Remove all the watches from a watch list.  It is expected that this will be
+    called preparatory to destruction and that the watch list will be
+    inaccessible to new watches by this point.  A notification
+    (``WATCH_META_REMOVAL_NOTIFICATION``) is sent to the watch queue of each
+    subscribed watch to indicate that the watch got removed.
+
+
+Notification Posting API
+========================
+
+To post a notification to watch list so that the subscribed watches can see it,
+the following function should be used::
+
+	void post_watch_notification(struct watch_list *wlist,
+				     struct watch_notification *n,
+				     const struct cred *cred,
+				     u64 id);
+
+The notification should be preformatted and a pointer to the header (``n``)
+should be passed in.  The notification may be larger than this and the size in
+units of buffer slots is noted in ``n->info & WATCH_INFO_LENGTH``.
+
+The ``cred`` struct indicates the credentials of the source (subject) and is
+passed to the LSMs, such as SELinux, to allow or suppress the recording of the
+note in each individual queue according to the credentials of that queue
+(object).
+
+The ``id`` is the ID of the source object (such as the serial number on a key).
+Only watches that have the same ID set in them will see this notification.
+
+
+Watch Sources
+=============
+
+Any particular buffer can be fed from multiple sources.  Sources include:
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
+    or temporary link loss.  Watches of this type are set on a global queue.
+
+
+Event Filtering
+===============
+
+Once a watch queue has been created, a set of filters can be applied to limit
+the events that are received using::
+
+	struct watch_notification_filter filter = {
+		...
+	};
+	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter)
+
+The filter description is a variable of type::
+
+	struct watch_notification_filter {
+		__u32	nr_filters;
+		__u32	__reserved;
+		struct watch_notification_type_filter filters[];
+	};
+
+Where "nr_filters" is the number of filters in filters[] and "__reserved"
+should be 0.  The "filters" array has elements of the following type::
+
+	struct watch_notification_type_filter {
+		__u32	type;
+		__u32	info_filter;
+		__u32	info_mask;
+		__u32	subtype_filter[8];
+	};
+
+Where:
+
+  * ``type`` is the event type to filter for and should be something like
+    "WATCH_TYPE_KEY_NOTIFY"
+
+  * ``info_filter`` and ``info_mask`` act as a filter on the info field of the
+    notification record.  The notification is only written into the buffer if::
+
+	(watch.info & info_mask) == info_filter
+
+    This could be used, for example, to ignore events that are not exactly on
+    the watched point in a mount tree.
+
+  * ``subtype_filter`` is a bitmask indicating the subtypes that are of
+    interest.  Bit 0 of subtype_filter[0] corresponds to subtype 0, bit 1 to
+    subtype 1, and so on.
+
+If the argument to the ioctl() is NULL, then the filters will be removed and
+all events from the watched sources will come through.
+
+
+Waiting For Events
+==================
+
+The file descriptor that holds the buffer may be used with poll() and similar.
+POLLIN and POLLRDNORM are set if the buffer indices differ.  POLLERR is set if
+the buffer indices are further apart than the size of the buffer.  Wake-up
+events are only generated if the buffer is transitioned from an empty state.
+
+
+Userspace Code Example
+======================
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
+It can then be set to receive keyring change notifications and device event
+notifications::
+
+	keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x01);
+
+	watch_devices(fd, 0x2);
+
+The notifications can then be consumed by something like the following::
+
+	extern void saw_key_change(struct watch_notification *n);
+	extern void saw_block_event(struct watch_notification *n);
+	extern void saw_usb_event(struct watch_notification *n);
+
+	static int consumer(int fd, struct watch_queue_buffer *buf)
+	{
+		struct watch_notification *n;
+		struct pollfd p[1];
+		unsigned int len, head, tail, mask = buf->meta.mask;
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
+				len = (n->info & WATCH_INFO_LENGTH) >>
+					WATCH_INFO_LENGTH__SHIFT;
+				if (len == 0)
+					goto went_wrong;
+
+				switch (n->type) {
+				case WATCH_TYPE_KEY_NOTIFY:
+					saw_key_change(n);
+					break;
+				case WATCH_TYPE_BLOCK_NOTIFY:
+					saw_block_event(n);
+					break;
+				case WATCH_TYPE_USB_NOTIFY:
+					saw_usb_event(n);
+					break;
+				}
+
+				tail += len;
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
index 6a0365b2332c..e53f88783fe7 100644
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
+	  conjunction with watches for key/keyring change notifications and device
+	  notifications.
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
index 000000000000..d80d469f8cf8
--- /dev/null
+++ b/drivers/misc/watch_queue.c
@@ -0,0 +1,890 @@
+// SPDX-License-Identifier: GPL-2.0
+/* User-mappable watch queue
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
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
+#include <linux/sched/signal.h>
+#include <linux/watch_queue.h>
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
+	struct user_struct	*owner;		/* Owner of the queue for rlimit purposes */
+	struct watch_filter __rcu *filter;
+	wait_queue_head_t	waiters;
+	struct hlist_head	watches;	/* Contributory watches */
+	struct kref		usage;		/* Object usage count */
+	spinlock_t		lock;
+	bool			defunct;	/* T when queues closed */
+	u8			nr_pages;	/* Size of pages[] */
+	u8			flag_next;	/* Flag to apply to next item */
+	u32			size;
+	struct watch_queue_buffer *buffer;	/* Pointer to first record */
+
+	/* The mappable pages.  The zeroth page holds the ring pointers. */
+	struct page		**pages;
+};
+
+/*
+ * Write a notification of an event into an mmap'd queue and let the user know.
+ * Returns true if successful and false on failure (eg. buffer overrun or
+ * userspace mucked up the ring indices).
+ */
+static bool write_one_notification(struct watch_queue *wqueue,
+				   struct watch_notification *n)
+{
+	struct watch_queue_buffer *buf = wqueue->buffer;
+	struct watch_notification *p;
+	unsigned int gran = WATCH_LENGTH_GRANULARITY;
+	unsigned int metalen = sizeof(buf->meta) / gran;
+	unsigned int size = wqueue->size, mask = size - 1;
+	unsigned int len;
+	unsigned int ring_tail, tail, head, used, gap, h;
+
+	ring_tail = READ_ONCE(buf->meta.tail);
+	head = READ_ONCE(buf->meta.head);
+	used = head - ring_tail;
+
+	/* Check to see if userspace mucked up the pointers */
+	if (used >= size)
+		goto lost_event; /* Inconsistent */
+	tail = ring_tail & mask;
+	if (tail > 0 && tail < metalen)
+		goto lost_event; /* Inconsistent */
+
+	len = (n->info & WATCH_INFO_LENGTH) >> WATCH_INFO_LENGTH__SHIFT;
+	h = head & mask;
+	if (h >= tail) {
+		/* Head is at or after tail in the buffer.  There may then be
+		 * two gaps: one to the end of buffer and one at the beginning
+		 * of the buffer between the metadata block and the tail
+		 * pointer.
+		 */
+		gap = size - h;
+		if (len > gap) {
+			/* Not enough space in the post-head gap; we need to
+			 * wrap.  When wrapping, we will have to skip the
+			 * metadata at the beginning of the buffer.
+			 */
+			if (len > tail - metalen)
+				goto lost_event; /* Overrun */
+
+			/* Fill the space at the end of the page */
+			p = &buf->slots[h];
+			p->type		= WATCH_TYPE_META;
+			p->subtype	= WATCH_META_SKIP_NOTIFICATION;
+			p->info		= gap << WATCH_INFO_LENGTH__SHIFT;
+			head += gap;
+			h = 0;
+			if (h >= tail)
+				goto lost_event; /* Overrun */
+		}
+	}
+
+	if (h == 0) {
+		/* Reset and skip the header metadata */
+		p = &buf->meta.watch;
+		p->type		= WATCH_TYPE_META;
+		p->subtype	= WATCH_META_SKIP_NOTIFICATION;
+		p->info		= metalen << WATCH_INFO_LENGTH__SHIFT;
+		head += metalen;
+		h = metalen;
+		if (h == tail)
+			goto lost_event; /* Overrun */
+	}
+
+	if (h < tail) {
+		/* Head is before tail in the buffer. */
+		gap = tail - h;
+		if (len > gap)
+			goto lost_event; /* Overrun */
+	}
+
+	n->info |= wqueue->flag_next;
+	wqueue->flag_next = 0;
+	p = &buf->slots[h];
+	memcpy(p, n, len * gran);
+	head += len;
+
+	smp_store_release(&buf->meta.head, head);
+	if (used == 0)
+		wake_up(&wqueue->waiters);
+	return true;
+
+lost_event:
+	WRITE_ONCE(buf->meta.watch.info,
+		   buf->meta.watch.info | WATCH_INFO_NOTIFICATIONS_LOST);
+	return false;
+}
+
+/*
+ * Post a notification to a watch queue.
+ */
+static bool post_one_notification(struct watch_queue *wqueue,
+				  struct watch_notification *n)
+{
+	bool done = false;
+
+	if (!wqueue->buffer)
+		return false;
+
+	spin_lock_bh(&wqueue->lock); /* Protect head pointer */
+
+	if (!wqueue->defunct)
+		done = write_one_notification(wqueue, n);
+	spin_unlock_bh(&wqueue->lock);
+	return done;
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
+	if (((n->info & WATCH_INFO_LENGTH) >> WATCH_INFO_LENGTH__SHIFT) == 0) {
+		WARN_ON(1);
+		return;
+	}
+
+	rcu_read_lock();
+
+	hlist_for_each_entry_rcu(watch, &wlist->watchers, list_node) {
+		if (watch->id != id)
+			continue;
+		n->info &= ~WATCH_INFO_ID;
+		n->info |= watch->info_id;
+
+		wqueue = rcu_dereference(watch->queue);
+		wf = rcu_dereference(wqueue->filter);
+		if (wf && !filter_watch_notification(wf, n))
+			continue;
+
+		if (security_post_notification(watch->cred, cred, n) < 0)
+			continue;
+
+		post_one_notification(wqueue, n);
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
+	if (!buf)
+		return EPOLLERR;
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
+static int watch_queue_account_mem(struct watch_queue *wqueue,
+				   unsigned long nr_pages)
+{
+	struct user_struct *user = wqueue->owner;
+	unsigned long page_limit, cur_pages, new_pages;
+
+	/* Don't allow more pages than we can safely lock */
+	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	cur_pages = atomic_long_read(&user->locked_vm);
+
+	do {
+		new_pages = cur_pages + nr_pages;
+		if (new_pages > page_limit && !capable(CAP_IPC_LOCK))
+			return -ENOMEM;
+	} while (atomic_long_try_cmpxchg_relaxed(&user->locked_vm, &cur_pages,
+						 new_pages));
+
+	wqueue->nr_pages = nr_pages;
+	return 0;
+}
+
+static void watch_queue_unaccount_mem(struct watch_queue *wqueue)
+{
+	struct user_struct *user = wqueue->owner;
+
+	if (wqueue->nr_pages) {
+		atomic_long_sub(wqueue->nr_pages, &user->locked_vm);
+		wqueue->nr_pages = 0;
+	}
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
+	struct inode *inode = file_inode(file);
+	u8 nr_pages;
+
+	inode_lock(inode);
+	nr_pages = wqueue->nr_pages;
+	inode_unlock(inode);
+
+	if (nr_pages == 0 ||
+	    vma->vm_pgoff != 0 ||
+	    vma->vm_end - vma->vm_start > nr_pages * PAGE_SIZE ||
+	    !(pgprot_val(vma->vm_page_prot) & pgprot_val(PAGE_SHARED)))
+		return -EINVAL;
+
+	vma->vm_flags |= VM_DONTEXPAND;
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
+	unsigned int gran = WATCH_LENGTH_GRANULARITY;
+	unsigned int metalen = sizeof(buf->meta) / gran;
+	int i;
+
+	BUILD_BUG_ON(gran != sizeof(__u64));
+
+	if (wqueue->buffer)
+		return -EBUSY;
+
+	if (nr_pages == 0 ||
+	    nr_pages > 16 || /* TODO: choose a better hard limit */
+	    !is_power_of_2(nr_pages))
+		return -EINVAL;
+
+	if (watch_queue_account_mem(wqueue, nr_pages) < 0)
+		goto err;
+
+	wqueue->pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!wqueue->pages)
+		goto err_unaccount;
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
+	wqueue->size = ((nr_pages * PAGE_SIZE) / sizeof(struct watch_notification));
+
+	/* The first four slots in the buffer contain metadata about the ring,
+	 * including the head and tail indices and mask.
+	 */
+	buf->meta.watch.info	= metalen << WATCH_INFO_LENGTH__SHIFT;
+	buf->meta.watch.type	= WATCH_TYPE_META;
+	buf->meta.watch.subtype	= WATCH_META_SKIP_NOTIFICATION;
+	buf->meta.mask		= wqueue->size - 1;
+	buf->meta.head		= metalen;
+	buf->meta.tail		= metalen;
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
+err_unaccount:
+	watch_queue_unaccount_mem(wqueue);
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
+	inode_lock(inode);
+	rcu_swap_protected(wqueue->filter, wfilter,
+			   lockdep_is_held(&inode->i_rwsem));
+	inode_unlock(inode);
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
+		inode_lock(inode);
+		ret = watch_queue_set_size(wqueue, arg);
+		inode_unlock(inode);
+		return ret;
+
+	case IOC_WATCH_QUEUE_SET_FILTER:
+		ret = watch_queue_set_filter(
+			inode, wqueue,
+			(struct watch_notification_filter __user *)arg);
+		return ret;
+
+	default:
+		return -ENOTTY;
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
+	kref_init(&wqueue->usage);
+	spin_lock_init(&wqueue->lock);
+	init_waitqueue_head(&wqueue->waiters);
+	wqueue->owner = get_uid(file->f_cred->user);
+
+	file->private_data = wqueue;
+	return 0;
+}
+
+static void __put_watch_queue(struct kref *kref)
+{
+	struct watch_queue *wqueue =
+		container_of(kref, struct watch_queue, usage);
+	struct watch_filter *wfilter;
+
+	wfilter = rcu_access_pointer(wqueue->filter);
+	if (wfilter)
+		kfree_rcu(wfilter, rcu);
+	free_uid(wqueue->owner);
+	kfree_rcu(wqueue, rcu);
+}
+
+/**
+ * put_watch_queue - Dispose of a ref on a watchqueue.
+ * @wqueue: The watch queue to unref.
+ */
+void put_watch_queue(struct watch_queue *wqueue)
+{
+	kref_put(&wqueue->usage, __put_watch_queue);
+}
+EXPORT_SYMBOL(put_watch_queue);
+
+static void free_watch(struct rcu_head *rcu)
+{
+	struct watch *watch = container_of(rcu, struct watch, rcu);
+
+	put_watch_queue(rcu_access_pointer(watch->queue));
+	put_cred(watch->cred);
+}
+
+static void __put_watch(struct kref *kref)
+{
+	struct watch *watch = container_of(kref, struct watch, usage);
+
+	call_rcu(&watch->rcu, free_watch);
+}
+
+/*
+ * Discard a watch.
+ */
+static void put_watch(struct watch *watch)
+{
+	kref_put(&watch->usage, __put_watch);
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
+	kref_init(&watch->usage);
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
+		struct watch_queue *wq = rcu_access_pointer(w->queue);
+		if (wqueue == wq && watch->id == w->id)
+			return -EBUSY;
+	}
+
+	rcu_assign_pointer(watch->watch_list, wlist);
+	watch->cred = get_current_cred();
+
+	spin_lock_bh(&wqueue->lock);
+	kref_get(&wqueue->usage);
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
+	/* We now own the reference on watch that used to belong to wlist. */
+
+	n.type = WATCH_TYPE_META;
+	n.subtype = WATCH_META_REMOVAL_NOTIFICATION;
+	n.info = watch->info_id | sizeof(n);
+
+	wqueue = rcu_dereference(watch->queue);
+
+	/* We don't need the watch list lock for the next bit as RCU is
+	 * protecting *wqueue from deallocation.
+	 */
+	if (wqueue) {
+		post_one_notification(wqueue, &n);
+
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
+		void (*release_watch)(struct watch *);
+
+		release_watch = wlist->release_watch;
+		rcu_read_unlock();
+		(*release_watch)(watch);
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
+ * Remove all the watches that are contributory to a queue.  This has the
+ * potential to race with removal of the watches by the destruction of the
+ * objects being watched or with the distribution of notifications.
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
+		/* We now own a ref on the watch. */
+		spin_unlock_bh(&wqueue->lock);
+
+		/* We can't do the next bit under the queue lock as we need to
+		 * get the list lock - which would cause a deadlock if someone
+		 * was removing from the opposite direction at the same time or
+		 * posting a notification.
+		 */
+		wlist = rcu_dereference(watch->watch_list);
+		if (wlist) {
+			void (*release_watch)(struct watch *);
+
+			spin_lock(&wlist->lock);
+
+			release = !hlist_unhashed(&watch->list_node);
+			if (release) {
+				hlist_del_init_rcu(&watch->list_node);
+				rcu_assign_pointer(watch->watch_list, NULL);
+
+				/* We now own a second ref on the watch. */
+			}
+
+			release_watch = wlist->release_watch;
+			spin_unlock(&wlist->lock);
+
+			if (release) {
+				if (release_watch) {
+					rcu_read_unlock();
+					/* This might need to call dput(), so
+					 * we have to drop all the locks.
+					 */
+					(*release_watch)(watch);
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
+	struct watch_queue *wqueue = file->private_data;
+	int i;
+
+	watch_queue_clear(wqueue);
+
+	if (wqueue->buffer)
+		vunmap(wqueue->buffer);
+
+	for (i = 0; i < wqueue->nr_pages; i++) {
+		ClearPageUptodate(wqueue->pages[i]);
+		wqueue->pages[i]->mapping = NULL;
+		__free_page(wqueue->pages[i]);
+	}
+
+	kfree(wqueue->pages);
+	watch_queue_unaccount_mem(wqueue);
+	put_watch_queue(wqueue);
+	return 0;
+}
+
+static const struct file_operations watch_queue_fops = {
+	.owner		= THIS_MODULE,
+	.open		= watch_queue_open,
+	.release	= watch_queue_release,
+	.unlocked_ioctl	= watch_queue_ioctl,
+	.poll		= watch_queue_poll,
+	.mmap		= watch_queue_mmap,
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
+			kref_get(&wqueue->usage);
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
+builtin_misc_device(watch_queue_dev);
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
new file mode 100644
index 000000000000..aa9b251a469c
--- /dev/null
+++ b/include/linux/watch_queue.h
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/* User-mappable watch queue
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * See Documentation/watch_queue.rst
+ */
+
+#ifndef _LINUX_WATCH_QUEUE_H
+#define _LINUX_WATCH_QUEUE_H
+
+#include <uapi/linux/watch_queue.h>
+#include <linux/kref.h>
+#include <linux/rcupdate.h>
+
+#ifdef CONFIG_WATCH_QUEUE
+
+struct watch_queue;
+struct cred;
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
+	const struct cred	*cred;		/* Creds of the owner of the watch */
+	void			*private;	/* Private data for the watched object */
+	u64			id;		/* Internal identifier */
+	struct kref		usage;		/* Object usage count */
+};
+
+/*
+ * List of watches on an object.
+ */
+struct watch_list {
+	struct rcu_head		rcu;
+	struct hlist_head	watchers;
+	void (*release_watch)(struct watch *);
+	spinlock_t		lock;
+};
+
+extern void __post_watch_notification(struct watch_list *,
+				      struct watch_notification *,
+				      const struct cred *,
+				      u64);
+extern struct watch_queue *get_watch_queue(int);
+extern void put_watch_queue(struct watch_queue *);
+extern void init_watch(struct watch *, struct watch_queue *);
+extern int add_watch_to_object(struct watch *, struct watch_list *);
+extern int remove_watch_from_object(struct watch_list *, struct watch_queue *, u64, bool);
+
+static inline void init_watch_list(struct watch_list *wlist,
+				   void (*release_watch)(struct watch *))
+{
+	INIT_HLIST_HEAD(&wlist->watchers);
+	spin_lock_init(&wlist->lock);
+	wlist->release_watch = release_watch;
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
+/**
+ * watch_sizeof - Calculate the information part of the size of a watch record,
+ * given the structure size.
+ */
+#define watch_sizeof(STRUCT) \
+	((sizeof(STRUCT) / WATCH_LENGTH_GRANULARITY) << WATCH_INFO_LENGTH__SHIFT)
+
+#endif
+
+#endif /* _LINUX_WATCH_QUEUE_H */
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 70f575099968..eabd7601ba0a 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -3,6 +3,10 @@
 #define _UAPI_LINUX_WATCH_QUEUE_H
 
 #include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define IOC_WATCH_QUEUE_SET_SIZE	_IO('W', 0x60)	/* Set the size in pages */
+#define IOC_WATCH_QUEUE_SET_FILTER	_IO('W', 0x61)	/* Set the filter */
 
 enum watch_notification_type {
 	WATCH_TYPE_META		= 0,	/* Special record */
@@ -64,4 +68,21 @@ struct watch_queue_buffer {
  */
 #define WATCH_INFO_NOTIFICATIONS_LOST WATCH_INFO_FLAG_0
 
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
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */

