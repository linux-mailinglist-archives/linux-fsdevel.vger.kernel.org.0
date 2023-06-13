Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EEF72E7E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 18:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbjFMQKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243046AbjFMQKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:10:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 797351989;
        Tue, 13 Jun 2023 09:10:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B482143D;
        Tue, 13 Jun 2023 09:10:50 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E80413F5A1;
        Tue, 13 Jun 2023 09:10:03 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/2] mm: /proc/pid/smaps: Report contpte mappings
Date:   Tue, 13 Jun 2023 17:09:50 +0100
Message-Id: <20230613160950.3554675-3-ryan.roberts@arm.com>
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

arm64 intends to start using its "contpte" bit in pgtables more
frequently, and therefore it would be useful to know how well utilised
it is in order to help diagnose and fix performance issues.

Add "ContPTEMapped" field, which shows how much of the rss is mapped
using contptes. For architectures that do not support contpte mappings
(as determined by pte_cont() not being defined) the field will be
suppressed.

Rollup Example:

aaaac5150000-ffffccf07000 ---p 00000000 00:00 0                 [rollup]
Rss:               11504 kB
...
ContPTEMapped:      6848 kB

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/filesystems/proc.rst |  5 +++++
 fs/proc/task_mmu.c                 | 19 +++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 5fa3f638848d..726951374c57 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -491,6 +491,7 @@ Memory Area, or VMA) there is a series of lines such as the following::
     FileCont512K:          0 kB
     FileCont1M:            0 kB
     FileCont2M:            0 kB
+    ContPTEMapped:         0 kB
     THPeligible:           0
     VmFlags: rd ex mr mw me dw
 
@@ -550,6 +551,10 @@ pmd size. Therefore the exact set of keys will vary by platform. It only
 includes pte-mapped memory and reports on anonymous and file-backed memory
 separately.
 
+"ContPTEMapped" is only present for architectures that support indicating a set
+of contiguously mapped ptes in their page tables. In this case, it indicates
+how much of the memory is currently mapped using contpte mappings.
+
 "THPeligible" indicates whether the mapping is eligible for allocating THP
 pages as well as the THP is PMD mappable or not - 1 if true, 0 otherwise.
 It just shows the current status.
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 29fee5b7b00b..0ebd6eb7efd4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -465,6 +465,7 @@ struct mem_size_stats {
 	unsigned long anon_cont[CONT_ORDER_MAX + 1];
 	unsigned long file_cont[CONT_ORDER_MAX + 1];
 	struct cont_accumulator cacc;
+	unsigned long contpte_mapped;
 };
 
 static void cacc_init(struct mem_size_stats *mss)
@@ -548,7 +549,7 @@ static void smaps_page_accumulate(struct mem_size_stats *mss,
 
 static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		bool compound, bool young, bool dirty, bool locked,
-		bool migration)
+		bool migration, bool contpte)
 {
 	int i, nr = compound ? compound_nr(page) : 1;
 	unsigned long size = nr * PAGE_SIZE;
@@ -572,6 +573,10 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 	if (!compound)
 		cacc_accumulate(mss, page);
 
+	/* Accumulate all the pages that are part of a contpte. */
+	if (contpte)
+		mss->contpte_mapped += size;
+
 	/*
 	 * Then accumulate quantities that may depend on sharing, or that may
 	 * differ page-by-page.
@@ -636,13 +641,16 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
-	bool migration = false, young = false, dirty = false;
+	bool migration = false, young = false, dirty = false, cont = false;
 	pte_t ptent = ptep_get(pte);
 
 	if (pte_present(ptent)) {
 		page = vm_normal_page(vma, addr, ptent);
 		young = pte_young(ptent);
 		dirty = pte_dirty(ptent);
+#ifdef pte_cont
+		cont = pte_cont(ptent);
+#endif
 	} else if (is_swap_pte(ptent)) {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
@@ -672,7 +680,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	if (!page)
 		return;
 
-	smaps_account(mss, page, false, young, dirty, locked, migration);
+	smaps_account(mss, page, false, young, dirty, locked, migration, cont);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -708,7 +716,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		mss->file_thp += HPAGE_PMD_SIZE;
 
 	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
-		      locked, migration);
+		      locked, migration, false);
 }
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
@@ -964,6 +972,9 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 					cont_label(i, label),
 					mss->file_cont[i] >> 10);
 	}
+#ifdef pte_cont
+	SEQ_PUT_DEC(" kB\nContPTEMapped:  ", mss->contpte_mapped);
+#endif
 	seq_puts(m, " kB\n");
 }
 
-- 
2.25.1

