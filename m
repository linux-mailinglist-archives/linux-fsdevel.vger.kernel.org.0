Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB9373F3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhEEQJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhEEQJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:09:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84384C061574;
        Wed,  5 May 2021 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Fnblz5Exlm2MS7V9ban3wbSDxZOMhSnBAHMw8i0wBj8=; b=LuN0y4qYXAqIZY/TvtQ6UG6Iqi
        sZZk/oJlkdWcY1me0kXfM7tzE1djaBv7csAVhPOMOqUum43jF6yqPnEK6f2q3bzQ4A5wvGjL4OxpB
        mwMhr7kmg2tXcnwVLZoC5IHOdjzO7Qzvb9P+3S8IyD1QrgJIIKbBacNTWEepdwfyA8pXb6YWbO0Ta
        kGO4ORVoqDd9ruoEfJY2Oymzl+yewd15dmga9xtdyUme8Q2TMTQ6VuTDe2enmviKxZEcuKjN9rNGO
        NwsADFV6nMoJfXiNcwO3s8u4oATIaRemiJwG+gfovuSF/FXDSNwjKo8fd+eXBX1hD3JxAU47f3SPP
        s/2B3vXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leK38-000Z6F-OI; Wed, 05 May 2021 16:07:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 49/96] mm/memcg: Use the node id in mem_cgroup_update_tree
Date:   Wed,  5 May 2021 16:05:41 +0100
Message-Id: <20210505150628.111735-50-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hoist the page_to_nid() call from mem_cgroup_page_nodeinfo() into
mem_cgroup_update_tree().  That lets us call soft_limit_tree_node()
and delete soft_limit_tree_from_page() altogether.  Saves 42
bytes of kernel text on my config.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1204c6a0c671..7423cb11eb88 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -453,10 +453,8 @@ ino_t page_cgroup_ino(struct page *page)
 }
 
 static struct mem_cgroup_per_node *
-mem_cgroup_page_nodeinfo(struct mem_cgroup *memcg, struct page *page)
+mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
 {
-	int nid = page_to_nid(page);
-
 	return memcg->nodeinfo[nid];
 }
 
@@ -466,14 +464,6 @@ soft_limit_tree_node(int nid)
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
@@ -549,8 +539,9 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, struct page *page)
 	unsigned long excess;
 	struct mem_cgroup_per_node *mz;
 	struct mem_cgroup_tree_per_node *mctz;
+	int nid = page_to_nid(page);
 
-	mctz = soft_limit_tree_from_page(page);
+	mctz = soft_limit_tree_node(nid);
 	if (!mctz)
 		return;
 	/*
@@ -558,7 +549,7 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, struct page *page)
 	 * because their event counter is not touched.
 	 */
 	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		mz = mem_cgroup_page_nodeinfo(memcg, page);
+		mz = mem_cgroup_nodeinfo(memcg, nid);
 		excess = soft_limit_excess(memcg);
 		/*
 		 * We have to update the tree if mz is on RB-tree or
-- 
2.30.2

