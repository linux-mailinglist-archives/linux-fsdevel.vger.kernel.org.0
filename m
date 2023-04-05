Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B7E6D865A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 20:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjDESyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 14:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjDESyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:54:38 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4E561B6
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 11:54:33 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a6-20020aa795a6000000b006262c174d64so16443433pfk.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Apr 2023 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680720873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yIEsCxGxp+Goi3FcKFGmOxdWE8VaKQI4GXE/OXZVyU=;
        b=TF78184WybJytfdYm4GCjpWzSx4mUisBexI8bJfnyd6K4JeOX369L2ClHVn4Ys8I7V
         JV+y1m7UAB4SCcuHTJGFIgQF6+zPgKdblexEZW4hF8aKIUP946k53euPlWdSC0diJGII
         +4BQZqOlikwwOc1ffTqbrRHhEVpr3wXhWZ0WF/Lu4nUjgmKclpwmru3gluXbSweQuK7W
         C3JM5wV7WTynZX48f/Lp4lcdapj5Vg97KMACQe2OSnlckxh/DO5uCHLUHH1nrwiXFUnK
         JKlKgk5qWcBAj572MmVExUzKlzT1AeS/W+Ao4ZB3tIG21TaLoaVVgW0UNpmmTPc769jm
         okiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680720873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yIEsCxGxp+Goi3FcKFGmOxdWE8VaKQI4GXE/OXZVyU=;
        b=09EvEu5Y7d5/aNHL9WvDZ1d5bvOrX+xsBYVtQ1cjsrPj2CvNEegZVtjJucR0L6YUWU
         oeX/00p++2vQ7mscJssU4Mk2pa0ZEnBSybp6bWCliHAG128429dTUSW8yrwjeAZngKDF
         M0YsnePdRl6TS53NqWo5aYxZqAj634YD7afXBXEY+RloTYcAh1VnclAh6y8E8JNCsuxW
         jumot2tBYx4vreQLrx8DLwsJuRiABX6TRzrKrX+IN2zL9WPS7XDGu5Xxy4Rdyk2HtDqO
         cru7Qe+gIQvXwS/jmV+0HWrvXVhP1aEbq624+z4kJGANNvWhGYbP3MIWm4XAmwRynvN5
         0vcQ==
X-Gm-Message-State: AAQBX9fpYri0yZI3lfef+4PIN2T8wePqL3IujIAzO0ITLukCETH29U/D
        bNYFNHCXjKvy3soupkZsdtQGMA9r/uQg1zRY
X-Google-Smtp-Source: AKy350acXJNtGWroYsn6aFMZG+1teLm2kBpgOPT0A7iZ6zD9rHb+p4s9om4KF91yo2bhBQ0j07DSjkYPZ7RoOPdC
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:2da6:b0:625:ccea:1627 with
 SMTP id fb38-20020a056a002da600b00625ccea1627mr3896876pfb.5.1680720873145;
 Wed, 05 Apr 2023 11:54:33 -0700 (PDT)
Date:   Wed,  5 Apr 2023 18:54:27 +0000
In-Reply-To: <20230405185427.1246289-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230405185427.1246289-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230405185427.1246289-3-yosryahmed@google.com>
Subject: [PATCH v5 2/2] mm: vmscan: refactor reclaim_state helpers
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During reclaim, we keep track of pages reclaimed from other means than
LRU-based reclaim through scan_control->reclaim_state->reclaimed_slab,
which we stash a pointer to in current task_struct.

However, we keep track of more than just reclaimed slab pages through
this. We also use it for clean file pages dropped through pruned inodes,
and xfs buffer pages freed. Rename reclaimed_slab to reclaimed, and add
a helper function that wraps updating it through current, so that future
changes to this logic are contained within mm/vmscan.c.

Additionally, add a flush_reclaim_state() helper to wrap using
reclaim_state->reclaimed to updated sc->nr_reclaimed, and use that
helper to add an elaborate comment about why we only do the update for
global reclaim.

