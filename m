Return-Path: <linux-fsdevel+bounces-11753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F06856EA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56871F23D2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 20:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6EF13B2B9;
	Thu, 15 Feb 2024 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uKMqNbYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4729A13A88D
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029228; cv=none; b=m0dftkhK8ytmuUhTen99GIkqEinY2bVmOH01gIqAkb1+i5YIn/lnHr4dThGQEGgWu9E364dxJk6ayEYA4Gs1jpePisRIWh/h7Rf0RJnBdog3b7aTdlhapFPf9eYDSnzms3grQyPKenz9lip2Q61wSnjcYGibpzoDGW/VBFMl7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029228; c=relaxed/simple;
	bh=svZI8lR5yuLAKcmkdT/NwJ0LBFg7C4bhwIEcPtd4wK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7+CDKP6nLGLQm7kIrXu8uDdS5kiI4ZMfwc1fMspP/q5Di4DxsbC1bKf8BZTpcfb02VoHEYB556tLvBeJG/bTpTTszyEBFHfakQUtag6Oe2KtSfXaxlahjR8cAVXQSi+GyVLJGnkRYXUS2s6casUC5+7BmRc1hnptLAya8KP83Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uKMqNbYR; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 15:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1h3mKBhbYx2gO9e1zxP9AUVbRxFOpkSn+Z2PNxlzZgw=;
	b=uKMqNbYRWjGlI+HaoeIYPI5ERvXjACozyNlWdRNl+Qg1jnpaLiF79qYZW/RTxK0qgoH1Wj
	xEHLKTRGoGqywmCPXSAl2Kq3qU0Ae4RnatPfkhFcJzRdH8nYJYHyebbvQZadulqXqF8Jgg
	hvFxKVPZazAslAUs1cKqTwK9orq6Wkw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
Message-ID: <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka>
 <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
 <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 09:22:07PM +0100, Vlastimil Babka wrote:
> On 2/15/24 19:29, Kent Overstreet wrote:
> > On Thu, Feb 15, 2024 at 08:47:59AM -0800, Suren Baghdasaryan wrote:
> >> On Thu, Feb 15, 2024 at 8:45 AM Michal Hocko <mhocko@suse.com> wrote:
> >> >
> >> > On Thu 15-02-24 06:58:42, Suren Baghdasaryan wrote:
> >> > > On Thu, Feb 15, 2024 at 1:22 AM Michal Hocko <mhocko@suse.com> wrote:
> >> > > >
> >> > > > On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
> >> > > > [...]
> >> > > > > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> >> > > > >  #ifdef CONFIG_MEMORY_FAILURE
> >> > > > >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
> >> > > > >  #endif
> >> > > > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> >> > > > > +     {
> >> > > > > +             struct seq_buf s;
> >> > > > > +             char *buf = kmalloc(4096, GFP_ATOMIC);
> >> > > > > +
> >> > > > > +             if (buf) {
> >> > > > > +                     printk("Memory allocations:\n");
> >> > > > > +                     seq_buf_init(&s, buf, 4096);
> >> > > > > +                     alloc_tags_show_mem_report(&s);
> >> > > > > +                     printk("%s", buf);
> >> > > > > +                     kfree(buf);
> >> > > > > +             }
> >> > > > > +     }
> >> > > > > +#endif
> >> > > >
> >> > > > I am pretty sure I have already objected to this. Memory allocations in
> >> > > > the oom path are simply no go unless there is absolutely no other way
> >> > > > around that. In this case the buffer could be preallocated.
> >> > >
> >> > > Good point. We will change this to a smaller buffer allocated on the
> >> > > stack and will print records one-by-one. Thanks!
> >> >
> >> > __show_mem could be called with a very deep call chains. A single
> >> > pre-allocated buffer should just do ok.
> >> 
> >> Ack. Will do.
> > 
> > No, we're not going to permanently burn 4k here.
> > 
> > It's completely fine if the allocation fails, there's nothing "unsafe"
> > about doing a GFP_ATOMIC allocation here.
> 
> Well, I think without __GFP_NOWARN it will cause a warning and thus
> recursion into __show_mem(), potentially infinite? Which is of course
> trivial to fix, but I'd myself rather sacrifice a bit of memory to get this
> potentially very useful output, if I enabled the profiling. The necessary
> memory overhead of page_ext and slabobj_ext makes the printing buffer
> overhead negligible in comparison?

__GFP_NOWARN is a good point, we should have that.

But - and correct me if I'm wrong here - doesn't an OOM kick in well
before GFP_ATOMIC 4k allocations are failing? I'd expect the system to
be well and truly hosed at that point.

If we want this report to be 100% reliable, then yes the preallocated
buffer makes sense - but I don't think 100% makes sense here; I think we
can accept ~99% and give back that 4k.

