Return-Path: <linux-fsdevel+bounces-26645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7667695AA56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A27B24B81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE317C225;
	Thu, 22 Aug 2024 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wq8bd9cb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520E210E7;
	Thu, 22 Aug 2024 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289939; cv=none; b=B2PcrlEojPdZTTErYLDRGAzmcG8kQQrruqKOUuNrwN1bEzIJWz0iW9kRDtDrn4KD8LFb2boK1KJXiYY0LVOMNqvjEypLiCeUdWdZMsJUmywRz7C0TW1ztTXijdUnx2udLAkgD2lmxQKSaN2xz334sRgY5fxhCLODwxw0WzPp4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289939; c=relaxed/simple;
	bh=lXgOrEnbrpLLD9kic5+pvhL5u9/hVs8V8wlwkACc8eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9JDILa57yIfXkjYFguzKO6NIwvtfyM0/QbTWW3bhS4JD/ZRy2FOZk+BNeiKlPrkZzfCkrJwQXU1sdKPopvPtMQp4cez/SA7jon7iJ53eNY+twq5TckNkUH5+oDxL+LeHpnYZEunqntseNCMDc4eUnRhbfaY43knx6zl7GWTAyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wq8bd9cb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289937; x=1755825937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lXgOrEnbrpLLD9kic5+pvhL5u9/hVs8V8wlwkACc8eM=;
  b=Wq8bd9cbC25IgPlzA4KKOvBM5iTk2/AJf1aJMNrHmZrRQ3bfl0O3LHRC
   vj3KqWmnMjFcWim74ixYXcBLOQmSH0d3zV7JIAn5cRJAozbQdtsjQkk9R
   QGMjdp1GFQbOYOdcOAX69+zdqK3ZXL01zNw140b9tIpkZF33Od3UMm/qM
   maf9wFc3huFJUs0JHBxwhMVdNPO+ibR93XnawvTy56cQy+SduZynSFR8e
   dWN8OGlJjBB3frcdz9KsijMBqiDYRp3pr2FlHjgC0Dpsvg3sGla8TbXxV
   0mseGXqiFfA0W3dPwx4TNcZYj01wmwNf+I1je7NKK2ppOa5OhaaZVD7MK
   w==;
X-CSE-ConnectionGUID: uBaWjmfkSV+tJG+aHdtMOQ==
X-CSE-MsgGUID: yfK+wbkjQzSdDoQmnjzAiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574739"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574739"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
X-CSE-ConnectionGUID: keXDrThMRXyNqBZMol3R6w==
X-CSE-MsgGUID: HeU2AJbMSo+3AC1it+SOwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811033"
Received: from unknown (HELO vcostago-mobl3.jf.intel.com) ([10.241.225.92])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v2 05/16] overlayfs: Use ovl_override_creds_light()/revert_creds_light()
Date: Wed, 21 Aug 2024 18:25:12 -0700
Message-ID: <20240822012523.141846-6-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822012523.141846-1-vinicius.gomes@intel.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use ovl_override_creds_light()/revert_creds_light(), these
functions assume that the critical section won't modify the usage
counter of the credentials in question.

In most overlayfs instances, the credentials lifetime is the duration
of the filesystem being mounted, so it's safe to assume that it will
continue to exist for that duration.

NOTE: that in copy up there was an instance in which that the
conversion is not safe, because there's a risk of the cred refcount
being changed in the critical section.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/copy_up.c |  4 ++--
 fs/overlayfs/dir.c     |  8 ++++----
 fs/overlayfs/file.c    | 28 ++++++++++++++--------------
 fs/overlayfs/inode.c   | 40 ++++++++++++++++++++--------------------
 fs/overlayfs/namei.c   | 18 +++++++++---------
 fs/overlayfs/readdir.c | 16 ++++++++--------
 fs/overlayfs/util.c    |  8 ++++----
 fs/overlayfs/xattrs.c  | 17 ++++++++---------
 8 files changed, 69 insertions(+), 70 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 7dec275e08cd..7b1679ce996e 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1204,7 +1204,7 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	while (!err) {
 		struct dentry *next;
 		struct dentry *parent = NULL;
@@ -1229,7 +1229,7 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		dput(parent);
 		dput(next);
 	}
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 851945904385..52021e56b235 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -701,9 +701,9 @@ static int ovl_set_link_redirect(struct dentry *dentry)
 	const struct cred *old_cred;
 	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	err = ovl_set_redirect(dentry, false);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	return err;
 }
