Return-Path: <linux-fsdevel+bounces-66485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2D0C20B93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 15:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA611A2205A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C15A2773F9;
	Thu, 30 Oct 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bJb3QitF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF41AF0AF
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835548; cv=none; b=TQGpmMLTs7KUzPpUsPnJ6OajYVtpUxUerAf+T5fVCkFSNEw+jaHKvrX15FCOc/4Cr+hHHLbXYwvcX6MRKjkVVa1AxsUylNtHUWEJgF9LPGq8J3iy3WaJyJ02TQ4D2ALVFn5BHLh6vNgUZzc3xkfrLTlnGpZbxzT1BztHUPR4bnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835548; c=relaxed/simple;
	bh=5JpbSHuKX2plvI1/zl+khhJC6C3X1JNbIvIqp8OFli4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6iaFiAIko193HLW/LX0ACJiQrAFuP44YtQL1RWnLHZe0fZoWzGgPGr3WfJ4aD/qbKPaDN6h/ONoejgAB3PBDY6fa/vRahzqxVmorgc2V+NenCzQB2v9nJWWyo1kH3/5B6BuiWVCZlz2CYrbrAgfBbEGZC5fkMCsxerPIfiLXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bJb3QitF; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c45c11be7so1850631a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761835544; x=1762440344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+q1WnNkV6oI/Ffptxas5/IbEl8V9x7m1lbLHWaOLlOc=;
        b=bJb3QitFCcMsmo0qprz+Tbed9ckO1I7N0cJY7SUdAUc+HeFTihNgAkypRMQKGpqQ1u
         3nvK7edZzj0aBX7VpBZ2n9dpDO2x7oT9SPlLauCEhxf15glyhd5g4Olf3OpZpkuP8Q4n
         EOapPIVFlB3Cm7DAs8KUyN7yoVfZalDT6EHtwxCUdY2gqqhfoK5dj1pjQ8cRS8FHiGYU
         J0DwQSMAlc/hfKdh0N27cgJHqbyfpbRUHWKFP0wMEwBlihuhtL3AQh1y3DJU+/qA04EQ
         ApPBNnz1IhuAIIw6Tt621B7SHxEVcDu74oxVj8qOBunHXa70j1AYYwyLDIyOI46e6gny
         YyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761835544; x=1762440344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+q1WnNkV6oI/Ffptxas5/IbEl8V9x7m1lbLHWaOLlOc=;
        b=igPbtVj+iBJi6w8swcwUbDx5TEjGRrDr6iltdLdtHq6cuTjp2xW9Oew9bepufIoA39
         54yMX9c3yhqWtekJhtQMCIUaVDn9L/D+ZJIO6+mZFEHDoJliKlk818IRPUqecJ5rXDYC
         khGsVtkrjwyItPiZhESPlscwGAefUZRBujJNccPk2bFfHAaWEZ8wGQgpoFDOM6vy4p4k
         9prH6npP39LsaLhhMUQ/VOh5NlbJVEPDLhHHho4DLNb6nDNugRexkdRmr28G3FtSu2jA
         NmQjPtlqrDuVhYBpyRGx51TG3FTrYf9Ua0UQqsrXWzsrfbNcgV24/ioF/VyOC6anDT9e
         fJCw==
X-Forwarded-Encrypted: i=1; AJvYcCUmSLscKFQ7HpuN8GO0Am66ieucs7FmNIOZWJ9Y17D8MgIrpPKFUJEkFL8JWKDaMVcT1T1Bi5juGs1fBfwI@vger.kernel.org
X-Gm-Message-State: AOJu0YyPgIv+Ne5h0hB+cslzexjgbQsD8B3hGyfAR2lRvDYBJrVR9x3c
	l8QIheleUWtHKRYDr/YoEboUzqXHSyq5c2rXjk7EcbnL9cvo7nNr0KAhZrot48cPFk/EIm7jhgR
	oBPEp8KrZilqThkrmuv7TXd4WO68GvGa0yaUnZ2/y/Q==
X-Gm-Gg: ASbGncs2Hrix3ePhIM8cftS4lEUFsw0ZWnt0HnIpuAU0HLPsG7KUlGHO9IdnHJZ3i58
	vE3X5GVlYSXu2cDUB3Fcs9CKkgT4tHDFU8QqLRJ/SCnmiG7TEIedbwUhlhhHWuRtgRpBasrE2Tz
	uNXIFafveAES2rfLeF80Sie2uvK4dElO/khHbBe2M6kGXDmVlPf2jsIIFRCgQBaxXSI0cMXa++F
	xRC2O5hvf3E8H2k1sMJ7G7+tOSHlsiH/U9X2xV6w1VKfjihdPWYrR20Bq9IGA6wRGxv
