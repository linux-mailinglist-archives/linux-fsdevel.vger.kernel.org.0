Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C0044229E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 22:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhKAV2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 17:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhKAV2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:28:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5F3C061714;
        Mon,  1 Nov 2021 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=C8svQXKQLi0+j8wvHwJ0C+5oXPlUxCJ2MNLhLP1HM2I=; b=TaQWhXjpskKJKOhWX38qa+sSNM
        l/vhFOnu2bv59dMj8VTMjkgGPUrt5zS5mSnzeSBwArz01BOSEQCYmYoX2MwBRjEStVKWh4AwtpkKa
        ZCAI6BZOpvBHnuR4y0HmW/puZ2Hr1+buVcMEK/s3SYYaR5lAqWNtvuKSlIq1NsHg4eULy4n2VM77D
        1TEVhFInakoKlS/+NArZqZ4+ER220xEOnvXikbo0isAPeQcOhsnqTIz9aR0/HUXr6TUZrmj9vE+M5
        pHltmxBKXpHYZmnL6+2PyCj1fBwIDyWAOxdjVB0HcstZOm8ygL7yGw8lR/vT5sKCH+uWCy9aYANYw
        5h1O4RaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mheYi-0041xh-RX; Mon, 01 Nov 2021 21:10:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 18/21] iomap: Convert iomap_add_to_ioend to take a folio
Date:   Mon,  1 Nov 2021 20:39:26 +0000
Message-Id: <20211101203929.954622-19-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We still iterate one block at a time, but now we call compound_head()
less often.  Rename file_offset to pos to fit the rest of the file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 100 +++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 53 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c50ae76835ca..2436933dfe42 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1252,29 +1252,29 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
  * first; otherwise finish off the current ioend and start another.
  */
 static void
-iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
+iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 		struct iomap_page *iop, struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct list_head *iolist)
 {
-	sector_t sector = iomap_sector(&wpc->iomap, offset);
+	sector_t sector = iomap_sector(&wpc->iomap, pos);
 	unsigned len = i_blocksize(inode);
-	unsigned poff = offset & (PAGE_SIZE - 1);
+	size_t poff = offset_in_folio(folio, pos);
 
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
+	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, sector)) {
 		if (wpc->ioend)
 			list_add(&wpc->ioend->io_list, iolist);
-		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
+		wpc->ioend = iomap_alloc_ioend(inode, wpc, pos, sector, wbc);
 	}
 
-	if (bio_add_page(wpc->ioend->io_bio, page, len, poff) != len) {
+	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
 		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
-		__bio_add_page(wpc->ioend->io_bio, page, len, poff);
+		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
 	}
 
 	if (iop)
 		atomic_add(len, &iop->write_bytes_pending);
 	wpc->ioend->io_size += len;
-	wbc_account_cgroup_owner(wbc, page, len);
+	wbc_account_cgroup_owner(wbc, &folio->page, len);
 }
 
 /*
@@ -1296,45 +1296,43 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 static int
 iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
-		struct page *page, u64 end_offset)
+		struct folio *folio, loff_t end_pos)
 {
-	struct folio *folio = page_folio(page);
 	struct iomap_page *iop = iomap_page_create(inode, folio);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
-	u64 file_offset; /* file offset of page */
+	unsigned nblocks = i_blocks_per_folio(inode, folio);
+	loff_t pos = folio_pos(folio);
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
 
 	/*
-	 * Walk through the page to find areas to write back. If we run off the
-	 * end of the current map or find the current map invalid, grab a new
-	 * one.
+	 * Walk through the folio to find areas to write back. If we
+	 * run off the end of the current map or find the current map
+	 * invalid, grab a new one.
 	 */
-	for (i = 0, file_offset = page_offset(page);
-	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
-	     i++, file_offset += len) {
+	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
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
+		iomap_add_to_ioend(inode, pos, folio, iop, wpc, wbc,
 				 &submit_list);
 		count++;
 	}
 
 	WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
-	WARN_ON_ONCE(!PageLocked(page));
-	WARN_ON_ONCE(PageWriteback(page));
-	WARN_ON_ONCE(PageDirty(page));
+	WARN_ON_ONCE(!folio_test_locked(folio));
+	WARN_ON_ONCE(folio_test_writeback(folio));
+	WARN_ON_ONCE(folio_test_dirty(folio));
 
 	/*
 	 * We cannot cancel the ioend directly here on error.  We may have
@@ -1350,16 +1348,16 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		 * now.
 		 */
 		if (wpc->ops->discard_folio)
