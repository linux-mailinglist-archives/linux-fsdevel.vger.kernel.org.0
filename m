Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2199966960A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjAMLxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241499AbjAMLwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E53111C
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:49:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E84C0B82121
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E13FC433F1;
        Fri, 13 Jan 2023 11:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610595;
        bh=BOvo/WxXug3mtLRpWMkx08GVzqYASSCu6L0jGsnL7gw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TJoim7Q6hb0VezDsANxlvwmpv6HR07Dp2rj0x5woXSKlQ9S4S9IXVUJuqpyOqvO8U
         7h50wdFyK9L+Y5932zS9Rb46swKovojUtLw0EGpUgwm6oJQEs62xCtvSUkKRygHRml
         KHdqOC4SD15kagWhXy4bpfP3J8bbcTqLm0uf5oNy0iHNmt8wX17WI0GYjIvaGjhfbD
         JbmhbIWpkd+9NCbDQf7NIDwkewMivs3+9uMarhPBkCtlfInv3f34CbL/q/EhpgzAQW
         RIFGuPaZyNe39xTceBLzyrV9e0rOYq99wg+RENUIxAvun4vbWDCbLU8hWGjtuIW6Zc
         PFjQoQ7p7RUmw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:16 +0100
Subject: [PATCH 08/25] fs: port ->mknod() to pass mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-8-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=32186; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BOvo/WxXug3mtLRpWMkx08GVzqYASSCu6L0jGsnL7gw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA1SkredtOhGJcd0kZMvEnunmUncF7N48+uHb2r3tebW
 okqWjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkUzGFkWMfkfZSD41akqKLOZc4Nmn
 eFuuvufnzwp/KS2CGNhs+b7jEy/DLxUNKctOCLzb5qCU7ntYdffFptrnagY8PVDw0CsWedmQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to struct mnt_idmap.

Last cycle we merged the necessary infrastructure in
256c8aed2b42 ("fs: introduce dedicated idmap type for mounts").
This is just the conversion to struct mnt_idmap.

Currently we still pass around the plain namespace that was attached to a
mount. This is in general pretty convenient but it makes it easy to
conflate namespaces that are relevant on the filesystem with namespaces
that are relevent on the mount level. Especially for non-vfs developers
without detailed knowledge in this area this can be a potential source for
bugs.

Once the conversion to struct mnt_idmap is done all helpers down to the
really low-level helpers will take a struct mnt_idmap argument instead of
two namespace arguments. This way it becomes impossible to conflate the two
eliminating the possibility of any bugs. All of the vfs and all filesystems
only operate on struct mnt_idmap.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 Documentation/filesystems/locking.rst | 2 +-
 Documentation/filesystems/vfs.rst     | 2 +-
 fs/9p/vfs_inode.c                     | 4 ++--
 fs/9p/vfs_inode_dotl.c                | 9 ++++-----
 fs/bad_inode.c                        | 2 +-
 fs/btrfs/inode.c                      | 3 ++-
 fs/ceph/dir.c                         | 5 ++---
 fs/cifs/cifsfs.h                      | 2 +-
 fs/cifs/dir.c                         | 2 +-
 fs/ecryptfs/inode.c                   | 2 +-
 fs/ext2/namei.c                       | 2 +-
 fs/ext4/namei.c                       | 3 ++-
 fs/f2fs/namei.c                       | 3 ++-
 fs/fuse/dir.c                         | 8 ++++----
 fs/gfs2/inode.c                       | 4 ++--
 fs/hfsplus/dir.c                      | 6 +++---
 fs/hostfs/hostfs_kern.c               | 2 +-
 fs/hpfs/namei.c                       | 2 +-
 fs/hugetlbfs/inode.c                  | 6 +++---
 fs/jffs2/dir.c                        | 4 ++--
 fs/jfs/namei.c                        | 2 +-
 fs/minix/namei.c                      | 4 ++--
 fs/namei.c                            | 2 +-
 fs/nfs/dir.c                          | 2 +-
 fs/nfs/internal.h                     | 2 +-
 fs/nilfs2/namei.c                     | 2 +-
 fs/ntfs3/namei.c                      | 3 ++-
 fs/ocfs2/namei.c                      | 6 +++---
 fs/overlayfs/dir.c                    | 2 +-
 fs/ramfs/inode.c                      | 6 +++---
 fs/reiserfs/namei.c                   | 2 +-
 fs/sysv/namei.c                       | 4 ++--
 fs/ubifs/dir.c                        | 2 +-
 fs/udf/namei.c                        | 2 +-
 fs/ufs/namei.c                        | 2 +-
 fs/xfs/xfs_iops.c                     | 5 +++--
 include/linux/fs.h                    | 2 +-
 mm/shmem.c                            | 8 ++++----
 38 files changed, 67 insertions(+), 64 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index ac7871ff1e3c..9605928c11b5 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -63,7 +63,7 @@ prototypes::
 	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
 	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
 	int (*rmdir) (struct inode *,struct dentry *);
