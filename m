Return-Path: <linux-fsdevel+bounces-35786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE6D9D84C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8091728960E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E001B3935;
	Mon, 25 Nov 2024 11:46:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272EC1AB6FA;
	Mon, 25 Nov 2024 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535197; cv=none; b=HFqT+inFc9IrIIy2jlD+rnG2XtMt0FTIvYQMj5Rj+fd7QqfQuw0GvbDkau1CQv9jAbeiOyahAJ81xHMHDg33wEXZaN8sZN57WpVLiHC6E02sEfJ8RsvV3r1K3fopaqzmYg2pPKhdKtJYduVWUD/ja2/Y4pK5p70ckONjPzFh9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535197; c=relaxed/simple;
	bh=dAiakTdG/9VWPzXgKVuwrxfKHzNh/YjUe+NPumXjyLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU1Wf3n+KEnGQ6qrKWca1gPfuI0XQICPkO6cBbSVlkixG7CRn7finsFnYUFrmuP8aEdrAQMEc3B5gpl/vRg/25ziFh9rBd3qOn80PAYTDq2p3jywek8xFqTKOJVPHcrPcdz+NAsahyNZHPBfHXSfB1D1kJ5eEZ6HfUIrqEGtzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XxkSB1wkXz4f3kq5;
	Mon, 25 Nov 2024 19:46:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF9621A0568;
	Mon, 25 Nov 2024 19:46:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4eFY0RnNicrCw--.44046S13;
	Mon, 25 Nov 2024 19:46:31 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	brauner@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC 9/9] ext4: enable large folio for regular file
Date: Mon, 25 Nov 2024 19:44:19 +0800
Message-ID: <20241125114419.903270-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
References: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4eFY0RnNicrCw--.44046S13
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWUuFWrXFyrGrW5ZrWrZrb_yoWrAF18pF
	WUGa4rGr4DZa4q9a1xtr4UZr1Yva4xGw4UGFZ3u39xX39rJ34IqF18tF1rAF45trWrWw4a
	qF17Kr1UuanxCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Besides fsverity, fscrypt, and data=journal mode, ext4 can support large
folios for regular files. Let's enable this feature.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---

The side effect of this patch is that we will no longer be able to
change the active inode's journal flag through
ext4_change_inode_journal_flag(). Since we always enable large folios
for regular files, but we cannot enable large folios for journal data
mode because it can easily exceed journal handle credits. If we want to
enable journal data mode online for an active inode, we must first drop
all of the inode's page cache and disable large folios before
conversion. However, disabling large folios is currently not permitted
on active inodes because it may not safe, which means we will lose the
ability to convert to online journal mode after this patch.

The data journal mode is not recommended and should probably be removed
in the future, I suppose we don't want to find a way to support this
mode, so can we just kill the online conversion now?

 fs/ext4/ext4.h      |  1 +
 fs/ext4/ext4_jbd2.c |  3 ++-
 fs/ext4/ialloc.c    |  3 +++
 fs/ext4/inode.c     | 19 +++++++++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..48de159a9508 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2983,6 +2983,7 @@ int ext4_walk_page_buffers(handle_t *handle,
 				     struct buffer_head *bh));
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
+bool ext4_should_enable_large_folio(struct inode *inode);
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
 
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index da4a82456383..8fa0c9bad715 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -16,7 +16,8 @@ int ext4_inode_journal_mode(struct inode *inode)
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
 	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
-	    !test_opt(inode->i_sb, DELALLOC))) {
+	    !test_opt(inode->i_sb, DELALLOC) &&
+	    !mapping_large_folio_support(inode->i_mapping))) {
 		/* We do not support data journalling for encrypted data */
 		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
 			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 7f1a5f90dbbd..cef7aee5ae02 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1333,6 +1333,9 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
+	if (ext4_should_enable_large_folio(inode))
+		mapping_set_large_folios(inode->i_mapping);
+
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
 	err = ext4_mark_inode_dirty(handle, inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c0179b07d753..8f9a16908503 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4702,6 +4702,22 @@ static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
 	return NULL;
 }
 
+bool ext4_should_enable_large_folio(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+
+	if (!S_ISREG(inode->i_mode))
+		return false;
+	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
+		return false;
+	if (ext4_has_feature_verity(sb))
+		return false;
+	if (ext4_has_feature_encrypt(sb))
+		return false;
+
+	return true;
+}
+
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			  ext4_iget_flags flags, const char *function,
 			  unsigned int line)
@@ -4970,6 +4986,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		inode->i_op = &ext4_file_inode_operations;
 		inode->i_fop = &ext4_file_operations;
 		ext4_set_aops(inode);
+
+		if (ext4_should_enable_large_folio(inode))
+			mapping_set_large_folios(inode->i_mapping);
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &ext4_dir_inode_operations;
 		inode->i_fop = &ext4_dir_operations;
-- 
2.46.1


