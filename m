Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51E37858FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjHWNS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbjHWNSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:18:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 660181708;
        Wed, 23 Aug 2023 06:17:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FA3A1713;
        Wed, 23 Aug 2023 06:18:24 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E4203F740;
        Wed, 23 Aug 2023 06:17:37 -0700 (PDT)
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
Subject: [PATCH RFC 33/37] arm64: mte: swap/copypage: Handle tag restoring when missing tag storage
Date:   Wed, 23 Aug 2023 14:13:46 +0100
Message-Id: <20230823131350.114942-34-alexandru.elisei@arm.com>
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

Linux restores tags when a page is swapped in and there are tags saved for
the swap entry which the new page will replace. The tags are restored even
if the page will not be mapped as tagged. This is done so when a shared
page is swapped in as untagged, followed by mprotect(PROT_MTE), the process
can still access the correct tags.

But this poses a challenge for tag storage: when a page is swapped in for
the process where it is untagged, the corresponding tag storage block is
not reserved, and restoring the tags can overwrite data in the tag storage
block, leading to data corruption.

Get around this issue by saving the tags in a new xarray, this time indexed
by the page pfn, and then restoring them in set_pte_at().

Something similar can happen when a page is migrated: the migration process
starts and the destination page is allocated when the VMA does not have MTE
enabled (so tag storage is not reserved as part of the allocation),
mprotect(PROT_MTE) is called before migration finishes and the source page
is accessed (thus marking it as tagged). When folio_copy() is called, the
code will try to copy the tags to the destination page, which doesn't have
tag storage reserved. Fix this in a similar way to tag restoring when doing
swap in, by saving the tags of the source page in a buffer, then restoring
them in set_pte_at().

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/memory_metadata.h |  1 +
 arch/arm64/include/asm/mte_tag_storage.h | 11 +++++
 arch/arm64/include/asm/pgtable.h         |  7 +++
 arch/arm64/kernel/mte.c                  | 17 +++++++
 arch/arm64/kernel/mte_tag_storage.c      |  9 +++-
 arch/arm64/mm/copypage.c                 | 26 ++++++++++
 arch/arm64/mm/mteswap.c                  | 63 ++++++++++++++++++++++++
 include/asm-generic/memory_metadata.h    |  4 ++
 mm/memory.c                              | 12 +++++
 9 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory_metadata.h b/arch/arm64/include/asm/memory_metadata.h
index 167b039f06cf..25b4d790e92b 100644
--- a/arch/arm64/include/asm/memory_metadata.h
+++ b/arch/arm64/include/asm/memory_metadata.h
@@ -43,6 +43,7 @@ static inline bool vma_has_metadata(struct vm_area_struct *vma)
 
 int reserve_metadata_storage(struct page *page, int order, gfp_t gfp_mask);
 void free_metadata_storage(struct page *page, int order);
+bool page_metadata_in_swap(struct page *page);
 #endif /* CONFIG_MEMORY_METADATA */
 
 #endif /* __ASM_MEMORY_METADATA_H  */
diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
index bad865866eeb..cafbb618d97a 100644
--- a/arch/arm64/include/asm/mte_tag_storage.h
+++ b/arch/arm64/include/asm/mte_tag_storage.h
@@ -12,6 +12,9 @@ extern void dcache_inval_tags_poc(unsigned long start, unsigned long end);
 #ifdef CONFIG_ARM64_MTE_TAG_STORAGE
 void mte_tag_storage_init(void);
 bool page_tag_storage_reserved(struct page *page);
+
+void *mte_erase_page_tags_by_pfn(struct page *page);
+int mte_save_page_tags_by_pfn(struct page *page, void *tags);
 #else
 static inline void mte_tag_storage_init(void)
 {
@@ -20,6 +23,14 @@ static inline bool page_tag_storage_reserved(struct page *page)
 {
 	return true;
 }
+static inline void *mte_erase_page_tags_by_pfn(struct page *page)
+{
+	return NULL;
+}
+static inline int mte_save_page_tags_by_pfn(struct page *page, void *tags)
+{
+	return 0;
+}
 #endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
 
 #endif /* __ASM_MTE_TAG_STORAGE_H  */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e5e1c23afb14..a1e93d3228fa 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1056,6 +1056,13 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 		mte_restore_page_tags_by_swp_entry(entry, &folio->page);
 }
 
