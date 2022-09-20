Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFD75BF070
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 00:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiITWoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 18:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiITWoC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:44:02 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDF07268E;
        Tue, 20 Sep 2022 15:43:59 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id w10so2978997pll.11;
        Tue, 20 Sep 2022 15:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4C9D2XwSD4XAZYApU/2xqCelB9rvl/YRzKfGl6DFlxo=;
        b=gxSOq4WIvz3+x1qE+dgzbTHCqjQCsP5pBe/jiNnA/gA1MJfM21SLDjCG7PTMgc8jG7
         K6qmShLE5UVqiGmzRjYaFNvbvVZT53RS5q7KNP8txgXPg6pOk3A1c6S3oFLdAzYxSXT6
         DR7UyOJ0YvPrkKdSdIsiklyVSySfunQZxowFh6DlMIugTkZonbFUYeqtel2SuPQ2Xxlp
         u8WTWmXj81qmavpAlmdCM9Bl+6KKp8HjVfHTf4BJ0rEZVekE3mIjE49VyYE01dfri8Yg
         kvciqkjhTH5w4eDcvrqte0seErb5/c2itSBKaRSri2AS+tAo2Iy1Dv2BS0Trs3rRQ72J
         GpOA==
X-Gm-Message-State: ACrzQf066fBSEXRMb1+ugsGrbidbj13lEm+d9uXhvWJawo2Et06dCHNW
        jMXVAqu3K1Fgga19WvcCLVI=
X-Google-Smtp-Source: AMsMyM7yATapzvgfEzrZc//mSrl9vNibhSZmt96nDNddbLgsmH8moikpPezeWyOOL8USWC5rH0gf5Q==
X-Received: by 2002:a17:903:204b:b0:176:a6c5:4277 with SMTP id q11-20020a170903204b00b00176a6c54277mr1799179pla.24.1663713839253;
        Tue, 20 Sep 2022 15:43:59 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id 13-20020a62140d000000b0053e93aa8fb9sm451352pfu.71.2022.09.20.15.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 15:43:58 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        atteh.mailbox@gmail.com, Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v7 3/3] ksmbd: fix racy issue from using ->d_parent and ->d_name
Date:   Wed, 21 Sep 2022 07:43:38 +0900
Message-Id: <20220920224338.22217-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920224338.22217-1-linkinjeon@kernel.org>
References: <20220920224338.22217-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al pointed out that ksmbd has racy issue from using ->d_parent and ->d_name
in ksmbd_vfs_unlink and smb2_vfs_rename(). and use new lock_rename_child()
to lock stable parent while underlying rename racy.
Introduce vfs_path_parent_lookup helper to avoid out of share access and
export vfs functions like the following ones to use
vfs_path_parent_lookup().
 - rename __lookup_hash() to lookup_one_qstr_excl().
 - export lookup_one_qstr_excl().
 - export getname_kernel() and putname().

vfs_path_parent_lookup() is used for parent lookup of destination file
using absolute pathname given from FILE_RENAME_INFORMATION request.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ksmbd/smb2pdu.c    | 145 ++++-----------
 fs/ksmbd/vfs.c        | 413 +++++++++++++++++-------------------------
 fs/ksmbd/vfs.h        |  19 +-
 fs/ksmbd/vfs_cache.c  |   5 +-
 fs/namei.c            |  57 ++++--
 include/linux/namei.h |   6 +
 6 files changed, 261 insertions(+), 384 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 9dd6033bc4de..75c34b521a66 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2436,7 +2436,7 @@ static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
 			return rc;
 	}
 
-	rc = ksmbd_vfs_kern_path(work, name, 0, path, 0);
+	rc = ksmbd_vfs_kern_path_locked(work, name, 0, path, 0);
 	if (rc) {
 		pr_err("cannot get linux path (%s), err = %d\n",
 		       name, rc);
@@ -2727,8 +2727,10 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out1;
 	}
 
