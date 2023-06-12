Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE76072D17D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbjFLVFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbjFLVEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:04:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC4420C
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 14:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LqgS6qgWtiqJa73/VdHea0R38qiYynjcB4wwTpq3gcQ=; b=MTi9yrf7kJncAdwaS/HpHbjWfp
        wxZ0cuGpUe8taydOM/uRs+SaFVsfDkT+ovdeSqXmydiDimKYlTX1bdxvFFac/hUqdNycv1sXHIsb0
        siLob4N1c9H2XbTbsxWExOimZofKyAh1UGqwx4aYCjxG+C6/lvQJGtZgQSu92OHWcTFdNtcgLpf+W
        wJo/6teIU1Xw+YiRbeG1yDyQIWBqGnm3L6GZTwTF3LfFvR/nAwXt6SIBHYs3RlcZEAAZ/DMkBAPae
        G6i4t3UcxQQoaG+bpA8bYgmSVfsMOHIttmJe3UnCqZ07bVfrgC2ApoMPZL/BVDTJqZfl0tBFcZCPg
        jsQB5QhA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8ofX-0033wk-6y; Mon, 12 Jun 2023 21:01:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH v3 04/14] buffer: Convert __block_write_full_page() to __block_write_full_folio()
Date:   Mon, 12 Jun 2023 22:01:31 +0100
Message-Id: <20230612210141.730128-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230612210141.730128-1-willy@infradead.org>
References: <20230612210141.730128-1-willy@infradead.org>
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

Remove nine hidden calls to compound_head() by using a folio instead
of a page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Bob Peterson <rpeterso@redhat.com>
Reviewed-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/buffer.c                 | 53 +++++++++++++++++++------------------
 fs/gfs2/aops.c              |  5 ++--
 fs/ntfs/aops.c              |  2 +-
 fs/reiserfs/inode.c         |  2 +-
 include/linux/buffer_head.h |  2 +-
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a7fc561758b1..4d518df50fab 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1764,7 +1764,7 @@ static struct buffer_head *folio_create_buffers(struct folio *folio,
  * WB_SYNC_ALL, the writes are posted using REQ_SYNC; this
  * causes the writes to be flagged as synchronous writes.
  */
-int __block_write_full_page(struct inode *inode, struct page *page,
+int __block_write_full_folio(struct inode *inode, struct folio *folio,
 			get_block_t *get_block, struct writeback_control *wbc,
 			bh_end_io_t *handler)
 {
@@ -1776,14 +1776,14 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	int nr_underway = 0;
 	blk_opf_t write_flags = wbc_to_write_flags(wbc);
 
-	head = folio_create_buffers(page_folio(page), inode,
+	head = folio_create_buffers(folio, inode,
 				    (1 << BH_Dirty) | (1 << BH_Uptodate));
 
 	/*
 	 * Be very careful.  We have no exclusion from block_dirty_folio
 	 * here, and the (potentially unmapped) buffers may become dirty at
 	 * any time.  If a buffer becomes dirty here after we've inspected it
-	 * then we just miss that fact, and the page stays dirty.
+	 * then we just miss that fact, and the folio stays dirty.
 	 *
 	 * Buffers outside i_size may be dirtied by block_dirty_folio;
 	 * handle that here by just cleaning them.
@@ -1793,7 +1793,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	blocksize = bh->b_size;
 	bbits = block_size_bits(blocksize);
 
-	block = (sector_t)page->index << (PAGE_SHIFT - bbits);
+	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
 	last_block = (i_size_read(inode) - 1) >> bbits;
 
 	/*
@@ -1804,7 +1804,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 		if (block > last_block) {
 			/*
 			 * mapped buffers outside i_size will occur, because
-			 * this page can be outside i_size when there is a
+			 * this folio can be outside i_size when there is a
 			 * truncate in progress.
 			 */
 			/*
@@ -1834,7 +1834,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 			continue;
 		/*
 		 * If it's a fully non-blocking write attempt and we cannot
-		 * lock the buffer then redirty the page.  Note that this can
+		 * lock the buffer then redirty the folio.  Note that this can
 		 * potentially cause a busy-wait loop from writeback threads
 		 * and kswapd activity, but those code paths have their own
 		 * higher-level throttling.
@@ -1842,7 +1842,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 		if (wbc->sync_mode != WB_SYNC_NONE) {
 			lock_buffer(bh);
 		} else if (!trylock_buffer(bh)) {
-			redirty_page_for_writepage(wbc, page);
+			folio_redirty_for_writepage(wbc, folio);
 			continue;
 		}
 		if (test_clear_buffer_dirty(bh)) {
@@ -1853,11 +1853,11 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	} while ((bh = bh->b_this_page) != head);
 
 	/*
-	 * The page and its buffers are protected by PageWriteback(), so we can
-	 * drop the bh refcounts early.
+	 * The folio and its buffers are protected by the writeback flag,
+	 * so we can drop the bh refcounts early.
 	 */
-	BUG_ON(PageWriteback(page));
-	set_page_writeback(page);
+	BUG_ON(folio_test_writeback(folio));
+	folio_start_writeback(folio);
 
 	do {
 		struct buffer_head *next = bh->b_this_page;
@@ -1867,20 +1867,20 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 		}
 		bh = next;
 	} while (bh != head);
-	unlock_page(page);
+	folio_unlock(folio);
 
 	err = 0;
 done:
 	if (nr_underway == 0) {
 		/*
-		 * The page was marked dirty, but the buffers were
+		 * The folio was marked dirty, but the buffers were
 		 * clean.  Someone wrote them back by hand with
 		 * write_dirty_buffer/submit_bh.  A rare case.
 		 */
-		end_page_writeback(page);
+		folio_end_writeback(folio);
 
 		/*
-		 * The page and buffer_heads can be released at any time from
+		 * The folio and buffer_heads can be released at any time from
 		 * here on.
 		 */
 	}
@@ -1891,7 +1891,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	 * ENOSPC, or some other error.  We may already have added some
 	 * blocks to the file, so we need to write these out to avoid
 	 * exposing stale data.
-	 * The page is currently locked and not marked for writeback
+	 * The folio is currently locked and not marked for writeback
 	 */
 	bh = head;
 	/* Recovery: lock and submit the mapped buffers */
@@ -1903,15 +1903,15 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 		} else {
 			/*
 			 * The buffer may have been set dirty during
-			 * attachment to a dirty page.
+			 * attachment to a dirty folio.
 			 */
 			clear_buffer_dirty(bh);
 		}
 	} while ((bh = bh->b_this_page) != head);
-	SetPageError(page);
-	BUG_ON(PageWriteback(page));
-	mapping_set_error(page->mapping, err);
-	set_page_writeback(page);
+	folio_set_error(folio);
+	BUG_ON(folio_test_writeback(folio));
+	mapping_set_error(folio->mapping, err);
+	folio_start_writeback(folio);
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
@@ -1921,10 +1921,10 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 		}
 		bh = next;
 	} while (bh != head);
