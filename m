Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718246D1821
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 09:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjCaHIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 03:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjCaHI3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:08:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275981115F
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 00:08:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-546422bd3ceso35679617b3.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680246505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVZwB8yF2h7dd4fmRqNpsJbSVI4UBUJ0tNYnQMZkjKk=;
        b=Qvh1jjxMNNvin3fUDDF8N+zZ8dqqA9V78pIPC9J4eiet7qDkXN9KmmYYGJUPeJYaHs
         MKLH6pNXsD05xRQcVpFEEfGwpCvmj99CxoROc64tCepIXuXgVcLXkcyqrZDmsVbfc/un
         7sfS8XWr9MjceXgEsPIOeI1S+8cmvT09eKc373lVeEeUsWXJ702WCHk+gyMUxa0d13mH
         DpL6cgiWqKJVgtXn1VwPDG4acoSGVNKXwkCh7EQWTotbaEfnfpggZPHjxNETB9GJ4f25
         tJPNvYQSCiMrvuPAqeNaMz0m/mU2f6x/6ZvXVSUmCM0sHbOErJEOuuXNLHg8qMP+5e4a
         yxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680246505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVZwB8yF2h7dd4fmRqNpsJbSVI4UBUJ0tNYnQMZkjKk=;
        b=LIcd9AtVnLKDSv/Nw2RW0RGXMIouWKdiZZ82PBn2fdRhm4jO7NUDYp7QyMIEfsAHR5
         JHhD8asNsNtNAaD5e+oGH9rVf7DEguRtmppH8AqtOJXB9H9sW+kf/AD7FqXFhn/vYXHc
         BtK/7/LtKaUC6agT2ItwCGTlQBDcYXowSHU5ewiAyMd5go8HzhnAgba+ScDQ9BrMz7HA
         ppkVH/4nHm85mARflJ0KjrnTE2sl3/Y2OgAFZycbUegnByXq3zpYZtb/aQ8OQKGna++T
         pQN63G0DKt1ci/8qWvklhpv8Jn5F0SCgLhrbDu1+zOW+hjHz+8mnKgbBCzTl4QSeiCc/
         dBnw==
X-Gm-Message-State: AAQBX9ed+FKHoaLPmkOm90pd65EoA1ZqXuAWGIcGJW4lTKqi+JHnt11e
        J8M6i5Y3ayaml7dOgNpIshoVKYgeEipaHZ7J
X-Google-Smtp-Source: AKy350acSxAChLfmqKO9826eoY8acajFCu3SAUOtEMLxv1trgvamSCxttKg1ftNmirCAT6DUp5LYAYXEe4TbOfrd
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:188f:b0:b78:bced:2e3d with
 SMTP id cj15-20020a056902188f00b00b78bced2e3dmr15320634ybb.3.1680246505338;
 Fri, 31 Mar 2023 00:08:25 -0700 (PDT)
Date:   Fri, 31 Mar 2023 07:08:17 +0000
In-Reply-To: <20230331070818.2792558-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230331070818.2792558-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230331070818.2792558-3-yosryahmed@google.com>
Subject: [PATCH v3 2/3] mm: vmscan: refactor updating reclaimed pages in reclaim_state
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
 include/linux/swap.h |  5 ++++-
 mm/slab.c            |  3 +--
 mm/slob.c            |  6 ++----
 mm/slub.c            |  5 ++---
 mm/vmscan.c          | 36 ++++++++++++++++++++++++++++++------
 7 files changed, 41 insertions(+), 20 deletions(-)

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
index 209a425739a9f..589ea2731931f 100644
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
index fef7d1c0f82b2..a3e38851b34ac 100644
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
2.40.0.348.gf938b09366-goog

