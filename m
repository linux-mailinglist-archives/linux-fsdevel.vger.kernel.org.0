Return-Path: <linux-fsdevel+bounces-57676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDAAB245C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 11:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19D0188F08D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F32F83B9;
	Wed, 13 Aug 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ClvGGN57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110492F2905
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077938; cv=none; b=QVNAtzzmSTp+60rm25YP47im5oNMEviiq6rTp54qArkj2qqXX7LKiutdTkiMZolfLrOkM3bJewRd8+sGkA9ZGbFAegy6JDX7wbMAqv6J6/mAJIafq1S9yAZFML8QgY0eMfLz3IVfvDt6qxbNd1aXZJGgIhA0EKwxBBKHnI7puds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077938; c=relaxed/simple;
	bh=rLQq+NcPWV9gelBv2M0UAMaigjdZb3yB5T07GZkSdpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CsilRYw9gEASjY3p/ySkMNZIqGw72U7gkTrhUBhjysV4ic558BXkQ6tJqVA15VfjjpgBLRJxw7WTBBva6iKkiOfjh3afUlVgAbqev69z4DMFavHkiXhdX2weZXR3c70XCKjcQp3u1vXyM0Zmo/4gRfqC0rNCeW98lIIKL8QzvIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ClvGGN57; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=16
	xZxNhapx1zmrqQvDVTERS6UOfNY3zsXg4rsnEQ910=; b=ClvGGN57mNF4WAPJEs
	UfRl8twLY5O2SD/h2CodjCFFx6pDel9FfgeQsOFfEjkbMA5vYXoB/dXq3RmkEWDA
	iiE4zoc+Zt3SA8LzJw3qpDJIufdxlCUUKesWDqS0ym1iHnJJJrmieP2gy8K9l6W/
	i36Oj5ZqA42Uy5DOIVn1khFp4=
Received: from YLLaptop.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3tyv8XJxo_MzyBQ--.54250S10;
	Wed, 13 Aug 2025 17:38:30 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Yi Zhang <yi.zhang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Nanzhe Zhao <nzzhao@126.com>
Subject: [RFC PATCH 8/9] f2fs: Introduce F2FS_GET_BLOCK_IOMAP and map_blocks he lpers
Date: Wed, 13 Aug 2025 17:37:54 +0800
Message-Id: <20250813093755.47599-9-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813093755.47599-1-nzzhao@126.com>
References: <20250813093755.47599-1-nzzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3tyv8XJxo_MzyBQ--.54250S10
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFyDXFy3ZF43WF4DKw1rZwb_yoW7Gw4DpF
	yDAF1rGrs0grWxWF4fta1Uur1S9r1Ik3W7Ca93X3s8G3yqqr1SqFnYya43u3Z8tr4fJr1q
	qFs8K348KayxGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziUDGOUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiExSoz2icVjtiagAAsx

    Introduce the `F2FS_GET_BLOCK_IOMAP` flag for `f2fs_ma
p_blocks`.

    With this flag, holes encountered during buffered I/O
iterative mapping
    can now be merged under `map_is_mergeable`. Furthermor
e, when this flag
    is passed, `f2fs_map_blocks` will by default store the
 mapped block
    information (from the `f2fs_map_blocks` structure) int
o the extent cache,
    provided the resulting extent size is greater than the
 minimum allowed
    length for the f2fs extent cache.
    Notably, both holes and `NEW_ADDR`
    extents will also be cached under the influence of thi
s flag.
    This improves buffered write performance for sparse fi
les.

    Additionally, two helper functions are introduced:
    - `f2fs_map_blocks_iomap`: A simple wrapper for `f2fs_
map_blocks` that
      enables the `F2FS_GET_BLOCK_IOMAP` flag.
    - `f2fs_map_blocks_prealloc`: A simple wrapper for usi
