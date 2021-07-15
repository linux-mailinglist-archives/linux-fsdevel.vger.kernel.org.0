Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6FC3C97B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbhGOEut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhGOEup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:50:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F5CC06175F;
        Wed, 14 Jul 2021 21:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=s4e8Kh2qWqpIIoiU7QzGdSi1p21qS0jMzL9s/9ihZxo=; b=BRDZ5j6Da8EHAij1YI9iH7W4bY
        nlylSxN3DJeOKKUL8gdufs+7uKHb3dGVCxEha/8hlarEKk/3FGz3kn5wxQpwjM5Rb80CGloZa7zW5
        oqBgPe8Jmqf8KRJOomhAwLIG3mLcYZ54e+7//Es5PK4T7Cf1+6EMUcm6gcghXKlb/j+Jl44fl7HsJ
        0olxlTwHC5zr4uk8BjJM3Eq4dyh2W9oK4zS0UiAJVu1dS72Sd7swwdVqF1t8FT4EOZHBmXa6l62xL
        E6t1Jq7pUdkVIgLkJEdWv+PTZnMC0Vy1cvQN17mjeTkU9pf35qc46mP90pPjtnahppQ+/7aiRQeiF
        5GW2voAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tGh-002yae-SG; Thu, 15 Jul 2021 04:46:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 087/138] mm/filemap: Convert mapping_get_entry to return a folio
Date:   Thu, 15 Jul 2021 04:36:13 +0100
Message-Id: <20210715033704.692967-88-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 4e34383fd894..85a457c7b7a7 100644
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

