Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0683A92A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 08:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhFPGdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 02:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhFPGdI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:33:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E87AC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 23:31:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q15so1117633pgg.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 23:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnVJHvXzTfMwZnd+sO8L8PW13B3KOws+XHBcdC/4riM=;
        b=Yv9ZQDLD3WsQqlq7yq5aUVVWSQwiUdOZ+qsoDuKBQI0Nt78TlXWAKguiTBzi+qqseo
         iwsgslAKqajlPYp+T/4wz34FbgnCi4e5ymRKLvdfnU/g12RY76V2hgg8wVE8U4Bj9EIB
         7UU4wxSC3AU3xrehmS1hDX94RtLkU2sf6KT5uhVFHMCYIGkg0uIlS87Moi+EYx9HUVeO
         wU8Z41eZfaffLRivuWoFCNg0z/3zRbAf4t3Z3xG5AXyj7PhAHt71XlYt7Nj8FOLCeNIo
         odc7gI6tMdUmPeT8KxIO+I+9kp6nGKAv576nYrk/Arn7Du74NChCTZvHu04ikY2o6XwZ
         nFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnVJHvXzTfMwZnd+sO8L8PW13B3KOws+XHBcdC/4riM=;
        b=Yv2F82tHvc7oy1ZlZ9JcJbkyrO/UnsGVNNOkEkof2lwzXz8FNIu41tS9KGQKgX0SCA
         PAgHPL9ORZVuo4fRgY5Qsz/0mWFm41mT903bmu/SobkqGn/cjplcAFML0OlEZYYj0CyM
         bIIgV0Uo6PzeohGj3+zHRwBCop/LJ5T/y5Hl3Vw4E+8MRX9GnEf6svPvgVMQ1OzyH9/4
         Q9SSuW9iOiU33P36aeh3sEfdI02KQcp6vWl8li/xa6UBw1Xc+s1hWBp6V4U6C9YRXpGQ
         SZgbe9+AAWp//FLXlkYBpyHZ12cqbDiEx8ql03Zy3+KOfIhqiZ5yA5elGbuMAbPz8FRI
         8A8A==
X-Gm-Message-State: AOAM5320DEgD0/qenkYuoVfe6RL4ClZ+hUKNJ1oNWudr9juWYKB/jdtv
        oahqiokM0TY7K1cTnjp1gcwWSOIAtoxCtEwd6UPRNw==
X-Google-Smtp-Source: ABdhPJxEr9gf18Cdhk1f8EhTHILp6osP6kHcu589GdH0NbQQbUNIN5WvGkClnb9HbcroXzcqyZCUY4XCXkw4wpHlRvc=
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr3477810pgm.279.1623825061741;
 Tue, 15 Jun 2021 23:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210604011844.1756145-1-ruansy.fnst@fujitsu.com> <20210604011844.1756145-5-ruansy.fnst@fujitsu.com>
In-Reply-To: <20210604011844.1756145-5-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Jun 2021 23:30:51 -0700
Message-ID: <CAPcyv4iEuPWs-f+rV=xncbXYKSHkbhuLJ-1hnP9N9ABNzr1VSA@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] mm, fsdax: Refactor memory-failure handler for
 dax mapping
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ drop old nvdimm list, add the new one ]

On Thu, Jun 3, 2021 at 6:19 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> The current memory_failure_dev_pagemap() can only handle single-mapped
> dax page for fsdax mode.  The dax page could be mapped by multiple files
> and offsets if we let reflink feature & fsdax mode work together.  So,
> we refactor current implementation to support handle memory failure on
> each file and offset.

I don't understand this organization, perhaps because this patch
introduces mf_dax_kill_procs() without a user. However, my expectation
is that memory_failure() is mostly untouched save for an early check
via pgmap->notify_memory_failure(). If pgmap->notify_memory_failure()
indicates that the memory failure was handled by the pgmap->owner /
dax_dev holder stack, then the typical memory failure path is
short-circuited. Otherwise, for non-reflink filesystems where
page->mapping() is valid the legacy / existing memory_failure()
operates as it does currently. If reflink capable filesystems want to
share a common implementation to map pfns to files they can, but I
don't think that common code belongs in mm/memory-failure.c.

>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c            |  21 ++++++++
>  include/linux/dax.h |   1 +
>  include/linux/mm.h  |   9 ++++
>  mm/memory-failure.c | 114 ++++++++++++++++++++++++++++----------------
>  4 files changed, 105 insertions(+), 40 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 62352cbcf0f4..58faca85455a 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -389,6 +389,27 @@ static struct page *dax_busy_page(void *entry)
>         return NULL;
>  }
>
> +/*
> + * dax_load_pfn - Load pfn of the DAX entry corresponding to a page
> + * @mapping: The file whose entry we want to load
> + * @index:   The offset where the DAX entry located in
> + *
> + * Return:   pfn of the DAX entry
> + */
> +unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index)
> +{
> +       XA_STATE(xas, &mapping->i_pages, index);
> +       void *entry;
> +       unsigned long pfn;
> +
> +       xas_lock_irq(&xas);
> +       entry = xas_load(&xas);
> +       pfn = dax_to_pfn(entry);
> +       xas_unlock_irq(&xas);

This looks racy, what happened to the locking afforded by dax_lock_page()?

> +
> +       return pfn;
> +}
> +
>  /*
>   * dax_lock_mapping_entry - Lock the DAX entry corresponding to a page
>   * @page: The page whose entry we want to lock
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 1ce343a960ab..6e758daa5004 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -158,6 +158,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
>
>  struct page *dax_layout_busy_page(struct address_space *mapping);
>  struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
> +unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index);
>  dax_entry_t dax_lock_page(struct page *page);
>  void dax_unlock_page(struct page *page, dax_entry_t cookie);
>  #else
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c274f75efcf9..2b7527e93c77 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1187,6 +1187,14 @@ static inline bool is_device_private_page(const struct page *page)
>                 page->pgmap->type == MEMORY_DEVICE_PRIVATE;
>  }
>
> +static inline bool is_device_fsdax_page(const struct page *page)
> +{
> +       return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
> +               IS_ENABLED(CONFIG_FS_DAX) &&
> +               is_zone_device_page(page) &&
> +               page->pgmap->type == MEMORY_DEVICE_FS_DAX;

Why is this necessary? The dax_dev holder is the one that knows the
nature of the pfn. The common memory_failure() code should not care
about fsdax vs devdax.

> +}
> +
>  static inline bool is_pci_p2pdma_page(const struct page *page)
>  {
>         return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
> @@ -3078,6 +3086,7 @@ enum mf_flags {
>         MF_MUST_KILL = 1 << 2,
>         MF_SOFT_OFFLINE = 1 << 3,
>  };
> +int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index, int flags);
>  extern int memory_failure(unsigned long pfn, int flags);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
>  extern void memory_failure_queue_kick(int cpu);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 85ad98c00fd9..4377e727d478 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -56,6 +56,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/ratelimit.h>
>  #include <linux/page-isolation.h>
> +#include <linux/dax.h>
>  #include "internal.h"
>  #include "ras/ras_event.h"
>
> @@ -120,6 +121,13 @@ static int hwpoison_filter_dev(struct page *p)
>         if (PageSlab(p))
>                 return -EINVAL;
>
> +       if (pfn_valid(page_to_pfn(p))) {
> +               if (is_device_fsdax_page(p))

This is racy unless the page is pinned. Also, not clear why this is needed?

> +                       return 0;
> +               else
> +                       return -EINVAL;
> +       }
> +
>         mapping = page_mapping(p);
>         if (mapping == NULL || mapping->host == NULL)
>                 return -EINVAL;
> @@ -290,10 +298,9 @@ void shake_page(struct page *p, int access)
>  }
>  EXPORT_SYMBOL_GPL(shake_page);
>
> -static unsigned long dev_pagemap_mapping_shift(struct page *page,
> -               struct vm_area_struct *vma)
> +static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
> +                                              unsigned long address)
>  {
> -       unsigned long address = vma_address(page, vma);
>         pgd_t *pgd;
>         p4d_t *p4d;
>         pud_t *pud;
> @@ -333,9 +340,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>   * Schedule a process for later kill.
>   * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
>   */
> -static void add_to_kill(struct task_struct *tsk, struct page *p,
> -                      struct vm_area_struct *vma,
> -                      struct list_head *to_kill)
> +static void add_to_kill(struct task_struct *tsk, struct page *p, pgoff_t pgoff,
> +                       struct vm_area_struct *vma, struct list_head *to_kill)
>  {
>         struct to_kill *tk;
>
> @@ -346,9 +352,12 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>         }
>
>         tk->addr = page_address_in_vma(p, vma);
> -       if (is_zone_device_page(p))
> -               tk->size_shift = dev_pagemap_mapping_shift(p, vma);
> -       else
> +       if (is_zone_device_page(p)) {
> +               if (is_device_fsdax_page(p))
> +                       tk->addr = vma->vm_start +
> +                                       ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> +               tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);

What was wrong with the original code?

