Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4400A36FF82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 19:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhD3RaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 13:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3RaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:30:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D180C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 10:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fkHcdJvm5A3j2Mq4YEmesA1P+0SrgKTmkDpO5wJ0zB0=; b=JJdfOfYDEwTDrL9lD5qob+aOjc
        ek99IN0RvDUhPNi+v+OSQ400klNEVU4Vc6o5r1448r3au3rhVEEtwnM6VR76Btj/rk8bGA6iZg8nO
        dzCKMa7/XdhHzHQQqHbM39nGIEadyjtXsGYdT4qnsdf+7iw2WqXHYTGkMeDbIoFX/2n7XR4Q0O2HD
        P6yV34ZCDw+Bbr4F4d6cuI7B73aHIEW3wYusmgSINGJPhB2aoyazN/x9O3vTYRtqZetaFgR8Oz+J6
        fl7e4gvT4aa55tgeKik5wdmxatqwchMNnEBmbOurERP4xixmMMBcnbfyYesI0QrO4DverIy4hzWCz
        wt8xaqqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcWvh-00BJV2-4Q; Fri, 30 Apr 2021 17:28:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zi Yan <ziy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 07/27] mm: Add folio_get
Date:   Fri, 30 Apr 2021 18:22:15 +0100
Message-Id: <20210430172235.2695303-8-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430172235.2695303-1-willy@infradead.org>
References: <20210430172235.2695303-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call folio_get() instead
of get_page() and save the overhead of calling compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/mm.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 610948f0cb43..b133734a7530 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1219,18 +1219,26 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 }
 
 /* 127: arbitrary random number, small enough to assemble well */
-#define page_ref_zero_or_close_to_overflow(page) \
-	((unsigned int) page_ref_count(page) + 127u <= 127u)
+#define folio_ref_zero_or_close_to_overflow(folio) \
+	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
+
+/**
+ * folio_get - Increment the reference count on a folio.
+ * @folio: The folio.
+ *
+ * Context: May be called in any context, as long as you know that
+ * you have a refcount on the folio.  If you do not already have one,
+ * try_grab_page() may be the right interface for you to use.
+ */
+static inline void folio_get(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
+	folio_ref_inc(folio);
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
+	folio_get(page_folio(page));
 }
 
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
-- 
2.30.2

