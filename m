Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF52468083B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 10:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjA3JLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 04:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjA3JLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:11:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C0E3581;
        Mon, 30 Jan 2023 01:11:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7389AB80C7B;
        Mon, 30 Jan 2023 09:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE19C4339B;
        Mon, 30 Jan 2023 09:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675069858;
        bh=us2Yn0eMjzDWeQ9PD2z9H6x85tUf7Rf2EnNCXsrO7/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CO5BuZPgPXUHnaoI044p8ubQzYcMONDeLcUNG0kmIENFcOwqtdbraWEq0Cymrzg8l
         NGQ/t7OXF15R0IJOz5Po5kabgvGyVESMg/1q7/1JiYaxBD5XGtYqO6ACgJS2cnG1fQ
         voDi3fs4VrgZPm5ULAg+TecZSSlMwF70gpiZHX986mVy9MEOalZrdu4A6sB8MRnetS
         wn7us0PXRYIBwIf3du2ofySEBR2DeQBMY0HvffHpuVQcYFzVdEJVI775eKutaCY4Nh
         rYo9R8jtZUOZ5OIT/w/pa+PnSxSD3HcBjrgJvaGYIorWPtqHUt/XYh4Qr9cQdgsBb7
         QBVDilvBCDJDw==
Date:   Mon, 30 Jan 2023 10:10:52 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-erofs@lists.ozlabs.org, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 00/12] acl: remove remaining posix acl handlers
Message-ID: <20230130091052.72zglqecqvom7hin@wittgenstein>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:28:45PM +0100, Christian Brauner wrote:
> Hey everyone,
> 
> after we finished the introduction of the new posix acl api last cycle
> we still left the generic POSIX ACL xattr handler around for two
> reasons. First, because a few filesystems relied on the ->list() method
> of the generic POSIX ACL xattr handlers in their ->listxattr() inode
> operation. Second, during inode initalization in inode_init_always() the
> registered xattr handlers in sb->s_xattr are used to raise IOP_XATTR in
> inode->i_opflags.
> 
> With the removal of the legacy POSIX ACL handlers it is at least
> possible for a filesystem to only implement POSIX ACLs but no other
> xattrs. If that were to happen we would miss to raise IOP_XATTR because
> sb->s_xattr would be NULL.
> 
> Fix these things and then get rid of the misleading and effectively
> already unused generic POSIX ACL handlers.
> 
> For most filesystems it is a trivial removal of the generic POSIX ACL
> handlers. Only for erofs, ext2, ext4, f2fs, jffs2, reiserfs, oc2fs the
> handler is used but rather easy to fix.
> 
> All filesystems with reasonable integration into xfstests have been
> tested with:
> 
>         ./check -g acl,attr,cap,idmapped,io_uring,perms,unlink
> 
> All tests pass without regression on xfstests for-next branch.
> 
> Since erofs doesn't have integration into xfstests yet afaict I have
> tested it with the testuite available in erofs-utils. They also all pass
> without any regressions.
> 
> This branch depends on [1] which hopefully should be merged soon and can
> be pulled from [2] which already includes [1] so it's easy to test and
> compile.
> 
> With this all remnants of the old POSIX ACL xattr handling will be gone.
> 
> Thanks!
> Christian
> 
> [1]: https://lore.kernel.org/lkml/20230125100040.374709-1-brauner@kernel.org
> [2]: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.acl.remove.generic.xattr.handlers.v1
> 
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
> Christian Brauner (12):
>       xattr: simplify listxattr helpers
>       xattr, posix acl: add listxattr helpers
>       xattr: remove unused argument
>       fs: drop unused posix acl handlers
>       erofs: drop posix acl handlers
>       ext2: drop posix acl handlers
>       ext4: drop posix acl handlers
>       f2fs: drop posix acl handlers
>       jffs2: drop posix acl handlers
>       ocfs2: drop posix acl handlers
>       reiserfs: drop posix acl handlers
>       acl: remove posix acl handlers

I just realized that b4 dropped a patch when I created a series to
track. So this is missing an important bit. Christoph, Al, the
SB_I_XATTR bit is the best thing that I came up with so far. It works
well enough and I find the handler based logic weird anyway. But I'm
open to other ideas.

