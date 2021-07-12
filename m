Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88E13C41C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhGLD2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhGLD2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:28:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A01C0613DD;
        Sun, 11 Jul 2021 20:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nVC+BVk2C7BJc13hyk4hGwQf60siCtkLq/Ed/hMAyaI=; b=axsdhuykGBz7my0QN9WdWBrj0A
        mukyHjbu6SoY3vNmu+LvF3DIezUNmUF9A3EB3Zov43uxDi+N4EuXJxvKCMSLhNNs76vhAo3CcPEEr
        FgkbbGa6Vqj5K8tZpOmNl6l8CapknbH60ANdX5Qs2NKcnseKxmc/0rJVZ63WcDNqF11z38zhwy/+E
        INI6QSx4junvezwQP4v6akJ8ZeulO2o56ihloeiARpyhRlz5urIWoGLOrnYviQiN89hfb5WpBdWYY
        SAbIwKgyEDw4VS89/9SHeGG8c/dVmokNORAaysKRBuiI0QCflTmKq1S2xP+tjxrH6+dhqdNZMXBF/
        EXmlP+hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mYL-00Gnyc-DH; Mon, 12 Jul 2021 03:24:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v13 032/137] mm: Add folio_mapped()
Date:   Mon, 12 Jul 2021 04:05:16 +0100
Message-Id: <20210712030701.4000097-33-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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

