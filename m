Return-Path: <linux-fsdevel+bounces-8954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB82283C88C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DA01F22445
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B27813AA53;
	Thu, 25 Jan 2024 16:43:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDA13AA4E;
	Thu, 25 Jan 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201032; cv=none; b=VUIEqOyu3SKqamB3LnZajh4+qN8UgXunAHqcs+cqCPSNgst8Srz77Dmxp7NP2cBtOUJasI4HRNb2d2sQao0Qz9wnYDmvOHN7s+NVNMbj6CpmsWuL5Ji84xaJ2wYt06zssdZk+RMgzzI+OQE7D6gTmzafNz9CD7MKjktK4IZo84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201032; c=relaxed/simple;
	bh=bDQAYA9SBLymzsq/ERIJmns41Syf2su6NFF3KJNqooM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZrNHOPVhoNCzEdt7plonZOVuR1KMdSCgTbSd2w0AvHrbqUZZ3d2DqR6AeRIdSUatF+krypBRZIc1GDvrE4CmnZd2MkdQ4TMQQlBLxrbzS7TNhRanDuFoc+ktEofdUYOefAX5Z6o8UR6F0Xh1rxQ3WZXumnrBirLrbEUG4z7cvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 113601570;
	Thu, 25 Jan 2024 08:44:35 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240823F5A1;
	Thu, 25 Jan 2024 08:43:45 -0800 (PST)
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
Subject: [PATCH RFC v3 11/35] mm: Allow an arch to hook into folio allocation when VMA is known
Date: Thu, 25 Jan 2024 16:42:32 +0000
Message-Id: <20240125164256.4147-12-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm64 uses VM_HIGH_ARCH_0 and VM_HIGH_ARCH_1 for enabling MTE for a VMA.
When VM_HIGH_ARCH_0, which arm64 renames to VM_MTE, is set for a VMA, and
the gfp flag __GFP_ZERO is present, the __GFP_ZEROTAGS gfp flag also gets
set in vma_alloc_zeroed_movable_folio().

Expand this to be more generic by adding an arch hook that modifes the gfp
flags for an allocation when the VMA is known.

Note that __GFP_ZEROTAGS is ignored by the page allocator unless __GFP_ZERO
is also set; from that point of view, the current behaviour is unchanged,
even though the arm64 flag is set in more places.  When arm64 will have
support to reuse the tag storage for data allocation, the uses of the
__GFP_ZEROTAGS flag will be expanded to instruct the page allocator to try
to reserve the corresponding tag storage for the pages being allocated.

The flags returned by arch_calc_vma_gfp() are or'ed with the flags set by
the caller; this has been done to keep an architecture from modifying the
flags already set by the core memory management code; this is similar to
how do_mmap() -> calc_vm_flag_bits() -> arch_calc_vm_flag_bits() has been
implemented. This can be revisited in the future if there's a need to do
so.

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
index 2312e6ee595f..88bab032a493 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -29,9 +29,8 @@ void copy_user_highpage(struct page *to, struct page *from,
 void copy_highpage(struct page *to, struct page *from);
 #define __HAVE_ARCH_COPY_HIGHPAGE
 
-struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
-						unsigned long vaddr);
-#define vma_alloc_zeroed_movable_folio vma_alloc_zeroed_movable_folio
+#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
+	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr, false)
 
 void tag_clear_highpage(struct page *to);
 #define __HAVE_ARCH_TAG_CLEAR_HIGHPAGE
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 79ce70fbb751..08f0904dbfc2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1071,6 +1071,9 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 
 #endif /* CONFIG_ARM64_MTE */
 
+#define __HAVE_ARCH_CALC_VMA_GFP
+gfp_t arch_calc_vma_gfp(struct vm_area_struct *vma, gfp_t gfp);
+
 /*
  * On AArch64, the cache coherency is handled via the set_pte_at() function.
  */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 55f6455a8284..4d3f0a870ad8 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -937,22 +937,15 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
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
-		flags |= __GFP_ZEROTAGS;
-
-	return vma_alloc_folio(flags, 0, vma, vaddr, false);
+		return __GFP_ZEROTAGS;
+	return 0;
 }
 
 void tag_clear_highpage(struct page *page)
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c5ddec6b5305..98f81ca08cbe 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -901,6 +901,13 @@ static inline void arch_do_swap_page(struct mm_struct *mm,
 }
 #endif
 
+#ifndef __HAVE_ARCH_CALC_VMA_GFP
+static inline gfp_t arch_calc_vma_gfp(struct vm_area_struct *vma, gfp_t gfp)
+{
+	return 0;
+}
+#endif
+
 #ifndef __HAVE_ARCH_FREE_PAGES_PREPARE
 static inline void arch_free_pages_prepare(struct page *page, int order) { }
 #endif
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..f7ef52760b32 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2168,6 +2168,7 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 	pgoff_t ilx;
 	struct page *page;
 
+	gfp |= arch_calc_vma_gfp(vma, gfp);
 	pol = get_vma_policy(vma, addr, order, &ilx);
 	page = alloc_pages_mpol(gfp | __GFP_COMP, order,
 				pol, ilx, numa_node_id());
diff --git a/mm/shmem.c b/mm/shmem.c
index d7c84ff62186..14427e9982f9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1585,7 +1585,7 @@ static struct folio *shmem_swapin_cluster(swp_entry_t swap, gfp_t gfp,
  */
 static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 {
-	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
+	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM | __GFP_ZEROTAGS;
 	gfp_t denyflags = __GFP_NOWARN | __GFP_NORETRY;
 	gfp_t zoneflags = limit_gfp & GFP_ZONEMASK;
 	gfp_t result = huge_gfp & ~(allowflags | GFP_ZONEMASK);
@@ -2038,6 +2038,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		gfp_t huge_gfp;
 
 		huge_gfp = vma_thp_gfp_mask(vma);
+		huge_gfp |= arch_calc_vma_gfp(vma, huge_gfp);
 		huge_gfp = limit_gfp_mask(huge_gfp, gfp);
 		folio = shmem_alloc_and_add_folio(huge_gfp,
 				inode, index, fault_mm, true);
@@ -2214,6 +2215,8 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	int err;
 
+	gfp |= arch_calc_vma_gfp(vmf->vma, gfp);
+
 	/*
 	 * Trinity finds that probing a hole which tmpfs is punching can
 	 * prevent the hole-punch from ever completing: noted in i_private.
-- 
2.43.0


