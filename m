Return-Path: <linux-fsdevel+bounces-15021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1816B885FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 18:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0484284911
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2F985C5E;
	Thu, 21 Mar 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wp4O/Vn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6620B00
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041780; cv=none; b=UNl4jYemOaaBLZ2r0xL3hczoR4pzh900jgs/Kaj54DNxUbC+UR0t/0Ki1qBbXiYJRaCCPtRzHwz1DnbeOPWRxALJBBBrOamm0WBYZyc5zvP7xy6gqJlmXZolLSp887vKALjw/x6r0VfHWFaWJyMZo3CoUnPob9dtEiHfH5HegAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041780; c=relaxed/simple;
	bh=Bla6ImeaxPC0l/wXS4fIkd5VYa4ZJlHCrM9gFW+aZB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ha2RaaA5W/EHhlr5nt24EDJU4VNEbh6zlKk7eXoK0fEWRgF4JMHs1CB6m1Fsl1Tx/vy66sFHkyZ/JOK9+IVkNKmwN9Ezm3rdfMGRBj9NjzOmJjvAeu8y1XRXfzHdiZBNwlvmFfRPOm5yhdYlGFy+cZCcFJ6Je1R6dMJ2WlXhKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wp4O/Vn1; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc236729a2bso1169345276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711041778; x=1711646578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4sCto2weX/tSraSWS0s5CjzL8cyi2xaSDvgaVtTzPM=;
        b=Wp4O/Vn1x+NjMVoyH1hqeGz5tXez/gLF44IpWIScGFPlcJyu5RJ7vJiJU/gQPl/4Dn
         htaniwwXNzQB2aWwR4yMm/3f9OHS4M1G8T1ih8wSy7E8R98XYDyIdy1jTczSEl4g7Tki
         2K3rqQo1QM00/qrcEl7zDLRPvvZs4YkH89pwYltNrD0UKP1BKGxtDCd05YExk5woVyxA
         Kybp7/HSuoE9rKnv0dGGk54Y1+pnsiL0uYJR4mXC9UMEnzzDuoTz/6cp8K1CpYa0qZHa
         p639zE4maeZirBKWuTl3ZpCOmTXcQPxMrIlmbNfQbca/Zm3qv+NrJ2T9roplqehch6lG
         fW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711041778; x=1711646578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4sCto2weX/tSraSWS0s5CjzL8cyi2xaSDvgaVtTzPM=;
        b=OeOm6jqGgNIzy1YS9RM63cYUPO3+P8dnMAtA+zYhQVFGzWz1te6Zsj3jofct9I15Hv
         FuCquKZ/WynNGQElpkYwPRC5aRLu1PahlTIeO2v10eFJPmLrFIfhMeo9PECv9iwlMl8L
         rM6nuKsD+JZfFUp4873zxjTVNHCujBrIxOxKs7G8a1xfcNY7Owl0RHK2Tf9JLqW9uqg4
         mD5lFfbe1BJY9HWIiqZvbdaaYkTabC5IwbN+LJZ2BbbOdOoc8yLVxc8oAWLvS08XhbW1
         Q0emKP2adsndF7oU16tQDKlTG+V6XPgdfaOlA2nngK9xD/inwY7zpM8IwhRpXPWqOtuQ
         Pzew==
X-Forwarded-Encrypted: i=1; AJvYcCXduHD0sA4UpLzi7rjCfWdDTg1z2A/Fyx/ghA2NraY9inA+WawgI8dAxImaToolYG5hYGj5RCSDjyyUiWqAYk9LwlZacAAToZlKGbA5Bw==
X-Gm-Message-State: AOJu0Yzud2wL/fcq+YAIJDsu9KnExKjbsqbudGSidfeZ9og5ibIZTw16
	8lwJZFhBPMnPWarRn/NA8nq13RP+aAajk2CQfsPs4EEowV9Ff7cQNAZpe0CZ7AClnN0jg++ggDm
	Bpy1gE1b0/xlHLlDhheI4Zy8ITZgig5AURO2b
