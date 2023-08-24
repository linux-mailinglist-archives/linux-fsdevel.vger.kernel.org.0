Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57415787168
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 16:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbjHXOY0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 10:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241607AbjHXOYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:24:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAEC1989;
        Thu, 24 Aug 2023 07:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9490166811;
        Thu, 24 Aug 2023 14:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF803C433C8;
        Thu, 24 Aug 2023 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692887046;
        bh=9L3jOQbK4eNuAr3wKG6NOy84Ax/7TpBaXMA6Pdv2QOg=;
        h=From:To:Cc:Subject:Date:From;
        b=hCm5LCfEIMSlohy11SpmslqgKaGcL6i8QzYo9D2PRNvfhpW0H5TARoER+rYE1TY62
         o/yogSkxVvhtU+x9NRg66G4TnY2CBGbuHsG0EWEGXJ3WIJjGtcEMS6AvZvbs6ssoGW
         G9wOZsEY6REyAJ5ZLLg6hcHn2DcILLaEY5AAx1aXpkSlkeJaAXj9r2vA8Kgom61x3f
         Q5uWG4CWhHnTwTjL4emRzEHXGcadb9c5Kmn5+FKVyYNJZaukpkvti1/VL+n7M+wZ5I
         06R20Xt2V9+3YlnGHnhJetdsL6W+6CmyD3b7V0B268CeEfGhiH8Wr/foPsBV5L0OoQ
         QrSVa/CPTSZhA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] libfs and tmpfs updates
Date:   Thu, 24 Aug 2023 16:23:52 +0200
Message-Id: <20230824-poren-betanken-fd9aea241890@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15963; i=brauner@kernel.org; h=from:subject:message-id; bh=9L3jOQbK4eNuAr3wKG6NOy84Ax/7TpBaXMA6Pdv2QOg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8Ty+yPnFJUehT4jyX1OPHUlj0e9V5H1Wt5356hYPtm+1P 8zchHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZMZ/hf+Efg1srd8x1KFqcXlVz4f O9bM43ExNelKbwOnnfiBeczs7IsOh3o+KhTEv1Hpe1V590yj3+tKQ0VajtL4Or4o/629mKHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This cycle saw a lot of work for tmpfs that required changes to the vfs
layer. Andrew, Hugh, and I decided to take tmpfs through vfs this cycle.
Things will go back to mm next cycle.

Features
========

* By far the biggest work is the quota support for tmpfs. New tmpfs
  quota infrastructure is added to support it and a new QFMT_SHMEM uapi
  option is exposed.

  This offers user and group quotas to tmpfs (project quotas will be
  added later). Similar to other filesystems tmpfs quota are not
  supported within user namespaces yet.

* Add support for user xattrs. While tmpfs already supports security
  xattrs (security.*) and POSIX ACLs for a long time it lacked support
  for user xattrs (user.*). With this pull request tmpfs will be able to
  support a limited number of user xattrs. This is accompanied by a fix
  (see below) to limit persistent simple xattr allocations.

* Add support for stable directory offsets. Currently tmpfs relies on
  the libfs provided cursor-based mechanism for readdir. This causes
  issues when a tmpfs filesystem is exported via NFS.

  NFS clients do not open directories. Instead, each server-side readdir
  operation opens the directory, reads it, and then closes it. Since the
  cursor state for that directory is associated with the opened file it
  is discarded after each readdir operation. Such directory offsets are
  not just cached by NFS clients but also various userspace libraries
  based on these clients.

  As it stands there is no way to invalidate the caches when directory
  offsets have changed and the whole application depends on unchanging
  directory offsets.

  At LSFMM we discussed how to solve this problem and decided to support
  stable directory offsets. libfs now allows filesystems like tmpfs to
  use an xarrary to map a directory offset to a dentry. This mechanism
  is currently only used by tmpfs but can be supported by others as well.

Fixes
=====

