Return-Path: <linux-fsdevel+bounces-41702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74443A35632
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 06:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0B73AE0A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 05:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8D615DBC1;
	Fri, 14 Feb 2025 05:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0uN+4HIp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Sq+lrFw9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0uN+4HIp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Sq+lrFw9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C41885BE;
	Fri, 14 Feb 2025 05:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739510572; cv=none; b=aXQ2mxbBJDyisB/9R1NHk0jUwvgGFn47gohu6LpeOYRkseN/0wPRXpv6iSaacqvoOrrAwCfCILrC+nMmZR4SM5yWJ49ADA6lebvAbipzzrGtA/yFnD5NVNboOir8sLXjrBCiNDYmetKBReWZt1y5cMXHLKjR8DFZs91eDqw4iI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739510572; c=relaxed/simple;
	bh=UIZwOpiDNjI4UfEV7vDficM/cB4LK4rUsH1idKSqrEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxTcGnTwMAFPERxedLnXStFEiNlB21PIbOZYkhXKcXFi3JDTjTbfn+rWTHrp1PlV1CZ7qOEC1jZmTIc7MnOuJId/P4tinP/QQ2RaUvZfsiou2R/VxDf2TXTwmxm9FhZPeK5V8gf+try5i7oalbjYnzNGrT/tSxaE9rza9A30amA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0uN+4HIp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Sq+lrFw9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0uN+4HIp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Sq+lrFw9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3E5C1F797;
	Fri, 14 Feb 2025 05:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739510568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoxUWLT6VcbPMv74Br1z1AZAGtUhmZw41uccBqEdJA4=;
	b=0uN+4HIpHMnBLPXOWa9SuXc1oS1buA2/taC6GANOIvhmT7JTUMlBeE8Gdj1sPgOGnUT5e+
	YnLDkbxAaPEhCxDbXO7wkO9bQhtQrTLhx+tWTOvmVfwhFFepgARh/A+cZ1KlOfTARwOdeD
	CJfELZ/QrVO4KUHPhk+ifCMgQ7n9w74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739510568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoxUWLT6VcbPMv74Br1z1AZAGtUhmZw41uccBqEdJA4=;
	b=Sq+lrFw9aL5fLPeSdS8GaaayTGOGn3kc4rT7oISFdgBpTCFWqWVN2WcvBJDUXV7NMOaw2D
	j5Xs2arIFDfeA1AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739510568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoxUWLT6VcbPMv74Br1z1AZAGtUhmZw41uccBqEdJA4=;
	b=0uN+4HIpHMnBLPXOWa9SuXc1oS1buA2/taC6GANOIvhmT7JTUMlBeE8Gdj1sPgOGnUT5e+
	YnLDkbxAaPEhCxDbXO7wkO9bQhtQrTLhx+tWTOvmVfwhFFepgARh/A+cZ1KlOfTARwOdeD
	CJfELZ/QrVO4KUHPhk+ifCMgQ7n9w74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739510568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoxUWLT6VcbPMv74Br1z1AZAGtUhmZw41uccBqEdJA4=;
	b=Sq+lrFw9aL5fLPeSdS8GaaayTGOGn3kc4rT7oISFdgBpTCFWqWVN2WcvBJDUXV7NMOaw2D
	j5Xs2arIFDfeA1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23984137DB;
	Fri, 14 Feb 2025 05:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NvnTMiXTrmdbbwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 14 Feb 2025 05:22:45 +0000
From: NeilBrown <neilb@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] VFS: Change vfs_mkdir() to return the dentry.
Date: Fri, 14 Feb 2025 16:16:43 +1100
Message-ID: <20250214052204.3105610-4-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250214052204.3105610-1-neilb@suse.de>
References: <20250214052204.3105610-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

vfs_mkdir() does not guarantee to leave the child dentry hashed or make
it positive on success.  It may leave it unhashed and negative and then
the caller needs to perform a lookup to find the target dentry, if it
needs it.

This patch changes vfs_mkdir() to return the dentry provided by the
filesystems which IS guaranteed to be hashed.  This avoids the need for
lookup code.

