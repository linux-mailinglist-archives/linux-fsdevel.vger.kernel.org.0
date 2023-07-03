Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2BE745862
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGCJbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCJbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:31:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB95CD;
        Mon,  3 Jul 2023 02:31:00 -0700 (PDT)
Received: from [192.168.43.110] (unknown [116.71.191.217])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 65E216606F57;
        Mon,  3 Jul 2023 10:30:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688376659;
        bh=w0YKyzQE0llhRjeo3PCXYRlQ1d3QGoB4qd/RGVz6sos=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=OidjyY4PvZPf8xwFy1Cebaujb5ufeFlWana6wOekGuauXeIy6Sp7pbAgyMKlEjxCU
         Cee/KL3B22KRXKEhszE5x/jDM9NCwWhS0Rd0rFieMGCEcGPFf7otZvArWCrRUdxkBJ
         b1GwdmaWZs0FCvxlgjLMw2k6eUMEXu/G0ugAVfLwbtE3QD8I/M0HZ9IIs2auOPuFqd
         dvdSTU1sShSAMO95gKvJ4RPeU8lCLC5owpQdngicC0Swuio1sgBqRYGlxAWwKNN9EC
         bhpssWzj/WSSGWyhmY6wmnYgftXm5UVvO9gLqRJPImklzd7h60Exibe7e7wsQ7Vhfh
         e34SZN9gTxXcg==
Message-ID: <1705991c-ea7c-f78c-421d-2900463985ab@collabora.com>
Date:   Mon, 3 Jul 2023 14:30:41 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
Subject: Re: [PATCH v22 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230628095426.1886064-1-usama.anjum@collabora.com>
 <20230628095426.1886064-3-usama.anjum@collabora.com>
 <CABb0KFFDCZ9E3sTukmdk3jViOJmP33xOoVNg37ACoynD97ZpwA@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFFDCZ9E3sTukmdk3jViOJmP33xOoVNg37ACoynD97ZpwA@mail.gmail.com>
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

On 6/28/23 5:11 PM, Michał Mirosław wrote:
> Hi Muhammad,
> 
> I'd really like to reduce the number of conditionals in this code by a
> third. I believe it is possible if we agree to rework the API a bit
> (making it always a GET operation with optional WP) and relax some of
> the restrictions on the input values.
I have discussed this multiple times in revisions that why we need the GET,
GET+WP and WP operations. We cannot remove only WP operation. Please
consult previous revisions on why we need exclusive WP operation without GET.

> 
> Also please include *all* changes you make in a patch in the changelog
> - I just noticed e.g. a `mmu_notifier` code that I haven't seen before
> in the review.
mmu_notifier code was added v16. I'll try to write more longer specific
changelog.

> 
> A general request from me would be to move all the page classification
> code to one place. That would mean replacing:
> 
>> +               bitmap = PM_SCAN_FLAGS(is_written, false,
>> +                                      pmd_present(*pmd), is_swap_pmd(*pmd),
>> +                                      pmd_present(*pmd) && is_zero_pfn(pmd_pfn(*pmd)));
> 
> With:
> 
>        category_flags = pmd_page_category_flags(*pmd);
> 
> ... and adding a pmd_page_category_flags() and pte/hugepage versions
> together at the top. The idea here is to separate concerns: split
> classification of pages from the code acting on the classification
> results and be able to easily understand (and review for correctness)
> how corresponding classes are derived from PTE and PMD values.
This is just a cosmetic change. I don't think we should keep on doing
cosmetic change when code is already readable and obvious. At this rate I
would keep doing cosmetic changes on the argument that we are making is
more easier to read. I've been working on this patch and particularly
task_mmu.c file from last 1 year. The current code is in same flavor as the
rest of the `task_mmu.c` file. All the functions above are using #ifdef THP.

> 
> I'd prefer the naming of the functions and variables to follow that it
> is a classification result, not a generic "bitmap" or "flags", so that
> it's harder to confuse them with page flags as used elsewhere in the
> kernel.
> 
> (inline review follows)
> 
> BTW, thanks for doing this!
> 
> On Wed, 28 Jun 2023 at 12:00, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> [...]
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 507cd4e59d07..be747fb89827 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
> [...]
>> +#define PM_SCAN_REQUIRE_UFFD   (1ULL << 63)
>> +
>> +#define PM_SCAN_FOUND_MAX_PAGES        (1)
>> +#define PM_SCAN_END_WALK       (-256)
> [...]
>> +static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
>> +                                 struct mm_walk *walk)
>> +{
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +
>> +       if ((p->flags & PM_SCAN_REQUIRE_UFFD) && (!userfaultfd_wp_async(vma) ||
>> +           !userfaultfd_wp_use_markers(vma)))
>> +               return -EPERM;
> 
> p->vma_can_wp = userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma);
> 
> And then use that in classification functions and for skipping WP for
> pages not prepared for that. The PM_SCAN_REQUIRE_UFFD won't be needed
> then.
No we don't want to skip, but return error if a VMA isn't setup to use WP
Async. Even after adding this new `vma_can_wp` variable. We'll have to
check in every test_walk() if UFFD is initialized on the VMA for every VMA.
At max, `vma_can_wp` can be setup to hold the true or false for
PM_SCAN_REQUIRE_UFFD which makes it cosmetic change again.

