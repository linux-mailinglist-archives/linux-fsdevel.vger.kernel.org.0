Return-Path: <linux-fsdevel+bounces-16583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 511CB89FB23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 17:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC6FB33BEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7185015FD03;
	Wed, 10 Apr 2024 14:38:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B717799A;
	Wed, 10 Apr 2024 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759918; cv=none; b=JBgtRVFitvRT3TdvkBFdgi1u6sj9GkiPKMAhCmCLXGf9zw53c21Xhjzpd7QcOmAReTdB+r/mKGYAHQrOkyT8KAglfoPrYV4jT0ucG2+mt9bM/MGbhlwhQhIUw3VFy/8tudc/+mTe5E1jGXzRyIID+K2503swU4bEGz7jzga0L5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759918; c=relaxed/simple;
	bh=AX/4mps3vXXjz0ubkiwC4YDnBnyZq5qyb5mnau521sY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DNmoaqkFiZX7sDOVZg+wk6bBoq1tJyu1/q51R3n8zC5vVaD1zWpL1MQo0G8vrKw98BM2wTpburDYBKAgN43bJnDsNdWlGT6hc0K3/dLM4pzPRUaH5aJK2Kg6xpmMINXL6zMJZtY48YFA2gMdL0bzKDOFEDGJdUWA4Rrq/WwAQ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF56S5qh1z4f3kjJ;
	Wed, 10 Apr 2024 22:38:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9D9AF1A0D3D;
	Wed, 10 Apr 2024 22:38:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S13;
	Wed, 10 Apr 2024 22:38:31 +0800 (CST)
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
	david@fromorbit.com,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [PATCH v4 09/34] ext4: make ext4_da_map_blocks() buffer_head unaware
Date: Wed, 10 Apr 2024 22:29:23 +0800
Message-Id: <20240410142948.2817554-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S13
X-Coremail-Antispam: 1UD129KBjvJXoW3WF4kCw1kAF4fJr1xJF1xuFg_yoW7Wr1Up3
	93AF1rGr13Ww18ua1ftr15ZF1fK3WUtFW7Kr93GryrA34DCrnaqF1DJF1avF98trZ7Xr1r
	XF45try8ua1IkrDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
	8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
	s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFI
	xGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWx
	Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7sRibyCP
	UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

After calling ext4_da_map_blocks(), a delalloc extent state could be
distinguished through EXT4_MAP_DELAYED flag in map. So factor out
buffer_head related handles in ext4_da_map_blocks(), make it
buffer_head unaware, make it become a common helper, it could be used
for iomap in the future.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 54 +++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 08e2692b7286..1731c1d24362 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1749,33 +1749,26 @@ static int ext4_insert_delayed_blocks(struct inode *inode, ext4_lblk_t lblk,
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
@@ -1785,10 +1778,8 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
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
 
@@ -1803,7 +1794,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 #ifdef ES_AGGRESSIVE_TEST
 		ext4_map_blocks_es_recheck(NULL, inode, map, &orig_map, 0);
 #endif
-		return retval;
+		return 0;
 	}
 
 	/*
@@ -1817,7 +1808,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 		retval = ext4_map_query_blocks(NULL, inode, map);
 	up_read(&EXT4_I(inode)->i_data_sem);
 	if (retval)
-		return retval;
+		return retval < 0 ? retval : 0;
 
 add_delayed:
 	down_write(&EXT4_I(inode)->i_data_sem);
@@ -1827,10 +1818,8 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 	 * whitout holding i_rwsem and folio lock.
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
@@ -1840,18 +1829,14 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
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
 
@@ -1871,11 +1856,15 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
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
 
@@ -1884,10 +1873,17 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
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


