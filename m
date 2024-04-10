Return-Path: <linux-fsdevel+bounces-16600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C8D89FA72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E731C210AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8124D1836E7;
	Wed, 10 Apr 2024 14:38:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60E180A7D;
	Wed, 10 Apr 2024 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759928; cv=none; b=SAH4ig+S0IYYrA17APeF0ILCo44IhfZaxOuTlG+h9JX1JjkcpuJ19OdPEIX72UKaR0duiY5rvMjUsXSDWhAw1LUjwVipZqQfr+jPnOuZOWStkRO4RmCVFftKJ6UbU4Bvh3vszDyzEY4621cLCZAkSs8rL4b4Cm0S01cHtzvepZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759928; c=relaxed/simple;
	bh=zir+RySIpOI4280YlgxTovqSOcIQ4cJyXU3fiM9eSIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCJcSqXm6Aygif/mQrigAlSyTmAgQRnaKdsqL9dExY1b6B/5UQcTbl1X+jAVaODdnk+HN2BYRlYi/WpC72vHHgL6RU5nzDciVf1PuxiUPGCUFFAx2MCaeZrY+saJhx4RhOiKvVhkcd5ZDLzunD4RyymXQj9fMswtWYpzHS9ZSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF56c4sY0z4f3mHH;
	Wed, 10 Apr 2024 22:38:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 544CD1A0CFB;
	Wed, 10 Apr 2024 22:38:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S28;
	Wed, 10 Apr 2024 22:38:41 +0800 (CST)
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
Subject: [RFC PATCH v4 24/34] ext4: implement buffered write iomap path
Date: Wed, 10 Apr 2024 22:29:38 +0800
Message-Id: <20240410142948.2817554-25-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S28
X-Coremail-Antispam: 1UD129KBjvJXoWxtw43trWDZFy5ur4xZF1DJrb_yoWDGr1DpF
	Z0kry5GF47XF929F4ftF4UZr1ak3Wxtr4UCrW3Wrn8Xr9FyrWIqF40gFyayF45J3yxCr4j
	qF4jkry8WF47CrDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr
	1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7sRibyCPUUUU
	U==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Implement buffered write iomap path, use ext4_da_map_blocks() to map
delalloc extents and add ext4_iomap_get_blocks() to allocate blocks if
delalloc is disabled or free space is about to run out.

Note that we always allocate unwritten extents for new blocks in the
iomap write path, this means that the allocation type is no longer
controlled by the dioread_nolock mount option. After that, we could
postpone the i_disksize updating to the writeback path, and drop journal
handle in the buffered dealloc write path completely.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |   3 +
 fs/ext4/file.c  |  19 +++++-
 fs/ext4/inode.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 183 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 05949a8136ae..2bd543c43341 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2970,6 +2970,7 @@ int ext4_walk_page_buffers(handle_t *handle,
 				     struct buffer_head *bh));
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
+int ext4_nonda_switch(struct super_block *sb);
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
 
@@ -3827,6 +3828,8 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
 extern const struct iomap_ops ext4_iomap_ops;
 extern const struct iomap_ops ext4_iomap_overwrite_ops;
 extern const struct iomap_ops ext4_iomap_report_ops;
+extern const struct iomap_ops ext4_iomap_buffered_write_ops;
+extern const struct iomap_ops ext4_iomap_buffered_da_write_ops;
 
 static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 {
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 54d6ff22585c..52f37c49572a 100644
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
+	return iomap_file_buffered_write(iocb, from, iomap_ops);
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
index 20eb772f4f62..e825ed16fd60 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2857,7 +2857,7 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	return ret;
 }
 
-static int ext4_nonda_switch(struct super_block *sb)
+int ext4_nonda_switch(struct super_block *sb)
 {
 	s64 free_clusters, dirty_clusters;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -3254,6 +3254,15 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
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
@@ -3284,6 +3293,9 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	    !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		iomap->flags |= IOMAP_F_MERGED;
 
+	iomap->validity_cookie = READ_ONCE(EXT4_I(inode)->i_es_seq);
+	iomap->folio_ops = &ext4_iomap_folio_ops;
+
 	/*
 	 * Flags passed to ext4_map_blocks() for direct I/O writes can result
 	 * in m_flags having both EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits
@@ -3523,11 +3535,42 @@ const struct iomap_ops ext4_iomap_report_ops = {
 	.iomap_begin = ext4_iomap_begin_report,
 };
 
-static int ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
+static int ext4_iomap_get_blocks(struct inode *inode,
+				 struct ext4_map_blocks *map)
+{
+	handle_t *handle;
+	int ret, needed_blocks;
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
+	 * Have to stop journal here since there is a potential deadlock
+	 * caused by later balance_dirty_pages(), it might wait on the
+	 * ditry pages to be written back, which might start another
+	 * handle and wait this handle stop.
+	 */
+	ext4_journal_stop(handle);
+
+	return ret;
+}
+
+#define IOMAP_F_EXT4_DELALLOC		IOMAP_F_PRIVATE
+
+static int __ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
 				loff_t length, unsigned int iomap_flags,
