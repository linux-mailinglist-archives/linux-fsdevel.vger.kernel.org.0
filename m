Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FB06E0B91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 12:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjDMKlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 06:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjDMKko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:40:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07032D67
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 03:40:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h206-20020a2521d7000000b00b8f3681db1eso5584150ybh.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681382442; x=1683974442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5OCAYSthWCELWDD+mYmXa9NvWHtbEH3UT/IFpudVmH4=;
        b=tNgjpd2vJ5sYdihexJ27wp/pJdtBdkGoDWlKPI+Qxip+uc94atiC4v8qSoBRSDpXnF
         2H1eFR4AE43zDnf3vSAC6PM4Yzv5eOl4FnSZ87ySrNsQr00bC+1pP0q2NisEbs11XCfK
         wfmIAOuWTU7ukaHpLHwHLoguS2c0haEBvsc03OpVoC1wgoCMAvA/kO8UJucX9FKOKJPQ
         FUpRKC72wJ0M5aFsenyPyMH3rc7A+TUAdQgnGrgJs85bN23klJx4wsrqR1AZvj2NJaOn
         RSlnCkB73DeUMUXx2hJ8njcRovku/drtS2o23klZqkp9a4zr1WrXp8WQJA7orQxM0t6d
         M7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681382442; x=1683974442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OCAYSthWCELWDD+mYmXa9NvWHtbEH3UT/IFpudVmH4=;
        b=GoiML+huCx6bDtWZqWUv8VMN+hj4jPC2l6PI5sDI3cNj9yjSRrHwEODs14RvrJczM2
         zrRiVufsUyQ5831iCpfj6MEOAFKhACykscS1AislAylBpP8jl5/Sf2yucKr2F/mFO+JH
         v+jpazR3z6V0BN2SHYoNuhhF7MZFCv5TPSKNjgkWCn9tp1huR0FaBCJPJhow/sq/em26
         UB8pDCvP0HtzDwFBBSWyUiFPynxosvF2EoDIQ4ThrOsC4l06mmkI5lSRc9CEZpRFFjIk
         VHrKe+M4b+GBuLwB7CQ5vVsUNIcxbe/CtBnbexoEwWh3pSt9VL7bj2vE38JvuoBc6ePg
         q7PA==
X-Gm-Message-State: AAQBX9fLY5YWoaaJdhXZazyEZlUlBf9a0tD77reeQMlyQVnP+AeLM/di
        NyHEp22u70kp1XZvPaOZdH6A9jMU1SmyFjtJ
X-Google-Smtp-Source: AKy350ato23F52bhKncBfpzqlbDSBjiTYHoOr/++AUIP1InXFnH0R1Cd3N+S/780qX9+qoWZd0rLQvVMvNIOlXzG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:dad2:0:b0:ac9:cb97:bd0e with SMTP
 id n201-20020a25dad2000000b00ac9cb97bd0emr904171ybf.5.1681382442136; Thu, 13
 Apr 2023 03:40:42 -0700 (PDT)
Date:   Thu, 13 Apr 2023 10:40:34 +0000
In-Reply-To: <20230413104034.1086717-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230413104034.1086717-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230413104034.1086717-4-yosryahmed@google.com>
Subject: [PATCH v6 3/3] mm: vmscan: refactor updating current->reclaim_state
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
        Dave Chinner <david@fromorbit.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
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
a helper function that wraps updating it through current, so that future
changes to this logic are contained within include/linux/swap.h.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 fs/inode.c           |  3 +--
 fs/xfs/xfs_buf.c     |  3 +--
 include/linux/swap.h | 17 ++++++++++++++++-
 mm/slab.c            |  3 +--
 mm/slob.c            |  6 ++----
 mm/slub.c            |  5 ++---
 6 files changed, 23 insertions(+), 14 deletions(-)

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
index 54c774af6e1c..15d1e5a7c2d3 100644
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
index 209a425739a9..e131ac155fb9 100644
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
-- 
2.40.0.577.gac1e443424-goog