@@ -908,12 +908,12 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	if (!lower_positive)
 		err = ovl_remove_upper(dentry, is_dir, &list);
 	else
 		err = ovl_remove_and_whiteout(dentry, &list);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 1a411cae57ed..5533fedcbc47 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -39,7 +39,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 	if (flags & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	old_cred = ovl_override_creds_light(inode->i_sb);
 	real_idmap = mnt_idmap(realpath->mnt);
 	err = inode_permission(real_idmap, realinode, MAY_OPEN | acc_mode);
 	if (err) {
@@ -51,7 +51,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 		realfile = backing_file_open(&file->f_path, flags, realpath,
 					     current_cred());
 	}
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,
@@ -211,9 +211,9 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	ovl_inode_lock(inode);
 	real.file->f_pos = file->f_pos;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	old_cred = ovl_override_creds_light(inode->i_sb);
 	ret = vfs_llseek(real.file, offset, whence);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	file->f_pos = real.file->f_pos;
 	ovl_inode_unlock(inode);
@@ -398,9 +398,9 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 	/* Don't sync lower file for fear of receiving EROFS error */
 	if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
-		old_cred = ovl_override_creds(file_inode(file)->i_sb);
+		old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
 		ret = vfs_fsync_range(real.file, start, end, datasync);
-		revert_creds(old_cred);
+		revert_creds_light(old_cred);
 	}
 
 	fdput(real);
@@ -438,9 +438,9 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	if (ret)
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
 	ret = vfs_fallocate(real.file, mode, offset, len);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file);
@@ -463,9 +463,9 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 	if (ret)
 		return ret;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
 	ret = vfs_fadvise(real.file, offset, len, advice);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	fdput(real);
 
@@ -506,7 +506,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 		goto out_unlock;
 	}
 
-	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
+	old_cred = ovl_override_creds_light(file_inode(file_out)->i_sb);
 	switch (op) {
 	case OVL_COPY:
 		ret = vfs_copy_file_range(real_in.file, pos_in,
@@ -524,7 +524,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 						flags);
 		break;
 	}
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file_out);
@@ -584,9 +584,9 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 		return err;
 
 	if (real.file->f_op->flush) {
-		old_cred = ovl_override_creds(file_inode(file)->i_sb);
+		old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
 		err = real.file->f_op->flush(real.file, id);
-		revert_creds(old_cred);
+		revert_creds_light(old_cred);
 	}
 	fdput(real);
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 35fd3e3e1778..30460d718605 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -78,9 +78,9 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out_put_write;
 
 		inode_lock(upperdentry->d_inode);
-		old_cred = ovl_override_creds(dentry->d_sb);
+		old_cred = ovl_override_creds_light(dentry->d_sb);
 		err = ovl_do_notify_change(ofs, upperdentry, attr);
-		revert_creds(old_cred);
+		revert_creds_light(old_cred);
 		if (!err)
 			ovl_copyattr(dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
@@ -169,7 +169,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	metacopy_blocks = ovl_is_metacopy_dentry(dentry);
 
 	type = ovl_path_real(dentry, &realpath);
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	err = ovl_do_getattr(&realpath, stat, request_mask, flags);
 	if (err)
 		goto out;
@@ -280,7 +280,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	return err;
 }
