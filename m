Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABE31F1E05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 19:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbgFHRCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 13:02:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44299 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbgFHRBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:01:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id 64so1943873pfv.11;
        Mon, 08 Jun 2020 10:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXDjJ7y4kAjAoIq3NLlxxshI3+WsFhQehQeoJndvSbs=;
        b=JzVnlonyT0FArGJQCFXXWEae1WUGpHZ7IPlixp+1Nq6MHe+Ne7jUPmZUN8EvrB5lmy
         kC9Ub1g+J6iiqgop/YLKtjFcX55BnZDJdXWsb1Cjqy+QNvVt7yyKwAUw/iOYpZHS3D22
         Pz90zZdAgEid95bOguZjuycMMPIu3jcn79jqKfSinFJvtAhL2FoJLOHEfD21AIxNIQZe
         ZpDU13HA4TowkF5KWxjDHln7AAbYUS/uY0Kevf+MHSyPSMnciqeVyViEhTPiyeGR57Gk
         1yEQ79jtm2oTJTZpd4FXKyzfKC4Nwt+gQPbevkOlzmnUDYwghZwtNwMeCXCN/DVUrZOz
         rDdQ==
X-Gm-Message-State: AOAM530J+jxTMDjxesV4PpXNrTBtEB20/Iz1mvKE0L4wARaZBNawoIfg
        Vy0L2dGqPkJnIRgkxEcCOvg=
X-Google-Smtp-Source: ABdhPJyeyDj9bMXdFW6Wd7IBC8nhDpsWhwG/SrlFg5KFMRn5bFXdjmvtvwKdt0w3nZVOHHQtnLodvQ==
X-Received: by 2002:a65:52cd:: with SMTP id z13mr20816774pgp.259.1591635695752;
        Mon, 08 Jun 2020 10:01:35 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j16sm7443498pfa.179.2020.06.08.10.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 10:01:32 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C260C422E5; Mon,  8 Jun 2020 17:01:28 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: [PATCH v6 6/6] blktrace: fix debugfs use after free
Date:   Mon,  8 Jun 2020 17:01:26 +0000
Message-Id: <20200608170127.20419-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200608170127.20419-1-mcgrof@kernel.org>
References: <20200608170127.20419-1-mcgrof@kernel.org>
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
script run_0004.sh from break-blktrace [0].

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

