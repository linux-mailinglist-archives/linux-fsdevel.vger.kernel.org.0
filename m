Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5339E30B2A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 23:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBAWNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 17:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhBAWNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:13:12 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8199FC06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Feb 2021 14:12:32 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id 16so19191430ioz.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 14:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WJoG60ceKTntaeB3RRnHJeVlEFtZwmWSC8LANiTw3Y=;
        b=PlDxAZzeq5kG3hS8Hcmc2CFLYpPCxSVc6Offv+qN4cdUjQ1Pyv3eJ501vrS93E48en
         hajpLNEm80yaVTKnIOe6yGnPWNJFD5Bkvbdk6NTaUi2PmEj7l8ZkiWMB9kRnk0OpvrIL
         uyZI2Y+46C+/W6HaydVBRHB2Q6i7EAo79dpNr0ipdha7cR4JEeFF6sXsiS02527YO4NG
         f+ZmO+IXUzRnih8uU19BN5LsojDZegLsew9zdB5l9PrTY4h3VZ0MN/lnLPqo41AquTWP
         7b1BFjcCAVaFh1oyfWl4KTQSgv6xFWEEMHGniF7oa404hHJhE5zHIxPz2zu5AgvSAFR8
         ccIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WJoG60ceKTntaeB3RRnHJeVlEFtZwmWSC8LANiTw3Y=;
        b=CWhRiCKbJdrrIe5nRgNRk7UmS4YRlQyAyj0Yqk0xKHTiFbqLOMeDi8NQeFg4eomQ30
         UxtcUi0MKzj08Kw9Q0yZ0D6G9DDnnghFOgFM/XWgZo4FnfsrtTUIC0LeJq8KF7c2ZL9n
         7DVxe5nfTv6tmKc2c1vyKXxmMXKttepvmRTqtyBO+Cpt/TE/YWDiGtP0hZk6kLZxxjbf
         tGq3D9zQDzv+tXw//eOZNmodZkflGTbq036hKbebMO3VRSwlBlsn2Ihq06Mmnel6fTWN
         invNKhbj4jg/kRYDIJ86vtq+U8+R3uNN+tvbOoHDUHamxYFGRxBGRH5+k4aXAkodrxQF
         naFQ==
X-Gm-Message-State: AOAM533yP/bnl2ovOSHHUnp27++WIy+1ulvJ8rl3Ruh8uf7BWBYR0Tpr
        mPp/f3wsCriBE3/4tOH068sLkHgiOqKP5j09DfKACQ==
X-Google-Smtp-Source: ABdhPJwPHLD4WbPAI5s4dJVj3b8xUybLTSiEtpQq3lluEC22rU7uaLERqtTz3Hcc+W3NQb5b0sv7VBcwwtvUOa7FvBk=
X-Received: by 2002:a02:3844:: with SMTP id v4mr16268861jae.1.1612217551689;
 Mon, 01 Feb 2021 14:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20210128224819.2651899-1-axelrasmussen@google.com>
 <20210128224819.2651899-8-axelrasmussen@google.com> <20210201192120.GG260413@xz-x1>
In-Reply-To: <20210201192120.GG260413@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 1 Feb 2021 14:11:55 -0800
Message-ID: <CAJHvVciv0-Xq75TKB=g=Sb+HmwMdJEd+CHg885TWX2svYCwFiQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] userfaultfd: add UFFDIO_CONTINUE ioctl
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

On Mon, Feb 1, 2021 at 11:21 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 28, 2021 at 02:48:17PM -0800, Axel Rasmussen wrote:
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index f94a35296618..79e1f0155afa 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -135,11 +135,14 @@ void hugetlb_show_meminfo(void);
> >  unsigned long hugetlb_total_pages(void);
> >  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >                       unsigned long address, unsigned int flags);
> > +#ifdef CONFIG_USERFAULTFD
>
> I'm confused why this is needed.. hugetlb_mcopy_atomic_pte() should only be
> called in userfaultfd.c, but if without uffd config set it won't compile
> either:
>
>         obj-$(CONFIG_USERFAULTFD) += userfaultfd.o

With this series as-is, but *without* the #ifdef CONFIG_USERFAULTFD
here, we introduce a bunch of build warnings like this:



In file included from ./include/linux/migrate.h:8:0,
                 from kernel/sched/sched.h:53,
                 from kernel/sched/isolation.c:10:
./include/linux/hugetlb.h:143:12: warning: 'enum mcopy_atomic_mode'
declared inside parameter list
     struct page **pagep);
            ^
./include/linux/hugetlb.h:143:12: warning: its scope is only this
definition or declaration, which is probably not what you want

And similarly we get an error about the "mode" parameter having an
incomplete type in hugetlb.c.



This is because enum mcopy_atomic_mode is defined in userfaultfd_k.h,
and that entire header is wrapped in a #ifdef CONFIG_USERFAULTFD. So
we either need to define enum mcopy_atomic_mode unconditionally, or we
need to #ifdef CONFIG_USERFAULTFD the references to it also.

