Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DD84C7EB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiB1Xtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiB1Xtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:49:52 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8040011986C;
        Mon, 28 Feb 2022 15:49:11 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id ay5so9238238plb.1;
        Mon, 28 Feb 2022 15:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AODVeBpHwg+oeijiQ65RBv/3GwfCKia7JrFok0VwOKk=;
        b=0FHWK9KZSJ3BPcPg/FM8OQZpwH7bptIZKqcMcKIWXEEbZGT0omR7a0ri0iTEJ2d6gC
         /BQpktIfcNsdGEp9+uCqeP2pZI3V0fCIgpPpuGfhScVQQ7j1FOT+ayFO22i9P3o/1phF
         j5lqSRyQCiJAXmxDSt8SJNaKJrS3grtwZVKEU/x4B5q/RSBEA8+yTKHU2Zp77ZI3qZ7m
         bSDWLfwvDvxkv9CHs60L5UJwbRGikyLpiy8pwgr2aS3cPSpkrpBXcLGs9AqQNkIqSN/U
         /9hq4MMxNXIGoD+B324LO8692nq/Sdnoz2CC1a5noAc+tQE505PtqoINvSc4XVjnpMC1
         9new==
X-Gm-Message-State: AOAM533GOLM6Qol3+s587u4UBaEnwtfs9dbSyADi+2r9MqeuV5R0iuUp
        eUjKd+exI3YxAroNFqtR7AgVhMmR7nA=
X-Google-Smtp-Source: ABdhPJw8+7u6oTYKLcvIClApPnWKsaSc5k/9zguRH+1Nx1h0r+QhC92dAE1MWPR3FabYsaQ3rW3Xdg==
X-Received: by 2002:a17:90a:3944:b0:1bd:5cde:6b76 with SMTP id n4-20020a17090a394400b001bd5cde6b76mr5681662pjf.42.1646092150450;
        Mon, 28 Feb 2022 15:49:10 -0800 (PST)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7939b000000b004ce11b956absm13829905pfe.186.2022.02.28.15.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:49:09 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 4/4] ksmbd: fix racy issue from using ->d_parent and ->d_name
Date:   Tue,  1 Mar 2022 08:48:33 +0900
Message-Id: <20220228234833.10434-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228234833.10434-1-linkinjeon@kernel.org>
References: <20220228234833.10434-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al pointed out that ksmbd has racy issue from using ->d_parent and ->d_name
in ksmbd_vfs_unlink and smb2_vfs_rename(). add dget_parent() in
ksmbd_vfs_unlink() and use take_dentry_name_snapshot() to check
underlying rename for lookup. Introduce vfs_path_parent_lookup helper
to avoid out of share access and export vfs functions like the following
ones to use vfs_path_parent_lookup().
 - __lookup_hash().
 - getname_kernel() and putname().

vfs_path_parent_lookup() is used for parent lookup of destination file
using absolute pathname given from FILE_RENAME_INFORMATION request.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 v3:
   - use dget_parent + take_dentry_name_snapshot() to check stability of source
     rename in smb2_vfs_rename().
 v2:
   - add filename_lock to avoid racy issue from fp->filename. (Sergey Senozhatsky)
   - fix warning: variable 'old_dentry' is used uninitialized (kernel
     test robot)

 fs/ksmbd/smb2pdu.c    | 105 ++----------------
 fs/ksmbd/vfs.c        | 253 +++++++++++++++++++-----------------------
 fs/ksmbd/vfs.h        |   7 +-
 fs/ksmbd/vfs_cache.c  |   5 +-
 fs/namei.c            |  41 ++++++-
 include/linux/namei.h |   4 +
 6 files changed, 167 insertions(+), 248 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 03c3733e54e4..bcb98109bac9 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5365,44 +5365,19 @@ int smb2_echo(struct ksmbd_work *work)
 
 static int smb2_rename(struct ksmbd_work *work,
 		       struct ksmbd_file *fp,
-		       struct user_namespace *user_ns,
 		       struct smb2_file_rename_info *file_info,
 		       struct nls_table *local_nls)
 {
 	struct ksmbd_share_config *share = fp->tcon->share_conf;
-	char *new_name = NULL, *abs_oldname = NULL, *old_name = NULL;
-	char *pathname = NULL;
-	struct path path;
-	bool file_present = true;
-	int rc;
+	char *new_name = NULL;
+	int rc, flags = 0;
 
 	ksmbd_debug(SMB, "setting FILE_RENAME_INFO\n");
-	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!pathname)
-		return -ENOMEM;
-
-	abs_oldname = d_path(&fp->filp->f_path, pathname, PATH_MAX);
-	if (IS_ERR(abs_oldname)) {
-		rc = -EINVAL;
-		goto out;
-	}
-	old_name = strrchr(abs_oldname, '/');
-	if (old_name && old_name[1] != '\0') {
-		old_name++;
-	} else {
-		ksmbd_debug(SMB, "can't get last component in path %s\n",
-			    abs_oldname);
-		rc = -ENOENT;
-		goto out;
-	}
-
 	new_name = smb2_get_name(file_info->FileName,
 				 le32_to_cpu(file_info->FileNameLength),
 				 local_nls);
