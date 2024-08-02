Return-Path: <linux-fsdevel+bounces-24863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E91945D78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71851F22AB2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F31E3CC1;
	Fri,  2 Aug 2024 11:55:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A51DF66A;
	Fri,  2 Aug 2024 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599708; cv=none; b=MtsSBvJMNpgvU1lvkjzd8onShuvxYX01a3QuC5gyVC9/woTra/6BXgaPRIpHDfMh0Z5zW3jz9PCj/+q4H88oOd9rNQujxCev/820QNvkyFiCAFZ5oXEq5RU0eICWDsRKuk+mrWs3xSHVbsBD3Jk5pYfZNZ/g2Vp4q7gCpS80HiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599708; c=relaxed/simple;
	bh=vHzNV3fNY/dKkiuhkHaYieH/NaucUrdpkBJbdd6hCvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WrJviyipUSiUfPN1XGnouXcOwgNeKWxEYrRTRS4cOXO3VnxJHgzqQQn4MCh1TnXla4bqTZhnRZxC63ImOueSMSicPdf8F3xH262dJqphqZQLSaMKSOrtcb1mTTJdPI0GfkDZyt+al8P7jq9FyXXsvHnYwfIeNVN3WYWRuVwVeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wb45B1n1Dz4f3k6B;
	Fri,  2 Aug 2024 19:54:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 06D571A084A;
	Fri,  2 Aug 2024 19:55:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4UJyaxmamI8Ag--.7970S5;
	Fri, 02 Aug 2024 19:55:02 +0800 (CST)
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
Subject: [PATCH v2 01/10] ext4: factor out ext4_map_create_blocks() to allocate new blocks
Date: Fri,  2 Aug 2024 19:51:11 +0800
Message-Id: <20240802115120.362902-2-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgB3n4UJyaxmamI8Ag--.7970S5
X-Coremail-Antispam: 1UD129KBjvJXoW3XF17GrWxKFy7ArW3KF4rZrb_yoW7Kr1Upr
	WfCFyrGr4UWw1qg3ySyr48XF1Yk3WYkrWUC3yfWryrZ345CrySyF15AFy3JF9rKrWxZw1Y
	qFWFy348Ca95GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUjldyUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Factor out a common helper ext4_map_create_blocks() from
ext4_map_blocks() to do a real blocks allocation, no logic changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 157 +++++++++++++++++++++++++-----------------------
 1 file changed, 81 insertions(+), 76 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0d5c6e..112aec171ee9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -482,6 +482,86 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 	return retval;
 }
 
+static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
+				  struct ext4_map_blocks *map, int flags)
+{
+	struct extent_status es;
+	unsigned int status;
+	int err, retval = 0;
+
+	/*
+	 * Here we clear m_flags because after allocating an new extent,
+	 * it will be set again.
+	 */
+	map->m_flags &= ~EXT4_MAP_FLAGS;
+
+	/*
+	 * We need to check for EXT4 here because migrate could have
+	 * changed the inode type in between.
+	 */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		retval = ext4_ext_map_blocks(handle, inode, map, flags);
+	} else {
+		retval = ext4_ind_map_blocks(handle, inode, map, flags);
+
+		/*
+		 * We allocated new blocks which will result in i_data's
+		 * format changing. Force the migrate to fail by clearing
+		 * migrate flags.
+		 */
+		if (retval > 0 && map->m_flags & EXT4_MAP_NEW)
+			ext4_clear_inode_state(inode, EXT4_STATE_EXT_MIGRATE);
+	}
+	if (retval <= 0)
+		return retval;
+
+	if (unlikely(retval != map->m_len)) {
+		ext4_warning(inode->i_sb,
+			     "ES len assertion failed for inode %lu: "
+			     "retval %d != map->m_len %d",
+			     inode->i_ino, retval, map->m_len);
+		WARN_ON(1);
+	}
+
+	/*
+	 * We have to zeroout blocks before inserting them into extent
+	 * status tree. Otherwise someone could look them up there and
+	 * use them before they are really zeroed. We also have to
+	 * unmap metadata before zeroing as otherwise writeback can
+	 * overwrite zeros with stale data from block device.
+	 */
+	if (flags & EXT4_GET_BLOCKS_ZERO &&
+	    map->m_flags & EXT4_MAP_MAPPED && map->m_flags & EXT4_MAP_NEW) {
+		err = ext4_issue_zeroout(inode, map->m_lblk, map->m_pblk,
+					 map->m_len);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * If the extent has been zeroed out, we don't need to update
+	 * extent status tree.
+	 */
+	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
+	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+		if (ext4_es_is_written(&es))
+			return retval;
+	}
+
+	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
+			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
+	if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
+	    !(status & EXTENT_STATUS_WRITTEN) &&
+	    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
+			       map->m_lblk + map->m_len - 1))
+		status |= EXTENT_STATUS_DELAYED;
+
+	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+			      map->m_pblk, status);
+
+	return retval;
+}
+
 /*
  * The ext4_map_blocks() function tries to look up the requested blocks,
  * and returns if the blocks are already mapped.
@@ -630,12 +710,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
 			return retval;
 
-	/*
-	 * Here we clear m_flags because after allocating an new extent,
-	 * it will be set again.
-	 */
-	map->m_flags &= ~EXT4_MAP_FLAGS;
-
 	/*
 	 * New blocks allocate and/or writing to unwritten extent
 	 * will possibly result in updating i_data, so we take
@@ -643,76 +717,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * with create == 1 flag.
 	 */
 	down_write(&EXT4_I(inode)->i_data_sem);
