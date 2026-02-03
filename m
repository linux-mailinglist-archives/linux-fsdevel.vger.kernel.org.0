Return-Path: <linux-fsdevel+bounces-76138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AojNfuWgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:34:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 935B1D54B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CD7A3093D26
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B8337F8D0;
	Tue,  3 Feb 2026 06:30:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3BD2BDC10;
	Tue,  3 Feb 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100220; cv=none; b=DDpon+31ofT2dUsVc/rQz5iriBp9h7HaVptWRooQEvh0gKP8uiq7dGIt7Y2SIhg/TItAeShGm0vObzrz4c+ZRVy1l3DVcx6/4B8Z5Rvw5vQanSTyMVUMWClwXKuPwLUrsQrkX5NSYEipyFvm9VjeSGnSuPYiyW+EdmvSCGv8pzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100220; c=relaxed/simple;
	bh=rwwIn6WDq2HBFnr0u9BZcbT5Rj0V+aWP3Jpzj29fqDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY66X6bNQayjBHtJCrwF4r3znlzMGUzMcnX21SzZcGPX2KCdf7dg7ZRD5Q49Th+LpPF5ycXwCxlabsCuOJpqD6CnJd3ML8H3gzSqPu+eph+8mxn5DzWxzwb+sk2nnFy8K3ljxAH4yS76nMkzxAJTx5BkECBtr3sLmgc0vItHm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f4trJ6ffvzKHMb2;
	Tue,  3 Feb 2026 14:29:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3F23240573;
	Tue,  3 Feb 2026 14:30:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S11;
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
Subject: [PATCH -next v2 07/22] ext4: move ext4_block_zero_page_range() out of an active handle
Date: Tue,  3 Feb 2026 14:25:07 +0800
Message-ID: <20260203062523.3869120-8-yi.zhang@huawei.com>
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
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S11
X-Coremail-Antispam: 1UD129KBjvJXoW3Jry8Cw15ury5trW8Wr18Grg_yoW7ZF4Upr
	W3J3WfKr48ua4qgr4Ikr4DZr4Yk3W8Kr4UCrWIkr9YqasrZw1ftF1Yya40qFWUtrW8W3Wj
	vF4jkr17G3WUC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZyC
	LUUUUU=
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76138-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 935B1D54B8
X-Rspamd-Action: no action

In the cases of truncating up and beyond EOF with fallocate, since
truncating down, buffered writeback, and DIO write operations have
guaranteed that the on-disk data has been zeroed, only the data in
memory needs to be zeroed out. Therefore, it is safe to move the call to
ext4_block_zero_page_range() outside the active handle.

In the case of a partial zero range and a partial punch hole, the entire
operation does not require atomicity guarantees. Therefore, it is also
safe to move the ext4_block_zero_page_range() call outside the active
handle.

This change prepares for converting the block zero range to the iomap
infrastructure. The folio lock will be held during the zeroing process.
Since the iomap iteration process always holds the folio lock before
starting a new handle, we need to ensure that the folio lock is not held
while an active handle is in use; otherwise, a potential deadlock may
occur.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 31 ++++++++++++-------------------
 fs/ext4/inode.c   | 33 +++++++++++++++++----------------
 2 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 953bf8945bda..afe92e58ca8d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4625,11 +4625,6 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 			if (ext4_update_inode_size(inode, epos) & 0x1)
 				inode_set_mtime_to_ts(inode,
 						      inode_get_ctime(inode));
-			if (epos > old_size) {
-				pagecache_isize_extended(inode, old_size, epos);
-				ext4_zero_partial_blocks(inode, old_size,
-						epos - old_size);
-			}
 		}
 		ret2 = ext4_mark_inode_dirty(handle, inode);
 		ext4_update_inode_fsync_trans(handle, inode, 1);
@@ -4638,6 +4633,11 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 		if (unlikely(ret2))
 			break;
 
+		if (new_size && epos > old_size) {
+			pagecache_isize_extended(inode, old_size, epos);
+			ext4_zero_partial_blocks(inode, old_size,
+						 epos - old_size);
+		}
 		if (alloc_zero &&
 		    (map.m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN))) {
 			ret2 = ext4_issue_zeroout(inode, map.m_lblk, map.m_pblk,
@@ -4673,7 +4673,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	ext4_lblk_t start_lblk, end_lblk;
 	unsigned int blocksize = i_blocksize(inode);
 	unsigned int blkbits = inode->i_blkbits;
-	int ret, flags, credits;
+	int ret, flags;
 
 	trace_ext4_zero_range(inode, offset, len, mode);
 	WARN_ON_ONCE(!inode_is_locked(inode));
@@ -4731,25 +4731,18 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (IS_ALIGNED(offset | end, blocksize))
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
+	handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(inode->i_sb, ret);
 		return ret;
 	}
 
-	/* Zero out partial block at the edges of the range */
-	ret = ext4_zero_partial_blocks(inode, offset, len);
-	if (ret)
-		goto out_handle;
-
 	if (new_size)
 		ext4_update_inode_size(inode, new_size);
 	ret = ext4_mark_inode_dirty(handle, inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e67c750866a5..9c0e70256527 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4456,8 +4456,12 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (ret)
 		return ret;
 
+	ret = ext4_zero_partial_blocks(inode, offset, length);
+	if (ret)
+		return ret;
+
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		credits = ext4_chunk_trans_extent(inode, 2);
+		credits = ext4_chunk_trans_extent(inode, 0);
 	else
 		credits = ext4_blocks_for_truncate(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
@@ -4467,10 +4471,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		return ret;
 	}
 
-	ret = ext4_zero_partial_blocks(inode, offset, length);
-	if (ret)
-		goto out_handle;
-
 	/* If there are blocks to remove, do it */
 	start_lblk = EXT4_B_TO_LBLK(inode, offset);
 	end_lblk = end >> inode->i_blkbits;
@@ -5973,15 +5973,6 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 					goto out_mmap_sem;
 			}
 
-			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
-			if (IS_ERR(handle)) {
-				error = PTR_ERR(handle);
-				goto out_mmap_sem;
-			}
-			if (ext4_handle_valid(handle) && shrink) {
-				error = ext4_orphan_add(handle, inode);
-				orphan = 1;
-			}
 			/*
 			 * Update c/mtime and tail zero the EOF folio on
 			 * truncate up. ext4_truncate() handles the shrink case
@@ -5989,10 +5980,20 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			 */
 			if (!shrink) {
 				inode_set_mtime_to_ts(inode,
-						      inode_set_ctime_current(inode));
+						inode_set_ctime_current(inode));
 				if (oldsize & (inode->i_sb->s_blocksize - 1))
 					ext4_block_truncate_page(
-							inode->i_mapping, oldsize);
+						inode->i_mapping, oldsize);
+			}
+
+			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
+			if (IS_ERR(handle)) {
+				error = PTR_ERR(handle);
+				goto out_mmap_sem;
+			}
+			if (ext4_handle_valid(handle) && shrink) {
+				error = ext4_orphan_add(handle, inode);
+				orphan = 1;
 			}
 
 			if (shrink)
-- 
2.52.0


