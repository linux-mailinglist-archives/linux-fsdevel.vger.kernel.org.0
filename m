Return-Path: <linux-fsdevel+bounces-16581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF38089FA38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE3A28946D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C754A179219;
	Wed, 10 Apr 2024 14:38:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A554172BBB;
	Wed, 10 Apr 2024 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759917; cv=none; b=lkjYsapkSP8wREV6TXu+1/caQLY4cf3Tatyp/Xz9VsCGLeqc139UukTpGW2H0cCRc6gOjhdHuqXZjZdwkiZ0FGF5v13Jln3gsHvSz8GNd7p2g5TR6moBmJCxN1lKDy16/BC4wooPryaf/W9O6GGOc4cpD2qF+kGhc86sqIeK0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759917; c=relaxed/simple;
	bh=NB4fXWHn4Tcd06n0yHnGM1XaWGMrwV7OP0+NM28cf2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ke5HOPymakrZW56xSIDdLzM4FAUXxJao+WwyhzUsrO7IWYtDAlNQVvIHUY4S5fLJSQ3OL00Ep2btWjmyAYb6tH4FFCGkmyg6fxY2Ne90kOrCnL/5IJv9ID9u3Cg1dYVBNfXlSJx9WF+MMjN3tbeI4z9tGlC9j7YxzSYU8jc4nj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF56Q2PtRz4f3m7Z;
	Wed, 10 Apr 2024 22:38:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F33A31A016E;
	Wed, 10 Apr 2024 22:38:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S12;
	Wed, 10 Apr 2024 22:38:30 +0800 (CST)
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
Subject: [PATCH v4 08/34] ext4: make ext4_insert_delayed_block() insert multi-blocks
Date: Wed, 10 Apr 2024 22:29:22 +0800
Message-Id: <20240410142948.2817554-9-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S12
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1DuF47Aw48XFW3ZF47Jwb_yoWrJFWkpr
	Z8CF1fJrWagr92gF4Sqr1DXr1aga1ktrWDJFZIgw1rZrWfJFyfKF1DtF13XF1SkrWkJa1Y
	vFW5A34Uuan0ka7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
index 46c34baa848a..08e2692b7286 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1678,24 +1678,28 @@ static int ext4_da_check_clu_allocated(struct inode *inode, ext4_lblk_t lblk,
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
@@ -1706,21 +1710,38 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
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
 
@@ -1823,7 +1844,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 		}
 	}
 
-	retval = ext4_insert_delayed_block(inode, map->m_lblk);
+	retval = ext4_insert_delayed_blocks(inode, map->m_lblk, map->m_len);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (retval)
 		return retval;
-- 
2.39.2


