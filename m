Return-Path: <linux-fsdevel+bounces-13108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0076D86B431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 17:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5981F2C048
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827BD15D5D1;
	Wed, 28 Feb 2024 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMUjyMjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD71015B98B;
	Wed, 28 Feb 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136530; cv=none; b=RC4F5qnHUGULILtRWv/CeLMxVoS1ydrdM/gcLqwKbvmx5MTZma1sjd1e2h8N5R9HsCUlkp3Lhhl0Bgj+9H4HyJiouI+dza5hgYPTUPELo5cClzT/GIvIPbTrb8h54vcqf9J3CnfqtRB0DNqsExfFs+7nxAlwX58hwjMHld9nDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136530; c=relaxed/simple;
	bh=UUR5O/tTBUC3FaIt6kvDQy2doFjzYWlQUtOdknsZ3Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3Yyp6z/tSfNPA05Mnd/9C4jcgGkABdO0FZry4xEEA3Al55buDHF0YYObznK7HU8as3LibouYbwsc6Lc7rBie9lBfhWiRfhcUVwLoM9rgJKk6e/fpcZMVe61i/R+VFub8u8qZ41jV+VQzTcCk2iYkWS479qKH+LKAiFMf66o3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMUjyMjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B62C433C7;
	Wed, 28 Feb 2024 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709136529;
	bh=UUR5O/tTBUC3FaIt6kvDQy2doFjzYWlQUtOdknsZ3Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMUjyMjKLhg1ceGo393w+fwOmRYwutRP8+Y0J3IFRXGiitYEsrn6accAF8CRoao1l
	 wZ5uRJKwjz3Kpg1HGN/FIctss4WyyHQPHO/tl5dwDo1Ppv3BSH5kP+5ApF0rcuW+PB
	 9+vTE2KrarSs67aRSMeqGc9VyTrDcquQmppxTUC2xCnni5N8nSb7YAGn68sdSJ+pu/
	 xWkaVQZC1K2GP7HF0sWBFgbIVzZQ7tY2LBh8UbJelr3TyKhvJgnd2qsE7rBq4YFBh3
	 69owrOEvC5npbRvohLmaavZLym2Fbhw3HK05tQ/E4QHUdmDRBGjugxtHxx4YmJUyty
	 RzIxM0ROS5N8g==
Date: Wed, 28 Feb 2024 08:08:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs: stop advertising SB_I_VERSION
Message-ID: <20240228160848.GF1927156@frogsfrogsfrogs>
References: <20240228042859.841623-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228042859.841623-1-david@fromorbit.com>

On Wed, Feb 28, 2024 at 03:28:59PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The redefinition of how NFS wants inode->i_version to be updated is
> incomaptible with the XFS i_version mechanism. The VFS now wants
> inode->i_version to only change when ctime changes (i.e. it has
> become a ctime change counter, not an inode change counter). XFS has
> fine grained timestamps, so it can just use ctime for the NFS change
> cookie like it still does for V4 XFS filesystems.
> 
> We still want XFS to update the inode change counter as it currently
> does, so convert all the code that checks SB_I_VERSION to check for
> v5 format support. Then we can remove the SB_I_VERSION flag from the
> VFS superblock to indicate that inode->i_version is not a valid
> change counter and should not be used as such.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Seeing as NFS and XFS' definition of i_version have diverged, I suppose
divorce is the only option.  But please, let's get rid of all the
*iversion() calls in the codebase.

With my paranoia hat on: let's add an i_changecounter to xfs_inode and
completely stop using the inode.i_version to prevent the vfs from
messing with us.

At some point we can rev the ondisk format to add a new field so that
"di_version" can be whatever u64 cookie the vfs passes us through
i_version.

--D

> ---
>  fs/xfs/libxfs/xfs_trans_inode.c | 15 +++++----------
>  fs/xfs/xfs_iops.c               | 16 +++-------------
>  fs/xfs/xfs_super.c              |  8 --------
>  3 files changed, 8 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> index 70e97ea6eee7..8071aefad728 100644
> --- a/fs/xfs/libxfs/xfs_trans_inode.c
> +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> @@ -97,17 +97,12 @@ xfs_trans_log_inode(
>  
>  	/*
>  	 * First time we log the inode in a transaction, bump the inode change
> -	 * counter if it is configured for this to occur. While we have the
> -	 * inode locked exclusively for metadata modification, we can usually
> -	 * avoid setting XFS_ILOG_CORE if no one has queried the value since
> -	 * the last time it was incremented. If we have XFS_ILOG_CORE already
> -	 * set however, then go ahead and bump the i_version counter
> -	 * unconditionally.
> +	 * counter if it is configured for this to occur.
>  	 */
> -	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
> -		if (IS_I_VERSION(inode) &&
> -		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
> -			flags |= XFS_ILOG_IVERSION;
> +	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags) &&
> +	    xfs_has_crc(ip->i_mount)) {
> +		inode->i_version++;
> +		flags |= XFS_ILOG_IVERSION;
>  	}
>  
>  	iip->ili_dirty_flags |= flags;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index be102fd49560..97e792d9d79a 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -584,11 +584,6 @@ xfs_vn_getattr(
>  		}
>  	}
>  
> -	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> -		stat->change_cookie = inode_query_iversion(inode);
> -		stat->result_mask |= STATX_CHANGE_COOKIE;
> -	}
> -
>  	/*
>  	 * Note: If you add another clause to set an attribute flag, please
>  	 * update attributes_mask below.
> @@ -1044,16 +1039,11 @@ xfs_vn_update_time(
>  	struct timespec64	now;
>  
>  	trace_xfs_update_time(ip);
> +	ASSERT(!(flags & S_VERSION));
>  
>  	if (inode->i_sb->s_flags & SB_LAZYTIME) {
> -		if (!((flags & S_VERSION) &&
> -		      inode_maybe_inc_iversion(inode, false))) {
> -			generic_update_time(inode, flags);
> -			return 0;
> -		}
> -
> -		/* Capture the iversion update that just occurred */
> -		log_flags |= XFS_ILOG_CORE;
> +		generic_update_time(inode, flags);
> +		return 0;
>  	}
>  
>  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 6ce1e6deb7ec..657ce0423f1d 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1692,10 +1692,6 @@ xfs_fs_fill_super(
>  
>  	set_posix_acl_flag(sb);
>  
> -	/* version 5 superblocks support inode version counters. */
> -	if (xfs_has_crc(mp))
> -		sb->s_flags |= SB_I_VERSION;
> -
>  	if (xfs_has_dax_always(mp)) {
>  		error = xfs_setup_dax_always(mp);
>  		if (error)
> @@ -1917,10 +1913,6 @@ xfs_fs_reconfigure(
>  	int			flags = fc->sb_flags;
>  	int			error;
>  
> -	/* version 5 superblocks always support version counters. */
> -	if (xfs_has_crc(mp))
> -		fc->sb_flags |= SB_I_VERSION;
> -
>  	error = xfs_fs_validate_params(new_mp);
>  	if (error)
>  		return error;
> -- 
> 2.43.0
> 
> 

