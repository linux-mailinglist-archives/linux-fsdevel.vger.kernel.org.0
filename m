Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6148E4849BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 22:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiADVQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 16:16:11 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:35222 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233906AbiADVQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:16:10 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3C35E62C8E7;
        Wed,  5 Jan 2022 08:16:06 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n4rA5-00BNqn-Ex; Wed, 05 Jan 2022 08:16:05 +1100
Date:   Wed, 5 Jan 2022 08:16:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "hch@infradead.org" <hch@infradead.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220104211605.GI945095@dread.disaster.area>
References: <20211230193522.55520-1-trondmy@kernel.org>
 <Yc5f/C1I+N8MPHcd@casper.infradead.org>
 <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <YdPyhpdxykDscMtJ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdPyhpdxykDscMtJ@infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61d4b919
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=baIrwSSmlUJSndfftQsA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 03, 2022 at 11:08:54PM -0800, hch@infradead.org wrote:
> On Tue, Jan 04, 2022 at 12:22:15PM +1100, Dave Chinner wrote:
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1098,6 +1098,15 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
> >  		return false;
> >  	if (ioend->io_offset + ioend->io_size != next->io_offset)
> >  		return false;
> > +	/*
> > +	 * Do not merge physically discontiguous ioends. The filesystem
> > +	 * completion functions will have to iterate the physical
> > +	 * discontiguities even if we merge the ioends at a logical level, so
> > +	 * we don't gain anything by merging physical discontiguities here.
> > +	 */
> > +	if (ioend->io_inline_bio.bi_iter.bi_sector + (ioend->io_size >> 9) !=
> 
> This open codes bio_end_sector()

No, it doesn't. The ioend can have chained bios or have others merged
and concatenated to the ioend->io_list, so ioend->io_size != length
of the first bio in the chain....

> > +	    next->io_inline_bio.bi_iter.bi_sector)
> 
> But more importantly I don't think just using the inline_bio makes sense
> here as the ioend can have multiple bios.  Fortunately we should always
> have the last built bio available in ->io_bio.

Except merging chains ioends and modifies the head io_size to
account for the chained ioends we add to ioend->io_list. Hence
ioend->io_bio is not the last bio in a contiguous ioend chain.

> > +		return false;
> >  	return true;
> >  }
> >  
> > @@ -1241,6 +1250,13 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
> >  		return false;
> >  	if (sector != bio_end_sector(wpc->ioend->io_bio))
> >  		return false;
> > +	/*
> > +	 * Limit ioend bio chain lengths to minimise IO completion latency. This
> > +	 * also prevents long tight loops ending page writeback on all the pages
> > +	 * in the ioend.
> > +	 */
> > +	if (wpc->ioend->io_size >= 4096 * PAGE_SIZE)
> > +		return false;
> 
> And this stops making sense with the impending additions of large folio
> support.  I think we need to count the pages/folios instead as the
> operations are once per page/folio.

Agree, but I was looking at this initially as something easy to test
and backport.

UNfortunately, we hide the ioend switching in a function that can be
called many times per page/folio and the calling function has no
real clue when ioends get switched. Hence it's much more invasive to
correctly account for size based on variable sized folios attached
to bios in an ioend compared to hard coding a simple IO size limit.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
