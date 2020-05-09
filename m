Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEAB1CBCCF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 05:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgEIDLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 23:11:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42361 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgEIDLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 23:11:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id n11so1789109pgl.9;
        Fri, 08 May 2020 20:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+N98j7Uw/XgQMz0eucqhw8vB6Ont3YdqTGvm5jrEkk=;
        b=Dd8xK61I1LZEMfTTT8tJ7nIhxsaoHvPGczzdYKDxDRDEKmH98yEaWtGeZl/mcYolQw
         YuT3OSFtrHwy/Keg1eJ3g0mRtRHU0OjR081T7LdRDDR0mSUlmqkZ3dv3GMWODm3R1UsL
         obYnm4l5UF9QP4bZZgjTg3vhfYVFuHMfZzUKsTxZ4PT0r3Tb0I6QEbAifby4te4e7+fM
         gubS/3BfkqcqAxZ/PWHofUJdrfmOghovjbtyVUF+vzbunnRGNOHVvuQMr1/TTz7zLzBT
         +NOzyEQPJnoh70YDe36TuU2JNeUYn+ukSov/gOyFpnZiIigMgYD6rRQQ2T+8ml3xdvYg
         tUXA==
X-Gm-Message-State: AGi0PuaoYTwejPKh23Iu03nT1xhgDfYDMaX4ParWKkn9R+Z6S08oafko
        MWd7/+Iu9NmEg/UldZKYS4w=
X-Google-Smtp-Source: APiQypKtd+3OZRFx+NniDMniNMYSjUjwR4ST9j1pimJhPsHP/tSPxVTNzxIjsuWHyzxYKXMGT08Rlw==
X-Received: by 2002:a65:460f:: with SMTP id v15mr4718325pgq.24.1588993865079;
        Fri, 08 May 2020 20:11:05 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a196sm3195827pfd.184.2020.05.08.20.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 20:11:00 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EBCC041D00; Sat,  9 May 2020 03:10:59 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christof Schmitt <christof.schmitt@de.ibm.com>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: [PATCH v4 3/5] blktrace: fix debugfs use after free
Date:   Sat,  9 May 2020 03:10:56 +0000
Message-Id: <20200509031058.8239-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200509031058.8239-1-mcgrof@kernel.org>
References: <20200509031058.8239-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On commit 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
merged on v4.12 Omar fixed the original blktrace code for request-based
drivers (multiqueue). This however left in place a possible crash, if you
happen to abuse blktrace while racing to remove / add a device.

We used to use asynchronous removal of the request_queue, and with that
the issue was easier to reproduce. Now that we have reverted to
synchronous removal of the request_queue, the issue is still possible to
reproduce, its however just a bit more difficult.

We essentially run two instances of break-blktrace which add/remove
a loop device, and setup a blktrace and just never tear the blktrace
down. We do this twice in parallel. This is easily reproduced with the
break-blktrace run_0004.sh script.

We can end up with two types of panics each reflecting where we
race, one a failed blktrace setup:

[  252.426751] debugfs: Directory 'loop0' with parent 'block' already present!
[  252.432265] BUG: kernel NULL pointer dereference, address: 00000000000000a0
[  252.436592] #PF: supervisor write access in kernel mode
[  252.439822] #PF: error_code(0x0002) - not-present page
[  252.442967] PGD 0 P4D 0
[  252.444656] Oops: 0002 [#1] SMP NOPTI
[  252.446972] CPU: 10 PID: 1153 Comm: break-blktrace Tainted: G            E     5.7.0-rc2-next-20200420+ #164
[  252.452673] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
[  252.456343] RIP: 0010:down_write+0x15/0x40
[  252.458146] Code: eb ca e8 ae 22 8d ff cc cc cc cc cc cc cc cc cc cc cc cc
               cc cc 0f 1f 44 00 00 55 48 89 fd e8 52 db ff ff 31 c0 ba 01 00
               00 00 <f0> 48 0f b1 55 00 75 0f 48 8b 04 25 c0 8b 01 00 48 89
               45 08 5d
[  252.463638] RSP: 0018:ffffa626415abcc8 EFLAGS: 00010246
[  252.464950] RAX: 0000000000000000 RBX: ffff958c25f0f5c0 RCX: ffffff8100000000
[  252.466727] RDX: 0000000000000001 RSI: ffffff8100000000 RDI: 00000000000000a0
[  252.468482] RBP: 00000000000000a0 R08: 0000000000000000 R09: 0000000000000001
[  252.470014] R10: 0000000000000000 R11: ffff958d1f9227ff R12: 0000000000000000
[  252.471473] R13: ffff958c25ea5380 R14: ffffffff8cce15f1 R15: 00000000000000a0
[  252.473346] FS:  00007f2e69dee540(0000) GS:ffff958c2fc80000(0000) knlGS:0000000000000000
[  252.475225] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  252.476267] CR2: 00000000000000a0 CR3: 0000000427d10004 CR4: 0000000000360ee0
[  252.477526] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  252.478776] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  252.479866] Call Trace:
[  252.480322]  simple_recursive_removal+0x4e/0x2e0
[  252.481078]  ? debugfs_remove+0x60/0x60
[  252.481725]  ? relay_destroy_buf+0x77/0xb0
[  252.482662]  debugfs_remove+0x40/0x60
[  252.483518]  blk_remove_buf_file_callback+0x5/0x10
[  252.484328]  relay_close_buf+0x2e/0x60
[  252.484930]  relay_open+0x1ce/0x2c0
[  252.485520]  do_blk_trace_setup+0x14f/0x2b0
[  252.486187]  __blk_trace_setup+0x54/0xb0
[  252.486803]  blk_trace_ioctl+0x90/0x140
[  252.487423]  ? do_sys_openat2+0x1ab/0x2d0
[  252.488053]  blkdev_ioctl+0x4d/0x260
[  252.488636]  block_ioctl+0x39/0x40
[  252.489139]  ksys_ioctl+0x87/0xc0
[  252.489675]  __x64_sys_ioctl+0x16/0x20
[  252.490380]  do_syscall_64+0x52/0x180
[  252.491032]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

And the other on the device removal:

[  128.528940] debugfs: Directory 'loop0' with parent 'block' already present!
[  128.615325] BUG: kernel NULL pointer dereference, address: 00000000000000a0
[  128.619537] #PF: supervisor write access in kernel mode
[  128.622700] #PF: error_code(0x0002) - not-present page
[  128.625842] PGD 0 P4D 0
[  128.627585] Oops: 0002 [#1] SMP NOPTI
[  128.629871] CPU: 12 PID: 544 Comm: break-blktrace Tainted: G            E     5.7.0-rc2-next-20200420+ #164
[  128.635595] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
[  128.640471] RIP: 0010:down_write+0x15/0x40
[  128.643041] Code: eb ca e8 ae 22 8d ff cc cc cc cc cc cc cc cc cc cc cc cc
               cc cc 0f 1f 44 00 00 55 48 89 fd e8 52 db ff ff 31 c0 ba 01 00
               00 00 <f0> 48 0f b1 55 00 75 0f 65 48 8b 04 25 c0 8b 01 00 48 89
               45 08 5d
[  128.650180] RSP: 0018:ffffa9c3c05ebd78 EFLAGS: 00010246
[  128.651820] RAX: 0000000000000000 RBX: ffff8ae9a6370240 RCX: ffffff8100000000
[  128.653942] RDX: 0000000000000001 RSI: ffffff8100000000 RDI: 00000000000000a0
[  128.655720] RBP: 00000000000000a0 R08: 0000000000000002 R09: ffff8ae9afd2d3d0
[  128.657400] R10: 0000000000000056 R11: 0000000000000000 R12: 0000000000000000
[  128.659099] R13: 0000000000000000 R14: 0000000000000003 R15: 00000000000000a0
[  128.660500] FS:  00007febfd995540(0000) GS:ffff8ae9afd00000(0000) knlGS:0000000000000000
[  128.662204] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  128.663426] CR2: 00000000000000a0 CR3: 0000000420042003 CR4: 0000000000360ee0
[  128.664776] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  128.666022] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  128.667282] Call Trace:
[  128.667801]  simple_recursive_removal+0x4e/0x2e0
[  128.668663]  ? debugfs_remove+0x60/0x60
[  128.669368]  debugfs_remove+0x40/0x60
[  128.669985]  blk_trace_free+0xd/0x50
[  128.670593]  __blk_trace_remove+0x27/0x40
[  128.671274]  blk_trace_shutdown+0x30/0x40
[  128.671935]  blk_release_queue+0x95/0xf0
[  128.672589]  kobject_put+0xa5/0x1b0
[  128.673188]  disk_release+0xa2/0xc0
[  128.673786]  device_release+0x28/0x80
[  128.674376]  kobject_put+0xa5/0x1b0
[  128.674915]  loop_remove+0x39/0x50 [loop]
[  128.675511]  loop_control_ioctl+0x113/0x130 [loop]
[  128.676199]  ksys_ioctl+0x87/0xc0
[  128.676708]  __x64_sys_ioctl+0x16/0x20
[  128.677274]  do_syscall_64+0x52/0x180
[  128.677823]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

