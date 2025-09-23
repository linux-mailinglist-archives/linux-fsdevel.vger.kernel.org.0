Return-Path: <linux-fsdevel+bounces-62468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E688B93DFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 03:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D0844E2C89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 01:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8612DA743;
	Tue, 23 Sep 2025 01:29:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B8C2701CF;
	Tue, 23 Sep 2025 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590978; cv=none; b=o9oRynXAY87y4Hn0Lax7rBUtshH/06ZYnm+bnSozeW0PL+g8auXzzATOF9/aXGB+TyfS9GVeY8BC40nsA+l2HoinhWg/a6fIkkOFvi9tm3Za2gmjw08G8XCS7eadsFo8vF2IAUr6y9O3mmpHnmc3IVQMOyJ4pxCeEv8Omd84ZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590978; c=relaxed/simple;
	bh=pE5jLeNab5P/CHV7cctJJvtK+tfdOJYGsBtA8ilytsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjSETd1KYFIW7ArEEVv5PnqPzW2d4M7lD/wJIzGW3cQGo8Na5NlJenFaDfu8IQdbwtIv6JKeCvLxwovGU8h1g7h3o6S0aM52F2Iw996Chgj/fzSI6m/WfvO4JXpo/r4BpaCywi1JzlB/oOhOdaar2RTS4AKfn8VRGCXJF0YD5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cW2Sv4s6hzYQv4N;
	Tue, 23 Sep 2025 09:29:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D00DE1A1041;
	Tue, 23 Sep 2025 09:29:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAXKWHq99FoGYYGAg--.10941S14;
	Tue, 23 Sep 2025 09:29:24 +0800 (CST)
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
Subject: [PATCH 10/13] ext4: introduce mext_move_extent()
Date: Tue, 23 Sep 2025 09:27:20 +0800
Message-ID: <20250923012724.2378858-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250923012724.2378858-1-yi.zhang@huaweicloud.com>
References: <20250923012724.2378858-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXKWHq99FoGYYGAg--.10941S14
X-Coremail-Antispam: 1UD129KBjvJXoW3tFyDCF1fJrW3Wr18uw1rJFb_yoWDWF4DpF
	W2krn8JrWDGayI9r4Iyw48Zr1fKayxGr47AFWfW343ZFyUtry0gas5K3WUZFyrKrWxJFyF
	qF4Fyry7WayUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When moving extents, the current move_extent_per_page() process can only
move extents of length PAGE_SIZE at a time, which is highly inefficient,
especially when the fragmentation of the file is not particularly
severe, this will result in a large number of unnecessary extent split
and merge operations. Moreover, since the ext4 file system now supports
large folios, using PAGE_SIZE as the processing unit is no longer
practical.

Therefore, introduce a new move extents method, mext_move_extent(). It
moves one extent of the origin inode at a time, but not exceeding the
size of a folio. The parameters for the move are passed through the new
mext_data data structure, which includes the origin inode, donor inode,
the mapping extent of the origin inode to be moved, and the starting
offset of the donor inode.

The move process is similar to move_extent_per_page() and can be
categorized into three types: MEXT_SKIP_EXTENT, MEXT_MOVE_EXTENT, and
MEXT_COPY_DATA. MEXT_SKIP_EXTENT indicates that the corresponding area
of the donor file is a hole, meaning no actual space is allocated, so
the move is skipped. MEXT_MOVE_EXTENT indicates that the corresponding
areas of both the origin and donor files are unwritten, so no data needs
to be copied; only the extents are swapped. MEXT_COPY_DATA indicates
that the corresponding areas of both the origin and donor files contain
data, so data must be copied. The data copying is performed in three
steps: first, the data from the original location is read into the page
cache; then, the extents are swapped, and the page cache is rebuilt to
reflect the index of the physical blocks; finally, the dirty page cache
is marked and written back to ensure that the data is written to disk
before the metadata is persisted.

One important point to note is that the folio lock and i_data_sem are
held only during the moving process. Therefore, before moving an extent,
it is necessary to check whether the sequence cookie of the area to be
moved has changed while holding the folio lock. If a change is detected,
it indicates that concurrent write-back operations may have occurred
during this period, and the type of the extent to be moved can no longer
be considered reliable. For example, it may have changed from unwritten
to written. In such cases, return -ESTALE, and the calling function
should reacquire the move extent of the original file and retry the
movement.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/move_extent.c | 216 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 5faa55109570..4edb9a378db7 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -13,6 +13,13 @@
 #include "ext4.h"
 #include "ext4_extents.h"
 
