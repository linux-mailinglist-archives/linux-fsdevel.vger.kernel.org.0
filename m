Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF256B469
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 10:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbiGHIWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 04:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiGHIWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:22:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D581487
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 01:22:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bf13so8713373pgb.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jul 2022 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OiydGQfoX7c72huoLN0EpuXg7JpZdtKvlblNE8ISP0o=;
        b=bu5EOGYP0IuwBoemQbUyQAQNkqqHQF+8/L3Oo/8rPl2p5lgmLR4JrSIclXDetWQaP6
         3C78R7Ib0rTYaO7jK2rBz8+z91GOcnQq3YOHOorVJrjGizBTPN5v1cgf6LruVi8N/lw3
         nMnHtlkMlz3IeZKZLhTAbDT9lDhNZg9711lSr/qDOuXutgLlFXIY7qlrHvKLVzKX+26M
         GaTs5f36/r2MMurtlnDulEPu1f7pSVsiOJGP81voGQNGQcK71dezT/QzgTNOsy5X0ZHa
         hEjKF6lYy1GMLWwBgeGjr2EYWiycCfGU3y+7uuhaYgRQahZ6BE6Kq9c92qvOeVEuU+qb
         mfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OiydGQfoX7c72huoLN0EpuXg7JpZdtKvlblNE8ISP0o=;
        b=fYQhnxlNViCT4EjpXkN6s/w8jbDyztr4pR+V79aycTNdIW+TvtHIHJ+WJFdXgqIRaM
         I40CGxA4idLrNwNBcQP3uyvZziNSsZLQIBT40as/MOz1IXBUIM0sHI909kirBci5zhJA
         bgRwWTMO076Hgms2uG5Wlplk4exSehD3Ad7r6t0jsG2483b1VgTmMGtR86akqmVldPIm
         bd0iUs/DyjiHbIcTjH2W77slzj2ucq5yQNRqVMO6PZSosBBbISpOGHUJeeaqcdPXIXCO
         pv+mzxTivrNvuf5Mpq8Q+6NIpaHamQpB1v9TElfHBf0OubU+T1wmbhthROn3c01JFPwR
         1mSQ==
X-Gm-Message-State: AJIora8gUV6FS4O3ZU9qSUGy6W7ZFaKI0EwmfMTSni3VfR89EhvdPlqX
        qhZdsngRrUNY3+EpRvp+vBAdpw==
X-Google-Smtp-Source: AGRyM1uAx3GntDC7EPT9lMtF2xH4xuZe6EjsCAdkW5TqWm8Wnig5bAxJch/MwbMLCLUp58AbHr7cLw==
X-Received: by 2002:a63:1f18:0:b0:414:f515:dc93 with SMTP id f24-20020a631f18000000b00414f515dc93mr2195183pgf.443.1657268558740;
        Fri, 08 Jul 2022 01:22:38 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id x65-20020a636344000000b00412b1043f33sm3329291pgb.39.2022.07.08.01.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:22:38 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     mhocko@suse.com, akpm@linux-foundation.org, surenb@google.com,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     rostedt@goodmis.org, david@redhat.com, imbrenda@linux.ibm.com,
        adobriyan@gmail.com, yang.yang29@zte.com.cn, brauner@kernel.org,
        stephen.s.brennan@oracle.com, zhengqi.arch@bytedance.com,
        haolee.swjtu@gmail.com, xu.xin16@zte.com.cn,
        Liam.Howlett@Oracle.com, ohoono.kwon@samsung.com,
        peterx@redhat.com, arnd@arndb.de, shy828301@gmail.com,
        alex.sierra@amd.com, xianting.tian@linux.alibaba.com,
        willy@infradead.org, ccross@google.com, vbabka@suse.cz,
        sujiaxun@uniontech.com, sfr@canb.auug.org.au,
        vasily.averin@linux.dev, mgorman@suse.de, vvghjk1234@gmail.com,
        tglx@linutronix.de, luto@kernel.org, bigeasy@linutronix.de,
        fenghua.yu@intel.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH v2 1/5] mm: add a new parameter `node` to `get/add/inc/dec_mm_counter`
Date:   Fri,  8 Jul 2022 16:21:25 +0800
Message-Id: <20220708082129.80115-2-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
References: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new parameter `node` to mm_counter for counting per node rss. Use
page_to_nid(page) to get node id from page.
before:
    dec_mm_counter(vma->vm_mm, MM_ANONPAGES);
after:
    dec_mm_counter(vma->vm_mm, MM_ANONPAGES, page_to_nid(page));

