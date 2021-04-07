Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E45F357621
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 22:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhDGUeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 16:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbhDGUdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:33:55 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C302C061762
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Apr 2021 13:33:45 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id x16so20870211iob.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Apr 2021 13:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmrZi7+R5wzOv6zqpXADGuUDKwGSsWYjkqolLt20Qjk=;
        b=PAmsZmfhPVYEKmB2rKSlDqeHJ74TLj+SL17RO2Qn+F7v6RA0TdCQz8G66A1nUhGRM8
         BOSR8YX+ewt+/doVe/NB5uvgvNJph4S21f6pW5a0kqCvHiNutLVlJcZ+fnkC2PXz3umP
         DZ04MAMVESs05UPDHISU2OlF13oGchBt7iX4GelSafTnf5+eA3HHcZyy6MegGlM1qHEp
         zTNphUUpL5+mczK81FBw+JLGAfb1yKWhzlgfd3lwx4JoVr23Dy6PoL1Rc8S2j9ORa7g3
         CdL9lHXjUdzS1WxUfRimF4ynLTtjdpzVRUgACCQCiam6PDHj33Jp5xC9mfDmzBhHLw2u
         iLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmrZi7+R5wzOv6zqpXADGuUDKwGSsWYjkqolLt20Qjk=;
        b=bimkjHH9UleUGXJM61bjXYp/9XX27wq3zK7oUykQCUiEWKjge6gAE8/IFMRD4P4AB8
         euXPRVn06p4giQpWSlvLPdse4zvI73ETqNpwf/DPmRdSnSD0l5aZawi3GqkWZoKwTKUU
         8LRYjXsUiq7X6DQdWFzBroYdiZih+vOt8MpL3ZNHTGtgwyxnq1l2vEZj3pBW0/6eUc2K
         lFTA2gF4/OIRldR1v8WG/mXXI64YWjqEOeWSs8v+2lDo/c4h3RAow+Y+cuvVW8U8YWQP
         XSW632XgpY8lBYmiYnd7gVQ0mteI/8bDckV1tAGtghQS4yq8p4l1QJK8jReDyxp1MJrF
         9e3A==
X-Gm-Message-State: AOAM533DSGfsgVag3UlxHkkQnufg4eI3aafLGdKb75J5ZQs1nVGnty/E
        /9v1PqoMfSANXXotbF7L1PgkasoIDg7tn9wDnwfWbw==
X-Google-Smtp-Source: ABdhPJzeZBVq8z12lx2w1wtlxVP+tpiEAjVwcvEKt7Vq0MNt33HBwwSD3eLQ7du3ABIRz4hnKf+cm6HZyWR4HYVp2/M=
X-Received: by 2002:a05:6602:1207:: with SMTP id y7mr3980187iot.23.1617827624456;
 Wed, 07 Apr 2021 13:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183701.1774159-1-axelrasmussen@google.com> <alpine.LSU.2.11.2104062307110.14082@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2104062307110.14082@eggly.anvils>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 7 Apr 2021 13:33:07 -0700
Message-ID: <CAJHvVcgGbdeoniOzwQsc370idV5gJ5cfq8Kzu3hneBAaB+CL6g@mail.gmail.com>
Subject: Re: [PATCH v4] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTINUE behavior
To:     Hugh Dickins <hughd@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the thorough and insightful review, Hugh!

On Tue, Apr 6, 2021 at 11:14 PM Hugh Dickins <hughd@google.com> wrote:
>
> [PATCH v4] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTINUE behavior
> was a significant rework, so here I'm reviewing a synthetic patch
> merged from 5.12-rc5's 2021-03-31 mmotm patches:
>   userfaultfd-support-minor-fault-handling-for-shmem.patch
>   userfaultfd-support-minor-fault-handling-for-shmem-fix.patch
>   userfaultfd-support-minor-fault-handling-for-shmem-fix-2.patch
> Plus the PATCH v4 which akpm added the next day as fix-3:
>   userfaultfd-support-minor-fault-handling-for-shmem-fix-3.patch
>
> [PATCH v5] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTINUE behavior
> was the same as v4, except for adding a change in selftests, which
> would not apply at this stage of the series: so I've ignored it.