-	rc = ksmbd_vfs_kern_path(work, name, LOOKUP_NO_SYMLINKS, &path, 1);
+	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS, &path, 1);
 	if (!rc) {
+		file_present = true;
+
 		if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE) {
 			/*
 			 * If file exists with under flags, return access
@@ -2737,7 +2739,6 @@ int smb2_open(struct ksmbd_work *work)
 			if (req->CreateDisposition == FILE_OVERWRITE_IF_LE ||
 			    req->CreateDisposition == FILE_OPEN_IF_LE) {
 				rc = -EACCES;
-				path_put(&path);
 				goto err_out;
 			}
 
@@ -2745,26 +2746,23 @@ int smb2_open(struct ksmbd_work *work)
 				ksmbd_debug(SMB,
 					    "User does not have write permission\n");
 				rc = -EACCES;
-				path_put(&path);
 				goto err_out;
 			}
 		} else if (d_is_symlink(path.dentry)) {
 			rc = -EACCES;
-			path_put(&path);
 			goto err_out;
 		}
-	}
 
-	if (rc) {
+		file_present = true;
+		user_ns = mnt_user_ns(path.mnt);
+	} else {
 		if (rc != -ENOENT)
 			goto err_out;
 		ksmbd_debug(SMB, "can not get linux path for %s, rc = %d\n",
 			    name, rc);
 		rc = 0;
-	} else {
-		file_present = true;
-		user_ns = mnt_user_ns(path.mnt);
 	}
+
 	if (stream_name) {
 		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
 			if (s_type == DATA_STREAM) {
@@ -2892,8 +2890,9 @@ int smb2_open(struct ksmbd_work *work)
 
 			if ((daccess & FILE_DELETE_LE) ||
 			    (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
-				rc = ksmbd_vfs_may_delete(user_ns,
-							  path.dentry);
+				rc = inode_permission(user_ns,
+						      d_inode(path.dentry->d_parent),
+						      MAY_EXEC | MAY_WRITE);
 				if (rc)
 					goto err_out;
 			}
@@ -3261,10 +3260,13 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 err_out:
-	if (file_present || created)
+	if (file_present || created) {
+		inode_unlock(d_inode(path.dentry->d_parent));
 		path_put(&path);
+	}
 	ksmbd_revert_fsids(work);
 err_out1:
+
 	if (rc) {
 		if (rc == -EINVAL)
 			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
@@ -5403,44 +5405,19 @@ int smb2_echo(struct ksmbd_work *work)
 
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
-	abs_oldname = file_path(fp->filp, pathname, PATH_MAX);
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
@@ -5466,7 +5443,7 @@ static int smb2_rename(struct ksmbd_work *work,
 		if (rc)
 			goto out;
 
-		rc = ksmbd_vfs_setxattr(user_ns,
+		rc = ksmbd_vfs_setxattr(file_mnt_user_ns(fp->filp),
 					fp->filp->f_path.dentry,
 					xattr_stream_name,
 					NULL, 0, 0);
@@ -5481,47 +5458,18 @@ static int smb2_rename(struct ksmbd_work *work,
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
 
@@ -5561,18 +5509,17 @@ static int smb2_create_link(struct ksmbd_work *work,
 	}
 
 	ksmbd_debug(SMB, "target name is %s\n", target_name);
-	rc = ksmbd_vfs_kern_path(work, link_name, LOOKUP_NO_SYMLINKS, &path, 0);
+	rc = ksmbd_vfs_kern_path_locked(work, link_name, LOOKUP_NO_SYMLINKS,
+					&path, 0);
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
 		file_present = false;
-	} else {
-		path_put(&path);
 	}
 
 	if (file_info->ReplaceIfExists) {
 		if (file_present) {
-			rc = ksmbd_vfs_remove_file(work, link_name);
+			rc = ksmbd_vfs_remove_file(work, &path);
 			if (rc) {
 				rc = -EINVAL;
 				ksmbd_debug(SMB, "cannot delete %s\n",
@@ -5592,6 +5539,10 @@ static int smb2_create_link(struct ksmbd_work *work,
 	if (rc)
 		rc = -EINVAL;
 out:
+	if (file_present) {
+		inode_unlock(d_inode(path.dentry->d_parent));
+		path_put(&path);
+	}
 	if (!IS_ERR(link_name))
 		kfree(link_name);
 	kfree(pathname);
@@ -5769,12 +5720,6 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
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
@@ -5784,32 +5729,10 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
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
+	if (!le32_to_cpu(rename_info->FileNameLength))
+		return -EINVAL;
 
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
-			   work->conn->local_nls);
+	return smb2_rename(work, fp, rename_info, work->conn->local_nls);
 }
 
 static int set_file_disposition_info(struct ksmbd_file *fp,
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index d994ee1f2c18..619d13100b27 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -17,6 +17,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sched/xacct.h>
 #include <linux/crc32c.h>
+#include <linux/namei.h>
 
 #include "glob.h"
 #include "oplock.h"
@@ -34,19 +35,6 @@
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
@@ -60,65 +48,46 @@ static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
 
 /**
  * ksmbd_vfs_lock_parent() - lock parent dentry if it is stable
- *
- * the parent dentry got by dget_parent or @parent could be
- * unstable, we try to lock a parent inode and lookup the
- * child dentry again.
- *
- * the reference count of @parent isn't incremented.
  */
-int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry *parent,
-			  struct dentry *child)
+int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
 {
-	struct dentry *dentry;
-	int ret = 0;
-
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	dentry = lookup_one(user_ns, child->d_name.name, parent,
-			    child->d_name.len);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto out_err;
-	}
-
-	if (dentry != child) {
-		ret = -ESTALE;
-		dput(dentry);
-		goto out_err;
+	if (child->d_parent != parent) {
+		inode_unlock(d_inode(parent));
+		return -ENOENT;
 	}
 
-	dput(dentry);
 	return 0;
-out_err:
-	inode_unlock(d_inode(parent));
-	return ret;
 }
 
