Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7873C6F64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhGMLTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235893AbhGMLTg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23C4B61164;
        Tue, 13 Jul 2021 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175006;
        bh=oLFPloEMpeQx+9oI6PlArWfyY4u+9iY5nMd33OW8ENk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMbIk3xwb46PEf7rFXSA4tqNucMCEihup7TB9TCM8vjhXz5wXgEouGjaHCScZIdiw
         Wu0F0goeHg1la6UWO8Ib0us5f8hNFKkCAusSoeSA0BTFbWSt+X2xD6PhLvyFBIuwcZ
         7htXNPgD7V2BX46b+G1mh6aa9wUHosZqLfS7YBgYpJRKwITVgESEOQA3hUZY0F3Hqy
         IpxbMCZKcEMh4SZHNXg2sdL53UXiZCmjitvYdU+3zxOAGJA3IwlWU8C43RRu13SYKo
         GyEv4NbrR6hRYijBEzttAvl0Et5rpcIz0aet0AvclrPd37EMmLT6mvCWWjKjwTMXIw
         CVD+JtqF7bzcw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 16/24] btrfs/inode: allow idmapped BTRFS_IOC_{SNAP,SUBVOL}_CREATE{_V2} ioctl
Date:   Tue, 13 Jul 2021 13:13:36 +0200
Message-Id: <20210713111344.1149376-17-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8137; h=from:subject; bh=9gp6kXRMxPi3RUK2iOaJ0WQKRxt8MHD9PRxqAG6s7/8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY2e7xr0fFHARCtB3buPVAXFbXJ+hd5V/b/3WbThjVhR F7vUjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInwlTIyfKtgMTVauKWgYmr+zkTVP0 lmBWn93xrK70x5y+WY1nRahZGh+ZLSnY5HPzfbbvJdLnxa5fbyVMVP8tPij+Q2VHEnHFBgAAA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Creating subvolumes and snapshots is one of the core features of btrfs and is
even available to unprivileged users. Make it possible to use subvolume and
snapshot creation on idmapped mounts. This is a fairly straightforward
operation since all the permission checking helpers are already capable of
handling idmapped mounts. So we just need to pass down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/ctree.h |  3 ++-
 fs/btrfs/inode.c |  5 +++--
 fs/btrfs/ioctl.c | 47 +++++++++++++++++++++++++++--------------------
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e5e53e592d4f..ee1876571b3f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3145,7 +3145,8 @@ int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      struct extent_state **cached_state);
 int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *new_root,
