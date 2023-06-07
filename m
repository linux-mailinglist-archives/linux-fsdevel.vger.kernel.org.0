Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FDB72658E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 18:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjFGQNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 12:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbjFGQNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:13:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897301BFA;
        Wed,  7 Jun 2023 09:13:11 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 267546606F0B;
        Wed,  7 Jun 2023 17:13:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686154389;
        bh=/E+RySgRt7WQ7Lc/lmqKu/Xzi1hQFJmb9USYUYriHx4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=k6da084i/96mW6B5ssX/wKQahuGtAA9KD+kaa5xQQI0GAqFzKHwT2eo4cDU1Ko9NM
         suO+vZipiylAjIGkxCsSoM20gyrhI8/F+pp1+DbPb9rziZ3/xJ1n/S57NFzw5PzhzT
         QXptkuRg+GfrVxAyDgiUld60ZVeNhWktA+1CsBR5J3EsdbozrmtJQxMjqM/+cX4UpC
         4kuIF6Qjc0tcUcMxrUeI10WZumgBRPxqFtsX7zU5Z6JZZ4Z2nOj+UDtvNi2GEAC8p7
         d95LR1y5W3M2NGL4CWAnX4T4lqcIuOMIGsLRjaP/HFc4P53Hq7Mn5SA84EsnYWShlR
         oMcw+Q6/OjrCg==
Message-ID: <0b8b19e7-fffa-aa1f-8479-e5a338780f7a@collabora.com>
Date:   Wed, 7 Jun 2023 21:12:58 +0500
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
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230606060822.1065182-1-usama.anjum@collabora.com>
 <20230606060822.1065182-3-usama.anjum@collabora.com>
 <CABb0KFGUSDwbMHQymCbPDwPiDit1+1JHbgTzzxXL04vQMUxo5w@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFGUSDwbMHQymCbPDwPiDit1+1JHbgTzzxXL04vQMUxo5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michał,

Thank you for taking time to review!

On 6/7/23 7:52 PM, Michał Mirosław wrote:
> On Tue, 6 Jun 2023 at 08:08, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>> the info about page table entries. The following operations are supported
>> in this ioctl:
>> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>>   (PAGE_IS_SWAPPED).
>> - Find pages which have been written-to and/or write protect the pages
>>   (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)
>>
>> This IOCTL can be extended to get information about more PTE bits.
> [...]
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
> [...]
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static inline bool is_pmd_uffd_wp(pmd_t pmd)
>> +{
>> +       return (pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
>> +              (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd));
>> +}
> [...]
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +static inline bool is_huge_pte_uffd_wp(pte_t pte)
>> +{
>> +       return ((pte_present(pte) && huge_pte_uffd_wp(pte)) ||
>> +              pte_swp_uffd_wp_any(pte));
> 
> Nit: please remove the outer parentheses (it is already done for
> similar finctuons above).
Will remove.

> 
>> +}
> 
>> +static inline bool pagemap_scan_check_page_written(struct pagemap_scan_private *p)
>> +{
>> +       return (p->required_mask | p->anyof_mask | p->excluded_mask) &
>> +              PAGE_IS_WRITTEN;
>> +}
> 
> This could be precalculated and put as a flag into
> pagemap_scan_private - it is kernel-private structure and there are a
> few spare bits in `flags` if you'd prefer not to add an explicit
> boolean.
This inline function is only being used at one spot. I can remove the
function altogether. I don't like putting it in flags. It'll bring some
complexity.

