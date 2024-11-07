Return-Path: <linux-fsdevel+bounces-33857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6819BFB15
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD72A2830B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C3739AEB;
	Thu,  7 Nov 2024 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kv1oxmmc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8010A1F;
	Thu,  7 Nov 2024 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941068; cv=none; b=ak46VY601t8nTjb6b2792qYxMBWz0F2lPfoqR/0asxK76JkRIEm/KH5yWNb7kF2X3PKdC3CZLUDtw4CeqaZbT4nN51aSGSPT7KgRkefhwM6PegyZwrhMD5ZkLU16wpn/Zgl2tWXqYUn84WeDbyHv4kXJQb4DvNcO9x288pL4LMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941068; c=relaxed/simple;
	bh=BgP7CUVEi1v7wLqOlPeBJI6W/NpcpFWJok8RKMmKwVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLqFfGZExyx0GoZbAjFpu9yTlDJRWQDOVS8ZPuZoJ5BBNx39uyEz6diIQpd2eIE6B2Vrnk+L7Z5Y3k56hP9aZbF+PJBxWRrbA1kTz/Z5CRHLvT/gjJFi+Ggprk/GSYJA8KTLsOPSD8HX6rhS/UtxYDD/AlonA6azGtlaLereLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kv1oxmmc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730941066; x=1762477066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BgP7CUVEi1v7wLqOlPeBJI6W/NpcpFWJok8RKMmKwVM=;
  b=kv1oxmmcJx4zB7/XuG542tH+DVtGmAVOP0jEezt0uEOq0nt7uMXVw+Lu
   sQsbvwLzcju4c+DzLlYHXhQmDDkXGFbhwUGnjW9vMiQU/crAZQ8/0+vaj
   GyZs64yab68g42cjSdGwgAPmOV40lYUJwgzTGmSRb1BsbNFiGpJ4vsqxx
   EcP7jZqhKQhatx3OFI0UcA1mqzZIMqhLiR+D4PGKlNSy+VRSCD4ozNqM7
   1n7W1hp4+YUHsaeqBQI3GScugfFAAM47VJqgm1QF+XYXTetWUvWT4PTcv
   xtPYnKeipQKFZ8T/+bM0DZShoWUoAENRZeduV7GBTaPzwatWZbbdPAspd
   Q==;
X-CSE-ConnectionGUID: YyAT43I/R9GWYaQ1sW9cBQ==
X-CSE-MsgGUID: GLmnOKHmQ7Ka4R+Jm4ZxRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41320194"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41320194"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:57:43 -0800
X-CSE-ConnectionGUID: 1EG1mS+WRuC1KdsV4VzkpQ==
X-CSE-MsgGUID: ftjVFDwwTmCUR5pMu5MA/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="85193440"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO vcostago-mobl3.lan) ([10.124.222.105])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:57:42 -0800
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
Subject: [PATCH v4 3/4] ovl: use wrapper ovl_revert_creds()
Date: Wed,  6 Nov 2024 16:57:19 -0800
Message-ID: <20241107005720.901335-4-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107005720.901335-1-vinicius.gomes@intel.com>
References: <20241107005720.901335-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce ovl_revert_creds() wrapper of revert_creds() to
match callers of ovl_override_creds().

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c   |  2 +-
 fs/overlayfs/dir.c       | 10 +++++-----
 fs/overlayfs/file.c      | 14 +++++++-------
 fs/overlayfs/inode.c     | 20 ++++++++++----------
 fs/overlayfs/namei.c     | 10 +++++-----
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/readdir.c   |  8 ++++----
 fs/overlayfs/util.c      |  9 +++++++--
 fs/overlayfs/xattrs.c    |  9 ++++-----
 9 files changed, 44 insertions(+), 39 deletions(-)

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
index ab65e98a1def..09db5eb19242 100644
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
@@ -1337,7 +1337,7 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 		fput(realfile);
 	}
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return err;
 }
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 12c4d502ff91..608a88ff8d81 100644
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
@@ -215,7 +215,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	ret = vfs_llseek(fd_file(real), offset, whence);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	file->f_pos = fd_file(real)->f_pos;
 	ovl_inode_unlock(inode);
@@ -412,7 +412,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (file_inode(fd_file(real)) == ovl_inode_upper(file_inode(file))) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
 		ret = vfs_fsync_range(fd_file(real), start, end, datasync);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 
 	fdput(real);
@@ -451,7 +451,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fallocate(fd_file(real), mode, offset, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file);
@@ -476,7 +476,7 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fadvise(fd_file(real), offset, len, advice);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	fdput(real);
 
@@ -535,7 +535,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 						flags);
 		break;
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file_out);
@@ -597,7 +597,7 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 	if (fd_file(real)->f_op->flush) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
 		err = fd_file(real)->f_op->flush(fd_file(real), id);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 	fdput(real);
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 35fd3e3e1778..6c3add3801be 100644
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
@@ -671,7 +671,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		err = ovl_set_protattr(inode, upperpath.dentry, fa);
 		if (!err)
 			err = ovl_real_fileattr_set(&upperpath, fa);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 		ovl_drop_write(dentry);
 
 		/*
@@ -733,7 +733,7 @@ int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa)
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
index 0bfe35da4b7b..7b7a6e3a43e2 100644
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
index edc9216f6e27..9408046f4f41 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -68,6 +68,11 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 	return override_creds(ofs->creator_cred);
 }
 
+void ovl_revert_creds(const struct cred *old_cred)
+{
+	revert_creds(old_cred);
+}
+
 /*
  * Check if underlying fs supports file handles and try to determine encoding
  * type, in order to deduce maximum inode number used by fs.
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


