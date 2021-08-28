Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582983FA2A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 02:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhH1A7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 20:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhH1A7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 20:59:48 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3161C0613D9
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 17:58:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id v19so2252131ybv.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 17:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j766wmeIUROd83oO6m7AIU2PDzlQyY/Fee/X27JUyiM=;
        b=AVu0ai1WZqJz4CZ4+Y/E1JdjJHR1v5sZBn9OND3+xYm/iRLshjkUConMoR9vkEO7gj
         VbJsTZYOjpjffGoi/BTtPSf+lf4fXtUFK8v5Wg65BxCOWvwM3MmDWZuTLRjJBG7S5tCE
         NPRL8o8pfOK6ovjRyk8/KEm8FmWqCdXOL8O4pkYyqp90gs5vM0lQHBXYb6O8Z2gzmjuG
         TgWS6NLuE/ALP+l+dyfdxVWy2oeRqXizb2pmN20s6e5LInI1hzajoKQFkv9ZoqIcG7QA
         mKQKEFXxctnYU7rxzJ4T5jRQH3x/EvZDFZh5EkNHAxNdk3BlELS/h0cmpsnIvDYuK/9N
         nbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j766wmeIUROd83oO6m7AIU2PDzlQyY/Fee/X27JUyiM=;
        b=NFaktFIFlmeJBKdBrrh0THIYNtFwuKjBpqcaHT8pvVJ+i3r+dR/2/IBsbIXcLx0TSK
         g72s19BdRLhBq/VqlSJGYNywCKarfr55KKmD0WsK7eN5IAQhlzVkq4OOvXQdL5T/spZ6
         eKm3wOnZg8x9oYATvsWQStgQeosHoLf2oKMJ7M8Z0M1BJ8tVGiAfrwOdemcYZsT0LX/Y
         0MPhGtqHeBIBvwCpHZhWQ2C/8z6EYo6XOwMyGJ5utPVV+Rcs4XKm7HmjOcbuQddy+b1V
         wxMh0oS38i2VSVnaZa4F2PF8Q82Yx4E0c09e/JO41mojwqrYj3wVT2wnLJBVuO5gnQ6c
         KY9g==
X-Gm-Message-State: AOAM531Bh79gdUnetBXK+lHlw3+nn+UgU+bBb77jpkmwRFVQvXii/TyF
        JCtjnx3X9fsIUta5hmjJ9qJd7LQ4GlYchchxajg0Xw==
X-Google-Smtp-Source: ABdhPJzGz+OTciZXBj0PDZJRd9XuVnJEC+IVRFByfwVQIa1f51OKEW93IpcOH9knoFj1yc3/QFk5+m6QxY38TFtzgmo=
X-Received: by 2002:a25:21c5:: with SMTP id h188mr8398398ybh.23.1630112336370;
 Fri, 27 Aug 2021 17:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210827191858.2037087-1-surenb@google.com> <20210827191858.2037087-2-surenb@google.com>
 <202108271712.1E99CCF4F@keescook>
In-Reply-To: <202108271712.1E99CCF4F@keescook>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 27 Aug 2021 17:58:45 -0700
Message-ID: <CAJuCfpGkM-YzkHN1Kc==f20yvk0DLpOaAp=Kfc-J7+zE0aUCPQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] mm: rearrange madvise code to allow for reuse
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org, eb@emlix.com,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Pekka Enberg <penberg@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Jan Glauber <jan.glauber@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Rob Landley <rob@landley.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Serge E. Hallyn" <serge.hallyn@ubuntu.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Michel Lespinasse <walken@google.com>,
        Tang Chen <tangchen@cn.fujitsu.com>, Robin Holt <holt@sgi.com>,
        Shaohua Li <shli@fusionio.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 5:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Aug 27, 2021 at 12:18:56PM -0700, Suren Baghdasaryan wrote:
> > From: Colin Cross <ccross@google.com>
> >
> > Refactor the madvise syscall to allow for parts of it to be reused by a
> > prctl syscall that affects vmas.
> >
> > Move the code that walks vmas in a virtual address range into a function
> > that takes a function pointer as a parameter.  The only caller for now is
> > sys_madvise, which uses it to call madvise_vma_behavior on each vma, but
> > the next patch will add an additional caller.
> >
> > Move handling all vma behaviors inside madvise_behavior, and rename it to
> > madvise_vma_behavior.
> >
> > Move the code that updates the flags on a vma, including splitting or
> > merging the vma as necessary, into a new function called
> > madvise_update_vma.  The next patch will add support for updating a new
> > anon_name field as well.
> >
> > Signed-off-by: Colin Cross <ccross@google.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Jan Glauber <jan.glauber@gmail.com>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Rob Landley <rob@landley.net>
> > Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: "Serge E. Hallyn" <serge.hallyn@ubuntu.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Rik van Riel <riel@redhat.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Michel Lespinasse <walken@google.com>
> > Cc: Tang Chen <tangchen@cn.fujitsu.com>
> > Cc: Robin Holt <holt@sgi.com>
> > Cc: Shaohua Li <shli@fusionio.com>
> > Cc: Sasha Levin <sasha.levin@oracle.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >   [sumits: rebased over v5.9-rc3]
> > Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> >   [surenb: rebased over v5.14-rc7]
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Other folks have already reviewed this, and it does look okay to me,
> too, but I find it a bit hard to review. There are at least 3 things
> happening in this patch:
> - moving to the walker
> - merging two behavior routines
> - extracting flag setting from behavior checking
>
> It seems like those could be separate patches, but I'm probably overly
> picky. :)

Thank you for taking a look. I wanted to keep the patch as close to
the original as possible, but if more people find it hard to review
then I'll break it up into smaller pieces.
Thanks,
Suren.

