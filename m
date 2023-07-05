Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C999B748D47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjGETIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGETHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:07:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FC42D7B;
        Wed,  5 Jul 2023 12:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C377D616D1;
        Wed,  5 Jul 2023 19:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C7BC433C7;
        Wed,  5 Jul 2023 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583852;
        bh=UuG0R0U0cRQYdeg+NT+3LnrqnY7pXt2obAtGOeiYJHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0OQBd/DHStoi63xy4zOgoCRQMzPX/Tn3+cI6hYTcwI603Hjonc/Xz5KVPuXljUbH
         Y4qRRIaEswFpGqfH3JzxWODp8tY3h+0yn4WzfWeL/9X2bBV7mWKZT+ZubpRCL0iou7
         7qCE3RLvIZmF08vYUG5Za1lNxD3R4U70X6I57XfADKxo3x9hwzWSrobT3aRK6noXK3
         YMXLOqkEvaDxe2pXjJAuOsGOO1GdhHxMzA4obec9kOGbvGBZJku7INl5rGqbZi5Dcw
         nMsHsOTzJI4HtolnS3oXblHRFk6pGL/51v6eMeiXrEBVIZZ3GO03XRbwoxNB4cv42X
         O1JU0gc+tYYJw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 40/92] exfat: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:05 -0400
Message-ID: <20230705190309.579783-38-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/exfat/file.c  |  4 ++--
 fs/exfat/inode.c |  6 +++---
 fs/exfat/namei.c | 21 +++++++++------------
 fs/exfat/super.c |  3 +--
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 3cbd270e0cba..f40ecfeee3a4 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -22,7 +22,7 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	if (err)
 		return err;
 
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 
 	if (!IS_SYNC(inode))
@@ -290,7 +290,7 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 
 	if (attr->ia_valid & ATTR_SIZE)
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_set_ctime_current(inode);
 
 	setattr_copy(&nop_mnt_idmap, inode, attr);
 	exfat_truncate_atime(&inode->i_atime);
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 481dd338f2b8..13329baeafbc 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -355,7 +355,7 @@ static void exfat_write_failed(struct address_space *mapping, loff_t to)
 
 	if (to > i_size_read(inode)) {
 		truncate_pagecache(inode, i_size_read(inode));
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_set_ctime_current(inode);
 		exfat_truncate(inode);
 	}
 }
@@ -398,7 +398,7 @@ static int exfat_write_end(struct file *file, struct address_space *mapping,
 		exfat_write_failed(mapping, pos+len);
 
 	if (!(err < 0) && !(ei->attr & ATTR_ARCHIVE)) {
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_set_ctime_current(inode);
 		ei->attr |= ATTR_ARCHIVE;
 		mark_inode_dirty(inode);
 	}
@@ -577,7 +577,7 @@ static int exfat_fill_inode(struct inode *inode, struct exfat_dir_entry *info)
 
 	inode->i_blocks = round_up(i_size_read(inode), sbi->cluster_size) >> 9;
 	inode->i_mtime = info->mtime;
-	inode->i_ctime = info->mtime;
+	inode_set_ctime_to_ts(inode, info->mtime);
 	ei->i_crtime = info->crtime;
 	inode->i_atime = info->atime;
 
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index e91022ff80ef..c007de6ac1c7 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -569,7 +569,7 @@ static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
 		goto unlock;
 
 	inode_inc_iversion(dir);
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
 	else
@@ -582,8 +582,7 @@ static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
 		goto unlock;
 
 	inode_inc_iversion(inode);
-	inode->i_mtime = inode->i_atime = inode->i_ctime =
-		EXFAT_I(inode)->i_crtime = current_time(inode);
+	inode->i_mtime = inode->i_atime = EXFAT_I(inode)->i_crtime = inode_set_ctime_current(inode);
 	exfat_truncate_atime(&inode->i_atime);
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
@@ -817,7 +816,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	ei->dir.dir = DIR_DELETED;
 
 	inode_inc_iversion(dir);
-	dir->i_mtime = dir->i_atime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = dir->i_atime = inode_set_ctime_current(dir);
 	exfat_truncate_atime(&dir->i_atime);
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
@@ -825,7 +824,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 		mark_inode_dirty(dir);
 
 	clear_nlink(inode);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	exfat_truncate_atime(&inode->i_atime);
 	exfat_unhash_inode(inode);
 	exfat_d_version_set(dentry, inode_query_iversion(dir));
@@ -852,7 +851,7 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto unlock;
 
 	inode_inc_iversion(dir);
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
 	else
@@ -866,8 +865,7 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto unlock;
 
 	inode_inc_iversion(inode);
-	inode->i_mtime = inode->i_atime = inode->i_ctime =
-		EXFAT_I(inode)->i_crtime = current_time(inode);
+	inode->i_mtime = inode->i_atime = EXFAT_I(inode)->i_crtime = inode_set_ctime_current(inode);
 	exfat_truncate_atime(&inode->i_atime);
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
@@ -979,7 +977,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	ei->dir.dir = DIR_DELETED;
 
 	inode_inc_iversion(dir);
-	dir->i_mtime = dir->i_atime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = dir->i_atime = inode_set_ctime_current(dir);
 	exfat_truncate_atime(&dir->i_atime);
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
@@ -988,7 +986,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	drop_nlink(dir);
 
 	clear_nlink(inode);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	exfat_truncate_atime(&inode->i_atime);
 	exfat_unhash_inode(inode);
 	exfat_d_version_set(dentry, inode_query_iversion(dir));
@@ -1353,8 +1351,7 @@ static int exfat_rename(struct mnt_idmap *idmap,
 			exfat_warn(sb, "abnormal access to an inode dropped");
 			WARN_ON(new_inode->i_nlink == 0);
 		}
-		new_inode->i_ctime = EXFAT_I(new_inode)->i_crtime =
-			current_time(new_inode);
+		EXFAT_I(new_inode)->i_crtime = inode_set_ctime_current(new_inode);
 	}
 
 unlock:
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8c32460e031e..8e0ca4b0fc8f 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -379,8 +379,7 @@ static int exfat_read_root(struct inode *inode)
 	ei->i_size_ondisk = i_size_read(inode);
 
 	exfat_save_attr(inode, ATTR_SUBDIR);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = ei->i_crtime =
-		current_time(inode);
+	inode->i_mtime = inode->i_atime = ei->i_crtime = inode_set_ctime_current(inode);
 	exfat_truncate_atime(&inode->i_atime);
 	return 0;
 }
-- 
2.41.0

