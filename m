Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A47201CA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 22:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391318AbgFSUrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 16:47:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35881 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391162AbgFSUrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:47:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id j4so4386851plk.3;
        Fri, 19 Jun 2020 13:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5SB3lTS6myB9B6BB7rLonydPqzm5GLIIyuTS5YLBZU=;
        b=QJEGKcziSduTYrm5U4qCWhMVZAOckdMKn/B0LW9i8RZfoAiR/uAUwN1FT0aAjqRxEL
         //jwCfJl5vSO8WBXOkSV8PuOIMfDwnhpVW73Hm9bDhNcrpzyxSjH1fXrOqOczRfaIu+5
         U4bO86/4DZPbwG9tBx9qo59MoQAjsd8xUeAEBKPNgtwtND1OqJELISgKiErKj+7zMgKt
         e02+00xmSiTUfPhXsf2htmTZr2BLmdtQ2owQfdUPyW8wccuqjTwtBAooRbZjcdCPO1R6
         4ffVG3MZrPx/dGLQzq2VZUCkgh/bRgBMWi4d8s70kWpo2Vsny8e0XTkAxuy1iRPAfvIC
         CzHA==
X-Gm-Message-State: AOAM533AdMiZtffu1D0r48hgvWFjMVjago6tOdyuqkh1oadtVFsLybL1
        wrpvBd6/wWhnupVEFLQDl7Y=
X-Google-Smtp-Source: ABdhPJw7CPnlRQTMIjEA8iDVo7A2b7Za9fcMJ4niTv0x4xjQwIHZ50kN8lA8oRygHsnFvZn6cbXTFw==
X-Received: by 2002:a17:902:be06:: with SMTP id r6mr3736717pls.310.1592599664519;
        Fri, 19 Jun 2020 13:47:44 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id l14sm6030320pjh.50.2020.06.19.13.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 13:47:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8508E42337; Fri, 19 Jun 2020 20:47:32 +0000 (UTC)
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
Subject: [PATCH v7 6/8] blktrace: fix debugfs use after free
Date:   Fri, 19 Jun 2020 20:47:28 +0000
Message-Id: <20200619204730.26124-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200619204730.26124-1-mcgrof@kernel.org>
References: <20200619204730.26124-1-mcgrof@kernel.org>
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
drivers (multiqueue) block drivers. When you race a removal of these
devices with a blktrace setup you end up in a situation where the
make_request recursive debugfs removal will sweep away the blktrace
files and then later blktrace will also try to remove individual
dentries which are already NULL. The inverse is also possible and hence
the two types of use after frees.

We don't create the block debugfs directory on init for these types of
block devices:

  * request-based block driver block devices
  * every possible partition
  * scsi-generic

And so, this race should in theory only be possible with make_request
drivers.

We can fix the UAF by simply re-using the debugfs directory for
make_request drivers (multiqueue) and only creating the ephemeral
directory for the other type of block devices. The new clarifications
on relying on the q->blk_trace_mutex *and* also checking for q->blk_trace
*prior* to processing a blktrace ensures the debugfs directories are
only created if no possible directory name clashes are possible.

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
 kernel/trace/blktrace.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 7ff2ea5cd05e..e6e2d25fdbd6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -524,10 +524,18 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!bt->msg_data)
 		goto err;
 
-	ret = -ENOENT;
-
-	dir = debugfs_lookup(buts->name, blk_debugfs_root);
-	if (!dir)
+#ifdef CONFIG_BLK_DEBUG_FS
+	/*
+	 * When tracing whole make_request drivers (multiqueue) block devices,
+	 * reuse the existing debugfs directory created by the block layer on
+	 * init. For request-based block devices, all partitions block devices,
+	 * and scsi-generic block devices we create a temporary new debugfs
+	 * directory that will be removed once the trace ends.
+	 */
+	if (queue_is_mq(q) && bdev && bdev == bdev->bd_contains)
+		dir = q->debugfs_dir;
+	else
+#endif
 		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
 
 	bt->dev = dev;
@@ -565,8 +573,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = 0;
 err:
-	if (dir && !bt->dir)
-		dput(dir);
 	if (ret)
 		blk_trace_free(bt);
 	return ret;
-- 
2.26.2

