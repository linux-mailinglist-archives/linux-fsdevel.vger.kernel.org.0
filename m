Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD7E253BF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 04:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgH0Cm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 22:42:57 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:47549 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726790AbgH0Cm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 22:42:56 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id AEE4B1AAE38;
        Thu, 27 Aug 2020 12:42:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kB7sG-0004YQ-2C; Thu, 27 Aug 2020 12:42:48 +1000
Date:   Thu, 27 Aug 2020 12:42:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v7 2/2] xfs: avoid transaction reservation recursion
Message-ID: <20200827024248.GA12131@dread.disaster.area>
References: <20200827013444.24270-1-laoar.shao@gmail.com>
 <20200827013444.24270-3-laoar.shao@gmail.com>
 <20200827015853.GA14765@casper.infradead.org>
 <CALOAHbA3Twne1ebM+tMZQPCJkL9ghpeeMJXPRjPX=iz8X9=LJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbA3Twne1ebM+tMZQPCJkL9ghpeeMJXPRjPX=iz8X9=LJA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=KcmsTjQD c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=Z0vDNPQScCoZdydbpagA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:13:15AM +0800, Yafang Shao wrote:
> On Thu, Aug 27, 2020 at 9:58 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Aug 27, 2020 at 09:34:44AM +0800, Yafang Shao wrote:
> > > @@ -1500,9 +1500,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
> > >
> > >       /*
> > >        * Given that we do not allow direct reclaim to call us, we should
> > > -      * never be called in a recursive filesystem reclaim context.
> > > +      * never be called while in a filesystem transaction.
> > >        */
> > > -     if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> > > +     if (WARN_ON_ONCE(wbc->fstrans_recursion))
> > >               goto redirty;
> >
> > Erm, Dave said:
> >
> > > I think we should just remove
> > > the check completely from iomap_writepage() and move it up into
> > > xfs_vm_writepage() and xfs_vm_writepages().
> >
> > ie everywhere you set this new bit, just check current->journal_info.
> 
> 
> I can't get you. Would you pls. be more specific ?
> 
> I move the check of current->journal into xfs_vm_writepage() and
> xfs_vm_writepages(), and I think that is the easiest way to implement
> it.
> 
>        /* we abort the update if there was an IO error */
> @@ -564,6 +565,9 @@ xfs_vm_writepage(
>  {
>         struct xfs_writepage_ctx wpc = { };
> 
> +       if (xfs_trans_context_active())
> +               wbc->fstrans_recursion = 1;    <<< set for XFS only.
> +
>         return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);

Get rid of wbc->fstrans_recursion. Just do

	if (WARN_ON_ONCE(current->journal_info))
		.....

right here in the XFS code.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
