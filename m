Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7E43C9862
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbhGOF3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGOF3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:29:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1D9C06175F;
        Wed, 14 Jul 2021 22:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ih/jlD7ckEePIBEtEqyFyU6U7BAhpCSlbvNH37tyxh8=; b=b5rnLKVPTKcdrUswNACQ1OF639
        khSgUwMgJl4M56i7DmZ/XLOZkViWJMkzRhKIR0uTmb2cjoU+70iJGXEPYICdT15E25jAHUe3+vsn9
        XwYSQB71/JuWB+a9AhbBXDlreLEpCOv2fpDEy4ZoJcuMUDam3hEfl4AzCkvlor0lEJU5Pk6udYd4H
        /ns3NoEm6AlN+uU1eK2xobpBk5tx7mxtIvbr4G7SZN5yhQTrv6hFb/d6jd42+WeoPGHhh/SPjLSqd
        sRVyWJs+z77/t0t41+aE19FpbraOGg+QZDu2H5rMKHTKRYWiu8up4xyqx+qFpErxJ07ePAP6mrHHY
        Zvg9DeNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3trx-00315s-Bv; Thu, 15 Jul 2021 05:25:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 134/138] mm: Support arbitrary THP sizes
Date:   Thu, 15 Jul 2021 04:37:00 +0100
Message-Id: <20210715033704.692967-135-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 99f5f736be64..df1f4c4976df 100644
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
@@ -937,13 +958,6 @@ static inline void destroy_compound_page(struct page *page)
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
@@ -981,20 +995,6 @@ static inline int compound_pincount(struct page *page)
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

