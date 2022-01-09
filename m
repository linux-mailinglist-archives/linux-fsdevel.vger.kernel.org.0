Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26ED488CFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 00:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiAIXJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jan 2022 18:09:55 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:41441 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237368AbiAIXJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jan 2022 18:09:55 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7D63010C086D;
        Mon, 10 Jan 2022 10:09:50 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n6hJt-00DNz7-2d; Mon, 10 Jan 2022 10:09:49 +1100
Date:   Mon, 10 Jan 2022 10:09:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220109230949.GU945095@dread.disaster.area>
References: <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <0996c40657b5873dda5119344bf74556491e27b9.camel@hammerspace.com>
 <c9d9b7850c6086b123b4add4de7b1992cb62f6ad.camel@hammerspace.com>
 <20220105224829.GO945095@dread.disaster.area>
 <20220106000107.GJ31606@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106000107.GJ31606@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61db6b41
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8
        a=aQYpAC3VT_W_qSOf6XEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 04:01:07PM -0800, Darrick J. Wong wrote:
> On Thu, Jan 06, 2022 at 09:48:29AM +1100, Dave Chinner wrote:
> > +
> > +	might_sleep();
> >  
> >  	list_replace_init(&ioend->io_list, &tmp);
> > +	segments = ioend->io_segments;
> >  	iomap_finish_ioend(ioend, error);
> >  
> >  	while (!list_empty(&tmp)) {
> > +		if (segments > 32768) {
> > +			cond_resched();
> > +			segments = 0;
> > +		}
> >  		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
> >  		list_del_init(&ioend->io_list);
> > +		segments += ioend->io_segments;
> >  		iomap_finish_ioend(ioend, error);
> >  	}
> 
> I wonder, should we take one more swing at cond_resched at the end of
> the function so that we can return to the caller having given the system
> at least one chance to reschedule?

That's for the caller of xfs_finish_ioends() to deal with as it
loops over each set of merged ioends and does it's own processing.
i.e. that's what the cond_resched() I added to the XFS endio
processing code here provides:

> >  void
> >  xfs_end_io(
> >  	struct work_struct	*work)
> > @@ -157,6 +170,7 @@ xfs_end_io(
> >  		list_del_init(&ioend->io_list);
> >  		iomap_ioend_try_merge(ioend, &tmp);
> >  		xfs_end_ioend(ioend);
> > +		cond_resched();
> >  	}
> >  }

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
