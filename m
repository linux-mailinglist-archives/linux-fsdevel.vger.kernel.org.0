Return-Path: <linux-fsdevel+bounces-29680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 241F197C359
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 06:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7971F21F59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 04:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB41219470;
	Thu, 19 Sep 2024 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cYrmvAV9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834C17999;
	Thu, 19 Sep 2024 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726720580; cv=none; b=oKXVrBV4FL+7URyci+HvIM4GfOrLFyMFz0yHIdZI/V1rYb+n6AGirbn8mRffUzcn5ChwSxlrecz2AXY7/pS33pmQbREyNEGipBrIBuF/1M0JnaAau5whMQOQys90cxfqpOm6kHAcDbz/dIu/14nT/LhhowjanN5VmLT2QJ9dzRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726720580; c=relaxed/simple;
	bh=Bt5Bz3tdGO9Uuv1cU7jZDlEBVIDWHzwK5jye7n7Mpes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc3t08wmvoWzuedejJ/VJtD0cqYoPOSICXiAZ+TmLXCpWr36OM43CzTqakAIB/Wmcop3LObBa8hS5hhTJUr5HTViG4TvHykYRU+JtnVj4JoTvBzeqhMIZfEBM7h8ajUm5l/8jy1riNrcUhQqQITrxoFl9VEhgW3WZMr2re5RFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cYrmvAV9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yBIDFtJtFLiiz28ldZ89Z7XDnfs0+KKtU9f88uP3b5k=; b=cYrmvAV9dPjwaQCl4qdeehbhDV
	AkQrf7ebQb5Qa90kM3q7m66KALEh9cenOR90RYjnSm+H8k3wH0iAPARUMVAjIJ/gqS7OP+HTR+Lb6
	XZsZLQ7teaTuRbDxU/gH0MkLl+AG4WkPFXCNrwks3mRUc/BDAn70vL1Hf9fglI9Zrg+qh5lCvQFNU
	a9/N/6KyoCvmTsQm+bzmmx3xlWFGm20T1SkWAdgajPrwgI2dIDaUdxcEkyHgQLygSNKKwh+zSAjVw
	dnDTumvpRbMeie4SipEvEYm8l8Ok9fPkWgD3pd0awvdR42uvLTB99voKGzA+DaL03GK7pMnEIAS8q
	XS9Wbh7w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sr8tp-00000006aAy-0WS8;
	Thu, 19 Sep 2024 04:36:13 +0000
Date: Thu, 19 Sep 2024 05:36:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>, Chris Mason <clm@meta.com>,
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
	regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZuuqPEtIliUJejvw@casper.infradead.org>
References: <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk>

On Wed, Sep 18, 2024 at 09:38:41PM -0600, Jens Axboe wrote:
> On 9/18/24 9:12 PM, Linus Torvalds wrote:
> > On Thu, 19 Sept 2024 at 05:03, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> I think we should just do the simple one-liner of adding a
> >> "xas_reset()" to after doing xas_split_alloc() (or do it inside the
> >> xas_split_alloc()).
> > 
> > .. and obviously that should be actually *verified* to fix the issue
> > not just with the test-case that Chris and Jens have been using, but
> > on Christian's real PostgreSQL load.
> > 
> > Christian?
> > 
> > Note that the xas_reset() needs to be done after the check for errors
> > - or like Willy suggested, xas_split_alloc() needs to be re-organized.
> > 
> > So the simplest fix is probably to just add a
> > 
> >                         if (xas_error(&xas))
> >                                 goto error;
> >                 }
> > +               xas_reset(&xas);
> >                 xas_lock_irq(&xas);
> >                 xas_for_each_conflict(&xas, entry) {
> >                         old = entry;
> > 
> > in __filemap_add_folio() in mm/filemap.c
> > 
> > (The above is obviously a whitespace-damaged pseudo-patch for the
> > pre-6758c1128ceb state. I don't actually carry a stable tree around on
> > my laptop, but I hope it's clear enough what I'm rambling about)
> 
> I kicked off a quick run with this on 6.9 with my debug patch as well,
> and it still fails for me... I'll double check everything is sane. For
> reference, below is the 6.9 filemap patch.
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 30de18c4fd28..88093e2b7256 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -883,6 +883,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  		if (order > folio_order(folio))
>  			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
>  					order, gfp);
> +		xas_reset(&xas);
>  		xas_lock_irq(&xas);
>  		xas_for_each_conflict(&xas, entry) {
>  			old = entry;

My brain is still mushy, but I think there is still a problem (both with
the simple fix for 6.9 and indeed with 6.10).

For splitting a folio, we have the folio locked, so we know it's not
going anywhere.  The tree may get rearranged around it while we don't
have the xa_lock, but we're somewhat protected.

In this case we're splitting something that was, at one point, a shadow
entry.  There's no struct there to lock.  So I think we can have a
situation where we replicate 'old' (in 6.10) or xa_load() (in 6.9)
into the nodes we allocate in xas_split_alloc().  In 6.10, that's at
least guaranteed to be a shadow entry, but in 6.9, it might already be a
folio by this point because we've raced with something else also doing a
split.

Probably xas_split_alloc() needs to just do the alloc, like the name
says, and drop the 'entry' argument.  ICBW, but I think it explains
what you're seeing?  Maybe it doesn't?

