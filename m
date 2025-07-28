Return-Path: <linux-fsdevel+bounces-56127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCA9B138A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7701889098
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6394825524D;
	Mon, 28 Jul 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWPJg6TU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75E6156F4A;
	Mon, 28 Jul 2025 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697697; cv=none; b=C0pBDKYWCeCB0Eyl22tMwzVkLxChXkExur6V2nIVYfOD7fWtSKFwTsKa50L6/5pvaqcdksbAzuugkx2vKMvy2NrQvRKRoKwEk0V07AKN6+C68+PvkmGwS0mhpW8FakIR8ROxhnBdPBCGQ34S0nnsLbEEzIZKAvjeWxrJ9GVzmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697697; c=relaxed/simple;
	bh=Qmfdssha0pQC/Q7+oh1hSuVB4LZ1IZAFEMrXqsQ8Udg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puagPD+BGBvfRlOfuV1+s8lcWllpqZnQmqrE+ScRCyhc1RxXsCYRShxQHVjPqWM31kJT01ncdbI8gfCMO1EpdwOyqHFqgaNmp/w34Fdem79K2bSt0McauJBJA86syEqtxmzlA1O2Z7cT6s4ZOTL1mQ8AOHBhTSTTMClLfw3JO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWPJg6TU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98B9C4CEE7;
	Mon, 28 Jul 2025 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753697697;
	bh=Qmfdssha0pQC/Q7+oh1hSuVB4LZ1IZAFEMrXqsQ8Udg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWPJg6TUX4DvdY/7ZlZ5rFSxlzfkXMLo6Y+4tJzAIpixUbN/1b3g/3LhJwM+QGT9V
	 uJpNPDJxKzps8hBfVhIw+Ar253PhuhPH9XqK2iBOH8H/iE3BNaN7/eYIvJHTaNXjQa
	 hdOnEU/6eYupi4bro/sil1dpHZNrjqHO8dowC+2pGzJfK08C+xlUFj5fKXMjTle5HQ
	 OorQ9lNK64e0YUvB+ZA3x6Nm9sGSfI7n4gnFt1wkTrlRxQn1+aJb/DV1lHvsH7vOI/
	 2HOKB28YAvJ+GbNzrz7lc2ML3PQpAjmBievnS9vJgT7vMaSMHRWuBoWtZYeBVnw0NN
	 l3svxY9hF4UHg==
Date: Mon, 28 Jul 2025 13:14:31 +0300
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
Subject: Re: [PATCH v2 02/32] kho: mm: Don't allow deferred struct page with
 KHO
Message-ID: <aIdNh-qqSqSUIr2V@kernel.org>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723144649.1696299-3-pasha.tatashin@soleen.com>

On Wed, Jul 23, 2025 at 02:46:15PM +0000, Pasha Tatashin wrote:
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

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

-- 
Sincerely yours,
Mike.

