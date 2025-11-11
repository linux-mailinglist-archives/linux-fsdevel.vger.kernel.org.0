Return-Path: <linux-fsdevel+bounces-67991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E70FC4FB34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 21:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 620584E2CAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3771833D6F5;
	Tue, 11 Nov 2025 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YISalZIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DF33D6D5;
	Tue, 11 Nov 2025 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892775; cv=none; b=K+EhVPgkG+4gbekASEF4SLLRmDkv9fiuAWOo7eiJPnjvNpJzSsQqZQBXXlAisQyC1B7wHacsFnZGEX6UyHPyj0wJ6L1ngXHlVgVnWsYjhQt1B6xwfWHcsTst7X93l1DJm4uClF1KwQguEQSYE3SsuU0NrW9NfefcGdQ4olIBOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892775; c=relaxed/simple;
	bh=g11VVLOrnrPR/EWZfPCKV/WPrJOnLP2exJs3CrROv6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkyFTPxEh3yVJ/MUin3k/P1YRkioT2RapBmGez/oNV3cInRXMqEsIZoXrDYuqRnxi6x6rBTolvao7WmsLXLL0bVmxEnzC6IqCTRReo0kZH7VmZZ4/oM44GUEMX1mF8+7k6LQSY91tp5rHmqZD8tyOdeMpuWh7JK2L7asYF+IWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YISalZIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8212C4CEF5;
	Tue, 11 Nov 2025 20:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762892775;
	bh=g11VVLOrnrPR/EWZfPCKV/WPrJOnLP2exJs3CrROv6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YISalZIK3TR8PTD+G8hE2OyU4402PpTibQm6YhhXgyG1aHMBQaLvYwlEFIpFzOQ5X
	 qoSlvR3ju4pMUrLtTAdx04FnwZt8dBsZWAW0Zqe7hCqv5B0RpR57/3C3aTVO+0fnKR
	 AYFaNnK9pPJ9rFmcOZncZTAMqpw5+mIW6Zp2N6o/7L624FLpGK0gCV4DdOvhWlHOKp
	 VmJx6sCEH1hefU34OhpEg0xJvO+Gar1UuQcXM1UlxP8IVtZQ530bfppIa/5fKNpf7o
	 9kBBt2oZWf/FzCUMy7Bwu4Rn0UxewXeFXI1cH8NEtgskC4ISIoozoNmPZrsaaMNIG+
	 2N7NuwQcalN0w==
Date: Tue, 11 Nov 2025 22:25:51 +0200
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
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
Message-ID: <aRObz4bQzRHH5hJb@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107210526.257742-3-pasha.tatashin@soleen.com>

On Fri, Nov 07, 2025 at 04:03:00PM -0500, Pasha Tatashin wrote:
> Integrate the LUO with the KHO framework to enable passing LUO state
> across a kexec reboot.
> 
> When LUO is transitioned to a "prepared" state, it tells KHO to
> finalize, so all memory segments that were added to KHO preservation
> list are getting preserved. After "Prepared" state no new segments
> can be preserved. If LUO is canceled, it also tells KHO to cancel the
> serialization, and therefore, later LUO can go back into the prepared
> state.
> 
> This patch introduces the following changes:
> - During the KHO finalization phase allocate FDT blob.
> - Populate this FDT with a LUO compatibility string ("luo-v1").
> 
> LUO now depends on `CONFIG_KEXEC_HANDOVER`. The core state transition
> logic (`luo_do_*_calls`) remains unimplemented in this patch.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

...

> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index c6812b4dbb2e..20c850a52167 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -21,6 +21,7 @@
>  #include <linux/buffer_head.h>
>  #include <linux/kmemleak.h>
>  #include <linux/kfence.h>
> +#include <linux/liveupdate.h>
>  #include <linux/page_ext.h>
>  #include <linux/pti.h>
>  #include <linux/pgtable.h>
> @@ -2703,6 +2704,9 @@ void __init mm_core_init(void)
>  	 */
>  	kho_memory_init();
>  
> +	/* Live Update should follow right after KHO is initialized */
> +	liveupdate_init();
> +

Why do you think it should be immediately after kho_memory_init()?
Any reason this can't be called from start_kernel() or even later as an
early_initcall() or core_initall()?

>  	memblock_free_all();
>  	mem_init();
>  	kmem_cache_init();
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 
> 

-- 
Sincerely yours,
Mike.

