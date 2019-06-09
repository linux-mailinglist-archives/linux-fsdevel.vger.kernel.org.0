Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220563A64C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2019 15:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfFIN5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jun 2019 09:57:05 -0400
Received: from mail177-30.suw61.mandrillapp.com ([198.2.177.30]:27120 "EHLO
        mail177-30.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728786AbfFIN5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jun 2019 09:57:05 -0400
X-Greylist: delayed 923 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jun 2019 09:57:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=ySr4Nrr+89DHcvxITmE7xFf/aeGkap9445ywRZ8FnQs=;
 b=QV75YMt8k7bKHfr0EHkuJedDYjKIPoeQcR9UbJyyb3uCz5tQpU0I87xP7DvASGWaYMtrIY1usuYj
   Z4J61vtYMJjLaiwgbKDbv46S/xHevdBEO10HTmIiGsHrn1cZEjQHOZ6tSHTUFqpsYt7zEIc2QXT+
   +3H03H6KLhglvnNDJKc=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-30.suw61.mandrillapp.com id hvk82u22rtks for <linux-fsdevel@vger.kernel.org>; Sun, 9 Jun 2019 13:39:11 +0000 (envelope-from <bounce-md_31050260.5cfd0bff.v1-392256ee45b94a62b5b6c18453ff629d@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1560087551; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=ySr4Nrr+89DHcvxITmE7xFf/aeGkap9445ywRZ8FnQs=; 
 b=L1WqjK8fPLCF8v4R9ZuFMywNlCJcgitOy/50TW6davRlNgDON2SpDkEUj9gAOTPsbMB8a5
 zpairUasvFX1Ehe2M5rTkmI+jL4Aq1TWKzWHYymZrAfkXayr256d9efhPO/3J3QtyTy1FaGa
 4jEgtEHU6hODSd8ewcOfft+bFhe6k=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 4.4 1/2] fs: stream_open - opener for stream-like files so that read and write can run simultaneously without deadlock
Received: from [87.98.221.171] by mandrillapp.com id 392256ee45b94a62b5b6c18453ff629d; Sun, 09 Jun 2019 13:39:11 +0000
X-Mailer: git-send-email 2.20.1
To:     <stable@vger.kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Message-Id: <20190609132443.9420-2-kirr@nexedi.com>
In-Reply-To: <20190609132443.9420-1-kirr@nexedi.com>
References: <20190609132443.9420-1-kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.392256ee45b94a62b5b6c18453ff629d
X-Mandrill-User: md_31050260
Date:   Sun, 09 Jun 2019 13:39:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ commit 10dce8af34226d90fa56746a934f8da5dcdba3df upstream.

  while porting to 4.4 xenbus conflict was trivially resolved in a way
  that actually fixes /proc/xen/xenbus deadlock introduced in 3.14,
  because original upstream commit 581d21a2d02a to fix xenbus deadlock
  was not included into 4.4 . ]

Commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX") added
locking for file.f_pos access and in particular made concurrent read and
write not possible - now both those functions take f_pos lock for the
whole run, and so if e.g. a read is blocked waiting for data, write will
deadlock waiting for that read to complete.

This caused regression for stream-like files where previously read and
write could run simultaneously, but after that patch could not do so
anymore. See e.g. commit 581d21a2d02a ("xenbus: fix deadlock on writes
to /proc/xen/xenbus") which fixes such regression for particular case of
/proc/xen/xenbus.

The patch that added f_pos lock in 2014 did so to guarantee POSIX thread
safety for read/write/lseek and added the locking to file descriptors of
all regular files. In 2014 that thread-safety problem was not new as it
was already discussed earlier in 2006.

However even though 2006'th version of Linus's patch was adding f_pos
locking "only for files that are marked seekable with FMODE_LSEEK (thus
avoiding the stream-like objects like pipes and sockets)", the 2014
version - the one that actually made it into the tree as 9c225f2655e3 -
is doing so irregardless of whether a file is seekable or not.

See

    https://lore.kernel.org/lkml/53022DB1.4070805@gmail.com/
    https://lwn.net/Articles/180387
    https://lwn.net/Articles/180396

