Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F04498163
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 14:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiAXNub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 08:50:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55428 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiAXNua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:50:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9300221993;
        Mon, 24 Jan 2022 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643032229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ew9r9vB/3DGXISd3go8UWQTuDLp3dz+S9C44MFVpDN0=;
        b=V+aVPrFoGT4COR1i4E/2iKH9gJ9vCuv/JgYcsVA0WNqaTRPOIo22IDGQc9bJ5jXC9oQS2E
        Hojvj9gbaJUbK23oahWMknB8MuXOYa1P0PeDd0CbCTxIStNV4FF+98PJoDw6S5bseZHclv
        is4gPDJHIKb5VVGZ+FLkK9AVwfT5h+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643032229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ew9r9vB/3DGXISd3go8UWQTuDLp3dz+S9C44MFVpDN0=;
        b=dwZMfxgzvHDf7aNmwSoAQci3X5I/9MI6zRsSppiJsbse/jbbaAVvxbYNHmXLz9+vY54Xmt
        fdxMrWCVZmsZG4Cg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 647A0A3B83;
        Mon, 24 Jan 2022 13:50:29 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A1528A05E7; Mon, 24 Jan 2022 14:50:23 +0100 (CET)
Date:   Mon, 24 Jan 2022 14:50:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        Ivan Delalande <colona@arista.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fsnotify: invalidate dcache before IN_DELETE event
Message-ID: <20220124135023.quzjsqtsrxynffrs@quack3.lan>
References: <20220120215305.282577-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120215305.282577-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-01-22 23:53:04, Amir Goldstein wrote:
> Apparently, there are some applications that use IN_DELETE event as an
> invalidation mechanism and expect that if they try to open a file with
> the name reported with the delete event, that it should not contain the
> content of the deleted file.
> 
> Commit 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of
> d_delete()") moved the fsnotify delete hook before d_delete() so fsnotify
> will have access to a positive dentry.
> 
> This allowed a race where opening the deleted file via cached dentry
> is now possible after receiving the IN_DELETE event.
> 
> To fix the regression, create a new hook fsnotify_delete() that takes
> the unlinked inode as an argument and use a helper d_delete_notify() to
> pin the inode, so we can pass it to fsnotify_delete() after d_delete().
> 
> Backporting hint: this regression is from v5.3. Although patch will
> apply with only trivial conflicts to v5.4 and v5.10, it won't build,
> because fsnotify_delete() implementation is different in each of those
> versions (see fsnotify_link()).
> 
> A follow up patch will fix the fsnotify_unlink/rmdir() calls in pseudo
> filesystem that do not need to call d_delete().
> 
> Reported-by: Ivan Delalande <colona@arista.com>
> Link: https://lore.kernel.org/linux-fsdevel/YeNyzoDM5hP5LtGW@visor/
> Fixes: 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of d_delete()")
> Cc: stable@vger.kernel.org # v5.3+
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks. Both patches look good to me now, I've merged them into my tree and
will push them to Linus later this week.

								Honza