> 
>> +
>> +       if (vma->vm_flags & VM_PFNMAP)
>> +               return 1;
> 
> Why do we skip VM_PFNMAP vmas? This will skip over at least VDSO and
> VVAR pages. Those two are not that big a problem, but it should be at
> least documented what ranges are skipped and why.
We are following pagemap_read(). We don't want to expose any additional
information which pagemap_read() doesn't show.

> 
>> +
>> +       return 0;
>> +}
>> +
>> +static int pagemap_scan_output(unsigned long bitmap,
>> +                              struct pagemap_scan_private *p,
>> +                              unsigned long addr, unsigned int n_pages)
>> +{
>> +       struct page_region *cur_buf = &p->cur_buf;
>> +
>> +       if (!n_pages)
>> +               return -EINVAL;
> 
> How can this happen?
This was there to check validity of n_pages before proceeding. By doing
static analysis, I can see that it isn't needed anymore and can be removed.

> 
>> +       bitmap &= p->return_mask;
>> +
>> +       if (cur_buf->flags == bitmap &&
>> +           cur_buf->start + cur_buf->len * PAGE_SIZE == addr) {
> 
> BTW, maybe the ranges returned to the user could also use start .. end
> form, and then this would be simplified to `cur->flags ==
> categories_to_report && cur->end == addr`.
> 
>> +               cur_buf->len += n_pages;
>> +               p->found_pages += n_pages;
>> +       } else {
>> +               if (cur_buf->len) {
>> +                       if (p->vec_buf_index >= p->vec_buf_len)
>> +                               return PM_SCAN_END_WALK;
>> +
>> +                       memcpy(&p->vec_buf[p->vec_buf_index], cur_buf,
>> +                              sizeof(*p->vec_buf));
>> +                       p->vec_buf_index++;
>> +               }
>> +
>> +               cur_buf->start = addr;
>> +               cur_buf->len = n_pages;
>> +               cur_buf->flags = bitmap;
>> +               p->found_pages += n_pages;
>> +       }
>> +
>> +       if (p->found_pages == p->max_pages)
>> +               return PM_SCAN_FOUND_MAX_PAGES;
> 
> Since we now return the address the walk ended at, what is the
> difference for PM_SCAN_END_WALK and PM_SCAN_FOUND_MAX_PAGES, and do we
> still need any of those instead of -ENOSPC or `n_pages !=
> scan_output(...)` check?
Yes, we need two different return codes from here to judge if we need to wp
the current range or not. When PM_SCAN_FOUND_MAX_PAGES is returned we need
to wp the current range. But when END_WALK is returned we don't need to
perform wp and return.

> 
>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>> +                                 unsigned long end, struct mm_walk *walk)
>> +{
>> +       bool is_written, flush = false, interesting = true;
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       unsigned long bitmap, addr = end;
>> +       pte_t *pte, *orig_pte, ptent;
>> +       spinlock_t *ptl;
>> +       int ret = 0;
>> +
>> +       arch_enter_lazy_mmu_mode();
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +       ptl = pmd_trans_huge_lock(pmd, vma);
>> +       if (ptl) {
>> +               unsigned long n_pages = (end - start)/PAGE_SIZE;
>> +
>> +               if (n_pages > p->max_pages - p->found_pages)
>> +                       n_pages = p->max_pages - p->found_pages;
>> +
>> +               is_written = !is_pmd_uffd_wp(*pmd);
>> +
>> +               bitmap = PM_SCAN_FLAGS(is_written, false,
>> +                                      pmd_present(*pmd), is_swap_pmd(*pmd),
>> +                                      pmd_present(*pmd) && is_zero_pfn(pmd_pfn(*pmd)));
>> +
>> +               if (IS_PM_SCAN_GET(p->flags))
>> +                       interesting = pagemap_scan_is_interesting_page(bitmap, p);
>> +
>> +               if (interesting) {
>> +                       /*
>> +                        * Break huge page into small pages if the WP operation
>> +                        * need to be performed is on a portion of the huge page.
>> +                        */
>> +                       if (is_written && IS_PM_SCAN_WP(p->flags) &&
>> +                           n_pages < HPAGE_SIZE/PAGE_SIZE) {
>> +                               spin_unlock(ptl);
>> +
>> +                               split_huge_pmd(vma, pmd, start);
>> +                               goto process_smaller_pages;
>> +                       }
>> +
>> +                       if (IS_PM_SCAN_GET(p->flags))
>> +                               ret = pagemap_scan_output(bitmap, p, start, n_pages);
>> +
>> +                       if (IS_PM_SCAN_WP(p->flags) && is_written && ret >= 0) {
>> +                               make_uffd_wp_pmd(vma, start, pmd);
>> +                               flush_tlb_range(vma, start, end);
>> +                       }
>> +               }
>> +
>> +               spin_unlock(ptl);
>> +               arch_leave_lazy_mmu_mode();
>> +
>> +               return ret;
>> +       }
> 
> Could you split the THP code and use it here like:
> 
> enter_lazy_mmu();
> 
> ret = scan_thp(...);
> if (ret != -ENOTTY) {
>   leave_lazy_mmu();
>   return ret;
> }
> 
> To avoid having #ifdef here, it can be moved to the scan_thp() only
> (either in the body or having a dummy `return -ENOTTY;` version in an
> #else block).
I'm following the flavour of code in this file as explained above. This
isn't needed.

> 
> BTW, there's no `cond_resched()` in the THP case - is that intentional?
AFAIU, processing of THP here is fast as compared to 512 iterations over
smaller pages. So cond_resched() isn't present here. But overall, I've not
seen cond_resched() being used after THPs.

> 
>> +
>> +process_smaller_pages:
>> +#endif
>> +
>> +       orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
>> +       if (!pte) {
>> +               walk->action = ACTION_AGAIN;
>> +               return 0;
>> +       }
>> +
>> +       for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE) {
>> +               ptent = ptep_get(pte);
>> +               is_written = !is_pte_uffd_wp(ptent);
>> +
>> +               bitmap = PM_SCAN_FLAGS(is_written, pagemap_scan_is_file(vma, ptent, addr),
>> +                                      pte_present(ptent), is_swap_pte(ptent),
>> +                                      pte_present(ptent) && is_zero_pfn(pte_pfn(ptent)));
>> +
>> +               if (IS_PM_SCAN_GET(p->flags)) {
>> +                       interesting = pagemap_scan_is_interesting_page(bitmap, p);
> 
> If we consider GET as always done, this can be:
> 
> if (!is_interesting) continue;
> 
> And that would simplify the code greatly.
> 
>> +                       if (interesting)
>> +                               ret = pagemap_scan_output(bitmap, p, addr, 1);
>> +               }
>> +
>> +               if (IS_PM_SCAN_WP(p->flags) && is_written && interesting &&
>> +                   ret >= 0) {
>> +                       make_uffd_wp_pte(vma, addr, pte);
>> +                       flush = true;
>> +               }
>> +       }
>> +
>> +       if (flush)
>> +               flush_tlb_range(vma, start, addr);
> 
> Would optimizing the TLB flush range be beneficial here? If yes, the
> loop above could do:
> 
> flush_start = end;
> flush_end = end;
> ...
> for (...) {
>   if (mark_wp) {
>     make_wp();
>     if (flush_start > addr)
>       flush_start = addr;
>     flush_end = addr;
>   }
> }
> 
> to reduce the flushed range.
Just tried this. There is some bug or hidden restriction. It isn't working.
Maybe we can look at it latter. Reducing the flush size may actually be
beneficial.

> 
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
>> +       bool is_written, interesting = true;
>> +       struct hstate *h = hstate_vma(vma);
>> +       unsigned long bitmap;
>> +       spinlock_t *ptl;
>> +       int ret = 0;
>> +       pte_t ptent;
>> +
>> +       if (IS_PM_SCAN_WP(p->flags) && n_pages < HPAGE_SIZE/PAGE_SIZE)
>> +               return -EINVAL;
> 
> Shouldn't this be checked after the `n_pages` is reduced? BTW, maybe
> check it only if the page `is_written` to avoid the conditional for
> all walks where WP is not used?
No, we (you and me) had reached to this current state after discussion. We
are returning -EINVAL here for the user to understand that he had not
passed the entire hugetlb page address range when specified WP op.

> 
>> +
>> +       if (n_pages > p->max_pages - p->found_pages)
>> +               n_pages = p->max_pages - p->found_pages;
> [...]
> 
> Proposing the relaxed API (and, while at it, less generic constant and
> field names) below.
> 
>> +static int pagemap_scan_args_valid(struct pm_scan_arg *arg, unsigned long start,
>> +                                  unsigned long end, struct page_region __user *vec)
>> +{
>> +       /* Detect illegal size, flags, len and masks */
>> +       if (arg->size != sizeof(struct pm_scan_arg))
>> +               return -EINVAL;
> 
>> +       if (!arg->flags)
>> +               return -EINVAL;
>> +       if (arg->flags & ~PM_SCAN_OPS)
>> +               return -EINVAL;
> 
> if (arg->flags & ~PM_SCAN_FLAGS)
>   return -EINVAL;
We need if (!flags) condition for the case when flag is zero.

> 
>> +       if (!(end - start))
>> +               return -EINVAL;
> 
> Remove. Nothing bad will happen when trying to scan an empty range.
We should return error. It is user's fault for not providing the correct range.

> 
>> +       if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask |
>> +            arg->return_mask) & ~PM_SCAN_BITS_ALL)
>> +               return -EINVAL;
> 
> if ((...) & ~PM_SCAN_PAGE_CATEGORIES)
>   return -EINVAL;
> 
>> +       if (!arg->required_mask && !arg->anyof_mask &&
>> +           !arg->excluded_mask)
>> +               return -EINVAL;
> 
> Remove. Will inspect all pages then.
> 
>> +       if (!arg->return_mask)
>> +               return -EINVAL;
> 
> Remove. Will not return any ranges then. (But will WP, if requested.)
> 
>> +       /* Validate memory range */
>> +       if (!IS_ALIGNED(start, PAGE_SIZE))
>> +               return -EINVAL;
>> +       if (!access_ok((void __user *)start, end - start))
>> +               return -EFAULT;
> 
>> +       if (IS_PM_SCAN_GET(arg->flags)) {
> 
> Remove. Do GET always.
> 
>> +               if (arg->vec_len == 0)
>> +                       return -EINVAL;
> 
> Remove. Will end the walk at the first matching page (and return its
> address in `start`).
> 
>> +               if (!vec)
>> +                       return -EINVAL;
>> +               if (!access_ok((void __user *)vec,
>> +                              arg->vec_len * sizeof(struct page_region)))
>> +                       return -EFAULT;
> 
> Check only if vec_len != 0. BTW, return EFAULT for `!vec`.
> 
>> +       }
>> +
>> +       if (IS_PM_SCAN_WP(arg->flags) && !IS_PM_SCAN_GET(arg->flags) &&
>> +           arg->max_pages)
>> +               return -EINVAL;
> 
> With return_mask == 0, arg->max_pages will be ignored anyway. We can
> just document that this limits the pages reported in the output
> vector. (And from that follows that if not returning anything, the
> value doesn't make a difference.)
I'm sorry. I don't see any value in channgig the interface again. The
interface is based on requirement, not the simplification of the code.

> 
> [...]
>> +       p.max_pages = (arg.max_pages) ? arg.max_pages : ULONG_MAX;
>> +       p.found_pages = 0;
>> +       p.required_mask = arg.required_mask;
>> +       p.anyof_mask = arg.anyof_mask;
>> +       p.excluded_mask = arg.excluded_mask;
>> +       p.return_mask = arg.return_mask;
>> +       p.flags = arg.flags;
>> +       p.flags |= ((p.required_mask | p.anyof_mask | p.excluded_mask) &
>> +                   PAGE_IS_WRITTEN) ? PM_SCAN_REQUIRE_UFFD : 0;
>> +       p.cur_buf.start = p.cur_buf.len = p.cur_buf.flags = 0;
>> +       p.vec_buf = NULL;
>> +       p.vec_buf_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
> 
> This needs to be less by 1 to account for the entry in p.cur_buf.
No, that would be bug.

> 
>> +       /*
>> +        * Allocate smaller buffer to get output from inside the page walk
>> +        * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
>> +        * we want to return output to user in compact form where no two
>> +        * consecutive regions should be continuous and have the same flags.
>> +        * So store the latest element in p.cur_buf between different walks and
>> +        * store the p.cur_buf at the end of the walk to the user buffer.
>> +        */
>> +       if (IS_PM_SCAN_GET(p.flags)) {
> 
> if (p.vec_len != 0)
No, this is wrong.

> 
>> +               p.vec_buf = kmalloc_array(p.vec_buf_len, sizeof(*p.vec_buf),
>> +                                         GFP_KERNEL);
>> +               if (!p.vec_buf)
>> +                       return -ENOMEM;
>> +       }
>> +
>> +       if (IS_PM_SCAN_WP(p.flags)) {
>> +               mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
>> +                                       mm, start, end);
>> +               mmu_notifier_invalidate_range_start(&range);
>> +       }
> 
> Please add a comment why this is needed.
This was added when we had left using change_pmd_range(). This is a
notification that protection for the range has been changed.

