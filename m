Return-Path: <linux-fsdevel+bounces-21129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FAF8FF434
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 20:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7851C25EED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8496A19925A;
	Thu,  6 Jun 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czEBcjKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF812110E;
	Thu,  6 Jun 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697005; cv=none; b=mlM443nb9+/A6Sm80e6W6XnlNvYf6bKOq2nKD8o66MDx7w2pGBRK4QsJwn9Pco0FPSqxwFq33+gmg+HLsCsbboSE7/jIh+0UcSZ9k4+4xWSm5Vl4pDpIuYEdWvUVHBsFDcXq9NmiVIowSQgffyxqCb8pb4PSdqvESIEYaxUxpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697005; c=relaxed/simple;
	bh=RvaIQQXTisHcXUQyO/iTfw9Q3NKcwREbNLAtuYmjHxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNAdU4IjRiSWSIaup74q6QEvkUXtnaRIblJzVmaNF3KmuSU6ApXP6o8U3VsXk1zZXLbIUWXjLCMSgj6bntvAJk38UcxFJkckqaGFgdEOHwaIZDxgDgbyHfH/ehJuHkOG829v4iPAzU+npI6NOTzGrRwBIeXkv0+IrkinckeR/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czEBcjKT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c284095ea6so1111968a91.0;
        Thu, 06 Jun 2024 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717697003; x=1718301803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D642LaXYHltFUziB57voG7OLuiRYrwbp9evgeaa63eE=;
        b=czEBcjKTF6XP827uG32OvIHWulH/WcJlTSk+dZTOC7IzQrU4ifohP4DYTKOwmmIrDs
         8ihuuBgmT09K4v7wxe37+BRwJvS9sC0Z/htJsrLpmsLcoSRWSrqJ1e0drY+x92WMQKZW
         Dt9F+MQ7NHRn0Z+8nDguSauhAQMPLJtIv9ZC850qbn552vJbIF44H0qYr7GpoeBVW4Ht
         xbgYyS9BgsZslFKivQPxGoRAkqQ5XyDMJWlGCeUFPn0AbTTYDXRAbTL7DPXCARQCBVg1
         Dy1tzcXQ/EMa5oF64vPFZsX2jaLTW2l9QhBwXLyk2VTZq1/ub61A8W33xc1gf5IfAQZb
         IQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717697003; x=1718301803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D642LaXYHltFUziB57voG7OLuiRYrwbp9evgeaa63eE=;
        b=LPTradX5NkkLBa9aH0D61Z6tuToMQm2Ov0MHG6KOqFksriOxfHu2+OWbbOvKjKMWjf
         eSkL7t9VSCEyef+kFC6wYwazmVfF3ZavAZ3z3eescr8RC78scpj7tMDmjTSP1S8wOw28
         BZomiQL2grhbhNTXWO55iz92tPwwN9LcgNJdy48tr8CLbJsDkmP55yqjxTfTSala4YKJ
         AzNDMUaiINC8e47PXSGSLA5XEN/tprjscJKgBXU2ZLHTULslKD/vArHtt32C+5HfgklY
         jlAVRqF+6bqYb8Te6RHLh2o66rJkOMYB63N2R4v6GGwf09GnKDwt7LQg3a3c2B9bXdba
         yCaA==
X-Forwarded-Encrypted: i=1; AJvYcCWMbwq/41WhV1NrUl5T4QP2py2PRY/L7AasCi2WEChcOE7jBplW3/vo8qdn83/8OJ0HE5OvihPr7IHS8h4PYh8HHpW8McDslEd3DtaNz52ZAk493f7YlL9//TX/UrGVPracF6HsAHRUZq8nbBQftKgXQw50cinovCbYkpf/r9svSA==
X-Gm-Message-State: AOJu0YyvGdgchWhchaQW8kg3zNvJWoo9qanmqckwGZBuynUw7shf03sD
	Tl4d6F4Hj6TM+6TX3sNRO1XH4A0o1SxgXfphAsC8bk5y0guOG1Ao39orprBhdbTk2a79i+9hd6p
	4j+g1dj4RbPgXrn3arBcuXYLoiZ8=
