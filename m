Return-Path: <linux-fsdevel+bounces-24914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCCF9468C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 11:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6581F21FCD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B248614D71A;
	Sat,  3 Aug 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6qKy9mU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50859D2EE;
	Sat,  3 Aug 2024 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722676178; cv=none; b=VRJHWygeHO+rSAsbM3TRsYC1DWOk4VMYH36XbLXcRtO+TkgKlVY4xhiqWvsV4sKrytraxLMaMICyyeT8FOdrozaFX3JYvtukbiuaoiInS1Q/mn9+vglsY5lEDUF10lcgg0G5lyaS1QfuOC33JEDjmg5KuDku6Me2xsLGeJh46HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722676178; c=relaxed/simple;
	bh=zyWocehT/wKGgDosvwz5xzrrcgF/SiBn2VbNMK7ip/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lldwP/+CrjOL9MeopFFP4n2Bn4ig/K5HDzBHG7Nm3vC48T//NGJSHK1NiFlKeT/fYphbymVrGxgrp/WkJ5QKjAtDf5Cuc1K/+pOeyjuYaxrfz+QbbZJk21dXfOCPJtAo0s/K9V4rpLglF01rI3YEQAF7lDaFr3hOSeAlvp5tyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6qKy9mU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso260447866b.0;
        Sat, 03 Aug 2024 02:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722676174; x=1723280974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa2Z089o7Gp9gL2lU5Xq5K8wM0rU6iF7IfuPszc9bls=;
        b=Z6qKy9mUQz8sPqcaxCNy/N34Hhxtf2+5XyrC24CKAy3Kn2L4bTDyFX9oXGFXweGcpu
         4TuIm+uE6GpGpS8E3aS3Md1UHvEtZmKQGxWkiy/fba6AqEH/QSJohRd25aAcMJJQUi9Z
         x+fBwvtLKVFA2QWUUhqmQQbIlYN82yaBpEW3xQFEkEF5BMG/ia2c4GG8LRD7RSzbZT+f
         g5e5Cv3aZpZ6cpgOoYH1FMGwvY7nErv61p7aZWBrUM7D9ecQ9D+n8/h6rcx8IZ5/SvI+
         Q3Y2UiYCusc5CAklh40JcMRZQPef9FmvLpCpn0cG0LbqSHqyoMasmsKpzHY4ZGusyLFe
         1Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722676174; x=1723280974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa2Z089o7Gp9gL2lU5Xq5K8wM0rU6iF7IfuPszc9bls=;
        b=R/cfBw9+9BOYrYebHY2124vWpV5QlvigMUwxLDy4sVxS4sYd+hgTeYU/LZEZvKc7J+
         +aTCjK4MEtfXNlx3ppp8g1KkU/YklTNwo3tfAgktMaSTWIxkGhl7Z06kaPEE0fCzwipL
         YaTLgTROa7UUVie3u4URc5yPqe9g/bAe+hzwX5qtET/iZJEhuqEVKggkhA+xHm+fNbDk
         cAU6/NxxYzEFqDU2uqBua9vG6M5y5va+K11Cicum8Ue8LjTAAeU12DSv5trp6FmHDS4X
         1dud2XrR4oQmWTDnfF4iHB8Ymm53LvPE7skbfSJEECiVdlDw8VeoWdsJfliOWc9HZtna
         GA6w==
X-Forwarded-Encrypted: i=1; AJvYcCUy6XlLxnL9eys9GS+/jjb3mCFvoqh6Ff3HdfwawCuJcYjvhZKQOzWIaSZh9rJEPej9XoYWbve1bbPMLTxL0MvJIs9YxVs6ErC8pwT5Udjg+csC9jb5hvC72/YMvdZKb2k0LBqziafYRqN/Ig==
X-Gm-Message-State: AOJu0Yzt/Lyr8KGOgf36HcfTT5M0Wn0d35gYRVHrRwhy21F14ja3ML3W
	WRDwNZYrn3yQYKqTIlmm8AzTSdLQQCNnDCTdb1c3ACt/TYWBViozLjf3sy8DG3OeD3XBfa60j9w
	0hfZApJw4pxv+UBKrxLhH9FAw3v0=
X-Google-Smtp-Source: AGHT+IGWrmf7/sVoU0Uvicm492einiT6KUI/gNEipSocgXtG/wApkju9NqLHFTKVF55fMzSP+pIWF7vchf3yd8BZslk=
X-Received: by 2002:a17:907:72c5:b0:a7a:929f:c0d6 with SMTP id
 a640c23a62f3a-a7dc508005bmr483027266b.38.1722676174214; Sat, 03 Aug 2024
 02:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
 <20240802-openfast-v1-3-a1cff2a33063@kernel.org> <r6gyrzb265f5w6sev6he3ctfjjh7wfhktzwxyylwwkeopkzkpj@fo3yp2lkgp7l>
In-Reply-To: <r6gyrzb265f5w6sev6he3ctfjjh7wfhktzwxyylwwkeopkzkpj@fo3yp2lkgp7l>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 3 Aug 2024 11:09:22 +0200
Message-ID: <CAGudoHHLcKoG6Y2Zzm34gLrtaXmtuMc=CPcVpVQUaJ1Ysz8EDQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] lockref: rework CMPXCHG_LOOP to handle contention better
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 6:44=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Fri, Aug 02, 2024 at 05:45:04PM -0400, Jeff Layton wrote:
> > In a later patch, we want to change the open(..., O_CREAT) codepath to
> > avoid taking the inode->i_rwsem for write when the dentry already exist=
s.
> > When we tested that initially, the performance devolved significantly
> > due to contention for the parent's d_lockref spinlock.
> >
> > There are two problems with lockrefs today: First, once any concurrent
> > task takes the spinlock, they all end up taking the spinlock, which is
> > much more costly than a single cmpxchg operation. The second problem is
> > that once any task fails to cmpxchg 100 times, it falls back to the
> > spinlock. The upshot there is that even moderate contention can cause a
> > fallback to serialized spinlocking, which worsens performance.
> >
> > This patch changes CMPXCHG_LOOP in 2 ways:
> >
> > First, change the loop to spin instead of falling back to a locked
> > codepath when the spinlock is held. Once the lock is released, allow th=
e
> > task to continue trying its cmpxchg loop as before instead of taking th=
e
> > lock. Second, don't allow the cmpxchg loop to give up after 100 retries=
.
> > Just continue infinitely.
> >
> > This greatly reduces contention on the lockref when there are large
> > numbers of concurrent increments and decrements occurring.
> >
>
> This was already tried by me and it unfortunately can reduce performance.
>

Oh wait I misread the patch based on what I tried there. Spinning
indefinitely waiting for the lock to be free is a no-go as it loses
the forward progress guarantee (and it is possible to get the lock
being continuously held). Only spinning up to an arbitrary point wins
some in some tests and loses in others.

Either way, as described below, chances are decent that:
1. there is an easy way to not lockref_get/put on the parent if the
file is already there, dodging the problem
.. and even if that's not true
2. lockref can be ditched in favor of atomics. apart from some minor
refactoring this all looks perfectly doable and I have a wip. I will
try to find the time next week to sort it out

> Key problem is that in some corner cases the lock can be continuously
> held and be queued on, making the fast path always fail and making all
> the spins actively waste time (and notably pull on the cacheline).
>
> See this for more details:
> https://lore.kernel.org/oe-lkp/lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfa=
qbkvv4ke@hzxat7utjnvx/
>
> However, I *suspect* in the case you are optimizing here (open + O_CREAT
> of an existing file) lockref on the parent can be avoided altogether
> with some hackery and that's what should be done here.
>
> When it comes to lockref in vfs in general, most uses can be elided with
> some hackery (see the above thread) which is in early WIP (the LSMs are
> a massive headache).
>
> For open calls which *do* need to take a real ref the hackery does not
> help of course.
>
> This is where I think decoupling ref from the lock is the best way
> forward. For that to work the dentry must hang around after the last
> unref (already done thanks to RCU and dput even explicitly handles that
> already!) and there needs to be a way to block new refs atomically --
> can be done with cmpxchg from a 0-ref state to a flag blocking new refs
> coming in. I have that as a WIP as well.
>
>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  lib/lockref.c | 85 ++++++++++++++++++++++-----------------------------=
--------
> >  1 file changed, 32 insertions(+), 53 deletions(-)
> >
> > diff --git a/lib/lockref.c b/lib/lockref.c
> > index 2afe4c5d8919..b76941043fe9 100644
> > --- a/lib/lockref.c
> > +++ b/lib/lockref.c
> > @@ -8,22 +8,25 @@
> >   * Note that the "cmpxchg()" reloads the "old" value for the
> >   * failure case.
> >   */
> > -#define CMPXCHG_LOOP(CODE, SUCCESS) do {                              =
       \
> > -     int retry =3D 100;                                               =
         \
> > -     struct lockref old;                                              =
       \
> > -     BUILD_BUG_ON(sizeof(old) !=3D 8);                                =
         \
> > -     old.lock_count =3D READ_ONCE(lockref->lock_count);               =
         \
> > -     while (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lock)))=
 {     \
> > -             struct lockref new =3D old;                              =
         \
> > -             CODE                                                     =
       \
> > -             if (likely(try_cmpxchg64_relaxed(&lockref->lock_count,   =
       \
> > -                                              &old.lock_count,        =
       \
> > -                                              new.lock_count))) {     =
       \
> > -                     SUCCESS;                                         =
       \
> > -             }                                                        =
       \
> > -             if (!--retry)                                            =
       \
> > -                     break;                                           =
       \
> > -     }                                                                =
       \
> > +#define CMPXCHG_LOOP(CODE, SUCCESS) do {                              =
               \
> > +     struct lockref old;                                              =
               \
> > +     BUILD_BUG_ON(sizeof(old) !=3D 8);                                =
                 \
> > +     old.lock_count =3D READ_ONCE(lockref->lock_count);               =
                 \
> > +     for (;;) {                                                       =
               \
> > +             struct lockref new =3D old;                              =
                 \
> > +                                                                      =
               \
> > +             if (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lo=
ck))) {        \
> > +                     CODE                                             =
               \
> > +                     if (likely(try_cmpxchg64_relaxed(&lockref->lock_c=
ount,          \
> > +                                                      &old.lock_count,=
               \
> > +                                                      new.lock_count))=
) {            \
> > +                             SUCCESS;                                 =
               \
> > +                     }                                                =
               \
> > +             } else {                                                 =
               \
> > +                     cpu_relax();                                     =
               \
> > +                     old.lock_count =3D READ_ONCE(lockref->lock_count)=
;                \
> > +             }                                                        =
               \
> > +     }                                                                =
               \
> >  } while (0)
> >
> >  #else
> > @@ -46,10 +49,8 @@ void lockref_get(struct lockref *lockref)
> >       ,
> >               return;
> >       );
> > -
> > -     spin_lock(&lockref->lock);
> > -     lockref->count++;
> > -     spin_unlock(&lockref->lock);
> > +     /* should never get here */
> > +     WARN_ON_ONCE(1);
> >  }
> >  EXPORT_SYMBOL(lockref_get);
> >
> > @@ -60,8 +61,6 @@ EXPORT_SYMBOL(lockref_get);
> >   */
> >  int lockref_get_not_zero(struct lockref *lockref)
> >  {
> > -     int retval;
> > -
> >       CMPXCHG_LOOP(
> >               new.count++;
> >               if (old.count <=3D 0)
> > @@ -69,15 +68,9 @@ int lockref_get_not_zero(struct lockref *lockref)
> >       ,
> >               return 1;
> >       );
> > -
> > -     spin_lock(&lockref->lock);
> > -     retval =3D 0;
> > -     if (lockref->count > 0) {
> > -             lockref->count++;
> > -             retval =3D 1;
> > -     }
> > -     spin_unlock(&lockref->lock);
> > -     return retval;
> > +     /* should never get here */
> > +     WARN_ON_ONCE(1);
> > +     return -1;
> >  }
> >  EXPORT_SYMBOL(lockref_get_not_zero);
> >
> > @@ -88,8 +81,6 @@ EXPORT_SYMBOL(lockref_get_not_zero);
> >   */
> >  int lockref_put_not_zero(struct lockref *lockref)
> >  {
> > -     int retval;
> > -
> >       CMPXCHG_LOOP(
> >               new.count--;
> >               if (old.count <=3D 1)
> > @@ -97,15 +88,9 @@ int lockref_put_not_zero(struct lockref *lockref)
> >       ,
> >               return 1;
> >       );
> > -
> > -     spin_lock(&lockref->lock);
> > -     retval =3D 0;
> > -     if (lockref->count > 1) {
> > -             lockref->count--;
> > -             retval =3D 1;
> > -     }
> > -     spin_unlock(&lockref->lock);
> > -     return retval;
> > +     /* should never get here */
> > +     WARN_ON_ONCE(1);
> > +     return -1;
> >  }
> >  EXPORT_SYMBOL(lockref_put_not_zero);
> >
> > @@ -125,6 +110,8 @@ int lockref_put_return(struct lockref *lockref)
> >       ,
> >               return new.count;
> >       );
> > +     /* should never get here */
> > +     WARN_ON_ONCE(1);
> >       return -1;
> >  }
> >  EXPORT_SYMBOL(lockref_put_return);
> > @@ -171,8 +158,6 @@ EXPORT_SYMBOL(lockref_mark_dead);
> >   */
> >  int lockref_get_not_dead(struct lockref *lockref)
> >  {
> > -     int retval;
> > -
> >       CMPXCHG_LOOP(
> >               new.count++;
> >               if (old.count < 0)
> > @@ -180,14 +165,8 @@ int lockref_get_not_dead(struct lockref *lockref)
> >       ,
> >               return 1;
> >       );
> > -
> > -     spin_lock(&lockref->lock);
> > -     retval =3D 0;
> > -     if (lockref->count >=3D 0) {
> > -             lockref->count++;
> > -             retval =3D 1;
> > -     }
> > -     spin_unlock(&lockref->lock);
> > -     return retval;
> > +     /* should never get here */
> > +     WARN_ON_ONCE(1);
> > +     return -1;
> >  }
> >  EXPORT_SYMBOL(lockref_get_not_dead);
> >
> > --
> > 2.45.2
> >



--=20
Mateusz Guzik <mjguzik gmail.com>