-	int (*mknod) (struct inode *,struct dentry *,umode_t,dev_t);
+	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t);
 	int (*rename) (struct inode *, struct dentry *,
 			struct inode *, struct dentry *, unsigned int);
 	int (*readlink) (struct dentry *, char __user *,int);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index daf9593b3754..e2cb36f15ce4 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -428,7 +428,7 @@ As of kernel 2.6.22, the following members are defined:
 		int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
 		int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
 		int (*rmdir) (struct inode *,struct dentry *);
-		int (*mknod) (struct user_namespace *, struct inode *,struct dentry *,umode_t,dev_t);
+		int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t);
 		int (*rename) (struct user_namespace *, struct inode *, struct dentry *,
 			       struct inode *, struct dentry *, unsigned int);
 		int (*readlink) (struct dentry *, char __user *,int);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index ba9e68bd3589..1a21b001f377 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1356,7 +1356,7 @@ v9fs_vfs_link(struct dentry *old_dentry, struct inode *dir,
 
 /**
  * v9fs_vfs_mknod - create a special file
- * @mnt_userns: The user namespace of the mount
+ * @idmap: idmap of the mount
  * @dir: inode destination for new link
  * @dentry: dentry for file
  * @mode: mode for creation
@@ -1365,7 +1365,7 @@ v9fs_vfs_link(struct dentry *old_dentry, struct inode *dir,
  */
 
 static int
-v9fs_vfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+v9fs_vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 63389ba14806..3bed3eb3a0e2 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -30,7 +30,7 @@
 #include "acl.h"
 
 static int
-v9fs_vfs_mknod_dotl(struct user_namespace *mnt_userns, struct inode *dir,
+v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 		    struct dentry *dentry, umode_t omode, dev_t rdev);
 
 /**
@@ -222,8 +222,7 @@ static int
 v9fs_vfs_create_dotl(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, umode_t omode, bool excl)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-	return v9fs_vfs_mknod_dotl(mnt_userns, dir, dentry, omode, 0);
+	return v9fs_vfs_mknod_dotl(idmap, dir, dentry, omode, 0);
 }
 
 static int
@@ -818,7 +817,7 @@ v9fs_vfs_link_dotl(struct dentry *old_dentry, struct inode *dir,
 
 /**
  * v9fs_vfs_mknod_dotl - create a special file
- * @mnt_userns: The user namespace of the mount
+ * @idmap: The idmap of the mount
  * @dir: inode destination for new link
  * @dentry: dentry for file
  * @omode: mode for creation
@@ -826,7 +825,7 @@ v9fs_vfs_link_dotl(struct dentry *old_dentry, struct inode *dir,
  *
  */
 static int
-v9fs_vfs_mknod_dotl(struct user_namespace *mnt_userns, struct inode *dir,
+v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 		    struct dentry *dentry, umode_t omode, dev_t rdev)
 {
 	int err;
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 6b6d20a41b60..d1b075b4dce8 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -69,7 +69,7 @@ static int bad_inode_rmdir (struct inode *dir, struct dentry *dentry)
 	return -EIO;
 }
 
-static int bad_inode_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int bad_inode_mknod(struct mnt_idmap *idmap, struct inode *dir,
 			   struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	return -EIO;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d0a965cfeda4..438b5142be44 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6725,9 +6725,10 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int btrfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode;
 
 	inode = new_inode(dir->i_sb);
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index af9ef4ba8d27..7ad56d5a63b3 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -845,7 +845,7 @@ int ceph_handle_notrace_create(struct inode *dir, struct dentry *dentry)
 	return PTR_ERR(result);
 }
 
-static int ceph_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
@@ -908,8 +908,7 @@ static int ceph_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 static int ceph_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-	return ceph_mknod(mnt_userns, dir, dentry, mode, 0);
+	return ceph_mknod(idmap, dir, dentry, mode, 0);
 }
 
 static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index ab729c6007e8..14bb46ab0874 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -57,7 +57,7 @@ extern struct dentry *cifs_lookup(struct inode *, struct dentry *,
 				  unsigned int);
 extern int cifs_unlink(struct inode *dir, struct dentry *dentry);
 extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry *);
