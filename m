Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598CC6D5572
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 02:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjDDAOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 20:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjDDAOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:14:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87412A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 17:14:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5463f2d3223so133723367b3.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 17:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680567240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KttjkMRwWn+raVJD4pdmRR27zCHPUdxyxHHqMjZ4zso=;
        b=LtYxh8YfdBOctNDOeOLcBvNxi7r6sZaIjGKGM0dSm4YAneG6TwPyrn6ciNpFpw7o05
         agIDp8r5g1zsrBgbrkIAj0istxDrIlFVjEGnPtfdwxO+fsBcrB9rTcH6hnSDhjeSGcI9
         DNWZ+jLmPaIMNrbRgwWvkKyl3KncBlpUe/ySEPbtedlDu2Al/e4kMdIq0CbOxcu1yZTM
         p4hiQCl8bRdPl3Qg3dXxTrvvyXCgzXh5Si+jrlA5hVfiT0NfHjRVSIoyov4AHA/OntzE
         adXxHHHwpx/tQEJ5noRB+DDraQeehxLQoOxrCnjR60/cYEdTl8ijh1e5DVzefIts+Ack
         bxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680567240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KttjkMRwWn+raVJD4pdmRR27zCHPUdxyxHHqMjZ4zso=;
        b=OjFRYwXS+9ZvLMeYGslny1+p7ZrZZRF67IUe4EJsrWYjx6UVOiQ53qWAT8Qu593+38
         XL7kAvCApqW6UuWgMDG+E5lniByk+DfIhcFOLIF1t9UIP40urcQQL++K1Z6uUX2vaZtE
         PE1NzS+WGQChAnwJY/RKtNOP1VLf0pygsLT1xaZ732ch/m8D5ar5p1jHJXvV9b79lcFK
         9hBBm3mHckQGDZ8dxlniy3EiZRQOiDV0h43l5+Ea2zG5xAwszDutMYKURss5UcvytaFj
         nGUpMD2QWrJW9/2G+KCzkx6WzcxLzttvTJczM5SjYezZ/I1+KUqZdYsn/sQoqFUYCTC5
         7efA==
X-Gm-Message-State: AAQBX9eoOmtNT2qllO6jL7qmw35Zd4ErpzPj6C84MPMPQrDVyuERlVWm
        8zsfZ06JFwhGlga0R6EMrSgBC3gxnKR8Hda+
X-Google-Smtp-Source: AKy350aw2fB9OoYuquCgQGUwaaV+x9FcDRGjxrCFXXINr0QvKI17cucoPmiPUl1lnvL0dNkgmm2U7bqUVOt3NxkG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:d950:0:b0:b7d:87f:ce3e with SMTP id
 q77-20020a25d950000000b00b7d087fce3emr663961ybg.6.1680567239851; Mon, 03 Apr
 2023 17:13:59 -0700 (PDT)
Date:   Tue,  4 Apr 2023 00:13:52 +0000
In-Reply-To: <20230404001353.468224-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230404001353.468224-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230404001353.468224-3-yosryahmed@google.com>
Subject: [PATCH v4 2/3] mm: vmscan: refactor updating reclaimed pages in reclaim_state
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

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 fs/inode.c           |  3 +--
 fs/xfs/xfs_buf.c     |  3 +--
 include/linux/swap.h | 17 ++++++++++++++++-
 mm/slab.c            |  3 +--
 mm/slob.c            |  6 ++----
 mm/slub.c            |  5 ++---
 mm/vmscan.c          | 21 +++++++++++++++------
 7 files changed, 38 insertions(+), 20 deletions(-)

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
index fef7d1c0f82b2..8f0e7c4e91ae3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -511,6 +511,19 @@ static void set_task_reclaim_state(struct task_struct *task,
 	task->reclaim_state = rs;
 }
 
+/*
+ * flush_reclaim_state(): add pages reclaimed outside of LRU-based reclaim to
+ * scan_control->nr_reclaimed.
+ */
+static void flush_reclaim_state(struct scan_control *sc,
+				struct reclaim_state *rs)
+{
+	if (rs) {
+		sc->nr_reclaimed += rs->reclaimed;
+		rs->reclaimed = 0;
+	}
+}
+
 static long xchg_nr_deferred(struct shrinker *shrinker,
 			     struct shrink_control *sc)
 {
@@ -5346,8 +5359,7 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
 			   sc->nr_reclaimed - reclaimed);
 
-	sc->nr_reclaimed += current->reclaim_state->reclaimed_slab;
-	current->reclaim_state->reclaimed_slab = 0;
+	flush_reclaim_state(sc, current->reclaim_state);
 
 	return success ? MEMCG_LRU_YOUNG : 0;
 }
@@ -6472,10 +6484,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	shrink_node_memcgs(pgdat, sc);
 
-	if (reclaim_state) {
-		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
-		reclaim_state->reclaimed_slab = 0;
-	}
+	flush_reclaim_state(sc, reclaim_state);
 
 	/* Record the subtree's reclaim efficiency */
 	if (!sc->proactive)
-- 
2.40.0.348.gf938b09366-goog

