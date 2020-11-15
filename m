Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228192B33F6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 11:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgKOKj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 05:39:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58933 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgKOKjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:39:03 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1keFQp-0000Kt-St; Sun, 15 Nov 2020 10:38:52 +0000
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
        Tycho Andersen <tycho@tycho.pizza>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 13/39] xattr: handle idmapped mounts
Date:   Sun, 15 Nov 2020 11:36:52 +0100
Message-Id: <20201115103718.298186-14-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115103718.298186-1-christian.brauner@ubuntu.com>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tycho Andersen <tycho@tycho.pizza>

When interacting with extended attributes the vfs verifies that the caller
is privileged over the inode with which the extended attribute is
associated. For posix access and posix default extended attributes a uid or
gid can be stored on-disk. Let the functions handle posix extended
attributes on idmapped mounts. If the inode is accessed through an idmapped
mount we need to map it according to the mount's user namespace. Afterwards
the checks are identical to non-idmapped mounts. This has no effect for
e.g. security xattrs that are set since no filesystem performs checks based
on the uid and gid of the inode as the vfs will have already done.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig:
  - Don't pollute the vfs with additional helpers simply extend the existing
    helpers with an additional argument and switch all callers.
---
 fs/cachefiles/xattr.c                 |  16 ++--
 fs/ecryptfs/crypto.c                  |   4 +-
 fs/ecryptfs/inode.c                   |   4 +-
 fs/ecryptfs/mmap.c                    |   4 +-
 fs/nfsd/vfs.c                         |  12 +--
 fs/overlayfs/copy_up.c                |  12 +--
 fs/overlayfs/dir.c                    |   2 +-
 fs/overlayfs/inode.c                  |   8 +-
 fs/overlayfs/overlayfs.h              |   6 +-
 fs/overlayfs/super.c                  |   4 +-
 fs/xattr.c                            | 120 +++++++++++++++-----------
 include/linux/xattr.h                 |  24 ++++--
 security/apparmor/domain.c            |   4 +-
 security/commoncap.c                  |   6 +-
 security/integrity/evm/evm_crypto.c   |  11 +--
 security/integrity/evm/evm_main.c     |   4 +-
 security/integrity/ima/ima_appraise.c |   8 +-
 security/selinux/hooks.c              |   2 +-
 security/smack/smack_lsm.c            |   4 +-
 19 files changed, 143 insertions(+), 112 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 72e42438f3d7..3b6a3f1610f4 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -39,7 +39,7 @@ int cachefiles_check_object_type(struct cachefiles_object *object)
 	_enter("%p{%s}", object, type);
 
 	/* attempt to install a type label directly */
-	ret = vfs_setxattr(dentry, cachefiles_xattr_cache, type, 2,
+	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache, type, 2,
 			   XATTR_CREATE);
 	if (ret == 0) {
 		_debug("SET"); /* we succeeded */
@@ -54,7 +54,7 @@ int cachefiles_check_object_type(struct cachefiles_object *object)
 	}
 
 	/* read the current type label */
-	ret = vfs_getxattr(dentry, cachefiles_xattr_cache, xtype, 3);
+	ret = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, xtype, 3);
 	if (ret < 0) {
 		if (ret == -ERANGE)
 			goto bad_type_length;
@@ -110,7 +110,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object,
 	_debug("SET #%u", auxdata->len);
 
 	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
-	ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
+	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
 			   &auxdata->type, auxdata->len,
 			   XATTR_CREATE);
 	if (ret < 0 && ret != -ENOMEM)
@@ -140,7 +140,7 @@ int cachefiles_update_object_xattr(struct cachefiles_object *object,
 	_debug("SET #%u", auxdata->len);
 
 	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
-	ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
+	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
 			   &auxdata->type, auxdata->len,
 			   XATTR_REPLACE);
 	if (ret < 0 && ret != -ENOMEM)
@@ -171,7 +171,7 @@ int cachefiles_check_auxdata(struct cachefiles_object *object)
 	if (!auxbuf)
 		return -ENOMEM;
 
