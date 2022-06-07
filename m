Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0153F52F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 06:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbiFGEmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 00:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiFGEmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:42:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865F8F7B
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 21:42:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D772468AFE; Tue,  7 Jun 2022 06:42:17 +0200 (CEST)
Date:   Tue, 7 Jun 2022 06:42:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/9] btrfs_direct_write(): cleaner way to handle
 generic_write_sync() suppression
Message-ID: <20220607044217.GB7887@lst.de>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk> <Yp7PlaCTJF19m2sG@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp7PlaCTJF19m2sG@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:09:57AM +0000, Al Viro wrote:
> explicitly tell iomap to do it, rather than messing with IOCB_DSYNC
> [folded a fix for braino spotted by willy]

Please split the iomap and btrfs side into separate patches.

> +++ b/fs/btrfs/inode.c
> @@ -8152,7 +8152,7 @@ ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t done_befo
>  	struct btrfs_dio_data data;
>  
>  	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> -			    IOMAP_DIO_PARTIAL, &data, done_before);
> +			    IOMAP_DIO_PARTIAL | IOMAP_DIO_NOSYNC, &data, done_before);

Please avoid the overly long line.

> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 370c3241618a..0f16479b13d6 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -548,7 +548,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		}
>  
>  		/* for data sync or sync, we need sync completion processing */
> -		if (iocb->ki_flags & IOCB_DSYNC)
> +		if (iocb->ki_flags & IOCB_DSYNC && !(dio_flags & IOMAP_DIO_NOSYNC))

Same here.  Also the FUA check below needs to check IOMAP_DIO_NOSYNC as
well.
