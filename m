Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D581E2FF912
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 00:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbhAUXrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 18:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbhAUXrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:47:40 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BAEC061788
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 15:46:57 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id y19so7693254iov.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 15:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOCoJB/4MgZNThu+dIcZm9WGwjvb6fwN+0FgO8Y/DRE=;
        b=kk1/XO5+RiMWH2eaK5KmtMsXb29FEaSVMOrkC35wb5VV7QDwFG1KKlWwkq/1SGVZri
         HP3BqvME4CQw5sqA2exWLXQ9EC+o6BsnWgvNHANuddXyNLqRcd5RcyVtuPNb/9OhLboX
         vw3xuJy5y6J4x9eiSA8ShEcZ+vAPdW/aqN4S/SeUQQV0LEz2C+M0K38iPVzWp3seN4QU
         6jfsHFv0xGrTZbVxfPIhciaT7iTr62Nrhk1weJ9+8vV7cmPKdylb3vBT+VwULA82fxFt
         EqqV7fiQJVc4SV9MStjDq+sLwXk4S+x+2628h0GA5Le1LUlr+EICsR6kQPYcmQr17RW1
         Xpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOCoJB/4MgZNThu+dIcZm9WGwjvb6fwN+0FgO8Y/DRE=;
        b=t6d2W3IDwsMkPocb2CZuH0NHh69jlkkid9hnt5Yqn48QgRn76Cfp2bjQJ0F78jBKiL
         hqOBnncCthgVSWhBiSDIxWl+xKZyiQx8cYaqqp1qz8oHtoIRNUKN0yAI4FzkJQWod0TV
         v5YUqO5axOnkUKbYyYP90SU1P4c5ypO/D508XHcMcshbEoIrgXYNPiMkEcXLejlmJwF3
         0+VtKMkfi7TpNiYU9LjLb6qJagbFlXnvx9QS76253UJBtNgcccw+u2X+tos5VID1fc4g
         15gxCX+qjz1mmuRsPYCk5+5G3fm56u6hfS2az9uWA7ky61PMqZlwld+iq3vh4iHAk4yz
         F8aw==
X-Gm-Message-State: AOAM532a9oEYt+QCLatiFzAeYftaiQ5O/dF+bt5DH+JU7Igo3SfZAe+P
        fJCxG//M4Tw9DX+cJnLaPDyRLzqygwq3xX4V8b/h1A==
X-Google-Smtp-Source: ABdhPJzSUPZQ6ModwKLMEWPK38OQLUaKOIvdn0QWyMDHu9TXnBHg5fjtX9E+l5VqMox7OgGLf/A0D4cAnwJCK5gMr10=
X-Received: by 2002:a6b:5915:: with SMTP id n21mr1509425iob.20.1611272816818;
 Thu, 21 Jan 2021 15:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20210115190451.3135416-1-axelrasmussen@google.com>
 <20210115190451.3135416-8-axelrasmussen@google.com> <20210121224653.GI260413@xz-x1>
