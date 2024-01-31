Return-Path: <linux-fsdevel+bounces-9602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DBE8433CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 03:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA711C23A68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AAF5677;
	Wed, 31 Jan 2024 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYFSi4EQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E8038DDE
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667881; cv=none; b=PBrrWfbe0Z0nO3jaJCcd7g+yJaNlamKPmN/yOBJDr3yw0fn3sgzA707c82+2/jRI916I6MD8zrGbvzPu0oVIgToNrCp6Tn/2JqsWmxDGESmJxAj50/rrRfh49xXpV8hXykmHrrJbIIu3dUUkJfskktdGTbAUCIA3AFXusDwCSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667881; c=relaxed/simple;
	bh=W8wKKId1/z0dIWkQvCTjtBqlVtolqte1iLwbPROJK3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IYvTehAG+Xtnz4zkk1Bqkw3kkGSjtbbVawkJN3RLj2utyvVC0q4VNfU4BMGhXpMr6KFmYd468eOwv6jw6ifSzLtKBPEq/9UwJTT33C9JeQ0FOJN5VPjP0QyF0IonNNqQcEhHSn2DGTJNHmklGMZ2Qc5niHa1G9dRdzl0ibrkXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYFSi4EQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-339289fead2so3560271f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 18:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706667878; x=1707272678; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNDBDr2HIUePrwDqJX7AXKQLPV8jSOXnSTo+JHeA8P8=;
        b=UYFSi4EQlRRTXc+dklykLD4l+9PnpUGRMmWl1E5m6Dr2nOqhnsQNMFx7Cx1/PEb1Kb
         8uu07cpTMkaMdeEIuNV1/jMjYem8pqkMksTou6/ZRQXIijO6py4VODIEX8UjqKFZ05+I
         UBfoxEi1P8zb16D3remv+q/ePhRWix91Bix6yyeyqrppPRyTF7Fg6uwOSssBY2ePBGqx
         pwn8B/ytHLOnjJFPWWUzm1WhXPukoMrr6n6mN9QfHUtTaSgdRf95tWRXf+h5icuu0aRM
         uNxak/wtunljMY0cLP5Df+UgJvhSxHjJPukJrvSfDespPOvfW+jAuopYLrP1WKZf8dT8
         Y9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706667878; x=1707272678;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNDBDr2HIUePrwDqJX7AXKQLPV8jSOXnSTo+JHeA8P8=;
        b=AXMCn3ts046citjUhVJUc5bRvGOv+eS77e9Te9fVCclNAFvLaV/ewhvAW0KQEFp7Wm
         q6GHCenxfsKdHfSU1/a1P5OV3HdE03PijPW+i3T6g+2p/CpR8ffY2+54vjI57wr0/DGM
         ohKVWu2T+T7+VuStD4tHdaYPOMeqOMfWsDu+BAhJzgdNznv8Ynn7JLmJ3CUkm5kjJPnZ
         ljyZvJt1VBqsTUDPlC1f6UaBfQcvJxb5owNU09HVmQ8AdGjdg5/iUBfRHccNNckY2Nms
         mshmhSxkZynHplZOM7z9K29XyOEo/TzQxKh1RhwRVVN4BolSIWVussFNu7sPXnijpqCI
         25nA==
X-Gm-Message-State: AOJu0YzTlqNM5986KEK6dp8/CW6oFbgjtxc/P90NjicCKlfIVN+iM6Mn
	4kmWTbn/fZcyZMT69c6+4R77/9ZQQXo2R3nQ91jEesuLpyHysc2/XwQCG+qSkkRcfLvyLHWyBwv
	jfbywC0UokvELMte6lJs8HmYpLC+fhKlA4Guw
X-Google-Smtp-Source: AGHT+IHmasuDEqZccuPfAUzwk2QyR9mhEieYSp+I9wbmzSc2V2fKLkiiZu/JCqxutAC4P8kMWrX8V3bPUn7hqIZEZHY=
X-Received: by 2002:a05:6000:1753:b0:33a:f4e4:107f with SMTP id
 m19-20020a056000175300b0033af4e4107fmr163045wrf.38.1706667877436; Tue, 30 Jan
 2024 18:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-3-lokeshgidra@google.com> <20240129210014.troxejbr3mzorcvx@revolver>
 <CA+EESO6XiPfbUBgU3FukGvi_NG5XpAQxWKu7vg534t=rtWmGXg@mail.gmail.com>
 <20240130034627.4aupq27mksswisqg@revolver> <Zbi5bZWI3JkktAMh@kernel.org> <20240130172831.hv5z7a7bhh4enoye@revolver>
