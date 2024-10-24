Return-Path: <linux-fsdevel+bounces-32751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F419AE668
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4925B1F264B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9A1FBF7A;
	Thu, 24 Oct 2024 13:25:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA81FAF06;
	Thu, 24 Oct 2024 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776325; cv=none; b=PaO6Oyd6KNIxvjITAVYTyF0FhlOZhTlFnsTSwUIZl5RzJW+gSQe50mDnPLg9aB8ts5wNVw8aWPHZY9qSM4HfAkACcelAZXA7HulcZMwS1W9N/gSRn+6OYktfuXQSrbbVzte3Uw5Ds6HEPfxbjcCjv7u9FUwMQa1HyceC3Q9nYqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776325; c=relaxed/simple;
	bh=qJpcOsMLDVQKKkrCG5wwxVuzpFMAoxIagkpp1nJIVp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwiAS9UTjIFqa5eqlqeEBANmUhhvvnZvFByfOVPcQxhGQCrAfG3EbeVHQwHR8eyeXroeL+FNHG9usr3VmQ2yOUkeFf4k3BTsByHlKRBrbHUd1ibQzfgZlsDcXPpMpYe21834u7fYAPvPqpaeBzcveQFBn4J9PHDFUONGKRmLAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZ68y5BpWz4f3m8F;
	Thu, 24 Oct 2024 21:25:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 188D01A0196;
	Thu, 24 Oct 2024 21:25:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMmxShpnmfz6Ew--.42902S13;
	Thu, 24 Oct 2024 21:25:18 +0800 (CST)
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
Subject: [PATCH 6.6 25/28] maple_tree: Add mtree_alloc_cyclic()
Date: Thu, 24 Oct 2024 21:22:22 +0800
Message-Id: <20241024132225.2271667-10-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3LMmxShpnmfz6Ew--.42902S13
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyDZF1UKr13ur47CFWUXFb_yoW7ZrWkpF
	WkG345trsIq3yxGr93ZF4UJr13ur48Xw4xtFZFq348ZF9xGF1Sgr1DC3WYvrWUCFWDXFya
	yayYvw4kCrsrJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnI
	WIevJa73UjIFyTuYvjTRGg4SUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Chuck Lever <chuck.lever@oracle.com>

commit 9b6713cc75229f25552c643083cbdbfb771e5bca upstream.

I need a cyclic allocator for the simple_offset implementation in
fs/libfs.c.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/170820144179.6328.12838600511394432325.stgit@91.116.238.104.host.secureserver.net
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 include/linux/maple_tree.h |  7 +++
 lib/maple_tree.c           | 93 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index b3d63123b945..a53ad4dabd7e 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -171,6 +171,7 @@ enum maple_type {
 #define MT_FLAGS_LOCK_IRQ	0x100
 #define MT_FLAGS_LOCK_BH	0x200
 #define MT_FLAGS_LOCK_EXTERN	0x300
+#define MT_FLAGS_ALLOC_WRAPPED	0x0800
 
 #define MAPLE_HEIGHT_MAX	31
 
@@ -319,6 +320,9 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 		void *entry, unsigned long size, unsigned long min,
 		unsigned long max, gfp_t gfp);
+int mtree_alloc_cyclic(struct maple_tree *mt, unsigned long *startp,
+		void *entry, unsigned long range_lo, unsigned long range_hi,
+		unsigned long *next, gfp_t gfp);
 int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 		void *entry, unsigned long size, unsigned long min,
 		unsigned long max, gfp_t gfp);
@@ -499,6 +503,9 @@ void *mas_find_range(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
 void *mas_find_range_rev(struct ma_state *mas, unsigned long max);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
+int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
+		void *entry, unsigned long range_lo, unsigned long range_hi,
+		unsigned long *next, gfp_t gfp);
 
 bool mas_nomem(struct ma_state *mas, gfp_t gfp);
 void mas_pause(struct ma_state *mas);
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1af83414877a..5328e08723d7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4337,6 +4337,56 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 
 }
 
