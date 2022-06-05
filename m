Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1CF53DC46
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 16:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345065AbiFEOig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 10:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbiFEOie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:38:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8E611811;
        Sun,  5 Jun 2022 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=280Wtqh+IaR+ohRn0i2SNeEIg3cG1n1gmfJkVF27ebM=; b=BiAVdWspfWXj/AOzHUemf++t4T
        k1JAoS9zARQrO/zZSlmWWy3MLu+WzBYbanzB0z33evw4UEHInxjyWB/0/H424pmzV7+Z7SOvY1Bvc
        T/fLowpBzOmFSBSPYGG7l12f8YZsEMUR3SZ54eoLftKyecse+eFeWK9YD8eusKDhGlc0FPPFNKXYl
        gRW9RKhejDW8Su8HkhlYNk/U8MV7KHmJJtEnXF1+ckWljZc1XUmRnf0/5yER5VNGWLVLUsLM9RnD8
        nw2MTagIu62BjLnoS3qRYXdQJcuywYSqAVHdXfsqSptfQ01mqF0/F6EI6RhOtC14ibBz1eQiX+1OE
        lgsmvymA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxrOU-009mNu-SR; Sun, 05 Jun 2022 14:38:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, tytso@mit.edu,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] ext4: Use generic_quota_read()
Date:   Sun,  5 Jun 2022 15:38:15 +0100
Message-Id: <20220605143815.2330891-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220605143815.2330891-1-willy@infradead.org>
References: <20220605143815.2330891-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The comment about the page cache is rather stale; the buffer cache will
read into the page cache if the buffer isn't present, and the page cache
will not take any locks if the page is present.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/super.c | 81 ++++++++++++-------------------------------------
 1 file changed, 20 insertions(+), 61 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 450c918d68fc..1780649ed224 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1506,8 +1506,6 @@ static int ext4_mark_dquot_dirty(struct dquot *dquot);
 static int ext4_write_info(struct super_block *sb, int type);
 static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 			 const struct path *path);
-static ssize_t ext4_quota_read(struct super_block *sb, int type, char *data,
-			       size_t len, loff_t off);
 static ssize_t ext4_quota_write(struct super_block *sb, int type,
 				const char *data, size_t len, loff_t off);
 static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
@@ -1535,7 +1533,7 @@ static const struct dquot_operations ext4_quota_operations = {
 static const struct quotactl_ops ext4_qctl_operations = {
 	.quota_on	= ext4_quota_on,
 	.quota_off	= ext4_quota_off,
-	.quota_sync	= dquot_quota_sync,
+	.quota_sync	= generic_quota_sync,
 	.get_state	= dquot_get_state,
 	.set_info	= dquot_set_dqinfo,
 	.get_dqblk	= dquot_get_dqblk,
@@ -1559,7 +1557,7 @@ static const struct super_operations ext4_sops = {
 	.statfs		= ext4_statfs,
 	.show_options	= ext4_show_options,
 #ifdef CONFIG_QUOTA
-	.quota_read	= ext4_quota_read,
+	.quota_read	= generic_quota_read,
 	.quota_write	= ext4_quota_write,
 	.get_dquots	= ext4_get_dquots,
 #endif
@@ -6856,55 +6854,15 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	return dquot_quota_off(sb, type);
 }
 
-/* Read data from quotafile - avoid pagecache and such because we cannot afford
- * acquiring the locks... As quota files are never truncated and quota code
- * itself serializes the operations (and no one else should touch the files)
- * we don't have to be afraid of races */
-static ssize_t ext4_quota_read(struct super_block *sb, int type, char *data,
-			       size_t len, loff_t off)
-{
-	struct inode *inode = sb_dqopt(sb)->files[type];
-	ext4_lblk_t blk = off >> EXT4_BLOCK_SIZE_BITS(sb);
-	int offset = off & (sb->s_blocksize - 1);
-	int tocopy;
-	size_t toread;
-	struct buffer_head *bh;
-	loff_t i_size = i_size_read(inode);
-
-	if (off > i_size)
-		return 0;
-	if (off+len > i_size)
-		len = i_size-off;
-	toread = len;
-	while (toread > 0) {
-		tocopy = sb->s_blocksize - offset < toread ?
-				sb->s_blocksize - offset : toread;
-		bh = ext4_bread(NULL, inode, blk, 0);
-		if (IS_ERR(bh))
-			return PTR_ERR(bh);
-		if (!bh)	/* A hole? */
-			memset(data, 0, tocopy);
-		else
-			memcpy(data, bh->b_data+offset, tocopy);
-		brelse(bh);
-		offset = 0;
-		toread -= tocopy;
-		data += tocopy;
-		blk++;
-	}
-	return len;
-}
-
 /* Write to quotafile (we know the transaction is already started and has
  * enough credits) */
 static ssize_t ext4_quota_write(struct super_block *sb, int type,
 				const char *data, size_t len, loff_t off)
 {
 	struct inode *inode = sb_dqopt(sb)->files[type];
-	ext4_lblk_t blk = off >> EXT4_BLOCK_SIZE_BITS(sb);
-	int err = 0, err2 = 0, offset = off & (sb->s_blocksize - 1);
-	int retries = 0;
-	struct buffer_head *bh;
+	int err = 0, offset = off & (sb->s_blocksize - 1);
+	struct buffer_head *bh, *head;
+	struct folio *folio;
 	handle_t *handle = journal_current_handle();
 
 	if (!handle) {
@@ -6924,20 +6882,21 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 		return -EIO;
 	}
 
-	do {
-		bh = ext4_bread(handle, inode, blk,
-				EXT4_GET_BLOCKS_CREATE |
-				EXT4_GET_BLOCKS_METADATA_NOFAIL);
-	} while (PTR_ERR(bh) == -ENOSPC &&
-		 ext4_should_retry_alloc(inode->i_sb, &retries));
-	if (IS_ERR(bh))
-		return PTR_ERR(bh);
-	if (!bh)
+	folio = read_mapping_folio(inode->i_mapping, off / PAGE_SIZE, NULL);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	head = folio_buffers(folio);
+	if (!head)
+		head = alloc_page_buffers(&folio->page, sb->s_blocksize, false);
+	if (!head)
 		goto out;
+	bh = head;
+	while ((bh_offset(bh) + sb->s_blocksize) <= (off % PAGE_SIZE))
+		bh = bh->b_this_page;
 	BUFFER_TRACE(bh, "get write access");
 	err = ext4_journal_get_write_access(handle, sb, bh, EXT4_JTR_NONE);
 	if (err) {
-		brelse(bh);
+		folio_put(folio);
 		return err;
 	}
 	lock_buffer(bh);
@@ -6945,14 +6904,14 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 	flush_dcache_page(bh->b_page);
 	unlock_buffer(bh);
 	err = ext4_handle_dirty_metadata(handle, NULL, bh);
-	brelse(bh);
 out:
+	folio_put(folio);
+	if (err)
+		return err;
 	if (inode->i_size < off + len) {
 		i_size_write(inode, off + len);
 		EXT4_I(inode)->i_disksize = inode->i_size;
-		err2 = ext4_mark_inode_dirty(handle, inode);
-		if (unlikely(err2 && !err))
-			err = err2;
+		err = ext4_mark_inode_dirty(handle, inode);
 	}
 	return err ? err : len;
 }
-- 
2.35.1

