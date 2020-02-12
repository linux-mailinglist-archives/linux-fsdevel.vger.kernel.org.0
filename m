Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D911C159FE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgBLESs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:18:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53958 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Akb0WAOF7QXNlcGV5Jo3slrj0DWeTKrSDHLBEAFZyQo=; b=JmBotViaw17Fpv0rX8r920ud8v
        gvwB06iH1yebAwT05IgWsF35N8L/z3MfTRwcbA/+edkCt5PDtRRvyJKgX1Zs1xyjKXrgoQ3/F7wtm
        ClUFOlYoly8K5XVu4kihVGcq6CUd7NvtQILRNTP6QsiUvvynXlJ46xVlgeQhzcjY1fuBtH/tDm9z5
        Jl6laf1T4z3RGi8SXvH2Sq6PNhsQb4w+o53oYwsZf2z52oko7ArM0zDh/dYlKzgFBxaucQ8gU1YWs
        awYt2DS8lkSJQcODtOu89pHporVkbPNTgIWslA25H3eCLiT3GdPBpKVuDxv/4gk0//WUuxD/wAxNl
        gtvYFBPw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU7-0006oK-65; Wed, 12 Feb 2020 04:18:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/25] iomap: Support large pages in write paths
Date:   Tue, 11 Feb 2020 20:18:37 -0800
Message-Id: <20200212041845.25879-18-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use thp_size() instead of PAGE_SIZE, offset_in_this_page().
Also simplify the logic in iomap_do_writepage() for determining end of
file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 68f8903ecd6d..af1f56408fcd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -445,7 +445,7 @@ iomap_is_partially_uptodate(struct page *page, unsigned long from,
 	unsigned i;
 
 	/* Limit range to one page */
-	len = min_t(unsigned, PAGE_SIZE - from, count);
+	len = min_t(unsigned, thp_size(page) - from, count);
 
 	/* First and last blocks in range within page */
 	first = from >> inode->i_blkbits;
@@ -488,7 +488,7 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 	 * If we are invalidating the entire page, clear the dirty state from it
 	 * and release it to avoid unnecessary buildup of the LRU.
 	 */
-	if (offset == 0 && len == PAGE_SIZE) {
+	if (offset == 0 && len == thp_size(page)) {
 		WARN_ON_ONCE(PageWriteback(page));
 		cancel_dirty_page(page);
 		iomap_page_release(page);
@@ -564,7 +564,9 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	loff_t block_size = i_blocksize(inode);
 	loff_t block_start = pos & ~(block_size - 1);
 	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
-	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
+	unsigned from = offset_in_this_page(page, pos);
+	unsigned to = from + len;
+	unsigned poff, plen;
 	int status;
 
 	if (PageUptodate(page))
@@ -696,7 +698,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	 */
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
-	iomap_set_range_uptodate(page, offset_in_page(pos), len);
+	iomap_set_range_uptodate(page, offset_in_this_page(page, pos), len);
 	iomap_set_page_dirty(page);
 	return copied;
 }
@@ -771,6 +773,10 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
 
+		/*
+		 * XXX: We don't know what size page we'll find in the
+		 * page cache, so only copy up to a regular page boundary.
+		 */
 		offset = offset_in_page(pos);
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
 						iov_iter_count(i));
@@ -1320,7 +1326,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 {
 	sector_t sector = iomap_sector(&wpc->iomap, offset);
 	unsigned len = i_blocksize(inode);
-	unsigned poff = offset & (PAGE_SIZE - 1);
+	unsigned poff = offset & (thp_size(page) - 1);
 	bool merged, same_page = false;
 
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
@@ -1372,9 +1378,10 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	unsigned len = i_blocksize(inode);
 	u64 file_offset; /* file offset of page */
 	int error = 0, count = 0, i;
+	int nr_blocks = i_blocks_per_page(inode, page);
 	LIST_HEAD(submit_list);
 
-	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
+	WARN_ON_ONCE(nr_blocks > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
 
 	/*
@@ -1382,8 +1389,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * end of the current map or find the current map invalid, grab a new
 	 * one.
 	 */
-	for (i = 0, file_offset = page_offset(page);
-	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
+	for (i = 0, file_offset = file_offset_of_page(page);
+	     i < nr_blocks && file_offset < end_offset;
 	     i++, file_offset += len) {
 		if (iop && !test_bit(i, iop->uptodate))
 			continue;
@@ -1477,7 +1484,6 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 {
 	struct iomap_writepage_ctx *wpc = data;
 	struct inode *inode = page->mapping->host;
-	pgoff_t end_index;
 	u64 end_offset;
 	loff_t offset;
 
@@ -1518,10 +1524,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 	 * ---------------------------------^------------------|
 	 */
 	offset = i_size_read(inode);
-	end_index = offset >> PAGE_SHIFT;
-	if (page->index < end_index)
-		end_offset = (loff_t)(page->index + 1) << PAGE_SHIFT;
-	else {
+	end_offset = file_offset_of_next_page(page);
+
+	if (end_offset > offset) {
 		/*
 		 * Check whether the page to write out is beyond or straddles
 		 * i_size or not.
@@ -1533,7 +1538,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * |				    |      Straddles     |
 		 * ---------------------------------^-----------|--------|
 		 */
-		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
+		unsigned offset_into_page = offset_in_this_page(page, offset);
+		pgoff_t end_index = offset >> PAGE_SHIFT;
 
 		/*
 		 * Skip the page if it is fully outside i_size, e.g. due to a
@@ -1564,7 +1570,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * memory is zeroed when mapped, and writes to that region are
 		 * not written out to the file."
 		 */
-		zero_user_segment(page, offset_into_page, PAGE_SIZE);
+		zero_user_segment(page, offset_into_page, thp_size(page));
 
 		/* Adjust the end_offset to the end of file */
 		end_offset = offset;
-- 
2.25.0

