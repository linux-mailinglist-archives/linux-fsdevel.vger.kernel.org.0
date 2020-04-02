Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C09D619B939
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 02:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbgDBAAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 20:00:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44681 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733287AbgDBAAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 20:00:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so621545plr.11;
        Wed, 01 Apr 2020 17:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnLJUtXOSia7PQE5OyDEi1WF/+/PGHAetD+0mMY8uXs=;
        b=LmktueFt+ykwGooK4RXZpbEEXpKBy0T2C5udtWS5Grj6anmIXZVY2JZinRH9SyuS1w
         Y6agJmJ85vubcUJm7TF3X1i760C/ZgaFtcBimuYsgnGiRLzIgiLBPmbffKML0mYp/Dnv
         xzaCWxUywluZBvyLqMxq8tabmO1tSCyKu+lZwmseM6ddRQ/ef6rHNKl6X+VysSsF0VFU
         qArFLmOhpJ/UZjOy0y7gWDVIs/Y3IvquIOWYllaIzURnu487xlGFXSvogrvQn8oBnhFa
         o6/mfx/6kC2CjWch2Z+jnnFypDgGoZtw/RoIlj+fQyUrVP36KBpq+5jLVaHZzfrv/Bmt
         CXbg==
X-Gm-Message-State: AGi0PuY74lyZlVVQ+ZBFfrxM7LVMvYKz2pDYFMvsmmWdAvkEqGLKwRNL
        5XgfgpHsambwB5q64FY40X0=
X-Google-Smtp-Source: APiQypIZbqiOw+Z25iDmBXUboufCfW1IaEAppS0y8nlBkDk1CH1yqy/pe9p4O36P93+CKhcfM9hY4A==
X-Received: by 2002:a17:90a:77cc:: with SMTP id e12mr660680pjs.134.1585785615909;
        Wed, 01 Apr 2020 17:00:15 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id ci18sm2504005pjb.23.2020.04.01.17.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 17:00:11 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A2C49418C0; Thu,  2 Apr 2020 00:00:10 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de
Cc:     mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: [RFC 2/3] blktrace: fix debugfs use after free
Date:   Thu,  2 Apr 2020 00:00:01 +0000
Message-Id: <20200402000002.7442-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200402000002.7442-1-mcgrof@kernel.org>
References: <20200402000002.7442-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On commit 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
Omar fixed the original blktrace code for multiqueue use. This however
left in place a possible crash, if you happen to abuse blktrace in a way
it was not intended.

Namely, if you loop adding a device, setup the blktrace with BLKTRACESETUP,
forget to BLKTRACETEARDOWN, and then just remove the device you end up
with a panic:

[  107.193134] debugfs: Directory 'loop0' with parent 'block' already present!
[  107.254615] BUG: kernel NULL pointer dereference, address: 00000000000000a0
[  107.258785] #PF: supervisor write access in kernel mode
[  107.262035] #PF: error_code(0x0002) - not-present page
[  107.264106] PGD 0 P4D 0
[  107.264404] Oops: 0002 [#1] SMP NOPTI
[  107.264803] CPU: 8 PID: 674 Comm: kworker/8:2 Tainted: G            E 5.6.0-rc7-next-20200327 #1
[  107.265712] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
[  107.266553] Workqueue: events __blk_release_queue
[  107.267051] RIP: 0010:down_write+0x15/0x40
[  107.267488] Code: eb ca e8 ee a5 8d ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 55 48 89 fd e8 52 db ff ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 55 00 75 0f  65 48 8b 04 25 c0 8b 01 00 48 89 45 08 5d
[  107.269300] RSP: 0018:ffff9927c06efda8 EFLAGS: 00010246
[  107.269841] RAX: 0000000000000000 RBX: ffff8be7e73b0600 RCX: ffffff8100000000
[  107.270559] RDX: 0000000000000001 RSI: ffffff8100000000 RDI: 00000000000000a0
[  107.271281] RBP: 00000000000000a0 R08: ffff8be7ebc80fa8 R09: ffff8be7ebc80fa8
[  107.272001] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  107.272722] R13: ffff8be7efc30400 R14: ffff8be7e0571200 R15: 00000000000000a0
[  107.273475] FS:  0000000000000000(0000) GS:ffff8be7efc00000(0000) knlGS:0000000000000000
[  107.274346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  107.274968] CR2: 00000000000000a0 CR3: 000000042abee003 CR4: 0000000000360ee0
[  107.275710] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  107.276465] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  107.277214] Call Trace:
[  107.277532]  simple_recursive_removal+0x4e/0x2e0
[  107.278049]  ? debugfs_remove+0x60/0x60
[  107.278493]  debugfs_remove+0x40/0x60
[  107.278922]  blk_trace_free+0xd/0x50
[  107.279339]  __blk_trace_remove+0x27/0x40
[  107.279797]  blk_trace_shutdown+0x30/0x40
[  107.280256]  __blk_release_queue+0xab/0x110
[  107.280734]  process_one_work+0x1b4/0x380
[  107.281194]  worker_thread+0x50/0x3c0
[  107.281622]  kthread+0xf9/0x130
[  107.281994]  ? process_one_work+0x380/0x380
[  107.282467]  ? kthread_park+0x90/0x90
[  107.282895]  ret_from_fork+0x1f/0x40
[  107.283316] Modules linked in: loop(E) <etc>
[  107.288562] CR2: 00000000000000a0
[  107.288957] ---[ end trace b885d243d441bbce ]---

