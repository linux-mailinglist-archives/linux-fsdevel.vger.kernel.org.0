Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC896BE98B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 13:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCQMoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 08:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCQMoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:44:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202CFA17EC;
        Fri, 17 Mar 2023 05:44:02 -0700 (PDT)
Received: from [192.168.82.158] (unknown [118.107.141.218])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E78466030B1;
        Fri, 17 Mar 2023 12:43:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679057039;
        bh=rrwUW1f4Sic42rt//6FlR/yr1md5w0A2J6Dnvr0Tpis=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=elLis6tAdUDcHIcrHmzlM2v7+pYdoFdtgVAR5lVvO4tfho/RZt9R0yeY/SXNo5KNo
         Mrs07gvbCfu7Xsc6gH49TFvtBt+Ws9kVOTpiNnZPqk6UcPGvdyY8z5htpAbUeBBS0L
         nBC7Xan7cco8ZllwJvH5HRImriYAPgloqohoDZUSJcJvkzOCm1ED4jI63meeJ0j3wO
         JLIenrbrgPmLxZxiqMg/9rkb/rvQXRyqm2DP7XdfREpLvOeXvXHdk5srqY4iMPtO4q
         2KVuWeXIdFn81NLEbQyb0cS9wVTZR4aNN6I8a2hFS1hCe3m5HzLv0r4c279CmSMzSo
         RUbvEOrKmHvdg==
Message-ID: <44d3f94e-fb9f-49df-7460-75dcee61802f@collabora.com>
Date:   Fri, 17 Mar 2023 17:43:31 +0500
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
 <3c8d9ea0-1382-be0c-8dd2-d490eedd3b55@collabora.com>
 <CABb0KFGru9xFCxyVHBcE+dkXe58=5wiCbvZGSWhuTfr4gn=MRQ@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFGru9xFCxyVHBcE+dkXe58=5wiCbvZGSWhuTfr4gn=MRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/17/23 2:28 AM, Michał Mirosław wrote:
> On Thu, 16 Mar 2023 at 18:53, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Hi,
>>
>> Thank you so much for reviewing.
>>
>> On 3/13/23 9:02 PM, Michał Mirosław wrote:
>>> On Thu, 9 Mar 2023 at 14:58, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
> [...]
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
> [...]
>>>> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
>>>> +                              struct pagemap_scan_private *p,
>>>> +                              unsigned long addr, unsigned int n_pages)
>>>> +{
>>>> +       unsigned long bitmap = PM_SCAN_BITMAP(wt, file, pres, swap);
>>>> +       struct page_region *cur = &p->cur;
>>>> +       bool cpy = true;
>>>> +
>>>> +       if (p->max_pages && (p->found_pages == p->max_pages))
>>>> +               return -ENOSPC;
>>>> +
>>>> +       if (!n_pages)
>>>> +               return -EINVAL;
>>>> +
>>>> +       if (p->required_mask)
>>>> +               cpy = ((p->required_mask & bitmap) == p->required_mask);
>>>> +       if (cpy && p->anyof_mask)
>>>> +               cpy = (p->anyof_mask & bitmap);
>>>> +       if (cpy && p->excluded_mask)
>>>> +               cpy = !(p->excluded_mask & bitmap);
>>>
>>> Since the rest of the code is executed only when `cpy` is true, this
>>> could just return early for easier understanding.
>> Hmm... I'll do the following:
>>         if (!cpy || !bitmap)
>>                 return 0;
>>> BTW, some of the tests are redundant. Eg: if required_mask == 0, then
>>> `required_mask & x == required_mask` will always hold. Same for
>>> `excluded_mask & x == 0`.
>> Correct. This is why I'm checking if required_mask is set and then
>> comparing bitmap with it. required_mask may be 0 if not set. This if will
>> ignore the subsequent check.
>>
>>         if (p->required_mask)
>>                 cpy = ((p->required_mask & bitmap) == p->required_mask);
>>
>> I don't see any redundancy here. Please let me know otherwise?
> [...]
>>>> +       if (cpy && bitmap) {
>>>
>>> Assuming early returns on `!cpy` are done earlier:
>>>
>>> if (!bitmap)
>>>   return 0;
>> I've posted condition above which would better suit here.
> [...]
> 
> Since the `cpy` condition is updated and passed to each new branch
> (IOW: after setting cpy = 0 for whatever reason all the further code
> is skipped) you can drop the variable and do early returns everywhere.
> E.g.:
> 
> if ((bitmap & p->required_mask) != p->required_mask)
>   return 0;
> if (p->anyof_mask && !(bitmap & p->anyof_mask))
>   return 0;
> if (bitmap & p->excluded_mask)
>   return 0;
> if (!bitmap)
>   return 0;
Clever. Will do.

> 
> Also you can take the "special" effect of masking with zero to be
> always zero (and in C - false) to avoid testing for an empty mask
> separately in most cases.
Done.

> 
>> Just for my knowledge, what does "Nit" signify if a comment is marked with it?
> 
> A low priority / cosmetic item that you might consider ignoring if a
> fix is too expensive or controversial.
> 
>>> +               if ((cur->len) && (cur->bitmap == bitmap) &&
>>> +                   (cur->start + cur->len * PAGE_SIZE == addr)) {
>>
>> I'd recommend removing the extra parentheses as they make the code
>> less readable for me (too many parentheses to match visually).
> I'll remove parenthesis.
> 
> [...]
>>> The `cur->len` test seems redundant: is it possible to have
>>> `cur->start == addr` in that case (I guess it would have to get
>>> `n_pages == 0` in an earlier invocation)?
>> No, both wouldn't work. cur->len == 0 means that it has only garbage. It is
>> essential to check the validity from cur->len before performing other
>> checks. Also cur->start can never be equal to addr as we are walking over
>> page addressing in serial manner. We want to see here if the current
>> address matches the previous data by finding the ending address of last
>> stored data (cur->start + cur->len * PAGE_SIZE).
> 
> If cur->len == 0, then it doesn't matter if it gets merged or not - it
> can be filtered out during the flush (see below).

> 
> [...]
>>>> +               } else if ((!p->vec_index) ||
>>>> +                          ((p->vec_index + 1) < p->vec_len)) {
>>>
>>> Can you explain this test? Why not just `p->vec_index < p->vec_len`? Or better:
>>>
>>> if (vec_index >= p->vec_len)
>>>     return -ENOSPC;
>>
>> No, it'll not work. Lets leave it as it is. :)
>>
>> It has gotten somewhat complex, but I don't have any other way to make it
>> simpler which works. First note the following points:
>> 1) We walk over 512 page or 1 thp at a time to not over allocate memory in
>> kernel (p->vec).
>> 2) We also want to merge the consecutive pages with the same flags into one
>> struct page_region. p->vec of current walk may merge with next walk. So we
>> cannot write to user memory until we find the results of the next walk.
>>
>> So most recent data is put into p->cur. When non-intersecting or mergeable
>> data is found, we move p->cur to p->vec[p->index] inside the page walk.
>> After the page walk, p->vec[0 to p->index] is moved to arg->vec. After all
>> the walks are over. We move the p->cur to arg->vec. It completes the data
>> transfer to user buffer.
> [...]
>> I'm so sorry that it has gotten this much complex. It was way simpler when
>> we were walking over all the memory in one go. But then we needed an
>> unbounded memory from the kernel which we don't want.
> [...]
> 
> I've gone through and hopefully understood the code. I'm not sure this
> needs to be so complicated: when traversing a single PMD you can
> always copy p->cur to p->vec[p->vec_index++] because you can have at
> most pages_per_PMD non-merges (in the worst case the last page always
> is left in p->cur and whole p->vec is used). After each PMD p->vec
> needs a flush if p->vec_index > 0, skipping the dummy entry at front
> (len == 0; if present). (This is mostly how it is implemented now, but
> I propose to remove the "overflow" check and do the starting guard
> removal only every PMD.)
Sorry, unable to understand where to remove the guard?

> 
> BTW, the pagemap_scan_deposit() got me a bit confused: it seems that
> it is just a copy of the p->vec flush to userspace. Please either use
> it for both p->vec and p->cur flushing or inline.
I can inline this function if you say so, now that you understand all the
logic. I don't see what else can be done here.

> 
> BTW#2, I think the ENOSPC return in pagemap_scan_output() should
> happen later - only if the pages would match and that caused the count
> to exceed the limit. For THP n_pages should be truncated to the limit
> (and ENOSPC returned right away) only after the pages were verified to
> match.
We have 2 counters here:
* the p->max_pages optionally can be set to find out only N pages of
interest. So p->found_pages is counting this. We need to return early if
the page limit is complete.
* the p->vec_index keeps track of output buffer array size

> 
> [...]
>>>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>>>> +                                 unsigned long end, struct mm_walk *walk)
>>>> +{
>>>> +       struct pagemap_scan_private *p = walk->private;
>>>> +       struct vm_area_struct *vma = walk->vma;
>>>> +       bool is_writ, is_file, is_pres, is_swap;
>>>> +       unsigned long addr = end;
>>>> +       spinlock_t *ptl;
>>>> +       int ret = 0;
>>>> +       pte_t *pte;
>>>> +
>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>
>>> Is the `#ifdef` needed? `pmd_trans_huge_lock()` will always return
>>> NULL if transparent hugepages are not compiled in. OTOH I see
>>> BUILD_BUG() is possible in HPAGE_SIZE definition (irrelevant in this
>>> case), so that would need to be worked around first.
>> I'd got the build error [1]. So I'd added these. I've tested it again with
>> the same config. We don't need these #ifdef now. I'll remove these.
> 
> I mean that there are cases like [1] that actually need the #ifdef at
> least to wrap HPAGE_SIZE usage. But maybe just this constant can be
> wrapped so that we keep the code always compile-tested?
Some arch define HPAGE_SIZE even if huge page config isn't enabled and some
don't. Lets just add #ifdef CONFIG_TRANSPARENT_HUGEPAGE as it is just like
the similar code in this same file is using this same #ifdef.

> 
> [1] https://elixir.bootlin.com/linux/v6.3-rc2/source/arch/mips/include/asm/page.h#L66
> 
> [...]
>>>> +       if (!arg->required_mask && !arg->anyof_mask &&
>>>> +           !arg->excluded_mask)
>>>> +               return false;
>>>
>>> Is there an assumption in the code that those checks are needed? I'd
>>> expect that no selection criteria makes a valid page set?
>> In my view, selection criterion must be specified for the ioctl to work. If
>> there is no criterio, user should go and read pagemap file directly. So the
>> assumption is that at least one selection criterion must be specified.
> 
> Yes. I'm not sure we need to prevent multiple ways of doing the same
> thing. But doesn't pagemap reading lack the range aggregation feature?
Yeah, correct. But note that we are supporting only selective 4 flags in
this ioctl, not all pagemap flags. So it is useful for only those users who
depend only on these 4 flags. Out pagemap_ioctl interface is not so much
generic that we can cater anyone. Its interface is specific and we are
adding only those cases which are of our interest. So if someone wants
range aggregation from pagemap_ioctl, he'll need to add that flag in the
IOCTL first. When IOCTL support is added, he can specify the selection
criterion etc.

> 
> [...]
>>>> +       if (!access_ok((void __user *)vec,
>>>> +                      arg->vec_len * sizeof(struct page_region)))
>>>> +               return false;
>>>
>>> Is there a provision that userspace threads are all blocked from
>>> manipulating mmaps during this ioctl()? If not, this is a TOCTOU bug
>>> and the writes should be checked each time as another userspace thread
>>> could remap the memory while the ioctl() is working.
>> mincore() syscall is doing in the same way. It checks the validity in the
>> start only. What provision should I add? Isn't it obvious that the user
>> should not remap such memory?
> 
> On the second look, I think the code already checks that while doing
> copy_to_user(), so this check is redundant and can be removed.
I'll remove.

> 
>>>
>>>> +       if (!IS_ALIGNED(start, PAGE_SIZE))
>>>> +               return false;
>>>> +       if (!access_ok((void __user *)start, arg->len))
>>>> +               return false;
>>>
>>> This I guess wants to check if the range to be scanned is mapped -
>>> but isn't this what the ioctl() should do during the scan? (But, also
>>> see above.)
>> No, start represents the memory which the user wants to watch. User must
>> allocate this memory first and then pass the address to this ioctl to find
>> out the flags per page.
> 
> From:
> + * struct pm_scan_arg - Pagemap ioctl argument
> + * @size:              Size of the structure
> + * @flags:             Flags for the IOCTL
> + * @start:             Starting address of the region
> + * @len:               Length of the region (All the pages in this
> length are included)
> ...
> 
> I'd expect the `start` field to just be a virtual address to start
> scanning from. Does it need to be mapped? For CRIU usecase I'd start
> with "start = 0" to find out all mappings, but 0 is (always) not
> mapped. Is this supposed to only work on already discovered page
> ranges? Anyway, I'd expect the code should be tolerant of another
> thread changing the mappings while this ioctl() is walking the page
> tables - is it so? If yes, then this check serves at most as an
> optimization used only for an invalid call.
Ohh... Ignore my previous comment. Yeah, any valid memory range can be
passed to view the page flags. This check just verifies if the memory range
is valid.

> 
>>>>  const struct file_operations proc_pagemap_operations = {
>>>>         .llseek         = mem_lseek, /* borrow this */
>>>>         .read           = pagemap_read,
>>>>         .open           = pagemap_open,
>>>>         .release        = pagemap_release,
>>>> +       .unlocked_ioctl = pagemap_scan_ioctl,
>>>> +       .compat_ioctl   = pagemap_scan_ioctl,
>>>
>>> Is this correct? Would the code need a different userspace pointer
>>> handling for 32-bit userspace on 64-bit kernel?
>> Yeah, it is needed for 32-bit application to run on 64-bit kernel.
> 
> I mean is using the same function for both entry points correct? Don't
> the pointers to userspace memory (e.g. arg->vec) need to be mapped for
> 32-bit process?
No, every member is our argument structure is of 64 bit in our structure
which keeps memory layout same. So we don't need any specific conversion
here. (Even if we had any 32-bit variable, we just needed to make sure that
the layout remains the same in the memory.)

Thanks,
Usama

> 
> Best Regards
> 
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
