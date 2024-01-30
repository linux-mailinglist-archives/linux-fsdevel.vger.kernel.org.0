Return-Path: <linux-fsdevel+bounces-9505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7BD841E78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 09:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692771C25278
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F369D58107;
	Tue, 30 Jan 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiNieTQC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4ED3838B;
	Tue, 30 Jan 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604936; cv=none; b=hLyCilkVqzH7nAiZwsnTqhdqKCV2vl79mEzwLYVqSlejmEeP+3KzPUf3hQr6ySIf3Ly/yl9G41V60yRfpcpnWMNjmxXXj06z0sYo9nSVbsYRgCEf6jcur9IvkeAkzEEQHxpsxvnS7rxBOk+HgzRxqndInx91v3JlvtgcZ/Vl4e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604936; c=relaxed/simple;
	bh=DYJUz9kKcGLJZ98tsI6Vy8dWSmkL5CVjrSjHuwrhBFc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWIv5cTZP9nUEKJfdBd0b8bQ+YUE310QMJExkXwq0N8pQ6hqH9ZD8Ad9x/o8LdcUkR8ftIo03KEbRV2UzYp93idT3lTM5qb3J3OXQr6XuHRfcaUygpKXfTbjwUTQWWNRb+HcOzYkm5ybIzhzuJUMl/ti0WsZNGSKoTIwN40osTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiNieTQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74A2C433C7;
	Tue, 30 Jan 2024 08:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706604935;
	bh=DYJUz9kKcGLJZ98tsI6Vy8dWSmkL5CVjrSjHuwrhBFc=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=KiNieTQCpZmVleFrROUWQu0NDvzUVlu47fVYNoOPNVEfF0RaUAPUbFJ8ELRE9xEBl
	 iRoWKAiUOKgCHz4ay+Sa350xqxXAh+L235WWsJfb6clIej45A7owi8nddPP4N72CoN
	 ZAk9eZUy1TV75OZZc7SxSMGyasVnSj8SrxMDfqiRIK96IFxnoOFoA/pJWx9ST6tT27
	 KuI3j0y5Jez8mpoPe5DrdudQaGJ30YQAI+jOIaSCkTpivdD1hEPfm2cZtGSX1apj9N
	 BCOtGf1fIXrl0fhc/KMELNpqB4Y7iN7kPqi4eiu4VfzNpx/drxCnUEZo0dONjuNzRB
	 gXOA3svyctVVQ==
Date: Tue, 30 Jan 2024 10:55:09 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com
Subject: Re: [PATCH v2 2/3] userfaultfd: protect mmap_changing with rw_sem in
 userfaulfd_ctx
Message-ID: <Zbi5bZWI3JkktAMh@kernel.org>
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-3-lokeshgidra@google.com>
 <20240129210014.troxejbr3mzorcvx@revolver>
 <CA+EESO6XiPfbUBgU3FukGvi_NG5XpAQxWKu7vg534t=rtWmGXg@mail.gmail.com>
 <20240130034627.4aupq27mksswisqg@revolver>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130034627.4aupq27mksswisqg@revolver>

