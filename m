Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61618280D44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 08:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgJBGF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 02:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgJBGF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:05:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A48C0613D0;
        Thu,  1 Oct 2020 23:05:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 197so141709pge.8;
        Thu, 01 Oct 2020 23:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=52QdXRrisB7Xu1g8Hm35aJcmi6V7/TNcWFYdkzoSlIk=;
        b=GyTeS9CbSYPgx1ihzJjv05CNlpMQTQdgKvxzBmUuiJYagF24Dc2l9UN68OeNykfDfc
         KyFx4KE54xcWy03f4FkjMcdqNTn9/4vNiM6iN7/j/VkY6WXcSRVHnCQoZ6F0pM0AvqOf
         VaAnXv2E9nsR3CtIZLhNpjzduSVzqfmyja7vGsF+t7+aVDMFVKCRzMoHcHkQYV2F33ut
         ajQcs4n+BM/T6G0R4LDTn89MgLFfck/wwHAbAqoqq7aZ8B68XmQv3s0ksI1XKs3J0G30
         OL4KV7Lw3p36R7zZY5jGr0oVXyN6+8oMf6H3+mgrwNTgFjgemiCfmVwFe3BrADQjjutK
         UKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=52QdXRrisB7Xu1g8Hm35aJcmi6V7/TNcWFYdkzoSlIk=;
        b=cOvhBRv51W7QdTNh9K+Hd/atGgfcEk2ikCNTwMBbC/55DQb4FdL0n/f0rLZzpJTVIz
         a6p4CdPSeH02VeZRE8D1H2bydmA9ZEldh1UP3xBS5TpUK1yIRtOOdk1ZzakJAdba02HD
         sZlJT2TCAhnmXNVITL7h8bDbeFHIYkam8lAaULqKv5fDPQ0O5f1Nn9fvlUo2CwRf9ejK
         Rck5RTNzwNWwqMnBFTc5ZjdN7Wm4jEmx/Q4nMXVa3LD+RniFWl+P856M/D5qbySQoE0S
         Ta1AqC5l9bGHV3cq3e4BRW/hdaZfvbS0fYW3uG97orPsqoDoraDNccaHUD20MIJ+sfxA
         ZtMA==
X-Gm-Message-State: AOAM531KDe9AiULscFGXDFR7Y3e7b3mwK8sxhmK0v+Dg8otqlBY+eR/L
        roSihyFkR4lK1jznPSe5/U52Apotcj2GTA==
X-Google-Smtp-Source: ABdhPJyf1oW8shBkaqVljJMtFNeYu3pJr/+FiKm8QiMJPSwKI2ftMqxF3DlLh6pHQAp/Sd3KEb/WVQ==
X-Received: by 2002:a63:c30a:: with SMTP id c10mr557035pgd.377.1601618726950;
        Thu, 01 Oct 2020 23:05:26 -0700 (PDT)
Received: from dc803.localdomain (flh2-125-196-131-224.osk.mesh.ad.jp. [125.196.131.224])
        by smtp.gmail.com with ESMTPSA id b11sm544995pfd.33.2020.10.01.23.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 23:05:26 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] exfat: add exfat_update_inode()
Date:   Fri,  2 Oct 2020 15:05:04 +0900
Message-Id: <20201002060505.27449-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Integrate exfat_sync_inode() and mark_inode_dirty() as exfat_update_inode()
Also, return the result of _exfat_write_inode () when sync is specified.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v3
 - no change
Changes in v2
 - no change

 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/file.c     |  5 +----
 fs/exfat/inode.c    |  9 +++++++--
 fs/exfat/namei.c    | 35 +++++++----------------------------
 4 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index b8f0e829ecbd..ec0ee516aee2 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -466,7 +466,7 @@ int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
 
 /* inode.c */
 extern const struct inode_operations exfat_file_inode_operations;
-void exfat_sync_inode(struct inode *inode);
+int exfat_update_inode(struct inode *inode);
 struct inode *exfat_build_inode(struct super_block *sb,
 		struct exfat_dir_entry *info, loff_t i_pos);
 void exfat_hash_inode(struct inode *inode, loff_t i_pos);
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index a92478eabfa4..e510b95dbf77 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -245,10 +245,7 @@ void exfat_truncate(struct inode *inode, loff_t size)
 		goto write_size;
 
 	inode->i_ctime = inode->i_mtime = current_time(inode);
