Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26246F2FA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389081AbfKGNgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:36:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26789 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729162AbfKGNgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UX3BmTraX4pHXAIUv1kzXX2Y0A8xeCGRP8BSAT+h+XI=;
        b=ODhjg/r/NQtgsCRYu8U+5WTWUzNA42zmYn52nLrj+HUUBX4IMCB8qEqNkDLmEY6KDsqU2n
        a+MtbqRO2dv+eD2Ow3tmQmOBgbPtVdaUv5Pbw2V/Zt9effwmSNKAIGkDbxdCvWoZy6dYGS
        pgKfvDkOmCojKRnY1hoKBH21/bMa8r8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-Oi0uBGIIPVmNCpT0XsTlwA-1; Thu, 07 Nov 2019 08:36:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 839C7107ACC3;
        Thu,  7 Nov 2019 13:36:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A48119488;
        Thu,  7 Nov 2019 13:36:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 05/14] pipe: Add general notification queue support [ver
 #2]
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
Date:   Thu, 07 Nov 2019 13:36:05 +0000
Message-ID: <157313376558.29677.12389078014886241663.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Oi0uBGIIPVmNCpT0XsTlwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

=09pipe2(fds, O_NOTIFICATION_PIPE);
=09ioctl(fds[0], IOC_WATCH_QUEUE_SET_SIZE, queue_depth);

 (2) The application then uses poll() and read() as normal to extract data
     from the pipe.  read() will return multiple notifications if the
     buffer is big enough, but it will not split a notification across
     buffers - rather it will return a short read or EMSGSIZE.

     Notification messages include a length in the header so that the
     caller can split them up.

Each message has a header that describes it:

=09struct watch_notification {
=09=09__u32=09type:24;
=09=09__u32=09subtype:8;
=09=09__u32=09info;
=09};

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

 Documentation/ioctl/ioctl-number.rst |    1=20
 Documentation/watch_queue.rst        |  354 ++++++++++++++++++
 fs/pipe.c                            |  193 ++++++----
 fs/splice.c                          |   12 -
 include/linux/pipe_fs_i.h            |   19 +
 include/linux/watch_queue.h          |  127 +++++++
 include/uapi/linux/watch_queue.h     |   20 +
 init/Kconfig                         |   12 +
 kernel/Makefile                      |    1=20
 kernel/watch_queue.c                 |  656 ++++++++++++++++++++++++++++++=
++++
 10 files changed, 1318 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/watch_queue.rst
 create mode 100644 include/linux/watch_queue.h
 create mode 100644 kernel/watch_queue.c

diff --git a/Documentation/ioctl/ioctl-number.rst b/Documentation/ioctl/ioc=
tl-number.rst
index bef79cd4c6b4..303fe17d871e 100644
--- a/Documentation/ioctl/ioctl-number.rst
+++ b/Documentation/ioctl/ioctl-number.rst
@@ -202,6 +202,7 @@ Code  Seq#    Include File                             =
              Comments
 'W'   00-1F  linux/wanrouter.h                                       confl=
ict! (pre 3.9)
 'W'   00-3F  sound/asound.h                                          confl=
ict!
 'W'   40-5F  drivers/pci/switch/switchtec.c
+'W'   60-61  linux/watch_queue.h
 'X'   all    fs/xfs/xfs_fs.h,                                        confl=
ict!
              fs/xfs/linux-2.6/xfs_ioctl32.h,
              include/linux/falloc.h,
diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
new file mode 100644
index 000000000000..d8f70282d247
--- /dev/null
+++ b/Documentation/watch_queue.rst
@@ -0,0 +1,354 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+General notification mechanism
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+The general notification mechanism is built on top of the standard pipe dr=
iver
+whereby it effectively splices notification messages from the kernel into =
pipes
+opened by userspace.  This can be used in conjunction with::
+
+  * Key/keyring notifications
+
+  * General device event notifications
+
+
+The notifications buffers can be enabled by:
+
+=09"General setup"/"General notification queue"
+=09(CONFIG_WATCH_QUEUE)
+
+This document has the following sections:
+
+.. contents:: :local:
+
+
+Overview
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+This facility appears as a pipe that is opened in a special mode.  The pip=
e's
+internal ring buffer is used to hold messages that are generated by the ke=
rnel.
+These messages are then read out by read().  Splice and similar are disabl=
ed on
+such pipes due to them wanting to, under some circumstances, revert their
+additions to the ring - which might end up interleaved with notification
+messages.
+
+The owner of the pipe has to tell the kernel which sources it would like t=
o
+watch through that pipe.  Only sources that have been connected to a pipe =
will
+insert messages into it.  Note that a source may be bound to multiple pipe=
s and
+insert messages into all of them simultaneously.
+
+Filters may also be emplaced on a pipe so that certain source types and
+subevents can be ignored if they're not of interest.
+
+A message will be discarded if there isn't a slot available in the ring or=
 if
+no preallocated message buffer is available.  In both of these cases, read=
()
+will insert a WATCH_META_LOSS_NOTIFICATION message into the output buffer =
after
+the last message currently in the buffer has been read.
+
+Note that when producing a notification, the kernel does not wait for the
+consumers to collect it, but rather just continues on.  This means that
+notifications can be generated whilst spinlocks are held and also protects=
 the
+kernel from being held up indefinitely by a userspace malfunction.
+
+
+Message Structure
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Notification messages begin with a short header::
+
+=09struct watch_notification {
+=09=09__u32=09type:24;
+=09=09__u32=09subtype:8;
+=09=09__u32=09info;
+=09};
+
+"type" indicates the source of the notification record and "subtype" indic=
ates
+the type of record from that source (see the Watch Sources section below).=
  The
+type may also be "WATCH_TYPE_META".  This is a special record type generat=
ed
+internally by the watch queue itself.  There are two subtypes:
+
+  * WATCH_META_REMOVAL_NOTIFICATION
+  * WATCH_META_LOSS_NOTIFICATION
+
+The first indicates that an object on which a watch was installed was remo=
ved
+or destroyed and the second indicates that some messages have been lost.
+
+"info" indicates a bunch of things, including:
+
+  * The length of the message in bytes, including the header (mask with
+    WATCH_INFO_LENGTH and shift by WATCH_INFO_LENGTH__SHIFT).  This indica=
tes
+    the size of the record, which may be between 8 and 127 bytes.
+
+  * The watch ID (mask with WATCH_INFO_ID and shift by WATCH_INFO_ID__SHIF=
T).
+    This indicates that caller's ID of the watch, which may be between 0
+    and 255.  Multiple watches may share a queue, and this provides a mean=
s to
+    distinguish them.
+
+  * A type-specific field (WATCH_INFO_TYPE_INFO).  This is set by the
+    notification producer to indicate some meaning specific to the type an=
d
+    subtype.
+
+Everything in info apart from the length can be used for filtering.
+
+The header can be followed by supplementary information.  The format of th=
is is
+at the discretion is defined by the type and subtype.
+
+
+Watch List (Notification Source) API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A "watch list" is a list of watchers that are subscribed to a source of
+notifications.  A list may be attached to an object (say a key or a superb=
lock)
+or may be global (say for device events).  From a userspace perspective, a
+non-global watch list is typically referred to by reference to the object =
it
+belongs to (such as using KEYCTL_NOTIFY and giving it a key serial number =
to
+watch that specific key).
+
+To manage a watch list, the following functions are provided:
+
+  * ``void init_watch_list(struct watch_list *wlist,
+=09=09=09   void (*release_watch)(struct watch *wlist));``
+
+    Initialise a watch list.  If ``release_watch`` is not NULL, then this
+    indicates a function that should be called when the watch_list object =
is
+    destroyed to discard any references the watch list holds on the watche=
d
+    object.
+
+  * ``void remove_watch_list(struct watch_list *wlist);``
+
+    This removes all of the watches subscribed to a watch_list and frees t=
hem
+    and then destroys the watch_list object itself.
+
+
+Watch Queue (Notification Output) API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A "watch queue" is the buffer allocated by an application that notificatio=
n
+records will be written into.  The workings of this are hidden entirely in=
side
+of the watch_queue device driver, but it is necessary to gain a reference =
to it
+to set a watch.  These can be managed with:
+
+  * ``struct watch_queue *get_watch_queue(int fd);``
+
+    Since watch queues are indicated to the kernel by the fd of the pipe t=
hat
+    implements the buffer, userspace must hand that fd through a system ca=
ll.
+    This can be used to look up an opaque pointer to the watch queue from =
the
+    system call.
+
+  * ``void put_watch_queue(struct watch_queue *wqueue);``
+
+    This discards the reference obtained from ``get_watch_queue()``.
+
+
+Watch Subscription API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A "watch" is a subscription on a watch list, indicating the watch queue, a=
nd
+thus the buffer, into which notification records should be written.  The w=
atch
+queue object may also carry filtering rules for that object, as set by
+userspace.  Some parts of the watch struct can be set by the driver::
+
+=09struct watch {
+=09=09union {
+=09=09=09u32=09=09info_id;=09/* ID to be OR'd in to info field */
+=09=09=09...
+=09=09};
+=09=09void=09=09=09*private;=09/* Private data for the watched object */
+=09=09u64=09=09=09id;=09=09/* Internal identifier */
+=09=09...
+=09};
+
+The ``info_id`` value should be an 8-bit number obtained from userspace an=
d
+shifted by WATCH_INFO_ID__SHIFT.  This is OR'd into the WATCH_INFO_ID fiel=
d of
+struct watch_notification::info when and if the notification is written in=
to
+the associated watch queue buffer.
+
+The ``private`` field is the driver's data associated with the watch_list =
and
+is cleaned up by the ``watch_list::release_watch()`` method.
+
+The ``id`` field is the source's ID.  Notifications that are posted with a
+different ID are ignored.
+
+The following functions are provided to manage watches:
+
+  * ``void init_watch(struct watch *watch, struct watch_queue *wqueue);``
+
+    Initialise a watch object, setting its pointer to the watch queue, usi=
ng
+    appropriate barriering to avoid lockdep complaints.
+
+  * ``int add_watch_to_object(struct watch *watch, struct watch_list *wlis=
t);``
+
+    Subscribe a watch to a watch list (notification source).  The
+    driver-settable fields in the watch struct must have been set before t=
his
+    is called.
+
+  * ``int remove_watch_from_object(struct watch_list *wlist,
+=09=09=09=09   struct watch_queue *wqueue,
+=09=09=09=09   u64 id, false);``
+
+    Remove a watch from a watch list, where the watch must match the speci=
fied
+    watch queue (``wqueue``) and object identifier (``id``).  A notificati=
on
+    (``WATCH_META_REMOVAL_NOTIFICATION``) is sent to the watch queue to
+    indicate that the watch got removed.
+
+  * ``int remove_watch_from_object(struct watch_list *wlist, NULL, 0, true=
);``
+
+    Remove all the watches from a watch list.  It is expected that this wi=
ll be
+    called preparatory to destruction and that the watch list will be
+    inaccessible to new watches by this point.  A notification
+    (``WATCH_META_REMOVAL_NOTIFICATION``) is sent to the watch queue of ea=
ch
+    subscribed watch to indicate that the watch got removed.
+
+
+Notification Posting API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+To post a notification to watch list so that the subscribed watches can se=
e it,
+the following function should be used::
+
+=09void post_watch_notification(struct watch_list *wlist,
+=09=09=09=09     struct watch_notification *n,
+=09=09=09=09     const struct cred *cred,
+=09=09=09=09     u64 id);
+
+The notification should be preformatted and a pointer to the header (``n``=
)
+should be passed in.  The notification may be larger than this and the siz=
e in
+units of buffer slots is noted in ``n->info & WATCH_INFO_LENGTH``.
+
+The ``cred`` struct indicates the credentials of the source (subject) and =
is
+passed to the LSMs, such as SELinux, to allow or suppress the recording of=
 the
+note in each individual queue according to the credentials of that queue
+(object).
+
+The ``id`` is the ID of the source object (such as the serial number on a =
key).
+Only watches that have the same ID set in them will see this notification.
+
+
+Watch Sources
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Any particular buffer can be fed from multiple sources.  Sources include:
+
+  * WATCH_TYPE_KEY_NOTIFY
+
+    Notifications of this type indicate changes to keys and keyrings, incl=
uding
+    the changes of keyring contents or the attributes of keys.
+
+    See Documentation/security/keys/core.rst for more information.
+
+  * WATCH_TYPE_BLOCK_NOTIFY
+
+    Notifications of this type indicate block layer events, such as I/O er=
rors
+    or temporary link loss.  Watches of this type are set on a global queu=
e.
+
+
+Event Filtering
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Once a watch queue has been created, a set of filters can be applied to li=
mit
+the events that are received using::
+
+=09struct watch_notification_filter filter =3D {
+=09=09...
+=09};
+=09ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter)
+
+The filter description is a variable of type::
+
+=09struct watch_notification_filter {
+=09=09__u32=09nr_filters;
+=09=09__u32=09__reserved;
+=09=09struct watch_notification_type_filter filters[];
+=09};
+
+Where "nr_filters" is the number of filters in filters[] and "__reserved"
+should be 0.  The "filters" array has elements of the following type::
+
+=09struct watch_notification_type_filter {
+=09=09__u32=09type;
+=09=09__u32=09info_filter;
+=09=09__u32=09info_mask;
+=09=09__u32=09subtype_filter[8];
+=09};
+
+Where:
+
+  * ``type`` is the event type to filter for and should be something like
+    "WATCH_TYPE_KEY_NOTIFY"
+
+  * ``info_filter`` and ``info_mask`` act as a filter on the info field of=
 the
