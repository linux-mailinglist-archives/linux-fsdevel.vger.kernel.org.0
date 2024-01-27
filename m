Return-Path: <linux-fsdevel+bounces-9157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C1483E943
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D607B27463
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BFC13FEF;
	Sat, 27 Jan 2024 02:02:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD6B65F;
	Sat, 27 Jan 2024 02:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320966; cv=none; b=kRJWo7v3XUBePZrHHCUJ6LL1gHs61zgFWhDuji5bVaijXAfXgPZbFj/mPrmYbzYeGhNT+9WfXdGH36zN0E0dKKXjZ1M86lUmYgWsGnt70oAo3G7tM12ruXBgsu6VHFceVjqpFJj9hp1WY3UrC2Dul130OIh9ch9J60i8FlPmgI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320966; c=relaxed/simple;
	bh=PH/0ZaXurrIcEe+ZEV4TMObaqqFSEIjL1SHGxIDWPxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2yPgOKy5lc6SwvcJvOsX2v0oZw6t0Uaw2F300Gd27aTY8pX7yl2D9nl2k/+kvjl+SnUnrVlnHGiL9ou8ht9fBll89oj5YRWDjYk9FRLys2AYia+DTZdvXjEd4uFhPJY4rzmFCi3N4STwp7/klezUZbgmqPcaYTQBV6CcDi3W3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TMHrW091Fz4f3lg1;
	Sat, 27 Jan 2024 10:02:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5E7F01A0171;
	Sat, 27 Jan 2024 10:02:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g40ZLRlGJtmCA--.7377S7;
	Sat, 27 Jan 2024 10:02:41 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [PATCH v3 03/26] ext4: correct the hole length returned by ext4_map_blocks()
Date: Sat, 27 Jan 2024 09:58:02 +0800
Message-Id: <20240127015825.1608160-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g40ZLRlGJtmCA--.7377S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1UCF4DJw13Xw47uFyrCrg_yoWxJr13pF
	Wfury5Gws8W34q93yxAF4UZr1rC3W8CrW7JrZ3tr1SyF15Jr48WF18KF12vFZ3tFWrJF1Y
	vr4jya4UCa1akaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoL0eDUUU
	U
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In ext4_map_blocks(), if we can't find a range of mapping in the
extents cache, we are calling ext4_ext_map_blocks() to search the real
path and ext4_ext_determine_hole() to determine the hole range. But if
the querying range was partially or completely overlaped by a delalloc
extent, we can't find it in the real extent path, so the returned hole
length could be incorrect.

Fortunately, ext4_ext_put_gap_in_cache() have already handle delalloc
extent, but it searches start from the expanded hole_start, doesn't
start from the querying range, so the delalloc extent found could not be
the one that overlaped the querying range, plus, it also didn't adjust
the hole length. Let's just remove ext4_ext_put_gap_in_cache(), handle
delalloc and insert adjusted hole extent in ext4_ext_determine_hole().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 111 +++++++++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d5efe076d3d3..e0b7e48c4c67 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2229,7 +2229,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
 
 
 /*
- * ext4_ext_determine_hole - determine hole around given block
+ * ext4_ext_find_hole - find hole around given block according to the given path
  * @inode:	inode we lookup in
  * @path:	path in extent tree to @lblk
  * @lblk:	pointer to logical block around which we want to determine hole
@@ -2241,9 +2241,9 @@ static int ext4_fill_es_cache_info(struct inode *inode,
  * The function returns the length of a hole starting at @lblk. We update @lblk
  * to the beginning of the hole if we managed to find it.
  */
-static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
-					   struct ext4_ext_path *path,
-					   ext4_lblk_t *lblk)
+static ext4_lblk_t ext4_ext_find_hole(struct inode *inode,
+				      struct ext4_ext_path *path,
+				      ext4_lblk_t *lblk)
 {
 	int depth = ext_depth(inode);
 	struct ext4_extent *ex;
@@ -2270,30 +2270,6 @@ static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
 	return len;
 }
 
