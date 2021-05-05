Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588A9373E7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhEEP1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhEEP1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:27:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39379C061574;
        Wed,  5 May 2021 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uN97v29/9OXao1BbJhRfG/cHRIY8UKsDV+V8TJG7abk=; b=lj4rlFNsCupC9IaynlJ7n7SKRa
        ZX/CL15P1QWDWp7/X7hhtcV92Vn9/0aEOJLSWeDDH8hQAu/FkzK00HkMja00S+ke+sDARyXXM3Ql+
        yb4AEvg1l9e6WALAaM06JImPwR5imatWfj5plzapaUbp6nycFGKjwfCqmEOdXlLGMgB4zy8xMCUlS
        kRRs4t7vhexKxnXluIpUMEPcPzdmJlp3aksPhIeGxSaUXjWaoun0kS1k4LkOhSjkb3rYEk64D6d5e
        sJq5TVyT8L7MfzUABT4lnzxzVsEF1RQntioYTuuncnPdQKBRIS8vMec51IEEXdyi0wEDIGaNP4U2q
        gRIZ/pPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJOn-000Uve-DK; Wed, 05 May 2021 15:25:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 17/96] mm: Add folio_young() and folio_idle()
Date:   Wed,  5 May 2021 16:05:09 +0100
Message-Id: <20210505150628.111735-18-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index 1e894d34bdce..bd957e818558 100644
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
+static inline void folio_set_young_flag(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext = lookup_page_ext(&folio->page);
 
 	if (unlikely(!page_ext))
 		return;
@@ -65,9 +35,9 @@ static inline void set_page_young(struct page *page)
 	set_bit(PAGE_EXT_YOUNG, &page_ext->flags);
 }
 
-static inline bool test_and_clear_page_young(struct page *page)
+static inline bool folio_test_clear_young_flag(struct folio *folio)
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
+static inline void folio_set_idle_flag(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext = lookup_page_ext(&folio->page);
 
 	if (unlikely(!page_ext))
 		return;
@@ -95,46 +65,75 @@ static inline void set_page_idle(struct page *page)
 	set_bit(PAGE_EXT_IDLE, &page_ext->flags);
 }
 
-static inline void clear_page_idle(struct page *page)
+static inline void folio_clear_idle_flag(struct folio *folio)
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
+static inline void folio_set_young_flag(struct folio *folio)
 {
 }
 
-static inline bool test_and_clear_page_young(struct page *page)
+static inline bool folio_test_clear_young_flag(struct folio *folio)
 {
 	return false;
 }
 
-static inline bool page_is_idle(struct page *page)
+static inline bool folio_idle(struct folio *folio)
 {
 	return false;
 }
 
-static inline void set_page_idle(struct page *page)
+static inline void folio_set_idle_flag(struct folio *folio)
 {
 }
 
-static inline void clear_page_idle(struct page *page)
+static inline void folio_clear_idle_flag(struct folio *folio)
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
+	folio_set_young_flag(page_folio(page));
+}
+
+static inline bool test_and_clear_page_young(struct page *page)
+{
+	return folio_test_clear_young_flag(page_folio(page));
+}
+
+static inline bool page_is_idle(struct page *page)
+{
+	return folio_idle(page_folio(page));
+}
+
+static inline void set_page_idle(struct page *page)
+{
+	folio_set_idle_flag(page_folio(page));
+}
+
+static inline void clear_page_idle(struct page *page)
+{
+	folio_clear_idle_flag(page_folio(page));
+}
 #endif /* _LINUX_MM_PAGE_IDLE_H */
-- 
2.30.2

