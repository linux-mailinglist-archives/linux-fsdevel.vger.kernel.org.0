Return-Path: <linux-fsdevel+bounces-11021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8309D84FE0A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 21:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41961F23BE3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCD6FBF3;
	Fri,  9 Feb 2024 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2V/zEA+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B29ED262
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512353; cv=none; b=L1l0yheZPzzZ4qW66+SPnHUZjiYg4QwR9EeKacZPcZDvSsaCjEGaBRelegLI09D1MFC4rHtiVTzIHfeMT42CIfjKFG0P+9HNfVFawd+7IaB/5LLRQD2Eqv+/wyNIewYxwpck60EhlMdDSqGgIIpv0IIRYhFBpbYhoW56wPH7dMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512353; c=relaxed/simple;
	bh=f8OBnWvlS09prMxacUNcO5BUGPmguGv5WFRVHWXs9Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jSV1ubdmWENW0TrgU4RAS9UlWpR78WIhWeBTBiqpqnTcO6pW0c98tQzOHrV/7EFjU4jE/OsEjUeYxqCdGWNDUqR5HNYWXLbgfmymH+IzCp7h2dmT64h6Tf3kmpGUjTmg1Cl/Bg7SJQJSAnwATWNYvD3x3A58V2bo8X4Pq67lrcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2V/zEA+y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fe59b22dbso10972625e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 12:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707512347; x=1708117147; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zrEc8EqBS4KRRpBKI/h97lI/mfHCFzgoeDGIbbkfEk=;
        b=2V/zEA+yW2TiVZKbCPVmG11wGQy9rnNBueaKuB+LOXBq8jKGdVDTTckdFEjZtsroly
         CrcnLDaR7qPzCMtrMRf0vvFajF6nEovM/2wpENiTMh/aVFtKcXY0+h26dotVTwymlhuE
         KXF8VL/QdAaKMpqm5MXurINMyixxfA+YuWYyLvz21FKdBmQJC24b6L9koAXZe9Oky4o1
         9zYzfJeL7UZmJnOQdEd0a6bw+3LGp/6x9giw19+Md2Of7Bo+pvSYlvNvSeHGvX0L+jab
         zC3+M4zr/8xF27JpDbZzMY7w/2cOO3FnLwg4siPPVwWnufBCSd0hVpOfAyZGHT624FvT
         5hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512347; x=1708117147;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zrEc8EqBS4KRRpBKI/h97lI/mfHCFzgoeDGIbbkfEk=;
        b=npCHjEtX8NVGx0ymg7PCjLL30wHL1bhEbyZZ4pRjFIqlZ8MBmZYIjOMACab5F0lcgs
         O9+pKkcYMYc2wGw8ytbwnbk0Jo6KydsxZ22DUmkItn7XMhIk8ynAbhevu47e2CikJqW5
         /XDNKp9w/EDwynDKIllwm11GgKK8JGIKPYZ/F6pWV8NOz+gRLyIixPdaq+GVjUwbb2ga
         Lk/7mfHuRUdEOfB+0IY9nArtOwAx8lSDTnlReHx6b0FIpgMvEt1R/02jBqmV5DtKq8e6
         RnuumOmQG/4Y82fwOs9/BsIGf4357iweyUOM4rgBU/bz4oVQA02bVRI/y6B+15kHpKg9
         PE7w==
X-Gm-Message-State: AOJu0YxZ9DrBy0LTWn5iFDlkyAY6QbNzG7n9OKrZHXSRtx/55jL291PP
	Xys1r+wd9iUX/7E1aZg+D/s8Xop9OnWpvat+rMstkCgRBVcAjcJ94cXXYI7d2XpxtFWBcWZlt14
	s2M2/bwYOZTV6Kn+59GK6zl+F0JQGuHf83OyA
X-Google-Smtp-Source: AGHT+IET79bq/KXualeLq6y64qmiChq2VEWzMI7B+dTzlcxES5Vi+I1Oyhry+wQjYe6iol3G7/KYPZwHB9JOJ/+1n0A=
X-Received: by 2002:a05:600c:1910:b0:40f:d3d8:c8d5 with SMTP id
 j16-20020a05600c191000b0040fd3d8c8d5mr328584wmq.9.1707512347048; Fri, 09 Feb
 2024 12:59:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208212204.2043140-1-lokeshgidra@google.com>
 <20240208212204.2043140-4-lokeshgidra@google.com> <20240209030654.lxh4krmxmiuszhab@revolver>
 <CA+EESO4Ar8o3HMPF_b9KGbH2ytk1gNSJo0ucNAdMDX_OhgTe=A@mail.gmail.com>
 <20240209190605.7gokzhg7afy7ibyf@revolver> <CA+EESO7uR4azkf-V=E4XWTCaDL7xxNwNxcdnRi4hKaJQWxyxcA@mail.gmail.com>
 <20240209193110.ltfdc6nolpoa2ccv@revolver>