-	unlock_page(page);
+	folio_unlock(folio);
 	goto done;
 }
-EXPORT_SYMBOL(__block_write_full_page);
+EXPORT_SYMBOL(__block_write_full_folio);
 
 /*
  * If a page has any new buffers, zero them out here, and mark them uptodate
@@ -2677,6 +2677,7 @@ EXPORT_SYMBOL(block_truncate_page);
 int block_write_full_page(struct page *page, get_block_t *get_block,
 			struct writeback_control *wbc)
 {
+	struct folio *folio = page_folio(page);
 	struct inode * const inode = page->mapping->host;
 	loff_t i_size = i_size_read(inode);
 	const pgoff_t end_index = i_size >> PAGE_SHIFT;
@@ -2684,13 +2685,13 @@ int block_write_full_page(struct page *page, get_block_t *get_block,
 
 	/* Is the page fully inside i_size? */
 	if (page->index < end_index)
-		return __block_write_full_page(inode, page, get_block, wbc,
+		return __block_write_full_folio(inode, folio, get_block, wbc,
 					       end_buffer_async_write);
 
 	/* Is the page fully outside i_size? (truncate in progress) */
 	offset = i_size & (PAGE_SIZE-1);
 	if (page->index >= end_index+1 || !offset) {
-		unlock_page(page);
+		folio_unlock(folio);
 		return 0; /* don't care */
 	}
 
@@ -2702,7 +2703,7 @@ int block_write_full_page(struct page *page, get_block_t *get_block,
 	 * writes to that region are not written out to the file."
 	 */
 	zero_user_segment(page, offset, PAGE_SIZE);
-	return __block_write_full_page(inode, page, get_block, wbc,
+	return __block_write_full_folio(inode, folio, get_block, wbc,
 							end_buffer_async_write);
 }
 EXPORT_SYMBOL(block_write_full_page);
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index ec5b5c1ea634..3a2be1901e1e 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -107,9 +107,8 @@ static int gfs2_write_jdata_folio(struct folio *folio,
 		folio_zero_segment(folio, offset_in_folio(folio, i_size),
 				folio_size(folio));
 
-	return __block_write_full_page(inode, &folio->page,
-				       gfs2_get_block_noalloc, wbc,
-				       end_buffer_async_write);
+	return __block_write_full_folio(inode, folio, gfs2_get_block_noalloc,
+			wbc, end_buffer_async_write);
 }
 
 /**
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index e8aeba124a95..4e158bce4192 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -526,7 +526,7 @@ static int ntfs_read_folio(struct file *file, struct folio *folio)
  *
  * Return 0 on success and -errno on error.
  *
- * Based on ntfs_read_block() and __block_write_full_page().
+ * Based on ntfs_read_block() and __block_write_full_folio().
  */
 static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 {
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index d8debbb6105f..ff34ee49106f 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2506,7 +2506,7 @@ static int map_block_for_writepage(struct inode *inode,
 
 /*
  * mason@suse.com: updated in 2.5.54 to follow the same general io
- * start/recovery path as __block_write_full_page, along with special
+ * start/recovery path as __block_write_full_folio, along with special
  * code to handle reiserfs tails.
  */
 static int reiserfs_write_full_page(struct page *page,
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 1520793c72da..a366e01f8bd4 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -263,7 +263,7 @@ extern int buffer_heads_over_limit;
 void block_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 int block_write_full_page(struct page *page, get_block_t *get_block,
 				struct writeback_control *wbc);
-int __block_write_full_page(struct inode *inode, struct page *page,
+int __block_write_full_folio(struct inode *inode, struct folio *folio,
 			get_block_t *get_block, struct writeback_control *wbc,
 			bh_end_io_t *handler);
 int block_read_full_folio(struct folio *, get_block_t *);
-- 
2.39.2

