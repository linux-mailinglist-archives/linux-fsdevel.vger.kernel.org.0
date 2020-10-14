Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1145828DDA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJNJa0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730103AbgJNJTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85117C0F26F2;
        Tue, 13 Oct 2020 20:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4CizuPWSROnWzpNyUK4VUnX0ZFhzuX47JJGzIGersuE=; b=vj5QlohI/1Ko5rtIubd+FWW2Ud
        Y75jzewv2TNpOe0TCvDblxbt2bnQLFPAZuwheWl+QEvi8MNl3qPD3/Q0pDcvQ9LJzWqBnOwNmcVjA
        NmhHMZe7gGracSc7SgU1GumvEP0xT7VLtQ/GaGRmCjHLQfBCJbpQzka4p+SRrqYU0cs5nxnWe8ZhR
        7TBes0NRdTe1L47Vz/sKIPGoD39z0TgNHf4AQoIjCjDSsMuoXlL6Sk2w0COX0zbT9nWAx4IcqFmOv
        nhGJOVByRL71PxP/HcOiIy46v3geKyhSy+tB1jLXdyKFTW9ZIs/+UtLvJtOzqMx4PwdlbkMbGKVro
        rq6GaoLw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSX58-0005jH-21; Wed, 14 Oct 2020 03:04:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 11/14] iomap: Support THP writeback
Date:   Wed, 14 Oct 2020 04:03:54 +0100
Message-Id: <20201014030357.21898-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201014030357.21898-1-willy@infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use offset_in_thp() and similar helpers to submit THPs for writeback.
This simplifies the logic in iomap_do_writepage() around handling the
end of the file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0a1fe7d1a27c..38fd69ebd4cc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1394,7 +1394,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 {
 	sector_t sector = iomap_sector(&wpc->iomap, offset);
 	unsigned len = i_blocksize(inode);
-	unsigned poff = offset & (PAGE_SIZE - 1);
+	unsigned poff = offset_in_thp(page, offset);
 	bool merged, same_page = false;
 
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
@@ -1444,8 +1444,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	struct iomap_page *iop = iomap_page_create(inode, page);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
-	u64 file_offset; /* file offset of page */
+	loff_t pos;
 	int error = 0, count = 0, i;
+	int nr_blocks = i_blocks_per_page(inode, page);
 	LIST_HEAD(submit_list);
 
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
@@ -1455,20 +1456,20 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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
@@ -1549,11 +1550,11 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 {
 	struct iomap_writepage_ctx *wpc = data;
 	struct inode *inode = page->mapping->host;
-	pgoff_t end_index;
 	u64 end_offset;
 	loff_t offset;
 
-	trace_iomap_writepage(inode, page_offset(page), PAGE_SIZE);
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	trace_iomap_writepage(inode, page_offset(page), thp_size(page));
 
 	/*
 	 * Refuse to write the page out if we are called from reclaim context.
@@ -1590,10 +1591,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
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
@@ -1605,7 +1604,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * |				    |      Straddles     |
 		 * ---------------------------------^-----------|--------|
 		 */
-		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
+		unsigned offset_into_page = offset_in_thp(page, offset);
+		pgoff_t end_index = offset >> PAGE_SHIFT;
 
 		/*
 		 * Skip the page if it is fully outside i_size, e.g. due to a
@@ -1636,7 +1636,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * memory is zeroed when mapped, and writes to that region are
 		 * not written out to the file."
 		 */
-		zero_user_segment(page, offset_into_page, PAGE_SIZE);
+		zero_user_segment(page, offset_into_page, thp_size(page));
 
 		/* Adjust the end_offset to the end of file */
 		end_offset = offset;
-- 
2.28.0

