Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7B159FF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgBLESr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:18:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5fxK0+YFXSkJnTT1JbNUHf7Rkjo4ppyqzoiB3mODWTo=; b=UoKeR+uDs6mPf2KwwVwGp8Y8n7
        EZNJYoeThkt8fZ0c/Zl3wznWrJqQ+tE8q5Q1vB+D3kW99hjtNNmSiX3LMu/Qvb8rils17qJy6BQWU
        6pQPxQkv1QrXKwZlAY0jwvVoYYAU4AkXSB5DB+VzmvFIGphY1ZZRjpnD1dVkYQYzE+FkHxV/m13WW
        i735Pqrqr4igy2Jta9pUn3WREr4oFJH8PYtL7vCPdoYvObVwIpI4FxD8Eq5gesahTePe8Ncg1gijI
        /u5Dyjnwx3ObHccnydEVez2c+hVP2sWPTndWnQ0+X+pQ3QCeE9OPYHAiV9VSfWioHrFxcMPeiFERZ
        s9EjqAdw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU6-0006n2-OM; Wed, 12 Feb 2020 04:18:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/25] mm: Introduce thp_size
Date:   Tue, 11 Feb 2020 20:18:27 -0800
Message-Id: <20200212041845.25879-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This is like page_size(), but compiles down to just PAGE_SIZE if THP
are disabled.  Convert the users of hpage_nr_pages() which would prefer
this interface.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/nvdimm/btt.c    | 4 +---
 drivers/nvdimm/pmem.c   | 3 +--
 include/linux/huge_mm.h | 2 ++
 mm/internal.h           | 2 +-
 mm/page_io.c            | 2 +-
 mm/page_vma_mapped.c    | 4 ++--
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 0d04ea3d9fd7..5d6a2a22f5a0 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1488,10 +1488,8 @@ static int btt_rw_page(struct block_device *bdev, sector_t sector,
 {
 	struct btt *btt = bdev->bd_disk->private_data;
 	int rc;
-	unsigned int len;
 
-	len = hpage_nr_pages(page) * PAGE_SIZE;
-	rc = btt_do_bvec(btt, NULL, page, len, 0, op, sector);
+	rc = btt_do_bvec(btt, NULL, page, thp_size(page), 0, op, sector);
 	if (rc == 0)
 		page_endio(page, op_is_write(op), 0);
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4eae441f86c9..9c71c81f310f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -223,8 +223,7 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 	struct pmem_device *pmem = bdev->bd_queue->queuedata;
 	blk_status_t rc;
 
-	rc = pmem_do_bvec(pmem, page, hpage_nr_pages(page) * PAGE_SIZE,
-			  0, op, sector);
+	rc = pmem_do_bvec(pmem, page, thp_size(page), 0, op, sector);
 
 	/*
 	 * The ->rw_page interface is subtle and tricky.  The core
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 16367e2f771e..3680ae2d9019 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -232,6 +232,7 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 }
 
 #define hpage_nr_pages(page)	(long)compound_nr(page)
+#define thp_size(page)		page_size(page)
 
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
@@ -286,6 +287,7 @@ static inline struct list_head *page_deferred_list(struct page *page)
 #define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
 
 #define hpage_nr_pages(x) 1L
+#define thp_size(x)		PAGE_SIZE
 
 static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 41b93c4b3ab7..390d81d8b85f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -358,7 +358,7 @@ vma_address(struct page *page, struct vm_area_struct *vma)
 	unsigned long start, end;
 
 	start = __vma_address(page, vma);
-	end = start + PAGE_SIZE * (hpage_nr_pages(page) - 1);
+	end = start + thp_size(page) - PAGE_SIZE;
 
 	/* page should be within @vma mapping range */
 	VM_BUG_ON_VMA(end < vma->vm_start || start >= vma->vm_end, vma);
diff --git a/mm/page_io.c b/mm/page_io.c
index 76965be1d40e..dd935129e3cb 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -41,7 +41,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
 		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
 		bio->bi_end_io = end_io;
 
-		bio_add_page(bio, page, PAGE_SIZE * hpage_nr_pages(page), 0);
+		bio_add_page(bio, page, thp_size(page), 0);
 	}
 	return bio;
 }
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 719c35246cfa..e65629c056e8 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -227,7 +227,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			if (pvmw->address >= pvmw->vma->vm_end ||
 			    pvmw->address >=
 					__vma_address(pvmw->page, pvmw->vma) +
-					hpage_nr_pages(pvmw->page) * PAGE_SIZE)
+					thp_size(pvmw->page))
 				return not_found(pvmw);
 			/* Did we cross page table boundary? */
 			if (pvmw->address % PMD_SIZE == 0) {
@@ -268,7 +268,7 @@ int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma)
 	unsigned long start, end;
 
 	start = __vma_address(page, vma);
-	end = start + PAGE_SIZE * (hpage_nr_pages(page) - 1);
+	end = start + thp_size(page) - PAGE_SIZE;
 
 	if (unlikely(end < vma->vm_start || start >= vma->vm_end))
 		return 0;
-- 
2.25.0

