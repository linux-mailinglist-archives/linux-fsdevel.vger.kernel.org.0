Return-Path: <linux-fsdevel+bounces-7108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A68821BF8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84951F24778
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D79156C3;
	Tue,  2 Jan 2024 12:42:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC014F83;
	Tue,  2 Jan 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4CD52s7dz4f3l8j;
	Tue,  2 Jan 2024 20:42:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1FD091A017F;
	Tue,  2 Jan 2024 20:42:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnwUGUBJRl+EvDFQ--.31823S22;
	Tue, 02 Jan 2024 20:42:14 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v2 18/25] ext4: implement writeback iomap path
Date: Tue,  2 Jan 2024 20:39:11 +0800
Message-Id: <20240102123918.799062-19-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnwUGUBJRl+EvDFQ--.31823S22
X-Coremail-Antispam: 1UD129KBjvAXoW3CF45CrWxCrW5XrW8Zr4rAFb_yoW8Wr1fZo
	WaqF45XF48Jr9xta9Ykr1ftFyUZanrGa1rJr1rZr4Fqa4ayr1avw43Gw43WFy7Ww4FkrWx
	AryxJF45Gr4kJF4rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO07AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU
	oxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Implement buffered writeback iomap path, include map_blocks() and
prepare_ioend() callbacks in iomap_writeback_ops and the corresponding
end io process. Add ext4_iomap_map_blocks() to query mapping status,
start journal handle and allocate new blocks if it's not allocated. Add
ext4_iomap_prepare_ioend() to register the end io handler of converting
unwritten extents to mapped extents.

In order to reduce the number of map times, we map an entire delayed
extent once a time, it means that we could map more blocks than we
expected, so we have to calculate the length through wbc->range_end
carefully. Besides, we won't be able to avoid splitting extents in
endio, so we would allow that because we have been using reserved blocks
in endio, it doesn't bring more risks of data loss than splitting before
submitting IO.

Since we always allocate unwritten extents and keep them until data have
been written to disk, we don't need to write back the data before the
metadata is updated to disk, there is no risk of exposing stale data, so
the data=ordered journal mode becomes useless. We don't need to attach
data to the jinode, and the journal thread won't have to write any
dependent data any more. In the meantime, we don't have to reserve
journal credits for the extent status conversion and we also could
postpone i_disksize updating into endio.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h      |   4 ++
 fs/ext4/ext4_jbd2.c |   6 ++
 fs/ext4/extents.c   |  23 ++++---
 fs/ext4/inode.c     | 156 +++++++++++++++++++++++++++++++++++++++++---
 fs/ext4/page-io.c   | 107 ++++++++++++++++++++++++++++++
 fs/ext4/super.c     |   2 +
 6 files changed, 280 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 03cdcf3d86a5..eaf29bade606 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1147,6 +1147,8 @@ struct ext4_inode_info {
 	 */
 	struct list_head i_rsv_conversion_list;
 	struct work_struct i_rsv_conversion_work;
+	struct list_head i_iomap_ioend_list;
+	struct work_struct i_iomap_ioend_work;
 	atomic_t i_unwritten; /* Nr. of inflight conversions pending */
 
 	spinlock_t i_block_reservation_lock;
@@ -3755,6 +3757,8 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *page,
 		size_t len);
 extern struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end);
 extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
+extern void ext4_iomap_end_io(struct work_struct *work);
+extern void ext4_iomap_end_bio(struct bio *bio);
 
 /* mmp.c */
 extern int ext4_multi_mount_protect(struct super_block *, ext4_fsblk_t);
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index d1a2e6624401..94c8073b49e7 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -11,6 +11,12 @@ int ext4_inode_journal_mode(struct inode *inode)
 {
 	if (EXT4_JOURNAL(inode) == NULL)
 		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
+	/*
+	 * Ordered mode is no longer needed for the inode that use the
+	 * iomap path, always use writeback mode.
+	 */
+	if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP))
+		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
 	/* We do not support data journalling with delayed allocation */
 	if (!S_ISREG(inode->i_mode) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 254f8b85653d..67ff75108cd1 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3708,18 +3708,23 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)ee_block, ee_len);
 
