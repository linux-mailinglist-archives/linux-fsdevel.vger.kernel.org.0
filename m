Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABB7778E9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 14:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjHKMDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 08:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbjHKMC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:02:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2270110;
        Fri, 11 Aug 2023 05:02:56 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.188.71])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C7C57660723B;
        Fri, 11 Aug 2023 13:02:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691755374;
        bh=ptGmykJh30mrgPn3Ps2k38+HI8VAIda+W/6jzn+VRyQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=BBRDIHQCDhDF5ynkOR70YhQIcMs/+L3Ct++iYHe0+VLrlN4J/NuO82YVibvPVp2QD
         59cc9z3hf7RiKJINcnGzTjXO5fC/M2TVTY3xZUQygx9KzdwpOK8I8mudMWMeKpyY5n
         OY0mP6CyutWidu67TlXma6TY9TATKjdQxeBGCOCOMyuGZwDCsBDeHSBPnX5fQAUM5n
         9RsRQu1bz/wutZa+H0TnEGFPkWyo+knMai20gS/jxaUaNLOmm2kFFq748InNA+Dv8p
         10rVFvLJD4fcqSTuhEvYMD5fxlrmhUa0l8wyJ9ROKDHG4J9o2aQBYYJuDzafm2lPrB
         nJJO280yimmOw==
Message-ID: <97de19a3-bba2-9260-7741-cd5b6f4581e9@collabora.com>
Date:   Fri, 11 Aug 2023 17:02:44 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v28 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230809061603.1969154-1-usama.anjum@collabora.com>
 <20230809061603.1969154-3-usama.anjum@collabora.com>
 <CABb0KFGqDo8hFohqpXewoquyLVZUhG-bRHxpw_PYXzGW9wXofQ@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFGqDo8hFohqpXewoquyLVZUhG-bRHxpw_PYXzGW9wXofQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/10/23 10:32 PM, Michał Mirosław wrote:
> On Wed, 9 Aug 2023 at 08:16, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>> the info about page table entries. The following operations are supported
>> in this ioctl:
>> - Get the information if the pages have Async Write-Protection enabled
>>   (``PAGE_IS_WPALLOWED``), have been written to (``PAGE_IS_WRITTEN``), file
>>   mapped (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``), swapped
>>   (``PAGE_IS_SWAPPED``) or page has pfn zero (``PAGE_IS_PFNZERO``).
>> - Find pages which have been written to and/or write protect
>>   (atomic ``PM_SCAN_WP_MATCHING + PM_SCAN_CHECK_WPASYNC``) the pages
>>   atomically. The (``PM_SCAN_WP_MATCHING``) is used to WP the matched
>>   pages. The (``PM_SCAN_CHECK_WPASYNC``) aborts the operation if
>>   non-Async-Write-Protected pages are found. Get is automatically performed
>>   if output buffer is specified.
>>
>> This IOCTL can be extended to get information about more PTE bits. The
>> entire address range passed by user [start, end) is scanned until either
>> the user provided buffer is full or max_pages have been found.
>>
>> Reviewed-by: Andrei Vagin <avagin@gmail.com>
>> Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Still applies, thanks! Please find some mostly-polishing comments below.
> 
>> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
>> ---
>> Changes in v28:
>> - Fix walk_end one last time after doing through testing
>>
>> Changes in v27:
>> - Add PAGE_IS_HUGE
> 
> It seems to be missing from the commitmsg, though. But maybe listing
> all the flags there is redundant, since a doc is coming anyway and the
> values are listed in the .h?
Yeah, fs.h and doc has all these mentioned.

> 
> [...]
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
> [...]
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static unsigned long pagemap_thp_category(pmd_t pmd)
>> +{
>> +       unsigned long categories = PAGE_IS_HUGE;
>> +
>> +       if (pmd_present(pmd)) {
>> +               categories |= PAGE_IS_PRESENT;
>> +               if (!pmd_uffd_wp(pmd))
>> +                       categories |= PAGE_IS_WRITTEN;
>> +               if (is_zero_pfn(pmd_pfn(pmd)))
>> +                       categories |= PAGE_IS_PFNZERO;
>> +       } else if (is_swap_pmd(pmd)) {
>> +               categories |= PAGE_IS_SWAPPED;
>> +               if (!pmd_swp_uffd_wp(pmd))
>> +                       categories |= PAGE_IS_WRITTEN;
>> +       }
>> +
>> +       return categories;
>> +}
> 
> I guess THPs can't be file-backed currently, but can we somehow mark
> this assumption so it can be easily found if the capability arrives?
Yeah, THPs cannot be file backed. Lets not care for some feature which may
not arrive in several years or eternity.

