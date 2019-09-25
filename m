Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69CD9BD5D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 02:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411305AbfIYAwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 20:52:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411300AbfIYAwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D/5bQzcGgQkfd9G5pE3hprJOP16SeMHFGWAqOiEhlJY=; b=aTZHh/d9DRCSCokXrgRZVDp95Q
        JFiJRGFfX2XRziAr0NNDDVnvnddQqPOf9Y9KdTukniRF7GPiTcx0G9fRuPW4HVJ/uOXQ4bNjdEmUJ
        WvRHt6+/lCX7LyoQvEDPnhDPJ0ZKnFIA7AiBbdH3RrIql1Iqml5hHQ3rDhuUwMgrxXiA/S7hZ8OHq
        ekdi/VhpAzucXxN5mq9c+0XlNhjVtG6awVibsgij1m2lAUQGPD70r2Y50ATYn/647qL0o2RLqMxNX
        n/SNQ9Ng2IlWjzPmCGYc6SZ/aMk7Pdmi/SCZRsFQe39dpm3RD7QwYCUON6HEMbgLBOI4mOHSoDhwP
        E4Tc3qcA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXV-00076S-C3; Wed, 25 Sep 2019 00:52:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 04/15] iomap: Support large pages
Date:   Tue, 24 Sep 2019 17:52:03 -0700
Message-Id: <20190925005214.27240-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925005214.27240-1-willy@infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Change iomap_page from a statically sized uptodate bitmap to a dynamically
allocated uptodate bitmap, allowing an arbitrarily large page.

The only remaining places where iomap assumes an order-0 page are for
files with inline data, where there's no sense in allocating a larger
page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 119 ++++++++++++++++++++++++++---------------
 include/linux/iomap.h  |   2 +-
 include/linux/mm.h     |   2 +
 3 files changed, 80 insertions(+), 43 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0e76a4b6d98a..15d844a88439 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -23,14 +23,14 @@ static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
 	struct iomap_page *iop = to_iomap_page(page);
+	unsigned int n;
 
 	if (iop || i_blocks_per_page(inode, page) <= 1)
 		return iop;
 
-	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
-	atomic_set(&iop->read_count, 0);
-	atomic_set(&iop->write_count, 0);
-	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+	n = BITS_TO_LONGS(i_blocks_per_page(inode, page));
+	iop = kmalloc(struct_size(iop, uptodate, n),
+			GFP_NOFS | __GFP_NOFAIL | __GFP_ZERO);
 
 	/*
 	 * migrate_page_move_mapping() assumes that pages with private data have
@@ -61,15 +61,16 @@ iomap_page_release(struct page *page)
  * Calculate the range inside the page that we actually need to read.
  */
 static void
-iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
+iomap_adjust_read_range(struct inode *inode, struct page *page,
 		loff_t *pos, loff_t length, unsigned *offp, unsigned *lenp)
 {
+	struct iomap_page *iop = to_iomap_page(page);
 	loff_t orig_pos = *pos;
 	loff_t isize = i_size_read(inode);
 	unsigned block_bits = inode->i_blkbits;
 	unsigned block_size = (1 << block_bits);
-	unsigned poff = offset_in_page(*pos);
-	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, length);
+	unsigned poff = offset_in_this_page(page, *pos);
+	unsigned plen = min_t(loff_t, page_size(page) - poff, length);
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
@@ -107,7 +108,8 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
 	if (orig_pos <= isize && orig_pos + length > isize) {
-		unsigned end = offset_in_page(isize - 1) >> block_bits;
+		unsigned end = offset_in_this_page(page, isize - 1) >>
+				block_bits;
 
 		if (first <= end && last > end)
 			plen -= (last - end) * block_size;
@@ -121,19 +123,16 @@ static void
 iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 {
 	struct iomap_page *iop = to_iomap_page(page);
-	struct inode *inode = page->mapping->host;
-	unsigned first = off >> inode->i_blkbits;
-	unsigned last = (off + len - 1) >> inode->i_blkbits;
-	unsigned int i;
 	bool uptodate = true;
 
 	if (iop) {
-		for (i = 0; i < i_blocks_per_page(inode, page); i++) {
-			if (i >= first && i <= last)
-				set_bit(i, iop->uptodate);
-			else if (!test_bit(i, iop->uptodate))
-				uptodate = false;
-		}
+		struct inode *inode = page->mapping->host;
+		unsigned first = off >> inode->i_blkbits;
+		unsigned count = len >> inode->i_blkbits;
+
+		bitmap_set(iop->uptodate, first, count);
+		if (!bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
+			uptodate = false;
 	}
 
 	if (uptodate && !PageError(page))
@@ -194,6 +193,7 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 		return;
 
 	BUG_ON(page->index);
+	BUG_ON(PageCompound(page));
 	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	addr = kmap_atomic(page);
@@ -203,6 +203,16 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 	SetPageUptodate(page);
 }
 
+/*
+ * Estimate the number of vectors we need based on the current page size;
+ * if we're wrong we'll end up doing an overly large allocation or needing
+ * to do a second allocation, neither of which is a big deal.
+ */
+static unsigned int iomap_nr_vecs(struct page *page, loff_t length)
+{
+	return (length + page_size(page) - 1) >> page_shift(page);
+}
+
 static loff_t
 iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap)
@@ -222,7 +232,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
-	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
+	iomap_adjust_read_range(inode, page, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
@@ -258,7 +268,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
-		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		int nr_vecs = iomap_nr_vecs(page, length);
 
 		if (ctx->bio)
 			submit_bio(ctx->bio);
@@ -293,9 +303,9 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 	unsigned poff;
 	loff_t ret;
 
-	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
-		ret = iomap_apply(inode, page_offset(page) + poff,
-				PAGE_SIZE - poff, 0, ops, &ctx,
+	for (poff = 0; poff < page_size(page); poff += ret) {
+		ret = iomap_apply(inode, file_offset_of_page(page) + poff,
+				page_size(page) - poff, 0, ops, &ctx,
 				iomap_readpage_actor);
 		if (ret <= 0) {
 			WARN_ON_ONCE(ret == 0);
@@ -328,7 +338,7 @@ iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
 	while (!list_empty(pages)) {
 		struct page *page = lru_to_page(pages);
 
-		if (page_offset(page) >= (u64)pos + length)
+		if (file_offset_of_page(page) >= (u64)pos + length)
 			break;
 
 		list_del(&page->lru);
@@ -342,7 +352,7 @@ iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
 		 * readpages call itself as every page gets checked again once
 		 * actually needed.
 		 */
-		*done += PAGE_SIZE;
+		*done += page_size(page);
 		put_page(page);
 	}
 
@@ -355,9 +365,14 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 {
 	struct iomap_readpage_ctx *ctx = data;
 	loff_t done, ret;
+	size_t left = 0;
+
+	if (ctx->cur_page)
+		left = page_size(ctx->cur_page) -
+					offset_in_this_page(ctx->cur_page, pos);
 
 	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
+		if (ctx->cur_page && left == 0) {
 			if (!ctx->cur_page_in_bio)
 				unlock_page(ctx->cur_page);
 			put_page(ctx->cur_page);
@@ -369,14 +384,27 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 			if (!ctx->cur_page)
 				break;
 			ctx->cur_page_in_bio = false;
+			left = page_size(ctx->cur_page);
 		}
 		ret = iomap_readpage_actor(inode, pos + done, length - done,
 				ctx, iomap);
+		left -= ret;
 	}
 
 	return done;
 }
 
+/* move to fs.h? */
+static inline struct page *readahead_first_page(struct list_head *head)
+{
+	return list_entry(head->prev, struct page, lru);
+}
+
+static inline struct page *readahead_last_page(struct list_head *head)
+{
+	return list_entry(head->next, struct page, lru);
+}
+
 int
 iomap_readpages(struct address_space *mapping, struct list_head *pages,
 		unsigned nr_pages, const struct iomap_ops *ops)
@@ -385,9 +413,10 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 		.pages		= pages,
 		.is_readahead	= true,
 	};
-	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
-	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
-	loff_t length = last - pos + PAGE_SIZE, ret = 0;
+	loff_t pos = file_offset_of_page(readahead_first_page(pages));
+	loff_t end = file_offset_of_next_page(readahead_last_page(pages));
+	loff_t length = end - pos;
+	loff_t ret = 0;
 
 	while (length > 0) {
 		ret = iomap_apply(mapping->host, pos, length, 0, ops,
@@ -410,7 +439,7 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 	}
 
 	/*
-	 * Check that we didn't lose a page due to the arcance calling
+	 * Check that we didn't lose a page due to the arcane calling
 	 * conventions..
 	 */
 	WARN_ON_ONCE(!ret && !list_empty(ctx.pages));
@@ -435,7 +464,7 @@ iomap_is_partially_uptodate(struct page *page, unsigned long from,
 	unsigned i;
 
 	/* Limit range to one page */
-	len = min_t(unsigned, PAGE_SIZE - from, count);
+	len = min_t(unsigned, page_size(page) - from, count);
 
 	/* First and last blocks in range within page */
 	first = from >> inode->i_blkbits;
@@ -474,7 +503,7 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 	 * If we are invalidating the entire page, clear the dirty state from it
 	 * and release it to avoid unnecessary buildup of the LRU.
 	 */
-	if (offset == 0 && len == PAGE_SIZE) {
+	if (offset == 0 && len == page_size(page)) {
 		WARN_ON_ONCE(PageWriteback(page));
 		cancel_dirty_page(page);
 		iomap_page_release(page);
@@ -550,18 +579,20 @@ static int
 __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
 		struct page *page, struct iomap *iomap)
 {
-	struct iomap_page *iop = iomap_page_create(inode, page);
 	loff_t block_size = i_blocksize(inode);
 	loff_t block_start = pos & ~(block_size - 1);
 	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
-	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
+	unsigned from = offset_in_this_page(page, pos);
+	unsigned to = from + len;
+	unsigned poff, plen;
 	int status = 0;
 
 	if (PageUptodate(page))
 		return 0;
+	iomap_page_create(inode, page);
 
 	do {
-		iomap_adjust_read_range(inode, iop, &block_start,
+		iomap_adjust_read_range(inode, page, &block_start,
 				block_end - block_start, &poff, &plen);
 		if (plen == 0)
 			break;
@@ -673,7 +704,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	 */
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
-	iomap_set_range_uptodate(page, offset_in_page(pos), len);
+	iomap_set_range_uptodate(page, offset_in_this_page(page, pos), len);
 	iomap_set_page_dirty(page);
 	return copied;
 }
@@ -685,6 +716,7 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
 	void *addr;
 
 	WARN_ON_ONCE(!PageUptodate(page));
+	BUG_ON(PageCompound(page));
 	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	addr = kmap_atomic(page);
@@ -749,6 +781,10 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
 
+		/*
+		 * XXX: We don't know what size page we'll find in the
+		 * page cache, so only copy up to a regular page boundary.
+		 */
 		offset = offset_in_page(pos);
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
 						iov_iter_count(i));
@@ -1041,19 +1077,18 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 	lock_page(page);
 	size = i_size_read(inode);
 	if ((page->mapping != inode->i_mapping) ||
-	    (page_offset(page) > size)) {
+	    (file_offset_of_page(page) > size)) {
 		/* We overload EFAULT to mean page got truncated */
 		ret = -EFAULT;
 		goto out_unlock;
 	}
 
-	/* page is wholly or partially inside EOF */
-	if (((page->index + 1) << PAGE_SHIFT) > size)
-		length = offset_in_page(size);
+	offset = file_offset_of_page(page);
+	if (size - offset < page_size(page))
+		length = offset_in_this_page(page, size);
 	else
-		length = PAGE_SIZE;
+		length = page_size(page);
 
-	offset = page_offset(page);
 	while (length > 0) {
 		ret = iomap_apply(inode, offset, length,
 				IOMAP_WRITE | IOMAP_FAULT, ops, page,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bc499ceae392..86be24a8259b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -139,7 +139,7 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 struct iomap_page {
 	atomic_t		read_count;
 	atomic_t		write_count;
-	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
+	unsigned long		uptodate[];
 };
 
 static inline struct iomap_page *to_iomap_page(struct page *page)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 294a67b94147..04bea9f9282c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1415,6 +1415,8 @@ static inline void clear_page_pfmemalloc(struct page *page)
 extern void pagefault_out_of_memory(void);
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
+#define offset_in_this_page(page, p)	\
+	((unsigned long)(p) & (page_size(page) - 1))
 
 /*
  * Flags passed to show_mem() and show_free_areas() to suppress output in
-- 
2.23.0

