Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BDB688AD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 00:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjBBXci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 18:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjBBXch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:32:37 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0269C67F
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Feb 2023 15:32:35 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id g5-20020a62e305000000b00593dc84b678so1676556pfh.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Feb 2023 15:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMfzYGpjLscA+cSHKjv+qODVcyrrlHVghJg0aaO0KBk=;
        b=OvrbEiCpGPYcK17eFl9Y8Nb0T74F1qeKRRPkLoOMDwdi/dRXxR6NuAQjAW9zXsUR0O
         NeVP3CBQfbmSZRDn3VjHms7iVR+lkrD9000HVofhlapWdM0H6OVWwh++RAm98vZ+5dhx
         bufiNX/dvrtyw3cumBPhgl4x+7y0E+G53ahhpnQuHNJSZ5luwRgX/jLAWcgel9dI3QjA
         SRu0TbgVgGpsoeFXfGAVryIKlsdRcV06r0T1Ttoz+3041WIcgTRlSdDg+usnZ1TMOPDz
         Rf9IFZN9Y+yLtQ9bRc+UBoG9YZg5Aztk+JWK5oqw6+zVPOqc/gIiW520ZtukWzKTIrxg
         lJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMfzYGpjLscA+cSHKjv+qODVcyrrlHVghJg0aaO0KBk=;
        b=waJftKV62WK1NrJ18SCbT6xdXvo1Sq3/ZaucPN87eNxF876RO/VmsoYq2M568+MQiG
         f4Tn3u4cbzgbGDkRJCiG+LP6R6CD+FMLdc63IZMg112BhSjCNvM07QmwVZhYqL0eNvmT
         hL8mxEYiyMswC1P7on9Wx1jchNEYUTFdrKHne+veWaeHnk+O0TQ9TD3lta8gotd/hvnz
         7YcmV6TtohfKTGTOu5daxzsHqbA1YXKR/v6zGmrEZbon0txlyIo3Eh/WzgdjRxW60B7k
         8Nzob13QXQ/PW35u6H/IVE8embjnn58wnY2RjVBYVEMoAUx55iJmWQuv0iHl8nDDvAo7
         ZY6w==
X-Gm-Message-State: AO0yUKUmqChx56JmfEEeA0Ojo2L66jYI1ph7HJmllEUQxZfi4/dzRIun
        09G1C6PfTl2R0wbxNYXwCVpKXBPKNlNALaMT
X-Google-Smtp-Source: AK7set9GQneKggPkDbKmlHsZPDxNqqKNqpt3nFbEgf1JtVVy4xckZ6axh9mOcnrxgc0XPi+3Fc6kG5az9ihIBd8Y
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:7f93:b0:22c:aacd:86c5 with SMTP
 id m19-20020a17090a7f9300b0022caacd86c5mr992815pjl.76.1675380755306; Thu, 02
 Feb 2023 15:32:35 -0800 (PST)
Date:   Thu,  2 Feb 2023 23:32:28 +0000
In-Reply-To: <20230202233229.3895713-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230202233229.3895713-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202233229.3895713-2-yosryahmed@google.com>
Subject: [RFC PATCH v1 1/2] mm: vmscan: refactor updating reclaimed pages in reclaim_state
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
 mm/vmscan.c          | 17 +++++++++++++++--
 7 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f453eb58fd03..adf0a7725054 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -863,8 +863,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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
index 2787b84eaf12..bc1d8b326453 100644
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
index 29300fc1289a..452db5913356 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1395,8 +1395,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
 	smp_wmb();
 	__folio_clear_slab(folio);
 
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += 1 << order;
+	report_freed_pages(1 << order);
 	unaccount_slab(slab, order, cachep);
 	__free_pages(folio_page(folio, 0), order);
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
index 13459c69095a..5145ad2467e9 100644
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
 	__free_pages(folio_page(folio, 0), order);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd6637fcd8f9..63a27d2f6f31 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -204,6 +204,19 @@ static void set_task_reclaim_state(struct task_struct *task,
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
+
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
 
@@ -6169,8 +6182,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	shrink_node_memcgs(pgdat, sc);
 
 	if (reclaim_state) {
-		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
-		reclaim_state->reclaimed_slab = 0;
+		sc->nr_reclaimed += reclaim_state->reclaimed;
+		reclaim_state->reclaimed = 0;
 	}
 
 	/* Record the subtree's reclaim efficiency */
-- 
2.39.1.519.gcb327c4b5f-goog