X-Google-Smtp-Source: AGHT+IEchVac4khjBai8ZMUeOEG+pay6R0DITToEq3FetB5+Bz6Fx0tQ3dmiDUpIWg8REeoZLlH/6+Ca7JUBqPCCrBc=
X-Received: by 2002:a25:3607:0:b0:dcc:323e:e1a4 with SMTP id
 d7-20020a253607000000b00dcc323ee1a4mr19870609yba.6.1711041777566; Thu, 21 Mar
 2024 10:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <20240321163705.3067592-21-surenb@google.com>
 <Zfxk9aFhF7O_-T3c@casper.infradead.org> <ZfxohXDDCx-_cJYa@casper.infradead.org>
 <CAJuCfpHjfKYNyGeALZzwJ1k_AKOm_qcgKkx5zR+X6eyWmsZTLw@mail.gmail.com>
In-Reply-To: <CAJuCfpHjfKYNyGeALZzwJ1k_AKOm_qcgKkx5zR+X6eyWmsZTLw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Mar 2024 10:22:46 -0700
Message-ID: <CAJuCfpGeep=4CqW+z4K=hXf2A6V3aWZLi_XSeEuEz1v=S7qKnw@mail.gmail.com>
Subject: Re: [PATCH v6 20/37] mm: fix non-compound multi-order memory
 accounting in __free_pages
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 10:19=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Mar 21, 2024 at 10:04=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Thu, Mar 21, 2024 at 04:48:53PM +0000, Matthew Wilcox wrote:
> > > On Thu, Mar 21, 2024 at 09:36:42AM -0700, Suren Baghdasaryan wrote:
> > > > +++ b/mm/page_alloc.c
> > > > @@ -4700,12 +4700,15 @@ void __free_pages(struct page *page, unsign=
ed int order)
> > > >  {
> > > >     /* get PageHead before we drop reference */
> > > >     int head =3D PageHead(page);
> > > > +   struct alloc_tag *tag =3D pgalloc_tag_get(page);
> > > >
> > > >     if (put_page_testzero(page))
> > > >             free_the_page(page, order);
> > > > -   else if (!head)
> > > > +   else if (!head) {
> > > > +           pgalloc_tag_sub_pages(tag, (1 << order) - 1);
> > > >             while (order-- > 0)
> > > >                     free_the_page(page + (1 << order), order);
> > > > +   }
> > >
> > > Why do you need these new functions instead of just:
> > >
> > > +     else if (!head) {
> > > +             pgalloc_tag_sub(page, (1 << order) - 1);
> > >               while (order-- > 0)
> > >                       free_the_page(page + (1 << order), order);
> > > +     }
> >
> > Actually, I'm not sure this is safe (I don't fully understand codetags,
> > so it may be safe).  What can happen is that the put_page() can come in
> > before the pgalloc_tag_sub(), and then that page can be allocated again=
.
> > Will that cause confusion?

I indirectly answered your question in the reason #2 but to be clear,
we obtain codetag before we do put_page() here, therefore it's valid.
If another page is allocated and it points to the same codetag, then
it will operate on the same codetag per-cpu counters and that should
not be a problem.

>
> So, there are two reasons I unfortunately can't reuse pgalloc_tag_sub():
>
> 1. We need to subtract `bytes` counter from the codetag but not the
> `calls` counter, otherwise the final accounting will be incorrect.
> This is because we effectively allocated multiple pages with one call
> but freeing them with separate calls here. pgalloc_tag_sub_pages()
> subtracts bytes but keeps calls counter the same. I mentioned this in
> here: https://lore.kernel.org/all/CAJuCfpEgh1OiYNE_uKG-BqW2x97sOL9+AaTX4J=
ct3=3DWHzAv+kg@mail.gmail.com/
> 2. The codetag object itself is stable, it's created at build time.
> The exception is when we unload modules and the codetag section gets
> freed but during module unloading we check that all module codetags
> are not referenced anymore and we prevent unloading this section if
> any of them are still referenced (should not normally happen). That
> said, the reference to the codetag (in this case from the page_ext)
> might change from under us and we have to make sure it's valid. We
> ensure that here by getting the codetag itself with pgalloc_tag_get()
> *before* calling put_page_testzero(), which ensures its stability.
>
> >

