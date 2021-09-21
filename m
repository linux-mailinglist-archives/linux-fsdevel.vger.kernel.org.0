Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9927413D9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 00:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhIUWfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 18:35:16 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:39401 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232614AbhIUWfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:35:16 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 95F5110895A;
        Wed, 22 Sep 2021 08:33:45 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mSoKd-00FCEc-TJ; Wed, 22 Sep 2021 08:33:43 +1000
Date:   Wed, 22 Sep 2021 08:33:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] iomap: use accelerated zeroing on a block device to
 zero a file range
Message-ID: <20210921223343.GP1756565@dread.disaster.area>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192865577.417973.11122330974455662098.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163192865577.417973.11122330974455662098.stgit@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=-5CkAHJHcSgt8UN8:21 a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=C-qKf3thjc4iI29I25oA:9 a=CjuIK1q_8ugA:10
        a=Juw0sNgvN_PjAcCGr8F2:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 06:30:55PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a function that ensures that the storage backing part of a file
> contains zeroes and will not trip over old media errors if the contents
> are re-read.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/iomap/direct-io.c  |   75 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iomap.h |    3 ++
>  2 files changed, 78 insertions(+)
> 
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 4ecd255e0511..48826a49f976 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -652,3 +652,78 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	return iomap_dio_complete(dio);
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_rw);
> +
> +static loff_t
> +iomap_zeroinit_iter(struct iomap_iter *iter)
> +{
> +	struct iomap *iomap = &iter->iomap;
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	const u64 start = iomap->addr + iter->pos - iomap->offset;
> +	const u64 nr_bytes = iomap_length(iter);
> +	sector_t sector = start >> SECTOR_SHIFT;
> +	sector_t nr_sectors = nr_bytes >> SECTOR_SHIFT;
> +	int ret;
> +
> +	if (!iomap->bdev)
> +		return -ECANCELED;
> +
> +	/* The physical extent must be sector-aligned for block layer APIs. */
> +	if ((start | nr_bytes) & (SECTOR_SIZE - 1))
> +		return -EINVAL;
> +
> +	/* Must be able to zero storage directly without fs intervention. */
> +	if (iomap->flags & IOMAP_F_SHARED)
> +		return -ECANCELED;
> +	if (srcmap != iomap)
> +		return -ECANCELED;
> +
> +	switch (iomap->type) {
> +	case IOMAP_MAPPED:
> +		ret = blkdev_issue_zeroout(iomap->bdev, sector, nr_sectors,
> +				GFP_KERNEL, 0);

Pretty sure this needs to use BLKDEV_ZERO_NOUNMAP.

The whole point of this is having zeroed space allocated ready for
write on return, so having the hardware optimise away the physical
storage zeroing by punching a hole in it's backing store and then
potentially getting ENOSPC on the next write to this range would be
.... suboptimal.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
