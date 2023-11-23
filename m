Return-Path: <linux-fsdevel+bounces-3533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6DC7F5F84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 13:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7EB1C21020
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662372FC3B;
	Thu, 23 Nov 2023 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A71D42;
	Thu, 23 Nov 2023 04:52:09 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SbdKx1W93z4f3l25;
	Thu, 23 Nov 2023 20:52:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DFB191A0726;
	Thu, 23 Nov 2023 20:52:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xHdSl9lSfnfBg--.20473S21;
	Thu, 23 Nov 2023 20:52:06 +0800 (CST)
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
Subject: [RFC PATCH 17/18] ext4: partial enable iomap for regular file's buffered IO path
Date: Thu, 23 Nov 2023 20:51:19 +0800
Message-Id: <20231123125121.4064694-18-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDn6xHdSl9lSfnfBg--.20473S21
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4UAryxCw1fCw47AF17trb_yoWxAr47pr
	ZIkr1rGw4ku3sF9a1ftF4UZr1Yk3WxKw4UWryS9r1fXFZrX34SqF18tF15A3W5trW8uw1S
	qF40kr1UWw43CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Partial enable iomap for regular file's buffered IO path on default
mount option and default filesystem features. Does not support inline
data, fs_verity, fs_crypt, bigalloc, dax and data=journal mode yet,
those will be supported in the future.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h        |  2 ++
 fs/ext4/ext4_jbd2.c   |  3 ++-
 fs/ext4/file.c        |  8 +++++++-
 fs/ext4/ialloc.c      |  3 +++
 fs/ext4/inode.c       | 31 +++++++++++++++++++++++++++++++
 fs/ext4/move_extent.c |  8 ++++++++
 6 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6b3e34ea58ad..7ce688cb1b07 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2959,6 +2959,7 @@ int ext4_walk_page_buffers(handle_t *handle,
 				     struct buffer_head *bh));
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
+extern bool ext4_should_use_buffered_iomap(struct inode *inode);
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
 
@@ -3822,6 +3823,7 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
 extern const struct iomap_ops ext4_iomap_ops;
 extern const struct iomap_ops ext4_iomap_overwrite_ops;
 extern const struct iomap_ops ext4_iomap_report_ops;
+extern const struct iomap_ops ext4_iomap_buffered_write_ops;
 
 static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 {
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index d1a2e6624401..cf25cdda7234 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -16,7 +16,8 @@ int ext4_inode_journal_mode(struct inode *inode)
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
 	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
-	    !test_opt(inode->i_sb, DELALLOC))) {
+	     !ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP) &&
+	     !test_opt(inode->i_sb, DELALLOC))) {
 		/* We do not support data journalling for encrypted data */
 		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
 			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 15fe65744cba..7e3352b3b752 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -296,7 +296,11 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	if (ret <= 0)
 		goto out;
 
-	ret = generic_perform_write(iocb, from);
+	if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP))
+		ret = iomap_file_buffered_write(iocb, from,
+						&ext4_iomap_buffered_write_ops);
+	else
+		ret = generic_perform_write(iocb, from);
 
 out:
 	inode_unlock(inode);
@@ -823,6 +827,8 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (IS_DAX(file_inode(file))) {
 		vma->vm_ops = &ext4_dax_vm_ops;
 		vm_flags_set(vma, VM_HUGEPAGE);
+	} else if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)) {
+		vma->vm_ops = &ext4_iomap_file_vm_ops;
 	} else {
 		vma->vm_ops = &ext4_file_vm_ops;
 	}
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b65058d972f9..0aae2810dbf6 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1336,6 +1336,9 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
+	if (ext4_should_use_buffered_iomap(inode))
+		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+
 	if (ext4_handle_valid(handle)) {
 		ei->i_sync_tid = handle->h_transaction->t_tid;
 		ei->i_datasync_tid = handle->h_transaction->t_tid;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b2ab202af57b..f95d4c321cbb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -779,6 +779,8 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
 
 	if (ext4_has_inline_data(inode))
 		return -ERANGE;
+	if (WARN_ON(ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)))
+		return -EINVAL;
 
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
@@ -4121,6 +4123,8 @@ void ext4_set_aops(struct inode *inode)
 	}
 	if (IS_DAX(inode))
 		inode->i_mapping->a_ops = &ext4_dax_aops;
+	else if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP))
+		inode->i_mapping->a_ops = &ext4_iomap_aops;
 	else if (test_opt(inode->i_sb, DELALLOC))
 		inode->i_mapping->a_ops = &ext4_da_aops;
 	else
@@ -5185,6 +5189,30 @@ static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
 	return NULL;
 }
 
+bool ext4_should_use_buffered_iomap(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+
+	if (ext4_has_feature_inline_data(sb))
+		return false;
+	if (ext4_has_feature_verity(sb))
+		return false;
+	if (ext4_has_feature_bigalloc(sb))
+		return false;
+	if (!IS_DAX(inode))
+		return false;
+	if (!S_ISREG(inode->i_mode))
+		return false;
+	if (ext4_should_journal_data(inode))
+		return false;
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE))
+		return false;
+	if (ext4_test_inode_flag(inode, EXT4_INODE_ENCRYPT))
+		return false;
+
+	return true;
+}
+
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			  ext4_iget_flags flags, const char *function,
 			  unsigned int line)
@@ -5449,6 +5477,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (ret)
 		goto bad_inode;
 
+	if (ext4_should_use_buffered_iomap(inode))
+		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext4_file_inode_operations;
 		inode->i_fop = &ext4_file_operations;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 18a9e7c47975..23b4b77c5af8 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -597,6 +597,14 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		return -EOPNOTSUPP;
 	}
 
+	/* TODO: not supported since block getting function is not switched */
+	if (ext4_test_inode_state(orig_inode, EXT4_STATE_BUFFERED_IOMAP) ||
+	    ext4_test_inode_state(donor_inode, EXT4_STATE_BUFFERED_IOMAP)) {
+		ext4_msg(orig_inode->i_sb, KERN_ERR,
+			 "Online defrag not supported with buffered iomap");
+		return -EOPNOTSUPP;
+	}
+
 	if (IS_ENCRYPTED(orig_inode) || IS_ENCRYPTED(donor_inode)) {
 		ext4_msg(orig_inode->i_sb, KERN_ERR,
 			 "Online defrag not supported for encrypted files");
-- 
2.39.2