In-Reply-To: <20210121224653.GI260413@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 21 Jan 2021 15:46:20 -0800
Message-ID: <CAJHvVciAEdUiDyKPsyYKzg8v4sCXFsWpFY9D+2prk7VK5MyvHg@mail.gmail.com>
Subject: Re: [PATCH 7/9] userfaultfd: add UFFDIO_CONTINUE ioctl
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 2:47 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jan 15, 2021 at 11:04:49AM -0800, Axel Rasmussen wrote:
> > This ioctl is how userspace ought to resolve "minor" userfaults. The
> > idea is, userspace is notified that a minor fault has occurred. It might
> > change the contents of the page using its second non-UFFD mapping, or
> > not. Then, it calls UFFDIO_CONTINUE to tell the kernel "I have ensured
> > the page contents are correct, carry on setting up the mapping".
> >
> > Note that it doesn't make much sense to use UFFDIO_{COPY,ZEROPAGE} for
> > MINOR registered VMAs. ZEROPAGE maps the VMA to the zero page; but in
> > the minor fault case, we already have some pre-existing underlying page.
> > Likewise, UFFDIO_COPY isn't useful if we have a second non-UFFD mapping.
> > We'd just use memcpy() or similar instead.
> >
> > It turns out hugetlb_mcopy_atomic_pte() already does very close to what
> > we want, if an existing page is provided via `struct page **pagep`. We
> > already special-case the behavior a bit for the UFFDIO_ZEROPAGE case, so
> > just extend that design: add an enum for the three modes of operation,
> > and make the small adjustments needed for the MCOPY_ATOMIC_CONTINUE
> > case. (Basically, look up the existing page, and avoid adding the
> > existing page to the page cache or calling set_page_huge_active() on
> > it.)
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  fs/userfaultfd.c                 | 67 +++++++++++++++++++++++++
> >  include/linux/userfaultfd_k.h    |  2 +
> >  include/uapi/linux/userfaultfd.h | 21 +++++++-
> >  mm/hugetlb.c                     | 11 ++--
> >  mm/userfaultfd.c                 | 86 ++++++++++++++++++++++++--------
> >  5 files changed, 158 insertions(+), 29 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 19d6925be03f..f0eb2d63289f 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1530,6 +1530,10 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >               if (!(uffdio_register.mode & UFFDIO_REGISTER_MODE_WP))
> >                       ioctls_out &= ~((__u64)1 << _UFFDIO_WRITEPROTECT);
> >
> > +             /* CONTINUE ioctl is only supported for MINOR ranges. */
> > +             if (!(uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR))
> > +                     ioctls_out &= ~((__u64)1 << _UFFDIO_CONTINUE);
> > +
> >               /*
> >                * Now that we scanned all vmas we can already tell
> >                * userland which ioctls methods are guaranteed to
> > @@ -1883,6 +1887,66 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
> >       return ret;
> >  }
> >
> > +static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
> > +{
> > +     __s64 ret;
> > +     struct uffdio_continue uffdio_continue;
> > +     struct uffdio_continue __user *user_uffdio_continue;
> > +     struct userfaultfd_wake_range range;
> > +
> > +     user_uffdio_continue = (struct uffdio_continue __user *)arg;
> > +
> > +     ret = -EAGAIN;
> > +     if (READ_ONCE(ctx->mmap_changing))
> > +             goto out;
> > +
> > +     ret = -EFAULT;
> > +     if (copy_from_user(&uffdio_continue, user_uffdio_continue,
> > +                        /* don't copy the output fields */
> > +                        sizeof(uffdio_continue) - (sizeof(__s64))))
> > +             goto out;
> > +
> > +     ret = validate_range(ctx->mm, &uffdio_continue.range.start,
> > +                          uffdio_continue.range.len);
> > +     if (ret)
> > +             goto out;
> > +
> > +     ret = -EINVAL;
> > +     /* double check for wraparound just in case. */
> > +     if (uffdio_continue.range.start + uffdio_continue.range.len <=
> > +         uffdio_continue.range.start) {
> > +             goto out;
> > +     }
> > +     if (uffdio_continue.mode & ~UFFDIO_CONTINUE_MODE_DONTWAKE)
> > +             goto out;
> > +
> > +     if (mmget_not_zero(ctx->mm)) {
> > +             ret = mcopy_continue(ctx->mm, uffdio_continue.range.start,
> > +                                  uffdio_continue.range.len,
> > +                                  &ctx->mmap_changing);
> > +             mmput(ctx->mm);
> > +     } else {
> > +             return -ESRCH;
> > +     }
> > +
> > +     if (unlikely(put_user(ret, &user_uffdio_continue->mapped)))
> > +             return -EFAULT;
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     /* len == 0 would wake all */
> > +     BUG_ON(!ret);
> > +     range.len = ret;
> > +     if (!(uffdio_continue.mode & UFFDIO_CONTINUE_MODE_DONTWAKE)) {
> > +             range.start = uffdio_continue.range.start;
> > +             wake_userfault(ctx, &range);
> > +     }
> > +     ret = range.len == uffdio_continue.range.len ? 0 : -EAGAIN;
> > +
> > +out:
> > +     return ret;
> > +}
> > +
> >  static inline unsigned int uffd_ctx_features(__u64 user_features)
> >  {
> >       /*
> > @@ -1967,6 +2031,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
> >       case UFFDIO_WRITEPROTECT:
> >               ret = userfaultfd_writeprotect(ctx, arg);
> >               break;
> > +     case UFFDIO_CONTINUE:
> > +             ret = userfaultfd_continue(ctx, arg);
> > +             break;
> >       }
> >       return ret;
> >  }
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index ed157804ca02..49d7e7b4581f 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -41,6 +41,8 @@ extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
> >                             unsigned long dst_start,
> >                             unsigned long len,
> >                             bool *mmap_changing);
> > +extern ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long dst_start,
> > +                           unsigned long len, bool *mmap_changing);
> >  extern int mwriteprotect_range(struct mm_struct *dst_mm,
> >                              unsigned long start, unsigned long len,
> >                              bool enable_wp, bool *mmap_changing);
> > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> > index 1cc2cd8a5279..9a48305f4bdd 100644
> > --- a/include/uapi/linux/userfaultfd.h
> > +++ b/include/uapi/linux/userfaultfd.h
> > @@ -40,10 +40,12 @@
> >       ((__u64)1 << _UFFDIO_WAKE |             \
> >        (__u64)1 << _UFFDIO_COPY |             \
> >        (__u64)1 << _UFFDIO_ZEROPAGE |         \
> > -      (__u64)1 << _UFFDIO_WRITEPROTECT)
> > +      (__u64)1 << _UFFDIO_WRITEPROTECT |     \
> > +      (__u64)1 << _UFFDIO_CONTINUE)
> >  #define UFFD_API_RANGE_IOCTLS_BASIC          \
> >       ((__u64)1 << _UFFDIO_WAKE |             \
> > -      (__u64)1 << _UFFDIO_COPY)
> > +      (__u64)1 << _UFFDIO_COPY |             \
> > +      (__u64)1 << _UFFDIO_CONTINUE)
> >
> >  /*
> >   * Valid ioctl command number range with this API is from 0x00 to
> > @@ -59,6 +61,7 @@
> >  #define _UFFDIO_COPY                 (0x03)
> >  #define _UFFDIO_ZEROPAGE             (0x04)
> >  #define _UFFDIO_WRITEPROTECT         (0x06)
> > +#define _UFFDIO_CONTINUE             (0x07)
> >  #define _UFFDIO_API                  (0x3F)
> >
> >  /* userfaultfd ioctl ids */
> > @@ -77,6 +80,8 @@
> >                                     struct uffdio_zeropage)
> >  #define UFFDIO_WRITEPROTECT  _IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
> >                                     struct uffdio_writeprotect)
> > +#define UFFDIO_CONTINUE              _IOR(UFFDIO, _UFFDIO_CONTINUE,  \
> > +                                  struct uffdio_continue)
> >
> >  /* read() structure */
> >  struct uffd_msg {
> > @@ -268,6 +273,18 @@ struct uffdio_writeprotect {
> >       __u64 mode;
> >  };
> >
> > +struct uffdio_continue {
> > +     struct uffdio_range range;
> > +#define UFFDIO_CONTINUE_MODE_DONTWAKE                ((__u64)1<<0)
> > +     __u64 mode;
> > +
> > +     /*
> > +      * Fields below here are written by the ioctl and must be at the end:
> > +      * the copy_from_user will not read past here.
> > +      */
> > +     __s64 mapped;
> > +};
> > +
> >  /*
> >   * Flags for the userfaultfd(2) system call itself.
> >   */
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 2b3741d6130c..84392d5fa079 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4666,12 +4666,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >       spinlock_t *ptl;
> >       int ret;
> >       struct page *page;
> > +     bool new_page = false;
> >
> >       if (!*pagep) {
> >               ret = -ENOMEM;
> >               page = alloc_huge_page(dst_vma, dst_addr, 0);
> >               if (IS_ERR(page))
> >                       goto out;
> > +             new_page = true;
> >
> >               ret = copy_huge_page_from_user(page,
> >                                               (const void __user *) src_addr,
> > @@ -4699,10 +4701,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >       mapping = dst_vma->vm_file->f_mapping;
> >       idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> >
> > -     /*
> > -      * If shared, add to page cache
> > -      */
> > -     if (vm_shared) {
> > +     /* Add shared, newly allocated pages to the page cache. */
> > +     if (vm_shared && new_page) {
>
> hugetlb_mcopy_atomic_pte() can be called with *page being set, when
> copy_huge_page_from_user(allow_pagefault=true) is called outside of this
> function before the retry.
>
> IIUC this change could break that case because here new_page will also be false
> then we won't insert page cache (while we should).
>
> So I think instead of the new_page flag we may also want to pass in the new
> mcopy_atomic_mode into this function, otherwise I don't see how we can identify
> these cases.

Ah, indeed, I hadn't fully considered this case. You're absolutely
right that in this path hugetlb_mcopy_atomic_pte will have allocated,
but not fully set up, a page, and it needs to notice that this
happened and deal with it.

I thought about some alternatives, like only ever calling
copy_huge_page_from_user in one of these functions or the other, but
that would be too messy I think. Another alternative would be to have
hugetlb_mcopy_atomic_pte take some new struct instead of a struct page
**, which records not just the page pointer but also what
initialization has / needs to be done ... but this seems messier than
just exposing / passing mcopy_atomic_mode.

I'll send a v2 which implements this suggestion. :)

Thanks for the thorough review!

>
> >               size = i_size_read(mapping->host) >> huge_page_shift(h);
> >               ret = -EFAULT;
> >               if (idx >= size)
> > @@ -4762,7 +4762,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >       update_mmu_cache(dst_vma, dst_addr, dst_pte);
> >
> >       spin_unlock(ptl);
> > -     set_page_huge_active(page);
> > +     if (new_page)
> > +             set_page_huge_active(page);
>
> Same here.
>
> >       if (vm_shared)
> >               unlock_page(page);
> >       ret = 0;
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index b2ce61c1b50d..0ecc50525dd4 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -197,6 +197,16 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
> >       return pmd_alloc(mm, pud, address);
> >  }
> >
> > +/* The mode of operation for __mcopy_atomic and its helpers. */
> > +enum mcopy_atomic_mode {
> > +     /* A normal copy_from_user into the destination range. */
> > +     MCOPY_ATOMIC_NORMAL,
> > +     /* Don't copy; map the destination range to the zero page. */
> > +     MCOPY_ATOMIC_ZEROPAGE,
> > +     /* Just setup the dst_vma, without modifying the underlying page(s). */
> > +     MCOPY_ATOMIC_CONTINUE,
> > +};
> > +
> >  #ifdef CONFIG_HUGETLB_PAGE
> >  /*
> >   * __mcopy_atomic processing for HUGETLB vmas.  Note that this routine is
> > @@ -207,7 +217,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                                             unsigned long dst_start,
> >                                             unsigned long src_start,
> >                                             unsigned long len,
> > -                                           bool zeropage)
> > +                                           enum mcopy_atomic_mode mode)
> >  {
> >       int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
> >       int vm_shared = dst_vma->vm_flags & VM_SHARED;
> > @@ -227,7 +237,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >        * by THP.  Since we can not reliably insert a zero page, this
> >        * feature is not supported.
> >        */
> > -     if (zeropage) {
> > +     if (mode == MCOPY_ATOMIC_ZEROPAGE) {
> >               mmap_read_unlock(dst_mm);
> >               return -EINVAL;
> >       }
> > @@ -273,8 +283,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >       }
> >
> >       while (src_addr < src_start + len) {
> > -             pte_t dst_pteval;
> > -
> >               BUG_ON(dst_addr >= dst_start + len);
> >
> >               /*
> > @@ -297,12 +305,22 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                       goto out_unlock;
> >               }
> >
> > -             err = -EEXIST;
> > -             dst_pteval = huge_ptep_get(dst_pte);
> > -             if (!huge_pte_none(dst_pteval)) {
> > -                     mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > -                     i_mmap_unlock_read(mapping);
> > -                     goto out_unlock;
> > +             if (mode == MCOPY_ATOMIC_CONTINUE) {
> > +                     /* hugetlb_mcopy_atomic_pte unlocks the page. */
> > +                     page = find_lock_page(mapping, idx);
>
> If my above understanding is right, we may also consider to move this
> find_lock_page() into hugetlb_mcopy_atomic_pte() directly, then as we pass in
> hugetlb_mcopy_atomic_pte(page==NULL, mode==MCOPY_ATOMIC_CONTINUE) we'll fetch
> the page cache instead of allocation.

Agreed, if we expose mcopy_atomic_mode anyway, this is a better place
for find_lock_page.

>
> > +                     if (!page) {
> > +                             err = -EFAULT;
> > +                             mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +                             i_mmap_unlock_read(mapping);
> > +                             goto out_unlock;
> > +                     }
> > +             } else {
> > +                     if (!huge_pte_none(huge_ptep_get(dst_pte))) {
> > +                             err = -EEXIST;
> > +                             mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +                             i_mmap_unlock_read(mapping);
> > +                             goto out_unlock;
> > +                     }
> >               }
> >
> >               err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
> > @@ -408,7 +426,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                                     unsigned long dst_start,
> >                                     unsigned long src_start,
> >                                     unsigned long len,
> > -                                   bool zeropage);
> > +                                   enum mcopy_atomic_mode mode);
> >  #endif /* CONFIG_HUGETLB_PAGE */
> >
> >  static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> > @@ -417,7 +435,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> >                                               unsigned long dst_addr,
> >                                               unsigned long src_addr,
> >                                               struct page **page,
> > -                                             bool zeropage,
> > +                                             enum mcopy_atomic_mode mode,
> >                                               bool wp_copy)
> >  {
> >       ssize_t err;
> > @@ -433,22 +451,38 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> >        * and not in the radix tree.
> >        */
> >       if (!(dst_vma->vm_flags & VM_SHARED)) {
> > -             if (!zeropage)
> > +             switch (mode) {
> > +             case MCOPY_ATOMIC_NORMAL:
> >                       err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
> >                                              dst_addr, src_addr, page,
> >                                              wp_copy);
> > -             else
> > +                     break;
> > +             case MCOPY_ATOMIC_ZEROPAGE:
> >                       err = mfill_zeropage_pte(dst_mm, dst_pmd,
> >                                                dst_vma, dst_addr);
> > +                     break;
> > +             /* It only makes sense to CONTINUE for shared memory. */
> > +             case MCOPY_ATOMIC_CONTINUE:
> > +                     err = -EINVAL;
> > +                     break;
> > +             }
> >       } else {
> >               VM_WARN_ON_ONCE(wp_copy);
> > -             if (!zeropage)
> > +             switch (mode) {
> > +             case MCOPY_ATOMIC_NORMAL:
> >                       err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
> >                                                    dst_vma, dst_addr,
> >                                                    src_addr, page);
> > -             else
> > +                     break;
> > +             case MCOPY_ATOMIC_ZEROPAGE:
> >                       err = shmem_mfill_zeropage_pte(dst_mm, dst_pmd,
> >                                                      dst_vma, dst_addr);
> > +                     break;
> > +             case MCOPY_ATOMIC_CONTINUE:
> > +                     /* FIXME: Add minor fault interception for shmem. */
> > +                     err = -EINVAL;
> > +                     break;
> > +             }
> >       }
> >
> >       return err;
> > @@ -458,7 +492,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >                                             unsigned long dst_start,
> >                                             unsigned long src_start,
> >                                             unsigned long len,
> > -                                           bool zeropage,
> > +                                           enum mcopy_atomic_mode mcopy_mode,
> >                                             bool *mmap_changing,
> >                                             __u64 mode)
> >  {
> > @@ -527,7 +561,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >        */
> >       if (is_vm_hugetlb_page(dst_vma))
> >               return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
> > -                                             src_start, len, zeropage);
> > +                                             src_start, len, mcopy_mode);
> >
> >       if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
> >               goto out_unlock;
> > @@ -577,7 +611,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >               BUG_ON(pmd_trans_huge(*dst_pmd));
> >
> >               err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> > -                                    src_addr, &page, zeropage, wp_copy);
> > +                                    src_addr, &page, mcopy_mode, wp_copy);
> >               cond_resched();
> >
> >               if (unlikely(err == -ENOENT)) {
> > @@ -626,14 +660,22 @@ ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
> >                    unsigned long src_start, unsigned long len,
> >                    bool *mmap_changing, __u64 mode)
> >  {
> > -     return __mcopy_atomic(dst_mm, dst_start, src_start, len, false,
> > -                           mmap_changing, mode);
> > +     return __mcopy_atomic(dst_mm, dst_start, src_start, len,
> > +                           MCOPY_ATOMIC_NORMAL, mmap_changing, mode);
> >  }
> >
> >  ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
> >                      unsigned long len, bool *mmap_changing)
> >  {
> > -     return __mcopy_atomic(dst_mm, start, 0, len, true, mmap_changing, 0);
> > +     return __mcopy_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_ZEROPAGE,
> > +                           mmap_changing, 0);
> > +}
> > +
> > +ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long start,
> > +                    unsigned long len, bool *mmap_changing)
> > +{
> > +     return __mcopy_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_CONTINUE,
> > +                           mmap_changing, 0);
> >  }
> >
> >  int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >
>
> --
> Peter Xu
>
