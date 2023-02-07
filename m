Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3AE68CDAE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjBGDxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBGDxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:53:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8380534C18;
        Mon,  6 Feb 2023 19:53:11 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o16-20020a17090ad25000b00230759a8c06so10558922pjw.2;
        Mon, 06 Feb 2023 19:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZij7LuvWqAUsc/tDyGKqVPa1LlLe014JzLJaRBVfac=;
        b=lwCPmEll3sOd5wCDntj64zUMlsIheRAjUYsSQaWXGrPEqqe5HN4xQyzTELcYR8EuUo
         UUzJtsuAS7oEwIk7LobPrcjseI3GOXqxJ6Ql9s2vibYXBJLETeFhrYgdz5FBuT1maHjz
         smYCxO1fRZJ0sVU7uY23VbWtRRcdj5GLh90hmDin4Kz6Y35MbZgiujZ2Tb+g9rx72+Ep
         q5ooXDOByXEEJWEOHbraaoSVRCP+W026b9+2nnOCT6+M2ac7ycU2fAMC6B355Rx1mDSE
         16dKTc35HJXmCGZUMjhvzoiE/9Crg/rFt+u4yvL0Detc0cbvOFP9nMLl4OsC3eZSnrMj
         Ivnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZij7LuvWqAUsc/tDyGKqVPa1LlLe014JzLJaRBVfac=;
        b=jjRNIGVgKCh5Hnw35I7Whmlnt+pzHJBsh4446f1MJWDBTjst7KDTJ9DY4R9BOIx7bj
         Rg3ip5M8gcu1iRG/YV+LZyDOOQr61JE6ufmvi8xhFA7TC2GBQigqqdZ+aSgIf7oTumy7
         rPbAFcDOdYoHYo9ZgAfjx7rvkdnBgvag8xVoObI6HXgDc0DmUXxSAhtPagdulIyOEtbi
         AN2IdTN19TrZjmW6+PrM9VAnlrU832rZymhNNn6UG9fsif9yrmVm12oxMM9XcuvxjL8d
         hiFm8U373TqS/0qYjMko2Wf/KLIEm8jgrrcCMch7StVrCpg5SUoQJZpIlDWIDu7SF6BE
         NF1A==
X-Gm-Message-State: AO0yUKUTIh6bxYwrDwtuYds5V3ckx3KQZwb72YIYaowCFDYMz//2077q
        h46aurr6066iaVxANyNKBcw=
X-Google-Smtp-Source: AK7set8e20ND70PIGz9eIdz6VNDFMIz/ERt5LiGEHQbdbQ4KvYIrKJ5UCXWnKI0Q4kYNn9Zk/Apy9A==
X-Received: by 2002:a05:6a20:7f95:b0:c1:2037:554f with SMTP id d21-20020a056a207f9500b000c12037554fmr2308038pzj.62.1675741990219;
        Mon, 06 Feb 2023 19:53:10 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:53:09 -0800 (PST)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Barry Song <baohua@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Li kunyu <kunyu@nfschina.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Barret Rhoden <brho@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [PATCH v4 03/14] mm: Add break COW PTE fault and helper functions
Date:   Tue,  7 Feb 2023 11:51:28 +0800
Message-Id: <20230207035139.272707-4-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207035139.272707-1-shiyn.lin@gmail.com>
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the function, handle_cow_pte_fault(), to break (unshare) COW-ed PTE
with the page fault that will modify the PTE table or the mapped page
resided in COW-ed PTE (i.e., write, unshared, file read fault).

When breaking COW PTE, it first checks COW-ed PTE's refcount to try to
reuse it. If COW-ed PTE cannot be reused, allocates new PTE and
duplicates all pte entries in COW-ed PTE. Moreover, Flush TLB when we
change the write protection of PTE.

In addition, provide the helper functions, break_cow_pte{,_range}(), to
let the other features (remap, THP, migration, swapfile, etc) to use.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/mm.h      |  17 ++
 include/linux/pgtable.h |   6 +
 mm/memory.c             | 339 +++++++++++++++++++++++++++++++++++++++-
 mm/mmap.c               |   4 +
 mm/mremap.c             |   2 +
 mm/swapfile.c           |   2 +
 6 files changed, 363 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 22e1e5804e96..369355e13936 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2020,6 +2020,23 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to);
 void truncate_pagecache_range(struct inode *inode, loff_t offset, loff_t end);
 int generic_error_remove_page(struct address_space *mapping, struct page *page);
 
