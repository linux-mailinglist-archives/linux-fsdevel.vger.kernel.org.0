Return-Path: <linux-fsdevel+bounces-36864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4709EA03E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 21:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7382016652F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 20:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74E81993BD;
	Mon,  9 Dec 2024 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bDvXITxW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055E137930
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776061; cv=none; b=FNGXTKS/Wg3jPgfTzychBWAY4kmAHFLXVNZZQSCjY5iC3c1L5UYcdlTyB9xSMIVOBAbIDUDdKRGzilOm1uBO4fEuycYL442B6e6QK3MdGRsgCTrEIgwgn3mnUOV1GEUkqdivztmvyZvRIoeWldBlI05MWg0nTcnMnS2fA5L3BNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776061; c=relaxed/simple;
	bh=PifocyfzOg7jQs4ZEJjXsJp38rDuKrS8V8TYCDhvk0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXEglgH74rBodilBI1JUBFB+AenOKUjJa/u9IurTRxfeMDcg8t1J6j11YK+oNOZuCwdLeFyFgUvVAO6Ie+53bxYT021O7rjuB66qyZRfViMLnGWRd8+P6dkE5E/ttrx71cki2BmfERNf/CQ7+L1eUM19ZNP1IBDOldjrxsFA0ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bDvXITxW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AVm6hZuE0NcAYBQ/uiyX0TZXpt5kwQI7d8ka7/lH0NY=; b=bDvXITxWL0gEuyRGQE8eTw0Ws4
	OIZ4Mj29XB6WEN2z88w5KHdsWD2poQKtbc5TvPWQ1xRMqnnaDas5wRKKC3bwSqc4fmpos/zzKkA7k
	gA+6ZwQJTIntV1b1pbcKpxKkoy50gB65FNVgnbvE9mH4vn12FbMimgvIatbLdJCfLFnzPD0nQIC6E
	h/gkQYE7M9ycXrd576egiBq/AICI6ZNo2aJ6tBFz0Zmdy0vJnoOAb0PzDS7f5ENUcncRPKbvICvQy
	ZpwAyQbn7A3Ub3GY9fXuV3DgU0IBKL4mIYFII3TuckqBVxHOdIWLzzCXfc6xbnltnmhdr6+tvNKbd
	VNGVerKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKkLw-00000006fB5-2F9w;
	Mon, 09 Dec 2024 20:27:36 +0000
Date: Mon, 9 Dec 2024 20:27:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <20241209202736.GZ3387508@ZenIV>
References: <20241209035251.GV3387508@ZenIV>
 <CAHk-=whnCrFZ+id8E3Y0uXVDyT4Kbu6pLdPgL42LYTNPdYDVpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whnCrFZ+id8E3Y0uXVDyT4Kbu6pLdPgL42LYTNPdYDVpQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 09, 2024 at 11:06:48AM -0800, Linus Torvalds wrote:
> On Sun, 8 Dec 2024 at 19:52, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > +               struct external_name *p;
> > +               p = container_of(name->name.name, struct external_name, name[0]);
> > +               // get a valid reference
> > +               if (unlikely(!atomic_inc_not_zero(&p->u.count)))
> > +                       goto retry;
> 
> Oh - this is very much *not* safe.
> 
> The other comment I had was really about "that's bad for performance".
> But this is actually actively buggy.
> 
> If the external name ref has gone down to zero, we can *not* do that
> 
>     atomic_inc_not_zero(..)
> 
> thing any more, because the recount is in a union with the rcu_head
> for delaying the free.

D'oh.  Right you are; missed it...

> In other words: the *name* will exist for the duration of the
> rcu_read_lock() we hold, but that "p->u.count" will not. When the
> refcount has gone to zero, the refcount is no longer usable.
> 
> IOW, you may be happily incrementing what is now a RCU list head
> rather than a count.
> 
> So NAK. This cannot work.
>
> It's probably easily fixable by just not using a union in struct
> external_name, and just having separate fields for the refcount and
> the rcu_head, but in the current state your patch is fundamentally and
> dangerously buggy.

Agreed.  And yes, separating the fields (and slapping a comment explaining
why they can not be combined) would be the easiest solution - any attempts
to be clever here would be too brittle for no good reason.

