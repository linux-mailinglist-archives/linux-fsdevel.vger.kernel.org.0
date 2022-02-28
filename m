Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FFD4C631C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 07:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiB1GhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 01:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiB1Gg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:36:56 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C9F66CA0
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 22:36:18 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id w37so10576155pga.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 22:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5g/0QWFd98PH+GDbIHxo8Dsrvq3fGfzY+G57IkW5WS4=;
        b=HX8+nAEYjlfswBQ5nj4httJxCQA4BhPACV7BlZZAhSmNF0RdD2JCR6g8o4WwpkGQ/5
         hdB9bW1/6Cyhwei8IAElPg1nVq2znfvIiObfUNOK6N4Fyb5pxX7qE/pXvjnIyhIwL40E
         a9YCpF/qt8VRsYBdacCTFnwT6ah4GTtRXmr0c87QhDFiMpPed23MpSM5wpqu5sU/JMma
         bOFrDgqAx9BHJS8YWgjV21MrYg3L8NljxaWZJYlhOIQZeRKwCYTHSPMBssrX0cRnbhG8
         uHiOoTE4yCZESmFPEX3p+4dWs6VwKTJqUYTjUYYqBUeXPkcEzinYEyBSFitJIYZyk2mL
         NezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5g/0QWFd98PH+GDbIHxo8Dsrvq3fGfzY+G57IkW5WS4=;
        b=HyAVfkKtZAFebFv5wqXlQb8/v2CG3VnlPzYoyY5MiUy22aeNnYcQbwnZP+giKE6tT6
         xr6ok2fJBbkdWXsOacUMRHLbUFcyqnfxeKnDvt/mV1YSO0KX1lwUHpZGNfQXOquQ6eNw
         CVDnSP24XCbHYSWNzRHocarN9zB/zeHPOabuLjSZrAVsX3oTrwRoOikhy+HhZtLy1o42
         o1YinzCTv0Pxkr6KjIMdlVRIEpL/nunCHS8+KL4V8Re8HPBENwCTyylJkx02CIepraqY
         W2VafgaW8eF0ubpY1GLpreEQDfHwwl9VQaWGd9o9fZYwniWylFGoEdmoHO6h1L5HWyZw
         jxqg==
X-Gm-Message-State: AOAM533jFUvWZ4Bq5t0pLRUnOdPCrv8S44UiqmxXbfsjCO6Ki5xfqeIh
        TAL057388v829KH6GiETJeBkIA==
X-Google-Smtp-Source: ABdhPJypY+8lhMBAxJc6LX0WefVBcScVdW93PI4OxjW8x5PZWFmpys0R1IuEdZjE11NT+4jWvS1kBA==
X-Received: by 2002:a63:3e45:0:b0:378:c5a9:abd1 with SMTP id l66-20020a633e45000000b00378c5a9abd1mr167718pga.25.1646030177716;
        Sun, 27 Feb 2022 22:36:17 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b004f13804c100sm11126472pfg.165.2022.02.27.22.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 22:36:17 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 3/6] mm: rmap: introduce pfn_mkclean_range() to cleans PTEs
Date:   Mon, 28 Feb 2022 14:35:33 +0800
Message-Id: <20220228063536.24911-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228063536.24911-1-songmuchun@bytedance.com>
References: <20220228063536.24911-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The page_mkclean_one() is supposed to be used with the pfn that has a
associated struct page, but not all the pfns (e.g. DAX) have a struct
page. Introduce a new function pfn_mkclean_range() to cleans the PTEs
(including PMDs) mapped with range of pfns which has no struct page
associated with them. This helper will be used by DAX device in the
next patch to make pfns clean.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/rmap.h |  3 +++
 mm/internal.h        | 26 +++++++++++++--------
 mm/rmap.c            | 65 +++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 74 insertions(+), 20 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b58ddb8b2220..a6ec0d3e40c1 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -263,6 +263,9 @@ unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
  */
 int folio_mkclean(struct folio *);
 
+int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
+		      struct vm_area_struct *vma);
+
 void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
 
 /*
diff --git a/mm/internal.h b/mm/internal.h
index f45292dc4ef5..ff873944749f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -516,26 +516,22 @@ void mlock_page_drain(int cpu);
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
 /*
- * At what user virtual address is page expected in vma?
- * Returns -EFAULT if all of the page is outside the range of vma.
- * If page is a compound head, the entire compound page is considered.
+ * * Return the start of user virtual address at the specific offset within
+ * a vma.
  */
 static inline unsigned long
-vma_address(struct page *page, struct vm_area_struct *vma)
+vma_pgoff_address(pgoff_t pgoff, unsigned long nr_pages,
+		  struct vm_area_struct *vma)
 {
-	pgoff_t pgoff;
 	unsigned long address;
 
-	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
-	pgoff = page_to_pgoff(page);
 	if (pgoff >= vma->vm_pgoff) {
 		address = vma->vm_start +
 			((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		/* Check for address beyond vma (or wrapped through 0?) */
 		if (address < vma->vm_start || address >= vma->vm_end)
 			address = -EFAULT;
-	} else if (PageHead(page) &&
-		   pgoff + compound_nr(page) - 1 >= vma->vm_pgoff) {
+	} else if (pgoff + nr_pages - 1 >= vma->vm_pgoff) {
 		/* Test above avoids possibility of wrap to 0 on 32-bit */
 		address = vma->vm_start;
 	} else {
@@ -545,6 +541,18 @@ vma_address(struct page *page, struct vm_area_struct *vma)
 }
 
 /*
+ * Return the start of user virtual address of a page within a vma.
+ * Returns -EFAULT if all of the page is outside the range of vma.
+ * If page is a compound head, the entire compound page is considered.
+ */
+static inline unsigned long
+vma_address(struct page *page, struct vm_area_struct *vma)
+{
+	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
+	return vma_pgoff_address(page_to_pgoff(page), compound_nr(page), vma);
+}
+
+/*
  * Then at what user virtual address will none of the range be found in vma?
  * Assumes that vma_address() already returned a good starting address.
  */
diff --git a/mm/rmap.c b/mm/rmap.c
index 723682ddb9e8..ad5cf0e45a73 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -929,12 +929,12 @@ int folio_referenced(struct folio *folio, int is_locked,
 	return pra.referenced;
 }
 
-static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
-			    unsigned long address, void *arg)
+static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
 {
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_SYNC);
+	int cleaned = 0;
+	struct vm_area_struct *vma = pvmw->vma;
 	struct mmu_notifier_range range;
-	int *cleaned = arg;
+	unsigned long address = pvmw->address;
 
 	/*
 	 * We have to assume the worse case ie pmd for invalidation. Note that
@@ -942,16 +942,16 @@ static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
 	 */
 	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
 				0, vma, vma->vm_mm, address,
-				vma_address_end(&pvmw));
+				vma_address_end(pvmw));
 	mmu_notifier_invalidate_range_start(&range);
 
-	while (page_vma_mapped_walk(&pvmw)) {
+	while (page_vma_mapped_walk(pvmw)) {
 		int ret = 0;
 
-		address = pvmw.address;
-		if (pvmw.pte) {
+		address = pvmw->address;
+		if (pvmw->pte) {
 			pte_t entry;
-			pte_t *pte = pvmw.pte;
+			pte_t *pte = pvmw->pte;
 
 			if (!pte_dirty(*pte) && !pte_write(*pte))
 				continue;
@@ -964,7 +964,7 @@ static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
 			ret = 1;
 		} else {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			pmd_t *pmd = pvmw.pmd;
+			pmd_t *pmd = pvmw->pmd;
 			pmd_t entry;
 
 			if (!pmd_dirty(*pmd) && !pmd_write(*pmd))
@@ -991,11 +991,22 @@ static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
 		 * See Documentation/vm/mmu_notifier.rst
 		 */
 		if (ret)
-			(*cleaned)++;
+			cleaned++;
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
 
+	return cleaned;
+}
+
+static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
+			     unsigned long address, void *arg)
+{
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_SYNC);
+	int *cleaned = arg;
+
+	*cleaned += page_vma_mkclean_one(&pvmw);
+
 	return true;
 }
 
@@ -1033,6 +1044,38 @@ int folio_mkclean(struct folio *folio)
 EXPORT_SYMBOL_GPL(folio_mkclean);
 
 /**
+ * pfn_mkclean_range - Cleans the PTEs (including PMDs) mapped with range of
+ *                     [@pfn, @pfn + @nr_pages) at the specific offset (@pgoff)
+ *                     within the @vma of shared mappings. And since clean PTEs
+ *                     should also be readonly, write protects them too.
+ * @pfn: start pfn.
+ * @nr_pages: number of physically contiguous pages srarting with @pfn.
+ * @pgoff: page offset that the @pfn mapped with.
+ * @vma: vma that @pfn mapped within.
+ *
+ * Returns the number of cleaned PTEs (including PMDs).
+ */
+int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
+		      struct vm_area_struct *vma)
+{
+	struct page_vma_mapped_walk pvmw = {
+		.pfn		= pfn,
+		.nr_pages	= nr_pages,
+		.pgoff		= pgoff,
+		.vma		= vma,
+		.flags		= PVMW_SYNC,
+	};
+
+	if (invalid_mkclean_vma(vma, NULL))
+		return 0;
+
+	pvmw.address = vma_pgoff_address(pgoff, nr_pages, vma);
+	VM_BUG_ON_VMA(pvmw.address == -EFAULT, vma);
+
+	return page_vma_mkclean_one(&pvmw);
+}
+
+/**
  * page_move_anon_rmap - move a page to our anon_vma
  * @page:	the page to move to our anon_vma
  * @vma:	the vma the page belongs to
-- 
2.11.0