+#ifdef CONFIG_COW_PTE
+int break_cow_pte(struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr);
+int break_cow_pte_range(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end);
+#else
+static inline int break_cow_pte(struct vm_area_struct *vma,
+				pmd_t *pmd, unsigned long addr)
+{
+	return 0;
+}
+static inline int break_cow_pte_range(struct vm_area_struct *vma,
+				      unsigned long start, unsigned long end)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_MMU
 extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
 				  unsigned long address, unsigned int flags,
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1159b25b0542..72ff2a1cee5e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1406,6 +1406,12 @@ static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
 	if (pmd_none(pmdval) || pmd_trans_huge(pmdval) ||
 		(IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION) && !pmd_present(pmdval)))
 		return 1;
+	/*
+	 * COW-ed PTE has write protection which can trigger pmd_bad().
+	 * To avoid this, return here if entry is write protection.
+	 */
+	if (!pmd_write(pmdval))
+		return 0;
 	if (unlikely(pmd_bad(pmdval))) {
 		pmd_clear_bad(pmd);
 		return 1;
diff --git a/mm/memory.c b/mm/memory.c
index 7d2a1d24db56..465742c6efa2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -192,6 +192,36 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
+#ifdef CONFIG_COW_PTE
+		/*
+		 * For COW-ed PTE, the pte entries still mapping to pages.
+		 * However, we should did de-accounting to all of it. So,
+		 * even if the refcount is not the same as zapping, we
+		 * could still fall back to normal PTE and handle it
+		 * without traversing entries to do the de-accounting.
+		 */
+		if (test_bit(MMF_COW_PTE, &tlb->mm->flags)) {
+			if (!pmd_none(*pmd) && !pmd_write(*pmd)) {
+				spinlock_t *ptl = pte_lockptr(tlb->mm, pmd);
+
+				spin_lock(ptl);
+				if (!pmd_put_pte(pmd)) {
+					pmd_t new = pmd_mkwrite(*pmd);
+
+					set_pmd_at(tlb->mm, addr, pmd, new);
+					spin_unlock(ptl);
+					free_pte_range(tlb, pmd, addr);
+					continue;
+				}
+				spin_unlock(ptl);
+
+				pmd_clear(pmd);
+				mm_dec_nr_ptes(tlb->mm);
+				tlb_flush_pmd_range(tlb, addr, PAGE_SIZE);
+			} else
+				VM_WARN_ON(cow_pte_count(pmd) != 1);
+		}
+#endif
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
 		free_pte_range(tlb, pmd, addr);
@@ -1654,6 +1684,29 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *start_pte;
 	pte_t *pte;
 	swp_entry_t entry;
+	bool pte_is_shared = false;
+
+#ifdef CONFIG_COW_PTE
+	if (test_bit(MMF_COW_PTE, &mm->flags) && !pmd_write(*pmd)) {
+		if (!range_in_vma(vma, addr & PMD_MASK,
+				  (addr + PMD_SIZE) & PMD_MASK)) {
+			/*
+			 * We cannot promise this COW-ed PTE will also be zap
+			 * with the rest of VMAs. So, break COW PTE here.
+			 */
+			break_cow_pte(vma, pmd, addr);
+		} else {
+			start_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			if (cow_pte_count(pmd) == 1) {
+				/* Reuse COW-ed PTE */
+				pmd_t new = pmd_mkwrite(*pmd);
+				set_pmd_at(tlb->mm, addr, pmd, new);
+			} else
+				pte_is_shared = true;
+			pte_unmap_unlock(start_pte, ptl);
+		}
+	}
+#endif
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 again:
@@ -1678,11 +1731,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
+			if (pte_is_shared)
+				ptent = *pte;
+			else
+				ptent = ptep_get_and_clear_full(mm, addr, pte,
+								tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
-			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
-						      ptent);
+			if (!pte_is_shared)
+				zap_install_uffd_wp_if_needed(vma, addr, pte,
+							      details, ptent);
 			if (unlikely(!page))
 				continue;
 
@@ -1754,8 +1811,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			/* We should have covered all the swap entry types */
 			WARN_ON_ONCE(1);
 		}
