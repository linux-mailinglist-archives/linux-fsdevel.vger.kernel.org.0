Return-Path: <linux-fsdevel+bounces-57055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E92B1E790
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1835D1AA3F86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 11:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81FC2750F8;
	Fri,  8 Aug 2025 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thXbzi8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F136526A08D;
	Fri,  8 Aug 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653353; cv=none; b=QcChV/Xh3pLwoJki2hZ7k8OxdnxdEtZ454vAKloriTB3WdJ7xq4rY6xfdFHk4G0o8ML7+BRX/nSw59Xy+919L9c76YaiwrDRZGT9zRHVCZIzW1n0djzpdVxfvSWJkd5aBDWHdiRGZo01mevoZTP34ErVdSBXIPRVCCop0ustjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653353; c=relaxed/simple;
	bh=+EXwIQbDINd7zs+mcit0rAyRB8QW/lOaVnLZfgR3OU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qpvyoAFN48+Sjc9MSla/10NG90t1jZ9wdmjOJZN1PVycl5eCbi78D5mC0Pz5k46aQ1k1PwORT48zjiRS3tb1DZRONCxjSlLF4MC9fRzR0TrO+AJVAqWd4STS/cf+HASs2gOg9dM29ratr/ucq9QDGzZJ1HkuySX2A9sZ0XLWTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thXbzi8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F953C4CEED;
	Fri,  8 Aug 2025 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653352;
	bh=+EXwIQbDINd7zs+mcit0rAyRB8QW/lOaVnLZfgR3OU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=thXbzi8UdXsRGC6Qoy3VJbFEU21MkSCOaDClxHC2JK1GJZt0rBKoB1Jn+AH6aCiwi
	 b0g+JiFxsmHtOPyVLLIP38MuvNDBW1mHFNFAITJGNoRqJtYvVjkmjm6acnUCnynowh
	 g6z3N7QQLflKhYJYtEJiZG04QlZIGfT09dmtF5670e5T2hm26OfS1CsXEtZzvJw83I
	 w4zxtBzNlzwxi8sqj1C4dwf2LcZKCFKEp9F5c+F6rW5KqqUC9HWONnn97gcslfc0VX
	 +QP/gzK0YMadigtYGs3vb06wIiT9fNCYpkbZ5lkp5/VOcN1BNMPTw9E1lQThAMnU6l
	 PgoVhAgaXBGyg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  rppt@kernel.org,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 01/30] kho: init new_physxa->phys_bits to fix lockdep
In-Reply-To: <20250807014442.3829950-2-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-2-pasha.tatashin@soleen.com>
Date: Fri, 08 Aug 2025 13:42:22 +0200
Message-ID: <mafs0o6sqavkx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Pasha,

On Thu, Aug 07 2025, Pasha Tatashin wrote:

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
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/kexec_handover.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index e49743ae52c5..6240bc38305b 100644
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
> +			int err = xa_err(physxa);
> +
> +			xa_destroy(&new_physxa->phys_bits);
> +			kfree(new_physxa);
> +
> +			return err;
> +		}
> +		if (physxa) {
> +			xa_destroy(&new_physxa->phys_bits);
> +			kfree(new_physxa);
> +		} else {
> +			physxa = new_physxa;
> +		}

I suppose this could be simplified a bit to:

	err = xa_err(physxa);
        if (err || physxa) {
        	xa_destroy(&new_physxa->phys_bits);
                kfree(new_physxa);

		if (err)
                	return err;
	} else {
        	physxa = new_physxa;
	}

No strong preference though, so fine either way. Up to you.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

> +	}
>  
>  	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
>  				sizeof(*bits));

-- 
Regards,
Pratyush Yadav

