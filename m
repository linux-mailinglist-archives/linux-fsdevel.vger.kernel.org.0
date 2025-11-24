Return-Path: <linux-fsdevel+bounces-69621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74340C7EFB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 06:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FC33A3261
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 05:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00B82D0C72;
	Mon, 24 Nov 2025 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGWFz4wk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0568B29D29A;
	Mon, 24 Nov 2025 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763960893; cv=none; b=PNIN7NN0a7aQZ/HCLUdhnrw6h0FvCxJACoRe2+d+U+t8RhZ82DoY872gYwUUkBHuUm9vnk8CNUY8ILjEMCsfSLFPNyWsOLUbstzJuzuFq6lpcwH41egxmY9Ob4Poq12pQEYlCEZzYDcmnrE3acfhICNQdmPpsWeVHOVDVp4hTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763960893; c=relaxed/simple;
	bh=hieoIPxIhRSooVrU3/2wVozJyRs1qMXLmzpW8xV1wzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rpr3vdwRU1szvrOanwMZ4JycVih+/gN0PpI7ePJFcaM915mFjtqBc5W5VhCXwa2rCy/kFtl+4qorO567NdY9uQZ3bXaupFyz306N2/LRf+djnve+Z5iysTxV1GoK6DZwjliQfO/Mbw33oXcZWhDTRGb16dvg8FGEj/zl0BfsbQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGWFz4wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463A1C4CEF1;
	Mon, 24 Nov 2025 05:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763960891;
	bh=hieoIPxIhRSooVrU3/2wVozJyRs1qMXLmzpW8xV1wzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGWFz4wkyghWCM5P7ckMfeF1ztZvSWtS2QEwkzMCzyzCVgtFKGEkLgJqy/viT440v
	 yaLEfYvDaQKnLSy6uR+9I+i+ZINn7SDTB+/qX8KrflY1cjgOHRmknnXDOV/u0/FvGu
	 NNUNwqZ/xrD2U3CUlUTED32zlbalE8ApcvCTVV7fCZM+JTWXoXtS4lzsdcfGlmNLAZ
	 /qzpXLU7vNgOw/YDtFTUPhAuvbAOle9zzBCqJRbhAWlNE1Pbz9cKm2a0gIDY1NPbmC
	 0aQfUTilZ7Bh0ou+L5xM7SHml4e2W0OPll/Ctzpic/zP4fsRsIy5pDrE+VWMcYh228
	 +PoEtTeYVePdw==
Date: Mon, 24 Nov 2025 07:07:47 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v7 01/22] liveupdate: luo_core: Live Update Orchestrator
Message-ID: <aSPoIw2keoueM2q8@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-2-pasha.tatashin@soleen.com>
 <aSLsCxLhrnyUlcy4@kernel.org>
 <CA+CK2bCN7x=eMwfTXF-2+vR=Gn3=41z6Xxx6wM1m7i-rxzug9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCN7x=eMwfTXF-2+vR=Gn3=41z6Xxx6wM1m7i-rxzug9w@mail.gmail.com>

On Sun, Nov 23, 2025 at 07:15:44AM -0500, Pasha Tatashin wrote:
> On Sun, Nov 23, 2025 at 6:12 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Sat, Nov 22, 2025 at 05:23:28PM -0500, Pasha Tatashin wrote:
> > > Introduce LUO, a mechanism intended to facilitate kernel updates while
> > > keeping designated devices operational across the transition (e.g., via
> > > kexec). The primary use case is updating hypervisors with minimal
> > > disruption to running virtual machines. For userspace side of hypervisor
> > > update we have copyless migration. LUO is for updating the kernel.
> > >
> > > This initial patch lays the groundwork for the LUO subsystem.
> > >
> > > Further functionality, including the implementation of state transition
> > > logic, integration with KHO, and hooks for subsystems and file
> > > descriptors, will be added in subsequent patches.
> > >
> > > Create a character device at /dev/liveupdate.
> > >
> > > A new uAPI header, <uapi/linux/liveupdate.h>, will define the necessary
> > > structures. The magic number for IOCTL is registered in
> > > Documentation/userspace-api/ioctl/ioctl-number.rst.
> > >
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> >
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Thank you
> 
> >
> > with a few nits below
> >
> > > ---
> >
> > > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> > > index a973a54447de..90857dccb359 100644
> > > --- a/kernel/liveupdate/Kconfig
> > > +++ b/kernel/liveupdate/Kconfig
> > > @@ -1,4 +1,10 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > > +#
> > > +# Copyright (c) 2025, Google LLC.
> > > +# Pasha Tatashin <pasha.tatashin@soleen.com>
> > > +#
> > > +# Live Update Orchestrator
> > > +#
> >
> > If you are adding copyrights it should have Amazon and Microsoft as well.
> > I believe those from kexec_handover.c would work.
> >
> > @Alex?
> 
> Sure, or I can remove all of them from Kconfig, whatever you prefer :-)

Quick grepping shows that the vast majority of Kconfigs does not have
copyright, let's just drop it.

> > >  menu "Live Update and Kexec HandOver"
> > >       depends on !DEFERRED_STRUCT_PAGE_INIT
> > > @@ -51,4 +57,25 @@ config KEXEC_HANDOVER_ENABLE_DEFAULT
> > >         The default behavior can still be overridden at boot time by
> > >         passing 'kho=off'.
> > >
> > > +config LIVEUPDATE
> > > +     bool "Live Update Orchestrator"
> > > +     depends on KEXEC_HANDOVER
> > > +     help
> > > +       Enable the Live Update Orchestrator. Live Update is a mechanism,
> > > +       typically based on kexec, that allows the kernel to be updated
> > > +       while keeping selected devices operational across the transition.
> > > +       These devices are intended to be reclaimed by the new kernel and
> > > +       re-attached to their original workload without requiring a device
> > > +       reset.
> > > +
> > > +       Ability to handover a device from current to the next kernel depends
> > > +       on specific support within device drivers and related kernel
> > > +       subsystems.
> >
> > Sorry, somehow this slipped during v6 review.
> > These days LUO is less about devices and more about file descriptors :)
> 
> Device preservation through file descriptors: memfd, iommufd, vfiofd
> are all dependencies for preserving devices.
> 
> That Kconfig description is correct and essential because the core
> complexity of the LUO is the preservation of device state and I/O
> across a kernel transition, which is a harder problem than just
> preserving memory or files, for that we could have used a file system
> instead of inventing something new with logic of can_preserve() etc.
> 
> Device preservation requires exactly what is stated in the description
> for this config:
> "Ability to handover a device from current to the next kernel depends
> on specific support within device drivers and related kernel
> subsystems." The only subsystem that is getting upstreamed with this
> series is MEMFD, it is a hard pre-requirement for iommufd
> preservation; the other subsystems: VFIO, PCI, IOMMU are WIP.
 
Ok.

-- 
Sincerely yours,
Mike.

