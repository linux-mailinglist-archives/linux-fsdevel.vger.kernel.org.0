Return-Path: <linux-fsdevel+bounces-40163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C1FA20048
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0DB165AE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 22:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322E11D9694;
	Mon, 27 Jan 2025 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcjciOQ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7831B4F0C;
	Mon, 27 Jan 2025 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015728; cv=none; b=VDGPq5+zES1AgqM/lHPl6ay7CuPlEowxuJhOvtbaDMqLaGMs7N3bnTczux24Gn8tzZOE7AqwKeeioHNFO0hnDkDiskQz6whk9nDrGkXDE7aOaK0olSDFRlQS7BuBa21RBF8HSsEcO1bd4SK8MG4iW5L1aqUHBhMT9yurXdu4rxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015728; c=relaxed/simple;
	bh=VIh1K8M6ewHn3aU6y7v9pjz+q+Bofm42EEKtD6yja8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLlc7vhA55qFNvjA2nfR2zas+RBGunNIHzcdV/h0J3cseSroRhJYsplcpYPgUQvvUk+20JEeBMJZjg9R/NDqSi6nkKpG/leRivqXBErlFFsqNBR1LrrPZIP1Um0ktuBJrj6lWhO+lKbxtq1O2XMIklQ9aXmLtt1Jd1AucEhtcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcjciOQ4; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-518954032b2so1632371e0c.0;
        Mon, 27 Jan 2025 14:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738015725; x=1738620525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/MaX3YAY2PQiBOYsEwPJEIAwTTPFRHSYvA/7ys2JTA=;
        b=CcjciOQ4zT3PZpADVZVmvSYvsxrZ7FiUDlIPSRZ5VX2Ty6w3u409sx1jvwag+VO+1h
         Vs+jkF4v+5b4m4bqSMjnvQ7RHMC8yJSNFtoD68aP0ll5qE38rgwv8P4EV8jFP7zxjwgO
         9kugAwWlnfsEvfzRQEYnRoTo9D23s5z0EuRiqKby2Sf7u9lI3n3nfA7c3RwsFqOpJra4
         Dt+VAnYwYRtdUsYnGWlOjl/zQ+FBHbkupzzqOq6w9M/zNfkDTnuVyTZZ5oFzcVjXLZm1
         aV0aYCHKhTlJcDGUxW3Rw5tHVpE5vop5az9Hf3bGTbY2yYu05PdUc4V+h2DFXEMIiRBh
         dZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738015725; x=1738620525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/MaX3YAY2PQiBOYsEwPJEIAwTTPFRHSYvA/7ys2JTA=;
        b=iwj2j6V/FvMI/9+AblfKLJWoPTtfiooQFdXqQ36o7bLvgF04qiGQbupT4qzKlyZizf
         ufbYbdLYANZbv2nL9zCi9JB9qZD0I5IWB4/+WFKa4u0ZLRr2I4RDUknXE/4FkTSDTAJr
         tf6lsrIwp79yDRvTT/wW7G3cbbXG2xIz+RKnTxznMH2yND2zigY/2lDRBs8iqfuYFSH7
         ZDfbbOW9W49QAPG+flOhyN3kBFofOk9UyoBVTHnZKUsZ0d1Zooyvf1p45k8N6DPXSPIE
         4JQHh4OeoOP3LIgigndQa6im7jvFYQtVN/RUMsZRCHM9kRNNMAPcJkEqNqHcmlWP0C5V
         7Pog==
X-Forwarded-Encrypted: i=1; AJvYcCVIrJX2+Kgp7fJ8o8E6JmEuZuJ9dIEVdWYRtn8EoW81iaXPKJD5IXxlBgr4tkNAypWy8mDCSGGjC0SIXJyd@vger.kernel.org, AJvYcCWPuXyWMwlfjLHGyqAy4Jm6ejD9nBThxm00Qa51PTMHGGVOzRe3lLInQx75LSwkepg4SfJSD7ZP20dqWmP+@vger.kernel.org, AJvYcCXDyGDGc2jCd4abYr/s8JSyZWrSlnEKkM+0x7ed9h7bUFeVUvXw6+yGp43DTaCr00Syko9VTPEoJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+cUaWFMeanu4oTp9vhOltBBHtIqUYEPdKvOFadWcfRq4AMjIy
	eUxRBDTXEzXdUVYyhOFy/WwLkx/4nDtzS18iLbkJePAKqZahSZ7XvMCV8PhYHorUYc9y0T7VD1f
	03xSenNWJb3pIVvSDh6mCaxCMlgA=
X-Gm-Gg: ASbGnctc7+9i72rtFFw3biAsXrxDOGzzcFe3KpMY9yxNetIGW1liwRq0Hu59PfParUx
	ODyyIaiuHLurBW60hehXBco1sd5jCUy/eKsVyCBVXpkown470oVRcvJXLbLiRpLLdvAoLzmthE5
	ndORWzAr0lYGxbD/guwq7V
