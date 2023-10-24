Return-Path: <linux-fsdevel+bounces-1098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59277D54BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64651C20C87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E582B776;
	Tue, 24 Oct 2023 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWKtZ5Ak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0425013FED
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 15:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E2EC433C8;
	Tue, 24 Oct 2023 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698160144;
	bh=+sTxJDVws6hFbRRZY3T4c/3V2tpunBXLS+DBgSiQAfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWKtZ5AkdfEFeb+k6ZpIxTkcLf+AQx1r2Mg3lGcLZLu7ZazlSpberuRpGGgiza/rs
	 vFHx72m+VaquZN/srqBqLAy8XQE6EDzEEL++XrxO7tiwGBBLYcbGnokd+EEz7letQA
	 IFCWLgNZdouVqq4q36Mi8u9dMVfj8pRgGULg/7cgZj7RO1nDb5XEUZDQXPqJcDtwK4
	 BnCnYnsAeF6Qt2ToYWCxKD2hF2hGa2MXLUkujWXM/C/ncAZnOOkB3kpaJvo/S5/APE
	 vD5eemoPWutD3m97mu90bSuAMYWKPtLKSAsWVEEpvopCkdqlWT7fz7OmQDNt6m6eDB
	 hnpqkcpuHRZlg==
Date: Tue, 24 Oct 2023 08:09:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] xfs: respect the stable writes flag on the RT device
Message-ID: <20231024150904.GA3195650@frogsfrogsfrogs>
References: <20231024064416.897956-1-hch@lst.de>
 <20231024064416.897956-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024064416.897956-4-hch@lst.de>

On Tue, Oct 24, 2023 at 08:44:16AM +0200, Christoph Hellwig wrote:
> Update the per-folio stable writes flag dependening on which device an
> inode resides on.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_inode.h | 8 ++++++++
>  fs/xfs/xfs_ioctl.c | 9 +++++++++
>  fs/xfs/xfs_iops.c  | 7 +++++++
>  3 files changed, 24 insertions(+)
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
> index 55bb01173cde8c..67bf613b3c86bc 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1147,6 +1147,15 @@ xfs_ioctl_setattr_xflags(
>  	ip->i_diflags2 = i_flags2;
>  
>  	xfs_diflags_to_iflags(ip, false);
> +
> +	/*
> +	 * Make the stable writes flag match that of the device the inode
> +	 * resides on when flipping the RT flag.
> +	 */
> +	if (S_ISREG(VFS_I(ip)->i_mode) &&
> +	    XFS_IS_REALTIME_INODE(ip) != (fa->fsx_xflags & FS_XFLAG_REALTIME))
> +		xfs_update_stable_writes(ip);

Hmm.  Won't the masking operation here result in the if test comparing 0
or FS_XFLAG_REALTIME to 0 or 1?

Oh.  FS_XFLAG_REALTIME == 1, so that's not an issue in this one case.
That's a bit subtle though, I'd have preferred

	    XFS_IS_REALTIME_INODE(ip) != !!(fa->fsx_xflags & FS_XFLAG_REALTIME))

to make it more obvious that the if test isn't comparing apples to
oranges.

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

I wonder if xfs_update_stable_writes should become an empty function for
the CONFIG_XFS_RT=n case, to avoid the atomic flags update?

(The extra code is probably not worth the microoptimization.)

With the !! nit addressed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
>  	/*
>  	 * If there is no attribute fork no ACL can exist on this inode,
>  	 * and it can't have any file capabilities attached to it either.
> -- 
> 2.39.2
> 

