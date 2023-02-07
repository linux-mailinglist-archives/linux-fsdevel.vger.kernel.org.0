Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4B68CDAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBGDxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBGDxT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:53:19 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746652FCC1;
        Mon,  6 Feb 2023 19:52:58 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b5so14380134plz.5;
        Mon, 06 Feb 2023 19:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo1tneLWwD2RhiZr7s0fNkFVvi/jYX7dsdS6SUFT8xM=;
        b=JGWqJchBnYVuac0oRm4Gs0CVChNaex/V6id79yjo6Pc49o4y2daSY6qA1Q6KXNfcHU
         dkBweq6GC/8dy9lcJjk16orPIoGqCkGn6VTu+AjsqPGTdNDmm4HWf8/We9Rhi4NLBVYg
         HaBMWnPebrPu8F8WkJotpDYqZSXLP19PQyuFmeRX9Wg6gUpQ5r8oKftolWojfhdEuJr6
         Z4OLASTNlYZIm+xFtUPJhTFo8Ci2y0rmW2pvV7JcvG8VuJRaSEpqBeCqGQxUMuMBjxoV
         vckW3Gc7QBdhjq4QEcLkQqWgDrUU3Xq4LfhEHtdATQ1Vocx8BgoJKHxsoUtkYZvTVTZ1
         22CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo1tneLWwD2RhiZr7s0fNkFVvi/jYX7dsdS6SUFT8xM=;
        b=AShGels9TXCLkUNt+fU3JFx5fM3GlC5/HrlTK6sMh7LpITAvAx8Yl+ODc2udsKACEl
         bkGHZd6IODY+A9wrj/cOWerGOt7il37lIpQ3/x0g1wbrEFqzjZg+TAC4bVGuXZjonFv6
         om41FiwRPrNx3HkSCwgT6gkkY2H0MkAvTGozs/LP/lYBThwjrmr5AyBi4VJlWtd8L/+1
         PCNKUCkKe493Nn+N1U+aKEk9hkfF1yCFRU5h57+i6lRzxc0W88IVWT/kn1K22F+NIghO
         GkWzUKI+gw7tqtnfih4rHsN/LzORMgz9+lT2fEPP1kxQrr7kjd8SqANOu2HAZl2qwtH/
         Z1uw==
X-Gm-Message-State: AO0yUKWc8bIWMr4k1eqFW9nR9wch3H7AoKBHI5A/sOdgH5+XMODbl1tL
        2fmhE9F6EXig2JLfCwBEDRg=
X-Google-Smtp-Source: AK7set/O7fcqmc6lLHaEVj1xEAfz8V3jwreohn2OTW5/SjFcXEbRoD9lnlHTuhQMmfHw7SNcGwH2HA==
X-Received: by 2002:a17:902:e5c7:b0:196:8b36:d135 with SMTP id u7-20020a170902e5c700b001968b36d135mr1442730plf.62.1675741977709;
        Mon, 06 Feb 2023 19:52:57 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:52:56 -0800 (PST)
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
Subject: [PATCH v4 02/14] mm: Add Copy-On-Write PTE to fork()
Date:   Tue,  7 Feb 2023 11:51:27 +0800
Message-Id: <20230207035139.272707-3-shiyn.lin@gmail.com>
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

Add copy_cow_pte_range() and recover_pte_range() for copy-on-write (COW)
PTE in fork system call. During COW PTE fork, when processing the shared
PTE, we traverse all the entries to determine current mapped page is
available to share between processes. If PTE can be shared, account
those mapped pages and then share the PTE. However, once we find out the
mapped page is unavailable, e.g., pinned page, we have to copy it via
copy_present_page(), which means that we will fall back to default path,
page table copying (copy_pte_range()). And, since we may have already
processed some COW-ed PTE entries, before starting the default path, we
have to recover those entries.