If a different dentry is returned, the first one is put.  If necessary
the fact that it is new can be determined by comparing pointers.  A new
dentry will certainly have a new pointer (as the old is put after the
new is obtained).

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/base/devtmpfs.c  |  7 +++----
 fs/cachefiles/namei.c    | 11 ++++------
 fs/ecryptfs/inode.c      |  8 ++++---
 fs/init.c                |  6 ++++--
 fs/namei.c               | 45 ++++++++++++++++++++++++++--------------
 fs/nfsd/nfs4recover.c    |  6 ++++--
 fs/nfsd/vfs.c            | 25 ++++++----------------
 fs/overlayfs/dir.c       | 37 ++++-----------------------------
 fs/overlayfs/overlayfs.h | 15 +++++++-------
 fs/overlayfs/super.c     |  5 +++--
 fs/smb/server/vfs.c      | 25 +++++-----------------
 fs/xfs/scrub/orphanage.c |  7 ++++---
 include/linux/fs.h       |  4 ++--
 13 files changed, 80 insertions(+), 121 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index c9e34842139f..8ec756b5dec4 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -160,18 +160,17 @@ static int dev_mkdir(const char *name, umode_t mode)
 {
 	struct dentry *dentry;
 	struct path path;
-	int err;
 
 	dentry = kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTORY);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	err = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
-	if (!err)
+	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
+	if (!IS_ERR(dentry))
 		/* mark as kernel-created inode */
 		d_inode(dentry)->i_private = &thread;
 	done_path_create(&path, dentry);
-	return err;
+	return PTR_ERR_OR_ZERO(dentry);
 }
 
 static int create_path(const char *nodepath)
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7cf59713f0f7..8188fe7a5084 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -95,7 +95,6 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	/* search the current directory for the element name */
 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
-retry:
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
 		subdir = lookup_one_len(dirname, dir, strlen(dirname));
@@ -129,8 +128,10 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		if (ret < 0)
 			goto mkdir_error;
 		ret = cachefiles_inject_write_error();
-		if (ret == 0)
-			ret = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
+		if (ret == 0) {
+			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
+			ret = PTR_ERR_OR_ZERO(subdir);
+		}
 		if (ret < 0) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
 						   cachefiles_trace_mkdir_error);
@@ -138,10 +139,6 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		}
 		trace_cachefiles_mkdir(dir, subdir);
 
-		if (unlikely(d_unhashed(subdir))) {
-			cachefiles_put_directory(subdir);
-			goto retry;
-		}
 		ASSERT(d_backing_inode(subdir));
 
 		_debug("mkdir -> %pd{ino=%lu}",
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 7445c32c1e95..b01fd0bb4fe8 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -511,9 +511,11 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *lower_dir;
 
 	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_mkdir(&nop_mnt_idmap, lower_dir,
-			       lower_dentry, mode);
+	if (!rc) {
+		lower_dentry = vfs_mkdir(&nop_mnt_idmap, lower_dir,
+					 lower_dentry, mode);
+		rc = PTR_ERR_OR_ZERO(lower_dentry);
+	}
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
diff --git a/fs/init.c b/fs/init.c
index e9387b6c4f30..07ac858e70c4 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -230,9 +230,11 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 		return PTR_ERR(dentry);
 	mode = mode_strip_umask(d_inode(path.dentry), mode);
 	error = security_path_mkdir(&path, dentry, mode);
-	if (!error)
-		error = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
+	if (!error) {
+		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
 				  dentry, mode);
+		error = PTR_ERR_OR_ZERO(dentry);
+	}
 	done_path_create(&path, dentry);
 	return error;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 6094d93ed7d3..c38ed9aefe3c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4126,7 +4126,8 @@ EXPORT_SYMBOL(kern_path_create);
 
 void done_path_create(struct path *path, struct dentry *dentry)
 {
-	dput(dentry);
+	if (!IS_ERR(dentry))
+		dput(dentry);
 	inode_unlock(path->dentry->d_inode);
 	mnt_drop_write(path->mnt);
 	path_put(path);
@@ -4272,7 +4273,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 }
 
 /**
- * vfs_mkdir - create directory
+ * vfs_mkdir - create directory returning correct dentry
  * @idmap:	idmap of the mount the inode was found from
  * @dir:	inode of the parent directory
  * @dentry:	dentry of the child directory
@@ -4285,9 +4286,15 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
  * raw inode simply pass @nop_mnt_idmap.
+ *
+ * In the event that the filesystem does not use the *@dentry but
+ * unhashes it and spices a different one returning it, the original
+ * dentry is dput() and the alternate is returned.
+ *
+ * In case of an error the denrty is dput() and an ERR_PTR() is returned.
  */
