Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5B1EBAF8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfJaXrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:47:51 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:40221 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728559AbfJaXqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:32 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 749747EA8F3;
        Fri,  1 Nov 2019 10:46:25 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007CM-FY; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00041p-DJ; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/28] mm: reclaim_state records pages reclaimed, not slabs
Date:   Fri,  1 Nov 2019 10:46:04 +1100
Message-Id: <20191031234618.15403-15-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
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
index d34e5d2edacd..55b082bc53b3 100644
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
index 66e5d8032bae..419be005f41a 100644
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
index b25c807a111f..478554082079 100644
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
index 7a8256322150..967e3d3c7748 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2870,8 +2870,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
 
 		if (reclaim_state) {
-			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
-			reclaim_state->reclaimed_slab = 0;
+			sc->nr_reclaimed += reclaim_state->reclaimed_pages;
+			reclaim_state->reclaimed_pages = 0;
 		}
 
 		/* Record the subtree's reclaim efficiency */
-- 
2.24.0.rc0