-extern int cifs_mknod(struct user_namespace *, struct inode *, struct dentry *,
+extern int cifs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
 extern int cifs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
 		      umode_t);
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index bc78af260fc9..2b6076324ffc 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -579,7 +579,7 @@ int cifs_create(struct mnt_idmap *idmap, struct inode *inode,
 	return rc;
 }
 
-int cifs_mknod(struct user_namespace *mnt_userns, struct inode *inode,
+int cifs_mknod(struct mnt_idmap *idmap, struct inode *inode,
 	       struct dentry *direntry, umode_t mode, dev_t device_number)
 {
 	int rc = -EPERM;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 6f9da8d138dc..6a2052d234b2 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -548,7 +548,7 @@ static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 }
 
 static int
-ecryptfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	int rc;
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 179a6a7b4845..91219a6a5739 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -133,7 +133,7 @@ static int ext2_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	return finish_open_simple(file, 0);
 }
 
-static int ext2_mknod (struct user_namespace * mnt_userns, struct inode * dir,
+static int ext2_mknod (struct mnt_idmap * idmap, struct inode * dir,
 	struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct inode * inode;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e5c54c30696e..0aa190e03b86 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2828,9 +2828,10 @@ static int ext4_create(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-static int ext4_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int ext4_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	handle_t *handle;
 	struct inode *inode;
 	int err, credits, retries = 0;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 0ed2909696e2..39f76a1d8b90 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -797,9 +797,10 @@ static int f2fs_rmdir(struct inode *dir, struct dentry *dentry)
 	return -ENOTEMPTY;
 }
 
-static int f2fs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int f2fs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
 	int err = 0;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d007e504f4c6..f6aa799fb584 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -645,7 +645,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return err;
 }
 
-static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
+static int fuse_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
 static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned flags,
@@ -686,7 +686,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	return err;
 
 mknod:
-	err = fuse_mknod(&init_user_ns, dir, entry, mode, 0);
+	err = fuse_mknod(&nop_mnt_idmap, dir, entry, mode, 0);
 	if (err)
 		goto out_dput;
 no_open:
@@ -773,7 +773,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	return err;
 }
 
-static int fuse_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *entry, umode_t mode, dev_t rdev)
 {
 	struct fuse_mknod_in inarg;
@@ -799,7 +799,7 @@ static int fuse_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *entry, umode_t mode, bool excl)
 {
-	return fuse_mknod(&init_user_ns, dir, entry, mode, 0);
+	return fuse_mknod(&nop_mnt_idmap, dir, entry, mode, 0);
 }
 
 static int fuse_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index bb06eabd2fc3..ed015ab66287 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1246,7 +1246,7 @@ static int gfs2_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 /**
  * gfs2_mknod - Make a special file
- * @mnt_userns: User namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @dir: The directory in which the special file will reside
  * @dentry: The dentry of the special file
  * @mode: The mode of the special file
@@ -1254,7 +1254,7 @@ static int gfs2_mkdir(struct mnt_idmap *idmap, struct inode *dir,
  *
  */
 
