Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4A53194CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 22:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhBKU7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 15:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhBKU7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:59:53 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39F6C061786
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 12:59:12 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id w1so5187964ilm.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 12:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKb3dM9SGaTyJAtj2qUflre3QSgUDe2kQ6XxdUyP9H8=;
        b=YjyldGPfw7DrejgtmdyB7luLL8IyCBc9pIL+/73tiY+w664CP2/469x+bpt6tRFKyu
         BG3V6IhUyjW0CGmzOa6w8xy5boNYODj11+qPHMQZv7DNJrU2KnottJ/rP5H6+TVVbpTj
         lWjSWmsM28kGM5B/Uhb+SVSNNkMIG1siktF/QLdRA+hCoU+cL2r7Xlu39fD1D41yseeO
         LPRtXOxVlb+vwdDa4+Rwm6qplX+HUYuZ7hG7yYgDLUD+ybGT/FRqd00OIaZpcdRInyMj
         cFvBtaTKrxCowscAp2Zy3tQ8m35cCJSOeQT1toKkzAF0omS9Opb3VRlc7lzy0ZM+04Kx
         F4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKb3dM9SGaTyJAtj2qUflre3QSgUDe2kQ6XxdUyP9H8=;
        b=gpzp7J1cTi+NCeEMqEa8hW3RadsXg/jPmUB+eNIJfpepYooT9EqxYmXh91KmThaqv+
         QLbSbI1ZxV0o+AxO/S5PATx6odxzNGZ0TkAItMGZmL9ag0n3WKB0rz7c3efwkvJstZme
         F68NNm4pnRcJ4oG+TYw4nYMBOP2r6sbu6abTapctbpiWMk2NR3ruP+UHmXmtChlWSi7J
         jJj21pohMw0B4NgKXHnvw+Q2eWkogjgAS4QU7L2qCtNYz9+TQqxGn1qPDs0LL3+GZPpN
         PmdI/Vq8tMB70lhHPWc8PEiHHsDXpjqH1lZ0oGigKfF7YgneeMyjV3VQGyJNEz+6aWGu
         tROw==
X-Gm-Message-State: AOAM530RLcuqmlt4dHe5luoasuExdtTsmoxC+rscc7foOII8HY2AZAH8
        +l7/rdS0jbKpSPkpxmi1yZu25jNzncUfOjnoH2D+Pw==
X-Google-Smtp-Source: ABdhPJwJ2udUvA3APUPit/2ua2KMceIppva/6EMFPK+E+TGyqEvv+P4u5GrmhwA6d5/btHQglYpFxyfRxR/VVdWpNh0=
X-Received: by 2002:a05:6e02:1c8d:: with SMTP id w13mr7414790ill.301.1613077151885;
 Thu, 11 Feb 2021 12:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-6-axelrasmussen@google.com> <CAJHvVch8jmqu=Hi9=1CHzPHJfZCRvSb6g7xngSBDQ_nDfSj-gA@mail.gmail.com>
In-Reply-To: <CAJHvVch8jmqu=Hi9=1CHzPHJfZCRvSb6g7xngSBDQ_nDfSj-gA@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 11 Feb 2021 12:58:34 -0800
Message-ID: <CAJHvVchrNfRs6kbWo2b01Cr3E=1XPJySxV9PVAVW9qpiVwuMOg@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] userfaultfd: add minor fault registration mode
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
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

