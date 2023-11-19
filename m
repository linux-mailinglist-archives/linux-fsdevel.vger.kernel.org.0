Return-Path: <linux-fsdevel+bounces-3166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5267F07F6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 18:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAA31C2090D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC58D1804F;
	Sun, 19 Nov 2023 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1CD210E2;
	Sun, 19 Nov 2023 08:59:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 929F61042;
	Sun, 19 Nov 2023 09:00:42 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69E853F6C4;
	Sun, 19 Nov 2023 08:59:51 -0800 (PST)
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
Subject: [PATCH RFC v2 26/27] arm64: mte: Fast track reserving tag storage when the block is free
Date: Sun, 19 Nov 2023 16:57:20 +0000
Message-Id: <20231119165721.9849-27-alexandru.elisei@arm.com>
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

A double digit performance decrease for Chrome startup time has been
reported with the dynamic tag storage management enabled. A large part of
the regression is due to lru_cache_disable(), called from
__alloc_contig_migrate_range(), which IPIs all CPUs in the system.

Improve the performance by taking the storage block directly from the
freelist if it's free, thus sidestepping the costly function call.

Note that at the moment this is implemented only when the block size is
1 (the block is one page); larger block sizes could be added later if
necessary.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/kernel/mte_tag_storage.c | 15 +++++++++++++++
 include/linux/page-flags.h          | 15 +++++++++++++--
 mm/Kconfig                          |  4 ++++
 mm/memory-failure.c                 |  8 ++++----
 mm/page_alloc.c                     | 21 ++++++++++++---------
 6 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3b9c435eaafb..93a4bbca3800 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2067,6 +2067,7 @@ config ARM64_MTE_TAG_STORAGE
 	bool "Dynamic MTE tag storage management"
 	depends on ARCH_KEEP_MEMBLOCK
 	select ARCH_HAS_FAULT_ON_ACCESS
+	select WANTS_TAKE_PAGE_OFF_BUDDY
 	select CONFIG_CMA
 	help
 	  Adds support for dynamic management of the memory used by the hardware
diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 602fdc70db1c..11961587382d 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -522,6 +522,7 @@ int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
 	unsigned long block;
 	unsigned long flags;
 	unsigned int tries;
+	bool success;
 	int ret = 0;
 
 	VM_WARN_ON_ONCE(!preemptible());
@@ -565,6 +566,19 @@ int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
 		if (tag_storage_block_is_reserved(block))
 			continue;
 
+		if (region->block_size == 1 && is_free_buddy_page(pfn_to_page(block))) {
+			success = take_page_off_buddy(pfn_to_page(block), false);
+			if (success) {
+				ret = tag_storage_reserve_block(block, region, order);
+				if (ret) {
+					put_page_back_buddy(pfn_to_page(block), false);
+					goto out_error;
+				}
+				page_ref_inc(pfn_to_page(block));
+				goto success_next;
+			}
+		}
+
 		tries = 3;
 		while (tries--) {
 			ret = alloc_contig_range(block, block + region->block_size, MIGRATE_CMA, gfp);
@@ -598,6 +612,7 @@ int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
 			goto out_error;
 		}
 
+success_next:
 		count_vm_events(CMA_ALLOC_SUCCESS, region->block_size);
 	}
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 7915165a51bd..0d0380141f5d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -576,11 +576,22 @@ TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define MAGIC_HWPOISON	0x48575053U	/* HWPS */
 extern void SetPageHWPoisonTakenOff(struct page *page);
 extern void ClearPageHWPoisonTakenOff(struct page *page);
-extern bool take_page_off_buddy(struct page *page);
-extern bool put_page_back_buddy(struct page *page);
+extern bool PageHWPoisonTakenOff(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison, hwpoison)
+TESTSCFLAG_FALSE(HWPoison, hwpoison)
 #define __PG_HWPOISON 0
+static inline void SetPageHWPoisonTakenOff(struct page *page) { }
+static inline void ClearPageHWPoisonTakenOff(struct page *page) { }
+static inline bool PageHWPoisonTakenOff(struct page *page)
+{
+	return false;
+}
+#endif
+
+#ifdef CONFIG_WANTS_TAKE_PAGE_OFF_BUDDY
+extern bool take_page_off_buddy(struct page *page, bool poison);
+extern bool put_page_back_buddy(struct page *page, bool unpoison);
 #endif
 
 #if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
diff --git a/mm/Kconfig b/mm/Kconfig
index a90eefc3ee80..0766cdc3de4d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -773,6 +773,7 @@ config MEMORY_FAILURE
 	depends on MMU
 	depends on ARCH_SUPPORTS_MEMORY_FAILURE
 	bool "Enable recovery from hardware memory errors"
