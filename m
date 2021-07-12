Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2D23C4257
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhGLD4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhGLD4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:56:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42375C0613DD;
        Sun, 11 Jul 2021 20:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DTgsfkcB+KmoY5/60sn/DAF372G/0oDSg1qUz0IFxnY=; b=DxWtKE3K34UYwkyGJkScJTrUHm
        PzEsmy96YW/bVDXMpfjyx2tQU6bSahht1r/n9QVTjrCgEDxkVkE1Ad5OORDsKI+bZMtpFlulwAbLB
        6lbykMISncStiJvZFEltZMcU1tW9dT6qVai34uBsIY1pvVjeYgXxrv0X4dVYzOzTOKmTNH5L4p91T
        iKP00v13i5LznIfH4M5jix76gwyTHFli9bayVCY4bxDSa1Mz+4xJ/CH5M2gf4w8adMC0nusBXwpV6
        j7EohlW5F3gYcFwcPL1+XqFWQ9uuA0EJJ77ZjRj9Sy1vJ5rc7IVFqsBPDcdP9gmJ9br9MAgxPoo7f
        myZDEmvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mzu-00GpzD-Hp; Mon, 12 Jul 2021 03:52:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 086/137] mm/filemap: Convert mapping_get_entry to return a folio
Date:   Mon, 12 Jul 2021 04:06:10 +0100
Message-Id: <20210712030701.4000097-87-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8e102505da11..5e1e357ec43f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1755,49 +1755,42 @@ EXPORT_SYMBOL(page_cache_prev_miss);
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
-		pgoff_t index)
+static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
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
-- 
2.30.2