* Change persistent simple xattrs allocations in libfs from GFP_KERNEL
  to GPF_KERNEL_ACCOUNT so they're subject to memory cgroup limits.
  Since this is a change to libfs it affects both tmpfs and kernfs.

* Correctly verify {g,u}id mount options.
  A new filesystem context is created via fsopen() which records the
  namespace that becomes the owning namespace of the superblock when
  fsconfig(FSCONFIG_CMD_CREATE) is called for filesystems that are
  mountable in namespaces. However, fsconfig() calls can occur in a
  namespace different from the namespace where fsopen() has been called.

  Currently, when fsconfig() is called to set {g,u}id mount options the
  requested {g,u}id is mapped into a k{g,u}id according to the namespace
  where fsconfig() was called from. The resulting k{g,u}id is not
  guaranteed to be resolvable in the namespace of the filesystem (the
  one that fsopen() was called in).

  This means it's possible for an unprivileged user to create files
  owned by any group in a tmpfs mount since it's possible to set the
  setid bits on the tmpfs directory.

  The contract for {g,u}id mount options and {g,u}id values in general
  set from userspace has always been that they are translated according
  to the caller's idmapping. In so far, tmpfs has been doing the correct
  thing. But since tmpfs is mountable in unprivileged contexts it is
  also necessary to verify that the resulting {k,g}uid is representable
  in the namespace of the superblock to avoid such bugs.

  The new mount api's cross-namespace delegation abilities are already
  widely used. Having talked to a bunch of userspace this is the most
  faithful solution with minimal regression risks.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.5-rc4 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
selftests, and LTP pass without regressions.

/* Conflicts */
This will cause a merge conflict with the v6.6-vfs.ctime pull request.
The pull request should have been sent and hopefully merged first. In
this case I'd suggest the following conflict resolution should you
decide to pull this branch:

diff --cc mm/shmem.c
index 98cc4be7a8a8,11298c797cdc..a7b15ed56eff
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@@ -2363,67 -2437,75 +2437,74 @@@ static struct inode *__shmem_get_inode(
  	struct shmem_inode_info *info;
  	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
  	ino_t ino;
+ 	int err;
+ 
+ 	err = shmem_reserve_inode(sb, &ino);
+ 	if (err)
+ 		return ERR_PTR(err);
  
- 	if (shmem_reserve_inode(sb, &ino))
- 		return NULL;
  
  	inode = new_inode(sb);
- 	if (inode) {
- 		inode->i_ino = ino;
- 		inode_init_owner(idmap, inode, dir, mode);
- 		inode->i_blocks = 0;
- 		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
- 		inode->i_generation = get_random_u32();
- 		info = SHMEM_I(inode);
- 		memset(info, 0, (char *)inode - (char *)info);
- 		spin_lock_init(&info->lock);
- 		atomic_set(&info->stop_eviction, 0);
- 		info->seals = F_SEAL_SEAL;
- 		info->flags = flags & VM_NORESERVE;
- 		info->i_crtime = inode->i_mtime;
- 		info->fsflags = (dir == NULL) ? 0 :
- 			SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
- 		if (info->fsflags)
- 			shmem_set_inode_flags(inode, info->fsflags);
- 		INIT_LIST_HEAD(&info->shrinklist);
- 		INIT_LIST_HEAD(&info->swaplist);
- 		if (sbinfo->noswap)
- 			mapping_set_unevictable(inode->i_mapping);
- 		simple_xattrs_init(&info->xattrs);
- 		cache_no_acl(inode);
- 		mapping_set_large_folios(inode->i_mapping);
--
- 		switch (mode & S_IFMT) {
- 		default:
- 			inode->i_op = &shmem_special_inode_operations;
- 			init_special_inode(inode, mode, dev);
- 			break;
- 		case S_IFREG:
- 			inode->i_mapping->a_ops = &shmem_aops;
- 			inode->i_op = &shmem_inode_operations;
- 			inode->i_fop = &shmem_file_operations;
- 			mpol_shared_policy_init(&info->policy,
- 						 shmem_get_sbmpol(sbinfo));
- 			break;
- 		case S_IFDIR:
- 			inc_nlink(inode);
- 			/* Some things misbehave if size == 0 on a directory */
- 			inode->i_size = 2 * BOGO_DIRENT_SIZE;
- 			inode->i_op = &shmem_dir_inode_operations;
- 			inode->i_fop = &simple_dir_operations;
- 			break;
- 		case S_IFLNK:
- 			/*
- 			 * Must not load anything in the rbtree,
- 			 * mpol_free_shared_policy will not be called.
- 			 */
- 			mpol_shared_policy_init(&info->policy, NULL);
- 			break;
- 		}
+ 	if (!inode) {
+ 		shmem_free_inode(sb, 0);
+ 		return ERR_PTR(-ENOSPC);
+ 	}
  
- 		lockdep_annotate_inode_mutex_key(inode);
- 	} else
- 		shmem_free_inode(sb);
+ 	inode->i_ino = ino;
+ 	inode_init_owner(idmap, inode, dir, mode);
+ 	inode->i_blocks = 0;
 -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
++	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+ 	inode->i_generation = get_random_u32();
+ 	info = SHMEM_I(inode);
+ 	memset(info, 0, (char *)inode - (char *)info);
+ 	spin_lock_init(&info->lock);
+ 	atomic_set(&info->stop_eviction, 0);
+ 	info->seals = F_SEAL_SEAL;
+ 	info->flags = flags & VM_NORESERVE;
+ 	info->i_crtime = inode->i_mtime;
+ 	info->fsflags = (dir == NULL) ? 0 :
+ 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
+ 	if (info->fsflags)
+ 		shmem_set_inode_flags(inode, info->fsflags);
+ 	INIT_LIST_HEAD(&info->shrinklist);
+ 	INIT_LIST_HEAD(&info->swaplist);
+ 	INIT_LIST_HEAD(&info->swaplist);
+ 	if (sbinfo->noswap)
+ 		mapping_set_unevictable(inode->i_mapping);
+ 	simple_xattrs_init(&info->xattrs);
+ 	cache_no_acl(inode);
+ 	mapping_set_large_folios(inode->i_mapping);
+ 
+ 	switch (mode & S_IFMT) {
+ 	default:
+ 		inode->i_op = &shmem_special_inode_operations;
+ 		init_special_inode(inode, mode, dev);
+ 		break;
+ 	case S_IFREG:
+ 		inode->i_mapping->a_ops = &shmem_aops;
+ 		inode->i_op = &shmem_inode_operations;
+ 		inode->i_fop = &shmem_file_operations;
+ 		mpol_shared_policy_init(&info->policy,
+ 					 shmem_get_sbmpol(sbinfo));
+ 		break;
+ 	case S_IFDIR:
+ 		inc_nlink(inode);
+ 		/* Some things misbehave if size == 0 on a directory */
+ 		inode->i_size = 2 * BOGO_DIRENT_SIZE;
+ 		inode->i_op = &shmem_dir_inode_operations;
+ 		inode->i_fop = &simple_offset_dir_operations;
+ 		simple_offset_init(shmem_get_offset_ctx(inode));
+ 		break;
+ 	case S_IFLNK:
+ 		/*
+ 		 * Must not load anything in the rbtree,
+ 		 * mpol_free_shared_policy will not be called.
+ 		 */
+ 		mpol_shared_policy_init(&info->policy, NULL);
+ 		break;
+ 	}
+ 
+ 	lockdep_annotate_inode_mutex_key(inode);
  	return inode;
  }
  
@@@ -3069,27 -3208,33 +3207,32 @@@ shmem_mknod(struct mnt_idmap *idmap, st
  	    struct dentry *dentry, umode_t mode, dev_t dev)
  {
  	struct inode *inode;
- 	int error = -ENOSPC;
+ 	int error;
  
  	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev, VM_NORESERVE);