-	if (IS_ERR(new_name)) {
-		rc = PTR_ERR(new_name);
-		goto out;
-	}
+	if (IS_ERR(new_name))
+		return PTR_ERR(new_name);
 
 	if (strchr(new_name, ':')) {
 		int s_type;
@@ -5428,7 +5403,7 @@ static int smb2_rename(struct ksmbd_work *work,
 		if (rc)
 			goto out;
 
-		rc = ksmbd_vfs_setxattr(user_ns,
+		rc = ksmbd_vfs_setxattr(file_mnt_user_ns(fp->filp),
 					fp->filp->f_path.dentry,
 					xattr_stream_name,
 					NULL, 0, 0);
@@ -5443,47 +5418,18 @@ static int smb2_rename(struct ksmbd_work *work,
 	}
 
 	ksmbd_debug(SMB, "new name %s\n", new_name);
-	rc = ksmbd_vfs_kern_path(work, new_name, LOOKUP_NO_SYMLINKS, &path, 1);
-	if (rc) {
-		if (rc != -ENOENT)
-			goto out;
-		file_present = false;
-	} else {
-		path_put(&path);
-	}
-
 	if (ksmbd_share_veto_filename(share, new_name)) {
 		rc = -ENOENT;
 		ksmbd_debug(SMB, "Can't rename vetoed file: %s\n", new_name);
 		goto out;
 	}
 
-	if (file_info->ReplaceIfExists) {
-		if (file_present) {
-			rc = ksmbd_vfs_remove_file(work, new_name);
-			if (rc) {
-				if (rc != -ENOTEMPTY)
-					rc = -EINVAL;
-				ksmbd_debug(SMB, "cannot delete %s, rc %d\n",
-					    new_name, rc);
-				goto out;
-			}
-		}
-	} else {
-		if (file_present &&
-		    strncmp(old_name, path.dentry->d_name.name, strlen(old_name))) {
-			rc = -EEXIST;
-			ksmbd_debug(SMB,
-				    "cannot rename already existing file\n");
-			goto out;
-		}
-	}
+	if (!file_info->ReplaceIfExists)
+		flags = RENAME_NOREPLACE;
 
-	rc = ksmbd_vfs_fp_rename(work, fp, new_name);
+	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
 out:
-	kfree(pathname);
-	if (!IS_ERR(new_name))
-		kfree(new_name);
+	kfree(new_name);
 	return rc;
 }
 
@@ -5731,12 +5677,6 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 			   struct smb2_file_rename_info *rename_info,
 			   unsigned int buf_len)
 {
-	struct user_namespace *user_ns;
-	struct ksmbd_file *parent_fp;
-	struct dentry *parent;
-	struct dentry *dentry = fp->filp->f_path.dentry;
-	int ret;
-
 	if (!(fp->daccess & FILE_DELETE_LE)) {
 		pr_err("no right to delete : 0x%x\n", fp->daccess);
 		return -EACCES;
@@ -5746,32 +5686,7 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 			le32_to_cpu(rename_info->FileNameLength))
 		return -EINVAL;
 
-	user_ns = file_mnt_user_ns(fp->filp);
-	if (ksmbd_stream_fd(fp))
-		goto next;
-
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
-	}
-
-	parent_fp = ksmbd_lookup_fd_inode(d_inode(parent));
-	inode_unlock(d_inode(parent));
-	dput(parent);
-
-	if (parent_fp) {
-		if (parent_fp->daccess & FILE_DELETE_LE) {
-			pr_err("parent dir is opened with delete access\n");
-			ksmbd_fd_put(work, parent_fp);
-			return -ESHARE;
-		}
-		ksmbd_fd_put(work, parent_fp);
-	}
-next:
-	return smb2_rename(work, fp, user_ns, rename_info,
-			   work->sess->conn->local_nls);
+	return smb2_rename(work, fp, rename_info, work->sess->conn->local_nls);
 }
 
 static int set_file_disposition_info(struct ksmbd_file *fp,
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 487617f729ec..0b92092f3e8a 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -35,19 +35,6 @@
 #include "mgmt/user_session.h"
 #include "mgmt/user_config.h"
 
-static char *extract_last_component(char *path)
-{
-	char *p = strrchr(path, '/');
-
-	if (p && p[1] != '\0') {
-		*p = '\0';
-		p++;
-	} else {
-		p = NULL;
-	}
-	return p;
-}
-
 static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
 				    struct inode *parent_inode,
 				    struct inode *inode)
