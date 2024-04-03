Return-Path: <linux-fsdevel+bounces-15960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A771B89626A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 04:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DF31F24CE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 02:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B72EB11;
	Wed,  3 Apr 2024 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1na1eMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998B182DF;
	Wed,  3 Apr 2024 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110706; cv=none; b=P2k6Kmj4+w6iJJmgBMnkb9LwFKOrc3wh5nm/1QDt5qu4gnxdPH/NK4K4Mlj1uj7grX1UzdbQRt9i/HynDfDjM07rRqWy4c0o86JuKeKGY/6KK+GCNQKfWE6hcKdXw4n59AQriIdqlIoRz2d5sekZl/qwN1CqeyIr++AMeBZFREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110706; c=relaxed/simple;
	bh=a5pOGWwAY8ThuE8C4VM1DN3hs8fiSuwgSay3H6gQEko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7zkHpSCLFGJHPRDiJuKcNMI0yNj2tNhiiZ2wMvuTyq0ve4oVPL/ffnVouGlFVPPsrzbQI6sa3zOs6WWReyT0MK+jlRL2vavGQuWUSkms1CimZrSnDAmTkjMF5qydC3Le4G9H1jjtetZ9H8OQYm/nMSjUnF9C92PiiPX0EnLYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1na1eMs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712110701; x=1743646701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a5pOGWwAY8ThuE8C4VM1DN3hs8fiSuwgSay3H6gQEko=;
  b=k1na1eMsTefA8+JqPDCD/S5SVtfY6U/iCcJ7J6HgaDNhvHkF7iKr6I4c
   Z74h0g4dwLdZ4gPGXs6YNorpklk/ar17TNv7h09ww5/PL3RbyIEQhvzSD
   L/UHbikGI7LYb5U/GmsMpQl5HuCoXZvlpinGOq5GFmqCp/cAY8hoQEA9N
   w8MElOvmguLcK3nnOTToPvcJ6Lgv72PkU6K+E9xgmEAxBZwSuyYXl/LM2
   Uk0sQnUEBgVRj2W+MSIhtLttu3zxtVMfGWyZ8wa2i49H/Pb31u5FFY9Jc
   JWOZA4OqS0zyIbumbATmBGLiryhUF2bRNRsCuMw6oHeJ/u17mtjYaW9MX
   w==;