-				struct iomap *iomap, struct iomap *srcmap)
+				struct iomap *iomap, struct iomap *srcmap,
+				bool delalloc)
 {
-	int ret;
+	int ret, retries = 0;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
 
@@ -3537,20 +3580,133 @@ static int ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
 		return -EINVAL;
 	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
 		return -ERANGE;
-
+retry:
 	/* Calculate the first and last logical blocks respectively. */
 	map.m_lblk = offset >> blkbits;
 	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
 			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	if (iomap_flags & IOMAP_WRITE) {
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
 
 	ext4_set_iomap(inode, iomap, &map, offset, length, iomap_flags);
+	if (delalloc)
+		iomap->flags |= IOMAP_F_EXT4_DELALLOC;
+
+	return 0;
+}
+
+static inline int ext4_iomap_buffered_io_begin(struct inode *inode,
+			loff_t offset, loff_t length, unsigned int flags,
+			struct iomap *iomap, struct iomap *srcmap)
+{
+	return __ext4_iomap_buffered_io_begin(inode, offset, length, flags,
+					      iomap, srcmap, false);
+}
+
+static inline int ext4_iomap_buffered_da_write_begin(struct inode *inode,
+			loff_t offset, loff_t length, unsigned int flags,
+			struct iomap *iomap, struct iomap *srcmap)
+{
+	return __ext4_iomap_buffered_io_begin(inode, offset, length, flags,
+					      iomap, srcmap, true);
+}
+
+/*
+ * Drop the staled delayed allocation range from the write failure,
+ * including both start and end blocks. If not, we could leave a range
+ * of delayed extents covered by a clean folio, it could lead to
+ * inaccurate space reservation.
+ */
+static int ext4_iomap_punch_delalloc(struct inode *inode, loff_t offset,
+				     loff_t length)
+{
+	ext4_es_remove_extent(inode, offset >> inode->i_blkbits,
+			DIV_ROUND_UP_ULL(length, EXT4_BLOCK_SIZE(inode->i_sb)));
 	return 0;
 }
 
+static int ext4_iomap_buffered_write_end(struct inode *inode, loff_t offset,
+					 loff_t length, ssize_t written,
+					 unsigned int flags,
+					 struct iomap *iomap)
+{
+	handle_t *handle;
+	loff_t end;
+	int ret = 0, ret2;
+
+	/* delalloc */
+	if (iomap->flags & IOMAP_F_EXT4_DELALLOC) {
+		ret = iomap_file_buffered_write_punch_delalloc(inode, iomap,
+			offset, length, written, ext4_iomap_punch_delalloc);
+		if (ret)
+			ext4_warning(inode->i_sb,
+			     "Failed to clean up delalloc for inode %lu, %d",
+			     inode->i_ino, ret);
+		return ret;
+	}
+
+	/* nodelalloc */
+	end = offset + length;
+	if (!(iomap->flags & IOMAP_F_SIZE_CHANGED) && end <= inode->i_size)
+		return 0;
+
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	if (iomap->flags & IOMAP_F_SIZE_CHANGED) {
+		ext4_update_i_disksize(inode, inode->i_size);
+		ret = ext4_mark_inode_dirty(handle, inode);
+	}
+
+	/*
+	 * If we have allocated more blocks and copied less.
+	 * We will have blocks allocated outside inode->i_size,
+	 * so truncate them.
+	 */
+	if (end > inode->i_size)
+		ext4_orphan_add(handle, inode);
+
+	ret2 = ext4_journal_stop(handle);
+	ret = ret ? : ret2;
+
+	if (end > inode->i_size) {
+		ext4_truncate_failed_write(inode);
+		/*
+		 * If truncate failed early the inode might still be
+		 * on the orphan list; we need to make sure the inode
+		 * is removed from the orphan list in that case.
+		 */
+		if (inode->i_nlink)
+			ext4_orphan_del(NULL, inode);
+	}
+
+	return ret;
+}
+
+
+const struct iomap_ops ext4_iomap_buffered_write_ops = {
+	.iomap_begin = ext4_iomap_buffered_io_begin,
+	.iomap_end = ext4_iomap_buffered_write_end,
+};
+
+const struct iomap_ops ext4_iomap_buffered_da_write_ops = {
+	.iomap_begin = ext4_iomap_buffered_da_write_begin,
+	.iomap_end = ext4_iomap_buffered_write_end,
+};
+
 const struct iomap_ops ext4_iomap_buffered_read_ops = {
 	.iomap_begin = ext4_iomap_buffered_io_begin,
 };
-- 
2.39.2


