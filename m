Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9B5339BBE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhCMEk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:40:58 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33568 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhCMEkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:36 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2j-005Nzi-0V; Sat, 13 Mar 2021 04:38:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Richard Weinberger <richard@nod.at>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 05/15] vboxsf: don't allow to change the inode type
Date:   Sat, 13 Mar 2021 04:38:14 +0000
Message-Id: <20210313043824.1283821-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
References: <YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk>
 <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vboxsf_init_inode() is used both for initial setup of inode and for metadata
updates.  Tell it whether we are updating a live inode or setting up a new
instance and have it refuse to change type in the former case.

[fixed the braino caught by Hans de Goede <hdegoede@redhat.com>]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/vboxsf/dir.c    |  4 ++--
 fs/vboxsf/super.c  |  4 ++--
 fs/vboxsf/utils.c  | 68 ++++++++++++++++++++++++++++++++++--------------------
 fs/vboxsf/vfsmod.h |  4 ++--
 4 files changed, 49 insertions(+), 31 deletions(-)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 7aee0ec63ade..eac6788fc6cf 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -225,7 +225,7 @@ static struct dentry *vboxsf_dir_lookup(struct inode *parent,
 	} else {
 		inode = vboxsf_new_inode(parent->i_sb);
 		if (!IS_ERR(inode))
-			vboxsf_init_inode(sbi, inode, &fsinfo);
+			vboxsf_init_inode(sbi, inode, &fsinfo, false);
 	}
 
 	return d_splice_alias(inode, dentry);
@@ -245,7 +245,7 @@ static int vboxsf_dir_instantiate(struct inode *parent, struct dentry *dentry,
 	sf_i = VBOXSF_I(inode);
 	/* The host may have given us different attr then requested */
 	sf_i->force_restat = 1;
-	vboxsf_init_inode(sbi, inode, info);
+	vboxsf_init_inode(sbi, inode, info, false);
 
 	d_instantiate(dentry, inode);
 
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index d7816c01a4f6..4f5e59f06284 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -207,7 +207,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = -ENOMEM;
 		goto fail_unmap;
 	}
-	vboxsf_init_inode(sbi, iroot, &sbi->root_info);
+	vboxsf_init_inode(sbi, iroot, &sbi->root_info, false);
 	unlock_new_inode(iroot);
 
 	droot = d_make_root(iroot);
@@ -418,7 +418,7 @@ static int vboxsf_reconfigure(struct fs_context *fc)
 
 	/* Apply changed options to the root inode */
 	sbi->o = ctx->o;
-	vboxsf_init_inode(sbi, iroot, &sbi->root_info);
+	vboxsf_init_inode(sbi, iroot, &sbi->root_info, true);
 
 	return 0;
 }
diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index 3b847e3fba24..aec2ebf7d25a 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -45,12 +45,12 @@ struct inode *vboxsf_new_inode(struct super_block *sb)
 }
 
 /* set [inode] attributes based on [info], uid/gid based on [sbi] */
