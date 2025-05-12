Return-Path: <linux-fsdevel+bounces-48701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AC9AB2FFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBBA189B58F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 06:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D03725A2AD;
	Mon, 12 May 2025 06:44:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFCF2561BF;
	Mon, 12 May 2025 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032297; cv=none; b=cFTOfTar/dWxUt3mqn/aynwBTdonR/gfOFJsdSwyjTWxBTiZItSwX5sO8VXSlWN3XzNHtrRbIum2fJxsEzBHQHK0+j+5rDZXu2zsrsPANY98t3xu4TZivtvQ5TmuVa1dmilGOuySm6KBkTF2tRj56VJtdsYtfIQY8YnGtdx1Lrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032297; c=relaxed/simple;
	bh=/QHM0b8IQexwJXPk5mDecCae6vIO/KpZKjBNsnEQX2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEUkdz6ymD3pXGdkD1/oYZrohl7GWqA4l6lvtjuFnAgHM3TScxR4qJCorydKX8ggY4pyDdKq1qsMvWJLlSGNT7yFPQP1QmdzQhaG9SEc/vWWb+J1gzf1wVrzIP6XsZ/wW5VHic6EiG7c8EQ/W/Qh4JYeaJ0nqS0xFjafXMNYx10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4Zwqps5nHpzKHMmt;
	Mon, 12 May 2025 14:44:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7BD2A1A07BD;
	Mon, 12 May 2025 14:44:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2DXmCFoxF6sMA--.62010S12;
	Mon, 12 May 2025 14:44:52 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 8/8] ext4: enable large folio for regular file
Date: Mon, 12 May 2025 14:33:19 +0800
Message-ID: <20250512063319.3539411-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHK2DXmCFoxF6sMA--.62010S12
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW3Jry3ZFW5WrWfAr4UCFg_yoW5Kr1DpF
	y3Ga4rGr4Dua4q9w4xKr4UZr1aq3WxGw4UC3yfuws8Xay7X34IqF4jyF1rA3W5trWkWa1S
	qF1jkr1UuanxC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUljgxUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Besides fsverity, fscrypt, and the data=journal mode, ext4 now supports
large folios for regular files. Enable this feature by default. However,
since we cannot change the folio order limitation of mappings on active
inodes, setting the journal=data mode via ioctl on an active inode will
not take immediate effect in non-delalloc mode.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h      |  1 +
 fs/ext4/ext4_jbd2.c |  3 ++-
 fs/ext4/ialloc.c    |  3 +++
 fs/ext4/inode.c     | 20 ++++++++++++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5a20e9cd7184..2fad90c30493 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2993,6 +2993,7 @@ int ext4_walk_page_buffers(handle_t *handle,
 				     struct buffer_head *bh));
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
+bool ext4_should_enable_large_folio(struct inode *inode);
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
 
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 135e278c832e..b3e9b7bd7978 100644
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
index e7ecc7c8a729..4938e78cbadc 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1336,6 +1336,9 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
+	if (ext4_should_enable_large_folio(inode))
+		mapping_set_large_folios(inode->i_mapping);
+
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
 	err = ext4_mark_inode_dirty(handle, inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 29eccdf8315a..7fd3921cfe46 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4774,6 +4774,23 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
 	return -EFSCORRUPTED;
 }
 
+bool ext4_should_enable_large_folio(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+
+	if (!S_ISREG(inode->i_mode))
+		return false;
+	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
+	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
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
@@ -5096,6 +5113,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
+	if (ext4_should_enable_large_folio(inode))
+		mapping_set_large_folios(inode->i_mapping);
+
 	ret = check_igot_inode(inode, flags, function, line);
 	/*
 	 * -ESTALE here means there is nothing inherently wrong with the inode,
-- 
2.46.1


