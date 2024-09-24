Return-Path: <linux-fsdevel+bounces-29981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C99848F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 17:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A501F23DAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300AF1AB6F3;
	Tue, 24 Sep 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tcg08JrS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EA427735;
	Tue, 24 Sep 2024 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193525; cv=none; b=n9qExCwrgy4cjgqklxQzqNbGAn79eajg0IYSaBWKuHWRpF1E1YMv8MuHtC8CHeF9aQD/z0mX9qe4VMSSdc82rCrpb2jSLjpBFIzWtHhdnqSt5zfttdLEeHAli+7wsMgY1LrKXvB2XWW9cHWdb+6WvzkO+f9tIdqv26Aw5iDflKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193525; c=relaxed/simple;
	bh=RQYoFQKbn7eT1j543PysaUj4crr0F3CY17BnjvpHBhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XA4XdF+UlmwDPAmAHi5Axuh+yUgzJsFh/UVmuEHA9HV0hiYgxPeZtW7d4crVNxLQvJpuguG/EKPbbD8d7dMOoHZTSxgK9FV5EST2+9q2UspWj14S2Dkn9HuDnTgmnu7+e1i4il6zmKOfZFSNoBUN16ZvDPq96nB92GtgyeGg7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tcg08JrS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V69cTC5cWm2Olzjm4Q+Ede0enQBKS02QbXSespSzrzY=; b=tcg08JrSLY1o3obB4H1iG+ojAy
	iXS15zRyD0BwojJQARr5sOSMoLAsLnuu3awYoANJG4P8Rk2JJ83IqsOQWDzRjCilXHNGMDNljYpg2
	jVAFl3fpvBJAaRkvvcOVVK8D2vcShv4Ovl+yID12YPswZjmjCHfGNpCFiFxHDJoblKqRShwMzF1LT
	UIwVvqR/PI3ZFJf1GTju1QuHltJrb8CMZ332HeqsV+18ZFHE8QrucO0iBlDfqsiCALP86WKmJM0E6
	ZD8p34HmPcexSmz6U843J2MpvAjddsBjQ1ewfuywYxMC+NPIppd4XKYZrc7GDv6wCozeR5GbKPqDY
	11A2/R1w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1st7vw-00000001uiM-445t;
	Tue, 24 Sep 2024 15:58:36 +0000
Date: Tue, 24 Sep 2024 16:58:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chris Mason <clm@meta.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>,
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
	regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZvLhrF5lj3x596Qm@casper.infradead.org>
References: <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk>
 <ZuuqPEtIliUJejvw@casper.infradead.org>
 <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com>

On Fri, Sep 20, 2024 at 03:54:55PM +0200, Chris Mason wrote:
> On 9/19/24 12:36 AM, Matthew Wilcox wrote:
> > My brain is still mushy, but I think there is still a problem (both with
> > the simple fix for 6.9 and indeed with 6.10).
> > 
> > For splitting a folio, we have the folio locked, so we know it's not
> > going anywhere.  The tree may get rearranged around it while we don't
> > have the xa_lock, but we're somewhat protected.
> > 
> > In this case we're splitting something that was, at one point, a shadow
> > entry.  There's no struct there to lock.  So I think we can have a
> > situation where we replicate 'old' (in 6.10) or xa_load() (in 6.9)
> > into the nodes we allocate in xas_split_alloc().  In 6.10, that's at
> > least guaranteed to be a shadow entry, but in 6.9, it might already be a
> > folio by this point because we've raced with something else also doing a
> > split.
> > 
> > Probably xas_split_alloc() needs to just do the alloc, like the name
> > says, and drop the 'entry' argument.  ICBW, but I think it explains
> > what you're seeing?  Maybe it doesn't?
> 
> Jens and I went through a lot of iterations making the repro more
> reliable, and we were able to pretty consistently show a UAF with
> the debug code that Willy suggested:
> 
> XA_NODE_BUG_ON(xas->xa_alloc, memchr_inv(&xas->xa_alloc->slots, 0, sizeof(void *) * XA_CHUNK_SIZE));
> 
> But, I didn't really catch what Willy was saying about xas_split_alloc()
> until this morning.
> 
> xas_split_alloc() does the allocation and also shoves an entry into some of
> the slots.  When the tree changes, the entry we've stored is wildly 
> wrong, but xas_reset() doesn't undo any of that.  So when we actually
> use the xas->xa_alloc nodes we've setup, they are pointing to the
> wrong things.
> 
> Which is probably why the commits in 6.10 added this:
> 
> /* entry may have changed before we re-acquire the lock */
> if (alloced_order && (old != alloced_shadow || order != alloced_order)) {
> 	xas_destroy(&xas);
>         alloced_order = 0;
> }
> 
> The only way to undo the work done by xas_split_alloc() is to call
> xas_destroy().

I hadn't fully understood this until today.  Here's what the code in 6.9
did (grossly simplified):

        do {
                unsigned int order = xa_get_order(xas.xa, xas.xa_index);
                if (order > folio_order(folio))
                        xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
                                        order, gfp);
                xas_lock_irq(&xas);
                if (old) {
                        order = xa_get_order(xas.xa, xas.xa_index);
                        if (order > folio_order(folio)) {
                                xas_split(&xas, old, order);
                        }
                }
                xas_store(&xas, folio);
                xas_unlock_irq(&xas);
        } while (xas_nomem(&xas, gfp));

The intent was that xas_store() would use the node allocated by
xas_nomem() and xas_split() would use the nodes allocated by
xas_split_alloc().  That doesn't end up happening if the split already
happened before getting the lock.  So if we were looking for a minimal
fix for pre-6.10, calling xas_destroy if we don't call xas_split()
would fix the problem.  But I think we're better off backporting the
6.10 patches.

For 6.12, I'm going to put this in -next:

http://git.infradead.org/?p=users/willy/xarray.git;a=commitdiff;h=6684aba0780da9f505c202f27e68ee6d18c0aa66

and then send it to Linus in a couple of weeks as an "obviously correct"
bit of hardening.  We really should have called xas_reset() before
retaking the lock.

Beyond that, I really want to revisit how, when and what we split.
A few months ago we came to the realisation that splitting order-9
folios to 512 order-0 folios was just legacy thinking.  What each user
really wants is to specify a precise page and say "I want this page to
end up in a folio that is of order N" (where N is smaller than the order
of the folio that it's currently in).  That is, if we truncate a file
which is currently a multiple of 2MB in size to one which has a tail of,
say, 13377ea bytes, we'd want to create a 1MB folio which we leave at
the end of the file, then a 512kB folio which we free, then a 256kB
folio which we keep, a 128kB folio which we discard, a 64kB folio which
we discard, ...

So we need to do that first, then all this code becomes way easier and
xas_split_alloc() no longer needs to fill in the node at the wrong time.

