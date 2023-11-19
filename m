Return-Path: <linux-fsdevel+bounces-3149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FAF7F07C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7189B209E6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9962156C2;
	Sun, 19 Nov 2023 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D642D77;
	Sun, 19 Nov 2023 08:58:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C9E914BF;
	Sun, 19 Nov 2023 08:59:13 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6E3F3F6C4;
	Sun, 19 Nov 2023 08:58:21 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v2 09/27] mm: Allow an arch to hook into folio allocation when VMA is known
Date: Sun, 19 Nov 2023 16:57:03 +0000
Message-Id: <20231119165721.9849-10-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119165721.9849-1-alexandru.elisei@arm.com>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An architecture might want to fixup the gfp flags based on the type of VMA
where the page will be mapped.

On arm64, this is currently used if the VMA is MTE enabled. When
__GFP_TAGGED is set, for performance reasons, tag zeroing is performed at
the same time as the data is zeroed, instead of being performed separately,
in set_pte_at() -> mte_sync_tags().

Its usage will be expanded when the storage for the tags will have to be
explicitely managed by the kernel.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/page.h    |  5 ++---
 arch/arm64/include/asm/pgtable.h |  3 +++
 arch/arm64/mm/fault.c            | 19 ++++++-------------
 include/linux/pgtable.h          |  7 +++++++
 mm/mempolicy.c                   |  1 +
 mm/shmem.c                       |  5 ++++-
 6 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 2312e6ee595f..c8125a28eaa2 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -29,9 +29,8 @@ void copy_user_highpage(struct page *to, struct page *from,
 void copy_highpage(struct page *to, struct page *from);
 #define __HAVE_ARCH_COPY_HIGHPAGE
 
-struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
-						unsigned long vaddr);
-#define vma_alloc_zeroed_movable_folio vma_alloc_zeroed_movable_folio
+#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
+	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr, false);
 
 void tag_clear_highpage(struct page *to);
 #define __HAVE_ARCH_TAG_CLEAR_HIGHPAGE
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 9b32c74b4a1b..cd5dacd1be3a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1065,6 +1065,9 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 
 #endif /* CONFIG_ARM64_MTE */
 
+#define __HAVE_ARCH_CALC_VMA_GFP
+gfp_t arch_calc_vma_gfp(struct vm_area_struct *vma, gfp_t gfp);
+
 /*
  * On AArch64, the cache coherency is handled via the set_pte_at() function.
  */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index daa91608d917..acbc7530d2b2 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -935,22 +935,15 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
 NOKPROBE_SYMBOL(do_debug_exception);
 
 /*
- * Used during anonymous page fault handling.
+ * If this is called during anonymous page fault handling, and the page is
+ * mapped with PROT_MTE, initialise the tags at the point of tag zeroing as this
+ * is usually faster than separate DC ZVA and STGM.
  */
-struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
-						unsigned long vaddr)
+gfp_t arch_calc_vma_gfp(struct vm_area_struct *vma, gfp_t gfp)
 {
-	gfp_t flags = GFP_HIGHUSER_MOVABLE | __GFP_ZERO;
-
-	/*
-	 * If the page is mapped with PROT_MTE, initialise the tags at the
-	 * point of allocation and page zeroing as this is usually faster than
-	 * separate DC ZVA and STGM.
-	 */
 	if (vma->vm_flags & VM_MTE)
-		flags |= __GFP_TAGGED;
-
-	return vma_alloc_folio(flags, 0, vma, vaddr, false);
+		return __GFP_TAGGED;
+	return 0;
 }
 
 void tag_clear_highpage(struct page *page)
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index b7a9ab818f6d..b1001ce361ac 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -873,6 +873,13 @@ static inline void arch_do_swap_page(struct mm_struct *mm,
 }
 #endif
 
+#ifndef __HAVE_ARCH_CALC_VMA_GFP
+static inline gfp_t arch_calc_vma_gfp(struct vm_area_struct *vma, gfp_t gfp)
+{
+	return 0;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PREP_NEW_PAGE
 static inline int arch_prep_new_page(struct page *page, int order, gfp_t gfp)
 {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 50bc43ab50d6..cb170abae1fd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2170,6 +2170,7 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 	pgoff_t ilx;
 	struct page *page;
 
+	gfp |= arch_calc_vma_gfp(vma, gfp);
 	pol = get_vma_policy(vma, addr, order, &ilx);
 	page = alloc_pages_mpol(gfp | __GFP_COMP, order,
 				pol, ilx, numa_node_id());
diff --git a/mm/shmem.c b/mm/shmem.c
index 91e2620148b2..71ce5fe5c779 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1570,7 +1570,7 @@ static struct folio *shmem_swapin_cluster(swp_entry_t swap, gfp_t gfp,
  */
 static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 {
-	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
+	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM | __GFP_TAGGED;
 	gfp_t denyflags = __GFP_NOWARN | __GFP_NORETRY;
 	gfp_t zoneflags = limit_gfp & GFP_ZONEMASK;
 	gfp_t result = huge_gfp & ~(allowflags | GFP_ZONEMASK);
@@ -2023,6 +2023,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		gfp_t huge_gfp;
 
 		huge_gfp = vma_thp_gfp_mask(vma);
+		huge_gfp |= arch_calc_vma_gfp(vma, huge_gfp);
 		huge_gfp = limit_gfp_mask(huge_gfp, gfp);
 		folio = shmem_alloc_and_add_folio(huge_gfp,
 				inode, index, fault_mm, true);
@@ -2199,6 +2200,8 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	int err;
 
+	gfp |= arch_calc_vma_gfp(vmf->vma, gfp);
+
 	/*
 	 * Trinity finds that probing a hole which tmpfs is punching can
 	 * prevent the hole-punch from ever completing: noted in i_private.
-- 
2.42.1


