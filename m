Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEEE1F5C7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgFJUNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbgFJUNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD356C08C5C4;
        Wed, 10 Jun 2020 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hN/37aRhgzzO2Cu+X3jM7dH/y9JI16FETpuj+qe6qfM=; b=QwUVdJWyV9AHqtytLyaTzSg1RZ
        kKswsI3XPSy5+PmHAHPn+IveskrPZkD0lYCK/fdORj5YqbXlf8G6s9Dof2YbI9MRAN3tsIrsZ96hG
        E0lGakXh9umHZL1X9hL/6QIHgX7aSvFrNX1RHgeLvolIXInjJ6egbVKpwLEFNH63bsxx509TgCDSW
        ZaLRdHZgqSQWM9FR2vOjSaENRdjvsgKbDYKoBNjlrM+yEufRk1DOREwTa365Q4gtnmVDNgpltmZUz
        uxeHZCGRVQQrkch+HQL0YIX8PCkPYLG5c2mwiIqeed6eILT99YYWw96fyldiEh4vXfC/g956oIZkE
        Llbi9A2A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003Tn-J6; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/51] mm: Add thp_size
Date:   Wed, 10 Jun 2020 13:13:03 -0700
Message-Id: <20200610201345.13273-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

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
index 90c0c4bbe77b..7255cfe6ebe2 100644
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
index d1ecd6da11a2..d1999c266b20 100644
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
2.26.2

