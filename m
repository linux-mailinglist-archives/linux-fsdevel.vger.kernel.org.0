Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8F965249E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 17:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiLTQ1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 11:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiLTQ1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:27:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBBE1AF25;
        Tue, 20 Dec 2022 08:26:58 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.25.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 578166602CA0;
        Tue, 20 Dec 2022 16:26:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671553617;
        bh=H/yXJ+C5YIAsByTqG2HS8f40ouw5wHWvBLV2umMJBWE=;
        h=From:To:Cc:Subject:Date:From;
        b=obpNYqXUxEOjSrti3bPlgqfPTuW193Kwt7bQmLKGZIF2Cphwe6FhH96wSqkBYI+wO
         BLqowYo3XgQgizNvWPC3Bo8tLXsFFvjKmIhzKjQBNgCO97+g9iz8PkqXbV4gyUMzi7
         IIUOJM/DttOAyTk8V3cHjpLxQ9wb2lsRHCipat6mC+QqG1hAwELr5nkbubVovtuHpb
         v/aY1qpAvmZ+IY51RqJwi8eSdOIfDF2cw7SA5jyH6I84xkFtCxT/h1ffzChObZVvtS
         jX7IWUwHeGK5CmGp76KZYklz2rGuB/YWIWSMo3/kBQEzTgjeaLTnnOq1aBxVG6Fn0b
         hxpGnPL1ubLsQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, peterx@redhat.com, david@redhat.com,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC] mm: implement granular soft-dirty vma support
Date:   Tue, 20 Dec 2022 21:26:05 +0500
Message-Id: <20221220162606.1595355-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The VM_SOFTDIRTY is used to mark a whole VMA soft-dirty. Sometimes
soft-dirty and non-soft-dirty VMAs are merged making the non-soft-dirty
region soft-dirty. This creates problems as the whole VMA region comes
out to be soft-dirty while in-reality no there is no soft-dirty page.
This can be solved by not merging the VMAs with different soft-dirty
flags. But it has potential to cause regression as the number of VMAs
can increase drastically.

This patch introduces non-soft-dirty regions tracking on VMA level. The
implementation is clean when non-soft-dirty regions are tracked. There
is no overhead for cases when soft-dirty flag isn't used by the
application. The real non-soft-dirty tracking in the VMA starts when the
soft-dirty flag is cleared from the user side. Then the list is
manipulated along with the VMA manipulations like split/merge/expand the
VMAs.

The sd flag is still shown in the smaps file. Only the softdirty will
not show up in format strings as its corresponding VM_SOFTDIRTY has
been removed which seems justified.

Overall, this patch should correct the soft-dirty tracking on the VMA
level. There shouldn't be any impact on the user's view other than now
the user will not get affected by kernel's internal activity (VMA
merging/splitting).

Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Cyrill has pointed to this kind of solution [1].

[1] https://lore.kernel.org/all/Y4W0axw0ZgORtfkt@grain
---
 fs/exec.c                      |   2 +-
 fs/proc/task_mmu.c             |  52 ++++++++++-----
 include/linux/mm.h             |   7 +-
 include/linux/mm_inline.h      | 117 +++++++++++++++++++++++++++++++++
 include/linux/mm_types.h       |   7 ++
 include/trace/events/mmflags.h |   7 --
 kernel/fork.c                  |   4 ++
 mm/gup.c                       |   6 +-
 mm/huge_memory.c               |   8 +--
 mm/internal.h                  |  22 ++++++-
 mm/mmap.c                      |  45 +++++--------
 mm/mprotect.c                  |   4 +-
 12 files changed, 214 insertions(+), 67 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index ab913243a367..30616601567c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -270,7 +270,7 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 	BUILD_BUG_ON(VM_STACK_FLAGS & VM_STACK_INCOMPLETE_SETUP);
 	vma->vm_end = STACK_TOP_MAX;
 	vma->vm_start = vma->vm_end - PAGE_SIZE;
