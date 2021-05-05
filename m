Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4B53747AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 20:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhEESBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 14:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbhEESBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 14:01:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516F5C0612B1;
        Wed,  5 May 2021 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GoWNWzBBq6+8thZPTfyvM1uVttt68WlD6Sz8J/pM0fU=; b=DyHoyNHd3z5LqQgnPtPPv8+3tR
        jJdqeBmJg540V1XXfNm/UU9uPqGqhYr/zQIuQ3iQXsnzipi0fNxtpFWo+67RoEQZ/uJEoj2+06pmQ
        MbpxbiqdsXbNoK8EV5WT4sMgAyfEIEzwC3wTsQLnCs2e8dafxFIV6F1UHhGGpm0UGVBPQZm2ULK99
        ZWdPxND0aLNVhkwSHvmDDyIRRZUaIL48JtBfu2/oxdKZf7eSBaSM2XWkipEcChI2/xxQ99TH3N+hw
        5dR8P5PCpC/KwFtmNWN1HoN3GCmeSSoBPLij8t0zO2kD9TlyWEAVi8crVm16pF5MADtmUhkfl1UIU
        sISSjdxw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leLRJ-000f1a-62; Wed, 05 May 2021 17:37:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 96/96] iomap: Convert iomap_do_writepage to use a folio
Date:   Wed,  5 May 2021 16:06:28 +0100
Message-Id: <20210505150628.111735-97-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index 4ea256de9d04..2dfeb7fa5f03 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1301,9 +1301,8 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
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
@@ -1321,7 +1320,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks; i++, pos += len) {
-		if (pos >= end_offset)
+		if (pos >= end_pos)
 			break;
 		if (iop && !test_bit(i, iop->uptodate))
 			continue;
@@ -1403,16 +1402,15 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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
+	trace_iomap_writepage(inode, folio_offset(folio), folio_size(folio));
 
 	/*
-	 * Refuse to write the page out if we are called from reclaim context.
+	 * Refuse to write the folio out if we are called from reclaim context.
 	 *
 	 * This avoids stack overflows when called from deeply used stacks in
 	 * random callers for direct reclaim or memcg reclaim.  We explicitly
@@ -1426,10 +1424,10 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
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
@@ -1438,11 +1436,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 	 * |     desired writeback range    |      see else    |
 	 * ---------------------------------^------------------|
 	 */
-	offset = i_size_read(inode);
-	end_index = offset >> PAGE_SHIFT;
-	if (page->index < end_index)
-		end_offset = (loff_t)(page->index + 1) << PAGE_SHIFT;
-	else {
+	isize = i_size_read(inode);
+	end_pos = folio_offset(folio) + folio_size(folio);
+	if (end_pos - 1 >= isize) {
 		/*
 		 * Check whether the page to write out is beyond or straddles
 		 * i_size or not.
@@ -1454,7 +1450,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * |				    |      Straddles     |
 		 * ---------------------------------^-----------|--------|
 		 */
-		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
+		size_t poff = offset_in_folio(folio, isize);
+		pgoff_t end_index = isize >> PAGE_SHIFT;
 
 		/*
 		 * Skip the page if it is fully outside i_size, e.g. due to a
@@ -1473,8 +1470,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * if the page to write is totally beyond the i_size or if it's
 		 * offset is just equal to the EOF.
 		 */
-		if (page->index > end_index ||
-		    (page->index == end_index && offset_into_page == 0))
+		if (folio->index > end_index ||
+		    (folio->index == end_index && poff == 0))
 			goto redirty;
 
 		/*
@@ -1485,17 +1482,15 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
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

