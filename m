Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62591E730C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407514AbgE2C6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 22:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391650AbgE2C6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2896C08C5CA;
        Thu, 28 May 2020 19:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=glzxVsAoxKq6bd/zLmDNmP27xxlauvpDAIZHd/7Oh6E=; b=IsqAQ9rEwMS4q/7fzeNo7ovVxc
        cq2R/pYRZ6i0HnNyQbrNRz4ufQZxg2aEcFrp9JAFNxIh9k2A0gNb5BOZALuse3APNWwKFpJuvl+W9
        OnX7uJIh5G21nayjvhPanPcrEoM/BDkDuZDbfXeLxbYA0oAZBBkF17hYQOx2UN2NR/xF6JoSzgdQc
        3O4iFDNddjEQdTJFGfKneRn98TMxT+ACLtaYy9P/21frcFffL8acPMwXXb0CaQstCMJLoJ4ECfM5H
        07RsA9AqME2XGfKHZDH9aDyPYw0A+VjvLdYK3OiHB/3Hj/8VZVAvdlmnin1QVKeyzjffCe4sN1kKU
        u6gvPQAg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008RV-70; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/39] iomap: Support large pages in write paths
Date:   Thu, 28 May 2020 19:58:02 -0700
Message-Id: <20200529025824.32296-18-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
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
 fs/iomap/buffered-io.c | 50 +++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bd70b7c1efd0..8767241ae535 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -466,7 +466,7 @@ iomap_is_partially_uptodate(struct page *page, unsigned long from,
 	unsigned i;
 
 	/* Limit range to one page */
-	len = min_t(unsigned, PAGE_SIZE - from, count);
+	len = min_t(unsigned, thp_size(page) - from, count);
 
 	/* First and last blocks in range within page */
 	first = from >> inode->i_blkbits;
@@ -590,7 +590,9 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	loff_t block_size = i_blocksize(inode);
 	loff_t block_start = pos & ~(block_size - 1);
 	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
-	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
+	unsigned from = offset_in_thp(page, pos);
+	unsigned to = from + len;
+	unsigned poff, plen;
 	int status;
 
 	if (PageUptodate(page))
@@ -658,8 +660,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
-		status = __iomap_write_begin(inode, pos, len, flags, page,
-				srcmap);
+		status = __iomap_write_begin(inode, pos, len, flags,
+				compound_head(page), srcmap);
 
 	if (unlikely(status))
 		goto out_unlock;
@@ -722,7 +724,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	 */
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
-	iomap_set_range_uptodate(page, offset_in_page(pos), len);
+	iomap_set_range_uptodate(page, offset_in_thp(page, pos), len);
 	iomap_set_page_dirty(page);
 	return copied;
 }
@@ -758,7 +760,8 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len, unsigned copied,
 		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
 				page, NULL);
 	} else {
-		ret = __iomap_write_end(inode, pos, len, copied, page);
+		ret = __iomap_write_end(inode, pos, len, copied,
+				compound_head(page));
 	}
 
 	/*
@@ -797,6 +800,10 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
 
+		/*
+		 * XXX: We don't know what size page we'll find in the
+		 * page cache, so only copy up to a regular page boundary.
+		 */
 		offset = offset_in_page(pos);
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
 						iov_iter_count(i));
@@ -1133,7 +1140,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 			next = bio->bi_private;
 
 		/* walk each page on bio, ending page IO on them */
-		bio_for_each_segment_all(bv, bio, iter_all)
+		bio_for_each_thp_segment_all(bv, bio, iter_all)
 			iomap_finish_page_writeback(inode, bv->bv_page, error);
 		bio_put(bio);
 	}
@@ -1339,7 +1346,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 {
 	sector_t sector = iomap_sector(&wpc->iomap, offset);
 	unsigned len = i_blocksize(inode);
-	unsigned poff = offset & (PAGE_SIZE - 1);
+	unsigned poff = offset & (thp_size(page) - 1);
 	bool merged, same_page = false;
 
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
@@ -1389,11 +1396,12 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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
@@ -1401,20 +1409,20 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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
@@ -1496,7 +1504,6 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 {
 	struct iomap_writepage_ctx *wpc = data;
 	struct inode *inode = page->mapping->host;
-	pgoff_t end_index;
 	u64 end_offset;
 	loff_t offset;
 
@@ -1537,10 +1544,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
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
@@ -1552,7 +1557,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * |				    |      Straddles     |
 		 * ---------------------------------^-----------|--------|
 		 */
-		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
+		unsigned offset_into_page = offset_in_thp(page, offset);
+		pgoff_t end_index = offset >> PAGE_SHIFT;
 
 		/*
 		 * Skip the page if it is fully outside i_size, e.g. due to a
@@ -1583,7 +1589,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * memory is zeroed when mapped, and writes to that region are
 		 * not written out to the file."
 		 */
-		zero_user_segment(page, offset_into_page, PAGE_SIZE);
+		zero_user_segment(page, offset_into_page, thp_size(page));
 
 		/* Adjust the end_offset to the end of file */
 		end_offset = offset;
-- 
2.26.2

