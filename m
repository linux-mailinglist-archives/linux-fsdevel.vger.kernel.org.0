Return-Path: <linux-fsdevel+bounces-29294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA820977B85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 10:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDF2280997
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063931D88DC;
	Fri, 13 Sep 2024 08:45:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB10B1D88CE;
	Fri, 13 Sep 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217123; cv=none; b=TMLrbi5h4Mqjl4vxxL33w08FeLUb+Mj2UHSRPTjm+19SqzGd9Gf/kd4KGe95mAHFSHulx6GxuEtvW0rsh6X1pEpBcubL88rQhPSdLofK8iwgj85LtLTv/BHTZfvAsJJpCcg/xnRoCEcTcFXf+2TqxGM+RMhBMynA3FWKefaKIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217123; c=relaxed/simple;
	bh=sGLDvqf3giJXIFtxTTD6JYN+ET5glWCbC3FUb/3lcNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p0M0TjCFpHMTHVGojhAvsDrKi3iQOEY4DafbDvuYfNatd9HnpbU6u5FTenM4xDIxtF/ZsjFemPdmbTxgdscsr/4Ck77KJXOaRC/DNhFsupTfO9I2lbJFgibQjr0XV8gBWXccntV/MdmQPKsBW0ZFkOTZr8QQ8OEUjPP/XbDS3/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAA98153B;
	Fri, 13 Sep 2024 01:45:49 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11A813F73B;
	Fri, 13 Sep 2024 01:45:13 -0700 (PDT)
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Muchun Song <muchun.song@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 6/7] mm: Use p4dp_get() for accessing P4D entries
Date: Fri, 13 Sep 2024 14:14:32 +0530
Message-Id: <20240913084433.1016256-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913084433.1016256-1-anshuman.khandual@arm.com>
References: <20240913084433.1016256-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert P4D accesses via p4dp_get() helper that defaults as READ_ONCE() but
also provides the platform an opportunity to override when required.

Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
cc: Christoph Lameter <cl@linux.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kasan-dev@googlegroups.com
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/misc/sgi-gru/grufault.c |  2 +-
 fs/userfaultfd.c                |  4 ++--
 include/linux/pgtable.h         |  6 +++---
 kernel/events/core.c            |  2 +-
 mm/gup.c                        |  6 +++---
 mm/hugetlb.c                    |  2 +-
 mm/kasan/init.c                 | 10 +++++-----
 mm/kasan/shadow.c               |  2 +-
 mm/memory-failure.c             |  2 +-
 mm/memory.c                     | 14 +++++++-------
 mm/page_vma_mapped.c            |  2 +-
 mm/pagewalk.c                   |  6 +++---
 mm/percpu.c                     |  4 ++--
 mm/pgalloc-track.h              |  2 +-
 mm/pgtable-generic.c            |  4 ++--
 mm/ptdump.c                     |  2 +-
 mm/rmap.c                       |  4 ++--
 mm/sparse-vmemmap.c             |  4 ++--
 mm/vmalloc.c                    | 24 ++++++++++++------------
 mm/vmscan.c                     |  6 +++---
 20 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 0a06ec92f090..cdca93398b44 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -216,7 +216,7 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
 		goto err;
 
 	p4dp = p4d_offset(pgdp, vaddr);
-	if (unlikely(p4d_none(*p4dp)))
+	if (unlikely(p4d_none(p4dp_get(p4dp))))
 		goto err;
 
 	pudp = pud_offset(p4dp, vaddr);
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 27a3e9285fbf..4044e15cdfd9 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -307,10 +307,10 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	if (!pgd_present(*pgd))
 		goto out;
 	p4d = p4d_offset(pgd, address);
-	if (!p4d_present(*p4d))
+	if (!p4d_present(p4dp_get(p4d)))
 		goto out;
 	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
+	if (!pud_present(pudp_get(pud)))
 		goto out;
 	pmd = pmd_offset(pud, address);
 again:
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index b25a0a505ce6..b3e40f06c8c4 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1078,7 +1078,7 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
 
 #define set_p4d_safe(p4dp, p4d) \
 ({ \
-	WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
+	WARN_ON_ONCE(p4d_present(p4dp_get(p4dp)) && !p4d_same(p4dp_get(p4dp), p4d)); \
 	set_p4d(p4dp, p4d); \
 })
 
