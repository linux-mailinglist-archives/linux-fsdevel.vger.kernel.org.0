Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE8161E99B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 09:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfEOH5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 03:57:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:58086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbfEOH5v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 03:57:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20337AFD2;
        Wed, 15 May 2019 07:57:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DB6F41E3CA1; Wed, 15 May 2019 09:57:46 +0200 (CEST)
Date:   Wed, 15 May 2019 09:57:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/4] fsnotify: add empty fsnotify_remove() hook
Message-ID: <20190515075746.GC11965@quack2.suse.cz>
References: <20190514221901.29125-1-amir73il@gmail.com>
 <20190514221901.29125-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514221901.29125-3-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-05-19 01:18:59, Amir Goldstein wrote:
> We would like to move fsnotify_nameremove() calls from d_delete()
> into a higher layer where the hook makes more sense and so we can
> consider every d_delete() call site individually.
> 
> Start by creating an empty hook called fsnotify_remove() and place
> it in the proper VFS call sites.  After all d_delete() call sites
> will be converted to use the new hook, it will replace the old
> fsnotify_nameremove() hook in d_delete().
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Hum, I would just fold this into patch 4. It is not that big and I don't
think it adds to the clarity of the whole series. Rather on contrary it
makes verifying that we didn't miss any conversion harder... Also that way
we don't have to rename the fsnotify hook.

BTW, you seem to have forgotten to provide an empty stub for
!CONFIG_FSNOTIFY case here.

								Honza

> ---
>  fs/libfs.c               |  5 ++++-
>  fs/namei.c               |  2 ++
>  include/linux/fsnotify.h | 13 +++++++++++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 030e67c52b5f..0dd676fc9272 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -10,6 +10,7 @@
>  #include <linux/cred.h>
>  #include <linux/mount.h>
>  #include <linux/vfs.h>
> +#include <linux/fsnotify.h>
>  #include <linux/quotaops.h>
>  #include <linux/mutex.h>
>  #include <linux/namei.h>
> @@ -367,8 +368,10 @@ int simple_remove(struct inode *dir, struct dentry *dentry)
>  	else
>  		ret = simple_unlink(dir, dentry);
>  
> -	if (!ret)
> +	if (!ret) {
> +		fsnotify_remove(dir, dentry);
>  		d_delete(dentry);
> +	}
>  	dput(dentry);
>  
>  	return ret;
> diff --git a/fs/namei.c b/fs/namei.c
> index 20831c2fbb34..c9eda9cc5d43 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3883,6 +3883,7 @@ int vfs_rmdir(struct inode *dir, struct dentry *dentry)
>  	dentry->d_inode->i_flags |= S_DEAD;
>  	dont_mount(dentry);
>  	detach_mounts(dentry);
> +	fsnotify_remove(dir, dentry);
>  
>  out:
>  	inode_unlock(dentry->d_inode);
> @@ -3999,6 +4000,7 @@ int vfs_unlink(struct inode *dir, struct dentry *dentry, struct inode **delegate
>  			if (!error) {
>  				dont_mount(dentry);
>  				detach_mounts(dentry);
> +				fsnotify_remove(dir, dentry);
>  			}
>  		}
>  	}
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 94972e8eb6d1..455dff82595e 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -151,6 +151,19 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
>  	__fsnotify_vfsmount_delete(mnt);
>  }
>  
> +/*
> + * fsnotify_remove - a filename was removed from a directory
> + *
> + * Caller must make sure that dentry->d_name is stable.
> + */
> +static inline void fsnotify_remove(struct inode *dir, struct dentry *dentry)
> +{
> +	/* Expected to be called before d_delete() */
> +	WARN_ON_ONCE(d_is_negative(dentry));
> +
> +	/* TODO: call fsnotify_dirent() */
> +}
> +
>  /*
>   * fsnotify_inoderemove - an inode is going away
>   */
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