ng
      `f2fs_map_blocks` to preallocate blocks.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/data.c | 49 +++++++++++++++++++++++++++++++++++++++++++------
 fs/f2fs/f2fs.h |  5 +++++
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5ecd08a3dd0b..37eaf431ab42 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1537,8 +1537,11 @@ static bool map_is_mergeable(struct f2fs_sb_info *sbi,
 		return true;
 	if (flag == F2FS_GET_BLOCK_PRE_DIO)
 		return true;
-	if (flag == F2FS_GET_BLOCK_DIO &&
-		map->m_pblk == NULL_ADDR && blkaddr == NULL_ADDR)
+	if (flag == F2FS_GET_BLOCK_DIO && map->m_pblk == NULL_ADDR &&
+	    blkaddr == NULL_ADDR)
+		return true;
+	if (flag == F2FS_GET_BLOCK_IOMAP && map->m_pblk == NULL_ADDR &&
+	    blkaddr == NULL_ADDR)
 		return true;
 	return false;
 }
@@ -1676,6 +1679,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 			if (map->m_next_pgofs)
 				*map->m_next_pgofs = pgofs + 1;
 			break;
+		case F2FS_GET_BLOCK_IOMAP:
+			if (map->m_next_pgofs)
+				*map->m_next_pgofs = pgofs + 1;
+			break;
 		default:
 			/* for defragment case */
 			if (map->m_next_pgofs)
@@ -1741,8 +1748,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	else if (dn.ofs_in_node < end_offset)
 		goto next_block;
 
-	if (flag == F2FS_GET_BLOCK_PRECACHE) {
-		if (map->m_flags & F2FS_MAP_MAPPED) {
+	if (flag == F2FS_GET_BLOCK_PRECACHE || flag == F2FS_GET_BLOCK_IOMAP) {
+		if (map->m_flags & F2FS_MAP_MAPPED &&
+		    map->m_len > F2FS_MIN_EXTENT_LEN) {
 			unsigned int ofs = start_pgofs - map->m_lblk;
 
 			f2fs_update_read_extent_cache_range(&dn,
@@ -1786,8 +1794,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		}
 	}
 
-	if (flag == F2FS_GET_BLOCK_PRECACHE) {
-		if (map->m_flags & F2FS_MAP_MAPPED) {
+	if (flag == F2FS_GET_BLOCK_PRECACHE || flag == F2FS_GET_BLOCK_IOMAP) {
+		if (map->m_flags & F2FS_MAP_MAPPED &&
+		    map->m_len > F2FS_MIN_EXTENT_LEN) {
 			unsigned int ofs = start_pgofs - map->m_lblk;
 
 			f2fs_update_read_extent_cache_range(&dn,
@@ -1808,6 +1817,34 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	return err;
 }
 
+int f2fs_map_blocks_iomap(struct inode *inode, block_t start, block_t len,
+			  struct f2fs_map_blocks *map)
+{
+	int err = 0;
+
+	map->m_lblk = start; // Logical block number for the start pos
+	map->m_len = len; // Length in blocks
+	map->m_may_create = false;
+	map->m_seg_type =
+		f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode), inode->i_write_hint);
+	err = f2fs_map_blocks(inode, map, F2FS_GET_BLOCK_IOMAP);
+	return err;
+}
+
+int f2fs_map_blocks_preallocate(struct inode *inode, block_t start, block_t len,
+				struct f2fs_map_blocks *map)
+{
+	int err = 0;
+
+	map->m_lblk = start;
+	map->m_len = len; // Length in blocks
+	map->m_may_create = true;
+	map->m_seg_type =
+		f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode), inode->i_write_hint);
+	err = f2fs_map_blocks(inode, map, F2FS_GET_BLOCK_PRE_AIO);
+	return err;
+}
+
 bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
 {
 	struct f2fs_map_blocks map;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c6b23fa63588..ac9a6ac13e1f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -788,6 +788,7 @@ enum {
 	F2FS_GET_BLOCK_PRE_DIO,
 	F2FS_GET_BLOCK_PRE_AIO,
 	F2FS_GET_BLOCK_PRECACHE,
+	F2FS_GET_BLOCK_IOMAP,
 };
 
 /*
@@ -4232,6 +4233,10 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 			struct folio *ifolio, pgoff_t index, bool new_i_size);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag);
+int f2fs_map_blocks_iomap(struct inode *inode, block_t start, block_t len,
+			  struct f2fs_map_blocks *map);
+int f2fs_map_blocks_preallocate(struct inode *inode, block_t start, block_t len,
+				struct f2fs_map_blocks *map);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len);
 int f2fs_encrypt_one_page(struct f2fs_io_info *fio);
-- 
2.34.1


