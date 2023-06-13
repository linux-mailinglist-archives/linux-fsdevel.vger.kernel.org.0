Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744B872E837
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 18:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbjFMQKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbjFMQKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:10:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBB961985;
        Tue, 13 Jun 2023 09:10:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AE202F4;
        Tue, 13 Jun 2023 09:10:48 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AB803F5A1;
        Tue, 13 Jun 2023 09:10:02 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 1/2] mm: /proc/pid/smaps: Report large folio mappings
Date:   Tue, 13 Jun 2023 17:09:49 +0100
Message-Id: <20230613160950.3554675-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613160950.3554675-1-ryan.roberts@arm.com>
References: <20230613160950.3554675-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the addition of large folios for page cache pages, it is useful to
see which orders of folios are being mapped into a process.
Additionally, with planned future improvements to allocate large folios
for anonymous memory this will become even more useful. Visibility will
help to tune performance.

New fields "AnonContXXX" and "FileContXXX" indicate physically
contiguous runs of memory, binned into power-of-2 sizes starting with
the page size and ending with the pmd size. Therefore the exact set of
keys will vary by platform. It only includes pte-mapped memory and
reports on anonymous and file-backed memory separately.

Rollup Example:

aaaac9960000-ffffddfdd000 ---p 00000000 00:00 0                 [rollup]
Rss:               10852 kB
...
AnonCont4K:         3480 kB
AnonCont8K:            0 kB
AnonCont16K:           0 kB
AnonCont32K:           0 kB
AnonCont64K:           0 kB
AnonCont128K:          0 kB
AnonCont256K:          0 kB
AnonCont512K:          0 kB
AnonCont1M:            0 kB
AnonCont2M:            0 kB
FileCont4K:         3060 kB
FileCont8K:           40 kB
FileCont16K:        3792 kB
FileCont32K:         160 kB
FileCont64K:         320 kB
FileCont128K:          0 kB
FileCont256K:          0 kB
FileCont512K:          0 kB
FileCont1M:            0 kB
FileCont2M:            0 kB

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/filesystems/proc.rst |  26 +++++++
 fs/proc/task_mmu.c                 | 115 +++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 7897a7dafcbc..5fa3f638848d 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -471,6 +471,26 @@ Memory Area, or VMA) there is a series of lines such as the following::
     KernelPageSize:        4 kB
     MMUPageSize:           4 kB
     Locked:                0 kB
+    AnonCont4K:            0 kB
+    AnonCont8K:            0 kB
+    AnonCont16K:           0 kB
+    AnonCont32K:           0 kB
+    AnonCont64K:           0 kB
+    AnonCont128K:          0 kB
+    AnonCont256K:          0 kB
+    AnonCont512K:          0 kB
+    AnonCont1M:            0 kB
+    AnonCont2M:            0 kB
+    FileCont4K:          348 kB
+    FileCont8K:            0 kB
+    FileCont16K:          32 kB
+    FileCont32K:           0 kB
+    FileCont64K:         512 kB
+    FileCont128K:          0 kB
+    FileCont256K:          0 kB
+    FileCont512K:          0 kB
+    FileCont1M:            0 kB
+    FileCont2M:            0 kB
     THPeligible:           0
     VmFlags: rd ex mr mw me dw
 
@@ -524,6 +544,12 @@ replaced by copy-on-write) part of the underlying shmem object out on swap.
 does not take into account swapped out page of underlying shmem objects.
 "Locked" indicates whether the mapping is locked in memory or not.
 
