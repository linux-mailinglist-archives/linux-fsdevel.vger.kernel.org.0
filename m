Return-Path: <linux-fsdevel+bounces-17805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB928B2558
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 17:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC55D1F24CF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C614B080;
	Thu, 25 Apr 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lu6K1LeB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF21149E0C
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059592; cv=none; b=BQdPPGfJKf+9iICdKi6rNSyaqtM+tOjhS8LLye0SqTf9BbPC8dBwuNPRISr83WoLotIKw5Mqo4HpJJid7x63gQ4atMUclzmPxzDlHA+0jOcHfLhDGgc1DZbp9gWAETyr2knwP5nGDC+zlHIUb67nOHP3hlW2IU2kzlCWUB/tzug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059592; c=relaxed/simple;
	bh=WF+dlvX2I/JhfKIJrRxXQkXnpq+LBXuSxxxOJYIm9Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUWmx1EWIG6riEXoKOMdJNfSjFyPPUL0wE5d9RNPRW7kUck+e8BHcY75VvkXTI96mPt0HqghZgQaxNAQp5bhxF8OqOTUldYCkFIqHOH6n30+mJmJCT79v3hBgdPcU+NNstmHoXhXs4hHKPhSuh8KbRNaEHzVeXrCT2jQoMlqXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lu6K1LeB; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1229680276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714059590; x=1714664390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0BChCss6w1nIzeILAtQLE3LhBpW3YXUB4HhPqTq7zU=;
        b=Lu6K1LeBSNBNuTVNCNhOq9CVfWCgWKfOOjLOuPvMlbZ4TbQX9Y6s3T3Dfquhqvq1gF
         mSGKoXEglg6vdgTDr5v9G47Ub46LTi7qUsk9DMx4zz8NmC2nBp58STboK2hpJPK6D8vG
         o+k4gfJ4LMFLggYdCwnnrRUKnZBBA4vmXiIPPSCwSNsbpdnV+ZvkvC1X8/O9rc+7Ft5w
         BDqipbhrArlE1vJtRM3CYBzMarSxplWxzeMnYt3vsxsEkfrb0jSHO8Nssq7cY4Ni3EIp
         ivIsN7Lhc03KWHjEh+harc3wwEVQW9cNDWot+8WGoPk7E/RremVKM910I6z8wswDBghp
         OxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714059590; x=1714664390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0BChCss6w1nIzeILAtQLE3LhBpW3YXUB4HhPqTq7zU=;
        b=IoN3MiCWlYls9QAWB8hIOaktTbT6mYIzbwmozQSc+IDQfkPUqKU9fSoUnRYXBZZaHb
         CSH3nFYRDozdVqQlsKM6D0eBbfaH5IBUX1FQKvbKaVGuKQN29RZ1t6i2cUs1zOd+T2A+
         C3L5kn7y6f8bPaay0vHGXZhJQJFjZDE4qp7nYxOKyE+ISC6jOfzbfLF5h3bh67/eLqhm
         BR/hwoprdMoYH5Zyje0nFjryWeBvipTcRDRoaXrTLuNGt03ebGhsbq5e533x6bw4kWDV
         ho9Im3CzwI4AOXKdix7+DRz3es17QQaNVQIHPfSyiIJQlVo/3w8+KkkumTPrQ1Ie2L5R
         qKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqk9E04AtYavkqsrZwZCM8RbjfNwV37DOwz3HPNAA8OJeaC/WhldmYKFpjEjrFou194tdySaIFEQgxLb92BLDUB9YD8i9CV0nSPTQ9HQ==
X-Gm-Message-State: AOJu0Yy7CZqOQMvDDsdPx/nJJYgRi7ugIEpET5hN+cZFwUNugotEh/XH
	0apxjhqgVig3JgV4RiSo5r9XmXo7dNKRxQFymhTfFw2aHQ88iJ7KfPzNB1LrWgj0HW0p2ZUr88l
	MAGkXksKcT7SmKGao7D7w6o/OuudjW9M6mqR0
X-Google-Smtp-Source: AGHT+IHMmrQCod73kiqRAvCkDsnHTcOLVG7U0Dhn6OWsLE5Eza4GBBk8ZEiq+Ddus8vlXjyfwMqyLLjmcyn5VeI1piA=
X-Received: by 2002:a05:6902:54b:b0:de1:849:a6f3 with SMTP id
 z11-20020a056902054b00b00de10849a6f3mr5525501ybs.7.1714059589879; Thu, 25 Apr
 2024 08:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <202404241852.DC4067B7@keescook>
 <3eyvxqihylh4st6baagn6o6scw3qhcb6lapgli4wsic2fvbyzu@h66mqxcikmcp>
In-Reply-To: <3eyvxqihylh4st6baagn6o6scw3qhcb6lapgli4wsic2fvbyzu@h66mqxcikmcp>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Apr 2024 08:39:37 -0700
Message-ID: <CAJuCfpFtj7MVY+9FaKfq0w7N1qw8=jYifC0sBUAySk=AWBhK6Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, songmuchun@bytedance.com, 
	jbaron@akamai.com, aliceryhl@google.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:26=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Wed, Apr 24, 2024 at 06:59:01PM -0700, Kees Cook wrote:
> > On Thu, Mar 21, 2024 at 09:36:22AM -0700, Suren Baghdasaryan wrote:
> > > Low overhead [1] per-callsite memory allocation profiling. Not just f=
or
> > > debug kernels, overhead low enough to be deployed in production.
> >
> > Okay, I think I'm holding it wrong. With next-20240424 if I set:
> >
> > CONFIG_CODE_TAGGING=3Dy
> > CONFIG_MEM_ALLOC_PROFILING=3Dy
> > CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=3Dy
> >
> > My test system totally freaks out:
> >
> > ...
> > SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, Nodes=3D1
> > Oops: general protection fault, probably for non-canonical address 0xc3=
88d881e4808550: 0000 [#1] PREEMPT SMP NOPTI
> > CPU: 0 PID: 0 Comm: swapper Not tainted 6.9.0-rc5-next-20240424 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06=
/2015
> > RIP: 0010:__kmalloc_node_noprof+0xcd/0x560
> >
> > Which is:
> >
> > __kmalloc_node_noprof+0xcd/0x560:
> > __slab_alloc_node at mm/slub.c:3780 (discriminator 2)
> > (inlined by) slab_alloc_node at mm/slub.c:3982 (discriminator 2)
> > (inlined by) __do_kmalloc_node at mm/slub.c:4114 (discriminator 2)
> > (inlined by) __kmalloc_node_noprof at mm/slub.c:4122 (discriminator 2)
> >
> > Which is:
> >
> >         tid =3D READ_ONCE(c->tid);
> >
> > I haven't gotten any further than that; I'm EOD. Anyone seen anything
> > like this with this series?
>
> I certainly haven't. That looks like some real corruption, we're in slub
> internal data structures and derefing a garbage address. Check kasan and
> all that?

Hi Kees,
I tested next-20240424 yesterday with defconfig and
CONFIG_MEM_ALLOC_PROFILING enabled but didn't see any issue like that.
Could you share your config file please?
Thanks,
Suren.

