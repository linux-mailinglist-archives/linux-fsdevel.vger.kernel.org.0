Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE0B5398F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 23:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243249AbiEaVqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 17:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiEaVqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 17:46:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0E86D96D;
        Tue, 31 May 2022 14:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54C3E61387;
        Tue, 31 May 2022 21:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B8DC385A9;
        Tue, 31 May 2022 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654033609;
        bh=5+TFnO/t+SNX2FQs/tWp2G1t5E0Wg0Jw7L9xutbcSx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VqS1AVZdj1v2THvdN5o49UuqSVE0ivcHNaziY4gy+vgSfrRPl34d0Z31nZBvAiCHF
         xT80VhojMYdYilIyAeDJTdmwDE33d/QwERifcS+YXhYk8jBxyrPOveGdpeLO5NYzV2
         MpODlZC1eKld8CNXymiIYurnzJ1zRFsLaSUo+ivRyU2Jq8w0yWiDLiub5bjRkOht/a
         mJaj/H5oAjKpeO7IMwENFfHGjScnoEBzVC2z+xr4XNmLh+2IJvDozVuhSF4c7wNqFo
         MVd5h67AJaydzVyfrapaZSP8qaW8esJrmf530op+1cQP4bTKlPBb1puhuoqMard6DA
         ExhOHqlrqVXNg==
Date:   Tue, 31 May 2022 21:46:48 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 09/11] block: introduce bdev_iter_is_aligned helper
Message-ID: <YpaMyCfOKK5NKgL+@gmail.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
 <20220531191137.2291467-10-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531191137.2291467-10-kbusch@fb.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 31, 2022 at 12:11:35PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide a convenient function for this repeatable coding pattern.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  include/linux/blkdev.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 834b981ef01b..583cdeb8895d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1370,6 +1370,13 @@ static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
>  	return queue_dma_alignment(bdev_get_queue(bdev));
>  }
>  
> +static inline bool bvev_iter_is_aligned(struct block_device *bdev,
> +					struct iov_iter *iter)
> +{
> +	return iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
> +				   bdev_logical_block_size(bdev) - 1);
> +}

"bdev", not "bvev".

- Eric
