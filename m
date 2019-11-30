Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7195110DF60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 22:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfK3VVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 16:21:10 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56202 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727025AbfK3VVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 16:21:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A7EBA8EE0DF;
        Sat, 30 Nov 2019 13:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575148869;
        bh=9G9qULMP0VWk9HdgFLR0qsxUcfBfJJiXEk18cWMJPRk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MagRRmh3t+4nR8I4EIVLTsFpHRRokDiFHlbxD5BoK3SZEI4zPKX3Qzl/TFk389peL
         0JRpQqK7z6wrBFWyxAwXX7Je2ixIoiV0twnP+wcIwuJo8ka1IrweFLIjOPPiFROCW4
         6SU3/ImWgKrpNvjfaBPLaDc1p27uJgDtxvOhpPsw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id koMtSQgiLAir; Sat, 30 Nov 2019 13:21:09 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1D8398EE07B;
        Sat, 30 Nov 2019 13:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575148869;
        bh=9G9qULMP0VWk9HdgFLR0qsxUcfBfJJiXEk18cWMJPRk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MagRRmh3t+4nR8I4EIVLTsFpHRRokDiFHlbxD5BoK3SZEI4zPKX3Qzl/TFk389peL
         0JRpQqK7z6wrBFWyxAwXX7Je2ixIoiV0twnP+wcIwuJo8ka1IrweFLIjOPPiFROCW4
         6SU3/ImWgKrpNvjfaBPLaDc1p27uJgDtxvOhpPsw=
