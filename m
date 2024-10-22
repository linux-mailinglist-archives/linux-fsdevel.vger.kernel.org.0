Return-Path: <linux-fsdevel+bounces-32566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A882D9A96CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DEC286446
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3BA1F9A90;
	Tue, 22 Oct 2024 03:13:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FAF14AD02;
	Tue, 22 Oct 2024 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566786; cv=none; b=FaRq/XgTfj1wmQOXL3AfKro8N1gvYGLt2gSozswQnFYxcOgYgvJxilELrLTKR7aWv/EFm6hrcujROGFPw7cRoZRqfAM7kgZ6CaPvwIw3qH1m7NgYDPfuKUnq8sagW9pdd4e1EyvT4QM6DH3sV7DQXA1tjA8EWJsz9Rgwd0aAynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566786; c=relaxed/simple;
	bh=4wNxr6z3hjdV+Va2/DAKywfCxx5XItXDt3rDGOdQbBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGXW4ccsm3uTUEbhkXX2slLh9If6BTMXCsosDgOUvHaJc6YPWjaN7FAEnGXAEMUzL+qV+6ZkHszgOmjC2Cf4igGResrj2Esaap9PuAGHhIqxJKH22YjsUDBg7d+0FNFGd5smRrIAXrzVCd3TXKeeyjgekrxaA2jyeJhhvpHieAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcgM5bWvz4f3jkm;
	Tue, 22 Oct 2024 11:12:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0C73F1A0568;
	Tue, 22 Oct 2024 11:13:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S21;
	Tue, 22 Oct 2024 11:12:59 +0800 (CST)
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
Subject: [PATCH 17/27] ext4: implement writeback iomap path
Date: Tue, 22 Oct 2024 19:10:48 +0800
Message-ID: <20241022111059.2566137-18-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S21
X-Coremail-Antispam: 1UD129KBjvAXoWfGFyruFW3Cry8JFy5ZF43Jrb_yoW8Xw4DCo
	WSva13XF48Jr98ta9Ykr1fJFyUuan7Ga1rAF15Zr40qa43JF1a9w4xGw43X3W7Ww4Fkryx
	ZryxJa15Gr4kJF4rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOH7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82xGYIkIc2
	x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Y
	j41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwV
	C0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
	wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
	xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_
	Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
	IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRtl1hUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Implement ext4_iomap_writepages(), introduce ext4_writeback_ops, and
create an end I/O extent conversion worker to implement the iomap
buffered write-back path. In the map_blocks() handler, we first query
the longest range of existing mapped extents. If the block range has not
already been allocated, we attempt to allocate a range of blocks that is
as long as possible to minimize the number of block mappings. This
allocation is based on the write-back length and the delalloc extent
length, rather than allocating for a single folio at a time. In the
->prepare_ioend() handler, we register the end I/O worker to convert
unwritten extents into written extents.

There are three key differences between the buffer_head write-back path
and the iomap write-back path:

1) Since we aim to allocate a range of blocks as long as possible within
   the writeback length for each invocation of ->map_blocks(), we may
   allocate a long range but write less in certain corner cases.
   Therefore, we cannot convert the extent to written in advance within
   ->map_blocks(). Fortunately, there is minimal risk of losing data
   between split extents during the write-back and the end I/O process.
   We defer this action to the end I/O worker, where we can accurately
   determine the actual written length. Besides, we should remove the
   warning in ext4_convert_unwritten_extents_endio().
2) Since we do not order data, the journal thread is not required to
   write back data. Besides, we also do not need to use the reserve
   handle when converting the unwritten extent in the end I/O worker, we
   can start normal handle directly.
3) We can also delay updating the i_disksize until the end of the I/O,
   which could prevent the exposure of zero data that may occur during a
   system crash while performing buffer append writes in the buffer_head
   buffered write path.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |   4 +
 fs/ext4/extents.c |  22 +++---
 fs/ext4/inode.c   | 188 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/page-io.c | 105 ++++++++++++++++++++++++++
 fs/ext4/super.c   |   2 +
 5 files changed, 311 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a09f96ef17d8..d4d594d97634 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1151,6 +1151,8 @@ struct ext4_inode_info {
 	 */
 	struct list_head i_rsv_conversion_list;
 	struct work_struct i_rsv_conversion_work;
+	struct list_head i_iomap_ioend_list;
+	struct work_struct i_iomap_ioend_work;
 
 	spinlock_t i_block_reservation_lock;
 
@@ -3773,6 +3775,8 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *page,
 		size_t len);
 extern struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end);
 extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
+extern void ext4_iomap_end_io(struct work_struct *work);
+extern void ext4_iomap_end_bio(struct bio *bio);
 
 /* mmp.c */
 extern int ext4_multi_mount_protect(struct super_block *, ext4_fsblk_t);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 33bc2cc5aff4..4b30e6f0a634 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3760,20 +3760,24 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)ee_block, ee_len);
 
-	/* If extent is larger than requested it is a clear sign that we still
-	 * have some extent state machine issues left. So extent_split is still
-	 * required.
-	 * TODO: Once all related issues will be fixed this situation should be
-	 * illegal.
+	/*
+	 * If the extent is larger than requested, we should split it here.
+	 * For inodes using the iomap buffered I/O path, we do not split in
+	 * advance during the write-back process. Therefore, we may need to
+	 * perform the split during the end I/O process here. However,
+	 * other inodes should not require this action.
 	 */
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
 		int flags = EXT4_GET_BLOCKS_CONVERT |
 			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
 #ifdef CONFIG_EXT4_DEBUG