@@ -1248,9 +1248,9 @@ static inline int pgd_none_or_clear_bad(pgd_t *pgd)
 
 static inline int p4d_none_or_clear_bad(p4d_t *p4d)
 {
-	if (p4d_none(*p4d))
+	if (p4d_none(p4dp_get(p4d)))
 		return 1;
-	if (unlikely(p4d_bad(*p4d))) {
+	if (unlikely(p4d_bad(p4dp_get(p4d)))) {
 		p4d_clear_bad(p4d);
 		return 1;
 	}
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 35e2f2789246..4e56a276ed25 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7611,7 +7611,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pgd_leaf_size(pgd);
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	if (!p4d_present(p4d))
 		return 0;
 
diff --git a/mm/gup.c b/mm/gup.c
index 300fc7eb306c..3a97d0263052 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1014,7 +1014,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 	p4d_t *p4dp, p4d;
 
 	p4dp = p4d_offset(pgdp, address);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	BUILD_BUG_ON(p4d_leaf(p4d));
 
 	if (!p4d_present(p4d) || p4d_bad(p4d))
@@ -1114,7 +1114,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 	if (pgd_none(*pgd))
 		return -EFAULT;
 	p4d = p4d_offset(pgd, address);
-	if (p4d_none(*p4d))
+	if (p4d_none(p4dp_get(p4d)))
 		return -EFAULT;
 	pud = pud_offset(p4d, address);
 	if (pud_none(pudp_get(pud)))
@@ -3245,7 +3245,7 @@ static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
 	do {
-		p4d_t p4d = READ_ONCE(*p4dp);
+		p4d_t p4d = p4dp_get(p4dp);
 
 		next = p4d_addr_end(addr, end);
 		if (!p4d_present(p4d))
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a3820242b01e..4fdb91c8cc2b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7454,7 +7454,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	if (!pgd_present(*pgd))
 		return NULL;
 	p4d = p4d_offset(pgd, addr);
-	if (!p4d_present(*p4d))
+	if (!p4d_present(p4dp_get(p4d)))
 		return NULL;
 
 	pud = pud_offset(p4d, addr);
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index f4cf519443e1..02af738fee5e 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -208,7 +208,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			continue;
 		}
 
-		if (p4d_none(*p4d)) {
+		if (p4d_none(p4dp_get(p4d))) {
 			pud_t *p;
 
 			if (slab_is_available()) {
@@ -330,7 +330,7 @@ static void kasan_free_pud(pud_t *pud_start, p4d_t *p4d)
 			return;
 	}
 
-	pud_free(&init_mm, (pud_t *)page_to_virt(p4d_page(*p4d)));
+	pud_free(&init_mm, (pud_t *)page_to_virt(p4d_page(p4dp_get(p4d))));
 	p4d_clear(p4d);
 }
 
@@ -341,7 +341,7 @@ static void kasan_free_p4d(p4d_t *p4d_start, pgd_t *pgd)
 
 	for (i = 0; i < PTRS_PER_P4D; i++) {
 		p4d = p4d_start + i;
-		if (!p4d_none(*p4d))
+		if (!p4d_none(p4dp_get(p4d)))
 			return;
 	}
 
@@ -434,10 +434,10 @@ static void kasan_remove_p4d_table(p4d_t *p4d, unsigned long addr,
 
 		next = p4d_addr_end(addr, end);
 
-		if (!p4d_present(*p4d))
+		if (!p4d_present(p4dp_get(p4d)))
 			continue;
 
-		if (kasan_pud_table(*p4d)) {
+		if (kasan_pud_table(p4dp_get(p4d))) {
 			if (IS_ALIGNED(addr, P4D_SIZE) &&
 			    IS_ALIGNED(next, P4D_SIZE)) {
 				p4d_clear(p4d);
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index dbd8164c75f1..52150cc5ae5f 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -194,7 +194,7 @@ static bool shadow_mapped(unsigned long addr)
 	if (pgd_none(*pgd))
 		return false;
 	p4d = p4d_offset(pgd, addr);
-	if (p4d_none(*p4d))
+	if (p4d_none(p4dp_get(p4d)))
 		return false;
 	pud = pud_offset(p4d, addr);
 	if (pud_none(pudp_get(pud)))
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fbb63401fb51..3d900cc039b3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -414,7 +414,7 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 	if (!pgd_present(*pgd))
 		return 0;
 	p4d = p4d_offset(pgd, address);
-	if (!p4d_present(*p4d))
+	if (!p4d_present(p4dp_get(p4d)))
 		return 0;
 	pud = pud_offset(p4d, address);
 	if (!pud_present(pudp_get(pud)))
diff --git a/mm/memory.c b/mm/memory.c
index af6c9346493c..7e6bb051d187 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2902,11 +2902,11 @@ static int apply_to_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	}
 	do {
 		next = p4d_addr_end(addr, end);
-		if (p4d_none(*p4d) && !create)
+		if (p4d_none(p4dp_get(p4d)) && !create)
 			continue;
-		if (WARN_ON_ONCE(p4d_leaf(*p4d)))
+		if (WARN_ON_ONCE(p4d_leaf(p4dp_get(p4d))))
 			return -EINVAL;
-		if (!p4d_none(*p4d) && WARN_ON_ONCE(p4d_bad(*p4d))) {
+		if (!p4d_none(p4dp_get(p4d)) && WARN_ON_ONCE(p4d_bad(p4dp_get(p4d)))) {
 			if (!create)
 				continue;
 			p4d_clear_bad(p4d);
@@ -6058,7 +6058,7 @@ int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address)
 		return -ENOMEM;
 
 	spin_lock(&mm->page_table_lock);
-	if (!p4d_present(*p4d)) {
+	if (!p4d_present(p4dp_get(p4d))) {
 		mm_inc_nr_puds(mm);
 		smp_wmb(); /* See comment in pmd_install() */
 		p4d_populate(mm, p4d, new);
@@ -6082,7 +6082,7 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 		return -ENOMEM;
 
 	ptl = pud_lock(mm, pud);
-	if (!pud_present(*pud)) {
+	if (!pud_present(pudp_get(pud))) {
 		mm_inc_nr_pmds(mm);
 		smp_wmb(); /* See comment in pmd_install() */
 		pud_populate(mm, pud, new);
@@ -6143,11 +6143,11 @@ int follow_pte(struct vm_area_struct *vma, unsigned long address,
 		goto out;
 
 	p4d = p4d_offset(pgd, address);
-	if (p4d_none(*p4d) || unlikely(p4d_bad(*p4d)))
+	if (p4d_none(p4dp_get(p4d)) || unlikely(p4d_bad(p4dp_get(p4d))))
 		goto out;
 
 	pud = pud_offset(p4d, address);
-	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
+	if (pud_none(pudp_get(pud)) || unlikely(pud_bad(pudp_get(pud))))
 		goto out;
 
 	pmd = pmd_offset(pud, address);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 511266307771..a33f92db2666 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -217,7 +217,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			continue;
 		}
 		p4d = p4d_offset(pgd, pvmw->address);
-		if (!p4d_present(*p4d)) {
+		if (!p4d_present(p4dp_get(p4d))) {
 			step_forward(pvmw, P4D_SIZE);
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
index 7ee77c0fd5e3..58660e8eb892 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3192,7 +3192,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 	}
 
 	p4d = p4d_offset(pgd, addr);
-	if (p4d_none(*p4d)) {
+	if (p4d_none(p4dp_get(p4d))) {
 		pud = memblock_alloc(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
 		if (!pud)
 			goto err_alloc;
@@ -3200,7 +3200,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 	}
 
 	pud = pud_offset(p4d, addr);
-	if (pud_none(*pud)) {
+	if (pud_none(pudp_get(pud))) {
 		pmd = memblock_alloc(PMD_TABLE_SIZE, PMD_TABLE_SIZE);
 		if (!pmd)
 			goto err_alloc;
diff --git a/mm/pgalloc-track.h b/mm/pgalloc-track.h
index 0f6b809431a3..3db8ccbcb141 100644
--- a/mm/pgalloc-track.h
+++ b/mm/pgalloc-track.h
@@ -20,7 +20,7 @@ static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
 				     unsigned long address,
 				     pgtbl_mod_mask *mod_mask)
 {
-	if (unlikely(p4d_none(*p4d))) {
+	if (unlikely(p4d_none(p4dp_get(p4d)))) {
 		if (__pud_alloc(mm, p4d, address))
 			return NULL;
 		*mod_mask |= PGTBL_P4D_MODIFIED;
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 5bd02c6208e7..7e0a4974b0fc 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -31,7 +31,7 @@ void pgd_clear_bad(pgd_t *pgd)
 #ifndef __PAGETABLE_P4D_FOLDED
 void p4d_clear_bad(p4d_t *p4d)
 {
-	p4d_ERROR(*p4d);
+	p4d_ERROR(p4dp_get(p4d));
 	p4d_clear(p4d);
 }
 #endif
@@ -39,7 +39,7 @@ void p4d_clear_bad(p4d_t *p4d)
 #ifndef __PAGETABLE_PUD_FOLDED
 void pud_clear_bad(pud_t *pud)
 {
-	pud_ERROR(*pud);
+	pud_ERROR(pudp_get(pud));
 	pud_clear(pud);
 }
 #endif
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 32ae8e829329..2c40224b8ad0 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -53,7 +53,7 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	p4d_t val = READ_ONCE(*p4d);
+	p4d_t val = p4dp_get(p4d);
 
 #if CONFIG_PGTABLE_LEVELS > 3 && \
 		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
diff --git a/mm/rmap.c b/mm/rmap.c
index ec668c48bccc..829d0cf5e384 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -813,11 +813,11 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address)
 		goto out;
 
 	p4d = p4d_offset(pgd, address);
-	if (!p4d_present(*p4d))
+	if (!p4d_present(p4dp_get(p4d)))
 		goto out;
 
 	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
+	if (!pud_present(pudp_get(pud)))
 		goto out;
 
 	pmd = pmd_offset(pud, address);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c89706e107ce..2bd1c95f107a 100644
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
@@ -220,7 +220,7 @@ void __weak __meminit pud_init(void *addr)
 p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 {
 	p4d_t *p4d = p4d_offset(pgd, addr);
-	if (p4d_none(*p4d)) {
+	if (p4d_none(p4dp_get(p4d))) {
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d27aa1ebaad6..c67b067f4686 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -200,7 +200,7 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
 	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
 		return 0;
 
-	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
+	if (pud_present(pudp_get(pud)) && !pud_free_pmd_page(pud, addr))
 		return 0;
 
 	return pud_set_huge(pud, phys_addr, prot);
@@ -251,7 +251,7 @@ static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
 	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
 		return 0;
 
-	if (p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr))
+	if (p4d_present(p4dp_get(p4d)) && !p4d_free_pud_page(p4d, addr))
 		return 0;
 
 	return p4d_set_huge(p4d, phys_addr, prot);
@@ -396,7 +396,7 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		next = pud_addr_end(addr, end);
 
 		cleared = pud_clear_huge(pud);
-		if (cleared || pud_bad(*pud))
+		if (cleared || pud_bad(pudp_get(pud)))
 			*mask |= PGTBL_PUD_MODIFIED;
 
 		if (cleared)
@@ -418,7 +418,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 		next = p4d_addr_end(addr, end);
 
 		p4d_clear_huge(p4d);
-		if (p4d_bad(*p4d))
+		if (p4d_bad(p4dp_get(p4d)))
 			*mask |= PGTBL_P4D_MODIFIED;
 
 		if (p4d_none_or_clear_bad(p4d))
@@ -760,19 +760,19 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 		return NULL;
 
 	p4d = p4d_offset(pgd, addr);
-	if (p4d_none(*p4d))
+	if (p4d_none(p4dp_get(p4d)))
 		return NULL;
-	if (p4d_leaf(*p4d))
-		return p4d_page(*p4d) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
-	if (WARN_ON_ONCE(p4d_bad(*p4d)))
+	if (p4d_leaf(p4dp_get(p4d)))
+		return p4d_page(p4dp_get(p4d)) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(p4d_bad(p4dp_get(p4d))))
 		return NULL;
 
 	pud = pud_offset(p4d, addr);
-	if (pud_none(*pud))
+	if (pud_none(pudp_get(pud)))
 		return NULL;
-	if (pud_leaf(*pud))
-		return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (WARN_ON_ONCE(pud_bad(*pud)))
+	if (pud_leaf(pudp_get(pud)))
+		return pud_page(pudp_get(pud)) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(pud_bad(pudp_get(pud))))
 		return NULL;
 
 	pmd = pmd_offset(pud, addr);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd489c1af228..b16925b5f072 100644
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
@@ -3579,7 +3579,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 	unsigned long next;
 	struct lru_gen_mm_walk *walk = args->private;
 
-	VM_WARN_ON_ONCE(p4d_leaf(*p4d));
+	VM_WARN_ON_ONCE(p4d_leaf(p4dp_get(p4d)));
 
 	pud = pud_offset(p4d, start & P4D_MASK);
 restart:
-- 
2.25.1