Finally, move set_task_reclaim_state() next to flush_reclaim_state() so
that all reclaim_state helpers are in close proximity for easier
readability.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 fs/inode.c           |  3 +-
 fs/xfs/xfs_buf.c     |  3 +-
 include/linux/swap.h | 17 +++++++++-
 mm/slab.c            |  3 +-
 mm/slob.c            |  6 ++--
 mm/slub.c            |  5 ++-
 mm/vmscan.c          | 75 ++++++++++++++++++++++++++++++++------------
 7 files changed, 78 insertions(+), 34 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4558dc2f13557..e60fcc41faf17 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -864,8 +864,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 				__count_vm_events(KSWAPD_INODESTEAL, reap);
 			else
 				__count_vm_events(PGINODESTEAL, reap);
-			if (current->reclaim_state)
-				current->reclaim_state->reclaimed_slab += reap;
+			mm_account_reclaimed_pages(reap);
 		}
 		iput(inode);
 		spin_lock(lru_lock);
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 54c774af6e1c6..15d1e5a7c2d34 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -286,8 +286,7 @@ xfs_buf_free_pages(
 		if (bp->b_pages[i])
 			__free_page(bp->b_pages[i]);
 	}
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += bp->b_page_count;
+	mm_account_reclaimed_pages(bp->b_page_count);
 
 	if (bp->b_pages != bp->b_page_array)
 		kmem_free(bp->b_pages);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 209a425739a9f..e131ac155fb95 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -153,13 +153,28 @@ union swap_header {
  * memory reclaim
  */
 struct reclaim_state {
-	unsigned long reclaimed_slab;
+	/* pages reclaimed outside of LRU-based reclaim */
+	unsigned long reclaimed;
 #ifdef CONFIG_LRU_GEN
 	/* per-thread mm walk data */
 	struct lru_gen_mm_walk *mm_walk;
 #endif
 };
 
+/*
+ * mm_account_reclaimed_pages(): account reclaimed pages outside of LRU-based
+ * reclaim
+ * @pages: number of pages reclaimed
+ *
+ * If the current process is undergoing a reclaim operation, increment the
+ * number of reclaimed pages by @pages.
+ */
+static inline void mm_account_reclaimed_pages(unsigned long pages)
+{
+	if (current->reclaim_state)
+		current->reclaim_state->reclaimed += pages;
+}
+
 #ifdef __KERNEL__
 
 struct address_space;
diff --git a/mm/slab.c b/mm/slab.c
index dabc2a671fc6f..64bf1de817b24 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1392,8 +1392,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
 	smp_wmb();
 	__folio_clear_slab(folio);
 
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += 1 << order;
+	mm_account_reclaimed_pages(1 << order);
 	unaccount_slab(slab, order, cachep);
 	__free_pages(&folio->page, order);
 }
diff --git a/mm/slob.c b/mm/slob.c
index fe567fcfa3a39..79cc8680c973c 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -61,7 +61,7 @@
 #include <linux/slab.h>
 
 #include <linux/mm.h>
-#include <linux/swap.h> /* struct reclaim_state */
+#include <linux/swap.h> /* mm_account_reclaimed_pages() */
 #include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/export.h>
@@ -211,9 +211,7 @@ static void slob_free_pages(void *b, int order)
 {
 	struct page *sp = virt_to_page(b);
 
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += 1 << order;
-
+	mm_account_reclaimed_pages(1 << order);
 	mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
 			    -(PAGE_SIZE << order));
 	__free_pages(sp, order);
diff --git a/mm/slub.c b/mm/slub.c
index 39327e98fce34..7aa30eef82350 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -11,7 +11,7 @@
  */
 
 #include <linux/mm.h>
-#include <linux/swap.h> /* struct reclaim_state */
+#include <linux/swap.h> /* mm_account_reclaimed_pages() */
 #include <linux/module.h>
 #include <linux/bit_spinlock.h>
 #include <linux/interrupt.h>