@@ -72,11 +59,14 @@ int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry *parent,
 			  struct dentry *child)
 {
 	struct dentry *dentry;
+	struct name_snapshot name;
 	int ret = 0;
 
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	dentry = lookup_one(user_ns, child->d_name.name, parent,
-			    child->d_name.len);
+	take_dentry_name_snapshot(&name, child);
+	dentry = lookup_one(user_ns, name.name.name, parent,
+			    name.name.len);
+	release_dentry_name_snapshot(&name);
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
 		goto out_err;
@@ -689,149 +679,130 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 	return err;
 }
 
-static int ksmbd_validate_entry_in_use(struct dentry *src_dent)
+int ksmbd_vfs_rename(struct ksmbd_work *work, struct path *old_path,
+		     char *newname, int flags)
 {
-	struct dentry *dst_dent;
-
-	spin_lock(&src_dent->d_lock);
-	list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
-		struct ksmbd_file *child_fp;
+	struct dentry *old_parent, *old_dentry, *new_dentry, *trap;
+	struct dentry *old_child = old_path->dentry;
+	struct path new_path;
+	struct qstr new_last;
+	struct renamedata rd;
+	struct filename *to;
+	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
+	struct ksmbd_file *parent_fp;
+	struct name_snapshot name;
+	int new_type;
+	int err, lookup_flags = LOOKUP_NO_SYMLINKS;
 
-		if (d_really_is_negative(dst_dent))
-			continue;
+	if (ksmbd_override_fsids(work))
+		return -ENOMEM;
 
-		child_fp = ksmbd_lookup_fd_inode(d_inode(dst_dent));
-		if (child_fp) {
-			spin_unlock(&src_dent->d_lock);
-			ksmbd_debug(VFS, "Forbid rename, sub file/dir is in use\n");
-			return -EACCES;
-		}
+	to = getname_kernel(newname);
+	if (IS_ERR(to)) {
+		err = PTR_ERR(to);
+		goto revert_fsids;
 	}
-	spin_unlock(&src_dent->d_lock);
-
-	return 0;
-}
 
-static int __ksmbd_vfs_rename(struct ksmbd_work *work,
-			      struct user_namespace *src_user_ns,
-			      struct dentry *src_dent_parent,
-			      struct dentry *src_dent,
-			      struct user_namespace *dst_user_ns,
-			      struct dentry *dst_dent_parent,
-			      struct dentry *trap_dent,
-			      char *dst_name)
-{
-	struct dentry *dst_dent;
-	int err;
+	old_parent = dget_parent(old_child);
+retry:
+	err = vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
+				     &new_path, &new_last, &new_type,
+				     &share_conf->vfs_path);
+	if (err)
+		goto out1;
 
