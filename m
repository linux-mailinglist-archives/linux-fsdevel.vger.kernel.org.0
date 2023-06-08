Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B467279BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 10:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjFHIMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjFHIMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:12:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98340213C;
        Thu,  8 Jun 2023 01:12:30 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4C48166057BA;
        Thu,  8 Jun 2023 09:12:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686211949;
        bh=F7n1LdRXjpGUxnOtMckRx2pdbD4P1L25PCalXPGM0Yk=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=TS2G/KqAjCRzoK4ovZSPK0A8Mg9iWm7I3CrHqPnxzTlUS8S/8T0oVSmHMA2mHwbQG
         lpueAM1cPrs6hp7VcEivK+Qrz9IMYz6dbreMfyDhAnz4E4QPUEkEBrKZcX8wdU0glU
         Qjqh0IC0DfVmmX5uIbTqZs3Vhl8M3VFWtK6nyBRGEbFfDvuSEQw+a1cnGs0yP1OF6L
         8j2KaZpTveKuaDDoWsgm7lFzemuC7Mhajyg3kOwNaNMYtiLuhvWcuSoO96r/yPUjGz
         cDCvmbjU0xHlz+/tWKh2Y0l0nptzWTtpDEiW69HQPoicGZzNEJ7L716qq8wPRYpJF7
         lYu0c6iiXoNqg==
