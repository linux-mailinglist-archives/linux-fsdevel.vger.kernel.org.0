Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD31369CC06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 14:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjBTNZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 08:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjBTNY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:24:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF101CF58;
        Mon, 20 Feb 2023 05:24:38 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B2486602161;
        Mon, 20 Feb 2023 13:24:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676899476;
        bh=eJp8f4kanDPWGSQe+bMtrvT/jqX6oyYHC55MjjLktIo=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Kvv8nVHUURBXJiFUqceF/KeOBdYEAFiTVU82yNKEOAdQPG3gktOmBQsZfHs/zBuv9
         yzVl3dHR0fwFjtjjpEaQPgqRi0tW5H2ezvAmD5mcoHGxhvG8gCwDu0cXh7qdFQLGez
         S3mvU/U3cOJYLAfb7dmommCdwnqZFq8ClkjnHaovGGiB0p/CcJ9O67g0d4mZ5S2NUW
         h6Ztr/JVhYfZxRP757YNMyJ6azcz3ZvEW5c1HhrQU57JL6eOZBWmk4r946fpT85ng/
         aQpROqQk+ohTOJEPHZrWxlOkM9uM84q7Z8o/PTxbJZhFBDf0Xx/RocvVKKfoWHpPoB
         uWrCuOcdbys0A==
Message-ID: <2fe790e5-89e0-d660-79cb-15160dffd907@collabora.com>
Date:   Mon, 20 Feb 2023 18:24:24 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Cyrill Gorcunov <gorcunov@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <cf36b6ea-6268-deff-d9ed-6782de2bd0a7@gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <cf36b6ea-6268-deff-d9ed-6782de2bd0a7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Nadav,

Thank you so much for reviewing!

On 2/19/23 6:52 PM, Nadav Amit wrote:
> 
> On 2/2/23 1:29 PM, Muhammad Usama Anjum wrote:
>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>> the info about page table entries. The following operations are supported
>> in this ioctl:
>> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>>    file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>>    (PAGE_IS_SWAPPED).
>> - Write-protect the pages (PAGEMAP_WP_ENGAGE) to start finding which
>>    pages have been written-to.
>> - Find pages which have been written-to and write protect the pages
>>    (atomic PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE)
>>
>> To get information about which pages have been written-to and/or write
>> protect the pages, following must be performed first in order:
>> - The userfaultfd file descriptor is created with userfaultfd syscall.
>> - The UFFD_FEATURE_WP_ASYNC feature is set by UFFDIO_API IOCTL.
>> - The memory range is registered with UFFDIO_REGISTER_MODE_WP mode
>>    through UFFDIO_REGISTER IOCTL.
>> Then the any part of the registered memory or the whole memory region
>> can be write protected using the UFFDIO_WRITEPROTECT IOCTL or
>> PAGEMAP_SCAN IOCTL.
>>
>> struct pagemap_scan_args is used as the argument of the IOCTL. In this
>> struct:
>> - The range is specified through start and len.
>> - The output buffer of struct page_region array and size is specified as
>>    vec and vec_len.
>> - The optional maximum requested pages are specified in the max_pages.
>> - The flags can be specified in the flags field. The PAGEMAP_WP_ENGAGE
>>    is the only added flag at this time.
>> - The masks are specified in required_mask, anyof_mask, excluded_ mask
>>    and return_mask.
>>
>> This IOCTL can be extended to get information about more PTE bits. This
>> IOCTL doesn't support hugetlbs at the moment. No information about
>> hugetlb can be obtained. This patch has evolved from a basic patch from
>> Gabriel Krisman Bertazi.
> 
> I was not involved before, so I am not commenting on the API and code to
> avoid making unhelpful noise.
> 
> Having said that, some things in the code seem quite dirty and make
> understanding the code hard to read.
There is a new proposal about the flags in the interface. I'll include you
there.