If a page is swapped out, it no longer exists on any numa node.
(Or it is swapped from disk into a specific numa node.)
Thus when we call *_mm_counter(MM_ANONPAGES), the `node` field should be
`NUMA_NO_NODE`. For example:
```
swap_out(){
    dec_mm_counter(vma->vm_mm, MM_ANONPAGES, page_to_nid(page));
    inc_mm_counter(vma->vm_mm, MM_SWAPENTS, NUMA_NO_NODE);
}
```

Pages can be migrated between nodes. `remove_migration_pte`
must call `add_mm_counter` now.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 arch/s390/mm/pgtable.c        |  4 +-
 fs/exec.c                     |  2 +-
 fs/proc/task_mmu.c            | 14 +++---
 include/linux/mm.h            | 14 +++---
 include/linux/mm_types_task.h | 10 ++++
 kernel/events/uprobes.c       |  6 +--
 mm/huge_memory.c              | 13 ++---
 mm/khugepaged.c               |  4 +-
 mm/ksm.c                      |  2 +-
 mm/madvise.c                  |  2 +-
 mm/memory.c                   | 94 +++++++++++++++++++++++------------
 mm/migrate.c                  |  4 ++
 mm/migrate_device.c           |  2 +-
 mm/oom_kill.c                 | 16 +++---
 mm/rmap.c                     | 19 ++++---
 mm/swapfile.c                 |  6 +--
 mm/userfaultfd.c              |  2 +-
 17 files changed, 132 insertions(+), 82 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 4909dcd762e8..b8306765cd63 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -703,11 +703,11 @@ void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep)
 static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 {
 	if (!non_swap_entry(entry))
-		dec_mm_counter(mm, MM_SWAPENTS);
+		dec_mm_counter(mm, MM_SWAPENTS, NUMA_NO_NODE);
 	else if (is_migration_entry(entry)) {
 		struct page *page = pfn_swap_entry_to_page(entry);
 
-		dec_mm_counter(mm, mm_counter(page));
+		dec_mm_counter(mm, mm_counter(page), page_to_nid(page));
 	}
 	free_swap_and_cache(entry);
 }
diff --git a/fs/exec.c b/fs/exec.c
index 5f0656e10b5d..99825c06d0c2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -192,7 +192,7 @@ static void acct_arg_size(struct linux_binprm *bprm, unsigned long pages)
 		return;
 
 	bprm->vma_pages = pages;
-	add_mm_counter(mm, MM_ANONPAGES, diff);
+	add_mm_counter(mm, MM_ANONPAGES, diff, NUMA_NO_NODE);
 }
 
 static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 34d292cec79a..24d33d1011d9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -32,9 +32,9 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	unsigned long text, lib, swap, anon, file, shmem;
 	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
 
-	anon = get_mm_counter(mm, MM_ANONPAGES);
-	file = get_mm_counter(mm, MM_FILEPAGES);
-	shmem = get_mm_counter(mm, MM_SHMEMPAGES);
+	anon = get_mm_counter(mm, MM_ANONPAGES, NUMA_NO_NODE);
+	file = get_mm_counter(mm, MM_FILEPAGES, NUMA_NO_NODE);
+	shmem = get_mm_counter(mm, MM_SHMEMPAGES, NUMA_NO_NODE);
 
 	/*
 	 * Note: to minimize their overhead, mm maintains hiwater_vm and
@@ -55,7 +55,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	text = min(text, mm->exec_vm << PAGE_SHIFT);
 	lib = (mm->exec_vm << PAGE_SHIFT) - text;
 
-	swap = get_mm_counter(mm, MM_SWAPENTS);
+	swap = get_mm_counter(mm, MM_SWAPENTS, NUMA_NO_NODE);
 	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
 	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
 	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
@@ -88,12 +88,12 @@ unsigned long task_statm(struct mm_struct *mm,
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
-	*shared = get_mm_counter(mm, MM_FILEPAGES) +
-			get_mm_counter(mm, MM_SHMEMPAGES);
+	*shared = get_mm_counter(mm, MM_FILEPAGES, NUMA_NO_NODE) +
+			get_mm_counter(mm, MM_SHMEMPAGES, NUMA_NO_NODE);
 	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
 								>> PAGE_SHIFT;
 	*data = mm->data_vm + mm->stack_vm;
-	*resident = *shared + get_mm_counter(mm, MM_ANONPAGES);
+	*resident = *shared + get_mm_counter(mm, MM_ANONPAGES, NUMA_NO_NODE);
 	return mm->total_vm;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 794ad19b57f8..84ce6e1b1252 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2026,7 +2026,7 @@ static inline bool get_user_page_fast_only(unsigned long addr,
 /*
  * per-process(per-mm_struct) statistics.
  */
