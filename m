Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61965E5DC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiIVIpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiIVIo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9755B79A
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663836294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rcFQG0iVLGv2/ysstKj5Y5FuHiIoW0CS65N+NYHLtI=;
        b=bnYiTdC97vo1LDUgKV1v2BqnhQrkgaBQmk5S3gje+Y6opaKBh7qXHh9CkHhGiHhTwvmGxn
        xdIH5/u/TsIRzZFom2rcSFfoB/0Jq2zczvEJ2pJih6vGnUlS0JDLb6lqRRGOEiEvz/WsBm
        EZcozI3C8skBocHI1ygbTd9nT8gfKDY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-uhOZF1UmN3iMOM5aYGKH-A-1; Thu, 22 Sep 2022 04:44:52 -0400
X-MC-Unique: uhOZF1UmN3iMOM5aYGKH-A-1
Received: by mail-ed1-f69.google.com with SMTP id y9-20020a056402270900b00451dfbbc9b2so6147187edd.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6rcFQG0iVLGv2/ysstKj5Y5FuHiIoW0CS65N+NYHLtI=;
        b=OF2Tl37dW/b3MuAlFyh8pC615hxLfXxRnAO+PZB7YKMnwqXitcM93Z6E/ywNf6yBsr
         oMua5GL/rwAIMWWfId6JF2O0o8ffWGBFZoejLQXUqJhFtSRMoQXXlxhJVH25fpXST46m
         9bhlZfSgZ1qafVGa6nVspGpEIvAK1AXVThaM9/KK/diOM2iQO6tDlS6xFx/1NxzZ+Qmh
         2/69904GoCjsfoLNjrUDYsihO7DB7IHgJ6aR3t997LsWi3IzyhoytwO65888uksZH9pt
         +3+enwIVmF9bwtwi6yNwAAfPH/Z8YpAsR3zh0YSstLeoUWlCmBAznMNoMzrNgWXwAMu8
         JlfQ==
X-Gm-Message-State: ACrzQf3k1hwHeZCoRTNp9O8/siTBPRptMOxZ3JSOlZ/JjwuMP+mSnt3k
        7JqgUQ+1dO9rglfyDY48PVo0ITyL0z2Hk8eFhmUeFeuL3rL1dXLzoMoWSehfXK8vx0oiyNdSb92
        4qOy3EAGY/RYzRk6MyDm1gHgBsMDzudany8H6G09G9ewteyo2l6GLx5sp2pnZumghHfQ4u7W2eD
        cn4Q==
X-Received: by 2002:aa7:de91:0:b0:451:ecf8:e3b6 with SMTP id j17-20020aa7de91000000b00451ecf8e3b6mr2078391edv.402.1663836291291;
        Thu, 22 Sep 2022 01:44:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4QhYPOlANG7yL0Meuo62QZQ/eQCwLMy0EhcU1nqAz3LIqGJimKl+4U23oUTnsHFrXhD7c9FA==
X-Received: by 2002:aa7:de91:0:b0:451:ecf8:e3b6 with SMTP id j17-20020aa7de91000000b00451ecf8e3b6mr2078375edv.402.1663836291017;
        Thu, 22 Sep 2022 01:44:51 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906718f00b00730b3bdd8d7sm2297942ejk.179.2022.09.22.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:44:50 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v4 06/10] ovl: use vfs_tmpfile_open() helper
Date:   Thu, 22 Sep 2022 10:44:38 +0200
Message-Id: <20220922084442.2401223-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922084442.2401223-1-mszeredi@redhat.com>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If tmpfile is used for copy up, then use this helper to create the tmpfile
and open it at the same time.  This will later allow filesystems such as
fuse to do this operation atomically.

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c   | 108 +++++++++++++++++++++------------------
 fs/overlayfs/overlayfs.h |  14 ++---
 fs/overlayfs/super.c     |  10 ++--
 fs/overlayfs/util.c      |   2 +-
 4 files changed, 72 insertions(+), 62 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index fdde6c56cc3d..62a63e9ca57d 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -193,11 +193,11 @@ static int ovl_copy_fileattr(struct inode *inode, struct path *old,
 	return ovl_real_fileattr_set(new, &newfa);
 }
 
