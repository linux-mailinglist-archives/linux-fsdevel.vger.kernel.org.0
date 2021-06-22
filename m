Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F993B054C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhFVM5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhFVM5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:57:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3171DC061574;
        Tue, 22 Jun 2021 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y0KiXdMi6qlFopeP6+ne5fm8oMGgTCLjazxpZLPk4Hk=; b=UTZ71SvYXAe9/3lIFDELLAwucW
        TkEeC+tzX441Wo3DqtLi7uFp4Amj1t1PiRFn0QRtzKOKiGS9DJWTHiP1ZemeTnE/8goOqyuA5Fi/P
        Xxb//Pom+NSBjVg7W8KZLPl6nN5JKl5Ig3d+2ieUBMt4n+gyQywhacwxFK+ZbLFdLRGPFL5Twckez
        98IabqlfgaXh/COj2Xm+UX84bT8sNzrGf/BFXCC7uqy9+q5oNF7ssGEwEI4ALCMYAFAtUiXT3JkAi
        xHGS6U6qPwKHdWh2pkjWLqGG+21v44iNhuLg91G25Mv7XNWfRxu8bD7kVqvFJJGUaf6PW+pYeHO1Y
        P0Zp7uOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfvC-00EJ75-T9; Tue, 22 Jun 2021 12:54:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 44/46] mm/filemap: Convert mapping_get_entry to return a folio
Date:   Tue, 22 Jun 2021 13:15:49 +0100
Message-Id: <20210622121551.3398730-45-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pagecache only contains folios, so indicate that this is definitely
not a tail page.  Shrinks mapping_get_entry() by 56 bytes, but grows
pagecache_get_page() by 21 bytes as gcc makes slightly different hot/cold
code decisions.  A net reduction of 35 bytes of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a174f8ce87ea..7d0b51f30223 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1754,49 +1754,43 @@ EXPORT_SYMBOL(page_cache_prev_miss);
  * @mapping: the address_space to search
  * @index: The page cache index.
  *
- * Looks up the page cache slot at @mapping & @index.  If there is a
- * page cache page, the head page is returned with an increased refcount.
+ * Looks up the page cache entry at @mapping & @index.  If it is a folio,
+ * it is returned with an increased refcount.  If it is a shadow entry
+ * of a previously evicted folio, or a swap entry from shmem/tmpfs,
+ * it is returned without further action.
  *
- * If the slot holds a shadow entry of a previously evicted page, or a
- * swap entry from shmem/tmpfs, it is returned.
- *
- * Return: The head page or shadow entry, %NULL if nothing is found.
+ * Return: The folio, swap or shadow entry, %NULL if nothing is found.
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
+	if (!folio_try_get_rcu(folio))
 		goto repeat;
 
-	/*
-	 * Has the page moved or been split?
-	 * This is part of the lockless pagecache protocol. See
-	 * include/linux/pagemap.h for details.
-	 */
-	if (unlikely(page != xas_reload(&xas))) {
-		put_page(page);
+	if (unlikely(folio != xas_reload(&xas))) {
+		folio_put(folio);
 		goto repeat;
 	}
 out:
 	rcu_read_unlock();
 
-	return page;
+	return folio;
 }
 
 /**
@@ -1836,10 +1830,12 @@ static struct page *mapping_get_entry(struct address_space *mapping,
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp_mask)
 {
+	struct folio *folio;
 	struct page *page;
 
 repeat:
-	page = mapping_get_entry(mapping, index);
+	folio = mapping_get_entry(mapping, index);
+	page = &folio->page;
 	if (xa_is_value(page)) {
 		if (fgp_flags & FGP_ENTRY)
 			return page;
-- 
2.30.2

