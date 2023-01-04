Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF7865DA0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 17:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbjADQkY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 11:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbjADQj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:39:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A9A12AEA;
        Wed,  4 Jan 2023 08:39:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC6A1617AA;
        Wed,  4 Jan 2023 16:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E66C433D2;
        Wed,  4 Jan 2023 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672850395;
        bh=h/jv+uc6C6fvuckoeygXFmUHyc8ekbQX8LzVof57rmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAW/38lR5Li7sDcOiH8PBrPeuCvf2bAmOoJREGCVe5RkZW/LwOLIyWuckeeop1CKW
         XqyHLRbR2qhheYpf2e3jbeWM7imXGbM48sipJ2jAvbdl/Hv/fKWvGZ39H0QZEHfl5Z
         GJEuDMCOr79MdP1/2D3tZlaJr0L+5nDSIXukPtalUaqqGE49Y9Fj61Rl8uzv5Ae1wu
         We2sG+YVU07gnt0s/xQ59bbBacStfc7gi3+9eUV4wwB3/DNcUWaM4kVmAE0AAMpSy4
         +/VRDYEQO1K7ratEFw8f3A0DRd1gjaLmM7TituMZtKFbNXmbhcbGTjmM93QMTi19WR
         VUOmskYJH12Ww==
Date:   Wed, 4 Jan 2023 08:39:54 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
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
Subject: Re: [PATCH v2 3/7] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <Y7Wr2uadI+82BB6a@magnolia>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-4-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229081252.452240-4-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 29, 2022 at 12:12:48AM -0800, Sarthak Kukreti wrote:
> FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> sends a hint to (supported) thinly provisioned block devices to
> allocate space for the given range of sectors via REQ_OP_PROVISION.
> 
> The man pages for both fallocate(2) and posix_fallocate(3) describe
> the default allocation mode as:
> 
> ```
> The default operation (i.e., mode is zero) of fallocate()
> allocates the disk space within the range specified by offset and len.
> ...
> subsequent writes to bytes in the specified range are guaranteed
> not to fail because of lack of disk space.
> ```
> 
> For thinly provisioned storage constructs (dm-thin, filesystems on sparse
> files), the term 'disk space' is overloaded and can either mean the apparent
> disk space in the filesystem/thin logical volume or the true disk
> space that will be utilized on the underlying non-sparse allocation layer.
> 
> The use of a separate mode allows us to cleanly disambiguate whether fallocate()
> causes allocation only at the current layer (default mode) or whether it propagates
> allocations to underlying layers (provision mode)

Why is it important to make this distinction?  The outcome of fallocate
is supposed to be that subsequent writes do not fail with ENOSPC.  In my
(fs developer) mind, REQ_OP_PROVISION simply an extra step to be taken
after allocating file blocks.

If you *don't* add this API flag and simply bake the REQ_OP_PROVISION
call into mode 0 fallocate, then the new functionality can be added (or
even backported) to existing kernels and customers can use it
immediately.  If you *do*, then you get to wait a few years for
developers to add it to their codebases only after enough enterprise
distros pick up a new kernel to make it worth their while.

> for thinly provisioned filesystems/
> block devices. For devices that do not support REQ_OP_PROVISION, both these
> allocation modes will be equivalent. Given the performance cost of sending provision
> requests to the underlying layers, keeping the default mode as-is allows users to
> preserve existing behavior.

How expensive is this expected to be?  Is this why you wanted a separate
mode flag?

--D

> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  block/fops.c                | 15 +++++++++++----
>  include/linux/falloc.h      |  3 ++-
>  include/uapi/linux/falloc.h |  8 ++++++++
>  3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 50d245e8c913..01bde561e1e2 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -598,7 +598,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  #define	BLKDEV_FALLOC_FL_SUPPORTED					\
>  		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
> -		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
> +		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE |	\
> +		 FALLOC_FL_PROVISION)
>  
>  static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  			     loff_t len)
> @@ -634,9 +635,11 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	filemap_invalidate_lock(inode->i_mapping);
>  
>  	/* Invalidate the page cache, including dirty pages. */
> -	error = truncate_bdev_range(bdev, file->f_mode, start, end);
> -	if (error)
> -		goto fail;
> +	if (mode != FALLOC_FL_PROVISION) {
> +		error = truncate_bdev_range(bdev, file->f_mode, start, end);
> +		if (error)
> +			goto fail;
> +	}
>  
>  	switch (mode) {
>  	case FALLOC_FL_ZERO_RANGE:
> @@ -654,6 +657,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
>  					     len >> SECTOR_SHIFT, GFP_KERNEL);
>  		break;
> +	case FALLOC_FL_PROVISION:
> +		error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
> +					       len >> SECTOR_SHIFT, GFP_KERNEL);
> +		break;
>  	default:
>  		error = -EOPNOTSUPP;
>  	}
> diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> index f3f0b97b1675..b9a40a61a59b 100644
> --- a/include/linux/falloc.h
> +++ b/include/linux/falloc.h
> @@ -30,7 +30,8 @@ struct space_resv {
>  					 FALLOC_FL_COLLAPSE_RANGE |	\
>  					 FALLOC_FL_ZERO_RANGE |		\
>  					 FALLOC_FL_INSERT_RANGE |	\
> -					 FALLOC_FL_UNSHARE_RANGE)
> +					 FALLOC_FL_UNSHARE_RANGE |	\
> +					 FALLOC_FL_PROVISION)
>  
>  /* on ia32 l_start is on a 32-bit boundary */
>  #if defined(CONFIG_X86_64)
> diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> index 51398fa57f6c..2d323d113eed 100644
> --- a/include/uapi/linux/falloc.h
> +++ b/include/uapi/linux/falloc.h
> @@ -77,4 +77,12 @@
>   */
>  #define FALLOC_FL_UNSHARE_RANGE		0x40
>  
> +/*
> + * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
> + * blocks for the range/EOF.
> + *
> + * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
> + */
> +#define FALLOC_FL_PROVISION		0x80
> +
>  #endif /* _UAPI_FALLOC_H_ */
> -- 
> 2.37.3
> 
