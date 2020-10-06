Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE46284BE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 14:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgJFMor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 08:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbgJFMor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601988285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lioyiK8xjC0fOm4WWDInz8tqPP/NCfGvAyNyJiaFTe4=;
        b=MXOlvgBOgkrkQ1u8zZlyqM3jNh6M/oYx3lwxlnfixib0oNSVgUzQwU7LNkO066pnU8akE7
        CG1OX4VECfSF4XDaemcxe8oTEHLICytDKE0+wqUroVreKqlR7xHT8KC82q+6FCg9VE+fut
        PAL1O2i5ihTobjMy1iqGlMiWg0uFzgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-Dt7HI9lqN7extXnoOeL94A-1; Tue, 06 Oct 2020 08:44:43 -0400
X-MC-Unique: Dt7HI9lqN7extXnoOeL94A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DF8A804001;
        Tue,  6 Oct 2020 12:44:42 +0000 (UTC)
Received: from bfoster (ovpn-112-249.rdu2.redhat.com [10.10.112.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BC8F5D9CD;
        Tue,  6 Oct 2020 12:44:42 +0000 (UTC)
Date:   Tue, 6 Oct 2020 08:44:40 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: kick extra large ioends to completion
 workqueue
Message-ID: <20201006124440.GA50358@bfoster>
References: <20201002153357.56409-3-bfoster@redhat.com>
 <20201005152102.15797-1-bfoster@redhat.com>
 <20201006035537.GD49524@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006035537.GD49524@magnolia>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 05, 2020 at 08:55:37PM -0700, Darrick J. Wong wrote:
> On Mon, Oct 05, 2020 at 11:21:02AM -0400, Brian Foster wrote:
> > We've had reports of soft lockup warnings in the iomap ioend
> > completion path due to very large bios and/or bio chains. Divert any
> > ioends with 256k or more pages to process to the workqueue so
> > completion occurs in non-atomic context and can reschedule to avoid
> > soft lockup warnings.
> 
> Hmmmm... is there any way we can just make end_page_writeback faster?
> 

I'm not sure that would help us. It's not doing much work as it is. The
issue is just that we effectively queue so many of them to a single bio
completion due to either bio chaining or the physical page merging
implemented by multipage bvecs.

> TBH it still strikes me as odd that we'd cap ioends this way just to
> cover for the fact that we have to poke each and every page.
> 

I suppose, but it's not like we don't already account for constructing
bios that must be handed off to a workqueue for completion processing.
Also FWIW this doesn't cap ioend size like my original patch does. It
just updates XFS to send them to the completion workqueue.

> (Also, those 'bool atomic' in the other patch make me kind of nervous --
> how do we make sure (from a QA perspective) that nobody gets that wrong?)
> 

Yeah, that's a bit ugly. If somebody has a better idea on the factoring
I'm interested in hearing about it. My understanding is that in_atomic()
is not reliable and/or generally frowned upon, hence the explicit
context parameter.

Also, I don't have the error handy but my development kernel complains
quite clearly if we make a call that can potentially sleep in atomic
context. I believe this is the purpose of the __might_sleep()
(CONFIG_DEBUG_ATOMIC_SLEEP) annotation.

Brian

> --D
> 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > v2:
> > - Fix type in macro.
> > 
> >  fs/xfs/xfs_aops.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > index 3e061ea99922..c00cc0624986 100644
> > --- a/fs/xfs/xfs_aops.c
> > +++ b/fs/xfs/xfs_aops.c
> > @@ -30,6 +30,13 @@ XFS_WPC(struct iomap_writepage_ctx *ctx)
> >  	return container_of(ctx, struct xfs_writepage_ctx, ctx);
> >  }
> >  
> > +/*
> > + * Kick extra large ioends off to the workqueue. Completion will process a lot
> > + * of pages for a large bio or bio chain and a non-atomic context is required to
> > + * reschedule and avoid soft lockup warnings.
> > + */
> > +#define XFS_LARGE_IOEND	(262144ULL << PAGE_SHIFT)
> > +
> >  /*
> >   * Fast and loose check if this write could update the on-disk inode size.
> >   */
> > @@ -239,7 +246,8 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
> >  {
> >  	return ioend->io_private ||
> >  		ioend->io_type == IOMAP_UNWRITTEN ||
> > -		(ioend->io_flags & IOMAP_F_SHARED);
> > +		(ioend->io_flags & IOMAP_F_SHARED) ||
> > +		(ioend->io_size >= XFS_LARGE_IOEND);
> >  }
> >  
> >  STATIC void
> > -- 
> > 2.25.4
> > 
> 

