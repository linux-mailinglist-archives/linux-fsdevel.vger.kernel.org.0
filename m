Return-Path: <linux-fsdevel+bounces-32563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F58A9A96C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9229B1F250D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09DC1E0E18;
	Tue, 22 Oct 2024 03:13:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324A148850;
	Tue, 22 Oct 2024 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566785; cv=none; b=LlSx4piQqUSyfPPLHT9/HpnUc+76IG9ChlQr2EY7NhvlLEQwcJCDFPa0y+LKJUsQMotUtYpkuvEB8FPkI08EAI4QjfWIXs9qFHN0sjQyN2ZdF4M3rO830ZF466+eKx8iC8jhoro+fyL9ZReLHcAhS/oTMsxOKmg5vrwm4JGQnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566785; c=relaxed/simple;
	bh=mvYROxnhlgk2x4bYLtyr7uhZYNNSevG/8KgsQUSX+BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShlEKI1V48EycMcOIqEVPtgmCJV5ZsajI52AznSHcohfToHiFl6LDzEpLiYmrr2NRHOt5x5lSJaSORAKfxsPZoSxKAsvYdEEpdp26PzsZv6FRWbJFytfrJyYrIhRqRSw9vCR0Xp2MbRwLl4HbE+g507l5SbKrmEWYbYyYsZJj80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXcgF31JNz4f3jXP;
	Tue, 22 Oct 2024 11:12:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BF4F01A018C;
	Tue, 22 Oct 2024 11:12:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S19;
	Tue, 22 Oct 2024 11:12:58 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 15/27] ext4: implement buffered write iomap path
Date: Tue, 22 Oct 2024 19:10:46 +0800
Message-ID: <20241022111059.2566137-16-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S19
X-Coremail-Antispam: 1UD129KBjvJXoW3ZFy8Zr1fJw1kGFy8Ar4rGrg_yoWDZF4kpF
	Z0kry5GF47Xr97uF4ftF47Zr1Fk3Wxtr4UCrW3Wrn8Xr9IyryIqF409FyayF15t3yxCr4j
	qF4Ykry8Wr4UCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRRgAFtUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Introduce two new iomap_ops: ext4_iomap_buffered_write_ops and
ext4_iomap_buffered_da_write_ops to implement the iomap write path.
These operations invoke ext4_da_map_blocks() to map delayed allocation
extents and introduce ext4_iomap_get_blocks() to directly allocate
blocks in non-delayed allocation mode. Additionally, implement
ext4_iomap_valid() to check the validity of extent mapping.

There are two key differences between the buffer_head write path and the
iomap write path:

1) In the iomap write path, we always allocate unwritten extents for new
   blocks, which means we consistently enable dioread_nolock. Therefore,
   we do not need to truncate blocks for short writes and write failure.
2) The iomap write frame maps multi-blocks in the ->iomap_begin()
   function, so we must remove the stale delayed allocation range from
   the short writes and write failure. Otherwise, this could result in a
   range of delayed extents being covered by a clean folio, leading to
   inaccurate space reservation.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |   3 +
 fs/ext4/file.c  |  19 +++++-
 fs/ext4/inode.c | 155 +++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 169 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ee170196bfff..a09f96ef17d8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2985,6 +2985,7 @@ int ext4_walk_page_buffers(handle_t *handle,
 				     struct buffer_head *bh));
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
+int ext4_nonda_switch(struct super_block *sb);
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
 
@@ -3845,6 +3846,8 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
 extern const struct iomap_ops ext4_iomap_ops;
 extern const struct iomap_ops ext4_iomap_overwrite_ops;
 extern const struct iomap_ops ext4_iomap_report_ops;
+extern const struct iomap_ops ext4_iomap_buffered_write_ops;
+extern const struct iomap_ops ext4_iomap_buffered_da_write_ops;
 
 static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 {
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f14aed14b9cf..92471865b4e5 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -282,6 +282,20 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	return count;
 }
 