-	vma->vm_flags = VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP;
+	vma->vm_flags = VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP;
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 
 	err = insert_vm_struct(mm, vma);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f444da25e2e2..bdb4eaf21986 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -683,9 +683,6 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_DONTDUMP)]	= "dd",
 #ifdef CONFIG_ARM64_BTI
 		[ilog2(VM_ARM64_BTI)]	= "bt",
-#endif
-#ifdef CONFIG_MEM_SOFT_DIRTY
-		[ilog2(VM_SOFTDIRTY)]	= "sd",
 #endif
 		[ilog2(VM_MIXEDMAP)]	= "mm",
 		[ilog2(VM_HUGEPAGE)]	= "hg",
@@ -723,6 +720,10 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 			seq_putc(m, ' ');
 		}
 	}
+
+	/* non_sd_reg isn't initialized for vsyscall vma */
+	if (is_nsdr_list_initialized(&vma->non_sd_reg) && is_vma_sd(vma))
+		seq_puts(m, "sd");
 	seq_putc(m, '\n');
 }
 
@@ -1299,10 +1300,24 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mas_for_each(&mas, vma, ULONG_MAX) {
-				if (!(vma->vm_flags & VM_SOFTDIRTY))
-					continue;
-				vma->vm_flags &= ~VM_SOFTDIRTY;
-				vma_set_page_prot(vma);
+				struct non_sd_reg *r;
+
+				if (list_empty(&vma->non_sd_reg)) {
+					r = kmalloc(sizeof(struct non_sd_reg), GFP_KERNEL);
+					list_add(&r->nsdr_head, &vma->non_sd_reg);
+				} else if (list_is_singular(&vma->non_sd_reg)) {
+					r = list_first_entry(&vma->non_sd_reg,
+							     struct non_sd_reg, nsdr_head);
+				} else {
+					while (!list_is_singular(&vma->non_sd_reg)) {
+						r = list_first_entry(&vma->non_sd_reg,
+								     struct non_sd_reg, nsdr_head);
+						list_del(&r->nsdr_head);
+						kfree(r);
+					}
+				}
+				r->start = vma->vm_start;
+				r->end = vma->vm_end;
 			}
 
 			inc_tlb_flush_pending(mm);
@@ -1397,10 +1412,13 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
 		if (!vma)
 			break;
 
