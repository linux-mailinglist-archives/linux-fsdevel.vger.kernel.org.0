Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464E22FE671
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 10:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbhAUJfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 04:35:10 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:41537 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728743AbhAUJdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:33:38 -0500
Received: from dread.disaster.area (pa49-180-243-77.pa.nsw.optusnet.com.au [49.180.243.77])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 90DF11A8BA9;
        Thu, 21 Jan 2021 20:32:52 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l2WKi-000p8H-2W; Thu, 21 Jan 2021 20:32:52 +1100
Date:   Thu, 21 Jan 2021 20:32:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com
Subject: Re: [PATCH 10/11] iomap: add a IOMAP_DIO_OVERWRITE_ONLY flag
Message-ID: <20210121093252.GB4662@dread.disaster.area>
References: <20210121085906.322712-1-hch@lst.de>
 <20210121085906.322712-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121085906.322712-11-hch@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=juxvdbeFDU67v5YkIhU0sw==:117 a=juxvdbeFDU67v5YkIhU0sw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=in2YdIHcAAAA:8 a=20KFwNOVAAAA:8
        a=7-415B0cAAAA:8 a=28_mCTYa1JjuCEsmLLgA:9 a=CjuIK1q_8ugA:10
        a=jvJaD-jWAXz1fu1h5wd8:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 09:59:05AM +0100, Christoph Hellwig wrote:
> Add a flag to signal an only pure overwrites are allowed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c  | 7 +++++++
>  include/linux/iomap.h | 8 ++++++++
>  2 files changed, 15 insertions(+)

IOMAP_DIO_OVERWRITE_ONLY is a much better name compared to all the
other alternatives that were suggested. :)

> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 947343730e2c93..65d32364345d22 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -485,6 +485,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		iomap_flags |= IOMAP_NOWAIT;
>  	}
>  
> +	if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
> +		ret = -EAGAIN;
> +		if (pos >= dio->i_size || pos + count > dio->i_size)
> +			goto out_free_dio;
> +		iomap_flags |= IOMAP_OVERWRITE_ONLY;
> +	}
> +
>  	ret = filemap_write_and_wait_range(mapping, pos, end);
>  	if (ret)
>  		goto out_free_dio;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index be4e1e1e01e801..cfa20afd7d5b87 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -122,6 +122,7 @@ struct iomap_page_ops {
>  #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
>  #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
> +#define IOMAP_OVERWRITE_ONLY	(1 << 6) /* purely overwrites allowed */

Nit: s/purely/pure/

But otherwise good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
