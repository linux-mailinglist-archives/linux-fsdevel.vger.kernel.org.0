Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675B12DC64C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgLPSZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbgLPSY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:24:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6002C0611CA;
        Wed, 16 Dec 2020 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Z2WxcQe4oqvmu0Mp0Iq/n1ReJp9tHHAOahV82RnR75I=; b=UfIFz383k7RGHSLOtIF8vJza9v
        6WhQD3hj+MX3bWM8l3uqi2D0jl1Grxe7mWEBT2Om9yUWzgoUYaIV1bG4BW7nj0GSbOEvJT6kb94Nf
        qWJ9AO+o9LwmNeeza9Eawa2nyLyiLLkpkMQH1FbzsO4A76foLDCoPRSTXINUefBiJoZj+T6uj/lXb
        8uiCM1tFYSg1bxZje7HbSj2+Lkm9uFhXbxH7NVDQnJJzOi781EroVvE+peMZxk7EoFYBGvkZ9tN4F
        uiIatA6ZLRgwQCh/mE6FpZD7ZvO/7//aFcCmYNPgHFUUj5SlnrpiDe3foFxI0U4we6YKeejaCcEAK
        ffam0Z0g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSe-000771-9K; Wed, 16 Dec 2020 18:23:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/25] mm: Convert mapping_get_entry to return a folio
Date:   Wed, 16 Dec 2020 18:23:21 +0000
Message-Id: <20201216182335.27227-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pagecache only contains folios, so this is the right thing to do.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 654bba53442a..b9f25a2d8312 100644
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
@@ -1757,7 +1757,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 	struct page *page;
 
 repeat:
-	page = mapping_get_entry(mapping, index);
+	page = &mapping_get_entry(mapping, index)->page;
 	if (xa_is_value(page)) {
 		if (fgp_flags & FGP_ENTRY)
 			return page;
-- 
2.29.2

