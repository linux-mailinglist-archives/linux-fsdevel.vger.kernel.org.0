Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C655A772E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 09:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiHaHKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 03:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiHaHKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:10:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84FF17040;
        Wed, 31 Aug 2022 00:10:14 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MHZyf0Pg5zHnYm;
        Wed, 31 Aug 2022 15:08:26 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 15:10:12 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cluster-devel@redhat.com>,
        <ntfs3@lists.linux.dev>, <ocfs2-devel@oss.oracle.com>,
        <reiserfs-devel@vger.kernel.org>
CC:     <jack@suse.cz>, <tytso@mit.edu>, <akpm@linux-foundation.org>,
        <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>,
        <rpeterso@redhat.com>, <agruenba@redhat.com>,
        <almaz.alexandrovich@paragon-software.com>, <mark@fasheh.com>,
        <dushistov@mail.ru>, <hch@infradead.org>, <yi.zhang@huawei.com>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 12/14] fs/buffer: remove ll_rw_block() helper
Date:   Wed, 31 Aug 2022 15:21:09 +0800
Message-ID: <20220831072111.3569680-13-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220831072111.3569680-1-yi.zhang@huawei.com>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all ll_rw_block() users has been replaced to new safe helpers,
we just remove it here.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/buffer.c                 | 63 +++----------------------------------
 include/linux/buffer_head.h |  1 -
 2 files changed, 4 insertions(+), 60 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e14adc638bfe..d1d09e2dacc2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -152,7 +152,7 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
 
 /*
  * Default synchronous end-of-IO handler..  Just mark it up-to-date and
- * unlock the buffer. This is what ll_rw_block uses too.
+ * unlock the buffer.
  */
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 {
@@ -491,8 +491,8 @@ int inode_has_buffers(struct inode *inode)
  * all already-submitted IO to complete, but does not queue any new
  * writes to the disk.
  *
- * To do O_SYNC writes, just queue the buffer writes with ll_rw_block as
- * you dirty the buffers, and then use osync_inode_buffers to wait for
+ * To do O_SYNC writes, just queue the buffer writes with write_dirty_buffer
+ * as you dirty the buffers, and then use osync_inode_buffers to wait for
  * completion.  Any other dirty buffers which are not yet queued for
  * write will not be flushed to disk by the osync.
  */
@@ -1807,7 +1807,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 		/*
 		 * The page was marked dirty, but the buffers were
 		 * clean.  Someone wrote them back by hand with
-		 * ll_rw_block/submit_bh.  A rare case.
+		 * write_dirty_buffer/submit_bh.  A rare case.
 		 */
 		end_page_writeback(page);
 
@@ -2714,61 +2714,6 @@ int submit_bh(blk_opf_t opf, struct buffer_head *bh)
 }
 EXPORT_SYMBOL(submit_bh);
 
-/**
- * ll_rw_block: low-level access to block devices (DEPRECATED)
- * @opf: block layer request operation and flags.
- * @nr: number of &struct buffer_heads in the array
- * @bhs: array of pointers to &struct buffer_head
- *
- * ll_rw_block() takes an array of pointers to &struct buffer_heads, and
- * requests an I/O operation on them, either a %REQ_OP_READ or a %REQ_OP_WRITE.
- * @opf contains flags modifying the detailed I/O behavior, most notably
- * %REQ_RAHEAD.
- *
- * This function drops any buffer that it cannot get a lock on (with the
- * BH_Lock state bit), any buffer that appears to be clean when doing a write
- * request, and any buffer that appears to be up-to-date when doing read
- * request.  Further it marks as clean buffers that are processed for
- * writing (the buffer cache won't assume that they are actually clean
- * until the buffer gets unlocked).
- *
- * ll_rw_block sets b_end_io to simple completion handler that marks
- * the buffer up-to-date (if appropriate), unlocks the buffer and wakes
- * any waiters. 
- *
- * All of the buffers must be for the same device, and must also be a
- * multiple of the current approved size for the device.
- */
-void ll_rw_block(const blk_opf_t opf, int nr, struct buffer_head *bhs[])
-{
-	const enum req_op op = opf & REQ_OP_MASK;
-	int i;
-
-	for (i = 0; i < nr; i++) {
-		struct buffer_head *bh = bhs[i];
-
-		if (!trylock_buffer(bh))
-			continue;
-		if (op == REQ_OP_WRITE) {
-			if (test_clear_buffer_dirty(bh)) {
-				bh->b_end_io = end_buffer_write_sync;
-				get_bh(bh);
-				submit_bh(opf, bh);
-				continue;
-			}
-		} else {
-			if (!buffer_uptodate(bh)) {
-				bh->b_end_io = end_buffer_read_sync;
-				get_bh(bh);
-				submit_bh(opf, bh);
-				continue;
-			}
-		}
-		unlock_buffer(bh);
-	}
-}
-EXPORT_SYMBOL(ll_rw_block);
-
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 {
 	lock_buffer(bh);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 8a01c07c0418..1c93ff8c8f51 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -223,7 +223,6 @@ struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
 void __lock_buffer(struct buffer_head *bh);
-void ll_rw_block(blk_opf_t, int, struct buffer_head * bh[]);
 int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
-- 
2.31.1

