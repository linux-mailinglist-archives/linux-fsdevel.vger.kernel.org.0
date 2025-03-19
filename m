Return-Path: <linux-fsdevel+bounces-44403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38581A6839C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 04:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9983423A5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 03:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE6A24DFF6;
	Wed, 19 Mar 2025 03:16:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242520DD65;
	Wed, 19 Mar 2025 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354170; cv=none; b=LGr0gJmM5w0eY3RUVA0nN0CuHR3CXLYEcmCXU/EWwNl7VenuilCwk517YEA/rjn2uN316LQ6Whyb0p8SGsEokmSgb4hEKFE34JTWa5s4uj8NYl9MtA4jN6fSmABaFvbb0YmxY4stm0VW0lInwsgPVyDPSLSFBTdLYOTHrO5kelg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354170; c=relaxed/simple;
	bh=i2C6e0R+h5HigK1EMJTyr6V0zwaF1vkYqkrBPiUFgFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9heSASgJUfX7zOd4OW+1p1KJAsJPCnu0xe+n1sIu0SIop+lUIfY1ETY8QAXwqqPIOe/jr48yeQy3tFewNNLXczU6NNten69nHSvxYiZSyQDZK6yL4Gu+N/HbBfp3tyt3aVoX0iEUl3nk8atTyLeyGwVBg+FbTARt9ZoRBqZveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tujuN-00G6oh-GC;
	Wed, 19 Mar 2025 03:15:55 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/6] VFS: improve interface for lookup_one functions
Date: Wed, 19 Mar 2025 14:01:32 +1100
Message-ID: <20250319031545.2999807-2-neil@brown.name>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319031545.2999807-1-neil@brown.name>
References: <20250319031545.2999807-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The family of functions:
  lookup_one()
  lookup_one_unlocked()
  lookup_one_positive_unlocked()

appear designed to be used by external clients of the filesystem rather
than by filesystems acting on themselves as the lookup_one_len family
are used.

They are used by:
   btrfs/ioctl - which is a user-space interface rather than an internal
     activity
   exportfs - i.e. from nfsd or the open_by_handle_at interface
   overlayfs - at access the underlying filesystems
   smb/server - for file service

They should be used by nfsd (more than just the exportfs path) and
cachefs but aren't.

It would help if the documentation didn't claim they should "not be
called by generic code".

Also the path component name is passed as "name" and "len" which are
(confusingly?) separate by the "base".  In some cases the len in simply
"strlen" and so passing a qstr using QSTR() would make the calling
clearer.
Other callers do pass separate name and len which are stored in a
struct.  Sometimes these are already stored in a qstr, other times it
easily could be.

So this patch changes these three functions to receive a 'struct qstr',
and improves the documentation.

QSTR_LEN() is added to make it easy to pass a QSTR containing a known
len.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  9 +++++
 fs/btrfs/ioctl.c                      |  9 ++---
 fs/exportfs/expfs.c                   |  5 ++-
 fs/namei.c                            | 51 ++++++++++++---------------
 fs/overlayfs/namei.c                  | 10 +++---
 fs/overlayfs/overlayfs.h              |  2 +-
 fs/overlayfs/readdir.c                |  9 ++---
 fs/smb/server/smb2pdu.c               |  7 ++--
 include/linux/dcache.h                |  3 +-
 include/linux/namei.h                 |  9 +++--
 10 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 6817614e0820..06296ffd1e81 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1196,3 +1196,12 @@ should use d_drop();d_splice_alias() and return the result of the latter.
 If a positive dentry cannot be returned for some reason, in-kernel
 clients such as cachefiles, nfsd, smb/server may not perform ideally but
 will fail-safe.
+
+---
+
+** mandatory**
+
+lookup_one(), lookup_one_unlocked(), lookup_one_positive_unlocked() now
+take a qstr instead of a name and len.  These, not the "one_len"
+versions, should be used whenever accessing a filesystem from outside
+that filesysmtem, through a mount point - which will have a mnt_idmap.
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..f94b638f9478 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -911,7 +911,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	if (error == -EINTR)
 		return error;
 