- I opted not to move it outside the #ifdef CONFIG_USERFAULTFD in
userfaultfd_k.h (defining it unconditionally), because that seemed
messy to me.
- I opted not to define it unconditionally in hugetlb.h, because we'd
have to move it to userfaultfd_k.h anyway when shmem or other users
are introduced. I'm planning to send a series to add this a few days
or so after this series is merged, so it seems churn-y to move it
then.
- It seemed optimal to not compile hugetlb_mcopy_atomic_pte anyway
(even ignoring adding the continue ioctl), since as you point out
userfaultfd is the only caller.

Hopefully this clarifies this and the next two comments. Let me know
if you still feel strongly, I don't hate any of the alternatives, just
wanted to clarify that I had considered them and thought this approach
was best.

>
> >  int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
> >                               struct vm_area_struct *dst_vma,
> >                               unsigned long dst_addr,
> >                               unsigned long src_addr,
> > +                             enum mcopy_atomic_mode mode,
> >                               struct page **pagep);
> > +#endif
> >  int hugetlb_reserve_pages(struct inode *inode, long from, long to,
> >                                               struct vm_area_struct *vma,
> >                                               vm_flags_t vm_flags);
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index fb9abaeb4194..2fcb686211e8 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -37,6 +37,22 @@ extern int sysctl_unprivileged_userfaultfd;
> >
> >  extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
> >
> > +/*
> > + * The mode of operation for __mcopy_atomic and its helpers.
> > + *
> > + * This is almost an implementation detail (mcopy_atomic below doesn't take this
> > + * as a parameter), but it's exposed here because memory-kind-specific
> > + * implementations (e.g. hugetlbfs) need to know the mode of operation.
> > + */
> > +enum mcopy_atomic_mode {
> > +     /* A normal copy_from_user into the destination range. */
> > +     MCOPY_ATOMIC_NORMAL,
> > +     /* Don't copy; map the destination range to the zero page. */
> > +     MCOPY_ATOMIC_ZEROPAGE,
> > +     /* Just setup the dst_vma, without modifying the underlying page(s). */
> > +     MCOPY_ATOMIC_CONTINUE,
> > +};
> > +
>
> Maybe better to keep this to where it's used, e.g. hugetlb.h where we've
> defined hugetlb_mcopy_atomic_pte()?
>
> [...]
>
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 6f9d8349f818..3d318ef3d180 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4647,6 +4647,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >       return ret;
> >  }
> >
> > +#ifdef CONFIG_USERFAULTFD
>
> So I feel like you added the header ifdef for this.
>
> IMHO we can drop both since that's what we have had.  I agree maybe it's better
> to not compile that without CONFIG_USERFAULTFD but that may worth a standalone
> patch anyways.
>
> >  /*
> >   * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
> >   * modifications for huge pages.
> > @@ -4656,6 +4657,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >                           struct vm_area_struct *dst_vma,
> >                           unsigned long dst_addr,
> >                           unsigned long src_addr,
> > +                         enum mcopy_atomic_mode mode,
> >                           struct page **pagep)
> >  {
> >       struct address_space *mapping;
> > @@ -4668,7 +4670,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >       int ret;
> >       struct page *page;
> >
> > -     if (!*pagep) {
> > +     mapping = dst_vma->vm_file->f_mapping;
> > +     idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> > +
> > +     if (!*pagep && mode != MCOPY_ATOMIC_CONTINUE) {
> >               ret = -ENOMEM;
> >               page = alloc_huge_page(dst_vma, dst_addr, 0);
> >               if (IS_ERR(page))
> > @@ -4685,6 +4690,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >                       /* don't free the page */
> >                       goto out;
> >               }
> > +     } else if (mode == MCOPY_ATOMIC_CONTINUE) {
> > +             ret = -EFAULT;
> > +             page = find_lock_page(mapping, idx);
> > +             *pagep = NULL;
> > +             if (!page)
> > +                     goto out;
> >       } else {
> >               page = *pagep;
> >               *pagep = NULL;
>
> I would write this as:
>
>     if (mode == MCOPY_ATOMIC_CONTINUE)
>         ...
>     else if (!*pagep)
>         ...
>     else
>         ...
>
> No strong opinion, but that'll look slightly cleaner to me.

Agreed, I like that better as well. :)

>
> [...]
>
> > @@ -408,7 +407,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                                     unsigned long dst_start,
> >                                     unsigned long src_start,
> >                                     unsigned long len,
> > -                                   bool zeropage);
> > +                                   enum mcopy_atomic_mode mode);
> >  #endif /* CONFIG_HUGETLB_PAGE */
> >
> >  static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> > @@ -417,7 +416,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> >                                               unsigned long dst_addr,
> >                                               unsigned long src_addr,
> >                                               struct page **page,
> > -                                             bool zeropage,
> > +                                             enum mcopy_atomic_mode mode,
> >                                               bool wp_copy)
> >  {
> >       ssize_t err;
> > @@ -433,22 +432,38 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
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
>
> The whole chunk above is not needed for hugetlbfs it seems - I'd avoid touching
> the anon/shmem code path until it's being supported.
>
> What you need is probably set zeropage as below in __mcopy_atomic():
>
>     zeropage = (mode == MCOPY_ATOMIC_ZEROPAGE);
>
> Before passing it over to mfill_atomic_pte().  As long as we reject
> UFFDIO_CONTINUE with !hugetlbfs correctly that'll be enough iiuc.

Seems reasonable to me, I'll make this change in v4.

>
> Thanks,
>
> --
> Peter Xu
>
