Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9243C641E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhGLTvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbhGLTvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:51:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD88C0613DD;
        Mon, 12 Jul 2021 12:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZszZ6tgqEqvbn4yMeCdI0iO4PNst4fp1/dzYOIQ1JeY=; b=YpSDwjHlxKrAWxqTnShe/Lfunv
        PMbS22mlDF78y1tDdHkWsocwPLx89wpwG2MuN2NCGi2OgHvwY+V35iXkc2YC5/M0QEzGd1pjQXKCf
        MxM4N2y+9Lz+v8qgmpm5owjq7euLdb0y68lmQxaIdRrm6zZIZ3rSee8CLMcjqI6bY8HgbT53ztGHx
        T4QZTGdzftVWhQXJH2e3yH7LTeNWxnimQcunqqOncTIB9ujShu+83mjUgIj7+QFYcp4jIeDtvzEJ2
        w0/xlinPzwoufdv1bgoL+unKwZX7oXx1PokyUMmPkd7W+y4G1ZuGXRoCNIjS870X2AKoAuP4Ftzt1
        6Ho2N+9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31uA-000O5g-GL; Mon, 12 Jul 2021 19:48:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 04/18] mm/memcg: Remove soft_limit_tree_node()
Date:   Mon, 12 Jul 2021 20:45:37 +0100
Message-Id: <20210712194551.91920-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712194551.91920-1-willy@infradead.org>
References: <20210712194551.91920-1-willy@infradead.org>
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

