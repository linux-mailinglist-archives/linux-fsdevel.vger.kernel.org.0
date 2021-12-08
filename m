Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1646CC7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbhLHE25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbhLHE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D889C0698CE
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ywFxKMKzhbL8Q2M7esNnlvljBPXvITK4YoC9wi4Run8=; b=RI1CigpKup6foGd3wx015ayzus
        GnsmYsy+7LOThknpVPelSoX3PQgtjZvWY7JCdAqwrMRIPMC4knDtL7caU1nIPidrbzHa+O4ncd0xF
        7ag6DrH2iwlAL0ZpyC5KPmJBW476Lq722GMDImeWhjrE7f/+/wbMAiREJtTmdMw/hzXTpcr5U4es2
        7L1GtQFyBTJRDhrnIf3++LVfnKwwRuEBRqiJsMHwws59gpkiqHuM5XLktFCusOMnlL8C52z5YdqYW
        kK35ZBii/ZtaGYReJQqWWRDSa07diwp5nXWlAhnr+7TWdD0Ib0PKZA7ekluNp698ouBPGS11OuTHy
        4DK/TvvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU5-0084aE-PY; Wed, 08 Dec 2021 04:23:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 32/48] truncate: Add truncate_cleanup_folio()
Date:   Wed,  8 Dec 2021 04:22:40 +0000
Message-Id: <20211208042256.1923824-33-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert both callers of truncate_cleanup_page() to use
truncate_cleanup_folio() instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index cc83a3f7c1ad..ab86b07c1e9c 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -177,21 +177,21 @@ void do_invalidatepage(struct page *page, unsigned int offset,
  * its lock, b) when a concurrent invalidate_mapping_pages got there first and
  * c) when tmpfs swizzles a page between a tmpfs inode and swapper_space.
  */
-static void truncate_cleanup_page(struct page *page)
+static void truncate_cleanup_folio(struct folio *folio)
 {
-	if (page_mapped(page))
-		unmap_mapping_page(page);
+	if (folio_mapped(folio))
+		unmap_mapping_page(&folio->page);
 
-	if (page_has_private(page))
-		do_invalidatepage(page, 0, thp_size(page));
+	if (folio_has_private(folio))
+		do_invalidatepage(&folio->page, 0, folio_size(folio));
 
 	/*
 	 * Some filesystems seem to re-dirty the page even after
 	 * the VM has canceled the dirty bit (eg ext3 journaling).
 	 * Hence dirty accounting check is placed after invalidation.
 	 */
-	cancel_dirty_page(page);
-	ClearPageMappedToDisk(page);
+	folio_cancel_dirty(folio);
+	folio_clear_mappedtodisk(folio);
 }
 
 /*
@@ -220,13 +220,14 @@ invalidate_complete_page(struct address_space *mapping, struct page *page)
 
 int truncate_inode_page(struct address_space *mapping, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
 	if (page->mapping != mapping)
 		return -EIO;
 
-	truncate_cleanup_page(page);
-	delete_from_page_cache(page);
+	truncate_cleanup_folio(folio);
+	filemap_remove_folio(folio);
 	return 0;
 }
 
@@ -332,7 +333,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		index = indices[pagevec_count(&pvec) - 1] + 1;
 		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
 		for (i = 0; i < pagevec_count(&pvec); i++)
-			truncate_cleanup_page(pvec.pages[i]);
+			truncate_cleanup_folio(page_folio(pvec.pages[i]));
 		delete_from_page_cache_batch(mapping, &pvec);
 		for (i = 0; i < pagevec_count(&pvec); i++)
 			unlock_page(pvec.pages[i]);
-- 
2.33.0