-static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
+static inline unsigned long get_mm_counter(struct mm_struct *mm, int member, int node)
 {
 	long val = atomic_long_read(&mm->rss_stat.count[member]);
 
@@ -2043,21 +2043,21 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 
 void mm_trace_rss_stat(struct mm_struct *mm, int member, long count);
 
-static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
+static inline void add_mm_counter(struct mm_struct *mm, int member, long value, int node)
 {
 	long count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
 
 	mm_trace_rss_stat(mm, member, count);
 }
 
-static inline void inc_mm_counter(struct mm_struct *mm, int member)
+static inline void inc_mm_counter(struct mm_struct *mm, int member, int node)
 {
 	long count = atomic_long_inc_return(&mm->rss_stat.count[member]);
 
 	mm_trace_rss_stat(mm, member, count);
 }
 
-static inline void dec_mm_counter(struct mm_struct *mm, int member)
+static inline void dec_mm_counter(struct mm_struct *mm, int member, int node)
 {
 	long count = atomic_long_dec_return(&mm->rss_stat.count[member]);
 
@@ -2081,9 +2081,9 @@ static inline int mm_counter(struct page *page)
 
 static inline unsigned long get_mm_rss(struct mm_struct *mm)
 {
-	return get_mm_counter(mm, MM_FILEPAGES) +
-		get_mm_counter(mm, MM_ANONPAGES) +
-		get_mm_counter(mm, MM_SHMEMPAGES);
+	return get_mm_counter(mm, MM_FILEPAGES, NUMA_NO_NODE) +
+		get_mm_counter(mm, MM_ANONPAGES, NUMA_NO_NODE) +
+		get_mm_counter(mm, MM_SHMEMPAGES, NUMA_NO_NODE);
 }
 
 static inline unsigned long get_mm_hiwater_rss(struct mm_struct *mm)
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index 0bb4b6da9993..32512af31721 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -36,6 +36,16 @@ enum {
 	NR_MM_COUNTERS
 };
 
+/*
+ * This macro should only be used in committing local values, like sync_mm_rss,
+ * add_mm_rss_vec. It means don't count per-mm-type, only count per-node in
+ * mm_stat.
+ *
+ * `MM_NO_TYPE` must equals to `NR_MM_COUNTERS`, since we will use it in
+ * `TRACE_MM_PAGES`.
+ */
+#define MM_NO_TYPE NR_MM_COUNTERS
+
 #if USE_SPLIT_PTE_PTLOCKS && defined(CONFIG_MMU)
 #define SPLIT_RSS_COUNTING
 /* per-thread cached information, */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 401bc2d24ce0..f5b0db3494a3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -184,11 +184,11 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		lru_cache_add_inactive_or_unevictable(new_page, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
-		dec_mm_counter(mm, MM_ANONPAGES);
+		dec_mm_counter(mm, MM_ANONPAGES, page_to_nid(old_page));
 
 	if (!PageAnon(old_page)) {
-		dec_mm_counter(mm, mm_counter_file(old_page));
-		inc_mm_counter(mm, MM_ANONPAGES);
+		dec_mm_counter(mm, mm_counter_file(old_page), page_to_nid(old_page));
+		inc_mm_counter(mm, MM_ANONPAGES, page_to_nid(new_page));
 	}
 
 	flush_cache_page(vma, addr, pte_pfn(*pvmw.pte));
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fd9d502aadc4..b7fd7df70e7c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -809,7 +809,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
-		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR, page_to_nid(page));
 		mm_inc_nr_ptes(vma->vm_mm);
 		spin_unlock(vmf->ptl);
 		count_vm_event(THP_FAULT_ALLOC);
@@ -1220,7 +1220,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 				pmd = pmd_swp_mkuffd_wp(pmd);
 			set_pmd_at(src_mm, addr, src_pmd, pmd);
 		}
-		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR, page_to_nid(pmd_page(*dst_pmd)));
 		mm_inc_nr_ptes(dst_mm);
 		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
 		if (!userfaultfd_wp(dst_vma))
@@ -1263,7 +1263,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		__split_huge_pmd(src_vma, src_pmd, addr, false, NULL);
 		return -EAGAIN;
 	}
-	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR, page_to_nid(src_page));
 out_zero_page:
 	mm_inc_nr_ptes(dst_mm);
 	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
