Return-Path: <linux-fsdevel+bounces-25772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21941950532
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982901F238AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA1719B3CE;
	Tue, 13 Aug 2024 12:39:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18819923A;
	Tue, 13 Aug 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552764; cv=none; b=Hd4BD3zbGNqgDbQX5P3h33XVN635gLJVx1QaNiJde5VLh+TgQSCADcRACwTbMqo9qzauj03fSiPibM/kfhcic1iBJpnVCTUFIiEyHLEMNJ0QvIK1EbzZcEYs+j0+F+k5CTBPuZiPdCWvyM2qrfhH6UpnLXxwTWXFuf+65XvWBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552764; c=relaxed/simple;
	bh=/UmpYTFHyISx7pjirU+0+lt3UV8KbEDniK+78/jkCME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ei4J9NOskMaefa6+xrufqnENyLNPqUkLoOgbaZ7CUODMGXuZFeIWoG8Wvp5FAWlJaqQlnfDLh1OJ8X6OR+aYqNuSQyIZKJFUYEsCnFQB0FQPyrfla1nVWshky38bZ25Cr5vWQ0j+ER8v5l8Dun5W+yA91gszpsu4XmlROS11DfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WjrY52MYSz4f3jHT;
	Tue, 13 Aug 2024 20:39:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0975F1A018D;
	Tue, 13 Aug 2024 20:39:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4XkU7tmejNSBg--.17625S9;
	Tue, 13 Aug 2024 20:39:18 +0800 (CST)
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
Subject: [PATCH v3 05/12] ext4: passing block allocation information to ext4_es_insert_extent()
Date: Tue, 13 Aug 2024 20:34:45 +0800
Message-Id: <20240813123452.2824659-6-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBnj4XkU7tmejNSBg--.17625S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGw13ZF45WFWruF15ZrWDJwb_yoWrurWkp3
	98Ary8Gr45Ww409ayIkr4UZr13Ga42krW7CrZayw1fKay3JrySyF1UtFyavF1FqrW8Xr1Y
	vFW0k34UCa13Ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Just pass the block allocation flag to ext4_es_insert_extent() when we
replacing a current extent after an actually block allocation or extent
status conversion, this flag will be used by later changes.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c        | 5 +++--
 fs/ext4/extents_status.c | 6 +++---
 fs/ext4/extents_status.h | 2 +-
 fs/ext4/inode.c          | 8 ++++----
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e067f2dd0335..671dacd7c873 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3113,7 +3113,7 @@ static void ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
 		return;
 
 	ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
-			      EXTENT_STATUS_WRITTEN);
+			      EXTENT_STATUS_WRITTEN, 0);
 }
 
 /* FIXME!! we need to try to merge to left or right after zero-out  */
@@ -4097,7 +4097,8 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
 insert_hole:
 	/* Put just found gap into cache to speed up subsequent requests */
 	ext_debug(inode, " -> %u:%u\n", hole_start, len);
-	ext4_es_insert_extent(inode, hole_start, len, ~0, EXTENT_STATUS_HOLE);
+	ext4_es_insert_extent(inode, hole_start, len, ~0,
+			      EXTENT_STATUS_HOLE, 0);
 
 	/* Update hole_len to reflect hole size after lblk */
 	if (hole_start != lblk)
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 4d24b56cfaf0..0580bc4bc762 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -848,7 +848,7 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
  */
 void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 			   ext4_lblk_t len, ext4_fsblk_t pblk,
-			   unsigned int status)
+			   unsigned int status, int flags)
 {
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
@@ -862,8 +862,8 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
-	es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
-		 lblk, len, pblk, status, inode->i_ino);
+	es_debug("add [%u/%u) %llu %x %x to extent status tree of inode %lu\n",
+		 lblk, len, pblk, status, flags, inode->i_ino);
 
 	if (!len)
 		return;
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 3c8e2edee5d5..b74d693c1adb 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -129,7 +129,7 @@ extern void ext4_es_init_tree(struct ext4_es_tree *tree);
 
 extern void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 				  ext4_lblk_t len, ext4_fsblk_t pblk,
-				  unsigned int status);
+				  unsigned int status, int flags);
 extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t len, ext4_fsblk_t pblk,
 				 unsigned int status);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e9ce1e4e6acb..260a38453604 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -478,7 +478,7 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-			      map->m_pblk, status);
+			      map->m_pblk, status, 0);
 	return retval;
 }
 
@@ -559,7 +559,7 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-			      map->m_pblk, status);
+			      map->m_pblk, status, flags);
 
 	return retval;
 }
@@ -677,7 +677,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-				      map->m_pblk, status);
+				      map->m_pblk, status, 0);
 	}
 	up_read((&EXT4_I(inode)->i_data_sem));
 
@@ -4065,7 +4065,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 						    stop_block);
 
 		ext4_es_insert_extent(inode, first_block, hole_len, ~0,
-				      EXTENT_STATUS_HOLE);
+				      EXTENT_STATUS_HOLE, 0);
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
 	ext4_fc_track_range(handle, inode, first_block, stop_block);
-- 
2.39.2


