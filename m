Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD8F1D4EC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgEONRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgEONRA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DCCC05BD09;
        Fri, 15 May 2020 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=n+nEZyido/DxHe/n1547nGNhqWH1ViJvKc/xC6MlKVQ=; b=td/O+zfmxpLo/MrXYYDpm9YR7t
        DHh0UbDLqOSyVakWYeqflEpWUwsRRZdJdboX0UOxtO4uddNwi+pMLamucxbcA1AFOPrmXF1y0R7JO
        +jMDHJtSLbo9tf2WAb2vCzkjxvIwJySsyPHvSh8sAkFcWWBwdXXwf5kpsZWAjvCSCxTC9N0hrZDsA
        CT7PaPeBDfJXhvfv3V6xMoFqSxojbKbRfpnT4skSwzwcxb+UpknT/lcXRINb4oj9kGE+sjIbo3aGD
        +5EqYIh7UnhrjdHwbXvknml0fhjzlKzl7Z8unM9AQvccJswAhHwd98RAJGEV/2QusLA8TDGBZtBUs
        zLQnRpWQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaCy-0005Tq-Dm; Fri, 15 May 2020 13:17:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/36] mm: Allow hpages to be arbitrary order
Date:   Fri, 15 May 2020 06:16:23 -0700
Message-Id: <20200515131656.12890-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove the assumption in hpage_nr_pages() that compound pages are
necessarily PMD sized.  Move the relevant parts of mm.h to before the
include of huge_mm.h so we can use an inline function rather than a macro.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h |  5 +--
 include/linux/mm.h      | 96 ++++++++++++++++++++---------------------
 2 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index cfbb0a87c5f0..6bec4b5b61e1 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -265,11 +265,10 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 	else
 		return NULL;
 }
+
 static inline int hpage_nr_pages(struct page *page)
 {
-	if (unlikely(PageTransHuge(page)))
-		return HPAGE_PMD_NR;
-	return 1;
+	return compound_nr(page);
 }
 
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 581e56275bc4..088acbda722d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -671,6 +671,54 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+static inline unsigned int compound_order(struct page *page)
+{
+	if (!PageHead(page))
+		return 0;
+	return page[1].compound_order;
+}
+
+static inline bool hpage_pincount_available(struct page *page)
+{
+	/*
+	 * Can the page->hpage_pinned_refcount field be used? That field is in
+	 * the 3rd page of the compound page, so the smallest (2-page) compound
+	 * pages cannot support it.
+	 */
+	page = compound_head(page);
+	return PageCompound(page) && compound_order(page) > 1;
+}
+
+static inline int compound_pincount(struct page *page)
+{
+	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
+	page = compound_head(page);
+	return atomic_read(compound_pincount_ptr(page));
+}
+
+static inline void set_compound_order(struct page *page, unsigned int order)
+{
+	page[1].compound_order = order;
+}
+
+/* Returns the number of pages in this potentially compound page. */
+static inline unsigned long compound_nr(struct page *page)
+{
+	return 1UL << compound_order(page);
+}
+
+/* Returns the number of bytes in this potentially compound page. */
+static inline unsigned long page_size(struct page *page)
+{
+	return PAGE_SIZE << compound_order(page);
+}
+
+/* Returns the number of bits needed for the number of bytes in a page */
+static inline unsigned int page_shift(struct page *page)
+{
+	return PAGE_SHIFT + compound_order(page);
+}
+
 /*
  * FIXME: take this include out, include page-flags.h in
  * files which need it (119 of them)
@@ -875,54 +923,6 @@ static inline compound_page_dtor *get_compound_page_dtor(struct page *page)
 	return compound_page_dtors[page[1].compound_dtor];
 }
 
-static inline unsigned int compound_order(struct page *page)
-{
-	if (!PageHead(page))
-		return 0;
-	return page[1].compound_order;
-}
-
-static inline bool hpage_pincount_available(struct page *page)
-{
-	/*
-	 * Can the page->hpage_pinned_refcount field be used? That field is in
-	 * the 3rd page of the compound page, so the smallest (2-page) compound
-	 * pages cannot support it.
-	 */
-	page = compound_head(page);
-	return PageCompound(page) && compound_order(page) > 1;
-}
-
-static inline int compound_pincount(struct page *page)
-{
-	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
-	page = compound_head(page);
-	return atomic_read(compound_pincount_ptr(page));
-}
-
-static inline void set_compound_order(struct page *page, unsigned int order)
-{
-	page[1].compound_order = order;
-}
-
-/* Returns the number of pages in this potentially compound page. */
-static inline unsigned long compound_nr(struct page *page)
-{
-	return 1UL << compound_order(page);
-}
-
-/* Returns the number of bytes in this potentially compound page. */
-static inline unsigned long page_size(struct page *page)
-{
-	return PAGE_SIZE << compound_order(page);
-}
-
-/* Returns the number of bits needed for the number of bytes in a page */
-static inline unsigned int page_shift(struct page *page)
-{
-	return PAGE_SHIFT + compound_order(page);
-}
-
 void free_compound_page(struct page *page);
 
 #ifdef CONFIG_MMU
-- 
2.26.2

