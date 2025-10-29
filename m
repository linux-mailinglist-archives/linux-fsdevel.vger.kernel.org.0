Return-Path: <linux-fsdevel+bounces-66380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB765C1D8B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 714B84E3954
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93757312816;
	Wed, 29 Oct 2025 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJR0SwWs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EDA284898
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761775237; cv=none; b=hmp9su9JhgaQoPdUfjrJ0RbItKNzru8EKjj9690Za9F/Rybd5RsakJloQf8VnVJF0JAYOUjz9AyqRblkhn6Cxy3Rd+QXQMGumuWUFdkuk2xP+Qs5ioAAM/mDMaYWK2DsBzTX8mH9x759LhH4KgC2tGP0dtdPYqysSpQQl+qgt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761775237; c=relaxed/simple;
	bh=6b6tWgoOYv1BDlNMVl9v4FQpfmpLkAx8er/On0TLus4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgAcbuibDSqm+G48/29LD4hccNaeogv8Pnrd1ijhoPDVCVuWZyoTs8ceQ+fP4ypC9A+6hY9kBcPAr23/Hw63eSTmKHx2yakpnVhmVlJ+ZbNobBMmVXUJ+/RB/KcF9IUTs7GfMl30QpAGYKWASaQ2jQxKI8OJUyP2b2zhPK+HUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJR0SwWs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27eeafd4882so35285ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 15:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761775234; x=1762380034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLD3TQVOiWY5r3Odhgs8R7i+r0sY0ies83ZNYoXLOpk=;
        b=ZJR0SwWsOdlfHJUtIWxy3O92CkUVWqkobeGiHJJENzAtYTaeQ3EWg+E/JxkTfbJmim
         fLqn8P93BT++vQ1qvcHtjOqrO9e91WYDetDyZGfgYjdxvfOysQSebNkrK6FDynIoNRqA
         2pYVOb7rdJZrYkm+JBzMUZYYzCX+SFYMtpFb9S7kZVtnC5N8e9cG49wW7HIsqgDPZ0Sq
         1uh8cK0O+9bG0tIAUxjmzw6llGmqoxoAB5r0XONQaXiD3ZqVdYkFHSvB8cLc1yu6L4bD
         NFHpDzhVzAw5Pu59HXdpeE3QDvaDxJSQT4ftrJOZvwqn0IQkkbjIDhjDknNSuGRsEcUi
         J6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761775234; x=1762380034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLD3TQVOiWY5r3Odhgs8R7i+r0sY0ies83ZNYoXLOpk=;
        b=AbIgi1keqRqJJEIlKe/GL7PeFgsAunODSYHkt79c9yV/Bnx59xh0HvVX8Oe7mM3ls/
         u1KfCR3DeMhlNB5VNHtprxXH1YxUraA6gYRmQr8/edTQ/hkY9wteM47/o1AMqAbONfV/
         KS8DHidQB0U/qT5gv7icZb8aHRNKBYvBqOJSB0+YnC+iPr88V/U5S+jqwHh/u01/8vuJ
         mDlja0t1oL6MV2gXegkDz88HXGMyAinCiUc2qv7PtLH1LBn2GaM+SAdHATp9p2kHGtf4
         /fWz2bn0u6y1i4cNX9SRHZ4B7QyEaAhKnE9vRvs7/n65jVwzjNxspiGno7r5DKTA3HQJ
         hoHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS5UZ/SNL67YaReVu0ZnxS6RGIIWn+4U1Cb8DL4PFZQnApuIfuJoSDGzXq73W28uumb2FECkK5r3f8xN6v@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzzAVdqTKRqzw3l349LXJo1ovBaq1ULu3ySusQOPN3lhMQio1
	lZ3SIdXZ8e9nG6MvxlBdUG20B/SHYbUWsxw47rPGL0oCAAQKttQTdL55SzBGLtbXhVezT0cGcg9
	iwssFizQnFfZlg88VovKNA2Em5Fj9Kv8vz7In8bZl
X-Gm-Gg: ASbGncsfO/7EZrALDVgWLDPCQPKEz4W0q/85qNSJvGJjbY8K0Eowok2UDO7oit0wM3b
	bZCF5TyV4dJB9KSPHhgApxb9DB4RZ8z2bo3YC9+73w4cy4pc69kqHvLHzsbqIHzrKjUjkW8l6e5
	YLlFYvc34yk9sJjmHGPUhh1YbxFfHF9+vTTRX8mzZxijMGtEwYD+Ai6lb0hzGHLNqyEHsb+p125
	3CubtWh87BeRQ+9t29ouBaZM0DGroRooPZZEtH2k2nDj0IVMmEWG6UJkNMWYOfi6AflxfMRQIrf
	s9csysAIKguXJ/op31b6HMPSlZkb
