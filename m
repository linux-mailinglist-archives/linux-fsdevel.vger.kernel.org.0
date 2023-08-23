Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738CF7858EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjHWNSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjHWNSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:18:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17F1EE7A;
        Wed, 23 Aug 2023 06:17:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B515415DB;
        Wed, 23 Aug 2023 06:18:03 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 376473F740;
        Wed, 23 Aug 2023 06:17:17 -0700 (PDT)
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
Subject: [PATCH RFC 30/37] mm: mprotect: arm64: Set PAGE_METADATA_NONE for mprotect(PROT_MTE)
Date:   Wed, 23 Aug 2023 14:13:43 +0100
Message-Id: <20230823131350.114942-31-alexandru.elisei@arm.com>
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

To enable tagging on a memory range, userspace can use mprotect() with the
PROT_MTE access flag. Pages already mapped in the VMA obviously don't have
the associated tag storage block reserved, so mark the PTEs as
PAGE_METADATA_NONE to trigger a fault next time they are accessed, and
reserve the tag storage as part of the fault handling. If the tag storage
for the page cannot be reserved, then migrate the page, because
alloc_migration_target() will do the right thing and allocate a destination
page with the tag storage reserved.

If the mapped page is a metadata storage page, which cannot have metadata
associated with it, the page is unconditionally migrated.

This has several benefits over reserving the tag storage as part of the
mprotect() call handling:

- Tag storage is reserved only for pages that are accessed.
- Reduces the latency of the mprotect() call.
- Eliminates races with page migration.

But all of this is at the expense of an extra page fault until the pages
being accessed all have their corresponding tag storage reserved.

This is only implemented for PTE mappings; PMD mappings will follow.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/mte_tag_storage.c |   6 ++
 include/linux/migrate_mode.h        |   1 +
 include/linux/mm.h                  |   2 +
 mm/memory.c                         | 152 +++++++++++++++++++++++++++-
 mm/mprotect.c                       |  46 +++++++++
 5 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index ba316ffb9aef..27bde1d2609c 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -531,6 +531,10 @@ int reserve_metadata_storage(struct page *page, int order, gfp_t gfp)
 
 	mutex_lock(&tag_blocks_lock);
 
+	/* Can happen for concurrent accesses to a METADATA_NONE page. */
+	if (page_tag_storage_reserved(page))
+		goto out_unlock;
+
 	/* Make sure existing entries are not freed from out under out feet. */
 	xa_lock_irqsave(&tag_blocks_reserved, flags);
 	for (block = start_block; block < end_block; block += region->block_size) {
@@ -568,6 +572,8 @@ int reserve_metadata_storage(struct page *page, int order, gfp_t gfp)
 		set_bit(PG_tag_storage_reserved, &(page + i)->flags);
 
 	memalloc_isolate_restore(cflags);
+
+out_unlock:
 	mutex_unlock(&tag_blocks_lock);
 
 	return 0;
diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index f37cc03f9369..5a9af239e425 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -29,6 +29,7 @@ enum migrate_reason {
 	MR_CONTIG_RANGE,
 	MR_LONGTERM_PIN,
 	MR_DEMOTION,
+	MR_METADATA_NONE,
 	MR_TYPES
 };
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ce87d55ecf87..6bd7d5810122 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2466,6 +2466,8 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
+/* Whether this protection change is to allocate metadata on next access */
+#define MM_CP_PROT_METADATA_NONE	   (1UL << 4)
 
 bool vma_needs_dirty_tracking(struct vm_area_struct *vma);
 int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
diff --git a/mm/memory.c b/mm/memory.c
index 01f39e8144ef..6c4a6151c7b2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -51,6 +51,7 @@
 #include <linux/swap.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/page-isolation.h>
 #include <linux/memremap.h>
 #include <linux/kmsan.h>
 #include <linux/ksm.h>
@@ -82,6 +83,7 @@
 #include <trace/events/kmem.h>
 
 #include <asm/io.h>
+#include <asm/memory_metadata.h>
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -4681,6 +4683,151 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	return ret;
 }
 
