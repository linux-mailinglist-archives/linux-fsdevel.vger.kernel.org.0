Return-Path: <linux-fsdevel+bounces-15768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D9F892B19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 13:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D7E1C20D44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186C63C068;
	Sat, 30 Mar 2024 12:10:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2573374D9;
	Sat, 30 Mar 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711800640; cv=none; b=S3JZ1zcj2rnxcOBOBZ+EndKcL4aPpJx0FmRAEbVDtyCVlOtj3BGAQg6hbc4rRycJRI5YFUp/t8yqqPUdUkcAPZoq09iDeY+dBK2BMdSSegFp9p8OSEl60qoFKV9sIij/HPbx5ndzN4EWfGRrPTxRSoya1Fm+W5hiQKP5JDEZE6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711800640; c=relaxed/simple;
	bh=j6+WM2D0HJzVVYM5B4Yvk3YhEQ5lQAT5x8NYg/Hcwp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LqT8Y8KQT9+Azz8aE/3DbCctBYpUqraJJzn+PH5uP0WIlfflxOwtLRSsz+p2Fi2qewR36yQMNIWkeOKdoRDJWO4JayRSVZevpjO6bPrGnZ/AqP6gk/Gm+hS5Vu2vG9snLxakHxTjDhUIOlQLG41cfKeJd+jimzkECeQOABx3Cc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V6GLr1Xhkz4f3jYY;
	Sat, 30 Mar 2024 20:10:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 573921A0B2E;
	Sat, 30 Mar 2024 20:10:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REsAQhmkPEjIg--.10652S6;
	Sat, 30 Mar 2024 20:10:32 +0800 (CST)
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
Subject: [PATCH 2/7] ext4: drop iblock parameter
Date: Sat, 30 Mar 2024 20:02:31 +0800
Message-Id: <20240330120236.3789589-3-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+REsAQhmkPEjIg--.10652S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWUAry7Cr4kZF4fCFy3urg_yoW8Zw4kp3
	98CF1rGr4fu3409a1IqF17ZF1Sga1jyFW7JryfKr1Fkas8GF1xtF4kAFy2va4DtrWfXFn0
	qFWUKryUuw4IyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The start block of the delalloc extent to be inserted is equal to
map->m_lblk, just drop the duplicate iblock input parameter.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b98f92622442..95f169801006 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1683,8 +1683,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
  * time. This function looks up the requested blocks and sets the
  * buffer delay bit under the protection of i_data_sem.
  */
-static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
-			      struct ext4_map_blocks *map,
+static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 			      struct buffer_head *bh)
 {
 	struct extent_status es;
@@ -1704,8 +1703,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		  (unsigned long) map->m_lblk);
 
 	/* Lookup extent status tree firstly */
-	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
-		retval = es.es_len - (iblock - es.es_lblk);
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+		retval = es.es_len - (map->m_lblk - es.es_lblk);
 		if (retval > map->m_len)
 			retval = map->m_len;
 		map->m_len = retval;
@@ -1724,7 +1723,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 			return 0;
 		}
 
-		map->m_pblk = ext4_es_pblock(&es) + iblock - es.es_lblk;
+		map->m_pblk = ext4_es_pblock(&es) + map->m_lblk - es.es_lblk;
 		if (ext4_es_is_written(&es))
 			map->m_flags |= EXT4_MAP_MAPPED;
 		else if (ext4_es_is_unwritten(&es))
@@ -1815,7 +1814,7 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	 * preallocated blocks are unmapped but should treated
 	 * the same as allocated blocks.
 	 */
-	ret = ext4_da_map_blocks(inode, iblock, &map, bh);
+	ret = ext4_da_map_blocks(inode, &map, bh);
 	if (ret <= 0)
 		return ret;
 
-- 
2.39.2


