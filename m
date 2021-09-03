Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6DE3FF860
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 02:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbhICAaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 20:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbhICAaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 20:30:10 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44C7C061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Sep 2021 17:29:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id f15so7149906ybg.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 17:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9SaGHSuOXCrItgAbBPYGhsYiz2vs3ute8NQFPvnaUQ=;
        b=V6AgF1x9oVWCjF2hTKLjoxWgqPgnmoYwiACxC56iF1TZ9hdA+2iGh3TRshNQb2Qvha
         QF66aXDqKrmni2DXQRZNAaGniJ2MBXiTn2qJ4XXB0qhtWUNqxNOEUz6phOkV6YtzMNzz
         1VXyU64s2wAFu4FkYPt05FDGiVbGZnZ9NCjDCl3Z2Qh+6NtIckL+GqNUQI85hV9XdRYa
         nM8GYTq8y306Cq3RX514UlqQmx37SSI9GxtkG6lRS8D/RXXICnVeeH1lMT1xsbYtqPLC
         ayf+V28SOtV2YV06ICcOKSmZ/tbsQLOMdvOMLB1y/P0r+RpjZz5yJo5PWyZ4Fd7RgrDE
         1bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9SaGHSuOXCrItgAbBPYGhsYiz2vs3ute8NQFPvnaUQ=;
        b=e5OyFjq2qTcL/TxfvEmXIXJ4/kRyAHnqVLUhNH2gTTPlFz8DINC4LFHAaNOSazjtNL
         IffGBfFXZji8q5+xedqadKs7mXYRTJKhY4YjwgoFGOuSo+FxXfJV1SV6NO+Oi9+50pAX
         3+ypp0RnU7WSLfABEbvxp0UhsfB3+Tg1Vc440phdlnlIqTxkp0R6++7k7p1uq8q/PlFn
         bw3I/DaNMa2X2dZo5l3Co+KfHmXIqml8wmh0xhwtk8kNHTdppvrQXSEzo/9dbC+JFD1r
         OIi3KNQ61O8qpCkoiUyEYH+VOO1suM8+O5gIaQTF9O0x/D1vH0CkxB6Cums7tyv81DSJ
         1CRA==
X-Gm-Message-State: AOAM53023Helf+d5scEvyJpkWhrB0hsV3HoDEcgxrpXcEgn9FFCCr3Uf
        XkI/2hyptCCN/VRrVMCa9HTvoopm3gX8is4CxlBXow==
X-Google-Smtp-Source: ABdhPJy2m5S1Zb6iZbjNfn32rAHmkKxfVRbZ/Yj3k68ca7klTUsu6U3xir0cSBVoer5aI0SozL4U5yIX46sumyNR7kI=
X-Received: by 2002:a25:49c2:: with SMTP id w185mr1274569yba.294.1630628950482;
 Thu, 02 Sep 2021 17:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210902231813.3597709-1-surenb@google.com>
