Return-Path: <linux-fsdevel+bounces-47028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C869FA97DE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268997ACA2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 04:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC358266572;
	Wed, 23 Apr 2025 04:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn8hPlvj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801826656A;
	Wed, 23 Apr 2025 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745383372; cv=none; b=MxBRaCVNVJp5HAoh88A2CJ5e+kmKc4L5pSst5ca7Ufhed8ZuUbNJRc+2AT02a1NTybT89tJeweroTmpoegOKmkwchD9BGL2KAK0VPPu2/aTOn879x6IsJkyMnMh9YWg/jY7QToDz/INRAtgfGR+FmrDIzxXLCZBQFATFmg/QOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745383372; c=relaxed/simple;
	bh=eB2CZHb0WVwwcVIXuRgXRUHtxGtgdPPys00kumbdgQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EM6kLKODxzdfgFbW9WdCeL0Y8Em642J97G5l990n9eO9ybLvjPnjE202Dl/AJ08C9Rb/Ih1Tev0O737MUPiGFkW6SspkRj8moQlXJhZnzBWnImUy//anJ2RqZi9a4SEdHO8esK3MN48fgDAzNAfwUiJMA3U+Np9N33bNTCUgDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn8hPlvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0C3C4CEF2;
	Wed, 23 Apr 2025 04:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745383371;
	bh=eB2CZHb0WVwwcVIXuRgXRUHtxGtgdPPys00kumbdgQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zn8hPlvjTxZEUGF3r3dC0uCY4x7lwS+UhKUPwnLXyJBVzxbGIF+WsRykUyeojNRTt
	 zq0nKwFcb6b6Ra8vRnBNvtVLl/V2GtWMelQSNR5jXSmXBqlja/+H3phgSJ2UZ4b5Y5
	 NW9NiawDYGuGtu/DhO8k2mA7/vjimhk3rpWLUGlamke7VVPulHSMnWoyBqxkssFE4q
	 gsCageUyYr98BPSjPjhqGlgeS8wOZl3S0IvrVR1tRqgqeQltMNZIaA1R90/q+6ex1n
	 mU8K4EYc3/nfAas8L4MQLBJLAJQe7Eel6wv5iEYVXil6jhewwKD8W8Ak3vdpJFrogu
	 7XHbEP2zaSZeQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac25520a289so778385866b.3;
        Tue, 22 Apr 2025 21:42:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDpRKKUHGFIxErIJ9ZZaOuOee0YHMoCwqAo4k9gdzsAt78obQVPaFsqqYxxByDkyA6AX9Gte3b8Gw2O8w7@vger.kernel.org, AJvYcCXdmUn1+lBKTgPxdQBAGPOrUyTGbj5QUe11MZxxv5J7egWAjvN5KjyYfrHfQftQ0lVYJIi6bIlT/HVFe1dh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv8EV3prlAekijeyJobLWA3xyY6rGcaUv5M+u36z/p+ft3LHnS
	RVXyIcg3EcmsFdVNyXGQoB8nds4ucWdTSGUr1cW6ANc8QqSFp+bf5bJRF3IJJiPzIdVvzp9ZQSD
	yc4abxaMe3iDF9rZJvSNPet9QSF4=
X-Google-Smtp-Source: AGHT+IElbU/Xu8BCdaTD32626AOwRjpxyqNecTmdVoitv1WKpBCsyDEmPUgUkY0l5x0O+/tZzfrkNkmBIThiisAkkug=
X-Received: by 2002:a17:907:7288:b0:aca:a383:b0c9 with SMTP id
 a640c23a62f3a-acb74afba44mr1582732666b.13.1745383370146; Tue, 22 Apr 2025
 21:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423010359.2030576-1-wangming01@loongson.cn>
In-Reply-To: <20250423010359.2030576-1-wangming01@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 23 Apr 2025 12:42:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5gVvJhHHU_7XGGry7GJmKmzf_PNiCEdv16BiEZv2rhww@mail.gmail.com>
X-Gm-Features: ATxdqUE-Z4nHGbctDyJOb3PVxOkgCXoATsuuX1DqcXM7KICHGeIn0TMw-Au_Kkg
Message-ID: <CAAhV-H5gVvJhHHU_7XGGry7GJmKmzf_PNiCEdv16BiEZv2rhww@mail.gmail.com>
Subject: Re: [PATCH] smaps: Fix crash in smaps_hugetlb_range for non-present
 hugetlb entries
To: Ming Wang <wangming01@loongson.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Michal Hocko <mhocko@suse.cz>, David Rientjes <rientjes@google.com>, Joern Engel <joern@logfs.org>, 
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, lixuefeng@loongson.cn, 
	Hongchen Zhang <zhanghongchen@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Wangming,

On Wed, Apr 23, 2025 at 9:04=E2=80=AFAM Ming Wang <wangming01@loongson.cn> =
wrote:
>
> When reading /proc/pid/smaps for a process that has mapped a hugetlbfs
> file with MAP_PRIVATE, the kernel might crash inside pfn_swap_entry_to_pa=
ge.
> This occurs on LoongArch under specific conditions.
>
> The root cause involves several steps:
> 1. When the hugetlbfs file is mapped (MAP_PRIVATE), the initial PMD
>    (or relevant level) entry is often populated by the kernel during mmap=
()
>    with a non-present entry pointing to the architecture's invalid_pte_ta=
ble
>    On the affected LoongArch system, this address was observed to
>    be 0x90000000031e4000.
> 2. The smaps walker (walk_hugetlb_range -> smaps_hugetlb_range) reads
>    this entry.
> 3. The generic is_swap_pte() macro checks `!pte_present() && !pte_none()`=
.
>    The entry (invalid_pte_table address) is not present. Crucially,
>    the generic pte_none() check (`!(pte_val(pte) & ~_PAGE_GLOBAL)`)
>    returns false because the invalid_pte_table address is non-zero.
>    Therefore, is_swap_pte() incorrectly returns true.
> 4. The code enters the `else if (is_swap_pte(...))` block.
> 5. Inside this block, it checks `is_pfn_swap_entry()`. Due to a bit
>    pattern coincidence in the invalid_pte_table address on LoongArch,
>    the embedded generic `is_migration_entry()` check happens to return
>    true (misinterpreting parts of the address as a migration type).
> 6. This leads to a call to pfn_swap_entry_to_page() with the bogus
>    swap entry derived from the invalid table address.
> 7. pfn_swap_entry_to_page() extracts a meaningless PFN, finds an
>    unrelated struct page, checks its lock status (unlocked), and hits
>    the `BUG_ON(is_migration_entry(entry) && !PageLocked(p))` assertion.
>
> The original code's intent in the `else if` block seems aimed at handling
> potential migration entries, as indicated by the inner `is_pfn_swap_entry=
()`
> check. The issue arises because the outer `is_swap_pte()` check incorrect=
ly
> includes the invalid table pointer case on LoongArch.
>
> This patch fixes the issue by changing the condition in
> smaps_hugetlb_range() from the broad `is_swap_pte()` to the specific
> `is_hugetlb_entry_migration()`.
>
> The `is_hugetlb_entry_migration()` helper function correctly handles this
> by first checking `huge_pte_none()`. Architectures like LoongArch can
> provide an override for `huge_pte_none()` that specifically recognizes
> the `invalid_pte_table` address as a "none" state for HugeTLB entries.
> This ensures `is_hugetlb_entry_migration()` returns false for the invalid
> entry, preventing the code from entering the faulty block.
>
> This change makes the code reflect the likely original intent (handling
> migration) more accurately and leverages architecture-specific helpers
> (`huge_pte_none`) to correctly interpret special PTE/PMD values in the
> HugeTLB context, fixing the crash on LoongArch without altering the
> generic is_swap_pte() behavior.
>
> Fixes: 25ee01a2fca0 ("mm: hugetlb: proc: add hugetlb-related fields to /p=
roc/PID/smaps")
> Co-developed-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> ---
>  fs/proc/task_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 994cde10e3f4..95a0093ae87c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1027,7 +1027,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned=
 long hmask,
>         if (pte_present(ptent)) {
>                 folio =3D page_folio(pte_page(ptent));
>                 present =3D true;
> -       } else if (is_swap_pte(ptent)) {
> +       } else if (is_hugetlb_entry_migration(ptent)) {
Other functions in this file, such as pagemap_hugetlb_category(), may
need similar modifications.

Huacai

>                 swp_entry_t swpent =3D pte_to_swp_entry(ptent);
>
>                 if (is_pfn_swap_entry(swpent))
> --
> 2.43.0
>

