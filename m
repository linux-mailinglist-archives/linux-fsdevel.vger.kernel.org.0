Return-Path: <linux-fsdevel+bounces-3145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7387F07BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D958A280DAC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B014F9A;
	Sun, 19 Nov 2023 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C6BBD4B;
	Sun, 19 Nov 2023 08:58:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 241511477;
	Sun, 19 Nov 2023 08:58:52 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB7AF3F6C4;
	Sun, 19 Nov 2023 08:58:00 -0800 (PST)
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
Subject: [PATCH RFC v2 05/27] mm: page_alloc: Add an arch hook to allow prep_new_page() to fail
Date: Sun, 19 Nov 2023 16:56:59 +0000
Message-Id: <20231119165721.9849-6-alexandru.elisei@arm.com>
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

Introduce arch_prep_new_page(), which will be used by arm64 to reserve tag
storage for an allocated page. Reserving tag storage can fail, for example,
if the tag storage page has a short pin on it, so allow prep_new_page() ->
arch_prep_new_page() to similarly fail.

arch_alloc_page(), called from post_alloc_hook(), has been considered as an
alternative to adding yet another arch hook, but post_alloc_hook() cannot
fail, as it's also called when free pages are isolated.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/linux/pgtable.h |  7 ++++
 mm/page_alloc.c         | 75 ++++++++++++++++++++++++++++++++---------
 2 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index af7639c3b0a3..b31f53e9ab1d 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -873,6 +873,13 @@ static inline void arch_do_swap_page(struct mm_struct *mm,
 }
 #endif
 
+#ifndef __HAVE_ARCH_PREP_NEW_PAGE
+static inline int arch_prep_new_page(struct page *page, int order, gfp_t gfp)
+{
+	return 0;
+}
+#endif
+
 #ifndef __HAVE_ARCH_UNMAP_ONE
 /*
  * Some architectures support metadata associated with a page. When a
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 770e585b77c8..b2782b778e78 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1538,9 +1538,15 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	page_table_check_alloc(page, order);
 }
 
-static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
+static int prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
 							unsigned int alloc_flags)
 {
+	int ret;
+
+	ret = arch_prep_new_page(page, order, gfp_flags);
+	if (unlikely(ret))
+		return ret;
+
 	post_alloc_hook(page, order, gfp_flags);
 
 	if (order && (gfp_flags & __GFP_COMP))
@@ -1556,6 +1562,8 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 		set_page_pfmemalloc(page);
 	else
 		clear_page_pfmemalloc(page);
+
+	return 0;
 }
 
 /*
@@ -3163,6 +3171,24 @@ static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
 	return alloc_flags;
 }
 
+#ifdef HAVE_ARCH_ALLOC_PAGE
+static void return_page_to_buddy(struct page *page, int order)
+{
+	int migratetype = get_pfnblock_migratetype(page, pfn);
+	unsigned long pfn = page_to_pfn(page);
+	struct zone *zone = page_zone(page);
+	unsigned long flags;
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
@@ -3309,7 +3335,10 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
-			prep_new_page(page, order, gfp_mask, alloc_flags);
+			if (prep_new_page(page, order, gfp_mask, alloc_flags)) {
+				return_page_to_buddy(page, order);
+				goto no_page;
+			}
 
 			/*
 			 * If this is a high-order atomic allocation then check
@@ -3319,20 +3348,20 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-		} else {
-			if (has_unaccepted_memory()) {
-				if (try_to_accept_memory(zone, order))
-					goto try_this_zone;
-			}
+		}
+no_page:
+		if (has_unaccepted_memory()) {
+			if (try_to_accept_memory(zone, order))
+				goto try_this_zone;
+		}
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-			/* Try again if zone has deferred pages */
-			if (deferred_pages_enabled()) {
-				if (_deferred_grow_zone(zone, order))
-					goto try_this_zone;
-			}
-#endif
+		/* Try again if zone has deferred pages */
+		if (deferred_pages_enabled()) {
+			if (_deferred_grow_zone(zone, order))
+				goto try_this_zone;
 		}
+#endif
 	}
 
 	/*
@@ -3538,8 +3567,12 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	count_vm_event(COMPACTSTALL);
 
 	/* Prep a captured page if available */
-	if (page)
-		prep_new_page(page, order, gfp_mask, alloc_flags);
+	if (page) {
+		if (prep_new_page(page, order, gfp_mask, alloc_flags)) {
+			return_page_to_buddy(page, order);
+			page = NULL;
+		}
+	}
 
 	/* Try get a page from the freelist if available */
 	if (!page)
@@ -4490,9 +4523,18 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			}
 			break;
 		}
+
+		if (prep_new_page(page, 0, gfp, 0)) {
+			pcp_spin_unlock(pcp);
+			pcp_trylock_finish(UP_flags);
+			return_page_to_buddy(page, 0);
+			if (!nr_account)
+				goto failed;
+			else
+				goto out_statistics;
+		}
 		nr_account++;
 
-		prep_new_page(page, 0, gfp, 0);
 		if (page_list)
 			list_add(&page->lru, page_list);
 		else
@@ -4503,6 +4545,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
 
+out_statistics:
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
 
-- 
2.42.1


