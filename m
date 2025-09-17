Return-Path: <linux-fsdevel+bounces-61866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF59B7F688
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38C55273D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 03:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF7C2F7AAF;
	Wed, 17 Sep 2025 03:38:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A62DFA25;
	Wed, 17 Sep 2025 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080286; cv=none; b=jyqtxlNklu6sjSN3rjJFecBDO2K6TEYWMCjTMr9wPRoXfgtf2DiQ7ZZenHgU+BX+zeAnrxrzlI3uwNqh5m5Wcrv03MHyuyy1r61H8FPGVvaSByVkd9el4rJ0LKjhzcWkUYSs7nws9V5Zm1pFC0p/5rCSnLTS4b2YKAQAfPG7aRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080286; c=relaxed/simple;
	bh=dEd3YvKYtJhwna/QJbFdGeqLzO7yuEcGfh1R+HLo+So=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXrY09wcWhC1mTWBLFGuK5tjj2RhbFoprEGZ/4xRIdZ4e7e4fY+0rlH/hPGii6JHbX2EAHK/wAsudbs+I8t+R0qZDU9o4hQXSnZNTszpSfLHXTn7Y4sreeoSqTC6KiUJcEU5ZDc2suuElCJhNy3fPDFDnDsv92mQ23BCt99G9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowABnsXvsLMpojtxAAw--.607S3;
	Wed, 17 Sep 2025 11:37:21 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V13 1/6] mm: softdirty: Add pgtable_supports_soft_dirty()
Date: Wed, 17 Sep 2025 11:36:58 +0800
Message-Id: <20250917033703.1695933-2-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917033703.1695933-1-zhangchunyan@iscas.ac.cn>
References: <20250917033703.1695933-1-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnsXvsLMpojtxAAw--.607S3
X-Coremail-Antispam: 1UD129KBjvJXoW3CF4Duw13Ar4UWF1UuFW3KFg_yoWkCF4kpF
	WkG3WYq3y8tFn2grWxJr4qvry3KrZaga4UCr1a9348Aay5t345XF1rXFWrZFnIqry8Za4f
	ZFsFyw43C3y7Kr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7
	CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x07bVsjbUUUUU=
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiBgsIB2jJ7zj1jgAAsP

Some platforms can customize the PTE PMD entry soft-dirty bit making it
unavailable even if the architecture provides the resource.

Add an API which architectures can define their specific implementations
to detect if soft-dirty bit is available on which device the kernel is
running.

This patch is removing "ifdef CONFIG_MEM_SOFT_DIRTY" in favor of
pgtable_supports_soft_dirty() checks that defaults to
IS_ENABLED(CONFIG_MEM_SOFT_DIRTY), if not overridden by
the architecture, no change in behavior is expected.

We make sure to never set VM_SOFTDIRTY if !pgtable_supports_soft_dirty(),
so we will never run into VM_SOFTDIRTY checks.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 fs/proc/task_mmu.c      | 15 ++++++---------
 include/linux/mm.h      |  3 +++
 include/linux/pgtable.h | 12 ++++++++++++
 mm/debug_vm_pgtable.c   | 10 +++++-----
 mm/huge_memory.c        | 13 +++++++------
 mm/internal.h           |  2 +-
 mm/mmap.c               |  6 ++++--
 mm/mremap.c             | 13 +++++++------
 mm/userfaultfd.c        | 10 ++++------
 mm/vma.c                |  6 ++++--
 mm/vma_exec.c           |  5 ++++-
 11 files changed, 57 insertions(+), 38 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ced01cf3c5ab..18c55e21bd16 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1582,8 +1582,6 @@ struct clear_refs_private {
 	enum clear_refs_types type;
 };
 
