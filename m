Return-Path: <linux-fsdevel+bounces-57084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA40B1E991
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA285A077A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290212CDA5;
	Fri,  8 Aug 2025 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GQWzPOC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA1126C03
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661169; cv=none; b=UDW4MCLinhlWgOPWHDgm7TikHa1VcKJWieksCXR0kFxtG7ZwFhE84WcggEWUmqkMugxC5kmwyIUH4KpJCs81eIfq9SauNlOLpTXtTn3HzMtEwqpA2T/jJ513oKfHDm2nzHm1/kuMh+NpAb51ijwla/OghIvy1M3m4eC+PepaulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661169; c=relaxed/simple;
	bh=/phiuRu5p1X263GZfYLWvs+0gJIAThibFvV6rDhANj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKks/L1reK3VDehW1yLTha8FFOx0qjYJclv7sqvzepkiYGeDK11g4rO68MQKYxtD58Y/xB+urX8tc/uxiugBe4xYr1U0Cj8g/UCcWlKdIB51AsuKcaHIv+0Y6DtAiGzMdQmhpNefwVFn5qPAw6BTAPbM7tkTT0gKdGYr8oTqV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=GQWzPOC0; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b064e94400so27677901cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754661165; x=1755265965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWuSm/n+x6UmSbenhuChDI181POgLouqBLmIRKho6Y8=;
        b=GQWzPOC0OL9E6k+XWGZiOzDqUTgCk+pMz3VP1SgeRWHZMCWGsYBAsLuigRmoNFSZaT
         g+3/dUerIytxx+j+7D9Q2fP+HKAxxqyYV8BcUkr9612c9B5p8GfhivzhfZVfmeziOAo8
         ry/s0eFxPKdwvvqxGLxYrk0JRwD7TIsEMSEyI9CIGtrL7o1PpHv0F1baywXOyyOd2w4l
         Kbh7BPTo+Mjun/ZQzGxqRjp9/3946VYI9RVuquXp1Jract4r6ngi/5uxBOIjX/Cm406D
         Fr9ASn85dYL0tICuLV0yieuzhIRoJwSf4x4+Kocmy34EPh94thfy/ZfOhuqF40xrNbr+
         CyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661165; x=1755265965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWuSm/n+x6UmSbenhuChDI181POgLouqBLmIRKho6Y8=;
        b=HypBaFO+QYri7aMQynWgsth78EPfS99YG1RC/FDUPkWjP/O31PJXkjIy2FY39NaX0/
         TKa2+4+z4Xx5jZ0c4TanM+kQve2I9sQAJfu1FXd8Y01MJe7z6l1fVVCYVOyqXSwXgU6A
         5Krv5HuSIhTx+0SL77/ptKmJbo7bmHQUOzfcv32vLNzYWvuzRPNy/ZHof5Swb0+RBSoL
         DngC4UXx3akWkIDVbtllgmptbjnT0s0PRl0Awqq8QPIAoM2uHDyY8/j1Q5zwrQPUX/nO
         ObrZuagGru8p19V7d33Mge5nYW9vxZEakloqG9ncMk6IEXJN1EEK+mDGU7vIi102/YVy
         lASw==
X-Forwarded-Encrypted: i=1; AJvYcCXHSSwUCj59ghJ2iG7vIxCuZ1ZwEiTLxzEEcbVgPue8pDqHUthtHMYrLQQLMW7PRPnABCjMDNM6aRXZNn4T@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+z+vvOZ1w/K9fU+2sI5xHglHHh9BifnZRITkeqwb/3f2AXeg
	xXhP2sIZ1xVhuaOODmIkoVKqm5i88HUlp55ZELb8ebAy5q2Qi0cBJ+XcNQYCAg8nAvMrd9I4cGL
	1YppJUpOIOROpqrfcJc1JXnq3jYI5Qer/bnQ2IIkhvQ==
X-Gm-Gg: ASbGnctPvx/4o3pqMefpeetWcrhf1rEPX+ck60qF1KA94gZPTAVJqc61Yb2uSUNbKKr
	7QCHIW0aTqxC15V+NfSZLikDd3gbv9D5Y3nh0QV4bQkpRpcaHr4hM60HcTkO0nfE3wlGKnbaEtN
	DVxkBXyhKJ+me84GSTLnnP3owksRHtIA6ONWaQVlq+KGQ2iSnZI9p9qUOzQ30ds9DxpCHCSTZNz
	jgI