- 	if (inode) {
- 		error = simple_acl_create(dir, inode);
- 		if (error)
- 			goto out_iput;
- 		error = security_inode_init_security(inode, dir,
- 						     &dentry->d_name,
- 						     shmem_initxattrs, NULL);
- 		if (error && error != -EOPNOTSUPP)
- 			goto out_iput;
 -
+ 	if (IS_ERR(inode))
+ 		return PTR_ERR(inode);
  
- 		error = 0;
- 		dir->i_size += BOGO_DIRENT_SIZE;
- 		dir->i_mtime = inode_set_ctime_current(dir);
- 		inode_inc_iversion(dir);
- 		d_instantiate(dentry, inode);
- 		dget(dentry); /* Extra count - pin the dentry in core */
- 	}
+ 	error = simple_acl_create(dir, inode);
+ 	if (error)
+ 		goto out_iput;
+ 	error = security_inode_init_security(inode, dir,
+ 					     &dentry->d_name,
+ 					     shmem_initxattrs, NULL);
+ 	if (error && error != -EOPNOTSUPP)
+ 		goto out_iput;
+ 
+ 	error = simple_offset_add(shmem_get_offset_ctx(dir), dentry);
+ 	if (error)
+ 		goto out_iput;
+ 
+ 	dir->i_size += BOGO_DIRENT_SIZE;
 -	dir->i_ctime = dir->i_mtime = current_time(dir);
++	dir->i_mtime = inode_set_ctime_current(dir);
+ 	inode_inc_iversion(dir);
+ 	d_instantiate(dentry, inode);
+ 	dget(dentry); /* Extra count - pin the dentry in core */
  	return error;
+ 
  out_iput:
  	iput(inode);
  	return error;
@@@ -3159,9 -3310,15 +3308,16 @@@ static int shmem_link(struct dentry *ol
  			goto out;
  	}
  
+ 	ret = simple_offset_add(shmem_get_offset_ctx(dir), dentry);
+ 	if (ret) {
+ 		if (inode->i_nlink)
+ 			shmem_free_inode(inode->i_sb, 0);
+ 		goto out;
+ 	}
+ 
  	dir->i_size += BOGO_DIRENT_SIZE;
 -	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 +	dir->i_mtime = inode_set_ctime_to_ts(dir,
 +					     inode_set_ctime_current(inode));
  	inode_inc_iversion(dir);
  	inc_nlink(inode);
  	ihold(inode);	/* New dentry reference */
