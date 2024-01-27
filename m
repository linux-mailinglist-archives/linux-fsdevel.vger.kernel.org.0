Return-Path: <linux-fsdevel+bounces-9172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9498183E974
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D581C23ED0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034752D05D;
	Sat, 27 Jan 2024 02:02:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97628DB5;
	Sat, 27 Jan 2024 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320977; cv=none; b=b3n5dyqkUiVwVWcFBCOQA7dDJUTyLwT84qLXK5tMtB0G64wLpJxndR6oMMYaCuJhOjc3Z6fNfdfeV7Qnxq5eqSMUNM6OMxo1KPGXx8BsnLHSVIi9gU73oblLI6NzRufIAcTHL8GrY9AoDaBn8J5y+LUuAuz0xKYL/Su2xlM3RhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320977; c=relaxed/simple;
	bh=ZQs/pUU050ayJ0zJQou8RKPWpvmxPSbPUb/yTH0mT9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZjjnEDaO73/hIMfdRcmgqvJdD/UqDT6+RFwYZ+7R6B+W/yCwBkY1fKVGSWkC46TJUAyleOy6/tsfaQriH6VL34sjbyLuPg9eOIwjwVlJi0L4D5ispiyN4nD60H8fnzieVuBUA9+XyFKyVPXfH0di0jJW+G5Fg86EEdrYqafHOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TMHrj4Xrpz4f3lg5;
	Sat, 27 Jan 2024 10:02:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 008D91A01E9;
	Sat, 27 Jan 2024 10:02:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g40ZLRlGJtmCA--.7377S23;
	Sat, 27 Jan 2024 10:02:51 +0800 (CST)
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
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v3 19/26] ext4: implement writeback iomap path
Date: Sat, 27 Jan 2024 09:58:18 +0800
Message-Id: <20240127015825.1608160-20-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g40ZLRlGJtmCA--.7377S23
X-Coremail-Antispam: 1UD129KBjvAXoW3CF45CrWxCrW5XrW8Zr4rAFb_yoW8Wr4kWo
	WavF43Xr48Jr98tayFkr1xJFyUuan7Ga1rJF15Zr40qa43AF1Y9w4xKw43Wa43Ww4Fkr4x
	ZryxJF45Gr4kXF4rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO07AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
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
 fs/ext4/ext4.h      |   4 +
 fs/ext4/ext4_jbd2.c |   6 ++
 fs/ext4/extents.c   |  23 +++---
 fs/ext4/inode.c     | 190 +++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/page-io.c   | 107 +++++++++++++++++++++++++
 fs/ext4/super.c     |   2 +
 6 files changed, 322 insertions(+), 10 deletions(-)

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
index 48d6d125ec37..46805b8e7bdc 100644
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
index c48aca637896..8ee0eca6a1e8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -43,6 +43,7 @@
 #include <linux/iversion.h>
 
 #include "ext4_jbd2.h"
+#include "ext4_extents.h"
 #include "xattr.h"
 #include "acl.h"
 #include "truncate.h"
@@ -3705,10 +3706,197 @@ static void ext4_iomap_readahead(struct readahead_control *rac)
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
+	 * In order to protect from the race of truncate, we have to lookup
+	 * extent stats and map blocks under i_data_sem, otherwise the
+	 * delalloc extent could be stale.
+	 */
+	down_write(&EXT4_I(inode)->i_data_sem);
+	if (likely(ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es))) {
+		retval = es.es_len - (map->m_lblk - es.es_lblk);
+		map->m_len = min_t(unsigned int, retval, map->m_len);
+
+		if (likely(ext4_es_is_delonly(&es))) {
+			trace_ext4_da_write_pages_extent(inode, map);
+			/*
+			 * Call ext4_map_create_blocks() to allocate any delayed
+			 * allocation blocks. It is possible that we're going to
+			 * need more metadata blocks, however we must not fail
+			 * because we're in writeback and there is nothing we
+			 * can do so it might result in data loss. So use
+			 * reserved blocks to allocate metadata if possible.
+			 *
+			 * We pass in the magic EXT4_GET_BLOCKS_DELALLOC_RESERVE
+			 * indicates that the blocks and quotas has already been
+			 * checked when the data was copied into the page cache.
+			 */
+			map_flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT |
+				    EXT4_GET_BLOCKS_METADATA_NOFAIL |
+				    EXT4_GET_BLOCKS_DELALLOC_RESERVE;
+
+			retval = ext4_map_create_blocks(handle, inode, map,
+							map_flags);
+		}
+		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
+			map->m_pblk = ext4_es_pblock(&es) + map->m_lblk -
+				      es.es_lblk;
+			map->m_flags = ext4_es_is_written(&es) ?
+				       EXT4_MAP_MAPPED : EXT4_MAP_UNWRITTEN;
+		}
+	} else {
+		retval = ext4_map_query_blocks(handle, inode, map, 0);
+	}
+
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
+	/*
+	 * The map isn't a delalloc extent, it must be a hole or have
+	 * already been allocated.
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
+		if (ret == -ENOSPC && ext4_count_free_clusters(sb)) {
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