@@ -1753,11 +1753,12 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		if (PageAnon(page)) {
 			zap_deposited_table(tlb->mm, pmd);
-			add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PMD_NR);
+			add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PMD_NR, page_to_nid(page));
 		} else {
 			if (arch_needs_pgtable_deposit())
 				zap_deposited_table(tlb->mm, pmd);
-			add_mm_counter(tlb->mm, mm_counter_file(page), -HPAGE_PMD_NR);
+			add_mm_counter(tlb->mm, mm_counter_file(page), -HPAGE_PMD_NR,
+				       page_to_nid(page));
 		}
 
 		spin_unlock(ptl);
@@ -2143,7 +2144,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			page_remove_rmap(page, vma, true);
 			put_page(page);
 		}
-		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
+		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR, page_to_nid(page));
 		return;
 	}
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cfe231c5958f..74d4c578a91c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -687,7 +687,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 
 		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
 			clear_user_highpage(page, address);
-			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
+			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1, page_to_nid(page));
 			if (is_zero_pfn(pte_pfn(pteval))) {
 				/*
 				 * ptl mostly unnecessary.
@@ -1469,7 +1469,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	/* step 3: set proper refcount and mm_counters. */
 	if (count) {
 		page_ref_sub(hpage, count);
-		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
+		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count, page_to_nid(hpage));
 	}
 
 	/* step 4: collapse pmd */
diff --git a/mm/ksm.c b/mm/ksm.c
index 63b4b9d71597..4dc4b78d6f9b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1180,7 +1180,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		 * will get wrong values in /proc, and a BUG message in dmesg
 		 * when tearing down the mm.
 		 */
-		dec_mm_counter(mm, MM_ANONPAGES);
+		dec_mm_counter(mm, MM_ANONPAGES, page_to_nid(page));
 	}
 
 	flush_cache_page(vma, addr, pte_pfn(*ptep));
diff --git a/mm/madvise.c b/mm/madvise.c
index 851fa4e134bc..46229b70cbbe 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -715,7 +715,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (current->mm == mm)
 			sync_mm_rss(mm);
 
-		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
+		add_mm_counter(mm, MM_SWAPENTS, nr_swap, NUMA_NO_NODE);
 	}
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
diff --git a/mm/memory.c b/mm/memory.c
index 8917bea2f0bc..bb24da767f79 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -161,6 +161,8 @@ EXPORT_SYMBOL(zero_pfn);
 
 unsigned long highest_memmap_pfn __read_mostly;
 
+static DEFINE_PER_CPU(int, percpu_numa_rss[MAX_NUMNODES]);
+
 /*
  * CONFIG_MMU architectures set up ZERO_PAGE in their paging_init()
  */
@@ -184,24 +186,24 @@ void sync_mm_rss(struct mm_struct *mm)
 
 	for (i = 0; i < NR_MM_COUNTERS; i++) {
 		if (current->rss_stat.count[i]) {
-			add_mm_counter(mm, i, current->rss_stat.count[i]);
+			add_mm_counter(mm, i, current->rss_stat.count[i], NUMA_NO_NODE);
 			current->rss_stat.count[i] = 0;
 		}
 	}
 	current->rss_stat.events = 0;
 }
 
-static void add_mm_counter_fast(struct mm_struct *mm, int member, int val)
+static void add_mm_counter_fast(struct mm_struct *mm, int member, int val, int node)
 {
 	struct task_struct *task = current;
 
 	if (likely(task->mm == mm))
 		task->rss_stat.count[member] += val;
 	else
-		add_mm_counter(mm, member, val);
+		add_mm_counter(mm, member, val, node);
 }
-#define inc_mm_counter_fast(mm, member) add_mm_counter_fast(mm, member, 1)
-#define dec_mm_counter_fast(mm, member) add_mm_counter_fast(mm, member, -1)
+#define inc_mm_counter_fast(mm, member, node) add_mm_counter_fast(mm, member, 1, node)
+#define dec_mm_counter_fast(mm, member, node) add_mm_counter_fast(mm, member, -1, node)
 
 /* sync counter once per 64 page faults */
 #define TASK_RSS_EVENTS_THRESH	(64)
@@ -214,8 +216,8 @@ static void check_sync_rss_stat(struct task_struct *task)
 }
 #else /* SPLIT_RSS_COUNTING */
 