-int ksmbd_vfs_may_delete(struct user_namespace *user_ns,
-			 struct dentry *dentry)
+static int ksmbd_vfs_path_parent_lookup(struct ksmbd_share_config *share_conf,
+					char *pathname, unsigned int flags,
+					struct path *parent_path)
 {
-	struct dentry *parent;
-	int ret;
+	struct qstr last;
+	struct filename *filename;
+	struct path *root_share_path = &share_conf->vfs_path;
+	int err, type;
 
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
+	if (pathname[0] == '\0') {
+		pathname = share_conf->path;
+		root_share_path = NULL;
 	}
 
-	ret = inode_permission(user_ns, d_inode(parent),
-			       MAY_EXEC | MAY_WRITE);
+	filename = getname_kernel(pathname);
+	if (IS_ERR(filename))
+		return PTR_ERR(filename);
 
-	inode_unlock(d_inode(parent));
-	dput(parent);
-	return ret;
+	err = vfs_path_parent_lookup(filename, flags,
+				     parent_path, &last, &type,
+				     root_share_path);
+	putname(filename);
+	return err;
 }
 
 int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
 				   struct dentry *dentry, __le32 *daccess)
 {
-	struct dentry *parent;
 	int ret = 0;
 
 	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
@@ -135,18 +104,9 @@ int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
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
+	if (!inode_permission(user_ns, d_inode(dentry->d_parent), MAY_EXEC | MAY_WRITE))
 		*daccess |= FILE_DELETE_LE;
 
-	inode_unlock(d_inode(parent));
-	dput(parent);
 	return ret;
 }
 
@@ -579,54 +539,32 @@ int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id)
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
+int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 {
 	struct user_namespace *user_ns;
-	struct path path;
-	struct dentry *parent;
+	struct dentry *parent = path->dentry->d_parent;
 	int err;
 
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
 
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
+	if (!d_inode(path->dentry)->i_nlink) {
 		err = -ENOENT;
 		goto out_err;
 	}
 
-	if (S_ISDIR(d_inode(path.dentry)->i_mode)) {
-		err = vfs_rmdir(user_ns, d_inode(parent), path.dentry);
+	user_ns = mnt_user_ns(path->mnt);
+	if (S_ISDIR(d_inode(path->dentry)->i_mode)) {
+		err = vfs_rmdir(user_ns, d_inode(parent), path->dentry);
 		if (err && err != -ENOTEMPTY)
-			ksmbd_debug(VFS, "%s: rmdir failed, err %d\n", name,
-				    err);
+			ksmbd_debug(VFS, "rmdir failed, err %d\n", err);
 	} else {
-		err = vfs_unlink(user_ns, d_inode(parent), path.dentry, NULL);
+		err = vfs_unlink(user_ns, d_inode(parent), path->dentry, NULL);
 		if (err)
-			ksmbd_debug(VFS, "%s: unlink failed, err %d\n", name,
-				    err);
+			ksmbd_debug(VFS, "unlink failed, err %d\n", err);
 	}
 
 out_err:
-	inode_unlock(d_inode(parent));
-	dput(parent);
-	path_put(&path);
 	ksmbd_revert_fsids(work);
 	return err;
 }
@@ -685,149 +623,114 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 	return err;
 }
 
-static int ksmbd_validate_entry_in_use(struct dentry *src_dent)
+int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
+		     char *newname, int flags)
 {
-	struct dentry *dst_dent;
-
-	spin_lock(&src_dent->d_lock);
-	list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
-		struct ksmbd_file *child_fp;
+	struct dentry *old_parent, *new_dentry, *trap;
+	struct dentry *old_child = old_path->dentry;
+	struct path new_path;
+	struct qstr new_last;
+	struct renamedata rd;
+	struct filename *to;
+	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
+	struct ksmbd_file *parent_fp;
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
 
-	return 0;
-}
+retry:
+	err = vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
+				     &new_path, &new_last, &new_type,
+				     &share_conf->vfs_path);
+	if (err)
+		goto out1;
 
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
+	if (old_path->mnt != new_path.mnt) {
+		err = -EXDEV;
+		goto out2;
+	}
 
-	if (!work->tcon->posix_extensions) {
-		err = ksmbd_validate_entry_in_use(src_dent);
-		if (err)
-			return err;
+	trap = lock_rename_child(old_child, new_path.dentry);
+
+	old_parent = dget(old_child->d_parent);
+	if (d_unhashed(old_child)) {
+		err = -EINVAL;
+		goto out3;
 	}
 
-	if (d_really_is_negative(src_dent_parent))
-		return -ENOENT;
-	if (d_really_is_negative(dst_dent_parent))
-		return -ENOENT;
-	if (d_really_is_negative(src_dent))
-		return -ENOENT;
-	if (src_dent == trap_dent)
-		return -EINVAL;
+	parent_fp = ksmbd_lookup_fd_inode(d_inode(old_child->d_parent));
+	if (parent_fp) {
+		if (parent_fp->daccess & FILE_DELETE_LE) {
+			pr_err("parent dir is opened with delete access\n");
+			err = -ESHARE;
+			ksmbd_fd_put(work, parent_fp);
+			goto out3;
+		}
+		ksmbd_fd_put(work, parent_fp);
+	}
 
-	if (ksmbd_override_fsids(work))
-		return -ENOMEM;
+	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
+					  lookup_flags | LOOKUP_RENAME_TARGET);
+	if (IS_ERR(new_dentry)) {
+		err = PTR_ERR(new_dentry);
+		goto out3;
+	}
 
