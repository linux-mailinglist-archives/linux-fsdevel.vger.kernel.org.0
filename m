Return-Path: <linux-fsdevel+bounces-11605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C95A855398
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 21:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867411F25090
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF9C13DBAA;
	Wed, 14 Feb 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V0Dtva7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844C13DB88
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940830; cv=none; b=fMao0ugWctpZCWnArfMOfgFOgSE6af5brxZIJRkEBkk53QLBIF2dKbVwE+AbAyZU5sVnS03mtDhDCOxn+xpu+TqGPMlKzWXodtvuSh30wI2/G6LBTfYqbeBqVn5A42uzl6yrv5GayfWFJoKpJf24AsMg2G6kxQ5ECePWPHw3dos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940830; c=relaxed/simple;
	bh=sG1eMeXm6V7HoOMCkcfIrnxVJDrJycSjo8dnKLtS7so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCtzN1b863GxrVUAJ34dALCed6igDnjlUabQIxRFxGntMsxxhbz7yDzKx8gHfmyWEkyL4J1ajio/GVr6/y75woe4U2LyrzhkY4WrlE+KudH6ivV2GHrifxcmXeMdd9p58WIEl0V8GgkYx4LfDBkRjt5wrTO3JVnx0kBa72YrmNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V0Dtva7q; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Feb 2024 15:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707940826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pf30Mbuh5b/kObn023v7ccfUflKK/+7eCEEfg4Q4/Xo=;
	b=V0Dtva7qS2reHkZJi6PJ+HEovBCR0hF1cHRtyU3vqEVbBd8vXfQIrh8jm2X0ifBBI4P+IO
	H5vrvDEyaz0upotCLVyuYanif0dGbMLFqnWADl59CQ4rEdihhMwhzsvSw9R6sR/elwVruF
	7JlRVAQ9ZPkvUkS27LLag/qy7F3NQ4g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, axboe@kernel.dk, 
	mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, 
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <stxem77cvysbfllp46dtgsgawzdtkr662ymw3jgo564ekssna3@t7iw7azgyqvy>
References: <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
 <20240214085548.d3608627739269459480d86e@linux-foundation.org>
 <7c3walgmzmcygchqaylcz2un5dandlnzdqcohyooryurx6utxr@66adcw7f26c3>
 <CAJuCfpGi6g3rG8aVmXveSxKvXnfm+5gLKS=Q4ouQBDaTxSuhww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGi6g3rG8aVmXveSxKvXnfm+5gLKS=Q4ouQBDaTxSuhww@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 14, 2024 at 11:24:23AM -0800, Suren Baghdasaryan wrote:
> On Wed, Feb 14, 2024 at 9:52 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Wed, Feb 14, 2024 at 08:55:48AM -0800, Andrew Morton wrote:
> > > On Tue, 13 Feb 2024 14:59:11 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > > > If you think you can easily achieve what Michal requested without all that,
> > > > > > good.
> > > > >
> > > > > He requested something?
> > > >
> > > > Yes, a cleaner instrumentation. Unfortunately the cleanest one is not
> > > > possible until the compiler feature is developed and deployed. And it
> > > > still would require changes to the headers, so don't think it's worth
> > > > delaying the feature for years.
> > >
> > > Can we please be told much more about this compiler feature?
> > > Description of what it is, what it does, how it will affect this kernel
> > > feature, etc.
> > >
> > > Who is developing it and when can we expect it to become available?
> > >
> > > Will we be able to migrate to it without back-compatibility concerns?
> > > (I think "you need quite recent gcc for memory profiling" is
> > > reasonable).
> > >
> > >
> > >
> > > Because: if the maintainability issues which Michel describes will be
> > > significantly addressed with the gcc support then we're kinda reviewing
> > > the wrong patchset.  Yes, it may be a maintenance burden initially, but
> > > at some (yet to be revealed) time in the future, this will be addressed
> > > with the gcc support?
> >
> > Even if we had compiler magic, after considering it more I don't think
> > the patchset would be improved by it - I would still prefer to stick
> > with the macro approach.
> >
> > There's also a lot of unresolved questions about whether the compiler
> > approach would even end being what we need; we need macro expansion to
> > happen in the caller of the allocation function
> 
> For the record, that's what this attribute will be doing. So it should
> cover our usecase.

That wasn't clear in the meeting we had the other day; all that was
discussed there was the attribute syntax, as I recall.

So say that does work out (and I don't think that's a given; if I were a
compiler person I don't think I'd be interested in this strange half
macro, half inline function beast); all that has accomplished is to get
rid of the need for the renaming - the _noprof() versions of functions.

So then how do you distinguish where in the callstack the accounting
happens?

If you say "it happens at the outermost wrapper", then what happens is

 - Extra overhead for all the inner wrapper invocations, where they have
   to now check "actually, we already have an alloc tag, don't do
   anything". That's a cost, and given how much time we spent shaving
   cycles and branches during development it's not one we want.

 - Inner allocations that shouldn't be accounted to the outer context
   are now a major problem, because they silently will be accounted
   there and never noticed.

   With our approach, inner allocations are by default (i.e. when we
   haven't switched them to the _noprof() variant) accounted to their
   own alloc tag; that way, when we're reading the /proc/allocinfo
   output, we can examine them and check if they should be collapsed to
   the outer context. With this approach they won't be seen.

So no, we still don't want the compiler approach.

