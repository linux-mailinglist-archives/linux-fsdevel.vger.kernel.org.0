Return-Path: <linux-fsdevel+bounces-12393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A9185ECED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C180E28393D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 23:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58B12AADC;
	Wed, 21 Feb 2024 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lq+ly2y7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602981726
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558170; cv=none; b=X7x+7CxYrE1JH+40hGsOKfHsVyNaF6CML5Uhg68hqLTdaDfRclHmd1A0C+xVkrCEA01OL3tY9DTwkMFwzz1Iz++Xqr393fMTtuY9UMOM9OzHBo0x4rrBz0XiDg7ESLR70FK+7tGWCZyEKlh8OX8juJ6x+JABU+dlDnOt260o/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558170; c=relaxed/simple;
	bh=VBQFWc4+X2Kq6N54nWyl3qAakm9/sRlka/LIAP7cJPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbJU3+I0tk49RiO/JuKgbtCuIRtpkFxy5rVJaxxKvEMWaHc9CDUPR8NTsTq3G4tymc0WWWYDENz2n8G5eJP3pKj9bMqCrhwJvVzXdrC5w+UgvwC1ZdwonBAQ11NUJIvBOMv2eb3IKdCXArY4DmH614oyhG7SBnGtr4pRJSJAz9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lq+ly2y7; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Feb 2024 18:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708558166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hjF2SQllee7ug3mHeFW3uN8wvM2xkpGrw/6L+GvqAI=;
	b=Lq+ly2y7ah6AgZEjrWQX8/IY+bYAY/Ak3A5hUtk/+rtO4t3TYNDPVCD+CvXmzOQkb6YHo7
	7yI3N4yC5JmG7fb7Y9dHPG42OsUly1lTcqxUI6lMJfU5Uv30ghFpPF8KPSHsNaDtEzb/sY
	xXygOWJKr+1K2eQRLdil8O1/4jAKKis=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, ndesaulniers@google.com, vvvvvv@google.com, 
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
Subject: Re: [PATCH v4 14/36] lib: add allocation tagging support for memory
 allocation profiling
Message-ID: <4vwiwgsemga7vmahgwsikbsawjq5xfskdsssmjsfe5hn7k2alk@b6ig5v2pxe5i>
References: <20240221194052.927623-1-surenb@google.com>
 <20240221194052.927623-15-surenb@google.com>
 <202402211449.401382D2AF@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402211449.401382D2AF@keescook>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 21, 2024 at 03:05:32PM -0800, Kees Cook wrote:
> On Wed, Feb 21, 2024 at 11:40:27AM -0800, Suren Baghdasaryan wrote:
> > [...]
> > +struct alloc_tag {
> > +	struct codetag			ct;
> > +	struct alloc_tag_counters __percpu	*counters;
> > +} __aligned(8);
> > [...]
> > +#define DEFINE_ALLOC_TAG(_alloc_tag)						\
> > +	static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr);	\
> > +	static struct alloc_tag _alloc_tag __used __aligned(8)			\
> > +	__section("alloc_tags") = {						\
> > +		.ct = CODE_TAG_INIT,						\
> > +		.counters = &_alloc_tag_cntr };
> > [...]
> > +static inline struct alloc_tag *alloc_tag_save(struct alloc_tag *tag)
> > +{
> > +	swap(current->alloc_tag, tag);
> > +	return tag;
> > +}
> 
> Future security hardening improvement idea based on this infrastructure:
> it should be possible to implement per-allocation-site kmem caches. For
> example, we could create:
> 
> struct alloc_details {
> 	u32 flags;
> 	union {
> 		u32 size; /* not valid after __init completes */
> 		struct kmem_cache *cache;
> 	};
> };
> 
> - add struct alloc_details to struct alloc_tag
> - move the tags section into .ro_after_init
> - extend alloc_hooks() to populate flags and size:
> 	.flags = __builtin_constant_p(size) ? KMALLOC_ALLOCATE_FIXED
> 					    : KMALLOC_ALLOCATE_BUCKETS;
> 	.size = __builtin_constant_p(size) ? size : SIZE_MAX;
> - during kernel start or module init, walk the alloc_tag list
>   and create either a fixed-size kmem_cache or to allocate a
>   full set of kmalloc-buckets, and update the "cache" member.
> - adjust kmalloc core routines to use current->alloc_tag->cache instead
>   of using the global buckets.
> 
> This would get us fully separated allocations, producing better than
> type-based levels of granularity, exceeding what we have currently with
> CONFIG_RANDOM_KMALLOC_CACHES.
> 
> Does this look possible, or am I misunderstanding something in the
> infrastructure being created here?

Definitely possible, but... would we want this? That would produce a
_lot_ of kmem caches, and don't we already try to collapse those where
possible to reduce internal fragmentation?

