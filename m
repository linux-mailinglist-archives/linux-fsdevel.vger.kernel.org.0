Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DA82E2DE1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Dec 2020 11:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgLZJ5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Dec 2020 04:57:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9935 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgLZJ5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Dec 2020 04:57:53 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D2zjY2l4DzhvFt;
        Sat, 26 Dec 2020 17:56:33 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Sat, 26 Dec 2020
 17:57:03 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <yangerkun@huawei.com>,
        <yi.zhang@huawei.com>, <linfeilong@huawei.com>, <jack@suse.cz>
Subject: [RFC PATCH RESEND] fs: fix a hungtask problem when freeze/unfreeze fs
Date:   Sat, 26 Dec 2020 04:56:41 -0500
Message-ID: <20201226095641.17290-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We found a hungtask problem as described following:
Running xfstests generic/390 with ext4 filesystem, and simutaneously 
offline/onlines the disk we tested. It will cause a hungtask problem 
whose call trace is like this,

[369.857104] INFO: task fsstress:11672 blocked for more than 120 seconds.
[  369.875724] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  369.885168] fsstress        D    0 11672  11625 0x00000080
[  369.885169] Call Trace:
[  369.885171]  ? __schedule+0x2fc/0x930
[  369.885173]  ? filename_parentat+0x10b/0x1a0
[  369.885175]  schedule+0x28/0x70
[  369.885176]  rwsem_down_read_failed+0x102/0x1c0
[  369.885178]  ? __percpu_down_read+0x93/0xb0
[  369.885179]  __percpu_down_read+0x93/0xb0
[  369.885182]  __sb_start_write+0x5f/0x70
[  369.885183]  mnt_want_write+0x20/0x50
[  369.885184]  do_renameat2+0x1f3/0x550
[  369.885186]  __x64_sys_rename+0x1c/0x20
[  369.885187]  do_syscall_64+0x5b/0x1b0
[  369.885188]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[  369.885189] RIP: 0033:0x7f5e6e34ccb7
[  369.885190] Code: Bad RIP value.
[  369.885191] RSP: 002b:00007ffef4a83788 EFLAGS: 00000206 ORIG_RAX: 0000000000000052
[  369.885191] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5e6e34ccb7
[  369.885192] RDX: 0000000000000000 RSI: 0000000001b09500 RDI: 0000000001b09f90
[  369.885192] RBP: 0000000000000000 R08: 0000000000000021 R09: 0000000000000000
[  369.885193] R10: 0000000000000692 R11: 0000000000000206 R12: 00007ffef4a83a30
[  369.885193] R13: 00007ffef4a83a40 R14: 00007ffef4a83a40 R15: 0000000000000001

The root cause is that when offline/onlines disks, the filesystem can easily get into 
a error state and this makes it change to be read-only. Function freeze_super() will hold 
all sb_writers rwsems including rwsem of SB_FREEZE_WRITE when filesystem not read-only, 
but thaw_super_locked() cannot release these while the filesystem suddenly become read-only, 
because the logic will go to out.

freeze_super
    hold sb_writers rwsems
        sb->s_writers.frozen = SB_FREEZE_COMPLETE
                                                 thaw_super_locked
                                                     sb_rdonly
                                                        sb->s_writers.frozen = SB_UNFROZEN;
                                                            goto out // not release rwsems

And at this time, if we call mnt_want_write(), the process will be blocked.

This patch fixes this problem, when filesystem is read-only, just not to set sb_writers.frozen 
be SB_FREEZE_COMPLETE in freeze_super() and then release all rwsems in thaw_super_locked.

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
Signed-off-by: yangerkun <yangerkun@huawei.com>

Fix some descriptions errors and resend the patch.
---
 fs/super.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 2c6cdea2ab2d..50d79213f678 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1672,9 +1672,7 @@ int freeze_super(struct super_block *sb)
 	}
 
 	if (sb_rdonly(sb)) {
-		/* Nothing to do really... */
-		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
-		up_write(&sb->s_umount);
+		deactivate_locked_super(sb);
 		return 0;
 	}
 
@@ -1733,13 +1731,11 @@ static int thaw_super_locked(struct super_block *sb)
 		return -EINVAL;
 	}
 
-	if (sb_rdonly(sb)) {
-		sb->s_writers.frozen = SB_UNFROZEN;
-		goto out;
-	}
-
 	lockdep_sb_freeze_acquire(sb);
 
+	if (sb_rdonly(sb))
+		goto out;
+
 	if (sb->s_op->unfreeze_fs) {
 		error = sb->s_op->unfreeze_fs(sb);
 		if (error) {
@@ -1751,9 +1747,9 @@ static int thaw_super_locked(struct super_block *sb)
 		}
 	}
 
+out:
 	sb->s_writers.frozen = SB_UNFROZEN;
 	sb_freeze_unlock(sb);
-out:
 	wake_up(&sb->s_writers.wait_unfrozen);
 	deactivate_locked_super(sb);
 	return 0;
-- 
2.19.1