> 
>> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> +
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +static unsigned long pagemap_hugetlb_category(pte_t pte)
>> +{
>> +       unsigned long categories = PAGE_IS_HUGE;
>> +
>> +       if (pte_present(pte)) {
>> +               categories |= PAGE_IS_PRESENT;
>> +               if (!huge_pte_uffd_wp(pte))
>> +                       categories |= PAGE_IS_WRITTEN;
>> +               if (!PageAnon(pte_page(pte)))
>> +                       categories |= PAGE_IS_FILE;
>> +               if (is_zero_pfn(pte_pfn(pte)))
>> +                       categories |= PAGE_IS_PFNZERO;
>> +       } else if (is_swap_pte(pte)) {
>> +               categories |= PAGE_IS_SWAPPED;
>> +               if (!pte_swp_uffd_wp_any(pte))
>> +                       categories |= PAGE_IS_WRITTEN;
>> +       }
> 
> BTW, can a HugeTLB page be file-backed and swapped out?
Accourding to pagemap_hugetlb_range(), file-backed HugeTLB page cannot be
swapped.

> 
>> +static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
>> +                                      unsigned long addr, unsigned long end,
>> +                                      unsigned long walk_end_addr)
>> +{
>> +       struct page_region *cur_buf = &p->cur_buf;
>> +
>> +       if (cur_buf->start != addr)
>> +               cur_buf->end = addr;
>> +       else
>> +               cur_buf->start = cur_buf->end = 0;
>> +
>> +       p->walk_end_addr = walk_end_addr;
>> +       p->found_pages -= (end - addr) / PAGE_SIZE;
>> +}
> 
> When would `walk_end_addr` be different from `end`? Maybe it would be
> easier to understand if the `p->walk_end_addr` update was pushed to
> the callers? (Actually: the one that wants to change it.)
Not very major thing, I've made the changes for next revision.