-	xlen = vfs_getxattr(dentry, cachefiles_xattr_cache,
+	xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
 			    &auxbuf->type, 512 + 1);
 	ret = -ESTALE;
 	if (xlen < 1 ||
@@ -213,7 +213,7 @@ int cachefiles_check_object_xattr(struct cachefiles_object *object,
 	}
 
 	/* read the current type label */
-	ret = vfs_getxattr(dentry, cachefiles_xattr_cache,
+	ret = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
 			   &auxbuf->type, 512 + 1);
 	if (ret < 0) {
 		if (ret == -ENODATA)
@@ -270,7 +270,7 @@ int cachefiles_check_object_xattr(struct cachefiles_object *object,
 		}
 
 		/* update the current label */
-		ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
+		ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
 				   &auxdata->type, auxdata->len,
 				   XATTR_REPLACE);
 		if (ret < 0) {
@@ -309,7 +309,7 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 {
 	int ret;
 
-	ret = vfs_removexattr(dentry, cachefiles_xattr_cache);
+	ret = vfs_removexattr(&init_user_ns, dentry, cachefiles_xattr_cache);
 	if (ret < 0) {
 		if (ret == -ENOENT || ret == -ENODATA)
 			ret = 0;
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 0681540c48d9..943e523f4c9d 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1110,8 +1110,8 @@ ecryptfs_write_metadata_to_xattr(struct dentry *ecryptfs_dentry,
 	}
 
 	inode_lock(lower_inode);
-	rc = __vfs_setxattr(lower_dentry, lower_inode, ECRYPTFS_XATTR_NAME,
-			    page_virt, size, 0);
+	rc = __vfs_setxattr(&init_user_ns, lower_dentry, lower_inode,
+			    ECRYPTFS_XATTR_NAME, page_virt, size, 0);
 	if (!rc && ecryptfs_inode)
 		fsstack_copy_attr_all(ecryptfs_inode, lower_inode);
 	inode_unlock(lower_inode);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 28cf830f0a4d..c35c2d2f3fe6 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1022,7 +1022,7 @@ ecryptfs_setxattr(struct dentry *dentry, struct inode *inode,
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
-	rc = vfs_setxattr(lower_dentry, name, value, size, flags);
+	rc = vfs_setxattr(&init_user_ns, lower_dentry, name, value, size, flags);
 	if (!rc && inode)
 		fsstack_copy_attr_all(inode, d_inode(lower_dentry));
 out:
@@ -1087,7 +1087,7 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
 		goto out;
 	}
 	inode_lock(lower_inode);
-	rc = __vfs_removexattr(lower_dentry, name);
+	rc = __vfs_removexattr(&init_user_ns, lower_dentry, name);
 	inode_unlock(lower_inode);
 out:
 	return rc;
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 019572c6b39a..2f333a40ff4d 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -426,8 +426,8 @@ static int ecryptfs_write_inode_size_to_xattr(struct inode *ecryptfs_inode)
 	if (size < 0)
 		size = 8;
 	put_unaligned_be64(i_size_read(ecryptfs_inode), xattr_virt);
-	rc = __vfs_setxattr(lower_dentry, lower_inode, ECRYPTFS_XATTR_NAME,
-			    xattr_virt, size, 0);
+	rc = __vfs_setxattr(&init_user_ns, lower_dentry, lower_inode,
+			    ECRYPTFS_XATTR_NAME, xattr_virt, size, 0);
 	inode_unlock(lower_inode);
 	if (rc)
 		printk(KERN_ERR "Error whilst attempting to write inode size "
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index e9b1452b505e..9a0e0e5b34f5 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -499,7 +499,7 @@ int nfsd4_is_junction(struct dentry *dentry)
 		return 0;
 	if (!(inode->i_mode & S_ISVTX))
 		return 0;
-	if (vfs_getxattr(dentry, NFSD_JUNCTION_XATTR_NAME, NULL, 0) <= 0)
+	if (vfs_getxattr(&init_user_ns, dentry, NFSD_JUNCTION_XATTR_NAME, NULL, 0) <= 0)
 		return 0;
 	return 1;
 }
@@ -2138,7 +2138,7 @@ nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 
 	inode_lock_shared(inode);
 
-	len = vfs_getxattr(dentry, name, NULL, 0);
+	len = vfs_getxattr(&init_user_ns, dentry, name, NULL, 0);
 
 	/*
 	 * Zero-length attribute, just return.
@@ -2165,7 +2165,7 @@ nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 		goto out;
 	}
 
-	len = vfs_getxattr(dentry, name, buf, len);
+	len = vfs_getxattr(&init_user_ns, dentry, name, buf, len);
 	if (len <= 0) {
 		kvfree(buf);
 		buf = NULL;
@@ -2272,7 +2272,7 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
 
 	fh_lock(fhp);
 
-	ret = __vfs_removexattr_locked(fhp->fh_dentry, name, NULL);
+	ret = __vfs_removexattr_locked(&init_user_ns, fhp->fh_dentry, name, NULL);
 
 	fh_unlock(fhp);
 	fh_drop_write(fhp);
@@ -2296,8 +2296,8 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 		return nfserrno(ret);
 	fh_lock(fhp);
 
-	ret = __vfs_setxattr_locked(fhp->fh_dentry, name, buf, len, flags,
-				    NULL);
+	ret = __vfs_setxattr_locked(&init_user_ns, fhp->fh_dentry, name, buf,
+				    len, flags, NULL);
 
 	fh_unlock(fhp);
 	fh_drop_write(fhp);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b972a58f1836..0ad1c47e2ca2 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -85,9 +85,9 @@ int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
 		if (ovl_is_private_xattr(sb, name))
 			continue;
 retry:
-		size = vfs_getxattr(old, name, value, value_size);
+		size = vfs_getxattr(&init_user_ns, old, name, value, value_size);
 		if (size == -ERANGE)
-			size = vfs_getxattr(old, name, NULL, 0);
+			size = vfs_getxattr(&init_user_ns, old, name, NULL, 0);
 
 		if (size < 0) {
 			error = size;
@@ -114,7 +114,7 @@ int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
 			error = 0;
 			continue; /* Discard */
 		}
-		error = vfs_setxattr(new, name, value, size, 0);
+		error = vfs_setxattr(&init_user_ns, new, name, value, size, 0);
 		if (error) {
 			if (error != -EOPNOTSUPP || ovl_must_copy_xattr(name))
 				break;
@@ -791,7 +791,7 @@ static ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value)
 	ssize_t res;
 	char *buf;
 
-	res = vfs_getxattr(dentry, name, NULL, 0);
+	res = vfs_getxattr(&init_user_ns, dentry, name, NULL, 0);
 	if (res == -ENODATA || res == -EOPNOTSUPP)
 		res = 0;
 
@@ -800,7 +800,7 @@ static ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value)
 		if (!buf)
 			return -ENOMEM;
 
-		res = vfs_getxattr(dentry, name, buf, res);
+		res = vfs_getxattr(&init_user_ns, dentry, name, buf, res);
 		if (res < 0)
 			kfree(buf);
 		else
@@ -842,7 +842,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	 * don't want that to happen for normal copy-up operation.
 	 */
 	if (capability) {
-		err = vfs_setxattr(upperpath.dentry, XATTR_NAME_CAPS,
+		err = vfs_setxattr(&init_user_ns, upperpath.dentry, XATTR_NAME_CAPS,
 				   capability, cap_size, 0);
 		if (err)
 			goto out_free;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 28e4d3e4d54d..a1794c838b78 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -449,7 +449,7 @@ static int ovl_set_upper_acl(struct dentry *upperdentry, const char *name,
 	if (err < 0)
 		goto out_free;
 
-	err = vfs_setxattr(upperdentry, name, buffer, size, XATTR_CREATE);
+	err = vfs_setxattr(&init_user_ns, upperdentry, name, buffer, size, XATTR_CREATE);
 out_free:
 	kfree(buffer);
 	return err;
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 7d1a455e4177..2835f33f386a 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -346,7 +346,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		goto out;
 
 	if (!value && !upperdentry) {
-		err = vfs_getxattr(realdentry, name, NULL, 0);
+		err = vfs_getxattr(&init_user_ns, realdentry, name, NULL, 0);
 		if (err < 0)
 			goto out_drop_write;
 	}
@@ -361,10 +361,10 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	if (value)
-		err = vfs_setxattr(realdentry, name, value, size, flags);
+		err = vfs_setxattr(&init_user_ns, realdentry, name, value, size, flags);
 	else {
 		WARN_ON(flags != XATTR_REPLACE);
-		err = vfs_removexattr(realdentry, name);
+		err = vfs_removexattr(&init_user_ns, realdentry, name);
 	}
 	revert_creds(old_cred);
 
@@ -386,7 +386,7 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 		ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry);
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_getxattr(realdentry, name, value, size);
+	res = vfs_getxattr(&init_user_ns, realdentry, name, value, size);
 	revert_creds(old_cred);
 	return res;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f8880aa2ba0e..bf26fb3fa2c1 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -184,7 +184,7 @@ static inline ssize_t ovl_do_getxattr(struct ovl_fs *ofs, struct dentry *dentry,
 				      size_t size)
 {
 	const char *name = ovl_xattr(ofs, ox);
-	return vfs_getxattr(dentry, name, value, size);
+	return vfs_getxattr(&init_user_ns, dentry, name, value, size);
 }
 
 static inline int ovl_do_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
@@ -192,7 +192,7 @@ static inline int ovl_do_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
 				  size_t size)
 {
 	const char *name = ovl_xattr(ofs, ox);
-	int err = vfs_setxattr(dentry, name, value, size, 0);
+	int err = vfs_setxattr(&init_user_ns, dentry, name, value, size, 0);
 	pr_debug("setxattr(%pd2, \"%s\", \"%*pE\", %zu, 0) = %i\n",
 		 dentry, name, min((int)size, 48), value, size, err);
 	return err;
@@ -202,7 +202,7 @@ static inline int ovl_do_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
 				     enum ovl_xattr ox)
 {
 	const char *name = ovl_xattr(ofs, ox);
-	int err = vfs_removexattr(dentry, name);
+	int err = vfs_removexattr(&init_user_ns, dentry, name);
 	pr_debug("removexattr(%pd2, \"%s\") = %i\n", dentry, name, err);
 	return err;
 }
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 9c12df942407..4dcd092ca561 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -749,11 +749,11 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		 * allowed as upper are limited to "normal" ones, where checking
 		 * for the above two errors is sufficient.
 		 */
-		err = vfs_removexattr(work, XATTR_NAME_POSIX_ACL_DEFAULT);
+		err = vfs_removexattr(&init_user_ns, work, XATTR_NAME_POSIX_ACL_DEFAULT);
 		if (err && err != -ENODATA && err != -EOPNOTSUPP)
 			goto out_dput;
 
-		err = vfs_removexattr(work, XATTR_NAME_POSIX_ACL_ACCESS);
+		err = vfs_removexattr(&init_user_ns, work, XATTR_NAME_POSIX_ACL_ACCESS);
 		if (err && err != -ENODATA && err != -EOPNOTSUPP)
 			goto out_dput;
 
diff --git a/fs/xattr.c b/fs/xattr.c
index ff9ffe77a4b2..438fedfcd402 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -83,7 +83,8 @@ xattr_resolve_name(struct inode *inode, const char **name)
  * because different namespaces have very different rules.
  */
 static int
-xattr_permission(struct inode *inode, const char *name, int mask)
+xattr_permission(struct user_namespace *user_ns, struct inode *inode,
+		 const char *name, int mask)
 {
 	/*
 	 * We can never set or remove an extended attribute on a read-only
@@ -127,11 +128,11 @@ xattr_permission(struct inode *inode, const char *name, int mask)
 		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
 		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
-		    (mask & MAY_WRITE) && !inode_owner_or_capable(&init_user_ns, inode))
+		    (mask & MAY_WRITE) && !inode_owner_or_capable(user_ns, inode))
 			return -EPERM;
 	}
 
-	return inode_permission(&init_user_ns, inode, mask);
+	return inode_permission(user_ns, inode, mask);
 }
 
 /*
@@ -162,8 +163,9 @@ xattr_supported_namespace(struct inode *inode, const char *prefix)
 EXPORT_SYMBOL(xattr_supported_namespace);
 
 int
-__vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
-	       const void *value, size_t size, int flags)
+__vfs_setxattr(struct user_namespace *user_ns, struct dentry *dentry,
+	       struct inode *inode, const char *name, const void *value,
+	       size_t size, int flags)
 {
 	const struct xattr_handler *handler;
 
@@ -174,7 +176,7 @@ __vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
 		return -EOPNOTSUPP;
 	if (size == 0)
 		value = "";  /* empty EA, do not remove */
-	return handler->set(handler, &init_user_ns, dentry, inode, name, value, size, flags);
+	return handler->set(handler, user_ns, dentry, inode, name, value, size, flags);
 }
 EXPORT_SYMBOL(__vfs_setxattr);
 
@@ -182,6 +184,7 @@ EXPORT_SYMBOL(__vfs_setxattr);
  *  __vfs_setxattr_noperm - perform setxattr operation without performing
  *  permission checks.
  *
+ *  @user_ns - user namespace of the mount
  *  @dentry - object to perform setxattr on
  *  @name - xattr name to set
  *  @value - value to set @name to
@@ -194,8 +197,9 @@ EXPORT_SYMBOL(__vfs_setxattr);
  *  is executed. It also assumes that the caller will make the appropriate
  *  permission checks.
  */
-int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags)
+int __vfs_setxattr_noperm(struct user_namespace *user_ns, struct dentry *dentry,
+			  const char *name, const void *value, size_t size,
+			  int flags)
 {
 	struct inode *inode = dentry->d_inode;
 	int error = -EAGAIN;
@@ -205,7 +209,7 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 	if (issec)
 		inode->i_flags &= ~S_NOSEC;
 	if (inode->i_opflags & IOP_XATTR) {
-		error = __vfs_setxattr(dentry, inode, name, value, size, flags);
+		error = __vfs_setxattr(user_ns, dentry, inode, name, value, size, flags);
 		if (!error) {
 			fsnotify_xattr(dentry);
 			security_inode_post_setxattr(dentry, name, value,
@@ -244,14 +248,14 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
  *  a delegation was broken on, NULL if none.
  */
 int
-__vfs_setxattr_locked(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags,
-		struct inode **delegated_inode)
+__vfs_setxattr_locked(struct user_namespace *user_ns, struct dentry *dentry,
+		      const char *name, const void *value, size_t size,
+		      int flags, struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	error = xattr_permission(inode, name, MAY_WRITE);
+	error = xattr_permission(user_ns, inode, name, MAY_WRITE);
 	if (error)
 		return error;
 
@@ -263,7 +267,7 @@ __vfs_setxattr_locked(struct dentry *dentry, const char *name,
 	if (error)
 		goto out;
 
-	error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
+	error = __vfs_setxattr_noperm(user_ns, dentry, name, value, size, flags);
 
 out:
 	return error;
@@ -271,8 +275,8 @@ __vfs_setxattr_locked(struct dentry *dentry, const char *name,
 EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
 
 int
-vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
-		size_t size, int flags)
+vfs_setxattr(struct user_namespace *user_ns, struct dentry *dentry,
+	     const char *name, const void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
@@ -280,8 +284,8 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 
 retry_deleg:
 	inode_lock(inode);
-	error = __vfs_setxattr_locked(dentry, name, value, size, flags,
-	    &delegated_inode);
+	error = __vfs_setxattr_locked(user_ns, dentry, name, value, size, flags,
+				      &delegated_inode);
 	inode_unlock(inode);
 
 	if (delegated_inode) {
@@ -328,15 +332,16 @@ xattr_getsecurity(struct inode *inode, const char *name, void *value,
  * Returns the result of alloc, if failed, or the getxattr operation.
  */
 ssize_t
-vfs_getxattr_alloc(struct dentry *dentry, const char *name, char **xattr_value,
-		   size_t xattr_size, gfp_t flags)
+vfs_getxattr_alloc(struct user_namespace *user_ns, struct dentry *dentry,
+		   const char *name, char **xattr_value, size_t xattr_size,
+		   gfp_t flags)
 {
 	const struct xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
 	char *value = *xattr_value;
 	int error;
 
-	error = xattr_permission(inode, name, MAY_READ);
+	error = xattr_permission(user_ns, inode, name, MAY_READ);
 	if (error)
 		return error;
 
@@ -377,12 +382,13 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 EXPORT_SYMBOL(__vfs_getxattr);
 
 ssize_t
-vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
+vfs_getxattr(struct user_namespace *user_ns, struct dentry *dentry,
+	     const char *name, void *value, size_t size)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	error = xattr_permission(inode, name, MAY_READ);
+	error = xattr_permission(user_ns, inode, name, MAY_READ);
 	if (error)
 		return error;
 
@@ -428,7 +434,7 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 EXPORT_SYMBOL_GPL(vfs_listxattr);
 
 int
-__vfs_removexattr(struct dentry *dentry, const char *name)
+__vfs_removexattr(struct user_namespace *user_ns, struct dentry *dentry, const char *name)
 {
 	struct inode *inode = d_inode(dentry);
 	const struct xattr_handler *handler;
@@ -438,7 +444,7 @@ __vfs_removexattr(struct dentry *dentry, const char *name)
 		return PTR_ERR(handler);
 	if (!handler->set)
 		return -EOPNOTSUPP;
-	return handler->set(handler, &init_user_ns, dentry, inode, name, NULL, 0, XATTR_REPLACE);
+	return handler->set(handler, user_ns, dentry, inode, name, NULL, 0, XATTR_REPLACE);
 }
 EXPORT_SYMBOL(__vfs_removexattr);
 
@@ -452,13 +458,13 @@ EXPORT_SYMBOL(__vfs_removexattr);
  *  a delegation was broken on, NULL if none.
  */
 int
-__vfs_removexattr_locked(struct dentry *dentry, const char *name,
-		struct inode **delegated_inode)
+__vfs_removexattr_locked(struct user_namespace *user_ns, struct dentry *dentry,
+			 const char *name, struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	error = xattr_permission(inode, name, MAY_WRITE);
+	error = xattr_permission(user_ns, inode, name, MAY_WRITE);
 	if (error)
 		return error;
 
@@ -470,7 +476,7 @@ __vfs_removexattr_locked(struct dentry *dentry, const char *name,
 	if (error)
 		goto out;
 
-	error = __vfs_removexattr(dentry, name);
+	error = __vfs_removexattr(user_ns, dentry, name);
 
 	if (!error) {
 		fsnotify_xattr(dentry);
@@ -483,7 +489,8 @@ __vfs_removexattr_locked(struct dentry *dentry, const char *name,
 EXPORT_SYMBOL_GPL(__vfs_removexattr_locked);
 
 int
-vfs_removexattr(struct dentry *dentry, const char *name)
+vfs_removexattr(struct user_namespace *user_ns, struct dentry *dentry,
+		const char *name)
 {
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
@@ -491,7 +498,7 @@ vfs_removexattr(struct dentry *dentry, const char *name)
 
 retry_deleg:
 	inode_lock(inode);
-	error = __vfs_removexattr_locked(dentry, name, &delegated_inode);
+	error = __vfs_removexattr_locked(user_ns, dentry, name, &delegated_inode);
 	inode_unlock(inode);
 
 	if (delegated_inode) {
@@ -508,8 +515,9 @@ EXPORT_SYMBOL_GPL(vfs_removexattr);
  * Extended attribute SET operations
  */
 static long
-setxattr(struct dentry *d, const char __user *name, const void __user *value,
-	 size_t size, int flags)
+setxattr(struct user_namespace *user_ns, struct dentry *d,
+	 const char __user *name, const void __user *value, size_t size,
+	 int flags)
 {
 	int error;
 	void *kvalue = NULL;
@@ -536,16 +544,16 @@ setxattr(struct dentry *d, const char __user *name, const void __user *value,
 		}
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_from_user(&init_user_ns, kvalue, size);
+			posix_acl_fix_xattr_from_user(user_ns, kvalue, size);
 		else if (strcmp(kname, XATTR_NAME_CAPS) == 0) {
-			error = cap_convert_nscap(&init_user_ns, d, &kvalue, size);
+			error = cap_convert_nscap(user_ns, d, &kvalue, size);
 			if (error < 0)
 				goto out;
 			size = error;
 		}
 	}
 
-	error = vfs_setxattr(d, kname, kvalue, size, flags);
+	error = vfs_setxattr(user_ns, d, kname, kvalue, size, flags);
 out:
 	kvfree(kvalue);
 
@@ -558,13 +566,17 @@ static int path_setxattr(const char __user *pathname,
 {
 	struct path path;
 	int error;
+
 retry:
 	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
 		return error;
 	error = mnt_want_write(path.mnt);
 	if (!error) {
-		error = setxattr(path.dentry, name, value, size, flags);
+		struct user_namespace *user_ns;
+
+		user_ns = mnt_user_ns(path.mnt);
+		error = setxattr(user_ns, path.dentry, name, value, size, flags);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -600,7 +612,11 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 	audit_file(f.file);
 	error = mnt_want_write_file(f.file);
 	if (!error) {
-		error = setxattr(f.file->f_path.dentry, name, value, size, flags);
+		struct user_namespace *user_ns;
+
+		user_ns = mnt_user_ns(f.file->f_path.mnt);
+		error = setxattr(user_ns, f.file->f_path.dentry, name, value,
+				 size, flags);
 		mnt_drop_write_file(f.file);
 	}
 	fdput(f);
@@ -611,8 +627,8 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
  * Extended attribute GET operations
  */
 static ssize_t
-getxattr(struct dentry *d, const char __user *name, void __user *value,
-	 size_t size)
+getxattr(struct user_namespace *user_ns, struct dentry *d,
+	 const char __user *name, void __user *value, size_t size)
 {
 	ssize_t error;
 	void *kvalue = NULL;
@@ -632,11 +648,11 @@ getxattr(struct dentry *d, const char __user *name, void __user *value,
 			return -ENOMEM;
 	}
 
-	error = vfs_getxattr(d, kname, kvalue, size);
+	error = vfs_getxattr(user_ns, d, kname, kvalue, size);
 	if (error > 0) {
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_to_user(&init_user_ns, kvalue, error);
+			posix_acl_fix_xattr_to_user(user_ns, kvalue, error);
 		if (size && copy_to_user(value, kvalue, error))
 			error = -EFAULT;
 	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
@@ -654,13 +670,15 @@ static ssize_t path_getxattr(const char __user *pathname,
 			     const char __user *name, void __user *value,
 			     size_t size, unsigned int lookup_flags)
 {
+	struct user_namespace *user_ns;
 	struct path path;
 	ssize_t error;
 retry:
 	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
 		return error;
-	error = getxattr(path.dentry, name, value, size);
+	user_ns = mnt_user_ns(path.mnt);
+	error = getxattr(user_ns, path.dentry, name, value, size);
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -684,13 +702,15 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
+	struct user_namespace *user_ns;
 	struct fd f = fdget(fd);
 	ssize_t error = -EBADF;
 
 	if (!f.file)
 		return error;
 	audit_file(f.file);
-	error = getxattr(f.file->f_path.dentry, name, value, size);
+	user_ns = mnt_user_ns(f.file->f_path.mnt);
+	error = getxattr(user_ns, f.file->f_path.dentry, name, value, size);
 	fdput(f);
 	return error;
 }
@@ -774,7 +794,7 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
  * Extended attribute REMOVE operations
  */
 static long
-removexattr(struct dentry *d, const char __user *name)
+removexattr(struct user_namespace *user_ns, struct dentry *d, const char __user *name)
 {
 	int error;
 	char kname[XATTR_NAME_MAX + 1];
@@ -785,7 +805,7 @@ removexattr(struct dentry *d, const char __user *name)
 	if (error < 0)
 		return error;
 
-	return vfs_removexattr(d, kname);
+	return vfs_removexattr(user_ns, d, kname);
 }
 
 static int path_removexattr(const char __user *pathname,
@@ -799,7 +819,9 @@ static int path_removexattr(const char __user *pathname,
 		return error;
 	error = mnt_want_write(path.mnt);
 	if (!error) {
-		error = removexattr(path.dentry, name);
+		struct user_namespace *user_ns = mnt_user_ns(path.mnt);
+
+		error = removexattr(user_ns, path.dentry, name);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -832,7 +854,9 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 	audit_file(f.file);
 	error = mnt_want_write_file(f.file);
 	if (!error) {
-		error = removexattr(f.file->f_path.dentry, name);
+		struct user_namespace *user_ns = mnt_user_ns(f.file->f_path.mnt);
+
+		error = removexattr(user_ns, f.file->f_path.dentry, name);
 		mnt_drop_write_file(f.file);
 	}
 	fdput(f);
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 6d2ef03ba399..a015f5b03ef2 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/user_namespace.h>
 #include <uapi/linux/xattr.h>
 
 struct inode;
@@ -48,18 +49,23 @@ struct xattr {
 };
 
 ssize_t __vfs_getxattr(struct dentry *, struct inode *, const char *, void *, size_t);
-ssize_t vfs_getxattr(struct dentry *, const char *, void *, size_t);
+ssize_t vfs_getxattr(struct user_namespace *, struct dentry *, const char *, void *, size_t);
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
-int __vfs_setxattr(struct dentry *, struct inode *, const char *, const void *, size_t, int);
-int __vfs_setxattr_noperm(struct dentry *, const char *, const void *, size_t, int);
-int __vfs_setxattr_locked(struct dentry *, const char *, const void *, size_t, int, struct inode **);
-int vfs_setxattr(struct dentry *, const char *, const void *, size_t, int);
-int __vfs_removexattr(struct dentry *, const char *);
-int __vfs_removexattr_locked(struct dentry *, const char *, struct inode **);
-int vfs_removexattr(struct dentry *, const char *);
+int __vfs_setxattr(struct user_namespace *, struct dentry *, struct inode *,
+		   const char *, const void *, size_t, int);
+int __vfs_setxattr_noperm(struct user_namespace *, struct dentry *,
+			  const char *, const void *, size_t, int);
+int __vfs_setxattr_locked(struct user_namespace *, struct dentry *,
+			  const char *, const void *, size_t, int,
+			  struct inode **);
+int vfs_setxattr(struct user_namespace *, struct dentry *, const char *, const void *, size_t, int);
+int __vfs_removexattr(struct user_namespace *, struct dentry *, const char *);
+int __vfs_removexattr_locked(struct user_namespace *, struct dentry *, const char *, struct inode **);
+int vfs_removexattr(struct user_namespace *, struct dentry *, const char *);
 
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
-ssize_t vfs_getxattr_alloc(struct dentry *dentry, const char *name,
+ssize_t vfs_getxattr_alloc(struct user_namespace *user_ns,
+			   struct dentry *dentry, const char *name,
 			   char **xattr_value, size_t size, gfp_t flags);
 
 int xattr_supported_namespace(struct inode *inode, const char *prefix);
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index f919ebd042fd..16f184bc48de 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -324,8 +324,8 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
 	d = bprm->file->f_path.dentry;
 
 	for (i = 0; i < profile->xattr_count; i++) {
-		size = vfs_getxattr_alloc(d, profile->xattrs[i], &value,
-					  value_size, GFP_KERNEL);
+		size = vfs_getxattr_alloc(&init_user_ns, d, profile->xattrs[i],
+					  &value, value_size, GFP_KERNEL);
 		if (size >= 0) {
 			u32 perm;
 
diff --git a/security/commoncap.c b/security/commoncap.c
index abefe9223b5e..873820091b07 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -313,7 +313,7 @@ int cap_inode_killpriv(struct dentry *dentry)
 {
 	int error;
 
-	error = __vfs_removexattr(dentry, XATTR_NAME_CAPS);
+	error = __vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_CAPS);
 	if (error == -EOPNOTSUPP)
 		error = 0;
 	return error;
@@ -386,8 +386,8 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 		return -EINVAL;
 
 	size = sizeof(struct vfs_ns_cap_data);
-	ret = (int) vfs_getxattr_alloc(dentry, XATTR_NAME_CAPS,
-				 &tmpbuf, size, GFP_NOFS);
+	ret = (int)vfs_getxattr_alloc(&init_user_ns, dentry, XATTR_NAME_CAPS,
+				      &tmpbuf, size, GFP_NOFS);
 	dput(dentry);
 
 	if (ret < 0)
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 168c3b78ac47..f720f78cbbb1 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -222,7 +222,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 				ima_present = true;
 			continue;
 		}
-		size = vfs_getxattr_alloc(dentry, xattr->name,
+		size = vfs_getxattr_alloc(&init_user_ns, dentry, xattr->name,
 					  &xattr_value, xattr_size, GFP_NOFS);
 		if (size == -ENOMEM) {
 			error = -ENOMEM;
@@ -275,8 +275,8 @@ static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
 		return 1;
 
 	/* Do this the hard way */
-	rc = vfs_getxattr_alloc(dentry, XATTR_NAME_EVM, (char **)&xattr_data, 0,
-				GFP_NOFS);
+	rc = vfs_getxattr_alloc(&init_user_ns, dentry, XATTR_NAME_EVM,
+				(char **)&xattr_data, 0, GFP_NOFS);
 	if (rc <= 0) {
 		if (rc == -ENODATA)
 			return 0;
@@ -319,11 +319,12 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 			   xattr_value_len, &data);
 	if (rc == 0) {
 		data.hdr.xattr.sha1.type = EVM_XATTR_HMAC;
-		rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_EVM,
+		rc = __vfs_setxattr_noperm(&init_user_ns, dentry,
+					   XATTR_NAME_EVM,
 					   &data.hdr.xattr.data[1],
 					   SHA1_DIGEST_SIZE + 1, 0);
 	} else if (rc == -ENODATA && (inode->i_opflags & IOP_XATTR)) {
-		rc = __vfs_removexattr(dentry, XATTR_NAME_EVM);
+		rc = __vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_EVM);
 	}
 	return rc;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 76d19146d74b..0de367aaa2d3 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -146,8 +146,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	/* if status is not PASS, try to check again - against -ENOMEM */
 
 	/* first need to know the sig type */
-	rc = vfs_getxattr_alloc(dentry, XATTR_NAME_EVM, (char **)&xattr_data, 0,
-				GFP_NOFS);
+	rc = vfs_getxattr_alloc(&init_user_ns, dentry, XATTR_NAME_EVM,
+				(char **)&xattr_data, 0, GFP_NOFS);
 	if (rc <= 0) {
 		evm_status = INTEGRITY_FAIL;
 		if (rc == -ENODATA) {
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3dd8c2e4314e..3492f0b2da1c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -89,7 +89,7 @@ static int ima_fix_xattr(struct dentry *dentry,
 		iint->ima_hash->xattr.ng.type = IMA_XATTR_DIGEST_NG;
 		iint->ima_hash->xattr.ng.algo = algo;
 	}
-	rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_IMA,
+	rc = __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_IMA,
 				   &iint->ima_hash->xattr.data[offset],
 				   (sizeof(iint->ima_hash->xattr) - offset) +
 				   iint->ima_hash->length, 0);
@@ -210,8 +210,8 @@ int ima_read_xattr(struct dentry *dentry,
 {
 	ssize_t ret;
 
-	ret = vfs_getxattr_alloc(dentry, XATTR_NAME_IMA, (char **)xattr_value,
-				 0, GFP_NOFS);
+	ret = vfs_getxattr_alloc(&init_user_ns, dentry, XATTR_NAME_IMA,
+				 (char **)xattr_value, 0, GFP_NOFS);
 	if (ret == -EOPNOTSUPP)
 		ret = 0;
 	return ret;
@@ -515,7 +515,7 @@ void ima_inode_post_setattr(struct dentry *dentry)
 
 	action = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR);
 	if (!action)
-		__vfs_removexattr(dentry, XATTR_NAME_IMA);
+		__vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_IMA);
 	iint = integrity_iint_find(inode);
 	if (iint) {
 		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 14a195fa55eb..3f42950feed0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6518,7 +6518,7 @@ static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen
  */
 static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0);
+	return __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0);
 }
 
 static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5c90b9fa4d40..11003244b18b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3425,7 +3425,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 			 */
 			if (isp->smk_flags & SMK_INODE_CHANGED) {
 				isp->smk_flags &= ~SMK_INODE_CHANGED;
-				rc = __vfs_setxattr(dp, inode,
+				rc = __vfs_setxattr(&init_user_ns, dp, inode,
 					XATTR_NAME_SMACKTRANSMUTE,
 					TRANS_TRUE, TRANS_TRUE_SIZE,
 					0);
@@ -4603,7 +4603,7 @@ static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 
 static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, ctx, ctxlen, 0);
+	return __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_SMACK, ctx, ctxlen, 0);
 }
 
 static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
-- 
2.29.2

