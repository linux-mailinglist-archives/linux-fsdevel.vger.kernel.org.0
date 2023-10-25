Return-Path: <linux-fsdevel+bounces-1187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CDA7D6EE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A039B211B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E12AB31;
	Wed, 25 Oct 2023 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJPfWDt5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373802AB2D
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FF1C433C8;
	Wed, 25 Oct 2023 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698244783;
	bh=GE2SFdyv9cPI+wHMUMYdDQNMKbpwQ523nL6lEiQznvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJPfWDt5LZA47V0pmiuWNNY47E4t0Gnh2UML/j2/DIfaOGcHADX2EI5MFca7JN8ED
	 NlIuKBDP1WGLPhmCChLc6qeSCTxTfqHqTg5JnmyoitNXt6Gja3fZctIK4/dqwWnXOG
	 IOsFoT9KyJeWCH0bU8LInPxBSllbbVtMIe8lL8Kdk502z1ru73+joKMxZ3APnbKtcF
	 cynXwXatUIU262lfXGHF4dqV68yZoxQ2/T8I+vXyz27PaYligoUnuERoOoJlGvan4x
	 UR6qIEARwgK7IPd88MfZbCknCU63QF652j2+CP0cTfb9466ocde8Pup7buLV3k24N+
	 PAuE/Z7LNUK0g==
Date: Wed, 25 Oct 2023 07:39:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/4] xfs: clean up FS_XFLAG_REALTIME handling in
 xfs_ioctl_setattr_xflags
Message-ID: <20231025143943.GC3195650@frogsfrogsfrogs>
References: <20231025141020.192413-1-hch@lst.de>
 <20231025141020.192413-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025141020.192413-4-hch@lst.de>

On Wed, Oct 25, 2023 at 04:10:19PM +0200, Christoph Hellwig wrote:
> Introduce a local boolean variable if FS_XFLAG_REALTIME to make the
> checks for it more obvious, and de-densify a few of the conditionals
> using it to make them more readable while at it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_ioctl.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 55bb01173cde8c..be69e7be713e5c 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1120,23 +1120,25 @@ xfs_ioctl_setattr_xflags(
>  	struct fileattr		*fa)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
> +	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
>  	uint64_t		i_flags2;
>  
> -	/* Can't change realtime flag if any extents are allocated. */
> -	if ((ip->i_df.if_nextents || ip->i_delayed_blks) &&
> -	    XFS_IS_REALTIME_INODE(ip) != (fa->fsx_xflags & FS_XFLAG_REALTIME))
> -		return -EINVAL;
> +	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
> +		/* Can't change realtime flag if any extents are allocated. */
> +		if (ip->i_df.if_nextents || ip->i_delayed_blks)
> +			return -EINVAL;
> +	}
>  
> -	/* If realtime flag is set then must have realtime device */
> -	if (fa->fsx_xflags & FS_XFLAG_REALTIME) {
> +	if (rtflag) {
> +		/* If realtime flag is set then must have realtime device */
>  		if (mp->m_sb.sb_rblocks == 0 || mp->m_sb.sb_rextsize == 0 ||
>  		    (ip->i_extsize % mp->m_sb.sb_rextsize))
>  			return -EINVAL;
> -	}
>  
> -	/* Clear reflink if we are actually able to set the rt flag. */
> -	if ((fa->fsx_xflags & FS_XFLAG_REALTIME) && xfs_is_reflink_inode(ip))
> -		ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
> +		/* Clear reflink if we are actually able to set the rt flag. */
> +		if (xfs_is_reflink_inode(ip))
> +			ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
> +	}
>  
>  	/* diflags2 only valid for v3 inodes. */
>  	i_flags2 = xfs_flags2diflags2(ip, fa->fsx_xflags);
> -- 
> 2.39.2
> 

