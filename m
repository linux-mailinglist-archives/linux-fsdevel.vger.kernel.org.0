Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71D13766C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbhEGOHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 10:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233903AbhEGOHg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 10:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620396396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0yxuYRlP3+iPt7uZ1NnSJh0bsPRY20POyt9MhGs9mU=;
        b=AUrsscyeAOd4wWGxOMe6A1M3xJp5D1VwICyEMFAnmwb6SJ9WWQ/Nl5GQBKgIEIrxbruYh9
        G9r6Rtvkw8m01GP5D+MxJjx5RTWXoFev0SqLirKE6a08FIF+iELzhmOvF3jL6v7hqH6AZi
        s5ETv17Nd5XrBBoCPZsURJPrz4mEKZQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-XjDIE0smNP-8HOQ3lKc3Kg-1; Fri, 07 May 2021 10:06:34 -0400
X-MC-Unique: XjDIE0smNP-8HOQ3lKc3Kg-1
Received: by mail-qv1-f72.google.com with SMTP id f20-20020a0caa940000b02901c5058e5813so6667068qvb.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 07:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H0yxuYRlP3+iPt7uZ1NnSJh0bsPRY20POyt9MhGs9mU=;
        b=DeQKBtTe1g7uuGqdxLE5IF5MKOpkZbl6hstMofdJ/5yU4/3pLvPED6Y7e/I2Qf2jgX
         0XuSCyvA6N/LErhlAvyR8pImpTXebkPuNiV5L7WXt26OdEIJAp2S5wr39P9xLrC9HcMI
         Mg5wiw7dwqU8w+B1FdsdwYE6Qd/4AycqizNn4uhGlhkku4c2obLShwNvDPsduRifo220
         JCtZKo59nzt5DiB7Sss+oVbWcRubPcG7VEVJgBoRQI0qq1/xVVKh9WFE8Wm9hMRNFBkT
         xQ3po9i9TYT4P2mIT05OuoZOTneY1rYPGsOOYJveUiJOB2YoRrEXHiLvsNEnjwYCqhZQ
         GR4w==
X-Gm-Message-State: AOAM530K4MlUG5Rka1SEckL7CLOzLuHIPYvQezzugryM5RuB5SFk85sM
        pLmvstiqwf34XKWAssmOjXF1aB5PPgmD/OSRLED4AJGHWMsnpjY0stNx3dR/VW9A8sFDsUJ3kmj
        Zku+uGaNvLzg2j1BQ9Canxu/2KQ==
X-Received: by 2002:a37:7906:: with SMTP id u6mr9648059qkc.225.1620396394050;
        Fri, 07 May 2021 07:06:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx48YET6vi+LZAMlwiDbV06UePLTLFCXrP277hebn5XPcDNUyZLbSqjm4VhCN0FdxENPy6f9w==
X-Received: by 2002:a37:7906:: with SMTP id u6mr9648028qkc.225.1620396393800;
        Fri, 07 May 2021 07:06:33 -0700 (PDT)
Received: from bfoster ([98.216.211.229])
        by smtp.gmail.com with ESMTPSA id w196sm4671399qkb.90.2021.05.07.07.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 07:06:33 -0700 (PDT)
Date:   Fri, 7 May 2021 10:06:31 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: kick extra large ioends to completion
 workqueue
Message-ID: <YJVJZzld5ucxnlAH@bfoster>
References: <20201002153357.56409-3-bfoster@redhat.com>
 <20201005152102.15797-1-bfoster@redhat.com>
 <20201006035537.GD49524@magnolia>
 <20201006124440.GA50358@bfoster>
 <20210506193158.GD8582@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506193158.GD8582@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 06, 2021 at 12:31:58PM -0700, Darrick J. Wong wrote:
> On Tue, Oct 06, 2020 at 08:44:40AM -0400, Brian Foster wrote:
> > On Mon, Oct 05, 2020 at 08:55:37PM -0700, Darrick J. Wong wrote:
> > > On Mon, Oct 05, 2020 at 11:21:02AM -0400, Brian Foster wrote:
> > > > We've had reports of soft lockup warnings in the iomap ioend
> > > > completion path due to very large bios and/or bio chains. Divert any
> > > > ioends with 256k or more pages to process to the workqueue so
> 
> Heh, lol, so now we're hitting this internally too.  Certain customers
> are sending 580,000-page bios, which then trip the hangcheck timer when
> we stall the interrupt handler while clearing all the page bits.
> 

Yep, sounds about right. :P