-int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-	      struct dentry *dentry, umode_t mode)
+struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+			 struct dentry *dentry, umode_t mode)
 {
 	int error;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4295,28 +4302,33 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	error = may_create(idmap, dir, dentry);
 	if (error)
-		return error;
+		goto err;
 
+	error = -EPERM;
 	if (!dir->i_op->mkdir)
-		return -EPERM;
+		goto err;
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
 	error = security_inode_mkdir(dir, dentry, mode);
 	if (error)
-		return error;
+		goto err;
 
+	error = -EMLINK;
 	if (max_links && dir->i_nlink >= max_links)
-		return -EMLINK;
+		goto err;
 
 	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
 	error = PTR_ERR_OR_ZERO(de);
-	if (!error) {
-		fsnotify_mkdir(dir, de);
-		if (de != dentry)
-			/* Cannot return de yet */
-			dput(de);
-	}
-	return error;
+	if (error)
+		goto err;
+	fsnotify_mkdir(dir, de);
+	if (de != dentry)
+		dput(dentry);
+	return de;
+
+err:
+	dput(dentry);
+	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(vfs_mkdir);
 
@@ -4336,8 +4348,9 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	error = security_path_mkdir(&path, dentry,
 			mode_strip_umask(path.dentry->d_inode, mode));
 	if (!error) {
-		error = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
+		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
 				  dentry, mode);
+		error = PTR_ERR_OR_ZERO(dentry);
 	}
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 28f4d5311c40..6773bef039dd 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -233,9 +233,11 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 * as well be forgiving and just succeed silently.
 		 */
 		goto out_put;
-	status = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
+	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
+	status = PTR_ERR_OR_ZERO(dentry);
 out_put:
-	dput(dentry);
+	if (!status)
+		dput(dentry);
 out_unlock:
 	inode_unlock(d_inode(dir));
 	if (status == 0) {
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29cb7b812d71..939267614b27 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1488,26 +1488,12 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			nfsd_check_ignore_resizing(iap);
 		break;
 	case S_IFDIR:
-		host_err = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
-		if (!host_err && unlikely(d_unhashed(dchild))) {
-			struct dentry *d;
-			d = lookup_one_len(dchild->d_name.name,
-					   dchild->d_parent,
-					   dchild->d_name.len);
-			if (IS_ERR(d)) {
-				host_err = PTR_ERR(d);
-				break;
-			}
-			if (unlikely(d_is_negative(d))) {
-				dput(d);
-				err = nfserr_serverfault;
-				goto out;
-			}
+		dchild = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
+		host_err = PTR_ERR_OR_ZERO(dchild);
+		if (!host_err && unlikely(dchild != resfhp->fh_dentry)) {
 			dput(resfhp->fh_dentry);
-			resfhp->fh_dentry = dget(d);
+			resfhp->fh_dentry = dget(dchild);
 			err = fh_update(resfhp);
-			dput(dchild);
-			dchild = d;
 			if (err)
 				goto out;
 		}
@@ -1530,7 +1516,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 
 out:
-	dput(dchild);
+	if (!IS_ERR(dchild))
+		dput(dchild);
 	return err;
 
 out_nfserr:
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 74a0541a8619..f03ebf43883b 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -138,37 +138,6 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
 	goto out;
 }
 
-int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
-		   struct dentry **newdentry, umode_t mode)
-{
-	int err;
-	struct dentry *d, *dentry = *newdentry;
-
-	err = ovl_do_mkdir(ofs, dir, dentry, mode);
-	if (err)
-		return err;
-
-	if (likely(!d_unhashed(dentry)))
-		return 0;
-
-	/*
-	 * vfs_mkdir() may succeed and leave the dentry passed
-	 * to it unhashed and negative. If that happens, try to
-	 * lookup a new hashed and positive dentry.
-	 */
-	d = ovl_lookup_upper(ofs, dentry->d_name.name, dentry->d_parent,
-			     dentry->d_name.len);
-	if (IS_ERR(d)) {
-		pr_warn("failed lookup after mkdir (%pd2, err=%i).\n",
-			dentry, err);
-		return PTR_ERR(d);
-	}
-	dput(dentry);
-	*newdentry = d;
-
-	return 0;
-}
-
 struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 			       struct dentry *newdentry, struct ovl_cattr *attr)
 {
@@ -191,7 +160,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 
 		case S_IFDIR:
 			/* mkdir is special... */
-			err =  ovl_mkdir_real(ofs, dir, &newdentry, attr->mode);
+			newdentry =  ovl_do_mkdir(ofs, dir, newdentry, attr->mode);
+			err = PTR_ERR_OR_ZERO(newdentry);
 			break;
 
 		case S_IFCHR:
@@ -219,7 +189,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 	}
 out:
 	if (err) {
-		dput(newdentry);
+		if (!IS_ERR(newdentry))
+			dput(newdentry);
 		return ERR_PTR(err);
 	}
 	return newdentry;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 0021e2025020..6f2f8f4cfbbc 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -241,13 +241,14 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
 	return err;
 }
 