On Thu, Feb 11, 2021 at 11:28 AM Axel Rasmussen
<axelrasmussen@google.com> wrote:
>
> On Wed, Feb 10, 2021 at 1:22 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > This feature allows userspace to intercept "minor" faults. By "minor"
> > faults, I mean the following situation:
> >
> > Let there exist two mappings (i.e., VMAs) to the same page(s). One of
> > the mappings is registered with userfaultfd (in minor mode), and the
> > other is not. Via the non-UFFD mapping, the underlying pages have
> > already been allocated & filled with some contents. The UFFD mapping
> > has not yet been faulted in; when it is touched for the first time,
> > this results in what I'm calling a "minor" fault. As a concrete
> > example, when working with hugetlbfs, we have huge_pte_none(), but
> > find_lock_page() finds an existing page.
> >
> > This commit adds the new registration mode, and sets the relevant flag
> > on the VMAs being registered. In the hugetlb fault path, if we find
> > that we have huge_pte_none(), but find_lock_page() does indeed find an
> > existing page, then we have a "minor" fault, and if the VMA has the
> > userfaultfd registration flag, we call into userfaultfd to handle it.
> >
> > Why add a new registration mode, as opposed to adding a feature to
> > MISSING registration, like UFFD_FEATURE_SIGBUS?
> >
> > - The semantics are significantly different. UFFDIO_COPY or
> >   UFFDIO_ZEROPAGE do not make sense for these minor faults; userspace
> >   would instead just memset() or memcpy() or whatever via the non-UFFD
> >   mapping. Unlike MISSING registration, MINOR registration only makes
> >   sense for hugetlbfs (or, in the future, shmem), as this is the only
> >   way to get two VMAs to a single set of underlying pages.
> >
> > - Doing so would make handle_userfault()'s "reason" argument confusing.
> >   We'd pass in "MISSING" even if the pages weren't really missing.
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  fs/proc/task_mmu.c               |  1 +
> >  fs/userfaultfd.c                 | 71 ++++++++++++++++++--------------
> >  include/linux/mm.h               |  1 +
> >  include/linux/userfaultfd_k.h    | 15 ++++++-
> >  include/trace/events/mmflags.h   |  1 +
> >  include/uapi/linux/userfaultfd.h | 15 ++++++-
> >  mm/hugetlb.c                     | 32 ++++++++++++++
> >  7 files changed, 102 insertions(+), 34 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 602e3a52884d..94e951ea3e03 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -651,6 +651,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >                 [ilog2(VM_MTE)]         = "mt",
> >                 [ilog2(VM_MTE_ALLOWED)] = "",
> >  #endif
> > +               [ilog2(VM_UFFD_MINOR)]  = "ui",
> >  #ifdef CONFIG_ARCH_HAS_PKEYS
> >                 /* These come out via ProtectionKey: */
> >                 [ilog2(VM_PKEY_BIT0)]   = "",
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 1f4a34b1a1e7..b351a8552140 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -197,24 +197,21 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
> >         msg_init(&msg);
> >         msg.event = UFFD_EVENT_PAGEFAULT;
> >         msg.arg.pagefault.address = address;
> > +       /*
> > +        * These flags indicate why the userfault occurred:
> > +        * - UFFD_PAGEFAULT_FLAG_WP indicates a write protect fault.
> > +        * - UFFD_PAGEFAULT_FLAG_MINOR indicates a minor fault.
> > +        * - Neither of these flags being set indicates a MISSING fault.
> > +        *
> > +        * Separately, UFFD_PAGEFAULT_FLAG_WRITE indicates it was a write
> > +        * fault. Otherwise, it was a read fault.
> > +        */
> >         if (flags & FAULT_FLAG_WRITE)
> > -               /*
> > -                * If UFFD_FEATURE_PAGEFAULT_FLAG_WP was set in the
> > -                * uffdio_api.features and UFFD_PAGEFAULT_FLAG_WRITE
> > -                * was not set in a UFFD_EVENT_PAGEFAULT, it means it
> > -                * was a read fault, otherwise if set it means it's
> > -                * a write fault.
> > -                */
> >                 msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WRITE;
> >         if (reason & VM_UFFD_WP)
> > -               /*
> > -                * If UFFD_FEATURE_PAGEFAULT_FLAG_WP was set in the
> > -                * uffdio_api.features and UFFD_PAGEFAULT_FLAG_WP was
> > -                * not set in a UFFD_EVENT_PAGEFAULT, it means it was
> > -                * a missing fault, otherwise if set it means it's a
> > -                * write protect fault.
> > -                */
> >                 msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WP;
> > +       if (reason & VM_UFFD_MINOR)
> > +               msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_MINOR;
> >         if (features & UFFD_FEATURE_THREAD_ID)
> >                 msg.arg.pagefault.feat.ptid = task_pid_vnr(current);
> >         return msg;
> > @@ -401,8 +398,10 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> >
> >         BUG_ON(ctx->mm != mm);
> >
> > -       VM_BUG_ON(reason & ~(VM_UFFD_MISSING|VM_UFFD_WP));
> > -       VM_BUG_ON(!(reason & VM_UFFD_MISSING) ^ !!(reason & VM_UFFD_WP));
> > +       /* Any unrecognized flag is a bug. */
> > +       VM_BUG_ON(reason & ~__VM_UFFD_FLAGS);
> > +       /* 0 or > 1 flags set is a bug; we expect exactly 1. */
> > +       VM_BUG_ON(!reason || !!(reason & (reason - 1)));
> >
> >         if (ctx->features & UFFD_FEATURE_SIGBUS)
> >                 goto out;
> > @@ -612,7 +611,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
> >                 for (vma = mm->mmap; vma; vma = vma->vm_next)
> >                         if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
> >                                 vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> > -                               vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
> > +                               vma->vm_flags &= ~__VM_UFFD_FLAGS;
> >                         }
> >                 mmap_write_unlock(mm);
> >
> > @@ -644,7 +643,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
> >         octx = vma->vm_userfaultfd_ctx.ctx;
> >         if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
> >                 vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> > -               vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
> > +               vma->vm_flags &= ~__VM_UFFD_FLAGS;
> >                 return 0;
> >         }
> >
> > @@ -726,7 +725,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
> >         } else {
> >                 /* Drop uffd context if remap feature not enabled */
> >                 vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> > -               vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
> > +               vma->vm_flags &= ~__VM_UFFD_FLAGS;
> >         }
> >  }
> >
> > @@ -867,12 +866,12 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
> >         for (vma = mm->mmap; vma; vma = vma->vm_next) {
> >                 cond_resched();
> >                 BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
> > -                      !!(vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP)));
> > +                      !!(vma->vm_flags & __VM_UFFD_FLAGS));
> >                 if (vma->vm_userfaultfd_ctx.ctx != ctx) {
> >                         prev = vma;
> >                         continue;
> >                 }
> > -               new_flags = vma->vm_flags & ~(VM_UFFD_MISSING | VM_UFFD_WP);
> > +               new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> >                 prev = vma_merge(mm, prev, vma->vm_start, vma->vm_end,
> >                                  new_flags, vma->anon_vma,
> >                                  vma->vm_file, vma->vm_pgoff,
> > @@ -1306,9 +1305,19 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
> >                                      unsigned long vm_flags)
> >  {
> >         /* FIXME: add WP support to hugetlbfs and shmem */
> > -       return vma_is_anonymous(vma) ||
> > -               ((is_vm_hugetlb_page(vma) || vma_is_shmem(vma)) &&
> > -                !(vm_flags & VM_UFFD_WP));
> > +       if (vm_flags & VM_UFFD_WP) {
> > +               if (is_vm_hugetlb_page(vma) || vma_is_shmem(vma))
> > +                       return false;
> > +       }
> > +
> > +       if (vm_flags & VM_UFFD_MINOR) {
> > +               /* FIXME: Add minor fault interception for shmem. */
> > +               if (!is_vm_hugetlb_page(vma))
> > +                       return false;
> > +       }
> > +
> > +       return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
> > +              vma_is_shmem(vma);
> >  }
> >
> >  static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > @@ -1334,14 +1343,15 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >         ret = -EINVAL;
> >         if (!uffdio_register.mode)
> >                 goto out;
> > -       if (uffdio_register.mode & ~(UFFDIO_REGISTER_MODE_MISSING|
> > -                                    UFFDIO_REGISTER_MODE_WP))
> > +       if (uffdio_register.mode & ~UFFD_API_REGISTER_MODES)
> >                 goto out;
> >         vm_flags = 0;
> >         if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MISSING)
> >                 vm_flags |= VM_UFFD_MISSING;
> >         if (uffdio_register.mode & UFFDIO_REGISTER_MODE_WP)
> >                 vm_flags |= VM_UFFD_WP;
> > +       if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR)
> > +               vm_flags |= VM_UFFD_MINOR;
> >
> >         ret = validate_range(mm, &uffdio_register.range.start,
> >                              uffdio_register.range.len);
> > @@ -1385,7 +1395,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >                 cond_resched();
> >
> >                 BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
> > -                      !!(cur->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP)));
> > +                      !!(cur->vm_flags & __VM_UFFD_FLAGS));
> >
> >                 /* check not compatible vmas */
> >                 ret = -EINVAL;
> > @@ -1465,8 +1475,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >                         start = vma->vm_start;
> >                 vma_end = min(end, vma->vm_end);
> >
> > -               new_flags = (vma->vm_flags &
> > -                            ~(VM_UFFD_MISSING|VM_UFFD_WP)) | vm_flags;
> > +               new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> >                 prev = vma_merge(mm, prev, start, vma_end, new_flags,
> >                                  vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> >                                  vma_policy(vma),
> > @@ -1588,7 +1597,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >                 cond_resched();
> >
> >                 BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
> > -                      !!(cur->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP)));
> > +                      !!(cur->vm_flags & __VM_UFFD_FLAGS));
> >
> >                 /*
> >                  * Check not compatible vmas, not strictly required
> > @@ -1639,7 +1648,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >                         wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
> >                 }
> >
> > -               new_flags = vma->vm_flags & ~(VM_UFFD_MISSING | VM_UFFD_WP);
> > +               new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> >                 prev = vma_merge(mm, prev, start, vma_end, new_flags,
> >                                  vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> >                                  vma_policy(vma),
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 89fca443e6f1..3f65a506c743 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -276,6 +276,7 @@ extern unsigned int kobjsize(const void *objp);
> >  #define VM_PFNMAP      0x00000400      /* Page-ranges managed without "struct page", just pure PFN */
> >  #define VM_DENYWRITE   0x00000800      /* ETXTBSY on write attempts.. */
> >  #define VM_UFFD_WP     0x00001000      /* wrprotect pages tracking */
> > +#define VM_UFFD_MINOR  0x00002000      /* minor fault interception */
>
> Ah, I had added this just after VM_UFFD_WP, without noticing that this
> would be sharing a bit with VM_LOCKED. That seems like not such a
> great idea.
>
> I don't see another unused bit, and I don't see some other obvious
> candidate to share with. So, the solution that comes to mind is
> something like:
>
> - Since it isn't feasible to have one VM_ flag per UFFD trigger type,
> handle_userfault()'s "reason" argument should be some enumeration of
> possible UFFD reasons instead.
> - Introduce a path where handle_userfault() can return 0, meaning "you
> called into me, but I am not meant to be handling this fault per the
> userfaultfd_ctx, handle it normally instead".