In-Reply-To: <20210902231813.3597709-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 2 Sep 2021 17:28:59 -0700
Message-ID: <CAJuCfpFDBJ_W1y2tqAT4BGtPbWrjjDud_JuKO8ZbnjYfeVNvRg@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] mm: rearrange madvise code to allow for reuse
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
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
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Mel Gorman <mgorman@suse.de>, Shaohua Li <shli@fusionio.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 2, 2021 at 4:18 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> From: Colin Cross <ccross@google.com>
>
> Refactor the madvise syscall to allow for parts of it to be reused by a
> prctl syscall that affects vmas.
>
> Move the code that walks vmas in a virtual address range into a function
> that takes a function pointer as a parameter.  The only caller for now is
> sys_madvise, which uses it to call madvise_vma_behavior on each vma, but
> the next patch will add an additional caller.
>
> Move handling all vma behaviors inside madvise_behavior, and rename it to
> madvise_vma_behavior.
>
> Move the code that updates the flags on a vma, including splitting or
> merging the vma as necessary, into a new function called
> madvise_update_vma.  The next patch will add support for updating a new
> anon_name field as well.
>
> Signed-off-by: Colin Cross <ccross@google.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Jan Glauber <jan.glauber@gmail.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Rob Landley <rob@landley.net>
> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Serge E. Hallyn" <serge.hallyn@ubuntu.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Shaohua Li <shli@fusionio.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>   [sumits: rebased over v5.9-rc3]
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
>   [surenb: rebased over v5.14-rc7]
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> previous version including cover letter with test results is at:
> https://lore.kernel.org/linux-mm/20210827191858.2037087-1-surenb@google.com/
>
> changes in v9
> - Removed unnecessary initialization of 'error' to 0 in madvise_vma_behavior,
> per Cyrill Gorcunov
> - Replaced goto's with returns in madvise_vma_behavior, per Cyrill Gorcunov
> - Recovered the comment explaining why we map ENOMEM to EAGAIN in
> madvise_vma_behavior, per Cyrill Gorcunov
>
>  mm/madvise.c | 317 +++++++++++++++++++++++++++------------------------
>  1 file changed, 170 insertions(+), 147 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 56324a3dbc4e..54bf9f73f95d 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -63,76 +63,20 @@ static int madvise_need_mmap_write(int behavior)
>  }
>
>  /*
> - * We can potentially split a vm area into separate
> - * areas, each area with its own behavior.
> + * Update the vm_flags on regiion of a vma, splitting it or merging it as
> + * necessary.  Must be called with mmap_sem held for writing;
>   */
> -static long madvise_behavior(struct vm_area_struct *vma,
> -                    struct vm_area_struct **prev,
> -                    unsigned long start, unsigned long end, int behavior)
> +static int madvise_update_vma(struct vm_area_struct *vma,
> +                             struct vm_area_struct **prev, unsigned long start,
> +                             unsigned long end, unsigned long new_flags)
>  {
>         struct mm_struct *mm = vma->vm_mm;
> -       int error = 0;
> +       int error;
>         pgoff_t pgoff;
> -       unsigned long new_flags = vma->vm_flags;
> -
> -       switch (behavior) {
> -       case MADV_NORMAL:
> -               new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
> -               break;
> -       case MADV_SEQUENTIAL:
> -               new_flags = (new_flags & ~VM_RAND_READ) | VM_SEQ_READ;
> -               break;
> -       case MADV_RANDOM:
> -               new_flags = (new_flags & ~VM_SEQ_READ) | VM_RAND_READ;
> -               break;
> -       case MADV_DONTFORK:
> -               new_flags |= VM_DONTCOPY;
> -               break;
> -       case MADV_DOFORK:
> -               if (vma->vm_flags & VM_IO) {
> -                       error = -EINVAL;
> -                       goto out;
> -               }
> -               new_flags &= ~VM_DONTCOPY;
> -               break;
> -       case MADV_WIPEONFORK:
> -               /* MADV_WIPEONFORK is only supported on anonymous memory. */
> -               if (vma->vm_file || vma->vm_flags & VM_SHARED) {
> -                       error = -EINVAL;
> -                       goto out;
> -               }
> -               new_flags |= VM_WIPEONFORK;
> -               break;
> -       case MADV_KEEPONFORK:
> -               new_flags &= ~VM_WIPEONFORK;
> -               break;
> -       case MADV_DONTDUMP:
> -               new_flags |= VM_DONTDUMP;
> -               break;
> -       case MADV_DODUMP:
> -               if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL) {
> -                       error = -EINVAL;
> -                       goto out;
> -               }
> -               new_flags &= ~VM_DONTDUMP;
> -               break;
> -       case MADV_MERGEABLE:
> -       case MADV_UNMERGEABLE:
> -               error = ksm_madvise(vma, start, end, behavior, &new_flags);
> -               if (error)
> -                       goto out_convert_errno;
> -               break;
> -       case MADV_HUGEPAGE:
> -       case MADV_NOHUGEPAGE:
> -               error = hugepage_madvise(vma, &new_flags, behavior);
> -               if (error)
> -                       goto out_convert_errno;
> -               break;
> -       }
>
>         if (new_flags == vma->vm_flags) {
>                 *prev = vma;
> -               goto out;
> +               return 0;
>         }
>
>         pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> @@ -149,21 +93,21 @@ static long madvise_behavior(struct vm_area_struct *vma,
>         if (start != vma->vm_start) {
>                 if (unlikely(mm->map_count >= sysctl_max_map_count)) {
>                         error = -ENOMEM;
> -                       goto out;
> +                       return error;

Oh, I missed this one. Should be simply:
-                       error = -ENOMEM;
-                       goto out;
+                       return -ENOMEM;


>                 }
>                 error = __split_vma(mm, vma, start, 1);
>                 if (error)
> -                       goto out_convert_errno;
> +                       return error;
>         }
>
>         if (end != vma->vm_end) {
>                 if (unlikely(mm->map_count >= sysctl_max_map_count)) {
>                         error = -ENOMEM;
> -                       goto out;
> +                       return error;

same here.

>                 }
>                 error = __split_vma(mm, vma, end, 0);
>                 if (error)
> -                       goto out_convert_errno;
> +                       return error;
>         }
>
>  success:
> @@ -172,15 +116,7 @@ static long madvise_behavior(struct vm_area_struct *vma,
>          */
>         vma->vm_flags = new_flags;
>
> -out_convert_errno:
> -       /*
> -        * madvise() returns EAGAIN if kernel resources, such as
> -        * slab, are temporarily unavailable.
> -        */
> -       if (error == -ENOMEM)
> -               error = -EAGAIN;
> -out:
> -       return error;
> +       return 0;
>  }
>
>  #ifdef CONFIG_SWAP
> @@ -930,6 +866,94 @@ static long madvise_remove(struct vm_area_struct *vma,
>         return error;
>  }
>
> +/*
> + * Apply an madvise behavior to a region of a vma.  madvise_update_vma
> + * will handle splitting a vm area into separate areas, each area with its own
> + * behavior.
> + */
> +static int madvise_vma_behavior(struct vm_area_struct *vma,
> +                               struct vm_area_struct **prev,
> +                               unsigned long start, unsigned long end,
> +                               unsigned long behavior)
> +{
> +       int error;
> +       unsigned long new_flags = vma->vm_flags;
> +
> +       switch (behavior) {
> +       case MADV_REMOVE:
> +               return madvise_remove(vma, prev, start, end);
> +       case MADV_WILLNEED:
> +               return madvise_willneed(vma, prev, start, end);
> +       case MADV_COLD:
> +               return madvise_cold(vma, prev, start, end);
> +       case MADV_PAGEOUT:
> +               return madvise_pageout(vma, prev, start, end);
> +       case MADV_FREE:
> +       case MADV_DONTNEED:
> +               return madvise_dontneed_free(vma, prev, start, end, behavior);
> +       case MADV_POPULATE_READ:
> +       case MADV_POPULATE_WRITE:
> +               return madvise_populate(vma, prev, start, end, behavior);
> +       case MADV_NORMAL:
> +               new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
> +               break;
> +       case MADV_SEQUENTIAL:
> +               new_flags = (new_flags & ~VM_RAND_READ) | VM_SEQ_READ;
> +               break;
> +       case MADV_RANDOM:
> +               new_flags = (new_flags & ~VM_SEQ_READ) | VM_RAND_READ;
> +               break;
> +       case MADV_DONTFORK:
> +               new_flags |= VM_DONTCOPY;
> +               break;
> +       case MADV_DOFORK:
> +               if (vma->vm_flags & VM_IO)
> +                       return -EINVAL;
> +               new_flags &= ~VM_DONTCOPY;
> +               break;
> +       case MADV_WIPEONFORK:
> +               /* MADV_WIPEONFORK is only supported on anonymous memory. */
> +               if (vma->vm_file || vma->vm_flags & VM_SHARED)
> +                       return -EINVAL;
> +               new_flags |= VM_WIPEONFORK;
> +               break;
> +       case MADV_KEEPONFORK:
> +               new_flags &= ~VM_WIPEONFORK;
> +               break;
> +       case MADV_DONTDUMP:
> +               new_flags |= VM_DONTDUMP;
> +               break;
> +       case MADV_DODUMP:
> +               if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL)
> +                       return -EINVAL;
> +               new_flags &= ~VM_DONTDUMP;
> +               break;
> +       case MADV_MERGEABLE:
> +       case MADV_UNMERGEABLE:
> +               error = ksm_madvise(vma, start, end, behavior, &new_flags);
> +               if (error)
> +                       goto out;
> +               break;
> +       case MADV_HUGEPAGE:
> +       case MADV_NOHUGEPAGE:
> +               error = hugepage_madvise(vma, &new_flags, behavior);
> +               if (error)
> +                       goto out;
> +               break;
> +       }
> +
> +       error = madvise_update_vma(vma, prev, start, end, new_flags);
> +
> +out:
> +       /*
> +        * madvise() returns EAGAIN if kernel resources, such as
> +        * slab, are temporarily unavailable.
> +        */
> +       if (error == -ENOMEM)
> +               error = -EAGAIN;
> +       return error;
> +}
> +
>  #ifdef CONFIG_MEMORY_FAILURE
>  /*
>   * Error injection support for memory error handling.
> @@ -978,30 +1002,6 @@ static int madvise_inject_error(int behavior,
>  }
>  #endif
>
> -static long
> -madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
> -               unsigned long start, unsigned long end, int behavior)
> -{
> -       switch (behavior) {
> -       case MADV_REMOVE:
> -               return madvise_remove(vma, prev, start, end);
> -       case MADV_WILLNEED:
> -               return madvise_willneed(vma, prev, start, end);
> -       case MADV_COLD:
> -               return madvise_cold(vma, prev, start, end);
> -       case MADV_PAGEOUT:
> -               return madvise_pageout(vma, prev, start, end);
> -       case MADV_FREE:
> -       case MADV_DONTNEED:
> -               return madvise_dontneed_free(vma, prev, start, end, behavior);
> -       case MADV_POPULATE_READ:
> -       case MADV_POPULATE_WRITE:
> -               return madvise_populate(vma, prev, start, end, behavior);
> -       default:
> -               return madvise_behavior(vma, prev, start, end, behavior);
> -       }
> -}
> -
>  static bool
>  madvise_behavior_valid(int behavior)
>  {
> @@ -1054,6 +1054,73 @@ process_madvise_behavior_valid(int behavior)
>         }
>  }
>
> +/*
> + * Walk the vmas in range [start,end), and call the visit function on each one.
> + * The visit function will get start and end parameters that cover the overlap
> + * between the current vma and the original range.  Any unmapped regions in the
> + * original range will result in this function returning -ENOMEM while still
> + * calling the visit function on all of the existing vmas in the range.
> + * Must be called with the mmap_lock held for reading or writing.
> + */
> +static
> +int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
> +                     unsigned long end, unsigned long arg,
> +                     int (*visit)(struct vm_area_struct *vma,
> +                                  struct vm_area_struct **prev, unsigned long start,
> +                                  unsigned long end, unsigned long arg))
> +{
> +       struct vm_area_struct *vma;
> +       struct vm_area_struct *prev;
> +       unsigned long tmp;
> +       int unmapped_error = 0;
> +
> +       /*
> +        * If the interval [start,end) covers some unmapped address
> +        * ranges, just ignore them, but return -ENOMEM at the end.
> +        * - different from the way of handling in mlock etc.
> +        */
> +       vma = find_vma_prev(mm, start, &prev);
> +       if (vma && start > vma->vm_start)
> +               prev = vma;
> +
> +       for (;;) {
> +               int error;
> +
> +               /* Still start < end. */
> +               if (!vma)
> +                       return -ENOMEM;
> +
> +               /* Here start < (end|vma->vm_end). */
> +               if (start < vma->vm_start) {
> +                       unmapped_error = -ENOMEM;
> +                       start = vma->vm_start;
> +                       if (start >= end)
> +                               break;
> +               }
> +
> +               /* Here vma->vm_start <= start < (end|vma->vm_end) */
> +               tmp = vma->vm_end;
> +               if (end < tmp)
> +                       tmp = end;
> +
> +               /* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
> +               error = visit(vma, &prev, start, tmp, arg);
> +               if (error)
> +                       return error;
> +               start = tmp;
> +               if (prev && start < prev->vm_end)
> +                       start = prev->vm_end;
> +               if (start >= end)
> +                       break;
> +               if (prev)
> +                       vma = prev->vm_next;
> +               else    /* madvise_remove dropped mmap_lock */
> +                       vma = find_vma(mm, start);
> +       }
> +
> +       return unmapped_error;
> +}
> +
>  /*
>   * The madvise(2) system call.
>   *
> @@ -1126,9 +1193,7 @@ process_madvise_behavior_valid(int behavior)
>   */
>  int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
>  {
> -       unsigned long end, tmp;
> -       struct vm_area_struct *vma, *prev;
> -       int unmapped_error = 0;
> +       unsigned long end;
>         int error = -EINVAL;
>         int write;
>         size_t len;
> @@ -1168,51 +1233,9 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
>                 mmap_read_lock(mm);
>         }
>
> -       /*
> -        * If the interval [start,end) covers some unmapped address
> -        * ranges, just ignore them, but return -ENOMEM at the end.
> -        * - different from the way of handling in mlock etc.
> -        */
> -       vma = find_vma_prev(mm, start, &prev);
> -       if (vma && start > vma->vm_start)
> -               prev = vma;
> -
>         blk_start_plug(&plug);
> -       for (;;) {
> -               /* Still start < end. */
> -               error = -ENOMEM;
> -               if (!vma)
> -                       goto out;
> -
> -               /* Here start < (end|vma->vm_end). */
> -               if (start < vma->vm_start) {
> -                       unmapped_error = -ENOMEM;
> -                       start = vma->vm_start;
> -                       if (start >= end)
> -                               goto out;
> -               }
> -
> -               /* Here vma->vm_start <= start < (end|vma->vm_end) */
> -               tmp = vma->vm_end;
> -               if (end < tmp)
> -                       tmp = end;
> -
> -               /* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
> -               error = madvise_vma(vma, &prev, start, tmp, behavior);
> -               if (error)
> -                       goto out;
> -               start = tmp;
> -               if (prev && start < prev->vm_end)
> -                       start = prev->vm_end;
> -               error = unmapped_error;
> -               if (start >= end)
> -                       goto out;
> -               if (prev)
> -                       vma = prev->vm_next;
> -               else    /* madvise_remove dropped mmap_lock */
> -                       vma = find_vma(mm, start);
> -       }
> -out:
> +       error = madvise_walk_vmas(mm, start, end, behavior,
> +                       madvise_vma_behavior);
>         blk_finish_plug(&plug);
>         if (write)
>                 mmap_write_unlock(mm);
> --
> 2.33.0.153.gba50c8fa24-goog
>