All the COW PTE behaviors are protected by the pte lock.
The logic of how we handle nonpresent/present pte entries and error
in copy_cow_pte_range() is same as copy_pte_range(). But to keep the
codes clean (e.g., avoiding condition lock), we introduce new functions
instead of modifying copy_pte_range().

To track the lifetime of COW-ed PTE, introduce the refcount of PTE.
We reuse the _refcount in struct page for the page table to maintain the
number of process references to COW-ed PTE table. Doing the fork with
COW PTE will increase the refcount. And, when someone writes to the
COW-ed PTE, it will cause the write fault to break COW PTE. If the
refcount of COW-ed PTE is one, the process that triggers the fault will
reuse the COW-ed PTE. Otherwise, the process will decrease the refcount
and duplicate it.

Since we share the PTE between the parent and child, the state of the
parent's pte entries is different between COW PTE and the normal fork.
COW PTE handles all the pte entries on the child side which means it
will clear the dirty and access bit of the parent's pte entry.

And, since some of the architectures, e.g., s390 and powerpc32, don't
support the PMD entry and PTE table operations, add a new Kconfig,
COW_PTE. COW_PTE config depends on the (HAVE_ARCH_TRANSPARENT_HUGEPAGE
&& !PREEMPT_RT) condition, it is same as the TRANSPARENT_HUGEPAGE
config since most of the operations in COW PTE are depend on it.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/mm.h |  20 +++
 mm/Kconfig         |   9 ++
 mm/memory.c        | 303 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 332 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f857163ac89..22e1e5804e96 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2482,6 +2482,23 @@ static inline bool ptlock_init(struct page *page) { return true; }
 static inline void ptlock_free(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
+#ifdef CONFIG_COW_PTE
+static inline int pmd_get_pte(pmd_t *pmd)
+{
+	return page_ref_inc_return(pmd_page(*pmd));
+}
+
+static inline bool pmd_put_pte(pmd_t *pmd)
+{
+	return page_ref_add_unless(pmd_page(*pmd), -1, 1);
+}
+
+static inline int cow_pte_count(pmd_t *pmd)
+{
+	return page_count(pmd_page(*pmd));
+}
+#endif
+
 static inline void pgtable_init(void)
 {
 	ptlock_cache_init();
@@ -2494,6 +2511,9 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
+#ifdef CONFIG_COW_PTE
+	set_page_count(page, 1);
+#endif
 	return true;
 }
 
diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec05..7dcceeb4196b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -822,6 +822,15 @@ config READ_ONLY_THP_FOR_FS
 
 endif # TRANSPARENT_HUGEPAGE
 
+menuconfig COW_PTE
+	bool "Copy-on-write PTE table"
+	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
+	help
+	  Extend the copy-on-write (COW) mechanism to the PTE table
+	  (the bottom level of the page-table hierarchy). To enable this
+	  feature, a process must set prctl(PR_SET_COW_PTE) before the
+	  fork system call.
+
 #
 # UP and nommu archs use km based percpu allocator
 #
diff --git a/mm/memory.c b/mm/memory.c
index 3e836fecd035..7d2a1d24db56 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -739,11 +739,17 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *dst_vma,
 		struct vm_area_struct *src_vma, unsigned long addr, int *rss)
 {
+	/* With COW PTE, dst_vma is src_vma. */
 	unsigned long vm_flags = dst_vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
 	swp_entry_t entry = pte_to_swp_entry(pte);
 
+	/*
+	 * If it's COW PTE, parent shares PTE with child. Which means the
+	 * following modifications of child will also affect parent.
+	 */
+
 	if (likely(!non_swap_entry(entry))) {
 		if (swap_duplicate(entry) < 0)
 			return -EIO;
@@ -886,6 +892,8 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 /*
  * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
  * is required to copy this pte.
+ * However, if prealloc is NULL, it is COW PTE. We should return and fall back
+ * to copy the PTE table.
  */
 static inline int
 copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
@@ -909,6 +917,14 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
 			/* Page maybe pinned, we have to copy. */
 			put_page(page);
+			/*
+			 * If prealloc is NULL, we are processing share page
+			 * table (COW PTE, in copy_cow_pte_range()). We cannot
+			 * call copy_present_page() right now, instead, we
+			 * should fall back to copy_pte_range().
+			 */
+			if (!prealloc)
+				return -EAGAIN;
 			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
 						 addr, rss, prealloc, page);
 		}
