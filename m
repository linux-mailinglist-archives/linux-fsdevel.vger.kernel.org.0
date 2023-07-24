Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EFE75FAAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjGXPWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjGXPWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:22:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FFC133;
        Mon, 24 Jul 2023 08:22:18 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.185.74])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B5EE66070F7;
        Mon, 24 Jul 2023 16:22:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690212136;
        bh=bnkD018OLMVlnqYn0CKMoCrb5lYKht87nInr5jLEyEA=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=CYMUR0MZRmc//CNry3EtS7AIREmSN/0yFPzY/6s695eoKPkgT+ct3gadk3IlUuUIp
         MQNmt+B43Y0N1k1L8Jwy9R9/xb8ASxVQ4pQ0LCT+BODxDWSIDNDxoveDZyFbJemlpZ
         EKSLpXeBZuE0+R2a9zUOOLqRR+NyU7g/1a1fsjeaDd8OVABfsAx6hGueqFQt4Qtf4M
         93pIsSXckHctpaXrxDaA/9Mb8wZx/xOAp9UQ9PcGUkcldXmbxvGkRPX7D9sliDQ8H1
         bXZrMpGeTNHoRV7CuK2Evmq1rYOF+ykT++ZYJ1iU+jRfRyRy/S12nefGQE7SFS4eD2
         znKDMuxFs0sPA==
Message-ID: <44eddc7d-fd68-1595-7e4f-e196abe37311@collabora.com>
Date:   Mon, 24 Jul 2023 20:21:58 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [v2] fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com>
 <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
 <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com>
 <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
 <b1071d62-5c8e-1b03-d919-b3a9db520e51@collabora.com>
 <CABb0KFF6M2_94Ect72zMtaRLBpOoHjHYJA-Ube3oQAh4cXSg5w@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFF6M2_94Ect72zMtaRLBpOoHjHYJA-Ube3oQAh4cXSg5w@mail.gmail.com>
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

