Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0EF415037
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 20:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhIVSzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 14:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhIVSzj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:55:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E232C61131;
        Wed, 22 Sep 2021 18:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632336849;
        bh=nw4rmUXhQ4DXG70zhOKzoN09kTCH7w6/WXX6pxQ3kws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9GFQPcRBA3kUuYk2dMAQiHm9KgtgisBscnO7fqiigAehyKvcCJ1413IwKa8Ils8l
         i75tdgLJjgC3GlYrz5MAVrj1rEiwl8jBVrrv6JzXGLKPbSuDxYvIAKBJ+SwdV6ijAq
         /To8nbl3xqm61zTQv7lHdldZDwx85Cp2G8sOSuIWo5iPYZJCFz3MuDo0yj8D4D+4Ax
         wPRunMATJlIH8XwwC24azoN3EFFKr3byQx6nM0zgDvUGWCejP7bWmggHCTr0AGbpzM
         UsKbcDIvwV605UQpeTKdUbw5RSb3CnPz46UwGGAjhrBOUVo9a5p0fJ1CWOxLk9E/CA
         Ikj06RMzF+mMw==
Date:   Wed, 22 Sep 2021 11:54:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] iomap: use accelerated zeroing on a block device to
 zero a file range
Message-ID: <20210922185408.GL570615@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192865577.417973.11122330974455662098.stgit@magnolia>
 <20210921223343.GP1756565@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921223343.GP1756565@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 08:33:43AM +1000, Dave Chinner wrote:
> On Fri, Sep 17, 2021 at 06:30:55PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create a function that ensures that the storage backing part of a file
> > contains zeroes and will not trip over old media errors if the contents
> > are re-read.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/iomap/direct-io.c  |   75 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/iomap.h |    3 ++
> >  2 files changed, 78 insertions(+)
> > 
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 4ecd255e0511..48826a49f976 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -652,3 +652,78 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  	return iomap_dio_complete(dio);
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_dio_rw);
> > +
> > +static loff_t
> > +iomap_zeroinit_iter(struct iomap_iter *iter)
> > +{
> > +	struct iomap *iomap = &iter->iomap;
> > +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > +	const u64 start = iomap->addr + iter->pos - iomap->offset;
> > +	const u64 nr_bytes = iomap_length(iter);
> > +	sector_t sector = start >> SECTOR_SHIFT;
> > +	sector_t nr_sectors = nr_bytes >> SECTOR_SHIFT;
> > +	int ret;
> > +
> > +	if (!iomap->bdev)
> > +		return -ECANCELED;
> > +
> > +	/* The physical extent must be sector-aligned for block layer APIs. */
> > +	if ((start | nr_bytes) & (SECTOR_SIZE - 1))
> > +		return -EINVAL;
> > +
> > +	/* Must be able to zero storage directly without fs intervention. */
> > +	if (iomap->flags & IOMAP_F_SHARED)
> > +		return -ECANCELED;
> > +	if (srcmap != iomap)
> > +		return -ECANCELED;
> > +
> > +	switch (iomap->type) {
> > +	case IOMAP_MAPPED:
> > +		ret = blkdev_issue_zeroout(iomap->bdev, sector, nr_sectors,
> > +				GFP_KERNEL, 0);
> 
> Pretty sure this needs to use BLKDEV_ZERO_NOUNMAP.

Oops, good catch!

--D

> The whole point of this is having zeroed space allocated ready for
> write on return, so having the hardware optimise away the physical
> storage zeroing by punching a hole in it's backing store and then
> potentially getting ENOSPC on the next write to this range would be
> .... suboptimal.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