Makes sense. :) Sorry about the confusing diff, a significant portion
of this patch is just undoing what we did in the series that added
this feature in the first place, due to the change in direction.

So, I'm planning to follow Peter's suggestion to roughly squash this
together, and send it as a full series. That ought to be much easier
to review.

So, the process of applying that series (to Andrew's tree) then
becomes, dropping some of the patches that are already in Andrew's
tree, and then applying the full new series. I'll include a precise
list of patches the new series replaces in its cover letter.

>
> >  fs/userfaultfd.c                 |    6
> >  include/linux/shmem_fs.h         |   26 +--
> >  include/uapi/linux/userfaultfd.h |    4
> >  mm/memory.c                      |    8 -
> >  mm/shmem.c                       |   65 +++------
> >  mm/userfaultfd.c                 |  192 ++++++++++++++++++++---------
> >  6 files changed, 186 insertions(+), 115 deletions(-)
> >
> > diff -purN 5125m243/fs/userfaultfd.c 5125m247/fs/userfaultfd.c
> > --- 5125m243/fs/userfaultfd.c 2021-04-04 22:32:32.018244547 -0700
> > +++ 5125m247/fs/userfaultfd.c 2021-04-04 22:34:14.946860343 -0700
> > @@ -1267,8 +1267,7 @@ static inline bool vma_can_userfault(str
> >       }
> >
> >       if (vm_flags & VM_UFFD_MINOR) {
> > -             /* FIXME: Add minor fault interception for shmem. */
> > -             if (!is_vm_hugetlb_page(vma))
> > +             if (!(is_vm_hugetlb_page(vma) || vma_is_shmem(vma)))
> >                       return false;
> >       }
> >
> > @@ -1941,7 +1940,8 @@ static int userfaultfd_api(struct userfa
> >       /* report all available features and ioctls to userland */
> >       uffdio_api.features = UFFD_API_FEATURES;
> >  #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> > -     uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS;
> > +     uffdio_api.features &=
> > +             ~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
> >  #endif
> >       uffdio_api.ioctls = UFFD_API_IOCTLS;
> >       ret = -EFAULT;
> > diff -purN 5125m243/include/linux/shmem_fs.h 5125m247/include/linux/shmem_fs.h
> > --- 5125m243/include/linux/shmem_fs.h 2021-02-14 14:32:24.000000000 -0800
> > +++ 5125m247/include/linux/shmem_fs.h 2021-04-04 22:34:14.958860415 -0700
> > @@ -9,6 +9,7 @@
> >  #include <linux/percpu_counter.h>
> >  #include <linux/xattr.h>
> >  #include <linux/fs_parser.h>
> > +#include <linux/userfaultfd_k.h>
>
> I'd much rather not include userfaultfd_k.h in shmem_fs.h, and go back
> to including it in mm/shmem.c: it's better to minimize everyone's header
> file inclusion, where reasonably possible.  A small change below for that.
>
> I advise the same for include/linux/hugetlb.h and mm/hugetlb.c,
> but those are outside the scope of this userfaultfd/shmem patch.
>
> >
> >  /* inode in-kernel data */
> >
> > @@ -122,21 +123,16 @@ static inline bool shmem_file(struct fil
> >  extern bool shmem_charge(struct inode *inode, long pages);
> >  extern void shmem_uncharge(struct inode *inode, long pages);
> >
> > +#ifdef CONFIG_USERFAULTFD
> >  #ifdef CONFIG_SHMEM
> > -extern int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > -                               struct vm_area_struct *dst_vma,
> > -                               unsigned long dst_addr,
> > -                               unsigned long src_addr,
> > -                               struct page **pagep);
> > -extern int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
> > -                                 pmd_t *dst_pmd,
> > -                                 struct vm_area_struct *dst_vma,
> > -                                 unsigned long dst_addr);
> > -#else
> > -#define shmem_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
> > -                            src_addr, pagep)        ({ BUG(); 0; })
> > -#define shmem_mfill_zeropage_pte(dst_mm, dst_pmd, dst_vma, \
> > -                              dst_addr)      ({ BUG(); 0; })
> > -#endif
>
> Please add
> enum mcopy_atomic_mode;
> here, so the compiler can understand it without needing userfaultfd_k.h.
>
> > +int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > +                        struct vm_area_struct *dst_vma,
> > +                        unsigned long dst_addr, unsigned long src_addr,
> > +                        enum mcopy_atomic_mode mode, struct page **pagep);
> > +#else /* !CONFIG_SHMEM */
> > +#define shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr, \
> > +                            src_addr, mode, pagep)        ({ BUG(); 0; })
> > +#endif /* CONFIG_SHMEM */
> > +#endif /* CONFIG_USERFAULTFD */
> >
> >  #endif
> > diff -purN 5125m243/include/uapi/linux/userfaultfd.h 5125m247/include/uapi/linux/userfaultfd.h
> > --- 5125m243/include/uapi/linux/userfaultfd.h 2021-04-04 22:32:32.042244690 -0700
> > +++ 5125m247/include/uapi/linux/userfaultfd.h 2021-04-04 22:34:14.962860439 -0700
> > @@ -31,7 +31,8 @@
> >                          UFFD_FEATURE_MISSING_SHMEM |         \
> >                          UFFD_FEATURE_SIGBUS |                \
> >                          UFFD_FEATURE_THREAD_ID |             \
> > -                        UFFD_FEATURE_MINOR_HUGETLBFS)
> > +                        UFFD_FEATURE_MINOR_HUGETLBFS |       \
> > +                        UFFD_FEATURE_MINOR_SHMEM)
> >  #define UFFD_API_IOCTLS                              \
> >       ((__u64)1 << _UFFDIO_REGISTER |         \
> >        (__u64)1 << _UFFDIO_UNREGISTER |       \
> > @@ -196,6 +197,7 @@ struct uffdio_api {
> >  #define UFFD_FEATURE_SIGBUS                  (1<<7)
> >  #define UFFD_FEATURE_THREAD_ID                       (1<<8)
> >  #define UFFD_FEATURE_MINOR_HUGETLBFS         (1<<9)
> > +#define UFFD_FEATURE_MINOR_SHMEM             (1<<10)
>
> That's fine, but looking at the file itself, UFFD_FEATURE_MINOR_HUGETLBFS
> has been given a comment above this list, so UFFD_FEATURE_MINOR_SHMEM is
> feeling lonely without one.
>
> >       __u64 features;
> >
> >       __u64 ioctls;
> > diff -purN 5125m243/mm/memory.c 5125m247/mm/memory.c
> > --- 5125m243/mm/memory.c      2021-04-04 22:32:32.082244929 -0700
> > +++ 5125m247/mm/memory.c      2021-04-04 22:34:15.002860678 -0700
> > @@ -3972,9 +3972,11 @@ static vm_fault_t do_read_fault(struct v
> >        * something).
> >        */
> >       if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
> > -             ret = do_fault_around(vmf);
> > -             if (ret)
> > -                     return ret;
> > +             if (likely(!userfaultfd_minor(vmf->vma))) {
> > +                     ret = do_fault_around(vmf);
> > +                     if (ret)
> > +                             return ret;
> > +             }
>
> Ah yes, that's important, well spotted.
>
> >       }
> >
> >       ret = __do_fault(vmf);
> > diff -purN 5125m243/mm/shmem.c 5125m247/mm/shmem.c
> > --- 5125m243/mm/shmem.c       2021-02-28 18:30:29.692414467 -0800
> > +++ 5125m247/mm/shmem.c       2021-04-04 22:34:15.014860751 -0700
> > @@ -77,7 +77,6 @@ static struct vfsmount *shm_mnt;
> >  #include <linux/syscalls.h>
> >  #include <linux/fcntl.h>
> >  #include <uapi/linux/memfd.h>
> > -#include <linux/userfaultfd_k.h>
> >  #include <linux/rmap.h>
> >  #include <linux/uuid.h>
> >
> > @@ -1785,8 +1784,8 @@ unlock:
> >   * vm. If we swap it in we mark it dirty since we also free the swap
> >   * entry since a page cannot live in both the swap and page cache.
> >   *
> > - * vmf and fault_type are only supplied by shmem_fault:
> > - * otherwise they are NULL.
> > + * vma, vmf, and fault_type are only supplied by shmem_fault: otherwise they
>
> Yes, you're right (though I did prefer the newline after ":" as before).
>
> > + * are NULL.
> >   */
> >  static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> >       struct page **pagep, enum sgp_type sgp, gfp_t gfp,
> > @@ -1830,6 +1829,13 @@ repeat:
> >               return error;
> >       }
> >
> > +     if (page && vma && userfaultfd_minor(vma)) {
> > +             unlock_page(page);
> > +             put_page(page);
> > +             *fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> > +             return 0;
> > +     }
> > +
>
> Yes and no. The problem here is that just above is an early return
> from the xa_is_value() shmem_swapin_page() case: if the page had been
> out on swap, VM_UFFD_MINOR must return there too.
>
> (I haven't looked into the neatest way of coding that: it would
> be preferable to have just one userfaultfd_minor() check and one
> handle_userfault() call for both swapped-out and in-cache cases;
> but maybe doing it that way would turn out to uglify the flow.)
>
> (Should shmem_getpage_gfp() return before doing shmem_swapin_page(),
> if swap is found when VM_UFFD_MINOR? Leaving it to userspace to touch
> the page and swap it in? That could be more efficient, letting userspace
> do it without the mmap_lock; but that would not be a robust interface,
> and the exceptional swap path does not need such optmization.)
>
> >       if (page)
> >               hindex = page->index;
> >       if (page && sgp == SGP_WRITE)
> > @@ -2354,13 +2360,11 @@ static struct inode *shmem_get_inode(str
> >       return inode;
> >  }
> >
> > -static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
> > -                               pmd_t *dst_pmd,
> > -                               struct vm_area_struct *dst_vma,
> > -                               unsigned long dst_addr,
> > -                               unsigned long src_addr,
> > -                               bool zeropage,
> > -                               struct page **pagep)
> > +#ifdef CONFIG_USERFAULTFD
>
> Thank you! It's particularly helpful, given that "shmem_mcopy_atomic_pte"
> gives no hint that it's for userfaultfd. (And I had to read Documentation
> to understand why it likes to say "atomic" here.)  Okay, it's not your job
> to change userfaultfd naming and organization; but on these rare occasions
> that I have to revisit it, I do wish it were easier to follow.
>
> > +int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > +                        struct vm_area_struct *dst_vma,
> > +                        unsigned long dst_addr, unsigned long src_addr,
> > +                        enum mcopy_atomic_mode mode, struct page **pagep)
> >  {
> >       struct inode *inode = file_inode(dst_vma->vm_file);
> >       struct shmem_inode_info *info = SHMEM_I(inode);
> > @@ -2372,7 +2376,11 @@ static int shmem_mfill_atomic_pte(struct
> >       struct page *page;
> >       pte_t _dst_pte, *dst_pte;
> >       int ret;
> > -     pgoff_t offset, max_off;
> > +     pgoff_t max_off;
> > +
> > +     /* Handled by mcontinue_atomic_pte instead. */
> > +     if (WARN_ON_ONCE(mode == MCOPY_ATOMIC_CONTINUE))
> > +             return -EINVAL;
> >
> >       ret = -ENOMEM;
> >       if (!shmem_inode_acct_block(inode, 1))
> > @@ -2383,7 +2391,7 @@ static int shmem_mfill_atomic_pte(struct
> >               if (!page)
> >                       goto out_unacct_blocks;
> >
> > -             if (!zeropage) {        /* mcopy_atomic */
> > +             if (mode == MCOPY_ATOMIC_NORMAL) {      /* mcopy_atomic */
> >                       page_kaddr = kmap_atomic(page);
> >                       ret = copy_from_user(page_kaddr,
> >                                            (const void __user *)src_addr,
> > @@ -2397,7 +2405,7 @@ static int shmem_mfill_atomic_pte(struct
> >                               /* don't free the page */
> >                               return -ENOENT;
> >                       }
> > -             } else {                /* mfill_zeropage_atomic */
> > +             } else {                /* zeropage */
> >                       clear_highpage(page);
> >               }
> >       } else {
> > @@ -2405,15 +2413,15 @@ static int shmem_mfill_atomic_pte(struct
> >               *pagep = NULL;
> >       }
> >
> > -     VM_BUG_ON(PageLocked(page) || PageSwapBacked(page));
> > +     VM_BUG_ON(PageSwapBacked(page));
> > +     VM_BUG_ON(PageLocked(page));
> >       __SetPageLocked(page);
> >       __SetPageSwapBacked(page);
> >       __SetPageUptodate(page);
> >
> >       ret = -EFAULT;
> > -     offset = linear_page_index(dst_vma, dst_addr);
> >       max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > -     if (unlikely(offset >= max_off))
> > +     if (unlikely(pgoff >= max_off))
>
> Yes, that's better.
>
> >               goto out_release;
> >
> >       ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
> > @@ -2439,7 +2447,7 @@ static int shmem_mfill_atomic_pte(struct
> >
> >       ret = -EFAULT;
> >       max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > -     if (unlikely(offset >= max_off))
> > +     if (unlikely(pgoff >= max_off))
> >               goto out_release_unlock;
> >
> >       ret = -EEXIST;
> > @@ -2476,28 +2484,7 @@ out_unacct_blocks:
> >       shmem_inode_unacct_blocks(inode, 1);
> >       goto out;
> >  }
> > -
> > -int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
> > -                        pmd_t *dst_pmd,
> > -                        struct vm_area_struct *dst_vma,
> > -                        unsigned long dst_addr,
> > -                        unsigned long src_addr,
> > -                        struct page **pagep)
> > -{
> > -     return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
> > -                                   dst_addr, src_addr, false, pagep);
> > -}
> > -
> > -int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
> > -                          pmd_t *dst_pmd,
> > -                          struct vm_area_struct *dst_vma,
> > -                          unsigned long dst_addr)
> > -{
> > -     struct page *page = NULL;
> > -
> > -     return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
> > -                                   dst_addr, 0, true, &page);
> > -}
>
> Yes, I like the way you have combined them into one.
>
> > +#endif /* CONFIG_USERFAULTFD */
> >
> >  #ifdef CONFIG_TMPFS
> >  static const struct inode_operations shmem_symlink_inode_operations;
> > diff -purN 5125m243/mm/userfaultfd.c 5125m247/mm/userfaultfd.c
> > --- 5125m243/mm/userfaultfd.c 2021-04-04 22:32:32.102245048 -0700
> > +++ 5125m247/mm/userfaultfd.c 2021-04-04 22:34:15.022860799 -0700
> > @@ -48,21 +48,103 @@ struct vm_area_struct *find_dst_vma(stru
> >       return dst_vma;
> >  }
> >
> > +/*
> > + * Install PTEs, to map dst_addr (within dst_vma) to page.
> > + *
> > + * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
> > + * whether or not dst_vma is VM_SHARED. It also handles the more general
> > + * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
> > + * backed, or not).
> > + *
> > + * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
> > + * shmem_mcopy_atomic_pte instead.
> > + */
> > +static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > +                                  struct vm_area_struct *dst_vma,
> > +                                  unsigned long dst_addr, struct page *page,
> > +                                  enum mcopy_atomic_mode mode, bool wp_copy)
> > +{
> > +     int ret;
> > +     pte_t _dst_pte, *dst_pte;
> > +     bool is_continue = mode == MCOPY_ATOMIC_CONTINUE;
> > +     int writable;
> > +     bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> > +     bool is_file_backed = dst_vma->vm_file;
> > +     spinlock_t *ptl;
> > +     struct inode *inode;
> > +     pgoff_t offset, max_off;
> > +
> > +     _dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> > +     writable = dst_vma->vm_flags & VM_WRITE;
> > +     /* For CONTINUE on a non-shared VMA, don't pte_mkwrite for CoW. */
> > +     if (is_continue && !vm_shared)
> > +             writable = 0;
>
> Indeed, there is nothing more important than keeping pte_write() off
> page cache mapped privately.
>
> > +
> > +     if (writable) {
> > +             _dst_pte = pte_mkdirty(_dst_pte);
> > +             if (wp_copy)
> > +                     _dst_pte = pte_mkuffd_wp(_dst_pte);
> > +             else
> > +                     _dst_pte = pte_mkwrite(_dst_pte);
> > +     } else if (vm_shared) {
> > +             /*
> > +              * Since we didn't pte_mkdirty(), mark the page dirty or it
> > +              * could be freed from under us. We could do this
> > +              * unconditionally, but doing it only if !writable is faster.
> > +              */
> > +             set_page_dirty(page);
>
> I do not remember why Andrea or I preferred set_page_dirty() here to
> pte_mkdirty(); but I suppose there might somewhere be a BUG_ON(pte_dirty)
> which this would avoid.  Risky to change it, though it does look odd.
>
> > +     }
> > +
> > +     dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> > +
> > +     if (is_file_backed) {
> > +             /* The shmem MAP_PRIVATE case requires checking the i_size */
> > +             inode = dst_vma->vm_file->f_inode;
> > +             offset = linear_page_index(dst_vma, dst_addr);
> > +             max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > +             ret = -EFAULT;
> > +             if (unlikely(offset >= max_off))
> > +                     goto out_unlock;
> > +     }
> > +
> > +     ret = -EEXIST;
> > +     if (!pte_none(*dst_pte))
> > +             goto out_unlock;
> > +
> > +     inc_mm_counter(dst_mm, mm_counter(page));
> > +     if (is_file_backed)
> > +             page_add_file_rmap(page, false);
> > +     else
> > +             page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
> > +
> > +     if (!is_continue)
> > +             lru_cache_add_inactive_or_unevictable(page, dst_vma);
>
> I'm beginning to think that you took a wrong direction in v4 and v5,
> sending MINOR/CONTINUE this way instead of into shmem.c.  I haven't
> spotted any mistakes in this function, but it's not easy.
>
> If shmem_mcopy_atomic_pte() ended up using this mcopy_atomic_install_ptes()
> (and so mm/shmem.c contain no pte manipulation at all), that would be one
> kind of nice outcome.
>
> Or if shmem_mcopy_atomic_pte() handled all of the shmem page cache issues,
> and this just did the anonymous, that would be a different nice outcome.
>
> But here we have mcopy_atomic_install_ptes(), with a host of at-first-sight
> independent booleans (is_continue, is_file_backed, vm_shared, writable,
> wp_copy), doing too much yet not enough.
>
> I think it needs to shift in one direction or another: maybe revert
> back towards something more like v3, or maybe go further with
> mcopy_atomic_install_ptes().

Agreed about taking one direction or the other further.

I get the sense that Peter prefers the mcopy_atomic_install_ptes()
version, and would thus prefer to just expose that and let
shmem_mcopy_atomic_pte() use it.

But, I get the sense that you (Hugh) slightly prefer the other way -
just letting shmem_mcopy_atomic_pte() deal with both the VM_SHARED and
!VM_SHARED cases.

I was planning to write "I prefer option X because (reasons), and
objections?" but I'm realizing that it isn't really clear to me which
route would end up being cleaner. I think I have to just pick one,
write it out, and see where I end up. If it ends up gross, I don't
mind backtracking and taking the other route. :) To that end, I'll
proceed by having shmem_mcopy_atomic_pte() call the new
mcopy_atomic_install_ptes() helper, and see how it looks (unless there
are objections).


