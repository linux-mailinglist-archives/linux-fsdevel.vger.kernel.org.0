Return-Path: <linux-fsdevel+bounces-29559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D1397AC2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A776BB2345D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 07:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600D615350B;
	Tue, 17 Sep 2024 07:32:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41E51547E1;
	Tue, 17 Sep 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558341; cv=none; b=Yvy7nblNXZXPL/uzCFCjtghviiDkFGVCamv75q5ajxzEXzSbZTemb2V31K/ImNZSUMdYh0FcQvw/ujSVVvO3gVLi6zNYmIzGcw4C0t+lLK2wyoBeNf7prGZS2hbgucb87sKRGJbqC1ih+sNTf85NUPwDgqDs8nbK/xuNbYV/f3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558341; c=relaxed/simple;
	bh=C23YUUtESr3bgzB+FarDRqPleSRIGmOGEvTDv35QskE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6GnrAkffAIKgsXYcmaB/L7jefQRCiBa/m9FfxYoe1yvxkXl/x45hiclarxvsbgtBU56l7lomw9vQireeIBKO5GEu1qubFyrcbI60Ep3cphpTrWyRHknsBNIMmyRhc79jLCCxYWlfClIqHXtfPuj/+Wxg7RkBYEs36oxK6N1e1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9BCB1063;
	Tue, 17 Sep 2024 00:32:47 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.61.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19E0A3F64C;
	Tue, 17 Sep 2024 00:32:10 -0700 (PDT)
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
Subject: [PATCH V2 7/7] mm: Use pgdp_get() for accessing PGD entries
Date: Tue, 17 Sep 2024 13:01:17 +0530
Message-Id: <20240917073117.1531207-8-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240917073117.1531207-1-anshuman.khandual@arm.com>
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert PGD accesses via pgdp_get() helper that defaults as READ_ONCE() but
also provides the platform an opportunity to override when required. This
stores read page table entry value in a local variable which can be used in
multiple instances there after. This helps in avoiding multiple memory load
operations as well possible race conditions.

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
Cc: linux-mm@kvack.org
Cc: linux-perf-users@vger.kernel.org
Cc: kasan-dev@googlegroups.com
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/misc/sgi-gru/grufault.c |  2 +-
 fs/userfaultfd.c                |  2 +-
 include/linux/mm.h              |  2 +-
 include/linux/pgtable.h         |  9 ++++++---
 kernel/events/core.c            |  2 +-
 mm/gup.c                        | 11 ++++++-----
 mm/hugetlb.c                    |  2 +-
 mm/kasan/init.c                 |  8 ++++----
 mm/kasan/shadow.c               |  2 +-
 mm/memory-failure.c             |  2 +-
 mm/memory.c                     | 16 +++++++++-------
 mm/page_vma_mapped.c            |  2 +-
 mm/percpu.c                     |  2 +-
 mm/pgalloc-track.h              |  2 +-
 mm/pgtable-generic.c            |  2 +-
 mm/rmap.c                       |  2 +-
 mm/sparse-vmemmap.c             |  2 +-
 mm/vmalloc.c                    | 13 +++++++------
 18 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index fcaceac60659..6aeccbd440e7 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -212,7 +212,7 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
 	pte_t pte;
 
 	pgdp = pgd_offset(vma->vm_mm, vaddr);
-	if (unlikely(pgd_none(*pgdp)))
+	if (unlikely(pgd_none(pgdp_get(pgdp))))
 		goto err;
 
 	p4dp = p4d_offset(pgdp, vaddr);
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4044e15cdfd9..6d33c7a9eb01 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -304,7 +304,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	assert_fault_locked(vmf);
 
 	pgd = pgd_offset(mm, address);
