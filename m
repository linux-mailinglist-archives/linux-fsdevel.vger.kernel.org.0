Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50C270C3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 11:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgISJkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 05:40:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13769 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgISJkw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 05:40:52 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F11E0F1404638B60D1B3;
        Sat, 19 Sep 2020 17:40:50 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 19 Sep 2020
 17:40:43 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <lihaotian9@huawei.com>,
        <lutianxiong@huawei.com>, <jack@suse.cz>, <linfeilong@huawei.com>
Subject: [PATCH RESEND] fs: fix race condition oops between destroy_inode and writeback_sb_inodes
Date:   Sat, 19 Sep 2020 05:39:23 -0400
Message-ID: <20200919093923.19016-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We tested an oops problem in Linux 4.18. The Call Trace message is
 followed below.

[255946.665989] Oops: 0000 [#1] SMP PTI
[255946.674811] Workqueue: writeback wb_workfn (flush-253:6)
[255946.676443] RIP: 0010:locked_inode_to_wb_and_lock_list+0x20/0x120
[255946.683916] RSP: 0018:ffffbb0e44727c00 EFLAGS: 00010286
[255946.685518] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[255946.687699] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9ef282be5398
[255946.689866] RBP: ffff9ef282be5398 R08: ffffbb0e44727cd8 R09: ffff9ef3064f306e
[255946.692037] R10: 0000000000000000 R11: 0000000000000010 R12: ffff9ef282be5420
[255946.694208] R13: ffff9ef3351cc800 R14: 0000000000000000 R15: ffff9ef3352e2058
[255946.696378] FS:  0000000000000000(0000) GS:ffff9ef33ad80000(0000) knlGS:0000000000000000
[255946.698835] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[255946.700604] CR2: 0000000000000000 CR3: 000000000760a005 CR4: 00000000003606e0
[255946.702787] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[255946.704955] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[255946.707123] Call Trace:
[255946.707918]  writeback_sb_inodes+0x1fe/0x460
[255946.709244]  __writeback_inodes_wb+0x5d/0xb0
[255946.710575]  wb_writeback+0x265/0x2f0
[255946.711728]  ? wb_workfn+0x3cf/0x4d0
[255946.712850]  wb_workfn+0x3cf/0x4d0
[255946.713923]  process_one_work+0x195/0x390
[255946.715173]  worker_thread+0x30/0x390
[255946.716319]  ? process_one_work+0x390/0x390
[255946.717625]  kthread+0x10d/0x130
[255946.718789]  ? kthread_flush_work_fn+0x10/0x10
[255946.720170]  ret_from_fork+0x35/0x40

There is a race condition between destroy_inode and writeback_sb_inodes,
thread-1                                    thread-2
wb_workfn
  writeback_inodes_wb
    __writeback_inodes_wb
      writeback_sb_inodes
        wbc_attach_and_unlock_inode
					iget_locked
                                          destroy_inode
                                            inode_detach_wb
                                              inode->i_wb = NULL;

        inode_to_wb_and_lock_list
          locked_inode_to_wb_and_lock_list
            wb_get
              oops

so destroy inode after adding I_FREEING to inode state and the I_SYNC state
 being cleared.

Reported-by: Tianxiong Lu <lutianxiong@huawei.com>
Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
Signed-off-by: Haotian Li <lihaotian9@huawei.com>
---
 fs/inode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 72c4c347afb7..b28a2a9e15d5 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1148,10 +1148,17 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
 		struct inode *new = alloc_inode(sb);
 
 		if (new) {
+			spin_lock(&new->i_lock);
 			new->i_state = 0;
+			spin_unlock(&new->i_lock);
 			inode = inode_insert5(new, hashval, test, set, data);
-			if (unlikely(inode != new))
+			if (unlikely(inode != new)) {
+				spin_lock(&new->i_lock);
+				new->i_state |= I_FREEING;
+				spin_unlock(&new->i_lock);
+				inode_wait_for_writeback(new);
 				destroy_inode(new);
+			}
 		}
 	}
 	return inode;
@@ -1218,6 +1225,11 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		 * allocated.
 		 */
 		spin_unlock(&inode_hash_lock);
+
+		spin_lock(&inode->i_lock);
+		inode->i_state |= I_FREEING;
+		spin_unlock(&inode->i_lock);
+		inode_wait_for_writeback(inode);
 		destroy_inode(inode);
 		if (IS_ERR(old))
 			return NULL;
-- 
2.19.1

