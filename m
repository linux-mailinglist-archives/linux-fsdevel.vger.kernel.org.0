Return-Path: <linux-fsdevel+bounces-13244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEAA86DA7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 05:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7901F23F8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 04:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C8147F4D;
	Fri,  1 Mar 2024 04:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fcm2Hn5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C83A8DF
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709265674; cv=none; b=UInal5I9V/4FepJ4axbV+94j4SMWsnaRD/HOn6Pgyjpp2jIJScZ3pmeAP9Wpy4NBNcGspoMixUI1f8MPNTUT3xroBAtlz/jIDFg4E76RhYJiiEJlqaFvleTlMtX7CE3zNcIoLn4Yt3gySyE/kjQ9cZCCxvfM/p1bpXlxa3aCnBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709265674; c=relaxed/simple;
	bh=siTWs4JAYy1Sa8eNBOtnHvskYqeEzwbICgWzAZw3Cho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYwStL1toqW1eXquEwvd2G+emmDczXuz37o1iXSpzHZaULgUDdvtS/tMQHnKNUGf7YfO8BQYW2UiTA9CdSpfNORt85jhOb1izQMQWRdR4kkJVAiMnx2RJ/cIpPaCnptptHrEV7/Zl1aYkD3H9HQ+aG4yQr/OOqx1TWreNQTQsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fcm2Hn5R; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 23:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709265669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k/OMy+M7U7z/nSpxCbhcdQOKxdHvlADZGMDs2NJ20Ws=;
	b=Fcm2Hn5RtSn4HKVJ5bJNp7rP3WM+rED7SBu4ZC4Ll7yyViDs2EXWAeD7rde7AH+Ga0UtjI
	rlY0KjhQfp1FXGx2PV3cKGXrmB2mzZ3lnuG2JtHq+74z0OZBKU9a0cscZjlffbD0hEi8KV
	CSyqa5voYOFD15bjMunChDRXfdmJTyg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Wilcox <willy@infradead.org>, NeilBrown <neilb@suse.de>, 
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <vpyvfmlr2cc6oyinf676zgc7mdqbbul2mq67kvkfebze3f4ov2@ucp43ej3dlrh>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u>
 <ZeFCFGc8Gncpstd8@casper.infradead.org>
 <wpof7womk7rzsqeox63pquq7jfx4qdyb3t45tqogcvxvfvdeza@ospqr2yemjah>
 <a43cf329bcfad3c52540fe33e35e2e65b0635bfd.camel@HansenPartnership.com>
 <3bykct7dzcduugy6kvp7n32sao4yavgbj2oui2rpidinst2zmn@e5qti5lkq25t>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bykct7dzcduugy6kvp7n32sao4yavgbj2oui2rpidinst2zmn@e5qti5lkq25t>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 29, 2024 at 10:52:06PM -0500, Kent Overstreet wrote:
> On Fri, Mar 01, 2024 at 10:33:59AM +0700, James Bottomley wrote:
> > On Thu, 2024-02-29 at 22:09 -0500, Kent Overstreet wrote:
> > > Or maybe you just want the syscall to return an error instead of
> > > blocking for an unbounded amount of time if userspace asks for
> > > something silly.
> > 
> > Warn on allocation above a certain size without MAY_FAIL would seem to
> > cover all those cases.  If there is a case for requiring instant
> > allocation, you always have GFP_ATOMIC, and, I suppose, we could even
> > do a bounded reclaim allocation where it tries for a certain time then
> > fails.
> 
> Then you're baking in this weird constant into all your algorithms that
> doesn't scale as machine memory sizes and working set sizes increase.
> 
> > > Honestly, relying on the OOM killer and saying that because that now
> > > we don't have to write and test your error paths is a lazy cop out.
> > 
> > OOM Killer is the most extreme outcome.  Usually reclaim (hugely
> > simplified) dumps clean cache first and tries the shrinkers then tries
> > to write out dirty cache.  Only after that hasn't found anything after
> > a few iterations will the oom killer get activated
> 
> All your caches dumped and the machine grinds to a halt and then a
> random process gets killed instead of simply _failing the allocation_.
> 
> > > The same kind of thinking got us overcommit, where yes we got an
> > > increase in efficiency, but the cost was that everyone started
> > > assuming and relying on overcommit, so now it's impossible to run
> > > without overcommit enabled except in highly controlled environments.
> > 
> > That might be true for your use case, but it certainly isn't true for a
> > cheap hosting cloud using containers: overcommit is where you make your
> > money, so it's absolutely standard operating procedure.  I wouldn't
> > call cheap hosting a "highly controlled environment" they're just
> > making a bet they won't get caught out too often.
> 
> Reading comprehension fail. Reread what I wrote.
> 
> > > And that means allocation failure as an effective signal is just
> > > completely busted in userspace. If you want to write code in
> > > userspace that uses as much memory as is available and no more, you
> > > _can't_, because system behaviour goes to shit if you have overcommit
> > > enabled or a bunch of memory gets wasted if overcommit is disabled
> > > because everyone assumes that's just what you do.
> > 
> > OK, this seems to be specific to your use case again, because if you
> > look at what the major user space processes like web browsers do, they
> > allocate way over the physical memory available to them for cache and
> > assume the kernel will take care of it.  Making failure a signal for
> > being over the working set would cause all these applications to
> > segfault almost immediately.
> 
> Again, reread what I wrote. You're restating what I wrote and completely
> missing the point.
> 
> > > Let's _not_ go that route in the kernel. I have pointy sticks to
> > > brandish at people who don't want to deal with properly handling
> > > errors.
> > 
> > Error legs are the least exercised and most bug, and therefore exploit,
> > prone pieces of code in C.  If we can get rid of them, we should.
> 
> Fuck no.
> 
> Having working error paths is _basic_, and learning how to test your
> code is also basic. If you can't be bothered to do that you shouldn't be
> writing kernel code.
> 
> We are giving far too much by going down the route of "oh, just kill
> stuff if we screwed the pooch and overcommitted".
> 
> I don't fucking care if it's what the big cloud providers want because
> it's convenient for them, some of us actually do care about reliability.
> 
> By just saying "oh, the OO killer will save us" what you're doing is
> making it nearly impossible to fully utilize a machine without having
> stuff randomly killed.
> 
> Fuck. That.

And besides all that, as a practical matter you can't just "not have
erro paths" because, like you said, you'd still have to have a max size
where you WARN() - and _fail the allocation_ - and you've still got to
unwind.

The OOM killer can't kill processes while they're stuck blocking on an
allocation that will rever return in the kernel.

I think we can safely nip this idea in the bud.

Test your damn error paths...

