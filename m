Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961F63D8344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhG0Wna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:43:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54034 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhG0Wn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:43:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D640D1FF31;
        Tue, 27 Jul 2021 22:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627425807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAzEDNq9szLfRXZIXQmeCEtmKHhwvl25ZMKYMdggNqU=;
        b=XYIcHHLt4Xij6KyF3wshuLCstJytZMDSrXw/669iyHCbSWdGoDX6VLrOjeZs81a89po2YW
        LCqyltfpXmZmUo46qdU1+7SA5Oe7rkZGu5AoNVfjpMzH2vcwd9M2+2eYdL75CEGgFev6Jo
        HTO5vY5sTG09mnFrLQq0vQaB8AYPUog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627425807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAzEDNq9szLfRXZIXQmeCEtmKHhwvl25ZMKYMdggNqU=;
        b=Drrt4JjHQmwX+10yFaeymiI4U3YVGPaLlkLifylJYX3ThkOZ6O0DuB2z5Bpx1NARsCG5/a
        GpgjO7deuQdCI7Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B361B13A5D;
        Tue, 27 Jul 2021 22:43:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 12VHHAyMAGHOVQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 22:43:24 +0000
Subject: [PATCH 07/11] exportfs: Allow filehandle lookup to cross internal
 mount points.
From:   NeilBrown <neilb@suse.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Wed, 28 Jul 2021 08:37:45 +1000
Message-ID: <162742546554.32498.9309110546560807513.stgit@noble.brown>
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a filesystem has internal mounts, it controls the filehandles
across all those mounts (subvols) in the filesystem.  So it is useful to
be able to look up a filehandle again one mount, and get a result which
is in a different mount (part of the same overall file system).

This patch makes that possible by changing export_decode_fh() and
export_decode_fh_raw() to take a vfsmount pointer by reference, and
possibly change the vfsmount pointed to before returning.

The core of the change is in reconnect_path() which now not only checks
that the dentry is fully connected, but also that the vfsmnt reported
has the same 'dev' (reported by vfs_getattr) as the dentry.
If it doesn't, we walk up the dparent() chain to find the highest place
where the dev changes without there being a mount point, and trigger an
automount there.

As no filesystems yet provide local-mounts, this does not yet change any
behaviour.

In exportfs_decode_fh_raw() we previously tested for DCACHE_DISCONNECT
before calling reconnect_path().  That test is dropped.  It was only a
minor optimisation and is now inconvenient.

The change in overlayfs needs more careful thought than I have yet given
it.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/exportfs/expfs.c      |  100 +++++++++++++++++++++++++++++++++++++++-------
 fs/fhandle.c             |    2 -
 fs/nfsd/nfsfh.c          |    9 +++-
 fs/overlayfs/namei.c     |    5 ++
 fs/xfs/xfs_ioctl.c       |   12 ++++--
 include/linux/exportfs.h |    4 +-
 6 files changed, 106 insertions(+), 26 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 0106eba46d5a..2d7c42137b49 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -207,11 +207,18 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
  * that case reconnect_path may still succeed with target_dir fully
  * connected, but further operations using the filehandle will fail when
  * necessary (due to S_DEAD being set on the directory).
+ *
+ * If the filesystem supports multiple subvols, then *mntp may be updated
+ * to a subordinate mount point on the same filesystem.
  */
 static int
-reconnect_path(struct vfsmount *mnt, struct dentry *target_dir, char *nbuf)
+reconnect_path(struct vfsmount **mntp, struct dentry *target_dir, char *nbuf)
 {
+	struct vfsmount *mnt = *mntp;
+	struct path path;
 	struct dentry *dentry, *parent;
+	struct kstat stat;
+	dev_t target_dev;
 
 	dentry = dget(target_dir);
 
@@ -232,6 +239,68 @@ reconnect_path(struct vfsmount *mnt, struct dentry *target_dir, char *nbuf)
 	}
 	dput(dentry);
 	clear_disconnected(target_dir);