X-Google-Smtp-Source: AGHT+IEdFmXNqU52VSDHeMcceD3GDuoJ/fU3V0V+QCiiKaqL658RtlSpMoscDJxCTnJiBX1QCuYykKwDDo83/qhYQrc=
X-Received: by 2002:a17:90a:5207:b0:2c2:1d0f:3c6e with SMTP id
 98e67ed59e1d1-2c2bcc6b446mr245234a91.37.1717697002522; Thu, 06 Jun 2024
 11:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605002459.4091285-1-andrii@kernel.org> <20240605002459.4091285-5-andrii@kernel.org>
 <CAJuCfpFp38X-tbiRAqS36zXG_ho2wyoRas0hCFLo07pN1noSmg@mail.gmail.com>
 <CAEf4BzYv0Ys+NpMMuXBYEVwAaOow=oBgUhBwen7g=68_5qKznQ@mail.gmail.com> <CAJuCfpG1vSHmdPFvZSryHd+5pMZayKL9AJwgw1syRSBHnW-WHQ@mail.gmail.com>
In-Reply-To: <CAJuCfpG1vSHmdPFvZSryHd+5pMZayKL9AJwgw1syRSBHnW-WHQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jun 2024 11:03:10 -0700
Message-ID: <CAEf4BzadsW2zs7NFrV66ndXryCgEauRRCQrjCwuD0gTy4tuZKw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] fs/procfs: use per-VMA RCU-protected locking in
 PROCMAP_QUERY API
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, liam.howlett@oracle.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 10:12=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Jun 6, 2024 at 9:52=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jun 5, 2024 at 4:16=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > >
> > > On Tue, Jun 4, 2024 at 5:25=E2=80=AFPM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > > >
> > > > Attempt to use RCU-protected per-VMA lock when looking up requested=
 VMA
