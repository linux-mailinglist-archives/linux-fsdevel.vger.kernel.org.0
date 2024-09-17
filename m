Return-Path: <linux-fsdevel+bounces-29557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1EB97AC2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324471C22773
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 07:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE0C15C125;
	Tue, 17 Sep 2024 07:32:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A3B14A62E;
	Tue, 17 Sep 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558324; cv=none; b=AMlrEP7AfcZGscteH7QVJdcuCkPxCLU5MnvWYGtnBI2X6PS4InQGYm41P7LublogyylFqIvfcngEhRdyFRxmL6iOBkdVtybvPb5/kSpYmLaVUKiTMnWYtPQO6SoaPxDbbq8f4MfTouo7xCaII3OftrywViTCTT1vfe4VVUy1w4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558324; c=relaxed/simple;
	bh=awnBQ9a5PklswIOIoZrYq5zcWJEC1+c42AhcHo2DcII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfmR1j2oEl+VvZlitmwIo6k3SQRNOd0ukPvins2KFruXDmeEqfj1fvRRSVTK2kUo4loADHOCxpeH16KjTUebSpbWrQGAvQfgLxnLqHZ4kwpYX60/dr1t1ofe/u4GEV8ydG16xx4ten7Imyjsp38pbcJEj/t3okuHLkU/YACYHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 950FD106F;
	Tue, 17 Sep 2024 00:32:31 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.61.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9716F3F64C;
	Tue, 17 Sep 2024 00:31:54 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH V2 5/7] mm: Use pudp_get() for accessing PUD entries
Date: Tue, 17 Sep 2024 13:01:15 +0530
Message-Id: <20240917073117.1531207-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240917073117.1531207-1-anshuman.khandual@arm.com>
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert PUD accesses via pudp_get() helper that defaults as READ_ONCE() but
also provides the platform an opportunity to override when required. This
stores read page table entry value in a local variable which can be used in
multiple instances there after. This helps in avoiding multiple memory load
operations as well possible race conditions.

Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-perf-users@vger.kernel.org
Cc: kasan-dev@googlegroups.com
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/misc/sgi-gru/grufault.c |  2 +-
 fs/userfaultfd.c                |  2 +-
 include/linux/huge_mm.h         |  2 +-
 include/linux/mm.h              |  2 +-
 include/linux/pgtable.h         | 13 ++++++++-----
 kernel/events/core.c            |  2 +-
 mm/gup.c                        | 12 ++++++------
 mm/hmm.c                        |  2 +-
 mm/huge_memory.c                | 24 +++++++++++++++---------
 mm/hugetlb.c                    |  6 +++---
 mm/kasan/init.c                 | 10 +++++-----
 mm/kasan/shadow.c               |  4 ++--
 mm/mapping_dirty_helpers.c      |  2 +-
 mm/memory-failure.c             |  4 ++--
 mm/memory.c                     | 14 +++++++-------
 mm/page_table_check.c           |  2 +-
 mm/page_vma_mapped.c            |  2 +-
 mm/pagewalk.c                   |  6 +++---
 mm/percpu.c                     |  2 +-
 mm/pgalloc-track.h              |  2 +-
 mm/pgtable-generic.c            |  6 +++---
 mm/ptdump.c                     |  4 ++--
 mm/rmap.c                       |  2 +-
 mm/sparse-vmemmap.c             |  2 +-
 mm/vmalloc.c                    | 15 ++++++++-------
 mm/vmscan.c                     |  4 ++--
 26 files changed, 79 insertions(+), 69 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 804f275ece99..95d479d5e40f 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -220,7 +220,7 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
 		goto err;
 
 	pudp = pud_offset(p4dp, vaddr);
-	if (unlikely(pud_none(*pudp)))
+	if (unlikely(pud_none(pudp_get(pudp))))
 		goto err;
 
 	pmdp = pmd_offset(pudp, vaddr);
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 27a3e9285fbf..00719a0f688c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -310,7 +310,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	if (!p4d_present(*p4d))
 		goto out;
 	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