-#ifdef CONFIG_MEM_SOFT_DIRTY
-
 static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 {
 	struct folio *folio;
@@ -1603,6 +1601,8 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
 static inline void clear_soft_dirty(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *pte)
 {
+	if (!pgtable_supports_soft_dirty())
+		return;
 	/*
 	 * The soft-dirty tracker uses #PF-s to catch writes
 	 * to pages, so write-protect the pte as well. See the
@@ -1625,19 +1625,16 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
 }
-#else
-static inline void clear_soft_dirty(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *pte)
-{
-}
-#endif
 
-#if defined(CONFIG_MEM_SOFT_DIRTY) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
 static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmdp)
 {
 	pmd_t old, pmd = *pmdp;
 
+	if (!pgtable_supports_soft_dirty())
+		return;
+
 	if (pmd_present(pmd)) {
 		/* See comment in change_huge_pmd() */
 		old = pmdp_invalidate(vma, addr, pmdp);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d004fb7d805d..c5bc449a65d5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -798,6 +798,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 static inline void vm_flags_init(struct vm_area_struct *vma,
 				 vm_flags_t flags)
 {
+	VM_WARN_ON_ONCE(!pgtable_supports_soft_dirty() && (flags & VM_SOFTDIRTY));
 	ACCESS_PRIVATE(vma, __vm_flags) = flags;
 }
 
@@ -816,6 +817,7 @@ static inline void vm_flags_reset(struct vm_area_struct *vma,
 static inline void vm_flags_reset_once(struct vm_area_struct *vma,
 				       vm_flags_t flags)
 {
+	VM_WARN_ON_ONCE(!pgtable_supports_soft_dirty() && (flags & VM_SOFTDIRTY));
 	vma_assert_write_locked(vma);
 	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
 }
@@ -823,6 +825,7 @@ static inline void vm_flags_reset_once(struct vm_area_struct *vma,
 static inline void vm_flags_set(struct vm_area_struct *vma,
 				vm_flags_t flags)
 {
+	VM_WARN_ON_ONCE(!pgtable_supports_soft_dirty() && (flags & VM_SOFTDIRTY));
 	vma_start_write(vma);
 	ACCESS_PRIVATE(vma, __vm_flags) |= flags;
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 32e8457ad535..b13b6f42be3c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1553,6 +1553,18 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 #define arch_start_context_switch(prev)	do {} while (0)
 #endif
 
+/*
+ * Some platforms can customize the PTE soft-dirty bit making it unavailable
+ * even if the architecture provides the resource.
+ * Adding this API allows architectures to add their own checks for the
+ * devices on which the kernel is running.
+ * Note: When overriding it, please make sure the CONFIG_MEM_SOFT_DIRTY
+ * is part of this macro.
+ */
+#ifndef pgtable_supports_soft_dirty
+#define pgtable_supports_soft_dirty()	IS_ENABLED(CONFIG_MEM_SOFT_DIRTY)
+#endif
+
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 #ifndef CONFIG_ARCH_ENABLE_THP_MIGRATION
 static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 830107b6dd08..6a5b226bda28 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -690,7 +690,7 @@ static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
 
-	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
+	if (!pgtable_supports_soft_dirty())
 		return;
 
 	pr_debug("Validating PTE soft dirty\n");
@@ -702,7 +702,7 @@ static void __init pte_swap_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pte_t pte;
 
-	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
+	if (!pgtable_supports_soft_dirty())
 		return;
 
 	pr_debug("Validating PTE swap soft dirty\n");
@@ -718,7 +718,7 @@ static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
-	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
+	if (!pgtable_supports_soft_dirty())
 		return;
 
 	if (!has_transparent_hugepage())
@@ -734,8 +734,8 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
-	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) ||
-		!IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
+	if (!pgtable_supports_soft_dirty() ||
+	    !IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
 		return;
 
 	if (!has_transparent_hugepage())
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5acca24bbabb..85dca384375e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2263,12 +2263,13 @@ static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
 
 static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 {
-#ifdef CONFIG_MEM_SOFT_DIRTY
-	if (unlikely(is_pmd_migration_entry(pmd)))
-		pmd = pmd_swp_mksoft_dirty(pmd);
-	else if (pmd_present(pmd))
-		pmd = pmd_mksoft_dirty(pmd);
-#endif
+	if (pgtable_supports_soft_dirty()) {
+		if (unlikely(is_pmd_migration_entry(pmd)))
+			pmd = pmd_swp_mksoft_dirty(pmd);
+		else if (pmd_present(pmd))
+			pmd = pmd_mksoft_dirty(pmd);
+	}
+
 	return pmd;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 63e3ec8d63be..6a4219cdff58 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1530,7 +1530,7 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
 	 * will be constantly true.
 	 */
-	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
+	if (!pgtable_supports_soft_dirty())
 		return false;
 
 	/*
diff --git a/mm/mmap.c b/mm/mmap.c
index 266711d1c91c..4ce7d4667766 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1451,8 +1451,10 @@ static struct vm_area_struct *__install_special_mapping(
 		return ERR_PTR(-ENOMEM);
 
 	vma_set_range(vma, addr, addr + len, 0);
-	vm_flags_init(vma, (vm_flags | mm->def_flags |
-		      VM_DONTEXPAND | VM_SOFTDIRTY) & ~VM_LOCKED_MASK);
+	vm_flags |= mm->def_flags | VM_DONTEXPAND;
+	if (pgtable_supports_soft_dirty())
+		vm_flags |= VM_SOFTDIRTY;
+	vm_flags_init(vma, vm_flags & ~VM_LOCKED_MASK);
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 
 	vma->vm_ops = ops;
diff --git a/mm/mremap.c b/mm/mremap.c
index 35de0a7b910e..35a135cd149a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -162,12 +162,13 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 	 * Set soft dirty bit so we can notice
 	 * in userspace the ptes were moved.
 	 */
-#ifdef CONFIG_MEM_SOFT_DIRTY
-	if (pte_present(pte))
-		pte = pte_mksoft_dirty(pte);
-	else if (is_swap_pte(pte))
-		pte = pte_swp_mksoft_dirty(pte);
-#endif
+	if (pgtable_supports_soft_dirty()) {
+		if (pte_present(pte))
+			pte = pte_mksoft_dirty(pte);
+		else if (is_swap_pte(pte))
+			pte = pte_swp_mksoft_dirty(pte);
+	}
+
 	return pte;
 }
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index af61b95c89e4..ea8ce18483fe 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1116,9 +1116,8 @@ static long move_present_ptes(struct mm_struct *mm,
 
 		orig_dst_pte = folio_mk_pte(src_folio, dst_vma->vm_page_prot);
 		/* Set soft dirty bit so userspace can notice the pte was moved */
-#ifdef CONFIG_MEM_SOFT_DIRTY
-		orig_dst_pte = pte_mksoft_dirty(orig_dst_pte);
-#endif
+		if (pgtable_supports_soft_dirty())
+			orig_dst_pte = pte_mksoft_dirty(orig_dst_pte);
 		if (pte_dirty(orig_src_pte))
 			orig_dst_pte = pte_mkdirty(orig_dst_pte);
 		orig_dst_pte = pte_mkwrite(orig_dst_pte, dst_vma);
@@ -1205,9 +1204,8 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	}
 
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
-#ifdef CONFIG_MEM_SOFT_DIRTY
-	orig_src_pte = pte_swp_mksoft_dirty(orig_src_pte);
-#endif
+	if (pgtable_supports_soft_dirty())
+		orig_src_pte = pte_swp_mksoft_dirty(orig_src_pte);
 	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
 	double_pt_unlock(dst_ptl, src_ptl);
 
diff --git a/mm/vma.c b/mm/vma.c
index 1be297f7bb00..674b7a7c6132 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2568,7 +2568,8 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
 	 * then new mapped in-place (which must be aimed as
 	 * a completely new data area).
 	 */
-	vm_flags_set(vma, VM_SOFTDIRTY);
+	if (pgtable_supports_soft_dirty())
+		vm_flags_set(vma, VM_SOFTDIRTY);
 
 	vma_set_page_prot(vma);
 }
@@ -2843,7 +2844,8 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	mm->data_vm += len >> PAGE_SHIFT;
 	if (vm_flags & VM_LOCKED)
 		mm->locked_vm += (len >> PAGE_SHIFT);
-	vm_flags_set(vma, VM_SOFTDIRTY);
+	if (pgtable_supports_soft_dirty())
+		vm_flags_set(vma, VM_SOFTDIRTY);
 	return 0;
 
 mas_store_fail:
diff --git a/mm/vma_exec.c b/mm/vma_exec.c
index 922ee51747a6..a822fb73f4e2 100644
--- a/mm/vma_exec.c
+++ b/mm/vma_exec.c
@@ -107,6 +107,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
 			  unsigned long *top_mem_p)
 {
+	unsigned long flags  = VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP;
 	int err;
 	struct vm_area_struct *vma = vm_area_alloc(mm);
 
@@ -137,7 +138,9 @@ int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
 	BUILD_BUG_ON(VM_STACK_FLAGS & VM_STACK_INCOMPLETE_SETUP);
 	vma->vm_end = STACK_TOP_MAX;
 	vma->vm_start = vma->vm_end - PAGE_SIZE;
-	vm_flags_init(vma, VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP);
+	if (pgtable_supports_soft_dirty())
+		flags |= VM_SOFTDIRTY;
+	vm_flags_init(vma, flags);
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 
 	err = insert_vm_struct(mm, vma);
-- 
2.34.1


