Return-Path: <linux-fsdevel+bounces-41073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99507A2A979
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280921697AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5302500D0;
	Thu,  6 Feb 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcqSW+xY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DB223F291;
	Thu,  6 Feb 2025 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847748; cv=none; b=l7ftjc6EasGTMy/QZM02+7TA3WB2NvTbNcr6AXj43tBRzUarOQen3lIq92/mkwOKbB+SCQS944WroDYEwHvffso0eSaQ7ze8RtSOItZucs5D3JGz1PjFBNWJEk44pd98BQCUaJ/rbmQ5hUbSq6Plim8Vy4ggBClaHr8UVvpVOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847748; c=relaxed/simple;
	bh=mW0kiXt6ZwlcQAgUr+mAVXAHTAJjQCG/WlZAFgQ9A3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU3SB49aCEyjTP+jNQmEUEYBhVWXSDp9oPXZecXGOUthkRPPqzK/TjfXhBh8y6yOKYsTfBQrPSbTmaFRJqmp/4PLr6/3ke4EEvJA3LFT6hLtnuj2Iqa080y9406Z8Y+kAk6cFQKykHvmlRRrhsX60YO1NxOQJUazCa2yrvX91sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcqSW+xY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3E4C4CEDD;
	Thu,  6 Feb 2025 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738847748;
	bh=mW0kiXt6ZwlcQAgUr+mAVXAHTAJjQCG/WlZAFgQ9A3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcqSW+xYlc/Pi1Vj25iywMXRrNldi5kuk9QGUtYh4WTu9JyUUsGHbdsonnE9r/d50
	 hySQFzIAiaWoWaBMmOu2rEPqDsNihB2LDVFjJIKLmGHIEpLF15kO/hrVfdJte70cVq
	 kgqlp1e1xam4XUUBbnEIaiRFLym2RrKMzlA3xFqzxjhPNJRQ086HgWUuke4XSoM/rK
	 XbgdwwgCAXD0dz8BEnOD+BwiQonwNQ6hlbXBlDdLetOYQyYupHMhz6fbB00+PoPm/b
	 70uowsCj0XNbLRYSFw0nfiXgaR2r0rNapHPuxoz9JYfAS89POVUZNnrnmMwrSLq+0S
	 TTcHfoXcBqOOg==
Date: Thu, 6 Feb 2025 14:15:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/19] VFS: add _async versions of the various directory
 modifying inode_operations
Message-ID: <20250206-bestochen-zulauf-34ce94cc4cbc@brauner>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-10-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-10-neilb@suse.de>

On Thu, Feb 06, 2025 at 04:42:46PM +1100, NeilBrown wrote:
> These "_async" versions of various inode operations are only guaranteed
> a shared lock on the directory but if the directory isn't exclusively
> locked then they are guaranteed an exclusive lock on the dentry within
> the directory (which will be implemented in a later patch).
> 
> This will allow a graceful transition from exclusive to shared locking
> for directory updates, and even to async updates which can complete with
> no lock on the directory - only on the dentry.
> 
> mkdir_async is a bit different as it optionally returns a new dentry
> for cases when the filesystem is not able to use the original dentry.
> This allows vfs_mkdir_return() to avoid the need for an extra lookup.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  Documentation/filesystems/locking.rst |  51 ++++++++-
>  Documentation/filesystems/porting.rst |  10 ++
>  Documentation/filesystems/vfs.rst     |  24 +++++
>  fs/namei.c                            | 142 +++++++++++++++++++++-----
>  include/linux/fs.h                    |  24 +++++
>  5 files changed, 223 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index d20a32b77b60..adeead366332 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -62,15 +62,24 @@ inode_operations
>  prototypes::
>  
>  	int (*create) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t, bool);
> +	int (*create_async) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t, bool, struct dirop_ret *);

If we end up doing this then imho the correct thing to do would be to
extend the existing operations. Yes, that's more work I know as I've
done that multiple times myself and it's a bit more annoying churn but
we shouldn't just keep adding new methods without a good reason.

