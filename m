Return-Path: <linux-fsdevel+bounces-21131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC648FF459
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 20:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CD81F24F7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38AD1FAA;
	Thu,  6 Jun 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqaQu1Bw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9422619924E;
	Thu,  6 Jun 2024 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697385; cv=none; b=idwEHTCoBfEHJh/kwVgpY89+gVfFNxIA/hHFS9EY9gwUXyRDvMl1EnNuOLuFg6AsWH/VVDp3L1GZ0BRNXApu28IKs4Yo97ap0BdY9aDBa6mew/Arq+BPv0uAAN+zLKloJeQdgBed3DB9zLqJrsmz8TEYUbeEUVjMiJ0iMP7gdj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697385; c=relaxed/simple;
	bh=wtSfRCp4XoOtqSU/r2nCisszzCUK5dk8CscPsz5DTE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=q4wMC6ar3GrckbSwiUSSsEK3dyCMFcMEPzW6qA3N0a+7lLH6Oz+hnR0f4fY49Y6kilDgHeWcoLyzTvFKoMXiPh+pUfujBv6tZCWpqM3NZqMBo7caNpLfaiosEhnK3zlRK6oVCe2LK1tDw2f3AVG7q/npjE6oR31mGBErg5sx9AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqaQu1Bw; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c1a5913777so1069009a91.2;
        Thu, 06 Jun 2024 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717697383; x=1718302183; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5OklrM6JwTm3HO8tSX1yK0hEi0xNRql5wG9ok44Rvg=;
        b=ZqaQu1Bwhr773eo/v0OHpAKMPjzNjs4jwmO06/R3NjNk87AaW4epmK9kD67ML5Takg
         TVFODCYMui2fAEXHjfW4lQK41klbxdJoQi29HZbvAV+/lBs0DdRW2T+gIDqPPEvkTGCl
         sRVZVJ6OLtv6fEsmNCiYWwJwWTi8/PG+wCGQDFB+iwMubI1djoF0A/2OmjPu2z6dgRI5
         69Dy32jHzF1cD772H2NxgtvhPbP1tW0gA64gWTmN0y0plhvfU45rmJCJ+b25K3G/+ot0
         emB6sWIE8oV1UB2amFSwpk4RCsUPDmzZwC3Y+6TDOfEaVORnYh2YeMpyX/csBknCFHjd
         9RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717697383; x=1718302183;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5OklrM6JwTm3HO8tSX1yK0hEi0xNRql5wG9ok44Rvg=;
        b=pRrO2oEWs0izYx5GTDUPUmUgapALsinJTV4bT7kyO9efUzjr6GfNdJYg1+2bytTHU6
         K6UUji+U1HMoHlYOwHdbe4yK9fTAdxqjFunaKtqucbhwM3NqIIKyEGTZMbObbutVuA4l
         bsHFjDCGcN06oZfH/C9nGxjvwRksmy922D7Iu3SfUVqpUY6yWASuApWdVXoAYiWLf6Xf
         u7sNOhoNxh8AAkwZ1nhDQuBrYztmsX5/S3o3VVOQt3Ml+mr2Czt9pMLNb1f9vu/xO26u
         9il4VgAHh5z8CmWfkigSc3199og5407vhufUY6HMHjOduRnFUV+8m/A4LbMsPINvej94
         fRNA==
X-Forwarded-Encrypted: i=1; AJvYcCVMGLshzLsfAq+VKU3708LV8s59xGyvDpsW5oAd+kdFUEI8+4gYFdZmZIhxFdB0d09Y4zzXqzlUu4GUyPsHsXSR3fI/kqwWKHEEgAXBzE8+cq5yYfdUr3NZfJ4zqs6gxenIJ2B/o7k6bHXpS17G8mfV3LNe2jptMsfDihKmD8P4BA==
X-Gm-Message-State: AOJu0Yymwu8AxVqK7CZnKSPokzu+0/nmwln49A519S4D/Bo7Aejpu4fu
	n8myQu03yGambd8v/GyE9S4ehMjT8CpsRrQGKsB0kAQOCizctCBmPWxl0P4VY4vP+ofoSHjo0+u
	vtans0E9ChZtIJiSncGda6uYdEcg=
X-Google-Smtp-Source: AGHT+IE2vgamaVfO416HSacKOgFDRZp6Of3eAzhvkx6J5QoVRXuCcj8K++0BpcHhbM0bVu33tOq4JFowQg2f8/r9/fQ=
X-Received: by 2002:a17:90b:1013:b0:2bf:9ed7:a79b with SMTP id
 98e67ed59e1d1-2c2bcada703mr290487a91.19.1717697382797; Thu, 06 Jun 2024
 11:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605002459.4091285-1-andrii@kernel.org> <20240605002459.4091285-5-andrii@kernel.org>
 <CAJuCfpFp38X-tbiRAqS36zXG_ho2wyoRas0hCFLo07pN1noSmg@mail.gmail.com>
 <CAEf4BzYv0Ys+NpMMuXBYEVwAaOow=oBgUhBwen7g=68_5qKznQ@mail.gmail.com> <ue44yftirugr6u4ewl5cvgatpqnheuho7rgax3jyg6ox5vruyq@7k6harvobd2q>
In-Reply-To: <ue44yftirugr6u4ewl5cvgatpqnheuho7rgax3jyg6ox5vruyq@7k6harvobd2q>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jun 2024 11:09:30 -0700
Message-ID: <CAEf4Bzaac0Di+mCfrxRVsZT0sfWWoOJi6ByW0XA5YEh1h7dwuw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] fs/procfs: use per-VMA RCU-protected locking in
 PROCMAP_QUERY API
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 10:15=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Andrii Nakryiko <andrii.nakryiko@gmail.com> [240606 12:52]:
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
>
> The documentation on the first link says to hold the lock or take a
> reference, but then we assert the lock.  If you take a reference to the
> anon vma name, then we will trigger the assert.  Either the
> documentation needs changing or the assert is incorrect - or I'm missing
> something?
>
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
> The reason I was hoping to have the new interface use the per-vma
> locking from the start is to ensure the guarantees that we provide to
> the users would not change.  We'd also avoid shifting to yet another
> mmap_lock users.
>

Yep, it's completely understandable. And you see that I changed the
structure quite a lot to abstract away mmap_lock vs vm_lock details.
I'm afraid anon_vma_name() is quite an obstacle, unfortunately, and
seems like it should be addressed first, but I'm just not qualified
enough to do this.

> I also didn't think it would complicate your series too much, so I
> understand why you want to revert to the old locking semantics.  I'm
> fine with you continuing with the series on the old lock.  Thanks for
> trying to make this work.
>

I'm happy to keep the existing structure of the code, and
(intentionally) all the CONFIG_PER_VMA_LOCK logic is in separate
patches, so it's easy to do. I'd love to help adopt a per-VMA lock
once all the pieces are figured out. Hopefully anon_vma_name() is the
last one remaining :) So please keep me cc'ed on relevant patches.

As I mentioned, I just don't feel like I would be able to solve the
anon_vma_name() problem, but of course I wouldn't want to be
completely blocked by it as well.

> Regards,
> Liam