+static ssize_t ext4_iomap_buffered_write(struct kiocb *iocb,
+					 struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	const struct iomap_ops *iomap_ops;
+
+	if (test_opt(inode->i_sb, DELALLOC) && !ext4_nonda_switch(inode->i_sb))
+		iomap_ops = &ext4_iomap_buffered_da_write_ops;
+	else
+		iomap_ops = &ext4_iomap_buffered_write_ops;
+
+	return iomap_file_buffered_write(iocb, from, iomap_ops, NULL);
+}
+
 static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 					struct iov_iter *from)
 {
@@ -296,7 +310,10 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	if (ret <= 0)
 		goto out;
 
-	ret = generic_perform_write(iocb, from);
+	if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP))
+		ret = ext4_iomap_buffered_write(iocb, from);
+	else
+		ret = generic_perform_write(iocb, from);
 
 out:
 	inode_unlock(inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f0bc4b58ac4f..23cbcaab0a56 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2862,7 +2862,7 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	return ret;
 }
 
-static int ext4_nonda_switch(struct super_block *sb)
+int ext4_nonda_switch(struct super_block *sb)
 {
 	s64 free_clusters, dirty_clusters;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -3257,6 +3257,15 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	return inode->i_state & I_DIRTY_DATASYNC;
 }
 
+static bool ext4_iomap_valid(struct inode *inode, const struct iomap *iomap)
+{
+	return iomap->validity_cookie == READ_ONCE(EXT4_I(inode)->i_es_seq);
+}
+
+static const struct iomap_folio_ops ext4_iomap_folio_ops = {
+	.iomap_valid = ext4_iomap_valid,
+};
+
 static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 			   struct ext4_map_blocks *map, loff_t offset,
 			   loff_t length, unsigned int flags)
@@ -3287,6 +3296,9 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	    !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		iomap->flags |= IOMAP_F_MERGED;
 
