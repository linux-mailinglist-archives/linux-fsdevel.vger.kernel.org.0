Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6142934529A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 23:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhCVWw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 18:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhCVWvz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:51:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A191C61934;
        Mon, 22 Mar 2021 22:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616453514;
        bh=yVoEM8LaGuagHtZ7+mbGkmOdHq82G3SojkjBmnlu8to=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ucbc0tXct62/N5UleHxcuqtwafv0G71BN8MDIfu2u4KJ3OXbMVubJK4FEg+5q7Nc9
         xqxmOBeUC5Bxz1rxhRhVeOy3kOW6F/se4ZRKjcKI/NoAOZvpmEPvRAnEYR2oJjjF5A
         WLBgexYuJ1sZ4tJ9/kjf0MWLNYxgokoEmv3sW8oZ3tM/0+/dIW63Dlqmgad4tMpaMi
         bd/kjYlrYwzxNVW4Ksej/016TQtcUdr2pm4sDLpfnbnbvwwyS/Qlw3x7dFuEWKEl58
         GugsXxVkhVSfLAoSPrRSKcX9SBXs0DoSqX+G41ZxegA9664GWB54c/E46gXGSn4EbF
         45mz7vAdgZSyg==
Date:   Mon, 22 Mar 2021 15:51:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 18/18] vfs: remove unused ioctl helpers
Message-ID: <20210322225154.GF22094@magnolia>
References: <20210322144916.137245-1-mszeredi@redhat.com>
 <20210322144916.137245-19-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322144916.137245-19-mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:49:16PM +0100, Miklos Szeredi wrote:
> Remove vfs_ioc_setflags_prepare(), vfs_ioc_fssetxattr_check() and
> simple_fill_fsxattr(), which are no longer used.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Woo hoo, so much boilerplate goes away!

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/inode.c         | 87 ----------------------------------------------
>  include/linux/fs.h | 12 -------
>  2 files changed, 99 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index a047ab306f9a..ae526fd9c0a4 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -12,7 +12,6 @@
>  #include <linux/security.h>
>  #include <linux/cdev.h>
>  #include <linux/memblock.h>
> -#include <linux/fscrypt.h>
>  #include <linux/fsnotify.h>
>  #include <linux/mount.h>
>  #include <linux/posix_acl.h>
> @@ -2314,89 +2313,3 @@ struct timespec64 current_time(struct inode *inode)
>  	return timestamp_truncate(now, inode);
>  }
>  EXPORT_SYMBOL(current_time);
> -
> -/*
> - * Generic function to check FS_IOC_SETFLAGS values and reject any invalid
> - * configurations.
> - *
> - * Note: the caller should be holding i_mutex, or else be sure that they have
> - * exclusive access to the inode structure.
> - */
> -int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
> -			     unsigned int flags)
> -{
> -	/*
> -	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
> -	 * the relevant capability.
> -	 *
> -	 * This test looks nicer. Thanks to Pauline Middelink
> -	 */
> -	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
> -	    !capable(CAP_LINUX_IMMUTABLE))
> -		return -EPERM;
> -
> -	return fscrypt_prepare_setflags(inode, oldflags, flags);
> -}
> -EXPORT_SYMBOL(vfs_ioc_setflags_prepare);
> -
> -/*
> - * Generic function to check FS_IOC_FSSETXATTR values and reject any invalid
> - * configurations.
> - *
> - * Note: the caller should be holding i_mutex, or else be sure that they have
> - * exclusive access to the inode structure.
> - */
> -int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
> -			     struct fsxattr *fa)
> -{
> -	/*
> -	 * Can't modify an immutable/append-only file unless we have
> -	 * appropriate permission.
> -	 */
> -	if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
> -			(FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND) &&
> -	    !capable(CAP_LINUX_IMMUTABLE))
> -		return -EPERM;
> -
> -	/*
> -	 * Project Quota ID state is only allowed to change from within the init
> -	 * namespace. Enforce that restriction only if we are trying to change
> -	 * the quota ID state. Everything else is allowed in user namespaces.
> -	 */
> -	if (current_user_ns() != &init_user_ns) {
> -		if (old_fa->fsx_projid != fa->fsx_projid)
> -			return -EINVAL;
> -		if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
> -				FS_XFLAG_PROJINHERIT)
> -			return -EINVAL;
> -	}
> -
> -	/* Check extent size hints. */
> -	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
> -		return -EINVAL;
> -
> -	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
> -			!S_ISDIR(inode->i_mode))
> -		return -EINVAL;
> -
> -	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
> -	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> -		return -EINVAL;
> -
> -	/*
> -	 * It is only valid to set the DAX flag on regular files and
> -	 * directories on filesystems.
> -	 */
> -	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
> -	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
> -		return -EINVAL;
> -
> -	/* Extent size hints of zero turn off the flags. */
> -	if (fa->fsx_extsize == 0)
> -		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
> -	if (fa->fsx_cowextsize == 0)
> -		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(vfs_ioc_fssetxattr_check);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9e7f6a592a70..1e88ace15004 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3571,18 +3571,6 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
>  extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
>  			   int advice);
>  
> -int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
> -			     unsigned int flags);
> -
> -int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
> -			     struct fsxattr *fa);
> -
> -static inline void simple_fill_fsxattr(struct fsxattr *fa, __u32 xflags)
> -{
> -	memset(fa, 0, sizeof(*fa));
> -	fa->fsx_xflags = xflags;
> -}
> -
>  /*
>   * Flush file data before changing attributes.  Caller must hold any locks
>   * required to prevent further writes to this file until we're done setting
> -- 
> 2.30.2
> 
