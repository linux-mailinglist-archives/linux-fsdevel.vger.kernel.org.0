Return-Path: <linux-fsdevel+bounces-13243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADAD86DA60
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 04:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFBF28393B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 03:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931404776F;
	Fri,  1 Mar 2024 03:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w7rKO7I/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F32405DC
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 03:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709265138; cv=none; b=TQn/sB65rKA3mt+EqOxT7QyAdqlITyOUOOdtMiSVc7np4Ssh4s+oG1tpm/aW/izrmSN16c9MOw1HTMJqXF7UN492A81LDqu4oQ9lqO4EUOLeXwaaSnZvF5Rd5G0J88g9AUmcRBNUnGXcE/byTdfl1lQs9VtjL9oXcDbksaBUuQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709265138; c=relaxed/simple;
	bh=2SWTi+xAflqvLMB2dYrFNtKH4DAVVofTZcOHTx+yaf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZd4nNnQA/Ar9zlSiDrfTTCiepZfSpjCvXxUjmGQgXXDCFOh+c41IJX3RhxFm22yyapjI1MuHkfrRY+Arz8z6/PTx0xHR9YTijNr80TXJu2dKxV6Acd/RCWsxhnJD7h9wif5VrsM7h5aC8GoRaw+rERItSThK6t6oMVrjOO0eN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w7rKO7I/; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 22:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709265134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8SOwqjeFRAR/gw4wRhkSs2tEGdlSpckI3H1/1f80q8=;
	b=w7rKO7I/2sgdoN6kR9KjZZk4R44cVUT+pOC6TOo7FhnyGto8A00V4lrbMIWvDhfzruZ7aJ
	9RpG997nfOHXcwI9inBjBFvRB+uNM0cCWgHCeNqSFNOOE38LnoSauP/CRRDndNAzClECfj
	3XOzV58YotMZ96FVE+Wu7NUsnQPYoBg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Wilcox <willy@infradead.org>, NeilBrown <neilb@suse.de>, 
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <3bykct7dzcduugy6kvp7n32sao4yavgbj2oui2rpidinst2zmn@e5qti5lkq25t>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u>
 <ZeFCFGc8Gncpstd8@casper.infradead.org>
 <wpof7womk7rzsqeox63pquq7jfx4qdyb3t45tqogcvxvfvdeza@ospqr2yemjah>
 <a43cf329bcfad3c52540fe33e35e2e65b0635bfd.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a43cf329bcfad3c52540fe33e35e2e65b0635bfd.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 01, 2024 at 10:33:59AM +0700, James Bottomley wrote:
> On Thu, 2024-02-29 at 22:09 -0500, Kent Overstreet wrote:
> > Or maybe you just want the syscall to return an error instead of
> > blocking for an unbounded amount of time if userspace asks for
> > something silly.
> 
> Warn on allocation above a certain size without MAY_FAIL would seem to
> cover all those cases.  If there is a case for requiring instant
> allocation, you always have GFP_ATOMIC, and, I suppose, we could even
> do a bounded reclaim allocation where it tries for a certain time then
> fails.

Then you're baking in this weird constant into all your algorithms that
doesn't scale as machine memory sizes and working set sizes increase.

> > Honestly, relying on the OOM killer and saying that because that now
> > we don't have to write and test your error paths is a lazy cop out.
> 
> OOM Killer is the most extreme outcome.  Usually reclaim (hugely
> simplified) dumps clean cache first and tries the shrinkers then tries
> to write out dirty cache.  Only after that hasn't found anything after
> a few iterations will the oom killer get activated

All your caches dumped and the machine grinds to a halt and then a
random process gets killed instead of simply _failing the allocation_.

> > The same kind of thinking got us overcommit, where yes we got an
> > increase in efficiency, but the cost was that everyone started
> > assuming and relying on overcommit, so now it's impossible to run
> > without overcommit enabled except in highly controlled environments.
> 
> That might be true for your use case, but it certainly isn't true for a
> cheap hosting cloud using containers: overcommit is where you make your
> money, so it's absolutely standard operating procedure.  I wouldn't
> call cheap hosting a "highly controlled environment" they're just
> making a bet they won't get caught out too often.

Reading comprehension fail. Reread what I wrote.

> > And that means allocation failure as an effective signal is just
> > completely busted in userspace. If you want to write code in
> > userspace that uses as much memory as is available and no more, you
> > _can't_, because system behaviour goes to shit if you have overcommit
> > enabled or a bunch of memory gets wasted if overcommit is disabled
> > because everyone assumes that's just what you do.
> 
> OK, this seems to be specific to your use case again, because if you
> look at what the major user space processes like web browsers do, they
> allocate way over the physical memory available to them for cache and
> assume the kernel will take care of it.  Making failure a signal for
> being over the working set would cause all these applications to
> segfault almost immediately.

Again, reread what I wrote. You're restating what I wrote and completely
missing the point.

> > Let's _not_ go that route in the kernel. I have pointy sticks to
> > brandish at people who don't want to deal with properly handling
> > errors.
> 
> Error legs are the least exercised and most bug, and therefore exploit,
> prone pieces of code in C.  If we can get rid of them, we should.

Fuck no.

Having working error paths is _basic_, and learning how to test your
code is also basic. If you can't be bothered to do that you shouldn't be
writing kernel code.

We are giving far too much by going down the route of "oh, just kill
stuff if we screwed the pooch and overcommitted".

I don't fucking care if it's what the big cloud providers want because
it's convenient for them, some of us actually do care about reliability.

By just saying "oh, the OO killer will save us" what you're doing is
making it nearly impossible to fully utilize a machine without having
stuff randomly killed.

Fuck. That.

