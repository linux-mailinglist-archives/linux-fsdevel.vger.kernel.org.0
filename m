Return-Path: <linux-fsdevel+bounces-72378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FC2CF1967
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 02:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FAB93043901
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 01:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EFB2EA731;
	Mon,  5 Jan 2026 01:48:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E51E515;
	Mon,  5 Jan 2026 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767577728; cv=none; b=AIfVLtmAmw0XkUECG8kDjThz8ihPSLHfbwFsnlElq8+nuZgGax0rZek2zFrze3qVgZk1M2hi77DCLk4Mi1yUazT8CEQI2yy5rotfE69xwuU7KQ8ReL/kCaJVNDvynnPkNhS4RKG6bjOuwbdB6jNeGUj2YQ2GfRB2QN/NV5QHRew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767577728; c=relaxed/simple;
	bh=i69k8c4PggZS90Tte9HwDeYJNoDwstKKc44HyJVvV0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpGxracDierepok8lII0TBEvMOMpCWxYoUYiyVIcd8BuJdwLmAvCK1Y/y9wAmSh3am5PLmKWixzjkp5l8IK3OCtpFubWX0ppxl0SXYg6oG5OBetdr4Es//hYWrleWRbsZLc9bVvDm1ybiBJ8yVQsjrKdfayy8vQLvfko+vQnRy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dkxyY0y9BzKHMZS;
	Mon,  5 Jan 2026 09:48:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A2E0240539;
	Mon,  5 Jan 2026 09:48:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgBHp_dpGFtppFisCg--.42376S6;
	Mon, 05 Jan 2026 09:48:42 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yukuai@fnnas.com
Subject: [PATCH -next v3 2/7] ext4: don't split extent before submitting I/O
Date: Mon,  5 Jan 2026 09:45:17 +0800
Message-ID: <20260105014522.1937690-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105014522.1937690-1-yi.zhang@huaweicloud.com>
References: <20260105014522.1937690-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHp_dpGFtppFisCg--.42376S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWUuw1fXF1rCFWkJF43ZFb_yoWruF13pF
	43Cw18GF4vgayY9392qF1Uur1Ig3W7Gr4UZryYg3yUWFZ8GryFqF4fKayFva4rtrWkXayY
	vF4Y934Uu3W5CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Currently, when writing back dirty pages to the filesystem with the
dioread_nolock feature enabled and when doing DIO, if the area to be
written back is part of an unwritten extent, the
EXT4_GET_BLOCKS_IO_CREATE_EXT flag is set during block allocation before
submitting I/O. The function ext4_split_convert_extents() then attempts
to split this extent in advance. This approach is designed to prevents
extent splitting and conversion to the written type from failing due to
insufficient disk space at the time of I/O completion, which could
otherwise result in data loss.

However, we already have two mechanisms to ensure successful extent
conversion. The first is the EXT4_GET_BLOCKS_METADATA_NOFAIL flag, which
is a best effort, it permits the use of 2% of the reserved space or
4,096 blocks in the file system when splitting extents. This flag covers
most scenarios where extent splitting might fail. The second is the
EXT4_EXT_MAY_ZEROOUT flag, which is also set during extent splitting. If
the reserved space is insufficient and splitting fails, it does not
retry the allocation. Instead, it directly zeros out the extra part of
the extent, thereby avoiding splitting and directly converting the
entire extent to the written type.

These two mechanisms also exist when I/Os are completed because there is
a concurrency window between write-back and fallocate, which may still
require us to split extents upon I/O completion. There is no much
difference between splitting extents before submitting I/O. Therefore,
It seems possible to defer the splitting until I/O completion, it won't
increase the risk of I/O failure and data loss. On the contrary, if some
I/Os can be merged when I/O completion, it can also reduce unnecessary
splitting operations, thereby alleviating the pressure on reserved
space.

In addition, deferring extent splitting until I/O completion can
also simplify the IO submission process and avoid initiating unnecessary
journal handles when writing unwritten extents.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 13 +------------
 fs/ext4/inode.c   |  4 ++--
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e53959120b04..c98f7c5482b4 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3787,21 +3787,10 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)ee_block, ee_len);
 
-	/* If extent is larger than requested it is a clear sign that we still
-	 * have some extent state machine issues left. So extent_split is still
-	 * required.
-	 * TODO: Once all related issues will be fixed this situation should be
-	 * illegal.
-	 */
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
 		int flags = EXT4_GET_BLOCKS_CONVERT |
 			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
-#ifdef CONFIG_EXT4_DEBUG
-		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
-			     " len %u; IO logical block %llu, len %u",
-			     inode->i_ino, (unsigned long long)ee_block, ee_len,
-			     (unsigned long long)map->m_lblk, map->m_len);
-#endif
+
 		path = ext4_split_convert_extents(handle, inode, map, path,
 						  flags, NULL);
 		if (IS_ERR(path))
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bb8165582840..ffde24ff7347 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2376,7 +2376,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 
 	dioread_nolock = ext4_should_dioread_nolock(inode);
 	if (dioread_nolock)
-		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
+		get_blocks_flags |= EXT4_GET_BLOCKS_UNWRIT_EXT;
 
 	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
 	if (err < 0)
@@ -3744,7 +3744,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	else if (EXT4_LBLK_TO_B(inode, map->m_lblk) >= i_size_read(inode))
 		m_flags = EXT4_GET_BLOCKS_CREATE;
 	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
+		m_flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
 
 	if (flags & IOMAP_ATOMIC)
 		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
-- 
2.52.0


