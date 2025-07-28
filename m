Return-Path: <linux-fsdevel+bounces-56126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C7B138A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 12:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CA8170D0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6392550D4;
	Mon, 28 Jul 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HergTxt5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF632E36E2;
	Mon, 28 Jul 2025 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697637; cv=none; b=ua64LXAyxjG++7brrSMDcpD2HiIzO/27tsyrQ3o7orNXFjNKWy1FUQ+sPQwzJXrZURfwZUMCtsGxxWLqgRsou0DUPfHGw4c0N0NXqgCgt7Y/hYaFdF9iZOvIP16W2MMVl+z5pRmmtMVI3Hkl3nrg0bBU3e6TchCyFmnyPPzLmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697637; c=relaxed/simple;
	bh=daNJNlAwuAlAmQ7p/YMaL/6tdKQoOCGv84U1fRIrrag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6nUt6t+C2sIbb/10eYuIe028nm4E25SBW/apXxR2cnNpfnrQlOVVoS1X3B0OkOxUB0WKbwPuIs0g/XQ9Bp+PSbr4fW4ZQRisk2m3oNeFFi93ZYUT04O2IS+6tBZ3Xzocl+8TlMMrk1BbwYViTXA3MxrXAIVvSpTyL7o5wNRNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HergTxt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE1BC4CEE7;
	Mon, 28 Jul 2025 10:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753697637;
	bh=daNJNlAwuAlAmQ7p/YMaL/6tdKQoOCGv84U1fRIrrag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HergTxt5kk4TR3TSd1NLJ1RsWKClShrSfD+8qw6wWjTmWoGROlYKuFOej/vLB4FQ4
	 kBRBH9motJGn7ADDkbzqwuXEzssSs4HSm0g6QrRwxL5ESr7Gq0sgeXo1ZWEkcFxA5c
	 38uGB+I6b3eutvofz1hgrZKjHL3yln6PLYAfi1YdtEdmUZQsbY2TYBPgSDAhDWOQe0
	 E3olCvXGndz1IVvIh5zg193asbIOrIhcnErpIdIC0UnddIgd5y8jEbLizZ3A7VUBRx
	 f5Aq4u9AoD8s/z97FIlq8gE1GGghk4A8DXRN+mj7vokix4E+z67ExqlxbdFqPuKVtZ
	 kq57cj7+KekTw==
Date: Mon, 28 Jul 2025 13:13:32 +0300
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
Subject: Re: [PATCH v2 01/32] kho: init new_physxa->phys_bits to fix lockdep
Message-ID: <aIdNTN1qd0dTvsQm@kernel.org>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723144649.1696299-2-pasha.tatashin@soleen.com>

On Wed, Jul 23, 2025 at 02:46:14PM +0000, Pasha Tatashin wrote:
> Lockdep shows the following warning:
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> 
> [<ffffffff810133a6>] dump_stack_lvl+0x66/0xa0
> [<ffffffff8136012c>] assign_lock_key+0x10c/0x120
> [<ffffffff81358bb4>] register_lock_class+0xf4/0x2f0
> [<ffffffff813597ff>] __lock_acquire+0x7f/0x2c40
> [<ffffffff81360cb0>] ? __pfx_hlock_conflict+0x10/0x10
> [<ffffffff811707be>] ? native_flush_tlb_global+0x8e/0xa0
> [<ffffffff8117096e>] ? __flush_tlb_all+0x4e/0xa0
> [<ffffffff81172fc2>] ? __kernel_map_pages+0x112/0x140
> [<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
> [<ffffffff81359556>] lock_acquire+0xe6/0x280
> [<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
> [<ffffffff8100b9e0>] _raw_spin_lock+0x30/0x40
> [<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
> [<ffffffff813ec327>] xa_load_or_alloc+0x67/0xe0
> [<ffffffff813eb4c0>] kho_preserve_folio+0x90/0x100
> [<ffffffff813ebb7f>] __kho_finalize+0xcf/0x400
> [<ffffffff813ebef4>] kho_finalize+0x34/0x70
> 
> This is becase xa has its own lock, that is not initialized in
> xa_load_or_alloc.
> 
> Modifiy __kho_preserve_order(), to properly call
> xa_init(&new_physxa->phys_bits);
> 
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/kexec_handover.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 5a21dbe17950..1ff6b242f98c 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -144,14 +144,35 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>  				unsigned int order)
>  {
>  	struct kho_mem_phys_bits *bits;
> -	struct kho_mem_phys *physxa;
> +	struct kho_mem_phys *physxa, *new_physxa;
>  	const unsigned long pfn_high = pfn >> order;
>  
>  	might_sleep();
>  
> -	physxa = xa_load_or_alloc(&track->orders, order, sizeof(*physxa));
> -	if (IS_ERR(physxa))
> -		return PTR_ERR(physxa);
> +	physxa = xa_load(&track->orders, order);
> +	if (!physxa) {
> +		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
> +		if (!new_physxa)
> +			return -ENOMEM;
> +
> +		xa_init(&new_physxa->phys_bits);
> +		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
> +				    GFP_KERNEL);
> +		if (xa_is_err(physxa)) {
> +			int err_ret = xa_err(physxa);

Just int err should be fine here, otherwise

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> +
> +			xa_destroy(&new_physxa->phys_bits);
> +			kfree(new_physxa);
> +
> +			return err_ret;
> +		}
> +		if (physxa) {
> +			xa_destroy(&new_physxa->phys_bits);
> +			kfree(new_physxa);
> +		} else {
> +			physxa = new_physxa;
> +		}
> +	}
>  
>  	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
>  				sizeof(*bits));
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

-- 
Sincerely yours,
Mike.

