Return-Path: <linux-fsdevel+bounces-32744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582309AE64F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0D21C21908
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDB41E7C33;
	Thu, 24 Oct 2024 13:25:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1B1E570C;
	Thu, 24 Oct 2024 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776316; cv=none; b=cIQNizprYlSBSoPuXRcBhvhsFwTPCM7iI+eF4z3rwEUD/peeggXYL0gBllrZO5zA9yyLswqDXURwvgHVV7ARJ2k3WsG86QfqxIOUZSKo1KZlmnHH/2x6HYzJz9+md0U+T2Ss5eenKJrsMSO9ePZbN/WqPdhfytahfWx0Y2HpC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776316; c=relaxed/simple;
	bh=x5/c8tuANtCq4EaRwlgqWxvTl7oE/NVLokn8SZvc8Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQSSwXi5yEiqFxZ9urxstQYYqS1pS2v642sSjD1EKF7lJuS1PZ15X3EXEoQUbRgJtD1TmKmHa0+oubxOrAtUQ9KqHD5uP5kpp8nojUJdpYROOwuloYP1Pn+nHeX1K1vY6fmYTiaNm/MPDfenh8G544sWONuFJ/fvmtzCHFSNmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZ68p3smgz4f3lX2;
	Thu, 24 Oct 2024 21:24:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E0B221A0196;
	Thu, 24 Oct 2024 21:25:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMmxShpnmfz6Ew--.42902S6;
	Thu, 24 Oct 2024 21:25:10 +0800 (CST)
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
Subject: [PATCH 6.6 18/28] maple_tree: don't find node end in mtree_lookup_walk()
Date: Thu, 24 Oct 2024 21:22:15 +0800
Message-Id: <20241024132225.2271667-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3LMmxShpnmfz6Ew--.42902S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAry3tryUGF4kCw43Gw1DGFg_yoW5Cw4fp3
	ZrGFy5tFyfAF4xWrWfKa18X34fXFs3Gr17t3yDGryrZFyUGw1Igr1rCryfurWagayxu3Wf
	Aa1Yqw18W3Z7JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
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
	Ja73UjIFyTuYvjTRGApnUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

commit 24662decdd44645e8f027d7912be962dd461d1aa upstream.

Since the pivot being set is now reliable, the optimized loop no longer
needs to find the node end.  The redundant check for a dead node can also
be avoided as there is no danger of using the wrong pivot since the
results will be thrown out in the case of a dead node by the later check.

This patch also adds a benchmark test for the function to the maple tree
test framework.  The benchmark shows an average increase performance of
5.98% over 3 runs with this commit.

Link: https://lkml.kernel.org/r/20231101171629.3612299-12-Liam.Howlett@oracle.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/maple_tree.c      | 12 +++---------
 lib/test_maple_tree.c | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 472aef7a3d5c..ad8bf3413889 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3742,23 +3742,17 @@ static inline void *mtree_lookup_walk(struct ma_state *mas)
 	enum maple_type type;
 	void __rcu **slots;
 	unsigned char end;
-	unsigned long max;
 
 	next = mas->node;
-	max = ULONG_MAX;
 	do {
-		offset = 0;
 		node = mte_to_node(next);
 		type = mte_node_type(next);
 		pivots = ma_pivots(node, type);
-		end = ma_data_end(node, type, pivots, max);
-		if (unlikely(ma_dead_node(node)))
-			goto dead_node;
+		end = mt_pivots[type];
+		offset = 0;
 		do {
-			if (pivots[offset] >= mas->index) {
-				max = pivots[offset];
+			if (pivots[offset] >= mas->index)
 				break;
-			}
 		} while (++offset < end);
 
 		slots = ma_slots(node, type);
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index f9acc6ef0728..26991888da14 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -43,6 +43,7 @@ atomic_t maple_tree_tests_passed;
 /* #define BENCH_NODE_STORE */
 /* #define BENCH_AWALK */
 /* #define BENCH_WALK */
+/* #define BENCH_LOAD */
 /* #define BENCH_MT_FOR_EACH */
 /* #define BENCH_FORK */
 /* #define BENCH_MAS_FOR_EACH */
@@ -1754,6 +1755,19 @@ static noinline void __init bench_walk(struct maple_tree *mt)
 }
 #endif
 
+#if defined(BENCH_LOAD)
+static noinline void __init bench_load(struct maple_tree *mt)
+{
+	int i, max = 2500, count = 550000000;
+
+	for (i = 0; i < max; i += 10)
+		mtree_store_range(mt, i, i + 5, xa_mk_value(i), GFP_KERNEL);
+
+	for (i = 0; i < count; i++)
+		mtree_load(mt, 1470);
+}
+#endif
+
 #if defined(BENCH_MT_FOR_EACH)
 static noinline void __init bench_mt_for_each(struct maple_tree *mt)
 {
@@ -3620,6 +3634,13 @@ static int __init maple_tree_seed(void)
 	mtree_destroy(&tree);
 	goto skip;
 #endif
+#if defined(BENCH_LOAD)
+#define BENCH
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	bench_load(&tree);
+	mtree_destroy(&tree);
+	goto skip;
+#endif
 #if defined(BENCH_FORK)
 #define BENCH
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-- 
2.39.2


