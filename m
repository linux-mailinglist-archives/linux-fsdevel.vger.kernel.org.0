Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499916F7E77
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 10:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjEEINh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 04:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjEEINg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 04:13:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843FC17FF5;
        Fri,  5 May 2023 01:13:33 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QCNd23hW8zpV1Q;
        Fri,  5 May 2023 16:09:26 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:13:31 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <dhowells@redhat.com>, <code@tyhicks.com>,
        <hirofumi@mail.parknet.co.jp>, <linkinjeon@kernel.org>,
        <sfrench@samba.org>, <senozhatsky@chromium.org>, <tom@talpey.com>,
        <chuck.lever@oracle.com>, <jlayton@kernel.org>,
        <miklos@szeredi.hu>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>, <casey@schaufler-ca.com>,
        <dchinner@redhat.com>, <john.johansen@canonical.com>,
        <mcgrof@kernel.org>, <mortonm@chromium.org>, <fred@cloudflare.com>,
        <mic@digikod.net>, <mpe@ellerman.id.au>, <nathanl@linux.ibm.com>,
        <gnoack3000@gmail.com>, <roberto.sassu@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-cachefs@redhat.com>, <ecryptfs@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-unionfs@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next 1/2] fs: Change notify_change() to take struct path argument
Date:   Fri, 5 May 2023 16:11:59 +0800
Message-ID: <20230505081200.254449-2-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230505081200.254449-1-xiujianfeng@huawei.com>
References: <20230505081200.254449-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For path-based LSMs such as Landlock, struct path instead of struct
dentry is required to make sense of attr/xattr accesses. notify_change()
is the main caller of security_inode_setattr(), so refactor it first
before lsm hook inode_setattr().

