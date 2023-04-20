Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EDA6E9966
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjDTQVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjDTQVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:21:17 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F35D40CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 09:20:30 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-74e17099772so79893985a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 09:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682007629; x=1684599629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi8BRALKHs7eage0Q9/aKDKQbgLFo1rksVSh6HXojUM=;
        b=O9s1lDpciss9bD60zs/9gDtg4x0rHdGWazzDFZq+bsBWfVGURngbaPLfjZp+q6UT22
         bs8x7mf3PZj3yGuCkVoe6e9cDxrHuFwe4AjjyltDp6yFCuLvkuhYUkeKr6YScVPUAzlp
         tf1j/v/a3MEiNqxWESPU5BB/9Q7XNcSxrAWG8+d10gVho0OQzgo6T3IiN8qzjVZ1opG5
         GAVfgC/OtzMvnsyzPalTcfJJ4T5Ce2bsoxzcy+Iu6d2iTYbqqic96LzhiKlgSR/4EnJB
         xn4/aaKTxTLcoasVGbOJdknAuGoD/8y37TxlcCZhVE+RKhR5JSXd04FscQ/A5glvWR8s
         dhFA==
X-Gm-Message-State: AAQBX9f0ba/MvVfpFYWg7IpV6XXna0sQUZIRfDg2oywuc7vQ/5FSq1u6
        2I7H2NKhELoSH17dqUEPfJMB
X-Google-Smtp-Source: AKy350ZdxFbx3P6KW7oGgzZkOdBts5SMHV3jmQ7iV4w8PdU+G+NU8GyRCb0ZtSnye0JdmMgLiXUHqw==
X-Received: by 2002:a05:6214:1c4e:b0:5f0:23be:a301 with SMTP id if14-20020a0562141c4e00b005f023bea301mr2999579qvb.5.1682007629560;
        Thu, 20 Apr 2023 09:20:29 -0700 (PDT)
Received: from localhost ([37.19.196.135])
        by smtp.gmail.com with ESMTPSA id b17-20020a05620a271100b0074e034915d4sm539562qkp.73.2023.04.20.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:20:28 -0700 (PDT)
Date:   Thu, 20 Apr 2023 12:20:27 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniil Lunev <dlunev@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v5-fix 1/5] block: Don't invalidate pagecache for invalid
 falloc modes
Message-ID: <ZEFmS9h81Wwlv9+/@redhat.com>
References: <20230420004850.297045-2-sarthakkukreti@chromium.org>
 <20230420014734.302304-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420014734.302304-1-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19 2023 at  9:47P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> Only call truncate_bdev_range() if the fallocate mode is
> supported. This fixes a bug where data in the pagecache
> could be invalidated if the fallocate() was called on the
> block device with an invalid mode.
> 
> Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")

You should add:

Cc: stable@vger.kernel.org
Reported-by: Darrick J. Wong <djwong@kernel.org>

> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  block/fops.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index d2e6be4e3d1c..d359254c645d 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -648,26 +648,37 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  
>  	filemap_invalidate_lock(inode->i_mapping);
>  
> -	/* Invalidate the page cache, including dirty pages. */
> -	error = truncate_bdev_range(bdev, file->f_mode, start, end);
> -	if (error)
> -		goto fail;
> -

You remove the only user of the 'fail' label.  But I think it'd be
cleaner to keep using it below (reduces indentation churn too).

> +	/*
> +	 * Invalidate the page cache, including dirty pages, for valid
> +	 * de-allocate mode calls to fallocate().
> +	 */
>  	switch (mode) {
>  	case FALLOC_FL_ZERO_RANGE:
>  	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
> -		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
> -					     len >> SECTOR_SHIFT, GFP_KERNEL,
> -					     BLKDEV_ZERO_NOUNMAP);
> +		error = truncate_bdev_range(bdev, file->f_mode, start, end);
> +		if (!error)
> +			error = blkdev_issue_zeroout(bdev,
> +						     start >> SECTOR_SHIFT,
> +						     len >> SECTOR_SHIFT,
> +						     GFP_KERNEL,
> +						     BLKDEV_ZERO_NOUNMAP);
>  		break;


So:

		error = truncate_bdev_range(bdev, file->f_mode, start, end);
		if (error)
		        goto fail;
		...


>  	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
> -		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
> -					     len >> SECTOR_SHIFT, GFP_KERNEL,
> -					     BLKDEV_ZERO_NOFALLBACK);
> +		error = truncate_bdev_range(bdev, file->f_mode, start, end);
> +		if (!error)
> +			error = blkdev_issue_zeroout(bdev,
> +						     start >> SECTOR_SHIFT,
> +						     len >> SECTOR_SHIFT,
> +						     GFP_KERNEL,
> +						     BLKDEV_ZERO_NOFALLBACK);
>  		break;

Same.

>  	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
> -		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> -					     len >> SECTOR_SHIFT, GFP_KERNEL);
> +		error = truncate_bdev_range(bdev, file->f_mode, start, end);
> +		if (!error)
> +			error = blkdev_issue_discard(bdev,
> +						     start >> SECTOR_SHIFT,
> +						     len >> SECTOR_SHIFT,
> +						     GFP_KERNEL);
>  		break;

Same.
