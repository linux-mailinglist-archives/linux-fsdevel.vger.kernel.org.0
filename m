Return-Path: <linux-fsdevel+bounces-50950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6350FAD1611
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 01:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C0B1882DD3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 23:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DB2267F58;
	Sun,  8 Jun 2025 23:48:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935AC265606;
	Sun,  8 Jun 2025 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749426530; cv=none; b=sZzY853TilyfEIhP1o70SEtZaf3ajDMlBahjRswh3yOwXvnBv8rF5Em43n1/UKXQWxctro62W1gIBPGPmhmTur5toNdC4KicCmoQV920xJ+KoOqKT7x7Ud9uy+FmP8jldeviz9kDHWdSFDMzjfqUXnAw6jBQUzqwPErXzAFi3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749426530; c=relaxed/simple;
	bh=HeUcgv2B7QYkQQZEeYJCTM24URTICSd2X6u8DNvzPs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzAejU+kPeH7+L6/Grm8eTKHMUiEae0WfP1Rvjx5TQruA4yrtWWroa3RIvrhjYV57PSm6JVM5h48s7e7M1q6p0dErif/Xy9Wjbs638vr9+MA4ZmCP2kGtcNkCS/W3YF67W2jbeRSG3k8YVILmtxh9osfis979kFOpHo093fJo7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOPkq-005xrA-UM;
	Sun, 08 Jun 2025 23:48:44 +0000
From: NeilBrown <neil@brown.name>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] smb/server: add ksmbd_vfs_kern_path()
Date: Mon,  9 Jun 2025 09:35:10 +1000
Message-ID: <20250608234108.30250-5-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608234108.30250-1-neil@brown.name>
References: <20250608234108.30250-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ksmbd_vfs_kern_path_locked() seems to serve two functions
and as a result has an odd interface.

On success it returns with the parent directory locked and with write
access on that filesystem requested, but it may have crossed over a
mount point to return the "path", which makes the lock and the write
access irrelevant.

This patches separates the functionality into two functions:
- ksmbd_vfs_kern_path() does not lock the parent, does not request
  write access, but does cross mount points
- ksmbd_vfs_kern_path_locked() does not cross mount points but
  does lock the parent and request write access.

The parent_path parameter is no longer needed.  For the _locked case
the final path is sufficient to drop write access and to unlock the
parent (using path->dentry->d_parent which is safe while the lock is
held).

There were 3 caller of ksmbd_vfs_kern_path_locked().

- smb2_create_link() needs to remove the target if it existed and
  needs the lock and the write-access, so it continues to use
  ksmbd_vfs_kern_path_locked().  It would not make sense to
  cross mount points in this case.
- smb2_open() is the only user that needs to cross mount points
  and it has no need for the lock or write access, so it now uses
  ksmbd_vfs_kern_path()
- smb2_creat() does not need to cross mountpoints as it is accessing
  a file that it has just created on *this* filesystem.  But also it
  does not need the lock or write access because by the time
  ksmbd_vfs_kern_path_locked() was called it has already created the
  file.  So it could use either interface.  It is simplest to use
  ksmbd_vfs_kern_path().

ksmbd_vfs_kern_path_unlock() is still needed after
ksmbd_vfs_kern_path_locked() but it doesn't require the parent_path any
more.  After a successful call to ksmbd_vfs_kern_path(), only path_put()
is needed to release the path.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/smb/server/smb2pdu.c |  22 +++---
 fs/smb/server/vfs.c     | 156 ++++++++++++++++++++++++++--------------
 fs/smb/server/vfs.h     |   7 +-
 3 files changed, 118 insertions(+), 67 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2e98717a0268..6d2faf19ab96 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2580,7 +2580,7 @@ static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
 	}
 }
 