>
> > +
> > +     set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> > +
> > +     /* No need to invalidate - it was non-present before */
> > +     update_mmu_cache(dst_vma, dst_addr, dst_pte);
> > +     pte_unmap_unlock(dst_pte, ptl);
> > +     ret = 0;
>
>         ret =0;
> out_unlock:
>         pte_unmap_unlock(dst_pte, ptl);
>
> would avoid the goto out contortions at out_unlock below.
>
> > +out:
> > +     return ret;
> > +out_unlock:
> > +     pte_unmap_unlock(dst_pte, ptl);
> > +     goto out;
> > +}
> > +
> >  static int mcopy_atomic_pte(struct mm_struct *dst_mm,
> >                           pmd_t *dst_pmd,
> >                           struct vm_area_struct *dst_vma,
> >                           unsigned long dst_addr,
> >                           unsigned long src_addr,
> >                           struct page **pagep,
> > +                         enum mcopy_atomic_mode mode,
> >                           bool wp_copy)
> >  {
> > -     pte_t _dst_pte, *dst_pte;
> > -     spinlock_t *ptl;
> >       void *page_kaddr;
> >       int ret;
> >       struct page *page;
> > -     pgoff_t offset, max_off;
> > -     struct inode *inode;
> >
> >       if (!*pagep) {
> >               ret = -ENOMEM;
> > @@ -99,43 +181,12 @@ static int mcopy_atomic_pte(struct mm_st
> >       if (mem_cgroup_charge(page, dst_mm, GFP_KERNEL))
> >               goto out_release;
> >
> > -     _dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
> > -     if (dst_vma->vm_flags & VM_WRITE) {
> > -             if (wp_copy)
> > -                     _dst_pte = pte_mkuffd_wp(_dst_pte);
> > -             else
> > -                     _dst_pte = pte_mkwrite(_dst_pte);
> > -     }
> > -
> > -     dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> > -     if (dst_vma->vm_file) {
> > -             /* the shmem MAP_PRIVATE case requires checking the i_size */
> > -             inode = dst_vma->vm_file->f_inode;
> > -             offset = linear_page_index(dst_vma, dst_addr);
> > -             max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > -             ret = -EFAULT;
> > -             if (unlikely(offset >= max_off))
> > -                     goto out_release_uncharge_unlock;
> > -     }
> > -     ret = -EEXIST;
> > -     if (!pte_none(*dst_pte))
> > -             goto out_release_uncharge_unlock;
> > -
> > -     inc_mm_counter(dst_mm, MM_ANONPAGES);
> > -     page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
> > -     lru_cache_add_inactive_or_unevictable(page, dst_vma);
> > -
> > -     set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> > -
> > -     /* No need to invalidate - it was non-present before */
> > -     update_mmu_cache(dst_vma, dst_addr, dst_pte);
> > -
> > -     pte_unmap_unlock(dst_pte, ptl);
> > -     ret = 0;
> > +     ret = mcopy_atomic_install_ptes(dst_mm, dst_pmd, dst_vma, dst_addr,
> > +                                     page, mode, wp_copy);
> > +     if (ret)
> > +             goto out_release;
> >  out:
> >       return ret;
> > -out_release_uncharge_unlock:
> > -     pte_unmap_unlock(dst_pte, ptl);
> >  out_release:
> >       put_page(page);
> >       goto out;
> > @@ -176,6 +227,38 @@ out_unlock:
> >       return ret;
> >  }
> >
> > +static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
> > +                             pmd_t *dst_pmd,
> > +                             struct vm_area_struct *dst_vma,
> > +                             unsigned long dst_addr,
> > +                             bool wp_copy)
> > +{
> > +     struct inode *inode = file_inode(dst_vma->vm_file);
> > +     struct address_space *mapping = inode->i_mapping;
> > +     pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> > +     struct page *page;
> > +     int ret;
> > +
> > +     ret = -EFAULT;
> > +     page = find_lock_page(mapping, pgoff);
> > +     if (!page)
> > +             goto out;
>
> No. That looks nice and generic, but IIUC only shmem gets to come this way,
> and find_lock_page() is not allowing for swap. Agreed that it will be
> unlikely for the page (vetted by userspace before ioctl'ing to here) to
> have gotten swapped out meanwhile, but we must allow for that unlikelihood.
>
> You will need to use shmem_getpage(SGP_CACHE) instead: NULL vma so you
> don't get trapped into endless userfaultfd_minor() breakouts.  (If someone
> else punched a hole in the file meanwhile, shmem_getpage() will allocate
> a new page you don't particularly want: but that is not a case we need to
> care about, beyond getting the accounting right and not crashing.)
>
> > +
> > +     ret = mcopy_atomic_install_ptes(dst_mm, dst_pmd, dst_vma, dst_addr,
> > +                                     page, MCOPY_ATOMIC_CONTINUE, wp_copy);
> > +     if (ret)
> > +             goto out_release;
> > +
> > +     unlock_page(page);
> > +     ret = 0;
> > +out:
> > +     return ret;
> > +out_release:
> > +     unlock_page(page);
> > +     put_page(page);
> > +     goto out;
> > +}
> > +
> >  static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
> >  {
> >       pgd_t *pgd;
> > @@ -415,10 +498,16 @@ static __always_inline ssize_t mfill_ato
> >                                               unsigned long dst_addr,
> >                                               unsigned long src_addr,
> >                                               struct page **page,
> > -                                             bool zeropage,
> > +                                             enum mcopy_atomic_mode mode,
> >                                               bool wp_copy)
> >  {
> > -     ssize_t err;
> > +     ssize_t err = 0;
> > +
> > +     if (mode == MCOPY_ATOMIC_CONTINUE) {
> > +             err = mcontinue_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> > +                                        wp_copy);
> > +             goto out;
> > +     }
> >
> >       /*
> >        * The normal page fault path for a shmem will invoke the
> > @@ -431,24 +520,20 @@ static __always_inline ssize_t mfill_ato
> >        * and not in the radix tree.
> >        */
> >       if (!(dst_vma->vm_flags & VM_SHARED)) {
> > -             if (!zeropage)
> > +             if (mode == MCOPY_ATOMIC_NORMAL)
> >                       err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
> >                                              dst_addr, src_addr, page,
> > -                                            wp_copy);
> > -             else
> > +                                            mode, wp_copy);
> > +             else if (mode == MCOPY_ATOMIC_ZEROPAGE)
> >                       err = mfill_zeropage_pte(dst_mm, dst_pmd,
> >                                                dst_vma, dst_addr);
> >       } else {
> >               VM_WARN_ON_ONCE(wp_copy);
> > -             if (!zeropage)
> > -                     err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
> > -                                                  dst_vma, dst_addr,
> > -                                                  src_addr, page);
> > -             else
> > -                     err = shmem_mfill_zeropage_pte(dst_mm, dst_pmd,
> > -                                                    dst_vma, dst_addr);
> > +             err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> > +                                          src_addr, mode, page);
> >       }
> >
> > +out:
> >       return err;
> >  }
> >
> > @@ -467,7 +552,6 @@ static __always_inline ssize_t __mcopy_a
> >       long copied;
> >       struct page *page;
> >       bool wp_copy;
> > -     bool zeropage = (mcopy_mode == MCOPY_ATOMIC_ZEROPAGE);
> >
> >       /*
> >        * Sanitize the command parameters:
> > @@ -530,7 +614,7 @@ retry:
> >
> >       if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
> >               goto out_unlock;
> > -     if (mcopy_mode == MCOPY_ATOMIC_CONTINUE)
> > +     if (!vma_is_shmem(dst_vma) && mcopy_mode == MCOPY_ATOMIC_CONTINUE)
> >               goto out_unlock;
> >
> >       /*
> > @@ -578,7 +662,7 @@ retry:
> >               BUG_ON(pmd_trans_huge(*dst_pmd));
> >
> >               err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> > -                                    src_addr, &page, zeropage, wp_copy);
> > +                                    src_addr, &page, mcopy_mode, wp_copy);
> >               cond_resched();
> >
> >               if (unlikely(err == -ENOENT)) {
>
> I didn't pay a great deal of attention to the remainder above: I think it's
> right, but it would have been easier to review if mcopy_mode and refactoring
> had been introduced in a preliminary patch, before going on to implement
> MINOR/CONTINUE on shmem.
>
> Hugh
