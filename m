Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A7B30DDCC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 16:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhBCPOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 10:14:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:40704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233983AbhBCPFe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:05:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3CB7AC6E;
        Wed,  3 Feb 2021 15:04:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 02A751E14B6; Wed,  3 Feb 2021 16:04:48 +0100 (CET)
Date:   Wed, 3 Feb 2021 16:04:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH 01/18] vfs: add miscattr ops
Message-ID: <20210203150448.GD7094@quack2.suse.cz>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
 <20210203124112.1182614-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203124112.1182614-2-mszeredi@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos!

On Wed 03-02-21 13:40:55, Miklos Szeredi wrote:
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

Getting rid of the boilerplate code and improving stacking of these calls
look like a nice goal to me :) Some technical comments below.

> +/**
> + * miscattr_fill_xflags - initialize miscattr with xflags
> + * @ma:		miscattr pointer
> + * @xflags:	FS_XFLAG_* flags
> + *
> + * Set ->fsx_xflags, ->xattr_valid and ->flags (translated xflags).  All
> + * other fields are zeroed.
> + */
> +void miscattr_fill_xflags(struct miscattr *ma, u32 xflags)

Maybe call this miscattr_fill_from_xflags() and the next function
miscattr_fill_from_flags()? At least to me it would be clearer when I want
to use which function just by looking at the name...

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
> +	memset(ma, 0, sizeof(*ma));

So here we clear whole 'ma' but callers already set e.g. xattr_valid field
and cleared the 'ma' as well which just looks silly...

> +	return inode->i_op->miscattr_get(dentry, ma);
> +}
> +EXPORT_SYMBOL(vfs_miscattr_get);

...

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
> + */
> +int vfs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
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
> +	if (!inode_owner_or_capable(inode))
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
> +			err = inode->i_op->miscattr_set(dentry, ma);

So I somewhat wonder here - not all filesystems support all the xflags or
other extended attributes. Currently these would be just silently ignored
AFAICT. Which seems a bit dangerous to me - most notably because it makes
future extensions of these filesystems difficult. So how are we going to go
about this? Is every filesystem supposed to check what it supports and
refuse other stuff (but currently e.g. your ext2 conversion patch doesn't do
that AFAICT)? Shouldn't we make things easier for filesystems to provide a
bitmask of changing fields (instead of flags / xflags bools) so that they
can refuse unsupported stuff with a single mask check?

To make things more complex, ext2/4 has traditionally silently cleared
unknown flags for setflags but not for setxflags. Unlike e.g. XFS which
refuses unknown flags.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