In-Reply-To: <20240130172831.hv5z7a7bhh4enoye@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 30 Jan 2024 18:24:24 -0800
Message-ID: <CA+EESO7W=yz1DyNsuDRd-KJiaOg51QWEQ_MfpHxEL99ZeLS=AA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 9:28=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Mike Rapoport <rppt@kernel.org> [240130 03:55]:
> > On Mon, Jan 29, 2024 at 10:46:27PM -0500, Liam R. Howlett wrote:
> > > * Lokesh Gidra <lokeshgidra@google.com> [240129 17:35]:
> > > > On Mon, Jan 29, 2024 at 1:00=E2=80=AFPM Liam R. Howlett <Liam.Howle=
tt@oracle.com> wrote:
> > > > >
> > > > > * Lokesh Gidra <lokeshgidra@google.com> [240129 14:35]:
> > > > > > Increments and loads to mmap_changing are always in mmap_lock
> > > > > > critical section.
> > > > >
> > > > > Read or write?
> > > > >
> > > > It's write-mode when incrementing (except in case of
> > > > userfaultfd_remove() where it's done in read-mode) and loads are in
> > > > mmap_lock (read-mode). I'll clarify this in the next version.
> > > > >
> > > > > > This ensures that if userspace requests event
> > > > > > notification for non-cooperative operations (e.g. mremap), user=
faultfd
> > > > > > operations don't occur concurrently.
> > > > > >
> > > > > > This can be achieved by using a separate read-write semaphore i=
n
> > > > > > userfaultfd_ctx such that increments are done in write-mode and=
 loads
> > > > > > in read-mode, thereby eliminating the dependency on mmap_lock f=
or this
> > > > > > purpose.
> > > > > >
> > > > > > This is a preparatory step before we replace mmap_lock usage wi=
th
> > > > > > per-vma locks in fill/move ioctls.
> > > > > >
> > > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > > ---
> > > > > >  fs/userfaultfd.c              | 40 ++++++++++++----------
> > > > > >  include/linux/userfaultfd_k.h | 31 ++++++++++--------
> > > > > >  mm/userfaultfd.c              | 62 ++++++++++++++++++++-------=
--------
> > > > > >  3 files changed, 75 insertions(+), 58 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > > > index 58331b83d648..c00a021bcce4 100644
> > > > > > --- a/fs/userfaultfd.c
> > > > > > +++ b/fs/userfaultfd.c
> > > > > > @@ -685,12 +685,15 @@ int dup_userfaultfd(struct vm_area_struct=
 *vma, struct list_head *fcs)
> > > > > >               ctx->flags =3D octx->flags;
> > > > > >               ctx->features =3D octx->features;
> > > > > >               ctx->released =3D false;
> > > > > > +             init_rwsem(&ctx->map_changing_lock);
> > > > > >               atomic_set(&ctx->mmap_changing, 0);
> > > > > >               ctx->mm =3D vma->vm_mm;
> > > > > >               mmgrab(ctx->mm);
> > > > > >
> > > > > >               userfaultfd_ctx_get(octx);
> > > > > > +             down_write(&octx->map_changing_lock);
> > > > > >               atomic_inc(&octx->mmap_changing);
> > > > > > +             up_write(&octx->map_changing_lock);
> > >
> > > On init, I don't think taking the lock is strictly necessary - unless
> > > there is a way to access it before this increment?  Not that it would
> > > cost much.
> >
> > It's fork, the lock is for the context of the parent process and there
> > could be uffdio ops running in parallel on its VM.
>
> Is this necessary then?  We are getting the octx from another mm but the
> mm is locked for forking.  Why does it matter if there are readers of
> the octx?
>
> I assume, currently, there is no way the userfaultfd ctx can
> be altered under mmap_lock held for writing. I would think it matters if
> there are writers (which, I presume are blocked by the mmap_lock for
> now?)  Shouldn't we hold the write lock for the entire dup process, I
> mean, if we remove the userfaultfd from the mmap_lock, we cannot let the
> structure being duplicated change half way through the dup process?
>
> I must be missing something with where this is headed?
>
AFAIU, the purpose of mmap_changing is to serialize uffdio operations
with non-cooperative events if and when such events are being
monitored by userspace (in case you missed, in all the cases of writes
to mmap_changing, we only do it if that non-cooperative event has been
requested by the user). As you pointed out there are no correctness
concerns as far as userfaultfd operations are concerned. But these
events are essential for the uffd monitor's functioning.

For example: say the uffd monitor wants to be notified for REMAP
operations while doing uffdio_copy operations. When COPY ioctls start
failing with -EAGAIN and uffdio_copy.copy =3D=3D 0, then it knows it must
be due to mremap(), in which case it waits for the REMAP event
notification before attempting COPY again.

But there are few things that I didn't get after going through the
history of non-cooperative events. Hopefully Mike (or someone else
familiar) can clarify:

IIUC, the idea behind non-cooperative events was to block uffdio
operations from happening *before* the page tables are manipulated by
the event (like mremap), and that the uffdio ops are resumed after the
event notification is received by the monitor. If so then:

1) Why in the case of REMAP prep() is done after page-tables are
moved? Shouldn't it be done before? All other non-cooperative
operations do the prep() before.
2) UFFD_FEATURE_EVENT_REMOVE only notifies user space. It is not
consistently blocking uffdio operations (as both sides are acquiring
mmap_lock in read-mode) when remove operation is taking place. I can
understand this was intentionally left as is in the interest of not
acquiring mmap_lock in write-mode during madvise. But is only getting
the notification any useful? Can we say this patch fixes it? And in
that case shouldn't I split userfaultfd_remove() into two functions
(like other non-cooperative operations)?
3) Based on [1] I see how mmap_changing helps in eliminating duplicate
work (background copy) by uffd monitor, but didn't get if there is a
correctness aspect too that I'm missing? I concur with Amit's point in
[1] that getting -EEXIST when setting up the pte will avoid memory
corruption, no?

