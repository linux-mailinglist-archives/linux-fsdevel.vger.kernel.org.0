Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CA33D95EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 21:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhG1TRO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 15:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1TRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 15:17:13 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF06C061757;
        Wed, 28 Jul 2021 12:17:11 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 917827C77; Wed, 28 Jul 2021 15:17:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 917827C77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1627499831;
        bh=QGi8Y+wurSkVuDPmP5sipc7Hrk2IhPq1SmNuzD0+Gug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IAQoriF0P6Iydqzyk12HgdxTxahcApXyETB1JRtcMNPnRj5trB/sHlPOizW5PvbHp
         9U/fRNq4k+wL5N9A9EWNlOJaiV2ZJoEJ24ILc8XbxrMKseglRXJXV4656YkYPlInDH
         RaqORoieJGDV5OZUySFUTrP+A/gBH57C4N03o3qI=
Date:   Wed, 28 Jul 2021 15:17:11 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/11] exportfs: Allow filehandle lookup to cross
 internal mount points.
Message-ID: <20210728191711.GC3152@fieldses.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546554.32498.9309110546560807513.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162742546554.32498.9309110546560807513.stgit@noble.brown>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> When a filesystem has internal mounts, it controls the filehandles
> across all those mounts (subvols) in the filesystem.  So it is useful to
> be able to look up a filehandle again one mount, and get a result which
> is in a different mount (part of the same overall file system).
> 
> This patch makes that possible by changing export_decode_fh() and
> export_decode_fh_raw() to take a vfsmount pointer by reference, and
> possibly change the vfsmount pointed to before returning.
> 
> The core of the change is in reconnect_path() which now not only checks
> that the dentry is fully connected, but also that the vfsmnt reported
> has the same 'dev' (reported by vfs_getattr) as the dentry.
> If it doesn't, we walk up the dparent() chain to find the highest place
> where the dev changes without there being a mount point, and trigger an
> automount there.
> 
> As no filesystems yet provide local-mounts, this does not yet change any
> behaviour.
> 
> In exportfs_decode_fh_raw() we previously tested for DCACHE_DISCONNECT
> before calling reconnect_path().  That test is dropped.  It was only a
> minor optimisation and is now inconvenient.
> 
> The change in overlayfs needs more careful thought than I have yet given
> it.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/exportfs/expfs.c      |  100 +++++++++++++++++++++++++++++++++++++++-------
>  fs/fhandle.c             |    2 -
>  fs/nfsd/nfsfh.c          |    9 +++-
>  fs/overlayfs/namei.c     |    5 ++
>  fs/xfs/xfs_ioctl.c       |   12 ++++--
>  include/linux/exportfs.h |    4 +-
>  6 files changed, 106 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 0106eba46d5a..2d7c42137b49 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -207,11 +207,18 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
>   * that case reconnect_path may still succeed with target_dir fully
>   * connected, but further operations using the filehandle will fail when
>   * necessary (due to S_DEAD being set on the directory).
> + *
> + * If the filesystem supports multiple subvols, then *mntp may be updated
> + * to a subordinate mount point on the same filesystem.
>   */
>  static int
> -reconnect_path(struct vfsmount *mnt, struct dentry *target_dir, char *nbuf)
> +reconnect_path(struct vfsmount **mntp, struct dentry *target_dir, char *nbuf)
>  {
> +	struct vfsmount *mnt = *mntp;
> +	struct path path;
>  	struct dentry *dentry, *parent;
> +	struct kstat stat;
> +	dev_t target_dev;
>  
>  	dentry = dget(target_dir);
>  
> @@ -232,6 +239,68 @@ reconnect_path(struct vfsmount *mnt, struct dentry *target_dir, char *nbuf)
>  	}
>  	dput(dentry);
>  	clear_disconnected(target_dir);

Minor nit--I'd prefer the following in a separate function.

--b.

