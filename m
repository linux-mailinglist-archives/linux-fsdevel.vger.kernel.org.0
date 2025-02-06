Return-Path: <linux-fsdevel+bounces-41063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A2A2A889
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022903A7E41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987B22E409;
	Thu,  6 Feb 2025 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjZLoe5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D621E521;
	Thu,  6 Feb 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738845121; cv=none; b=KXg9P0UdLVs27dWk6yB5pJIcwGx3ZnHkPcue/iHQiZKK/w7OJKJVVZboDy/ug1ps09BsAglOD3fKlpVG9n+PWFDD8oEwfusUa1D4gbKmjazIzPXr778jRgDN3ghNr/CHJLLztFmhq0rBQIJpgP4WO0KNLBcphWFqlwhFSrV8mC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738845121; c=relaxed/simple;
	bh=7aBH+7VaFrGHEnPtVNMmyJj5xhRfEIc1SnD2aWeMMCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NW4eLXk/GAZvwgJLkxNDBCr3XrQ2+Pdc0f9gqw3/9vx1WCNOfz6+DEGZVJf7bekjCQY5T9GUmnQYmTjdmx8Oj2R8Mm8sZ8gU7oRzBcFO64LtESv8MAlrb1pOBDCt5KY+Cakj1awVE3JAskr8Gb3XJSjfIq6dg2RdWBBPvRladOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjZLoe5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BE8C4CEDD;
	Thu,  6 Feb 2025 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738845121;
	bh=7aBH+7VaFrGHEnPtVNMmyJj5xhRfEIc1SnD2aWeMMCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjZLoe5R29ixQ+Wb3PnJkHHXBc5p6pRfslExFcV8b3BKbvq26OA8y006Z7kfLoIo4
	 2ET/hr6nzawh/byfvHmBrR9AdByeKI5xw0SHc2Ud5XP95SEWjRs23crdQTarjN647i
	 zGXTSxGwUP9pk76aC8gKftfNbGPFQLQzncl3GV0Y02DaJUaI8ZIB1kadmvwbUG52zI
	 uG51RxNVB0+Gx8iu+rQQjIbgfQSI2OKtQxFSUEjXjvCtbrY5i/SRO8GtBP75jxEkO1
	 vzqzZl9osOLdBQt1/y8ZeBoG5G88qYwHfweQUow2WQp7UUGttBl05aI52N0xy9tb7d
	 CMSjP+zFi4zDA==
Date: Thu, 6 Feb 2025 13:31:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/19] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
Message-ID: <20250206-brust-lernbegierde-217cbba91255@brauner>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-5-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-5-neilb@suse.de>

On Thu, Feb 06, 2025 at 04:42:41PM +1100, NeilBrown wrote:
> No callers of kern_path_locked() or user_path_locked_at() want a
> negative dentry.  So change them to return -ENOENT instead.  This
> simplifies callers.
> 
> This results in a subtle change to bcachefs in that an ioctl will now
> return -ENOENT in preference to -EXDEV.  I believe this restores the
> behaviour to what it was prior to
>  Commit bbe6a7c899e7 ("bch2_ioctl_subvolume_destroy(): fix locking")
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---

It would be nice if you could send this as a separate cleanup patch.
It seems unrelated to the series.

