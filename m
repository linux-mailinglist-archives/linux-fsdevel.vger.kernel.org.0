Return-Path: <linux-fsdevel+bounces-11002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C8684FB76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 19:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731FD1F23A00
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF787F496;
	Fri,  9 Feb 2024 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ku3cNm/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CD7EF06
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501733; cv=none; b=Zkz4HVNDwoQzfAhAi5vFAwctokg1eaieAxwuOuqvE/sHIvrPUVUmAa9pFag4FiV8sjKQCA8uxjqA8KeROnOdhadcuzNgcVECktizFbWaKqjoeCAz2aTizcceANFkESilEz46e+hw0qZ5aouNEHGuNQ9OffW2VAC5MmNSaNdqRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501733; c=relaxed/simple;
	bh=j1ZRr+H8uqc3feM+iw8u54XjPaa3tM5OcfCLLY05eEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ms3MUhwT5xkZGFhohs2MsXkMDKRrvc9dtKfwjRS9DEanpEsycOYJ0J4bLtjsCcwzfMGuXL3r8Z1t1+kD1rb/nXvrZOmNNoR/ldb6gQeTAXDSTxhvqmngqNRyVtiMtf0g37PtsnPC+qoffU7nsoaSZ8byySfSp/Bgl5ixqqjvHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ku3cNm/y; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b68db9b38so216834f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 10:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707501729; x=1708106529; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Rz1CqVXfmhrDkg4FYloOaiy8RD5Kx1e3kEoF6csDqY=;
        b=ku3cNm/ynWmVulp8F3xmlU4l9iQKf1Ez1cB8P3XLdGLU84eWY+xXBmXmpTdH5SGvz6
         AItpoBA9l/MVjdHOPQf7L45hvCV9c4i5Q0Yg6eKLKRf71cxFhlLPwoFBkDZfbx3lhvU/
         T9mabF4mmY7i8O9OQIMKbH9gdMse59uuhSqFLT2ZmfYKVa6CFItKyICWZ970ZZvaV8HW
         YnXLttxposajqKluPsZ0PooPAKCLOZAdWk7mLxXkvL2jRN985hUX3A5dwFl6vFDVIQn2
         RJ3yN87dODSDtC1DNDCri+gaQ5pp9A/57X8gRcq6nVfY6fkJJOrEkTxVyKtBFRph+LZa
         YW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707501729; x=1708106529;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Rz1CqVXfmhrDkg4FYloOaiy8RD5Kx1e3kEoF6csDqY=;
        b=va9hOjqd/xsKk/0l+LL7AgNpUlS1N7B2UoLPPrAaIfhMS3o/OOW9yvX/RPjlR6cOtv
         tleLgbVIOxIrSte4ZJ8tSG2ftDRMYEDmHvLf18+Pn2D9/ziMQEac3Mrxw+YzDxtlqKAC
         gOrzBdloni21560+w/EunpPzuAZqeq/qc1cVC5UOKYuYm3poszBLKaoj3QuPPaDoZER7
         IAVrzsIc0E34/sixajOKM3PHLa1qgBoK6y6WBIKW4Pzzfudp5BQNdLT5c/74AJJNYyNT
         odeXZPNEwfN22l54rfGyG0kkqDK0Sst1uFaTYh81par+5gaJhAaB3TobHLvoBgV7mDeV
         28Yg==
X-Gm-Message-State: AOJu0Yx5SmATVQof2mquaG+lWxlkrd+TIWONNCIRq2/yENjG7lDDREdf
	862anxUpT02XBTyrUN5AzaZliwDz/BKU5T4AfEim1aF0dCBcwxo5C5zq9lBFxd2FEOFfX4BocdB
	CKy3jODOQcPRTlvgBQ1STHbppNmCT4UtM7hUK
