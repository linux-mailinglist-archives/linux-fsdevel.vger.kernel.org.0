Return-Path: <linux-fsdevel+bounces-11750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F40E856D1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 19:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26301C23A9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 18:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A5C31A60;
	Thu, 15 Feb 2024 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FaVsFLVE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F571386B2
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023016; cv=none; b=QLTahCu/hAYjKMn1lsJKuhoazqnvUPwlad9L87lDj/aCn66CpqAXi5FPtrcKfOkbCKV9mx7wjc9Wpap2Nd/5KbkjYTY28CHejDpvIkSvuQPGtdQIEnajs1H6RKaBz5oT04q1Av8H4HfoipFPkJZry3UhjVahp9qhTQ2IUaq8r8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023016; c=relaxed/simple;
	bh=S81pGoJ8PfU6aLi9PbShqhGOm1UW2ATW5Cnzr2dZfPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+i2fYzAJkmFPoeHkEWZ+0vClOT4kBh2DgFj7Js6NftNTvudgZiNc3RqcO5C/0P4SN/iURPjywSKqfwkeHDnYYD9qxIcjtRcZKKixXoPgnVHh0WENnfvDUaTVoTj0dZk1tbzOlyktAXEM2OW9STvEk5wSZqu0dEPbHKTWt+4Ii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FaVsFLVE; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so956532276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 10:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708023013; x=1708627813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUlsSeO8LefyO4xLZYNJ9jNHAOJrLbOdsT9pDfMZXA8=;
        b=FaVsFLVEmA/s7ZT+0qO05AKXq3N/CiEGTriEZX7A1DGDJu+w1odmSr6HyTCYMjbV/p
         pHNLIglR5WAk9m6jUQDHKSke2WnBRfGXbEySMMp9AcsXTOBrKN6s8jk7R+7rZkDKyym7
         cG6Erf05ctrJfX2/NfOlgZ+M1foaKS/+HcrI/4AsoM+HCmlwK6xolxVG8x7KJH8As5iS
         9uL3wapXE+fnUbo4UBvkgIdVP3y/ZIZ9nGwUYohlCvChaCgEXpZUfFHhjlnz8NQgQMOc
         XBbCXc8NQPcbL33CqBpVRI7h/IjT77LeRLlOXkLJePz+Asgvtpv6zvWhqFcu8Agg+KE+
         9+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708023013; x=1708627813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUlsSeO8LefyO4xLZYNJ9jNHAOJrLbOdsT9pDfMZXA8=;
        b=Nij4LS38HHfxe4z4w19nFFMCrWgngqg8nZLHJMWke/lEpuVeLqLJgcX8yi7qma0PyA
         RCiWn5J+qrWDoLbnVopeYfAR9qTPXtxEdeI3Q9NPaJ7RvR/hsb1fy2HCfzcyST5uq15d
         gh1TnltOuoDEdjYdBjDPbCB8fOs57uRcF70lYcWI/ghkatlaPNZjY83ASMH5/8KQ8ji4
         ZTsyvF5VtGfKSivNcr+uZoAzhhr1f/sDZUcE9kAZzp5o7YZaAMPJICmf93aJJbiYjhNL
         nKeFOOrFhoSPlhnEzjMYXBMoW3w72X9lCPGlT80qvbu0AzKsTIq26h6vvYDdL2nMq1U3
         wHtw==
X-Forwarded-Encrypted: i=1; AJvYcCUDw6eOMgGw3qyYqu6+2fKMzqnNlkNY0GsULScY1Ikgu2RWRN+aYkcQI80YIW9eBO/gWX3kLkJFsDu36uC5dXy0ef564Yaf18l3lGtEvw==
X-Gm-Message-State: AOJu0Yw5Y5JMJLUOkA27I7THfCHVMgHJZ+RA6xWRVVutvHSvwhl1DXGd
	Q09q8usPRu/c33K8GoE+jFYf7v9uYam0bwUsVQbZHJwqx3tCiq3KbGxgRgLsdEFNM5n6znOlJXk
	HN4tfPby4hapMFQSb/rHSMiRDbPy5GzJOkdPx
X-Google-Smtp-Source: AGHT+IHQQXGNaksc4ZLhdDELtvsfOEVbOUct07hRFV1UcZvxQkhvZT74vejiVn2ZOSoGey1AwcE3FMB7Y05S+V1u8DE=
X-Received: by 2002:a25:ae28:0:b0:dc2:4fff:75ee with SMTP id
 a40-20020a25ae28000000b00dc24fff75eemr1999749ybj.3.1708023012635; Thu, 15 Feb
 2024 10:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka> <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka> <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut> <Zc5a8MsJyt27jeJC@tiehlicka>
In-Reply-To: <Zc5a8MsJyt27jeJC@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 10:49:59 -0800
Message-ID: <CAJuCfpH2EF8DZhBp_7324ka7mnMkUdWyqTs+ZiMhwjm_nmcwZQ@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Michal Hocko <mhocko@suse.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, akpm@linux-foundation.org, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:41=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 15-02-24 13:29:40, Kent Overstreet wrote:
> > On Thu, Feb 15, 2024 at 08:47:59AM -0800, Suren Baghdasaryan wrote:
> > > On Thu, Feb 15, 2024 at 8:45=E2=80=AFAM Michal Hocko <mhocko@suse.com=
> wrote:
> > > >
> > > > On Thu 15-02-24 06:58:42, Suren Baghdasaryan wrote:
> > > > > On Thu, Feb 15, 2024 at 1:22=E2=80=AFAM Michal Hocko <mhocko@suse=
.com> wrote:
> > > > > >
> > > > > > On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
> > > > > > [...]
> > > > > > > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nod=
emask_t *nodemask, int max_zone_idx)
> > > > > > >  #ifdef CONFIG_MEMORY_FAILURE
> > > > > > >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_=
poisoned_pages));
> > > > > > >  #endif
> > > > > > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > > > > > +     {
> > > > > > > +             struct seq_buf s;
> > > > > > > +             char *buf =3D kmalloc(4096, GFP_ATOMIC);
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
> > > > > > I am pretty sure I have already objected to this. Memory alloca=
tions in
> > > > > > the oom path are simply no go unless there is absolutely no oth=
er way
> > > > > > around that. In this case the buffer could be preallocated.
> > > > >
> > > > > Good point. We will change this to a smaller buffer allocated on =
the
> > > > > stack and will print records one-by-one. Thanks!
> > > >
> > > > __show_mem could be called with a very deep call chains. A single
> > > > pre-allocated buffer should just do ok.
> > >
> > > Ack. Will do.
> >
> > No, we're not going to permanently burn 4k here.
> >
> > It's completely fine if the allocation fails, there's nothing "unsafe"
> > about doing a GFP_ATOMIC allocation here.
>
> Nobody is talking about safety. This is just a wrong thing to do when
> you are likely under OOM situation. This is a situation when you
> GFP_ATOMIC allocation is _likely_ to fail. Yes, yes you will get some
> additional memory reservers head room, but you shouldn't rely on that
> because that will make the output unreliable. Not something you want in
> situation when you really want to know that information.
>
> More over you do not need to preallocate a full page.

Folks, please stop arguing about it. We have more important things to
do. I'll fix it to use a small preallocated buffer.

>
> --
> Michal Hocko
> SUSE Labs

