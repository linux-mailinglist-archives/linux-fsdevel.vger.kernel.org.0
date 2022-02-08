Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4EC4ACDEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 02:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbiBHBUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 20:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbiBHBUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:20:03 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E36C03E947;
        Mon,  7 Feb 2022 17:11:25 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id y5so15130900pfe.4;
        Mon, 07 Feb 2022 17:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fjHYYZXms5wkLd7R8NjbxfPOLcSDC2NcEjyO7cDVJog=;
        b=qYXr05jZkVPpgy0/TpNeBCVYIaKegbA65UHluEtOIb1AjWsGLze4QrgLXbaKC8ZMLr
         QdGNfBdxtQEFfVYv+hbSdgZ9wnUa/iaXgPkNdy8ScYtHHOkzSuRo2gaFvT+TAP7RIbF+
         EWs+sJKrHrJxtXohRMGhW/tMpnWuDvt2p7ke5OTLUM+lMENxJppBZ2dyxF8p3BCew4WI
         Cfk2TZJZ5g5I9HmFQJPmYMAEx/Kmp6ZmexEJ/5Bf8Psap0AxH9wAPqYIXxivUAU/JSl+
         2yApL7qMEr4yVB/DNc5VW73kz+Hm9yLlnnJWG0JV+J9n0vpjhHyp98ex4y7TU3FfAQ+G
         GClw==
X-Gm-Message-State: AOAM530RaOTAMwoYS+xI/vdPSAbMJ66ewfHlU26iCJFC8fpaZdyzr4rs
        Etvv7BuyCNcIhzOGrYrGX5tNIYXcNgU=
X-Google-Smtp-Source: ABdhPJwZ/g8SoS+7UKJAOe+N9+XNscIfbVDCBfFCRJ4w50648gTvU1LjTah8jRiLqRkoPJ2BzmC+GA==
X-Received: by 2002:a05:6a00:2301:: with SMTP id h1mr1975596pfh.77.1644282644832;
        Mon, 07 Feb 2022 17:10:44 -0800 (PST)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id i17sm9280043pgv.8.2022.02.07.17.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 17:10:44 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     smfrench@gmail.com, hyc.lee@gmail.com,
        Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] ksmbd: fix racy issue from using ->d_parent and ->d_name
Date:   Tue,  8 Feb 2022 10:09:59 +0900
Message-Id: <20220208010959.4050-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al pointed out that ksmbd has racy issue from using ->d_parent and ->d_name
in ksmbd_vfs_unlink and smb2_vfs_rename(). and he suggested changing from
the way it start with dget_parent(), which can cause retry loop and
unexpected errors, to find the parent of child, lock it and then look for
a child in locked directory.

This patch introduce a new helper(vfs_path_parent_lookup()) to avoid
out of share access and export vfs functions like the following ones to use
vfs_path_parent_lookup() and filename_parentat().
 - __lookup_hash().
 - getname_kernel() and putname().
 - filename_parentat()

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/internal.h                |   3 +
 fs/ksmbd/mgmt/user_session.c |   2 +-
 fs/ksmbd/smb2pdu.c           | 124 ++--------
 fs/ksmbd/vfs.c               | 465 +++++++++++++++--------------------
 fs/ksmbd/vfs.h               |  18 +-
 fs/ksmbd/vfs_cache.c         |   5 +-
 fs/namei.c                   |  43 +++-
 include/linux/namei.h        |   4 +
 8 files changed, 272 insertions(+), 392 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 8590c973c2f4..633a950cce1f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -58,6 +58,9 @@ extern int finish_clean_context(struct fs_context *fc);
  */
 extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, struct path *root);
+int vfs_path_parent_lookup(struct dentry *dentry, struct vfsmount *mnt,
+			   struct filename *filename, unsigned int flags,
+			   struct path *parent, struct qstr *last, int *type);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
 int do_rmdir(int dfd, struct filename *name);
diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 8d8ffd8c6f19..f4279f450053 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -161,8 +161,8 @@ void ksmbd_session_destroy(struct ksmbd_session *sess)
 	if (sess->user)
 		ksmbd_free_user(sess->user);
 
-	ksmbd_tree_conn_session_logoff(sess);
 	ksmbd_destroy_file_table(&sess->file_table);