-		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
-			     " len %u; IO logical block %llu, len %u",
-			     inode->i_ino, (unsigned long long)ee_block, ee_len,
-			     (unsigned long long)map->m_lblk, map->m_len);
+		if (!ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)) {
+			ext4_warning(inode->i_sb,
+				     "Inode (%ld) finished: extent logical block %llu, len %u; IO logical block %llu, len %u",
+				     inode->i_ino, (unsigned long long)ee_block,
+				     ee_len, (unsigned long long)map->m_lblk,
+				     map->m_len);
+		}
 #endif
 		path = ext4_split_convert_extents(handle, inode, map, path,
 						  flags, NULL);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 23cbcaab0a56..a260942fd2dd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -44,6 +44,7 @@
 #include <linux/iversion.h>
 
 #include "ext4_jbd2.h"
+#include "ext4_extents.h"
 #include "xattr.h"
 #include "acl.h"
 #include "truncate.h"
@@ -3710,10 +3711,195 @@ static void ext4_iomap_readahead(struct readahead_control *rac)
 	iomap_readahead(rac, &ext4_iomap_buffered_read_ops);
 }
 
+struct ext4_writeback_ctx {
+	struct iomap_writepage_ctx ctx;
+	struct writeback_control *wbc;
+	unsigned int data_seq;
+};
+
+static int ext4_iomap_map_one_extent(struct inode *inode,
+				     struct ext4_map_blocks *map)
+{
+	struct extent_status es;
+	handle_t *handle = NULL;
+	int credits, map_flags;
+	int retval;
+
+	credits = ext4_da_writepages_trans_blocks(inode);
+	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, credits);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	map->m_flags = 0;
+	/*
+	 * It is necessary to look up extent and map blocks under i_data_sem
+	 * in write mode, otherwise, the delalloc extent may become stale
+	 * during concurrent truncate operations.
+	 */
+	down_write(&EXT4_I(inode)->i_data_sem);
+	if (likely(ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es))) {
+		retval = es.es_len - (map->m_lblk - es.es_lblk);
+		map->m_len = min_t(unsigned int, retval, map->m_len);
+
+		if (ext4_es_is_delayed(&es)) {
+			map->m_flags |= EXT4_MAP_DELAYED;
+			trace_ext4_da_write_pages_extent(inode, map);
+			/*
+			 * Call ext4_map_create_blocks() to allocate any
+			 * delayed allocation blocks. It is possible that
+			 * we're going to need more metadata blocks, however
+			 * we must not fail because we're in writeback and
+			 * there is nothing we can do so it might result in
+			 * data loss. So use reserved blocks to allocate
+			 * metadata if possible.
+			 */
+			map_flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT |
+				    EXT4_GET_BLOCKS_METADATA_NOFAIL;
+
+			retval = ext4_map_create_blocks(handle, inode, map,
+							map_flags);
+			goto out;
+		}
+		if (unlikely(ext4_es_is_hole(&es)))
+			goto out;
+
+		/* Found written or unwritten extent. */
+		map->m_pblk = ext4_es_pblock(&es) + map->m_lblk -
+			      es.es_lblk;
+		map->m_flags = ext4_es_is_written(&es) ?
+			       EXT4_MAP_MAPPED : EXT4_MAP_UNWRITTEN;
+		goto out;
+	}
+
+	retval = ext4_map_query_blocks(handle, inode, map);
+out:
+	up_write(&EXT4_I(inode)->i_data_sem);
+	ext4_journal_stop(handle);
+	return retval < 0 ? retval : 0;
+}
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
+	struct ext4_map_blocks map;
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
+	end = min_t(unsigned int, (ewpc->wbc->range_end >> blkbits),
+				  (UINT_MAX - 1));
+	len = (end > index + dirty_len) ? end - index + 1 : dirty_len;
+
+retry:
+	map.m_lblk = index;
+	map.m_len = min_t(unsigned int, MAX_WRITEPAGES_EXTENT_LEN, len);
+	ret = ext4_map_blocks(NULL, inode, &map, 0);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The map is not a delalloc extent, it must either be a hole
+	 * or an extent which have already been allocated.
+	 */
+	if (!(map.m_flags & EXT4_MAP_DELAYED))
+		goto out;
+
+	/* Map one delalloc extent. */
+	ret = ext4_iomap_map_one_extent(inode, &map);
+	if (ret < 0) {
+		if (ext4_forced_shutdown(sb))
+			return ret;
+
+		/*
+		 * Retry transient ENOSPC errors, if
+		 * ext4_count_free_blocks() is non-zero, a commit
+		 * should free up blocks.
+		 */
+		if (ret == -ENOSPC && journal && ext4_count_free_clusters(sb)) {
+			jbd2_journal_force_commit_nested(journal);
+			goto retry;
+		}
+
+		ext4_msg(sb, KERN_CRIT,
+			 "Delayed block allocation failed for inode %lu at logical offset %llu with max blocks %u with error %d",
+			 inode->i_ino, (unsigned long long)map.m_lblk,
+			 (unsigned int)map.m_len, -ret);
+		ext4_msg(sb, KERN_CRIT,
+			 "This should not happen!! Data will be lost\n");
+		if (ret == -ENOSPC)
+			ext4_print_free_blocks(inode);
+		return ret;
+	}
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
+	loff_t length = folio_pos(folio) + folio_size(folio) - pos;
+
+	ext4_iomap_punch_delalloc(inode, pos, length, NULL);
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
index ad5543866d21..659ee0fb7cea 100644
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
@@ -562,3 +563,107 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 
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
+			 "failed to convert unwritten extents to written extents or update inode size -- potential data loss! (inode %lu, error %d)",
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
index a01e0bbe57c8..56baadec27e0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1419,11 +1419,13 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
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
2.46.1


