Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505564CF50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 15:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfFTNql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 09:46:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:45856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbfFTNqk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:46:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CAA66AE2C;
        Thu, 20 Jun 2019 13:46:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 504A11E434F; Thu, 20 Jun 2019 15:46:37 +0200 (CEST)
Date:   Thu, 20 Jun 2019 15:46:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        shaggy@kernel.org, ard.biesheuvel@linaro.org, josef@toxicpanda.com,
        clm@fb.com, adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] vfs: teach vfs_ioc_fssetxattr_check to check extent
 size hints
Message-ID: <20190620134637.GG30243@quack2.suse.cz>
References: <156022833285.3227089.11990489625041926920.stgit@magnolia>
 <156022836522.3227089.4353401791178719941.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156022836522.3227089.4353401791178719941.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 10-06-19 21:46:05, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Move the extent size hint checks that aren't xfs-specific to the vfs.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c         |   18 +++++++++++++
>  fs/xfs/xfs_ioctl.c |   70 ++++++++++++++++++++++------------------------------
>  2 files changed, 47 insertions(+), 41 deletions(-)
> 
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 40ecd3a6a188..a3757051fd55 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2214,6 +2214,24 @@ int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
>  			return -EINVAL;
>  	}
>  
> +	/* Check extent size hints. */
> +	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
> +		return -EINVAL;
> +
> +	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
> +			!S_ISDIR(inode->i_mode))
> +		return -EINVAL;
> +
> +	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
> +	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> +		return -EINVAL;
> +
> +	/* Extent size hints of zero turn off the flags. */
> +	if (fa->fsx_extsize == 0)
> +		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
> +	if (fa->fsx_cowextsize == 0)
> +		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(vfs_ioc_fssetxattr_check);
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 82961de98900..b494e7e881e3 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1201,39 +1201,31 @@ xfs_ioctl_setattr_check_extsize(
>  	struct fsxattr		*fa)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
> -
> -	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(VFS_I(ip)->i_mode))
> -		return -EINVAL;
> -
> -	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
> -	    !S_ISDIR(VFS_I(ip)->i_mode))
> -		return -EINVAL;
> +	xfs_extlen_t		size;
> +	xfs_fsblock_t		extsize_fsb;
>  
>  	if (S_ISREG(VFS_I(ip)->i_mode) && ip->i_d.di_nextents &&
>  	    ((ip->i_d.di_extsize << mp->m_sb.sb_blocklog) != fa->fsx_extsize))
>  		return -EINVAL;
>  
> -	if (fa->fsx_extsize != 0) {
> -		xfs_extlen_t    size;
> -		xfs_fsblock_t   extsize_fsb;
> -
> -		extsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_extsize);
> -		if (extsize_fsb > MAXEXTLEN)
> -			return -EINVAL;
> +	if (fa->fsx_extsize == 0)
> +		return 0;
>  
> -		if (XFS_IS_REALTIME_INODE(ip) ||
> -		    (fa->fsx_xflags & FS_XFLAG_REALTIME)) {
> -			size = mp->m_sb.sb_rextsize << mp->m_sb.sb_blocklog;
> -		} else {
> -			size = mp->m_sb.sb_blocksize;
> -			if (extsize_fsb > mp->m_sb.sb_agblocks / 2)
> -				return -EINVAL;
> -		}
> +	extsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_extsize);
> +	if (extsize_fsb > MAXEXTLEN)
> +		return -EINVAL;
>  
> -		if (fa->fsx_extsize % size)
> +	if (XFS_IS_REALTIME_INODE(ip) ||
> +	    (fa->fsx_xflags & FS_XFLAG_REALTIME)) {
> +		size = mp->m_sb.sb_rextsize << mp->m_sb.sb_blocklog;
> +	} else {
> +		size = mp->m_sb.sb_blocksize;
> +		if (extsize_fsb > mp->m_sb.sb_agblocks / 2)
>  			return -EINVAL;
> -	} else
> -		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
> +	}
> +
> +	if (fa->fsx_extsize % size)
> +		return -EINVAL;
>  
>  	return 0;
>  }
> @@ -1259,6 +1251,8 @@ xfs_ioctl_setattr_check_cowextsize(
>  	struct fsxattr		*fa)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
> +	xfs_extlen_t		size;
> +	xfs_fsblock_t		cowextsize_fsb;
>  
>  	if (!(fa->fsx_xflags & FS_XFLAG_COWEXTSIZE))
>  		return 0;
> @@ -1267,25 +1261,19 @@ xfs_ioctl_setattr_check_cowextsize(
>  	    ip->i_d.di_version != 3)
>  		return -EINVAL;
>  
> -	if (!S_ISREG(VFS_I(ip)->i_mode) && !S_ISDIR(VFS_I(ip)->i_mode))
> -		return -EINVAL;
> -
> -	if (fa->fsx_cowextsize != 0) {
> -		xfs_extlen_t    size;
> -		xfs_fsblock_t   cowextsize_fsb;
> +	if (fa->fsx_cowextsize == 0)
> +		return 0;
>  
> -		cowextsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_cowextsize);
> -		if (cowextsize_fsb > MAXEXTLEN)
> -			return -EINVAL;
> +	cowextsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_cowextsize);
> +	if (cowextsize_fsb > MAXEXTLEN)
> +		return -EINVAL;
>  
> -		size = mp->m_sb.sb_blocksize;
> -		if (cowextsize_fsb > mp->m_sb.sb_agblocks / 2)
> -			return -EINVAL;
> +	size = mp->m_sb.sb_blocksize;
> +	if (cowextsize_fsb > mp->m_sb.sb_agblocks / 2)
> +		return -EINVAL;
>  
> -		if (fa->fsx_cowextsize % size)
> -			return -EINVAL;
> -	} else
> -		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> +	if (fa->fsx_cowextsize % size)
> +		return -EINVAL;
>  
>  	return 0;
>  }
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