X-Google-Smtp-Source: AGHT+IHKItOZOihLBD4ELXODk2DVxVUYYxt55u/opR4OMKbKScaIynza0YIbt6N/VCGBDopOHo5iqKrk06xgN1c/CkE=
X-Received: by 2002:a5d:5707:0:b0:33b:14f8:732a with SMTP id
 a7-20020a5d5707000000b0033b14f8732amr1767772wrv.45.1707501728811; Fri, 09 Feb
 2024 10:02:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208212204.2043140-1-lokeshgidra@google.com>
 <20240208212204.2043140-4-lokeshgidra@google.com> <20240209030654.lxh4krmxmiuszhab@revolver>
In-Reply-To: <20240209030654.lxh4krmxmiuszhab@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Fri, 9 Feb 2024 10:01:56 -0800
Message-ID: <CA+EESO4Ar8o3HMPF_b9KGbH2ytk1gNSJo0ucNAdMDX_OhgTe=A@mail.gmail.com>
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

On Thu, Feb 8, 2024 at 7:07=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240208 16:22]:
> > All userfaultfd operations, except write-protect, opportunistically use
> > per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
> > critical section.
> >
> > Write-protect operation requires mmap_lock as it iterates over multiple
> > vmas.
> >
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> >  fs/userfaultfd.c              |  13 +-
> >  include/linux/userfaultfd_k.h |   5 +-
> >  mm/userfaultfd.c              | 356 ++++++++++++++++++++++++++--------
> >  3 files changed, 275 insertions(+), 99 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index c00a021bcce4..60dcfafdc11a 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -2005,17 +2005,8 @@ static int userfaultfd_move(struct userfaultfd_c=
tx *ctx,
> >               return -EINVAL;
> >
> >       if (mmget_not_zero(mm)) {
> > -             mmap_read_lock(mm);
> > -
> > -             /* Re-check after taking map_changing_lock */
> > -             down_read(&ctx->map_changing_lock);
> > -             if (likely(!atomic_read(&ctx->mmap_changing)))
> > -                     ret =3D move_pages(ctx, mm, uffdio_move.dst, uffd=
io_move.src,
> > -                                      uffdio_move.len, uffdio_move.mod=
e);
> > -             else
> > -                     ret =3D -EAGAIN;
> > -             up_read(&ctx->map_changing_lock);
> > -             mmap_read_unlock(mm);
> > +             ret =3D move_pages(ctx, uffdio_move.dst, uffdio_move.src,
> > +                              uffdio_move.len, uffdio_move.mode);
> >               mmput(mm);
> >       } else {
> >               return -ESRCH;
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_=
k.h
> > index 3210c3552976..05d59f74fc88 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -138,9 +138,8 @@ extern long uffd_wp_range(struct vm_area_struct *vm=
a,
> >  /* move_pages */
> >  void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> >  void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
> > -                unsigned long dst_start, unsigned long src_start,
> > -                unsigned long len, __u64 flags);
> > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_star=
t,
> > +                unsigned long src_start, unsigned long len, __u64 flag=
s);
> >  int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *s=
rc_pmd, pmd_t dst_pmdval,
> >                       struct vm_area_struct *dst_vma,
> >                       struct vm_area_struct *src_vma,
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 74aad0831e40..1e25768b2136 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -19,20 +19,12 @@
> >  #include <asm/tlb.h>
> >  #include "internal.h"
> >
> > -static __always_inline
> > -struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
> > -                                 unsigned long dst_start,
> > -                                 unsigned long len)
>
> You could probably leave the __always_inline for this.

