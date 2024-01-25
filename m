Return-Path: <linux-fsdevel+bounces-8956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F9D83C893
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F67FB26815
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A86D13B797;
	Thu, 25 Jan 2024 16:44:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5BE133997;
	Thu, 25 Jan 2024 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201045; cv=none; b=ZTbxaRGvjYAL7kKTFTDcVEEy5u2N7cIU8tFQ8iMpo8JSUJL85Bl3s6wuXoiYflOaxY94GpBdUbqAH8frBec43zW26ZvLsogGMZw7irjYX2KRHaHMER0u/7v89W0yuBAPVBy90xdx0VEB7f1+TjPn8vOT/VszAZy4m0KqOss1UMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201045; c=relaxed/simple;
	bh=t0dAP6TAcUuIlGIYHAJGWd4RU2YFIjS4Zw/gn5LLLDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O09kN4xGy81kkOK4LJob7/T+9w2Bj7Nkas4y50PSEf8R3WSnuo1igy7r0tnQtc5OGvNftknLJP0ZIQIahlqKoBAXHHy02bj1BGGw42YCdufnwlQinc7N9pdcweKeatleBIrda8cpwZpOCtmI77Wj/t42+vXSF8veh3pb1LxmIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7E751596;
	Thu, 25 Jan 2024 08:44:46 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A76463F5A1;
	Thu, 25 Jan 2024 08:43:56 -0800 (PST)
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
Subject: [PATCH RFC v3 13/35] mm: memory: Introduce fault-on-access mechanism for pages
Date: Thu, 25 Jan 2024 16:42:34 +0000
Message-Id: <20240125164256.4147-14-alexandru.elisei@arm.com>
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

Introduce a mechanism that allows an architecture to trigger a page fault,
and add the infrastructure to handle that fault accordingly. To use make
use of this, an arch is expected to mark the table entry as PAGE_NONE (which
will cause a fault next time it is accessed) and to implement an
arch-specific method (like a software bit) for recognizing that the fault
needs to be handled by the arch code.

arm64 will use of this approach to reserve tag storage for pages which are
mapped in an MTE enabled VMA, but the storage needed to store tags isn't
reserved (for example, because of an mprotect(PROT_MTE) call on a VMA with
existing pages).

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* New patch. Split from patch #19 ("mm: mprotect: Introduce PAGE_FAULT_ON_ACCESS
for mprotect(PROT_MTE)") (David Hildenbrand).

 include/linux/huge_mm.h |  4 ++--
 include/linux/pgtable.h | 47 +++++++++++++++++++++++++++++++++++--
 mm/Kconfig              |  3 +++
 mm/huge_memory.c        | 36 +++++++++++++++++++++--------
 mm/memory.c             | 51 ++++++++++++++++++++++++++---------------
 5 files changed, 109 insertions(+), 32 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5adb86af35fc..4678a0a5e6a8 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -346,7 +346,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 		pud_t *pud, int flags, struct dev_pagemap **pgmap);
 
-vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
+vm_fault_t handle_huge_pmd_protnone(struct vm_fault *vmf);
 
 extern struct page *huge_zero_page;
 extern unsigned long huge_zero_pfn;
@@ -476,7 +476,7 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 	return NULL;
 }
 
-static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
+static inline vm_fault_t handle_huge_pmd_protnone(struct vm_fault *vmf)
 {
 	return 0;
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2d0f04042f62..81a21be855a2 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1455,7 +1455,7 @@ static inline int pud_trans_unstable(pud_t *pud)
 	return 0;
 }
 
-#ifndef CONFIG_NUMA_BALANCING
+#if !defined(CONFIG_NUMA_BALANCING) && !defined(CONFIG_ARCH_HAS_FAULT_ON_ACCESS)
 /*
  * In an inaccessible (PROT_NONE) VMA, pte_protnone() may indicate "yes". It is
  * perfectly valid to indicate "no" in that case, which is why our default
@@ -1477,7 +1477,50 @@ static inline int pmd_protnone(pmd_t pmd)
 {
 	return 0;
 }
-#endif /* CONFIG_NUMA_BALANCING */
+#endif /* !CONFIG_NUMA_BALANCING && !CONFIG_ARCH_HAS_FAULT_ON_ACCESS */
+
+#ifndef CONFIG_ARCH_HAS_FAULT_ON_ACCESS
+static inline bool arch_fault_on_access_pte(pte_t pte)
+{
+	return false;
+}
+
+static inline bool arch_fault_on_access_pmd(pmd_t pmd)
+{
+	return false;
+}
+
+/*
+ * The function is called with the fault lock held and an elevated reference on
+ * the folio.
+ *
+ * Rules that an arch implementation of the function must follow:
+ *
+ * 1. The function must return with the elevated reference dropped.
+ *
+ * 2. If the return value contains VM_FAULT_RETRY or VM_FAULT_COMPLETED then:
+ *
+ * - if FAULT_FLAG_RETRY_NOWAIT is not set, the function must return with the
+ *   correct fault lock released, which can be accomplished with
+ *   release_fault_lock(vmf). Note that release_fault_lock() doesn't check if
+ *   FAULT_FLAG_RETRY_NOWAIT is set before releasing the mmap_lock.
+ *
+ * - if FAULT_FLAG_RETRY_NOWAIT is set, then the function must not release the
+ *   mmap_lock. The flag should be set only if the mmap_lock is held.
+ *
+ * 3. If the return value contains neither of the above, the function must not
+ * release the fault lock; the generic fault handler will take care of releasing
+ * the correct lock.
+ */
+static inline vm_fault_t arch_handle_folio_fault_on_access(struct folio *folio,
+							   struct vm_fault *vmf,
+							   bool *map_pte)
+{
+	*map_pte = false;
+
+	return VM_FAULT_SIGBUS;
+}
+#endif
 
 #endif /* CONFIG_MMU */
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 341cf53898db..153df67221f1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1006,6 +1006,9 @@ config IDLE_PAGE_TRACKING
 config ARCH_HAS_CACHE_LINE_SIZE
 	bool
 
+config ARCH_HAS_FAULT_ON_ACCESS
+	bool
+
 config ARCH_HAS_CURRENT_STACK_POINTER
 	bool
 	help
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94ef5c02b459..2bad63a7ec16 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1698,7 +1698,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 }
 
 /* NUMA hinting page fault entry point for trans huge pmds */
-vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
+vm_fault_t handle_huge_pmd_protnone(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	pmd_t oldpmd = vmf->orig_pmd;
@@ -1708,6 +1708,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	int nid = NUMA_NO_NODE;
 	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
 	bool migrated = false, writable = false;
+	vm_fault_t ret;
 	int flags = 0;
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
@@ -1731,6 +1732,20 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	if (!folio)
 		goto out_map;
 
+	folio_get(folio);
+	vma_set_access_pid_bit(vma);
+
+	if (arch_fault_on_access_pmd(oldpmd)) {
+		bool map_pte = false;
+
+		spin_unlock(vmf->ptl);
+		ret = arch_handle_folio_fault_on_access(folio, vmf, &map_pte);
+		if (ret || !map_pte)
+			return ret;
+		writable = false;
+		goto out_lock_and_map;
+	}
+
 	/* See similar comment in do_numa_page for explanation */
 	if (!writable)
 		flags |= TNF_NO_GROUP;
@@ -1755,15 +1770,18 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	if (migrated) {
 		flags |= TNF_MIGRATED;
 		nid = target_nid;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
-			spin_unlock(vmf->ptl);
-			goto out;
-		}
-		goto out_map;
+		goto out;
+	}
+
+	flags |= TNF_MIGRATE_FAIL;
+
+out_lock_and_map:
+	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+		spin_unlock(vmf->ptl);
+		goto out;
 	}
+	goto out_map;
 
 out:
 	if (nid != NUMA_NO_NODE)
diff --git a/mm/memory.c b/mm/memory.c
index 8a421e168b57..110fe2224277 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4886,11 +4886,6 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags)
 {
-	folio_get(folio);
-
-	/* Record the current PID acceesing VMA */
-	vma_set_access_pid_bit(vma);
-
 	count_vm_numa_event(NUMA_HINT_FAULTS);
 	if (page_nid == numa_node_id()) {
 		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
@@ -4900,13 +4895,14 @@ int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
 	return mpol_misplaced(folio, vma, addr);
 }
 
-static vm_fault_t do_numa_page(struct vm_fault *vmf)
+static vm_fault_t handle_pte_protnone(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio = NULL;
 	int nid = NUMA_NO_NODE;
 	bool writable = false;
 	int last_cpupid;
+	vm_fault_t ret;
 	int target_nid;
 	pte_t pte, old_pte;
 	int flags = 0;
@@ -4939,6 +4935,20 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 
+	folio_get(folio);
+	/* Record the current PID acceesing VMA */
+	vma_set_access_pid_bit(vma);
+
+	if (arch_fault_on_access_pte(old_pte)) {
+		bool map_pte = false;
+
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		ret = arch_handle_folio_fault_on_access(folio, vmf, &map_pte);
+		if (ret || !map_pte)
+			return ret;
+		goto out_lock_and_map;
+	}
+
 	/* TODO: handle PTE-mapped THP */
 	if (folio_test_large(folio))
 		goto out_map;
@@ -4983,18 +4993,21 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (migrate_misplaced_folio(folio, vma, target_nid)) {
 		nid = target_nid;
 		flags |= TNF_MIGRATED;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					       vmf->address, &vmf->ptl);
-		if (unlikely(!vmf->pte))
-			goto out;
-		if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			goto out;
-		}
-		goto out_map;
+		goto out;
+	}
+
+	flags |= TNF_MIGRATE_FAIL;
+
+out_lock_and_map:
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+	if (unlikely(!vmf->pte))
+		goto out;
+	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		goto out;
 	}
+	goto out_map;
 
 out:
 	if (nid != NUMA_NO_NODE)
@@ -5151,7 +5164,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		return do_swap_page(vmf);
 
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
-		return do_numa_page(vmf);
+		return handle_pte_protnone(vmf);
 
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
@@ -5272,7 +5285,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		}
 		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
 			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
-				return do_huge_pmd_numa_page(&vmf);
+				return handle_huge_pmd_protnone(&vmf);
 
 			if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
 			    !pmd_write(vmf.orig_pmd)) {
-- 
2.43.0


