Return-Path: <linux-fsdevel+bounces-11794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA488572DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA0AB21ED4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFC110961;
	Fri, 16 Feb 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VQv3k7CK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE3101EE;
	Fri, 16 Feb 2024 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044641; cv=none; b=IWAM3zLAgNZScof1R+5f3I4QCOzxn5KF1Rjy39MwCjSkfvsC4aUYEYPz4RtaWhe5fp1/ffffcIfqvz4moKxodf4xxIpQjvNrf2+dRUOKZHNBhd+t4o7j6HfUFJkRF3kYu338IZsIsbx5JeQ1nUpKugPrNCTwpkzD5TsCtsnTo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044641; c=relaxed/simple;
	bh=yJvazTFR+86hv5uLjPrGm+ajAykGtrKmqRpojL3XFvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAi9NoX3IB5ynMm2LfTI2fkfHHRa/G3vBvLxPQ46p9jmR0RnfUrUjIRYe+dnLriHbZe1pzwQ8JHG7k9dSr08x1exUHqAVegOkI3PsROfVcdV9NTj8gPtUAyZIoinnpjNPYJcfKefunXHuS5laAGP4VYBvy+Z+H0OmmgwgH9SWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VQv3k7CK; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 19:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708044637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLCxs+brit7Xt9ohcQIkEDEwu4CGUrETZSQhOqg+Gh4=;
	b=VQv3k7CKQO7VvnNiO0UaPC3fRsfnv/HUGMdvgh4+aJJ2aWRJtV+YlrOeBfde8VCHgAcbY5
	lXO47e7kbZbILN8ftGGc8KCEueNDr1rNHWaoOXL0Hdz+XHBXnlrz7urf5prbXjGBLGGyRP
	hi3yRo88y4QRr5f5p0UTWDtVOke68ds=
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
Message-ID: <a3ha7fchkeugpthmatm5lw7chg6zxkapyimn3qio3pkoipg4tc@3j6xfdfoustw>
References: <Zc4_i_ED6qjGDmhR@tiehlicka>
 <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
 <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home>
 <jpmlfejxcmxa7vpsuyuzykahr6kz5vjb44ecrzfylw7z4un3g7@ia3judu4xkfp>
 <20240215192141.03421b85@gandalf.local.home>
 <uhagqnpumyyqsnf4qj3fxm62i6la47yknuj4ngp6vfi7hqcwsy@lm46eypwe2lp>
 <20240215193915.2d457718@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215193915.2d457718@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 07:39:15PM -0500, Steven Rostedt wrote:
> On Thu, 15 Feb 2024 19:32:38 -0500
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > > But where are the benchmarks that are not micro-benchmarks. How much
> > > overhead does this cause to those? Is it in the noise, or is it noticeable?  
> > 
> > Microbenchmarks are how we magnify the effect of a change like this to
> > the most we'll ever see. Barring cache effects, it'll be in the noise.
> > 
> > Cache effects are a concern here because we're now touching task_struct
> > in the allocation fast path; that is where the
> > "compiled-in-but-turned-off" overhead comes from, because we can't add
> > static keys for that code without doubling the amount of icache
> > footprint, and I don't think that would be a great tradeoff.
> > 
> > So: if your code has fastpath allocations where the hot part of
> > task_struct isn't in cache, then this will be noticeable overhead to
> > you, otherwise it won't be.
> 
> All nice, but where are the benchmarks? This looks like it will have an
> affect on cache and you can talk all you want about how it will not be an
> issue, but without real world benchmarks, it's meaningless. Numbers talk.

Steve, you're being demanding. We provided sufficient benchmarks to show
the overhead is low enough for production, and then I gave you a
detailed breakdown of where our overhead is and where it'll show up. I
think that's reasonable.

