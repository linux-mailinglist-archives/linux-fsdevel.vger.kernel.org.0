Return-Path: <linux-fsdevel+bounces-3534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055B7F5F85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 13:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACDAB217A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E99F2FC41;
	Thu, 23 Nov 2023 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C57AD53;
	Thu, 23 Nov 2023 04:52:07 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SbdKr5ZNzz4f3m74;
	Thu, 23 Nov 2023 20:52:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 139B61A0724;
	Thu, 23 Nov 2023 20:52:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xHdSl9lSfnfBg--.20473S17;
	Thu, 23 Nov 2023 20:52:04 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH 13/18] ext4: impliment writeback iomap path
Date: Thu, 23 Nov 2023 20:51:15 +0800
Message-Id: <20231123125121.4064694-14-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
References: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xHdSl9lSfnfBg--.20473S17
X-Coremail-Antispam: 1UD129KBjvAXoWfJFykuF18Xw1UGFy3Cr4xXrb_yoW8XrWUGo
	WftF45XF48Jryaq3yfCr1ftFyUuan7Ga18Jr1rZrZYqa4ayF15Zw43Gw43X3WxXw4Fkryx
	ArWxGF4rGr48A3Wrn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO07AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU
	OBTYUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Impliment writeback iomap path and journal write data path in
data=order mode, includes .map_blocks() and .prepare_ioend() callbacks
in iomap_writeback_ops, most of them are inherited from
ext4_writepages() and ext4_normal_submit_inode_data_buffers(), modify
and reuse mpage_map_one_extent() to save some codes. At the same time,
we are not able to switch buffered IO to iomap at onece, so introduce a
flag EXT4_STATE_BUFFERED_IOMAP to indicate one inode use traditional
buffered_head path or iomap path.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |   5 +
 fs/ext4/inode.c   | 262 +++++++++++++++++++++++++++++++++++++++++-----
 fs/ext4/page-io.c |  74 +++++++++++++
 fs/ext4/super.c   |   2 +
 4 files changed, 318 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b5026090ad6f..65373d53ba6a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1136,6 +1136,8 @@ struct ext4_inode_info {
 	 */
 	struct list_head i_rsv_conversion_list;
 	struct work_struct i_rsv_conversion_work;
+	struct list_head i_iomap_ioend_list;
+	struct work_struct i_iomap_ioend_work;
 	atomic_t i_unwritten; /* Nr. of inflight conversions pending */
 
 	spinlock_t i_block_reservation_lock;
@@ -1900,6 +1902,7 @@ enum {
 	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	EXT4_STATE_FC_COMMITTING,	/* Fast commit ongoing */
 	EXT4_STATE_ORPHAN_FILE,		/* Inode orphaned in orphan file */
+	EXT4_STATE_BUFFERED_IOMAP,	/* Inode use iomap for buffered IO */
 };
 
 #define EXT4_INODE_BIT_FNS(name, field, offset)				\
@@ -3743,6 +3746,8 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *page,
 		size_t len);
 extern struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end);
 extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
+extern void ext4_iomap_end_io(struct work_struct *work);
+extern void ext4_iomap_end_bio(struct bio *bio);
 
 /* mmp.c */
 extern int ext4_multi_mount_protect(struct super_block *, ext4_fsblk_t);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9229297e1efc..f72864b9a6b3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -43,6 +43,7 @@
 #include <linux/iversion.h>
 
 #include "ext4_jbd2.h"
+#include "ext4_extents.h"
 #include "xattr.h"
 #include "acl.h"
 #include "truncate.h"
@@ -2172,10 +2173,10 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
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
 
