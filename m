Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360623C9809
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhGOFJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGOFJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:09:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD6C06175F;
        Wed, 14 Jul 2021 22:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2kO2DGhsWpCEZQZSuKBdU48h/VIyaOm4/uZr2l+t0xI=; b=HSHshhoPypa7G76ECE/ojc5dqA
        KLh/vHqG9HVhsGikLecnTX4MFIv7Hnn9WCQYDjWTq2okVsZPNwyuaQPzjnpiF6j2J/va075rL9RuM
        AreyvSS8bkKNbAZuDs6sSrR/e3bSFfMii4BrMMt5Jmhg+yAzEXh03mzc8D09lNSQncGFni/6iWHJh
        ABvsfk5drBhjR46SDlRWevk5gulri/Yx6gDBTpzlc9Ro59bsv2GV7qXoFZxm8S272m4wO8QvODiPv
        1XmyELguUzQjTRhQGoPbYAFwBtipeMveIwxti0aZnsoSXaJnO6SVeI7qwZ5HlqpvGYRSUTlrsUA4H
        oWXP50+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tXy-002zqN-79; Thu, 15 Jul 2021 05:04:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 108/138] mm/filemap: Convert page_cache_delete to take a folio
Date:   Thu, 15 Jul 2021 04:36:34 +0100
Message-Id: <20210715033704.692967-109-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 0434c5a55fec..c96febad32fc 100644
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

