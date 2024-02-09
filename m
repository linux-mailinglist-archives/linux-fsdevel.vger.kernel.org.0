Return-Path: <linux-fsdevel+bounces-11009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C41C84FCBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC08B2381D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 19:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E79583CA6;
	Fri,  9 Feb 2024 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5WOKPez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F424A18
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506506; cv=none; b=rX7+UACjHaiUUlKSNKcqRix4iYTMUA/v9D9Fx/krHXEg0DwFZi7bfuBmxR55/YB+WG0d0ch/6WQBeJMOBYQwB2nDSWgnW6Hiu/wUcuUNZhrSKb8adalbX47dUQXCQZO+oQA+iSkiBQxEf+No8VK4Qzn5wQfG7xAKt9iCZBZIOFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506506; c=relaxed/simple;
	bh=JpE+i3M48J1kF15+Zk0MZhXhXlZOVQbeZgpXhN9lL2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=geZkEobs8iHKxEaWW5nK7yXLgt3uq9UEx8sqci0sXhEu3nOaLgdw0zbaHlm7qyoz+2txsAz3ZCroMhf56KiovNsXBz6bYLjqZAUPozTRHsfkow/gxqvbeVjgD6dlxC1Po4FJtIr+UTvZIcHsSEnbdbFDvQyCHy/R5qzaXwEAtho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5WOKPez; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b6c89c4f1so15666f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 11:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707506502; x=1708111302; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++mj34sLwXPClXHT6wKvTdKwLaMvjkaehlEfIv23RiU=;
        b=a5WOKPezLth3EXMf8bonXkzffLJT5S8WAdcT7oSpf8cGnr2ZB3U1dMYIV9Iy66eEto
         HJIvrru7XRGDNQFVRe7DJncJs8uzwFgAaf7xjCQ6FEFgZqCInrJdU+IZTVP6dGvH/kzW
         0z1b5gr/afnOycnZXcNa9Sq21OGv46k5YK84bSYmYoGTJ7kzCHLfbih9mOFsYzyw1DPn
         jk3i5TuC6N5X9ayErTN6iHTBtM9Dbnh6Z8Yp2hKN7TGqJg1ei0JeSBRXJ2PyAj6UiZfo
         H3vM0C2bXYP3hCTyleDmtxvQVmst8LMM8WmebOy9Df1ODefYbrBEjalRhuuJvxr/YJ22
         Wf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707506502; x=1708111302;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++mj34sLwXPClXHT6wKvTdKwLaMvjkaehlEfIv23RiU=;
        b=KaUWYIp0CciCNtwMhO3Gv41l7K/j9/q19knupgp1nimiCSxE6ww8ZJbwBpzi0cEbj+
         jPVv7uwd18ILUeJjDw7K9257dbtjyFkTVgkGVZC+75Wd8Z1rcwLdkh2u0fEnYHPUrRoo
         BjNJL27bTu8xckGamHFBGMULGsSbUIr8ywJ6PssuBcynjEHYyZwe+UQPeCqJIRXTZ5W3
         h6BhbgzWDt6ejWQdk4pVfTnLxr8EssP8GyK3Kk79tFlkfgCRkbnFGG7PG+YVPcsuL4nc
         dZ/1S9K78k1RcD3HYPHy97ldmjPhVaGOxCfwl5OiKF0KyRTqhWPrQm7ywEoq+z6JOkWH
         56BA==
X-Forwarded-Encrypted: i=1; AJvYcCW3TAMRxAhwByUnxMokVkawZ7Pd+VxZRi77jK/72ivizU/cNoI191YiFA60N8Uak2tqpb3UM0wwwSC3v7HzUJX0LtnnDoQxhGRb3jtjMA==
X-Gm-Message-State: AOJu0Yy5iknVaQ9tRsngfxcapgefOeVjM+CTSD+zP4pFGX8qO1s10HG7
	0rlJUgMNXsSgLebJo4OzlAVsXrfMCBFzyziRu3eIDO5YdMuGKhHSeESKRubJVNaFykDyUO3E05D
	dYjcIxDfSoFTe+va7fdFG4cg33tITmiy73l1X
