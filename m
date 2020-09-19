Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10797271173
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Sep 2020 01:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgISX6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 19:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgISX6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 19:58:39 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D2DC061755;
        Sat, 19 Sep 2020 16:58:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so5925301pff.6;
        Sat, 19 Sep 2020 16:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+D60sK6ulXBM+jVaN5g99sd0MUnvJyqKAb1K91qzmcY=;
        b=M5pgWxkisK7s9J2kp99bhYPk9l056QGctt6W/OFTsvRVq5nXxGDbUT7tOBBotl84p3
         ntoB49tPOd0IoFkjXJz5a33q7a/e987VfDs7WGWAQz0MeF8xNVP6ODR0nwDhTcMVpZQA
         qOEuw4bWXzAM6rlNl3uuME+JOI4kR74yfgz1umnpS2Hn9IX1CWxUkZ3UuDUfFBfs6FBf
         hQuNCQHPq8OD+aCGP7ot6YG3GySq4FIZwItfTpScvMHnBqfJZanOphOaZyRZluZSODjm
         4lZtNXst141BnVLCBN2zjhvFb8TNw1HXNXszsGJUi7o7my0OXCL74xUoYZylngmakvpv
         9bgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+D60sK6ulXBM+jVaN5g99sd0MUnvJyqKAb1K91qzmcY=;
        b=lrgWRa41QfzwJhhchGnQnzcLBZWxv3sojsQ0cO7bDX/okTaFcehxBHpdVQFr5UDKrz
         Kh1IjZM5l2eD/fc4EYaFBKc66o+4dfYI/H17WyLIYGQq7wKUysGIaZnOxsZkgnFR3nvp
         pFuVdFTFwCVF8HDdLg+bpvbyb50IXNlAXEo/nexKNj2gei2ps7SSzzk3GySqiv0h8ytS
         BzhkZDou1G/DAYIXiF+PAzpvDZwYTacagxVTeAPajJLjM/SO6MYSYRfwuV/b6isUu4Kc
         31VUGl3MItoxQ4vd0IeVVzX6Qu1SzRn33jHim2jCl65gvPpXWu9A5gGYx9fVAXFuy5ue
         QPiQ==
X-Gm-Message-State: AOAM532lokqVcuH7vgKDPbrlYTU0PKsu0DxwUEdTxf94546LKN133llv
        dysbfMK+nK8ffnJ1HoonWNQNKK+FgjU=
X-Google-Smtp-Source: ABdhPJyisBm6IwdixmV4FwpBLStkTlokQZyLp18tN/JY65/HL2l2tmXqX/jQiJfDc9bnSemy2WF4GA==
X-Received: by 2002:a05:6a00:2b1:b029:142:440b:fca9 with SMTP id q17-20020a056a0002b1b0290142440bfca9mr18673595pfs.15.1600559918465;
        Sat, 19 Sep 2020 16:58:38 -0700 (PDT)
Received: from dc803.localdomain (FL1-133-208-231-143.hyg.mesh.ad.jp. [133.208.231.143])
        by smtp.gmail.com with ESMTPSA id kt18sm6583615pjb.56.2020.09.19.16.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 16:58:37 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] exfat: add exfat_update_inode()
Date:   Sun, 20 Sep 2020 08:58:32 +0900
Message-Id: <20200919235832.14962-1-kohada.t2@gmail.com>
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
Changes in v2
 - no change

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