-void vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
-		       const struct shfl_fsobjinfo *info)
+int vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
+		       const struct shfl_fsobjinfo *info, bool reinit)
 {
 	const struct shfl_fsobjattr *attr;
 	s64 allocated;
-	int mode;
+	umode_t mode;
 
 	attr = &info->attr;
 
@@ -75,29 +75,44 @@ void vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
 	inode->i_mapping->a_ops = &vboxsf_reg_aops;
 
 	if (SHFL_IS_DIRECTORY(attr->mode)) {
-		inode->i_mode = sbi->o.dmode_set ? sbi->o.dmode : mode;
-		inode->i_mode &= ~sbi->o.dmask;
-		inode->i_mode |= S_IFDIR;
-		inode->i_op = &vboxsf_dir_iops;
-		inode->i_fop = &vboxsf_dir_fops;
-		/*
-		 * XXX: this probably should be set to the number of entries
-		 * in the directory plus two (. ..)
-		 */
-		set_nlink(inode, 1);
+		if (sbi->o.dmode_set)
+			mode = sbi->o.dmode;
+		mode &= ~sbi->o.dmask;
+		mode |= S_IFDIR;
+		if (!reinit) {
+			inode->i_op = &vboxsf_dir_iops;
+			inode->i_fop = &vboxsf_dir_fops;
+			/*
+			 * XXX: this probably should be set to the number of entries
+			 * in the directory plus two (. ..)
+			 */
+			set_nlink(inode, 1);
+		} else if (!S_ISDIR(inode->i_mode))
+			return -ESTALE;
+		inode->i_mode = mode;
 	} else if (SHFL_IS_SYMLINK(attr->mode)) {
-		inode->i_mode = sbi->o.fmode_set ? sbi->o.fmode : mode;
-		inode->i_mode &= ~sbi->o.fmask;
-		inode->i_mode |= S_IFLNK;
-		inode->i_op = &vboxsf_lnk_iops;
-		set_nlink(inode, 1);
+		if (sbi->o.fmode_set)
+			mode = sbi->o.fmode;
+		mode &= ~sbi->o.fmask;
+		mode |= S_IFLNK;
+		if (!reinit) {
+			inode->i_op = &vboxsf_lnk_iops;
+			set_nlink(inode, 1);
+		} else if (!S_ISLNK(inode->i_mode))
+			return -ESTALE;
+		inode->i_mode = mode;
 	} else {
-		inode->i_mode = sbi->o.fmode_set ? sbi->o.fmode : mode;
-		inode->i_mode &= ~sbi->o.fmask;
-		inode->i_mode |= S_IFREG;
-		inode->i_op = &vboxsf_reg_iops;
-		inode->i_fop = &vboxsf_reg_fops;
-		set_nlink(inode, 1);
+		if (sbi->o.fmode_set)
+			mode = sbi->o.fmode;
+		mode &= ~sbi->o.fmask;
+		mode |= S_IFREG;
+		if (!reinit) {
+			inode->i_op = &vboxsf_reg_iops;
+			inode->i_fop = &vboxsf_reg_fops;
+			set_nlink(inode, 1);
+		} else if (!S_ISREG(inode->i_mode))
+			return -ESTALE;
+		inode->i_mode = mode;
 	}
 
 	inode->i_uid = sbi->o.uid;
@@ -116,6 +131,7 @@ void vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
 				 info->change_time.ns_relative_to_unix_epoch);
 	inode->i_mtime = ns_to_timespec64(
 			   info->modification_time.ns_relative_to_unix_epoch);
+	return 0;
 }
 
 int vboxsf_create_at_dentry(struct dentry *dentry,
@@ -199,7 +215,9 @@ int vboxsf_inode_revalidate(struct dentry *dentry)
 
 	dentry->d_time = jiffies;
 	sf_i->force_restat = 0;
-	vboxsf_init_inode(sbi, inode, &info);
+	err = vboxsf_init_inode(sbi, inode, &info, true);
+	if (err)
+		return err;
 
 	/*
 	 * If the file was changed on the host side we need to invalidate the
diff --git a/fs/vboxsf/vfsmod.h b/fs/vboxsf/vfsmod.h
index 760524e78c88..6a7a9cedebc6 100644
--- a/fs/vboxsf/vfsmod.h
+++ b/fs/vboxsf/vfsmod.h
@@ -82,8 +82,8 @@ extern const struct dentry_operations vboxsf_dentry_ops;
 
 /* from utils.c */
 struct inode *vboxsf_new_inode(struct super_block *sb);
-void vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
-		       const struct shfl_fsobjinfo *info);
+int vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
+		       const struct shfl_fsobjinfo *info, bool reinit);
 int vboxsf_create_at_dentry(struct dentry *dentry,
 			    struct shfl_createparms *params);
 int vboxsf_stat(struct vboxsf_sbi *sbi, struct shfl_string *path,
-- 
2.11.0

