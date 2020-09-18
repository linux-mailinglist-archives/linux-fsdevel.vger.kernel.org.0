Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D1F26EF25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 04:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgIRCdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 22:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbgIRCde (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:33:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36860C06174A;
        Thu, 17 Sep 2020 19:33:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k14so2540931pgi.9;
        Thu, 17 Sep 2020 19:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAjLi3yUqHgXThWcwyho1+FN4wJQjNNxkWi1m1khT3o=;
        b=Kw4W+7IlKeNZM2TbJMi9lO/DJParnQeRhblrtS0q/hOjO5/j71ENbOLdNRPlaiQ2r7
         aZyYgiPNAuxbpLBERU9xxTe4gy8htq/XFvWd5yj+a1kS6InpqiKyirWIeYIZhXxWiclU
         3I6mw04Ip+7oaof0MjqanIeB4CdN/aHvUUi3XqVxgsnk61SXya/xTzJASDKX1ecCfP8N
         p7HGq94yjcrQfEg/grCe3LrnvGvumG9q9kawAirPcgp+icIvP7VY13MeMzuVJ5WoQaf1
         A9c/Kdj4jdKObxgbQML+WfBiNROxncgfTjVqfRjxp8GNDvPoUYVhUUNSQcHJ6ydopk4R
         Jw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAjLi3yUqHgXThWcwyho1+FN4wJQjNNxkWi1m1khT3o=;
        b=lR+mGPBOe8lRS0n9pCJUK/03zMqE9EVgxQQvK/+F3ttVu3scHG1ivjq5AAtZK7c0sV
         zAIy5hStYpGCdqSYDp9oCad6qLk5+BLSqAcEK83pbMFJDLSvD5Mv7HeFSCc0aQQG1Opd
         SNMCFxPBdDgdwwsdhuaZLitZ0F68gKflOsx07rw2W3TTyvSWkj23fF9gpoZS5ohrBHxD
         M9fxPAwA/gQnAfA2yPlw5o+3zx4lobZ76VVONqhcf3F5Ch/AF05n4B/CpgjAodTewpca
         w0rp8t9XtNwQXGPZ5aJP0ptaQT96xFiPqXG6shwgw7/NmBfuFC1BIPnVf+mem8HOY/vq
         Fc/A==
X-Gm-Message-State: AOAM532kcf8fRA7h0v+JR21ZJTifOILLdocWnpbn2+AcU0P89EvK2ePe
        eZBAM/p19rSpJI9XM0WFTBM=
X-Google-Smtp-Source: ABdhPJwUw4SJOlSmnwccvoDAnD7+vGYn/P4Uh6UP+RoWeK+g+zO0ISI9NEhaEDkG84C++IuyOfb/rg==
X-Received: by 2002:a62:8c88:0:b029:13e:d13d:a08b with SMTP id m130-20020a628c880000b029013ed13da08bmr29878986pfd.34.1600396413693;
        Thu, 17 Sep 2020 19:33:33 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-191-163.hyg.mesh.ad.jp. [111.169.191.163])
        by smtp.gmail.com with ESMTPSA id p11sm945198pjz.44.2020.09.17.19.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:33:33 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] exfat: add exfat_update_inode()
Date:   Fri, 18 Sep 2020 11:33:27 +0900
Message-Id: <20200918023328.17528-1-kohada.t2@gmail.com>
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
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/file.c     |  5 +----
 fs/exfat/inode.c    |  9 +++++++--
 fs/exfat/namei.c    | 35 +++++++----------------------------
 4 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 44dc04520175..3152c01e47ed 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -467,7 +467,7 @@ int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
 
 /* inode.c */
 extern const struct inode_operations exfat_file_inode_operations;
-void exfat_sync_inode(struct inode *inode);
+int exfat_update_inode(struct inode *inode);
 struct inode *exfat_build_inode(struct super_block *sb,
 		struct exfat_dir_entry *info, loff_t i_pos);
 void exfat_hash_inode(struct inode *inode, loff_t i_pos);
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 4831a39632a1..dcc99349b816 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -247,10 +247,7 @@ void exfat_truncate(struct inode *inode, loff_t size)
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
index 7f90204adef5..f307019afe88 100644
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
index b966b9120c9c..4febff3541a9 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -571,10 +571,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	inode_inc_iversion(dir);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
-	if (IS_DIRSYNC(dir))
-		exfat_sync_inode(dir);
-	else
-		mark_inode_dirty(dir);
+	exfat_update_inode(dir);
 
 	i_pos = exfat_make_i_pos(&info);
 	inode = exfat_build_inode(sb, &info, i_pos);
@@ -822,10 +819,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
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
@@ -856,10 +850,7 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	inode_inc_iversion(dir);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
-	if (IS_DIRSYNC(dir))
-		exfat_sync_inode(dir);
-	else
-		mark_inode_dirty(dir);
+	exfat_update_inode(dir);
 	inc_nlink(dir);
 
 	i_pos = exfat_make_i_pos(&info);
@@ -986,10 +977,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
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
@@ -1362,19 +1350,13 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
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
@@ -1384,10 +1366,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 
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

