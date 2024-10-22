Return-Path: <linux-fsdevel+bounces-32571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19709A96E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9238128607D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F72E200CB1;
	Tue, 22 Oct 2024 03:13:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA61EABBF;
	Tue, 22 Oct 2024 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566790; cv=none; b=ZZVlk1jGAWmoMc9Occ9s9XGUJKYxAekEuEsLOHpr3yS1p+brZ5IylKHr4hH2vNKdPzWEbBA8dX1Ew3+Oh4r3t457CX4y3WI7O0aCHz/aZnRJK5yOuhmoUV9XgvRtfYckqjsU4Qbb9HsByCjzcRb8PojW0ebO/3WFpfvI82F3WEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566790; c=relaxed/simple;
	bh=UB+Gs3civCuEYlS4cLJVQslxb6/ZGgNvoifXv/YHRsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0Q5RspfAisFoKguoHd3lfBFAUcipQV7H3H2uImEZM+puS12NRyq53wrZZPQ2Z4PmhL0raJXRheaTiczuPwyrW9M+uFL9Zcj8ncEb09evSU7jpa9Xe1Yg6v5bAleOD7uCKhPeEw+DXE1uziflAGbk72HGUmmqKQ6TKMIdRs9bDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcgL2Rv3z4f3lVv;
	Tue, 22 Oct 2024 11:12:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 80E2A1A018D;
	Tue, 22 Oct 2024 11:13:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S28;
	Tue, 22 Oct 2024 11:13:04 +0800 (CST)
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
Subject: [PATCH 24/27] ext4: partially enable iomap for the buffered I/O path of regular files
Date: Tue, 22 Oct 2024 19:10:55 +0800
Message-ID: <20241022111059.2566137-25-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S28
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy3uF1xur47Wr1UGrW8tFb_yoWrGF15pF
	ZxKF1rGr4v93s29r4ftF48Zr1av3WxKa1UWrWSgr95XFWUJw1SqF10yF15A3W5JrZ5u34a
	qF4jkr15uw43urDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Partially enable iomap for the buffered I/O path of regular files with
the default mount option. This supports default filesystem features and
the bigalloc feature. However, it does not yet support inline data,
fs_verity, fs_crypt, online defrag and data=journal mode. Some of these
features should be supported gradually in the future. The filesystem
will fallback to the buffered_head path automatically if these mount
options or features are enabled.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h   |  1 +
 fs/ext4/ialloc.c |  3 +++
 fs/ext4/inode.c  | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e1b7f7024f07..0096191b454c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2987,6 +2987,7 @@ int ext4_walk_page_buffers(handle_t *handle,
 				     struct buffer_head *bh));
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
+bool ext4_should_use_buffered_iomap(struct inode *inode);
 int ext4_nonda_switch(struct super_block *sb);
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 7f1a5f90dbbd..2e3e257b9808 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1333,6 +1333,9 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
+	if (ext4_should_use_buffered_iomap(inode))
+		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
 	err = ext4_mark_inode_dirty(handle, inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 50e4afd17e93..512094dc4117 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -776,6 +776,8 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
 
 	if (ext4_has_inline_data(inode))
 		return -ERANGE;
+	if (WARN_ON(ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)))
+		return -EINVAL;
 
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
@@ -2572,6 +2574,9 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 
 	trace_ext4_writepages(inode, wbc);
 
+	if (WARN_ON(ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)))
+		return -EINVAL;
+
 	/*
 	 * No pages to write? This is mainly a kludge to avoid starting
 	 * a transaction for special inodes like journal inode on last iput()
@@ -5144,6 +5149,30 @@ static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
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
@@ -5408,6 +5437,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (ret)
 		goto bad_inode;
 
+	if (ext4_should_use_buffered_iomap(inode))
+		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext4_file_inode_operations;
 		inode->i_fop = &ext4_file_operations;
-- 
2.46.1


