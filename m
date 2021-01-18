Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B108A2FABC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 21:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394245AbhARUrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 15:47:06 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:48361 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394462AbhARUqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:46:13 -0500
Received: from dread.disaster.area (pa49-181-54-82.pa.nsw.optusnet.com.au [49.181.54.82])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0808D3C39DB;
        Tue, 19 Jan 2021 07:45:30 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l1bP0-001MBv-GB; Tue, 19 Jan 2021 07:45:30 +1100
Date:   Tue, 19 Jan 2021 07:45:30 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com
Subject: Re: [PATCH 10/11] iomap: add a IOMAP_DIO_UNALIGNED flag
Message-ID: <20210118204530.GE78941@dread.disaster.area>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-11-hch@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=NAd5MxazP4FGoF8nXO8esw==:117 a=NAd5MxazP4FGoF8nXO8esw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=NBupp-YSCloIjiwG5kQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:15PM +0100, Christoph Hellwig wrote:
> Add a flag to signal an I/O that is not file system block aligned.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c  | 7 +++++++
>  include/linux/iomap.h | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 32dbbf7dd4aadb..d93019ee4c9e3e 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -485,6 +485,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		iomap_flags |= IOMAP_NOWAIT;
>  	}
>  
> +	if (dio_flags & IOMAP_DIO_UNALIGNED) {
> +		ret = -EAGAIN;
> +		if (pos >= dio->i_size)
> +			goto out_free_dio;

This also needs to check for pos+len > dio->i_size on a write as
iomap_dio_rw_actor will do unconditional sub-block zeroing in that
case, too.

> +		iomap_flags |= IOMAP_UNALIGNED;
> +	}
> +
>  	ret = filemap_write_and_wait_range(mapping, pos, end);
>  	if (ret)
>  		goto out_free_dio;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index b322598dc10ec0..2fa94ec9583d0a 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -122,6 +122,7 @@ struct iomap_page_ops {
>  #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
>  #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
> +#define IOMAP_UNALIGNED		(1 << 6) /* do not allocate blocks */
>  
>  struct iomap_ops {
>  	/*
> @@ -262,6 +263,13 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_FORCE_WAIT	(1 << 0)
>  
> +/*
> + * Direct I/O that is not aligned to the file system block.  Do not allocate
> + * blocks and do not zero partial blocks, fall back to the caller by returning
> + * -EAGAIN instead.
> + */
> +#define IOMAP_DIO_UNALIGNED	(1 << 1)

I'd describe it a little bit differently, clearly indicating that
this is for optional behaviour and not needed on all unaligned DIO.

/*
 * Filesystems may need to special case DIO that is not aligned to
 * block boundaries. If they set IOMAP_DIO_UNALIGNED on an unaligned
 * IO, then do not allocate blocks or zero partial blocks, but
 * instead fall back to the caller by returning -EAGAIN so they can
 * handle these conditions correctly.
 */

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
