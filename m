Return-Path: <linux-fsdevel+bounces-9609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B007B843453
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 04:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277E01F2612B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 03:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23279107AA;
	Wed, 31 Jan 2024 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuRi4O+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B9FBF1
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706670206; cv=none; b=itFA7m/xzh0AhRSe2+axcHoOuCxd2g/CNiGIAfhSHu1DgjM/BwMRSkrVoWIj3Rtxffb45tEQjOSMgERmwOGLf8ZnvNLZphbFKyE4CcwFJxXKscMs3+k4+4JVAl3i1Zdi1M6tZdNWW2HOYcLq7I7YP+nqp8c5cCkxP+SE+EdpXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706670206; c=relaxed/simple;
	bh=daUKYDL/6IzbcpClNbJr9o4qH2Hmr8Hjfbl3notoBnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZRXH7FDdNoik35GPuihQ0OZI1uEPCl3JfsIfe0OiR3yuYVPKz9H4d4imeCbbVIHHe94eqhn9GvD1BHT/voo9AfwQy8i97HH87V1vqxhsxEya2fnlP0OVQBDqwr5Si1srwAdtpVqPsRgMoeKkNXAqqqWwT9Z3kPGopGME/QIgsJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PuRi4O+a; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-602c91a76b1so56346247b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 19:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706670202; x=1707275002; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeaIbFJEjMZ0jRQys0Xul9vkIHuknBKw4VAfLwsPlGE=;
        b=PuRi4O+aBk0/meGg0iuPjbnu6f9d38eDCFRfIrOx4k6NCYjOg5ZBIFJ4hEuFD3n7iU
         SW+J73818oSlnBs1Zk1j8XCVJPhm7DjOiF8Y240ArAkGMVsdyOxTk9tRLBpVEG9/+p3U
         jHI1n14PnH3N6hJgF8ADKcgVLnDRarPN0M5GGgRACcniDhWkNmcdvrFOQc0J4qJTtC3J
         QR5Do1cqmi7SsD/njMMeQ8Cf5lKa5PmN4d6DI7ZFt6JY+2PgXlAADAjli76QrqlkYAmN
         nHosi6+g+Zog51I9KOVwaaL2EFXrYdr1DfodIfoCpXc2sy6HsPgYfu6ait2clqwmsQTf
         ZUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706670202; x=1707275002;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeaIbFJEjMZ0jRQys0Xul9vkIHuknBKw4VAfLwsPlGE=;
        b=b6MMFjaSfYYChtP7qKSp0TCO1pi+tBFeBaX4s70KwNN362xbdupDRznutUXdG6/yoZ
         fOZmT6E8tz6XcrtZSAga3UqnxUXJ8McTLzzWK4mtflVv1cb9B4Jqirlwy9NcDcI21b7U
         TVzbnPo6z5DwLjTktxqwtAdEftg9tQdUtyyY/2yb8CRW9QqHlA/r5QVA0NtdRGjxo0ws
         qhyGmKg33jWL8rCTAFNFR+yWJ5fF6SNYg5kfEX0y19AVJWJzGM7OsnAwDHgM7yuYPt+G
         E/1uH+3aAay6pG7gdhD6+Bos6mcJocK939WpmQa0hawmBjjlHE06N1PrWz1lzD4m6ZgR
         UG0A==
X-Gm-Message-State: AOJu0YwlYhkGTA20ta/btkQorWFmaJQRhWaTDn9hPMTtFWXxziMc/+7w
	RWQB1aLqCA2tY1zZukRdBChEIH482zQqwFxWXM0S3Dj6ekstapwG8ioaPwY13HZlDKCOCgGMIYl
	lHEkznlEr8QeDdIKV+AR6EmEUWuaDCyCks6MdMw+lkLr9QfOEp51f
X-Google-Smtp-Source: AGHT+IE3JqiRxQpLsHDzLnwnusIVr4AxaI4+mlcuADQqpwyZllmFdJ4pO9RklMYhNvbRs55AaiTnw4zSNQf/C/pPmLE=
X-Received: by 2002:a81:ae16:0:b0:604:4f5:f258 with SMTP id
 m22-20020a81ae16000000b0060404f5f258mr290649ywh.25.1706670201976; Tue, 30 Jan
 2024 19:03:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-4-lokeshgidra@google.com> <20240129203626.uq5tdic4z5qua5qy@revolver>
 <CAJuCfpFS=h8h1Tgn55Hv+cr9bUFFoUvejiFQsHGN5yT7utpDMg@mail.gmail.com>
 <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com> <20240130025803.2go3xekza5qubxgz@revolver>
In-Reply-To: <20240130025803.2go3xekza5qubxgz@revolver>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 30 Jan 2024 19:03:11 -0800
Message-ID: <CAJuCfpF0J_7vgTZim3vfH6=ExRTsCRtpg+beJ+bJfYEqD5Se8g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 6:58=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240129 19:28]:
> > On Mon, Jan 29, 2024 at 12:53=E2=80=AFPM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > >
>
> ...
>
> >
> > Thanks for informing. So vma_lookup() returns the vma for any address
> > within [vma->vm_start, vma->vm_end)?
>
> No.  It returns the vma that contains the address passed.  If there
> isn't one, you will get NULL.  This is why the range check is not
> needed.
>
> find_vma() walks to the address passed and if it is NULL, it returns a
> vma that has a higher start address than the one passed (or, rarely NULL
> if it runs off the edge).
>
> > > > If you want to search upwards from dst_start for a VMA then you sho=
uld
> > > > move the range check below into this brace.
> > > >
> > > > > +     }
> > > > > +
> > > > >       /*
> > > > >        * Make sure that the dst range is both valid and fully wit=
hin a
> > > > >        * single existing vma.
> > > > >        */
> > > > > -     struct vm_area_struct *dst_vma;
> > > > > -
> > > > > -     dst_vma =3D find_vma(dst_mm, dst_start);
> > > > >       if (!range_in_vma(dst_vma, dst_start, dst_start + len))
> > > > > -             return NULL;
> > > > > +             goto unpin;
> > > > >
> > > > >       /*
> > > > >        * Check the vma is registered in uffd, this is required to
> > > > > @@ -40,9 +59,13 @@ struct vm_area_struct *find_dst_vma(struct mm_=
struct *dst_mm,
> > > > >        * time.
> > > > >        */
> > > > >       if (!dst_vma->vm_userfaultfd_ctx.ctx)
> > > > > -             return NULL;
> > > > > +             goto unpin;
> > > > >
> > > > >       return dst_vma;
> > > > > +
> > > > > +unpin:
> > > > > +     unpin_vma(dst_mm, dst_vma, mmap_locked);
> > > > > +     return NULL;
> > > > >  }
> > > > >
> > > > >  /* Check if dst_addr is outside of file's size. Must be called w=
ith ptl held. */
> > > > > @@ -350,7 +373,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *=
mm, unsigned long address)
> > > > >  #ifdef CONFIG_HUGETLB_PAGE
> > > > >  /*
> > > > >   * mfill_atomic processing for HUGETLB vmas.  Note that this rou=
tine is
> > > > > - * called with mmap_lock held, it will release mmap_lock before =
returning.
> > > > > + * called with either vma-lock or mmap_lock held, it will releas=
e the lock
> > > > > + * before returning.
> > > > >   */
> > > > >  static __always_inline ssize_t mfill_atomic_hugetlb(
> > > > >                                             struct userfaultfd_ct=
x *ctx,
> > > > > @@ -358,7 +382,8 @@ static __always_inline ssize_t mfill_atomic_h=
ugetlb(
> > > > >                                             unsigned long dst_sta=
rt,
> > > > >                                             unsigned long src_sta=
rt,
> > > > >                                             unsigned long len,
> > > > > -                                           uffd_flags_t flags)
> > > > > +                                           uffd_flags_t flags,
> > > > > +                                           bool *mmap_locked)
> > > > >  {
> > > > >       struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> > > > >       int vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > > > > @@ -380,7 +405,7 @@ static __always_inline ssize_t mfill_atomic_h=
ugetlb(
> > > > >        */
> > > > >       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> > > > >               up_read(&ctx->map_changing_lock);
> > > > > -             mmap_read_unlock(dst_mm);
> > > > > +             unpin_vma(dst_mm, dst_vma, mmap_locked);
> > > > >               return -EINVAL;
> > > > >       }
> > > > >
> > > > > @@ -404,12 +429,25 @@ static __always_inline ssize_t mfill_atomic=
_hugetlb(
> > > > >        */
> > > > >       if (!dst_vma) {
> > > > >               err =3D -ENOENT;
> > > > > -             dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > > > -             if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
> > > > > -                     goto out_unlock;
> > > > > +             dst_vma =3D find_and_pin_dst_vma(dst_mm, dst_start,
> > > > > +                                            len, mmap_locked);
> > > > > +             if (!dst_vma)
> > > > > +                     goto out;
> > > > > +             if (!is_vm_hugetlb_page(dst_vma))
> > > > > +                     goto out_unlock_vma;
> > > > >
> > > > >               err =3D -EINVAL;
> > > > >               if (vma_hpagesize !=3D vma_kernel_pagesize(dst_vma)=
)
> > > > > +                     goto out_unlock_vma;
> > > > > +
> > > > > +             /*
> > > > > +              * If memory mappings are changing because of non-c=
ooperative
> > > > > +              * operation (e.g. mremap) running in parallel, bai=
l out and
> > > > > +              * request the user to retry later
> > > > > +              */
> > > > > +             down_read(&ctx->map_changing_lock);
> > > > > +             err =3D -EAGAIN;
> > > > > +             if (atomic_read(&ctx->mmap_changing))
> > > > >                       goto out_unlock;
> > > > >
> > > > >               vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > > > > @@ -465,7 +503,7 @@ static __always_inline ssize_t mfill_atomic_h=
ugetlb(
> > > > >
> > > > >               if (unlikely(err =3D=3D -ENOENT)) {
> > > > >                       up_read(&ctx->map_changing_lock);
> > > > > -                     mmap_read_unlock(dst_mm);
> > > > > +                     unpin_vma(dst_mm, dst_vma, mmap_locked);
> > > > >                       BUG_ON(!folio);
> > > > >
> > > > >                       err =3D copy_folio_from_user(folio,
> > > > > @@ -474,17 +512,6 @@ static __always_inline ssize_t mfill_atomic_=
hugetlb(
> > > > >                               err =3D -EFAULT;
> > > > >                               goto out;
> > > > >                       }
> > > > > -                     mmap_read_lock(dst_mm);
> > > > > -                     down_read(&ctx->map_changing_lock);
> > > > > -                     /*
> > > > > -                      * If memory mappings are changing because =
of non-cooperative
> > > > > -                      * operation (e.g. mremap) running in paral=
lel, bail out and
> > > > > -                      * request the user to retry later
> > > > > -                      */
> > > > > -                     if (atomic_read(ctx->mmap_changing)) {
> > > > > -                             err =3D -EAGAIN;
> > > > > -                             break;
> > > > > -                     }
> > > >
> > > > ... Okay, this is where things get confusing.
> > > >
> > > > How about this: Don't do this locking/boolean dance.
> > > >
> > > > Instead, do something like this:
> > > > In mm/memory.c, below lock_vma_under_rcu(), but something like this
> > > >
> > > > struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > > >         unsigned long addr))    /* or some better name.. */
> > > > {
> > > >         struct vm_area_struct *vma;
> > > >
> > > >         vma =3D lock_vma_under_rcu(mm, addr);
> > > >
> > > >         if (vma)
> > > >                 return vma;
> > > >
> > > >         mmap_read_lock(mm);
> > > >         vma =3D lookup_vma(mm, addr);
> > > >         if (vma)
> > > >                 vma_start_read(vma); /* Won't fail */
> > >
> > > Please don't assume vma_start_read() won't fail even when you have
> > > mmap_read_lock(). See the comment in vma_start_read() about the
> > > possibility of an overflow producing false negatives.
> > >
> > > >
> > > >         mmap_read_unlock(mm);
> > > >         return vma;
> > > > }
> > > >
> > > > Now, we know we have a vma that's vma locked if there is a vma.  Th=
e vma
> > > > won't go away - you have it locked.  The mmap lock is held for even
> > > > less time for your worse case, and the code gets easier to follow.
> >
> > Your suggestion is definitely simpler and easier to follow, but due to
> > the overflow situation that Suren pointed out, I would still need to
> > keep the locking/boolean dance, no? IIUC, even if I were to return
> > EAGAIN to the userspace, there is no guarantee that subsequent ioctls
> > on the same vma will succeed due to the same overflow, until someone
> > acquires and releases mmap_lock in write-mode.
> > Also, sometimes it seems insufficient whether we managed to lock vma
> > or not. For instance, lock_vma_under_rcu() checks if anon_vma (for
> > anonymous vma) exists. If not then it bails out.
> > So it seems to me that we have to provide some fall back in
> > userfaultfd operations which executes with mmap_lock in read-mode.
>
> Fair enough, what if we didn't use the sequence number and just locked
> the vma directly?
>
> /* This will wait on the vma lock, so once we return it's locked */
> void vma_aquire_read_lock(struct vm_area_struct *vma)
> {
>         mmap_assert_locked(vma->vm_mm);
>         down_read(&vma->vm_lock->lock);
> }
>
> struct vm_area_struct *lock_vma(struct mm_struct *mm,
>         unsigned long addr))    /* or some better name.. */
> {
>         struct vm_area_struct *vma;
>
>         vma =3D lock_vma_under_rcu(mm, addr);
>         if (vma)
>                 return vma;
>
>         mmap_read_lock(mm);
>         /* mm sequence cannot change, no mm writers anyways.
>          * find_mergeable_anon_vma is only a concern in the page fault
>          * path
>          * start/end won't change under the mmap_lock
>          * vma won't become detached as we have the mmap_lock in read
>          * We are now sure no writes will change the VMA
>          * So let's make sure no other context is isolating the vma
>          */
>         vma =3D lookup_vma(mm, addr);
>         if (vma)
>                 vma_aquire_read_lock(vma);
>
>         mmap_read_unlock(mm);
>         return vma;
> }
>
> I'm betting that avoiding the mmap_lock most of the time is good, but
> then holding it just to lock the vma will have extremely rare collisions
> - and they will be short lived.
>
> This would allow us to simplify your code.
>
> > > >
> > > > Once you are done with the vma do a vma_end_read(vma).  Don't forge=
t to
> > > > do this!
> > > >
> > > > Now the comment above such a function should state that the vma nee=
ds to
> > > > be vma_end_read(vma), or that could go undetected..  It might be wo=
rth
> > > > adding a unlock_vma() counterpart to vma_end_read(vma) even.
> > >
> > > Locking VMA while holding mmap_read_lock is an interesting usage
> > > pattern I haven't seen yet. I think this should work quite well!
> > >
> > > >
> > > >
> > > > >
> > > > >                       dst_vma =3D NULL;
> > > > >                       goto retry;
> > > > > @@ -505,7 +532,8 @@ static __always_inline ssize_t mfill_atomic_h=
ugetlb(
> > > > >
> > > > >  out_unlock:
> > > > >       up_read(&ctx->map_changing_lock);
> > > > > -     mmap_read_unlock(dst_mm);
> > > > > +out_unlock_vma:
> > > > > +     unpin_vma(dst_mm, dst_vma, mmap_locked);
> > > > >  out:
> > > > >       if (folio)
> > > > >               folio_put(folio);
> > > > > @@ -521,7 +549,8 @@ extern ssize_t mfill_atomic_hugetlb(struct us=
erfaultfd_ctx *ctx,
> > > > >                                   unsigned long dst_start,
> > > > >                                   unsigned long src_start,
> > > > >                                   unsigned long len,
> > > > > -                                 uffd_flags_t flags);
> > > > > +                                 uffd_flags_t flags,
> > > > > +                                 bool *mmap_locked);
> > > >
> > > > Just a thought, tabbing in twice for each argument would make this =
more
> > > > compact.
> > > >
> > > >
> > > > >  #endif /* CONFIG_HUGETLB_PAGE */
> > > > >
> > > > >  static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
> > > > > @@ -581,6 +610,7 @@ static __always_inline ssize_t mfill_atomic(s=
truct userfaultfd_ctx *ctx,
> > > > >       unsigned long src_addr, dst_addr;
> > > > >       long copied;
> > > > >       struct folio *folio;
> > > > > +     bool mmap_locked =3D false;
> > > > >
> > > > >       /*
> > > > >        * Sanitize the command parameters:
> > > > > @@ -597,7 +627,14 @@ static __always_inline ssize_t mfill_atomic(=
struct userfaultfd_ctx *ctx,
> > > > >       copied =3D 0;
> > > > >       folio =3D NULL;
> > > > >  retry:
> > > > > -     mmap_read_lock(dst_mm);
> > > > > +     /*
> > > > > +      * Make sure the vma is not shared, that the dst range is
> > > > > +      * both valid and fully within a single existing vma.
> > > > > +      */
> > > > > +     err =3D -ENOENT;
> > > > > +     dst_vma =3D find_and_pin_dst_vma(dst_mm, dst_start, len, &m=
map_locked);
> > > > > +     if (!dst_vma)
> > > > > +             goto out;
> > > > >
> > > > >       /*
> > > > >        * If memory mappings are changing because of non-cooperati=
ve
> > > > > @@ -609,15 +646,6 @@ static __always_inline ssize_t mfill_atomic(=
struct userfaultfd_ctx *ctx,
> > > > >       if (atomic_read(&ctx->mmap_changing))
> > > > >               goto out_unlock;
> > > > >
> > > > > -     /*
> > > > > -      * Make sure the vma is not shared, that the dst range is
> > > > > -      * both valid and fully within a single existing vma.
> > > > > -      */
> > > > > -     err =3D -ENOENT;
> > > > > -     dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > > > -     if (!dst_vma)
> > > > > -             goto out_unlock;
> > > > > -
> > > > >       err =3D -EINVAL;
> > > > >       /*
> > > > >        * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MA=
P_SHARED but
> > > > > @@ -638,8 +666,8 @@ static __always_inline ssize_t mfill_atomic(s=
truct userfaultfd_ctx *ctx,
> > > > >        * If this is a HUGETLB vma, pass off to appropriate routin=
e
> > > > >        */
> > > > >       if (is_vm_hugetlb_page(dst_vma))
> > > > > -             return  mfill_atomic_hugetlb(ctx, dst_vma, dst_star=
t,
> > > > > -                                          src_start, len, flags)=
;
> > > > > +             return  mfill_atomic_hugetlb(ctx, dst_vma, dst_star=
t, src_start
> > > > > +                                          len, flags, &mmap_lock=
ed);
> > > > >
> > > > >       if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
> > > > >               goto out_unlock;
> > > > > @@ -699,7 +727,8 @@ static __always_inline ssize_t mfill_atomic(s=
truct userfaultfd_ctx *ctx,
> > > > >                       void *kaddr;
> > > > >
> > > > >                       up_read(&ctx->map_changing_lock);
> > > > > -                     mmap_read_unlock(dst_mm);
> > > > > +                     unpin_vma(dst_mm, dst_vma, &mmap_locked);
> > > > > +
> > > > >                       BUG_ON(!folio);
> > > > >
> > > > >                       kaddr =3D kmap_local_folio(folio, 0);
> > > > > @@ -730,7 +759,7 @@ static __always_inline ssize_t mfill_atomic(s=
truct userfaultfd_ctx *ctx,
> > > > >
> > > > >  out_unlock:
> > > > >       up_read(&ctx->map_changing_lock);
> > > > > -     mmap_read_unlock(dst_mm);
> > > > > +     unpin_vma(dst_mm, dst_vma, &mmap_locked);
> > > > >  out:
> > > > >       if (folio)
> > > > >               folio_put(folio);
> > > > > @@ -1285,8 +1314,6 @@ static int validate_move_areas(struct userf=
aultfd_ctx *ctx,
> > > > >   * @len: length of the virtual memory range
> > > > >   * @mode: flags from uffdio_move.mode
> > > > >   *
> > > > > - * Must be called with mmap_lock held for read.
> > > > > - *
> > > > >   * move_pages() remaps arbitrary anonymous pages atomically in z=
ero
> > > > >   * copy. It only works on non shared anonymous pages because tho=
se can
> > > > >   * be relocated without generating non linear anon_vmas in the r=
map
> > > > > @@ -1353,15 +1380,16 @@ static int validate_move_areas(struct use=
rfaultfd_ctx *ctx,
> > > > >   * could be obtained. This is the only additional complexity add=
ed to
> > > > >   * the rmap code to provide this anonymous page remapping functi=
onality.
> > > > >   */
> > > > > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct=
 *mm,
> > > > > -                unsigned long dst_start, unsigned long src_start=
,
> > > > > -                unsigned long len, __u64 mode)
> > > > > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long ds=
t_start,
> > > > > +                unsigned long src_start, unsigned long len, __u6=
4 mode)
> > > > >  {
> > > > > +     struct mm_struct *mm =3D ctx->mm;
> > > > >       struct vm_area_struct *src_vma, *dst_vma;
> > > > >       unsigned long src_addr, dst_addr;
> > > > >       pmd_t *src_pmd, *dst_pmd;
> > > > >       long err =3D -EINVAL;
> > > > >       ssize_t moved =3D 0;
> > > > > +     bool mmap_locked =3D false;
> > > > >
> > > > >       /* Sanitize the command parameters. */
> > > > >       if (WARN_ON_ONCE(src_start & ~PAGE_MASK) ||
> > > > > @@ -1374,28 +1402,52 @@ ssize_t move_pages(struct userfaultfd_ctx=
 *ctx, struct mm_struct *mm,
> > > > >           WARN_ON_ONCE(dst_start + len <=3D dst_start))
> > > > >               goto out;
> > > >
> > > > Ah, is this safe for rmap?  I think you need to leave this read loc=
k.
> > > >
> > I didn't fully understand you here.
>
> Sorry, I'm confused on how your locking scheme avoids rmap from trying
> to use the VMA with the atomic increment part.

I'm also a bit confused. Which atomic increment are you referring to?
AFAIU move_pages() will lock both src_vma and dst_vma, so even if rmap
finds them it can't modify them, no?

>
> > > > >
> > > > > +     dst_vma =3D NULL;
> > > > > +     src_vma =3D lock_vma_under_rcu(mm, src_start);
> > > > > +     if (src_vma) {
> > > > > +             dst_vma =3D lock_vma_under_rcu(mm, dst_start);
> > > > > +             if (!dst_vma)
> > > > > +                     vma_end_read(src_vma);
> > > > > +     }
> > > > > +
> > > > > +     /* If we failed to lock both VMAs, fall back to mmap_lock *=
/
> > > > > +     if (!dst_vma) {
> > > > > +             mmap_read_lock(mm);
> > > > > +             mmap_locked =3D true;
> > > > > +             src_vma =3D find_vma(mm, src_start);
> > > > > +             if (!src_vma)
> > > > > +                     goto out_unlock_mmap;
> > > > > +             dst_vma =3D find_vma(mm, dst_start);
> > > >
> > > > Again, there is a difference in how find_vma and lock_vam_under_rcu
> > > > works.
> >
> > Sure, I'll use vma_lookup() instead of find_vma().
>
> Be sure it fits with what you are doing, I'm not entire sure it's right
> to switch.  If it is not right then I don't think you can use
> lock_vma_under_rcu() - but we can work around that too.
>
> > > >
> > > > > +             if (!dst_vma)
> > > > > +                     goto out_unlock_mmap;
> > > > > +     }
> > > > > +
> > > > > +     /* Re-check after taking map_changing_lock */
> > > > > +     down_read(&ctx->map_changing_lock);
> > > > > +     if (likely(atomic_read(&ctx->mmap_changing))) {
> > > > > +             err =3D -EAGAIN;
> > > > > +             goto out_unlock;
> > > > > +     }
> > > > >       /*
> > > > >        * Make sure the vma is not shared, that the src and dst re=
map
> > > > >        * ranges are both valid and fully within a single existing
> > > > >        * vma.
> > > > >        */
> > > > > -     src_vma =3D find_vma(mm, src_start);
> > > > > -     if (!src_vma || (src_vma->vm_flags & VM_SHARED))
> > > > > -             goto out;
> > > > > +     if (src_vma->vm_flags & VM_SHARED)
> > > > > +             goto out_unlock;
> > > > >       if (src_start < src_vma->vm_start ||
> > > > >           src_start + len > src_vma->vm_end)
> > > > > -             goto out;
> > > > > +             goto out_unlock;
> > > > >
> > > > > -     dst_vma =3D find_vma(mm, dst_start);
> > > > > -     if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> > > > > -             goto out;
> > > > > +     if (dst_vma->vm_flags & VM_SHARED)
> > > > > +             goto out_unlock;
> > > > >       if (dst_start < dst_vma->vm_start ||
> > > > >           dst_start + len > dst_vma->vm_end)
> > > > > -             goto out;
> > > > > +             goto out_unlock;
> > > > >
> > > > >       err =3D validate_move_areas(ctx, src_vma, dst_vma);
> > > > >       if (err)
> > > > > -             goto out;
> > > > > +             goto out_unlock;
> > > > >
> > > > >       for (src_addr =3D src_start, dst_addr =3D dst_start;
> > > > >            src_addr < src_start + len;) {
> > > > > @@ -1512,6 +1564,15 @@ ssize_t move_pages(struct userfaultfd_ctx =
*ctx, struct mm_struct *mm,
> > > > >               moved +=3D step_size;
> > > > >       }
> > > > >
> > > > > +out_unlock:
> > > > > +     up_read(&ctx->map_changing_lock);
> > > > > +out_unlock_mmap:
> > > > > +     if (mmap_locked)
> > > > > +             mmap_read_unlock(mm);
> > > > > +     else {
> > > > > +             vma_end_read(dst_vma);
> > > > > +             vma_end_read(src_vma);
> > > > > +     }
> > > > >  out:
> > > > >       VM_WARN_ON(moved < 0);
> > > > >       VM_WARN_ON(err > 0);
> > > > > --
> > > > > 2.43.0.429.g432eaa2c6b-goog
> > > > >
> > > > >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

