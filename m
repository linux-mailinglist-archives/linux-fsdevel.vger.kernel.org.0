Return-Path: <linux-fsdevel+bounces-28828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B3496E9F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 08:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD0528A1AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 06:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6508914BF87;
	Fri,  6 Sep 2024 06:15:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81214A4C1;
	Fri,  6 Sep 2024 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603357; cv=none; b=GihTuCZ7ibiz66rV0FU+hHdh/lQvuCRkuQRkCfaL23/WEF+WvUtCq1jFm0SkvgnTqUeGurzBc2fW9+lLmHDif5GA0tCUirJkYAa//R8P57V740L3whLDx7cdQHnjpnRxdiac7NoARpwX0DiCtOuG9eaTQzfW6VdUV/AIj0eY+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603357; c=relaxed/simple;
	bh=DGiN00MEFZb29//k0HhtpU7XT9RPs4nXcpaAdtQZRAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YW+yS1p/532wTlbvgtnpCUY48+oIx8a3V51tnPVQIvu1+KjABJFlXDbgh6qCv0o/mEWSDF0mChKtBfrkXQgXr/QMumDKpCnA635S5r5l4bAKe1MbnSnk1ZyGxwvjSFZHwT8yt4KCmKhR4T9Lf+WoUgK8dqlOFmQShUCfACSg8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X0QvZ5hgYz4f3jkc;
	Fri,  6 Sep 2024 14:15:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 28AB51A0568;
	Fri,  6 Sep 2024 14:15:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgCH2oYLntpmsS4SAg--.27881S4;
	Fri, 06 Sep 2024 14:15:48 +0800 (CST)
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
Subject: [PATCH -next] ext4: don't pass full mapping flags to ext4_es_insert_extent()
Date: Fri,  6 Sep 2024 14:14:01 +0800
Message-Id: <20240906061401.2980330-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCH2oYLntpmsS4SAg--.27881S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWryxXFy8JFWxCFyUCry5XFb_yoWrZFyxp3
	9xCF18Gr4rWw409ayIyr4UXr15Ka47KrW7ArZakr1SgFW3JrySyF1UKFyYvFySqFW8Xr1Y
	vFWFk34UCay3Ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When converting a delalloc extent in ext4_es_insert_extent(), since we
only want to pass the info of whether the quota has already been claimed
if the allocation is a direct allocation from ext4_map_create_blocks(),
there is no need to pass full mapping flags, so changes to just pass
whether the EXT4_GET_BLOCKS_DELALLOC_RESERVE bit is set.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c        | 4 ++--
 fs/ext4/extents_status.c | 8 ++++----
 fs/ext4/extents_status.h | 3 ++-
 fs/ext4/inode.c          | 6 +++---
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 34e25eee6521..c144fe43a29f 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3138,7 +3138,7 @@ static void ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
 		return;
 
 	ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
-			      EXTENT_STATUS_WRITTEN, 0);
+			      EXTENT_STATUS_WRITTEN, false);
 }
 
 /* FIXME!! we need to try to merge to left or right after zero-out  */
@@ -4158,7 +4158,7 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
 	/* Put just found gap into cache to speed up subsequent requests */
 	ext_debug(inode, " -> %u:%u\n", hole_start, len);
 	ext4_es_insert_extent(inode, hole_start, len, ~0,
-			      EXTENT_STATUS_HOLE, 0);
+			      EXTENT_STATUS_HOLE, false);
 
 	/* Update hole_len to reflect hole size after lblk */
 	if (hole_start != lblk)
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index c786691dabd3..ae29832aab1e 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -848,7 +848,7 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
  */
 void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 			   ext4_lblk_t len, ext4_fsblk_t pblk,
-			   unsigned int status, int flags)
+			   unsigned int status, bool delalloc_reserve_used)
 {
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
@@ -863,8 +863,8 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
-	es_debug("add [%u/%u) %llu %x %x to extent status tree of inode %lu\n",
-		 lblk, len, pblk, status, flags, inode->i_ino);
+	es_debug("add [%u/%u) %llu %x %d to extent status tree of inode %lu\n",
+		 lblk, len, pblk, status, delalloc_reserve_used, inode->i_ino);
 
 	if (!len)
 		return;
@@ -945,7 +945,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	resv_used += pending;
 	if (resv_used)
 		ext4_da_update_reserve_space(inode, resv_used,
-				flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE);
+					     delalloc_reserve_used);
 
 	if (err1 || err2 || err3 < 0)
 		goto retry;
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 4424232de298..8f9c008d11e8 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -135,7 +135,8 @@ extern void ext4_es_init_tree(struct ext4_es_tree *tree);
 
 extern void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 				  ext4_lblk_t len, ext4_fsblk_t pblk,
-				  unsigned int status, int flags);
+				  unsigned int status,
+				  bool delalloc_reserve_used);
 extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t len, ext4_fsblk_t pblk,
 				 unsigned int status);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..599190d7ddf4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -483,7 +483,7 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-			      map->m_pblk, status, 0);
+			      map->m_pblk, status, false);
 	return retval;
 }
 
@@ -563,8 +563,8 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 
 	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-			      map->m_pblk, status, flags);
+	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,
+			      status, flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE);
 
 	return retval;
 }
-- 
2.39.2


