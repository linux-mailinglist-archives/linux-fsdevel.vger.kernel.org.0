Return-Path: <linux-fsdevel+bounces-29565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 253BC97AD05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 10:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C514B1F25789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7A21581F3;
	Tue, 17 Sep 2024 08:44:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F191411C8;
	Tue, 17 Sep 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562678; cv=none; b=ebZI3mEaxusDf00Q53KnGtH6N2j+6GUxBsK9FXd49HJWbsqKXlJJy3J6bZ8vJwBPWAOq1y8DoI8ZoOLfuwncQpSfsuCp88xFz9O+xSdjTJn15Bg8b1irAKf6XsoOIgl2KtLV1R1iTwI5yTcJPOFG/dKuyt61NN32B5Ad63ZgVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562678; c=relaxed/simple;
	bh=1kZQOv6aCARwhPkW5k+9PCifhhDez3ftRd0I8Urv4n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIAa/JYXvS5E+dzQ0rgR7WIbu8cO2DiNUkTA5mKY5Oe5uxcSTx6oMOBPPBCRpGMCDdAGP+QTflvbbcl8Sm50KVVHnkHqbSsgqpK76VsBMJRGuk76rlesmqTN4MiV8LXMFD0CMey84j+cyMQKssU68BVSiE/FJlt203r01XfrpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0B8EDA7;
	Tue, 17 Sep 2024 01:45:04 -0700 (PDT)
Received: from [10.57.83.157] (unknown [10.57.83.157])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBC1D3F66E;
	Tue, 17 Sep 2024 01:44:33 -0700 (PDT)
Message-ID: <45084868-0a09-4c57-81b0-f59a1ca292db@arm.com>
Date: Tue, 17 Sep 2024 09:44:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/7] mm: Use ptep_get() for accessing PTE entries
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
 <20240917073117.1531207-4-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240917073117.1531207-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2024 08:31, Anshuman Khandual wrote:
> Convert PTE accesses via ptep_get() helper that defaults as READ_ONCE() but
> also provides the platform an opportunity to override when required. This
> stores read page table entry value in a local variable which can be used in
> multiple instances there after. This helps in avoiding multiple memory load
> operations as well possible race conditions.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/pgtable.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 2a6a3cccfc36..547eeae8c43f 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1060,7 +1060,8 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>   */
>  #define set_pte_safe(ptep, pte) \
>  ({ \
> -	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
> +	pte_t __old = ptep_get(ptep); \
> +	WARN_ON_ONCE(pte_present(__old) && !pte_same(__old, pte)); \
>  	set_pte(ptep, pte); \
>  })
>  