-#define inc_mm_counter_fast(mm, member) inc_mm_counter(mm, member)
-#define dec_mm_counter_fast(mm, member) dec_mm_counter(mm, member)
+#define inc_mm_counter_fast(mm, member, node) inc_mm_counter(mm, member, node)
+#define dec_mm_counter_fast(mm, member, node) dec_mm_counter(mm, member, node)
 
 static void check_sync_rss_stat(struct task_struct *task)
 {
@@ -502,12 +504,13 @@ int __pte_alloc_kernel(pmd_t *pmd)
 	return 0;
 }
 
-static inline void init_rss_vec(int *rss)
+static inline void init_rss_vec(int *rss, int *numa_rss)
 {
 	memset(rss, 0, sizeof(int) * NR_MM_COUNTERS);
+	memset(numa_rss, 0, sizeof(int) * num_possible_nodes());
 }
 
-static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
+static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss, int *numa_rss)
 {
 	int i;
 
@@ -515,7 +518,7 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
 		sync_mm_rss(mm);
 	for (i = 0; i < NR_MM_COUNTERS; i++)
 		if (rss[i])
-			add_mm_counter(mm, i, rss[i]);
+			add_mm_counter(mm, i, rss[i], NUMA_NO_NODE);
 }
 
 /*
@@ -792,7 +795,8 @@ try_restore_exclusive_pte(pte_t *src_pte, struct vm_area_struct *vma,
 static unsigned long
 copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *dst_vma,
-		struct vm_area_struct *src_vma, unsigned long addr, int *rss)
+		struct vm_area_struct *src_vma, unsigned long addr, int *rss,
+		int *numa_rss)
 {
 	unsigned long vm_flags = dst_vma->vm_flags;
 	pte_t pte = *src_pte;
@@ -817,10 +821,12 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
 		rss[MM_SWAPENTS]++;
+		numa_rss[page_to_nid(pte_page(*dst_pte))]++;
 	} else if (is_migration_entry(entry)) {
 		page = pfn_swap_entry_to_page(entry);
 
 		rss[mm_counter(page)]++;
+		numa_rss[page_to_nid(page)]++;
 
 		if (!is_readable_migration_entry(entry) &&
 				is_cow_mapping(vm_flags)) {
@@ -852,6 +858,8 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 */
 		get_page(page);
 		rss[mm_counter(page)]++;
+		numa_rss[page_to_nid(page)]++;
+
 		/* Cannot fail as these pages cannot get pinned. */
 		BUG_ON(page_try_dup_anon_rmap(page, false, src_vma));
 
@@ -912,7 +920,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 static inline int
 copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		  pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
-		  struct page **prealloc, struct page *page)
+		  struct page **prealloc, struct page *page, int *numa_rss)
 {
 	struct page *new_page;
 	pte_t pte;
@@ -931,6 +939,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	page_add_new_anon_rmap(new_page, dst_vma, addr);
 	lru_cache_add_inactive_or_unevictable(new_page, dst_vma);
 	rss[mm_counter(new_page)]++;
+	rss[page_to_nid(new_page)]++;
 
 	/* All done, just insert the new page copy in the child */
 	pte = mk_pte(new_page, dst_vma->vm_page_prot);
@@ -949,7 +958,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 static inline int
 copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
-		 struct page **prealloc)
+		 struct page **prealloc, int *numa_rss)
 {
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	unsigned long vm_flags = src_vma->vm_flags;
@@ -969,13 +978,15 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			/* Page maybe pinned, we have to copy. */
 			put_page(page);
 			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
-						 addr, rss, prealloc, page);
+						 addr, rss, prealloc, page, numa_rss);
 		}
 		rss[mm_counter(page)]++;
+		numa_rss[page_to_nid(page)]++;
 	} else if (page) {
 		get_page(page);
 		page_dup_file_rmap(page, false);
 		rss[mm_counter(page)]++;
+		numa_rss[page_to_nid(page)]++;
 	}
 
 	/*
@@ -1034,12 +1045,16 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	spinlock_t *src_ptl, *dst_ptl;
 	int progress, ret = 0;
 	int rss[NR_MM_COUNTERS];
+	int *numa_rss;
 	swp_entry_t entry = (swp_entry_t){0};
 	struct page *prealloc = NULL;
+	numa_rss = kcalloc(num_possible_nodes(), sizeof(int), GFP_KERNEL);
+	if (unlikely(!numa_rss))
+		numa_rss = (int *)get_cpu_ptr(&percpu_numa_rss);
 
 again:
 	progress = 0;
-	init_rss_vec(rss);
+	init_rss_vec(rss, numa_rss);
 
 	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
 	if (!dst_pte) {
@@ -1072,7 +1087,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			ret = copy_nonpresent_pte(dst_mm, src_mm,
 						  dst_pte, src_pte,
 						  dst_vma, src_vma,
-						  addr, rss);
+						  addr, rss, numa_rss);
 			if (ret == -EIO) {
 				entry = pte_to_swp_entry(*src_pte);
 				break;
@@ -1091,7 +1106,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		}
 		/* copy_present_pte() will clear `*prealloc' if consumed */
 		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
