Return-Path: <linux-fsdevel+bounces-76141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INodGj+WgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:31:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE34D541F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C682F3021547
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97D3859FF;
	Tue,  3 Feb 2026 06:30:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB7280309;
	Tue,  3 Feb 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100220; cv=none; b=N2MJ1UjmiuJVWN3doM7zT3uxF+hnXNKOsdxusr4/XM2Rr6y8hHz2gu8k+1CHDK+n7VbX0KUccwHQNCU5scKPUYTRiUA+G95bLPMm96jCokdHYaIn6cVmDCw8zPIVAH0oEnHp5FvlcoexuRs94QSznhpCew/WTfO6hL/xYMiIoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100220; c=relaxed/simple;
	bh=0H3W+6a71flSLzpqq6UEC3TaLlEPPuhZoaLQAw8asCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZtPGrmHxpGGRV68+kBiEEjxDBzPG5UuBXsZZhUTWQkx5jibj9w6WS9JI0h9+3UixhQJvgqg5R8CqUTirco4NfU6Xl6RefpVBQXMLzvHikmvbETP0RmWX1R+iOC+poYcqJhZsFkV1LDmrTzKl8gCSFEV4Wjn7NKT6QEhvAEr12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4tqq14jkzYQtxx;
	Tue,  3 Feb 2026 14:29:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 18EA440577;
	Tue,  3 Feb 2026 14:30:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S9;
	Tue, 03 Feb 2026 14:30:13 +0800 (CST)
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
Subject: [PATCH -next v2 05/22] ext4: stop passing handle to ext4_journalled_block_zero_range()
Date: Tue,  3 Feb 2026 14:25:05 +0800
Message-ID: <20260203062523.3869120-6-yi.zhang@huawei.com>
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
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S9
X-Coremail-Antispam: 1UD129KBjvJXoW3GF15WFW7tw48WFW3WryxGrg_yoWfXr1Dpr
	yUAw1rCr43uryq9F4xKFsFvr4a93Z7GFW8Gry7Gr9YvasrXw1xKF1DK3WrtFWjqrW7Wa10
	vF4Yy34jg3WUJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFPETDU
	UUU
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76141-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FE34D541F
X-Rspamd-Action: no action

When zeroing partial blocks, only the journal data mode requires an
active journal handle. Therefore, stop passing the handle to
ext4_zero_partial_blocks() and related functions, and make
ext4_journalled_block_zero_range() start a handle independently.

Currently, this change has no practical impact because all calls occur
within the context of an active handle. This change prepares for moving
ext4_block_truncate_page() out of an active handle, which is a
prerequisite for converting block zero range operations to the iomap
infrastructure because it requires active writeback after truncate down.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |  4 ++--
 fs/ext4/extents.c |  6 +++---
 fs/ext4/inode.c   | 54 +++++++++++++++++++++++++----------------------
 3 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e0ed273e2e8a..19d0b4917aea 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3103,8 +3103,8 @@ extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
 extern int ext4_chunk_trans_extent(struct inode *inode, int nrblocks);
 extern int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
-extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
-			     loff_t lstart, loff_t lend);
+extern int ext4_zero_partial_blocks(struct inode *inode,
+				loff_t lstart, loff_t lend);
 extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
 extern qsize_t *ext4_get_reserved_space(struct inode *inode);
 extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3630b27e4fd7..953bf8945bda 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4627,8 +4627,8 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 						      inode_get_ctime(inode));
 			if (epos > old_size) {
 				pagecache_isize_extended(inode, old_size, epos);
-				ext4_zero_partial_blocks(handle, inode,
-						     old_size, epos - old_size);
+				ext4_zero_partial_blocks(inode, old_size,
+						epos - old_size);
 			}
 		}
 		ret2 = ext4_mark_inode_dirty(handle, inode);
@@ -4746,7 +4746,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	}
 
 	/* Zero out partial block at the edges of the range */