for historic context.

The reason that it did so is, probably, that there are many files that
are marked non-seekable, but e.g. their read implementation actually
depends on knowing current position to correctly handle the read. Some
examples:

	kernel/power/user.c		snapshot_read
	fs/debugfs/file.c		u32_array_read
	fs/fuse/control.c		fuse_conn_waiting_read + ...
	drivers/hwmon/asus_atk0110.c	atk_debugfs_ggrp_read
	arch/s390/hypfs/inode.c		hypfs_read_iter
	...

Despite that, many nonseekable_open users implement read and write with
pure stream semantics - they don't depend on passed ppos at all. And for
those cases where read could wait for something inside, it creates a
situation similar to xenbus - the write could be never made to go until
read is done, and read is waiting for some, potentially external, event,
for potentially unbounded time -> deadlock.

Besides xenbus, there are 14 such places in the kernel that I've found
with semantic patch (see below):

	drivers/xen/evtchn.c:667:8-24: ERROR: evtchn_fops: .read() can deadlock .write()
	drivers/isdn/capi/capi.c:963:8-24: ERROR: capi_fops: .read() can deadlock .write()
	drivers/input/evdev.c:527:1-17: ERROR: evdev_fops: .read() can deadlock .write()
	drivers/char/pcmcia/cm4000_cs.c:1685:7-23: ERROR: cm4000_fops: .read() can deadlock .write()
	net/rfkill/core.c:1146:8-24: ERROR: rfkill_fops: .read() can deadlock .write()
	drivers/s390/char/fs3270.c:488:1-17: ERROR: fs3270_fops: .read() can deadlock .write()
	drivers/usb/misc/ldusb.c:310:1-17: ERROR: ld_usb_fops: .read() can deadlock .write()
	drivers/hid/uhid.c:635:1-17: ERROR: uhid_fops: .read() can deadlock .write()
	net/batman-adv/icmp_socket.c:80:1-17: ERROR: batadv_fops: .read() can deadlock .write()
	drivers/media/rc/lirc_dev.c:198:1-17: ERROR: lirc_fops: .read() can deadlock .write()
	drivers/leds/uleds.c:77:1-17: ERROR: uleds_fops: .read() can deadlock .write()
	drivers/input/misc/uinput.c:400:1-17: ERROR: uinput_fops: .read() can deadlock .write()
	drivers/infiniband/core/user_mad.c:985:7-23: ERROR: umad_fops: .read() can deadlock .write()
	drivers/gnss/core.c:45:1-17: ERROR: gnss_fops: .read() can deadlock .write()

In addition to the cases above another regression caused by f_pos
locking is that now FUSE filesystems that implement open with
FOPEN_NONSEEKABLE flag, can no longer implement bidirectional
stream-like files - for the same reason as above e.g. read can deadlock
write locking on file.f_pos in the kernel.

FUSE's FOPEN_NONSEEKABLE was added in 2008 in a7c1b990f715 ("fuse:
implement nonseekable open") to support OSSPD. OSSPD implements /dev/dsp
in userspace with FOPEN_NONSEEKABLE flag, with corresponding read and
write routines not depending on current position at all, and with both
read and write being potentially blocking operations:

See

    https://github.com/libfuse/osspd
    https://lwn.net/Articles/308445

    https://github.com/libfuse/osspd/blob/14a9cff0/osspd.c#L1406
    https://github.com/libfuse/osspd/blob/14a9cff0/osspd.c#L1438-L1477
    https://github.com/libfuse/osspd/blob/14a9cff0/osspd.c#L1479-L1510

Corresponding libfuse example/test also describes FOPEN_NONSEEKABLE as
"somewhat pipe-like files ..." with read handler not using offset.
However that test implements only read without write and cannot exercise
the deadlock scenario:

    https://github.com/libfuse/libfuse/blob/fuse-3.4.2-3-ga1bff7d/example/poll.c#L124-L131
    https://github.com/libfuse/libfuse/blob/fuse-3.4.2-3-ga1bff7d/example/poll.c#L146-L163
    https://github.com/libfuse/libfuse/blob/fuse-3.4.2-3-ga1bff7d/example/poll.c#L209-L216