From e661c29b999f3d5d6293046ea1fe9e7d40cfa453 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jan 2023 10:00:00 +0100
Subject: [PATCH 01/14] fs: add SB_I_XATTR

Last cycle we introduced a dedicated POSIX ACLs api which only relies on
the associated inode operations. It does not depend on the xattr handler
infrastructure anymore.

However, a few filesystems still rely on the ->list() method of the
generix POSIX ACL xattr handlers in their ->listxattr() inode operation.
This is a very limited set of filesystems. For most of them there is no
dependence on the generic POSIX ACL xattr handler in any way.

In addition, during inode initalization in inode_init_always() the
registered xattr handlers in sb->s_xattr are used to raise IOP_XATTR in
inode->i_opflags.

With the incoming removal of the legacy POSIX ACL handlers it is at
least possible for a filesystem to only implement POSIX ACLs but no
other xattrs. If that were to happen we would miss to raise IOP_XATTR
because sb->s_xattr would be NULL. While there currently is no such
filesystem we should still make sure that this just works should it ever
happen in the future.

We could try and use raise IOP_XATTR if we detect that the filesystems
implements the associated inode operations. But this doesn't work at the
time inode_init_always() is called because the inode->i_op field is not
yet initialized with the correct filesystem inode operations.

We could of course make the filesystems responsible for raising IOP_XATR
but this is messy as quite a few filesystems initialize inode->i_op in
multiple locations meaning we would have to scatter the checks to raise
IOP_XATTR across the filesystems. This is doable but ugly.

Another possibility would be to just check for SB_POSIXACL in
sb->s_flags and then raise IOP_XATTR. However, this doesn't work as for
some filesystems this flag can be turned on or off. For example, both
btrfs and ext4 support the "acl" and "noacl" mount option to turn
SB_POSIXACL on or off.

So if the filesystem is mounted with "noacl" then we cannot use
SB_POSIXACL as it might not be raised because the filesystem temporarily
disabled POSIX ACLs.

We could try and get rid of IOP_XATTR but it is used in subtle ways to
communicate that a given inode doesn't support xattrs even though the
superblock does in general and is especially prevalent in the lsm world.
This could potentially be solved by having each inode have a separate
xattr handler field instead of the superblock but would bloat each inode
and would be a more substantial change.

The option that chosen here is to introduce SB_I_XATTR which is raised
in sb->s_iflags whenever the superblock supports xattrs. That
encompasses POSIX ACLs and handler based xattrs. The flag will become
even more useful once fscaps have a dedicated inode operation and we're
really not short of flags anyway.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/9p/vfs_super.c    | 2 ++
 fs/afs/super.c       | 4 +++-
 fs/btrfs/super.c     | 1 +
 fs/ceph/super.c      | 1 +
 fs/cifs/cifsfs.c     | 1 +
 fs/ecryptfs/main.c   | 1 +
 fs/erofs/super.c     | 1 +
 fs/ext2/super.c      | 1 +
 fs/ext4/super.c      | 1 +
 fs/f2fs/super.c      | 1 +
 fs/fuse/inode.c      | 4 ++++
 fs/gfs2/ops_fstype.c | 1 +
 fs/hfs/super.c       | 1 +
 fs/hfsplus/super.c   | 1 +
 fs/inode.c           | 2 +-
 fs/jffs2/super.c     | 1 +
 fs/jfs/super.c       | 1 +
 fs/kernfs/mount.c    | 1 +
 fs/libfs.c           | 2 ++
 fs/nfs/super.c       | 3 +++
 fs/ntfs3/super.c     | 1 +
 fs/ocfs2/super.c     | 1 +
 fs/orangefs/super.c  | 1 +
 fs/overlayfs/super.c | 2 +-
 fs/reiserfs/super.c  | 1 +
 fs/squashfs/super.c  | 1 +
 fs/ubifs/super.c     | 1 +
 fs/xfs/xfs_super.c   | 1 +
 include/linux/fs.h   | 2 ++
 mm/shmem.c           | 2 ++
 30 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 266c4693e20c..003191b6ad97 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -93,6 +93,8 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 		sb->s_flags |= SB_POSIXACL;
 #endif
 
