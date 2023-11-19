Return-Path: <linux-fsdevel+bounces-3162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A107F07E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A159280F12
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450C91803B;
	Sun, 19 Nov 2023 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1ECA10FD;
	Sun, 19 Nov 2023 08:59:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8837FEC;
	Sun, 19 Nov 2023 09:00:21 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77E993F6C4;
	Sun, 19 Nov 2023 08:59:30 -0800 (PST)
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
Subject: [PATCH RFC v2 22/27] arm64: mte: swap: Handle tag restoring when missing tag storage
Date: Sun, 19 Nov 2023 16:57:16 +0000
Message-Id: <20231119165721.9849-23-alexandru.elisei@arm.com>
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

Linux restores tags when a page is swapped in and there are tags associated
with the swap entry which the new page will replace. The saved tags are
restored even if the page will not be mapped as tagged, to protect against
cases where the page is shared between different VMAs, and is tagged in
some, but untagged in others. By using this approach, the process can still
access the correct tags following an mprotect(PROT_MTE) on the non-MTE
enabled VMA.

But this poses a challenge for managing tag storage: in the scenario above,
when a new page is allocated to be swapped in for the process where it will
be mapped as untagged, the corresponding tag storage block is not reserved.
mte_restore_page_tags_by_swp_entry(), when it restores the saved tags, will
overwrite data in the tag storage block associated with the new page,
leading to data corruption if the block is in use by a process.

Get around this issue by saving the tags in a new xarray, this time indexed
by the page pfn, and then restoring them when tag storage is reserved for
the page.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/mte_tag_storage.h |   9 ++
 arch/arm64/include/asm/pgtable.h         |  11 +++
 arch/arm64/kernel/mte_tag_storage.c      |  20 +++-
 arch/arm64/mm/mteswap.c                  | 112 +++++++++++++++++++++++
 4 files changed, 148 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
index 6a8b19a6a758..a3c38099fe1a 100644
--- a/arch/arm64/include/asm/mte_tag_storage.h
+++ b/arch/arm64/include/asm/mte_tag_storage.h
@@ -37,6 +37,15 @@ bool page_is_tag_storage(struct page *page);
 
 vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf);
 vm_fault_t handle_huge_page_missing_tag_storage(struct vm_fault *vmf);
+
+void tags_by_pfn_lock(void);
+void tags_by_pfn_unlock(void);
+
+void *mte_erase_tags_for_pfn(unsigned long pfn);
+bool mte_save_tags_for_pfn(void *tags, unsigned long pfn);
+void mte_restore_tags_for_pfn(unsigned long start_pfn, int order);
+
+vm_fault_t mte_try_transfer_swap_tags(swp_entry_t entry, struct page *page);
 #else
 static inline bool tag_storage_enabled(void)
 {
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 1704411c096d..1a25b7d601c2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1084,6 +1084,17 @@ static inline void arch_swap_invalidate_area(int type)
 		mte_invalidate_tags_area_by_swp_entry(type);
 }
 
+#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
+#define __HAVE_ARCH_SWAP_PREPARE_TO_RESTORE
+static inline vm_fault_t arch_swap_prepare_to_restore(swp_entry_t entry,
+						      struct folio *folio)
+{
+	if (tag_storage_enabled())
+		return mte_try_transfer_swap_tags(entry, &folio->page);
+	return 0;
+}
+#endif
+
 #define __HAVE_ARCH_SWAP_RESTORE
 static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 {
diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 5096ce859136..6b11bb408b51 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -547,8 +547,10 @@ int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
 	mutex_lock(&tag_blocks_lock);
 
 	/* Check again, this time with the lock held. */
-	if (page_tag_storage_reserved(page))
-		goto out_unlock;
+	if (page_tag_storage_reserved(page)) {
+		mutex_unlock(&tag_blocks_lock);
+		return 0;
+	}
 
 	/* Make sure existing entries are not freed from out under out feet. */
 	xa_lock_irqsave(&tag_blocks_reserved, flags);
@@ -583,9 +585,10 @@ int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
 	}
 
 	page_set_tag_storage_reserved(page, order);
-out_unlock:
 	mutex_unlock(&tag_blocks_lock);
 
+	mte_restore_tags_for_pfn(page_to_pfn(page), order);
+
 	return 0;
 
 out_error:
@@ -612,7 +615,8 @@ void free_tag_storage(struct page *page, int order)
 	struct tag_region *region;
 	unsigned long page_va;
 	unsigned long flags;
-	int ret;
+	void *tags;
+	int i, ret;
 
 	ret = tag_storage_find_block(page, &start_block, &region);
 	if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx", page_to_pfn(page)))
@@ -622,6 +626,14 @@ void free_tag_storage(struct page *page, int order)
 	/* Avoid writeback of dirty tag cache lines corrupting data. */
 	dcache_inval_tags_poc(page_va, page_va + (PAGE_SIZE << order));
 
