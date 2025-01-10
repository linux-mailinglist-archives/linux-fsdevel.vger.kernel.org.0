Return-Path: <linux-fsdevel+bounces-38795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C4CA085A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577B83A9B1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6351E32B3;
	Fri, 10 Jan 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F/NCgrvl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79E1E22E8;
	Fri, 10 Jan 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476990; cv=none; b=AwKCMzwKfzfw9OeNwsJlCo2yf/dlo5IZ+2a2xXcVnuUpcQK59tmgfM87wR/+E+Cqtk7ndqDtym76Xp5GuL5xK12oXlrNHOM+5gsGlp4k8BO6fbSOCnPNNGkIm2JrNR1iTxBHGQ995aeNcU66gB9XmudhhbMi8aeyEYP665QLuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476990; c=relaxed/simple;
	bh=JMjIU/VvD391nivyMGlnt3w0hQky3+adc7K1x8k6G3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdTHEKrI21BLBZ+jDJopc71ZB/gxV3aq+480CShnBvLsRzg4H6Er8OT+7orVrOxACAVvJIyyUgldhEGh0hba6jPJjbRFwg9+NcJXAEH5/rsSYjPzDhBNI4rDc5jM2m2xKZfnEZ1DeSbBo5Wfiy4eZ7WQ5FHQIVeL1oxvgRjg3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F/NCgrvl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=k+OnzZcGjU+K3lPZ95W1COeyt15vvmTdJn0HGuy50Wg=; b=F/NCgrvlRA3zA1m1FMwaNHhrto
	99Z1f5EpsMyq5tqK2G+1BiY4bLbdV0bokevqqyHSh6JcnYwpB7vwMs7vS6pQWI/JhTeA4yfdK0QBJ
	LekTfKbZKWuLSmmvtgTALkKhjC00XHT4nUNVNl8QgZQ8uxt4Xm12/LwIKw/AQY5Q0eonlyaFvLMVT
	KUofEPGtbTp36W6AuvKspcrkHQfSSl656sSEi+rT1I7N5sUGUH47xyTz437BM8CX9uHA9QsM1aHC6
	sSpsCl1T44cX1R3mSplVjM6VULOdYPf6rOeADJLtX1jiQ8vA1Mt2FDXeLR6xDqqiYhnhiz72jR/Es
	+VnPX3Iw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zI-0000000HRbM-0kJO;
	Fri, 10 Jan 2025 02:43:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH 07/20] Pass parent directory inode and expected name to ->d_revalidate()
Date: Fri, 10 Jan 2025 02:42:50 +0000
Message-ID: <20250110024303.4157645-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

->d_revalidate() often needs to access dentry parent and name; that has
to be done carefully, since the locking environment varies from caller
to caller.  We are not guaranteed that dentry in question will not be
moved right under us - not unless the filesystem is such that nothing
on it ever gets renamed.

It can be dealt with, but that results in boilerplate code that isn't
even needed - the callers normally have just found the dentry via dcache
lookup and want to verify that it's in the right place; they already
have the values of ->d_parent and ->d_name stable.  There is a couple
of exceptions (overlayfs and, to less extent, ecryptfs), but for the
majority of calls that song and dance is not needed at all.

It's easier to make ecryptfs and overlayfs find and pass those values if
there's a ->d_revalidate() instance to be called, rather than doing that
in the instances.

This commit only changes the calling conventions; making use of supplied
values is left to followups.

