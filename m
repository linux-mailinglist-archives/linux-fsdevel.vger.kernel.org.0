Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79CE44795E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbhKHEbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhKHEbd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:31:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B78EC061570;
        Sun,  7 Nov 2021 20:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FFUWVznVjkFny3CeBnySJ30Sr87Ms+/L5ZarsHXVCDs=; b=ZnAHgapdFTx7RwBoh6tHHaw3+z
        zXPtT1PxxtQ/XivY5COItC0EccD3TFQuOguWfniKFWdN+QfUzAp70yHZPaUkLLuAhqbP5h5z7MHCw
        j9F5mSElVGmEXlAjAIDsH0QKp5QnS9cehGc2sEuPGa5jGaH9H9oKaXRvF2uRUZSUewEEJK9D46KCK
        F9GOOBmCbyLl+KI6hRUG6DjlGmJi5ws/pV9tzS+Dw98nJrSMWfeW7TAmV29TBy/+0gasaOHDLTq20
        SEmKkilsZIL0AGfUM+uzuX7grQiNg96PeaYnINFsxsiQd93uX1cLSRsiivcwE+Mz2eAlz6fHtBzra
        oF01EB/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwC3-0089rj-TH; Mon, 08 Nov 2021 04:24:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 07/28] fs/buffer: Convert __block_write_begin_int() to take a folio
Date:   Mon,  8 Nov 2021 04:05:30 +0000
Message-Id: <20211108040551.1942823-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are no plans to convert buffer_head infrastructure to use multi-page
folios, but __block_write_begin_int() is called from iomap, and it's
more convenient and less error-prone if we pass in a folio from iomap.
It also has a nice saving of almost 200 bytes of code from removing
repeated calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c            | 22 +++++++++++-----------
 fs/internal.h          |  2 +-
 fs/iomap/buffered-io.c |  7 +++++--
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 46bc589b7a03..b1d722b26fe9 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1969,34 +1969,34 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 	}
 }
 
-int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
+int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block, const struct iomap *iomap)
 {
 	unsigned from = pos & (PAGE_SIZE - 1);
 	unsigned to = from + len;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	unsigned block_start, block_end;
 	sector_t block;
 	int err = 0;
 	unsigned blocksize, bbits;
 	struct buffer_head *bh, *head, *wait[2], **wait_bh=wait;
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(from > PAGE_SIZE);
 	BUG_ON(to > PAGE_SIZE);
 	BUG_ON(from > to);
 
-	head = create_page_buffers(page, inode, 0);
+	head = create_page_buffers(&folio->page, inode, 0);
 	blocksize = head->b_size;
 	bbits = block_size_bits(blocksize);
 
-	block = (sector_t)page->index << (PAGE_SHIFT - bbits);
+	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
 
 	for(bh = head, block_start = 0; bh != head || !block_start;
 	    block++, block_start=block_end, bh = bh->b_this_page) {
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
-			if (PageUptodate(page)) {
+			if (folio_test_uptodate(folio)) {
 				if (!buffer_uptodate(bh))
 					set_buffer_uptodate(bh);
 			}
@@ -2016,20 +2016,20 @@ int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
 
 			if (buffer_new(bh)) {
 				clean_bdev_bh_alias(bh);
-				if (PageUptodate(page)) {
+				if (folio_test_uptodate(folio)) {
 					clear_buffer_new(bh);
 					set_buffer_uptodate(bh);
 					mark_buffer_dirty(bh);
 					continue;
 				}
 				if (block_end > to || block_start < from)
-					zero_user_segments(page,
+					folio_zero_segments(folio,
 						to, block_end,
 						block_start, from);
 				continue;
 			}
 		}
-		if (PageUptodate(page)) {
+		if (folio_test_uptodate(folio)) {
 			if (!buffer_uptodate(bh))
 				set_buffer_uptodate(bh);
 			continue; 
@@ -2050,14 +2050,14 @@ int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
 			err = -EIO;
 	}
 	if (unlikely(err))
-		page_zero_new_buffers(page, from, to);
+		page_zero_new_buffers(&folio->page, from, to);
 	return err;
 }
 
 int __block_write_begin(struct page *page, loff_t pos, unsigned len,
 		get_block_t *get_block)
 {
-	return __block_write_begin_int(page, pos, len, get_block, NULL);
+	return __block_write_begin_int(page_folio(page), pos, len, get_block, NULL);
 }
 EXPORT_SYMBOL(__block_write_begin);
 
diff --git a/fs/internal.h b/fs/internal.h
index cdd83d4899bb..afc13443392b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -37,7 +37,7 @@ static inline int emergency_thaw_bdev(struct super_block *sb)
 /*
  * buffer.c
  */
-int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
+int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block, const struct iomap *iomap);
 
 /*
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1753c26c8e76..4e09ea823148 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -597,6 +597,7 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct page *page;
+	struct folio *folio;
 	int status = 0;
 
 	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
@@ -618,11 +619,12 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		status = -ENOMEM;
 		goto out_no_page;
 	}
+	folio = page_folio(page);
 
 	if (srcmap->type == IOMAP_INLINE)
 		status = iomap_write_begin_inline(iter, page);
 	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
-		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
+		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
 	else
 		status = __iomap_write_begin(iter, pos, len, page);
 
@@ -954,11 +956,12 @@ EXPORT_SYMBOL_GPL(iomap_truncate_page);
 static loff_t iomap_page_mkwrite_iter(struct iomap_iter *iter,
 		struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	loff_t length = iomap_length(iter);
 	int ret;
 
 	if (iter->iomap.flags & IOMAP_F_BUFFER_HEAD) {
-		ret = __block_write_begin_int(page, iter->pos, length, NULL,
+		ret = __block_write_begin_int(folio, iter->pos, length, NULL,
 					      &iter->iomap);
 		if (ret)
 			return ret;
-- 
2.33.0

