Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7494D1BDF46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 15:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgD2Nlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 09:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgD2NhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:37:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF01C03C1AD;
        Wed, 29 Apr 2020 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bOEbKIsQIFnCtSDYQkNPerOlNIh4Nn7TrV9caXzQimA=; b=tmNyVBN5wFfv8upzxj5VjRpHh2
        uckdawMPejrJi+vyScItinIu/HXlQe0TdhyOgr8Cs/m2qk/tbygMa3YM7tbRq1LyMrEWfwZtOWiX/
        GQNXJ3Q2UqNnuf6aGU9VlHfRDadqv4WyFRF8F6LICdZp/Jq/PUXs8IJS09FcolnFxHA52vnqeFLf5
        UG3afY1rxFd72OPbhnn3GGkghiLFrQwmOUA537UNVjuLSzZ31ttw4Be6u6d7aIket5PkKOCU2duBs
        Lc44PXdeOAohIzGA+uGnMT1G1LUU6m1ttGUG1IEXY9gbL5iQn9FL6Lh3sJ3ywDS93pXvoV3xKnYUx
        xLBAyJBQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtX-0005va-Hr; Wed, 29 Apr 2020 13:36:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/25] iomap: Support large pages in write paths
Date:   Wed, 29 Apr 2020 06:36:45 -0700
Message-Id: <20200429133657.22632-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use thp_size() instead of PAGE_SIZE and offset_in_thp() instead of
offset_in_page().  Also simplify the logic in iomap_do_writepage()
for determining end of file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 43 +++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 75f42c0d4cd9..709be90a1997 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -466,7 +466,7 @@ iomap_is_partially_uptodate(struct page *page, unsigned long from,
 	unsigned i;
 
 	/* Limit range to one page */
-	len = min_t(unsigned, PAGE_SIZE - from, count);
+	len = min_t(unsigned, thp_size(page) - from, count);
 
 	/* First and last blocks in range within page */
 	first = from >> inode->i_blkbits;
@@ -510,7 +510,7 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 	 * If we are invalidating the entire page, clear the dirty state from it
 	 * and release it to avoid unnecessary buildup of the LRU.
 	 */
-	if (offset == 0 && len == PAGE_SIZE) {
+	if (offset == 0 && len == thp_size(page)) {
 		WARN_ON_ONCE(PageWriteback(page));
 		cancel_dirty_page(page);
 		iomap_page_release(page);
@@ -586,7 +586,9 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	loff_t block_size = i_blocksize(inode);
 	loff_t block_start = pos & ~(block_size - 1);
 	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
-	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
+	unsigned from = offset_in_thp(page, pos);
+	unsigned to = from + len;
+	unsigned poff, plen;
 	int status;
 
 	if (PageUptodate(page))
@@ -718,7 +720,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	 */
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
-	iomap_set_range_uptodate(page, offset_in_page(pos), len);
+	iomap_set_range_uptodate(page, offset_in_thp(page, pos), len);
 	iomap_set_page_dirty(page);
 	return copied;
 }
@@ -793,6 +795,10 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
 
+		/*
+		 * XXX: We don't know what size page we'll find in the
+		 * page cache, so only copy up to a regular page boundary.
+		 */
 		offset = offset_in_page(pos);
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
 						iov_iter_count(i));
@@ -1335,7 +1341,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 {
 	sector_t sector = iomap_sector(&wpc->iomap, offset);
 	unsigned len = i_blocksize(inode);
-	unsigned poff = offset & (PAGE_SIZE - 1);
+	unsigned poff = offset & (thp_size(page) - 1);
 	bool merged, same_page = false;
 
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
@@ -1385,11 +1391,12 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	struct iomap_page *iop = to_iomap_page(page);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
-	u64 file_offset; /* file offset of page */
+	loff_t pos;
 	int error = 0, count = 0, i;
+	int nr_blocks = i_blocks_per_page(inode, page);
 	LIST_HEAD(submit_list);
 
-	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
+	WARN_ON_ONCE(nr_blocks > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
 
 	/*
@@ -1397,20 +1404,20 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * end of the current map or find the current map invalid, grab a new
 	 * one.
 	 */
-	for (i = 0, file_offset = page_offset(page);
-	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
-	     i++, file_offset += len) {
+	for (i = 0, pos = page_offset(page);
+	     i < nr_blocks && pos < end_offset;
+	     i++, pos += len) {
 		if (iop && !test_bit(i, iop->uptodate))
 			continue;
 
-		error = wpc->ops->map_blocks(wpc, inode, file_offset);
+		error = wpc->ops->map_blocks(wpc, inode, pos);
 		if (error)
 			break;
 		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
 			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
-		iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
+		iomap_add_to_ioend(inode, pos, page, iop, wpc, wbc,
 				 &submit_list);
 		count++;
 	}
@@ -1492,7 +1499,6 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 {
 	struct iomap_writepage_ctx *wpc = data;
 	struct inode *inode = page->mapping->host;
-	pgoff_t end_index;
 	u64 end_offset;
 	loff_t offset;
 
@@ -1533,10 +1539,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 	 * ---------------------------------^------------------|
 	 */
 	offset = i_size_read(inode);
-	end_index = offset >> PAGE_SHIFT;
-	if (page->index < end_index)
-		end_offset = (loff_t)(page->index + 1) << PAGE_SHIFT;
-	else {
+	end_offset = page_offset(page) + thp_size(page);
+	if (end_offset > offset) {
 		/*
 		 * Check whether the page to write out is beyond or straddles
 		 * i_size or not.
@@ -1548,7 +1552,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * |				    |      Straddles     |
 		 * ---------------------------------^-----------|--------|
 		 */
-		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
+		unsigned offset_into_page = offset_in_thp(page, offset);
+		pgoff_t end_index = offset >> PAGE_SHIFT;
 
 		/*
 		 * Skip the page if it is fully outside i_size, e.g. due to a
@@ -1579,7 +1584,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * memory is zeroed when mapped, and writes to that region are
 		 * not written out to the file."
 		 */
-		zero_user_segment(page, offset_into_page, PAGE_SIZE);
+		zero_user_segment(page, offset_into_page, thp_size(page));
 
 		/* Adjust the end_offset to the end of file */
 		end_offset = offset;
-- 
2.26.2

