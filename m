Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A843C41FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhGLDio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhGLDio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:38:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B0C0613DD;
        Sun, 11 Jul 2021 20:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=S04dDMrMIzfangXtNut/66Qz1gSGH9EBYIsvxlfCWBc=; b=slF3p+z8+cUPOA8vVHISFQ0pdv
        jZy4f6mgLoBEkIpkwBLgm24tDEOJkJi2vXTbUILmqICVPOu8ArPSuhG8LBrzhOBNKF7ICAMkzUVkH
        rbrldt0FCOaqNJ2GXF+dUun2q+vehLYZy8MroiMS3LWJkI3qAxZ1sZYR4xxZJ4mJjz9zubj9a91Tj
        c6AmtBOFJX4AmHOMJDm9skqnBQjLCFsjkp/UIm5jN9DrhLEKzmMZ5nUgOo2L81cF92nHNVhoq/BDU
        EHpdQiqqzFfZsSLXBvF485qDQ86J15YfLEqrztGMyR/nQvbTapTFeJziCNd41wUcGa+lxuCsXWM7s
        dF3yZblg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2miY-00Gois-LR; Mon, 12 Jul 2021 03:35:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 052/137] mm: Add folio_raw_mapping()
Date:   Mon, 12 Jul 2021 04:05:36 +0100
Message-Id: <20210712030701.4000097-53-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index 0c65b260cded..48d843165a1a 100644
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

