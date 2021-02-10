Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3A5316DD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 19:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhBJSFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 13:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbhBJSBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:01:48 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE24C06178C
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 10:00:58 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z21so1474805iob.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 10:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o49AbbaqNtmBNLl+e+wTukbuIeuXAQ703tVisLKMY9c=;
        b=VnBvbp2kKLGhA2qV6eCfPPdlSh0iITgW/Ydl0Kov5nh6W1YxOmH+Ik/0n9wAqnrnLh
         LX0jtFzkMrTa3yi3gbWkvJk33UG+i07lV5sfsGdwYPKoGKfeg60nkwwSvdBANDftw6+T
         OevAAzoj++555XcWpQBgfTaxVoqlRmevJnnDfpRCfWwW2q/wPA+848sPmJeejxfmqWWr
         bgNLqtxSh7yCPEG7xQPxKBjdp7EpjOjoT7losdxwYbVb0rm1ytkUo72a+gzsnmUfTVPl
         siAAUbZh2GPRkb2UJ85C31an6GT3FqzTQX55e0tXmLhbDZMFU7NhOJqbJAojJMKVWOlS
         jDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o49AbbaqNtmBNLl+e+wTukbuIeuXAQ703tVisLKMY9c=;
        b=m9qPPY7cSvY2B05L1NLLlu6f2LdRK1Yf0gSmCp9m93x1r8aPJni2N4gig8e4+uhzSw
         QzE4g/0OvQmn/Jphekj1wzEFOkD347GHg2R0reHKaOJKGf+iQ/IcuSYch6G7y3KWfk+Z
         0tQrL8Ujt7LwW6YxRHSwljmFHt3IQFfuiCLPnZXuA0ya5jkMK6uRaOwVmHDCBXeudvE0
         sOu81b+OCoGa5b14rpMADPpPFZznHR80Nd3W4QNzUrr9ADFS2q07agwy3n6dr6TZrF8F
         yyF2/jjmJqivZMarb9EYKhiwi9JPNCB7lr+HlbuIaUChYMAKJNGNWhB9hnfVuuOjE1Le
         YaCA==
X-Gm-Message-State: AOAM533lGbftY1tkX06gjuye4em6MeE3+w0GCPWCLrjVau8JgJuARITx
        NvSHju4+Rq1Cus+jCrnNOIzw3rWJaYl0Fs7TUvE6lQ==
X-Google-Smtp-Source: ABdhPJz14jAl0ZNEsgW94gY4Oc38D/91s0rn8mt639JdpQP4MMeQ3rmxqg/qx1Smz8psQGuJotvWDsnmDxhOsAhhLRA=
X-Received: by 2002:a5e:8807:: with SMTP id l7mr1921757ioj.23.1612980057418;
 Wed, 10 Feb 2021 10:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20210204183433.1431202-1-axelrasmussen@google.com>
 <20210204183433.1431202-9-axelrasmussen@google.com> <20210208235411.GC71523@xz-x1>
