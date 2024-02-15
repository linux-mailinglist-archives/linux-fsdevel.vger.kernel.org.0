Return-Path: <linux-fsdevel+bounces-11747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2CB856CCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 19:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DBF1F2276F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 18:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A8813A886;
	Thu, 15 Feb 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPZiK8qO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC413A245
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022050; cv=none; b=VC31827mIXxSw6WnbrvtJVtxLbnv5DfdJ0Mu7a2vNxlaYBU3k7HEZAaapy+JWmHdS9u+EjyhuCYXy/zbMG8Oe7VykHrbjbvgHlFu/Fzj4unCbZAwT/lnTW1R5QEmTX4Qm6zUiuSZg0aPGxZduSzdUVDNUGP1vQ7NIFNzr7ksiGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022050; c=relaxed/simple;
	bh=EkHV+pK0QXOWaf9RwSvvipbxHFbyApBZyCN11/BLKS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/x2fHMy73dGLhf0tC3+OARZ9YQkJKcuh9xUpMRwHYDDuWNyJwNiM+iIY+ljnWEcL/UiyaA3QYrWqiLW0ovzFZL5jT81rgyLAJNXvEYXQ/9rLr0mjbciWicc4i7fb8822EfENrThtFQlXRqUsYCFCoga4u95vJzy2VRktTMaRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPZiK8qO; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc71031680so1118035276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 10:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708022047; x=1708626847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/zbyo2KXw6JhtuTeO6vuT3ARKuU8XObNaLi3n/GNPQ=;
        b=HPZiK8qOi6j8eHtrVWkMY3/y5zdg/R+snoTpxl7otDapqq8U5nGISzOlEkPxZVJOdI
         XR6njoQyRhO65h5YNcGuFvkesKajuM20CnxqrI9baL2knQfhsz9i1+UJTfO/Fwv2mWTf
         ktaaM3njCRzf4blGVz++m8/G8b/gI10LhL7Lo9omGw4CKaE33N35IUtraESVDyXf3BoB
         +kSU70ufu2xuFOyyFPJ3MNb80cNFbgtERN/ovjHCNXsLMp8aiUnGWyQ+KIEnZK5WjyH6
         fjfew7jLvJTyZxNKc/fe0U0yIcdA0rN1LrHpAsojFlar/bktGjvn9Bhpp1YDl4RdPR2v
         cRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708022047; x=1708626847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/zbyo2KXw6JhtuTeO6vuT3ARKuU8XObNaLi3n/GNPQ=;
        b=t3c5lTFzrmCHQcm0Zm/Z9uBjwp80eqa02mJ1jesYFjsM0jFlaFJKpiHxIahg32DDwG
         n858SvmiM+4PIQDEQfMSZIHOoLW5kKdXLHRInDZEqyNUQ6y2u1/dT1hMucWtN8mbhJOG
         D7KkDTvbOaWEzCQG6Tfl5UYHiTgXP9uv/JbNZ/gIxoKMqq+Gwlpr4U9WQZTrSp5ytr0E
         sVmFjyE/IMmXa5PICY9UT//dVZtibtR+aBPrOWgvQDpOTJK9qasNq5268CqFIgOx38Lt
         r+w4Aj3mNi0aEqSq8iDB1CJjpy/7BAkWmh7N8Rp50ZcBZoyXpAHCyR5TfKmoRjF3WY+l
         WKbA==
X-Forwarded-Encrypted: i=1; AJvYcCXF4pifF1T5Kreg35CvFKp8IySnQRxIn0eJI4garJBo6H/QDdqxPHCuvwX9KSPX/wt0Sm3QYVFCbD0O7Hcg6SF1G0jScTCaIxe+s/CKaw==
X-Gm-Message-State: AOJu0YyP0sYIsyc56IPxLWdcI5mIT4zS2X1QcMv2QNUOUPp0LMXHE/Ya
	7mkC/1SvSM9dCR9uJDgryECqubEGV6cJhgQ0RWEAmtovvPm0rCPJF+3qL71i6GD1f6qel6yHrtr
	xWrOLn3TJxKcpvAsV0rJzvpWY8wfPE3Wspa1q
X-Google-Smtp-Source: AGHT+IEt7T1ebO4wrqtMW0nsnctPBGiEDzeC44EjMTKbens2LRTQqSvb2ncntkrHv+IFqf/aB+CXdxd6L9MiMSXl2r0=
X-Received: by 2002:a25:bac5:0:b0:dc6:a223:bb3b with SMTP id
 a5-20020a25bac5000000b00dc6a223bb3bmr2333936ybk.46.1708022046848; Thu, 15 Feb
 2024 10:34:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka> <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka> <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
In-Reply-To: <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 10:33:53 -0800
Message-ID: <CAJuCfpFCu73eCMo-hd=vvvMhGjEuOwvkcGb2DuDssHC5soNFGw@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
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

On Thu, Feb 15, 2024 at 10:29=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Feb 15, 2024 at 08:47:59AM -0800, Suren Baghdasaryan wrote:
> > On Thu, Feb 15, 2024 at 8:45=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Thu 15-02-24 06:58:42, Suren Baghdasaryan wrote:
> > > > On Thu, Feb 15, 2024 at 1:22=E2=80=AFAM Michal Hocko <mhocko@suse.c=
om> wrote:
> > > > >
> > > > > On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
> > > > > [...]
> > > > > > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodem=
ask_t *nodemask, int max_zone_idx)
> > > > > >  #ifdef CONFIG_MEMORY_FAILURE
> > > > > >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_po=
isoned_pages));
> > > > > >  #endif
> > > > > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > > > > +     {
> > > > > > +             struct seq_buf s;
> > > > > > +             char *buf =3D kmalloc(4096, GFP_ATOMIC);
> > > > > > +
> > > > > > +             if (buf) {
> > > > > > +                     printk("Memory allocations:\n");
> > > > > > +                     seq_buf_init(&s, buf, 4096);
> > > > > > +                     alloc_tags_show_mem_report(&s);
> > > > > > +                     printk("%s", buf);
> > > > > > +                     kfree(buf);
> > > > > > +             }
> > > > > > +     }
> > > > > > +#endif
> > > > >
> > > > > I am pretty sure I have already objected to this. Memory allocati=
ons in
> > > > > the oom path are simply no go unless there is absolutely no other=
 way
> > > > > around that. In this case the buffer could be preallocated.
> > > >
> > > > Good point. We will change this to a smaller buffer allocated on th=
e
> > > > stack and will print records one-by-one. Thanks!
> > >
> > > __show_mem could be called with a very deep call chains. A single
> > > pre-allocated buffer should just do ok.
> >
> > Ack. Will do.
>
> No, we're not going to permanently burn 4k here.

We don't need 4K here. Just enough to store one line and then print
these 10 highest allocations one line at a time. This way we can also
change that 10 to any higher number we like without any side effects.

>
> It's completely fine if the allocation fails, there's nothing "unsafe"
> about doing a GFP_ATOMIC allocation here.

