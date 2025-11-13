Return-Path: <linux-fsdevel+bounces-68270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9252C57C02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 881CC358AFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F5F21D3E6;
	Thu, 13 Nov 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2SPT7ui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F661DDC0B;
	Thu, 13 Nov 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041090; cv=none; b=h353iJQPWs9ZvdKOAY+jCEF8qv9lAy+rqV8jtsW+VvyBPH9cNtUYU9EfrdFnFqQ0Q08nQc9swWfEPxqKoTOgJ9YR5Xpsll6hwtmNHcNyF+pJidqYtXga+zv9mZxRy3oz1ODolUHX0kXmwhJuI9ggK+/DGwcBgJew+8kvkG2M30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041090; c=relaxed/simple;
	bh=TanqNDDou92JeIIiWS3c/wMf1Ii6b9BkUyE/vwk57VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omCKQHeYkFK7xPEaoxHGj9Vug4JLwub6xp9fcjrY5SslP+emC+c1JsJPZydAoQrLehj44U46VTNwqPBZv6HbCyoL7Q7PW5MsY5QLGfboMqOQ/MtLIgYXm0nap0OdQpmFl+xpajBRwi46Uhfg2QhW25jqyb4/v/Q5ViLaEa49tF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2SPT7ui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363CCC16AAE;
	Thu, 13 Nov 2025 13:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763041090;
	bh=TanqNDDou92JeIIiWS3c/wMf1Ii6b9BkUyE/vwk57VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U2SPT7uiGDnCCG6zb5qV815Sdj+r/uoSMOEc9j/lDhdWJRl6ShlV3SlTJuqDT9Tgk
	 RFqKZr6iJlXWjCYWomACcsJ9ChroZfCyo9zV3HtJ+rhsSZp8cOA5ZLSvx9UykS0IlE
	 sObeATI2JOfkex303JF7L8VsylgtKzcJMtxpc5OB2cLwBE0nBgoPsmDmbuFkOY/lYw
	 IHqX06nHuXISwbnGRAH11InGI6hhbI8mTYsSN1dTFb5KoYyEe9EtrJBRCEg2qK0fhB
	 H1BCrwQp8B38S+H3T7Xw/MFbxm0/tJwuhV0uHb4Iaum1bU+pryW8wlml6fPOM/Fadb
	 TVU+5ngjiikxw==
Date: Thu, 13 Nov 2025 15:37:44 +0200
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
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
Subject: Re: [PATCH v5 01/22] liveupdate: luo_core: luo_ioctl: Live Update
 Orchestrator
Message-ID: <aRXfKPfoi96B68Ef@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107210526.257742-2-pasha.tatashin@soleen.com>

On Fri, Nov 07, 2025 at 04:02:59PM -0500, Pasha Tatashin wrote:
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
> ---

...

> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +/*
> + * Userspace interface for /dev/liveupdate
> + * Live Update Orchestrator
> + *
> + * Copyright (c) 2025, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +#ifndef _UAPI_LIVEUPDATE_H
> +#define _UAPI_LIVEUPDATE_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/**
> + * DOC: General ioctl format
> + *

It seems it's not linked from Documentation/.../liveupdate.rst

> + * The ioctl interface follows a general format to allow for extensibility. Each
> + * ioctl is passed in a structure pointer as the argument providing the size of
> + * the structure in the first u32. The kernel checks that any structure space
> + * beyond what it understands is 0. This allows userspace to use the backward
> + * compatible portion while consistently using the newer, larger, structures.
> + *
> + * ioctls use a standard meaning for common errnos:
> + *
> + *  - ENOTTY: The IOCTL number itself is not supported at all
> + *  - E2BIG: The IOCTL number is supported, but the provided structure has
> + *    non-zero in a part the kernel does not understand.
> + *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
> + *    understood, however a known field has a value the kernel does not
> + *    understand or support.
> + *  - EINVAL: Everything about the IOCTL was understood, but a field is not
> + *    correct.
> + *  - ENOENT: A provided token does not exist.
> + *  - ENOMEM: Out of memory.
> + *  - EOVERFLOW: Mathematics overflowed.
> + *
> + * As well as additional errnos, within specific ioctls.

...

> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -1,7 +1,34 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (c) 2025, Google LLC.
> +# Pasha Tatashin <pasha.tatashin@soleen.com>
> +#
> +# Live Update Orchestrator
> +#
>  
>  menu "Live Update and Kexec HandOver"
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
> +
> +	  This feature primarily targets virtual machine hosts to quickly update
> +	  the kernel hypervisor with minimal disruption to the running virtual
> +	  machines.
> +
> +	  If unsure, say N.
> +

Not a big deal, but since LIVEUPDATE depends on KEXEC_HANDOVER, shouldn't
it go after KEXEC_HANDOVER?

>  config KEXEC_HANDOVER
>  	bool "kexec handover"
>  	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE

-- 
Sincerely yours,
Mike.