+"AnonContXXX" and "FileContXXX" indicate physically contiguous runs of memory,
+binned into power-of-2 sizes starting with the page size and ending with the
+pmd size. Therefore the exact set of keys will vary by platform. It only
+includes pte-mapped memory and reports on anonymous and file-backed memory
+separately.
+
 "THPeligible" indicates whether the mapping is eligible for allocating THP
 pages as well as the THP is PMD mappable or not - 1 if true, 0 otherwise.
 It just shows the current status.
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 507cd4e59d07..29fee5b7b00b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -397,6 +397,49 @@ const struct file_operations proc_pid_maps_operations = {
 #define PSS_SHIFT 12
 
 #ifdef CONFIG_PROC_PAGE_MONITOR
+
+#define CONT_ORDER_MAX		(PMD_SHIFT-PAGE_SHIFT)
+#define CONT_LABEL_FIELD_SIZE	8
+#define CONT_LABEL_BUF_SIZE	32
+
+static char *cont_label(int order, char buf[CONT_LABEL_BUF_SIZE])
+{
+	unsigned long size = ((1UL << order) * PAGE_SIZE) >> 10;
+	char suffix = 'K';
+	int count;
+
+	if (size >= SZ_1K) {
+		size >>= 10;
+		suffix = 'M';
+	}
+
+	if (size >= SZ_1K) {
+		size >>= 10;
+		suffix = 'G';
+	}
+
+	count = snprintf(buf, CONT_LABEL_BUF_SIZE, "%lu%c:", size, suffix);
+
+	/*
+	 * If the string is less than the field size, pad it with spaces so that
+	 * the values line up in smaps.
+	 */
+	if (count < CONT_LABEL_FIELD_SIZE) {
+		memset(&buf[count], ' ', CONT_LABEL_FIELD_SIZE - count);
+		buf[CONT_LABEL_FIELD_SIZE] = '\0';
+	}
+
+	return buf;
+}
+
+struct cont_accumulator {
+	bool anon;
+	unsigned long folio_start_pfn;
+	unsigned long folio_end_pfn;
+	unsigned long next_pfn;
+	unsigned long nrpages;
+};
+
 struct mem_size_stats {
 	unsigned long resident;
 	unsigned long shared_clean;
@@ -419,8 +462,60 @@ struct mem_size_stats {
 	u64 pss_dirty;
 	u64 pss_locked;
 	u64 swap_pss;
+	unsigned long anon_cont[CONT_ORDER_MAX + 1];
+	unsigned long file_cont[CONT_ORDER_MAX + 1];
+	struct cont_accumulator cacc;
 };
 
+static void cacc_init(struct mem_size_stats *mss)
+{
+	struct cont_accumulator *cacc = &mss->cacc;
+
+	cacc->next_pfn = -1;
+	cacc->nrpages = 0;
+}
+
+static void cacc_drain(struct mem_size_stats *mss)
+{
+	struct cont_accumulator *cacc = &mss->cacc;
+	unsigned long *cont = cacc->anon ? mss->anon_cont : mss->file_cont;
+	unsigned long order;
+	unsigned long nrpages;
+
+	while (cacc->nrpages > 0) {
+		order = ilog2(cacc->nrpages);
+		nrpages = 1UL << order;
+		cacc->nrpages -= nrpages;
+		cont[order] += nrpages * PAGE_SIZE;
+	}
+}
+
+static void cacc_accumulate(struct mem_size_stats *mss, struct page *page)
+{
+	struct cont_accumulator *cacc = &mss->cacc;
+	unsigned long pfn = page_to_pfn(page);
+	bool anon = PageAnon(page);
+	struct folio *folio;
+	unsigned long start_pfn;
+
+	if (cacc->next_pfn == pfn && cacc->anon == anon &&
+	    pfn >= cacc->folio_start_pfn && pfn < cacc->folio_end_pfn) {
+		cacc->next_pfn++;
+		cacc->nrpages++;
+	} else {
+		cacc_drain(mss);
+
+		folio = page_folio(page);
+		start_pfn = page_to_pfn(&folio->page);
+
+		cacc->anon = anon;
+		cacc->folio_start_pfn = start_pfn;
+		cacc->folio_end_pfn = start_pfn + folio_nr_pages(folio);
+		cacc->next_pfn = pfn + 1;
+		cacc->nrpages = 1;
+	}
+}
+
 static void smaps_page_accumulate(struct mem_size_stats *mss,
 		struct page *page, unsigned long size, unsigned long pss,
 		bool dirty, bool locked, bool private)
@@ -473,6 +568,10 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 	if (young || page_is_young(page) || PageReferenced(page))
 		mss->referenced += size;
 
+	/* Accumulate physically contiguous map size information. */
+	if (!compound)
+		cacc_accumulate(mss, page);
+
 	/*
 	 * Then accumulate quantities that may depend on sharing, or that may
 	 * differ page-by-page.
@@ -622,6 +721,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			   struct mm_walk *walk)
 {
 	struct vm_area_struct *vma = walk->vma;
+	struct mem_size_stats *mss = walk->private;
 	pte_t *pte;
 	spinlock_t *ptl;
 
@@ -632,6 +732,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
+	cacc_init(mss);
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	if (!pte) {
 		walk->action = ACTION_AGAIN;
@@ -640,6 +741,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		smaps_pte_entry(pte, addr, walk);
 	pte_unmap_unlock(pte - 1, ptl);
+	cacc_drain(mss);
 out:
 	cond_resched();
 	return 0;
@@ -816,6 +918,9 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 	bool rollup_mode)
 {
+	int i;
+	char label[CONT_LABEL_BUF_SIZE];
+
 	SEQ_PUT_DEC("Rss:            ", mss->resident);
 	SEQ_PUT_DEC(" kB\nPss:            ", mss->pss >> PSS_SHIFT);
 	SEQ_PUT_DEC(" kB\nPss_Dirty:      ", mss->pss_dirty >> PSS_SHIFT);
@@ -849,6 +954,16 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 					mss->swap_pss >> PSS_SHIFT);
 	SEQ_PUT_DEC(" kB\nLocked:         ",
 					mss->pss_locked >> PSS_SHIFT);
+	for (i = 0; i <= CONT_ORDER_MAX; i++) {
+		seq_printf(m, " kB\nAnonCont%s%8lu",
+					cont_label(i, label),
+					mss->anon_cont[i] >> 10);
+	}
+	for (i = 0; i <= CONT_ORDER_MAX; i++) {
+		seq_printf(m, " kB\nFileCont%s%8lu",
+					cont_label(i, label),
+					mss->file_cont[i] >> 10);
+	}
 	seq_puts(m, " kB\n");
 }
 
-- 
2.25.1