>  drivers/base/devtmpfs.c | 65 +++++++++++++++++++----------------------
>  fs/bcachefs/fs-ioctl.c  |  4 ---
>  fs/namei.c              |  4 +++
>  kernel/audit_watch.c    | 12 ++++----
>  4 files changed, 40 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index b848764ef018..c9e34842139f 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -245,15 +245,12 @@ static int dev_rmdir(const char *name)
>  	dentry = kern_path_locked(name, &parent);
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
> -	if (d_really_is_positive(dentry)) {
> -		if (d_inode(dentry)->i_private == &thread)
> -			err = vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
> -					dentry);
> -		else
> -			err = -EPERM;
> -	} else {
> -		err = -ENOENT;
> -	}
> +	if (d_inode(dentry)->i_private == &thread)
> +		err = vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
> +				dentry);
> +	else
> +		err = -EPERM;
> +
>  	dput(dentry);
>  	inode_unlock(d_inode(parent.dentry));
>  	path_put(&parent);
> @@ -310,6 +307,8 @@ static int handle_remove(const char *nodename, struct device *dev)
>  {
>  	struct path parent;
>  	struct dentry *dentry;
> +	struct kstat stat;
> +	struct path p;
>  	int deleted = 0;
>  	int err;
>  
> @@ -317,32 +316,28 @@ static int handle_remove(const char *nodename, struct device *dev)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	if (d_really_is_positive(dentry)) {
> -		struct kstat stat;
> -		struct path p = {.mnt = parent.mnt, .dentry = dentry};
> -		err = vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
> -				  AT_STATX_SYNC_AS_STAT);
> -		if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
> -			struct iattr newattrs;
> -			/*
> -			 * before unlinking this node, reset permissions
> -			 * of possible references like hardlinks
> -			 */
> -			newattrs.ia_uid = GLOBAL_ROOT_UID;
> -			newattrs.ia_gid = GLOBAL_ROOT_GID;
> -			newattrs.ia_mode = stat.mode & ~0777;
> -			newattrs.ia_valid =
> -				ATTR_UID|ATTR_GID|ATTR_MODE;
> -			inode_lock(d_inode(dentry));
> -			notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
> -			inode_unlock(d_inode(dentry));
> -			err = vfs_unlink(&nop_mnt_idmap, d_inode(parent.dentry),
> -					 dentry, NULL);
> -			if (!err || err == -ENOENT)
> -				deleted = 1;
> -		}
> -	} else {
> -		err = -ENOENT;
> +	p.mnt = parent.mnt;
> +	p.dentry = dentry;
> +	err = vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
> +			  AT_STATX_SYNC_AS_STAT);
> +	if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
> +		struct iattr newattrs;
> +		/*
> +		 * before unlinking this node, reset permissions
> +		 * of possible references like hardlinks
> +		 */
> +		newattrs.ia_uid = GLOBAL_ROOT_UID;
> +		newattrs.ia_gid = GLOBAL_ROOT_GID;
> +		newattrs.ia_mode = stat.mode & ~0777;
> +		newattrs.ia_valid =
> +			ATTR_UID|ATTR_GID|ATTR_MODE;
> +		inode_lock(d_inode(dentry));
> +		notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
> +		inode_unlock(d_inode(dentry));
> +		err = vfs_unlink(&nop_mnt_idmap, d_inode(parent.dentry),
> +				 dentry, NULL);
> +		if (!err || err == -ENOENT)
> +			deleted = 1;
>  	}
>  	dput(dentry);
>  	inode_unlock(d_inode(parent.dentry));
> diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
> index 15725b4ce393..595b57fabc9a 100644
> --- a/fs/bcachefs/fs-ioctl.c
> +++ b/fs/bcachefs/fs-ioctl.c
> @@ -511,10 +511,6 @@ static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
>  		ret = -EXDEV;
>  		goto err;
>  	}
> -	if (!d_is_positive(victim)) {
> -		ret = -ENOENT;
> -		goto err;
> -	}
>  	ret = __bch2_unlink(dir, victim, true);
>  	if (!ret) {
>  		fsnotify_rmdir(dir, victim);
> diff --git a/fs/namei.c b/fs/namei.c
> index d684102d873d..1901120bcbb8 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2745,6 +2745,10 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
>  	}
>  	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
>  	d = lookup_one_qstr(&last, path->dentry, 0);
> +	if (!IS_ERR(d) && d_is_negative(d)) {
> +		dput(d);
> +		d = ERR_PTR(-ENOENT);
> +	}
>  	if (IS_ERR(d)) {
>  		inode_unlock(path->dentry->d_inode);
>  		path_put(path);
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 7f358740e958..e3130675ee6b 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -350,11 +350,10 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
>  	struct dentry *d = kern_path_locked(watch->path, parent);
>  	if (IS_ERR(d))
>  		return PTR_ERR(d);
> -	if (d_is_positive(d)) {
> -		/* update watch filter fields */
> -		watch->dev = d->d_sb->s_dev;
> -		watch->ino = d_backing_inode(d)->i_ino;
> -	}
> +	/* update watch filter fields */
> +	watch->dev = d->d_sb->s_dev;
> +	watch->ino = d_backing_inode(d)->i_ino;
> +
>  	inode_unlock(d_backing_inode(parent->dentry));
>  	dput(d);
>  	return 0;
> @@ -419,7 +418,7 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
>  	/* caller expects mutex locked */
>  	mutex_lock(&audit_filter_mutex);
>  
> -	if (ret) {
> +	if (ret && ret != -ENOENT) {
>  		audit_put_watch(watch);
>  		return ret;
>  	}
> @@ -438,6 +437,7 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
>  
>  	h = audit_hash_ino((u32)watch->ino);
>  	*list = &audit_inode_hash[h];
> +	ret = 0;
>  error:
>  	path_put(&parent_path);
>  	audit_put_watch(watch);
> -- 
> 2.47.1
> 