-static int gfs2_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int gfs2_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	return gfs2_create_inode(dir, dentry, NULL, mode, dev, NULL, 0, 0);
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 9a953bb62eac..19caa2d953a7 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -476,7 +476,7 @@ static int hfsplus_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	return res;
 }
 
-static int hfsplus_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int hfsplus_mknod(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(dir->i_sb);
@@ -520,13 +520,13 @@ static int hfsplus_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 static int hfsplus_create(struct mnt_idmap *idmap, struct inode *dir,
 			  struct dentry *dentry, umode_t mode, bool excl)
 {
-	return hfsplus_mknod(&init_user_ns, dir, dentry, mode, 0);
+	return hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
 }
 
 static int hfsplus_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode)
 {
-	return hfsplus_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
+	return hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
 }
 
 static int hfsplus_rename(struct user_namespace *mnt_userns,
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index f9369099125e..b7f512d2c669 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -696,7 +696,7 @@ static int hostfs_rmdir(struct inode *ino, struct dentry *dentry)
 	return err;
 }
 
-static int hostfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int hostfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	struct inode *inode;
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index b44bc14e735b..8415137a064d 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -217,7 +217,7 @@ static int hpfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-static int hpfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int hpfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	const unsigned char *name = dentry->d_name.name;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0f16a509c3d8..b37e29dc125d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1019,7 +1019,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 /*
  * File creation. Allocate an inode, and we're done..
  */
