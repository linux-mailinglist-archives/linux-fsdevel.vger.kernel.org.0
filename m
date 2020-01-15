Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA813C2F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAONbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:31:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20766 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729162AbgAONbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579095091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Op7gPMciTnbUrmfO4XOhAB0VXk4GDXxHz5ne9DQCyrY=;
        b=QQdx7KWQyciagArM5oNyW6JsJ3c1ZYdsBGccVob0yUPYTQMVP79p1+YGCW5cWVlRsr6k1f
        5frZ98czlsPYlQWo9Q5sZ2xwDCQ2p8pucMlelkhJSTCRrv2dJVzi7x/LK3+yV6Gzn0GE5S
        p0pBJaEmXmRJ2I7Tx9WRhviPM9BDHGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-e4fKJjB6P9m_E0Cz-9UnxQ-1; Wed, 15 Jan 2020 08:31:27 -0500
X-MC-Unique: e4fKJjB6P9m_E0Cz-9UnxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 830F41800D48;
        Wed, 15 Jan 2020 13:31:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3195B5C3F8;
        Wed, 15 Jan 2020 13:31:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 05/14] pipe: Add general notification queue support [ver
 #3]
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
Date:   Wed, 15 Jan 2020 13:31:20 +0000
Message-ID: <157909508046.20155.15948272289530644703.stgit@warthog.procyon.org.uk>
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

Make it possible to have a general notification queue built on top of a
standard pipe.  Notifications are 'spliced' into the pipe and then read
out.  splice(), vmsplice() and sendfile() are forbidden on pipes used for
notifications as post_one_notification() cannot take pipe->mutex.  This
means that notifications could be posted in between individual pipe
buffers, making iov_iter_revert() difficult to effect.

The way the notification queue is used is:

 (1) An application opens a pipe with a special flag and indicates the
     number of messages it wishes to be able to queue at once (this can
     only be set once):

	pipe2(fds, O_NOTIFICATION_PIPE);
	ioctl(fds[0], IOC_WATCH_QUEUE_SET_SIZE, queue_depth);

 (2) The application then uses poll() and read() as normal to extract data
     from the pipe.  read() will return multiple notifications if the
     buffer is big enough, but it will not split a notification across
     buffers - rather it will return a short read or EMSGSIZE.

     Notification messages include a length in the header so that the
     caller can split them up.

Each message has a header that describes it:

	struct watch_notification {
		__u32	type:24;
		__u32	subtype:8;
		__u32	info;
	};

The type indicates the source (eg. mount tree changes, superblock events,
keyring changes, block layer events) and the subtype indicates the event
type (eg. mount, unmount; EIO, EDQUOT; link, unlink).  The info field
indicates a number of things, including the entry length, an ID assigned to
a watchpoint contributing to this buffer and type-specific flags.

Supplementary data, such as the key ID that generated an event, can be
attached in additional slots.  The maximum message size is 127 bytes.
Messages may not be padded or aligned, so there is no guarantee, for
example, that the notification type will be on a 4-byte bounary.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 
 Documentation/watch_queue.rst                      |  354 +++++++++++
 fs/pipe.c                                          |  206 ++++--
 fs/splice.c                                        |   12 
 include/linux/pipe_fs_i.h                          |   19 +
 include/linux/watch_queue.h                        |  127 ++++
 include/uapi/linux/watch_queue.h                   |   20 +
 init/Kconfig                                       |   12 
 kernel/Makefile                                    |    1 
 kernel/watch_queue.c                               |  657 ++++++++++++++++++++
 10 files changed, 1333 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/watch_queue.rst
 create mode 100644 include/linux/watch_queue.h
 create mode 100644 kernel/watch_queue.c

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 4ef86433bd67..dbdc1ccbe949 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -202,6 +202,7 @@ Code  Seq#    Include File                                           Comments
 'W'   00-1F  linux/wanrouter.h                                       conflict! (pre 3.9)
 'W'   00-3F  sound/asound.h                                          conflict!
 'W'   40-5F  drivers/pci/switch/switchtec.c
+'W'   60-61  linux/watch_queue.h
 'X'   all    fs/xfs/xfs_fs.h,                                        conflict!
              fs/xfs/linux-2.6/xfs_ioctl32.h,
              include/linux/falloc.h,
diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
new file mode 100644
index 000000000000..d8f70282d247
--- /dev/null
+++ b/Documentation/watch_queue.rst
@@ -0,0 +1,354 @@
+==============================
+General notification mechanism
+==============================
+
+The general notification mechanism is built on top of the standard pipe driver
+whereby it effectively splices notification messages from the kernel into pipes
+opened by userspace.  This can be used in conjunction with::
+
+  * Key/keyring notifications
+
+  * General device event notifications
+
+
+The notifications buffers can be enabled by:
+
+	"General setup"/"General notification queue"
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
+This facility appears as a pipe that is opened in a special mode.  The pipe's
+internal ring buffer is used to hold messages that are generated by the kernel.
+These messages are then read out by read().  Splice and similar are disabled on
+such pipes due to them wanting to, under some circumstances, revert their
+additions to the ring - which might end up interleaved with notification
+messages.
+
+The owner of the pipe has to tell the kernel which sources it would like to
+watch through that pipe.  Only sources that have been connected to a pipe will
+insert messages into it.  Note that a source may be bound to multiple pipes and
+insert messages into all of them simultaneously.
+
+Filters may also be emplaced on a pipe so that certain source types and
+subevents can be ignored if they're not of interest.
+
+A message will be discarded if there isn't a slot available in the ring or if
+no preallocated message buffer is available.  In both of these cases, read()
+will insert a WATCH_META_LOSS_NOTIFICATION message into the output buffer after
+the last message currently in the buffer has been read.
+
+Note that when producing a notification, the kernel does not wait for the
+consumers to collect it, but rather just continues on.  This means that
+notifications can be generated whilst spinlocks are held and also protects the
+kernel from being held up indefinitely by a userspace malfunction.
+
+
+Message Structure
+=================
+
+Notification messages begin with a short header::
+
+	struct watch_notification {
+		__u32	type:24;
+		__u32	subtype:8;
+		__u32	info;
+	};
+
+"type" indicates the source of the notification record and "subtype" indicates
+the type of record from that source (see the Watch Sources section below).  The
+type may also be "WATCH_TYPE_META".  This is a special record type generated
+internally by the watch queue itself.  There are two subtypes:
+
+  * WATCH_META_REMOVAL_NOTIFICATION
+  * WATCH_META_LOSS_NOTIFICATION
+
+The first indicates that an object on which a watch was installed was removed
+or destroyed and the second indicates that some messages have been lost.
+
+"info" indicates a bunch of things, including:
+
+  * The length of the message in bytes, including the header (mask with
+    WATCH_INFO_LENGTH and shift by WATCH_INFO_LENGTH__SHIFT).  This indicates
+    the size of the record, which may be between 8 and 127 bytes.
+
+  * The watch ID (mask with WATCH_INFO_ID and shift by WATCH_INFO_ID__SHIFT).
+    This indicates that caller's ID of the watch, which may be between 0
+    and 255.  Multiple watches may share a queue, and this provides a means to
+    distinguish them.
+
+  * A type-specific field (WATCH_INFO_TYPE_INFO).  This is set by the
+    notification producer to indicate some meaning specific to the type and
+    subtype.
+
+Everything in info apart from the length can be used for filtering.
+
+The header can be followed by supplementary information.  The format of this is
+at the discretion is defined by the type and subtype.
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
+Watch Queue (Notification Output) API
+=====================================
+
+A "watch queue" is the buffer allocated by an application that notification
+records will be written into.  The workings of this are hidden entirely inside
+of the watch_queue device driver, but it is necessary to gain a reference to it
+to set a watch.  These can be managed with:
+
+  * ``struct watch_queue *get_watch_queue(int fd);``
+
+    Since watch queues are indicated to the kernel by the fd of the pipe that
+    implements the buffer, userspace must hand that fd through a system call.
+    This can be used to look up an opaque pointer to the watch queue from the
+    system call.
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
+Userspace Code Example
+======================
+
+A buffer is created with something like the following::
+
+	pipe2(fds, O_TMPFILE);
+	ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);
+
+It can then be set to receive keyring change notifications and device event
+notifications::
+
+	keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fds[1], 0x01);
+	watch_devices(fds[1], 0x2);
+
+The notifications can then be consumed by something like the following::
+
+	static void consumer(int rfd, struct watch_queue_buffer *buf)
+	{
+		unsigned char buffer[128];
+		ssize_t buf_len;
+
+		while (buf_len = read(rfd, buffer, sizeof(buffer)),
+		       buf_len > 0
+		       ) {
+			void *p = buffer;
+			void *end = buffer + buf_len;
+			while (p < end) {
+				union {
+					struct watch_notification n;
+					unsigned char buf1[128];
+				} n;
+				size_t largest, len;
+
+				largest = end - p;
+				if (largest > 128)
+					largest = 128;
+				memcpy(&n, p, largest);
+
+				len = (n->info & WATCH_INFO_LENGTH) >>
+					WATCH_INFO_LENGTH__SHIFT;
+				if (len == 0 || len > largest)
+					return;
+
+				switch (n.n.type) {
+				case WATCH_TYPE_META:
+					got_meta(&n.n);
+				case WATCH_TYPE_KEY_NOTIFY:
+					saw_key_change(&n.n);
+					break;
+				case WATCH_TYPE_BLOCK_NOTIFY:
+					saw_block_event(&n.n);
+					break;
+				case WATCH_TYPE_USB_NOTIFY:
+					saw_usb_event(&n.n);
+					break;
+				}
+
+				p += len;
+			}
+		}
+	}
diff --git a/fs/pipe.c b/fs/pipe.c
index 57502c3c0fba..5352c07be47f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -24,6 +24,7 @@
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
 #include <linux/memcontrol.h>