@@ -2207,13 +2208,13 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
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
@@ -2257,7 +2258,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 		return PTR_ERR(io_end_vec);
 	io_end_vec->offset = ((loff_t)map->m_lblk) << inode->i_blkbits;
 	do {
-		err = mpage_map_one_extent(handle, mpd);
+		err = mpage_map_one_extent(handle, inode, map, &mpd->io_submit);
 		if (err < 0) {
 			struct super_block *sb = inode->i_sb;
 
@@ -2822,22 +2823,6 @@ static int ext4_writepages(struct address_space *mapping,
 	return ret;
 }
 
-int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode)
-{
-	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_ALL,
-		.nr_to_write = LONG_MAX,
-		.range_start = jinode->i_dirty_start,
-		.range_end = jinode->i_dirty_end,
-	};
-	struct mpage_da_data mpd = {
-		.inode = jinode->i_vfs_inode,
-		.wbc = &wbc,
-		.can_map = 0,
-	};
-	return ext4_do_writepages(&mpd);
-}
-
 static int ext4_dax_writepages(struct address_space *mapping,
 			       struct writeback_control *wbc)
 {
@@ -3773,10 +3758,237 @@ static void ext4_iomap_readahead(struct readahead_control *rac)
 	iomap_readahead(rac, &ext4_iomap_read_ops);
 }
 