X-Google-Smtp-Source: AGHT+IGDU4/Gkv1R1qd17xLlVAOgOMmcUmYUsrlTksKyc7NoB+oWGvlCOuq9OeegwnOVOhMBaIm81jNVaYjX67APFf4=
X-Received: by 2002:a05:6402:d08:b0:63c:2d72:56e3 with SMTP id
 4fb4d7f45d1cf-64044252e1amr5523342a12.23.1761835543199; Thu, 30 Oct 2025
 07:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-15-pasha.tatashin@soleen.com> <mafs0tszhcyrw.fsf@kernel.org>
 <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com> <CAAywjhTbBx+rYGpPGtTw_--9XhoYZBX8ase5ddM6rxmC5J-2JQ@mail.gmail.com>
In-Reply-To: <CAAywjhTbBx+rYGpPGtTw_--9XhoYZBX8ase5ddM6rxmC5J-2JQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 30 Oct 2025 10:45:06 -0400
X-Gm-Features: AWmQ_blojHtPMG7BDXtmPjNBm90NSboe9qJfp5atDPpsuilsmQAVEvUy6gel7ys
Message-ID: <CA+CK2bC8Ge0WM84ei1JGpqTzsZXeP6B3VXbSiNW6ZmHmQsXHCg@mail.gmail.com>
Subject: Re: [PATCH v4 14/30] liveupdate: luo_session: Add ioctls for file
 preservation and state management
To: Samiullah Khawaja <skhawaja@google.com>
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

On Wed, Oct 29, 2025 at 6:00=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Wed, Oct 29, 2025 at 1:13=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Wed, Oct 29, 2025 at 3:07=E2=80=AFPM Pratyush Yadav <pratyush@kernel=
.org> wrote:
> > >
> > > Hi Pasha,
> > >
> > > On Mon, Sep 29 2025, Pasha Tatashin wrote:
> > >
> > > > Introducing the userspace interface and internal logic required to
> > > > manage the lifecycle of file descriptors within a session. Previous=
ly, a
> > > > session was merely a container; this change makes it a functional
> > > > management unit.
> > > >
> > > > The following capabilities are added:
> > > >
> > > > A new set of ioctl commands are added, which operate on the file
> > > > descriptor returned by CREATE_SESSION. This allows userspace to:
> > > > - LIVEUPDATE_SESSION_PRESERVE_FD: Add a file descriptor to a sessio=
n
> > > >   to be preserved across the live update.
> > > > - LIVEUPDATE_SESSION_UNPRESERVE_FD: Remove a previously added file
> > > >   descriptor from the session.
> > > > - LIVEUPDATE_SESSION_RESTORE_FD: Retrieve a preserved file in the
> > > >   new kernel using its unique token.
> > > >
> > > > A state machine for each individual session, distinct from the glob=
al
> > > > LUO state. This enables more granular control, allowing userspace t=
o
> > > > prepare or freeze specific sessions independently. This is managed =
via:
> > > > - LIVEUPDATE_SESSION_SET_EVENT: An ioctl to send PREPARE, FREEZE,
> > > >   CANCEL, or FINISH events to a single session.
> > > > - LIVEUPDATE_SESSION_GET_STATE: An ioctl to query the current state
> > > >   of a single session.
> > > >
> > > > The global subsystem callbacks (luo_session_prepare, luo_session_fr=
eeze)
> > > > are updated to iterate through all existing sessions. They now trig=
ger
> > > > the appropriate per-session state transitions for any sessions that
> > > > haven't already been transitioned individually by userspace.
> > > >
> > > > The session's .release handler is enhanced to be state-aware. When =
a
> > > > session's file descriptor is closed, it now correctly cancels or
> > > > finishes the session based on its current state before freeing all
> > > > associated file resources, preventing resource leaks.
> > > >
> > > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > [...]
> > > > +/**
> > > > + * struct liveupdate_session_get_state - ioctl(LIVEUPDATE_SESSION_=
GET_STATE)
> > > > + * @size:     Input; sizeof(struct liveupdate_session_get_state)
> > > > + * @incoming: Input; If 1, query the state of a restored file from=
 the incoming
> > > > + *            (previous kernel's) set. If 0, query a file being pr=
epared for
> > > > + *            preservation in the current set.
> > >
> > > Spotted this when working on updating my test suite for LUO. This see=
ms
> > > to be a leftover from a previous version. I don't see it being used
> > > anywhere in the code.
> >
> > thank you will remove this.
> >
> > > Also, I think the model we should have is to only allow new sessions =
in
> > > normal state. Currently luo_session_create() allows creating a new
> > > session in updated state. This would end up mixing sessions from a
> > > previous boot and sessions from current boot. I don't really see a
> > > reason for that and I think the userspace should first call finish
> > > before starting new serialization. Keeps things simpler.
> >
> > It does. However, yesterday Jason Gunthorpe suggested that we simplify
> > the uapi, at least for the initial landing, by removing the state
> > machine during boot and allowing new sessions to be created at any
> > time. This would also mean separating the incoming and outgoing
> > sessions and removing the ioctl() call used to bring the machine into
> > a normal state; instead, only individual sessions could be brought
> > into a 'normal' state.
> >
> > Simplified uAPI Proposal
> > The simplest uAPI would look like this:
> > IOCTLs on /dev/liveupdate (to create and retrieve session FDs):
> > LIVEUPDATE_IOCTL_CREATE_SESSION
> > LIVEUPDATE_IOCTL_RETRIEVE_SESSION
> >
> > IOCTLs on session FDs:
> > LIVEUPDATE_CMD_SESSION_PRESERVE_FD
> > LIVEUPDATE_CMD_SESSION_RETRIEVE_FD
> > LIVEUPDATE_CMD_SESSION_FINISH
> >
> > Happy Path
> > The happy path would look like this:
> > - luod creates a session with a specific name and passes it to the vmm.
> > - The vmm preserves FDs in a specific order: memfd, iommufd, vfiofd.
> > (If the order is wrong, the preserve callbacks will fail.)
> > - A reboot(KEXEC) is performed.
> > - Each session receives a freeze() callback to notify it that
> > mutations are no longer possible.
> > - During boot, liveupdate_fh_global_state_get(&h, &obj) can be used to
> > retrieve the global state.
> > - Once the machine has booted, luod retrieves the incoming sessions
> > and passes them to the vmms.
> > - The vmm retrieves the FDs from the session and performs the
> > necessary IOCTLs on them.
> > - The vmm calls LIVEUPDATE_CMD_SESSION_FINISH on the session. Each FD
> > receives a finish() callback in LIFO order.
> > - If everything succeeds, the session becomes an empty "outgoing"
> > session. It can then be closed and discarded or reused for the next
> > live update by preserving new FDs into it.
> > - Once the last FD for a file-handler is finished,
> > h->ops->global_state_finish(h, h->global_state_obj) is called to
> > finish the incoming global state.
> >
> > Unhappy Paths
> > - If an outgoing session FD is closed, each FD in that session
> > receives an unpreserve callback in LIFO order.
> > - If the last FD for a global state is unpreserved,
> > h->ops->global_state_unpreserve(h, h->global_state_obj) is called.
> > - If freeze() fails, a cancel() is performed on each FD that received
> > freeze() cb, and reboot(KEXEC) returns a failure.
>
> nit: Maybe we can rename cancel to unfreeze. So it matches preserve/unpre=
serve?

Sounds good, I will call it unfreeze() instead of cancel().

> > - If an incoming session FD is closed, the resources are considered
> > "leaked." They are discarded only during the next live-update; this is
> > intended to prevent implementing rare and untested clean-up code.
>
> I am assuming the preserved folios will become unpreserved during
> shutdown and in the next kernel those folios are free.

That is right, KHO does not keep memory preserved for the next reboot.

> > - If a user tries to finish a session and it fails, it is considered
> > the user's problem. This might happen because some IOCTLs still need
> > to be run on the retrieved FDs to bring them to a state where finish
> > is possible.
>
> Sounds great.
> >
> > This would also mean that subsystems would not be needed, leaving only
> > FLB (File-Lifecycle-Bound Global State) to use as a handle for global
> > state. The API I am proposing for FLB keeps the same global state for
> > a single file-handler type. However, HugeTLB might have multiple file
> > handlers, so the API would need to be extended slightly to support
> > this case. Multiple file handlers will share the same global resource
> > with the same callbacks.
> >
> > Pasha
> >
> > > > + * @reserved: Must be zero.
> > > > + * @state:    Output; The live update state of this FD.
> > > > + *
> > > > + * Query the current live update state of a specific preserved fil=
e descriptor.
> > > > + *
> > > > + * - %LIVEUPDATE_STATE_NORMAL:   Default state
> > > > + * - %LIVEUPDATE_STATE_PREPARED: Prepare callback has been perform=
ed on this FD.
> > > > + * - %LIVEUPDATE_STATE_FROZEN:   Freeze callback ahs been performe=
d on this FD.
> > > > + * - %LIVEUPDATE_STATE_UPDATED:  The system has successfully reboo=
ted into the
> > > > + *                               new kernel.
> > > > + *
> > > > + * See the definition of &enum liveupdate_state for more details o=
n each state.
> > > > + *
> > > > + * Return: 0 on success, negative error code on failure.
> > > > + */
> > > > +struct liveupdate_session_get_state {
> > > > +     __u32           size;
> > > > +     __u8            incoming;
> > > > +     __u8            reserved[3];
> > > > +     __u32           state;
> > > > +};
> > > > +
> > > > +#define LIVEUPDATE_SESSION_GET_STATE                              =
   \
> > > > +     _IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_STATE)
> > > [...]
> > >
> > > --
> > > Regards,
> > > Pratyush Yadav

