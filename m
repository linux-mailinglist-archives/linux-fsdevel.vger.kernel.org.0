Return-Path: <linux-fsdevel+bounces-21118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B38FF2F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA84290033
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223891990D2;
	Thu,  6 Jun 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZDmjnz6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F61196DB0;
	Thu,  6 Jun 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692725; cv=none; b=Vj9ZXq5HiSIvCdYxBUbwr5S2vBI1WmymZRXJVP9/G/Qw/W9W2wnwIX06O9GbOctV2EiWgBSh+E/lajV67fmO/xIJFJ+lL/dZPkdVt5PhxBT2fn4qifUbj4K5lK5XwviNOtvUBT6y7vI/QWvP96AepQIoGdtukN/r1cMHGxEJvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692725; c=relaxed/simple;
	bh=e1O3UJIALNPdhBkiYJFVlFPPit40t4xY0hK3WgJhTD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFZl0fcPYv/euwklSsa4IaBoyGU3gEKYhLOxXHbt8NyQBsawvl5s8ikMw3r0BfTIXq3qNzLQOjfsDTaYQ61o2JzNWyl2sYu+ZEJzbNt1wuVUEzWfxl1ZtgrYX77j41ZKOUUbfyM/113Nv1ictw54duEr7DycHhChk1ejYLwfGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZDmjnz6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c4829d7136so911661a12.1;
        Thu, 06 Jun 2024 09:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717692722; x=1718297522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPKhCgxXa/CNr7U5QI54wZCLdvYy/KVKpQ3JKTtNoA4=;
        b=BZDmjnz6H9CVxOp8TBe2dDDjbEXOJEnjNG7199zpBxIPPJiABRe1YulZdXAVuagW+j
         GhFNBYfq+26YMwjSvyqmrn9T/AEaVslTBvINt+W2ClqHV3i2iJLvLpKAz2t9ZC/Y+WXI
         5YqVTocV91JAWV4YhAhqbYwJI4ls8IyaTk21cgIiRlq9YNW7X9I9ZF5PQMIFUfwxx9GW
         NNQAMQnBRj9m8aZLhPK2aCjJ5g8//QWKMsMTAiQaTucgmT6hRSNlRfaCyGGxpOVeUYO+
         Zz8IEB6mCl2vmJElJbGylW45j3Z1VcP70SCf2KU2o6Fd5cXFrWlcU8tLRaFAWqAxni1E
         g71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692722; x=1718297522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPKhCgxXa/CNr7U5QI54wZCLdvYy/KVKpQ3JKTtNoA4=;
        b=PMh4X0fmj5NVogBPt2a3tFwhz7LYJ2x/e35fCWqwJbggvBTzgXO2iFW+gMi41ZCTjv
         V47TpwgYpp1I36CxGXMgD4ICko8zp723oHZVw9fE2jyWjdFiqsyenMXzGNm+ztV5/mK/
         QUuRV3Cijn22Eau5Dem4FjsKqN7Obr1uQggUE6EUGszZT8pOH87aj/IBJsZgJiS084Le
         9dZrOpek1in5IYeMgeFLw6OF8sJZJiFR9hjXg6fKVamduEuRcTRVPhD3f/DQm2+38Fea
         tv8frfbME+BfMdPnRhPZiGl0vjNMqVM3QXZ04ksjZiWB/njfk/aDA05HuxT7ofVxz1Fp
         ZoTg==
X-Forwarded-Encrypted: i=1; AJvYcCXB9sGtZMaQEkCcax596n8Nz4g6g6rRk4lw5rUhY7cLcR3begje+PUmQn3KbV87zcqSNqcz7tr6LsqmJXfJRypLmGszLL307q5TBdRitk0wETFAjZZ3CjxGs681NCriHeQmzkg7+MwT4J31Mg1DxXo6TO/ohHDdcvo84Cl1+5J43A==
X-Gm-Message-State: AOJu0Yy0n6n1mobFxwNIkCAN4boB8x13JVUdFMV4MF3LiRsU5InjEnbU
	JVWAZXLY0co3c5Y7XqtGAWtMjdzlfzaurH+QeclMPoBTdei7dQPJU7PiEwD6iRf0xiQbZTSPcw3
	EX1AZFMit8BB8H+nueiIHcntdtUQPtg==
