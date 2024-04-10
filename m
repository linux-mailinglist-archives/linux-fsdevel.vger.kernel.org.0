Return-Path: <linux-fsdevel+bounces-16554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB9A89F85F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2055A282DFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5CA175542;
	Wed, 10 Apr 2024 13:37:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55F916EC1D;
	Wed, 10 Apr 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756225; cv=none; b=sUIBSaSj8g7eL/H9lPciRS+UT/xgRiNCTvgbHarhN+PMFE7Nkf4fwo62irx4jz86gi+zBPh/+uzDRkiH1mnIg09t1LkJuTGzkdZvffS/WhAWESGnUH5uGBrolE8OEzCqdETZzx1x2PTtxE4m1wVzTx3FU3yqhU5TOViADDSKhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756225; c=relaxed/simple;
	bh=B8HmUiBBrmS2xnG69j0ang3+DAGeB23kQsLMIpcC7H4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFZ51DpRRQFQQqM1M+xFZbmNvyKiGvdP9W0hAVlZk5bcEanvq3wCdwfsXT5B8T0dMhBREJ7b61mGI/MmSN76LUxwialpeGY3vmBKOg0R2sTTpIL9fD/hqMnGetP9KJK4ZxvA4M194uaWnpCYCq4fXbVakDVtqiU3jnE5I0gZMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF3lM2Zb0z4f3khY;
	Wed, 10 Apr 2024 21:36:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 335F51A0572;
	Wed, 10 Apr 2024 21:36:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHolRZmeCl4Jg--.8806S14;
	Wed, 10 Apr 2024 21:36:53 +0800 (CST)
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
Subject: [RFC PATCH v4 10/34] ext4: factor out ext4_map_create_blocks() to allocate new blocks
Date: Wed, 10 Apr 2024 21:27:54 +0800
Message-Id: <20240410132818.2812377-11-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+RHolRZmeCl4Jg--.8806S14
X-Coremail-Antispam: 1UD129KBjvJXoW3XF17GrWUWFy8Jw4kJryxKrg_yoW7Kr47pr
	WfCFyrGr4jgw1qg3ySyr48XF1Yk3WFkrWUC3yfWryrZ345CrySyF15AFy3JF9rKrWxZw1Y
	qFWFy348Ca95GrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Factor out a common helper ext4_map_create_blocks() from
ext4_map_blocks(), it allocate new blocks and create a new extent, no
logic changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 157 +++++++++++++++++++++++++-----------------------
 1 file changed, 81 insertions(+), 76 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1731c1d24362..10a256cfcaa1 100644
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


