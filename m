Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525C538E61C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 14:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhEXMDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 08:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232476AbhEXMDv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 08:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621857743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbvaV+DM5yQpwPh803YCQ/Bi/4BeS4L0C8m8goZzVO4=;
        b=OHAlzZI3jiXJh0CTS7OZTXNdIFjzueL68wdgjvy6cXKZSZq7UbFFaYe4Z/+jca+7Pfp/QL
        kqnd13eXYL+3oNvd9opSOjw2G8w6gTAz2VhIzkTbWamOl9OpsHIK/UVz2+MffmsOWvUQ1i
        p0R4Iz2geMu0B7O4L0nrg0HGXJsF08c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-oin5NdEpP3uUGjnxcNiz9g-1; Mon, 24 May 2021 08:02:21 -0400
X-MC-Unique: oin5NdEpP3uUGjnxcNiz9g-1
Received: by mail-qk1-f200.google.com with SMTP id a24-20020a05620a1038b02902fa6ba180ffso26614427qkk.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 05:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mbvaV+DM5yQpwPh803YCQ/Bi/4BeS4L0C8m8goZzVO4=;
        b=XeQ2PyAP1uSSm5kK9xWxlhdRNW13mT9pjvmXU/ghwzFcDzeKwD58YsazuSrwTfYAXv
         vycPKYQQFmR445fGdQSGgTo8/rMya03hnA0XJMP5fPW5AaDAVL4h4v0DMI3iIhZVAwkN
         5JusKxu6fwTRhjdInxwdKCIdlh9Rwr5jZeE8/GZ8yfEjpRk26n1CUz9QO1+6fcaOhFzO
         pyRIJ+mzHUzFQGq3xbIkT14zlTkQ1xbC98N8f1PB16fN4VModJFY6EY19mWFgbNm2qua
         QdMqbbakPWlNy1AMo9Sr2cqKC0dapXMl7QVyk8Bt74p1YH3AL8KpSpi6p1svo6LP2uUK
         FHhA==
X-Gm-Message-State: AOAM533Xk3ilvu/z12/XHwcXlw7Rqdl8iEDG5AVWkFxoVzRIJZunWynX
        oq8A8sx/LwTylrOlN3aUnxfpuVPRixUVRCd0XS/0dMUM/yVrCRuHja8nv9U+9PyP6uATeqOfQ85
        Am7JYpPqqsOcFGLBEfU31v9/qGw==
X-Received: by 2002:ac8:5e51:: with SMTP id i17mr27141944qtx.263.1621857740761;
        Mon, 24 May 2021 05:02:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAVxDX/X8pDEq02HtwBhR40JScjEwwWGB6Il50ytduOzRd/Dh/uOmJ0KdmX6D3AeW9In2V1w==
X-Received: by 2002:ac8:5e51:: with SMTP id i17mr27141922qtx.263.1621857740510;
        Mon, 24 May 2021 05:02:20 -0700 (PDT)
Received: from bfoster ([98.216.211.229])
        by smtp.gmail.com with ESMTPSA id r23sm1353881qtc.32.2021.05.24.05.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 05:02:20 -0700 (PDT)
Date:   Mon, 24 May 2021 08:02:18 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 3/3] iomap: bound ioend size to 4096 pages
Message-ID: <YKuVymtSYhrDCytP@bfoster>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-4-bfoster@redhat.com>
 <20210520232737.GA9675@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520232737.GA9675@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 04:27:37PM -0700, Darrick J. Wong wrote:
> On Mon, May 17, 2021 at 01:17:22PM -0400, Brian Foster wrote:
> > The iomap writeback infrastructure is currently able to construct
> > extremely large bio chains (tens of GBs) associated with a single
> > ioend. This consolidation provides no significant value as bio
> > chains increase beyond a reasonable minimum size. On the other hand,
> > this does hold significant numbers of pages in the writeback
> > state across an unnecessarily large number of bios because the ioend
> > is not processed for completion until the final bio in the chain
> > completes. Cap an individual ioend to a reasonable size of 4096
> > pages (16MB with 4k pages) to avoid this condition.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c |  6 ++++--
> >  include/linux/iomap.h  | 26 ++++++++++++++++++++++++++
> >  2 files changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 642422775e4e..f2890ee434d0 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1269,7 +1269,7 @@ iomap_chain_bio(struct bio *prev)
> >  
> >  static bool
> >  iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
> > -		sector_t sector)
> > +		unsigned len, sector_t sector)
> >  {
> >  	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
> >  	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
> > @@ -1280,6 +1280,8 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
> >  		return false;
> >  	if (sector != bio_end_sector(wpc->ioend->io_bio))
> >  		return false;
> > +	if (wpc->ioend->io_size + len > IOEND_MAX_IOSIZE)
> > +		return false;
> >  	return true;
> >  }
> >  
> > @@ -1297,7 +1299,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
> >  	unsigned poff = offset & (PAGE_SIZE - 1);
> >  	bool merged, same_page = false;
> >  
> > -	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
> > +	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, len, sector)) {
> >  		if (wpc->ioend)
> >  			list_add(&wpc->ioend->io_list, iolist);
> >  		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 07f3f4e69084..89b15cc236d5 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -203,6 +203,32 @@ struct iomap_ioend {
> >  	struct bio		io_inline_bio;	/* MUST BE LAST! */
> >  };
> >  
> > +/*
> > + * Maximum ioend IO size is used to prevent ioends from becoming unbound in
> > + * size. bios can reach 4GB in size if pages are contiguous, and bio chains are
> > + * effectively unbound in length. Hence the only limits on the size of the bio
> > + * chain is the contiguity of the extent on disk and the length of the run of
> > + * sequential dirty pages in the page cache. This can be tens of GBs of physical
> > + * extents and if memory is large enough, tens of millions of dirty pages.
> > + * Locking them all under writeback until the final bio in the chain is
> > + * submitted and completed locks all those pages for the legnth of time it takes
> 
> s/legnth/length/
>

Fixed.
 
> > + * to write those many, many GBs of data to storage.
> > + *
> > + * Background writeback caps any single writepages call to half the device
> > + * bandwidth to ensure fairness and prevent any one dirty inode causing
> > + * writeback starvation. fsync() and other WB_SYNC_ALL writebacks have no such
> > + * cap on wbc->nr_pages, and that's where the above massive bio chain lengths
> > + * come from. We want large IOs to reach the storage, but we need to limit
> > + * completion latencies, hence we need to control the maximum IO size we
> > + * dispatch to the storage stack.
> > + *
> > + * We don't really have to care about the extra IO completion overhead here
> > + * because iomap has contiguous IO completion merging. If the device can sustain
> 
> Assuming you're referring to iomap_finish_ioends, only XFS employs the
> ioend completion merging, and only for ioends where it decides to
> override the default bi_end_io.  iomap on its own never calls
> iomap_ioend_try_merge.
> 
> This patch establishes a maximum ioend size of 4096 pages so that we
> don't trip the lockup watchdog while clearing pagewriteback and also so
> that we don't pin a large number of pages while constructing a big chain
> of bios.  On gfs2 and zonefs, each ioend completion will now have to
> clear up to 4096 pages from whatever context bio_endio is called.
> 
> For XFS it's a more complicated -- XFS already overrode the bio handler
> for ioends that required further metadata updates (e.g. unwritten
> conversion, eof extension, or cow) so that it could combine ioends when
> possible.  XFS wants to combine ioends to amortize the cost of getting
> the ILOCK and running transactions over a larger number of pages.
> 
> So I guess I see how the two changes dovetail nicely for XFS -- iomap
> issues smaller write bios, and the xfs ioend worker can recombine
> however many bios complete before the worker runs.  As a bonus, we don't
> have to worry about situations like the device driver completing so many
> bios from a single invocation of a bottom half handler that we run afoul
> of the soft lockup timer.
> 
> Is that a correct understanding of how the two changes intersect with
> each other?  TBH I was expecting the two thresholds to be closer in
> value.
> 

I think so. That's interesting because my inclination was to make them
farther apart (or more specifically, increase the threshold in this
patch and leave the previous). The primary goal of this series was to
address the soft lockup warning problem, hence the thresholds on earlier
versions started at rather conservative values. I think both values have
been reasonably justified in being reduced, though this patch has a more
broad impact than the previous in that it changes behavior for all iomap
based fs'. Of course that's something that could also be addressed with
a more dynamic tunable..

> The other two users of iomap for buffered io (gfs2 and zonefs) don't
> have a means to defer and combine ioends like xfs does.  Do you think
> they should?  I think it's still possible to trip the softlockup there.
> 

I'm not sure. We'd probably want some feedback from developers of
filesystems other than XFS before incorporating a change like this. The
first patch in the series more just provides some infrastructure for
other filesystems to avoid the problem as they see fit.

Brian

> --D
> 
> > + * high throughput and large bios, the ioends are merged on completion and
> > + * processed in large, efficient chunks with no additional IO latency.
> > + */
> > +#define IOEND_MAX_IOSIZE	(4096ULL << PAGE_SHIFT)
> > +
> >  struct iomap_writeback_ops {
> >  	/*
> >  	 * Required, maps the blocks so that writeback can be performed on
> > -- 
> > 2.26.3
> > 
> 