+	if (!pud_present(pudp_get(pud)))
 		goto out;
 	pmd = pmd_offset(pud, address);
 again:
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 38b5de040d02..66a19622d95b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -379,7 +379,7 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
 {
-	if (pud_trans_huge(*pud) || pud_devmap(*pud))
+	if (pud_trans_huge(pudp_get(pud)) || pud_devmap(pudp_get(pud)))
 		return __pud_trans_huge_lock(pud, vma);
 	else
 		return NULL;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 258e49323306..1bb1599b5779 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2832,7 +2832,7 @@ static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
 
 static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
-	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
+	return (unlikely(pud_none(pudp_get(pud))) && __pmd_alloc(mm, pud, address)) ?
 		NULL: pmd_offset(pud, address);
 }
 #endif /* CONFIG_MMU */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index ea283ce958a7..eb993ef0946f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -611,7 +611,7 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address,
 					    pud_t *pudp)
 {
-	pud_t pud = *pudp;
+	pud_t pud = pudp_get(pudp);
 
 	pud_clear(pudp);
 	page_table_check_pud_clear(mm, pud);
@@ -893,7 +893,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 static inline void pudp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pud_t *pudp)
 {
-	pud_t old_pud = *pudp;
+	pud_t old_pud = pudp_get(pudp);
 
 	set_pud_at(mm, address, pudp, pud_wrprotect(old_pud));
 }
@@ -1074,7 +1074,8 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
 
 #define set_pud_safe(pudp, pud) \
 ({ \
-	WARN_ON_ONCE(pud_present(*pudp) && !pud_same(*pudp, pud)); \
+	pud_t __old = pudp_get(pudp); \
+	WARN_ON_ONCE(pud_present(__old) && !pud_same(__old, pud)); \
 	set_pud(pudp, pud); \
 })
 
