Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C18B167A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 18:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfEGQTb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 12:19:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:43028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfEGQTb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 12:19:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D22CAE12;
        Tue,  7 May 2019 16:19:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8377D1E3C5A; Tue,  7 May 2019 18:19:28 +0200 (CEST)
Date:   Tue, 7 May 2019 18:19:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKP <lkp@01.org>
Subject: Re: [PATCH v2] fsnotify: fix unlink performance regression
Message-ID: <20190507161928.GE4635@quack2.suse.cz>
References: <CAOQ4uxgde7UeFRkD13CHYX2g3SyKY92zX8Tt_wSShkNd9QPYOA@mail.gmail.com>
 <20190505200728.5892-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505200728.5892-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 05-05-19 23:07:28, Amir Goldstein wrote:
> __fsnotify_parent() has an optimization in place to avoid unneeded
> take_dentry_name_snapshot().  When fsnotify_nameremove() was changed
> not to call __fsnotify_parent(), we left out the optimization.
> Kernel test robot reported a 5% performance regression in concurrent
> unlink() workload.
> 
> Modify __fsnotify_parent() so that it can be called also to report
> directory modififcation events and use it from fsnotify_nameremove().
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Link: https://lore.kernel.org/lkml/20190505062153.GG29809@shao2-debian/
> Link: https://lore.kernel.org/linux-fsdevel/20190104090357.GD22409@quack2.suse.cz/
> Fixes: 5f02a8776384 ("fsnotify: annotate directory entry modification events")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> A nicer approach reusing __fsnotify_parent() instead of copying code
> from it.
> 
> This version does not apply cleanly to Al's for-next branch (there are
> some fsnotify changes in work.dcache). The conflict is trivial and
> resolved on my fsnotify branch [1].

Hum, let me check if I understand the situation right. We've changed
fsnotify_nameremove() to not use fsnotify_parent() as we don't want to
report FS_EVENT_ON_CHILD with it anymore. We should use fsnotify_dirent()
as for all other directory event notification handlers but that's
problematic due to different locking context and possible instability of
parent.

Honestly I don't like the patch below much. How we are notifying parent
without sending FS_EVENT_ON_CHILD and modify behavior based on that flag
just looks subtle. So I'd rather move the fsnotify call to vfs_unlink(),
vfs_rmdir(), simple_unlink(), simple_rmdir(), and then those few callers of
d_delete() that remain as you suggest elsewhere in this thread. And then we
get more consistent context for fsnotify_nameremove() and could just use
fsnotify_dirent(). 

								Honza

> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index df06f3da166c..265b726d6e8d 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -151,31 +151,31 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>  	spin_unlock(&inode->i_lock);
>  }
>  
> -/* Notify this dentry's parent about a child's events. */
> +/*
> + * Notify this dentry's parent about an event and make sure that name is stable.
> + * Events "on child" are only reported if parent is watching.
> + * Directory modification events are also reported if super block is watching.
> + */
>  int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask)
>  {
>  	struct dentry *parent;
>  	struct inode *p_inode;
>  	int ret = 0;
> +	bool on_child = (mask & FS_EVENT_ON_CHILD);
> +	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
>  
> -	if (!dentry)
> -		dentry = path->dentry;
> -
> -	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
> +	if (on_child && !(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
>  		return 0;
>  
>  	parent = dget_parent(dentry);
>  	p_inode = parent->d_inode;
>  
> -	if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
> +	if (on_child && unlikely(!fsnotify_inode_watches_children(p_inode))) {
>  		__fsnotify_update_child_dentry_flags(p_inode);
> -	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
> +	} else if ((p_inode->i_fsnotify_mask & test_mask) ||
> +		   (!on_child && (dentry->d_sb->s_fsnotify_mask & test_mask))) {
>  		struct name_snapshot name;
>  
> -		/* we are notifying a parent so come up with the new mask which
> -		 * specifies these are events which came from a child. */
> -		mask |= FS_EVENT_ON_CHILD;
> -
>  		take_dentry_name_snapshot(&name, dentry);
>  		if (path)
>  			ret = fsnotify(p_inode, mask, path, FSNOTIFY_EVENT_PATH,
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 09587e2860b5..8641bf9a1eda 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -37,7 +37,7 @@ static inline int fsnotify_parent(const struct path *path,
>  	if (!dentry)
>  		dentry = path->dentry;
>  
> -	return __fsnotify_parent(path, dentry, mask);
> +	return __fsnotify_parent(path, dentry, mask | FS_EVENT_ON_CHILD);
>  }
>  
>  /*
> @@ -158,13 +158,11 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
>   * dentry->d_parent should be stable. However there are some corner cases where
>   * inode lock is not held. So to be on the safe side and be reselient to future
>   * callers and out of tree users of d_delete(), we do not assume that d_parent
> - * and d_name are stable and we use dget_parent() and
> + * and d_name are stable and we use __fsnotify_parent() to
>   * take_dentry_name_snapshot() to grab stable references.
>   */
>  static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
>  {
> -	struct dentry *parent;
> -	struct name_snapshot name;
>  	__u32 mask = FS_DELETE;
>  
>  	/* d_delete() of pseudo inode? (e.g. __ns_get_path() playing tricks) */
> @@ -174,14 +172,7 @@ static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
>  	if (isdir)
>  		mask |= FS_ISDIR;
>  
> -	parent = dget_parent(dentry);
> -	take_dentry_name_snapshot(&name, dentry);
> -
> -	fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
> -		 name.name, 0);
> -
> -	release_dentry_name_snapshot(&name);
> -	dput(parent);
> +	__fsnotify_parent(NULL, dentry, mask);
>  }
>  
>  /*
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