X-CSE-ConnectionGUID: XeyqS9pOTJefAs9ItU0L+g==
X-CSE-MsgGUID: zxQzhMvpQOqDE6CtiCs4Eg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7164937"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7164937"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 19:18:19 -0700
X-CSE-ConnectionGUID: BWJNDk4xSNWxz9tRcwJctw==
X-CSE-MsgGUID: 0Ag6jWRqTse6uHEInr/qCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="55718012"
Received: from unknown (HELO vcostago-mobl3.intel.com) ([10.124.222.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 19:18:18 -0700
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
Subject: [PATCH v1 3/3] overlayfs: Optimize credentials usage
Date: Tue,  2 Apr 2024 19:18:08 -0700
Message-ID: <20240403021808.309900-4-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403021808.309900-1-vinicius.gomes@intel.com>
References: <20240403021808.309900-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

File operations in overlayfs also check against the credentials of the
mounter task, stored in the superblock, this credentials will outlive
most of the operations. For these cases, use the recently introduced
guard statements to guarantee that override/revert_creds() are paired.

As the guard() statements are in effect non-trivial variable
declarations and initializations, in a few cases, replacing
ovl_override_creds()/revert_creds() by guard() statements would cause
those initializations to be skipped when 'goto' labels are used. In
those cases, use scoped_guard(), clang 17.0.6 emits an error in these
cases.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/copy_up.c |  4 +--
 fs/overlayfs/dir.c     | 22 +++++++--------
 fs/overlayfs/file.c    | 63 +++++++++++++++++-------------------------
 fs/overlayfs/inode.c   | 60 +++++++++++++++-------------------------
 fs/overlayfs/namei.c   | 22 ++++-----------
 fs/overlayfs/readdir.c | 16 +++--------
 fs/overlayfs/util.c    | 25 ++++++++---------
 fs/overlayfs/xattrs.c  | 33 +++++++++-------------
 8 files changed, 92 insertions(+), 153 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 0762575a1e70..14a55823fdf1 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1180,7 +1180,6 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 {
 	int err = 0;
-	const struct cred *old_cred;
 	bool disconnected = (dentry->d_flags & DCACHE_DISCONNECTED);
 
 	/*
@@ -1200,7 +1199,7 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	while (!err) {
 		struct dentry *next;
 		struct dentry *parent = NULL;
@@ -1225,7 +1224,6 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		dput(parent);
 		dput(next);
 	}
-	revert_creds(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0f8b4a719237..e68d5ba24ca7 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -684,12 +684,10 @@ static int ovl_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 static int ovl_set_link_redirect(struct dentry *dentry)
 {
-	const struct cred *old_cred;
 	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	err = ovl_set_redirect(dentry, false);
-	revert_creds(old_cred);
 
 	return err;
 }
@@ -875,7 +873,6 @@ static void ovl_drop_nlink(struct dentry *dentry)
 static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 {
 	int err;
-	const struct cred *old_cred;
 	bool lower_positive = ovl_lower_positive(dentry);
 	LIST_HEAD(list);
 
@@ -894,12 +891,13 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	if (!lower_positive)
-		err = ovl_remove_upper(dentry, is_dir, &list);
-	else
-		err = ovl_remove_and_whiteout(dentry, &list);
-	revert_creds(old_cred);
+	cred_scoped_guard(ovl_creds(dentry->d_sb)) {
+		if (!lower_positive)
+			err = ovl_remove_upper(dentry, is_dir, &list);
+		else
+			err = ovl_remove_and_whiteout(dentry, &list);
+	}
+
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);
@@ -1146,7 +1144,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 			goto out;
 	}
 
-	old_cred = ovl_override_creds(old->d_sb);
+	old_cred = override_creds_light(ovl_creds(old->d_sb));
 
 	if (!list_empty(&list)) {
 		opaquedir = ovl_clear_empty(new, &list);
@@ -1279,7 +1277,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 	else
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 05536964d37f..2a76220d8889 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -34,7 +34,6 @@ static struct file *ovl_open_realfile(const struct file *file,
 	struct inode *inode = file_inode(file);
 	struct mnt_idmap *real_idmap;
 	struct file *realfile;
-	const struct cred *old_cred;
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
 	int acc_mode = ACC_MODE(flags);
 	int err;
@@ -42,7 +41,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 	if (flags & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	cred_guard(ovl_creds(inode->i_sb));
 	real_idmap = mnt_idmap(realpath->mnt);
 	err = inode_permission(real_idmap, realinode, MAY_OPEN | acc_mode);
 	if (err) {
@@ -54,7 +53,6 @@ static struct file *ovl_open_realfile(const struct file *file,
 		realfile = backing_file_open(&file->f_path, flags, realpath,
 					     current_cred());
 	}
-	revert_creds(old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,
@@ -185,7 +183,6 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
 	struct fd real;
-	const struct cred *old_cred;
 	loff_t ret;
 
 	/*
@@ -214,9 +211,8 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	ovl_inode_lock(inode);
 	real.file->f_pos = file->f_pos;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	cred_guard(ovl_creds(inode->i_sb));
 	ret = vfs_llseek(real.file, offset, whence);
-	revert_creds(old_cred);
 
 	file->f_pos = real.file->f_pos;
 	ovl_inode_unlock(inode);
@@ -388,7 +384,6 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct fd real;
-	const struct cred *old_cred;
 	int ret;
 
 	ret = ovl_sync_status(OVL_FS(file_inode(file)->i_sb));
@@ -401,9 +396,8 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 	/* Don't sync lower file for fear of receiving EROFS error */
 	if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
-		old_cred = ovl_override_creds(file_inode(file)->i_sb);
+		cred_guard(ovl_creds(file_inode(file)->i_sb));
 		ret = vfs_fsync_range(real.file, start, end, datasync);
-		revert_creds(old_cred);
 	}
 
 	fdput(real);
@@ -427,7 +421,6 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 {
 	struct inode *inode = file_inode(file);
 	struct fd real;
-	const struct cred *old_cred;
 	int ret;
 
 	inode_lock(inode);
@@ -441,9 +434,8 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	if (ret)
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fallocate(real.file, mode, offset, len);
-	revert_creds(old_cred);
+	cred_scoped_guard(ovl_creds(file_inode(file)->i_sb))
+		ret = vfs_fallocate(real.file, mode, offset, len);
 
 	/* Update size */
 	ovl_file_modified(file);
@@ -459,16 +451,14 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 {
 	struct fd real;
-	const struct cred *old_cred;
 	int ret;
 
 	ret = ovl_real_fdget(file, &real);
 	if (ret)
 		return ret;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	cred_guard(ovl_creds(file_inode(file)->i_sb));
 	ret = vfs_fadvise(real.file, offset, len, advice);
-	revert_creds(old_cred);
 
 	fdput(real);
 
@@ -487,7 +477,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 {
 	struct inode *inode_out = file_inode(file_out);
 	struct fd real_in, real_out;
-	const struct cred *old_cred;
 	loff_t ret;
 
 	inode_lock(inode_out);
@@ -509,25 +498,25 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 		goto out_unlock;
 	}
 
-	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
-	switch (op) {
-	case OVL_COPY:
-		ret = vfs_copy_file_range(real_in.file, pos_in,
-					  real_out.file, pos_out, len, flags);
-		break;
-
-	case OVL_CLONE:
-		ret = vfs_clone_file_range(real_in.file, pos_in,
-					   real_out.file, pos_out, len, flags);
-		break;
-
-	case OVL_DEDUPE:
-		ret = vfs_dedupe_file_range_one(real_in.file, pos_in,
-						real_out.file, pos_out, len,
-						flags);
-		break;
+	cred_scoped_guard(ovl_creds(file_inode(file_out)->i_sb)) {
+		switch (op) {
+		case OVL_COPY:
+			ret = vfs_copy_file_range(real_in.file, pos_in,
+						  real_out.file, pos_out, len, flags);
+			break;
+
+		case OVL_CLONE:
+			ret = vfs_clone_file_range(real_in.file, pos_in,
+						   real_out.file, pos_out, len, flags);
+			break;
+
+		case OVL_DEDUPE:
+			ret = vfs_dedupe_file_range_one(real_in.file, pos_in,
+							real_out.file, pos_out, len,
+							flags);
+			break;
+		}
 	}
-	revert_creds(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file_out);
@@ -579,7 +568,6 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 static int ovl_flush(struct file *file, fl_owner_t id)
 {
 	struct fd real;
-	const struct cred *old_cred;
 	int err;
 
 	err = ovl_real_fdget(file, &real);
@@ -587,9 +575,8 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 		return err;
 
 	if (real.file->f_op->flush) {
-		old_cred = ovl_override_creds(file_inode(file)->i_sb);
+		cred_guard(ovl_creds(file_inode(file)->i_sb));
 		err = real.file->f_op->flush(real.file, id);
-		revert_creds(old_cred);
 	}
 	fdput(real);
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index c63b31a460be..56d7d6516a02 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -26,7 +26,6 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	bool full_copy_up = false;
 	struct dentry *upperdentry;
-	const struct cred *old_cred;
 
 	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (err)
@@ -79,9 +78,9 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out_put_write;
 
 		inode_lock(upperdentry->d_inode);
-		old_cred = ovl_override_creds(dentry->d_sb);
-		err = ovl_do_notify_change(ofs, upperdentry, attr);
-		revert_creds(old_cred);
+		cred_scoped_guard(ovl_creds(dentry->d_sb))
+			err = ovl_do_notify_change(ofs, upperdentry, attr);
+
 		if (!err)
 			ovl_copyattr(dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
@@ -160,7 +159,6 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct dentry *dentry = path->dentry;
 	enum ovl_path_type type;
 	struct path realpath;
-	const struct cred *old_cred;
 	struct inode *inode = d_inode(dentry);
 	bool is_dir = S_ISDIR(inode->i_mode);
 	int fsid = 0;
@@ -170,7 +168,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	metacopy_blocks = ovl_is_metacopy_dentry(dentry);
 
 	type = ovl_path_real(dentry, &realpath);
-	old_cred = ovl_override_creds(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	err = ovl_do_getattr(&realpath, stat, request_mask, flags);
 	if (err)
 		goto out;
@@ -281,8 +279,6 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	revert_creds(old_cred);
-
 	return err;
 }
 
@@ -292,7 +288,6 @@ int ovl_permission(struct mnt_idmap *idmap,
 	struct inode *upperinode = ovl_inode_upper(inode);
 	struct inode *realinode;
 	struct path realpath;
-	const struct cred *old_cred;
 	int err;
 
 	/* Careful in RCU walk mode */
@@ -310,7 +305,8 @@ int ovl_permission(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	cred_guard(ovl_creds(inode->i_sb));
+
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
 		mask &= ~(MAY_WRITE | MAY_APPEND);
@@ -318,7 +314,6 @@ int ovl_permission(struct mnt_idmap *idmap,
 		mask |= MAY_READ;
 	}
 	err = inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
-	revert_creds(old_cred);
 
 	return err;
 }
@@ -327,15 +322,14 @@ static const char *ovl_get_link(struct dentry *dentry,
 				struct inode *inode,
 				struct delayed_call *done)
 {
-	const struct cred *old_cred;
 	const char *p;
 
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	cred_guard(ovl_creds(inode->i_sb));
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	revert_creds(old_cred);
+
 	return p;
 }
 
@@ -466,11 +460,8 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
 
 		acl = get_cached_acl_rcu(realinode, type);
 	} else {
-		const struct cred *old_cred;
-
-		old_cred = ovl_override_creds(inode->i_sb);
+		cred_guard(ovl_creds(inode->i_sb));
 		acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type), noperm);
-		revert_creds(old_cred);
 	}
 
 	return acl;
@@ -482,7 +473,6 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 	int err;
 	struct path realpath;
 	const char *acl_name;
-	const struct cred *old_cred;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdentry = ovl_dentry_upper(dentry);
 	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
@@ -496,10 +486,10 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 		struct posix_acl *real_acl;
 
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds(dentry->d_sb);
-		real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry,
-				       acl_name);
-		revert_creds(old_cred);
+		cred_scoped_guard(ovl_creds(dentry->d_sb))
+			real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry,
+					       acl_name);
+
 		if (IS_ERR(real_acl)) {
 			err = PTR_ERR(real_acl);
 			goto out;
@@ -519,12 +509,12 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	if (acl)
-		err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
-	else
-		err = ovl_do_remove_acl(ofs, realdentry, acl_name);
-	revert_creds(old_cred);
+	cred_scoped_guard(ovl_creds(dentry->d_sb)) {
+		if (acl)
+			err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
+		else
+			err = ovl_do_remove_acl(ofs, realdentry, acl_name);
+	}
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */
@@ -591,7 +581,6 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 {
 	int err;
 	struct inode *realinode = ovl_inode_realdata(inode);
-	const struct cred *old_cred;
 
 	if (!realinode)
 		return -EIO;
@@ -599,9 +588,8 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!realinode->i_op->fiemap)
 		return -EOPNOTSUPP;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	cred_guard(ovl_creds(inode->i_sb));
 	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	revert_creds(old_cred);
 
 	return err;
 }
@@ -649,7 +637,6 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(dentry);
 	struct path upperpath;
-	const struct cred *old_cred;
 	unsigned int flags;
 	int err;
 
@@ -661,7 +648,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		if (err)
 			goto out;
 
-		old_cred = ovl_override_creds(inode->i_sb);
+		cred_guard(ovl_creds(inode->i_sb));
 		/*
 		 * Store immutable/append-only flags in xattr and clear them
 		 * in upper fileattr (in case they were set by older kernel)
@@ -672,7 +659,6 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		err = ovl_set_protattr(inode, upperpath.dentry, fa);
 		if (!err)
 			err = ovl_real_fileattr_set(&upperpath, fa);
-		revert_creds(old_cred);
 		ovl_drop_write(dentry);
 
 		/*
@@ -726,15 +712,13 @@ int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct path realpath;
-	const struct cred *old_cred;
 	int err;
 
 	ovl_path_real(dentry, &realpath);
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	cred_guard(ovl_creds(inode->i_sb));
 	err = ovl_real_fileattr_get(&realpath, fa);
 	ovl_fileattr_prot_flags(inode, fa);
-	revert_creds(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 5764f91d283e..dd7c645140f9 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -953,15 +953,11 @@ static int ovl_maybe_validate_verity(struct dentry *dentry)
 		return err;
 
 	if (!ovl_test_flag(OVL_VERIFIED_DIGEST, inode)) {
-		const struct cred *old_cred;
-
-		old_cred = ovl_override_creds(dentry->d_sb);
+		cred_guard(ovl_creds(dentry->d_sb));
 
 		err = ovl_validate_verity(ofs, &metapath, &datapath);
 		if (err == 0)
 			ovl_set_flag(OVL_VERIFIED_DIGEST, inode);
-
-		revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
@@ -975,7 +971,6 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	struct inode *inode = d_inode(dentry);
 	const char *redirect = ovl_lowerdata_redirect(inode);
 	struct ovl_path datapath = {};
-	const struct cred *old_cred;
 	int err;
 
 	if (!redirect || ovl_dentry_lowerdata(dentry))
@@ -993,9 +988,9 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	if (ovl_dentry_lowerdata(dentry))
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_lookup_data_layers(dentry, redirect, &datapath);
-	revert_creds(old_cred);
+	cred_scoped_guard(ovl_creds(dentry->d_sb))
+		err = ovl_lookup_data_layers(dentry, redirect, &datapath);
+
 	if (err)
 		goto out_err;
 
@@ -1030,7 +1025,6 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			  unsigned int flags)
 {
 	struct ovl_entry *oe = NULL;
-	const struct cred *old_cred;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	struct ovl_entry *roe = OVL_E(dentry->d_sb->s_root);
@@ -1061,7 +1055,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > ofs->namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	upperdir = ovl_dentry_upper(dentry->d_parent);
 	if (upperdir) {
 		d.layer = &ofs->layers[0];
@@ -1342,7 +1336,6 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 
 	ovl_dentry_init_reval(dentry, upperdentry, OVL_I_E(inode));
 
-	revert_creds(old_cred);
 	if (origin_path) {
 		dput(origin_path->dentry);
 		kfree(origin_path);
@@ -1366,7 +1359,6 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	kfree(upperredirect);
 out:
 	kfree(d.redirect);
-	revert_creds(old_cred);
 	return ERR_PTR(err);
 }
 
@@ -1374,7 +1366,6 @@ bool ovl_lower_positive(struct dentry *dentry)
 {
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	const struct qstr *name = &dentry->d_name;
-	const struct cred *old_cred;
 	unsigned int i;
 	bool positive = false;
 	bool done = false;
@@ -1390,7 +1381,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 	if (!ovl_dentry_upper(dentry))
 		return true;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	/* Positive upper -> have to look up lower to see whether it exists */
 	for (i = 0; !done && !positive && i < ovl_numlower(poe); i++) {
 		struct dentry *this;
@@ -1423,7 +1414,6 @@ bool ovl_lower_positive(struct dentry *dentry)
 			dput(this);
 		}
 	}
-	revert_creds(old_cred);
 
 	return positive;
 }
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 0ca8af060b0c..41e01fe3ae4a 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -273,9 +273,8 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 	int err;
 	struct ovl_cache_entry *p;
 	struct dentry *dentry, *dir = path->dentry;
-	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(rdd->dentry->d_sb);
+	cred_guard(ovl_creds(rdd->dentry->d_sb));
 
 	err = down_write_killable(&dir->d_inode->i_rwsem);
 	if (!err) {
@@ -290,7 +289,6 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 		}
 		inode_unlock(dir->d_inode);
 	}