NOTE: some instances need more than just the parent - things like CIFS
may need to build an entire path from filesystem root, so they need
more precautions than the usual boilerplate.  This series doesn't
do anything to that need - these filesystems have to keep their locking
mechanisms (rename_lock loops, use of dentry_path_raw(), private rwsem
a-la v9fs).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/locking.rst |  3 ++-
 Documentation/filesystems/porting.rst | 13 +++++++++++++
 Documentation/filesystems/vfs.rst     |  3 ++-
 fs/9p/vfs_dentry.c                    | 10 ++++++++--
 fs/afs/dir.c                          |  6 ++++--
 fs/ceph/dir.c                         |  5 +++--
 fs/coda/dir.c                         |  3 ++-
 fs/crypto/fname.c                     |  3 ++-
 fs/ecryptfs/dentry.c                  | 18 ++++++++++++++----
 fs/exfat/namei.c                      |  3 ++-
 fs/fat/namei_vfat.c                   |  6 ++++--
 fs/fuse/dir.c                         |  3 ++-
 fs/gfs2/dentry.c                      |  7 +++++--
 fs/hfs/sysdep.c                       |  3 ++-
 fs/jfs/namei.c                        |  3 ++-
 fs/kernfs/dir.c                       |  3 ++-
 fs/namei.c                            | 18 ++++++++++--------
 fs/nfs/dir.c                          |  9 ++++++---
 fs/ocfs2/dcache.c                     |  3 ++-
 fs/orangefs/dcache.c                  |  3 ++-
 fs/overlayfs/super.c                  | 22 ++++++++++++++++++++--
 fs/proc/base.c                        |  6 ++++--
 fs/proc/fd.c                          |  3 ++-
 fs/proc/generic.c                     |  6 ++++--
 fs/proc/proc_sysctl.c                 |  3 ++-
 fs/smb/client/dir.c                   |  3 ++-
 fs/tracefs/inode.c                    |  3 ++-
 fs/vboxsf/dir.c                       |  3 ++-
 include/linux/dcache.h                |  3 ++-
 include/linux/fscrypt.h               |  7 ++++---
 30 files changed, 133 insertions(+), 51 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index f5e3676db954..146e7d8aa736 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -17,7 +17,8 @@ dentry_operations
 
 prototypes::
 
-	int (*d_revalidate)(struct dentry *, unsigned int);
+	int (*d_revalidate)(struct inode *, const struct qstr *,
+			    struct dentry *, unsigned int);
 	int (*d_weak_revalidate)(struct dentry *, unsigned int);
 	int (*d_hash)(const struct dentry *, struct qstr *);
 	int (*d_compare)(const struct dentry *,
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 9ab2a3d6f2b4..b50c3ce36ef2 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1141,3 +1141,16 @@ pointer are gone.
 
 set_blocksize() takes opened struct file instead of struct block_device now
 and it *must* be opened exclusive.
+
+---
+
+** mandatory**
+
+->d_revalidate() gets two extra arguments - inode of parent directory and
+name our dentry is expected to have.  Both are stable (dir is pinned in
+non-RCU case and will stay around during the call in RCU case, and name
+is guaranteed to stay unchanging).  Your instance doesn't have to use
+either, but it often helps to avoid a lot of painful boilerplate.
+NOTE: if you need something like full path from the root of filesystem,
+you are still on your own - this assists with simple cases, but it's not
+magic.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 0b18af3f954e..7c352ebaae98 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1251,7 +1251,8 @@ defined:
 .. code-block:: c
 
 	struct dentry_operations {
-		int (*d_revalidate)(struct dentry *, unsigned int);
+		int (*d_revalidate)(struct inode *, const struct qstr *,
+				    struct dentry *, unsigned int);
 		int (*d_weak_revalidate)(struct dentry *, unsigned int);
 		int (*d_hash)(const struct dentry *, struct qstr *);
 		int (*d_compare)(const struct dentry *,
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 01338d4c2d9e..872c1abe3295 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -61,7 +61,7 @@ static void v9fs_dentry_release(struct dentry *dentry)
 		p9_fid_put(hlist_entry(p, struct p9_fid, dlist));
 }
 
-static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
+static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct p9_fid *fid;
 	struct inode *inode;
@@ -99,9 +99,15 @@ static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 	return 1;
 }
 
+static int v9fs_lookup_revalidate(struct inode *dir, const struct qstr *name,
+				  struct dentry *dentry, unsigned int flags)
+{
+	return __v9fs_lookup_revalidate(dentry, flags);
+}
+
 const struct dentry_operations v9fs_cached_dentry_operations = {
 	.d_revalidate = v9fs_lookup_revalidate,
-	.d_weak_revalidate = v9fs_lookup_revalidate,
+	.d_weak_revalidate = __v9fs_lookup_revalidate,
 	.d_delete = v9fs_cached_dentry_delete,
 	.d_release = v9fs_dentry_release,
 };
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index ada363af5aab..9780013cd83a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -22,7 +22,8 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 				 unsigned int flags);
 static int afs_dir_open(struct inode *inode, struct file *file);
 static int afs_readdir(struct file *file, struct dir_context *ctx);
