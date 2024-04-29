Return-Path: <linux-fsdevel+bounces-18105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 221548B59D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 15:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2D11C239AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603AC5F861;
	Mon, 29 Apr 2024 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oxcqpyph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4EC42055
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397188; cv=none; b=epkXkV+l8ozb+m5xzkd+O0Bs+Wx/iK9sR9g/rBmvL5+kVyKqjYxjCngfPOxmv4HwKjbnC5Xt5LaYIpPZ7y0p/H159be8k/j/MGrj3bKYdZbHqxlE80Iwk00xWKksA7sC6BL42SdNwZxc2TUO/xeb0z6I6Tm4QPOsKn1mVQQR6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397188; c=relaxed/simple;
	bh=JF8s8pfUNALjYV4XYo6IZD3fk7FpqAUkyRR3EltZ8AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAHyrEZ6grjL/08EVgokA8CfGJOcbHcp7oxDp9XSlKGTigVEMb1BX5WwgkhFWNT06aC7CZCW9RtsvE7y5MZ84WqK6JUWHxTK3WCwTlAgJOo/PUygc/YbalREeLE0gOKEEmZhJGVAvlyq8INfbSZnuw1ZnEu/JPkkovWx9Q7kfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oxcqpyph; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714397185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g/UFL8mP+AUxpEYC9faxnXPXi2vEiwF5wGayAgrqKmo=;
	b=OxcqpyphEjDaXyjphKK4QldT0ILmzSXCGEKKuklDNDimjb9kPcAxA9ZDq4RgTWlP3+XRy2
	18EGkI4nvQJgaduWjvbU6BEl3df/k9guSbzLvxdROR97aCuTHcC2hJPE8v4S4hGwSfx5pe
	0c3/HS9Vwden6ym0+STX4tBkfS4MCsA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-9oX-nYRSPDqJbLiEFjrPfQ-1; Mon, 29 Apr 2024 09:26:24 -0400
X-MC-Unique: 9oX-nYRSPDqJbLiEFjrPfQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34bb415008bso3250482f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 06:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397183; x=1715001983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/UFL8mP+AUxpEYC9faxnXPXi2vEiwF5wGayAgrqKmo=;
        b=f2B3PKsKxYt+346GB7TDAzQSfxnTg3KPjSzCzBbihhLZmLs2pk2cuoXkgNlSuZygA0
         MYh8ltKRTY4uVb2QbhieOCwTGRtv+mAbgGhKTJvr2h4i3FqEXFssdJYayd325yAzMttx
         bw+FyJAaTjf3Uf05yXttLxs7DziVfx7UXbZFJYwZJZ/okNbaqULA2MU1oVLjUTyof3eZ
         KAqweCqGl2EhxvIjozix2ZdOipt6Dh6saDzCS2esIbqub7C17dIzAk+JINCNQd/EYINI
         jFipxhSCK/z8AXmO/abWnyQWKv+SmZxu1bAmqMw15YzjHIJH1nwe57bNhKOdeUqCjH/x
         WnVA==
X-Forwarded-Encrypted: i=1; AJvYcCUB+uBuZCD9b+HFy3NlAqi12cAcx1m4H+DQlJAh5QuHVESZbu7ZNx96zClIQyioff0I7nN8o46pMMGeCN0R5a66+k69wrdXjIO7E979qw==
X-Gm-Message-State: AOJu0YyeJqnOLSMz/DRscs+/o4AiK08HGngp8wl82eFU+7WswWEZkKfh
	qQ3SppvdpqVMPB3cYdVdBZnQjdubyHukN00HVHgMFozysTA+I+6+mpHIfkzU6eB6myIys198K0y
	/5alt7y9gzZxdUgSJAxBv0tJCERemIs1H61GHO0AjP7zZtEPkQxaNpgXxW+8wgVlUkTYNFlU=
X-Received: by 2002:a05:6000:154d:b0:34d:2466:df51 with SMTP id 13-20020a056000154d00b0034d2466df51mr2010090wry.48.1714397182699;
        Mon, 29 Apr 2024 06:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzmmhdSfq9Wove4AQtvoencUdS16/OXuWxt3Lb/r/FK195mEPIUUJEbZlIBK/oVBe16qPitw==