X-Google-Smtp-Source: AGHT+IEB6OolDSrP3Rnv3sb7vP6n8o1kGoB493b6UbHnJIs0/RiYGEy3CxkFieHAInZhO251MHV/iElJCcjo/8r8NX0=
X-Received: by 2002:a17:90a:5588:b0:2bf:6a1b:fcb8 with SMTP id
 98e67ed59e1d1-2c2bcaf9250mr77250a91.24.1717692722316; Thu, 06 Jun 2024
 09:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605002459.4091285-1-andrii@kernel.org> <20240605002459.4091285-2-andrii@kernel.org>
 <Zl-38XrUw9entlFR@casper.infradead.org> <uevtozlryyqw5vj2duuzowupknfynmreruiw6m7bcxryjppqpm@7g766emooxfh>
 <CAEf4BzZFpidjJzRMWboZYY03U8M22Yo1sqXconi36V11XA-ZfA@mail.gmail.com>
 <CAEf4BzYDhtkYt=qn2YgrnRkZ0tpa3EPAiCUcBkdUa-9DKN22dQ@mail.gmail.com>
 <CAEf4Bzbzj55LfgTom9KiM1Xe8pfXvpWBd6ETjXQCh7M===G5aw@mail.gmail.com>
 <5fmylram4hhrrdl7vf6odyvuxcrvhipsx2ij5z4dsfciuzf4on@qwk7qzze6gbt> <CAJuCfpER9qUSGbWBcHhT1=ssH41Xv8--XVA5BEPCM7uf=z_GLw@mail.gmail.com>
