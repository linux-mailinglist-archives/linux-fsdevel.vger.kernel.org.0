Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FDE502018
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 03:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348404AbiDOBZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 21:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343588AbiDOBZh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:25:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1600A66C96;
        Thu, 14 Apr 2022 18:23:11 -0700 (PDT)
Received: from kwepemi100012.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kfdkx3d7PzCqw6;
        Fri, 15 Apr 2022 09:18:49 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100012.china.huawei.com (7.221.188.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 09:23:09 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Apr
 2022 09:23:08 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <torvalds@linux-foundation.org>,
        <hch@lst.de>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] fs-writeback: Flush plug before next iteration in wb_writeback()
Date:   Fri, 15 Apr 2022 09:37:35 +0800
Message-ID: <20220415013735.1610091-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Fix it by flush plug before next iteration in wb_writeback().

Goto Link to find a reproducer.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215837
Cc: stable@vger.kernel.org # v4.3
Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/fs-writeback.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 591fe9cf1659..e524c0a1749c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2036,8 +2036,21 @@ static long wb_writeback(struct bdi_writeback *wb,
 		 * mean the overall work is done. So we keep looping as long
 		 * as made some progress on cleaning pages or inodes.
 		 */
-		if (progress)
+		if (progress) {
+			/*
+			 * The progress may be false postive in page redirty
+			 * case (which is caused by failing to get buffer head
+			 * lock), which will requeue dirty inodes and start
+			 * next writeback iteration, and other tasks maybe
+			 * stuck for getting tags for new requests. So, flush
+			 * plug to schedule requests holding tags.
+			 *
+			 * The code can be removed after buffer head
+			 * disappering from linux.
+			 */
+			blk_flush_plug(current->plug, false);
 			continue;
+		}
 		/*
 		 * No more inodes for IO, bail
 		 */
-- 
2.31.1

