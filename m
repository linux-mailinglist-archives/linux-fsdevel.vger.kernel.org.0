Return-Path: <linux-fsdevel+bounces-17733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798BB8B1EED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66B51F24A1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 10:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B71986250;
	Thu, 25 Apr 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azbhs548"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327AD86151
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040164; cv=none; b=r2OH3IKkceTmNNxjTzcgro8pIGu1gdILbva96J5nRElJ8+LpF5B396PqmrCA+mPMHRP8mQCRp8t+3n9awzLBHiA6iDG3vnP6+yM4QoL8m2QdXjualT2ldumHUHVmF2MT1GddR2AoR/d57O1JDIV+KNQBlryU/nfLTpDwGw6/j18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040164; c=relaxed/simple;
	bh=RE0XHFXgyl7Qhs3xhfirtZTiUibrL3JV+GrmP2ucD2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VaW9u0rxz284BTEOwXtK25M5eaiJhhXEHuAKCi5i8RPy3YuLCAE+Ug2MzM0kj09wmJ5HqKl/6TkURoEdOyqR81BLEyFaR++V0mnX20x8uV9hUsyKdPlNb2CUBDAsunYBh8Hc97uDqbLydcWMOe0WiUaFlh/khFku2nmmjLkbBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azbhs548; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714040162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YhTFcgirWpjzeJGwbOuso3pvZt+KgZvxAhl3li4Ro/Y=;
	b=azbhs548A2fTr5DQgwqdOwY3eofeLt/haYYD1cxZhEfIOqPu4E7paFdXW8jWT5crdgS8N/
	0Yi0iliWQFUbqxABG0AcN/FSel+CbsBI3eZ3Ic2SQWtJABwOHDbeoMa6g7wT9AffjpDzIC
	fFT2WVr7t0C9M9pXaAptNU/yVTpZBh8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-cpPsuzcGO9a-2lzMdoQMxw-1; Thu, 25 Apr 2024 06:16:00 -0400
X-MC-Unique: cpPsuzcGO9a-2lzMdoQMxw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a5872678bd2so46450666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 03:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714040159; x=1714644959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhTFcgirWpjzeJGwbOuso3pvZt+KgZvxAhl3li4Ro/Y=;
        b=tWVRL3wMxfGEwUurYnkgz2azrLgh38LiaOAPVn7mdqadFBJmI7E+k/xRZme747Hyxt
         ffnFgbalIB1TPBVW5kLvurqh7Ehd1+yrlXGYbLtxlsfYheMQ184dk5JqH9EVwOJ2wTnd
         K8dPdvZI/OgLh8KHRu9fw1jrUtgTqYjv1jx1+vNpzc5BG6qwkEv7x4pVVxfvkuFLap1C
         h+bLJC97gFIg2cG8ueKt8vHFMzXAPYlvF//ptOzGrHRswgD+MZDWR9AIJGPYUC0AxUn5
         nso07OYRxPlZqwS/nHRVAHVmVsSW9bv86rA4Q6lUlgFkeI1FOFJRjLjeY7JF8070qlQZ
         ZZsg==
X-Forwarded-Encrypted: i=1; AJvYcCV7CblbFRASqDmlLL4um61omn3XloScBoh5bilm+PHxNWAHkgt/unZ4XDE8C2ngeMLrL2/ePtZsjKu2tvYIyDlgZcqyvFypBUVkf66VGA==
X-Gm-Message-State: AOJu0YxRzqcXiW/VyoAoqFKwOxmLNpLvAhc82J/e7URXu++CZSKG9uqr
	huQ4oosBY64NR3bNvos+PF4rz92ZIVTg/0kMmadlnVvuLB/BcrVHOsw9PFdANktV0BxFHEdzNq/
	SHrO2uyuBGOI33JgLZ1HNbKO24tP6YQqMBMf+YUXhq7rVn06lLBzFUQwVXpfDD6dChw+1kKI=
X-Received: by 2002:a17:907:a4c:b0:a58:9485:3156 with SMTP id be12-20020a1709070a4c00b00a5894853156mr3656213ejc.50.1714040158705;
        Thu, 25 Apr 2024 03:15:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdBYdEYzbH1z+pURMBUd3BtbOrGsGVjdXPc41i5KC4qM0vBceWm9PwopCy84mw9zWJxgKOww==
X-Received: by 2002:a17:907:a4c:b0:a58:9485:3156 with SMTP id be12-20020a1709070a4c00b00a5894853156mr3656198ejc.50.1714040158312;
        Thu, 25 Apr 2024 03:15:58 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-114.pool.digikabel.hu. [176.241.63.114])
        by smtp.gmail.com with ESMTPSA id cd19-20020a170906b35300b00a4673706b4dsm9352523ejb.78.2024.04.25.03.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:15:57 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] ovl: implement tmpfile
