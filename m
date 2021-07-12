Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD343C639A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbhGLTYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbhGLTX7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:23:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C10C0613DD;
        Mon, 12 Jul 2021 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nVC+BVk2C7BJc13hyk4hGwQf60siCtkLq/Ed/hMAyaI=; b=dqRkOjlTLq2BRsXKi6WZcdHJZy
        r5zu9rXxRVL+Uj9YXsJ+39aVU+oKXATLt1stkCi0w7fY1VhXjrgSexO0Kn+PAoHclKKJlv1C+HMT3
        hBkWzgK83bekW26ISLW4t9m2ydkFmoPu2Gm3SGl5qlpXBb7P6qZHNnNpgmTCovVajMOnfSOCSIxvD
        sGX+4L4o+H9TAdnf7zG7Synq2gborbZZg9p4BetJg7hxbIr9eHyfXGVzVv4UbMBCgOXBWZqr3IBPD
        y2NQEsHTOaJ3p9O69EXBnhAyWUto6T5Lg30siTMui2jJC7gFMO5QZU1V7wREzeaXcFpmumAmG9SXP
        yk1vv3AQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31TI-000MfM-Tn; Mon, 12 Jul 2021 19:20:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v13 32/32] mm: Add folio_mapped()
Date:   Mon, 12 Jul 2021 20:02:04 +0100
Message-Id: <20210712190204.80979-33-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712190204.80979-1-willy@infradead.org>
References: <20210712190204.80979-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Howells <dhowells@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/mm.h       |  1 +
 include/linux/mm_types.h |  6 ++++++
 mm/folio-compat.c        |  6 ++++++
 mm/util.c                | 29 ++++++++++++++++-------------
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 24311e4c08e9..a856c078e040 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1766,6 +1766,7 @@ static inline pgoff_t page_index(struct page *page)
 }
 
 bool page_mapped(struct page *page);
+bool folio_mapped(struct folio *folio);
 
 /*
  * Return true only if the page has been allocated with
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c15b4af8ef4d..d0061ddf080f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -291,6 +291,12 @@ FOLIO_MATCH(memcg_data, memcg_data);
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
index d6176bb63629..0c65b260cded 100644
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

