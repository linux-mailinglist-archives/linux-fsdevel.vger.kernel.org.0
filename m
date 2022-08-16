Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C20595F87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiHPPqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 11:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiHPPp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:45:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3892856BA0;
        Tue, 16 Aug 2022 08:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 398C4B819FD;
        Tue, 16 Aug 2022 15:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84DEC433D6;
        Tue, 16 Aug 2022 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660664588;
        bh=M3oLnJo1qmEGcHvhKv48Lhf5XwYiKJUkic7K4U2f4t4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j6rpiN8O9urVKjfieHeD48UO+RMAXF/2X+y+Qr/aYB82aJnWM2CeZSIkjQL4HM2CL
         9Ta9peS4IazlR4t+ohNfv6Qu7RKWV69F18VKn8YWzkFm1FzcaXIITJ8hwOpP1CtM85
         +zdRa8WSLsCaGFlq89blyG6Ws0GyJ+GWTZsZjcNCTFi1z/pPc0SYA0GscBOGf0v5LP
         II6g/PUHKh827ZGhNLg7yhcmREZCZj+QXDLWwP0anVpFzu+UjTKySDNZhf8Uyesatp
         i5KNFcnL3KxuKxmywvIK6rnh+V55GlDTw0GGqcYMSompDD6ex+dbY1aE8rKtjPwiu4
         FeLWJCnLNwAjQ==
Date:   Tue, 16 Aug 2022 08:43:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Message-ID: <Yvu7DHDWl4g1KsI5@magnolia>
References: <20220816131736.42615-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816131736.42615-1-jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:17:36AM -0400, Jeff Layton wrote:
> The i_version in xfs_trans_log_inode is bumped for any inode update,
> including atime-only updates due to reads. We don't want to record those
> in the i_version, as they don't represent "real" changes. Remove that
> callsite.
> 
> In xfs_vn_update_time, if S_VERSION is flagged, then attempt to bump the
> i_version and turn on XFS_ILOG_CORE if it happens. In
> xfs_trans_ichgtime, update the i_version if the mtime or ctime are being
> updated.

What about operations that don't touch the mtime but change the file
metadata anyway?  There are a few of those, like the blockgc garbage
collector, deduperange, and the defrag tool.

Zooming out a bit -- what does i_version signal, concretely?  I thought
it was used by nfs (and maybe ceph?) to signal to clients that the file
on the server has moved on, and the client needs to invalidate its
caches.  I thought afs had a similar generation counter, though it's
only used to cache file data, not metadata?  Does an i_version change
cause all of them to invalidate caches, or is there more behavior I
don't know about?

Does that mean that we should bump i_version for any file data or
attribute that could be queried or observed by userspace?  In which case
I suppose this change is still correct, even if it relaxes i_version
updates from "any change to the inode whatsoever" to "any change that
would bump mtime".  Unless FIEMAP is part of "attributes observed by
userspace".

(The other downside I can see is that now we have to remember to bump
timestamps for every new file operation we add, unlike the current code
which is centrally located in xfs_trans_log_inode.)

--D

> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_trans_inode.c | 17 +++--------------
>  fs/xfs/xfs_iops.c               |  4 ++++
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> index 8b5547073379..78bf7f491462 100644
> --- a/fs/xfs/libxfs/xfs_trans_inode.c
> +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> @@ -71,6 +71,8 @@ xfs_trans_ichgtime(
>  		inode->i_ctime = tv;
>  	if (flags & XFS_ICHGTIME_CREATE)
>  		ip->i_crtime = tv;
> +	if (flags & (XFS_ICHGTIME_MOD|XFS_ICHGTIME_CHG))
> +		inode_inc_iversion(inode);
>  }
>  
>  /*
> @@ -116,20 +118,7 @@ xfs_trans_log_inode(
>  		spin_unlock(&inode->i_lock);
>  	}
>  
> -	/*
> -	 * First time we log the inode in a transaction, bump the inode change
> -	 * counter if it is configured for this to occur. While we have the
> -	 * inode locked exclusively for metadata modification, we can usually
> -	 * avoid setting XFS_ILOG_CORE if no one has queried the value since
> -	 * the last time it was incremented. If we have XFS_ILOG_CORE already
> -	 * set however, then go ahead and bump the i_version counter
> -	 * unconditionally.
> -	 */
> -	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
> -		if (IS_I_VERSION(inode) &&
> -		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
> -			iversion_flags = XFS_ILOG_CORE;
> -	}
> +	set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags);
>  
>  	/*
>  	 * If we're updating the inode core or the timestamps and it's possible
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 45518b8c613c..162e044c7f56 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -718,6 +718,7 @@ xfs_setattr_nonsize(
>  	}
>  
>  	setattr_copy(mnt_userns, inode, iattr);
> +	inode_inc_iversion(inode);
>  	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
>  
>  	XFS_STATS_INC(mp, xs_ig_attrchg);
> @@ -943,6 +944,7 @@ xfs_setattr_size(
>  
>  	ASSERT(!(iattr->ia_valid & (ATTR_UID | ATTR_GID)));
>  	setattr_copy(mnt_userns, inode, iattr);
> +	inode_inc_iversion(inode);
>  	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
>  
>  	XFS_STATS_INC(mp, xs_ig_attrchg);
> @@ -1047,6 +1049,8 @@ xfs_vn_update_time(
>  		inode->i_mtime = *now;
>  	if (flags & S_ATIME)
>  		inode->i_atime = *now;
> +	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> +		log_flags |= XFS_ILOG_CORE;
>  
>  	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
>  	xfs_trans_log_inode(tp, ip, log_flags);
> -- 
> 2.37.2
> 
