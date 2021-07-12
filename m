Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22E23C4289
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhGLEFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhGLEFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:05:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A88C0613DD;
        Sun, 11 Jul 2021 21:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SK8yOeE/lbjT6+xJu7l9snuSsax4aIwbWKZSevIDweo=; b=HiBVX/K/Q+nuyifSksFrhZoQSz
        dfy3g3QMogXAICAXeDV+HQBzPJURNLfaTEbuS2M34uDxQu8THDx+S/mvTsXtTGAMNxHK9eN62M5qa
        nPX1uCwAQ/syjaLtB2IMdEh5PiaQeltzo48Vo/kP1+gTBkN2j3CgUE6BX0TuWrrsrVxzVDNyEnXur
        JKls9YjSXolAJCQ/UUpP9zoKjRBeIGa1rONJi5T5egRKDctiMAJBSChwk470585BQFSnmv9yO6ouX
        a0MC6drw7KjQOJ9+VuRU/mLBhmrsTOPT6NItk7/ifJ4SwLTHHUM3zghk/mHBKLQoLB5xgMVOQ8q7q
        E9fKFsXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2n8a-00Gqcz-SG; Mon, 12 Jul 2021 04:01:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 105/137] iomap: Convert iomap_do_writepage to use a folio
Date:   Mon, 12 Jul 2021 04:06:29 +0100
Message-Id: <20210712030701.4000097-106-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Writeback an entire folio at a time, and adjust some of the variables
to have more familiar names.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 49 +++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5b6a3e675101..c2736f36db76 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1296,9 +1296,8 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 static int
 iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
-		struct page *page, u64 end_offset)
+		struct folio *folio, loff_t end_pos)
 {
-	struct folio *folio = page_folio(page);
 	struct iomap_page *iop = to_iomap_page(folio);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
@@ -1316,7 +1315,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks; i++, pos += len) {
-		if (pos >= end_offset)
+		if (pos >= end_pos)
 			break;
 		if (iop && !test_bit(i, iop->uptodate))
 			continue;
@@ -1398,16 +1397,15 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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
-	 * Refuse to write the page out if we are called from reclaim context.
+	 * Refuse to write the folio out if we are called from reclaim context.
 	 *
 	 * This avoids stack overflows when called from deeply used stacks in
 	 * random callers for direct reclaim or memcg reclaim.  We explicitly
@@ -1421,10 +1419,10 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
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
@@ -1433,11 +1431,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
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
@@ -1449,7 +1445,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * |				    |      Straddles     |
 		 * ---------------------------------^-----------|--------|
 		 */
-		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
+		size_t poff = offset_in_folio(folio, isize);
+		pgoff_t end_index = isize >> PAGE_SHIFT;
 
 		/*
 		 * Skip the page if it is fully outside i_size, e.g. due to a
@@ -1468,8 +1465,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * if the page to write is totally beyond the i_size or if it's
 		 * offset is just equal to the EOF.
 		 */
-		if (page->index > end_index ||
-		    (page->index == end_index && offset_into_page == 0))
+		if (folio->index > end_index ||
+		    (folio->index == end_index && poff == 0))
 			goto redirty;
 
 		/*
@@ -1480,17 +1477,15 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
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
2.30.2

