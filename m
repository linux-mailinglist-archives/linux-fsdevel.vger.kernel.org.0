Return-Path: <linux-fsdevel+bounces-33697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ADA9BD5FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 20:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29881F24D9D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35235212D21;
	Tue,  5 Nov 2024 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1ZQrnmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32E212626;
	Tue,  5 Nov 2024 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835341; cv=none; b=FSKpemqcPS6u/Zkljf5HT8Clf9aM7FKIfl14hj9GOozIxNHFIE6iiYcnISBtFOSj9n9yF5xzhoFalG09kfPdy9bY0nwLI4gwm/O2rcm+tInCRwsrjaIgwHaAkWZ4V8H7iRotKd4Ubqk3hqaiO7JXmozPU3FubOb6SE+5IPmGgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835341; c=relaxed/simple;
	bh=6BA4/DdHmx50dp2MTaL45n7sznxf6N9VEEaIYVuoZvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEt7gl64dspQLIB9QcnoEeYz44GXEyaPu8i450nA9iSxJa2fQIVc2FrpCkjOmXH4wdu82Qjn+PRjKPuXAXbd2gC0h0+u510+2QCxtl0qIq/z402e/PJazCsk8JYic+8sB6V8HjdKSSGIubV+nWojA4ub39BeFOM6oIOFzLiFgd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1ZQrnmf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730835340; x=1762371340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6BA4/DdHmx50dp2MTaL45n7sznxf6N9VEEaIYVuoZvQ=;
  b=e1ZQrnmf1ed3F1zLMmMjtG2Y3nNIl0+NbrPgWGzNMl0Duq/KVU67+U2W
   1X5iMbFNyqMuXVTFpNYIqtxkNmABOGEpbBUs5iE1ZsHS5UVFxerjB3QGB
   HBAAf3bw7w+JFeacaZEav6jabNjwt1VUd60e0OLBihV+Buh3aW1HDdsMi
   0fqWRUPKV6XftQXA8NIhU3Z9JolAnibQSwcbgBzUbpheuA2CWZwtljqPp
   D+XE9eblvgT4Sfjf41TLRyl/83BOuupi1MTKGHN7pBsPBCM817ZLcbfdq
   YxzdgUU+FKSu95YLH4KdRXKJY4vyH2X+cvcSN/+2eUY9JrORoMa0SB4lh
   w==;
X-CSE-ConnectionGUID: iHKgQ2yzSES1NVKkRgctTQ==
X-CSE-MsgGUID: 3Gb0XkprRhGsQyG4ggT81w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34297823"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34297823"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:35:37 -0800
X-CSE-ConnectionGUID: 9iTvh/FCQmWHQGAlOylMGQ==
X-CSE-MsgGUID: ZeP3YiqITXGQOOEVDOD1mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="114939406"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO vcostago-mobl3.intel.com) ([10.124.221.238])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:35:36 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH overlayfs-next v3 3/4] fs/overlayfs: Optimize override/revert creds
Date: Tue,  5 Nov 2024 11:35:13 -0800
Message-ID: <20241105193514.828616-4-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105193514.828616-1-vinicius.gomes@intel.com>
References: <20241105193514.828616-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove refcount changes when overriding or reverting the credentials
in overlayfs. Since the mounter's credentials have a longer lifetime
than the operations using them, you can omit 'cred->usage' increment
and decrement.

The change has a few sub-parts:
 1. Modify ovl_override_creds() to use override_creds_light();
 2. Introduce ovl_revert_creds(), which use revert_creds_light();
 3. Replace usages of revert_creds() by ovl_revert_creds();

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/copy_up.c   |  2 +-
 fs/overlayfs/dir.c       | 10 +++++-----
 fs/overlayfs/file.c      | 14 +++++++-------
 fs/overlayfs/inode.c     | 20 ++++++++++----------
 fs/overlayfs/namei.c     | 10 +++++-----
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/readdir.c   |  8 ++++----
 fs/overlayfs/util.c      | 11 ++++++++---
 fs/overlayfs/xattrs.c    |  9 ++++-----
 9 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 2ed6ad641a20..dafd1c71b977 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1260,7 +1260,7 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		dput(parent);
 		dput(next);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 4cf6cc3a5c9d..74769d47c8ae 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -621,7 +621,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		err = ovl_create_over_whiteout(dentry, inode, attr);
 
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return err;
 }
 
@@ -702,7 +702,7 @@ static int ovl_set_link_redirect(struct dentry *dentry)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_set_redirect(dentry, false);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -912,7 +912,7 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 		err = ovl_remove_upper(dentry, is_dir, &list);
 	else
 		err = ovl_remove_and_whiteout(dentry, &list);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);
@@ -1292,7 +1292,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 	else
@@ -1345,7 +1345,7 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 		ovl_file_free(of);
 	}
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return err;
 }
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 00eba1278793..969b458100fe 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -51,7 +51,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 		realfile = backing_file_open(&file->f_path, flags, realpath,
 					     current_cred());
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,
@@ -275,7 +275,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	ret = vfs_llseek(realfile, offset, whence);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	file->f_pos = realfile->f_pos;
 	ovl_inode_unlock(inode);
@@ -471,7 +471,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fsync_range(upperfile, start, end, datasync);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return ret;
 }
@@ -508,7 +508,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fallocate(realfile, mode, offset, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file);
@@ -531,7 +531,7 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fadvise(realfile, offset, len, advice);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return ret;
 }
@@ -588,7 +588,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 						flags);
 		break;
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file_out);
@@ -647,7 +647,7 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 	if (realfile->f_op->flush) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
 		err = realfile->f_op->flush(realfile, id);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 
 	return err;
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index baa54c718bd7..a3798040532a 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -80,7 +80,7 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		inode_lock(upperdentry->d_inode);
 		old_cred = ovl_override_creds(dentry->d_sb);
 		err = ovl_do_notify_change(ofs, upperdentry, attr);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 		if (!err)
 			ovl_copyattr(dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
@@ -280,7 +280,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -317,7 +317,7 @@ int ovl_permission(struct mnt_idmap *idmap,
 		mask |= MAY_READ;
 	}
 	err = inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -334,7 +334,7 @@ static const char *ovl_get_link(struct dentry *dentry,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return p;
 }
 
@@ -469,7 +469,7 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
 
 		old_cred = ovl_override_creds(inode->i_sb);
 		acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type), noperm);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 
 	return acl;
@@ -498,7 +498,7 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 		old_cred = ovl_override_creds(dentry->d_sb);
 		real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry,
 				       acl_name);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 		if (IS_ERR(real_acl)) {
 			err = PTR_ERR(real_acl);
 			goto out;
@@ -523,7 +523,7 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 		err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
 	else
 		err = ovl_do_remove_acl(ofs, realdentry, acl_name);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */
@@ -600,7 +600,7 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -676,7 +676,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		err = ovl_set_protattr(inode, upperpath.dentry, fa);
 		if (!err)
 			err = ovl_real_fileattr_set(&upperpath, fa);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 		ovl_drop_write(dentry);
 
 		/*
@@ -738,7 +738,7 @@ int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	old_cred = ovl_override_creds(inode->i_sb);
 	err = ovl_real_fileattr_get(&realpath, fa);
 	ovl_fileattr_prot_flags(inode, fa);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 5764f91d283e..7e27b7d4adee 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -961,7 +961,7 @@ static int ovl_maybe_validate_verity(struct dentry *dentry)
 		if (err == 0)
 			ovl_set_flag(OVL_VERIFIED_DIGEST, inode);
 
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
@@ -995,7 +995,7 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_lookup_data_layers(dentry, redirect, &datapath);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (err)
 		goto out_err;
 
@@ -1342,7 +1342,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 
 	ovl_dentry_init_reval(dentry, upperdentry, OVL_I_E(inode));
 
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (origin_path) {
 		dput(origin_path->dentry);
 		kfree(origin_path);
@@ -1366,7 +1366,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	kfree(upperredirect);
 out:
 	kfree(d.redirect);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return ERR_PTR(err);
 }
 
@@ -1423,7 +1423,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 			dput(this);
 		}
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return positive;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 7453815bc0f3..6e32eb9cd1b6 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -429,6 +429,7 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
+void ovl_revert_creds(const struct cred *old_cred);
 
 static inline const struct cred *ovl_creds(struct super_block *sb)
 {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 0ca8af060b0c..881ec5592da5 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -290,7 +290,7 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 		}
 		inode_unlock(dir->d_inode);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -808,7 +808,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	}
 	err = 0;
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return err;
 }
 
@@ -860,7 +860,7 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return res;
 }
@@ -987,7 +987,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_dir_read_merged(dentry, list, &root);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (err)
 		return err;
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index edc9216f6e27..d0c379fb8885 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -65,7 +65,12 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 {
 	struct ovl_fs *ofs = OVL_FS(sb);
 
-	return override_creds(ofs->creator_cred);
+	return override_creds_light(ofs->creator_cred);
+}
+
+void ovl_revert_creds(const struct cred *old_cred)
+{
+	revert_creds_light((struct cred *)old_cred);
 }
 
 /*
@@ -1178,7 +1183,7 @@ int ovl_nlink_start(struct dentry *dentry)
 	 * value relative to the upper inode nlink in an upper inode xattr.
 	 */
 	err = ovl_set_nlink_upper(dentry);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (err)
 		goto out_drop_write;
 
@@ -1203,7 +1208,7 @@ void ovl_nlink_end(struct dentry *dentry)
 
 		old_cred = ovl_override_creds(dentry->d_sb);
 		ovl_cleanup_index(dentry);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 383978e4663c..88055deca936 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -47,7 +47,7 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 		ovl_path_lower(dentry, &realpath);
 		old_cred = ovl_override_creds(dentry->d_sb);
 		err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 		if (err < 0)
 			goto out;
 	}
@@ -72,7 +72,7 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 		WARN_ON(flags != XATTR_REPLACE);
 		err = ovl_do_removexattr(ofs, realdentry, name);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */
@@ -91,7 +91,7 @@ static int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char
 	ovl_i_path_real(inode, &realpath);
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return res;
 }
 
@@ -121,7 +121,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_listxattr(realdentry, list, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (res <= 0 || size == 0)
 		return res;
 
@@ -268,4 +268,3 @@ const struct xattr_handler * const *ovl_xattr_handlers(struct ovl_fs *ofs)
 	return ofs->config.userxattr ? ovl_user_xattr_handlers :
 		ovl_trusted_xattr_handlers;
 }
-
-- 
2.47.0


