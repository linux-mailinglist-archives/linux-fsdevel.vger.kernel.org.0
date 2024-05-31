Return-Path: <linux-fsdevel+bounces-20663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3A68D6703
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18761C240D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1AF171644;
	Fri, 31 May 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRtASc+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7725156242;
	Fri, 31 May 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173477; cv=none; b=SnnQsAOvKIqloKXGxQy3O7KUWuLTxWlqaw+0ZRKfeLX2h3nJwfZp6bohXjCFoifA6WyC2rVtVASnEn6R8LnVba43q3UQmhGLUC2sdmAZ91W6g0lIzszd1P1Me16jPMQyjhWUqwr+j0NckaqQQ32Ks0k/6hNF0icSWY2VUhx/4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173477; c=relaxed/simple;
	bh=4m0X1EqwFd+yuWmMO8eiV36fPx3yKbFp0wEvOBJDNAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LfwbJ2q0o4yBaB/bOmJjn4kB8xvKhd2VSAOCO4Wrb9i+Ifhsax10nDAgRc3TWxp9aXUtOtS0s+zjiojP+RSQKrEtDdiMcLJR+/PMT2H26z9SISfX8F3W8uN0phThYi/eboOqqP/zwKFoweYrCC4Dyxzm8Z/82GngnN6sA4+qsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRtASc+e; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-60585faa69fso1499456a12.1;
        Fri, 31 May 2024 09:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717173475; x=1717778275; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9OsVhc7MRu17ZxqE7Uec7qOOSBjzF0OYY1R4Nallcs=;
        b=JRtASc+ekw9uUCeLMdNPCZucYWLm7o7Q7yXfCjdUxcP6BQKsmubeRXXduUw6RZV0fa
         BesHRm4xIz03hdDeTXTF1hWwm00Lp2YEcqykPKx0PTqGJAG4YmRBaG2G/7Zuf25cCH71
         RTsa51MtMIV/8a/s7jpvr6mpay7/uq1TEcIH6n8BZXayna9ac2IM7w+bGRuclWMQK0RO
         jRz44c1O3wKpcUuN4cDDiJSIXOaEyIW1cJOJautsoQZHIydVELiFPtuH5RaGsrwy2xm+
         7swaXx2KqzscH6K35ypXP6wVDCM+YFY3CDVJTqPDD6DhkCLfGtCEIJKhrSI0Q8ivtNpo
         50pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717173475; x=1717778275;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9OsVhc7MRu17ZxqE7Uec7qOOSBjzF0OYY1R4Nallcs=;
        b=RgU15iq6fD1Tv3W+0OqL1zmCKbPBFHcOcnpikK7oCQ2AQuFxBAoWdJ1TjrXcTJbmWZ
         0tDxBy3F1JfWi4AHGWyqGL/SIhJVvs5stE5hYQ8oUIVsfGp8m55HIplQOPIHLR3gYxvd
         Fl8nQdTJ5g9OR4GR+/Omz/SoocgZMRSH1jg1wMIF7z9W0NRFgbZhvqNY+CpwSAGMAzVE
         zsq4dUK2RN7110ux2Nx63xIghIqQF2VGKwvYh9NZQbh9bF4SzFK5lldHNo4TdzHMk90g
         C0S+65I0yamfyKfiXndQH7hRkTYau4IFNMld+K+UiDHo6wKwb5rgynQI9NH8nPmG7T84
         lKqw==
X-Forwarded-Encrypted: i=1; AJvYcCWtSbUm0J9X6rggGqNFlu8x37s4Ab+9O4iTwT5YFIATOhVJNHNkyA9BDR2ENwTK8+Rp0+xS/0IOphiZcnCQp7pEgypAPB10wh9MKKn6MG1+9D4D5Qw1MtDlcFj0sMrozzSB5MTNRKkXASZnRjIQFujLrFszEOSp84qIMhB7PT6H1Q==
X-Gm-Message-State: AOJu0YxXsFrKOnA+XdBRq17ZEopEdzakGhz0pIDWDNOMPZaI0fNKPMij
	mL4QI7Au0TjF5Jh15IKhW3yTibLvLh7kfbAU3k5kjIHOPUWnEGmwIJzIEkoC7bNUdXoigmgBfZJ
	bMrbR6rtXd+25uf5ErvLSw4Mf5Fc=
