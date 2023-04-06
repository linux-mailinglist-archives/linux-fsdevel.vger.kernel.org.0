Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB816D9F5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbjDFR6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 13:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDFR6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:58:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164368F;
        Thu,  6 Apr 2023 10:58:41 -0700 (PDT)
Received: from [192.168.10.39] (unknown [119.155.57.40])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F9A966031C3;
        Thu,  6 Apr 2023 18:58:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680803919;
        bh=iDHptxLrH6idtLyBiS7LT+XDwnK/m3agYt8Smg6/hz4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=OxNZsdEWCfq01riJrdhCPz2E5cG2FDqn6AYBagBBpt8BFdwsDbF5X3dyGzepGnEp4
         O8p8CKjBy12PaSMsDylduEJTG7kmHWJwhD5JQln4uxlglVL2MyV+IB6hRnP7Jxnt71
         6biVBO/5FVI2QnGLUp/Ce7cD33HwlYLPcNl7Mc5maing9KE3f2XauyyUxb9MmBvR9c
         fYkczFqQVTS3dXLy4sK+rRjAqgfWp9QPHH4pIsWnqfCoL0BdDkqlVj3AXT5XHj2bQ2
         7lrFsK/CwHikGFZd94AuN2KnwYV0xPXSlNIcuakcYk3SZgW9Z/uNaVGqEskgvTRsY4
         rDaAQl21xYlMQ==
Message-ID: <0351b563-5193-6431-aa9c-c5bf5741b791@collabora.com>
Date:   Thu, 6 Apr 2023 22:58:27 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
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
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
 <20230406074005.1784728-3-usama.anjum@collabora.com>
 <CABb0KFHZpYVML2e+Xg9+kwjyhqQkikPBhymO=EXoQnO2xjfG4g@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFHZpYVML2e+Xg9+kwjyhqQkikPBhymO=EXoQnO2xjfG4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Thank you so much for the review. Do you have any thoughts on the build
error on arc architecture?
https://lore.kernel.org/all/e3c82373-256a-6297-bcb4-5e1179a2cbe2@collabora.com

On 4/6/23 8:52 PM, Michał Mirosław wrote:
> On Thu, 6 Apr 2023 at 09:40, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:>
>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>> the info about page table entries. The following operations are supported
>> in this ioctl:
>> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>>   (PAGE_IS_SWAPPED).
>> - Find pages which have been written-to and write protect the pages
>>   (atomic PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE)
>>
>> This IOCTL can be extended to get information about more PTE bits.
> [...]
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
> [...]
>> +static inline bool is_pte_uffd_wp(pte_t pte)
>> +{
>> +       return ((pte_present(pte) && pte_uffd_wp(pte)) ||
>> +               pte_swp_uffd_wp_any(pte));
> 
> Nit: outer parentheses are not needed for `return`ed value -- please
> remove. (Same in other places.)
Will remove.

> 
>> @@ -1768,11 +1789,416 @@ static int pagemap_release(struct inode *inode, struct file *file)
>>         return 0;
>>  }
>>
>> +#define PM_SCAN_FOUND_MAX_PAGES        (1)
>> +#define PM_SCAN_BITS_ALL       (PAGE_IS_WRITTEN | PAGE_IS_FILE |       \
>> +                                PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
>> +#define PM_SCAN_OPS            (PM_SCAN_OP_GET | PM_SCAN_OP_WP)
>> +#define PM_SCAN_OP_IS_WP(a)    (a->flags & PM_SCAN_OP_WP)
> 
> Nit: PM_SCAN_DO_UFFD_WP()? It would shift the hint in the name from
> what op is executed to what behaviour is requested.
Will do.

> 
>> +#define PM_SCAN_BITMAP(wt, file, present, swap)        \
>> +       (wt | file << 1 | present << 2 | swap << 3)
> 
> Please parenthesize macro arguments ("(wt)", "(file)", etc.) to not
> have to worry about operator precedence when passed a complex
> expression.
Like this?
#define PM_SCAN_BITMAP(wt, file, present, swap)	\
	((wt) | (file << 1) | (present << 2) | (swap << 3))

> 
> I
> 
> [...]
>> +static inline bool pagemap_scan_is_written_set(struct pagemap_scan_private *p)
> 
> pagemap_scan_checks_page_written? or similar 'scan is written' doesn't
> seem to convey the expected intention.
> The function is used only once in ..._test_walk(), so maybe just
> inline, possibly using a temporary `bool` to make the condition easier
> to read?
I'll update the name of function. Using bool doesn't help much. Lets keep
the same implementation.

> 
> [...]
> 
>> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
> 
> Could you try out how the code would look when passing the bitmap
> instead of separate booleans?
It doesn't look better. Right now we have less duplicate code.

> 
>> +                              struct pagemap_scan_private *p,
>> +                              unsigned long addr, unsigned int n_pages)
>> +{
> [...]
>> +       if ((cur->start + cur->len * PAGE_SIZE == addr) &&
>> +           (cur->bitmap == bitmap)) {
> 
> Nit: bitmap check is cheaper, so I'd put it first. BTW, inner
> parentheses are not needed here.
Will do.

> 
>> +               cur->len += n_pages;
>> +               p->found_pages += n_pages;
>> +
>> +               if (p->max_pages && (p->found_pages == p->max_pages))
>> +                       return PM_SCAN_FOUND_MAX_PAGES;
>> +
>> +               return 0;
>> +       }
>> +
>> +       if (!p->vec_index || ((p->vec_index + 1) < p->vec_len)) {
> 
> It looks that `if (p->vec_index < p->vec_len)` is enough here - if we
> have vec_len == 0 here, then we'd not fit the entry in the userspace
> buffer anyway. Am I missing something?
No. I'd explained it with diagram last time:
https://lore.kernel.org/all/3c8d9ea0-1382-be0c-8dd2-d490eedd3b55@collabora.com

I'll add a concise comment here.

> 
>> +
>> +               if (cur->len) {
>> +                       memcpy(&p->vec[p->vec_index], cur,
>> +                              sizeof(struct page_region));
>> +                       p->vec_index++;
>> +               }
>> +               cur->start = addr;
>> +               cur->len = n_pages;
>> +               cur->bitmap = bitmap;
>> +               p->found_pages += n_pages;
>> +
>> +               if (p->max_pages && (p->found_pages == p->max_pages))
>> +                       return PM_SCAN_FOUND_MAX_PAGES;
>> +
>> +               return 0;
>> +       }
>> +
>> +       return -ENOSPC;
>> +}
>> +
>> +static inline int pagemap_scan_deposit(struct pagemap_scan_private *p,
>> +                                      struct page_region __user *vec,
>> +                                      unsigned long *vec_index)
> 
> ..._deposit() is used only in single place - please inline.
It is already inline.