+	sb->s_iflags |= SB_I_XATTR;
+
 	return 0;
 }
 
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 95d713074dc8..379e6d7ac827 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -457,8 +457,10 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	sb->s_maxbytes		= MAX_LFS_FILESIZE;
 	sb->s_magic		= AFS_FS_MAGIC;
 	sb->s_op		= &afs_super_ops;
-	if (!as->dyn_root)
+	if (!as->dyn_root) {
 		sb->s_xattr	= afs_xattr_handlers;
+		sb->s_iflags	|= SB_I_XATTR;
+	}
 	ret = super_setup_bdi(sb);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 93f52ee85f6f..9af31008aafa 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1141,6 +1141,7 @@ static int btrfs_fill_super(struct super_block *sb,
 #endif
 	sb->s_flags |= SB_I_VERSION;
 	sb->s_iflags |= SB_I_CGROUPWB;
+	sb->s_iflags |= SB_I_XATTR;
 
 	err = super_setup_bdi(sb);
 	if (err) {
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 3fc48b43cab0..5aeb4fa0c4b0 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1125,6 +1125,7 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 	s->s_flags |= SB_NODIRATIME | SB_NOATIME;
+	s->s_iflags |= SB_I_XATTR;
 
 	ret = set_anon_super_fc(s, fc);
 	if (ret != 0)
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 10e00c624922..6a938b93d75d 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -235,6 +235,7 @@ cifs_read_super(struct super_block *sb)
 	sb->s_magic = CIFS_SUPER_MAGIC;
 	sb->s_op = &cifs_super_ops;
 	sb->s_xattr = cifs_xattr_handlers;
+	sb->s_iflags |= SB_I_XATTR;
 	rc = super_setup_bdi(sb);
 	if (rc)
 		goto out_no_root;
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 2dc927ba067f..4ae69d23bc47 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -521,6 +521,7 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 	sbi = NULL;
 	s->s_op = &ecryptfs_sops;
 	s->s_xattr = ecryptfs_xattr_handlers;
+	s->s_iflags |= SB_I_XATTR;
 	s->s_d_op = &ecryptfs_dops;
 
 	err = "Reading sb failed";
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 481788c24a68..ea349cea9229 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -772,6 +772,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_time_gran = 1;
 	sb->s_xattr = erofs_xattr_handlers;
+	sb->s_iflags |= SB_I_XATTR;
 	sb->s_export_op = &erofs_export_ops;
 
 	if (test_opt(&sbi->opt, POSIX_ACL))
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 69c88facfe90..ee6e0c4978d1 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1171,6 +1171,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op = &ext2_sops;
 	sb->s_export_op = &ext2_export_ops;
 	sb->s_xattr = ext2_xattr_handlers;
+	sb->s_iflags |= SB_I_XATTR;
 
 #ifdef CONFIG_QUOTA
 	sb->dq_op = &dquot_operations;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 260c1b3e3ef2..2706930beed2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5104,6 +5104,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	/* i_version is always enabled now */
 	sb->s_flags |= SB_I_VERSION;
+	sb->s_iflags |= SB_I_XATTR;
 
 	if (ext4_check_feature_compatibility(sb, es, silent))
 		goto failed_mount;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1f812b9ce985..6fff82f0efdf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4217,6 +4217,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 	memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
 	sb->s_iflags |= SB_I_CGROUPWB;
+	sb->s_iflags |= SB_I_XATTR;
 
 	/* init f2fs-specific super block info */
 	sbi->valid_super_block = valid_super_block;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index de9b9ec5ce81..c9952bb9f9d5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1181,6 +1181,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			if ((flags & FUSE_POSIX_ACL)) {
 				fc->default_permissions = 1;
 				fc->posix_acl = 1;
+				fm->sb->s_iflags |= SB_I_XATTR;
 			}
 			if (flags & FUSE_CACHE_SYMLINKS)
 				fc->cache_symlinks = 1;
@@ -1426,6 +1427,7 @@ static void fuse_sb_defaults(struct super_block *sb)
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
+	sb->s_iflags |= SB_I_XATTR;
 }
 
 static int fuse_fill_super_submount(struct super_block *sb,
@@ -1443,6 +1445,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	sb->s_bdi = bdi_get(parent_sb->s_bdi);
 
 	sb->s_xattr = parent_sb->s_xattr;
+	if (sb->s_xattr)
+		sb->s_iflags |= SB_I_XATTR;
 	sb->s_time_gran = parent_sb->s_time_gran;
 	sb->s_blocksize = parent_sb->s_blocksize;
 	sb->s_blocksize_bits = parent_sb->s_blocksize_bits;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c0cf1d2d0ef5..71c4fa1cdc1c 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -506,6 +506,7 @@ static int init_sb(struct gfs2_sbd *sdp, int silent)
 	default:
 		BUG();
 	}
+	sb->s_iflags |= SB_I_XATTR;
 
 	/* Set up the buffer cache and SB for real */
 	if (sdp->sd_sb.sb_bsize < bdev_logical_block_size(sb->s_bdev)) {
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 6764afa98a6f..6220ce2af0d0 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -401,6 +401,7 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
 	sb->s_flags |= SB_NODIRATIME;
+	sb->s_iflags |= SB_I_XATTR;
 	mutex_init(&sbi->bitmap_lock);
 
 	res = hfs_mdb_get(sb);
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 122ed89ebf9f..c5dd14057a78 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -490,6 +490,7 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
 		atomic_set(&sbi->attr_tree_state, HFSPLUS_VALID_ATTR_TREE);
 	}
 	sb->s_xattr = hfsplus_xattr_handlers;
+	sb->s_iflags |= SB_I_XATTR;
 
 	inode = hfsplus_iget(sb, HFSPLUS_ALLOC_CNID);
 	if (IS_ERR(inode)) {
diff --git a/fs/inode.c b/fs/inode.c
index f453eb58fd03..51824bde0b35 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -169,7 +169,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_ino = 0;
 	inode->__i_nlink = 1;
 	inode->i_opflags = 0;
-	if (sb->s_xattr)
+	if (sb->s_iflags & SB_I_XATTR)
 		inode->i_opflags |= IOP_XATTR;
 	i_uid_write(inode, 0);
 	i_gid_write(inode, 0);
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 7ea37f49f1e1..1ae1ee573280 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -285,6 +285,7 @@ static int jffs2_fill_super(struct super_block *sb, struct fs_context *fc)
 #ifdef CONFIG_JFFS2_FS_POSIX_ACL
 	sb->s_flags |= SB_POSIXACL;
 #endif
+	sb->s_iflags |= SB_I_XATTR;
 	return jffs2_do_fill_super(sb, fc);
 }
 
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index d2f82cb7db1b..b78042d3f3c0 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -532,6 +532,7 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op = &jfs_super_operations;
 	sb->s_export_op = &jfs_export_operations;
 	sb->s_xattr = jfs_xattr_handlers;
+	sb->s_iflags |= SB_I_XATTR;
 #ifdef CONFIG_QUOTA
 	sb->dq_op = &dquot_operations;
 	sb->s_qcop = &jfs_quotactl_ops;
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index e08e8d999807..cd3391419692 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -251,6 +251,7 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_magic = kfc->magic;
 	sb->s_op = &kernfs_sops;
 	sb->s_xattr = kernfs_xattr_handlers;
+	sb->s_iflags |= SB_I_XATTR;
 	if (info->root->flags & KERNFS_ROOT_SUPPORT_EXPORTOP)
 		sb->s_export_op = &kernfs_export_ops;
 	sb->s_time_gran = 1;
diff --git a/fs/libfs.c b/fs/libfs.c
index aada4e7c8713..bd219120f248 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -328,6 +328,8 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_magic = ctx->magic;
 	s->s_op = ctx->ops ?: &simple_super_operations;
 	s->s_xattr = ctx->xattr;
+	if (s->s_xattr)
+		s->s_iflags |= SB_I_XATTR;
 	s->s_time_gran = 1;
 	root = new_inode(s);
 	if (!root)
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 05ae23657527..23c746745129 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1077,6 +1077,9 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 		break;
 	}
 
