Return-Path: <linux-fsdevel+bounces-67587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C4DC43E68
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 14:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FDC188A16E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED32F6597;
	Sun,  9 Nov 2025 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPHa1AiU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F752F6199
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762693860; cv=none; b=FBPnJsByzCQXBxuctwrPV5pKC4ZYZLOx5kFYG7RkUeoMhI3uV7CUjcOeNo0t5/AKjYAIrz9u3+ZRvBmKAzPUu/2RhAaecupKRpO6AGv69sjdUkPbtsowWeGg8pmrS0tqXwt9JoHaqBdvOlkUkYYrg80U4SO5GKSn5G4KEJruOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762693860; c=relaxed/simple;
	bh=NnSoECfC7HDUZWeEocUxEKjYCg5JMU8aKAcSsGGo+G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gm8QmBPJVu5AdICgt9RgKyFGUPvBGlhVvh0VtuLYapKnicsKmIbqNDVvPh6yRjfvu9+zamRM1kBc5NYd+sggR3VqMKFjrfh0IP6ZcLNsNbs24k7okNdbx7hCpSrjLvha6zg8Hg3kHUMS+jzdGvs2YY3yp+BDAvgz+hsh5pR33rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPHa1AiU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso1071744a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 05:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762693856; x=1763298656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKARBXSwr1aXmZWX6tJUZ+Zm/9hq/LiOLLKvc+8uGy4=;
        b=TPHa1AiUM0herARVujkZ6X2VRY3gqnYd9AF8e4hTLKWQaf7DkBMZENsV3ryBW/dqGg
         6/JOVks/TS8z7D6EI52VewXsyzpRwKcMlxoWR+zOnMBx9xdWwgjw4hWkIJ6OkD+4bYRb
         Rp/NqIGpdYLzD8T4mORRoFewgRrOm523V9H/HwEJ3swm4wwWzfD1AORdSsqd0Nk36GQp
         BbR0ZjoCus2ryKmARmWH270UAXZscBVpchaViAwsYyA2ye/w6fwIHzyimTCjNvHvyir3
         rp8kdNKcm2gDNaFsA+93TGsAf1GLFOx/ZO0ZWlBZVOeKbCBpmfNLu2a31tSJzstvTgIs
         GuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762693856; x=1763298656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JKARBXSwr1aXmZWX6tJUZ+Zm/9hq/LiOLLKvc+8uGy4=;
        b=a05HGBD0+Eeg1I5oa9yN0zeAmx+gt7HO80xhiRoECCD+P8zabWorB4xZHWP/1PArlJ
         rNE2AwmwwSmu9CyNBFLqqiXer6zSgr937Jm4eoIyI4W8nGuG9y0VmFPWk3uWYj2+QbRO
         8uWDbsz6Am/oYyTirVfxfBeimB5cc42Hd0rvEOTjuJRqE3ZL/KbfyqxFo3tqCoqQkC3D
         szcWCOx/ZsuKbrEILSfGi9Gb1U2BK1+p+0kdzQe/WoJsqWlJQmmnc2POdHrojRZgVDct
         IKge29CnAasoeTYX0PSYdEgWM5W4qK14An0aXJTOV0aSpGz+ySTCAiSe3ATXX3KTEwiR
         qzDg==
X-Forwarded-Encrypted: i=1; AJvYcCVSBhFX708P6Ia/MQkJaHjwDdVVt16cdhF2pa3d48KcwiQhckCJFyLf7IoWFHXhNWlVoWz6LjsPHEQhbQKP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa1L4hBgcLke6MfSd62kTogeFffYb55gGto2SNIHj2DxENzpvt
	X2ucdbB/G7Jkko8HSB14wWemQ1p64P8Z6AedWhifTL5Fig6aPNe7Y9Z/Yc68BSXZ9l4F1HLKMX5
	uitrM1TZMmcmUEaOIKcg3LPjddKyyFls=
