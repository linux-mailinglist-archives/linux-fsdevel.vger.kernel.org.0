Return-Path: <linux-fsdevel+bounces-21065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D90158FD2E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 18:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6159A1F246E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4FD15F33A;
	Wed,  5 Jun 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7Nk+Agu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84877801;
	Wed,  5 Jun 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604848; cv=none; b=aORBT/ymjzwYYJngfcyYMTDWFkkMOzRw0jqnw87Ugqdkr9DKEHvkE0iaOcXIIVZB0tq9/ZrtbmQ3ktJgESt/o5CQDSOeziybI9wt3QdlKYufF7bTvyXHvFiMi0TILqKXMlXAoV18u95xKV1KsAIGXiywH7aEuoEE6ePxwvhanGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604848; c=relaxed/simple;
	bh=kEJJT7vPcgrPtfSwhgERL/7FGdm5mHT2kO+xtNLBeHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XRRotvWjVujOV4zStTJFT3MJGruPM6l8+hYPlga1yh5xf7L2abak4HKNupJ/9MpfJFXuPKGP3MgqaKxayvXhHZ65hgu6w4Y0Lc5ZD2RBw4c27xPv+EdxoynmPG4CimTPLq5DUEJWNRGk6taToSSNm2UY8ycM3Xob7fd1dCa2bqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7Nk+Agu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f658800344so479985ad.0;
        Wed, 05 Jun 2024 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717604847; x=1718209647; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlqYX7CZRXcik8grmUTE6vS1byeP3eeXqYE/oo9qiFo=;
        b=D7Nk+Aguz6qIIPjud+opJpLo0Nt1kqfr1O28wEVnwCsJ57b26fVk61Mkkwg1FpWCx8
         IGqJK0P60uKw043dH/C8I03wQ0SkZIXGGZKLd2svjNQ6WVLlGwia/nlGwfFopJd8HDDP
         Woz0YpO7Oz5FI9B/s/mEf+K6wVPYxdCuByUr19nOnWEepFje8I9uTbf10UgFHeZcDP29
         AyvU4HBkZgskeeaAO1uvM+6ighHUA+HXWgOP8U9FUMwJ/JlV/BNTmpmy8nhaFrLVeZbo
         ZxPY3n+g41T/ZnYfGLwzz/N5S51bi+3Z/Bi4c8OXsSc7389XXdG8LfD5hF8K0nNpu2FF
         op+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717604847; x=1718209647;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlqYX7CZRXcik8grmUTE6vS1byeP3eeXqYE/oo9qiFo=;
        b=i7OFT66B7PEFVB7MeW52qAFdIfjiCq/PFO5gOtWyGfsh49fDR6hioYCE9u8yumdFRM
         K6In+dL9+8JmybzcHAyFwH55q4HR1t7zUuZPmCL7V4Jo/gRgYfi/UwIR69fiSW8frxR3
         xaNf5kuE4wsKqBvPbvgS/joRFe0pOj+N0woQtQmFszlFEInmGdqTRm5w+fGq2MqCNb6x
         w08C28BGepcAz3JT7CJOe0Y3tQayzaP3LzXLRuJq8sQpCTeipW6Nrx5BjIAy8E9SEklf
         6REb/TI3G9Qg/pS8h+o/dofQXNGBApPMhrjFoJydCPGGVU8Iyk0YADB///hmrRxxdy1F
         tHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+/gcFlWABvd7n+x4n7x71wSUP7CD1nbxlbRV9QDU2+VeBWeoz7FfoHuYiNjmcipKDwpfY9HrrqycZ5GOffLgbztfcBARtxUm0AXBMbQ5xAdxhJye1N4J7OPIewd29Z6SDg6gEhVc40VW8L0dIWIOTPP6VD/TcbhWu1IS5tXESjg==
X-Gm-Message-State: AOJu0YxDRDeFbpdAj2nV3NOH4wxY+WZiMOEnZLovajbHFOS4aK9Xiiu7
	sCoUFiC/CgEdtbF4MNJBR9/x60iLlEcWPN2OsainY+9P/e39Oki05uP3rKgwJdW/vJZDbMkRaRr
	iMgyuUJmL08R2ER3Lt+vTLNQCvVc4Ku8/
X-Google-Smtp-Source: AGHT+IFm0S5xOg68BNRVacZTRtX3OMveoYFGLEWlIQvH25K+sH/ZnawuSmmeabnbH099N3GydWsGDSWHpu0ibWhLLZA=
X-Received: by 2002:a17:90a:f6c8:b0:2c1:a9a2:256e with SMTP id
 98e67ed59e1d1-2c27db4faddmr3612067a91.31.1717604846834; Wed, 05 Jun 2024
 09:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605002459.4091285-1-andrii@kernel.org> <20240605002459.4091285-2-andrii@kernel.org>
 <Zl-38XrUw9entlFR@casper.infradead.org> <uevtozlryyqw5vj2duuzowupknfynmreruiw6m7bcxryjppqpm@7g766emooxfh>
 <CAEf4BzZFpidjJzRMWboZYY03U8M22Yo1sqXconi36V11XA-ZfA@mail.gmail.com> <CAEf4BzYDhtkYt=qn2YgrnRkZ0tpa3EPAiCUcBkdUa-9DKN22dQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYDhtkYt=qn2YgrnRkZ0tpa3EPAiCUcBkdUa-9DKN22dQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Jun 2024 09:27:14 -0700
