Return-Path: <linux-fsdevel+bounces-32742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C989AE647
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008DF1F25F48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167511E633B;
	Thu, 24 Oct 2024 13:25:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE7F1E490B;
	Thu, 24 Oct 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776315; cv=none; b=GUXZemr2Gg0Rt9828HCu4UzptBaQw3Jbrm4OoG1HGLDt7z7N++QHDlA+haF7RaVNc7GUR+P9P2Q0lP3UKDaEH+JTQsv1oLvwo9qRR6wxxyrPJLq+ph6GtxmRRQ2w2ECO08HamEhh4mOKInVOQVxEXld7hYNK/L5CWr8WCF796i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776315; c=relaxed/simple;
	bh=0qnYg5aBJ2iB36MPHcPSbP1CyciPh7KnmGA2FGs+DFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqi9ncMX77QGog6t1OtVpNgBoBuxyTjG2ZLw8AZN7fIJbZuINrgzX+L6pnrhIY2SEvbXKDyZ5izMyCjCjLFaq5PG6K8otnonBGRox0WqzUG/fwFnxfi3yVnWwNYQ6cjUq863glxRvv2JZ/NQRAqsbmZK817joRop/pPVBJEY5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZ68h1pwWz4f3jsD;
	Thu, 24 Oct 2024 21:24:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B46041A0194;
	Thu, 24 Oct 2024 21:25:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMmxShpnmfz6Ew--.42902S5;
	Thu, 24 Oct 2024 21:25:08 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	sashal@kernel.org,
	srinivasan.shanmugam@amd.com,
	chiahsuan.chung@amd.com,
	mingo@kernel.org,
	mgorman@techsingularity.net,
	yukuai3@huawei.com,
	chengming.zhou@linux.dev,
	zhangpeng.00@bytedance.com,
	chuck.lever@oracle.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 6.6 17/28] maple_tree: use maple state end for write operations
Date: Thu, 24 Oct 2024 21:22:14 +0800
Message-Id: <20241024132225.2271667-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241024132225.2271667-1-yukuai1@huaweicloud.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
 <20241024132225.2271667-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3LMmxShpnmfz6Ew--.42902S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKF1DKr4fZFWkXr1rtF4UXFb_yoW3Arykpa
	srKFy7Kr1xJry7GFZ2k3y8Z3WDJwnrGr4YqFyUKwnYqFyDKF9Iqa18Zw1IgFWqy3yxAr13
	JFW5Wr4Duwn7tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIev
	Ja73UjIFyTuYvjTRXcTmUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

commit 0de56e38b307b0cb2ac825e8e7cb371a28daf844 upstream.

ma_wr_state was previously tracking the end of the node for writing.
Since the implementation of the ma_state end tracking, this is duplicated
work.  This patch removes the maple write state tracking of the end of the
node and uses the maple state end instead.