X-Gm-Gg: ASbGncuqfHsvJhKznoGnzPkBoRaLUwGc6B9W5kOJ/EiF6Vc1sHKDGG1JSHc55BWkYc9
	icaz5Zcfxg0uS3JQqc+AaMIWDDzLaOTELt1xnyJirBhaf7Co1TS4cPg/yxXDveCw0BD3/8SRVhs
	UwSQ6YkRpClz0UA9R0POv+Bqa06Gmd9SaD0nc4GUeAVJ2bnVE27ZfC7+Bnzs+mfdS7kDik/UAe9
	BA2E2A7IpVs4yT3D5zBNxWMKdYhSD+O8D8JbNPT1nX8iqDcwHiJSj4lCL9TpzxXlFCpZA0=
X-Google-Smtp-Source: AGHT+IEl9MW22IQb8cz6gkNnRNDIsMMkyhNIsn4ivK8T6yzVCykEJxEU+foa+7QckGYATPbFT8xxfS3qce8kjw2WQNA=
X-Received: by 2002:a05:6402:2707:b0:640:c2df:f00a with SMTP id
 4fb4d7f45d1cf-6415dc128edmr3509625a12.9.1762693855567; Sun, 09 Nov 2025
 05:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com> <cd103d9bdc8c0dbb63a0361599b02081520191b4.1762621568.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <cd103d9bdc8c0dbb63a0361599b02081520191b4.1762621568.git.lorenzo.stoakes@oracle.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 9 Nov 2025 21:10:18 +0800
X-Gm-Features: AWmQ_bmfH3ksRfR0A2K2gyRnNJuT_yTKuVqefgY6nG1gVo5-Pc4ryZAWbXuQhCE
Message-ID: <CAMgjq7B1AzqGk7nSxwY_paTxeJt8-=+T+2Wc6dBT_6XfGFhGvA@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] mm: introduce leaf entry type and use to
 simplify leaf entry logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, 
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Pedro Falcato <pfalcato@suse.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 1:41=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> The kernel maintains leaf page table entries which contain either:
>
> - Nothing ('none' entries)
> - Present entries (that is stuff the hardware can navigate without fault)
> - Everything else that will cause a fault which the kernel handles
>
> In the 'everything else' group we include swap entries, but we also inclu=
de
> a number of other things such as migration entries, device private entrie=
s
> and marker entries.
>
> Unfortunately this 'everything else' group expresses everything through
> a swp_entry_t type, and these entries are referred to swap entries even
> though they may well not contain a... swap entry.
>
> This is compounded by the rather mind-boggling concept of a non-swap swap
> entry (checked via non_swap_entry()) and the means by which we twist and
> turn to satisfy this.
>
> This patch lays the foundation for reducing this confusion.
>
> We refer to 'everything else' as a 'software-define leaf entry' or
> 'softleaf'. for short And in fact we scoop up the 'none' entries into thi=
s
> concept also so we are left with:
>
> - Present entries.
> - Softleaf entries (which may be empty).
>
> This allows for radical simplification across the board - one can simply
> convert any leaf page table entry to a leaf entry via softleaf_from_pte()=
.
>
> If the entry is present, we return an empty leaf entry, so it is assumed
> the caller is aware that they must differentiate between the two categori=
es
> of page table entries, checking for the former via pte_present().
>
> As a result, we can eliminate a number of places where we would otherwise
> need to use predicates to see if we can proceed with leaf page table entr=
y
> conversion and instead just go ahead and do it unconditionally.
>
> We do so where we can, adjusting surrounding logic as necessary to
> integrate the new softleaf_t logic as far as seems reasonable at this
> stage.
>
> We typedef swp_entry_t to softleaf_t for the time being until the
> conversion can be complete, meaning everything remains compatible
> regardless of which type is used. We will eventually remove swp_entry_t
> when the conversion is complete.
>
> We introduce a new header file to keep things clear - leafops.h - this
> imports swapops.h so can direct replace swapops imports without issue, an=
d
> we do so in all the files that require it.
>
> Additionally, add new leafops.h file to core mm maintainers entry.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  MAINTAINERS                   |   1 +
>  fs/proc/task_mmu.c            |  26 +--
>  fs/userfaultfd.c              |   6 +-
>  include/linux/leafops.h       | 382 ++++++++++++++++++++++++++++++++++
>  include/linux/mm_inline.h     |   6 +-
>  include/linux/mm_types.h      |  25 +++
>  include/linux/swapops.h       |  28 ---
>  include/linux/userfaultfd_k.h |  51 +----
>  mm/hmm.c                      |   2 +-
>  mm/hugetlb.c                  |  37 ++--
>  mm/madvise.c                  |  16 +-
>  mm/memory.c                   |  41 ++--
>  mm/mincore.c                  |   6 +-
>  mm/mprotect.c                 |   6 +-
>  mm/mremap.c                   |   4 +-
>  mm/page_vma_mapped.c          |  11 +-
>  mm/shmem.c                    |   7 +-
>  mm/userfaultfd.c              |   6 +-
>  18 files changed, 497 insertions(+), 164 deletions(-)
>  create mode 100644 include/linux/leafops.h

