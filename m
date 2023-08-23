Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B778589D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjHWNOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjHWNO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:14:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71F72E79;
        Wed, 23 Aug 2023 06:14:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF9EF1515;
        Wed, 23 Aug 2023 06:15:02 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BAF13F740;
        Wed, 23 Aug 2023 06:14:16 -0700 (PDT)
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
Subject: [PATCH RFC 02/37] arm64: mte: Rework naming for tag manipulation functions
Date:   Wed, 23 Aug 2023 14:13:15 +0100
Message-Id: <20230823131350.114942-3-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823131350.114942-1-alexandru.elisei@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The tag save/restore/copy functions could be more explicit about from where
the tags are coming from and where they are being copied to. Renaming the
functions to make it easier to understand what they are doing:

- Rename the mte_clear_page_tags() 'addr' parameter to 'page_addr', to
  match the other functions that take a page address as parameter.

- Rename mte_save/restore_tags() to
  mte_save/restore_page_tags_by_swp_entry() to 1. distinguish the functions
  from mte_save/restore_page_tags() and 2. make it clear how they are
  indexed (this will become important once other ways to save the tags are
  added). Same applies to mte_invalidate_tags{,_area}_by_swp_entry().

- Rename mte_save/restore_page_tags() to make it clear where the tags are
  going to be saved, respectively from where they are restored - in a
  previously allocator memory buffer, not in an xarray, like with the tags
  preserved when swapping.

- Rename mte_allocate/free_tag_storage() to mte_allocate/free_tags_mem() to
  make it clear the functions have nothing to do with the memory where the
  live tags are stored for a page. Change the parameter type for
  mte_free_tags_mem()) to be void *, to match the return value of
  mte_allocate_tags_mem(). Also because that memory is opaque and it not
  meant to be directly deferenced.

In the name of consistency rename local variables from tag_storage to tags.
Give a similar treatment to the hibernation code that saves and restores
the tags for all tagged pages.

In the same spirit, rename MTE_PAGE_TAG_STORAGE to
MTE_PAGE_TAG_STORAGE_SIZE to make it clear that it relates to the size of
the memory needed to save the tags for a page. Oportunistically rename
MTE_TAG_SIZE to MTE_TAG_SIZE_BITS to make it clear it is measured in bits,
not bytes, like the rest of the size variable from the same header file.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/mte-def.h | 16 +++++-----
 arch/arm64/include/asm/mte.h     | 24 +++++++++------
 arch/arm64/include/asm/pgtable.h |  8 ++---
 arch/arm64/kernel/elfcore.c      | 14 ++++-----
 arch/arm64/kernel/hibernate.c    | 46 ++++++++++++++---------------
 arch/arm64/lib/mte.S             | 14 ++++-----
 arch/arm64/mm/mteswap.c          | 50 ++++++++++++++++----------------
 7 files changed, 89 insertions(+), 83 deletions(-)

diff --git a/arch/arm64/include/asm/mte-def.h b/arch/arm64/include/asm/mte-def.h
index 14ee86b019c2..eb0d76a6bdcf 100644
--- a/arch/arm64/include/asm/mte-def.h
+++ b/arch/arm64/include/asm/mte-def.h
@@ -5,14 +5,14 @@
 #ifndef __ASM_MTE_DEF_H
 #define __ASM_MTE_DEF_H
 
-#define MTE_GRANULE_SIZE	UL(16)
-#define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
-#define MTE_GRANULES_PER_PAGE	(PAGE_SIZE / MTE_GRANULE_SIZE)
-#define MTE_TAG_SHIFT		56
-#define MTE_TAG_SIZE		4
-#define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
-#define MTE_PAGE_TAG_STORAGE	(MTE_GRANULES_PER_PAGE * MTE_TAG_SIZE / 8)
+#define MTE_GRANULE_SIZE		UL(16)
+#define MTE_GRANULE_MASK		(~(MTE_GRANULE_SIZE - 1))
+#define MTE_GRANULES_PER_PAGE		(PAGE_SIZE / MTE_GRANULE_SIZE)
+#define MTE_TAG_SHIFT			56
+#define MTE_TAG_SIZE_BITS		4
+#define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE_BITS - 1)), MTE_TAG_SHIFT)
+#define MTE_PAGE_TAG_STORAGE_SIZE	(MTE_GRANULES_PER_PAGE * MTE_TAG_SIZE_BITS / 8)
 
