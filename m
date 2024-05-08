Return-Path: <linux-fsdevel+bounces-18999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AF98BF622
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70BB5B226FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D463F8E6;
	Wed,  8 May 2024 06:22:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69F22091;
	Wed,  8 May 2024 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149367; cv=none; b=in5sozlrSJgmPg5KpjL5ktjkg3RdLs72bzJDsmzPhDCNaZL1xevUAKIaiPZQPSEy05R6Ja8FFn4B/4E3P5nfcvL1rJ6GyFC1iUrxneq+dDKHFBB2zow8jjy5LB1efQlTiw5ngfSyEpS0+qN+6bjBal/DtEbllwvYdDTwJuqkdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149367; c=relaxed/simple;
	bh=Mj6BnHzrxInqGSNem33jYFs8lPS6YifOhW/IZyrskjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsaxuegFXfcYEfK3YaSJXkZM1Rc7E1kqaZ36Juht2IdIM68MEsiVYqFys2/Wa8SUhjLq6xqsWnIUG2O1e9xPvyPBdAV9cN83/jhsUDg7r6ASkD6IzjoVEI6ti0vYec5B5dZRMgznD/0UAURDS26CJiikBE3mTEVoGVS734srVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VZ4nT2GJFz4f3kKX;
	Wed,  8 May 2024 14:22:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9A5DA1A0179;
	Wed,  8 May 2024 14:22:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6REbGjtm9_1NMA--.61952S14;
	Wed, 08 May 2024 14:22:42 +0800 (CST)
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
Subject: [PATCH v3 10/10] ext4: make ext4_da_map_blocks() buffer_head unaware
Date: Wed,  8 May 2024 14:12:20 +0800
Message-Id: <20240508061220.967970-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
References: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6REbGjtm9_1NMA--.61952S14
X-Coremail-Antispam: 1UD129KBjvJXoW3WF4kCw4rGr1fuFWxKFykXwb_yoW7Zw4Upr
	Z3AF1rGr15Ww18ua1ftr15ZF1fK3WjyFW7Kr93GryrA34DCrn3tF1UJF1avas8trZ7Wr1r
	XF4jqry8ua1IkrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

After calling the ext4_da_map_blocks(), a delalloc extent state could
be identified through the EXT4_MAP_DELAYED flag in map. So factor out
buffer_head related handles in ext4_da_map_blocks(), make this function
buffer_head unaware and becomes a common helper, and also update the
stale function commtents, preparing for the iomap da write path in the
future.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 63 ++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c56386d1b10d..1dba5337382a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1745,36 +1745,32 @@ static int ext4_insert_delayed_blocks(struct inode *inode, ext4_lblk_t lblk,
 }
 
 /*
- * This function is grabs code from the very beginning of
- * ext4_map_blocks, but assumes that the caller is from delayed write
- * time. This function looks up the requested blocks and sets the
- * buffer delay bit under the protection of i_data_sem.
+ * Looks up the requested blocks and sets the delalloc extent map.
+ * First try to look up for the extent entry that contains the requested
+ * blocks in the extent status tree without i_data_sem, then try to look
+ * up for the ondisk extent mapping with i_data_sem in read mode,
+ * finally hold i_data_sem in write mode, looks up again and add a
+ * delalloc extent entry if it still couldn't find any extent. Pass out
+ * the mapped extent through @map and return 0 on success.
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
 
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
-		retval = es.es_len - (map->m_lblk - es.es_lblk);
-		if (retval > map->m_len)
-			retval = map->m_len;
-		map->m_len = retval;
+		map->m_len = min_t(unsigned int, map->m_len,
+				   es.es_len - (map->m_lblk - es.es_lblk));
 
 		if (ext4_es_is_hole(&es))
 			goto add_delayed;
@@ -1784,10 +1780,8 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
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
 
@@ -1802,7 +1796,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 #ifdef ES_AGGRESSIVE_TEST
 		ext4_map_blocks_es_recheck(NULL, inode, map, &orig_map, 0);
 #endif
-		return retval;
+		return 0;
 	}
 
 	/*
@@ -1816,7 +1810,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 		retval = ext4_map_query_blocks(NULL, inode, map);
 	up_read(&EXT4_I(inode)->i_data_sem);
 	if (retval)
-		return retval;
+		return retval < 0 ? retval : 0;
 
 add_delayed:
 	down_write(&EXT4_I(inode)->i_data_sem);
@@ -1828,10 +1822,8 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 	 * the extent status tree.
 	 */
 	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
-		retval = es.es_len - (map->m_lblk - es.es_lblk);
-		if (retval > map->m_len)
-			retval = map->m_len;
-		map->m_len = retval;
+		map->m_len = min_t(unsigned int, map->m_len,
+				   es.es_len - (map->m_lblk - es.es_lblk));
 
 		if (!ext4_es_is_hole(&es)) {
 			up_write(&EXT4_I(inode)->i_data_sem);
@@ -1841,18 +1833,14 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 		retval = ext4_map_query_blocks(NULL, inode, map);
 		if (retval) {
 			up_write(&EXT4_I(inode)->i_data_sem);
-			return retval;
+			return retval < 0 ? retval : 0;
 		}
 	}
 
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
 
@@ -1872,11 +1860,15 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
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
 
@@ -1885,10 +1877,17 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
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