This patch also touches do_truncate() and other related callers.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/base/devtmpfs.c   |  5 +++--
 fs/attr.c                 |  5 +++--
 fs/cachefiles/interface.c |  4 ++--
 fs/coredump.c             |  2 +-
 fs/ecryptfs/inode.c       | 18 +++++++++---------
 fs/inode.c                |  8 +++++---
 fs/ksmbd/smb2pdu.c        |  6 +++---
 fs/ksmbd/smbacl.c         |  2 +-
 fs/namei.c                |  2 +-
 fs/nfsd/vfs.c             | 12 ++++++++----
 fs/open.c                 | 19 ++++++++++---------
 fs/overlayfs/overlayfs.h  |  4 +++-
 fs/utimes.c               |  2 +-
 include/linux/fs.h        |  4 ++--
 14 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index b848764ef018..e67dd258984c 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -220,13 +220,14 @@ static int handle_create(const char *nodename, umode_t mode, kuid_t uid,
 			dev->devt);
 	if (!err) {
 		struct iattr newattrs;
+		struct path new = { .mnt = path.mnt, .dentry = dentry };
 
 		newattrs.ia_mode = mode;
 		newattrs.ia_uid = uid;
 		newattrs.ia_gid = gid;
 		newattrs.ia_valid = ATTR_MODE|ATTR_UID|ATTR_GID;
 		inode_lock(d_inode(dentry));
-		notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
+		notify_change(&nop_mnt_idmap, &new, &newattrs, NULL);
 		inode_unlock(d_inode(dentry));
 
 		/* mark as kernel-created inode */
@@ -334,7 +335,7 @@ static int handle_remove(const char *nodename, struct device *dev)
 			newattrs.ia_valid =
 				ATTR_UID|ATTR_GID|ATTR_MODE;
 			inode_lock(d_inode(dentry));
-			notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
+			notify_change(&nop_mnt_idmap, &p, &newattrs, NULL);
 			inode_unlock(d_inode(dentry));
 			err = vfs_unlink(&nop_mnt_idmap, d_inode(parent.dentry),
 					 dentry, NULL);
diff --git a/fs/attr.c b/fs/attr.c
index d60dc1edb526..eecd78944b83 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -354,7 +354,7 @@ EXPORT_SYMBOL(may_setattr);
 /**
  * notify_change - modify attributes of a filesytem object
  * @idmap:	idmap of the mount the inode was found from
- * @dentry:	object affected
+ * @path:	path of object affected
  * @attr:	new attributes
  * @delegated_inode: returns inode, if the inode is delegated
  *
@@ -378,9 +378,10 @@ EXPORT_SYMBOL(may_setattr);
  * permissions. On non-idmapped mounts or if permission checking is to be
  * performed on the raw inode simply pass @nop_mnt_idmap.
  */
-int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
+int notify_change(struct mnt_idmap *idmap, const struct path *path,
 		  struct iattr *attr, struct inode **delegated_inode)
 {
+	struct dentry *dentry = path->dentry;
 	struct inode *inode = dentry->d_inode;
 	umode_t mode = inode->i_mode;
 	int error;
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 40052bdb3365..4700285a76f0 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -138,7 +138,7 @@ static int cachefiles_adjust_size(struct cachefiles_object *object)
 		newattrs.ia_size = oi_size & PAGE_MASK;
 		ret = cachefiles_inject_remove_error();
 		if (ret == 0)
-			ret = notify_change(&nop_mnt_idmap, file->f_path.dentry,
+			ret = notify_change(&nop_mnt_idmap, &file->f_path,
 					    &newattrs, NULL);
 		if (ret < 0)
 			goto truncate_failed;
@@ -148,7 +148,7 @@ static int cachefiles_adjust_size(struct cachefiles_object *object)
 	newattrs.ia_size = ni_size;
 	ret = cachefiles_inject_write_error();
 	if (ret == 0)
-		ret = notify_change(&nop_mnt_idmap, file->f_path.dentry,
+		ret = notify_change(&nop_mnt_idmap, &file->f_path,
 				    &newattrs, NULL);
 
 truncate_failed:
diff --git a/fs/coredump.c b/fs/coredump.c
index ece7badf701b..01bef4830bfa 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -736,7 +736,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 		if (!(cprm.file->f_mode & FMODE_CAN_WRITE))
 			goto close_fail;
-		if (do_truncate(idmap, cprm.file->f_path.dentry,
+		if (do_truncate(idmap, &cprm.file->f_path,
 				0, 0, cprm.file))
 			goto close_fail;
 	}
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 83274915ba6d..423bd457623e 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -853,12 +853,12 @@ int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
 
 	rc = truncate_upper(dentry, &ia, &lower_ia);
 	if (!rc && lower_ia.ia_valid & ATTR_SIZE) {
-		struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+		const struct path *lower_path = ecryptfs_dentry_to_lower_path(dentry);
 
-		inode_lock(d_inode(lower_dentry));
-		rc = notify_change(&nop_mnt_idmap, lower_dentry,
+		inode_lock(d_inode(lower_path->dentry));
+		rc = notify_change(&nop_mnt_idmap, lower_path,
 				   &lower_ia, NULL);
-		inode_unlock(d_inode(lower_dentry));
+		inode_unlock(d_inode(lower_path->dentry));
 	}
 	return rc;
 }
@@ -888,7 +888,7 @@ static int ecryptfs_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct iattr *ia)
 {
 	int rc = 0;
-	struct dentry *lower_dentry;
+	const struct path *lower_path;
 	struct iattr lower_ia;
 	struct inode *inode;
 	struct inode *lower_inode;
@@ -902,7 +902,7 @@ static int ecryptfs_setattr(struct mnt_idmap *idmap,
 	}
 	inode = d_inode(dentry);
 	lower_inode = ecryptfs_inode_to_lower(inode);
-	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	lower_path = ecryptfs_dentry_to_lower_path(dentry);
 	mutex_lock(&crypt_stat->cs_mutex);
 	if (d_is_dir(dentry))
 		crypt_stat->flags &= ~(ECRYPTFS_ENCRYPTED);
@@ -964,9 +964,9 @@ static int ecryptfs_setattr(struct mnt_idmap *idmap,
 	if (lower_ia.ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))
 		lower_ia.ia_valid &= ~ATTR_MODE;
 
-	inode_lock(d_inode(lower_dentry));
-	rc = notify_change(&nop_mnt_idmap, lower_dentry, &lower_ia, NULL);
-	inode_unlock(d_inode(lower_dentry));
+	inode_lock(d_inode(lower_path->dentry));
+	rc = notify_change(&nop_mnt_idmap, lower_path, &lower_ia, NULL);
+	inode_unlock(d_inode(lower_path->dentry));
 out:
 	fsstack_copy_attr_all(inode, lower_inode);
 	return rc;
diff --git a/fs/inode.c b/fs/inode.c
index 577799b7855f..4fa51d46f655 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1973,7 +1973,7 @@ int dentry_needs_remove_privs(struct mnt_idmap *idmap,
 }
 
 static int __remove_privs(struct mnt_idmap *idmap,
-			  struct dentry *dentry, int kill)
+			  struct path *path, int kill)
 {
 	struct iattr newattrs;
 
@@ -1982,13 +1982,15 @@ static int __remove_privs(struct mnt_idmap *idmap,
 	 * Note we call this on write, so notify_change will not
 	 * encounter any conflicting delegations:
 	 */
-	return notify_change(idmap, dentry, &newattrs, NULL);
+	return notify_change(idmap, path, &newattrs, NULL);
 }
 
 static int __file_remove_privs(struct file *file, unsigned int flags)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = file_inode(file);
+	/* this path maybe incorrect */
+	struct path path = {.mnt = file->f_path.mnt, .dentry = dentry};
 	int error = 0;
 	int kill;
 
@@ -2003,7 +2005,7 @@ static int __file_remove_privs(struct file *file, unsigned int flags)
 		if (flags & IOCB_NOWAIT)
 			return -EAGAIN;
 
-		error = __remove_privs(file_mnt_idmap(file), dentry, kill);
+		error = __remove_privs(file_mnt_idmap(file), &path, kill);
 	}
 
 	if (!error)
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index cb93fd231f4e..2b7e5c446397 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5644,8 +5644,8 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 	}
 
 	if (attrs.ia_valid) {
-		struct dentry *dentry = filp->f_path.dentry;
-		struct inode *inode = d_inode(dentry);
+		struct path *path = &filp->f_path;
+		struct inode *inode = d_inode(path->dentry);
 
 		if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 			return -EACCES;
@@ -5653,7 +5653,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 		inode_lock(inode);
 		inode->i_ctime = attrs.ia_ctime;
 		attrs.ia_valid &= ~ATTR_CTIME;
-		rc = notify_change(idmap, dentry, &attrs, NULL);
+		rc = notify_change(idmap, path, &attrs, NULL);
 		inode_unlock(inode);
 	}
 	return rc;
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 6d6cfb6957a9..39d8aff3ae1b 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1403,7 +1403,7 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	}
 
 	inode_lock(inode);
-	rc = notify_change(idmap, path->dentry, &newattrs, NULL);
+	rc = notify_change(idmap, path, &newattrs, NULL);
 	inode_unlock(inode);
 	if (rc)
 		goto out;
diff --git a/fs/namei.c b/fs/namei.c
index e4fe0879ae55..ec7075a8505d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3292,7 +3292,7 @@ static int handle_truncate(struct mnt_idmap *idmap, struct file *filp)
 
 	error = security_file_truncate(filp);
 	if (!error) {
-		error = do_truncate(idmap, path->dentry, 0,
+		error = do_truncate(idmap, path, 0,
 				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
 				    filp);
 	}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index bb9d47172162..4b51fd2f05e3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -410,7 +410,7 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return nfserrno(get_write_access(inode));
 }
 
-static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
+static int __nfsd_setattr(struct path *path, struct iattr *iap)
 {
 	int host_err;
 
@@ -430,7 +430,7 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
 		if (iap->ia_size < 0)
 			return -EFBIG;
 
-		host_err = notify_change(&nop_mnt_idmap, dentry, &size_attr, NULL);
+		host_err = notify_change(&nop_mnt_idmap, path, &size_attr, NULL);
 		if (host_err)
 			return host_err;
 		iap->ia_valid &= ~ATTR_SIZE;
@@ -448,7 +448,7 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
 		return 0;
 
 	iap->ia_valid |= ATTR_CTIME;
-	return notify_change(&nop_mnt_idmap, dentry, iap, NULL);
+	return notify_change(&nop_mnt_idmap, path, iap, NULL);
 }
 
 /**
@@ -471,6 +471,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	     struct nfsd_attrs *attr,
 	     int check_guard, time64_t guardtime)
 {
+	struct path path;
 	struct dentry	*dentry;
 	struct inode	*inode;
 	struct iattr	*iap = attr->na_iattr;
@@ -534,9 +535,12 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			return err;
 	}
 
+	path.mnt = fhp->fh_export->ex_path.mnt;
+	path.dentry = fhp->fh_dentry;
+
 	inode_lock(inode);
 	for (retries = 1;;) {
-		host_err = __nfsd_setattr(dentry, iap);
+		host_err = __nfsd_setattr(&path, iap);
 		if (host_err != -EAGAIN || !retries--)
 			break;
 		if (!nfsd_wait_for_delegreturn(rqstp, inode))
diff --git a/fs/open.c b/fs/open.c
index 4478adcc4f3a..7a7841606285 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -37,11 +37,12 @@
 
 #include "internal.h"
 
-int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
+int do_truncate(struct mnt_idmap *idmap, const struct path *path,
 		loff_t length, unsigned int time_attrs, struct file *filp)
 {
 	int ret;
 	struct iattr newattrs;
+	struct dentry *dentry = path->dentry;
 
 	/* Not pretty: "inode->i_size" shouldn't really be signed. But it is. */
 	if (length < 0)
@@ -63,7 +64,7 @@ int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	inode_lock(dentry->d_inode);
 	/* Note any delegations or leases have already been broken: */
-	ret = notify_change(idmap, dentry, &newattrs, NULL);
+	ret = notify_change(idmap, path, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
 	return ret;
 }
@@ -109,7 +110,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 
 	error = security_path_truncate(path);
 	if (!error)
-		error = do_truncate(idmap, path->dentry, length, 0, NULL);
+		error = do_truncate(idmap, path, length, 0, NULL);
 
 put_write_and_out:
 	put_write_access(inode);
@@ -157,7 +158,7 @@ COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 {
 	struct inode *inode;
-	struct dentry *dentry;
+	struct path *path;
 	struct fd f;
 	int error;
 
@@ -173,8 +174,8 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	if (f.file->f_flags & O_LARGEFILE)
 		small = 0;
 
-	dentry = f.file->f_path.dentry;
-	inode = dentry->d_inode;
+	path = &f.file->f_path;
+	inode = d_inode(path->dentry);
 	error = -EINVAL;
 	if (!S_ISREG(inode->i_mode) || !(f.file->f_mode & FMODE_WRITE))
 		goto out_putf;
@@ -191,7 +192,7 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	sb_start_write(inode->i_sb);
 	error = security_file_truncate(f.file);
 	if (!error)
-		error = do_truncate(file_mnt_idmap(f.file), dentry, length,
+		error = do_truncate(file_mnt_idmap(f.file), path, length,
 				    ATTR_MTIME | ATTR_CTIME, f.file);
 	sb_end_write(inode->i_sb);
 out_putf:
@@ -640,7 +641,7 @@ int chmod_common(const struct path *path, umode_t mode)
 		goto out_unlock;
 	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
 	newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-	error = notify_change(mnt_idmap(path->mnt), path->dentry,
+	error = notify_change(mnt_idmap(path->mnt), path,
 			      &newattrs, &delegated_inode);
 out_unlock:
 	inode_unlock(inode);
@@ -771,7 +772,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 		from_vfsuid(idmap, fs_userns, newattrs.ia_vfsuid),
 		from_vfsgid(idmap, fs_userns, newattrs.ia_vfsgid));
 	if (!error)
-		error = notify_change(idmap, path->dentry, &newattrs,
+		error = notify_change(idmap, path, &newattrs,
 				      &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 4d0b278f5630..d1a1eaa1c00c 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -141,7 +141,9 @@ static inline int ovl_do_notify_change(struct ovl_fs *ofs,
 				       struct dentry *upperdentry,
 				       struct iattr *attr)
 {
-	return notify_change(ovl_upper_mnt_idmap(ofs), upperdentry, attr, NULL);
+	struct path path = { .mnt = ovl_upper_mnt(ofs), .dentry = upperdentry };
+
+	return notify_change(ovl_upper_mnt_idmap(ofs), &path, attr, NULL);
 }
 
 static inline int ovl_do_rmdir(struct ovl_fs *ofs,
diff --git a/fs/utimes.c b/fs/utimes.c
index 3701b3946f88..1e6b82b27899 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -63,7 +63,7 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 	}
 retry_deleg:
 	inode_lock(inode);
-	error = notify_change(mnt_idmap(path->mnt), path->dentry, &newattrs,
+	error = notify_change(mnt_idmap(path->mnt), path, &newattrs,
 			      &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..dbba36ab4a1b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2333,7 +2333,7 @@ static inline bool is_idmapped_mnt(const struct vfsmount *mnt)
 }
 
 extern long vfs_truncate(const struct path *, loff_t);
-int do_truncate(struct mnt_idmap *, struct dentry *, loff_t start,
+int do_truncate(struct mnt_idmap *, const struct path *, loff_t start,
 		unsigned int time_attrs, struct file *filp);
 extern int vfs_fallocate(struct file *file, int mode, loff_t offset,
 			loff_t len);
@@ -2488,7 +2488,7 @@ static inline int bmap(struct inode *inode,  sector_t *block)
 }
 #endif
 
-int notify_change(struct mnt_idmap *, struct dentry *,
+int notify_change(struct mnt_idmap *, const struct path *,
 		  struct iattr *, struct inode **);
 int inode_permission(struct mnt_idmap *, struct inode *, int);
 int generic_permission(struct mnt_idmap *, struct inode *, int);
-- 
2.17.1