X-Received: by 2002:a05:6000:154d:b0:34d:2466:df51 with SMTP id 13-20020a056000154d00b0034d2466df51mr2010068wry.48.1714397182256;
        Mon, 29 Apr 2024 06:26:22 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-114.pool.digikabel.hu. [176.241.63.114])
        by smtp.gmail.com with ESMTPSA id l7-20020adffe87000000b0034c7330da82sm7845049wrr.80.2024.04.29.06.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:26:21 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] ovl: implement tmpfile
Date: Mon, 29 Apr 2024 15:26:19 +0200
Message-ID: <20240429132620.659012-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combine inode creation with opening a file.

There are six separate objects that are being set up: the backing inode,
dentry and file, and the overlay inode, dentry and file.  Cleanup in case
of an error is a bit of a challenge and is difficult to test, so careful
review is needed.

All tmpfile testcases except generic/509 now run/pass, and no regressions
are observed with full xfstests.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
v2:
  - don't pass real_idmap to backing_tmpfile_open()
  - move ovl_dir_modified() from ovl_instantiate() to callers
  - use ovl_instantiate() for tmpfile
  - call d_mark_tmpfile() before d_instantiate() in ovl_instantiate();
    no longer need to mess with nlink
  - extract helper ovl_setup_cred_for_create() from ovl_create_or_link()
  - don't apply umask to mode, VFS will do that when creating the tmpfile
  - add comment above file->private_data cleanup

---
 fs/backing-file.c            |  23 ++++++
 fs/internal.h                |   3 +
 fs/namei.c                   |   6 +-
 fs/overlayfs/dir.c           | 145 ++++++++++++++++++++++++++++++-----
 fs/overlayfs/file.c          |   3 -
 fs/overlayfs/overlayfs.h     |   3 +
 include/linux/backing-file.h |   3 +
 7 files changed, 161 insertions(+), 25 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 740185198db3..afb557446c27 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -52,6 +52,29 @@ struct file *backing_file_open(const struct path *user_path, int flags,
 }
 EXPORT_SYMBOL_GPL(backing_file_open);
 
+struct file *backing_tmpfile_open(const struct path *user_path, int flags,
+				  const struct path *real_parentpath,
+				  umode_t mode, const struct cred *cred)
+{
+	struct mnt_idmap *real_idmap = mnt_idmap(real_parentpath->mnt);
+	struct file *f;
+	int error;
+
+	f = alloc_empty_backing_file(flags, cred);
+	if (IS_ERR(f))
+		return f;
+
+	path_get(user_path);
+	*backing_file_user_path(f) = *user_path;
+	error = vfs_tmpfile(real_idmap, real_parentpath, f, mode);
+	if (error) {
+		fput(f);
+		f = ERR_PTR(error);
+	}
+	return f;
+}
+EXPORT_SYMBOL(backing_tmpfile_open);
+
 struct backing_aio {
 	struct kiocb iocb;
 	refcount_t ref;
diff --git a/fs/internal.h b/fs/internal.h
index 7ca738904e34..ab2225136f60 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -62,6 +62,9 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode);
 int do_symlinkat(struct filename *from, int newdfd, struct filename *to);
 int do_linkat(int olddfd, struct filename *old, int newdfd,
 			struct filename *new, int flags);
+int vfs_tmpfile(struct mnt_idmap *idmap,
+		const struct path *parentpath,
+		struct file *file, umode_t mode);
 
 /*
  * namespace.c
diff --git a/fs/namei.c b/fs/namei.c
index c5b2a25be7d0..13e50b0a49d2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3668,9 +3668,9 @@ static int do_open(struct nameidata *nd,
  * On non-idmapped mounts or if permission checking is to be performed on the
  * raw inode simply pass @nop_mnt_idmap.
  */
