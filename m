Return-Path: <linux-fsdevel+bounces-10653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F084D1CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 19:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F8F1F2717B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2B612838C;
	Wed,  7 Feb 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGviMRh5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EDB127B7D
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331825; cv=none; b=Y+jlMw1KHhTWZ9s2eZgA/bbSU5LXWJUuM6HB/Sh0hl09/8MrTsoXq7LlHCVtmKTNYSjSjlIceIt3gvtpRlVmXMv63En/dcRpg3f2usXRQaEr/r8tVuGPgZg9CUpQ54X6ZdONb+GPLizZzn5+OilKPbjDsa5CvV1Ny/XHJb5x2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331825; c=relaxed/simple;
	bh=jpYe0v2ASWi8osKT94CG82J/2D3BYio/TDmLz3ifNKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHCaMCkng6Ba9wDSoddD8N/j8kmPx3JtKjOVd9WRfzLlml/IcKOxS1gnKQJJR/MJ1kwoSiNqj5AIEce77U0fCj9HqBnyS9D77eELF9//WAsk/UOFFccNvmHYptWX3jA3tMeXNzoY3G13RSoyL1R3zK126js1LaWaE65qDH9FuzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGviMRh5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b4db36eb1so724039f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 10:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707331821; x=1707936621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slYbxMwYxeMYBVKVdbMzEGm/TzHLZWmuYeE2/l4I/eA=;
        b=EGviMRh5XoTmvYZmL9TftADITw9tTqyAjQftEecGXwAdHP1btN4RU8bcStEtFcLu41
         T7NmG6+fCA4i80QANIQPg7OBObWiON6ZG0kDnBpPbGxSC3WgpRUUYEY/sHMBz9V6bfFY
         MWBaQW9xnCtGVAQjwLMjTRRL5QMXKL7xuvDSR1N0DkCSGwF3nOkijsP9MuH2pfWCYMHB
         /QWkD5lvUZ5dOH/8q7dtfb7lpL+c1a0Oo42UmifkPyKALGNuigE9fBo6QJhru/llfyZQ
         p1uwLDf9X7foNqKcZtTkz0WechJ7xlqMKYqf71Vva0+wFdAvo/yyYuchLVMJ15tOWluX
         NRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331821; x=1707936621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slYbxMwYxeMYBVKVdbMzEGm/TzHLZWmuYeE2/l4I/eA=;
        b=f1BWAVClJaQ+RyUMBSmECnR5MSVeMQr5VrMqvoekScNUgxTnFeszGYcct8605JEGDn
         Tabk009CgibvS2bI56FMO+6nAXZVjqDCa5ioRTe9Cv0k3GWxQJ62YuskULtcN4pQhBIV
         nNrqwNXjvuXbHjJHcsGUrYW5J3zdkB7KpCLFy853FbZCSgoyJpTRPo8Vg+W87tqTLbIy
         0Ay00GmTgas48l9rrYmzeQDEakj+d6krWzGaqyoL22+/5EjrjKV3/HwFtYhNyg4KRmnz
         qU0XetRk5LSSaV7zctE0NbW725AaVepnD/sgCitIPGTE/89XdoxxXfEaAqWioxL8P/MI
         RPBw==
X-Gm-Message-State: AOJu0YxOHeGkdDFdiay5S0Oqzs41DHkS5d/Psc1XNEheXFgqcBIi0RA3
	VlgRw75Wqye4r2ADPk2mD4MlzA4K4L+X2ID0wlAnMg0fjrkB0DOuT/w3CfLr1MuI5rMVS3gR9JO
	AQwkmL3fYI42tym05nKcPWMt9OIzJ4z7J3xad
X-Google-Smtp-Source: AGHT+IG0JTw4oZowLgnN8QxNdN+nmk0HIO8joSXtWDsL509mK3h2BqePpHbK4YwZJLB/ZFQYXXR2AjhOoekibUbDJDA=
X-Received: by 2002:a05:6000:118e:b0:33b:252d:ec26 with SMTP id
 g14-20020a056000118e00b0033b252dec26mr3577965wrx.65.1707331820699; Wed, 07
 Feb 2024 10:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206010919.1109005-1-lokeshgidra@google.com>
 <20240206010919.1109005-4-lokeshgidra@google.com> <CAG48ez0AdTijvuh0xueg_spwNE9tVcPuvqT9WpvmtiNNudQFMw@mail.gmail.com>
In-Reply-To: <CAG48ez0AdTijvuh0xueg_spwNE9tVcPuvqT9WpvmtiNNudQFMw@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 7 Feb 2024 10:50:08 -0800
Message-ID: <CA+EESO4mVVFjx1bSpWwwhsY9V_LTzerKyivvCO=hdPbY1JFsPQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com, 
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com, 
	bgeffon@google.com, willy@infradead.org, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 10:28=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Feb 6, 2024 at 2:09=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
