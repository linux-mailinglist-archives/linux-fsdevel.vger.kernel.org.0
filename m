Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57DB6BD796
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 18:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjCPRyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 13:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCPRyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:54:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17AA3FBB7;
        Thu, 16 Mar 2023 10:53:36 -0700 (PDT)
Received: from [192.168.10.39] (unknown [39.37.168.222])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F8D966030A0;
        Thu, 16 Mar 2023 17:53:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678989198;
        bh=a+REsevWza3RGnvtEbF+s1mQmrHPT/HQ6uSGRFPBebI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=O4KxMNhR2x9Rc6Zycdizhg4o9RGSbsU35fk7k5wiu3K4Geq1NuGFapd4SapH9xhYK
         jDTwC12EWqqz4irQR9YPHfR9S/UAjmOQsSpf1NZyHvKwvH+e5GgbfJ0xLgeMcOSBVU
         VW0tVjH3EJ2gq/HiWi30ZgIe5YerqPMl0LTGwXlBvDW2sWl+FBVEdjx+NYJy5PW3hZ
         RAdDr0dueYyjmEpczSXir07FGAac2PjkbO+/GX4O6R+YLG7rdCQfSFoh6JKpy+iaZo
         0h8TBDMgdRNILohwwAjeyEybA2VKPUYzW6u5wGcsSsyRR5uNN+afqNkQYhZka7MGSY
         yxkvMGCDtemsw==
Message-ID: <3c8d9ea0-1382-be0c-8dd2-d490eedd3b55@collabora.com>
Date:   Thu, 16 Mar 2023 22:53:02 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v11 4/7] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-5-usama.anjum@collabora.com>
 <CABb0KFGU-jn4pCgmTK2zw0J-1-AVert4JsWF2CxgZ7LxckmWCA@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFGU-jn4pCgmTK2zw0J-1-AVert4JsWF2CxgZ7LxckmWCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Thank you so much for reviewing.

