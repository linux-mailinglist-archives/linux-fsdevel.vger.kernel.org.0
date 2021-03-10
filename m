Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE05333479
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 05:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhCJEky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 23:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhCJEkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 23:40:43 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DB7C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Mar 2021 20:40:42 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z13so16511931iox.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Mar 2021 20:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcISgC5Q3nGprCOYu/lpREhq7zt2FDTKaFHkwjCP9Uk=;
        b=QUiVQOMEl2A0jPCar/3uflczSQwzmfYSg9UyJsO73ajJc81o48FaBjLx1wuvMNqHNc
         zTOVWDKQ7qc4IbDual/uMz/FHGneN4YGEuCLIyL+pb5ZOv5r88lgJCmo9jtgW2xauIL6
         wJrRyXzcJvgAbRSpUISDZBPRr0KYdKS1DgxtjGXH8+CUGu+p0fDTMm0tV0lP1KUOrizF
         +szikY/U2aTozxMMByx+REquYNRQK0ut/a9wYNX9xLyAWgF+rUd2TJC0aNbAbq3p5QbY
         FUfcQEG4O+BA06/M7aj7lluYApyNXocqKICnfy9/YE/tXzbc3X1DBgGRJLRoNK7Zqu5e
         Vr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcISgC5Q3nGprCOYu/lpREhq7zt2FDTKaFHkwjCP9Uk=;
        b=G2yTpi9kYfpOgxmEYevqevuPw6kYyj77OnlsgcUskRTZQXFMBwjF7VHEJ7DC2QQr8x
         iBmkLs0njRlY1dFrBHQUpVF59NoGdgp2lahqWmIvopNpqeq2ioEE69QE3sWDAPJMXnsP
         4+PoHmMro0lXN6cXlzp/jUqA7qLywqYDRYAigBOo2GiWGBH1uXd1Y2GuPSt+ZnnQXdRD
         Qm90o6sFWhnZgLC82sOO98ls1R6Gfv2UNfwyUkNZpWXBmMyQEHBPu/CFQ/oML173mB/P
         o7aAwj110OrYjEmYXFrht/gGDFUFyVp/CHWLdpUFvyOL9AoOfPFXJeP/JTbEo32tMzr+
         ff0Q==
X-Gm-Message-State: AOAM532+1nbc72D+Au5HNz1q9fZQWKI7xjPt28x0s/03WJm7mEM0pFw1
        j0P6NncxIetbAyut5F5410GLSeXTJbX31bdiJgj4Tg==
X-Google-Smtp-Source: ABdhPJzX4YknmCcU/DR89rwpw8xxcaOmYMQoQYtNNgj9/z7sm7f+W7gzb8C/7CRQOcwZnkZ/Nd14RpR5A5XX+VCzspI=
X-Received: by 2002:a02:cbb2:: with SMTP id v18mr1512510jap.4.1615351242069;
 Tue, 09 Mar 2021 20:40:42 -0800 (PST)
MIME-Version: 1.0
References: <04697A35-AEC7-43F1-8462-1CD39648544A@nvidia.com> <20210309225830.2988269-1-axelrasmussen@google.com>
In-Reply-To: <20210309225830.2988269-1-axelrasmussen@google.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 9 Mar 2021 20:40:05 -0800
Message-ID: <CAJHvVciPYrwoSVz7sj25uw7crB_XU6vqiV3QPM5V8jwqa3R6eA@mail.gmail.com>
Subject: Re: [PATCH v2.5] userfaultfd: support minor fault handling for shmem
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>, Wang Qing <wangqing@vivo.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>, Zi Yan <ziy@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+Stephen to CC, as an FYI.

On Tue, Mar 9, 2021 at 2:58 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> Modify the userfaultfd register API to allow registering shmem VMAs in
> minor mode. Modify the shmem mcopy implementation to support
> UFFDIO_CONTINUE in order to resolve such faults.
>
> Combine the shmem mcopy handler functions into a single
> shmem_mcopy_atomic_pte, which takes a mode parameter. This matches how
> the hugetlbfs implementation is structured, and lets us remove a good
> chunk of boilerplate.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/userfaultfd.c                 |  6 +-
>  include/linux/shmem_fs.h         | 26 ++++-----
>  include/uapi/linux/userfaultfd.h |  4 +-
>  mm/memory.c                      |  8 ++-
>  mm/shmem.c                       | 94 +++++++++++++++-----------------
>  mm/userfaultfd.c                 | 27 ++++-----
>  6 files changed, 81 insertions(+), 84 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 14f92285d04f..9f3b8684cf3c 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1267,8 +1267,7 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
>         }
>
>         if (vm_flags & VM_UFFD_MINOR) {
> -               /* FIXME: Add minor fault interception for shmem. */
> -               if (!is_vm_hugetlb_page(vma))
> +               if (!(is_vm_hugetlb_page(vma) || vma_is_shmem(vma)))
>                         return false;
>         }
>
> @@ -1941,7 +1940,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
>         /* report all available features and ioctls to userland */
>         uffdio_api.features = UFFD_API_FEATURES;
>  #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> -       uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS;
> +       uffdio_api.features &=
> +               ~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
>  #endif
>         uffdio_api.ioctls = UFFD_API_IOCTLS;
>         ret = -EFAULT;
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index d82b6f396588..f0919c3722e7 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -9,6 +9,7 @@
>  #include <linux/percpu_counter.h>
>  #include <linux/xattr.h>
>  #include <linux/fs_parser.h>
> +#include <linux/userfaultfd_k.h>
>
>  /* inode in-kernel data */
>
> @@ -122,21 +123,16 @@ static inline bool shmem_file(struct file *file)
>  extern bool shmem_charge(struct inode *inode, long pages);
>  extern void shmem_uncharge(struct inode *inode, long pages);
>
> +#ifdef CONFIG_USERFAULTFD
>  #ifdef CONFIG_SHMEM
> -extern int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> -                                 struct vm_area_struct *dst_vma,
> -                                 unsigned long dst_addr,
> -                                 unsigned long src_addr,
> -                                 struct page **pagep);
> -extern int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
> -                                   pmd_t *dst_pmd,
> -                                   struct vm_area_struct *dst_vma,
> -                                   unsigned long dst_addr);
> -#else
> -#define shmem_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
> -                              src_addr, pagep)        ({ BUG(); 0; })
> -#define shmem_mfill_zeropage_pte(dst_mm, dst_pmd, dst_vma, \
> -                                dst_addr)      ({ BUG(); 0; })
> -#endif
> +int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> +                          struct vm_area_struct *dst_vma,
> +                          unsigned long dst_addr, unsigned long src_addr,
> +                          enum mcopy_atomic_mode mode, struct page **pagep);
> +#else /* !CONFIG_SHMEM */
> +#define shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr, \
> +                              src_addr, mode, pagep)        ({ BUG(); 0; })
> +#endif /* CONFIG_SHMEM */
> +#endif /* CONFIG_USERFAULTFD */
>
>  #endif
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index bafbeb1a2624..47d9790d863d 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -31,7 +31,8 @@
>                            UFFD_FEATURE_MISSING_SHMEM |         \
>                            UFFD_FEATURE_SIGBUS |                \
>                            UFFD_FEATURE_THREAD_ID |             \
> -                          UFFD_FEATURE_MINOR_HUGETLBFS)
> +                          UFFD_FEATURE_MINOR_HUGETLBFS |       \
> +                          UFFD_FEATURE_MINOR_SHMEM)
>  #define UFFD_API_IOCTLS                                \
>         ((__u64)1 << _UFFDIO_REGISTER |         \
>          (__u64)1 << _UFFDIO_UNREGISTER |       \
> @@ -196,6 +197,7 @@ struct uffdio_api {
>  #define UFFD_FEATURE_SIGBUS                    (1<<7)
>  #define UFFD_FEATURE_THREAD_ID                 (1<<8)
>  #define UFFD_FEATURE_MINOR_HUGETLBFS           (1<<9)
> +#define UFFD_FEATURE_MINOR_SHMEM               (1<<10)
>         __u64 features;
>
>         __u64 ioctls;
> diff --git a/mm/memory.c b/mm/memory.c
> index c8e357627318..a1e5ff55027e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3929,9 +3929,11 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
>          * something).
>          */
>         if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
> -               ret = do_fault_around(vmf);
> -               if (ret)
> -                       return ret;
> +               if (likely(!userfaultfd_minor(vmf->vma))) {
> +                       ret = do_fault_around(vmf);
> +                       if (ret)
> +                               return ret;
> +               }
>         }
>
>         ret = __do_fault(vmf);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b2db4ed0fbc7..ef8c9f5e92fc 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -77,7 +77,6 @@ static struct vfsmount *shm_mnt;
>  #include <linux/syscalls.h>
>  #include <linux/fcntl.h>
>  #include <uapi/linux/memfd.h>
> -#include <linux/userfaultfd_k.h>
>  #include <linux/rmap.h>
>  #include <linux/uuid.h>
>
> @@ -1785,8 +1784,8 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>   * vm. If we swap it in we mark it dirty since we also free the swap
>   * entry since a page cannot live in both the swap and page cache.
>   *
> - * vmf and fault_type are only supplied by shmem_fault:
> - * otherwise they are NULL.
> + * vma, vmf, and fault_type are only supplied by shmem_fault: otherwise they
> + * are NULL.
>   */
>  static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>         struct page **pagep, enum sgp_type sgp, gfp_t gfp,
> @@ -1830,6 +1829,12 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>                 return error;
>         }
>
> +       if (page && vma && userfaultfd_minor(vma)) {
> +               unlock_page(page);
> +               *fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> +               return 0;
> +       }
> +
>         if (page)
>                 hindex = page->index;
>         if (page && sgp == SGP_WRITE)
> @@ -2354,14 +2359,13 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>         return inode;
>  }
>
> -static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
> -                                 pmd_t *dst_pmd,
> -                                 struct vm_area_struct *dst_vma,
> -                                 unsigned long dst_addr,
> -                                 unsigned long src_addr,
> -                                 bool zeropage,
> -                                 struct page **pagep)
> +#ifdef CONFIG_USERFAULTFD
> +int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> +                          struct vm_area_struct *dst_vma,
> +                          unsigned long dst_addr, unsigned long src_addr,
> +                          enum mcopy_atomic_mode mode, struct page **pagep)
>  {
> +       bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
>         struct inode *inode = file_inode(dst_vma->vm_file);
>         struct shmem_inode_info *info = SHMEM_I(inode);
>         struct address_space *mapping = inode->i_mapping;
> @@ -2378,12 +2382,17 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>         if (!shmem_inode_acct_block(inode, 1))
>                 goto out;
>
> -       if (!*pagep) {
> +       if (is_continue) {
> +               ret = -EFAULT;
> +               page = find_lock_page(mapping, pgoff);
> +               if (!page)
> +                       goto out_unacct_blocks;
> +       } else if (!*pagep) {
>                 page = shmem_alloc_page(gfp, info, pgoff);
>                 if (!page)
>                         goto out_unacct_blocks;
>
> -               if (!zeropage) {        /* mcopy_atomic */
> +               if (mode == MCOPY_ATOMIC_NORMAL) {      /* mcopy_atomic */
>                         page_kaddr = kmap_atomic(page);
>                         ret = copy_from_user(page_kaddr,
>                                              (const void __user *)src_addr,
> @@ -2397,7 +2406,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>                                 /* don't free the page */
>                                 return -ENOENT;
>                         }
> -               } else {                /* mfill_zeropage_atomic */
> +               } else {                /* zeropage */
>                         clear_highpage(page);
>                 }
>         } else {
> @@ -2405,10 +2414,13 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>                 *pagep = NULL;
>         }
>
> -       VM_BUG_ON(PageLocked(page) || PageSwapBacked(page));
> -       __SetPageLocked(page);
> -       __SetPageSwapBacked(page);
> -       __SetPageUptodate(page);
> +       if (!is_continue) {
> +               VM_BUG_ON(PageSwapBacked(page));
> +               VM_BUG_ON(PageLocked(page));
> +               __SetPageLocked(page);
> +               __SetPageSwapBacked(page);
> +               __SetPageUptodate(page);
> +       }
>
>         ret = -EFAULT;
>         offset = linear_page_index(dst_vma, dst_addr);
> @@ -2416,10 +2428,13 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>         if (unlikely(offset >= max_off))
>                 goto out_release;
>
> -       ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
> -                                     gfp & GFP_RECLAIM_MASK, dst_mm);
> -       if (ret)
> -               goto out_release;
> +       /* If page wasn't already in the page cache, add it. */
> +       if (!is_continue) {
> +               ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
> +                                             gfp & GFP_RECLAIM_MASK, dst_mm);
> +               if (ret)
> +                       goto out_release;
> +       }
>
>         _dst_pte = mk_pte(page, dst_vma->vm_page_prot);
>         if (dst_vma->vm_flags & VM_WRITE)
> @@ -2446,13 +2461,15 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>         if (!pte_none(*dst_pte))
>                 goto out_release_unlock;
>
> -       lru_cache_add(page);
> +       if (!is_continue) {
> +               lru_cache_add(page);
>
> -       spin_lock_irq(&info->lock);
> -       info->alloced++;
> -       inode->i_blocks += BLOCKS_PER_PAGE;
> -       shmem_recalc_inode(inode);
> -       spin_unlock_irq(&info->lock);
> +               spin_lock_irq(&info->lock);
> +               info->alloced++;
> +               inode->i_blocks += BLOCKS_PER_PAGE;
> +               shmem_recalc_inode(inode);
> +               spin_unlock_irq(&info->lock);
> +       }
>
>         inc_mm_counter(dst_mm, mm_counter_file(page));
>         page_add_file_rmap(page, false);
> @@ -2476,28 +2493,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>         shmem_inode_unacct_blocks(inode, 1);
>         goto out;
>  }
> -
> -int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
> -                          pmd_t *dst_pmd,
> -                          struct vm_area_struct *dst_vma,
> -                          unsigned long dst_addr,
> -                          unsigned long src_addr,
> -                          struct page **pagep)
> -{
> -       return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
> -                                     dst_addr, src_addr, false, pagep);
> -}
> -
> -int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
> -                            pmd_t *dst_pmd,
> -                            struct vm_area_struct *dst_vma,
> -                            unsigned long dst_addr)
> -{
> -       struct page *page = NULL;
> -
> -       return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
> -                                     dst_addr, 0, true, &page);
> -}
> +#endif /* CONFIG_USERFAULTFD */
>
>  #ifdef CONFIG_TMPFS
>  static const struct inode_operations shmem_symlink_inode_operations;
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index ce6cb4760d2c..6cd7ab531aec 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -415,7 +415,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>                                                 unsigned long dst_addr,
>                                                 unsigned long src_addr,
>                                                 struct page **page,
> -                                               bool zeropage,
> +                                               enum mcopy_atomic_mode mode,
>                                                 bool wp_copy)
>  {
>         ssize_t err;
> @@ -431,22 +431,24 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>          * and not in the radix tree.
>          */
>         if (!(dst_vma->vm_flags & VM_SHARED)) {
> -               if (!zeropage)
> +               switch (mode) {
> +               case MCOPY_ATOMIC_NORMAL:
>                         err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
>                                                dst_addr, src_addr, page,
>                                                wp_copy);
> -               else
> +                       break;
> +               case MCOPY_ATOMIC_ZEROPAGE:
>                         err = mfill_zeropage_pte(dst_mm, dst_pmd,
>                                                  dst_vma, dst_addr);
> +                       break;
> +               case MCOPY_ATOMIC_CONTINUE:
> +                       err = -EINVAL;
> +                       break;
> +               }
>         } else {
>                 VM_WARN_ON_ONCE(wp_copy);
> -               if (!zeropage)
> -                       err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
> -                                                    dst_vma, dst_addr,
> -                                                    src_addr, page);
> -               else
> -                       err = shmem_mfill_zeropage_pte(dst_mm, dst_pmd,
> -                                                      dst_vma, dst_addr);
> +               err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> +                                            src_addr, mode, page);
>         }
>
>         return err;
> @@ -467,7 +469,6 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>         long copied;
>         struct page *page;
>         bool wp_copy;
> -       bool zeropage = (mcopy_mode == MCOPY_ATOMIC_ZEROPAGE);
>
>         /*
>          * Sanitize the command parameters:
> @@ -530,7 +531,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>
>         if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
>                 goto out_unlock;
> -       if (mcopy_mode == MCOPY_ATOMIC_CONTINUE)
> +       if (!vma_is_shmem(dst_vma) && mcopy_mode == MCOPY_ATOMIC_CONTINUE)
>                 goto out_unlock;
>
>         /*
> @@ -578,7 +579,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>                 BUG_ON(pmd_trans_huge(*dst_pmd));
>
>                 err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> -                                      src_addr, &page, zeropage, wp_copy);
> +                                      src_addr, &page, mcopy_mode, wp_copy);
>                 cond_resched();
>
>                 if (unlikely(err == -ENOENT)) {
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
