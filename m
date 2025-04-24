Return-Path: <linux-fsdevel+bounces-47233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719DBA9AD93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1D3465F8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA627A91D;
	Thu, 24 Apr 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clPc57TT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA443143C69;
	Thu, 24 Apr 2025 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498221; cv=none; b=Sz6DSdJ92ldnnRyOWX048Qh70MY24/W04Rloyt8LKJK7fMITibbCCq7tHcvnk4MPBEc/Qs1KX8V+gXaQSGP7i40MxCeoKBlRhr4NemVtd1xSXIA0Twb2yLiNEIGXAUwes3XU1WYXkPmqjfEB0R6VcJBWLAJl+lyg5V9F7AEWFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498221; c=relaxed/simple;
	bh=tk9hRRStedPVvY7uvjpSi9r3RhkLpQ5/0fbRdqJLXlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4Io8lm3wzl/+8kTVhm7CmIqaPqOo1UjFidWChL/8AkOozYL80rdMOtLy3PPxQk78RNUe0iHMhT9CC3uTOeRaJy28FlbuN+aa4i6OyMozsk/bpLhEAfbWfNIP6R1feeBzs3miCxDtmY+6XRN8YuUgsUMAfJC4m1YpA60qgT06c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clPc57TT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D19FC4CEF1;
	Thu, 24 Apr 2025 12:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745498221;
	bh=tk9hRRStedPVvY7uvjpSi9r3RhkLpQ5/0fbRdqJLXlo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=clPc57TTXvulDPN17ZLtiF5NF8s2cWPS65FB5JMInEPhwYPBKow3ZD5iI7DmYuy0W
	 djfhF1bdpwlWDxGDNDk09DbWoYLhrM9CD/mBVxC7IyPtI6NlKhKAb2YY26PIvASBRr
	 czwV7/gk9Vk0IqKLmsmIwmKHKsUFO2XOeHi4NdV2WUDDsPyGbApHm68/pOXKv4U6Ki
	 R7RVKjqMNVGcxq96+og1GeaLdNLnOadMOZoIn3cZZC/z2OGYxzmlD6dP8HaPPPhBXM
	 DvpZUSNdsYnOvCWIv5FSQQ87S7ZkARFx+nmN5HRcI3v7c1ZliHD9vJS55CuOiheNe5
	 hMSJIBIlys6Lw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f4b7211badso1516910a12.2;
        Thu, 24 Apr 2025 05:37:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJWSvT1ZlzcV4Mi0wsL3rgWR2U14DxR9GmTkKaINChjYL/I8pmDZR6uDZYRN66w6V7cmwrJ2TgVZ/Klvtk@vger.kernel.org, AJvYcCWPLfeS3TWbqzrlBUYYhdNI+JbHbsE9HDNtVEpw8XBK2/2lj8onXA+3o563wqDS5VWxrgkr6+FfedL+JZ6h@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzv1SXSvqwWTs6E+SnmYTHwdzmPBJ9pywqEwVjmRgG3D0pveaf
	KoTyDfTr7B5hiftLKmQlMTMRM9gBLgH/CK88rp7qqjWcl6hcPBh/XzIDTIslROw42onpsWwHffz
	ukdD06bzQ+nGdKX9ca8hEzAUFPes=
X-Google-Smtp-Source: AGHT+IFqHKEIiZCyV2lx8QIWsLbh8kJA+SfRcyM+NWe650kNmQcb1e4b9Kgn7bY31oqR6Kn58+XRu+C4dnWBOh0D4kk=
X-Received: by 2002:a17:907:9485:b0:acb:5f17:624d with SMTP id
 a640c23a62f3a-ace5751c1d9mr239880466b.57.1745498219705; Thu, 24 Apr 2025
 05:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423010359.2030576-1-wangming01@loongson.cn>
 <b64aea02-cc44-433a-8214-854feda2c06d@redhat.com> <14bc5d9c-7311-46ae-b46f-314a7ca649d5@loongson.cn>
 <e1f7bfa3-7418-4b4f-9339-c37e7e699c5e@redhat.com>
In-Reply-To: <e1f7bfa3-7418-4b4f-9339-c37e7e699c5e@redhat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 24 Apr 2025 20:36:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5SL_aqvx28h+szz1D2Up-m=GMv7KfdW0AFbdzH-TmeQA@mail.gmail.com>
X-Gm-Features: ATxdqUFIOUCV6uLv6vpiNx_ZuNrbC5OKKH6UvuFUHxKs5l6QBKHz083BMZna26E
Message-ID: <CAAhV-H5SL_aqvx28h+szz1D2Up-m=GMv7KfdW0AFbdzH-TmeQA@mail.gmail.com>
Subject: Re: [PATCH] smaps: Fix crash in smaps_hugetlb_range for non-present
 hugetlb entries
To: David Hildenbrand <david@redhat.com>
Cc: Ming Wang <wangming01@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Michal Hocko <mhocko@suse.cz>, David Rientjes <rientjes@google.com>, Joern Engel <joern@logfs.org>, 
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, lixuefeng@loongson.cn, 
	Hongchen Zhang <zhanghongchen@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 8:21=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 23.04.25 10:14, Ming Wang wrote:
> >
> >
> > On 4/23/25 15:07, David Hildenbrand wrote:
> >> On 23.04.25 03:03, Ming Wang wrote:
> >>> When reading /proc/pid/smaps for a process that has mapped a hugetlbf=
s
> >>> file with MAP_PRIVATE, the kernel might crash inside
> >>> pfn_swap_entry_to_page.
> >>> This occurs on LoongArch under specific conditions.
> >>>
> >>> The root cause involves several steps:
> >>> 1. When the hugetlbfs file is mapped (MAP_PRIVATE), the initial PMD
> >>>      (or relevant level) entry is often populated by the kernel durin=
g
> >>> mmap()
> >>>      with a non-present entry pointing to the architecture's
> >>> invalid_pte_table
> >>>      On the affected LoongArch system, this address was observed to
> >>>      be 0x90000000031e4000.
> >>> 2. The smaps walker (walk_hugetlb_range -> smaps_hugetlb_range) reads
> >>>      this entry.
> >>> 3. The generic is_swap_pte() macro checks `!pte_present() && !
> >>> pte_none()`.
> >>>      The entry (invalid_pte_table address) is not present. Crucially,
> >>>      the generic pte_none() check (`!(pte_val(pte) & ~_PAGE_GLOBAL)`)
> >>>      returns false because the invalid_pte_table address is non-zero.
> >>>      Therefore, is_swap_pte() incorrectly returns true.
> >>> 4. The code enters the `else if (is_swap_pte(...))` block.
> >>> 5. Inside this block, it checks `is_pfn_swap_entry()`. Due to a bit
> >>>      pattern coincidence in the invalid_pte_table address on LoongArc=
h,
> >>>      the embedded generic `is_migration_entry()` check happens to ret=
urn
> >>>      true (misinterpreting parts of the address as a migration type).
> >>> 6. This leads to a call to pfn_swap_entry_to_page() with the bogus
> >>>      swap entry derived from the invalid table address.
> >>> 7. pfn_swap_entry_to_page() extracts a meaningless PFN, finds an
> >>>      unrelated struct page, checks its lock status (unlocked), and hi=
ts
> >>>      the `BUG_ON(is_migration_entry(entry) && !PageLocked(p))` assert=
ion.
> >>>
> >>> The original code's intent in the `else if` block seems aimed at hand=
ling
> >>> potential migration entries, as indicated by the inner
> >>> `is_pfn_swap_entry()`
> >>> check. The issue arises because the outer `is_swap_pte()` check
> >>> incorrectly
> >>> includes the invalid table pointer case on LoongArch.
> >>
> >> This has a big loongarch smell to it.
> >>
> >> If we end up passing !pte_present() && !pte_none(), then loongarch mus=
t
> >> be fixed to filter out these weird non-present entries.
> >>
> >> is_swap_pte() must not succeed on something that is not an actual swap=
 pte.
> >>
> >
> > Hi David,
> >
> > Thanks a lot for your feedback and insightful analysis!
> >
> > You're absolutely right, the core issue here stems from how the generic
> > is_swap_pte() macro interacts with the specific value of
> > invalid_pte_table (or the equivalent invalid table entries for PMD) on
> > the LoongArch architecture. I agree that this has a strong LoongArch
> > characteristic.
> >
> > On the affected LoongArch system, the address used for invalid_pte_tabl=
e
> > (observed as 0x90000000031e4000 in the vmcore) happens to satisfy both
> > !pte_present() and !pte_none() conditions. This is because:
> > 1. It lacks the _PAGE_PRESENT and _PAGE_PROTNONE bits (correct for an
> > invalid entry).
> > 2. The generic pte_none() check (`!(pte_val(pte) & ~_PAGE_GLOBAL)`)
> > returns false, as the address value itself is non-zero and doesn't matc=
h
> > the all-zero (except global bit) pattern.
> > This causes is_swap_pte() to incorrectly return true for these
> > non-mapped, initial entries set up during mmap().
> >
> > The reason my proposed patch changes the condition in
> > smaps_hugetlb_range() from is_swap_pte(ptent) to
> > is_hugetlb_entry_migration(pte) is precisely to leverage an
> > **architecture-level filtering mechanism**, as you suggested LoongArch
> > should provide.
> >
> > This works because is_hugetlb_entry_migration() internally calls
> > `huge_pte_none()`. LoongArch **already provides** an
> > architecture-specific override for huge_pte_none() (via
> > `__HAVE_ARCH_HUGE_PTE_NONE`), which is defined as follows in
> > arch/loongarch/include/asm/pgtable.h:
> >
> > ```
> > static inline int huge_pte_none(pte_t pte)
> > {
> >       unsigned long val =3D pte_val(pte) & ~_PAGE_GLOBAL;
> >       /* Check for all zeros (except global) OR if it points to
> > invalid_pte_table */
> >       return !val || (val =3D=3D (unsigned long)invalid_pte_table);
> > }
> > ```
>
> There is now an alternative fix on the list, right?
>
> https://lore.kernel.org/loongarch/20250424083037.2226732-1-wangming01@loo=
ngson.cn/T/#u
Yes, that one is better.



Huacai

>
> --
> Cheers,
>
> David / dhildenb
>