I assume that you've done that mostly so that you wouldn't be held up by
menial work for the prototype. That's obviously fine. But for the final
thing we should just fixup everyone.

>  	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
>  	int (*link) (struct dentry *,struct inode *,struct dentry *);
> +	int (*link_async) (struct dentry *,struct inode *,struct dentry *, struct dirop_ret *);
>  	int (*unlink) (struct inode *,struct dentry *);
> +	int (*unlink_async) (struct inode *,struct dentry *, struct dirop_ret *);
>  	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
> +	int (*symlink_async) (struct mnt_idmap *, struct inode *,struct dentry *,const char *m , struct dirop_ret *);
>  	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
> +	struct dentry * (*mkdir_async) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t, struct dirop_ret *);
>  	int (*rmdir) (struct inode *,struct dentry *);
> +	int (*rmdir_async) (struct inode *,struct dentry *, struct dirop_ret *);
>  	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t);
> +	int (*mknod_async) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t, struct dirop_ret *);
>  	int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
>  			struct inode *, struct dentry *, unsigned int);
> +	int (*rename_async) (struct mnt_idmap *, struct inode *, struct dentry *,
> +			struct inode *, struct dentry *, unsigned int, struct dirop_ret *);
>  	int (*readlink) (struct dentry *, char __user *,int);
>  	const char *(*get_link) (struct dentry *, struct inode *, struct delayed_call *);
>  	void (*truncate) (struct inode *);
> @@ -84,6 +93,9 @@ prototypes::
>  	int (*atomic_open)(struct inode *, struct dentry *,
>  				struct file *, unsigned open_flag,
>  				umode_t create_mode);
> +	int (*atomic_open_async)(struct inode *, struct dentry *,
> +				struct file *, unsigned open_flag,
> +				umode_t create_mode, struct dirop_ret *);
>  	int (*tmpfile) (struct mnt_idmap *, struct inode *,
>  			struct file *, umode_t);
>  	int (*fileattr_set)(struct mnt_idmap *idmap,
> @@ -95,18 +107,33 @@ prototypes::
>  locking rules:
>  	all may block
>  
> +All directory-modifying operations are called with an exclusive lock on
> +the target dentry or dentries using DCACHE_PAR_LOOKUP.  This allows the
> +shared lock on i_rwsem for the _async ops to be safe.  The lock on
> +i_rwsem may be dropped as soon as the op returns, though if it returns
> +-EINPROGRESS the lock using DCACHE_PAR_UPDATE will not be dropped until
> +the callback is called.
> +
>  ==============	==================================================
>  ops		i_rwsem(inode)
>  ==============	==================================================
>  lookup:		shared
>  create:		exclusive
> +create_async:	shared
>  link:		exclusive (both)
> +link_async:	exclusive on source, shared on target
>  mknod:		exclusive
> +mknod_async:	shared
>  symlink:	exclusive
> +symlink_async:	shared
>  mkdir:		exclusive
> +mkdir_async:	shared
>  unlink:		exclusive (both)
> +unlink_async:	exclusive on object, shared on directory/name
>  rmdir:		exclusive (both)(see below)
> +rmdir_async:	exclusive on object, shared on directory/name (see below)
>  rename:		exclusive (both parents, some children)	(see below)
> +rename_async:	shared (both parents) exclusive (some children)	(see below)
>  readlink:	no
>  get_link:	no
>  setattr:	exclusive
> @@ -118,6 +145,7 @@ listxattr:	no
>  fiemap:		no
>  update_time:	no
>  atomic_open:	shared (exclusive if O_CREAT is set in open flags)
> +atomic_open_async:	shared (if O_CREAT is not set, then may not have exclusive lock on name)
>  tmpfile:	no
>  fileattr_get:	no or exclusive
>  fileattr_set:	exclusive
> @@ -125,8 +153,10 @@ get_offset_ctx  no
>  ==============	==================================================
>  
>  
> -	Additionally, ->rmdir(), ->unlink() and ->rename() have ->i_rwsem
> -	exclusive on victim.
> +	Additionally, ->rmdir(), ->unlink() and ->rename(), as well as _async
> +	versions, have ->i_rwsem exclusive on victim.  This exclusive lock
> +        may be dropped when the op completes even if the async operation is
> +        continuing.
>  	cross-directory ->rename() has (per-superblock) ->s_vfs_rename_sem.
>  	->unlink() and ->rename() have ->i_rwsem exclusive on all non-directories
>  	involved.
> @@ -135,6 +165,23 @@ get_offset_ctx  no
>  See Documentation/filesystems/directory-locking.rst for more detailed discussion
>  of the locking scheme for directory operations.
>  
> +The _async operations will be passed a (non-NULL) struct dirop_ret pointer::
> +
> +	struct dirop_ret {
> +		union {
> +			int err;
> +			struct dentry *dentry;
> +		};
> +		void (*done_cb)(struct dirop_ret*);
> +	};
> +
> +They may return -EINPROGRESS (or ERR_PTR(-EINPROGRESS)) in which case
> +the op will continue asynchronously.  When it completes the result,
> +which must NOT be -EINPROGRESS, is stored in err or dentry (as
> +appropriate) and the done_cb() function is called.  Callers can only
> +make use of the asynchrony when they determine that no lock need be held
> +on i_rwsem.
> +
>  xattr_handler operations
>  ========================
>  
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 1639e78e3146..a736c9f30d9d 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1157,3 +1157,13 @@ in normal case it points into the pathname being looked up.
>  NOTE: if you need something like full path from the root of filesystem,
>  you are still on your own - this assists with simple cases, but it's not
>  magic.
> +
> +---
> +
> +**recommended**
> +
> +create_async, link_async, unlink_async, rmdir_async, mknod_async,
> +rename_async, atomic_open_async can be provided instead of the
> +corresponding inode_operations with the "_async" suffix.  Multiple
> +_async operations can be performed in a given directory concurrently,
> +but never on the same name.
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 31eea688609a..e18655054e6c 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -491,15 +491,24 @@ As of kernel 2.6.22, the following members are defined:
>  
>  	struct inode_operations {
>  		int (*create) (struct mnt_idmap *, struct inode *,struct dentry *, umode_t, bool);
> +		int (*create_async) (struct mnt_idmap *, struct inode *,struct dentry *, umode_t, bool, struct dirop_ret *);
>  		struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
>  		int (*link) (struct dentry *,struct inode *,struct dentry *);
> +		int (*link_async) (struct dentry *,struct inode *,struct dentry *, struct dirop_ret *);
>  		int (*unlink) (struct inode *,struct dentry *);
> +		int (*unlink_async) (struct inode *,struct dentry *, struct dirop_ret *);
>  		int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
> +		int (*symlink_async) (struct mnt_idmap *, struct inode *,struct dentry *,const char *, struct dirop_ret *);
>  		int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
> +		struct dentry * (*mkdir_async) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t, struct dirop_ret *);
>  		int (*rmdir) (struct inode *,struct dentry *);
> +		int (*rmdir_async) (struct inode *,struct dentry *, struct dirop_ret *);
>  		int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t);
> +		int (*mknod_async) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t, struct dirop_ret *);
>  		int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
>  			       struct inode *, struct dentry *, unsigned int);
> +		int (*rename_async) (struct mnt_idmap *, struct inode *, struct dentry *,
> +			       struct inode *, struct dentry *, unsigned int, struct dirop_ret *);
>  		int (*readlink) (struct dentry *, char __user *,int);
>  		const char *(*get_link) (struct dentry *, struct inode *,
>  					 struct delayed_call *);
> @@ -511,6 +520,8 @@ As of kernel 2.6.22, the following members are defined:
>  		void (*update_time)(struct inode *, struct timespec *, int);
>  		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
>  				   unsigned open_flag, umode_t create_mode);
> +		int (*atomic_open_async)(struct inode *, struct dentry *, struct file *,
> +				   unsigned open_flag, umode_t create_mode, struct dirop_ret *);
>  		int (*tmpfile) (struct mnt_idmap *, struct inode *, struct file *, umode_t);
>  		struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
>  	        int (*set_acl)(struct mnt_idmap *, struct dentry *, struct posix_acl *, int);
> @@ -524,6 +535,7 @@ Again, all methods are called without any locks being held, unless
>  otherwise noted.
>  
>  ``create``
> +``create_async``
>  	called by the open(2) and creat(2) system calls.  Only required
>  	if you want to support regular files.  The dentry you get should
>  	not have an inode (i.e. it should be a negative dentry).  Here
> @@ -546,29 +558,39 @@ otherwise noted.
>  	directory inode semaphore held
>  
>  ``link``
> +``link_async``
>  	called by the link(2) system call.  Only required if you want to
>  	support hard links.  You will probably need to call
>  	d_instantiate() just as you would in the create() method
>  
>  ``unlink``
> +``unlink_async``
>  	called by the unlink(2) system call.  Only required if you want
>  	to support deleting inodes
>  
>  ``symlink``
> +``symlink_async``
>  	called by the symlink(2) system call.  Only required if you want
>  	to support symlinks.  You will probably need to call
>  	d_instantiate() just as you would in the create() method
>  
>  ``mkdir``
> +``mkdir_async``
>  	called by the mkdir(2) system call.  Only required if you want
>  	to support creating subdirectories.  You will probably need to
>  	call d_instantiate() just as you would in the create() method
>  
> +	mkdir_async can return an alternate dentry, much like lookup.
> +	In this case the original dentry will still be negative and will
> +	be unhashed.
> +
>  ``rmdir``
> +``rmdir_async``
>  	called by the rmdir(2) system call.  Only required if you want
>  	to support deleting subdirectories
>  
>  ``mknod``
> +``mknod_async``
>  	called by the mknod(2) system call to create a device (char,
>  	block) inode or a named pipe (FIFO) or socket.  Only required if
>  	you want to support creating these types of inodes.  You will
> @@ -576,6 +598,7 @@ otherwise noted.
>  	create() method
>  
>  ``rename``
> +``rename_async``
>  	called by the rename(2) system call to rename the object to have
>  	the parent and name given by the second inode and dentry.
>  
> @@ -647,6 +670,7 @@ otherwise noted.
>  	itself and call mark_inode_dirty_sync.
>  
>  ``atomic_open``
> +``atomic_open_async``
>  	called on the last component of an open.  Using this optional
>  	method the filesystem can look up, possibly create and open the
>  	file in one atomic operation.  If it wants to leave actual
> diff --git a/fs/namei.c b/fs/namei.c
> index 3c0feca081a2..eadde9de73bf 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -123,6 +123,41 @@
>   * PATH_MAX includes the nul terminator --RR.
>   */
>  
> +static void dirop_done_cb(struct dirop_ret *dret)
> +{
> +	wake_up_var(dret);
> +}
> +
> +#define DO_DIROP(dir, op, ...)						\
> +	({								\
> +		 struct dirop_ret dret;					\
> +		 int ret;						\
> +		 dret.err = -EINPROGRESS;				\
> +		 dret.done_cb = dirop_done_cb;				\
> +		 ret = (dir)->i_op->op(__VA_ARGS__, &dret);		\
> +		 if (ret == -EINPROGRESS) {				\
> +			 wait_var_event(&dret,				\
> +					dret.err != -EINPROGRESS);	\
> +			 ret = dret.err;				\
> +		 }							\
> +		 ret;							\
> +	})
> +
> +#define DO_DE_DIROP(dir, op, ...)					\
> +	({								\
> +		 struct dirop_ret dret;					\
> +		 struct dentry *ret;					\
> +		 dret.dentry = ERR_PTR(-EINPROGRESS);			\
> +		 dret.done_cb = dirop_done_cb;				\
> +		 ret = (dir)->i_op->op(__VA_ARGS__, &dret);		\
> +		 if (ret == ERR_PTR(-EINPROGRESS)) {			\
> +			 wait_var_event(&dret,				\
> +					dret.dentry != ERR_PTR(-EINPROGRESS));	\
> +			 ret = dret.dentry;				\
> +		 }							\
> +		 ret;							\
> +	})