Message-ID: <1575148868.5563.30.camel@HansenPartnership.com>
Subject: [PATCH 1/1] fs: rethread notify_change to take a path instead of a
 dentry
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>
Date:   Sat, 30 Nov 2019 13:21:08 -0800
In-Reply-To: <1575148763.5563.28.camel@HansenPartnership.com>
References: <1575148763.5563.28.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to prepare for implementing shiftfs as a property changing
bind mount, the path (which contains the vfsmount) must be threaded
through everywhere we are going to do either a permission check or an
attribute get/set so that we can arrange for the credentials for the
operation to be based on the bind mount properties rather than those
of current.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/base/devtmpfs.c   |  8 +++++--
 fs/attr.c                 |  4 +++-
 fs/cachefiles/interface.c |  6 +++--
 fs/coredump.c             |  4 ++--
 fs/ecryptfs/inode.c       |  9 ++++---
 fs/inode.c                |  7 +++---
 fs/namei.c                |  2 +-
 fs/nfsd/vfs.c             |  9 +++++--
 fs/open.c                 | 19 ++++++++-------
 fs/overlayfs/copy_up.c    | 60 +++++++++++++++++++++++++++--------------------
 fs/overlayfs/dir.c        | 16 ++++++++++---
 fs/overlayfs/inode.c      |  6 +++--
 fs/overlayfs/overlayfs.h  |  2 +-
 fs/overlayfs/super.c      |  3 ++-
 fs/utimes.c               |  2 +-
 include/linux/fs.h        |  6 ++---
 16 files changed, 102 insertions(+), 61 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 30d0523014e0..35488f7140a9 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -224,13 +224,17 @@ static int handle_create(const char *nodename, umode_t mode, kuid_t uid,
 	err = vfs_mknod(d_inode(path.dentry), dentry, mode, dev->devt);
 	if (!err) {
 		struct iattr newattrs;
+		struct path newpath = {
+			.mnt = path.mnt,
+			.dentry = dentry,
+		};
 
 		newattrs.ia_mode = mode;
 		newattrs.ia_uid = uid;
 		newattrs.ia_gid = gid;
 		newattrs.ia_valid = ATTR_MODE|ATTR_UID|ATTR_GID;
 		inode_lock(d_inode(dentry));
-		notify_change(dentry, &newattrs, NULL);
+		notify_change(&newpath, &newattrs, NULL);
 		inode_unlock(d_inode(dentry));
 
 		/* mark as kernel-created inode */
@@ -337,7 +341,7 @@ static int handle_remove(const char *nodename, struct device *dev)
 			newattrs.ia_valid =
 				ATTR_UID|ATTR_GID|ATTR_MODE;
 			inode_lock(d_inode(dentry));
-			notify_change(dentry, &newattrs, NULL);
+			notify_change(&p, &newattrs, NULL);
 			inode_unlock(d_inode(dentry));
 			err = vfs_unlink(d_inode(parent.dentry), dentry, NULL);
 			if (!err || err == -ENOENT)
diff --git a/fs/attr.c b/fs/attr.c
index df28035aa23e..370b18807f05 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -226,8 +226,10 @@ EXPORT_SYMBOL(setattr_copy);
  * the file open for write, as there can be no conflicting delegation in
  * that case.
  */
-int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **delegated_inode)
+int notify_change(const struct path *path, struct iattr * attr,
+		  struct inode **delegated_inode)
 {
+	struct dentry *dentry = path->dentry;
 	struct inode *inode = dentry->d_inode;
 	umode_t mode = inode->i_mode;
 	int error;
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 4cea5fbf695e..aa82d95890fa 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -436,6 +436,7 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
 	uint64_t ni_size;
 	loff_t oi_size;
 	int ret;
+	struct path *path;
 
 	ni_size = _object->store_limit_l;
 
@@ -466,18 +467,19 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
 	/* if there's an extension to a partial page at the end of the backing
 	 * file, we need to discard the partial page so that we pick up new
 	 * data after it */
+	path = &(struct path) { .mnt = cache->mnt, .dentry = object->backer };
 	if (oi_size & ~PAGE_MASK && ni_size > oi_size) {
 		_debug("discard tail %llx", oi_size);
 		newattrs.ia_valid = ATTR_SIZE;
 		newattrs.ia_size = oi_size & PAGE_MASK;
-		ret = notify_change(object->backer, &newattrs, NULL);
+		ret = notify_change(path, &newattrs, NULL);
 		if (ret < 0)
 			goto truncate_failed;
 	}
 
 	newattrs.ia_valid = ATTR_SIZE;
 	newattrs.ia_size = ni_size;
-	ret = notify_change(object->backer, &newattrs, NULL);
+	ret = notify_change(path, &newattrs, NULL);
 
 truncate_failed:
 	inode_unlock(d_inode(object->backer));
diff --git a/fs/coredump.c b/fs/coredump.c
index b1ea7dfbd149..69899bfb025a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -775,7 +775,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			goto close_fail;
 		if (!(cprm.file->f_mode & FMODE_CAN_WRITE))
 			goto close_fail;
-		if (do_truncate(cprm.file->f_path.dentry, 0, 0, cprm.file))
+		if (do_truncate(&cprm.file->f_path, 0, 0, cprm.file))
 			goto close_fail;
 	}
 
@@ -879,7 +879,7 @@ void dump_truncate(struct coredump_params *cprm)
 	if (file->f_op->llseek && file->f_op->llseek != no_llseek) {
 		offset = file->f_op->llseek(file, 0, SEEK_CUR);
 		if (i_size_read(file->f_mapping->host) < offset)
-			do_truncate(file->f_path.dentry, offset, 0, file);
+			do_truncate(&file->f_path, offset, 0, file);
 	}
 }
 EXPORT_SYMBOL(dump_truncate);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index e23752d9a79f..72c45b9419d0 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -852,10 +852,11 @@ int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
 
 	rc = truncate_upper(dentry, &ia, &lower_ia);
 	if (!rc && lower_ia.ia_valid & ATTR_SIZE) {
-		struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+		struct path *path = ecryptfs_dentry_to_lower_path(dentry);
+		struct dentry *lower_dentry = path->dentry;
 
 		inode_lock(d_inode(lower_dentry));
-		rc = notify_change(lower_dentry, &lower_ia, NULL);
+		rc = notify_change(path, &lower_ia, NULL);
 		inode_unlock(d_inode(lower_dentry));
 	}
 	return rc;
