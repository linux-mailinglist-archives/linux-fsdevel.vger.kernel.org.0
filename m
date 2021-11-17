Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA797454BFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 18:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbhKQReL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 12:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237646AbhKQReK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:34:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A92261B9F;
        Wed, 17 Nov 2021 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637170271;
        bh=BiRKQ/d3nVUFjcnKBhqKmlNar5IqbY6hjBQWP//4lO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REgDCmlv/GsdUGBCUzpgY0SLzbRa7hiC9XAkokcnw8ztdTAZXw6loYohaUrV7/92E
         P4bRiUjDuNTcTzI0vzrQ96agKc9CmHmCrcXaCZROvQtNhvQwR3t0TBYcHApAjclXSM
         RwG3+khdqhamkmbTKDMPmHpQzbrMwArDRtSrCF9cFjT4inXLa8SkeN78UiQ5CxL+yo
         NbLu0pV80tIJ7V1OH4OqygjECgeNMnPLK3PGbMD+HBNd52+pNQAUAMoBe5BtrmSENT
         wX6MAEmgIfeFftiBn3U9SsdpvtrK2RpoPT6ry6Uad/3tdXf4Om38cNgzsujDy0Bu6U
         p63F7wtEJbVHw==
Date:   Wed, 17 Nov 2021 09:31:11 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 07/29] xfs: factor out a xfs_setup_dax_always helper
Message-ID: <20211117173111.GZ24307@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:32:47AM +0100, Christoph Hellwig wrote:
> Factor out another DAX setup helper to simplify future changes.  Also
> move the experimental warning after the checks to not clutter the log
> too much if the setup failed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_super.c | 47 +++++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index e21459f9923a8..875fd3151d6c9 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -340,6 +340,32 @@ xfs_buftarg_is_dax(
>  			bdev_nr_sectors(bt->bt_bdev));
>  }
>  
> +static int
> +xfs_setup_dax_always(
> +	struct xfs_mount	*mp)
> +{
> +	struct super_block	*sb = mp->m_super;
> +
> +	if (!xfs_buftarg_is_dax(sb, mp->m_ddev_targp) &&
> +	   (!mp->m_rtdev_targp || !xfs_buftarg_is_dax(sb, mp->m_rtdev_targp))) {
> +		xfs_alert(mp,
> +			"DAX unsupported by block device. Turning off DAX.");
> +		goto disable_dax;
> +	}
> +
> +	if (xfs_has_reflink(mp)) {
> +		xfs_alert(mp, "DAX and reflink cannot be used together!");
> +		return -EINVAL;
> +	}
> +
> +	xfs_warn(mp, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> +	return 0;
> +
> +disable_dax:
> +	xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
> +	return 0;
> +}
> +
>  STATIC int
>  xfs_blkdev_get(
>  	xfs_mount_t		*mp,
> @@ -1593,26 +1619,9 @@ xfs_fs_fill_super(
>  		sb->s_flags |= SB_I_VERSION;
>  
>  	if (xfs_has_dax_always(mp)) {
> -		bool rtdev_is_dax = false, datadev_is_dax;
> -
> -		xfs_warn(mp,
> -		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> -
> -		datadev_is_dax = xfs_buftarg_is_dax(sb, mp->m_ddev_targp);
> -		if (mp->m_rtdev_targp)
> -			rtdev_is_dax = xfs_buftarg_is_dax(sb,
> -						mp->m_rtdev_targp);
> -		if (!rtdev_is_dax && !datadev_is_dax) {
> -			xfs_alert(mp,
> -			"DAX unsupported by block device. Turning off DAX.");
> -			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
> -		}
> -		if (xfs_has_reflink(mp)) {
> -			xfs_alert(mp,
> -		"DAX and reflink cannot be used together!");
> -			error = -EINVAL;
> +		error = xfs_setup_dax_always(mp);
> +		if (error)
>  			goto out_filestream_unmount;
> -		}
>  	}
>  
>  	if (xfs_has_discard(mp)) {
> -- 
> 2.30.2
> 
