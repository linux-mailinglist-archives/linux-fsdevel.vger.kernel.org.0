Return-Path: <linux-fsdevel+bounces-21117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F2F8FF2F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D1228F998
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 16:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564A198E99;
	Thu,  6 Jun 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBm6QRjF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9AC43ACB;
	Thu,  6 Jun 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692717; cv=none; b=YHJW0LXu2T5zn1K+ejWr7bmBjnTCB1v+UMlMTBGyG4TU7MQVIJNWxyUKFMTXMy4UYmikXL5ponal6ue1bbIf/Zyju+ic27/CxZz3CbW/oRE3xM2I7hMESiZgR1bWxbfNJmOs30KqPszNGbkfvq3FBe1xgShL+BAkKgb1tKrCZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692717; c=relaxed/simple;
	bh=ATGThuu+pF7blY+n42lON5C+U/eiOI1dhQFtkGRBpWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/0+fk3oVO9smxm/i8KbsEzUXDZmFf7Ot4A74B7aVssjQOdWxd2sbRibQZpyrIKVMubPG6Z/mD9dlyKs3BZs117vTIQ6YpMOjWLqFCGQMFeA8td/JQh+fh5ffStn5/md1OceoPSRLaRq3hNjG0Gf+oZdmv74rGZBvFCVj3+rO/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBm6QRjF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7024cd9dd3dso978166b3a.3;
        Thu, 06 Jun 2024 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717692715; x=1718297515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRcNGWjjh7UdvSzMfC+vxv6k260+2UboBQ1hJWD5TG8=;
        b=TBm6QRjFlFCjxnZQ0YYoDb45cW0xaChBqtibpAslIzzcDN3pfK1KGEhG6bHK/nFGDt
         KosZ5n8c/7rXj3iYFOvcosiEk3AtTqpk1Cx3BHKkBUx7+ZhU+loc74IV3L4iwiIWsnKl
         3nKPNfcRGuS5up3akT8chiI7xlLGisCM3xmiPMxZoEmR2L9xJq/7vpy6jlp7Ms5fG4mZ
         ug6EkjWMTiQ+hphohn5BIYLpXpImeuZVWfIlCOUfQVZa5nHDbgaBSW+6jSWThakeTG2H
         00EeGE6/uhhF+LIcAXKjb+6NgaffQsAgGzTJKEbH7jBwlyGGGkgjjbe45Y0UN8JJk1MA
         1Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692715; x=1718297515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRcNGWjjh7UdvSzMfC+vxv6k260+2UboBQ1hJWD5TG8=;
        b=uPkL9flgTOfyZn+TFGtDotfUTLsyKWfdN6BYA/QvE7B+iejqo0PCv/X+x2tFTDyjq6
         8iMvzC95961Emd6N3nJYU0xRJ9Kc83lCzgpL3NeUEj79oPkEyALaJIKl9JPmgcMwBLwG
         Oc2tqObG3oQtGBD27Gy3xWWK2/C4mKF+554IJkHNGqb7nTzfqIogHSGxlpxUk+tUd0fV
         +C1LcgY67w8NuEA8zBR42QSOztF9l0GJJzND1KXOXjyY5bQpkgK7l4CgNANb9kAfL3sH
         yRwhWdO+5j7UkIwdMvADiCZ/R/3x1dtEe3GqBCdxtDNkpoyZ7tvtU6rwW6A1n4hdckpH
         fH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHgqVblmXn7xH0eEvjGGrg0FZNjUn19DtTJT5tbAQtUjOqmrZHobp/FvLtTqWjKTckbCguB6MueTeXGVezEjFLzXReKWaRZ99SfmAc3iQXJ5Y9m3Lzaqe8q7J+WETDA3ro8frtFm/jBsjV0LGkPr57y3hPtxinuAvNtkMWH3ufgg==
X-Gm-Message-State: AOJu0YwJA3uT0dJWEqlAMzFXrB8PQLZJGxL+yJ7IMQ7yxOQBpEoBomEJ
	bqDUTvflHiY/EldKu1Q2PiedF5wnjxFVXArERDezD+1ob7mpM9gRnGBG2A6hbO8b3PGkGp6Wmdm
	YBFejP+SB8THZkExKh8qsQofxLPU=
X-Google-Smtp-Source: AGHT+IG+iriY1C6m2KcPqevYlxmvmTV9onEU6KUKB7+3t3oIqLC1nn1err2v+gcspD5d//2VeMoAebazpM8D9YLNI3g=
X-Received: by 2002:a17:90b:1008:b0:2c1:9c10:8b87 with SMTP id
 98e67ed59e1d1-2c2bcc0bed1mr76660a91.29.1717692714697; Thu, 06 Jun 2024
 09:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605002459.4091285-1-andrii@kernel.org> <20240605002459.4091285-5-andrii@kernel.org>
 <CAJuCfpFp38X-tbiRAqS36zXG_ho2wyoRas0hCFLo07pN1noSmg@mail.gmail.com>
