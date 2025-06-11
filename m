Return-Path: <linux-fsdevel+bounces-51248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E45CCAD4D97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D314C1BC0A6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965AE245031;
	Wed, 11 Jun 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JhiUpr9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0423AB98
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628483; cv=none; b=u6T4R4GRFcuRhZGVeBMk4gal4jVnZIuteCuk8NyPGgPUbWHf3IQX7TjokwUGRsChdwyKVC4JBAuf+UWDSNWaJATOzsi1Vg2wiWSmgv5eFqjdzkBYgV09An/UDYOirJ6fS42BiOggZdoUMNgBSTutN4+7bZrnVsjSweN3zjZMmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628483; c=relaxed/simple;
	bh=iSD9YjsymJVloDmrQ66Mew+MJQaYmIEaZL/1p41TDt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruB9HM47+HGPM6ZA000OcmzLgQ3AckLftTNJiBgnd0IGki8nccfqzu45JjF8KZIcscKikvJfUPR5qDrporXGd2xSTr0c2dySJz0rRS6zvyLs7e3fW/Jzh2lgS8dEjwhKTFGOyNY8+1iA1ryUOicjWMWTi+reIQq4A99kHVLmZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JhiUpr9Z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tiXTSec1+BeFyzqyHSA31oh9F48jO1TbCLchgF18gvw=; b=JhiUpr9ZxK+JdBfFbDQ0wsIU7Y
	h++G5g0Ol+Q3vu1C8zuSTYgOtwk1bDJlSS217eSGSXMCaCZ/0HU5SpFDCORTnuDP7w518xCk/WyIu
	4IbBcnEoOjOQd8tZBJagTX8mO7ejYRml2hoMy/wqoMa1jSMD5P36xCbmwsDxlCQkDrDpyc8aJarwY
	1KiiJNihn+FjTDoJmjH86yqLfCgytHIwgYf9ETLRaaJdL4jqq19qJTehACWYoBSrdUBJazjJd7raa
	fFNUd0tq14UIhZDqgz0yFl54hhtxrRVqq8Lf5aJbrGuyVLg1IWYVnpGeIEQMaclaK9AM4n1rOaD0m
	zTUXVS7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIA-0000000HTwQ-1qZL;
	Wed, 11 Jun 2025 07:54:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 06/21] new helper: set_default_d_op()
Date: Wed, 11 Jun 2025 08:54:22 +0100
Message-ID: <20250611075437.4166635-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... to be used instead of manually assigning to ->s_d_op.
All in-tree filesystem converted (and field itself is renamed,
so any out-of-tree ones in need of conversion will be caught
by compiler).

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst |  7 +++++++
 fs/9p/vfs_super.c                     |  4 ++--
 fs/adfs/super.c                       |  2 +-
 fs/affs/super.c                       |  4 ++--
 fs/afs/super.c                        |  4 ++--
 fs/autofs/inode.c                     |  2 +-
 fs/btrfs/super.c                      |  2 +-
 fs/ceph/super.c                       |  2 +-
 fs/coda/inode.c                       |  2 +-
 fs/configfs/mount.c                   |  2 +-
 fs/dcache.c                           | 10 ++++++++--
 fs/debugfs/inode.c                    |  2 +-
 fs/devpts/inode.c                     |  2 +-
 fs/ecryptfs/main.c                    |  2 +-
 fs/efivarfs/super.c                   |  2 +-
 fs/exfat/super.c                      |  4 ++--
 fs/fat/namei_msdos.c                  |  2 +-
 fs/fat/namei_vfat.c                   |  4 ++--
 fs/fuse/inode.c                       |  4 ++--
 fs/gfs2/ops_fstype.c                  |  2 +-
 fs/hfs/super.c                        |  2 +-
 fs/hfsplus/super.c                    |  2 +-
 fs/hostfs/hostfs_kern.c               |  2 +-
 fs/hpfs/super.c                       |  2 +-
 fs/isofs/inode.c                      |  2 +-
 fs/jfs/super.c                        |  2 +-
 fs/kernfs/mount.c                     |  2 +-
 fs/libfs.c                            | 16 ++++++++--------
 fs/nfs/super.c                        |  2 +-
 fs/ntfs3/super.c                      |  3 ++-
 fs/ocfs2/super.c                      |  2 +-
 fs/orangefs/super.c                   |  2 +-
 fs/overlayfs/super.c                  |  2 +-
 fs/smb/client/cifsfs.c                |  4 ++--
 fs/tracefs/inode.c                    |  2 +-
 fs/vboxsf/super.c                     |  2 +-
 include/linux/dcache.h                |  2 ++
 include/linux/fs.h                    |  2 +-
 mm/shmem.c                            |  2 +-
 net/sunrpc/rpc_pipe.c                 |  2 +-
 40 files changed, 69 insertions(+), 53 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 3616d7161dab..b16139e91942 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1249,3 +1249,10 @@ Using try_lookup_noperm() will require linux/namei.h to be included.
 
 Calling conventions for ->d_automount() have changed; we should *not* grab
 an extra reference to new mount - it should be returned with refcount 1.