-	if (!work->tcon->posix_extensions) {
-		err = ksmbd_validate_entry_in_use(src_dent);
-		if (err)
-			return err;
+	if (d_is_symlink(new_path.dentry)) {
+		err = -EACCES;
+		goto out2;
 	}
 
-	if (d_really_is_negative(src_dent_parent))
-		return -ENOENT;
-	if (d_really_is_negative(dst_dent_parent))
-		return -ENOENT;
-	if (d_really_is_negative(src_dent))
-		return -ENOENT;
-	if (src_dent == trap_dent)
-		return -EINVAL;
+	if (old_path->mnt != new_path.mnt) {
+		err = -EXDEV;
+		goto out2;
+	}
 
-	if (ksmbd_override_fsids(work))
-		return -ENOMEM;
+	trap = lock_rename(old_parent, new_path.dentry);
+	take_dentry_name_snapshot(&name, old_child);
+	old_dentry = lookup_one(mnt_user_ns(old_path->mnt), name.name.name,
+				old_parent, name.name.len);
+	release_dentry_name_snapshot(&name);
+	if (IS_ERR(old_dentry)) {
+		err = PTR_ERR(old_dentry);
+		goto out3;
+	}
 
-	dst_dent = lookup_one(dst_user_ns, dst_name, dst_dent_parent,
-			      strlen(dst_name));
-	err = PTR_ERR(dst_dent);
-	if (IS_ERR(dst_dent)) {
-		pr_err("lookup failed %s [%d]\n", dst_name, err);
-		goto out;
+	if (old_dentry != old_child) {
+		err = -ESTALE;
+		dput(old_dentry);
+		goto out4;
 	}
 
-	err = -ENOTEMPTY;
-	if (dst_dent != trap_dent && !d_really_is_positive(dst_dent)) {
-		struct renamedata rd = {
-			.old_mnt_userns	= src_user_ns,
-			.old_dir	= d_inode(src_dent_parent),
-			.old_dentry	= src_dent,
-			.new_mnt_userns	= dst_user_ns,
-			.new_dir	= d_inode(dst_dent_parent),
-			.new_dentry	= dst_dent,
-		};
-		err = vfs_rename(&rd);
+	new_dentry = __lookup_hash(&new_last, new_path.dentry,
+				   lookup_flags | LOOKUP_RENAME_TARGET);
+	if (IS_ERR(new_dentry)) {
+		err = PTR_ERR(new_dentry);
+		goto out4;
 	}
-	if (err)
-		pr_err("vfs_rename failed err %d\n", err);
-	if (dst_dent)
-		dput(dst_dent);
-out:
-	ksmbd_revert_fsids(work);
-	return err;
-}
 
-int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
-			char *newname)
-{
-	struct user_namespace *user_ns;
-	struct path dst_path;
-	struct dentry *src_dent_parent, *dst_dent_parent;
-	struct dentry *src_dent, *trap_dent, *src_child;
-	char *dst_name;
-	int err;
+	if (d_is_symlink(new_dentry)) {
+		err = -EACCES;
+		goto out5;
+	}
 
-	dst_name = extract_last_component(newname);
-	if (!dst_name) {
-		dst_name = newname;
-		newname = "";
+	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry)) {
+		err = -EEXIST;
+		goto out5;
 	}
 
-	src_dent_parent = dget_parent(fp->filp->f_path.dentry);
-	src_dent = fp->filp->f_path.dentry;
+	if (old_dentry == trap) {
+		err = -EINVAL;
+		goto out5;
+	}
 
-	err = ksmbd_vfs_kern_path(work, newname,
-				  LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
-				  &dst_path, false);
-	if (err) {
-		ksmbd_debug(VFS, "Cannot get path for %s [%d]\n", newname, err);
-		goto out;
+	if (new_dentry == trap) {
+		err = -ENOTEMPTY;
+		goto out5;
 	}
-	dst_dent_parent = dst_path.dentry;
 
-	trap_dent = lock_rename(src_dent_parent, dst_dent_parent);
-	dget(src_dent);
-	dget(dst_dent_parent);
-	user_ns = file_mnt_user_ns(fp->filp);
-	src_child = lookup_one(user_ns, src_dent->d_name.name, src_dent_parent,
-			       src_dent->d_name.len);
-	if (IS_ERR(src_child)) {
-		err = PTR_ERR(src_child);
-		goto out_lock;
+	parent_fp = ksmbd_lookup_fd_inode(old_parent->d_inode);
+	if (parent_fp) {
+		if (parent_fp->daccess & FILE_DELETE_LE) {
+			pr_err("parent dir is opened with delete access\n");
+			err = -ESHARE;
+			ksmbd_fd_put(work, parent_fp);
+			goto out5;
+		}
+		ksmbd_fd_put(work, parent_fp);
 	}
 
-	if (src_child != src_dent) {
-		err = -ESTALE;
-		dput(src_child);
-		goto out_lock;
-	}
-	dput(src_child);
-
-	err = __ksmbd_vfs_rename(work,
-				 user_ns,
-				 src_dent_parent,
-				 src_dent,
-				 mnt_user_ns(dst_path.mnt),
-				 dst_dent_parent,
-				 trap_dent,
-				 dst_name);
-out_lock:
-	dput(src_dent);
-	dput(dst_dent_parent);
-	unlock_rename(src_dent_parent, dst_dent_parent);
-	path_put(&dst_path);
-out:
-	dput(src_dent_parent);
+	rd.old_mnt_userns	= mnt_user_ns(old_path->mnt),
+	rd.old_dir		= old_parent->d_inode,
+	rd.old_dentry		= old_dentry,
+	rd.new_mnt_userns	= mnt_user_ns(new_path.mnt),
+	rd.new_dir		= new_path.dentry->d_inode,
+	rd.new_dentry		= new_dentry,
+	rd.flags		= flags,
+	err = vfs_rename(&rd);
+	if (err)
+		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
+out5:
+	dput(new_dentry);
+out4:
+	dput(old_dentry);
+out3:
+	unlock_rename(old_parent, new_path.dentry);
+out2:
+	path_put(&new_path);
+
+	if (retry_estale(err, lookup_flags)) {
+		lookup_flags |= LOOKUP_REVAL;
+		goto retry;
+	}
+out1:
+	putname(to);
+	dput(old_parent);
+revert_fsids:
+	ksmbd_revert_fsids(work);
 	return err;
 }
 
@@ -1080,14 +1051,16 @@ int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
 	return vfs_removexattr(user_ns, dentry, attr_name);
 }
 
-int ksmbd_vfs_unlink(struct user_namespace *user_ns,
-		     struct dentry *dir, struct dentry *dentry)
+int ksmbd_vfs_unlink(struct file *filp)
 {
 	int err = 0;
+	struct dentry *dir, *dentry = filp->f_path.dentry;
+	struct user_namespace *user_ns = file_mnt_user_ns(filp);
 
+	dir = dget_parent(dentry);
 	err = ksmbd_vfs_lock_parent(user_ns, dir, dentry);
 	if (err)
-		return err;
+		goto out;
 	dget(dentry);
 
 	if (S_ISDIR(d_inode(dentry)->i_mode))
@@ -1099,6 +1072,8 @@ int ksmbd_vfs_unlink(struct user_namespace *user_ns,
 	inode_unlock(d_inode(dir));
 	if (err)
 		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
+out:
+	dput(dir);
 
 	return err;
 }
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 8c37aaf936ab..5b8070774aab 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -86,8 +86,8 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name);
 int ksmbd_vfs_link(struct ksmbd_work *work,
 		   const char *oldname, const char *newname);
 int ksmbd_vfs_getattr(struct path *path, struct kstat *stat);
-int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
-			char *newname);
+int ksmbd_vfs_rename(struct ksmbd_work *work, struct path *old_path,
+		     char *newname, int flags);
 int ksmbd_vfs_truncate(struct ksmbd_work *work,
 		       struct ksmbd_file *fp, loff_t size);
 struct srv_copychunk;
