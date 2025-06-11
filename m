Return-Path: <linux-fsdevel+bounces-51363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B03AD619D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 23:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE7A7A8191
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 21:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7D4248886;
	Wed, 11 Jun 2025 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTtHo4IW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C6D243968;
	Wed, 11 Jun 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677820; cv=none; b=Hn5tfJkJsvSeqvpokx/9WxJWnRIig7Zx4BaD4sU2CQzuAdZqnFauTEUT7adnViGQUwC2wV5V4vBAIL+oSXIYszROm+6iIV4e3iV4vZqNoA5emDXpoxSyCnGnYp+3IEouewRtAbEfHQybtFZNCj0tfJ7LzXBtRZfaJZDRQ7x712U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677820; c=relaxed/simple;
	bh=wYNHkDW6WpVh2Jvzbqjve2B808mF0EEubMr2DeddhIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYdzv63KKNOmKqLG9rOk11ONZJkdlVZauek4cAhK7wF343zZtkeWlr/PCCAtsRhmYFeoxOKweDWlqw9pC4TKSWCiuZWM37rxoqLV/qLp9Af05tHT9sAy7ttuLPKbLou9ScOU1ECVt1NZ1j4aGmj8UB1UcWhiTYRaeDA4ZVh6Hkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTtHo4IW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57405C4CEE3;
	Wed, 11 Jun 2025 21:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749677819;
	bh=wYNHkDW6WpVh2Jvzbqjve2B808mF0EEubMr2DeddhIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTtHo4IW38VTnQK7l0Od+IBPL2TrTr/Na/IL24hd30X4A1uug5okD8gjzaiaLoTKN
	 R/uYZDsaBBCN3OtfQyqmfNX80eqsZrga8SyiWWMrTMdtwTvnFhlqaMMt/xCn87/8jz
	 rUZTK6F/f/mSD/lW7W4/emf1wsASwS7IIgVf8OuDsRAFjHy4hEmqSNW6aTnrJ+1dQE
	 n68mET//Hb5+XpTlcvkaly7iLa/EAK28DfF1rKcIJaOlUM+HsF4uXIbxxRyTQgP7/k
	 6E1xUrrvy3rVXvj0Vzz9o0Skztv9/uB6Jr5qMRnmRt1jdpDkdycPAXpI/heKA1sicb
	 s0J1IkUHfCTPw==
Date: Wed, 11 Jun 2025 17:36:58 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH 1/6]
 NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
Message-ID: <aEn2-mYA3VDv-vB8@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>

On Wed, Jun 11, 2025 at 04:29:58PM -0400, Jeff Layton wrote:
> On Wed, 2025-06-11 at 15:18 -0400, Mike Snitzer wrote:
> > On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
> > > On 6/10/25 4:57 PM, Mike Snitzer wrote:
> > > > Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
> > > > read or written by NFSD will either not be cached (thanks to O_DIRECT)
> > > > or will be removed from the page cache upon completion (DONTCACHE).
> > > 
> > > I thought we were going to do two switches: One for reads and one for
> > > writes? I could be misremembering.
> > 
> > We did discuss the possibility of doing that.  Still can-do if that's
> > what you'd prefer.
> >  
> 
> Having them as separate controls in debugfs is fine for
> experimentation's sake, but I imagine we'll need to be all-in one way
> or the other with a real interface.
> 
> I think if we can crack the problem of receiving WRITE payloads into an
> already-aligned buffer, then that becomes much more feasible. I think
> that's a solveable problem.

You'd immediately be my hero!  Let's get into it:

In a previously reply to this thread you aptly detailed what I found
out the hard way (with too much xdr_buf code review and tracing):

On Wed, Jun 11, 2025 at 08:55:20AM -0400, Jeff Layton wrote:
> >
> > NFSD will also set RWF_DIRECT if a WRITE's IO is aligned relative to
> > DIO alignment (both page and disk alignment).  This works quite well
> > for aligned WRITE IO with SUNRPC's RDMA transport as-is, because it
> > maps the WRITE payload into aligned pages. But more work is needed to
> > be able to leverage O_DIRECT when SUNRPC's regular TCP transport is
> > used. I spent quite a bit of time analyzing the existing xdr_buf code
> > and NFSD's use of it.  Unfortunately, the WRITE payload gets stored in
> > misaligned pages such that O_DIRECT isn't possible without a copy
> > (completely defeating the point).  I'll reply to this cover letter to
> > start a subthread to discuss how best to deal with misaligned write
> > IO (by association with Hammerspace, I'm most interested in NFS v3).
> >
>
> Tricky problem. svc_tcp_recvfrom() just slurps the whole RPC into the
> rq_pages array. To get alignment right, you'd probably have to do the
> receive in a much more piecemeal way.
>
> Basically, you'd need to decode as you receive chunks of the message,
> and look out for WRITEs, and then set it up so that their payloads are
> received with proper alignment.

1)
Yes, and while I arrived at the same exact conclusion I was left with
dread about the potential for "breaking too many eggs to make that
tasty omelette".

If you (or others) see a way forward to have SUNRPC TCP's XDR receive
"inline" decode (rather than have the 2 stage process you covered
above) that'd be fantastic.  Seems like really old tech-debt in SUNRPC
from a time when such care about alignment of WRITE payload pages was
completely off engineers' collective radar (owed to NFSD only using
buffered IO I assume?).

2)
One hack that I verified to work for READ and WRITE IO on my
particular TCP testbed was to front-pad the first "head" page of the
xdr_buf such that the WRITE payload started at the 2nd page of
rq_pages.  So that looked like this hack for my usage:

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 8fc5b2b2d806..cf082a265261 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -676,7 +676,9 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)

        /* Make arg->head point to first page and arg->pages point to rest */
        arg->head[0].iov_base = page_address(rqstp->rq_pages[0]);
-       arg->head[0].iov_len = PAGE_SIZE;
+       // FIXME: front-pad optimized to align TCP's WRITE payload
+       // but may not be enough for other operations?
+       arg->head[0].iov_len = 148;
        arg->pages = rqstp->rq_pages + 1;
        arg->page_base = 0;
        /* save at least one page for response */

That gut "but may not be enough for other operations?" comment proved
to be prophetic.

Sadly it went on to fail spectacularly for other ops (specifically
READDIR and READDIRPLUS, probably others would too) because
xdr_inline_decode() _really_ doesn't like going beyond the end of the
xdr_buf's inline "head" page.  It could be that even if
xdr_inline_decode() et al was "fixed" (which isn't for the faint of
heart given xdr_buf's more complex nature) there will likely be other
mole(s) that pop up.  And in addition, we'd be wasting space in the
xdr_buf's head page (PAGE_SIZE-frontpad).  So I moved on from trying
to see this frontpad hack through to completion.

3)
Lastly, for completeness, I also mentioned briefly in a previous
recent reply:

On Wed, Jun 11, 2025 at 04:51:03PM -0400, Mike Snitzer wrote:
> On Wed, Jun 11, 2025 at 11:44:29AM -0400, Jeff Layton wrote:
>
> > In any case, for now at least, unless you're using RDMA, it's going to
> > end up falling back to buffered writes everywhere. The data is almost
> > never going to be properly aligned coming in off the wire. That might
> > be fixable though.
>
> Ben Coddington mentioned to me that soft-iwarp would allow use of RDMA
> over TCP to workaround SUNRPC TCP's XDR handling always storing the
> write payload in misaligned IO.  But that's purely a stop-gap
> workaround, which needs testing (to see if soft-iwap negates the win
> of using O_DIRECT, etc).

(Ab)using soft-iwarp as the basis for easily getting page aligned TCP
WRITE payloads seems pretty gross given we are chasing utmost
performance, etc.

All said, I welcome your sage advice and help on this effort to
DIO-align SUNRPC TCP's WRITE payload pages.

Thanks,
Mike

