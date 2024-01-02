Return-Path: <linux-fsdevel+bounces-7112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2B6821C00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340C81C21FA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679F2FBF8;
	Tue,  2 Jan 2024 12:42:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72043156C8;
	Tue,  2 Jan 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4CD41MhMz4f3nKG;
	Tue,  2 Jan 2024 20:42:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CAF211A07FD;
	Tue,  2 Jan 2024 20:42:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnwUGUBJRl+EvDFQ--.31823S27;
	Tue, 02 Jan 2024 20:42:17 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v2 23/25] ext4: partially enable iomap for regular file's buffered IO path
Date: Tue,  2 Jan 2024 20:39:16 +0800
Message-Id: <20240102123918.799062-24-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnwUGUBJRl+EvDFQ--.31823S27
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyxGFy5GF1xXFy8XFyrWFg_yoWrXw18pF
	Wqkr1rGr4F93s29F4ftF48Zr1ava1xK3yUG3ySgwn5AFyrJ3WSqF10yF15AF1rJrZ5u3WS
	qF48CF15uw47urDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Partially enable iomap for regular file's buffered IO path on default
mount option and default filesystem features. Set inode state flag
EXT4_STATE_BUFFERED_IOMAP when creating one inode to indicate that this
inode choice the iomap path.

Now it still have many limitations, it doesn't support inline data,
fs_verity, fs_crypt, defrag, bigalloc, dax and data=journal mode yet, so
we have to fallback to buffered_head path if these options/features were
enabled. I hope these would be supported gradually in the future.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h   |  1 +
 fs/ext4/ialloc.c |  3 +++
 fs/ext4/inode.c  | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index eaf29bade606..16dce8701c5e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2972,6 +2972,7 @@ int ext4_walk_page_buffers(handle_t *handle,
 				     struct buffer_head *bh));
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
+bool ext4_should_use_buffered_iomap(struct inode *inode);
 int ext4_nonda_switch(struct super_block *sb);
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index e9bbb1da2d0a..956b9d69c559 100644
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
index 1ca2c995a889..2d2b8f2b634d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -759,6 +759,8 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
 
 	if (ext4_has_inline_data(inode))
 		return -ERANGE;
+	if (WARN_ON(ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)))
+		return -EINVAL;
 
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
@@ -2537,6 +2539,9 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 
 	trace_ext4_writepages(inode, wbc);
 
+	if (WARN_ON(ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)))
+		return -EINVAL;
+
 	/*
 	 * No pages to write? This is mainly a kludge to avoid starting
 	 * a transaction for special inodes like journal inode on last iput()
@@ -5024,6 +5029,32 @@ static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
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
+	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
+		return false;
+	if (!S_ISREG(inode->i_mode))
+		return false;
+	if (IS_DAX(inode))
+		return false;
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
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
@@ -5288,6 +5319,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (ret)
 		goto bad_inode;
 
+	if (ext4_should_use_buffered_iomap(inode))
+		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext4_file_inode_operations;
 		inode->i_fop = &ext4_file_operations;
-- 
2.39.2