> +       } else
>                 tk->size_shift = page_shift(compound_head(p));
>
>         /*
> @@ -496,7 +505,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>                         if (!page_mapped_in_vma(page, vma))
>                                 continue;
>                         if (vma->vm_mm == t->mm)
> -                               add_to_kill(t, page, vma, to_kill);
> +                               add_to_kill(t, page, 0, vma, to_kill);
>                 }
>         }
>         read_unlock(&tasklist_lock);
> @@ -506,24 +515,19 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>  /*
>   * Collect processes when the error hit a file mapped page.
>   */
> -static void collect_procs_file(struct page *page, struct list_head *to_kill,
> -                               int force_early)
> +static void collect_procs_file(struct page *page, struct address_space *mapping,
> +               pgoff_t pgoff, struct list_head *to_kill, int force_early)
>  {

collect_procs() and kill_procs() are the only core memory_failure()
helpers I expect would be exported for a fileystem dax_dev holder to
call when it is trying to cleanup a memory_failure() on a reflink'd
mapping.

>         struct vm_area_struct *vma;
>         struct task_struct *tsk;
> -       struct address_space *mapping = page->mapping;
> -       pgoff_t pgoff;
>
>         i_mmap_lock_read(mapping);
>         read_lock(&tasklist_lock);
> -       pgoff = page_to_pgoff(page);
>         for_each_process(tsk) {
>                 struct task_struct *t = task_early_kill(tsk, force_early);
> -
>                 if (!t)
>                         continue;
> -               vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff,
> -                                     pgoff) {
> +               vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
>                         /*
>                          * Send early kill signal to tasks where a vma covers
>                          * the page but the corrupted page is not necessarily
> @@ -532,7 +536,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
>                          * to be informed of all such data corruptions.
>                          */
>                         if (vma->vm_mm == t->mm)
> -                               add_to_kill(t, page, vma, to_kill);
> +                               add_to_kill(t, page, pgoff, vma, to_kill);
>                 }
>         }
>         read_unlock(&tasklist_lock);
> @@ -551,7 +555,8 @@ static void collect_procs(struct page *page, struct list_head *tokill,
>         if (PageAnon(page))
>                 collect_procs_anon(page, tokill, force_early);
>         else
> -               collect_procs_file(page, tokill, force_early);
> +               collect_procs_file(page, page_mapping(page), page_to_pgoff(page),
> +                                  tokill, force_early);
>  }
>
>  static const char *action_name[] = {
> @@ -1218,6 +1223,51 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
>         return 0;
>  }
>
> +static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
> +               struct address_space *mapping, pgoff_t index, int flags)
> +{
> +       struct to_kill *tk;
> +       unsigned long size = 0;
> +       loff_t start;
> +
> +       list_for_each_entry(tk, to_kill, nd)
> +               if (tk->size_shift)
> +                       size = max(size, 1UL << tk->size_shift);
> +       if (size) {
> +               /*
> +                * Unmap the largest mapping to avoid breaking up
> +                * device-dax mappings which are constant size. The
> +                * actual size of the mapping being torn down is
> +                * communicated in siginfo, see kill_proc()
> +                */
> +               start = (index << PAGE_SHIFT) & ~(size - 1);
> +               unmap_mapping_range(mapping, start, size, 0);
> +       }
> +
> +       kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
> +}
> +
> +int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index, int flags)
> +{
> +       LIST_HEAD(to_kill);
> +       /* load the pfn of the dax mapping file */
> +       unsigned long pfn = dax_load_pfn(mapping, index);
> +
> +       /*
> +        * Unlike System-RAM there is no possibility to swap in a
> +        * different physical page at a given virtual address, so all
> +        * userspace consumption of ZONE_DEVICE memory necessitates
> +        * SIGBUS (i.e. MF_MUST_KILL)
> +        */
> +       flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
> +       collect_procs_file(pfn_to_page(pfn), mapping, index, &to_kill,
> +                          flags & MF_ACTION_REQUIRED);
> +
> +       unmap_and_kill(&to_kill, pfn, mapping, index, flags);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
> +
>  static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  {
>         struct page *p = pfn_to_page(pfn);
> @@ -1298,12 +1348,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>                 struct dev_pagemap *pgmap)
>  {
>         struct page *page = pfn_to_page(pfn);
> -       const bool unmap_success = true;
> -       unsigned long size = 0;
> -       struct to_kill *tk;
> -       LIST_HEAD(tokill);
> +       LIST_HEAD(to_kill);
>         int rc = -EBUSY;
> -       loff_t start;
>         dax_entry_t cookie;
>
>         if (flags & MF_COUNT_INCREASED)
> @@ -1355,22 +1401,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>          * SIGBUS (i.e. MF_MUST_KILL)
>          */
>         flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
> -       collect_procs(page, &tokill, flags & MF_ACTION_REQUIRED);
> +       collect_procs_file(page, page->mapping, page->index, &to_kill,
> +                          flags & MF_ACTION_REQUIRED);
>
> -       list_for_each_entry(tk, &tokill, nd)
> -               if (tk->size_shift)
> -                       size = max(size, 1UL << tk->size_shift);
> -       if (size) {
> -               /*
> -                * Unmap the largest mapping to avoid breaking up
> -                * device-dax mappings which are constant size. The
> -                * actual size of the mapping being torn down is
> -                * communicated in siginfo, see kill_proc()
> -                */
> -               start = (page->index << PAGE_SHIFT) & ~(size - 1);
> -               unmap_mapping_range(page->mapping, start, size, 0);
> -       }
> -       kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
> +       unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);

There's just too much change in this patch and not enough
justification of what is being refactored and why.
