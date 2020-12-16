Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FAF2DC638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgLPSYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbgLPSYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:24:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE4DC0617A6;
        Wed, 16 Dec 2020 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5Zi4DM0SCR/rLdJqqBOozfoB+4s1oEmMy46WhNZh64o=; b=bvqprScq9J0FSjYdSj/5KsUeu1
        VbATfLNW73/h7oM+8ANAyk4FodqWxTyv7DbKSwPayQ4qRtBM4JWrSNyyB4Id3EiVRQSCbDuTNk8hG
        IlXA8UL0TSPkCfRYLLHy7Zcj07Oex3hS0LOF2cY6s1a+T0TrFkYijTpv+jpGAUvhHoAPL6cHQSXdk
        sIPfmIQOmHZZA/X4iAigfCihDdDBCrDS6pnIC9c8J7PLgKCzkiUoLSS7VcuQ8bAqJ5oLQ7jLcJH9+
        shUg26MNd/DtJ1AJvY9iXaKsFcrZ6DPdFuCRIFHEOWGyaWwHUMo09Y2ewzxA0pr1k+isFV1XETb3j
        dtK6G8fg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSb-000765-BC; Wed, 16 Dec 2020 18:23:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/25] mm: Add get_folio
Date:   Wed, 16 Dec 2020 18:23:13 +0000
Message-Id: <20201216182335.27227-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call get_folio() instead of get_page()
and save the overhead of calling compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a9191dc250a6..02ccb7a09190 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1172,15 +1172,17 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 #define page_ref_zero_or_close_to_overflow(page) \
 	((unsigned int) page_ref_count(page) + 127u <= 127u)
 
+static inline void get_folio(struct folio *folio)
+{
+	/* Getting a page requires an already elevated page->_refcount. */
+	VM_BUG_ON_PAGE(page_ref_zero_or_close_to_overflow(&folio->page),
+			&folio->page);
+	page_ref_inc(&folio->page);
+}
+
 static inline void get_page(struct page *page)
 {
-	page = compound_head(page);
-	/*
-	 * Getting a normal page or the head of a compound page
-	 * requires to already have an elevated page->_refcount.
-	 */
-	VM_BUG_ON_PAGE(page_ref_zero_or_close_to_overflow(page), page);
-	page_ref_inc(page);
+	get_folio(page_folio(page));
 }
 
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
-- 
2.29.2