X-Google-Smtp-Source: AGHT+IF7FL1AYCjP1BwUnG05McUJ4KkwiviRElNE88xHJCWG+NZK2inRtrMj/0pKr5HBygGg0ozDqiOuo4p2k7eRfYU=
X-Received: by 2002:a17:90a:3482:b0:2c0:19bd:543a with SMTP id
 98e67ed59e1d1-2c1c43ee447mr3657114a91.9.1717173474799; Fri, 31 May 2024
 09:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524041032.1048094-1-andrii@kernel.org> <20240524041032.1048094-5-andrii@kernel.org>
 <eciqv22jtpw6uveqih3jarjqulm5g3nxhlec5ytk2pltlltxnw@47agja2den2b>
 <CAEf4BzbphUBPnA7iDz5pis17GRwzpqsduftV_JHyf1Ce0MMqzw@mail.gmail.com> <gkhzuurhqhtozk6u53ufkesbhtjse5ba6kovqm7mnzrqe3szma@3tpbspq7hxjl>
In-Reply-To: <gkhzuurhqhtozk6u53ufkesbhtjse5ba6kovqm7mnzrqe3szma@3tpbspq7hxjl>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 May 2024 09:37:42 -0700
Message-ID: <CAEf4BzZPSVG685pFpBY3Ng1CyXKGTMBNcKNzAdBHYGg_xbEJtw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] fs/procfs: use per-VMA RCU-protected locking in
 PROCMAP_QUERY API
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, surenb@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 6:38=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Andrii Nakryiko <andrii.nakryiko@gmail.com> [240528 16:37]:
> > On Fri, May 24, 2024 at 12:48=E2=80=AFPM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Andrii Nakryiko <andrii@kernel.org> [240524 00:10]:
> > > > Attempt to use RCU-protected per-VAM lock when looking up requested=
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
> > >
> > > Thanks for doing this.
> > >
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  fs/proc/task_mmu.c | 42 ++++++++++++++++++++++++++++++++++--------
> > > >  1 file changed, 34 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index 8ad547efd38d..2b14d06d1def 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -389,12 +389,30 @@ static int pid_maps_open(struct inode *inode,=
 struct file *file)
