Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D8334738C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 09:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhCXIVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 04:21:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34707 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbhCXIVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:21:09 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOylI-0005kT-3r; Wed, 24 Mar 2021 08:21:08 +0000
Date:   Wed, 24 Mar 2021 09:21:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 01/18] vfs: add miscattr ops
Message-ID: <20210324082107.m5bz6rp2bkz7qont@wittgenstein>
References: <20210322144916.137245-1-mszeredi@redhat.com>
 <20210322144916.137245-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322144916.137245-2-mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:48:59PM +0100, Miklos Szeredi wrote:
> There's a substantial amount of boilerplate in filesystems handling
> FS_IOC_[GS]ETFLAGS/ FS_IOC_FS[GS]ETXATTR ioctls.
> 
> Also due to userspace buffers being involved in the ioctl API this is
> difficult to stack, as shown by overlayfs issues related to these ioctls.
> 
> Introduce a new internal API named "miscattr" (fsxattr can be confused with
> xattr, xflags is inappropriate, since this is more than just flags).
> 
> There's significant overlap between flags and xflags and this API handles
> the conversions automatically, so filesystems may choose which one to use.
> 
> In ->miscattr_get() a hint is provided to the filesystem whether flags or
> xattr are being requested by userspace, but in this series this hint is
> ignored by all filesystems, since generating all the attributes is cheap.
> 
> If a filesystem doesn't implemement the miscattr API, just fall back to
> f_op->ioctl().  When all filesystems are converted, the fallback can be
> removed.
> 
> 32bit compat ioctls are now handled by the generic code as well.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Fwiw, I think this is a good cleanup. Changing something like the
miscattr_set() method to take a mnt_userns would've been less
churn then having to audit all ioctls individually.

(Only one small comment below.)