@@ -883,6 +884,7 @@ static int ecryptfs_setattr(struct dentry *dentry, struct iattr *ia)
 {
 	int rc = 0;
 	struct dentry *lower_dentry;
+	struct path *lower_path;
 	struct iattr lower_ia;
 	struct inode *inode;
 	struct inode *lower_inode;
@@ -897,6 +899,7 @@ static int ecryptfs_setattr(struct dentry *dentry, struct iattr *ia)
 	inode = d_inode(dentry);
 	lower_inode = ecryptfs_inode_to_lower(inode);
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_path = ecryptfs_dentry_to_lower_path(dentry);
 	mutex_lock(&crypt_stat->cs_mutex);
 	if (d_is_dir(dentry))
 		crypt_stat->flags &= ~(ECRYPTFS_ENCRYPTED);
@@ -959,7 +962,7 @@ static int ecryptfs_setattr(struct dentry *dentry, struct iattr *ia)
 		lower_ia.ia_valid &= ~ATTR_MODE;
 
 	inode_lock(d_inode(lower_dentry));
-	rc = notify_change(lower_dentry, &lower_ia, NULL);
+	rc = notify_change(lower_path, &lower_ia, NULL);
 	inode_unlock(d_inode(lower_dentry));
 out:
 	fsstack_copy_attr_all(inode, lower_inode);
diff --git a/fs/inode.c b/fs/inode.c
index fef457a42882..f2cc96ebede4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1810,7 +1810,7 @@ int dentry_needs_remove_privs(struct dentry *dentry)
 	return mask;
 }
 
-static int __remove_privs(struct dentry *dentry, int kill)
+static int __remove_privs(struct path *path, int kill)
 {
 	struct iattr newattrs;
 
@@ -1819,7 +1819,7 @@ static int __remove_privs(struct dentry *dentry, int kill)
 	 * Note we call this on write, so notify_change will not
 	 * encounter any conflicting delegations:
 	 */
-	return notify_change(dentry, &newattrs, NULL);
+	return notify_change(path, &newattrs, NULL);
 }
 
 /*
@@ -1828,6 +1828,7 @@ static int __remove_privs(struct dentry *dentry, int kill)
  */
 int file_remove_privs(struct file *file)
 {
+	struct path *path = &file->f_path;
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = file_inode(file);
 	int kill;
@@ -1846,7 +1847,7 @@ int file_remove_privs(struct file *file)
 	if (kill < 0)
 		return kill;
 	if (kill)
-		error = __remove_privs(dentry, kill);
+		error = __remove_privs(path, kill);
 	if (!error)
 		inode_has_no_xattr(inode);
 
diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..900c826161ef 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2995,7 +2995,7 @@ static int handle_truncate(struct file *filp)
 	if (!error)
 		error = security_path_truncate(path);
 	if (!error) {
-		error = do_truncate(path->dentry, 0,
+		error = do_truncate(path, 0,
 				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
 				    filp);
 	}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index bd0a385df3fc..5e758749cbc4 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -362,6 +362,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
+	const struct path *path;
 	int		accmode = NFSD_MAY_SATTR;
 	umode_t		ftype = 0;
 	__be32		err;
@@ -402,6 +403,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 
 	dentry = fhp->fh_dentry;
 	inode = d_inode(dentry);
+	path = &(struct path){
+		.mnt = fhp->fh_export->ex_path.mnt,
+		.dentry = dentry,
+	};
 
 	/* Ignore any mode updates on symlinks */
 	if (S_ISLNK(inode->i_mode))
@@ -442,7 +447,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 			.ia_size	= iap->ia_size,
 		};
 
-		host_err = notify_change(dentry, &size_attr, NULL);
+		host_err = notify_change(path, &size_attr, NULL);
 		if (host_err)
 			goto out_unlock;
 		iap->ia_valid &= ~ATTR_SIZE;
@@ -457,7 +462,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 	}
 
 	iap->ia_valid |= ATTR_CTIME;
-	host_err = notify_change(dentry, iap, NULL);
+	host_err = notify_change(path, iap, NULL);
 
 out_unlock:
 	fh_unlock(fhp);
