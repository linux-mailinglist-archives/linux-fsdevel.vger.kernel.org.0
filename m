Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA99778103
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 21:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjHJTH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 15:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjHJTHZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:07:25 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D01A8;
        Thu, 10 Aug 2023 12:07:24 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bc886d1504so1210692a34.0;
        Thu, 10 Aug 2023 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691694443; x=1692299243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa9sfAl+ylZ6tghTSB9hOsbQY59hrVU85Awo4VaoicU=;
        b=dZfo5aDWKx+6JutzXBP++C7e7wwHLvtvPXx3S0Na6r8wl1io3A3NpcLsBz8b8qJAnW
         CJxQz+O3/tlzDMjrDvLfB13bJj1rCbE2q38PVdcrp8OyGwjMaAdkyFQvYCHrqGIjIgOX
         PNtDSoeLjK97JKHg1Ybd739DEJ6Fj6uOKLrtJ5WcA/pWCVjWeVFhigl7yn01z5ZSwsVR
         a2MnJ5+qHl1wKh0QQRiNyljDi+HQRmQe+XS7GilwGK/4pdb2ALNQLn+6A76AqbyvTv0S
         lrNANtDr90BWJXRS0slpZJAywaBuCI+wzGJPqsENFx7I09RdDGJEGBkrQRH4bUYAVyxg
         tVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694443; x=1692299243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa9sfAl+ylZ6tghTSB9hOsbQY59hrVU85Awo4VaoicU=;
        b=IbaIEXluPXHL5YHgIgeW5YHrXTrIyzKnw8j3hTdkmchnaPIFV42QHO8euNW7dQzyuz
         ffh7et3voQRblOvAYcekAGdwBjFuhu1atcSihhOMYNb0p9TZc9hT3JRGHAWHXku8Y3pn
         YlrgHTF9pfA+/9FSEw2ShS3NANxaT1DkJ1TPGiWb4SqAbOqm3YBQOmhOFs7Rt3u5Ny4G
         Wtn8FwoRWm2YVNaIPTg35ktEg+D+TElnvMlX6NViiOSfqhwbzu5Smlzsqi4zrPy3n+Sz
         459ISUztn2FlTwQxhZ98B4F9+ld33YpS0sGufxMjxHs89tnJLdi+MBm1btlfl9l74vy/
         a9iA==
X-Gm-Message-State: AOJu0Ywv5AGGjCZwpfSVhFX7OE8XGAr6nRGkIxPcXk449krnAvUDRnzt
        j/oCobojRMVC8iA+FqCtY/9SbDnb1IHMU81PO9A=
X-Google-Smtp-Source: AGHT+IGl0qaGC/IIRR/5+Vsc0j7p6Bh3g0n15vd9I7+WXg7vm42FkUEwJ636BvYjxVnhSSUKOY0RTQ0wkc+HQ1Ci3fg=
X-Received: by 2002:a05:6359:2d4d:b0:134:e40e:b6d6 with SMTP id
 rm13-20020a0563592d4d00b00134e40eb6d6mr2468677rwb.6.1691694443107; Thu, 10
 Aug 2023 12:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230809061603.1969154-1-usama.anjum@collabora.com> <20230809061603.1969154-3-usama.anjum@collabora.com>
