Return-Path: <linux-fsdevel+bounces-68469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C06C5CDE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9E0A34DEF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2055A3148C3;
	Fri, 14 Nov 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Akk7h6Hl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEFD3112BB;
	Fri, 14 Nov 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763119807; cv=none; b=nNEZgwQmIEW/ddeq/YRb2mXxSVZ28ZZsfUp+MbS8zLJkgbmArfrGU2k19da2jZvqaeeuw2t6bsgFllpTJ8Jokmj7xmsdRimomwrFjHKx98a+B8+Uw2WKkMFeTVX+qJHuPsUn8kttoFbJjSoLRGVxmTf0SmIdKZd+bxOmbAoynVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763119807; c=relaxed/simple;
	bh=nWQdNFwkseMe3m11T//I7TjOchkTxc0f6sD/wvtcMU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfamLVoA1cR1D/7fwhLJuMCe1iHL7AApt5pgItsRHMZfAFu8TKBLlrxM9idJzvWlsnqNJGnqsSTEKFitCHMKtJ+frqyWrqW/G3mNGunvYQS0dOO67RcDgRHpRGRpIJkK/gzl1LI3Ld1EukSCbhsAqC1AZFHt3URyWmHUN2pG8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Akk7h6Hl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6503CC4CEF1;
	Fri, 14 Nov 2025 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763119807;
	bh=nWQdNFwkseMe3m11T//I7TjOchkTxc0f6sD/wvtcMU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Akk7h6HlDkGyGgeCHZX5VqCq5N2nSt0CHf09pDVbnqBORphhI2YOmYWQy1u7s7HXC
	 vk2eR2lL3RSSszzGR9ZhrQ9QHgg7YrLsh+41vhXoLLGIoUvW4UsruI26iGVeGzAPcP
	 84LrN6UJauCgG0t0GQcvjzAMnlfsFZghOoVZaAboWw1so/FBVYjxsoCOb/82AQtq2Z
	 0NtCLvZKWHuVI1yWzfUj922GUd6PeRI52oxjC49q5F9N+wj9XWPMdbCNqC7iekpi2w
	 awEJbNAXVGPvsWxl0F2algphSwaLFV5Rgvd/Ls4Ffdpt7rW/ve1asAz7IG+BKt3CL0
	 RK6yYv8fID0kA==
Date: Fri, 14 Nov 2025 13:29:41 +0200
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
Message-ID: <aRcSpbwBabFjeYe3@kernel.org>
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
> ---
>  include/linux/liveupdate.h         |   6 +
>  include/linux/liveupdate/abi/luo.h |  54 +++++++
>  kernel/liveupdate/luo_core.c       | 243 ++++++++++++++++++++++++++++-
>  kernel/liveupdate/luo_internal.h   |  17 ++
>  mm/mm_init.c                       |   4 +
>  5 files changed, 323 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/liveupdate/abi/luo.h
>  create mode 100644 kernel/liveupdate/luo_internal.h
> 
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index 730b76625fec..0be8804fc42a 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -13,6 +13,8 @@
>  
>  #ifdef CONFIG_LIVEUPDATE
>  
> +void __init liveupdate_init(void);
> +
>  /* Return true if live update orchestrator is enabled */
>  bool liveupdate_enabled(void);
>  
> @@ -21,6 +23,10 @@ int liveupdate_reboot(void);
>  
>  #else /* CONFIG_LIVEUPDATE */
>  
> +static inline void liveupdate_init(void)
> +{
> +}

The common practice is to place brackets at the same line with function
declaration.

...

> +static int __init luo_early_startup(void)
> +{
> +	phys_addr_t fdt_phys;
> +	int err, ln_size;
> +	const void *ptr;
> +
> +	if (!kho_is_enabled()) {
> +		if (liveupdate_enabled())
> +			pr_warn("Disabling liveupdate because KHO is disabled\n");
> +		luo_global.enabled = false;
> +		return 0;
> +	}
> +
> +	/* Retrieve LUO subtree, and verify its format. */
> +	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys);
> +	if (err) {
> +		if (err != -ENOENT) {
> +			pr_err("failed to retrieve FDT '%s' from KHO: %pe\n",
> +			       LUO_FDT_KHO_ENTRY_NAME, ERR_PTR(err));
> +			return err;
> +		}
> +
> +		return 0;
> +	}
> +
> +	luo_global.fdt_in = __va(fdt_phys);

phys_to_virt is clearer, isn't it?

> +	err = fdt_node_check_compatible(luo_global.fdt_in, 0,
> +					LUO_FDT_COMPATIBLE);

...

> +void __init liveupdate_init(void)
> +{
> +	int err;
> +
> +	err = luo_early_startup();
> +	if (err) {
> +		pr_err("The incoming tree failed to initialize properly [%pe], disabling live update\n",
> +		       ERR_PTR(err));
> +		luo_global.enabled = false;
> +	}
> +}
> +
> +/* Called during boot to create LUO fdt tree */

			 ^ create outgoing

> +static int __init luo_late_startup(void)
> +{
> +	int err;
> +
> +	if (!liveupdate_enabled())
> +		return 0;
> +
> +	err = luo_fdt_setup();
> +	if (err)
> +		luo_global.enabled = false;
> +
> +	return err;
> +}
> +late_initcall(luo_late_startup);

It would be nice to have a comment explaining why late_initcall() is fine
and why there's no need to initialize the outgoing fdt earlier.

> +/**
> + * luo_alloc_preserve - Allocate, zero, and preserve memory.

I think this and the "free" counterparts would be useful for any KHO users,
even those that don't need LUO.

> + * @size: The number of bytes to allocate.
> + *
> + * Allocates a physically contiguous block of zeroed pages that is large
> + * enough to hold @size bytes. The allocated memory is then registered with
> + * KHO for preservation across a kexec.
> + *
> + * Note: The actual allocated size will be rounded up to the nearest
> + * power-of-two page boundary.
> + *
> + * @return A virtual pointer to the allocated and preserved memory on success,
> + * or an ERR_PTR() encoded error on failure.
> + */
> +void *luo_alloc_preserve(size_t size)
> +{
> +	struct folio *folio;
> +	int order, ret;
> +
> +	if (!size)
> +		return ERR_PTR(-EINVAL);
> +
> +	order = get_order(size);
> +	if (order > MAX_PAGE_ORDER)
> +		return ERR_PTR(-E2BIG);

High order allocations would likely fail or at least cause a heavy reclaim.
For now it seems that we won't be needing really large contiguous chunks so
maybe limiting this to PAGE_ALLOC_COSTLY_ORDER?

Later if we'd need higher order allocations we can try to allocate with
__GFP_NORETRY or __GFP_RETRY_MAYFAIL with a fallback to vmalloc.

> +
> +	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, order);
> +	if (!folio)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = kho_preserve_folio(folio);
> +	if (ret) {
> +		folio_put(folio);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return folio_address(folio);
> +}
> +

-- 
Sincerely yours,
Mike.