@@ -929,6 +945,11 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	}
 	VM_BUG_ON(page && PageAnon(page) && PageAnonExclusive(page));
 
+	/*
+	 * If it's COW PTE, parent shares PTE with child.
+	 * Which means the following will also affect parent.
+	 */
+
 	/*
 	 * If it's a shared mapping, mark it clean in
 	 * the child
@@ -937,6 +958,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
 
+	/* For COW PTE, dst_vma is still src_vma. */
 	if (!userfaultfd_wp(dst_vma))
 		pte = pte_clear_uffd_wp(pte);
 
@@ -963,6 +985,8 @@ page_copy_prealloc(struct mm_struct *src_mm, struct vm_area_struct *vma,
 	return new_page;
 }
 
+
+/* copy_pte_range() will immediately allocate new page table. */
 static int
 copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	       pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
@@ -1087,6 +1111,227 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	return ret;
 }
 
+#ifdef CONFIG_COW_PTE
+/*
+ * copy_cow_pte_range() will try to share the page table with child.
+ * The logic of non-present, present and error handling is same as
+ * copy_pte_range() but dst_vma and dst_pte are src_vma and src_pte.
+ *
+ * We cannot preserve soft-dirty information, because PTE will share
+ * between multiple processes.
+ */
+static int
+copy_cow_pte_range(struct vm_area_struct *dst_vma,
+		   struct vm_area_struct *src_vma,
+		   pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
+		   unsigned long end, unsigned long *recover_end)
+{
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
+	struct vma_iterator vmi;
+	struct vm_area_struct *curr = src_vma;
+	pte_t *src_pte, *orig_src_pte;
+	spinlock_t *src_ptl;
+	int ret = 0;
+	int rss[NR_MM_COUNTERS];
+	swp_entry_t entry = (swp_entry_t){0};
+	unsigned long vm_end, orig_addr = addr;
+	pgtable_t pte_table = pmd_pgtable(*src_pmd);
+
+	end = (addr + PMD_SIZE) & PMD_MASK;
+	addr = addr & PMD_MASK;
+
+	/*
+	 * Increase the refcount to prevent the parent's PTE
+	 * dropped/reused. Only increace the refcount at first
+	 * time attached.
+	 */
+	src_ptl = pte_lockptr(src_mm, src_pmd);
+	spin_lock(src_ptl);
+	pmd_get_pte(src_pmd);
+	pmd_install(dst_mm, dst_pmd, &pte_table);
+	spin_unlock(src_ptl);
+
+	/*
+	 * We should handle all of the entries in this PTE at this traversal,
+	 * since we cannot promise that the next vma will not do the lazy fork.
+	 * The lazy fork will skip the copying, which may cause the incomplete
+	 * state of COW-ed PTE.
+	 */
+	vma_iter_init(&vmi, src_mm, addr);
+	for_each_vma_range(vmi, curr, end) {
+		vm_end = min(end, curr->vm_end);
+		addr = max(addr, curr->vm_start);
+
+		/* We don't share the PTE with VM_DONTCOPY. */
+		if (curr->vm_flags & VM_DONTCOPY) {
+			*recover_end = addr;
+			return -EAGAIN;
+		}
+again:
+		init_rss_vec(rss);
+		src_pte = pte_offset_map(src_pmd, addr);
+		src_ptl = pte_lockptr(src_mm, src_pmd);
+		orig_src_pte = src_pte;
+		spin_lock(src_ptl);
+		arch_enter_lazy_mmu_mode();
+
+		do {
+			if (pte_none(*src_pte))
+				continue;
+			if (unlikely(!pte_present(*src_pte))) {
+				/*
+				 * Although, parent's PTE is COW-ed, we should
+				 * still need to handle all the swap stuffs.
+				 */
+				ret = copy_nonpresent_pte(dst_mm, src_mm,
+							  src_pte, src_pte,
+							  curr, curr,
+							  addr, rss);
+				if (ret == -EIO) {
+					entry = pte_to_swp_entry(*src_pte);
+					break;
+				} else if (ret == -EBUSY) {
+					break;
+				} else if (!ret)
+					continue;
+				/*
+				 * Device exclusive entry restored, continue by
+				 * copying the now present pte.
+				 */
+				WARN_ON_ONCE(ret != -ENOENT);
+			}
+			/*
+			 * copy_present_pte() will determine the mapped page
+			 * should be COW mapping or not.
+			 */
+			ret = copy_present_pte(curr, curr, src_pte, src_pte,
+					       addr, rss, NULL);
+			/*
+			 * If we need a pre-allocated page for this pte,
+			 * drop the lock, recover all the entries, fall
+			 * back to copy_pte_range(), and try again.
+			 */
+			if (unlikely(ret == -EAGAIN))
+				break;
+		} while (src_pte++, addr += PAGE_SIZE, addr != vm_end);
+
+		arch_leave_lazy_mmu_mode();
+		add_mm_rss_vec(dst_mm, rss);
+		spin_unlock(src_ptl);
+		pte_unmap(orig_src_pte);
+		cond_resched();
+
+		if (ret == -EIO) {
+			VM_WARN_ON_ONCE(!entry.val);
+			if (add_swap_count_continuation(entry, GFP_KERNEL) < 0) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			entry.val = 0;
+		} else if (ret == -EBUSY) {
+			goto out;
+		} else if (ret == -EAGAIN) {
+			/*
+			 * We've to allocate the page immediately but first we
+			 * should recover the processed entries and fall back
+			 * to copy_pte_range().
+			 */
+			*recover_end = addr;
+			return -EAGAIN;
+		} else if (ret) {
+			VM_WARN_ON_ONCE(1);
+		}
+
+		/* We've captured and resolved the error. Reset, try again. */
+		ret = 0;
+		if (addr != vm_end)
+			goto again;
+	}
+
+out:
+	/*
+	 * All the pte entries are available to COW mapping.
+	 * Now, we can share with child (COW PTE).
+	 */
+	pmdp_set_wrprotect(src_mm, orig_addr, src_pmd);
+	set_pmd_at(dst_mm, orig_addr, dst_pmd, pmd_wrprotect(*src_pmd));
+
+	return ret;
+}
+
+/* When recovering the pte entries, we should hold the locks entirely. */
+static int
+recover_pte_range(struct vm_area_struct *dst_vma,
+		  struct vm_area_struct *src_vma,
+		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long end)
+{
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	struct mm_struct *src_mm = src_vma->vm_mm;
+	struct vma_iterator vmi;
+	struct vm_area_struct *curr = src_vma;
+	pte_t *orig_src_pte, *orig_dst_pte;
+	pte_t *src_pte, *dst_pte;
+	spinlock_t *src_ptl, *dst_ptl;
+	unsigned long vm_end, addr = end & PMD_MASK;
+	int ret = 0;
+
+	/* Before we allocate the new PTE, clear the entry. */
+	mm_dec_nr_ptes(dst_mm);
+	pmd_clear(dst_pmd);
+	if (pte_alloc(dst_mm, dst_pmd))
+		return -ENOMEM;
+
+	/*
+	 * Traverse all the vmas that cover this PTE table until
+	 * the end of recover address (unshareable page).
+	 */
+	vma_iter_init(&vmi, src_mm, addr);
+	for_each_vma_range(vmi, curr, end) {
+		vm_end = min(end, curr->vm_end);
+		addr = max(addr, curr->vm_start);
+
+		orig_dst_pte = dst_pte = pte_offset_map(dst_pmd, addr);
+		dst_ptl = pte_lockptr(dst_mm, dst_pmd);
+		spin_lock(dst_ptl);
+
+		orig_src_pte = src_pte = pte_offset_map(src_pmd, addr);
+		src_ptl = pte_lockptr(src_mm, src_pmd);
+		spin_lock(src_ptl);
+		arch_enter_lazy_mmu_mode();
+
+		do {
+			if (pte_none(*src_pte))
+				continue;
+			/*
+			 * COW mapping stuffs (e.g., PageAnonExclusive)
+			 * should already handled by copy_cow_pte_range().
+			 * We can simply set the entry to the child.
+			 */
+			set_pte_at(dst_mm, addr, dst_pte, *src_pte);
+		} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
+
+		arch_leave_lazy_mmu_mode();
+		spin_unlock(src_ptl);
+		pte_unmap(orig_src_pte);
+
+		spin_unlock(dst_ptl);
+		pte_unmap(orig_dst_pte);
+	}
+	/*
+	 * After recovering the entries, release the holding from child.
+	 * Parent may still share with others, so don't make it writeable.
+	 */
+	spin_lock(src_ptl);
+	pmd_put_pte(src_pmd);
+	spin_unlock(src_ptl);
+
+	cond_resched();
+
+	return ret;
+}
+#endif /* CONFIG_COW_PTE */
+
 static inline int
 copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	       pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
