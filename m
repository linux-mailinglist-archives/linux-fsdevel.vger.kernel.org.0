Return-Path: <linux-fsdevel+bounces-68957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F1C6A63A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72DBC34E39C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AD621FF25;
	Tue, 18 Nov 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct0PkeIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445FB34DB64;
	Tue, 18 Nov 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480773; cv=none; b=T0/zecAvguTT+E35ZX8zwLTLGr6MnQCsPIZn91FZs1+u1TohUMTs+uq6iYTtH71BhTfqtzsGKCtd39QJ6rNe1hZ/ecWXlThCvBmyVjKZnJwXbOjgyz1AmsIVLybMsXuRymbWCH/cS1TNiH0GMP/BSO+VgEFLKsQq6anJMb4frEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480773; c=relaxed/simple;
	bh=NvD+wD7hmOypGfZvut1BGQBiSML9gfkbHDd/jrJynOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V7V+XUXRhVnSrGv0LWwRgxLA1O7z1L2nKVPCmscngQ3oNqImQBTBUP5fpb6RBdEQp99Cp1OsSA0He4yV0kcylR8FurFIBmjn08lVU0s2W8CyLZgEGV/OwfGNhGcImUNNhB51g+LX9ZnvS/LvDrA73GbTVWMYPtXZJMH9i5bFL5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct0PkeIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA31C2BCB3;
	Tue, 18 Nov 2025 15:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480771;
	bh=NvD+wD7hmOypGfZvut1BGQBiSML9gfkbHDd/jrJynOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ct0PkeIs59PlX7LBGwYra2RgxeAFbO3eu3CW387XaQ0vnkjlGKnXy1w+S0G/oOYtF
	 3ZEbbLXi1D05J9bfC9Kp3vmdRxAT/lXrLySZHirFUBiRot+9TB2RrRq26O7Vyp+RfT
	 gNP+w3+ra/xuIrI2I1+G366IiaCHP516oJrICW32YHHy2eRDL990BKAN74RCPNZofw
	 fpDz1EdIYhN3k5zNwgWwtSRzGcmztFet9HWsWS4eqFTwcAMlf1L0X+iaqRkb9oxm/M
	 p287zHialGlUvSLnD7038deHegCI7IXtkUuXEri/bq2MleKqO/m3O6QK9Fw7NLVrbR
	 +OOcRa9wAkakg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org
Subject: Re: [PATCH v6 01/20] liveupdate: luo_core: luo_ioctl: Live Update
 Orchestrator
In-Reply-To: <20251115233409.768044-2-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 15 Nov 2025 18:33:47 -0500")
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
	<20251115233409.768044-2-pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 16:45:57 +0100
Message-ID: <mafs0ecpv4a4q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 15 2025, Pasha Tatashin wrote:

> Introduce LUO, a mechanism intended to facilitate kernel updates while
> keeping designated devices operational across the transition (e.g., via
> kexec). The primary use case is updating hypervisors with minimal
> disruption to running virtual machines. For userspace side of hypervisor
> update we have copyless migration. LUO is for updating the kernel.
>
> This initial patch lays the groundwork for the LUO subsystem.
>
> Further functionality, including the implementation of state transition
> logic, integration with KHO, and hooks for subsystems and file
> descriptors, will be added in subsequent patches.
>
> Create a character device at /dev/liveupdate.
>
> A new uAPI header, <uapi/linux/liveupdate.h>, will define the necessary
> structures. The magic number for IOCTL is registered in
> Documentation/userspace-api/ioctl/ioctl-number.rst.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[...]
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> new file mode 100644
> index 000000000000..0e1ab19fa1cd
> --- /dev/null
> +++ b/kernel/liveupdate/luo_core.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +/**
> + * DOC: Live Update Orchestrator (LUO)
> + *
> + * Live Update is a specialized, kexec-based reboot process that allows a
> + * running kernel to be updated from one version to another while preserving
> + * the state of selected resources and keeping designated hardware devices
> + * operational. For these devices, DMA activity may continue throughout the
> + * kernel transition.
> + *
> + * While the primary use case driving this work is supporting live updates of
> + * the Linux kernel when it is used as a hypervisor in cloud environments, the
> + * LUO framework itself is designed to be workload-agnostic. Much like Kernel
> + * Live Patching, which applies security fixes regardless of the workload,
> + * Live Update facilitates a full kernel version upgrade for any type of system.

Nit: I think live update is very different from live patching. It has
very different limitations and advantages. In fact, I view live patching
and live update on two opposite ends of the "applying security patches"
spectrum. I think this line is going to mislead or confuse people.

I think it would better to either spend more lines explaining the
difference between the two, or just drop it from here.

> + *
> + * For example, a non-hypervisor system running an in-memory cache like
> + * memcached with many gigabytes of data can use LUO. The userspace service
> + * can place its cache into a memfd, have its state preserved by LUO, and
> + * restore it immediately after the kernel kexec.
> + *
> + * Whether the system is running virtual machines, containers, a
> + * high-performance database, or networking services, LUO's primary goal is to
> + * enable a full kernel update by preserving critical userspace state and
> + * keeping essential devices operational.
> + *
> + * The core of LUO is a mechanism that tracks the progress of a live update,
> + * along with a callback API that allows other kernel subsystems to participate
> + * in the process. Example subsystems that can hook into LUO include: kvm,
> + * iommu, interrupts, vfio, participating filesystems, and memory management.
> + *
> + * LUO uses Kexec Handover to transfer memory state from the current kernel to
> + * the next kernel. For more details see
> + * Documentation/core-api/kho/concepts.rst.
> + */
> +
[...]
> diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioctl.c
> new file mode 100644
> index 000000000000..44d365185f7c
> --- /dev/null
> +++ b/kernel/liveupdate/luo_ioctl.c
[...]
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Pasha Tatashin");
> +MODULE_DESCRIPTION("Live Update Orchestrator");
> +MODULE_VERSION("0.1");

Nit: do we really need the module version? I don't think LUO can even be
used as a module. What does this number mean then?

Other than these two nitpicks,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

