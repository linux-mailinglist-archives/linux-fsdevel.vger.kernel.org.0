Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BF46A54BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 09:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjB1IuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 03:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjB1IuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:50:16 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B45193DA
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 00:50:08 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x63-20020a17090a6c4500b00237731465feso2704276pjj.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 00:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677574208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgJC52QM6QqWzETYUfTKUV+TRKWCtnTb99Tc/z4xtcc=;
        b=QpsaKClBM6T/l157IH+7qI9Rdj6857P2of63Qy25b1ULux6HWBa7tPwczUKR822sQm
         Jtu4ES6VL+1NRykXmz5aiv4K55zgEU1gyffkFKfifRDKyIBnA0uJ1jjdMSq3yLorLuby
         A7J9nOJUGetgqw5d1Alpv1sY4oIyc7bWZD02dBipyIYqxTGJWAjh1Aoxhy0vJ4ZuLYiU
         ZcI+vNG4fis3fO4Q1DKAztlEJeJR69f7liSjn2WRt9qFaSe5iB8T7zMWLuiVof/9K0MV
         SOrTQToIej9jdyCvxdFzm7JPtyyAS6uRvP9Ms6dFChBa7ZvjPPagDLqcGbXyvNXqmUa6
         KqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677574208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgJC52QM6QqWzETYUfTKUV+TRKWCtnTb99Tc/z4xtcc=;
        b=YhkmMpu4prleUf3Or+aiRFHAgHTg4bKQuATpi9t4ivPFbFj1EPrs6uOeAqU8baitlW
         9pz2l+AS3GtpmBR74zhBXYRIgbdi52IzbHevztcFoES9Qc/A1uv1r2DBSqX0xMUqtmoR
         916zKrxL/INWaUJ5au3zVNqgAkWp7lVTBVnpItIWDKAliBjJLNQP/s/Pf81dWR03ZxEe
         y7z+Bp99oD/UzID9CenArwaxIv4oa/ObSWN+uh9A8Cv11TcVJ7IC+I4SQPC4RANIaYhC
         X3C+652w6L7V9qFBSTgfwDz1Pn92p1sDaH+4OD14cRE+SR4m/HccVFejjNz2yj5YkFk8
         hZ/g==
X-Gm-Message-State: AO0yUKUNeCs3oYfGHqRKNpgB4TICXJ+dx0wEv5fdnbyItxpcYwBzn9os
        1SswP6n11uUObYDWvCU1N2+VvxqnKl2d5o6z
X-Google-Smtp-Source: AK7set8t0cooG+i7Em12R7p9gzkWi0x9flCtehwMdDtbP+QKpSIaBR21aL7xJpXfLxb2tbubY3iK1iSuvetMpUhV
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:b21b:0:b0:502:f4c6:3992 with SMTP
 id x27-20020a63b21b000000b00502f4c63992mr521403pge.4.1677574207767; Tue, 28
 Feb 2023 00:50:07 -0800 (PST)
Date:   Tue, 28 Feb 2023 08:50:01 +0000
In-Reply-To: <20230228085002.2592473-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230228085002.2592473-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230228085002.2592473-2-yosryahmed@google.com>
Subject: [PATCH v1 1/2] mm: vmscan: refactor updating reclaimed pages in reclaim_state
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
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
a helper function that wraps updating it through current.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 fs/inode.c           |  3 +--
 fs/xfs/xfs_buf.c     |  3 +--
 include/linux/swap.h |  5 ++++-
 mm/slab.c            |  3 +--
 mm/slob.c            |  6 ++----
 mm/slub.c            |  5 ++---
 mm/vmscan.c          | 31 +++++++++++++++++++++++++------
 7 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4558dc2f1355..1022d8ac7205 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -864,8 +864,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 				__count_vm_events(KSWAPD_INODESTEAL, reap);
 			else
 				__count_vm_events(PGINODESTEAL, reap);
-			if (current->reclaim_state)
-				current->reclaim_state->reclaimed_slab += reap;
+			report_freed_pages(reap);
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
index 209a425739a9..525f0ae442f9 100644
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
 
+void report_freed_pages(unsigned long pages);
+
 #ifdef __KERNEL__
 
 struct address_space;
diff --git a/mm/slab.c b/mm/slab.c
index dabc2a671fc6..325634416aab 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1392,8 +1392,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
 	smp_wmb();
 	__folio_clear_slab(folio);
 
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += 1 << order;
+	report_freed_pages(1 << order);
 	unaccount_slab(slab, order, cachep);
 	__free_pages(&folio->page, order);
 }
diff --git a/mm/slob.c b/mm/slob.c
index fe567fcfa3a3..71ee00e9dd46 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -61,7 +61,7 @@
 #include <linux/slab.h>
 
 #include <linux/mm.h>
-#include <linux/swap.h> /* struct reclaim_state */
+#include <linux/swap.h> /* report_freed_pages() */
 #include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/export.h>
@@ -211,9 +211,7 @@ static void slob_free_pages(void *b, int order)
 {
 	struct page *sp = virt_to_page(b);
 
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += 1 << order;
-
+	report_freed_pages(1 << order);
 	mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
 			    -(PAGE_SIZE << order));
 	__free_pages(sp, order);
diff --git a/mm/slub.c b/mm/slub.c
index 39327e98fce3..165319bf11f1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -11,7 +11,7 @@
  */
 
 #include <linux/mm.h>
-#include <linux/swap.h> /* struct reclaim_state */
+#include <linux/swap.h> /* report_freed_pages() */
 #include <linux/module.h>
 #include <linux/bit_spinlock.h>
 #include <linux/interrupt.h>
@@ -2063,8 +2063,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	/* Make the mapping reset visible before clearing the flag */
 	smp_wmb();
 	__folio_clear_slab(folio);
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += pages;
+	report_freed_pages(pages);
 	unaccount_slab(slab, order, s);
 	__free_pages(&folio->page, order);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c1c5e8b24b8..8846531e85a4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -200,6 +200,29 @@ static void set_task_reclaim_state(struct task_struct *task,
 	task->reclaim_state = rs;
 }
 
+/*
+ * reclaim_report_freed_pages: report pages freed outside of LRU-based reclaim
+ * @pages: number of pages freed
+ *
+ * If the current process is undergoing a reclaim operation,
+ * increment the number of reclaimed pages by @pages.
+ */
+void report_freed_pages(unsigned long pages)
+{
+	if (current->reclaim_state)
+		current->reclaim_state->reclaimed += pages;
+}
+EXPORT_SYMBOL(report_freed_pages);
+
+static void add_non_vmscan_reclaimed(struct scan_control *sc,
+				     struct reclaim_state *rs)
+{
+	if (rs) {
+		sc->nr_reclaimed += rs->reclaimed;
+		rs->reclaimed = 0;
+	}
+}
+
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
 
@@ -5346,8 +5369,7 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
 			   sc->nr_reclaimed - reclaimed);
 
-	sc->nr_reclaimed += current->reclaim_state->reclaimed_slab;
-	current->reclaim_state->reclaimed_slab = 0;
+	add_non_vmscan_reclaimed(sc, current->reclaim_state);
 
 	return success ? MEMCG_LRU_YOUNG : 0;
 }
@@ -6472,10 +6494,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	shrink_node_memcgs(pgdat, sc);
 
-	if (reclaim_state) {
-		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
-		reclaim_state->reclaimed_slab = 0;
-	}
+	add_non_vmscan_reclaimed(sc, reclaim_state);
 
 	/* Record the subtree's reclaim efficiency */
 	if (!sc->proactive)
-- 
2.39.2.722.g9855ee24e9-goog