+    notification record.  The notification is only written into the buffer=
 if::
+
+=09(watch.info & info_mask) =3D=3D info_filter
+
+    This could be used, for example, to ignore events that are not exactly=
 on
+    the watched point in a mount tree.
+
+  * ``subtype_filter`` is a bitmask indicating the subtypes that are of
+    interest.  Bit 0 of subtype_filter[0] corresponds to subtype 0, bit 1 =
to
+    subtype 1, and so on.
+
+If the argument to the ioctl() is NULL, then the filters will be removed a=
nd
+all events from the watched sources will come through.
+
+
+Userspace Code Example
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A buffer is created with something like the following::
+
+=09pipe2(fds, O_TMPFILE);
+=09ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);
+
+It can then be set to receive keyring change notifications and device even=
t
+notifications::
+
+=09keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fds[1], 0x01);
+=09watch_devices(fds[1], 0x2);
+
+The notifications can then be consumed by something like the following::
+
+=09static void consumer(int rfd, struct watch_queue_buffer *buf)
+=09{
+=09=09unsigned char buffer[128];
+=09=09ssize_t buf_len;
+
+=09=09while (buf_len =3D read(rfd, buffer, sizeof(buffer)),
+=09=09       buf_len > 0
+=09=09       ) {
+=09=09=09void *p =3D buffer;
+=09=09=09void *end =3D buffer + buf_len;
+=09=09=09while (p < end) {
+=09=09=09=09union {
+=09=09=09=09=09struct watch_notification n;
+=09=09=09=09=09unsigned char buf1[128];
+=09=09=09=09} n;
+=09=09=09=09size_t largest, len;
+
+=09=09=09=09largest =3D end - p;
+=09=09=09=09if (largest > 128)
+=09=09=09=09=09largest =3D 128;
+=09=09=09=09memcpy(&n, p, largest);
+
+=09=09=09=09len =3D (n->info & WATCH_INFO_LENGTH) >>
+=09=09=09=09=09WATCH_INFO_LENGTH__SHIFT;
+=09=09=09=09if (len =3D=3D 0 || len > largest)
+=09=09=09=09=09return;
+
+=09=09=09=09switch (n.n.type) {
+=09=09=09=09case WATCH_TYPE_META:
+=09=09=09=09=09got_meta(&n.n);
+=09=09=09=09case WATCH_TYPE_KEY_NOTIFY:
+=09=09=09=09=09saw_key_change(&n.n);
+=09=09=09=09=09break;
+=09=09=09=09case WATCH_TYPE_BLOCK_NOTIFY:
+=09=09=09=09=09saw_block_event(&n.n);
+=09=09=09=09=09break;
+=09=09=09=09case WATCH_TYPE_USB_NOTIFY:
+=09=09=09=09=09saw_usb_event(&n.n);
+=09=09=09=09=09break;
+=09=09=09=09}
+
+=09=09=09=09p +=3D len;
+=09=09=09}
+=09=09}
+=09}
diff --git a/fs/pipe.c b/fs/pipe.c
index 9cd5cbef9552..099bf4b657dd 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -24,6 +24,7 @@
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
 #include <linux/memcontrol.h>