In-Reply-To: <20240209193110.ltfdc6nolpoa2ccv@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Fri, 9 Feb 2024 12:58:54 -0800
Message-ID: <CA+EESO4mbS_zB6AutaGZz1Jdx1uLFy5JqhyjnDHND4tY=3bn7Q@mail.gmail.com>
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

On Fri, Feb 9, 2024 at 11:31=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240209 14:21]:
> > On Fri, Feb 9, 2024 at 11:06=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Lokesh Gidra <lokeshgidra@google.com> [240209 13:02]:
> > > > On Thu, Feb 8, 2024 at 7:07=E2=80=AFPM Liam R. Howlett <Liam.Howlet=
t@oracle.com> wrote:
> > > > >
> > > > > * Lokesh Gidra <lokeshgidra@google.com> [240208 16:22]:
> > > > > > All userfaultfd operations, except write-protect, opportunistic=
ally use
> > > > > > per-vma locks to lock vmas. On failure, attempt again inside mm=
ap_lock
> > > > > > critical section.
> > > > > >
> > > > > > Write-protect operation requires mmap_lock as it iterates over =
multiple
> > > > > > vmas.
> > > > > >
> > > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > > ---
> > > > > >  fs/userfaultfd.c              |  13 +-
> > > > > >  include/linux/userfaultfd_k.h |   5 +-
> > > > > >  mm/userfaultfd.c              | 356 ++++++++++++++++++++++++++=
--------
> > > > > >  3 files changed, 275 insertions(+), 99 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > > > index c00a021bcce4..60dcfafdc11a 100644
> > > > > > --- a/fs/userfaultfd.c
> > > > > > +++ b/fs/userfaultfd.c
> > > > > > @@ -2005,17 +2005,8 @@ static int userfaultfd_move(struct userf=
aultfd_ctx *ctx,
> > > > > >               return -EINVAL;
> > > > > >
> > > > > >       if (mmget_not_zero(mm)) {
> > > > > > -             mmap_read_lock(mm);
> > > > > > -
> > > > > > -             /* Re-check after taking map_changing_lock */
> > > > > > -             down_read(&ctx->map_changing_lock);
> > > > > > -             if (likely(!atomic_read(&ctx->mmap_changing)))
> > > > > > -                     ret =3D move_pages(ctx, mm, uffdio_move.d=
st, uffdio_move.src,
> > > > > > -                                      uffdio_move.len, uffdio_=
move.mode);
> > > > > > -             else
> > > > > > -                     ret =3D -EAGAIN;
> > > > > > -             up_read(&ctx->map_changing_lock);
> > > > > > -             mmap_read_unlock(mm);
> > > > > > +             ret =3D move_pages(ctx, uffdio_move.dst, uffdio_m=
ove.src,
> > > > > > +                              uffdio_move.len, uffdio_move.mod=
e);
> > > > > >               mmput(mm);
> > > > > >       } else {
> > > > > >               return -ESRCH;
> > > > > > diff --git a/include/linux/userfaultfd_k.h b/include/linux/user=
faultfd_k.h
> > > > > > index 3210c3552976..05d59f74fc88 100644
> > > > > > --- a/include/linux/userfaultfd_k.h
> > > > > > +++ b/include/linux/userfaultfd_k.h
> > > > > > @@ -138,9 +138,8 @@ extern long uffd_wp_range(struct vm_area_st=
ruct *vma,
> > > > > >  /* move_pages */
> > > > > >  void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> > > > > >  void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> > > > > > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_stru=
ct *mm,
> > > > > > -                unsigned long dst_start, unsigned long src_sta=
rt,
> > > > > > -                unsigned long len, __u64 flags);
> > > > > > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long =
dst_start,
> > > > > > +                unsigned long src_start, unsigned long len, __=
u64 flags);
> > > > > >  int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, =
pmd_t *src_pmd, pmd_t dst_pmdval,
> > > > > >                       struct vm_area_struct *dst_vma,
> > > > > >                       struct vm_area_struct *src_vma,
> > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > index 74aad0831e40..1e25768b2136 100644
> > > > > > --- a/mm/userfaultfd.c
> > > > > > +++ b/mm/userfaultfd.c
> > > > > > @@ -19,20 +19,12 @@
> > > > > >  #include <asm/tlb.h>
> > > > > >  #include "internal.h"
> > > > > >
> > > > > > -static __always_inline
> > > > > > -struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
> > > > > > -                                 unsigned long dst_start,
> > > > > > -                                 unsigned long len)
> > > > >
> > > > > You could probably leave the __always_inline for this.
> > > >
> > > > Sure
> > > > >
> > > > > > +static bool validate_dst_vma(struct vm_area_struct *dst_vma,
> > > > > > +                          unsigned long dst_end)
> > > > > >  {
> > > > > > -     /*
> > > > > > -      * Make sure that the dst range is both valid and fully w=
ithin a
> > > > > > -      * single existing vma.
> > > > > > -      */
> > > > > > -     struct vm_area_struct *dst_vma;
> > > > > > -
> > > > > > -     dst_vma =3D find_vma(dst_mm, dst_start);
> > > > > > -     if (!range_in_vma(dst_vma, dst_start, dst_start + len))
> > > > > > -             return NULL;
> > > > > > +     /* Make sure that the dst range is fully within dst_vma. =
*/
> > > > > > +     if (dst_end > dst_vma->vm_end)
> > > > > > +             return false;
> > > > > >
> > > > > >       /*
> > > > > >        * Check the vma is registered in uffd, this is required =
to
> > > > > > @@ -40,11 +32,125 @@ struct vm_area_struct *find_dst_vma(struct=
 mm_struct *dst_mm,
> > > > > >        * time.
> > > > > >        */
> > > > > >       if (!dst_vma->vm_userfaultfd_ctx.ctx)
> > > > > > -             return NULL;
> > > > > > +             return false;
> > > > > > +
> > > > > > +     return true;
> > > > > > +}
> > > > > > +
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +/*
> > > > > > + * lock_vma() - Lookup and lock vma corresponding to @address.
> > > > > > + * @mm: mm to search vma in.
> > > > > > + * @address: address that the vma should contain.
> > > > > > + * @prepare_anon: If true, then prepare the vma (if private) w=
ith anon_vma.
> > > > > > + *
> > > > > > + * Should be called without holding mmap_lock. vma should be u=
nlocked after use
> > > > > > + * with unlock_vma().
> > > > > > + *
> > > > > > + * Return: A locked vma containing @address, NULL if no vma is=
 found, or
> > > > > > + * -ENOMEM if anon_vma couldn't be allocated.
> > > > > > + */
> > > > > > +static struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > > > > > +                                    unsigned long address,
> > > > > > +                                    bool prepare_anon)
> > > > > > +{
> > > > > > +     struct vm_area_struct *vma;
> > > > > > +
> > > > > > +     vma =3D lock_vma_under_rcu(mm, address);
> > > > > > +     if (vma) {
> > > > > > +             /*
> > > > > > +              * lock_vma_under_rcu() only checks anon_vma for =
private
> > > > > > +              * anonymous mappings. But we need to ensure it i=
s assigned in
> > > > > > +              * private file-backed vmas as well.
> > > > > > +              */
> > > > > > +             if (prepare_anon && !(vma->vm_flags & VM_SHARED) =
&&
> > > > > > +                 !vma->anon_vma)
> > > > > > +                     vma_end_read(vma);
> > > > > > +             else
> > > > > > +                     return vma;
> > > > > > +     }
> > > > > > +
> > > > > > +     mmap_read_lock(mm);
> > > > > > +     vma =3D vma_lookup(mm, address);
> > > > > > +     if (vma) {
> > > > > > +             if (prepare_anon && !(vma->vm_flags & VM_SHARED) =
&&
> > > > > > +                 anon_vma_prepare(vma)) {
> > > > > > +                     vma =3D ERR_PTR(-ENOMEM);
> > > > > > +             } else {
> > > > > > +                     /*
> > > > > > +                      * We cannot use vma_start_read() as it m=
ay fail due to
> > > > > > +                      * false locked (see comment in vma_start=
_read()). We
> > > > > > +                      * can avoid that by directly locking vm_=
lock under
> > > > > > +                      * mmap_lock, which guarantees that nobod=
y can lock the
> > > > > > +                      * vma for write (vma_start_write()) unde=
r us.
> > > > > > +                      */
> > > > > > +                     down_read(&vma->vm_lock->lock);
> > > > > > +             }
> > > > > > +     }
> > > > > > +
> > > > > > +     mmap_read_unlock(mm);
> > > > > > +     return vma;
> > > > > > +}
> > > > > > +
> > > > > > +static void unlock_vma(struct vm_area_struct *vma)
> > > > > > +{
> > > > > > +     vma_end_read(vma);
> > > > > > +}
> > > > > > +
> > > > > > +static struct vm_area_struct *find_and_lock_dst_vma(struct mm_=
struct *dst_mm,
> > > > > > +                                                 unsigned long=
 dst_start,
> > > > > > +                                                 unsigned long=
 len)
