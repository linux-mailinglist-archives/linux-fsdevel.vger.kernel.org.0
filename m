Return-Path: <linux-fsdevel+bounces-12983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F992869CD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8389B3011B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886CE4C63D;
	Tue, 27 Feb 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKD7Q0CU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378F149E1D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051952; cv=none; b=cY6+kekcQv0sqB1ZpyZorO32eVyQnGPut0JuYYXo41MfKCwdgXJFWcAzT1Q8Qs0ySTK7YT2Fe9gmqq2qE7GUu2TWUU1r+TtLmM2P42djO4twfcempwxeDsiEzluDpla/ZXz++fqHuFzo4A6jSOuEmuRu/9jndhm8pRjYINVCOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051952; c=relaxed/simple;
	bh=NgpWdnxiLbFqNexAmzcqA9YP7ocmvHBLOxsvEhPCKvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTsV/f/ebKAuGx59bCKgeilRS+be2S3htWzPENBJIYSKt3MHWr6iTKiRQ3/4O+hnZC+S+wwxKVazQLMIKE0BLrVmW9kk5zImvCrnRZH/byZweP1tHrU06iIEydLPnKGYOYxa/ayakNkR24A6kAnFlVN4C1T3dYc4OTqdbRTykP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QKD7Q0CU; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-608e3530941so29954157b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 08:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709051948; x=1709656748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/ds6xBAyNMUyUudVMgCcZQOOdZHJrbf6LFZuMELU1U=;
        b=QKD7Q0CU+PmNSO7RJww0aB+q3R7zUuzk7/y1EuKmJFnj7MkMmhvOdGPLJ/dOhGOi/j
         SqDwkcPkraX8yTXe804U9TSSRoF6+z6sgaBoWk+hpR/ZxiTDheObd6jWF+A7MtkSz++w
         Av2kDuZInsSMRm2hAAUb4BLDauRLOBm4yx8tXlbBX9PUbwx8iyfnP7ev0xXkMYZMZ8in
         Gbz0hc9sqnLaZbD8ji4kT71KIkoKUtZoTysPK6cwhRxOd+XLYxh0Dk+hke3ItkHhX3MX
         QnLp0UhMtRJxMw5uYVO4j5oLc6fuvHGwfsRshcOlf2JGk4vHAkKCVDhhP4gfz0Gy661o
         lNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051948; x=1709656748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/ds6xBAyNMUyUudVMgCcZQOOdZHJrbf6LFZuMELU1U=;
        b=DcDU/zPZZxcywdFlSp4omlJEnv02rEt0zhbIdS7/JbhHPs/rg5fWyse2VTGUl+7OJ0
         Y7c/HQTwT7CX87AGpyiZCbkYBCj2wMm3IDz9qT0/zWmMmvEeGsFvkUEHwqzahR+k0z0g
         hmySF2PSfSrNFjvmk1kdFDZm8hm0ranneET5FVYrhLhw9n4EqCVxkdJa2uhi5IAD9edI
         N7kVFRmlS/7mGEeMmFvgbDWUew5L7eRPR9x3VQCQOfVfgVVkbtQW+2s6dx1lETGn/lZX
         QnDtMJYdF6h1rh6O+QEyYyiRGrhjmqkE8hHZFFgd92WIWu2+CP5sr7/q6szJmU1QUQXC
         5tng==
X-Forwarded-Encrypted: i=1; AJvYcCW4HUJ8nxqOD+HYC5MY3QqvUVVS7AnvBD9JcYvwwUGDlrUZhguY/7+/3KGMudEtxubtX6g5OsEHtwNZ3ugdokQ9cwwoF8TXvRkPDqrj1Q==
X-Gm-Message-State: AOJu0YzQKgR7CO+9K/B39S/TXD1ztWueLWq9JIm6GrWL+ktlan4rpw9o
	6vt6a2g1WYsIYdN/nRksLgN8l6b4EuBxTShAhl0b10SdIUz1OhMtcwtOifzn2HCtMVwp3hwwX+d
	t3NYIy5pF5gauFhVtXvF/T6SqfrWKyGMjhVj5
X-Google-Smtp-Source: AGHT+IGYsfj1hpFG2qZ+lv3Tc2gaVahH2B+pghzlhO4uZB2pAxOqLV3b7HUJfJpPshrzze8w4TdCoPFLjSNMBWpeWIM=
X-Received: by 2002:a0d:cc52:0:b0:609:2c38:4dd2 with SMTP id
 o79-20020a0dcc52000000b006092c384dd2mr1712145ywd.42.1709051948102; Tue, 27
 Feb 2024 08:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-20-surenb@google.com>
 <2daf5f5a-401a-4ef7-8193-6dca4c064ea0@suse.cz>
In-Reply-To: <2daf5f5a-401a-4ef7-8193-6dca4c064ea0@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Feb 2024 08:38:54 -0800
Message-ID: <CAJuCfpGt+zfFzfLSXEjeTo79gw2Be-UWBcJq=eL1qAnPf9PaiA@mail.gmail.com>
Subject: Re: [PATCH v4 19/36] mm: create new codetag references during page splitting
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

