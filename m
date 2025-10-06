Return-Path: <linux-fsdevel+bounces-63509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86041BBEC36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 19:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B7618963E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAC62236EE;
	Mon,  6 Oct 2025 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgLfsYlT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2FE1E511;
	Mon,  6 Oct 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770110; cv=none; b=SB1M9pubQ3hsMM7LApXrnEDbdIMlz5ebs1lXC7WdmbkwjAragc/HmBmg2o2mUH0I5seIv427u0ncrobgYV16p3JVOl7U05Pk8IGe7WgGfocYh+J8NJhsGRzRp+TP66n0IpPZo85uRT/VkleyfbsTHROWlpkAvf7GJNnWryEL3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770110; c=relaxed/simple;
	bh=MG1dcQMphQ748JndS811tTZbOvZl5viKUiBdA36kux8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJOQyagk1PvCjlFhH6MMCWYochbzXFCk/Nu/p/YW47Bi3n2IoOVb/LFDEDlG8MwqBB8WTZSMnxu03Kej0mjNWcgQC5ge4xyx71EpYsa1dpIj+fHiUVvGaRF+Uy+4Tyz2mfRsIfZBjxAvUR115++M4pNZXNoLFfU+b8gC0zouGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgLfsYlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E62C4CEF5;
	Mon,  6 Oct 2025 17:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759770108;
	bh=MG1dcQMphQ748JndS811tTZbOvZl5viKUiBdA36kux8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NgLfsYlTgtpvDbSOm2NiGUojPOjwRGe/OH3C0JNNWeU0NeJOo51dJ2Ci9kDtEdQQe
	 3k5DscndvUU0phiQ/ZHNvwhZrgX6lqwI5J/xlNMT8aZdV5u3WDO3VM8ATPykvRSGGT
	 r5b1d+SHy8/FqS7MKcd7EdWJCNFHUCHjE9sfR1Z8e+WnV6oVs1zsX8KGWKj3S8B7Ik
	 dfqxPViKr/BDk3+rzxCGaCa3H0MaJSLU2n1ptlHIv/2Y1ql7EfqnzAbEI1HB2hxOHp
	 1IF9IgN+pr/DVwtODnsjwyUKJ4s19AHLk26ebEq26WDj2aZOB2f8yyO+hVGm27x+7w
	 a51lxbN5OsjFQ==
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
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org,
  steven.sistare@oracle.com
Subject: Re: [PATCH v4 03/30] kho: drop notifiers
In-Reply-To: <20250929010321.3462457-4-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 29 Sep 2025 01:02:54 +0000")
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
	<20250929010321.3462457-4-pasha.tatashin@soleen.com>
Date: Mon, 06 Oct 2025 19:01:37 +0200
Message-ID: <mafs0tt0cnevi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 29 2025, Pasha Tatashin wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> The KHO framework uses a notifier chain as the mechanism for clients to
> participate in the finalization process. While this works for a single,
> central state machine, it is too restrictive for kernel-internal
> components like pstore/reserve_mem or IMA. These components need a
> simpler, direct way to register their state for preservation (e.g.,
> during their initcall) without being part of a complex,
> shutdown-time notifier sequence. The notifier model forces all
> participants into a single finalization flow and makes direct
> preservation from an arbitrary context difficult.
> This patch refactors the client participation model by removing the
> notifier chain and introducing a direct API for managing FDT subtrees.
>
> The core kho_finalize() and kho_abort() state machine remains, but
> clients now register their data with KHO beforehand.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[...]
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e23e16618e9b..c4b2d4e4c715 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2444,53 +2444,18 @@ int reserve_mem_release_by_name(const char *name)
>  #define MEMBLOCK_KHO_FDT "memblock"
>  #define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
>  #define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
> -static struct page *kho_fdt;
> -
> -static int reserve_mem_kho_finalize(struct kho_serialization *ser)
> -{
> -	int err = 0, i;
> -
> -	for (i = 0; i < reserved_mem_count; i++) {
> -		struct reserve_mem_table *map = &reserved_mem_table[i];
> -		struct page *page = phys_to_page(map->start);
> -		unsigned int nr_pages = map->size >> PAGE_SHIFT;
> -
> -		err |= kho_preserve_pages(page, nr_pages);
> -	}
> -
> -	err |= kho_preserve_folio(page_folio(kho_fdt));
> -	err |= kho_add_subtree(ser, MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
> -
> -	return notifier_from_errno(err);
> -}
> -
> -static int reserve_mem_kho_notifier(struct notifier_block *self,
> -				    unsigned long cmd, void *v)
> -{
> -	switch (cmd) {
> -	case KEXEC_KHO_FINALIZE:
> -		return reserve_mem_kho_finalize((struct kho_serialization *)v);
> -	case KEXEC_KHO_ABORT:
> -		return NOTIFY_DONE;
> -	default:
> -		return NOTIFY_BAD;
> -	}
> -}
> -
> -static struct notifier_block reserve_mem_kho_nb = {
> -	.notifier_call = reserve_mem_kho_notifier,
> -};
>  
>  static int __init prepare_kho_fdt(void)
>  {
>  	int err = 0, i;
> +	struct page *fdt_page;
>  	void *fdt;
>  
> -	kho_fdt = alloc_page(GFP_KERNEL);
> -	if (!kho_fdt)
> +	fdt_page = alloc_page(GFP_KERNEL);
> +	if (!fdt_page)
>  		return -ENOMEM;
>  
> -	fdt = page_to_virt(kho_fdt);
> +	fdt = page_to_virt(fdt_page);
>  
>  	err |= fdt_create(fdt, PAGE_SIZE);
>  	err |= fdt_finish_reservemap(fdt);
> @@ -2499,7 +2464,10 @@ static int __init prepare_kho_fdt(void)
>  	err |= fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE_COMPATIBLE);
>  	for (i = 0; i < reserved_mem_count; i++) {
>  		struct reserve_mem_table *map = &reserved_mem_table[i];
> +		struct page *page = phys_to_page(map->start);
> +		unsigned int nr_pages = map->size >> PAGE_SHIFT;
>  
> +		err |= kho_preserve_pages(page, nr_pages);
>  		err |= fdt_begin_node(fdt, map->name);
>  		err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
>  		err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));
> @@ -2507,13 +2475,14 @@ static int __init prepare_kho_fdt(void)
>  		err |= fdt_end_node(fdt);
>  	}
>  	err |= fdt_end_node(fdt);
> -
>  	err |= fdt_finish(fdt);
>  
> +	err |= kho_preserve_folio(page_folio(fdt_page));
> +	err |= kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
> +
>  	if (err) {
>  		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
> -		put_page(kho_fdt);
> -		kho_fdt = NULL;
> +		put_page(fdt_page);

This adds subtree to KHO even if the FDT might be invalid. And then
leaves a dangling reference in KHO to the FDT in case of an error. I
think you should either do this check after
kho_preserve_folio(page_folio(fdt_page)) and do a clean error check for
kho_add_subtree(), or call kho_remove_subtree() in the error block.

I prefer the former since if kho_add_subtree() is the one that fails,
there is little sense in removing a subtree that was never added.

>  	}
>  
>  	return err;
> @@ -2529,13 +2498,6 @@ static int __init reserve_mem_init(void)
>  	err = prepare_kho_fdt();
>  	if (err)
>  		return err;
> -
> -	err = register_kho_notifier(&reserve_mem_kho_nb);
> -	if (err) {
> -		put_page(kho_fdt);
> -		kho_fdt = NULL;
> -	}
> -
>  	return err;
>  }
>  late_initcall(reserve_mem_init);

-- 
Regards,
Pratyush Yadav