-	dst_dent = lookup_one(dst_user_ns, dst_name, dst_dent_parent,
-			      strlen(dst_name));
-	err = PTR_ERR(dst_dent);
-	if (IS_ERR(dst_dent)) {
-		pr_err("lookup failed %s [%d]\n", dst_name, err);
-		goto out;
+	if (d_is_symlink(new_dentry)) {
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
+	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry)) {
+		err = -EEXIST;
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
+	if (old_child == trap) {
+		err = -EINVAL;
+		goto out4;
+	}
 
-	dst_name = extract_last_component(newname);
-	if (!dst_name) {
-		dst_name = newname;
-		newname = "";
+	if (new_dentry == trap) {
+		err = -ENOTEMPTY;
+		goto out4;
 	}
 
-	src_dent_parent = dget_parent(fp->filp->f_path.dentry);
-	src_dent = fp->filp->f_path.dentry;
+	rd.old_mnt_userns	= mnt_user_ns(old_path->mnt),
+	rd.old_dir		= d_inode(old_parent),
+	rd.old_dentry		= old_child,
+	rd.new_mnt_userns	= mnt_user_ns(new_path.mnt),
+	rd.new_dir		= new_path.dentry->d_inode,
+	rd.new_dentry		= new_dentry,
+	rd.flags		= flags,
+	err = vfs_rename(&rd);
+	if (err)
+		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
 
-	err = ksmbd_vfs_kern_path(work, newname,
-				  LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
-				  &dst_path, false);
-	if (err) {
-		ksmbd_debug(VFS, "Cannot get path for %s [%d]\n", newname, err);
-		goto out;
+out4:
+	dput(new_dentry);
+out3:
+	dput(old_parent);
+	unlock_rename(old_parent, new_path.dentry);
+out2:
+	path_put(&new_path);
+
+	if (retry_estale(err, lookup_flags)) {
+		lookup_flags |= LOOKUP_REVAL;
+		goto retry;
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
+out1:
+	putname(to);
+revert_fsids:
+	ksmbd_revert_fsids(work);
 	return err;
 }
 
@@ -1078,14 +981,16 @@ int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
 	return vfs_removexattr(user_ns, dentry, attr_name);
 }
 
-int ksmbd_vfs_unlink(struct user_namespace *user_ns,
-		     struct dentry *dir, struct dentry *dentry)
+int ksmbd_vfs_unlink(struct file *filp)
 {
 	int err = 0;
+	struct dentry *dir, *dentry = filp->f_path.dentry;
+	struct user_namespace *user_ns = file_mnt_user_ns(filp);
 
-	err = ksmbd_vfs_lock_parent(user_ns, dir, dentry);
+	dir = dget_parent(dentry);
+	err = ksmbd_vfs_lock_parent(dir, dentry);
 	if (err)
-		return err;
+		goto out;
 	dget(dentry);
 
 	if (S_ISDIR(d_inode(dentry)->i_mode))
@@ -1097,6 +1002,8 @@ int ksmbd_vfs_unlink(struct user_namespace *user_ns,
 	inode_unlock(d_inode(dir));
 	if (err)
 		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
+out:
+	dput(dir);
 
 	return err;
 }
@@ -1196,24 +1103,30 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name, size_t na
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
-			unsigned int flags, struct path *path, bool caseless)
+int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
+			       unsigned int flags, struct path *path,
+			       bool caseless)
 {
 	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
 	int err;
+	struct path parent_path;
 
+	err = ksmbd_vfs_path_parent_lookup(share_conf, name, flags,
+					   &parent_path);
 	flags |= LOOKUP_BENEATH;
-	err = vfs_path_lookup(share_conf->vfs_path.dentry,
-			      share_conf->vfs_path.mnt,
-			      name,
-			      flags,
-			      path);
-	if (!err)
-		return 0;
+	if (!err) {
+		err = vfs_path_lookup(share_conf->vfs_path.dentry,
+				      share_conf->vfs_path.mnt,
+				      name,
+				      flags,
+				      path);
+		if (!err)
+			goto lock_parent;
+		path_put(&parent_path);
+	}
 
 	if (caseless) {
 		char *filepath;
-		struct path parent;
 		size_t path_len, remain_len;
 
 		filepath = kstrdup(name, GFP_KERNEL);
@@ -1223,10 +1136,10 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 		path_len = strlen(filepath);
 		remain_len = path_len;
 
-		parent = share_conf->vfs_path;
-		path_get(&parent);
+		parent_path = share_conf->vfs_path;
+		path_get(&parent_path);
 
-		while (d_can_lookup(parent.dentry)) {
+		while (d_can_lookup(parent_path.dentry)) {
 			char *filename = filepath + path_len - remain_len;
 			char *next = strchrnul(filename, '/');
 			size_t filename_len = next - filename;
@@ -1235,11 +1148,10 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 			if (filename_len == 0)
 				break;
 
-			err = ksmbd_vfs_lookup_in_dir(&parent, filename,
+			err = ksmbd_vfs_lookup_in_dir(&parent_path, filename,
 						      filename_len);
-			path_put(&parent);
 			if (err)
-				goto out;
+				goto out2;
 
 			next[0] = '\0';
 
@@ -1247,23 +1159,32 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 					      share_conf->vfs_path.mnt,
 					      filepath,
 					      flags,
-					      &parent);
+					      path);
 			if (err)
-				goto out;
-			else if (is_last) {
-				*path = parent;
-				goto out;
-			}
+				goto out2;
+			else if (is_last)
+				goto out1;
+			path_put(&parent_path);
+			parent_path = *path;
 
 			next[0] = '/';
 			remain_len -= filename_len + 1;
 		}
 
-		path_put(&parent);
 		err = -EINVAL;
-out:
+out2:
+		path_put(&parent_path);
+out1:
 		kfree(filepath);
 	}
+
+lock_parent:
+	if (!err) {
+		err = ksmbd_vfs_lock_parent(parent_path.dentry, path->dentry);
+		if (err)
+			path_put(path);
+		path_put(&parent_path);
+	}
 	return err;
 }
 
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index d7542a2dab52..e89b55f3de98 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -69,9 +69,7 @@ struct ksmbd_kstat {
 	__le32			file_attributes;
 };
 
-int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry *parent,
-			  struct dentry *child);
-int ksmbd_vfs_may_delete(struct user_namespace *user_ns, struct dentry *dentry);
+int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child);
 int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
 				   struct dentry *dentry, __le32 *daccess);
 int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode);
