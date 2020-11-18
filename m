Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681712B866C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 22:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKRVPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 16:15:10 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:50927 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbgKRVPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:15:10 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 8064F3C1DFD;
        Thu, 19 Nov 2020 08:15:07 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kfUnC-00CZgk-4w; Thu, 19 Nov 2020 08:15:06 +1100
Date:   Thu, 19 Nov 2020 08:15:06 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] iomap: only return IO error if no data has been
 transferred
Message-ID: <20201118211506.GQ7391@dread.disaster.area>
References: <2a56ae95-b64e-f20f-8875-62a2f2e8e00f@kernel.dk>
 <20201118071941.GN7391@dread.disaster.area>
 <9ef0f890-f115-41f3-15fc-28f21810379f@kernel.dk>
 <20201118203723.GP7391@dread.disaster.area>
 <95d51836-9dc0-24c3-9aad-678d68613907@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d51836-9dc0-24c3-9aad-678d68613907@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10 a=7-415B0cAAAA:8
        a=4VEEKuDIvK2Sp4QpMRgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 02:00:06PM -0700, Jens Axboe wrote:
> On 11/18/20 1:37 PM, Dave Chinner wrote:
> > On Wed, Nov 18, 2020 at 08:26:50AM -0700, Jens Axboe wrote:
> >> On 11/18/20 12:19 AM, Dave Chinner wrote:
> >>> On Tue, Nov 17, 2020 at 03:17:18PM -0700, Jens Axboe wrote:
> >>>> If we've successfully transferred some data in __iomap_dio_rw(),
> >>>> don't mark an error for a latter segment in the dio.
> >>>>
> >>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>>>
> >>>> ---
> >>>>
> >>>> Debugging an issue with io_uring, which uses IOCB_NOWAIT for the
> >>>> IO. If we do parts of an IO, then once that completes, we still
> >>>> return -EAGAIN if we ran into a problem later on. That seems wrong,
> >>>> normal convention would be to return the short IO instead. For the
> >>>> -EAGAIN case, io_uring will retry later parts without IOCB_NOWAIT
> >>>> and complete it successfully.
> >>>
> >>> So you are getting a write IO that is split across an allocated
> >>> extent and a hole, and the second mapping is returning EAGAIN
> >>> because allocation would be required? This sort of split extent IO
> >>> is fairly common, so I'm not sure that splitting them into two
> >>> separate IOs may not be the best approach.
> >>
> >> The case I seem to be hitting is this one:
> >>
> >> if (iocb->ki_flags & IOCB_NOWAIT) {
> >> 	if (filemap_range_has_page(mapping, pos, end)) {
> >>                   ret = -EAGAIN;
> >>                   goto out_free_dio;
> >> 	}
> >> 	flags |= IOMAP_NOWAIT;
> >> }
> >>
> >> in __iomap_dio_rw(), which isn't something we can detect upfront like IO
> >> over a multiple extents...
> > 
> > This specific situation cannot result in the partial IO behaviour
> > you described.  It is an -upfront check- that is done before any IO
> > is mapped or issued so results in the entire IO being skipped and we
> > don't get anywhere near the code you changed.
> > 
> > IOWs, this doesn't explain why you saw a partial IO, or why changing
> > partial IO return values avoids -EAGAIN from a range we apparently
> > just did a partial IO over and -didn't have page cache pages-
> > sitting over it.
> 
> You are right, I double checked and recreated my debugging. What's
> triggering is that we're hitting this in xfs_direct_write_iomap_begin()
> after we've already done some IO:
> 
> allocate_blocks:
> 	error = -EAGAIN;
> 	if (flags & IOMAP_NOWAIT)
> 		goto out_unlock;

Ok, that's exactly the case the reproducer I wrote triggers.

> > Can you provide an actual event trace of the IOs in question that
> > are failing in your tests (e.g. from something like `trace-cmd
> > record -e xfs_file\* -e xfs_i\* -e xfs_\*write -e iomap\*` over the
> > sequential that reproduces the issue) so that there's no ambiguity
> > over how this problem is occurring in your systems?
> 
> Let me know if you still want this!

No, it makes sense now :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