The common theme here is:

debugfs: Directory 'loop0' with parent 'block' already present

This crash happens because of how blktrace uses the debugfs directory
where it places its files. Upon init we always create the same directory
which would be needed by blktrace but we only do this for make_request
drivers (multiqueue) block drivers, but never for request-based block
drivers. Furthermore, that directory is only created on init for the
entire disk. This means that if you use blktrace on a partition, we'll
always be creating a new directory regardless of whether or not you
are doing blktrace on a make_request driver (multiqueue) or a
request-based block drivers.

These directory creations are only associated with a path, and so
when a debugfs_remove() is called it removes everything in its way.
A device removal will remove all blktrace files, and so if a blktrace
is still present a cleanup of blktrace files later will end up trying
to remove dentries pointing to NULL.

We can fix the UAF by using a debugfs directory which moving forward
will always be accessible if debugfs is enabled for both make_request
drivers (multiqueue) and request-based block drivers, *and* for all
partitions upon creation. This ensures that removal of the directories
only happens on device removal and removes the race of the files
underneath an active blktrace.

For partitions we simply symlink to the whole disk's debugfs_dir, as the
debugfs_dir is shared anyway and this limits us to only run one blktrace
for the entire disk.

We special-case a solution for scsi-generic which got blktrace support
added by Christof via commit 6da127ad0918 ("blktrace: Add blktrace
ioctls to SCSI generic devices") so upstream since v2.6.25. scsi-generic
drives use a character device, however behind the scenes we have a scsi
device with a request_queue. How this is used varies by class of driver
(TYPE_DISK, TYPE_TYPE, etc). Care has to be taken into consideration of
the fact that scsi drivers will probe asynchronously but the scsi-generic
class_interface sg_add_device() will complete before. This means
sd_probe() will use device_add_disk() for TYPE_DISK and have its
debugfs_dir created *after* the scsi-generic device is created.

For scsi-generic then we symlink to the real debugfs_dir only during a
blktrace ioctl, but we do this only once. We also have to special-case
yet another solution for drivers which use the bsg queue.

This goes tested with:

  o nvme partitions
  o ISCSI with tgt, and blktracing against scsi-generic with:
    o block
    o tape
    o cdrom
    o media changer

Screenshots of what the debugfs for block looks like after running
blktrace on a system with sg0  which has a raid controllerand then sg1
as the media changer:

 # ls -l /sys/kernel/debug/block
total 0
drwxr-xr-x  3 root root 0 May  9 02:31 bsg
drwxr-xr-x 19 root root 0 May  9 02:31 nvme0n1
drwxr-xr-x 19 root root 0 May  9 02:31 nvme1n1
lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p1 -> nvme1n1
lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p2 -> nvme1n1
lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p3 -> nvme1n1
lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p5 -> nvme1n1
lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p6 -> nvme1n1
drwxr-xr-x  2 root root 0 May  9 02:33 sch0
lrwxrwxrwx  1 root root 0 May  9 02:33 sg0 -> bsg/2:0:0:0
lrwxrwxrwx  1 root root 0 May  9 02:33 sg1 -> sch0
drwxr-xr-x  5 root root 0 May  9 02:31 vda
lrwxrwxrwx  1 root root 0 May  9 02:31 vda1 -> vda

Code for handling the  ebugfs_dir did get more complicatd for
scsi-generic but this is technical debt. For the other types of devices,
this simplifies the code considerably, with the only penalty now being
that we're always creating the request queue debugfs directory for the
request-based block device drivers.

The symlink use also makes it clearer when the request_queue is shared.

This patch is part of the work which disputes the severity of
CVE-2019-19770 which shows this issue is not a core debugfs issue, but
a misuse of debugfs within blktace.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: yu kuai <yukuai3@huawei.com>
Cc: Christof Schmitt <christof.schmitt@de.ibm.com>
Reported-by: syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Fixes: 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-debugfs.c          | 187 +++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.c       |   5 -
 block/blk-sysfs.c            |   3 +
 block/blk.h                  |  16 +++
 block/bsg.c                  |   2 +
 block/partitions/core.c      |   9 ++
 drivers/scsi/ch.c            |   1 +
 drivers/scsi/sg.c            |  75 ++++++++++++++
 drivers/scsi/st.c            |   2 +
 include/linux/blkdev.h       |   4 +-
 include/linux/blktrace_api.h |   1 -
 include/linux/genhd.h        |  69 +++++++++++++
 kernel/trace/blktrace.c      |  24 +++--
 13 files changed, 385 insertions(+), 13 deletions(-)

diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
index 19091e1effc0..d40f12aecf8a 100644
--- a/block/blk-debugfs.c
+++ b/block/blk-debugfs.c
@@ -8,8 +8,195 @@
 #include <linux/debugfs.h>
 
 struct dentry *blk_debugfs_root;
+struct dentry *blk_debugfs_bsg = NULL;
+
+/**
+ * enum blk_debugfs_dir_type - block device debugfs directory type
+ * @BLK_DBG_DIR_BASE: the block device debugfs_dir exists on the base
+ * 	system <system-debugfs-dir>/block/ debugfs directory.
+ * @BLK_DBG_DIR_BSG: the block device debugfs_dir is under the directory
+ * 	<system-debugfs-dir>/block/bsg/
+ */
+enum blk_debugfs_dir_type {
+	BLK_DBG_DIR_BASE = 1,
+	BLK_DBG_DIR_BSG,
+};
 
 void blk_debugfs_register(void)
 {
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
 }
+
+static struct dentry *queue_get_base_dir(enum blk_debugfs_dir_type type)
+{
+	switch (type) {
+	case BLK_DBG_DIR_BASE:
+		return blk_debugfs_root;
+	case BLK_DBG_DIR_BSG:
+		return blk_debugfs_bsg;
+	}
+	return NULL;
+}
+
+static void queue_debugfs_register_type(struct request_queue *q,
+					const char *name,
+					enum blk_debugfs_dir_type type)
+{
+	struct dentry *base_dir = queue_get_base_dir(type);
+
+	q->debugfs_dir = debugfs_create_dir(name, base_dir);
+}
+
+/**
+ * blk_queue_debugfs_register - register the debugfs_dir for the block device
+ * @q: the associated request_queue of the block device
+ * @name: the name of the block device exposed
+ *
+ * This is used to create the debugfs_dir used by the block layer and blktrace.
+ * Drivers which use any of the *add_disk*() calls or variants have this called
+ * automatically for them. This directory is removed automatically on
+ * blk_release_queue() once the request_queue reference count reaches 0.
+ */
+void blk_queue_debugfs_register(struct request_queue *q, const char *name)
+{
+	queue_debugfs_register_type(q, name, BLK_DBG_DIR_BASE);
+}
+EXPORT_SYMBOL_GPL(blk_queue_debugfs_register);
+
+/**
+ * blk_queue_debugfs_unregister - remove the debugfs_dir for the block device
+ * @q: the associated request_queue of the block device
+ *
+ * Removes the debugfs_dir for the request_queue on the associated block device.
+ * This is handled for you on blk_release_queue(), and that should only be
+ * called once.
+ *
+ * Since we don't care where the debugfs_dir was created this is used for all
+ * types of of enum blk_debugfs_dir_type.
+ */
+void blk_queue_debugfs_unregister(struct request_queue *q)
+{
+	debugfs_remove_recursive(q->debugfs_dir);
+}
+
+static struct dentry *queue_debugfs_symlink_type(struct request_queue *q,
+						 const char *src,
+						 const char *dst,
+						 enum blk_debugfs_dir_type type)
+{
+	struct dentry *dentry = ERR_PTR(-EINVAL);
+	char *dir_dst;
+
+	dir_dst = kzalloc(PATH_MAX, GFP_KERNEL);
+	if (!dir_dst)
+		return dentry;
+
+	switch (type) {
+	case BLK_DBG_DIR_BASE:
+		if (dst)
+			snprintf(dir_dst, PATH_MAX, "%s", dst);
+		else if (!IS_ERR_OR_NULL(q->debugfs_dir))
+			snprintf(dir_dst, PATH_MAX, "%s",
+				 q->debugfs_dir->d_name.name);
+		else
+			goto out;
+		break;
+	case BLK_DBG_DIR_BSG:
+		if (dst)
+			snprintf(dir_dst, PATH_MAX, "bsg/%s", dst);
+		else
+			goto out;
+		break;
+	}
+
+	/*
+	 * The base block debugfs directory is always used for the symlinks,
+	 * their target is what changes.
+	 */
+	dentry = debugfs_create_symlink(src, blk_debugfs_root, dir_dst);
+out:
+	kfree(dir_dst);
+
+	return dentry;
+}
+
+/**
+ * blk_queue_debugfs_symlink - symlink to the real block device debugfs_dir
+ * @q: the request queue where we know the debugfs_dir exists or will exist
+ *     eventually. Cannot be NULL.
+ * @src: name of the exposed device we wish to associate to the block device
+ * @dst: the name of the directory to which we want to symlink to, may be NULL
+ *	 if you do not know what this may be, but only if your base block device
+ *	 is not bsg. If you set this to NULL, we will have no other option but
+ *	 to look at the request_queue to infer the name, but you must ensure
+ *	 it is already be set, be mindful of asynchronous probes.
+ *
+ * Some devices don't have a request_queue of their own, however, they have an
+ * association to one and have historically supported using the same
+ * debugfs_dir which has been used to represent the whole disk for blktrace
+ * functionality. Such is the case for partitions and for scsi-generic devices.
+ * They share the same request_queue and debugfs_dir as with the whole disk for
+ * blktrace purposes.  This helper allows such association to be made explicit
+ * and enable blktrace functionality for them. scsi-generic devices representing
+ * scsi device such as block, cdrom, tape, media changer register their own
+ * debug_dir already and share the same request_queue as with scsi-generic, as
+ * such the respective scsi-generic debugfs_dir is just a symlink to these
+ * driver's debugfs_dir.
+ *
+ * To remove use debugfs_remove() on the symlink dentry returned by this
+ * function. The block layer will not clean this up for you, you must remove
+ * it yourself in case of device removal.
+ */
+struct dentry *blk_queue_debugfs_symlink(struct request_queue *q,
+					 const char *src,
+					 const char *dst)
+{
+	return queue_debugfs_symlink_type(q, src, dst, BLK_DBG_DIR_BASE);
+}
+EXPORT_SYMBOL_GPL(blk_queue_debugfs_symlink);
+
+#ifdef CONFIG_BLK_DEV_BSG
+
+void blk_debugfs_register_bsg(void)
+{
+	blk_debugfs_bsg = debugfs_create_dir("bsg", blk_debugfs_root);
+}
+
+/**
+ * blk_queue_debugfs_register_bsg - create the debugfs_dir for bsg block devices
+ * @q: the associated request_queue of the block device
+ * @name: the name of the block device exposed
+ *
+ * This is used to create the debugfs_dir used by the Block layer SCSI generic
+ * (bsg) driver. This is to be used only by the scsi-generic driver on behalf
+ * of scsi devices which work as scsi controllers or transports.
+ *
+ * This directory is cleaned up for all drivers automatically on
+ * blk_release_queue() once the request_queue reference count reaches 0.
+ */
+void blk_queue_debugfs_register_bsg(struct request_queue *q, const char *name)
+{
+	queue_debugfs_register_type(q, name, BLK_DBG_DIR_BSG);
+}
+EXPORT_SYMBOL_GPL(blk_queue_debugfs_register_bsg);
+
+/**
+ * blk_queue_debugfs_symlink_bsg - symlink to the bsg debugfs_dir
+ * @q: the request queue where we know the debugfs_dir exists or will exist
+ *     eventually. Cannot be NULL.
+ * @src: name of the scsi-generic device we wish to associate to the bsg
+ * 	request_queue.
+ * @dst: the name of the bsg request_queue debugfs_dir to which we want to
+ *	 symlink to. This cannot be NULL.
+ *
+ * This is used by scsi-generic devices representing raid controllers /
+ * transport drivers.
+ */
+struct dentry *blk_queue_debugfs_bsg_symlink(struct request_queue *q,
+					     const char *src,
+					     const char *dst)
+{
+	return queue_debugfs_symlink_type(q, src, dst, BLK_DBG_DIR_BSG);
+}
+EXPORT_SYMBOL_GPL(blk_queue_debugfs_bsg_symlink);
+#endif /* CONFIG_BLK_DEV_BSG */
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 96b7a35c898a..08edc3a54114 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -822,9 +822,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
-					    blk_debugfs_root);
-
 	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	/*
@@ -855,9 +852,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 void blk_mq_debugfs_unregister(struct request_queue *q)
 {
-	debugfs_remove_recursive(q->debugfs_dir);
 	q->sched_debugfs_dir = NULL;
-	q->debugfs_dir = NULL;
 }
 
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 5d0fc165a036..1d151f19bd87 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -905,6 +905,7 @@ static void blk_release_queue(struct kobject *kobj)
 
 	blk_trace_shutdown(q);
 
+	blk_queue_debugfs_unregister(q);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
 
@@ -976,6 +977,8 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
+	blk_queue_debugfs_register(q, kobject_name(q->kobj.parent));
+
 	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
diff --git a/block/blk.h b/block/blk.h
index ec16e8a6049e..f7ace11c8bd1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -458,10 +458,26 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		bool *same_page);
 #ifdef CONFIG_DEBUG_FS
 void blk_debugfs_register(void);
+void blk_queue_debugfs_unregister(struct request_queue *q);
+void blk_part_debugfs_register(struct hd_struct *p, const char *name);
+void blk_part_debugfs_unregister(struct hd_struct *p);
 #else
 static inline void blk_debugfs_register(void)
 {
 }
+
+static inline void blk_queue_debugfs_unregister(struct request_queue *q)
+{
+}
+
+static inline void blk_part_debugfs_register(struct hd_struct *p,
+					     const char *name)
+{
+}
+
+static inline void blk_part_debugfs_unregister(struct hd_struct *p)
+{
+}
 #endif /* CONFIG_DEBUG_FS */
 
 #endif /* BLK_INTERNAL_H */
diff --git a/block/bsg.c b/block/bsg.c
index d7bae94b64d9..bfb1036858c4 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -503,6 +503,8 @@ static int __init bsg_init(void)
 	if (ret)
 		goto unregister_chrdev;
 
+	blk_debugfs_register_bsg();
+
 	printk(KERN_INFO BSG_DESCRIPTION " version " BSG_VERSION
 	       " loaded (major %d)\n", bsg_major);
 	return 0;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 873999e2e2f2..a96b2418e70d 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -10,6 +10,7 @@
 #include <linux/vmalloc.h>
 #include <linux/blktrace_api.h>
 #include <linux/raid/detect.h>
+#include <linux/debugfs.h>
 #include "check.h"
 
 static int (*check_part[])(struct parsed_partitions *) = {
@@ -309,6 +310,9 @@ void delete_partition(struct gendisk *disk, struct hd_struct *part)
 	struct disk_part_tbl *ptbl =
 		rcu_dereference_protected(disk->part_tbl, 1);
 
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove(part->debugfs_sym);
+#endif
 	rcu_assign_pointer(ptbl->part[part->partno], NULL);
 	rcu_assign_pointer(ptbl->last_lookup, NULL);
 	kobject_put(part->holder_dir);
@@ -450,6 +454,11 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	/* everything is up and running, commence */
 	rcu_assign_pointer(ptbl->part[partno], p);
 
+#ifdef CONFIG_DEBUG_FS
+	p->debugfs_sym = blk_queue_debugfs_symlink(disk->queue, dev_name(pdev),
+						   disk->disk_name);
+#endif
+
 	/* suppress uevent if the disk suppresses it */
 	if (!dev_get_uevent_suppress(ddev))
 		kobject_uevent(&pdev->kobj, KOBJ_ADD);
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index cb74ab1ae5a4..5dfabc04bfef 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -971,6 +971,7 @@ static int ch_probe(struct device *dev)
 
 	mutex_unlock(&ch->lock);
 	dev_set_drvdata(dev, ch);
+	blk_queue_debugfs_register(sd->request_queue, dev_name(class_dev));
 	sdev_printk(KERN_INFO, sd, "Attached scsi changer %s\n", ch->name);
 
 	return 0;
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 20472aaaf630..6fa201086e59 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -47,6 +47,7 @@ static int sg_version_num = 30536;	/* 2 digits for each component */
 #include <linux/ratelimit.h>
 #include <linux/uio.h>
 #include <linux/cred.h> /* for sg_check_file_access() */
+#include <linux/debugfs.h>
 
 #include "scsi.h"
 #include <scsi/scsi_dbg.h>
@@ -169,6 +170,10 @@ typedef struct sg_device { /* holds the state of each scsi generic device */
 	struct gendisk *disk;
 	struct cdev * cdev;	/* char_dev [sysfs: /sys/cdev/major/sg<n>] */
 	struct kref d_ref;
+#ifdef CONFIG_DEBUG_FS
+	bool debugfs_set;
+	struct dentry *debugfs_sym;
+#endif
 } Sg_device;
 
 /* tasklet or soft irq callback */
@@ -914,6 +919,72 @@ static int put_compat_request_table(struct compat_sg_req_info __user *o,
 }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+/*
+ * For scsi-generic devices like TYPE_DISK will re-use the scsi_device
+ * request_queue on their driver for their disk and later device_add_disk() it,
+ * we want its respective scsi-generic debugfs_dir to just be a symlink to the
+ * one created on the real scsi device probe.
+ *
+ * We use this on the ioctl path instead of sg_add_device() since some driver
+ * probes can run asynchronously. Such is the case for scsi devices of
+ * TYPE_DISK, and the class interface currently has no callbacks once a device
+ * driver probe has completed its probe. We don't use wait_for_device_probe()
+ * on sg_add_device() as that would defeat the purpose of using asynchronous
+ * probe.
+ */
+static void sg_init_blktrace_setup(Sg_device *sdp)
+{
+	struct scsi_device *scsidp = sdp->device;
+	struct device *scsi_dev = &scsidp->sdev_gendev;
+	struct gendisk *sg_disk = sdp->disk;
+	struct request_queue *q = scsidp->request_queue;
+
+	/*
+	 * Although debugfs is used for debugging purposes and we
+	 * typically don't care about the return value, we do here
+	 * because we use it for userspace to ensure blktrace works.
+	 *
+	 * Instead of always just checking for the return value though,
+	 * just try setting this once, if the first time failed we don't
+	 * try again.
+	 */
+	if (sdp->debugfs_set)
+		return;
+
+	switch (sdp->device->type) {
+	case TYPE_RAID:
+		/*
+		 * We do the registration for bsg here to keep bsg scsi_device
+		 * opaque. If bsg is disabled we just create the debugfs_dir on
+		 * the base block debugfs_dir and scsi-generic symlinks to it.
+		 */
+		blk_queue_debugfs_register_bsg(q, dev_name(scsi_dev));
+		sdp->debugfs_sym =
+			blk_queue_debugfs_bsg_symlink(q,
+						      sg_disk->disk_name,
+						      dev_name(scsi_dev));
+		break;
+	default:
+		/*
+		 * We don't know scsi_device probed device name (this is
+		 * different from the scsi_device name). This is opaque to
+		 * scsi-generic, so we use the request_queue to infer the name
+		 * based on the set debugfs_dir.
+		 */
+		sdp->debugfs_sym = blk_queue_debugfs_symlink(q,
+							     sg_disk->disk_name,
+							     NULL);
+		break;
+	}
+	sdp->debugfs_set = true;
+}
+#else
+static void sg_init_blktrace_setup(Sg_device *sdp)
+{
+}
+#endif
+
 static long
 sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 		unsigned int cmd_in, void __user *p)
