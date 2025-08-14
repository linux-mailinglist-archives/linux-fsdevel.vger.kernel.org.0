Return-Path: <linux-fsdevel+bounces-57825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 383C0B259B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 05:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372CB6827D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 03:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396E1259CB2;
	Thu, 14 Aug 2025 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTAZ7Xvt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41BF21C192;
	Thu, 14 Aug 2025 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755140864; cv=none; b=n/K1HvhtnjT/tnQZXwqJiTDRNE7jMDJRRLSgaugmL/nSzuMitmebqOMXhr3SNdt6XxSmL7/McC3nnmwgXffjawcbTw4Z0mSTvlZguIOwbVQNbPYTSr62dJVyC0qhL/f45Iq0zeKYo7cdaaqiIVXDBwb4sFYATgz/c30HiIIEZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755140864; c=relaxed/simple;
	bh=1KlUcrBRrFp/B5jQJD9nCnjZm0GqgPsP5dpL6i9Z0ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJvn9PyR6LTSzpsqTiBXt3KBD/DxrCj5sxSbyWMw/+GATJZoL96nudZeqt7p/UspvKVJzIKQHB0yn37e3pofq1O5NLWPFuqX7dR7xa/SmGdtDrpV7J79FZ17CyPn++cpcfy4a3b+LyFgt+r7fT6J1uroYlcSLct+Vm7TLoygpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTAZ7Xvt; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70a927f38deso3511686d6.1;
        Wed, 13 Aug 2025 20:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755140862; x=1755745662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUDzc1mdDHBjiqG/zzLcUzG9tliWvoEfjM11Vf1vwNI=;
        b=dTAZ7XvtQcH+NanhSD0UJkwQ7Tv6ExVvwvARVUh59A0H7LiSFkM+OKyJ+YEelR5RmP
         yBY9Og90s9DdFB1XlLzCZwMKL9on35QF2Fvn4MulaKXU1zWfAq7iN3IVTdStzlGbd9Ga
         lKIC5/2t19N4sX586KT2kpF7YptFduq48tBakqdcS8nTA1OaNbjFV1ldYD1iycXqL9+r
         iOoTBAjNXH58DszTxmyNfTHCxASzQG/FL8D6usrDEsPFahHdAuiwBVITDdf7FHoaXt/O
         OM3OMI6IsYwjKxZOA8gXJy9xMt9QNUeJqcrIx+GRyKZZT1I6xi2b+yMf2XJq+hJdNNFt
         femg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755140862; x=1755745662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUDzc1mdDHBjiqG/zzLcUzG9tliWvoEfjM11Vf1vwNI=;
        b=JnFec2hYe0GfoDKaNnrrtnCNCFwPuxJ1jcyjo2LNypRstv/BnAYaY92WB0sY+QLAHJ
         R+z/d66OXQJ5dGEbTKnUBSu8sxfD0CK9j3ruvCPQgOJc5RPtMPPP4WSN47FYtLECElFv
         m/evjfHUvgacWsshlpFR3u3haq5USOQyGp6PLwj32bJ6ZW4xQ4pk0wb7xMKb+VOeZO7b
         DbnrIGRzryvUEc92M+k58Lp3Af99H5ZfXkvXHeDn07TD72N8CwgQpEDo4u3D9+hdKMV+
         5yjUkC/4VrTEruoW4WXYpfpi8Hvkhi9hokZ4mL18EAoRWNQRInryZbhMngOLXhEy05qu
         bWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdlPNpD5N8l0vXCNUZ21oitb0YQPh3GREYueMl/cxXWyTPUYdy4FRzPHqu6R3xxiiYULtNXmRPqs0=@vger.kernel.org, AJvYcCVCRmp5USXlNWePjlXl/TXodb4F/Ma+CqFDtNejfeg0r9mRG1lhJvF1C0jUvvSd5NbDYeHuF5xBZ+b+4hNR7A==@vger.kernel.org, AJvYcCX3QaLoLoyBUo6UoZOKBvJcPE6LNIHKh0apb6DJQpGsBML9esSsCE7/1hXG4myUzJ/Ejrh2uhXmfXyDHUDc@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxZflaIrKqkHCFGOVqj9BQIkTkHsnIjzXRh09a2Hx6We+Ev3S
	cTvXfTSUIatoUOYL5maLi5zA8w9opJAqZZNxTSRUDxxmiyx1gSP9rMTWEvInoTN+WKm6QW1iek0
	d9q3gETg6YionEhxbJJE8zapx8/FCAz4=