-			wpc->ops->discard_folio(page_folio(page), file_offset);
+			wpc->ops->discard_folio(folio, pos);
 		if (!count) {
-			ClearPageUptodate(page);
-			unlock_page(page);
+			folio_clear_uptodate(folio);
+			folio_unlock(folio);
 			goto done;
 		}
 	}
 
-	set_page_writeback(page);
-	unlock_page(page);
+	folio_start_writeback(folio);
+	folio_unlock(folio);
 
 	/*
 	 * Preserve the original error if there was one; catch
@@ -1380,9 +1378,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * with a partial page truncate on a sub-page block sized filesystem.
 	 */
 	if (!count)
-		end_page_writeback(page);
+		folio_end_writeback(folio);
 done:
-	mapping_set_error(page->mapping, error);
+	mapping_set_error(folio->mapping, error);
 	return error;
 }
 
@@ -1396,16 +1394,15 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 static int
 iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 {
+	struct folio *folio = page_folio(page);
 	struct iomap_writepage_ctx *wpc = data;
-	struct inode *inode = page->mapping->host;
-	pgoff_t end_index;
-	u64 end_offset;
-	loff_t offset;
+	struct inode *inode = folio->mapping->host;
+	loff_t end_pos, isize;
 
-	trace_iomap_writepage(inode, page_offset(page), PAGE_SIZE);
+	trace_iomap_writepage(inode, folio_pos(folio), folio_size(folio));
 
 	/*
-	 * Refuse to write the page out if we're called from reclaim context.
+	 * Refuse to write the folio out if we're called from reclaim context.
 	 *
 	 * This avoids stack overflows when called from deeply used stacks in
 	 * random callers for direct reclaim or memcg reclaim.  We explicitly
@@ -1419,10 +1416,10 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		goto redirty;
 
 	/*
-	 * Is this page beyond the end of the file?
+	 * Is this folio beyond the end of the file?
 	 *
-	 * The page index is less than the end_index, adjust the end_offset
-	 * to the highest offset that this page should represent.
+	 * The folio index is less than the end_index, adjust the end_pos
+	 * to the highest offset that this folio should represent.
 	 * -----------------------------------------------------
 	 * |			file mapping	       | <EOF> |
 	 * -----------------------------------------------------
@@ -1431,11 +1428,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 	 * |     desired writeback range    |      see else    |
 	 * ---------------------------------^------------------|
 	 */
-	offset = i_size_read(inode);
-	end_index = offset >> PAGE_SHIFT;
-	if (page->index < end_index)
-		end_offset = (loff_t)(page->index + 1) << PAGE_SHIFT;
-	else {
+	isize = i_size_read(inode);
+	end_pos = folio_pos(folio) + folio_size(folio);
+	if (end_pos - 1 >= isize) {
 		/*
 		 * Check whether the page to write out is beyond or straddles
 		 * i_size or not.
@@ -1447,7 +1442,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * |				    |      Straddles     |
 		 * ---------------------------------^-----------|--------|
 		 */
-		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
+		size_t poff = offset_in_folio(folio, isize);
+		pgoff_t end_index = isize >> PAGE_SHIFT;
 
 		/*
 		 * Skip the page if it's fully outside i_size, e.g. due to a
@@ -1466,8 +1462,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * checking if the page is totally beyond i_size or if its
 		 * offset is just equal to the EOF.
 		 */
-		if (page->index > end_index ||
-		    (page->index == end_index && offset_into_page == 0))
+		if (folio->index > end_index ||
+		    (folio->index == end_index && poff == 0))
 			goto redirty;
 
 		/*
@@ -1478,17 +1474,15 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * memory is zeroed when mapped, and writes to that region are
 		 * not written out to the file."
 		 */
-		zero_user_segment(page, offset_into_page, PAGE_SIZE);
-
-		/* Adjust the end_offset to the end of file */
-		end_offset = offset;
+		zero_user_segment(&folio->page, poff, folio_size(folio));
+		end_pos = isize;
 	}
 
-	return iomap_writepage_map(wpc, wbc, inode, page, end_offset);
+	return iomap_writepage_map(wpc, wbc, inode, folio, end_pos);
 
 redirty:
-	redirty_page_for_writepage(wbc, page);
-	unlock_page(page);
+	folio_redirty_for_writepage(wbc, folio);
+	folio_unlock(folio);
 	return 0;
 }
 
-- 
2.33.0