-	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
+	ret = ext4_zero_partial_blocks(inode, offset, len);
 	if (ret)
 		goto out_handle;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7990ad566e10..c05b1c0a1b45 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1458,7 +1458,7 @@ static int ext4_write_end(const struct kiocb *iocb,
 
 	if (old_size < pos && !verity) {
 		pagecache_isize_extended(inode, old_size, pos);
-		ext4_zero_partial_blocks(handle, inode, old_size, pos - old_size);
+		ext4_zero_partial_blocks(inode, old_size, pos - old_size);
 	}
 	/*
 	 * Don't mark the inode dirty under folio lock. First, it unnecessarily
@@ -1576,7 +1576,7 @@ static int ext4_journalled_write_end(const struct kiocb *iocb,
 
 	if (old_size < pos && !verity) {
 		pagecache_isize_extended(inode, old_size, pos);
-		ext4_zero_partial_blocks(handle, inode, old_size, pos - old_size);
+		ext4_zero_partial_blocks(inode, old_size, pos - old_size);
 	}
 
 	if (size_changed) {
@@ -3252,7 +3252,7 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 	if (zero_len)
-		ext4_zero_partial_blocks(handle, inode, old_size, zero_len);
+		ext4_zero_partial_blocks(inode, old_size, zero_len);
 	ext4_mark_inode_dirty(handle, inode);
 	ext4_journal_stop(handle);
 
@@ -4126,16 +4126,23 @@ static int ext4_block_zero_range(struct inode *inode, loff_t from,
 	return 0;
 }
 
-static int ext4_journalled_block_zero_range(handle_t *handle,
-		struct inode *inode, loff_t from, loff_t length, bool *did_zero)
+static int ext4_journalled_block_zero_range(struct inode *inode, loff_t from,
+					    loff_t length, bool *did_zero)
 {
 	struct buffer_head *bh;
 	struct folio *folio;
+	handle_t *handle;
 	int err;
 
+	handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
 	bh = ext4_block_get_zero_range(inode, from, length);
-	if (IS_ERR_OR_NULL(bh))
-		return PTR_ERR_OR_ZERO(bh);
+	if (IS_ERR_OR_NULL(bh)) {
+		err = PTR_ERR_OR_ZERO(bh);
+		goto out_handle;
+	}
 	folio = bh->b_folio;
 
 	BUFFER_TRACE(bh, "get write access");
@@ -4156,6 +4163,8 @@ static int ext4_journalled_block_zero_range(handle_t *handle,
 out:
 	folio_unlock(folio);
 	folio_put(folio);
+out_handle:
+	ext4_journal_stop(handle);
 	return err;
 }
 
@@ -4166,9 +4175,9 @@ static int ext4_journalled_block_zero_range(handle_t *handle,
  * the end of the block it will be shortened to end of the block
  * that corresponds to 'from'
  */
-static int ext4_block_zero_page_range(handle_t *handle,
-		struct address_space *mapping, loff_t from, loff_t length,
-		bool *did_zero)
+static int ext4_block_zero_page_range(struct address_space *mapping,
+				      loff_t from, loff_t length,
+				      bool *did_zero)
 {
 	struct inode *inode = mapping->host;
 	unsigned blocksize = inode->i_sb->s_blocksize;
@@ -4185,7 +4194,7 @@ static int ext4_block_zero_page_range(handle_t *handle,
 		return dax_zero_range(inode, from, length, did_zero,
 				      &ext4_iomap_ops);
 	} else if (ext4_should_journal_data(inode)) {
-		return ext4_journalled_block_zero_range(handle, inode, from,
+		return ext4_journalled_block_zero_range(inode, from,
 							length, did_zero);
 	}
 	return ext4_block_zero_range(inode, from, length, did_zero);
@@ -4198,8 +4207,7 @@ static int ext4_block_zero_page_range(handle_t *handle,
  * of that block so it doesn't yield old data if the file is later grown.
  * Return the zeroed length on success.
  */
-static int ext4_block_truncate_page(handle_t *handle,
-		struct address_space *mapping, loff_t from)
+static int ext4_block_truncate_page(struct address_space *mapping, loff_t from)
 {
 	unsigned length;
 	unsigned blocksize;
@@ -4214,16 +4222,14 @@ static int ext4_block_truncate_page(handle_t *handle,
 	blocksize = i_blocksize(inode);
 	length = blocksize - (from & (blocksize - 1));
 
-	err = ext4_block_zero_page_range(handle, mapping, from, length,
-					 &did_zero);
+	err = ext4_block_zero_page_range(mapping, from, length, &did_zero);
 	if (err)
 		return err;
 
 	return did_zero ? length : 0;
 }
 
-int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
-			     loff_t lstart, loff_t length)
+int ext4_zero_partial_blocks(struct inode *inode, loff_t lstart, loff_t length)
 {
 	struct super_block *sb = inode->i_sb;
 	struct address_space *mapping = inode->i_mapping;
@@ -4241,20 +4247,19 @@ int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
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
-		err = ext4_block_zero_page_range(handle, mapping, lstart,
+		err = ext4_block_zero_page_range(mapping, lstart,
 						 sb->s_blocksize, NULL);
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
@@ -4462,7 +4467,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		return ret;
 	}
 
-	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
+	ret = ext4_zero_partial_blocks(inode, offset, length);
 	if (ret)
 		goto out_handle;
 
@@ -4614,8 +4619,7 @@ int ext4_truncate(struct inode *inode)
 	if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
 		unsigned int zero_len;
 
-		zero_len = ext4_block_truncate_page(handle, mapping,
-						    inode->i_size);
+		zero_len = ext4_block_truncate_page(mapping, inode->i_size);
 		if (zero_len < 0) {
 			err = zero_len;
 			goto out_stop;
@@ -5990,7 +5994,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				inode_set_mtime_to_ts(inode,
 						      inode_set_ctime_current(inode));
 				if (oldsize & (inode->i_sb->s_blocksize - 1))
-					ext4_block_truncate_page(handle,
+					ext4_block_truncate_page(
 							inode->i_mapping, oldsize);
 			}
 
-- 
2.52.0