+	iomap->validity_cookie = READ_ONCE(EXT4_I(inode)->i_es_seq);
+	iomap->folio_ops = &ext4_iomap_folio_ops;
+
 	/*
 	 * Flags passed to ext4_map_blocks() for direct I/O writes can result
 	 * in m_flags having both EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits
@@ -3526,11 +3538,57 @@ const struct iomap_ops ext4_iomap_report_ops = {
 	.iomap_begin = ext4_iomap_begin_report,
 };
 
-static int ext4_iomap_buffered_read_begin(struct inode *inode, loff_t offset,
-			loff_t length, unsigned int flags, struct iomap *iomap,
-			struct iomap *srcmap)
+static int ext4_iomap_get_blocks(struct inode *inode,
+				 struct ext4_map_blocks *map)
 {
-	int ret;
+	loff_t i_size = i_size_read(inode);
+	handle_t *handle;
+	int ret, needed_blocks;
+
+	/*
+	 * Check if the blocks have already been allocated, this could
+	 * avoid initiating a new journal transaction and return the
+	 * mapping information directly.
+	 */
+	if ((map->m_lblk + map->m_len) <=
+	    round_up(i_size, i_blocksize(inode)) >> inode->i_blkbits) {
+		ret = ext4_map_blocks(NULL, inode, map, 0);
+		if (ret < 0)
+			return ret;
+		if (map->m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN |
+				    EXT4_MAP_DELAYED))
+			return 0;
+	}
+
+	/*
+	 * Reserve one block more for addition to orphan list in case
+	 * we allocate blocks but write fails for some reason.
+	 */
+	needed_blocks = ext4_writepage_trans_blocks(inode) + 1;
+	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, needed_blocks);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	ret = ext4_map_blocks(handle, inode, map,
+			      EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
+	/*
+	 * We need to stop handle here due to a potential deadlock caused
+	 * by the subsequent call to balance_dirty_pages(). This function
+	 * may wait for the dirty pages to be written back, which could
+	 * initiate another handle and cause it to wait for the first
+	 * handle to complete.
+	 */
+	ext4_journal_stop(handle);
+
+	return ret;
+}
+
+static int ext4_iomap_buffered_begin(struct inode *inode, loff_t offset,
+				     loff_t length, unsigned int flags,
+				     struct iomap *iomap, struct iomap *srcmap,
+				     bool delalloc)
+{
+	int ret, retries = 0;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
 
@@ -3541,13 +3599,23 @@ static int ext4_iomap_buffered_read_begin(struct inode *inode, loff_t offset,
 	/* Inline data support is not yet available. */
 	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
 		return -ERANGE;
-
+retry:
 	/* Calculate the first and last logical blocks respectively. */
 	map.m_lblk = offset >> blkbits;
 	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
 			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	if (flags & IOMAP_WRITE) {
+		if (delalloc)
+			ret = ext4_da_map_blocks(inode, &map);
+		else
+			ret = ext4_iomap_get_blocks(inode, &map);
 
-	ret = ext4_map_blocks(NULL, inode, &map, 0);
+		if (ret == -ENOSPC &&
+		    ext4_should_retry_alloc(inode->i_sb, &retries))
+			goto retry;
+	} else {
+		ret = ext4_map_blocks(NULL, inode, &map, 0);
+	}
 	if (ret < 0)
 		return ret;
 
@@ -3555,6 +3623,79 @@ static int ext4_iomap_buffered_read_begin(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static int ext4_iomap_buffered_read_begin(struct inode *inode,
+			loff_t offset, loff_t length, unsigned int flags,
+			struct iomap *iomap, struct iomap *srcmap)
+{
+	return ext4_iomap_buffered_begin(inode, offset, length, flags,
+					 iomap, srcmap, false);
+}
+
+static int ext4_iomap_buffered_write_begin(struct inode *inode,
+			loff_t offset, loff_t length, unsigned int flags,
+			struct iomap *iomap, struct iomap *srcmap)
+{
+	return ext4_iomap_buffered_begin(inode, offset, length, flags,
+					 iomap, srcmap, false);
+}
+
+static int ext4_iomap_buffered_da_write_begin(struct inode *inode,
+			loff_t offset, loff_t length, unsigned int flags,
+			struct iomap *iomap, struct iomap *srcmap)
+{
+	return ext4_iomap_buffered_begin(inode, offset, length, flags,
+					 iomap, srcmap, true);
+}
+
+/*
+ * Drop the staled delayed allocation range from the write failure,
+ * including both start and end blocks. If not, we could leave a range
+ * of delayed extents covered by a clean folio, it could lead to
+ * inaccurate space reservation.
+ */
+static void ext4_iomap_punch_delalloc(struct inode *inode, loff_t offset,
+				     loff_t length, struct iomap *iomap)
+{
+	down_write(&EXT4_I(inode)->i_data_sem);
+	ext4_es_remove_extent(inode, offset >> inode->i_blkbits,
+			DIV_ROUND_UP_ULL(length, EXT4_BLOCK_SIZE(inode->i_sb)));
+	up_write(&EXT4_I(inode)->i_data_sem);
+}
+
+static int ext4_iomap_buffered_da_write_end(struct inode *inode, loff_t offset,
+					    loff_t length, ssize_t written,
+					    unsigned int flags,
+					    struct iomap *iomap)
+{
+	loff_t start_byte, end_byte;
+
+	/* If we didn't reserve the blocks, we're not allowed to punch them. */
+	if (iomap->type != IOMAP_DELALLOC || !(iomap->flags & IOMAP_F_NEW))
+		return 0;
+
+	/* Nothing to do if we've written the entire delalloc extent */
+	start_byte = iomap_last_written_block(inode, offset, written);
+	end_byte = round_up(offset + length, i_blocksize(inode));
+	if (start_byte >= end_byte)
+		return 0;
+
+	filemap_invalidate_lock(inode->i_mapping);
+	iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
+				     iomap, ext4_iomap_punch_delalloc);
+	filemap_invalidate_unlock(inode->i_mapping);
+	return 0;
+}
+
+
+const struct iomap_ops ext4_iomap_buffered_write_ops = {
+	.iomap_begin = ext4_iomap_buffered_write_begin,
+};
+
+const struct iomap_ops ext4_iomap_buffered_da_write_ops = {
+	.iomap_begin = ext4_iomap_buffered_da_write_begin,
+	.iomap_end = ext4_iomap_buffered_da_write_end,
+};
+
 const struct iomap_ops ext4_iomap_buffered_read_ops = {
 	.iomap_begin = ext4_iomap_buffered_read_begin,
 };
-- 
2.46.1