-		/* Addresses in the VMA. */
-		if (vma->vm_flags & VM_SOFTDIRTY)
-			pme = make_pme(0, PM_SOFT_DIRTY);
 		for (; addr < min(end, vma->vm_end); addr += PAGE_SIZE) {
+			/* Addresses in the VMA. */
+			if (is_vma_addr_sd(vma, addr))
+				pme = make_pme(0, PM_SOFT_DIRTY);
+			else
+				pme = make_pme(0, 0);
+
 			err = add_to_pagemap(addr, &pme, pm);
 			if (err)
 				goto out;
@@ -1458,7 +1476,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		flags |= PM_FILE;
 	if (page && !migration && page_mapcount(page) == 1)
 		flags |= PM_MMAP_EXCLUSIVE;
-	if (vma->vm_flags & VM_SOFTDIRTY)
+	if (is_vma_addr_sd(vma, addr))
 		flags |= PM_SOFT_DIRTY;
 
 	return make_pme(frame, flags);
@@ -1481,7 +1499,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		pmd_t pmd = *pmdp;
 		struct page *page = NULL;
 
-		if (vma->vm_flags & VM_SOFTDIRTY)
+		if (is_vma_addr_sd(vma, addr))
 			flags |= PM_SOFT_DIRTY;
 
 		if (pmd_present(pmd)) {
@@ -1578,9 +1596,6 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	int err = 0;
 	pte_t pte;
 
-	if (vma->vm_flags & VM_SOFTDIRTY)
-		flags |= PM_SOFT_DIRTY;
-
 	pte = huge_ptep_get(ptep);
 	if (pte_present(pte)) {
 		struct page *page = pte_page(pte);
@@ -1603,7 +1618,12 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	}
 
 	for (; addr != end; addr += PAGE_SIZE) {
-		pagemap_entry_t pme = make_pme(frame, flags);
+		pagemap_entry_t pme;
+
+		if (is_vma_addr_sd(vma, addr))
+			pme = make_pme(frame, flags | PM_SOFT_DIRTY);
+		else
+			pme = make_pme(frame, flags);
 
 		err = add_to_pagemap(addr, &pme, pm);
 		if (err)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 517225fce10f..a2f11aa96d90 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -287,12 +287,6 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_WIPEONFORK	0x02000000	/* Wipe VMA contents in child. */
 #define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
 
-#ifdef CONFIG_MEM_SOFT_DIRTY
-# define VM_SOFTDIRTY	0x08000000	/* Not soft dirty clean area */
-#else
-# define VM_SOFTDIRTY	0
-#endif
-
 #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
 #define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
 #define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
@@ -609,6 +603,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	INIT_LIST_HEAD(&vma->non_sd_reg);
 }
 
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index e8ed225d8f7c..d515c2a9b10a 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -578,4 +578,121 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 #endif
 }
 
+static inline int nsdr_clone(struct vm_area_struct *new_vma, struct vm_area_struct *vma)
+{
+	struct non_sd_reg *r, *reg;
+
+	list_for_each_entry(r, &vma->non_sd_reg, nsdr_head) {
+		reg = kmalloc(sizeof(struct non_sd_reg), GFP_KERNEL);
+		if (!reg)
+			return -ENOMEM;
+		reg->start = r->start;
+		reg->end = r->end;
+		list_add_tail(&reg->nsdr_head, &new_vma->non_sd_reg);
+	}
+	return 0;
+}
+
+static inline void nsdr_clear(struct vm_area_struct *vma)
+{
+	struct non_sd_reg *r, *r_tmp;
+
+	list_for_each_entry_safe(r, r_tmp, &vma->non_sd_reg, nsdr_head) {
+		list_del(&r->nsdr_head);
+		kfree(r);
+	}
+}
+
+static inline bool is_vma_range_sd(struct vm_area_struct *vma, unsigned long addr,
+				   unsigned long end)
+{
+	struct non_sd_reg *r;
+
+	list_for_each_entry(r, &vma->non_sd_reg, nsdr_head) {
+		if (addr >= r->start && end <= r->end)
+			return false;
+	}
+	return true;
+}
+
+static inline bool is_vma_addr_sd(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct non_sd_reg *r;
+
+	list_for_each_entry(r, &vma->non_sd_reg, nsdr_head) {
+		if (addr >= r->start && addr < r->end)
+			return false;
+	}
+	return true;
+}
+
+static inline bool is_vma_sd(struct vm_area_struct *vma)
+{
+	struct non_sd_reg *r;
+
+	if (list_is_singular(&vma->non_sd_reg)) {
+		r = list_first_entry(&vma->non_sd_reg, struct non_sd_reg, nsdr_head);
+		if (r->start == vma->vm_start && r->end == vma->vm_end)
+			return false;
+	}
+	return true;
+}
+
+static inline bool is_nsdr_list_initialized(struct list_head *list)
+{
+	return (list->next != NULL);
+}
+
+static inline void nsdr_move(struct vm_area_struct *vma_to, struct vm_area_struct *vma_from)
+{
+	struct non_sd_reg *r, *r_tmp;
+
+	list_for_each_entry_safe(r, r_tmp, &vma_from->non_sd_reg, nsdr_head)
+		list_move_tail(&r->nsdr_head, &vma_to->non_sd_reg);
+}
+
+static inline int nsdr_adjust_new_first(struct vm_area_struct *new, struct vm_area_struct *vma)
+{
+	struct non_sd_reg *r, *r_tmp, *reg;
+	unsigned long mid = vma->vm_start;
+
+	list_for_each_entry_safe(r, r_tmp, &vma->non_sd_reg, nsdr_head) {
+		if (r->start < mid && r->end > mid) {
+			reg = kmalloc(sizeof(struct non_sd_reg), GFP_KERNEL);
+			if (!reg)
+				return -ENOMEM;
+			reg->start = r->start;
+			reg->end = mid;
+			list_add_tail(&reg->nsdr_head, &new->non_sd_reg);
+
+			r->start = mid;
+		} else if (r->end <= mid) {
+			list_move_tail(&r->nsdr_head, &new->non_sd_reg);
+		}
+	}
+	return 0;
+}
+
+static inline int nsdr_adjust_new_after(struct vm_area_struct *new, struct vm_area_struct *vma)
+{
+	struct non_sd_reg *r, *r_tmp, *reg;
+	unsigned long mid = vma->vm_end;
+
+	list_for_each_entry_safe(r, r_tmp, &vma->non_sd_reg, nsdr_head) {
+		if (r->start < mid && r->end > mid) {
+			reg = kmalloc(sizeof(struct non_sd_reg), GFP_KERNEL);
+			if (!reg)
+				return -ENOMEM;
+			reg->start = mid;
+			reg->end = r->end;
+			list_add_tail(&reg->nsdr_head, &new->non_sd_reg);
+
+			r->end = vma->vm_end;
+		} else if (r->start >= mid) {
+			list_move_tail(&r->nsdr_head, &new->non_sd_reg);
+		}
+	}
+	return 0;
+}
+
 #endif
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3b8475007734..c4e2dfc75d26 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -595,8 +595,15 @@ struct vm_area_struct {
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+	struct list_head non_sd_reg;
 } __randomize_layout;
 
+struct non_sd_reg {
+	struct list_head nsdr_head;
+	unsigned long start;
+	unsigned long end;
+};
+
 struct kioctx_table;
 struct mm_struct {
 	struct {
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 412b5a46374c..75cd0da07673 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -151,12 +151,6 @@ IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
 #define __VM_ARCH_SPECIFIC_1 {VM_ARCH_1,	"arch_1"	}
 #endif
 
-#ifdef CONFIG_MEM_SOFT_DIRTY
-#define IF_HAVE_VM_SOFTDIRTY(flag,name) {flag, name },
-#else
-#define IF_HAVE_VM_SOFTDIRTY(flag,name)
-#endif
-
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 # define IF_HAVE_UFFD_MINOR(flag, name) {flag, name},
 #else
@@ -191,7 +185,6 @@ IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
 	__VM_ARCH_SPECIFIC_1				,		\
 	{VM_WIPEONFORK,			"wipeonfork"	},		\
 	{VM_DONTDUMP,			"dontdump"	},		\
-IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_MIXEDMAP,			"mixedmap"	},		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..3f8d2c30efbf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -474,6 +474,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		 */
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
+		INIT_LIST_HEAD(&new->non_sd_reg);
 		dup_anon_vma_name(orig, new);
 	}
 	return new;
@@ -481,6 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 
 void vm_area_free(struct vm_area_struct *vma)
 {
+	nsdr_clear(vma);
 	free_anon_vma_name(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
@@ -650,6 +652,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		retval = dup_userfaultfd(tmp, &uf);
 		if (retval)
 			goto fail_nomem_anon_vma_fork;
+		if (nsdr_clone(tmp, mpnt))
+			goto fail_nomem_anon_vma_fork;
 		if (tmp->vm_flags & VM_WIPEONFORK) {
 			/*
 			 * VM_WIPEONFORK gets a clean slate in the child.
diff --git a/mm/gup.c b/mm/gup.c
index c2c2c6dbcfcf..aec7a0ea98b7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -496,7 +496,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 /* FOLL_FORCE can write to even unwritable PTEs in COW mappings. */
 static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 					struct vm_area_struct *vma,
-					unsigned int flags)
+					unsigned int flags, unsigned long addr)
 {
 	/* If the pte is writable, we can write to the page. */
 	if (pte_write(pte))
@@ -526,7 +526,7 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 		return false;
 
 	/* ... and a write-fault isn't required for other reasons. */
-	if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
+	if (vma_addr_soft_dirty_enabled(vma, addr, PAGE_SIZE) && !pte_soft_dirty(pte))
 		return false;
 	return !userfaultfd_pte_wp(vma, pte);
 }
@@ -562,7 +562,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	 * have to worry about pte_devmap() because they are never anon.
 	 */
 	if ((flags & FOLL_WRITE) &&
-	    !can_follow_write_pte(pte, page, vma, flags)) {
+	    !can_follow_write_pte(pte, page, vma, flags, address)) {
 		page = NULL;
 		goto out;
 	}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index abe6cfd92ffa..a6f74e5535bd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1405,7 +1405,7 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 		return false;
 
 	/* Do we need write faults for softdirty tracking? */
-	if (vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd))
+	if (vma_addr_soft_dirty_enabled(vma, addr, HPAGE_SIZE) && !pmd_soft_dirty(pmd))
 		return false;
 
 	/* Do we need write faults for uffd-wp tracking? */
@@ -1425,7 +1425,7 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 /* FOLL_FORCE can write to even unwritable PMDs in COW mappings. */
 static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
 					struct vm_area_struct *vma,
-					unsigned int flags)
+					unsigned int flags, unsigned long addr)
 {
 	/* If the pmd is writable, we can write to the page. */
 	if (pmd_write(pmd))
@@ -1455,7 +1455,7 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
 		return false;
 
 	/* ... and a write-fault isn't required for other reasons. */
-	if (vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd))
+	if (vma_addr_soft_dirty_enabled(vma, addr, PAGE_SIZE) && !pmd_soft_dirty(pmd))
 		return false;
 	return !userfaultfd_huge_pmd_wp(vma, pmd);
 }