> 
> [...]
>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>> +                                 unsigned long end, struct mm_walk *walk)
>> +{
>> +       struct pagemap_scan_private *p = walk->private;
>> +       bool is_written, is_file, is_present, is_swap;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       unsigned long addr = end;
>> +       spinlock_t *ptl;
>> +       int ret = 0;
>> +       pte_t *pte;
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +       ptl = pmd_trans_huge_lock(pmd, vma);
>> +       if (ptl) {
> 
> Nit: `page_lock` or `pt_lock` to make it easier to guess the purpose?
No, in this file ptl is used religiously for this lock. So I'll keep it ptl
to keep consistency.

> 
>> +               unsigned long n_pages = (end - start)/PAGE_SIZE;
>> +
>> +               is_written = !is_pmd_uffd_wp(*pmd);
>> +               is_file = vma->vm_file;
>> +               is_present = pmd_present(*pmd);
>> +               is_swap = is_swap_pmd(*pmd);
>> +
>> +               spin_unlock(ptl);
>> +
>> +               /*
>> +                * Break huge page into small pages if the WP operation need to
>> +                * be performed is on a portion of the huge page or if max_pages
>> +                * pages limit would exceed.
> 
> BTW, could the `max_pages` limit be relaxed a bit (in that it would be
> possible to return more pages if they all merge into the last vector
> entry) so that it would not need to split otherwise-matching huge
> page? It would remove the need for this special handling in the kernel
> and splitting the page by this read-only-appearing ioctl?
No, this cannot be done. Otherwise we'll not be able to emulate Windows
syscall GetWriteWatch() which specifies the exact number of pages. Usually
in most of cases, either user will not use THP or not perform the operation
on partial huge page. So this part is only there to keep things correct for
those users who do use THP and partial pagemap_scan operations.

> 
>> +                */
>> +               if (is_written && PM_SCAN_OP_IS_WP(p) &&
>> +                   ((end - start < HPAGE_SIZE) ||
>> +                    (p->max_pages &&
>> +                     (p->max_pages - p->found_pages) < n_pages))) {
>> +
>> +                       split_huge_pmd(vma, pmd, start);
>> +                       goto process_smaller_pages;
>> +               }
>> +
>> +               if (p->max_pages &&
>> +                   p->found_pages + n_pages > p->max_pages)
>> +                       n_pages = p->max_pages - p->found_pages;
>> +
>> +               ret = pagemap_scan_output(is_written, is_file, is_present,
>> +                                         is_swap, p, start, n_pages);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               if (is_written && PM_SCAN_OP_IS_WP(p) &&
>> +                   uffd_wp_range(vma, start, HPAGE_SIZE, true) < 0)
>> +                       ret = -EINVAL;
> 
> Why not propagate the error from uffd_wp_range()?
uffd_wp_range() returns status in long variable. We cannot return long in
this function. So intead of type casting long to int and then return I've
used -EINVAL. Would following be more suitable?

long ret2 = uffd_wp_range(vma, start, HPAGE_SIZE, true);
if (ret2 < 0)
	return (int)ret2;

> 
> [...]
>> +static long do_pagemap_cmd(struct mm_struct *mm,
>> +                          struct pm_scan_arg __user *uarg)
> 
> Please rename the function to `do_pagemap_scan` as it implements just
> this single ioctl now.
Will do.

> 
>> +{
> [...]
>> +       start = (unsigned long)untagged_addr(arg.start);
>> +       vec = (struct page_region *)(unsigned long)untagged_addr(arg.vec);
> 
> Is the inner cast needed?
arg.vec remains 64-bit on 32-bit systems. So casting 64bit value directly
to struct page_region pointer errors out. So I've added specific casting to
unsigned long first before casting to pointers.

> 
>> +       ret = pagemap_scan_args_valid(&arg, start, vec);
>> +       if (ret)
>> +               return ret;
>> +
>> +       end = start + arg.len;
>> +       p.max_pages = arg.max_pages;
>> +       p.found_pages = 0;
>> +       p.flags = arg.flags;
>> +       p.required_mask = arg.required_mask;
>> +       p.anyof_mask = arg.anyof_mask;
>> +       p.excluded_mask = arg.excluded_mask;
>> +       p.return_mask = arg.return_mask;
>> +       p.cur.len = 0;
>> +       p.cur.start = 0;
>> +       p.vec = NULL;
>> +       p.vec_len = (PAGEMAP_WALK_SIZE >> PAGE_SHIFT);
> 
> Nit: parentheses are not needed here, please remove.
Will do.

> 
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
>> +       while (walk_end < end && !ret) {
> 
> The loop will stop if a previous iteration returned ENOSPC (and the
> error will be lost) - is it intended?
It is intentional. -ENOSPC means that the user buffer is full even though
there was more memory to walk over. We don't treat this error. So when
buffer gets full, we stop walking over further as user buffer has gotten
full and return as success.

> 
>> +               p.vec_index = 0;
>> +
>> +               empty_slots = arg.vec_len - vec_index;
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
>> +               if (ret && ret != -ENOSPC && ret != PM_SCAN_FOUND_MAX_PAGES)
>> +                       goto free_data;
>> +
>> +               walk_start = walk_end;
>> +               if (p.vec_index) {
>> +                       if (copy_to_user(&vec[vec_index], p.vec,
>> +                                        p.vec_index *
>> +                                        sizeof(struct page_region))) {
> 
> sizeof(*p.vec) ?
Sure.

> 
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
> 
> This is specific to PAGEMAP_SCAN ioctl, so should go into do_pagemap_cmd().
Sure.

> 
>> +       struct mm_struct *mm = file->private_data;
>> +
>> +       switch (cmd) {
>> +       case PAGEMAP_SCAN:
>> +               return do_pagemap_cmd(mm, uarg);
> [...]
>> --- a/include/linux/userfaultfd_k.h
>> +++ b/include/linux/userfaultfd_k.h
>> @@ -210,6 +210,14 @@ extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
>>
>>  #else /* CONFIG_USERFAULTFD */
>>
>> +static inline long uffd_wp_range(struct mm_struct *dst_mm,
>> +                                struct vm_area_struct *vma,
>> +                                unsigned long start, unsigned long len,
>> +                                bool enable_wp)
>> +{
>> +       return 0;
>> +}
>> +
>>  /* mm helpers */
>>  static inline vm_fault_t handle_userfault(struct vm_fault *vmf,
>>                                 unsigned long reason)
> 
> Shouldn't this part be in the patch introducing uffd_wp_range()?
We have not added uffd_wp_range() in previous patches. We just need this
stub for this patch for the case when CONFIG_USERFAULTFD isn't enabled.

I'd this as separate patch before this patch. Mike asked me to merge it
with this patch in order not to break bisectability.
https://lore.kernel.org/all/ZBK+86eMMazwfhdx@kernel.org


> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
