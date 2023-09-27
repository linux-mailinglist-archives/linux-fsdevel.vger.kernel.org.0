Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DFB7B095E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 17:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjI0Pv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 11:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjI0Pvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:51:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E508697;
        Wed, 27 Sep 2023 08:41:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE25C433C8;
        Wed, 27 Sep 2023 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695829247;
        bh=aF93GdhhV1COeqCylc+ipsiYAn1fVgsAgFGh8I21JAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCgPYfQzhrFVwCFlu7Rt3zZKj2PDNs2shFLcEP6uTse0Y6lwizwi+YEtxv4oZfuOf
         AfhqbfmRM5jIRmVJYdZujZYnHpUURrcOfLG2gF5VnKqCkGH7Ar/pntImx8uX8Uapvs
         NsnE8mCxzWLGIRDicXOmX5YbUP36/5JwYQCgI42liDONo07WlwcapP04EDfh7S9uHT
         KhdI5SaaR6ZMqzfIJIOdgm+zRdHDDI8m4iod1+VxQ690AuqNH03GMWrO14jQRCfME5
         TQW70odaKHpKc/H/goJLUXZ4jm+oTjSaPUq6zisvCQBqWcssi57UmD9pNDQu8b7f2P
         VkKNzCmBbi68Q==
Date:   Wed, 27 Sep 2023 08:40:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 28/29] xfs: Convert to bdev_open_by_path()
Message-ID: <20230927154046.GH11414@frogsfrogsfrogs>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230927093442.25915-28-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927093442.25915-28-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:34:34AM +0200, Jan Kara wrote:
> Convert xfs to use bdev_open_by_path() and pass the handle around.
> 
> CC: "Darrick J. Wong" <djwong@kernel.org>
> CC: linux-xfs@vger.kernel.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks like a pretty straightforward conversion, so:

For the block parts,
Acked-by: Darrick J. Wong <djwong@kernel.org>

