Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31A4489327
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 09:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbiAJISz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 03:18:55 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:54987 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231458AbiAJISw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:18:52 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5569E62C1B7;
        Mon, 10 Jan 2022 19:18:49 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n6pt9-00DX9k-J0; Mon, 10 Jan 2022 19:18:47 +1100
Date:   Mon, 10 Jan 2022 19:18:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220110081847.GW945095@dread.disaster.area>
References: <YdPyhpdxykDscMtJ@infradead.org>
 <YdSNGAupnxF/ouis@casper.infradead.org>
 <YdSOgyvDnZadYpUP@infradead.org>
 <20220104192227.GA398655@magnolia>
 <20220104215227.GJ945095@dread.disaster.area>
 <20220104231230.GG31606@magnolia>
 <20220105021022.GL945095@dread.disaster.area>
 <YdWjkW7hhbTl4TQa@bfoster>
 <20220105220421.GM945095@dread.disaster.area>
 <YdccZ4Ut3VlJhSMS@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdccZ4Ut3VlJhSMS@bfoster>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61dbebea
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8
        a=thn2x24IeB6EKl0Mb6oA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 06, 2022 at 11:44:23AM -0500, Brian Foster wrote:
> On Thu, Jan 06, 2022 at 09:04:21AM +1100, Dave Chinner wrote:
> > On Wed, Jan 05, 2022 at 08:56:33AM -0500, Brian Foster wrote:
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 71a36ae120ee..39214577bc46 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1066,17 +1066,34 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
> >  	}
> >  }
> >  
> > +/*
> > + * Ioend completion routine for merged bios. This can only be called from task
> > + * contexts as merged ioends can be of unbound length. Hence we have to break up
> > + * the page writeback completion into manageable chunks to avoid long scheduler
> > + * holdoffs. We aim to keep scheduler holdoffs down below 10ms so that we get
> > + * good batch processing throughput without creating adverse scheduler latency
> > + * conditions.
> > + */
> >  void
> >  iomap_finish_ioends(struct iomap_ioend *ioend, int error)
> >  {
> >  	struct list_head tmp;
> > +	int segments;
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
> 
> How is this intended to address the large bi_vec scenario? AFAICT
> bio_segments() doesn't account for multipage bvecs so the above logic
> can allow something like 34b (?) 4k pages before a yield.

Right now the bvec segment iteration in iomap_finish_ioend() is
completely unaware of multipage bvecs - as per above
bio_for_each_segment_all() iterates by PAGE_SIZE within a bvec,
regardless of whether they are stored in a multipage bvec or not.
Hence it always iterates the entire bio a single page at a time.

IOWs, we don't use multi-page bvecs in iomap writeback, nor is it
aware of them at all. We're adding single pages to bios via
bio_add_page() which may merge them internally into multipage bvecs.
However, all our iterators use single page interfaces, hence we
don't see the internal multi-page structure of the bio at all.
As such, bio_segments() should return the number of PAGE_SIZE pages
attached to the bio regardless of it's internal structure.

That is what I see on a trace from a large single file submission,
comparing bio_segments() output from the page count on an ioend:

   kworker/u67:2-187   [017] 13530.753548: iomap_do_writepage: 2. bios 4096, pages 4096, start sector 0x370400 bi_vcnt 1, bi_size 16777216
   kworker/u67:2-187   [017] 13530.759706: iomap_do_writepage: 2. bios 4096, pages 4096, start sector 0x378400 bi_vcnt 1, bi_size 16777216
   kworker/u67:2-187   [017] 13530.766326: iomap_do_writepage: 2. bios 4096, pages 4096, start sector 0x380400 bi_vcnt 1, bi_size 16777216
   kworker/u67:2-187   [017] 13530.770689: iomap_do_writepage: 2. bios 4096, pages 4096, start sector 0x388400 bi_vcnt 1, bi_size 16777216
   kworker/u67:2-187   [017] 13530.774716: iomap_do_writepage: 2. bios 4096, pages 4096, start sector 0x390400 bi_vcnt 1, bi_size 16777216
   kworker/u67:2-187   [017] 13530.777157: iomap_writepages: 3. bios 2048, pages 2048, start sector 0x398400 bi_vcnt 1, bi_size 8388608

Which shows we are building ioends with a single bio with a single
bvec, containing 4096 pages and 4096 bio segments. So, as expected,
bio_segments() matches the page count and we submit 4096 page ioends
with a single bio attached to it.

This is clearly a case where we are getting physically contiguous
page cache page allocation during write() syscalls, and the result
is a single contiguous bvec from bio_add_page() doing physical page
merging at the bvec level. Hence we see bio->bi_vcnt = 1 and a
physically contiguous 4096 multipage bvec being dispatched. The
lower layers slice and dice these huge bios to what the hardware can
handle...

What I'm not yet reproducing is whatever vector that Trond is seeing
that is causing the multi-second hold-offs. I get page completion
processed at a rate of about a million pages per second per CPU, but
I'm bandwidth limited to about 400,000 pages per second due to
mapping->i_pages lock contention (reclaim vs page cache
instantiation vs writeback completion). I'm not seeing merged ioend
batches of larger than about 40,000 pages being processed at once.
Hence I can't yet see where the millions of pages in a single ioend
completion that would be required to hold a CPU for tens of seconds
is coming from yet...

> That aside, I find the approach odd in that we calculate the segment
> count for each bio via additional iteration (which is how bio_segments()
> works) and track the summation of the chain in the ioend only to provide
> iomap_finish_ioends() with a subtly inaccurate view of how much work
> iomap_finish_ioend() is doing as the loop iterates.

I just did that so I didn't have to count pages as the bio is built.
Easy to change - in fact I have changed it to check that
bio_segments() was returning the page count I expected it should be
returning....

I also changed the completion side to just count
end_page_writeback() calls, and I get the same number of
cond_resched() calls being made as the bio_segment. So AFAICT
there's no change of behaviour or accounting between the two
methods, and I'm not sure where the latest problem Trond reported
is...

> We already have this
> information in completion context and iomap_finish_ioends() is just a
> small iterator function, so I don't understand why we wouldn't do
> something like factor these two loops into a non-atomic context only
> variant that yields based on the actual amount of page processing work
> being done (i.e. including multipage bvecs). That seems more robust and
> simple to me, but that's just my .02.

iomap_finish_ioends() is pretty much that non-atomic version of
the ioend completion code. Merged ioend chains cannot be sanely
handled in atomic context and so it has to be called from task
context. Hence the "might_sleep()" I added to ensure that we get
warnings if it is called from atomic contexts.

As for limiting atomic context completion processing, we've
historically done that by limiting the size of individual IO chains
submitted during writeback. This means that atomic completion
contexts don't need any special signalling (i.e. conditional
"in_atomic()" behaviour) because they aren't given anything to
process that would cause problems in atomic contexts...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