-	revert_creds(old_cred);
 
 	return err;
 }
@@ -753,10 +751,9 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_cache_entry *p;
-	const struct cred *old_cred;
 	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	if (!ctx->pos)
 		ovl_dir_reset(file);
 
@@ -808,7 +805,6 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	}
 	err = 0;
 out:
-	revert_creds(old_cred);
 	return err;
 }
 
@@ -856,11 +852,9 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 					  const struct path *realpath)
 {
 	struct file *res;
-	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	cred_guard(ovl_creds(file_inode(file)->i_sb));
 	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
-	revert_creds(old_cred);
 
 	return res;
 }
@@ -983,11 +977,9 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	int err;
 	struct ovl_cache_entry *p, *n;
 	struct rb_root root = RB_ROOT;
-	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	err = ovl_dir_read_merged(dentry, list, &root);
-	revert_creds(old_cred);
 	if (err)
 		return err;
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index d285d1d7baad..2f8edd1024ff 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1133,7 +1133,6 @@ static void ovl_cleanup_index(struct dentry *dentry)
 int ovl_nlink_start(struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	const struct cred *old_cred;
 	int err;
 
 	if (WARN_ON(!inode))
@@ -1170,15 +1169,16 @@ int ovl_nlink_start(struct dentry *dentry)
 	if (d_is_dir(dentry) || !ovl_test_flag(OVL_INDEX, inode))
 		return 0;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	/*
-	 * The overlay inode nlink should be incremented/decremented IFF the
-	 * upper operation succeeds, along with nlink change of upper inode.
-	 * Therefore, before link/unlink/rename, we store the union nlink
-	 * value relative to the upper inode nlink in an upper inode xattr.
-	 */
-	err = ovl_set_nlink_upper(dentry);
-	revert_creds(old_cred);
+	cred_scoped_guard(ovl_creds(dentry->d_sb)) {
+		/*
+		 * The overlay inode nlink should be incremented/decremented IFF the
+		 * upper operation succeeds, along with nlink change of upper inode.
+		 * Therefore, before link/unlink/rename, we store the union nlink
+		 * value relative to the upper inode nlink in an upper inode xattr.
+		 */
+		err = ovl_set_nlink_upper(dentry);
+	}
+
 	if (err)
 		goto out_drop_write;
 
@@ -1199,11 +1199,8 @@ void ovl_nlink_end(struct dentry *dentry)
 	ovl_drop_write(dentry);
 
 	if (ovl_test_flag(OVL_INDEX, inode) && inode->i_nlink == 0) {
-		const struct cred *old_cred;
-
-		old_cred = ovl_override_creds(dentry->d_sb);
+		cred_guard(ovl_creds(dentry->d_sb));
 		ovl_cleanup_index(dentry);
-		revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 383978e4663c..e4ce093a3a73 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -41,13 +41,11 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	struct dentry *upperdentry = ovl_i_dentry_upper(inode);
 	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
 	struct path realpath;
-	const struct cred *old_cred;
 
 	if (!value && !upperdentry) {
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds(dentry->d_sb);
-		err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
-		revert_creds(old_cred);
+		cred_scoped_guard(ovl_creds(dentry->d_sb))
+			err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
 		if (err < 0)
 			goto out;
 	}
@@ -64,15 +62,15 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	if (value) {
-		err = ovl_do_setxattr(ofs, realdentry, name, value, size,
-				      flags);
-	} else {
-		WARN_ON(flags != XATTR_REPLACE);
-		err = ovl_do_removexattr(ofs, realdentry, name);
+	cred_scoped_guard(ovl_creds(dentry->d_sb)) {
+		if (value) {
+			err = ovl_do_setxattr(ofs, realdentry, name, value, size,
+					      flags);
+		} else {
+			WARN_ON(flags != XATTR_REPLACE);
+			err = ovl_do_removexattr(ofs, realdentry, name);
+		}
 	}
-	revert_creds(old_cred);
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */
@@ -85,13 +83,11 @@ static int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char
 			 void *value, size_t size)
 {
 	ssize_t res;
-	const struct cred *old_cred;
 	struct path realpath;
 
 	ovl_i_path_real(inode, &realpath);
-	old_cred = ovl_override_creds(dentry->d_sb);
+	cred_guard(ovl_creds(dentry->d_sb));
 	res = vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
-	revert_creds(old_cred);
 	return res;
 }
 
@@ -116,12 +112,10 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 	ssize_t res;
 	size_t len;
 	char *s;
-	const struct cred *old_cred;
 	size_t prefix_len, name_len;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_listxattr(realdentry, list, size);
-	revert_creds(old_cred);
+	cred_scoped_guard(ovl_creds(dentry->d_sb))
+		res = vfs_listxattr(realdentry, list, size);
 	if (res <= 0 || size == 0)
 		return res;
 
@@ -268,4 +262,3 @@ const struct xattr_handler * const *ovl_xattr_handlers(struct ovl_fs *ofs)
 	return ofs->config.userxattr ? ovl_user_xattr_handlers :
 		ovl_trusted_xattr_handlers;
 }
-
-- 
2.44.0