X-Google-Smtp-Source: AGHT+IHs4y2ru9UoHfqK5Lru0d36Ptxf/fYvy67WGZyM8HOIMTJMlPAEqJAQdgCqvUd+LqetDXQv3AlZ2xwHy2yYyV8=
X-Received: by 2002:a05:6000:1183:b0:33b:1c33:2b3b with SMTP id
 g3-20020a056000118300b0033b1c332b3bmr1866776wrx.2.1707506501429; Fri, 09 Feb
 2024 11:21:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208212204.2043140-1-lokeshgidra@google.com>
 <20240208212204.2043140-4-lokeshgidra@google.com> <20240209030654.lxh4krmxmiuszhab@revolver>
 <CA+EESO4Ar8o3HMPF_b9KGbH2ytk1gNSJo0ucNAdMDX_OhgTe=A@mail.gmail.com> <20240209190605.7gokzhg7afy7ibyf@revolver>
In-Reply-To: <20240209190605.7gokzhg7afy7ibyf@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Fri, 9 Feb 2024 11:21:29 -0800
Message-ID: <CA+EESO7uR4azkf-V=E4XWTCaDL7xxNwNxcdnRi4hKaJQWxyxcA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 11:06=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240209 13:02]:
> > On Thu, Feb 8, 2024 at 7:07=E2=80=AFPM Liam R. Howlett <Liam.Howlett@or=
acle.com> wrote:
> > >
> > > * Lokesh Gidra <lokeshgidra@google.com> [240208 16:22]:
> > > > All userfaultfd operations, except write-protect, opportunistically=
 use
