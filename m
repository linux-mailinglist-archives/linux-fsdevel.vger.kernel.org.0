Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D871E735F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391844AbgE2DEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391633AbgE2C6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AC7C08C5C6;
        Thu, 28 May 2020 19:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YpNOcOmQ2EiLs3AdppJEAuW3m0dTwOL20RLpwBVbMOo=; b=aEfaBOfM4JhC4kP3HQDlPVA0L7
        7Yffsjt3lSI6NNyGjLyJkcUOJwJxg5sQ4tvNfWOjxIv7UJ2Td923Pdy+30Xh2/0a46AjpiXqaEWTH
        k3VjvlRpRsBNmnpdAxbY2235m94Hh/Ha/zpXecose30QfmvmlD7WLnQN5+XP9EqjIevmC3hHuGBUT
        SXB2qd+kHNX7yYu63WFbULj9bzPWq+ufkTtJW0W2Fsj1OlN6sR8BIYuByCt4AUat4SsH4e+nblg7C
        xVQyUOmlIvYUxWv1rsr3Mfg+gkkUn6CGh7xTP6NQ7I0gC5gWzbD/0sV0HJkJxM5w3X6k805uzE7YP
        FFoRGQ0Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE2-0008Pu-Nv; Fri, 29 May 2020 02:58:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v5 04/39] mm: Introduce thp_size
Date:   Thu, 28 May 2020 19:57:49 -0700
Message-Id: <20200529025824.32296-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
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
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 drivers/nvdimm/btt.c    | 4 +---
 drivers/nvdimm/pmem.c   | 6 ++----
 include/linux/huge_mm.h | 7 +++++++
 mm/internal.h           | 2 +-
 mm/page_io.c            | 2 +-
 mm/page_vma_mapped.c    | 4 ++--
 6 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 3b09419218d6..78e8d972d45a 100644
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
index 2df6994acf83..d511504d07af 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -235,11 +235,9 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 	blk_status_t rc;
 
 	if (op_is_write(op))
-		rc = pmem_do_write(pmem, page, 0, sector,
-				   hpage_nr_pages(page) * PAGE_SIZE);
+		rc = pmem_do_write(pmem, page, 0, sector, thp_size(page));
 	else
-		rc = pmem_do_read(pmem, page, 0, sector,
-				   hpage_nr_pages(page) * PAGE_SIZE);
+		rc = pmem_do_read(pmem, page, 0, sector, thp_size(page));
 	/*
 	 * The ->rw_page interface is subtle and tricky.  The core
 	 * retries on any error, so we can only invoke page_endio() in
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 6bec4b5b61e1..e944f9757349 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -271,6 +271,11 @@ static inline int hpage_nr_pages(struct page *page)
 	return compound_nr(page);
 }
 
+static inline unsigned long thp_size(struct page *page)
+{
+	return page_size(page);
+}
+
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
@@ -329,6 +334,8 @@ static inline int hpage_nr_pages(struct page *page)
 	return 1;
 }
 
+#define thp_size(x)		PAGE_SIZE
+
 static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
 	return false;
diff --git a/mm/internal.h b/mm/internal.h
index f762a34b0c57..5efb13d5c226 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -386,7 +386,7 @@ vma_address(struct page *page, struct vm_area_struct *vma)
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
2.26.2

