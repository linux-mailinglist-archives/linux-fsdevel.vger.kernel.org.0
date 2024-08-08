Return-Path: <linux-fsdevel+bounces-25390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E885194B588
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 05:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CD71F21C4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 03:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9243BBE0;
	Thu,  8 Aug 2024 03:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UUZdeQif"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579708BF0
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723088110; cv=none; b=d6OZUVM6FnZyp65SGb4TKm8SWyls418VAG86GoHts6wJMoHnVrnls8WKk6AUEsEzDeqr/tTJwF4hTnih3Wnh70R4wIoGvsbl4DXWG0njeFdJMEuumKKuN1zuLGyf+Fv86zndynjLPZuzor1sUuEj1131qJuhOe65mgAe2FKvFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723088110; c=relaxed/simple;
	bh=tno+rgEnWPS5y21Q0W/TGXpSKT0N8pZtsrK2zWzPQ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYySm8JSYotJJSXvtJOp/YsTZewe7lqJPi/faIryyFxKxA2HoNa/6lzGLKbrhj1SHdYCLNl9NICvHvX+LImrhPQjyRDj2vbloSWha+LhTfeHo0h2q6qSnBdri9oWh2hcVEHEygF7iipF4oAUKx30LY7/ruOfOZc+lKWI1EHt/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UUZdeQif; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LHK/CFpZOLtvUiYn1Xa4Tq7YbGkeX0wtGX88FSjoMGo=; b=UUZdeQifMr+gChqJLs5DfPHQ6I
	pzQJhDduuvJy+3+4bRNZtKgSdZ064Y6DEv1ScCrUTcYnCepT/c+Omta1aiuGK442kP79IQwRjL9Ge
	0WyWF6nwK7jVUcKZK40yYedyMkTp49kov+GUYuiUWcuhxC9fRgV11RkABBojcFq0Wt0kfp5EQAhr6
	IeXe1EGT3nQ8kBApU+Kn8SLpKeaxN7UNfLShUTWtPrSD1btaXIne7dMRpDYGSIkC7iSVjMUXub4Nz
	No6BGUcumizttnQqPRqfSOco5F54TO78p7H/EpWMK8+yublMR9YfWU8fqJhleiFLBWO4UymzcwHgw
	ymwfGNWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbtvd-00000002ZUJ-11aD;
	Thu, 08 Aug 2024 03:35:05 +0000
Date: Thu, 8 Aug 2024 04:35:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC] why do we need smp_rmb/smp_wmb pair in
 fd_install()/expand_fdtable()?
Message-ID: <20240808033505.GC5334@ZenIV>
References: <20240808025029.GB5334@ZenIV>
 <CAHk-=wgse0ui5sJgNGSvqvYw_BDTcObqdqcwN1BxgCqKBiiGzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgse0ui5sJgNGSvqvYw_BDTcObqdqcwN1BxgCqKBiiGzQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 07, 2024 at 08:06:31PM -0700, Linus Torvalds wrote:

> That should be fine. smp_store_release()->smp_load_acquire() is the
> more modern model, and the better one. But I think we simply have a
> long history of using the old smp_wmb()->smp_rmb() model, so we have a
> lot of code that does that.
> 
> On x86, there's basically no difference - in all cases it ends up
> being just an instruction scheduling barrier.
> 
> On arm64, store_release->load_acquire is likely better, but obviously
> micro-architectural implementation issues might make it a wash.
> 
> On other architectures, there probably isn't a huge difference, but
> acquire/release can be more expensive if the architecture is
> explicitly designed for the old-style rmb/wmb model.
> 
> So on alpha, for example, store_release->load_acquire ends up being a
> full memory barrier in both cases (rmb is always a full memory barrier
> on alpha), which is hugely more expensive than wmb (well, again, in
> theory this is all obviously dependent on microarchitectures, but wmb
> in particular is very cheap unless the uarch really screwed the pooch
> and just messed up its barriers entirely).
> 
> End result: wmb/rmb is usually never _horrific_, while release/acquire
> can be rather expensive on bad machines.
> 
> But release/acquire is the RightThing(tm), and the fact that alpha
> based its ordering on the bad old model is not really our problem.

alpha would have fuckloads of full barriers simply from all those READ_ONCE()
in rcu reads...

smp_rmb() is on the side that is much hotter - fd_install() vs. up to what, 25 calls
of expand_fdtable() per files_struct instance history in the worst possible case?
With rather big memcpy() done by those calls, at that...