> 
>> +static int pagemap_scan_output(unsigned long categories,
>> +                              struct pagemap_scan_private *p,
>> +                              unsigned long addr, unsigned long *end)
>> +{
>> +       unsigned long n_pages, total_pages;
>> +       int ret = 0;
>> +
>> +       if (!p->vec_buf)
>> +               return 0;
>> +
>> +       categories &= p->arg.return_mask;
>> +
>> +       n_pages = (*end - addr) / PAGE_SIZE;
>> +       if (check_add_overflow(p->found_pages, n_pages, &total_pages) || //TODO
>> +           total_pages > p->arg.max_pages) {
> 
> Re: TODO: Is there anything left to change here?
No, I'll remove it.

> 
>> +               size_t n_too_much = total_pages - p->arg.max_pages;
>> +               *end -= n_too_much * PAGE_SIZE;
>> +               n_pages -= n_too_much;
>> +               ret = -ENOSPC;
>> +       }
> [...]
> 
>> +static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
>> +                                 unsigned long end, struct mm_walk *walk)
>> +{
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       unsigned long categories;
>> +       spinlock_t *ptl;
>> +       int ret = 0;
>> +
>> +       ptl = pmd_trans_huge_lock(pmd, vma);
>> +       if (!ptl)
>> +               return -ENOENT;
>> +
>> +       categories = p->cur_vma_category | pagemap_thp_category(*pmd);
>> +
>> +       if (!pagemap_scan_is_interesting_page(categories, p))
>> +               goto out_unlock;
>> +
>> +       ret = pagemap_scan_output(categories, p, start, &end);
>> +       if (start == end)
>> +               goto out_unlock;
>> +
>> +       if (~p->arg.flags & PM_SCAN_WP_MATCHING)
>> +               goto out_unlock;
>> +       if (~categories & PAGE_IS_WRITTEN)
>> +               goto out_unlock;
>> +
>> +       /*
>> +        * Break huge page into small pages if the WP operation
>> +        * need to be performed is on a portion of the huge page.
> 
> "needs to be performed on ..."
Okay. I'll update.

> 
>> +        */
>> +       if (end != start + HPAGE_SIZE) {
>> +               spin_unlock(ptl);
>> +               split_huge_pmd(vma, pmd, start);
>> +               pagemap_scan_backout_range(p, start, end, 0);
>> +               /* Indicate to caller for processing these as normal pages */
> 
> Nit: "Report as if there was no THP." ?
Sure. I'll update.

> 
>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>> +                                 unsigned long end, struct mm_walk *walk)
>> +{
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       pte_t *pte, *start_pte;
>> +       unsigned long addr;
>> +       bool flush = false;
>> +       spinlock_t *ptl;
>> +       int ret;
>> +
>> +       arch_enter_lazy_mmu_mode();
>> +
>> +       ret = pagemap_scan_thp_entry(pmd, start, end, walk);
>> +       if (ret != -ENOENT) {
>> +               arch_leave_lazy_mmu_mode();
>> +               return ret;
>> +       }
>> +
>> +       ret = 0;
>> +       start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
>> +       if (!pte) {
>> +               arch_leave_lazy_mmu_mode();
>> +               walk->action = ACTION_AGAIN;
>> +               return 0;
>> +       }
>> +
>> +       for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
>> +               unsigned long categories = p->cur_vma_category |
>> +                                          pagemap_page_category(p, vma, addr, ptep_get(pte));
>> +               unsigned long next = addr + PAGE_SIZE;
>> +
>> +               if (!pagemap_scan_is_interesting_page(categories, p))
>> +                       continue;
>> +
>> +               ret = pagemap_scan_output(categories, p, addr, &next);
>> +               if (next == addr)
>> +                       break;
>> +
>> +               if (~p->arg.flags & PM_SCAN_WP_MATCHING)
>> +                       continue;
>> +               if (~categories & PAGE_IS_WRITTEN)
>> +                       continue;
>> +
>> +               make_uffd_wp_pte(vma, addr, pte);
>> +               if (!flush) {
>> +                       start = addr;
>> +                       flush = true;
>> +               }
> 
> A quick improvement:
> 
> /* instead of `flush` declaration */ unsigned long flush_end = 0;
> 
> if (!flush_end)
>   start = addr;
> flush_end = next;
I'll update.

> 
>> +       }
>> +
>> +       if (flush)
>> +               flush_tlb_range(vma, start, addr);
> 
> And here:
> if (flush_end)
>   flush_tlb_range(vma, start, flush_end);
> 
>> +       pte_unmap_unlock(start_pte, ptl);
>> +       arch_leave_lazy_mmu_mode();
>> +
>> +       cond_resched();
>> +       return ret;
>> +}
> 
> [...]
>> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>> +{
>> +       struct mmu_notifier_range range;
>> +       struct pagemap_scan_private p;
>> +       unsigned long walk_start;
>> +       size_t n_ranges_out = 0;
>> +       int ret;
>> +
>> +       memset(&p, 0, sizeof(p));
>> +       ret = pagemap_scan_get_args(&p.arg, uarg);
>> +       if (ret)
>> +               return ret;
>> +
>> +       p.masks_of_interest = MASKS_OF_INTEREST(p.arg);
> 
> Please inline the macro as here is the only use of it.
Got it.

> 
> [...]
>> +       walk_start = p.arg.start;
>> +       for (; walk_start < p.arg.end; walk_start = p.arg.walk_end) {
> 
> Nit: the initialization statement can now be part of the for().
Sure.

> 
>> +               int n_out;
>> +
>> +               if (fatal_signal_pending(current)) {
>> +                       ret = -EINTR;
>> +                       break;
>> +               }
>> +
>> +               ret = mmap_read_lock_killable(mm);
>> +               if (ret)
>> +                       break;
>> +               ret = walk_page_range(mm, walk_start, p.arg.end,
>> +                                     &pagemap_scan_ops, &p);
>> +               mmap_read_unlock(mm);
>> +
>> +               n_out = pagemap_scan_flush_buffer(&p);
>> +               if (n_out < 0)
>> +                       ret = n_out;
>> +               else
>> +                       n_ranges_out += n_out;
>> +
>> +               if (!ret)
>> +                       p.walk_end_addr = p.arg.end;
>> +
>> +               if (ret != -ENOSPC || p.arg.vec_len - 1 == 0 ||
>> +                   p.found_pages == p.arg.max_pages)
>> +                       break;
> 
> The second condition is equivalent to `p.arg.vec_len == 1`, but why is
> that an ending condition? Isn't the last entry enough to gather one
> more range? (The walk could have returned -ENOSPC due to buffer full
> and after flushing it could continue with the last free entry.)
Now we are walking the entire range walk_page_range(). We don't break loop
when we get -ENOSPC as this error may only mean that the temporary buffer
is full. So we need check if max pages have been found or output buffer is
full or ret is 0 or any other error. When p.arg.vec_len = 1 is end
condition as the last entry is in cur. As we have walked over the entire
range, cur must be full after which the walk returned.

So current condition is necessary. I've double checked it. I'll change it
to `p.arg.vec_len == 1`.

> 
> [...]
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -259,6 +259,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>>                 unsigned long cp_flags);
>>
>>  bool is_hugetlb_entry_migration(pte_t pte);
>> +bool is_hugetlb_entry_hwpoisoned(pte_t pte);
>>  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
>>
>>  #else /* !CONFIG_HUGETLB_PAGE */
>> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
>> index b7b56871029c5..1c9d38af1015e 100644
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -305,4 +305,63 @@ typedef int __bitwise __kernel_rwf_t;
>>  #define RWF_SUPPORTED  (RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>>                          RWF_APPEND)
>>
>> +/* Pagemap ioctl */
>> +#define PAGEMAP_SCAN   _IOWR('f', 16, struct pm_scan_arg)
>> +
>> +/* Bits are set in flags of the page_region and masks in pm_scan_args */
> 
> "Bitmasks provided in pm_scan_args masks and reported in
> page_region.categories."
Okay.

> 
>> +#define PAGE_IS_WPALLOWED      (1 << 0)
>> +#define PAGE_IS_WRITTEN                (1 << 1)
>> +#define PAGE_IS_FILE           (1 << 2)
>> +#define PAGE_IS_PRESENT                (1 << 3)
>> +#define PAGE_IS_SWAPPED                (1 << 4)
>> +#define PAGE_IS_PFNZERO                (1 << 5)
>> +#define PAGE_IS_HUGE           (1 << 6)
>> +
>> +/*
>> + * struct page_region - Page region with flags
>> + * @start:     Start of the region
>> + * @end:       End of the region (exclusive)
>> + * @categories:        PAGE_IS_* category bitmask for the region
>> + */
>> +struct page_region {
>> +       __u64 start;
>> +       __u64 end;
>> +       __u64 categories;
>> +};
>> +
>> +/* Flags for PAGEMAP_SCAN ioctl */
>> +#define PM_SCAN_WP_MATCHING    (1 << 0)        /* Write protect the pages matched. */
>> +#define PM_SCAN_CHECK_WPASYNC  (1 << 1)        /* Abort the scan when a non-WP-enabled page is found. */
>> +
>> +/*
>> + * struct pm_scan_arg - Pagemap ioctl argument
>> + * @size:              Size of the structure
>> + * @flags:             Flags for the IOCTL
>> + * @start:             Starting address of the region
>> + * @end:               Ending address of the region
>> + * @walk_end           Address where the scan stopped (written by kernel).
>> + *                     walk_end == end informs that the scan completed on entire range.
> 
> Can we ensure this holds also for the tagged pointers?
No, we cannot.

> 
>> + * @vec:               Address of page_region struct array for output
>> + * @vec_len:           Length of the page_region struct array
>> + * @max_pages:         Optional limit for number of returned pages (0 = disabled)
>> + * @category_inverted: PAGE_IS_* categories which values match if 0 instead of 1
>> + * @category_mask:     Skip pages for which any category doesn't match
>> + * @category_anyof_mask: Skip pages for which no category matches
>> + * @return_mask:       PAGE_IS_* categories that are to be reported in `page_region`s returned
>> + */
> [...]
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
