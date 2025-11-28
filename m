Return-Path: <linux-fsdevel+bounces-70163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E53C92A67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F67F34F580
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDBB2F5313;
	Fri, 28 Nov 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhMJAP52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD72F3C0E;
	Fri, 28 Nov 2025 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348691; cv=none; b=nMmvmLS4K8odM+MEaderjA8KgKqGVIOiejq9aeZyoTrzxwn/Iw8Vb1UpxMV8WrwahnOAywZynG53K9V6TcFBzZ/8ktWBCTKU6rWAbbA6+pSUL2f9fyw7DXNlIMdyx0691xRFOP7OnuMyOUBQq/fLm5XCk1rUF1e+p8Ec1jOERo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348691; c=relaxed/simple;
	bh=VtyyiyeiJ2kLLB5crSkh5yoObfsW+nVhTsF9BZEtT3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBGdi/F5uiXHIo8PReyufL9mRa5kxmKCgD8BpgoT0/bW3G1B5zKXvKjrUJgUQnDoyC4nVOdHfWoTTRk19UeRNJZ8sLv9vkSckB0lDIBhYV4HR3gmm6+pxX5HnOJB1bNEduumbrICpcCz/8RQgnmt4f/tc15zP8rmOOTf244GbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhMJAP52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BF6C4CEFB;
	Fri, 28 Nov 2025 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348691;
	bh=VtyyiyeiJ2kLLB5crSkh5yoObfsW+nVhTsF9BZEtT3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhMJAP52Alwdxh4VJicFs7RzNHIYIKl6PgvigoyHX/cgLgoemd5X/W5wLZ+WJ4RkT
	 PLWgymMQQZQAWSvCVJLNLsZHm3B2IgxO/zpZ+EYAH+6f7Z9NLiHvu0RpD337Wkw/UH
	 rRDg7EGCYwhFzLcunwvfe/lqIlRaeBR3cY08ShFy+USweCYEWxV0AX30QvjsxtugT6
	 1jORfaT5+ewEyhW8QZKtL6TCwawhe2d+Y9AvYjfwLazXAORJc7oUx3hWgbVRB+uVSI
	 k52NkUBBSHX/hUJOea66MnaIpzNZ+quejHY9un+mOcrNng8NTHJgQX3GWEDB2niARz
	 Hjjcf+NefFtgQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 13/17 for v6.19] vfs directory locking
Date: Fri, 28 Nov 2025 17:48:24 +0100
Message-ID: <20251128-vfs-directory-locking-v619-311b82e68064@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14745; i=brauner@kernel.org; h=from:subject:message-id; bh=VtyyiyeiJ2kLLB5crSkh5yoObfsW+nVhTsF9BZEtT3I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnoslvq2sXN/gIXdrRXXGvdeEl371/4Gk5yi4oKdT R9OnF5+s6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiuX8ZGTr3T1IsDa8/EXTV 9nKW7tzaPZvk5dX7z0q+Dep7sDpn4jKGv2LnKi8WBaXdZDt6lKv/t4zmkX4VoT5X4cMr607+epl 7mg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the work to add centralized APIs for directory locking
operations.

This series is part of a larger effort to change directory operation
locking to allow multiple concurrent operations in a directory. The
ultimate goal is to lock the target dentry(s) rather than the whole
parent directory.

To help with changing the locking protocol, this series centralizes
locking and lookup in new helper functions. The helpers establish a
pattern where it is the dentry that is being locked and unlocked
(currently the lock is held on dentry->d_parent->d_inode, but that can
change in the future).

This also changes vfs_mkdir() to unlock the parent on failure, as well
as dput()ing the dentry. This allows end_creating() to only require the
target dentry (which may be IS_ERR() after vfs_mkdir()), not the parent.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline or other vfs branches
===================================================

[1] This contains a merge conflict with the directory delegation changes:

diff --cc fs/cachefiles/namei.c
index 50c0f9c76d1f,ef22ac19545b..000000000000
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@@ -129,10 -128,12 +128,12 @@@ retry
  		if (ret < 0)
  			goto mkdir_error;
  		ret = cachefiles_inject_write_error();
- 		if (ret == 0)
+ 		if (ret == 0) {
 -			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
 +			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700, NULL);
- 		else
+ 		} else {
+ 			end_creating(subdir);
  			subdir = ERR_PTR(ret);
+ 		}
  		if (IS_ERR(subdir)) {
  			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
  						   cachefiles_trace_mkdir_error);
diff --cc fs/ecryptfs/inode.c
index dc3ee0cbd77a,2ad1db2cd2ec..000000000000
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@@ -186,9 -190,12 +190,11 @@@ ecryptfs_do_create(struct inode *direct
  	struct inode *lower_dir;
  	struct inode *inode;
  
- 	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
- 	if (!rc)
- 		rc = vfs_create(&nop_mnt_idmap, lower_dentry, mode, NULL);
+ 	lower_dentry = ecryptfs_start_creating_dentry(ecryptfs_dentry);
+ 	if (IS_ERR(lower_dentry))
+ 		return ERR_CAST(lower_dentry);
+ 	lower_dir = lower_dentry->d_parent->d_inode;
 -	rc = vfs_create(&nop_mnt_idmap, lower_dir,
 -			lower_dentry, mode, true);
++	rc = vfs_create(&nop_mnt_idmap, lower_dentry, mode, NULL);
  	if (rc) {
  		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
  		       "rc = [%d]\n", __func__, rc);
@@@ -500,14 -511,16 +510,16 @@@ static struct dentry *ecryptfs_mkdir(st
  {
  	int rc;
  	struct dentry *lower_dentry;
+ 	struct dentry *lower_dir_dentry;
  	struct inode *lower_dir;
  
- 	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
- 	if (rc)
- 		goto out;
- 
+ 	lower_dentry = ecryptfs_start_creating_dentry(dentry);
+ 	if (IS_ERR(lower_dentry))
+ 		return lower_dentry;
+ 	lower_dir_dentry = dget(lower_dentry->d_parent);
+ 	lower_dir = lower_dir_dentry->d_inode;
  	lower_dentry = vfs_mkdir(&nop_mnt_idmap, lower_dir,
 -				 lower_dentry, mode);
 +				 lower_dentry, mode, NULL);
  	rc = PTR_ERR(lower_dentry);
  	if (IS_ERR(lower_dentry))
  		goto out;
@@@ -533,14 -546,12 +545,12 @@@ static int ecryptfs_rmdir(struct inode 
  	struct inode *lower_dir;
  	int rc;
  
- 	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
- 	dget(lower_dentry);	// don't even try to make the lower negative
- 	if (!rc) {
- 		if (d_unhashed(lower_dentry))
- 			rc = -EINVAL;
- 		else
- 			rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry, NULL);
- 	}
+ 	lower_dentry = ecryptfs_start_removing_dentry(dentry);
+ 	if (IS_ERR(lower_dentry))
+ 		return PTR_ERR(lower_dentry);
+ 	lower_dir = lower_dentry->d_parent->d_inode;
+ 
 -	rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
++	rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry, NULL);
  	if (!rc) {
  		clear_nlink(d_inode(dentry));
  		fsstack_copy_attr_times(dir, lower_dir);
@@@ -561,10 -571,12 +570,12 @@@ ecryptfs_mknod(struct mnt_idmap *idmap
  	struct dentry *lower_dentry;
  	struct inode *lower_dir;
  
- 	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
- 	if (!rc)
- 		rc = vfs_mknod(&nop_mnt_idmap, lower_dir,
- 			       lower_dentry, mode, dev, NULL);
+ 	lower_dentry = ecryptfs_start_creating_dentry(dentry);
+ 	if (IS_ERR(lower_dentry))
+ 		return PTR_ERR(lower_dentry);
+ 	lower_dir = lower_dentry->d_parent->d_inode;
+ 
 -	rc = vfs_mknod(&nop_mnt_idmap, lower_dir, lower_dentry, mode, dev);
++	rc = vfs_mknod(&nop_mnt_idmap, lower_dir, lower_dentry, mode, dev, NULL);
  	if (rc || d_really_is_negative(lower_dentry))
  		goto out;
  	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
diff --cc fs/namei.c
index 13041756d941,d284ebae41bf..000000000000
--- a/fs/namei.c
+++ b/fs/namei.c
@@@ -4717,12 -5171,10 +5288,11 @@@ retry
  	error = security_path_rmdir(&path, dentry);
  	if (error)
  		goto exit4;
 -	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
 +	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode,
 +			  dentry, &delegated_inode);
  exit4:
- 	dput(dentry);
+ 	end_dirop(dentry);
  exit3:
- 	inode_unlock(path.dentry->d_inode);
  	mnt_drop_write(path.mnt);
  exit2:
  	path_put(&path);
@@@ -4845,31 -5289,33 +5415,33 @@@ retry
  
  	error = mnt_want_write(path.mnt);
  	if (error)
- 		goto exit2;
+ 		goto exit_path_put;
  retry_deleg:
- 	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
- 	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+ 	dentry = start_dirop(path.dentry, &last, lookup_flags);
  	error = PTR_ERR(dentry);
- 	if (!IS_ERR(dentry)) {
+ 	if (IS_ERR(dentry))
+ 		goto exit_drop_write;
  
- 		/* Why not before? Because we want correct error value */
- 		if (last.name[last.len])
- 			goto slashes;
- 		inode = dentry->d_inode;
- 		ihold(inode);
- 		error = security_path_unlink(&path, dentry);
- 		if (error)
- 			goto exit3;
- 		error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
- 				   dentry, &delegated_inode);
- exit3:
- 		dput(dentry);
+ 	/* Why not before? Because we want correct error value */
+ 	if (unlikely(last.name[last.len])) {
+ 		if (d_is_dir(dentry))
+ 			error = -EISDIR;
+ 		else
+ 			error = -ENOTDIR;
+ 		end_dirop(dentry);
+ 		goto exit_drop_write;
  	}
- 	inode_unlock(path.dentry->d_inode);
- 	if (inode)
- 		iput(inode);	/* truncate the inode here */
- 	inode = NULL;
+ 	inode = dentry->d_inode;
+ 	ihold(inode);
+ 	error = security_path_unlink(&path, dentry);
+ 	if (error)
+ 		goto exit_end_dirop;
+ 	error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
+ 			   dentry, &delegated_inode);
+ exit_end_dirop:
+ 	end_dirop(dentry);
+ 	iput(inode);	/* truncate the inode here */
 -	if (delegated_inode) {
 +	if (is_delegated(&delegated_inode)) {
  		error = break_deleg_wait(&delegated_inode);
  		if (!error)
  			goto retry_deleg;
@@@ -5407,11 -5824,8 +5972,8 @@@ int do_renameat2(int olddfd, struct fil
  	struct path old_path, new_path;
  	struct qstr old_last, new_last;
  	int old_type, new_type;
 -	struct inode *delegated_inode = NULL;
 +	struct delegated_inode delegated_inode = { };
- 	unsigned int lookup_flags = 0, target_flags =
- 		LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
+ 	unsigned int lookup_flags = 0;
  	bool should_retry = false;
  	int error = -EINVAL;
  
@@@ -5480,44 -5883,24 +6031,24 @@@ retry_deleg
  		}
  	}
  	/* unless the source is a directory trailing slashes give -ENOTDIR */
- 	if (!d_is_dir(old_dentry)) {
+ 	if (!d_is_dir(rd.old_dentry)) {
  		error = -ENOTDIR;
  		if (old_last.name[old_last.len])
- 			goto exit5;
+ 			goto exit_unlock;
  		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
- 			goto exit5;
+ 			goto exit_unlock;
  	}
- 	/* source should not be ancestor of target */
- 	error = -EINVAL;
- 	if (old_dentry == trap)
- 		goto exit5;
- 	/* target should not be an ancestor of source */
- 	if (!(flags & RENAME_EXCHANGE))
- 		error = -ENOTEMPTY;
- 	if (new_dentry == trap)
- 		goto exit5;
  
- 	error = security_path_rename(&old_path, old_dentry,
- 				     &new_path, new_dentry, flags);
+ 	error = security_path_rename(&old_path, rd.old_dentry,
+ 				     &new_path, rd.new_dentry, flags);
  	if (error)
- 		goto exit5;
+ 		goto exit_unlock;
  
- 	rd.old_parent	   = old_path.dentry;
- 	rd.old_dentry	   = old_dentry;
- 	rd.mnt_idmap	   = mnt_idmap(old_path.mnt);
- 	rd.new_parent	   = new_path.dentry;
- 	rd.new_dentry	   = new_dentry;
- 	rd.delegated_inode = &delegated_inode;
- 	rd.flags	   = flags;
  	error = vfs_rename(&rd);
- exit5:
- 	dput(new_dentry);
- exit4:
- 	dput(old_dentry);
- exit3:
- 	unlock_rename(new_path.dentry, old_path.dentry);
+ exit_unlock:
+ 	end_renaming(&rd);
  exit_lock_rename:
 -	if (delegated_inode) {
 +	if (is_delegated(&delegated_inode)) {
  		error = break_deleg_wait(&delegated_inode);
  		if (!error)
  			goto retry_deleg;
diff --cc fs/nfsd/nfs4recover.c
index 30bae93931d9,18c08395b273..000000000000
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@@ -212,15 -210,13 +210,13 @@@ nfsd4_create_clid_dir(struct nfs4_clien
  		 * In the 4.0 case, we should never get here; but we may
  		 * as well be forgiving and just succeed silently.
  		 */
- 		goto out_put;
+ 		goto out_end;
 -	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
 +	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, 0700, NULL);
  	if (IS_ERR(dentry))
  		status = PTR_ERR(dentry);
- out_put:
- 	if (!status)
- 		dput(dentry);
- out_unlock:
- 	inode_unlock(d_inode(dir));
+ out_end:
+ 	end_creating(dentry);
+ out:
  	if (status == 0) {
  		if (nn->in_grace)
  			__nfsd4_create_reclaim_record_grace(clp, dname,
@@@ -328,20 -324,12 +324,12 @@@ nfsd4_unlink_clid_dir(char *name, struc
  	dprintk("NFSD: nfsd4_unlink_clid_dir. name %s\n", name);
  
  	dir = nn->rec_file->f_path.dentry;
- 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
- 	dentry = lookup_one(&nop_mnt_idmap, &QSTR(name), dir);
- 	if (IS_ERR(dentry)) {
- 		status = PTR_ERR(dentry);
- 		goto out_unlock;
- 	}
- 	status = -ENOENT;
- 	if (d_really_is_negative(dentry))
- 		goto out;
+ 	dentry = start_removing(&nop_mnt_idmap, dir, &QSTR(name));
+ 	if (IS_ERR(dentry))
+ 		return PTR_ERR(dentry);
+ 
 -	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
 +	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry, NULL);
- out:
- 	dput(dentry);
- out_unlock:
- 	inode_unlock(d_inode(dir));
+ 	end_removing(dentry);
  	return status;
  }
  

Merge conflicts with other trees
================================

[1]: https://lore.kernel.org/linux-next/20251121082731.0e39ee5d@canb.auug.org.au

[2]: https://lore.kernel.org/linux-next/20251121083333.48687f3e@canb.auug.org.au

[3]: https://lore.kernel.org/linux-next/20251121084211.7accff09@canb.auug.org.au

[4]: https://lore.kernel.org/linux-next/20251121084753.585ab636@canb.auug.org.au

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.directory.locking

for you to fetch changes up to eeec741ee0df36e79a847bb5423f9eef4ed96071:

  nfsd: fix end_creating() conversion (2025-11-28 09:51:16 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.directory.locking tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.directory.locking

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Create and use APIs to centralise locking for directory ops."

Neil Brown (1):
      nfsd: fix end_creating() conversion

NeilBrown (15):
      debugfs: rename end_creating() to debugfs_end_creating()
      VFS: introduce start_dirop() and end_dirop()
      VFS: tidy up do_unlinkat()
      VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()
      VFS/nfsd/cachefiles/ovl: introduce start_removing() and end_removing()
      VFS: introduce start_creating_noperm() and start_removing_noperm()
      smb/server: use end_removing_noperm for for target of smb2_create_link()
      VFS: introduce start_removing_dentry()
      VFS: add start_creating_killable() and start_removing_killable()
      VFS/nfsd/ovl: introduce start_renaming() and end_renaming()
      VFS/ovl/smb: introduce start_renaming_dentry()
      Add start_renaming_two_dentries()
      ecryptfs: use new start_creating/start_removing APIs
      VFS: change vfs_mkdir() to unlock on failure.
      VFS: introduce end_creating_keep()

 Documentation/filesystems/porting.rst |  13 +
 fs/btrfs/ioctl.c                      |  41 +-
 fs/cachefiles/interface.c             |  11 +-
 fs/cachefiles/namei.c                 |  96 +++--
 fs/cachefiles/volume.c                |   9 +-
 fs/debugfs/inode.c                    |  74 ++--
 fs/ecryptfs/inode.c                   | 153 ++++---
 fs/fuse/dir.c                         |  19 +-
 fs/internal.h                         |   3 +
 fs/libfs.c                            |  36 +-
 fs/namei.c                            | 747 +++++++++++++++++++++++++++++-----
 fs/nfsd/nfs3proc.c                    |  14 +-
 fs/nfsd/nfs4proc.c                    |  14 +-
 fs/nfsd/nfs4recover.c                 |  34 +-
 fs/nfsd/nfsproc.c                     |  14 +-
 fs/nfsd/vfs.c                         | 157 +++----
 fs/overlayfs/copy_up.c                |  73 ++--
 fs/overlayfs/dir.c                    | 241 ++++++-----
 fs/overlayfs/overlayfs.h              |  47 ++-
 fs/overlayfs/readdir.c                |   8 +-
 fs/overlayfs/super.c                  |  49 +--
 fs/overlayfs/util.c                   |  11 -
 fs/smb/server/smb2pdu.c               |   6 +-
 fs/smb/server/vfs.c                   | 114 ++----
 fs/smb/server/vfs.h                   |   8 +-
 fs/xfs/scrub/orphanage.c              |  11 +-
 include/linux/fs.h                    |   2 +
 include/linux/namei.h                 |  82 ++++
 ipc/mqueue.c                          |  32 +-
 security/apparmor/apparmorfs.c        |   8 +-
 security/selinux/selinuxfs.c          |  15 +-
 31 files changed, 1303 insertions(+), 839 deletions(-)