X-Gm-Gg: ASbGncuRbrINq1+N9qUedEl0mMnOgXAQYpdj4IF9YFOilJQWUY5WB7QRSmEshcTbZzn
	9zylVhEz8A+G/mTMk8Rg0kD1+KvzRrbHqw3bGVn+QG+N7fhz5xS6QQQg1x36l8D5X96Q5Sa7hvI
	BWWqJ9jHt2bwwVS+ozpPk13kppPslNFPj/wtm9sCRKITjBy/wi1AKld8us8IR9zKYBnJO8DtOy5
	w1qbOR0mQlm9i7U7Txff/vYGClsvA==
X-Google-Smtp-Source: AGHT+IFYxDmdtCd1AOfg3PPu0GGuc/CboEux5FPcuVbxvPt1Q0ZG3/4JBDkLE42D+b8yyII1bAVdU+IUJHNYlXKAF6Y=
X-Received: by 2002:a05:6214:e6e:b0:709:bc45:b9f7 with SMTP id
 6a1803df08f44-70af5b03e24mr23289996d6.14.1755140861453; Wed, 13 Aug 2025
 20:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813135642.1986480-1-usamaarif642@gmail.com> <20250813135642.1986480-3-usamaarif642@gmail.com>
In-Reply-To: <20250813135642.1986480-3-usamaarif642@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 14 Aug 2025 11:07:05 +0800
X-Gm-Features: Ac12FXw7qs-tSJF4aKoa8rmDweW7mQyT51zC6eFE-QG_TX-v7WWZYuuumuDMqoY
Message-ID: <CALOAHbAe9Rbb2iC3Vnw29jxHEQiWA83jw72fb_CQKGDFHv6+FQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] mm/huge_memory: convert "tva_flags" to "enum tva_type"
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org, 
	shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com, dev.jain@arm.com, 
	baolin.wang@linux.alibaba.com, npache@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz, 
	jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 9:57=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> From: David Hildenbrand <david@redhat.com>
>
> When determining which THP orders are eligible for a VMA mapping,
> we have previously specified tva_flags, however it turns out it is
> really not necessary to treat these as flags.
>
> Rather, we distinguish between distinct modes.
>
> The only case where we previously combined flags was with
> TVA_ENFORCE_SYSFS, but we can avoid this by observing that this
> is the default, except for MADV_COLLAPSE or an edge cases in
> collapse_pte_mapped_thp() and hugepage_vma_revalidate(), and
> adding a mode specifically for this case - TVA_FORCED_COLLAPSE.
>
> We have:
> * smaps handling for showing "THPeligible"
> * Pagefault handling
> * khugepaged handling
> * Forced collapse handling: primarily MADV_COLLAPSE, but also for
>   an edge case in collapse_pte_mapped_thp()
>
> Disregarding the edge cases, we only want to ignore sysfs settings only
> when we are forcing a collapse through MADV_COLLAPSE, otherwise we
> want to enforce it, hence this patch does the following flag to enum
> conversions:
>
> * TVA_SMAPS | TVA_ENFORCE_SYSFS -> TVA_SMAPS
> * TVA_IN_PF | TVA_ENFORCE_SYSFS -> TVA_PAGEFAULT
> * TVA_ENFORCE_SYSFS             -> TVA_KHUGEPAGED
> * 0                             -> TVA_FORCED_COLLAPSE
>
> With this change, we immediately know if we are in the forced collapse
> case, which will be valuable next.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

Hello Usama,

This change is also required by my BPF-based THP order selection
series [0]. Since this patch appears to be independent of the series,
could we merge it first into mm-new or mm-everything if the series
itself won't be merged shortly?

Link: https://lwn.net/Articles/1031829/ [0]