Link: https://lkml.kernel.org/r/20231101171629.3612299-11-Liam.Howlett@oracle.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 include/linux/maple_tree.h |  1 -
 lib/maple_tree.c           | 46 ++++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 4dd668f7b111..b3d63123b945 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -441,7 +441,6 @@ struct ma_wr_state {
 	unsigned long r_max;		/* range max */
 	enum maple_type type;		/* mas->node type */
 	unsigned char offset_end;	/* The offset where the write ends */
-	unsigned char node_end;		/* mas->node end */
 	unsigned long *pivots;		/* mas->node->pivots pointer */
 	unsigned long end_piv;		/* The pivot at the offset end */
 	void __rcu **slots;		/* mas->node->slots pointer */
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 291412b91047..472aef7a3d5c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2158,11 +2158,11 @@ static noinline_for_kasan void mas_store_b_node(struct ma_wr_state *wr_mas,
 	}
 
 	slot = offset_end + 1;
-	if (slot > wr_mas->node_end)
+	if (slot > mas->end)
 		goto b_end;
 
 	/* Copy end data to the end of the node. */
-	mas_mab_cp(mas, slot, wr_mas->node_end + 1, b_node, ++b_end);
+	mas_mab_cp(mas, slot, mas->end + 1, b_node, ++b_end);
 	b_node->b_end--;
 	return;
 
@@ -2253,8 +2253,8 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
 
 	wr_mas->node = mas_mn(wr_mas->mas);
 	wr_mas->pivots = ma_pivots(wr_mas->node, wr_mas->type);
-	count = wr_mas->node_end = ma_data_end(wr_mas->node, wr_mas->type,
-					       wr_mas->pivots, mas->max);
+	count = mas->end = ma_data_end(wr_mas->node, wr_mas->type,
+				       wr_mas->pivots, mas->max);
 	offset = mas->offset;
 
 	while (offset < count && mas->index > wr_mas->pivots[offset])
@@ -3904,10 +3904,10 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	/* Copy l_mas and store the value in b_node. */
-	mas_store_b_node(&l_wr_mas, &b_node, l_wr_mas.node_end);
+	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
 	/* Copy r_mas into b_node. */
-	if (r_mas.offset <= r_wr_mas.node_end)
-		mas_mab_cp(&r_mas, r_mas.offset, r_wr_mas.node_end,
+	if (r_mas.offset <= r_mas.end)
+		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
 			   &b_node, b_node.b_end + 1);
 	else
 		b_node.b_end++;
@@ -3949,7 +3949,7 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 	if (mas->last == wr_mas->end_piv)
 		offset_end++; /* don't copy this offset */
 	else if (unlikely(wr_mas->r_max == ULONG_MAX))
-		mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
+		mas_bulk_rebalance(mas, mas->end, wr_mas->type);
 
 	/* set up node. */
 	if (in_rcu) {
@@ -3985,12 +3985,12 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 	 * this range wrote to the end of the node or it overwrote the rest of
 	 * the data
 	 */
-	if (offset_end > wr_mas->node_end)
+	if (offset_end > mas->end)
 		goto done;
 
 	dst_offset = mas->offset + 1;
 	/* Copy to the end of node if necessary. */
-	copy_size = wr_mas->node_end - offset_end + 1;
+	copy_size = mas->end - offset_end + 1;
 	memcpy(dst_slots + dst_offset, wr_mas->slots + offset_end,
 	       sizeof(void *) * copy_size);
 	memcpy(dst_pivots + dst_offset, wr_mas->pivots + offset_end,
@@ -4077,10 +4077,10 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 	} else {
 		/* Check next slot(s) if we are overwriting the end */
 		if ((mas->last == wr_mas->end_piv) &&
-		    (wr_mas->node_end != wr_mas->offset_end) &&
+		    (mas->end != wr_mas->offset_end) &&
 		    !wr_mas->slots[wr_mas->offset_end + 1]) {
 			wr_mas->offset_end++;
-			if (wr_mas->offset_end == wr_mas->node_end)
+			if (wr_mas->offset_end == mas->end)
 				mas->last = mas->max;
 			else
 				mas->last = wr_mas->pivots[wr_mas->offset_end];
@@ -4105,11 +4105,11 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 
 static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
 {
-	while ((wr_mas->offset_end < wr_mas->node_end) &&
+	while ((wr_mas->offset_end < wr_mas->mas->end) &&
 	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
 		wr_mas->offset_end++;
 
-	if (wr_mas->offset_end < wr_mas->node_end)
+	if (wr_mas->offset_end < wr_mas->mas->end)
 		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
 	else
 		wr_mas->end_piv = wr_mas->mas->max;
@@ -4121,7 +4121,7 @@ static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
 static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
-	unsigned char new_end = wr_mas->node_end + 2;
+	unsigned char new_end = mas->end + 2;
 
 	new_end -= wr_mas->offset_end - mas->offset;
 	if (wr_mas->r_min == mas->index)
@@ -4155,10 +4155,10 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 	if (mt_in_rcu(mas->tree))
 		return false;
 
-	if (mas->offset != wr_mas->node_end)
+	if (mas->offset != mas->end)
 		return false;
 
-	end = wr_mas->node_end;
+	end = mas->end;
 	if (mas->offset != end)
 		return false;
 
@@ -4210,7 +4210,7 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 	trace_ma_write(__func__, wr_mas->mas, 0, wr_mas->entry);
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
-	mas_commit_b_node(wr_mas, &b_node, wr_mas->node_end);
+	mas_commit_b_node(wr_mas, &b_node, wr_mas->mas->end);
 }
 
 static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
@@ -4238,7 +4238,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 	if (mas_wr_append(wr_mas, new_end))
 		return;
 
-	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
+	if (new_end == mas->end && mas_wr_slot_store(wr_mas))
 		return;
 
 	if (mas_wr_node_store(wr_mas, new_end))
@@ -5052,6 +5052,7 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	unsigned char offset;
 	unsigned long *pivots;
 	enum maple_type mt;
+	struct maple_node *node;
 
 	if (min > max)
 		return -EINVAL;
@@ -5082,13 +5083,14 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	if (unlikely(offset == MAPLE_NODE_SLOTS))
 		return -EBUSY;
 
+	node = mas_mn(mas);
 	mt = mte_node_type(mas->node);
-	pivots = ma_pivots(mas_mn(mas), mt);
+	pivots = ma_pivots(node, mt);
 	min = mas_safe_min(mas, pivots, offset);
 	if (mas->index < min)
 		mas->index = min;
 	mas->last = mas->index + size - 1;
-	mas->end = mas_data_end(mas);
+	mas->end = ma_data_end(node, mt, pivots, mas->max);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mas_empty_area);
@@ -7607,7 +7609,7 @@ void mas_wr_dump(const struct ma_wr_state *wr_mas)
 	pr_err("WR_MAS: node=%p r_min=%lx r_max=%lx\n",
 	       wr_mas->node, wr_mas->r_min, wr_mas->r_max);
 	pr_err("        type=%u off_end=%u, node_end=%u, end_piv=%lx\n",
-	       wr_mas->type, wr_mas->offset_end, wr_mas->node_end,
+	       wr_mas->type, wr_mas->offset_end, wr_mas->mas->end,
 	       wr_mas->end_piv);
 }
 EXPORT_SYMBOL_GPL(mas_wr_dump);
-- 
2.39.2