>  Documentation/filesystems/locking.rst |   5 +
>  Documentation/filesystems/vfs.rst     |  15 ++
>  fs/ioctl.c                            | 329 ++++++++++++++++++++++++++
>  include/linux/fs.h                    |   4 +
>  include/linux/miscattr.h              |  53 +++++
>  5 files changed, 406 insertions(+)
>  create mode 100644 include/linux/miscattr.h
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index b7dcc86c92a4..a5aa2046d48f 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -80,6 +80,9 @@ prototypes::
>  				struct file *, unsigned open_flag,
>  				umode_t create_mode);
>  	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
> +	int (*miscattr_set)(struct user_namespace *mnt_userns,
> +			    struct dentry *dentry, struct miscattr *ma);
> +	int (*miscattr_get)(struct dentry *dentry, struct miscattr *ma);
>  
>  locking rules:
>  	all may block
> @@ -107,6 +110,8 @@ fiemap:		no
>  update_time:	no
>  atomic_open:	shared (exclusive if O_CREAT is set in open flags)
>  tmpfile:	no
> +miscattr_get:	no or exclusive
> +miscattr_set:	exclusive
>  ============	=============================================
>  
>  
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 2049bbf5e388..f125ce6c3b47 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -441,6 +441,9 @@ As of kernel 2.6.22, the following members are defined:
>  				   unsigned open_flag, umode_t create_mode);
>  		int (*tmpfile) (struct user_namespace *, struct inode *, struct dentry *, umode_t);
>  	        int (*set_acl)(struct user_namespace *, struct inode *, struct posix_acl *, int);
> +		int (*miscattr_set)(struct user_namespace *mnt_userns,
> +				    struct dentry *dentry, struct miscattr *ma);
> +		int (*miscattr_get)(struct dentry *dentry, struct miscattr *ma);
>  	};
>  
>  Again, all methods are called without any locks being held, unless
> @@ -588,6 +591,18 @@ otherwise noted.
>  	atomically creating, opening and unlinking a file in given
>  	directory.
>  
> +``miscattr_get``
> +	called on ioctl(FS_IOC_GETFLAGS) and ioctl(FS_IOC_FSGETXATTR) to
> +	retrieve miscellaneous filesystem flags and attributes.  Also
> +	called before the relevant SET operation to check what is being
> +	changed (in this case with i_rwsem locked exclusive).  If unset,
> +	then fall back to f_op->ioctl().
> +
> +``miscattr_set``
> +	called on ioctl(FS_IOC_SETFLAGS) and ioctl(FS_IOC_FSSETXATTR) to
> +	change miscellaneous filesystem flags and attributes.  Callers hold
> +	i_rwsem exclusive.  If unset, then fall back to f_op->ioctl().
> +
>  
>  The Address Space Object
>  ========================
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 4e6cc0a7d69c..e5f3820809a4 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -19,6 +19,9 @@
>  #include <linux/falloc.h>
>  #include <linux/sched/signal.h>
>  #include <linux/fiemap.h>
> +#include <linux/mount.h>
> +#include <linux/fscrypt.h>
> +#include <linux/miscattr.h>
>  
>  #include "internal.h"
>  
> @@ -657,6 +660,311 @@ static int ioctl_file_dedupe_range(struct file *file,
>  	return ret;
>  }
>  
> +/**
> + * miscattr_fill_xflags - initialize miscattr with xflags
> + * @ma:		miscattr pointer
> + * @xflags:	FS_XFLAG_* flags
> + *
> + * Set ->fsx_xflags, ->xattr_valid and ->flags (translated xflags).  All
> + * other fields are zeroed.
> + */
> +void miscattr_fill_xflags(struct miscattr *ma, u32 xflags)
> +{
> +	memset(ma, 0, sizeof(*ma));
> +	ma->xattr_valid = true;
> +	ma->fsx_xflags = xflags;
> +	if (ma->fsx_xflags & FS_XFLAG_IMMUTABLE)
> +		ma->flags |= FS_IMMUTABLE_FL;
> +	if (ma->fsx_xflags & FS_XFLAG_APPEND)
> +		ma->flags |= FS_APPEND_FL;
> +	if (ma->fsx_xflags & FS_XFLAG_SYNC)
> +		ma->flags |= FS_SYNC_FL;
> +	if (ma->fsx_xflags & FS_XFLAG_NOATIME)
> +		ma->flags |= FS_NOATIME_FL;
> +	if (ma->fsx_xflags & FS_XFLAG_NODUMP)
> +		ma->flags |= FS_NODUMP_FL;
> +	if (ma->fsx_xflags & FS_XFLAG_DAX)
> +		ma->flags |= FS_DAX_FL;
> +	if (ma->fsx_xflags & FS_XFLAG_PROJINHERIT)
> +		ma->flags |= FS_PROJINHERIT_FL;
> +}
> +EXPORT_SYMBOL(miscattr_fill_xflags);
> +
> +/**
> + * miscattr_fill_flags - initialize miscattr with flags
> + * @ma:		miscattr pointer
> + * @flags:	FS_*_FL flags
> + *
> + * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
> + * All other fields are zeroed.
> + */
> +void miscattr_fill_flags(struct miscattr *ma, u32 flags)
> +{
> +	memset(ma, 0, sizeof(*ma));
> +	ma->flags_valid = true;
> +	ma->flags = flags;
> +	if (ma->flags & FS_SYNC_FL)
> +		ma->fsx_xflags |= FS_XFLAG_SYNC;
> +	if (ma->flags & FS_IMMUTABLE_FL)
> +		ma->fsx_xflags |= FS_XFLAG_IMMUTABLE;
> +	if (ma->flags & FS_APPEND_FL)
> +		ma->fsx_xflags |= FS_XFLAG_APPEND;
> +	if (ma->flags & FS_NODUMP_FL)
> +		ma->fsx_xflags |= FS_XFLAG_NODUMP;
> +	if (ma->flags & FS_NOATIME_FL)
> +		ma->fsx_xflags |= FS_XFLAG_NOATIME;
> +	if (ma->flags & FS_DAX_FL)
> +		ma->fsx_xflags |= FS_XFLAG_DAX;
> +	if (ma->flags & FS_PROJINHERIT_FL)
> +		ma->fsx_xflags |= FS_XFLAG_PROJINHERIT;
> +}
> +EXPORT_SYMBOL(miscattr_fill_flags);
> +
> +/**
> + * vfs_miscattr_get - retrieve miscellaneous inode attributes
> + * @dentry:	the object to retrieve from
> + * @ma:		miscattr pointer
> + *
> + * Call i_op->miscattr_get() callback, if exists.
> + *
> + * Returns 0 on success, or a negative error on failure.
> + */
> +int vfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
> +{
> +	struct inode *inode = d_inode(dentry);
> +
> +	if (d_is_special(dentry))
> +		return -ENOTTY;
> +
> +	if (!inode->i_op->miscattr_get)
> +		return -ENOIOCTLCMD;
> +
> +	return inode->i_op->miscattr_get(dentry, ma);
> +}
> +EXPORT_SYMBOL(vfs_miscattr_get);
> +
> +/**
> + * fsxattr_copy_to_user - copy fsxattr to userspace.
> + * @ma:		miscattr pointer
> + * @ufa:	fsxattr user pointer
> + *
> + * Returns 0 on success, or -EFAULT on failure.
> + */
> +int fsxattr_copy_to_user(const struct miscattr *ma, struct fsxattr __user *ufa)
> +{
> +	struct fsxattr fa = {
> +		.fsx_xflags	= ma->fsx_xflags,
> +		.fsx_extsize	= ma->fsx_extsize,
> +		.fsx_nextents	= ma->fsx_nextents,
> +		.fsx_projid	= ma->fsx_projid,
> +		.fsx_cowextsize	= ma->fsx_cowextsize,
> +	};
> +
> +	if (copy_to_user(ufa, &fa, sizeof(fa)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(fsxattr_copy_to_user);
> +
> +static int fsxattr_copy_from_user(struct miscattr *ma,
> +				  struct fsxattr __user *ufa)
> +{
> +	struct fsxattr fa;
> +
> +	if (copy_from_user(&fa, ufa, sizeof(fa)))
> +		return -EFAULT;
> +
> +	miscattr_fill_xflags(ma, fa.fsx_xflags);
> +	ma->fsx_extsize = fa.fsx_extsize;
> +	ma->fsx_nextents = fa.fsx_nextents;
> +	ma->fsx_projid = fa.fsx_projid;
> +	ma->fsx_cowextsize = fa.fsx_cowextsize;
> +
> +	return 0;
> +}
> +
> +/*
> + * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
> + * any invalid configurations.
> + *
> + * Note: must be called with inode lock held.
> + */
> +static int miscattr_set_prepare(struct inode *inode,
> +			      const struct miscattr *old_ma,
> +			      struct miscattr *ma)
> +{
> +	int err;
> +
> +	/*
> +	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
> +	 * the relevant capability.
> +	 */
> +	if ((ma->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
> +	    !capable(CAP_LINUX_IMMUTABLE))
> +		return -EPERM;
> +
> +	err = fscrypt_prepare_setflags(inode, old_ma->flags, ma->flags);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Project Quota ID state is only allowed to change from within the init
> +	 * namespace. Enforce that restriction only if we are trying to change
> +	 * the quota ID state. Everything else is allowed in user namespaces.
> +	 */
> +	if (current_user_ns() != &init_user_ns) {
> +		if (old_ma->fsx_projid != ma->fsx_projid)
> +			return -EINVAL;
> +		if ((old_ma->fsx_xflags ^ ma->fsx_xflags) &
> +				FS_XFLAG_PROJINHERIT)
> +			return -EINVAL;
> +	}
> +
> +	/* Check extent size hints. */
> +	if ((ma->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
> +		return -EINVAL;
> +
> +	if ((ma->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
> +			!S_ISDIR(inode->i_mode))
> +		return -EINVAL;
> +
> +	if ((ma->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
> +	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> +		return -EINVAL;
> +
> +	/*
> +	 * It is only valid to set the DAX flag on regular files and
> +	 * directories on filesystems.
> +	 */
> +	if ((ma->fsx_xflags & FS_XFLAG_DAX) &&
> +	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
> +		return -EINVAL;
> +
> +	/* Extent size hints of zero turn off the flags. */
> +	if (ma->fsx_extsize == 0)
> +		ma->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
> +	if (ma->fsx_cowextsize == 0)
> +		ma->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> +
> +	return 0;
> +}
> +
> +/**
> + * vfs_miscattr_set - change miscellaneous inode attributes

I think this misses to document the @mnt_userns argument probably just
caused by the rebase.

> + * @dentry:	the object to change
> + * @ma:		miscattr pointer

> + *
> + * After verifying permissions, call i_op->miscattr_set() callback, if
> + * exists.
> + *
> + * Verifying attributes involves retrieving current attributes with
> + * i_op->miscattr_get(), this also allows initilaizing attributes that have
> + * not been set by the caller to current values.  Inode lock is held
> + * thoughout to prevent racing with another instance.
> + *
> + * Returns 0 on success, or a negative error on failure.

Fwiw, just because Willy made me aware of this, adding a ":" after the
Return will make kernel-doc generate a separate return value section. It
might also complain otherwise.

Christian

> + */
> +int vfs_miscattr_set(struct user_namespace *mnt_userns, struct dentry *dentry,
> +		     struct miscattr *ma)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct miscattr old_ma = {};
> +	int err;
> +
> +	if (d_is_special(dentry))
> +		return -ENOTTY;
> +
> +	if (!inode->i_op->miscattr_set)
> +		return -ENOIOCTLCMD;
> +
> +	if (!inode_owner_or_capable(mnt_userns, inode))
> +		return -EPERM;
> +
> +	inode_lock(inode);
> +	err = vfs_miscattr_get(dentry, &old_ma);
> +	if (!err) {
> +		/* initialize missing bits from old_ma */
> +		if (ma->flags_valid) {
> +			ma->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
> +			ma->fsx_extsize = old_ma.fsx_extsize;
> +			ma->fsx_nextents = old_ma.fsx_nextents;
> +			ma->fsx_projid = old_ma.fsx_projid;
> +			ma->fsx_cowextsize = old_ma.fsx_cowextsize;
> +		} else {
> +			ma->flags |= old_ma.flags & ~FS_COMMON_FL;
> +		}
> +		err = miscattr_set_prepare(inode, &old_ma, ma);
> +		if (!err)
> +			err = inode->i_op->miscattr_set(mnt_userns, dentry, ma);
> +	}
> +	inode_unlock(inode);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(vfs_miscattr_set);
