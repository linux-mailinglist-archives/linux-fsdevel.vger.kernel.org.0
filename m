Return-Path: <linux-fsdevel+bounces-24869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D67D945D89
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAE41F230D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824821E674D;
	Fri,  2 Aug 2024 11:55:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A641E2868;
	Fri,  2 Aug 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599711; cv=none; b=JBcnw3x/64+Hv2mpyov1uwfppfe95pWZ5y6kVb8HkBvT86LW2xAC9TDww535ytB/V3HcGdyVMAntwtDjbYlWiLjjz6ppGxjryqRLasr8JA8NxzVdyUp6UKTfHCVCOxopoRqzNKDOEvs6MKcq3Wivje6PHpY27vV5hHEQ/xKU+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599711; c=relaxed/simple;
	bh=0MlLklCiDAV7EnJ6NWEB/ZAvAX0U5czPqoo9FU6zsno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rW2xRLFQ7Izj8QN+XSW4LBal0BLgKGoAH68y7oXzgIpcWPmC1mDvbXeoJs4fkjHH2SbH0fOoTWPW2oPSpMgLfyUX+f0iEnPK7jy51rOO+QhlKo748Hg6EId74pC41ppsrYf28RbBXAyafoYBcwAZsRYIUgUF6cQyWYfgRYivgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wb45D3B9Jz4f3k5x;
	Fri,  2 Aug 2024 19:54:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3705D1A0359;
	Fri,  2 Aug 2024 19:55:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4UJyaxmamI8Ag--.7970S10;
	Fri, 02 Aug 2024 19:55:05 +0800 (CST)
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
Subject: [PATCH v2 06/10] ext4: update delalloc data reserve spcae in ext4_es_insert_extent()
Date: Fri,  2 Aug 2024 19:51:16 +0800
Message-Id: <20240802115120.362902-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4UJyaxmamI8Ag--.7970S10
X-Coremail-Antispam: 1UD129KBjvJXoWxtF43ZFWkGw45Jw4DAw1rXrb_yoW7ur4fpr
	ZIkr1fJw1rWw1qgrZ3Xw1Uur15WayrGr4UGrZaqry8uFW3AF1fKF1DtF1rZFWF9rW8J3Z8
	XFyUCw17uayDCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUriihUUUUU
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

Thers is one special case needs to concern is the quota claiming, when
bigalloc is enabled, if the delayed cluster allocation has been raced
by another no-delayed allocation(e.g. from fallocate) which doesn't
cover the delayed blocks:

  |<       one cluster       >|
  hhhhhhhhhhhhhhhhhhhdddddddddd
  ^            ^
  |<          >| < fallocate this range, don't claim quota again

We can't claim quota as usual because the fallocate has already claimed
it in ext4_mb_new_blocks(), we could notice this case through the
removed delalloc blocks count.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c        | 37 -------------------------------------
 fs/ext4/extents_status.c | 22 +++++++++++++++++++++-
 fs/ext4/indirect.c       |  7 -------
 3 files changed, 21 insertions(+), 45 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e067f2dd0335..a58240fdfe3f 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4356,43 +4356,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
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
index 3107e07ffe46..2daf61cfcf58 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -858,6 +858,8 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
 	int err1 = 0, err2 = 0, err3 = 0;
+	struct rsvd_info rinfo;
+	int resv_used, pending = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct extent_status *es1 = NULL;
 	struct extent_status *es2 = NULL;
@@ -896,7 +898,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
+	err1 = __es_remove_extent(inode, lblk, end, &rinfo, es1);
 	if (err1 != 0)
 		goto error;
 	/* Free preallocated extent if it didn't get used. */
@@ -926,9 +928,27 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
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