I've actually hit the read vs write deadlock for real while implementing
my FUSE filesystem where there is /head/watch file, for which open
creates separate bidirectional socket-like stream in between filesystem
and its user with both read and write being later performed
simultaneously. And there it is semantically not easy to split the
stream into two separate read-only and write-only channels:

    https://lab.nexedi.com/kirr/wendelin.core/blob/f13aa600/wcfs/wcfs.go#L88-169

Let's fix this regression. The plan is:

1. We can't change nonseekable_open to include &~FMODE_ATOMIC_POS -
   doing so would break many in-kernel nonseekable_open users which
   actually use ppos in read/write handlers.

2. Add stream_open() to kernel to open stream-like non-seekable file
   descriptors. Read and write on such file descriptors would never use
   nor change ppos. And with that property on stream-like files read and
   write will be running without taking f_pos lock - i.e. read and write
   could be running simultaneously.

3. With semantic patch search and convert to stream_open all in-kernel
   nonseekable_open users for which read and write actually do not
   depend on ppos and where there is no other methods in file_operations
   which assume @offset access.

4. Add FOPEN_STREAM to fs/fuse/ and open in-kernel file-descriptors via
   steam_open if that bit is present in filesystem open reply.

   It was tempting to change fs/fuse/ open handler to use stream_open
   instead of nonseekable_open on just FOPEN_NONSEEKABLE flags, but
   grepping through Debian codesearch shows users of FOPEN_NONSEEKABLE,
   and in particular GVFS which actually uses offset in its read and
   write handlers

	https://codesearch.debian.net/search?q=-%3Enonseekable+%3D
	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1080
	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1247-1346
	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1399-1481

   so if we would do such a change it will break a real user.

5. Add stream_open and FOPEN_STREAM handling to stable kernels starting
   from v3.14+ (the kernel where 9c225f2655 first appeared).

   This will allow to patch OSSPD and other FUSE filesystems that
   provide stream-like files to return FOPEN_STREAM | FOPEN_NONSEEKABLE
   in their open handler and this way avoid the deadlock on all kernel
   versions. This should work because fs/fuse/ ignores unknown open
   flags returned from a filesystem and so passing FOPEN_STREAM to a
   kernel that is not aware of this flag cannot hurt. In turn the kernel
   that is not aware of FOPEN_STREAM will be < v3.14 where just
   FOPEN_NONSEEKABLE is sufficient to implement streams without read vs
   write deadlock.

This patch adds stream_open, converts /proc/xen/xenbus to it and adds
semantic patch to automatically locate in-kernel places that are either
required to be converted due to read vs write deadlock, or that are just
safe to be converted because read and write do not use ppos and there
are no other funky methods in file_operations.

Regarding semantic patch I've verified each generated change manually -
that it is correct to convert - and each other nonseekable_open instance
left - that it is either not correct to convert there, or that it is not
converted due to current stream_open.cocci limitations.

The script also does not convert files that should be valid to convert,
but that currently have .llseek = noop_llseek or generic_file_llseek for
unknown reason despite file being opened with nonseekable_open (e.g.
drivers/input/mousedev.c)

Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Yongzhi Pan <panyongzhi@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Tejun Heo <tj@kernel.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Nikolaus Rath <Nikolaus@rath.org>
Cc: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ backport to 4.4: actually fixed deadlock on /proc/xen/xenbus as 581d21a2d02a was not backported to 4.4 ]
---
 drivers/xen/xenbus/xenbus_dev_frontend.c |   2 +-
 fs/open.c                                |  18 ++
 fs/read_write.c                          |   5 +-
 include/linux/fs.h                       |   4 +
 scripts/coccinelle/api/stream_open.cocci | 363 +++++++++++++++++++++++
 5 files changed, 389 insertions(+), 3 deletions(-)
 create mode 100644 scripts/coccinelle/api/stream_open.cocci

diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 816a0e08ef10..d7591efa7775 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -536,7 +536,7 @@ static int xenbus_file_open(struct inode *inode, struct file *filp)
 	if (xen_store_evtchn == 0)
 		return -ENOENT;
 
