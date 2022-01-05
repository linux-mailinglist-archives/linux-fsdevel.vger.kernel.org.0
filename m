Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3C2485BBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 23:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245085AbiAEWes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 17:34:48 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:35146 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245076AbiAEWes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:34:48 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id EE6FD62C0C7;
        Thu,  6 Jan 2022 09:34:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n5Erk-00BnnE-GL; Thu, 06 Jan 2022 09:34:44 +1100
Date:   Thu, 6 Jan 2022 09:34:44 +1100
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
Message-ID: <20220105223444.GN945095@dread.disaster.area>
References: <Yc5f/C1I+N8MPHcd@casper.infradead.org>
 <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <YdPyhpdxykDscMtJ@infradead.org>
 <20220104211605.GI945095@dread.disaster.area>
 <YdWgmlgrCTNMsB53@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdWgmlgrCTNMsB53@infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61d61d06
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=SLVI7NbiAsdRXP7XeHoA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 05:43:54AM -0800, hch@infradead.org wrote:
> On Wed, Jan 05, 2022 at 08:16:05AM +1100, Dave Chinner wrote:
> > > > +	if (ioend->io_inline_bio.bi_iter.bi_sector + (ioend->io_size >> 9) !=
> > > 
> > > This open codes bio_end_sector()
> > 
> > No, it doesn't. The ioend can have chained bios or have others merged
> > and concatenated to the ioend->io_list, so ioend->io_size != length
> > of the first bio in the chain....
> > 
> > > > +	    next->io_inline_bio.bi_iter.bi_sector)
> > > 
> > > But more importantly I don't think just using the inline_bio makes sense
> > > here as the ioend can have multiple bios.  Fortunately we should always
> > > have the last built bio available in ->io_bio.
> > 
> > Except merging chains ioends and modifies the head io_size to
> > account for the chained ioends we add to ioend->io_list. Hence
> > ioend->io_bio is not the last bio in a contiguous ioend chain.
> 
> Indeed.  We could use bio_end_sector on io_bio or this.

Not after we merge the first two contiguous ioends:

Before first merge:

ioend.io_inline_bio.bi_sector	= X
ioend.io_size			= A
bio_end_sector(ioend.io_bio)    = X + A		<<<< correct
ioend.io_list			= <empty>

After first merge:

ioend.io_inline_bio.bi_sector	= X
ioend.io_size			= A + B
bio_end_sector(ioend.io_bio)    = X + A		<<<<<<<< wrong
ioend.io_list			= <merged ioend B,
				   bi_sector	= X + A,
				   io_size	= B,
	correct >>>>>>>		   bio_end_sector() = X + A + B>


Hence if we want to use bio_end_sector(), we've got to jump through
hoops to get to the end of the ioend->io_list to get the io_bio from
that ioend. i.e:

	if (!list_empty(ioend->io_list)) {
		struct iomap_ioend *last = list_last_entry(&ioend->io_list, ...); 

		if (bio_end_sector(last->io_bio) !=
		    next->io_inline_bio.bi_iter.bi_sector)
			return false;
	}
	return true;

That much more opaque than just using bi_sector and ioend->io_size
to directly calculate the last sector of the contiguous ioend chain.
I much prefer the simple, obvious direct ioend maths compared to
having to remember exactly how the the io_list is structured every
time I need to understand what the merging constraints are....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