We special-case a solution for scsi-generic as well which got blktrace
support added by Christof via commit 6da127ad0918 ("blktrace: Add
blktrace ioctls to SCSI generic devices") so upstream since v2.6.25.
scsi-generic drives use a character device, however behind the scenes
we have a scsi device with a request_queue. How this is used varies
by class of driver (TYPE_DISK, TYPE_TAPE, etc).  We simply create its
a scsi-generic dedicated debugfs_dir and have blktrace use that when
this interface is used.

This goes tested with:

  o nvme partitions
  o ISCSI with tgt, and blktracing against scsi-generic with:
    o block
    o tape
    o cdrom
    o media changer
  o blktests

This patch is part of the work which disputes the severity of
CVE-2019-19770 which shows this issue is not a core debugfs issue, but
a misuse of debugfs within blktace.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: yu kuai <yukuai3@huawei.com>
Reported-by: syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Fixes: 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-core.c             |  4 ---
 block/blk-mq-debugfs.c       |  5 ----
 block/blk-sysfs.c            | 40 +++++++++++++++++++++++++++
 block/blk.h                  |  2 --
 block/partitions/core.c      |  3 ++
 drivers/scsi/sg.c            |  3 ++
 include/linux/blkdev.h       |  4 ++-
 include/linux/blktrace_api.h |  1 -
 include/linux/genhd.h        |  1 +
 kernel/trace/blktrace.c      | 53 ++++++++++++++++++++++++++++--------
 10 files changed, 91 insertions(+), 25 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a5126c0be777..fd850bebdf18 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -51,9 +51,7 @@
 #include "blk-pm.h"
 #include "blk-rq-qos.h"
 
-#ifdef CONFIG_DEBUG_FS
 struct dentry *blk_debugfs_root;
-#endif
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_remap);
@@ -1937,9 +1935,7 @@ int __init blk_dev_init(void)
 	blk_requestq_cachep = kmem_cache_create("request_queue",
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
 
-#ifdef CONFIG_DEBUG_FS
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
-#endif
 
 	return 0;
 }
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 15df3a36e9fa..a2800bc56fb4 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -824,9 +824,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
-					    blk_debugfs_root);
-
 	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	/*
@@ -857,9 +854,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 void blk_mq_debugfs_unregister(struct request_queue *q)
 {
-	debugfs_remove_recursive(q->debugfs_dir);
 	q->sched_debugfs_dir = NULL;
-	q->debugfs_dir = NULL;
 }
 
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 561624d4cc4e..70168435f079 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/blktrace_api.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-cgroup.h>
+#include <linux/debugfs.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -918,6 +919,9 @@ static void blk_release_queue(struct kobject *kobj)
 
 	blk_trace_shutdown(q);
 
+	debugfs_remove_recursive(q->debugfs_dir);
+	if (IS_ENABLED(CONFIG_CHR_DEV_SG))
+		debugfs_remove_recursive(q->sg_debugfs_dir);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
 
@@ -937,6 +941,20 @@ struct kobj_type blk_queue_ktype = {
 	.release	= blk_release_queue,
 };
 
+/**
+ * blk_sg_debugfs_init - initialize debugfs for scsi-generic
+ * @q: the associated queue
+ * @name: name of the scsi-generic device
+ *
+ * To be used by scsi-generic for allowing it to use blktrace.
+ */
+void blk_sg_debugfs_init(struct request_queue *q, const char *name)
+{
+	if (IS_ENABLED(CONFIG_CHR_DEV_SG))
+		q->sg_debugfs_dir = debugfs_create_dir(name, blk_debugfs_root);
+}
+EXPORT_SYMBOL_GPL(blk_sg_debugfs_init);
+
 /**
  * blk_register_queue - register a block layer queue with sysfs
  * @disk: Disk of which the request queue should be registered with sysfs.
@@ -989,6 +1007,28 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
+	/*
+	 * Blktrace needs a debugfs name even for queues that don't register
+	 * a gendisk, so it lazily registers the debugfs directory.  But that
+	 * can get us into a situation where a SCSI device is found, with no
+	 * driver for it (yet).  Then blktrace is used on the device, creating
+	 * the debugfs directory, and only after that a driver is loaded. In
+	 * that case we might already have a debugfs directory registered here.
+	 * Even worse we could be racing with blktrace to register it.
+	 */
+#ifdef CONFIG_BLK_DEV_IO_TRACE
+	mutex_lock(&q->blk_trace_mutex);
+	if (!q->debugfs_dir) {
+		q->debugfs_dir =
+			debugfs_create_dir(kobject_name(q->kobj.parent),
+				blk_debugfs_root);
+	}
+	mutex_unlock(&q->blk_trace_mutex);
+#else
+	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
+					    blk_debugfs_root);
+#endif
+
 	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
diff --git a/block/blk.h b/block/blk.h
index b5d1f0fc6547..499308c6ab3b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -14,9 +14,7 @@
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
 
-#ifdef CONFIG_DEBUG_FS
 extern struct dentry *blk_debugfs_root;