>
> -Kees
>
> > ---
> >  mm/madvise.c | 319 +++++++++++++++++++++++++++------------------------
> >  1 file changed, 172 insertions(+), 147 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 5c065bc8b5f6..359cd3fa612c 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -63,76 +63,20 @@ static int madvise_need_mmap_write(int behavior)
> >  }
> >
> >  /*
> > - * We can potentially split a vm area into separate
> > - * areas, each area with its own behavior.
> > + * Update the vm_flags on regiion of a vma, splitting it or merging it as
> > + * necessary.  Must be called with mmap_sem held for writing;
> >   */
> > -static long madvise_behavior(struct vm_area_struct *vma,
> > -                  struct vm_area_struct **prev,
> > -                  unsigned long start, unsigned long end, int behavior)
> > +static int madvise_update_vma(struct vm_area_struct *vma,
> > +                           struct vm_area_struct **prev, unsigned long start,
> > +                           unsigned long end, unsigned long new_flags)
> >  {
> >       struct mm_struct *mm = vma->vm_mm;
> > -     int error = 0;
> > +     int error;
> >       pgoff_t pgoff;
> > -     unsigned long new_flags = vma->vm_flags;
> > -
> > -     switch (behavior) {
> > -     case MADV_NORMAL:
> > -             new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
> > -             break;
> > -     case MADV_SEQUENTIAL:
> > -             new_flags = (new_flags & ~VM_RAND_READ) | VM_SEQ_READ;
> > -             break;
> > -     case MADV_RANDOM:
> > -             new_flags = (new_flags & ~VM_SEQ_READ) | VM_RAND_READ;
> > -             break;
> > -     case MADV_DONTFORK:
> > -             new_flags |= VM_DONTCOPY;
> > -             break;
> > -     case MADV_DOFORK:
> > -             if (vma->vm_flags & VM_IO) {
> > -                     error = -EINVAL;
> > -                     goto out;
> > -             }
> > -             new_flags &= ~VM_DONTCOPY;
> > -             break;
> > -     case MADV_WIPEONFORK:
> > -             /* MADV_WIPEONFORK is only supported on anonymous memory. */
> > -             if (vma->vm_file || vma->vm_flags & VM_SHARED) {
> > -                     error = -EINVAL;
> > -                     goto out;
> > -             }
> > -             new_flags |= VM_WIPEONFORK;
> > -             break;
> > -     case MADV_KEEPONFORK:
> > -             new_flags &= ~VM_WIPEONFORK;
> > -             break;
> > -     case MADV_DONTDUMP:
> > -             new_flags |= VM_DONTDUMP;
> > -             break;
> > -     case MADV_DODUMP:
> > -             if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL) {
> > -                     error = -EINVAL;
> > -                     goto out;
> > -             }
> > -             new_flags &= ~VM_DONTDUMP;
> > -             break;
> > -     case MADV_MERGEABLE:
> > -     case MADV_UNMERGEABLE:
> > -             error = ksm_madvise(vma, start, end, behavior, &new_flags);
> > -             if (error)
> > -                     goto out_convert_errno;
> > -             break;
> > -     case MADV_HUGEPAGE:
> > -     case MADV_NOHUGEPAGE:
> > -             error = hugepage_madvise(vma, &new_flags, behavior);
> > -             if (error)
> > -                     goto out_convert_errno;
> > -             break;
> > -     }
> >
> >       if (new_flags == vma->vm_flags) {
> >               *prev = vma;
> > -             goto out;
> > +             return 0;
> >       }
> >
> >       pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > @@ -149,21 +93,21 @@ static long madvise_behavior(struct vm_area_struct *vma,
> >       if (start != vma->vm_start) {
> >               if (unlikely(mm->map_count >= sysctl_max_map_count)) {
> >                       error = -ENOMEM;
> > -                     goto out;
> > +                     return error;
> >               }
> >               error = __split_vma(mm, vma, start, 1);
> >               if (error)
> > -                     goto out_convert_errno;
> > +                     return error;
> >       }
> >
> >       if (end != vma->vm_end) {
> >               if (unlikely(mm->map_count >= sysctl_max_map_count)) {
> >                       error = -ENOMEM;
> > -                     goto out;
> > +                     return error;
> >               }
> >               error = __split_vma(mm, vma, end, 0);
> >               if (error)
> > -                     goto out_convert_errno;
> > +                     return error;
> >       }
> >
> >  success:
> > @@ -172,15 +116,7 @@ static long madvise_behavior(struct vm_area_struct *vma,
> >        */
> >       vma->vm_flags = new_flags;
> >
> > -out_convert_errno:
> > -     /*
> > -      * madvise() returns EAGAIN if kernel resources, such as
> > -      * slab, are temporarily unavailable.
> > -      */
> > -     if (error == -ENOMEM)
> > -             error = -EAGAIN;
> > -out:
> > -     return error;
> > +     return 0;
> >  }
> >
> >  #ifdef CONFIG_SWAP
> > @@ -930,6 +866,96 @@ static long madvise_remove(struct vm_area_struct *vma,
> >       return error;
> >  }
> >
> > +/*
> > + * Apply an madvise behavior to a region of a vma.  madvise_update_vma
> > + * will handle splitting a vm area into separate areas, each area with its own
> > + * behavior.
> > + */
> > +static int madvise_vma_behavior(struct vm_area_struct *vma,
> > +                             struct vm_area_struct **prev,
> > +                             unsigned long start, unsigned long end,
> > +                             unsigned long behavior)
> > +{
> > +     int error = 0;
> > +     unsigned long new_flags = vma->vm_flags;
> > +
> > +     switch (behavior) {
> > +     case MADV_REMOVE:
> > +             return madvise_remove(vma, prev, start, end);
> > +     case MADV_WILLNEED:
> > +             return madvise_willneed(vma, prev, start, end);
> > +     case MADV_COLD:
> > +             return madvise_cold(vma, prev, start, end);
> > +     case MADV_PAGEOUT:
> > +             return madvise_pageout(vma, prev, start, end);
> > +     case MADV_FREE:
> > +     case MADV_DONTNEED:
> > +             return madvise_dontneed_free(vma, prev, start, end, behavior);
> > +     case MADV_POPULATE_READ:
> > +     case MADV_POPULATE_WRITE:
> > +             return madvise_populate(vma, prev, start, end, behavior);
> > +     case MADV_NORMAL:
> > +             new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
> > +             break;
> > +     case MADV_SEQUENTIAL:
> > +             new_flags = (new_flags & ~VM_RAND_READ) | VM_SEQ_READ;
> > +             break;
> > +     case MADV_RANDOM:
> > +             new_flags = (new_flags & ~VM_SEQ_READ) | VM_RAND_READ;
> > +             break;
> > +     case MADV_DONTFORK:
> > +             new_flags |= VM_DONTCOPY;
> > +             break;
> > +     case MADV_DOFORK:
> > +             if (vma->vm_flags & VM_IO) {
> > +                     error = -EINVAL;
> > +                     goto out;
> > +             }
> > +             new_flags &= ~VM_DONTCOPY;
> > +             break;
> > +     case MADV_WIPEONFORK:
> > +             /* MADV_WIPEONFORK is only supported on anonymous memory. */
> > +             if (vma->vm_file || vma->vm_flags & VM_SHARED) {
> > +                     error = -EINVAL;
> > +                     goto out;
> > +             }
> > +             new_flags |= VM_WIPEONFORK;
> > +             break;
> > +     case MADV_KEEPONFORK:
> > +             new_flags &= ~VM_WIPEONFORK;
> > +             break;
> > +     case MADV_DONTDUMP:
> > +             new_flags |= VM_DONTDUMP;
> > +             break;
> > +     case MADV_DODUMP:
> > +             if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL) {
> > +                     error = -EINVAL;
> > +                     goto out;
> > +             }
> > +             new_flags &= ~VM_DONTDUMP;
> > +             break;
> > +     case MADV_MERGEABLE:
> > +     case MADV_UNMERGEABLE:
> > +             error = ksm_madvise(vma, start, end, behavior, &new_flags);
> > +             if (error)
> > +                     goto out;
> > +             break;
> > +     case MADV_HUGEPAGE:
> > +     case MADV_NOHUGEPAGE:
> > +             error = hugepage_madvise(vma, &new_flags, behavior);
> > +             if (error)
> > +                     goto out;
> > +             break;
> > +     }
> > +
> > +     error = madvise_update_vma(vma, prev, start, end, new_flags);
> > +
> > +out:
> > +     if (error == -ENOMEM)
> > +             error = -EAGAIN;
> > +     return error;
> > +}
> > +
> >  #ifdef CONFIG_MEMORY_FAILURE
> >  /*
> >   * Error injection support for memory error handling.
> > @@ -978,30 +1004,6 @@ static int madvise_inject_error(int behavior,
> >  }
> >  #endif
> >
> > -static long
> > -madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
> > -             unsigned long start, unsigned long end, int behavior)
> > -{
> > -     switch (behavior) {
> > -     case MADV_REMOVE:
> > -             return madvise_remove(vma, prev, start, end);
> > -     case MADV_WILLNEED:
> > -             return madvise_willneed(vma, prev, start, end);
> > -     case MADV_COLD:
> > -             return madvise_cold(vma, prev, start, end);
> > -     case MADV_PAGEOUT:
> > -             return madvise_pageout(vma, prev, start, end);
> > -     case MADV_FREE:
> > -     case MADV_DONTNEED:
> > -             return madvise_dontneed_free(vma, prev, start, end, behavior);
> > -     case MADV_POPULATE_READ:
> > -     case MADV_POPULATE_WRITE:
> > -             return madvise_populate(vma, prev, start, end, behavior);
> > -     default:
> > -             return madvise_behavior(vma, prev, start, end, behavior);
> > -     }
> > -}
> > -
> >  static bool
> >  madvise_behavior_valid(int behavior)
> >  {
> > @@ -1054,6 +1056,73 @@ process_madvise_behavior_valid(int behavior)
> >       }
> >  }
> >
> > +/*
> > + * Walk the vmas in range [start,end), and call the visit function on each one.
> > + * The visit function will get start and end parameters that cover the overlap
> > + * between the current vma and the original range.  Any unmapped regions in the
> > + * original range will result in this function returning -ENOMEM while still
> > + * calling the visit function on all of the existing vmas in the range.
> > + * Must be called with the mmap_lock held for reading or writing.
> > + */
> > +static
> > +int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
> > +                   unsigned long end, unsigned long arg,
> > +                   int (*visit)(struct vm_area_struct *vma,
> > +                                struct vm_area_struct **prev, unsigned long start,
> > +                                unsigned long end, unsigned long arg))
> > +{
> > +     struct vm_area_struct *vma;
> > +     struct vm_area_struct *prev;
> > +     unsigned long tmp;
> > +     int unmapped_error = 0;
> > +
> > +     /*
> > +      * If the interval [start,end) covers some unmapped address
> > +      * ranges, just ignore them, but return -ENOMEM at the end.
> > +      * - different from the way of handling in mlock etc.
> > +      */
> > +     vma = find_vma_prev(mm, start, &prev);
> > +     if (vma && start > vma->vm_start)
> > +             prev = vma;
> > +
> > +     for (;;) {
> > +             int error;
> > +
> > +             /* Still start < end. */
> > +             if (!vma)
> > +                     return -ENOMEM;
> > +
> > +             /* Here start < (end|vma->vm_end). */
> > +             if (start < vma->vm_start) {
> > +                     unmapped_error = -ENOMEM;
> > +                     start = vma->vm_start;
> > +                     if (start >= end)
> > +                             break;
> > +             }
> > +
> > +             /* Here vma->vm_start <= start < (end|vma->vm_end) */
> > +             tmp = vma->vm_end;
> > +             if (end < tmp)
> > +                     tmp = end;
> > +
> > +             /* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
> > +             error = visit(vma, &prev, start, tmp, arg);
> > +             if (error)
> > +                     return error;
> > +             start = tmp;
> > +             if (prev && start < prev->vm_end)
> > +                     start = prev->vm_end;
> > +             if (start >= end)
> > +                     break;
> > +             if (prev)
> > +                     vma = prev->vm_next;
> > +             else    /* madvise_remove dropped mmap_lock */
> > +                     vma = find_vma(mm, start);
> > +     }
> > +
> > +     return unmapped_error;
> > +}
> > +
> >  /*
> >   * The madvise(2) system call.
> >   *
> > @@ -1126,9 +1195,7 @@ process_madvise_behavior_valid(int behavior)
> >   */
> >  int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
> >  {
> > -     unsigned long end, tmp;
> > -     struct vm_area_struct *vma, *prev;
> > -     int unmapped_error = 0;
> > +     unsigned long end;
> >       int error = -EINVAL;
> >       int write;
> >       size_t len;
> > @@ -1168,51 +1235,9 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
> >               mmap_read_lock(mm);
> >       }
> >
> > -     /*
> > -      * If the interval [start,end) covers some unmapped address
> > -      * ranges, just ignore them, but return -ENOMEM at the end.
> > -      * - different from the way of handling in mlock etc.
> > -      */
> > -     vma = find_vma_prev(mm, start, &prev);
> > -     if (vma && start > vma->vm_start)
> > -             prev = vma;
> > -
> >       blk_start_plug(&plug);
> > -     for (;;) {
> > -             /* Still start < end. */
> > -             error = -ENOMEM;
> > -             if (!vma)
> > -                     goto out;
> > -
> > -             /* Here start < (end|vma->vm_end). */
> > -             if (start < vma->vm_start) {
> > -                     unmapped_error = -ENOMEM;
> > -                     start = vma->vm_start;
> > -                     if (start >= end)
> > -                             goto out;
> > -             }
> > -
> > -             /* Here vma->vm_start <= start < (end|vma->vm_end) */
> > -             tmp = vma->vm_end;
> > -             if (end < tmp)
> > -                     tmp = end;
> > -
> > -             /* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
> > -             error = madvise_vma(vma, &prev, start, tmp, behavior);
> > -             if (error)
> > -                     goto out;
> > -             start = tmp;
> > -             if (prev && start < prev->vm_end)
> > -                     start = prev->vm_end;
> > -             error = unmapped_error;
> > -             if (start >= end)
> > -                     goto out;
> > -             if (prev)
> > -                     vma = prev->vm_next;
> > -             else    /* madvise_remove dropped mmap_lock */
> > -                     vma = find_vma(mm, start);
> > -     }
> > -out:
> > +     error = madvise_walk_vmas(mm, start, end, behavior,
> > +                     madvise_vma_behavior);
> >       blk_finish_plug(&plug);
> >       if (write)
> >               mmap_write_unlock(mm);
> > --
> > 2.33.0.259.gc128427fd7-goog
> >
>
> --
> Kees Cook
