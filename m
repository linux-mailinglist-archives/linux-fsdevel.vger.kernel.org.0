Return-Path: <linux-fsdevel+bounces-23655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB1D930F25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541071C20BCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 07:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65451836CB;
	Mon, 15 Jul 2024 07:53:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD6523A9
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029996; cv=none; b=IdTR5moR+oNl1+9iLXyqSPfo4hmS9MXOdcgnAWdWSERfygeaeNcPC0juIgHu0pIOXR0ohEEvD5v/yYxemDtoGzZuQI/9BBvYE8J7p8HNsig3SoeoWAcsOLiu6J8wwpKryyQi7AH4W7t0038OOkb9pzsJKD/VgxN7qRQIwhn6c6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029996; c=relaxed/simple;
	bh=CGeyOrDxGHJLbPdG0UwWgVmTjuOdudMo/ybOfaUSg6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XK0ciF0+YQo7+wwYVtPl1cAQrmugMXwlGpL7ptda4bGwRPw2Jt7w1VpyIdASRBexrzvTlh+ELau4YdtfrjSsKcGrh5SwWJIJ8yyp0RAFtW36FbridfhbBJuYbAMmhoTX4S7LWu67Ac1IDrtBGhNfj1Zb9WaHH2/d5W6WGOrGOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 493ADDA7;
	Mon, 15 Jul 2024 00:53:39 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA5403F73F;
	Mon, 15 Jul 2024 00:53:05 -0700 (PDT)
Message-ID: <3e13f67a-b9b0-4cb1-9af9-19df06546ca4@arm.com>
Date: Mon, 15 Jul 2024 13:23:02 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/29] mm: use ARCH_PKEY_BITS to define VM_PKEY_BITN
To: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
 catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, maz@kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
 npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org,
 szabolcs.nagy@arm.com, tglx@linutronix.de, will@kernel.org, x86@kernel.org,
 kvmarm@lists.linux.dev
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-4-joey.gouly@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240503130147.1154804-4-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 18:31, Joey Gouly wrote:
> Use the new CONFIG_ARCH_PKEY_BITS to simplify setting these bits
> for different architectures.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  fs/proc/task_mmu.c |  2 ++
>  include/linux/mm.h | 16 ++++++++++------
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 23fbab954c20..0d152f460dcc 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -692,7 +692,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_PKEY_BIT0)]	= "",
>  		[ilog2(VM_PKEY_BIT1)]	= "",
>  		[ilog2(VM_PKEY_BIT2)]	= "",
> +#if VM_PKEY_BIT3
>  		[ilog2(VM_PKEY_BIT3)]	= "",
> +#endif
>  #if VM_PKEY_BIT4
>  		[ilog2(VM_PKEY_BIT4)]	= "",
>  #endif
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b6bdaa18b9e9..5605b938acce 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -329,12 +329,16 @@ extern unsigned int kobjsize(const void *objp);
>  #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
>  
>  #ifdef CONFIG_ARCH_HAS_PKEYS
> -# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
> -# define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
> -# define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64   */
> -# define VM_PKEY_BIT2	VM_HIGH_ARCH_2
> -# define VM_PKEY_BIT3	VM_HIGH_ARCH_3
> -#ifdef CONFIG_PPC
> +# define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
> +# define VM_PKEY_BIT0  VM_HIGH_ARCH_0
> +# define VM_PKEY_BIT1  VM_HIGH_ARCH_1
> +# define VM_PKEY_BIT2  VM_HIGH_ARCH_2
> +#if CONFIG_ARCH_PKEY_BITS > 3
> +# define VM_PKEY_BIT3  VM_HIGH_ARCH_3
> +#else
> +# define VM_PKEY_BIT3  0
> +#endif
> +#if CONFIG_ARCH_PKEY_BITS > 4
>  # define VM_PKEY_BIT4  VM_HIGH_ARCH_4
>  #else
>  # define VM_PKEY_BIT4  0

Agree with Dave that this is not very clean but does the job i.e getting
rid of the platform #ifdef which in itself is an improvement.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

