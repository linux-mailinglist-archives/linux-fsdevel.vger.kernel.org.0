Return-Path: <linux-fsdevel+bounces-18113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2DC8B5E32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38018B21C7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A782D9F;
	Mon, 29 Apr 2024 15:55:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ADB81741;
	Mon, 29 Apr 2024 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406113; cv=none; b=Id8vitEhmfzK4z+ODEGZEm8SSlrYUyEJpYOioo+C0mJYOOHrB42XbdKwDiFnUoqZDuMMux0pXl3MOyCRQCrDgzEBkIW9ZVdQqoUcxCyjAzH2uQOl5DGPgtx1O+AoxAH0GHs57w4M7KRoVPUZk9djnl7RkwKn25pqUlvA26uNP24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406113; c=relaxed/simple;
	bh=QWhh71QKLkT8KLKHIg0Ia146hwmXeKdOgOf8k75gClg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyfEuhNvT8CPf5scrYlBG+fKhbmSG14NYbxrXoShbSrAyWvwVNpf4A25uYq89fT2I2WtjLMojK4FEbVDSjx218GUtDRQYktBgRwj+1m8Hg9ovmk4NoWiLFmPPEkVzr1nWgrHByb2YXm8KyNZGiZyHpzq+Zrn/cQJBalnmzD8Bws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F8352F4;
	Mon, 29 Apr 2024 08:55:37 -0700 (PDT)
Received: from [10.57.65.53] (unknown [10.57.65.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B519B3F73F;
	Mon, 29 Apr 2024 08:55:09 -0700 (PDT)
Message-ID: <a6656f48-da57-4bbd-849c-7f4e812a0092@arm.com>
Date: Mon, 29 Apr 2024 16:55:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fs/proc/task_mmu: Fix loss of young/dirty bits during
 pagemap scan
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240429114017.182570-1-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240429114017.182570-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2024 12:40, Ryan Roberts wrote:
> make_uffd_wp_pte() was previously doing:
> 
>   pte = ptep_get(ptep);
>   ptep_modify_prot_start(ptep);
>   pte = pte_mkuffd_wp(pte);
>   ptep_modify_prot_commit(ptep, pte);
> 
> But if another thread accessed or dirtied the pte between the first 2
> calls, this could lead to loss of that information. Since
> ptep_modify_prot_start() gets and clears atomically, the following is
> the correct pattern and prevents any possible race. Any access after the
> first call would see an invalid pte and cause a fault:
> 
>   pte = ptep_modify_prot_start(ptep);
>   pte = pte_mkuffd_wp(pte);
>   ptep_modify_prot_commit(ptep, pte);
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

I guess this should have cc'ed stable but I forgot to add it. Are you able to
fix this up when you take it, Andrew, or do I need to repost?

> ---
>  fs/proc/task_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 23fbab954c20..af4bc1da0c01 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1825,7 +1825,7 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
>  		pte_t old_pte;
> 
>  		old_pte = ptep_modify_prot_start(vma, addr, pte);
> -		ptent = pte_mkuffd_wp(ptent);
> +		ptent = pte_mkuffd_wp(old_pte);
>  		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
>  	} else if (is_swap_pte(ptent)) {
>  		ptent = pte_swp_mkuffd_wp(ptent);
> --
> 2.25.1
> 


