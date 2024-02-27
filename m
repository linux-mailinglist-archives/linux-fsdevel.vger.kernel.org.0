Return-Path: <linux-fsdevel+bounces-12978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B63869BF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F60285FC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAB814831E;
	Tue, 27 Feb 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdv0Elu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6414830E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050889; cv=none; b=DSzDmMY58Q/kYvKl1B7eY7GRSFS9aAXMLN8FuHPFQiQcdNATdpDwXWe29YMVaD85m26+qr2Pfg8P8ADKy708PxhRhyA7A/X5IEwrXBZqXsyjgNh2JzKbu+l0Qx/7PkzTstgC9Q+1YvKMm195tcFjc26OLvsvZuMa9vouC5lT6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050889; c=relaxed/simple;
	bh=Hzg6zefAGU5YFBT8ZyU0GJNb+Waa5u+eZRrV8mqCzvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw3aIS9mvy2rYBjqUrv+vqxq667C9SPA7e4/V+5MneihCu1OuynR0fzVn2CqXW7GreBXgIieYx7FShyKidorgAX/UKaqj6DA8qnWDGSWLFHX8RFIjX8Jxumbn9fkf4aY8dBTCwID4SRJjtr1bS7vfexPeK/U8bqpsdxzYO2bo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdv0Elu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8C9C433C7;
	Tue, 27 Feb 2024 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709050889;
	bh=Hzg6zefAGU5YFBT8ZyU0GJNb+Waa5u+eZRrV8mqCzvY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kdv0Elu8z2EC15UsAezT6BWoezSHq5bGjRQ7d7TbhaAQggXcgRpu/BjIHQiLX6DrY
	 WjBoWHxqOSKvieJHw8EGHlkIzEvdP3H0zo355eiivFQFT848J1TRgAm/vf51lDYZU+
	 AgZkjMRUrRfdLgctP9dPkKB+fcTPnoSGEhlvzV4hqAjM8SsFHE4sF808+fk+Stvki3
	 /BR6VQDGlCI9IaCIvpqfR0DAgMicEbnakhVNIrrLhJVefOmoaXbD4ppdSRe+PYGdqP
	 d0BiomBHQKQPUiu7prrZud84e6LyidITFxhuRl7N9qZGDJ9GnISy0qRhaPA5Po9jCk
	 HTUJf7bgiEpnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 391B0CE0F12; Tue, 27 Feb 2024 08:21:29 -0800 (PST)
Date: Tue, 27 Feb 2024 08:21:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <1f0d0536-c35b-46f9-9dfb-c8bc29e6956a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
 <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>
 <efb40e53-dae5-44c8-9e15-3cbf3a0cf537@paulmck-laptop>
 <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>
 <49354148-4dea-4c89-b591-76b21ed4a5d1@paulmck-laptop>
 <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>
 <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
 <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>
 <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>
 <Zd4FrwE8D7m31c66@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd4FrwE8D7m31c66@casper.infradead.org>

On Tue, Feb 27, 2024 at 03:54:23PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 27, 2024 at 07:32:32AM -0800, Paul E. McKenney wrote:
> > At a ridiculously high level, reclaim is looking for memory to free.
> > Some read-only memory can often be dropped immediately on the grounds
> > that its data can be read back in if needed.  Other memory can only be
> > dropped after being written out, which involves a delay.  There are of
> > course many other complications, but this will do for a start.
> 
> Hi Paul,
> 
> I appreciate the necessity of describing what's going on at a very high
> level, but there's a wrinkle that I'm not sure you're aware of which
> may substantially change your argument.
> 
> For anonymous memory, we do indeed wait until reclaim to start writing it
> to swap.  That may or may not be the right approach given how anonymous
> memory is used (and could be the topic of an interesting discussion
> at LSFMM).
> 
> For file-backed memory, we do not write back memory in reclaim.  If it
> has got to the point of calling ->writepage in vmscan, things have gone
> horribly wrong to the point where calling ->writepage will make things
> worse.  This is why we're currently removing ->writepage from every
> filesystem (only ->writepages will remain).  Instead, the page cache
> is written back much earlier, once we get to balance_dirty_pages().
> That lets us write pages in filesystem-friendly ways instead of in MM
> LRU order.

Thank you for the additional details.

But please allow me to further summarize the point of my prior email
that seems to be getting lost:

1.	RCU already does significant work prodding grace periods.

2.	There is no reasonable way to provide estimates of the
	memory sent to RCU via call_rcu(), and in many cases
	the bulk of the waiting memory will be call_rcu() memory.

Therefore, if we cannot come up with a heuristic that does not need to
know the bytes of memory waiting, we are stuck anyway.

So perhaps the proper heuristic for RCU speeding things up is simply
"Hey RCU, we are in reclaim!".

Or do you have hard data showing that this is insufficient?

							Thanx, Paul