-	nonseekable_open(inode, filp);
+	stream_open(inode, filp);
 
 	u = kzalloc(sizeof(*u), GFP_KERNEL);
 	if (u == NULL)
diff --git a/fs/open.c b/fs/open.c
index fbc5c7b230b3..6cf516156111 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1152,3 +1152,21 @@ int nonseekable_open(struct inode *inode, struct file *filp)
 }
 
 EXPORT_SYMBOL(nonseekable_open);
+
+/*
+ * stream_open is used by subsystems that want stream-like file descriptors.
+ * Such file descriptors are not seekable and don't have notion of position
+ * (file.f_pos is always 0). Contrary to file descriptors of other regular
+ * files, .read() and .write() can run simultaneously.
+ *
+ * stream_open never fails and is marked to return int so that it could be
+ * directly used as file_operations.open .
+ */
+int stream_open(struct inode *inode, struct file *filp)
+{
+	filp->f_mode &= ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE | FMODE_ATOMIC_POS);
+	filp->f_mode |= FMODE_STREAM;
+	return 0;
+}
+
+EXPORT_SYMBOL(stream_open);
diff --git a/fs/read_write.c b/fs/read_write.c
index 16e554ba885d..7b175b9134ec 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -553,12 +553,13 @@ EXPORT_SYMBOL(vfs_write);
 
 static inline loff_t file_pos_read(struct file *file)
 {
-	return file->f_pos;
+	return file->f_mode & FMODE_STREAM ? 0 : file->f_pos;
 }
 
 static inline void file_pos_write(struct file *file, loff_t pos)
 {
-	file->f_pos = pos;
+	if ((file->f_mode & FMODE_STREAM) == 0)
+		file->f_pos = pos;
 }
 
 SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 13277d2715df..26c4bf47cc99 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -140,6 +140,9 @@ typedef void (dax_iodone_t)(struct buffer_head *bh_map, int uptodate);
 /* Has write method(s) */
 #define FMODE_CAN_WRITE         ((__force fmode_t)0x40000)
 
+/* File is stream-like */
+#define FMODE_STREAM		((__force fmode_t)0x200000)
+
 /* File was opened by fanotify and shouldn't generate fanotify events */
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
 
@@ -2706,6 +2709,7 @@ extern loff_t fixed_size_llseek(struct file *file, loff_t offset,
 		int whence, loff_t size);
 extern int generic_file_open(struct inode * inode, struct file * filp);
 extern int nonseekable_open(struct inode * inode, struct file * filp);
