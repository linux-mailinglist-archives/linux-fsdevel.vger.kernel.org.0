Return-Path: <linux-fsdevel+bounces-32567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC009A96D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4EF1F259BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E771FF613;
	Tue, 22 Oct 2024 03:13:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B319F424;
	Tue, 22 Oct 2024 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566787; cv=none; b=qSxt1bORvL3naEvPjwXcSBYIzqlxzWsM38Vv1ISi3Lfncff5HvgDqUis02fUWdVpptthgR2uc41ks11h/VGvj43Fo4YOdpnWaCIMqrsGjwE5lRE6+96GkECM5IxxDRfAvxfvnZS6NI/QLNOoTcd+WQtrXx014KggRSfGA9jwIWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566787; c=relaxed/simple;
	bh=ZybBkTVx2KW71/Nmb2vUl1H2ZG3QiraM4QFypEzqLtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0jPOL58QmFEpIt+i/Brb3zGVGm/fQbcpuyPSHxAvKPNmawoDDsQHDDuk20UrGkHXvukt2aPiqmEJHQONUkizRrvhL+nIOwIDg2YSt9xF2TPOS3p6tuXgufWxadrzJO11MI8vFGGBYKV9Q3g1prma1O3UaJoTxaOKwLNWUwMxKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXcgJ4Dd7z4f3jXg;
	Tue, 22 Oct 2024 11:12:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EBDD71A0194;
	Tue, 22 Oct 2024 11:13:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S24;
	Tue, 22 Oct 2024 11:13:01 +0800 (CST)
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
Subject: [PATCH 20/27] ext4: do not start handle if unnecessary while partial zeroing out a block
Date: Tue, 22 Oct 2024 19:10:51 +0800
Message-ID: <20241022111059.2566137-21-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S24
X-Coremail-Antispam: 1UD129KBjvJXoW3tFW7ZF48ur1fAF47Gw15Arb_yoWDZF45pr
	y5Gr15Cr47ua4q9F4IgF4DXr1Ik3Z3KFW8WrW7Gr9Yva93Xw1fKF98KFnYvF4YgrW7Xay0
	vF4Yy347Ww4UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
	8v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRio7uDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When zeroing out a partial block in __ext4_block_zero_page_range()
during a partial truncate, zeroing range, or punching a hole, we only
need to start a handle in data=journal mode because we need to log the
zeroed data block, we don't need this handle in other modes. Therefore,
we can start a handle in ext4_block_zero_page_range() and avoid
performing the zeroing process under a running handle if it is in
data=ordered or writeback mode.

This change is essential for the conversion to iomap buffered I/O, as
it helps prevent a potential deadlock issue. After we switch to using
iomap_zero_range() to zero out a partial block in the later patches,
iomap_zero_range() may write out dirty folios and wait for I/O to
complete before the zeroing out. However, we can't wait I/O to complete
under running handle because the end I/O process may also wait this
handle to stop if the running transaction has begun to commit or the
journal is running out of space.

Therefore, let's postpone the start of handle in the of the partial
truncation, zeroing range, and hole punching, in preparation for the
buffered write iomap conversion.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |  4 +--
 fs/ext4/extents.c | 22 ++++++---------
 fs/ext4/inode.c   | 70 +++++++++++++++++++++++++----------------------
 3 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d4d594d97634..e1b7f7024f07 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3034,8 +3034,8 @@ extern void ext4_set_aops(struct inode *inode);
 extern int ext4_writepage_trans_blocks(struct inode *);
 extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
 extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
-extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
-			     loff_t lstart, loff_t lend);
+extern int ext4_zero_partial_blocks(struct inode *inode,
+				    loff_t lstart, loff_t lend);
 extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
 extern qsize_t *ext4_get_reserved_space(struct inode *inode);
 extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 4b30e6f0a634..20e56cd17847 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4576,7 +4576,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	ext4_lblk_t start_lblk, end_lblk;
 	unsigned int blocksize = i_blocksize(inode);
 	unsigned int blkbits = inode->i_blkbits;
-	int ret, flags, credits;
+	int ret, flags;
 
 	trace_ext4_zero_range(inode, offset, len, mode);
 	WARN_ON_ONCE(!inode_is_locked(inode));
