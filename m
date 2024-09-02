Return-Path: <linux-fsdevel+bounces-28223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE87C9683A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0491C2213F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A2F1D2F6A;
	Mon,  2 Sep 2024 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t4kJaVlk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68C44C76;
	Mon,  2 Sep 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270668; cv=none; b=R8BBoKjoSdlUc8W1yr4LNXASN5K1qzASZmy1dVY3Z+XZVKl5/J4aDhSI1L0HJlSKXd0rZ6ldy1r0aoDiGJ72KTnRc4JMDrgOmGpq9sYwg3mbmbAMsZ7QxA0q59O62rWLWsJDKOFhAuNF+XwiYl34WJ30cgoYQsz/H4Yv3kP3t20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270668; c=relaxed/simple;
	bh=9tLygEonqQuh5/Rv5N0mZI5qLJAe4uxmz33mLjhIoFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXv7kChQXp4tBciOE10hYjNssYJ6ifmdWG3sB8+EO17sZqcupKa3WTVRRNfr7Uxxtnpl9xQi0E1UajniRBITokhPfu+d91NFlEyq3Y+TGoMMImHus4xvLJu5NdhnZkyaenQJpKFglinsQBsZxDXSEVhlkC9IH9AoxfLqGwLlpbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t4kJaVlk; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Sep 2024 05:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725270664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvuMnP7w3vffI0/vSAapeokE9ygqz+HaF9Aaksx9bG0=;
	b=t4kJaVlksiM0tu/pUBiVqQp9VLGLKhZPpdN7t2/SB/xvRgFXnXRsI+xDpSUxzy5vNaUjwB
	bEtiuKt04EZCy8z1mcA0Ur4IRUnUToZF2dHRiVEaI1uOxk5vOv8bdGPkTJc5R4bzFgYA8p
	E7OmBCq/V5DXQYOdk9eM0B/H2vlv3zo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
References: <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtWH3SkiIEed4NDc@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
> On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
> > On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
> > > On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
> > > [...]
> > > > But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
> > > > in the case of bugs, because that's going to be an improvement w.r.t.
> > > > system robustness, in exactly the same way we don't use BUG_ON() if it's
> > > > something that we can't guarantee won't happen in the wild - we WARN()
> > > > and try to handle the error as best we can.
> > > 
> > > We have discussed that in a different email thread. And I have to say
> > > that I am not convinced that returning NULL makes a broken code much
> > > better. Why? Because we can expect that broken NOFAIL users will not have a
> > > error checking path. Even valid NOFAIL users will not have one because
> > > they _know_ they do not have a different than retry for ever recovery
> > > path. 
> > 
> > You mean where I asked you for a link to the discussion and rationale
> > you claimed had happened? Still waiting on that
> 
> I am not your assistent to be tasked and search through lore archives.
> Find one if you need that.
> 
> Anyway, if you read the email and even tried to understand what is
> written there rather than immediately started shouting a response then
> you would have noticed I have put actual arguments here. You are free to
> disagree with them and lay down your arguments. You have decided to
> 
> [...]
> 
> > Yeah, enough of this insanity.
> 
> so I do not think you are able to do that. Again...

Michal, if you think crashing processes is an acceptable alternative to
error handling _you have no business writing kernel code_.

You have been stridently arguing for one bad idea after another, and
it's an insult to those of us who do give a shit about writing reliable
software.

You're arguing against basic precepts of kernel programming.

Get your head examined. And get the fuck out of here with this shit.

