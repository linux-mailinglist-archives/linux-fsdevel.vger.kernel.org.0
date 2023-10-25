Return-Path: <linux-fsdevel+bounces-1188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F6B7D6EE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF231C20E52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8762AB2C;
	Wed, 25 Oct 2023 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSOBcTG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4268C2AB36
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B53EC433C8;
	Wed, 25 Oct 2023 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698244802;
	bh=ZsyjdxTVs6itWoN60CajWTBiY55Mxf69XVsG6IddPiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSOBcTG6fmO/7Y94SFHz5tQHb29xFHidQPzjKqkf7U374cJqty9/mU48GewklkUou
	 UCaKC2JOK3OnsiAAH5O1UMNDS7nRI2sGnB1PWUx/ztQlkLePEmatJKtfnSApZdcgRv
	 JlI9saS06zcFPKUPQT28UPj2Dugk5uWD6VClw/Bu7h+U2x+SSKNwom3NlaPHC+bHzJ
	 m6lJbrgEkF4DbVF/QtHGmMTGcEArPl5onx4KvDK8aAWXNEvoVtZ/xUU5CIG1jIysqe
	 Sqy7UwwmNY6aGLBr/4PWVjl/WQNEDCqVywfzfcoQJhy63Cja+eDDcU6ykUB4IVzPgp
	 DCNJDNDQM0hrg==
Date: Wed, 25 Oct 2023 07:40:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] xfs: respect the stable writes flag on the RT device
Message-ID: <20231025144002.GD3195650@frogsfrogsfrogs>
References: <20231025141020.192413-1-hch@lst.de>
 <20231025141020.192413-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025141020.192413-5-hch@lst.de>

On Wed, Oct 25, 2023 at 04:10:20PM +0200, Christoph Hellwig wrote:
> Update the per-folio stable writes flag dependening on which device an
> inode resides on.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_inode.h | 8 ++++++++
>  fs/xfs/xfs_ioctl.c | 8 ++++++++
>  fs/xfs/xfs_iops.c  | 7 +++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 0c5bdb91152e1c..682959c8f78cb0 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -561,6 +561,14 @@ extern void xfs_setup_inode(struct xfs_inode *ip);
>  extern void xfs_setup_iops(struct xfs_inode *ip);
>  extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
>  
> +static inline void xfs_update_stable_writes(struct xfs_inode *ip)
> +{
> +	if (bdev_stable_writes(xfs_inode_buftarg(ip)->bt_bdev))
> +		mapping_set_stable_writes(VFS_I(ip)->i_mapping);
> +	else
> +		mapping_clear_stable_writes(VFS_I(ip)->i_mapping);
> +}
> +
>  /*
>   * When setting up a newly allocated inode, we need to call
>   * xfs_finish_inode_setup() once the inode is fully instantiated at
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index be69e7be713e5c..535f6d38cdb540 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1149,6 +1149,14 @@ xfs_ioctl_setattr_xflags(
>  	ip->i_diflags2 = i_flags2;
>  
>  	xfs_diflags_to_iflags(ip, false);
> +
> +	/*
> +	 * Make the stable writes flag match that of the device the inode
> +	 * resides on when flipping the RT flag.
> +	 */
> +	if (rtflag != XFS_IS_REALTIME_INODE(ip) && S_ISREG(VFS_I(ip)->i_mode))
> +		xfs_update_stable_writes(ip);
> +
>  	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
>  	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
>  	XFS_STATS_INC(mp, xs_ig_attrchg);
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 2b3b05c28e9e48..b8ec045708c318 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1298,6 +1298,13 @@ xfs_setup_inode(
>  	gfp_mask = mapping_gfp_mask(inode->i_mapping);
>  	mapping_set_gfp_mask(inode->i_mapping, (gfp_mask & ~(__GFP_FS)));
>  
> +	/*
> +	 * For real-time inodes update the stable write flags to that of the RT
> +	 * device instead of the data device.
> +	 */
> +	if (S_ISREG(inode->i_mode) && XFS_IS_REALTIME_INODE(ip))
> +		xfs_update_stable_writes(ip);
> +
>  	/*
>  	 * If there is no attribute fork no ACL can exist on this inode,
>  	 * and it can't have any file capabilities attached to it either.
> -- 
> 2.39.2
> 