In-Reply-To: <20230809061603.1969154-3-usama.anjum@collabora.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 10 Aug 2023 12:07:11 -0700
Message-ID: <CANaxB-xoNiNnsJnSMAbn+6=3zf_54k31vqws+fJo3SWhN18enQ@mail.gmail.com>
Subject: Re: [PATCH v28 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 8, 2023 at 11:16=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
> the info about page table entries. The following operations are supported
> in this ioctl:
> - Get the information if the pages have Async Write-Protection enabled
>   (``PAGE_IS_WPALLOWED``), have been written to (``PAGE_IS_WRITTEN``), fi=
le
>   mapped (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``), swapped
>   (``PAGE_IS_SWAPPED``) or page has pfn zero (``PAGE_IS_PFNZERO``).
> - Find pages which have been written to and/or write protect
>   (atomic ``PM_SCAN_WP_MATCHING + PM_SCAN_CHECK_WPASYNC``) the pages
>   atomically. The (``PM_SCAN_WP_MATCHING``) is used to WP the matched
>   pages. The (``PM_SCAN_CHECK_WPASYNC``) aborts the operation if
>   non-Async-Write-Protected pages are found. Get is automatically perform=
ed
>   if output buffer is specified.
>
> This IOCTL can be extended to get information about more PTE bits. The
> entire address range passed by user [start, end) is scanned until either
> the user provided buffer is full or max_pages have been found.
>
> Reviewed-by: Andrei Vagin <avagin@gmail.com>
> Reviewed-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in v28:
> - Fix walk_end one last time after doing through testing
>
> Changes in v27:
> - Add PAGE_IS_HUGE
> - Iterate until temporary buffer is full to do less iterations
> - Don't check if PAGE_IS_FILE if no mask needs it as it is very
>   expensive to check per pte
> - bring is_interesting_page() outside pagemap_scan_output() to remove
>   the horrible return value check
> - Replace memcpy() with direct copy
> - rename end_addr to walk_end_addr in pagemap_scan_private
> - Abort walk if fatal_signal_pending()
>
> Changes in v26:
> Changes made by Usama:
> - Fix the wrong breaking of loop if page isn't interesting, skip intsead
> - Untag the address and save them into struct
> - Round off the end address to next page
> - Correct the partial hugetlb page handling and returning the error
> - Rename PAGE_IS_WPASYNC to PAGE_IS_WPALLOWED
> - Return walk ending address in walk_end instead of returning in start
>   as there is potential of replacing the memory tag
>
> Changes by Micha=C5=82:
> 1. the API:
>   a. return ranges as {begin, end} instead of {begin + len};
>   b. rename match "flags" to 'page categories' everywhere - this makes
>         it easier to differentiate the ioctl()s categorisation of pages
>         from struct page flags;
>   c. change {required + excluded} to {inverted + required}. This was
>         rejected before, but I'd like to illustrate the difference.
>         Old interface can be translated to the new by:
>                 categories_inverted =3D excluded_mask
>                 categories_mask =3D required_mask | excluded_mask
>                 categories_anyof_mask =3D anyof_mask
>         The new way allows filtering by: A & (B | !C)
>                 categories_inverted =3D C
>                 categories_mask =3D A
>                 categories_anyof_mask =3D B | C
>   e. allow no-op calls
> 2. the implementation:
>   a. gather the page-categorising and write-protecting code in one place;
>   b. optimization: add whole-vma skipping for WP usecase;
>   c. extracted output limiting code to pagemap_scan_output();
>   d. extracted range coalescing to pagemap_scan_push_range();
>   e. extracted THP entry handling to pagemap_scan_thp_entry();
>   f. added a shortcut for non-WP hugetlb scan; avoids conditional
>         locking;
>   g. extracted scan buffer handling code out of do_pagemap_scan();
>   h. rework output code to always try to write pending ranges; if EFAULT
>         is generated it always overwrites the original error code;
>         (the case of SIGKILL is needlessly trying to write the output
>         now, but this should be rare case and ignoring it makes the code
>         not needing a goto)
> 3.Change no-GET operation condition from `arg.return_mask =3D=3D 0` to
>   `arg.vec =3D=3D NULL`. This will allow issuing the ioctl with
>   return_mask =3D=3D 0 to gather matching ranges when the exact category
>   is not interesting. (Anticipated for CRIU scanning a large sparse
>   anonymous mapping).
>
> Changes in v25:
> - Do proper filtering on hole as well (hole got missed earlier)
>
> Changes in v24:
> - Place WP markers in case of hole as well
>
> Changes in v23:
> - Set vec_buf_index to 0 only when vec_buf_index is set
> - Return -EFAULT instead of -EINVAL if vec is NULL
> - Correctly return the walk ending address to the page granularity
>
> Changes in v22:
> - Interface change to return walk ending address to user:
>   - Replace [start start + len) with [start, end)
>   - Return the ending address of the address walk in start
>
> Changes in v21:
> - Abort walk instead of returning error if WP is to be performed on
>   partial hugetlb
> - Changed the data types of some variables in pagemap_scan_private to
>   long
>
> Changes in v20:
> - Correct PAGE_IS_FILE and add PAGE_IS_PFNZERO
>
> Changes in v19:
> - Interface changes such as renaming, return mask and WP can be used
>   with any flags specified in masks
> - Internal code changes
>
> Changes in v18:
> - Rebased on top of next-20230613
>   - ptep_get() updates
>   - remove pmd_trans_unstable() and add ACTION_AGAIN
> - Review updates (Micheal)
>
> Changes in v17:
> - Rebased on next-20230606
> - Made make_uffd_wp_*_pte() better and minor changes
>
> Changes in v16:
> - Fixed a corner case where kernel writes beyond user buffer by one
>   element
> - Bring back exclusive PM_SCAN_OP_WP
> - Cosmetic changes
>
> Changes in v15:
> - Build fix:
>   - Use generic tlb flush function in pagemap_scan_pmd_entry() instead of
>     using x86 specific flush function in do_pagemap_scan()
>   - Remove #ifdef from pagemap_scan_hugetlb_entry()
>   - Use mm instead of undefined vma->vm_mm
>
> Changes in v14:
> - Fix build error caused by #ifdef added at last minute in some configs
>
> Changes in v13:
> - Review updates
> - mmap_read_lock_killable() instead of mmap_read_lock()
> - Replace uffd_wp_range() with helpers which increases performance
>   drastically for OP_WP operations by reducing the number of tlb
>   flushing etc
> - Add MMU_NOTIFY_PROTECTION_VMA notification for the memory range
>
> Changes in v12:
> - Add hugetlb support to cover all memory types
> - Merge "userfaultfd: Define dummy uffd_wp_range()" with this patch
> - Review updates to the code
>
> Changes in v11:
> - Find written pages in a better way
> - Fix a corner case (thanks Paul)
> - Improve the code/comments
> - remove ENGAGE_WP + ! GET operation
> - shorten the commit message in favour of moving documentation to
>   pagemap.rst
>
> Changes in v10:
> - move changes in tools/include/uapi/linux/fs.h to separate patch
> - update commit message
>
> Change in v8:
> - Correct is_pte_uffd_wp()
> - Improve readability and error checks
> - Remove some un-needed code
>
> Changes in v7:
> - Rebase on top of latest next
> - Fix some corner cases
> - Base soft-dirty on the uffd wp async
> - Update the terminologies
> - Optimize the memory usage inside the ioctl
> ---
>  fs/proc/task_mmu.c      | 678 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/hugetlb.h |   1 +
>  include/uapi/linux/fs.h |  59 ++++
>  mm/hugetlb.c            |   2 +-
>  4 files changed, 739 insertions(+), 1 deletion(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index c1e6531cb02ae..0e219a44e97cd 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -19,6 +19,8 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/uaccess.h>
>  #include <linux/pkeys.h>
> +#include <linux/minmax.h>
> +#include <linux/overflow.h>
>
>  #include <asm/elf.h>
>  #include <asm/tlb.h>
> @@ -1749,11 +1751,687 @@ static int pagemap_release(struct inode *inode, =
struct file *file)
>         return 0;
>  }
>
> +#define PM_SCAN_CATEGORIES     (PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN |  \
> +                                PAGE_IS_FILE | PAGE_IS_PRESENT |       \
> +                                PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |    \
> +                                PAGE_IS_HUGE)
> +#define PM_SCAN_FLAGS          (PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPAS=
YNC)
> +
> +#define MASKS_OF_INTEREST(a)   (a.category_inverted | a.category_mask | =
\
> +                                a.category_anyof_mask | a.return_mask)
> +
> +struct pagemap_scan_private {
> +       struct pm_scan_arg arg;
> +       unsigned long masks_of_interest, cur_vma_category;
> +       struct page_region *vec_buf, cur_buf;

I think we can remove cur_buf. Imho, it makes code a bit more readable.
Here is a quick poc patch:
https://gist.github.com/avagin/2e465e7c362c515ec84d72a201a28de4

> +       unsigned long vec_buf_len, vec_buf_index, found_pages, walk_end_a=
ddr;
> +       struct page_region __user *vec_out;
> +};