In-Reply-To: <CAJuCfpFp38X-tbiRAqS36zXG_ho2wyoRas0hCFLo07pN1noSmg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jun 2024 09:51:41 -0700
Message-ID: <CAEf4BzYv0Ys+NpMMuXBYEVwAaOow=oBgUhBwen7g=68_5qKznQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] fs/procfs: use per-VMA RCU-protected locking in
 PROCMAP_QUERY API
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, liam.howlett@oracle.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:16=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Jun 4, 2024 at 5:25=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > Attempt to use RCU-protected per-VMA lock when looking up requested VMA
> > as much as possible, only falling back to mmap_lock if per-VMA lock
> > failed. This is done so that querying of VMAs doesn't interfere with
> > other critical tasks, like page fault handling.
> >
> > This has been suggested by mm folks, and we make use of a newly added
> > internal API that works like find_vma(), but tries to use per-VMA lock.
> >
> > We have two sets of setup/query/teardown helper functions with differen=
t
> > implementations depending on availability of per-VMA lock (conditioned
> > on CONFIG_PER_VMA_LOCK) to abstract per-VMA lock subtleties.
> >
> > When per-VMA lock is available, lookup is done under RCU, attempting to
> > take a per-VMA lock. If that fails, we fallback to mmap_lock, but then
> > proceed to unconditionally grab per-VMA lock again, dropping mmap_lock
> > immediately. In this configuration mmap_lock is never helf for long,
> > minimizing disruptions while querying.
> >
> > When per-VMA lock is compiled out, we take mmap_lock once, query VMAs
> > using find_vma() API, and then unlock mmap_lock at the very end once as
> > well. In this setup we avoid locking/unlocking mmap_lock on every looke=
d
> > up VMA (depending on query parameters we might need to iterate a few of
> > them).
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  fs/proc/task_mmu.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 614fbe5d0667..140032ffc551 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -388,6 +388,49 @@ static int pid_maps_open(struct inode *inode, stru=
ct file *file)
> >                 PROCMAP_QUERY_VMA_FLAGS                         \
> >  )
> >
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +static int query_vma_setup(struct mm_struct *mm)
> > +{
> > +       /* in the presence of per-VMA lock we don't need any setup/tear=
down */
> > +       return 0;
> > +}
> > +
> > +static void query_vma_teardown(struct mm_struct *mm, struct vm_area_st=
ruct *vma)
> > +{
> > +       /* in the presence of per-VMA lock we need to unlock vma, if pr=
esent */
> > +       if (vma)
> > +               vma_end_read(vma);
> > +}
> > +
> > +static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct =
*mm, unsigned long addr)
> > +{
> > +       struct vm_area_struct *vma;
> > +
> > +       /* try to use less disruptive per-VMA lock */
> > +       vma =3D find_and_lock_vma_rcu(mm, addr);
> > +       if (IS_ERR(vma)) {
> > +               /* failed to take per-VMA lock, fallback to mmap_lock *=
/
> > +               if (mmap_read_lock_killable(mm))
> > +                       return ERR_PTR(-EINTR);
> > +
> > +               vma =3D find_vma(mm, addr);
> > +               if (vma) {
> > +                       /*
> > +                        * We cannot use vma_start_read() as it may fai=
l due to
> > +                        * false locked (see comment in vma_start_read(=
)). We
> > +                        * can avoid that by directly locking vm_lock u=
nder
> > +                        * mmap_lock, which guarantees that nobody can =
lock the
> > +                        * vma for write (vma_start_write()) under us.
> > +                        */
> > +                       down_read(&vma->vm_lock->lock);
>
> Hi Andrii,
> The above pattern of locking VMA under mmap_lock and then dropping
> mmap_lock is becoming more common. Matthew had an RFC proposal for an
> API to do this here:
> https://lore.kernel.org/all/ZivhG0yrbpFqORDw@casper.infradead.org/. It
> might be worth reviving that discussion.

Sure, it would be nice to have generic and blessed primitives to use
here. But the good news is that once this is all figured out by you mm
folks, it should be easy to make use of those primitives here, right?

>
> > +               }
> > +
> > +               mmap_read_unlock(mm);
>
> Later on in your code you are calling get_vma_name() which might call
> anon_vma_name() to retrieve user-defined VMA name. After this patch
> this operation will be done without holding mmap_lock, however per
> https://elixir.bootlin.com/linux/latest/source/include/linux/mm_types.h#L=
582
> this function has to be called with mmap_lock held for read. Indeed
> with debug flags enabled you should hit this assertion:
> https://elixir.bootlin.com/linux/latest/source/mm/madvise.c#L96.

Sigh... Ok, what's the suggestion then? Should it be some variant of
mmap_assert_locked() || vma_assert_locked() logic, or it's not so
simple?

Maybe I should just drop the CONFIG_PER_VMA_LOCK changes for now until
all these gotchas are figured out for /proc/<pid>/maps anyway, and
then we can adapt both text-based and ioctl-based /proc/<pid>/maps
APIs on top of whatever the final approach will end up being the right
one?

Liam, any objections to this? The whole point of this patch set is to
add a new API, not all the CONFIG_PER_VMA_LOCK gotchas. My
implementation is structured in a way that should be easily amenable
to CONFIG_PER_VMA_LOCK changes, but if there are a few more subtle
things that need to be figured for existing text-based
/proc/<pid>/maps anyways, I think it would be best to use mmap_lock
for now for this new API, and then adopt the same final
CONFIG_PER_VMA_LOCK-aware solution.

>
> > +       }
> > +
> > +       return vma;
> > +}
> > +#else
> >  static int query_vma_setup(struct mm_struct *mm)
> >  {
> >         return mmap_read_lock_killable(mm);
> > @@ -402,6 +445,7 @@ static struct vm_area_struct *query_vma_find_by_add=
r(struct mm_struct *mm, unsig
> >  {
> >         return find_vma(mm, addr);
> >  }
> > +#endif
> >
> >  static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
> >                                                  unsigned long addr, u3=
2 flags)
> > @@ -441,8 +485,10 @@ static struct vm_area_struct *query_matching_vma(s=
truct mm_struct *mm,
> >  skip_vma:
> >         /*
> >          * If the user needs closest matching VMA, keep iterating.
> > +        * But before we proceed we might need to unlock current VMA.
> >          */
> >         addr =3D vma->vm_end;
> > +       vma_end_read(vma); /* no-op under !CONFIG_PER_VMA_LOCK */
> >         if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
> >                 goto next_vma;
> >  no_vma:
> > --
> > 2.43.0
> >