-#define __MTE_PREAMBLE		ARM64_ASM_PREAMBLE ".arch_extension memtag\n"
+#define __MTE_PREAMBLE			ARM64_ASM_PREAMBLE ".arch_extension memtag\n"
 
 #endif /* __ASM_MTE_DEF_H  */
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 4cedbaa16f41..246a561652f4 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -18,19 +18,25 @@
 
 #include <asm/pgtable-types.h>
 
-void mte_clear_page_tags(void *addr);
+void mte_clear_page_tags(void *page_addr);
+
 unsigned long mte_copy_tags_from_user(void *to, const void __user *from,
 				      unsigned long n);
 unsigned long mte_copy_tags_to_user(void __user *to, void *from,
 				    unsigned long n);
-int mte_save_tags(struct page *page);
-void mte_save_page_tags(const void *page_addr, void *tag_storage);
-void mte_restore_tags(swp_entry_t entry, struct page *page);
-void mte_restore_page_tags(void *page_addr, const void *tag_storage);
-void mte_invalidate_tags(int type, pgoff_t offset);
-void mte_invalidate_tags_area(int type);
-void *mte_allocate_tag_storage(void);
-void mte_free_tag_storage(char *storage);
+
+/* page_private(page) contains the swp_entry.val value. */
+int mte_save_page_tags_by_swp_entry(struct page *page);
+void mte_restore_page_tags_by_swp_entry(swp_entry_t entry, struct page *page);
+
+void mte_save_page_tags_to_mem(const void *page_addr, void *to);
+void mte_restore_page_tags_from_mem(void *page_addr, const void *from);
+
+void mte_invalidate_tags_by_swp_entry(int type, pgoff_t offset);
+void mte_invalidate_tags_area_by_swp_entry(int type);
+
+void *mte_allocate_tags_mem(void);
+void mte_free_tags_mem(void *tags);
 
 #ifdef CONFIG_ARM64_MTE
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e8a252e62b12..944860d7090e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1020,7 +1020,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 static inline int arch_prepare_to_swap(struct page *page)
 {
 	if (system_supports_mte())
-		return mte_save_tags(page);
+		return mte_save_page_tags_by_swp_entry(page);
 	return 0;
 }
 
@@ -1028,20 +1028,20 @@ static inline int arch_prepare_to_swap(struct page *page)
 static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
 {
 	if (system_supports_mte())
-		mte_invalidate_tags(type, offset);
+		mte_invalidate_tags_by_swp_entry(type, offset);
 }
 
 static inline void arch_swap_invalidate_area(int type)
 {
 	if (system_supports_mte())
-		mte_invalidate_tags_area(type);
+		mte_invalidate_tags_area_by_swp_entry(type);
 }
 
 #define __HAVE_ARCH_SWAP_RESTORE
 static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 {
 	if (system_supports_mte())
-		mte_restore_tags(entry, &folio->page);
+		mte_restore_page_tags_by_swp_entry(entry, &folio->page);
 }
 
 #endif /* CONFIG_ARM64_MTE */
diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
index 2e94d20c4ac7..c062c2c3d10d 100644
--- a/arch/arm64/kernel/elfcore.c
+++ b/arch/arm64/kernel/elfcore.c
@@ -17,7 +17,7 @@
 
 static unsigned long mte_vma_tag_dump_size(struct core_vma_metadata *m)
 {
-	return (m->dump_size >> PAGE_SHIFT) * MTE_PAGE_TAG_STORAGE;
+	return (m->dump_size >> PAGE_SHIFT) * MTE_PAGE_TAG_STORAGE_SIZE;
 }
 
 /* Derived from dump_user_range(); start/end must be page-aligned */