+#include <linux/watch_queue.h>
=20
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
@@ -407,6 +408,11 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 =09=09goto out;
 =09}
=20
+=09if (pipe->watch_queue) {
+=09=09ret =3D -EXDEV;
+=09=09goto out;
+=09}
+
 =09head =3D pipe->head;
 =09max_usage =3D pipe->max_usage;
 =09mask =3D pipe->ring_size - 1;
@@ -546,25 +552,37 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long =
arg)
 {
 =09struct pipe_inode_info *pipe =3D filp->private_data;
-=09int count, head, tail, mask;
+=09int count, head, tail, mask, ret;
=20
 =09switch (cmd) {
-=09=09case FIONREAD:
-=09=09=09__pipe_lock(pipe);
-=09=09=09count =3D 0;
-=09=09=09head =3D pipe->head;
-=09=09=09tail =3D pipe->tail;
-=09=09=09mask =3D pipe->ring_size - 1;
+=09case FIONREAD:
+=09=09__pipe_lock(pipe);
+=09=09count =3D 0;
+=09=09head =3D pipe->head;
+=09=09tail =3D pipe->tail;
+=09=09mask =3D pipe->ring_size - 1;
=20
-=09=09=09while (tail !=3D head) {
-=09=09=09=09count +=3D pipe->bufs[tail & mask].len;
-=09=09=09=09tail++;
-=09=09=09}
-=09=09=09__pipe_unlock(pipe);
+=09=09while (tail !=3D head) {
+=09=09=09count +=3D pipe->bufs[tail & mask].len;
+=09=09=09tail++;
+=09=09}
+=09=09__pipe_unlock(pipe);
+
+=09=09return put_user(count, (int __user *)arg);
=20
-=09=09=09return put_user(count, (int __user *)arg);
-=09=09default:
-=09=09=09return -ENOIOCTLCMD;
+=09case IOC_WATCH_QUEUE_SET_SIZE:
+=09=09__pipe_lock(pipe);
+=09=09ret =3D watch_queue_set_size(pipe, arg);
+=09=09__pipe_unlock(pipe);
+=09=09return ret;
+
+=09case IOC_WATCH_QUEUE_SET_FILTER:
+=09=09ret =3D watch_queue_set_filter(
+=09=09=09pipe, (struct watch_notification_filter __user *)arg);
+=09=09return ret;
+
+=09default:
+=09=09return -ENOIOCTLCMD;
 =09}
 }
=20
@@ -660,27 +678,27 @@ pipe_fasync(int fd, struct file *filp, int on)
 =09return retval;
 }
=20
-static unsigned long account_pipe_buffers(struct user_struct *user,
-                                 unsigned long old, unsigned long new)
+unsigned long account_pipe_buffers(struct user_struct *user,
+=09=09=09=09   unsigned long old, unsigned long new)
 {
 =09return atomic_long_add_return(new - old, &user->pipe_bufs);
 }
=20
-static bool too_many_pipe_buffers_soft(unsigned long user_bufs)
+bool too_many_pipe_buffers_soft(unsigned long user_bufs)
 {
 =09unsigned long soft_limit =3D READ_ONCE(pipe_user_pages_soft);
=20
 =09return soft_limit && user_bufs > soft_limit;
 }
=20
-static bool too_many_pipe_buffers_hard(unsigned long user_bufs)
+bool too_many_pipe_buffers_hard(unsigned long user_bufs)
 {
 =09unsigned long hard_limit =3D READ_ONCE(pipe_user_pages_hard);
=20
 =09return hard_limit && user_bufs > hard_limit;
 }
=20
-static bool is_unprivileged_user(void)
+bool pipe_is_unprivileged_user(void)
 {
 =09return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
 }
@@ -702,12 +720,12 @@ struct pipe_inode_info *alloc_pipe_info(void)
=20
 =09user_bufs =3D account_pipe_buffers(user, 0, pipe_bufs);
