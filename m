Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4193E3C6419
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhGLTvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbhGLTvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:51:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C10C0613DD;
        Mon, 12 Jul 2021 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NrDQtj4djFfXw8xNxP1weUzjA286Ja1TcVGDP+T/Mwo=; b=NPSplIuV3eemegUetzyLZtPzCk
        CydtW54zBnNqzWW/pWyUVqzhb0CDpf3fd3CeQVaVNqnSGPR2IyW3LwuM9hUagz2BaR21t41m20QSq
        0ldMJeqLeGUXEv9wbMsuayPhB/yQJ1XF5fKoFSG1ayN209bMJ3cZnltE2GYTEUKchFB4/Rpz62PEh
        zRNNLLqyMCZsnrHV0T8Wwo/+ZyV6MRktdqVid2bcZIMMMNw7/FgIhTasctOIV8yHTGpp0EiyUtsG5
        NkGA3YsXFT78qex4vfoEmDTSFKxdsK9JH6fQxiTZW7/nafdM+8MeK6G1nPef+3TndJHUBqdgduJz5
        N2XI5ozw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31tP-000O24-Hv; Mon, 12 Jul 2021 19:47:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 03/18] mm/memcg: Use the node id in mem_cgroup_update_tree()
Date:   Mon, 12 Jul 2021 20:45:36 +0100
Message-Id: <20210712194551.91920-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712194551.91920-1-willy@infradead.org>
References: <20210712194551.91920-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By using the node id in mem_cgroup_update_tree(), we can delete
soft_limit_tree_from_page() and mem_cgroup_page_nodeinfo().  Saves 42
bytes of kernel text on my config.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/memcontrol.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ee892daecb8b..d57ff5c5d330 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -451,28 +451,12 @@ ino_t page_cgroup_ino(struct page *page)
 	return ino;
 }
 
-static struct mem_cgroup_per_node *
-mem_cgroup_page_nodeinfo(struct mem_cgroup *memcg, struct page *page)
-{
-	int nid = page_to_nid(page);
-
-	return memcg->nodeinfo[nid];
-}
-
 static struct mem_cgroup_tree_per_node *
 soft_limit_tree_node(int nid)
 {
 	return soft_limit_tree.rb_tree_per_node[nid];
 }
 
-static struct mem_cgroup_tree_per_node *
-soft_limit_tree_from_page(struct page *page)
-{
-	int nid = page_to_nid(page);
-
-	return soft_limit_tree.rb_tree_per_node[nid];
-}
-
 static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
 					 struct mem_cgroup_tree_per_node *mctz,
 					 unsigned long new_usage_in_excess)
@@ -543,13 +527,13 @@ static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
 	return excess;
 }
 
-static void mem_cgroup_update_tree(struct mem_cgroup *memcg, struct page *page)
+static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
 {
 	unsigned long excess;
 	struct mem_cgroup_per_node *mz;
 	struct mem_cgroup_tree_per_node *mctz;
 
-	mctz = soft_limit_tree_from_page(page);
+	mctz = soft_limit_tree_node(nid);
 	if (!mctz)
 		return;
 	/*
@@ -557,7 +541,7 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, struct page *page)
 	 * because their event counter is not touched.
 	 */
 	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		mz = mem_cgroup_page_nodeinfo(memcg, page);
+		mz = memcg->nodeinfo[nid];
 		excess = soft_limit_excess(memcg);
 		/*
 		 * We have to update the tree if mz is on RB-tree or
@@ -884,7 +868,7 @@ static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
 						MEM_CGROUP_TARGET_SOFTLIMIT);
 		mem_cgroup_threshold(memcg);
 		if (unlikely(do_softlimit))
-			mem_cgroup_update_tree(memcg, page);
+			mem_cgroup_update_tree(memcg, page_to_nid(page));
 	}
 }
 
-- 
2.30.2

