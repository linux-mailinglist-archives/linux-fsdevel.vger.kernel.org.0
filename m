Return-Path: <linux-fsdevel+bounces-19311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F978C30E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 13:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A44F1C20B1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2855E48;
	Sat, 11 May 2024 11:37:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D653362;
	Sat, 11 May 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715427430; cv=none; b=DhLxmwJpRtJImKVe7sx8tqMW9euQkV+QuBM41k09qOdO+U+0oz/kwo+Lv9RCO3sx6567jrhZxtNp2Om2gahOBYydUDP4MOEHRl9Q/+PvLGvccgSrp7PIKyWuD+xh3Ik7H+Jxgbhdo9cylC1Wi4lHaCainxLph/dbHkGj8267FTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715427430; c=relaxed/simple;
	bh=r3kGCj6p4ccBjVSfW52HjxMspg48PzdX9qXYKJ4T0w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VB7QxM3HIcMXOXrL6qaiguuFjFJfRfd4Y6JZjhAxl7LQM6eAYSIa6ensEyrOo2ByCBjNtiq5Nn1yzNc616gLHjDeOM6lxgZKjpQMN7Xtyy2SnbL7UNN+Dhe6mRcdBe1OQ4onh8Q4Ge80lCmR4Q0xWq9wIg+6Hq8u8fUu4lDCaZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vc3ck5Dmhz4f3lVm;
	Sat, 11 May 2024 19:36:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B3B421A01D2;
	Sat, 11 May 2024 19:37:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxA+WD9mG0B4MQ--.22689S5;
	Sat, 11 May 2024 19:37:04 +0800 (CST)
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
Subject: [PATCH v4 01/10] ext4: factor out a common helper to query extent map
Date: Sat, 11 May 2024 19:26:10 +0800
Message-Id: <20240511112619.3656450-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240511112619.3656450-1-yi.zhang@huaweicloud.com>
References: <20240511112619.3656450-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxA+WD9mG0B4MQ--.22689S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXr47GrW8uF4UWr1xtF1DWrg_yoW5WF43pr
	W3CryrCr1UWws2gayftr1UZFyfK3W5trZFq397Wr15A3W5CrnayF15tFySqFyDKrZ7Xw4Y
	qFWSkryrCw4rGrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjLL07UUUUU=
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Factor out a new common helper ext4_map_query_blocks() from the
ext4_da_map_blocks(), it query and return the extent map status on the
inode's extent path, no logic changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 57 +++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 537803250ca9..6a41172c06e1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -453,6 +453,35 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 }
 #endif /* ES_AGGRESSIVE_TEST */
 
+static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
+				 struct ext4_map_blocks *map)
+{
+	unsigned int status;
+	int retval;
+
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		retval = ext4_ext_map_blocks(handle, inode, map, 0);
+	else
+		retval = ext4_ind_map_blocks(handle, inode, map, 0);
+
+	if (retval <= 0)
+		return retval;
+
+	if (unlikely(retval != map->m_len)) {
+		ext4_warning(inode->i_sb,
+			     "ES len assertion failed for inode "
+			     "%lu: retval %d != map->m_len %d",
+			     inode->i_ino, retval, map->m_len);
+		WARN_ON(1);
+	}
+
+	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
+			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
+	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+			      map->m_pblk, status);
+	return retval;
+}
+
 /*
  * The ext4_map_blocks() function tries to look up the requested blocks,
  * and returns if the blocks are already mapped.
@@ -1744,33 +1773,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 	down_read(&EXT4_I(inode)->i_data_sem);
 	if (ext4_has_inline_data(inode))
 		retval = 0;
-	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
 	else
-		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
-	if (retval < 0) {
-		up_read(&EXT4_I(inode)->i_data_sem);
-		return retval;
-	}
-	if (retval > 0) {
-		unsigned int status;
-
-		if (unlikely(retval != map->m_len)) {
-			ext4_warning(inode->i_sb,
-				     "ES len assertion failed for inode "
-				     "%lu: retval %d != map->m_len %d",
-				     inode->i_ino, retval, map->m_len);
-			WARN_ON(1);
-		}
-
-		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
-				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-				      map->m_pblk, status);
-		up_read(&EXT4_I(inode)->i_data_sem);
-		return retval;
-	}
+		retval = ext4_map_query_blocks(NULL, inode, map);
 	up_read(&EXT4_I(inode)->i_data_sem);
+	if (retval)
+		return retval;
 
 add_delayed:
 	down_write(&EXT4_I(inode)->i_data_sem);
-- 
2.39.2


