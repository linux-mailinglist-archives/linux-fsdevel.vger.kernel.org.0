Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0561F776485
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 17:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjHIPz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 11:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjHIPz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABDD1BD9;
        Wed,  9 Aug 2023 08:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B28C761150;
        Wed,  9 Aug 2023 15:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12045C433C8;
        Wed,  9 Aug 2023 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691596525;
        bh=3iB+9ATezzmqYQmC0LUv1pBtayZQRiye79OEK1xc1TM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rISR/PAAE4PKeR6QMwwUWflpYraHLWknbVvPIb3ViB/L/teof9m2LtYDrDzDFCslJ
         S3ELO/ZsBF2ocUKXdlbIQH73tSojk54XfOF1U39shh0jfKzkzW/GZbvuE2IpGepx7/
         a9lU9z7AXxapSFkektJlwghsqPfGrwr3Lrh7j6lEbydx5iWgDeBmcT8NSgZtESj3hC
         7UdJRKbxm9pTfcreIBsTvZXl+i2GwVxuvdzeb5vw7UuPxJni47m/JMfkRYOmBm+7aD
         lHSl2v+ZMBt+RQsYuHjPUABQBz+YVFJ8lgxA00Ye/KPrYhr7XOYbx2kUtw/6RQgR+7
         zV6aAxOZa88Wg==
Date:   Wed, 9 Aug 2023 08:55:24 -0700
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
Subject: Re: [PATCH 07/13] xfs: close the external block devices in
 xfs_mount_free
Message-ID: <20230809155524.GU11352@frogsfrogsfrogs>
References: <20230808161600.1099516-1-hch@lst.de>
 <20230808161600.1099516-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808161600.1099516-8-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:15:54AM -0700, Christoph Hellwig wrote:
> blkdev_put must not be called under sb->s_umount to avoid a lock order
> reversal with disk->open_mutex.  Move closing the buftargs into ->kill_sb
> to archive that.  Note that the flushing of the disk caches needs to be
> kept in ->put_super as the main block device is closed in
> kill_block_super already.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_buf.c   |  1 -
>  fs/xfs/xfs_super.c | 27 +++++++++++++++++++--------
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index c57e6e03dfa80c..3b903f6bce98d8 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1945,7 +1945,6 @@ xfs_free_buftarg(
>  	percpu_counter_destroy(&btp->bt_io_count);
>  	list_lru_destroy(&btp->bt_lru);
>  
> -	blkdev_issue_flush(btp->bt_bdev);
>  	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
>  	/* the main block device is closed by kill_block_super */
>  	if (bdev != btp->bt_mount->m_super->s_bdev)
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 37b1b763a0bef0..67343364ac66e9 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -396,14 +396,14 @@ xfs_blkdev_get(
>  }
>  
>  STATIC void
> -xfs_close_devices(
> +xfs_flush_disk_caches(
>  	struct xfs_mount	*mp)
>  {
>  	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
> -		xfs_free_buftarg(mp->m_logdev_targp);
> +		blkdev_issue_flush(mp->m_logdev_targp->bt_bdev);
>  	if (mp->m_rtdev_targp)
> -		xfs_free_buftarg(mp->m_rtdev_targp);
> -	xfs_free_buftarg(mp->m_ddev_targp);
> +		blkdev_issue_flush(mp->m_rtdev_targp->bt_bdev);
> +	blkdev_issue_flush(mp->m_ddev_targp->bt_bdev);

If I'm following this correctly, putting the superblock flushes the
bdevs (though it doesn't invalidate the bdev mapping!) and only later
when we free the xfs_mount do we actually put the buftargs?

That works, though I still think we need to invalidate the bdev
pagecache for the log and data bdevs.

--D

>  }
>  
>  /*
> @@ -741,6 +741,17 @@ static void
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
> @@ -1126,7 +1137,7 @@ xfs_fs_put_super(
>  	xfs_inodegc_free_percpu(mp);
>  	xfs_destroy_percpu_counters(mp);
>  	xfs_destroy_mount_workqueues(mp);
> -	xfs_close_devices(mp);
> +	xfs_flush_disk_caches(mp);
>  }
>  
>  static long
> @@ -1499,7 +1510,7 @@ xfs_fs_fill_super(
>  
>  	error = xfs_init_mount_workqueues(mp);
>  	if (error)
> -		goto out_close_devices;
> +		goto out_flush_caches;
>  
>  	error = xfs_init_percpu_counters(mp);
>  	if (error)
> @@ -1713,8 +1724,8 @@ xfs_fs_fill_super(
>  	xfs_destroy_percpu_counters(mp);
>   out_destroy_workqueues:
>  	xfs_destroy_mount_workqueues(mp);
> - out_close_devices:
> -	xfs_close_devices(mp);
> + out_flush_caches:
> +	xfs_flush_disk_caches(mp);
>  	return error;
>  
>   out_unmount:
> -- 
> 2.39.2
> 