@@ -309,7 +309,7 @@ int ovl_permission(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	old_cred = ovl_override_creds_light(inode->i_sb);
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
 		mask &= ~(MAY_WRITE | MAY_APPEND);
@@ -317,7 +317,7 @@ int ovl_permission(struct mnt_idmap *idmap,
 		mask |= MAY_READ;
 	}
 	err = inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	return err;
 }
@@ -332,9 +332,9 @@ static const char *ovl_get_link(struct dentry *dentry,
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	return p;
 }
 
@@ -467,9 +467,9 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
 	} else {
 		const struct cred *old_cred;
 
-		old_cred = ovl_override_creds(inode->i_sb);
+		old_cred = ovl_override_creds_light(inode->i_sb);
 		acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type), noperm);
-		revert_creds(old_cred);
+		revert_creds_light(old_cred);
 	}
 
 	return acl;
@@ -495,10 +495,10 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 		struct posix_acl *real_acl;
 
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds(dentry->d_sb);
+		old_cred = ovl_override_creds_light(dentry->d_sb);
 		real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry,
 				       acl_name);
-		revert_creds(old_cred);
+		revert_creds_light(old_cred);
 		if (IS_ERR(real_acl)) {
 			err = PTR_ERR(real_acl);
 			goto out;
@@ -518,12 +518,12 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	if (acl)
 		err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
 	else
 		err = ovl_do_remove_acl(ofs, realdentry, acl_name);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */
@@ -598,9 +598,9 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!realinode->i_op->fiemap)
 		return -EOPNOTSUPP;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	old_cred = ovl_override_creds_light(inode->i_sb);
 	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	return err;
 }
@@ -660,7 +660,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		if (err)
 			goto out;
 
-		old_cred = ovl_override_creds(inode->i_sb);
+		old_cred = ovl_override_creds_light(inode->i_sb);
 		/*
 		 * Store immutable/append-only flags in xattr and clear them
 		 * in upper fileattr (in case they were set by older kernel)
@@ -671,7 +671,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		err = ovl_set_protattr(inode, upperpath.dentry, fa);
 		if (!err)
 			err = ovl_real_fileattr_set(&upperpath, fa);
-		revert_creds(old_cred);
+		revert_creds_light(old_cred);
 		ovl_drop_write(dentry);
 
 		/*
@@ -730,10 +730,10 @@ int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 
 	ovl_path_real(dentry, &realpath);
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	old_cred = ovl_override_creds_light(inode->i_sb);
 	err = ovl_real_fileattr_get(&realpath, fa);
 	ovl_fileattr_prot_flags(inode, fa);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 5764f91d283e..e52d6ae8eeb5 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -955,13 +955,13 @@ static int ovl_maybe_validate_verity(struct dentry *dentry)
 	if (!ovl_test_flag(OVL_VERIFIED_DIGEST, inode)) {
 		const struct cred *old_cred;
 
-		old_cred = ovl_override_creds(dentry->d_sb);
+		old_cred = ovl_override_creds_light(dentry->d_sb);
 
 		err = ovl_validate_verity(ofs, &metapath, &datapath);
 		if (err == 0)
 			ovl_set_flag(OVL_VERIFIED_DIGEST, inode);
 
-		revert_creds(old_cred);
+		revert_creds_light(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
@@ -993,9 +993,9 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	if (ovl_dentry_lowerdata(dentry))
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	err = ovl_lookup_data_layers(dentry, redirect, &datapath);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	if (err)
 		goto out_err;
 
@@ -1061,7 +1061,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > ofs->namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	upperdir = ovl_dentry_upper(dentry->d_parent);
 	if (upperdir) {
 		d.layer = &ofs->layers[0];
@@ -1342,7 +1342,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 
 	ovl_dentry_init_reval(dentry, upperdentry, OVL_I_E(inode));
 
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	if (origin_path) {
 		dput(origin_path->dentry);
 		kfree(origin_path);
@@ -1366,7 +1366,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	kfree(upperredirect);
 out:
 	kfree(d.redirect);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	return ERR_PTR(err);
 }
 
@@ -1390,7 +1390,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 	if (!ovl_dentry_upper(dentry))
 		return true;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	/* Positive upper -> have to look up lower to see whether it exists */
 	for (i = 0; !done && !positive && i < ovl_numlower(poe); i++) {
 		struct dentry *this;
@@ -1423,7 +1423,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 			dput(this);
 		}
 	}
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	return positive;
 }
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 0ca8af060b0c..c8bf681f5cf0 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -275,7 +275,7 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 	struct dentry *dentry, *dir = path->dentry;
 	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(rdd->dentry->d_sb);
+	old_cred = ovl_override_creds_light(rdd->dentry->d_sb);
 
 	err = down_write_killable(&dir->d_inode->i_rwsem);
 	if (!err) {
@@ -290,7 +290,7 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 		}
 		inode_unlock(dir->d_inode);
 	}
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	return err;
 }
@@ -756,7 +756,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	const struct cred *old_cred;
 	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	if (!ctx->pos)
 		ovl_dir_reset(file);
 
@@ -808,7 +808,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	}
 	err = 0;
 out:
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	return err;
 }
 
@@ -858,9 +858,9 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 	struct file *res;
 	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
 	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	return res;
 }
@@ -985,9 +985,9 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	struct rb_root root = RB_ROOT;
 	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	err = ovl_dir_read_merged(dentry, list, &root);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	if (err)
 		return err;
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 3525ede21600..80caeb81c727 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1177,7 +1177,7 @@ int ovl_nlink_start(struct dentry *dentry)
 	if (d_is_dir(dentry) || !ovl_test_flag(OVL_INDEX, inode))
 		return 0;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	/*
 	 * The overlay inode nlink should be incremented/decremented IFF the
 	 * upper operation succeeds, along with nlink change of upper inode.
@@ -1185,7 +1185,7 @@ int ovl_nlink_start(struct dentry *dentry)
 	 * value relative to the upper inode nlink in an upper inode xattr.
 	 */
 	err = ovl_set_nlink_upper(dentry);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	if (err)
 		goto out_drop_write;
 
@@ -1208,9 +1208,9 @@ void ovl_nlink_end(struct dentry *dentry)
 	if (ovl_test_flag(OVL_INDEX, inode) && inode->i_nlink == 0) {
 		const struct cred *old_cred;
 
-		old_cred = ovl_override_creds(dentry->d_sb);
+		old_cred = ovl_override_creds_light(dentry->d_sb);
 		ovl_cleanup_index(dentry);
-		revert_creds(old_cred);
+		revert_creds_light(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 383978e4663c..0d315d0dd89e 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -45,9 +45,9 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 
 	if (!value && !upperdentry) {
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds(dentry->d_sb);
+		old_cred = ovl_override_creds_light(dentry->d_sb);
 		err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
-		revert_creds(old_cred);
+		revert_creds_light(old_cred);
 		if (err < 0)
 			goto out;
 	}
@@ -64,7 +64,7 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	if (value) {
 		err = ovl_do_setxattr(ofs, realdentry, name, value, size,
 				      flags);
@@ -72,7 +72,7 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 		WARN_ON(flags != XATTR_REPLACE);
 		err = ovl_do_removexattr(ofs, realdentry, name);
 	}
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */
@@ -89,9 +89,9 @@ static int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char
 	struct path realpath;
 
 	ovl_i_path_real(inode, &realpath);
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	res = vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	return res;
 }
 
@@ -119,9 +119,9 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 	const struct cred *old_cred;
 	size_t prefix_len, name_len;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_override_creds_light(dentry->d_sb);
 	res = vfs_listxattr(realdentry, list, size);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	if (res <= 0 || size == 0)
 		return res;
 
@@ -268,4 +268,3 @@ const struct xattr_handler * const *ovl_xattr_handlers(struct ovl_fs *ofs)
 	return ofs->config.userxattr ? ovl_user_xattr_handlers :
 		ovl_trusted_xattr_handlers;
 }
-
-- 
2.46.0