-static inline int ovl_do_mkdir(struct ovl_fs *ofs,
-			       struct inode *dir, struct dentry *dentry,
-			       umode_t mode)
+static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
+					  struct inode *dir,
+					  struct dentry *dentry,
+					  umode_t mode)
 {
-	int err = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
-	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, err);
-	return err;
+	dentry = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
+	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, PTR_ERR_OR_ZERO(dentry));
+	return dentry;
 }
 
 static inline int ovl_do_mknod(struct ovl_fs *ofs,
@@ -838,8 +839,6 @@ struct ovl_cattr {
 
 #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
 
-int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
-		   struct dentry **newdentry, umode_t mode);
 struct dentry *ovl_create_real(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 86ae6f6da36b..3802678b960c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -327,9 +327,10 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 			goto retry;
 		}
 
-		err = ovl_mkdir_real(ofs, dir, &work, attr.ia_mode);
+		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
+		err = PTR_ERR_OR_ZERO(work);
 		if (err)
-			goto out_dput;
+			goto out_err;
 
 		/* Weird filesystem returning with hashed negative (kernfs)? */
 		err = -EINVAL;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index fe29acef5872..4589a151b80d 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -206,7 +206,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 {
 	struct mnt_idmap *idmap;
 	struct path path;
-	struct dentry *dentry;
+	struct dentry *dentry, *d;
 	int err;
 
 	dentry = ksmbd_vfs_kern_path_create(work, name,
@@ -222,27 +222,12 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 
 	idmap = mnt_idmap(path.mnt);
 	mode |= S_IFDIR;
-	err = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
-	if (!err && d_unhashed(dentry)) {
-		struct dentry *d;
-
-		d = lookup_one(idmap, dentry->d_name.name, dentry->d_parent,
-			       dentry->d_name.len);
-		if (IS_ERR(d)) {
-			err = PTR_ERR(d);
-			goto out_err;
-		}
-		if (unlikely(d_is_negative(d))) {
-			dput(d);
-			err = -ENOENT;
-			goto out_err;
-		}
-
+	d = dentry;
+	entry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
+	err = PTR_ERR_OR_ZERO(dentry);
+	if (!err && dentry != d)
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
-		dput(d);
-	}
 
-out_err:
 	done_path_create(&path, dentry);
 	if (err)
 		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index c287c755f2c5..9b8d27624717 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -167,10 +167,11 @@ xrep_orphanage_create(
 	 * directory to control access to a file we put in here.
 	 */
 	if (d_really_is_negative(orphanage_dentry)) {
-		error = vfs_mkdir(&nop_mnt_idmap, root_inode, orphanage_dentry,
-				0750);
+		orphanage_dentry = vfs_mkdir(&nop_mnt_idmap, root_inode,
+					     orphanage_dentry, 0750);
+		error = PTR_ERR_OR_ZERO(orphanage_dentry);
 		if (error)
-			goto out_dput_orphanage;
+			goto out_unlock_root;
 	}
 
 	/* Not a directory? Bail out. */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 67eb77f75b40..29d0df85b7fb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1969,8 +1969,8 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
  */
 int vfs_create(struct mnt_idmap *, struct inode *,
 	       struct dentry *, umode_t, bool);
-int vfs_mkdir(struct mnt_idmap *, struct inode *,
-	      struct dentry *, umode_t);
+struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
+			 struct dentry *, umode_t);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
               umode_t, dev_t);
 int vfs_symlink(struct mnt_idmap *, struct inode *,
-- 
2.47.1


