Return-Path: <linux-fsdevel+bounces-71750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2BCCD03DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 15:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9018C306D318
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE453314D1;
	Fri, 19 Dec 2025 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O717isD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1B33121B;
	Fri, 19 Dec 2025 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153700; cv=none; b=C1M6g443HuUjBs7Tl7BbARHseYtCX1f3q2IynjfMIfSknY3JIAxNHBwTrTuysnMoD5p8T3IwKhBfi1iThLyhhjT1+CZ6zEgrLy2qCdlV4bnSmOKmgy/ycmDgKhRAhQM+18WUHUM/ftnmH6KIDucJNMqAWoxcR0o6b1aeQL3qjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153700; c=relaxed/simple;
	bh=h9gatBXLPknkA9XB/kDpWVDHKRf+rqWFuU1zgf9gItM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8ZcEzkV6lae7U+ZUu3a9K0j7Udy40id61LeTOH4FtVjQ3OZNueiBmC7VBNFqzqdtHlRjOtzb46UNhMnPUTa13+c1c2hm4+SpPKaQj34QxbEfqR7iI6HHPdYcQo+2phRCdaN6iMScyGPBEwqUyolviZzLIiBh/IrRWAelNvYSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O717isD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405DDC4CEF1;
	Fri, 19 Dec 2025 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766153699;
	bh=h9gatBXLPknkA9XB/kDpWVDHKRf+rqWFuU1zgf9gItM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O717isD1mHBm5W4zYOFNoyxyRF7E9NbvNqjbXcL4AhlmDAOPyLQ33+Kr9Lv7uuq14
	 ohp1+/WYbEhEL/CST8pbWNnvW1sAS2iIOYrj8+0JrEqqvx3mvCjjI/LgdiYcd93cL6
	 HCAERNkf2egSFz2ikTO1H4RjquN2pCH+Ajbdo0teEkX5FcAq1oLo+JGYJGghTlxmjQ
	 5XqtpYvGZgHHWjpDNXYlBjZubxrTfFTk59FwbQz6CINzp98bvVwDsuCxsSD9bDXoaa
	 ItcakAYKMnhUHmAucPOMJcoLlPH8n1AtCbGfuHdvDf/Gqm1zCOuRrh8nrgPdf8np1P
	 yE+NKtFJE/Bzw==
Message-ID: <3f3e2e99-cf87-4498-93a7-700ecb42a2a9@kernel.org>
Date: Fri, 19 Dec 2025 15:14:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/memremap: fix spurious large folio warning for
 FS-DAX
To: John Groves <John@Groves.net>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: John Groves <jgroves@micron.com>, "Darrick J . Wong" <djwong@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Gregory Price <gourry@gourry.net>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Aravind Ramesh <arramesh@micron.com>,
 Ajay Joshi <ajayjoshi@micron.com>
References: <20251219123717.39330-1-john@groves.net>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251219123717.39330-1-john@groves.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 13:37, John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> This patch addresses a warning that I discovered while working on famfs,
> which is an fs-dax file system that virtually always does PMD faults
> (next famfs patch series coming after the holidays).
> 
> However, XFS also does PMD faults in fs-dax mode, and it also triggers
> the warning. It takes some effort to get XFS to do a PMD fault, but
> instructions to reproduce it are below.
> 
> The VM_WARN_ON_ONCE(folio_test_large(folio)) check in
> free_zone_device_folio() incorrectly triggers for MEMORY_DEVICE_FS_DAX
> when PMD (2MB) mappings are used.
> 
> FS-DAX legitimately creates large file-backed folios when handling PMD
> faults. This is a core feature of FS-DAX that provides significant
> performance benefits by mapping 2MB regions directly to persistent
> memory. When these mappings are unmapped, the large folios are freed
> through free_zone_device_folio(), which triggers the spurious warning.
> 
> The warning was introduced by commit that added support for large zone
> device private folios. However, that commit did not account for FS-DAX
> file-backed folios, which have always supported large (PMD-sized)
> mappings.
> 
> The check distinguishes between anonymous folios (which clear
> AnonExclusive flags for each sub-page) and file-backed folios. For
> file-backed folios, it assumes large folios are unexpected - but this
> assumption is incorrect for FS-DAX.
> 
> The fix is to exempt MEMORY_DEVICE_FS_DAX from the large folio warning,
> allowing FS-DAX to continue using PMD mappings without triggering false
> warnings.
> 
> Fixes: d245f9b4ab80 ("mm/zone_device: support large zone device private folios")
> Signed-off-by: John Groves <john@groves.net>
> ---
> 
> Change since V1: Deleted the warning altogether, rather than exempting
> fs-dax.
> 
> === How to reproduce ===
> 
> A reproducer is available at:
> 
>      git clone https://github.com/jagalactic/dax-pmd-test.git
>      cd xfs-dax-test
>      make
>      sudo make test
> 
> This will set up XFS on pmem with 2MB stripe alignment and run a test
> that triggers the warning.
> 
> Alternatively, follow the manual steps below.
> 
> Prerequisites:
>    - Linux kernel with FS-DAX support and CONFIG_DEBUG_VM=y
>    - A pmem device (real or emulated)
>    - An fsdax namespace configured via ndctl as /dev/pmem0
> 
> Manual steps:
> 
> 1. Create an fsdax namespace (if not already present):
>     # ndctl create-namespace -m fsdax -e namespace0.0
> 
> 2. Create XFS with 2MB stripe alignment:
>     # mkfs.xfs -f -d su=2m,sw=1 /dev/pmem0
>     # mount -o dax /dev/pmem0 /mnt/pmem
> 
> 3. Compile and run the reproducer:
>     # gcc -Wall -O2 -o dax_pmd_test dax_pmd_test.c
>     # ./dax_pmd_test /mnt/pmem/testfile
> 
> 4. Check dmesg for the warning:
>     WARNING: mm/memremap.c:431 at free_zone_device_folio+0x.../0x...
> 
> Note: The 2MB stripe alignment (-d su=2m,sw=1) is critical. XFS normally
> allocates blocks at arbitrary offsets, causing PMD faults to fall back
> to PTE faults. The stripe alignment forces 2MB-aligned allocations,
> allowing PMD faults to succeed and exposing this bug.
> 
> 
>   mm/memremap.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 4c2e0d68eb27..63c6ab4fdf08 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -427,8 +427,6 @@ void free_zone_device_folio(struct folio *folio)
>   	if (folio_test_anon(folio)) {
>   		for (i = 0; i < nr; i++)
>   			__ClearPageAnonExclusive(folio_page(folio, i));
> -	} else {
> -		VM_WARN_ON_ONCE(folio_test_large(folio));
>   	}
>   

LGTM

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

