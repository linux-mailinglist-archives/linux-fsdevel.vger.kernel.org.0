Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289C637478C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 20:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhEER6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbhEER6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:58:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D74C061761;
        Wed,  5 May 2021 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Av+BBOZUAh68SU/Va2q2cjv/1CjK/OveGHjToGYH/sA=; b=CAhWDKDx3yaZWJa35M23tD+lyu
        hmnqg3FWgFypWHnHGXbtRsbNfwwMFBsEOR/Ia8sjH8WdFRgIp4dbulaQePJRXCjYinBib8vdqlMGk
        Mjm449KWodW2lo9JTmys2AGZADpeTzgg6MGh28a9izlEcmPG2AGDUeFNvvJaeTBUeLcKpJ4eTtKYl
        nWIRDq2K07Nl3JGewOy1BM6J3qCMy187DbWBUWjGuX+grtj9gmOnpwUJr26rrIhJYByEbh6T6vqz/
        5JH/EPLSMuU4OtMxfC4gq+WMu41SHQZXDWUO6ell1IaTOHfmipJcFkhFmaInJQKrfEmD4Ej9T3Jjx
        /XgTs/ew==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKvk-000ceS-O0; Wed, 05 May 2021 17:04:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 79/96] mm/filemap: Convert mapping_get_entry to return a folio
Date:   Wed,  5 May 2021 16:06:11 +0100
Message-Id: <20210505150628.111735-80-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
 mm/filemap.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 062610ae95d8..b3714dddb045 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1732,34 +1732,33 @@ EXPORT_SYMBOL(page_cache_prev_miss);
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
+	if (!page_cache_get_speculative(&folio->page))
 		goto repeat;
 
 	/*
@@ -1767,14 +1766,14 @@ static struct page *mapping_get_entry(struct address_space *mapping,
 	 * This is part of the lockless pagecache protocol. See
 	 * include/linux/pagemap.h for details.
 	 */
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
@@ -1814,10 +1813,12 @@ static struct page *mapping_get_entry(struct address_space *mapping,
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

