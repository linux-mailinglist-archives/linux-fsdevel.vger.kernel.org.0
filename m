Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9A034E739
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhC3MML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 08:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232049AbhC3MMJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:12:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACA6B61927;
        Tue, 30 Mar 2021 12:12:07 +0000 (UTC)
Date:   Tue, 30 Mar 2021 14:12:04 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark
 mask
Message-ID: <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
References: <20210328155624.930558-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210328155624.930558-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 28, 2021 at 06:56:24PM +0300, Amir Goldstein wrote:
> Add a high level hook fsnotify_path_create() which is called from
> syscall context where mount context is available, so that FAN_CREATE
> event can be added to a mount mark mask.
> 
> This high level hook is called in addition to fsnotify_create(),
> fsnotify_mkdir() and fsnotify_link() hooks in vfs helpers where the mount
> context is not available.
> 
> In the context where fsnotify_path_create() will be called, a dentry flag
> flag is set on the new dentry the suppress the FS_CREATE event in the vfs
> level hooks.

Ok, just to make sure this scheme would also work for overlay-style
filesystems like ecryptfs where you possible generate two notify events:
- in the ecryptfs layer
- in the lower fs layer
at least when you set a regular inode watch.

If you set a mount watch you ideally would generate two events in both
layers too, right? But afaict that wouldn't work.

Say, someone creates a new link in ecryptfs the DENTRY_PATH_CREATE
flag will be set on the new ecryptfs dentry and so no notify event will
be generated for the ecryptfs layer again. Then ecryptfs calls
vfs_link() to create a new dentry in the lower layer. The new dentry in
the lower layer won't have DCACHE_PATH_CREATE set. Ok, that makes sense.

But since vfs_link() doesn't have access to the mnt context itself you
can't generate a notify event for the mount associated with the lower
fs. This would cause people who a FAN_MARK_MOUNT watch on that lower fs
mount to not get notified about creation events going through the
ecryptfs layer. Is that right?  Seems like this could be a problem.

Christian

> 
> This functionality was requested by Christian Brauner to replace
> recursive inotify watches for detecting when some path was created under
> an idmapped mount without having to monitor FAN_CREATE events in the
> entire filesystem.
> 
> In combination with more changes to allow unprivileged fanotify listener
> to watch an idmapped mount, this functionality would be usable also by
> nested container managers.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20210318143140.jxycfn3fpqntq34z@wittgenstein/
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> After trying several different approaches, I finally realized that
> making FAN_CREATE available for mount marks is not that hard and it could
> be very useful IMO.
> 
> Adding support for other "inode events" with mount mark, such as
> FAN_ATTRIB, FAN_DELETE, FAN_MOVE may also be possible, but adding support
> for FAN_CREATE was really easy due to the fact that all call sites are
> already surrounded by filename_creat()/done_path_create() calls.
> 
> Also, there is an inherent a-symetry between FAN_CREATE and other
> events. All the rest of the events may be set when watching a postive
> path, for example, to know when a path of a bind mount that was
> "injected" to a container was moved or deleted, it is possible to start
> watching that directory before injecting the bind mount.
> 
> It is not possible to do the same with a "negative" path to know when
> a positive dentry was instantiated at that path.
> 
> This patch provides functionality that is independant of other changes,
> but I also tested it along with other changes that demonstrate how it
> would be utilized in userns setups [1][2].
> 
> As can be seen in dcache.h patch, this patch comes on top a revert patch
> to reclaim an unused dentry flag. If you accept this proposal, I will
> post the full series.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/linux/commits/fanotify_userns
> [2] https://github.com/amir73il/inotify-tools/commits/fanotify_userns
> 
>  fs/namei.c               | 21 ++++++++++++++++++++-
>  include/linux/dcache.h   |  2 +-
>  include/linux/fanotify.h |  8 ++++----
>  include/linux/fsnotify.h | 36 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 216f16e74351..cf979e956938 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3288,7 +3288,7 @@ static const char *open_last_lookups(struct nameidata *nd,
>  		inode_lock_shared(dir->d_inode);
>  	dentry = lookup_open(nd, file, op, got_write);
>  	if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
> -		fsnotify_create(dir->d_inode, dentry);
> +		fsnotify_path_create(&nd->path, dentry);
>  	if (open_flag & O_CREAT)
>  		inode_unlock(dir->d_inode);
>  	else
> @@ -3560,6 +3560,20 @@ struct file *do_file_open_root(struct dentry *dentry, struct vfsmount *mnt,
>  	return file;
>  }
>  
> +static void d_set_path_create(struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	dentry->d_flags |= DCACHE_PATH_CREATE;
> +	spin_unlock(&dentry->d_lock);
> +}
> +
> +static void d_clear_path_create(struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	dentry->d_flags &= ~DCACHE_PATH_CREATE;
> +	spin_unlock(&dentry->d_lock);
> +}
> +
>  static struct dentry *filename_create(int dfd, struct filename *name,
>  				struct path *path, unsigned int lookup_flags)
>  {
> @@ -3617,6 +3631,8 @@ static struct dentry *filename_create(int dfd, struct filename *name,
>  		goto fail;
>  	}
>  	putname(name);
> +	/* Start "path create" context that ends in done_path_create() */
> +	d_set_path_create(dentry);
>  	return dentry;
>  fail:
>  	dput(dentry);
> @@ -3641,6 +3657,9 @@ EXPORT_SYMBOL(kern_path_create);
>  
>  void done_path_create(struct path *path, struct dentry *dentry)
>  {
> +	if (d_inode(dentry))
> +		fsnotify_path_create(path, dentry);
> +	d_clear_path_create(dentry);
>  	dput(dentry);
>  	inode_unlock(path->dentry->d_inode);
>  	mnt_drop_write(path->mnt);
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 4225caa8cf02..d153793d5b95 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -213,7 +213,7 @@ struct dentry_operations {
>  #define DCACHE_SYMLINK_TYPE		0x00600000 /* Symlink (or fallthru to such) */
>  
>  #define DCACHE_MAY_FREE			0x00800000
> -/* Was #define DCACHE_FALLTHRU			0x01000000 */

Indeed, that seems completely unused.