+	tags_by_pfn_lock();
+	for (i = 0; i < (1 << order); i++) {
+		tags = mte_erase_tags_for_pfn(page_to_pfn(page + i));
+		if (unlikely(tags))
+			mte_free_tag_buf(tags);
+	}
+	tags_by_pfn_unlock();
+
 	end_block = start_block + order_to_num_blocks(order) * region->block_size;
 
 	xa_lock_irqsave(&tag_blocks_reserved, flags);
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index 2a43746b803f..20d718a514af 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -20,6 +20,114 @@ void mte_free_tag_buf(void *buf)
 	kfree(buf);
 }
 
+#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
+static DEFINE_XARRAY(tags_by_pfn);
+
+void tags_by_pfn_lock(void)
+{
+	xa_lock(&tags_by_pfn);
+}
+
+void tags_by_pfn_unlock(void)
+{
+	xa_unlock(&tags_by_pfn);
+}
+
+void *mte_erase_tags_for_pfn(unsigned long pfn)
+{
+	return __xa_erase(&tags_by_pfn, pfn);
+}
+
+bool mte_save_tags_for_pfn(void *tags, unsigned long pfn)
+{
+	void *entry;
+	int ret;
+
+	ret = xa_reserve(&tags_by_pfn, pfn, GFP_KERNEL);
+	if (ret)
+		return true;
+
+	tags_by_pfn_lock();
+
+	if (page_tag_storage_reserved(pfn_to_page(pfn))) {
+		tags_by_pfn_unlock();
+		return false;
+	}
+
+	entry = __xa_store(&tags_by_pfn, pfn, tags, GFP_ATOMIC);
+	if (xa_is_err(entry)) {
+		xa_release(&tags_by_pfn, pfn);
+		goto out_unlock;
+	} else if (entry) {
+		mte_free_tag_buf(entry);
+	}
+
+out_unlock:
+	tags_by_pfn_unlock();
+	return true;
+}
+
+void mte_restore_tags_for_pfn(unsigned long start_pfn, int order)
+{
+	struct page *page = pfn_to_page(start_pfn);
+	unsigned long pfn;
+	void *tags;
+
+	tags_by_pfn_lock();
+
+	for (pfn = start_pfn; pfn < start_pfn + (1 << order); pfn++, page++) {
+		if (WARN_ON_ONCE(!page_tag_storage_reserved(page)))
+			continue;
+
+		tags = mte_erase_tags_for_pfn(pfn);
+		if (unlikely(tags)) {
+			/*
+			 * Mark the page as tagged so mte_sync_tags() doesn't
+			 * clear the tags.
+			 */
+			WARN_ON_ONCE(!try_page_mte_tagging(page));
+			mte_copy_page_tags_from_buf(page_address(page), tags);
+			set_page_mte_tagged(page);
+			mte_free_tag_buf(tags);
+		}
+	}
+
+	tags_by_pfn_unlock();
+}
+
+/*
+ * Note on locking: swap in/out is done with the folio locked, which eliminates
+ * races with mte_save/restore_page_tags_by_swp_entry.
+ */
+vm_fault_t mte_try_transfer_swap_tags(swp_entry_t entry, struct page *page)
+{
+	void *swap_tags, *pfn_tags;
+	bool saved;
+
+	/*
+	 * mte_restore_page_tags_by_swp_entry() will take care of copying the
+	 * tags over.
+	 */
+	if (likely(page_mte_tagged(page) || page_tag_storage_reserved(page)))
+		return 0;
+
+	swap_tags = xa_load(&tags_by_swp_entry, entry.val);
+	if (!swap_tags)
+		return 0;
+
+	pfn_tags = mte_allocate_tag_buf();
+	if (!pfn_tags)
+		return VM_FAULT_OOM;
+
+	memcpy(pfn_tags, swap_tags, MTE_PAGE_TAG_STORAGE_SIZE);
+	saved = mte_save_tags_for_pfn(pfn_tags, page_to_pfn(page));
+	if (!saved)
+		mte_free_tag_buf(pfn_tags);
+
+	return 0;
+}
+#endif
+
 int mte_save_page_tags_by_swp_entry(struct page *page)
 {
 	void *tags, *ret;
@@ -54,6 +162,10 @@ void mte_restore_page_tags_by_swp_entry(swp_entry_t entry, struct page *page)
 	if (!tags)
 		return;
 
+	/* Tags will be restored when tag storage is reserved. */
+	if (tag_storage_enabled() && unlikely(!page_tag_storage_reserved(page)))
+		return;
+
 	if (try_page_mte_tagging(page)) {
 		mte_copy_page_tags_from_buf(page_address(page), tags);
 		set_page_mte_tagged(page);
-- 
2.42.1