diff --git a/fs/open.c b/fs/open.c
index b62f5c0923a8..033e2112fbda 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -35,11 +35,12 @@
 
 #include "internal.h"
 
-int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
+int do_truncate(const struct path *path, loff_t length, unsigned int time_attrs,
 	struct file *filp)
 {
 	int ret;
 	struct iattr newattrs;
+	struct dentry *dentry = path->dentry;
 
 	/* Not pretty: "inode->i_size" shouldn't really be signed. But it is. */
 	if (length < 0)
@@ -61,7 +62,7 @@ int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
 
 	inode_lock(dentry->d_inode);
 	/* Note any delegations or leases have already been broken: */
-	ret = notify_change(dentry, &newattrs, NULL);
+	ret = notify_change(path, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
 	return ret;
 }
@@ -107,7 +108,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 	if (!error)
 		error = security_path_truncate(path);
 	if (!error)
-		error = do_truncate(path->dentry, length, 0, NULL);
+		error = do_truncate(path, length, 0, NULL);
 
 put_write_and_out:
 	put_write_access(inode);
@@ -155,7 +156,7 @@ COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 {
 	struct inode *inode;
-	struct dentry *dentry;
+	struct path *path;
 	struct fd f;
 	int error;
 
@@ -171,8 +172,8 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	if (f.file->f_flags & O_LARGEFILE)
 		small = 0;
 
-	dentry = f.file->f_path.dentry;
-	inode = dentry->d_inode;
+	path = &f.file->f_path;
+	inode = path->dentry->d_inode;
 	error = -EINVAL;
 	if (!S_ISREG(inode->i_mode) || !(f.file->f_mode & FMODE_WRITE))
 		goto out_putf;
@@ -192,7 +193,7 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	if (!error)
 		error = security_path_truncate(&f.file->f_path);
 	if (!error)
-		error = do_truncate(dentry, length, ATTR_MTIME|ATTR_CTIME, f.file);
+		error = do_truncate(path, length, ATTR_MTIME|ATTR_CTIME, f.file);
 	sb_end_write(inode->i_sb);
 out_putf:
 	fdput(f);
@@ -558,7 +559,7 @@ static int chmod_common(const struct path *path, umode_t mode)
 		goto out_unlock;
 	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
 	newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-	error = notify_change(path->dentry, &newattrs, &delegated_inode);
+	error = notify_change(path, &newattrs, &delegated_inode);
 out_unlock:
 	inode_unlock(inode);
 	if (delegated_inode) {
@@ -649,7 +650,7 @@ static int chown_common(const struct path *path, uid_t user, gid_t group)
 	inode_lock(inode);
 	error = security_path_chown(path, uid, gid);
 	if (!error)
-		error = notify_change(path->dentry, &newattrs, &delegated_inode);
+		error = notify_change(path, &newattrs, &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b801c6353100..52bfca5016fe 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -177,17 +177,17 @@ static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
 	return error;
 }
 
-static int ovl_set_size(struct dentry *upperdentry, struct kstat *stat)
+static int ovl_set_size(struct path *upperpath, struct kstat *stat)
 {
 	struct iattr attr = {
 		.ia_valid = ATTR_SIZE,
 		.ia_size = stat->size,
 	};
 
-	return notify_change(upperdentry, &attr, NULL);
+	return notify_change(upperpath, &attr, NULL);
 }
 
-static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
+static int ovl_set_timestamps(struct path *upperpath, struct kstat *stat)
 {
 	struct iattr attr = {
 		.ia_valid =
@@ -196,10 +196,10 @@ static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
 		.ia_mtime = stat->mtime,
 	};
 
-	return notify_change(upperdentry, &attr, NULL);
+	return notify_change(upperpath, &attr, NULL);
 }
 
-int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
+int ovl_set_attr(struct path *upperpath, struct kstat *stat)
 {
 	int err = 0;
 
@@ -208,7 +208,7 @@ int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
 			.ia_valid = ATTR_MODE,
 			.ia_mode = stat->mode,
 		};
-		err = notify_change(upperdentry, &attr, NULL);
+		err = notify_change(upperpath, &attr, NULL);
 	}
 	if (!err) {
 		struct iattr attr = {
@@ -216,10 +216,10 @@ int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
 			.ia_uid = stat->uid,
 			.ia_gid = stat->gid,
 		};
-		err = notify_change(upperdentry, &attr, NULL);
+		err = notify_change(upperpath, &attr, NULL);
 	}
 	if (!err)
-		ovl_set_timestamps(upperdentry, stat);
+		ovl_set_timestamps(upperpath, stat);
 
 	return err;
 }
@@ -389,7 +389,7 @@ struct ovl_copy_up_ctx {
 	struct kstat stat;
 	struct kstat pstat;
 	const char *link;
-	struct dentry *destdir;
+	struct path *destpath;
 	struct qstr destname;
 	struct dentry *workdir;
 	bool origin;
@@ -403,6 +403,9 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 	struct dentry *upper;
 	struct dentry *upperdir = ovl_dentry_upper(c->parent);
 	struct inode *udir = d_inode(upperdir);
+	struct path upperpath;
+
+	ovl_path_upper(c->parent, &upperpath);
 
 	/* Mark parent "impure" because it may now contain non-pure upper */
 	err = ovl_set_impure(c->parent, upperdir);
@@ -423,7 +426,7 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 
 		if (!err) {
 			/* Restore timestamps on parent (best effort) */
-			ovl_set_timestamps(upperdir, &c->pstat);
+			ovl_set_timestamps(&upperpath, &c->pstat);
 			ovl_dentry_set_upper_alias(c->dentry);
 		}
 	}
@@ -439,7 +442,9 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
 {
 	int err;
+	struct path upperpath, *path;
 
+	ovl_path_upper(c->dentry, &upperpath);
 	/*
 	 * Copy up data first and then xattrs. Writing data after
 	 * xattrs will remove security.capability xattr automatically.
@@ -447,7 +452,6 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
 	if (S_ISREG(c->stat.mode) && !c->metacopy) {
 		struct path upperpath, datapath;
 
-		ovl_path_upper(c->dentry, &upperpath);
 		if (WARN_ON(upperpath.dentry != NULL))
 			return -EIO;
 		upperpath.dentry = temp;
@@ -481,12 +485,13 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
 		if (err)
 			return err;
 	}
+	path = &(struct path) {	.mnt = upperpath.mnt, .dentry = temp };
 
 	inode_lock(temp->d_inode);
 	if (c->metacopy)
-		err = ovl_set_size(temp, &c->stat);
+		err = ovl_set_size(path, &c->stat);
 	if (!err)
-		err = ovl_set_attr(temp, &c->stat);
+		err = ovl_set_attr(path, &c->stat);
 	inode_unlock(temp->d_inode);
 
 	return err;
@@ -527,7 +532,7 @@ static void ovl_revert_cu_creds(struct ovl_cu_creds *cc)
 static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 {
 	struct inode *inode;
-	struct inode *udir = d_inode(c->destdir), *wdir = d_inode(c->workdir);
+	struct inode *udir = d_inode(c->destpath->dentry), *wdir = d_inode(c->workdir);
 	struct dentry *temp, *upper;
 	struct ovl_cu_creds cc;
 	int err;
@@ -538,7 +543,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		.link = c->link
 	};
 
-	err = ovl_lock_rename_workdir(c->workdir, c->destdir);
+	err = ovl_lock_rename_workdir(c->workdir, c->destpath->dentry);
 	if (err)
 		return err;
 
@@ -563,7 +568,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 			goto cleanup;
 	}
 
-	upper = lookup_one_len(c->destname.name, c->destdir, c->destname.len);
+	upper = lookup_one_len(c->destname.name, c->destpath->dentry, c->destname.len);
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
 		goto cleanup;
@@ -580,7 +585,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
 unlock:
-	unlock_rename(c->workdir, c->destdir);
+	unlock_rename(c->workdir, c->destpath->dentry);
 
 	return err;
 
@@ -593,7 +598,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 /* Copyup using O_TMPFILE which does not require cross dir locking */
 static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 {
-	struct inode *udir = d_inode(c->destdir);
+	struct inode *udir = d_inode(c->destpath->dentry);
 	struct dentry *temp, *upper;
 	struct ovl_cu_creds cc;
 	int err;
@@ -614,7 +619,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 
 	inode_lock_nested(udir, I_MUTEX_PARENT);
 
-	upper = lookup_one_len(c->destname.name, c->destdir, c->destname.len);
+	upper = lookup_one_len(c->destname.name, c->destpath->dentry, c->destname.len);
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(temp, udir, upper);
@@ -650,6 +655,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 	int err;
 	struct ovl_fs *ofs = c->dentry->d_sb->s_fs_info;
 	bool to_index = false;
+	struct path path;
 
 	/*
 	 * Indexed non-dir is copied up directly to the index entry and then
@@ -669,7 +675,9 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		c->origin = true;
 
 	if (to_index) {
-		c->destdir = ovl_indexdir(c->dentry->d_sb);
+		path.dentry = ovl_indexdir(c->dentry->d_sb);
+		path.mnt = ofs->upper_mnt;
+		c->destpath = &path;
 		err = ovl_get_index_name(c->lowerpath.dentry, &c->destname);
 		if (err)
 			return err;
@@ -681,7 +689,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		 * Mark parent "impure" because it may now contain non-pure
 		 * upper
 		 */
-		err = ovl_set_impure(c->parent, c->destdir);
+		err = ovl_set_impure(c->parent, c->destpath->dentry);
 		if (err)
 			return err;
 	}
@@ -701,19 +709,21 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		/* Initialize nlink for copy up of disconnected dentry */
 		err = ovl_set_nlink_upper(c->dentry);
 	} else {
-		struct inode *udir = d_inode(c->destdir);
+		struct inode *udir = d_inode(c->destpath->dentry);
 
 		/* Restore timestamps on parent (best effort) */
 		inode_lock(udir);
-		ovl_set_timestamps(c->destdir, &c->pstat);
+		ovl_set_timestamps(c->destpath, &c->pstat);
 		inode_unlock(udir);
 
 		ovl_dentry_set_upper_alias(c->dentry);
 	}
 
 out:
-	if (to_index)
+	if (to_index) {
 		kfree(c->destname.name);
+		c->destpath = NULL;
+	}
 	return err;
 }
 
