Return-Path: <linux-fsdevel+bounces-16082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67228897B9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 00:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B451C274E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A99915698C;
	Wed,  3 Apr 2024 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vjP/yYrv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC51815697C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183073; cv=none; b=UKuc+WHdgcLzWx8tSFgryhUeSzCHw7j9AN6kF2a8JQw+qR4RcRdfN/l7SREEdQlWlEDrQ3ryr1MQmXY7sOVAbHvcJW9H17fOYfYe8JSGciTdqhQxbSuVMpjjFa6RL6lk4GjXYro/gQrNlvhWTot+CF3700Z2DCRHY3a8Io3nUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183073; c=relaxed/simple;
	bh=LNCSPovg0Yr0f5AT+54kFFxIj5VkH82mvFV2YH+a9nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfaAOXO+gQJQm/okErLLYhotHW/sVC4V9lkzeu6fJh6hXQIyGQ1ZN93qlFsjwUTdjUcTLk4MvKncVXCCus17wgTZdlcQAs7/2WUUVy2yMTn8ymTyd0BFtI5rSVZjO+pniix97Qljs5ogHjsceHGjtDiALkINPrK6++CaMUDTVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vjP/yYrv; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 3 Apr 2024 18:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712183069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2bIqvAswIgDrceINf7iI+jp9YVPIpyS4ScRls8ALPo=;
	b=vjP/yYrvtF19e9GfRt/XiqymxaisEEbkdtyuuCJTe5x3Tzrxf7uToW6LSjpKH1aM+fIeK0
	P9E8Bz3M+ETRXVDhyGNKvROLYhHwrlU+63KTdjYO4b8Kviblvao04uSo5uDEb+Xz95wKRS
	QhWTv+BTLyRzNRskMf78GaGa3slcvU8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	akpm@linux-foundation.org, willy@infradead.org, bfoster@redhat.com, dsterba@suse.com, 
	mjguzik@gmail.com, dhowells@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <zsuqucmnc2yp52e3nijfe42rsel2jw73fom3bl5exkk5324ctq@getfgchn6ppr>
References: <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>
 <ZgXJH9XQNqda7fpz@slm.duckdns.org>
 <wgec7wbhdn7ilvwddcalkbgxzjutp6h7dgfrijzffb64pwpksz@e6tqcybzfu2f>
 <ZgXPZ1uJSUCF79Ef@slm.duckdns.org>
 <qv3vv6355aw5fkzw5yvuwlnyceypcsfl5kkcrvlipxwfl3nuyg@7cqwaqpxn64t>
 <ZgXXKaZlmOWC-3mn@slm.duckdns.org>
 <20240403162716.icjbicvtbleiymjy@quack3>
 <Zg2jdcochRXNdDZX@slm.duckdns.org>
 <qemects2mglzjdig7y5uufhoqdhoccwlrwrtfhe4jy6gbadj6n@dnnbzymtxpyj>
 <Zg2sQTIDom21q4i9@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg2sQTIDom21q4i9@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 03, 2024 at 09:21:37AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 03, 2024 at 03:06:56PM -0400, Kent Overstreet wrote:
> ...
> > That's how it should be if you just make a point of making your internal
> > state easy to view and introspect, but when I'm debugging issues that
> > run into the wider block layer, or memory reclaim, we often hit a wall.
> 
> Try drgn:
> 
>   https://drgn.readthedocs.io/en/latest/
> 
> I've been adding drgn scripts under tools/ directory for introspection.
> They're easy to write, deploy and ask users to run.

Which is still inferior to simply writing to_text() functions for all
your objects and exposing them under sysfs/debugfs.

Plus, it's a whole new language/system for boths devs and users to
learn.

And having to_text() functions makes your log and error messages way
better.

"But what about code size/overhead?" - bullshit, we're talking about a
couple percent of .text for the code itself; we blow more memory on
permament dentries/inodes due to the way our virtual filesystems work
but that's more of a problem for tracefs.

> > Writeback throttling was buggy for _months_, no visibility or
> > introspection or concerns for debugging, and that's a small chunk of
> > code. io_uring - had to disable it. I _still_ have people bringing
> > issues to me that are clearly memory reclaim related but I don't have
> > the tools.
> > 
> > It's not like any of this code exports much in the way of useful
> > tracepoints either, but tracepoints often just aren't what you want;
> > what you want just to be able to see internal state (_without_ having to
> > use a debugger, because that's completely impractical outside highly
> > controlled environments) - and tracing is also never the first thing you
> > want to reach for when you have a user asking you "hey, this thing went
> > wonky, what's it doing?" - tracing automatically turns it into a multi
> > step process of decide what you want to look at, run the workload more
> > to collect data, iterate.
> > 
> > Think more about "what would make code easier to debug" and less about
> > "how do I shove this round peg through the square tracing/BPF slot".
> > There's _way_ more we could be doing that would just make our lives
> > easier.
> 
> Maybe it'd help classifying visibility into the the following categories:
> 
> 1. Current state introspection.
> 2. Dynamic behavior tracing.
> 3. Accumluative behavior profiling.
> 
> drgn is great for #1. Tracing and BPF stuff is great for #2 especially when
> things get complicated. #3 is the trickest. Static stuff is useful in a lot
> of cases but BPF can also be useful in other cases.
> 
> I agree that it's all about using the right tool for the problem.

Yeah, and you guys are all about the nerdiest and most overengineered
tools and ignoring the basics. Get the simple stuff right, /then/ if
there's stuff you still can't do, that's when you start looking at the
more complicated stuff.