+	select WANTS_TAKE_PAGE_OFF_BUDDY
 	select MEMORY_ISOLATION
 	select RAS
 	help
@@ -1022,6 +1023,9 @@ config ARCH_HAS_CACHE_LINE_SIZE
 config ARCH_HAS_FAULT_ON_ACCESS
 	bool
 
+config WANTS_TAKE_PAGE_OFF_BUDDY
+	bool
+
 config ARCH_HAS_CURRENT_STACK_POINTER
 	bool
 	help
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 660c21859118..8b44afd6a558 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -157,7 +157,7 @@ static int __page_handle_poison(struct page *page)
 	zone_pcp_disable(page_zone(page));
 	ret = dissolve_free_huge_page(page);
 	if (!ret)
-		ret = take_page_off_buddy(page);
+		ret = take_page_off_buddy(page, true);
 	zone_pcp_enable(page_zone(page));
 
 	return ret;
@@ -1348,7 +1348,7 @@ static int page_action(struct page_state *ps, struct page *p,
 	return action_result(pfn, ps->type, result);
 }
 
-static inline bool PageHWPoisonTakenOff(struct page *page)
+bool PageHWPoisonTakenOff(struct page *page)
 {
 	return PageHWPoison(page) && page_private(page) == MAGIC_HWPOISON;
 }
@@ -2236,7 +2236,7 @@ int memory_failure(unsigned long pfn, int flags)
 		res = get_hwpoison_page(p, flags);
 		if (!res) {
 			if (is_free_buddy_page(p)) {
-				if (take_page_off_buddy(p)) {
+				if (take_page_off_buddy(p, true)) {
 					page_ref_inc(p);
 					res = MF_RECOVERED;
 				} else {
@@ -2567,7 +2567,7 @@ int unpoison_memory(unsigned long pfn)
 		ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
 	} else if (ghp < 0) {
 		if (ghp == -EHWPOISON) {
-			ret = put_page_back_buddy(p) ? 0 : -EBUSY;
+			ret = put_page_back_buddy(p, true) ? 0 : -EBUSY;
 		} else {
 			ret = ghp;
 			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 135f9283a863..4b74acfc41a6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6700,7 +6700,7 @@ bool is_free_buddy_page(struct page *page)
 }
 EXPORT_SYMBOL(is_free_buddy_page);
 
-#ifdef CONFIG_MEMORY_FAILURE
+#ifdef CONFIG_WANTS_TAKE_PAGE_OFF_BUDDY
 /*
  * Break down a higher-order page in sub-pages, and keep our target out of
  * buddy allocator.
@@ -6730,11 +6730,10 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 		set_buddy_order(current_buddy, high);
 	}
 }
-
 /*
- * Take a page that will be marked as poisoned off the buddy allocator.
+ * Take a page off the buddy allocator, and optionally mark it as poisoned.
  */
-bool take_page_off_buddy(struct page *page)
+bool take_page_off_buddy(struct page *page, bool poison)
 {
 	struct zone *zone = page_zone(page);
 	unsigned long pfn = page_to_pfn(page);
@@ -6755,7 +6754,8 @@ bool take_page_off_buddy(struct page *page)
 			del_page_from_free_list(page_head, zone, page_order);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
-			SetPageHWPoisonTakenOff(page);
+			if (poison)
+				SetPageHWPoisonTakenOff(page);
 			if (!is_migrate_isolate(migratetype))
 				__mod_zone_freepage_state(zone, -1, migratetype);
 			ret = true;
@@ -6769,9 +6769,10 @@ bool take_page_off_buddy(struct page *page)
 }
 
 /*
- * Cancel takeoff done by take_page_off_buddy().
+ * Cancel takeoff done by take_page_off_buddy(), and optionally unpoison the
+ * page.
  */
-bool put_page_back_buddy(struct page *page)
+bool put_page_back_buddy(struct page *page, bool unpoison)
 {
 	struct zone *zone = page_zone(page);
 	unsigned long pfn = page_to_pfn(page);
@@ -6781,9 +6782,11 @@ bool put_page_back_buddy(struct page *page)
 
 	spin_lock_irqsave(&zone->lock, flags);
 	if (put_page_testzero(page)) {
-		ClearPageHWPoisonTakenOff(page);
+		VM_WARN_ON_ONCE(PageHWPoisonTakenOff(page) && !unpoison);
+		if (unpoison)
+			ClearPageHWPoisonTakenOff(page);
 		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
-		if (TestClearPageHWPoison(page)) {
+		if (!unpoison || (unpoison && TestClearPageHWPoison(page))) {
 			ret = true;
 		}
 	}
-- 
2.42.1