-	if (!pgd_present(*pgd))
+	if (!pgd_present(pgdp_get(pgd)))
 		goto out;
 	p4d = p4d_offset(pgd, address);
 	if (!p4d_present(p4dp_get(p4d)))
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1bb1599b5779..1978a4b1fcf5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2819,7 +2819,7 @@ int __pte_alloc_kernel(pmd_t *pmd);
 static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
 		unsigned long address)
 {
-	return (unlikely(pgd_none(*pgd)) && __p4d_alloc(mm, pgd, address)) ?
+	return (unlikely(pgd_none(pgdp_get(pgd))) && __p4d_alloc(mm, pgd, address)) ?
 		NULL : p4d_offset(pgd, address);
 }
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 689cd5a32157..6d12ae7e3982 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1088,7 +1088,8 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
 
 #define set_pgd_safe(pgdp, pgd) \
 ({ \
-	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
+	pgd_t __old = pgdp_get(pgdp); \
+	WARN_ON_ONCE(pgd_present(__old) && !pgd_same(__old, pgd)); \
 	set_pgd(pgdp, pgd); \
 })
 
@@ -1241,9 +1242,11 @@ void pmd_clear_bad(pmd_t *);
 
 static inline int pgd_none_or_clear_bad(pgd_t *pgd)
 {
-	if (pgd_none(*pgd))
+	pgd_t old_pgd = pgdp_get(pgd);
+
+	if (pgd_none(old_pgd))
 		return 1;
-	if (unlikely(pgd_bad(*pgd))) {
+	if (unlikely(pgd_bad(old_pgd))) {
 		pgd_clear_bad(pgd);
 		return 1;
 	}
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4e56a276ed25..1e3142211cce 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7603,7 +7603,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	pte_t *ptep, pte;
 
 	pgdp = pgd_offset(mm, addr);
-	pgd = READ_ONCE(*pgdp);
+	pgd = pgdp_get(pgdp);
 	if (pgd_none(pgd))
 		return 0;
 
diff --git a/mm/gup.c b/mm/gup.c
index 3a97d0263052..3aff3555ba19 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1051,7 +1051,7 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 			      unsigned long address, unsigned int flags,
 			      struct follow_page_context *ctx)
 {
-	pgd_t *pgd;
+	pgd_t *pgd, old_pgd;
 	struct mm_struct *mm = vma->vm_mm;
 	struct page *page;
 
@@ -1060,7 +1060,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	ctx->page_mask = 0;
 	pgd = pgd_offset(mm, address);
 
-	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+	old_pgd = pgdp_get(pgd);
+	if (pgd_none(old_pgd) || unlikely(pgd_bad(old_pgd)))
 		page = no_page_table(vma, flags, address);
 	else
 		page = follow_p4d_mask(vma, address, pgd, flags, ctx);
@@ -1111,7 +1112,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 		pgd = pgd_offset_k(address);
 	else
 		pgd = pgd_offset_gate(mm, address);
-	if (pgd_none(*pgd))
+	if (pgd_none(pgdp_get(pgd)))
 		return -EFAULT;
 	p4d = p4d_offset(pgd, address);
 	if (p4d_none(p4dp_get(p4d)))
@@ -3158,7 +3159,7 @@ static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	if (!folio)
 		return 0;
 
-	if (unlikely(pgd_val(orig) != pgd_val(*pgdp))) {
+	if (unlikely(pgd_val(orig) != pgd_val(pgdp_get(pgdp)))) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
@@ -3267,7 +3268,7 @@ static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 
 	pgdp = pgd_offset(current->mm, addr);
 	do {
-		pgd_t pgd = READ_ONCE(*pgdp);
+		pgd_t pgd = pgdp_get(pgdp);
 
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4fdb91c8cc2b..294d74b03d83 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7451,7 +7451,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	pmd_t *pmd;
 
 	pgd = pgd_offset(mm, addr);
-	if (!pgd_present(*pgd))
+	if (!pgd_present(pgdp_get(pgd)))
 		return NULL;
 	p4d = p4d_offset(pgd, addr);
 	if (!p4d_present(p4dp_get(p4d)))
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 02af738fee5e..c2b307716551 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -271,7 +271,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			continue;
 		}
 
-		if (pgd_none(*pgd)) {
+		if (pgd_none(pgdp_get(pgd))) {
 			p4d_t *p;
 
 			if (slab_is_available()) {
@@ -345,7 +345,7 @@ static void kasan_free_p4d(p4d_t *p4d_start, pgd_t *pgd)
 			return;
 	}
 
-	p4d_free(&init_mm, (p4d_t *)page_to_virt(pgd_page(*pgd)));
+	p4d_free(&init_mm, (p4d_t *)page_to_virt(pgd_page(pgdp_get(pgd))));
 	pgd_clear(pgd);
 }
 
@@ -468,10 +468,10 @@ void kasan_remove_zero_shadow(void *start, unsigned long size)
 		next = pgd_addr_end(addr, end);
 
 		pgd = pgd_offset_k(addr);
-		if (!pgd_present(*pgd))
+		if (!pgd_present(pgdp_get(pgd)))
 			continue;
 
-		if (kasan_p4d_table(*pgd)) {
+		if (kasan_p4d_table(pgdp_get(pgd))) {
 			if (IS_ALIGNED(addr, PGDIR_SIZE) &&
 			    IS_ALIGNED(next, PGDIR_SIZE)) {
 				pgd_clear(pgd);
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 52150cc5ae5f..7f3c46237816 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -191,7 +191,7 @@ static bool shadow_mapped(unsigned long addr)
 	pmd_t *pmd;
 	pte_t *pte;
 
-	if (pgd_none(*pgd))
+	if (pgd_none(pgdp_get(pgd)))
 		return false;
 	p4d = p4d_offset(pgd, addr);
 	if (p4d_none(p4dp_get(p4d)))
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3d900cc039b3..c9397eab52bd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -411,7 +411,7 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 
 	VM_BUG_ON_VMA(address == -EFAULT, vma);
 	pgd = pgd_offset(vma->vm_mm, address);
-	if (!pgd_present(*pgd))
+	if (!pgd_present(pgdp_get(pgd)))
 		return 0;
 	p4d = p4d_offset(pgd, address);
 	if (!p4d_present(p4dp_get(p4d)))
diff --git a/mm/memory.c b/mm/memory.c
index 5056f39f2c3b..b4845a84ceb5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2942,7 +2942,7 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 				 unsigned long size, pte_fn_t fn,
 				 void *data, bool create)
 {
-	pgd_t *pgd;
+	pgd_t *pgd, old_pgd;
 	unsigned long start = addr, next;
 	unsigned long end = addr + size;
 	pgtbl_mod_mask mask = 0;
@@ -2954,11 +2954,12 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 	pgd = pgd_offset(mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		if (pgd_none(*pgd) && !create)
+		old_pgd = pgdp_get(pgd);
+		if (pgd_none(old_pgd) && !create)
 			continue;
-		if (WARN_ON_ONCE(pgd_leaf(*pgd)))
+		if (WARN_ON_ONCE(pgd_leaf(old_pgd)))
 			return -EINVAL;
-		if (!pgd_none(*pgd) && WARN_ON_ONCE(pgd_bad(*pgd))) {
+		if (!pgd_none(old_pgd) && WARN_ON_ONCE(pgd_bad(old_pgd))) {
 			if (!create)
 				continue;
 			pgd_clear_bad(pgd);
@@ -6053,7 +6054,7 @@ int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 		return -ENOMEM;
 
 	spin_lock(&mm->page_table_lock);
-	if (pgd_present(*pgd)) {	/* Another has populated it */
+	if (pgd_present(pgdp_get(pgd))) {	/* Another has populated it */
 		p4d_free(mm, new);
 	} else {
 		smp_wmb(); /* See comment in pmd_install() */
@@ -6143,7 +6144,7 @@ int follow_pte(struct vm_area_struct *vma, unsigned long address,
 	       pte_t **ptepp, spinlock_t **ptlp)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	pgd_t *pgd;
+	pgd_t *pgd, old_pgd;
 	p4d_t *p4d, old_p4d;
 	pud_t *pud;
 	pmd_t *pmd;
@@ -6157,7 +6158,8 @@ int follow_pte(struct vm_area_struct *vma, unsigned long address,
 		goto out;
 
 	pgd = pgd_offset(mm, address);
-	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+	old_pgd = pgdp_get(pgd);
+	if (pgd_none(old_pgd) || unlikely(pgd_bad(old_pgd)))
 		goto out;
 
 	p4d = p4d_offset(pgd, address);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index a33f92db2666..fb8b610f7378 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -212,7 +212,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 restart:
 	do {
 		pgd = pgd_offset(mm, pvmw->address);
-		if (!pgd_present(*pgd)) {
+		if (!pgd_present(pgdp_get(pgd))) {
 			step_forward(pvmw, PGDIR_SIZE);
 			continue;
 		}
diff --git a/mm/percpu.c b/mm/percpu.c
index 58660e8eb892..70e68ab002e9 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3184,7 +3184,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 	pud_t *pud;
 	pmd_t *pmd;
 
-	if (pgd_none(*pgd)) {
+	if (pgd_none(pgdp_get(pgd))) {
 		p4d = memblock_alloc(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
 		if (!p4d)
 			goto err_alloc;
diff --git a/mm/pgalloc-track.h b/mm/pgalloc-track.h
index 3db8ccbcb141..644f632c7cba 100644
--- a/mm/pgalloc-track.h
+++ b/mm/pgalloc-track.h
@@ -7,7 +7,7 @@ static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
 				     unsigned long address,
 				     pgtbl_mod_mask *mod_mask)
 {
-	if (unlikely(pgd_none(*pgd))) {
+	if (unlikely(pgd_none(pgdp_get(pgd)))) {
 		if (__p4d_alloc(mm, pgd, address))
 			return NULL;
 		*mod_mask |= PGTBL_PGD_MODIFIED;
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index f5ab52beb536..16c1ed5b3d0b 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -24,7 +24,7 @@
 
 void pgd_clear_bad(pgd_t *pgd)
 {
-	pgd_ERROR(*pgd);
+	pgd_ERROR(pgdp_get(pgd));
 	pgd_clear(pgd);
 }
 
diff --git a/mm/rmap.c b/mm/rmap.c
index a0ff325467eb..5f4c52f34192 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -809,7 +809,7 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address)
 	pmd_t *pmd = NULL;
 
 	pgd = pgd_offset(mm, address);
-	if (!pgd_present(*pgd))
+	if (!pgd_present(pgdp_get(pgd)))
 		goto out;
 
 	p4d = p4d_offset(pgd, address);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 2bd1c95f107a..ffc78329a130 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -233,7 +233,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 {
 	pgd_t *pgd = pgd_offset_k(addr);
-	if (pgd_none(*pgd)) {
+	if (pgd_none(pgdp_get(pgd))) {
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f27ecac7bd6e..a40323a8c6ab 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -450,7 +450,7 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		if (pgd_bad(*pgd))
+		if (pgd_bad(pgdp_get(pgd)))
 			mask |= PGTBL_PGD_MODIFIED;
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
@@ -582,7 +582,7 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		if (pgd_bad(*pgd))
+		if (pgd_bad(pgdp_get(pgd)))
 			mask |= PGTBL_PGD_MODIFIED;
 		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
 		if (err)
@@ -740,7 +740,7 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 {
 	unsigned long addr = (unsigned long) vmalloc_addr;
 	struct page *page = NULL;
-	pgd_t *pgd = pgd_offset_k(addr);
+	pgd_t *pgd = pgd_offset_k(addr), old_pgd;
 	p4d_t *p4d, old_p4d;
 	pud_t *pud, old_pud;
 	pmd_t *pmd, old_pmd;
@@ -752,11 +752,12 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 	 */
 	VIRTUAL_BUG_ON(!is_vmalloc_or_module_addr(vmalloc_addr));
 
-	if (pgd_none(*pgd))
+	old_pgd = pgdp_get(pgd);
+	if (pgd_none(old_pgd))
 		return NULL;
-	if (WARN_ON_ONCE(pgd_leaf(*pgd)))
+	if (WARN_ON_ONCE(pgd_leaf(old_pgd)))
 		return NULL; /* XXX: no allowance for huge pgd */
-	if (WARN_ON_ONCE(pgd_bad(*pgd)))
+	if (WARN_ON_ONCE(pgd_bad(old_pgd)))
 		return NULL;
 
 	p4d = p4d_offset(pgd, addr);
-- 
2.25.1