-				       addr, rss, &prealloc);
+				       addr, rss, &prealloc, numa_rss);
 		/*
 		 * If we need a pre-allocated page for this pte, drop the
 		 * locks, allocate, and try again.
@@ -1114,7 +1129,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	arch_leave_lazy_mmu_mode();
 	spin_unlock(src_ptl);
 	pte_unmap(orig_src_pte);
-	add_mm_rss_vec(dst_mm, rss);
+	add_mm_rss_vec(dst_mm, rss, numa_rss);
 	pte_unmap_unlock(orig_dst_pte, dst_ptl);
 	cond_resched();
 
@@ -1143,6 +1158,10 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 out:
 	if (unlikely(prealloc))
 		put_page(prealloc);
+	if (unlikely(numa_rss == (int *)raw_cpu_ptr(&percpu_numa_rss)))
+		put_cpu_ptr(numa_rss);
+	else
+		kfree(numa_rss);
 	return ret;
 }
 
@@ -1415,14 +1434,18 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	struct mm_struct *mm = tlb->mm;
 	int force_flush = 0;
 	int rss[NR_MM_COUNTERS];
+	int *numa_rss;
 	spinlock_t *ptl;
 	pte_t *start_pte;
 	pte_t *pte;
 	swp_entry_t entry;
+	numa_rss = kcalloc(num_possible_nodes(), sizeof(int), GFP_KERNEL);
+	if (unlikely(!numa_rss))
+		numa_rss = (int *)get_cpu_ptr(&percpu_numa_rss);
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 again:
-	init_rss_vec(rss);
+	init_rss_vec(rss, numa_rss);
 	start_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	pte = start_pte;
 	flush_tlb_batched_pending(mm);
@@ -1459,6 +1482,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 					mark_page_accessed(page);
 			}
 			rss[mm_counter(page)]--;
+			numa_rss[page_to_nid(page)]--;
 			page_remove_rmap(page, vma, false);
 			if (unlikely(page_mapcount(page) < 0))
 				print_bad_pte(vma, addr, ptent, page);
@@ -1484,6 +1508,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			 */
 			WARN_ON_ONCE(!vma_is_anonymous(vma));
 			rss[mm_counter(page)]--;
+			numa_rss[page_to_nid(page)]--;
 			if (is_device_private_entry(entry))
 				page_remove_rmap(page, vma, false);
 			put_page(page);
@@ -1499,13 +1524,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (!should_zap_page(details, page))
 				continue;
 			rss[mm_counter(page)]--;
+			numa_rss[page_to_nid(page)]--;
 		} else if (pte_marker_entry_uffd_wp(entry)) {
 			/* Only drop the uffd-wp marker if explicitly requested */
 			if (!zap_drop_file_uffd_wp(details))
 				continue;
 		} else if (is_hwpoison_entry(entry) ||
 			   is_swapin_error_entry(entry)) {
-			if (!should_zap_cows(details))
 				continue;
 		} else {
 			/* We should have covered all the swap entry types */
@@ -1515,7 +1540,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
-	add_mm_rss_vec(mm, rss);
+	add_mm_rss_vec(mm, rss, numa_rss);
 	arch_leave_lazy_mmu_mode();
 
 	/* Do the actual TLB flush before dropping ptl */
@@ -1539,6 +1564,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		goto again;
 	}
 
+	if (unlikely(numa_rss == (int *)raw_cpu_ptr(&percpu_numa_rss)))
+		put_cpu_ptr(numa_rss);
+	else
+		kfree(numa_rss);
 	return addr;
 }
 
@@ -1868,7 +1897,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
 	get_page(page);
-	inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
+	inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page), page_to_nid(page));
 	page_add_file_rmap(page, vma, false);
 	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
 	return 0;