> ---
> 
> Changes since v1:
> - Split patch for pseudo filesystem (Jan)
> - Fix logic change for DCACHE_NFSFS_RENAMED (Jan)
> - btrfs also needs d_delete_notify()
> - Make fsnotify_unlink/rmdir() wrappers of fsnotify_delete()
> - FS_DELETE event always uses FSNOTIFY_EVENT_INODE data_type
> 
> 
>  fs/btrfs/ioctl.c         |  6 ++---
>  fs/namei.c               | 10 ++++----
>  include/linux/fsnotify.h | 49 +++++++++++++++++++++++++++++++++++-----
>  3 files changed, 50 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index edfecfe62b4b..a5ee6ffeadf5 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3060,10 +3060,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>  	btrfs_inode_lock(inode, 0);
>  	err = btrfs_delete_subvolume(dir, dentry);
>  	btrfs_inode_unlock(inode, 0);
> -	if (!err) {
> -		fsnotify_rmdir(dir, dentry);
> -		d_delete(dentry);
> -	}
> +	if (!err)
> +		d_delete_notify(dir, dentry);
>  
>  out_dput:
>  	dput(dentry);
> diff --git a/fs/namei.c b/fs/namei.c
> index 1f9d2187c765..3c0568d3155b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3973,13 +3973,12 @@ int vfs_rmdir(struct user_namespace *mnt_userns, struct inode *dir,
>  	dentry->d_inode->i_flags |= S_DEAD;
>  	dont_mount(dentry);
>  	detach_mounts(dentry);
> -	fsnotify_rmdir(dir, dentry);
>  
>  out:
>  	inode_unlock(dentry->d_inode);
>  	dput(dentry);
>  	if (!error)
> -		d_delete(dentry);
> +		d_delete_notify(dir, dentry);
>  	return error;
>  }
>  EXPORT_SYMBOL(vfs_rmdir);
> @@ -4101,7 +4100,6 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
>  			if (!error) {
>  				dont_mount(dentry);
>  				detach_mounts(dentry);
> -				fsnotify_unlink(dir, dentry);
>  			}
>  		}
>  	}
> @@ -4109,9 +4107,11 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
>  	inode_unlock(target);
>  
>  	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
> -	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
> +	if (!error && dentry->d_flags & DCACHE_NFSFS_RENAMED) {
> +		fsnotify_unlink(dir, dentry);
> +	} else if (!error) {
>  		fsnotify_link_count(target);
> -		d_delete(dentry);
> +		d_delete_notify(dir, dentry);
>  	}
>  
>  	return error;
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 3a2d7dc3c607..bb8467cd11ae 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -224,6 +224,43 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode,
>  		      dir, &new_dentry->d_name, 0);
>  }
>  
> +/*
> + * fsnotify_delete - @dentry was unlinked and unhashed
> + *
> + * Caller must make sure that dentry->d_name is stable.
> + *
> + * Note: unlike fsnotify_unlink(), we have to pass also the unlinked inode
> + * as this may be called after d_delete() and old_dentry may be negative.
> + */
> +static inline void fsnotify_delete(struct inode *dir, struct inode *inode,
> +				   struct dentry *dentry)
> +{
> +	__u32 mask = FS_DELETE;
> +
> +	if (S_ISDIR(inode->i_mode))
> +		mask |= FS_ISDIR;
> +
> +	fsnotify_name(mask, inode, FSNOTIFY_EVENT_INODE, dir, &dentry->d_name,
> +		      0);
> +}
> +
> +/**
> + * d_delete_notify - delete a dentry and call fsnotify_delete()
> + * @dentry: The dentry to delete
> + *
> + * This helper is used to guaranty that the unlinked inode cannot be found
> + * by lookup of this name after fsnotify_delete() event has been delivered.
> + */
> +static inline void d_delete_notify(struct inode *dir, struct dentry *dentry)
> +{
> +	struct inode *inode = d_inode(dentry);
> +
> +	ihold(inode);
> +	d_delete(dentry);
> +	fsnotify_delete(dir, inode, dentry);
> +	iput(inode);
> +}
> +
>  /*
>   * fsnotify_unlink - 'name' was unlinked
>   *
> @@ -231,10 +268,10 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode,
>   */
>  static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
>  {
> -	/* Expected to be called before d_delete() */
> -	WARN_ON_ONCE(d_is_negative(dentry));
> +	if (WARN_ON_ONCE(d_is_negative(dentry)))
> +		return;
>  
> -	fsnotify_dirent(dir, dentry, FS_DELETE);
> +	fsnotify_delete(dir, d_inode(dentry), dentry);
>  }
>  
>  /*
> @@ -258,10 +295,10 @@ static inline void fsnotify_mkdir(struct inode *dir, struct dentry *dentry)
>   */
>  static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
>  {
> -	/* Expected to be called before d_delete() */
> -	WARN_ON_ONCE(d_is_negative(dentry));
> +	if (WARN_ON_ONCE(d_is_negative(dentry)))
> +		return;
>  
> -	fsnotify_dirent(dir, dentry, FS_DELETE | FS_ISDIR);
> +	fsnotify_delete(dir, d_inode(dentry), dentry);
>  }
>  
>  /*
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