=20
-=09if (too_many_pipe_buffers_soft(user_bufs) && is_unprivileged_user()) {
+=09if (too_many_pipe_buffers_soft(user_bufs) && pipe_is_unprivileged_user(=
)) {
 =09=09user_bufs =3D account_pipe_buffers(user, pipe_bufs, 1);
 =09=09pipe_bufs =3D 1;
 =09}
=20
-=09if (too_many_pipe_buffers_hard(user_bufs) && is_unprivileged_user())
+=09if (too_many_pipe_buffers_hard(user_bufs) && pipe_is_unprivileged_user(=
))
 =09=09goto out_revert_acct;
=20
 =09pipe->bufs =3D kcalloc(pipe_bufs, sizeof(struct pipe_buffer),
@@ -718,6 +736,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
 =09=09pipe->r_counter =3D pipe->w_counter =3D 1;
 =09=09pipe->max_usage =3D pipe_bufs;
 =09=09pipe->ring_size =3D pipe_bufs;
+=09=09pipe->nr_accounted =3D pipe_bufs;
 =09=09pipe->user =3D user;
 =09=09mutex_init(&pipe->mutex);
 =09=09return pipe;
@@ -735,7 +754,12 @@ void free_pipe_info(struct pipe_inode_info *pipe)
 {
 =09int i;
=20
-=09(void) account_pipe_buffers(pipe->user, pipe->ring_size, 0);
+=09if (pipe->watch_queue) {
+=09=09watch_queue_clear(pipe->watch_queue);
+=09=09put_watch_queue(pipe->watch_queue);
+=09}
+
+=09(void) account_pipe_buffers(pipe->user, pipe->nr_accounted, 0);
 =09free_uid(pipe->user);
 =09for (i =3D 0; i < pipe->ring_size; i++) {
 =09=09struct pipe_buffer *buf =3D pipe->bufs + i;
@@ -811,6 +835,13 @@ int create_pipe_files(struct file **res, int flags)
 =09if (!inode)
 =09=09return -ENFILE;
=20
+=09if (flags & O_NOTIFICATION_PIPE) {
+=09=09if (watch_queue_init(inode->i_pipe) < 0) {
+=09=09=09iput(inode);
+=09=09=09return -ENOMEM;
+=09=09}
+=09}
+
 =09f =3D alloc_file_pseudo(inode, pipe_mnt, "",
 =09=09=09=09O_WRONLY | (flags & (O_NONBLOCK | O_DIRECT)),
 =09=09=09=09&pipefifo_fops);
@@ -839,7 +870,7 @@ static int __do_pipe_flags(int *fd, struct file **files=
, int flags)
 =09int error;
 =09int fdw, fdr;
=20
-=09if (flags & ~(O_CLOEXEC | O_NONBLOCK | O_DIRECT))
+=09if (flags & ~(O_CLOEXEC | O_NONBLOCK | O_DIRECT | O_NOTIFICATION_PIPE))
 =09=09return -EINVAL;
=20
 =09error =3D create_pipe_files(files, flags);
@@ -1086,42 +1117,12 @@ unsigned int round_pipe_size(unsigned long size)
 }
=20
 /*
- * Allocate a new array of pipe buffers and copy the info over. Returns th=
e
- * pipe size if successful, or return -ERROR on error.
+ * Resize the pipe ring to a number of slots.
  */
-static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
+int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 {
 =09struct pipe_buffer *bufs;
-=09unsigned int size, nr_slots, head, tail, mask, n;
-=09unsigned long user_bufs;
-=09long ret =3D 0;
-
-=09size =3D round_pipe_size(arg);
-=09nr_slots =3D size >> PAGE_SHIFT;
-
-=09if (!nr_slots)
-=09=09return -EINVAL;
-
-=09/*
-=09 * If trying to increase the pipe capacity, check that an
-=09 * unprivileged user is not trying to exceed various limits
-=09 * (soft limit check here, hard limit check just below).
-=09 * Decreasing the pipe capacity is always permitted, even
-=09 * if the user is currently over a limit.
-=09 */
-=09if (nr_slots > pipe->ring_size &&
-=09=09=09size > pipe_max_size && !capable(CAP_SYS_RESOURCE))
-=09=09return -EPERM;
-
-=09user_bufs =3D account_pipe_buffers(pipe->user, pipe->ring_size, nr_slot=
s);
-
-=09if (nr_slots > pipe->ring_size &&
-=09=09=09(too_many_pipe_buffers_hard(user_bufs) ||
-=09=09=09 too_many_pipe_buffers_soft(user_bufs)) &&
-=09=09=09is_unprivileged_user()) {
-=09=09ret =3D -EPERM;
-=09=09goto out_revert_acct;
-=09}
+=09unsigned int head, tail, mask, n;
=20
 =09/*
 =09 * We can shrink the pipe, if arg is greater than the ring occupancy.
@@ -1133,17 +1134,13 @@ static long pipe_set_size(struct pipe_inode_info *p=
ipe, unsigned long arg)
 =09head =3D pipe->head;
 =09tail =3D pipe->tail;
 =09n =3D pipe_occupancy(pipe->head, pipe->tail);
-=09if (nr_slots < n) {
-=09=09ret =3D -EBUSY;
-=09=09goto out_revert_acct;
-=09}
+=09if (nr_slots < n)
+=09=09return -EBUSY;
=20
 =09bufs =3D kcalloc(nr_slots, sizeof(*bufs),
 =09=09       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
-=09if (unlikely(!bufs)) {
-=09=09ret =3D -ENOMEM;
-=09=09goto out_revert_acct;
-=09}
+=09if (unlikely(!bufs))
+=09=09return -ENOMEM;
=20
 =09/*
 =09 * The pipe array wraps around, so just start the new one at zero
@@ -1171,13 +1168,63 @@ static long pipe_set_size(struct pipe_inode_info *p=
ipe, unsigned long arg)
 =09kfree(pipe->bufs);
 =09pipe->bufs =3D bufs;
 =09pipe->ring_size =3D nr_slots;
-=09pipe->max_usage =3D nr_slots;
+=09if (pipe->max_usage > nr_slots)
+=09=09pipe->max_usage =3D nr_slots;
 =09pipe->tail =3D tail;
 =09pipe->head =3D head;
+=09return 0;
+}
+
+/*
+ * Allocate a new array of pipe buffers and copy the info over. Returns th=
e
+ * pipe size if successful, or return -ERROR on error.
+ */
+long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
+{
+=09unsigned long user_bufs;
+=09unsigned int nr_slots, size;
+=09long ret =3D 0;
+
+=09if (pipe->watch_queue)
+=09=09return -EBUSY;
+
+=09size =3D round_pipe_size(arg);
+=09nr_slots =3D size >> PAGE_SHIFT;
+
+=09if (!nr_slots)
+=09=09return -EINVAL;
+
+=09/*
+=09 * If trying to increase the pipe capacity, check that an
+=09 * unprivileged user is not trying to exceed various limits
+=09 * (soft limit check here, hard limit check just below).
+=09 * Decreasing the pipe capacity is always permitted, even
+=09 * if the user is currently over a limit.
+=09 */
+=09if (nr_slots > pipe->max_usage &&
+=09=09=09size > pipe_max_size && !capable(CAP_SYS_RESOURCE))
+=09=09return -EPERM;
+
+=09user_bufs =3D account_pipe_buffers(pipe->user, pipe->nr_accounted, nr_s=
lots);
+
+=09if (nr_slots > pipe->max_usage &&
+=09=09=09(too_many_pipe_buffers_hard(user_bufs) ||
+=09=09=09 too_many_pipe_buffers_soft(user_bufs)) &&
+=09=09=09pipe_is_unprivileged_user()) {
+=09=09ret =3D -EPERM;
+=09=09goto out_revert_acct;
+=09}
+
+=09ret =3D pipe_resize_ring(pipe, nr_slots);
+=09if (ret < 0)
+=09=09goto out_revert_acct;
+
+=09pipe->max_usage =3D nr_slots;
+=09pipe->nr_accounted =3D nr_slots;
 =09return pipe->max_usage * PAGE_SIZE;
=20
 out_revert_acct:
-=09(void) account_pipe_buffers(pipe->user, nr_slots, pipe->ring_size);
+=09(void) account_pipe_buffers(pipe->user, nr_slots, pipe->nr_accounted);
 =09return ret;
 }
=20
@@ -1186,9 +1233,15 @@ static long pipe_set_size(struct pipe_inode_info *pi=
pe, unsigned long arg)
  * location, so checking ->i_pipe is not enough to verify that this is a
  * pipe.
  */
-struct pipe_inode_info *get_pipe_info(struct file *file)
+struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice)
 {
-=09return file->f_op =3D=3D &pipefifo_fops ? file->private_data : NULL;
+=09struct pipe_inode_info *pipe =3D file->private_data;
+
+=09if (file->f_op !=3D &pipefifo_fops || !pipe)
+=09=09return NULL;
+=09if (for_splice && pipe->watch_queue)
+=09=09return NULL;
+=09return pipe;
 }
=20
 long pipe_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -1196,7 +1249,7 @@ long pipe_fcntl(struct file *file, unsigned int cmd, =
unsigned long arg)
 =09struct pipe_inode_info *pipe;
 =09long ret;
=20
-=09pipe =3D get_pipe_info(file);
+=09pipe =3D get_pipe_info(file, false);
 =09if (!pipe)
 =09=09return -EBADF;
=20
diff --git a/fs/splice.c b/fs/splice.c
index c521090a0469..01eb34e0dfac 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1118,8 +1118,8 @@ static long do_splice(struct file *in, loff_t __user =
*off_in,
 =09loff_t offset;
 =09long ret;
=20
-=09ipipe =3D get_pipe_info(in);
-=09opipe =3D get_pipe_info(out);
+=09ipipe =3D get_pipe_info(in, true);
+=09opipe =3D get_pipe_info(out, true);
=20
 =09if (ipipe && opipe) {
 =09=09if (off_in || off_out)
@@ -1271,7 +1271,7 @@ static int pipe_to_user(struct pipe_inode_info *pipe,=
 struct pipe_buffer *buf,
 static long vmsplice_to_user(struct file *file, struct iov_iter *iter,
 =09=09=09     unsigned int flags)
 {
-=09struct pipe_inode_info *pipe =3D get_pipe_info(file);
+=09struct pipe_inode_info *pipe =3D get_pipe_info(file, true);
 =09struct splice_desc sd =3D {
 =09=09.total_len =3D iov_iter_count(iter),
 =09=09.flags =3D flags,
@@ -1306,7 +1306,7 @@ static long vmsplice_to_pipe(struct file *file, struc=
t iov_iter *iter,
 =09if (flags & SPLICE_F_GIFT)
 =09=09buf_flag =3D PIPE_BUF_FLAG_GIFT;
=20
-=09pipe =3D get_pipe_info(file);
+=09pipe =3D get_pipe_info(file, true);
 =09if (!pipe)
 =09=09return -EBADF;
=20
@@ -1770,8 +1770,8 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 static long do_tee(struct file *in, struct file *out, size_t len,
 =09=09   unsigned int flags)
 {
-=09struct pipe_inode_info *ipipe =3D get_pipe_info(in);
-=09struct pipe_inode_info *opipe =3D get_pipe_info(out);
+=09struct pipe_inode_info *ipipe =3D get_pipe_info(in, true);
+=09struct pipe_inode_info *opipe =3D get_pipe_info(out, true);
 =09int ret =3D -EINVAL;
=20
 =09/*
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 44f2245debda..816bc0d3aecd 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -34,6 +34,7 @@ struct pipe_buffer {
  *=09@tail: The point of buffer consumption
  *=09@max_usage: The maximum number of slots that may be used in the ring
  *=09@ring_size: total number of buffers (should be a power of 2)
+ *=09@nr_accounted: The amount this pipe accounts for in user->pipe_bufs
  *=09@tmp_page: cached released page
  *=09@readers: number of current readers of this pipe
  *=09@writers: number of current writers of this pipe
@@ -45,6 +46,7 @@ struct pipe_buffer {
  *=09@fasync_writers: writer side fasync
  *=09@bufs: the circular array of pipe buffers
  *=09@user: the user who created this pipe
+ *=09@watch_queue: If this pipe is a watch_queue, this is the stuff for th=
at
  **/
 struct pipe_inode_info {
 =09struct mutex mutex;
@@ -53,6 +55,7 @@ struct pipe_inode_info {
 =09unsigned int tail;
 =09unsigned int max_usage;
 =09unsigned int ring_size;
+=09unsigned int nr_accounted;
 =09unsigned int readers;
 =09unsigned int writers;
 =09unsigned int files;
@@ -64,6 +67,9 @@ struct pipe_inode_info {
 =09struct fasync_struct *fasync_writers;
 =09struct pipe_buffer *bufs;
 =09struct user_struct *user;
+#ifdef CONFIG_WATCH_QUEUE
+=09struct watch_queue *watch_queue;
+#endif
 };
=20
 /*
@@ -238,9 +244,20 @@ void pipe_buf_mark_unmergeable(struct pipe_buffer *buf=
);
=20
 extern const struct pipe_buf_operations nosteal_pipe_buf_ops;
=20
+#ifdef CONFIG_WATCH_QUEUE
+unsigned long account_pipe_buffers(struct user_struct *user,
+=09=09=09=09   unsigned long old, unsigned long new);
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
=20
 int create_pipe_files(struct file **, int);
 unsigned int round_pipe_size(unsigned long size);
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
new file mode 100644
index 000000000000..b705db0a2868
--- /dev/null
+++ b/include/linux/watch_queue.h
@@ -0,0 +1,127 @@
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
+struct cred;
+
+struct watch_type_filter {
+=09enum watch_notification_type type;
+=09__u32=09=09subtype_filter[1];=09/* Bitmask of subtypes to filter on */
+=09__u32=09=09info_filter;=09=09/* Filter on watch_notification::info */
+=09__u32=09=09info_mask;=09=09/* Mask of relevant bits in info_filter */
+};
+
+struct watch_filter {
+=09union {
+=09=09struct rcu_head=09rcu;
+=09=09unsigned long=09type_filter[2];=09/* Bitmask of accepted types */
+=09};
+=09u32=09=09=09nr_filters;=09/* Number of filters */
+=09struct watch_type_filter filters[];
+};
+
+struct watch_queue {
+=09struct rcu_head=09=09rcu;
+=09struct watch_filter __rcu *filter;
+=09struct pipe_inode_info=09*pipe;=09=09/* The pipe we're using as a buffe=
r */
+=09struct hlist_head=09watches;=09/* Contributory watches */
+=09struct page=09=09**notes;=09/* Preallocated notifications */
+=09unsigned long=09=09*notes_bitmap;=09/* Allocation bitmap for notes */
+=09struct kref=09=09usage;=09=09/* Object usage count */
+=09spinlock_t=09=09lock;
+=09unsigned int=09=09nr_notes;=09/* Number of notes */
+=09unsigned int=09=09nr_pages;=09/* Number of pages in notes[] */
+=09bool=09=09=09defunct;=09/* T when queues closed */
+};
+
+/*
+ * Representation of a watch on an object.
+ */
+struct watch {
+=09union {
+=09=09struct rcu_head=09rcu;
+=09=09u32=09=09info_id;=09/* ID to be OR'd in to info field */
+=09};
+=09struct watch_queue __rcu *queue;=09/* Queue to post events to */
+=09struct hlist_node=09queue_node;=09/* Link in queue->watches */
+=09struct watch_list __rcu=09*watch_list;
+=09struct hlist_node=09list_node;=09/* Link in watch_list->watchers */
+=09const struct cred=09*cred;=09=09/* Creds of the owner of the watch */
+=09void=09=09=09*private;=09/* Private data for the watched object */
+=09u64=09=09=09id;=09=09/* Internal identifier */
+=09struct kref=09=09usage;=09=09/* Object usage count */
+};
+
+/*
+ * List of watches on an object.
+ */
+struct watch_list {
+=09struct rcu_head=09=09rcu;
+=09struct hlist_head=09watchers;
+=09void (*release_watch)(struct watch *);
+=09spinlock_t=09=09lock;
+};
+
+extern void __post_watch_notification(struct watch_list *,
+=09=09=09=09      struct watch_notification *,
+=09=09=09=09      const struct cred *,
+=09=09=09=09      u64);
+extern struct watch_queue *get_watch_queue(int);
+extern void put_watch_queue(struct watch_queue *);
+extern void init_watch(struct watch *, struct watch_queue *);
+extern int add_watch_to_object(struct watch *, struct watch_list *);
+extern int remove_watch_from_object(struct watch_list *, struct watch_queu=
e *, u64, bool);
+extern long watch_queue_set_size(struct pipe_inode_info *, unsigned int);
+extern long watch_queue_set_filter(struct pipe_inode_info *,
+=09=09=09=09   struct watch_notification_filter __user *);
+extern int watch_queue_init(struct pipe_inode_info *);
+extern void watch_queue_clear(struct watch_queue *);
+
+static inline void init_watch_list(struct watch_list *wlist,
+=09=09=09=09   void (*release_watch)(struct watch *))
+{
+=09INIT_HLIST_HEAD(&wlist->watchers);
+=09spin_lock_init(&wlist->lock);
+=09wlist->release_watch =3D release_watch;
+}
+
+static inline void post_watch_notification(struct watch_list *wlist,
+=09=09=09=09=09   struct watch_notification *n,
+=09=09=09=09=09   const struct cred *cred,
+=09=09=09=09=09   u64 id)
+{
+=09if (unlikely(wlist))
+=09=09__post_watch_notification(wlist, n, cred, id);
+}
+
+static inline void remove_watch_list(struct watch_list *wlist, u64 id)
+{
+=09if (wlist) {
+=09=09remove_watch_from_object(wlist, NULL, id, true);
+=09=09kfree_rcu(wlist, rcu);
+=09}
+}
+
+/**
+ * watch_sizeof - Calculate the information part of the size of a watch re=
cord,
+ * given the structure size.
+ */
+#define watch_sizeof(STRUCT) (sizeof(STRUCT) << WATCH_INFO_LENGTH__SHIFT)
+
+#endif
+
+#endif /* _LINUX_WATCH_QUEUE_H */
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_qu=
eue.h
index 9df72227f515..3a5790f1f05d 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -4,9 +4,13 @@
=20
 #include <linux/types.h>
 #include <linux/fcntl.h>
+#include <linux/ioctl.h>
=20
 #define O_NOTIFICATION_PIPE=09O_EXCL=09/* Parameter to pipe2() selecting n=
otification pipe */
=20
+#define IOC_WATCH_QUEUE_SET_SIZE=09_IO('W', 0x60)=09/* Set the size in pag=
es */
+#define IOC_WATCH_QUEUE_SET_FILTER=09_IO('W', 0x61)=09/* Set the filter */
+
 enum watch_notification_type {
 =09WATCH_TYPE_META=09=09=3D 0,=09/* Special record */
 =09WATCH_TYPE__NR=09=09=3D 1
@@ -41,6 +45,22 @@ struct watch_notification {
 #define WATCH_INFO_FLAG_7=090x00800000
 };
=20
+/*
+ * Notification filtering rules (IOC_WATCH_QUEUE_SET_FILTER).
+ */
+struct watch_notification_type_filter {
+=09__u32=09type;=09=09=09/* Type to apply filter to */
+=09__u32=09info_filter;=09=09/* Filter on watch_notification::info */
+=09__u32=09info_mask;=09=09/* Mask of relevant bits in info_filter */
+=09__u32=09subtype_filter[8];=09/* Bitmask of subtypes to filter on */
+};
+
+struct watch_notification_filter {
+=09__u32=09nr_filters;=09=09/* Number of filters */
+=09__u32=09__reserved;=09=09/* Must be 0 */
+=09struct watch_notification_type_filter filters[];
+};
+
=20
 /*
  * Extended watch removal notification.  This is used optionally if the ty=
pe
diff --git a/init/Kconfig b/init/Kconfig
index b4daad2bac23..eb177b78f560 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -358,6 +358,18 @@ config POSIX_MQUEUE_SYSCTL
 =09depends on SYSCTL
 =09default y
=20
+config WATCH_QUEUE
+=09bool "General notification queue"
+=09default n
+=09help
+
+=09  This is a general notification queue for the kernel to pass events to
+=09  userspace by splicing them into pipes.  It can be used in conjunction
+=09  with watches for key/keyring change notifications and device
+=09  notifications.
+
+=09  See Documentation/watch_queue.rst
+
 config CROSS_MEMORY_ATTACH
 =09bool "Enable process_vm_readv/writev syscalls"
 =09depends on MMU
diff --git a/kernel/Makefile b/kernel/Makefile
index daad787fb795..067975dd2e0c 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -114,6 +114,7 @@ obj-$(CONFIG_TORTURE_TEST) +=3D torture.o
=20
 obj-$(CONFIG_HAS_IOMEM) +=3D iomem.o
 obj-$(CONFIG_RSEQ) +=3D rseq.o
+obj-$(CONFIG_WATCH_QUEUE) +=3D watch_queue.o
=20
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) +=3D stackleak.o
 KASAN_SANITIZE_stackleak.o :=3D n
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
new file mode 100644
index 000000000000..b73fbfe0d467
--- /dev/null
+++ b/kernel/watch_queue.c
@@ -0,0 +1,656 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Watch queue and general notification mechanism, built on pipes
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
+=09=09=09=09=09 struct pipe_buffer *buf)
+{
+=09struct watch_queue *wqueue =3D (struct watch_queue *)buf->private;
+=09struct page *page;
+=09unsigned int bit;
+
+=09/* We need to work out which note within the page this refers to, but
+=09 * the note might have been maximum size, so merely ANDing the offset
+=09 * off doesn't work.  OTOH, the note must've been more than zero size.
+=09 */
+=09bit =3D buf->offset + buf->len;
+=09if ((bit & (WATCH_QUEUE_NOTE_SIZE - 1)) =3D=3D 0)
+=09=09bit -=3D WATCH_QUEUE_NOTE_SIZE;
+=09bit /=3D WATCH_QUEUE_NOTE_SIZE;
+
+=09page =3D buf->page;
+=09bit +=3D page->index;
+
+=09set_bit(bit, wqueue->notes_bitmap);
+}
+
+static int watch_queue_pipe_buf_steal(struct pipe_inode_info *pipe,
+=09=09=09=09      struct pipe_buffer *buf)
+{
+=09return -1; /* No. */
+}
+
+/* New data written to a pipe may be appended to a buffer with this type. =
*/
+static const struct pipe_buf_operations watch_queue_pipe_buf_ops =3D {
+=09.confirm=09=3D generic_pipe_buf_confirm,
+=09.release=09=3D watch_queue_pipe_buf_release,
+=09.steal=09=09=3D watch_queue_pipe_buf_steal,
+=09.get=09=09=3D generic_pipe_buf_get,
+};
+
+/*
+ * Post a notification to a watch queue.
+ */
+static bool post_one_notification(struct watch_queue *wqueue,
+=09=09=09=09  struct watch_notification *n)
+{
+=09void *p;
+=09struct pipe_inode_info *pipe =3D wqueue->pipe;
+=09struct pipe_buffer *buf;
+=09struct page *page;
+=09unsigned int head, tail, mask, note, offset, len;
+=09bool done =3D false;
+
+=09if (!pipe)
+=09=09return false;
+
+=09spin_lock_irq(&pipe->wait.lock);
+
+=09if (wqueue->defunct)
+=09=09goto out;
+
+=09mask =3D pipe->ring_size - 1;
+=09head =3D pipe->head;
+=09tail =3D pipe->tail;
+=09if (pipe_full(head, tail, pipe->ring_size))
+=09=09goto lost;
+
+=09note =3D find_first_bit(wqueue->notes_bitmap, wqueue->nr_notes);
+=09if (note >=3D wqueue->nr_notes)
+=09=09goto lost;
+
+=09page =3D wqueue->notes[note / WATCH_QUEUE_NOTES_PER_PAGE];
+=09offset =3D note % WATCH_QUEUE_NOTES_PER_PAGE * WATCH_QUEUE_NOTE_SIZE;
+=09get_page(page);
+=09len =3D n->info & WATCH_INFO_LENGTH;
+=09p =3D kmap_atomic(page);
+=09memcpy(p + offset, n, len);
+=09kunmap_atomic(p);
+
+=09buf =3D &pipe->bufs[head & mask];
+=09buf->page =3D page;
+=09buf->private =3D (unsigned long)wqueue;
+=09buf->ops =3D &watch_queue_pipe_buf_ops;
+=09buf->offset =3D offset;
+=09buf->len =3D len;
+=09buf->flags =3D 0;
+=09pipe->head =3D head + 1;
+
+=09if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
+=09=09spin_unlock_irq(&pipe->wait.lock);
+=09=09BUG();
+=09}
+=09wake_up_interruptible_sync_poll_locked(&pipe->wait, EPOLLIN | EPOLLRDNO=
RM);
+=09done =3D true;
+
+out:
+=09spin_unlock_irq(&pipe->wait.lock);
+=09if (done)
+=09=09kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
+=09return done;
+
+lost:
+=09goto out;
+}
+
+/*
+ * Apply filter rules to a notification.
+ */
+static bool filter_watch_notification(const struct watch_filter *wf,
+=09=09=09=09      const struct watch_notification *n)
+{
+=09const struct watch_type_filter *wt;
+=09unsigned int st_bits =3D sizeof(wt->subtype_filter[0]) * 8;
+=09unsigned int st_index =3D n->subtype / st_bits;
+=09unsigned int st_bit =3D 1U << (n->subtype % st_bits);
+=09int i;
+
+=09if (!test_bit(n->type, wf->type_filter))
+=09=09return false;
+
+=09for (i =3D 0; i < wf->nr_filters; i++) {
+=09=09wt =3D &wf->filters[i];
+=09=09if (n->type =3D=3D wt->type &&
+=09=09    (wt->subtype_filter[st_index] & st_bit) &&
+=09=09    (n->info & wt->info_mask) =3D=3D wt->info_filter)
+=09=09=09return true;
+=09}
+
+=09return false; /* If there is a filter, the default is to reject. */
+}
+
+/**
+ * __post_watch_notification - Post an event notification
+ * @wlist: The watch list to post the event to.
+ * @n: The notification record to post.
+ * @cred: The creds of the process that triggered the notification.
+ * @id: The ID to match on the watch.
+ *
+ * Post a notification of an event into a set of watch queues and let the =
users
+ * know.
+ *
+ * The size of the notification should be set in n->info & WATCH_INFO_LENG=
TH and
+ * should be in units of sizeof(*n).
+ */
+void __post_watch_notification(struct watch_list *wlist,
+=09=09=09       struct watch_notification *n,
+=09=09=09       const struct cred *cred,
+=09=09=09       u64 id)
+{
+=09const struct watch_filter *wf;
+=09struct watch_queue *wqueue;
+=09struct watch *watch;
+
+=09if (((n->info & WATCH_INFO_LENGTH) >> WATCH_INFO_LENGTH__SHIFT) =3D=3D =
0) {
+=09=09WARN_ON(1);
+=09=09return;
+=09}
+
+=09rcu_read_lock();
+
+=09hlist_for_each_entry_rcu(watch, &wlist->watchers, list_node) {
+=09=09if (watch->id !=3D id)
+=09=09=09continue;
+=09=09n->info &=3D ~WATCH_INFO_ID;
+=09=09n->info |=3D watch->info_id;
+
+=09=09wqueue =3D rcu_dereference(watch->queue);
+=09=09wf =3D rcu_dereference(wqueue->filter);
+=09=09if (wf && !filter_watch_notification(wf, n))
+=09=09=09continue;
+
+=09=09if (security_post_notification(watch->cred, cred, n) < 0)
+=09=09=09continue;
+
+=09=09post_one_notification(wqueue, n);
+=09}
+
+=09rcu_read_unlock();
+}
+EXPORT_SYMBOL(__post_watch_notification);
+
+/*
+ * Allocate sufficient pages to preallocation for the requested number of
+ * notifications.
+ */
+long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_no=
tes)
+{
+=09struct watch_queue *wqueue =3D pipe->watch_queue;
+=09struct page **pages;
+=09unsigned long *bitmap;
+=09unsigned long user_bufs;
+=09unsigned int bmsize;
+=09int ret, i, nr_pages;
+
+=09if (!wqueue)
+=09=09return -ENODEV;
+=09if (wqueue->notes)
+=09=09return -EBUSY;
+
+=09if (nr_notes < 1 ||
+=09    nr_notes > 512) /* TODO: choose a better hard limit */
+=09=09return -EINVAL;
+
+=09nr_pages =3D (nr_notes + WATCH_QUEUE_NOTES_PER_PAGE - 1);
+=09nr_pages /=3D WATCH_QUEUE_NOTES_PER_PAGE;
+=09user_bufs =3D account_pipe_buffers(pipe->user, pipe->nr_accounted, nr_p=
ages);
+
+=09if (nr_pages > pipe->max_usage &&
+=09    (too_many_pipe_buffers_hard(user_bufs) ||
+=09     too_many_pipe_buffers_soft(user_bufs)) &&
+=09    pipe_is_unprivileged_user()) {
+=09=09ret =3D -EPERM;
+=09=09goto error;
+=09}
+
+=09ret =3D pipe_resize_ring(pipe, nr_notes);
+=09if (ret < 0)
+=09=09goto error;
+
+=09pages =3D kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
+=09if (!pages)
+=09=09goto error;
+
+=09for (i =3D 0; i < nr_pages; i++) {
+=09=09pages[i] =3D alloc_page(GFP_KERNEL);
+=09=09if (!pages[i])
+=09=09=09goto error_p;
+=09=09pages[i]->index =3D i * WATCH_QUEUE_NOTES_PER_PAGE;
+=09}
+
+=09bmsize =3D (nr_notes + BITS_PER_LONG - 1) / BITS_PER_LONG;
+=09bmsize *=3D sizeof(unsigned long);
+=09bitmap =3D kmalloc(bmsize, GFP_KERNEL);
+=09if (!bitmap)
+=09=09goto error_p;
+
+=09memset(bitmap, 0xff, bmsize);
+=09wqueue->notes =3D pages;
+=09wqueue->notes_bitmap =3D bitmap;
+=09wqueue->nr_pages =3D nr_pages;
+=09wqueue->nr_notes =3D nr_pages * WATCH_QUEUE_NOTES_PER_PAGE;
+=09return 0;
+
+error_p:
+=09for (i =3D 0; i < nr_pages; i++)
+=09=09__free_page(pages[i]);
+=09kfree(pages);
+error:
+=09(void) account_pipe_buffers(pipe->user, nr_pages, pipe->nr_accounted);
+=09return ret;
+}
+
+/*
+ * Set the filter on a watch queue.
+ */
+long watch_queue_set_filter(struct pipe_inode_info *pipe,
+=09=09=09    struct watch_notification_filter __user *_filter)
+{
+=09struct watch_notification_type_filter *tf;
+=09struct watch_notification_filter filter;
+=09struct watch_type_filter *q;
+=09struct watch_filter *wfilter;
+=09struct watch_queue *wqueue =3D pipe->watch_queue;
+=09int ret, nr_filter =3D 0, i;
+
+=09if (!wqueue)
+=09=09return -ENODEV;
+
+=09if (!_filter) {
+=09=09/* Remove the old filter */
+=09=09wfilter =3D NULL;
+=09=09goto set;
+=09}
+
+=09/* Grab the user's filter specification */
+=09if (copy_from_user(&filter, _filter, sizeof(filter)) !=3D 0)
+=09=09return -EFAULT;
+=09if (filter.nr_filters =3D=3D 0 ||
+=09    filter.nr_filters > 16 ||
+=09    filter.__reserved !=3D 0)
+=09=09return -EINVAL;
+
+=09tf =3D memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
+=09if (IS_ERR(tf))
+=09=09return PTR_ERR(tf);
+
+=09ret =3D -EINVAL;
+=09for (i =3D 0; i < filter.nr_filters; i++) {
+=09=09if ((tf[i].info_filter & ~tf[i].info_mask) ||
+=09=09    tf[i].info_mask & WATCH_INFO_LENGTH)
+=09=09=09goto err_filter;
+=09=09/* Ignore any unknown types */
+=09=09if (tf[i].type >=3D sizeof(wfilter->type_filter) * 8)
+=09=09=09continue;
+=09=09nr_filter++;
+=09}
+
+=09/* Now we need to build the internal filter from only the relevant
+=09 * user-specified filters.
+=09 */
+=09ret =3D -ENOMEM;
+=09wfilter =3D kzalloc(struct_size(wfilter, filters, nr_filter), GFP_KERNE=
L);
+=09if (!wfilter)
+=09=09goto err_filter;
+=09wfilter->nr_filters =3D nr_filter;
+
+=09q =3D wfilter->filters;
+=09for (i =3D 0; i < filter.nr_filters; i++) {
+=09=09if (tf[i].type >=3D sizeof(wfilter->type_filter) * BITS_PER_LONG)
+=09=09=09continue;
+
+=09=09q->type=09=09=09=3D tf[i].type;
+=09=09q->info_filter=09=09=3D tf[i].info_filter;
+=09=09q->info_mask=09=09=3D tf[i].info_mask;
+=09=09q->subtype_filter[0]=09=3D tf[i].subtype_filter[0];
+=09=09__set_bit(q->type, wfilter->type_filter);
+=09=09q++;
+=09}
+
+=09kfree(tf);
+set:
+=09pipe_lock(pipe);
+=09rcu_swap_protected(wqueue->filter, wfilter,
+=09=09=09   lockdep_is_held(&pipe->mutex));
+=09pipe_unlock(pipe);
+=09if (wfilter)
+=09=09kfree_rcu(wfilter, rcu);
+=09return 0;
+
+err_filter:
+=09kfree(tf);
+=09return ret;
+}
+
+static void __put_watch_queue(struct kref *kref)
+{
+=09struct watch_queue *wqueue =3D
+=09=09container_of(kref, struct watch_queue, usage);
+=09struct watch_filter *wfilter;
+=09int i;
+
+=09for (i =3D 0; i < wqueue->nr_pages; i++)
+=09=09__free_page(wqueue->notes[i]);
+
+=09wfilter =3D rcu_access_pointer(wqueue->filter);
+=09if (wfilter)
+=09=09kfree_rcu(wfilter, rcu);
+=09kfree_rcu(wqueue, rcu);
+}
+
+/**
+ * put_watch_queue - Dispose of a ref on a watchqueue.
+ * @wqueue: The watch queue to unref.
+ */
+void put_watch_queue(struct watch_queue *wqueue)
+{
+=09kref_put(&wqueue->usage, __put_watch_queue);
+}
+EXPORT_SYMBOL(put_watch_queue);
+
+static void free_watch(struct rcu_head *rcu)
+{
+=09struct watch *watch =3D container_of(rcu, struct watch, rcu);
+
+=09put_watch_queue(rcu_access_pointer(watch->queue));
+=09put_cred(watch->cred);
+}
+
+static void __put_watch(struct kref *kref)
+{
+=09struct watch *watch =3D container_of(kref, struct watch, usage);
+
+=09call_rcu(&watch->rcu, free_watch);
+}
+
+/*
+ * Discard a watch.
+ */
+static void put_watch(struct watch *watch)
+{
+=09kref_put(&watch->usage, __put_watch);
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
+=09kref_init(&watch->usage);
+=09INIT_HLIST_NODE(&watch->list_node);
+=09INIT_HLIST_NODE(&watch->queue_node);
+=09rcu_assign_pointer(watch->queue, wqueue);
+}
+
+/**
+ * add_watch_to_object - Add a watch on an object to a watch list
+ * @watch: The watch to add
+ * @wlist: The watch list to add to
+ *
+ * @watch->queue must have been set to point to the queue to post notifica=
tions
+ * to and the watch list of the object to be watched.  @watch->cred must a=
lso
+ * have been set to the appropriate credentials and a ref taken on them.
+ *
+ * The caller must pin the queue and the list both and must hold the list
+ * locked against racing watch additions/removals.
+ */
+int add_watch_to_object(struct watch *watch, struct watch_list *wlist)
+{
+=09struct watch_queue *wqueue =3D rcu_access_pointer(watch->queue);
+=09struct watch *w;
+
+=09hlist_for_each_entry(w, &wlist->watchers, list_node) {
+=09=09struct watch_queue *wq =3D rcu_access_pointer(w->queue);
+=09=09if (wqueue =3D=3D wq && watch->id =3D=3D w->id)
+=09=09=09return -EBUSY;
+=09}
+
+=09watch->cred =3D get_current_cred();
+=09rcu_assign_pointer(watch->watch_list, wlist);
+
+=09spin_lock_bh(&wqueue->lock);
+=09kref_get(&wqueue->usage);
+=09hlist_add_head(&watch->queue_node, &wqueue->watches);
+=09spin_unlock_bh(&wqueue->lock);
+
+=09hlist_add_head(&watch->list_node, &wlist->watchers);
+=09return 0;
+}
+EXPORT_SYMBOL(add_watch_to_object);
+
+/**
+ * remove_watch_from_object - Remove a watch or all watches from an object=
.
+ * @wlist: The watch list to remove from
+ * @wq: The watch queue of interest (ignored if @all is true)
+ * @id: The ID of the watch to remove (ignored if @all is true)
+ * @all: True to remove all objects
+ *
+ * Remove a specific watch or all watches from an object.  A notification =
is
+ * sent to the watcher to tell them that this happened.
+ */
+int remove_watch_from_object(struct watch_list *wlist, struct watch_queue =
*wq,
+=09=09=09     u64 id, bool all)
+{
+=09struct watch_notification_removal n;
+=09struct watch_queue *wqueue;
+=09struct watch *watch;
+=09int ret =3D -EBADSLT;
+
+=09rcu_read_lock();
+
+again:
+=09spin_lock(&wlist->lock);
+=09hlist_for_each_entry(watch, &wlist->watchers, list_node) {
+=09=09if (all ||
+=09=09    (watch->id =3D=3D id && rcu_access_pointer(watch->queue) =3D=3D =
wq))
+=09=09=09goto found;
+=09}
+=09spin_unlock(&wlist->lock);
+=09goto out;
+
+found:
+=09ret =3D 0;
+=09hlist_del_init_rcu(&watch->list_node);
+=09rcu_assign_pointer(watch->watch_list, NULL);
+=09spin_unlock(&wlist->lock);
+
+=09/* We now own the reference on watch that used to belong to wlist. */
+
+=09n.watch.type =3D WATCH_TYPE_META;
+=09n.watch.subtype =3D WATCH_META_REMOVAL_NOTIFICATION;
+=09n.watch.info =3D watch->info_id | watch_sizeof(n.watch);
+=09n.id =3D id;
+=09if (id !=3D 0)
+=09=09n.watch.info =3D watch->info_id | watch_sizeof(n);
+
+=09wqueue =3D rcu_dereference(watch->queue);
+
+=09/* We don't need the watch list lock for the next bit as RCU is
+=09 * protecting *wqueue from deallocation.
+=09 */
+=09if (wqueue) {
+=09=09post_one_notification(wqueue, &n.watch);
+
+=09=09spin_lock_bh(&wqueue->lock);
+
+=09=09if (!hlist_unhashed(&watch->queue_node)) {
+=09=09=09hlist_del_init_rcu(&watch->queue_node);
+=09=09=09put_watch(watch);
+=09=09}
+
+=09=09spin_unlock_bh(&wqueue->lock);
+=09}
+
+=09if (wlist->release_watch) {
+=09=09void (*release_watch)(struct watch *);
+
+=09=09release_watch =3D wlist->release_watch;
+=09=09rcu_read_unlock();
+=09=09(*release_watch)(watch);
+=09=09rcu_read_lock();
+=09}
+=09put_watch(watch);
+
+=09if (all && !hlist_empty(&wlist->watchers))
+=09=09goto again;
+out:
+=09rcu_read_unlock();
+=09return ret;
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
+=09struct watch_list *wlist;
+=09struct watch *watch;
+=09bool release;
+
+=09rcu_read_lock();
+=09spin_lock_bh(&wqueue->lock);
+
+=09/* Prevent new additions and prevent notifications from happening */
+=09wqueue->defunct =3D true;
+
+=09while (!hlist_empty(&wqueue->watches)) {
+=09=09watch =3D hlist_entry(wqueue->watches.first, struct watch, queue_nod=
e);
+=09=09hlist_del_init_rcu(&watch->queue_node);
+=09=09/* We now own a ref on the watch. */
+=09=09spin_unlock_bh(&wqueue->lock);
+
+=09=09/* We can't do the next bit under the queue lock as we need to
+=09=09 * get the list lock - which would cause a deadlock if someone
+=09=09 * was removing from the opposite direction at the same time or
+=09=09 * posting a notification.
+=09=09 */
+=09=09wlist =3D rcu_dereference(watch->watch_list);
+=09=09if (wlist) {
+=09=09=09void (*release_watch)(struct watch *);
+
+=09=09=09spin_lock(&wlist->lock);
+
+=09=09=09release =3D !hlist_unhashed(&watch->list_node);
+=09=09=09if (release) {
+=09=09=09=09hlist_del_init_rcu(&watch->list_node);
+=09=09=09=09rcu_assign_pointer(watch->watch_list, NULL);
+
+=09=09=09=09/* We now own a second ref on the watch. */
+=09=09=09}
+
+=09=09=09release_watch =3D wlist->release_watch;
+=09=09=09spin_unlock(&wlist->lock);
+
+=09=09=09if (release) {
+=09=09=09=09if (release_watch) {
+=09=09=09=09=09rcu_read_unlock();
+=09=09=09=09=09/* This might need to call dput(), so
+=09=09=09=09=09 * we have to drop all the locks.
+=09=09=09=09=09 */
+=09=09=09=09=09(*release_watch)(watch);
+=09=09=09=09=09rcu_read_lock();
+=09=09=09=09}
+=09=09=09=09put_watch(watch);
+=09=09=09}
+=09=09}
+
+=09=09put_watch(watch);
+=09=09spin_lock_bh(&wqueue->lock);
+=09}
+
+=09spin_unlock_bh(&wqueue->lock);
+=09rcu_read_unlock();
+}
+
+/**
+ * get_watch_queue - Get a watch queue from its file descriptor.
+ * @fd: The fd to query.
+ */
+struct watch_queue *get_watch_queue(int fd)
+{
+=09struct pipe_inode_info *pipe;
+=09struct watch_queue *wqueue =3D ERR_PTR(-EINVAL);
+=09struct fd f;
+
+=09f =3D fdget(fd);
+=09if (f.file) {
+=09=09pipe =3D get_pipe_info(f.file, false);
+=09=09if (pipe && pipe->watch_queue) {
+=09=09=09wqueue =3D pipe->watch_queue;
+=09=09=09kref_get(&wqueue->usage);
+=09=09}
+=09=09fdput(f);
+=09}
+
+=09return wqueue;
+}
+EXPORT_SYMBOL(get_watch_queue);
+
+/*
+ * Initialise a watch queue
+ */
+int watch_queue_init(struct pipe_inode_info *pipe)
+{
+=09struct watch_queue *wqueue;
+
+=09wqueue =3D kzalloc(sizeof(*wqueue), GFP_KERNEL);
+=09if (!wqueue)
+=09=09return -ENOMEM;
+
+=09wqueue->pipe =3D pipe;
+=09kref_init(&wqueue->usage);
+=09spin_lock_init(&wqueue->lock);
+=09INIT_HLIST_HEAD(&wqueue->watches);
+
+=09pipe->watch_queue =3D wqueue;
+=09return 0;
+}

