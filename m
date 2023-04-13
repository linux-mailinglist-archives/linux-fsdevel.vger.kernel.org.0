Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9706A6E0B89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjDMKkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 06:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjDMKkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:40:41 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AAE10EA
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 03:40:39 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id j2-20020a170902da8200b001a055243657so7994521plx.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681382439; x=1683974439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGnocY4pIBEOyCy1J5p5K30k0wCvlbaawbxDP+ACQr8=;
        b=7DaELoYbwDJCrNtZlmfg9Wt1StcR4uFr/DcPD/2pe3cLhlNGHN0Vo/cQ7EdPJo7up0
         8bmCI0JQEmCL566Vot7ySRXaEZ0Q9wHFt3Sh9NvXD+gSBVNkrXxQorzAPrPz3sL21Jvg
         UkLNapMN9bhRXj3lO4/bDPz8UGmnAz0jlApmptNFgfyGVpKdYVctpDwfppNvGRrl4WXx
         hDn5QBpGHzMAOlfKXhd4xxjuLNGoae6rpvwcD9uDypxIntJ4NI1CR6tegrXbWE9t7vA4
         LHSI7L2dX5euMSDWQaeHCt4S6p/b4GKxns2a9UeAtjH7MQxy0QVqfkDsaHQMGS5XAPuo
         907w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681382439; x=1683974439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGnocY4pIBEOyCy1J5p5K30k0wCvlbaawbxDP+ACQr8=;
        b=jklRdoixFu+X7tRVFNFcBoFi33TeCSKpg5d3I8MD3Ds1WEsCo3tvF6Y8Ffj3Skykjv
         sjqf+veFHLB/usx59CvTXiCzEsRn6+sqLqGtzIoKiazSZ84+S0pAIEQqbI+gW0SjT8sq
         6HSI4e11MtmSjWWLQ0NzqNmiRa+mB9FS1mHNIICebcLhua828x9HBVEcZ01L4mjsAgTb
         K/XRe9zD+2QyH1z2ke8HcnrPWQjZzbbM7GOqq/K5cqnoDuz2uEChoeffG85SKGoFyh0F
         meHtBNEWv5zWclICc10/UG+TdemYjQPsV0y28kLWpcS+fUJTS+Jxz14jeQ46Vxjd65k5
         WLfQ==
X-Gm-Message-State: AAQBX9cm8KthU6tCBM9g/9VGCjTZQq7SUO/jaOOihnvgX7K+a0FBMyLS
        Q0UP4B83NaHM66QCDnjplUPoLp6JCwRSC4CB
X-Google-Smtp-Source: AKy350a/CmtWydI2qt+GCIKlEW3m+RGe6OazzLUzw02C2znW4S1CHo0XCY6i4wYnjhyCBrNF8AH/yKwjvGLojZVt
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a65:51c7:0:b0:51a:f873:2645 with SMTP
 id i7-20020a6551c7000000b0051af8732645mr331971pgq.9.1681382438784; Thu, 13
 Apr 2023 03:40:38 -0700 (PDT)
Date:   Thu, 13 Apr 2023 10:40:32 +0000
In-Reply-To: <20230413104034.1086717-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230413104034.1086717-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230413104034.1086717-2-yosryahmed@google.com>
Subject: [PATCH v6 1/3] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
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

We keep track of different types of reclaimed pages through
reclaim_state->reclaimed_slab, and we add them to the reported number
of reclaimed pages.  For non-memcg reclaim, this makes sense. For memcg
reclaim, we have no clue if those pages are charged to the memcg under
reclaim.

Slab pages are shared by different memcgs, so a freed slab page may have
only been partially charged to the memcg under reclaim.  The same goes for
clean file pages from pruned inodes (on highmem systems) or xfs buffer
pages, there is no simple way to currently link them to the memcg under
reclaim.

Stop reporting those freed pages as reclaimed pages during memcg reclaim.
This should make the return value of writing to memory.reclaim, and may
help reduce unnecessary reclaim retries during memcg charging.  Writing to
memory.reclaim on the root memcg is considered as cgroup_reclaim(), but
for this case we want to include any freed pages, so use the
global_reclaim() check instead of !cgroup_reclaim().

Generally, this should make the return value of
try_to_free_mem_cgroup_pages() more accurate. In some limited cases (e.g.
freed a slab page that was mostly charged to the memcg under reclaim),
the return value of try_to_free_mem_cgroup_pages() can be underestimated,
but this should be fine. The freed pages will be uncharged anyway, and we
can charge the memcg the next time around as we usually do memcg reclaim
in a retry loop.

Fixes: f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
instead of pages")

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/vmscan.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c1c5e8b24b8..be657832be48 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -511,6 +511,46 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 }
 #endif
 
+/*
+ * flush_reclaim_state(): add pages reclaimed outside of LRU-based reclaim to
+ * scan_control->nr_reclaimed.
+ */
+static void flush_reclaim_state(struct scan_control *sc)
+{
+	/*
+	 * Currently, reclaim_state->reclaimed includes three types of pages
+	 * freed outside of vmscan:
+	 * (1) Slab pages.
+	 * (2) Clean file pages from pruned inodes (on highmem systems).
+	 * (3) XFS freed buffer pages.
+	 *
+	 * For all of these cases, we cannot universally link the pages to a
+	 * single memcg. For example, a memcg-aware shrinker can free one object
+	 * charged to the target memcg, causing an entire page to be freed.
+	 * If we count the entire page as reclaimed from the memcg, we end up
+	 * overestimating the reclaimed amount (potentially under-reclaiming).
+	 *
+	 * Only count such pages for global reclaim to prevent under-reclaiming
+	 * from the target memcg; preventing unnecessary retries during memcg
+	 * charging and false positives from proactive reclaim.
+	 *
+	 * For uncommon cases where the freed pages were actually mostly
+	 * charged to the target memcg, we end up underestimating the reclaimed
+	 * amount. This should be fine. The freed pages will be uncharged
+	 * anyway, even if they are not counted here properly, and we will be
+	 * able to make forward progress in charging (which is usually in a
+	 * retry loop).
+	 *
+	 * We can go one step further, and report the uncharged objcg pages in
+	 * memcg reclaim, to make reporting more accurate and reduce
+	 * underestimation, but it's probably not worth the complexity for now.
+	 */
+	if (current->reclaim_state && global_reclaim(sc)) {
+		sc->nr_reclaimed += current->reclaim_state->reclaimed;
+		current->reclaim_state->reclaimed = 0;
+	}
+}
+
 static long xchg_nr_deferred(struct shrinker *shrinker,
 			     struct shrink_control *sc)
 {
@@ -5346,8 +5386,7 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
 			   sc->nr_reclaimed - reclaimed);
 
-	sc->nr_reclaimed += current->reclaim_state->reclaimed_slab;
-	current->reclaim_state->reclaimed_slab = 0;
+	flush_reclaim_state(sc);
 
 	return success ? MEMCG_LRU_YOUNG : 0;
 }
@@ -6450,7 +6489,6 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
-	struct reclaim_state *reclaim_state = current->reclaim_state;
 	unsigned long nr_reclaimed, nr_scanned;
 	struct lruvec *target_lruvec;
 	bool reclaimable = false;
@@ -6472,10 +6510,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	shrink_node_memcgs(pgdat, sc);
 
-	if (reclaim_state) {
-		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
-		reclaim_state->reclaimed_slab = 0;
-	}
+	flush_reclaim_state(sc);
 
 	/* Record the subtree's reclaim efficiency */
 	if (!sc->proactive)
-- 
2.40.0.577.gac1e443424-goog