[1] https://lore.kernel.org/lkml/20201206093703.GY123287@linux.ibm.com/
> >
> > > > > You could use the first bit of the atomic_inc as indication of a =
write.
> > > > > So if the mmap_changing is even, then there are no writers.  If i=
t
> > > > > didn't change and it's even then you know no modification has hap=
pened
> > > > > (or it overflowed and hit the same number which would be rare, bu=
t
> > > > > maybe okay?).
> > > >
> > > > This is already achievable, right? If mmap_changing is >0 then we k=
now
> > > > there are writers. The problem is that we want writers (like mremap
> > > > operations) to block as long as there is a userfaultfd operation (a=
lso
> > > > reader of mmap_changing) going on. Please note that I'm inferring t=
his
> > > > from current implementation.
> > > >
> > > > AFAIU, mmap_changing isn't required for correctness, because all
> > > > operations are happening under the right mode of mmap_lock. It's us=
ed
> > > > to ensure that while a non-cooperative operations is happening, if =
the
> > > > user has asked it to be notified, then no other userfaultfd operati=
ons
> > > > should take place until the user gets the event notification.
> > >
> > > I think it is needed, mmap_changing is read before the mmap_lock is
> > > taken, then compared after the mmap_lock is taken (both read mode) to
> > > ensure nothing has changed.
> >
> > mmap_changing is required to ensure that no uffdio operation runs in
> > parallel with operations that modify the memory map, like fork, mremap,
> > munmap and some of madvise calls.
> > And we do need the writers to block if there is an uffdio operation goi=
ng
> > on, so I think an rwsem is the right way to protect mmap_chaniging.
> >
> > > > > > @@ -783,7 +788,9 @@ bool userfaultfd_remove(struct vm_area_stru=
ct *vma,
> > > > > >               return true;
> > > > > >
> > > > > >       userfaultfd_ctx_get(ctx);
> > > > > > +     down_write(&ctx->map_changing_lock);
> > > > > >       atomic_inc(&ctx->mmap_changing);
> > > > > > +     up_write(&ctx->map_changing_lock);
> > > > > >       mmap_read_unlock(mm);
> > > > > >
> > > > > >       msg_init(&ewq.msg);
> > >
> > > If this happens in read mode, then why are you waiting for the reader=
s
> > > to leave?  Can't you just increment the atomic?  It's fine happening =
in
> > > read mode today, so it should be fine with this new rwsem.
> >
> > It's been a while and the details are blurred now, but if I remember
> > correctly, having this in read mode forced non-cooperative uffd monitor=
 to
> > be single threaded. If a monitor runs, say uffdio_copy, and in parallel=
 a
> > thread in the monitored process does MADV_DONTNEED, the latter will wai=
t
> > for userfaultfd_remove notification to be processed in the monitor and =
drop
> > the VMA contents only afterwards. If a non-cooperative monitor would
> > process notification in parallel with uffdio ops, MADV_DONTNEED could
> > continue and race with uffdio_copy, so read mode wouldn't be enough.
> >
>
> Right now this function won't stop to wait for readers to exit the
> critical section, but with this change there will be a pause (since the
> down_write() will need to wait for the readers with the read lock).  So
> this is adding a delay in this call path that isn't necessary (?) nor
> existed before.  If you have non-cooperative uffd monitors, then you
> will have to wait for them to finish to mark the uffd as being removed,
> where as before it was a fire & forget, this is now a wait to tell.
>
I think a lot will be clearer once we get a response to my questions
above. IMHO not only this write-lock is needed here, we need to fix
userfaultfd_remove() by splitting it into userfaultfd_remove_prep()
and userfaultfd_remove_complete() (like all other non-cooperative
operations) as well. This patch enables us to do that as we remove
mmap_changing's dependency on mmap_lock for synchronization.
>
> > There was no much sense to make MADV_DONTNEED take mmap_lock in write m=
ode
> > just for this, but now taking the rwsem in write mode here sounds
> > reasonable.
> >
>
> I see why there was no need for a mmap_lock in write mode, but I think
> taking the new rwsem in write mode is unnecessary.
>
> Basically, I see this as a signal to new readers to abort, but we don't
> need to wait for current readers to finish before this one increments
> the atomic.
>
> Unless I missed something, I don't think you want to take the write lock
> here.
What I understood from the history of mmap_changing is that the
intention was to enable informing the uffd monitor about the correct
state of which pages are filled and which aren't. Going through this
thread was very helpful [2]

[2] https://lore.kernel.org/lkml/1527061324-19949-1-git-send-email-rppt@lin=
ux.vnet.ibm.com/
>
> Thanks,
> Liam

