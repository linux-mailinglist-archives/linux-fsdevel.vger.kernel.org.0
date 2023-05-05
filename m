Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D326F889D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 20:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjEEScJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 14:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjEEScE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 14:32:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB651C0DC;
        Fri,  5 May 2023 11:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18C3563F52;
        Fri,  5 May 2023 18:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61682C4339B;
        Fri,  5 May 2023 18:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683311522;
        bh=ElxiH9XVsymefwL2/VnRDjD7rNi5AY4KOX50SLE23uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtEmJ0/iXGFKi+IxJM21pwAwotKpFmmiY3Ie/63QAeQZ/Riv/8cy0v9JN4y/btD5n
         QUVc28Cf/yDnJcM3hfXI20mSNGBGi2G+uTmq5LKMjX+AKi+huySoRODt+1RWFULkQ/
         bEjlG8fRFu2flFY75XDOc1sUO10GYnzFNXNgRTPIK/P9VEEFXxsSewmKkthoouDZOa
         4kD0PU7Bg36lu1S8d0ihBGPqSyQDJchRa2zNzdqDNjXoNJ4j+aVbZK+mtR/sT078lb
         uGquO3paNZyVKFPIzrPj8RhUwai9lGRzbXeRBfackaxdZNKdJWE4AvXEYa/0PkMggb
         yGpcu/rgaCGbg==
Date:   Fri, 5 May 2023 11:32:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 9/9] xfs: wire up the ->mark_dead holder operation for
 log and RT devices
Message-ID: <20230505183201.GF15394@frogsfrogsfrogs>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505175132.2236632-10-hch@lst.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 01:51:32PM -0400, Christoph Hellwig wrote:
> Implement a set of holder_ops that shut down the file system when the
> block device used as log or RT device is removed undeneath the file
> system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_super.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 3abe5ae96cc59b..9c2401d9548d83 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -377,6 +377,17 @@ xfs_setup_dax_always(
>  	return 0;
>  }
>  
> +static void
> +xfs_hop_mark_dead(
> +	struct block_device	*bdev)
> +{
> +	xfs_force_shutdown(bdev->bd_holder, SHUTDOWN_DEVICE_REMOVED);

/me wonders if this should be xfs_bdev_mark_dead, but eh that's mostly
stylistic.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +}
> +
> +static const struct blk_holder_ops xfs_holder_ops = {
> +	.mark_dead		= xfs_hop_mark_dead,
> +};
> +
>  STATIC int
>  xfs_blkdev_get(
>  	xfs_mount_t		*mp,
> @@ -386,7 +397,7 @@ xfs_blkdev_get(
>  	int			error = 0;
>  
>  	*bdevp = blkdev_get_by_path(name, FMODE_READ|FMODE_WRITE|FMODE_EXCL,
> -				    mp, NULL);
> +				    mp, &xfs_holder_ops);
>  	if (IS_ERR(*bdevp)) {
>  		error = PTR_ERR(*bdevp);
>  		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
> -- 
> 2.39.2
> 
