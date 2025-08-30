Return-Path: <linux-fsdevel+bounces-59705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB34FB3C94E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 10:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1EF1BA0301
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D618B243946;
	Sat, 30 Aug 2025 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ2Gq9Q4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD2223DF1;
	Sat, 30 Aug 2025 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756542927; cv=none; b=cDRLF+QjNIwDLYAosoxE8fb0neYHRBXWryaCpDCwtEZOSVr/Yb8BqhAD9Jh8OhhFUMn2ZbqVvtqVHBMX/ABBLa5npLM2drgJidkF0aBb3VaawOvQ69rU6e/ZQG+qDOnDZl97uCB9Yq5Lg6SBTvyvaHcZyBko4xJ+yjyHghDpJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756542927; c=relaxed/simple;
	bh=oKvjDljPLSRg2x/aOWCyZgodbMjJIdmSCcxy/Ed/RYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga5hWbldyPcaJ3NIjcFMff8Xs2SoQLNY/5jVYP6teqaa6IH1u8GW02q90x0Tv5lFnL/CM2ANm4DpzXo/zZVYsSXwPrHkcBr4fDaU/mR0jKi8C2RUTKKoXK7PBzwqKlwNwJeUFUuYLD70XsVxSqnOYm46ioJaSH0DWnhZqz6I+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ2Gq9Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DCBC4CEEB;
	Sat, 30 Aug 2025 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756542926;
	bh=oKvjDljPLSRg2x/aOWCyZgodbMjJIdmSCcxy/Ed/RYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJ2Gq9Q41CFdV6Q+M16uVYmCXPBnCX6Mtf7wOUYVVkWOIgfiBBx0jlaPa180Cf10s
	 WYotg2neDOLYCEklciQmDeMW3qUzX0UkTa6QROBFiA93CP1SFlmZBKYFWkLmubtmF8
	 6IjAbqmqeDZeZGMSSgPx6Y/SnyNOHjZmt+g7kXUXwVENrl/uCuBffvAtsL/jMM2lEc
	 0lQ2G1Jorwlhp+I8wSJzRGlMX7OxHmQgPe3ubKgbY3jw3rfN6RBNzm/jw+2U86JKgV
	 hRdhGKSEIEL5Sdf+8dpRe+3XW9gqx3VoLY6G1z5UzYe5mU1jAx5nzCn+phxkVTEV28
	 TMP4NOKcmoVjw==
Date: Sat, 30 Aug 2025 11:35:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
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
	leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v3 09/30] liveupdate: kho: move to kernel/liveupdate
Message-ID: <aLK3trXYYYIUaV4Q@kernel.org>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-10-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807014442.3829950-10-pasha.tatashin@soleen.com>

On Thu, Aug 07, 2025 at 01:44:15AM +0000, Pasha Tatashin wrote:
> Move KHO to kernel/liveupdate/ in preparation of placing all Live Update
> core kernel related files to the same place.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> ---
> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
> new file mode 100644
> index 000000000000..72cf7a8e6739
> --- /dev/null
> +++ b/kernel/liveupdate/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the linux kernel.

Nit: this line does not provide much, let's drop it

> +
> +obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
> +obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
> diff --git a/kernel/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> similarity index 99%
> rename from kernel/kexec_handover.c
> rename to kernel/liveupdate/kexec_handover.c
> index 07755184f44b..05f5694ea057 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -23,8 +23,8 @@
>   * KHO is tightly coupled with mm init and needs access to some of mm
>   * internal APIs.
>   */
> -#include "../mm/internal.h"
> -#include "kexec_internal.h"
> +#include "../../mm/internal.h"
> +#include "../kexec_internal.h"
>  #include "kexec_handover_internal.h"
>  
>  #define KHO_FDT_COMPATIBLE "kho-v1"
> @@ -824,7 +824,7 @@ static int __kho_finalize(void)
>  	err |= fdt_finish_reservemap(root);
>  	err |= fdt_begin_node(root, "");
>  	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
> -	/**
> +	/*
>  	 * Reserve the preserved-memory-map property in the root FDT, so
>  	 * that all property definitions will precede subnodes created by
>  	 * KHO callers.
> diff --git a/kernel/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
> similarity index 100%
> rename from kernel/kexec_handover_debug.c
> rename to kernel/liveupdate/kexec_handover_debug.c
> diff --git a/kernel/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
> similarity index 100%
> rename from kernel/kexec_handover_internal.h
> rename to kernel/liveupdate/kexec_handover_internal.h
> -- 
> 2.50.1.565.gc32cd1483b-goog
> 

-- 
Sincerely yours,
Mike.