-	dentry = lookup_one(idmap, name, parent->dentry, namelen);
+	dentry = lookup_one(idmap, QSTR_LEN(name, namelen), parent->dentry);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_unlock;
@@ -2289,7 +2289,6 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	struct btrfs_ioctl_vol_args_v2 *vol_args2 = NULL;
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	char *subvol_name, *subvol_name_ptr = NULL;
-	int subvol_namelen;
 	int ret = 0;
 	bool destroy_parent = false;
 
@@ -2412,10 +2411,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 			goto out;
 	}
 
-	subvol_namelen = strlen(subvol_name);
-
 	if (strchr(subvol_name, '/') ||
-	    strncmp(subvol_name, "..", subvol_namelen) == 0) {
+	    strcmp(subvol_name, "..") == 0) {
 		ret = -EINVAL;
 		goto free_subvol_name;
 	}
@@ -2428,7 +2425,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	ret = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
 	if (ret == -EINTR)
 		goto free_subvol_name;
-	dentry = lookup_one(idmap, subvol_name, parent, subvol_namelen);
+	dentry = lookup_one(idmap, QSTR(subvol_name), parent);
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
 		goto out_unlock_dir;
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 0c899cfba578..974b432087aa 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -145,7 +145,7 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
 	if (err)
 		goto out_err;
 	dprintk("%s: found name: %s\n", __func__, nbuf);
-	tmp = lookup_one_unlocked(mnt_idmap(mnt), nbuf, parent, strlen(nbuf));
+	tmp = lookup_one_unlocked(mnt_idmap(mnt), QSTR(nbuf), parent);
 	if (IS_ERR(tmp)) {
 		dprintk("lookup failed: %ld\n", PTR_ERR(tmp));
 		err = PTR_ERR(tmp);
@@ -551,8 +551,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 		}
 
 		inode_lock(target_dir->d_inode);
