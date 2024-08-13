Return-Path: <linux-fsdevel+bounces-25773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A70950537
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76189B22F2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E3519CCF0;
	Tue, 13 Aug 2024 12:39:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE4199E81;
	Tue, 13 Aug 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552765; cv=none; b=HzYZo7abt/7gNDiRiCAV3dK6fXP47D0QXnI7ikD4lLts2sk0rzkMXld+boyAckZxBW60FqUaVu3bu6cMiGiHa7VmE8BTEwcewRZsFc2lNikqb3XwxViE/QovRARu5ECHOsQl/5zZlUVDcpUmWCkYf54KCFtlr6y69bLst3XCi78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552765; c=relaxed/simple;
	bh=xQzrcK+qiJEQQKGTJKElJXRSm117PNToSqPCee3UAgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HmQQvPcLLFPcbzsa6WJaKF9n2IQY5VVr2ng12UU+L8IaqOIqb2zuGbn03/qgNGUK6ssuurB7cGytnxW3nxQRPWK9UICsLa9igyDnnUJcuRc7Ha1/a0o/7jK9Mgpdb1V/p3wL5uoptv8oOgEH+fOJyYOXzfALId7upz5KEhBbBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WjrY55Vv3z4f3jdM;
	Tue, 13 Aug 2024 20:39:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 759BD1A07B6;
	Tue, 13 Aug 2024 20:39:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4XkU7tmejNSBg--.17625S10;
	Tue, 13 Aug 2024 20:39:19 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 06/12] ext4: update delalloc data reserve spcae in ext4_es_insert_extent()
Date: Tue, 13 Aug 2024 20:34:46 +0800
Message-Id: <20240813123452.2824659-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4XkU7tmejNSBg--.17625S10
X-Coremail-Antispam: 1UD129KBjvJXoWxtF47Kr4UCFyfCr4xZFyrWFg_yoWxAFykpr
	ZIkr1fJw1rWw1q9rZ3Xw4UWr15WayrKw4UGrZ3tryxuFW3Ar1fKF1DtF1rZFWI9rWkJ3Z8
	XFyUCw17uayDCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Now that we update data reserved space for delalloc after allocating
new blocks in ext4_{ind|ext}_map_blocks(), and if bigalloc feature is
enabled, we also need to query the extents_status tree to calculate the
exact reserved clusters. This is complicated now and it appears that
it's better to do this job in ext4_es_insert_extent(), because
__es_remove_extent() have already count delalloc blocks when removing
delalloc extents and __revise_pending() return new adding pending count,
we could update the reserved blocks easily in ext4_es_insert_extent().

We direct reduce the reserved cluster count when replacing a delalloc
extent. However, thers are two special cases need to concern about the
quota claiming when doing direct block allocation (e.g. from fallocate).

A),
fallocate a range that covers a delalloc extent but start with
non-delayed allocated blocks, e.g. a hole.

  hhhhhhh+ddddddd+ddddddd
  ^^^^^^^^^^^^^^^^^^^^^^^  fallocate this range

Current ext4_map_blocks() can't always trim the extent since it may
release i_data_sem before calling ext4_map_create_blocks() and raced by
another delayed allocation. Hence the EXT4_GET_BLOCKS_DELALLOC_RESERVE
may not set even when we are replacing a delalloc extent, without this
flag set, the quota has already been claimed by ext4_mb_new_blocks(), so
we should release the quota reservations instead of claim them again.

B),
bigalloc feature is enabled, fallocate a range that contains non-delayed
allocated blocks.

  |<         one cluster       >|
  hhhhhhh+hhhhhhh+hhhhhhh+ddddddd
  ^^^^^^^  fallocate this range

This case is similar to above case, the EXT4_GET_BLOCKS_DELALLOC_RESERVE
flag is also not set.

Hence we should release the quota reservations if we replace a delalloc
extent but without EXT4_GET_BLOCKS_DELALLOC_RESERVE set.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c        | 37 -------------------------------------
 fs/ext4/extents_status.c | 25 ++++++++++++++++++++++++-
 fs/ext4/indirect.c       |  7 -------
 3 files changed, 24 insertions(+), 45 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 671dacd7c873..db8f9d79477c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4357,43 +4357,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
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
index 0580bc4bc762..41adf0d69959 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -853,6 +853,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
 	int err1 = 0, err2 = 0, err3 = 0;
+	int resv_used = 0, pending = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct extent_status *es1 = NULL;
 	struct extent_status *es2 = NULL;
@@ -891,7 +892,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
+	err1 = __es_remove_extent(inode, lblk, end, &resv_used, es1);
 	if (err1 != 0)
 		goto error;
 	/* Free preallocated extent if it didn't get used. */
@@ -921,9 +922,31 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
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
+	 * When direct allocating (from fallocate, filemap, DIO, or clusters
+	 * allocated when delalloc has been disabled by ext4_nonda_switch())
+	 * an extent either 1) contains delayed blocks but start with
+	 * non-delayed allocated blocks (e.g. hole) or 2) contains non-delayed
+	 * allocated blocks which belong to delayed allocated clusters when
+	 * bigalloc feature is enabled, quota has already been claimed by
+	 * ext4_mb_new_blocks(), so release the quota reservations made for
+	 * any previously delayed allocated clusters instead of claim them
+	 * again.
+	 */
+	resv_used += pending;
+	if (resv_used)
+		ext4_da_update_reserve_space(inode, resv_used,
+				flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE);
+
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