X-Google-Smtp-Source: AGHT+IGQiEL8ReoIvOwZKzbVpHBeTpPCQv29yrRij7Hwfs/n1+GX5gwd67TK3b+ch8zjTS1IjIo6qaeBI23B0BA9NWI=
X-Received: by 2002:a17:902:c40e:b0:26d:72f8:8cfa with SMTP id
 d9443c01a7336-294ef8d21c6mr633415ad.13.1761775233734; Wed, 29 Oct 2025
 15:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-15-pasha.tatashin@soleen.com> <mafs0tszhcyrw.fsf@kernel.org>
 <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
In-Reply-To: <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 29 Oct 2025 15:00:20 -0700
X-Gm-Features: AWmQ_bkGoprZL04a0uQTcZsPv3KjOr3HxUN9sapy64_kyfy98s5fgevUjY0pmjs
Message-ID: <CAAywjhTbBx+rYGpPGtTw_--9XhoYZBX8ase5ddM6rxmC5J-2JQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/30] liveupdate: luo_session: Add ioctls for file
 preservation and state management
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:13=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Wed, Oct 29, 2025 at 3:07=E2=80=AFPM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
> >
> > Hi Pasha,
> >
> > On Mon, Sep 29 2025, Pasha Tatashin wrote:
> >
> > > Introducing the userspace interface and internal logic required to
> > > manage the lifecycle of file descriptors within a session. Previously=
, a
> > > session was merely a container; this change makes it a functional
> > > management unit.
> > >
> > > The following capabilities are added:
> > >
> > > A new set of ioctl commands are added, which operate on the file
> > > descriptor returned by CREATE_SESSION. This allows userspace to:
> > > - LIVEUPDATE_SESSION_PRESERVE_FD: Add a file descriptor to a session
> > >   to be preserved across the live update.
> > > - LIVEUPDATE_SESSION_UNPRESERVE_FD: Remove a previously added file
> > >   descriptor from the session.
> > > - LIVEUPDATE_SESSION_RESTORE_FD: Retrieve a preserved file in the
> > >   new kernel using its unique token.
> > >
> > > A state machine for each individual session, distinct from the global
> > > LUO state. This enables more granular control, allowing userspace to
> > > prepare or freeze specific sessions independently. This is managed vi=
a:
> > > - LIVEUPDATE_SESSION_SET_EVENT: An ioctl to send PREPARE, FREEZE,
> > >   CANCEL, or FINISH events to a single session.
> > > - LIVEUPDATE_SESSION_GET_STATE: An ioctl to query the current state
> > >   of a single session.
> > >
> > > The global subsystem callbacks (luo_session_prepare, luo_session_free=
ze)
> > > are updated to iterate through all existing sessions. They now trigge=
r
> > > the appropriate per-session state transitions for any sessions that
> > > haven't already been transitioned individually by userspace.
> > >
> > > The session's .release handler is enhanced to be state-aware. When a
> > > session's file descriptor is closed, it now correctly cancels or
> > > finishes the session based on its current state before freeing all
> > > associated file resources, preventing resource leaks.
> > >
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > [...]
> > > +/**
> > > + * struct liveupdate_session_get_state - ioctl(LIVEUPDATE_SESSION_GE=
T_STATE)
> > > + * @size:     Input; sizeof(struct liveupdate_session_get_state)
> > > + * @incoming: Input; If 1, query the state of a restored file from t=
he incoming
> > > + *            (previous kernel's) set. If 0, query a file being prep=
ared for
> > > + *            preservation in the current set.
> >
> > Spotted this when working on updating my test suite for LUO. This seems
> > to be a leftover from a previous version. I don't see it being used
> > anywhere in the code.
>
> thank you will remove this.
>
> > Also, I think the model we should have is to only allow new sessions in
> > normal state. Currently luo_session_create() allows creating a new
> > session in updated state. This would end up mixing sessions from a
> > previous boot and sessions from current boot. I don't really see a
> > reason for that and I think the userspace should first call finish
> > before starting new serialization. Keeps things simpler.
>
> It does. However, yesterday Jason Gunthorpe suggested that we simplify
> the uapi, at least for the initial landing, by removing the state
> machine during boot and allowing new sessions to be created at any
> time. This would also mean separating the incoming and outgoing
> sessions and removing the ioctl() call used to bring the machine into
> a normal state; instead, only individual sessions could be brought
> into a 'normal' state.
>
> Simplified uAPI Proposal
> The simplest uAPI would look like this:
> IOCTLs on /dev/liveupdate (to create and retrieve session FDs):
> LIVEUPDATE_IOCTL_CREATE_SESSION
> LIVEUPDATE_IOCTL_RETRIEVE_SESSION
>
> IOCTLs on session FDs:
> LIVEUPDATE_CMD_SESSION_PRESERVE_FD
> LIVEUPDATE_CMD_SESSION_RETRIEVE_FD
> LIVEUPDATE_CMD_SESSION_FINISH
>
> Happy Path
> The happy path would look like this:
> - luod creates a session with a specific name and passes it to the vmm.
> - The vmm preserves FDs in a specific order: memfd, iommufd, vfiofd.
> (If the order is wrong, the preserve callbacks will fail.)
> - A reboot(KEXEC) is performed.
> - Each session receives a freeze() callback to notify it that
> mutations are no longer possible.
> - During boot, liveupdate_fh_global_state_get(&h, &obj) can be used to
> retrieve the global state.
> - Once the machine has booted, luod retrieves the incoming sessions
> and passes them to the vmms.
> - The vmm retrieves the FDs from the session and performs the
> necessary IOCTLs on them.
> - The vmm calls LIVEUPDATE_CMD_SESSION_FINISH on the session. Each FD
> receives a finish() callback in LIFO order.
> - If everything succeeds, the session becomes an empty "outgoing"
> session. It can then be closed and discarded or reused for the next
> live update by preserving new FDs into it.
> - Once the last FD for a file-handler is finished,
> h->ops->global_state_finish(h, h->global_state_obj) is called to
> finish the incoming global state.
>
> Unhappy Paths
> - If an outgoing session FD is closed, each FD in that session
> receives an unpreserve callback in LIFO order.
> - If the last FD for a global state is unpreserved,
> h->ops->global_state_unpreserve(h, h->global_state_obj) is called.
> - If freeze() fails, a cancel() is performed on each FD that received
> freeze() cb, and reboot(KEXEC) returns a failure.

nit: Maybe we can rename cancel to unfreeze. So it matches preserve/unprese=
rve?
> - If an incoming session FD is closed, the resources are considered
> "leaked." They are discarded only during the next live-update; this is
> intended to prevent implementing rare and untested clean-up code.

I am assuming the preserved folios will become unpreserved during
shutdown and in the next kernel those folios are free.
> - If a user tries to finish a session and it fails, it is considered
> the user's problem. This might happen because some IOCTLs still need
> to be run on the retrieved FDs to bring them to a state where finish
> is possible.

Sounds great.
>
> This would also mean that subsystems would not be needed, leaving only
> FLB (File-Lifecycle-Bound Global State) to use as a handle for global
> state. The API I am proposing for FLB keeps the same global state for
> a single file-handler type. However, HugeTLB might have multiple file
> handlers, so the API would need to be extended slightly to support
> this case. Multiple file handlers will share the same global resource
> with the same callbacks.
>
> Pasha
>
> > > + * @reserved: Must be zero.
> > > + * @state:    Output; The live update state of this FD.
> > > + *
> > > + * Query the current live update state of a specific preserved file =
descriptor.
> > > + *
> > > + * - %LIVEUPDATE_STATE_NORMAL:   Default state
> > > + * - %LIVEUPDATE_STATE_PREPARED: Prepare callback has been performed=
 on this FD.
> > > + * - %LIVEUPDATE_STATE_FROZEN:   Freeze callback ahs been performed =
on this FD.
> > > + * - %LIVEUPDATE_STATE_UPDATED:  The system has successfully reboote=
d into the
> > > + *                               new kernel.
> > > + *
> > > + * See the definition of &enum liveupdate_state for more details on =
each state.
> > > + *
> > > + * Return: 0 on success, negative error code on failure.
> > > + */
> > > +struct liveupdate_session_get_state {
> > > +     __u32           size;
> > > +     __u8            incoming;
> > > +     __u8            reserved[3];
> > > +     __u32           state;
> > > +};
> > > +
> > > +#define LIVEUPDATE_SESSION_GET_STATE                                =
 \
> > > +     _IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_STATE)
> > [...]
> >
> > --
> > Regards,
> > Pratyush Yadav