@@ -82,12 +80,12 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    char *buf, size_t count, loff_t *pos, bool sync,
 		    ssize_t *written);
 int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id);
-int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name);
+int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path);
 int ksmbd_vfs_link(struct ksmbd_work *work,
 		   const char *oldname, const char *newname);
 int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat);
-int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
-			char *newname);
+int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
+		     char *newname, int flags);
 int ksmbd_vfs_truncate(struct ksmbd_work *work,
 		       struct ksmbd_file *fp, loff_t size);
 struct srv_copychunk;
@@ -114,9 +112,9 @@ int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 				size_t *xattr_stream_name_size, int s_type);
 int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
 			   struct dentry *dentry, char *attr_name);
-int ksmbd_vfs_kern_path(struct ksmbd_work *work,
-			char *name, unsigned int flags, struct path *path,
-			bool caseless);
+int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
+			       unsigned int flags, struct path *path,
+			       bool caseless);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
@@ -129,8 +127,7 @@ struct file_allocated_range_buffer;
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
index da9163b00350..fb944482b652 100644
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
index 5ff7f2a9e54e..9c28400aaf75 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -253,6 +253,7 @@ getname_kernel(const char * filename)
 
 	return result;
 }
+EXPORT_SYMBOL(getname_kernel);
 
 void putname(struct filename *name)
 {
@@ -270,6 +271,7 @@ void putname(struct filename *name)
 	} else
 		__putname(name);
 }
+EXPORT_SYMBOL(putname);
 
 /**
  * check_acl - perform ACL permission checking
@@ -1580,8 +1582,9 @@ static struct dentry *lookup_dcache(const struct qstr *name,
  * when directory is guaranteed to have no in-lookup children
  * at all.
  */