> 
>> +       walk_start = walk_end = start;
>> +       while (walk_end < end && !ret) {
>> +               if (IS_PM_SCAN_GET(p.flags)) {
> 
> if (p.vec_len)
> 
>> +                       p.vec_buf_index = 0;
>> +
>> +                       /*
>> +                        * All data is copied to cur_buf first. When more data
>> +                        * is found, we push cur_buf to vec_buf and copy new
>> +                        * data to cur_buf. Subtract 1 from length as the
>> +                        * index of cur_buf isn't counted in length.
>> +                        */
>> +                       empty_slots = arg.vec_len - vec_index;
>> +                       p.vec_buf_len = min(p.vec_buf_len, empty_slots - 1);
>> +               }
>> +
>> +               ret = mmap_read_lock_killable(mm);
>> +               if (ret)
>> +                       goto return_status;
> 
> This could be _interruptible() now as we can return early overwriting
> `start` so that userspace can detect that the walk was interrupted by
> a signal (start != end).
> 
>> +               walk_end = min((walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK, end);
>> +
>> +               ret = walk_page_range(mm, walk_start, walk_end,
>> +                                     &pagemap_scan_ops, &p);
>> +               mmap_read_unlock(mm);
>> +
>> +               if (ret && ret != PM_SCAN_FOUND_MAX_PAGES &&
>> +                   ret != PM_SCAN_END_WALK)
>> +                       goto return_status;
> 
> So now there is no difference in the two special error values.
Inside pagemap_scan_pmd_entry() the purpose is different.

> 
>> +               walk_start = walk_end;
>> +               if (IS_PM_SCAN_GET(p.flags) && p.vec_buf_index) {
> 
> `if (p.vec_buf_index)` should be enough, as if not reporting the
> ranges, the index will never increase.
Agreed. Will update.

> 
>> +                       if (copy_to_user(&vec[vec_index], p.vec_buf,
>> +                                        p.vec_buf_index * sizeof(*p.vec_buf))) {
>> +                               /*
>> +                                * Return error even though the OP succeeded
>> +                                */
>> +                               ret = -EFAULT;
>> +                               goto return_status;
>> +                       }
>> +                       vec_index += p.vec_buf_index;
> 
> p.vec_buf_index = 0;
> 
> ... so that there is no need to do that at every start of the loop iteration.
Okay.

> 
>> +               }
>> +       }
>> +
>> +       if (p.cur_buf.len) {
>> +               if (copy_to_user(&vec[vec_index], &p.cur_buf, sizeof(p.cur_buf))) {
>> +                       ret = -EFAULT;
>> +                       goto return_status;
>> +               }
>> +               vec_index++;
>> +       }
>> +
>> +       ret = vec_index;
>> +
>> +return_status:
> 
> The label name looks too narrowing, considering what is being done
> here now. Maybe just 'out', as there is no other non-trivial exit path
> from the function?
Okay.

> 
>> +       arg.start = (unsigned long)walk_end;
>> +       if (copy_to_user(&uarg->start, &arg.start, sizeof(arg.start)))
>> +               ret = -EFAULT;
>> +
>> +       if (IS_PM_SCAN_WP(p.flags))
>> +               mmu_notifier_invalidate_range_end(&range);
> 
> With removal of the OP_GET, there is only a single flag left. I don't
> think it is useful then to hide it behind a macro. It should be
> readable as `p.flags & PM_SCAN_DO_WP`.
> 
> [...]
>> +/* Bits are set in flags of the page_region and masks in pm_scan_args */
>> +#define PAGE_IS_WRITTEN                (1 << 0)
>> +#define PAGE_IS_FILE           (1 << 1)
>> +#define PAGE_IS_PRESENT                (1 << 2)
>> +#define PAGE_IS_SWAPPED                (1 << 3)
>> +#define PAGE_IS_PFNZERO                (1 << 4)
> 
> Please add PAGE_IS_UFFD_WP_ENABLED (or a shorter name) - this would be
> populated from `p->vma_can_wp` in the `test_walk` implementation
> above.
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