+#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
+
+#define __HAVE_ARCH_SWAP_PREPARE_TO_RESTORE
+int arch_swap_prepare_to_restore(swp_entry_t entry, struct folio *folio);
+
+#endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
+
 #endif /* CONFIG_ARM64_MTE */
 
 /*
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 4556989f0b9e..5139ce6952ff 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -37,6 +37,20 @@ DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
 EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
 #endif
 
+static bool mte_restore_saved_tags(struct page *page)
+{
+	void *tags = mte_erase_page_tags_by_pfn(page);
+
+	if (likely(!tags))
+		return false;
+
+	mte_restore_page_tags_from_mem(page_address(page), tags);
+	mte_free_tags_mem(tags);
+	set_page_mte_tagged(page);
+
+	return true;
+}
+
 void mte_sync_tags(pte_t *pteval)
 {
 	struct page *page = pte_page(*pteval);
@@ -51,6 +65,9 @@ void mte_sync_tags(pte_t *pteval)
 
 		/* if PG_mte_tagged is set, tags have already been initialised */
 		if (try_page_mte_tagging(page)) {
+			if (metadata_storage_enabled() &&
+			    unlikely(mte_restore_saved_tags(page)))
+				continue;
 			mte_clear_page_tags(page_address(page));
 			set_page_mte_tagged(page);
 		}
diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 27bde1d2609c..ce378f45f866 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -603,7 +603,8 @@ void free_metadata_storage(struct page *page, int order)
 	struct tag_region *region;
 	unsigned long page_va;
 	unsigned long flags;
-	int ret;
+	void *tags;
+	int i, ret;
 
 	if (WARN_ONCE(!page_mte_tagged(page), "pfn 0x%lx is not tagged", page_to_pfn(page)))
 		return;
@@ -619,6 +620,12 @@ void free_metadata_storage(struct page *page, int order)
 	 */
 	dcache_inval_tags_poc(page_va, page_va + (PAGE_SIZE << order));
 
+	for (i = 0; i < (1 << order); i++) {
+		tags = mte_erase_page_tags_by_pfn(page + i);
+		if (unlikely(tags))
+			mte_free_tags_mem(tags);
+	}
+
 	end_block = start_block + order_to_num_blocks(order) * region->block_size;
 
 	xa_lock_irqsave(&tag_blocks_reserved, flags);
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index a7bb20055ce0..e4ac3806b994 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -12,7 +12,29 @@
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
+#include <asm/memory_metadata.h>
 #include <asm/mte.h>