On 3/13/23 9:02 PM, Michał Mirosław wrote:
> On Thu, 9 Mar 2023 at 14:58, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>> the info about page table entries. The following operations are supported
>> in this ioctl:
>> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>>   (PAGE_IS_SWAPPED).
>> - Find pages which have been written-to and write protect the pages
>>   (atomic PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE)
> [...]
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/shmem_fs.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/pkeys.h>
>> +#include <linux/minmax.h>
>>
>>  #include <asm/elf.h>
>>  #include <asm/tlb.h>
>> @@ -1132,6 +1133,18 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
>>  }
>>  #endif
>>
>> +static inline bool is_pte_uffd_wp(pte_t pte)
>> +{
>> +       return ((pte_present(pte) && pte_uffd_wp(pte)) ||
>> +               (pte_swp_uffd_wp_any(pte)));
> 
> Parentheses around pte_swp_uffd_wp_any() are redundant. Please remove
> here and in all following if()s. (Nit: those extra parentheses are
> used inconsistently in the patch anyway.)
I'll remove these in next version.

> 
> [...]
>> +static inline bool pagemap_scan_is_wt_required(struct pagemap_scan_private *p)
> 
> This seems to check if the PAGE_IS_WRITTEN flag is tested, so
> "pagemap_scan_needs_wp_checks()"? Or maybe document/expand the "wt"
> acronym as it seems used also on following code.
I'll expand wt.

> 
>> +{
>> +       return  ((p->required_mask & PAGE_IS_WRITTEN) ||
>> +                (p->anyof_mask & PAGE_IS_WRITTEN) ||
>> +                (p->excluded_mask & PAGE_IS_WRITTEN));
> 
> Nit: It looks like it should answer "do any of the masks contain
> PAGE_IS_WRITTEN?" so maybe:
> 
> return (p->required_mask | p->anyof_mask | p->excluded_mask) & PAGE_IS_WRITTEN;
I'll update.

> 
> [...]
> 
>> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
>> +                              struct pagemap_scan_private *p,
>> +                              unsigned long addr, unsigned int n_pages)
>> +{
>> +       unsigned long bitmap = PM_SCAN_BITMAP(wt, file, pres, swap);
>> +       struct page_region *cur = &p->cur;
>> +       bool cpy = true;
>> +
>> +       if (p->max_pages && (p->found_pages == p->max_pages))
>> +               return -ENOSPC;
>> +
>> +       if (!n_pages)
>> +               return -EINVAL;
>> +
>> +       if (p->required_mask)
>> +               cpy = ((p->required_mask & bitmap) == p->required_mask);
>> +       if (cpy && p->anyof_mask)
>> +               cpy = (p->anyof_mask & bitmap);
>> +       if (cpy && p->excluded_mask)
>> +               cpy = !(p->excluded_mask & bitmap);
> 
> Since the rest of the code is executed only when `cpy` is true, this
> could just return early for easier understanding.
Hmm... I'll do the following:
	if (!cpy || !bitmap)
		return 0;

> 
> BTW, some of the tests are redundant. Eg: if required_mask == 0, then
> `required_mask & x == required_mask` will always hold. Same for
> `excluded_mask & x == 0`.
Correct. This is why I'm checking if required_mask is set and then
comparing bitmap with it. required_mask may be 0 if not set. This if will
ignore the subsequent check.

	if (p->required_mask)
		cpy = ((p->required_mask & bitmap) == p->required_mask);

I don't see any redundancy here. Please let me know otherwise?

> 
>> +
>> +       bitmap = bitmap & p->return_mask;
> 
> Nit: bitmap &= p->return_mask;
Sure. Will do.

Just for my knowledge, what does "Nit" signify if a comment is marked with it?

> 
>> +       if (cpy && bitmap) {
> 
> Assuming early returns on `!cpy` are done earlier:
> 
> if (!bitmap)
>   return 0;
I've posted condition above which would better suit here.

> 
>> +               if ((cur->len) && (cur->bitmap == bitmap) &&
>> +                   (cur->start + cur->len * PAGE_SIZE == addr)) {
> 
> I'd recommend removing the extra parentheses as they make the code
> less readable for me (too many parentheses to match visually).
I'll remove parenthesis.

> The `cur->len` test seems redundant: is it possible to have
> `cur->start == addr` in that case (I guess it would have to get
> `n_pages == 0` in an earlier invocation)?
No, both wouldn't work. cur->len == 0 means that it has only garbage. It is
essential to check the validity from cur->len before performing other
checks. Also cur->start can never be equal to addr as we are walking over
page addressing in serial manner. We want to see here if the current
address matches the previous data by finding the ending address of last
stored data (cur->start + cur->len * PAGE_SIZE).

> 
>> +
>> +                       cur->len += n_pages;
>> +                       p->found_pages += n_pages;
> 
> Please add an early return so that 'else' chaining won't be necessary.
I'll do it.

> 
>> +               } else if ((!p->vec_index) ||
>> +                          ((p->vec_index + 1) < p->vec_len)) {
> 
> Can you explain this test? Why not just `p->vec_index < p->vec_len`? Or better:
> 
> if (vec_index >= p->vec_len)
>     return -ENOSPC;

No, it'll not work. Lets leave it as it is. :)

It has gotten somewhat complex, but I don't have any other way to make it
simpler which works. First note the following points:
1) We walk over 512 page or 1 thp at a time to not over allocate memory in
kernel (p->vec).
2) We also want to merge the consective pages with same flags into one
struct page_region. p->vec of current walk may merge with next walk. So we
cannot write to user memory until we find the results of the next walk.

So most recent data is put into p->cur. When non-intersecting or mergeable
data is found, we move p->cur to p->vec[p->index] inside the page walk.
After the page walk, p->vec[0 to p->index] is moved to arg->vec. After all
the walks are over. We move the p->cur to arg->vec. It completes the data
transfer to user buffer.

	--------------
	|   p->cur   |
	--------------
	      |
	      |
	      V
	--------------
	|	     |
	|	     |
	|   p->vec   |
	|	     |
	|	     |
	--------------
	      |
	      |
	      V
	--------------
	|	     |
	|	     |
	|	     |
	|  arg->vec  |
	|	     |
	|	     |
	|	     |
	--------------


I'm so sorry that it has gotten this much complex. It was way simpler when
we were walking over all the memory in one go. But then we needed an
unbounded memory from the kernel which we don't want.

> 
>> +                       if (cur->len) {
>> +                               memcpy(&p->vec[p->vec_index], cur,
>> +                                      sizeof(struct page_region));
>> +                               p->vec_index++;
>> +                       }
>> +
>> +                       cur->start = addr;
>> +                       cur->len = n_pages;
>> +                       cur->bitmap = bitmap;
>> +                       p->found_pages += n_pages;
>> +               } else {
>> +                       return -ENOSPC;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
> [...]
> 
>> +static int pagemap_scan_deposit(struct pagemap_scan_private *p,
>> +                               struct page_region __user *vec,
>> +                               unsigned long *vec_index)
>> +{
>> +       struct page_region *cur = &p->cur;
>> +
>> +       if (cur->len) {
> 
> if (!cur->len)
>   return 0;
Sure.

> 
>> +               if (copy_to_user(&vec[*vec_index], cur,
>> +                                sizeof(struct page_region)))
>> +                       return -EFAULT;
>> +
>> +               p->vec_index++;
>> +               (*vec_index)++;
>> +       }
>> +
>> +       return 0;
>> +}
> 
>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>> +                                 unsigned long end, struct mm_walk *walk)
>> +{
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       bool is_writ, is_file, is_pres, is_swap;
>> +       unsigned long addr = end;
>> +       spinlock_t *ptl;
>> +       int ret = 0;
>> +       pte_t *pte;
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> 
> Is the `#ifdef` needed? `pmd_trans_huge_lock()` will always return
> NULL if transparent hugepages are not compiled in. OTOH I see
> BUILD_BUG() is possible in HPAGE_SIZE definition (irrelevant in this
> case), so that would need to be worked around first.
I'd got the build error [1]. So I'd added these. I've tested it again with
the same config. We don't need these #ifdef now. I'll remove these.

[1] https://lore.kernel.org/all/202211120107.cYLiq2cH-lkp@intel.com

> 
>> +       ptl = pmd_trans_huge_lock(pmd, vma);
>> +       if (ptl) {
>> +               unsigned long n_pages;
>> +
>> +               is_writ = !is_pmd_uffd_wp(*pmd);
> 
> `is_written`?
I'd kept it is_writ to match the pattern of is_file, is_pres and is_swap.
I'll update it to is_written and is_pres to is_present.

> 
>> +               /*
>> +                * Break huge page into small pages if operation needs to be
>> +                * performed is on a portion of the huge page.
>> +                */
>> +               if (is_writ && PM_SCAN_OP_IS_WP(p) &&
>> +                   (end - start < HPAGE_SIZE)) {
>> +                       spin_unlock(ptl);
>> +
>> +                       split_huge_pmd(vma, pmd, start);
>> +                       goto process_smaller_pages;
>> +               }
>> +
>> +               n_pages = (end - start)/PAGE_SIZE;
>> +               if (p->max_pages &&
>> +                   p->found_pages + n_pages >= p->max_pages)
> 
> Nit: greater-than is also correct and avoids no-op assignment.
Ohh... I'll update.

> 
>> +                       n_pages = p->max_pages - p->found_pages;
>> +
>> +               ret = pagemap_scan_output(is_writ, vma->vm_file,
>> +                                         pmd_present(*pmd), is_swap_pmd(*pmd),
>> +                                         p, start, n_pages);
>> +               spin_unlock(ptl);
> 
> if (ret || !is_written)
>   return ret;
> 
> This will avoid those tests in the following if().
Done.

> 
>> +
>> +               if (!ret && is_writ && PM_SCAN_OP_IS_WP(p) &&
>> +                   uffd_wp_range(walk->mm, vma, start, HPAGE_SIZE, true) < 0)
>> +                       ret = -EINVAL;
>> +
>> +               return ret;
> 
> After above early returns, this will be always `return 0;`.
Sure.

> 
>> +       }
>> +process_smaller_pages:
>> +       if (pmd_trans_unstable(pmd))
>> +               return 0;
>> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> +
>> +       for (addr = start; !ret && addr < end; pte++, addr += PAGE_SIZE) {
> 
> The `!ret` can be removed if the EINVAL case was to `break` by itself.
Sure. Will do.

> 
>> +               pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>> +
>> +               is_writ = !is_pte_uffd_wp(*pte);
>> +               is_file = vma->vm_file;
>> +               is_pres = pte_present(*pte);
>> +               is_swap = is_swap_pte(*pte);
>> +
>> +               pte_unmap_unlock(pte, ptl);
>> +
>> +               ret = pagemap_scan_output(is_writ, is_file, is_pres, is_swap,
>> +                                         p, addr, 1);
>> +               if (ret)
>> +                       break;
>> +
>> +               if (PM_SCAN_OP_IS_WP(p) && is_writ &&
>> +                   uffd_wp_range(walk->mm, vma, addr, PAGE_SIZE, true) < 0)
>> +                       ret = -EINVAL;
>> +       }
>> +
>> +       cond_resched();
>> +       return ret;
>> +}
>> +
>> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
>> +                                int depth, struct mm_walk *walk)
>> +{
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       unsigned long n_pages;
>> +       int ret = 0;
>> +
>> +       if (vma) {
> 
> if (!vma) return 0;
Will do.

> 
>> +               n_pages = (end - addr)/PAGE_SIZE;
>> +               if (p->max_pages &&
>> +                   p->found_pages + n_pages >= p->max_pages)
>> +                       n_pages = p->max_pages - p->found_pages;
>> +
>> +               ret = pagemap_scan_output(false, vma->vm_file, false, false, p,
>> +                                         addr, n_pages);
>> +       }
>> +
>> +       return ret;
>> +}
> 
> 
>> +/* No hugetlb support is present. */
> 
> "FIXME: hugetlb support is not implemented."? (There seems to be no
> #ifdef CONFIG_HUGETLB or similar, so I guess the comment is about the
> current implementation.)
I'm working on adding hugetlb support. I'll remove this comment.