-/*
- * ext4_ext_put_gap_in_cache:
- * calculate boundaries of the gap that the requested block fits into
- * and cache this gap
- */
-static void
-ext4_ext_put_gap_in_cache(struct inode *inode, ext4_lblk_t hole_start,
-			  ext4_lblk_t hole_len)
-{
-	struct extent_status es;
-
-	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
-				  hole_start + hole_len - 1, &es);
-	if (es.es_len) {
-		/* There's delayed extent containing lblock? */
-		if (es.es_lblk <= hole_start)
-			return;
-		hole_len = min(es.es_lblk - hole_start, hole_len);
-	}
-	ext_debug(inode, " -> %u:%u\n", hole_start, hole_len);
-	ext4_es_insert_extent(inode, hole_start, hole_len, ~0,
-			      EXTENT_STATUS_HOLE);
-}
-
 /*
  * ext4_ext_rm_idx:
  * removes index from the index block.
@@ -4062,6 +4038,69 @@ static int get_implied_cluster_alloc(struct super_block *sb,
 	return 0;
 }
 
+/*
+ * Determine hole length around the given logical block, first try to
+ * locate and expand the hole from the given @path, and then adjust it
+ * if it's partially or completely converted to delayed extents, insert
+ * it into the extent cache tree if it's indeed a hole, finally return
+ * the length of the determined extent.
+ */
+static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
+						  struct ext4_ext_path *path,
+						  ext4_lblk_t lblk)
+{
+	ext4_lblk_t hole_start, len;
+	struct extent_status es;
+
+	hole_start = lblk;
+	len = ext4_ext_find_hole(inode, path, &hole_start);
+again:
+	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
+				  hole_start + len - 1, &es);
+	if (!es.es_len)
+		goto insert_hole;
+
+	/*
+	 * There's a delalloc extent in the hole, handle it if the delalloc
+	 * extent is in front of, behind and straddle the queried range.
+	 */
+	if (lblk >= es.es_lblk + es.es_len) {
+		/*
+		 * The delalloc extent is in front of the queried range,
+		 * find again from the queried start block.
+		 */
+		len -= lblk - hole_start;
+		hole_start = lblk;
+		goto again;
+	} else if (in_range(lblk, es.es_lblk, es.es_len)) {
+		/*
+		 * The delalloc extent containing lblk, it must have been
+		 * added after ext4_map_blocks() checked the extent status
+		 * tree, adjust the length to the delalloc extent's after
+		 * lblk.
+		 */
+		len = es.es_lblk + es.es_len - lblk;
+		return len;
+	} else {
+		/*
+		 * The delalloc extent is partially or completely behind
+		 * the queried range, update hole length until the
+		 * beginning of the delalloc extent.
+		 */
+		len = min(es.es_lblk - hole_start, len);
+	}
+
+insert_hole:
+	/* Put just found gap into cache to speed up subsequent requests */
+	ext_debug(inode, " -> %u:%u\n", hole_start, len);
+	ext4_es_insert_extent(inode, hole_start, len, ~0, EXTENT_STATUS_HOLE);
+
+	/* Update hole_len to reflect hole size after lblk */
+	if (hole_start != lblk)
+		len -= lblk - hole_start;
+
+	return len;
+}
 
 /*
  * Block allocation/map/preallocation routine for extents based files
@@ -4179,22 +4218,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	 * we couldn't try to create block if create flag is zero
 	 */
 	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) {
-		ext4_lblk_t hole_start, hole_len;
+		ext4_lblk_t len;
 
-		hole_start = map->m_lblk;
-		hole_len = ext4_ext_determine_hole(inode, path, &hole_start);
-		/*
-		 * put just found gap into cache to speed up
-		 * subsequent requests
-		 */
-		ext4_ext_put_gap_in_cache(inode, hole_start, hole_len);
+		len = ext4_ext_determine_insert_hole(inode, path, map->m_lblk);
 
-		/* Update hole_len to reflect hole size after map->m_lblk */
-		if (hole_start != map->m_lblk)
-			hole_len -= map->m_lblk - hole_start;
 		map->m_pblk = 0;
-		map->m_len = min_t(unsigned int, map->m_len, hole_len);
-
+		map->m_len = min_t(unsigned int, map->m_len, len);
 		goto out;
 	}
 
-- 
2.39.2


