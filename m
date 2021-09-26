Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFFE418B51
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Sep 2021 23:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhIZV6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Sep 2021 17:58:15 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:35015 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229827AbhIZV6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Sep 2021 17:58:15 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id C1B96A7FB;
        Mon, 27 Sep 2021 07:56:34 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mUc8P-00H5Dz-7k; Mon, 27 Sep 2021 07:56:33 +1000
Date:   Mon, 27 Sep 2021 07:56:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] Introduce IOCB_SWAP kiocb flag to trigger REQ_SWAP
Message-ID: <20210926215633.GG2361455@dread.disaster.area>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
 <163250391274.2330363.16176856646027970865.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163250391274.2330363.16176856646027970865.stgit@warthog.procyon.org.uk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8
        a=VwQbUJbxAAAA:8 a=37rDS-QxAAAA:8 a=7-415B0cAAAA:8 a=4LiqF8mHRpqmJXjidzwA:9
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=k1Nq6YrhK2t884LQW06G:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:18:32PM +0100, David Howells wrote:
> Introduce an IOCB_SWAP flag for the kiocb struct such that the REQ_SWAP
> will get set on lower level operation structures in generic code.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Darrick J. Wong <djwong@kernel.org>
> cc: linux-xfs@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
> 
>  fs/direct-io.c      |    2 ++
>  include/linux/bio.h |    2 ++
>  include/linux/fs.h  |    1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index b2e86e739d7a..76eec0a68fa4 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1216,6 +1216,8 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	}
>  	if (iocb->ki_flags & IOCB_HIPRI)
>  		dio->op_flags |= REQ_HIPRI;
> +	if (iocb->ki_flags & IOCB_SWAP)
> +		dio->op_flags |= REQ_SWAP;
>  
>  	/*
>  	 * For AIO O_(D)SYNC writes we need to defer completions to a workqueue
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 00952e92eae1..b01133727494 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -787,6 +787,8 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
>  	bio->bi_opf |= REQ_HIPRI;
>  	if (!is_sync_kiocb(kiocb))
>  		bio->bi_opf |= REQ_NOWAIT;
> +	if (kiocb->ki_flags & IOCB_SWAP)
> +		bio->bi_opf |= REQ_SWAP;
>  }
>  
>  struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c909ca6c0eb6..c20f4423e2f1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -321,6 +321,7 @@ enum rw_hint {
>  #define IOCB_NOIO		(1 << 20)
>  /* can use bio alloc cache */
>  #define IOCB_ALLOC_CACHE	(1 << 21)
> +#define IOCB_SWAP		(1 << 22)	/* Operation on a swapfile */
>  
>  struct kiocb {
>  	struct file		*ki_filp;

This doesn't set REQ_SWAP for the iomap based DIO path.
bio_set_polled() is only called from iomap for IOCB_HIPRI IO.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