> ---
>  fs/proc/task_mmu.c      |  4 ++--
>  include/linux/huge_mm.h | 30 ++++++++++++++++++------------
>  mm/huge_memory.c        |  8 ++++----
>  mm/khugepaged.c         | 17 ++++++++---------
>  mm/memory.c             | 14 ++++++--------
>  5 files changed, 38 insertions(+), 35 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e8e7bef345313..ced01cf3c5ab3 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1369,8 +1369,8 @@ static int show_smap(struct seq_file *m, void *v)
>         __show_smap(m, &mss, false);
>
>         seq_printf(m, "THPeligible:    %8u\n",
> -                  !!thp_vma_allowable_orders(vma, vma->vm_flags,
> -                          TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL)=
);
> +                  !!thp_vma_allowable_orders(vma, vma->vm_flags, TVA_SMA=
PS,
> +                                             THP_ORDERS_ALL));
>
>         if (arch_pkeys_enabled())
>                 seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 22b8b067b295e..92ea0b9771fae 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -94,12 +94,15 @@ extern struct kobj_attribute thpsize_shmem_enabled_at=
tr;
>  #define THP_ORDERS_ALL \
>         (THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_SPECIAL | THP_ORDERS_ALL_FI=
LE_DEFAULT)
>
> -#define TVA_SMAPS              (1 << 0)        /* Will be used for procf=
s */
> -#define TVA_IN_PF              (1 << 1)        /* Page fault handler */
> -#define TVA_ENFORCE_SYSFS      (1 << 2)        /* Obey sysfs configurati=
on */
> +enum tva_type {
> +       TVA_SMAPS,              /* Exposing "THPeligible:" in smaps. */
> +       TVA_PAGEFAULT,          /* Serving a page fault. */
> +       TVA_KHUGEPAGED,         /* Khugepaged collapse. */
> +       TVA_FORCED_COLLAPSE,    /* Forced collapse (e.g. MADV_COLLAPSE). =
*/
> +};
>
> -#define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
> -       (!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order))=
)
> +#define thp_vma_allowable_order(vma, vm_flags, type, order) \
> +       (!!thp_vma_allowable_orders(vma, vm_flags, type, BIT(order)))
>
>  #define split_folio(f) split_folio_to_list(f, NULL)
>
> @@ -264,14 +267,14 @@ static inline unsigned long thp_vma_suitable_orders=
(struct vm_area_struct *vma,
>
>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>                                          vm_flags_t vm_flags,
> -                                        unsigned long tva_flags,
> +                                        enum tva_type type,
>                                          unsigned long orders);
>
>  /**
>   * thp_vma_allowable_orders - determine hugepage orders that are allowed=
 for vma
>   * @vma:  the vm area to check
>   * @vm_flags: use these vm_flags instead of vma->vm_flags
> - * @tva_flags: Which TVA flags to honour
> + * @type: TVA type
>   * @orders: bitfield of all orders to consider
>   *
>   * Calculates the intersection of the requested hugepage orders and the =
allowed
> @@ -285,11 +288,14 @@ unsigned long __thp_vma_allowable_orders(struct vm_=
area_struct *vma,
>  static inline
>  unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>                                        vm_flags_t vm_flags,
> -                                      unsigned long tva_flags,
> +                                      enum tva_type type,
>                                        unsigned long orders)
>  {
> -       /* Optimization to check if required orders are enabled early. */
> -       if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
> +       /*
> +        * Optimization to check if required orders are enabled early. On=
ly
> +        * forced collapse ignores sysfs configs.
> +        */
> +       if (type !=3D TVA_FORCED_COLLAPSE && vma_is_anonymous(vma)) {
>                 unsigned long mask =3D READ_ONCE(huge_anon_orders_always)=
;
>
>                 if (vm_flags & VM_HUGEPAGE)
> @@ -303,7 +309,7 @@ unsigned long thp_vma_allowable_orders(struct vm_area=
_struct *vma,
>                         return 0;
>         }
>
> -       return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, order=
s);
> +       return __thp_vma_allowable_orders(vma, vm_flags, type, orders);
>  }
>
>  struct thpsize {
> @@ -547,7 +553,7 @@ static inline unsigned long thp_vma_suitable_orders(s=
truct vm_area_struct *vma,
>
>  static inline unsigned long thp_vma_allowable_orders(struct vm_area_stru=
ct *vma,
>                                         vm_flags_t vm_flags,
> -                                       unsigned long tva_flags,
> +                                       enum tva_type type,
>                                         unsigned long orders)
>  {
>         return 0;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 6df1ed0cef5cf..9c716be949cbf 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -99,12 +99,12 @@ static inline bool file_thp_enabled(struct vm_area_st=
ruct *vma)
>
>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>                                          vm_flags_t vm_flags,
> -                                        unsigned long tva_flags,
> +                                        enum tva_type type,
>                                          unsigned long orders)
>  {
> -       bool smaps =3D tva_flags & TVA_SMAPS;
> -       bool in_pf =3D tva_flags & TVA_IN_PF;
> -       bool enforce_sysfs =3D tva_flags & TVA_ENFORCE_SYSFS;
> +       const bool smaps =3D type =3D=3D TVA_SMAPS;
> +       const bool in_pf =3D type =3D=3D TVA_PAGEFAULT;
> +       const bool enforce_sysfs =3D type !=3D TVA_FORCED_COLLAPSE;
>         unsigned long supported_orders;
>
>         /* Check the intersection of requested and supported orders. */
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 1a416b8659972..d3d4f116e14b6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -474,8 +474,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>  {
>         if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
>             hugepage_pmd_enabled()) {
> -               if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SY=
SFS,
> -                                           PMD_ORDER))
> +               if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED=
, PMD_ORDER))
>                         __khugepaged_enter(vma->vm_mm);
>         }
>  }
> @@ -921,7 +920,8 @@ static int hugepage_vma_revalidate(struct mm_struct *=
mm, unsigned long address,
>                                    struct collapse_control *cc)
>  {
>         struct vm_area_struct *vma;
> -       unsigned long tva_flags =3D cc->is_khugepaged ? TVA_ENFORCE_SYSFS=
 : 0;
> +       enum tva_type type =3D cc->is_khugepaged ? TVA_KHUGEPAGED :
> +                                TVA_FORCED_COLLAPSE;
>
>         if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
>                 return SCAN_ANY_PROCESS;
> @@ -932,7 +932,7 @@ static int hugepage_vma_revalidate(struct mm_struct *=
mm, unsigned long address,
>
>         if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
>                 return SCAN_ADDRESS_RANGE;
> -       if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_O=
RDER))
> +       if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER)=
)
>                 return SCAN_VMA_CHECK;
>         /*
>          * Anon VMA expected, the address may be unmapped then
> @@ -1533,9 +1533,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, u=
nsigned long addr,
>          * in the page cache with a single hugepage. If a mm were to faul=
t-in
>          * this memory (mapped by a suitably aligned VMA), we'd get the h=
ugepage
>          * and map it by a PMD, regardless of sysfs THP settings. As such=
, let's
> -        * analogously elide sysfs THP settings here.
> +        * analogously elide sysfs THP settings here and force collapse.
>          */
> -       if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
> +       if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLA=
PSE, PMD_ORDER))
>                 return SCAN_VMA_CHECK;
>
>         /* Keep pmd pgtable for uffd-wp; see comment in retract_page_tabl=
es() */
> @@ -2432,8 +2432,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
>                         progress++;
>                         break;
>                 }
> -               if (!thp_vma_allowable_order(vma, vma->vm_flags,
> -                                       TVA_ENFORCE_SYSFS, PMD_ORDER)) {
> +               if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUG=
EPAGED, PMD_ORDER)) {
>  skip:
>                         progress++;
>                         continue;
> @@ -2767,7 +2766,7 @@ int madvise_collapse(struct vm_area_struct *vma, un=
signed long start,
>         BUG_ON(vma->vm_start > start);
>         BUG_ON(vma->vm_end < end);
>
> -       if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
> +       if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLA=
PSE, PMD_ORDER))
>                 return -EINVAL;
>
>         cc =3D kmalloc(sizeof(*cc), GFP_KERNEL);
> diff --git a/mm/memory.c b/mm/memory.c
> index 002c28795d8b7..7b1e8f137fa3f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4515,8 +4515,8 @@ static struct folio *alloc_swap_folio(struct vm_fau=
lt *vmf)
>          * Get a list of all the (large) orders below PMD_ORDER that are =
enabled
>          * and suitable for swapping THP.
>          */
> -       orders =3D thp_vma_allowable_orders(vma, vma->vm_flags,
> -                       TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1=
);
> +       orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEF=
AULT,
> +                                         BIT(PMD_ORDER) - 1);
>         orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
>         orders =3D thp_swap_suitable_orders(swp_offset(entry),
>                                           vmf->address, orders);
> @@ -5063,8 +5063,8 @@ static struct folio *alloc_anon_folio(struct vm_fau=
lt *vmf)
>          * for this vma. Then filter out the orders that can't be allocat=
ed over
>          * the faulting address and still be fully contained in the vma.
>          */
> -       orders =3D thp_vma_allowable_orders(vma, vma->vm_flags,
> -                       TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1=
);
> +       orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEF=
AULT,
> +                                         BIT(PMD_ORDER) - 1);
>         orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
>
>         if (!orders)
> @@ -6254,8 +6254,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_=
struct *vma,
>                 return VM_FAULT_OOM;
>  retry_pud:
>         if (pud_none(*vmf.pud) &&
> -           thp_vma_allowable_order(vma, vm_flags,
> -                               TVA_IN_PF | TVA_ENFORCE_SYSFS, PUD_ORDER)=
) {
> +           thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PUD_ORD=
ER)) {
>                 ret =3D create_huge_pud(&vmf);
>                 if (!(ret & VM_FAULT_FALLBACK))
>                         return ret;
> @@ -6289,8 +6288,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_=
struct *vma,
>                 goto retry_pud;
>
>         if (pmd_none(*vmf.pmd) &&
> -           thp_vma_allowable_order(vma, vm_flags,
> -                               TVA_IN_PF | TVA_ENFORCE_SYSFS, PMD_ORDER)=
) {
> +           thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_ORD=
ER)) {
>                 ret =3D create_huge_pmd(&vmf);
>                 if (!(ret & VM_FAULT_FALLBACK))
>                         return ret;
> --
> 2.47.3
>


--=20
Regards
Yafang