+extern int stream_open(struct inode * inode, struct file * filp);
 
 #ifdef CONFIG_BLOCK
 typedef void (dio_submit_t)(int rw, struct bio *bio, struct inode *inode,
diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
new file mode 100644
index 000000000000..350145da7669
--- /dev/null
+++ b/scripts/coccinelle/api/stream_open.cocci
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+// Author: Kirill Smelkov (kirr@nexedi.com)
+//
+// Search for stream-like files that are using nonseekable_open and convert
+// them to stream_open. A stream-like file is a file that does not use ppos in
+// its read and write. Rationale for the conversion is to avoid deadlock in
+// between read and write.
+
+virtual report
+virtual patch
+virtual explain  // explain decisions in the patch (SPFLAGS="-D explain")
+
+// stream-like reader & writer - ones that do not depend on f_pos.
+@ stream_reader @
+identifier readstream, ppos;
+identifier f, buf, len;
+type loff_t;
+@@
+  ssize_t readstream(struct file *f, char *buf, size_t len, loff_t *ppos)
+  {
+    ... when != ppos
+  }
+
+@ stream_writer @
+identifier writestream, ppos;
+identifier f, buf, len;
+type loff_t;
+@@
+  ssize_t writestream(struct file *f, const char *buf, size_t len, loff_t *ppos)
+  {
+    ... when != ppos
+  }
+
+
+// a function that blocks
+@ blocks @
+identifier block_f;
+identifier wait_event =~ "^wait_event_.*";
+@@
+  block_f(...) {
+    ... when exists
+    wait_event(...)
+    ... when exists
+  }
+
+// stream_reader that can block inside.
+//
+// XXX wait_* can be called not directly from current function (e.g. func -> f -> g -> wait())
+// XXX currently reader_blocks supports only direct and 1-level indirect cases.
+@ reader_blocks_direct @
+identifier stream_reader.readstream;
+identifier wait_event =~ "^wait_event_.*";
+@@
+  readstream(...)
+  {
+    ... when exists
+    wait_event(...)
+    ... when exists
+  }
+
+@ reader_blocks_1 @
+identifier stream_reader.readstream;
+identifier blocks.block_f;
+@@
+  readstream(...)
+  {
+    ... when exists
+    block_f(...)
+    ... when exists
+  }
+
+@ reader_blocks depends on reader_blocks_direct || reader_blocks_1 @
+identifier stream_reader.readstream;
+@@
+  readstream(...) {
+    ...
+  }
+
+
+// file_operations + whether they have _any_ .read, .write, .llseek ... at all.
+//
+// XXX add support for file_operations xxx[N] = ...	(sound/core/pcm_native.c)
+@ fops0 @
+identifier fops;
+@@
+  struct file_operations fops = {
+    ...
+  };
+
+@ has_read @
+identifier fops0.fops;
+identifier read_f;
+@@
+  struct file_operations fops = {
+    .read = read_f,
+  };
+
+@ has_read_iter @
+identifier fops0.fops;
+identifier read_iter_f;
+@@
+  struct file_operations fops = {
+    .read_iter = read_iter_f,
+  };
+
+@ has_write @
+identifier fops0.fops;
+identifier write_f;
+@@
+  struct file_operations fops = {
+    .write = write_f,
+  };
+
+@ has_write_iter @
+identifier fops0.fops;
+identifier write_iter_f;
+@@
+  struct file_operations fops = {
+    .write_iter = write_iter_f,
+  };
+
+@ has_llseek @
+identifier fops0.fops;
+identifier llseek_f;
+@@
+  struct file_operations fops = {
+    .llseek = llseek_f,
+  };
+
+@ has_no_llseek @
+identifier fops0.fops;
+@@
+  struct file_operations fops = {
+    .llseek = no_llseek,
+  };
+
+@ has_mmap @
+identifier fops0.fops;
+identifier mmap_f;
+@@
+  struct file_operations fops = {
+    .mmap = mmap_f,
+  };
+
+@ has_copy_file_range @
+identifier fops0.fops;
+identifier copy_file_range_f;
+@@
+  struct file_operations fops = {
+    .copy_file_range = copy_file_range_f,
+  };
+
+@ has_remap_file_range @
+identifier fops0.fops;
+identifier remap_file_range_f;
+@@
+  struct file_operations fops = {
+    .remap_file_range = remap_file_range_f,
+  };
+
+@ has_splice_read @
+identifier fops0.fops;
+identifier splice_read_f;
+@@
+  struct file_operations fops = {
+    .splice_read = splice_read_f,
+  };
+
+@ has_splice_write @
+identifier fops0.fops;
+identifier splice_write_f;
+@@
+  struct file_operations fops = {
+    .splice_write = splice_write_f,
+  };
+
+
+// file_operations that is candidate for stream_open conversion - it does not
+// use mmap and other methods that assume @offset access to file.
+//
+// XXX for simplicity require no .{read/write}_iter and no .splice_{read/write} for now.
+// XXX maybe_steam.fops cannot be used in other rules - it gives "bad rule maybe_stream or bad variable fops".
+@ maybe_stream depends on (!has_llseek || has_no_llseek) && !has_mmap && !has_copy_file_range && !has_remap_file_range && !has_read_iter && !has_write_iter && !has_splice_read && !has_splice_write @
+identifier fops0.fops;
+@@
+  struct file_operations fops = {
+  };
+
+
+// ---- conversions ----
+
+// XXX .open = nonseekable_open -> .open = stream_open
+// XXX .open = func -> openfunc -> nonseekable_open
+
+// read & write
+//
+// if both are used in the same file_operations together with an opener -
+// under that conditions we can use stream_open instead of nonseekable_open.
+@ fops_rw depends on maybe_stream @
+identifier fops0.fops, openfunc;
+identifier stream_reader.readstream;
+identifier stream_writer.writestream;
+@@
+  struct file_operations fops = {
+      .open  = openfunc,
+      .read  = readstream,
+      .write = writestream,
+  };
+
+@ report_rw depends on report @
+identifier fops_rw.openfunc;
+position p1;
+@@
+  openfunc(...) {
+    <...
+     nonseekable_open@p1
+    ...>
+  }
+
+@ script:python depends on report && reader_blocks @
+fops << fops0.fops;
+p << report_rw.p1;
+@@
+coccilib.report.print_report(p[0],
+  "ERROR: %s: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix." % (fops,))
+
+@ script:python depends on report && !reader_blocks @
+fops << fops0.fops;
+p << report_rw.p1;
+@@
+coccilib.report.print_report(p[0],
+  "WARNING: %s: .read() and .write() have stream semantic; safe to change nonseekable_open -> stream_open." % (fops,))
+
+
+@ explain_rw_deadlocked depends on explain && reader_blocks @
+identifier fops_rw.openfunc;
+@@
+  openfunc(...) {
+    <...
+-    nonseekable_open
++    nonseekable_open /* read & write (was deadlock) */
+    ...>
+  }
+
+
+@ explain_rw_nodeadlock depends on explain && !reader_blocks @
+identifier fops_rw.openfunc;
+@@
+  openfunc(...) {
+    <...
+-    nonseekable_open
++    nonseekable_open /* read & write (no direct deadlock) */
+    ...>
+  }
+
+@ patch_rw depends on patch @
+identifier fops_rw.openfunc;
+@@
+  openfunc(...) {
+    <...
+-   nonseekable_open
++   stream_open
+    ...>
+  }
+
+
+// read, but not write
+@ fops_r depends on maybe_stream && !has_write @
+identifier fops0.fops, openfunc;
+identifier stream_reader.readstream;
+@@
+  struct file_operations fops = {
+      .open  = openfunc,
+      .read  = readstream,
+  };
+
+@ report_r depends on report @
+identifier fops_r.openfunc;
+position p1;
+@@
+  openfunc(...) {
+    <...
+    nonseekable_open@p1
+    ...>
+  }
+
+@ script:python depends on report @
+fops << fops0.fops;
+p << report_r.p1;
+@@
+coccilib.report.print_report(p[0],
+  "WARNING: %s: .read() has stream semantic; safe to change nonseekable_open -> stream_open." % (fops,))
+
+@ explain_r depends on explain @
+identifier fops_r.openfunc;
+@@
+  openfunc(...) {
+    <...
+-   nonseekable_open
++   nonseekable_open /* read only */
+    ...>
+  }
+
+@ patch_r depends on patch @
+identifier fops_r.openfunc;
+@@
+  openfunc(...) {
+    <...
+-   nonseekable_open
++   stream_open
+    ...>
+  }
+
+
+// write, but not read
+@ fops_w depends on maybe_stream && !has_read @
+identifier fops0.fops, openfunc;
+identifier stream_writer.writestream;
+@@
+  struct file_operations fops = {
+      .open  = openfunc,
+      .write = writestream,
+  };
+
+@ report_w depends on report @
+identifier fops_w.openfunc;
+position p1;
+@@
+  openfunc(...) {
+    <...
+    nonseekable_open@p1
+    ...>
+  }
+
+@ script:python depends on report @
+fops << fops0.fops;
+p << report_w.p1;
+@@
+coccilib.report.print_report(p[0],
+  "WARNING: %s: .write() has stream semantic; safe to change nonseekable_open -> stream_open." % (fops,))
+
+@ explain_w depends on explain @
+identifier fops_w.openfunc;
+@@
+  openfunc(...) {
+    <...
+-   nonseekable_open
++   nonseekable_open /* write only */
+    ...>
+  }
+
+@ patch_w depends on patch @
+identifier fops_w.openfunc;
+@@
+  openfunc(...) {
+    <...
+-   nonseekable_open
++   stream_open
+    ...>
+  }
+
+
+// no read, no write - don't change anything
-- 
2.20.1
