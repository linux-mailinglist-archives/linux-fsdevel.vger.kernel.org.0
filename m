Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C9932E08E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCEETr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhCEETr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:19:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2236AC061574;
        Thu,  4 Mar 2021 20:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=d50BWWwyptEXh1B6An6n9AJNYi6qLn96OD0apF8yUVA=; b=ALmZiyAevE8ylgfKYrhR8VnqUL
        QIi7RhfS1Wv9c79tU1+Sda1hU6HUss0VHmRBPZTvQXfdaQXsQ0uTkXWnh+GR3mIdBqgucMiAqRO+S
        LkF6HBqm6gRgivRU3VGTXzO7R2LDruxqLqgmC/gHrnhNkCTSCUcmqW+gg84DSoVatxqDag/7eYIln
        zOHhrTLzwwZge5IE4I2XesegOaIDj/eBnR1MsT3USqjDB198Sr+eNOwrFMLQMybPq9ZNSpaUAf5FI
        P/JqEuT7x6zYrh7OIO3nw42N9lOa2BjBDpocerIyHMjdQ/LO6SO4sXDeCFtuT4Ad+pEio5CF8O7iF
        V7Ay+uqg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI1vx-00A3TP-GY; Fri, 05 Mar 2021 04:19:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v4 06/25] mm: Add get_folio
Date:   Fri,  5 Mar 2021 04:18:42 +0000
Message-Id: <20210305041901.2396498-7-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call get_folio() instead of get_page()
and save the overhead of calling compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mm.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 30fd431b1b05..4595955805f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1177,18 +1177,19 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 }
 
 /* 127: arbitrary random number, small enough to assemble well */
-#define page_ref_zero_or_close_to_overflow(page) \
-	((unsigned int) page_ref_count(page) + 127u <= 127u)
+#define folio_ref_zero_or_close_to_overflow(folio) \
+	((unsigned int) page_ref_count(&folio->page) + 127u <= 127u)
+
+static inline void get_folio(struct folio *folio)
+{
+	/* Getting a page requires an already elevated page->_refcount. */
+	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
+	page_ref_inc(&folio->page);
+}
 
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
2.30.0

