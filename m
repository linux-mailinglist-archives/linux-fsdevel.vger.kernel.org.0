Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3692337B16F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 00:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhEKWM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 18:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEKWMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 18:12:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16A9C061574;
        Tue, 11 May 2021 15:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/GdfvwTM/K0ZoZemuBNLY2t2LpqYKThsq49VxHp7UGg=; b=DlKtqZS7VBQcU0d2qPIkzGqL04
        P18HUAB36LqMat+D7dNQefgCb4/bKGQqF5ypaq/PkcPRg5yCSbUnrnNfECglQgTPxJ3Mb5Fj/YFSP
        dFAAg2ujDHo9qm+xolGqt9HZqOpEtyIjiTSk9Q/HLDDJZAcD+Td3OZadkzmbtJX+2UpxrYd9NSIGC
        ePsABT8vHFFArOHwyberdJ8Rq/2ERuMLlYuY6Fxzr2sgO5wFb8rV9rZV3zd0QZvjQr2Cr3Ra3oYeb
        VSwP/Zl4O/2VtBpI97uaefSJ/pP6B2snsaLXxNJ+X8yb0gt1HEcccwYYh4u/IrnYI5Dh6U6l6h9b/
        awMerhLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgaaG-007iyN-0L; Tue, 11 May 2021 22:10:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 33/33] mm: Add folio_mapped
Date:   Tue, 11 May 2021 22:47:35 +0100
Message-Id: <20210511214735.1836149-34-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is the equivalent of page_mapped().  It is slightly
shorter as we do not need to handle the PageTail() case.  Reimplement
page_mapped() as a wrapper around folio_mapped().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h |  1 +
 mm/folio-compat.c  |  6 ++++++
 mm/util.c          | 29 ++++++++++++++++-------------
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6e3dde81ecc9..4686107a4f96 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1779,6 +1779,7 @@ static inline pgoff_t page_index(struct page *page)
 }
 
 bool page_mapped(struct page *page);
+bool folio_mapped(struct folio *folio);
 
 /*
  * Return true only if the page has been allocated with
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
index 245f5c7bedae..c2d22145ebae 100644
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
+ * Return: true if any page in this folio is mapped into pagetables.
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
+	if (atomic_read(compound_mapcount_ptr(&folio->page)) >= 0)
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

