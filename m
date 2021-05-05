Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F9C373F1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhEEQBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbhEEQBy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:01:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBEDC061574;
        Wed,  5 May 2021 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oVPeo/1eyCIP/suESTeKyctz41j9g0cex7YKKkrVPKQ=; b=RysEn5fK/Xx8ATWOD25wm6Kh3q
        GlbTNVSJ5WsPFcOQUgbSh2iA40dfUSGf5iztvJyDsR9UfhX0YJJo4ufQUEcJPhgwdrt3a2pP7AVHD
        q58hIXLNb3/vbxMfQOa2UMOhWua1mDmcM2Q1T0O2kfe2mTr4sC3LvllggCjTBbEwU6SzxPhFib0We
        ArE7s1laoXo/XzWPfZRjKkz7XijUeG3ViEGERD/jWWBG12k5o9bh195WJUbI33vk+SgR54N+jwsZC
        ok6+ZOCFx1UAjBR+oIKs2QhafWMwfuyEKGs60YY4t646WnxLsRwSSnghllkHTS9nc+vW3YDyd+yNo
        ehC3Ae3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJvm-000XZr-Nc; Wed, 05 May 2021 15:59:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 42/96] mm/swap: Add folio_activate
Date:   Wed,  5 May 2021 16:05:34 +0100
Message-Id: <20210505150628.111735-43-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This ends up being inlined into mark_page_accessed(), saving 70 bytes
of text.  It eliminates a lot of calls to compound_head(), but we still
have to pass a page to __activate_page() because pagevec_lru_move_fn()
takes a struct page.  That should be cleaned up eventually.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/swap.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 828889349b0b..07244999bcc6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -347,16 +347,16 @@ static bool need_activate_page_drain(int cpu)
 	return pagevec_count(&per_cpu(lru_pvecs.activate_page, cpu)) != 0;
 }
 
-static void activate_page(struct page *page)
+static void folio_activate(struct folio *folio)
 {
-	page = compound_head(page);
-	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
+	if (folio_lru(folio) && !folio_active(folio) &&
+	    !folio_unevictable(folio)) {
 		struct pagevec *pvec;
 
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
-		get_page(page);
-		if (pagevec_add_and_need_flush(pvec, page))
+		folio_get(folio);
+		if (pagevec_add_and_need_flush(pvec, &folio->page))
 			pagevec_lru_move_fn(pvec, __activate_page);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -367,16 +367,15 @@ static inline void activate_page_drain(int cpu)
 {
 }
 
-static void activate_page(struct page *page)
+static void folio_activate(struct folio *folio)
 {
 	struct lruvec *lruvec;
 
-	page = compound_head(page);
-	if (TestClearPageLRU(page)) {
-		lruvec = lock_page_lruvec_irq(page);
-		__activate_page(page, lruvec);
+	if (folio_test_clear_lru_flag(folio)) {
+		lruvec = folio_lock_lruvec_irq(folio);
+		__activate_page(&folio->page, lruvec);
 		unlock_page_lruvec_irq(lruvec);
-		SetPageLRU(page);
+		folio_set_lru_flag(folio);
 	}
 }
 #endif
@@ -441,7 +440,7 @@ void mark_page_accessed(struct page *page)
 		 * LRU on the next drain.
 		 */
 		if (PageLRU(page))
-			activate_page(page);
+			folio_activate(page_folio(page));
 		else
 			__lru_cache_activate_page(page);
 		ClearPageReferenced(page);
-- 
2.30.2