@@ -4638,27 +4638,21 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (!(offset & (blocksize - 1)) && !(end & (blocksize - 1)))
 		return ret;
 
-	/*
-	 * In worst case we have to writeout two nonadjacent unwritten
-	 * blocks and update the inode
-	 */
-	credits = (2 * ext4_ext_index_trans_blocks(inode, 2)) + 1;
-	if (ext4_should_journal_data(inode))
-		credits += 2;
-	handle = ext4_journal_start(inode, EXT4_HT_MISC, credits);
+	/* Zero out partial block at the edges of the range */
+	ret = ext4_zero_partial_blocks(inode, offset, len);
+	if (ret)
+		return ret;
+
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(inode->i_sb, ret);
 		return ret;
 	}
 
-	/* Zero out partial block at the edges of the range */
-	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
-	if (ret)
-		goto out_handle;
-
 	if (new_size)
 		ext4_update_inode_size(inode, new_size);
+
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret))
 		goto out_handle;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 97be75cde481..34701afe61c2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4037,8 +4037,7 @@ void ext4_set_aops(struct inode *inode)
  * ext4_punch_hole, etc) which needs to be properly zeroed out. Otherwise a
  * racing writeback can come later and flush the stale pagecache to disk.
  */
-static int __ext4_block_zero_page_range(handle_t *handle,
-					struct address_space *mapping,
+static int __ext4_block_zero_page_range(struct address_space *mapping,
 					loff_t from, loff_t length,
 					bool *did_zero)
 {
@@ -4046,16 +4045,25 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	unsigned offset = from & (PAGE_SIZE-1);
 	unsigned blocksize, pos;
 	ext4_lblk_t iblock;
+	handle_t *handle;
 	struct inode *inode = mapping->host;
 	struct buffer_head *bh;
 	struct folio *folio;
 	int err = 0;
 
+	if (ext4_should_journal_data(inode)) {
+		handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);
+		if (IS_ERR(handle))
+			return PTR_ERR(handle);
+	}
+
 	folio = __filemap_get_folio(mapping, from >> PAGE_SHIFT,
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 				    mapping_gfp_constraint(mapping, ~__GFP_FS));
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+	if (IS_ERR(folio)) {
+		err = PTR_ERR(folio);
+		goto out;
+	}
 
 	blocksize = inode->i_sb->s_blocksize;
 
@@ -4106,22 +4114,24 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 			}
 		}
 	}
+
 	if (ext4_should_journal_data(inode)) {
 		BUFFER_TRACE(bh, "get write access");
 		err = ext4_journal_get_write_access(handle, inode->i_sb, bh,
 						    EXT4_JTR_NONE);
 		if (err)
 			goto unlock;
-	}
-	folio_zero_range(folio, offset, length);
-	BUFFER_TRACE(bh, "zeroed end of block");
 
-	if (ext4_should_journal_data(inode)) {
+		folio_zero_range(folio, offset, length);
+		BUFFER_TRACE(bh, "zeroed end of block");
+
 		err = ext4_dirty_journalled_data(handle, bh);
 		if (err)
 			goto unlock;
 	} else {
-		err = 0;
+		folio_zero_range(folio, offset, length);
+		BUFFER_TRACE(bh, "zeroed end of block");
+
 		mark_buffer_dirty(bh);
 	}
 
@@ -4131,6 +4141,9 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 unlock:
 	folio_unlock(folio);
 	folio_put(folio);
+out:
+	if (ext4_should_journal_data(inode))
+		ext4_journal_stop(handle);
 	return err;
 }
 
@@ -4141,8 +4154,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
  * the end of the block it will be shortened to end of the block
  * that corresponds to 'from'
  */