-	if (IS_DIRSYNC(inode))
-		exfat_sync_inode(inode);
-	else
-		mark_inode_dirty(inode);
+	exfat_update_inode(inode);
 
 	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1)) &
 			~(sbi->cluster_size - 1)) >> inode->i_blkbits;
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 730373e0965a..5a55303e1f65 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -91,10 +91,15 @@ int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return ret;
 }
 
-void exfat_sync_inode(struct inode *inode)
+int exfat_update_inode(struct inode *inode)
 {
 	lockdep_assert_held(&EXFAT_SB(inode->i_sb)->s_lock);
-	__exfat_write_inode(inode, 1);
+
+	if (IS_DIRSYNC(inode))
+		return __exfat_write_inode(inode, 1);
+
+	mark_inode_dirty(inode);
+	return 0;
 }
 
 /*
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 676094f2abe2..4eb7cb528e97 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -561,10 +561,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	inode_inc_iversion(dir);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
-	if (IS_DIRSYNC(dir))
-		exfat_sync_inode(dir);
-	else
-		mark_inode_dirty(dir);
+	exfat_update_inode(dir);
 
 	i_pos = exfat_make_i_pos(&info);
 	inode = exfat_build_inode(sb, &info, i_pos);
@@ -812,10 +809,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	inode_inc_iversion(dir);
 	dir->i_mtime = dir->i_atime = current_time(dir);
 	exfat_truncate_atime(&dir->i_atime);
-	if (IS_DIRSYNC(dir))
-		exfat_sync_inode(dir);
-	else
-		mark_inode_dirty(dir);
+	exfat_update_inode(dir);
 
 	clear_nlink(inode);
 	inode->i_mtime = inode->i_atime = current_time(inode);
@@ -846,10 +840,7 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	inode_inc_iversion(dir);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
-	if (IS_DIRSYNC(dir))
-		exfat_sync_inode(dir);
-	else
-		mark_inode_dirty(dir);
+	exfat_update_inode(dir);
 	inc_nlink(dir);
 
 	i_pos = exfat_make_i_pos(&info);
@@ -976,10 +967,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	inode_inc_iversion(dir);
 	dir->i_mtime = dir->i_atime = current_time(dir);
 	exfat_truncate_atime(&dir->i_atime);
-	if (IS_DIRSYNC(dir))
-		exfat_sync_inode(dir);
-	else
-		mark_inode_dirty(dir);
+	exfat_update_inode(dir);
 	drop_nlink(dir);
 
 	clear_nlink(inode);
@@ -1352,19 +1340,13 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	new_dir->i_ctime = new_dir->i_mtime = new_dir->i_atime =
 		EXFAT_I(new_dir)->i_crtime = current_time(new_dir);
 	exfat_truncate_atime(&new_dir->i_atime);
-	if (IS_DIRSYNC(new_dir))
-		exfat_sync_inode(new_dir);
-	else
-		mark_inode_dirty(new_dir);
+	exfat_update_inode(new_dir);
 
 	i_pos = ((loff_t)EXFAT_I(old_inode)->dir.dir << 32) |
 		(EXFAT_I(old_inode)->entry & 0xffffffff);
 	exfat_unhash_inode(old_inode);
 	exfat_hash_inode(old_inode, i_pos);
-	if (IS_DIRSYNC(new_dir))
-		exfat_sync_inode(old_inode);
-	else
-		mark_inode_dirty(old_inode);
+	exfat_update_inode(old_inode);
 
 	if (S_ISDIR(old_inode->i_mode) && old_dir != new_dir) {
 		drop_nlink(old_dir);
@@ -1374,10 +1356,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	inode_inc_iversion(old_dir);
 	old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
-	if (IS_DIRSYNC(old_dir))
-		exfat_sync_inode(old_dir);
-	else
-		mark_inode_dirty(old_dir);
+	exfat_update_inode(old_dir);
 
 	if (new_inode) {
 		exfat_unhash_inode(new_inode);
-- 
2.25.1