-	/* If extent is larger than requested it is a clear sign that we still
-	 * have some extent state machine issues left. So extent_split is still
-	 * required.
-	 * TODO: Once all related issues will be fixed this situation should be
-	 * illegal.
+	/*
+	 * For the inodes that use the buffered iomap path need to split
+	 * extents in endio, other inodes not.
+	 *
+	 * TODO: Reserve enough sapce for splitting extents, always split
+	 * extents here, and totally remove this warning.
 	 */
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
 #ifdef CONFIG_EXT4_DEBUG
-		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
-			     " len %u; IO logical block %llu, len %u",
-			     inode->i_ino, (unsigned long long)ee_block, ee_len,
-			     (unsigned long long)map->m_lblk, map->m_len);
+		if (!ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)) {
+			ext4_warning(inode->i_sb,
+				     "Inode (%ld) finished: extent logical block %llu, "
+				     "len %u; IO logical block %llu, len %u",
+				     inode->i_ino, (unsigned long long)ee_block,
+				     ee_len, (unsigned long long)map->m_lblk,
+				     map->m_len);
+		}
 #endif
 		err = ext4_split_convert_extents(handle, inode, map, ppath,
 					EXT4_GET_BLOCKS_CONVERT |
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5512f38a1a9d..c22b49521df2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -43,6 +43,7 @@
 #include <linux/iversion.h>
 
 #include "ext4_jbd2.h"
+#include "ext4_extents.h"
 #include "xattr.h"
 #include "acl.h"
 #include "truncate.h"
@@ -2139,10 +2140,10 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 	return err;
 }
 
