Return-Path: <linux-fsdevel+bounces-32741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDCB9AE632
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCD71F2591F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65FC1DE2C5;
	Thu, 24 Oct 2024 13:23:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3721F76A4;
	Thu, 24 Oct 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776201; cv=none; b=VQSA8Vybn7O9Ax6fh0Cwv3rMKOlY29tPDk/pE8gOwEsuRZmhxs5Nh1M62dSNbLsXkR93u+OnNFFZfJeqYu82Jkxb2ZFToGalmMC5IuvZ7hSSLv2/3aCCqDVBnWLVViuVnF6Bp4F5+uBld0yvClw2xYtfezu789qFpyCN7LVugBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776201; c=relaxed/simple;
	bh=dK7S5BbCk4lqOsiw74Kip/Y9iclqEZbEz5QO4OlUkww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CzQUfB7Bx3wtbnVlOJULHRn1UAamqUYXp6+Esxiu15scjMP0aMbBwZCpbS/rfU7QnGnYrpLoMMr70bG3irY+KQy3haBe1+i3irK/Rn+q6c0GQI2iR/s/GbW6FVBp/33w+90tGEFgpehaVrWeWca50XY90DwAdp+DeqKRBzCWGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZ66V28mlz4f3l8c;
	Thu, 24 Oct 2024 21:22:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A1CD61A0196;
	Thu, 24 Oct 2024 21:23:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHusYpShpn7tb6Ew--.444S18;
	Thu, 24 Oct 2024 21:23:10 +0800 (CST)
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
Subject: [PATCH 6.6 14/28] maple_tree: separate ma_state node from status
Date: Thu, 24 Oct 2024 21:19:55 +0800
Message-Id: <20241024132009.2267260-15-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHusYpShpn7tb6Ew--.444S18
X-Coremail-Antispam: 1UD129KBjvAXoWDAFW8Jr47Jry8Cry7Cw4fuFg_yoWxAryfGo
	ZxJr95Gw1kJF1xGr4xK3WxWa45Za4Uuws5C3sF9F4Ig3ZxXw48ua47Wan0qa4Y9rs3GF47
	AFnrJ34IqF47uFy5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOI7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJV
	W0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsG
	vfC2KfnxnUUI43ZEXa7sREzuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

commit 067311d33e650adfe7ae23765959ddcc1ba18510 upstream.

The maple tree node is overloaded to keep status as well as the active
node.  This, unfortunately, results in a re-walk on underflow or overflow.
Since the maple state has room, the status can be placed in its own enum
in the structure.  Once an underflow/overflow is detected, certain modes
can restore the status to active and others may need to re-walk just that
one node to see the entry.

The status being an enum has the benefit of detecting unhandled status in
switch statements.

[Liam.Howlett@oracle.com: fix comments about MAS_*]
  Link: https://lkml.kernel.org/r/20231106154124.614247-1-Liam.Howlett@oracle.com
[Liam.Howlett@oracle.com: update forking to separate maple state and node]
  Link: https://lkml.kernel.org/r/20231106154551.615042-1-Liam.Howlett@oracle.com
[Liam.Howlett@oracle.com: fix mas_prev() state separation code]
  Link: https://lkml.kernel.org/r/20231207193319.4025462-1-Liam.Howlett@oracle.com
Link: https://lkml.kernel.org/r/20231101171629.3612299-9-Liam.Howlett@oracle.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 include/linux/maple_tree.h       |  87 +++---
 include/linux/mm_types.h         |   3 +-
 lib/maple_tree.c                 | 459 +++++++++++++++++++------------
 lib/test_maple_tree.c            | 189 +++++++------
 mm/internal.h                    |   8 +-
 tools/testing/radix-tree/maple.c |  26 +-
 6 files changed, 445 insertions(+), 327 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 0b82efe0cf1e..4dd668f7b111 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -349,6 +349,36 @@ static inline bool mtree_empty(const struct maple_tree *mt)
 
 /* Advanced API */
 
