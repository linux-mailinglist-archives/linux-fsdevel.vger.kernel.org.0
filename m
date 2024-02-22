Return-Path: <linux-fsdevel+bounces-12411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B6E85EE14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 01:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEA71F2388F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678F810A29;
	Thu, 22 Feb 2024 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DNUFEkkq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56829A5
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 00:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562101; cv=none; b=MJVIQb4zi6H7+8qgh/LSjyFm4ID6brRVW9clvUVnyDbAgL5p8IG8QkAMictNOnj21bPUQN5rbFBAAj7QDmtO9TA6tp3HyXmLwFmHuEPdpEAXFMvTzUHkrV9WKrXfdymoYFVmB8CZSsc6V2Xvrgrjm/Hi9N9e9cmfPGOF4MR5J3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562101; c=relaxed/simple;
	bh=fsJO7Voe+3kvWM45B0Sk22Vetz/209FiI591NGHa660=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlOkeDrPbLQpPeVd0m/H9jnOi7U2pjSPAomuHzZqhXGQJ3iDbjSkK6re5PiSIVGiipJBjiBpfOB9r9hg+RZENUbpXm8A8lfr+60TdEzfNMTfo+/if67NU5gpZsVqw3j8qVwUl+qCnLbK14QfTun5nTOlxhp1UqnvgjCaPDa5APg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DNUFEkkq; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Feb 2024 19:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708562097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G88uSOyu1u80Eng+KqSI+b6wDgfOq5t2Nzkcxgmz8B8=;
	b=DNUFEkkqgQoWl+SP5laughmYXRyxMqPuHqKkeAnGKyFby/zySfYBY3FIzXWdfPg84xohpk
	J9sGqqVtCHuZbx8fNQO/nCqhO4qFN18b+/JysbQQ/t5n2nk/SljAJhmsg3qEL65+dgnRkH
	bSHDYXEVjKjZFJzAzNHVNqfZXbzQDrY=
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
Message-ID: <vxx2o2wdcqjkxauglu7ul52mygu4tti2i3yc2dvmcbzydvgvu2@knujflwtakni>
References: <20240221194052.927623-1-surenb@google.com>
 <20240221194052.927623-15-surenb@google.com>
 <202402211449.401382D2AF@keescook>
 <4vwiwgsemga7vmahgwsikbsawjq5xfskdsssmjsfe5hn7k2alk@b6ig5v2pxe5i>
 <202402211608.41AD94094@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402211608.41AD94094@keescook>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 21, 2024 at 04:25:02PM -0800, Kees Cook wrote:
> On Wed, Feb 21, 2024 at 06:29:17PM -0500, Kent Overstreet wrote:
> > On Wed, Feb 21, 2024 at 03:05:32PM -0800, Kees Cook wrote:
> > > On Wed, Feb 21, 2024 at 11:40:27AM -0800, Suren Baghdasaryan wrote:
> > > > [...]
> > > > +struct alloc_tag {
> > > > +	struct codetag			ct;
> > > > +	struct alloc_tag_counters __percpu	*counters;
> > > > +} __aligned(8);
> > > > [...]
> > > > +#define DEFINE_ALLOC_TAG(_alloc_tag)						\
> > > > +	static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr);	\
> > > > +	static struct alloc_tag _alloc_tag __used __aligned(8)			\
> > > > +	__section("alloc_tags") = {						\
> > > > +		.ct = CODE_TAG_INIT,						\
> > > > +		.counters = &_alloc_tag_cntr };
> > > > [...]
> > > > +static inline struct alloc_tag *alloc_tag_save(struct alloc_tag *tag)
> > > > +{
> > > > +	swap(current->alloc_tag, tag);
> > > > +	return tag;
> > > > +}
> > > 
> > > Future security hardening improvement idea based on this infrastructure:
> > > it should be possible to implement per-allocation-site kmem caches. For
> > > example, we could create:
> > > 
> > > struct alloc_details {
> > > 	u32 flags;
> > > 	union {
> > > 		u32 size; /* not valid after __init completes */
> > > 		struct kmem_cache *cache;
> > > 	};
> > > };
> > > 
> > > - add struct alloc_details to struct alloc_tag
> > > - move the tags section into .ro_after_init
> > > - extend alloc_hooks() to populate flags and size:
> > > 	.flags = __builtin_constant_p(size) ? KMALLOC_ALLOCATE_FIXED
> > > 					    : KMALLOC_ALLOCATE_BUCKETS;
> > > 	.size = __builtin_constant_p(size) ? size : SIZE_MAX;
> > > - during kernel start or module init, walk the alloc_tag list
> > >   and create either a fixed-size kmem_cache or to allocate a
> > >   full set of kmalloc-buckets, and update the "cache" member.
> > > - adjust kmalloc core routines to use current->alloc_tag->cache instead
> > >   of using the global buckets.
> > > 
> > > This would get us fully separated allocations, producing better than
> > > type-based levels of granularity, exceeding what we have currently with
> > > CONFIG_RANDOM_KMALLOC_CACHES.
> > > 
> > > Does this look possible, or am I misunderstanding something in the
> > > infrastructure being created here?
> > 
> > Definitely possible, but... would we want this?
> 
> Yes, very very much. One of the worst and mostly unaddressed weaknesses
> with the kernel right now is use-after-free based type confusion[0], which
> depends on merged caches (or cache reuse).
> 
> This doesn't solve cross-allocator (kmalloc/page_alloc) type confusion
> (as terrifyingly demonstrated[1] by Jann Horn), but it does help with
> what has been a very common case of "use msg_msg to impersonate your
> target object"[2] exploitation.

We have a ton of code that references PAGE_SIZE and uses the page
allocator completely unnecessarily - that's something worth harping
about at conferences; if we could motivate people to clean that stuff up
it'd have a lot of positive effects.

> > That would produce a _lot_ of kmem caches
> 
> Fewer than you'd expect, but yes, there is some overhead. However,
> out-of-tree forks of Linux have successfully experimented with this
> already and seen good results[3].

So in that case - I don't think there's any need for a separate
alloc_details; we'd just add a kmem_cache * to alloc_tag and then hook
into the codetag init/unload path to create and destroy the kmem caches.

No need to adjust the slab code either; alloc_hooks() itself could
dispatch to kmem_cache_alloc() instead of kmalloc() if this is in use.