+#include <linux/watch_queue.h>
 
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
@@ -450,6 +451,13 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
+#ifdef CONFIG_WATCH_QUEUE
+	if (pipe->watch_queue) {
+		ret = -EXDEV;
+		goto out;
+	}
+#endif
+
 	/*
 	 * Only wake up if the pipe started out empty, since
 	 * otherwise there should be no readers waiting.
@@ -614,22 +622,37 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	int count, head, tail, mask;
 
 	switch (cmd) {
-		case FIONREAD:
-			__pipe_lock(pipe);
-			count = 0;
-			head = pipe->head;
-			tail = pipe->tail;
-			mask = pipe->ring_size - 1;
+	case FIONREAD:
+		__pipe_lock(pipe);
+		count = 0;
+		head = pipe->head;
+		tail = pipe->tail;
+		mask = pipe->ring_size - 1;
 
-			while (tail != head) {
-				count += pipe->bufs[tail & mask].len;
-				tail++;
-			}
-			__pipe_unlock(pipe);
+		while (tail != head) {
+			count += pipe->bufs[tail & mask].len;
+			tail++;
+		}
+		__pipe_unlock(pipe);
 
-			return put_user(count, (int __user *)arg);
-		default:
-			return -ENOIOCTLCMD;
+		return put_user(count, (int __user *)arg);
+
+#ifdef CONFIG_WATCH_QUEUE
+	case IOC_WATCH_QUEUE_SET_SIZE: {
+		int ret;
+		__pipe_lock(pipe);
+		ret = watch_queue_set_size(pipe, arg);
+		__pipe_unlock(pipe);
+		return ret;
+	}
+
+	case IOC_WATCH_QUEUE_SET_FILTER:
+		return watch_queue_set_filter(
+			pipe, (struct watch_notification_filter __user *)arg);
+#endif
+
+	default:
+		return -ENOIOCTLCMD;
 	}
 }
 
@@ -735,27 +758,27 @@ pipe_fasync(int fd, struct file *filp, int on)
 	return retval;
 }
 
-static unsigned long account_pipe_buffers(struct user_struct *user,
-                                 unsigned long old, unsigned long new)
+unsigned long account_pipe_buffers(struct user_struct *user,
+				   unsigned long old, unsigned long new)
 {
 	return atomic_long_add_return(new - old, &user->pipe_bufs);
 }
 
-static bool too_many_pipe_buffers_soft(unsigned long user_bufs)
+bool too_many_pipe_buffers_soft(unsigned long user_bufs)
 {
 	unsigned long soft_limit = READ_ONCE(pipe_user_pages_soft);
 
 	return soft_limit && user_bufs > soft_limit;
 }
 
-static bool too_many_pipe_buffers_hard(unsigned long user_bufs)
+bool too_many_pipe_buffers_hard(unsigned long user_bufs)
 {
 	unsigned long hard_limit = READ_ONCE(pipe_user_pages_hard);
 
 	return hard_limit && user_bufs > hard_limit;
 }
 
-static bool is_unprivileged_user(void)
+bool pipe_is_unprivileged_user(void)
 {
 	return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
 }
@@ -777,12 +800,12 @@ struct pipe_inode_info *alloc_pipe_info(void)
 
 	user_bufs = account_pipe_buffers(user, 0, pipe_bufs);
 
-	if (too_many_pipe_buffers_soft(user_bufs) && is_unprivileged_user()) {
+	if (too_many_pipe_buffers_soft(user_bufs) && pipe_is_unprivileged_user()) {
 		user_bufs = account_pipe_buffers(user, pipe_bufs, 1);
 		pipe_bufs = 1;
 	}
 
-	if (too_many_pipe_buffers_hard(user_bufs) && is_unprivileged_user())
+	if (too_many_pipe_buffers_hard(user_bufs) && pipe_is_unprivileged_user())
 		goto out_revert_acct;
 
 	pipe->bufs = kcalloc(pipe_bufs, sizeof(struct pipe_buffer),
@@ -793,6 +816,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
 		pipe->r_counter = pipe->w_counter = 1;
 		pipe->max_usage = pipe_bufs;
 		pipe->ring_size = pipe_bufs;
+		pipe->nr_accounted = pipe_bufs;
 		pipe->user = user;
 		mutex_init(&pipe->mutex);
 		return pipe;
@@ -810,7 +834,14 @@ void free_pipe_info(struct pipe_inode_info *pipe)
 {
 	int i;
 
-	(void) account_pipe_buffers(pipe->user, pipe->ring_size, 0);
+#ifdef CONFIG_WATCH_QUEUE
+	if (pipe->watch_queue) {
+		watch_queue_clear(pipe->watch_queue);
+		put_watch_queue(pipe->watch_queue);
+	}
+#endif
+
+	(void) account_pipe_buffers(pipe->user, pipe->nr_accounted, 0);
 	free_uid(pipe->user);
 	for (i = 0; i < pipe->ring_size; i++) {
 		struct pipe_buffer *buf = pipe->bufs + i;
@@ -886,6 +917,17 @@ int create_pipe_files(struct file **res, int flags)
 	if (!inode)
 		return -ENFILE;
 
+	if (flags & O_NOTIFICATION_PIPE) {
+#ifdef CONFIG_WATCH_QUEUE
+		if (watch_queue_init(inode->i_pipe) < 0) {
+			iput(inode);
+			return -ENOMEM;
+		}
+#else
+		return -ENOPKG;
+#endif
+	}
+
 	f = alloc_file_pseudo(inode, pipe_mnt, "",
 				O_WRONLY | (flags & (O_NONBLOCK | O_DIRECT)),
 				&pipefifo_fops);
@@ -916,7 +958,7 @@ static int __do_pipe_flags(int *fd, struct file **files, int flags)
 	int error;
 	int fdw, fdr;
 
-	if (flags & ~(O_CLOEXEC | O_NONBLOCK | O_DIRECT))
+	if (flags & ~(O_CLOEXEC | O_NONBLOCK | O_DIRECT | O_NOTIFICATION_PIPE))
 		return -EINVAL;
 
 	error = create_pipe_files(files, flags);
@@ -1163,42 +1205,12 @@ unsigned int round_pipe_size(unsigned long size)
 }
 
 /*
- * Allocate a new array of pipe buffers and copy the info over. Returns the
- * pipe size if successful, or return -ERROR on error.
+ * Resize the pipe ring to a number of slots.
  */
