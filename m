Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1803CAD96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbhGOULU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242027AbhGOULT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:11:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA79C061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YnFXoc4cznHKZojXibwmEBdTqWwEducieNxXhTy+6a0=; b=FXVFYVHDsB5smuNlcd625TWwdm
        5xVdx3ZChBA71oeMgr8ib+48nDTdQlzhNHNMIGJtkPUjTIdXPC7aY5/yCFrcuyNlskeuRCNGJCgBV
        3OxNjuLQkDmNeQxWPWXNwbNr6Ft4wXULdkyKKCDkHsNFv0PHTa/SyZoY8QMSiBi63E1GXnplRk3Gj
        CtwT2TfU91s+p5gefYyjRoC3dX1No77vPJSZkgWOyDBblzW24uxk7OGRUkvJFqViO2fVu0o49hrFF
        N/sE/Xir85CeL+JYtdx35PoIBEhckLE0OAOKlaArCA2GqXAN8TrFDbwzjBmMIEnLnmkhXUXS5HOyr
        4oBUIdpA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m47dF-003mhh-Dq; Thu, 15 Jul 2021 20:07:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 06/39] mm: Add folio_young and folio_idle
Date:   Thu, 15 Jul 2021 20:59:57 +0100
Message-Id: <20210715200030.899216-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Idle page tracking is handled through page_ext on 32-bit architectures.
Add folio equivalents for 32-bit and move all the page compatibility
parts to common code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/page_idle.h | 99 +++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 50 deletions(-)

diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index 1e894d34bdce..1bcb1365b1d0 100644
--- a/include/linux/page_idle.h
+++ b/include/linux/page_idle.h
@@ -8,46 +8,16 @@
 
 #ifdef CONFIG_IDLE_PAGE_TRACKING
 
-#ifdef CONFIG_64BIT
-static inline bool page_is_young(struct page *page)
-{
-	return PageYoung(page);
-}
-
-static inline void set_page_young(struct page *page)
-{
-	SetPageYoung(page);
-}
-
-static inline bool test_and_clear_page_young(struct page *page)
-{
-	return TestClearPageYoung(page);
-}
-
-static inline bool page_is_idle(struct page *page)
-{
-	return PageIdle(page);
-}
-
-static inline void set_page_idle(struct page *page)
-{
-	SetPageIdle(page);
-}
-
-static inline void clear_page_idle(struct page *page)
-{
-	ClearPageIdle(page);
-}
-#else /* !CONFIG_64BIT */
+#ifndef CONFIG_64BIT
 /*
  * If there is not enough space to store Idle and Young bits in page flags, use
  * page ext flags instead.
  */
 extern struct page_ext_operations page_idle_ops;
 
-static inline bool page_is_young(struct page *page)
+static inline bool folio_test_young(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext = lookup_page_ext(&folio->page);
 
 	if (unlikely(!page_ext))
 		return false;
@@ -55,9 +25,9 @@ static inline bool page_is_young(struct page *page)
 	return test_bit(PAGE_EXT_YOUNG, &page_ext->flags);
 }
 
-static inline void set_page_young(struct page *page)
+static inline void folio_set_young(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext = lookup_page_ext(&folio->page);
 
 	if (unlikely(!page_ext))
 		return;
@@ -65,9 +35,9 @@ static inline void set_page_young(struct page *page)
 	set_bit(PAGE_EXT_YOUNG, &page_ext->flags);
 }
 
-static inline bool test_and_clear_page_young(struct page *page)
+static inline bool folio_test_clear_young(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext = lookup_page_ext(&folio->page);
 
 	if (unlikely(!page_ext))
 		return false;
@@ -75,9 +45,9 @@ static inline bool test_and_clear_page_young(struct page *page)
 	return test_and_clear_bit(PAGE_EXT_YOUNG, &page_ext->flags);
 }
 
-static inline bool page_is_idle(struct page *page)
+static inline bool folio_test_idle(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext = lookup_page_ext(&folio->page);
 
 	if (unlikely(!page_ext))
 		return false;
@@ -85,9 +55,9 @@ static inline bool page_is_idle(struct page *page)
 	return test_bit(PAGE_EXT_IDLE, &page_ext->flags);
 }
 
-static inline void set_page_idle(struct page *page)
+static inline void folio_set_idle(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext = lookup_page_ext(&folio->page);
 
 	if (unlikely(!page_ext))
 		return;
@@ -95,46 +65,75 @@ static inline void set_page_idle(struct page *page)
 	set_bit(PAGE_EXT_IDLE, &page_ext->flags);
 }
 
-static inline void clear_page_idle(struct page *page)
+static inline void folio_clear_idle(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext = lookup_page_ext(&folio->page);
 
 	if (unlikely(!page_ext))
 		return;
 
 	clear_bit(PAGE_EXT_IDLE, &page_ext->flags);
 }
-#endif /* CONFIG_64BIT */
+#endif /* !CONFIG_64BIT */
 
 #else /* !CONFIG_IDLE_PAGE_TRACKING */
 
-static inline bool page_is_young(struct page *page)
+static inline bool folio_test_young(struct folio *folio)
 {
 	return false;
 }
 
-static inline void set_page_young(struct page *page)
+static inline void folio_set_young(struct folio *folio)
 {
 }
 
-static inline bool test_and_clear_page_young(struct page *page)
+static inline bool folio_test_clear_young(struct folio *folio)
 {
 	return false;
 }
 
-static inline bool page_is_idle(struct page *page)
+static inline bool folio_test_idle(struct folio *folio)
 {
 	return false;
 }
 
-static inline void set_page_idle(struct page *page)
+static inline void folio_set_idle(struct folio *folio)
 {
 }
 
-static inline void clear_page_idle(struct page *page)
+static inline void folio_clear_idle(struct folio *folio)
 {
 }
 
 #endif /* CONFIG_IDLE_PAGE_TRACKING */
 
+static inline bool page_is_young(struct page *page)
+{
+	return folio_test_young(page_folio(page));
+}
+
+static inline void set_page_young(struct page *page)
+{
+	folio_set_young(page_folio(page));
+}
+
+static inline bool test_and_clear_page_young(struct page *page)
+{
+	return folio_test_clear_young(page_folio(page));
+}
+
+static inline bool page_is_idle(struct page *page)
+{
+	return folio_test_idle(page_folio(page));
+}
+
+static inline void set_page_idle(struct page *page)
+{
+	folio_set_idle(page_folio(page));
+}
+
+static inline void clear_page_idle(struct page *page)
+{
+	folio_clear_idle(page_folio(page));
+}
 #endif /* _LINUX_MM_PAGE_IDLE_H */
-- 
2.30.2