+	ksmbd_tree_conn_session_logoff(sess);
 	ksmbd_session_rpc_clear_list(sess);
 	free_channel_list(sess);
 	kfree(sess->Preauth_HashValue);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 67e8e28e3fc3..2477d1da4f0c 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2803,11 +2803,9 @@ int smb2_open(struct ksmbd_work *work)
 		if (!file_present) {
 			daccess = cpu_to_le32(GENERIC_ALL_FLAGS);
 		} else {
-			rc = ksmbd_vfs_query_maximal_access(user_ns,
-							    path.dentry,
-							    &daccess);
-			if (rc)
-				goto err_out;
+			ksmbd_vfs_query_maximal_access(share, user_ns,
+						       path.dentry, name,
+						       &daccess);
 			already_permitted = true;
 		}
 		maximal_access = daccess;
@@ -2869,8 +2867,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			if ((daccess & FILE_DELETE_LE) ||
 			    (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
-				rc = ksmbd_vfs_may_delete(user_ns,
-							  path.dentry);
+				rc = ksmbd_vfs_may_delete(share, name);
 				if (rc)
 					goto err_out;
 			}
@@ -3187,8 +3184,8 @@ int smb2_open(struct ksmbd_work *work)
 		struct create_context *mxac_ccontext;
 
 		if (maximal_access == 0)
-			ksmbd_vfs_query_maximal_access(user_ns,
-						       path.dentry,
+			ksmbd_vfs_query_maximal_access(share, user_ns,
+						       path.dentry, name,
 						       &maximal_access);
 		mxac_ccontext = (struct create_context *)(rsp->Buffer +
 				le32_to_cpu(rsp->CreateContextsLength));
@@ -5369,44 +5366,19 @@ int smb2_echo(struct ksmbd_work *work)
 
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
@@ -5432,7 +5404,7 @@ static int smb2_rename(struct ksmbd_work *work,
 		if (rc)
 			goto out;
 
-		rc = ksmbd_vfs_setxattr(user_ns,
+		rc = ksmbd_vfs_setxattr(file_mnt_user_ns(fp->filp),
 					fp->filp->f_path.dentry,
 					xattr_stream_name,
 					NULL, 0, 0);
@@ -5447,47 +5419,23 @@ static int smb2_rename(struct ksmbd_work *work,
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
+	if (rc) {
 		kfree(new_name);
+	} else {
+		kfree(fp->filename);
+		fp->filename = new_name;
+	}
 	return rc;
 }
 
@@ -5538,7 +5486,8 @@ static int smb2_create_link(struct ksmbd_work *work,
 
 	if (file_info->ReplaceIfExists) {
 		if (file_present) {
-			rc = ksmbd_vfs_remove_file(work, link_name);
+			rc = ksmbd_vfs_unlink(work->tcon->share_conf,
+					      link_name);
 			if (rc) {
 				rc = -EINVAL;
 				ksmbd_debug(SMB, "cannot delete %s\n",
@@ -5738,12 +5687,6 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
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
@@ -5753,30 +5696,7 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
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
-			return -ESHARE;
-		}
-	}
-next:
-	return smb2_rename(work, fp, user_ns, rename_info,
-			   work->sess->conn->local_nls);
+	return smb2_rename(work, fp, rename_info, work->sess->conn->local_nls);
 }
 
 static int set_file_disposition_info(struct ksmbd_file *fp,
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 19d36393974c..9321b05891b0 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -37,19 +37,6 @@
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
@@ -61,69 +48,57 @@ static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
 	i_uid_write(inode, i_uid_read(parent_inode));
 }
 
-/**
- * ksmbd_vfs_lock_parent() - lock parent dentry if it is stable
- *
- * the parent dentry got by dget_parent or @parent could be
- * unstable, we try to lock a parent inode and lookup the
- * child dentry again.
- *
- * the reference count of @parent isn't incremented.
- */
-int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry *parent,
-			  struct dentry *child)
+int ksmbd_vfs_may_delete(struct ksmbd_share_config *share, char *filename)
 {
 	struct dentry *dentry;
-	int ret = 0;
+	struct path path;
+	struct qstr last;
+	struct filename *filename_struct;
+	struct inode *dir;
+	int type, err = 0;
+
+	filename_struct = getname_kernel(filename);
+	if (IS_ERR(filename_struct))
+		return PTR_ERR(filename_struct);
+
+	err = vfs_path_parent_lookup(share->vfs_path.dentry,
+				     share->vfs_path.mnt, filename_struct,
+				     LOOKUP_NO_SYMLINKS | LOOKUP_BENEATH,
+				     &path, &last, &type);
+	if (err)
+		goto putname;
 
-	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	dentry = lookup_one(user_ns, child->d_name.name, parent,
-			    child->d_name.len);
+	dir = d_inode(path.dentry);
+
+	inode_lock_nested(dir, I_MUTEX_PARENT);
+	dentry = __lookup_hash(&last, path.dentry, 0);
 	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto out_err;
+		err = PTR_ERR(dentry);
+		goto unlock_inode;
 	}
 
-	if (dentry != child) {
-		ret = -ESTALE;
+	if (d_is_negative(dentry)) {
+		err = -ENOENT;
 		dput(dentry);
-		goto out_err;
+		goto unlock_inode;
 	}
 
-	dput(dentry);
-	return 0;
-out_err:
-	inode_unlock(d_inode(parent));
-	return ret;
-}
-
-int ksmbd_vfs_may_delete(struct user_namespace *user_ns,
-			 struct dentry *dentry)
-{
-	struct dentry *parent;
-	int ret;
-
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
-	}
-
-	ret = inode_permission(user_ns, d_inode(parent),
+	err = inode_permission(mnt_user_ns(path.mnt), dir,
 			       MAY_EXEC | MAY_WRITE);
-
-	inode_unlock(d_inode(parent));
-	dput(parent);
-	return ret;
+	dput(dentry);
+unlock_inode:
+	inode_unlock(dir);
+	path_put(&path);
+putname:
+	putname(filename_struct);
+	return err;
 }
 
-int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
-				   struct dentry *dentry, __le32 *daccess)
+void ksmbd_vfs_query_maximal_access(struct ksmbd_share_config *share,
+				    struct user_namespace *user_ns,
+				    struct dentry *dentry, char *filename,
+				    __le32 *daccess)
 {
-	struct dentry *parent;
-	int ret = 0;
-
 	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
 
 	if (!inode_permission(user_ns, d_inode(dentry), MAY_OPEN | MAY_WRITE))
@@ -138,19 +113,8 @@ int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
 	if (!inode_permission(user_ns, d_inode(dentry), MAY_OPEN | MAY_EXEC))
 		*daccess |= FILE_EXECUTE_LE;
 
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
-	}
-
-	if (!inode_permission(user_ns, d_inode(parent), MAY_EXEC | MAY_WRITE))
+	if (!ksmbd_vfs_may_delete(share, filename))
 		*daccess |= FILE_DELETE_LE;
-
-	inode_unlock(d_inode(parent));
-	dput(parent);
-	return ret;
 }
 
 /**
@@ -580,64 +544,6 @@ int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id)
 	return err;
 }
 
-/**
- * ksmbd_vfs_remove_file() - vfs helper for smb rmdir or unlink
- * @name:	directory or file name that is relative to share
- *
- * Return:	0 on success, otherwise error
- */
-int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
-{
-	struct user_namespace *user_ns;
-	struct path path;
-	struct dentry *parent;
-	int err;
-
-	if (ksmbd_override_fsids(work))
-		return -ENOMEM;
-
-	err = ksmbd_vfs_kern_path(work, name, LOOKUP_NO_SYMLINKS, &path, false);
-	if (err) {
-		ksmbd_debug(VFS, "can't get %s, err %d\n", name, err);
-		ksmbd_revert_fsids(work);
-		return err;
-	}
-
-	user_ns = mnt_user_ns(path.mnt);
-	parent = dget_parent(path.dentry);
-	err = ksmbd_vfs_lock_parent(user_ns, parent, path.dentry);
-	if (err) {
-		dput(parent);
-		path_put(&path);
-		ksmbd_revert_fsids(work);
-		return err;
-	}
-
-	if (!d_inode(path.dentry)->i_nlink) {
-		err = -ENOENT;
-		goto out_err;
-	}
-
-	if (S_ISDIR(d_inode(path.dentry)->i_mode)) {
-		err = vfs_rmdir(user_ns, d_inode(parent), path.dentry);
-		if (err && err != -ENOTEMPTY)
-			ksmbd_debug(VFS, "%s: rmdir failed, err %d\n", name,
-				    err);
-	} else {
-		err = vfs_unlink(user_ns, d_inode(parent), path.dentry, NULL);
-		if (err)
-			ksmbd_debug(VFS, "%s: unlink failed, err %d\n", name,
-				    err);
-	}
-
-out_err:
-	inode_unlock(d_inode(parent));
-	dput(parent);
-	path_put(&path);
-	ksmbd_revert_fsids(work);
-	return err;
-}
-
 /**
  * ksmbd_vfs_link() - vfs helper for creating smb hardlink
  * @oldname:	source file name
@@ -692,149 +598,138 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 	return err;
 }
 
-static int ksmbd_validate_entry_in_use(struct dentry *src_dent)
+int ksmbd_vfs_rename(struct ksmbd_work *work, struct path *path, char *newname,
+		     int flags)
 {
-	struct dentry *dst_dent;
-
-	spin_lock(&src_dent->d_lock);
-	list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
-		struct ksmbd_file *child_fp;
+	struct dentry *old_dentry, *new_dentry, *trap;
+	struct path old_path, new_path;
+	struct qstr old_last, new_last;
+	struct renamedata rd;
+	struct filename *from, *to;
+	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
+	struct ksmbd_file *parent_fp;
+	int old_type, new_type;
+	int err, lookup_flags = LOOKUP_NO_SYMLINKS;
+	char *pathname, *abs_oldname;
 
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
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathname) {
+		ksmbd_revert_fsids(work);
+		return -ENOMEM;
 	}
-	spin_unlock(&src_dent->d_lock);
 
-	return 0;
-}
+	abs_oldname = d_path(path, pathname, PATH_MAX);
+	if (IS_ERR(abs_oldname)) {
+		err = -EINVAL;
+		goto free_pathname;
+	}
 
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
+	from = getname_kernel(abs_oldname);
+	if (IS_ERR(from)) {
+		err = PTR_ERR(from);
+		goto free_pathname;
+	}
 
-	if (!work->tcon->posix_extensions) {
-		err = ksmbd_validate_entry_in_use(src_dent);
-		if (err)
-			return err;
+	to = getname_kernel(newname);
+	if (IS_ERR(to)) {
+		err = PTR_ERR(to);
+		goto putname_from;
 	}
 
-	if (d_really_is_negative(src_dent_parent))
-		return -ENOENT;
-	if (d_really_is_negative(dst_dent_parent))
-		return -ENOENT;
-	if (d_really_is_negative(src_dent))
-		return -ENOENT;
-	if (src_dent == trap_dent)
-		return -EINVAL;
+	err = filename_parentat(AT_FDCWD, from, lookup_flags, &old_path,
+				&old_last, &old_type);
+	if (err)
+		goto putnames;
 
-	if (ksmbd_override_fsids(work))
-		return -ENOMEM;
+	err = vfs_path_parent_lookup(share_conf->vfs_path.dentry,
+				     share_conf->vfs_path.mnt, to,
+				     lookup_flags | LOOKUP_BENEATH,
+				     &new_path, &new_last, &new_type);
+	if (err)
+		goto out1;
 
-	dst_dent = lookup_one(dst_user_ns, dst_name, dst_dent_parent,
-			      strlen(dst_name));
-	err = PTR_ERR(dst_dent);
-	if (IS_ERR(dst_dent)) {
-		pr_err("lookup failed %s [%d]\n", dst_name, err);
-		goto out;
+	if (d_is_symlink(new_path.dentry)) {
+		err = -EACCES;
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
+	trap = lock_rename(old_path.dentry, new_path.dentry);
+	old_dentry = __lookup_hash(&old_last, old_path.dentry, 0);
+	if (IS_ERR(old_dentry)) {
+		err = PTR_ERR(old_dentry);
+		goto out2;
+	}
+	if (d_is_negative(old_dentry)) {
+		err = -ENOENT;
+		goto out3;
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
+	new_dentry = __lookup_hash(&new_last, new_path.dentry,
+				   LOOKUP_RENAME_TARGET);
+	if (IS_ERR(new_dentry)) {
+		err = PTR_ERR(new_dentry);
+		goto out3;
+	}
 
-	dst_name = extract_last_component(newname);
-	if (!dst_name) {
-		dst_name = newname;
-		newname = "";
+	if (d_is_symlink(new_dentry)) {
+		err = -EACCES;
+		goto out4;
 	}
 
-	src_dent_parent = dget_parent(fp->filp->f_path.dentry);
-	src_dent = fp->filp->f_path.dentry;
+	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry)) {
+		err = -EEXIST;
+		goto out4;
+	}
 
-	err = ksmbd_vfs_kern_path(work, newname,
-				  LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
-				  &dst_path, false);
-	if (err) {
-		ksmbd_debug(VFS, "Cannot get path for %s [%d]\n", newname, err);
-		goto out;
+	if (old_dentry == trap) {
+		err = -EINVAL;
+		goto out4;
 	}
-	dst_dent_parent = dst_path.dentry;
-
-	trap_dent = lock_rename(src_dent_parent, dst_dent_parent);
-	dget(src_dent);
-	dget(dst_dent_parent);
-	user_ns = file_mnt_user_ns(fp->filp);
-	src_child = lookup_one(user_ns, src_dent->d_name.name, src_dent_parent,
-			       src_dent->d_name.len);
-	if (IS_ERR(src_child)) {
-		err = PTR_ERR(src_child);
-		goto out_lock;
-	}
-
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
+
+	if (new_dentry == trap) {
+		err = -ENOTEMPTY;
+		goto out4;
+	}
+
+	parent_fp = ksmbd_lookup_fd_inode(old_path.dentry->d_inode);
+	if (parent_fp) {
+		if (parent_fp->daccess & FILE_DELETE_LE) {
+			pr_err("parent dir is opened with delete access\n");
+			err = -ESHARE;
+			goto out4;
+		}
+	}
+
+	rd.old_mnt_userns	= mnt_user_ns(old_path.mnt),
+	rd.old_dir		= old_path.dentry->d_inode,
+	rd.old_dentry		= old_dentry,
+	rd.new_mnt_userns	= mnt_user_ns(new_path.mnt),
+	rd.new_dir		= new_path.dentry->d_inode,
+	rd.new_dentry		= new_dentry,
+	rd.flags		= flags,
+	err = vfs_rename(&rd);
+	if (err)
+		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
+out4:
+	dput(new_dentry);
+out3:
+	dput(old_dentry);
+out2:
+	unlock_rename(new_path.dentry, old_path.dentry);
+	path_put(&new_path);
+out1:
+	path_put(&old_path);
+
+putnames:
+	putname(to);
+putname_from:
+	putname(from);
+free_pathname:
+	kfree(pathname);
+	ksmbd_revert_fsids(work);
 	return err;
 }
 
@@ -1084,26 +979,57 @@ int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
 	return vfs_removexattr(user_ns, dentry, attr_name);
 }
 
-int ksmbd_vfs_unlink(struct user_namespace *user_ns,
-		     struct dentry *dir, struct dentry *dentry)
+int ksmbd_vfs_unlink(struct ksmbd_share_config *share, char *filename)
 {
-	int err = 0;
-
-	err = ksmbd_vfs_lock_parent(user_ns, dir, dentry);
+	struct dentry *dentry;
+	struct path path;
+	struct qstr last;
+	struct filename *filename_struct;
+	struct inode *inode = NULL, *dir;
+	int type, err = 0;
+
+	filename_struct = getname_kernel(filename);
+	if (IS_ERR(filename_struct))
+		return PTR_ERR(filename_struct);
+
+	err = vfs_path_parent_lookup(share->vfs_path.dentry,
+				     share->vfs_path.mnt, filename_struct,
+				     LOOKUP_NO_SYMLINKS | LOOKUP_BENEATH,
+				     &path, &last, &type);
 	if (err)
-		return err;
-	dget(dentry);
+		goto putname;
 
-	if (S_ISDIR(d_inode(dentry)->i_mode))
-		err = vfs_rmdir(user_ns, d_inode(dir), dentry);
-	else
-		err = vfs_unlink(user_ns, d_inode(dir), dentry, NULL);
+	dir = d_inode(path.dentry);
+
+	inode_lock_nested(dir, I_MUTEX_PARENT);
+	dentry = __lookup_hash(&last, path.dentry, 0);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto unlock_inode;
+	}
 
+	if (d_is_negative(dentry)) {
+		err = -ENOENT;
+		dput(dentry);
+		goto unlock_inode;
+	}
+
+	inode = dentry->d_inode;
+	ihold(inode);
+	if (S_ISDIR(inode->i_mode))
+		err = vfs_rmdir(mnt_user_ns(path.mnt), dir, dentry);
+	else
+		err = vfs_unlink(mnt_user_ns(path.mnt), dir, dentry, NULL);
+	iput(inode);
 	dput(dentry);
-	inode_unlock(d_inode(dir));
+unlock_inode:
+	inode_unlock(dir);
 	if (err)
-		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
+		pr_err("failed to delete, err %d\n", err);
 
+	path_put(&path);
+putname:
+	putname(filename_struct);
 	return err;
 }
 
@@ -1258,6 +1184,7 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 				goto out;
 			else if (is_last) {
 				*path = parent;
+				memcpy(name, filepath, path_len);
 				goto out;
 			}
 
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 8c37aaf936ab..8e800e5f2e7b 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -69,11 +69,11 @@ struct ksmbd_kstat {
 	__le32			file_attributes;
 };
 
-int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry *parent,
-			  struct dentry *child);
-int ksmbd_vfs_may_delete(struct user_namespace *user_ns, struct dentry *dentry);
-int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
-				   struct dentry *dentry, __le32 *daccess);
+int ksmbd_vfs_may_delete(struct ksmbd_share_config *share, char *filename);
+void ksmbd_vfs_query_maximal_access(struct ksmbd_share_config *share,
+				    struct user_namespace *user_ns,
+				    struct dentry *dentry, char *filename,
+				    __le32 *daccess);
 int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode);
 int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode);
 int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp,
@@ -82,12 +82,11 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    char *buf, size_t count, loff_t *pos, bool sync,
 		    ssize_t *written);
 int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id);
-int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name);
 int ksmbd_vfs_link(struct ksmbd_work *work,
 		   const char *oldname, const char *newname);
 int ksmbd_vfs_getattr(struct path *path, struct kstat *stat);
-int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
-			char *newname);
+int ksmbd_vfs_rename(struct ksmbd_work *work, struct path *path, char *newname,
+		     int flags);
 int ksmbd_vfs_truncate(struct ksmbd_work *work,
 		       struct ksmbd_file *fp, loff_t size);
 struct srv_copychunk;
@@ -129,8 +128,7 @@ struct file_allocated_range_buffer;
 int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
 			 struct file_allocated_range_buffer *ranges,
 			 unsigned int in_count, unsigned int *out_count);
-int ksmbd_vfs_unlink(struct user_namespace *user_ns,
-		     struct dentry *dir, struct dentry *dentry);
+int ksmbd_vfs_unlink(struct ksmbd_share_config *share, char *filename);
 void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat);
 int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 				struct user_namespace *user_ns,
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 29c1db66bd0f..70b7c96002b9 100644
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
+			ksmbd_vfs_unlink(fp->tcon->share_conf, fp->filename);
 			write_lock(&ci->m_lock);
 		}
 		write_unlock(&ci->m_lock);
diff --git a/fs/namei.c b/fs/namei.c
index b867a92c078e..3a035112a18b 100644
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
@@ -2556,16 +2559,16 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
 }
 
 /* Note: this does not consume "name" */
-static int filename_parentat(int dfd, struct filename *name,
-			     unsigned int flags, struct path *parent,
-			     struct qstr *last, int *type)
+static int __filename_parentat(int dfd, struct filename *name,
+			       unsigned int flags, struct path *parent,
+			       struct qstr *last, int *type, struct path *root)
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
@@ -2580,6 +2583,13 @@ static int filename_parentat(int dfd, struct filename *name,
 	return retval;
 }
 
+int filename_parentat(int dfd, struct filename *name, unsigned int flags,
+		      struct path *parent, struct qstr *last, int *type)
+{
+	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
+}
+EXPORT_SYMBOL(filename_parentat);
+
 /* does lookup, returns the object with parent locked */
 static struct dentry *__kern_path_locked(struct filename *name, struct path *path)
 {
@@ -2623,6 +2633,27 @@ int kern_path(const char *name, unsigned int flags, struct path *path)
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
+int vfs_path_parent_lookup(struct dentry *dentry, struct vfsmount *mnt,
+			   struct filename *filename, unsigned int flags,
+			   struct path *parent, struct qstr *last, int *type)
+{
+	struct path root = {.mnt = mnt, .dentry = dentry};
+
+	return  __filename_parentat(AT_FDCWD, filename, flags, parent, last,
+				    type, &root);
+}
+EXPORT_SYMBOL(vfs_path_parent_lookup);
+
 /**
  * vfs_path_lookup - lookup a file path relative to a dentry-vfsmount pair
  * @dentry:  pointer to dentry of the base directory
diff --git a/include/linux/namei.h b/include/linux/namei.h
index e89329bb3134..3d9a46df2dbd 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -57,6 +57,10 @@ static inline int user_path_at(int dfd, const char __user *name, unsigned flags,
 	return user_path_at_empty(dfd, name, flags, path, NULL);
 }
 
+struct dentry *__lookup_hash(const struct qstr *name, struct dentry *base,
+			     unsigned int flags);
+int filename_parentat(int dfd, struct filename *name, unsigned int flags,
+		      struct path *parent, struct qstr *last, int *type);
 extern int kern_path(const char *, unsigned, struct path *);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
-- 
2.25.1

