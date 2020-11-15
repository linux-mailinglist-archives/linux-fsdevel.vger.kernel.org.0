Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDF32B33FB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 11:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgKOKj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 05:39:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58980 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgKOKjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:39:06 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1keFQv-0000Kt-Nd; Sun, 15 Nov 2020 10:38:57 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 15/39] stat: handle idmapped mounts
Date:   Sun, 15 Nov 2020 11:36:54 +0100
Message-Id: <20201115103718.298186-16-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115103718.298186-1-christian.brauner@ubuntu.com>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The generic_fillattr() helper fills in the basic attributes associated with
an inode. Enable it to handle idmapped mounts. If the inode is accessed
through an idmapped mount we need to map it according to the mount's user
namespace. If the initial user namespace is passed all operations are a nop
so non-idmapped mounts will not see a change in behavior and will also not
see any performance impact.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig:
  - Don't pollute the vfs with additional helpers simply extend the existing
    helpers with an additional argument and switch all callers.
---
 fs/9p/vfs_inode.c      |  4 ++--
 fs/9p/vfs_inode_dotl.c |  4 ++--
 fs/afs/inode.c         |  2 +-
 fs/btrfs/inode.c       |  2 +-
 fs/ceph/inode.c        |  2 +-
 fs/cifs/inode.c        |  2 +-
 fs/coda/inode.c        |  2 +-
 fs/ecryptfs/inode.c    |  4 ++--
 fs/erofs/inode.c       |  2 +-
 fs/exfat/file.c        |  2 +-
 fs/ext2/inode.c        |  2 +-
 fs/ext4/inode.c        |  2 +-
 fs/f2fs/file.c         |  2 +-
 fs/fat/file.c          |  2 +-
 fs/fuse/dir.c          |  2 +-
 fs/gfs2/inode.c        |  2 +-
 fs/hfsplus/inode.c     |  2 +-
 fs/kernfs/inode.c      |  2 +-
 fs/libfs.c             |  4 ++--
 fs/minix/inode.c       |  2 +-
 fs/nfs/inode.c         |  2 +-
 fs/nfs/namespace.c     |  2 +-
 fs/ocfs2/file.c        |  2 +-
 fs/orangefs/inode.c    |  2 +-
 fs/proc/base.c         |  8 ++++----
 fs/proc/generic.c      |  2 +-
 fs/proc/proc_net.c     |  2 +-
 fs/proc/proc_sysctl.c  |  2 +-
 fs/proc/root.c         |  2 +-
 fs/stat.c              | 10 ++++++----
 fs/sysv/itree.c        |  2 +-
 fs/ubifs/dir.c         |  2 +-
 fs/udf/symlink.c       |  2 +-
 fs/vboxsf/utils.c      |  2 +-
 include/linux/fs.h     |  2 +-
 mm/shmem.c             |  2 +-
 36 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 404526499c94..0a5c022c1c70 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1006,7 +1006,7 @@ v9fs_vfs_getattr(const struct path *path, struct kstat *stat,
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		generic_fillattr(d_inode(dentry), stat);
+		generic_fillattr(&init_user_ns, d_inode(dentry), stat);
 		return 0;
 	}
 	fid = v9fs_fid_lookup(dentry);
@@ -1018,7 +1018,7 @@ v9fs_vfs_getattr(const struct path *path, struct kstat *stat,
 		return PTR_ERR(st);
 
 	v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb, 0);
-	generic_fillattr(d_inode(dentry), stat);
+	generic_fillattr(&init_user_ns, d_inode(dentry), stat);
 
 	p9stat_free(st);
 	kfree(st);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 282ec5cb45dc..8f3c1daf72ba 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -466,7 +466,7 @@ v9fs_vfs_getattr_dotl(const struct path *path, struct kstat *stat,
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		generic_fillattr(d_inode(dentry), stat);
+		generic_fillattr(&init_user_ns, d_inode(dentry), stat);
 		return 0;
 	}
 	fid = v9fs_fid_lookup(dentry);
