Return-Path: <linux-fsdevel+bounces-15769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609C892B1B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 13:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FD51F230E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B35E374D9;
	Sat, 30 Mar 2024 12:10:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81042D057;
	Sat, 30 Mar 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711800641; cv=none; b=qA2AUCXuNIeaFf0E9TFCdTFuTjPdLdVhU4N1IEMSBsVbCSD1pxaim8h7SUqzledb21KOCKmRRUNmvM4AViGyxWYEyWMNI60+N+i0OjDfA2yOUIijglp87K840UrTLCmmvT4R4mCWwotEK66lYeI1V+tqk74e2O4lHQ1uO2jqUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711800641; c=relaxed/simple;
	bh=+ixc1uNvIKaGevL37bDckvnrFxYiL2IIzR2flXamFVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dD2e2fOxlNkoWqKtK8exd72J2nlWOsQXouRPO3B/hqbQKg/jyypnj4XEI8KOHJX5nAdbR/RxIDNYl8e32pW5sj16FjUWnROv3NSsJSVlQ8OJJiLL7gE8aQUoQgexDP1dcDMMpUNIOGWFWnde8g1FFq2EvjHUrJvWCu0ZAx9n2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V6GLq72lHz4f3kG5;
	Sat, 30 Mar 2024 20:10:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 55DA91A016E;
	Sat, 30 Mar 2024 20:10:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REsAQhmkPEjIg--.10652S11;
	Sat, 30 Mar 2024 20:10:34 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH 7/7] ext4: make ext4_da_map_blocks() buffer_head unaware
Date: Sat, 30 Mar 2024 20:02:36 +0800
Message-Id: <20240330120236.3789589-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240330120236.3789589-1-yi.zhang@huaweicloud.com>
References: <20240330120236.3789589-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REsAQhmkPEjIg--.10652S11
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4rGw4UCF43Gw4DJFy5Jwb_yoWrWFWUpr
	ZxAF1rGr17WF1xua1ftw1UXF1fK3WjyFWUKr93GryrAryDArn2qF1UJFyava98trZ3WFn5
	XF45Kry8uF48C37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

After calling ext4_da_map_blocks(), a delalloc extent state could be
distinguished through EXT4_MAP_DELAYED flag in map. So factor out
buffer_head related handles in ext4_da_map_blocks(), make it
buffer_head unaware, make it become a common helper, it could be used
for iomap in the future.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6983ced32dce..8f026d8c27db 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1720,23 +1720,18 @@ static int ext4_insert_delayed_blocks(struct inode *inode, ext4_lblk_t lblk,
  * This function is grabs code from the very beginning of
  * ext4_map_blocks, but assumes that the caller is from delayed write
  * time. This function looks up the requested blocks and sets the
- * buffer delay bit under the protection of i_data_sem.
+ * delalloc extent map under the protection of i_data_sem.
  */
-static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
-			      struct buffer_head *bh)
+static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 {
 	struct extent_status es;
 	int retval;
-	sector_t invalid_block = ~((sector_t) 0xffff);
 #ifdef ES_AGGRESSIVE_TEST
 	struct ext4_map_blocks orig_map;
 
 	memcpy(&orig_map, map, sizeof(*map));
 #endif
 
-	if (invalid_block < ext4_blocks_count(EXT4_SB(inode->i_sb)->s_es))
-		invalid_block = ~0;
-
 	map->m_flags = 0;
 	ext_debug(inode, "max_blocks %u, logical block %lu\n", map->m_len,
 		  (unsigned long) map->m_lblk);
@@ -1755,10 +1750,8 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 		 * Delayed extent could be allocated by fallocate.
 		 * So we need to check it.
 		 */
-		if (ext4_es_is_delayed(&es) && !ext4_es_is_unwritten(&es)) {
-			map_bh(bh, inode->i_sb, invalid_block);
-			set_buffer_new(bh);
-			set_buffer_delay(bh);
+		if (ext4_es_is_delonly(&es)) {
+			map->m_flags |= EXT4_MAP_DELAYED;
 			return 0;
 		}
 
@@ -1773,7 +1766,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 #ifdef ES_AGGRESSIVE_TEST
 		ext4_map_blocks_es_recheck(NULL, inode, map, &orig_map, 0);
 #endif
-		return retval;
+		return 0;
 	}
 
 	/*
@@ -1807,20 +1800,16 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 				      map->m_pblk, status);
 		up_read(&EXT4_I(inode)->i_data_sem);
-		return retval;
+		return 0;
 	}
 	up_read(&EXT4_I(inode)->i_data_sem);
 
 add_delayed:
 	down_write(&EXT4_I(inode)->i_data_sem);
+	map->m_flags |= EXT4_MAP_DELAYED;
 	retval = ext4_insert_delayed_blocks(inode, map->m_lblk, map->m_len);
 	up_write(&EXT4_I(inode)->i_data_sem);
-	if (retval)
-		return retval;
 
-	map_bh(bh, inode->i_sb, invalid_block);
-	set_buffer_new(bh);
-	set_buffer_delay(bh);
 	return retval;
 }
 
@@ -1840,11 +1829,15 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 			   struct buffer_head *bh, int create)
 {
 	struct ext4_map_blocks map;
+	sector_t invalid_block = ~((sector_t) 0xffff);
 	int ret = 0;
 
 	BUG_ON(create == 0);
 	BUG_ON(bh->b_size != inode->i_sb->s_blocksize);
 
+	if (invalid_block < ext4_blocks_count(EXT4_SB(inode->i_sb)->s_es))
+		invalid_block = ~0;
+
 	map.m_lblk = iblock;
 	map.m_len = 1;
 
@@ -1853,10 +1846,17 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	 * preallocated blocks are unmapped but should treated
 	 * the same as allocated blocks.
 	 */
-	ret = ext4_da_map_blocks(inode, &map, bh);
-	if (ret <= 0)
+	ret = ext4_da_map_blocks(inode, &map);
+	if (ret < 0)
 		return ret;
 
+	if (map.m_flags & EXT4_MAP_DELAYED) {
+		map_bh(bh, inode->i_sb, invalid_block);
+		set_buffer_new(bh);
+		set_buffer_delay(bh);
+		return 0;
+	}
+
 	map_bh(bh, inode->i_sb, map.m_pblk);
 	ext4_update_bh_state(bh, map.m_flags);
 
-- 
2.39.2


