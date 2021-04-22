Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0C73687D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 22:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbhDVUXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 16:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbhDVUXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:23:15 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6131C06138C
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 13:22:39 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id c3so32805060ils.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjuNnO6MKvDOTzf0nn5KvuEYDkXSGr2lbpNfyh+4O/0=;
        b=V/bBR6qj7VWCzH0qWnYOfwOh4EYjIuumwalfybz+smYtDrp9/n+DqtqkLGug4EgyRV
         DYEEiwC5x2TzCuuzxFON0t4G3kUKwQOY0Srv9wncYZBILCMZ+GdMFbkwCcnD73vpG5JU
         1/OH6n6nN0W2awyKoccKjw6QrawNa94Eqdhvcd5JBJ0b8Lsbm1++SgCG95u7XyxSucuL
         /1cQ0iiyW6Ca3U7dCtLf0pmV4Vq3qGu5k380/CFWuooO8MKVl1ROW/BrTogukj6s1ido
         7wPXmTeOO97w/D8dJjaNZN2Txyd+p6uzX3Q+ZTLC4Wjfr/BEYM+HN48mQtjctk7dvoNK
         wFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjuNnO6MKvDOTzf0nn5KvuEYDkXSGr2lbpNfyh+4O/0=;
        b=pqz5o29cRyw35VCfLrssvCVyySN6lDtBeS9My13buh6AR0r5OMd6vOXj7aqiBD4aWn
         wxKeK56OyjUJvMSPDBmApfdOpwgB9ZVBzXshMjRJBZChPOXfo0bEsM9GEYX3ZdF9uEko
         oavy1E5CJeiC6vjeoZ71LVr4OHAQbP1GSWO+faqkAu/VPs4Crn0CQPVc2LDPkhGOeOUE
         73QvmvC6PjZd2ZOLZDJIGhfQIlg4F+ptUHvO4I8oapJA1kJ048QZvGS/VGLwaOKEMaso
         v9Lw4ZDngMWXx2764PUVxkfqa2ddhkOceig/b8k4iFXh8eWHC9RwqalbOWevtPR11717
         QdsQ==
X-Gm-Message-State: AOAM531CRF0aaNy2YJMiBq8XR21zOojOVcT2q+0R/U9ia72Oiz6jawIB
        cODTibwJ1PUcwtOhkuDzFRuQR+9u/28HK7OvFfjTvg==
X-Google-Smtp-Source: ABdhPJxoSBX+HyUlYztrB/PX2WWdqsfjofIlBI3XTo+U45A8v+n+TZ0kql4znsPHYLs5v9vrKH/2MFUrSAwQfpCMFmU=
X-Received: by 2002:a05:6e02:1a4b:: with SMTP id u11mr219105ilv.258.1619122958865;
 Thu, 22 Apr 2021 13:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com> <20210420220804.486803-4-axelrasmussen@google.com>