@@@ -3176,11 -3333,12 +3332,13 @@@ static int shmem_unlink(struct inode *d
  	struct inode *inode = d_inode(dentry);
  
  	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
- 		shmem_free_inode(inode->i_sb);
+ 		shmem_free_inode(inode->i_sb, 0);
+ 
+ 	simple_offset_remove(shmem_get_offset_ctx(dir), dentry);
  
  	dir->i_size -= BOGO_DIRENT_SIZE;
 -	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 +	dir->i_mtime = inode_set_ctime_to_ts(dir,
 +					     inode_set_ctime_current(inode));
  	inode_inc_iversion(dir);
  	drop_nlink(inode);
  	dput(dentry);	/* Undo the count from "create" - this does all the work */
@@@ -3459,15 -3660,40 +3658,40 @@@ static int shmem_xattr_handler_set(cons
  				   size_t size, int flags)
  {
  	struct shmem_inode_info *info = SHMEM_I(inode);
- 	int err;
+ 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+ 	struct simple_xattr *old_xattr;
+ 	size_t ispace = 0;
  
  	name = xattr_full_name(handler, name);
- 	err = simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
- 	if (!err) {
+ 	if (value && sbinfo->max_inodes) {
+ 		ispace = simple_xattr_space(name, size);
+ 		raw_spin_lock(&sbinfo->stat_lock);
+ 		if (sbinfo->free_ispace < ispace)
+ 			ispace = 0;
+ 		else
+ 			sbinfo->free_ispace -= ispace;
+ 		raw_spin_unlock(&sbinfo->stat_lock);
+ 		if (!ispace)
+ 			return -ENOSPC;
+ 	}
+ 
+ 	old_xattr = simple_xattr_set(&info->xattrs, name, value, size, flags);
+ 	if (!IS_ERR(old_xattr)) {
+ 		ispace = 0;
+ 		if (old_xattr && sbinfo->max_inodes)
+ 			ispace = simple_xattr_space(old_xattr->name,
+ 						    old_xattr->size);
+ 		simple_xattr_free(old_xattr);
+ 		old_xattr = NULL;
 -		inode->i_ctime = current_time(inode);
 +		inode_set_ctime_current(inode);
  		inode_inc_iversion(inode);
  	}
- 	return err;
+ 	if (ispace) {
+ 		raw_spin_lock(&sbinfo->stat_lock);
+ 		sbinfo->free_ispace += ispace;
+ 		raw_spin_unlock(&sbinfo->stat_lock);
+ 	}
+ 	return PTR_ERR(old_xattr);
  }
  
  static const struct xattr_handler shmem_security_xattr_handler = {

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.tmpfs

for you to fetch changes up to 572a3d1e5d3a3e335b92e2c28a63c0b27944480c:

  tmpfs,xattr: GFP_KERNEL_ACCOUNT for simple xattrs (2023-08-22 10:57:46 +0200)

Please consider pulling these changes from the signed v6.6-vfs.tmpfs tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-vfs.tmpfs

----------------------------------------------------------------
Carlos Maiolino (3):
      shmem: make shmem_get_inode() return ERR_PTR instead of NULL
      shmem: prepare shmem quota infrastructure
      shmem: quota support

Christian Brauner (1):
      tmpfs: verify {g,u}id mount options correctly

Chuck Lever (5):
      libfs: Add directory operations for stable offsets
      shmem: Refactor shmem_symlink()
      shmem: stable directory offsets
      libfs: Add a lock class for the offset map's xa_lock
      libfs: Remove parent dentry locking in offset_iterate_dir()

Hugh Dickins (8):
      shmem: fix quota lock nesting in huge hole handling
      shmem: move spinlock into shmem_recalc_inode() to fix quota support
      xattr: simple_xattr_set() return old_xattr to be freed
      tmpfs: track free_ispace instead of free_inodes
      tmpfs,xattr: enable limited user extended attributes
      tmpfs: trivial support for direct IO
      mm: invalidation check mapping before folio_contains
      tmpfs,xattr: GFP_KERNEL_ACCOUNT for simple xattrs

Jan Kara (1):
      quota: Check presence of quota operation structures instead of ->quota_read and ->quota_write callbacks

Lukas Czerner (2):
      shmem: make shmem_inode_acct_block() return error
      shmem: Add default quota limit mount options

 Documentation/filesystems/locking.rst |   8 +-
 Documentation/filesystems/tmpfs.rst   |  38 +-
 Documentation/filesystems/vfs.rst     |   6 +-
 fs/Kconfig                            |  16 +-
 fs/kernfs/dir.c                       |   2 +-
 fs/kernfs/inode.c                     |  46 +-
 fs/libfs.c                            | 248 ++++++++++
 fs/quota/dquot.c                      |   2 +-
 fs/xattr.c                            |  83 ++--
 include/linux/fs.h                    |  18 +
 include/linux/shmem_fs.h              |  31 +-
 include/linux/xattr.h                 |  10 +-
 include/uapi/linux/quota.h            |   1 +
 mm/Makefile                           |   2 +-
 mm/huge_memory.c                      |   6 +-
 mm/khugepaged.c                       |  13 +-
 mm/shmem.c                            | 827 +++++++++++++++++++++++++---------
 mm/shmem_quota.c                      | 350 ++++++++++++++
 mm/truncate.c                         |   4 +-
 19 files changed, 1414 insertions(+), 297 deletions(-)
 create mode 100644 mm/shmem_quota.c