-static int ext4_block_zero_page_range(handle_t *handle,
-				      struct address_space *mapping,
+static int ext4_block_zero_page_range(struct address_space *mapping,
 				      loff_t from, loff_t length,
 				      bool *did_zero)
 {
@@ -4162,8 +4174,7 @@ static int ext4_block_zero_page_range(handle_t *handle,
 		return dax_zero_range(inode, from, length, NULL,
 				      &ext4_iomap_ops);
 	}
-	return __ext4_block_zero_page_range(handle, mapping, from, length,
-					    did_zero);
+	return __ext4_block_zero_page_range(mapping, from, length, did_zero);
 }
 
 /*
@@ -4172,8 +4183,7 @@ static int ext4_block_zero_page_range(handle_t *handle,
  * This required during truncate. We need to physically zero the tail end
  * of that block so it doesn't yield old data if the file is later grown.
  */
-static int ext4_block_truncate_page(handle_t *handle,
-				    struct address_space *mapping, loff_t from,
+static int ext4_block_truncate_page(struct address_space *mapping, loff_t from,
 				    loff_t *zero_len)
 {
 	unsigned offset = from & (PAGE_SIZE-1);
@@ -4190,8 +4200,7 @@ static int ext4_block_truncate_page(handle_t *handle,
 	blocksize = inode->i_sb->s_blocksize;
 	length = blocksize - (offset & (blocksize - 1));
 
-	ret = ext4_block_zero_page_range(handle, mapping, from, length,
-					 &did_zero);
+	ret = ext4_block_zero_page_range(mapping, from, length, &did_zero);
 	if (ret)
 		return ret;
 
@@ -4199,8 +4208,7 @@ static int ext4_block_truncate_page(handle_t *handle,
 	return 0;
 }
 
-int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
-			     loff_t lstart, loff_t length)
+int ext4_zero_partial_blocks(struct inode *inode, loff_t lstart, loff_t length)
 {
 	struct super_block *sb = inode->i_sb;
 	struct address_space *mapping = inode->i_mapping;
@@ -4218,21 +4226,19 @@ int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 	/* Handle partial zero within the single block */
 	if (start == end &&
 	    (partial_start || (partial_end != sb->s_blocksize - 1))) {
-		err = ext4_block_zero_page_range(handle, mapping,
-						 lstart, length, NULL);
+		err = ext4_block_zero_page_range(mapping, lstart, length, NULL);
 		return err;
 	}
 	/* Handle partial zero out on the start of the range */
 	if (partial_start) {
-		err = ext4_block_zero_page_range(handle, mapping,
-						 lstart, sb->s_blocksize,
-						 NULL);
+		err = ext4_block_zero_page_range(mapping, lstart,
+						 sb->s_blocksize, NULL);
 		if (err)
 			return err;
 	}
 	/* Handle partial zero out on the end of the range */
 	if (partial_end != sb->s_blocksize - 1)
-		err = ext4_block_zero_page_range(handle, mapping,
+		err = ext4_block_zero_page_range(mapping,
 						 byte_end - partial_end,
 						 partial_end + 1, NULL);
 	return err;
@@ -4418,6 +4424,10 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	/* Now release the pages and zero block aligned part of pages*/
 	truncate_pagecache_range(inode, offset, end - 1);
 
+	ret = ext4_zero_partial_blocks(inode, offset, length);
+	if (ret)
+		return ret;
+
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		credits = ext4_writepage_trans_blocks(inode);
 	else
@@ -4429,10 +4439,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		return ret;
 	}
 
-	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
-	if (ret)
-		goto out_handle;
-
 	/* If there are blocks to remove, do it */
 	start_lblk = round_up(offset, blocksize) >> inode->i_blkbits;
 	end_lblk = end >> inode->i_blkbits;
@@ -4564,6 +4570,8 @@ int ext4_truncate(struct inode *inode)
 		err = ext4_inode_attach_jinode(inode);
 		if (err)
 			goto out_trace;
+
+		ext4_block_truncate_page(mapping, inode->i_size, &zero_len);
 	}
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
@@ -4577,10 +4585,6 @@ int ext4_truncate(struct inode *inode)
 		goto out_trace;
 	}
 
-	if (inode->i_size & (inode->i_sb->s_blocksize - 1))
-		ext4_block_truncate_page(handle, mapping, inode->i_size,
-					 &zero_len);
-
 	if (zero_len && ext4_should_order_data(inode)) {
 		err = ext4_jbd2_inode_add_write(handle, inode, inode->i_size,
 						zero_len);
-- 
2.46.1