-		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
-		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
+
+		if (!pte_is_shared) {
+			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+			zap_install_uffd_wp_if_needed(vma, addr, pte,
+						      details, ptent);
+		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	add_mm_rss_vec(mm, rss);
@@ -2143,6 +2204,8 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	if (retval)
 		goto out;
 	retval = -ENOMEM;
+	if (break_cow_pte(vma, NULL, addr))
+		goto out;
 	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
 	if (!pte)
 		goto out;
@@ -2402,6 +2465,9 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	pte_t *pte, entry;
 	spinlock_t *ptl;
 
+	if (break_cow_pte(vma, NULL, addr))
+		return VM_FAULT_OOM;
+
 	pte = get_locked_pte(mm, addr, &ptl);
 	if (!pte)
 		return VM_FAULT_OOM;
@@ -2779,6 +2845,10 @@ int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
 	BUG_ON(addr >= end);
 	pfn -= addr >> PAGE_SHIFT;
 	pgd = pgd_offset(mm, addr);
+
+	if (break_cow_pte_range(vma, addr, end))
+		return -ENOMEM;
+
 	flush_cache_range(vma, addr, end);
 	do {
 		next = pgd_addr_end(addr, end);
@@ -5159,6 +5229,233 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 	return VM_FAULT_FALLBACK;
 }
 
+#ifdef CONFIG_COW_PTE
+/* Break (unshare) COW PTE */
+static vm_fault_t handle_cow_pte_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
+	pmd_t *pmd = vmf->pmd;
+	unsigned long start, end, addr = vmf->address;
+	struct mmu_notifier_range range;
+	pmd_t cowed_entry;
+	pte_t *orig_dst_pte, *orig_src_pte;
+	pte_t *dst_pte, *src_pte;
+	spinlock_t *dst_ptl, *src_ptl;
+	int ret = 0;
+
+	/*
+	 * Do nothing with the fault that doesn't have PTE yet
+	 * (from lazy fork).
+	 */
+	if (pmd_none(*pmd) || pmd_write(*pmd))
+		return 0;
+	/* COW PTE doesn't handle huge page. */
+	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
+		return 0;
+
+	mmap_assert_write_locked(mm);
+
+	start = addr & PMD_MASK;
+	end = (addr + PMD_SIZE) & PMD_MASK;
+	addr = start;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
+				0, vma, mm, start, end);
+	/*
+	 * Because of the address range is PTE not only for the faulted
+	 * vma, it might have some unmatch situations since mmu notifier
+	 * will only reigster the faulted vma.
+	 * Do we really need to care about this kind of unmatch?
+	 */
+	mmu_notifier_invalidate_range_start(&range);
+	raw_write_seqcount_begin(&mm->write_protect_seq);
+
+	/*
+	 * Fast path, check if we are the only one faulted task
+	 * references to this COW-ed PTE, reuse it.
+	 */
+	src_pte = pte_offset_map_lock(mm, pmd, addr, &src_ptl);
+	if (cow_pte_count(pmd) == 1) {
+		pmd_t new = pmd_mkwrite(*pmd);
+		set_pmd_at(mm, addr, pmd, new);
+		pte_unmap_unlock(src_pte, src_ptl);
+		goto flush_tlb;
+	}
+	/* We don't hold the lock when allocating the new PTE. */
+	pte_unmap_unlock(src_pte, src_ptl);
+
+	/*
+	 * Slow path. Since we already did the accounting and still
+	 * sharing the mapped pages, we can just clone PTE.
+	 */
+
+	cowed_entry = READ_ONCE(*pmd);
+	/* Decrease the pgtable_bytes of COW-ed PTE. */
+	mm_dec_nr_ptes(mm);
+	pmd_clear(pmd);
+	orig_dst_pte = dst_pte = pte_alloc_map_lock(mm, pmd, addr, &dst_ptl);
+	if (unlikely(!dst_pte)) {
+		/* If allocation failed, restore COW-ed PTE. */
+		set_pmd_at(mm, addr, pmd, cowed_entry);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * We should hold the lock of COW-ed PTE until all the operations
+	 * have been done, including duplicating, and decrease refcount.
+	 */
+	src_pte = pte_offset_map_lock(mm, &cowed_entry, addr, &src_ptl);
+	orig_src_pte = src_pte;
+	arch_enter_lazy_mmu_mode();
+
+	/*
+	 * All the mapped pages in COW-ed PTE are COW mapping. We can
+	 * set the entries and leave other stuff to handle_pte_fault().
+	 */
+	do {
+		if (pte_none(*src_pte))
+			continue;
+		set_pte_at(mm, addr, dst_pte, *src_pte);
+	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
+
+	arch_leave_lazy_mmu_mode();
+	pte_unmap_unlock(orig_dst_pte, dst_ptl);
+
+	/* Decrease the refcount of COW-ed PTE. */
+	if (!pmd_put_pte(&cowed_entry)) {
+		/*
+		 * COW-ed (old) PTE's refcount is 1. Now we have two PTEs
+		 * with the same content. Free the new one and reuse the
+		 * old one.
+		 */
+		pgtable_t token = pmd_pgtable(*pmd);
+		/* Reuse COW-ed PTE. */
+		pmd_t new = pmd_mkwrite(cowed_entry);
+
+		/* Clear all the entries of new PTE. */
+		addr = start;
+		dst_pte = pte_offset_map_lock(mm, pmd, addr, &dst_ptl);
+		orig_dst_pte = dst_pte;
+		do {
+			if (pte_none(*dst_pte))
+				continue;
+			if (pte_present(*dst_pte))
+				page_table_check_pte_clear(mm, addr, *dst_pte);
+			pte_clear(mm, addr, dst_pte);
+		} while (dst_pte++, addr += PAGE_SIZE, addr != end);
+		pte_unmap_unlock(orig_dst_pte, dst_ptl);
+		/* Now, we can safely free new PTE. */
+		pmd_clear(pmd);
+		pte_free(mm, token);
+		/* Reuse COW-ed PTE */
+		set_pmd_at(mm, start, pmd, new);
+	}
+
+	pte_unmap_unlock(orig_src_pte, src_ptl);
+
+flush_tlb:
+	/*
+	 * If we change the protection, flush TLB.
+	 * flush_tlb_range() will only use vma to get mm, we don't need
+	 * to consider the unmatch address range with vma problem here.
+	 *
+	 * Should we flush TLB when holding the pte lock?
+	 */
+	flush_tlb_range(vma, start, end);
+out:
+	raw_write_seqcount_end(&mm->write_protect_seq);
+	mmu_notifier_invalidate_range_end(&range);
+
+	return ret;
+}
+
+static inline int __break_cow_pte(struct vm_area_struct *vma, pmd_t *pmd,
+				  unsigned long addr)
+{
+	struct vm_fault vmf = {
+		.vma = vma,
+		.address = addr & PAGE_MASK,
+		.pmd = pmd,
+	};
+
+	return handle_cow_pte_fault(&vmf);
+}
+
+/**
+ * break_cow_pte - duplicate/reuse shared, wprotected (COW-ed) PTE
+ * @vma: target vma want to break COW
+ * @pmd: pmd index that maps to the shared PTE
+ * @addr: the address trigger break COW PTE
+ *
+ * Return: zero on success, < 0 otherwise.
+ *
+ * The address needs to be in the range of shared and write portected
+ * PTE that the pmd index mapped. If pmd is NULL, it will get the pmd
+ * from vma. Duplicate COW-ed PTE when some still mapping to it.
+ * Otherwise, reuse COW-ed PTE.
+ */
+int break_cow_pte(struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr)
+{
+	struct mm_struct *mm;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+
+	if (!vma)
+		return -EINVAL;
+	mm = vma->vm_mm;
+
+	if (!test_bit(MMF_COW_PTE, &mm->flags))
+		return 0;
+
+	if (!pmd) {
+		pgd = pgd_offset(mm, addr);
+		if (pgd_none_or_clear_bad(pgd))
+			return 0;
+		p4d = p4d_offset(pgd, addr);
+		if (p4d_none_or_clear_bad(p4d))
+			return 0;
+		pud = pud_offset(p4d, addr);
+		if (pud_none_or_clear_bad(pud))
+			return 0;
+		pmd = pmd_offset(pud, addr);
+	}
+
+	/* We will check the type of pmd entry later. */
+
+	return __break_cow_pte(vma, pmd, addr);
+}
+
+/**
+ * break_cow_pte_range - duplicate/reuse COW-ed PTE in a given range
+ * @vma: target vma want to break COW
+ * @start: the address of start breaking
+ * @end: the address of end breaking
+ *
+ * Return: zero on success, the number of failed otherwise.
+ */
+int break_cow_pte_range(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end)
+{
+	unsigned long addr, next;
+	int nr_failed = 0;
+
+	if (!range_in_vma(vma, start, end))
+		return -EINVAL;
+
+	addr = start;
+	do {
+		next = pmd_addr_end(addr, end);
+		if (break_cow_pte(vma, NULL, addr))
+			nr_failed++;
+	} while (addr = next, addr != end);
+
+	return nr_failed;
+}
+#endif /* CONFIG_COW_PTE */
+
 /*
  * These routines also need to handle stuff like marking pages dirty
  * and/or accessed for architectures that don't do it in hardware (most
@@ -5234,8 +5531,13 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			return do_fault(vmf);
 	}
 
-	if (!pte_present(vmf->orig_pte))
+	if (!pte_present(vmf->orig_pte)) {
+#ifdef CONFIG_COW_PTE
+		if (test_bit(MMF_COW_PTE, &vmf->vma->vm_mm->flags))
+			handle_cow_pte_fault(vmf);
+#endif
 		return do_swap_page(vmf);
+	}
 
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
@@ -5371,8 +5673,31 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 				return 0;
 			}
 		}
+#ifdef CONFIG_COW_PTE
+		/*
+		 * Duplicate COW-ed PTE when page fault will change the
+		 * mapped pages (write or unshared fault) or COW-ed PTE
+		 * (file mapped read fault, see do_read_fault()).
+		 */
+		if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE) ||
+		      vma->vm_ops) && test_bit(MMF_COW_PTE, &mm->flags)) {
+			ret = handle_cow_pte_fault(&vmf);
+			if (unlikely(ret == -ENOMEM))
+				return VM_FAULT_OOM;
+		}
+#endif
 	}
 
