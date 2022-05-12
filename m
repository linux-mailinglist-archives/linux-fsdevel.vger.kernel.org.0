Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF452447D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 06:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348347AbiELEru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 00:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348039AbiELEr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 00:47:26 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527E2B18D
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 21:47:23 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x23so3746831pff.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 21:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ct/r82Wcunw1PERZ1nRBl5tbVAIAGrsJEk78L35mllQ=;
        b=3Kt71VQFt5+H6wMDXcQrWrnCxnzCZBjHtsxKRzNB95j7znLjPuLK++5D8uvybr8MS+
         tcc3KXE7GoRh+BYYlP4dodIS35VgiHCRoXByb7ba9ptdngmSirBxM33auyqfJvgBJgSg
         A32CLH27+38VKji38lVGWGUkvCPdZllFtgyWKPvaPtKguChdZjnwUzbxqYK9efIp+oNE
         L1u6yAx31be4uNEXI8EBzO2Y0DB6Zu15TNRu0sKpor01fcVnsbVvI31LY7CZDvU2gh+/
         rHnjg6EarIgSP5eXgQzkTBXy8lghXGpVijuvWN70AD1d4ViAYgkVB55tgSHh3G1sihWY
         EEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ct/r82Wcunw1PERZ1nRBl5tbVAIAGrsJEk78L35mllQ=;
        b=yRx8lqysknhh7TUoWnkikhDEEa55oj4NjLf2b6QfRzzQwmoQTCpydM6R/ubXOoRLa1
         Q0n+8mUjcPdQb60xcLLLo1uiMyYUCt+vFKx0BkZr1cYz+a4DshByI6KGQCtdKoZPLTK5
         6VdfGU0Ged6frlRZgqpbMTtJV//peymStdTqt8eI+i5jD7Bi8NLIdrdfQfxa1cWxMLri
         UG4+XyA3ejvNeesa9XzPdDpqO82JnyE61Ks08VKLk6PAy7WDl1ngGboCvpQ/tlEkWGYD
         6NA1o7J3E1K7MyyRp+RUlA9r2+2z/v4HWX+cNh384Z2v2OQpc1Q2XzGbTQhb8akHpMs2
         NG+g==
X-Gm-Message-State: AOAM530mgvlwoQNJpMuO5Zy3vWIrvldB0DKLLocbFABa98BLd1Q2DiVv
        wSCW8h47ELtWrJOpZdgXSJfpEg==
X-Google-Smtp-Source: ABdhPJxpeZVYA4mVH6kYEhlOoPntmKhHa7TvT04NF4ot6lh5IboMSrPfSEIpfVDX8vyYODG9jd6Ddg==
X-Received: by 2002:a63:5264:0:b0:3db:6ee:7c0a with SMTP id s36-20020a635264000000b003db06ee7c0amr7652894pgl.100.1652330842750;
        Wed, 11 May 2022 21:47:22 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b0015edc07dcf3sm2790824plk.21.2022.05.11.21.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:47:22 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ebiederm@xmission.com, keescook@chromium.org,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        apopple@nvidia.com, adobriyan@gmail.com,
        stephen.s.brennan@oracle.com, ohoono.kwon@samsung.com,
        haolee.swjtu@gmail.com, kaleshsingh@google.com,
        zhengqi.arch@bytedance.com, peterx@redhat.com, shy828301@gmail.com,
        surenb@google.com, ccross@google.com, vincent.whitchurch@axis.com,
        tglx@linutronix.de, bigeasy@linutronix.de, fenghua.yu@intel.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH 1/5 v1] mm: add a new parameter `node` to `get/add/inc/dec_mm_counter`
Date:   Thu, 12 May 2022 12:46:30 +0800
Message-Id: <20220512044634.63586-2-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
References: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new parameter `node` to mm_counter for counting per process
per node rss.

Since pages can be migrated between nodes, `remove_migration_pte`
also needs to call `add_mm_counter`.

Notice that the `MM_SWAPENTS` doesn't exist on any node. So when
add_mm_counter is used to modify rss_stat.count[MM_SWAPENTS], its
`node` field should be `NUMA_NO_NODE`.