+	if (sb->s_xattr || (sb->s_flags & SB_POSIXACL))
+		sb->s_iflags |= SB_I_XATTR;
+
 	sb->s_magic = NFS_SUPER_MAGIC;
 
 	/* We probably want something more informative here */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index ef4ea3f21905..93e66112fac5 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -950,6 +950,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_export_op = &ntfs_export_ops;
 	sb->s_time_gran = NTFS_TIME_GRAN; // 100 nsec
 	sb->s_xattr = ntfs_xattr_handlers;
+	sb->s_iflags |= SB_I_XATTR;
 	sb->s_d_op = sbi->options->nocase ? &ntfs_dentry_ops : NULL;
 
 	sbi->options->nls = ntfs_load_nls(sbi->options->nls_name);
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 0b0e6a132101..514f5bcc9722 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2020,6 +2020,7 @@ static int ocfs2_initialize_super(struct super_block *sb,
 	sb->dq_op = &ocfs2_quota_operations;
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
 	sb->s_xattr = ocfs2_xattr_handlers;
+	sb->s_iflags |= SB_I_XATTR;
 	sb->s_time_gran = 1;
 	sb->s_flags |= SB_NOATIME;
 	/* this is needed to support O_LARGEFILE */
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 5254256a224d..ec3e2d4ddb92 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -433,6 +433,7 @@ static int orangefs_fill_sb(struct super_block *sb,
 
 	/* Hang the xattr handlers off the superblock */
 	sb->s_xattr = orangefs_xattr_handlers;
+	sb->s_iflags |= SB_I_XATTR;
 	sb->s_magic = ORANGEFS_SUPER_MAGIC;
 	sb->s_op = &orangefs_s_ops;
 	sb->s_d_op = &orangefs_dentry_operations;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 85b891152a2c..1002c8f332b9 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2060,7 +2060,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		ovl_trusted_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
-	sb->s_iflags |= SB_I_SKIP_SYNC;
+	sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_XATTR;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 929acce6e731..1655b384e0b4 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -2041,6 +2041,7 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
 		goto error_unlocked;
 
 	s->s_xattr = reiserfs_xattr_handlers;
+	s->s_iflags |= SB_I_XATTR;
 
 	if (bdev_read_only(s->s_bdev) && !sb_rdonly(s)) {
 		SWARN(silent, s, "clm-7000",
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index e090fae48e68..7ab4fbc1f663 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -338,6 +338,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Handle xattrs */
 	sb->s_xattr = squashfs_xattr_handlers;
+	sb->s_iflags |= SB_I_XATTR;
 	xattr_id_table_start = le64_to_cpu(sblk->xattr_id_table_start);
 	if (xattr_id_table_start == SQUASHFS_INVALID_BLK) {
 		next_table = msblk->bytes_used;
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index d0c9a09988bc..be9e96cf9d5a 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2215,6 +2215,7 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 		sb->s_maxbytes = c->max_inode_sz = MAX_LFS_FILESIZE;
 	sb->s_op = &ubifs_super_operations;
 	sb->s_xattr = ubifs_xattr_handlers;
+	sb->s_iflags |= SB_I_XATTR;
 	fscrypt_set_ops(sb, &ubifs_crypt_operations);
 
 	mutex_lock(&c->umount_mutex);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 0c4b73e9b29d..5a94d3eeab8a 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1461,6 +1461,7 @@ xfs_fs_fill_super(
 
 	sb_min_blocksize(sb, BBSIZE);
 	sb->s_xattr = xfs_xattr_handlers;
+	sb->s_iflags |= SB_I_XATTR;
 	sb->s_export_op = &xfs_export_operations;
 #ifdef CONFIG_XFS_QUOTA
 	sb->s_qcop = &xfs_quotactl_operations;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 066555ad1bf8..700be4b969ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1449,6 +1449,8 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
 #define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 
+#define SB_I_XATTR	0x00001000	/* superblock supports xattrs */
+
 /* Possible states of 'frozen' field */
 enum {
 	SB_UNFROZEN = 0,		/* FS is unfrozen */
diff --git a/mm/shmem.c b/mm/shmem.c
index c301487be5fb..f9604b64624e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3817,6 +3817,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #ifdef CONFIG_TMPFS_POSIX_ACL
 	sb->s_flags |= SB_POSIXACL;
 #endif
+	if (sb->s_xattr || (sb->s_flags & SB_POSIXACL))
+		sb->s_iflags |= SB_I_XATTR;
 	uuid_gen(&sb->s_uuid);
 
 	inode = shmem_get_inode(sb, NULL, S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
-- 
2.34.1