@@ -38,7 +38,7 @@ static int mte_dump_tag_range(struct coredump_params *cprm,
 		 * have been all zeros.
 		 */
 		if (!page) {
-			dump_skip(cprm, MTE_PAGE_TAG_STORAGE);
+			dump_skip(cprm, MTE_PAGE_TAG_STORAGE_SIZE);
 			continue;
 		}
 
@@ -48,12 +48,12 @@ static int mte_dump_tag_range(struct coredump_params *cprm,
 		 */
 		if (!page_mte_tagged(page)) {
 			put_page(page);
-			dump_skip(cprm, MTE_PAGE_TAG_STORAGE);
+			dump_skip(cprm, MTE_PAGE_TAG_STORAGE_SIZE);
 			continue;
 		}
 
 		if (!tags) {
-			tags = mte_allocate_tag_storage();
+			tags = mte_allocate_tags_mem();
 			if (!tags) {
 				put_page(page);
 				ret = 0;
@@ -61,16 +61,16 @@ static int mte_dump_tag_range(struct coredump_params *cprm,
 			}
 		}
 
-		mte_save_page_tags(page_address(page), tags);
+		mte_save_page_tags_to_mem(page_address(page), tags);
 		put_page(page);
-		if (!dump_emit(cprm, tags, MTE_PAGE_TAG_STORAGE)) {
+		if (!dump_emit(cprm, tags, MTE_PAGE_TAG_STORAGE_SIZE)) {
 			ret = 0;
 			break;
 		}
 	}
 
 	if (tags)
-		mte_free_tag_storage(tags);
+		mte_free_tags_mem(tags);
 
 	return ret;
 }
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 02870beb271e..f3cdbd8ba8f9 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -215,41 +215,41 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 #ifdef CONFIG_ARM64_MTE
 
-static DEFINE_XARRAY(mte_pages);
+static DEFINE_XARRAY(tags_by_pfn);
 
-static int save_tags(struct page *page, unsigned long pfn)
+static int save_page_tags_by_pfn(struct page *page, unsigned long pfn)
 {
-	void *tag_storage, *ret;
+	void *tags, *ret;
 
-	tag_storage = mte_allocate_tag_storage();
-	if (!tag_storage)
+	tags = mte_allocate_tags_mem();
+	if (!tags)
 		return -ENOMEM;
 
-	mte_save_page_tags(page_address(page), tag_storage);
+	mte_save_page_tags_to_mem(page_address(page), tags);
 
-	ret = xa_store(&mte_pages, pfn, tag_storage, GFP_KERNEL);
+	ret = xa_store(&tags_by_pfn, pfn, tags, GFP_KERNEL);
 	if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
-		mte_free_tag_storage(tag_storage);
+		mte_free_tags_mem(tags);
 		return xa_err(ret);
 	} else if (WARN(ret, "swsusp: %s: Duplicate entry", __func__)) {
-		mte_free_tag_storage(ret);
+		mte_free_tags_mem(ret);
 	}
 
 	return 0;
 }
 
-static void swsusp_mte_free_storage(void)
+static void swsusp_mte_free_tags(void)
 {
-	XA_STATE(xa_state, &mte_pages, 0);
+	XA_STATE(xa_state, &tags_by_pfn, 0);
 	void *tags;
 
-	xa_lock(&mte_pages);
+	xa_lock(&tags_by_pfn);
 	xas_for_each(&xa_state, tags, ULONG_MAX) {
-		mte_free_tag_storage(tags);
+		mte_free_tags_mem(tags);
 	}
-	xa_unlock(&mte_pages);
+	xa_unlock(&tags_by_pfn);
 
-	xa_destroy(&mte_pages);
+	xa_destroy(&tags_by_pfn);
 }
 
 static int swsusp_mte_save_tags(void)
@@ -273,9 +273,9 @@ static int swsusp_mte_save_tags(void)
 			if (!page_mte_tagged(page))
 				continue;
 
-			ret = save_tags(page, pfn);
+			ret = save_page_tags_by_pfn(page, pfn);
 			if (ret) {
-				swsusp_mte_free_storage();
+				swsusp_mte_free_tags();
 				goto out;
 			}
 
@@ -290,25 +290,25 @@ static int swsusp_mte_save_tags(void)
 
 static void swsusp_mte_restore_tags(void)
 {
-	XA_STATE(xa_state, &mte_pages, 0);
+	XA_STATE(xa_state, &tags_by_pfn, 0);
 	int n = 0;
 	void *tags;
 
-	xa_lock(&mte_pages);
+	xa_lock(&tags_by_pfn);
 	xas_for_each(&xa_state, tags, ULONG_MAX) {
 		unsigned long pfn = xa_state.xa_index;
 		struct page *page = pfn_to_online_page(pfn);
 
-		mte_restore_page_tags(page_address(page), tags);
+		mte_restore_page_tags_from_mem(page_address(page), tags);
 
-		mte_free_tag_storage(tags);
+		mte_free_tags_mem(tags);
 		n++;
 	}
-	xa_unlock(&mte_pages);
+	xa_unlock(&tags_by_pfn);
 
 	pr_info("Restored %d MTE pages\n", n);
 
-	xa_destroy(&mte_pages);
+	xa_destroy(&tags_by_pfn);
 }
 
 #else	/* CONFIG_ARM64_MTE */
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index 5018ac03b6bf..d3c4ff70f48b 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -119,7 +119,7 @@ SYM_FUNC_START(mte_copy_tags_to_user)
 	cbz	x2, 2f
 1:
 	ldg	x4, [x1]
-	ubfx	x4, x4, #MTE_TAG_SHIFT, #MTE_TAG_SIZE
+	ubfx	x4, x4, #MTE_TAG_SHIFT, #MTE_TAG_SIZE_BITS
 USER(2f, sttrb	w4, [x0])
 	add	x0, x0, #1
 	add	x1, x1, #MTE_GRANULE_SIZE
@@ -134,9 +134,9 @@ SYM_FUNC_END(mte_copy_tags_to_user)
 /*
  * Save the tags in a page
  *   x0 - page address
- *   x1 - tag storage, MTE_PAGE_TAG_STORAGE bytes
+ *   x1 - memory buffer, MTE_PAGE_TAG_STORAGE_SIZE bytes
  */
-SYM_FUNC_START(mte_save_page_tags)
+SYM_FUNC_START(mte_save_page_tags_to_mem)
 	multitag_transfer_size x7, x5
 1:
 	mov	x2, #0
@@ -153,14 +153,14 @@ SYM_FUNC_START(mte_save_page_tags)
 	b.ne	1b
 
 	ret
-SYM_FUNC_END(mte_save_page_tags)
+SYM_FUNC_END(mte_save_page_tags_to_mem)
 
 /*
  * Restore the tags in a page
  *   x0 - page address
- *   x1 - tag storage, MTE_PAGE_TAG_STORAGE bytes
+ *   x1 - memory buffer, MTE_PAGE_TAG_STORAGE_SIZE bytes
  */
-SYM_FUNC_START(mte_restore_page_tags)
+SYM_FUNC_START(mte_restore_page_tags_from_mem)
 	multitag_transfer_size x7, x5
 1:
 	ldr	x2, [x1], #8
@@ -174,4 +174,4 @@ SYM_FUNC_START(mte_restore_page_tags)
 	b.ne	1b
 
 	ret
-SYM_FUNC_END(mte_restore_page_tags)
+SYM_FUNC_END(mte_restore_page_tags_from_mem)
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index cd508ba80ab1..aaeca57f36cc 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -7,78 +7,78 @@
 #include <linux/swapops.h>
 #include <asm/mte.h>
 
-static DEFINE_XARRAY(mte_pages);
+static DEFINE_XARRAY(tags_by_swp_entry);
 
-void *mte_allocate_tag_storage(void)
+void *mte_allocate_tags_mem(void)
 {
 	/* tags granule is 16 bytes, 2 tags stored per byte */
-	return kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
+	return kmalloc(MTE_PAGE_TAG_STORAGE_SIZE, GFP_KERNEL);
 }
 
-void mte_free_tag_storage(char *storage)
+void mte_free_tags_mem(void *tags)
 {
-	kfree(storage);
+	kfree(tags);
 }
 
-int mte_save_tags(struct page *page)
+int mte_save_page_tags_by_swp_entry(struct page *page)
 {
-	void *tag_storage, *ret;
+	void *tags, *ret;
 
 	if (!page_mte_tagged(page))
 		return 0;
 
-	tag_storage = mte_allocate_tag_storage();
-	if (!tag_storage)
+	tags = mte_allocate_tags_mem();
+	if (!tags)
 		return -ENOMEM;
 
-	mte_save_page_tags(page_address(page), tag_storage);
+	mte_save_page_tags_to_mem(page_address(page), tags);
 
 	/* page_private contains the swap entry.val set in do_swap_page */
-	ret = xa_store(&mte_pages, page_private(page), tag_storage, GFP_KERNEL);
+	ret = xa_store(&tags_by_swp_entry, page_private(page), tags, GFP_KERNEL);
 	if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
-		mte_free_tag_storage(tag_storage);
+		mte_free_tags_mem(tags);
 		return xa_err(ret);
 	} else if (ret) {
 		/* Entry is being replaced, free the old entry */
-		mte_free_tag_storage(ret);
+		mte_free_tags_mem(ret);
 	}
 
 	return 0;
 }
 
