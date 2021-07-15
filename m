Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843683C96EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhGOEKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbhGOEKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:10:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC1C06175F;
        Wed, 14 Jul 2021 21:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZszZ6tgqEqvbn4yMeCdI0iO4PNst4fp1/dzYOIQ1JeY=; b=wPmYhWokc0h/1jnZH2rdEpIe5+
        sTk9Y6WM2M+h0b3SId3ix0NQhr40fpWL05ij7pr7ZqBI1RNqoEcjCiaX8EmGEOXFBy5n+47n1Oz1d
        rKneLvrq185zq67z+0wIEhpPL33ForXtfb0gVCyzHqW6dreZErrjjbXJdV3sUUg4xSgEsAfkJRBtC
        w/GGubJW8pwefwkZd9GpGLt9ih8CtFMeq/2WuSYbh4RHg48Cm/Z8sH+OyX96EBNGVRei9LUiErWW6
        AqbY2LNfpo2OYzAIn6IDMhOKvN8Sa7Vs8u5M7ZnjxeMaND1WC901zIIKl1iYMarodvinheZLDVUEH
        0rOsKWOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sd9-002w0Q-Aa; Thu, 15 Jul 2021 04:05:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 036/138] mm/memcg: Remove soft_limit_tree_node()
Date:   Thu, 15 Jul 2021 04:35:22 +0100
Message-Id: <20210715033704.692967-37-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Opencode this one-line function in its three callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/memcontrol.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d57ff5c5d330..f70e33d691aa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -451,12 +451,6 @@ ino_t page_cgroup_ino(struct page *page)
 	return ino;
 }
 
-static struct mem_cgroup_tree_per_node *
-soft_limit_tree_node(int nid)
-{
-	return soft_limit_tree.rb_tree_per_node[nid];
-}
-
 static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
 					 struct mem_cgroup_tree_per_node *mctz,
 					 unsigned long new_usage_in_excess)
@@ -533,7 +527,7 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
 	struct mem_cgroup_per_node *mz;
 	struct mem_cgroup_tree_per_node *mctz;
 
-	mctz = soft_limit_tree_node(nid);
+	mctz = soft_limit_tree.rb_tree_per_node[nid];
 	if (!mctz)
 		return;
 	/*
@@ -572,7 +566,7 @@ static void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
 
 	for_each_node(nid) {
 		mz = memcg->nodeinfo[nid];
-		mctz = soft_limit_tree_node(nid);
+		mctz = soft_limit_tree.rb_tree_per_node[nid];
 		if (mctz)
 			mem_cgroup_remove_exceeded(mz, mctz);
 	}
@@ -3420,7 +3414,7 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 	if (order > 0)
 		return 0;
 
-	mctz = soft_limit_tree_node(pgdat->node_id);
+	mctz = soft_limit_tree.rb_tree_per_node[pgdat->node_id];
 
 	/*
 	 * Do not even bother to check the largest node if the root
-- 
2.30.2

