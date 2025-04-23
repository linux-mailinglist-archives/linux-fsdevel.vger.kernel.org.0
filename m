Return-Path: <linux-fsdevel+bounces-47075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D7FA984A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7895E1B6295D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D04262FC3;
	Wed, 23 Apr 2025 09:03:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E022F75C;
	Wed, 23 Apr 2025 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399014; cv=none; b=cC83hznRGGz1i30y43uGmNZap0Jk9SnVVMg3xgmzSZeO65R61/9QQAikKOHRE5o8oMIVy7aWBSYF6TJtiXHDsoh3XNyjtv3O47OqykWGAYIenJuWWYPszTZqDMGj2DDXHzqgjjkJCuWSgvSTD6KUvLooDWvMI65W85FoHmuVVJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399014; c=relaxed/simple;
	bh=sAPACFC3t36Gg+WzxMkpC0hm41+8ifNe/Ut/dWkREHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z410rPM4uAtMcFfNHNSjVMCfQK1u3tD0OZwcag0sDk7GViNj2HoW1YvgCUot8/fgGQdZWK0qBgXe0BxvEl05w7D4G8GjveGk0yFeoMfypUapnj96iHG9fHCGeQcfQO07EisZRKeb4XPC/KV7YjWDEwwUw44gZkf8bChv+lFsKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZjCmx6Wgyz4f3jd9;
	Wed, 23 Apr 2025 17:02:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D4D571A07BB;
	Wed, 23 Apr 2025 17:03:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacPQrAhoJkGrKA--.8976S7;
	Wed, 23 Apr 2025 17:03:21 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 3/9] ext4: prevent stale extent cache entries caused by concurrent I/O writeback
Date: Wed, 23 Apr 2025 16:52:51 +0800
Message-ID: <20250423085257.122685-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
References: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacPQrAhoJkGrKA--.8976S7
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1fWw1kWF4xJF45Gry7GFg_yoW3CFWxpr
	ZrAF1rGr40g3yY9FWxJF1UXF1S93W8GFWUXrZ3GryY9FyUtryxtF15tFy3AFWFgrZ7Xa1Y
	qF45t34UAa15C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JULBMNUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Currently, in the I/O writeback path, ext4_map_blocks() may attempt to
cache additional unrelated extents in the extent status tree without
holding the inode's i_rwsem and the mapping's invalidate_lock. This can
lead to stale extent status entries remaining in certain scenarios,
potentially causing data corruption.

For example, when performing a collapse range in ext4_collapse_range(),
it clears the extent cache and dirty pages before removing blocks and
shifting extents. It also holds the i_data_sem during these two
operations. However, both ext4_ext_remove_space() and
ext4_ext_shift_extents() may briefly release the i_data_sem if journal
credits are insufficient (ext4_datasem_ensure_credits()). If another
writeback process writes dirty pages from other regions during this
interval, it may cache extents that are about to be modified. Unless
ext4_collapse_range() explicitly clears the extent cache again, these
cached entries can become stale and inconsistent with the actual
extents.

     0 a  n       b      c         m
     | |  |       |      |         |
    [www][wwwwww][wwwwwwww]...[wwwww][wwww]...
          |                           |
          N                           M

Assume that block a is dirty. The collapse range operation is removing
data from n to m and drops i_data_sem immediately after removing the
extent from b to c. At the same time, a concurrent writeback begins to
write back block a; it will reloads the extent from [n, b) into the
extent status tree since it does not hold the i_rwsem or the
invalidate_lock. After the collapse range operation, it left the stale
extent [n, b), which points logical block n to N, but the actual
physical block of n should be M.

Similarly, both ext4_insert_range() and ext4_truncate() have the same
problem. ext4_punch_hole() survived since it re-add a hole extent entry
after removing space since commit 9f1118223aa0 ("ext4: add a hole extent
entry in cache after punch").

In most cases, during dirty page writeback, the block mapping
information is likely to be found in the extent cache, making it less
necessary to search for physical extents. Consequently, loading
unrelated extent caches during writeback appears to be ineffective.
Therefore, fix this by adds EXT4_EX_NOCACHE in the writeback path to
prevent caching of unrelated extents, eliminating this potential source
of corruption.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h        |  1 +
 fs/ext4/extents.c     | 12 +++++++++---
 fs/ext4/fast_commit.c |  3 ++-
 fs/ext4/inode.c       | 28 ++++++++++++++++++++--------
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ad39bfe4b5d2..f04cad83d74b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -741,6 +741,7 @@ enum {
 #define EXT4_EX_NOCACHE				0x40000000
 #define EXT4_EX_FORCE_CACHE			0x20000000
 #define EXT4_EX_NOFAIL				0x10000000
+#define EXT4_EX_FILTER				0x70000000
 
 /*
  * Flags used by ext4_free_blocks
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d8eac736cc9a..8a5724b2dc51 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4202,7 +4202,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	trace_ext4_ext_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
 
 	/* find extent for this block */
-	path = ext4_find_extent(inode, map->m_lblk, NULL, 0);
+	path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
 	if (IS_ERR(path)) {
 		err = PTR_ERR(path);
 		goto out;
@@ -4315,7 +4315,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		goto out;
 	ar.lright = map->m_lblk;
 	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright,
-				    &ex2, 0);
+				    &ex2, flags);
 	if (err < 0)
 		goto out;
 
@@ -4820,8 +4820,14 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 				break;
 			}
 		}