-			     struct btrfs_root *parent_root);
+			     struct btrfs_root *parent_root,
+			     struct user_namespace *mnt_userns);
  void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 			       unsigned *bits);
 void btrfs_clear_delalloc_extent(struct inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b537d90172e..7cfa1c5a1534 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8851,7 +8851,8 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
  */
 int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *new_root,
-			     struct btrfs_root *parent_root)
+			     struct btrfs_root *parent_root,
+			     struct user_namespace *mnt_userns)
 {
 	struct inode *inode;
 	int err;
@@ -8862,7 +8863,7 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 	if (err < 0)
 		return err;
 
-	inode = btrfs_new_inode(trans, new_root, &init_user_ns, NULL, "..", 2,
+	inode = btrfs_new_inode(trans, new_root, mnt_userns, NULL, "..", 2,
 				ino, ino,
 				S_IFDIR | (~current_umask() & S_IRWXUGO),
 				&index);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f332de258058..31115083f382 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -492,8 +492,8 @@ int __pure btrfs_is_empty_uuid(u8 *uuid)
 	return 1;
 }
 
-static noinline int create_subvol(struct inode *dir,
-				  struct dentry *dentry,
+static noinline int create_subvol(struct user_namespace *mnt_userns,
+				  struct inode *dir, struct dentry *dentry,
 				  const char *name, int namelen,
 				  struct btrfs_qgroup_inherit *inherit)
 {
@@ -638,7 +638,7 @@ static noinline int create_subvol(struct inode *dir,
 		goto fail;
 	}
 
-	ret = btrfs_create_subvol_root(trans, new_root, root);
+	ret = btrfs_create_subvol_root(trans, new_root, root, mnt_userns);
 	btrfs_put_root(new_root);
 	if (ret) {
 		/* We potentially lose an unused inode item here */
@@ -864,15 +864,16 @@ static int btrfs_may_delete(struct inode *dir, struct dentry *victim, int isdir)
 }
 
 /* copy of may_create in fs/namei.c() */
-static inline int btrfs_may_create(struct inode *dir, struct dentry *child)
+static inline int btrfs_may_create(struct user_namespace *mnt_userns,
+				   struct inode *dir, struct dentry *child)
 {
 	if (d_really_is_positive(child))
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	if (!fsuidgid_has_mapping(dir->i_sb, &init_user_ns))
+	if (!fsuidgid_has_mapping(dir->i_sb, mnt_userns))
 		return -EOVERFLOW;
-	return inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
+	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
 }
 
 /*
@@ -881,6 +882,7 @@ static inline int btrfs_may_create(struct inode *dir, struct dentry *child)
  * inside this filesystem so it's quite a bit simpler.
  */
 static noinline int btrfs_mksubvol(const struct path *parent,
+				   struct user_namespace *mnt_userns,
 				   const char *name, int namelen,
 				   struct btrfs_root *snap_src,
 				   bool readonly,
@@ -895,12 +897,12 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	if (error == -EINTR)
 		return error;
 
-	dentry = lookup_one_len(&init_user_ns, name, parent->dentry, namelen);
+	dentry = lookup_one_len(mnt_userns, name, parent->dentry, namelen);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_unlock;
 
-	error = btrfs_may_create(dir, dentry);
+	error = btrfs_may_create(mnt_userns, dir, dentry);
 	if (error)
 		goto out_dput;
 
@@ -922,7 +924,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	if (snap_src)
 		error = create_snapshot(snap_src, dir, dentry, readonly, inherit);
 	else
-		error = create_subvol(dir, dentry, name, namelen, inherit);
+		error = create_subvol(mnt_userns, dir, dentry, name, namelen, inherit);
 
 	if (!error)
 		fsnotify_mkdir(dir, dentry);
@@ -936,6 +938,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 }
 
 static noinline int btrfs_mksnapshot(const struct path *parent,
+				   struct user_namespace *mnt_userns,
 				   const char *name, int namelen,
 				   struct btrfs_root *root,
 				   bool readonly,
@@ -965,7 +968,7 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 
 	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
 
-	ret = btrfs_mksubvol(parent, name, namelen,
+	ret = btrfs_mksubvol(parent, mnt_userns, name, namelen,
 			     root, readonly, inherit);
 out:
 	if (snapshot_force_cow)
@@ -1794,6 +1797,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 }
 
 static noinline int __btrfs_ioctl_snap_create(struct file *file,
+				struct user_namespace *mnt_userns,
 				const char *name, unsigned long fd, int subvol,
 				bool readonly,
 				struct btrfs_qgroup_inherit *inherit)
@@ -1821,8 +1825,8 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 	}
 
 	if (subvol) {
-		ret = btrfs_mksubvol(&file->f_path, name, namelen,
-				     NULL, readonly, inherit);
+		ret = btrfs_mksubvol(&file->f_path, mnt_userns, name,
+				     namelen, NULL, readonly, inherit);
 	} else {
 		struct fd src = fdget(fd);
 		struct inode *src_inode;
@@ -1836,16 +1840,17 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 			btrfs_info(BTRFS_I(file_inode(file))->root->fs_info,
 				   "Snapshot src from another FS");
 			ret = -EXDEV;
-		} else if (!inode_owner_or_capable(&init_user_ns, src_inode)) {
+		} else if (!inode_owner_or_capable(mnt_userns, src_inode)) {
 			/*
 			 * Subvolume creation is not restricted, but snapshots
 			 * are limited to own subvolumes only
 			 */
 			ret = -EPERM;
 		} else {
-			ret = btrfs_mksnapshot(&file->f_path, name, namelen,
-					     BTRFS_I(src_inode)->root,
-					     readonly, inherit);
+			ret = btrfs_mksnapshot(&file->f_path, mnt_userns,
+					       name, namelen,
+					       BTRFS_I(src_inode)->root,
+					       readonly, inherit);
 		}
 		fdput(src);
 	}
@@ -1869,8 +1874,9 @@ static noinline int btrfs_ioctl_snap_create(struct file *file,
 		return PTR_ERR(vol_args);
 	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
 
-	ret = __btrfs_ioctl_snap_create(file, vol_args->name, vol_args->fd,
-					subvol, false, NULL);
+	ret = __btrfs_ioctl_snap_create(file, file_mnt_user_ns(file),
+					vol_args->name, vol_args->fd, subvol,
+					false, NULL);
 
 	kfree(vol_args);
 	return ret;
@@ -1928,8 +1934,9 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 		}
 	}
 
-	ret = __btrfs_ioctl_snap_create(file, vol_args->name, vol_args->fd,
-					subvol, readonly, inherit);
+	ret = __btrfs_ioctl_snap_create(file, file_mnt_user_ns(file),
+					vol_args->name, vol_args->fd, subvol,
+					readonly, inherit);
 	if (ret)
 		goto free_inherit;
 free_inherit:
-- 
2.30.2