+/*
+ * Maple State Status
+ * ma_active means the maple state is pointing to a node and offset and can
+ * continue operating on the tree.
+ * ma_start means we have not searched the tree.
+ * ma_root means we have searched the tree and the entry we found lives in
+ * the root of the tree (ie it has index 0, length 1 and is the only entry in
+ * the tree).
+ * ma_none means we have searched the tree and there is no node in the
+ * tree for this entry.  For example, we searched for index 1 in an empty
+ * tree.  Or we have a tree which points to a full leaf node and we
+ * searched for an entry which is larger than can be contained in that
+ * leaf node.
+ * ma_pause means the data within the maple state may be stale, restart the
+ * operation
+ * ma_overflow means the search has reached the upper limit of the search
+ * ma_underflow means the search has reached the lower limit of the search
+ * ma_error means there was an error, check the node for the error number.
+ */
+enum maple_status {
+	ma_active,
+	ma_start,
+	ma_root,
+	ma_none,
+	ma_pause,
+	ma_overflow,
+	ma_underflow,
+	ma_error,
+};
+
 /*
  * The maple state is defined in the struct ma_state and is used to keep track
  * of information during operations, and even between operations when using the
@@ -381,6 +411,13 @@ static inline bool mtree_empty(const struct maple_tree *mt)
  * When returning a value the maple state index and last respectively contain
  * the start and end of the range for the entry.  Ranges are inclusive in the
  * Maple Tree.
+ *
+ * The status of the state is used to determine how the next action should treat
+ * the state.  For instance, if the status is ma_start then the next action
+ * should start at the root of the tree and walk down.  If the status is
+ * ma_pause then the node may be stale data and should be discarded.  If the
+ * status is ma_overflow, then the last action hit the upper limit.
+ *
  */
 struct ma_state {
 	struct maple_tree *tree;	/* The tree we're operating in */
@@ -390,6 +427,7 @@ struct ma_state {
 	unsigned long min;		/* The minimum index of this node - implied pivot min */
 	unsigned long max;		/* The maximum index of this node - implied pivot max */
 	struct maple_alloc *alloc;	/* Allocated nodes for this operation */
+	enum maple_status status;	/* The status of the state (active, start, none, etc) */
 	unsigned char depth;		/* depth of tree descent during write */
 	unsigned char offset;
 	unsigned char mas_flags;
@@ -416,28 +454,12 @@ struct ma_wr_state {
 		spin_lock_nested(&((mas)->tree->ma_lock), subclass)
 #define mas_unlock(mas)         spin_unlock(&((mas)->tree->ma_lock))
 
-
 /*
  * Special values for ma_state.node.
- * MAS_START means we have not searched the tree.
- * MAS_ROOT means we have searched the tree and the entry we found lives in
- * the root of the tree (ie it has index 0, length 1 and is the only entry in
- * the tree).
- * MAS_NONE means we have searched the tree and there is no node in the
- * tree for this entry.  For example, we searched for index 1 in an empty
- * tree.  Or we have a tree which points to a full leaf node and we
- * searched for an entry which is larger than can be contained in that
- * leaf node.
  * MA_ERROR represents an errno.  After dropping the lock and attempting
  * to resolve the error, the walk would have to be restarted from the
  * top of the tree as the tree may have been modified.
  */
-#define MAS_START	((struct maple_enode *)1UL)
-#define MAS_ROOT	((struct maple_enode *)5UL)
-#define MAS_NONE	((struct maple_enode *)9UL)
-#define MAS_PAUSE	((struct maple_enode *)17UL)
-#define MAS_OVERFLOW	((struct maple_enode *)33UL)
-#define MAS_UNDERFLOW	((struct maple_enode *)65UL)
 #define MA_ERROR(err) \
 		((struct maple_enode *)(((unsigned long)err << 2) | 2UL))
 
@@ -446,7 +468,8 @@ struct ma_wr_state {
 		.tree = mt,						\
 		.index = first,						\
 		.last = end,						\
-		.node = MAS_START,					\
+		.node = NULL,						\
+		.status = ma_start,					\
 		.min = 0,						\
 		.max = ULONG_MAX,					\
 		.alloc = NULL,						\
@@ -477,7 +500,6 @@ void *mas_find_range(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
 void *mas_find_range_rev(struct ma_state *mas, unsigned long max);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
-bool mas_is_err(struct ma_state *mas);
 
 bool mas_nomem(struct ma_state *mas, gfp_t gfp);
 void mas_pause(struct ma_state *mas);
@@ -506,28 +528,18 @@ static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
 	mas->tree = tree;
 	mas->index = mas->last = addr;
 	mas->max = ULONG_MAX;
-	mas->node = MAS_START;
+	mas->status = ma_start;
+	mas->node = NULL;
 }
 
-/* Checks if a mas has not found anything */
-static inline bool mas_is_none(const struct ma_state *mas)
-{
-	return mas->node == MAS_NONE;
-}
-
-/* Checks if a mas has been paused */
-static inline bool mas_is_paused(const struct ma_state *mas)
+static inline bool mas_is_active(struct ma_state *mas)
 {
-	return mas->node == MAS_PAUSE;
+	return mas->status == ma_active;
 }
 
-/* Check if the mas is pointing to a node or not */
-static inline bool mas_is_active(struct ma_state *mas)
+static inline bool mas_is_err(struct ma_state *mas)
 {
-	if ((unsigned long)mas->node >= MAPLE_RESERVED_RANGE)
-		return true;
-
-	return false;
+	return mas->status == ma_error;
 }
 
 /**
@@ -540,9 +552,10 @@ static inline bool mas_is_active(struct ma_state *mas)
  *
  * Context: Any context.
  */
-static inline void mas_reset(struct ma_state *mas)
+static __always_inline void mas_reset(struct ma_state *mas)
 {
-	mas->node = MAS_START;
+	mas->status = ma_start;
+	mas->node = NULL;
 }
 
 /**
@@ -716,7 +729,7 @@ static inline void __mas_set_range(struct ma_state *mas, unsigned long start,
 static inline
 void mas_set_range(struct ma_state *mas, unsigned long start, unsigned long last)
 {
-	mas->node = MAS_START;
+	mas_reset(mas);
 	__mas_set_range(mas, start, last);
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 43c19d85dfe7..e38abf389943 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1041,7 +1041,8 @@ struct vma_iterator {
 		.mas = {						\
 			.tree = &(__mm)->mm_mt,				\
 			.index = __addr,				\
-			.node = MAS_START,				\
+			.node = NULL,					\
+			.status = ma_start,				\
 		},							\
 	}
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d1416276f1ef..f7a1c1cc18eb 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -249,40 +249,40 @@ static __always_inline bool mt_is_reserved(const void *entry)
 		xa_is_internal(entry);
 }
 
-static inline void mas_set_err(struct ma_state *mas, long err)
+static __always_inline void mas_set_err(struct ma_state *mas, long err)
 {
 	mas->node = MA_ERROR(err);
+	mas->status = ma_error;
 }
 
-static inline bool mas_is_ptr(const struct ma_state *mas)
+static __always_inline bool mas_is_ptr(const struct ma_state *mas)
 {
-	return mas->node == MAS_ROOT;
+	return mas->status == ma_root;
 }
 
-static inline bool mas_is_start(const struct ma_state *mas)
+static __always_inline bool mas_is_start(const struct ma_state *mas)
 {
-	return mas->node == MAS_START;
+	return mas->status == ma_start;
 }
 
-bool mas_is_err(struct ma_state *mas)
+static __always_inline bool mas_is_none(const struct ma_state *mas)
 {
-	return xa_is_err(mas->node);
+	return mas->status == ma_none;
 }
 
-static __always_inline bool mas_is_overflow(struct ma_state *mas)
+static __always_inline bool mas_is_paused(const struct ma_state *mas)
 {
-	if (unlikely(mas->node == MAS_OVERFLOW))
-		return true;
-
-	return false;
+	return mas->status == ma_pause;
 }
 
-static __always_inline bool mas_is_underflow(struct ma_state *mas)
+static __always_inline bool mas_is_overflow(struct ma_state *mas)
 {
-	if (unlikely(mas->node == MAS_UNDERFLOW))
-		return true;
+	return mas->status == ma_overflow;
+}
 
-	return false;
+static inline bool mas_is_underflow(struct ma_state *mas)
+{
+	return mas->status == ma_underflow;
 }
 
 static inline bool mas_searchable(struct ma_state *mas)
@@ -1274,6 +1274,7 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 	if (mas->mas_flags & MA_STATE_PREALLOC) {
 		if (allocated)
 			return;
+		BUG_ON(!allocated);
 		WARN_ON(!allocated);
 	}
 
@@ -1379,14 +1380,14 @@ static void mas_node_count(struct ma_state *mas, int count)
  * mas_start() - Sets up maple state for operations.
  * @mas: The maple state.
  *
- * If mas->node == MAS_START, then set the min, max and depth to
+ * If mas->status == mas_start, then set the min, max and depth to
  * defaults.
  *
  * Return:
- * - If mas->node is an error or not MAS_START, return NULL.
- * - If it's an empty tree:     NULL & mas->node == MAS_NONE
- * - If it's a single entry:    The entry & mas->node == MAS_ROOT
- * - If it's a tree:            NULL & mas->node == safe root node.
+ * - If mas->node is an error or not mas_start, return NULL.
+ * - If it's an empty tree:     NULL & mas->status == ma_none
+ * - If it's a single entry:    The entry & mas->status == mas_root
+ * - If it's a tree:            NULL & mas->status == safe root node.
  */
 static inline struct maple_enode *mas_start(struct ma_state *mas)
 {
@@ -1402,6 +1403,7 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
 			mas->depth = 1;
+			mas->status = ma_active;
 			mas->node = mte_safe_root(root);
 			mas->offset = 0;
 			if (mte_dead_node(mas->node))
@@ -1412,13 +1414,14 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 
 		/* empty tree */
 		if (unlikely(!root)) {
-			mas->node = MAS_NONE;
+			mas->node = NULL;
+			mas->status = ma_none;
 			mas->offset = MAPLE_NODE_SLOTS;
 			return NULL;
 		}
 
 		/* Single entry tree */
-		mas->node = MAS_ROOT;
+		mas->status = ma_root;
 		mas->offset = MAPLE_NODE_SLOTS;
 
 		/* Single entry tree. */
@@ -2225,19 +2228,21 @@ static inline bool mas_next_sibling(struct ma_state *mas)
 }
 
 /*
- * mte_node_or_node() - Return the encoded node or MAS_NONE.
+ * mte_node_or_none() - Set the enode and state.
  * @enode: The encoded maple node.
  *
- * Shorthand to avoid setting %NULLs in the tree or maple_subtree_state.
- *
- * Return: @enode or MAS_NONE
+ * Set the node to the enode and the status.
  */
-static inline struct maple_enode *mte_node_or_none(struct maple_enode *enode)
+static inline void mas_node_or_none(struct ma_state *mas,
+		struct maple_enode *enode)
 {
-	if (enode)
-		return enode;
-
-	return ma_enode_ptr(MAS_NONE);
+	if (enode) {
+		mas->node = enode;
+		mas->status = ma_active;
+	} else {
+		mas->node = NULL;
+		mas->status = ma_none;
+	}
 }
 
 /*
@@ -2559,13 +2564,15 @@ static inline void mast_set_split_parents(struct maple_subtree_state *mast,
  * The node will either be RCU freed or pushed back on the maple state.
  */
 static inline void mas_topiary_node(struct ma_state *mas,
-		struct maple_enode *enode, bool in_rcu)
+		struct ma_state *tmp_mas, bool in_rcu)
 {
 	struct maple_node *tmp;
+	struct maple_enode *enode;
 
-	if (enode == MAS_NONE)
+	if (mas_is_none(tmp_mas))
 		return;
 
+	enode = tmp_mas->node;
 	tmp = mte_to_node(enode);
 	mte_set_node_dead(enode);
 	if (in_rcu)
@@ -2605,8 +2612,8 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 	/* Update the parent pointers in the tree */
 	tmp[0] = *mas;
 	tmp[0].offset = 0;
-	tmp[1].node = MAS_NONE;
-	tmp[2].node = MAS_NONE;
+	tmp[1].status = ma_none;
+	tmp[2].status = ma_none;
 	while (!mte_is_leaf(tmp[0].node)) {
 		n = 0;
 		for (i = 0; i < 3; i++) {
@@ -2626,7 +2633,7 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 			break;
 
 		while (n < 3)
-			tmp_next[n++].node = MAS_NONE;
+			tmp_next[n++].status = ma_none;
 
 		for (i = 0; i < 3; i++)
 			tmp[i] = tmp_next[i];
@@ -2639,8 +2646,8 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 	tmp[0] = *mas;
 	tmp[0].offset = 0;
 	tmp[0].node = old_enode;
-	tmp[1].node = MAS_NONE;
-	tmp[2].node = MAS_NONE;
+	tmp[1].status = ma_none;
+	tmp[2].status = ma_none;
 	in_rcu = mt_in_rcu(mas->tree);
 	do {
 		n = 0;
@@ -2655,7 +2662,7 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 				if ((tmp_next[n].min >= tmp_next->index) &&
 				    (tmp_next[n].max <= tmp_next->last)) {
 					mat_add(&subtrees, tmp_next[n].node);
-					tmp_next[n].node = MAS_NONE;
+					tmp_next[n].status = ma_none;
 				} else {
 					n++;
 				}
@@ -2666,16 +2673,16 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 			break;
 
 		while (n < 3)
-			tmp_next[n++].node = MAS_NONE;
+			tmp_next[n++].status = ma_none;
 
 		for (i = 0; i < 3; i++) {
-			mas_topiary_node(mas, tmp[i].node, in_rcu);
+			mas_topiary_node(mas, &tmp[i], in_rcu);
 			tmp[i] = tmp_next[i];
 		}
 	} while (!mte_is_leaf(tmp[0].node));
 
 	for (i = 0; i < 3; i++)
-		mas_topiary_node(mas, tmp[i].node, in_rcu);
+		mas_topiary_node(mas, &tmp[i], in_rcu);
 
 	mas_mat_destroy(mas, &subtrees);
 }
@@ -2714,9 +2721,9 @@ static inline void mast_cp_to_nodes(struct maple_subtree_state *mast,
 {
 	bool new_lmax = true;
 
-	mast->l->node = mte_node_or_none(left);
-	mast->m->node = mte_node_or_none(middle);
-	mast->r->node = mte_node_or_none(right);
+	mas_node_or_none(mast->l, left);
+	mas_node_or_none(mast->m, middle);
+	mas_node_or_none(mast->r, right);
 
 	mast->l->min = mast->orig_l->min;
 	if (split == mast->bn->b_end) {
@@ -2896,7 +2903,7 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 	mast->l = &l_mas;
 	mast->m = &m_mas;
 	mast->r = &r_mas;
-	l_mas.node = r_mas.node = m_mas.node = MAS_NONE;
+	l_mas.status = r_mas.status = m_mas.status = ma_none;
 
 	/* Check if this is not root and has sufficient data.  */
 	if (((mast->orig_l->min != 0) || (mast->orig_r->max != ULONG_MAX)) &&
@@ -3423,7 +3430,6 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 		/* Try to push left. */
 		if (mas_push_data(mas, height, &mast, true))
 			break;
-
 		/* Try to push right. */
 		if (mas_push_data(mas, height, &mast, false))
 			break;
@@ -3539,6 +3545,7 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
 	slots = ma_slots(node, type);
 	node->parent = ma_parent_ptr(mas_tree_parent(mas));
 	mas->node = mt_mk_node(node, type);
+	mas->status = ma_active;
 
 	if (mas->index) {
 		if (contents) {
@@ -3571,7 +3578,7 @@ static inline void mas_store_root(struct ma_state *mas, void *entry)
 		mas_root_expand(mas, entry);
 	else {
 		rcu_assign_pointer(mas->tree->ma_root, entry);
-		mas->node = MAS_START;
+		mas->status = ma_start;
 	}
 }
 
@@ -3801,7 +3808,7 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
 		mas->depth = 0;
 		mas_set_height(mas);
 		rcu_assign_pointer(mas->tree->ma_root, entry);
-		mas->node = MAS_START;
+		mas->status = ma_start;
 		goto done;
 	}
 
@@ -3814,6 +3821,7 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
 	slots = ma_slots(node, type);
 	node->parent = ma_parent_ptr(mas_tree_parent(mas));
 	mas->node = mt_mk_node(node, type);
+	mas->status = ma_active;
 	rcu_assign_pointer(slots[0], entry);
 	pivots[0] = mas->last;
 	mas->depth = 1;
@@ -4367,11 +4375,13 @@ static __always_inline bool mas_rewalk_if_dead(struct ma_state *mas,
 
 /*
  * mas_prev_node() - Find the prev non-null entry at the same level in the
- * tree.  The prev value will be mas->node[mas->offset] or MAS_NONE.
+ * tree.  The prev value will be mas->node[mas->offset] or the status will be
+ * ma_none.
  * @mas: The maple state
  * @min: The lower limit to search
  *
- * The prev node value will be mas->node[mas->offset] or MAS_NONE.
+ * The prev node value will be mas->node[mas->offset] or the status will be
+ * ma_none.
  * Return: 1 if the node is dead, 0 otherwise.
  */
 static int mas_prev_node(struct ma_state *mas, unsigned long min)
@@ -4441,7 +4451,7 @@ static int mas_prev_node(struct ma_state *mas, unsigned long min)
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
-	mas->node = MAS_NONE;
+	mas->status = ma_underflow;
 	return 0;
 }
 
@@ -4455,8 +4465,7 @@ static int mas_prev_node(struct ma_state *mas, unsigned long min)
  *
  * Return: The entry in the previous slot which is possibly NULL
  */
-static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
-			   bool set_underflow)
+static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 {
 	void *entry;
 	void __rcu **slots;
@@ -4489,13 +4498,16 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
 		mas->last = mas->index - 1;
 		mas->index = mas_safe_min(mas, pivots, mas->offset);
 	} else  {
+		if (mas->index <= min)
+			goto underflow;
+
 		if (mas_prev_node(mas, min)) {
 			mas_rewalk(mas, save_point);
 			goto retry;
 		}
 
-		if (mas_is_none(mas))
-			goto underflow;
+		if (WARN_ON_ONCE(mas_is_underflow(mas)))
+			return NULL;
 
 		mas->last = mas->max;
 		node = mas_mn(mas);
@@ -4509,12 +4521,15 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
+
 	if (likely(entry))
 		return entry;
 
 	if (!empty) {
-		if (mas->index <= min)
-			goto underflow;
+		if (mas->index <= min) {
+			mas->status = ma_underflow;
+			return NULL;
+		}
 
 		goto again;
 	}
@@ -4522,8 +4537,7 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
 	return entry;
 
 underflow:
-	if (set_underflow)
-		mas->node = MAS_UNDERFLOW;
+	mas->status = ma_underflow;
 	return NULL;
 }
 
@@ -4532,7 +4546,8 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
  * @mas: The maple state
  * @max: The maximum pivot value to check.
  *
- * The next value will be mas->node[mas->offset] or MAS_NONE.
+ * The next value will be mas->node[mas->offset] or the status will have
+ * overflowed.
  * Return: 1 on dead node, 0 otherwise.
  */
 static int mas_next_node(struct ma_state *mas, struct maple_node *node,
@@ -4548,13 +4563,13 @@ static int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	void __rcu **slots;
 
 	if (mas->max >= max)
-		goto no_entry;
+		goto overflow;
 
 	min = mas->max + 1;
 	level = 0;
 	do {
 		if (ma_is_root(node))
-			goto no_entry;
+			goto overflow;
 
 		/* Walk up. */
 		if (unlikely(mas_ascend(mas)))
@@ -4605,11 +4620,11 @@ static int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	mas->min = min;
 	return 0;
 
-no_entry:
+overflow:
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
-	mas->node = MAS_NONE;
+	mas->status = ma_overflow;
 	return 0;
 }
 
@@ -4624,8 +4639,7 @@ static int mas_next_node(struct ma_state *mas, struct maple_node *node,
  *
  * Return: The entry in the next slot which is possibly NULL
  */
-static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
-			   bool set_overflow)
+static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 {
 	void __rcu **slots;
 	unsigned long *pivots;
@@ -4646,13 +4660,15 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 		if (likely(mas->offset < mas->end))
 			pivot = pivots[mas->offset];
 		else
-			goto overflow;
+			pivot = mas->max;
 
 		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 			goto retry;
 
-		if (pivot >= max)
-			goto overflow;
+		if (pivot >= max) { /* Was at the limit, next will extend beyond */
+			mas->status = ma_overflow;
+			return NULL;
+		}
 	}
 
 	if (likely(mas->offset < mas->end)) {
@@ -4664,16 +4680,18 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 		else
 			mas->last = mas->max;
 	} else  {
+		if (mas->last >= max) {
+			mas->status = ma_overflow;
+			return NULL;
+		}
+
 		if (mas_next_node(mas, node, max)) {
 			mas_rewalk(mas, save_point);
 			goto retry;
 		}
 
-		if (WARN_ON_ONCE(mas_is_none(mas))) {
-			mas->node = MAS_OVERFLOW;
+		if (WARN_ON_ONCE(mas_is_overflow(mas)))
 			return NULL;
-			goto overflow;
-		}
 
 		mas->offset = 0;
 		mas->index = mas->min;
@@ -4691,20 +4709,18 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 	if (entry)
 		return entry;
 
+
 	if (!empty) {
-		if (mas->last >= max)
-			goto overflow;
+		if (mas->last >= max) {
+			mas->status = ma_overflow;
+			return NULL;
+		}
 
 		mas->index = mas->last + 1;
 		goto again;
 	}
 
 	return entry;
-
-overflow:
-	if (set_overflow)
-		mas->node = MAS_OVERFLOW;
-	return NULL;
 }
 
 /*
@@ -4723,11 +4739,11 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
 	if (mas->last >= limit) {
-		mas->node = MAS_OVERFLOW;
+		mas->status = ma_overflow;
 		return NULL;
 	}
 
-	return mas_next_slot(mas, limit, false, true);
+	return mas_next_slot(mas, limit, false);
 }
 
 /*
@@ -4895,7 +4911,7 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
  * @mas: The maple state.
  *
  * mas->index and mas->last will be set to the range if there is a value.  If
- * mas->node is MAS_NONE, reset to MAS_START.
+ * mas->status is ma_none, reset to ma_start
  *
  * Return: the entry at the location or %NULL.
  */
@@ -4904,7 +4920,7 @@ void *mas_walk(struct ma_state *mas)
 	void *entry;
 
 	if (!mas_is_active(mas) || !mas_is_start(mas))
-		mas->node = MAS_START;
+		mas->status = ma_start;
 retry:
 	entry = mas_state_walk(mas);
 	if (mas_is_start(mas)) {
@@ -4920,7 +4936,7 @@ void *mas_walk(struct ma_state *mas)
 
 		mas->index = 1;
 		mas->last = ULONG_MAX;
-		mas->node = MAS_NONE;
+		mas->status = ma_none;
 		return NULL;
 	}
 
@@ -5683,27 +5699,40 @@ static bool mas_next_setup(struct ma_state *mas, unsigned long max,
 	bool was_none = mas_is_none(mas);
 
 	if (unlikely(mas->last >= max)) {
-		mas->node = MAS_OVERFLOW;
+		mas->status = ma_overflow;
 		return true;
 	}
 
-	if (mas_is_active(mas))
+	switch (mas->status) {
+	case ma_active:
 		return false;
-
-	if (mas_is_none(mas) || mas_is_paused(mas)) {
-		mas->node = MAS_START;
-	} else if (mas_is_overflow(mas)) {
+	case ma_none:
+		fallthrough;
+	case ma_pause:
+		mas->status = ma_start;
+		fallthrough;
+	case ma_start:
+		mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
+		break;
+	case ma_overflow:
 		/* Overflowed before, but the max changed */
-		mas->node = MAS_START;
-	} else if (mas_is_underflow(mas)) {
-		mas->node = MAS_START;
+		mas->status = ma_active;
+		break;
+	case ma_underflow:
+		/* The user expects the mas to be one before where it is */
+		mas->status = ma_active;
 		*entry = mas_walk(mas);
 		if (*entry)
 			return true;
+		break;
+	case ma_root:
+		break;
+	case ma_error:
+		return true;
 	}
 
-	if (mas_is_start(mas))
-		*entry = mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
+	if (likely(mas_is_active(mas))) /* Fast path */
+		return false;
 
 	if (mas_is_ptr(mas)) {
 		*entry = NULL;
@@ -5713,7 +5742,7 @@ static bool mas_next_setup(struct ma_state *mas, unsigned long max,
 		}
 		mas->index = 1;
 		mas->last = ULONG_MAX;
-		mas->node = MAS_NONE;
+		mas->status = ma_none;
 		return true;
 	}
 
@@ -5742,7 +5771,7 @@ void *mas_next(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false, true);
+	return mas_next_slot(mas, max, false);
 }
 EXPORT_SYMBOL_GPL(mas_next);
 
@@ -5765,7 +5794,7 @@ void *mas_next_range(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, true, true);
+	return mas_next_slot(mas, max, true);
 }
 EXPORT_SYMBOL_GPL(mas_next_range);
 
@@ -5796,33 +5825,45 @@ EXPORT_SYMBOL_GPL(mt_next);
 static bool mas_prev_setup(struct ma_state *mas, unsigned long min, void **entry)
 {
 	if (unlikely(mas->index <= min)) {
-		mas->node = MAS_UNDERFLOW;
+		mas->status = ma_underflow;
 		return true;
 	}
 
-	if (mas_is_active(mas))
+	switch (mas->status) {
+	case ma_active:
 		return false;
-
-	if (mas_is_overflow(mas)) {
-		mas->node = MAS_START;
+	case ma_start:
+		break;
+	case ma_none:
+		fallthrough;
+	case ma_pause:
+		mas->status = ma_start;
+		break;
+	case ma_underflow:
+		/* underflowed before but the min changed */
+		mas->status = ma_active;
+		break;
+	case ma_overflow:
+		/* User expects mas to be one after where it is */
+		mas->status = ma_active;
 		*entry = mas_walk(mas);
 		if (*entry)
 			return true;
-	}
-
-	if (mas_is_none(mas) || mas_is_paused(mas)) {
-		mas->node = MAS_START;
-	} else if (mas_is_underflow(mas)) {
-		/* underflowed before but the min changed */
-		mas->node = MAS_START;
+		break;
+	case ma_root:
+		break;
+	case ma_error:
+		return true;
 	}
 
 	if (mas_is_start(mas))
 		mas_walk(mas);
 
 	if (unlikely(mas_is_ptr(mas))) {
-		if (!mas->index)
-			goto none;
+		if (!mas->index) {
+			mas->status = ma_none;
+			return true;
+		}
 		mas->index = mas->last = 0;
 		*entry = mas_root(mas);
 		return true;
@@ -5832,7 +5873,7 @@ static bool mas_prev_setup(struct ma_state *mas, unsigned long min, void **entry
 		if (mas->index) {
 			/* Walked to out-of-range pointer? */
 			mas->index = mas->last = 0;
-			mas->node = MAS_ROOT;
+			mas->status = ma_root;
 			*entry = mas_root(mas);
 			return true;
 		}
@@ -5840,10 +5881,6 @@ static bool mas_prev_setup(struct ma_state *mas, unsigned long min, void **entry
 	}
 
 	return false;
-
-none:
-	mas->node = MAS_NONE;
-	return true;
 }
 
 /**
@@ -5852,7 +5889,7 @@ static bool mas_prev_setup(struct ma_state *mas, unsigned long min, void **entry
  * @min: The minimum value to check.
  *
  * Must hold rcu_read_lock or the write lock.
- * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
+ * Will reset mas to ma_start if the status is ma_none.  Will stop on not
  * searchable nodes.
  *
  * Return: the previous value or %NULL.
@@ -5864,7 +5901,7 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 	if (mas_prev_setup(mas, min, &entry))
 		return entry;
 
-	return mas_prev_slot(mas, min, false, true);
+	return mas_prev_slot(mas, min, false);
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
@@ -5875,7 +5912,7 @@ EXPORT_SYMBOL_GPL(mas_prev);
  *
  * Sets @mas->index and @mas->last to the range.
  * Must hold rcu_read_lock or the write lock.
- * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
+ * Will reset mas to ma_start if the node is ma_none.  Will stop on not
  * searchable nodes.
  *
  * Return: the previous value or %NULL.
@@ -5887,7 +5924,7 @@ void *mas_prev_range(struct ma_state *mas, unsigned long min)
 	if (mas_prev_setup(mas, min, &entry))
 		return entry;
 
-	return mas_prev_slot(mas, min, true, true);
+	return mas_prev_slot(mas, min, true);
 }
 EXPORT_SYMBOL_GPL(mas_prev_range);
 
@@ -5930,7 +5967,8 @@ EXPORT_SYMBOL_GPL(mt_prev);
  */
 void mas_pause(struct ma_state *mas)
 {
-	mas->node = MAS_PAUSE;
+	mas->status = ma_pause;
+	mas->node = NULL;
 }
 EXPORT_SYMBOL_GPL(mas_pause);
 
@@ -5944,32 +5982,52 @@ EXPORT_SYMBOL_GPL(mas_pause);
  */
 static __always_inline bool mas_find_setup(struct ma_state *mas, unsigned long max, void **entry)
 {
-	if (mas_is_active(mas)) {
+	switch (mas->status) {
+	case ma_active:
 		if (mas->last < max)
 			return false;
-
 		return true;
-	}
-
-	if (mas_is_paused(mas)) {
+	case ma_start:
+		break;
+	case ma_pause:
 		if (unlikely(mas->last >= max))
 			return true;
 
 		mas->index = ++mas->last;
-		mas->node = MAS_START;
-	} else if (mas_is_none(mas)) {
+		mas->status = ma_start;
+		break;
+	case ma_none:
 		if (unlikely(mas->last >= max))
 			return true;
 
 		mas->index = mas->last;
-		mas->node = MAS_START;
-	} else if (mas_is_overflow(mas) || mas_is_underflow(mas)) {
-		if (mas->index > max) {
-			mas->node = MAS_OVERFLOW;
+		mas->status = ma_start;
+		break;
+	case ma_underflow:
+		/* mas is pointing at entry before unable to go lower */
+		if (unlikely(mas->index >= max)) {
+			mas->status = ma_overflow;
 			return true;
 		}
 
-		mas->node = MAS_START;
+		mas->status = ma_active;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
+		break;
+	case ma_overflow:
+		if (unlikely(mas->last >= max))
+			return true;
+
+		mas->status = ma_active;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
+		break;
+	case ma_root:
+		break;
+	case ma_error:
+		return true;
 	}
 
 	if (mas_is_start(mas)) {
@@ -5996,7 +6054,7 @@ static __always_inline bool mas_find_setup(struct ma_state *mas, unsigned long m
 	return false;
 
 ptr_out_of_range:
-	mas->node = MAS_NONE;
+	mas->status = ma_none;
 	mas->index = 1;
 	mas->last = ULONG_MAX;
 	return true;
@@ -6010,7 +6068,7 @@ static __always_inline bool mas_find_setup(struct ma_state *mas, unsigned long m
  *
  * Must hold rcu_read_lock or the write lock.
  * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * May set @mas->status to ma_overflow.
  *
  * Return: The entry or %NULL.
  */
@@ -6022,7 +6080,10 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false, false);
+	entry = mas_next_slot(mas, max, false);
+	/* Ignore overflow */
+	mas->status = ma_active;
+	return entry;
 }
 EXPORT_SYMBOL_GPL(mas_find);
 
@@ -6034,7 +6095,7 @@ EXPORT_SYMBOL_GPL(mas_find);
  *
  * Must hold rcu_read_lock or the write lock.
  * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * May set @mas->status to ma_overflow.
  *
  * Return: The entry or %NULL.
  */
@@ -6046,7 +6107,7 @@ void *mas_find_range(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, true, false);
+	return mas_next_slot(mas, max, true);
 }
 EXPORT_SYMBOL_GPL(mas_find_range);
 
@@ -6061,33 +6122,45 @@ EXPORT_SYMBOL_GPL(mas_find_range);
 static bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
 		void **entry)
 {
-	if (mas_is_active(mas)) {
-		if (mas->index > min)
-			return false;
-
-		return true;
-	}
 
-	if (mas_is_paused(mas)) {
+	switch (mas->status) {
+	case ma_active:
+		goto active;
+	case ma_start:
+		break;
+	case ma_pause:
 		if (unlikely(mas->index <= min)) {
-			mas->node = MAS_NONE;
+			mas->status = ma_underflow;
 			return true;
 		}
-		mas->node = MAS_START;
 		mas->last = --mas->index;
-	} else if (mas_is_none(mas)) {
+		mas->status = ma_start;
+		break;
+	case ma_none:
 		if (mas->index <= min)
 			goto none;
 
 		mas->last = mas->index;
-		mas->node = MAS_START;
-	} else if (mas_is_underflow(mas) || mas_is_overflow(mas)) {
-		if (mas->last <= min) {
-			mas->node = MAS_UNDERFLOW;
+		mas->status = ma_start;
+		break;
+	case ma_overflow: /* user expects the mas to be one after where it is */
+		if (unlikely(mas->index <= min)) {
+			mas->status = ma_underflow;
 			return true;
 		}
 
-		mas->node = MAS_START;
+		mas->status = ma_active;
+		break;
+	case ma_underflow: /* user expects the mas to be one before where it is */
+		if (unlikely(mas->index <= min))
+			return true;
+
+		mas->status = ma_active;
+		break;
+	case ma_root:
+		break;
+	case ma_error:
+		return true;
 	}
 
 	if (mas_is_start(mas)) {
@@ -6110,19 +6183,20 @@ static bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
 			 * previous location is 0.
 			 */
 			mas->last = mas->index = 0;
-			mas->node = MAS_ROOT;
+			mas->status = ma_root;
 			*entry = mas_root(mas);
 			return true;
 		}
 	}
 
+active:
 	if (mas->index < min)
 		return true;
 
 	return false;
 
 none:
-	mas->node = MAS_NONE;
+	mas->status = ma_none;
 	return true;
 }
 
@@ -6135,7 +6209,7 @@ static bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
  *
  * Must hold rcu_read_lock or the write lock.
  * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * May set @mas->status to ma_underflow.
  *
  * Return: The entry or %NULL.
  */
@@ -6147,7 +6221,7 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, false, false);
+	return mas_prev_slot(mas, min, false);
 
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
@@ -6161,7 +6235,7 @@ EXPORT_SYMBOL_GPL(mas_find_rev);
  *
  * Must hold rcu_read_lock or the write lock.
  * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * May set @mas->status to ma_underflow.
  *
  * Return: The entry or %NULL.
  */
@@ -6173,7 +6247,7 @@ void *mas_find_range_rev(struct ma_state *mas, unsigned long min)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, true, false);
+	return mas_prev_slot(mas, min, true);
 }
 EXPORT_SYMBOL_GPL(mas_find_range_rev);
 
@@ -6194,7 +6268,7 @@ void *mas_erase(struct ma_state *mas)
 	MA_WR_STATE(wr_mas, mas, NULL);
 
 	if (!mas_is_active(mas) || !mas_is_start(mas))
-		mas->node = MAS_START;
+		mas->status = ma_start;
 
 	/* Retry unnecessary when holding the write lock. */
 	entry = mas_state_walk(mas);
@@ -6239,7 +6313,7 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 	if (!mas_allocated(mas))
 		return false;
 
-	mas->node = MAS_START;
+	mas->status = ma_start;
 	return true;
 }
 
@@ -6638,7 +6712,7 @@ static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
 
 	node = mt_alloc_one(gfp);
 	if (!node) {
-		new_mas->node = MAS_NONE;
+		new_mas->status = ma_none;
 		mas_set_err(mas, -ENOMEM);
 		return;
 	}
@@ -6982,11 +7056,11 @@ static inline struct maple_enode *mas_get_slot(struct ma_state *mas,
 static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 {
 
-	struct maple_enode *p = MAS_NONE, *mn = mas->node;
+	struct maple_enode *p, *mn = mas->node;
 	unsigned long p_min, p_max;
 
 	mas_next_node(mas, mas_mn(mas), max);
-	if (!mas_is_none(mas))
+	if (!mas_is_overflow(mas))
 		return;
 
 	if (mte_is_root(mn))
@@ -6999,7 +7073,7 @@ static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 		p_min = mas->min;
 		p_max = mas->max;
 		mas_prev_node(mas, 0);
-	} while (!mas_is_none(mas));
+	} while (!mas_is_underflow(mas));
 
 	mas->node = p;
 	mas->max = p_max;
@@ -7454,7 +7528,7 @@ static void mt_validate_nulls(struct maple_tree *mt)
 	MA_STATE(mas, mt, 0, 0);
 
 	mas_start(&mas);
-	if (mas_is_none(&mas) || (mas.node == MAS_ROOT))
+	if (mas_is_none(&mas) || (mas_is_ptr(&mas)))
 		return;
 
 	while (!mte_is_leaf(mas.node))
@@ -7471,7 +7545,7 @@ static void mt_validate_nulls(struct maple_tree *mt)
 		last = entry;
 		if (offset == mas_data_end(&mas)) {
 			mas_next_node(&mas, mas_mn(&mas), ULONG_MAX);
-			if (mas_is_none(&mas))
+			if (mas_is_overflow(&mas))
 				return;
 			offset = 0;
 			slots = ma_slots(mte_to_node(mas.node),
@@ -7480,7 +7554,7 @@ static void mt_validate_nulls(struct maple_tree *mt)
 			offset++;
 		}
 
-	} while (!mas_is_none(&mas));
+	} while (!mas_is_overflow(&mas));
 }
 
 /*
@@ -7501,7 +7575,7 @@ void mt_validate(struct maple_tree *mt)
 	while (!mte_is_leaf(mas.node))
 		mas_descend(&mas);
 
-	while (!mas_is_none(&mas)) {
+	while (!mas_is_overflow(&mas)) {
 		MAS_WARN_ON(&mas, mte_dead_node(mas.node));
 		end = mas_data_end(&mas);
 		if (MAS_WARN_ON(&mas, (end < mt_min_slot_count(mas.node)) &&
@@ -7526,16 +7600,35 @@ EXPORT_SYMBOL_GPL(mt_validate);
 void mas_dump(const struct ma_state *mas)
 {
 	pr_err("MAS: tree=%p enode=%p ", mas->tree, mas->node);
-	if (mas_is_none(mas))
-		pr_err("(MAS_NONE) ");
-	else if (mas_is_ptr(mas))
-		pr_err("(MAS_ROOT) ");
-	else if (mas_is_start(mas))
-		 pr_err("(MAS_START) ");
-	else if (mas_is_paused(mas))
-		pr_err("(MAS_PAUSED) ");
-
-	pr_err("[%u] index=%lx last=%lx\n", mas->offset, mas->index, mas->last);
+	switch (mas->status) {
+	case ma_active:
+		pr_err("(ma_active)");
+		break;
+	case ma_none:
+		pr_err("(ma_none)");
+		break;
+	case ma_root:
+		pr_err("(ma_root)");
+		break;
+	case ma_start:
+		pr_err("(ma_start) ");
+		break;
+	case ma_pause:
+		pr_err("(ma_pause) ");
+		break;
+	case ma_overflow:
+		pr_err("(ma_overflow) ");
+		break;
+	case ma_underflow:
+		pr_err("(ma_underflow) ");
+		break;
+	case ma_error:
+		pr_err("(ma_error) ");
+		break;
+	}
+
+	pr_err("[%u/%u] index=%lx last=%lx\n", mas->offset, mas->end,
+	       mas->index, mas->last);
 	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
 	       mas->min, mas->max, mas->alloc, mas->depth, mas->mas_flags);
 	if (mas->index > mas->last)
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index de470950714f..f9acc6ef0728 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -54,6 +54,11 @@ atomic_t maple_tree_tests_passed;
 #else
 #define cond_resched()			do {} while (0)
 #endif
+
+#define mas_is_none(x)		((x)->status == ma_none)
+#define mas_is_overflow(x)	((x)->status == ma_overflow)
+#define mas_is_underflow(x)	((x)->status == ma_underflow)
+
 static int __init mtree_insert_index(struct maple_tree *mt,
 				     unsigned long index, gfp_t gfp)
 {
@@ -582,7 +587,7 @@ static noinline void __init check_find(struct maple_tree *mt)
 	MT_BUG_ON(mt, last != mas.last);
 
 
-	mas.node = MAS_NONE;
+	mas.status = ma_none;
 	mas.index = ULONG_MAX;
 	mas.last = ULONG_MAX;
 	entry2 = mas_prev(&mas, 0);
@@ -2175,7 +2180,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 5);
-	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	mas.index = 0;
 	mas.last = 5;
@@ -3039,10 +3044,6 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		DNE	active		active		range of NULL
  */
 
-#define mas_active(x)		(((x).node != MAS_ROOT) && \
-				 ((x).node != MAS_START) && \
-				 ((x).node != MAS_PAUSE) && \
-				 ((x).node != MAS_NONE))
 static noinline void __init check_state_handling(struct maple_tree *mt)
 {
 	MA_STATE(mas, mt, 0, 0);
@@ -3057,7 +3058,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	/* prev: Start -> underflow*/
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
-	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+	MT_BUG_ON(mt, mas.status != ma_underflow);
 
 	/* prev: Start -> root */
 	mas_set(&mas, 10);
@@ -3065,7 +3066,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* prev: pause -> root */
 	mas_set(&mas, 10);
@@ -3074,7 +3075,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* next: start -> none */
 	mas_set(&mas, 0);
@@ -3082,7 +3083,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* next: start -> none*/
 	mas_set(&mas, 10);
@@ -3090,7 +3091,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* find: start -> root */
 	mas_set(&mas, 0);
@@ -3098,21 +3099,21 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* find: root -> none */
 	entry = mas_find(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* find: none -> none */
 	entry = mas_find(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* find: start -> none */
 	mas_set(&mas, 10);
@@ -3120,14 +3121,14 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* find_rev: none -> root */
 	entry = mas_find_rev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* find_rev: start -> root */
 	mas_set(&mas, 0);
@@ -3135,21 +3136,21 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* find_rev: root -> none */
 	entry = mas_find_rev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* find_rev: none -> none */
 	entry = mas_find_rev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* find_rev: start -> root */
 	mas_set(&mas, 10);
@@ -3157,7 +3158,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* walk: start -> none */
 	mas_set(&mas, 10);
@@ -3165,7 +3166,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* walk: pause -> none*/
 	mas_set(&mas, 10);
@@ -3174,7 +3175,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* walk: none -> none */
 	mas.index = mas.last = 10;
@@ -3182,14 +3183,14 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* walk: none -> none */
 	entry = mas_walk(&mas);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* walk: start -> root */
 	mas_set(&mas, 0);
@@ -3197,7 +3198,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* walk: pause -> root */
 	mas_set(&mas, 0);
@@ -3206,22 +3207,22 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* walk: none -> root */
-	mas.node = MAS_NONE;
+	mas.status = ma_none;
 	entry = mas_walk(&mas);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* walk: root -> root */
 	entry = mas_walk(&mas);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* walk: root -> none */
 	mas_set(&mas, 10);
@@ -3229,7 +3230,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* walk: none -> root */
 	mas.index = mas.last = 0;
@@ -3237,7 +3238,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	mas_unlock(&mas);
 
@@ -3255,7 +3256,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* next: pause ->active */
 	mas_set(&mas, 0);
@@ -3264,126 +3265,132 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* next: none ->active */
 	mas.index = mas.last = 0;
 	mas.offset = 0;
-	mas.node = MAS_NONE;
+	mas.status = ma_none;
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* next:active ->active */
-	entry = mas_next(&mas, ULONG_MAX);
+	/* next:active ->active (spanning limit) */
+	entry = mas_next(&mas, 0x2100);
 	MT_BUG_ON(mt, entry != ptr2);
 	MT_BUG_ON(mt, mas.index != 0x2000);
 	MT_BUG_ON(mt, mas.last != 0x2500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* next:active -> active beyond data */
+	/* next:active -> overflow (limit reached) beyond data */
 	entry = mas_next(&mas, 0x2999);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x2501);
 	MT_BUG_ON(mt, mas.last != 0x2fff);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_overflow(&mas));
 
-	/* Continue after last range ends after max */
+	/* next:overflow -> active (limit changed) */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
 	MT_BUG_ON(mt, mas.last != 0x3500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* next:active -> active continued */
+	/* next:active ->  overflow (limit reached) */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x3501);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, !mas_active(mas));
-
-	/* next:active -> overflow  */
-	entry = mas_next(&mas, ULONG_MAX);
-	MT_BUG_ON(mt, entry != NULL);
-	MT_BUG_ON(mt, mas.index != 0x3501);
-	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_OVERFLOW);
+	MT_BUG_ON(mt, !mas_is_overflow(&mas));
 
 	/* next:overflow -> overflow  */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x3501);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_OVERFLOW);
+	MT_BUG_ON(mt, !mas_is_overflow(&mas));
 
 	/* prev:overflow -> active  */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
 	MT_BUG_ON(mt, mas.last != 0x3500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* next: none -> active, skip value at location */
 	mas_set(&mas, 0);
 	entry = mas_next(&mas, ULONG_MAX);
-	mas.node = MAS_NONE;
+	mas.status = ma_none;
 	mas.offset = 0;
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr2);
 	MT_BUG_ON(mt, mas.index != 0x2000);
 	MT_BUG_ON(mt, mas.last != 0x2500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* prev:active ->active */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* prev:active -> active spanning end range */
+	/* prev:active -> underflow (span limit) */
+	mas_next(&mas, ULONG_MAX);
+	entry = mas_prev(&mas, 0x1200);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_is_active(&mas)); /* spanning limit */
+	entry = mas_prev(&mas, 0x1200); /* underflow */
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
+
+	/* prev:underflow -> underflow (lower limit) spanning end range */
 	entry = mas_prev(&mas, 0x0100);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0x0FFF);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
-	/* prev:active -> underflow */
+	/* prev:underflow -> underflow */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0x0FFF);
-	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	/* prev:underflow -> underflow */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0x0FFF);
-	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	/* next:underflow -> active */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* prev:first value -> underflow */
 	entry = mas_prev(&mas, 0x1000);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	/* find:underflow -> first value */
 	entry = mas_find(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* prev: pause ->active */
 	mas_set(&mas, 0x3600);
@@ -3394,21 +3401,21 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr2);
 	MT_BUG_ON(mt, mas.index != 0x2000);
 	MT_BUG_ON(mt, mas.last != 0x2500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* prev:active -> active spanning min */
+	/* prev:active -> underflow spanning min */
 	entry = mas_prev(&mas, 0x1600);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1FFF);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	/* prev: active ->active, continue */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find: start ->active */
 	mas_set(&mas, 0);
@@ -3416,7 +3423,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find: pause ->active */
 	mas_set(&mas, 0);
@@ -3425,7 +3432,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find: start ->active on value */;
 	mas_set(&mas, 1200);
@@ -3433,14 +3440,14 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find:active ->active */
 	entry = mas_find(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr2);
 	MT_BUG_ON(mt, mas.index != 0x2000);
 	MT_BUG_ON(mt, mas.last != 0x2500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 
 	/* find:active -> active (NULL)*/
@@ -3448,35 +3455,35 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x2501);
 	MT_BUG_ON(mt, mas.last != 0x2FFF);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MAS_BUG_ON(&mas, !mas_is_active(&mas));
 
 	/* find: overflow ->active */
 	entry = mas_find(&mas, 0x5000);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
 	MT_BUG_ON(mt, mas.last != 0x3500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find:active -> active (NULL) end*/
 	entry = mas_find(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x3501);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MAS_BUG_ON(&mas, !mas_is_active(&mas));
 
 	/* find_rev: active (END) ->active */
 	entry = mas_find_rev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
 	MT_BUG_ON(mt, mas.last != 0x3500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find_rev:active ->active */
 	entry = mas_find_rev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr2);
 	MT_BUG_ON(mt, mas.index != 0x2000);
 	MT_BUG_ON(mt, mas.last != 0x2500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find_rev: pause ->active */
 	mas_pause(&mas);
@@ -3484,14 +3491,14 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* find_rev:active -> active */
+	/* find_rev:active -> underflow */
 	entry = mas_find_rev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0x0FFF);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	/* find_rev: start ->active */
 	mas_set(&mas, 0x1200);
@@ -3499,7 +3506,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk start ->active */
 	mas_set(&mas, 0x1200);
@@ -3507,7 +3514,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk start ->active */
 	mas_set(&mas, 0x1600);
@@ -3515,7 +3522,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1fff);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk pause ->active */
 	mas_set(&mas, 0x1200);
@@ -3524,7 +3531,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk pause -> active */
 	mas_set(&mas, 0x1600);
@@ -3533,25 +3540,25 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1fff);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk none -> active */
 	mas_set(&mas, 0x1200);
-	mas.node = MAS_NONE;
+	mas.status = ma_none;
 	entry = mas_walk(&mas);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk none -> active */
 	mas_set(&mas, 0x1600);
-	mas.node = MAS_NONE;
+	mas.status = ma_none;
 	entry = mas_walk(&mas);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1fff);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk active -> active */
 	mas.index = 0x1200;
@@ -3561,7 +3568,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk active -> active */
 	mas.index = 0x1600;
@@ -3570,7 +3577,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1fff);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	mas_unlock(&mas);
 }
diff --git a/mm/internal.h b/mm/internal.h
index 8212179b8566..b29f9693b0f2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1107,13 +1107,13 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 {
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.status != ma_start &&
 			vmi->mas.index > vma->vm_start)) {
 		pr_warn("%lx > %lx\n store vma %lx-%lx\n into slot %lx-%lx\n",
 			vmi->mas.index, vma->vm_start, vma->vm_start,
 			vma->vm_end, vmi->mas.index, vmi->mas.last);
 	}
-	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.status != ma_start &&
 			vmi->mas.last <  vma->vm_start)) {
 		pr_warn("%lx < %lx\nstore vma %lx-%lx\ninto slot %lx-%lx\n",
 		       vmi->mas.last, vma->vm_start, vma->vm_start, vma->vm_end,
@@ -1121,7 +1121,7 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 	}
 #endif
 
-	if (vmi->mas.node != MAS_START &&
+	if (vmi->mas.status != ma_start &&
 	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
 		vma_iter_invalidate(vmi);
 
@@ -1132,7 +1132,7 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 			struct vm_area_struct *vma, gfp_t gfp)
 {
-	if (vmi->mas.node != MAS_START &&
+	if (vmi->mas.status != ma_start &&
 	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
 		vma_iter_invalidate(vmi);
 
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 1c86ae3f8186..d630e86052f9 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -118,6 +118,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.alloc == NULL);
 	MT_BUG_ON(mt, mas.alloc->slot[0] == NULL);
 	mas_push_node(&mas, mn);
+	mas_reset(&mas);
 	mas_nomem(&mas, GFP_KERNEL); /* free */
 	mtree_unlock(mt);
 
@@ -141,7 +142,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
-	mas.node = MAS_START;
+	mas.status = ma_start;
 	mas_nomem(&mas, GFP_KERNEL);
 	/* Allocate 3 nodes, will fail. */
 	mas_node_count(&mas, 3);
@@ -158,6 +159,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	/* Ensure we counted 3. */
 	MT_BUG_ON(mt, mas_allocated(&mas) != 3);
 	/* Free. */
+	mas_reset(&mas);
 	mas_nomem(&mas, GFP_KERNEL);
 
 	/* Set allocation request to 1. */
@@ -272,6 +274,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 			ma_free_rcu(mn);
 			MT_BUG_ON(mt, mas_allocated(&mas) != i - j - 1);
 		}
+		mas_reset(&mas);
 		MT_BUG_ON(mt, mas_nomem(&mas, GFP_KERNEL));
 
 	}
@@ -294,6 +297,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 		smn = smn->slot[0]; /* next. */
 	}
 	MT_BUG_ON(mt, mas_allocated(&mas) != total);
+	mas_reset(&mas);
 	mas_nomem(&mas, GFP_KERNEL); /* Free. */
 
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
@@ -441,7 +445,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	mas.node = MA_ERROR(-ENOMEM);
 	mas_node_count(&mas, 10); /* Request */
 	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-	mas.node = MAS_START;
+	mas.status = ma_start;
 	MT_BUG_ON(mt, mas_allocated(&mas) != 10);
 	mas_destroy(&mas);
 
@@ -452,7 +456,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	mas.node = MA_ERROR(-ENOMEM);
 	mas_node_count(&mas, 10 + MAPLE_ALLOC_SLOTS - 1); /* Request */
 	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-	mas.node = MAS_START;
+	mas.status = ma_start;
 	MT_BUG_ON(mt, mas_allocated(&mas) != 10 + MAPLE_ALLOC_SLOTS - 1);
 	mas_destroy(&mas);
 
@@ -941,7 +945,7 @@ static inline bool mas_tree_walk(struct ma_state *mas, unsigned long *range_min,
 
 	ret = mas_descend_walk(mas, range_min, range_max);
 	if (unlikely(mte_dead_node(mas->node))) {
-		mas->node = MAS_START;
+		mas->status = ma_start;
 		goto retry;
 	}
 
@@ -961,10 +965,10 @@ static inline void *mas_range_load(struct ma_state *mas,
 	unsigned long index = mas->index;
 
 	if (mas_is_none(mas) || mas_is_paused(mas))
-		mas->node = MAS_START;
+		mas->status = ma_start;
 retry:
 	if (mas_tree_walk(mas, range_min, range_max))
-		if (unlikely(mas->node == MAS_ROOT))
+		if (unlikely(mas->status == ma_root))
 			return mas_root(mas);
 
 	if (likely(mas->offset != MAPLE_NODE_SLOTS))
@@ -35337,7 +35341,7 @@ static void mas_dfs_preorder(struct ma_state *mas)
 	unsigned char end, slot = 0;
 	unsigned long *pivots;
 
-	if (mas->node == MAS_START) {
+	if (mas->status == ma_start) {
 		mas_start(mas);
 		return;
 	}
@@ -35374,7 +35378,7 @@ static void mas_dfs_preorder(struct ma_state *mas)
 
 	return;
 done:
-	mas->node = MAS_NONE;
+	mas->status = ma_none;
 }
 
 
@@ -35833,7 +35837,7 @@ static noinline void __init check_nomem(struct maple_tree *mt)
 	mas_store(&ms, &ms); /* insert 1 -> &ms, fails. */
 	MT_BUG_ON(mt, ms.node != MA_ERROR(-ENOMEM));
 	mas_nomem(&ms, GFP_KERNEL); /* Node allocated in here. */
-	MT_BUG_ON(mt, ms.node != MAS_START);
+	MT_BUG_ON(mt, ms.status != ma_start);
 	mtree_unlock(mt);
 	MT_BUG_ON(mt, mtree_insert(mt, 2, mt, GFP_KERNEL) != 0);
 	mtree_lock(mt);
@@ -35952,7 +35956,7 @@ static int __init compare_tree(struct maple_tree *mt_a, struct maple_tree *mt_b)
 
 	if (mas_is_ptr(&mas_a) || mas_is_ptr(&mas_b)) {
 		if (!(mas_is_ptr(&mas_a) && mas_is_ptr(&mas_b))) {
-			pr_err("One is MAS_ROOT and the other is not.\n");
+			pr_err("One is ma_root and the other is not.\n");
 			return -1;
 		}
 		return 0;
@@ -35961,7 +35965,7 @@ static int __init compare_tree(struct maple_tree *mt_a, struct maple_tree *mt_b)
 	while (!mas_is_none(&mas_a) || !mas_is_none(&mas_b)) {
 
 		if (mas_is_none(&mas_a) || mas_is_none(&mas_b)) {
-			pr_err("One is MAS_NONE and the other is not.\n");
+			pr_err("One is ma_none and the other is not.\n");
 			return -1;
 		}
 
-- 
2.39.2


