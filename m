Return-Path: <linux-fsdevel+bounces-59609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07776B3B2DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 08:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAB51C203B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 06:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA7522A4F8;
	Fri, 29 Aug 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MgFbvehJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3562222C2
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447391; cv=none; b=H4gQ1y6qJcVwyt5WmMtOoggzuuCNdmJByE5kGQcXcZ6RhkbVejWbswnISPeDGTB/092g//rfvA52c99G/EYedWyiGj56uKDhVxyvztqiTBNXBtmA1iAJhxs7oGhxWS9jTBbqDhkgDvLn1hJQFcjBRDQ53cRI46paHvivqXrOseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447391; c=relaxed/simple;
	bh=CpyJxD28q0mhm2vY99dmhh0wKurdXmjfEtmmujyeqxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6FU9D4+gXZR/qnxZK8LGdxFhjfNoWdq9mjFznz0GE3LiFH2ZnWaVxEk2QCnMPVwxm4VvlS9jGxNOTRMA5H4dZYrVO+M2JXhTUI+j6bO9Mc8N1NY6/V6pPJLPogJsPtQywY7Wcv06juyKdwT4QkgZ9JodLjW8kYohCLGxwH3bI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MgFbvehJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jpeoK/4MBU/2gzhZz/Hz+QyhT8id1Zr1Ghp9Z5s+cNA=; b=MgFbvehJNG9yAYdpeB9R5NP2yO
	rX31g0wB5fo8mTwk8WZQfByPKZ+C9v3OC8F02mvqg5cnlqq/cXNG2zgWIIM++cLscRXyQSnqljkl3
	a5fj+yD4yXKrFWxkTsN8OIczwx7pB0+8YMGXFodd52aTJcs1eggdkl5ld7fI/cyl8FComDLDwibbp
	4HVvuUFn/N6K6AdjttCk/8AY0fobpJuybnQTixILaNS4Gz/Aw+GkuyK1hhF7PR8FkJjwUlDbLv7o6
	TGKgzwOKNgmmSJ4utzjse1afhaxgDKZKLqeTvG6KlCvIUn6emJbdpjxlEyR1KKqD0edycjKFZlPf/
	CpFLz2aA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ursCY-00000002lVZ-2kU0;
	Fri, 29 Aug 2025 06:03:06 +0000
Date: Fri, 29 Aug 2025 07:03:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH v2 61/63] struct mount: relocate MNT_WRITE_HOLD bit
Message-ID: <20250829060306.GC39973@ZenIV>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 28, 2025 at 05:35:26PM -0700, Linus Torvalds wrote:
> On Thu, 28 Aug 2025 at 17:11, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > What I want to avoid is compiler seeing something like
> >         (unsigned long)READ_ONCE(m->mnt_pprev_for_sb) & 1
> > and going "that thing is a pointer to struct mount *, either the address
> > is even or it's an undefined behaviour and I can do whatever I want
> > anyway; optimize it to 0".
> 
> Have you actually seen that? Because if some compiler does this, we
> have tons of other places that will hit this, and we'll need to try to
> figure out some generic solution, or - more likely - just disable said
> compiler "optimization".

list_bl.h being an obvious victim...  OK, convinced.  No, I hadn't seen
that, and I agree that we'll get some very visible breakage if that ever
happens.

Anyway, I think I've come up with a trick that would be proof against
that kind of idiocy:
	struct mount *__aligned(1) *mnt_pprev_for_sb;

IOW, tell compiler that this member contains a pointer to a possibly
unaligned object containing a pointer to struct mount.

Since the member is declared as pointer to unaligned object, compiler
is not allowed to make any assumptions about the LSB of its value.

For any type T, we are fine with
	T __aligned(1) *p;
	...
	T *q = p;
and as long as the value of p is actually aligned, no nasal daemons should
fly.

Since we never dereference them directly ('add' doesn't dereference them
at all, 'del' copies to local struct mount ** and dereferences that), all
generated memory accesses will be aligned ones.

Since the only values we'll ever assign to that member will be addresses
of normally aligned objects, we should be fine.

Sure, __attribute__((__aligned__(...))) is not standard, but AFAICS we
should not step into any UB in a compiler implementing it...

Replacements for the 59..62 in followups (I've reordered them - easier
that way).

