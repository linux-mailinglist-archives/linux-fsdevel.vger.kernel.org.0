Return-Path: <linux-fsdevel+bounces-76147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNs7IZ2XgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:37:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C331AD5545
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5686C303D7E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C238E5E2;
	Tue,  3 Feb 2026 06:30:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C03815D2;
	Tue,  3 Feb 2026 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100224; cv=none; b=hrhpRHRBWz0/xS1uDCl4PwwqugXmYpmYDrR+6gYkMYKlUmpinqjjr5ehudQFZ43h9E0vKSs78/DD2h/OkI1+eXz9OsQ0xPmhr6jUj8CWl/zN3IYngQBgJpC/FfJcxY7gzJAeZZw2zInASC+I/o37c6MJn0H1pqIYKgh9Eew+HfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100224; c=relaxed/simple;
	bh=Vd6xxkOhK4dvyZpBYkB6b+dQhRuxKD02kT0JWgySG2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrBn7Xn9MyOnbHISdjmeHEdzbSGWOfgT0qIlo6KNSgaSbxgZDexvv04V2RC9VOJAcL/JTbt1/gFCsI/5dT93bwL5FUR2jCgoT2JNWej6fVWEvQFSIU+vBRslxPwgclm5hU6Ik2KsmVDDsD+KAgGUXYwg4VhiRHv+QT0llY5hcr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4tqq5wP1zYQtyh;
	Tue,  3 Feb 2026 14:29:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BF3594058F;
	Tue,  3 Feb 2026 14:30:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S17;
	Tue, 03 Feb 2026 14:30:14 +0800 (CST)
From: Zhang Yi <yi.zhang@huawei.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yukuai@fnnas.com
Subject: [PATCH -next v2 13/22] ext4: implement writeback iomap path
Date: Tue,  3 Feb 2026 14:25:13 +0800
Message-ID: <20260203062523.3869120-14-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203062523.3869120-1-yi.zhang@huawei.com>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S17
X-Coremail-Antispam: 1UD129KBjvAXoW3ury7WF1xur1rtry7ZrW7twb_yoW8WF18Zo
	WSqa13Xr48Jry5tayFkF1ftryUuan7Gw4rJr45ZrZFvasxJa4Yyw4fGw47W3W7Xw4FkFyf
	ZrWxJ3W5Gr48J3Wrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOt7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0aVACjI8F5VA0II8E6IAqYI8I648v4I1lFI
	xGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFP
	ETDUUUU
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76147-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C331AD5545
X-Rspamd-Action: no action

Implement the iomap writeback path for ext4. It implement
ext4_iomap_writepages(), introduce a new iomap_writeback_ops instance,
ext4_writeback_ops, and create a new end I/O extent conversion worker to
convert unwritten extents after the I/O is completed.

In the ->writeback_range() callback, it first call
ext4_iomap_map_writeback_range() to query the longest range of existing
mapped extents. For performance considerations, if the block range has
not been allocated, it attempts to allocate a range of longest blocks
which is based on the writeback length and the delalloc extent length,
rather than allocating for a single folio length at a time. Then, add
the folio to the iomap_ioend instance.

In the ->writeback_submit() callback, it registers a special end bio
callback, ext4_iomap_end_bio(), which will start a worker if we need to
convert unwritten extents or need to update i_disksize after the data
has been written back, and if we need to abort the journal when the I/O
is failed to write back.

Key notes:

 - Since we aim to allocate a range of blocks as long as possible within
   the writeback length for each invocation of ->writeback_range()
   callback, we may allocate a long range but write less in certain
   corner cases. Therefore, we have to ignore the dioread_nolock mount
   option and always allocate unwritten blocks. This is consistent with
   the non-delayed buffer write process.

 - Since ->writeback_range() is always executed under the folio lock,
   this means we need to start the handle under the folio lock as well.
   This is opposite to the order in the buffer_head writeback path.
   Therefore, we cannot use the ordered data mode to write back data,
   otherwise it would cause a deadlock. Fortunately, since we always
   allocate unwritten extents when allocating blocks, the functionality
   of the ordered data mode is already quite limited and can be replaced
   by other methods.

 - Since we don't use ordered data mode, the deadlock problem that was
   expected to be resolved through the reserve handle does not exists
   here. Therefore, we also do not need to use the reserve handle when
   converting the unwritten extent in the end I/O worker, we can start a
   normal journal handle instead.

 - Since we always allocate unwritten blocks, we also delay updating the
   i_disksize until the I/O is done, which could prevent the exposure of
   zero data that may occur during a system crash while performing
   buffer append writes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |   4 +
 fs/ext4/inode.c   | 213 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/page-io.c | 119 ++++++++++++++++++++++++++
 fs/ext4/super.c   |   7 +-
 4 files changed, 341 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 89059b15ee5c..520f6d5dcdab 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1176,6 +1176,8 @@ struct ext4_inode_info {
 	 */
 	struct list_head i_rsv_conversion_list;
 	struct work_struct i_rsv_conversion_work;
+	struct list_head i_iomap_ioend_list;
+	struct work_struct i_iomap_ioend_work;
 
 	/*
 	 * Transactions that contain inode's metadata needed to complete
@@ -3874,6 +3876,8 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *page,
 		size_t len);
 extern struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end);
 extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
+extern void ext4_iomap_end_io(struct work_struct *work);
+extern void ext4_iomap_end_bio(struct bio *bio);
 
 /* mmp.c */
 extern int ext4_multi_mount_protect(struct super_block *, ext4_fsblk_t);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index da4fd62c6963..4a7d18511c3f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -44,6 +44,7 @@
 #include <linux/iversion.h>
 
 #include "ext4_jbd2.h"
+#include "ext4_extents.h"
 #include "xattr.h"
 #include "acl.h"
 #include "truncate.h"
@@ -4123,10 +4124,220 @@ static void ext4_iomap_readahead(struct readahead_control *rac)
 	iomap_bio_readahead(rac, &ext4_iomap_buffered_read_ops);
 }
 
