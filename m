Return-Path: <linux-fsdevel+bounces-57056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 315FAB1E7AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D647AE67D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA942750FD;
	Fri,  8 Aug 2025 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQU2DVcy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A30273D9B;
	Fri,  8 Aug 2025 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653658; cv=none; b=ZWmBR7wFtUKKRma8lF+BsyWK+1REBLuwFrbqrQNYUZD8Y+XpiTFNFbnmWEydZ0ruoV2Qh2OD7uCKKNIZUDE5LGBWz7paFic3WGHg7Rg+FjxVxOzxLKYvwSuQuyV7M4m31yFp9OtdCfGB9Yaxlo5Qs1YBGPUwTbWWYgHRHuLlvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653658; c=relaxed/simple;
	bh=/MZhv2xyt4AcUDBeXqBeLQjeF82okZjGlosKDRDZRRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZwvSN+6gYCU9tu6HmDaESqjHkOVnQuEWcYXHzIArgawo+/VA07frm4VqVb0oyVbqqxWrZ2CF8eWKgdphOLS0psZ0LeO2wtdoKBQiNf6PrLtj2z9Fk/yFPya8aYXp7amH6FJqbxI/QNG4U5fwlWiSIvbuixeMS9sPwrvnnrCjpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQU2DVcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C61CC4CEED;
	Fri,  8 Aug 2025 11:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653655;
	bh=/MZhv2xyt4AcUDBeXqBeLQjeF82okZjGlosKDRDZRRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IQU2DVcyJVd5B0+i0u+kVGVGSkAyEJgeoPLt83MBFTeukFmA767VSCfee9jo2kpJu
	 ewnqYzL6oFuM7V3YAHQKSYCZOsFySGH8wD9cKXnZ0GjvCQG0ofU/o3fp4iR99Vdn4N
	 6OxePJiGA9xHAIcPvRRE33aHWyPRNjMyeM8mnvmewljS376m/31icfgu4UnvrvGbjj
	 Bs+qwGRAP/jEDGNUL2NU1f2FiSa6GoHKoZZ+pLsWzn9OAgxbccK0jU1nVw7t+sZLje
	 K5KflUU+XXYFZxZAybDHl6gqr17n00q7l0EDS4/DJlhSWNViKSvh12nw55GJCFY56f
	 EOv0YpzVtF53Q==
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
Subject: Re: [PATCH v3 02/30] kho: mm: Don't allow deferred struct page with
 KHO
In-Reply-To: <20250807014442.3829950-3-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-3-pasha.tatashin@soleen.com>
Date: Fri, 08 Aug 2025 13:47:25 +0200
Message-ID: <mafs0jz3eavci.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 07 2025, Pasha Tatashin wrote:

> KHO uses struct pages for the preserved memory early in boot, however,
> with deferred struct page initialization, only a small portion of
> memory has properly initialized struct pages.
>
> This problem was detected where vmemmap is poisoned, and illegal flag
> combinations are detected.
>
> Don't allow them to be enabled together, and later we will have to
> teach KHO to work properly with deferred struct page init kernel
> feature.
>
> Fixes: 990a950fe8fd ("kexec: add config option for KHO")
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Nit: Drop the blank line before fixes. git interpret-trailers doesn't
seem to recognize the fixes otherwise, so this may break some tooling.
Try it yourself:

    $ git interpret-trailers --parse commit_message.txt

Other than this,

Acked-by: Pratyush Yadav <pratyush@kernel.org>

> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/Kconfig.kexec | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 2ee603a98813..1224dd937df0 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -97,6 +97,7 @@ config KEXEC_JUMP
>  config KEXEC_HANDOVER
>  	bool "kexec handover"
>  	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
> +	depends on !DEFERRED_STRUCT_PAGE_INIT
>  	select MEMBLOCK_KHO_SCRATCH
>  	select KEXEC_FILE
>  	select DEBUG_FS

-- 
Regards,
Pratyush Yadav