@@ -129,8 +129,7 @@ struct file_allocated_range_buffer;
 int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
 			 struct file_allocated_range_buffer *ranges,
 			 unsigned int in_count, unsigned int *out_count);
-int ksmbd_vfs_unlink(struct user_namespace *user_ns,
-		     struct dentry *dir, struct dentry *dentry);
+int ksmbd_vfs_unlink(struct file *filp);
 void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat);
 int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 				struct user_namespace *user_ns,
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index c4d59d2735f0..df600eb04552 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -243,7 +243,6 @@ void ksmbd_release_inode_hash(void)
 
 static void __ksmbd_inode_close(struct ksmbd_file *fp)
 {
-	struct dentry *dir, *dentry;
 	struct ksmbd_inode *ci = fp->f_ci;
 	int err;
 	struct file *filp;
@@ -262,11 +261,9 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 	if (atomic_dec_and_test(&ci->m_count)) {
 		write_lock(&ci->m_lock);
 		if (ci->m_flags & (S_DEL_ON_CLS | S_DEL_PENDING)) {
-			dentry = filp->f_path.dentry;
-			dir = dentry->d_parent;
 			ci->m_flags &= ~(S_DEL_ON_CLS | S_DEL_PENDING);
 			write_unlock(&ci->m_lock);
-			ksmbd_vfs_unlink(file_mnt_user_ns(filp), dir, dentry);
+			ksmbd_vfs_unlink(filp);
 			write_lock(&ci->m_lock);
 		}
 		write_unlock(&ci->m_lock);
diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..e882156877f6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -252,6 +252,7 @@ getname_kernel(const char * filename)
 
 	return result;
 }
+EXPORT_SYMBOL(getname_kernel);
 
 void putname(struct filename *name)
 {
@@ -269,6 +270,7 @@ void putname(struct filename *name)
 	} else
 		__putname(name);
 }
+EXPORT_SYMBOL(putname);
 
 /**
  * check_acl - perform ACL permission checking
@@ -1587,8 +1589,8 @@ static struct dentry *lookup_dcache(const struct qstr *name,
  * when directory is guaranteed to have no in-lookup children
  * at all.
  */
-static struct dentry *__lookup_hash(const struct qstr *name,
-		struct dentry *base, unsigned int flags)
+struct dentry *__lookup_hash(const struct qstr *name, struct dentry *base,
+			     unsigned int flags)
 {
 	struct dentry *dentry = lookup_dcache(name, base, flags);
 	struct dentry *old;
@@ -1612,6 +1614,7 @@ static struct dentry *__lookup_hash(const struct qstr *name,
 	}
 	return dentry;
 }
+EXPORT_SYMBOL(__lookup_hash);
 
 static struct dentry *lookup_fast(struct nameidata *nd,
 				  struct inode **inode,
@@ -2556,16 +2559,17 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
 }
 
 /* Note: this does not consume "name" */
-static int filename_parentat(int dfd, struct filename *name,
-			     unsigned int flags, struct path *parent,
-			     struct qstr *last, int *type)
+static int __filename_parentat(int dfd, struct filename *name,
+			       unsigned int flags, struct path *parent,
+			       struct qstr *last, int *type,
+			       const struct path *root)
 {
 	int retval;
 	struct nameidata nd;
 
 	if (IS_ERR(name))
 		return PTR_ERR(name);
-	set_nameidata(&nd, dfd, name, NULL);
+	set_nameidata(&nd, dfd, name, root);
 	retval = path_parentat(&nd, flags | LOOKUP_RCU, parent);
 	if (unlikely(retval == -ECHILD))
 		retval = path_parentat(&nd, flags, parent);
@@ -2580,6 +2584,12 @@ static int filename_parentat(int dfd, struct filename *name,
 	return retval;
 }
 
+int filename_parentat(int dfd, struct filename *name, unsigned int flags,
+		      struct path *parent, struct qstr *last, int *type)
+{
+	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
+}
+
 /* does lookup, returns the object with parent locked */
 static struct dentry *__kern_path_locked(struct filename *name, struct path *path)
 {
@@ -2623,6 +2633,25 @@ int kern_path(const char *name, unsigned int flags, struct path *path)
 }
 EXPORT_SYMBOL(kern_path);
 
+/**
+ * vfs_path_parent_lookup - lookup a parent path relative to a dentry-vfsmount pair
+ * @dentry:  pointer to dentry of the base directory
+ * @mnt: pointer to vfs mount of the base directory
+ * @filename: filename structure
+ * @flags: lookup flags
+ * @parent: pointer to struct path to fill
+ * @last: last component
+ * @type: type of the last component
+ */
+int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
+			   struct path *parent, struct qstr *last, int *type,
+			   const struct path *root)
+{
+	return  __filename_parentat(AT_FDCWD, filename, flags, parent, last,
+				    type, root);
+}
+EXPORT_SYMBOL(vfs_path_parent_lookup);
+
 /**
  * vfs_path_lookup - lookup a file path relative to a dentry-vfsmount pair
  * @dentry:  pointer to dentry of the base directory
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 4858c3cdf7c6..439b2a6767ae 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -57,12 +57,16 @@ static inline int user_path_at(int dfd, const char __user *name, unsigned flags,
 	return user_path_at_empty(dfd, name, flags, path, NULL);
 }
 
+struct dentry *__lookup_hash(const struct qstr *name, struct dentry *base,
+			     unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
+int vfs_path_parent_lookup(struct filename *, unsigned int, struct path *,\
+			   struct qstr *, int *, const struct path *);
 int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
 		    unsigned int, struct path *);
 
-- 
2.25.1