@@ -1475,7 +1475,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
 
 	if ((flags & FOLL_WRITE) &&
-	    !can_follow_write_pmd(*pmd, page, vma, flags))
+	    !can_follow_write_pmd(*pmd, page, vma, flags, addr))
 		return NULL;
 
 	/* Avoid dumping huge zero page */
diff --git a/mm/internal.h b/mm/internal.h
index bcf75a8b032d..35f682ce7b17 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -12,6 +12,7 @@
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/mm_inline.h>
 
 struct folio_batch;
 
@@ -830,6 +831,25 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
 
 extern bool mirrored_kernelcore;
 
+static inline bool vma_addr_soft_dirty_enabled(struct vm_area_struct *vma,
+					       unsigned long addr, unsigned long end)
+{
+	/*
+	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
+	 * enablements, because when without soft-dirty being compiled in,
+	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
+	 * will be constantly true.
+	 */
+	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
+		return false;
+
+	/*
+	 * Soft-dirty is kind of special: its tracking is enabled when the
+	 * vma flags not set.
+	 */
+	return !(is_vma_range_sd(vma, addr, end));
+}
+
 static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 {
 	/*
@@ -845,7 +865,7 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 	 * Soft-dirty is kind of special: its tracking is enabled when the
 	 * vma flags not set.
 	 */
-	return !(vma->vm_flags & VM_SOFTDIRTY);
+	return !(is_vma_sd(vma));
 }
 
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index 5d54cde108c0..687fbc19ee8e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -587,6 +587,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 	}
 
 	if (remove_next) {
+		nsdr_move(vma, next);
 		if (file) {
 			uprobe_munmap(next, next->vm_start, next->vm_end);
 			fput(file);
@@ -868,15 +869,7 @@ static inline int is_mergeable_vma(struct vm_area_struct *vma,
 				struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
 				struct anon_vma_name *anon_name)
 {
-	/*
-	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
-	 * match the flags but dirty bit -- the caller should mark
-	 * merged VMA as dirty. If dirty bit won't be excluded from
-	 * comparison, we increase pressure on the memory system forcing
-	 * the kernel to generate new VMAs when old one could be
-	 * extended instead.
-	 */
-	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
+	if (vma->vm_flags ^ vm_flags)
 		return 0;
 	if (vma->vm_file != file)
 		return 0;
@@ -1050,6 +1043,9 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 		err = __vma_adjust(prev, prev->vm_start,
 					next->vm_end, prev->vm_pgoff, NULL,
 					prev);
+		if (err)
+			return NULL;
+		err = nsdr_adjust_new_first(prev, next);
 		res = prev;
 	} else if (merge_prev) {			/* cases 2, 5, 7 */
 		err = __vma_adjust(prev, prev->vm_start,
@@ -1092,7 +1088,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
 	return a->vm_end == b->vm_start &&
 		mpol_equal(vma_policy(a), vma_policy(b)) &&
 		a->vm_file == b->vm_file &&
-		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SOFTDIRTY)) &&
+		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS)) &&
 		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
 }
 
