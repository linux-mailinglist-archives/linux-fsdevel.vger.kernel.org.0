Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778AB46CC70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244244AbhLHE1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244181AbhLHE0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C55C0698D4
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=O2rXYGwuMrrnf3QKuW5hfKeCWLF/1U/uGtPuofV+Hos=; b=mnArESWZgEj9j0aKIwRhyceMXW
        CoTGKDMFwU+07rPdBMg2zmf8ogUqG8Igo1xjVIMo3XeuSdMs+Qyz/Wgq/8CEZymkWRcenJ7dBXTVQ
        6TeDnVoedFJPwE7j4yxDzU0ozth4XPq2L5CV3ZaEl3Q5X1uEP/MOEGLI9QGd3o3/qkkyl/eF6lNNg
        ckx2pFteVauMPiNWuFBbo9HnvhIRfNauxGeB/SOGwgsDjgJcPNccDbwTVFcJAkREaxZyap44L6dVZ
        lfDNly5QXTssa5y/LWowHDU8pDXZj1Cm+s6UU6b5Y5CyiUycgX+lGjFRQu4W6AO8ARhi+0o/YSEJn
        4P4nGkug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU6-0084cD-St; Wed, 08 Dec 2021 04:23:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 38/48] truncate: Add invalidate_complete_folio2()
Date:   Wed,  8 Dec 2021 04:22:46 +0000
Message-Id: <20211208042256.1923824-39-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert invalidate_complete_page2() to invalidate_complete_folio2().
Use filemap_free_folio() to free the page instead of calling ->freepage
manually.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c  |  3 +--
 mm/internal.h |  1 +
 mm/truncate.c | 23 ++++++++++-------------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7a418f0012e5..fb3cdb7aeffc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -229,8 +229,7 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 	page_cache_delete(mapping, folio, shadow);
 }
 
-static void filemap_free_folio(struct address_space *mapping,
-				struct folio *folio)
+void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 {
 	void (*freepage)(struct page *);
 
diff --git a/mm/internal.h b/mm/internal.h
index b05515d3b07b..d3c7b35934ed 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -113,6 +113,7 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
+void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 
 /**
diff --git a/mm/truncate.c b/mm/truncate.c
index ef6980b240e2..5370094641d6 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -571,31 +571,29 @@ void invalidate_mapping_pagevec(struct address_space *mapping,
  * shrink_page_list() has a temp ref on them, or because they're transiently
  * sitting in the lru_cache_add() pagevecs.
  */
-static int
-invalidate_complete_page2(struct address_space *mapping, struct page *page)
+static int invalidate_complete_folio2(struct address_space *mapping,
+					struct folio *folio)
 {
-	if (page->mapping != mapping)
+	if (folio->mapping != mapping)
 		return 0;
 
-	if (page_has_private(page) && !try_to_release_page(page, GFP_KERNEL))
+	if (folio_has_private(folio) &&
+	    !filemap_release_folio(folio, GFP_KERNEL))
 		return 0;
 
 	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
-	if (PageDirty(page))
+	if (folio_test_dirty(folio))
 		goto failed;
 
-	BUG_ON(page_has_private(page));
-	__delete_from_page_cache(page, NULL);
+	BUG_ON(folio_has_private(folio));
+	__filemap_remove_folio(folio, NULL);
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_add_lru(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
 
-	if (mapping->a_ops->freepage)
-		mapping->a_ops->freepage(page);
-
-	put_page(page);	/* pagecache ref */
+	filemap_free_folio(mapping, folio);
 	return 1;
 failed:
 	xa_unlock_irq(&mapping->i_pages);
@@ -679,8 +677,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 			ret2 = do_launder_page(mapping, &folio->page);
 			if (ret2 == 0) {
-				if (!invalidate_complete_page2(mapping,
-								&folio->page))
+				if (!invalidate_complete_folio2(mapping, folio))
 					ret2 = -EBUSY;
 			}
 			if (ret2 < 0)
-- 
2.33.0

