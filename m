Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56339776C31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 00:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjHIWeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 18:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjHIWeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:34:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BC310C;
        Wed,  9 Aug 2023 15:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 494B064B67;
        Wed,  9 Aug 2023 22:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B86C433C7;
        Wed,  9 Aug 2023 22:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691620441;
        bh=IXz1Cm9ssDRQorn/6jLeGC/NZVxM2a25AmVpo1ICwmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFSuKgY2aS7Pj+Xz4nlnIKMzHamIpI/IxLitdcRNBqxqizHYSn8wqk90qWEXnuuSX
         +ocNAZ1e+A/jWhcVzCc6QFAAiydnHHRn/8oxYv/6PbDmcqqmtUptok5DZwNE48oJ6c
         PBaWp/KMUnCy7LCI7hdv+rCQR/xb4FhV9MLAK0N1tJHOlfCB/IeEHe9JZ6iczryX6o
         L8FybvqbK2mSmHG/29uf+VowLWCjPiEtvVVN496L7hlEUlNK0i/nl8+j8FXTrsh9k2
         e+Lw37rFRoUbGWgq9AXf9GDVw2VxhWkA9XLihvbMmx6qABcDC4/ibM+Nqsm85pToOP
         TIFwq554GHPcQ==
Date:   Wed, 9 Aug 2023 15:34:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/13] xfs: close the external block devices in
 xfs_mount_free
Message-ID: <20230809223401.GW11352@frogsfrogsfrogs>
References: <20230809220545.1308228-1-hch@lst.de>
 <20230809220545.1308228-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809220545.1308228-7-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:05:38PM -0700, Christoph Hellwig wrote:
> blkdev_put must not be called under sb->s_umount to avoid a lock order
> reversal with disk->open_mutex.  Move closing the buftargs into ->kill_sb
> to archive that.  Note that the flushing of the disk caches and
> block device mapping invalidated needs to stay in ->put_super as the main
> block device is closed in kill_block_super already.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_buf.c   |  2 --
>  fs/xfs/xfs_super.c | 36 ++++++++++++++++++++++++++----------
>  2 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index e33eb17648dfed..3b903f6bce98d8 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1945,8 +1945,6 @@ xfs_free_buftarg(
>  	percpu_counter_destroy(&btp->bt_io_count);
>  	list_lru_destroy(&btp->bt_lru);
>  
> -	blkdev_issue_flush(btp->bt_bdev);
> -	invalidate_bdev(btp->bt_bdev);
>  	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
>  	/* the main block device is closed by kill_block_super */
>  	if (bdev != btp->bt_mount->m_super->s_bdev)
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 368c05a2dea5b9..4ae3b01ed038c7 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -396,14 +396,19 @@ xfs_blkdev_get(
>  }
>  
>  STATIC void
> -xfs_close_devices(
> +xfs_shutdown_devices(
>  	struct xfs_mount	*mp)
>  {
> -	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
> -		xfs_free_buftarg(mp->m_logdev_targp);
> -	if (mp->m_rtdev_targp)
> -		xfs_free_buftarg(mp->m_rtdev_targp);
> -	xfs_free_buftarg(mp->m_ddev_targp);
> +	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
> +		blkdev_issue_flush(mp->m_logdev_targp->bt_bdev);
> +		invalidate_bdev(mp->m_logdev_targp->bt_bdev);
> +	}
> +	if (mp->m_rtdev_targp) {
> +		blkdev_issue_flush(mp->m_rtdev_targp->bt_bdev);
> +		invalidate_bdev(mp->m_rtdev_targp->bt_bdev);
> +	}
> +	blkdev_issue_flush(mp->m_ddev_targp->bt_bdev);
> +	invalidate_bdev(mp->m_ddev_targp->bt_bdev);
>  }
>  
>  /*
> @@ -741,6 +746,17 @@ static void
>  xfs_mount_free(
>  	struct xfs_mount	*mp)
>  {
> +	/*
> +	 * Free the buftargs here because blkdev_put needs to be called outside
> +	 * of sb->s_umount, which is held around the call to ->put_super.
> +	 */
> +	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
> +		xfs_free_buftarg(mp->m_logdev_targp);
> +	if (mp->m_rtdev_targp)
> +		xfs_free_buftarg(mp->m_rtdev_targp);
> +	if (mp->m_ddev_targp)
> +		xfs_free_buftarg(mp->m_ddev_targp);
> +
>  	kfree(mp->m_rtname);
>  	kfree(mp->m_logname);
>  	kmem_free(mp);
> @@ -1126,7 +1142,7 @@ xfs_fs_put_super(
>  	xfs_inodegc_free_percpu(mp);
>  	xfs_destroy_percpu_counters(mp);
>  	xfs_destroy_mount_workqueues(mp);
> -	xfs_close_devices(mp);
> +	xfs_shutdown_devices(mp);
>  }
>  
>  static long
> @@ -1499,7 +1515,7 @@ xfs_fs_fill_super(
>  
>  	error = xfs_init_mount_workqueues(mp);
>  	if (error)
> -		goto out_close_devices;
> +		goto out_shutdown_devices;
>  
>  	error = xfs_init_percpu_counters(mp);
>  	if (error)
> @@ -1713,8 +1729,8 @@ xfs_fs_fill_super(
>  	xfs_destroy_percpu_counters(mp);
>   out_destroy_workqueues:
>  	xfs_destroy_mount_workqueues(mp);
> - out_close_devices:
> -	xfs_close_devices(mp);
> + out_shutdown_devices:
> +	xfs_shutdown_devices(mp);
>  	return error;
>  
>   out_unmount:
> -- 
> 2.39.2
> 