...

> +#ifdef CONFIG_HUGETLB_PAGE
> +static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
> +                                     unsigned long start, unsigned long =
end,
> +                                     struct mm_walk *walk)
> +{
> +       struct pagemap_scan_private *p =3D walk->private;
> +       struct vm_area_struct *vma =3D walk->vma;
> +       unsigned long categories;
> +       spinlock_t *ptl;
> +       int ret =3D 0;
> +       pte_t pte;
> +
> +       if (~p->arg.flags & PM_SCAN_WP_MATCHING) {
> +               /* Go the short route when not write-protecting pages. */
> +
> +               pte =3D huge_ptep_get(ptep);
> +               categories =3D p->cur_vma_category | pagemap_hugetlb_cate=
gory(pte);
> +
> +               if (!pagemap_scan_is_interesting_page(categories, p))
> +                       return 0;
> +
> +               return pagemap_scan_output(categories, p, start, &end);
> +       }
> +
> +       i_mmap_lock_write(vma->vm_file->f_mapping);
> +       ptl =3D huge_pte_lock(hstate_vma(vma), vma->vm_mm, ptep);
> +
> +       pte =3D huge_ptep_get(ptep);
> +       categories =3D p->cur_vma_category | pagemap_hugetlb_category(pte=
);
> +
> +       if (!pagemap_scan_is_interesting_page(categories, p))
> +               goto out_unlock;
> +
> +       ret =3D pagemap_scan_output(categories, p, start, &end);
> +       if (start =3D=3D end)
> +               goto out_unlock;
> +
> +       if (~categories & PAGE_IS_WRITTEN)
> +               goto out_unlock;
> +
> +       if (end !=3D start + HPAGE_SIZE) {
> +               /* Partial HugeTLB page WP isn't possible. */
> +               pagemap_scan_backout_range(p, start, end, start);
> +               ret =3D -EINVAL;

Will this error be returned from ioctl? If the answer is yet, it looks
wrong to me.

> +               goto out_unlock;
> +       }
> +
> +       make_uffd_wp_huge_pte(vma, start, ptep, pte);
> +       flush_hugetlb_tlb_range(vma, start, end);
> +
> +out_unlock:
> +       spin_unlock(ptl);
> +       i_mmap_unlock_write(vma->vm_file->f_mapping);
> +
> +       return ret;
> +}