Ah, yeah this doesn't work either. The context is per-fd, not
per-registration. We don't write down the requested registration mode
anywhere other than the VM flags. So then, in lieu of some larger
redesign I think minor fault handling has to be a per-fd option, not a
per-registration option -- basically, it has to be a UFFD_FEATURE_*
flag instead of a separate mode.

> - Use VM_UFFD_MISSING to decide whether or not to call
> handle_userfault(), whether it was a missing or minor fault.
>
> Unless there are objections or some simpler idea, I'll send a v6 with
> this change.
>
> >
> >  #define VM_LOCKED      0x00002000
> >  #define VM_IO           0x00004000     /* Memory mapped I/O or similar */
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index c63ccdae3eab..0390e5ac63b3 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -17,6 +17,9 @@
> >  #include <linux/mm.h>
> >  #include <asm-generic/pgtable_uffd.h>
> >
> > +/* The set of all possible UFFD-related VM flags. */
> > +#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
> > +
> >  /*
> >   * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
> >   * new flags, since they might collide with O_* ones. We want
> > @@ -71,6 +74,11 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
> >         return vma->vm_flags & VM_UFFD_WP;
> >  }
> >
> > +static inline bool userfaultfd_minor(struct vm_area_struct *vma)
> > +{
> > +       return vma->vm_flags & VM_UFFD_MINOR;
> > +}
> > +
> >  static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
> >                                       pte_t pte)
> >  {
> > @@ -85,7 +93,7 @@ static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
> >
> >  static inline bool userfaultfd_armed(struct vm_area_struct *vma)
> >  {
> > -       return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP);
> > +       return vma->vm_flags & __VM_UFFD_FLAGS;
> >  }
> >
> >  extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
> > @@ -132,6 +140,11 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
> >         return false;
> >  }
> >
> > +static inline bool userfaultfd_minor(struct vm_area_struct *vma)
> > +{
> > +       return false;
> > +}
> > +
> >  static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
> >                                       pte_t pte)
> >  {
> > diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> > index 67018d367b9f..2d583ffd4100 100644
> > --- a/include/trace/events/mmflags.h
> > +++ b/include/trace/events/mmflags.h
> > @@ -151,6 +151,7 @@ IF_HAVE_PG_ARCH_2(PG_arch_2,                "arch_2"        )
> >         {VM_PFNMAP,                     "pfnmap"        },              \
> >         {VM_DENYWRITE,                  "denywrite"     },              \
> >         {VM_UFFD_WP,                    "uffd_wp"       },              \
> > +       {VM_UFFD_MINOR,                 "uffd_minor"    },              \
> >         {VM_LOCKED,                     "locked"        },              \
> >         {VM_IO,                         "io"            },              \
> >         {VM_SEQ_READ,                   "seqread"       },              \
> > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> > index 5f2d88212f7c..f24dd4fcbad9 100644
> > --- a/include/uapi/linux/userfaultfd.h
> > +++ b/include/uapi/linux/userfaultfd.h
> > @@ -19,15 +19,19 @@
> >   * means the userland is reading).
> >   */
> >  #define UFFD_API ((__u64)0xAA)
> > +#define UFFD_API_REGISTER_MODES (UFFDIO_REGISTER_MODE_MISSING |        \
> > +                                UFFDIO_REGISTER_MODE_WP |      \
> > +                                UFFDIO_REGISTER_MODE_MINOR)
> >  #define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |    \
> >                            UFFD_FEATURE_EVENT_FORK |            \
> >                            UFFD_FEATURE_EVENT_REMAP |           \
> > -                          UFFD_FEATURE_EVENT_REMOVE |  \
> > +                          UFFD_FEATURE_EVENT_REMOVE |          \
> >                            UFFD_FEATURE_EVENT_UNMAP |           \
> >                            UFFD_FEATURE_MISSING_HUGETLBFS |     \
> >                            UFFD_FEATURE_MISSING_SHMEM |         \
> >                            UFFD_FEATURE_SIGBUS |                \
> > -                          UFFD_FEATURE_THREAD_ID)
> > +                          UFFD_FEATURE_THREAD_ID |             \
> > +                          UFFD_FEATURE_MINOR_HUGETLBFS)
> >  #define UFFD_API_IOCTLS                                \
> >         ((__u64)1 << _UFFDIO_REGISTER |         \
> >          (__u64)1 << _UFFDIO_UNREGISTER |       \
> > @@ -127,6 +131,7 @@ struct uffd_msg {
> >  /* flags for UFFD_EVENT_PAGEFAULT */
> >  #define UFFD_PAGEFAULT_FLAG_WRITE      (1<<0)  /* If this was a write fault */
> >  #define UFFD_PAGEFAULT_FLAG_WP         (1<<1)  /* If reason is VM_UFFD_WP */
> > +#define UFFD_PAGEFAULT_FLAG_MINOR      (1<<2)  /* If reason is VM_UFFD_MINOR */
> >
> >  struct uffdio_api {
> >         /* userland asks for an API number and the features to enable */
> > @@ -171,6 +176,10 @@ struct uffdio_api {
> >          *
> >          * UFFD_FEATURE_THREAD_ID pid of the page faulted task_struct will
> >          * be returned, if feature is not requested 0 will be returned.
> > +        *
> > +        * UFFD_FEATURE_MINOR_HUGETLBFS indicates that minor faults
> > +        * can be intercepted (via REGISTER_MODE_MINOR) for
> > +        * hugetlbfs-backed pages.
> >          */
> >  #define UFFD_FEATURE_PAGEFAULT_FLAG_WP         (1<<0)
> >  #define UFFD_FEATURE_EVENT_FORK                        (1<<1)
> > @@ -181,6 +190,7 @@ struct uffdio_api {
> >  #define UFFD_FEATURE_EVENT_UNMAP               (1<<6)
> >  #define UFFD_FEATURE_SIGBUS                    (1<<7)
> >  #define UFFD_FEATURE_THREAD_ID                 (1<<8)
> > +#define UFFD_FEATURE_MINOR_HUGETLBFS           (1<<9)
> >         __u64 features;
> >
> >         __u64 ioctls;
> > @@ -195,6 +205,7 @@ struct uffdio_register {
> >         struct uffdio_range range;
> >  #define UFFDIO_REGISTER_MODE_MISSING   ((__u64)1<<0)
> >  #define UFFDIO_REGISTER_MODE_WP                ((__u64)1<<1)
> > +#define UFFDIO_REGISTER_MODE_MINOR     ((__u64)1<<2)
> >         __u64 mode;
> >
> >         /*
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index e41b77cf6cc2..f150b10981a8 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4366,6 +4366,38 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >                                 VM_FAULT_SET_HINDEX(hstate_index(h));
> >                         goto backout_unlocked;
> >                 }
> > +
> > +               /* Check for page in userfault range. */
> > +               if (userfaultfd_minor(vma)) {
> > +                       u32 hash;
> > +                       struct vm_fault vmf = {
> > +                               .vma = vma,
> > +                               .address = haddr,
> > +                               .flags = flags,
> > +                               /*
> > +                                * Hard to debug if it ends up being used by a
> > +                                * callee that assumes something about the
> > +                                * other uninitialized fields... same as in
> > +                                * memory.c
> > +                                */
> > +                       };
> > +
> > +                       unlock_page(page);
> > +
> > +                       /*
> > +                        * hugetlb_fault_mutex and i_mmap_rwsem must be dropped
> > +                        * before handling userfault.  Reacquire after handling
> > +                        * fault to make calling code simpler.
> > +                        */
> > +
> > +                       hash = hugetlb_fault_mutex_hash(mapping, idx);
> > +                       mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +                       i_mmap_unlock_read(mapping);
> > +                       ret = handle_userfault(&vmf, VM_UFFD_MINOR);
> > +                       i_mmap_lock_read(mapping);
> > +                       mutex_lock(&hugetlb_fault_mutex_table[hash]);
> > +                       goto out;
> > +               }
> >         }
> >
> >         /*
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >
