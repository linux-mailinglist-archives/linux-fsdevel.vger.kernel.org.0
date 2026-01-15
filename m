Return-Path: <linux-fsdevel+bounces-73930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B016FD255B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F5C30CDE70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F673399A5C;
	Thu, 15 Jan 2026 15:25:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13693A9018;
	Thu, 15 Jan 2026 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490743; cv=none; b=Wat1LU1/bIWXz1ASLXUH41kuup78fKfbYvVyMPu/dJSwfVoBfTKRdg/hlBN2bB5zR+HaTJuMkopyOqrwCKCYm3B8qRj2dvemt9mPwJ8A+1ZEKVLtE/oOYsTzWPJwIaV/eZqB9ifdLJBTsfWyzHMzGWZ5iIaz+xoRAj4v3JSde2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490743; c=relaxed/simple;
	bh=4sLim5u98wNN+/Q7IVcfcHIvCVrJ4ZM3mi4JkLXQlu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnDKE/DsNbtRMefThICeEXC97evxwiUcCNs4tKSvG7jfVj0r9A7k7XsoSTrRV8pqRwLKIoeV9XVbVhYxetQeGbEZC85QvKUje5FcRN1N4NkKgL4AILaHFpy4hB47e3+SawnHeDJO24kfWF2AZpu0cOZrBvBYU5X7W5yiJObxkfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 0013EE0905;
	Thu, 15 Jan 2026 16:25:32 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 15 Jan 2026 16:25:32 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v4 3/3] fuse: add an implementation of open+getattr
Message-ID: <aWkEWEgerlDv0bt6@fedora>
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
 <20260109-fuse-compounds-upstream-v4-3-0d3b82a4666f@ddn.com>
 <CAJnrk1ZtS4VfYo03UFO_khcaA6ugHiwtWQqaObB5P_ozFtsCHA@mail.gmail.com>
 <aWjteRMwc_KIN4pt@fedora.fritz.box>
 <3223f464-9f76-4c37-b62b-f61f6b1fc1f6@bsbernd.com>
 <aWju_kqgdiOZt8gn@fedora.fritz.box>
 <87wm1i52si.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wm1i52si.fsf@wotan.olymp>

Hi Luis,

thanks for looking at this.

On Thu, Jan 15, 2026 at 03:11:25PM +0000, Luis Henriques wrote:
> On Thu, Jan 15 2026, Horst Birthelmer wrote:
> 
> > On Thu, Jan 15, 2026 at 02:41:49PM +0100, Bernd Schubert wrote:
> >> 
> >> 
> >> On 1/15/26 14:38, Horst Birthelmer wrote:
> >> > On Wed, Jan 14, 2026 at 06:29:26PM -0800, Joanne Koong wrote:
> >> >> On Fri, Jan 9, 2026 at 10:27 AM Horst Birthelmer <horst@birthelmer.com> wrote:
> >> >>>
> >> >>> +
> >> >>> +       err = fuse_compound_send(compound);
> >> >>> +       if (err)
> >> >>> +               goto out;
> >> >>> +
> >> >>> +       err = fuse_compound_get_error(compound, 0);
> >> >>> +       if (err)
> >> >>> +               goto out;
> >> >>> +
> >> >>> +       err = fuse_compound_get_error(compound, 1);
> >> >>> +       if (err)
> >> >>> +               goto out;
> >> >>
> >> >> Hmm, if the open succeeds but the getattr fails, why not process it
> >> >> kernel-side as a success for the open? Especially since on the server
> >> >> side, libfuse will disassemble the compound request into separate
> >> >> ones, so the server has no idea the open is even part of a compound.
> >> >>
> >> >> I haven't looked at the rest of the patch yet but this caught my
> >> >> attention when i was looking at how fuse_compound_get_error() gets
> >> >> used.
> >> >>
> >> > After looking at this again ...
> >> > Do you think it would make sense to add an example of lookup+create, or would that just convolute things?
> >> 
> >> 
> >> I think that will be needed with the LOOKUP_HANDLE from Luis, if we go
> >> the way Miklos proposes. To keep things simple, maybe not right now?
> >
> > I was thinking more along the lines of ... we would have more than one example
> > especially for the error handling. Otherwise it is easy to miss something
> > because the given example just doesn't need that special case.
> > Like the case above. There we would be perfectly fine with a function returning
> > the first error, which in the case of lookup+create is the opposite of success
> > and you would need to access every single error to check what actually happened.
> 
> Not sure if I can add a lot to this discussion, but I've been playing a
> bit with your patchset.
You already do ;-)

> 
> I was trying to understand how to implement the LOOKUP_HANDLE+STATX, and
> it doesn't look too difficult at the moment.  But I guess it'll take me some
> more time to figure out all the other unknowns (e.g. other operations such
> as readdirplus).
> 
> Anyway, the interface for compound operations seem to be quite usable in
> general.  I'll try to do a proper review soon, but regarding the specific
> comment of error handling, I find the interface a bit clumsy.  Have you
> thought about using something like an iterator?  Or maybe some sort of
> macro such as foreach_compound_error()?
Not in those terms, no.
But I don't think it would get any better. Do you have an idea you would want implemented in this context?

> 
> And regarding the error handling in general: it sounds like things can
> become really complex when some operations within a compound operation may
> succeed and others fail.  Because these examples are using two operations
> only, but there's nothing preventing us from having 3 or more in the
> future, right?  Wouldn't it be easier to have the compound operation
> itself fail or succeed, instead of each op?  (Although that would probably
> simply move the complexity into user-space, that would be required to do
> more clean-up work when there are failures.)

I think we need all the granularity we can get since different combinations mean different things in different contexts.
Imagine you have a compound as the current example. That is pretty much all or nothing and there is almost no way that one of the operations doesn't succeed, and if it goes wrong you can still fall back to separate operations.
There are certainly cases where the compound itself is the operation because it really has to be atomic, or for arguments sake they have to be started concurrently ... or whatnot.


> 
> Cheers,
> -- 
> Luís

Thanks,
Horst

