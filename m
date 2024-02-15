Return-Path: <linux-fsdevel+bounces-11746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A38A856CBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 19:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2641F2848A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2D136641;
	Thu, 15 Feb 2024 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f0hAZFJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895F139562;
	Thu, 15 Feb 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021794; cv=none; b=V2diUKgZcjDDlY1tckvSXC793M7LPSeOu9ZNVWnmwWGm3YTr8jaS+SfeBeJQ5aUmVn86FQRd7Kn7bn8S4bGxox02d+dKL0G+X2szcSij+coR+Jx/QkPaMn5G6wp9WWPBlh8qQSMGMi8vqr1ctglqtRH6rMyu6ZqNf2xilEDpbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021794; c=relaxed/simple;
	bh=nqKSivlpykOU5aRvgMFi7Gq55Mo7pEcYs3weDz1dp+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stUl2XJOdgui9bHRffOZ14s870eGGAKz/1D2x1fNE2dc8FTQ32uMnkUQB9P8zXDggctdfy94POsEWwOlPD0bm1oQjWsid9jeQRrbq5F1oa+hM5kTc6eP3RxnTEpsM8xE8YqU20pXqfPrMT9RliIOm5R7Q56+v8OETBLbro+mJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f0hAZFJH; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 13:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708021790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhfBmJirNsqHXJktLhuMpinYcutoXu2NT5NVAvXIUmQ=;
	b=f0hAZFJHOvaRSVjmLM0URBKbO2TqcjlWIG6gzkHjx3Rq8tk1kJMF+EE25IP8jdRKYN3Dfl
	Bx8BonKRcNfBtJGsfFzfa//oBkb7e5ag/Ca9oOO5nGM2CIMRh64J6AlUyZjhzzwIjjk+Cr
	CxUh4L9AQue2vyXrnfcADk++1zL8KH4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, 
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
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
Message-ID: <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka>
 <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
 <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 08:47:59AM -0800, Suren Baghdasaryan wrote:
> On Thu, Feb 15, 2024 at 8:45 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 15-02-24 06:58:42, Suren Baghdasaryan wrote:
> > > On Thu, Feb 15, 2024 at 1:22 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
> > > > [...]
> > > > > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> > > > >  #ifdef CONFIG_MEMORY_FAILURE
> > > > >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
> > > > >  #endif
> > > > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > > > +     {
> > > > > +             struct seq_buf s;
> > > > > +             char *buf = kmalloc(4096, GFP_ATOMIC);
> > > > > +
> > > > > +             if (buf) {
> > > > > +                     printk("Memory allocations:\n");
> > > > > +                     seq_buf_init(&s, buf, 4096);
> > > > > +                     alloc_tags_show_mem_report(&s);
> > > > > +                     printk("%s", buf);
> > > > > +                     kfree(buf);
> > > > > +             }
> > > > > +     }
> > > > > +#endif
> > > >
> > > > I am pretty sure I have already objected to this. Memory allocations in
> > > > the oom path are simply no go unless there is absolutely no other way
> > > > around that. In this case the buffer could be preallocated.
> > >
> > > Good point. We will change this to a smaller buffer allocated on the
> > > stack and will print records one-by-one. Thanks!
> >
> > __show_mem could be called with a very deep call chains. A single
> > pre-allocated buffer should just do ok.
> 
> Ack. Will do.

No, we're not going to permanently burn 4k here.

It's completely fine if the allocation fails, there's nothing "unsafe"
about doing a GFP_ATOMIC allocation here.