Hi Lorenzo,

Thanks, overloading swap entry types for things like migration always
looked confusing to me.

There is a problem with this patch as I mentioned here:
https://lore.kernel.org/linux-mm/CAMgjq7AP383YfU3L5ZxJ9U3x-vRPnEkEUtmnPdXD2=
9HiNC8OrA@mail.gmail.com/

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2628431dcdfe..314910a70bbf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16257,6 +16257,7 @@ T:      git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/akpm/mm
>  F:     include/linux/gfp.h
>  F:     include/linux/gfp_types.h
>  F:     include/linux/highmem.h
> +F:     include/linux/leafops.h
>  F:     include/linux/memory.h
>  F:     include/linux/mm.h
>  F:     include/linux/mm_*.h
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index fc35a0543f01..24d26b49d870 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -14,7 +14,7 @@
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
>  #include <linux/sched/mm.h>
> -#include <linux/swapops.h>
> +#include <linux/leafops.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/page_idle.h>
>  #include <linux/shmem_fs.h>
> @@ -1230,11 +1230,11 @@ static int smaps_hugetlb_range(pte_t *pte, unsign=
ed long hmask,
>         if (pte_present(ptent)) {
>                 folio =3D page_folio(pte_page(ptent));
>                 present =3D true;
> -       } else if (is_swap_pte(ptent)) {
> -               swp_entry_t swpent =3D pte_to_swp_entry(ptent);
> +       } else {
> +               const softleaf_t entry =3D softleaf_from_pte(ptent);
>
> -               if (is_pfn_swap_entry(swpent))
> -                       folio =3D pfn_swap_entry_folio(swpent);
> +               if (softleaf_has_pfn(entry))
> +                       folio =3D softleaf_to_folio(entry);
>         }
>
>         if (folio) {
> @@ -1955,9 +1955,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct =
pagemapread *pm,
>                 flags |=3D PM_SWAP;
>                 if (is_pfn_swap_entry(entry))
>                         page =3D pfn_swap_entry_to_page(entry);
> -               if (pte_marker_entry_uffd_wp(entry))
> +               if (softleaf_is_uffd_wp_marker(entry))
>                         flags |=3D PM_UFFD_WP;
> -               if (is_guard_swp_entry(entry))
> +               if (softleaf_is_guard_marker(entry))
>                         flags |=3D  PM_GUARD_REGION;
>         }
>
> @@ -2330,18 +2330,18 @@ static unsigned long pagemap_page_category(struct=
 pagemap_scan_private *p,
>                 if (pte_soft_dirty(pte))
>                         categories |=3D PAGE_IS_SOFT_DIRTY;
>         } else if (is_swap_pte(pte)) {
> -               swp_entry_t swp;
> +               softleaf_t entry;
>
>                 categories |=3D PAGE_IS_SWAPPED;
>                 if (!pte_swp_uffd_wp_any(pte))
>                         categories |=3D PAGE_IS_WRITTEN;
>
> -               swp =3D pte_to_swp_entry(pte);
> -               if (is_guard_swp_entry(swp))
> +               entry =3D softleaf_from_pte(pte);
> +               if (softleaf_is_guard_marker(entry))
>                         categories |=3D PAGE_IS_GUARD;
>                 else if ((p->masks_of_interest & PAGE_IS_FILE) &&
> -                        is_pfn_swap_entry(swp) &&
> -                        !folio_test_anon(pfn_swap_entry_folio(swp)))
> +                        softleaf_has_pfn(entry) &&
> +                        !folio_test_anon(softleaf_to_folio(entry)))
>                         categories |=3D PAGE_IS_FILE;
>
>                 if (pte_swp_soft_dirty(pte))
> @@ -2466,7 +2466,7 @@ static void make_uffd_wp_huge_pte(struct vm_area_st=
ruct *vma,
>  {
>         unsigned long psize;
>
> -       if (is_hugetlb_entry_hwpoisoned(ptent) || is_pte_marker(ptent))
> +       if (is_hugetlb_entry_hwpoisoned(ptent) || pte_is_marker(ptent))
>                 return;
>
>         psize =3D huge_page_size(hstate_vma(vma));
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 04c66b5001d5..e33e7df36927 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -29,7 +29,7 @@
>  #include <linux/ioctl.h>
>  #include <linux/security.h>
>  #include <linux/hugetlb.h>
> -#include <linux/swapops.h>
> +#include <linux/leafops.h>
>  #include <linux/miscdevice.h>
>  #include <linux/uio.h>
>
> @@ -251,7 +251,7 @@ static inline bool userfaultfd_huge_must_wait(struct =
userfaultfd_ctx *ctx,
>         if (huge_pte_none(pte))
>                 return true;
>         /* UFFD PTE markers require handling. */
> -       if (is_uffd_pte_marker(pte))
> +       if (pte_is_uffd_marker(pte))
>                 return true;
>         /* If VMA has UFFD WP faults enabled and WP fault, wait for handl=
er. */
>         if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
> @@ -330,7 +330,7 @@ static inline bool userfaultfd_must_wait(struct userf=
aultfd_ctx *ctx,
>         if (pte_none(ptent))
>                 goto out;
>         /* UFFD PTE markers require handling. */
> -       if (is_uffd_pte_marker(ptent))
> +       if (pte_is_uffd_marker(ptent))
>                 goto out;
>         /* If VMA has UFFD WP faults enabled and WP fault, wait for handl=
er. */
>         if (!pte_write(ptent) && (reason & VM_UFFD_WP))
> diff --git a/include/linux/leafops.h b/include/linux/leafops.h
> new file mode 100644
> index 000000000000..1376589d94b0
> --- /dev/null
> +++ b/include/linux/leafops.h
> @@ -0,0 +1,382 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Describes operations that can be performed on software-defined page t=
able
> + * leaf entries. These are abstracted from the hardware page table entri=
es
> + * themselves by the softleaf_t type, see mm_types.h.
> + */
> +#ifndef _LINUX_LEAFOPS_H
> +#define _LINUX_LEAFOPS_H
> +
> +#include <linux/mm_types.h>
> +#include <linux/swapops.h>
> +#include <linux/swap.h>
> +
> +#ifdef CONFIG_MMU
> +
> +/* Temporary until swp_entry_t eliminated. */
> +#define LEAF_TYPE_SHIFT SWP_TYPE_SHIFT
> +
> +enum softleaf_type {
> +       /* Fundamental types. */
> +       SOFTLEAF_NONE,
> +       SOFTLEAF_SWAP,
> +       /* Migration types. */
> +       SOFTLEAF_MIGRATION_READ,
> +       SOFTLEAF_MIGRATION_READ_EXCLUSIVE,
> +       SOFTLEAF_MIGRATION_WRITE,
> +       /* Device types. */
> +       SOFTLEAF_DEVICE_PRIVATE_READ,
> +       SOFTLEAF_DEVICE_PRIVATE_WRITE,
> +       SOFTLEAF_DEVICE_EXCLUSIVE,
> +       /* H/W posion types. */
> +       SOFTLEAF_HWPOISON,
> +       /* Marker types. */
> +       SOFTLEAF_MARKER,
> +};
> +
> +/**
> + * softleaf_mk_none() - Create an empty ('none') leaf entry.
> + * Returns: empty leaf entry.
> + */
> +static inline softleaf_t softleaf_mk_none(void)
> +{
> +       return ((softleaf_t) { 0 });
> +}
> +
> +/**
> + * softleaf_from_pte() - Obtain a leaf entry from a PTE entry.
> + * @pte: PTE entry.
> + *
> + * If @pte is present (therefore not a leaf entry) the function returns =
an empty
> + * leaf entry. Otherwise, it returns a leaf entry.
> + *
> + * Returns: Leaf entry.
> + */
> +static inline softleaf_t softleaf_from_pte(pte_t pte)
> +{
> +       if (pte_present(pte))
> +               return softleaf_mk_none();
> +
> +       /* Temporary until swp_entry_t eliminated. */
> +       return pte_to_swp_entry(pte);
> +}
> +
> +/**
> + * softleaf_is_none() - Is the leaf entry empty?
> + * @entry: Leaf entry.
> + *
> + * Empty entries are typically the result of a 'none' page table leaf en=
try
> + * being converted to a leaf entry.
> + *
> + * Returns: true if the entry is empty, false otherwise.
> + */
> +static inline bool softleaf_is_none(softleaf_t entry)
> +{
> +       return entry.val =3D=3D 0;
> +}
> +
> +/**
> + * softleaf_type() - Identify the type of leaf entry.
> + * @enntry: Leaf entry.
> + *
> + * Returns: the leaf entry type associated with @entry.
> + */
> +static inline enum softleaf_type softleaf_type(softleaf_t entry)
> +{
> +       unsigned int type_num;
> +
> +       if (softleaf_is_none(entry))
> +               return SOFTLEAF_NONE;
> +
> +       type_num =3D entry.val >> LEAF_TYPE_SHIFT;
> +
> +       if (type_num < MAX_SWAPFILES)
> +               return SOFTLEAF_SWAP;
> +
> +       switch (type_num) {
> +#ifdef CONFIG_MIGRATION
> +       case SWP_MIGRATION_READ:
> +               return SOFTLEAF_MIGRATION_READ;
> +       case SWP_MIGRATION_READ_EXCLUSIVE:
> +               return SOFTLEAF_MIGRATION_READ_EXCLUSIVE;
> +       case SWP_MIGRATION_WRITE:
> +               return SOFTLEAF_MIGRATION_WRITE;
> +#endif
> +#ifdef CONFIG_DEVICE_PRIVATE
> +       case SWP_DEVICE_WRITE:
> +               return SOFTLEAF_DEVICE_PRIVATE_WRITE;
> +       case SWP_DEVICE_READ:
> +               return SOFTLEAF_DEVICE_PRIVATE_READ;
> +       case SWP_DEVICE_EXCLUSIVE:
> +               return SOFTLEAF_DEVICE_EXCLUSIVE;
> +#endif
> +#ifdef CONFIG_MEMORY_FAILURE
> +       case SWP_HWPOISON:
> +               return SOFTLEAF_HWPOISON;
> +#endif
> +       case SWP_PTE_MARKER:
> +               return SOFTLEAF_MARKER;
> +       }
> +
> +       /* Unknown entry type. */
> +       VM_WARN_ON_ONCE(1);
> +       return SOFTLEAF_NONE;
> +}
> +
> +/**
> + * softleaf_is_swap() - Is this leaf entry a swap entry?
> + * @entry: Leaf entry.
> + *
> + * Returns: true if the leaf entry is a swap entry, otherwise false.
> + */
> +static inline bool softleaf_is_swap(softleaf_t entry)
> +{
> +       return softleaf_type(entry) =3D=3D SOFTLEAF_SWAP;
> +}
> +
> +/**
> + * softleaf_is_swap() - Is this leaf entry a migration entry?
> + * @entry: Leaf entry.
> + *
> + * Returns: true if the leaf entry is a migration entry, otherwise false=
.
> + */
> +static inline bool softleaf_is_migration(softleaf_t entry)

And a nitpick here, the kerneldoc above doesn't match the function name her=
e.

And now swap functions (swap_cache_*) that expects a swp_entry_t is
getting a softleaf_t instead, they are the same thing right now, so
that's fine. Will we need something like a softleaf_to_swap?

