Return-Path: <linux-fsdevel+bounces-11748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7419856D17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 19:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37399B2D79D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 18:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570491386A3;
	Thu, 15 Feb 2024 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JN/LPHA6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B7136994
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022301; cv=none; b=oI+ep7IQ9vgPZKxfrI0dg9OHFWyGcFyD2C6xX6ESDMTRkJbKPjNIC5xQc2LF6wLmJwn9bapH9xdetxndBOEGikppjjsCs3rV1v5o5B3+Bzyq0yLlkOjjscnjvvA3C3oDgaFxxjunGvBvt2v690nuPUw/OAXcDo3iMLhF6+OBCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022301; c=relaxed/simple;
	bh=1qVom1rSiklCLS5RbXYjODOEuKVFGJz+okg7fDM+Ia0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVz4v2mk224HO2jhXklSOoLphQ8sTZKWY7Ck83z1vbA6rZ5LOFaxFSFy8rcyChmcdV4VoUe/sxQj6uafueZ69JBydC5qrElb6g+cZCabSEuBzClBluoYKOElLP0OVXLvQVFeZTuJ93Gd6mv2Dr9HgBHbmO1RU1ui0dUyTsC1tBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JN/LPHA6; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 13:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708022297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MX5iN/R1aA7qp1uBjwVKqzgAyTA6O01vDbmEmEpF1HI=;
	b=JN/LPHA6l0xQ7QMKiDnxsNR2Ab6ALTGJ4OE63oTahR1/1K8veWc90tjRp4QXqdUElopDI5
	YH5NElMZRXmq24WL24GA6MqkZu9wAXmJwNLE+wgHedUF1t2ic5fKjMy5mDaNTCYjsqAX5o
	vtrOv4NPQDR3Mz1YWEXaxTFt9VFFDKU=
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
Message-ID: <qjw54t5doykhej63f5l5k7zee4fuiekkdp7px67f3bgu7y4bec@2akbmyhn2ubz>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka>
 <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
 <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <CAJuCfpFCu73eCMo-hd=vvvMhGjEuOwvkcGb2DuDssHC5soNFGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFCu73eCMo-hd=vvvMhGjEuOwvkcGb2DuDssHC5soNFGw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 10:33:53AM -0800, Suren Baghdasaryan wrote:
> On Thu, Feb 15, 2024 at 10:29 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, Feb 15, 2024 at 08:47:59AM -0800, Suren Baghdasaryan wrote:
> > > On Thu, Feb 15, 2024 at 8:45 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 15-02-24 06:58:42, Suren Baghdasaryan wrote:
> > > > > On Thu, Feb 15, 2024 at 1:22 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
> > > > > > [...]
> > > > > > > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> > > > > > >  #ifdef CONFIG_MEMORY_FAILURE
> > > > > > >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
> > > > > > >  #endif
> > > > > > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > > > > > +     {
> > > > > > > +             struct seq_buf s;
> > > > > > > +             char *buf = kmalloc(4096, GFP_ATOMIC);
> > > > > > > +
> > > > > > > +             if (buf) {
> > > > > > > +                     printk("Memory allocations:\n");
> > > > > > > +                     seq_buf_init(&s, buf, 4096);
> > > > > > > +                     alloc_tags_show_mem_report(&s);
> > > > > > > +                     printk("%s", buf);
> > > > > > > +                     kfree(buf);
> > > > > > > +             }
> > > > > > > +     }
> > > > > > > +#endif
> > > > > >
> > > > > > I am pretty sure I have already objected to this. Memory allocations in
> > > > > > the oom path are simply no go unless there is absolutely no other way
> > > > > > around that. In this case the buffer could be preallocated.
> > > > >
> > > > > Good point. We will change this to a smaller buffer allocated on the
> > > > > stack and will print records one-by-one. Thanks!
> > > >
> > > > __show_mem could be called with a very deep call chains. A single
> > > > pre-allocated buffer should just do ok.
> > >
> > > Ack. Will do.
> >
> > No, we're not going to permanently burn 4k here.
> 
> We don't need 4K here. Just enough to store one line and then print
> these 10 highest allocations one line at a time. This way we can also
> change that 10 to any higher number we like without any side effects.

There's no reason to make the change at all. If Michal thinks there's
something "dangerous" about allocating a buffer here, he needs to able
to explain what it is.