+		/*
+		 * Do not cache any unrelated extents, as it does not hold the
+		 * i_rwsem or invalidate_lock, which could corrupt the extent
+		 * status tree.
+		 */
 		ret = ext4_map_blocks(handle, inode, &map,
-				      EXT4_GET_BLOCKS_IO_CONVERT_EXT);
+				      EXT4_GET_BLOCKS_IO_CONVERT_EXT |
+				      EXT4_EX_NOCACHE);
 		if (ret <= 0)
 			ext4_warning(inode->i_sb,
 				     "inode #%lu: block %u: len %u: "
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 11c42b39478b..ea4ec1ce9c85 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -911,7 +911,8 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 		map.m_lblk = cur_lblk_off;
 		map.m_len = new_blk_size - cur_lblk_off + 1;
 		ret = ext4_map_blocks(NULL, inode, &map,
-				      EXT4_GET_BLOCKS_IO_SUBMIT);
+				      EXT4_GET_BLOCKS_IO_SUBMIT |
+				      EXT4_EX_NOCACHE);
 		if (ret < 0)
 			return -ECANCELED;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..02eac9ee36f5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -463,15 +463,16 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 #endif /* ES_AGGRESSIVE_TEST */
 
 static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
-				 struct ext4_map_blocks *map)
+				 struct ext4_map_blocks *map, int flags)
 {
 	unsigned int status;
 	int retval;
 
+	flags &= EXT4_EX_FILTER;
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		retval = ext4_ext_map_blocks(handle, inode, map, 0);
+		retval = ext4_ext_map_blocks(handle, inode, map, flags);
 	else
-		retval = ext4_ind_map_blocks(handle, inode, map, 0);
+		retval = ext4_ind_map_blocks(handle, inode, map, flags);
 
 	if (retval <= 0)
 		return retval;
@@ -622,6 +623,13 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	if (unlikely(map->m_lblk >= EXT_MAX_BLOCKS))
 		return -EFSCORRUPTED;
 
+	/*
+	 * Do not allow caching of unrelated ranges of extents during I/O
+	 * submission.
+	 */
+	if (flags & EXT4_GET_BLOCKS_IO_SUBMIT)
+		WARN_ON_ONCE(!(flags & EXT4_EX_NOCACHE));
+
 	/* Lookup extent status tree firstly */
 	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
 	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
@@ -667,7 +675,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * file system block.
 	 */
 	down_read(&EXT4_I(inode)->i_data_sem);
-	retval = ext4_map_query_blocks(handle, inode, map);
+	retval = ext4_map_query_blocks(handle, inode, map, flags);
 	up_read((&EXT4_I(inode)->i_data_sem));
 
 found:
@@ -1805,7 +1813,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 	if (ext4_has_inline_data(inode))
 		retval = 0;
 	else
-		retval = ext4_map_query_blocks(NULL, inode, map);
+		retval = ext4_map_query_blocks(NULL, inode, map, 0);
 	up_read(&EXT4_I(inode)->i_data_sem);
 	if (retval)
 		return retval < 0 ? retval : 0;
@@ -1828,7 +1836,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 			goto found;
 		}
 	} else if (!ext4_has_inline_data(inode)) {
-		retval = ext4_map_query_blocks(NULL, inode, map);
+		retval = ext4_map_query_blocks(NULL, inode, map, 0);
 		if (retval) {
 			up_write(&EXT4_I(inode)->i_data_sem);
 			return retval < 0 ? retval : 0;
@@ -2212,11 +2220,15 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	 * previously reserved. However we must not fail because we're in
 	 * writeback and there is nothing we can do about it so it might result
 	 * in data loss.  So use reserved blocks to allocate metadata if
-	 * possible.
+	 * possible. In addition, do not cache any unrelated extents, as it
+	 * only holds the folio lock but does not hold the i_rwsem or
+	 * invalidate_lock, which could corrupt the extent status tree.
 	 */
 	get_blocks_flags = EXT4_GET_BLOCKS_CREATE |
 			   EXT4_GET_BLOCKS_METADATA_NOFAIL |
-			   EXT4_GET_BLOCKS_IO_SUBMIT;
+			   EXT4_GET_BLOCKS_IO_SUBMIT |
+			   EXT4_EX_NOCACHE;
+
 	dioread_nolock = ext4_should_dioread_nolock(inode);
 	if (dioread_nolock)
 		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
-- 
2.46.1


