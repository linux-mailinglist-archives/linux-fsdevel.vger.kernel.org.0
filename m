Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625AC1EA0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 10:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEOIYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 04:24:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfEOIYM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 04:24:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 729DCAD47;
        Wed, 15 May 2019 08:24:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B1EB71E3CA1; Wed, 15 May 2019 10:24:07 +0200 (CEST)
Date:   Wed, 15 May 2019 10:24:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/4] fsnotify: move fsnotify_nameremove() hook out
 of d_delete()
Message-ID: <20190515082407.GD11965@quack2.suse.cz>
References: <20190514221901.29125-1-amir73il@gmail.com>
 <20190514221901.29125-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514221901.29125-5-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-05-19 01:19:01, Amir Goldstein wrote:
> d_delete() was piggy backed for the fsnotify_nameremove() hook when
> in fact not all callers of d_delete() care about fsnotify events.
> 
> For all callers of d_delete() that may be interested in fsnotify
> events, we made sure that parent dir and d_name are stable and
> we call the fsnotify_remove() hook before calling d_delete().
> Because of that, fsnotify_remove() does not need the safety measures
> that were in fsnotify_nameremove() to stabilize parent and name.

Looks good, some smaller comments below.

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/afs/dir_silly.c               |  5 ----
>  fs/btrfs/ioctl.c                 |  4 +++-
>  fs/configfs/dir.c                |  3 +++
>  fs/dcache.c                      |  2 --
>  fs/devpts/inode.c                |  1 +
>  fs/nfs/unlink.c                  |  6 -----
>  fs/notify/fsnotify.c             | 41 --------------------------------
>  include/linux/fsnotify.h         |  7 +++++-
>  include/linux/fsnotify_backend.h |  4 ----
>  9 files changed, 13 insertions(+), 60 deletions(-)
> 
> diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
> index f6f89fdab6b2..d3494825d08a 100644
> --- a/fs/afs/dir_silly.c
> +++ b/fs/afs/dir_silly.c
> @@ -57,11 +57,6 @@ static int afs_do_silly_rename(struct afs_vnode *dvnode, struct afs_vnode *vnode
>  		if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
>  			afs_edit_dir_add(dvnode, &new->d_name,
>  					 &vnode->fid, afs_edit_dir_for_silly_1);
> -
> -		/* vfs_unlink and the like do not issue this when a file is
> -		 * sillyrenamed, so do it here.
> -		 */
> -		fsnotify_nameremove(old, 0);
>  	}
>  
>  	_leave(" = %d", ret);

This changes the behavior when rename happens to overwrite a file, doesn't
it? It is more consistent that way and I don't think anybody depends on it
so I agree but it might deserve a comment in the changelog.

> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 591e82ba443c..78566002234a 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -1797,6 +1798,7 @@ void configfs_unregister_group(struct config_group *group)
>  	configfs_detach_group(&group->cg_item);
>  	d_inode(dentry)->i_flags |= S_DEAD;
>  	dont_mount(dentry);
> +	fsnotify_remove(d_inode(parent), dentry);
>  	d_delete(dentry);
>  	inode_unlock(d_inode(parent));
>  
> @@ -1925,6 +1927,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
>  	configfs_detach_group(&group->cg_item);
>  	d_inode(dentry)->i_flags |= S_DEAD;
>  	dont_mount(dentry);
> +	fsnotify_remove(d_inode(root), dentry);
>  	inode_unlock(d_inode(dentry));
>  
>  	d_delete(dentry);

Is his really needed? We have a call chain:
 configfs_detach_group()
   configfs_detach_item()
     configfs_remove_dir()
       remove_dir()
         simple_rmdir()

Ah, but this is the special configfs treatment you were speaking about as
configfs_detach_group() can get called also from vfs_rmdir(). I see. But
please separate this into a special patch with a good changelog.

> diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
> index 52d533967485..0effeee28352 100644
> --- a/fs/nfs/unlink.c
> +++ b/fs/nfs/unlink.c
> @@ -396,12 +396,6 @@ nfs_complete_sillyrename(struct rpc_task *task, struct nfs_renamedata *data)
>  		nfs_cancel_async_unlink(dentry);
>  		return;
>  	}
> -
> -	/*
> -	 * vfs_unlink and the like do not issue this when a file is
> -	 * sillyrenamed, so do it here.
> -	 */
> -	fsnotify_nameremove(dentry, 0);
>  }

Ditto as for AFS I assume...

> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 8c7cbac7183c..5433e37fb0c5 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -107,47 +107,6 @@ void fsnotify_sb_delete(struct super_block *sb)
>  	fsnotify_clear_marks_by_sb(sb);
>  }
>  
> -/*
> - * fsnotify_nameremove - a filename was removed from a directory
> - *
> - * This is mostly called under parent vfs inode lock so name and
> - * dentry->d_parent should be stable. However there are some corner cases where
> - * inode lock is not held. So to be on the safe side and be reselient to future
> - * callers and out of tree users of d_delete(), we do not assume that d_parent
> - * and d_name are stable and we use dget_parent() and
> - * take_dentry_name_snapshot() to grab stable references.
> - */
> -void fsnotify_nameremove(struct dentry *dentry, int isdir)
> -{
> -	struct dentry *parent;
> -	struct name_snapshot name;
> -	__u32 mask = FS_DELETE;
> -
> -	/* d_delete() of pseudo inode? (e.g. __ns_get_path() playing tricks) */
> -	if (IS_ROOT(dentry))
> -		return;
> -
> -	if (isdir)
> -		mask |= FS_ISDIR;
> -
> -	parent = dget_parent(dentry);
> -	/* Avoid unneeded take_dentry_name_snapshot() */
> -	if (!(d_inode(parent)->i_fsnotify_mask & FS_DELETE) &&
> -	    !(dentry->d_sb->s_fsnotify_mask & FS_DELETE))
> -		goto out_dput;
> -
> -	take_dentry_name_snapshot(&name, dentry);
> -
> -	fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
> -		 &name.name, 0);
> -
> -	release_dentry_name_snapshot(&name);
> -
> -out_dput:
> -	dput(parent);
> -}
> -EXPORT_SYMBOL(fsnotify_nameremove);
> -
>  /*
>   * Given an inode, first check if we care what happens to our children.  Inotify
>   * and dnotify both tell their parents about events.  If we care about any event
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 455dff82595e..7f68cb9825dd 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -158,10 +158,15 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
>   */
>  static inline void fsnotify_remove(struct inode *dir, struct dentry *dentry)
>  {
> +	__u32 mask = FS_DELETE;
> +
>  	/* Expected to be called before d_delete() */
>  	WARN_ON_ONCE(d_is_negative(dentry));
>  
> -	/* TODO: call fsnotify_dirent() */
> +	if (d_is_dir(dentry))
> +		mask |= FS_ISDIR;
> +
> +	fsnotify_dirent(dir, dentry, mask);
>  }

With folding patch 2 into this patch, I'd leave fsnotify changes for a
separate patch. I.e., keep fsnotify_nameremove() as is in this patch just
change its callsites and then simplify fsnotify_nameremove() in the next
patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