+
+---
+
+**mandatory**
+
+If your filesystem sets the default dentry_operations, use set_default_d_op()
+rather than manually setting sb->s_d_op.
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 489db161abc9..5c3dc3efb909 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -135,9 +135,9 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 		goto release_sb;
 
 	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
-		sb->s_d_op = &v9fs_cached_dentry_operations;
+		set_default_d_op(sb, &v9fs_cached_dentry_operations);
 	else
-		sb->s_d_op = &v9fs_dentry_operations;
+		set_default_d_op(sb, &v9fs_dentry_operations);
 
 	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
 	if (IS_ERR(inode)) {
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 017c48a80203..fdccdbbfc213 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -397,7 +397,7 @@ static int adfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (asb->s_ftsuffix)
 		asb->s_namelen += 4;
 
-	sb->s_d_op = &adfs_dentry_operations;
+	set_default_d_op(sb, &adfs_dentry_operations);
 	root = adfs_iget(sb, &root_obj);
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root) {
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 2fa40337776d..44f8aa883100 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -500,9 +500,9 @@ static int affs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return PTR_ERR(root_inode);
 
 	if (affs_test_opt(AFFS_SB(sb)->s_flags, SF_INTL))
-		sb->s_d_op = &affs_intl_dentry_operations;
+		set_default_d_op(sb, &affs_intl_dentry_operations);
 	else
-		sb->s_d_op = &affs_dentry_operations;
+		set_default_d_op(sb, &affs_dentry_operations);
 
 	sb->s_root = d_make_root(root_inode);
 	if (!sb->s_root) {
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 25b306db6992..da407f2d6f0d 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -483,9 +483,9 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 		goto error;
 
 	if (as->dyn_root) {
-		sb->s_d_op = &afs_dynroot_dentry_operations;
+		set_default_d_op(sb, &afs_dynroot_dentry_operations);
 	} else {
-		sb->s_d_op = &afs_fs_dentry_operations;
+		set_default_d_op(sb, &afs_fs_dentry_operations);
 		rcu_assign_pointer(as->volume->sb, sb);
 	}
 
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index ee2edccaef70..f5c16ffba013 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -311,7 +311,7 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;
 	s->s_op = &autofs_sops;
-	s->s_d_op = &autofs_dentry_operations;
+	set_default_d_op(s, &autofs_dentry_operations);
 	s->s_time_gran = 1;
 
 	/*
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a0c65adce1ab..ad75d9f8f404 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -950,7 +950,7 @@ static int btrfs_fill_super(struct super_block *sb,
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_magic = BTRFS_SUPER_MAGIC;
 	sb->s_op = &btrfs_super_ops;
-	sb->s_d_op = &btrfs_dentry_operations;
+	set_default_d_op(sb, &btrfs_dentry_operations);
 	sb->s_export_op = &btrfs_export_ops;
 #ifdef CONFIG_FS_VERITY
 	sb->s_vop = &btrfs_verityops;
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 2b8438d8a324..c3eb651862c5 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1219,7 +1219,7 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	fsc->max_file_size = 1ULL << 40; /* temp value until we get mdsmap */
 
 	s->s_op = &ceph_super_ops;
-	s->s_d_op = &ceph_dentry_ops;
+	set_default_d_op(s, &ceph_dentry_ops);
 	s->s_export_op = &ceph_export_ops;
 
 	s->s_time_gran = 1;
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 6896fce122e1..08450d006016 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -230,7 +230,7 @@ static int coda_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize_bits = 12;
 	sb->s_magic = CODA_SUPER_MAGIC;
 	sb->s_op = &coda_super_operations;
-	sb->s_d_op = &coda_dentry_operations;
+	set_default_d_op(sb, &coda_dentry_operations);
 	sb->s_time_gran = 1;
 	sb->s_time_min = S64_MIN;
 	sb->s_time_max = S64_MAX;
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index c2d820063ec4..20412eaca972 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -92,7 +92,7 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	configfs_root_group.cg_item.ci_dentry = root;
 	root->d_fsdata = &configfs_root;
 	sb->s_root = root;
-	sb->s_d_op = &configfs_dentry_ops; /* the rest get that */
+	set_default_d_op(sb, &configfs_dentry_ops); /* the rest get that */
 	return 0;
 }
 
diff --git a/fs/dcache.c b/fs/dcache.c
index bf550d438e40..2ed875558ccc 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1738,7 +1738,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	INIT_HLIST_HEAD(&dentry->d_children);
 	INIT_HLIST_NODE(&dentry->d_u.d_alias);
 	INIT_HLIST_NODE(&dentry->d_sib);
-	d_set_d_op(dentry, dentry->d_sb->s_d_op);
+	d_set_d_op(dentry, dentry->d_sb->__s_d_op);
 
 	if (dentry->d_op && dentry->d_op->d_init) {
 		err = dentry->d_op->d_init(dentry);
@@ -1821,7 +1821,7 @@ struct dentry *d_alloc_pseudo(struct super_block *sb, const struct qstr *name)
 	struct dentry *dentry = __d_alloc(sb, name);
 	if (likely(dentry)) {
 		dentry->d_flags |= DCACHE_NORCU;
-		if (!sb->s_d_op)
+		if (!dentry->d_op)
 			d_set_d_op(dentry, &anon_ops);
 	}
 	return dentry;
@@ -1867,6 +1867,12 @@ void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
 }
 EXPORT_SYMBOL(d_set_d_op);
 
+void set_default_d_op(struct super_block *s, const struct dentry_operations *ops)
+{
+	s->__s_d_op = ops;
+}
+EXPORT_SYMBOL(set_default_d_op);
+
 static unsigned d_flags_for_inode(struct inode *inode)
 {
 	unsigned add_flags = DCACHE_REGULAR_TYPE;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 30c4944e1862..29c5ec382342 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -273,7 +273,7 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return err;
 
 	sb->s_op = &debugfs_super_operations;
-	sb->s_d_op = &debugfs_dops;
+	set_default_d_op(sb, &debugfs_dops);
 
 	debugfs_apply_options(sb);
 
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 9c20d78e41f6..fd17992ee298 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -381,7 +381,7 @@ static int devpts_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_blocksize_bits = 10;
 	s->s_magic = DEVPTS_SUPER_MAGIC;
 	s->s_op = &devpts_sops;
-	s->s_d_op = &simple_dentry_operations;
+	set_default_d_op(s, &simple_dentry_operations);
 	s->s_time_gran = 1;
 	fsi->sb = s;
 
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 8dd1d7189c3b..45f9ca4465da 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -471,7 +471,7 @@ static int ecryptfs_get_tree(struct fs_context *fc)
 	sbi = NULL;
 	s->s_op = &ecryptfs_sops;
 	s->s_xattr = ecryptfs_xattr_handlers;
-	s->s_d_op = &ecryptfs_dops;
+	set_default_d_op(s, &ecryptfs_dops);
 
 	err = "Reading sb failed";
 	rc = kern_path(fc->source, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index c900d98bf494..f76d8dfa646b 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -350,7 +350,7 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize_bits    = PAGE_SHIFT;
 	sb->s_magic             = EFIVARFS_MAGIC;
 	sb->s_op                = &efivarfs_ops;
-	sb->s_d_op		= &efivarfs_d_ops;
+	set_default_d_op(sb, &efivarfs_d_ops);
 	sb->s_time_gran         = 1;
 
 	if (!efivar_supports_writes())
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7ed858937d45..ea5c1334a214 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -667,9 +667,9 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	if (sbi->options.utf8)
-		sb->s_d_op = &exfat_utf8_dentry_ops;
+		set_default_d_op(sb, &exfat_utf8_dentry_ops);
 	else
-		sb->s_d_op = &exfat_dentry_ops;
+		set_default_d_op(sb, &exfat_dentry_ops);
 
 	root_inode = new_inode(sb);
 	if (!root_inode) {
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 23e9b9371ec3..0b920ee40a7f 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -646,7 +646,7 @@ static const struct inode_operations msdos_dir_inode_operations = {
 static void setup(struct super_block *sb)
 {
 	MSDOS_SB(sb)->dir_ops = &msdos_dir_inode_operations;
-	sb->s_d_op = &msdos_dentry_operations;
+	set_default_d_op(sb, &msdos_dentry_operations);
 	sb->s_flags |= SB_NOATIME;
 }
 
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index dd910edd2404..5dbc4cbb8fce 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1187,9 +1187,9 @@ static void setup(struct super_block *sb)
 {
 	MSDOS_SB(sb)->dir_ops = &vfat_dir_inode_operations;
 	if (MSDOS_SB(sb)->options.name_check != 's')
-		sb->s_d_op = &vfat_ci_dentry_ops;
+		set_default_d_op(sb, &vfat_ci_dentry_ops);
 	else
-		sb->s_d_op = &vfat_dentry_ops;
+		set_default_d_op(sb, &vfat_dentry_ops);
 }
 
 static int vfat_fill_super(struct super_block *sb, struct fs_context *fc)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index eb6177508598..0dd65c0e9e29 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1715,7 +1715,7 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	fi = get_fuse_inode(root);
 	fi->nlookup--;
 
-	sb->s_d_op = &fuse_dentry_operations;
+	set_default_d_op(sb, &fuse_dentry_operations);
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root)
 		return -ENOMEM;
@@ -1850,7 +1850,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
-	sb->s_d_op = &fuse_dentry_operations;
+	set_default_d_op(sb, &fuse_dentry_operations);
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
 		goto err_dev_free;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 85c491fcf1a3..b568767dba46 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1145,7 +1145,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_magic = GFS2_MAGIC;
 	sb->s_op = &gfs2_super_ops;
 
-	sb->s_d_op = &gfs2_dops;
+	set_default_d_op(sb, &gfs2_dops);
 	sb->s_export_op = &gfs2_export_ops;
 	sb->s_qcop = &gfs2_quotactl_ops;
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index fe09c2093a93..388a318297ec 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -365,7 +365,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!root_inode)
 		goto bail_no_root;
 
-	sb->s_d_op = &hfs_dentry_operations;
+	set_default_d_op(sb, &hfs_dentry_operations);
 	res = -ENOMEM;
 	sb->s_root = d_make_root(root_inode);
 	if (!sb->s_root)
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 948b8aaee33e..0caf7aa1c249 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -508,7 +508,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto out_put_alloc_file;
 	}
 
-	sb->s_d_op = &hfsplus_dentry_operations;
+	set_default_d_op(sb, &hfsplus_dentry_operations);
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root) {
 		err = -ENOMEM;
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 702c41317589..1c0f5038e19c 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -933,7 +933,7 @@ static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize_bits = 10;
 	sb->s_magic = HOSTFS_SUPER_MAGIC;
 	sb->s_op = &hostfs_sbops;
-	sb->s_d_op = &simple_dentry_operations;
+	set_default_d_op(sb, &simple_dentry_operations);
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	err = super_setup_bdi(sb);
 	if (err)
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 27567920abe4..42b779b4d87f 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -554,7 +554,7 @@ static int hpfs_fill_super(struct super_block *s, struct fs_context *fc)
 	/* Fill superblock stuff */
 	s->s_magic = HPFS_SUPER_MAGIC;
 	s->s_op = &hpfs_sops;
-	s->s_d_op = &hpfs_dentry_operations;
+	set_default_d_op(s, &hpfs_dentry_operations);
 	s->s_time_min =  local_to_gmt(s, 0);
 	s->s_time_max =  local_to_gmt(s, U32_MAX);
 
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index d5da9817df9b..8624393c0d8c 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -939,7 +939,7 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 	sbi->s_check = opt->check;
 
 	if (table)
-		s->s_d_op = &isofs_dentry_ops[table - 1];
+		set_default_d_op(s, &isofs_dentry_ops[table - 1]);
 
 	/* get the root dentry */
 	s->s_root = d_make_root(inode);
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 10368c188c5e..3cfb86c5a36e 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -542,7 +542,7 @@ static int jfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_magic = JFS_SUPER_MAGIC;
 
 	if (sbi->mntflag & JFS_OS2)
-		sb->s_d_op = &jfs_ci_dentry_operations;
+		set_default_d_op(sb, &jfs_ci_dentry_operations);
 
 	inode = jfs_iget(sb, ROOT_I);
 	if (IS_ERR(inode)) {
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index c1719b5778a1..e384a69fbece 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -318,7 +318,7 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 		return -ENOMEM;
 	}
 	sb->s_root = root;
-	sb->s_d_op = &kernfs_dops;
+	set_default_d_op(sb, &kernfs_dops);
 	return 0;
 }
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a8..ab82de070310 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -75,7 +75,7 @@ struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, unsigned
 {
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
-	if (!dentry->d_sb->s_d_op)
+	if (!dentry->d_op)
 		d_set_d_op(dentry, &simple_dentry_operations);
 
 	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
@@ -684,7 +684,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_root = d_make_root(root);
 	if (!s->s_root)
 		return -ENOMEM;
-	s->s_d_op = ctx->dops;
+	set_default_d_op(s, ctx->dops);
 	return 0;
 }
 
@@ -1950,22 +1950,22 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
  * @sb: superblock to be configured
  *
  * Filesystems supporting casefolding and/or fscrypt can call this
- * helper at mount-time to configure sb->s_d_op to best set of dentry
- * operations required for the enabled features. The helper must be
- * called after these have been configured, but before the root dentry
- * is created.
+ * helper at mount-time to configure default dentry_operations to the
+ * best set of dentry operations required for the enabled features.
+ * The helper must be called after these have been configured, but
+ * before the root dentry is created.
  */
 void generic_set_sb_d_ops(struct super_block *sb)
 {
 #if IS_ENABLED(CONFIG_UNICODE)
 	if (sb->s_encoding) {
-		sb->s_d_op = &generic_ci_dentry_ops;
+		set_default_d_op(sb, &generic_ci_dentry_ops);
 		return;
 	}
 #endif
 #ifdef CONFIG_FS_ENCRYPTION
 	if (sb->s_cop) {
-		sb->s_d_op = &generic_encrypted_dentry_ops;
+		set_default_d_op(sb, &generic_encrypted_dentry_ops);
 		return;
 	}
 #endif
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 91b5503b6f74..72dee6f3050e 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1183,7 +1183,7 @@ static int nfs_set_super(struct super_block *s, struct fs_context *fc)
 	struct nfs_server *server = fc->s_fs_info;
 	int ret;
 
-	s->s_d_op = server->nfs_client->rpc_ops->dentry_ops;
+	set_default_d_op(s, server->nfs_client->rpc_ops->dentry_ops);
 	ret = set_anon_super(s, server);
 	if (ret == 0)
 		server->s_dev = s->s_dev;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 920a1ab47b63..ddff94c091b8 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1223,7 +1223,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_export_op = &ntfs_export_ops;
 	sb->s_time_gran = NTFS_TIME_GRAN; // 100 nsec
 	sb->s_xattr = ntfs_xattr_handlers;
-	sb->s_d_op = options->nocase ? &ntfs_dentry_ops : NULL;
+	if (options->nocase)
+		set_default_d_op(sb, &ntfs_dentry_ops);
 
 	options->nls = ntfs_load_nls(options->nls_name);
 	if (IS_ERR(options->nls)) {
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 3d2533950bae..53daa4482406 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1962,7 +1962,7 @@ static int ocfs2_initialize_super(struct super_block *sb,
 
 	sb->s_fs_info = osb;
 	sb->s_op = &ocfs2_sops;
-	sb->s_d_op = &ocfs2_dentry_ops;
+	set_default_d_op(sb, &ocfs2_dentry_ops);
 	sb->s_export_op = &ocfs2_export_ops;
 	sb->s_qcop = &dquot_quotactl_sysfile_ops;
 	sb->dq_op = &ocfs2_quota_operations;
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 64ca9498f550..f3da840758e7 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -416,7 +416,7 @@ static int orangefs_fill_sb(struct super_block *sb,
 	sb->s_xattr = orangefs_xattr_handlers;
 	sb->s_magic = ORANGEFS_SUPER_MAGIC;
 	sb->s_op = &orangefs_s_ops;
-	sb->s_d_op = &orangefs_dentry_operations;
+	set_default_d_op(sb, &orangefs_dentry_operations);
 
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e19940d649ca..efbf0b291551 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1322,7 +1322,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (WARN_ON(fc->user_ns != current_user_ns()))
 		goto out_err;
 
-	sb->s_d_op = &ovl_dentry_operations;
+	set_default_d_op(sb, &ovl_dentry_operations);
 
 	err = -ENOMEM;
 	if (!ofs->creator_cred)
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 0a5266ecfd15..d4ec73359922 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -260,9 +260,9 @@ cifs_read_super(struct super_block *sb)
 	}
 
 	if (tcon->nocase)
-		sb->s_d_op = &cifs_ci_dentry_ops;
+		set_default_d_op(sb, &cifs_ci_dentry_ops);
 	else
-		sb->s_d_op = &cifs_dentry_ops;
+		set_default_d_op(sb, &cifs_dentry_ops);
 
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root) {
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index a3fd3cc591bd..c8ca61777323 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -480,7 +480,7 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return err;
 
 	sb->s_op = &tracefs_super_operations;
-	sb->s_d_op = &tracefs_dentry_operations;
+	set_default_d_op(sb, &tracefs_dentry_operations);
 
 	return 0;
 }
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 0bc96ab6580b..241647b060ee 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -189,7 +189,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize = 1024;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_op = &vboxsf_super_ops;
-	sb->s_d_op = &vboxsf_dentry_ops;
+	set_default_d_op(sb, &vboxsf_dentry_ops);
 
 	iroot = iget_locked(sb, 0);
 	if (!iroot) {
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 1993e6704552..be7ae058fa90 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -607,4 +607,6 @@ static inline struct dentry *d_next_sibling(const struct dentry *dentry)
 	return hlist_entry_safe(dentry->d_sib.next, struct dentry, d_sib);
 }
 
+void set_default_d_op(struct super_block *, const struct dentry_operations *);
+
 #endif	/* __LINUX_DCACHE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..7cd8eaab4d4e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1413,7 +1413,7 @@ struct super_block {
 	 */
 	const char *s_subtype;
 
-	const struct dentry_operations *s_d_op; /* default d_op for dentries */
+	const struct dentry_operations *__s_d_op; /* default d_op for dentries */
 
 	struct shrinker *s_shrink;	/* per-sb shrinker handle */
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 0c5fb4ffa03a..3583508800fc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5028,7 +5028,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	if (ctx->encoding) {
 		sb->s_encoding = ctx->encoding;
-		sb->s_d_op = &shmem_ci_dentry_ops;
+		set_default_d_op(sb, &shmem_ci_dentry_ops);
 		if (ctx->strict_encoding)
 			sb->s_encoding_flags = SB_ENC_STRICT_MODE_FL;
 	}
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 98f78cd55905..f4e880383f67 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1363,7 +1363,7 @@ rpc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = RPCAUTH_GSSMAGIC;
 	sb->s_op = &s_ops;
-	sb->s_d_op = &simple_dentry_operations;
+	set_default_d_op(sb, &simple_dentry_operations);
 	sb->s_time_gran = 1;
 
 	inode = rpc_get_inode(sb, S_IFDIR | 0555);
-- 
2.39.5