> > > > per-vma locks to lock vmas. On failure, attempt again inside mmap_l=
ock
> > > > critical section.
> > > >
> > > > Write-protect operation requires mmap_lock as it iterates over mult=
iple
> > > > vmas.
> > > >
> > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > ---
> > > >  fs/userfaultfd.c              |  13 +-
> > > >  include/linux/userfaultfd_k.h |   5 +-
> > > >  mm/userfaultfd.c              | 356 ++++++++++++++++++++++++++----=
----
> > > >  3 files changed, 275 insertions(+), 99 deletions(-)
> > > >
> > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > index c00a021bcce4..60dcfafdc11a 100644
> > > > --- a/fs/userfaultfd.c
> > > > +++ b/fs/userfaultfd.c
> > > > @@ -2005,17 +2005,8 @@ static int userfaultfd_move(struct userfault=
fd_ctx *ctx,
> > > >               return -EINVAL;
> > > >
> > > >       if (mmget_not_zero(mm)) {
> > > > -             mmap_read_lock(mm);
> > > > -
> > > > -             /* Re-check after taking map_changing_lock */
> > > > -             down_read(&ctx->map_changing_lock);
> > > > -             if (likely(!atomic_read(&ctx->mmap_changing)))
> > > > -                     ret =3D move_pages(ctx, mm, uffdio_move.dst, =
uffdio_move.src,
> > > > -                                      uffdio_move.len, uffdio_move=
.mode);
> > > > -             else
> > > > -                     ret =3D -EAGAIN;
> > > > -             up_read(&ctx->map_changing_lock);
> > > > -             mmap_read_unlock(mm);
> > > > +             ret =3D move_pages(ctx, uffdio_move.dst, uffdio_move.=
src,
> > > > +                              uffdio_move.len, uffdio_move.mode);
> > > >               mmput(mm);
> > > >       } else {
> > > >               return -ESRCH;
> > > > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaul=
tfd_k.h
> > > > index 3210c3552976..05d59f74fc88 100644
> > > > --- a/include/linux/userfaultfd_k.h
> > > > +++ b/include/linux/userfaultfd_k.h
> > > > @@ -138,9 +138,8 @@ extern long uffd_wp_range(struct vm_area_struct=
 *vma,
> > > >  /* move_pages */
> > > >  void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> > > >  void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> > > > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *=
mm,
> > > > -                unsigned long dst_start, unsigned long src_start,
> > > > -                unsigned long len, __u64 flags);
> > > > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_=
start,
> > > > +                unsigned long src_start, unsigned long len, __u64 =
flags);
> > > >  int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_=
t *src_pmd, pmd_t dst_pmdval,
> > > >                       struct vm_area_struct *dst_vma,
> > > >                       struct vm_area_struct *src_vma,
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index 74aad0831e40..1e25768b2136 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -19,20 +19,12 @@
> > > >  #include <asm/tlb.h>
> > > >  #include "internal.h"
> > > >
> > > > -static __always_inline
> > > > -struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
> > > > -                                 unsigned long dst_start,
> > > > -                                 unsigned long len)
> > >
> > > You could probably leave the __always_inline for this.
> >
> > Sure
> > >
> > > > +static bool validate_dst_vma(struct vm_area_struct *dst_vma,
> > > > +                          unsigned long dst_end)
> > > >  {
> > > > -     /*
> > > > -      * Make sure that the dst range is both valid and fully withi=
n a
> > > > -      * single existing vma.
> > > > -      */
> > > > -     struct vm_area_struct *dst_vma;
> > > > -
> > > > -     dst_vma =3D find_vma(dst_mm, dst_start);
> > > > -     if (!range_in_vma(dst_vma, dst_start, dst_start + len))
> > > > -             return NULL;
> > > > +     /* Make sure that the dst range is fully within dst_vma. */
> > > > +     if (dst_end > dst_vma->vm_end)
> > > > +             return false;
> > > >
> > > >       /*
> > > >        * Check the vma is registered in uffd, this is required to
> > > > @@ -40,11 +32,125 @@ struct vm_area_struct *find_dst_vma(struct mm_=
struct *dst_mm,
> > > >        * time.
> > > >        */
> > > >       if (!dst_vma->vm_userfaultfd_ctx.ctx)
> > > > -             return NULL;
> > > > +             return false;
> > > > +
> > > > +     return true;
> > > > +}
> > > > +
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +/*
> > > > + * lock_vma() - Lookup and lock vma corresponding to @address.
> > > > + * @mm: mm to search vma in.
> > > > + * @address: address that the vma should contain.
> > > > + * @prepare_anon: If true, then prepare the vma (if private) with =
anon_vma.
> > > > + *
> > > > + * Should be called without holding mmap_lock. vma should be unloc=
ked after use
> > > > + * with unlock_vma().
> > > > + *
> > > > + * Return: A locked vma containing @address, NULL if no vma is fou=
nd, or
> > > > + * -ENOMEM if anon_vma couldn't be allocated.
> > > > + */
> > > > +static struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > > > +                                    unsigned long address,
> > > > +                                    bool prepare_anon)
> > > > +{
> > > > +     struct vm_area_struct *vma;
> > > > +
> > > > +     vma =3D lock_vma_under_rcu(mm, address);
> > > > +     if (vma) {
> > > > +             /*
> > > > +              * lock_vma_under_rcu() only checks anon_vma for priv=
ate
> > > > +              * anonymous mappings. But we need to ensure it is as=
signed in
> > > > +              * private file-backed vmas as well.
> > > > +              */
> > > > +             if (prepare_anon && !(vma->vm_flags & VM_SHARED) &&
> > > > +                 !vma->anon_vma)
> > > > +                     vma_end_read(vma);
> > > > +             else
> > > > +                     return vma;
> > > > +     }
> > > > +
> > > > +     mmap_read_lock(mm);
> > > > +     vma =3D vma_lookup(mm, address);
> > > > +     if (vma) {
> > > > +             if (prepare_anon && !(vma->vm_flags & VM_SHARED) &&
> > > > +                 anon_vma_prepare(vma)) {
> > > > +                     vma =3D ERR_PTR(-ENOMEM);
> > > > +             } else {
> > > > +                     /*
> > > > +                      * We cannot use vma_start_read() as it may f=
ail due to
> > > > +                      * false locked (see comment in vma_start_rea=
d()). We
> > > > +                      * can avoid that by directly locking vm_lock=
 under
> > > > +                      * mmap_lock, which guarantees that nobody ca=
n lock the
> > > > +                      * vma for write (vma_start_write()) under us=
.
> > > > +                      */
> > > > +                     down_read(&vma->vm_lock->lock);
> > > > +             }
> > > > +     }
> > > > +
> > > > +     mmap_read_unlock(mm);
> > > > +     return vma;
> > > > +}
> > > > +
> > > > +static void unlock_vma(struct vm_area_struct *vma)
> > > > +{
> > > > +     vma_end_read(vma);
> > > > +}
> > > > +
> > > > +static struct vm_area_struct *find_and_lock_dst_vma(struct mm_stru=
ct *dst_mm,
> > > > +                                                 unsigned long dst=
_start,
> > > > +                                                 unsigned long len=
)
> > > > +{
> > > > +     struct vm_area_struct *dst_vma;
> > > > +
> > > > +     /* Ensure anon_vma is assigned for private vmas */
> > > > +     dst_vma =3D lock_vma(dst_mm, dst_start, true);
> > > > +
> > > > +     if (!dst_vma)
> > > > +             return ERR_PTR(-ENOENT);
> > > > +
> > > > +     if (PTR_ERR(dst_vma) =3D=3D -ENOMEM)
> > > > +             return dst_vma;
> > > > +
> > > > +     if (!validate_dst_vma(dst_vma, dst_start + len))
> > > > +             goto out_unlock;
> > > >
> > > >       return dst_vma;
> > > > +out_unlock:
> > > > +     unlock_vma(dst_vma);
> > > > +     return ERR_PTR(-ENOENT);
> > > >  }
> > > >
> > > > +#else
> > > > +
> > > > +static struct vm_area_struct *lock_mm_and_find_dst_vma(struct mm_s=
truct *dst_mm,
> > > > +                                                    unsigned long =
dst_start,
> > > > +                                                    unsigned long =
len)
> > > > +{
> > > > +     struct vm_area_struct *dst_vma;
> > > > +     int err =3D -ENOENT;
> > > > +
> > > > +     mmap_read_lock(dst_mm);
> > > > +     dst_vma =3D vma_lookup(dst_mm, dst_start);
> > > > +     if (!dst_vma)
> > > > +             goto out_unlock;
> > > > +
> > > > +     /* Ensure anon_vma is assigned for private vmas */
> > > > +     if (!(dst_vma->vm_flags & VM_SHARED) && anon_vma_prepare(dst_=
vma)) {
> > > > +             err =3D -ENOMEM;
> > > > +             goto out_unlock;
> > > > +     }
> > > > +
> > > > +     if (!validate_dst_vma(dst_vma, dst_start + len))
> > > > +             goto out_unlock;
> > > > +
> > > > +     return dst_vma;
> > > > +out_unlock:
> > > > +     mmap_read_unlock(dst_mm);
> > > > +     return ERR_PTR(err);
> > > > +}
> > > > +#endif
> > > > +
> > > >  /* Check if dst_addr is outside of file's size. Must be called wit=
h ptl held. */
> > > >  static bool mfill_file_over_size(struct vm_area_struct *dst_vma,
> > > >                                unsigned long dst_addr)
> > > > @@ -350,7 +456,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm=
, unsigned long address)
> > > >  #ifdef CONFIG_HUGETLB_PAGE
> > > >  /*
> > > >   * mfill_atomic processing for HUGETLB vmas.  Note that this routi=
ne is
> > > > - * called with mmap_lock held, it will release mmap_lock before re=
turning.
> > > > + * called with either vma-lock or mmap_lock held, it will release =
the lock
> > > > + * before returning.
> > > >   */
> > > >  static __always_inline ssize_t mfill_atomic_hugetlb(
> > > >                                             struct userfaultfd_ctx =
*ctx,
> > > > @@ -361,7 +468,6 @@ static __always_inline ssize_t mfill_atomic_hug=
etlb(
> > > >                                             uffd_flags_t flags)
> > > >  {
> > > >       struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> > > > -     int vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > > >       ssize_t err;
> > > >       pte_t *dst_pte;
> > > >       unsigned long src_addr, dst_addr;
> > > > @@ -380,7 +486,11 @@ static __always_inline ssize_t mfill_atomic_hu=
getlb(
> > > >        */
> > > >       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> > > >               up_read(&ctx->map_changing_lock);
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +             unlock_vma(dst_vma);
> > > > +#else
> > > >               mmap_read_unlock(dst_mm);
> > > > +#endif
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > @@ -403,24 +513,32 @@ static __always_inline ssize_t mfill_atomic_h=
ugetlb(
> > > >        * retry, dst_vma will be set to NULL and we must lookup agai=
n.
> > > >        */
> > > >       if (!dst_vma) {
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +             dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_start, =
len);
> > > > +#else
> > > > +             dst_vma =3D lock_mm_and_find_dst_vma(dst_mm, dst_star=
t, len);
> > > > +#endif
> > > > +             if (IS_ERR(dst_vma)) {
> > > > +                     err =3D PTR_ERR(dst_vma);
> > > > +                     goto out;
> > > > +             }
> > > > +
> > > >               err =3D -ENOENT;
> > > > -             dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > > -             if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
> > > > -                     goto out_unlock;
> > > > +             if (!is_vm_hugetlb_page(dst_vma))
> > > > +                     goto out_unlock_vma;
> > > >
> > > >               err =3D -EINVAL;
> > > >               if (vma_hpagesize !=3D vma_kernel_pagesize(dst_vma))
> > > > -                     goto out_unlock;
> > > > -
> > > > -             vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > > > -     }
> > > > +                     goto out_unlock_vma;
> > > >
> > > > -     /*
> > > > -      * If not shared, ensure the dst_vma has a anon_vma.
> > > > -      */
> > > > -     err =3D -ENOMEM;
> > > > -     if (!vm_shared) {
> > > > -             if (unlikely(anon_vma_prepare(dst_vma)))
> > > > +             /*
> > > > +              * If memory mappings are changing because of non-coo=
perative
> > > > +              * operation (e.g. mremap) running in parallel, bail =
out and
> > > > +              * request the user to retry later
> > > > +              */
> > > > +             down_read(&ctx->map_changing_lock);
> > > > +             err =3D -EAGAIN;
> > > > +             if (atomic_read(&ctx->mmap_changing))
> > > >                       goto out_unlock;
> > > >       }
> > > >
> > > > @@ -465,7 +583,11 @@ static __always_inline ssize_t mfill_atomic_hu=
getlb(
> > > >
> > > >               if (unlikely(err =3D=3D -ENOENT)) {
> > > >                       up_read(&ctx->map_changing_lock);
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +                     unlock_vma(dst_vma);
> > > > +#else
> > > >                       mmap_read_unlock(dst_mm);
> > > > +#endif
> > > >                       BUG_ON(!folio);
> > > >
> > > >                       err =3D copy_folio_from_user(folio,
> > > > @@ -474,17 +596,6 @@ static __always_inline ssize_t mfill_atomic_hu=
getlb(
> > > >                               err =3D -EFAULT;
> > > >                               goto out;
> > > >                       }
> > > > -                     mmap_read_lock(dst_mm);
> > > > -                     down_read(&ctx->map_changing_lock);
> > > > -                     /*
> > > > -                      * If memory mappings are changing because of=
 non-cooperative
> > > > -                      * operation (e.g. mremap) running in paralle=
l, bail out and
> > > > -                      * request the user to retry later
> > > > -                      */
> > > > -                     if (atomic_read(&ctx->mmap_changing)) {
> > > > -                             err =3D -EAGAIN;
> > > > -                             break;
> > > > -                     }
> > > >
> > > >                       dst_vma =3D NULL;
> > > >                       goto retry;
> > > > @@ -505,7 +616,12 @@ static __always_inline ssize_t mfill_atomic_hu=
getlb(
> > > >
> > > >  out_unlock:
> > > >       up_read(&ctx->map_changing_lock);
> > > > +out_unlock_vma:
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +     unlock_vma(dst_vma);
> > > > +#else
> > > >       mmap_read_unlock(dst_mm);
> > > > +#endif
> > > >  out:
> > > >       if (folio)
> > > >               folio_put(folio);
> > > > @@ -597,7 +713,19 @@ static __always_inline ssize_t mfill_atomic(st=
ruct userfaultfd_ctx *ctx,
> > > >       copied =3D 0;
> > > >       folio =3D NULL;
> > > >  retry:
> > > > -     mmap_read_lock(dst_mm);
> > > > +     /*
> > > > +      * Make sure the vma is not shared, that the dst range is
> > > > +      * both valid and fully within a single existing vma.
> > > > +      */
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +     dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_start, len);
> > > > +#else
> > > > +     dst_vma =3D lock_mm_and_find_dst_vma(dst_mm, dst_start, len);
> > > > +#endif
> > > > +     if (IS_ERR(dst_vma)) {
> > > > +             err =3D PTR_ERR(dst_vma);
> > > > +             goto out;
> > > > +     }
> > > >
> > > >       /*
> > > >        * If memory mappings are changing because of non-cooperative
> > > > @@ -609,15 +737,6 @@ static __always_inline ssize_t mfill_atomic(st=
ruct userfaultfd_ctx *ctx,
> > > >       if (atomic_read(&ctx->mmap_changing))
> > > >               goto out_unlock;
> > > >
> > > > -     /*
> > > > -      * Make sure the vma is not shared, that the dst range is
> > > > -      * both valid and fully within a single existing vma.
> > > > -      */
> > > > -     err =3D -ENOENT;
> > > > -     dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > > -     if (!dst_vma)
> > > > -             goto out_unlock;
> > > > -
> > > >       err =3D -EINVAL;
> > > >       /*
> > > >        * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_=
SHARED but
> > > > @@ -647,16 +766,6 @@ static __always_inline ssize_t mfill_atomic(st=
ruct userfaultfd_ctx *ctx,
> > > >           uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> > > >               goto out_unlock;
> > > >
> > > > -     /*
> > > > -      * Ensure the dst_vma has a anon_vma or this page
> > > > -      * would get a NULL anon_vma when moved in the
> > > > -      * dst_vma.
> > > > -      */
> > > > -     err =3D -ENOMEM;
> > > > -     if (!(dst_vma->vm_flags & VM_SHARED) &&
> > > > -         unlikely(anon_vma_prepare(dst_vma)))
> > > > -             goto out_unlock;
> > > > -
> > > >       while (src_addr < src_start + len) {
> > > >               pmd_t dst_pmdval;
> > > >
> > > > @@ -699,7 +808,11 @@ static __always_inline ssize_t mfill_atomic(st=
ruct userfaultfd_ctx *ctx,
> > > >                       void *kaddr;
> > > >
> > > >                       up_read(&ctx->map_changing_lock);
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +                     unlock_vma(dst_vma);
> > > > +#else
> > > >                       mmap_read_unlock(dst_mm);
> > > > +#endif
> > > >                       BUG_ON(!folio);
> > > >
> > > >                       kaddr =3D kmap_local_folio(folio, 0);
> > > > @@ -730,7 +843,11 @@ static __always_inline ssize_t mfill_atomic(st=
ruct userfaultfd_ctx *ctx,
> > > >
> > > >  out_unlock:
> > > >       up_read(&ctx->map_changing_lock);
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +     unlock_vma(dst_vma);
> > > > +#else
> > > >       mmap_read_unlock(dst_mm);
> > > > +#endif
> > > >  out:
> > > >       if (folio)
> > > >               folio_put(folio);
> > > > @@ -1267,16 +1384,67 @@ static int validate_move_areas(struct userf=
aultfd_ctx *ctx,
> > > >       if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
> > > >               return -EINVAL;
> > > >
> > > > -     /*
> > > > -      * Ensure the dst_vma has a anon_vma or this page
> > > > -      * would get a NULL anon_vma when moved in the
> > > > -      * dst_vma.
> > > > -      */
> > > > -     if (unlikely(anon_vma_prepare(dst_vma)))
> > > > -             return -ENOMEM;
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +static int find_and_lock_vmas(struct mm_struct *mm,
> > > > +                           unsigned long dst_start,
> > > > +                           unsigned long src_start,
> > > > +                           struct vm_area_struct **dst_vmap,
> > > > +                           struct vm_area_struct **src_vmap)
> > > > +{
> > > > +     int err;
> > > > +
> > > > +     /* There is no need to prepare anon_vma for src_vma */
> > > > +     *src_vmap =3D lock_vma(mm, src_start, false);
> > > > +     if (!*src_vmap)
> > > > +             return -ENOENT;
> > > > +
> > > > +     /* Ensure anon_vma is assigned for anonymous vma */
> > > > +     *dst_vmap =3D lock_vma(mm, dst_start, true);
> > > > +     err =3D -ENOENT;
> > > > +     if (!*dst_vmap)
> > > > +             goto out_unlock;
> > > > +
> > > > +     err =3D -ENOMEM;
> > > > +     if (PTR_ERR(*dst_vmap) =3D=3D -ENOMEM)
> > > > +             goto out_unlock;
> > >
> > > If you change lock_vma() to return the vma or ERR_PTR(-ENOENT) /
> > > ERR_PTR(-ENOMEM), then you could change this to check IS_ERR() and
> > > return the PTR_ERR().
> > >
> > > You could also use IS_ERR_OR_NULL here, but the first suggestion will
> > > simplify your life for find_and_lock_dst_vma() and the error type to
> > > return.
> >
> > Good suggestion. I'll make the change. Thanks
> > >
> > > What you have here will work though.
> > >
> > > >
> > > >       return 0;
> > > > +out_unlock:
> > > > +     unlock_vma(*src_vmap);
> > > > +     return err;
> > > >  }
> > > > +#else
> > > > +static int lock_mm_and_find_vmas(struct mm_struct *mm,
> > > > +                              unsigned long dst_start,
> > > > +                              unsigned long src_start,
> > > > +                              struct vm_area_struct **dst_vmap,
> > > > +                              struct vm_area_struct **src_vmap)
> > > > +{
> > > > +     int err =3D -ENOENT;
> > >
> > > Nit: new line after declarations.
> > >
> > > > +     mmap_read_lock(mm);
> > > > +
> > > > +     *src_vmap =3D vma_lookup(mm, src_start);
> > > > +     if (!*src_vmap)
> > > > +             goto out_unlock;
> > > > +
> > > > +     *dst_vmap =3D vma_lookup(mm, dst_start);
> > > > +     if (!*dst_vmap)
> > > > +             goto out_unlock;
> > > > +
> > > > +     /* Ensure anon_vma is assigned */
> > > > +     err =3D -ENOMEM;
> > > > +     if (vma_is_anonymous(*dst_vmap) && anon_vma_prepare(*dst_vmap=
))
> > > > +             goto out_unlock;
> > > > +
> > > > +     return 0;
> > > > +out_unlock:
> > > > +     mmap_read_unlock(mm);
> > > > +     return err;
> > > > +}
> > > > +#endif
> > > >
> > > >  /**
> > > >   * move_pages - move arbitrary anonymous pages of an existing vma
> > > > @@ -1287,8 +1455,6 @@ static int validate_move_areas(struct userfau=
ltfd_ctx *ctx,
> > > >   * @len: length of the virtual memory range
> > > >   * @mode: flags from uffdio_move.mode
> > > >   *
> > > > - * Must be called with mmap_lock held for read.
> > > > - *
> > >
> > > Will either use the mmap_lock in read mode or per-vma locking ?
> >
> > Makes sense. Will add it.
> > >
> > > >   * move_pages() remaps arbitrary anonymous pages atomically in zer=
o
> > > >   * copy. It only works on non shared anonymous pages because those=
 can
> > > >   * be relocated without generating non linear anon_vmas in the rma=
p
> > > > @@ -1355,10 +1521,10 @@ static int validate_move_areas(struct userf=
aultfd_ctx *ctx,
> > > >   * could be obtained. This is the only additional complexity added=
 to
> > > >   * the rmap code to provide this anonymous page remapping function=
ality.
> > > >   */
> > > > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *=
mm,
> > > > -                unsigned long dst_start, unsigned long src_start,
> > > > -                unsigned long len, __u64 mode)
> > > > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_=
start,
> > > > +                unsigned long src_start, unsigned long len, __u64 =
mode)
> > > >  {
> > > > +     struct mm_struct *mm =3D ctx->mm;
> > >
> > > You dropped the argument, but left the comment for the argument.
> >
> > Thanks, will fix it.
> > >
> > > >       struct vm_area_struct *src_vma, *dst_vma;
> > > >       unsigned long src_addr, dst_addr;
> > > >       pmd_t *src_pmd, *dst_pmd;
> > > > @@ -1376,28 +1542,40 @@ ssize_t move_pages(struct userfaultfd_ctx *=
ctx, struct mm_struct *mm,
> > > >           WARN_ON_ONCE(dst_start + len <=3D dst_start))
> > > >               goto out;
> > > >
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +     err =3D find_and_lock_vmas(mm, dst_start, src_start,
> > > > +                              &dst_vma, &src_vma);
> > > > +#else
> > > > +     err =3D lock_mm_and_find_vmas(mm, dst_start, src_start,
> > > > +                                 &dst_vma, &src_vma);
> > > > +#endif
> > >
> > > I was hoping you could hide this completely, but it's probably better=
 to
> > > show what's going on and the function names document it well.
> >
> > I wanted to hide unlock as it's called several times, but then I
> > thought you wanted explicit calls to mmap_read_unlock() so didn't hide
> > it. If you are ok can I define unlock_vma() for !CONFIG_PER_VMA_LOCK
> > as well, calling mmap_read_unlock()?
>
> My bigger problem was with the name.  We can't have unlock_vma()
> just unlock the mm - it is confusing to read and I think it'll lead to
> misunderstandings of what is really going on here.
>
> Whatever you decide to do is fine as long as it's clear what's going on.
> I think this is clear while hiding it could also be clear with the right
> function name - I'm not sure what that would be; naming is hard.

Maybe unlock_mm_or_vma() ? If not then I'll just keep it as is.

Naming is indeed hard!

>
> Thanks,
> Liam
>

