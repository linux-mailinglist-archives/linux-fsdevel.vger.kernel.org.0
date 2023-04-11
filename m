Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206896DDE95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 16:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDKOzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 10:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjDKOyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840D82683;
        Tue, 11 Apr 2023 07:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D99E62811;
        Tue, 11 Apr 2023 14:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697C0C433D2;
        Tue, 11 Apr 2023 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681224887;
        bh=CGAs5krnbEkxPgaPAZs8JvQBrcDCyRJbtDmkf6pgqFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXugew4HthDAgFBFPE2Y+YeHKjqPLkIIGT0qU6/HO3aO4Mlj6uYdN9LcO8i/ixePo
         b17IMExYNJJyPkedoCq7nAeOFjJXKgbVuyMBBE5hL0QBBoXV4qsMq2Xk7XVbtUq82/
         d16gGqvrGJYhXonPCK+e8YHiVR1INUlReTP5qrB6vFS2imX16R84fAdb0PE1ovk+F2
         yNEbfo2qlZPy4GCMEcjXhMl3u089fP98Z85p7WasnlVS+Lch/IrirJhZNFcOzRtEZK
         JkggJUZbUQvse4WIrd0ZI8yu0iwo0c8w8H0q0HU9u+29p5bR8wWT8FUAqQUNteoRhJ
         qi1OQcDHA2fIA==
Date:   Tue, 11 Apr 2023 07:54:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 3/3][RESEND] xfs: mark the inode for high-res
 timestamp update in getattr
Message-ID: <20230411145446.GG360895@frogsfrogsfrogs>
References: <20230411143702.64495-1-jlayton@kernel.org>
 <20230411143702.64495-4-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411143702.64495-4-jlayton@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:37:02AM -0400, Jeff Layton wrote:
> When the mtime or ctime is being queried via getattr, ensure that we
> mark the inode for a high-res timestamp update on the next pass. Also,
> switch to current_cmtime for other c/mtime updates.
> 
> With this change, we're better off having the NFS server just ignore
> the i_version field and have it use the ctime instead, so clear the
> STATX_CHANGE_COOKIE flag in the result mask in ->getattr.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
>  fs/xfs/xfs_acl.c                |  2 +-
>  fs/xfs/xfs_inode.c              |  2 +-
>  fs/xfs/xfs_iops.c               | 15 ++++++++++++---
>  4 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> index 8b5547073379..9ad7c229c617 100644
> --- a/fs/xfs/libxfs/xfs_trans_inode.c
> +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> @@ -63,7 +63,7 @@ xfs_trans_ichgtime(
>  	ASSERT(tp);
>  	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
>  
> -	tv = current_time(inode);
> +	tv = current_cmtime(inode);
>  
>  	if (flags & XFS_ICHGTIME_MOD)
>  		inode->i_mtime = tv;
> diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
> index 791db7d9c849..461adc58cf8c 100644
> --- a/fs/xfs/xfs_acl.c
> +++ b/fs/xfs/xfs_acl.c
> @@ -233,7 +233,7 @@ xfs_acl_set_mode(
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
>  	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
>  	inode->i_mode = mode;
> -	inode->i_ctime = current_time(inode);
> +	inode->i_ctime = current_cmtime(inode);

Hmm, now we're adding a spinlock to all these updates.
Does lockdep have anything exciting to say about this?

(I don't think it will, just wondering aloud...)

>  	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
>  
>  	if (xfs_has_wsync(mp))
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 5808abab786c..80f9d731e261 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -843,7 +843,7 @@ xfs_init_new_inode(
>  	ip->i_df.if_nextents = 0;
>  	ASSERT(ip->i_nblocks == 0);
>  
> -	tv = current_time(inode);
> +	tv = current_cmtime(inode);
>  	inode->i_mtime = tv;
>  	inode->i_atime = tv;
>  	inode->i_ctime = tv;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 24718adb3c16..a0b07f90e16c 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -565,6 +565,15 @@ xfs_vn_getattr(
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
>  
> +	/*
> +	 * XFS uses the i_version infrastructure to track any change to
> +	 * the inode, including atime updates. This means that the i_version
> +	 * returned by getattr doesn't conform to what the callers expect.
> +	 * Clear it here so that nfsd will fake up a change cookie from the
> +	 * ctime instead.
> +	 */
> +	stat->result_mask &= ~STATX_CHANGE_COOKIE;
> +
>  	stat->size = XFS_ISIZE(ip);
>  	stat->dev = inode->i_sb->s_dev;
>  	stat->mode = inode->i_mode;
> @@ -573,8 +582,8 @@ xfs_vn_getattr(
>  	stat->gid = vfsgid_into_kgid(vfsgid);
>  	stat->ino = ip->i_ino;
>  	stat->atime = inode->i_atime;
> -	stat->mtime = inode->i_mtime;
> -	stat->ctime = inode->i_ctime;
> +	if (request_mask & (STATX_CTIME|STATX_MTIME))
> +		fill_cmtime_and_mark(inode, stat);

Should we be setting STATX_[CM]TIME in the result_mask, just in case the
caller asked for ctime and not mtime?

--D

>  	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
>  
>  	if (xfs_has_v3inodes(mp)) {
> @@ -917,7 +926,7 @@ xfs_setattr_size(
>  	if (newsize != oldsize &&
>  	    !(iattr->ia_valid & (ATTR_CTIME | ATTR_MTIME))) {
>  		iattr->ia_ctime = iattr->ia_mtime =
> -			current_time(inode);
> +			current_cmtime(inode);
>  		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME;
>  	}
>  
> -- 
> 2.39.2
> 
