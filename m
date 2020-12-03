Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD52CE3A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 01:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbgLDACk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 19:02:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41851 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389191AbgLDACe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:02:34 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kkyXl-0007ka-7z; Fri, 04 Dec 2020 00:01:49 +0000
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
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 19/40] namei: introduce struct renamedata
Date:   Fri,  4 Dec 2020 00:57:15 +0100
Message-Id: <20201203235736.3528991-20-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
References: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to handle idmapped mounts we will extend the vfs rename helper
to take two new arguments in follow up patches. Since this operations
already takes a bunch of arguments add a simple struct renamedata (based
on struct nameidata) and make the current helper use it before we extend
it.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged

/* v4 */
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.

- Christoph Hellwig <hch@lst.de>:
  - Declare variable on separate lines instead of chaining them and
    wrapping with weird indentation.
---
 fs/cachefiles/namei.c    |  9 +++++++--
 fs/ecryptfs/inode.c      | 10 +++++++---
 fs/namei.c               | 21 +++++++++++++++------
 fs/nfsd/vfs.c            |  8 +++++++-
 fs/overlayfs/overlayfs.h |  9 ++++++++-
 include/linux/fs.h       | 12 +++++++++++-
 6 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index ecc8ecbbfa5a..7b987de0babe 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -412,9 +412,14 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 	if (ret < 0) {
 		cachefiles_io_error(cache, "Rename security error %d", ret);
 	} else {
+		struct renamedata rd = {
+			.old_dir	= d_inode(dir),
+			.old_dentry	= rep,
+			.new_dir	= d_inode(cache->graveyard),
+			.new_dentry	= grave,
+		};
 		trace_cachefiles_rename(object, rep, grave, why);
-		ret = vfs_rename(d_inode(dir), rep,
-				 d_inode(cache->graveyard), grave, NULL, 0);
+		ret = vfs_rename(&rd);
 		if (ret != 0 && ret != -ENOMEM)
 			cachefiles_io_error(cache,
 					    "Rename failed with error %d", ret);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 0a218d7c3023..0697480ee2eb 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -590,6 +590,7 @@ ecryptfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct dentry *lower_new_dir_dentry;
 	struct dentry *trap;
 	struct inode *target_inode;
+	struct renamedata rd = {};
 
 	if (flags)
 		return -EINVAL;
@@ -619,9 +620,12 @@ ecryptfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		rc = -ENOTEMPTY;
 		goto out_lock;
 	}
-	rc = vfs_rename(d_inode(lower_old_dir_dentry), lower_old_dentry,
-			d_inode(lower_new_dir_dentry), lower_new_dentry,
-			NULL, 0);
+
+	rd.old_dir	= d_inode(lower_old_dir_dentry);
+	rd.old_dentry	= lower_old_dentry;
+	rd.new_dir	= d_inode(lower_new_dir_dentry);
+	rd.new_dentry	= lower_new_dentry;
+	rc = vfs_rename(&rd);
 	if (rc)
 		goto out_lock;
 	if (target_inode)
diff --git a/fs/namei.c b/fs/namei.c
index a023d35174bd..453920b493b0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4307,12 +4307,15 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *	   ->i_mutex on parents, which works but leads to some truly excessive
  *	   locking].
  */
-int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-	       struct inode *new_dir, struct dentry *new_dentry,
-	       struct inode **delegated_inode, unsigned int flags)
+int vfs_rename(struct renamedata *rd)
 {
 	int error;
 	struct user_namespace *mnt_userns = &init_user_ns;
+	struct inode *old_dir = rd->old_dir, *new_dir = rd->new_dir;
+	struct dentry *old_dentry = rd->old_dentry;
+	struct dentry *new_dentry = rd->new_dentry;
+	struct inode **delegated_inode = rd->delegated_inode;
+	unsigned int flags = rd->flags;
 	bool is_dir = d_is_dir(old_dentry);
 	struct inode *source = old_dentry->d_inode;
 	struct inode *target = new_dentry->d_inode;
@@ -4436,6 +4439,7 @@ EXPORT_SYMBOL(vfs_rename);
 static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
 			const char __user *newname, unsigned int flags)
 {
+	struct renamedata rd;
 	struct dentry *old_dentry, *new_dentry;
 	struct dentry *trap;
 	struct path old_path, new_path;
@@ -4541,9 +4545,14 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
 				     &new_path, new_dentry, flags);
 	if (error)
 		goto exit5;
-	error = vfs_rename(old_path.dentry->d_inode, old_dentry,
-			   new_path.dentry->d_inode, new_dentry,
-			   &delegated_inode, flags);
+
+	rd.old_dir	   = old_path.dentry->d_inode;
+	rd.old_dentry	   = old_dentry;
+	rd.new_dir	   = new_path.dentry->d_inode;
+	rd.new_dentry	   = new_dentry;
+	rd.delegated_inode = &delegated_inode;
+	rd.flags	   = flags;
+	error = vfs_rename(&rd);
 exit5:
 	dput(new_dentry);
 exit4:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9a0e0e5b34f5..3d7a8cd61098 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1787,7 +1787,13 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		has_cached = true;
 		goto out_dput_old;
 	} else {
-		host_err = vfs_rename(fdir, odentry, tdir, ndentry, NULL, 0);
+		struct renamedata rd = {
+			.old_dir	= fdir,
+			.old_dentry	= odentry,
+			.new_dir	= tdir,
+			.new_dentry	= ndentry,
+		};
+		host_err = vfs_rename(&rd);
 		if (!host_err) {
 			host_err = commit_metadata(tfhp);
 			if (!host_err)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index bf26fb3fa2c1..73da8710b0f0 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -212,9 +212,16 @@ static inline int ovl_do_rename(struct inode *olddir, struct dentry *olddentry,
 				unsigned int flags)
 {
 	int err;
+	struct renamedata rd = {
+		.old_dir 	= olddir,
+		.old_dentry 	= olddentry,
+		.new_dir 	= newdir,
+		.new_dentry 	= newdentry,
+		.flags 		= flags,
+	};
 
 	pr_debug("rename(%pd2, %pd2, 0x%x)\n", olddentry, newdentry, flags);
-	err = vfs_rename(olddir, olddentry, newdir, newdentry, NULL, flags);
+	err = vfs_rename(&rd);
 	if (err) {
 		pr_debug("...rename(%pd2, %pd2, ...) = %i\n",
 			 olddentry, newdentry, err);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index db6a1137856d..6f0fb7d8d2c4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1776,7 +1776,17 @@ extern int vfs_symlink(struct inode *, struct dentry *, const char *);
 extern int vfs_link(struct dentry *, struct inode *, struct dentry *, struct inode **);
 extern int vfs_rmdir(struct inode *, struct dentry *);
 extern int vfs_unlink(struct inode *, struct dentry *, struct inode **);
-extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *, struct inode **, unsigned int);
+
+struct renamedata {
+	struct inode *old_dir;
+	struct dentry *old_dentry;
+	struct inode *new_dir;
+	struct dentry *new_dentry;
+	struct inode **delegated_inode;
+	unsigned int flags;
+} __randomize_layout;
+
+extern int vfs_rename(struct renamedata *);
 
 static inline int vfs_whiteout(struct inode *dir, struct dentry *dentry)
 {
-- 
2.29.2