-static int smb2_creat(struct ksmbd_work *work, struct path *parent_path,
+static int smb2_creat(struct ksmbd_work *work,
 		      struct path *path, char *name, int open_flags,
 		      umode_t posix_mode, bool is_dir)
 {
@@ -2609,7 +2609,7 @@ static int smb2_creat(struct ksmbd_work *work, struct path *parent_path,
 			return rc;
 	}
 
-	rc = ksmbd_vfs_kern_path_locked(work, name, 0, parent_path, path, 0);
+	rc = ksmbd_vfs_kern_path(work, name, 0, path, 0);
 	if (rc) {
 		pr_err("cannot get linux path (%s), err = %d\n",
 		       name, rc);
@@ -2859,7 +2859,7 @@ int smb2_open(struct ksmbd_work *work)
 	struct ksmbd_tree_connect *tcon = work->tcon;
 	struct smb2_create_req *req;
 	struct smb2_create_rsp *rsp;
-	struct path path, parent_path;
+	struct path path;
 	struct ksmbd_share_config *share = tcon->share_conf;
 	struct ksmbd_file *fp = NULL;
 	struct file *filp = NULL;
@@ -3115,8 +3115,8 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out2;
 	}
 
-	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS,
-					&parent_path, &path, 1);
+	rc = ksmbd_vfs_kern_path(work, name, LOOKUP_NO_SYMLINKS,
+				 &path, 1);
 	if (!rc) {
 		file_present = true;
 
@@ -3237,7 +3237,7 @@ int smb2_open(struct ksmbd_work *work)
 
 	/*create file if not present */
 	if (!file_present) {
-		rc = smb2_creat(work, &parent_path, &path, name, open_flags,
+		rc = smb2_creat(work, &path, name, open_flags,
 				posix_mode,
 				req->CreateOptions & FILE_DIRECTORY_FILE_LE);
 		if (rc) {
@@ -3442,7 +3442,7 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 	if (file_present || created)
-		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+		path_put(&path);
 
 	if (!S_ISDIR(file_inode(filp)->i_mode) && open_flags & O_TRUNC &&
 	    !fp->attrib_only && !stream_name) {
@@ -3723,7 +3723,7 @@ int smb2_open(struct ksmbd_work *work)
 
 err_out:
 	if (rc && (file_present || created))
-		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+		path_put(&path);
 
 err_out1:
 	ksmbd_revert_fsids(work);
@@ -6008,7 +6008,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 			    struct nls_table *local_nls)
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
-	struct path path, parent_path;
+	struct path path;
 	int rc;
 
 	if (buf_len < (u64)sizeof(struct smb2_file_link_info) +
@@ -6037,7 +6037,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 
 	ksmbd_debug(SMB, "target name is %s\n", target_name);
 	rc = ksmbd_vfs_kern_path_locked(work, link_name, LOOKUP_NO_SYMLINKS,
-					&parent_path, &path, 0);
+					&path, 0);
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
@@ -6055,7 +6055,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 			ksmbd_debug(SMB, "link already exists\n");
 			goto out;
 		}
-		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+		ksmbd_vfs_kern_path_unlock(&path);
 	}
 	rc = ksmbd_vfs_link(work, target_name, link_name);
 	if (rc)
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 654c2f14a9e6..a5599d2e9ab0 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -66,10 +66,9 @@ int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
 	return 0;
 }
 
-static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
-					char *pathname, unsigned int flags,
-					struct path *parent_path,
-					struct path *path)
+static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
+				 char *pathname, unsigned int flags,
+				 struct path *path, bool do_lock)
 {
 	struct qstr last;
 	struct filename *filename;
@@ -89,51 +88,58 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 		return PTR_ERR(filename);
 
 	err = vfs_path_parent_lookup(filename, flags,
-				     parent_path, &last, &type,
+				     path, &last, &type,
 				     root_share_path);
-	if (err) {
-		putname(filename);
+	putname(filename);
+	if (err)
 		return err;
-	}
 
 	if (unlikely(type != LAST_NORM)) {
-		path_put(parent_path);
-		putname(filename);
-		return -ENOENT;
-	}
-
-	err = mnt_want_write(parent_path->mnt);
-	if (err) {
-		path_put(parent_path);
-		putname(filename);
+		path_put(path);
 		return -ENOENT;
 	}
 
-	inode_lock_nested(parent_path->dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path->dentry, 0);
-	if (IS_ERR(d))
-		goto err_out;
+	if (do_lock) {
+		err = mnt_want_write(path->mnt);
+		if (err) {
+			path_put(path);
+			return -ENOENT;
+		}
 
-	path->dentry = d;
-	path->mnt = mntget(parent_path->mnt);
+		inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
+		d = lookup_one_qstr_excl(&last, path->dentry, 0);
 
-	if (test_share_config_flag(share_conf, KSMBD_SHARE_FLAG_CROSSMNT)) {
-		err = follow_down(path, 0);
-		if (err < 0) {
+		if (!IS_ERR(d)) {
+			dput(path->dentry);
+			path->dentry = d;
+			return 0;
+		}
+		inode_unlock(path->dentry->d_inode);
+		mnt_drop_write(path->mnt);
+		path_put(path);
+		return -ENOENT;
+	} else {
+		d = lookup_noperm_unlocked(&last, path->dentry);
+		if (!IS_ERR(d) && d_is_negative(d)) {
+			dput(d);
+			d = ERR_PTR(-ENOENT);
+		}
+		if (IS_ERR(d)) {
 			path_put(path);
-			goto err_out;
+			return -ENOENT;
 		}
+		dput(path->dentry);
+		path->dentry = d;
+
+		if (test_share_config_flag(share_conf, KSMBD_SHARE_FLAG_CROSSMNT)) {
+			err = follow_down(path, 0);
+			if (err < 0) {
+				path_put(path);
+				return -ENOENT;
+			}
+		}
+		return 0;
 	}
-
-	putname(filename);
-	return 0;
-
-err_out:
-	inode_unlock(d_inode(parent_path->dentry));
-	mnt_drop_write(parent_path->mnt);
-	path_put(parent_path);
-	putname(filename);
-	return -ENOENT;
 }
 
 void ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
@@ -1202,33 +1208,33 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
  * @work:	work
  * @name:		file path that is relative to share
  * @flags:		lookup flags
- * @parent_path:	if lookup succeed, return parent_path info
  * @path:		if lookup succeed, return path info
  * @caseless:	caseless filename lookup
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *filepath,
-			       unsigned int flags, struct path *parent_path,
-			       struct path *path, bool caseless)
+static
+int __ksmbd_vfs_kern_path(struct ksmbd_work *work, char *filepath,
+			  unsigned int flags,
+			  struct path *path, bool caseless, bool do_lock)
 {
 	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
+	struct path parent_path;
 	size_t path_len, remain_len;
 	int err;
 
 retry:
-	err = ksmbd_vfs_path_lookup_locked(share_conf, filepath, flags, parent_path,
-					   path);
+	err = ksmbd_vfs_path_lookup(share_conf, filepath, flags, path, do_lock);
 	if (!err || !caseless)
 		return err;
 
 	path_len = strlen(filepath);
 	remain_len = path_len;
 
-	*parent_path = share_conf->vfs_path;
-	path_get(parent_path);
+	parent_path = share_conf->vfs_path;
+	path_get(&parent_path);
 
-	while (d_can_lookup(parent_path->dentry)) {
+	while (d_can_lookup(parent_path.dentry)) {
 		char *filename = filepath + path_len - remain_len;
 		char *next = strchrnul(filename, '/');
 		size_t filename_len = next - filename;
@@ -1237,10 +1243,10 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *filepath,
 		if (filename_len == 0)
 			break;
 
-		err = ksmbd_vfs_lookup_in_dir(parent_path, filename,
+		err = ksmbd_vfs_lookup_in_dir(&parent_path, filename,
 					      filename_len,
 					      work->conn->um);
-		path_put(parent_path);
+		path_put(&parent_path);
 		if (err)
 			goto out;
 		if (is_last) {
@@ -1253,7 +1259,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *filepath,
 				      share_conf->vfs_path.mnt,
 				      filepath,
 				      flags,
-				      parent_path);
+				      &parent_path);
 		next[0] = '/';
 		if (err)
 			goto out;
@@ -1262,17 +1268,59 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *filepath,
 	}
 
 	err = -EINVAL;
-	path_put(parent_path);
+	path_put(&parent_path);
 out:
 	return err;
 }
 
-void ksmbd_vfs_kern_path_unlock(struct path *parent_path, struct path *path)
+/**
+ * ksmbd_vfs_kern_path() - lookup a file and get path info
+ * @work:	work
+ * @name:		file path that is relative to share
+ * @flags:		lookup flags
+ * @path:		if lookup succeed, return path info
+ * @caseless:	caseless filename lookup
+ *
+ * Perform the lookup, possibly crossing over any mount point.
+ * On return no locks will be held and write-access to filesystem
+ * won't have been checked.
+ * Return:	0 if file was found, otherwise error
+ */
+int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *filepath,
+			unsigned int flags,
+			struct path *path, bool caseless)
+{
+	return __ksmbd_vfs_kern_path(work, filepath, flags, path,
+				     caseless, false);
+}
+
+/**
+ * ksmbd_vfs_kern_path_locked() - lookup a file and get path info
+ * @work:	work
+ * @name:		file path that is relative to share
+ * @flags:		lookup flags
+ * @path:		if lookup succeed, return path info
+ * @caseless:	caseless filename lookup
+ *
+ * Perform the lookup, but don't cross over any mount point.
+ * On return the parent of path->dentry will be locked and write-access to
+ * filesystem will have been gained.
+ * Return:	0 on if file was found, otherwise error
+ */
+int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *filepath,
+			       unsigned int flags,
+			       struct path *path, bool caseless)
+{
+	return __ksmbd_vfs_kern_path(work, filepath, flags, path,
+				     caseless, true);
+}
+
+void ksmbd_vfs_kern_path_unlock(struct path *path)
 {
-	inode_unlock(d_inode(parent_path->dentry));
-	mnt_drop_write(parent_path->mnt);
+	/* While lock is still held, ->d_parent is safe */
+	inode_unlock(d_inode(path->dentry->d_parent));
+	mnt_drop_write(path->mnt);
 	path_put(path);
-	path_put(parent_path);
 }
 
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 2893f59803a6..d47472f3e30b 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -117,10 +117,13 @@ int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
 			   const struct path *path, char *attr_name,
 			   bool get_write);
+int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
+			unsigned int flags,
+			struct path *path, bool caseless);
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
-			       unsigned int flags, struct path *parent_path,
+			       unsigned int flags,
 			       struct path *path, bool caseless);
-void ksmbd_vfs_kern_path_unlock(struct path *parent_path, struct path *path);
+void ksmbd_vfs_kern_path_unlock(struct path *path);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
-- 
2.49.0


