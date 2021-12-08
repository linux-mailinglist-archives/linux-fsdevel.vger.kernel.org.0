Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A5846CC58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbhLHE0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240029AbhLHE0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128DDC061756
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Yp6HjXN/gjhhCCnIC8blGjRGkTqUSfJsyt3heH3EC8Q=; b=THifieJp3/uon84a99kjw6IH+n
        MN7o5exK542sKTyQ+ZuUo1jf4ak7AKw1lsrkntvRfE1J26t+NVueZpBxWeYoPsAIggZpbhJcBGTqa
        B7u6JazNWOSyrftVJTgDYXQXNQiKc/cqaP+IGI5tl1yX1zOY9a7blWPijuUWqrLr/W595Da2q+a+0
        1gFnSTUD6XgbKUx/95U6Wi6pgv9JBRpoTlM1zFoYGDCMM6JrKuJdD8wnDRbOITOo0yjAlBq5CA5i6
        B33Z0kIm4CQOfU9KaYt7FocF83GzZ+CY+81kpGuS3ZCfkkBFdSjFAOgHKa8S33nkyHFTHonwW59xZ
        TfEoC5Bg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU2-0084XE-BD; Wed, 08 Dec 2021 04:23:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 08/48] mm: Add folio_test_pmd_mappable()
Date:   Wed,  8 Dec 2021 04:22:16 +0000
Message-Id: <20211208042256.1923824-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a predicate to determine if the folio might be mapped by a PMD entry.
If CONFIG_TRANSPARENT_HUGEPAGE is disabled, we know it can't be, even
if it's large enough.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h | 14 ++++++++++++++
 include/linux/mm.h      | 42 ++++++++++++++++++++---------------------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f280f33ff223..e4c18ba8d3bf 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -274,6 +274,15 @@ static inline int thp_nr_pages(struct page *page)
 	return 1;
 }
 
+/**
+ * folio_test_pmd_mappable - Can we map this folio with a PMD?
+ * @folio: The folio to test
+ */
+static inline bool folio_test_pmd_mappable(struct folio *folio)
+{
+	return folio_order(folio) >= HPAGE_PMD_ORDER;
+}
+
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
@@ -339,6 +348,11 @@ static inline int thp_nr_pages(struct page *page)
 	return 1;
 }
 
+static inline bool folio_test_pmd_mappable(struct folio *folio)
+{
+	return false;
+}
+
 static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
 	return false;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..72ca04f16711 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -714,6 +714,27 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+static inline unsigned int compound_order(struct page *page)
+{
+	if (!PageHead(page))
+		return 0;
+	return page[1].compound_order;
+}
+
+/**
+ * folio_order - The allocation order of a folio.
+ * @folio: The folio.
+ *
+ * A folio is composed of 2^order pages.  See get_order() for the definition
+ * of order.
+ *
+ * Return: The order of the folio.
+ */
+static inline unsigned int folio_order(struct folio *folio)
+{
+	return compound_order(&folio->page);
+}
+
 #include <linux/huge_mm.h>
 
 /*
@@ -906,27 +927,6 @@ static inline void destroy_compound_page(struct page *page)
 	compound_page_dtors[page[1].compound_dtor](page);
 }
 
-static inline unsigned int compound_order(struct page *page)
-{
-	if (!PageHead(page))
-		return 0;
-	return page[1].compound_order;
-}
-
-/**
- * folio_order - The allocation order of a folio.
- * @folio: The folio.
- *
- * A folio is composed of 2^order pages.  See get_order() for the definition
- * of order.
- *
- * Return: The order of the folio.
- */
-static inline unsigned int folio_order(struct folio *folio)
-{
-	return compound_order(&folio->page);
-}
-
 static inline bool hpage_pincount_available(struct page *page)
 {
 	/*
-- 
2.33.0