This splat happens to be very similar to the one reported via
kernel.org korg#205713, only that korg#205713 was for v4.19.83
and the above now includes the simple_recursive_removal() introduced
via commit a3d1e7eb5abe ("simple_recursive_removal(): kernel-side rm
-rf for ramfs-style filesystems") merged on v5.6.

korg#205713 then was used to create CVE-2019-19770 and claims that
the bug is in a use-after-free in the debugfs core code. The
implications of this being a generic UAF on debugfs would be
much more severe, as it would imply parent dentries can sometimes
not be possitive, which is something claim is not possible.

It turns out that the issue actually is a mis-use of debugfs for
the multiqueue case, and the fragile nature of how we free the
directory used to keep track of blktrace debugfs files. Omar's
commit assumed the parent directory would be kept with
debugfs_lookup() but this is not the case, only the dentry is
kept around. We also special-case a solution for multiqueue
given that for multiqueue code we always instantiate the debugfs
directory for the request queue. We were leaving it only to chance,
if someone happens to use blktrace, on single queue block devices
for the respective debugfs directory be created.

We can fix the UAF by simply using a debugfs directory which is
always created for singlequeue and multiqueue block devices. This
simplifies the code considerably, with the only penalty now being
that we're always creating the request queue directory debugfs
directory for the block device on singlequeue block devices.

The UAF then is not a core debugfs issue, but instead a mis-use of
debugfs, and this issue can only be triggered if you are root, and
mis-use blktrace.

This issue can be reproduced with break-blktrace [2] using:

  break-blktrace -c 10 -d

This patch fixes this issue. Note that there is also another
respective UAF but from the ioctl path [3], this should also fix
that issue.

This patch then also contends the severity of CVE-2019-19770 as
this issue is only possible using root to shoot yourself in the
foot by also misuing blktrace.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=205713
[1] https://nvd.nist.gov/vuln/detail/CVE-2019-19770
[2] https://github.com/mcgrof/break-blktrace
[3] https://lore.kernel.org/lkml/000000000000ec635b059f752700@google.com/

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Reported-by: syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-debugfs.c          | 12 ++++++++++++
 block/blk-mq-debugfs.c       |  5 -----
 block/blk-sysfs.c            |  3 +++
 block/blk.h                  | 10 ++++++++++
 include/linux/blktrace_api.h |  1 -
 kernel/trace/blktrace.c      | 19 ++++++++-----------
 6 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
index 634dea4b1507..a8b343e758e4 100644
--- a/block/blk-debugfs.c
+++ b/block/blk-debugfs.c
@@ -13,3 +13,15 @@ void blk_debugfs_register(void)
 {
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
 }
+
+void blk_q_debugfs_register(struct request_queue *q)
+{
+	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
+					    blk_debugfs_root);
+}
+
+void blk_q_debugfs_unregister(struct request_queue *q)
+{
+	debugfs_remove_recursive(q->debugfs_dir);
+	q->debugfs_dir = NULL;
+}
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992..bda9378eab90 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -823,9 +823,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
-					    blk_debugfs_root);
-
 	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	/*
@@ -856,9 +853,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 void blk_mq_debugfs_unregister(struct request_queue *q)
 {
-	debugfs_remove_recursive(q->debugfs_dir);
 	q->sched_debugfs_dir = NULL;
-	q->debugfs_dir = NULL;
 }
 
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..20f20b0fa0b9 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -895,6 +895,7 @@ static void __blk_release_queue(struct work_struct *work)
 
 	blk_trace_shutdown(q);
 
+	blk_q_debugfs_unregister(q);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
 
@@ -975,6 +976,8 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
+	blk_q_debugfs_register(q);
+
 	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
diff --git a/block/blk.h b/block/blk.h
index 86a66b614f08..b86123a2d74f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -489,10 +489,20 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		bool *same_page);
 #ifdef CONFIG_DEBUG_FS
 void blk_debugfs_register(void);
+void blk_q_debugfs_register(struct request_queue *q);
+void blk_q_debugfs_unregister(struct request_queue *q);
 #else
 static inline void blk_debugfs_register(void)
 {
 }
+
+static inline void blk_q_debugfs_register(struct request_queue *q)
+{
+}
+
+static inline void blk_q_debugfs_unregister(struct request_queue *q)
+{
+}
 #endif /* CONFIG_DEBUG_FS */
 
 #endif /* BLK_INTERNAL_H */
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
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ca39dc3230cb..15086227592f 100644
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
@@ -476,7 +475,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 			      struct blk_user_trace_setup *buts)
 {
 	struct blk_trace *bt = NULL;
-	struct dentry *dir = NULL;
 	int ret;
 
 	if (!buts->buf_size || !buts->buf_nr)
@@ -485,6 +483,9 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!blk_debugfs_root)
 		return -ENOENT;
 
+	if (!q->debugfs_dir)
+		return -ENOENT;
+
 	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
 	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
 
@@ -509,21 +510,19 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = -ENOENT;
 
-	dir = debugfs_lookup(buts->name, blk_debugfs_root);
-	if (!dir)
-		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
-
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);
 
 	ret = -EIO;
-	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
+	bt->dropped_file = debugfs_create_file("dropped", 0444,
+					       q->debugfs_dir, bt,
 					       &blk_dropped_fops);
 
-	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
+	bt->msg_file = debugfs_create_file("msg", 0222, q->debugfs_dir,
+					   bt, &blk_msg_fops);
 
-	bt->rchan = relay_open("trace", dir, buts->buf_size,
+	bt->rchan = relay_open("trace", q->debugfs_dir, buts->buf_size,
 				buts->buf_nr, &blk_relay_callbacks, bt);
 	if (!bt->rchan)
 		goto err;
@@ -551,8 +550,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = 0;
 err:
-	if (dir && !bt->dir)
-		dput(dir);
 	if (ret)
 		blk_trace_free(bt);
 	return ret;
-- 
2.25.1

