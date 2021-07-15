Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B986B3C9853
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbhGOF0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOF0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:26:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B44C06175F;
        Wed, 14 Jul 2021 22:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QEEI1dbEoDD8GArjWkq2Z6EQLrcEX4Lhox3YGo6XvTs=; b=QeuiV/0mnHEiaSLCAALqI+FG00
        LlhMEl6fDkOIc0i+gjVa3C/V4irQuK5E4PnGmaqXpFaDbC9LCLU64dCEe51olZrAHoSLso+ZGLdaN
        5WbAXhTcjZxUuFKFbgp8XQtp5Ccy+K6hmR/Tzua21VTmcAyRYNii7l9By/+YZxoAdzdvr1BZMYWzz
        lVQLTnGr2CFwAH0oVcXqWhKUuxYwaplh6cb88w1hiT6IGfggK1oSPPLoRcu7et7/EbYnP3xDNu+CP
        wYUK3Aka3HGMV5zvzLrXOLlCcT8rzv8lIc/P+n8+bY85sIImI4B+sIP6v9RDCThQyBRfBIJe0GtQm
        jHqIQ5iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3to5-0030tM-Mx; Thu, 15 Jul 2021 05:21:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 130/138] mm/truncate: Convert invalidate_inode_pages2_range to folios
Date:   Thu, 15 Jul 2021 04:36:56 +0100
Message-Id: <20210715033704.692967-131-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we're going to unmap a folio, we have to be sure to unmap the entire
folio, not just the part of it which lies after the search index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 62 ++++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index b8c9d2fbd9b5..d068f22fe422 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -599,42 +599,43 @@ void invalidate_mapping_pagevec(struct address_space *mapping,
  * shrink_page_list() has a temp ref on them, or because they're transiently
  * sitting in the lru_cache_add() pagevecs.
  */
-static int
-invalidate_complete_page2(struct address_space *mapping, struct page *page)
+static int invalidate_complete_folio2(struct address_space *mapping,
+		struct folio *folio)
 {
 	unsigned long flags;
 
-	if (page->mapping != mapping)
+	if (folio->mapping != mapping)
 		return 0;
 
-	if (page_has_private(page) && !try_to_release_page(page, GFP_KERNEL))
+	if (folio_has_private(folio) &&
+	    !try_to_release_page(&folio->page, GFP_KERNEL))
 		return 0;
 
 	xa_lock_irqsave(&mapping->i_pages, flags);
-	if (PageDirty(page))
+	if (folio_test_dirty(folio))
 		goto failed;
 
-	BUG_ON(page_has_private(page));
-	__delete_from_page_cache(page, NULL);
+	BUG_ON(folio_has_private(folio));
+	__filemap_remove_folio(folio, NULL);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 
 	if (mapping->a_ops->freepage)
-		mapping->a_ops->freepage(page);
+		mapping->a_ops->freepage(&folio->page);
 
-	put_page(page);	/* pagecache ref */
+	folio_ref_sub(folio, folio_nr_pages(folio));	/* pagecache ref */
 	return 1;
 failed:
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 	return 0;
 }
 
-static int do_launder_page(struct address_space *mapping, struct page *page)
+static int do_launder_folio(struct address_space *mapping, struct folio *folio)
 {
-	if (!PageDirty(page))
+	if (!folio_test_dirty(folio))
 		return 0;
-	if (page->mapping != mapping || mapping->a_ops->launder_page == NULL)
+	if (folio->mapping != mapping || mapping->a_ops->launder_page == NULL)
 		return 0;
-	return mapping->a_ops->launder_page(page);
+	return mapping->a_ops->launder_page(&folio->page);
 }
 
 /**
@@ -666,21 +667,21 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	index = start;
 	while (find_get_entries(mapping, index, end, &pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+			struct folio *folio = (struct folio *)pvec.pages[i];
 
-			/* We rely upon deletion not changing page->index */
+			/* We rely upon deletion not changing folio->index */
 			index = indices[i];
 
-			if (xa_is_value(page)) {
+			if (xa_is_value(folio)) {
 				if (!invalidate_exceptional_entry2(mapping,
-								   index, page))
+								index, folio))
 					ret = -EBUSY;
 				continue;
 			}
 
-			if (!did_range_unmap && page_mapped(page)) {
+			if (!did_range_unmap && folio_mapped(folio)) {
 				/*
-				 * If page is mapped, before taking its lock,
+				 * If folio is mapped, before taking its lock,
 				 * zap the rest of the file in one hit.
 				 */
 				unmap_mapping_pages(mapping, index,
@@ -688,26 +689,27 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				did_range_unmap = 1;
 			}
 
-			lock_page(page);
-			WARN_ON(page_to_index(page) != index);
-			if (page->mapping != mapping) {
-				unlock_page(page);
+			folio_lock(folio);
+			VM_WARN_ON_ONCE_FOLIO(!folio_contains(folio, index),
+						folio);
+			if (folio->mapping != mapping) {
+				folio_unlock(folio);
 				continue;
 			}
-			wait_on_page_writeback(page);
+			folio_wait_writeback(folio);
 
-			if (page_mapped(page))
-				unmap_mapping_page(page);
-			BUG_ON(page_mapped(page));
+			if (folio_mapped(folio))
+				unmap_mapping_page(&folio->page);
+			BUG_ON(folio_mapped(folio));
 
-			ret2 = do_launder_page(mapping, page);
+			ret2 = do_launder_folio(mapping, folio);
 			if (ret2 == 0) {
-				if (!invalidate_complete_page2(mapping, page))
+				if (!invalidate_complete_folio2(mapping, folio))
 					ret2 = -EBUSY;
 			}
 			if (ret2 < 0)
 				ret = ret2;
-			unlock_page(page);
+			folio_unlock(folio);
 		}
 		pagevec_remove_exceptionals(&pvec);
 		pagevec_release(&pvec);
-- 
2.30.2

