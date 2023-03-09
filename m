Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BFC6B2018
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjCIJbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjCIJbd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:31:33 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8C4A1FE9
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 01:31:31 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id h1-20020a62de01000000b005d943b97706so950307pfg.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Mar 2023 01:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678354291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h6SnRTgbJt8uctknxsPWdjBgy9HatQBYNy5scoYuFng=;
        b=BIspgDfgpDn4bkLxtBabsOU9Uhv4DiqHmpsyEYFdYYQOsugC1O3FyPc6aDReE1SUAN
         5uV0uFO+sQlWKI/40WV3HZDPsDyksERJrVxwFRis6lKh0WsNGujWmErL0jVg9DFJ7Sxd
         IuVjwB/VEOvIqca+ISasnf6kTvYtPtyS5xSUuEuv0nl1KwuTEi21GUVG3fYoJYL/P/IC
         HyKUQOiXj+7FJ83bqgaNXvvsRkza48cZcoJSntHuv6rgRw6VPmYf64OIgEh4BzpyXPFS
         xbI1nWERtwBhK1R2RwjpugpOVd7LTuQKHDFNUS6dv8MWFgB5hNM2IG1rMMNwqORxP1qi
         hAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6SnRTgbJt8uctknxsPWdjBgy9HatQBYNy5scoYuFng=;
        b=LJfdvZ0w4pwiJcUSrPV3TXGbTo28gZuyOHruLVFa63WfJzpoPga/nfAPXkAgFqHgx/
         iv8XxxFsNF5Wbyn9xnitV693Ks7rv8mqcm3DmsJWWMePrSxdGF0tinEW2s1Ng4I7rrjW
         oLPMWwoOoDmfgmRcNLO7nHf1vxxl3sP2cSXNdj3eqCcT1pUrTzfwFGmBk9KDu9YB7KwO
         FEbhw4F2GrBPDhiskdIzreiz5/mszcA6X08mgy9tXqykV2M/JJublOyNIFuBD0l/5Nvc
         iSH+dyMgJEOdWp+bh3mVwV/xoV96/7RxcPEXZBPybiPFoC5juqTkQEsG2sJKfIywngRG
         SHdw==
X-Gm-Message-State: AO0yUKWN2gJTWqjzyLfs2K3hXWs0uBzz41oribIFqohGh+siNNatEYCu
        nI70B/XS71RneEq5p4+nQHPMDzYjaeG9ys9x
X-Google-Smtp-Source: AK7set/xvyeflSxZY0dqmtHjFakw/c6fvI1rhtdCuvGq7DrJIicLLxLjDK/zNls11ytQyWAWIJilVYP0U74iRmT+
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:ef8a:b0:19a:9434:af24 with SMTP
 id iz10-20020a170902ef8a00b0019a9434af24mr8176829plb.10.1678354291238; Thu,
 09 Mar 2023 01:31:31 -0800 (PST)
Date:   Thu,  9 Mar 2023 09:31:08 +0000
In-Reply-To: <20230309093109.3039327-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230309093109.3039327-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230309093109.3039327-3-yosryahmed@google.com>
Subject: [PATCH v2 2/3] mm: vmscan: refactor updating reclaimed pages in reclaim_state
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
 include/linux/swap.h |  5 ++++-
 mm/slab.c            |  3 +--
 mm/slob.c            |  6 ++----
 mm/slub.c            |  5 ++---
 mm/vmscan.c          | 36 ++++++++++++++++++++++++++++++------
 7 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4558dc2f1355..e60fcc41faf1 100644
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
index 54c774af6e1c..060079f1e966 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -286,8 +286,7 @@ xfs_buf_free_pages(
 		if (bp->b_pages[i])
 			__free_page(bp->b_pages[i]);
 	}
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += bp->b_page_count;
+	report_freed_pages(bp->b_page_count);
 
 	if (bp->b_pages != bp->b_page_array)
 		kmem_free(bp->b_pages);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 209a425739a9..589ea2731931 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -153,13 +153,16 @@ union swap_header {
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
 
+void mm_account_reclaimed_pages(unsigned long pages);
+
 #ifdef __KERNEL__
 
 struct address_space;
diff --git a/mm/slab.c b/mm/slab.c
index dabc2a671fc6..64bf1de817b2 100644
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
index fe567fcfa3a3..79cc8680c973 100644
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
index 39327e98fce3..7aa30eef8235 100644
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
index fef7d1c0f82b..a3e38851b34a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -511,6 +511,34 @@ static void set_task_reclaim_state(struct task_struct *task,
 	task->reclaim_state = rs;
 }
 
+/*
+ * mm_account_reclaimed_pages(): account reclaimed pages outside of LRU-based
+ * reclaim
+ * @pages: number of pages reclaimed
+ *
+ * If the current process is undergoing a reclaim operation, increment the
+ * number of reclaimed pages by @pages.
+ */
+void mm_account_reclaimed_pages(unsigned long pages)
+{
+	if (current->reclaim_state)
+		current->reclaim_state->reclaimed += pages;
+}
+EXPORT_SYMBOL(mm_account_reclaimed_pages);
+
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
@@ -5346,8 +5374,7 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
 			   sc->nr_reclaimed - reclaimed);
 
-	sc->nr_reclaimed += current->reclaim_state->reclaimed_slab;
-	current->reclaim_state->reclaimed_slab = 0;
+	flush_reclaim_state(sc, current->reclaim_state);
 
 	return success ? MEMCG_LRU_YOUNG : 0;
 }
@@ -6472,10 +6499,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	shrink_node_memcgs(pgdat, sc);
 
-	if (reclaim_state) {
-		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
-		reclaim_state->reclaimed_slab = 0;
-	}
+	flush_reclaim_state(sc, reclaim_state);
 
 	/* Record the subtree's reclaim efficiency */
 	if (!sc->proactive)
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