@@ -1261,9 +1262,11 @@ static inline int p4d_none_or_clear_bad(p4d_t *p4d)
 
 static inline int pud_none_or_clear_bad(pud_t *pud)
 {
-	if (pud_none(*pud))
+	pud_t old_pud = pudp_get(pud);
+
+	if (pud_none(old_pud))
 		return 1;
-	if (unlikely(pud_bad(*pud))) {
+	if (unlikely(pud_bad(old_pud))) {
 		pud_clear_bad(pud);
 		return 1;
 	}
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8a6c6bbcd658..35e2f2789246 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7619,7 +7619,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return p4d_leaf_size(p4d);
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return 0;
 
diff --git a/mm/gup.c b/mm/gup.c
index aeeac0a54944..300fc7eb306c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -606,7 +606,7 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page *page;
-	pud_t pud = *pudp;
+	pud_t pud = pudp_get(pudp);
 	unsigned long pfn = pud_pfn(pud);
 	int ret;
 
@@ -989,7 +989,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	pudp = pud_offset(p4dp, address);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
 	if (pud_leaf(pud)) {
@@ -1117,7 +1117,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 	if (p4d_none(*p4d))
 		return -EFAULT;
 	pud = pud_offset(p4d, address);
-	if (pud_none(*pud))
+	if (pud_none(pudp_get(pud)))
 		return -EFAULT;
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(pmdp_get(pmd)))
@@ -3025,7 +3025,7 @@ static int gup_fast_devmap_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
 		return 0;
 
-	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
+	if (unlikely(pud_val(orig) != pud_val(pudp_get(pudp)))) {
 		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
 		return 0;
 	}
@@ -3118,7 +3118,7 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (!folio)
 		return 0;
 
-	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
+	if (unlikely(pud_val(orig) != pud_val(pudp_get(pudp)))) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
@@ -3219,7 +3219,7 @@ static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
 	do {
-		pud_t pud = READ_ONCE(*pudp);
+		pud_t pud = pudp_get(pudp);
 
 		next = pud_addr_end(addr, end);
 		if (unlikely(!pud_present(pud)))
diff --git a/mm/hmm.c b/mm/hmm.c
index 7e0229ae4a5a..c1b093d670b8 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -423,7 +423,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 	/* Normally we don't want to split the huge page */
 	walk->action = ACTION_CONTINUE;
 
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud)) {
 		spin_unlock(ptl);
 		return hmm_vma_walk_hole(start, end, -1, walk);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bb63de935937..69e1400a51ec 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1243,17 +1243,18 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgprot_t prot = vma->vm_page_prot;
-	pud_t entry;
+	pud_t entry, old_pud;
 	spinlock_t *ptl;
 
 	ptl = pud_lock(mm, pud);
-	if (!pud_none(*pud)) {
+	old_pud = pudp_get(pud);
+	if (!pud_none(old_pud)) {
 		if (write) {
-			if (pud_pfn(*pud) != pfn_t_to_pfn(pfn)) {
-				WARN_ON_ONCE(!is_huge_zero_pud(*pud));
+			if (pud_pfn(old_pud) != pfn_t_to_pfn(pfn)) {
+				WARN_ON_ONCE(!is_huge_zero_pud(old_pud));
 				goto out_unlock;
 			}
-			entry = pud_mkyoung(*pud);
+			entry = pud_mkyoung(old_pud);
 			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
 			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
 				update_mmu_cache_pud(vma, addr, pud);
@@ -1476,7 +1477,7 @@ void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 {
 	pud_t _pud;
 
-	_pud = pud_mkyoung(*pud);
+	_pud = pud_mkyoung(pudp_get(pud));
 	if (write)
 		_pud = pud_mkdirty(_pud);
 	if (pudp_set_access_flags(vma, addr & HPAGE_PUD_MASK,
@@ -2284,9 +2285,10 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
+	pud_t old_pud = pudp_get(pud);
 
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud)))
+	if (likely(pud_trans_huge(old_pud) || pud_devmap(old_pud)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2317,10 +2319,12 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 		unsigned long haddr)
 {
+	pud_t old_pud = pudp_get(pud);
+
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
-	VM_BUG_ON(!pud_trans_huge(*pud) && !pud_devmap(*pud));
+	VM_BUG_ON(!pud_trans_huge(old_pud) && !pud_devmap(old_pud));
 
 	count_vm_event(THP_SPLIT_PUD);
 
@@ -2332,13 +2336,15 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 {
 	spinlock_t *ptl;
 	struct mmu_notifier_range range;
+	pud_t old_pud;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
 				address & HPAGE_PUD_MASK,
 				(address & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (unlikely(!pud_trans_huge(*pud) && !pud_devmap(*pud)))
+	old_pud = pudp_get(pud);
+	if (unlikely(!pud_trans_huge(old_pud) && !pud_devmap(old_pud)))
 		goto out;
 	__split_huge_pud_locked(vma, pud, range.start);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index aaf508be0a2b..a3820242b01e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7328,7 +7328,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out;
 
 	spin_lock(&mm->page_table_lock);
-	if (pud_none(*pud)) {
+	if (pud_none(pudp_get(pud))) {
 		pud_populate(mm, pud,
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
 		mm_inc_nr_pmds(mm);
@@ -7417,7 +7417,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			pte = (pte_t *)pud;
 		} else {
 			BUG_ON(sz != PMD_SIZE);
-			if (want_pmd_share(vma, addr) && pud_none(*pud))
+			if (want_pmd_share(vma, addr) && pud_none(pudp_get(pud)))
 				pte = huge_pmd_share(mm, vma, addr, pud);
 			else
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
@@ -7461,7 +7461,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	if (sz == PUD_SIZE)
 		/* must be pud huge, non-present or none */
 		return (pte_t *)pud;
-	if (!pud_present(*pud))
+	if (!pud_present(pudp_get(pud)))
 		return NULL;
 	/* must have a valid entry and size to go further */
 
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 4418bcdcb2aa..f4cf519443e1 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -162,7 +162,7 @@ static int __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
 			continue;
 		}
 
-		if (pud_none(*pud)) {
+		if (pud_none(pudp_get(pud))) {
 			pmd_t *p;
 
 			if (slab_is_available()) {
@@ -315,7 +315,7 @@ static void kasan_free_pmd(pmd_t *pmd_start, pud_t *pud)
 			return;
 	}
 
-	pmd_free(&init_mm, (pmd_t *)page_to_virt(pud_page(*pud)));
+	pmd_free(&init_mm, (pmd_t *)page_to_virt(pud_page(pudp_get(pud))));
 	pud_clear(pud);
 }
 
@@ -326,7 +326,7 @@ static void kasan_free_pud(pud_t *pud_start, p4d_t *p4d)
 
 	for (i = 0; i < PTRS_PER_PUD; i++) {
 		pud = pud_start + i;
-		if (!pud_none(*pud))
+		if (!pud_none(pudp_get(pud)))
 			return;
 	}
 
@@ -407,10 +407,10 @@ static void kasan_remove_pud_table(pud_t *pud, unsigned long addr,
 
 		next = pud_addr_end(addr, end);
 
-		if (!pud_present(*pud))
+		if (!pud_present(pudp_get(pud)))
 			continue;
 
-		if (kasan_pmd_table(*pud)) {
+		if (kasan_pmd_table(pudp_get(pud))) {
 			if (IS_ALIGNED(addr, PUD_SIZE) &&
 			    IS_ALIGNED(next, PUD_SIZE)) {
 				pud_clear(pud);
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index aec16a7236f7..dbd8164c75f1 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -197,9 +197,9 @@ static bool shadow_mapped(unsigned long addr)
 	if (p4d_none(*p4d))
 		return false;
 	pud = pud_offset(p4d, addr);
-	if (pud_none(*pud))
+	if (pud_none(pudp_get(pud)))
 		return false;
-	if (pud_leaf(*pud))
+	if (pud_leaf(pudp_get(pud)))
 		return true;
 	pmd = pmd_offset(pud, addr);
 	if (pmd_none(pmdp_get(pmd)))
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 2f8829b3541a..c556cc4e3480 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -149,7 +149,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-	pud_t pudval = READ_ONCE(*pud);
+	pud_t pudval = pudp_get(pud);
 
 	/* Do not split a huge pud */
 	if (pud_trans_huge(pudval) || pud_devmap(pudval)) {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 305dbef3cc4d..fbb63401fb51 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -417,9 +417,9 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 	if (!p4d_present(*p4d))
 		return 0;
 	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
+	if (!pud_present(pudp_get(pud)))
 		return 0;
-	if (pud_devmap(*pud))
+	if (pud_devmap(pudp_get(pud)))
 		return PUD_SHIFT;
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(pmdp_get(pmd)))
diff --git a/mm/memory.c b/mm/memory.c
index 5520e1f6a1b9..801750e4337c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1753,7 +1753,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
+		if (pud_trans_huge(pudp_get(pud)) || pud_devmap(pudp_get(pud))) {
 			if (next - addr != HPAGE_PUD_SIZE) {
 				mmap_assert_locked(tlb->mm);
 				split_huge_pud(vma, pud, addr);
@@ -2836,7 +2836,7 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 	unsigned long next;
 	int err = 0;
 
-	BUG_ON(pud_leaf(*pud));
+	BUG_ON(pud_leaf(pudp_get(pud)));
 
 	if (create) {
 		pmd = pmd_alloc_track(mm, pud, addr, mask);
@@ -2883,11 +2883,11 @@ static int apply_to_pud_range(struct mm_struct *mm, p4d_t *p4d,
 	}
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_none(*pud) && !create)
+		if (pud_none(pudp_get(pud)) && !create)
 			continue;
-		if (WARN_ON_ONCE(pud_leaf(*pud)))
+		if (WARN_ON_ONCE(pud_leaf(pudp_get(pud))))
 			return -EINVAL;
-		if (!pud_none(*pud) && WARN_ON_ONCE(pud_bad(*pud))) {
+		if (!pud_none(pudp_get(pud)) && WARN_ON_ONCE(pud_bad(pudp_get(pud)))) {
 			if (!create)
 				continue;
 			pud_clear_bad(pud);
@@ -6099,7 +6099,7 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 		return -ENOMEM;
 
 	ptl = pud_lock(mm, pud);
-	if (!pud_present(*pud)) {
+	if (!pud_present(pudp_get(pud))) {
 		mm_inc_nr_pmds(mm);
 		smp_wmb(); /* See comment in pmd_install() */
 		pud_populate(mm, pud, new);
@@ -6164,7 +6164,7 @@ int follow_pte(struct vm_area_struct *vma, unsigned long address,
 		goto out;
 
 	pud = pud_offset(p4d, address);
-	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
+	if (pud_none(pudp_get(pud)) || unlikely(pud_bad(pudp_get(pud))))
 		goto out;
 
 	pmd = pmd_offset(pud, address);
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 48a2cf56c80e..2a22d098b0b1 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -254,7 +254,7 @@ void __page_table_check_pud_set(struct mm_struct *mm, pud_t *pudp, pud_t pud)
 	if (&init_mm == mm)
 		return;
 
-	__page_table_check_pud_clear(mm, *pudp);
+	__page_table_check_pud_clear(mm, pudp_get(pudp));
 	if (pud_user_accessible_page(pud)) {
 		page_table_check_set(pud_pfn(pud), PUD_SIZE >> PAGE_SHIFT,
 				     pud_write(pud));
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index ae5cc42aa208..511266307771 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -222,7 +222,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			continue;
 		}
 		pud = pud_offset(p4d, pvmw->address);
-		if (!pud_present(*pud)) {
+		if (!pud_present(pudp_get(pud))) {
 			step_forward(pvmw, PUD_SIZE);
 			continue;
 		}
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index c3019a160e77..1d32c6da1a0d 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -145,7 +145,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 	do {
  again:
 		next = pud_addr_end(addr, end);
-		if (pud_none(*pud)) {
+		if (pud_none(pudp_get(pud))) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
@@ -163,14 +163,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		if (walk->action == ACTION_AGAIN)
 			goto again;
 
-		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
+		if ((!walk->vma && (pud_leaf(pudp_get(pud)) || !pud_present(pudp_get(pud)))) ||
 		    walk->action == ACTION_CONTINUE ||
 		    !(ops->pmd_entry || ops->pte_entry))
 			continue;
 
 		if (walk->vma)
 			split_huge_pud(walk->vma, pud, addr);
-		if (pud_none(*pud))
+		if (pud_none(pudp_get(pud)))
 			goto again;
 
 		err = walk_pmd_range(pud, addr, next, walk);
diff --git a/mm/percpu.c b/mm/percpu.c
index 7ee77c0fd5e3..5f32164b04a2 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3200,7 +3200,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 	}
 
 	pud = pud_offset(p4d, addr);
-	if (pud_none(*pud)) {
+	if (pud_none(pudp_get(pud))) {
 		pmd = memblock_alloc(PMD_TABLE_SIZE, PMD_TABLE_SIZE);
 		if (!pmd)
 			goto err_alloc;
diff --git a/mm/pgalloc-track.h b/mm/pgalloc-track.h
index e9e879de8649..0f6b809431a3 100644
--- a/mm/pgalloc-track.h
+++ b/mm/pgalloc-track.h
@@ -33,7 +33,7 @@ static inline pmd_t *pmd_alloc_track(struct mm_struct *mm, pud_t *pud,
 				     unsigned long address,
 				     pgtbl_mod_mask *mod_mask)
 {
-	if (unlikely(pud_none(*pud))) {
+	if (unlikely(pud_none(pudp_get(pud)))) {
 		if (__pmd_alloc(mm, pud, address))
 			return NULL;
 		*mod_mask |= PGTBL_PUD_MODIFIED;
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 920947bb76cd..e09e3f920f7a 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -39,7 +39,7 @@ void p4d_clear_bad(p4d_t *p4d)
 #ifndef __PAGETABLE_PUD_FOLDED
 void pud_clear_bad(pud_t *pud)
 {
-	pud_ERROR(*pud);
+	pud_ERROR(pudp_get(pud));
 	pud_clear(pud);
 }
 #endif
@@ -150,10 +150,10 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 pud_t pudp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 			    pud_t *pudp)
 {
-	pud_t pud;
+	pud_t pud, old_pud = pudp_get(pudp);
 
 	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
-	VM_BUG_ON(!pud_trans_huge(*pudp) && !pud_devmap(*pudp));
+	VM_BUG_ON(!pud_trans_huge(old_pud) && !pud_devmap(old_pud));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, address, pudp);
 	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
 	return pud;
diff --git a/mm/ptdump.c b/mm/ptdump.c
index e17588a32012..32ae8e829329 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -30,7 +30,7 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	pgd_t val = READ_ONCE(*pgd);
+	pgd_t val = pgdp_get(pgd);
 
 #if CONFIG_PGTABLE_LEVELS > 4 && \
 		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
@@ -76,7 +76,7 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	pud_t val = READ_ONCE(*pud);
+	pud_t val = pudp_get(pud);
 
 #if CONFIG_PGTABLE_LEVELS > 2 && \
 		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
diff --git a/mm/rmap.c b/mm/rmap.c
index 32e4920e419d..81f1946653e0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -817,7 +817,7 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address)
 		goto out;
 
 	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
+	if (!pud_present(pudp_get(pud)))
 		goto out;
 
 	pmd = pmd_offset(pud, address);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c89706e107ce..d8ea64ec665f 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -203,7 +203,7 @@ void __weak __meminit pmd_init(void *addr)
 pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
 {
 	pud_t *pud = pud_offset(p4d, addr);
-	if (pud_none(*pud)) {
+	if (pud_none(pudp_get(pud))) {
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1da56cbe5feb..05292d998122 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -200,7 +200,7 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
 	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
 		return 0;
 
-	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
+	if (pud_present(pudp_get(pud)) && !pud_free_pmd_page(pud, addr))
 		return 0;
 
 	return pud_set_huge(pud, phys_addr, prot);
@@ -396,7 +396,7 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		next = pud_addr_end(addr, end);
 
 		cleared = pud_clear_huge(pud);
-		if (cleared || pud_bad(*pud))
+		if (cleared || pud_bad(pudp_get(pud)))
 			*mask |= PGTBL_PUD_MODIFIED;
 
 		if (cleared)
@@ -742,7 +742,7 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 	struct page *page = NULL;
 	pgd_t *pgd = pgd_offset_k(addr);
 	p4d_t *p4d;
-	pud_t *pud;
+	pud_t *pud, old_pud;
 	pmd_t *pmd, old_pmd;
 	pte_t *ptep, pte;
 
@@ -768,11 +768,12 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 		return NULL;
 
 	pud = pud_offset(p4d, addr);
-	if (pud_none(*pud))
+	old_pud = pudp_get(pud);
+	if (pud_none(old_pud))
 		return NULL;
-	if (pud_leaf(*pud))
-		return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (WARN_ON_ONCE(pud_bad(*pud)))
+	if (pud_leaf(old_pud))
+		return pud_page(old_pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(pud_bad(old_pud)))
 		return NULL;
 
 	pmd = pmd_offset(pud, addr);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd489c1af228..04b03e6c3095 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3421,7 +3421,7 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 	DEFINE_MAX_SEQ(walk->lruvec);
 	int old_gen, new_gen = lru_gen_from_seq(max_seq);
 
-	VM_WARN_ON_ONCE(pud_leaf(*pud));
+	VM_WARN_ON_ONCE(pud_leaf(pudp_get(pud)));
 
 	/* try to batch at most 1+MIN_LRU_BATCH+1 entries */
 	if (*first == -1) {
@@ -3501,7 +3501,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 	struct lru_gen_mm_walk *walk = args->private;
 	struct lru_gen_mm_state *mm_state = get_mm_state(walk->lruvec);
 
-	VM_WARN_ON_ONCE(pud_leaf(*pud));
+	VM_WARN_ON_ONCE(pud_leaf(pudp_get(pud)));
 
 	/*
 	 * Finish an entire PMD in two passes: the first only reaches to PTE
-- 
2.25.1