> > > > > > +{
> > > > > > +     struct vm_area_struct *dst_vma;
> > > > > > +
> > > > > > +     /* Ensure anon_vma is assigned for private vmas */
> > > > > > +     dst_vma =3D lock_vma(dst_mm, dst_start, true);
> > > > > > +
> > > > > > +     if (!dst_vma)
> > > > > > +             return ERR_PTR(-ENOENT);
> > > > > > +
> > > > > > +     if (PTR_ERR(dst_vma) =3D=3D -ENOMEM)
> > > > > > +             return dst_vma;
> > > > > > +
> > > > > > +     if (!validate_dst_vma(dst_vma, dst_start + len))
> > > > > > +             goto out_unlock;
> > > > > >
> > > > > >       return dst_vma;
> > > > > > +out_unlock:
> > > > > > +     unlock_vma(dst_vma);
> > > > > > +     return ERR_PTR(-ENOENT);
> > > > > >  }
> > > > > >
> > > > > > +#else
> > > > > > +
> > > > > > +static struct vm_area_struct *lock_mm_and_find_dst_vma(struct =
mm_struct *dst_mm,
> > > > > > +                                                    unsigned l=
ong dst_start,
> > > > > > +                                                    unsigned l=
ong len)
> > > > > > +{
> > > > > > +     struct vm_area_struct *dst_vma;
> > > > > > +     int err =3D -ENOENT;
> > > > > > +
> > > > > > +     mmap_read_lock(dst_mm);
> > > > > > +     dst_vma =3D vma_lookup(dst_mm, dst_start);
> > > > > > +     if (!dst_vma)
> > > > > > +             goto out_unlock;
> > > > > > +
> > > > > > +     /* Ensure anon_vma is assigned for private vmas */
> > > > > > +     if (!(dst_vma->vm_flags & VM_SHARED) && anon_vma_prepare(=
dst_vma)) {
> > > > > > +             err =3D -ENOMEM;
> > > > > > +             goto out_unlock;
> > > > > > +     }
> > > > > > +
> > > > > > +     if (!validate_dst_vma(dst_vma, dst_start + len))
> > > > > > +             goto out_unlock;
> > > > > > +
> > > > > > +     return dst_vma;
> > > > > > +out_unlock:
> > > > > > +     mmap_read_unlock(dst_mm);
> > > > > > +     return ERR_PTR(err);
> > > > > > +}
> > > > > > +#endif
> > > > > > +
> > > > > >  /* Check if dst_addr is outside of file's size. Must be called=
 with ptl held. */
