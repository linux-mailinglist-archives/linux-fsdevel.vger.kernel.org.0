Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D9A489E99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 18:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbiAJRpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 12:45:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28381 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238535AbiAJRpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641836706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KH1SvETr963XJ47PT0NIJyMKwpzkzjQS6lMIcgLUvOI=;
        b=IcsrmCQOVaUhMimmDdZj+/CSktmVJqpmCAQYmKtTuxdcpFb+RKrSTF5l4WVzZELY+4+WLs
        8+Jm3o5hIUmRRKZfsOc6MxDnzKHqy7bdysyc0SW2/wNQ7SQLTduia9EzuJruaQ0C9nqNXD
        kO5L8DKhw94aXyy3R/MjhtyUlxYL808=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-61DpVFcWM8qwx_7_1HbXGg-1; Mon, 10 Jan 2022 12:45:05 -0500
X-MC-Unique: 61DpVFcWM8qwx_7_1HbXGg-1
Received: by mail-qt1-f198.google.com with SMTP id p7-20020a05622a00c700b002b2f6944e7dso11338961qtw.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 09:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KH1SvETr963XJ47PT0NIJyMKwpzkzjQS6lMIcgLUvOI=;
        b=tKrh+JJ4Cz0zQH5d0QJQf3WRKRPnqb0IfUpvqQDjmkYcXqCL4uPYq4mRFgv8g9qR8f
         M9OlXiE7NvdapHvl5W/+pkNsFiQ1ckSb6MbQb8NAvmiNdBPWDem+fpKcoJa+iDt+MX/A
         RlRqnnmuwIDdd7KtNz/SohirUXAaWZh0uiL8GRU8tcINoKgsTfcPUzry1YvQzpnZtvYK
         40ZjMbIpxIHXwEWzHDRxNvbfTILJ6AtY9/jnwzTRgT/G/5hfnBI9aYAO7ZBkU1wCQWwW
         ymF4DluiK0s55Z9OQhpMOCfvDcr7qUWHRW9e2HE5IJMchYkCz/8UiCp4yaU+V5tbPDi8
         HGZA==
X-Gm-Message-State: AOAM5315W/ls+HQoBsLsrQ+/2O3RiNNemOhDfkmBFaMJ+DQ6ZGBRztnH
        +MYrBeRfdn84FKapcbELmFz63dNQ+wMOZuMrqO8ReAbYAXhJmP7NdYifHsgCGqGJBsZmKpqrjS5
        6pDHEjTW2Ikue2CD0bubebn2p3A==
X-Received: by 2002:a05:622a:1c6:: with SMTP id t6mr677956qtw.271.1641836704141;
        Mon, 10 Jan 2022 09:45:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzeQB2c3M0FFSkYCcyRGzcAT8bBP4KSdi+bh0jBbKBDeurAHnmBPj5sd6C/H+5lFabjhTA8w==
X-Received: by 2002:a05:622a:1c6:: with SMTP id t6mr677937qtw.271.1641836703822;
        Mon, 10 Jan 2022 09:45:03 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id g19sm5016531qtg.82.2022.01.10.09.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 09:45:03 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:45:01 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <YdxwnaT0nYHgGQZR@bfoster>
References: <YdSNGAupnxF/ouis@casper.infradead.org>
 <YdSOgyvDnZadYpUP@infradead.org>
 <20220104192227.GA398655@magnolia>
 <20220104215227.GJ945095@dread.disaster.area>
 <20220104231230.GG31606@magnolia>
 <20220105021022.GL945095@dread.disaster.area>
 <YdWjkW7hhbTl4TQa@bfoster>
 <20220105220421.GM945095@dread.disaster.area>
 <YdccZ4Ut3VlJhSMS@bfoster>
 <20220110081847.GW945095@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110081847.GW945095@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 10, 2022 at 07:18:47PM +1100, Dave Chinner wrote:
> On Thu, Jan 06, 2022 at 11:44:23AM -0500, Brian Foster wrote:
> > On Thu, Jan 06, 2022 at 09:04:21AM +1100, Dave Chinner wrote:
> > > On Wed, Jan 05, 2022 at 08:56:33AM -0500, Brian Foster wrote:
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 71a36ae120ee..39214577bc46 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -1066,17 +1066,34 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
> > >  	}
> > >  }
> > >  
> > > +/*
> > > + * Ioend completion routine for merged bios. This can only be called from task
> > > + * contexts as merged ioends can be of unbound length. Hence we have to break up
> > > + * the page writeback completion into manageable chunks to avoid long scheduler
> > > + * holdoffs. We aim to keep scheduler holdoffs down below 10ms so that we get
> > > + * good batch processing throughput without creating adverse scheduler latency
> > > + * conditions.
> > > + */
> > >  void
> > >  iomap_finish_ioends(struct iomap_ioend *ioend, int error)
> > >  {
> > >  	struct list_head tmp;
> > > +	int segments;
> > > +
> > > +	might_sleep();
> > >  
> > >  	list_replace_init(&ioend->io_list, &tmp);
> > > +	segments = ioend->io_segments;
> > >  	iomap_finish_ioend(ioend, error);
> > >  
> > >  	while (!list_empty(&tmp)) {
> > > +		if (segments > 32768) {
> > > +			cond_resched();
> > > +			segments = 0;
> > > +		}
> > 
> > How is this intended to address the large bi_vec scenario? AFAICT
> > bio_segments() doesn't account for multipage bvecs so the above logic
> > can allow something like 34b (?) 4k pages before a yield.
> 
> Right now the bvec segment iteration in iomap_finish_ioend() is
> completely unaware of multipage bvecs - as per above
> bio_for_each_segment_all() iterates by PAGE_SIZE within a bvec,
> regardless of whether they are stored in a multipage bvec or not.
> Hence it always iterates the entire bio a single page at a time.
> 
> IOWs, we don't use multi-page bvecs in iomap writeback, nor is it
> aware of them at all. We're adding single pages to bios via
> bio_add_page() which may merge them internally into multipage bvecs.
> However, all our iterators use single page interfaces, hence we
> don't see the internal multi-page structure of the bio at all.
> As such, bio_segments() should return the number of PAGE_SIZE pages
> attached to the bio regardless of it's internal structure.
> 

That is pretty much the point. The completion loop doesn't really care
whether the amount of page processing work is due to a large bio chain,
multipage bi_bvec(s), merged ioends, or some odd combination thereof. As
you note, these conditions can manifest from various layers above or
below iomap. I don't think iomap really needs to know or care about any
of this. It just needs to yield when it has spent "too much" time
processing pages.

With regard to the iterators, my understanding was that
bio_for_each_segment_all() walks the multipage bvecs but
bio_for_each_segment() does not, but that could certainly be wrong as I
find the iterators a bit confusing. Either way, the most recent test
with the ioend granular filter implies that a single ioend can still
become a soft lockup vector from non-atomic context.

> That is what I see on a trace from a large single file submission,
> comparing bio_segments() output from the page count on an ioend:
> 
>    kworker/u67:2-187   [017] 13530.753548: iomap_do_writepage: 2. bios 4096, pages 4096, start sector 0x370400 bi_vcnt 1, bi_size 16777216
>    kworker/u67:2-187   [017] 13530.759706: iomap_do_writepage: 2. bios 4096, pages 4096, start sector 0x378400 bi_vcnt 1, bi_size 16777216
>    kworker/u67:2-187   [017] 13530.766326: iomap_do_writepage: 2. bios 4096, pages 4096, start sector 0x380400 bi_vcnt 1, bi_size 16777216
>    kworker/u67:2-187   [017] 13530.770689: iomap_do_writepage: 2. bios 4096, pages 4096, start sector 0x388400 bi_vcnt 1, bi_size 16777216
>    kworker/u67:2-187   [017] 13530.774716: iomap_do_writepage: 2. bios 4096, pages 4096, start sector 0x390400 bi_vcnt 1, bi_size 16777216
>    kworker/u67:2-187   [017] 13530.777157: iomap_writepages: 3. bios 2048, pages 2048, start sector 0x398400 bi_vcnt 1, bi_size 8388608
> 
> Which shows we are building ioends with a single bio with a single
> bvec, containing 4096 pages and 4096 bio segments. So, as expected,
> bio_segments() matches the page count and we submit 4096 page ioends
> with a single bio attached to it.
> 
> This is clearly a case where we are getting physically contiguous
> page cache page allocation during write() syscalls, and the result
> is a single contiguous bvec from bio_add_page() doing physical page
> merging at the bvec level. Hence we see bio->bi_vcnt = 1 and a
> physically contiguous 4096 multipage bvec being dispatched. The
> lower layers slice and dice these huge bios to what the hardware can
> handle...
> 

I think we're in violent agreement here. That is the crux of multipage
bvecs and what I've been trying to point out [1]. Ming (who I believe
implemented it) pointed this out back when the problem was first
reported. This is also why I asked Trond to test out the older patch
series, because that was intended to cover this case.

[1] https://lore.kernel.org/linux-xfs/20220104192321.GF31606@magnolia/T/#mc08ffe4b619c1b503b2c1342157bdaa9823167c1

> What I'm not yet reproducing is whatever vector that Trond is seeing
> that is causing the multi-second hold-offs. I get page completion
> processed at a rate of about a million pages per second per CPU, but
> I'm bandwidth limited to about 400,000 pages per second due to
> mapping->i_pages lock contention (reclaim vs page cache
> instantiation vs writeback completion). I'm not seeing merged ioend
> batches of larger than about 40,000 pages being processed at once.
> Hence I can't yet see where the millions of pages in a single ioend
> completion that would be required to hold a CPU for tens of seconds
> is coming from yet...
> 

I was never able to reproduce the actual warning either (only construct
the unexpectedly large page sequences through various means), so I'm
equally as curious about that aspect of the problem. My only guess at
the moment is that perhaps hardware is enough of a factor to increase
the cost (i.e. slow cpu, cacheline misses, etc.)? I dunno..

> > That aside, I find the approach odd in that we calculate the segment
> > count for each bio via additional iteration (which is how bio_segments()
> > works) and track the summation of the chain in the ioend only to provide
> > iomap_finish_ioends() with a subtly inaccurate view of how much work
> > iomap_finish_ioend() is doing as the loop iterates.
> 
> I just did that so I didn't have to count pages as the bio is built.
> Easy to change - in fact I have changed it to check that
> bio_segments() was returning the page count I expected it should be
> returning....
> 
> I also changed the completion side to just count
> end_page_writeback() calls, and I get the same number of
> cond_resched() calls being made as the bio_segment. So AFAICT
> there's no change of behaviour or accounting between the two
> methods, and I'm not sure where the latest problem Trond reported
> is...
> 
> > We already have this
> > information in completion context and iomap_finish_ioends() is just a
> > small iterator function, so I don't understand why we wouldn't do
> > something like factor these two loops into a non-atomic context only
> > variant that yields based on the actual amount of page processing work
> > being done (i.e. including multipage bvecs). That seems more robust and
> > simple to me, but that's just my .02.
> 
> iomap_finish_ioends() is pretty much that non-atomic version of
> the ioend completion code. Merged ioend chains cannot be sanely
> handled in atomic context and so it has to be called from task
> context. Hence the "might_sleep()" I added to ensure that we get
> warnings if it is called from atomic contexts.
> 

We don't need to call iomap_finish_ioends() from atomic context. The
issue is the use of iomap_finish_ioend() in non-atomic context because
(if we assume atomic context usage is addressed by ioend size limits) it
can perform too much work without yielding the cpu. If we want to track
the number of pages across an arbitrary set of ioends/bios/bvecs, all we
need is something like:

iomap_finish_ioend(..., *count)
{
	for (bio = &ioend->io_inline_bio; bio; bio = next) {
		...
		bio_for_each_segment_all(bv, bio, iter_all) {
			...
			if (count && ++(*count) > MAGIC_VALUE) {
				cond_resched();
				*count = 0;
			}
		}
	}
}

iomap_finish_ioends()
{
	int count = 0;

	...

	while (...) {
		...
		iomap_finish_ioend(..., &count);
	}
}

... and you can slap a might_sleep() in either function for a sanity
check.

This doesn't require any additional counting in the submission path,
doesn't require increasing the size of the ioend, doesn't require
changes to the ioend merging code, doesn't impact non-atomic context
processing, and doesn't really impact any code outside of these couple
of functions (iomap_finish_ioend() is already static). It's also more
natural to remove if something like folios eliminates the need for it.

> As for limiting atomic context completion processing, we've
> historically done that by limiting the size of individual IO chains
> submitted during writeback. This means that atomic completion
> contexts don't need any special signalling (i.e. conditional
> "in_atomic()" behaviour) because they aren't given anything to
> process that would cause problems in atomic contexts...
> 

I've no real preference on the I/O splitting vs. queueing approach. Part
of the reason my last series implemented both is because there was
conflicting feedback. Some wanted to submit the large ioends as
constructed and complete them in wq context. Others wanted to split them
up and avoid the problem that way. Since an ioend size limit only
applied to the atomic context variant, I thought it made some sense to
break the problem down. I don't know where folks stand on these various
things atm.

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