-#endif
 
 struct blk_flush_queue {
 	unsigned int		flush_pending_idx:1;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 78951e33b2d7..8387128364f1 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -10,6 +10,7 @@
 #include <linux/vmalloc.h>
 #include <linux/blktrace_api.h>
 #include <linux/raid/detect.h>
+#include <linux/debugfs.h>
 #include "check.h"
 
 static int (*check_part[])(struct parsed_partitions *) = {
@@ -322,6 +323,7 @@ void delete_partition(struct gendisk *disk, struct hd_struct *part)
 	get_device(disk_to_dev(part_to_disk(part)));
 	rcu_assign_pointer(ptbl->part[part->partno], NULL);
 	kobject_put(part->holder_dir);
+	debugfs_remove_recursive(part->debugfs_dir);
 	device_del(part_to_dev(part));
 
 	/*
@@ -444,6 +446,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	if (!p->holder_dir)
 		goto out_del;
 
+	p->debugfs_dir = debugfs_create_dir(dev_name(pdev), blk_debugfs_root);
 	dev_set_uevent_suppress(pdev, 0);
 	if (flags & ADDPART_FLAG_WHOLEDISK) {
 		err = device_create_file(pdev, &dev_attr_whole_disk);
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 20472aaaf630..5f6ccf4ba4d9 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1117,6 +1117,9 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 		return put_user(max_sectors_bytes(sdp->device->request_queue),
 				ip);
 	case BLKTRACESETUP:
+		if (!sdp->device->request_queue->sg_debugfs_dir)
+			blk_sg_debugfs_init(sdp->device->request_queue,
+					    sdp->disk->disk_name);
 		return blk_trace_setup(sdp->device->request_queue,
 				       sdp->disk->disk_name,
 				       MKDEV(SCSI_GENERIC_MAJOR, sdp->index),
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2462b78c1013..afc43c8923c5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -574,8 +574,9 @@ struct request_queue {
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
 
-#ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*debugfs_dir;
+	struct dentry		*sg_debugfs_dir;
+#ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
 #endif
@@ -858,6 +859,7 @@ static inline void rq_flush_dcache_pages(struct request *rq)
 
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
+extern void blk_sg_debugfs_init(struct request_queue *q, const char *name);
 extern blk_qc_t generic_make_request(struct bio *bio);
 extern blk_qc_t direct_make_request(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
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
index 392aad5e29a2..902e50808bd9 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -76,6 +76,7 @@ struct hd_struct {
 	int make_it_fail;
 #endif
 	struct rcu_work rcu_work;
+	struct dentry *debugfs_dir;
 };
 
 /**
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 7ff2ea5cd05e..4690d70e16a4 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -314,7 +314,6 @@ static void blk_trace_free(struct blk_trace *bt)
 	debugfs_remove(bt->msg_file);
 	debugfs_remove(bt->dropped_file);
 	relay_close(bt->rchan);
-	debugfs_remove(bt->dir);
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
 	kfree(bt);
@@ -488,9 +487,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!buts->buf_size || !buts->buf_nr)
 		return -EINVAL;
 
-	if (!blk_debugfs_root)
-		return -ENOENT;
-
 	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
 	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
 
@@ -511,6 +507,47 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		return -EBUSY;
 	}
 
+	/*
+	 * We have to use a partition directory if a partition is being worked
+	 * on. The same request_queue is shared between all partitions.
+	 */
+	if (bdev && bdev != bdev->bd_contains) {
+		dir = bdev->bd_part->debugfs_dir;
+	} else if (IS_ENABLED(CONFIG_CHR_DEV_SG) &&
+		   MAJOR(dev) == SCSI_GENERIC_MAJOR) {
+		/*
+		 * scsi-generic exposes the request_queue through the /dev/sg*
+		 * interface but since that uses a different path than whatever
+		 * the respective scsi driver device name may expose and use
+		 * for the request_queue debugfs_dir. We have a dedicated
+		 * dentry for scsi-generic then.
+		 */
+		dir = q->sg_debugfs_dir;
+	} else {
+		/*
+		 * Drivers which do not use the *add_disk*() interfaces will
+		 * not have their debugfs_dir created for them automatically,
+		 * so we must create it for them.
+		 */
+		if (!q->debugfs_dir) {
+			q->debugfs_dir =
+				debugfs_create_dir(buts->name,
+						   blk_debugfs_root);
+		}
+		dir = q->debugfs_dir;
+	}
+
+	/*
+	 * As blktrace relies on debugfs for its interface the debugfs directory
+	 * is required, contrary to the usual mantra of not checking for debugfs
+	 * files or directories.
+	 */
+	if (IS_ERR_OR_NULL(dir)) {
+		pr_warn("debugfs_dir not present for %s so skipping\n",
+			buts->name);
+		return -ENOENT;
+	}
+
 	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
 	if (!bt)
 		return -ENOMEM;
@@ -524,12 +561,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!bt->msg_data)
 		goto err;
 
-	ret = -ENOENT;
-
-	dir = debugfs_lookup(buts->name, blk_debugfs_root);
-	if (!dir)
-		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
-
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);
@@ -565,8 +596,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = 0;
 err:
-	if (dir && !bt->dir)
-		dput(dir);
 	if (ret)
 		blk_trace_free(bt);
 	return ret;
-- 
2.26.2