+/* Returns with the page reference dropped. */
+static void migrate_metadata_none_page(struct page *page, struct vm_area_struct *vma)
+{
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_TAGGED,
+	};
+	LIST_HEAD(pagelist);
+	int ret, tries;
+
+	lru_cache_disable();
+
+	if (!isolate_lru_page(page)) {
+		put_page(page);
+		lru_cache_enable();
+		return;
+	}
+	/* Isolate just grabbed another reference, drop ours. */
+	put_page(page);
+
+	list_add_tail(&page->lru, &pagelist);
+
+	tries = 5;
+	while (tries--) {
+		ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
+				    (unsigned long)&mtc, MIGRATE_SYNC, MR_METADATA_NONE, NULL);
+		if (ret == 0 || ret != -EBUSY)
+			break;
+	}
+
+	if (ret != 0) {
+		list_del(&page->lru);
+		putback_movable_pages(&pagelist);
+	}
+	lru_cache_enable();
+}
+
+static vm_fault_t do_metadata_none_page(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct page *page = NULL;
+	bool do_migrate = false;
+	pte_t new_pte, old_pte;
+	bool writable = false;
+	vm_fault_t err;
+	int ret;
+
+	/*
+	 * The pte at this point cannot be used safely without validation
+	 * through pte_same().
+	 */
+	vmf->ptl = pte_lockptr(vma->vm_mm, vmf->pmd);
+	spin_lock(vmf->ptl);
+	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
+	}
+
+	/* Get the normal PTE  */
+	old_pte = ptep_get(vmf->pte);
+	new_pte = pte_modify(old_pte, vma->vm_page_prot);
+
+	/*
+	 * Detect now whether the PTE could be writable; this information
+	 * is only valid while holding the PT lock.
+	 */
+	writable = pte_write(new_pte);
+	if (!writable && vma_wants_manual_pte_write_upgrade(vma) &&
+	    can_change_pte_writable(vma, vmf->address, new_pte))
+		writable = true;
+
+	page = vm_normal_page(vma, vmf->address, new_pte);
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
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+
+	/*
+	 * Probably the page is being isolated for migration, replay the fault
+	 * to give time for the entry to be replaced by a migration pte.
+	 */
+	if (unlikely(is_migrate_isolate_page(page))) {
+		if (!(vmf->flags & FAULT_FLAG_TRIED))
+			err = VM_FAULT_RETRY;
+		else
+			err = 0;
+		put_page(page);
+		return 0;
+	} else if (is_migrate_metadata_page(page)) {
+		do_migrate = true;
+	} else {
+		ret = reserve_metadata_storage(page, 0, GFP_HIGHUSER_MOVABLE);
+		if (ret == -EINTR) {
+			put_page(page);
+			return VM_FAULT_RETRY;
+		} else if (ret) {
+			do_migrate = true;
+		}
+	}
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
+	spin_lock(vmf->ptl);
+	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
+	}
+
+out_map:
+	/*
+	 * Make it present again, depending on how arch implements
+	 * non-accessible ptes, some can allow access by kernel mode.
+	 */
+	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
+	new_pte = pte_modify(old_pte, vma->vm_page_prot);
+	new_pte = pte_mkyoung(new_pte);
+	if (writable)
+		new_pte = pte_mkwrite(new_pte);
+	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, new_pte);
+	update_mmu_cache(vma, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+
+	return 0;
+}
+
 int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags)
 {
@@ -4941,8 +5088,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
-	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
+	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma)) {
+		if (metadata_storage_enabled() && pte_metadata_none(vmf->orig_pte))
+			return do_metadata_none_page(vmf);
 		return do_numa_page(vmf);
+	}
 
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6f658d483704..2c022133aed3 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -33,6 +33,7 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/memory-tiers.h>
 #include <asm/cacheflush.h>
+#include <asm/memory_metadata.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
@@ -89,6 +90,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 	long pages = 0;
 	int target_node = NUMA_NO_NODE;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
+	bool prot_metadata_none = cp_flags & MM_CP_PROT_METADATA_NONE;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
@@ -161,6 +163,40 @@ static long change_pte_range(struct mmu_gather *tlb,
 						jiffies_to_msecs(jiffies));
 			}
 
+			if (prot_metadata_none) {
+				struct page *page;
+
+				/*
+				 * Skip METADATA_NONE pages, but not NUMA pages,
+				 * just so we don't get two faults, one after
+				 * the other. The page fault handling code
+				 * might end up migrating the current page
+				 * anyway, so there really is no need to keep
+				 * the pte marked for NUMA balancing.
+				 */
+				if (pte_protnone(oldpte) && pte_metadata_none(oldpte))
+					continue;
+
+				page = vm_normal_page(vma, addr, oldpte);
+				if (!page || is_zone_device_page(page))
+					continue;
+
+				/* Page already mapped as tagged in a shared VMA. */
+				if (page_has_metadata(page))
+					continue;
+
+				/*
+				 * The LRU takes a page reference, which means
+				 * that page_count > 1 is true even if the page
+				 * is not COW. Reserving tag storage for a COW
+				 * page is ok, because one mapping of that page
+				 * won't be migrated; but not reserving tag
+				 * storage for a page is definitely wrong. So
+				 * don't skip pages that might be COW, like
+				 * NUMA does.
+				 */
+			}
+
 			oldpte = ptep_modify_prot_start(vma, addr, pte);
 			ptent = pte_modify(oldpte, newprot);
 
@@ -531,6 +567,13 @@ long change_protection(struct mmu_gather *tlb,
 	WARN_ON_ONCE(cp_flags & MM_CP_PROT_NUMA);
 #endif
 
+#ifdef CONFIG_MEMORY_METADATA
+	if (cp_flags & MM_CP_PROT_METADATA_NONE)
+		newprot = PAGE_METADATA_NONE;
+#else
+	WARN_ON_ONCE(cp_flags & MM_CP_PROT_METADATA_NONE);
+#endif
+
 	if (is_vm_hugetlb_page(vma))
 		pages = hugetlb_change_protection(vma, start, end, newprot,
 						  cp_flags);
@@ -661,6 +704,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
 	vma_set_page_prot(vma);
 
+	if (metadata_storage_enabled() && (newflags & VM_MTE) && !(oldflags & VM_MTE))
+		mm_cp_flags |= MM_CP_PROT_METADATA_NONE;
+
 	change_protection(tlb, vma, start, end, mm_cp_flags);
 
 	/*
-- 
2.41.0

