Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8E2D05E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfJIDVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:39 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57921 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730511AbfJIDVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:36 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 559533632B6;
        Wed,  9 Oct 2019 14:21:27 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-0006Be-3j; Wed, 09 Oct 2019 14:21:27 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-00039W-1N; Wed, 09 Oct 2019 14:21:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/26] mm: reclaim_state records pages reclaimed, not slabs
Date:   Wed,  9 Oct 2019 14:21:11 +1100
Message-Id: <20191009032124.10541-14-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8
        a=avOCubNBGnevqGq14jMA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Add a wrapper to account for page freeing in shrinker reclaim so
that the high level scanning accounts for all the memory freed
during a shrinker scan.

No logic changes, just replacing open coded checks with a simple
wrapper.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/inode.c           |  3 +--
 fs/xfs/xfs_buf.c     |  4 +---
 include/linux/swap.h | 20 ++++++++++++++++++--
 mm/slab.c            |  3 +--
 mm/slob.c            |  4 +---
 mm/slub.c            |  3 +--
 mm/vmscan.c          |  4 ++--
 7 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index fef457a42882..a77caf216659 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -764,8 +764,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 				__count_vm_events(KSWAPD_INODESTEAL, reap);
 			else
 				__count_vm_events(PGINODESTEAL, reap);
-			if (current->reclaim_state)
-				current->reclaim_state->reclaimed_slab += reap;
+			current_reclaim_account_pages(reap);
 		}
 		iput(inode);
 		spin_lock(lru_lock);
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 45b470f55ad7..bc5e0c712e2e 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -324,9 +324,7 @@ xfs_buf_free(
 
 			__free_page(page);
 		}
-		if (current->reclaim_state)
-			current->reclaim_state->reclaimed_slab +=
-							bp->b_page_count;
+		current_reclaim_account_pages(bp->b_page_count);
 	} else if (bp->b_flags & _XBF_KMEM)
 		kmem_free(bp->b_addr);
 	_xfs_buf_free_pages(bp);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 063c0c1e112b..72b855fe20b0 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -126,12 +126,28 @@ union swap_header {
 
 /*
  * current->reclaim_state points to one of these when a task is running
- * memory reclaim
+ * memory reclaim. It is typically used by shrinkers to return reclaim
+ * information back to the main vmscan loop.
  */
 struct reclaim_state {
-	unsigned long reclaimed_slab;
+	unsigned long	reclaimed_pages;	/* pages freed by shrinkers */
 };
 
+/*
+ * When code frees a page that may be run from a memory reclaim context, it
+ * needs to account for the pages it frees so memory reclaim can track them.
+ * Slab memory that is freed is accounted via this mechanism, so this is not
+ * necessary for slab or heap memory being freed. However, if the object being
+ * freed frees pages directly, then those pages should be accounted as well when
+ * in memory reclaim. This helper function takes care accounting for the pages
+ * being reclaimed when it is required.
+ */
+static inline void current_reclaim_account_pages(int nr_pages)
+{
+	if (current->reclaim_state)
+		current->reclaim_state->reclaimed_pages += nr_pages;
+}
+
 #ifdef __KERNEL__
 
 struct address_space;
diff --git a/mm/slab.c b/mm/slab.c
index 9df370558e5d..05baeda97fef 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1395,8 +1395,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct page *page)
 	page_mapcount_reset(page);
 	page->mapping = NULL;
 
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += 1 << order;
+	current_reclaim_account_pages(1 << order);
 	uncharge_slab_page(page, order, cachep);
 	__free_pages(page, order);
 }
diff --git a/mm/slob.c b/mm/slob.c
index fa53e9f73893..c54a7eeee86d 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -211,9 +211,7 @@ static void slob_free_pages(void *b, int order)
 {
 	struct page *sp = virt_to_page(b);
 
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += 1 << order;
-
+	current_reclaim_account_pages(1 << order);
 	mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE,
 			    -(1 << order));
 	__free_pages(sp, order);
diff --git a/mm/slub.c b/mm/slub.c
index 3d63ae320d31..c79122dd9452 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1746,8 +1746,7 @@ static void __free_slab(struct kmem_cache *s, struct page *page)
 	__ClearPageSlab(page);
 
 	page->mapping = NULL;
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += pages;
+	current_reclaim_account_pages(pages);
 	uncharge_slab_page(page, order, s);
 	__free_pages(page, order);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 65093dd89dd7..feea179bcb67 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2872,8 +2872,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
 
 		if (reclaim_state) {
-			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
-			reclaim_state->reclaimed_slab = 0;
+			sc->nr_reclaimed += reclaim_state->reclaimed_pages;
+			reclaim_state->reclaimed_pages = 0;
 		}
 
 		/* Record the subtree's reclaim efficiency */
-- 
2.23.0.rc1

