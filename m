Return-Path: <linux-fsdevel+bounces-11799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A2285732B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 02:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B8A282837
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4791BC4B;
	Fri, 16 Feb 2024 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VwI1BtmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43B1B962
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045263; cv=none; b=CopBjq3vJj80YEnj6ZmVzlzhjsDN+IHi6FlFtmWnB9TdbatF2/4tieAnrr8gap7Lpt6i4b/gciFFkBhzfIHqd1fQNkTl15AExJ1tBF1AdSCTT6cyAFlpEwEE3fgkK4qQtG/b1MQ7smyw6KgFbQf1EuYpFsLBKt7lugX0tkLvZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045263; c=relaxed/simple;
	bh=A52H0dqD8kleqE238ieALR6ZBY6GGUNS1919tKqbDeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYctZ11Ez0FdEayPq/Rgj/B9NJI+xMOwANJCM6bs96LQ+8G6dpQpUnVY0fm1+K8Koah4X5gxUeV466EBMRviBtC69EjfO8d2ziciKob4N4B9pdTmQPJQg0T2jWlKiWEmvSF80uxDzNJX3mcTLFzbrRvNaRNCvvYicUhkyTrq/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VwI1BtmZ; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 20:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708045258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BBDDxkjYnEavfD3mPCDXRmZmPfVkLnkDBgf+7vi9zKM=;
	b=VwI1BtmZHZ8AkEFSDPZcDAbf2+PV4v1WRQyNv3uIXV1rbNjzQt5Leg53FPjWDtQ/KaxbAn
	GxjPODEgB7rm5NhFMSI3EYn8tBPiHukc5PvTq1vOA+l7XGhliE2x7w1hLnpYG9dWz5RqKW
	pX+V+s/4pq5j3IaGneZUuQMv6MupngE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, 
	cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
Message-ID: <wdj72247rptlp4g7dzpvgrt3aupbvinskx3abxnhrxh32bmxvt@pm3d3k6rn7pm>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-14-surenb@google.com>
 <20240215165438.cd4f849b291c9689a19ba505@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215165438.cd4f849b291c9689a19ba505@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 04:54:38PM -0800, Andrew Morton wrote:
> On Mon, 12 Feb 2024 13:38:59 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > +Example output.
> > +
> > +::
> > +
> > +    > cat /proc/allocinfo
> > +
> > +      153MiB     mm/slub.c:1826 module:slub func:alloc_slab_page
> > +     6.08MiB     mm/slab_common.c:950 module:slab_common func:_kmalloc_order
> > +     5.09MiB     mm/memcontrol.c:2814 module:memcontrol func:alloc_slab_obj_exts
> > +     4.54MiB     mm/page_alloc.c:5777 module:page_alloc func:alloc_pages_exact
> > +     1.32MiB     include/asm-generic/pgalloc.h:63 module:pgtable func:__pte_alloc_one
> 
> I don't really like the fancy MiB stuff.  Wouldn't it be better to just
> present the amount of memory in plain old bytes, so people can use sort
> -n on it?

They can use sort -h on it; the string_get_size() patch was specifically
so that we could make the output compatible with sort -h

> And it's easier to tell big-from-small at a glance because
> big has more digits.
> 
> Also, the first thing any sort of downstream processing of this data is
> going to have to do is to convert the fancified output back into
> plain-old-bytes.  So why not just emit plain-old-bytes?
> 
> If someone wants the fancy output (and nobody does) then that can be
> done in userspace.

I like simpler, more discoverable tools; e.g. we've got a bunch of
interesting stuff in scripts/ but it doesn't get used nearly as much -
not as accessible as cat'ing a file, definitely not going to be
installed by default.

I'm just optimizing for the most common use case. I doubt there's going
to be nearly as much consumption by tools, and I'm ok with making them
do the conversion back to bytes if they really need it.

