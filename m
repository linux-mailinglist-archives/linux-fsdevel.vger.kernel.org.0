Return-Path: <linux-fsdevel+bounces-9166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7EC83E960
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106062867EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DAD24209;
	Sat, 27 Jan 2024 02:02:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECED20B0D;
	Sat, 27 Jan 2024 02:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320973; cv=none; b=ocaaJZwWvamcMaM5+E/u4oxooXZ0cnHKFKKivkP+4/DSMA5UK9u2L+Q9jJNP9Lqwe4lrlbg6GIbaoQc4aQt4S/1YdBCcY4ryLsMtve3RU0pv5g0TJIy2sHV1+1Lc1QsTo7MVhC9baGkJH5C+xOB9Dq1lBfjwzExLrPXmkgvPs/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320973; c=relaxed/simple;
	bh=ksLkZb0NfMQKKBicfDO5MfvA6nNiHTpqrbrQArp5piU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dvDomTE+ntN/u1i9smhcd8msAagIUhMf2KMUGtVNvK0Li5WGPNJVgzCVWQJwQmO+B9ygM/EJctpVxfE1k1ucKbc0xwddPmvN1bGsDrNSFakZ+j1q3NfbSYLBmVeuXOxGolH/0Uqa9xxQrx0sL6CqZvttnmNzbdM9Z9hoFHMtEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TMHrg2YPkz4f3lwt;
	Sat, 27 Jan 2024 10:02:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 598541A01E9;
	Sat, 27 Jan 2024 10:02:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g40ZLRlGJtmCA--.7377S16;
	Sat, 27 Jan 2024 10:02:47 +0800 (CST)
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
Subject: [RFC PATCH v3 12/26] ext4: factor out bh handles to ext4_da_get_block_prep()
Date: Sat, 27 Jan 2024 09:58:11 +0800
Message-Id: <20240127015825.1608160-13-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g40ZLRlGJtmCA--.7377S16
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1rWr48Zw4ruF47JF1DJrb_yoW7Ary8p3
	9xAF1rGr13Ww109a1ftr1UXF1fK3WqyrW7Cr93GryFy3s5JrnaqF1UAFySqF98trZ3Zrs8
	WF45Kry8uF18GrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Factor buffer_head related handles out from ext4_da_map_blocks() to
ext4_da_get_block_prep(), and make ext4_da_map_blocks() always return 0
if success, we can distinguish delalloc map through EXT4_MAP_DELAYED
flag.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 75 ++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9ac9bb548a4c..9f9b1fce8da8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1690,48 +1690,37 @@ static int ext4_insert_delayed_blocks(struct inode *inode, ext4_lblk_t lblk,
  * time. This function looks up the requested blocks and sets the
  * buffer delay bit under the protection of i_data_sem.
  */
-static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
-			      struct ext4_map_blocks *map,
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
-	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
-		retval = es.es_len - (iblock - es.es_lblk);
-		if (retval > map->m_len)
-			retval = map->m_len;
-		map->m_len = retval;
-
-		if (ext4_es_is_hole(&es))
-			goto add_delayed;
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+		retval = es.es_len - (map->m_lblk - es.es_lblk);
+		map->m_len = min_t(unsigned int, map->m_len, retval);
 
 		/*
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
+		if (ext4_es_is_hole(&es))
+			goto add_delayed;
 
-		map->m_pblk = ext4_es_pblock(&es) + iblock - es.es_lblk;
+		map->m_pblk = ext4_es_pblock(&es) + map->m_lblk - es.es_lblk;
 		if (ext4_es_is_written(&es))
 			map->m_flags |= EXT4_MAP_MAPPED;
 		else if (ext4_es_is_unwritten(&es))
@@ -1743,7 +1732,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		ext4_map_blocks_es_recheck(NULL, inode, map, &orig_map, 0);
 #endif
 		if (ext4_es_is_delayed(&es) || ext4_es_is_written(&es))
-			return retval;
+			return 0;
 
 		down_read(&EXT4_I(inode)->i_data_sem);
 		goto insert_extent;
@@ -1775,6 +1764,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 			WARN_ON(1);
 		}
 insert_extent:
+		retval = 0;
 		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 		if (status == EXTENT_STATUS_UNWRITTEN)
@@ -1788,14 +1778,10 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
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
 
@@ -1815,11 +1801,15 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
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
 
@@ -1828,22 +1818,29 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	 * preallocated blocks are unmapped but should treated
 	 * the same as allocated blocks.
 	 */
-	ret = ext4_da_map_blocks(inode, iblock, &map, bh);
-	if (ret <= 0)
+	ret = ext4_da_map_blocks(inode, &map);
+	if (ret < 0)
 		return ret;
 
-	map_bh(bh, inode->i_sb, map.m_pblk);
-	ext4_update_bh_state(bh, map.m_flags);
-
-	if (buffer_unwritten(bh)) {
-		/* A delayed write to unwritten bh should be marked
-		 * new and mapped.  Mapped ensures that we don't do
-		 * get_block multiple times when we write to the same
-		 * offset and new ensures that we do proper zero out
-		 * for partial write.
-		 */
+	if (map.m_flags & EXT4_MAP_DELAYED) {
+		map_bh(bh, inode->i_sb, invalid_block);
 		set_buffer_new(bh);
-		set_buffer_mapped(bh);
+		set_buffer_delay(bh);
+	} else {
+		map_bh(bh, inode->i_sb, map.m_pblk);
+		ext4_update_bh_state(bh, map.m_flags);
+
+		if (buffer_unwritten(bh)) {
+			/*
+			 * A delayed write to unwritten bh should be marked
+			 * new and mapped.  Mapped ensures that we don't do
+			 * get_block multiple times when we write to the same
+			 * offset and new ensures that we do proper zero out
+			 * for partial write.
+			 */
+			set_buffer_new(bh);
+			set_buffer_mapped(bh);
+		}
 	}
 	return 0;
 }
-- 
2.39.2


