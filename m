Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92B33C42D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhGLEVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhGLEVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:21:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AB3C0613DD;
        Sun, 11 Jul 2021 21:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+VbWUeKfZMEA+Wd9+U+PmI5IKCEO5A7uc1AvAOcMUeI=; b=pn9cV8zkbPWHK7fSr7+K7k1QRa
        LAFXsV85iFk2ghPGQHuEd53Ouyy/uFBLOf2NpXAAznuhkvCF8xCN0Ct9ZCglYAec4C3ipLE4WUC6M
        aQFRelE+CfRKnTMmIxV6PXlGpfWHUpNxHe9V4MPKb/r9xN/cqMoUYd9hNKlcTVNAAY5N94MXoZoTI
        4sPFGurW4bUsRd+9zP1qSYTQEe5S5sAej/aaw1ny/Q9UV9jcLMlT0SEmuSqFQ1+i+13cn2IOtQFQL
        GPHVeEBOF40XlrTAH/sYOLS01vvLjfx/3i0z0gEQNOQpRJtKTIYRD5ULamgJ02LgVaAZZuxy7N9IF
        BpH//qig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nNi-00Grha-Jr; Mon, 12 Jul 2021 04:17:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 133/137] mm: Support arbitrary THP sizes
Date:   Mon, 12 Jul 2021 04:06:57 +0100
Message-Id: <20210712030701.4000097-134-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the compound size of the page instead of assuming PTE or PMD size.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h |  8 ++------
 include/linux/mm.h      | 42 ++++++++++++++++++++---------------------
 2 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f280f33ff223..b70318fe7863 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -257,9 +257,7 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 static inline unsigned int thp_order(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	if (PageHead(page))
-		return HPAGE_PMD_ORDER;
-	return 0;
+	return compound_order(page);
 }
 
 /**
@@ -269,9 +267,7 @@ static inline unsigned int thp_order(struct page *page)
 static inline int thp_nr_pages(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	if (PageHead(page))
-		return HPAGE_PMD_NR;
-	return 1;
+	return compound_nr(page);
 }
 
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 24c2b4b97176..0c7cf52619bd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -715,6 +715,27 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+static inline unsigned int compound_order(struct page *page)
+{
+	if (!PageHead(page))
+		return 0;
+	return page[1].compound_order;
+}
+
+/* Returns the number of pages in this potentially compound page. */
+static inline unsigned long compound_nr(struct page *page)
+{
+	if (!PageHead(page))
+		return 1;
+	return page[1].compound_nr;
+}
+
+static inline void set_compound_order(struct page *page, unsigned int order)
+{
+	page[1].compound_order = order;
+	page[1].compound_nr = 1U << order;
+}
+
 #include <linux/huge_mm.h>
 
 /*
@@ -936,13 +957,6 @@ static inline void destroy_compound_page(struct page *page)
 	compound_page_dtors[page[1].compound_dtor](page);
 }
 
-static inline unsigned int compound_order(struct page *page)
-{
-	if (!PageHead(page))
-		return 0;
-	return page[1].compound_order;
-}
-
 /**
  * folio_order - The allocation order of a folio.
  * @folio: The folio.
@@ -980,20 +994,6 @@ static inline int compound_pincount(struct page *page)
 	return head_compound_pincount(page);
 }
 
-static inline void set_compound_order(struct page *page, unsigned int order)
-{
-	page[1].compound_order = order;
-	page[1].compound_nr = 1U << order;
-}
-
-/* Returns the number of pages in this potentially compound page. */
-static inline unsigned long compound_nr(struct page *page)
-{
-	if (!PageHead(page))
-		return 1;
-	return page[1].compound_nr;
-}
-
 /* Returns the number of bytes in this potentially compound page. */
 static inline unsigned long page_size(struct page *page)
 {
-- 
2.30.2