For this patch:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_buf.c   | 22 ++++++++++------------
>  fs/xfs/xfs_buf.h   |  3 ++-
>  fs/xfs/xfs_super.c | 42 ++++++++++++++++++++++++------------------
>  3 files changed, 36 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index c1ece4a08ff4..003e157241da 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1945,8 +1945,6 @@ void
>  xfs_free_buftarg(
>  	struct xfs_buftarg	*btp)
>  {
> -	struct block_device	*bdev = btp->bt_bdev;
> -
>  	unregister_shrinker(&btp->bt_shrinker);
>  	ASSERT(percpu_counter_sum(&btp->bt_io_count) == 0);
>  	percpu_counter_destroy(&btp->bt_io_count);
> @@ -1954,8 +1952,8 @@ xfs_free_buftarg(
>  
>  	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
>  	/* the main block device is closed by kill_block_super */
> -	if (bdev != btp->bt_mount->m_super->s_bdev)
> -		blkdev_put(bdev, btp->bt_mount->m_super);
> +	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
> +		bdev_release(btp->bt_bdev_handle);
>  
>  	kmem_free(btp);
>  }
> @@ -1990,16 +1988,15 @@ xfs_setsize_buftarg(
>   */
>  STATIC int
>  xfs_setsize_buftarg_early(
> -	xfs_buftarg_t		*btp,
> -	struct block_device	*bdev)
> +	xfs_buftarg_t		*btp)
>  {
> -	return xfs_setsize_buftarg(btp, bdev_logical_block_size(bdev));
> +	return xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev));
>  }
>  
>  struct xfs_buftarg *
>  xfs_alloc_buftarg(
>  	struct xfs_mount	*mp,
> -	struct block_device	*bdev)
> +	struct bdev_handle	*bdev_handle)
>  {
>  	xfs_buftarg_t		*btp;
>  	const struct dax_holder_operations *ops = NULL;
> @@ -2010,9 +2007,10 @@ xfs_alloc_buftarg(
>  	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
>  
>  	btp->bt_mount = mp;
> -	btp->bt_dev =  bdev->bd_dev;
> -	btp->bt_bdev = bdev;
> -	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off,
> +	btp->bt_bdev_handle = bdev_handle;
> +	btp->bt_dev = bdev_handle->bdev->bd_dev;
> +	btp->bt_bdev = bdev_handle->bdev;
> +	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
>  					    mp, ops);
>  
>  	/*
> @@ -2022,7 +2020,7 @@ xfs_alloc_buftarg(
>  	ratelimit_state_init(&btp->bt_ioerror_rl, 30 * HZ,
>  			     DEFAULT_RATELIMIT_BURST);
>  
> -	if (xfs_setsize_buftarg_early(btp, bdev))
> +	if (xfs_setsize_buftarg_early(btp))
>  		goto error_free;
>  
>  	if (list_lru_init(&btp->bt_lru))
> diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
> index df8f47953bb4..ada9d310b7d3 100644
> --- a/fs/xfs/xfs_buf.h
> +++ b/fs/xfs/xfs_buf.h
> @@ -98,6 +98,7 @@ typedef unsigned int xfs_buf_flags_t;
>   */
>  typedef struct xfs_buftarg {
>  	dev_t			bt_dev;
> +	struct bdev_handle	*bt_bdev_handle;
>  	struct block_device	*bt_bdev;
>  	struct dax_device	*bt_daxdev;
>  	u64			bt_dax_part_off;
> @@ -364,7 +365,7 @@ xfs_buf_update_cksum(struct xfs_buf *bp, unsigned long cksum_offset)
>   *	Handling of buftargs.
>   */
>  struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
> -		struct block_device *bdev);
> +		struct bdev_handle *bdev_handle);
>  extern void xfs_free_buftarg(struct xfs_buftarg *);
>  extern void xfs_buftarg_wait(struct xfs_buftarg *);
>  extern void xfs_buftarg_drain(struct xfs_buftarg *);
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 819a3568b28f..f0ae07828153 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -361,14 +361,15 @@ STATIC int
>  xfs_blkdev_get(
>  	xfs_mount_t		*mp,
>  	const char		*name,
> -	struct block_device	**bdevp)
> +	struct bdev_handle	**handlep)
>  {
>  	int			error = 0;
>  
> -	*bdevp = blkdev_get_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE,
> -				    mp->m_super, &fs_holder_ops);
> -	if (IS_ERR(*bdevp)) {
> -		error = PTR_ERR(*bdevp);
> +	*handlep = bdev_open_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE,
> +				     mp->m_super, &fs_holder_ops);
> +	if (IS_ERR(*handlep)) {
> +		error = PTR_ERR(*handlep);
> +		*handlep = NULL;
>  		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
>  	}
>  
> @@ -433,7 +434,7 @@ xfs_open_devices(
>  {
>  	struct super_block	*sb = mp->m_super;
>  	struct block_device	*ddev = sb->s_bdev;
> -	struct block_device	*logdev = NULL, *rtdev = NULL;
> +	struct bdev_handle	*logdev_handle = NULL, *rtdev_handle = NULL;
>  	int			error;
>  
>  	/*
> @@ -446,17 +447,19 @@ xfs_open_devices(
>  	 * Open real time and log devices - order is important.
>  	 */
>  	if (mp->m_logname) {
> -		error = xfs_blkdev_get(mp, mp->m_logname, &logdev);
> +		error = xfs_blkdev_get(mp, mp->m_logname, &logdev_handle);
>  		if (error)
>  			goto out_relock;
>  	}
>  
>  	if (mp->m_rtname) {
> -		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev);
> +		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev_handle);
>  		if (error)
>  			goto out_close_logdev;
>  
> -		if (rtdev == ddev || rtdev == logdev) {
> +		if (rtdev_handle->bdev == ddev ||
> +		    (logdev_handle &&
> +		     rtdev_handle->bdev == logdev_handle->bdev)) {
>  			xfs_warn(mp,
>  	"Cannot mount filesystem with identical rtdev and ddev/logdev.");
>  			error = -EINVAL;
> @@ -468,22 +471,25 @@ xfs_open_devices(
>  	 * Setup xfs_mount buffer target pointers
>  	 */
>  	error = -ENOMEM;
> -	mp->m_ddev_targp = xfs_alloc_buftarg(mp, ddev);
> +	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb->s_bdev_handle);
>  	if (!mp->m_ddev_targp)
>  		goto out_close_rtdev;
>  
> -	if (rtdev) {
> -		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev);
> +	if (rtdev_handle) {
> +		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev_handle);
>  		if (!mp->m_rtdev_targp)
>  			goto out_free_ddev_targ;
>  	}
>  
> -	if (logdev && logdev != ddev) {
> -		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev);
> +	if (logdev_handle && logdev_handle->bdev != ddev) {
> +		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_handle);
>  		if (!mp->m_logdev_targp)
>  			goto out_free_rtdev_targ;
>  	} else {
>  		mp->m_logdev_targp = mp->m_ddev_targp;
> +		/* Handle won't be used, drop it */
> +		if (logdev_handle)
> +			bdev_release(logdev_handle);
>  	}
>  
>  	error = 0;
> @@ -497,11 +503,11 @@ xfs_open_devices(
>   out_free_ddev_targ:
>  	xfs_free_buftarg(mp->m_ddev_targp);
>   out_close_rtdev:
> -	 if (rtdev)
> -		 blkdev_put(rtdev, sb);
> +	 if (rtdev_handle)
> +		bdev_release(rtdev_handle);
>   out_close_logdev:
> -	if (logdev && logdev != ddev)
> -		blkdev_put(logdev, sb);
> +	if (logdev_handle)
> +		bdev_release(logdev_handle);
>  	goto out_relock;
>  }
>  
> -- 
> 2.35.3
> 