-static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int hugetlbfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 			   struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	struct inode *inode;
@@ -1036,7 +1036,7 @@ static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 static int hugetlbfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			   struct dentry *dentry, umode_t mode)
 {
-	int retval = hugetlbfs_mknod(&init_user_ns, dir, dentry,
+	int retval = hugetlbfs_mknod(&nop_mnt_idmap, dir, dentry,
 				     mode | S_IFDIR, 0);
 	if (!retval)
 		inc_nlink(dir);
@@ -1047,7 +1047,7 @@ static int hugetlbfs_create(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *dentry,
 			    umode_t mode, bool excl)
 {
-	return hugetlbfs_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
+	return hugetlbfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFREG, 0);
 }
 
 static int hugetlbfs_tmpfile(struct user_namespace *mnt_userns,
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 9158d8e1b762..9e1110de6f0b 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -35,7 +35,7 @@ static int jffs2_symlink (struct mnt_idmap *, struct inode *,
 static int jffs2_mkdir (struct mnt_idmap *, struct inode *,struct dentry *,
 			umode_t);
 static int jffs2_rmdir (struct inode *,struct dentry *);
-static int jffs2_mknod (struct user_namespace *, struct inode *,struct dentry *,
+static int jffs2_mknod (struct mnt_idmap *, struct inode *,struct dentry *,
 			umode_t,dev_t);
 static int jffs2_rename (struct user_namespace *, struct inode *,
 			 struct dentry *, struct inode *, struct dentry *,
@@ -614,7 +614,7 @@ static int jffs2_rmdir (struct inode *dir_i, struct dentry *dentry)
 	return ret;
 }
 
-static int jffs2_mknod (struct user_namespace *mnt_userns, struct inode *dir_i,
+static int jffs2_mknod (struct mnt_idmap *idmap, struct inode *dir_i,
 		        struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct jffs2_inode_info *f, *dir_f;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 588dbd757293..917c1237cf93 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1345,7 +1345,7 @@ static int jfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
  *
  * FUNCTION:	Create a special file (device)
  */
-static int jfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int jfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct jfs_inode_info *jfs_ip;
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index bd5dcd528b9a..b6b4b0a1608e 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -33,7 +33,7 @@ static struct dentry *minix_lookup(struct inode * dir, struct dentry *dentry, un
 	return d_splice_alias(inode, dentry);
 }
 
-static int minix_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int minix_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	int error;
@@ -68,7 +68,7 @@ static int minix_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 static int minix_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
-	return minix_mknod(&init_user_ns, dir, dentry, mode, 0);
+	return minix_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
 }
 
 static int minix_symlink(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/fs/namei.c b/fs/namei.c
index 7b543c523350..74c194c0ceab 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3919,7 +3919,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	error = dir->i_op->mknod(mnt_userns, dir, dentry, mode, dev);
+	error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 91ad69a1776e..19b4926b93cb 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2325,7 +2325,7 @@ EXPORT_SYMBOL_GPL(nfs_create);
  * See comments for nfs_proc_create regarding failed operations.
  */
 int
-nfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+nfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	  struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct iattr attr;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 93a97af3638a..d6df06d61f28 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -393,7 +393,7 @@ int nfs_unlink(struct inode *, struct dentry *);
 int nfs_symlink(struct mnt_idmap *, struct inode *, struct dentry *,
 		const char *);
 int nfs_link(struct dentry *, struct inode *, struct dentry *);
-int nfs_mknod(struct user_namespace *, struct inode *, struct dentry *, umode_t,
+int nfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *, umode_t,
 	      dev_t);
 int nfs_rename(struct user_namespace *, struct inode *, struct dentry *,
 	       struct inode *, struct dentry *, unsigned int);
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index e0ef6ff0f35c..9cc52d8fa022 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -100,7 +100,7 @@ static int nilfs_create(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static int
-nilfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+nilfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	    struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct inode *inode;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index f40ac46fa1d1..3cd1a18c6c02 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -111,9 +111,10 @@ static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
  *
  * inode_operations::mknod
  */
-static int ntfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int ntfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode;
 
 	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, mode, rdev,
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index e1db6da2f70b..e588009cb04e 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -221,7 +221,7 @@ static void ocfs2_cleanup_add_entry_failure(struct ocfs2_super *osb,
 	iput(inode);
 }
 
-static int ocfs2_mknod(struct user_namespace *mnt_userns,
+static int ocfs2_mknod(struct mnt_idmap *idmap,
 		       struct inode *dir,
 		       struct dentry *dentry,
 		       umode_t mode,
@@ -651,7 +651,7 @@ static int ocfs2_mkdir(struct mnt_idmap *idmap,
 
 	trace_ocfs2_mkdir(dir, dentry, dentry->d_name.len, dentry->d_name.name,
 			  OCFS2_I(dir)->ip_blkno, mode);
-	ret = ocfs2_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
+	ret = ocfs2_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
 	if (ret)
 		mlog_errno(ret);
 
@@ -668,7 +668,7 @@ static int ocfs2_create(struct mnt_idmap *idmap,
 
 	trace_ocfs2_create(dir, dentry, dentry->d_name.len, dentry->d_name.name,
 			   (unsigned long long)OCFS2_I(dir)->ip_blkno, mode);
-	ret = ocfs2_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
+	ret = ocfs2_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFREG, 0);
 	if (ret)
 		mlog_errno(ret);
 
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index abdaa12e833d..ff18a6a16b01 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -667,7 +667,7 @@ static int ovl_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	return ovl_create_object(dentry, (mode & 07777) | S_IFDIR, 0, NULL);
 }
 
-static int ovl_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int ovl_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	/* Don't allow creation of "whiteout" on overlay */
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 1f0e9c8581cd..2ca68aa81895 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -95,7 +95,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
  */
 /* SMP-safe */
 static int
-ramfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	    struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	struct inode * inode = ramfs_get_inode(dir->i_sb, dir, mode, dev);
@@ -113,7 +113,7 @@ ramfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 static int ramfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
-	int retval = ramfs_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
+	int retval = ramfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
 	if (!retval)
 		inc_nlink(dir);
 	return retval;
@@ -122,7 +122,7 @@ static int ramfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 static int ramfs_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
-	return ramfs_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
+	return ramfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFREG, 0);
 }
 
 static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 149b3c9af275..4c3da7ccca34 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -700,7 +700,7 @@ static int reiserfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	return retval;
 }
 
-static int reiserfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int reiserfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 			  struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	int retval;
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index 982caf4dec67..e44c5f5f5b0c 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -41,7 +41,7 @@ static struct dentry *sysv_lookup(struct inode * dir, struct dentry * dentry, un
 	return d_splice_alias(inode, dentry);
 }
 
-static int sysv_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int sysv_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct inode * inode;
@@ -64,7 +64,7 @@ static int sysv_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 static int sysv_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
-	return sysv_mknod(&init_user_ns, dir, dentry, mode, 0);
+	return sysv_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
 }
 
 static int sysv_symlink(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 042ddfbc1d82..9f521a8edebf 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1052,7 +1052,7 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-static int ubifs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct inode *inode;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 9a360f286d1c..7ecfeaad41b1 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -645,7 +645,7 @@ static int udf_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	return finish_open_simple(file, 0);
 }
 
-static int udf_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int udf_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct inode *inode;
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 5d6b05269cf4..85afc26d559d 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -86,7 +86,7 @@ static int ufs_create (struct mnt_idmap * idmap,
 	return ufs_add_nondir(dentry, inode);
 }
 
-static int ufs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+static int ufs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct inode *inode;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index df3d7f6dbd7d..249b0d8fcd84 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -255,13 +255,14 @@ xfs_generic_create(
 
 STATIC int
 xfs_vn_mknod(
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct inode		*dir,
 	struct dentry		*dentry,
 	umode_t			mode,
 	dev_t			rdev)
 {
-	return xfs_generic_create(mnt_userns, dir, dentry, mode, rdev, NULL);
+	return xfs_generic_create(mnt_idmap_owner(idmap), dir, dentry, mode,
+				  rdev, NULL);
 }
 
 STATIC int
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f6b1f0ca261a..a28117398e71 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2148,7 +2148,7 @@ struct inode_operations {
 	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,
 		      umode_t);
 	int (*rmdir) (struct inode *,struct dentry *);
-	int (*mknod) (struct user_namespace *, struct inode *,struct dentry *,
+	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,
 		      umode_t,dev_t);
 	int (*rename) (struct user_namespace *, struct inode *, struct dentry *,
 			struct inode *, struct dentry *, unsigned int);
diff --git a/mm/shmem.c b/mm/shmem.c
index 998e5873f029..d66f75c5e85e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2915,7 +2915,7 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
  * File creation. Allocate an inode, and we're done..
  */
 static int
-shmem_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	    struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	struct inode *inode;
@@ -2975,7 +2975,7 @@ static int shmem_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 {
 	int error;
 
-	if ((error = shmem_mknod(&init_user_ns, dir, dentry,
+	if ((error = shmem_mknod(&nop_mnt_idmap, dir, dentry,
 				 mode | S_IFDIR, 0)))
 		return error;
 	inc_nlink(dir);
@@ -2985,7 +2985,7 @@ static int shmem_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 static int shmem_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
-	return shmem_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
+	return shmem_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFREG, 0);
 }
 
 /*
@@ -3055,7 +3055,7 @@ static int shmem_whiteout(struct user_namespace *mnt_userns,
 	if (!whiteout)
 		return -ENOMEM;
 
-	error = shmem_mknod(&init_user_ns, old_dir, whiteout,
+	error = shmem_mknod(&nop_mnt_idmap, old_dir, whiteout,
 			    S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 	dput(whiteout);
 	if (error)

-- 
2.34.1