....

> +static int pagemap_scan_get_args(struct pm_scan_arg *arg,
> +                                unsigned long uarg)
> +{
> +       if (copy_from_user(arg, (void __user *)uarg, sizeof(*arg)))
> +               return -EFAULT;
> +
> +       if (arg->size !=3D sizeof(struct pm_scan_arg))
> +               return -EINVAL;
> +
> +       /* Validate requested features */
> +       if (arg->flags & ~PM_SCAN_FLAGS)
> +               return -EINVAL;
> +       if ((arg->category_inverted | arg->category_mask |
> +            arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATE=
GORIES)
> +               return -EINVAL;
> +
> +       arg->start =3D untagged_addr((unsigned long)arg->start);
> +       arg->end =3D untagged_addr((unsigned long)arg->end);
> +       arg->vec =3D untagged_addr((unsigned long)arg->vec);
> +
> +       /* Validate memory pointers */
> +       if (!IS_ALIGNED(arg->start, PAGE_SIZE))
> +               return -EINVAL;
> +       if (!access_ok((void __user *)arg->start, arg->end - arg->start))
> +               return -EFAULT;
> +       if (!arg->vec && arg->vec_len)
> +               return -EFAULT;

It looks more like EINVAL.

> +       if (arg->vec && !access_ok((void __user *)arg->vec,
> +                             arg->vec_len * sizeof(struct page_region)))
> +               return -EFAULT;
> +
> +       /* Fixup default values */
> +       arg->end =3D ALIGN(arg->end, PAGE_SIZE);
> +       if (!arg->max_pages)
> +               arg->max_pages =3D ULONG_MAX;
> +
> +       return 0;
> +}
> +

Thanks,
Andrei