-static int vfs_tmpfile(struct mnt_idmap *idmap,
-		       const struct path *parentpath,
-		       struct file *file, umode_t mode)
+int vfs_tmpfile(struct mnt_idmap *idmap,
+		const struct path *parentpath,
+		struct file *file, umode_t mode)
 {
 	struct dentry *child;
 	struct inode *dir = d_inode(parentpath->dentry);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0f8b4a719237..cac21ef546fe 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -14,6 +14,7 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/atomic.h>
 #include <linux/ratelimit.h>
+#include <linux/backing-file.h>
 #include "overlayfs.h"
 
 static unsigned short ovl_redirect_max = 256;
@@ -260,14 +261,13 @@ static int ovl_set_opaque(struct dentry *dentry, struct dentry *upperdentry)
  * may not use to instantiate the new dentry.
  */
 static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
-			   struct dentry *newdentry, bool hardlink)
+			   struct dentry *newdentry, bool hardlink, struct file *tmpfile)
 {
 	struct ovl_inode_params oip = {
 		.upperdentry = newdentry,
 		.newinode = inode,
 	};
 
-	ovl_dir_modified(dentry->d_parent, false);
 	ovl_dentry_set_upper_alias(dentry);
 	ovl_dentry_init_reval(dentry, newdentry, NULL);
 
@@ -295,6 +295,9 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
 		inc_nlink(inode);
 	}
 
+	if (tmpfile)
+		d_mark_tmpfile(tmpfile, inode);
+
 	d_instantiate(dentry, inode);
 	if (inode != oip.newinode) {
 		pr_warn_ratelimited("newly created inode found in cache (%pd2)\n",
@@ -345,7 +348,8 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 		ovl_set_opaque(dentry, newdentry);
 	}
 
-	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink);
+	ovl_dir_modified(dentry->d_parent, false);
+	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink, NULL);
 	if (err)
 		goto out_cleanup;
 out_unlock:
@@ -529,7 +533,8 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 	}
-	err = ovl_instantiate(dentry, inode, newdentry, hardlink);
+	ovl_dir_modified(dentry->d_parent, false);
+	err = ovl_instantiate(dentry, inode, newdentry, hardlink, NULL);
 	if (err) {
 		ovl_cleanup(ofs, udir, newdentry);
 		dput(newdentry);
@@ -551,12 +556,35 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	goto out_dput;
 }
 
+static int ovl_setup_cred_for_create(struct dentry *dentry, struct inode *inode,
+				     umode_t mode, const struct cred *old_cred)
+{
+	int err;
+	struct cred *override_cred;
+
+	override_cred = prepare_creds();
+	if (!override_cred)
+		return -ENOMEM;
+
+	override_cred->fsuid = inode->i_uid;
+	override_cred->fsgid = inode->i_gid;
+	err = security_dentry_create_files_as(dentry, mode, &dentry->d_name,
+					      old_cred, override_cred);
+	if (err) {
+		put_cred(override_cred);
+		return err;
+	}
+	put_cred(override_creds(override_cred));
+	put_cred(override_cred);
+
+	return 0;
+}
+
 static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			      struct ovl_cattr *attr, bool origin)
 {
 	int err;
 	const struct cred *old_cred;
-	struct cred *override_cred;
 	struct dentry *parent = dentry->d_parent;
 
 	old_cred = ovl_override_creds(dentry->d_sb);
@@ -572,10 +600,6 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 	}
 
 	if (!attr->hardlink) {
-		err = -ENOMEM;
-		override_cred = prepare_creds();
-		if (!override_cred)
-			goto out_revert_creds;
 		/*
 		 * In the creation cases(create, mkdir, mknod, symlink),
 		 * ovl should transfer current's fs{u,g}id to underlying
@@ -589,17 +613,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		 * create a new inode, so just use the ovl mounter's
 		 * fs{u,g}id.
 		 */
-		override_cred->fsuid = inode->i_uid;
-		override_cred->fsgid = inode->i_gid;
-		err = security_dentry_create_files_as(dentry,
-				attr->mode, &dentry->d_name, old_cred,
-				override_cred);
-		if (err) {
-			put_cred(override_cred);
+		err = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
+		if (err)
 			goto out_revert_creds;
-		}
-		put_cred(override_creds(override_cred));
-		put_cred(override_cred);
 	}
 
 	if (!ovl_dentry_is_whiteout(dentry))
@@ -1290,6 +1306,96 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	return err;
 }
 
