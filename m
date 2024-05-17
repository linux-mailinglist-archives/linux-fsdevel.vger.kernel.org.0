Return-Path: <linux-fsdevel+bounces-19672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69968C868F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BB4283BE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3007554746;
	Fri, 17 May 2024 12:51:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C74EB36;
	Fri, 17 May 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715950262; cv=none; b=Ovffk0LHY9qureBLh8zOEQM2dXTr5lHCj87PUo1gIOPR1BHlaNUDlovDcD2Q4RTnWCtc4j4yAgWx1UPk73NsBzaJuU8dokbDVXmTVAbshVSbu8UOCSnFc6KZZRnteH0GwLUx3xWr4Dy/0gdTvRR1PwXbbRWpQHeDATOWjwT6Ywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715950262; c=relaxed/simple;
	bh=z5dbdQK1P7O99RM08Qo0pGpaYAbIH6tpnlYeWwUdZSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTmUswNRoPDiNX9pHK3vQP69/P1+oeqCBKKX+nw3wyy6rxpmQwKuRPqnGSUdPSGO9rUYHw1k765dfri4ctAXojSd7mVovdU0dF+BO0zBzuIb+q7jjp2HVZXXl/GZqbaMyUAn1ybfg+A+fHl8UZcoKU8DQkhNGdA2U94tdvsGP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VgmzH3LpFz4f3k6f;
	Fri, 17 May 2024 20:50:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 17ED71A017F;
	Fri, 17 May 2024 20:50:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGdUkdmdAmqMw--.14380S9;
	Fri, 17 May 2024 20:50:56 +0800 (CST)
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
Subject: [PATCH v5 05/10] ext4: drop iblock parameter
Date: Fri, 17 May 2024 20:40:00 +0800
Message-Id: <20240517124005.347221-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
References: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBGdUkdmdAmqMw--.14380S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy7KF4UGr47WF47XrW5Wrg_yoW5Gw18p3
	93CF1rGr4fuw109a1xtF17ZF1rKa1UtrW7Jryftr1Fka4kGF1xtF4DAF12ya4UKrWfXFn0
	qF4Utr1Uuw4SyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU17G
	YJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The start block of the delalloc extent to be inserted is equal to
map->m_lblk, just drop the duplicate iblock input parameter.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fb76016e2ab7..de157aebc306 100644
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
@@ -1790,8 +1789,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 	 * is held in write mode, before inserting a new da entry in
 	 * the extent status tree.
 	 */
-	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
-		retval = es.es_len - (iblock - es.es_lblk);
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+		retval = es.es_len - (map->m_lblk - es.es_lblk);
 		if (retval > map->m_len)
 			retval = map->m_len;
 		map->m_len = retval;
@@ -1848,7 +1847,7 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	 * preallocated blocks are unmapped but should treated
 	 * the same as allocated blocks.
 	 */
-	ret = ext4_da_map_blocks(inode, iblock, &map, bh);
+	ret = ext4_da_map_blocks(inode, &map, bh);
 	if (ret <= 0)
 		return ret;
 
-- 
2.39.2


