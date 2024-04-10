Return-Path: <linux-fsdevel+bounces-16547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026FE89F848
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343DF1C25B3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A52616DEA5;
	Wed, 10 Apr 2024 13:37:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568A15F414;
	Wed, 10 Apr 2024 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756220; cv=none; b=YjXhG/9ULg52zM+09rxu/zk5B3tZZq98U2hqQo8iGmIItuBDzab63FoON72UFWpA4yGnvQzavM65g5L8h3ekVLWr+scyOxRe1bx9hUvj3pgX0bgzSOswT9fGwVe/3ZJZg94oiY3gEclIlWu8eK2Ljj8coYHTg7DfjZbraUhHh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756220; c=relaxed/simple;
	bh=bufxHOVc0PpM9V2w/cjt4ES+5o3E5VFV22cph4TnOxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rizAFsd/1dIW45nmotpu+TcEs0tld3XbEnJOhF7lLh4AVqhEAv1rhUvceKBIsFGhJFwMu5RWrAygavBS5xcmkrBIiJCs6NKYnHDdiFidlxakxjZHttr9Y5A1AbEXBB5rrRNfjQI+dhQagugdlxodQslEJkhMkJT0d32HZ8/Nx5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF3lH4gPFz4f3kFy;
	Wed, 10 Apr 2024 21:36:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7AF721A09EE;
	Wed, 10 Apr 2024 21:36:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHolRZmeCl4Jg--.8806S8;
	Wed, 10 Apr 2024 21:36:50 +0800 (CST)
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
Subject: [PATCH v4 04/34] ext4: drop iblock parameter
Date: Wed, 10 Apr 2024 21:27:48 +0800
Message-Id: <20240410132818.2812377-5-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+RHolRZmeCl4Jg--.8806S8
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy7ZFy7XrW5Jr1rCFW3Wrg_yoW5Gr47p3
	93AF1rGr1fuw109a1xtF17ZF1Sga1UtrW7Jryftr1Fkas5GF1ftF4DAF12yFy8trWfXFn0
	qF4jqr1UCw4SyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU17G
	YJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The start block of the delalloc extent to be inserted is equal to
map->m_lblk, just drop the duplicate iblock input parameter.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e4043ddb07a5..cccc16506f5f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1712,8 +1712,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
  * time. This function looks up the requested blocks and sets the
  * buffer delay bit under the protection of i_data_sem.
  */
-static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
-			      struct ext4_map_blocks *map,
+static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 			      struct buffer_head *bh)
 {
 	struct extent_status es;
@@ -1733,8 +1732,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		  (unsigned long) map->m_lblk);
 
 	/* Lookup extent status tree firstly */
-	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
-		retval = es.es_len - (iblock - es.es_lblk);
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+		retval = es.es_len - (map->m_lblk - es.es_lblk);
 		if (retval > map->m_len)
 			retval = map->m_len;
 		map->m_len = retval;
@@ -1754,7 +1753,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 			return 0;
 		}
 
-		map->m_pblk = ext4_es_pblock(&es) + iblock - es.es_lblk;
+		map->m_pblk = ext4_es_pblock(&es) + map->m_lblk - es.es_lblk;
 		if (ext4_es_is_written(&es))
 			map->m_flags |= EXT4_MAP_MAPPED;
 		else if (ext4_es_is_unwritten(&es))
@@ -1788,8 +1787,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 	 * inserting delalloc range haven't been delayed or allocated
 	 * whitout holding i_rwsem and folio lock.
 	 */
-	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
-		retval = es.es_len - (iblock - es.es_lblk);
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+		retval = es.es_len - (map->m_lblk - es.es_lblk);
 		if (retval > map->m_len)
 			retval = map->m_len;
 		map->m_len = retval;
@@ -1846,7 +1845,7 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	 * preallocated blocks are unmapped but should treated
 	 * the same as allocated blocks.
 	 */
-	ret = ext4_da_map_blocks(inode, iblock, &map, bh);
+	ret = ext4_da_map_blocks(inode, &map, bh);
 	if (ret <= 0)
 		return ret;
 
-- 
2.39.2


