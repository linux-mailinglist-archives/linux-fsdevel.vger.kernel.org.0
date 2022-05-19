Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DD752C877
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 02:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiESAO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 20:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiESAO4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 20:14:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9091617EC14;
        Wed, 18 May 2022 17:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EC49B8224F;
        Thu, 19 May 2022 00:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5C0C385A9;
        Thu, 19 May 2022 00:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652919291;
        bh=xh67BXY6nRd6sUO/8wonkcQujUiANp+o46hSD4mh8UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpKRoRAycInJIVequPxVd5CqSr+vRUsxp8CuKBoCqro5DqNmjrBELOM8tnU4cYjCE
         H7wPd9YpFuNX370BmLejW2DgEMm3CuwFzhwjzgUptuPfJ9BMqAW074iv3P08PQAhjE
         G3tIb/UtGvwmAVm5b5+jmTg2fbJ4uD1qSMfoSeW+RllYJeMk4nP+J1+pDwlO6Jrv0T
         otLYKL9N+hR7ZiocfhIVI2xr9ymJpJB6btuTmEFmrAiO5Mmv+kDp2xOEjT9Fs7iZe8
         U0EoqBtSsLm15BpVNNNT4o9EApsrjwqjSPY3s1qpsgz2I6+nLjRyczDD+h9dso18Wl
         CJdm9lkb+Wh4w==
Date:   Wed, 18 May 2022 17:14:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <YoWL+T8JiIO5Ln3h@sol.localdomain>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-4-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518171131.3525293-4-kbusch@fb.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 10:11:31AM -0700, Keith Busch wrote:
> diff --git a/block/fops.c b/block/fops.c
> index b9b83030e0df..d8537c29602f 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -54,8 +54,9 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>  	struct bio bio;
>  	ssize_t ret;
>  
> -	if ((pos | iov_iter_alignment(iter)) &
> -	    (bdev_logical_block_size(bdev) - 1))
> +	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
> +		return -EINVAL;
> +	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
>  		return -EINVAL;

The block layer makes a lot of assumptions that bios can be split at any bvec
boundary.  With this patch, bios whose length isn't a multiple of the logical
block size can be generated by splitting, which isn't valid.

Also some devices aren't compatible with logical blocks spanning bdevs at all.
dm-crypt errors out in this case, for example.

What am I missing?

- Eric
