Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A833C9717
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhGOEWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbhGOEWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:22:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1EEC06175F;
        Wed, 14 Jul 2021 21:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TCeIycJ0VBmfdDjFJis4rziunkk2jYfcqWr47jM0A6w=; b=hX+LWden5mfIQEpU4c1BH7LtcA
        TwaU/4kB/cftZXp3G4h+JkzAY0mtabv/0MVUUEDj5zz4wis+cAGecPoIsmA7ETm/a4dc6FSBeiwgC
        86Pk1sr18zn5gSbTKZLro0He5niwpR/PKwe5E01clCTD32MQywfOoqGJP2fe5XscnbXVssn7P1g4G
        518vzLvh8/z9HtxRpauIzXpPtMT0pyyU17MKOfnRf6ABtAD6BNgrxdteQsRDWU+Lpw1mlPRvJjXWx
        0ZKDReH4lZplNBdwPHFqm76SmM7KSP2pzSIEJiMK1OVBEQVvjkElPJIhOJIgHkQgBtiJ6L1R8kIkg
        wIZtk6QA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3spO-002wkP-1W; Thu, 15 Jul 2021 04:18:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 052/138] mm: Add folio_raw_mapping()
Date:   Thu, 15 Jul 2021 04:35:38 +0100
Message-Id: <20210715033704.692967-53-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert __page_rmapping to folio_raw_mapping and move it to mm/internal.h.
It's only a couple of instructions (load and mask), so it's definitely
going to be cheaper to inline it than call it.  Leave page_rmapping
out of line.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h |  7 +++++++
 mm/util.c     | 20 ++++----------------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1a8851b73031..fa31a7f0ed79 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -34,6 +34,13 @@
 
 void page_writeback_init(void);
 
+static inline void *folio_raw_mapping(struct folio *folio)
+{
+	unsigned long mapping = (unsigned long)folio->mapping;
+
+	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
+}
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 
diff --git a/mm/util.c b/mm/util.c
index e8c12350b3eb..d0aa1d9c811e 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -635,21 +635,10 @@ void kvfree_sensitive(const void *addr, size_t len)
 }
 EXPORT_SYMBOL(kvfree_sensitive);
 
-static inline void *__page_rmapping(struct page *page)
-{
-	unsigned long mapping;
-
-	mapping = (unsigned long)page->mapping;
-	mapping &= ~PAGE_MAPPING_FLAGS;
-
-	return (void *)mapping;
-}
-
 /* Neutral page->mapping pointer to address_space or anon_vma or other */
 void *page_rmapping(struct page *page)
 {
-	page = compound_head(page);
-	return __page_rmapping(page);
+	return folio_raw_mapping(page_folio(page));
 }
 
 /**
@@ -680,13 +669,12 @@ EXPORT_SYMBOL(folio_mapped);
 
 struct anon_vma *page_anon_vma(struct page *page)
 {
-	unsigned long mapping;
+	struct folio *folio = page_folio(page);
+	unsigned long mapping = (unsigned long)folio->mapping;
 
-	page = compound_head(page);
-	mapping = (unsigned long)page->mapping;
 	if ((mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
 		return NULL;
-	return __page_rmapping(page);
+	return (void *)(mapping - PAGE_MAPPING_ANON);
 }
 
 /**
-- 
2.30.2

