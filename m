Return-Path: <linux-fsdevel+bounces-15766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFA6892B15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 13:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8625283183
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 12:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880F83A1A8;
	Sat, 30 Mar 2024 12:10:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D221B36B08;
	Sat, 30 Mar 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711800640; cv=none; b=OB/iChXpB2eGKiuJOTxEZynOVI6EhcBpG8d8a7jxcsidN6LGtAjDtSXPSIV4g7mg2KQFSqlNomYb9oXwVVK2F7+s00Dj+qFC9BdXI0D3PwojHaz/jJeUYDy2aF7ocEGHIjnEEIYTAt/kGkkhSQ/CxQh0j/EYAi79toFdJXl8vTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711800640; c=relaxed/simple;
	bh=7IUGd/49CBEzjxeD3mYDsTlgWcj1SvsHfd95vnGm+LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQdOr1LUjLkzGHiNSRjzGq2MIGATfy5Rl5hFJ9RYLA5Gh68id5QR9O67kpry/HSv1mufoEwV94ChCbt7mNPtaSOMsGvZv2IunCiECk8TRY9ZePoy1mpgYOfeJZCgLpRpqDfmOIYtJMbi+TnS1yLeenoa14cBRUqaSP73Zw0tCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V6GLn4tQgz4f3mHf;
	Sat, 30 Mar 2024 20:10:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E73C81A0232;
	Sat, 30 Mar 2024 20:10:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REsAQhmkPEjIg--.10652S10;
	Sat, 30 Mar 2024 20:10:33 +0800 (CST)
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
Subject: [PATCH 6/7] ext4: make ext4_insert_delayed_block() insert multi-blocks
Date: Sat, 30 Mar 2024 20:02:35 +0800
Message-Id: <20240330120236.3789589-7-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+REsAQhmkPEjIg--.10652S10
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1DuF47Aw48XFW3ZF47Jwb_yoWrGryDpr
	Z8CF1fJrWagr92gF4Sqr1DXr1aga1ktrWDJFZIg3WrZrWfJFyfKF1DtF13XF1SkrZ5Ja1Y
	qFW5A34Uuan0ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Rename ext4_insert_delayed_block() to ext4_insert_delayed_blocks(),
pass length parameter to make it insert multi delalloc blocks once a
time. For non-bigalloc case, just reserve len blocks and insert delalloc
extent. For bigalloc case, we can ensure the middle clusters are not
allocated, but need to check whether the start and end clusters are
delayed/allocated, if not, we should reserve more space for the start
and/or end block(s).

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 51 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 58bd4ed23cde..6983ced32dce 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1649,24 +1649,28 @@ static int ext4_da_check_clu_allocated(struct inode *inode, ext4_lblk_t lblk,
 }
 
 /*
- * ext4_insert_delayed_block - adds a delayed block to the extents status
- *                             tree, incrementing the reserved cluster/block
- *                             count or making a pending reservation
- *                             where needed
+ * ext4_insert_delayed_blocks - adds a multiple delayed blocks to the extents
+ *                              status tree, incrementing the reserved
+ *                              cluster/block count or making pending
+ *                              reservations where needed
  *
  * @inode - file containing the newly added block
- * @lblk - logical block to be added
+ * @lblk - start logical block to be added
+ * @len - length of blocks to be added
  *
  * Returns 0 on success, negative error code on failure.
  */
-static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
+static int ext4_insert_delayed_blocks(struct inode *inode, ext4_lblk_t lblk,
+				      ext4_lblk_t len)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	int ret;
-	bool allocated = false;
+	int resv_clu, ret;
+	bool lclu_allocated = false;
+	bool end_allocated = false;
+	ext4_lblk_t end = lblk + len - 1;
 
 	/*
-	 * If the cluster containing lblk is shared with a delayed,
+	 * If the cluster containing lblk or end is shared with a delayed,
 	 * written, or unwritten extent in a bigalloc file system, it's
 	 * already been accounted for and does not need to be reserved.
 	 * A pending reservation must be made for the cluster if it's
@@ -1677,21 +1681,38 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	 * extents status tree doesn't get a match.
 	 */
 	if (sbi->s_cluster_ratio == 1) {
-		ret = ext4_da_reserve_space(inode, 1);
+		ret = ext4_da_reserve_space(inode, len);
 		if (ret != 0)   /* ENOSPC */
 			return ret;
 	} else {   /* bigalloc */
-		ret = ext4_da_check_clu_allocated(inode, lblk, &allocated);
+		resv_clu = EXT4_B2C(sbi, end) - EXT4_B2C(sbi, lblk) - 1;
+		if (resv_clu < 0)
+			resv_clu = 0;
+
+		ret = ext4_da_check_clu_allocated(inode, lblk, &lclu_allocated);
 		if (ret < 0)
 			return ret;
-		if (ret > 0) {
-			ret = ext4_da_reserve_space(inode, 1);
+		if (ret > 0)
+			resv_clu++;
+
+		if (EXT4_B2C(sbi, lblk) != EXT4_B2C(sbi, end)) {
+			ret = ext4_da_check_clu_allocated(inode, end,
+							  &end_allocated);
+			if (ret < 0)
+				return ret;
+			if (ret > 0)
+				resv_clu++;
+		}
+
+		if (resv_clu) {
+			ret = ext4_da_reserve_space(inode, resv_clu);
 			if (ret != 0)   /* ENOSPC */
 				return ret;
 		}
 	}
 
-	ext4_es_insert_delayed_extent(inode, lblk, 1, allocated, false);
+	ext4_es_insert_delayed_extent(inode, lblk, len, lclu_allocated,
+				      end_allocated);
 	return 0;
 }
 
@@ -1792,7 +1813,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 
 add_delayed:
 	down_write(&EXT4_I(inode)->i_data_sem);
-	retval = ext4_insert_delayed_block(inode, map->m_lblk);
+	retval = ext4_insert_delayed_blocks(inode, map->m_lblk, map->m_len);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (retval)
 		return retval;
-- 
2.39.2