> 
> [...]
>> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
>> +                              struct pagemap_scan_private *p,
>> +                              unsigned long addr, unsigned int n_pages)
>> +{
>> +       unsigned long bitmap = PM_SCAN_BITMAP(wt, file, pres, swap);
>> +       struct page_region *cur = &p->cur;
>> +
>> +       if (!n_pages)
>> +               return -EINVAL;
>> +
>> +       if ((p->required_mask & bitmap) != p->required_mask)
>> +               return 0;
>> +       if (p->anyof_mask && !(p->anyof_mask & bitmap))
>> +               return 0;
>> +       if (p->excluded_mask & bitmap)
>> +               return 0;
>> +
>> +       bitmap &= p->return_mask;
>> +       if (!bitmap)
>> +               return 0;
>> +
>> +       if (cur->bitmap == bitmap &&
>> +           cur->start + cur->len * PAGE_SIZE == addr) {
>> +               cur->len += n_pages;
>> +               p->found_pages += n_pages;
>> +       } else {
>> +               /*
>> +                * All data is copied to cur first. When more data is found, we
>> +                * push cur to vec and copy new data to cur. The vec_index
>> +                * represents the current index of vec array. We add 1 to the
>> +                * vec_index while performing checks to account for data in cur.
>> +                */
>> +               if (cur->len && (p->vec_index + 1) >= p->vec_len)
>> +                       return -ENOSPC;
>> +
>> +               if (cur->len) {
>> +                       memcpy(&p->vec[p->vec_index], cur, sizeof(*p->vec));
>> +                       p->vec_index++;
>> +               }
>> +
>> +               cur->start = addr;
>> +               cur->len = n_pages;
>> +               cur->bitmap = bitmap;
>> +               p->found_pages += n_pages;
>> +       }
>> +
>> +       if (p->max_pages && (p->found_pages == p->max_pages))
>> +               return PM_SCAN_FOUND_MAX_PAGES;
>> +
>> +       return 0;
>> +}
>> +
>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>> +                                 unsigned long end, struct mm_walk *walk)
>> +{
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       unsigned long addr = end;
>> +       pte_t *pte, *orig_pte;
>> +       spinlock_t *ptl;
>> +       bool is_written;
>> +       int ret = 0;
>> +
>> +       arch_enter_lazy_mmu_mode();
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +       ptl = pmd_trans_huge_lock(pmd, vma);
>> +       if (ptl) {
>> +               unsigned long n_pages = (end - start)/PAGE_SIZE;
>> +
>> +               if (p->max_pages && n_pages > p->max_pages - p->found_pages)
>> +                       n_pages = p->max_pages - p->found_pages;
> 
> Since p->found_pages is only ever increased in `pagemap_scan_output()`
> and that function is only called for GET or GET+WP operations, maybe
> the logic could be folded to pagemap_scan_output() to avoid
> duplication?
> In this function the calculation is used only when WP op is done to
> split the HP if n_pages limit would be hit, but if using plain WP
> (without GET) it doesn't make sense to use the limit.
The n_pages is needed to decide if THP need to be broken down and it is
used in pagemap_scan_output(). I've brought this condition out of
pagemap_scan_output() to cater this former condition. If I move it to
pagemap_scan_output(), I'll have to write same condition to find out if I
need to breakt he THP. This seems like repetition, but we have same use
case for tlbhuge page.

> (pagemap_scan_output() is trivial enough so I think it could be pulled
> inside the spinlocked region.)
It is already in spinlocked region. Spin lock is being released after tlb
flush.

> 
>> +
>> +               is_written = !is_pmd_uffd_wp(*pmd);
>> +
>> +               /*
>> +                * Break huge page into small pages if the WP operation need to
>> +                * be performed is on a portion of the huge page.
>> +                */
>> +               if (is_written && IS_PM_SCAN_WP(p->flags) &&
>> +                   n_pages < HPAGE_SIZE/PAGE_SIZE) {
>> +                       spin_unlock(ptl);
>> +
>> +                       split_huge_pmd(vma, pmd, start);
>> +                       goto process_smaller_pages;
>> +               }
>> +
>> +               if (IS_PM_SCAN_GET(p->flags))
>> +                       ret = pagemap_scan_output(is_written, vma->vm_file,
>> +                                                 pmd_present(*pmd),
>> +                                                 is_swap_pmd(*pmd),
>> +                                                 p, start, n_pages);
>> +
>> +               if (ret >= 0 && is_written && IS_PM_SCAN_WP(p->flags))
>> +                       make_uffd_wp_pmd(vma, addr, pmd);
>> +
>> +               if (IS_PM_SCAN_WP(p->flags))
> 
> Why `is_written` is not checked? If is_written is false, then the WP
> op should be a no-op and so won't need TLB flushing, will it? [Same
> for the PTE case below.]
It can be done for THP. But for ptes we cannot trust is_written as
is_written only represent last pte state.

> 
>> +                       flush_tlb_range(vma, start, end);
>> +
> [...]
>> +       if (IS_PM_SCAN_WP(p->flags))
>> +               flush_tlb_range(vma, start, addr);
>> +
>> +       pte_unmap_unlock(orig_pte, ptl);
>> +       arch_leave_lazy_mmu_mode();
>> +
>> +       cond_resched();
>> +       return ret;
>> +}
>> +
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
>> +                                     unsigned long start, unsigned long end,
>> +                                     struct mm_walk *walk)
>> +{
>> +       unsigned long n_pages = (end - start)/PAGE_SIZE;
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       struct hstate *h = hstate_vma(vma);
>> +       spinlock_t *ptl;
>> +       bool is_written;
>> +       int ret = 0;
>> +       pte_t pte;
>> +
>> +       if (p->max_pages && n_pages > p->max_pages - p->found_pages)
>> +               n_pages = p->max_pages - p->found_pages;
>> +
>> +       if (IS_PM_SCAN_WP(p->flags)) {
>> +               i_mmap_lock_write(vma->vm_file->f_mapping);
>> +               ptl = huge_pte_lock(h, vma->vm_mm, ptep);
>> +       }
>> +
>> +       pte = huge_ptep_get(ptep);
>> +       is_written = !is_huge_pte_uffd_wp(pte);
>> +
>> +       /*
>> +        * Partial hugetlb page clear isn't supported
>> +        */
>> +       if (is_written && IS_PM_SCAN_WP(p->flags) &&
>> +           n_pages < HPAGE_SIZE/PAGE_SIZE) {
>> +               ret = -EPERM;
> 
> Shouldn't this be ENOSPC, conveying that the operation would overflow
> the n_pages limit?
We are testing here is user has asked us to engage WP on a part of the
hugetlb or we can only perform WP on a part of the engage as user buffer is
full. We cannot judge this has happened because of the former or later
condition. So I'm assuming that user's parameters aren't solid enough and
returning -EPERM. It seemed more suitable to me. But I can return -ENOSPC
as well, if you say?

> 
>> +               goto unlock_and_return;
>> +       }
>> +
>> +       if (IS_PM_SCAN_GET(p->flags)) {
>> +               ret = pagemap_scan_output(is_written, vma->vm_file,
>> +                                         pte_present(pte), is_swap_pte(pte),
>> +                                         p, start, n_pages);
>> +               if (ret < 0)
>> +                       goto unlock_and_return;
>> +       }
>> +
>> +       if (is_written && IS_PM_SCAN_WP(p->flags)) {
> 
> Oh, this case does check `is_written` before flushing TLB, contrary to
> what the cases above do.
> 
>> +               make_uffd_wp_huge_pte(vma, start, ptep, pte);
>> +               flush_hugetlb_tlb_range(vma, start, end);
>> +       }
>> +
>> +unlock_and_return:
>> +       if (IS_PM_SCAN_WP(p->flags)) {
>> +               spin_unlock(ptl);
>> +               i_mmap_unlock_write(vma->vm_file->f_mapping);
>> +       }
>> +
>> +       return ret;
>> +}
>> +#else
>> +#define pagemap_scan_hugetlb_entry NULL
>> +#endif
>> +
>> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
>> +                                int depth, struct mm_walk *walk)
>> +{
>> +       unsigned long n_pages = (end - addr)/PAGE_SIZE;
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       int ret = 0;
>> +
>> +       if (!vma || !IS_PM_SCAN_GET(p->flags))
>> +               return 0;
>> +
>> +       if (p->max_pages && n_pages > p->max_pages - p->found_pages)
>> +               n_pages = p->max_pages - p->found_pages;
> 
> Nit: If the page flags don't match (wouldn't be output), the limit
> would not be hit and the calculation is unnecessary. But if it was
> done in pagemap_scan_output() instead after all the flags checks...
Correct for this use case. But moving to pagemap_scan_output() would make
me do duplicate calculation for other 2 cases as explained above.

