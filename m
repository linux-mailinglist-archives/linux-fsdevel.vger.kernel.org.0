Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5409370710D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 20:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjEQSqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 14:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEQSqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 14:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603FB5BAD
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684349146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbUhmV81VjTy3RZgoWd9BaM6OjDgG414fToPJp9IL7c=;
        b=jJzOzxem29U4tH913HLS8udD+C+xEYU83XNfG7EavxMOlPzj/TUWLCkbcyhEOAbpelGlam
        Uru1thFUc+FzDwVgs0VqxwRBIn99k8rZXom1naa8H14SnhvlD/6iA1LHV/Hxevf5FMvunK
        Y+aTiC5tPkMdAnuVk1qhgjHDzCNZOmI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-Jn_r1W5GOOa0_qJuCb4Ixg-1; Wed, 17 May 2023 14:45:45 -0400
X-MC-Unique: Jn_r1W5GOOa0_qJuCb4Ixg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f3a3a276a5so6800341cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 11:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684349144; x=1686941144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbUhmV81VjTy3RZgoWd9BaM6OjDgG414fToPJp9IL7c=;
        b=jZdBzBfOdDKpKMv6DcgtuSgd7ZIUwBRA8QVrHvUuFudQ7tdiWk3g/ZdLaCgPEN2QRW
         3hQBMYA4OKL7S80mX0S2KXA0gBK80J5jVXg3k9MOVosxgf96bTKLDirRAMb7e1PDrk2W
         6I1YPr+dAFDoQ9hafYPjO/y2G3BdSrySzI3+wbu0P3I3qEl5JeOe305k8m+WO4U/FB+w
         5pBpJ+DScn7/1qw247+so4N2l8tTnOwCF5MzpCe2hn3XzOBYGIgzt9+8uGWCeHT5/O6D
         jwgVpRTlnx0GHTJNY6/TDCwCQYUN+BMvFr8ce1PrVWZC+Gqk6Av63gbOl7PB1OzgDPGP
         qf+Q==
X-Gm-Message-State: AC+VfDxMEpXDlzisDdPvESxRsOYu4cKc6aTT0daofnUQye7mjuw2uz9k
        j3E6atp7Hji4GCgAtJG5IfjfYE7k5Estypp1c8cMs4ljTFvN+Q0OuApgUfrl+No40gIoos+coDb
        bwA9snthNjOyrev6f3PUTtiMmvTv8a2/VIw==
X-Received: by 2002:a05:622a:188c:b0:3dc:fa58:97fd with SMTP id v12-20020a05622a188c00b003dcfa5897fdmr1381325qtc.25.1684349144480;
        Wed, 17 May 2023 11:45:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BjgXl3sXv3YUcTg0rpqAWOVnRR9IQQavy1XThm7hDtOesMFAkhzhmmdy/zL6B+jSoYTvHPA==
X-Received: by 2002:a05:622a:188c:b0:3dc:fa58:97fd with SMTP id v12-20020a05622a188c00b003dcfa5897fdmr1381288qtc.25.1684349144111;
        Wed, 17 May 2023 11:45:44 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id g6-20020a05620a13c600b0075772c756e0sm817009qkl.101.2023.05.17.11.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:45:43 -0700 (PDT)
Date:   Wed, 17 May 2023 14:48:12 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve
 performance
Message-ID: <ZGUhbM9uSk9loUPH@bfoster>
References: <ZGPZhMr0ZiPDxVkw@bfoster>
 <87bkij3ry0.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkij3ry0.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 08:50:39PM +0530, Ritesh Harjani wrote:
> Brian Foster <bfoster@redhat.com> writes:
> 
> > On Tue, May 16, 2023 at 08:19:31PM +0530, Ritesh Harjani wrote:
> >> Brian Foster <bfoster@redhat.com> writes:
> >>
> >> > On Mon, May 08, 2023 at 12:58:00AM +0530, Ritesh Harjani (IBM) wrote:
> >> >> When filesystem blocksize is less than folio size (either with
> >> >> mapping_large_folio_support() or with blocksize < pagesize) and when the
> >> >> folio is uptodate in pagecache, then even a byte write can cause
> >> >> an entire folio to be written to disk during writeback. This happens
> >> >> because we currently don't have a mechanism to track per-block dirty
> >> >> state within struct iomap_page. We currently only track uptodate state.
> >> >>
> >> >> This patch implements support for tracking per-block dirty state in
> >> >> iomap_page->state bitmap. This should help improve the filesystem write
> >> >> performance and help reduce write amplification.
> >> >>
> >> >> Performance testing of below fio workload reveals ~16x performance
> >> >> improvement using nvme with XFS (4k blocksize) on Power (64K pagesize)
> >> >> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
> >> >>
> >> >> 1. <test_randwrite.fio>
> >> >> [global]
> >> >> 	ioengine=psync
> >> >> 	rw=randwrite
> >> >> 	overwrite=1
> >> >> 	pre_read=1
> >> >> 	direct=0
> >> >> 	bs=4k
> >> >> 	size=1G
> >> >> 	dir=./
> >> >> 	numjobs=8
> >> >> 	fdatasync=1
> >> >> 	runtime=60
> >> >> 	iodepth=64
> >> >> 	group_reporting=1
> >> >>
> >> >> [fio-run]
> >> >>
> >> >> 2. Also our internal performance team reported that this patch improves
> >> >>    their database workload performance by around ~83% (with XFS on Power)
> >> >>
> >> >> Reported-by: Aravinda Herle <araherle@in.ibm.com>
> >> >> Reported-by: Brian Foster <bfoster@redhat.com>
> >> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> >> ---
> >> >>  fs/gfs2/aops.c         |   2 +-
> >> >>  fs/iomap/buffered-io.c | 115 ++++++++++++++++++++++++++++++++++++++---
> >> >>  fs/xfs/xfs_aops.c      |   2 +-
> >> >>  fs/zonefs/file.c       |   2 +-
> >> >>  include/linux/iomap.h  |   1 +
> >> >>  5 files changed, 112 insertions(+), 10 deletions(-)
> >> >>
> >> > ...
> >> >> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >> >> index 25f20f269214..c7f41b26280a 100644
> >> >> --- a/fs/iomap/buffered-io.c
> >> >> +++ b/fs/iomap/buffered-io.c
> >> > ...
> >> >> @@ -119,12 +169,20 @@ static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
> >> >>  	else
> >> >>  		gfp = GFP_NOFS | __GFP_NOFAIL;
> >> >>
> >> >> -	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
> >> >> +	/*
> >> >> +	 * iop->state tracks two sets of state flags when the
> >> >> +	 * filesystem block size is smaller than the folio size.
> >> >> +	 * The first state tracks per-block uptodate and the
> >> >> +	 * second tracks per-block dirty state.
> >> >> +	 */
> >> >> +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
> >> >>  		      gfp);
> >> >>  	if (iop) {
> >> >>  		spin_lock_init(&iop->state_lock);
> >> >>  		if (folio_test_uptodate(folio))
> >> >>  			iop_set_range(iop, 0, nr_blocks);
> >> >> +		if (is_dirty)
> >> >> +			iop_set_range(iop, nr_blocks, nr_blocks);
> >> >
> >> > I find the is_dirty logic here a bit confusing. AFAICT, this is
> >> > primarily to handle the case where a folio is completely overwritten, so
> >> > no iop is allocated at write time, and so then writeback needs to
> >> > allocate the iop as fully dirty to reflect that. I.e., all iop_alloc()
> >> > callers other than iomap_writepage_map() either pass the result of
> >> > folio_test_dirty() or explicitly dirty the entire range of the folio
> >> > anyways.  iomap_dirty_folio() essentially does the latter because it
> >> > needs to dirty the entire folio regardless of whether the iop already
> >> > exists or not, right?
> >>
> >> Yes.
> >>
> >> >
> >> > If so and if I'm following all of that correctly, could this complexity
> >> > be isolated to iomap_writepage_map() by simply checking for the !iop
> >> > case first, then call iop_alloc() immediately followed by
> >> > set_range_dirty() of the entire folio? Then presumably iop_alloc() could
> >> > always just dirty based on folio state with the writeback path exception
> >> > case handled explicitly. Hm?
> >> >
> >>
> >> Hi Brian,
> >>
> >> It was discussed here [1] to pass is_dirty flag at the time of iop
> >> allocation. We can do what you are essentially suggesting, but it's just
> >> extra work i.e. we will again do some calculations of blocks_per_folio,
> >> start, end and more importantly take and release iop->state_lock
> >> spinlock. Whereas with above approach we could get away with this at the
> >> time of iop allocation itself.
> >>
> >
> > Hi Ritesh,
> >
> > Isn't that extra work already occurring in iomap_dirty_folio()? I was
> > just thinking that maybe moving it to where it's apparently needed (i.e.
> > writeback) might eliminate the need for the param.
> >
> > I suppose iomap_dirty_folio() would need to call filemap_dirty_folio()
> > first to make sure iop_alloc() sees the dirty state, but maybe that
> > would also allow skipping the iop alloc if the folio was already dirty
> > (i.e. if the folio was previously dirtied by a full buffered overwite
> > for example)?
> >
> > I've appended a quick diff below (compile tested only) just to explain
> > what I mean. When doing that it also occurred to me that if we really
> > care about the separate call, we could keep the is_dirty param but do
> > the __iop_alloc() wrapper thing where iop_alloc() always passes
> > folio_test_dirty().
> 
> Sure. Brian. I guess when we got the comment, it was still in the intial
> work & I was anyway passing a from_writeback flag. Thanks for the diff,
> it does make sense to me. I will try to add that change in the next revision.
> 

