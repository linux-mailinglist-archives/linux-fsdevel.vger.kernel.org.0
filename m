Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95874521850
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243461AbiEJNeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 09:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbiEJNc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 09:32:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1972375C7;
        Tue, 10 May 2022 06:24:17 -0700 (PDT)
Received: from kwepemi500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KyJbB2pSbzGpbC;
        Tue, 10 May 2022 21:21:26 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi500021.china.huawei.com (7.221.188.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 21:24:14 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 21:24:13 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <axboe@kernel.dk>, <hch@lst.de>, <torvalds@linux-foundation.org>,
        <mingo@redhat.com>, <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
Subject: [PATCH v3 1/1] =?UTF-8?q?fs-writeback:=20writeback=5Fsb=5Finodes?= =?UTF-8?q?=EF=BC=9ARecalculate=20'wrote'=20according=20skipped=20pages?=
Date:   Tue, 10 May 2022 21:38:05 +0800
Message-ID: <20220510133805.1988292-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 505a666ee3fc ("writeback: plug writeback in wb_writeback() and
writeback_inodes_wb()") has us holding a plug during wb_writeback, which
may cause a potential ABBA dead lock:

    wb_writeback		fat_file_fsync
blk_start_plug(&plug)
for (;;) {
  iter i-1: some reqs have been added into plug->mq_list  // LOCK A
  iter i:
    progress = __writeback_inodes_wb(wb, work)
    . writeback_sb_inodes // fat's bdev
    .   __writeback_single_inode
    .   . generic_writepages
    .   .   __block_write_full_page
    .   .   . . 	    __generic_file_fsync
    .   .   . . 	      sync_inode_metadata
    .   .   . . 	        writeback_single_inode
    .   .   . . 		  __writeback_single_inode
    .   .   . . 		    fat_write_inode
    .   .   . . 		      __fat_write_inode
    .   .   . . 		        sync_dirty_buffer	// fat's bdev
    .   .   . . 			  lock_buffer(bh)	// LOCK B
    .   .   . . 			    submit_bh
    .   .   . . 			      blk_mq_get_tag	// LOCK A
    .   .   . trylock_buffer(bh)  // LOCK B
    .   .   .   redirty_page_for_writepage
    .   .   .     wbc->pages_skipped++
    .   .   --wbc->nr_to_write
    .   wrote += write_chunk - wbc.nr_to_write  // wrote > 0
    .   requeue_inode
    .     redirty_tail_locked
    if (progress)    // progress > 0
      continue;
  iter i+1:
      queue_io
      // similar process with iter i, infinite for-loop !
}
blk_finish_plug(&plug)   // flush plug won't be called

Above process triggers a hungtask like:
[  399.044861] INFO: task bb:2607 blocked for more than 30 seconds.
[  399.046824]       Not tainted 5.18.0-rc1-00005-gefae4d9eb6a2-dirty
[  399.051539] task:bb              state:D stack:    0 pid: 2607 ppid:
2426 flags:0x00004000
[  399.051556] Call Trace:
[  399.051570]  __schedule+0x480/0x1050
[  399.051592]  schedule+0x92/0x1a0
[  399.051602]  io_schedule+0x22/0x50
[  399.051613]  blk_mq_get_tag+0x1d3/0x3c0
[  399.051640]  __blk_mq_alloc_requests+0x21d/0x3f0
[  399.051657]  blk_mq_submit_bio+0x68d/0xca0
[  399.051674]  __submit_bio+0x1b5/0x2d0
[  399.051708]  submit_bio_noacct+0x34e/0x720
[  399.051718]  submit_bio+0x3b/0x150
[  399.051725]  submit_bh_wbc+0x161/0x230
[  399.051734]  __sync_dirty_buffer+0xd1/0x420
[  399.051744]  sync_dirty_buffer+0x17/0x20
[  399.051750]  __fat_write_inode+0x289/0x310
[  399.051766]  fat_write_inode+0x2a/0xa0
[  399.051783]  __writeback_single_inode+0x53c/0x6f0
[  399.051795]  writeback_single_inode+0x145/0x200
[  399.051803]  sync_inode_metadata+0x45/0x70
[  399.051856]  __generic_file_fsync+0xa3/0x150
[  399.051880]  fat_file_fsync+0x1d/0x80
[  399.051895]  vfs_fsync_range+0x40/0xb0
[  399.051929]  __x64_sys_fsync+0x18/0x30

In my test, 'need_resched()' (which is imported by 590dca3a71 "fs-writeback:
unplug before cond_resched in writeback_sb_inodes") in function
'writeback_sb_inodes()' seldom comes true, unless cond_resched() is deleted
from write_cache_pages().

Fix it by correcting wrote number according number of skipped pages
in writeback_sb_inodes().

Goto Link to find a reproducer.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215837
Cc: stable@vger.kernel.org # v4.3
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
v2->v3:
  Don't update 'work->nr_pages' (This variable means how many pages
  to be processed).
 fs/fs-writeback.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 591fe9cf1659..b20b70de9143 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1775,11 +1775,12 @@ static long writeback_sb_inodes(struct super_block *sb,
 	};
 	unsigned long start_time = jiffies;
 	long write_chunk;
-	long wrote = 0;  /* count both pages and inodes */
+	long total_wrote = 0;  /* count both pages and inodes */
 
 	while (!list_empty(&wb->b_io)) {
 		struct inode *inode = wb_inode(wb->b_io.prev);
 		struct bdi_writeback *tmp_wb;
+		long wrote;
 
 		if (inode->i_sb != sb) {
 			if (work->sb) {
@@ -1855,7 +1856,9 @@ static long writeback_sb_inodes(struct super_block *sb,
 
 		wbc_detach_inode(&wbc);
 		work->nr_pages -= write_chunk - wbc.nr_to_write;
-		wrote += write_chunk - wbc.nr_to_write;
+		wrote = write_chunk - wbc.nr_to_write - wbc.pages_skipped;
+		wrote = wrote < 0 ? 0 : wrote;
+		total_wrote += wrote;
 
 		if (need_resched()) {
 			/*
@@ -1877,7 +1880,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		tmp_wb = inode_to_wb_and_lock_list(inode);
 		spin_lock(&inode->i_lock);
 		if (!(inode->i_state & I_DIRTY_ALL))
-			wrote++;
+			total_wrote++;
 		requeue_inode(inode, tmp_wb, &wbc);
 		inode_sync_complete(inode);
 		spin_unlock(&inode->i_lock);
@@ -1891,14 +1894,14 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 * bail out to wb_writeback() often enough to check
 		 * background threshold and other termination conditions.
 		 */
-		if (wrote) {
+		if (total_wrote) {
 			if (time_is_before_jiffies(start_time + HZ / 10UL))
 				break;
 			if (work->nr_pages <= 0)
 				break;
 		}
 	}
-	return wrote;
+	return total_wrote;
 }
 
 static long __writeback_inodes_wb(struct bdi_writeback *wb,
-- 
2.31.1

