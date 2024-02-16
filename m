Return-Path: <linux-fsdevel+bounces-11791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC865857296
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5AF285580
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7DB610B;
	Fri, 16 Feb 2024 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TCBheLyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268AB803
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043604; cv=none; b=S/s0ev0PDaR/pDKGnF7I1Sinb3KnxKmv4ddplqsWRuDyROVpxKP93W7xhD7woocQbgQ0qqRewiEKOpxGNetZc+aVOUR3TK1L9a/WoFHpgQbd9P0ZndmDtTeDmwsTCGCHGreRz5uxnxpxiKY1LEI2G8dju1wLak4HppcxHZbNXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043604; c=relaxed/simple;
	bh=XuXzzdT4qpI/thepOvg44pFxyCWv6wsSemsRQD9/TFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2+G4Tc904tCWpO8qzoc8TXq3B2incZDAqIp9RNdI2gvx9VUhWrYUCqvDvW4iBvhz0YHnf2DjIez2zSOqA7LizWsY/VRo7BYS1GdxpptjjFMDJM/6Akz2iprpxtxkoWLeJT69TK8Wyqaiq935t4EhY/+P3HUjKPK5qb37Ou1NMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TCBheLyH; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 19:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708043600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BwLdbKvwbuT7Py0w8ufFkW1cCk4JPEqYMR9dx/1h65M=;
	b=TCBheLyHkvkCr2rg0SrQW08oAxBRtTvcZx+IRR+qV8bqJLfXAVvHTLefKtevmhJLC2yagF
	90KJRsTt6yvwTHkdPhpkVXfpIaPw9mB+yLAmbC/9FosSVc2V4C/QiUfYBPe+UYZAzKt98o
	D2JEy+U5Cbi2lIuDcjB+L1a1QUd7tzU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, david@redhat.com, 
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
Message-ID: <uhagqnpumyyqsnf4qj3fxm62i6la47yknuj4ngp6vfi7hqcwsy@lm46eypwe2lp>
References: <Zc3X8XlnrZmh2mgN@tiehlicka>
 <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
 <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
 <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home>
 <jpmlfejxcmxa7vpsuyuzykahr6kz5vjb44ecrzfylw7z4un3g7@ia3judu4xkfp>
 <20240215192141.03421b85@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215192141.03421b85@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 07:21:41PM -0500, Steven Rostedt wrote:
> On Thu, 15 Feb 2024 18:51:41 -0500
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > Most of that is data (505024), not text (68582, or 66k).
> > 
> 
> And the 4K extra would have been data too.

"It's not that much" isn't an argument for being wasteful.

> > The data is mostly the alloc tags themselves (one per allocation
> > callsite, and you compiled the entire kernel), so that's expected.
> > 
> > Of the text, a lot of that is going to be slowpath stuff - module load
> > and unload hooks, formatt and printing the output, other assorted bits.
> > 
> > Then there's Allocation and deallocating obj extensions vectors - not
> > slowpath but not super fast path, not every allocation.
> > 
> > The fastpath instruction count overhead is pretty small
> >  - actually doing the accounting - the core of slub.c, page_alloc.c,
> >    percpu.c
> >  - setting/restoring the alloc tag: this is overhead we add to every
> >    allocation callsite, so it's the most relevant - but it's just a few
> >    instructions.
> > 
> > So that's the breakdown. Definitely not zero overhead, but that fixed
> > memory overhead (and additionally, the percpu counters) is the price we
> > pay for very low runtime CPU overhead.
> 
> But where are the benchmarks that are not micro-benchmarks. How much
> overhead does this cause to those? Is it in the noise, or is it noticeable?

Microbenchmarks are how we magnify the effect of a change like this to
the most we'll ever see. Barring cache effects, it'll be in the noise.

Cache effects are a concern here because we're now touching task_struct
in the allocation fast path; that is where the
"compiled-in-but-turned-off" overhead comes from, because we can't add
static keys for that code without doubling the amount of icache
footprint, and I don't think that would be a great tradeoff.

So: if your code has fastpath allocations where the hot part of
task_struct isn't in cache, then this will be noticeable overhead to
you, otherwise it won't be.