+
+	/* Need to find appropriate vfsmount, which might not exist yet.
+	 * We may need to trigger automount points.
+	 */
+	path.mnt = mnt;
+	path.dentry = target_dir;
+	vfs_getattr_nosec(&path, &stat, 0, AT_STATX_DONT_SYNC);
+	target_dev = stat.dev;
+
+	path.dentry = mnt->mnt_root;
+	vfs_getattr_nosec(&path, &stat, 0, AT_STATX_DONT_SYNC);
+
+	while (stat.dev != target_dev) {
+		/* walk up the dcache tree from target_dir, recording the
+		 * location of the most recent change in dev number,
+		 * until we find a mountpoint.
+		 * If there was no change in show_dev result before the
+		 * mountpount, the vfsmount at the mountpoint is what we want.
+		 * If there was, we need to trigger an automount where the
+		 * show_dev() result changed.
+		 */
+		struct dentry *last_change = NULL;
+		dev_t last_dev = target_dev;
+
+		dentry = dget(target_dir);
+		while ((parent = dget_parent(dentry)) != dentry) {
+			path.dentry = parent;
+			vfs_getattr_nosec(&path, &stat, 0, AT_STATX_DONT_SYNC);
+			if (stat.dev != last_dev) {
+				path.dentry = dentry;
+				mnt = lookup_mnt(&path);
+				if (mnt) {
+					mntput(path.mnt);
+					path.mnt = mnt;
+					break;
+				}
+				dput(last_change);
+				last_change = dget(dentry);
+				last_dev = stat.dev;
+			}
+			dput(dentry);
+			dentry = parent;
+		}
+		dput(dentry); dput(parent);
+
+		if (!last_change)
+			break;
+
+		mnt = path.mnt;
+		path.dentry = last_change;
+		follow_down(&path, LOOKUP_AUTOMOUNT);
+		dput(path.dentry);
+		if (path.mnt == mnt)
+			/* There should have been a mount-trap there,
+			 * but there wasn't.  Just give up.
+			 */
+			break;
+
+		path.dentry = mnt->mnt_root;
+		vfs_getattr_nosec(&path, &stat, 0, AT_STATX_DONT_SYNC);
+	}
+	*mntp = path.mnt;
 	return 0;
 }
 
