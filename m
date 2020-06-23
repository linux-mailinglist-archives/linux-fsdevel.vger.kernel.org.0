Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBD82049AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 08:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbgFWGPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 02:15:30 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:60084 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730515AbgFWGP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:15:29 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id AEB30110169;
        Tue, 23 Jun 2020 16:15:26 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jncDN-0003TN-O3; Tue, 23 Jun 2020 16:15:25 +1000
Date:   Tue, 23 Jun 2020 16:15:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, dsterba@suse.cz, jthumshirn@suse.de,
        fdmanana@gmail.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/6] iomap: IOMAP_DIOF_PGINVALID_FAIL return if page
 invalidation fails
Message-ID: <20200623061525.GI2040@dread.disaster.area>
References: <20200622152457.7118-1-rgoldwyn@suse.de>
 <20200622152457.7118-3-rgoldwyn@suse.de>
 <20200622173330.GA11239@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622173330.GA11239@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
        a=7-415B0cAAAA:8 a=qqUFr-TMUkpXaUc-sFEA:9 a=CjuIK1q_8ugA:10
        a=WzC6qhA0u3u7Ye7llzcV:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:33:30AM -0700, Darrick J. Wong wrote:
> On Mon, Jun 22, 2020 at 10:24:53AM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > The flag indicates that if the page invalidation fails, it should return
> > back control to the filesystem so it may fallback to buffered mode.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Looks reasonable enough, I suppose...
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> --D
> 
> > ---
> >  fs/iomap/direct-io.c  | 8 +++++++-
> >  include/linux/iomap.h | 5 +++++
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 7ed857196a39..20c4370e6b1b 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -484,8 +484,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  	 */
> >  	ret = invalidate_inode_pages2_range(mapping,
> >  			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > -	if (ret)
> > +	if (ret) {
> > +		if (dio_flags & IOMAP_DIOF_PGINVALID_FAIL) {
> > +			if (ret == -EBUSY)
> > +				ret = 0;
> > +			goto out_free_dio;
> > +		}
> >  		dio_warn_stale_pagecache(iocb->ki_filp);
> > +	}
> >  	ret = 0;
> >  
> >  	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index f6230446b08d..95024e28dec5 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -261,6 +261,11 @@ struct iomap_dio_ops {
> >  
> >  /* Wait for completion of DIO */
> >  #define IOMAP_DIOF_WAIT_FOR_COMPLETION 		0x1
> > +/*
> > + * Return zero if page invalidation fails, so caller filesystem may fallback
> > + * to buffered I/O
> > + */
> > +#define IOMAP_DIOF_PGINVALID_FAIL		0x2

That's a mouthful of letter salad. :(

Basically, you want the DIO to return a short IO if there is a busy
page cache on the inode?

IOWs, you don't want the page cache to become stale as a result of
the DIO being executed? So what the caller is actually asking for is
that the dio avoids creating stale page cache pages? Hence:

/*
 * Direct IO will attempt to keep the page cache coherent by
 * invalidating the inode's page cache over the range of the DIO.
 * That can fail if something else is actively using the page cache.
 * If this happens and the DIO continues, the data in the page
 * cache will become stale.
 *
 * Set this flag if you want the DIO to abort without issuing any IO
 * or error if it fails to invalidate the page cache successfully.
 * This allows the IO submitter to resubmit the entire IO as a
 * buffered IO through the page cache.
 */
#define IOMAP_DIO_RWF_NO_STALE_PAGECACHE	(1 << 1)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