@@ -1117,6 +1188,7 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 		return put_user(max_sectors_bytes(sdp->device->request_queue),
 				ip);
 	case BLKTRACESETUP:
+		sg_init_blktrace_setup(sdp);
 		return blk_trace_setup(sdp->device->request_queue,
 				       sdp->disk->disk_name,
 				       MKDEV(SCSI_GENERIC_MAJOR, sdp->index),
@@ -1644,6 +1716,9 @@ sg_remove_device(struct device *cl_dev, struct class_interface *cl_intf)
 
 	sysfs_remove_link(&scsidp->sdev_gendev.kobj, "generic");
 	device_destroy(sg_sysfs_class, MKDEV(SCSI_GENERIC_MAJOR, sdp->index));
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove(sdp->debugfs_sym);
+#endif
 	cdev_del(sdp->cdev);
 	sdp->cdev = NULL;
 
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 4bf4ab3b70f4..fb3c0546803a 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4417,6 +4417,8 @@ static int st_probe(struct device *dev)
 	if (error)
 		goto out_remove_devs;
 	scsi_autopm_put_device(SDp);
+	blk_queue_debugfs_register(tpnt->device->request_queue,
+				   tape_name(tpnt));
 
 	sdev_printk(KERN_NOTICE, SDp,
 		    "Attached scsi tape %s\n", tape_name(tpnt));
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3122a93c7277..9b12fcc94572 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -561,8 +561,10 @@ struct request_queue {
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
 
-#ifdef CONFIG_BLK_DEBUG_FS
+#ifdef CONFIG_DEBUG_FS
 	struct dentry		*debugfs_dir;
+#endif
+#ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
 #endif
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 3b6ff5902edc..eb6db276e293 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -22,7 +22,6 @@ struct blk_trace {
 	u64 end_lba;
 	u32 pid;
 	u32 dev;
-	struct dentry *dir;
 	struct dentry *dropped_file;
 	struct dentry *msg_file;
 	struct list_head running_list;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f9c226f9546a..71b7896365b3 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -86,6 +86,9 @@ struct hd_struct {
 #endif
 	struct percpu_ref ref;
 	struct rcu_work rcu_work;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_sym;
+#endif
 };
 
 /**
@@ -391,4 +394,70 @@ static inline dev_t blk_lookup_devt(const char *name, int partno)
 }
 #endif /* CONFIG_BLOCK */
 
+#ifdef CONFIG_DEBUG_FS
+void blk_queue_debugfs_register(struct request_queue *q, const char *name);
+struct dentry *blk_queue_debugfs_symlink(struct request_queue *q,
+					 const char *src,
+					 const char *dst);
+#ifdef CONFIG_BLK_DEV_BSG
+void blk_debugfs_register_bsg(void);
+void blk_queue_debugfs_register_bsg(struct request_queue *q, const char *name);
+struct dentry *blk_queue_debugfs_bsg_symlink(struct request_queue *q,
+					     const char *src,
+					     const char *dst);
+#else
+
+static inline void blk_debugfs_register_bsg(void)
+{
+}
+
+/* If bsg is not enabled we use the base directory */
+static inline void blk_queue_debugfs_register_bsg(struct request_queue *q,
+						  const char *name)
+{
+	blk_queue_debugfs_register(q, name);
+}
+
+static inline
+struct dentry *blk_queue_debugfs_bsg_symlink(struct request_queue *q,
+					     const char *src,
+					     const char *dst)
+{
+	return blk_queue_debugfs_symlink(q, src, dst);
+}
+
+#endif /* CONFIG_BLK_DEV_BSG */
+#else  /* ! CONFIG_DEBUG_FS */
+static inline void blk_queue_debugfs_register(struct request_queue *q,
+					      const char *name)
+{
+}
+
+struct dentry *blk_queue_debugfs_symlink(struct request_queue *q,
+					 const char *src,
+					 const char *dst)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+#ifdef CONFIG_BLK_DEV_BSG
+static inline void blk_debugfs_register_bsg(void)
+{
+}
+#endif /* CONFIG_BLK_DEV_BSG */
+
+static inline void blk_queue_debugfs_register_bsg(struct request_queue *q,
+						  const char *name)
+{
+}
+
+static inline
+struct dentry *blk_queue_debugfs_bsg_symlink(struct request_queue *q,
+					     const char *src,
+					     const char *dst)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif /* CONFIG_DEBUG_FS */
+
 #endif /* _LINUX_GENHD_H */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ca39dc3230cb..6c10a1427de2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -311,7 +311,6 @@ static void blk_trace_free(struct blk_trace *bt)
 	debugfs_remove(bt->msg_file);
 	debugfs_remove(bt->dropped_file);
 	relay_close(bt->rchan);
-	debugfs_remove(bt->dir);
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
 	kfree(bt);
@@ -509,9 +508,24 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = -ENOENT;
 
-	dir = debugfs_lookup(buts->name, blk_debugfs_root);
-	if (!dir)
-		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
+	dir = q->debugfs_dir;
+
+	/*
+	 * Although the directory here is from debugfs, and we typically do not
+	 * care about NULL dirs as debugfs is typically only used for debugging,
+	 * we rely on the directory to exist to place files which we then use
+	 * for blktrace userspace functionality. Without this directory
+	 * blktrace would not work. Enabling blktrace functionality enables
+	 * debugfs too, as such, we *really* do want to check for this and must
+	 * ensure it was set before chugging on. If NULL were used below, we'd
+	 * also end up creating the debugfs files under the block root
+	 * directory, which we definitely do not want.
+	 */
+	if (IS_ERR_OR_NULL(dir)) {
+		pr_warn("debugfs_dir not present for %s so skipping\n",
+			buts->name);
+		goto err;
+	}
 
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
@@ -551,8 +565,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = 0;
 err:
-	if (dir && !bt->dir)
-		dput(dir);
 	if (ret)
 		blk_trace_free(bt);
 	return ret;
-- 
2.25.1