@@ -418,12 +487,13 @@ int exportfs_encode_fh(struct dentry *dentry, struct fid *fid, int *max_len,
 EXPORT_SYMBOL_GPL(exportfs_encode_fh);
 
 struct dentry *
-exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
+exportfs_decode_fh_raw(struct vfsmount **mntp, struct fid *fid, int fh_len,
 		       int fileid_type,
 		       int (*acceptable)(void *, struct dentry *),
 		       void *context)
 {
-	const struct export_operations *nop = mnt->mnt_sb->s_export_op;
+	struct super_block *sb = (*mntp)->mnt_sb;
+	const struct export_operations *nop = sb->s_export_op;
 	struct dentry *result, *alias;
 	char nbuf[NAME_MAX+1];
 	int err;
@@ -433,7 +503,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 	 */
 	if (!nop || !nop->fh_to_dentry)
 		return ERR_PTR(-ESTALE);
-	result = nop->fh_to_dentry(mnt->mnt_sb, fid, fh_len, fileid_type);
+	result = nop->fh_to_dentry(sb, fid, fh_len, fileid_type);
 	if (IS_ERR_OR_NULL(result))
 		return result;
 
@@ -452,14 +522,12 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 		 *
 		 * On the positive side there is only one dentry for each
 		 * directory inode.  On the negative side this implies that we
-		 * to ensure our dentry is connected all the way up to the
+		 * need to ensure our dentry is connected all the way up to the
 		 * filesystem root.
 		 */
-		if (result->d_flags & DCACHE_DISCONNECTED) {
-			err = reconnect_path(mnt, result, nbuf);
-			if (err)
-				goto err_result;
-		}
+		err = reconnect_path(mntp, result, nbuf);
+		if (err)
+			goto err_result;
 
 		if (!acceptable(context, result)) {
 			err = -EACCES;
@@ -494,7 +562,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 		if (!nop->fh_to_parent)
 			goto err_result;
 
-		target_dir = nop->fh_to_parent(mnt->mnt_sb, fid,
+		target_dir = nop->fh_to_parent(sb, fid,
 				fh_len, fileid_type);
 		if (!target_dir)
 			goto err_result;
@@ -507,7 +575,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 		 * connected to the filesystem root.  The VFS really doesn't
 		 * like disconnected directories..
 		 */
-		err = reconnect_path(mnt, target_dir, nbuf);
+		err = reconnect_path(mntp, target_dir, nbuf);
 		if (err) {
 			dput(target_dir);
 			goto err_result;
@@ -518,7 +586,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 		 * dentry for the inode we're after, make sure that our
 		 * inode is actually connected to the parent.
 		 */
-		err = exportfs_get_name(mnt, target_dir, nbuf, result);
+		err = exportfs_get_name(*mntp, target_dir, nbuf, result);
 		if (err) {
 			dput(target_dir);
 			goto err_result;
@@ -556,7 +624,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 			goto err_result;
 		}
 
-		return alias;
+		return result;
 	}
 
  err_result:
@@ -565,14 +633,14 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 }
 EXPORT_SYMBOL_GPL(exportfs_decode_fh_raw);
 
-struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
+struct dentry *exportfs_decode_fh(struct vfsmount **mntp, struct fid *fid,
 				  int fh_len, int fileid_type,
 				  int (*acceptable)(void *, struct dentry *),
 				  void *context)
 {
 	struct dentry *ret;
 
-	ret = exportfs_decode_fh_raw(mnt, fid, fh_len, fileid_type,
+	ret = exportfs_decode_fh_raw(mntp, fid, fh_len, fileid_type,
 				     acceptable, context);
 	if (IS_ERR_OR_NULL(ret)) {
 		if (ret == ERR_PTR(-ENOMEM))
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 6630c69c23a2..b47c7696469f 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -149,7 +149,7 @@ static int do_handle_to_path(int mountdirfd, struct file_handle *handle,
 	}
 	/* change the handle size to multiple of sizeof(u32) */
 	handle_dwords = handle->handle_bytes >> 2;
-	path->dentry = exportfs_decode_fh(path->mnt,
+	path->dentry = exportfs_decode_fh(&path->mnt,
 					  (struct fid *)handle->f_handle,
 					  handle_dwords, handle->handle_type,
 					  vfs_dentry_acceptable, NULL);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 0bf7ac13ae50..4023046f63e2 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -157,6 +157,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	struct fid *fid = NULL, sfid;
 	struct svc_export *exp;
 	struct dentry *dentry;
+	struct vfsmount *mnt = NULL;
 	int fileid_type;
 	int data_left = fh->fh_size/4;
 	__be32 error;
@@ -253,6 +254,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	if (rqstp->rq_vers > 2)
 		error = nfserr_badhandle;
 
+	mnt = mntget(exp->ex_path.mnt);
+
 	if (fh->fh_version != 1) {
 		sfid.i32.ino = fh->ofh_ino;
 		sfid.i32.gen = fh->ofh_generation;
@@ -269,7 +272,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	if (fileid_type == FILEID_ROOT)
 		dentry = dget(exp->ex_path.dentry);
 	else {
-		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
+		dentry = exportfs_decode_fh_raw(&mnt, fid,
 						data_left, fileid_type,
 						nfsd_acceptable, exp);
 		if (IS_ERR_OR_NULL(dentry)) {
@@ -299,7 +302,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	}
 
 	fhp->fh_dentry = dentry;
-	fhp->fh_mnt = mntget(exp->ex_path.mnt);
+	fhp->fh_mnt = mnt;
 	fhp->fh_export = exp;
 
 	switch (rqstp->rq_vers) {
@@ -317,6 +320,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 
 	return 0;
 out:
+	mntput(mnt);
 	exp_put(exp);
 	return error;
 }
@@ -428,7 +432,6 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	return error;
 }
 
-
 /*
  * Compose a file handle for an NFS reply.
  *
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 210cd6f66e28..0bca19f6df54 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -155,6 +155,7 @@ struct dentry *ovl_decode_real_fh(struct ovl_fs *ofs, struct ovl_fh *fh,
 {
 	struct dentry *real;
 	int bytes;
+	struct vfsmount *mnt2;
 
 	if (!capable(CAP_DAC_READ_SEARCH))
 		return NULL;
@@ -169,9 +170,11 @@ struct dentry *ovl_decode_real_fh(struct ovl_fs *ofs, struct ovl_fh *fh,
 		return NULL;
 
 	bytes = (fh->fb.len - offsetof(struct ovl_fb, fid));
-	real = exportfs_decode_fh(mnt, (struct fid *)fh->fb.fid,
+	mnt2 = mntget(mnt);
+	real = exportfs_decode_fh(&mnt2, (struct fid *)fh->fb.fid,
 				  bytes >> 2, (int)fh->fb.type,
 				  connected ? ovl_acceptable : NULL, mnt);
+	mntput(mnt2);
 	if (IS_ERR(real)) {
 		/*
 		 * Treat stale file handle to lower file as "origin unknown".
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 16039ea10ac9..76eb7d540811 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -149,6 +149,8 @@ xfs_handle_to_dentry(
 {
 	xfs_handle_t		handle;
 	struct xfs_fid64	fid;
+	struct dentry		*ret;
+	struct vfsmount		*mnt;
 
 	/*
 	 * Only allow handle opens under a directory.
@@ -168,9 +170,13 @@ xfs_handle_to_dentry(
 	fid.ino = handle.ha_fid.fid_ino;
 	fid.gen = handle.ha_fid.fid_gen;
 
-	return exportfs_decode_fh(parfilp->f_path.mnt, (struct fid *)&fid, 3,
-			FILEID_INO32_GEN | XFS_FILEID_TYPE_64FLAG,
-			xfs_handle_acceptable, NULL);
+	mnt = mntget(parfilp->f_path.mnt);
+	ret = exportfs_decode_fh(&mnt, (struct fid *)&fid, 3,
+				 FILEID_INO32_GEN | XFS_FILEID_TYPE_64FLAG,
+				 xfs_handle_acceptable, NULL);
+	WARN_ON(mnt != parfilp->f_path.mnt);
+	mntput(mnt);
+	return ret;
 }
 
 STATIC struct dentry *
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index fe848901fcc3..9a8c5434a5cf 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -228,12 +228,12 @@ extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 				    int *max_len, struct inode *parent);
 extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
 	int *max_len, int connectable);
-extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
+extern struct dentry *exportfs_decode_fh_raw(struct vfsmount **mntp,
 					     struct fid *fid, int fh_len,
 					     int fileid_type,
 					     int (*acceptable)(void *, struct dentry *),
 					     void *context);
-extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
+extern struct dentry *exportfs_decode_fh(struct vfsmount **mnt, struct fid *fid,
 	int fh_len, int fileid_type, int (*acceptable)(void *, struct dentry *),
 	void *context);
 


