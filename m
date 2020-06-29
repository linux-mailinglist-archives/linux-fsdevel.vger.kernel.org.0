Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF1E20E329
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390429AbgF2VMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbgF2S5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:44 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7686AC03078D
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=95SdqjJoDQdl+TmMfghj+EInmiqVZjpeZ41IZZkKIFw=; b=cdgFw+PGplwvdsjA4yReFKfDS8
        QmUXTteUskh5S4DUFQj2It8bp9/nLy3lAbcU6OloVXreaiFdSpQvbRDOeLi34gzUh8wX2ICGUWvKD
        VRYo2WIdALhG7nSDPzmp/+AkiefhGNP/ivsuJuMk/2AtiHagQ4mILZKIBNaXKRLb2vEbqUtAiPRmC
        bhT1LQ+TcGTZbk44qbPTGoEGzCfdGA3Cyo0nXMYl00au3qTI5zvodscLGwuzj1cqFm16agTzf8PEU
        KTDC/kgsLVXdX5PBs1NXuAvOo1mEAO81O0cH3C7YbcypMWkuMFj+RLUTLVFb5HfKw3EEDnW+ESOqm
        tAVyyofA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpvZo-0004CM-K3; Mon, 29 Jun 2020 15:20:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 4/7] mm: Add thp_size
Date:   Mon, 29 Jun 2020 16:19:56 +0100
Message-Id: <20200629151959.15779-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629151959.15779-1-willy@infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function returns the number of bytes in a THP.  It is like
page_size(), but compiles to just PAGE_SIZE if CONFIG_TRANSPARENT_HUGEPAGE
is disabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/nvdimm/btt.c    |  4 +---
 drivers/nvdimm/pmem.c   |  6 ++----
 include/linux/huge_mm.h | 11 +++++++++++
 mm/internal.h           |  2 +-
 mm/page_io.c            |  2 +-
 mm/page_vma_mapped.c    |  4 ++--
 6 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 48e9d169b6f9..92f25b9e1483 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1490,10 +1490,8 @@ static int btt_rw_page(struct block_device *bdev, sector_t sector,
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
index d25e66fd942d..d5e86ae144e3 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -238,11 +238,9 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
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
index dd19720a8bc2..0ec3b5a73d38 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -469,4 +469,15 @@ static inline bool thp_migration_supported(void)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+/**
+ * thp_size - Size of a transparent huge page.
+ * @page: Head page of a transparent huge page.
+ *
+ * Return: Number of bytes in this page.
+ */
+static inline unsigned long thp_size(struct page *page)
+{
+	return PAGE_SIZE << thp_order(page);
+}
+
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/mm/internal.h b/mm/internal.h
index 9886db20d94f..de9f1d0ba5fc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -395,7 +395,7 @@ vma_address(struct page *page, struct vm_area_struct *vma)
 	unsigned long start, end;
 
 	start = __vma_address(page, vma);
-	end = start + PAGE_SIZE * (hpage_nr_pages(page) - 1);
+	end = start + thp_size(page) - PAGE_SIZE;
 
 	/* page should be within @vma mapping range */
 	VM_BUG_ON_VMA(end < vma->vm_start || start >= vma->vm_end, vma);
diff --git a/mm/page_io.c b/mm/page_io.c
index e8726f3e3820..888000d1a8cc 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -40,7 +40,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
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
2.27.0

