Return-Path: <linux-fsdevel+bounces-16553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A5289F85E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD60528B986
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD45174EE3;
	Wed, 10 Apr 2024 13:37:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A3816F0C8;
	Wed, 10 Apr 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756225; cv=none; b=sfZfbPk/h3DBF1dD5YPK92M1R4F3WEeVi9QUYBZ1aa4hEsUoaCDXL/dhDBAB8ue7OaQJa6Tpp0Yq4rlbco/K5JNjoxvASIZiTcwPn6lzKrdO/0F2iitrfCrUpTXDdSqseW0tw1DWnBV+FJq8YCHaAbV6BKDSX9IxsYh0D4BAJ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756225; c=relaxed/simple;
	bh=aHOAXjEHlVp/8KJOctpi+of6Qtv9ufx9i8fFt5zvFYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fBH7eigaxV+M9DdojTw2x3JrS26bMAUWTIbIia/+s9cKY2N9zOKfFQgvczLFhbM3rdGw6NPJ98BPc4tngHE09aLEImFPRW10Pa13ZQg+HEDJB6PzyUcJ/383efc9ml9QFneJSEBm/dlgR6fNHVFmwg0Teb/5pTMKXeImA+6aag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF3lQ3BMsz4f3jJ9;
	Wed, 10 Apr 2024 21:36:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 471E71A0572;
	Wed, 10 Apr 2024 21:36:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHolRZmeCl4Jg--.8806S19;
	Wed, 10 Apr 2024 21:36:57 +0800 (CST)
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
Subject: [RFC PATCH v4 15/34] ext4: update delalloc data reserve spcae in ext4_es_insert_extent()
Date: Wed, 10 Apr 2024 21:27:59 +0800
Message-Id: <20240410132818.2812377-16-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410132818.2812377-1-yi.zhang@huaweicloud.com>
References: <20240410132818.2812377-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHolRZmeCl4Jg--.8806S19
X-Coremail-Antispam: 1UD129KBjvJXoW3JryxCFy7GFy8tr1kWF13CFg_yoW7ZF47pr
	ZxCr1fJw1rXw1qgrZ3Xw1UWr15Way8Gr4UGrZaqry8uFW3AF1fKF1DtF1rZFWY9rW8WFn8
	XFyUCw17ua98Ca7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Now we update data reserved space for delalloc after allocating new
blocks in ext4_{ind|ext}_map_blocks(). If bigalloc feature is enabled,
we also need to query the extents_status tree and calculate the exact
reserved clusters. This is complicated and it appears
ext4_es_insert_extent() is a better place to do this job, it could make
things simple because __es_remove_extent() could count delalloc blocks
and __revise_pending() and return newly added pending count.

One special case needs to concern is the quota claiming, when bigalloc
is enabled, if the delayed cluster allocation has been raced by another
no-delayed allocation which doesn't overlap the delayed blocks (from
fallocate, filemap, DIO...) , we cannot claim quota as usual because the
racer have already done it, so we also need to check the counted
reserved blocks.

  |               one cluster               |
  -------------------------------------------
  |                            | delayed es |
  -------------------------------------------
  ^           ^
  | fallocate | <- don't claim quota

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c        | 37 -------------------------------------
 fs/ext4/extents_status.c | 22 +++++++++++++++++++++-
 fs/ext4/indirect.c       |  7 -------
 3 files changed, 21 insertions(+), 45 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e57054bdc5fd..8bc8a519f745 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4355,43 +4355,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		goto out;
 	}
 
-	/*
-	 * Reduce the reserved cluster count to reflect successful deferred
-	 * allocation of delayed allocated clusters or direct allocation of
-	 * clusters discovered to be delayed allocated.  Once allocated, a
-	 * cluster is not included in the reserved count.
-	 */
-	if (test_opt(inode->i_sb, DELALLOC) && allocated_clusters) {
-		if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) {
-			/*
-			 * When allocating delayed allocated clusters, simply
-			 * reduce the reserved cluster count and claim quota
-			 */
-			ext4_da_update_reserve_space(inode, allocated_clusters,
-							1);
-		} else {
-			ext4_lblk_t lblk, len;
-			unsigned int n;
-
-			/*
-			 * When allocating non-delayed allocated clusters
-			 * (from fallocate, filemap, DIO, or clusters
-			 * allocated when delalloc has been disabled by
-			 * ext4_nonda_switch), reduce the reserved cluster
-			 * count by the number of allocated clusters that
-			 * have previously been delayed allocated.  Quota
-			 * has been claimed by ext4_mb_new_blocks() above,
-			 * so release the quota reservations made for any
-			 * previously delayed allocated clusters.
-			 */
-			lblk = EXT4_LBLK_CMASK(sbi, map->m_lblk);
-			len = allocated_clusters << sbi->s_cluster_bits;
-			n = ext4_es_delayed_clu(inode, lblk, len);
-			if (n > 0)
-				ext4_da_update_reserve_space(inode, (int) n, 0);
-		}
-	}
-
 	/*
 	 * Cache the extent and update transaction to commit on fdatasync only
 	 * when it is _not_ an unwritten extent.
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 38ec2cc5ae3b..75227f151b8f 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -856,6 +856,8 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
 	int err1 = 0, err2 = 0, err3 = 0;
+	struct rsvd_info rinfo;
+	int resv_used, pending = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct extent_status *es1 = NULL;
 	struct extent_status *es2 = NULL;
@@ -894,7 +896,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
+	err1 = __es_remove_extent(inode, lblk, end, &rinfo, es1);
 	if (err1 != 0)
 		goto error;
 	/* Free preallocated extent if it didn't get used. */
@@ -924,9 +926,27 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 			__free_pending(pr);
 			pr = NULL;
 		}
+		pending = err3;
 	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
+	/*
+	 * Reduce the reserved cluster count to reflect successful deferred
+	 * allocation of delayed allocated clusters or direct allocation of
+	 * clusters discovered to be delayed allocated.  Once allocated, a
+	 * cluster is not included in the reserved count.
+	 *
+	 * When bigalloc is enabled, allocating non-delayed allocated blocks
+	 * which belong to delayed allocated clusters (from fallocate, filemap,
+	 * DIO, or clusters allocated when delalloc has been disabled by
+	 * ext4_nonda_switch()). Quota has been claimed by ext4_mb_new_blocks(),
+	 * so release the quota reservations made for any previously delayed
+	 * allocated clusters.
+	 */
+	resv_used = rinfo.delonly_cluster + pending;
+	if (resv_used)
+		ext4_da_update_reserve_space(inode, resv_used,
+					     rinfo.delonly_block);
 	if (err1 || err2 || err3 < 0)
 		goto retry;
 
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index d8ca7f64f952..7404f0935c90 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -652,13 +652,6 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 	count = ar.len;
 
-	/*
-	 * Update reserved blocks/metadata blocks after successful block
-	 * allocation which had been deferred till now.
-	 */
-	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
-		ext4_da_update_reserve_space(inode, count, 1);
-
 got_it:
 	map->m_flags |= EXT4_MAP_MAPPED;
 	map->m_pblk = le32_to_cpu(chain[depth-1].key);
-- 
2.39.2


