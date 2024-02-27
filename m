Return-Path: <linux-fsdevel+bounces-12980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 342BD869CB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C930FB279B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C9D1EB39;
	Tue, 27 Feb 2024 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OMEI6pvD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F961CD3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051656; cv=none; b=o8eRV287B4XUCKwsOcLUFqKqerzsgKlgio/vYxBO7UFP9x8kyluDVMSQvBiUvuiepsMg3FdPkbuN8AxSt2vHfkuXrjioC0ODH0G3zttQVXzijgASz6vsFeLPxNJ0wtXBEojsKqfBCc2xx/1qlIMl/U/594/hDUqiDJw19KV3cZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051656; c=relaxed/simple;
	bh=dL4CekRfhWrXPM3OoSgr9VZHe0lxBGUXglunloRrwdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTL49n+m0yWg4uMJ4pYcVxQCroNuzl/sg8K7EHIu6hqI18pqFvFmau9PZqBk7lnj5dBk3o/8KM6DejvNO6mzpiyyCh3YwLKhqcgEdWdUQ2DW2XAvYR65E1rYH2VIjmWVIi2ddB2jT4feUuLSdctJcRiIfvRKvU1bK2w4Ai6yowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OMEI6pvD; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 11:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709051652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MtgrO6HfgDBspUmBO8A8V2lYH0C5Az89B+6E1HS2XoY=;
	b=OMEI6pvDazZJhBGLztBSvzYmoeC097k3eEm7TxwgiEqXxsl8bWOJ5pYlKoifuZA5kFkbhx
	zbT7G0u5dZAabWuYNicluQCdjuMcEktSpCv58eVEcKFno9zcRulGxy9pKZim9Np+ta12JN
	dud7rauI8N+HH+8Y14TFoFYGtU5Oc2o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <4eibprmeehxnavkbjwvqdxecqk3b4l6lkc3hslbf3ggmxv5vxw@gprjhbny5rue>
References: <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>
 <efb40e53-dae5-44c8-9e15-3cbf3a0cf537@paulmck-laptop>
 <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>
 <49354148-4dea-4c89-b591-76b21ed4a5d1@paulmck-laptop>
 <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>
 <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
 <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>
 <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>
 <Zd4FrwE8D7m31c66@casper.infradead.org>
 <1f0d0536-c35b-46f9-9dfb-c8bc29e6956a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f0d0536-c35b-46f9-9dfb-c8bc29e6956a@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 08:21:29AM -0800, Paul E. McKenney wrote:
> On Tue, Feb 27, 2024 at 03:54:23PM +0000, Matthew Wilcox wrote:
> > On Tue, Feb 27, 2024 at 07:32:32AM -0800, Paul E. McKenney wrote:
> > > At a ridiculously high level, reclaim is looking for memory to free.
> > > Some read-only memory can often be dropped immediately on the grounds
> > > that its data can be read back in if needed.  Other memory can only be
> > > dropped after being written out, which involves a delay.  There are of
> > > course many other complications, but this will do for a start.
> > 
> > Hi Paul,
> > 
> > I appreciate the necessity of describing what's going on at a very high
> > level, but there's a wrinkle that I'm not sure you're aware of which
> > may substantially change your argument.
> > 
> > For anonymous memory, we do indeed wait until reclaim to start writing it
> > to swap.  That may or may not be the right approach given how anonymous
> > memory is used (and could be the topic of an interesting discussion
> > at LSFMM).
> > 
> > For file-backed memory, we do not write back memory in reclaim.  If it
> > has got to the point of calling ->writepage in vmscan, things have gone
> > horribly wrong to the point where calling ->writepage will make things
> > worse.  This is why we're currently removing ->writepage from every
> > filesystem (only ->writepages will remain).  Instead, the page cache
> > is written back much earlier, once we get to balance_dirty_pages().
> > That lets us write pages in filesystem-friendly ways instead of in MM
> > LRU order.
> 
> Thank you for the additional details.
> 
> But please allow me to further summarize the point of my prior email
> that seems to be getting lost:
> 
> 1.	RCU already does significant work prodding grace periods.
> 
> 2.	There is no reasonable way to provide estimates of the
> 	memory sent to RCU via call_rcu(), and in many cases
> 	the bulk of the waiting memory will be call_rcu() memory.
> 
> Therefore, if we cannot come up with a heuristic that does not need to
> know the bytes of memory waiting, we are stuck anyway.

That is a completely asinine argument.

> So perhaps the proper heuristic for RCU speeding things up is simply
> "Hey RCU, we are in reclaim!".

Because that's the wrong heuristic. There are important workloads for
which  we're _always_ in reclaim, but as long as RCU grace periods are
happening at some steady rate, the amount of memory stranded will be
bounded and there's no reason to expedite grace periods.

If we start RCU freeing all pagecache folios we're going to be cycling
memory through RCU freeing at the rate of gigabytes per second, tens of
gigabytes per second on high end systems.

Do you put hard limits on how long we can go before an RCU grace period
that will limit the amount of memory stranded to something acceptable?
Yes or no?