Date: Thu, 25 Apr 2024 12:15:55 +0200
Message-ID: <20240425101556.573616-1-mszeredi@redhat.com>
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
dentry and file and the overlay inode, dentry and file.  Cleanup in case of
an error is a bit of a challenge and is difficult to test, so careful
review is needed.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/backing-file.c            |  23 +++++++
 fs/internal.h                |   3 +
 fs/namei.c                   |   6 +-
 fs/overlayfs/dir.c           | 130 +++++++++++++++++++++++++++++++++++
 fs/overlayfs/file.c          |   3 -
 fs/overlayfs/overlayfs.h     |   3 +
 include/linux/backing-file.h |   4 ++
 7 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 740185198db3..2dc3f7477d1d 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -52,6 +52,29 @@ struct file *backing_file_open(const struct path *user_path, int flags,
 }
 EXPORT_SYMBOL_GPL(backing_file_open);
 
+struct file *backing_tmpfile_open(const struct path *user_path, int flags,
+				  struct mnt_idmap *real_idmap,
+				  const struct path *real_parentpath,
+				  umode_t mode, const struct cred *cred)
+{
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
index 0f8b4a719237..91ac268986a9 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -14,6 +14,7 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/atomic.h>
 #include <linux/ratelimit.h>
+#include <linux/backing-file.h>
 #include "overlayfs.h"
 
 static unsigned short ovl_redirect_max = 256;
@@ -1290,6 +1291,134 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	return err;
 }
 
+static int ovl_create_upper_tmpfile(struct file *file, struct dentry *dentry,
+				    struct inode *inode, umode_t mode)
+{
+	struct ovl_inode_params oip;
+	struct path realparentpath;
+	struct file *realfile;
+	/* It's okay to set O_NOATIME, since the owner will be current fsuid */
+	int flags = file->f_flags | OVL_OPEN_FLAGS;
+
+	ovl_path_upper(dentry->d_parent, &realparentpath);
+
+	if (!IS_POSIXACL(d_inode(realparentpath.dentry)))
+		mode &= ~current_umask();
+
+	realfile = backing_tmpfile_open(&file->f_path, flags,
+					&nop_mnt_idmap, &realparentpath, mode,
+					current_cred());
+	if (IS_ERR(realfile))
+		return PTR_ERR(realfile);
+
+	ovl_dentry_set_upper_alias(dentry);
+	ovl_dentry_update_reval(dentry, realfile->f_path.dentry);
+
+	/* ovl_get_inode() consumes the .upperdentry reference on success */
+	oip = (struct ovl_inode_params) {
+		.upperdentry = dget(realfile->f_path.dentry),
+		.newinode = inode,
+	};
+
+	inode = ovl_get_inode(dentry->d_sb, &oip);
+	if (IS_ERR(inode))
+		goto out_err;
+
+	/* d_tmpfile() expects inode to have a positive link count */
+	set_nlink(inode, 1);
+	d_tmpfile(file, inode);
+	file->private_data = realfile;
+	return 0;
+
+out_err:
+	dput(realfile->f_path.dentry);
+	fput(realfile);
+	return PTR_ERR(inode);
+}
+
+static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
+			      struct inode *inode, umode_t mode)
+{
+	int err;
+	const struct cred *old_cred;
+	struct cred *override_cred;
+
+	err = ovl_copy_up(dentry->d_parent);
+	if (err)
+		return err;
+
+	old_cred = ovl_override_creds(dentry->d_sb);
+
+	err = -ENOMEM;
+	override_cred = prepare_creds();
+	if (override_cred) {
+		override_cred->fsuid = inode->i_uid;
+		override_cred->fsgid = inode->i_gid;
+		err = security_dentry_create_files_as(dentry, mode,
+						      &dentry->d_name, old_cred,
+						      override_cred);
+		if (err) {
+			put_cred(override_cred);
+			goto out_revert_creds;
+		}
+		put_cred(override_creds(override_cred));
+		put_cred(override_cred);
+
+		err = ovl_create_upper_tmpfile(file, dentry, inode, mode);
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
@@ -1310,4 +1439,5 @@ const struct inode_operations ovl_dir_inode_operations = {
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
index 3f1fe1774f1b..0f59f11a5a3f 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -22,6 +22,10 @@ struct backing_file_ctx {
 struct file *backing_file_open(const struct path *user_path, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred);
+struct file *backing_tmpfile_open(const struct path *user_path, int flags,
+				  struct mnt_idmap *real_idmap,
+				  const struct path *real_parentpath,
+				  umode_t mode, const struct cred *cred);
 ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			       struct kiocb *iocb, int flags,
 			       struct backing_file_ctx *ctx);
-- 
2.44.0