On Tue, Feb 27, 2024 at 2:10=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > When a high-order page is split into smaller ones, each newly split
> > page should get its codetag. The original codetag is reused for these
> > pages but it's recorded as 0-byte allocation because original codetag
> > already accounts for the original high-order allocated page.
>
> This was v3 but then you refactored (for the better) so the commit log
> could reflect it?

Yes, technically mechnism didn't change but I should word it better.
Smth like this:

When a high-order page is split into smaller ones, each newly split
page should get its codetag. After the split each split page will be
referencing the original codetag. The codetag's "bytes" counter
remains the same because the amount of allocated memory has not
changed, however the "calls" counter gets increased to keep the
counter correct when these individual pages get freed.

>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> I was going to R-b, but now I recalled the trickiness of
> __free_pages() for non-compound pages if it loses the race to a
> speculative reference. Will the codetag handling work fine there?

I think so. Each non-compoud page has its individual reference to its
codetag and will decrement it whenever the page is freed. IIUC the
logic in  __free_pages(), when it loses race to a speculative
reference it will free all pages except for the first one and the
first one will be freed when the last put_page() happens. If prior to
this all these pages were split from one page then all of them will
have their own reference which points to the same codetag. Every time
one of these pages are freed that codetag's "bytes" and "calls"
counters will be decremented. I think accounting will work correctly
irrespective of where these pages are freed, in __free_pages() or by
put_page().

>
> > ---
> >  include/linux/pgalloc_tag.h | 30 ++++++++++++++++++++++++++++++
> >  mm/huge_memory.c            |  2 ++
> >  mm/page_alloc.c             |  2 ++
> >  3 files changed, 34 insertions(+)
> >
> > diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
> > index b49ab955300f..9e6ad8e0e4aa 100644
> > --- a/include/linux/pgalloc_tag.h
> > +++ b/include/linux/pgalloc_tag.h
> > @@ -67,11 +67,41 @@ static inline void pgalloc_tag_sub(struct page *pag=
e, unsigned int order)
> >       }
> >  }
> >
> > +static inline void pgalloc_tag_split(struct page *page, unsigned int n=
r)
> > +{
> > +     int i;
> > +     struct page_ext *page_ext;
> > +     union codetag_ref *ref;
> > +     struct alloc_tag *tag;
> > +
> > +     if (!mem_alloc_profiling_enabled())
> > +             return;
> > +
> > +     page_ext =3D page_ext_get(page);
> > +     if (unlikely(!page_ext))
> > +             return;
> > +
> > +     ref =3D codetag_ref_from_page_ext(page_ext);
> > +     if (!ref->ct)
> > +             goto out;
> > +
> > +     tag =3D ct_to_alloc_tag(ref->ct);
> > +     page_ext =3D page_ext_next(page_ext);
> > +     for (i =3D 1; i < nr; i++) {
> > +             /* Set new reference to point to the original tag */
> > +             alloc_tag_ref_set(codetag_ref_from_page_ext(page_ext), ta=
g);
> > +             page_ext =3D page_ext_next(page_ext);
> > +     }
> > +out:
> > +     page_ext_put(page_ext);
> > +}
> > +
> >  #else /* CONFIG_MEM_ALLOC_PROFILING */
> >
> >  static inline void pgalloc_tag_add(struct page *page, struct task_stru=
ct *task,
> >                                  unsigned int order) {}
> >  static inline void pgalloc_tag_sub(struct page *page, unsigned int ord=
er) {}
> > +static inline void pgalloc_tag_split(struct page *page, unsigned int n=
r) {}
> >
> >  #endif /* CONFIG_MEM_ALLOC_PROFILING */
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 94c958f7ebb5..86daae671319 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/sched/sysctl.h>
> >  #include <linux/memory-tiers.h>
> >  #include <linux/compat.h>
> > +#include <linux/pgalloc_tag.h>
> >
> >  #include <asm/tlb.h>
> >  #include <asm/pgalloc.h>
> > @@ -2899,6 +2900,7 @@ static void __split_huge_page(struct page *page, =
struct list_head *list,
> >       /* Caller disabled irqs, so they are still disabled here */
> >
> >       split_page_owner(head, nr);
> > +     pgalloc_tag_split(head, nr);
> >
> >       /* See comment in __split_huge_page_tail() */
> >       if (PageAnon(head)) {
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 58c0e8b948a4..4bc5b4720fee 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2621,6 +2621,7 @@ void split_page(struct page *page, unsigned int o=
rder)
> >       for (i =3D 1; i < (1 << order); i++)
> >               set_page_refcounted(page + i);
> >       split_page_owner(page, 1 << order);
> > +     pgalloc_tag_split(page, 1 << order);
> >       split_page_memcg(page, 1 << order);
> >  }
> >  EXPORT_SYMBOL_GPL(split_page);
> > @@ -4806,6 +4807,7 @@ static void *make_alloc_exact(unsigned long addr,=
 unsigned int order,
> >               struct page *last =3D page + nr;
> >
> >               split_page_owner(page, 1 << order);
> > +             pgalloc_tag_split(page, 1 << order);
> >               split_page_memcg(page, 1 << order);
> >               while (page < --last)
> >                       set_page_refcounted(last);

