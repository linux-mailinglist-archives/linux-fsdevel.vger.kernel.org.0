Return-Path: <linux-fsdevel+bounces-11176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3FD851C74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 19:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30331C216CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985FE3FB1E;
	Mon, 12 Feb 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mi32PsGl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351923F8F7
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761310; cv=none; b=uKUc6/cngD7Wa2Xv++UC8arZA78Ti53C5hTJAImR/v43pHc0/UfC/EvYy8vmV8L73a7lCNy6bnrScu3glxsNyWU2exQIvyLIl0Upp8KCcR7Vo1S6Ul7/s72rr/fLhGsyZYqEyzdr5964l36SPG9b3Pzr7fi1iWr2qpPpORa1f/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761310; c=relaxed/simple;
	bh=Zpcn+sDldZR5gKoU79I02xWs3jCCZubXGm7z7r3eaUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eKktPP1YdDfda1QXwuvFK56rKI9thiNW4b8hXRywLn6yg8cLWnTj4ED3XFpNk34gvVG5NNUt3yG4ccfWtNNqiycspIBLS1UiLNLosB2zi3WKQxR/mNhyKYhFtk7Zkb/y5xGoHFAFmvqouFHxDgxgnI1jhHBOY/rNubtOrwW/nRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mi32PsGl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-411a5a8653aso4096875e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 10:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707761306; x=1708366106; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8eG2vfx+alRR2jEJWaH33x2v1+Lh70lXZyOGEZrheI=;
        b=mi32PsGlI3/DSlWlmJqfGoDOVMyWpsS9af+/TlX7jqaL5/ZOuV7sch1adhYVB1eDJT
         YLUJOkko4+OCgnvTyKx2XAlrLzIjU400IOA+jgupVaED6h1UWuMKDMNGrGwgP+gsrTJz
         YmsUHSNsdFg1a6/5pec0djvCB3nW4AkctRH4agcxTCkfBodaHRBvtd9g8yKRc9ZTMwis
         0tNcGhNn2i1GD060TNrTwygfdmI5hTGERIM7kTFlx5Dwjf2nCAg4iTAX07d396k1+SGT
         ALhrTSp2TnxyiXNeHqbcjjAL1w1FnFtwF2qV4fgQrCDz2Z8YxPVh8x/rYwv0ZgSaCgdP
         5Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707761306; x=1708366106;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8eG2vfx+alRR2jEJWaH33x2v1+Lh70lXZyOGEZrheI=;
        b=Jqw0J/DrFBT1LIcuuu+fAy9DKSgjGVNiN02wY6wMY62U202I0hdWjHB3YaNua4YZVr
         1EBOxDuiGh3Laong/cGiIeGMfxypKvVrSyUJ7sc811eRCssvgackdUCkxFkf6CXpF98a
         o52Rpdb0Bk5LXrUf1j5JGjkF0GsJ9tILArYfil35/V8K5YA3fi+Dr7iA3Uz4rdJ8tzLw
         kC1DmM270jSOA/zAjmc4YDhikRJyPn/XaSJKGtpWTU4e8kK4FJb7haL9GVrnk6Esp0R+
         jh2CZbRXenHAStH6iPgIczWXGrGJzHmK6gk0ifUhsR4xfedohgaTNTVQX1jklQqnRkfL
         HUQA==
X-Gm-Message-State: AOJu0YyGiw4m5ZPt9ssa/9D26Vwb27T++Yk58DI0U0z6LSpYfWCSQPuZ
	VRkws0V2++PhkDoL0eg37XDUrqXHlUieoIp/++jldbH4FYllitHFSHiqjzGnotFj8ppQm/n29eM
	vl5fmxNW+GdkScWYQ7klcrs1fyikQNdb6kziM
X-Google-Smtp-Source: AGHT+IGvSi87FXWNJLShT2MHSY/26nRA1F0T3W3Z1QBasH8tQNph0vir2QtvDBXT/NWKQhu2BqbqDAPSLJ4Fg4qtFQM=
X-Received: by 2002:adf:cd8d:0:b0:33b:66bf:769d with SMTP id
 q13-20020adfcd8d000000b0033b66bf769dmr5366876wrj.61.1707761306190; Mon, 12
 Feb 2024 10:08:26 -0800 (PST)
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
 <20240209193110.ltfdc6nolpoa2ccv@revolver> <CA+EESO4mbS_zB6AutaGZz1Jdx1uLFy5JqhyjnDHND4tY=3bn7Q@mail.gmail.com>
 <20240212151959.vnpqzvpvztabxpiv@revolver>
In-Reply-To: <20240212151959.vnpqzvpvztabxpiv@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Mon, 12 Feb 2024 10:08:13 -0800
Message-ID: <CA+EESO706V0OuX4pmX87t4YqrOxa9cLVXhhTPkFh22wLbVDD8Q@mail.gmail.com>
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

On Mon, Feb 12, 2024 at 7:20=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240209 15:59]:
> > On Fri, Feb 9, 2024 at 11:31=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> ...
>
> > > > > > > > +static struct vm_area_struct *lock_vma(struct mm_struct *m=
m,
> > > > > > > > +                                    unsigned long address,
> > > > > > > > +                                    bool prepare_anon)
> > > > > > > > +{
> > > > > > > > +     struct vm_area_struct *vma;
> > > > > > > > +
> > > > > > > > +     vma =3D lock_vma_under_rcu(mm, address);
> > > > > > > > +     if (vma) {
> > > > > > > > +             /*
> > > > > > > > +              * lock_vma_under_rcu() only checks anon_vma =
for private
> > > > > > > > +              * anonymous mappings. But we need to ensure =
it is assigned in
> > > > > > > > +              * private file-backed vmas as well.
> > > > > > > > +              */
> > > > > > > > +             if (prepare_anon && !(vma->vm_flags & VM_SHAR=
ED) &&
> > > > > > > > +                 !vma->anon_vma)
> > > > > > > > +                     vma_end_read(vma);
> > > > > > > > +             else
> > > > > > > > +                     return vma;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     mmap_read_lock(mm);
> > > > > > > > +     vma =3D vma_lookup(mm, address);
> > > > > > > > +     if (vma) {
> > > > > > > > +             if (prepare_anon && !(vma->vm_flags & VM_SHAR=
ED) &&
> > > > > > > > +                 anon_vma_prepare(vma)) {
> > > > > > > > +                     vma =3D ERR_PTR(-ENOMEM);
> > > > > > > > +             } else {
> > > > > > > > +                     /*
> > > > > > > > +                      * We cannot use vma_start_read() as =
it may fail due to
> > > > > > > > +                      * false locked (see comment in vma_s=
tart_read()). We
> > > > > > > > +                      * can avoid that by directly locking=
 vm_lock under
> > > > > > > > +                      * mmap_lock, which guarantees that n=
obody can lock the
> > > > > > > > +                      * vma for write (vma_start_write()) =
under us.
> > > > > > > > +                      */
> > > > > > > > +                     down_read(&vma->vm_lock->lock);
> > > > > > > > +             }
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     mmap_read_unlock(mm);
> > > > > > > > +     return vma;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void unlock_vma(struct vm_area_struct *vma)
> > > > > > > > +{
> > > > > > > > +     vma_end_read(vma);
> > > > > > > > +}
> > > > > > > > +
> ...
>
> >
> > The current implementation has a deadlock problem:
> >
> > thread 1
> >                                      thread 2
> >
> > vma_start_read(dst_vma)
> >
> >
> >                                          mmap_write_lock()
> >
> >                                          vma_start_write(src_vma)
> > vma_start_read(src_vma) fails
> > mmap_read_lock() blocks
> >
> >
> >                                         vma_start_write(dst_vma)
> > blocks
> >
> >
> > I think the solution is to implement it this way:
> >
> > long find_and_lock_vmas(...)
> > {
> >               dst_vma =3D lock_vma(mm, dst_start, true);
> >               if (IS_ERR(dst_vma))
> >                           return PTR_ERR(vma);
> >
> >               src_vma =3D lock_vma_under_rcu(mm, src_start);
> >               if (!src_vma) {
> >                             long err;
> >                             if (mmap_read_trylock(mm)) {
> >                                             src_vma =3D vma_lookup(mm, =
src_start);
> >                                             if (src_vma) {
> >
> > down_read(&src_vma->vm_lock->lock);
> >                                                         err =3D 0;
> >                                             } else {
> >                                                        err =3D -ENOENT;
> >                                             }
> >                                             mmap_read_unlock(mm);
> >                                } else {
> >                                            vma_end_read(dst_vma);
> >                                            err =3D lock_mm_and_find_vma=
s(...);
> >                                            if (!err) {
>
> Right now lock_mm_and_find_vmas() doesn't use the per-vma locking, so
> you'd have to lock those here too.  I'm sure you realise that, but this
> is very convoluted.

That's right. I realized that after I sent this email.
>
> >                                                          mmap_read_unlo=
ck(mm);
> >                                            }
> >                                 }
> >                                 return err;
>
> On contention you will now abort vs block.

Is it? On contention mmap_read_trylock() will fail and we do the whole
operation using lock_mm_and_find_vmas() which blocks on mmap_lock. Am
I missing something?
>
> >               }
> >               return 0;
> > }
> >
> > Of course this would need defining lock_mm_and_find_vmas() regardless
> > of CONFIG_PER_VMA_LOCK. I can also remove the prepare_anon condition
> > in lock_vma().
>
> You are adding a lot of complexity for a relatively rare case, which is
> probably not worth optimising.
>
> I think you'd be better served by something like :
>
> if (likely(src_vma))
>         return 0;
>
> /* Undo any locking */
> vma_end_read(dst_vma);
>
> /* Fall back to locking both in mmap_lock critical section */

Agreed on reduced complexity. But as Suren pointed out in one of his
replies that lock_vma_under_rcu() may fail due to seq overflow. That's
why lock_vma() uses vma_lookup() followed by direct down_read() on
vma-lock. IMHO what we need here is exactly lock_mm_and_find_vmas()
and the code can be further simplified as follows:

err =3D lock_mm_and_find_vmas(...);
if (!err) {
          down_read(dst_vma...);
          if (dst_vma !=3D src_vma)
                       down_read(src_vma....);
          mmap_read_unlock(mm);
}
return err;

(another thing I'm fixing in the next version is avoiding locking the
vma twice if both src_start and dst_start are in same vma)

> mmap_read_lock();
> /*
>  * probably worth creating an inline function for a single vma
>  * find/populate that can be used in lock_vma() that does the anon vma
>  * population?
>  */
Good idea. This can simplify both lock_vma() as well as lock_mm_and_find_vm=
as().

> dst_vm =3D lock_vma_populate_anon();
> ...
>
> src_vma =3D lock_vma_under_rcu(mm, src_start);
> ...
>
>
> mmap_read_unlock();
> return 0;
>
> src_failed:
>         vma_end_read(dst_vma);
> dst_failed:
> mmap_read_unlock();
> return err;
>
> Thanks,
> Liam
>
> ...
>