> > > >  )
> > > >
> > > >  static struct vm_area_struct *query_matching_vma(struct mm_struct =
*mm,
> > > > -                                              unsigned long addr, =
u32 flags)
> > > > +                                              unsigned long addr, =
u32 flags,
> > > > +                                              bool *mm_locked)
> > > >  {
> > > >       struct vm_area_struct *vma;
> > > > +     bool mmap_locked;
> > > > +
> > > > +     *mm_locked =3D mmap_locked =3D false;
> > > >
> > > >  next_vma:
> > > > -     vma =3D find_vma(mm, addr);
> > > > +     if (!mmap_locked) {
> > > > +             /* if we haven't yet acquired mmap_lock, try to use l=
ess disruptive per-VMA */
> > > > +             vma =3D find_and_lock_vma_rcu(mm, addr);
> > > > +             if (IS_ERR(vma)) {
> > >
> > > There is a chance that find_and_lock_vma_rcu() will return NULL when
> > > there should never be a NULL.
> > >
> > > If you follow the MAP_FIXED call to mmap(), you'll land in map_region=
()
> > > which does two operations: munmap(), then the mmap().  Since this was
> > > behind a lock, it was fine.  Now that we're transitioning to rcu
> > > readers, it's less ideal.  We have a race where we will see that gap.
> > > In this implementation we may return NULL if the MAP_FIXED is at the =
end
> > > of the address space.
> > >
> > > It might also cause issues if we are searching for a specific address
> > > and we will skip a VMA that is currently being inserted by MAP_FIXED.
> > >
> > > The page fault handler doesn't have this issue as it looks for a
> > > specific address then falls back to the lock if one is not found.
> > >
> > > This problem needs to be fixed prior to shifting the existing proc ma=
ps
> > > file to using rcu read locks as well.  We have a solution that isn't
> > > upstream or on the ML, but is being tested and will go upstream.
> >
> > Ok, any ETA for that? Can it be retrofitted into
> > find_and_lock_vma_rcu() once the fix lands? It's not ideal, but I
> > think it's acceptable (for now) for this new API to have this race,
> > given it seems quite unlikely to be hit in practice.
> >
> > Worst case, we can leave the per-VMA RCU-protected bits out until we
> > have this solution in place, and then add it back when ready.
>
> I've sent the patches to Suren for testing on the /proc/<pid>/maps he is
> doing as he could recreate this issue, but I think he is busy with other
> things.  They are isolated to the mm changes so I can send you the same
> patches to include in this patch set.  This does increase the risk of
> issues with the patch set, so you can have a look and decide how you
> want to proceed.

Please do send them, without seeing them it's hard to make a judgement
call if it's ok to proceed without them. If the changes are
transparent to the rest of my changes in this patch set, of course I'd
prefer to keep it simpler and land them separately.

>
> >
> > >
> > > > +                     /* failed to take per-VMA lock, fallback to m=
map_lock */
> > > > +                     if (mmap_read_lock_killable(mm))
> > > > +                             return ERR_PTR(-EINTR);
> > > > +
> > > > +                     *mm_locked =3D mmap_locked =3D true;
> > > > +                     vma =3D find_vma(mm, addr);
> > >
> > > If you lock the vma here then drop the mmap lock, then you should be
> > > able to simplify the code by avoiding the passing of the mmap_locked
> > > variable around.
> > >
> > > It also means we don't need to do an unlokc_vma() call, which indicat=
es
> > > we are going to end the vma read but actually may be unlocking the mm=
.
> > >
> > > This is exactly why I think we need a common pattern and infrastructu=
re
> > > to do this sort of walking.
> > >
> > > Please have a look at userfaultfd patches here [1].  Note that
> > > vma_start_read() cannot be used in the mmap_read_lock() critical
> > > section.
> >
> > Ok, so you'd like me to do something like below, right?
> >
> > vma =3D find_vma(mm, addr);
> > if (vma)
> >     down_read(&vma->vm_lock->lock)
> > mmap_read_unlock(mm);
> >
> > ... and for the rest of logic always assume having per-VMA lock. ...
> >
> >
> > The problem here is that I think we can't assume per-VMA lock, because
> > it's gated by CONFIG_PER_VMA_LOCK, so I think we'll have to deal with
> > this mmap_locked flag either way. Or am I missing anything?
>
> The per-vma lock being used depends on the CONFIG_PER_VMA_LOCK, so that
> flag tells us which lock has been taken.
>
> >
> > I don't think the flag makes things that much worse, tbh, but I'm
> > happy to accommodate any better solution that would work regardless of
> > CONFIG_PER_VMA_LOCK.
> >
> > >
> > > > +             }
> > > > +     } else {
> > > > +             /* if we have mmap_lock, get through the search as fa=
st as possible */
> > > > +             vma =3D find_vma(mm, addr);
> > >
> > > I think the only way we get here is if we are contending on the mmap
> > > lock.  This is actually where we should try to avoid holding the lock=
?
> > >
> > > > +     }
> > > >
> > > >       /* no VMA found */
> > > >       if (!vma)
> > > > @@ -428,18 +446,25 @@ static struct vm_area_struct *query_matching_=
vma(struct mm_struct *mm,
> > > >  skip_vma:
> > > >       /*
> > > >        * If the user needs closest matching VMA, keep iterating.
> > > > +      * But before we proceed we might need to unlock current VMA.
> > > >        */
> > > >       addr =3D vma->vm_end;
> > > > +     if (!mmap_locked)
> > > > +             vma_end_read(vma);
> > > >       if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
> > > >               goto next_vma;
> > > >  no_vma:
> > > > -     mmap_read_unlock(mm);
> > > > +     if (mmap_locked)
> > > > +             mmap_read_unlock(mm);
> > > >       return ERR_PTR(-ENOENT);
> > > >  }
> > > >
> > > > -static void unlock_vma(struct vm_area_struct *vma)
> > > > +static void unlock_vma(struct vm_area_struct *vma, bool mm_locked)
> > >
> > > Confusing function name, since it may not be doing anything with the
> > > vma lock.
> >
> > Would "unlock_vma_or_mm()" be ok?
>
> The way that seemed most clear in the userfaultfd code
> (/mm/userfaultfd.c), seemed to focus on what we were undoing instead of
> the lock we were unlocking.  Instead of saying "unlock one or the other"
> we have "uffd_mfill_unlock()", and have two versions of that function
> that take the same argument.  This way we can have the same blocks of
> code calling the same thing, with a different lock/unlock happening
> based on the CONFIG_PER_VMA_LOCK compile time option.  If that makes
> sense to you, then I'd prefer it over the other options - none are
> ideal.

ok, two implementations of the same function sounds fine to me, I'll
do that in the next revision, thanks!

>
> Note that people didn't like the "unlock_" name, even on static
> functions as it implies it can be used everywhere and may conflict with
> a global function in the future [1].

yep, ack

>
> [1] https://lore.kernel.org/linux-mm/20240426144506.1290619-4-willy@infra=
dead.org/
>
> Thanks,
> Liam