> > > > > >  static bool mfill_file_over_size(struct vm_area_struct *dst_vm=
a,
> > > > > >                                unsigned long dst_addr)
> > > > > > @@ -350,7 +456,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct=
 *mm, unsigned long address)
> > > > > >  #ifdef CONFIG_HUGETLB_PAGE
> > > > > >  /*
> > > > > >   * mfill_atomic processing for HUGETLB vmas.  Note that this r=
outine is
> > > > > > - * called with mmap_lock held, it will release mmap_lock befor=
e returning.
> > > > > > + * called with either vma-lock or mmap_lock held, it will rele=
ase the lock
> > > > > > + * before returning.
> > > > > >   */
> > > > > >  static __always_inline ssize_t mfill_atomic_hugetlb(
> > > > > >                                             struct userfaultfd_=
ctx *ctx,
> > > > > > @@ -361,7 +468,6 @@ static __always_inline ssize_t mfill_atomic=
_hugetlb(
> > > > > >                                             uffd_flags_t flags)
> > > > > >  {
> > > > > >       struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> > > > > > -     int vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > > > > >       ssize_t err;
> > > > > >       pte_t *dst_pte;
> > > > > >       unsigned long src_addr, dst_addr;
> > > > > > @@ -380,7 +486,11 @@ static __always_inline ssize_t mfill_atomi=
c_hugetlb(
> > > > > >        */
> > > > > >       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> > > > > >               up_read(&ctx->map_changing_lock);
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +             unlock_vma(dst_vma);
> > > > > > +#else
> > > > > >               mmap_read_unlock(dst_mm);
> > > > > > +#endif
> > > > > >               return -EINVAL;
> > > > > >       }
> > > > > >
> > > > > > @@ -403,24 +513,32 @@ static __always_inline ssize_t mfill_atom=
ic_hugetlb(
> > > > > >        * retry, dst_vma will be set to NULL and we must lookup =
again.
> > > > > >        */
> > > > > >       if (!dst_vma) {
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +             dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_sta=
rt, len);
> > > > > > +#else
> > > > > > +             dst_vma =3D lock_mm_and_find_dst_vma(dst_mm, dst_=
start, len);
> > > > > > +#endif
> > > > > > +             if (IS_ERR(dst_vma)) {
> > > > > > +                     err =3D PTR_ERR(dst_vma);
> > > > > > +                     goto out;
> > > > > > +             }
> > > > > > +
> > > > > >               err =3D -ENOENT;
> > > > > > -             dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > > > > -             if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
> > > > > > -                     goto out_unlock;
> > > > > > +             if (!is_vm_hugetlb_page(dst_vma))
> > > > > > +                     goto out_unlock_vma;
> > > > > >
> > > > > >               err =3D -EINVAL;
> > > > > >               if (vma_hpagesize !=3D vma_kernel_pagesize(dst_vm=
a))
> > > > > > -                     goto out_unlock;
> > > > > > -
> > > > > > -             vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > > > > > -     }
> > > > > > +                     goto out_unlock_vma;
> > > > > >
> > > > > > -     /*
> > > > > > -      * If not shared, ensure the dst_vma has a anon_vma.
> > > > > > -      */
> > > > > > -     err =3D -ENOMEM;
> > > > > > -     if (!vm_shared) {
> > > > > > -             if (unlikely(anon_vma_prepare(dst_vma)))
> > > > > > +             /*
> > > > > > +              * If memory mappings are changing because of non=
-cooperative
> > > > > > +              * operation (e.g. mremap) running in parallel, b=
ail out and
> > > > > > +              * request the user to retry later
> > > > > > +              */
> > > > > > +             down_read(&ctx->map_changing_lock);
> > > > > > +             err =3D -EAGAIN;
> > > > > > +             if (atomic_read(&ctx->mmap_changing))
> > > > > >                       goto out_unlock;
> > > > > >       }
> > > > > >
> > > > > > @@ -465,7 +583,11 @@ static __always_inline ssize_t mfill_atomi=
c_hugetlb(
> > > > > >
> > > > > >               if (unlikely(err =3D=3D -ENOENT)) {
> > > > > >                       up_read(&ctx->map_changing_lock);
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +                     unlock_vma(dst_vma);
> > > > > > +#else
> > > > > >                       mmap_read_unlock(dst_mm);
> > > > > > +#endif
> > > > > >                       BUG_ON(!folio);
> > > > > >
> > > > > >                       err =3D copy_folio_from_user(folio,
> > > > > > @@ -474,17 +596,6 @@ static __always_inline ssize_t mfill_atomi=
c_hugetlb(
> > > > > >                               err =3D -EFAULT;
> > > > > >                               goto out;
> > > > > >                       }
> > > > > > -                     mmap_read_lock(dst_mm);
> > > > > > -                     down_read(&ctx->map_changing_lock);
> > > > > > -                     /*
> > > > > > -                      * If memory mappings are changing becaus=
e of non-cooperative
> > > > > > -                      * operation (e.g. mremap) running in par=
allel, bail out and
> > > > > > -                      * request the user to retry later
> > > > > > -                      */
> > > > > > -                     if (atomic_read(&ctx->mmap_changing)) {
> > > > > > -                             err =3D -EAGAIN;
> > > > > > -                             break;
> > > > > > -                     }
> > > > > >
> > > > > >                       dst_vma =3D NULL;
> > > > > >                       goto retry;
> > > > > > @@ -505,7 +616,12 @@ static __always_inline ssize_t mfill_atomi=
c_hugetlb(
> > > > > >
> > > > > >  out_unlock:
> > > > > >       up_read(&ctx->map_changing_lock);
> > > > > > +out_unlock_vma:
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +     unlock_vma(dst_vma);
> > > > > > +#else
> > > > > >       mmap_read_unlock(dst_mm);
> > > > > > +#endif
> > > > > >  out:
> > > > > >       if (folio)
> > > > > >               folio_put(folio);
> > > > > > @@ -597,7 +713,19 @@ static __always_inline ssize_t mfill_atomi=
c(struct userfaultfd_ctx *ctx,
> > > > > >       copied =3D 0;
> > > > > >       folio =3D NULL;
> > > > > >  retry:
> > > > > > -     mmap_read_lock(dst_mm);
> > > > > > +     /*
> > > > > > +      * Make sure the vma is not shared, that the dst range is
> > > > > > +      * both valid and fully within a single existing vma.
> > > > > > +      */
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +     dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_start, len)=
;
> > > > > > +#else
> > > > > > +     dst_vma =3D lock_mm_and_find_dst_vma(dst_mm, dst_start, l=
en);
> > > > > > +#endif
> > > > > > +     if (IS_ERR(dst_vma)) {
> > > > > > +             err =3D PTR_ERR(dst_vma);
> > > > > > +             goto out;
> > > > > > +     }
> > > > > >
> > > > > >       /*
> > > > > >        * If memory mappings are changing because of non-coopera=
tive
> > > > > > @@ -609,15 +737,6 @@ static __always_inline ssize_t mfill_atomi=
c(struct userfaultfd_ctx *ctx,
> > > > > >       if (atomic_read(&ctx->mmap_changing))
> > > > > >               goto out_unlock;
> > > > > >
> > > > > > -     /*
> > > > > > -      * Make sure the vma is not shared, that the dst range is
> > > > > > -      * both valid and fully within a single existing vma.
> > > > > > -      */
> > > > > > -     err =3D -ENOENT;
> > > > > > -     dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > > > > -     if (!dst_vma)
> > > > > > -             goto out_unlock;
> > > > > > -
> > > > > >       err =3D -EINVAL;
> > > > > >       /*
> > > > > >        * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|=
MAP_SHARED but
> > > > > > @@ -647,16 +766,6 @@ static __always_inline ssize_t mfill_atomi=
c(struct userfaultfd_ctx *ctx,
> > > > > >           uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> > > > > >               goto out_unlock;
> > > > > >
> > > > > > -     /*
> > > > > > -      * Ensure the dst_vma has a anon_vma or this page
> > > > > > -      * would get a NULL anon_vma when moved in the
> > > > > > -      * dst_vma.
> > > > > > -      */
> > > > > > -     err =3D -ENOMEM;
> > > > > > -     if (!(dst_vma->vm_flags & VM_SHARED) &&
> > > > > > -         unlikely(anon_vma_prepare(dst_vma)))
> > > > > > -             goto out_unlock;
> > > > > > -
> > > > > >       while (src_addr < src_start + len) {
> > > > > >               pmd_t dst_pmdval;
> > > > > >
> > > > > > @@ -699,7 +808,11 @@ static __always_inline ssize_t mfill_atomi=
c(struct userfaultfd_ctx *ctx,
> > > > > >                       void *kaddr;
> > > > > >
> > > > > >                       up_read(&ctx->map_changing_lock);
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +                     unlock_vma(dst_vma);
> > > > > > +#else
> > > > > >                       mmap_read_unlock(dst_mm);
> > > > > > +#endif
> > > > > >                       BUG_ON(!folio);
> > > > > >
> > > > > >                       kaddr =3D kmap_local_folio(folio, 0);
> > > > > > @@ -730,7 +843,11 @@ static __always_inline ssize_t mfill_atomi=
c(struct userfaultfd_ctx *ctx,
> > > > > >
> > > > > >  out_unlock:
> > > > > >       up_read(&ctx->map_changing_lock);
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +     unlock_vma(dst_vma);
> > > > > > +#else
> > > > > >       mmap_read_unlock(dst_mm);
> > > > > > +#endif
> > > > > >  out:
> > > > > >       if (folio)
> > > > > >               folio_put(folio);
> > > > > > @@ -1267,16 +1384,67 @@ static int validate_move_areas(struct u=
serfaultfd_ctx *ctx,
> > > > > >       if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_v=
ma))
> > > > > >               return -EINVAL;
> > > > > >
> > > > > > -     /*
> > > > > > -      * Ensure the dst_vma has a anon_vma or this page
> > > > > > -      * would get a NULL anon_vma when moved in the
> > > > > > -      * dst_vma.
> > > > > > -      */
> > > > > > -     if (unlikely(anon_vma_prepare(dst_vma)))
> > > > > > -             return -ENOMEM;
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +static int find_and_lock_vmas(struct mm_struct *mm,
> > > > > > +                           unsigned long dst_start,
> > > > > > +                           unsigned long src_start,
> > > > > > +                           struct vm_area_struct **dst_vmap,
> > > > > > +                           struct vm_area_struct **src_vmap)
> > > > > > +{
> > > > > > +     int err;
> > > > > > +
> > > > > > +     /* There is no need to prepare anon_vma for src_vma */
> > > > > > +     *src_vmap =3D lock_vma(mm, src_start, false);
> > > > > > +     if (!*src_vmap)
> > > > > > +             return -ENOENT;
> > > > > > +
> > > > > > +     /* Ensure anon_vma is assigned for anonymous vma */
> > > > > > +     *dst_vmap =3D lock_vma(mm, dst_start, true);
> > > > > > +     err =3D -ENOENT;
> > > > > > +     if (!*dst_vmap)
> > > > > > +             goto out_unlock;
> > > > > > +
> > > > > > +     err =3D -ENOMEM;
> > > > > > +     if (PTR_ERR(*dst_vmap) =3D=3D -ENOMEM)
> > > > > > +             goto out_unlock;
> > > > >
> > > > > If you change lock_vma() to return the vma or ERR_PTR(-ENOENT) /
> > > > > ERR_PTR(-ENOMEM), then you could change this to check IS_ERR() an=
d
> > > > > return the PTR_ERR().
> > > > >
> > > > > You could also use IS_ERR_OR_NULL here, but the first suggestion =
will
> > > > > simplify your life for find_and_lock_dst_vma() and the error type=
 to
> > > > > return.
> > > >
> > > > Good suggestion. I'll make the change. Thanks
> > > > >
> > > > > What you have here will work though.
> > > > >
> > > > > >
> > > > > >       return 0;
> > > > > > +out_unlock:
> > > > > > +     unlock_vma(*src_vmap);
> > > > > > +     return err;
> > > > > >  }

The current implementation has a deadlock problem:

thread 1
                                     thread 2

vma_start_read(dst_vma)


                                         mmap_write_lock()

                                         vma_start_write(src_vma)
vma_start_read(src_vma) fails
mmap_read_lock() blocks


                                        vma_start_write(dst_vma)
blocks


I think the solution is to implement it this way:

long find_and_lock_vmas(...)
{
              dst_vma =3D lock_vma(mm, dst_start, true);
              if (IS_ERR(dst_vma))
                          return PTR_ERR(vma);

              src_vma =3D lock_vma_under_rcu(mm, src_start);
              if (!src_vma) {
                            long err;
                            if (mmap_read_trylock(mm)) {
                                            src_vma =3D vma_lookup(mm, src_=
start);
                                            if (src_vma) {

down_read(&src_vma->vm_lock->lock);
                                                        err =3D 0;
                                            } else {
                                                       err =3D -ENOENT;
                                            }
                                            mmap_read_unlock(mm);
                               } else {
                                           vma_end_read(dst_vma);
                                           err =3D lock_mm_and_find_vmas(..=
.);
                                           if (!err) {
                                                         mmap_read_unlock(m=
m);
                                           }
                                }
                                return err;
              }
              return 0;
}

Of course this would need defining lock_mm_and_find_vmas() regardless
of CONFIG_PER_VMA_LOCK. I can also remove the prepare_anon condition
in lock_vma().

> > > > > > +#else
> > > > > > +static int lock_mm_and_find_vmas(struct mm_struct *mm,
> > > > > > +                              unsigned long dst_start,
> > > > > > +                              unsigned long src_start,
> > > > > > +                              struct vm_area_struct **dst_vmap=
,
> > > > > > +                              struct vm_area_struct **src_vmap=
)
> > > > > > +{
> > > > > > +     int err =3D -ENOENT;
> > > > >
> > > > > Nit: new line after declarations.
> > > > >
> > > > > > +     mmap_read_lock(mm);
> > > > > > +
> > > > > > +     *src_vmap =3D vma_lookup(mm, src_start);
> > > > > > +     if (!*src_vmap)
> > > > > > +             goto out_unlock;
> > > > > > +
> > > > > > +     *dst_vmap =3D vma_lookup(mm, dst_start);
> > > > > > +     if (!*dst_vmap)
> > > > > > +             goto out_unlock;
> > > > > > +
> > > > > > +     /* Ensure anon_vma is assigned */
> > > > > > +     err =3D -ENOMEM;
> > > > > > +     if (vma_is_anonymous(*dst_vmap) && anon_vma_prepare(*dst_=
vmap))
> > > > > > +             goto out_unlock;
> > > > > > +
> > > > > > +     return 0;
> > > > > > +out_unlock:
> > > > > > +     mmap_read_unlock(mm);
> > > > > > +     return err;
> > > > > > +}
> > > > > > +#endif
> > > > > >
> > > > > >  /**
> > > > > >   * move_pages - move arbitrary anonymous pages of an existing =
vma
> > > > > > @@ -1287,8 +1455,6 @@ static int validate_move_areas(struct use=
rfaultfd_ctx *ctx,
> > > > > >   * @len: length of the virtual memory range
> > > > > >   * @mode: flags from uffdio_move.mode
> > > > > >   *
> > > > > > - * Must be called with mmap_lock held for read.
> > > > > > - *
> > > > >
> > > > > Will either use the mmap_lock in read mode or per-vma locking ?
> > > >
> > > > Makes sense. Will add it.
> > > > >
> > > > > >   * move_pages() remaps arbitrary anonymous pages atomically in=
 zero
> > > > > >   * copy. It only works on non shared anonymous pages because t=
hose can
> > > > > >   * be relocated without generating non linear anon_vmas in the=
 rmap
> > > > > > @@ -1355,10 +1521,10 @@ static int validate_move_areas(struct u=
serfaultfd_ctx *ctx,
> > > > > >   * could be obtained. This is the only additional complexity a=
dded to
> > > > > >   * the rmap code to provide this anonymous page remapping func=
tionality.
> > > > > >   */
> > > > > > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_stru=
ct *mm,
> > > > > > -                unsigned long dst_start, unsigned long src_sta=
rt,
> > > > > > -                unsigned long len, __u64 mode)
> > > > > > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long =
dst_start,
> > > > > > +                unsigned long src_start, unsigned long len, __=
u64 mode)
> > > > > >  {
> > > > > > +     struct mm_struct *mm =3D ctx->mm;
> > > > >
> > > > > You dropped the argument, but left the comment for the argument.
> > > >
> > > > Thanks, will fix it.
> > > > >
> > > > > >       struct vm_area_struct *src_vma, *dst_vma;
> > > > > >       unsigned long src_addr, dst_addr;
> > > > > >       pmd_t *src_pmd, *dst_pmd;
> > > > > > @@ -1376,28 +1542,40 @@ ssize_t move_pages(struct userfaultfd_c=
tx *ctx, struct mm_struct *mm,
> > > > > >           WARN_ON_ONCE(dst_start + len <=3D dst_start))
> > > > > >               goto out;
> > > > > >
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +     err =3D find_and_lock_vmas(mm, dst_start, src_start,
> > > > > > +                              &dst_vma, &src_vma);
> > > > > > +#else
> > > > > > +     err =3D lock_mm_and_find_vmas(mm, dst_start, src_start,
> > > > > > +                                 &dst_vma, &src_vma);
> > > > > > +#endif
> > > > >
> > > > > I was hoping you could hide this completely, but it's probably be=
tter to
> > > > > show what's going on and the function names document it well.
> > > >
> > > > I wanted to hide unlock as it's called several times, but then I
> > > > thought you wanted explicit calls to mmap_read_unlock() so didn't h=
ide
> > > > it. If you are ok can I define unlock_vma() for !CONFIG_PER_VMA_LOC=
K
> > > > as well, calling mmap_read_unlock()?
> > >
> > > My bigger problem was with the name.  We can't have unlock_vma()
> > > just unlock the mm - it is confusing to read and I think it'll lead t=
o
> > > misunderstandings of what is really going on here.
> > >
> > > Whatever you decide to do is fine as long as it's clear what's going =
on.
> > > I think this is clear while hiding it could also be clear with the ri=
ght
> > > function name - I'm not sure what that would be; naming is hard.
> >
> > Maybe unlock_mm_or_vma() ? If not then I'll just keep it as is.
> >
>
> Maybe just leave it as it is unless someone else has issue with it.
> Using some form of uffd_unlock name runs into the question of that
> atomic and the new lock.

Sure. I'll let it as it is.
>
>