+#ifdef CONFIG_COW_PTE
+	/*
+	 * It's definitely will break the kernel when refcount of PTE
+	 * is higher than 1 and it is writeable in PMD entry. But we
+	 * want to see more information so just warning here.
+	 */
+	if (likely(!pmd_none(*vmf.pmd)))
+		VM_WARN_ON(cow_pte_count(vmf.pmd) > 1 && pmd_write(*vmf.pmd));
+#endif
+
 	return handle_pte_fault(&vmf);
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 425a9349e610..ca16d7abcdb6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2208,6 +2208,10 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 			return err;
 	}
 
+	err = break_cow_pte(vma, NULL, addr);
+	if (err)
+		return err;
+
 	new = vm_area_dup(vma);
 	if (!new)
 		return -ENOMEM;
diff --git a/mm/mremap.c b/mm/mremap.c
index 930f65c315c0..3fbc45e381cc 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -534,6 +534,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
 		if (!old_pmd)
 			continue;
+		/* TLB flush twice time here? */
+		break_cow_pte(vma, old_pmd, old_addr);
 		new_pmd = alloc_new_pmd(vma->vm_mm, vma, new_addr);
 		if (!new_pmd)
 			break;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4fa440e87cd6..92e39a722100 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1911,6 +1911,8 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 			continue;
+		if (break_cow_pte(vma, pmd, addr))
+			return -ENOMEM;
 		ret = unuse_pte_range(vma, pmd, addr, next, type);
 		if (ret)
 			return ret;
-- 
2.34.1

