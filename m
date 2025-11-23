Return-Path: <linux-fsdevel+bounces-69507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E73C7DFF1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 12:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43D3A3493C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 11:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AAD2D2486;
	Sun, 23 Nov 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD70297O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353392D3A75;
	Sun, 23 Nov 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763896356; cv=none; b=jYxILhmL8hPcmyyx6Lti1qdtGKkJTqQW8iAT+zO0ha6emvXEUNXuwoWNkJGuUVu+NgCMUPy27L+OcuQXT7s3YL8dAOrt4O6t26j8HCVHQ079YGizuyTk+TwsWXazII1ij6r3G7N5pMJowwkvEs2HFJas+rwhG0fMHzCj4vah514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763896356; c=relaxed/simple;
	bh=Akr26sM3VEhR3kKN7o52n5Q0IG8yNVh9gdExmJrI8ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVBt9oqwW6LsNEBgBTw4S0efT0AJw1W90CBI2rPCib8qbWIdVpKj+GjNQYmS++C19/YDjx680D80DJBdO8JBmozoI3BMoVCTT7GjFFaxZ3Xce178YUT0RgLk5ndQgWJxMHR0OA+/LX+2pDMjexMSnE0a2fDIwl6tFMta8thOASI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DD70297O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E672EC113D0;
	Sun, 23 Nov 2025 11:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763896355;
	bh=Akr26sM3VEhR3kKN7o52n5Q0IG8yNVh9gdExmJrI8ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DD70297OscX5jW+1bL2L8Z5+6LxRLvMSuqNcQmzITuFPIzMzmkRtlD/mIf3T2D858
	 mLjthfkdI3QvX5wzmOddr/fDz3ZYEbjtxPo1YEND1/rowOhEwrqrpzC2boUYmSqpWC
	 LJa9Y4iSUVo8vPl4T49RkU+H90guNy7wohSE0KXct5W8r9dxLkD1p0m6pifzJ+NS+d
	 gQ4atTXM+NBkfw97j9VlyFdkIVV9vi3HLQHWP2WLZ7acpq+JnxntA0ebpsXBDISpJN
	 uF6MX92LSt9PIFptSK1yfDhmlyBzzfbfcjg9RYfN9IA5CBhLECVurLPXjqk1yT2SZV
	 LiaEhMRjyjibg==
Date: Sun, 23 Nov 2025 13:12:11 +0200
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
Message-ID: <aSLsCxLhrnyUlcy4@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-2-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:28PM -0500, Pasha Tatashin wrote:
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
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

with a few nits below

> ---

> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index a973a54447de..90857dccb359 100644
> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -1,4 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (c) 2025, Google LLC.
> +# Pasha Tatashin <pasha.tatashin@soleen.com>
> +#
> +# Live Update Orchestrator
> +#

If you are adding copyrights it should have Amazon and Microsoft as well.
I believe those from kexec_handover.c would work.

@Alex?

>  menu "Live Update and Kexec HandOver"
>  	depends on !DEFERRED_STRUCT_PAGE_INIT
> @@ -51,4 +57,25 @@ config KEXEC_HANDOVER_ENABLE_DEFAULT
>  	  The default behavior can still be overridden at boot time by
>  	  passing 'kho=off'.
>  
> +config LIVEUPDATE
> +	bool "Live Update Orchestrator"
> +	depends on KEXEC_HANDOVER
> +	help
> +	  Enable the Live Update Orchestrator. Live Update is a mechanism,
> +	  typically based on kexec, that allows the kernel to be updated
> +	  while keeping selected devices operational across the transition.
> +	  These devices are intended to be reclaimed by the new kernel and
> +	  re-attached to their original workload without requiring a device
> +	  reset.
> +
> +	  Ability to handover a device from current to the next kernel depends
> +	  on specific support within device drivers and related kernel
> +	  subsystems.

Sorry, somehow this slipped during v6 review.
These days LUO is less about devices and more about file descriptors :) 

> +
> +	  This feature primarily targets virtual machine hosts to quickly update
> +	  the kernel hypervisor with minimal disruption to the running virtual
> +	  machines.
> +
> +	  If unsure, say N.
> +
>  endmenu

-- 
Sincerely yours,
Mike.

