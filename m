Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D981946CC5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbhLHE0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbhLHE0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBF6C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rF8B5Bv6xTxudXTmrHELyzSGUCagkpzrcf/781BtVxg=; b=WC2Sw82qHt3NL9eKhvdbIcJ7jZ
        VkibfBA7ok4kr0WMAK06JK0P1a2F8FqP19vz3guLQBJUB1RWoiyI6lRNPfLfXXMxNmE9/0c+qUDyQ
        S7vW5ke/npS6XKfy9zpubgmniy69pd/3IRAviL6y1q27zJgGdVpFggZkhUc8l2ak1WtJ80ybjtUS0
        2Z4tUgVFWzIgIRH917dlx6/G3OyAvoOJqkW9Bj1fe5RpduWzkcwD71I/RJG+nIaJga8RtPgyqmdw4
        6RCfB4FFrZCmojNhNFzY2PCm+mxalOacqoUdLltDCVc1IWG+QmfAnNexZg0VOH1vTwsmfhnW50Jqw
        UrIXsEXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU2-0084XQ-KT; Wed, 08 Dec 2021 04:23:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 10/48] filemap: Convert page_cache_delete to take a folio
Date:   Wed,  8 Dec 2021 04:22:18 +0000
Message-Id: <20211208042256.1923824-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It was already assuming a head page, so this is a straightforward
conversion.  Convert the one caller to call page_folio(), even though
it must currently be passing in a head page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5dd3c6e39c9f..38fb26e16b85 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -121,27 +121,26 @@
  */
 
 static void page_cache_delete(struct address_space *mapping,
-				   struct page *page, void *shadow)
+				   struct folio *folio, void *shadow)
 {
-	XA_STATE(xas, &mapping->i_pages, page->index);
-	unsigned int nr = 1;
+	XA_STATE(xas, &mapping->i_pages, folio->index);
+	long nr = 1;
 
 	mapping_set_update(&xas, mapping);
 
 	/* hugetlb pages are represented by a single entry in the xarray */
-	if (!PageHuge(page)) {
-		xas_set_order(&xas, page->index, compound_order(page));
-		nr = compound_nr(page);
+	if (!folio_test_hugetlb(folio)) {
+		xas_set_order(&xas, folio->index, folio_order(folio));
+		nr = folio_nr_pages(folio);
 	}
 
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(PageTail(page), page);
-	VM_BUG_ON_PAGE(nr != 1 && shadow, page);
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(nr != 1 && shadow, folio);
 
 	xas_store(&xas, shadow);
 	xas_init_marks(&xas);
 
-	page->mapping = NULL;
+	folio->mapping = NULL;
 	/* Leave page->index set: truncation lookup relies upon it */
 	mapping->nrpages -= nr;
 }
@@ -223,12 +222,13 @@ static void unaccount_page_cache_page(struct address_space *mapping,
  */
 void __delete_from_page_cache(struct page *page, void *shadow)
 {
+	struct folio *folio = page_folio(page);
 	struct address_space *mapping = page->mapping;
 
 	trace_mm_filemap_delete_from_page_cache(page);
 
 	unaccount_page_cache_page(mapping, page);
-	page_cache_delete(mapping, page, shadow);
+	page_cache_delete(mapping, folio, shadow);
 }
 
 static void page_cache_free_page(struct address_space *mapping,
-- 
2.33.0