> > > > completion occurs in non-atomic context and can reschedule to avoid
> > > > soft lockup warnings.
> > > 
> > > Hmmmm... is there any way we can just make end_page_writeback faster?
> > > 
> > 
> > I'm not sure that would help us. It's not doing much work as it is. The
> > issue is just that we effectively queue so many of them to a single bio
> > completion due to either bio chaining or the physical page merging
> > implemented by multipage bvecs.
> > 
> > > TBH it still strikes me as odd that we'd cap ioends this way just to
> > > cover for the fact that we have to poke each and every page.
> > > 
> > 
> > I suppose, but it's not like we don't already account for constructing
> > bios that must be handed off to a workqueue for completion processing.
> > Also FWIW this doesn't cap ioend size like my original patch does. It
> > just updates XFS to send them to the completion workqueue.
> 
> <nod> So I guess I'm saying that my resistance to /this/ part of the
> changes is melting away.  For a 2GB+ write IO, I guess the extra overhead
> of poking a workqueue can be amortized over the sheer number of pages.
> 

I think the main question is what is a suitable size threshold to kick
an ioend over to the workqueue? Looking back, I think this patch just
picked 256k randomly to propose the idea. ISTM there could be a
potentially large window from the point where I/O latency starts to
dominate (over the extra context switch for wq processing) and where the
softlockup warning thing will eventually trigger due to having too many
pages. I think that means we could probably use a more conservative
value, I'm just not sure what value should be (10MB, 100MB, 1GB?). If
you have a reproducer it might be interesting to experiment with that.

> > > (Also, those 'bool atomic' in the other patch make me kind of nervous --
> > > how do we make sure (from a QA perspective) that nobody gets that wrong?)
> > > 
> > 
> > Yeah, that's a bit ugly. If somebody has a better idea on the factoring
> > I'm interested in hearing about it. My understanding is that in_atomic()
> > is not reliable and/or generally frowned upon, hence the explicit
> > context parameter.
> > 
> > Also, I don't have the error handy but my development kernel complains
> > quite clearly if we make a call that can potentially sleep in atomic
> > context. I believe this is the purpose of the __might_sleep()
> > (CONFIG_DEBUG_ATOMIC_SLEEP) annotation.
> 
> I wonder if it's not too late to establish a new iomap rule?
> 
> All clients whose ->prepare_ioend handler overrides the default
> ioend->io_bio->bi_end_io handler must call iomap_finish_ioends from
> process context, because the "only" reason why a filesystem would need
> to do that is because some post-write metadata update is necessary, and
> those really shouldn't be running from interrupt context.
> 
> With such a rule (no idea how we'd enforce that) we could at least
> constrain that in_atomic variable to buffered-io.c, since the only time
> it would be unsafe to call cond_resched() is if iomap_writepage_end_bio
> is in use, and it decides to call iomap_finish_ioend directly.
> 

I'm not following if you mean to suggest to change what patch 1 does
somehow or another (it seems similar to what you're describing here) or
something else..?

Brian

> Right now XFS is the only filesystem that overrides the bio endio
> handler, and the only time it does that is for writes that need extra
> metadata updates (unwritten conversion, setfilesize, cow).
> 
> --D
> 
> > Brian
> > 
> > > --D
> > > 
> > > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > > ---
> > > > 
> > > > v2:
> > > > - Fix type in macro.
> > > > 
> > > >  fs/xfs/xfs_aops.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > > > index 3e061ea99922..c00cc0624986 100644
> > > > --- a/fs/xfs/xfs_aops.c
> > > > +++ b/fs/xfs/xfs_aops.c
> > > > @@ -30,6 +30,13 @@ XFS_WPC(struct iomap_writepage_ctx *ctx)
> > > >  	return container_of(ctx, struct xfs_writepage_ctx, ctx);
> > > >  }
> > > >  
> > > > +/*
> > > > + * Kick extra large ioends off to the workqueue. Completion will process a lot
> > > > + * of pages for a large bio or bio chain and a non-atomic context is required to
> > > > + * reschedule and avoid soft lockup warnings.
> > > > + */
> > > > +#define XFS_LARGE_IOEND	(262144ULL << PAGE_SHIFT)
> > > > +
> > > >  /*
> > > >   * Fast and loose check if this write could update the on-disk inode size.
> > > >   */
> > > > @@ -239,7 +246,8 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
> > > >  {
> > > >  	return ioend->io_private ||
> > > >  		ioend->io_type == IOMAP_UNWRITTEN ||
> > > > -		(ioend->io_flags & IOMAP_F_SHARED);
> > > > +		(ioend->io_flags & IOMAP_F_SHARED) ||
> > > > +		(ioend->io_size >= XFS_LARGE_IOEND);
> > > >  }
> > > >  
> > > >  STATIC void
> > > > -- 
> > > > 2.25.4
> > > > 
> > > 
> > 
> 