And there is no need to modify `resident_page_types`, because
`MM_NO_TYPE` is not used in `check_mm`.

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
 mm/memory.c                   | 91 +++++++++++++++++++++++------------
 mm/migrate.c                  |  2 +
 mm/migrate_device.c           |  2 +-
 mm/oom_kill.c                 | 16 +++---
 mm/rmap.c                     | 16 +++---
 mm/swapfile.c                 |  4 +-
 mm/userfaultfd.c              |  2 +-
 17 files changed, 124 insertions(+), 80 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 697df02362af..d44198c5929f 100644
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
index e3e55d5e0be1..6c82393b1720 100644
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
index f46060eb91b5..5cf65327fa6d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -33,9 +33,9 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
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
@@ -56,7 +56,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	text = min(text, mm->exec_vm << PAGE_SHIFT);
 	lib = (mm->exec_vm << PAGE_SHIFT) - text;
 
-	swap = get_mm_counter(mm, MM_SWAPENTS);
+	swap = get_mm_counter(mm, MM_SWAPENTS, NUMA_NO_NODE);
 	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
 	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
 	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
@@ -89,12 +89,12 @@ unsigned long task_statm(struct mm_struct *mm,
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
index 9f44254af8ce..1b6c2e912ec8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1992,7 +1992,7 @@ static inline bool get_user_page_fast_only(unsigned long addr,
 /*
  * per-process(per-mm_struct) statistics.
  */
-static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
+static inline unsigned long get_mm_counter(struct mm_struct *mm, int member, int node)
 {
 	long val = atomic_long_read(&mm->rss_stat.count[member]);
 
@@ -2009,21 +2009,21 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 
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
 
@@ -2047,9 +2047,9 @@ static inline int mm_counter(struct page *page)
 
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
index c1bc6731125c..3e7da8c7ab95 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -48,6 +48,16 @@ enum {
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
index 6418083901d4..f8cd234084fe 100644
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
index c468fee595ff..b2c0fd668d01 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -652,7 +652,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
-		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR, page_to_nid(page));
 		mm_inc_nr_ptes(vma->vm_mm);
 		spin_unlock(vmf->ptl);
 		count_vm_event(THP_FAULT_ALLOC);
@@ -1064,7 +1064,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 				pmd = pmd_swp_mkuffd_wp(pmd);
 			set_pmd_at(src_mm, addr, src_pmd, pmd);
 		}
-		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR, page_to_nid(pmd_page(*dst_pmd)));
 		mm_inc_nr_ptes(dst_mm);
 		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
 		if (!userfaultfd_wp(dst_vma))
@@ -1114,7 +1114,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	get_page(src_page);
 	page_dup_rmap(src_page, true);
-	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR, page_to_nid(src_page));
 out_zero_page:
 	mm_inc_nr_ptes(dst_mm);
 	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
@@ -1597,11 +1597,12 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
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
@@ -1981,7 +1982,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			page_remove_rmap(page, vma, true);
 			put_page(page);
 		}
-		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
+		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR, page_to_nid(page));
 		return;
 	}
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a4e5eaf3eb01..3ceaae2c24c0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -742,7 +742,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 
 		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
 			clear_user_highpage(page, address);
-			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
+			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1, page_to_nid(page));
 			if (is_zero_pfn(pte_pfn(pteval))) {
 				/*
 				 * ptl mostly unnecessary.
@@ -1510,7 +1510,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	/* step 3: set proper refcount and mm_counters. */
 	if (count) {
 		page_ref_sub(hpage, count);
-		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
+		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count, page_to_nid(hpage));
 	}
 
 	/* step 4: collapse pmd */
diff --git a/mm/ksm.c b/mm/ksm.c
index 063a48eeb5ee..1185fa086a31 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1161,7 +1161,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		 * will get wrong values in /proc, and a BUG message in dmesg
 		 * when tearing down the mm.
 		 */
-		dec_mm_counter(mm, MM_ANONPAGES);
+		dec_mm_counter(mm, MM_ANONPAGES, page_to_nid(page));
 	}
 
 	flush_cache_page(vma, addr, pte_pfn(*ptep));
diff --git a/mm/madvise.c b/mm/madvise.c
index 1873616a37d2..819a1cf47d7d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -704,7 +704,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (current->mm == mm)
 			sync_mm_rss(mm);
 