Sure
>
> > +static bool validate_dst_vma(struct vm_area_struct *dst_vma,
> > +                          unsigned long dst_end)
> >  {
> > -     /*
> > -      * Make sure that the dst range is both valid and fully within a
> > -      * single existing vma.
> > -      */
> > -     struct vm_area_struct *dst_vma;
> > -
> > -     dst_vma =3D find_vma(dst_mm, dst_start);
> > -     if (!range_in_vma(dst_vma, dst_start, dst_start + len))
> > -             return NULL;
> > +     /* Make sure that the dst range is fully within dst_vma. */
> > +     if (dst_end > dst_vma->vm_end)
> > +             return false;
> >
> >       /*
> >        * Check the vma is registered in uffd, this is required to
> > @@ -40,11 +32,125 @@ struct vm_area_struct *find_dst_vma(struct mm_stru=
ct *dst_mm,
> >        * time.
> >        */
> >       if (!dst_vma->vm_userfaultfd_ctx.ctx)
> > -             return NULL;
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +/*
> > + * lock_vma() - Lookup and lock vma corresponding to @address.
> > + * @mm: mm to search vma in.
> > + * @address: address that the vma should contain.
> > + * @prepare_anon: If true, then prepare the vma (if private) with anon=
_vma.
> > + *
> > + * Should be called without holding mmap_lock. vma should be unlocked =
after use
> > + * with unlock_vma().
> > + *
> > + * Return: A locked vma containing @address, NULL if no vma is found, =
or
> > + * -ENOMEM if anon_vma couldn't be allocated.
> > + */
> > +static struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > +                                    unsigned long address,
> > +                                    bool prepare_anon)
> > +{
> > +     struct vm_area_struct *vma;
> > +
> > +     vma =3D lock_vma_under_rcu(mm, address);
> > +     if (vma) {
> > +             /*
> > +              * lock_vma_under_rcu() only checks anon_vma for private
> > +              * anonymous mappings. But we need to ensure it is assign=
ed in
> > +              * private file-backed vmas as well.
> > +              */
> > +             if (prepare_anon && !(vma->vm_flags & VM_SHARED) &&
> > +                 !vma->anon_vma)
> > +                     vma_end_read(vma);
> > +             else
> > +                     return vma;
> > +     }
> > +
> > +     mmap_read_lock(mm);
> > +     vma =3D vma_lookup(mm, address);
> > +     if (vma) {
> > +             if (prepare_anon && !(vma->vm_flags & VM_SHARED) &&
> > +                 anon_vma_prepare(vma)) {
> > +                     vma =3D ERR_PTR(-ENOMEM);
> > +             } else {
> > +                     /*
> > +                      * We cannot use vma_start_read() as it may fail =
due to
> > +                      * false locked (see comment in vma_start_read())=
. We
> > +                      * can avoid that by directly locking vm_lock und=
er
> > +                      * mmap_lock, which guarantees that nobody can lo=
ck the
> > +                      * vma for write (vma_start_write()) under us.
> > +                      */
> > +                     down_read(&vma->vm_lock->lock);
> > +             }
> > +     }
> > +
> > +     mmap_read_unlock(mm);
> > +     return vma;
> > +}
> > +
> > +static void unlock_vma(struct vm_area_struct *vma)
> > +{
> > +     vma_end_read(vma);
> > +}
> > +
> > +static struct vm_area_struct *find_and_lock_dst_vma(struct mm_struct *=
dst_mm,
> > +                                                 unsigned long dst_sta=
rt,
> > +                                                 unsigned long len)
> > +{
> > +     struct vm_area_struct *dst_vma;
> > +
> > +     /* Ensure anon_vma is assigned for private vmas */
> > +     dst_vma =3D lock_vma(dst_mm, dst_start, true);
> > +
> > +     if (!dst_vma)
> > +             return ERR_PTR(-ENOENT);
> > +
> > +     if (PTR_ERR(dst_vma) =3D=3D -ENOMEM)
> > +             return dst_vma;
> > +
> > +     if (!validate_dst_vma(dst_vma, dst_start + len))
> > +             goto out_unlock;
> >
> >       return dst_vma;
> > +out_unlock:
> > +     unlock_vma(dst_vma);
> > +     return ERR_PTR(-ENOENT);
> >  }
> >
> > +#else
> > +
> > +static struct vm_area_struct *lock_mm_and_find_dst_vma(struct mm_struc=
t *dst_mm,
> > +                                                    unsigned long dst_=
start,
> > +                                                    unsigned long len)
> > +{
> > +     struct vm_area_struct *dst_vma;
> > +     int err =3D -ENOENT;
> > +
> > +     mmap_read_lock(dst_mm);
> > +     dst_vma =3D vma_lookup(dst_mm, dst_start);
> > +     if (!dst_vma)
> > +             goto out_unlock;
> > +
> > +     /* Ensure anon_vma is assigned for private vmas */
> > +     if (!(dst_vma->vm_flags & VM_SHARED) && anon_vma_prepare(dst_vma)=
) {
> > +             err =3D -ENOMEM;
> > +             goto out_unlock;
> > +     }
> > +
> > +     if (!validate_dst_vma(dst_vma, dst_start + len))
> > +             goto out_unlock;
> > +
> > +     return dst_vma;
> > +out_unlock:
> > +     mmap_read_unlock(dst_mm);
> > +     return ERR_PTR(err);
> > +}
> > +#endif
> > +
> >  /* Check if dst_addr is outside of file's size. Must be called with pt=
l held. */
> >  static bool mfill_file_over_size(struct vm_area_struct *dst_vma,
> >                                unsigned long dst_addr)
> > @@ -350,7 +456,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, un=
signed long address)
> >  #ifdef CONFIG_HUGETLB_PAGE
> >  /*
> >   * mfill_atomic processing for HUGETLB vmas.  Note that this routine i=
s
> > - * called with mmap_lock held, it will release mmap_lock before return=
ing.
> > + * called with either vma-lock or mmap_lock held, it will release the =
lock
> > + * before returning.
> >   */
> >  static __always_inline ssize_t mfill_atomic_hugetlb(
> >                                             struct userfaultfd_ctx *ctx=
,
> > @@ -361,7 +468,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb=
(
> >                                             uffd_flags_t flags)
> >  {
> >       struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> > -     int vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> >       ssize_t err;
> >       pte_t *dst_pte;
> >       unsigned long src_addr, dst_addr;
> > @@ -380,7 +486,11 @@ static __always_inline ssize_t mfill_atomic_hugetl=
b(
> >        */
> >       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> >               up_read(&ctx->map_changing_lock);
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +             unlock_vma(dst_vma);
> > +#else
> >               mmap_read_unlock(dst_mm);
> > +#endif
> >               return -EINVAL;
> >       }
> >
> > @@ -403,24 +513,32 @@ static __always_inline ssize_t mfill_atomic_huget=
lb(
> >        * retry, dst_vma will be set to NULL and we must lookup again.
> >        */
> >       if (!dst_vma) {
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +             dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_start, len)=
;
> > +#else
> > +             dst_vma =3D lock_mm_and_find_dst_vma(dst_mm, dst_start, l=
en);
> > +#endif
> > +             if (IS_ERR(dst_vma)) {
> > +                     err =3D PTR_ERR(dst_vma);
> > +                     goto out;
> > +             }
> > +
> >               err =3D -ENOENT;
> > -             dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > -             if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
> > -                     goto out_unlock;
> > +             if (!is_vm_hugetlb_page(dst_vma))
> > +                     goto out_unlock_vma;
> >
> >               err =3D -EINVAL;
> >               if (vma_hpagesize !=3D vma_kernel_pagesize(dst_vma))
> > -                     goto out_unlock;
> > -
> > -             vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > -     }
> > +                     goto out_unlock_vma;
> >
> > -     /*
> > -      * If not shared, ensure the dst_vma has a anon_vma.
> > -      */
> > -     err =3D -ENOMEM;
> > -     if (!vm_shared) {
> > -             if (unlikely(anon_vma_prepare(dst_vma)))
> > +             /*
> > +              * If memory mappings are changing because of non-coopera=
tive
> > +              * operation (e.g. mremap) running in parallel, bail out =
and
> > +              * request the user to retry later
> > +              */
> > +             down_read(&ctx->map_changing_lock);
> > +             err =3D -EAGAIN;
> > +             if (atomic_read(&ctx->mmap_changing))
> >                       goto out_unlock;
> >       }
> >
> > @@ -465,7 +583,11 @@ static __always_inline ssize_t mfill_atomic_hugetl=
b(
> >
> >               if (unlikely(err =3D=3D -ENOENT)) {
> >                       up_read(&ctx->map_changing_lock);
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +                     unlock_vma(dst_vma);
> > +#else
> >                       mmap_read_unlock(dst_mm);
> > +#endif
> >                       BUG_ON(!folio);
> >
> >                       err =3D copy_folio_from_user(folio,
> > @@ -474,17 +596,6 @@ static __always_inline ssize_t mfill_atomic_hugetl=
b(
> >                               err =3D -EFAULT;
> >                               goto out;
> >                       }
> > -                     mmap_read_lock(dst_mm);
> > -                     down_read(&ctx->map_changing_lock);
> > -                     /*
> > -                      * If memory mappings are changing because of non=
-cooperative
> > -                      * operation (e.g. mremap) running in parallel, b=
ail out and
> > -                      * request the user to retry later
> > -                      */
> > -                     if (atomic_read(&ctx->mmap_changing)) {
> > -                             err =3D -EAGAIN;
> > -                             break;
> > -                     }
> >
> >                       dst_vma =3D NULL;
> >                       goto retry;
> > @@ -505,7 +616,12 @@ static __always_inline ssize_t mfill_atomic_hugetl=
b(
> >
> >  out_unlock:
> >       up_read(&ctx->map_changing_lock);
> > +out_unlock_vma:
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     unlock_vma(dst_vma);
> > +#else
> >       mmap_read_unlock(dst_mm);
> > +#endif
> >  out:
> >       if (folio)
> >               folio_put(folio);
> > @@ -597,7 +713,19 @@ static __always_inline ssize_t mfill_atomic(struct=
 userfaultfd_ctx *ctx,
> >       copied =3D 0;
> >       folio =3D NULL;
> >  retry:
> > -     mmap_read_lock(dst_mm);
> > +     /*
> > +      * Make sure the vma is not shared, that the dst range is
> > +      * both valid and fully within a single existing vma.
> > +      */
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_start, len);
> > +#else
> > +     dst_vma =3D lock_mm_and_find_dst_vma(dst_mm, dst_start, len);
> > +#endif
> > +     if (IS_ERR(dst_vma)) {
> > +             err =3D PTR_ERR(dst_vma);
> > +             goto out;
> > +     }
> >
> >       /*
> >        * If memory mappings are changing because of non-cooperative
> > @@ -609,15 +737,6 @@ static __always_inline ssize_t mfill_atomic(struct=
 userfaultfd_ctx *ctx,
> >       if (atomic_read(&ctx->mmap_changing))
> >               goto out_unlock;
> >
> > -     /*
> > -      * Make sure the vma is not shared, that the dst range is
> > -      * both valid and fully within a single existing vma.
> > -      */
> > -     err =3D -ENOENT;
> > -     dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > -     if (!dst_vma)
> > -             goto out_unlock;
> > -
> >       err =3D -EINVAL;
> >       /*
> >        * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SHAR=
ED but
> > @@ -647,16 +766,6 @@ static __always_inline ssize_t mfill_atomic(struct=
 userfaultfd_ctx *ctx,
> >           uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> >               goto out_unlock;
> >
> > -     /*
> > -      * Ensure the dst_vma has a anon_vma or this page
> > -      * would get a NULL anon_vma when moved in the
> > -      * dst_vma.
> > -      */
> > -     err =3D -ENOMEM;
> > -     if (!(dst_vma->vm_flags & VM_SHARED) &&
> > -         unlikely(anon_vma_prepare(dst_vma)))
> > -             goto out_unlock;
> > -
> >       while (src_addr < src_start + len) {
> >               pmd_t dst_pmdval;
> >
> > @@ -699,7 +808,11 @@ static __always_inline ssize_t mfill_atomic(struct=
 userfaultfd_ctx *ctx,
> >                       void *kaddr;
> >
> >                       up_read(&ctx->map_changing_lock);
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +                     unlock_vma(dst_vma);
> > +#else
> >                       mmap_read_unlock(dst_mm);
> > +#endif
> >                       BUG_ON(!folio);
> >
> >                       kaddr =3D kmap_local_folio(folio, 0);
> > @@ -730,7 +843,11 @@ static __always_inline ssize_t mfill_atomic(struct=
 userfaultfd_ctx *ctx,
> >
> >  out_unlock:
> >       up_read(&ctx->map_changing_lock);
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     unlock_vma(dst_vma);
> > +#else
> >       mmap_read_unlock(dst_mm);
> > +#endif
> >  out:
> >       if (folio)
> >               folio_put(folio);
> > @@ -1267,16 +1384,67 @@ static int validate_move_areas(struct userfault=
fd_ctx *ctx,
> >       if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
> >               return -EINVAL;
> >
> > -     /*
> > -      * Ensure the dst_vma has a anon_vma or this page
> > -      * would get a NULL anon_vma when moved in the
> > -      * dst_vma.
> > -      */
> > -     if (unlikely(anon_vma_prepare(dst_vma)))
> > -             return -ENOMEM;
> > +     return 0;
> > +}
> > +
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +static int find_and_lock_vmas(struct mm_struct *mm,
> > +                           unsigned long dst_start,
> > +                           unsigned long src_start,
> > +                           struct vm_area_struct **dst_vmap,
> > +                           struct vm_area_struct **src_vmap)
> > +{
> > +     int err;
> > +
> > +     /* There is no need to prepare anon_vma for src_vma */
> > +     *src_vmap =3D lock_vma(mm, src_start, false);
> > +     if (!*src_vmap)
> > +             return -ENOENT;
> > +
> > +     /* Ensure anon_vma is assigned for anonymous vma */
> > +     *dst_vmap =3D lock_vma(mm, dst_start, true);
> > +     err =3D -ENOENT;
> > +     if (!*dst_vmap)
> > +             goto out_unlock;
> > +
> > +     err =3D -ENOMEM;
> > +     if (PTR_ERR(*dst_vmap) =3D=3D -ENOMEM)
> > +             goto out_unlock;
>
> If you change lock_vma() to return the vma or ERR_PTR(-ENOENT) /
> ERR_PTR(-ENOMEM), then you could change this to check IS_ERR() and
> return the PTR_ERR().
>
> You could also use IS_ERR_OR_NULL here, but the first suggestion will
> simplify your life for find_and_lock_dst_vma() and the error type to
> return.

Good suggestion. I'll make the change. Thanks
>
> What you have here will work though.
>
> >
> >       return 0;
> > +out_unlock:
> > +     unlock_vma(*src_vmap);
> > +     return err;
> >  }
> > +#else
> > +static int lock_mm_and_find_vmas(struct mm_struct *mm,
> > +                              unsigned long dst_start,
> > +                              unsigned long src_start,
> > +                              struct vm_area_struct **dst_vmap,
> > +                              struct vm_area_struct **src_vmap)
> > +{
> > +     int err =3D -ENOENT;
>
> Nit: new line after declarations.
>
> > +     mmap_read_lock(mm);
> > +
> > +     *src_vmap =3D vma_lookup(mm, src_start);
> > +     if (!*src_vmap)
> > +             goto out_unlock;
> > +
> > +     *dst_vmap =3D vma_lookup(mm, dst_start);
> > +     if (!*dst_vmap)
> > +             goto out_unlock;
> > +
> > +     /* Ensure anon_vma is assigned */
> > +     err =3D -ENOMEM;
> > +     if (vma_is_anonymous(*dst_vmap) && anon_vma_prepare(*dst_vmap))
> > +             goto out_unlock;
> > +
> > +     return 0;
> > +out_unlock:
> > +     mmap_read_unlock(mm);
> > +     return err;
> > +}
> > +#endif
> >
> >  /**
> >   * move_pages - move arbitrary anonymous pages of an existing vma
> > @@ -1287,8 +1455,6 @@ static int validate_move_areas(struct userfaultfd=
_ctx *ctx,
> >   * @len: length of the virtual memory range
> >   * @mode: flags from uffdio_move.mode
> >   *
> > - * Must be called with mmap_lock held for read.
> > - *
>
> Will either use the mmap_lock in read mode or per-vma locking ?

Makes sense. Will add it.
>
> >   * move_pages() remaps arbitrary anonymous pages atomically in zero
> >   * copy. It only works on non shared anonymous pages because those can
> >   * be relocated without generating non linear anon_vmas in the rmap
> > @@ -1355,10 +1521,10 @@ static int validate_move_areas(struct userfault=
fd_ctx *ctx,
> >   * could be obtained. This is the only additional complexity added to
> >   * the rmap code to provide this anonymous page remapping functionalit=
y.
> >   */
> > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
> > -                unsigned long dst_start, unsigned long src_start,
> > -                unsigned long len, __u64 mode)
> > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_star=
t,
> > +                unsigned long src_start, unsigned long len, __u64 mode=
)
> >  {
> > +     struct mm_struct *mm =3D ctx->mm;
>
> You dropped the argument, but left the comment for the argument.

Thanks, will fix it.
>
> >       struct vm_area_struct *src_vma, *dst_vma;
> >       unsigned long src_addr, dst_addr;
> >       pmd_t *src_pmd, *dst_pmd;
> > @@ -1376,28 +1542,40 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 struct mm_struct *mm,
> >           WARN_ON_ONCE(dst_start + len <=3D dst_start))
> >               goto out;
> >
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     err =3D find_and_lock_vmas(mm, dst_start, src_start,
> > +                              &dst_vma, &src_vma);
> > +#else
> > +     err =3D lock_mm_and_find_vmas(mm, dst_start, src_start,
> > +                                 &dst_vma, &src_vma);
> > +#endif
>
> I was hoping you could hide this completely, but it's probably better to
> show what's going on and the function names document it well.

I wanted to hide unlock as it's called several times, but then I
thought you wanted explicit calls to mmap_read_unlock() so didn't hide
it. If you are ok can I define unlock_vma() for !CONFIG_PER_VMA_LOCK
as well, calling mmap_read_unlock()?
>
> > +     if (err)
> > +             goto out;
> > +
> > +     /* Re-check after taking map_changing_lock */
> > +     down_read(&ctx->map_changing_lock);
> > +     if (likely(atomic_read(&ctx->mmap_changing))) {
> > +             err =3D -EAGAIN;
> > +             goto out_unlock;
> > +     }
> >       /*
> >        * Make sure the vma is not shared, that the src and dst remap
> >        * ranges are both valid and fully within a single existing
> >        * vma.
> >        */
> > -     src_vma =3D find_vma(mm, src_start);
> > -     if (!src_vma || (src_vma->vm_flags & VM_SHARED))
> > -             goto out;
> > -     if (src_start < src_vma->vm_start ||
> > -         src_start + len > src_vma->vm_end)
> > -             goto out;
> > +     if (src_vma->vm_flags & VM_SHARED)
> > +             goto out_unlock;
> > +     if (src_start + len > src_vma->vm_end)
> > +             goto out_unlock;
> >
> > -     dst_vma =3D find_vma(mm, dst_start);
> > -     if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> > -             goto out;
> > -     if (dst_start < dst_vma->vm_start ||
> > -         dst_start + len > dst_vma->vm_end)
> > -             goto out;
> > +     if (dst_vma->vm_flags & VM_SHARED)
> > +             goto out_unlock;
> > +     if (dst_start + len > dst_vma->vm_end)
> > +             goto out_unlock;
> >
> >       err =3D validate_move_areas(ctx, src_vma, dst_vma);
> >       if (err)
> > -             goto out;
> > +             goto out_unlock;
> >
> >       for (src_addr =3D src_start, dst_addr =3D dst_start;
> >            src_addr < src_start + len;) {
> > @@ -1514,6 +1692,14 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, =
struct mm_struct *mm,
> >               moved +=3D step_size;
> >       }
> >
> > +out_unlock:
> > +     up_read(&ctx->map_changing_lock);
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     unlock_vma(dst_vma);
> > +     unlock_vma(src_vma);
> > +#else
> > +     mmap_read_unlock(mm);
> > +#endif
> >  out:
> >       VM_WARN_ON(moved < 0);
> >       VM_WARN_ON(err > 0);
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >

