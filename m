Return-Path: <linux-fsdevel+bounces-11807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AEA857369
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 02:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37C21C22473
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A16FDDDA;
	Fri, 16 Feb 2024 01:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eikRcSiI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91FD2EE
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046868; cv=none; b=oHoAbeQ34CU75KKBxdsab9yipEm5vW2i8NzgfGbuXF3maEzX4QwX350DWiOMuRpRYZkskJF3AmGUm9p5GWeRWqmzEdMMcb6wL8vDeHia1LGnqLpMKAsBV3yO5Z2iHPY/aTjAA55HtRbdI/YMMUEB11mCqP4Kw2Hnct/BsMYGLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046868; c=relaxed/simple;
	bh=2oKO7VA3PoFchDCqL7KpfExW+/KPmg7jqfIF2Vuf9TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuBWtWEl3iInH4XkGcveGV4JGph7Upu/qFATzguQPbO2UKC1dSdWt7akNSJ6vRKRfvaZe3lh1952Uf4OQrJUvEVRG+wvW42Cs1/ZiVfU9N82SV8muCU6oNrgzKas1BLlXzXhDPElj4/tPIE8b7HeSSM42tvDatwfGKG88lVM/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eikRcSiI; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 20:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708046863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eetpFPzcLKuw5HxOpWYVmhh5wz1OkHFu3WKeFY7241g=;
	b=eikRcSiIlxJQoaLSe+2OYMExnYsOjBZ9AUpmDf2rLIL/Q/zgYknGLLmlbY+KHrXhdQJyXa
	4s4NUYFAxjJDTXRvs8jDGA9ZRJ1Xl781WswYHby5Zd9fsMN57an2WOSUwRYNvGe6uJPWh3
	lr3fAX/rJ/8V61hf1ztLpHxf+bwctRo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
Message-ID: <iqynyf7tiei5xgpxiifzsnj4z6gpazujrisdsrjagt2c6agdfd@th3rlagul4nn>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-14-surenb@google.com>
 <20240215165438.cd4f849b291c9689a19ba505@linux-foundation.org>
 <wdj72247rptlp4g7dzpvgrt3aupbvinskx3abxnhrxh32bmxvt@pm3d3k6rn7pm>
 <CA+CK2bBod-1FtrWQH89OUhf0QMvTar1btTsE0wfROwiCumA8tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBod-1FtrWQH89OUhf0QMvTar1btTsE0wfROwiCumA8tg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 08:22:44PM -0500, Pasha Tatashin wrote:
> On Thu, Feb 15, 2024 at 8:00 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, Feb 15, 2024 at 04:54:38PM -0800, Andrew Morton wrote:
> > > On Mon, 12 Feb 2024 13:38:59 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > +Example output.
> > > > +
> > > > +::
> > > > +
> > > > +    > cat /proc/allocinfo
> > > > +
> > > > +      153MiB     mm/slub.c:1826 module:slub func:alloc_slab_page
> > > > +     6.08MiB     mm/slab_common.c:950 module:slab_common func:_kmalloc_order
> > > > +     5.09MiB     mm/memcontrol.c:2814 module:memcontrol func:alloc_slab_obj_exts
> > > > +     4.54MiB     mm/page_alloc.c:5777 module:page_alloc func:alloc_pages_exact
> > > > +     1.32MiB     include/asm-generic/pgalloc.h:63 module:pgtable func:__pte_alloc_one
> > >
> > > I don't really like the fancy MiB stuff.  Wouldn't it be better to just
> > > present the amount of memory in plain old bytes, so people can use sort
> > > -n on it?
> >
> > They can use sort -h on it; the string_get_size() patch was specifically
> > so that we could make the output compatible with sort -h
> >
> > > And it's easier to tell big-from-small at a glance because
> > > big has more digits.
> > >
> > > Also, the first thing any sort of downstream processing of this data is
> > > going to have to do is to convert the fancified output back into
> > > plain-old-bytes.  So why not just emit plain-old-bytes?
> > >
> > > If someone wants the fancy output (and nobody does) then that can be
> > > done in userspace.
> >
> > I like simpler, more discoverable tools; e.g. we've got a bunch of
> > interesting stuff in scripts/ but it doesn't get used nearly as much -
> > not as accessible as cat'ing a file, definitely not going to be
> > installed by default.
> 
> I also prefer plain bytes instead of MiB. A driver developer that
> wants to verify up-to the byte allocations for a new data structure
> that they added is going to be disappointed by the rounded MiB
> numbers.

That's a fair point.

> The data contained in this file is not consumable without at least
> "sort -h -r", so why not just output bytes instead?
> 
> There is /proc/slabinfo  and there is a slabtop tool.
> For raw /proc/allocinfo we can create an alloctop tool that would
> parse, sort and show data in human readable format based on various
> criteria.
> 
> We should also add at the top of this file "allocinfo - version: 1.0",
> to allow future extensions (i.e. column for proc name).

How would we feel about exposing two different versions in /proc? It
should be a pretty minimal addition to .text.

Personally, I hate trying to count long strings digits by eyeball...

