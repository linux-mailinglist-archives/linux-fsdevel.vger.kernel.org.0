Return-Path: <linux-fsdevel+bounces-28741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E78C96DB20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 16:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743A51F22065
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E0E19D063;
	Thu,  5 Sep 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hW2nI1Il"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FC19DF8B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545125; cv=none; b=HR235FmQIvk5NbME9j4KUl/qedoT4UjzleV7cFu0Om+dGdI1qwC1Mu7Y9p1xQfaCkWW4/YsrrQluwYsMNvzjPflgLO6gVuHnrdoDDuRKdjnO3nlS4d5QjHtOOhKloOiVfDiwl/AWAq1aW3p/QLcaqs7uscDGJpt/dnOg3IgOa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545125; c=relaxed/simple;
	bh=ZVg1DAg6N5h7F/0RkaxUxwzQhYejrBYDgjgdlUgE5mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkxxwIkL8nOfN3PBZF7dEcD0TMXClsGNkg6BmUZQrfM9vXVuKt+QftBXv1X0+g3a89KngGVaOHen4JSrPvrOm9nRwEb1dTIBgMuoso4JoS2CObac0kxVFo2lHtaevggLBk3LGwkNMG2tJ57ru+f0F9Fd/d7PhRHDtPIfTurmDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hW2nI1Il; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Sep 2024 10:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725545121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MyCjQthpFJhnYK6tEfReEkQ3UbH/LJW1l4f9CWgc5Fc=;
	b=hW2nI1IlY8C3UAhbNifysoKIq+TJeJoVcizmcoRH4fUejSVQruyq6fk04012lwnxvEmkah
	i6tgXPD4QgRXHbE89wQ9Oi65yCi54TneuQAxZ2EXNJMLMmiwRCniBHRBc0ZN1fsRO3obE8
	NS2TA/IPKHrlBcNkankYN8VfXh17UOY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Vlastimil Babka <vbabka@suse.cz>, 
	Dave Chinner <dchinner@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <4ty2psn26sergqax6yhcs3htt2tsg3wuvrfyvfdvseom22zhqk@yppva6vxpmjz>
References: <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
 <qlkjvxqdm72ijaaiauifgsnyzx3mw4edl2hexfabnsdncvpyhd@dvxliffsmkl6>
 <ZtgI1bKhE3imqE5s@tiehlicka>
 <xjtcom43unuubdtzj7pudew3m5yk34jdrhim5nynvoalk3bgbu@4aohsslg5c5m>
 <ZtiOyJ1vjY3OjAUv@tiehlicka>
 <pmvxqqj5e6a2hdlyscmi36rcuf4kn37ry4ofdsp4aahpw223nk@lskmdcwkjeob>
 <ZtmVej0fbVxrGPVz@tiehlicka>
 <20240905135326.GU9627@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905135326.GU9627@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 05, 2024 at 09:53:26AM GMT, Theodore Ts'o wrote:
> On Thu, Sep 05, 2024 at 01:26:50PM +0200, Michal Hocko wrote:
> > > > > > This is exactly GFP_KERNEL semantic for low order allocations or
> > > > > > kvmalloc for that matter. They simply never fail unless couple of corner
> > > > > > cases - e.g. the allocating task is an oom victim and all of the oom
> > > > > > memory reserves have been consumed. This is where we call "not possible
> > > > > > to allocate".
> > > > > 
> > > > > Which does beg the question of why GFP_NOFAIL exists.
> > > > 
> > > > Exactly for the reason that even rare failure is not acceptable and
> > > > there is no way to handle it other than keep retrying. Typical code was 
> > > > 	while (!(ptr = kmalloc()))
> > > > 		;
> > > 
> > > But is it _rare_ failure, or _no_ failure?
> > >
> > > You seem to be saying (and I just reviewed the code, it looks like
> > > you're right) that there is essentially no difference in behaviour
> > > between GFP_KERNEL and GFP_NOFAIL.
> 
> That may be the currrent state of affiars; but is it
> ****guaranteed**** forever and ever, amen, that GFP_KERNEL will never
> fail if the amount of memory allocated was lower than a particular
> multiple of the page size?  If so, what is that size?  I've checked,
> and this is not documented in the formal interface.

Yeah, and I think we really need to make that happen, in order to head
off a lot more sillyness in the future.

We'd also be documenting at the same time _exactly_ when it is required
to check for errors:
- small, fixed sized allocation in a known sleepable context, safe to skip
- anything else, i.e. variable sized allocation or library code that can
  be called from different contexts: you check for errors (and probably
  that's just "something crazy has happened, emergency shutdown" for the
  xfs/ext4 paths

> > The fundamental difference is that (appart from unsupported allocation
> > mode/size) the latter never returns NULL and you can rely on that fact.
> > Our docummentation says:
> >  * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
> >  * cannot handle allocation failures. The allocation could block
> >  * indefinitely but will never return with failure. Testing for
> >  * failure is pointless.
> 
> So if the documentation is going to give similar guarantees, as
> opposed to it being an accident of the current implementation that is
> subject to change at any time, then sure, we can probably get away
> with all or most of ext4's uses of __GFP_NOFAIL.  But I don't want to
> do that and then have a "Lucy and Charlie Brown" moment from the
> Peanuts comics strip where the football suddenly gets snatched away
> from us[1] (and many file sytem users will be very, very sad and/or
> angry).

yeah absolutely, and the "what is a small allocation" limit needs to be
nailed down as well