X-Google-Smtp-Source: AGHT+IGuYh9hEG25zHdFNari8iaK0FGwypKdrfMdzkC4lUjyLPuEDLdNXpIv8VHKsRGphTbuWP011BGsVDSzcdNE0ww=
X-Received: by 2002:a05:6122:4005:b0:517:4fca:86d4 with SMTP id
 71dfb90a1353d-51d5b3aacb3mr35313618e0c.11.1738015725296; Mon, 27 Jan 2025
 14:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215182756.3448972-5-lokeshgidra@google.com>
 <20250123041427.1987-1-21cnbao@gmail.com> <rb7qajtpmmntvvqq2ckzjqs76mflxyuingixx3v7q63jd7xqfm@v7hm5aqhe23z>
 <CA+EESO64boFPfXqZ7c6nQe6U8K4T-4acVC+RKRQWwHP_+0YTQA@mail.gmail.com>
In-Reply-To: <CA+EESO64boFPfXqZ7c6nQe6U8K4T-4acVC+RKRQWwHP_+0YTQA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 28 Jan 2025 06:08:31 +0800
X-Gm-Features: AWEUYZkd54V2eWdghLL9GpsA51a04wOUhGrwB5LWEt3YUD8isFhku1qMpzYHb8Y
Message-ID: <CAGsJ_4yi=rp0uTzECt_+d9OD=jMikp40f9EhM4U6xFy+evYimQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] userfaultfd: use per-vma locks in userfaultfd operations
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, aarcange@redhat.com, akpm@linux-foundation.org, 
	axelrasmussen@google.com, bgeffon@google.com, david@redhat.com, 
	jannh@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ngeoffray@google.com, peterx@redhat.com, rppt@kernel.org, 
	ryan.roberts@arm.com, selinux@vger.kernel.org, surenb@google.com, 
	timmurray@google.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:45=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> On Thu, Jan 23, 2025 at 8:52=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Barry Song <21cnbao@gmail.com> [250122 23:14]:
> > > > All userfaultfd operations, except write-protect, opportunistically=
 use
> > > > per-vma locks to lock vmas. On failure, attempt again inside mmap_l=
ock
> > > > critical section.
> > > >
> > > > Write-protect operation requires mmap_lock as it iterates over mult=
iple
> > > > vmas.
> > > h
> > > Hi Lokesh,
> > >
> > > Apologies for reviving this old thread. We truly appreciate the excel=
lent work
> > > you=E2=80=99ve done in transitioning many userfaultfd operations to p=
er-VMA locks.
> > >
> > > However, we=E2=80=99ve noticed that userfaultfd still remains one of =
the largest users
> > > of mmap_lock for write operations, with the other=E2=80=94binder=E2=
=80=94having been recently
> > > addressed by Carlos Llamas's "binder: faster page installations" seri=
es:
> > >
> > > https://lore.kernel.org/lkml/20241203215452.2820071-1-cmllamas@google=
.com/
> > >
> > > The HeapTaskDaemon(Java GC) might frequently perform userfaultfd_regi=
ster()
> > > and userfaultfd_unregister() operations, both of which require the mm=
ap_lock
> > > in write mode to either split or merge VMAs. Since HeapTaskDaemon is =
a
> > > lower-priority background task, there are cases where, after acquirin=
g the
> > > mmap_lock, it gets preempted by other tasks. As a result, even high-p=
riority
> > > threads waiting for the mmap_lock =E2=80=94 whether in writer or read=
er mode=E2=80=94can
> > > end up experiencing significant delays=EF=BC=88The delay can reach se=
veral hundred
> > > milliseconds in the worst case.=EF=BC=89
>
> Do you happen to have some trace that I can take a look at?

We observed a rough trace in Android Studio showing the HeapTaskDaemon
stuck in a runnable state after holding the mmap_lock for 1 second, while o=
ther
threads were waiting for the lock.

Our team will assist in collecting a detailed trace, but everyone is
currently on
an extended Chinese New Year holiday. Apologies, this may delay the process
until after February 8.

> >
> > This needs an RFC or proposal or a discussion - certainly not a reply t=
o
> > an old v7 patch set.  I'd want neon lights and stuff directing people t=
o
> > this topic.
> >
> > >
> > > We haven=E2=80=99t yet identified an ideal solution for this. However=
, the Java heap
> > > appears to behave like a "volatile" vma in its usage. A somewhat simp=
listic
> > > idea would be to designate a specific region of the user address spac=
e as
> > > "volatile" and restrict all "volatile" VMAs to this isolated region.
> >
> > I'm going to assume the uffd changes are in the volatile area?  But
> > really, maybe you mean the opposite..  I'll just assume I guessed
> > correct here.  Because, both sides of this are competing for the write
> > lock.
> >
> > >
> > > We may have a MAP_VOLATILE flag to mmap. VMA regions with this flag w=
ill be
> > > mapped to the volatile space, while those without it will be mapped t=
o the
> > > non-volatile space.
> > >
> > >          =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90TASK_SIZE
> > >          =E2=94=82            =E2=94=82
> > >          =E2=94=82            =E2=94=82
> > >          =E2=94=82            =E2=94=82mmap VOLATILE
> > >          =E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> > >          =E2=94=82            =E2=94=82
> > >          =E2=94=82            =E2=94=82
> > >          =E2=94=82            =E2=94=82
> > >          =E2=94=82            =E2=94=82
> > >          =E2=94=82            =E2=94=82default mmap
> > >          =E2=94=82            =E2=94=82
> > >          =E2=94=82            =E2=94=82
> > >          =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> >
> > No, this is way too complicated for what you are trying to work around.
> >
> > You are proposing a segmented layout of the virtual memory area so that
> > an optional (userfaultfd) component can avoid a lock - which already ha=
s
> > another optional (vma locking) workaround.
> >
> > I think we need to stand back and look at what we're doing here in
> > regards to userfaultfd and how it interacts with everything.  Things
> > have gotten complex and we're going in the wrong direction.
> >
> > I suggest there is an easier way to avoid the contention, and maybe try
> > to rectify some of the uffd code to fit better with the evolved use
> > cases and vma locking.
> >
> > >
> > > VMAs in the volatile region are assigned their own volatile_mmap_lock=
,
> > > which is independent of the mmap_lock for the non-volatile region.
> > > Additionally, we ensure that no single VMA spans the boundary between
> > > the volatile and non-volatile regions. This separation prevents the
> > > frequent modifications of a small number of volatile VMAs from blocki=
ng
> > > other operations on a large number of non-volatile VMAs.
> > >
> > > The implementation itself wouldn=E2=80=99t be overly complex, but the=
 design
> > > might come across as somewhat hacky.
>
> I agree with others. Your proposal sounds too radical and doesn't seem
> necessary to me. I'd like to see the traces and understand how
> real/frequent the issue is.

No worries, I figured the idea might not be well-received since it was more=
 of
a hack. Just try to explain that some VMAs might contribute more mmap_lock
contention (volatile), while others might not.

> > >
> > > Lastly, I have two questions:
> > >
> > > 1. Have you observed similar issues where userfaultfd continues to
> > > cause lock contention and priority inversion?
>
> We haven't seen any such cases so far. But due to some other reasons,
> we are seriously considering temporarily increasing the GC-thread's
> priority when it is running stop-the-world pause.
> > >
> > > 2. If so, do you have any ideas or suggestions on how to address this
> > > problem?
>
> There are userspace solutions possible to reduce/eliminate the number
> of times userfaultfd register/unregister are done during a GC. I
> didn't do it due to added complexity it would introduce to the GC's
> code.
> >
> > These are good questions.
> >
> > I have a few of my own about what you described:
> >
> > - What is causing your application to register/unregister so many uffds=
?
>
> In every GC invocation, we have two userfaultfd_register() + mremap()
> in a stop-the-world pause, and then two userfaultfd_unregister() at
> the end of GC. The problematic ones ought to be the one in the pause
> as we want to keep it as short as possible. The reason we want to
> register/unregister the heap during GC is so that the overhead of
> userfaults can be avoided when GC is not active.
>
> >
> > - Does the writes to the vmas overlap the register/unregsiter area
> >   today?  That is, do you have writes besides register/unregister going
> >   into your proposed volatile area or uffd modifications happening in
> >   the 'default mmap' area you specify above?
>
> That shouldn't be the case. The access to uffd registered VMAs should
> start *after* registration. That's the reason it is done in a pause.
> AFAIK, the source of contention is if some native (non-java) thread,
> which is not participating in the pause, does a mmap_lock write
> operation (mmap/munmap/mprotect/mremap/mlock etc.) elsewhere in the
> address space. The heap can't be involved.

Exactly. Essentially, we observe that the GC holds the mmap_lock but
gets preempted for an extended period, causing other tasks performing
mmap-like operations to wait for the GC to release the lock.

> >
> > Barry, this is a good LSF topic - will you be there?  I hope to attend.
> >
> > Something along the lines of "Userfualtfd contention, interactions, and
> > mitigations".

Thank you for your interest in this topic

It's unlikely that a travel budget will be available, so I won=E2=80=99t be=
 attending
in person. I might apply for virtual attendance to participate in some
discussions, but I don=E2=80=99t plan to run a session remotely=E2=80=94too=
 many things
can go wrong.

> >
> > Thanks,
> > Liam
> >

Thanks
Barry