In-Reply-To: <CAJuCfpER9qUSGbWBcHhT1=ssH41Xv8--XVA5BEPCM7uf=z_GLw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jun 2024 09:51:50 -0700
Message-ID: <CAEf4Bzax2E1JS=MUm=sBJvcMb+CyWaPdxmr2mDuODs2cc3_mTg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] mm: add find_vma()-like API but RCU protected and
 taking VMA lock
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:22=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Wed, Jun 5, 2024 at 10:03=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Andrii Nakryiko <andrii.nakryiko@gmail.com> [240605 12:27]:
> > > On Wed, Jun 5, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Jun 5, 2024 at 9:13=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Wed, Jun 5, 2024 at 6:33=E2=80=AFAM Liam R. Howlett <Liam.Howl=
ett@oracle.com> wrote:
> > > > > >
> > > > > > * Matthew Wilcox <willy@infradead.org> [240604 20:57]:
> > > > > > > On Tue, Jun 04, 2024 at 05:24:46PM -0700, Andrii Nakryiko wro=
te:
> > > > > > > > +/*
> > > > > > > > + * find_and_lock_vma_rcu() - Find and lock the VMA for a g=
iven address, or the
> > > > > > > > + * next VMA. Search is done under RCU protection, without =
taking or assuming
> > > > > > > > + * mmap_lock. Returned VMA is guaranteed to be stable and =
not isolated.
> > > > > > >
> > > > > > > You know this is supposed to be the _short_ description, righ=
t?
> > > > > > > Three lines is way too long.  The full description goes betwe=
en the
> > > > > > > arguments and the Return: line.
> > > > >
> > > > > Sure, I'll adjust.
> > > > >
> > > > > > >
> > > > > > > > + * @mm: The mm_struct to check
> > > > > > > > + * @addr: The address
> > > > > > > > + *
> > > > > > > > + * Returns: The VMA associated with addr, or the next VMA.
> > > > > > > > + * May return %NULL in the case of no VMA at addr or above=
.
> > > > > > > > + * If the VMA is being modified and can't be locked, -EBUS=
Y is returned.
> > > > > > > > + */
> > > > > > > > +struct vm_area_struct *find_and_lock_vma_rcu(struct mm_str=
uct *mm,
> > > > > > > > +                                        unsigned long addr=
ess)
> > > > > > > > +{
> > > > > > > > +   MA_STATE(mas, &mm->mm_mt, address, address);
> > > > > > > > +   struct vm_area_struct *vma;
> > > > > > > > +   int err;
> > > > > > > > +
> > > > > > > > +   rcu_read_lock();
> > > > > > > > +retry:
> > > > > > > > +   vma =3D mas_find(&mas, ULONG_MAX);
> > > > > > > > +   if (!vma) {
> > > > > > > > +           err =3D 0; /* no VMA, return NULL */
> > > > > > > > +           goto inval;
> > > > > > > > +   }
> > > > > > > > +
> > > > > > > > +   if (!vma_start_read(vma)) {
> > > > > > > > +           err =3D -EBUSY;
> > > > > > > > +           goto inval;
> > > > > > > > +   }
> > > > > > > > +
> > > > > > > > +   /*
> > > > > > > > +    * Check since vm_start/vm_end might change before we l=
ock the VMA.
> > > > > > > > +    * Note, unlike lock_vma_under_rcu() we are searching f=
or VMA covering
> > > > > > > > +    * address or the next one, so we only make sure VMA wa=
sn't updated to
> > > > > > > > +    * end before the address.
> > > > > > > > +    */
> > > > > > > > +   if (unlikely(vma->vm_end <=3D address)) {
> > > > > > > > +           err =3D -EBUSY;
> > > > > > > > +           goto inval_end_read;
> > > > > > > > +   }
> > > > > > > > +
> > > > > > > > +   /* Check if the VMA got isolated after we found it */
> > > > > > > > +   if (vma->detached) {
> > > > > > > > +           vma_end_read(vma);
> > > > > > > > +           count_vm_vma_lock_event(VMA_LOCK_MISS);
> > > > > > > > +           /* The area was replaced with another one */
> > > > > > >
> > > > > > > Surely you need to mas_reset() before you goto retry?
> > > > > >
> > > > > > Probably more than that.  We've found and may have adjusted the
> > > > > > index/last; we should reconfigure the maple state.  You should =
probably
> > > > > > use mas_set(), which will reset the maple state and set the ind=
ex and
> > > > > > long to address.
> > > > >
> > > > > Yep, makes sense, thanks. As for the `unlikely(vma->vm_end <=3D
> > > > > address)` case, I presume we want to do the same, right? Basicall=
y, on
> > > > > each retry start from the `address` unconditionally, no matter wh=
at's
> > > > > the reason for retry.
> > > >
> > > > ah, never mind, we don't retry in that situation, I'll just put
> > > > `mas_set(&mas, address);` right before `goto retry;`. Unless we sho=
uld
> > > > actually retry in the case when VMA got moved before the requested
> > > > address, not sure, let me know what you think. Presumably retrying
> > > > will allow us to get the correct VMA without the need to fall back =
to
> > > > mmap_lock?
> > >
> > > sorry, one more question as I look some more around this (unfamiliar
> > > to me) piece of code. I see that lock_vma_under_rcu counts
> > > VMA_LOCK_MISS on retry, but I see that there is actually a
> > > VMA_LOCK_RETRY stat as well. Any reason it's a MISS instead of RETRY?
> > > Should I use MISS as well, or actually count a RETRY?
> > >
> >
> > VMA_LOCK_MISS is used here because we missed the VMA due to a write
> > happening to move the vma (rather rare).  The VMA_LOCK missed the vma.
> >
> > VMA_LOCK_RETRY is used to indicate we need to retry under the mmap lock=
.
> > A retry is needed after the VMA_LOCK did not work under rcu locking.
>
> Originally lock_vma_under_rcu() was used only inside page fault path,
> so these counters helped us quantify how effective VMA locking is when
> handling page faults. With more users of that function these counters
> will be affected by other paths as well. I'm not sure but I think it
> makes sense to use them only inside page fault path, IOW we should
> probably move count_vm_vma_lock_event() calls outside of
> lock_vma_under_rcu() and add them only when handling page faults.

Alright, seems like I should then just drop count_vm_vma_lock_event()
from the API I'm adding.

>
> >
> > Thanks,
> > Liam