> 
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes in v10:
>> - move changes in tools/include/uapi/linux/fs.h to separate patch
>> - update commit message
>>
>> Change in v8:
>> - Correct is_pte_uffd_wp()
>> - Improve readability and error checks
>> - Remove some un-needed code
>>
>> Changes in v7:
>> - Rebase on top of latest next
>> - Fix some corner cases
>> - Base soft-dirty on the uffd wp async
>> - Update the terminologies
>> - Optimize the memory usage inside the ioctl
>>
>> Changes in v6:
>> - Rename variables and update comments
>> - Make IOCTL independent of soft_dirty config
>> - Change masks and bitmap type to _u64
>> - Improve code quality
>>
>> Changes in v5:
>> - Remove tlb flushing even for clear operation
>>
>> Changes in v4:
>> - Update the interface and implementation
>>
>> Changes in v3:
>> - Tighten the user-kernel interface by using explicit types and add more
>>    error checking
>>
>> Changes in v2:
>> - Convert the interface from syscall to ioctl
>> - Remove pidfd support as it doesn't make sense in ioctl
>> ---
>>   fs/proc/task_mmu.c      | 290 ++++++++++++++++++++++++++++++++++++++++
>>   include/uapi/linux/fs.h |  50 +++++++
>>   2 files changed, 340 insertions(+)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index e35a0398db63..c6bde19d63d9 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/shmem_fs.h>
>>   #include <linux/uaccess.h>
>>   #include <linux/pkeys.h>
>> +#include <linux/minmax.h>
>>     #include <asm/elf.h>
>>   #include <asm/tlb.h>
>> @@ -1135,6 +1136,22 @@ static inline void clear_soft_dirty(struct
>> vm_area_struct *vma,
>>   }
>>   #endif
>>   +static inline bool is_pte_uffd_wp(pte_t pte)
>> +{
>> +    if ((pte_present(pte) && pte_uffd_wp(pte)) ||
>> +        (pte_swp_uffd_wp_any(pte)))
>> +        return true;
>> +    return false;
>> +}
>> +
>> +static inline bool is_pmd_uffd_wp(pmd_t pmd)
>> +{
>> +    if ((pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
>> +        (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd)))
>> +        return true;
>> +    return false;
>> +}
>> +
>>   #if defined(CONFIG_MEM_SOFT_DIRTY) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
>>   static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
>>           unsigned long addr, pmd_t *pmdp)
>> @@ -1763,11 +1780,284 @@ static int pagemap_release(struct inode *inode,
>> struct file *file)
>>       return 0;
>>   }
>>   +#define PAGEMAP_BITS_ALL        (PAGE_IS_WRITTEN | PAGE_IS_FILE |    \
>> +                     PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
>> +#define PAGEMAP_NON_WRITTEN_BITS    (PAGE_IS_FILE |    PAGE_IS_PRESENT |
>> PAGE_IS_SWAPPED)
>> +#define IS_WP_ENGAGE_OP(a)        (a->flags & PAGEMAP_WP_ENGAGE)
>> +#define IS_GET_OP(a)            (a->vec)
>> +#define HAS_NO_SPACE(p)            (p->max_pages && (p->found_pages ==
>> p->max_pages))
> 
> I think that in general it is better to have an inline function instead of
> macros when possible, as it is clearer and checks types. Anyhow, IMHO most
> of these macros are better be open-coded.
I'll update most of these in next version.

