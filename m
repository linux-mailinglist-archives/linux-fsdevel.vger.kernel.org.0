Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB746CC6F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244234AbhLHE1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbhLHE0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934CCC0698D3
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AMdXWqM9y2naxpi8sOt9C2UydZsRiUJuoqUPrvDFvVk=; b=ByebKbQ1Gn0JnlxAc57DWSS9Ff
        Cc3iOKVahJoBfHov4cJb+ytLbC3XERdLjG1wLH5fkj/CO986sltyZgmUNUYBtC6b2n+Wa+xhZ+wbX
        PzYHzbmc/ZjhQtIwCZdjEqRSGyadsj0qjbQ6ca4Qd5O4CeeRyl5C2RoxCoybIwrP8YndDmRb9aYYo
        rGLA4ubMV4bwH7Q4byEX0oNFPIFEhVKi3AwADwxbozACEx3Jt/+dK4U6EfXkBeKDtVsBx3AYlwXXy
        1MOzHPQMQkBAzNgQgcFn4AczCnKYCMItIIIR6b7n1iB074x0TB2xxanZIZb68/hufQF+xP7WtQhQr
        GhyvAcjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU6-0084br-Oc; Wed, 08 Dec 2021 04:23:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 37/48] truncate: Convert invalidate_inode_pages2_range() to use a folio
Date:   Wed,  8 Dec 2021 04:22:45 +0000
Message-Id: <20211208042256.1923824-38-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we're going to unmap a folio, we have to be sure to unmap the entire
folio, not just the part of it which lies after the search index.

We cannot yet remove the struct page from invalidate_inode_pages2_range()
because the page pointer in the pvec might be a shadow/dax/swap entry
instead of actually a page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 0df420c1cf5b..ef6980b240e2 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -642,8 +642,9 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	while (find_get_entries(mapping, index, end, &pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
+			struct folio *folio;
 
-			/* We rely upon deletion not changing page->index */
+			/* We rely upon deletion not changing folio->index */
 			index = indices[i];
 
 			if (xa_is_value(page)) {
@@ -652,10 +653,11 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 					ret = -EBUSY;
 				continue;
 			}
+			folio = page_folio(page);
 
-			if (!did_range_unmap && page_mapped(page)) {
+			if (!did_range_unmap && folio_mapped(folio)) {
 				/*
-				 * If page is mapped, before taking its lock,
+				 * If folio is mapped, before taking its lock,
 				 * zap the rest of the file in one hit.
 				 */
 				unmap_mapping_pages(mapping, index,
@@ -663,26 +665,27 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				did_range_unmap = 1;
 			}
 
-			lock_page(page);
-			WARN_ON(page_to_index(page) != index);
-			if (page->mapping != mapping) {
-				unlock_page(page);
+			folio_lock(folio);
+			VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
+			if (folio->mapping != mapping) {
+				folio_unlock(folio);
 				continue;
 			}
-			wait_on_page_writeback(page);
+			folio_wait_writeback(folio);
 
-			if (page_mapped(page))
-				unmap_mapping_folio(page_folio(page));
-			BUG_ON(page_mapped(page));
+			if (folio_mapped(folio))
+				unmap_mapping_folio(folio);
+			BUG_ON(folio_mapped(folio));
 
-			ret2 = do_launder_page(mapping, page);
+			ret2 = do_launder_page(mapping, &folio->page);
 			if (ret2 == 0) {
-				if (!invalidate_complete_page2(mapping, page))
+				if (!invalidate_complete_page2(mapping,
+								&folio->page))
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
2.33.0

