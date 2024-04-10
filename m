Return-Path: <linux-fsdevel+bounces-16513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 472C489E88D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 05:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DC028562C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 03:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3F12E73;
	Wed, 10 Apr 2024 03:50:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DB9BE49;
	Wed, 10 Apr 2024 03:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712721053; cv=none; b=eh4zKYjbXHbB3bUTsVw10/a3gYRQyJ3Sj3xSgHDccTJ7XGxVifXb2HNY5ZyVjSe21uJxRMoJ2DW1MQoGve40QAko5brfVt438WfTklUdS3HXeK0+NE3Rp7DkWbGWRMLvqQPUbTrv3kUq4XmO9rtq1y6ZGPSR3g3CtdWK3TeeeqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712721053; c=relaxed/simple;
	bh=bufxHOVc0PpM9V2w/cjt4ES+5o3E5VFV22cph4TnOxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhJ0GpgErZdKG0qyUmttYWQrdeUBRGswGWkClvpTQUhmrdi/BgOpsw6EDsYRU7DgT65R1ghRlmDiz8Gg8zEjmOhANxA5BEn6GRCZTqKVjSpWf7YgVb0B4/rsfY0SdNk0pP3891gb/4qY4DWf+xo3x1MudzcVw8gJaY8PxkXoQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VDpl364xjz4f3mJD;
	Wed, 10 Apr 2024 11:50:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 791BB1A0568;
	Wed, 10 Apr 2024 11:50:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGADBZmy5ZTJg--.21880S8;
	Wed, 10 Apr 2024 11:50:48 +0800 (CST)
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
Subject: [PATCH v2 4/9] ext4: drop iblock parameter
Date: Wed, 10 Apr 2024 11:41:58 +0800
Message-Id: <20240410034203.2188357-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBGADBZmy5ZTJg--.21880S8
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy7ZFy7XrW5Jr1rCFW3Wrg_yoW5Gr47p3
	93AF1rGr1fuw109a1xtF17ZF1Sga1UtrW7Jryftr1Fkas5GF1ftF4DAF12yFy8trWfXFn0
	qF4jqr1UCw4SyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
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