-static int afs_d_revalidate(struct dentry *dentry, unsigned int flags);
+static int afs_d_revalidate(struct inode *dir, const struct qstr *name,
+			    struct dentry *dentry, unsigned int flags);
 static int afs_d_delete(const struct dentry *dentry);
 static void afs_d_iput(struct dentry *dentry, struct inode *inode);
 static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int nlen,
@@ -1093,7 +1094,8 @@ static int afs_d_revalidate_rcu(struct dentry *dentry)
  * - NOTE! the hit can be a negative hit too, so we can't assume we have an
  *   inode
  */
-static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
+			    struct dentry *dentry, unsigned int flags)
 {
 	struct afs_vnode *vnode, *dir;
 	struct afs_fid fid;
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 0bf388e07a02..c4c71c24221b 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1940,7 +1940,8 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry,
 /*
  * Check if cached dentry can be trusted.
  */
-static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int ceph_d_revalidate(struct inode *parent_dir, const struct qstr *name,
+			     struct dentry *dentry, unsigned int flags)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(dentry->d_sb)->mdsc;
 	struct ceph_client *cl = mdsc->fsc->client;
@@ -1948,7 +1949,7 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	struct dentry *parent;
 	struct inode *dir, *inode;
 
-	valid = fscrypt_d_revalidate(dentry, flags);
+	valid = fscrypt_d_revalidate(parent_dir, name, dentry, flags);
 	if (valid <= 0)
 		return valid;
 
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 4e552ba7bd43..a3e2dfeedfbf 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -445,7 +445,8 @@ static int coda_readdir(struct file *coda_file, struct dir_context *ctx)
 }
 
 /* called when a cache lookup succeeds */