-
-	/*
-	 * We need to check for EXT4 here because migrate
-	 * could have changed the inode type in between
-	 */
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		retval = ext4_ext_map_blocks(handle, inode, map, flags);
-	} else {
-		retval = ext4_ind_map_blocks(handle, inode, map, flags);
-
-		if (retval > 0 && map->m_flags & EXT4_MAP_NEW) {
-			/*
-			 * We allocated new blocks which will result in
-			 * i_data's format changing.  Force the migrate
-			 * to fail by clearing migrate flags
-			 */
-			ext4_clear_inode_state(inode, EXT4_STATE_EXT_MIGRATE);
-		}
-	}
-
-	if (retval > 0) {
-		unsigned int status;
-
-		if (unlikely(retval != map->m_len)) {
-			ext4_warning(inode->i_sb,
-				     "ES len assertion failed for inode "
-				     "%lu: retval %d != map->m_len %d",
-				     inode->i_ino, retval, map->m_len);
-			WARN_ON(1);
-		}
-
-		/*
-		 * We have to zeroout blocks before inserting them into extent
-		 * status tree. Otherwise someone could look them up there and
-		 * use them before they are really zeroed. We also have to
-		 * unmap metadata before zeroing as otherwise writeback can
-		 * overwrite zeros with stale data from block device.
-		 */
-		if (flags & EXT4_GET_BLOCKS_ZERO &&
-		    map->m_flags & EXT4_MAP_MAPPED &&
-		    map->m_flags & EXT4_MAP_NEW) {
-			ret = ext4_issue_zeroout(inode, map->m_lblk,
-						 map->m_pblk, map->m_len);
-			if (ret) {
-				retval = ret;
-				goto out_sem;
-			}
-		}
-
-		/*
-		 * If the extent has been zeroed out, we don't need to update
-		 * extent status tree.
-		 */
-		if ((flags & EXT4_GET_BLOCKS_PRE_IO) &&
-		    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
-			if (ext4_es_is_written(&es))
-				goto out_sem;
-		}
-		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
-				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-		if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
-		    !(status & EXTENT_STATUS_WRITTEN) &&
-		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
-				       map->m_lblk + map->m_len - 1))
-			status |= EXTENT_STATUS_DELAYED;
-		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-				      map->m_pblk, status);
-	}
-
-out_sem:
+	retval = ext4_map_create_blocks(handle, inode, map, flags);
 	up_write((&EXT4_I(inode)->i_data_sem));
 	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
 		ret = check_block_validity(inode, map);
-- 
2.39.2


