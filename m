Return-Path: <linux-fsdevel+bounces-11864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6408582C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FE81C218B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCD6130E38;
	Fri, 16 Feb 2024 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P/rHKmX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD412F39F
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101554; cv=none; b=Z8FNZ7hDdwUQQB+2dw262/FNj1BV2sUDCILiKUE9Y+VQDkCo4qByVr+bBQXo1NoIZkyhhtFntSoBWbiB5sMI9e2BXOj3kqcCRjw4i/9CzvMC+ZqJwTzCni60J/bYCInpE0v1SgdOQxWJwaVv8kgqY3Cce/7v3S3t+xYZG9RXk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101554; c=relaxed/simple;
	bh=PkWRMaDgTly/5ez9/SA93u9YGwFkohBiRhZ2gvWvgoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUFLzknWhFstODrY3O1ny1/JT/1Z61GmnSc7Epmbyhfp7Nf05aJIvmazc0d0VLj9RV3bP4BgyKuEe26lFbV/F1pRAb1raAhlK02fj6T0qXXH45byo0MD2SO6U6Qw5WK2C2m7tbG3RuqdiwGJy6MjZzqMlzn3O/85rpI9Bj5cIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P/rHKmX3; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 Feb 2024 11:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708101549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykstDffvORkHR/QBul+dunCrpEbnMsgllsNmRKwgALQ=;
	b=P/rHKmX3j/prO7tgG2j74FOBqArykGjAD+QXCi/CNWHvRgoNUgOhhnMDCES9P7PyrRETo+
	l/VeuBrESrdYcr+HcB7pGshKvMzuIAFjDfuOhDowTTeo3OT984nPcJzcavwvweaH8hU/1B
	3Wof2PoerJMLJIVUnvZFOQj0zf3N6Rg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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
Subject: Re: [PATCH v3 21/35] mm/slab: add allocation accounting into slab
 allocation and free paths
Message-ID: <vjtuo55tzxrezoxz54zav5oxp5djngtyftkgrj2mnimf4wqq6a@hedzv4xlrgv7>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-22-surenb@google.com>
 <ec0f9be2-d544-45a6-b6a9-178872b27bd4@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec0f9be2-d544-45a6-b6a9-178872b27bd4@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 16, 2024 at 05:31:11PM +0100, Vlastimil Babka wrote:
> On 2/12/24 22:39, Suren Baghdasaryan wrote:
> > Account slab allocations using codetag reference embedded into slabobj_ext.
> > 
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  mm/slab.h | 26 ++++++++++++++++++++++++++
> >  mm/slub.c |  5 +++++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 224a4b2305fb..c4bd0d5348cb 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -629,6 +629,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
> >  
> >  #endif /* CONFIG_SLAB_OBJ_EXT */
> >  
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +
> > +static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> > +					void **p, int objects)
> > +{
> > +	struct slabobj_ext *obj_exts;
> > +	int i;
> > +
> > +	obj_exts = slab_obj_exts(slab);
> > +	if (!obj_exts)
> > +		return;
> > +
> > +	for (i = 0; i < objects; i++) {
> > +		unsigned int off = obj_to_index(s, slab, p[i]);
> > +
> > +		alloc_tag_sub(&obj_exts[off].ref, s->size);
> > +	}
> > +}
> > +
> > +#else
> > +
> > +static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> > +					void **p, int objects) {}
> > +
> > +#endif /* CONFIG_MEM_ALLOC_PROFILING */
> 
> You don't actually use the alloc_tagging_slab_free_hook() anywhere? I see
> it's in the next patch, but logically should belong to this one.

I don't think it makes any sense to quibble about introducing something
in one patch that's not used until the next patch; often times, it's
just easier to review that way.