-static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
+static int mpage_map_one_extent(handle_t *handle, struct inode *inode,
+				struct ext4_map_blocks *map,
+				struct ext4_io_submit *io)
 {
-	struct inode *inode = mpd->inode;
-	struct ext4_map_blocks *map = &mpd->map;
 	int get_blocks_flags;
 	int err, dioread_nolock;
 
@@ -2174,13 +2175,13 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
 	if (err < 0)
 		return err;
-	if (dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
-		if (!mpd->io_submit.io_end->handle &&
+	if (io && dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
+		if (!io->io_end->handle &&
 		    ext4_handle_valid(handle)) {
-			mpd->io_submit.io_end->handle = handle->h_rsv_handle;
+			io->io_end->handle = handle->h_rsv_handle;
 			handle->h_rsv_handle = NULL;
 		}
-		ext4_set_io_unwritten_flag(inode, mpd->io_submit.io_end);
+		ext4_set_io_unwritten_flag(inode, io->io_end);
 	}
 
 	BUG_ON(map->m_len == 0);
@@ -2224,7 +2225,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 		return PTR_ERR(io_end_vec);
 	io_end_vec->offset = ((loff_t)map->m_lblk) << inode->i_blkbits;
 	do {
-		err = mpage_map_one_extent(handle, mpd);
+		err = mpage_map_one_extent(handle, inode, map, &mpd->io_submit);
 		if (err < 0) {
 			struct super_block *sb = inode->i_sb;
 
@@ -3690,10 +3691,147 @@ static void ext4_iomap_readahead(struct readahead_control *rac)
 	iomap_readahead(rac, &ext4_iomap_buffered_read_ops);
 }
 
+struct ext4_writeback_ctx {
+	struct iomap_writepage_ctx ctx;
+	struct writeback_control *wbc;
+	unsigned int data_seq;
+};
+
+static int ext4_iomap_map_blocks(struct iomap_writepage_ctx *wpc,
+				 struct inode *inode, loff_t offset,
+				 unsigned int dirty_len)
+{
+	struct ext4_writeback_ctx *ewpc =
+			container_of(wpc, struct ext4_writeback_ctx, ctx);
+	struct super_block *sb = inode->i_sb;
+	struct journal_s *journal = EXT4_SB(sb)->s_journal;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	int needed_blocks;
+	struct ext4_map_blocks map;
+	handle_t *handle = NULL;
+	unsigned int blkbits = inode->i_blkbits;
+	unsigned int index = offset >> blkbits;
+	unsigned int end, len;
+	int ret;
+
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
+	/* Check validity of the cached writeback mapping. */
+	if (offset >= wpc->iomap.offset &&
+	    offset < wpc->iomap.offset + wpc->iomap.length &&
+	    ewpc->data_seq == READ_ONCE(ei->i_es_seq))
+		return 0;
+
+	needed_blocks = ext4_da_writepages_trans_blocks(inode);
+	end = min_t(unsigned int,
+		    (ewpc->wbc->range_end >> blkbits), (UINT_MAX - 1));
+	len = (end > index + dirty_len) ? end - index + 1 : dirty_len;
+
+retry:
+	map.m_lblk = index;
+	map.m_len = min_t(unsigned int, EXT_UNWRITTEN_MAX_LEN, len);
+	ret = ext4_map_blocks(NULL, inode, &map, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Already allocated. */
+	if (map.m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN))
+		goto out;
+
+	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, needed_blocks);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		return ret;
+	}
+
+	ret = mpage_map_one_extent(handle, inode, &map, NULL);
+	if (ret < 0) {
+		if (ext4_forced_shutdown(sb))
+			goto out_journal;
+
+		/*
+		 * Retry transient ENOSPC errors, if
+		 * ext4_count_free_blocks() is non-zero, a commit
+		 * should free up blocks.
+		 */
+		if (ret == -ENOSPC && ext4_count_free_clusters(sb)) {
+			ext4_journal_stop(handle);
+			jbd2_journal_force_commit_nested(journal);
+			goto retry;
+		}
+
+		ext4_msg(sb, KERN_CRIT,
+			 "Delayed block allocation failed for "
+			 "inode %lu at logical offset %llu with "
+			 "max blocks %u with error %d",
+			 inode->i_ino, (unsigned long long)map.m_lblk,
+			 (unsigned int)map.m_len, -ret);
+		ext4_msg(sb, KERN_CRIT,
+			 "This should not happen!! Data will "
+			 "be lost\n");
+		if (ret == -ENOSPC)
+			ext4_print_free_blocks(inode);
+out_journal:
+		ext4_journal_stop(handle);
+		return ret;
+	}
+
+	ext4_journal_stop(handle);
+out:
+	ewpc->data_seq = READ_ONCE(ei->i_es_seq);
+	ext4_set_iomap(inode, &wpc->iomap, &map, offset,
+		       map.m_len << blkbits, 0);
+	return 0;
+}
+
+static int ext4_iomap_prepare_ioend(struct iomap_ioend *ioend, int status)
+{
+	struct ext4_inode_info *ei = EXT4_I(ioend->io_inode);
+
+	/* Need to convert unwritten extents when I/Os are completed. */
+	if (ioend->io_type == IOMAP_UNWRITTEN ||
+	    ioend->io_offset + ioend->io_size > READ_ONCE(ei->i_disksize))
+		ioend->io_bio.bi_end_io = ext4_iomap_end_bio;
+
+	return status;
+}
+
+static void ext4_iomap_discard_folio(struct folio *folio, loff_t pos)
+{
+	struct inode *inode = folio->mapping->host;
+
+	ext4_iomap_punch_delalloc(inode, pos,
+				  folio_pos(folio) + folio_size(folio) - pos);
+}
+
+static const struct iomap_writeback_ops ext4_writeback_ops = {
+	.map_blocks = ext4_iomap_map_blocks,
+	.prepare_ioend = ext4_iomap_prepare_ioend,
+	.discard_folio = ext4_iomap_discard_folio,
+};
+
 static int ext4_iomap_writepages(struct address_space *mapping,
 				 struct writeback_control *wbc)
 {
-	return 0;
+	struct inode *inode = mapping->host;
+	struct super_block *sb = inode->i_sb;
+	long nr = wbc->nr_to_write;
+	int alloc_ctx, ret;
+	struct ext4_writeback_ctx ewpc = {
+		.wbc = wbc,
+	};
+
+	if (unlikely(ext4_forced_shutdown(sb)))
+		return -EIO;
+
+	alloc_ctx = ext4_writepages_down_read(sb);
+	trace_ext4_writepages(inode, wbc);
+	ret = iomap_writepages(mapping, wbc, &ewpc.ctx, &ext4_writeback_ops);
+	trace_ext4_writepages_result(inode, wbc, ret, nr - wbc->nr_to_write);
+	ext4_writepages_up_read(sb, alloc_ctx);
+
+	return ret;
 }
 
 /*
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index dfdd7e5cf038..a499208500e4 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -22,6 +22,7 @@
 #include <linux/bio.h>
 #include <linux/workqueue.h>
 #include <linux/kernel.h>
+#include <linux/iomap.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
@@ -565,3 +566,109 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 
 	return 0;
 }
+
+static void ext4_iomap_finish_ioend(struct iomap_ioend *ioend)
+{
+	struct inode *inode = ioend->io_inode;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	loff_t pos = ioend->io_offset;
+	size_t size = ioend->io_size;
+	loff_t new_disksize;
+	handle_t *handle;
+	int credits;
+	int ret, err;
+
+	ret = blk_status_to_errno(ioend->io_bio.bi_status);
+	if (unlikely(ret))
+		goto out;
+
+	/*
+	 * We may need to convert up to one extent per block in
+	 * the page and we may dirty the inode.
+	 */
+	credits = ext4_chunk_trans_blocks(inode,
+			EXT4_MAX_BLOCKS(size, pos, inode->i_blkbits));
+	handle = ext4_journal_start(inode, EXT4_HT_EXT_CONVERT, credits);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto out_err;
+	}
+
+	if (ioend->io_type == IOMAP_UNWRITTEN) {
+		ret = ext4_convert_unwritten_extents(handle, inode, pos, size);
+		if (ret)
+			goto out_journal;
+	}
+
+	/*
+	 * Update on-disk size after IO is completed. Races with
+	 * truncate are avoided by checking i_size under i_data_sem.
+	 */
+	new_disksize = pos + size;
+	if (new_disksize > READ_ONCE(ei->i_disksize)) {
+		down_write(&ei->i_data_sem);
+		new_disksize = min(new_disksize, i_size_read(inode));
+		if (new_disksize > ei->i_disksize)
+			ei->i_disksize = new_disksize;
+		up_write(&ei->i_data_sem);
+		ret = ext4_mark_inode_dirty(handle, inode);
+		if (ret)
+			EXT4_ERROR_INODE_ERR(inode, -ret,
+					     "Failed to mark inode dirty");
+	}
+
+out_journal:
+	err = ext4_journal_stop(handle);
+	if (!ret)
+		ret = err;
+out_err:
+	if (ret < 0 && !ext4_forced_shutdown(inode->i_sb)) {
+		ext4_msg(inode->i_sb, KERN_EMERG,
+			 "failed to convert unwritten extents to "
+			 "written extents or update inode size -- "
+			 "potential data loss! (inode %lu, error %d)",
+			 inode->i_ino, ret);
+	}
+out:
+	iomap_finish_ioends(ioend, ret);
+}
+
+/*
+ * Work on buffered iomap completed IO, to convert unwritten extents to
+ * mapped extents
+ */
+void ext4_iomap_end_io(struct work_struct *work)
+{
+	struct ext4_inode_info *ei = container_of(work, struct ext4_inode_info,
+						  i_iomap_ioend_work);
+	struct iomap_ioend *ioend;
+	struct list_head ioend_list;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
+	list_replace_init(&ei->i_iomap_ioend_list, &ioend_list);
+	spin_unlock_irqrestore(&ei->i_completed_io_lock, flags);
+
+	iomap_sort_ioends(&ioend_list);
+	while (!list_empty(&ioend_list)) {
+		ioend = list_entry(ioend_list.next, struct iomap_ioend, io_list);
+		list_del_init(&ioend->io_list);
+		iomap_ioend_try_merge(ioend, &ioend_list);
+		ext4_iomap_finish_ioend(ioend);
+	}
+}
+
+void ext4_iomap_end_bio(struct bio *bio)
+{
+	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
+	struct ext4_inode_info *ei = EXT4_I(ioend->io_inode);
+	struct ext4_sb_info *sbi = EXT4_SB(ioend->io_inode->i_sb);
+	unsigned long flags;
+
+	/* Only reserved conversions from writeback should enter here */
+	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
+	if (list_empty(&ei->i_iomap_ioend_list))
+		queue_work(sbi->rsv_conversion_wq, &ei->i_iomap_ioend_work);
+	list_add_tail(&ioend->io_list, &ei->i_iomap_ioend_list);
+	spin_unlock_irqrestore(&ei->i_completed_io_lock, flags);
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d4afaae8ab38..811a46f83bb9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1431,11 +1431,13 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 #endif
 	ei->jinode = NULL;
 	INIT_LIST_HEAD(&ei->i_rsv_conversion_list);
+	INIT_LIST_HEAD(&ei->i_iomap_ioend_list);
 	spin_lock_init(&ei->i_completed_io_lock);
 	ei->i_sync_tid = 0;
 	ei->i_datasync_tid = 0;
 	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
+	INIT_WORK(&ei->i_iomap_ioend_work, ext4_iomap_end_io);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	mutex_init(&ei->i_fc_lock);
 	return &ei->vfs_inode;
-- 
2.39.2