On Mon, Jan 29, 2024 at 10:46:27PM -0500, Liam R. Howlett wrote:
> * Lokesh Gidra <lokeshgidra@google.com> [240129 17:35]:
> > On Mon, Jan 29, 2024 at 1:00 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Lokesh Gidra <lokeshgidra@google.com> [240129 14:35]:
> > > > Increments and loads to mmap_changing are always in mmap_lock
> > > > critical section.
> > >
> > > Read or write?
> > >
> > It's write-mode when incrementing (except in case of
> > userfaultfd_remove() where it's done in read-mode) and loads are in
> > mmap_lock (read-mode). I'll clarify this in the next version.
> > >
> > > > This ensures that if userspace requests event
> > > > notification for non-cooperative operations (e.g. mremap), userfaultfd
> > > > operations don't occur concurrently.
> > > >
> > > > This can be achieved by using a separate read-write semaphore in
> > > > userfaultfd_ctx such that increments are done in write-mode and loads
> > > > in read-mode, thereby eliminating the dependency on mmap_lock for this
> > > > purpose.
> > > >
> > > > This is a preparatory step before we replace mmap_lock usage with
> > > > per-vma locks in fill/move ioctls.
> > > >
> > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > ---
> > > >  fs/userfaultfd.c              | 40 ++++++++++++----------
> > > >  include/linux/userfaultfd_k.h | 31 ++++++++++--------
> > > >  mm/userfaultfd.c              | 62 ++++++++++++++++++++---------------
> > > >  3 files changed, 75 insertions(+), 58 deletions(-)
> > > >
> > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > index 58331b83d648..c00a021bcce4 100644
> > > > --- a/fs/userfaultfd.c
> > > > +++ b/fs/userfaultfd.c
> > > > @@ -685,12 +685,15 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
> > > >               ctx->flags = octx->flags;
> > > >               ctx->features = octx->features;
> > > >               ctx->released = false;
> > > > +             init_rwsem(&ctx->map_changing_lock);
> > > >               atomic_set(&ctx->mmap_changing, 0);
> > > >               ctx->mm = vma->vm_mm;
> > > >               mmgrab(ctx->mm);
> > > >
> > > >               userfaultfd_ctx_get(octx);
> > > > +             down_write(&octx->map_changing_lock);
> > > >               atomic_inc(&octx->mmap_changing);
> > > > +             up_write(&octx->map_changing_lock);
> 
> On init, I don't think taking the lock is strictly necessary - unless
> there is a way to access it before this increment?  Not that it would
> cost much.

It's fork, the lock is for the context of the parent process and there
could be uffdio ops running in parallel on its VM.
 
> > > You could use the first bit of the atomic_inc as indication of a write.
> > > So if the mmap_changing is even, then there are no writers.  If it
> > > didn't change and it's even then you know no modification has happened
> > > (or it overflowed and hit the same number which would be rare, but
> > > maybe okay?).
> > 
> > This is already achievable, right? If mmap_changing is >0 then we know
> > there are writers. The problem is that we want writers (like mremap
> > operations) to block as long as there is a userfaultfd operation (also
> > reader of mmap_changing) going on. Please note that I'm inferring this
> > from current implementation.
> > 
> > AFAIU, mmap_changing isn't required for correctness, because all
> > operations are happening under the right mode of mmap_lock. It's used
> > to ensure that while a non-cooperative operations is happening, if the
> > user has asked it to be notified, then no other userfaultfd operations
> > should take place until the user gets the event notification.
> 
> I think it is needed, mmap_changing is read before the mmap_lock is
> taken, then compared after the mmap_lock is taken (both read mode) to
> ensure nothing has changed.

mmap_changing is required to ensure that no uffdio operation runs in
parallel with operations that modify the memory map, like fork, mremap,
munmap and some of madvise calls. 
And we do need the writers to block if there is an uffdio operation going
on, so I think an rwsem is the right way to protect mmap_chaniging.

> > > > @@ -783,7 +788,9 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
> > > >               return true;
> > > >
> > > >       userfaultfd_ctx_get(ctx);
> > > > +     down_write(&ctx->map_changing_lock);
> > > >       atomic_inc(&ctx->mmap_changing);
> > > > +     up_write(&ctx->map_changing_lock);
> > > >       mmap_read_unlock(mm);
> > > >
> > > >       msg_init(&ewq.msg);
> 
> If this happens in read mode, then why are you waiting for the readers
> to leave?  Can't you just increment the atomic?  It's fine happening in
> read mode today, so it should be fine with this new rwsem.

It's been a while and the details are blurred now, but if I remember
correctly, having this in read mode forced non-cooperative uffd monitor to
be single threaded. If a monitor runs, say uffdio_copy, and in parallel a
thread in the monitored process does MADV_DONTNEED, the latter will wait
for userfaultfd_remove notification to be processed in the monitor and drop
the VMA contents only afterwards. If a non-cooperative monitor would
process notification in parallel with uffdio ops, MADV_DONTNEED could
continue and race with uffdio_copy, so read mode wouldn't be enough.

There was no much sense to make MADV_DONTNEED take mmap_lock in write mode
just for this, but now taking the rwsem in write mode here sounds
reasonable.
 
> Thanks,
> Liam
> 
> ...

-- 
Sincerely yours,
Mike.