-static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
+int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 {
 	struct pipe_buffer *bufs;
-	unsigned int size, nr_slots, head, tail, mask, n;
-	unsigned long user_bufs;
-	long ret = 0;
-
-	size = round_pipe_size(arg);
-	nr_slots = size >> PAGE_SHIFT;
-
-	if (!nr_slots)
-		return -EINVAL;
-
-	/*
-	 * If trying to increase the pipe capacity, check that an
-	 * unprivileged user is not trying to exceed various limits
-	 * (soft limit check here, hard limit check just below).
-	 * Decreasing the pipe capacity is always permitted, even
-	 * if the user is currently over a limit.
-	 */
-	if (nr_slots > pipe->ring_size &&
-			size > pipe_max_size && !capable(CAP_SYS_RESOURCE))
-		return -EPERM;
-
-	user_bufs = account_pipe_buffers(pipe->user, pipe->ring_size, nr_slots);
-
-	if (nr_slots > pipe->ring_size &&
-			(too_many_pipe_buffers_hard(user_bufs) ||
-			 too_many_pipe_buffers_soft(user_bufs)) &&
-			is_unprivileged_user()) {
-		ret = -EPERM;
-		goto out_revert_acct;
-	}
+	unsigned int head, tail, mask, n;
 
 	/*
 	 * We can shrink the pipe, if arg is greater than the ring occupancy.
@@ -1210,17 +1222,13 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	head = pipe->head;
 	tail = pipe->tail;
 	n = pipe_occupancy(pipe->head, pipe->tail);
-	if (nr_slots < n) {
-		ret = -EBUSY;
-		goto out_revert_acct;
-	}
+	if (nr_slots < n)
+		return -EBUSY;
 
 	bufs = kcalloc(nr_slots, sizeof(*bufs),
 		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
-	if (unlikely(!bufs)) {
-		ret = -ENOMEM;
-		goto out_revert_acct;
-	}
+	if (unlikely(!bufs))
+		return -ENOMEM;
 
 	/*
 	 * The pipe array wraps around, so just start the new one at zero
@@ -1248,14 +1256,66 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	kfree(pipe->bufs);
 	pipe->bufs = bufs;
 	pipe->ring_size = nr_slots;
-	pipe->max_usage = nr_slots;
+	if (pipe->max_usage > nr_slots)
+		pipe->max_usage = nr_slots;
 	pipe->tail = tail;
 	pipe->head = head;
 	wake_up_interruptible_all(&pipe->wait);
+	return 0;
+}
+
+/*
+ * Allocate a new array of pipe buffers and copy the info over. Returns the
+ * pipe size if successful, or return -ERROR on error.
+ */
+static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
+{
+	unsigned long user_bufs;
+	unsigned int nr_slots, size;
+	long ret = 0;
+
+#ifdef CONFIG_WATCH_QUEUE
+	if (pipe->watch_queue)
+		return -EBUSY;
+#endif
+
+	size = round_pipe_size(arg);
+	nr_slots = size >> PAGE_SHIFT;
+
+	if (!nr_slots)
+		return -EINVAL;
+
+	/*
+	 * If trying to increase the pipe capacity, check that an
+	 * unprivileged user is not trying to exceed various limits
+	 * (soft limit check here, hard limit check just below).
+	 * Decreasing the pipe capacity is always permitted, even
+	 * if the user is currently over a limit.
+	 */
+	if (nr_slots > pipe->max_usage &&
+			size > pipe_max_size && !capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+
+	user_bufs = account_pipe_buffers(pipe->user, pipe->nr_accounted, nr_slots);
+
+	if (nr_slots > pipe->max_usage &&
+			(too_many_pipe_buffers_hard(user_bufs) ||
+			 too_many_pipe_buffers_soft(user_bufs)) &&
+			pipe_is_unprivileged_user()) {
+		ret = -EPERM;
+		goto out_revert_acct;
+	}
+
+	ret = pipe_resize_ring(pipe, nr_slots);
+	if (ret < 0)
+		goto out_revert_acct;
+
+	pipe->max_usage = nr_slots;
+	pipe->nr_accounted = nr_slots;
 	return pipe->max_usage * PAGE_SIZE;
 
 out_revert_acct:
-	(void) account_pipe_buffers(pipe->user, nr_slots, pipe->ring_size);
+	(void) account_pipe_buffers(pipe->user, nr_slots, pipe->nr_accounted);
 	return ret;
 }
 
@@ -1264,9 +1324,17 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
  * location, so checking ->i_pipe is not enough to verify that this is a
  * pipe.
  */
-struct pipe_inode_info *get_pipe_info(struct file *file)
+struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice)
 {
-	return file->f_op == &pipefifo_fops ? file->private_data : NULL;
+	struct pipe_inode_info *pipe = file->private_data;
+
+	if (file->f_op != &pipefifo_fops || !pipe)
+		return NULL;
+#ifdef CONFIG_WATCH_QUEUE
+	if (for_splice && pipe->watch_queue)
+		return NULL;
+#endif
+	return pipe;
 }
 
 long pipe_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -1274,7 +1342,7 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct pipe_inode_info *pipe;
 	long ret;
 
-	pipe = get_pipe_info(file);
+	pipe = get_pipe_info(file, false);
 	if (!pipe)
 		return -EBADF;
 
diff --git a/fs/splice.c b/fs/splice.c
index 3009652a41c8..44a999d30f3f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1118,8 +1118,8 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 	loff_t offset;
 	long ret;
 
-	ipipe = get_pipe_info(in);
-	opipe = get_pipe_info(out);
+	ipipe = get_pipe_info(in, true);
+	opipe = get_pipe_info(out, true);
 
 	if (ipipe && opipe) {
 		if (off_in || off_out)
@@ -1278,7 +1278,7 @@ static int pipe_to_user(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 static long vmsplice_to_user(struct file *file, struct iov_iter *iter,
 			     unsigned int flags)
 {
-	struct pipe_inode_info *pipe = get_pipe_info(file);
+	struct pipe_inode_info *pipe = get_pipe_info(file, true);
 	struct splice_desc sd = {
 		.total_len = iov_iter_count(iter),
 		.flags = flags,
@@ -1313,7 +1313,7 @@ static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 	if (flags & SPLICE_F_GIFT)
 		buf_flag = PIPE_BUF_FLAG_GIFT;
 
-	pipe = get_pipe_info(file);
+	pipe = get_pipe_info(file, true);
 	if (!pipe)
 		return -EBADF;
 
@@ -1766,8 +1766,8 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 static long do_tee(struct file *in, struct file *out, size_t len,
 		   unsigned int flags)
 {
-	struct pipe_inode_info *ipipe = get_pipe_info(in);
-	struct pipe_inode_info *opipe = get_pipe_info(out);
+	struct pipe_inode_info *ipipe = get_pipe_info(in, true);
+	struct pipe_inode_info *opipe = get_pipe_info(out, true);
 	int ret = -EINVAL;
 
 	/*
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index dbcfa6892384..cef70acd99bf 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -34,6 +34,7 @@ struct pipe_buffer {
  *	@tail: The point of buffer consumption
  *	@max_usage: The maximum number of slots that may be used in the ring
  *	@ring_size: total number of buffers (should be a power of 2)
+ *	@nr_accounted: The amount this pipe accounts for in user->pipe_bufs
  *	@tmp_page: cached released page
  *	@readers: number of current readers of this pipe
  *	@writers: number of current writers of this pipe
@@ -44,6 +45,7 @@ struct pipe_buffer {
  *	@fasync_writers: writer side fasync
  *	@bufs: the circular array of pipe buffers
  *	@user: the user who created this pipe
+ *	@watch_queue: If this pipe is a watch_queue, this is the stuff for that
  **/
 struct pipe_inode_info {
 	struct mutex mutex;
@@ -52,6 +54,7 @@ struct pipe_inode_info {
 	unsigned int tail;
 	unsigned int max_usage;
 	unsigned int ring_size;
+	unsigned int nr_accounted;
 	unsigned int readers;
 	unsigned int writers;
 	unsigned int files;
@@ -62,6 +65,9 @@ struct pipe_inode_info {
 	struct fasync_struct *fasync_writers;
 	struct pipe_buffer *bufs;
 	struct user_struct *user;
+#ifdef CONFIG_WATCH_QUEUE
+	struct watch_queue *watch_queue;
+#endif
 };
 
 /*
@@ -236,9 +242,20 @@ void pipe_buf_mark_unmergeable(struct pipe_buffer *buf);
 
 extern const struct pipe_buf_operations nosteal_pipe_buf_ops;
 
+#ifdef CONFIG_WATCH_QUEUE
+unsigned long account_pipe_buffers(struct user_struct *user,
+				   unsigned long old, unsigned long new);
+bool too_many_pipe_buffers_soft(unsigned long user_bufs);
+bool too_many_pipe_buffers_hard(unsigned long user_bufs);
+bool pipe_is_unprivileged_user(void);
+#endif
+
 /* for F_SETPIPE_SZ and F_GETPIPE_SZ */
+#ifdef CONFIG_WATCH_QUEUE
+int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots);
+#endif
 long pipe_fcntl(struct file *, unsigned int, unsigned long arg);
-struct pipe_inode_info *get_pipe_info(struct file *file);
+struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice);
 
 int create_pipe_files(struct file **, int);
 unsigned int round_pipe_size(unsigned long size);
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
new file mode 100644
index 000000000000..5e08db2adc31
--- /dev/null
+++ b/include/linux/watch_queue.h
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/* User-mappable watch queue
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
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
+struct cred;
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
+	u32			nr_filters;	/* Number of filters */
+	struct watch_type_filter filters[];
+};
+
+struct watch_queue {
+	struct rcu_head		rcu;
+	struct watch_filter __rcu *filter;
+	struct pipe_inode_info	*pipe;		/* The pipe we're using as a buffer */
+	struct hlist_head	watches;	/* Contributory watches */
+	struct page		**notes;	/* Preallocated notifications */
+	unsigned long		*notes_bitmap;	/* Allocation bitmap for notes */
+	struct kref		usage;		/* Object usage count */
+	spinlock_t		lock;
+	unsigned int		nr_notes;	/* Number of notes */
+	unsigned int		nr_pages;	/* Number of pages in notes[] */
+	bool			defunct;	/* T when queues closed */
+};
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
+extern long watch_queue_set_size(struct pipe_inode_info *, unsigned int);
+extern long watch_queue_set_filter(struct pipe_inode_info *,
+				   struct watch_notification_filter __user *);
+extern int watch_queue_init(struct pipe_inode_info *);
+extern void watch_queue_clear(struct watch_queue *);
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
+static inline void remove_watch_list(struct watch_list *wlist, u64 id)
+{
+	if (wlist) {
+		remove_watch_from_object(wlist, NULL, id, true);
+		kfree_rcu(wlist, rcu);
+	}
+}
+
+/**
+ * watch_sizeof - Calculate the information part of the size of a watch record,
+ * given the structure size.
+ */
+#define watch_sizeof(STRUCT) (sizeof(STRUCT) << WATCH_INFO_LENGTH__SHIFT)
+
+#endif
+
+#endif /* _LINUX_WATCH_QUEUE_H */
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 9df72227f515..3a5790f1f05d 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -4,9 +4,13 @@
 
 #include <linux/types.h>
 #include <linux/fcntl.h>
+#include <linux/ioctl.h>
 
 #define O_NOTIFICATION_PIPE	O_EXCL	/* Parameter to pipe2() selecting notification pipe */
 
+#define IOC_WATCH_QUEUE_SET_SIZE	_IO('W', 0x60)	/* Set the size in pages */
+#define IOC_WATCH_QUEUE_SET_FILTER	_IO('W', 0x61)	/* Set the filter */
+
 enum watch_notification_type {
 	WATCH_TYPE_META		= 0,	/* Special record */
 	WATCH_TYPE__NR		= 1
@@ -41,6 +45,22 @@ struct watch_notification {
 #define WATCH_INFO_FLAG_7	0x00800000
 };
 
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
 
 /*
  * Extended watch removal notification.  This is used optionally if the type
diff --git a/init/Kconfig b/init/Kconfig
index a34064a031a5..53cdcc25c920 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -338,6 +338,18 @@ config POSIX_MQUEUE_SYSCTL
 	depends on SYSCTL
 	default y
 
+config WATCH_QUEUE
+	bool "General notification queue"
+	default n
+	help
+
+	  This is a general notification queue for the kernel to pass events to
+	  userspace by splicing them into pipes.  It can be used in conjunction
+	  with watches for key/keyring change notifications and device
+	  notifications.
+
+	  See Documentation/watch_queue.rst
+
 config CROSS_MEMORY_ATTACH
 	bool "Enable process_vm_readv/writev syscalls"
 	depends on MMU
diff --git a/kernel/Makefile b/kernel/Makefile
index f2cc0d118a0b..06d5255784b4 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -114,6 +114,7 @@ obj-$(CONFIG_TORTURE_TEST) += torture.o
 
 obj-$(CONFIG_HAS_IOMEM) += iomem.o
 obj-$(CONFIG_RSEQ) += rseq.o
+obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
 
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
new file mode 100644
index 000000000000..e2e3344a2586
--- /dev/null
+++ b/kernel/watch_queue.c
@@ -0,0 +1,657 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Watch queue and general notification mechanism, built on pipes
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
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
+#include <linux/pipe_fs_i.h>
+
+MODULE_DESCRIPTION("Watch queue");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+#define WATCH_QUEUE_NOTE_SIZE 128
+#define WATCH_QUEUE_NOTES_PER_PAGE (PAGE_SIZE / WATCH_QUEUE_NOTE_SIZE)
+
+static void watch_queue_pipe_buf_release(struct pipe_inode_info *pipe,
+					 struct pipe_buffer *buf)
+{
+	struct watch_queue *wqueue = (struct watch_queue *)buf->private;
+	struct page *page;
+	unsigned int bit;
+
+	/* We need to work out which note within the page this refers to, but
+	 * the note might have been maximum size, so merely ANDing the offset
+	 * off doesn't work.  OTOH, the note must've been more than zero size.
+	 */
+	bit = buf->offset + buf->len;
+	if ((bit & (WATCH_QUEUE_NOTE_SIZE - 1)) == 0)
+		bit -= WATCH_QUEUE_NOTE_SIZE;
+	bit /= WATCH_QUEUE_NOTE_SIZE;
+
+	page = buf->page;
+	bit += page->index;
+
+	set_bit(bit, wqueue->notes_bitmap);
+}
+
+static int watch_queue_pipe_buf_steal(struct pipe_inode_info *pipe,
+				      struct pipe_buffer *buf)
+{
+	return -1; /* No. */
+}
+
+/* New data written to a pipe may be appended to a buffer with this type. */
+static const struct pipe_buf_operations watch_queue_pipe_buf_ops = {
+	.confirm	= generic_pipe_buf_confirm,
+	.release	= watch_queue_pipe_buf_release,
+	.steal		= watch_queue_pipe_buf_steal,
+	.get		= generic_pipe_buf_get,
+};
+
+/*
+ * Post a notification to a watch queue.
+ */
+static bool post_one_notification(struct watch_queue *wqueue,
+				  struct watch_notification *n)
+{
+	void *p;
+	struct pipe_inode_info *pipe = wqueue->pipe;
+	struct pipe_buffer *buf;
+	struct page *page;
+	unsigned int head, tail, mask, note, offset, len;
+	bool done = false;
+
+	if (!pipe)
+		return false;
+
+	spin_lock_irq(&pipe->wait.lock);
+
+	if (wqueue->defunct)
+		goto out;
+
+	mask = pipe->ring_size - 1;
+	head = pipe->head;
+	tail = pipe->tail;
+	if (pipe_full(head, tail, pipe->ring_size))
+		goto lost;
+
+	note = find_first_bit(wqueue->notes_bitmap, wqueue->nr_notes);
+	if (note >= wqueue->nr_notes)
+		goto lost;
+
+	page = wqueue->notes[note / WATCH_QUEUE_NOTES_PER_PAGE];
+	offset = note % WATCH_QUEUE_NOTES_PER_PAGE * WATCH_QUEUE_NOTE_SIZE;
+	get_page(page);
+	len = n->info & WATCH_INFO_LENGTH;
+	p = kmap_atomic(page);
+	memcpy(p + offset, n, len);
+	kunmap_atomic(p);
+
+	buf = &pipe->bufs[head & mask];
+	buf->page = page;
+	buf->private = (unsigned long)wqueue;
+	buf->ops = &watch_queue_pipe_buf_ops;
+	buf->offset = offset;
+	buf->len = len;
+	buf->flags = 0;
+	pipe->head = head + 1;
+
+	if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
+		spin_unlock_irq(&pipe->wait.lock);
+		BUG();
+	}
+	wake_up_interruptible_sync_poll_locked(&pipe->wait, EPOLLIN | EPOLLRDNORM);
+	done = true;
+
+out:
+	spin_unlock_irq(&pipe->wait.lock);
+	if (done)
+		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
+	return done;
+
+lost:
+	goto out;
+}
+
+/*
+ * Apply filter rules to a notification.
+ */
+static bool filter_watch_notification(const struct watch_filter *wf,
+				      const struct watch_notification *n)
+{
+	const struct watch_type_filter *wt;
+	unsigned int st_bits = sizeof(wt->subtype_filter[0]) * 8;
+	unsigned int st_index = n->subtype / st_bits;
+	unsigned int st_bit = 1U << (n->subtype % st_bits);
+	int i;
+
+	if (!test_bit(n->type, wf->type_filter))
+		return false;
+
+	for (i = 0; i < wf->nr_filters; i++) {
+		wt = &wf->filters[i];
+		if (n->type == wt->type &&
+		    (wt->subtype_filter[st_index] & st_bit) &&
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
+ * Allocate sufficient pages to preallocation for the requested number of
+ * notifications.
+ */
+long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
+{
+	struct watch_queue *wqueue = pipe->watch_queue;
+	struct page **pages;
+	unsigned long *bitmap;
+	unsigned long user_bufs;
+	unsigned int bmsize;
+	int ret, i, nr_pages;
+
+	if (!wqueue)
+		return -ENODEV;
+	if (wqueue->notes)
+		return -EBUSY;
+
+	if (nr_notes < 1 ||
+	    nr_notes > 512) /* TODO: choose a better hard limit */
+		return -EINVAL;
+
+	nr_pages = (nr_notes + WATCH_QUEUE_NOTES_PER_PAGE - 1);
+	nr_pages /= WATCH_QUEUE_NOTES_PER_PAGE;
+	user_bufs = account_pipe_buffers(pipe->user, pipe->nr_accounted, nr_pages);
+
+	if (nr_pages > pipe->max_usage &&
+	    (too_many_pipe_buffers_hard(user_bufs) ||
+	     too_many_pipe_buffers_soft(user_bufs)) &&
+	    pipe_is_unprivileged_user()) {
+		ret = -EPERM;
+		goto error;
+	}
+
+	ret = pipe_resize_ring(pipe, nr_notes);
+	if (ret < 0)
+		goto error;
+
+	pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
+	if (!pages)
+		goto error;
+
+	for (i = 0; i < nr_pages; i++) {
+		pages[i] = alloc_page(GFP_KERNEL);
+		if (!pages[i])
+			goto error_p;
+		pages[i]->index = i * WATCH_QUEUE_NOTES_PER_PAGE;
+	}
+
+	bmsize = (nr_notes + BITS_PER_LONG - 1) / BITS_PER_LONG;
+	bmsize *= sizeof(unsigned long);
+	bitmap = kmalloc(bmsize, GFP_KERNEL);
+	if (!bitmap)
+		goto error_p;
+
+	memset(bitmap, 0xff, bmsize);
+	wqueue->notes = pages;
+	wqueue->notes_bitmap = bitmap;
+	wqueue->nr_pages = nr_pages;
+	wqueue->nr_notes = nr_pages * WATCH_QUEUE_NOTES_PER_PAGE;
+	return 0;
+
+error_p:
+	for (i = 0; i < nr_pages; i++)
+		__free_page(pages[i]);
+	kfree(pages);
+error:
+	(void) account_pipe_buffers(pipe->user, nr_pages, pipe->nr_accounted);
+	return ret;
+}
+
+/*
+ * Set the filter on a watch queue.
+ */
+long watch_queue_set_filter(struct pipe_inode_info *pipe,
+			    struct watch_notification_filter __user *_filter)
+{
+	struct watch_notification_type_filter *tf;
+	struct watch_notification_filter filter;
+	struct watch_type_filter *q;
+	struct watch_filter *wfilter;
+	struct watch_queue *wqueue = pipe->watch_queue;
+	int ret, nr_filter = 0, i;
+
+	if (!wqueue)
+		return -ENODEV;
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
+	pipe_lock(pipe);
+	rcu_swap_protected(wqueue->filter, wfilter,
+			   lockdep_is_held(&pipe->mutex));
+	pipe_unlock(pipe);
+	if (wfilter)
+		kfree_rcu(wfilter, rcu);
+	return 0;
+
+err_filter:
+	kfree(tf);
+	return ret;
+}
+
+static void __put_watch_queue(struct kref *kref)
+{
+	struct watch_queue *wqueue =
+		container_of(kref, struct watch_queue, usage);
+	struct watch_filter *wfilter;
+	int i;
+
+	for (i = 0; i < wqueue->nr_pages; i++)
+		__free_page(wqueue->notes[i]);
+
+	wfilter = rcu_access_pointer(wqueue->filter);
+	if (wfilter)
+		kfree_rcu(wfilter, rcu);
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
+ * to and the watch list of the object to be watched.  @watch->cred must also
+ * have been set to the appropriate credentials and a ref taken on them.
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
+	watch->cred = get_current_cred();
+	rcu_assign_pointer(watch->watch_list, wlist);
+
+	spin_lock_bh(&wqueue->lock);
+	kref_get(&wqueue->usage);
+	kref_get(&watch->usage);
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
+	struct watch_notification_removal n;
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
+	n.watch.type = WATCH_TYPE_META;
+	n.watch.subtype = WATCH_META_REMOVAL_NOTIFICATION;
+	n.watch.info = watch->info_id | watch_sizeof(n.watch);
+	n.id = id;
+	if (id != 0)
+		n.watch.info = watch->info_id | watch_sizeof(n);
+
+	wqueue = rcu_dereference(watch->queue);
+
+	/* We don't need the watch list lock for the next bit as RCU is
+	 * protecting *wqueue from deallocation.
+	 */
+	if (wqueue) {
+		post_one_notification(wqueue, &n.watch);
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
+void watch_queue_clear(struct watch_queue *wqueue)
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
+/**
+ * get_watch_queue - Get a watch queue from its file descriptor.
+ * @fd: The fd to query.
+ */
+struct watch_queue *get_watch_queue(int fd)
+{
+	struct pipe_inode_info *pipe;
+	struct watch_queue *wqueue = ERR_PTR(-EINVAL);
+	struct fd f;
+
+	f = fdget(fd);
+	if (f.file) {
+		pipe = get_pipe_info(f.file, false);
+		if (pipe && pipe->watch_queue) {
+			wqueue = pipe->watch_queue;
+			kref_get(&wqueue->usage);
+		}
+		fdput(f);
+	}
+
+	return wqueue;
+}
+EXPORT_SYMBOL(get_watch_queue);
+
+/*
+ * Initialise a watch queue
+ */
+int watch_queue_init(struct pipe_inode_info *pipe)
+{
+	struct watch_queue *wqueue;
+
+	wqueue = kzalloc(sizeof(*wqueue), GFP_KERNEL);
+	if (!wqueue)
+		return -ENOMEM;
+
+	wqueue->pipe = pipe;
+	kref_init(&wqueue->usage);
+	spin_lock_init(&wqueue->lock);
+	INIT_HLIST_HEAD(&wqueue->watches);
+
+	pipe->watch_queue = wqueue;
+	return 0;
+}