@@ -2236,8 +2232,14 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 		err = vma_adjust(vma, vma->vm_start, addr, vma->vm_pgoff, new);
 
 	/* Success. */
-	if (!err)
-		return 0;
+	if (!err) {
+		if (new_below)
+			err = nsdr_adjust_new_first(new, vma);
+		else
+			err = nsdr_adjust_new_after(new, vma);
+		if (!err)
+			return err;
+	}
 
 	/* Avoid vm accounting in close() operation */
 	new->vm_start = new->vm_end;
@@ -2728,17 +2730,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (file)
 		uprobe_mmap(vma);
 
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vma->vm_flags |= VM_SOFTDIRTY;
-
-	vma_set_page_prot(vma);
-
 	validate_mm(mm);
 	return addr;
 
@@ -2947,7 +2938,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 	 */
 	if (vma &&
 	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
-	    ((vma->vm_flags & ~VM_SOFTDIRTY) == flags)) {
+	    (vma->vm_flags == flags)) {
 		mas_set_range(mas, vma->vm_start, addr + len - 1);
 		if (mas_preallocate(mas, vma, GFP_KERNEL))
 			goto unacct_fail;
@@ -2958,7 +2949,6 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 			anon_vma_interval_tree_pre_update_vma(vma);
 		}
 		vma->vm_end = addr + len;