In-Reply-To: <20210208235411.GC71523@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 10 Feb 2021 10:00:21 -0800
Message-ID: <CAJHvVcgC1zXoVde2Uva9zm3TjzA7g-qOMPm7wxX0dXxxwTLs6A@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] userfaultfd: add UFFDIO_CONTINUE ioctl
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
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 8, 2021 at 3:54 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Feb 04, 2021 at 10:34:31AM -0800, Axel Rasmussen wrote:
> > +enum mcopy_atomic_mode {
> > +     /* A normal copy_from_user into the destination range. */
> > +     MCOPY_ATOMIC_NORMAL,
> > +     /* Don't copy; map the destination range to the zero page. */
> > +     MCOPY_ATOMIC_ZEROPAGE,
> > +     /* Just setup the dst_vma, without modifying the underlying page(s). */
>
> "setup the dst_vma" sounds odd.  How about "install pte with the existing page
> in the page cache"?
>
> > +     MCOPY_ATOMIC_CONTINUE,
> > +};
>
> [...]
>
> > @@ -4749,22 +4754,27 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >               hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
> >       }
> >
> > -     _dst_pte = make_huge_pte(dst_vma, page, dst_vma->vm_flags & VM_WRITE);
> > -     if (dst_vma->vm_flags & VM_WRITE)
> > +     dst_pte_flags = dst_vma->vm_flags & VM_WRITE;
> > +     /* For CONTINUE on a non-shared VMA, don't set VM_WRITE for CoW. */
> > +     if (mode == MCOPY_ATOMIC_CONTINUE && !vm_shared)
> > +             dst_pte_flags &= ~VM_WRITE;
>
> I agree it should work but it's odd to explicitly remove a VM_WRITE bit, since
> imho what we want to do is not changing vma or vma flags but deciding whether
> to keep the write bit in the ptes.  How about as simple as:
>
>         bool writable;
>
>         if (mode == MCOPY_ATOMIC_CONTINUE && !vm_shared)
>             writable = false;
>         else
>             writable = dst_vma->vm_flags & VM_WRITE;
>
>         _dst_pte = make_huge_pte(dst_vma, page, writable);
>         if (writable)
>                 _dst_pte = huge_pte_mkdirty(_dst_pte);
>
> ?
>
> > +     _dst_pte = make_huge_pte(dst_vma, page, dst_pte_flags);
> > +     if (dst_pte_flags & VM_WRITE)
> >               _dst_pte = huge_pte_mkdirty(_dst_pte);
> >       _dst_pte = pte_mkyoung(_dst_pte);
> >
> >       set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> >
> >       (void)huge_ptep_set_access_flags(dst_vma, dst_addr, dst_pte, _dst_pte,
> > -                                     dst_vma->vm_flags & VM_WRITE);
> > +                                      dst_pte_flags);
> >       hugetlb_count_add(pages_per_huge_page(h), dst_mm);
> >
> >       /* No need to invalidate - it was non-present before */
> >       update_mmu_cache(dst_vma, dst_addr, dst_pte);
> >
> >       spin_unlock(ptl);
> > -     set_page_huge_active(page);
> > +     if (mode != MCOPY_ATOMIC_CONTINUE)
> > +             set_page_huge_active(page);
>
> This has been changed to SetHPageMigratable(page) in akpm-next by Mike's new
> series.  So maybe it's time to rebase your series to that starting from the
> next post.
>
> >       if (vm_shared)
> >               unlock_page(page);
>
> After removing the shared restriction, I think we need:
>
>         if (vm_shared || (mode == MCOPY_ATOMIC_CONTINUE))
>                 unlock_page(page);
>
> Since we seem to check (mode == MCOPY_ATOMIC_CONTINUE) a lot, maybe we can
> introduce a temp var for that too.
>
> >       ret = 0;
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index b2ce61c1b50d..7bf83ffa456b 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -207,7 +207,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                                             unsigned long dst_start,
> >                                             unsigned long src_start,
> >                                             unsigned long len,
> > -                                           bool zeropage)
> > +                                           enum mcopy_atomic_mode mode)
> >  {
> >       int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
> >       int vm_shared = dst_vma->vm_flags & VM_SHARED;
> > @@ -227,7 +227,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >        * by THP.  Since we can not reliably insert a zero page, this
> >        * feature is not supported.
> >        */
> > -     if (zeropage) {
> > +     if (mode == MCOPY_ATOMIC_ZEROPAGE) {
> >               mmap_read_unlock(dst_mm);
> >               return -EINVAL;
> >       }
> > @@ -273,8 +273,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >       }
> >
> >       while (src_addr < src_start + len) {
> > -             pte_t dst_pteval;
> > -
> >               BUG_ON(dst_addr >= dst_start + len);
> >
> >               /*
> > @@ -297,16 +295,17 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                       goto out_unlock;
> >               }
> >
> > -             err = -EEXIST;
> > -             dst_pteval = huge_ptep_get(dst_pte);
> > -             if (!huge_pte_none(dst_pteval)) {
> > -                     mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > -                     i_mmap_unlock_read(mapping);
> > -                     goto out_unlock;
> > +             if (mode != MCOPY_ATOMIC_CONTINUE) {
> > +                     if (!huge_pte_none(huge_ptep_get(dst_pte))) {
>
> Maybe merge the two "if"s?
>
> > +                             err = -EEXIST;
> > +                             mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +                             i_mmap_unlock_read(mapping);
> > +                             goto out_unlock;
> > +                     }
> >               }
> >
> >               err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
> > -                                             dst_addr, src_addr, &page);
> > +                                            dst_addr, src_addr, mode, &page);
> >
> >               mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> >               i_mmap_unlock_read(mapping);
> > @@ -408,7 +407,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                                     unsigned long dst_start,
> >                                     unsigned long src_start,
> >                                     unsigned long len,
> > -                                   bool zeropage);
> > +                                   enum mcopy_atomic_mode mode);
> >  #endif /* CONFIG_HUGETLB_PAGE */
> >
> >  static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> > @@ -417,10 +416,14 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> >                                               unsigned long dst_addr,
> >                                               unsigned long src_addr,
> >                                               struct page **page,
> > -                                             bool zeropage,
> > +                                             enum mcopy_atomic_mode mode,
> >                                               bool wp_copy)
> >  {
> >       ssize_t err;
> > +     bool zeropage = (mode == MCOPY_ATOMIC_ZEROPAGE);
> > +
> > +     if (mode == MCOPY_ATOMIC_CONTINUE)
> > +             return -EINVAL;
>
> So you still passed in the mode into mfill_atomic_pte() just to make sure
> CONTINUE is not called there.  It's okay, but again I think it's not extremely
> necessary: we should make sure to fail early at the entry of uffdio_continue()
> by checking against the vma type to be hugetlb, rather than reaching here.

Hmm, it's not quite as simple as that. We don't have the dst_vma yet
in uffdio_continue(), __mcopy_atomic looks it up.

I'd prefer not to look it up in uffdio_continue(), because I think
that means changing the API so all the ioctls look up the vma, and
then plumb it into __mcopy_atomic. (We don't want to look it up twice,
since each lookup has to traverse the rbtree.) This is complicated too
by the fact that the ioctl handlers would need to perform various
validation / checks - e.g., acquiring mmap_lock, dealing with
*mmap_changing, validating the range, ....

We can move the enforcement up one more layer, into __mcopy_atomic,
easily enough, though.



The other comments above I agree with, so I'll send a v5. :)

>
> Thanks,
>
> --
> Peter Xu
>