X-Google-Smtp-Source: AGHT+IHO5jWq2R+C8O5R0Fm2lL7gLcJpGW7g9n82qYxS65FLgaiPl7bc5Ibupu3yaSPySLQfW9SenpAn90221JpxA8E=
X-Received: by 2002:ac8:7d89:0:b0:4b0:8092:9918 with SMTP id
 d75a77b69052e-4b0aec614dfmr42016261cf.1.1754661165053; Fri, 08 Aug 2025
 06:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com> <b227482a-31ec-4c92-a856-bd19f72217b7@redhat.com>
In-Reply-To: <b227482a-31ec-4c92-a856-bd19f72217b7@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 8 Aug 2025 13:52:08 +0000
X-Gm-Features: Ac12FXyoXpYy06IoMQTlfI4PNRF-wgM5UcLDQBO-MIGYnp5DILElI_szjslsn1M
Message-ID: <CA+CK2bCUXszEadZeBvmjJSEPH2NMi_KZA9o3Nvc6WiMBBE=Hfw@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
To: David Hildenbrand <david@redhat.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 12:07=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 07.08.25 03:44, Pasha Tatashin wrote:
> > This series introduces the LUO, a kernel subsystem designed to
> > facilitate live kernel updates with minimal downtime,
> > particularly in cloud delplyoments aiming to update without fully
> > disrupting running virtual machines.
> >
> > This series builds upon KHO framework by adding programmatic
> > control over KHO's lifecycle and leveraging KHO for persisting LUO's
> > own metadata across the kexec boundary. The git branch for this series
> > can be found at:
> >
> > https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3
> >
> > Changelog from v2:
> > - Addressed comments from Mike Rapoport and Jason Gunthorpe
> > - Only one user agent (LiveupdateD) can open /dev/liveupdate
> > - Release all preserved resources if /dev/liveupdate closes
> >    before reboot.
> > - With the above changes, sessions are not needed, and should be
> >    maintained by the user-agent itself, so removed support for
> >    sessions.
> > - Added support for changing per-FD state (i.e. some FDs can be
> >    prepared or finished before the global transition.
> > - All IOCTLs now follow iommufd/fwctl extendable design.
> > - Replaced locks with guards
> > - Added a callback for registered subsystems to be notified
> >    during boot: ops->boot().
> > - Removed args from callbacks, instead use container_of() to
> >    carry context specific data (see luo_selftests.c for example).
> > - removed patches for luolib, they are going to be introduced in
> >    a separate repository.
> >
> > What is Live Update?
> > Live Update is a kexec based reboot process where selected kernel
> > resources (memory, file descriptors, and eventually devices) are kept
> > operational or their state preserved across a kernel transition. For
> > certain resources, DMA and interrupt activity might continue with
> > minimal interruption during the kernel reboot.
> >
> > LUO provides a framework for coordinating live updates. It features:
> > State Machine: Manages the live update process through states:
> > NORMAL, PREPARED, FROZEN, UPDATED.
> >
> > KHO Integration:
> >
> > LUO programmatically drives KHO's finalization and abort sequences.
> > KHO's debugfs interface is now optional configured via
> > CONFIG_KEXEC_HANDOVER_DEBUG.
> >
> > LUO preserves its own metadata via KHO's kho_add_subtree and
> > kho_preserve_phys() mechanisms.
> >
> > Subsystem Participation: A callback API liveupdate_register_subsystem()
> > allows kernel subsystems (e.g., KVM, IOMMU, VFIO, PCI) to register
> > handlers for LUO events (PREPARE, FREEZE, FINISH, CANCEL) and persist a
> > u64 payload via the LUO FDT.
> >
> > File Descriptor Preservation: Infrastructure
> > liveupdate_register_filesystem, luo_register_file, luo_retrieve_file to
> > allow specific types of file descriptors (e.g., memfd, vfio) to be
> > preserved and restored.
> >
> > Handlers for specific file types can be registered to manage their
> > preservation and restoration, storing a u64 payload in the LUO FDT.
> >
> > User-space Interface:
> >
> > ioctl (/dev/liveupdate): The primary control interface for
> > triggering LUO state transitions (prepare, freeze, finish, cancel)
> > and managing the preservation/restoration of file descriptors.
> > Access requires CAP_SYS_ADMIN.
> >
> > sysfs (/sys/kernel/liveupdate/state): A read-only interface for
> > monitoring the current LUO state. This allows userspace services to
> > track progress and coordinate actions.
> >
> > Selftests: Includes kernel-side hooks and userspace selftests to
> > verify core LUO functionality, particularly subsystem registration and
> > basic state transitions.
> >
> > LUO State Machine and Events:
> >
> > NORMAL:   Default operational state.
> > PREPARED: Initial preparation complete after LIVEUPDATE_PREPARE
> >            event. Subsystems have saved initial state.
> > FROZEN:   Final "blackout window" state after LIVEUPDATE_FREEZE
> >            event, just before kexec. Workloads must be suspended.
> > UPDATED:  Next kernel has booted via live update. Awaiting restoration
> >            and LIVEUPDATE_FINISH.
> >
> > Events:
> > LIVEUPDATE_PREPARE: Prepare for reboot, serialize state.
> > LIVEUPDATE_FREEZE:  Final opportunity to save state before kexec.
> > LIVEUPDATE_FINISH:  Post-reboot cleanup in the next kernel.
> > LIVEUPDATE_CANCEL:  Abort prepare or freeze, revert changes.
> >
> > v2: https://lore.kernel.org/all/20250723144649.1696299-1-pasha.tatashin=
@soleen.com
> > v1: https://lore.kernel.org/all/20250625231838.1897085-1-pasha.tatashin=
@soleen.com
> > RFC v2: https://lore.kernel.org/all/20250515182322.117840-1-pasha.tatas=
hin@soleen.com
> > RFC v1: https://lore.kernel.org/all/20250320024011.2995837-1-pasha.tata=
shin@soleen.com
> >
> > Changyuan Lyu (1):
> >    kho: add interfaces to unpreserve folios and physical memory ranges
> >
> > Mike Rapoport (Microsoft) (1):
> >    kho: drop notifiers
> >
> > Pasha Tatashin (23):
> >    kho: init new_physxa->phys_bits to fix lockdep
> >    kho: mm: Don't allow deferred struct page with KHO
> >    kho: warn if KHO is disabled due to an error
> >    kho: allow to drive kho from within kernel
> >    kho: make debugfs interface optional
> >    kho: don't unpreserve memory during abort
> >    liveupdate: kho: move to kernel/liveupdate
> >    liveupdate: luo_core: luo_ioctl: Live Update Orchestrator
> >    liveupdate: luo_core: integrate with KHO
> >    liveupdate: luo_subsystems: add subsystem registration
> >    liveupdate: luo_subsystems: implement subsystem callbacks
> >    liveupdate: luo_files: add infrastructure for FDs
> >    liveupdate: luo_files: implement file systems callbacks
> >    liveupdate: luo_ioctl: add userpsace interface
> >    liveupdate: luo_files: luo_ioctl: Unregister all FDs on device close
> >    liveupdate: luo_files: luo_ioctl: Add ioctls for per-file state
> >      management
> >    liveupdate: luo_sysfs: add sysfs state monitoring
> >    reboot: call liveupdate_reboot() before kexec
> >    kho: move kho debugfs directory to liveupdate
> >    liveupdate: add selftests for subsystems un/registration
> >    selftests/liveupdate: add subsystem/state tests
> >    docs: add luo documentation
> >    MAINTAINERS: add liveupdate entry
> >
> > Pratyush Yadav (5):
> >    mm: shmem: use SHMEM_F_* flags instead of VM_* flags
> >    mm: shmem: allow freezing inode mapping
> >    mm: shmem: export some functions to internal.h
> >    luo: allow preserving memfd
> >    docs: add documentation for memfd preservation via LUO
>
> It's not clear from the description why these mm shmem changes are
> buried in this patch set. It's not even described above in the patch
> description.

Hi David,

Yes, I should update the cover letter to include memfd preservation work.

> I suggest sending that part out separately, so Hugh actually spots this.
> (is he even CC'ed?)

+cc hughd@google.com

While MM list is CCed, you are right, I have not specifically CCed
shmem maintainers. This will be fixed in the next revision.

Thank you,
Pasha

