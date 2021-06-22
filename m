Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65563B0422
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhFVMVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhFVMVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:21:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D3DC061574;
        Tue, 22 Jun 2021 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2lIACpBDXhR9UMzEVkRUjHVrgl0kNtJLTDuzoYDq1Tc=; b=jh6uB9KQf3e90PTtC87rtTAsB+
        kGfKldlqET7gvifMtXeXzG+gEZafJdKXkEglCGs/PbPtAUAcE4w8Ztq9KGb8xDXFc8Aqk4f5Kt0RL
        oIwJ0Z5K3sxy6LICIVoxHQQwWwdSSQMUflFWFvdBfDF2DpagRSD+y9sJndTvfz1cR1nPIGvx2E0MY
        jvRgRQq/YozhtcRvcBsIe/0cCuMYcipfogGTxvGyJTpNJpHk6AxM8iMCPz5U300ISKhgsqPsJrfrB
        56JK8jh7+wPOZxutBbfwm2LQ2ssc5SyjeSeJv5Fh0WSCqh4yPWYEAXAhHVtitDsB91ZniKV5XE/6Q
        DGEw867g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfLy-00EGMD-GM; Tue, 22 Jun 2021 12:18:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/46] mm: Add folio_rmapping()
Date:   Tue, 22 Jun 2021 13:15:07 +0100
Message-Id: <20210622121551.3398730-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert __page_rmapping to folio_rmapping and move it to mm/internal.h.
It's only a couple of instructions (load and mask), so it's definitely
going to be cheaper to inline it than call it.  Leave page_rmapping
out of line.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h |  7 +++++++
 mm/util.c     | 20 ++++----------------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 76ddcf55012c..3e70121c71c7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -34,6 +34,13 @@
 
 void page_writeback_init(void);
 
+static inline void *folio_rmapping(struct folio *folio)
+{
+	unsigned long mapping = (unsigned long)folio->mapping;
+
+	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
+}
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 
diff --git a/mm/util.c b/mm/util.c
index a8766e7f1b7f..0ba3a56c2c90 100644
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
+	return folio_rmapping(page_folio(page));
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
+	return folio_rmapping(folio);
 }
 
 /**
-- 
2.30.2