Ok, though I think what I did to iomap_folio_dirty() might be wrong...
If we have a folio/iop that is already partially dirty with sub-folio
blocks, and then that folio is mapped and write faulted, we still need
to explicitly dirty the rest of the iop during the fault, right? If so,
then I guess we'd still need to keep the iop_set_range_dirty() call
there at least for that case.

Hmm.. so I suppose I could see doing that a couple different ways. One
is just to just keep it as you already have it and just drop the dirty
param. I.e.:

bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
{
        iop_alloc(mapping->host, folio, 0);
        iop_set_range_dirty(mapping->host, folio, 0, folio_size(folio));
        return filemap_dirty_folio(mapping, folio);
}

But I also wonder.. if we can skip the iop alloc on full folio buffered
overwrites, isn't that also true of mapped writes to folios that don't
already have an iop? I.e., I think what I was trying to do in the
previous diff was actually something like this:

bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
{
        iop_set_range_dirty(mapping->host, folio, 0, folio_size(folio));
        return filemap_dirty_folio(mapping, folio);
}

... which would only dirty the full iop if it already exists. Thoughts?

Brian

> >
> > BTW, I think you left off your [1] discussion reference..
> >
> 
> Sorry, my bad.
> 
> [1]: https://lore.kernel.org/linux-xfs/Y9f7cZxnXbL7x0p+@infradead.org/
> 
> >> Besides, isn't it easier this way? which as you also stated we will
> >> dirty all the blocks based on is_dirty flag, which is folio_test_dirty()
> >> except at the writeback time.
> >>
> >
> > My thinking was just that I kind of had to read through all of the
> > iop_alloc() callsites to grok the purpose of the parameter, which made
> > it seem unnecessarily confusing. But ultimately it made sense, so I
> > don't insist on changing it or anything if this approach is intentional
> > and/or preferred by others. That's just my .02 and I'll defer to your
> > preference. :)
> >
> 
> Sure Thanks!
> 
> >>
> >> >>  		folio_attach_private(folio, iop);
> >> >>  	}
> >> >>  	return iop;
> >> > ...
> >> >> @@ -561,6 +621,18 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
> > ...
> >> >
> >> > WRT to the !iop case.. I _think_ this is handled correctly here because
> >> > that means we'd handle the folio as completely dirty at writeback time.
> >> > Is that the case? If so, it might be nice to document that assumption
> >> > somewhere (here or perhaps in the writeback path).
> >> >
> >>
> >> !iop case is simply when we don't have a large folio and blocksize ==
> >>  pagesize. In that case we don't allocate any iop and simply returns
> >>  from iop_alloc().
> >> So then we just skip the loop which is only meant when we have blocks
> >> within a folio.
> >>
> >
> > Isn't it also the case that iop might be NULL at this point if the fs
> > has sub-folio blocks, but the folio was dirtied by a full overwrite of
> > the folio? Or did I misunderstand patch 4?
> >
> 
> Yes. Both of the cases. We can either have bs == ps or we can have a
> complete overwritten folio in which case we don't allocate any iop in
> iomap_writepage_map() function.
> 
> Sure. I will document that when we factor out that change in a seperate function.
> 
> > Brian
> >
> > --- 8< ---
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 92e1e1061225..89b3053e3f2d 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -155,7 +155,7 @@ static void iop_clear_range_dirty(struct folio *folio, size_t off, size_t len)
> >  }
> >
> >  static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
> > -				    unsigned int flags, bool is_dirty)
> > +				    unsigned int flags)
> >  {
> >  	struct iomap_page *iop = to_iomap_page(folio);
> >  	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> > @@ -181,7 +181,7 @@ static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
> >  		spin_lock_init(&iop->state_lock);
> >  		if (folio_test_uptodate(folio))
> >  			iop_set_range(iop, 0, nr_blocks);
> > -		if (is_dirty)
> > +		if (folio_test_dirty(folio))
> >  			iop_set_range(iop, nr_blocks, nr_blocks);
> >  		folio_attach_private(folio, iop);
> >  	}
> > @@ -326,8 +326,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
> >  	if (WARN_ON_ONCE(size > iomap->length))
> >  		return -EIO;
> >  	if (offset > 0)
> > -		iop = iop_alloc(iter->inode, folio, iter->flags,
> > -				folio_test_dirty(folio));
> > +		iop = iop_alloc(iter->inode, folio, iter->flags);
> >  	else
> >  		iop = to_iomap_page(folio);
> >
> > @@ -365,8 +364,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
> >  		return iomap_read_inline_data(iter, folio);
> >
> >  	/* zero post-eof blocks as the page may be mapped */
> > -	iop = iop_alloc(iter->inode, folio, iter->flags,
> > -			folio_test_dirty(folio));
> > +	iop = iop_alloc(iter->inode, folio, iter->flags);
> >  	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
> >  	if (plen == 0)
> >  		goto done;
> > @@ -616,13 +614,10 @@ EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
> >
> >  bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
> >  {
> > -	struct iomap_page *iop;
> > -	struct inode *inode = mapping->host;
> > -	size_t len = i_blocks_per_folio(inode, folio) << inode->i_blkbits;
> > -
> > -	iop = iop_alloc(inode, folio, 0, false);
> > -	iop_set_range_dirty(inode, folio, 0, len);
> > -	return filemap_dirty_folio(mapping, folio);
> > +	bool dirtied = filemap_dirty_folio(mapping, folio);
> > +	if (dirtied)
> > +		iop_alloc(mapping->host, folio, 0);
> > +	return dirtied;
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_dirty_folio);
> >
> > @@ -673,8 +668,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
> >  	    pos + len >= folio_pos(folio) + folio_size(folio))
> >  		return 0;
> >
> > -	iop = iop_alloc(iter->inode, folio, iter->flags,
> > -			folio_test_dirty(folio));
> > +	iop = iop_alloc(iter->inode, folio, iter->flags);
> >
> >  	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
> >  		return -EAGAIN;
> > @@ -1759,7 +1753,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  		struct writeback_control *wbc, struct inode *inode,
> >  		struct folio *folio, u64 end_pos)
> >  {
> > -	struct iomap_page *iop = iop_alloc(inode, folio, 0, true);
> > +	struct iomap_page *iop = to_iomap_page(folio);
> >  	struct iomap_ioend *ioend, *next;
> >  	unsigned len = i_blocksize(inode);
> >  	unsigned nblocks = i_blocks_per_folio(inode, folio);
> > @@ -1767,6 +1761,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  	int error = 0, count = 0, i;
> >  	LIST_HEAD(submit_list);
> >
> > +	if (!iop) {
> > +		iop = iop_alloc(inode, folio, 0);
> > +		iop_set_range_dirty(inode, folio, 0, folio_size(folio));
> > +	}
> > +
> >  	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
> >
> >  	/*
> 
> Thanks for the review!
> 
> -ritesh
> 

