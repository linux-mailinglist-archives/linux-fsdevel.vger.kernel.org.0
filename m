Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D626E8765
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 03:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjDTBWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 21:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjDTBWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94CF4C22;
        Wed, 19 Apr 2023 18:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 467A4641B5;
        Thu, 20 Apr 2023 01:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95740C433EF;
        Thu, 20 Apr 2023 01:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681953764;
        bh=bVyk52+Jw/zEohPJbwxcs2kjOrKfDFKxFsXbn06qgL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hf+Kh1XAJEXUNqHdJI+TUAe+nY2VPArGhPGypeO2j+fNj94mAOGdsQoHVX/yoR7Vs
         sSVzxIAQScRdwp4Bs6scIqQm2C4jrrie58zv1NiGYG5mRnjWQ7NsVyDLbGlLiFfsZz
         j+0E1rDHpBodXYAb6lrA90GAXk3XZg8Mmz9Z6z/3Hv8bhB4cENWnIS6+47neL7GoM9
         OraBtKHWYIQJO7pC2cZsDctM7HXLuATX4zJISKoKdPeHZ1NcfwNBQb+H2nsA0mjpVz
         8VsFcICUvTfRtMyV8FwZaixLfYf0w4AJS/NpX030abRNyg10E/iMsLuxJCLXz5/mcX
         vievTjUriqjKQ==
Date:   Wed, 19 Apr 2023 18:22:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>
Subject: Re: [PATCH v5 1/5] block: Don't invalidate pagecache for invalid
 falloc modes
Message-ID: <20230420012243.GO360895@frogsfrogsfrogs>
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230420004850.297045-2-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420004850.297045-2-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 05:48:46PM -0700, Sarthak Kukreti wrote:
> Only call truncate_bdev_range() if the fallocate mode is
> supported. This fixes a bug where data in the pagecache
> could be invalidated if the fallocate() was called on the
> block device with an invalid mode.
> 
> Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  block/fops.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index d2e6be4e3d1c..2fd7e8b9ab48 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -648,25 +648,27 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  
>  	filemap_invalidate_lock(inode->i_mapping);
>  
> -	/* Invalidate the page cache, including dirty pages. */
> -	error = truncate_bdev_range(bdev, file->f_mode, start, end);
> -	if (error)
> -		goto fail;
> -
> +	/*
> +	 * Invalidate the page cache, including dirty pages, for valid
> +	 * de-allocate mode calls to fallocate().
> +	 */
>  	switch (mode) {
>  	case FALLOC_FL_ZERO_RANGE:
>  	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
> -		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
> +		error = truncate_bdev_range(bdev, file->f_mode, start, end) ||
> +			blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,

I'm pretty sure we're supposed to preserve the error codes returned by
both functions.

	error = truncate_bdev_range(...);
	if (!error)
		error = blkdev_issue_zeroout(...);

--D

>  					     len >> SECTOR_SHIFT, GFP_KERNEL,
>  					     BLKDEV_ZERO_NOUNMAP);
>  		break;
>  	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
> -		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
> +		error = truncate_bdev_range(bdev, file->f_mode, start, end) ||
> +			blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
>  					     len >> SECTOR_SHIFT, GFP_KERNEL,
>  					     BLKDEV_ZERO_NOFALLBACK);
>  		break;
>  	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
> -		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> +		error = truncate_bdev_range(bdev, file->f_mode, start, end) ||
> +			blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
>  					     len >> SECTOR_SHIFT, GFP_KERNEL);
>  		break;
>  	default:
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