+struct ext4_writeback_ctx {
+	struct iomap_writepage_ctx ctx;
+	struct writeback_control *wbc;
+	unsigned int can_map:1;	/* Can writepages call map blocks? */
+};
+
+static int ext4_iomap_map_blocks(struct iomap_writepage_ctx *wpc,
+				 struct inode *inode, loff_t offset)
+{
+	struct ext4_writeback_ctx *ewpc =
+			container_of(wpc, struct ext4_writeback_ctx, ctx);
+	struct super_block *sb = inode->i_sb;
+	struct journal_s *journal = EXT4_SB(sb)->s_journal;
+	int needed_blocks;
+	struct ext4_map_blocks map;
+	handle_t *handle = NULL;
+	unsigned int blkbits = inode->i_blkbits;
+	unsigned int index = offset >> blkbits;
+	unsigned int end = ewpc->wbc->range_end >> blkbits;
+	unsigned int len = end - index + 1 ? : UINT_MAX;
+	loff_t new_disksize;
+	bool allocated = false;
+	int ret = 0;
+
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
+	/* Check validity of the cached writeback mapping. */
+	if (offset >= wpc->iomap.offset &&
+	    offset < wpc->iomap.offset + wpc->iomap.length)
+		return 0;
+
+	needed_blocks = ext4_da_writepages_trans_blocks(inode);
+
+retry:
+	map.m_lblk = index;
+	map.m_len = min_t(unsigned int, EXT_UNWRITTEN_MAX_LEN, len);
+	ret = ext4_map_blocks(NULL, inode, &map, 0);
+	if (ret < 0)
+		return ret;
+	ret = 0;
+
+	if (!ewpc->can_map &&
+	    (map.m_len == 0 || map.m_flags != EXT4_MAP_MAPPED)) {
+		/*
+		 * We cannot reach here when we do a journal commit via
+		 * journal_submit_data_buffers(), we must write mapped
+		 * blocks to achieve data=ordered mode guarantees.
+		 */
+		WARN_ON_ONCE(1);
+		return -EIO;
+	}
+
+	allocated = (map.m_flags & EXT4_MAP_MAPPED) ||
+		    ((map.m_flags & EXT4_MAP_UNWRITTEN) &&
+				ext4_should_dioread_nolock(inode));
+	if (allocated) {
+		new_disksize = offset + (map.m_len << blkbits);
+		if (new_disksize <= READ_ONCE(EXT4_I(inode)->i_disksize))
+			goto out;
+	}
+
+	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, needed_blocks);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		return ret;
+	}
+
+	if (!allocated) {
+		ret = mpage_map_one_extent(handle, inode, &map, NULL);
+		if (ret < 0) {
+			if (ext4_forced_shutdown(sb))
+				goto out_journal;
+
+			/*
+			 * Retry transient ENOSPC errors, if
+			 * ext4_count_free_blocks() is non-zero, a commit
+			 * should free up blocks.
+			 */
+			if (ret == -ENOSPC && ext4_count_free_clusters(sb)) {
+				ext4_journal_stop(handle);
+				jbd2_journal_force_commit_nested(journal);
+				goto retry;
+			}
+
+			ext4_msg(sb, KERN_CRIT,
+				 "Delayed block allocation failed for "
+				 "inode %lu at logical offset %llu with "
+				 "max blocks %u with error %d",
+				 inode->i_ino, (unsigned long long)map.m_lblk,
+				 (unsigned int)map.m_len, -ret);
+			ext4_msg(sb, KERN_CRIT,
+				 "This should not happen!! Data will "
+				 "be lost\n");
+			if (ret == -ENOSPC)
+				ext4_print_free_blocks(inode);
+			goto out_journal;
+		}
+	}
+
+	/*
+	 * Update on-disk size after IO is submitted.  Races with
+	 * truncate are avoided by checking i_size under i_data_sem.
+	 */
+	new_disksize = offset + (map.m_len << blkbits);
+	if (new_disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
+		loff_t i_size;
+
+		down_write(&EXT4_I(inode)->i_data_sem);
+		i_size = i_size_read(inode);
+		if (new_disksize > i_size)
+			new_disksize = i_size;
+		if (new_disksize > EXT4_I(inode)->i_disksize)
+			EXT4_I(inode)->i_disksize = new_disksize;
+		up_write(&EXT4_I(inode)->i_data_sem);
+		ret = ext4_mark_inode_dirty(handle, inode);
+		if (ret)
+			EXT4_ERROR_INODE_ERR(inode, -ret,
+					     "Failed to mark inode dirty");
+	}
+out_journal:
+	ext4_journal_stop(handle);
+out:
+	if (!ret)
+		ext4_set_iomap(inode, &wpc->iomap, &map, offset,
+			       map.m_len << blkbits, 0);
+	return 0;
+}
+
+static int ext4_iomap_prepare_ioend(struct iomap_ioend *ioend, int status)
+{
+	handle_t *handle = NULL;
+	struct inode *inode = ioend->io_inode;
+	int rsv_blocks;
+	int ret;
+
+	if (ioend->io_type != IOMAP_UNWRITTEN)
+		return status;
+
+	ioend->io_bio->bi_end_io = ext4_iomap_end_bio;
+
+	/*
+	 * Reserve enough transaction credits for unwritten extent
+	 * convert processing in end IO.
+	 */
+	rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
+				ioend->io_size >> inode->i_blkbits);
+	handle = ext4_journal_start_with_reserve(inode,
+				EXT4_HT_WRITE_PAGE, 0, rsv_blocks);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		ext4_msg(inode->i_sb, KERN_CRIT,
+			 "%s: jbd2_start: %ld blocks, ino %lu; err %d\n",
+			 __func__, ioend->io_size >> inode->i_blkbits,
+			 inode->i_ino, ret);
+		return status ? status : ret;
+	}
+	if (ext4_handle_valid(handle)) {
+		ioend->io_private = handle->h_rsv_handle;
+		handle->h_rsv_handle = NULL;
+	}
+	ext4_journal_stop(handle);
+
+	return status;
+}
+
+static const struct iomap_writeback_ops ext4_iomap_writeback_ops = {
+	.map_blocks = ext4_iomap_map_blocks,
+	.prepare_ioend = ext4_iomap_prepare_ioend,
+};
+
+static int ext4_iomap_do_writepages(struct address_space *mapping,
+				    struct writeback_control *wbc,
+				    struct ext4_writeback_ctx *ewpc)
+{
+	struct inode *inode = mapping->host;
+	long nr_to_write = wbc->nr_to_write;
+	int ret;
+
+	trace_ext4_writepages(inode, wbc);
+	ret = iomap_writepages(mapping, wbc, &ewpc->ctx,
+			       &ext4_iomap_writeback_ops);
+	trace_ext4_writepages_result(inode, wbc, ret,
+				     nr_to_write - wbc->nr_to_write);
+	return ret;
+}
+
 static int ext4_iomap_writepages(struct address_space *mapping,
 				 struct writeback_control *wbc)
 {
-	return 0;
+	struct ext4_writeback_ctx ewpc = {
+		.wbc = wbc,
+		.can_map = 1,
+	};
+	struct super_block *sb = mapping->host->i_sb;
+	int alloc_ctx, ret;
+
+	if (unlikely(ext4_forced_shutdown(sb)))
+		return -EIO;
+
+	alloc_ctx = ext4_writepages_down_read(sb);
+	ret = ext4_iomap_do_writepages(mapping, wbc, &ewpc);
+	ext4_writepages_up_read(sb, alloc_ctx);
+
+	return ret;
+}
+
+int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode)
+{
+	struct inode *inode = jinode->i_vfs_inode;
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL,
+		.nr_to_write = LONG_MAX,
+		.range_start = jinode->i_dirty_start,
+		.range_end = jinode->i_dirty_end,
+	};
+	struct mpage_da_data mpd = {
+		.inode = inode,
+		.wbc = &wbc,
+		.can_map = 0,
+	};
+	struct ext4_writeback_ctx ewpc = {
+		.wbc = &wbc,
+		.can_map = 0,
+	};
+
+	if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP))
+		return ext4_iomap_do_writepages(jinode->i_vfs_inode->i_mapping,
+						&wbc, &ewpc);
+
+	return ext4_do_writepages(&mpd);
 }
 
 /*
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index dfdd7e5cf038..f817fcf8df99 100644
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
@@ -565,3 +566,76 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 
 	return 0;
 }
+
+static int ext4_iomap_convert_unwritten_io_end(struct iomap_ioend *ioend)
+{
+	handle_t *handle = ioend->io_private;
+	struct inode *inode = ioend->io_inode;
+	int ret, err;
+
+	if (handle) {
+		handle = ext4_journal_start_reserved(handle,
+						     EXT4_HT_EXT_CONVERT);
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out;
+		}
+	}
+
+	ret = ext4_convert_unwritten_extents(handle, ioend->io_inode,
+					     ioend->io_offset, ioend->io_size);
+	if (handle) {
+		err = ext4_journal_stop(handle);
+		if (!ret)
+			ret = err;
+	}
+out:
+	if (ret < 0 && !ext4_forced_shutdown(inode->i_sb)) {
+		ext4_msg(inode->i_sb, KERN_EMERG,
+			 "failed to convert unwritten extents to "
+			 "written extents -- potential data loss!  "
+			 "(inode %lu, error %d)", inode->i_ino, ret);
+	}
+	iomap_finish_ioends(ioend, ret);
+	return ret;
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
+	while (!list_empty(&ioend_list)) {
+		ioend = list_entry(ioend_list.next, struct iomap_ioend, io_list);
+		BUG_ON(ioend->io_type != IOMAP_UNWRITTEN);
+		list_del_init(&ioend->io_list);
+		ext4_iomap_convert_unwritten_io_end(ioend);
+	}
+}
+
+void ext4_iomap_end_bio(struct bio *bio)
+{
+	struct iomap_ioend *ioend = bio->bi_private;
+	struct ext4_inode_info *ei = EXT4_I(ioend->io_inode);
+	struct ext4_sb_info *sbi = EXT4_SB(ioend->io_inode->i_sb);
+	unsigned long flags;
+
+	/* Only reserved conversions from writeback should enter here */
+	WARN_ON(ioend->io_type != IOMAP_UNWRITTEN);
+	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
+	if (list_empty(&ei->i_iomap_ioend_list))
+		queue_work(sbi->rsv_conversion_wq, &ei->i_iomap_ioend_work);
+	list_add_tail(&ioend->io_list, &ei->i_iomap_ioend_list);
+	spin_unlock_irqrestore(&ei->i_completed_io_lock, flags);
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dbebd8b3127e..08a39f364d78 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1422,11 +1422,13 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
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