We should also try to avoid these ugly wrappers. That'll be easier if we
don't have multiple methods as well.

> +
>  #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
>  
>  struct filename *
> @@ -3403,14 +3438,17 @@ int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		return error;
>  
> -	if (!dir->i_op->create)
> +	if (!dir->i_op->create && !dir->i_op->create_async)
>  		return -EACCES;	/* shouldn't it be ENOSYS? */
>  
>  	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
>  	error = security_inode_create(dir, dentry, mode);
>  	if (error)
>  		return error;
> -	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
> +	if (dir->i_op->create_async)
> +		error = DO_DIROP(dir, create_async, idmap, dir, dentry, mode, want_excl);
> +	else
> +		error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
>  	if (!error)
>  		fsnotify_create(dir, dentry);
>  	return error;
> @@ -3571,8 +3609,12 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
>  
>  	file->f_path.dentry = DENTRY_NOT_SET;
>  	file->f_path.mnt = nd->path.mnt;
> -	error = dir->i_op->atomic_open(dir, dentry, file,
> -				       open_to_namei_flags(open_flag), mode);
> +	if (dir->i_op->atomic_open_async)
> +		error = DO_DIROP(dir, atomic_open_async, dir, dentry, file,
> +				 open_to_namei_flags(open_flag), mode);
> +	else
> +		error = dir->i_op->atomic_open(dir, dentry, file,
> +					       open_to_namei_flags(open_flag), mode);
>  	d_lookup_done(dentry);
>  	if (!error) {
>  		if (file->f_mode & FMODE_OPENED) {
> @@ -3680,7 +3722,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	}
>  	if (create_error)
>  		open_flag &= ~O_CREAT;
> -	if (dir_inode->i_op->atomic_open) {
> +	if (dir_inode->i_op->atomic_open || dir_inode->i_op->atomic_open_async) {
>  		dentry = atomic_open(nd, dentry, file, open_flag, mode);
>  		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
>  			dentry = ERR_PTR(create_error);
> @@ -3705,13 +3747,16 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
>  		file->f_mode |= FMODE_CREATED;
>  		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> -		if (!dir_inode->i_op->create) {
> -			error = -EACCES;
> -			goto out_dput;
> -		}
>  
> -		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
> -						mode, open_flag & O_EXCL);
> +		if (dir_inode->i_op->create_async)
> +			error = DO_DIROP(dir_inode, create_async, idmap, dir_inode,
> +					 dentry, mode,  open_flag & O_EXCL);
> +		else if (dir_inode->i_op->create)
> +			error = dir_inode->i_op->create(idmap, dir_inode,
> +							dentry, mode,
> +							open_flag & O_EXCL);
> +		else
> +			error = -EACCES;
>  		if (error)
>  			goto out_dput;
>  	}
> @@ -4217,7 +4262,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	    !capable(CAP_MKNOD))
>  		return -EPERM;
>  
> -	if (!dir->i_op->mknod)
> +	if (!dir->i_op->mknod && !dir->i_op->mknod_async)
>  		return -EPERM;
>  
>  	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
> @@ -4229,7 +4274,10 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		return error;
>  
> -	error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
> +	if (dir->i_op->mknod_async)
> +		error = DO_DIROP(dir, mknod_async, idmap, dir, dentry, mode, dev);
> +	else
> +		error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
>  	if (!error)
>  		fsnotify_create(dir, dentry);
>  	return error;
> @@ -4340,7 +4388,7 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		return error;
>  
> -	if (!dir->i_op->mkdir)
> +	if (!dir->i_op->mkdir && !dir->i_op->mkdir_async)
>  		return -EPERM;
>  
>  	mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
> @@ -4351,7 +4399,16 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (max_links && dir->i_nlink >= max_links)
>  		return -EMLINK;
>  
> -	error = dir->i_op->mkdir(idmap, dir, dentry, mode);
> +	if (dir->i_op->mkdir_async) {
> +		struct dentry *de;
> +		de = DO_DE_DIROP(dir, mkdir_async, idmap, dir, dentry, mode);
> +		if (IS_ERR(de))
> +			error = PTR_ERR(de);
> +		else if (de)
> +			dput(de);
> +	} else {
> +		error = dir->i_op->mkdir(idmap, dir, dentry, mode);
> +	}
>  	if (!error)
>  		fsnotify_mkdir(dir, dentry);
>  	return error;
> @@ -4399,6 +4456,20 @@ int vfs_mkdir_return(struct mnt_idmap *idmap, struct inode *dir,
>  	if (max_links && dir->i_nlink >= max_links)
>  		return -EMLINK;
>  
> +	if (dir->i_op->mkdir_async) {
> +		struct dentry *de;
> +
> +		de = DO_DE_DIROP(dir, mkdir_async, idmap, dir, dentry, mode);
> +		if (IS_ERR(de))
> +			return PTR_ERR(de);
> +		if (de) {
> +			dput(dentry);
> +			*dentryp = de;
> +		}
> +		fsnotify_mkdir(dir, dentry);
> +		return 0;
> +	}
> +
>  	error = dir->i_op->mkdir(idmap, dir, dentry, mode);
>  	if (!error) {
>  		fsnotify_mkdir(dir, dentry);
> @@ -4488,7 +4559,7 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		return error;
>  
> -	if (!dir->i_op->rmdir)
> +	if (!dir->i_op->rmdir && !dir->i_op->rmdir_async)
>  		return -EPERM;
>  
>  	dget(dentry);
> @@ -4503,7 +4574,10 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		goto out;
>  
> -	error = dir->i_op->rmdir(dir, dentry);
> +	if (dir->i_op->rmdir_async)
> +		error = DO_DIROP(dir, rmdir_async, dir, dentry);
> +	else
> +		error = dir->i_op->rmdir(dir, dentry);
>  	if (error)
>  		goto out;
>  
> @@ -4613,7 +4687,7 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		return error;
>  
> -	if (!dir->i_op->unlink)
> +	if (!dir->i_op->unlink && !dir->i_op->unlink_async)
>  		return -EPERM;
>  
>  	inode_lock(target);
> @@ -4627,7 +4701,10 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
>  			error = try_break_deleg(target, delegated_inode);
>  			if (error)
>  				goto out;
> -			error = dir->i_op->unlink(dir, dentry);
> +			if (dir->i_op->unlink_async)
> +				error = DO_DIROP(dir, unlink_async, dir, dentry);
> +			else
> +				error = dir->i_op->unlink(dir, dentry);
>  			if (!error) {
>  				dont_mount(dentry);
>  				detach_mounts(dentry);
> @@ -4761,14 +4838,17 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		return error;
>  
> -	if (!dir->i_op->symlink)
> +	if (!dir->i_op->symlink && !dir->i_op->symlink_async)
>  		return -EPERM;
>  
>  	error = security_inode_symlink(dir, dentry, oldname);
>  	if (error)
>  		return error;
>  
> -	error = dir->i_op->symlink(idmap, dir, dentry, oldname);
> +	if (dir->i_op->symlink_async)
> +		error = DO_DIROP(dir, symlink_async, idmap, dir, dentry, oldname);
> +	else
> +		error = dir->i_op->symlink(idmap, dir, dentry, oldname);
>  	if (!error)
>  		fsnotify_create(dir, dentry);
>  	return error;
> @@ -4874,7 +4954,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
>  	 */
>  	if (HAS_UNMAPPED_ID(idmap, inode))
>  		return -EPERM;
> -	if (!dir->i_op->link)
> +	if (!dir->i_op->link && !dir->i_op->link_async)
>  		return -EPERM;
>  	if (S_ISDIR(inode->i_mode))
>  		return -EPERM;
> @@ -4891,7 +4971,11 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
>  		error = -EMLINK;
>  	else {
>  		error = try_break_deleg(inode, delegated_inode);
> -		if (!error)
> +		if (error)
> +			;
> +		else if (dir->i_op->link_async)
> +			error = DO_DIROP(dir, link_async, old_dentry, dir, new_dentry);
> +		else
>  			error = dir->i_op->link(old_dentry, dir, new_dentry);
>  	}
>  
> @@ -5083,7 +5167,7 @@ int vfs_rename(struct renamedata *rd)
>  	if (error)
>  		return error;
>  
> -	if (!old_dir->i_op->rename)
> +	if (!old_dir->i_op->rename && !old_dir->i_op->rename_async)
>  		return -EPERM;
>  
>  	/*
> @@ -5166,8 +5250,14 @@ int vfs_rename(struct renamedata *rd)
>  		if (error)
>  			goto out;
>  	}
> -	error = old_dir->i_op->rename(rd->new_mnt_idmap, old_dir, old_dentry,
> -				      new_dir, new_dentry, flags);
> +	if (old_dir->i_op->rename_async)
> +		error = DO_DIROP(old_dir, rename_async, rd->new_mnt_idmap,
> +				 old_dir, old_dentry,
> +				 new_dir, new_dentry, flags);
> +	else
> +		error = old_dir->i_op->rename(rd->new_mnt_idmap,
> +					      old_dir, old_dentry,
> +					      new_dir, new_dentry, flags);
>  	if (error)
>  		goto out;
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f81d6bc65fe4..e414400c2487 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2187,6 +2187,14 @@ int wrap_directory_iterator(struct file *, struct dir_context *,
>  	static int shared_##x(struct file *file , struct dir_context *ctx) \
>  	{ return wrap_directory_iterator(file, ctx, x); }
>  
> +struct dirop_ret {
> +	union {
> +		int err;
> +		struct dentry *dentry;
> +	};
> +	void (*done_cb)(struct dirop_ret*);
> +};
> +
>  struct inode_operations {
>  	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
>  	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
> @@ -2197,17 +2205,30 @@ struct inode_operations {
>  
>  	int (*create) (struct mnt_idmap *, struct inode *,struct dentry *,
>  		       umode_t, bool);
> +	int (*create_async) (struct mnt_idmap *, struct inode *,struct dentry *,
> +		       umode_t, bool, struct dirop_ret *);
>  	int (*link) (struct dentry *,struct inode *,struct dentry *);
> +	int (*link_async) (struct dentry *,struct inode *,struct dentry *, struct dirop_ret *);
>  	int (*unlink) (struct inode *,struct dentry *);
> +	int (*unlink_async) (struct inode *,struct dentry *, struct dirop_ret *);
>  	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,
>  			const char *);
> +	int (*symlink_async) (struct mnt_idmap *, struct inode *,struct dentry *,
> +			const char *, struct dirop_ret *);
>  	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,
>  		      umode_t);
> +	struct dentry * (*mkdir_async) (struct mnt_idmap *, struct inode *,struct dentry *,
> +		      umode_t, struct dirop_ret *);
>  	int (*rmdir) (struct inode *,struct dentry *);
> +	int (*rmdir_async) (struct inode *,struct dentry *, struct dirop_ret *);
>  	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,
>  		      umode_t,dev_t);
> +	int (*mknod_async) (struct mnt_idmap *, struct inode *,struct dentry *,
> +		      umode_t,dev_t, struct dirop_ret *);
>  	int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
>  			struct inode *, struct dentry *, unsigned int);
> +	int (*rename_async) (struct mnt_idmap *, struct inode *, struct dentry *,
> +			struct inode *, struct dentry *, unsigned int, struct dirop_ret *);
>  	int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
>  	int (*getattr) (struct mnt_idmap *, const struct path *,
>  			struct kstat *, u32, unsigned int);
> @@ -2218,6 +2239,9 @@ struct inode_operations {
>  	int (*atomic_open)(struct inode *, struct dentry *,
>  			   struct file *, unsigned open_flag,
>  			   umode_t create_mode);
> +	int (*atomic_open_async)(struct inode *, struct dentry *,
> +			   struct file *, unsigned open_flag,
> +			   umode_t create_mode, struct dirop_ret *);
>  	int (*tmpfile) (struct mnt_idmap *, struct inode *,
>  			struct file *, umode_t);
>  	struct posix_acl *(*get_acl)(struct mnt_idmap *, struct dentry *,
> -- 
> 2.47.1
> 