> 
>> +
>> +#define PAGEMAP_SCAN_BITMAP(wt, file, present, swap)    \
>> +    (wt | file << 1 | present << 2 | swap << 3)
>> +#define IS_WT_REQUIRED(a)                \
>> +    ((a->required_mask & PAGE_IS_WRITTEN) ||    \
>> +     (a->anyof_mask & PAGE_IS_WRITTEN))
>> +
>> +struct pagemap_scan_private {
>> +    struct page_region *vec;
>> +    struct page_region prev;
>> +    unsigned long vec_len, vec_index;
>> +    unsigned int max_pages, found_pages, flags;
>> +    unsigned long required_mask, anyof_mask, excluded_mask, return_mask;
>> +};
>> +
>> +static int pagemap_scan_test_walk(unsigned long start, unsigned long
>> end, struct mm_walk *walk)
>> +{
>> +    struct pagemap_scan_private *p = walk->private;
>> +    struct vm_area_struct *vma = walk->vma;
>> +
>> +    if (IS_WT_REQUIRED(p) && !userfaultfd_wp(vma) &&
>> !userfaultfd_wp_async(vma))
>> +        return -EPERM;
>> +    if (vma->vm_flags & VM_PFNMAP)
>> +        return 1;
>> +    return 0;
>> +}
>> +
>> +static inline int pagemap_scan_output(bool wt, bool file, bool pres,
>> bool swap,
>> +                      struct pagemap_scan_private *p, unsigned long addr,
>> +                      unsigned int len)
>> +{
>> +    unsigned long bitmap, cur = PAGEMAP_SCAN_BITMAP(wt, file, pres, swap);
>> +    bool cpy = true;
>> +    struct page_region *prev = &p->prev;
>> +
>> +    if (HAS_NO_SPACE(p))
>> +        return -ENOSPC;
>> +
>> +    if (p->max_pages && p->found_pages + len >= p->max_pages)
>> +        len = p->max_pages - p->found_pages;
>> +    if (!len)
>> +        return -EINVAL;
>> +
>> +    if (p->required_mask)
>> +        cpy = ((p->required_mask & cur) == p->required_mask);
>> +    if (cpy && p->anyof_mask)
>> +        cpy = (p->anyof_mask & cur);
>> +    if (cpy && p->excluded_mask)
>> +        cpy = !(p->excluded_mask & cur);
>> +    bitmap = cur & p->return_mask;
>> +    if (cpy && bitmap) {
>> +        if ((prev->len) && (prev->bitmap == bitmap) &&
>> +            (prev->start + prev->len * PAGE_SIZE == addr)) {
>> +            prev->len += len;
> The use of "len" both for bytes and pages is very confusing. Consider
> changing the name to n_pages or something similar.
Will update in next version.

>> +            p->found_pages += len;
>> +        } else if (p->vec_index < p->vec_len) {
>> +            if (prev->len) {
>> +                memcpy(&p->vec[p->vec_index], prev, sizeof(struct
>> page_region));
>> +                p->vec_index++;
>> +            }
>> +            prev->start = addr;
>> +            prev->len = len;
>> +            prev->bitmap = bitmap;
>> +            p->found_pages += len;
>> +        } else {
>> +            return -ENOSPC;
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>> +static inline int export_prev_to_out(struct pagemap_scan_private *p,
>> struct page_region __user *vec,
>> +                     unsigned long *vec_index)
>> +{
>> +    struct page_region *prev = &p->prev;
>> +
>> +    if (prev->len) {
>> +        if (copy_to_user(&vec[*vec_index], prev, sizeof(struct
>> page_region)))
>> +            return -EFAULT;
>> +        p->vec_index++;
>> +        (*vec_index)++;
>> +        prev->len = 0;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static inline int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>> +                     unsigned long end, struct mm_walk *walk)
>> +{
>> +    struct pagemap_scan_private *p = walk->private;
>> +    struct vm_area_struct *vma = walk->vma;
>> +    unsigned long addr = end;
>> +    spinlock_t *ptl;
>> +    int ret = 0;
>> +    pte_t *pte;
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +    ptl = pmd_trans_huge_lock(pmd, vma);
>> +    if (ptl) {
>> +        bool pmd_wt;
>> +
>> +        pmd_wt = !is_pmd_uffd_wp(*pmd);
>> +        /*
>> +         * Break huge page into small pages if operation needs to be
>> performed is
>> +         * on a portion of the huge page.
>> +         */
>> +        if (pmd_wt && IS_WP_ENGAGE_OP(p) && (end - start < HPAGE_SIZE)) {
>> +            spin_unlock(ptl);
>> +            split_huge_pmd(vma, pmd, start);
>> +            goto process_smaller_pages;
> I think that such goto's are really confusing and should be avoided. And
> using 'else' (could have easily prevented the need for goto). It is not the
> best solution though, since I think it would have been better to invert the
> conditions.
Yeah, else can be used here. But then we'll have to add a tab to all the
code after adding else. We have already so many tabs and very less space to
right code. Not sure which is better.

>> +        }
>> +        if (IS_GET_OP(p))
>> +            ret = pagemap_scan_output(pmd_wt, vma->vm_file,
>> pmd_present(*pmd),
>> +                          is_swap_pmd(*pmd), p, start,
>> +                          (end - start)/PAGE_SIZE);
>> +        spin_unlock(ptl);
>> +        if (!ret) {
>> +            if (pmd_wt && IS_WP_ENGAGE_OP(p))
>> +                uffd_wp_range(walk->mm, vma, start, HPAGE_SIZE, true);
>> +        }
>> +        return ret;
>> +    }
>> +process_smaller_pages:
>> +    if (pmd_trans_unstable(pmd))
>> +        return 0;
>> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> +
>> +    pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
>> +    if (IS_GET_OP(p)) {
>> +        for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
>> +            ret = pagemap_scan_output(!is_pte_uffd_wp(*pte), vma->vm_file,
>> +                          pte_present(*pte), is_swap_pte(*pte), p, addr,
>> 1);
>> +            if (ret)
>> +                break;
>> +        }
>> +    }
>> +    pte_unmap_unlock(pte - 1, ptl);
> We might have not entered the loop and pte-1 would be wrong.
>> +    if ((!ret || ret == -ENOSPC) && IS_WP_ENGAGE_OP(p) && (addr - start))
> What does 'addr - start' mean? If you want to say they are not equal, why
> not say so?
This has been revamped in the next version.

>> +        uffd_wp_range(walk->mm, vma, start, addr - start, true);
>> +
>> +    cond_resched();
>> +    return ret;
>> +}
>> +
>> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
>> int depth,
>> +                 struct mm_walk *walk)
>> +{
>> +    struct pagemap_scan_private *p = walk->private;
>> +    struct vm_area_struct *vma = walk->vma;
>> +    int ret = 0;
>> +
>> +    if (vma)
>> +        ret = pagemap_scan_output(false, vma->vm_file, false, false, p,
>> addr,
>> +                      (end - addr)/PAGE_SIZE);
>> +    return ret;
>> +}
>> +
>> +/* No hugetlb support is present. */
>> +static const struct mm_walk_ops pagemap_scan_ops = {
>> +    .test_walk = pagemap_scan_test_walk,
>> +    .pmd_entry = pagemap_scan_pmd_entry,
>> +    .pte_hole = pagemap_scan_pte_hole,
>> +};
>> +
>> +static long do_pagemap_cmd(struct mm_struct *mm, struct pagemap_scan_arg
>> *arg)
>> +{
>> +    unsigned long empty_slots, vec_index = 0;
>> +    unsigned long __user start, end;
> 
> The whole point of __user (attribute) is to be assigned to pointers.
I'll remove it.

> 
>> +    unsigned long __start, __end;
> 
> I think such names do not convey sufficient information.
I'll update it.

> 
>> +    struct page_region __user *vec;
>> +    struct pagemap_scan_private p;
>> +    int ret = 0;
>> +
>> +    start = (unsigned long)untagged_addr(arg->start);
>> +    vec = (struct page_region *)(unsigned long)untagged_addr(arg->vec);
>> +
>> +    /* Validate memory ranges */
>> +    if ((!IS_ALIGNED(start, PAGE_SIZE)) || (!access_ok((void __user
>> *)start, arg->len)))
>> +        return -EINVAL;
>> +    if (IS_GET_OP(arg) && ((arg->vec_len == 0) ||
>> +        (!access_ok((void __user *)vec, arg->vec_len * sizeof(struct
>> page_region)))))
>> +        return -EINVAL;
>> +
>> +    /* Detect illegal flags and masks */
>> +    if ((arg->flags & ~PAGEMAP_WP_ENGAGE) || (arg->required_mask &
>> ~PAGEMAP_BITS_ALL) ||
>> +        (arg->anyof_mask & ~PAGEMAP_BITS_ALL) || (arg->excluded_mask &
>> ~PAGEMAP_BITS_ALL) ||
>> +        (arg->return_mask & ~PAGEMAP_BITS_ALL))
> 
> Using bitwise or to check
> 
>     (arg->required_mask | arg->anyof_mask |
>      arg->excluded_mask | arg->return_mask) & ~PAGE_MAP_BITS_ALL
> 
> Would have been much cleaner, IMHO.
I'll update it.

> 
>> +        return -EINVAL;
>> +    if (IS_GET_OP(arg) && ((!arg->required_mask && !arg->anyof_mask &&
>> !arg->excluded_mask) ||
>> +                !arg->return_mask))
>> +        return -EINVAL;
>> +    /* The non-WT flags cannot be obtained if PAGEMAP_WP_ENGAGE is also
>> specified. */
>> +    if (IS_WP_ENGAGE_OP(arg) && ((arg->required_mask &
>> PAGEMAP_NON_WRITTEN_BITS) ||
>> +        (arg->anyof_mask & PAGEMAP_NON_WRITTEN_BITS)))
>> +        return -EINVAL;
>> +
>> +    end = start + arg->len;
>> +    p.max_pages = arg->max_pages;
>> +    p.found_pages = 0;
>> +    p.flags = arg->flags;
>> +    p.required_mask = arg->required_mask;
>> +    p.anyof_mask = arg->anyof_mask;
>> +    p.excluded_mask = arg->excluded_mask;
>> +    p.return_mask = arg->return_mask;
>> +    p.prev.len = 0;
>> +    p.vec_len = (PAGEMAP_WALK_SIZE >> PAGE_SHIFT);
>> +
>> +    if (IS_GET_OP(arg)) {
>> +        p.vec = kmalloc_array(p.vec_len, sizeof(struct page_region),
>> GFP_KERNEL);
>> +        if (!p.vec)
>> +            return -ENOMEM;
>> +    } else {
>> +        p.vec = NULL;
> I find it cleaner to initialize 'p.vec = NULL' unconditionally before
> IS_GET_OP() check.
It'll get updated.

>> +    }
>> +    __start = __end = start;
>> +    while (!ret && __end < end) {
>> +        p.vec_index = 0;
>> +        empty_slots = arg->vec_len - vec_index;
>> +        if (p.vec_len > empty_slots)
>> +            p.vec_len = empty_slots;
>> +
>> +        __end = (__start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
>> +        if (__end > end)
>> +            __end = end;
> Easier to understand using min().
Will update.

>> +
>> +        mmap_read_lock(mm);
>> +        ret = walk_page_range(mm, __start, __end, &pagemap_scan_ops, &p);
>> +        mmap_read_unlock(mm);
>> +        if (!(!ret || ret == -ENOSPC))
> 
> Double negations complicate things unnecessarily.
> 
> And if you already "break" on ret, why do you check the condition in the
> while loop?
Ohh, good catch.

> 
>> +            goto free_data;
>> +
>> +        __start = __end;
>> +        if (IS_GET_OP(arg) && p.vec_index) {
>> +            if (copy_to_user(&vec[vec_index], p.vec,
>> +                     p.vec_index * sizeof(struct page_region))) {
>> +                ret = -EFAULT;
>> +                goto free_data;
>> +            }
>> +            vec_index += p.vec_index;
>> +        }
>> +    }
>> +    ret = export_prev_to_out(&p, vec, &vec_index);
>> +    if (!ret)
>> +        ret = vec_index;
>> +free_data:
>> +    if (IS_GET_OP(arg))
>> +        kfree(p.vec);
> Just call it unconditionally.
I didn't know it. I'll do it.

>> +
>> +    return ret;
>> +}
>> +
>> +static long pagemap_scan_ioctl(struct file *file, unsigned int cmd,
>> unsigned long arg)
>> +{
>> +    struct pagemap_scan_arg __user *uarg = (struct pagemap_scan_arg
>> __user *)arg;
>> +    struct mm_struct *mm = file->private_data;
>> +    struct pagemap_scan_arg argument;
>> +
>> +    if (cmd == PAGEMAP_SCAN) {
>> +        if (copy_from_user(&argument, uarg, sizeof(struct
>> pagemap_scan_arg)))
>> +            return -EFAULT;
>> +        return do_pagemap_cmd(mm, &argument);
>> +    }
>> +    return -EINVAL;
>> +}
>> +
>>   const struct file_operations proc_pagemap_operations = {
>>       .llseek        = mem_lseek, /* borrow this */
>>       .read        = pagemap_read,
>>       .open        = pagemap_open,
>>       .release    = pagemap_release,
>> +    .unlocked_ioctl = pagemap_scan_ioctl,
>> +    .compat_ioctl    = pagemap_scan_ioctl,
>>   };
>>   #endif /* CONFIG_PROC_PAGE_MONITOR */
>>   diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
>> index b7b56871029c..1ae9a8684b48 100644
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -305,4 +305,54 @@ typedef int __bitwise __kernel_rwf_t;
>>   #define RWF_SUPPORTED    (RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>>                RWF_APPEND)
>>   +/* Pagemap ioctl */
>> +#define PAGEMAP_SCAN    _IOWR('f', 16, struct pagemap_scan_arg)
>> +
>> +/* Bits are set in the bitmap of the page_region and masks in
>> pagemap_scan_args */
>> +#define PAGE_IS_WRITTEN        (1 << 0)
>> +#define PAGE_IS_FILE        (1 << 1)
>> +#define PAGE_IS_PRESENT        (1 << 2)
>> +#define PAGE_IS_SWAPPED        (1 << 3)
> 
> These names are way too generic and are likely to be misused for the wrong
> purpose. The "_IS_" part seems confusing as well. So I think the naming
> needs to be fixed and some new type (using typedef) or enum should be
> introduced to hold these flags. I understand it is part of uapi and it is
> less common there, but it is not unheard of and does make things clearer.
Do you think PM_SCAN_PAGE_IS_* work here?

> 
> 
>> +
>> +/*
>> + * struct page_region - Page region with bitmap flags
>> + * @start:    Start of the region
>> + * @len:    Length of the region
>> + * bitmap:    Bits sets for the region
>> + */
>> +struct page_region {
>> +    __u64 start;
>> +    __u64 len;
> 
> I presume in bytes. Would be useful to mention.
Length of region in pages.

> 
>> +    __u64 bitmap;
>> +};
>> +
>> +/*
>> + * struct pagemap_scan_arg - Pagemap ioctl argument
>> + * @start:        Starting address of the region
>> + * @len:        Length of the region (All the pages in this length are
>> included)
>> + * @vec:        Address of page_region struct array for output
>> + * @vec_len:        Length of the page_region struct array
>> + * @max_pages:        Optional max return pages
>> + * @flags:        Flags for the IOCTL
>> + * @required_mask:    Required mask - All of these bits have to be set
>> in the PTE
>> + * @anyof_mask:        Any mask - Any of these bits are set in the PTE
>> + * @excluded_mask:    Exclude mask - None of these bits are set in the PTE
>> + * @return_mask:    Bits that are to be reported in page_region
>> + */
>> +struct pagemap_scan_arg {
>> +    __u64 start;
>> +    __u64 len;
>> +    __u64 vec;
>> +    __u64 vec_len;
>> +    __u32 max_pages;
>> +    __u32 flags;
>> +    __u64 required_mask;
>> +    __u64 anyof_mask;
>> +    __u64 excluded_mask;
>> +    __u64 return_mask;
>> +};
>> +
>> +/* Special flags */
>> +#define PAGEMAP_WP_ENGAGE    (1 << 0)
>> +
>>   #endif /* _UAPI_LINUX_FS_H */

-- 
BR,
Muhammad Usama Anjum
