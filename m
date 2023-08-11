Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E1277931F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 17:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbjHKPaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 11:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjHKPa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:30:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA6F103;
        Fri, 11 Aug 2023 08:30:27 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.188.71])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E82DE6607247;
        Fri, 11 Aug 2023 16:30:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691767826;
        bh=aJAfOnVKYAKCLBtRxHoBmsF+Y76g4uMvYo6dubi5kTY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=VPpGNHxdfBiX4UxVZhw3GdcPgkC07HQiubODJEhjpBXuXjBCVk5FaHUlGceWK2TGH
         qmcDLHGvP+P8PR02oZGeuUl81bjyZm2YS6FnDLmYieh5TYtP60iCTHkD+GmBNdgJy3
         2Q0jOokybr34srHpePoKISH1sYtvhQNY5YSe0ZyKWVPkC07MVczYSsseFijDYdiYgN
         KLSpkRKlarFlv3Jao1uhuzMmSe6UtQxRaR/v6k0tZeLwHGzYLAS6wphE/8hZVBOwim
         WZIIyr7Rykr981nA6X9gV7eOY3FVLXdHAmaojYBKHkRyU6+qkN17jJ+DMDVqYWwHhd
         ltFX7a5JDownw==
Message-ID: <f80cc4b8-39ca-c410-655a-9abc377ec442@collabora.com>
Date:   Fri, 11 Aug 2023 20:30:16 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
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
Subject: Re: [PATCH v28 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20230809061603.1969154-1-usama.anjum@collabora.com>
 <20230809061603.1969154-3-usama.anjum@collabora.com>
 <CABb0KFGqDo8hFohqpXewoquyLVZUhG-bRHxpw_PYXzGW9wXofQ@mail.gmail.com>
 <97de19a3-bba2-9260-7741-cd5b6f4581e9@collabora.com>
 <ZNY4bz1450enHxlG@qmqm.qmqm.pl>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZNY4bz1450enHxlG@qmqm.qmqm.pl>
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

On 8/11/23 6:32 PM, Michał Mirosław wrote:
> On Fri, Aug 11, 2023 at 05:02:44PM +0500, Muhammad Usama Anjum wrote:
>> On 8/10/23 10:32 PM, Michał Mirosław wrote:
>>> On Wed, 9 Aug 2023 at 08:16, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
> [...]
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>> [...]
>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> +static unsigned long pagemap_thp_category(pmd_t pmd)
>>>> +{
>>>> +       unsigned long categories = PAGE_IS_HUGE;
>>>> +
>>>> +       if (pmd_present(pmd)) {
>>>> +               categories |= PAGE_IS_PRESENT;
>>>> +               if (!pmd_uffd_wp(pmd))
>>>> +                       categories |= PAGE_IS_WRITTEN;
>>>> +               if (is_zero_pfn(pmd_pfn(pmd)))
>>>> +                       categories |= PAGE_IS_PFNZERO;
>>>> +       } else if (is_swap_pmd(pmd)) {
>>>> +               categories |= PAGE_IS_SWAPPED;
>>>> +               if (!pmd_swp_uffd_wp(pmd))
>>>> +                       categories |= PAGE_IS_WRITTEN;
>>>> +       }
>>>> +
>>>> +       return categories;
>>>> +}
>>> I guess THPs can't be file-backed currently, but can we somehow mark
>>> this assumption so it can be easily found if the capability arrives?
>> Yeah, THPs cannot be file backed. Lets not care for some feature which may
>> not arrive in several years or eternity.
> 
> Yes, it might not arrive. But please add at least a comment, so that it
> is clearly visible that lack if PAGE_IS_FILE here is intentional.
I'll add a comment.

> 
>>>> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>> +
>>>> +#ifdef CONFIG_HUGETLB_PAGE
>>>> +static unsigned long pagemap_hugetlb_category(pte_t pte)
>>>> +{
>>>> +       unsigned long categories = PAGE_IS_HUGE;
>>>> +
>>>> +       if (pte_present(pte)) {
>>>> +               categories |= PAGE_IS_PRESENT;
>>>> +               if (!huge_pte_uffd_wp(pte))
>>>> +                       categories |= PAGE_IS_WRITTEN;
>>>> +               if (!PageAnon(pte_page(pte)))
>>>> +                       categories |= PAGE_IS_FILE;
>>>> +               if (is_zero_pfn(pte_pfn(pte)))
>>>> +                       categories |= PAGE_IS_PFNZERO;
>>>> +       } else if (is_swap_pte(pte)) {
>>>> +               categories |= PAGE_IS_SWAPPED;
>>>> +               if (!pte_swp_uffd_wp_any(pte))
>>>> +                       categories |= PAGE_IS_WRITTEN;
>>>> +       }
>>>
>>> BTW, can a HugeTLB page be file-backed and swapped out?
>> Accourding to pagemap_hugetlb_range(), file-backed HugeTLB page cannot be
>> swapped.
> 
> Here too a comment that leaving out this case is intentional would be useful.
Sure.

> 
>>> [...]
>>>> +       walk_start = p.arg.start;
>>>> +       for (; walk_start < p.arg.end; walk_start = p.arg.walk_end) {
> [...[
>>>> +               ret = mmap_read_lock_killable(mm);
>>>> +               if (ret)
>>>> +                       break;
>>>> +               ret = walk_page_range(mm, walk_start, p.arg.end,
>>>> +                                     &pagemap_scan_ops, &p);
>>>> +               mmap_read_unlock(mm);
> [...]
>>>> +               if (ret != -ENOSPC || p.arg.vec_len - 1 == 0 ||
>>>> +                   p.found_pages == p.arg.max_pages)
>>>> +                       break;
>>>
>>> The second condition is equivalent to `p.arg.vec_len == 1`, but why is
>>> that an ending condition? Isn't the last entry enough to gather one
>>> more range? (The walk could have returned -ENOSPC due to buffer full
>>> and after flushing it could continue with the last free entry.)
>> Now we are walking the entire range walk_page_range(). We don't break loop
>> when we get -ENOSPC as this error may only mean that the temporary buffer
>> is full. So we need check if max pages have been found or output buffer is
>> full or ret is 0 or any other error. When p.arg.vec_len = 1 is end
>> condition as the last entry is in cur. As we have walked over the entire
>> range, cur must be full after which the walk returned.
>>
>> So current condition is necessary. I've double checked it. I'll change it
>> to `p.arg.vec_len == 1`.
> 
> If we have walked the whole range, then the loop will end anyway due to
> `walk_start < walk_end` not held in the `for()`'s condition.
Sorry, for not explaining to-the-point.
Why would we walk the entire range when we should recognize that the output
buffer is full and break the loop?

I've test cases written for this case. If I remove `p.arg.vec_len == 1`
check, there is infinite loop for walking. So we are doing correct thing here.

> 
> [...]
>>>> +/*
>>>> + * struct pm_scan_arg - Pagemap ioctl argument
>>>> + * @size:              Size of the structure
>>>> + * @flags:             Flags for the IOCTL
>>>> + * @start:             Starting address of the region
>>>> + * @end:               Ending address of the region
>>>> + * @walk_end           Address where the scan stopped (written by kernel).
>>>> + *                     walk_end == end informs that the scan completed on entire range.
>>>
>>> Can we ensure this holds also for the tagged pointers?
>> No, we cannot.
> 
> So this need explanation in the comment here. (Though I'd still like to
> know how the address tags are supposed to be used from someone that
> knows them.)
I've looked at some documentations (presentations/talks) about tags. Tags
is more like userspace feature. Kernel should just ignore them for our use
case. I'll add comment.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
