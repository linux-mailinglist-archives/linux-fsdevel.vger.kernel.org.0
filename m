Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2881D6E259A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDNOZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjDNOZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:25:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A8EC151;
        Fri, 14 Apr 2023 07:24:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id my14-20020a17090b4c8e00b0024708e8e2ddso7875796pjb.4;
        Fri, 14 Apr 2023 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482298; x=1684074298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaw2VxgI5AOS+jKxtvax6AkU7/SfikwF+oX34AlhCVI=;
        b=rJFjdOiiKNNXrMgf0f7hQQpzgbUfjp/YzEEFdDEchHIG1R7cyEuRP4vZ4X9QAYdQpO
         6ajhP80GcIbDgZosE/SHJrXcdEIWgu1h59eQB9X95h+n/Q64EqRJ9GBz/j5e2RopGOw8
         2TZGBt+XhJegu0jCPROYu4kJFKMzLj1plc2+7zCv4uJc4IB6J+PwDFXwfIcVXUKYTd9j
         e1sihKOvAQYVMlwMH2YoKpSFwmUJogkEfcn9vi94ebsv/i3E/NbE9mmv0GyDf0/lbGNh
         Y22w1vLhGvDkCwXa1vqYP4rXIRfndQd7a3n9wiQYvVBRivfsTUyvOh0y+wdRkTC+0zMs
         olIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482298; x=1684074298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaw2VxgI5AOS+jKxtvax6AkU7/SfikwF+oX34AlhCVI=;
        b=Wfs1av5IdqJwsFVmy+KnnSUgbQZVe8XMILUw6bzXir/VN/QujS9fPhuTqmd9cfFz+B
         x4l2tql6LsRvqRl5GsULViH2Ykj/vPNk46adrAydriHXFGGcq5IjI3Ge0X/sk5VlwpAJ
         Lg2YXVTAOFqcfNMt9Hkg0ZAE/UWB8orLKFs/qmnsCRx4oB6mOu4wUsQEpYUGpdE9HWKS
         nc3glP2sV2FE4nh7NNu7gpjMG5Sutp6Ri/UpKtrvdJhjTHpfH3/5X5Yrw3lgre9ucalu
         Z9XnHls2/O6sW5mfszEJTl5zZh8BIn/oF5A+uJdJ/ixPpPzns8OaBRPZ0cLkzMHL3q2V
         tSqQ==
X-Gm-Message-State: AAQBX9eqKdtyVUoBl1/bexJWK4y36aGPemHZk9BN6wEwAj/qXCRu5J9/
        Sj0UT8ao9/pkQuDHzDHAklk=
X-Google-Smtp-Source: AKy350a6UNo1RjXOl4dyrR1EDggOcNns0y0a21eWdH/247G7ARNprz1vznZe7RgwqXKLT+0DQYVdyA==
X-Received: by 2002:a17:90b:4d8d:b0:240:67d5:aea1 with SMTP id oj13-20020a17090b4d8d00b0024067d5aea1mr6379154pjb.14.1681482298053;
        Fri, 14 Apr 2023 07:24:58 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:24:57 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Barry Song <baohua@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Steven Barrett <steven@liquorix.net>,
        Juergen Gross <jgross@suse.com>, Peter Xu <peterx@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alex Sierra <alex.sierra@amd.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Li kunyu <kunyu@nfschina.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Chih-En Lin <shiyn.lin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Gladkov <legion@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: [PATCH v5 04/17] mm: Add break COW PTE fault and helper functions
Date:   Fri, 14 Apr 2023 22:23:28 +0800
Message-Id: <20230414142341.354556-5-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414142341.354556-1-shiyn.lin@gmail.com>
References: <20230414142341.354556-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
duplicates all pte entries in COW-ed PTE. Moreover, flush TLB when we
change the write protection of PTE.

In addition, provide the helper functions, break_cow_pte{,_range}(), to
let the other features (remap, THP, migration, swapfile, etc) to use.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/mm.h      |  17 +++
 include/linux/pgtable.h |   6 +
 mm/memory.c             | 318 +++++++++++++++++++++++++++++++++++++++-
 mm/mmap.c               |   4 +
 mm/mremap.c             |   2 +
 mm/swapfile.c           |   2 +
 6 files changed, 348 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 828f8a1b1e32..b4c9658ccd28 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2179,6 +2179,23 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to);
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
index c63cd44777ec..f177a9d48b70 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1378,6 +1378,12 @@ static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
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
index 3b1c4a7e632c..f8a87a0fc382 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2166,6 +2166,8 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	if (retval)
 		goto out;
 	retval = -ENOMEM;
+	if (break_cow_pte(vma, NULL, addr))
+		goto out;
 	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
 	if (!pte)
 		goto out;
@@ -2425,6 +2427,9 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	pte_t *pte, entry;
 	spinlock_t *ptl;
 
+	if (break_cow_pte(vma, NULL, addr))
+		return VM_FAULT_OOM;
+
 	pte = get_locked_pte(mm, addr, &ptl);
 	if (!pte)
 		return VM_FAULT_OOM;
@@ -2802,6 +2807,10 @@ int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
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
@@ -5192,6 +5201,285 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 	return VM_FAULT_FALLBACK;
 }
 