@@ -2063,8 +2063,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	/* Make the mapping reset visible before clearing the flag */
 	smp_wmb();
 	__folio_clear_slab(folio);
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += pages;
+	mm_account_reclaimed_pages(pages);
 	unaccount_slab(slab, order, s);
 	__free_pages(&folio->page, order);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c82bd89f90364..049e39202e6ce 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -188,18 +188,6 @@ struct scan_control {
  */
 int vm_swappiness = 60;
 
-static void set_task_reclaim_state(struct task_struct *task,
-				   struct reclaim_state *rs)
-{
-	/* Check for an overwrite */
-	WARN_ON_ONCE(rs && task->reclaim_state);
-
-	/* Check for the nulling of an already-nulled member */
-	WARN_ON_ONCE(!rs && !task->reclaim_state);
-
-	task->reclaim_state = rs;
-}
-
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
 
@@ -511,6 +499,59 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 }
 #endif
 
+static void set_task_reclaim_state(struct task_struct *task,
+				   struct reclaim_state *rs)
+{
+	/* Check for an overwrite */
+	WARN_ON_ONCE(rs && task->reclaim_state);
+
+	/* Check for the nulling of an already-nulled member */
+	WARN_ON_ONCE(!rs && !task->reclaim_state);
+
+	task->reclaim_state = rs;
+}
+
+/*
+ * flush_reclaim_state(): add pages reclaimed outside of LRU-based reclaim to
+ * scan_control->nr_reclaimed.
+ */
+static void flush_reclaim_state(struct scan_control *sc,
+				struct reclaim_state *rs)
+{
+	/*
+	 * Currently, reclaim_state->reclaimed includes three types of pages
+	 * freed outside of vmscan:
+	 * (1) Slab pages.
+	 * (2) Clean file pages from pruned inodes.
+	 * (3) XFS freed buffer pages.
+	 *
+	 * For all of these cases, we have no way of finding out whether these
+	 * pages were related to the memcg under reclaim. For example, a freed
+	 * slab page could have had only a single object charged to the memcg
+	 * under reclaim. Also, populated inodes are not on shrinker LRUs
+	 * anymore except on highmem systems.
+	 *
+	 * Instead of over-reporting the reclaimed pages in a memcg reclaim,
+	 * only count such pages in global reclaim. This prevents unnecessary
+	 * retries during memcg charging and false positive from proactive
+	 * reclaim (memory.reclaim).
+	 *
+	 * For uncommon cases were the freed pages were actually significantly
+	 * charged to the memcg under reclaim, and we end up under-reporting, it
+	 * should be fine. The freed pages will be uncharged anyway, even if
+	 * they are not reported properly, and we will be able to make forward
+	 * progress in charging (which is usually in a retry loop).
+	 *
+	 * We can go one step further, and report the uncharged objcg pages in
+	 * memcg reclaim, to make reporting more accurate and reduce
+	 * under-reporting, but it's probably not worth the complexity for now.
+	 */
+	if (rs && global_reclaim(sc)) {
+		sc->nr_reclaimed += rs->reclaimed;
+		rs->reclaimed = 0;
+	}
+}
+
 static long xchg_nr_deferred(struct shrinker *shrinker,
 			     struct shrink_control *sc)
 {
@@ -5346,10 +5387,7 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
 			   sc->nr_reclaimed - reclaimed);
 
-	if (global_reclaim(sc)) {
-		sc->nr_reclaimed += current->reclaim_state->reclaimed_slab;
-		current->reclaim_state->reclaimed_slab = 0;
-	}
+	flush_reclaim_state(sc, current->reclaim_state);
 
 	return success ? MEMCG_LRU_YOUNG : 0;
 }
@@ -6474,10 +6512,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	shrink_node_memcgs(pgdat, sc);
 
-	if (reclaim_state && global_reclaim(sc)) {
-		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
-		reclaim_state->reclaimed_slab = 0;
-	}
+	flush_reclaim_state(sc, reclaim_state);
 
 	/* Record the subtree's reclaim efficiency */
 	if (!sc->proactive)
-- 
2.40.0.348.gf938b09366-goog

