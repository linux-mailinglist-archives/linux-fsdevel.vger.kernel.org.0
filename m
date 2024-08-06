Return-Path: <linux-fsdevel+bounces-25084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F4948C4C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 11:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23020B24FE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 09:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADC41BDAB1;
	Tue,  6 Aug 2024 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mlsA68eB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55B5464E;
	Tue,  6 Aug 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937458; cv=none; b=uKwHGN7UEp0ojagcyvZAyLv54fBGxHb432e4lxfE8qDsg8sDns1fyZvzMA9osxOxsDoZefTYgs19cuDI2DpxPugr+T0d9JQSl7R+PUgMcO3tadAY7FUUaxu3glk8OilnWox7WsmG+FJYUsC+dsig/tHWEZ4qcLFCWmZDSMXUVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937458; c=relaxed/simple;
	bh=9hU69UZM9LqNRrO8sJDJRoZJnTfGYjYSj/tarClKfD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6xvXHRToAxq+k2fKzjGXhAd//VyYJbk41NTQZjVFqPUYFtKfQ6tYCztADkrvV8h2SNkiBakfc0hlE5RfxMoO9l+gL9dsRj6WriLHoYpvyIC+WrOAea7LnieoJqj2USI0txhSCZZDDA1CCcCjGwrnOe05MDVCs3jSPC4OF3/TMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mlsA68eB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=39V3FioJp3COx+jGkYqvGEZBHRp/UIdXm+MJrO3+fOI=; b=mlsA68eBayPB+Ehqt5BfHIG9MG
	kbbefJv7a43hgpYIc1ND/PNuetHyn3J/eDJHk7cFzAd02A9tHkpS0FAKEc0tDbde875yE/VI8InVq
	epDGE4mguIuf/NcAFf2pkW4WD14iKoTV/qPxNJZQos3X3apC1YYPpL6S6aNA4wMqhMfPYuDZXJ1u0
	uD/T+zWdj652DKVjXz3xeeYSBCKmoFNo5x2YSxrrqfvvmGQPvLbr4xy6nL+08kHXS1cRbmq7A4gV7
	wS2ZEub+x8V81hQ7a04auh7SGPpFaAlWqXygoK2fAnns8LGYX8s/eHs0kaSIw5k8IHxsajG6pfIzf
	BQgVxorA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbGjm-00000005WhQ-01Si;
	Tue, 06 Aug 2024 09:44:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3103130049D; Tue,  6 Aug 2024 11:44:13 +0200 (CEST)
Date: Tue, 6 Aug 2024 11:44:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
	tglx@linutronix.de
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240806094413.GS37996@noisy.programming.kicks-ass.net>
References: <20240730033849.GH6352@frogsfrogsfrogs>
 <87o76f9vpj.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240730132626.GV26599@noisy.programming.kicks-ass.net>
 <20240731001950.GN6352@frogsfrogsfrogs>
 <20240731031033.GP6352@frogsfrogsfrogs>
 <20240731053341.GQ6352@frogsfrogsfrogs>
 <20240731105557.GY33588@noisy.programming.kicks-ass.net>
 <20240805143522.GA623936@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805143522.GA623936@frogsfrogsfrogs>

On Mon, Aug 05, 2024 at 07:35:22AM -0700, Darrick J. Wong wrote:
> On Wed, Jul 31, 2024 at 12:55:57PM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 30, 2024 at 10:33:41PM -0700, Darrick J. Wong wrote:
> > 
> > > Sooooo... it turns out that somehow your patch got mismerged on the
> > > first go-round, and that worked.  The second time, there was no
> > > mismerge, which mean that the wrong atomic_cmpxchg() callsite was
> > > tested.
> > > 
> > > Looking back at the mismerge, it actually changed
> > > __static_key_slow_dec_cpuslocked, which had in 6.10:
> > > 
> > > 	if (atomic_dec_and_test(&key->enabled))
> > > 		jump_label_update(key);
> > > 
> > > Decrement, then return true if the value was set to zero.  With the 6.11
> > > code, it looks like we want to exchange a 1 with a 0, and act only if
> > > the previous value had been 1.
> > > 
> > > So perhaps we really want this change?  I'll send it out to the fleet
> > > and we'll see what it reports tomorrow morning.
> > 
> > Bah yes, I missed we had it twice. Definitely both sites want this.
> > 
> > I'll tentatively merge the below patch in tip/locking/urgent. I can
> > rebase if there is need.
> 
> Hi Peter,
> 
> This morning, I noticed the splat below with -rc2.
> 
> WARNING: CPU: 0 PID: 8578 at kernel/jump_label.c:295 __static_key_slow_dec_cpuslocked.part.0+0x50/0x60
> 
> Line 295 is the else branch of this code:
> 
> 	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
> 		jump_label_update(key);
> 	else
> 		WARN_ON_ONCE(!static_key_slow_try_dec(key));
> 
> Apparently static_key_slow_try_dec returned false?  Looking at that
> function, I suppose the atomic_read of key->enabled returned 0, since it
> didn't trigger the "WARN_ON_ONCE(v < 0)" code.  Does that mean the value
> must have dropped from positive N to 0 without anyone ever taking the
> jump_label_mutex?

One possible scenario I see:

  slow_dec
    if (try_dec) // dec_not_one-ish, false
    // enabled == 1
				slow_inc
				  if (inc_not_disabled) // inc_not_zero-ish
				  // enabled == 2
				    return

    guard((mutex)(&jump_label_mutex);
    if (atomic_cmpxchg(1,0)==1) // false, we're 2
    
				slow_dec
				  if (try-dec) // dec_not_one, true
				  // enabled == 1
				    return
    else
      try_dec() // dec_not_one, false
      WARN


Let me go play to see how best to cure this.

> Unfortunately I'm a little too covfid-brained to figure this out today.
> :(

Urgh, brain-fog is the worst :/


