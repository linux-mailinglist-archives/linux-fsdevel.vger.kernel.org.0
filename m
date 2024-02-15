Return-Path: <linux-fsdevel+bounces-11782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BE38571FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD00F1F23E28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36CB145FF7;
	Thu, 15 Feb 2024 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AX8VvR4l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D47145324;
	Thu, 15 Feb 2024 23:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041116; cv=none; b=UPu/+tzqwpvqaejZVqrQGY2ooJFO+Q3tW0vaZAQmrluXqMgYpL1NIY7kUKBEzAanumSpWIfza9TgaqtxWyBKfaEbHPBec5CFYcOW2ODretycvjCk9VTtgse17sOZvDn0NzCnlVzon9fGGeb1gDaGf8sqoHCGxbQXsk58FnK5L/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041116; c=relaxed/simple;
	bh=+Q5LCbfshzsAZdu2xMUBI5sVBfTSUWyS3SLTEBuBLFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBjkyV16IfUf/3xehJ6j7zrZNdLcR2HXp+lzNGcMxil1dAiuBPZkhZZG4rN6ahH2OYYEadn2HQrsXjq06Nr/SwzYrOkwJGMhGxlTx7O5jCAbFXwQw1VHxmesEf8ZAWPVwZflYK+R6Yzi8lmS2I7fPnJA+RWTQgWJfIjPSmZlq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AX8VvR4l; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 18:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708041111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fn06dkJ1+mAaWpggeUdl7NGUJOJXRgTvflxoZrn/p3U=;
	b=AX8VvR4luSIKxjOW3kIPF4f8jCsn0k7LGyQ/dc1uxcl77umiNOAVr6Tu53YSB1J9xNktKT
	0U9aZdYfTGQtk/VNGVpka453ky7CfEdKYdVC+PyEzsFA+OPOAMQ5phcorB0KJ1vyZn5Tz1
	MR90Q0CtrObSpQ3vR5b3OC1C1lIokhI=
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
Message-ID: <jpmlfejxcmxa7vpsuyuzykahr6kz5vjb44ecrzfylw7z4un3g7@ia3judu4xkfp>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka>
 <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
 <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
 <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215180742.34470209@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 06:07:42PM -0500, Steven Rostedt wrote:
> On Thu, 15 Feb 2024 15:33:30 -0500
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > > Well, I think without __GFP_NOWARN it will cause a warning and thus
> > > recursion into __show_mem(), potentially infinite? Which is of course
> > > trivial to fix, but I'd myself rather sacrifice a bit of memory to get
> > > this potentially very useful output, if I enabled the profiling. The
> > > necessary memory overhead of page_ext and slabobj_ext makes the
> > > printing buffer overhead negligible in comparison?  
> > 
> > __GFP_NOWARN is a good point, we should have that.
> > 
> > But - and correct me if I'm wrong here - doesn't an OOM kick in well
> > before GFP_ATOMIC 4k allocations are failing? I'd expect the system to
> > be well and truly hosed at that point.
> > 
> > If we want this report to be 100% reliable, then yes the preallocated
> > buffer makes sense - but I don't think 100% makes sense here; I think we
> > can accept ~99% and give back that 4k.
> 
> I just compiled v6.8-rc4 vanilla (with a fedora localmodconfig build) and
> saved it off (vmlinux.orig), then I compiled with the following:
> 
> Applied the patches but did not enable anything:	vmlinux.memtag-off
> Enabled MEM_ALLOC_PROFILING:				vmlinux.memtag
> Enabled MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT:		vmlinux.memtag-default-on
> Enabled MEM_ALLOC_PROFILING_DEBUG:			vmlinux.memtag-debug
> 
> And here's what I got:
> 
>    text         data            bss     dec             hex filename
> 29161847        18352730        5619716 53134293        32ac3d5 vmlinux.orig
> 29162286        18382638        5595140 53140064        32ada60 vmlinux.memtag-off		(+5771)
> 29230868        18887662        5275652 53394182        32ebb06 vmlinux.memtag			(+259889)
> 29230746        18887662        5275652 53394060        32eba8c vmlinux.memtag-default-on	(+259767) dropped?
> 29276214        18946374        5177348 53399936        32ed180 vmlinux.memtag-debug		(+265643)
> 
> Just adding the patches increases the size by 5k. But the rest shows an
> increase of 259k, and you are worried about 4k (and possibly less?)???

Most of that is data (505024), not text (68582, or 66k).

The data is mostly the alloc tags themselves (one per allocation
callsite, and you compiled the entire kernel), so that's expected.

Of the text, a lot of that is going to be slowpath stuff - module load
and unload hooks, formatt and printing the output, other assorted bits.

Then there's Allocation and deallocating obj extensions vectors - not
slowpath but not super fast path, not every allocation.

The fastpath instruction count overhead is pretty small
 - actually doing the accounting - the core of slub.c, page_alloc.c,
   percpu.c
 - setting/restoring the alloc tag: this is overhead we add to every
   allocation callsite, so it's the most relevant - but it's just a few
   instructions.

So that's the breakdown. Definitely not zero overhead, but that fixed
memory overhead (and additionally, the percpu counters) is the price we
pay for very low runtime CPU overhead.

