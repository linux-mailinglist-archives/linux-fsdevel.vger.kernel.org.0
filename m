Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C6A2D33A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgLHUWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbgLHUWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B03C0611CD;
        Tue,  8 Dec 2020 12:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MU5rCpKmGXhiLqucBbIqDDGkng6QmmAdASzyNay4oBY=; b=h3L9nMuBrmeDfbKNSovSzbvMqm
        vCY+8SmGBTxB/iIbsiwS6qSFf88CsAvLf6KHr3fVfDraoxjNIBqchmUNR8hMDhNNimZgLsEEIofD1
        djcVZuq+qaa1oba8EmjHYUKO101Y0u4SSAKxDsnAY1B14ucesBDybnajOKEltH2WroV+BKIqkoPFm
        xW0N9nUz5Ialk/+Z4pVDJ7+Q30hBoD/JmlAI84F+SMQcALPlAZRvwWD8fitI4bxACAiId5TbhX1U3
        0oJAGb5vgIvvcW8fQps91ad5bmNiobVh2sskcxxY/b1PXb8/Ytm+1fO70OAsz8fsPTO1o0PM6LHyW
        MI4FlqdA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmiwt-000515-P6; Tue, 08 Dec 2020 19:46:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/11] mm/filemap: Convert mapping_get_entry and pagecache_get_page to folio
Date:   Tue,  8 Dec 2020 19:46:51 +0000
Message-Id: <20201208194653.19180-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201208194653.19180-1-willy@infradead.org>
References: <20201208194653.19180-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert mapping_get_entry() to return a folio and convert
pagecache_get_page() to use the folio where possible.  The seemingly
dangerous cast of a page pointer to a folio pointer is safe because
__page_cache_alloc() allocates an order-0 page, which is a folio by
definition.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f1b65f777539..56ff6aa24265 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1673,33 +1673,33 @@ EXPORT_SYMBOL(page_cache_prev_miss);
  * @index: The page cache index.
  *
  * Looks up the page cache slot at @mapping & @offset.  If there is a
- * page cache page, the head page is returned with an increased refcount.
+ * page cache page, the folio is returned with an increased refcount.
  *
  * If the slot holds a shadow entry of a previously evicted page, or a
  * swap entry from shmem/tmpfs, it is returned.
  *
- * Return: The head page or shadow entry, %NULL if nothing is found.
+ * Return: The folio or shadow entry, %NULL if nothing is found.
  */
-static struct page *mapping_get_entry(struct address_space *mapping,
+static struct folio *mapping_get_entry(struct address_space *mapping,
 		pgoff_t index)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
-	struct page *page;
+	struct folio *folio;
 
 	rcu_read_lock();
 repeat:
 	xas_reset(&xas);
-	page = xas_load(&xas);
-	if (xas_retry(&xas, page))
+	folio = xas_load(&xas);
+	if (xas_retry(&xas, folio))
 		goto repeat;
 	/*
 	 * A shadow entry of a recently evicted page, or a swap entry from
 	 * shmem/tmpfs.  Return it without attempting to raise page count.
 	 */
-	if (!page || xa_is_value(page))
+	if (!folio || xa_is_value(folio))
 		goto out;
 
-	if (!page_cache_get_speculative(page))
+	if (!page_cache_get_speculative(&folio->page))
 		goto repeat;
 
 	/*
@@ -1707,14 +1707,14 @@ static struct page *mapping_get_entry(struct address_space *mapping,
 	 * This is part of the lockless pagecache protocol. See
 	 * include/linux/pagemap.h for details.
 	 */
-	if (unlikely(page != xas_reload(&xas))) {
-		put_page(page);
+	if (unlikely(folio != xas_reload(&xas))) {
+		put_folio(folio);
 		goto repeat;
 	}
 out:
 	rcu_read_unlock();
 
-	return page;
+	return folio;
 }
 
 /**
@@ -1754,11 +1754,13 @@ static struct page *mapping_get_entry(struct address_space *mapping,
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp_mask)
 {
+	struct folio *folio;
 	struct page *page;
 
 repeat:
-	page = mapping_get_entry(mapping, index);
-	if (xa_is_value(page)) {
+	folio = mapping_get_entry(mapping, index);
+	page = &folio->page;
+	if (xa_is_value(folio)) {
 		if (fgp_flags & FGP_ENTRY)
 			return page;
 		page = NULL;
@@ -1768,18 +1770,18 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 
 	if (fgp_flags & FGP_LOCK) {
 		if (fgp_flags & FGP_NOWAIT) {
-			if (!trylock_page(page)) {
-				put_page(page);
+			if (!trylock_folio(folio)) {
+				put_folio(folio);
 				return NULL;
 			}
 		} else {
-			lock_page(page);
+			lock_folio(folio);
 		}
 
 		/* Has the page been truncated? */
 		if (unlikely(page->mapping != mapping)) {
-			unlock_page(page);
-			put_page(page);
+			unlock_folio(folio);
+			put_folio(folio);
 			goto repeat;
 		}
 		VM_BUG_ON_PAGE(!thp_contains(page, index), page);
@@ -1806,17 +1808,18 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			return NULL;
+		folio = (struct folio *)page;
 
 		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
 			fgp_flags |= FGP_LOCK;
 
 		/* Init accessed so avoid atomic mark_page_accessed later */
 		if (fgp_flags & FGP_ACCESSED)
-			__SetPageReferenced(page);
+			__SetFolioReferenced(folio);
 
 		err = add_to_page_cache_lru(page, mapping, index, gfp_mask);
 		if (unlikely(err)) {
-			put_page(page);
+			put_folio(folio);
 			page = NULL;
 			if (err == -EEXIST)
 				goto repeat;
@@ -1827,7 +1830,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		 * an unlocked page.
 		 */
 		if (page && (fgp_flags & FGP_FOR_MMAP))
-			unlock_page(page);
+			unlock_folio(folio);
 	}
 
 	return page;
-- 
2.29.2

