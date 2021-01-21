Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A182FEF18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbhAUPjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:39:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53919 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731839AbhAUNVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:21:51 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2ZtR-0005g7-7h; Thu, 21 Jan 2021 13:20:57 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
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
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v6 09/40] xattr: handle idmapped mounts
Date:   Thu, 21 Jan 2021 14:19:28 +0100
Message-Id: <20210121131959.646623-10-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=Ucu2lDO5FFShzhPyCveia/26+X1XsYiywHJxFSOSKsY=; m=tSCR/QYvKf0OSs4dE6PYSs8A+8OUWboDd71m9Awnbzw=; p=swFV++aPN5a25G29U/ngXDnRvYQ/lotFmNfC1yW6Cdg=; g=37d1a8b560cca1f91144c90152a934ae9aa0ae8e
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pAAKCRCRxhvAZXjcopnUAQCOdqj Y42N7fZJ6ppSuVtUXsS1sNDej+9cuISHWFpeK1gEAn2yfJ1cXnc1yYj4Ozl/psUctNAva3vw3sJmj qeGZyg4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tycho Andersen <tycho@tycho.pizza>

When interacting with extended attributes the vfs verifies that the
caller is privileged over the inode with which the extended attribute is
associated. For posix access and posix default extended attributes a uid
or gid can be stored on-disk. Let the functions handle posix extended
attributes on idmapped mounts. If the inode is accessed through an
idmapped mount we need to map it according to the mount's user
namespace. Afterwards the checks are identical to non-idmapped mounts.
This has no effect for e.g. security xattrs since they don't store uids
or gids and don't perform permission checks on them like posix acls do.

Link: https://lore.kernel.org/r/20210112220124.837960-17-christian.brauner@ubuntu.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig <hch@lst.de>:
  - Don't pollute the vfs with additional helpers simply extend the existing
    helpers with an additional argument and switch all callers.

/* v3 */
unchanged

/* v4 */
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.

/* v5 */
unchanged
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

/* v6 */
base-commit: 19c329f6808995b142b3966301f217c831e7cf31

- Christoph Hellwig <hch@lst.de>:
  - Remove local variables in favor of calling file_mnt_user_ns()
    directly.
---
 fs/cachefiles/xattr.c                 |  29 +++----
 fs/ecryptfs/crypto.c                  |   4 +-
 fs/ecryptfs/inode.c                   |   5 +-
 fs/ecryptfs/mmap.c                    |   4 +-
 fs/nfsd/vfs.c                         |  14 +--
 fs/overlayfs/copy_up.c                |  14 +--
 fs/overlayfs/dir.c                    |   2 +-
 fs/overlayfs/inode.c                  |   9 +-
 fs/overlayfs/overlayfs.h              |   6 +-
 fs/overlayfs/super.c                  |   6 +-
 fs/xattr.c                            | 120 +++++++++++++++-----------
 include/linux/xattr.h                 |  27 ++++--
 security/apparmor/domain.c            |   4 +-
 security/commoncap.c                  |   6 +-
 security/integrity/evm/evm_crypto.c   |  11 +--
 security/integrity/evm/evm_main.c     |   4 +-
 security/integrity/ima/ima_appraise.c |   8 +-
 security/selinux/hooks.c              |   3 +-
 security/smack/smack_lsm.c            |   8 +-
 19 files changed, 160 insertions(+), 124 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 72e42438f3d7..a591b5e09637 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -39,8 +39,8 @@ int cachefiles_check_object_type(struct cachefiles_object *object)
 	_enter("%p{%s}", object, type);
 
 	/* attempt to install a type label directly */
-	ret = vfs_setxattr(dentry, cachefiles_xattr_cache, type, 2,
-			   XATTR_CREATE);
+	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache, type,
+			   2, XATTR_CREATE);
 	if (ret == 0) {
 		_debug("SET"); /* we succeeded */
 		goto error;
@@ -54,7 +54,8 @@ int cachefiles_check_object_type(struct cachefiles_object *object)
 	}
 
 	/* read the current type label */