+/**
+ * mas_alloc_cyclic() - Internal call to find somewhere to store an entry
+ * @mas: The maple state.
+ * @startp: Pointer to ID.
+ * @range_lo: Lower bound of range to search.
+ * @range_hi: Upper bound of range to search.
+ * @entry: The entry to store.
+ * @next: Pointer to next ID to allocate.
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ * Return: 0 if the allocation succeeded without wrapping, 1 if the
+ * allocation succeeded after wrapping, or -EBUSY if there are no
+ * free entries.
+ */
+int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
+		void *entry, unsigned long range_lo, unsigned long range_hi,
+		unsigned long *next, gfp_t gfp)
+{
+	unsigned long min = range_lo;
+	int ret = 0;
+
+	range_lo = max(min, *next);
+	ret = mas_empty_area(mas, range_lo, range_hi, 1);
+	if ((mas->tree->ma_flags & MT_FLAGS_ALLOC_WRAPPED) && ret == 0) {
+		mas->tree->ma_flags &= ~MT_FLAGS_ALLOC_WRAPPED;
+		ret = 1;
+	}
+	if (ret < 0 && range_lo > min) {
+		ret = mas_empty_area(mas, min, range_hi, 1);
+		if (ret == 0)
+			ret = 1;
+	}
+	if (ret < 0)
+		return ret;
+
+	do {
+		mas_insert(mas, entry);
+	} while (mas_nomem(mas, gfp));
+	if (mas_is_err(mas))
+		return xa_err(mas->node);
+
+	*startp = mas->index;
+	*next = *startp + 1;
+	if (*next == 0)
+		mas->tree->ma_flags |= MT_FLAGS_ALLOC_WRAPPED;
+
+	return ret;
+}
+EXPORT_SYMBOL(mas_alloc_cyclic);
+
 static __always_inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 {
 retry:
@@ -6490,6 +6540,49 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 }
 EXPORT_SYMBOL(mtree_alloc_range);
 
+/**
+ * mtree_alloc_cyclic() - Find somewhere to store this entry in the tree.
+ * @mt: The maple tree.
+ * @startp: Pointer to ID.
+ * @range_lo: Lower bound of range to search.
+ * @range_hi: Upper bound of range to search.
+ * @entry: The entry to store.
+ * @next: Pointer to next ID to allocate.
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ * Finds an empty entry in @mt after @next, stores the new index into
+ * the @id pointer, stores the entry at that index, then updates @next.
+ *
+ * @mt must be initialized with the MT_FLAGS_ALLOC_RANGE flag.
+ *
+ * Context: Any context.  Takes and releases the mt.lock.  May sleep if
+ * the @gfp flags permit.
+ *
+ * Return: 0 if the allocation succeeded without wrapping, 1 if the
+ * allocation succeeded after wrapping, -ENOMEM if memory could not be
+ * allocated, -EINVAL if @mt cannot be used, or -EBUSY if there are no
+ * free entries.
+ */
+int mtree_alloc_cyclic(struct maple_tree *mt, unsigned long *startp,
+		void *entry, unsigned long range_lo, unsigned long range_hi,
+		unsigned long *next, gfp_t gfp)
+{
+	int ret;
+
+	MA_STATE(mas, mt, 0, 0);
+
+	if (!mt_is_alloc(mt))
+		return -EINVAL;
+	if (WARN_ON_ONCE(mt_is_reserved(entry)))
+		return -EINVAL;
+	mtree_lock(mt);
+	ret = mas_alloc_cyclic(&mas, startp, entry, range_lo, range_hi,
+			       next, gfp);
+	mtree_unlock(mt);
+	return ret;
+}
+EXPORT_SYMBOL(mtree_alloc_cyclic);
+
 int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 		void *entry, unsigned long size, unsigned long min,
 		unsigned long max, gfp_t gfp)
-- 
2.39.2