> 
>> +       ret = pagemap_scan_output(false, vma->vm_file, false, false, p, addr,
>> +                                 n_pages);
>> +
>> +       return ret;
>> +}
> [...]
>> +static long do_pagemap_scan(struct mm_struct *mm,
>> +                           struct pm_scan_arg __user *uarg)
>> +{
>> +       unsigned long start, end, walk_start, walk_end;
>> +       unsigned long empty_slots, vec_index = 0;
>> +       struct mmu_notifier_range range;
>> +       struct page_region __user *vec;
>> +       struct pagemap_scan_private p;
>> +       struct pm_scan_arg arg;
>> +       int ret = 0;
>> +
>> +       if (copy_from_user(&arg, uarg, sizeof(arg)))
>> +               return -EFAULT;
>> +
>> +       start = untagged_addr((unsigned long)arg.start);
>> +       vec = (struct page_region *)untagged_addr((unsigned long)arg.vec);
>> +
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
>> +       p.cur.start = p.cur.len = p.cur.bitmap = 0;
>> +       p.vec = NULL;
>> +       p.vec_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
> 
> If p.vec_len would not count the entry held in `cur` (IOW: vec_len =
> WALK_SIZE - 1), then pagemap_scan_output() wouldn't need the big
> comment about adding or subtracting 1 when checking for overflow. The
> output vector needs to have space for at least one entrry to make GET
> useful. Maybe `cur` could be renamed or annotated to express that it
> always holds the last entry?
Ohhh.. This can be done by doing subtracting 1 from empty_slots. But I've
explored the idea. I don't see any benefit. If we do this, then I'll have
to put a comment why subtracting 1 is needed. Seems like same problem:

--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1909,7 +1909,7 @@ static int pagemap_scan_output(bool wt, bool file,
bool pres, bool swap,
                 * represents the current index of vec array. We add 1 to the
                 * vec_index while performing checks to account for data in
cur.
                 */
-               if (cur->len && (p->vec_index + 1) >= p->vec_len)
+               if (cur->len && p->vec_index >= p->vec_len)
                        return -ENOSPC;

                if (cur->len) {
@@ -2202,7 +2202,7 @@ static long do_pagemap_scan(struct mm_struct *mm,
                if (IS_PM_SCAN_GET(p.flags)) {
                        p.vec_index = 0;

-                       empty_slots = arg.vec_len - vec_index;
+                       empty_slots = arg.vec_len - 1 - vec_index;
                        p.vec_len = min(p.vec_len, empty_slots);
                }

Lets leave it as it is. I can change `cur` to `last` or any other name.
Please suggest.

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
>> +       if (IS_PM_SCAN_GET(p.flags)) {
>> +               p.vec = kmalloc_array(p.vec_len, sizeof(*p.vec), GFP_KERNEL);
>> +               if (!p.vec)
>> +                       return -ENOMEM;
>> +       }
>> +
>> +       if (IS_PM_SCAN_WP(p.flags)) {
>> +               mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
>> +                                       mm, start, end);
>> +               mmu_notifier_invalidate_range_start(&range);
>> +       }
>> +
>> +       walk_start = walk_end = start;
>> +       while (walk_end < end && !ret) {
>> +               if (IS_PM_SCAN_GET(p.flags)) {
>> +                       p.vec_index = 0;
>> +
>> +                       empty_slots = arg.vec_len - vec_index;
> 
> Can `empty_slots` be zero here? I don't see anything prohibiting this case.
I'll add a check here and abort the loop here instead of continuing the
operation.

> 
>> +                       p.vec_len = min(p.vec_len, empty_slots);
> 
> ( If not counting `cur`, it would be min(p.vec_len, empty_slots - 1); )
> 
>> +               }
>> +
>> +               walk_end = (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
>> +               if (walk_end > end)
>> +                       walk_end = end;
>> +
>> +               ret = mmap_read_lock_killable(mm);
>> +               if (ret)
>> +                       goto free_data;
>> +               ret = walk_page_range(mm, walk_start, walk_end,
>> +                                     &pagemap_scan_ops, &p);
>> +               mmap_read_unlock(mm);
>> +
>> +               if (ret && ret != -ENOSPC && ret != PM_SCAN_FOUND_MAX_PAGES)
>> +                       goto free_data;
>> +
>> +               walk_start = walk_end;
>> +               if (IS_PM_SCAN_GET(p.flags) && p.vec_index) {
>> +                       if (copy_to_user(&vec[vec_index], p.vec,
>> +                                        p.vec_index * sizeof(*p.vec))) {
>> +                               /*
>> +                                * Return error even though the OP succeeded
>> +                                */
>> +                               ret = -EFAULT;
>> +                               goto free_data;
>> +                       }
>> +                       vec_index += p.vec_index;
>> +               }
>> +       }
>> +
>> +       if (IS_PM_SCAN_GET(p.flags) && p.cur.len) {
> 
> Nit: p.cur.len can be non-zero only if we do a GET (or GET+WP) operation.
I'll remove the first half of condition.

> 
>> +               if (copy_to_user(&vec[vec_index], &p.cur, sizeof(*p.vec))) {
> 
> Nit: sizeof(*p.cur); (even though this is the same type)
Good point.

> 
>> +                       ret = -EFAULT;
>> +                       goto free_data;
>> +               }
>> +               vec_index++;
>> +       }
>> +
>> +       ret = vec_index;
>> +
>> +free_data:
>> +       if (IS_PM_SCAN_WP(p.flags))
>> +               mmu_notifier_invalidate_range_end(&range);
>> +
>> +       kfree(p.vec);
>> +       return ret;
>> +}
>> +
>> +static long do_pagemap_cmd(struct file *file, unsigned int cmd,
>> +                          unsigned long arg)
>> +{
>> +       struct pm_scan_arg __user *uarg = (struct pm_scan_arg __user *)arg;
> 
> The cast should be in do_pagemap_scan() as if there comes another
> `cmd`, then it might use a different argument type.
I'll update.

> 
>> +       struct mm_struct *mm = file->private_data;
>> +
>> +       switch (cmd) {
>> +       case PAGEMAP_SCAN:
>> +               return do_pagemap_scan(mm, uarg);
>> +
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +}
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
