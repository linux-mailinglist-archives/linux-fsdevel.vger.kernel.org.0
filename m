Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C067954372B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbiFHPVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245530AbiFHPU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117C112D16E
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 08:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D90160AE5
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 15:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A39C3411D;
        Wed,  8 Jun 2022 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654701470;
        bh=3h8zWnLsaM7K0zjzg7bk1acjEnInXYiTKE8L7i2YQLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtdWtWbB6DwbRNMSuwVFHIA6UPHu088hGwbndsKPTBh8lvf0YHU+FQRuNlOZcP/WI
         YEynzClqo5qJpQWwqE4J/etzX2suGFijIAvP3vNUxdlxsi9LA1x5KD+ENs9E7OJx18
         vErSHP6cRQ1xraCKaENazIAqSFeLaOeBc95ZFvKCEDwCg1aTTV2Rh/kY8NMgPnri2R
         h8G3lF1gT4ZvSTagMvLkUTRsgY2arW2w5rHfWL0GpI0OLtqQlaUPGOQuo9BgUv/sXr
         jCPg/jNKAGOp3wn22gYsQUedDB+ZtjfKLEQs7xdvpNieuMaSeOo2w8vrXIEn2ZGi5j
         8Fot4DfkjQzlw==
Date:   Wed, 8 Jun 2022 08:17:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 02/10] teach iomap_dio_rw() to suppress dsync
Message-ID: <YqC9nZwgOHk2x0pg@magnolia>
References: <Yp/e+KFSksyDILpJ@zeniv-ca.linux.org.uk>
 <20220607233143.1168114-1-viro@zeniv.linux.org.uk>
 <20220607233143.1168114-2-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607233143.1168114-2-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:31:35PM +0000, Al Viro wrote:
> New flag, equivalent to removal of IOCB_DSYNC from iocb flags.
> This mimics what btrfs is doing (and that's what btrfs will
> switch to).  However, I'm not at all sure that we want to
> suppress REQ_FUA for those - all btrfs hack really cares about
> is suppression of generic_write_sync().  For now let's keep
> the existing behaviour, but I really want to hear more detailed
> arguments pro or contra.
> 
> [folded brain fix from willy]
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c  | 20 +++++++++++---------
>  include/linux/iomap.h |  6 ++++++
>  2 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 370c3241618a..c10c69e2de24 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -548,17 +548,19 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		}
>  
>  		/* for data sync or sync, we need sync completion processing */
> -		if (iocb->ki_flags & IOCB_DSYNC)
> +		if (iocb->ki_flags & IOCB_DSYNC &&
> +		    !(dio_flags & IOMAP_DIO_NOSYNC)) {
>  			dio->flags |= IOMAP_DIO_NEED_SYNC;
>  
> -		/*
> -		 * For datasync only writes, we optimistically try using FUA for
> -		 * this IO.  Any non-FUA write that occurs will clear this flag,
> -		 * hence we know before completion whether a cache flush is
> -		 * necessary.
> -		 */
> -		if ((iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC)) == IOCB_DSYNC)
> -			dio->flags |= IOMAP_DIO_WRITE_FUA;
> +		       /*
> +			* For datasync only writes, we optimistically try
> +			* using FUA for this IO.  Any non-FUA write that
> +			* occurs will clear this flag, hence we know before
> +			* completion whether a cache flush is necessary.
> +			*/
> +			if (!(iocb->ki_flags & IOCB_SYNC))
> +				dio->flags |= IOMAP_DIO_WRITE_FUA;
> +		}
>  	}
>  
>  	if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e552097c67e0..c8622d8f064e 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -353,6 +353,12 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_PARTIAL		(1 << 2)
>  
> +/*
> + * The caller will sync the write if needed; do not sync it within
> + * iomap_dio_rw.  Overrides IOMAP_DIO_FORCE_WAIT.
> + */
> +#define IOMAP_DIO_NOSYNC		(1 << 3)
> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, void *private, size_t done_before);
> -- 
> 2.30.2
> 
