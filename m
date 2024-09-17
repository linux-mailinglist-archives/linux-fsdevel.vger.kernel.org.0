Return-Path: <linux-fsdevel+bounces-29564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DF497ACF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 10:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763E51C20F72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807115383A;
	Tue, 17 Sep 2024 08:40:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65768446DB;
	Tue, 17 Sep 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562408; cv=none; b=Ld9tCJ/NgnAZo3KwB+mDU8q4G89SfI6fTXqyEkrVg+wc7qGv890PLliKhKa0E+shZ1QyuF2TfRQaSW7mEcXyvEY249e6Y8TR/92+Ek4c2zyyIF/OJlc8Yu1o/meiLv7oT/z2oTC6uydS6cuviKmIrxQnCZ097PyFZNCvT0FaeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562408; c=relaxed/simple;
	bh=TWJMtfJZ9QPOu5Te4EqE5AIl1qhQ4uGMya1ppUhTjgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e91vE6ZrED+JvEvSoHWoH2FTjAZVVOjJgTviI/tH19ZpL4RMC6QEw2FdN5F16I9X3caue2qxjb/OqFjiC9oSrpadZKkVGFLfABvOJyJ73EzVC+UFCURT6ELonHYfjc970TnYRD+FSDOrZdJ2ha3XIE35x99mPoEsC2a7IwFoqDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3231DA7;
	Tue, 17 Sep 2024 01:40:33 -0700 (PDT)
Received: from [10.57.83.157] (unknown [10.57.83.157])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AF643F66E;
	Tue, 17 Sep 2024 01:40:02 -0700 (PDT)
Message-ID: <6800a37f-8a37-4a9b-9e22-a78943d1ecf7@arm.com>
Date: Tue, 17 Sep 2024 09:40:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/7] m68k/mm: Change pmd_val()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guo Ren <guoren@kernel.org>
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
 <20240917073117.1531207-2-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240917073117.1531207-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2024 08:31, Anshuman Khandual wrote:
> This changes platform's pmd_val() to access the pmd_t element directly like
> other architectures rather than current pointer address based dereferencing
> that prevents transition into pmdp_get().
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

I know very little about m68k, but for what it's worth:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/m68k/include/asm/page.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
> index 8cfb84b49975..be3f2c2a656c 100644
> --- a/arch/m68k/include/asm/page.h
> +++ b/arch/m68k/include/asm/page.h
> @@ -19,7 +19,7 @@
>   */
>  #if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS == 3
>  typedef struct { unsigned long pmd; } pmd_t;
> -#define pmd_val(x)	((&x)->pmd)
> +#define pmd_val(x)	((x).pmd)
>  #define __pmd(x)	((pmd_t) { (x) } )
>  #endif
>  


