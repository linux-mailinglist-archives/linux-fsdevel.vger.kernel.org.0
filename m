Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABDA3A708B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhFNUiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbhFNUiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:38:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C9C061574;
        Mon, 14 Jun 2021 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X3GGI5ZixyDG1CrMjRxTv0etp3mo3ZL6Xx3w1pohK4U=; b=ZhloFGgATVktaHLgOafJwac97Z
        x1iip5BW5KpcQ9flP/CsBIeWblS2w3bA8qYH/OT2fy8iXnsRBAyy2fYPnbzSPHk8piOQQCn7GU3sY
        BIn9KxD81qOYIq9dwIU8APNYYnuJGWj0jSQuRBvYiTAq53AbkEdxc4SHk9l+wn0DCaFoM10wQVK3k
        uSaJ+LMEuev87eM/IHGnNE4i1aLCDpaSWQ9ehF/l6lWnxMjy/x5I/1Q7Vfi/ZHtcrMxedY551DZ0F
        vfPqyfclvlZbsA8jn4v1HRUVJXLDuriHYy7m91EFQn6e4mE4IEBLJu1Ujv9lwOdtqTPw8d7z70Gvn
        UB3X9uoA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lstI9-005oUn-0x; Mon, 14 Jun 2021 20:34:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v11 33/33] mm: Add folio_mapped()
Date:   Mon, 14 Jun 2021 21:14:35 +0100
Message-Id: <20210614201435.1379188-34-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is the equivalent of page_mapped().  It is slightly
shorter as we do not need to handle the PageTail() case.  Reimplement
page_mapped() as a wrapper around folio_mapped().  folio_mapped()
is 13 bytes smaller than page_mapped(), but the page_mapped() wrapper
is 30 bytes, for a net increase of 17 bytes of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/mm.h       |  1 +
 include/linux/mm_types.h |  6 ++++++
 mm/folio-compat.c        |  6 ++++++
 mm/util.c                | 29 ++++++++++++++++-------------
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cd8078cbe21d..f75a17bb5f82 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1768,6 +1768,7 @@ static inline pgoff_t page_index(struct page *page)
 }
 
 bool page_mapped(struct page *page);
+bool folio_mapped(struct folio *folio);
 
 /*
  * Return true only if the page has been allocated with
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 943854268986..0a0d7e3d069f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -284,6 +284,12 @@ FOLIO_MATCH(memcg_data, memcg_data);
 #endif
 #undef FOLIO_MATCH
 
+static inline atomic_t *folio_mapcount_ptr(struct folio *folio)
+{
+	struct page *tail = &folio->page + 1;
+	return &tail->compound_mapcount;
+}
+
 static inline atomic_t *compound_mapcount_ptr(struct page *page)
 {
 	return &page[1].compound_mapcount;
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 3c83f03b80d7..7044fcc8a8aa 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -35,3 +35,9 @@ void wait_for_stable_page(struct page *page)
 	return folio_wait_stable(page_folio(page));
 }
 EXPORT_SYMBOL_GPL(wait_for_stable_page);
+
+bool page_mapped(struct page *page)
+{
+	return folio_mapped(page_folio(page));
+}
+EXPORT_SYMBOL(page_mapped);
diff --git a/mm/util.c b/mm/util.c
index afd99591cb81..a8766e7f1b7f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -652,28 +652,31 @@ void *page_rmapping(struct page *page)
 	return __page_rmapping(page);
 }
 
-/*
- * Return true if this page is mapped into pagetables.
- * For compound page it returns true if any subpage of compound page is mapped.
+/**
+ * folio_mapped - Is this folio mapped into userspace?
+ * @folio: The folio.
+ *
+ * Return: True if any page in this folio is referenced by user page tables.
  */
-bool page_mapped(struct page *page)
+bool folio_mapped(struct folio *folio)
 {
-	int i;
+	int i, nr;
 
-	if (likely(!PageCompound(page)))
-		return atomic_read(&page->_mapcount) >= 0;
-	page = compound_head(page);
-	if (atomic_read(compound_mapcount_ptr(page)) >= 0)
+	if (folio_single(folio))
+		return atomic_read(&folio->_mapcount) >= 0;
+	if (atomic_read(folio_mapcount_ptr(folio)) >= 0)
 		return true;
-	if (PageHuge(page))
+	if (folio_hugetlb(folio))
 		return false;
-	for (i = 0; i < compound_nr(page); i++) {
-		if (atomic_read(&page[i]._mapcount) >= 0)
+
+	nr = folio_nr_pages(folio);
+	for (i = 0; i < nr; i++) {
+		if (atomic_read(&folio_page(folio, i)->_mapcount) >= 0)
 			return true;
 	}
 	return false;
 }
-EXPORT_SYMBOL(page_mapped);
+EXPORT_SYMBOL(folio_mapped);
 
 struct anon_vma *page_anon_vma(struct page *page)
 {
-- 
2.30.2