@@ -1115,6 +1360,64 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 				continue;
 			/* fall through */
 		}
+
+#ifdef CONFIG_COW_PTE
+		/*
+		 * If MMF_COW_PTE set, copy_pte_range() will try to share
+		 * the PTE page table first. In other words, it attempts to
+		 * do COW on PTE (and mapped pages). However, if there has
+		 * any unshareable page (e.g., pinned page, device private
+		 * page), it will fall back to the default path, which will
+		 * copy the page table immediately.
+		 * In such a case, it stores the address of first unshareable
+		 * page to recover_end then goes back to the beginning of PTE
+		 * and recovers the COW-ed PTE entries until it meets the same
+		 * unshareable page again. During the recovering, because of
+		 * COW-ed PTE entries are logical same as COW mapping, so it
+		 * only needs to allocate the new PTE and sets COW-ed PTE
+		 * entries to new PTE (which will be same as COW mapping).
+		 */
+		if (test_bit(MMF_COW_PTE, &src_mm->flags)) {
+			unsigned long recover_end = 0;
+			int ret;
+
+			/*
+			 * Setting wrprotect with normal PTE to pmd entry
+			 * will trigger pmd_bad(). Skip bad checking here.
+			 */
+			if (pmd_none(*src_pmd))
+				continue;
+			/* Skip if the PTE already did COW PTE this time. */
+			if (!pmd_none(*dst_pmd) && !pmd_write(*dst_pmd))
+				continue;
+
+			ret = copy_cow_pte_range(dst_vma, src_vma,
+						 dst_pmd, src_pmd,
+						 addr, next, &recover_end);
+			if (!ret) {
+				/* COW PTE succeeded. */
+				continue;
+			} else if (ret == -EAGAIN) {
+				/* fall back to normal copy method. */
+				if (recover_pte_range(dst_vma, src_vma,
+						      dst_pmd, src_pmd,
+						      recover_end))
+					return -ENOMEM;
+				/*
+				 * Since we processed all the entries of PTE
+				 * table, recover_end may not in the src_vma.
+				 * If we already handled the src_vma, skip it.
+				 */
+				if (!range_in_vma(src_vma, recover_end,
+						  recover_end + PAGE_SIZE))
+					continue;
+				else
+					addr = recover_end;
+				/* fall through */
+			} else if (ret)
+				return -ENOMEM;
+		}
+#endif /* CONFIG_COW_PTE */
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
 		if (copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
-- 
2.34.1

