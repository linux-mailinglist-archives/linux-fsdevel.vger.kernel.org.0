Return-Path: <linux-fsdevel+bounces-21125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4B78FF3D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 19:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E76B28B00
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D7619922D;
	Thu,  6 Jun 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDTXyTi0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E9197A6A
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695218; cv=none; b=Wy18dni/obofnyEnpUD4uscM9s6lbpib432Cek7nYjFND2QbAaLSMzYr/snivJpubW3eAfhp51BBluqBNbry/qff7T5UY3+C+FoY1cYjlaoqinFfOAvZm0PypfeejrG83lE606EqHrEsAuBZ+a1rqztZrqAkqHoVe0tOedNzDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695218; c=relaxed/simple;
	bh=rYVMkwI8qFoB/ptB7kU79gZFDx+FsNx/WF4p8yfanOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ON7ElGIfxm7Rc7eEztKTwrKqmj064VMjAfnVBPM0DtLKuFNz8v3sXZ8e90enJkZg/6916z5A2tZCqVDw9NWYx+Oo5xzOu/y6MGdmO4WZQAX4CKCK4A4aPK/I3+zDjmmGKm82dSgTqH62MRbZ4ZNWkt3h9/wscauRAam9DBXaot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDTXyTi0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so13741155e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2024 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717695215; x=1718300015; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPjsJlKDBXzcFKJiIo/4f6GGzkeINELRnLiFwHcGpOo=;
        b=mDTXyTi0rNw369u0JcGh6PhF8bbU1DdWb+GmNbbS/K5/j1zjdJa6PDMz2m++vK1gwa
         M0qxjq4TcBc8R8CeRthxIZQfF5Y/RuM6f/Sme+sY6OvrFkZyWMw5QZvRDZlL3PbgoFIK
         vZT1mxIRTSQioeBa//dcS7595/B+C46yb79cZ5cCBKkyLcLWC7VaVQhzgc1s5wq52nGJ
         AZu3JET/rp8SQwrPDW0qXqJ7NJKJHRSIF3PB9tfKwPIlB4ZBJ8hfjzRWMNCraIIJ+26G
         Yg1jT2s3OZfaq9250Ovcm6F5rElsrxJ3yLWk5oMcwzGt0wBMZsJB0Y6Age3GbIzX5QOL
         m8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717695215; x=1718300015;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPjsJlKDBXzcFKJiIo/4f6GGzkeINELRnLiFwHcGpOo=;
        b=VAfMrX+QEGbdtCYz53ySoyWOR3Z9CG/0ADXr7ZWwE7mjpA/niCdSqqCf8qC6Qkv8Xv
         y58bbzZhRxrjOGt34h7dcG0JDS6XPQbE8KGwJxUnuwSyYs7PuOTZBbNvnW/3fEm2RBZ6
         gDfehGHp0gkWzGEuyi1xv3NTvdt5IYgNV+4T0mUPenKr+5BPqDI7/xAVaFX4x12Eyk6l
         3OB09wswYWHHnIWSLejsxij27mZJ8wTuYmwUevpG+sejALVfh72ILTCD1PCErb6Os/Ot
         kXMJFsbAZX8jF2cDDsT7K0WIeOam61LqUeY+0G7wLb8Grca6z6LC83pAt57JUBzxmzgI
         EJOw==
X-Forwarded-Encrypted: i=1; AJvYcCUaFuWhUEEpD8Q0FECc+9+xYeMJLPflS9c1RYhZ3pjXwHXIePSh4AXQOrw02dnp2g7IkzilyDa9mFXu/bJyGrSc3oEerKa92AugZQM67A==
X-Gm-Message-State: AOJu0Yxuk4XR2GXW1nUSyHYRHHxYl8qHJsc3Eu3vsZprB6Cqt2ejlOcJ
	BayLtUF7yoflzPZ5ZdUM1VOkWtkc+pUv58wCG3vQXoZeWDuIonW1n1Tkt2p/cbmClAiBlDhl3k4
	pCjBJbBbgv+FmdW3upUhS4P34Yij9exCYIP6w
X-Google-Smtp-Source: AGHT+IE4QPvkBQBYH5qBQiqsMSACkO+0MruSkYzXUyRwuzkvF/JqqLhtKdRfSDNl8JmBwmG1H52WpeDjd6vt0pJCRZ4=
X-Received: by 2002:a05:600c:54ca:b0:420:309a:fe63 with SMTP id
 5b1f17b1804b1-42164a030a5mr3279955e9.22.1717695214069; Thu, 06 Jun 2024
 10:33:34 -0700 (PDT)
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
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 6 Jun 2024 10:33:19 -0700
Message-ID: <CAJuCfpEFpd-+DDr=EyA1gMKZcDZYpZN9pBuFczhVXrFSe11U_g@mail.gmail.com>
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

I think the documentation is correct. It says that at the time of
calling anon_vma_name() the mmap_lock should be locked (hence the
assertion). Then the user can raise anon_vma_name refcount, drop
mmap_lock and safely continue using anon_vma_name object. IOW this is
fine:

mmap_read_lock(vma->mm);
anon_name =3D anon_vma_name(vma);
anon_vma_name_get(anon_name);
mmap_read_unlock(vma->mm);
// keep using anon_name
anon_vma_name_put(anon_name);


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
> I also didn't think it would complicate your series too much, so I
> understand why you want to revert to the old locking semantics.  I'm
> fine with you continuing with the series on the old lock.  Thanks for
> trying to make this work.
>
> Regards,
> Liam