+#include <asm/mte_tag_storage.h>
+
+static bool copy_page_tags_to_page(struct page *to, struct page *from)
+{
+	void *kfrom = page_address(from);
+	void *tags;
+
+	if (likely(page_tag_storage_reserved(to)))
+		return false;
+
+	tags = mte_allocate_tags_mem();
+	if (WARN_ON(!tags))
+		goto out;
+
+	mte_save_page_tags_to_mem(kfrom, tags);
+
+	if (WARN_ON(mte_save_page_tags_by_pfn(to, tags)))
+		mte_free_tags_mem(tags);
+out:
+	return true;
+}
 
 void copy_highpage(struct page *to, struct page *from)
 {
@@ -25,6 +47,10 @@ void copy_highpage(struct page *to, struct page *from)
 		page_kasan_tag_reset(to);
 
 	if (system_supports_mte() && page_mte_tagged(from)) {
+		if (metadata_storage_enabled() &&
+		    unlikely(copy_page_tags_to_page(to, from)))
+			return;
+
 		/* It's a new page, shouldn't have been tagged yet */
 		WARN_ON_ONCE(!try_page_mte_tagging(to));
 		mte_copy_page_tags(kto, kfrom);
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index aaeca57f36cc..f6a9b6f889e6 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -5,7 +5,9 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <asm/memory_metadata.h>
 #include <asm/mte.h>
+#include <asm/mte_tag_storage.h>
 
 static DEFINE_XARRAY(tags_by_swp_entry);
 
@@ -20,6 +22,62 @@ void mte_free_tags_mem(void *tags)
 	kfree(tags);
 }
 
+#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
+static DEFINE_XARRAY(tags_by_pfn);
+
+int mte_save_page_tags_by_pfn(struct page *page, void *tags)
+{
+	void *entry;
+
+	entry = xa_store(&tags_by_pfn, page_to_pfn(page), tags, GFP_KERNEL);
+	if (xa_is_err(entry))
+		return xa_err(entry);
+	else if (entry)
+		mte_free_tags_mem(entry);
+
+	return 0;
+}
+
+int arch_swap_prepare_to_restore(swp_entry_t entry, struct folio *folio)
+{
+	struct page *page = &folio->page;
+	void *swp_tags, *pfn_tags;
+	int ret;
+
+	might_sleep();
+
+	if (!metadata_storage_enabled() || page_mte_tagged(page) ||
+	    page_tag_storage_reserved(page))
+		return 0;
+
+	swp_tags = xa_load(&tags_by_swp_entry, entry.val);
+	if (!swp_tags)
+		return 0;
+
+	pfn_tags = mte_allocate_tags_mem();
+	if (!pfn_tags)
+		return -ENOMEM;
+
+	memcpy(pfn_tags, swp_tags, MTE_PAGE_TAG_STORAGE_SIZE);
+
+	ret = mte_save_page_tags_by_pfn(page, pfn_tags);
+	if (ret)
+		mte_free_tags_mem(pfn_tags);
+
+	return ret;
+}
+
+void *mte_erase_page_tags_by_pfn(struct page *page)
+{
+	return xa_erase(&tags_by_pfn, page_to_pfn(page));
+}
+
+bool page_metadata_in_swap(struct page *page)
+{
+	return xa_load(&tags_by_pfn, page_to_pfn(page)) != NULL;
+}
+#endif
+
 int mte_save_page_tags_by_swp_entry(struct page *page)
 {
 	void *tags, *ret;
@@ -53,6 +111,11 @@ void mte_restore_page_tags_by_swp_entry(swp_entry_t entry, struct page *page)
 	if (!tags)
 		return;
 
+	/* Tags already saved in mte_swap_prepare_to_restore(). */
+	if (metadata_storage_enabled() &&
+	    unlikely(!page_tag_storage_reserved(page)))
+		return;
+
 	if (try_page_mte_tagging(page)) {
 		mte_restore_page_tags_from_mem(page_address(page), tags);
 		set_page_mte_tagged(page);
diff --git a/include/asm-generic/memory_metadata.h b/include/asm-generic/memory_metadata.h
index 35a0d6a8b5fc..4176fd89ef41 100644
--- a/include/asm-generic/memory_metadata.h
+++ b/include/asm-generic/memory_metadata.h
@@ -39,6 +39,10 @@ static inline bool vma_has_metadata(struct vm_area_struct *vma)
 {
 	return false;
 }
+static inline bool page_metadata_in_swap(struct page *page)
+{
+	return false;
+}
 #endif /* !CONFIG_MEMORY_METADATA */
 
 #endif /* __ASM_GENERIC_MEMORY_METADATA_H */
diff --git a/mm/memory.c b/mm/memory.c
index 5f7587109ac2..ade71f38b2ff 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4801,6 +4801,18 @@ static vm_fault_t do_metadata_none_page(struct vm_fault *vmf)
 			put_page(page);
 			return VM_FAULT_RETRY;
 		} else if (ret) {
+			// TODO: support migrating swap metadata with the page.
+			if (unlikely(page_metadata_in_swap(page))) {
+				vm_fault_t err;
+
+				if (vmf->flags & FAULT_FLAG_TRIED)
+					err = VM_FAULT_OOM;
+				else
+					err = VM_FAULT_RETRY;
+
+				put_page(page);
+				return err;
+			}
 			do_migrate = true;
 		}
 	}
-- 
2.41.0