> > > > as much as possible, only falling back to mmap_lock if per-VMA lock
> > > > failed. This is done so that querying of VMAs doesn't interfere wit=
h
> > > > other critical tasks, like page fault handling.
> > > >
> > > > This has been suggested by mm folks, and we make use of a newly add=
ed
> > > > internal API that works like find_vma(), but tries to use per-VMA l=
ock.
> > > >
> > > > We have two sets of setup/query/teardown helper functions with diff=
erent
> > > > implementations depending on availability of per-VMA lock (conditio=
ned
> > > > on CONFIG_PER_VMA_LOCK) to abstract per-VMA lock subtleties.
> > > >
> > > > When per-VMA lock is available, lookup is done under RCU, attemptin=
g to
> > > > take a per-VMA lock. If that fails, we fallback to mmap_lock, but t=
hen
> > > > proceed to unconditionally grab per-VMA lock again, dropping mmap_l=
ock
> > > > immediately. In this configuration mmap_lock is never helf for long=
,
> > > > minimizing disruptions while querying.
> > > >
> > > > When per-VMA lock is compiled out, we take mmap_lock once, query VM=
As
> > > > using find_vma() API, and then unlock mmap_lock at the very end onc=
e as
> > > > well. In this setup we avoid locking/unlocking mmap_lock on every l=
ooked
> > > > up VMA (depending on query parameters we might need to iterate a fe=
w of
> > > > them).
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  fs/proc/task_mmu.c | 46 ++++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 46 insertions(+)
> > > >
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index 614fbe5d0667..140032ffc551 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -388,6 +388,49 @@ static int pid_maps_open(struct inode *inode, =
struct file *file)
> > > >                 PROCMAP_QUERY_VMA_FLAGS                         \
> > > >  )
> > > >
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +static int query_vma_setup(struct mm_struct *mm)
> > > > +{
> > > > +       /* in the presence of per-VMA lock we don't need any setup/=
teardown */
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static void query_vma_teardown(struct mm_struct *mm, struct vm_are=
a_struct *vma)
> > > > +{
> > > > +       /* in the presence of per-VMA lock we need to unlock vma, i=
f present */
> > > > +       if (vma)
> > > > +               vma_end_read(vma);
> > > > +}
> > > > +
> > > > +static struct vm_area_struct *query_vma_find_by_addr(struct mm_str=
uct *mm, unsigned long addr)
> > > > +{
> > > > +       struct vm_area_struct *vma;
> > > > +
> > > > +       /* try to use less disruptive per-VMA lock */
> > > > +       vma =3D find_and_lock_vma_rcu(mm, addr);
> > > > +       if (IS_ERR(vma)) {
> > > > +               /* failed to take per-VMA lock, fallback to mmap_lo=
ck */
> > > > +               if (mmap_read_lock_killable(mm))
> > > > +                       return ERR_PTR(-EINTR);
> > > > +
> > > > +               vma =3D find_vma(mm, addr);
> > > > +               if (vma) {
> > > > +                       /*
> > > > +                        * We cannot use vma_start_read() as it may=
 fail due to
> > > > +                        * false locked (see comment in vma_start_r=
ead()). We
> > > > +                        * can avoid that by directly locking vm_lo=
ck under
> > > > +                        * mmap_lock, which guarantees that nobody =
can lock the
> > > > +                        * vma for write (vma_start_write()) under =
us.
> > > > +                        */
> > > > +                       down_read(&vma->vm_lock->lock);
> > >
> > > Hi Andrii,
> > > The above pattern of locking VMA under mmap_lock and then dropping
> > > mmap_lock is becoming more common. Matthew had an RFC proposal for an
> > > API to do this here:
> > > https://lore.kernel.org/all/ZivhG0yrbpFqORDw@casper.infradead.org/. I=
t
> > > might be worth reviving that discussion.
> >
> > Sure, it would be nice to have generic and blessed primitives to use
> > here. But the good news is that once this is all figured out by you mm
> > folks, it should be easy to make use of those primitives here, right?
> >
> > >
> > > > +               }
> > > > +
> > > > +               mmap_read_unlock(mm);
> > >
> > > Later on in your code you are calling get_vma_name() which might call
> > > anon_vma_name() to retrieve user-defined VMA name. After this patch
> > > this operation will be done without holding mmap_lock, however per
> > > https://elixir.bootlin.com/linux/latest/source/include/linux/mm_types=
.h#L582
> > > this function has to be called with mmap_lock held for read. Indeed
> > > with debug flags enabled you should hit this assertion:
> > > https://elixir.bootlin.com/linux/latest/source/mm/madvise.c#L96.
> >
> > Sigh... Ok, what's the suggestion then? Should it be some variant of
> > mmap_assert_locked() || vma_assert_locked() logic, or it's not so
> > simple?
> >
> > Maybe I should just drop the CONFIG_PER_VMA_LOCK changes for now until
> > all these gotchas are figured out for /proc/<pid>/maps anyway, and
> > then we can adapt both text-based and ioctl-based /proc/<pid>/maps
> > APIs on top of whatever the final approach will end up being the right
> > one?
> >
> > Liam, any objections to this? The whole point of this patch set is to
> > add a new API, not all the CONFIG_PER_VMA_LOCK gotchas. My
> > implementation is structured in a way that should be easily amenable
> > to CONFIG_PER_VMA_LOCK changes, but if there are a few more subtle
> > things that need to be figured for existing text-based
> > /proc/<pid>/maps anyways, I think it would be best to use mmap_lock
> > for now for this new API, and then adopt the same final
> > CONFIG_PER_VMA_LOCK-aware solution.
>
> I agree that you should start simple, using mmap_lock first and then
> work on improvements. Would the proposed solution become useless with
> coarse mmap_lock'ing?

Sorry, it's not clear what you mean by "proposed solution"? If you
mean this new ioctl-based API, no it's still very useful and fast even
if we take mmap_lock.

But if you mean vm_lock, then I'd say that due to anon_vma_name()
complication it makes vm_lock not attractive anymore, because vma_name
will be requested pretty much always. And if we need to take mmap_lock
anyways, then what's the point of per-VMA lock, right?

I'd like to be a good citizen here and help you guys not add new
mmap_lock users (and adopt per-VMA lock more widely), but I'm not sure
I can solve the anon_vma_name() conundrum, unfortunately.

Ultimately, I do care the most about having this new API available for
my customers to take advantage of, of course.

>
> >
> > >
> > > > +       }
> > > > +
> > > > +       return vma;
> > > > +}
> > > > +#else
> > > >  static int query_vma_setup(struct mm_struct *mm)
> > > >  {
> > > >         return mmap_read_lock_killable(mm);
> > > > @@ -402,6 +445,7 @@ static struct vm_area_struct *query_vma_find_by=
_addr(struct mm_struct *mm, unsig
> > > >  {
> > > >         return find_vma(mm, addr);
> > > >  }
> > > > +#endif
> > > >
> > > >  static struct vm_area_struct *query_matching_vma(struct mm_struct =
*mm,
> > > >                                                  unsigned long addr=
, u32 flags)
> > > > @@ -441,8 +485,10 @@ static struct vm_area_struct *query_matching_v=
ma(struct mm_struct *mm,
> > > >  skip_vma:
> > > >         /*
> > > >          * If the user needs closest matching VMA, keep iterating.
> > > > +        * But before we proceed we might need to unlock current VM=
A.
> > > >          */
> > > >         addr =3D vma->vm_end;
> > > > +       vma_end_read(vma); /* no-op under !CONFIG_PER_VMA_LOCK */
> > > >         if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
> > > >                 goto next_vma;
> > > >  no_vma:
> > > > --
> > > > 2.43.0
> > > >

