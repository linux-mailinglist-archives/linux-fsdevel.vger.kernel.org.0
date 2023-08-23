Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F4B7858E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbjHWNSE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbjHWNR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:17:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92A01E58;
        Wed, 23 Aug 2023 06:17:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 472231688;
        Wed, 23 Aug 2023 06:16:50 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99D093F740;
        Wed, 23 Aug 2023 06:16:03 -0700 (PDT)
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
Subject: [PATCH RFC 19/37] mm: page_alloc: Manage metadata storage on page allocation
Date:   Wed, 23 Aug 2023 14:13:32 +0100
Message-Id: <20230823131350.114942-20-alexandru.elisei@arm.com>
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

When a page is allocated with metadata, the associated metadata storage
cannot be used for data because the page metadata will overwrite the
metadata storage contents. Reserve metadata storage when the associated
page is allocated with metadata enabled. If metadata storage cannot be
reserved, because, for example, of a short term pin, then the page with
metadata enabled which triggered the reservation will be put back at the
tail of the free list and the page allocator will repeat the process for a
new page. If the page allocator exhausts all allocation paths, then it must
mean that the system is out of memory and this is treated like any other
OOM situation.

When a metadata-enabled page is freed, then also free the associated
metadata storage, so it can be used to data allocations.

For the direct reclaim slowpath, no special handling for metadata pages has
been added - metadata pages are still considered for reclaim even if they
cannot be used to satisfy the allocation request. This behaviour has been
preserved to increase the chance that the metadata storage is free when the
associated page is allocated with metadata enabled.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/memory_metadata.h | 14 ++++++++
 include/asm-generic/memory_metadata.h    | 11 ++++++
 include/linux/vm_event_item.h            |  5 +++
 mm/page_alloc.c                          | 43 ++++++++++++++++++++++++
 mm/vmstat.c                              |  5 +++
 5 files changed, 78 insertions(+)

diff --git a/arch/arm64/include/asm/memory_metadata.h b/arch/arm64/include/asm/memory_metadata.h
index 3287b2776af1..1b18e3217dd0 100644
--- a/arch/arm64/include/asm/memory_metadata.h
+++ b/arch/arm64/include/asm/memory_metadata.h
@@ -20,12 +20,26 @@ static inline bool alloc_can_use_metadata_pages(gfp_t gfp_mask)
 	return !(gfp_mask & __GFP_TAGGED);
 }
 
+static inline bool alloc_requires_metadata(gfp_t gfp_mask)
+{
+	return gfp_mask & __GFP_TAGGED;
+}
+
 #define page_has_metadata(page)			page_mte_tagged(page)
 
 static inline bool folio_has_metadata(struct folio *folio)
 {
 	return page_has_metadata(&folio->page);
 }
+
+static inline int reserve_metadata_storage(struct page *page, int order, gfp_t gfp_mask)
+{
+	return 0;
+}
+
+static inline void free_metadata_storage(struct page *page, int order)
+{
+}
 #endif /* CONFIG_MEMORY_METADATA */
 
 #endif /* __ASM_MEMORY_METADATA_H  */
diff --git a/include/asm-generic/memory_metadata.h b/include/asm-generic/memory_metadata.h
index 8f4e2fba222f..111d6edc0997 100644
--- a/include/asm-generic/memory_metadata.h
+++ b/include/asm-generic/memory_metadata.h
@@ -16,6 +16,17 @@ static inline bool alloc_can_use_metadata_pages(gfp_t gfp_mask)
 {
 	return false;
 }
+static inline bool alloc_requires_metadata(gfp_t gfp_mask)
+{
+	return false;
+}
+static inline int reserve_metadata_storage(struct page *page, int order, gfp_t gfp_mask)
+{
+	return 0;
+}
+static inline void free_metadata_storage(struct page *page, int order)
+{
+}
 static inline bool page_has_metadata(struct page *page)
 {
 	return false;
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 8abfa1240040..3163b85d2bc6 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -86,6 +86,11 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_CMA
 		CMA_ALLOC_SUCCESS,
 		CMA_ALLOC_FAIL,
+#endif
+#ifdef CONFIG_MEMORY_METADATA
+		METADATA_RESERVE_SUCCESS,
+		METADATA_RESERVE_FAIL,
+		METADATA_RESERVE_FREE,
 #endif
 		UNEVICTABLE_PGCULLED,	/* culled to noreclaim list */
 		UNEVICTABLE_PGSCANNED,	/* scanned for reclaimability */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 011645d07ce9..911d3c362848 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1111,6 +1111,9 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
 
+	if (metadata_storage_enabled() && page_has_metadata(page))
+		free_metadata_storage(page, order);
+
 	if (unlikely(PageHWPoison(page)) && !order) {
 		/*
 		 * Do not let hwpoison pages hit pcplists/buddy
@@ -3143,6 +3146,24 @@ static inline unsigned int gfp_to_alloc_flags_fast(gfp_t gfp_mask,
 	return alloc_flags;
 }
 
+#ifdef CONFIG_MEMORY_METADATA
+static void return_page_to_buddy(struct page *page, int order)
+{
+	struct zone *zone = page_zone(page);
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long flags;
+	int migratetype = get_pfnblock_migratetype(page, pfn);
+
+	spin_lock_irqsave(&zone->lock, flags);
+	__free_one_page(page, pfn, zone, order, migratetype, FPI_TO_TAIL);
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
+#else
+static void return_page_to_buddy(struct page *page, int order)
+{
+}
+#endif
+
 /*
  * get_page_from_freelist goes through the zonelist trying to allocate
  * a page.
@@ -3156,6 +3177,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
+	int ret;
 
 retry:
 	/*
@@ -3270,6 +3292,15 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
+			if (metadata_storage_enabled() && alloc_requires_metadata(gfp_mask)) {
+				ret = reserve_metadata_storage(page, order, gfp_mask);
+				if (ret != 0) {
+					return_page_to_buddy(page, order);
+					page = NULL;
+					goto no_page;
+				}
+			}
+
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
 			/*
@@ -3285,7 +3316,10 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				if (try_to_accept_memory(zone, order))
 					goto try_this_zone;
 			}
+		}
 
+no_page:
+		if (!page) {
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/* Try again if zone has deferred pages */
 			if (deferred_pages_enabled()) {
@@ -3475,6 +3509,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	struct page *page = NULL;
 	unsigned long pflags;
 	unsigned int noreclaim_flag;
+	int ret;
 
 	if (!order)
 		return NULL;
@@ -3498,6 +3533,14 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	 */
 	count_vm_event(COMPACTSTALL);
 
+	if (metadata_storage_enabled() && page && alloc_requires_metadata(gfp_mask)) {
+		ret = reserve_metadata_storage(page, order, gfp_mask);
+		if (ret != 0) {
+			return_page_to_buddy(page, order);
+			page = NULL;
+		}
+	}
+
 	/* Prep a captured page if available */
 	if (page)
 		prep_new_page(page, order, gfp_mask, alloc_flags);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 07caa284a724..807b514718d2 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1338,6 +1338,11 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_CMA
 	"cma_alloc_success",
 	"cma_alloc_fail",
+#endif
+#ifdef CONFIG_MEMORY_METADATA
+	"metadata_reserve_success",
+	"metadata_reserve_fail",
+	"metadata_reserve_free",
 #endif
 	"unevictable_pgs_culled",
 	"unevictable_pgs_scanned",
-- 
2.41.0

