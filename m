Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC85D4CF1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 15:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFTNlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 09:41:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:44940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbfFTNlW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:41:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 551A4AEF8;
        Thu, 20 Jun 2019 13:41:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ADFD51E434F; Thu, 20 Jun 2019 15:41:18 +0200 (CEST)
Date:   Thu, 20 Jun 2019 15:41:18 +0200
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
Subject: Re: [PATCH 3/4] fs: teach vfs_ioc_fssetxattr_check to check project
 id info
Message-ID: <20190620134118.GF30243@quack2.suse.cz>
References: <156022833285.3227089.11990489625041926920.stgit@magnolia>
 <156022835712.3227089.13380623784109583024.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156022835712.3227089.13380623784109583024.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 10-06-19 21:45:57, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Standardize the project id checks for FSSETXATTR.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ioctl.c    |   27 ---------------------------
>  fs/f2fs/file.c     |   27 ---------------------------
>  fs/inode.c         |   13 +++++++++++++
>  fs/xfs/xfs_ioctl.c |   15 ---------------
>  4 files changed, 13 insertions(+), 69 deletions(-)
> 
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index c2f48c90ca45..6aa1df1918f7 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -697,30 +697,6 @@ static long ext4_ioctl_group_add(struct file *file,
>  	return err;
>  }
>  
> -static int ext4_ioctl_check_project(struct inode *inode, struct fsxattr *fa)
> -{
> -	/*
> -	 * Project Quota ID state is only allowed to change from within the init
> -	 * namespace. Enforce that restriction only if we are trying to change
> -	 * the quota ID state. Everything else is allowed in user namespaces.
> -	 */
> -	if (current_user_ns() == &init_user_ns)
> -		return 0;
> -
> -	if (__kprojid_val(EXT4_I(inode)->i_projid) != fa->fsx_projid)
> -		return -EINVAL;
> -
> -	if (ext4_test_inode_flag(inode, EXT4_INODE_PROJINHERIT)) {
> -		if (!(fa->fsx_xflags & FS_XFLAG_PROJINHERIT))
> -			return -EINVAL;
> -	} else {
> -		if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
> -			return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>  static void ext4_fsgetxattr(struct inode *inode, struct fsxattr *fa)
>  {
>  	struct ext4_inode_info *ei = EXT4_I(inode);
> @@ -1135,9 +1111,6 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  
>  		inode_lock(inode);
>  		ext4_fsgetxattr(inode, &old_fa);
> -		err = ext4_ioctl_check_project(inode, &fa);
> -		if (err)
> -			goto out;
>  		err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
>  		if (err)
>  			goto out;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f707de6bd4a8..183ed1ac60e1 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2799,30 +2799,6 @@ static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
>  	return 0;
>  }
>  
> -static int f2fs_ioctl_check_project(struct inode *inode, struct fsxattr *fa)
> -{
> -	/*
> -	 * Project Quota ID state is only allowed to change from within the init
> -	 * namespace. Enforce that restriction only if we are trying to change
> -	 * the quota ID state. Everything else is allowed in user namespaces.
> -	 */
> -	if (current_user_ns() == &init_user_ns)
> -		return 0;
> -
> -	if (__kprojid_val(F2FS_I(inode)->i_projid) != fa->fsx_projid)
> -		return -EINVAL;
> -
> -	if (F2FS_I(inode)->i_flags & F2FS_PROJINHERIT_FL) {
> -		if (!(fa->fsx_xflags & FS_XFLAG_PROJINHERIT))
> -			return -EINVAL;
> -	} else {
> -		if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
> -			return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>  static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
> @@ -2850,9 +2826,6 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
>  		return err;
>  
>  	inode_lock(inode);
> -	err = f2fs_ioctl_check_project(inode, &fa);
> -	if (err)
> -		goto out;
>  
>  	__f2fs_ioc_fsgetxattr(inode, &old_fa);
>  	err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
> diff --git a/fs/inode.c b/fs/inode.c
> index 026955258a47..40ecd3a6a188 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2201,6 +2201,19 @@ int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
>  	    !capable(CAP_LINUX_IMMUTABLE))
>  		return -EPERM;
>  
> +	/*
> +	 * Project Quota ID state is only allowed to change from within the init
> +	 * namespace. Enforce that restriction only if we are trying to change
> +	 * the quota ID state. Everything else is allowed in user namespaces.
> +	 */
> +	if (current_user_ns() != &init_user_ns) {
> +		if (old_fa->fsx_projid != fa->fsx_projid)
> +			return -EINVAL;
> +		if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
> +				FS_XFLAG_PROJINHERIT)
> +			return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(vfs_ioc_fssetxattr_check);
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 08c24f2f55c3..82961de98900 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1299,21 +1299,6 @@ xfs_ioctl_setattr_check_projid(
>  	if (fa->fsx_projid > (uint16_t)-1 &&
>  	    !xfs_sb_version_hasprojid32bit(&ip->i_mount->m_sb))
>  		return -EINVAL;
> -
> -	/*
> -	 * Project Quota ID state is only allowed to change from within the init
> -	 * namespace. Enforce that restriction only if we are trying to change
> -	 * the quota ID state. Everything else is allowed in user namespaces.
> -	 */
> -	if (current_user_ns() == &init_user_ns)
> -		return 0;
> -
> -	if (xfs_get_projid(ip) != fa->fsx_projid)
> -		return -EINVAL;
> -	if ((fa->fsx_xflags & FS_XFLAG_PROJINHERIT) !=
> -	    (ip->i_d.di_flags & XFS_DIFLAG_PROJINHERIT))
> -		return -EINVAL;
> -
>  	return 0;
>  }
>  
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
