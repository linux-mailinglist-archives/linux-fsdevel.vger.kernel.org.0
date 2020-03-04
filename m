Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF46B178B08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 07:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgCDG6G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 01:58:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728216AbgCDG6G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 01:58:06 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0BD34999C45BB105C7BD;
        Wed,  4 Mar 2020 14:58:00 +0800 (CST)
Received: from fedora-aep.huawei.cmm (10.175.113.49) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Mar 2020 14:57:52 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <neilb@suse.com>, <jlayton@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>
Subject: [PATCH] locks: fix a potential use-after-free problem when wakeup a waiter
Date:   Wed, 4 Mar 2020 15:25:56 +0800
Message-ID: <20200304072556.2762-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.49]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

'16306a61d3b7 ("fs/locks: always delete_block after waiting.")' add the
logic to check waiter->fl_blocker without blocked_lock_lock. And it will
trigger a UAF when we try to wakeup some waiter：

Thread 1 has create a write flock a on file, and now thread 2 try to
unlock and delete flock a, thread 3 try to add flock b on the same file.

Thread2                         Thread3
                                flock syscall(create flock b)
	                        ...flock_lock_inode_wait
				    flock_lock_inode(will insert
				    our fl_blocked_member list
				    to flock a's fl_blocked_requests)
				   sleep
flock syscall(unlock)
...flock_lock_inode_wait
    locks_delete_lock_ctx
    ...__locks_wake_up_blocks
        __locks_delete_blocks(
	b->fl_blocker = NULL)
	...
                                   break by a signal
				   locks_delete_block
				    b->fl_blocker == NULL &&
				    list_empty(&b->fl_blocked_requests)
	                            success, return directly
				 locks_free_lock b
	wake_up(&b->fl_waiter)
	trigger UAF

Fix it by remove this logic, and this patch may also fix CVE-2019-19769.

Fixes: 16306a61d3b7 ("fs/locks: always delete_block after waiting.")
Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/locks.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 44b6da032842..426b55d333d5 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -753,20 +753,6 @@ int locks_delete_block(struct file_lock *waiter)
 {
 	int status = -ENOENT;
 
-	/*
-	 * If fl_blocker is NULL, it won't be set again as this thread
-	 * "owns" the lock and is the only one that might try to claim
-	 * the lock.  So it is safe to test fl_blocker locklessly.
-	 * Also if fl_blocker is NULL, this waiter is not listed on
-	 * fl_blocked_requests for some lock, so no other request can
-	 * be added to the list of fl_blocked_requests for this
-	 * request.  So if fl_blocker is NULL, it is safe to
-	 * locklessly check if fl_blocked_requests is empty.  If both
-	 * of these checks succeed, there is no need to take the lock.
-	 */
-	if (waiter->fl_blocker == NULL &&
-	    list_empty(&waiter->fl_blocked_requests))
-		return status;
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_blocker)
 		status = 0;
-- 
2.17.2