-		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
+		add_mm_counter(mm, MM_SWAPENTS, nr_swap, NUMA_NO_NODE);
 	}
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
diff --git a/mm/memory.c b/mm/memory.c
index 76e3af9639d9..adb07fb0b483 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -158,6 +158,8 @@ EXPORT_SYMBOL(zero_pfn);
 
 unsigned long highest_memmap_pfn __read_mostly;
 
+static DEFINE_PER_CPU(int, percpu_numa_rss[MAX_NUMNODES]);
+
 /*
  * CONFIG_MMU architectures set up ZERO_PAGE in their paging_init()
  */
@@ -181,24 +183,24 @@ void sync_mm_rss(struct mm_struct *mm)
 
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
@@ -211,8 +213,8 @@ static void check_sync_rss_stat(struct task_struct *task)
 }
 #else /* SPLIT_RSS_COUNTING */
 
-#define inc_mm_counter_fast(mm, member) inc_mm_counter(mm, member)
-#define dec_mm_counter_fast(mm, member) dec_mm_counter(mm, member)
+#define inc_mm_counter_fast(mm, member, node) inc_mm_counter(mm, member, node)
+#define dec_mm_counter_fast(mm, member, node) dec_mm_counter(mm, member, node)
 
 static void check_sync_rss_stat(struct task_struct *task)
 {
@@ -490,12 +492,13 @@ int __pte_alloc_kernel(pmd_t *pmd)
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
 
@@ -503,7 +506,7 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
 		sync_mm_rss(mm);
 	for (i = 0; i < NR_MM_COUNTERS; i++)
 		if (rss[i])
-			add_mm_counter(mm, i, rss[i]);
+			add_mm_counter(mm, i, rss[i], NUMA_NO_NODE);
 }
 
 /*
@@ -771,7 +774,8 @@ try_restore_exclusive_pte(pte_t *src_pte, struct vm_area_struct *vma,
 static unsigned long
 copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *dst_vma,
-		struct vm_area_struct *src_vma, unsigned long addr, int *rss)
+		struct vm_area_struct *src_vma, unsigned long addr, int *rss,
+		int *numa_rss)
 {
 	unsigned long vm_flags = dst_vma->vm_flags;
 	pte_t pte = *src_pte;
@@ -791,10 +795,12 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			spin_unlock(&mmlist_lock);
 		}
 		rss[MM_SWAPENTS]++;
+		numa_rss[page_to_nid(pte_page(*dst_pte))]++;
 	} else if (is_migration_entry(entry)) {
 		page = pfn_swap_entry_to_page(entry);
 
 		rss[mm_counter(page)]++;
+		numa_rss[page_to_nid(page)]++;
 
 		if (is_writable_migration_entry(entry) &&
 				is_cow_mapping(vm_flags)) {
@@ -825,6 +831,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 */
 		get_page(page);
 		rss[mm_counter(page)]++;
+		numa_rss[page_to_nid(page)]++;
 		page_dup_rmap(page, false);
 
 		/*
@@ -884,7 +891,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 static inline int
 copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		  pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
-		  struct page **prealloc, pte_t pte, struct page *page)
+		  struct page **prealloc, pte_t pte, struct page *page, int *numa_rss)
 {
 	struct page *new_page;
 
@@ -918,6 +925,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	page_add_new_anon_rmap(new_page, dst_vma, addr, false);
 	lru_cache_add_inactive_or_unevictable(new_page, dst_vma);
 	rss[mm_counter(new_page)]++;
+	rss[page_to_nid(new_page)]++;
 
 	/* All done, just insert the new page copy in the child */
 	pte = mk_pte(new_page, dst_vma->vm_page_prot);
@@ -936,7 +944,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 static inline int
 copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
-		 struct page **prealloc)
+		 struct page **prealloc, int *numa_rss)
 {
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	unsigned long vm_flags = src_vma->vm_flags;
@@ -948,13 +956,14 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		int retval;
 
 		retval = copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
-					   addr, rss, prealloc, pte, page);
+					   addr, rss, prealloc, pte, page, numa_rss);
 		if (retval <= 0)
 			return retval;
 
 		get_page(page);
 		page_dup_rmap(page, false);
 		rss[mm_counter(page)]++;