+struct mext_data {
+	struct inode *orig_inode;	/* Origin file inode */
+	struct inode *donor_inode;	/* Donor file inode */
+	struct ext4_map_blocks orig_map;/* Origin file's move mapping */
+	ext4_lblk_t donor_lblk;		/* Start block of the donor file */
+};
+
 /**
  * get_ext_path() - Find an extent path for designated logical block number.
  * @inode:	inode to be searched
@@ -164,6 +171,14 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
 	return 0;
 }
 
+static void mext_folio_double_unlock(struct folio *folio[2])
+{
+	folio_unlock(folio[0]);
+	folio_put(folio[0]);
+	folio_unlock(folio[1]);
+	folio_put(folio[1]);
+}
+
 /* Force folio buffers uptodate w/o dropping folio's lock */
 static int mext_folio_mkuptodate(struct folio *folio, size_t from, size_t to)
 {
@@ -238,6 +253,207 @@ static int mext_folio_mkuptodate(struct folio *folio, size_t from, size_t to)
 	return 0;
 }
 
+enum mext_move_type {MEXT_SKIP_EXTENT, MEXT_MOVE_EXTENT, MEXT_COPY_DATA};
+
+/*
+ * Start to move extent between the origin inode and the donor inode,
+ * hold one folio for each inode and check the candidate moving extent
+ * mapping status again.
+ */
+static int mext_move_begin(struct mext_data *mext, struct folio *folio[2],
+			   enum mext_move_type *move_type)
+{
+	struct inode *orig_inode = mext->orig_inode;
+	struct inode *donor_inode = mext->donor_inode;
+	unsigned int blkbits = orig_inode->i_blkbits;
+	struct ext4_map_blocks donor_map = {0};
+	loff_t orig_pos, donor_pos;
+	size_t move_len;
+	int ret;
+
+	orig_pos = ((loff_t)mext->orig_map.m_lblk) << blkbits;
+	donor_pos = ((loff_t)mext->donor_lblk) << blkbits;
+	ret = mext_folio_double_lock(orig_inode, donor_inode,
+			orig_pos >> PAGE_SHIFT, donor_pos >> PAGE_SHIFT, folio);
+	if (ret)
+		return ret;
+
+	/*
+	 * Check the origin inode's mapping information again under the
+	 * folio lock, as we do not hold the i_data_sem at all times, and
+	 * it may change during the concurrent write-back operation.
+	 */
+	if (mext->orig_map.m_seq != READ_ONCE(EXT4_I(orig_inode)->i_es_seq)) {
+		ret = -ESTALE;
+		goto error;
+	}
+
+	/* Adjust the moving length according to the minor folios length. */
+	move_len = umin(folio_pos(folio[0]) + folio_size(folio[0]) - orig_pos,
+			folio_pos(folio[1]) + folio_size(folio[1]) - donor_pos);
+	move_len >>= blkbits;
+	if (move_len < mext->orig_map.m_len)
+		mext->orig_map.m_len = move_len;
+
+	donor_map.m_lblk = mext->donor_lblk;
+	donor_map.m_len = mext->orig_map.m_len;
+	donor_map.m_flags = 0;
+	ret = ext4_map_blocks(NULL, donor_inode, &donor_map, 0);
+	if (ret < 0)
+		goto error;
+
+	/* Adjust the moving length according to the donor mapping length. */
+	mext->orig_map.m_len = donor_map.m_len;
+
+	/* Skip moving if the donor range is a hole or a delalloc extent. */
+	if (!(donor_map.m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)))
+		*move_type = MEXT_SKIP_EXTENT;
+	/* If both mapping ranges are unwritten, no need to copy data. */
+	else if ((mext->orig_map.m_flags & EXT4_MAP_UNWRITTEN) &&
+		 (donor_map.m_flags & EXT4_MAP_UNWRITTEN))
+		*move_type = MEXT_MOVE_EXTENT;
+	else
+		*move_type = MEXT_COPY_DATA;
+
+	return 0;
+error:
+	mext_folio_double_unlock(folio);
+	return ret;
+}
+
+/*
+ * Re-create the new moved mapping buffers of the original inode and commit
+ * the entire written range.
+ */
+static int mext_folio_mkwrite(struct inode *inode, struct folio *folio,
+			      size_t from, size_t to)
+{
+	unsigned int blocksize = i_blocksize(inode);
+	struct buffer_head *bh, *head;
+	size_t block_start, block_end;
+	sector_t block;
+	int ret;
+
+	head = folio_buffers(folio);
+	if (!head)
+		head = create_empty_buffers(folio, blocksize, 0);
+
+	block = folio_pos(folio) >> inode->i_blkbits;
+	block_end = 0;
+	bh = head;
+	do {
+		block_start = block_end;
+		block_end = block_start + blocksize;
+		if (block_end <= from || block_start >= to)
+			continue;
+
+		ret = ext4_get_block(inode, block, bh, 0);
+		if (ret)
+			return ret;
+	} while (block++, (bh = bh->b_this_page) != head);
+
+	block_commit_write(folio, from, to);
+	return 0;
+}
+
+/*
+ * Save the data in original inode extent blocks and replace one folio size
+ * aligned original inode extent with one or one partial donor inode extent,
+ * and then write out the saved data in new original inode blocks. Pass out
+ * the replaced block count through m_len. Return 0 on success, and an error
+ * code otherwise.
+ */
+static __used int mext_move_extent(struct mext_data *mext, u64 *m_len)
+{
+	struct inode *orig_inode = mext->orig_inode;
+	struct inode *donor_inode = mext->donor_inode;
+	struct ext4_map_blocks *orig_map = &mext->orig_map;
+	unsigned int blkbits = orig_inode->i_blkbits;
+	struct folio *folio[2] = {NULL, NULL};
+	loff_t from, length;
+	enum mext_move_type move_type = 0;
+	handle_t *handle;
+	u64 r_len = 0;
+	unsigned int credits;
+	int ret, ret2;
+
+	*m_len = 0;
+	credits = ext4_chunk_trans_extent(orig_inode, 0) * 2;
+	handle = ext4_journal_start(orig_inode, EXT4_HT_MOVE_EXTENTS, credits);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	ret = mext_move_begin(mext, folio, &move_type);
+	if (ret)
+		goto stop_handle;
+
+	if (move_type == MEXT_SKIP_EXTENT)
+		goto unlock;
+
+	/*
+	 * Copy the data. First, read the original inode data into the page
+	 * cache. Then, release the existing mapping relationships and swap
+	 * the extent. Finally, re-establish the new mapping relationships
+	 * and dirty the page cache.
+	 */
+	if (move_type == MEXT_COPY_DATA) {
+		from = offset_in_folio(folio[0],
+				((loff_t)orig_map->m_lblk) << blkbits);
+		length = ((loff_t)orig_map->m_len) << blkbits;
+
+		ret = mext_folio_mkuptodate(folio[0], from, from + length);
+		if (ret)
+			goto unlock;
+	}
+
+	if (!filemap_release_folio(folio[0], 0) ||
+	    !filemap_release_folio(folio[1], 0)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	/* Move extent */
+	ext4_double_down_write_data_sem(orig_inode, donor_inode);
+	*m_len = ext4_swap_extents(handle, orig_inode, donor_inode,
+				   orig_map->m_lblk, mext->donor_lblk,
+				   orig_map->m_len, 1, &ret);
+	ext4_double_up_write_data_sem(orig_inode, donor_inode);
+	if (ret)
+		goto unlock;
+
+	if (move_type == MEXT_MOVE_EXTENT)
+		goto unlock;
+
+	/* Copy data */
+	length = (*m_len) << blkbits;
+	ret = mext_folio_mkwrite(orig_inode, folio[0], from, from + length);
+	if (ret)
+		goto repair_branches;
+	/*
+	 * Even in case of data=writeback it is reasonable to pin
+	 * inode to transaction, to prevent unexpected data loss.
+	 */
+	ret = ext4_jbd2_inode_add_write(handle, orig_inode,
+			((loff_t)orig_map->m_lblk) << blkbits, length);
+unlock:
+	mext_folio_double_unlock(folio);
+stop_handle:
+	ext4_journal_stop(handle);
+	return ret;
+
+repair_branches:
+	r_len = ext4_swap_extents(handle, donor_inode, orig_inode,
+				  mext->donor_lblk, orig_map->m_lblk,
+				  *m_len, 0, &ret2);
+	if (ret2 || r_len != *m_len) {
+		ext4_error_inode_block(orig_inode, (sector_t)(orig_map->m_lblk),
+				       EIO, "Unable to copy data block, data will be lost!");
+		ret = -EIO;
+	}
+	*m_len = 0;
+	goto unlock;
+}
+
 /**
  * move_extent_per_page - Move extent data per page
  *
-- 
2.46.1