> > All userfaultfd operations, except write-protect, opportunistically use
> > per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
> > critical section.
> >
> > Write-protect operation requires mmap_lock as it iterates over multiple
> > vmas.
> >
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> [...]
> > diff --git a/mm/memory.c b/mm/memory.c
> > index b05fd28dbce1..393ab3b0d6f3 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> [...]
> > +/*
> > + * lock_vma() - Lookup and lock VMA corresponding to @address.
> > + * @prepare_anon: If true, then prepare the VMA (if anonymous) with an=
on_vma.
> > + *
> > + * Should be called without holding mmap_lock. VMA should be unlocked =
after use
> > + * with unlock_vma().
> > + *
> > + * Return: A locked VMA containing @address, NULL of no VMA is found, =
or
> > + * -ENOMEM if anon_vma couldn't be allocated.
> > + */
> > +struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > +                               unsigned long address,
> > +                               bool prepare_anon)
> > +{
> > +       struct vm_area_struct *vma;
> > +
> > +       vma =3D lock_vma_under_rcu(mm, address);
> > +
> > +       if (vma)
> > +               return vma;
> > +
> > +       mmap_read_lock(mm);
> > +       vma =3D vma_lookup(mm, address);
> > +       if (vma) {
> > +               if (prepare_anon && vma_is_anonymous(vma) &&
> > +                   anon_vma_prepare(vma))
> > +                       vma =3D ERR_PTR(-ENOMEM);
> > +               else
> > +                       vma_acquire_read_lock(vma);
>
> This new code only calls anon_vma_prepare() for VMAs where
> vma_is_anonymous() is true (meaning they are private anonymous).
>
> [...]
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 74aad0831e40..64e22e467e4f 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -19,20 +19,25 @@
> >  #include <asm/tlb.h>
> >  #include "internal.h"
> >
> > -static __always_inline
> > -struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
> > -                                   unsigned long dst_start,
> > -                                   unsigned long len)
> > +/* Search for VMA and make sure it is valid. */
> > +static struct vm_area_struct *find_and_lock_dst_vma(struct mm_struct *=
dst_mm,
> > +                                                   unsigned long dst_s=
tart,
> > +                                                   unsigned long len)
> >  {
> > -       /*
> > -        * Make sure that the dst range is both valid and fully within =
a
> > -        * single existing vma.
> > -        */
> >         struct vm_area_struct *dst_vma;
> >
> > -       dst_vma =3D find_vma(dst_mm, dst_start);
> > -       if (!range_in_vma(dst_vma, dst_start, dst_start + len))
> > -               return NULL;
> > +       /* Ensure anon_vma is assigned for anonymous vma */
> > +       dst_vma =3D lock_vma(dst_mm, dst_start, true);
>
> lock_vma() is now used by find_and_lock_dst_vma(), which is used by
> mfill_atomic().
>
> > +       if (!dst_vma)
> > +               return ERR_PTR(-ENOENT);
> > +
> > +       if (PTR_ERR(dst_vma) =3D=3D -ENOMEM)
> > +               return dst_vma;
> > +
> > +       /* Make sure that the dst range is fully within dst_vma. */
> > +       if (dst_start + len > dst_vma->vm_end)
> > +               goto out_unlock;
> >
> >         /*
> >          * Check the vma is registered in uffd, this is required to
> [...]
> > @@ -597,7 +599,15 @@ static __always_inline ssize_t mfill_atomic(struct=
 userfaultfd_ctx *ctx,
> >         copied =3D 0;
> >         folio =3D NULL;
> >  retry:
> > -       mmap_read_lock(dst_mm);
> > +       /*
> > +        * Make sure the vma is not shared, that the dst range is
> > +        * both valid and fully within a single existing vma.
> > +        */
> > +       dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_start, len);
> > +       if (IS_ERR(dst_vma)) {
> > +               err =3D PTR_ERR(dst_vma);
> > +               goto out;
> > +       }
> >
> >         /*
> >          * If memory mappings are changing because of non-cooperative
> > @@ -609,15 +619,6 @@ static __always_inline ssize_t mfill_atomic(struct=
 userfaultfd_ctx *ctx,
> >         if (atomic_read(&ctx->mmap_changing))
> >                 goto out_unlock;
> >
> > -       /*
> > -        * Make sure the vma is not shared, that the dst range is
> > -        * both valid and fully within a single existing vma.
> > -        */
> > -       err =3D -ENOENT;
> > -       dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > -       if (!dst_vma)
> > -               goto out_unlock;
> > -
> >         err =3D -EINVAL;
> >         /*
> >          * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SH=
ARED but
> > @@ -647,16 +648,6 @@ static __always_inline ssize_t mfill_atomic(struct=
 userfaultfd_ctx *ctx,
> >             uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> >                 goto out_unlock;
> >
> > -       /*
> > -        * Ensure the dst_vma has a anon_vma or this page
> > -        * would get a NULL anon_vma when moved in the
> > -        * dst_vma.
> > -        */
> > -       err =3D -ENOMEM;
> > -       if (!(dst_vma->vm_flags & VM_SHARED) &&
> > -           unlikely(anon_vma_prepare(dst_vma)))
> > -               goto out_unlock;
>
> But the check mfill_atomic() used to do was different, it checked for VM_=
SHARED.

Thanks so much for catching this.
>
> Each VMA has one of these three types:
>
> 1. shared (marked by VM_SHARED; does not have an anon_vma)
> 2. private file-backed (needs to have anon_vma when storing PTEs)
> 3. private anonymous (what vma_is_anonymous() detects; needs to have
> anon_vma when storing PTEs)

As in the case of mfill_atomic(), it seems to me that checking for
VM_SHARED flag will cover both (2) and (3) right?
>
> This old code would call anon_vma_prepare() for both private VMA types
> (which is correct). The new code only calls anon_vma_prepare() for
> private anonymous VMAs, not for private file-backed ones. I think this
> code will probably crash with a BUG_ON() in __folio_set_anon() if you
> try to use userfaultfd to insert a PTE into a private file-backed VMA
> of a shmem file. (Which you should be able to get by creating a file
> in /dev/shm/ and then mapping that file with mmap(NULL, <size>,
> PROT_READ|PROT_WRITE, MAP_PRIVATE, <fd>, 0).)