> 
>> +static const struct mm_walk_ops pagemap_scan_ops = {
>> +       .test_walk = pagemap_scan_test_walk,
>> +       .pmd_entry = pagemap_scan_pmd_entry,
>> +       .pte_hole = pagemap_scan_pte_hole,
>> +};
>> +
>> +static bool pagemap_scan_args_valid(struct pm_scan_arg *arg,
>> +                                   struct page_region __user *vec,
>> +                                   unsigned long start)
>> +{
>> +       /* Detect illegal size, flags and masks */
>> +       if (arg->size != sizeof(struct pm_scan_arg))
>> +               return false;
>> +       if (arg->flags & ~PM_SCAN_OPS)
>> +               return false;
>> +       if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask |
>> +            arg->return_mask) & ~PM_SCAN_BITS_ALL)
>> +               return false;
> 
>> +       if (!arg->required_mask && !arg->anyof_mask &&
>> +           !arg->excluded_mask)
>> +               return false;
> 
> Is there an assumption in the code that those checks are needed? I'd
> expect that no selection criteria makes a valid page set?
In my view, selection criterion must be specified for the ioctl to work. If
there is no criterio, user should go and read pagemap file directly. So the
assumption is that at least one selection criterion must be specified.

> 
>> +       if (!arg->return_mask)
>> +               return false;
>> +
>> +       /* Validate memory ranges */
>> +       if (!(arg->flags & PM_SCAN_OP_GET))
>> +               return false;
>> +       if (!arg->vec)
>> +               return false;
>> +       if (arg->vec_len == 0)
>> +               return false;
> 
>> +       if (!access_ok((void __user *)vec,
>> +                      arg->vec_len * sizeof(struct page_region)))
>> +               return false;
> 
> Is there a provision that userspace threads are all blocked from
> manipulating mmaps during this ioctl()? If not, this is a TOCTOU bug
> and the writes should be checked each time as another userspace thread
> could remap the memory while the ioctl() is working.
mincore() syscall is doing in the same way. It checks the validity in the
start only. What provision should I add? Isn't it obvious that the user
should not remap such memory?

