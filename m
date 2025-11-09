Return-Path: <linux-fsdevel+bounces-67585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFB7C43DFE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 13:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685661889A44
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA17D2EDD6B;
	Sun,  9 Nov 2025 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzHOoyiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4942F2EC557
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692584; cv=none; b=VwUJzhgwoe5+KsnMIa0N2OvmXUO38KLDqZF0nYrTJbVI8nCGyiEbBq/lVTkK+oQlLUKYjCL7z5A7D66GBr0Dz0rl0y8KcCFc/o2rlZUUZBK4hrbSE84/WE2Z3mCiG1wWkOZIUPNoMS627TDMtKpL/RWwv5t+MinYp3VsbkWazPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692584; c=relaxed/simple;
	bh=JF2q7sTKzYiIVusFfVQ6qlbWbep+D+t1c3S+sk6voF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/lvGsfzPkwFjOZubeHnTPHm+4p28sqJKoHnfIvKQIWaaccKoh60htQrntztX3iuyMvkBOg8CnbspWHE4MtksZV0Kzx9r9kdg+w6qYnW9zr5tZgo5qcIrR64RWu32lqNQQJ1r3cx8UlX1AIthtBOMyAH9F/34UPk8ctHICdZaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzHOoyiv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so337130266b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 04:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762692580; x=1763297380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDZ3xafdhT/YtTTUoql25uDvUJxupIOBYIVvt5riwwA=;
        b=LzHOoyivCN7TqrVfs1SH/3010EEQXneCel/Ht1s9wzDAO1cnvcIyTpK2UdcYVNApqa
         q25lILxkcWkPxpQr/dhAlLS5LlLEDblcQEBnC26OboyeBzstSHW25/RLcHe39JF8PsPU
         BI2tSJVuK4x6m6eU1+nkp8exx+tMYQ2cwRCQqxiz3JIKBsDD2h6RGoIL7EUKcRVU+i2y
         1joXruWP0YGD91Fh2DVL1q3udqu5o9lwfk01Pf1+viEW5zkhdhhEPtZTtOKsQgJ4tEqa
         +svApird7KA/5RKFOLNEI3g7UJuVHUbZKvxEPjKuqTyF9ob0qHQteX2Wx+cP7ecPlX2x
         qm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762692580; x=1763297380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hDZ3xafdhT/YtTTUoql25uDvUJxupIOBYIVvt5riwwA=;
        b=jyv23RBdWDeRb2KQeIXqESkW8Td7lRJ+d1MgrIizrpnSKBLh9WYwIEaGbEKqffoopQ
         F1mlXRJRYZDwH+ysax/XDvG0eRnXEmStLk9yya4n7FHa+RPsJxSYOTRnjJgsVUobvkEf
         2Un+wlZpz45OmBWh//EWSy0gNxfh1rA2h7Ovvm+xBduMDgCvMMGH1Ear9Nz5QVPeulW2
         QQAagdGolbi8aCWxvY/PhKbg9JQoA2XxdKy2ek3vz9ENPgk0l6LEGgCF1IIgGMK//zDb
         MznwLjvE8QGdI/eQ+Jg6CkRX91brwmq0STKkoCcz/nHowoiSPhmnD7mXIv2Q5Yx/oYeA
         bY8g==
X-Forwarded-Encrypted: i=1; AJvYcCVbhYMOrS6LN79j8Y93FHWe1AKIwpSpG5TBkpr3OKm8HlD14UE6HLnUUgsyZIYTAKMs2SnME6tGhkCxNoNm@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKYdaG+Rt7ShiTupmhS6I0IO6TIxz3xdqP7WCIE7QmpuzdeQG
	3Cc0I3dQhFqt/phlOkLcSe5Ni+/hUj03QHI3CuqvBdz3JIvHi9FULuhcO/uZOTdmkVJbHZU70VJ
	J0LtWNfCmdmkgjElCYJaaG86NGt9gOpg=
X-Gm-Gg: ASbGncttkqktrpQcP3PaGJeCwkE5n9SLdtz/998Krkz5ycRxHE9BVcKsgHu+e3w0uoH
	IzqaNmeMx55WB7PlU+HOK4vXDjQXtoCyBENBDFSmZ5i/ZsDIL1n7Ma/4LdV9H2+3h3zKEjP8eJ6
	kh8M6Cco9IXvolaWicCXnPJQHcAb9ENAi4q+KbypTnUK0sLEtDX+qjM40MEc27EOScvq3lAOFZ1
	m8bdeN/s3qiV2T2Rx+FoMdkif6qByave8Q8iTH0eNcD6fy0IBxGXLOvNJaU
X-Google-Smtp-Source: AGHT+IHNVHcrPcoXcfMQAdrM6mfxVNIvqirPfSk4ZwLH/WJQN1X+/EwZuiwM1z9Tvembh+GaQUpS/PpKFfhnQ7ESKbE=
X-Received: by 2002:a17:907:869f:b0:b33:a2ef:c7 with SMTP id
 a640c23a62f3a-b72e058a781mr441932566b.55.1762692579280; Sun, 09 Nov 2025
 04:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com> <75c2e8fa38de383757a49bcc3f5c081be1e27a40.1762621568.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <75c2e8fa38de383757a49bcc3f5c081be1e27a40.1762621568.git.lorenzo.stoakes@oracle.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 9 Nov 2025 20:49:02 +0800
X-Gm-Features: AWmQ_bm7gm65mOXTd2rtxZ-2sSA2POMXyYBKPT6giX8icbqtDuQMmyxTTsU5nEc
Message-ID: <CAMgjq7AP383YfU3L5ZxJ9U3x-vRPnEkEUtmnPdXD29HiNC8OrA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] mm: eliminate is_swap_pte() when
 softleaf_from_pte() suffices
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

On Sun, Nov 9, 2025 at 2:16=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> In cases where we can simply utilise the fact that softleaf_from_pte()
> treats present entries as if they were none entries and thus eliminate
> spurious uses of is_swap_pte(), do so.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/internal.h   |  7 +++----
>  mm/madvise.c    |  8 +++-----
>  mm/swap_state.c | 12 ++++++------
>  mm/swapfile.c   |  9 ++++-----
>  4 files changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 9465129367a4..f0c7461bb02c 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -15,7 +15,7 @@
>  #include <linux/pagewalk.h>
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
> -#include <linux/swapops.h>
> +#include <linux/leafops.h>
>  #include <linux/swap_cgroup.h>
>  #include <linux/tracepoint-defs.h>
>
> @@ -380,13 +380,12 @@ static inline int swap_pte_batch(pte_t *start_ptep,=
 int max_nr, pte_t pte)
>  {
>         pte_t expected_pte =3D pte_next_swp_offset(pte);
>         const pte_t *end_ptep =3D start_ptep + max_nr;
> -       swp_entry_t entry =3D pte_to_swp_entry(pte);
> +       const softleaf_t entry =3D softleaf_from_pte(pte);
>         pte_t *ptep =3D start_ptep + 1;
>         unsigned short cgroup_id;
>
>         VM_WARN_ON(max_nr < 1);
> -       VM_WARN_ON(!is_swap_pte(pte));
> -       VM_WARN_ON(non_swap_entry(entry));
> +       VM_WARN_ON(!softleaf_is_swap(entry));
>
>         cgroup_id =3D lookup_swap_cgroup_id(entry);
>         while (ptep < end_ptep) {
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 2d5ad3cb37bb..58d82495b6c6 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -195,7 +195,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned=
 long start,
>
>         for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
>                 pte_t pte;
> -               swp_entry_t entry;
> +               softleaf_t entry;
>                 struct folio *folio;
>
>                 if (!ptep++) {
> @@ -205,10 +205,8 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigne=
d long start,
>                 }
>
>                 pte =3D ptep_get(ptep);
> -               if (!is_swap_pte(pte))
> -                       continue;
> -               entry =3D pte_to_swp_entry(pte);
> -               if (unlikely(non_swap_entry(entry)))
> +               entry =3D softleaf_from_pte(pte);
> +               if (unlikely(!softleaf_is_swap(entry)))
>                         continue;
>
>                 pte_unmap_unlock(ptep, ptl);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index d20d238109f9..8881a79f200c 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -12,7 +12,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/mempolicy.h>
>  #include <linux/swap.h>
> -#include <linux/swapops.h>
> +#include <linux/leafops.h>
>  #include <linux/init.h>
>  #include <linux/pagemap.h>
>  #include <linux/pagevec.h>
> @@ -732,7 +732,6 @@ static struct folio *swap_vma_readahead(swp_entry_t t=
arg_entry, gfp_t gfp_mask,
>         pte_t *pte =3D NULL, pentry;
>         int win;
>         unsigned long start, end, addr;
> -       swp_entry_t entry;
>         pgoff_t ilx;
>         bool page_allocated;
>
> @@ -744,16 +743,17 @@ static struct folio *swap_vma_readahead(swp_entry_t=
 targ_entry, gfp_t gfp_mask,
>
>         blk_start_plug(&plug);
>         for (addr =3D start; addr < end; ilx++, addr +=3D PAGE_SIZE) {
> +               softleaf_t entry;
> +
>                 if (!pte++) {
>                         pte =3D pte_offset_map(vmf->pmd, addr);
>                         if (!pte)
>                                 break;
>                 }
>                 pentry =3D ptep_get_lockless(pte);
> -               if (!is_swap_pte(pentry))
> -                       continue;
> -               entry =3D pte_to_swp_entry(pentry);
> -               if (unlikely(non_swap_entry(entry)))
> +               entry =3D softleaf_from_pte(pentry);
> +
> +               if (!softleaf_is_swap(entry))

Hi Lorenzo,

This part isn't right, is_swap_pte excludes present PTE and non PTE,
but softleaf_from_pte returns a invalid swap entry from a non PTE.

This may lead to a kernel panic as the invalid swap value will be
0x3ffffffffffff on x86_64 (pte_to_swp_entry(0)), the offset value will
cause out of border access.

We might need something like this on top of patch 2:

diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index 1376589d94b0..49de62f96835 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -54,7 +54,7 @@ static inline softleaf_t softleaf_mk_none(void)
  */
 static inline softleaf_t softleaf_from_pte(pte_t pte)
 {
-       if (pte_present(pte))
+       if (pte_present(pte) || pte_none(pte))
                return softleaf_mk_none();

        /* Temporary until swp_entry_t eliminated. */