@@ -3164,11 +3193,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		if (old_page) {
 			if (!PageAnon(old_page)) {
 				dec_mm_counter_fast(mm,
-						mm_counter_file(old_page));
-				inc_mm_counter_fast(mm, MM_ANONPAGES);
+						mm_counter_file(old_page), page_to_nid(old_page));
+				inc_mm_counter_fast(mm, MM_ANONPAGES, page_to_nid(new_page));
+			} else {
+				dec_mm_counter_fast(mm, MM_ANONPAGES, page_to_nid(old_page));
+				inc_mm_counter_fast(mm, MM_ANONPAGES, page_to_nid(new_page));
 			}
 		} else {
-			inc_mm_counter_fast(mm, MM_ANONPAGES);
+			inc_mm_counter_fast(mm, MM_ANONPAGES, page_to_nid(new_page));
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
@@ -3955,8 +3987,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (should_try_to_free_swap(page, vma, vmf->flags))
 		try_to_free_swap(page);
 
-	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
+	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES, page_to_nid(page));
+	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS, NUMA_NO_NODE);
 	pte = mk_pte(page, vma->vm_page_prot);
 
 	/*
@@ -4134,7 +4166,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
-	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
+	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES, page_to_nid(page));
 	page_add_new_anon_rmap(page, vma, vmf->address);
 	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
@@ -4275,7 +4307,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (write)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
-	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
+	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR, page_to_nid(page));
 	page_add_file_rmap(page, vma, true);
 
 	/*
@@ -4324,11 +4356,11 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 		entry = pte_mkuffd_wp(pte_wrprotect(entry));
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
-		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
+		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES, page_to_nid(page));
 		page_add_new_anon_rmap(page, vma, addr);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
-		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
+		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page), page_to_nid(page));
 		page_add_file_rmap(page, vma, false);
 	}
 	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
diff --git a/mm/migrate.c b/mm/migrate.c
index e01624fcab5b..1d7aac928e7e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -258,6 +258,10 @@ static bool remove_migration_pte(struct folio *folio,
 
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
+		add_mm_counter(vma->vm_mm, MM_ANONPAGES,
+				-compound_nr(old), page_to_nid(old));
+		add_mm_counter(vma->vm_mm, MM_ANONPAGES,
+				compound_nr(&folio->page), page_to_nid(&folio->page));
 	}
 
 	return true;
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index ad593d5754cf..e17c5fbc3d2a 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -631,7 +631,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	if (userfaultfd_missing(vma))
 		goto unlock_abort;
 
-	inc_mm_counter(mm, MM_ANONPAGES);
+	inc_mm_counter(mm, MM_ANONPAGES, page_to_nid(page));
 	page_add_new_anon_rmap(page, vma, addr);
 	if (!is_zone_device_page(page))
 		lru_cache_add_inactive_or_unevictable(page, vma);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 35ec75cdfee2..e25c37e2e90d 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -227,7 +227,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 	 * The baseline for the badness score is the proportion of RAM that each
 	 * task's rss, pagetable and swap space use.
 	 */
-	points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS) +
+	points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS, NUMA_NO_NODE) +
 		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
 	task_unlock(p);
 
@@ -403,7 +403,7 @@ static int dump_task(struct task_struct *p, void *arg)
 		task->pid, from_kuid(&init_user_ns, task_uid(task)),
 		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
 		mm_pgtables_bytes(task->mm),
-		get_mm_counter(task->mm, MM_SWAPENTS),
+		get_mm_counter(task->mm, MM_SWAPENTS, NUMA_NO_NODE),
 		task->signal->oom_score_adj, task->comm);
 	task_unlock(task);
 
@@ -594,9 +594,9 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 
 	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 			task_pid_nr(tsk), tsk->comm,
-			K(get_mm_counter(mm, MM_ANONPAGES)),
-			K(get_mm_counter(mm, MM_FILEPAGES)),
-			K(get_mm_counter(mm, MM_SHMEMPAGES)));
+			K(get_mm_counter(mm, MM_ANONPAGES, NUMA_NO_NODE)),
+			K(get_mm_counter(mm, MM_FILEPAGES, NUMA_NO_NODE)),
+			K(get_mm_counter(mm, MM_SHMEMPAGES, NUMA_NO_NODE)));
 out_finish:
 	trace_finish_task_reaping(tsk->pid);
 out_unlock:
@@ -948,9 +948,9 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	mark_oom_victim(victim);
 	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
 		message, task_pid_nr(victim), victim->comm, K(mm->total_vm),
