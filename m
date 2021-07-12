Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0343C4292
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhGLEHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhGLEHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:07:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8A5C0613DD;
        Sun, 11 Jul 2021 21:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4vOeP6YYf1fVI6dzwNlUU8r67Z65w+rGGpi9DMjCya0=; b=n3Jb5t1qmtVZANI9ZAT38WWGBG
        3CP13A5nnZ1P63LHBMcU+AjlzLReh3ixSVHIWreim/pP8D0SAHmCjXLQAJjBjiAocjRqi9RxkOGR+
        bMAyN/Yr6x6biBPTQLvDhmWMMjEo3wUxIy7IuwPxCyBmfrR2qTBSYr7Ueu09NnG084ogq0k4Vbmrp
        wNxtclE30jAbTJZchjzSf7BC+OCJvurBDX9mJzc2+/LeSTE0fRiv/Ur+LJPwmihzA97w79rRsWHgw
        7UUJDWmyMm+pg1Fe/H4e435peE/7Z8oVwNsH+Q5TtP19EAUtLg0CG9H0Fk8GNOOP347K3sICAcygJ
        w/Y+LIRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2n9i-00Gqhl-3D; Mon, 12 Jul 2021 04:03:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 107/137] mm/filemap: Convert page_cache_delete to take a folio
Date:   Mon, 12 Jul 2021 04:06:31 +0100
Message-Id: <20210712030701.4000097-108-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
 mm/filemap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a918599fc851..5b62e9ee46a2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -120,27 +120,26 @@
  */
 
 static void page_cache_delete(struct address_space *mapping,
-				   struct page *page, void *shadow)
+				   struct folio *folio, void *shadow)
 {
-	XA_STATE(xas, &mapping->i_pages, page->index);
+	XA_STATE(xas, &mapping->i_pages, folio->index);
 	unsigned int nr = 1;
 
 	mapping_set_update(&xas, mapping);
 
 	/* hugetlb pages are represented by a single entry in the xarray */
-	if (!PageHuge(page)) {
-		xas_set_order(&xas, page->index, compound_order(page));
-		nr = compound_nr(page);
+	if (!folio_hugetlb(folio)) {
+		xas_set_order(&xas, folio->index, folio_order(folio));
+		nr = folio_nr_pages(folio);
 	}
 
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(PageTail(page), page);
-	VM_BUG_ON_PAGE(nr != 1 && shadow, page);
+	VM_BUG_ON_FOLIO(!folio_locked(folio), folio);
+	VM_BUG_ON_FOLIO(nr != 1 && shadow, folio);
 
 	xas_store(&xas, shadow);
 	xas_init_marks(&xas);
 
-	page->mapping = NULL;
+	folio->mapping = NULL;
 	/* Leave page->index set: truncation lookup relies upon it */
 	mapping->nrpages -= nr;
 }
@@ -222,12 +221,13 @@ static void unaccount_page_cache_page(struct address_space *mapping,
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
2.30.2

