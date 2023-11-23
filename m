Return-Path: <linux-fsdevel+bounces-3537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94AB7F5F8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 13:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA37281F22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 12:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963F533096;
	Thu, 23 Nov 2023 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59123D4E;
	Thu, 23 Nov 2023 04:52:07 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SbdKs75ZFz4f3kFq;
	Thu, 23 Nov 2023 20:52:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AB4811A01E8;
	Thu, 23 Nov 2023 20:52:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xHdSl9lSfnfBg--.20473S14;
	Thu, 23 Nov 2023 20:52:03 +0800 (CST)
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
Subject: [RFC PATCH 10/18] ext4: implement buffered write iomap path
Date: Thu, 23 Nov 2023 20:51:12 +0800
Message-Id: <20231123125121.4064694-11-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDn6xHdSl9lSfnfBg--.20473S14
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1UJF4xXF1xXr17Xw1DJrb_yoW3Jw43pa
	93CFy5Ga15W3s29F4ftr4UZF15K3W0yw47CrWfWr98Aa4Utry3KF10kFyavFy5trWxZF4j
	gF4rKry8Ca1UC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Implement both buffer write path with/without delayed allocation
feature, also inherit the fallback to nodelalloc logic from buffer_head
path when the free space is about to run out. After switching to iomap,
we support mapping multi-blocks once a time, which could bring a lot of
performance gains.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 209 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 207 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4c206cf37a49..9229297e1efc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3525,13 +3525,154 @@ const struct iomap_ops ext4_iomap_report_ops = {
 	.iomap_begin = ext4_iomap_begin_report,
 };
 