@@ -809,7 +819,7 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 
 	if (parent) {
 		ovl_path_upper(parent, &parentpath);
-		ctx.destdir = parentpath.dentry;
+		ctx.destpath = &parentpath;
 		ctx.destname = dentry->d_name;
 
 		err = vfs_getattr(&parentpath, &ctx.pstat,
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 702aa63f6774..d694c5740bdb 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -334,7 +334,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	struct inode *wdir = workdir->d_inode;
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
 	struct inode *udir = upperdir->d_inode;
-	struct path upperpath;
+	struct path upperpath, *opaquepath;
 	struct dentry *upper;
 	struct dentry *opaquedir;
 	struct kstat stat;
@@ -373,8 +373,13 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (err)
 		goto out_cleanup;
 
+	opaquepath = &(struct path){
+		.mnt = upperpath.mnt,
+		.dentry = opaquedir
+	};
+
 	inode_lock(opaquedir->d_inode);
-	err = ovl_set_attr(opaquedir, &stat);
+	err = ovl_set_attr(opaquepath, &stat);
 	inode_unlock(opaquedir->d_inode);
 	if (err)
 		goto out_cleanup;
@@ -435,10 +440,13 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	struct inode *udir = upperdir->d_inode;
 	struct dentry *upper;
 	struct dentry *newdentry;
+	struct path path;
 	int err;
 	struct posix_acl *acl, *default_acl;
 	bool hardlink = !!cattr->hardlink;
 
+	ovl_path_upper(dentry, &path);
+
 	if (WARN_ON(!workdir))
 		return -EROFS;
 
@@ -478,8 +486,10 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 			.ia_valid = ATTR_MODE,
 			.ia_mode = cattr->mode,
 		};
+
+		path.dentry = newdentry;
 		inode_lock(newdentry->d_inode);
-		err = notify_change(newdentry, &attr, NULL);
+		err = notify_change(&path, &attr, NULL);
 		inode_unlock(newdentry->d_inode);
 		if (err)
 			goto out_cleanup;
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index bc14781886bf..218540003872 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -45,8 +45,10 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 		err = ovl_copy_up_with_data(dentry);
 	if (!err) {
 		struct inode *winode = NULL;
+		struct path path;
 
-		upperdentry = ovl_dentry_upper(dentry);
+		ovl_path_upper(dentry, &path);
+		upperdentry = path.dentry;
 
 		if (attr->ia_valid & ATTR_SIZE) {
 			winode = d_inode(upperdentry);
@@ -60,7 +62,7 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 
 		inode_lock(upperdentry->d_inode);
 		old_cred = ovl_override_creds(dentry->d_sb);
-		err = notify_change(upperdentry, attr, NULL);
+		err = notify_change(&path, attr, NULL);
 		revert_creds(old_cred);
 		if (!err)
 			ovl_copyattr(upperdentry->d_inode, dentry->d_inode);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6934bcf030f0..dc50b97a5e68 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -423,7 +423,7 @@ int ovl_copy_up_with_data(struct dentry *dentry);
 int ovl_copy_up_flags(struct dentry *dentry, int flags);
 int ovl_maybe_copy_up(struct dentry *dentry, int flags);
 int ovl_copy_xattr(struct dentry *old, struct dentry *new);
-int ovl_set_attr(struct dentry *upper, struct kstat *stat);
+int ovl_set_attr(struct path *upper, struct kstat *stat);
 struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper);
 int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
 		   struct dentry *upper);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index afbcb116a7f1..03b6d4a9d43a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -632,6 +632,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 			.ia_valid = ATTR_MODE,
 			.ia_mode = S_IFDIR | 0,
 		};