Message-ID: <ccbfb9b0-e616-02ad-b6a5-474e860d023a@collabora.com>
Date:   Thu, 8 Jun 2023 13:12:17 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
Subject: Re: [PATCH v17 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230606060822.1065182-1-usama.anjum@collabora.com>
 <20230606060822.1065182-3-usama.anjum@collabora.com>
 <CABb0KFGUSDwbMHQymCbPDwPiDit1+1JHbgTzzxXL04vQMUxo5w@mail.gmail.com>
 <0b8b19e7-fffa-aa1f-8479-e5a338780f7a@collabora.com>
 <CABb0KFHoYeOz7A6vAUqYDx8PkxjeujPrQRi+Y0YxkqQ_i4tTpA@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFHoYeOz7A6vAUqYDx8PkxjeujPrQRi+Y0YxkqQ_i4tTpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/7/23 9:52 PM, Michał Mirosław wrote:
> On Wed, 7 Jun 2023 at 18:13, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Hi Michał,
>>
>> Thank you for taking time to review!
>>
>> On 6/7/23 7:52 PM, Michał Mirosław wrote:
>>> On Tue, 6 Jun 2023 at 08:08, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>>>> the info about page table entries. The following operations are supported
>>>> in this ioctl:
>>>> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>>>>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>>>>   (PAGE_IS_SWAPPED).
>>>> - Find pages which have been written-to and/or write protect the pages
>>>>   (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)
>>>>
>>>> This IOCTL can be extended to get information about more PTE bits.
>>> [...]
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
> [...]
>>>> +static inline bool pagemap_scan_check_page_written(struct pagemap_scan_private *p)
>>>> +{
>>>> +       return (p->required_mask | p->anyof_mask | p->excluded_mask) &
>>>> +              PAGE_IS_WRITTEN;
>>>> +}
>>>
>>> This could be precalculated and put as a flag into
>>> pagemap_scan_private - it is kernel-private structure and there are a
>>> few spare bits in `flags` if you'd prefer not to add an explicit
>>> boolean.
>> This inline function is only being used at one spot. I can remove the
>> function altogether. I don't like putting it in flags. It'll bring some
>> complexity.
> 
> The difference at the call site will be function call vs field access.
> Do you mean that moving the function to where the struct is
> initialized would add complexity? Why is that?
In my view, adding this calculation to `flag` would make the `flag double
meaning. 1) user flags 2) wp flag is turn on or off
Okay, I've added the flag and removed this function call from
frpagemap_scan_test_walk().

> 
>>> [...]
>>>> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
>>>> +                              struct pagemap_scan_private *p,
>>>> +                              unsigned long addr, unsigned int n_pages)
>>>> +{
>>>> +       unsigned long bitmap = PM_SCAN_BITMAP(wt, file, pres, swap);
>>>> +       struct page_region *cur = &p->cur;
>>>> +
>>>> +       if (!n_pages)
>>>> +               return -EINVAL;
>>>> +
>>>> +       if ((p->required_mask & bitmap) != p->required_mask)
>>>> +               return 0;
>>>> +       if (p->anyof_mask && !(p->anyof_mask & bitmap))
>>>> +               return 0;
>>>> +       if (p->excluded_mask & bitmap)
>>>> +               return 0;
>>>> +
>>>> +       bitmap &= p->return_mask;
>>>> +       if (!bitmap)
>>>> +               return 0;
>>>> +
>>>> +       if (cur->bitmap == bitmap &&
>>>> +           cur->start + cur->len * PAGE_SIZE == addr) {
>>>> +               cur->len += n_pages;
>>>> +               p->found_pages += n_pages;
>>>> +       } else {
>>>> +               /*
>>>> +                * All data is copied to cur first. When more data is found, we
>>>> +                * push cur to vec and copy new data to cur. The vec_index
>>>> +                * represents the current index of vec array. We add 1 to the
>>>> +                * vec_index while performing checks to account for data in cur.
>>>> +                */
>>>> +               if (cur->len && (p->vec_index + 1) >= p->vec_len)
>>>> +                       return -ENOSPC;
>>>> +
>>>> +               if (cur->len) {
>>>> +                       memcpy(&p->vec[p->vec_index], cur, sizeof(*p->vec));
>>>> +                       p->vec_index++;
>>>> +               }
>>>> +
>>>> +               cur->start = addr;
>>>> +               cur->len = n_pages;
>>>> +               cur->bitmap = bitmap;
>>>> +               p->found_pages += n_pages;
>>>> +       }
>>>> +
>>>> +       if (p->max_pages && (p->found_pages == p->max_pages))
>>>> +               return PM_SCAN_FOUND_MAX_PAGES;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>>>> +                                 unsigned long end, struct mm_walk *walk)
>>>> +{
>>>> +       struct pagemap_scan_private *p = walk->private;
>>>> +       struct vm_area_struct *vma = walk->vma;
>>>> +       unsigned long addr = end;
>>>> +       pte_t *pte, *orig_pte;
>>>> +       spinlock_t *ptl;
>>>> +       bool is_written;
>>>> +       int ret = 0;
>>>> +
>>>> +       arch_enter_lazy_mmu_mode();
>>>> +
>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> +       ptl = pmd_trans_huge_lock(pmd, vma);
>>>> +       if (ptl) {
>>>> +               unsigned long n_pages = (end - start)/PAGE_SIZE;
>>>> +
>>>> +               if (p->max_pages && n_pages > p->max_pages - p->found_pages)
>>>> +                       n_pages = p->max_pages - p->found_pages;
>>>
>>> Since p->found_pages is only ever increased in `pagemap_scan_output()`
>>> and that function is only called for GET or GET+WP operations, maybe
>>> the logic could be folded to pagemap_scan_output() to avoid
>>> duplication?
>>> In this function the calculation is used only when WP op is done to
>>> split the HP if n_pages limit would be hit, but if using plain WP
>>> (without GET) it doesn't make sense to use the limit.
>> The n_pages is needed to decide if THP need to be broken down and it is
>> used in pagemap_scan_output(). I've brought this condition out of
>> pagemap_scan_output() to cater this former condition. If I move it to
>> pagemap_scan_output(), I'll have to write same condition to find out if I
>> need to breakt he THP. This seems like repetition, but we have same use
>> case for tlbhuge page.
> 
> My point is that you need to split the THP only if doing a GET+WP
> operation. If you only do GET, then the worst case would be for the
> process to report a spurious WRITTEN bit if an earlier-visited part of
> THP was modified and the scan restarted in the middle of a THP.
We only need to split if doing GET+WP or WP only. In case of WP op, I need
to check if we have less than HPAGE_SIZE/PAGE_SIZE pages and only then
split. So moving this  if condition would not be beneficial.

> 
>>>> (pagemap_scan_output() is trivial enough so I think it could be pulled
>>> inside the spinlocked region.)
>> It is already in spinlocked region. Spin lock is being released after tlb
>> flush.
> 
> Ah, I was thinking about calling pagemap_scan_output() before checking
> split_huge_pmd() case - and at that use the pagemap_scan_output()'s
> return value to do the check.
> 
>>>> +               is_written = !is_pmd_uffd_wp(*pmd);
>>>> +
>>>> +               /*
>>>> +                * Break huge page into small pages if the WP operation need to
>>>> +                * be performed is on a portion of the huge page.
>>>> +                */
>>>> +               if (is_written && IS_PM_SCAN_WP(p->flags) &&
>>>> +                   n_pages < HPAGE_SIZE/PAGE_SIZE) {
>>>> +                       spin_unlock(ptl);
>>>> +
>>>> +                       split_huge_pmd(vma, pmd, start);
>>>> +                       goto process_smaller_pages;
>>>> +               }
>>>> +
>>>> +               if (IS_PM_SCAN_GET(p->flags))
>>>> +                       ret = pagemap_scan_output(is_written, vma->vm_file,
>>>> +                                                 pmd_present(*pmd),
>>>> +                                                 is_swap_pmd(*pmd),
>>>> +                                                 p, start, n_pages);
>>>> +
>>>> +               if (ret >= 0 && is_written && IS_PM_SCAN_WP(p->flags))
>>>> +                       make_uffd_wp_pmd(vma, addr, pmd);
>>>> +
>>>> +               if (IS_PM_SCAN_WP(p->flags))
>>>
>>> Why `is_written` is not checked? If is_written is false, then the WP
>>> op should be a no-op and so won't need TLB flushing, will it? [Same
>>> for the PTE case below.]
>> It can be done for THP. But for ptes we cannot trust is_written as
>> is_written only represent last pte state.
> 
> Ok, so the PTE case could use a flag recording whether any PTE had WP
> applied instead of `is_written`.
Definately, but I'll have to add a extra variable. I'll add it as you have
asked.

> 
>>>> +                       flush_tlb_range(vma, start, end);
>>>> +
>>> [...]
>>>> +       if (IS_PM_SCAN_WP(p->flags))
>>>> +               flush_tlb_range(vma, start, addr);
>>>> +
>>>> +       pte_unmap_unlock(orig_pte, ptl);
>>>> +       arch_leave_lazy_mmu_mode();
>>>> +
>>>> +       cond_resched();
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_HUGETLB_PAGE
>>>> +static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
>>>> +                                     unsigned long start, unsigned long end,
>>>> +                                     struct mm_walk *walk)
>>>> +{
>>>> +       unsigned long n_pages = (end - start)/PAGE_SIZE;
>>>> +       struct pagemap_scan_private *p = walk->private;
>>>> +       struct vm_area_struct *vma = walk->vma;
>>>> +       struct hstate *h = hstate_vma(vma);
>>>> +       spinlock_t *ptl;
>>>> +       bool is_written;
>>>> +       int ret = 0;
>>>> +       pte_t pte;
>>>> +
>>>> +       if (p->max_pages && n_pages > p->max_pages - p->found_pages)
>>>> +               n_pages = p->max_pages - p->found_pages;
>>>> +
>>>> +       if (IS_PM_SCAN_WP(p->flags)) {
>>>> +               i_mmap_lock_write(vma->vm_file->f_mapping);
>>>> +               ptl = huge_pte_lock(h, vma->vm_mm, ptep);
>>>> +       }
>>>> +
>>>> +       pte = huge_ptep_get(ptep);
>>>> +       is_written = !is_huge_pte_uffd_wp(pte);
>>>> +
>>>> +       /*
>>>> +        * Partial hugetlb page clear isn't supported
>>>> +        */
>>>> +       if (is_written && IS_PM_SCAN_WP(p->flags) &&
>>>> +           n_pages < HPAGE_SIZE/PAGE_SIZE) {
>>>> +               ret = -EPERM;
>>>
>>> Shouldn't this be ENOSPC, conveying that the operation would overflow
>>> the n_pages limit?
>> We are testing here is user has asked us to engage WP on a part of the
>> hugetlb or we can only perform WP on a part of the engage as user buffer is
>> full. We cannot judge this has happened because of the former or later
>> condition. So I'm assuming that user's parameters aren't solid enough and
>> returning -EPERM. It seemed more suitable to me. But I can return -ENOSPC
>> as well, if you say?
> 
> Those two cases can be differentiated when checked before truncating
> n_pages. If a user requests partial WP for a hugetlb page wouldn't
> EINVAL (or other error - as this can't ever work) be more appropriate
> (this check could happen only at the start of scan)? If the request is
> due to max_pages limit (with found_pages > 0), then I'd return ENOSPC
> and expect the user to restart the scan with a new buffer.
Okay. I'll update.

> 
> Our discussion here makes me wonder: what is the expected return value
> for the ioctl WP (without GET) operation? If it would return e.g. the
> number of 4K-pages successfully scanned, then the caller would be able
> to detect the partial tail hugepage case and act accordingly.
Returning error in case of only WP means partial hugetlb is hit. User
should expect the partial wp on the memory area already.

If we really want to return number of pages cleared, possible option of
return value:
* Return 0 means whole region is wp-ed
* Return number of pages wp-ed if some error occurred (we need to handle
this only for hugetlb) OR return -1 * number of pages wp-ed?

An another uniform way can be to sum all wp-ed pages every time and return
them * -. -1 is needed to let the know user that wp operation got halted
mid way.

> 
>>>> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
>>>> +                                int depth, struct mm_walk *walk)
>>>> +{
>>>> +       unsigned long n_pages = (end - addr)/PAGE_SIZE;
>>>> +       struct pagemap_scan_private *p = walk->private;
>>>> +       struct vm_area_struct *vma = walk->vma;
>>>> +       int ret = 0;
>>>> +
>>>> +       if (!vma || !IS_PM_SCAN_GET(p->flags))
>>>> +               return 0;
>>>> +
>>>> +       if (p->max_pages && n_pages > p->max_pages - p->found_pages)
>>>> +               n_pages = p->max_pages - p->found_pages;
>>>
>>> Nit: If the page flags don't match (wouldn't be output), the limit
>>> would not be hit and the calculation is unnecessary. But if it was
>>> done in pagemap_scan_output() instead after all the flags checks...
>> Correct for this use case. But moving to pagemap_scan_output() would make
>> me do duplicate calculation for other 2 cases as explained above.
> 
> (responded below the cases above)
> 
>>>> +       ret = pagemap_scan_output(false, vma->vm_file, false, false, p, addr,
>>>> +                                 n_pages);
>>>> +
>>>> +       return ret;
>>>> +}
>>> [...]
>>>> +static long do_pagemap_scan(struct mm_struct *mm,
>>>> +                           struct pm_scan_arg __user *uarg)
>>>> +{
>>>> +       unsigned long start, end, walk_start, walk_end;
>>>> +       unsigned long empty_slots, vec_index = 0;
>>>> +       struct mmu_notifier_range range;
>>>> +       struct page_region __user *vec;
>>>> +       struct pagemap_scan_private p;
>>>> +       struct pm_scan_arg arg;
>>>> +       int ret = 0;
>>>> +
>>>> +       if (copy_from_user(&arg, uarg, sizeof(arg)))
>>>> +               return -EFAULT;
>>>> +
>>>> +       start = untagged_addr((unsigned long)arg.start);
>>>> +       vec = (struct page_region *)untagged_addr((unsigned long)arg.vec);
>>>> +
>>>> +       ret = pagemap_scan_args_valid(&arg, start, vec);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       end = start + arg.len;
>>>> +       p.max_pages = arg.max_pages;
>>>> +       p.found_pages = 0;
>>>> +       p.flags = arg.flags;
>>>> +       p.required_mask = arg.required_mask;
>>>> +       p.anyof_mask = arg.anyof_mask;
>>>> +       p.excluded_mask = arg.excluded_mask;
>>>> +       p.return_mask = arg.return_mask;
>>>> +       p.cur.start = p.cur.len = p.cur.bitmap = 0;
>>>> +       p.vec = NULL;
>>>> +       p.vec_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
>>>
>>> If p.vec_len would not count the entry held in `cur` (IOW: vec_len =
>>> WALK_SIZE - 1), then pagemap_scan_output() wouldn't need the big
>>> comment about adding or subtracting 1 when checking for overflow. The
>>> output vector needs to have space for at least one entrry to make GET
>>> useful. Maybe `cur` could be renamed or annotated to express that it
>>> always holds the last entry?
>> Ohhh.. This can be done by doing subtracting 1 from empty_slots. But I've
>> explored the idea. I don't see any benefit. If we do this, then I'll have
>> to put a comment why subtracting 1 is needed. Seems like same problem:
>>
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1909,7 +1909,7 @@ static int pagemap_scan_output(bool wt, bool file,
>> bool pres, bool swap,
>>                  * represents the current index of vec array. We add 1 to the
>>                  * vec_index while performing checks to account for data in
>> cur.
>>                  */
>> -               if (cur->len && (p->vec_index + 1) >= p->vec_len)
>> +               if (cur->len && p->vec_index >= p->vec_len)
>>                         return -ENOSPC;
>>
>>                 if (cur->len) {
>> @@ -2202,7 +2202,7 @@ static long do_pagemap_scan(struct mm_struct *mm,
>>                 if (IS_PM_SCAN_GET(p.flags)) {
>>                         p.vec_index = 0;
>>
>> -                       empty_slots = arg.vec_len - vec_index;
>> +                       empty_slots = arg.vec_len - 1 - vec_index;
>>                         p.vec_len = min(p.vec_len, empty_slots);
>>                 }
>>
>> Lets leave it as it is. I can change `cur` to `last` or any other name.
>> Please suggest.
> 
> The difference is that you have the subtraction only once per the
> outer page_walk loop iteration, but in the current version the
> addition has to happen every pagemap_scan_output() call after a hole.
I'll update as you are saying. After updating, we cannot abort this outer
loop if length is 0 as the last element is present in cur.

> 
> From the readability perspective, "if (next_index >= vec_len)" is
> short and self-documenting. Also I'd use "p.vec_len = min(p.vec_len,
> empty_slots - 1)" as it also conveys the intent better (in that `vec`
> is holding all but the last entry, but arg.vec_len holds the final
> output buffer length).
> 
> If we're picking colors, then maybe make `arg.vec_len` have a
> different name than `p.vec_len` (same for `vec_index`) so that there
> is less confusion possible as to what they refer to. Maybe keep
> `arg.vec_len`, but have `p.vec_buf`, `p.vec_buf_len`, and
> `p.next_buf_index`?
So we do have colors in variable names. :) I'll update.

> 
> (Note: you'd also need to decrement p.vec_len where it is first assigned.)
> 
> [...]
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