+		numa_rss[page_to_nid(page)]++;
 	}
 
 	/*
@@ -1012,12 +1021,16 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
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
@@ -1050,7 +1063,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			ret = copy_nonpresent_pte(dst_mm, src_mm,
 						  dst_pte, src_pte,
 						  dst_vma, src_vma,
-						  addr, rss);
+						  addr, rss, numa_rss);
 			if (ret == -EIO) {
 				entry = pte_to_swp_entry(*src_pte);
 				break;
@@ -1069,7 +1082,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		}
 		/* copy_present_pte() will clear `*prealloc' if consumed */
 		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
-				       addr, rss, &prealloc);
+				       addr, rss, &prealloc, numa_rss);
 		/*
 		 * If we need a pre-allocated page for this pte, drop the
 		 * locks, allocate, and try again.
@@ -1092,7 +1105,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	arch_leave_lazy_mmu_mode();
 	spin_unlock(src_ptl);
 	pte_unmap(orig_src_pte);
-	add_mm_rss_vec(dst_mm, rss);
+	add_mm_rss_vec(dst_mm, rss, numa_rss);
 	pte_unmap_unlock(orig_dst_pte, dst_ptl);
 	cond_resched();
 
@@ -1121,6 +1134,10 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 out:
 	if (unlikely(prealloc))
 		put_page(prealloc);
+	if (unlikely(numa_rss == (int *)raw_cpu_ptr(&percpu_numa_rss)))
+		put_cpu_ptr(numa_rss);
+	else
+		kfree(numa_rss);
 	return ret;
 }
 
@@ -1344,14 +1361,18 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
@@ -1386,6 +1407,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 					mark_page_accessed(page);
 			}
 			rss[mm_counter(page)]--;
+			numa_rss[page_to_nid(page)]--;
 			page_remove_rmap(page, vma, false);
 			if (unlikely(page_mapcount(page) < 0))
 				print_bad_pte(vma, addr, ptent, page);
@@ -1404,6 +1426,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
 			rss[mm_counter(page)]--;
+			numa_rss[page_to_nid(page)]--;
 			if (is_device_private_entry(entry))
 				page_remove_rmap(page, vma, false);
 			put_page(page);
@@ -1419,6 +1442,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (!should_zap_page(details, page))
 				continue;
 			rss[mm_counter(page)]--;
+			numa_rss[page_to_nid(page)]--;
 		} else if (is_hwpoison_entry(entry)) {
 			if (!should_zap_cows(details))
 				continue;
@@ -1429,7 +1453,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
-	add_mm_rss_vec(mm, rss);
+	add_mm_rss_vec(mm, rss, numa_rss);
 	arch_leave_lazy_mmu_mode();
 
 	/* Do the actual TLB flush before dropping ptl */
@@ -1453,6 +1477,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		goto again;
 	}
 
+	if (unlikely(numa_rss == (int *)raw_cpu_ptr(&percpu_numa_rss)))
+		put_cpu_ptr(numa_rss);
+	else
+		kfree(numa_rss);
 	return addr;
 }
 
@@ -1767,7 +1795,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
 	get_page(page);
-	inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
+	inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page), page_to_nid(page));
 	page_add_file_rmap(page, vma, false);
 	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
 	return 0;
@@ -3053,11 +3081,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
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
@@ -3685,8 +3716,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (should_try_to_free_swap(page, vma, vmf->flags))
 		try_to_free_swap(page);
 
