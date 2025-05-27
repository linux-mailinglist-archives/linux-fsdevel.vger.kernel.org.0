Return-Path: <linux-fsdevel+bounces-49922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E07AC5320
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 18:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C723BEBA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64327FB0C;
	Tue, 27 May 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmZYfj3A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C245279910;
	Tue, 27 May 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363877; cv=none; b=DWiAB7ceuCHJF8AZI7NguH/48Pb/g0KwDg5juDS96WTbj1gbo10RdUhP+ildMQhwvg1aJD2+xwA4WmuLeEosjysnSpGKlddFbV1lwP7P+EYeHahr5Bo4rZ+b0leZI+YJMS0J9woTyZKJn/TDBHT2B4qIXxdNT27Q4vb4Imlsre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363877; c=relaxed/simple;
	bh=cbKKCkqWwj5R3NhfMsFzcH80Kv1e6XNU0rpPm2F+hog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVLG7LDGNgeI0zNrmYgRrH51jZiVgcX4774uX7MwUolKgSxUJB0aBDaWmgQX/0Wwk27hrOo61kK/1rR36vk76v3VEOUBk5PC9vTdijubWQJhh/InyxtOYbrVfa+Ekd0ZB14QArmBJu1P3pfdab7mRPYNMaPVa6vDEzbZiK1Gb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmZYfj3A; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748363876; x=1779899876;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cbKKCkqWwj5R3NhfMsFzcH80Kv1e6XNU0rpPm2F+hog=;
  b=MmZYfj3AmSqb5GCgy1+WeVKwkR+1mkPC9CoKMCERwOQpyt4IGc1K2/UN
   9nN/tkBLfCP6XE6xRUxDnQD5SgkDsIjC227Go/tAqneZj94mrmoPWd0IK
   Y/PqVNUH0FLtuQIglv96vsbXHZb3VNL/bOnfCdNC30GVsYfbdp5w8YFNz
   GzYMwGzoUaJajJrmUtt211r/Z4MRrPbM890BF9n5FbkVqI7E5/Ar5aO7b
   X4SsN7I8M9iNwFvCiLhTnz0k5fbbjs8ylEuFprSCW3TG3mQSJbKWiteUL
   c36V6ao0NM9jvzVd50hA+dCqtXBW6ULjOQmBcsvnWCk9tdR4W2ZUkzeE/
   A==;
X-CSE-ConnectionGUID: n82G4WRoQM6FAic1j1Xs4w==
X-CSE-MsgGUID: C36ke6zxQ+ypUYW86XDHVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61714972"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="61714972"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 09:37:54 -0700
X-CSE-ConnectionGUID: OUcSBdMeQOWnHX/hgemOrg==
X-CSE-MsgGUID: 5kud2WDqSQK4loLjiAmDkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="180092453"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.109.244]) ([10.125.109.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 09:37:50 -0700
Message-ID: <626be90e-fa54-4ae9-8cad-d3b7eb3e59f7@intel.com>
Date: Tue, 27 May 2025 09:37:50 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] mm: add STATIC_PMD_ZERO_PAGE config option
To: Pankaj Raghav <p.raghav@samsung.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, willy@infradead.org, x86@kernel.org,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, kernel@pankajraghav.com, hch@lst.de
References: <20250527050452.817674-1-p.raghav@samsung.com>
 <20250527050452.817674-3-p.raghav@samsung.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250527050452.817674-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 055204dc211d..96f99b4f96ea 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -152,6 +152,7 @@ config X86
>  	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
>  	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
>  	select ARCH_WANTS_THP_SWAP		if X86_64
> +	select ARCH_WANTS_STATIC_PMD_ZERO_PAGE if X86_64

I don't think this should be the default. There are lots of little
x86_64 VMs sitting around and 2MB might be significant to them.

> +config ARCH_WANTS_STATIC_PMD_ZERO_PAGE
> +	bool
> +
> +config STATIC_PMD_ZERO_PAGE
> +	def_bool y
> +	depends on ARCH_WANTS_STATIC_PMD_ZERO_PAGE
> +	help
> +	  Typically huge_zero_folio, which is a PMD page of zeroes, is allocated
> +	  on demand and deallocated when not in use. This option will always
> +	  allocate huge_zero_folio for zeroing and it is never deallocated.
> +	  Not suitable for memory constrained systems.

"Static" seems like a weird term to use for this. I was really expecting
to see a 2MB object that gets allocated in .bss or something rather than
a dynamically allocated page that's just never freed.

>  menuconfig TRANSPARENT_HUGEPAGE
>  	bool "Transparent Hugepage Support"
>  	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
> diff --git a/mm/memory.c b/mm/memory.c
> index 11edc4d66e74..ab8c16d04307 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -203,9 +203,17 @@ static void put_huge_zero_page(void)
>  	BUG_ON(atomic_dec_and_test(&huge_zero_refcount));
>  }
>  
> +/*
> + * If STATIC_PMD_ZERO_PAGE is enabled, @mm can be NULL, i.e, the huge_zero_folio
> + * is not associated with any mm_struct.
> +*/

I get that callers have to handle failure. But isn't this pretty nasty
for mm==NULL callers to be *guaranteed* to fail? They'll generate code
for the success case that will never even run.