Message-ID: <CAEf4Bzbzj55LfgTom9KiM1Xe8pfXvpWBd6ETjXQCh7M===G5aw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] mm: add find_vma()-like API but RCU protected and
 taking VMA lock
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, surenb@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 5, 2024 at 9:13=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jun 5, 2024 at 6:33=E2=80=AFAM Liam R. Howlett <Liam.Howlett@or=
acle.com> wrote:
> > >
> > > * Matthew Wilcox <willy@infradead.org> [240604 20:57]:
> > > > On Tue, Jun 04, 2024 at 05:24:46PM -0700, Andrii Nakryiko wrote:
> > > > > +/*
> > > > > + * find_and_lock_vma_rcu() - Find and lock the VMA for a given a=
ddress, or the
> > > > > + * next VMA. Search is done under RCU protection, without taking=
 or assuming
> > > > > + * mmap_lock. Returned VMA is guaranteed to be stable and not is=
olated.
> > > >
> > > > You know this is supposed to be the _short_ description, right?
> > > > Three lines is way too long.  The full description goes between the
> > > > arguments and the Return: line.
> >
> > Sure, I'll adjust.
> >
> > > >
> > > > > + * @mm: The mm_struct to check
> > > > > + * @addr: The address
> > > > > + *
> > > > > + * Returns: The VMA associated with addr, or the next VMA.
> > > > > + * May return %NULL in the case of no VMA at addr or above.
> > > > > + * If the VMA is being modified and can't be locked, -EBUSY is r=
eturned.
> > > > > + */
> > > > > +struct vm_area_struct *find_and_lock_vma_rcu(struct mm_struct *m=
m,
> > > > > +                                        unsigned long address)
> > > > > +{
> > > > > +   MA_STATE(mas, &mm->mm_mt, address, address);
> > > > > +   struct vm_area_struct *vma;
> > > > > +   int err;
> > > > > +
> > > > > +   rcu_read_lock();
> > > > > +retry:
> > > > > +   vma =3D mas_find(&mas, ULONG_MAX);
> > > > > +   if (!vma) {
> > > > > +           err =3D 0; /* no VMA, return NULL */
> > > > > +           goto inval;
> > > > > +   }
> > > > > +
> > > > > +   if (!vma_start_read(vma)) {
> > > > > +           err =3D -EBUSY;
> > > > > +           goto inval;
> > > > > +   }
> > > > > +
> > > > > +   /*
> > > > > +    * Check since vm_start/vm_end might change before we lock th=
e VMA.
> > > > > +    * Note, unlike lock_vma_under_rcu() we are searching for VMA=
 covering
> > > > > +    * address or the next one, so we only make sure VMA wasn't u=
pdated to
> > > > > +    * end before the address.
> > > > > +    */
> > > > > +   if (unlikely(vma->vm_end <=3D address)) {
> > > > > +           err =3D -EBUSY;
> > > > > +           goto inval_end_read;
> > > > > +   }
> > > > > +
> > > > > +   /* Check if the VMA got isolated after we found it */
> > > > > +   if (vma->detached) {
> > > > > +           vma_end_read(vma);
> > > > > +           count_vm_vma_lock_event(VMA_LOCK_MISS);
> > > > > +           /* The area was replaced with another one */
> > > >
> > > > Surely you need to mas_reset() before you goto retry?
> > >
> > > Probably more than that.  We've found and may have adjusted the
> > > index/last; we should reconfigure the maple state.  You should probab=
ly
> > > use mas_set(), which will reset the maple state and set the index and
> > > long to address.
> >
> > Yep, makes sense, thanks. As for the `unlikely(vma->vm_end <=3D
> > address)` case, I presume we want to do the same, right? Basically, on
> > each retry start from the `address` unconditionally, no matter what's
> > the reason for retry.
>
> ah, never mind, we don't retry in that situation, I'll just put
> `mas_set(&mas, address);` right before `goto retry;`. Unless we should
> actually retry in the case when VMA got moved before the requested
> address, not sure, let me know what you think. Presumably retrying
> will allow us to get the correct VMA without the need to fall back to
> mmap_lock?

sorry, one more question as I look some more around this (unfamiliar
to me) piece of code. I see that lock_vma_under_rcu counts
VMA_LOCK_MISS on retry, but I see that there is actually a
VMA_LOCK_RETRY stat as well. Any reason it's a MISS instead of RETRY?
Should I use MISS as well, or actually count a RETRY?

>
> >
> > >
> > >
> > > >
> > > > > +           goto retry;
> > > > > +   }
> > > >

