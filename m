Return-Path: <linux-fsdevel+bounces-20686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C5D8D6DC3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 05:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9651C20BE7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 03:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B811CD18;
	Sat,  1 Jun 2024 03:42:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3256FBE;
	Sat,  1 Jun 2024 03:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717213325; cv=none; b=sCDeTQlEXQzxYEY8cTM86bv+YUOlFgbz13eKssv5y6EzyFZV+7ohKTdMH5T2TFl9IdwjXI4iCinqxJQTrlYrcmWp2AlUjnxqofrv6/mWpPj1WJoRmAWThqu7n3G/JCpCJSSHIw0F6AuP9hiGn/b2wItoY5uqTtowDngqFMLaAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717213325; c=relaxed/simple;
	bh=dV8Fhwy41UeGC4fsFppftNos9WIm0ec1BYFC7nnXHPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mXPz+ND1KUFcF4uy2msS1pqKQ97NyHDs6bOPPxoIiLqlRx3H4E5CzaGSJ4ssWpHopZt+2Sg9rdx5GFucHDRBrkQ/jLKHNq+NHSi914zJxAIu+7MIT+SPrsOdCI7lTeJI54zD85+aKNFEqxEdAh+i7edgE8Ws6r2JLsjfbCViMhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vrm4l2RGdz4f3jdP;
	Sat,  1 Jun 2024 11:41:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C47431A0189;
	Sat,  1 Jun 2024 11:41:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFumFpmHN_4OA--.4543S5;
	Sat, 01 Jun 2024 11:41:52 +0800 (CST)
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
Subject: [PATCH 01/10] ext4: factor out ext4_map_create_blocks() to allocate new blocks
Date: Sat,  1 Jun 2024 11:41:40 +0800
Message-Id: <20240601034149.2169771-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240601034149.2169771-1-yi.zhang@huaweicloud.com>
References: <20240601034149.2169771-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFumFpmHN_4OA--.4543S5
X-Coremail-Antispam: 1UD129KBjvJXoW3XF17GrWUWFy8Jw4kJryxKrg_yoW7Kr1Upr
	WfCFyrGr4UWw1jg3ySyr48XF1Yk3WYkrWUC3yfWryrZ345CrySyF15AFy3JFyDKrWxZw1Y
	qFWYy348Ca95GrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUTHqxUUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Factor out a common helper ext4_map_create_blocks() from
ext4_map_blocks() to do a real blocks allocation, no logic changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 157 +++++++++++++++++++++++++-----------------------
 1 file changed, 81 insertions(+), 76 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2afa3f83ddfb..01a30483e521 100644
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
2.31.1