> Anyway, the
> return should be EFAULT for this case.
I'll update.

> 
>> +       if (!IS_ALIGNED(start, PAGE_SIZE))
>> +               return false;
>> +       if (!access_ok((void __user *)start, arg->len))
>> +               return false;
> 
> This I guess want's to check if the range to be scanned is mapped -
> but isn't this what the ioctl() should do during the scan? (But, also
> see above.)
No, start represents the memory which the user wants to watch. User must
allocate this memory first and then pass the address to this ioctl to find
out the flags per page.

> 
>> +       if (PM_SCAN_OP_IS_WP(arg)) {
> 
> if (!...IS_WP) return true;
I was liking this way. Anyways I'll update.

> 
>> +               if (arg->required_mask & PM_SCAN_NON_WT_BITS)
>> +                       return false;
>> +               if (arg->anyof_mask & PM_SCAN_NON_WT_BITS)
>> +                       return false;
>> +               if (arg->excluded_mask & PM_SCAN_NON_WT_BITS)
>> +                       return false;
> 
> Please see: pagemap_scan_is_wt_required comment. Also, it seems this
> constant is used only here, so ~PAGE_IS_WRITTEN might be enough?
Yup, I'll update.

> 
> [...]
>> +static long do_pagemap_cmd(struct mm_struct *mm, struct pm_scan_arg *arg)
>> +{
>> +       unsigned long start, end, walk_start, walk_end;
>> +       unsigned long empty_slots, vec_index = 0;
>> +       struct page_region __user *vec;
>> +       struct pagemap_scan_private p;
>> +       int ret = 0;
>> +
>> +       start = (unsigned long)untagged_addr(arg->start);
>> +       vec = (struct page_region *)(unsigned long)untagged_addr(arg->vec);
>> +
>> +       if (!pagemap_scan_args_valid(arg, vec, start))
>> +               return -EINVAL;
>> +
>> +       end = start + arg->len;
>> +       p.max_pages = arg->max_pages;
>> +       p.found_pages = 0;
>> +       p.flags = arg->flags;
>> +       p.required_mask = arg->required_mask;
>> +       p.anyof_mask = arg->anyof_mask;
>> +       p.excluded_mask = arg->excluded_mask;
>> +       p.return_mask = arg->return_mask;
>> +       p.cur.len = 0;
>> +       p.vec = NULL;
>> +       p.vec_len = (PAGEMAP_WALK_SIZE >> PAGE_SHIFT);
>> +
>> +       /*
>> +        * Allocate smaller buffer to get output from inside the page walk
>> +        * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
>> +        * we want to return output to user in compact form where no two
>> +        * consecutive regions should be continuous and have the same flags.
>> +        * So store the latest element in p.cur between different walks and
>> +        * store the p.cur at the end of the walk to the user buffer.
>> +        */
>> +       p.vec = kmalloc_array(p.vec_len, sizeof(struct page_region),
>> +                             GFP_KERNEL);
>> +       if (!p.vec)
>> +               return -ENOMEM;
>> +
>> +       walk_start = walk_end = start;
>> +       while (walk_end < end) {
>> +               p.vec_index = 0;
>> +
>> +               empty_slots = arg->vec_len - vec_index;
>> +               p.vec_len = min(p.vec_len, empty_slots);
>> +
>> +               walk_end = (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
>> +               if (walk_end > end)
>> +                       walk_end = end;
>> +
>> +               mmap_read_lock(mm);
>> +               ret = walk_page_range(mm, walk_start, walk_end,
>> +                                     &pagemap_scan_ops, &p);
>> +               mmap_read_unlock(mm);
>> +
>> +               if (!(!ret || ret == -ENOSPC))
> 
> if (ret && ret != -ENOSPC)
Sorry, I should have thought of this one. Thanks.

> 
>> +                       goto free_data;
>> +
>> +               walk_start = walk_end;
>> +               if (p.vec_index) {
>> +                       if (copy_to_user(&vec[vec_index], p.vec,
>> +                                        p.vec_index *
>> +                                        sizeof(struct page_region))) {
>> +                               ret = -EFAULT;
>> +                               goto free_data;
>> +                       }
>> +                       vec_index += p.vec_index;
>> +               }
>> +       }
>> +       ret = pagemap_scan_deposit(&p, vec, &vec_index);
>> +       if (!ret)
>> +               ret = vec_index;
>> +free_data:
>> +       kfree(p.vec);
>> +
>> +       return ret;
>> +}
>> +
>> +static long pagemap_scan_ioctl(struct file *file, unsigned int cmd,
>> +                              unsigned long arg)
>> +{
>> +       struct pm_scan_arg __user *uarg = (struct pm_scan_arg __user *)arg;
>> +       struct mm_struct *mm = file->private_data;
>> +       struct pm_scan_arg argument;
>> +
>> +       if (cmd == PAGEMAP_SCAN) {
> 
> switch() for easier expansion later?
I'd switch here once. I'll add it again.

> 
>> +               if (copy_from_user(&argument, uarg,
>> +                                  sizeof(struct pm_scan_arg)))
> 
> sizeof(*argument);
> 
> Could you push this to do_pagemap_cmd()? In case this file gets more
> ioctl() commands there won't be need to add more command-specific
> structures in this function.
Sure, I'll update.

> 
>> +                       return -EFAULT;
>> +               return do_pagemap_cmd(mm, &argument);
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>> +
>>  const struct file_operations proc_pagemap_operations = {
>>         .llseek         = mem_lseek, /* borrow this */
>>         .read           = pagemap_read,
>>         .open           = pagemap_open,
>>         .release        = pagemap_release,
>> +       .unlocked_ioctl = pagemap_scan_ioctl,
>> +       .compat_ioctl   = pagemap_scan_ioctl,
> 
> Is this correct? Would the code need a different userspace pointer
> handling for 32-bit userspace on 64-bit kernel?
Yeah, it is needed for 32-bit application to run on 64-bit kernel.

> 
>>  };
>>  #endif /* CONFIG_PROC_PAGE_MONITOR */

-- 
BR,
Muhammad Usama Anjum
