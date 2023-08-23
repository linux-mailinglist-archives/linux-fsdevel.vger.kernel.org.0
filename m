Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA36785927
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbjHWN1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjHWN1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:27:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93E37CEA;
        Wed, 23 Aug 2023 06:26:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A5CF1758;
        Wed, 23 Aug 2023 06:18:36 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29A2D3F740;
        Wed, 23 Aug 2023 06:17:50 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com
Cc:     pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
        kcc@google.com, hyesoo.yu@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC 35/37] mm: hugepage: Handle PAGE_METADATA_NONE faults for huge pages
Date:   Wed, 23 Aug 2023 14:13:48 +0100
Message-Id: <20230823131350.114942-36-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823131350.114942-1-alexandru.elisei@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle accesses to huge pages mapped with PAGE_METADATA_NONE in a
similar way to how accesses to PTEs are handled.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/asm-generic/memory_metadata.h |   2 +
 include/linux/huge_mm.h               |   6 ++
 mm/huge_memory.c                      | 108 ++++++++++++++++++++++++++
 mm/memory.c                           |   7 +-
 4 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/memory_metadata.h b/include/asm-generic/memory_metadata.h
index 4176fd89ef41..dfdf2dd82ea6 100644
--- a/include/asm-generic/memory_metadata.h
+++ b/include/asm-generic/memory_metadata.h
@@ -7,6 +7,8 @@
 
 extern unsigned long totalmetadata_pages;
 
+void migrate_metadata_none_page(struct page *page, struct vm_area_struct *vma);
+
 #ifndef CONFIG_MEMORY_METADATA
 static inline bool metadata_storage_enabled(void)
 {
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 20284387b841..6920571b5b6d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -229,6 +229,7 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 		pud_t *pud, int flags, struct dev_pagemap **pgmap);
 
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
+vm_fault_t do_huge_pmd_metadata_none_page(struct vm_fault *vmf);
 
 extern struct page *huge_zero_page;
 extern unsigned long huge_zero_pfn;
@@ -356,6 +357,11 @@ static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	return 0;
 }
 
+static inline vm_fault_t do_huge_pmd_metadata_none_page(struct vm_fault *vmf)
+{
+	return 0;
+}
+
 static inline bool is_huge_zero_page(struct page *page)
 {
 	return false;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cf5247b012de..06038424c3a7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -26,6 +26,7 @@
 #include <linux/mman.h>
 #include <linux/memremap.h>
 #include <linux/pagemap.h>
+#include <linux/page-isolation.h>
 #include <linux/debugfs.h>
 #include <linux/migrate.h>
 #include <linux/hashtable.h>
@@ -38,6 +39,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 
+#include <asm/memory_metadata.h>
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
 #include "internal.h"
@@ -1490,6 +1492,112 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	return page;
 }
 
+vm_fault_t do_huge_pmd_metadata_none_page(struct vm_fault *vmf)
+{
+	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	struct vm_area_struct *vma = vmf->vma;
+	pmd_t old_pmd = vmf->orig_pmd;
+	struct page *page = NULL;
+	bool do_migrate = false;
+	bool writable = false;
+	vm_fault_t err;
+	pmd_t new_pmd;
+	int ret;
+
+	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
+	spin_lock(vmf->ptl);
+	if (unlikely(!pmd_same(*vmf->pmd, old_pmd))) {
+		spin_unlock(vmf->ptl);
+		return 0;
+	}
+
+	new_pmd = pmd_modify(old_pmd, vma->vm_page_prot);
+
+	/*
+	 * Detect now whether the PMD could be writable; this information
+	 * is only valid while holding the PT lock.
+	 */
+	writable = pmd_write(new_pmd);
+	if (!writable && vma_wants_manual_pte_write_upgrade(vma) &&
+	    can_change_pmd_writable(vma, vmf->address, new_pmd))
+		writable = true;
+
+	page = vm_normal_page_pmd(vma, vmf->address, new_pmd);
+	if (!page)
+		goto out_map;
+
+	/*
+	 * This should never happen, once a VMA has been marked as tagged, that
+	 * cannot be changed.
+	 */
+	if (!(vma->vm_flags & VM_MTE))
+		goto out_map;
+
+	/* Prevent the page from being unmapped from under us. */
+	get_page(page);
+	vma_set_access_pid_bit(vma);
+
+	spin_unlock(vmf->ptl);
+	writable = false;
+
+	if (unlikely(is_migrate_isolate_page(page))) {
+		if (!(vmf->flags & FAULT_FLAG_TRIED))
+			err = VM_FAULT_RETRY;
+		else
+			err = 0;
+		put_page(page);
+	} else if (is_migrate_metadata_page(page)) {
+		do_migrate = true;
+	} else {
+		ret = reserve_metadata_storage(page, HPAGE_PMD_ORDER, GFP_HIGHUSER_MOVABLE);
+		if (ret == -EINTR) {
+			put_page(page);
+			return VM_FAULT_RETRY;
+		} else if (ret) {
+			if (unlikely(page_metadata_in_swap(page))) {
+				if (vmf->flags & FAULT_FLAG_TRIED)
+					err = VM_FAULT_OOM;
+				else
+					err = VM_FAULT_RETRY;
+
+				put_page(page);
+				return err;
+			}
+			do_migrate = true;
+		}
+	}
+
+	if (do_migrate) {
+		migrate_metadata_none_page(page, vma);
+		/*
+		 * Either the page was migrated, in which case there's nothing
+		 * we need to do; either migration failed, in which case all we
+		 * can do is try again. So don't change the pte.
+		 */
+		return 0;
+	}
+
+	put_page(page);
+
+	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	if (unlikely(!pmd_same(*vmf->pmd, old_pmd))) {
+		spin_unlock(vmf->ptl);
+		return 0;
+	}
+
+out_map:
+	new_pmd = pmd_modify(old_pmd, vma->vm_page_prot);
+	new_pmd = pmd_mkyoung(new_pmd);
+	if (writable)
+		new_pmd = pmd_mkwrite(new_pmd);
+	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, new_pmd);
+	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
+	spin_unlock(vmf->ptl);
+
+	return 0;
+}
+
+
 /* NUMA hinting page fault entry point for trans huge pmds */
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
diff --git a/mm/memory.c b/mm/memory.c
index ade71f38b2ff..6d78d33ef91f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4695,7 +4695,7 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 }
 
 /* Returns with the page reference dropped. */
-static void migrate_metadata_none_page(struct page *page, struct vm_area_struct *vma)
+void migrate_metadata_none_page(struct page *page, struct vm_area_struct *vma)
 {
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
@@ -5234,8 +5234,11 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 			return 0;
 		}
 		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
-			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
+			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma)) {
+				if (metadata_storage_enabled() && pmd_metadata_none(vmf.orig_pmd))
+					return do_huge_pmd_metadata_none_page(&vmf);
 				return do_huge_pmd_numa_page(&vmf);
+			}
 
 			if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
 			    !pmd_write(vmf.orig_pmd)) {
-- 
2.41.0