> +
> +	/* Need to find appropriate vfsmount, which might not exist yet.
> +	 * We may need to trigger automount points.
> +	 */
> +	path.mnt = mnt;
> +	path.dentry = target_dir;
> +	vfs_getattr_nosec(&path, &stat, 0, AT_STATX_DONT_SYNC);
> +	target_dev = stat.dev;
> +
> +	path.dentry = mnt->mnt_root;
> +	vfs_getattr_nosec(&path, &stat, 0, AT_STATX_DONT_SYNC);
> +
> +	while (stat.dev != target_dev) {
> +		/* walk up the dcache tree from target_dir, recording the
> +		 * location of the most recent change in dev number,
> +		 * until we find a mountpoint.
> +		 * If there was no change in show_dev result before the
> +		 * mountpount, the vfsmount at the mountpoint is what we want.
> +		 * If there was, we need to trigger an automount where the
> +		 * show_dev() result changed.
> +		 */
> +		struct dentry *last_change = NULL;
> +		dev_t last_dev = target_dev;
> +
> +		dentry = dget(target_dir);
> +		while ((parent = dget_parent(dentry)) != dentry) {
> +			path.dentry = parent;
> +			vfs_getattr_nosec(&path, &stat, 0, AT_STATX_DONT_SYNC);
> +			if (stat.dev != last_dev) {
> +				path.dentry = dentry;
> +				mnt = lookup_mnt(&path);
> +				if (mnt) {
> +					mntput(path.mnt);
> +					path.mnt = mnt;
> +					break;
> +				}
> +				dput(last_change);
> +				last_change = dget(dentry);
> +				last_dev = stat.dev;
> +			}
> +			dput(dentry);
> +			dentry = parent;
> +		}
> +		dput(dentry); dput(parent);
> +
> +		if (!last_change)
> +			break;
> +
> +		mnt = path.mnt;
> +		path.dentry = last_change;
> +		follow_down(&path, LOOKUP_AUTOMOUNT);
> +		dput(path.dentry);
> +		if (path.mnt == mnt)
> +			/* There should have been a mount-trap there,
> +			 * but there wasn't.  Just give up.
> +			 */
> +			break;
> +
> +		path.dentry = mnt->mnt_root;
> +		vfs_getattr_nosec(&path, &stat, 0, AT_STATX_DONT_SYNC);
> +	}
> +	*mntp = path.mnt;
>  	return 0;
>  }
>  
> @@ -418,12 +487,13 @@ int exportfs_encode_fh(struct dentry *dentry, struct fid *fid, int *max_len,
>  EXPORT_SYMBOL_GPL(exportfs_encode_fh);
>  
>  struct dentry *
> -exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
> +exportfs_decode_fh_raw(struct vfsmount **mntp, struct fid *fid, int fh_len,
>  		       int fileid_type,
>  		       int (*acceptable)(void *, struct dentry *),
>  		       void *context)
>  {
> -	const struct export_operations *nop = mnt->mnt_sb->s_export_op;
> +	struct super_block *sb = (*mntp)->mnt_sb;
> +	const struct export_operations *nop = sb->s_export_op;
>  	struct dentry *result, *alias;
>  	char nbuf[NAME_MAX+1];
>  	int err;
> @@ -433,7 +503,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
>  	 */
>  	if (!nop || !nop->fh_to_dentry)
>  		return ERR_PTR(-ESTALE);
> -	result = nop->fh_to_dentry(mnt->mnt_sb, fid, fh_len, fileid_type);
> +	result = nop->fh_to_dentry(sb, fid, fh_len, fileid_type);
>  	if (IS_ERR_OR_NULL(result))
>  		return result;
>  
> @@ -452,14 +522,12 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
>  		 *
>  		 * On the positive side there is only one dentry for each
>  		 * directory inode.  On the negative side this implies that we
> -		 * to ensure our dentry is connected all the way up to the
> +		 * need to ensure our dentry is connected all the way up to the
>  		 * filesystem root.
>  		 */
> -		if (result->d_flags & DCACHE_DISCONNECTED) {
> -			err = reconnect_path(mnt, result, nbuf);
> -			if (err)
> -				goto err_result;
> -		}
> +		err = reconnect_path(mntp, result, nbuf);
> +		if (err)
> +			goto err_result;
>  
>  		if (!acceptable(context, result)) {
>  			err = -EACCES;
> @@ -494,7 +562,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
>  		if (!nop->fh_to_parent)
>  			goto err_result;
>  
> -		target_dir = nop->fh_to_parent(mnt->mnt_sb, fid,
> +		target_dir = nop->fh_to_parent(sb, fid,
>  				fh_len, fileid_type);
>  		if (!target_dir)
>  			goto err_result;
> @@ -507,7 +575,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
>  		 * connected to the filesystem root.  The VFS really doesn't
>  		 * like disconnected directories..
>  		 */
> -		err = reconnect_path(mnt, target_dir, nbuf);
> +		err = reconnect_path(mntp, target_dir, nbuf);
>  		if (err) {
>  			dput(target_dir);
>  			goto err_result;
> @@ -518,7 +586,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
>  		 * dentry for the inode we're after, make sure that our
>  		 * inode is actually connected to the parent.
>  		 */
> -		err = exportfs_get_name(mnt, target_dir, nbuf, result);
> +		err = exportfs_get_name(*mntp, target_dir, nbuf, result);
>  		if (err) {
>  			dput(target_dir);
>  			goto err_result;
> @@ -556,7 +624,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
>  			goto err_result;
>  		}
>  
> -		return alias;
> +		return result;
>  	}
>  
>   err_result:
> @@ -565,14 +633,14 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
>  }
>  EXPORT_SYMBOL_GPL(exportfs_decode_fh_raw);
>  
> -struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
> +struct dentry *exportfs_decode_fh(struct vfsmount **mntp, struct fid *fid,
>  				  int fh_len, int fileid_type,
>  				  int (*acceptable)(void *, struct dentry *),
>  				  void *context)
>  {
>  	struct dentry *ret;
>  
> -	ret = exportfs_decode_fh_raw(mnt, fid, fh_len, fileid_type,
> +	ret = exportfs_decode_fh_raw(mntp, fid, fh_len, fileid_type,
>  				     acceptable, context);
>  	if (IS_ERR_OR_NULL(ret)) {
>  		if (ret == ERR_PTR(-ENOMEM))
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 6630c69c23a2..b47c7696469f 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -149,7 +149,7 @@ static int do_handle_to_path(int mountdirfd, struct file_handle *handle,
>  	}
>  	/* change the handle size to multiple of sizeof(u32) */
>  	handle_dwords = handle->handle_bytes >> 2;
> -	path->dentry = exportfs_decode_fh(path->mnt,
> +	path->dentry = exportfs_decode_fh(&path->mnt,
>  					  (struct fid *)handle->f_handle,
>  					  handle_dwords, handle->handle_type,
>  					  vfs_dentry_acceptable, NULL);
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 0bf7ac13ae50..4023046f63e2 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -157,6 +157,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  	struct fid *fid = NULL, sfid;
>  	struct svc_export *exp;
>  	struct dentry *dentry;
> +	struct vfsmount *mnt = NULL;
>  	int fileid_type;
>  	int data_left = fh->fh_size/4;
>  	__be32 error;
> @@ -253,6 +254,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  	if (rqstp->rq_vers > 2)
>  		error = nfserr_badhandle;
>  
> +	mnt = mntget(exp->ex_path.mnt);
> +
>  	if (fh->fh_version != 1) {
>  		sfid.i32.ino = fh->ofh_ino;
>  		sfid.i32.gen = fh->ofh_generation;
> @@ -269,7 +272,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  	if (fileid_type == FILEID_ROOT)
>  		dentry = dget(exp->ex_path.dentry);
>  	else {
> -		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
> +		dentry = exportfs_decode_fh_raw(&mnt, fid,
>  						data_left, fileid_type,
>  						nfsd_acceptable, exp);
>  		if (IS_ERR_OR_NULL(dentry)) {
> @@ -299,7 +302,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  	}
>  
>  	fhp->fh_dentry = dentry;
> -	fhp->fh_mnt = mntget(exp->ex_path.mnt);
> +	fhp->fh_mnt = mnt;
>  	fhp->fh_export = exp;
>  
>  	switch (rqstp->rq_vers) {
> @@ -317,6 +320,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  
>  	return 0;
>  out:
> +	mntput(mnt);
>  	exp_put(exp);
>  	return error;
>  }
> @@ -428,7 +432,6 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
>  	return error;
>  }
>  
> -
>  /*
>   * Compose a file handle for an NFS reply.
>   *
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 210cd6f66e28..0bca19f6df54 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -155,6 +155,7 @@ struct dentry *ovl_decode_real_fh(struct ovl_fs *ofs, struct ovl_fh *fh,
>  {
>  	struct dentry *real;
>  	int bytes;
> +	struct vfsmount *mnt2;
>  
>  	if (!capable(CAP_DAC_READ_SEARCH))
>  		return NULL;
> @@ -169,9 +170,11 @@ struct dentry *ovl_decode_real_fh(struct ovl_fs *ofs, struct ovl_fh *fh,
>  		return NULL;
>  
>  	bytes = (fh->fb.len - offsetof(struct ovl_fb, fid));
> -	real = exportfs_decode_fh(mnt, (struct fid *)fh->fb.fid,
> +	mnt2 = mntget(mnt);
> +	real = exportfs_decode_fh(&mnt2, (struct fid *)fh->fb.fid,
>  				  bytes >> 2, (int)fh->fb.type,
>  				  connected ? ovl_acceptable : NULL, mnt);
> +	mntput(mnt2);
>  	if (IS_ERR(real)) {
>  		/*
>  		 * Treat stale file handle to lower file as "origin unknown".
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 16039ea10ac9..76eb7d540811 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -149,6 +149,8 @@ xfs_handle_to_dentry(
>  {
>  	xfs_handle_t		handle;
>  	struct xfs_fid64	fid;
> +	struct dentry		*ret;
> +	struct vfsmount		*mnt;
>  
>  	/*
>  	 * Only allow handle opens under a directory.
> @@ -168,9 +170,13 @@ xfs_handle_to_dentry(
>  	fid.ino = handle.ha_fid.fid_ino;
>  	fid.gen = handle.ha_fid.fid_gen;
>  
> -	return exportfs_decode_fh(parfilp->f_path.mnt, (struct fid *)&fid, 3,
> -			FILEID_INO32_GEN | XFS_FILEID_TYPE_64FLAG,
> -			xfs_handle_acceptable, NULL);
> +	mnt = mntget(parfilp->f_path.mnt);
> +	ret = exportfs_decode_fh(&mnt, (struct fid *)&fid, 3,
> +				 FILEID_INO32_GEN | XFS_FILEID_TYPE_64FLAG,
> +				 xfs_handle_acceptable, NULL);
> +	WARN_ON(mnt != parfilp->f_path.mnt);
> +	mntput(mnt);
> +	return ret;
>  }
>  
>  STATIC struct dentry *
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index fe848901fcc3..9a8c5434a5cf 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -228,12 +228,12 @@ extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>  				    int *max_len, struct inode *parent);
>  extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
>  	int *max_len, int connectable);
> -extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
> +extern struct dentry *exportfs_decode_fh_raw(struct vfsmount **mntp,
>  					     struct fid *fid, int fh_len,
>  					     int fileid_type,
>  					     int (*acceptable)(void *, struct dentry *),
>  					     void *context);
> -extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
> +extern struct dentry *exportfs_decode_fh(struct vfsmount **mnt, struct fid *fid,
>  	int fh_len, int fileid_type, int (*acceptable)(void *, struct dentry *),
>  	void *context);
>  
> 
