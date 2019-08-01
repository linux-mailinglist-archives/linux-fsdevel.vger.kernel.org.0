Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55C67D333
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfHACSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:21 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:33331 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729026AbfHACSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:10 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5634843ECAA;
        Thu,  1 Aug 2019 12:17:58 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eA-0003aY-Se; Thu, 01 Aug 2019 12:16:50 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fG-0001ko-QX; Thu, 01 Aug 2019 12:17:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/24] mm: reclaim_state records pages reclaimed, not slabs
Date:   Thu,  1 Aug 2019 12:17:34 +1000
Message-Id: <20190801021752.4986-7-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=pP-XxJAliQGaY3BKeNcA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Name change only, no logic changes.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/inode.c           | 2 +-
 include/linux/swap.h | 5 +++--
 mm/slab.c            | 2 +-
 mm/slob.c            | 2 +-
 mm/slub.c            | 2 +-
 mm/vmscan.c          | 4 ++--
 6 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 0f1e3b563c47..8c70f0643218 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -762,7 +762,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 			else
 				__count_vm_events(PGINODESTEAL, reap);
 			if (current->reclaim_state)
-				current->reclaim_state->reclaimed_slab += reap;
+				current->reclaim_state->reclaimed_pages += reap;
 		}
 		iput(inode);
 		spin_lock(lru_lock);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index de2c67a33b7e..978e6cd5c05a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -126,10 +126,11 @@ union swap_header {
 
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
 
 #ifdef __KERNEL__
diff --git a/mm/slab.c b/mm/slab.c
index 9df370558e5d..abc97e340f6d 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1396,7 +1396,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct page *page)
 	page->mapping = NULL;
 
 	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += 1 << order;
+		current->reclaim_state->reclaimed_pages += 1 << order;
 	uncharge_slab_page(page, order, cachep);
 	__free_pages(page, order);
 }
diff --git a/mm/slob.c b/mm/slob.c
index 7f421d0ca9ab..c46ce297805e 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -208,7 +208,7 @@ static void *slob_new_pages(gfp_t gfp, int order, int node)
 static void slob_free_pages(void *b, int order)
 {
 	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += 1 << order;
+		current->reclaim_state->reclaimed_pages += 1 << order;
 	free_pages((unsigned long)b, order);
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index e6c030e47364..a3e4bc62383b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1743,7 +1743,7 @@ static void __free_slab(struct kmem_cache *s, struct page *page)
 
 	page->mapping = NULL;
 	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += pages;
+		current->reclaim_state->reclaimed_pages += pages;
 	uncharge_slab_page(page, order, s);
 	__free_pages(page, order);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d5ce26b4d49d..231ddcfcd046 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2765,8 +2765,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
 
 		if (reclaim_state) {
-			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
-			reclaim_state->reclaimed_slab = 0;
+			sc->nr_reclaimed += reclaim_state->reclaimed_pages;
+			reclaim_state->reclaimed_pages = 0;
 		}
 
 		/* Record the subtree's reclaim efficiency */
-- 
2.22.0

