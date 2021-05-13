Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3DA37FFD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 23:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhEMVbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 17:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbhEMVbs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 17:31:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F7FC061574;
        Thu, 13 May 2021 14:30:37 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id f12so22882823ljp.2;
        Thu, 13 May 2021 14:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulveDe0GcodliqoO6WkEBV2On2D7HTmvHnhRbioOx5M=;
        b=lVWIar/4CW8qIyvq3H+e1lg6CNLF/OMvV8aieWeuc0eN78OqpUT7SNehXdtPylfzy5
         O8v6Ldrigw91iiZAz/3YPZXRHRNzsARdD47vfdVEn9ZXzzi6AgOnzD4j/U6GqqqkJbeP
         pBr2ZLHWN9A/7/RtuD6i6kvQaJoywlcFVXjUty6YMoqU7DgcsMZZkHxma1HPGkCoWrn8
         VP+kNi4EykGH9Y4DuBhp5ha2D8gSJ7iytCHjwn9gjoYSFPXKqcBPy29N8tujqpTAMeXE
         W0XMEon2708SvAUX2mRqvlnc1p63eLMMEY+WIb20UTMS6pXysmzrvYQZ4wlLEyMd08Dk
         eLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulveDe0GcodliqoO6WkEBV2On2D7HTmvHnhRbioOx5M=;
        b=jfhfhSTBRUVRlP0UeBVgOB0JtKcGU20/jqq4YOq7GY6Iw4yuVqezu9hrcqsqYBj6Xx
         Lhe7mfwtewIp51m6gzo6r9C4TQsRow6Az/xANcGdFsIxo8esvU2fk1Vcws+GWwZcJHdZ
         VfF2JApS9cPp6fMpdD1ULbxK68MK+8/qn7lF5KyW2vpjuEqT7LrEDmKjv83HxZAIvJz6
         IqjTO+iNyaWlZgONqjM2ElQuIDeDDhf5zkmwgNfz7SVxtop86AdCz8xFUTFwqBZE7f94
         OqAM03O6E7sAOdM8imgVtuApJ9Xh3hrr+6hwuZjcMBSo+fPAK0g0Nleje6ZZbp5gaMx+
         v5+w==
X-Gm-Message-State: AOAM5302VV0lVLyEsMp2qOLBhHDD36kQkn3pKeYSsJDrau7cCyHJn+AF
        4J1pTmV8q3bfRbKCmZSmaloaH5K0CV9vJdGXk1LneZg9Q8/gig==
X-Google-Smtp-Source: ABdhPJw65l2XB0GhvZH8bRdALUHea+Dz5lRurGuGlOyKtRwHwM72wpfFrEC+nyefsHdxCrheoDxyus831oy7akMFNwI=
X-Received: by 2002:a2e:3508:: with SMTP id z8mr33792261ljz.424.1620941435168;
 Thu, 13 May 2021 14:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210511134857.1581273-1-linmiaohe@huawei.com> <20210511134857.1581273-4-linmiaohe@huawei.com>
In-Reply-To: <20210511134857.1581273-4-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 13 May 2021 14:30:23 -0700
Message-ID: <CAHbLzkric1DfZrspY7grQtjTeFUS7CTTdRAhYVhLKTOHjy+t2A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm/huge_memory.c: add missing read-only THP
 checking in transparent_hugepage_enabled()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        william.kucharski@oracle.com, Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        aneesh.kumar@linux.ibm.com, Ralph Campbell <rcampbell@nvidia.com>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>, adobriyan@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 6:49 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
> (non-shmem) FS"), read-only THP file mapping is supported. But it
> forgot to add checking for it in transparent_hugepage_enabled().
> To fix it, we add checking for read-only THP file mapping and also
> introduce helper transhuge_vma_enabled() to check whether thp is
> enabled for specified vma to reduce duplicated code. We rename
> transparent_hugepage_enabled to transparent_hugepage_active to make
> the code easier to follow as suggested by David Hildenbrand.
>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Looks correct to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

Just a nit below:

> ---
>  fs/proc/task_mmu.c      |  2 +-
>  include/linux/huge_mm.h | 27 ++++++++++++++++++++-------
>  mm/huge_memory.c        | 11 ++++++++++-
>  mm/khugepaged.c         |  4 +---
>  mm/shmem.c              |  3 +--
>  5 files changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index fc9784544b24..7389df326edd 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -832,7 +832,7 @@ static int show_smap(struct seq_file *m, void *v)
>         __show_smap(m, &mss, false);
>
>         seq_printf(m, "THPeligible:    %d\n",
> -                  transparent_hugepage_enabled(vma));
> +                  transparent_hugepage_active(vma));
>
>         if (arch_pkeys_enabled())
>                 seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 0a526f211fec..a35c13d1f487 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -115,9 +115,19 @@ extern struct kobj_attribute shmem_enabled_attr;
>
>  extern unsigned long transparent_hugepage_flags;
>
> +static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,

I'd like to have this function defined next to transhuge_vma_suitable().

> +                                         unsigned long vm_flags)
> +{
> +       /* Explicitly disabled through madvise. */
> +       if ((vm_flags & VM_NOHUGEPAGE) ||
> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +               return false;
> +       return true;
> +}
> +
>  /*
>   * to be used on vmas which are known to support THP.
> - * Use transparent_hugepage_enabled otherwise
> + * Use transparent_hugepage_active otherwise
>   */
>  static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  {
> @@ -128,15 +138,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>         if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
>                 return false;
>
> -       if (vma->vm_flags & VM_NOHUGEPAGE)
> +       if (!transhuge_vma_enabled(vma, vma->vm_flags))
>                 return false;
>
>         if (vma_is_temporary_stack(vma))
>                 return false;
>
> -       if (test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> -               return false;
> -
>         if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
>                 return true;
>
> @@ -150,7 +157,7 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>         return false;
>  }
>
> -bool transparent_hugepage_enabled(struct vm_area_struct *vma);
> +bool transparent_hugepage_active(struct vm_area_struct *vma);
>
>  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>                 unsigned long haddr)
> @@ -351,7 +358,7 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>         return false;
>  }
>
> -static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
> +static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
>  {
>         return false;
>  }
> @@ -362,6 +369,12 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>         return false;
>  }
>
> +static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> +                                         unsigned long vm_flags)
> +{
> +       return false;
> +}
> +
>  static inline void prep_transhuge_page(struct page *page) {}
>
>  static inline bool is_transparent_hugepage(struct page *page)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 76ca1eb2a223..4f37867eed12 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -63,7 +63,14 @@ static struct shrinker deferred_split_shrinker;
>  static atomic_t huge_zero_refcount;
>  struct page *huge_zero_page __read_mostly;
>
> -bool transparent_hugepage_enabled(struct vm_area_struct *vma)
> +static inline bool file_thp_enabled(struct vm_area_struct *vma)
> +{
> +       return transhuge_vma_enabled(vma, vma->vm_flags) && vma->vm_file &&
> +              !inode_is_open_for_write(vma->vm_file->f_inode) &&
> +              (vma->vm_flags & VM_EXEC);
> +}
> +
> +bool transparent_hugepage_active(struct vm_area_struct *vma)
>  {
>         /* The addr is used to check if the vma size fits */
>         unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> @@ -74,6 +81,8 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>                 return __transparent_hugepage_enabled(vma);
>         if (vma_is_shmem(vma))
>                 return shmem_huge_enabled(vma);
> +       if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS))
> +               return file_thp_enabled(vma);
>
>         return false;
>  }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6c0185fdd815..d97b20fad6e8 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -442,9 +442,7 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
>  static bool hugepage_vma_check(struct vm_area_struct *vma,
>                                unsigned long vm_flags)
>  {
> -       /* Explicitly disabled through madvise. */
> -       if ((vm_flags & VM_NOHUGEPAGE) ||
> -           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +       if (!transhuge_vma_enabled(vma, vm_flags))
>                 return false;
>
>         /* Enabled via shmem mount options or sysfs settings. */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a08cedefbfaa..1dcbec313c70 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4032,8 +4032,7 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
>         loff_t i_size;
>         pgoff_t off;
>
> -       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> -           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +       if (!transhuge_vma_enabled(vma, vma->vm_flags))
>                 return false;
>         if (shmem_huge == SHMEM_HUGE_FORCE)
>                 return true;
> --
> 2.23.0
>
>
