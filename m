Return-Path: <linux-fsdevel+bounces-29525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF1A97A740
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 20:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF48F1C21D6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E8517623F;
	Mon, 16 Sep 2024 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qFXl2F/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2F172BA9;
	Mon, 16 Sep 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726510706; cv=none; b=mIYnmrQJXmRw1ajwTePgKEEv906yDMj+wYyYYTcIeLEFnENIW8sNhMS0QZxRFelt4b+cBuIf2qpj0S+sPBYQBNTFECig4LaIsFmiAk6u7vGdPGVNed0spr1QhR7/8l1O14pxp8Tp6JeVmIBGzsoOQmI2t53zFeYA7xBzM/uDAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726510706; c=relaxed/simple;
	bh=xaEoZ3CYNprlKmLfLiCt//14ZkCN0OXDW4GXr+mON3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF693sjMtl+yTHNROP6kMF6Ke9CwUdaUStip9nka3bAtnS64wuyF1+K60KIL2H5ipbTBpDmmob2Kiv8aac0sHRl3MxgpLQFHsMFGpgaoLMApH7B1Z+dVqZ/rWys9t/YUN/OWTRRCCFSmVHnYprKPxS4N4uo0QlsvymE/swWnAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qFXl2F/5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KU1yM8DVM8wX9QSGYYRoSr68iddFXvJxEb2ckeWkU8M=; b=qFXl2F/5scIuOsVdpRBQY3SFNn
	vFe/6lceo8Ea2OIjH1B48dNbwvLG1iFnN0AAer5LEoQRabpT/7PNo1xW3AICwdaPctDssbHz67p5F
	4fip2Vx1vzLmqxOpqBJcM37+8jt2TIxg2ZnzP5udgAlUXj5IsKjhowJREJZtL1ERDwy2akAEBZPsd
	H7p2dkCAvDl9Crhi3s082RK3TWM9qKv6f5ayHoSg5U+D4aPEetvNPsH4cDwXOO0ExOcSShTb1++t/
	q3bfkKlgEzN/nJG8gdleK3IDbPW0vVs/sKOGv4vRKwdH5JyfVQBvZV7q1Nm38fP4wuG5vWRADkdAb
	rFJ8pLpA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sqGIj-00000002FH5-2SPE;
	Mon, 16 Sep 2024 18:18:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C9DD8300777; Mon, 16 Sep 2024 20:18:17 +0200 (CEST)
Date: Mon, 16 Sep 2024 20:18:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/7] sched: change wake_up_bit() and related function to
 expect unsigned long *
Message-ID: <20240916181817.GF4723@noisy.programming.kicks-ass.net>
References: <>
 <20240916112810.GY4723@noisy.programming.kicks-ass.net>
 <172648729127.17050.15543415823867299910@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172648729127.17050.15543415823867299910@noble.neil.brown.name>

On Mon, Sep 16, 2024 at 09:48:11PM +1000, NeilBrown wrote:
> On Mon, 16 Sep 2024, Peter Zijlstra wrote:
> > On Mon, Aug 26, 2024 at 04:30:59PM +1000, NeilBrown wrote:
> > > wake_up_bit() currently allows a "void *".  While this isn't strictly a
> > > problem as the address is never dereferenced, it is inconsistent with
> > > the corresponding wait_var_event() which requires "unsigned long *" and
> > > does dereference the pointer.
> > 
> > I'm having trouble parsing this. The way I read it, you're contradicting
> > yourself. Where does wait_var_event() require 'unsigned long *' ?
> 
> Sorry, that is meant so as "the corresponding wait_on_bit()".
> 
> 
> > 
> > > And code that needs to wait for a change in something other than an
> > > unsigned long would be better served by wake_up_var().
> > 
> > This, afaict the whole var thing is size invariant. It only cares about
> > the address.
> > 
> 
> Again - wake_up_bit().  Sorry - bits are vars were swimming around my
> brain and I didn't proof-read properly.
> 
> This patch is all "bit", no "var".

OK :-)

Anyway, other than that the patches look fine, but given we're somewhat
in the middle of the merge window and all traveling to get into Vienna
and have a few beers, I would much prefer merging these patches after
-rc1, that okay?