In-Reply-To: <20210420220804.486803-4-axelrasmussen@google.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 22 Apr 2021 13:22:02 -0700
Message-ID: <CAJHvVchQk1zrgah08n_P3sHUVzQLZUXHSMbkpd9rG-w5jUGNdw@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 3:08 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> With this change, userspace can resolve a minor fault within a
> shmem-backed area with a UFFDIO_CONTINUE ioctl. The semantics for this
> match those for hugetlbfs - we look up the existing page in the page
> cache, and install a PTE for it.
>
> This commit introduces a new helper: mcopy_atomic_install_pte.
>
> Why handle UFFDIO_CONTINUE for shmem in mm/userfaultfd.c, instead of in
> shmem.c? The existing userfault implementation only relies on shmem.c
> for VM_SHARED VMAs. However, minor fault handling / CONTINUE work just
> fine for !VM_SHARED VMAs as well. We'd prefer to handle CONTINUE for
> shmem in one place, regardless of shared/private (to reduce code
> duplication).
>
> Why add a new mcopy_atomic_install_pte helper? A problem we have with
> continue is that shmem_mcopy_atomic_pte() and mcopy_atomic_pte() are
> *close* to what we want, but not exactly. We do want to setup the PTEs
> in a CONTINUE operation, but we don't want to e.g. allocate a new page,
> charge it (e.g. to the shmem inode), manipulate various flags, etc. Also
> we have the problem stated above: shmem_mcopy_atomic_pte() and
> mcopy_atomic_pte() both handle one-half of the problem (shared /
> private) continue cares about. So, introduce mcontinue_atomic_pte(), to
> handle all of the shmem continue cases. Introduce the helper so it
> doesn't duplicate code with mcopy_atomic_pte().
>
> In a future commit, shmem_mcopy_atomic_pte() will also be modified to
> use this new helper. However, since this is a bigger refactor, it seems
> most clear to do it as a separate change.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  mm/userfaultfd.c | 172 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 127 insertions(+), 45 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 23fa2583bbd1..51d8c0127161 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -48,6 +48,83 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
>         return dst_vma;
>  }
>
> +/*
> + * Install PTEs, to map dst_addr (within dst_vma) to page.
> + *
> + * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
> + * whether or not dst_vma is VM_SHARED. It also handles the more general
> + * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
> + * backed, or not).
> + *
> + * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
> + * shmem_mcopy_atomic_pte instead.
> + */
> +static int mcopy_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> +                                   struct vm_area_struct *dst_vma,
> +                                   unsigned long dst_addr, struct page *page,
> +                                   bool newly_allocated, bool wp_copy)
> +{
> +       int ret;
> +       pte_t _dst_pte, *dst_pte;
> +       bool writable = dst_vma->vm_flags & VM_WRITE;
> +       bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> +       bool page_in_cache = page->mapping;
> +       spinlock_t *ptl;
> +       struct inode *inode;
> +       pgoff_t offset, max_off;
> +
> +       _dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> +       if (page_in_cache && !vm_shared)
> +               writable = false;
> +       if (writable || !page_in_cache)
> +               _dst_pte = pte_mkdirty(_dst_pte);
> +       if (writable) {
> +               if (wp_copy)
> +                       _dst_pte = pte_mkuffd_wp(_dst_pte);
> +               else
> +                       _dst_pte = pte_mkwrite(_dst_pte);
> +       }
> +
> +       dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> +
> +       if (vma_is_shmem(dst_vma)) {
> +               /* serialize against truncate with the page table lock */
> +               inode = dst_vma->vm_file->f_inode;
> +               offset = linear_page_index(dst_vma, dst_addr);
> +               max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +               ret = -EFAULT;
> +               if (unlikely(offset >= max_off))
> +                       goto out_unlock;
> +       }
> +
> +       ret = -EEXIST;
> +       if (!pte_none(*dst_pte))
> +               goto out_unlock;
> +
> +       if (page_in_cache)
> +               page_add_file_rmap(page, false);
> +       else
> +               page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
> +
> +       /*
> +        * Must happen after rmap, as mm_counter() checks mapping (via
> +        * PageAnon()), which is set by __page_set_anon_rmap().
> +        */
> +       inc_mm_counter(dst_mm, mm_counter(page));

Actually, I've noticed that this is still slightly incorrect.

As Hugh pointed out, this works for the anon case, because
page_add_new_anon_rmap() sets page->mapping.

But for the page_in_cache case, it doesn't work: unlike its anon
counterpart, page_add_file_rmap() *does not* set page->mapping. So, I
think this line needs to become:

inc_mm_counter(dst_mm, page_in_cache ? mm_counter_file(page) :
mm_counter(page));

I'll include this fix in a v5 as well.

> +
> +       if (newly_allocated)
> +               lru_cache_add_inactive_or_unevictable(page, dst_vma);
> +
> +       set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> +
> +       /* No need to invalidate - it was non-present before */
> +       update_mmu_cache(dst_vma, dst_addr, dst_pte);
> +       ret = 0;
> +out_unlock:
> +       pte_unmap_unlock(dst_pte, ptl);
> +       return ret;
> +}
> +
>  static int mcopy_atomic_pte(struct mm_struct *dst_mm,
>                             pmd_t *dst_pmd,
>                             struct vm_area_struct *dst_vma,
> @@ -56,13 +133,9 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
>                             struct page **pagep,
>                             bool wp_copy)
>  {
> -       pte_t _dst_pte, *dst_pte;
> -       spinlock_t *ptl;
>         void *page_kaddr;
>         int ret;
>         struct page *page;
> -       pgoff_t offset, max_off;
> -       struct inode *inode;
>
>         if (!*pagep) {
>                 ret = -ENOMEM;
> @@ -99,43 +172,12 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
>         if (mem_cgroup_charge(page, dst_mm, GFP_KERNEL))
>                 goto out_release;
>
> -       _dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
> -       if (dst_vma->vm_flags & VM_WRITE) {
> -               if (wp_copy)
> -                       _dst_pte = pte_mkuffd_wp(_dst_pte);
> -               else
> -                       _dst_pte = pte_mkwrite(_dst_pte);
> -       }
> -
> -       dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> -       if (dst_vma->vm_file) {
> -               /* the shmem MAP_PRIVATE case requires checking the i_size */
> -               inode = dst_vma->vm_file->f_inode;
> -               offset = linear_page_index(dst_vma, dst_addr);
> -               max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> -               ret = -EFAULT;
> -               if (unlikely(offset >= max_off))
> -                       goto out_release_uncharge_unlock;
> -       }
> -       ret = -EEXIST;
> -       if (!pte_none(*dst_pte))
> -               goto out_release_uncharge_unlock;
> -
> -       inc_mm_counter(dst_mm, MM_ANONPAGES);
> -       page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
> -       lru_cache_add_inactive_or_unevictable(page, dst_vma);
> -
> -       set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> -
> -       /* No need to invalidate - it was non-present before */
> -       update_mmu_cache(dst_vma, dst_addr, dst_pte);
> -
> -       pte_unmap_unlock(dst_pte, ptl);
> -       ret = 0;
> +       ret = mcopy_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> +                                      page, true, wp_copy);
> +       if (ret)
> +               goto out_release;
>  out:
>         return ret;
> -out_release_uncharge_unlock:
> -       pte_unmap_unlock(dst_pte, ptl);
>  out_release:
>         put_page(page);
>         goto out;
> @@ -176,6 +218,41 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
>         return ret;
>  }
>
> +/* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
> +static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
> +                               pmd_t *dst_pmd,
> +                               struct vm_area_struct *dst_vma,
> +                               unsigned long dst_addr,
> +                               bool wp_copy)
> +{
> +       struct inode *inode = file_inode(dst_vma->vm_file);
> +       pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> +       struct page *page;
> +       int ret;
> +
> +       ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
> +       if (ret)
> +               goto out;
> +       if (!page) {
> +               ret = -EFAULT;
> +               goto out;
> +       }
> +
> +       ret = mcopy_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> +                                      page, false, wp_copy);
> +       if (ret)
> +               goto out_release;
> +
> +       unlock_page(page);
> +       ret = 0;
> +out:
> +       return ret;
> +out_release:
> +       unlock_page(page);
> +       put_page(page);
> +       goto out;
> +}
> +
>  static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
>  {
>         pgd_t *pgd;
> @@ -415,11 +492,16 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>                                                 unsigned long dst_addr,
>                                                 unsigned long src_addr,
>                                                 struct page **page,
> -                                               bool zeropage,
> +                                               enum mcopy_atomic_mode mode,
>                                                 bool wp_copy)
>  {
>         ssize_t err;
>
> +       if (mode == MCOPY_ATOMIC_CONTINUE) {
> +               return mcontinue_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> +                                           wp_copy);
> +       }
> +
>         /*
>          * The normal page fault path for a shmem will invoke the
>          * fault, fill the hole in the file and COW it right away. The
> @@ -431,7 +513,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>          * and not in the radix tree.
>          */
>         if (!(dst_vma->vm_flags & VM_SHARED)) {
> -               if (!zeropage)
> +               if (mode == MCOPY_ATOMIC_NORMAL)
>                         err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
>                                                dst_addr, src_addr, page,
>                                                wp_copy);
> @@ -441,7 +523,8 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>         } else {
>                 VM_WARN_ON_ONCE(wp_copy);
>                 err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
> -                                            dst_addr, src_addr, zeropage,
> +                                            dst_addr, src_addr,
> +                                            mode != MCOPY_ATOMIC_NORMAL,
>                                              page);
>         }
>
> @@ -463,7 +546,6 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>         long copied;
>         struct page *page;
>         bool wp_copy;
> -       bool zeropage = (mcopy_mode == MCOPY_ATOMIC_ZEROPAGE);
>
>         /*
>          * Sanitize the command parameters:
> @@ -526,7 +608,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>
>         if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
>                 goto out_unlock;
> -       if (mcopy_mode == MCOPY_ATOMIC_CONTINUE)
> +       if (!vma_is_shmem(dst_vma) && mcopy_mode == MCOPY_ATOMIC_CONTINUE)
>                 goto out_unlock;
>
>         /*
> @@ -574,7 +656,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>                 BUG_ON(pmd_trans_huge(*dst_pmd));
>
>                 err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> -                                      src_addr, &page, zeropage, wp_copy);
> +                                      src_addr, &page, mcopy_mode, wp_copy);
>                 cond_resched();
>
>                 if (unlikely(err == -ENOENT)) {
> --
> 2.31.1.368.gbe11c130af-goog
>