-static struct dentry *__lookup_hash(const struct qstr *name,
-		struct dentry *base, unsigned int flags)
+struct dentry *lookup_one_qstr_excl(const struct qstr *name,
+				    struct dentry *base,
+				    unsigned int flags)
 {
 	struct dentry *dentry = lookup_dcache(name, base, flags);
 	struct dentry *old;
@@ -1605,6 +1608,7 @@ static struct dentry *__lookup_hash(const struct qstr *name,
 	}
 	return dentry;
 }
+EXPORT_SYMBOL(lookup_one_qstr_excl);
 
 static struct dentry *lookup_fast(struct nameidata *nd)
 {
@@ -2531,16 +2535,17 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
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
@@ -2555,6 +2560,13 @@ static int filename_parentat(int dfd, struct filename *name,
 	return retval;
 }
 
+static int filename_parentat(int dfd, struct filename *name,
+			     unsigned int flags, struct path *parent,
+			     struct qstr *last, int *type)
+{
+	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
+}
+
 /* does lookup, returns the object with parent locked */
 static struct dentry *__kern_path_locked(struct filename *name, struct path *path)
 {
@@ -2570,7 +2582,7 @@ static struct dentry *__kern_path_locked(struct filename *name, struct path *pat
 		return ERR_PTR(-EINVAL);
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	d = __lookup_hash(&last, path->dentry, 0);
+	d = lookup_one_qstr_excl(&last, path->dentry, 0);
 	if (IS_ERR(d)) {
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
@@ -2598,6 +2610,24 @@ int kern_path(const char *name, unsigned int flags, struct path *path)
 }
 EXPORT_SYMBOL(kern_path);
 
+/**
+ * vfs_path_parent_lookup - lookup a parent path relative to a dentry-vfsmount pair
+ * @filename: filename structure
+ * @flags: lookup flags
+ * @parent: pointer to struct path to fill
+ * @last: last component
+ * @type: type of the last component
+ * @root: pointer to struct path of the base directory
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
@@ -3806,7 +3836,8 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	if (last.name[last.len] && !want_dir)
 		create_flags = 0;
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path->dentry, reval_flag | create_flags);
+	dentry = lookup_one_qstr_excl(&last, path->dentry,
+				      reval_flag | create_flags);
 	if (IS_ERR(dentry))
 		goto unlock;
 
@@ -4168,7 +4199,7 @@ int do_rmdir(int dfd, struct filename *name)
 		goto exit2;
 
 	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
@@ -4302,7 +4333,7 @@ int do_unlinkat(int dfd, struct filename *name)
 		goto exit2;
 retry_deleg:
 	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		struct user_namespace *mnt_userns;
@@ -4871,7 +4902,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 retry_deleg:
 	trap = lock_rename(new_path.dentry, old_path.dentry);
 
-	old_dentry = __lookup_hash(&old_last, old_path.dentry, lookup_flags);
+	old_dentry = lookup_one_qstr_excl(&old_last, old_path.dentry,
+					  lookup_flags);
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
@@ -4879,7 +4911,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	error = -ENOENT;
 	if (d_is_negative(old_dentry))
 		goto exit4;
-	new_dentry = __lookup_hash(&new_last, new_path.dentry, lookup_flags | target_flags);
+	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
+					  lookup_flags | target_flags);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto exit4;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 7868732cce24..53c03d9ed34c 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -57,12 +57,18 @@ static inline int user_path_at(int dfd, const char __user *name, unsigned flags,
 	return user_path_at_empty(dfd, name, flags, path, NULL);
 }
 
+struct dentry *lookup_one_qstr_excl(const struct qstr *name,
+				    struct dentry *base,
+				    unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
+int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
+			   struct path *parent, struct qstr *last, int *type,
+			   const struct path *root);
 int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
 		    unsigned int, struct path *);
 
-- 
2.25.1