@@ -482,7 +482,7 @@ v9fs_vfs_getattr_dotl(const struct path *path, struct kstat *stat,
 		return PTR_ERR(st);
 
 	v9fs_stat2inode_dotl(st, d_inode(dentry), 0);
-	generic_fillattr(d_inode(dentry), stat);
+	generic_fillattr(&init_user_ns, d_inode(dentry), stat);
 	/* Change block size to what the server returned */
 	stat->blksize = st->st_blksize;
 
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 0fe8844b4bee..17ecdee404eb 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -737,7 +737,7 @@ int afs_getattr(const struct path *path, struct kstat *stat,
 
 	do {
 		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
-		generic_fillattr(inode, stat);
+		generic_fillattr(&init_user_ns, inode, stat);
 		if (test_bit(AFS_VNODE_SILLY_DELETED, &vnode->flags) &&
 		    stat->nlink > 0)
 			stat->nlink -= 1;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e6f4aed0d311..99b4fd66681d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8783,7 +8783,7 @@ static int btrfs_getattr(const struct path *path, struct kstat *stat,
 				  STATX_ATTR_IMMUTABLE |
 				  STATX_ATTR_NODUMP);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	stat->dev = BTRFS_I(inode)->root->anon_dev;
 
 	spin_lock(&BTRFS_I(inode)->lock);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 19ec845ba5ec..decfa5e1ec4c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2380,7 +2380,7 @@ int ceph_getattr(const struct path *path, struct kstat *stat,
 			return err;
 	}
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	stat->ino = ceph_present_inode(inode);
 
 	/*
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 4d69b786e403..4fb3b6961096 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2400,7 +2400,7 @@ int cifs_getattr(const struct path *path, struct kstat *stat,
 			return rc;
 	}
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	stat->blksize = cifs_sb->bsize;
 	stat->ino = CIFS_I(inode)->uniqueid;
 
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index b1c70e2b9b1e..4d113e191cb8 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -256,7 +256,7 @@ int coda_getattr(const struct path *path, struct kstat *stat,
 {
 	int err = coda_revalidate_inode(d_inode(path->dentry));
 	if (!err)
-		generic_fillattr(d_inode(path->dentry), stat);
+		generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
 	return err;
 }
 
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index c35c2d2f3fe6..d98448c75051 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -975,7 +975,7 @@ static int ecryptfs_getattr_link(const struct path *path, struct kstat *stat,
 
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 						dentry->d_sb)->mount_crypt_stat;
-	generic_fillattr(d_inode(dentry), stat);
+	generic_fillattr(&init_user_ns, d_inode(dentry), stat);
 	if (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES) {
 		char *target;
 		size_t targetsiz;
@@ -1003,7 +1003,7 @@ static int ecryptfs_getattr(const struct path *path, struct kstat *stat,
 	if (!rc) {
 		fsstack_copy_attr_all(d_inode(dentry),
 				      ecryptfs_inode_to_lower(d_inode(dentry)));
-		generic_fillattr(d_inode(dentry), stat);
+		generic_fillattr(&init_user_ns, d_inode(dentry), stat);
 		stat->blocks = lower_stat.blocks;
 	}
 	return rc;
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 139d0bed42f8..6b57529b1c1d 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -342,7 +342,7 @@ int erofs_getattr(const struct path *path, struct kstat *stat,
 	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_IMMUTABLE);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	return 0;
 }
 
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index ace35aa8e64b..e9705b3295d3 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -273,7 +273,7 @@ int exfat_getattr(const struct path *path, struct kstat *stat,
 	struct inode *inode = d_backing_inode(path->dentry);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	exfat_truncate_atime(&stat->atime);
 	stat->result_mask |= STATX_BTIME;
 	stat->btime.tv_sec = ei->i_crtime.tv_sec;
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 5ff1e5e3c0fe..7fcda76094ff 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1659,7 +1659,7 @@ int ext2_getattr(const struct path *path, struct kstat *stat,
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	return 0;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7bc58f25bf2e..03be530cebbe 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5557,7 +5557,7 @@ int ext4_getattr(const struct path *path, struct kstat *stat,
 				  STATX_ATTR_NODUMP |
 				  STATX_ATTR_VERITY);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	return 0;
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5fc6c44020ed..20f7e5bdd9ad 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -814,7 +814,7 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 				  STATX_ATTR_NODUMP |
 				  STATX_ATTR_VERITY);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 
 	/* we need to show initial sectors used for inline_data/dentries */
 	if ((S_ISREG(inode->i_mode) && f2fs_has_inline_data(inode)) ||
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 805b501467e9..f7e04f533d31 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -398,7 +398,7 @@ int fat_getattr(const struct path *path, struct kstat *stat,
 		u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	stat->blksize = MSDOS_SB(inode->i_sb)->cluster_size;
 
 	if (MSDOS_SB(inode->i_sb)->options.nfs == FAT_NFS_NOSTALE_RO) {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index dc6e8cc565d2..0750755685cd 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1064,7 +1064,7 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 		forget_all_cached_acls(inode);
 		err = fuse_do_getattr(inode, stat, file);
 	} else if (stat) {
-		generic_fillattr(inode, stat);
+		generic_fillattr(&init_user_ns, inode, stat);
 		stat->mode = fi->orig_i_mode;
 		stat->ino = fi->orig_ino;
 	}
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 00a90287b919..eebc07f62c50 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2047,7 +2047,7 @@ static int gfs2_getattr(const struct path *path, struct kstat *stat,
 				  STATX_ATTR_IMMUTABLE |
 				  STATX_ATTR_NODUMP);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 
 	if (gfs2_holder_initialized(&gh))
 		gfs2_glock_dq_uninit(&gh);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index a2789730f451..a34f37a53dcd 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -286,7 +286,7 @@ int hfsplus_getattr(const struct path *path, struct kstat *stat,
 	stat->attributes_mask |= STATX_ATTR_APPEND | STATX_ATTR_IMMUTABLE |
 				 STATX_ATTR_NODUMP;
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	return 0;
 }
 
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 74ee0ffcfe71..062593491bbe 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -193,7 +193,7 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 	kernfs_refresh_inode(kn, inode);
 	mutex_unlock(&kernfs_mutex);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	return 0;
 }
 
diff --git a/fs/libfs.c b/fs/libfs.c
index f50446576b10..6aa8bead838f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -31,7 +31,7 @@ int simple_getattr(const struct path *path, struct kstat *stat,
 		   u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	stat->blocks = inode->i_mapping->nrpages << (PAGE_SHIFT - 9);
 	return 0;
 }
@@ -1302,7 +1302,7 @@ static int empty_dir_getattr(const struct path *path, struct kstat *stat,
 			     u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	return 0;
 }
 
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 34f546404aa1..91c81d2fc90d 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -658,7 +658,7 @@ int minix_getattr(const struct path *path, struct kstat *stat,
 	struct super_block *sb = path->dentry->d_sb;
 	struct inode *inode = d_inode(path->dentry);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	if (INODE_VERSION(inode) == MINIX_V1)
 		stat->blocks = (BLOCK_SIZE / 512) * V1_minix_blocks(stat->size, sb);
 	else
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index aa6493905bbe..8d74974d7992 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -858,7 +858,7 @@ int nfs_getattr(const struct path *path, struct kstat *stat,
 	/* Only return attributes that were revalidated. */
 	stat->result_mask &= request_mask;
 out_no_update:
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 2bcbe38afe2e..55fc711e368b 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -213,7 +213,7 @@ nfs_namespace_getattr(const struct path *path, struct kstat *stat,
 {
 	if (NFS_FH(d_inode(path->dentry))->size != 0)
 		return nfs_getattr(path, stat, request_mask, query_flags);
-	generic_fillattr(d_inode(path->dentry), stat);
+	generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
 	return 0;
 }
 
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index cabf355b148f..a070d4c9b6ed 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1313,7 +1313,7 @@ int ocfs2_getattr(const struct path *path, struct kstat *stat,
 		goto bail;
 	}
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	/*
 	 * If there is inline data in the inode, the inode will normally not
 	 * have data blocks allocated (it may have an external xattr block).
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 563fe9ab8eb2..b94032f77e61 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -903,7 +903,7 @@ int orangefs_getattr(const struct path *path, struct kstat *stat,
 	ret = orangefs_inode_getattr(inode,
 	    request_mask & STATX_SIZE ? ORANGEFS_GETATTR_SIZE : 0);
 	if (ret == 0) {
-		generic_fillattr(inode, stat);
+		generic_fillattr(&init_user_ns, inode, stat);
 
 		/* override block size reported to stat */
 		if (!(request_mask & STATX_SIZE))
diff --git a/fs/proc/base.c b/fs/proc/base.c
index e60f4c60f94c..541779a52b7d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1932,7 +1932,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	struct task_struct *task;
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 
 	stat->uid = GLOBAL_ROOT_UID;
 	stat->gid = GLOBAL_ROOT_GID;
@@ -2618,7 +2618,7 @@ static struct dentry *proc_pident_instantiate(struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
-static struct dentry *proc_pident_lookup(struct inode *dir, 
+static struct dentry *proc_pident_lookup(struct inode *dir,
 					 struct dentry *dentry,
 					 const struct pid_entry *p,
 					 const struct pid_entry *end)
@@ -2818,7 +2818,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 
 static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
 {
-	return proc_pident_readdir(file, ctx, 
+	return proc_pident_readdir(file, ctx,
 				   attr_dir_stuff, ARRAY_SIZE(attr_dir_stuff));
 }
 
@@ -3795,7 +3795,7 @@ static int proc_task_getattr(const struct path *path, struct kstat *stat,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct task_struct *p = get_proc_task(inode);
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 
 	if (p) {
 		stat->nlink += get_nr_threads(p);
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index fee877db93f2..6b8094a64176 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -145,7 +145,7 @@ static int proc_getattr(const struct path *path, struct kstat *stat,
 		}
 	}
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	return 0;
 }
 
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index ed8a6306990c..bc555b7da6dc 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -313,7 +313,7 @@ static int proc_tgid_net_getattr(const struct path *path, struct kstat *stat,
 
 	net = get_proc_task_net(inode);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 
 	if (net != NULL) {
 		stat->nlink = net->proc_net->nlink;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index ec67dbc1f705..87c828348140 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -840,7 +840,7 @@ static int proc_sys_getattr(const struct path *path, struct kstat *stat,
 	if (IS_ERR(head))
 		return PTR_ERR(head);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	if (table)
 		stat->mode = (stat->mode & S_IFMT) | table->mode;
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 5e444d4f9717..244e4b6f15ef 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -311,7 +311,7 @@ void __init proc_root_init(void)
 static int proc_root_getattr(const struct path *path, struct kstat *stat,
 			     u32 request_mask, unsigned int query_flags)
 {
-	generic_fillattr(d_inode(path->dentry), stat);
+	generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
 	stat->nlink = proc_root.nlink + nr_processes();
 	return 0;
 }
diff --git a/fs/stat.c b/fs/stat.c
index dacecdda2e79..868e39e101bc 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -26,6 +26,7 @@
 
 /**
  * generic_fillattr - Fill in the basic attributes from the inode struct
+ * @user_ns: the user namespace from which we access this inode
  * @inode: Inode to use as the source
  * @stat: Where to fill in the attributes
  *
@@ -33,14 +34,15 @@
  * found on the VFS inode structure.  This is the default if no getattr inode
  * operation is supplied.
  */
-void generic_fillattr(struct inode *inode, struct kstat *stat)
+void generic_fillattr(struct user_namespace *mnt_user_ns, struct inode *inode,
+		      struct kstat *stat)
 {
 	stat->dev = inode->i_sb->s_dev;
 	stat->ino = inode->i_ino;
 	stat->mode = inode->i_mode;
 	stat->nlink = inode->i_nlink;
-	stat->uid = inode->i_uid;
-	stat->gid = inode->i_gid;
+	stat->uid = i_uid_into_mnt(mnt_user_ns, inode);
+	stat->gid = i_gid_into_mnt(mnt_user_ns, inode);
 	stat->rdev = inode->i_rdev;
 	stat->size = i_size_read(inode);
 	stat->atime = inode->i_atime;
@@ -87,7 +89,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 		return inode->i_op->getattr(path, stat, request_mask,
 					    query_flags);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(mnt_user_ns(path->mnt), inode, stat);
 	return 0;
 }
 EXPORT_SYMBOL(vfs_getattr_nosec);
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index bcb67b0cabe7..83cffab6955f 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -445,7 +445,7 @@ int sysv_getattr(const struct path *path, struct kstat *stat,
 		 u32 request_mask, unsigned int flags)
 {
 	struct super_block *s = path->dentry->d_sb;
-	generic_fillattr(d_inode(path->dentry), stat);
+	generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
 	stat->blocks = (s->s_blocksize / 512) * sysv_nblocks(s, stat->size);
 	stat->blksize = s->s_blocksize;
 	return 0;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 1639331f9543..144422c39125 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1579,7 +1579,7 @@ int ubifs_getattr(const struct path *path, struct kstat *stat,
 				STATX_ATTR_ENCRYPTED |
 				STATX_ATTR_IMMUTABLE);
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	stat->blksize = UBIFS_BLOCK_SIZE;
 	stat->size = ui->ui_size;
 
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index c973db239604..54a44d1f023c 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -159,7 +159,7 @@ static int udf_symlink_getattr(const struct path *path, struct kstat *stat,
 	struct inode *inode = d_backing_inode(dentry);
 	struct page *page;
 
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 	page = read_mapping_page(inode->i_mapping, 0, NULL);
 	if (IS_ERR(page))
 		return PTR_ERR(page);
diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index 018057546067..d2cd1c99f48e 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -233,7 +233,7 @@ int vboxsf_getattr(const struct path *path, struct kstat *kstat,
 	if (err)
 		return err;
 
-	generic_fillattr(d_inode(dentry), kstat);
+	generic_fillattr(&init_user_ns, d_inode(dentry), kstat);
 	return 0;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 95200607ac9c..17f23f0ffca3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3123,7 +3123,7 @@ extern int __page_symlink(struct inode *inode, const char *symname, int len,
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
-extern void generic_fillattr(struct inode *, struct kstat *);
+extern void generic_fillattr(struct user_namespace *, struct inode *, struct kstat *);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/mm/shmem.c b/mm/shmem.c
index 8fdf52576e06..7c317b0d06f0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1072,7 +1072,7 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
 		shmem_recalc_inode(inode);
 		spin_unlock_irq(&info->lock);
 	}
-	generic_fillattr(inode, stat);
+	generic_fillattr(&init_user_ns, inode, stat);
 
 	if (is_huge_enabled(sb_info))
 		stat->blksize = HPAGE_PMD_SIZE;
-- 
2.29.2