+struct ext4_writeback_ctx {
+	struct iomap_writepage_ctx ctx;
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
+	credits = ext4_chunk_trans_blocks(inode, map->m_len);
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
+	ext4_fc_track_inode(handle, inode);
+	down_write(&EXT4_I(inode)->i_data_sem);
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, &map->m_seq)) {
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
+				    EXT4_GET_BLOCKS_METADATA_NOFAIL |
+				    EXT4_EX_NOCACHE;
+
+			retval = ext4_map_create_blocks(handle, inode, map,
+							map_flags);
+			if (retval > 0)
+				ext4_fc_track_range(handle, inode, map->m_lblk,
+						map->m_lblk + map->m_len - 1);
+			goto out;
+		} else if (unlikely(ext4_es_is_hole(&es)))
+			goto out;
+
+		/* Found written or unwritten extent. */
+		map->m_pblk = ext4_es_pblock(&es) + map->m_lblk - es.es_lblk;
+		map->m_flags = ext4_es_is_written(&es) ?
+			       EXT4_MAP_MAPPED : EXT4_MAP_UNWRITTEN;
+		goto out;
+	}
+
+	retval = ext4_map_query_blocks(handle, inode, map, EXT4_EX_NOCACHE);
+out:
+	up_write(&EXT4_I(inode)->i_data_sem);
+	ext4_journal_stop(handle);
+	return retval < 0 ? retval : 0;
+}
+
+static int ext4_iomap_map_writeback_range(struct iomap_writepage_ctx *wpc,
+					  loff_t offset, unsigned int dirty_len)
+{
+	struct ext4_writeback_ctx *ewpc =
+			container_of(wpc, struct ext4_writeback_ctx, ctx);
+	struct inode *inode = wpc->inode;
+	struct super_block *sb = inode->i_sb;
+	struct journal_s *journal = EXT4_SB(sb)->s_journal;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_map_blocks map;
+	unsigned int blkbits = inode->i_blkbits;
+	unsigned int index = offset >> blkbits;
+	unsigned int blk_end, blk_len;
+	int ret;
+
+	ret = ext4_emergency_state(sb);
+	if (unlikely(ret))
+		return ret;
+
+	/* Check validity of the cached writeback mapping. */
+	if (offset >= wpc->iomap.offset &&
+	    offset < wpc->iomap.offset + wpc->iomap.length &&
+	    ewpc->data_seq == READ_ONCE(ei->i_es_seq))
+		return 0;
+
+	blk_len = dirty_len >> blkbits;
+	blk_end = min_t(unsigned int, (wpc->wbc->range_end >> blkbits),
+				      (UINT_MAX - 1));
+	if (blk_end > index + blk_len)
+		blk_len = blk_end - index + 1;
+
+retry:
+	map.m_lblk = index;
+	map.m_len = min_t(unsigned int, MAX_WRITEPAGES_EXTENT_LEN, blk_len);
+	ret = ext4_map_blocks(NULL, inode, &map,
+			      EXT4_GET_BLOCKS_IO_SUBMIT | EXT4_EX_NOCACHE);
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
+		if (ext4_emergency_state(sb))
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
+	ewpc->data_seq = map.m_seq;
+	ext4_set_iomap(inode, &wpc->iomap, &map, offset, dirty_len, 0);
+	return 0;
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
+static ssize_t ext4_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
+					  struct folio *folio, u64 offset,
+					  unsigned int len, u64 end_pos)
+{
+	ssize_t ret;
+
+	ret = ext4_iomap_map_writeback_range(wpc, offset, len);
+	if (!ret)
+		ret = iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
+	if (ret < 0)
+		ext4_iomap_discard_folio(folio, offset);
+	return ret;
+}
+
+static int ext4_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
+				       int error)
+{
+	struct iomap_ioend *ioend = wpc->wb_ctx;
+	struct ext4_inode_info *ei = EXT4_I(ioend->io_inode);
+
+	/* Need to convert unwritten extents when I/Os are completed. */
+	if ((ioend->io_flags & IOMAP_IOEND_UNWRITTEN) ||
+	    ioend->io_offset + ioend->io_size > READ_ONCE(ei->i_disksize))
+		ioend->io_bio.bi_end_io = ext4_iomap_end_bio;
+
+	return iomap_ioend_writeback_submit(wpc, error);
+}
+
+static const struct iomap_writeback_ops ext4_writeback_ops = {
+	.writeback_range = ext4_iomap_writeback_range,
+	.writeback_submit = ext4_iomap_writeback_submit,
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
+		.ctx = {
+			.inode = inode,
+			.wbc = wbc,
+			.ops = &ext4_writeback_ops,
+		},
+	};
+
+	ret = ext4_emergency_state(sb);
+	if (unlikely(ret))
+		return ret;
+
+	alloc_ctx = ext4_writepages_down_read(sb);
+	trace_ext4_writepages(inode, wbc);
+	ret = iomap_writepages(&ewpc.ctx);
+	trace_ext4_writepages_result(inode, wbc, ret, nr - wbc->nr_to_write);
+	ext4_writepages_up_read(sb, alloc_ctx);
+
+	return ret;
 }
 
 /*
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index a8c95eee91b7..d74aa430636f 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -23,6 +23,7 @@
 #include <linux/bio.h>
 #include <linux/workqueue.h>
 #include <linux/kernel.h>
+#include <linux/iomap.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
@@ -592,3 +593,121 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 
 	return 0;
 }
+
+static void ext4_iomap_finish_ioend(struct iomap_ioend *ioend)
+{
+	struct inode *inode = ioend->io_inode;
+	struct super_block *sb = inode->i_sb;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	loff_t pos = ioend->io_offset;
+	size_t size = ioend->io_size;
+	loff_t new_disksize;
+	handle_t *handle;
+	int credits;
+	int ret, err;
+
+	ret = blk_status_to_errno(ioend->io_bio.bi_status);
+	if (unlikely(ret)) {
+		if (test_opt(sb, DATA_ERR_ABORT))
+			jbd2_journal_abort(EXT4_SB(sb)->s_journal, ret);
+		goto out;
+	}
+
+	/* We may need to convert one extent and dirty the inode. */
+	credits = ext4_chunk_trans_blocks(inode,
+			EXT4_MAX_BLOCKS(size, pos, inode->i_blkbits));
+	handle = ext4_journal_start(inode, EXT4_HT_EXT_CONVERT, credits);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto out_err;
+	}
+
+	if (ioend->io_flags & IOMAP_IOEND_UNWRITTEN) {
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
+	if (ret < 0 && !ext4_emergency_state(sb)) {
+		ext4_msg(sb, KERN_EMERG,
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
+	int ret;
+
+	/* Needs to convert unwritten extents or update the i_disksize. */
+	if ((ioend->io_flags & IOMAP_IOEND_UNWRITTEN) ||
+	    ioend->io_offset + ioend->io_size > READ_ONCE(ei->i_disksize))
+		goto defer;
+
+	/* Needs to abort the journal on data_err=abort.  */
+	ret = blk_status_to_errno(ioend->io_bio.bi_status);
+	if (unlikely(ret) && test_opt(ioend->io_inode->i_sb, DATA_ERR_ABORT))
+		goto defer;
+
+	iomap_finish_ioends(ioend, ret);
+	return;
+defer:
+	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
+	if (list_empty(&ei->i_iomap_ioend_list))
+		queue_work(sbi->rsv_conversion_wq, &ei->i_iomap_ioend_work);
+	list_add_tail(&ioend->io_list, &ei->i_iomap_ioend_list);
+	spin_unlock_irqrestore(&ei->i_completed_io_lock, flags);
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b68509505558..cffe63deba31 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -123,7 +123,10 @@ static const struct fs_parameter_spec ext4_param_specs[];
  * sb_start_write -> i_mutex -> transaction start -> i_data_sem (rw)
  *
  * writepages:
- * transaction start -> page lock(s) -> i_data_sem (rw)
+ * - buffer_head path:
+ *   transaction start -> folio lock(s) -> i_data_sem (rw)
+ * - iomap path:
+ *   folio lock -> transaction start -> i_data_sem (rw)
  */
 
 static const struct fs_context_operations ext4_context_ops = {
@@ -1426,10 +1429,12 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 #endif
 	ei->jinode = NULL;
 	INIT_LIST_HEAD(&ei->i_rsv_conversion_list);
+	INIT_LIST_HEAD(&ei->i_iomap_ioend_list);
 	spin_lock_init(&ei->i_completed_io_lock);
 	ei->i_sync_tid = 0;
 	ei->i_datasync_tid = 0;
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
+	INIT_WORK(&ei->i_iomap_ioend_work, ext4_iomap_end_io);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	spin_lock_init(&ei->i_fc_lock);
 	return &ei->vfs_inode;
-- 
2.52.0


