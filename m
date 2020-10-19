Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA329210D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 04:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgJSCGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Oct 2020 22:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgJSCGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Oct 2020 22:06:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA816C061755;
        Sun, 18 Oct 2020 19:06:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a1so4729706pjd.1;
        Sun, 18 Oct 2020 19:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AXG6jOtPUaAkxpmExytpCYme+/qeZvBbz3J0v9qzZ18=;
        b=WFbGUJ2WtIpW6DzyFTfmz8G71mi3rgYBhkpKIHhVP8B6oibcHbSzBAGJ/wyico5Xt9
         VI9FVEuxOwe+aR4tHFCD4SP5/t8kZMULd3pN9wzb37QqsF4jguvrsNbzpvK7YdVBezZd
         9hrMFG7YCotLyp4+tVCWGlThDnDUWetZpdBZd6dl3bM1mwtN5WIUkUNu+smslD9jKCot
         jFRfInrxefBRUxdH4GgVC+spJPgR7MEEne1dj6nEgpDB8MRavPG8v8ciH+39NvGAbhPg
         8iO6TfkUhNvlPvRllJr2mre41lZIHXvg8XrRaczhqykk7Ud72+QrXWSkL4wVrGxcUMY4
         y8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AXG6jOtPUaAkxpmExytpCYme+/qeZvBbz3J0v9qzZ18=;
        b=Zy8Dtc9PQmijoF5prAz23qrPj4u3Eq5Y05d2EP3HoSfJ+bNkjDq5Q09wBD30VNNw2G
         W/xeJzWRYXltwh5lif63DkHyi1wtfzKsZz7gEAxt1PDnclb1LjObkWFWWf/u/QDbnLRZ
         /jpFCx3/FzrUoVwGZnWSvO9NzNVnMK4b7Xkb6dfLaSZHlIuqJsUXITyQNhHAZlO4tSpz
         4E8YdsWitNiXzgLItx72Rgcf1vdCHq46+ERqSTzyW4U8FVMZpjgEeqJIHbbzJtTQhGrk
         tNNwf5bEhHHRrwqBqvaRPRHxohZ8GN1eXLcs/AJnahPsJfSD+G1Z3ZXfLa7c27fg8k7A
         Vgkg==
X-Gm-Message-State: AOAM531QmxMyE15aMc641A6L9ozvi9k+EVUNc3/tyIE27n32Z3cnAejL
        mJK+W5rhhNvrSKLI5c/Pnsk=
X-Google-Smtp-Source: ABdhPJxYuP1xLOlfPEd1BqdPCKLphN7bnlTsjsA82B1IaWaveXu6vTtHGyUxcYCPMgve0iEZBNNIgg==
X-Received: by 2002:a17:902:56e:b029:d5:d861:6b17 with SMTP id 101-20020a170902056eb02900d5d8616b17mr7330110plf.17.1603073160313;
        Sun, 18 Oct 2020 19:06:00 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-190-108.hyg.mesh.ad.jp. [111.169.190.108])
        by smtp.gmail.com with ESMTPSA id y4sm9832891pgs.0.2020.10.18.19.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 19:05:59 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] exfat: add exfat_update_inode()
Date:   Mon, 19 Oct 2020 11:05:53 +0900
Message-Id: <20201019020554.28619-1-kohada.t2@gmail.com>
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
Changes in v4
 - no change
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
index 2932b23a3b6c..1f5f72eb5baf 100644
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
@@ -1347,19 +1335,13 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
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
@@ -1369,10 +1351,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 
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