+#ifdef CONFIG_COW_PTE
+/*
+ * Break (unshare) COW PTE
+ *
+ * Since the pte lock is held during all operations on the COW-ed PTE
+ * table, it should be safe to modify it's pmd entry as well, provided
+ * it has been ensured that the pmd entry points to a COW-ed PTE table
+ * rather than a huge page or default PTE. Otherwise, we should also
+ * consider holding the pmd lock as we do for the huge page.
+ */
+static vm_fault_t handle_cow_pte_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
+	pmd_t *pmd = vmf->pmd;
+	unsigned long start, end, addr = vmf->address;
+	struct mmu_notifier_range range;
+	pmd_t new_entry, cowed_entry;
+	pte_t *orig_dst_pte, *orig_src_pte;
+	pte_t *dst_pte, *src_pte;
+	pgtable_t new_pte_table = NULL;
+	spinlock_t *src_ptl;
+	int ret = 0;
+
+	/* Do nothing with the fault that doesn't have PTE yet. */
+	if (pmd_none(*pmd) || pmd_write(*pmd))
+		return 0;
+	/* COW PTE doesn't handle huge page. */
+	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
+		return 0;
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
+	src_pte = pte_offset_map(pmd, addr);
+	src_ptl = pte_lockptr(mm, pmd);
+	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
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
+	/*
+	 * Before acquiring the lock, we allocate the memory we may
+	 * possibly need.
+	 */
+	new_pte_table = pte_alloc_one(mm);
+	if (unlikely(!new_pte_table)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * To protect the pte table from the rmap and page table walk,
+	 * we should hold the lock of COW-ed PTE until all the operations
+	 * have been done including setting pmd entry, duplicating, and
+	 * decrease refcount.
+	 */
+	orig_src_pte = src_pte = pte_offset_map(pmd, addr);
+	src_ptl = pte_lockptr(mm, pmd);
+	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
+
+	/* Before pouplate the new pte table, we store the cowed (old) one. */
+	cowed_entry = READ_ONCE(*pmd);
+
+	/*
+	 * Someone may also break COW PTE when we allocating the pte table.
+	 * So, let check refcount again.
+	 */
+	if (cow_pte_count(&cowed_entry) == 1) {
+		pmd_t new = pmd_mkwrite(*pmd);
+		set_pmd_at(mm, addr, pmd, new);
+		pte_unmap_unlock(src_pte, src_ptl);
+		goto flush_tlb;
+	}
+
+	/*
+	 * We will only set the new pte table to the pmd entry after finish
+	 * all the duplicating.
+	 * We first store the new table in another pmd entry even though we
+	 * have held the COW-ed PTE's lock. This is because, if we clear the
+	 * pmd entry assigned to the COW-ed PTe table, other places (e.g.,
+	 * another page fault) may allocate an empty PTe table, leading to
+	 * potential issues.
+	 */
+	pmd_clear(&new_entry);
+	pmd_populate(mm, &new_entry, new_pte_table);
+	/*
+	 * No one else excluding us can access to this new table, so we don't
+	 * have to hold the second pte lock.
+	 */
+	orig_dst_pte = dst_pte = pte_offset_map(&new_entry, addr);
+
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
+
+	pte_unmap(orig_dst_pte);
+
+	/*
+	 * Decrease the refcount of COW-ed PTE.
+	 * In this path, we assume that someone is still using COW-ed PTE.
+	 * So, if the refcount is 1 before we decrease it, this might be
+	 * wrong.
+	 */
+	VM_WARN_ON(!pmd_put_pte(&cowed_entry));
+	VM_WARN_ON(!pmd_same(*pmd, cowed_entry));
+
+	/* Now, we can finally install the new PTE table to the pmd entry. */
+	set_pmd_at(mm, start, pmd, new_entry);
+	/*
+	 * We installed the new table, let cleanup the new_pte_table
+	 * variable to prevent pte_free() free it in the following.
+	 */
+	new_pte_table = NULL;
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
+	if (new_pte_table)
+		pte_free(mm, new_pte_table);
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
+ * If the first attempt fails, it will wait for some time and try
+ * again. If it fails again, then the OOM killer will be called.
+ */
+int break_cow_pte(struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr)
+{
+	struct mm_struct *mm;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	int ret = 0;
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
+	ret = __break_cow_pte(vma, pmd, addr);
+
+	if (unlikely(ret == -ENOMEM)) {
+		unsigned int cow_pte_alloc_sleep_millisecs = 60000;
+
+		schedule_timeout(msecs_to_jiffies(
+					cow_pte_alloc_sleep_millisecs));
+
+		ret = __break_cow_pte(vma, pmd, addr);
+		if (unlikely(ret == -ENOMEM))  {
+			struct oom_control oc = {
+				.gfp_mask = GFP_PGTABLE_USER,
+			};
+
+			mutex_lock(&oom_lock);
+			out_of_memory(&oc);
+			mutex_unlock(&oom_lock);
+		}
+	}
+
+	return ret;
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
@@ -5267,8 +5555,13 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
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
@@ -5404,8 +5697,31 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
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
index ff68a67a2a7c..ac1002e85d88 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2169,6 +2169,10 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
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
index 411a85682b58..0668e9ead65a 100644
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
index 2c718f45745f..b7aa880957fd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1919,6 +1919,8 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
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

