Return-Path: <linux-fsdevel+bounces-52284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E24AAE10D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 03:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA32C3AD535
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 01:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED4F7FBA1;
	Fri, 20 Jun 2025 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iuEhRBEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB9CA52
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750384316; cv=none; b=DBls6Vmla3b9AxO0iGGpxgGO7ANZ9w3X6gjSlZCFD+k99BDBoWdOg9zH8TKrZR1/PpWtT3u2PttblATRhrSHngl/J9l4j5ZqAG1dgQ0ZIWOHeCbZBi6pdTYWdNckwpW14J8FED0AHeF6PXdYaCOlJdGdxWUO1HA8SllgB472dAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750384316; c=relaxed/simple;
	bh=ppaOq2L7Bv4b8aWinnrXOmddG/0jCPB5B87Z4oUiAlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkfFjwTKBxyHzVnyCH8qPzos9CzODk7dvr20xcumQMyYlD8UmwfobdFuwWgKNcsQrlTbVoj95nWLUIJKXebPDr05mWYkIdZ8DYDpXuoKUH3IkPFET9j7fTD/654LKdbSl/qYj515vLMQgQ97v/CDMXX8fyG7PeMDS3rsO3wJCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iuEhRBEI; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 19 Jun 2025 21:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750384311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/zw5DBz4TZsHz5LLDF++yx1xMq2LHRMhz7o0BGjg6o0=;
	b=iuEhRBEIFtwEWR2y2SUxU2oLMU/GLPvODYhMK3ZQgcgdymKTBn9Z4eFmX837siVlTlhjWy
	LRKTt+7o5V9aVolVB+Ud+N17X9urpD6PJ88QGBw6om1z1ooflHlGGZ67IPYo4sGxNxKFGE
	BQh/XIBME/YR8sSkg00a9qwi2qiudtA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jani Partanen <jiipee@sotapeli.fi>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
Message-ID: <ep4g2kphzkxp3gtx6rz5ncbbnmxzkp6jsg6mvfarr5unp5f47h@dmo32t3edh2c>
References: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
 <CAHk-=wi2ae794_MyuW1XJAR64RDkDLUsRHvSemuWAkO6T45=YA@mail.gmail.com>
 <lyvczhllyn5ove3ibecnacu323yv4sm5snpiwrddw7tyjxo55z@6xea7oo5yqkn>
 <06f75836-8276-428e-b128-8adffd0664ee@sotapeli.fi>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06f75836-8276-428e-b128-8adffd0664ee@sotapeli.fi>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 20, 2025 at 04:25:58AM +0300, Jani Partanen wrote:
> 
> On 20/06/2025 4.09, Kent Overstreet wrote:
> > I'm not seeing that _you_ get that.
> 
> 
> How hard it is?
> 
> New feature window for 6.16 was 2 weeks ago.
> 
> rc<insert number here> is purely for fixing bugs, not adding new features
> and potential new bugs.

That's an easy rule for the rest of the kernel, where all your mistakes
are erased at a reboot. Filesystems don't have that luxury.

In the past, I've had to rush entire new on disk format features in
response to issues I saw starting to arise - I think more than once, but
the btree bitmap in the member info section was the big one that sticks
in my mind; that one was very hectic, but 100% proved its worth.

Thankfully, we're well past that. This time, we're just talking about a
~70 line patch that just picks overwrites instead of updates from the
journal and sorts them in reverse order.

So your next question might be - why not leave that in a branch for the
users that need it until the next merge window?

For a lot of users, compiling a kernel from some random git repository
is a lot to ask. I spend a lot of time doing what amounts to support;
that's just how it is these days. But rc kernels are packaged by most
kernels, and we absolutely do not want to wait an additional 3 months
for it to show up in a release kernel -

For something that might be the difference between losing a filesystem
and getting it back.

There's also a couple patches for tracepoints and introspection
improvements; I don't know if Linus was referring to those. But those
are important too.

I think at least as much about "how do I make this codebase easy to
debug; how do I make it _practical_ to support and QA when it's running
on random user machines in the wild" as I do about the debugging itself.
That's at least as important as the debugging; making it maintainable.

Partly that's about maintaining a quick feedback cycle between myself
and the users reporting issues; that builds trust, brings people into
the community, turns into opportunities to teach them more about testing
and QA and bug reporting.

I also never cease to be amazed how often I add some bit of logging or
improve a tracepoint or some introspection - and then a week later I'm
working on something else and it's exactly the thing I need.

IOW - it's not just about fixing the bugs, it's about how we fix the
bugs.

Tools to repair, tools to debug, it's all just tools, all the way
down...