-	ret = vfs_getxattr(dentry, cachefiles_xattr_cache, xtype, 3);
+	ret = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, xtype,
+			   3);
 	if (ret < 0) {
 		if (ret == -ERANGE)
 			goto bad_type_length;
@@ -110,9 +111,8 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object,
 	_debug("SET #%u", auxdata->len);
 
 	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
-	ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
-			   &auxdata->type, auxdata->len,
-			   XATTR_CREATE);
+	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
+			   &auxdata->type, auxdata->len, XATTR_CREATE);
 	if (ret < 0 && ret != -ENOMEM)
 		cachefiles_io_error_obj(
 			object,
@@ -140,9 +140,8 @@ int cachefiles_update_object_xattr(struct cachefiles_object *object,
 	_debug("SET #%u", auxdata->len);
 
 	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
-	ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
-			   &auxdata->type, auxdata->len,
-			   XATTR_REPLACE);
+	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
+			   &auxdata->type, auxdata->len, XATTR_REPLACE);
 	if (ret < 0 && ret != -ENOMEM)
 		cachefiles_io_error_obj(
 			object,
@@ -171,7 +170,7 @@ int cachefiles_check_auxdata(struct cachefiles_object *object)
 	if (!auxbuf)
 		return -ENOMEM;
 
-	xlen = vfs_getxattr(dentry, cachefiles_xattr_cache,
+	xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
 			    &auxbuf->type, 512 + 1);
 	ret = -ESTALE;
 	if (xlen < 1 ||
@@ -213,7 +212,7 @@ int cachefiles_check_object_xattr(struct cachefiles_object *object,
 	}
 
 	/* read the current type label */
-	ret = vfs_getxattr(dentry, cachefiles_xattr_cache,
+	ret = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
 			   &auxbuf->type, 512 + 1);
 	if (ret < 0) {
 		if (ret == -ENODATA)
@@ -270,9 +269,9 @@ int cachefiles_check_object_xattr(struct cachefiles_object *object,
 		}
 
 		/* update the current label */
-		ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
-				   &auxdata->type, auxdata->len,
-				   XATTR_REPLACE);
+		ret = vfs_setxattr(&init_user_ns, dentry,
+				   cachefiles_xattr_cache, &auxdata->type,
+				   auxdata->len, XATTR_REPLACE);
 		if (ret < 0) {
 			cachefiles_io_error_obj(object,
 						"Can't update xattr on %lu"
@@ -309,7 +308,7 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
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
index ac6472a82567..b9ccc4085d46 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1024,7 +1024,8 @@ ecryptfs_setxattr(struct dentry *dentry, struct inode *inode,
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
-	rc = vfs_setxattr(lower_dentry, name, value, size, flags);
+	rc = vfs_setxattr(&init_user_ns, lower_dentry, name, value, size,
+			  flags);
 	if (!rc && inode)
 		fsstack_copy_attr_all(inode, d_inode(lower_dentry));
 out:
@@ -1089,7 +1090,7 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
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
index 1905b39be1c2..37d85046b4d6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -499,7 +499,8 @@ int nfsd4_is_junction(struct dentry *dentry)
 		return 0;
 	if (!(inode->i_mode & S_ISVTX))
 		return 0;
-	if (vfs_getxattr(dentry, NFSD_JUNCTION_XATTR_NAME, NULL, 0) <= 0)
+	if (vfs_getxattr(&init_user_ns, dentry, NFSD_JUNCTION_XATTR_NAME,
+			 NULL, 0) <= 0)
 		return 0;
 	return 1;
 }
@@ -2149,7 +2150,7 @@ nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 
 	inode_lock_shared(inode);
 
-	len = vfs_getxattr(dentry, name, NULL, 0);
+	len = vfs_getxattr(&init_user_ns, dentry, name, NULL, 0);
 
 	/*
 	 * Zero-length attribute, just return.
@@ -2176,7 +2177,7 @@ nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 		goto out;
 	}
 
-	len = vfs_getxattr(dentry, name, buf, len);
+	len = vfs_getxattr(&init_user_ns, dentry, name, buf, len);
 	if (len <= 0) {
 		kvfree(buf);
 		buf = NULL;
@@ -2283,7 +2284,8 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
 
 	fh_lock(fhp);
 
-	ret = __vfs_removexattr_locked(fhp->fh_dentry, name, NULL);
+	ret = __vfs_removexattr_locked(&init_user_ns, fhp->fh_dentry,
+				       name, NULL);
 
 	fh_unlock(fhp);
 	fh_drop_write(fhp);
@@ -2307,8 +2309,8 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 		return nfserrno(ret);
 	fh_lock(fhp);
 
-	ret = __vfs_setxattr_locked(fhp->fh_dentry, name, buf, len, flags,
-				    NULL);
+	ret = __vfs_setxattr_locked(&init_user_ns, fhp->fh_dentry, name, buf,
+				    len, flags, NULL);
 
 	fh_unlock(fhp);
 	fh_drop_write(fhp);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 3e9957ae19fa..f81b836c2256 100644
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
@@ -795,7 +795,7 @@ static ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value)
 	ssize_t res;
 	char *buf;
 
-	res = vfs_getxattr(dentry, name, NULL, 0);
+	res = vfs_getxattr(&init_user_ns, dentry, name, NULL, 0);
 	if (res == -ENODATA || res == -EOPNOTSUPP)
 		res = 0;
 
@@ -804,7 +804,7 @@ static ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value)
 		if (!buf)
 			return -ENOMEM;
 
-		res = vfs_getxattr(dentry, name, buf, res);
+		res = vfs_getxattr(&init_user_ns, dentry, name, buf, res);
 		if (res < 0)
 			kfree(buf);
 		else
@@ -846,8 +846,8 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	 * don't want that to happen for normal copy-up operation.
 	 */
 	if (capability) {
-		err = vfs_setxattr(upperpath.dentry, XATTR_NAME_CAPS,
-				   capability, cap_size, 0);
+		err = vfs_setxattr(&init_user_ns, upperpath.dentry,
+				   XATTR_NAME_CAPS, capability, cap_size, 0);
 		if (err)
 			goto out_free;
 	}
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 29840820a46c..d75c96cb18c3 100644
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
index 5aa66881dbd7..023fde466e3a 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -352,7 +352,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		goto out;
 
 	if (!value && !upperdentry) {
-		err = vfs_getxattr(realdentry, name, NULL, 0);
+		err = vfs_getxattr(&init_user_ns, realdentry, name, NULL, 0);
 		if (err < 0)
 			goto out_drop_write;
 	}
@@ -367,10 +367,11 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	if (value)
-		err = vfs_setxattr(realdentry, name, value, size, flags);
+		err = vfs_setxattr(&init_user_ns, realdentry, name, value, size,
+				   flags);
 	else {
 		WARN_ON(flags != XATTR_REPLACE);
-		err = vfs_removexattr(realdentry, name);
+		err = vfs_removexattr(&init_user_ns, realdentry, name);
 	}
 	revert_creds(old_cred);
 
@@ -392,7 +393,7 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 		ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry);
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_getxattr(realdentry, name, value, size);
+	res = vfs_getxattr(&init_user_ns, realdentry, name, value, size);
 	revert_creds(old_cred);
 	return res;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b487e48c7fd4..0002834f664a 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -186,7 +186,7 @@ static inline ssize_t ovl_do_getxattr(struct ovl_fs *ofs, struct dentry *dentry,
 				      size_t size)
 {
 	const char *name = ovl_xattr(ofs, ox);
-	return vfs_getxattr(dentry, name, value, size);
+	return vfs_getxattr(&init_user_ns, dentry, name, value, size);
 }
 
 static inline int ovl_do_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
@@ -194,7 +194,7 @@ static inline int ovl_do_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
 				  size_t size)
 {
 	const char *name = ovl_xattr(ofs, ox);
-	int err = vfs_setxattr(dentry, name, value, size, 0);
+	int err = vfs_setxattr(&init_user_ns, dentry, name, value, size, 0);
 	pr_debug("setxattr(%pd2, \"%s\", \"%*pE\", %zu, 0) = %i\n",
 		 dentry, name, min((int)size, 48), value, size, err);
 	return err;
@@ -204,7 +204,7 @@ static inline int ovl_do_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
 				     enum ovl_xattr ox)
 {
 	const char *name = ovl_xattr(ofs, ox);
-	int err = vfs_removexattr(dentry, name);
+	int err = vfs_removexattr(&init_user_ns, dentry, name);
 	pr_debug("removexattr(%pd2, \"%s\") = %i\n", dentry, name, err);
 	return err;
 }
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e24c995c5fd4..8168ab2dda11 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -794,11 +794,13 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		 * allowed as upper are limited to "normal" ones, where checking
 		 * for the above two errors is sufficient.
 		 */
-		err = vfs_removexattr(work, XATTR_NAME_POSIX_ACL_DEFAULT);
+		err = vfs_removexattr(&init_user_ns, work,
+				      XATTR_NAME_POSIX_ACL_DEFAULT);
 		if (err && err != -ENODATA && err != -EOPNOTSUPP)
 			goto out_dput;
 
-		err = vfs_removexattr(work, XATTR_NAME_POSIX_ACL_ACCESS);
+		err = vfs_removexattr(&init_user_ns, work,
+				      XATTR_NAME_POSIX_ACL_ACCESS);
 		if (err && err != -ENODATA && err != -EOPNOTSUPP)
 			goto out_dput;
 
diff --git a/fs/xattr.c b/fs/xattr.c
index d777025121e0..a49541713b11 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -83,7 +83,8 @@ xattr_resolve_name(struct inode *inode, const char **name)
  * because different namespaces have very different rules.
  */
 static int
-xattr_permission(struct inode *inode, const char *name, int mask)
+xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
+		 const char *name, int mask)
 {
 	/*
 	 * We can never set or remove an extended attribute on a read-only
@@ -128,11 +129,11 @@ xattr_permission(struct inode *inode, const char *name, int mask)
 			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
 		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
 		    (mask & MAY_WRITE) &&
-		    !inode_owner_or_capable(&init_user_ns, inode))
+		    !inode_owner_or_capable(mnt_userns, inode))
 			return -EPERM;
 	}
 
-	return inode_permission(&init_user_ns, inode, mask);
+	return inode_permission(mnt_userns, inode, mask);
 }
 
 /*
@@ -163,8 +164,9 @@ xattr_supported_namespace(struct inode *inode, const char *prefix)
 EXPORT_SYMBOL(xattr_supported_namespace);
 
 int
-__vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
-	       const void *value, size_t size, int flags)
+__vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+	       struct inode *inode, const char *name, const void *value,
+	       size_t size, int flags)
 {
 	const struct xattr_handler *handler;
 
@@ -175,7 +177,7 @@ __vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
 		return -EOPNOTSUPP;
 	if (size == 0)
 		value = "";  /* empty EA, do not remove */
-	return handler->set(handler, &init_user_ns, dentry, inode, name, value,
+	return handler->set(handler, mnt_userns, dentry, inode, name, value,
 			    size, flags);
 }
 EXPORT_SYMBOL(__vfs_setxattr);
@@ -184,6 +186,7 @@ EXPORT_SYMBOL(__vfs_setxattr);
  *  __vfs_setxattr_noperm - perform setxattr operation without performing
  *  permission checks.
  *
+ *  @mnt_userns - user namespace of the mount the inode was found from
  *  @dentry - object to perform setxattr on
  *  @name - xattr name to set
  *  @value - value to set @name to
@@ -196,8 +199,9 @@ EXPORT_SYMBOL(__vfs_setxattr);
  *  is executed. It also assumes that the caller will make the appropriate
  *  permission checks.
  */
-int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags)
+int __vfs_setxattr_noperm(struct user_namespace *mnt_userns,
+			  struct dentry *dentry, const char *name,
+			  const void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
 	int error = -EAGAIN;
@@ -207,7 +211,8 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 	if (issec)
 		inode->i_flags &= ~S_NOSEC;
 	if (inode->i_opflags & IOP_XATTR) {
-		error = __vfs_setxattr(dentry, inode, name, value, size, flags);
+		error = __vfs_setxattr(mnt_userns, dentry, inode, name, value,
+				       size, flags);
 		if (!error) {
 			fsnotify_xattr(dentry);
 			security_inode_post_setxattr(dentry, name, value,
@@ -246,14 +251,14 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
  *  a delegation was broken on, NULL if none.
  */
 int
-__vfs_setxattr_locked(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags,
-		struct inode **delegated_inode)
+__vfs_setxattr_locked(struct user_namespace *mnt_userns, struct dentry *dentry,
+		      const char *name, const void *value, size_t size,
+		      int flags, struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	error = xattr_permission(inode, name, MAY_WRITE);
+	error = xattr_permission(mnt_userns, inode, name, MAY_WRITE);
 	if (error)
 		return error;
 
@@ -265,7 +270,8 @@ __vfs_setxattr_locked(struct dentry *dentry, const char *name,
 	if (error)
 		goto out;
 
-	error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
+	error = __vfs_setxattr_noperm(mnt_userns, dentry, name, value,
+				      size, flags);
 
 out:
 	return error;
@@ -273,8 +279,8 @@ __vfs_setxattr_locked(struct dentry *dentry, const char *name,
 EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
 
 int
-vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
-		size_t size, int flags)
+vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+	     const char *name, const void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
@@ -282,7 +288,7 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 	int error;
 
 	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
-		error = cap_convert_nscap(&init_user_ns, dentry, &value, size);
+		error = cap_convert_nscap(mnt_userns, dentry, &value, size);
 		if (error < 0)
 			return error;
 		size = error;
@@ -290,8 +296,8 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 
 retry_deleg:
 	inode_lock(inode);
-	error = __vfs_setxattr_locked(dentry, name, value, size, flags,
-	    &delegated_inode);
+	error = __vfs_setxattr_locked(mnt_userns, dentry, name, value, size,
+				      flags, &delegated_inode);
 	inode_unlock(inode);
 
 	if (delegated_inode) {
@@ -341,15 +347,16 @@ xattr_getsecurity(struct inode *inode, const char *name, void *value,
  * Returns the result of alloc, if failed, or the getxattr operation.
  */
 ssize_t
-vfs_getxattr_alloc(struct dentry *dentry, const char *name, char **xattr_value,
-		   size_t xattr_size, gfp_t flags)
+vfs_getxattr_alloc(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   const char *name, char **xattr_value, size_t xattr_size,
+		   gfp_t flags)
 {
 	const struct xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
 	char *value = *xattr_value;
 	int error;
 
-	error = xattr_permission(inode, name, MAY_READ);
+	error = xattr_permission(mnt_userns, inode, name, MAY_READ);
 	if (error)
 		return error;
 
@@ -390,12 +397,13 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 EXPORT_SYMBOL(__vfs_getxattr);
 
 ssize_t
-vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
+vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+	     const char *name, void *value, size_t size)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	error = xattr_permission(inode, name, MAY_READ);
+	error = xattr_permission(mnt_userns, inode, name, MAY_READ);
 	if (error)
 		return error;
 
@@ -441,7 +449,8 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 EXPORT_SYMBOL_GPL(vfs_listxattr);
 
 int
-__vfs_removexattr(struct dentry *dentry, const char *name)
+__vfs_removexattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		  const char *name)
 {
 	struct inode *inode = d_inode(dentry);
 	const struct xattr_handler *handler;
@@ -451,8 +460,8 @@ __vfs_removexattr(struct dentry *dentry, const char *name)
 		return PTR_ERR(handler);
 	if (!handler->set)
 		return -EOPNOTSUPP;
-	return handler->set(handler, &init_user_ns, dentry, inode, name, NULL,
-			    0, XATTR_REPLACE);
+	return handler->set(handler, mnt_userns, dentry, inode, name, NULL, 0,
+			    XATTR_REPLACE);
 }
 EXPORT_SYMBOL(__vfs_removexattr);
 
@@ -466,13 +475,14 @@ EXPORT_SYMBOL(__vfs_removexattr);
  *  a delegation was broken on, NULL if none.
  */
 int
-__vfs_removexattr_locked(struct dentry *dentry, const char *name,
-		struct inode **delegated_inode)
+__vfs_removexattr_locked(struct user_namespace *mnt_userns,
+			 struct dentry *dentry, const char *name,
+			 struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	error = xattr_permission(inode, name, MAY_WRITE);
+	error = xattr_permission(mnt_userns, inode, name, MAY_WRITE);
 	if (error)
 		return error;
 
@@ -484,7 +494,7 @@ __vfs_removexattr_locked(struct dentry *dentry, const char *name,
 	if (error)
 		goto out;
 
-	error = __vfs_removexattr(dentry, name);
+	error = __vfs_removexattr(mnt_userns, dentry, name);
 
 	if (!error) {
 		fsnotify_xattr(dentry);
@@ -497,7 +507,8 @@ __vfs_removexattr_locked(struct dentry *dentry, const char *name,
 EXPORT_SYMBOL_GPL(__vfs_removexattr_locked);
 
 int
-vfs_removexattr(struct dentry *dentry, const char *name)
+vfs_removexattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		const char *name)
 {
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
@@ -505,7 +516,8 @@ vfs_removexattr(struct dentry *dentry, const char *name)
 
 retry_deleg:
 	inode_lock(inode);
-	error = __vfs_removexattr_locked(dentry, name, &delegated_inode);
+	error = __vfs_removexattr_locked(mnt_userns, dentry,
+					 name, &delegated_inode);
 	inode_unlock(inode);
 
 	if (delegated_inode) {
@@ -522,8 +534,9 @@ EXPORT_SYMBOL_GPL(vfs_removexattr);
  * Extended attribute SET operations
  */
 static long
-setxattr(struct dentry *d, const char __user *name, const void __user *value,
-	 size_t size, int flags)
+setxattr(struct user_namespace *mnt_userns, struct dentry *d,
+	 const char __user *name, const void __user *value, size_t size,
+	 int flags)
 {
 	int error;
 	void *kvalue = NULL;
@@ -550,11 +563,10 @@ setxattr(struct dentry *d, const char __user *name, const void __user *value,
 		}
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_from_user(&init_user_ns, kvalue,
-						      size);
+			posix_acl_fix_xattr_from_user(mnt_userns, kvalue, size);
 	}
 
-	error = vfs_setxattr(d, kname, kvalue, size, flags);
+	error = vfs_setxattr(mnt_userns, d, kname, kvalue, size, flags);
 out:
 	kvfree(kvalue);
 
@@ -567,13 +579,15 @@ static int path_setxattr(const char __user *pathname,
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
+		error = setxattr(mnt_user_ns(path.mnt), path.dentry, name,
+				 value, size, flags);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -609,7 +623,9 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 	audit_file(f.file);
 	error = mnt_want_write_file(f.file);
 	if (!error) {
-		error = setxattr(f.file->f_path.dentry, name, value, size, flags);
+		error = setxattr(file_mnt_user_ns(f.file),
+				 f.file->f_path.dentry, name,
+				 value, size, flags);
 		mnt_drop_write_file(f.file);
 	}
 	fdput(f);
@@ -620,8 +636,8 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
  * Extended attribute GET operations
  */
 static ssize_t
-getxattr(struct dentry *d, const char __user *name, void __user *value,
-	 size_t size)
+getxattr(struct user_namespace *mnt_userns, struct dentry *d,
+	 const char __user *name, void __user *value, size_t size)
 {
 	ssize_t error;
 	void *kvalue = NULL;
@@ -641,12 +657,11 @@ getxattr(struct dentry *d, const char __user *name, void __user *value,
 			return -ENOMEM;
 	}
 
-	error = vfs_getxattr(d, kname, kvalue, size);
+	error = vfs_getxattr(mnt_userns, d, kname, kvalue, size);
 	if (error > 0) {
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_to_user(&init_user_ns, kvalue,
-						    error);
+			posix_acl_fix_xattr_to_user(mnt_userns, kvalue, error);
 		if (size && copy_to_user(value, kvalue, error))
 			error = -EFAULT;
 	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
@@ -670,7 +685,7 @@ static ssize_t path_getxattr(const char __user *pathname,
 	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
 		return error;
-	error = getxattr(path.dentry, name, value, size);
+	error = getxattr(mnt_user_ns(path.mnt), path.dentry, name, value, size);
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -700,7 +715,8 @@ SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 	if (!f.file)
 		return error;
 	audit_file(f.file);
-	error = getxattr(f.file->f_path.dentry, name, value, size);
+	error = getxattr(file_mnt_user_ns(f.file), f.file->f_path.dentry,
+			 name, value, size);
 	fdput(f);
 	return error;
 }
@@ -784,7 +800,8 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
  * Extended attribute REMOVE operations
  */
 static long
-removexattr(struct dentry *d, const char __user *name)
+removexattr(struct user_namespace *mnt_userns, struct dentry *d,
+	    const char __user *name)
 {
 	int error;
 	char kname[XATTR_NAME_MAX + 1];
@@ -795,7 +812,7 @@ removexattr(struct dentry *d, const char __user *name)
 	if (error < 0)
 		return error;
 
-	return vfs_removexattr(d, kname);
+	return vfs_removexattr(mnt_userns, d, kname);
 }
 
 static int path_removexattr(const char __user *pathname,
@@ -809,7 +826,7 @@ static int path_removexattr(const char __user *pathname,
 		return error;
 	error = mnt_want_write(path.mnt);
 	if (!error) {
-		error = removexattr(path.dentry, name);
+		error = removexattr(mnt_user_ns(path.mnt), path.dentry, name);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -842,7 +859,8 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 	audit_file(f.file);
 	error = mnt_want_write_file(f.file);
 	if (!error) {
-		error = removexattr(f.file->f_path.dentry, name);
+		error = removexattr(file_mnt_user_ns(f.file),
+				    f.file->f_path.dentry, name);
 		mnt_drop_write_file(f.file);
 	}
 	fdput(f);
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 260c9bcb0edb..4c379d23ec6e 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/user_namespace.h>
 #include <uapi/linux/xattr.h>
 
 struct inode;
@@ -49,18 +50,26 @@ struct xattr {
 };
 
 ssize_t __vfs_getxattr(struct dentry *, struct inode *, const char *, void *, size_t);
-ssize_t vfs_getxattr(struct dentry *, const char *, void *, size_t);
+ssize_t vfs_getxattr(struct user_namespace *, struct dentry *, const char *,
+		     void *, size_t);
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
+int vfs_setxattr(struct user_namespace *, struct dentry *, const char *,
+		 const void *, size_t, int);
+int __vfs_removexattr(struct user_namespace *, struct dentry *, const char *);
+int __vfs_removexattr_locked(struct user_namespace *, struct dentry *,
+			     const char *, struct inode **);
+int vfs_removexattr(struct user_namespace *, struct dentry *, const char *);
 
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
-ssize_t vfs_getxattr_alloc(struct dentry *dentry, const char *name,
+ssize_t vfs_getxattr_alloc(struct user_namespace *mnt_userns,
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
index c3fd9b86ea9a..745dc1f2c97f 100644
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
index 8361941ee0a1..70b643c41c6b 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -94,7 +94,7 @@ static int ima_fix_xattr(struct dentry *dentry,
 		iint->ima_hash->xattr.ng.type = IMA_XATTR_DIGEST_NG;
 		iint->ima_hash->xattr.ng.algo = algo;
 	}
-	rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_IMA,
+	rc = __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_IMA,
 				   &iint->ima_hash->xattr.data[offset],
 				   (sizeof(iint->ima_hash->xattr) - offset) +
 				   iint->ima_hash->length, 0);
@@ -215,8 +215,8 @@ int ima_read_xattr(struct dentry *dentry,
 {
 	ssize_t ret;
 
-	ret = vfs_getxattr_alloc(dentry, XATTR_NAME_IMA, (char **)xattr_value,
-				 0, GFP_NOFS);
+	ret = vfs_getxattr_alloc(&init_user_ns, dentry, XATTR_NAME_IMA,
+				 (char **)xattr_value, 0, GFP_NOFS);
 	if (ret == -EOPNOTSUPP)
 		ret = 0;
 	return ret;
@@ -520,7 +520,7 @@ void ima_inode_post_setattr(struct dentry *dentry)
 
 	action = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR);
 	if (!action)
-		__vfs_removexattr(dentry, XATTR_NAME_IMA);
+		__vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_IMA);
 	iint = integrity_iint_find(inode);
 	if (iint) {
 		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9d6d3da2caf2..2efedd7001b2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6526,7 +6526,8 @@ static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen
  */
 static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0);
+	return __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_SELINUX,
+				     ctx, ctxlen, 0);
 }
 
 static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f69c3dd9a0c6..746e5743accc 100644
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
@@ -4597,12 +4597,14 @@ static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
 static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, ctx, ctxlen, 0);
+	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, ctx,
+				       ctxlen, 0);
 }
 
 static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, ctx, ctxlen, 0);
+	return __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_SMACK,
+				     ctx, ctxlen, 0);
 }
 
 static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
-- 
2.30.0