-		vma->vm_flags |= VM_SOFTDIRTY;
 		mas_store_prealloc(mas, vma);
 
 		if (vma->anon_vma) {
@@ -2991,7 +2981,6 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 	mm->data_vm += len >> PAGE_SHIFT;
 	if (flags & VM_LOCKED)
 		mm->locked_vm += (len >> PAGE_SHIFT);
-	vma->vm_flags |= VM_SOFTDIRTY;
 	validate_mm(mm);
 	return 0;
 
@@ -3224,6 +3213,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		new_vma->vm_pgoff = pgoff;
 		if (vma_dup_policy(vma, new_vma))
 			goto out_free_vma;
+		if (nsdr_clone(new_vma, vma))
+			goto out_free_vma;
 		if (anon_vma_clone(new_vma, vma))
 			goto out_free_mempol;
 		if (new_vma->vm_file)
@@ -3395,7 +3386,7 @@ static struct vm_area_struct *__install_special_mapping(
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 
-	vma->vm_flags = vm_flags | mm->def_flags | VM_DONTEXPAND | VM_SOFTDIRTY;
+	vma->vm_flags = vm_flags | mm->def_flags | VM_DONTEXPAND;
 	vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ce6119456d54..562d017aa9ff 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -52,7 +52,7 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 		return false;
 
 	/* Do we need write faults for softdirty tracking? */
-	if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
+	if (vma_addr_soft_dirty_enabled(vma, addr, addr + PAGE_SIZE) && !pte_soft_dirty(pte))
 		return false;
 
 	/* Do we need write faults for uffd-wp tracking? */
@@ -610,7 +610,7 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*pprev) {
 		vma = *pprev;
-		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
+		VM_WARN_ON(vma->vm_flags ^ newflags);
 		goto success;
 	}
 
-- 
2.30.2