+static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
+			      struct inode *inode, umode_t mode)
+{
+	const struct cred *old_cred;
+	struct path realparentpath;
+	struct file *realfile;
+	struct dentry *newdentry;
+	/* It's okay to set O_NOATIME, since the owner will be current fsuid */
+	int flags = file->f_flags | OVL_OPEN_FLAGS;
+	int err;
+
+	err = ovl_copy_up(dentry->d_parent);
+	if (err)
+		return err;
+
+	old_cred = ovl_override_creds(dentry->d_sb);
+	err = ovl_setup_cred_for_create(dentry, inode, mode, old_cred);
+	if (err)
+		goto out_revert_creds;
+
+	ovl_path_upper(dentry->d_parent, &realparentpath);
+	realfile = backing_tmpfile_open(&file->f_path, flags, &realparentpath,
+					mode, current_cred());
+	err = PTR_ERR(realfile);
+	if (IS_ERR(realfile))
+		goto out_revert_creds;
+
+	/* ovl_instantiate() consumes the newdentry reference on success */
+	newdentry = dget(realfile->f_path.dentry);
+	err = ovl_instantiate(dentry, inode, newdentry, false, file);
+	if (!err) {
+		file->private_data = realfile;
+	} else {
+		dput(newdentry);
+		fput(realfile);
+	}
+out_revert_creds:
+	revert_creds(old_cred);
+	return err;
+}
+
+static int ovl_dummy_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int ovl_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
+		       struct file *file, umode_t mode)
+{
+	int err;
+	struct dentry *dentry = file->f_path.dentry;
+	struct inode *inode;
+
+	err = ovl_want_write(dentry);
+	if (err)
+		return err;
+
+	err = -ENOMEM;
+	inode = ovl_new_inode(dentry->d_sb, mode, 0);
+	if (!inode)
+		goto drop_write;
+
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
+	err = ovl_create_tmpfile(file, dentry, inode, inode->i_mode);
+	if (err)
+		goto put_inode;
+
+	/*
+	 * Check if the preallocated inode was actually used.  Having something
+	 * else assigned to the dentry shouldn't happen as that would indicate
+	 * that the backing tmpfile "leaked" out of overlayfs.
+	 */
+	err = -EIO;
+	if (WARN_ON(inode != d_inode(dentry)))
+		goto put_realfile;
+
+	/* inode reference was transferred to dentry */
+	inode = NULL;
+	err = finish_open(file, dentry, ovl_dummy_open);
+put_realfile:
+	/* Without FMODE_OPENED ->release() won't be called on @file */
+	if (!(file->f_mode & FMODE_OPENED))
+		fput(file->private_data);
+put_inode:
+	iput(inode);
+drop_write:
+	ovl_drop_write(dentry);
+	return err;
+}
+
 const struct inode_operations ovl_dir_inode_operations = {
 	.lookup		= ovl_lookup,
 	.mkdir		= ovl_mkdir,
@@ -1310,4 +1416,5 @@ const struct inode_operations ovl_dir_inode_operations = {
 	.update_time	= ovl_update_time,
 	.fileattr_get	= ovl_fileattr_get,
 	.fileattr_set	= ovl_fileattr_set,
+	.tmpfile	= ovl_tmpfile,
 };
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 05536964d37f..1a411cae57ed 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -24,9 +24,6 @@ static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 		return 'm';
 }
 
-/* No atime modification on underlying */
-#define OVL_OPEN_FLAGS (O_NOATIME)
-
 static struct file *ovl_open_realfile(const struct file *file,
 				      const struct path *realpath)
 {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index ee949f3e7c77..0bfe35da4b7b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -175,6 +175,9 @@ static inline int ovl_metadata_digest_size(const struct ovl_metacopy *metacopy)
 	return (int)metacopy->len - OVL_METACOPY_MIN_SIZE;
 }
 
+/* No atime modification on underlying */
+#define OVL_OPEN_FLAGS (O_NOATIME)
+
 extern const char *const ovl_xattr_table[][2];
 static inline const char *ovl_xattr(struct ovl_fs *ofs, enum ovl_xattr ox)
 {
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 3f1fe1774f1b..4b61b0e57720 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -22,6 +22,9 @@ struct backing_file_ctx {
 struct file *backing_file_open(const struct path *user_path, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred);
+struct file *backing_tmpfile_open(const struct path *user_path, int flags,
+				  const struct path *real_parentpath,
+				  umode_t mode, const struct cred *cred);
 ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			       struct kiocb *iocb, int flags,
 			       struct backing_file_ctx *ctx);
-- 
2.44.0