-static int coda_dentry_revalidate(struct dentry *de, unsigned int flags)
+static int coda_dentry_revalidate(struct inode *dir, const struct qstr *name,
+				  struct dentry *de, unsigned int flags)
 {
 	struct inode *inode;
 	struct coda_inode_info *cii;
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 0ad52fbe51c9..389f5b2bf63b 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -574,7 +574,8 @@ EXPORT_SYMBOL_GPL(fscrypt_fname_siphash);
  * Validate dentries in encrypted directories to make sure we aren't potentially
  * caching stale dentries after a key has been added.
  */
-int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
+int fscrypt_d_revalidate(struct inode *parent_dir, const struct qstr *name,
+			 struct dentry *dentry, unsigned int flags)
 {
 	struct dentry *dir;
 	int err;
diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index acaa0825e9bb..1dfd5b81d831 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -17,7 +17,9 @@
 
 /**
  * ecryptfs_d_revalidate - revalidate an ecryptfs dentry
- * @dentry: The ecryptfs dentry
+ * @dir: inode of expected parent
+ * @name: expected name
+ * @dentry: dentry to revalidate
  * @flags: lookup flags
  *
  * Called when the VFS needs to revalidate a dentry. This
@@ -28,7 +30,8 @@
  * Returns 1 if valid, 0 otherwise.
  *
  */
-static int ecryptfs_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int ecryptfs_d_revalidate(struct inode *dir, const struct qstr *name,
+				 struct dentry *dentry, unsigned int flags)
 {
 	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	int rc = 1;
@@ -36,8 +39,15 @@ static int ecryptfs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	if (lower_dentry->d_flags & DCACHE_OP_REVALIDATE)
-		rc = lower_dentry->d_op->d_revalidate(lower_dentry, flags);
+	if (lower_dentry->d_flags & DCACHE_OP_REVALIDATE) {
+		struct inode *lower_dir = ecryptfs_inode_to_lower(dir);
+		struct name_snapshot n;
+
+		take_dentry_name_snapshot(&n, lower_dentry);
+		rc = lower_dentry->d_op->d_revalidate(lower_dir, &n.name,
+						      lower_dentry, flags);
+		release_dentry_name_snapshot(&n);
+	}
 
 	if (d_really_is_positive(dentry)) {
 		struct inode *inode = d_inode(dentry);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 97d2774760fe..e3b4feccba07 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -31,7 +31,8 @@ static inline void exfat_d_version_set(struct dentry *dentry,
  * If it happened, the negative dentry isn't actually negative anymore.  So,
  * drop it.
  */
-static int exfat_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int exfat_d_revalidate(struct inode *dir, const struct qstr *name,
+			      struct dentry *dentry, unsigned int flags)
 {
 	int ret;
 
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 15bf32c21ac0..f9cbd5c6f932 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -53,7 +53,8 @@ static int vfat_revalidate_shortname(struct dentry *dentry)
 	return ret;
 }
 
-static int vfat_revalidate(struct dentry *dentry, unsigned int flags)
+static int vfat_revalidate(struct inode *dir, const struct qstr *name,
+			   struct dentry *dentry, unsigned int flags)
 {
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -64,7 +65,8 @@ static int vfat_revalidate(struct dentry *dentry, unsigned int flags)
 	return vfat_revalidate_shortname(dentry);
 }
 
-static int vfat_revalidate_ci(struct dentry *dentry, unsigned int flags)
+static int vfat_revalidate_ci(struct inode *dir, const struct qstr *name,
+			      struct dentry *dentry, unsigned int flags)
 {
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 494ac372ace0..d9e9f26917eb 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -192,7 +192,8 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
  * the lookup once more.  If the lookup results in the same inode,
  * then refresh the attributes, timeouts and mark the dentry valid.
  */
-static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
+static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
+				  struct dentry *entry, unsigned int flags)
 {
 	struct inode *inode;
 	struct dentry *parent;
diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index 2e215e8c3c88..86c338901fab 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -21,7 +21,9 @@
 
 /**
  * gfs2_drevalidate - Check directory lookup consistency
- * @dentry: the mapping to check
+ * @dir: expected parent directory inode
+ * @name: expexted name
+ * @dentry: dentry to check
  * @flags: lookup flags
  *
  * Check to make sure the lookup necessary to arrive at this inode from its
@@ -30,7 +32,8 @@
  * Returns: 1 if the dentry is ok, 0 if it isn't
  */
 
-static int gfs2_drevalidate(struct dentry *dentry, unsigned int flags)
+static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
+			    struct dentry *dentry, unsigned int flags)
 {
 	struct dentry *parent;
 	struct gfs2_sbd *sdp;
diff --git a/fs/hfs/sysdep.c b/fs/hfs/sysdep.c
index 76fa02e3835b..ef54fc8093cf 100644
--- a/fs/hfs/sysdep.c
+++ b/fs/hfs/sysdep.c
@@ -13,7 +13,8 @@
 
 /* dentry case-handling: just lowercase everything */
 
-static int hfs_revalidate_dentry(struct dentry *dentry, unsigned int flags)
+static int hfs_revalidate_dentry(struct inode *dir, const struct qstr *name,
+				 struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	int diff;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index d68a4e6ac345..fc8ede43afde 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1576,7 +1576,8 @@ static int jfs_ci_compare(const struct dentry *dentry,
 	return result;
 }
 
-static int jfs_ci_revalidate(struct dentry *dentry, unsigned int flags)
+static int jfs_ci_revalidate(struct inode *dir, const struct qstr *name,
+			     struct dentry *dentry, unsigned int flags)
 {
 	/*
 	 * This is not negative dentry. Always valid.
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 458519e416fe..5f0f8b95f44c 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1109,7 +1109,8 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 	return ERR_PTR(rc);
 }
 
-static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
+static int kernfs_dop_revalidate(struct inode *dir, const struct qstr *name,
+				 struct dentry *dentry, unsigned int flags)
 {
 	struct kernfs_node *kn;
 	struct kernfs_root *root;
diff --git a/fs/namei.c b/fs/namei.c
index 9d30c7aa9aa6..77e5d136faaf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -921,10 +921,11 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	return false;
 }
 
-static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
+static inline int d_revalidate(struct inode *dir, const struct qstr *name,
+			       struct dentry *dentry, unsigned int flags)
 {
 	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
-		return dentry->d_op->d_revalidate(dentry, flags);
+		return dentry->d_op->d_revalidate(dir, name, dentry, flags);
 	else
 		return 1;
 }
@@ -1652,7 +1653,7 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 {
 	struct dentry *dentry = d_lookup(dir, name);
 	if (dentry) {
-		int error = d_revalidate(dentry, flags);
+		int error = d_revalidate(dir->d_inode, name, dentry, flags);
 		if (unlikely(error <= 0)) {
 			if (!error)
 				d_invalidate(dentry);
@@ -1737,19 +1738,20 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 		if (read_seqcount_retry(&parent->d_seq, nd->seq))
 			return ERR_PTR(-ECHILD);
 
-		status = d_revalidate(dentry, nd->flags);
+		status = d_revalidate(nd->inode, &nd->last, dentry, nd->flags);
 		if (likely(status > 0))
 			return dentry;
 		if (!try_to_unlazy_next(nd, dentry))
 			return ERR_PTR(-ECHILD);
 		if (status == -ECHILD)
 			/* we'd been told to redo it in non-rcu mode */
-			status = d_revalidate(dentry, nd->flags);
+			status = d_revalidate(nd->inode, &nd->last,
+					      dentry, nd->flags);
 	} else {
 		dentry = __d_lookup(parent, &nd->last);
 		if (unlikely(!dentry))
 			return NULL;
-		status = d_revalidate(dentry, nd->flags);
+		status = d_revalidate(nd->inode, &nd->last, dentry, nd->flags);
 	}
 	if (unlikely(status <= 0)) {
 		if (!status)
@@ -1777,7 +1779,7 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 	if (IS_ERR(dentry))
 		return dentry;
 	if (unlikely(!d_in_lookup(dentry))) {
-		int error = d_revalidate(dentry, flags);
+		int error = d_revalidate(inode, name, dentry, flags);
 		if (unlikely(error <= 0)) {
 			if (!error) {
 				d_invalidate(dentry);
@@ -3575,7 +3577,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (d_in_lookup(dentry))
 			break;
 
-		error = d_revalidate(dentry, nd->flags);
+		error = d_revalidate(dir_inode, &nd->last, dentry, nd->flags);
 		if (likely(error > 0))
 			break;
 		if (error)
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 492cffd9d3d8..9910d9796f4c 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1814,7 +1814,8 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags,
 	return ret;
 }
 
-static int nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
+static int nfs_lookup_revalidate(struct inode *dir, const struct qstr *name,
+				 struct dentry *dentry, unsigned int flags)
 {
 	return __nfs_lookup_revalidate(dentry, flags, nfs_do_lookup_revalidate);
 }
@@ -2025,7 +2026,8 @@ void nfs_d_prune_case_insensitive_aliases(struct inode *inode)
 EXPORT_SYMBOL_GPL(nfs_d_prune_case_insensitive_aliases);
 
 #if IS_ENABLED(CONFIG_NFS_V4)
-static int nfs4_lookup_revalidate(struct dentry *, unsigned int);
+static int nfs4_lookup_revalidate(struct inode *, const struct qstr *,
+				  struct dentry *, unsigned int);
 
 const struct dentry_operations nfs4_dentry_operations = {
 	.d_revalidate	= nfs4_lookup_revalidate,
@@ -2260,7 +2262,8 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 	return nfs_do_lookup_revalidate(dir, dentry, flags);
 }
 
-static int nfs4_lookup_revalidate(struct dentry *dentry, unsigned int flags)
+static int nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
+				  struct dentry *dentry, unsigned int flags)
 {
 	return __nfs_lookup_revalidate(dentry, flags,
 			nfs4_do_lookup_revalidate);
diff --git a/fs/ocfs2/dcache.c b/fs/ocfs2/dcache.c
index a9b8688aaf30..ecb1ce6301c4 100644
--- a/fs/ocfs2/dcache.c
+++ b/fs/ocfs2/dcache.c
@@ -32,7 +32,8 @@ void ocfs2_dentry_attach_gen(struct dentry *dentry)
 }
 
 
-static int ocfs2_dentry_revalidate(struct dentry *dentry, unsigned int flags)
+static int ocfs2_dentry_revalidate(struct inode *dir, const struct qstr *name,
+				   struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	int ret = 0;    /* if all else fails, just return false */
diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
index 395a00ed8ac7..c32c9a86e8d0 100644
--- a/fs/orangefs/dcache.c
+++ b/fs/orangefs/dcache.c
@@ -92,7 +92,8 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
  *
  * Should return 1 if dentry can still be trusted, else 0.
  */
-static int orangefs_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int orangefs_d_revalidate(struct inode *dir, const struct qstr *name,
+				 struct dentry *dentry, unsigned int flags)
 {
 	int ret;
 	unsigned long time = (unsigned long) dentry->d_fsdata;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index fe511192f83c..86ae6f6da36b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -91,7 +91,24 @@ static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak)
 		if (d->d_flags & DCACHE_OP_WEAK_REVALIDATE)
 			ret =  d->d_op->d_weak_revalidate(d, flags);
 	} else if (d->d_flags & DCACHE_OP_REVALIDATE) {
-		ret = d->d_op->d_revalidate(d, flags);
+		struct dentry *parent;
+		struct inode *dir;
+		struct name_snapshot n;
+
+		if (flags & LOOKUP_RCU) {
+			parent = READ_ONCE(d->d_parent);
+			dir = d_inode_rcu(parent);
+			if (!dir)
+				return -ECHILD;
+		} else {
+			parent = dget_parent(d);
+			dir = d_inode(parent);
+		}
+		take_dentry_name_snapshot(&n, d);
+		ret = d->d_op->d_revalidate(dir, &n.name, d, flags);
+		release_dentry_name_snapshot(&n);
+		if (!(flags & LOOKUP_RCU))
+			dput(parent);
 		if (!ret) {
 			if (!(flags & LOOKUP_RCU))
 				d_invalidate(d);
@@ -127,7 +144,8 @@ static int ovl_dentry_revalidate_common(struct dentry *dentry,
 	return ret;
 }
 
-static int ovl_dentry_revalidate(struct dentry *dentry, unsigned int flags)
+static int ovl_dentry_revalidate(struct inode *dir, const struct qstr *name,
+				 struct dentry *dentry, unsigned int flags)
 {
 	return ovl_dentry_revalidate_common(dentry, flags, false);
 }
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 0edf14a9840e..fb5493d0edf0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2058,7 +2058,8 @@ void pid_update_inode(struct task_struct *task, struct inode *inode)
  * performed a setuid(), etc.
  *
  */
-static int pid_revalidate(struct dentry *dentry, unsigned int flags)
+static int pid_revalidate(struct inode *dir, const struct qstr *name,
+			  struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	struct task_struct *task;
@@ -2191,7 +2192,8 @@ static int dname_to_vma_addr(struct dentry *dentry,
 	return 0;
 }
 
-static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int map_files_d_revalidate(struct inode *dir, const struct qstr *name,
+				  struct dentry *dentry, unsigned int flags)
 {
 	unsigned long vm_start, vm_end;
 	bool exact_vma_exists = false;
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 24baf23e864f..37aa778d1af7 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -140,7 +140,8 @@ static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
 	security_task_to_inode(task, inode);
 }
 
-static int tid_fd_revalidate(struct dentry *dentry, unsigned int flags)
+static int tid_fd_revalidate(struct inode *dir, const struct qstr *name,
+			     struct dentry *dentry, unsigned int flags)
 {
 	struct task_struct *task;
 	struct inode *inode;
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index dbe82cf23ee4..8ec90826a49e 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -216,7 +216,8 @@ void proc_free_inum(unsigned int inum)
 	ida_free(&proc_inum_ida, inum - PROC_DYNAMIC_FIRST);
 }
 
-static int proc_misc_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int proc_misc_d_revalidate(struct inode *dir, const struct qstr *name,
+				  struct dentry *dentry, unsigned int flags)
 {
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -343,7 +344,8 @@ static const struct file_operations proc_dir_operations = {
 	.iterate_shared		= proc_readdir,
 };
 
-static int proc_net_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int proc_net_d_revalidate(struct inode *dir, const struct qstr *name,
+				 struct dentry *dentry, unsigned int flags)
 {
 	return 0;
 }
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 27a283d85a6e..cc9d74a06ff0 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -884,7 +884,8 @@ static const struct inode_operations proc_sys_dir_operations = {
 	.getattr	= proc_sys_getattr,
 };
 
-static int proc_sys_revalidate(struct dentry *dentry, unsigned int flags)
+static int proc_sys_revalidate(struct inode *dir, const struct qstr *name,
+			       struct dentry *dentry, unsigned int flags)
 {
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 864b194dbaa0..8c5d44ee91ed 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -737,7 +737,8 @@ cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry,
 }
 
 static int
-cifs_d_revalidate(struct dentry *direntry, unsigned int flags)
+cifs_d_revalidate(struct inode *dir, const struct qstr *name,
+		  struct dentry *direntry, unsigned int flags)
 {
 	struct inode *inode;
 	int rc;
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index cfc614c638da..53214499e384 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -457,7 +457,8 @@ static void tracefs_d_release(struct dentry *dentry)
 		eventfs_d_release(dentry);
 }
 
-static int tracefs_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int tracefs_d_revalidate(struct inode *inode, const struct qstr *name,
+				struct dentry *dentry, unsigned int flags)
 {
 	struct eventfs_inode *ei = dentry->d_fsdata;
 
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 5f1a14d5b927..a859ac9b74ba 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -192,7 +192,8 @@ const struct file_operations vboxsf_dir_fops = {
  * This is called during name resolution/lookup to check if the @dentry in
  * the cache is still valid. the job is handled by vboxsf_inode_revalidate.
  */
-static int vboxsf_dentry_revalidate(struct dentry *dentry, unsigned int flags)
+static int vboxsf_dentry_revalidate(struct inode *dir, const struct qstr *name,
+				    struct dentry *dentry, unsigned int flags)
 {
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 8bc567a35718..4a6bdadf2f29 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -144,7 +144,8 @@ enum d_real_type {
 };
 
 struct dentry_operations {
-	int (*d_revalidate)(struct dentry *, unsigned int);
+	int (*d_revalidate)(struct inode *, const struct qstr *,
+			    struct dentry *, unsigned int);
 	int (*d_weak_revalidate)(struct dentry *, unsigned int);
 	int (*d_hash)(const struct dentry *, struct qstr *);
 	int (*d_compare)(const struct dentry *,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 772f822dc6b8..18855cb44b1c 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -192,7 +192,8 @@ struct fscrypt_operations {
 					     unsigned int *num_devs);
 };
 
-int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
+int fscrypt_d_revalidate(struct inode *dir, const struct qstr *name,
+			 struct dentry *dentry, unsigned int flags);
 
 static inline struct fscrypt_inode_info *
 fscrypt_get_inode_info(const struct inode *inode)
@@ -711,8 +712,8 @@ static inline u64 fscrypt_fname_siphash(const struct inode *dir,
 	return 0;
 }
 
-static inline int fscrypt_d_revalidate(struct dentry *dentry,
-				       unsigned int flags)
+static inline int fscrypt_d_revalidate(struct inode *dir, const struct qstr *name,
+				       struct dentry *dentry, unsigned int flags)
 {
 	return 1;
 }
-- 
2.39.5


