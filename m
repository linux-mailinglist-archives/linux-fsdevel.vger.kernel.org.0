Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA1D758214
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 18:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjGRQ2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 12:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjGRQ2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:28:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DABE77;
        Tue, 18 Jul 2023 09:27:59 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.184.252])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 44CA06607069;
        Tue, 18 Jul 2023 17:27:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689697677;
        bh=xri/7NiFFtC1ErMdL5z9Id14lXfscVhH+yKOPXCwmo8=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ledU0TTHS7bQL/nKzSLDHqlzhDyNweNtbOdtRBsYCWAiql5AL0SXQGSL5qFcHkwvX
         MpGxk1LPkN1AeL2mQMgGwV4E48Da2WTV5R+RTafXVUTe6k+pFSLesxA2R1EH/GWV3f
         nHxRJSa1RkA7xpzlVXNJDyyaAj/5OsAkRwc9HmbcSg4YjQO9ue/goKFbQpcnpKZH9l
         YR80MyJnc2XAT8fHGhOpjRhDmmdac0MkBjzlhcW4Psv4zy6N5IvNwpQb/XDaD15WHy
         kZyyveSc5zOwqFBwI55NHQLZmZvgx3iDxbdrjNR5Is5kDbhi+KZxc0Yi9kZsPeyOrz
         Sgj8nfRU4mQLQ==
Message-ID: <ff953d3f-2a55-44dd-c69c-b82b7944448a@collabora.com>
Date:   Tue, 18 Jul 2023 21:27:46 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v25 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     Andrei Vagin <avagin@gmail.com>
References: <20230713101415.108875-1-usama.anjum@collabora.com>
 <20230713101415.108875-3-usama.anjum@collabora.com>
 <CANaxB-zMhhi+kHZ+3w9yzogo6fKjR=swBkuA-s88Qs5oeLRAYQ@mail.gmail.com>
 <c379c99f-2466-6056-4dd6-90d0a202c13c@collabora.com>
 <CANaxB-y2C+gu9Z5MyKQEZATU6dscd04+PeJNNgvhYLp+31_Nrw@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CANaxB-y2C+gu9Z5MyKQEZATU6dscd04+PeJNNgvhYLp+31_Nrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/18/23 9:08 PM, Andrei Vagin wrote:
...
>>>> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
>>>> +                                int depth, struct mm_walk *walk)
>>>> +{
>>>> +       unsigned long n_pages = (end - addr)/PAGE_SIZE;
>>>> +       struct pagemap_scan_private *p = walk->private;
>>>> +       struct vm_area_struct *vma = walk->vma;
>>>> +       bool interesting = true;
>>>> +       unsigned long bitmap;
>>>> +       int ret = 0;
>>>> +
>>>> +       if (!vma)
>>>> +               return 0;
>>>> +
>>>> +       bitmap = PM_SCAN_FLAGS(false, false, false, false, false);
>>>> +
>>>> +       if (IS_PM_SCAN_GET(p->flags))
>>>> +               interesting = pagemap_scan_is_interesting_page(bitmap, p);
>>>> +
>>>> +       if (interesting) {
>>>> +               if (IS_PM_SCAN_GET(p->flags)) {
>>>> +                       if (n_pages > p->max_pages - p->found_pages)
>>>> +                               n_pages = p->max_pages - p->found_pages;
>>>> +
>>>> +                       ret = pagemap_scan_output(bitmap, p, addr, n_pages);
>>>> +               }
>>>> +
>>>> +               if (IS_PM_SCAN_WP(p->flags) && !ret &&
>>>> +                   uffd_wp_range(vma, addr, end - addr, true) < 0)
>>>
>>> Why do we need to call uffd_wp_range for holes? Should we call
>>> flush_tlb_range after it?
> 
> Did you skip this question?
Sorry, missed it the first time. In case of holes, there isn't any pmd or
pte. But we need to place the PTE markers indicating that this memory is
WPed. So we can parse the address range from PGD ourselves and place the
markers. Or we can use the uffd_wp_range(). Using uffd_wp_range() for this
case seems optimal. We don't need to do flush as uffd_wp_range() flushes
the range by itself.

> 
>>>
>>>> +                       ret = -EINVAL;
>>>> +       }
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +static const struct mm_walk_ops pagemap_scan_ops = {
>>>> +       .test_walk = pagemap_scan_test_walk,
>>>> +       .pmd_entry = pagemap_scan_pmd_entry,
>>>> +       .pte_hole = pagemap_scan_pte_hole,
>>>> +       .hugetlb_entry = pagemap_scan_hugetlb_entry,
>>>> +};
>>>> +
>>>> +static int pagemap_scan_args_valid(struct pm_scan_arg *arg, unsigned long start,
>>>> +                                  unsigned long end, struct page_region __user *vec)
>>>> +{
>>>> +       /* Detect illegal size, flags, len and masks */
>>>> +       if (arg->size != sizeof(struct pm_scan_arg))
>>>> +               return -EINVAL;
>>>> +       if (!arg->flags)
>>>> +               return -EINVAL;
>>>> +       if (arg->flags & ~PM_SCAN_OPS)
>>>> +               return -EINVAL;
>>>> +       if (!(end - start))
>>>> +               return -EINVAL;
>>>> +       if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask |
>>>> +            arg->return_mask) & ~PM_SCAN_BITS_ALL)
>>>> +               return -EINVAL;
>>>> +       if (!arg->required_mask && !arg->anyof_mask &&
>>>> +           !arg->excluded_mask)
>>>> +               return -EINVAL;
>>>> +       if (!arg->return_mask)
>>>> +               return -EINVAL;
>>>> +
>>>> +       /* Validate memory range */
>>>> +       if (!IS_ALIGNED(start, PAGE_SIZE))
>>>> +               return -EINVAL;
>>>> +       if (!access_ok((void __user *)start, end - start))
>>>> +               return -EFAULT;
>>>> +
>>>> +       if (IS_PM_SCAN_GET(arg->flags)) {
>>>> +               if (arg->vec_len == 0)
>>>> +                       return -EINVAL;
>>>> +               if (!vec)
>>>> +                       return -EFAULT;
>>>> +               if (!access_ok((void __user *)vec,
>>>> +                              arg->vec_len * sizeof(struct page_region)))
>>>> +                       return -EFAULT;
>>>> +       }
>>>> +
>>>> +       if (IS_PM_SCAN_WP(arg->flags) && !IS_PM_SCAN_GET(arg->flags) &&
>>>> +           arg->max_pages)
>>>> +               return -EINVAL;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long __arg)
>>>> +{
>>>> +       struct pm_scan_arg __user *uarg = (struct pm_scan_arg __user *)__arg;
>>>> +       unsigned long long start, end, walk_start, walk_end;
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
>>>> +       end = untagged_addr((unsigned long)arg.end);
>>>> +       vec = (struct page_region __user *)untagged_addr((unsigned long)arg.vec);
>>>> +
>>>> +       ret = pagemap_scan_args_valid(&arg, start, end, vec);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       p.max_pages = (arg.max_pages) ? arg.max_pages : ULONG_MAX;
>>>> +       p.found_pages = 0;
>>>> +       p.required_mask = arg.required_mask;
>>>> +       p.anyof_mask = arg.anyof_mask;
>>>> +       p.excluded_mask = arg.excluded_mask;
>>>> +       p.return_mask = arg.return_mask;
>>>> +       p.flags = arg.flags;
>>>> +       p.flags |= ((p.required_mask | p.anyof_mask | p.excluded_mask) &
>>>> +                   PAGE_IS_WRITTEN) ? PM_SCAN_REQUIRE_UFFD : 0;
>>>> +       p.cur_buf.start = p.cur_buf.len = p.cur_buf.flags = 0;
>>>> +       p.vec_buf = NULL;
>>>> +       p.vec_buf_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
>>>> +       p.vec_buf_index = 0;
>>>> +       p.end_addr = 0;
>>>> +
>>>> +       /*
>>>> +        * Allocate smaller buffer to get output from inside the page walk
>>>> +        * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
>>>> +        * we want to return output to user in compact form where no two
>>>> +        * consecutive regions should be continuous and have the same flags.
>>>> +        * So store the latest element in p.cur_buf between different walks and
>>>> +        * store the p.cur_buf at the end of the walk to the user buffer.
>>>> +        */
>>>> +       if (IS_PM_SCAN_GET(p.flags)) {
>>>> +               p.vec_buf = kmalloc_array(p.vec_buf_len, sizeof(*p.vec_buf),
>>>> +                                         GFP_KERNEL);
>>>> +               if (!p.vec_buf)
>>>> +                       return -ENOMEM;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * Protection change for the range is going to happen.
>>>> +        */
>>>> +       if (IS_PM_SCAN_WP(p.flags)) {
>>>> +               mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
>>>> +                                       mm, start, end);
>>>> +               mmu_notifier_invalidate_range_start(&range);
>>>> +       }
>>>> +
>>>> +       walk_start = walk_end = start;
>>>> +       while (walk_end < end && !ret) {
>>>> +               if (IS_PM_SCAN_GET(p.flags)) {
>>>> +                       /*
>>>> +                        * All data is copied to cur_buf first. When more data
>>>> +                        * is found, we push cur_buf to vec_buf and copy new
>>>> +                        * data to cur_buf. Subtract 1 from length as the
>>>> +                        * index of cur_buf isn't counted in length.
>>>> +                        */
>>>> +                       empty_slots = arg.vec_len - vec_index;
>>>> +                       p.vec_buf_len = min(p.vec_buf_len, empty_slots - 1);
>>>> +               }
>>>> +
>>>
>>> I still don't understand why we don't want/need to check for pending signals.
>> We haven't added it as other existing code such as mincore() and
> 
> It doesn't convince me. There should be reasons to do or not to do
> certain things.
> We can't say how long this loop can be running, so it is the reason
> why we can want
> to check pending signals.
> 
>> pagemap_read() don't have it either.
> 
> I already explained that this case is different, because the size of
> the output buffer is
> limited for pagemap_read.
> 
>> Also mmap_read_lock_killable would return error if there is some critical single pending.\
> 
> It isn't completely true. It doesn't return errors in the fast path
> when it takes the lock right
> away. It checks signals only when it needs to wait for the lock.
> 
Okay. It seems reasonable. I'll add the following at the start of the loop:

	if (fatal_signal_pending(current))
		return -EINTR;


>>
>>>
>>>> +               ret = mmap_read_lock_killable(mm);
>>>> +               if (ret)
>>>> +                       goto out;
>>>> +
>>>> +               walk_end = min((walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK, end);
>>>> +
>>>> +               ret = walk_page_range(mm, walk_start, walk_end,
>>>> +                                     &pagemap_scan_ops, &p);
>>>> +               mmap_read_unlock(mm);
>>>> +
>>>> +               if (ret == PM_SCAN_FOUND_MAX_PAGES || ret == PM_SCAN_END_WALK)
>>>> +                       arg.start = p.end_addr;
>>>
>>> nit: this check can be moved out of the loop.
>> No, ret could get replaced by error if copy_to_user() fails. So we have to
>> do this before that.
> 
> If we fail to copy a vector, it is a fatal error and it probably doesn't matter
> what end address has been there. It is up to you to leave it here or not.
Sure.


-- 
BR,
Muhammad Usama Anjum