-		K(get_mm_counter(mm, MM_ANONPAGES)),
-		K(get_mm_counter(mm, MM_FILEPAGES)),
-		K(get_mm_counter(mm, MM_SHMEMPAGES)),
+		K(get_mm_counter(mm, MM_ANONPAGES, NUMA_NO_NODE)),
+		K(get_mm_counter(mm, MM_FILEPAGES, NUMA_NO_NODE)),
+		K(get_mm_counter(mm, MM_SHMEMPAGES, NUMA_NO_NODE)),
 		from_kuid(&init_user_ns, task_uid(victim)),
 		mm_pgtables_bytes(mm) >> 10, victim->signal->oom_score_adj);
 	task_unlock(victim);
diff --git a/mm/rmap.c b/mm/rmap.c
index edc06c52bc82..a6e8bb3d40cc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1620,7 +1620,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				hugetlb_count_sub(folio_nr_pages(folio), mm);
 				set_huge_pte_at(mm, address, pvmw.pte, pteval);
 			} else {
-				dec_mm_counter(mm, mm_counter(&folio->page));
+				dec_mm_counter(mm, mm_counter(&folio->page),
+						page_to_nid(&folio->page));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -1635,7 +1636,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * migration) will not expect userfaults on already
 			 * copied pages.
 			 */
-			dec_mm_counter(mm, mm_counter(&folio->page));
+			dec_mm_counter(mm, mm_counter(&folio->page), page_to_nid(&folio->page));
 			/* We have to invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
@@ -1686,7 +1687,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					/* Invalidate as we cleared the pte */
 					mmu_notifier_invalidate_range(mm,
 						address, address + PAGE_SIZE);
-					dec_mm_counter(mm, MM_ANONPAGES);
+					dec_mm_counter(mm, MM_ANONPAGES, page_to_nid(&folio->page));
 					goto discard;
 				}
 
@@ -1739,8 +1740,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					list_add(&mm->mmlist, &init_mm.mmlist);
 				spin_unlock(&mmlist_lock);
 			}
-			dec_mm_counter(mm, MM_ANONPAGES);
-			inc_mm_counter(mm, MM_SWAPENTS);
+			dec_mm_counter(mm, MM_ANONPAGES, page_to_nid(&folio->page));
+			inc_mm_counter(mm, MM_SWAPENTS, NUMA_NO_NODE);
 			swp_pte = swp_entry_to_pte(entry);
 			if (anon_exclusive)
 				swp_pte = pte_swp_mkexclusive(swp_pte);
@@ -1764,7 +1765,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 *
 			 * See Documentation/mm/mmu_notifier.rst
 			 */
-			dec_mm_counter(mm, mm_counter_file(&folio->page));
+			dec_mm_counter(mm, mm_counter_file(&folio->page),
+					page_to_nid(&folio->page));
 		}
 discard:
 		/*
@@ -2011,7 +2013,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				hugetlb_count_sub(folio_nr_pages(folio), mm);
 				set_huge_pte_at(mm, address, pvmw.pte, pteval);
 			} else {
-				dec_mm_counter(mm, mm_counter(&folio->page));
+				dec_mm_counter(mm, mm_counter(&folio->page),
+						page_to_nid(&folio->page));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -2026,7 +2029,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * migration) will not expect userfaults on already
 			 * copied pages.
 			 */
-			dec_mm_counter(mm, mm_counter(&folio->page));
+			dec_mm_counter(mm, mm_counter(&folio->page), page_to_nid(&folio->page));
 			/* We have to invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5c8681a3f1d9..c0485bb54954 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1791,7 +1791,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	if (unlikely(!PageUptodate(page))) {
 		pte_t pteval;
 
-		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
+		dec_mm_counter(vma->vm_mm, MM_SWAPENTS, NUMA_NO_NODE);
 		pteval = swp_entry_to_pte(make_swapin_error_entry(page));
 		set_pte_at(vma->vm_mm, addr, pte, pteval);
 		swap_free(entry);
@@ -1803,8 +1803,8 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
 	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
 
-	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
-	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
+	dec_mm_counter(vma->vm_mm, MM_SWAPENTS, NUMA_NO_NODE);
+	inc_mm_counter(vma->vm_mm, MM_ANONPAGES, page_to_nid(page));
 	get_page(page);
 	if (page == swapcache) {
 		rmap_t rmap_flags = RMAP_NONE;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 07d3befc80e4..b6581867aad6 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -127,7 +127,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	 * Must happen after rmap, as mm_counter() checks mapping (via
 	 * PageAnon()), which is set by __page_set_anon_rmap().
 	 */
-	inc_mm_counter(dst_mm, mm_counter(page));
+	inc_mm_counter(dst_mm, mm_counter(page), page_to_nid(page));
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
-- 
2.20.1