-		nresult = lookup_one(mnt_idmap(mnt), nbuf,
-				     target_dir, strlen(nbuf));
+		nresult = lookup_one(mnt_idmap(mnt), QSTR(nbuf), target_dir);
 		if (!IS_ERR(nresult)) {
 			if (unlikely(nresult->d_inode != result->d_inode)) {
 				dput(nresult);
diff --git a/fs/namei.c b/fs/namei.c
index b5abf456c5f4..75816fa80028 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2922,19 +2922,17 @@ struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
 EXPORT_SYMBOL(lookup_one_len);
 
 /**
- * lookup_one - filesystem helper to lookup single pathname component
+ * lookup_one - lookup single pathname component
  * @idmap:	idmap of the mount the lookup is performed from
- * @name:	pathname component to lookup
+ * @name:	qstr holding pathname component to lookup
  * @base:	base directory to lookup from
- * @len:	maximum length @len should be interpreted to
  *
- * Note that this routine is purely a helper for filesystem usage and should
- * not be called by generic code.
+ * This can be used for in-kernel filesystem clients such as file servers.
  *
  * The caller must hold base->i_mutex.
  */
-struct dentry *lookup_one(struct mnt_idmap *idmap, const char *name,
-			  struct dentry *base, int len)
+struct dentry *lookup_one(struct mnt_idmap *idmap, struct qstr name,
+			  struct dentry *base)
 {
 	struct dentry *dentry;
 	struct qstr this;
@@ -2942,7 +2940,7 @@ struct dentry *lookup_one(struct mnt_idmap *idmap, const char *name,
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_common(idmap, name, base, len, &this);
+	err = lookup_one_common(idmap, name.name, base, name.len, &this);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2952,27 +2950,24 @@ struct dentry *lookup_one(struct mnt_idmap *idmap, const char *name,
 EXPORT_SYMBOL(lookup_one);
 
 /**
- * lookup_one_unlocked - filesystem helper to lookup single pathname component
+ * lookup_one_unlocked - lookup single pathname component
  * @idmap:	idmap of the mount the lookup is performed from
- * @name:	pathname component to lookup
+ * @name:	qstr olding pathname component to lookup
  * @base:	base directory to lookup from
- * @len:	maximum length @len should be interpreted to
  *
- * Note that this routine is purely a helper for filesystem usage and should
- * not be called by generic code.
+ * This can be used for in-kernel filesystem clients such as file servers.
  *
  * Unlike lookup_one_len, it should be called without the parent
- * i_mutex held, and will take the i_mutex itself if necessary.
+ * i_rwsem held, and will take the i_rwsem itself if necessary.
  */
 struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
-				   const char *name, struct dentry *base,
-				   int len)
+				   struct qstr name, struct dentry *base)
 {
 	struct qstr this;
 	int err;
 	struct dentry *ret;
 
-	err = lookup_one_common(idmap, name, base, len, &this);
+	err = lookup_one_common(idmap, name.name, base, name.len, &this);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2984,12 +2979,10 @@ struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 EXPORT_SYMBOL(lookup_one_unlocked);
 
 /**
- * lookup_one_positive_unlocked - filesystem helper to lookup single
- *				  pathname component
+ * lookup_one_positive_unlocked - lookup single pathname component
  * @idmap:	idmap of the mount the lookup is performed from
- * @name:	pathname component to lookup
+ * @name:	qstr holding pathname component to lookup
  * @base:	base directory to lookup from
- * @len:	maximum length @len should be interpreted to
  *
  * This helper will yield ERR_PTR(-ENOENT) on negatives. The helper returns
  * known positive or ERR_PTR(). This is what most of the users want.
@@ -2998,16 +2991,15 @@ EXPORT_SYMBOL(lookup_one_unlocked);
  * time, so callers of lookup_one_unlocked() need to be very careful; pinned
  * positives have >d_inode stable, so this one avoids such problems.
  *
- * Note that this routine is purely a helper for filesystem usage and should
- * not be called by generic code.
+ * This can be used for in-kernel filesystem clients such as file servers.
  *
- * The helper should be called without i_mutex held.
+ * The helper should be called without i_rwsem held.
  */
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
-					    const char *name,
-					    struct dentry *base, int len)
+					    struct qstr name,
+					    struct dentry *base)
 {
-	struct dentry *ret = lookup_one_unlocked(idmap, name, base, len);
+	struct dentry *ret = lookup_one_unlocked(idmap, name, base);
 
 	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
 		dput(ret);
@@ -3032,7 +3024,7 @@ EXPORT_SYMBOL(lookup_one_positive_unlocked);
 struct dentry *lookup_one_len_unlocked(const char *name,
 				       struct dentry *base, int len)
 {
-	return lookup_one_unlocked(&nop_mnt_idmap, name, base, len);
+	return lookup_one_unlocked(&nop_mnt_idmap, QSTR_LEN(name, len), base);
 }
 EXPORT_SYMBOL(lookup_one_len_unlocked);
 
@@ -3047,7 +3039,8 @@ EXPORT_SYMBOL(lookup_one_len_unlocked);
 struct dentry *lookup_positive_unlocked(const char *name,
 				       struct dentry *base, int len)
 {
-	return lookup_one_positive_unlocked(&nop_mnt_idmap, name, base, len);
+	return lookup_one_positive_unlocked(&nop_mnt_idmap, QSTR_LEN(name, len),
+					    base);
 }
 EXPORT_SYMBOL(lookup_positive_unlocked);
 
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index be5c65d6f848..6a6301e4bba5 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -205,8 +205,8 @@ static struct dentry *ovl_lookup_positive_unlocked(struct ovl_lookup_data *d,
 						   struct dentry *base, int len,
 						   bool drop_negative)
 {
-	struct dentry *ret = lookup_one_unlocked(mnt_idmap(d->layer->mnt), name,
-						 base, len);
+	struct dentry *ret = lookup_one_unlocked(mnt_idmap(d->layer->mnt),
+						 QSTR_LEN(name, len), base);
 
 	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
 		if (drop_negative && ret->d_lockref.count == 1) {
@@ -789,8 +789,8 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 	if (err)
 		return ERR_PTR(err);
 
-	index = lookup_one_positive_unlocked(ovl_upper_mnt_idmap(ofs), name.name,
-					     ofs->workdir, name.len);
+	index = lookup_one_positive_unlocked(ovl_upper_mnt_idmap(ofs), name,
+					     ofs->workdir);
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
 		if (err == -ENOENT) {
@@ -1396,7 +1396,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 
 		this = lookup_one_positive_unlocked(
 				mnt_idmap(parentpath->layer->mnt),
-				name->name, parentpath->dentry, name->len);
+				*name, parentpath->dentry);
 		if (IS_ERR(this)) {
 			switch (PTR_ERR(this)) {
 			case -ENOENT:
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6f2f8f4cfbbc..ceaf4eb199c7 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -402,7 +402,7 @@ static inline struct dentry *ovl_lookup_upper(struct ovl_fs *ofs,
 					      const char *name,
 					      struct dentry *base, int len)
 {
-	return lookup_one(ovl_upper_mnt_idmap(ofs), name, base, len);
+	return lookup_one(ovl_upper_mnt_idmap(ofs), QSTR_LEN(name, len), base);
 }
 
 static inline bool ovl_open_flags_need_copy_up(int flags)
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 881ec5592da5..68df61f4bba7 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -271,7 +271,6 @@ static bool ovl_fill_merge(struct dir_context *ctx, const char *name,
 static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data *rdd)
 {
 	int err;
-	struct ovl_cache_entry *p;
 	struct dentry *dentry, *dir = path->dentry;
 	const struct cred *old_cred;
 
@@ -280,9 +279,11 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 	err = down_write_killable(&dir->d_inode->i_rwsem);
 	if (!err) {
 		while (rdd->first_maybe_whiteout) {
-			p = rdd->first_maybe_whiteout;
+			struct ovl_cache_entry *p =
+				rdd->first_maybe_whiteout;
 			rdd->first_maybe_whiteout = p->next_maybe_whiteout;
-			dentry = lookup_one(mnt_idmap(path->mnt), p->name, dir, p->len);
+			dentry = lookup_one(mnt_idmap(path->mnt),
+					    QSTR_LEN(p->name, p->len), dir);
 			if (!IS_ERR(dentry)) {
 				p->is_whiteout = ovl_is_whiteout(dentry);
 				dput(dentry);
@@ -492,7 +493,7 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
 		}
 	}
 	/* This checks also for xwhiteouts */
-	this = lookup_one(mnt_idmap(path->mnt), p->name, dir, p->len);
+	this = lookup_one(mnt_idmap(path->mnt), QSTR_LEN(p->name, p->len), dir);
 	if (IS_ERR_OR_NULL(this) || !this->d_inode) {
 		/* Mark a stale entry */
 		p->is_whiteout = true;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f1efcd027475..c862e3bd4531 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4091,9 +4091,10 @@ static int process_query_dir_entries(struct smb2_query_dir_private *priv)
 			return -EINVAL;
 
 		lock_dir(priv->dir_fp);
-		dent = lookup_one(idmap, priv->d_info->name,
-				  priv->dir_fp->filp->f_path.dentry,
-				  priv->d_info->name_len);
+		dent = lookup_one(idmap,
+				  QSTR_LEN(priv->d_info->name,
+					   priv->d_info->name_len),
+				  priv->dir_fp->filp->f_path.dentry);
 		unlock_dir(priv->dir_fp);
 
 		if (IS_ERR(dent)) {
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 45bff10d3773..1f01f4e734c5 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -57,7 +57,8 @@ struct qstr {
 };
 
 #define QSTR_INIT(n,l) { { { .len = l } }, .name = n }
-#define QSTR(n) (struct qstr)QSTR_INIT(n, strlen(n))
+#define QSTR_LEN(n,l) (struct qstr)QSTR_INIT(n,l)
+#define QSTR(n) QSTR_LEN(n, strlen(n))
 
 extern const struct qstr empty_name;
 extern const struct qstr slash_name;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index e3042176cdf4..508dae67e3c5 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -73,13 +73,12 @@ extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
 extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
-struct dentry *lookup_one(struct mnt_idmap *, const char *, struct dentry *, int);
+struct dentry *lookup_one(struct mnt_idmap *, struct qstr, struct dentry *);
 struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
-				   const char *name, struct dentry *base,
-				   int len);
+				   struct qstr name, struct dentry *base);
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
-					    const char *name,
-					    struct dentry *base, int len);
+					    struct qstr name,
+					    struct dentry *base);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
-- 
2.48.1


