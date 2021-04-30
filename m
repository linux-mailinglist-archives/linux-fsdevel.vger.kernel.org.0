Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E478C370049
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhD3SQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhD3SQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:16:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320A3C06138C
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZMwx6iT9HbZnBuHHx4Juc8/b38WiZBARqT8KThLHIKA=; b=geCM3fA6GgD0AxzdHkhuvOuznq
        s6VRZNcAqCoOw1vgW5vOrXlAL/Yz70PrfHG5aD2FKQlzVoiIwxo19S4cVK4nyf1I/IM3xGM0GURDU
        FkdHzwQwpOUInjUg2WxfQA4f/0zZDsSAHZIxwy8g8SKFJlO4Ne00G+Z6IKmyA2cSer5EfFtd+NUc3
        4BYVqDRrbvLD7ep40PDpb1tmijIZV8zVAn/fTtnsxIU6eiE9lC+TsrdPYkivdwEnJpe7V8abbdmi2
        +J3Z3KtCHLKw89e7Dd/uSeegYVF8XfedPB/x1HYyOUcEnu1HuxXvUq9XzaWrygtIv+nLz2YG0USZ4
        tHjjwx8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXet-00BMgA-Sx; Fri, 30 Apr 2021 18:15:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v8 09/31] mm: Add folio_young() and folio_idle()
Date:   Fri, 30 Apr 2021 19:07:18 +0100
Message-Id: <20210430180740.2707166-10-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Idle page tracking is handled through page_ext for 32-bit.  Add folio
equivalents for 32 bit and move all the page compatibility parts to
common code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page_idle.h | 99 +++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 50 deletions(-)

diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index 1e894d34bdce..9693d1a93781 100644
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
+static inline bool folio_young(struct folio *folio)
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
+static inline bool folio_idle(struct folio *folio)
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
+static inline bool folio_young(struct folio *folio)
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
+static inline bool folio_idle(struct folio *folio)
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
+	return folio_young(page_folio(page));
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
+	return folio_idle(page_folio(page));
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