+		const struct path path = { .mnt = mnt, .dentry = work };
 
 		if (work->d_inode) {
 			err = -EEXIST;
@@ -675,7 +676,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 
 		/* Clear any inherited mode bits */
 		inode_lock(work->d_inode);
-		err = notify_change(work, &attr, NULL);
+		err = notify_change(&path, &attr, NULL);
 		inode_unlock(work->d_inode);
 		if (err)
 			goto out_dput;
diff --git a/fs/utimes.c b/fs/utimes.c
index 1ba3f7883870..87da3e974a75 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -57,7 +57,7 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
 	}
 retry_deleg:
 	inode_lock(inode);
-	error = notify_change(path->dentry, &newattrs, &delegated_inode);
+	error = notify_change(path, &newattrs, &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 51f1408180f5..96356b884de7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2519,8 +2519,8 @@ struct filename {
 static_assert(offsetof(struct filename, iname) % sizeof(long) == 0);
 
 extern long vfs_truncate(const struct path *, loff_t);
-extern int do_truncate(struct dentry *, loff_t start, unsigned int time_attrs,
-		       struct file *filp);
+extern int do_truncate(const struct path *p, loff_t start,
+		       unsigned int time_attrs, struct file *filp);
 extern int vfs_fallocate(struct file *file, int mode, loff_t offset,
 			loff_t len);
 extern long do_sys_open(int dfd, const char __user *filename, int flags,
@@ -2867,7 +2867,7 @@ extern void emergency_remount(void);
 #ifdef CONFIG_BLOCK
 extern sector_t bmap(struct inode *, sector_t);
 #endif
-extern int notify_change(struct dentry *, struct iattr *, struct inode **);
+extern int notify_change(const struct path *, struct iattr *, struct inode **);
 extern int inode_permission(struct inode *, int);
 extern int generic_permission(struct inode *, int);
 extern int __check_sticky(struct inode *dir, struct inode *inode);
-- 
2.16.4

