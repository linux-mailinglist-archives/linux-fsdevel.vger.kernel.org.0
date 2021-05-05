Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD863747AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 20:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhEESBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 14:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbhEESBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 14:01:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5EEC04BE52;
        Wed,  5 May 2021 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=x6J2sWeAKNcs8Pb+1O/Qe6Ze54/g0lXljFCqyHrvbbQ=; b=ZlsRc5Pa3qkTHSqnI4f0kdJxnx
        AOlG4IV7W6/C6lqRzBRordiA7aHom4vwquYZwiLRxk3Cewk41vkLYfiPY8KXUGnxmqs2E+Q3swxK7
        tTXqfC51JwNvb8eMrnA09Ce3hA958fzpisSBKTk2lCu7k9XcLO8u1xFo1nOpQey0H6Ktc6vqfzSqT
        PUBO/ZlmG+cyojI/K4oZcipdHB/5CaojYHEeBhzTHqPE+OGgetV+mQ55tJhR9meW2VIGzYlAckwXU
        n1Akl2Qa8TaatWkeeAk4MYVSAOQ+yXAgV9aymxqdlqXa+lZSLlgZIywWz9c5Olni5P6Fw8xBGsNTk
        f7ZcQ18g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leLOk-000elt-NN; Wed, 05 May 2021 17:34:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 95/96] iomap: Convert iomap_add_to_ioend to take a folio
Date:   Wed,  5 May 2021 16:06:27 +0100
Message-Id: <20210505150628.111735-96-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We still iterate one block at a time, but now we call compound_head()
less often.  Rename file_offset to pos to fit the rest of the file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 66 +++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 40934c624f11..4ea256de9d04 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1257,36 +1257,29 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
  * first, otherwise finish off the current ioend and start another.
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
-	bool merged, same_page = false;
+	size_t poff = offset_in_folio(folio, pos);
 
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
+	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, sector)) {
 		if (wpc->ioend)
 			list_add(&wpc->ioend->io_list, iolist);
-		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
+		wpc->ioend = iomap_alloc_ioend(inode, wpc, pos, sector, wbc);
 	}
 
-	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
-			&same_page);
 	if (iop)
 		atomic_add(len, &iop->write_bytes_pending);
-
-	if (!merged) {
-		if (bio_full(wpc->ioend->io_bio, len)) {
-			wpc->ioend->io_bio =
-				iomap_chain_bio(wpc->ioend->io_bio);
-		}
-		bio_add_page(wpc->ioend->io_bio, page, len, poff);
+	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
+		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
+		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
 	}
 
 	wpc->ioend->io_size += len;
-	wbc_account_cgroup_owner(wbc, page, len);
+	wbc_account_cgroup_owner(wbc, &folio->page, len);
 }
 
 /*
@@ -1314,40 +1307,41 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	struct iomap_page *iop = to_iomap_page(folio);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
-	u64 file_offset; /* file offset of page */
+	unsigned nblocks = i_blocks_per_folio(inode, folio);
+	loff_t pos = folio_offset(folio);
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
-	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
+	WARN_ON_ONCE(nblocks > 1 && !iop);
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
+	for (i = 0; i < nblocks; i++, pos += len) {
+		if (pos >= end_offset)
+			break;
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
+	WARN_ON_ONCE(!folio_locked(folio));
+	WARN_ON_ONCE(folio_writeback(folio));
+	WARN_ON_ONCE(folio_dirty(folio));
 
 	/*
 	 * We cannot cancel the ioend directly here on error.  We may have
@@ -1363,16 +1357,16 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		 * now.
 		 */
 		if (wpc->ops->discard_page)
-			wpc->ops->discard_page(page, file_offset);
+			wpc->ops->discard_page(&folio->page, pos);
 		if (!count) {
-			ClearPageUptodate(page);
-			unlock_page(page);
+			folio_clear_uptodate_flag(folio);
+			folio_unlock(folio);
 			goto done;
 		}
 	}
 
-	set_page_writeback(page);
-	unlock_page(page);
+	folio_start_writeback(folio);
+	folio_unlock(folio);
 
 	/*
 	 * Preserve the original error if there was one, otherwise catch
@@ -1393,9 +1387,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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
 
-- 
2.30.2

