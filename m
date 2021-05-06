Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028D9375BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 21:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhEFTdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 15:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230375AbhEFTc6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 15:32:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 597F26103E;
        Thu,  6 May 2021 19:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620329519;
        bh=Qzu7EcQIxSaf1YHSuSRBNSpxPRDdNZPdfGRB0iLju2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/K+33N04BByZ4KdHNChVCxjpG7NbIwEVJasaX+Q+lYSNH3URU3qPBPTIDgv5Mgmd
         dyAqMFMTRGtnDFyiv/vqAU7gao9a/1qK8WSpsdZXI+toFQ5iIe10rXXOr4P5lRRrDz
         Da6QykE0j2j80SycpH0wOje8gXtOqQIS8xTkav4HxlyEAuwZ7EBdnZb17rEAE+djfT
         pJKCGle9VNX3nRuQA9Y11DAy6ht+gHgUh73oEbAstXM8lgyaZc8bYSmv0A3TKPqwdb
         WZL+Qhzy+aRg0+yr9DKpojMNlARa/Ick8uXe3NE3llLtDabm4lYUbNGql6TUZIWARq
         2WJAcJkQ6galw==
Date:   Thu, 6 May 2021 12:31:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: kick extra large ioends to completion
 workqueue
Message-ID: <20210506193158.GD8582@magnolia>
References: <20201002153357.56409-3-bfoster@redhat.com>
 <20201005152102.15797-1-bfoster@redhat.com>
 <20201006035537.GD49524@magnolia>
 <20201006124440.GA50358@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006124440.GA50358@bfoster>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 06, 2020 at 08:44:40AM -0400, Brian Foster wrote:
> On Mon, Oct 05, 2020 at 08:55:37PM -0700, Darrick J. Wong wrote:
> > On Mon, Oct 05, 2020 at 11:21:02AM -0400, Brian Foster wrote:
> > > We've had reports of soft lockup warnings in the iomap ioend
> > > completion path due to very large bios and/or bio chains. Divert any
> > > ioends with 256k or more pages to process to the workqueue so

Heh, lol, so now we're hitting this internally too.  Certain customers
are sending 580,000-page bios, which then trip the hangcheck timer when
we stall the interrupt handler while clearing all the page bits.

> > > completion occurs in non-atomic context and can reschedule to avoid
> > > soft lockup warnings.
> > 
> > Hmmmm... is there any way we can just make end_page_writeback faster?
> > 
> 
> I'm not sure that would help us. It's not doing much work as it is. The
> issue is just that we effectively queue so many of them to a single bio
> completion due to either bio chaining or the physical page merging
> implemented by multipage bvecs.
> 
> > TBH it still strikes me as odd that we'd cap ioends this way just to
> > cover for the fact that we have to poke each and every page.
> > 
> 
> I suppose, but it's not like we don't already account for constructing
> bios that must be handed off to a workqueue for completion processing.
> Also FWIW this doesn't cap ioend size like my original patch does. It
> just updates XFS to send them to the completion workqueue.

<nod> So I guess I'm saying that my resistance to /this/ part of the
changes is melting away.  For a 2GB+ write IO, I guess the extra overhead
of poking a workqueue can be amortized over the sheer number of pages.

> > (Also, those 'bool atomic' in the other patch make me kind of nervous --
> > how do we make sure (from a QA perspective) that nobody gets that wrong?)
> > 
> 
> Yeah, that's a bit ugly. If somebody has a better idea on the factoring
> I'm interested in hearing about it. My understanding is that in_atomic()
> is not reliable and/or generally frowned upon, hence the explicit
> context parameter.
> 
> Also, I don't have the error handy but my development kernel complains
> quite clearly if we make a call that can potentially sleep in atomic
> context. I believe this is the purpose of the __might_sleep()
> (CONFIG_DEBUG_ATOMIC_SLEEP) annotation.

I wonder if it's not too late to establish a new iomap rule?

All clients whose ->prepare_ioend handler overrides the default
ioend->io_bio->bi_end_io handler must call iomap_finish_ioends from
process context, because the "only" reason why a filesystem would need
to do that is because some post-write metadata update is necessary, and
those really shouldn't be running from interrupt context.

With such a rule (no idea how we'd enforce that) we could at least
constrain that in_atomic variable to buffered-io.c, since the only time
it would be unsafe to call cond_resched() is if iomap_writepage_end_bio
is in use, and it decides to call iomap_finish_ioend directly.

Right now XFS is the only filesystem that overrides the bio endio
handler, and the only time it does that is for writes that need extra
metadata updates (unwritten conversion, setfilesize, cow).

--D

> Brian
> 
> > --D
> > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > > 
> > > v2:
> > > - Fix type in macro.
> > > 
> > >  fs/xfs/xfs_aops.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > > index 3e061ea99922..c00cc0624986 100644
> > > --- a/fs/xfs/xfs_aops.c
> > > +++ b/fs/xfs/xfs_aops.c
> > > @@ -30,6 +30,13 @@ XFS_WPC(struct iomap_writepage_ctx *ctx)
> > >  	return container_of(ctx, struct xfs_writepage_ctx, ctx);
> > >  }
> > >  
> > > +/*
> > > + * Kick extra large ioends off to the workqueue. Completion will process a lot
> > > + * of pages for a large bio or bio chain and a non-atomic context is required to
> > > + * reschedule and avoid soft lockup warnings.
> > > + */
> > > +#define XFS_LARGE_IOEND	(262144ULL << PAGE_SHIFT)
> > > +
> > >  /*
> > >   * Fast and loose check if this write could update the on-disk inode size.
> > >   */
> > > @@ -239,7 +246,8 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
> > >  {
> > >  	return ioend->io_private ||
> > >  		ioend->io_type == IOMAP_UNWRITTEN ||
> > > -		(ioend->io_flags & IOMAP_F_SHARED);
> > > +		(ioend->io_flags & IOMAP_F_SHARED) ||
> > > +		(ioend->io_size >= XFS_LARGE_IOEND);
> > >  }
> > >  
> > >  STATIC void
> > > -- 
> > > 2.25.4
> > > 
> > 
> 
