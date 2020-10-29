Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD8429F555
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgJ2TeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgJ2TeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A7C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=s1cCfqcsILzWonrmhPADFuQaWV/n44mIEDAgMnBPBWs=; b=GjtdCwcfhF/TVVIqPnUDC25++f
        BnD+8bDa4SOZWlnGoG3Ygs+kQnhqaxR+FPpm1Q9/3Izljt77lSRroTSVmH1B8H898vyRAPmXlXLbQ
        ee4kUxtRQH5hJpM+v3uC/KOo5Y1sI4U7rvfXDEuDOql7UQqlMI7ccJ0UMs3WZcwAooYnuQVqjvNkw
        Ar0YofCqerzlrNdX0ZQ9nci8/vB9jlzwQaBlmYUzxtx8suGfVO27aAHOlQe6m2gM39SSzEu+XJnOe
        yp39RaqKFYcT057V9xRdMwE4ABGftx9NKzrIQjaMOLwYHPu/St5IPisjwfYGIxtsk3bJmOwNgGJlC
        VU5KiK4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgW-0007bG-6y; Thu, 29 Oct 2020 19:34:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 03/19] mm: Support arbitrary THP sizes
Date:   Thu, 29 Oct 2020 19:33:49 +0000
Message-Id: <20201029193405.29125-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
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
index c2ecb6036ad8..60a907a19f7d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -272,9 +272,7 @@ static inline struct page *thp_head(struct page *page)
 static inline unsigned int thp_order(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	if (PageHead(page))
-		return HPAGE_PMD_ORDER;
-	return 0;
+	return compound_order(page);
 }
 
 /**
@@ -284,9 +282,7 @@ static inline unsigned int thp_order(struct page *page)
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
index 4e75f1c64534..3a73161a25a4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -685,6 +685,27 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
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
@@ -901,13 +922,6 @@ static inline void destroy_compound_page(struct page *page)
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
@@ -931,20 +945,6 @@ static inline int compound_pincount(struct page *page)
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
2.28.0

