Return-Path: <linux-fsdevel+bounces-25085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E97948C58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 11:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96D11C214E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8A21BE25A;
	Tue,  6 Aug 2024 09:46:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAE41BDA86;
	Tue,  6 Aug 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937568; cv=none; b=ZmpOMKUlhukL4YJxbQ3pY9MvQN71RnF0a6wCMvTvDISqBVxZGeEuHi/Qqfi0B0UPkm3P8MX6pT/LY17zj2q85KK7xwepJGOqTBMl8lFNT25/Mc3efNIfYk+Kz26hZ2ESGdY/8ZZnkhebf1GivztUaM0EAzp9vaBM5kh7Lle9kdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937568; c=relaxed/simple;
	bh=wKTlcGiWBThyUbRzi9ybAMp65v0DAlZ2p6BQtxLqgA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQy3asSAVH/3m6I3dVRY2q2g9HL6GacWR9p3NoZ93utrxdz/ObmGJbGEw2lekXBHOBw1EImNx0LBCYpGG8Xra8JRD+1IJGtRTpQw3hVlda13uDpThfLm1uAtEaVCfI+I1f9JedVnv11l6z/t5qGGcmYie23fm+gayoixj1y/V+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 205221063;
	Tue,  6 Aug 2024 02:46:31 -0700 (PDT)
Received: from [10.57.81.200] (unknown [10.57.81.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7451C3F6A8;
	Tue,  6 Aug 2024 02:46:02 -0700 (PDT)
Message-ID: <e1d44e36-06e4-4d1c-8daf-315d149ea1b3@arm.com>
Date: Tue, 6 Aug 2024 10:46:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] mm/huge_memory: convert split_huge_pages_pid()
 from follow_page() to folio_walk
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Mark Brown <broonie@kernel.org>
References: <20240802155524.517137-1-david@redhat.com>
 <20240802155524.517137-8-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240802155524.517137-8-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/08/2024 16:55, David Hildenbrand wrote:
> Let's remove yet another follow_page() user. Note that we have to do the
> split without holding the PTL, after folio_walk_end(). We don't care
> about losing the secretmem check in follow_page().

Hi David,

Our (arm64) CI is showing a regression in split_huge_page_test from mm selftests from next-20240805 onwards. Navigating around a couple of other lurking bugs, I was able to bisect to this change (which smells about right).

Newly failing test:

# # ------------------------------
# # running ./split_huge_page_test
# # ------------------------------
# # TAP version 13
# # 1..12
# # Bail out! Still AnonHugePages not split
# # # Planned tests != run tests (12 != 0)
# # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
# # [FAIL]
# not ok 52 split_huge_page_test # exit=1

It's trying to split some pmd-mapped THPs then checking and finding that they are not split. The split is requested via /sys/kernel/debug/split_huge_pages, which I believe ends up in this function you are modifying here. Although I'll admit that looking at the change, there is nothing obviously wrong! Any ideas?

bisect log:

# bad: [1e391b34f6aa043c7afa40a2103163a0ef06d179] Add linux-next specific files for 20240806
git bisect bad 1e391b34f6aa043c7afa40a2103163a0ef06d179
# good: [de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed] Linux 6.11-rc2
git bisect good de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
# bad: [01c2d56f2c52e8af01dfd91af1fe9affc76c4c9e] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
git bisect bad 01c2d56f2c52e8af01dfd91af1fe9affc76c4c9e
# bad: [01c2d56f2c52e8af01dfd91af1fe9affc76c4c9e] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
git bisect bad 01c2d56f2c52e8af01dfd91af1fe9affc76c4c9e
# bad: [3610638e967f32f02c56c7cc8f7d6a815972f8c2] Merge branch 'for-linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
git bisect bad 3610638e967f32f02c56c7cc8f7d6a815972f8c2
# bad: [3610638e967f32f02c56c7cc8f7d6a815972f8c2] Merge branch 'for-linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
git bisect bad 3610638e967f32f02c56c7cc8f7d6a815972f8c2
# bad: [d35ef6c9d106eedff36908c21699e1b7f3e55584] Merge branch 'clang-format' of https://github.com/ojeda/linux.git
git bisect bad d35ef6c9d106eedff36908c21699e1b7f3e55584
# good: [e1a15959d75c9ba4b45e07e37bcf843c85750010] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect good e1a15959d75c9ba4b45e07e37bcf843c85750010
# good: [6d66cb9bdeceb769ce62591f56580ebe80f6267a] mm: swap: add a adaptive full cluster cache reclaim
git bisect good 6d66cb9bdeceb769ce62591f56580ebe80f6267a
# bad: [2b820b576dfc4aa9b65f18b68f468cb5b38ece84] mm: optimization on page allocation when CMA enabled
git bisect bad 2b820b576dfc4aa9b65f18b68f468cb5b38ece84
# bad: [ab70279848c8623027791799492a3f6e7c38a9b2] MIPS: sgi-ip27: drop HAVE_ARCH_NODEDATA_EXTENSION
git bisect bad ab70279848c8623027791799492a3f6e7c38a9b2
# bad: [539bc09ff00b29eb60f3dc8ed2d82ad2050a582d] mm/huge_memory: convert split_huge_pages_pid() from follow_page() to folio_walk
git bisect bad 539bc09ff00b29eb60f3dc8ed2d82ad2050a582d
# good: [1a37544d0e35340ce740d377d7d6c746a84e2aae] include/linux/mmzone.h: clean up watermark accessors
git bisect good 1a37544d0e35340ce740d377d7d6c746a84e2aae
# good: [22adafb60d6e1a607a3d99da90927ddd7df928ad] mm/migrate: convert do_pages_stat_array() from follow_page() to folio_walk
git bisect good 22adafb60d6e1a607a3d99da90927ddd7df928ad
# good: [57e1ccf54dba4dda6d6f0264b76e2b86eec3d401] mm/ksm: convert get_mergeable_page() from follow_page() to folio_walk
git bisect good 57e1ccf54dba4dda6d6f0264b76e2b86eec3d401
# good: [285aa1a963f310530351b0e4a2e64bc4b806e518] mm/ksm: convert scan_get_next_rmap_item() from follow_page() to folio_walk
git bisect good 285aa1a963f310530351b0e4a2e64bc4b806e518
# first bad commit: [539bc09ff00b29eb60f3dc8ed2d82ad2050a582d] mm/huge_memory: convert split_huge_pages_pid() from follow_page() to folio_walk

Thanks,
Ryan


> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0167dc27e365..697fcf89f975 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -40,6 +40,7 @@
>  #include <linux/memory-tiers.h>
>  #include <linux/compat.h>
>  #include <linux/pgalloc_tag.h>
> +#include <linux/pagewalk.h>
>  
>  #include <asm/tlb.h>
>  #include <asm/pgalloc.h>
> @@ -3507,7 +3508,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  	 */
>  	for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
>  		struct vm_area_struct *vma = vma_lookup(mm, addr);
> -		struct page *page;
> +		struct folio_walk fw;
>  		struct folio *folio;
>  
>  		if (!vma)
> @@ -3519,13 +3520,10 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  			continue;
>  		}
>  
> -		/* FOLL_DUMP to ignore special (like zero) pages */
> -		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> -
> -		if (IS_ERR_OR_NULL(page))
> +		folio = folio_walk_start(&fw, vma, addr, 0);
> +		if (!folio)
>  			continue;
>  
> -		folio = page_folio(page);
>  		if (!is_transparent_hugepage(folio))
>  			goto next;
>  
> @@ -3544,13 +3542,19 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  
>  		if (!folio_trylock(folio))
>  			goto next;
> +		folio_get(folio);
> +		folio_walk_end(&fw, vma);
>  
>  		if (!split_folio_to_order(folio, new_order))
>  			split++;
>  
>  		folio_unlock(folio);
> -next:
>  		folio_put(folio);
> +
> +		cond_resched();
> +		continue;
> +next:
> +		folio_walk_end(&fw, vma);
>  		cond_resched();
>  	}
>  	mmap_read_unlock(mm);