-static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
-			    struct path *new, loff_t len)
+static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
+			    struct file *new_file, loff_t len)
 {
+	struct path datapath;
 	struct file *old_file;
-	struct file *new_file;
 	loff_t old_pos = 0;
 	loff_t new_pos = 0;
 	loff_t cloned;
@@ -206,23 +206,18 @@ static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
 	bool skip_hole = false;
 	int error = 0;
 
-	if (len == 0)
-		return 0;
+	ovl_path_lowerdata(dentry, &datapath);
+	if (WARN_ON(datapath.dentry == NULL))
+		return -EIO;
 
-	old_file = ovl_path_open(old, O_LARGEFILE | O_RDONLY);
+	old_file = ovl_path_open(&datapath, O_LARGEFILE | O_RDONLY);
 	if (IS_ERR(old_file))
 		return PTR_ERR(old_file);
 
-	new_file = ovl_path_open(new, O_LARGEFILE | O_WRONLY);
-	if (IS_ERR(new_file)) {
-		error = PTR_ERR(new_file);
-		goto out_fput;
-	}
-
 	/* Try to use clone_file_range to clone up within the same fs */
 	cloned = do_clone_file_range(old_file, 0, new_file, 0, len, 0);
 	if (cloned == len)
-		goto out;
+		goto out_fput;
 	/* Couldn't clone, so now we try to copy the data */
 
 	/* Check if lower fs supports seek operation */
@@ -282,10 +277,8 @@ static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
 
 		len -= bytes;
 	}
-out:
 	if (!error && ovl_should_sync(ofs))
 		error = vfs_fsync(new_file, 0);
-	fput(new_file);
 out_fput:
 	fput(old_file);
 	return error;
@@ -556,30 +549,31 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 	return err;
 }
 
-static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
+static int ovl_copy_up_data(struct ovl_copy_up_ctx *c, const struct path *temp)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
-	struct inode *inode = d_inode(c->dentry);
-	struct path upperpath, datapath;
+	struct file *new_file;
 	int err;
 
-	ovl_path_upper(c->dentry, &upperpath);
-	if (WARN_ON(upperpath.dentry != NULL))
-		return -EIO;
+	if (!S_ISREG(c->stat.mode) || c->metacopy || !c->stat.size)
+		return 0;
 
-	upperpath.dentry = temp;
+	new_file = ovl_path_open(temp, O_LARGEFILE | O_WRONLY);
+	if (IS_ERR(new_file))
+		return PTR_ERR(new_file);
 
-	/*
-	 * Copy up data first and then xattrs. Writing data after
-	 * xattrs will remove security.capability xattr automatically.
-	 */
-	if (S_ISREG(c->stat.mode) && !c->metacopy) {
-		ovl_path_lowerdata(c->dentry, &datapath);
-		err = ovl_copy_up_data(ofs, &datapath, &upperpath,
-				       c->stat.size);
-		if (err)
-			return err;
-	}
+	err = ovl_copy_up_file(ofs, c->dentry, new_file, c->stat.size);
+	fput(new_file);
+
+	return err;
+}
+
+static int ovl_copy_up_metadata(struct ovl_copy_up_ctx *c, struct dentry *temp)
+{
+	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
+	struct inode *inode = d_inode(c->dentry);
+	struct path upperpath = { .mnt = ovl_upper_mnt(ofs), .dentry = temp };
+	int err;
 
 	err = ovl_copy_xattr(c->dentry->d_sb, &c->lowerpath, temp);
 	if (err)
@@ -662,6 +656,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *inode;
 	struct inode *udir = d_inode(c->destdir), *wdir = d_inode(c->workdir);
+	struct path path = { .mnt = ovl_upper_mnt(ofs) };
 	struct dentry *temp, *upper;
 	struct ovl_cu_creds cc;
 	int err;
@@ -688,7 +683,16 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (IS_ERR(temp))
 		goto unlock;
 
-	err = ovl_copy_up_inode(c, temp);
+	/*
+	 * Copy up data first and then xattrs. Writing data after
+	 * xattrs will remove security.capability xattr automatically.
+	 */
+	path.dentry = temp;
+	err = ovl_copy_up_data(c, &path);
+	if (err)
+		goto cleanup;
+
+	err = ovl_copy_up_metadata(c, temp);
 	if (err)
 		goto cleanup;
 
@@ -732,6 +736,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *udir = d_inode(c->destdir);
 	struct dentry *temp, *upper;
+	struct file *tmpfile;
 	struct ovl_cu_creds cc;
 	int err;
 
@@ -739,15 +744,22 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	if (err)
 		return err;
 
-	temp = ovl_do_tmpfile(ofs, c->workdir, c->stat.mode);
+	tmpfile = ovl_do_tmpfile(ofs, c->workdir, c->stat.mode);
 	ovl_revert_cu_creds(&cc);
 
-	if (IS_ERR(temp))
-		return PTR_ERR(temp);
+	if (IS_ERR(tmpfile))
+		return PTR_ERR(tmpfile);
 
-	err = ovl_copy_up_inode(c, temp);
+	temp = tmpfile->f_path.dentry;
+	if (!c->metacopy && c->stat.size) {
+		err = ovl_copy_up_file(ofs, c->dentry, tmpfile, c->stat.size);
+		if (err)
+			return err;
+	}
+
+	err = ovl_copy_up_metadata(c, temp);
 	if (err)
-		goto out_dput;
+		goto out_fput;
 
 	inode_lock_nested(udir, I_MUTEX_PARENT);
 
@@ -761,16 +773,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	inode_unlock(udir);
 
 	if (err)
-		goto out_dput;
+		goto out_fput;
 
 	if (!c->metacopy)
 		ovl_set_upperdata(d_inode(c->dentry));
-	ovl_inode_update(d_inode(c->dentry), temp);
+	ovl_inode_update(d_inode(c->dentry), dget(temp));
 
-	return 0;
-
-out_dput:
-	dput(temp);
+out_fput:
+	fput(tmpfile);
 	return err;
 }
 