On 7/24/23 7:38 PM, Michał Mirosław wrote:
> On Mon, 24 Jul 2023 at 16:04, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Fixed found bugs. Testing it further.
>>
>> - Split and backoff in case buffer full case as well
>> - Fix the wrong breaking of loop if page isn't interesting, skip intead
>> - Untag the address and save them into struct
>> - Round off the end address to next page
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  fs/proc/task_mmu.c | 54 ++++++++++++++++++++++++++--------------------
>>  1 file changed, 31 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index add21fdf3c9a..64b326d0ec6d 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1985,18 +1989,19 @@ static int pagemap_scan_output(unsigned long
>> categories,
>>         unsigned long n_pages, total_pages;
>>         int ret = 0;
>>
>> +       if (!p->vec_buf)
>> +               return 0;
>> +
>>         if (!pagemap_scan_is_interesting_page(categories, p)) {
>>                 *end = addr;
>>                 return 0;
>>         }
>>
>> -       if (!p->vec_buf)
>> -               return 0;
>> -
>>         categories &= p->arg.return_mask;
> 
> This is wrong - is_interesting() check must happen before output as
> the `*end = addr` means the range should be skipped, but return 0
> requests continuing of the walk.
Will revert.

> 
>> @@ -2044,7 +2050,7 @@ static int pagemap_scan_thp_entry(pmd_t *pmd,
>> unsigned long start,
>>          * Break huge page into small pages if the WP operation
>>          * need to be performed is on a portion of the huge page.
>>          */
>> -       if (end != start + HPAGE_SIZE) {
>> +       if (end != start + HPAGE_SIZE || ret == -ENOSPC) {
> 
> Why is it needed? If `end == start + HPAGE_SIZE` then we're handling a
> full hugepage anyway.
If we weren't able to add the complete thp in the output buffer and we need
to perform WP on the entire page, we should split and rollback. Otherwise
we'll WP the entire thp and we'll lose the state on the remaining THP which
wasn't added to output.

Lets say max=100
only 100 pages would be added to output
we need to split and rollback otherwise other 412 pages would get WP

> 
>> @@ -2066,8 +2072,8 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
>> unsigned long start,
>>  {
>>         struct pagemap_scan_private *p = walk->private;
>>         struct vm_area_struct *vma = walk->vma;
>> +       unsigned long addr, categories, next;
>>         pte_t *pte, *start_pte;
>> -       unsigned long addr;
>>         bool flush = false;
>>         spinlock_t *ptl;
>>         int ret;
>> @@ -2088,12 +2094,14 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
>> unsigned long start,
>>         }
>>
>>         for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
>> -               unsigned long categories = p->cur_vma_category |
>> -                       pagemap_page_category(vma, addr, ptep_get(pte));
>> -               unsigned long next = addr + PAGE_SIZE;
>> +               categories = p->cur_vma_category |
>> +                            pagemap_page_category(vma, addr, ptep_get(pte));
>> +               next = addr + PAGE_SIZE;
> 
> Why moving the variable declarations out of the loop?
Saving spaces inside loop. What are pros of declation of variable in loop?

> 
>>
>>                 ret = pagemap_scan_output(categories, p, addr, &next);
>> -               if (next == addr)
>> +               if (ret == 0 && next == addr)
>> +                       continue;
>> +               else if (next == addr)
>>                         break;
> 
> Ah, this indeed was a bug. Nit:
> 
> if (next == addr) { if (!ret) continue; break; }
> 
>> @@ -2204,8 +2212,6 @@ static const struct mm_walk_ops pagemap_scan_ops = {
>>  static int pagemap_scan_get_args(struct pm_scan_arg *arg,
>>                                  unsigned long uarg)
>>  {
>> -       unsigned long start, end, vec;
>> -
>>         if (copy_from_user(arg, (void __user *)uarg, sizeof(*arg)))
>>                 return -EFAULT;
>>
>> @@ -2219,22 +2225,24 @@ static int pagemap_scan_get_args(struct pm_scan_arg
>> *arg,
>>              arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATEGORIES)
>>                 return -EINVAL;
>>
>> -       start = untagged_addr((unsigned long)arg->start);
>> -       end = untagged_addr((unsigned long)arg->end);
>> -       vec = untagged_addr((unsigned long)arg->vec);
>> +       arg->start = untagged_addr((unsigned long)arg->start);
>> +       arg->end = untagged_addr((unsigned long)arg->end);
>> +       arg->vec = untagged_addr((unsigned long)arg->vec);
> 
> BTW, We should we keep the tag in args writeback().
Sorry what?
After this function, the start, end and vec would be used. We need to make
sure that the address are untagged before that.

> 
>>         /* Validate memory pointers */
>> -       if (!IS_ALIGNED(start, PAGE_SIZE))
>> +       if (!IS_ALIGNED(arg->start, PAGE_SIZE))
>>                 return -EINVAL;
>> -       if (!access_ok((void __user *)start, end - start))
>> +       if (!access_ok((void __user *)arg->start, arg->end - arg->start))
>>                 return -EFAULT;
>> -       if (!vec && arg->vec_len)
>> +       if (!arg->vec && arg->vec_len)
>>                 return -EFAULT;
>> -       if (vec && !access_ok((void __user *)vec,
>> +       if (arg->vec && !access_ok((void __user *)arg->vec,
>>                               arg->vec_len * sizeof(struct page_region)))
>>                 return -EFAULT;
>>
>>         /* Fixup default values */
>> +       arg->end = (arg->end & ~PAGE_MASK) ?
>> +                  ((arg->end & PAGE_MASK) + PAGE_SIZE) : (arg->end);
> 
> arg->end = ALIGN(arg->end, PAGE_SIZE);
> 
>>         if (!arg->max_pages)
>>                 arg->max_pages = ULONG_MAX;
>>
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
