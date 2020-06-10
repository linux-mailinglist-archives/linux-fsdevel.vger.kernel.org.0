Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254281F5CDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgFJURb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbgFJUNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBF9C08C5C7;
        Wed, 10 Jun 2020 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=To8irju2/LINnhXcN1nryanQ2IhjjlZJW8yhv6eYHp0=; b=aQpqFIA5a558mRuswO/tjXDNEn
        CHb/HxwhlS9KyjDOKbpVv1YyD5U3BJFb0R/HHmy4xtop6G73Q+metDN8dyXElNUyr/i3IP5XFjOsu
        6vk2uqzdXcdPm+kEQPcb5ZWvc6AbfXXc6WoXf+te+SKLdkMNgpalGnvRWoGy8fpHp3dkZtVJ5ZKHR
        +qB5ebtCOIx/ATPsPtQatEc0ORAWmedZC6KVzqk3F08IFBY7Y7EX8xFu8AucLmeA+crs6Nt6dKP/e
        X7Xm1jeENjj3I0v44tyH7wXU2Gi+tZ+88MDYbxQ5RX/aQx5olU91P22O9yGZVq2wPrgKpXRdH0GkK
        FFlk/wqA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003UF-OB; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/51] mm: Support arbitrary THP sizes
Date:   Wed, 10 Jun 2020 13:13:07 -0700
Message-Id: <20200610201345.13273-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the compound size of the page instead of assuming PTE or PMD size.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h |  8 ++------
 include/linux/mm.h      | 42 ++++++++++++++++++++---------------------
 2 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index bd13e9ac3437..d125912a3e0d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -282,9 +282,7 @@ static inline struct page *thp_head(struct page *page)
 static inline unsigned int thp_order(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	if (PageHead(page))
-		return HPAGE_PMD_ORDER;
-	return 0;
+	return compound_order(page);
 }
 
 /**
@@ -294,9 +292,7 @@ static inline unsigned int thp_order(struct page *page)
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
index 3fc7e8121216..67b36b141ec7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -668,6 +668,27 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
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
@@ -879,13 +900,6 @@ static inline void destroy_compound_page(struct page *page)
 	compound_page_dtors[page[1].compound_dtor](page);
 }
 
-static inline unsigned int compound_order(struct page *page)
-{
-	if (!PageHead(page))
-		return 0;
-	return page[1].compound_order;
-}
-
 static inline bool hpage_pincount_available(struct page *page)
 {
 	/*
@@ -904,20 +918,6 @@ static inline int compound_pincount(struct page *page)
 	return atomic_read(compound_pincount_ptr(page));
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
2.26.2

