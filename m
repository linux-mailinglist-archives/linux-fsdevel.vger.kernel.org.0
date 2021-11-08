Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94094479C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 06:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhKHFJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 00:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhKHFJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 00:09:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71DCC061570;
        Sun,  7 Nov 2021 21:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3aaCDVfG47oywaemBl2GN9Mv/+JwqTsxtdXzUkzFH+g=; b=POs0LgCPGPLUDA9UFRZT1xYv53
        D0GAmtyy5Djl/wLP1CRN6SQYXNCxxizb8aqGx32mr+S4CT4XbJENrngTUpFlnTTei6895dsBCdb4e
        rLRHy2SvE3D/Tm037cGs8D+iQdbCcc2nmWN+okGRna9Aw66zl12M7PbxULpzBxX9HTaIDQBVfXrKE
        CKEXXzwhl27y3pAvtw4Wanpa5K9HaEnZNaixq40mYmm21xD7VVHKnQ5fGVTQ0KMQvtLl/X6CqHUER
        ce3V2lcOx9gFuQna6r33ncUTKH52IzVSDJk75+OR1HAKul4KS9ZJr8goAaDa9Vk5wO9WB8qiY82jZ
        Qo2H1AHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwp4-008Aqa-4Y; Mon, 08 Nov 2021 05:04:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 25/28] iomap: Convert iomap_add_to_ioend() to take a folio
Date:   Mon,  8 Nov 2021 04:05:48 +0000
Message-Id: <20211108040551.1942823-26-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We still iterate one block at a time, but now we call compound_head()
less often.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 70 ++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b168cc0fe8be..90f9f33ffe41 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1249,29 +1249,29 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
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
@@ -1293,9 +1293,8 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 static int
 iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
-		struct page *page, u64 end_pos)
+		struct folio *folio, u64 end_pos)
 {
-	struct folio *folio = page_folio(page);
 	struct iomap_page *iop = iomap_page_create(inode, folio);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
@@ -1322,15 +1321,15 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
-		iomap_add_to_ioend(inode, pos, page, iop, wpc, wbc,
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
@@ -1348,14 +1347,14 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		if (wpc->ops->discard_folio)
 			wpc->ops->discard_folio(folio, pos);
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
@@ -1376,9 +1375,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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
 
@@ -1392,14 +1391,15 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 static int
 iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 {
+	struct folio *folio = page_folio(page);
 	struct iomap_writepage_ctx *wpc = data;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	u64 end_pos, isize;
 
-	trace_iomap_writepage(inode, page_offset(page), PAGE_SIZE);
+	trace_iomap_writepage(inode, folio_pos(folio), folio_size(folio));
 
 	/*
-	 * Refuse to write the page out if we're called from reclaim context.
+	 * Refuse to write the folio out if we're called from reclaim context.
 	 *
 	 * This avoids stack overflows when called from deeply used stacks in
 	 * random callers for direct reclaim or memcg reclaim.  We explicitly
@@ -1413,10 +1413,10 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
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
@@ -1426,7 +1426,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 	 * ---------------------------------^------------------|
 	 */
 	isize = i_size_read(inode);
-	end_pos = page_offset(page) + PAGE_SIZE;
+	end_pos = folio_pos(folio) + folio_size(folio);
 	if (end_pos > isize) {
 		/*
 		 * Check whether the page to write out is beyond or straddles
@@ -1439,7 +1439,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * |				    |      Straddles     |
 		 * ---------------------------------^-----------|--------|
 		 */
-		size_t poff = offset_in_page(isize);
+		size_t poff = offset_in_folio(folio, isize);
 		pgoff_t end_index = isize >> PAGE_SHIFT;
 
 		/*
@@ -1459,8 +1459,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * checking if the page is totally beyond i_size or if its
 		 * offset is just equal to the EOF.
 		 */
-		if (page->index > end_index ||
-		    (page->index == end_index && poff == 0))
+		if (folio->index > end_index ||
+		    (folio->index == end_index && poff == 0))
 			goto redirty;
 
 		/*
@@ -1471,17 +1471,15 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * memory is zeroed when mapped, and writes to that region are
 		 * not written out to the file."
 		 */
-		zero_user_segment(page, poff, PAGE_SIZE);
-
-		/* Adjust the end_offset to the end of file */
+		folio_zero_segment(folio, poff, folio_size(folio));
 		end_pos = isize;
 	}
 
-	return iomap_writepage_map(wpc, wbc, inode, page, end_pos);
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