-	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
+	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES, page_to_nid(page));
+	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS, NUMA_NO_NODE);
 	pte = mk_pte(page, vma->vm_page_prot);
 
 	/*
@@ -3861,7 +3892,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
-	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
+	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES, page_to_nid(page));
 	page_add_new_anon_rmap(page, vma, vmf->address, false);
 	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
@@ -4002,7 +4033,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (write)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
-	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
+	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR, page_to_nid(page));
 	page_add_file_rmap(page, vma, true);
 
 	/*
@@ -4048,11 +4079,11 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
-		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
+		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES, page_to_nid(page));
 		page_add_new_anon_rmap(page, vma, addr, false);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
-		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
+		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page), page_to_nid(page));
 		page_add_file_rmap(page, vma, false);
 	}
 	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
diff --git a/mm/migrate.c b/mm/migrate.c
index 6c31ee1e1c9b..8554c7a64928 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -253,6 +253,8 @@ static bool remove_migration_pte(struct folio *folio,
 
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
+		add_mm_counter(vma->vm_mm, MM_ANONPAGES, -compound_nr(old), page_to_nid(old));
+		add_mm_counter(vma->vm_mm, MM_ANONPAGES, compound_nr(&folio->page), page_to_nid(&folio->page));
 	}
 
 	return true;
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 70c7dc05bbfc..eedd053febd8 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -609,7 +609,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	if (userfaultfd_missing(vma))
 		goto unlock_abort;
 
-	inc_mm_counter(mm, MM_ANONPAGES);
+	inc_mm_counter(mm, MM_ANONPAGES, page_to_nid(page));
 	page_add_new_anon_rmap(page, vma, addr, false);
 	if (!is_zone_device_page(page))
 		lru_cache_add_inactive_or_unevictable(page, vma);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 49d7df39b02d..757f5665ae94 100644
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
 
@@ -593,9 +593,9 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 
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
@@ -917,9 +917,9 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
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
index fedb82371efe..1566689476fc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1549,7 +1549,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 						     pvmw.pte, pteval,
 						     vma_mmu_pagesize(vma));
 			} else {
-				dec_mm_counter(mm, mm_counter(&folio->page));
+				dec_mm_counter(mm, mm_counter(&folio->page), page_to_nid(&folio->page));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -1564,7 +1564,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * migration) will not expect userfaults on already
 			 * copied pages.
 			 */
-			dec_mm_counter(mm, mm_counter(&folio->page));
+			dec_mm_counter(mm, mm_counter(&folio->page), page_to_nid(&folio->page));
 			/* We have to invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
@@ -1615,7 +1615,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					/* Invalidate as we cleared the pte */
 					mmu_notifier_invalidate_range(mm,
 						address, address + PAGE_SIZE);
-					dec_mm_counter(mm, MM_ANONPAGES);
+					dec_mm_counter(mm, MM_ANONPAGES, page_to_nid(&folio->page));
 					goto discard;
 				}
 
@@ -1648,8 +1648,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					list_add(&mm->mmlist, &init_mm.mmlist);
 				spin_unlock(&mmlist_lock);
 			}
-			dec_mm_counter(mm, MM_ANONPAGES);
-			inc_mm_counter(mm, MM_SWAPENTS);
+			dec_mm_counter(mm, MM_ANONPAGES, page_to_nid(&folio->page));
+			inc_mm_counter(mm, MM_SWAPENTS, NUMA_NO_NODE);
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_soft_dirty(pteval))
 				swp_pte = pte_swp_mksoft_dirty(swp_pte);
@@ -1671,7 +1671,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 *
 			 * See Documentation/vm/mmu_notifier.rst
 			 */
-			dec_mm_counter(mm, mm_counter_file(&folio->page));
+			dec_mm_counter(mm, mm_counter_file(&folio->page), page_to_nid(&folio->page));
 		}
 discard:
 		/*
@@ -1896,7 +1896,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 						     pvmw.pte, pteval,
 						     vma_mmu_pagesize(vma));
 			} else {
-				dec_mm_counter(mm, mm_counter(&folio->page));
+				dec_mm_counter(mm, mm_counter(&folio->page), page_to_nid(&folio->page));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -1911,7 +1911,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * migration) will not expect userfaults on already
 			 * copied pages.
 			 */
-			dec_mm_counter(mm, mm_counter(&folio->page));
+			dec_mm_counter(mm, mm_counter(&folio->page), page_to_nid(&folio->page));
 			/* We have to invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 63c61f8b2611..098bdb58109a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1796,8 +1796,8 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		goto out;
 	}
 
-	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
-	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
+	dec_mm_counter(vma->vm_mm, MM_SWAPENTS, NUMA_NO_NODE);
+	inc_mm_counter(vma->vm_mm, MM_ANONPAGES, page_to_nid(page));
 	get_page(page);
 	if (page == swapcache) {
 		page_add_anon_rmap(page, vma, addr, false);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e9bb6db002aa..0355285a3d6f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -112,7 +112,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	 * Must happen after rmap, as mm_counter() checks mapping (via
 	 * PageAnon()), which is set by __page_set_anon_rmap().
 	 */
-	inc_mm_counter(dst_mm, mm_counter(page));
+	inc_mm_counter(dst_mm, mm_counter(page), page_to_nid(page));
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
-- 
2.20.1