@@ -899,7 +909,7 @@ static ssize_t ovl_getxattr_value(struct path *path, char *name, char **value)
 static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
-	struct path upperpath, datapath;
+	struct path upperpath;
 	int err;
 	char *capability = NULL;
 	ssize_t cap_size;
@@ -908,10 +918,6 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	if (WARN_ON(upperpath.dentry == NULL))
 		return -EIO;
 
-	ovl_path_lowerdata(c->dentry, &datapath);
-	if (WARN_ON(datapath.dentry == NULL))
-		return -EIO;
-
 	if (c->stat.size) {
 		err = cap_size = ovl_getxattr_value(&upperpath, XATTR_NAME_CAPS,
 						    &capability);
@@ -919,7 +925,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 			goto out;
 	}
 
-	err = ovl_copy_up_data(ofs, &datapath, &upperpath, c->stat.size);
+	err = ovl_copy_up_data(c, &upperpath);
 	if (err)
 		goto out_free;
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 87759165d32b..0f9dbd0e2ff5 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -310,14 +310,16 @@ static inline int ovl_do_whiteout(struct ovl_fs *ofs,
 	return err;
 }
 
-static inline struct dentry *ovl_do_tmpfile(struct ovl_fs *ofs,
-					    struct dentry *dentry, umode_t mode)
+static inline struct file *ovl_do_tmpfile(struct ovl_fs *ofs,
+					  struct dentry *dentry, umode_t mode)
 {
-	struct dentry *ret = vfs_tmpfile(ovl_upper_mnt_userns(ofs), dentry, mode, 0);
-	int err = PTR_ERR_OR_ZERO(ret);
+	struct path path = { .mnt = ovl_upper_mnt(ofs), .dentry = dentry };
+	struct file *file = vfs_tmpfile_open(ovl_upper_mnt_userns(ofs), &path, mode,
+					O_LARGEFILE | O_WRONLY, current_cred());
+	int err = PTR_ERR_OR_ZERO(file);
 
 	pr_debug("tmpfile(%pd2, 0%o) = %i\n", dentry, mode, err);
-	return ret;
+	return file;
 }
 
 static inline struct dentry *ovl_lookup_upper(struct ovl_fs *ofs,
@@ -401,7 +403,7 @@ void ovl_inode_update(struct inode *inode, struct dentry *upperdentry);
 void ovl_dir_modified(struct dentry *dentry, bool impurity);
 u64 ovl_dentry_version_get(struct dentry *dentry);
 bool ovl_is_whiteout(struct dentry *dentry);
-struct file *ovl_path_open(struct path *path, int flags);
+struct file *ovl_path_open(const struct path *path, int flags);
 int ovl_copy_up_start(struct dentry *dentry, int flags);
 void ovl_copy_up_end(struct dentry *dentry);
 bool ovl_already_copied_up(struct dentry *dentry, int flags);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ec746d447f1b..7837223689c1 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
+#include <linux/file.h>
 #include "overlayfs.h"
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
@@ -1356,7 +1357,8 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 			    struct path *workpath)
 {
 	struct vfsmount *mnt = ovl_upper_mnt(ofs);
-	struct dentry *temp, *workdir;
+	struct dentry *workdir;
+	struct file *tmpfile;
 	bool rename_whiteout;
 	bool d_type;
 	int fh_type;
@@ -1392,10 +1394,10 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 		pr_warn("upper fs needs to support d_type.\n");
 
 	/* Check if upper/work fs supports O_TMPFILE */
-	temp = ovl_do_tmpfile(ofs, ofs->workdir, S_IFREG | 0);
-	ofs->tmpfile = !IS_ERR(temp);
+	tmpfile = ovl_do_tmpfile(ofs, ofs->workdir, S_IFREG | 0);
+	ofs->tmpfile = !IS_ERR(tmpfile);
 	if (ofs->tmpfile)
-		dput(temp);
+		fput(tmpfile);
 	else
 		pr_warn("upper fs does not support tmpfile.\n");
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 87f811c089e4..968926c0c7ab 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -490,7 +490,7 @@ bool ovl_is_whiteout(struct dentry *dentry)
 	return inode && IS_WHITEOUT(inode);
 }
 
-struct file *ovl_path_open(struct path *path, int flags)
+struct file *ovl_path_open(const struct path *path, int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct user_namespace *real_mnt_userns = mnt_user_ns(path->mnt);
-- 
2.37.3