-void mte_restore_tags(swp_entry_t entry, struct page *page)
+void mte_restore_page_tags_by_swp_entry(swp_entry_t entry, struct page *page)
 {
-	void *tags = xa_load(&mte_pages, entry.val);
+	void *tags = xa_load(&tags_by_swp_entry, entry.val);
 
 	if (!tags)
 		return;
 
 	if (try_page_mte_tagging(page)) {
-		mte_restore_page_tags(page_address(page), tags);
+		mte_restore_page_tags_from_mem(page_address(page), tags);
 		set_page_mte_tagged(page);
 	}
 }
 
-void mte_invalidate_tags(int type, pgoff_t offset)
+void mte_invalidate_tags_by_swp_entry(int type, pgoff_t offset)
 {
 	swp_entry_t entry = swp_entry(type, offset);
-	void *tags = xa_erase(&mte_pages, entry.val);
+	void *tags = xa_erase(&tags_by_swp_entry, entry.val);
 
-	mte_free_tag_storage(tags);
+	mte_free_tags_mem(tags);
 }
 
-void mte_invalidate_tags_area(int type)
+void mte_invalidate_tags_area_by_swp_entry(int type)
 {
 	swp_entry_t entry = swp_entry(type, 0);
 	swp_entry_t last_entry = swp_entry(type + 1, 0);
 	void *tags;
 
-	XA_STATE(xa_state, &mte_pages, entry.val);
+	XA_STATE(xa_state, &tags_by_swp_entry, entry.val);
 
-	xa_lock(&mte_pages);
+	xa_lock(&tags_by_swp_entry);
 	xas_for_each(&xa_state, tags, last_entry.val - 1) {
-		__xa_erase(&mte_pages, xa_state.xa_index);
-		mte_free_tag_storage(tags);
+		__xa_erase(&tags_by_swp_entry, xa_state.xa_index);
+		mte_free_tags_mem(tags);
 	}
-	xa_unlock(&mte_pages);
+	xa_unlock(&tags_by_swp_entry);
 }
-- 
2.41.0