+static int ext4_iomap_da_map_blocks(struct inode *inode,
+				    struct ext4_map_blocks *map)
+{
+	struct extent_status es;
+	unsigned int status;
+	ext4_lblk_t next;
+	int mapped_len;
+	int ret = 0;
+#ifdef ES_AGGRESSIVE_TEST
+	struct ext4_map_blocks orig_map;
+
+	memcpy(&orig_map, map, sizeof(*map));
+#endif
+
+	map->m_flags = 0;
+	ext_debug(inode, "max_blocks %u, logical block %llu\n", map->m_len,
+		  (unsigned long long)map->m_lblk);
+
+	/* Lookup extent status tree firstly */
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+		int es_len = es.es_len - (map->m_lblk - es.es_lblk);
+
+		map->m_len = min_t(unsigned int, map->m_len, es_len);
+		if (ext4_es_is_delonly(&es)) {
+			map->m_pblk = 0;
+			map->m_flags |= EXT4_MAP_DELAYED;
+			return 0;
+		}
+		if (ext4_es_is_hole(&es)) {
+			down_read(&EXT4_I(inode)->i_data_sem);
+			goto add_delayed;
+		}
+
+		map->m_pblk = ext4_es_pblock(&es) + map->m_lblk - es.es_lblk;
+		if (ext4_es_is_written(&es))
+			map->m_flags |= EXT4_MAP_MAPPED;
+		else if (ext4_es_is_unwritten(&es))
+			map->m_flags |= EXT4_MAP_UNWRITTEN;
+		else
+			BUG();
+
+#ifdef ES_AGGRESSIVE_TEST
+		ext4_map_blocks_es_recheck(NULL, inode, map, &orig_map, 0);
+#endif
+		/* Already delayed */
+		if (ext4_es_is_delayed(&es))
+			return 0;
+
+		down_read(&EXT4_I(inode)->i_data_sem);
+		goto insert_extent;
+	}
+
+	/*
+	 * Not found cached extents, adjust the length if it has been
+	 * partially allocated.
+	 */
+	if (es.es_lblk > map->m_lblk &&
+	    es.es_lblk < map->m_lblk + map->m_len) {
+		next = es.es_lblk;
+		if (ext4_es_is_hole(&es))
+			next = ext4_es_skip_hole_extent(inode, map->m_lblk,
+							map->m_len);
+		map->m_len = next - map->m_lblk;
+	}
+
+	/*
+	 * Try to see if we can get blocks without requesting new file
+	 * system blocks.
+	 */
+	down_read(&EXT4_I(inode)->i_data_sem);
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		mapped_len = ext4_ext_map_blocks(NULL, inode, map, 0);
+	else
+		mapped_len = ext4_ind_map_blocks(NULL, inode, map, 0);
+	if (mapped_len < 0) {
+		ret = mapped_len;
+		goto out_unlock;
+	}
+	if (mapped_len == 0)
+		goto add_delayed;
+
+	if (unlikely(mapped_len != map->m_len)) {
+		ext4_warning(inode->i_sb,
+			     "ES len assertion failed for inode %lu: "
+			     "retval %d != map->m_len %d",
+			     inode->i_ino, mapped_len, map->m_len);
+		WARN_ON(1);
+	}
+
+insert_extent:
+	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
+			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
+	if (status == EXTENT_STATUS_UNWRITTEN)
+		status |= EXTENT_STATUS_DELAYED;
+	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+			      map->m_pblk, status);
+	goto out_unlock;
+add_delayed:
+	ret = ext4_insert_delayed_blocks(inode, map->m_lblk, map->m_len);
+out_unlock:
+	up_read((&EXT4_I(inode)->i_data_sem));
+	return ret;
+}
+
+static int ext4_iomap_noda_map_blocks(struct inode *inode,
+				      struct ext4_map_blocks *map)
+{
+	handle_t *handle;
+	int ret, needed_blocks;
+	int flags;
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
+	if (ext4_should_dioread_nolock(inode))
+		flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
+	else
+		flags = EXT4_GET_BLOCKS_CREATE;
+
+	ret = ext4_map_blocks(handle, inode, map, flags);
+	if (ret < 0) {
+		ext4_journal_stop(handle);
+		return ret;
+	}
+
+	return 0;
+}
+
+#define IOMAP_F_EXT4_NONDELALLOC IOMAP_F_PRIVATE
+
 static int ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
 				loff_t length, unsigned int flags,
 				struct iomap *iomap, struct iomap *srcmap)
 {
-	int ret;
+	int ret, retries = 0;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
+	bool no_delalloc = false;
+
+	if ((flags & IOMAP_WRITE) &&
+	    unlikely(ext4_forced_shutdown(inode->i_sb)))
+		return -EIO;
 
 	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
 		return -EINVAL;
@@ -3539,6 +3680,7 @@ static int ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
 	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
 		return -ERANGE;
 
+retry:
 	/*
 	 * Calculate the first and last logical blocks respectively.
 	 */
@@ -3546,14 +3688,77 @@ static int ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
 	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
 			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
 
-	ret = ext4_map_blocks(NULL, inode, &map, 0);
+	if (flags & IOMAP_WRITE) {
+		if (test_opt(inode->i_sb, DELALLOC) &&
+		    !ext4_nonda_switch(inode->i_sb)) {
+			ret = ext4_iomap_da_map_blocks(inode, &map);
+		} else {
+			ret = ext4_iomap_noda_map_blocks(inode, &map);
+			no_delalloc = true;
+		}
+		if (ret == -ENOSPC &&
+		    ext4_should_retry_alloc(inode->i_sb, &retries))
+			goto retry;
+	} else {
+		ret = ext4_map_blocks(NULL, inode, &map, 0);
+	}
 	if (ret < 0)
 		return ret;
 
 	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
+	if (no_delalloc)
+		iomap->flags |= IOMAP_F_EXT4_NONDELALLOC;
+
 	return 0;
 }
 
+static int ext4_iomap_buffered_write_end(struct inode *inode, loff_t offset,
+					 loff_t length, ssize_t written,
+					 unsigned flags, struct iomap *iomap)
+{
+	handle_t *handle;
+	int ret = 0, ret2;
+
+	if (!(flags & IOMAP_WRITE))
+		return 0;
+	if (!(iomap->flags & IOMAP_F_EXT4_NONDELALLOC))
+		return 0;
+
+	handle = ext4_journal_current_handle();
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
+	if (offset + length > inode->i_size)
+		ext4_orphan_add(handle, inode);
+
+	ret2 = ext4_journal_stop(handle);
+	ret = ret ? ret : ret2;
+
+	if (offset + length > inode->i_size) {
+		ext4_truncate_failed_write(inode);
+		/*
+		 * If truncate failed early the inode might still be
+		 * on the orphan list; we need to make sure the inode
+		 * is removed from the orphan list in that case.
+		 */
+		if (inode->i_nlink)
+			ext4_orphan_del(NULL, inode);
+	}
+	return ret;
+}
+
+const struct iomap_ops ext4_iomap_buffered_write_ops = {
+	.iomap_begin = ext4_iomap_buffered_io_begin,
+	.iomap_end = ext4_iomap_buffered_write_end,
+};
+
 const struct iomap_ops ext4_iomap_read_ops = {
 	.iomap_begin = ext4_iomap_buffered_io_begin,
 };
-- 
2.39.2


