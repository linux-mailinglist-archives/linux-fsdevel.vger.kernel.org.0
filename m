Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59B969797B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 11:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjBOKDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 05:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjBOKDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:03:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCDA10AA3;
        Wed, 15 Feb 2023 02:03:21 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57A146602180;
        Wed, 15 Feb 2023 10:03:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676455399;
        bh=X00el7p+dbNTAWPiS1YW1ebOoUoyaNwOhDYiwL1/FLY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ijvylnSHQqn/Hrg59y3nIPoo9NYWq9fs5upS3FOuom+I/ikfB8SqOCyvSn3Wcjnzy
         Hvpx7vDHAmj4/W87+tC51Wmoiym91Rody0QLIznvS+i9mj1bD7ZILp/ThpK48u7yTi
         XXXa6KrAKcGZ4IHFqy/bwfDfUTvGq6HzOc85eubl4elY/VgxY1GwQxnBAxyris6u1F
         rtv43eml3G5y2FJLofeUj6fh31Csy2PrxREwrliCtZGvN3Qr1Fnc+cwrm3OYagVDus
         jrxqcm5B42Fu9bnHV8kB8VjWwNUHW0haRt5Jxe2DTNw8XR/ZV3KFpR6j5PtYC9I77W
         oxydz1usFQgqA==
Message-ID: <884f5aa6-5d12-eecc-ed71-7d653828ca20@collabora.com>
Date:   Wed, 15 Feb 2023 15:03:09 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com> <Y+QfDN4Y5Q10x8GQ@x1n>
 <8b2959fb-2a74-0a1f-8833-0b18eab142dc@collabora.com> <Y+qur8iIUQTLyE8f@x1n>
 <39217d9a-ed7e-f1ff-59b9-4cbffa464999@collabora.com> <Y+v2HJ8+3i/KzDBu@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+v2HJ8+3i/KzDBu@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/15/23 1:59 AM, Peter Xu wrote:
[..]
>>>> static inline bool is_pte_written(pte_t pte)
>>>> {
>>>> 	if ((pte_present(pte) && pte_uffd_wp(pte)) ||
>>>> 	    (pte_swp_uffd_wp_any(pte)))
>>>> 		return false;
>>>> 	return (pte_present(pte) || is_swap_pte(pte));
>>>> }
>>>
>>> Could you explain why you don't want to return dirty for !present?  A page
>>> can be written then swapped out.  Don't you want to know that happened
>>> (from dirty tracking POV)?
>>>
>>> The code looks weird to me too..  We only have three types of ptes: (1)
>>> present, (2) swap, (3) none.
>>>
>>> Then, "(pte_present() || is_swap_pte())" is the same as !pte_none().  Is
>>> that what you're really looking for?
>> Yes, this is what I've been trying to do. I'll use !pte_none() to make it
>> simpler.
> 
> Ah I think I see what you wanted to do now.. But I'm afraid it won't work
> for all cases.
> 
> So IIUC the problem is anon pte can be empty, but since uffd-wp bit doesn't
> persist on anon (but none) ptes, then we got it lost and we cannot identify
> it from pages being written.  Your solution will solve problem for
> anonymous, but I think it'll break file memories.
> 
> Example:
> 
> Consider one shmem page that got mapped, write protected (using UFFDIO_WP
> ioctl), written again (removing uffd-wp bit automatically), then zapped.
> The pte will be pte_none() but it's actually written, afaiu.
> 
> Maybe it's time we should introduce UFFD_FEATURE_WP_ZEROPAGE, so we'll need
> to install pte markers for anonymous too (then it will work similarly like
> shmem/hugetlbfs, that we'll report writting to zero pages), then you'll
> need to have the new UFFD_FEATURE_WP_ASYNC depend on it.  With that I think
> you can keep using the old check and it should start to work.
> 
> Please let me know if my understanding is correct above.
Thank you for identifying it. Your understanding seems on point. I'll have
research things up about PTE Markers. I'm looking at your patches about it
[1]. Can you refer me to "mm alignment sessions" discussion in form of
presentation or if any transcript is available?

> 
> I'll see whether I can quickly play with UFFD_FEATURE_WP_ZEROPAGE with some
> patch at the meantime.  That's something we wanted before too, when the app
> cares about zero pages on anon.  We used to populate the pages before doing
> ioctl(UFFDIO_WP) to make sure zero pages will be repoted too, but that flag
> should be more efficient.
Is this discussion public? For what application you were looking into this?
I'll dig down to see how can I contribute to it.

> 
>>
>>>
>>>>
>>>> static inline bool is_pmd_written(pmd_t pmd)
>>>> {
>>>> 	if ((pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
>>>> 	    (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd)))
>>>> 		return false;
>>>> 	return (pmd_present(pmd) || is_swap_pmd(pmd));
>>>> }
>>>
>>> [...]
>>>
>>>>>> +	bitmap = cur & p->return_mask;
>>>>>> +	if (cpy && bitmap) {
>>>>>> +		if ((prev->len) && (prev->bitmap == bitmap) &&
>>>>>> +		    (prev->start + prev->len * PAGE_SIZE == addr)) {
>>>>>> +			prev->len += len;
>>>>>> +			p->found_pages += len;
>>>>>> +		} else if (p->vec_index < p->vec_len) {
>>>>>> +			if (prev->len) {
>>>>>> +				memcpy(&p->vec[p->vec_index], prev, sizeof(struct page_region));
>>>>>> +				p->vec_index++;
>>>>>> +			}
>>>>>
>>>>> IIUC you can have:
>>>>>
>>>>>   int pagemap_scan_deposit(p)
>>>>>   {
>>>>>         if (p->vec_index >= p->vec_len)
>>>>>                 return -ENOSPC;
>>>>>
>>>>>         if (p->prev->len) {
>>>>>                 memcpy(&p->vec[p->vec_index], prev, sizeof(struct page_region));
>>>>>                 p->vec_index++;
>>>>>         }
>>>>>
>>>>>         return 0;
>>>>>   }
>>>>>
>>>>> Then call it here.  I think it can also be called below to replace
>>>>> export_prev_to_out().
>>>> No this isn't possible. We fill up prev until the next range doesn't merge
>>>> with it. At that point, we put prev into the output buffer and new range is
>>>> put into prev. Now that we have shifted to smaller page walks of <= 512
>>>> entries. We want to visit all ranges before finally putting the prev to
>>>> output. Sorry to have this some what complex method. The problem is that we
>>>> want to merge the consective matching regions into one entry in the output.
>>>> So to achieve this among multiple different page walks, the prev is being used.
>>>>
>>>> Lets suppose we want to visit memory from 0x7FFF00000000 to 7FFF00400000
>>>> having length of 1024 pages and all of the memory has been written.
>>>> walk_page_range() will be called 2 times. In the first call, prev will be
>>>> set having length of 512. In second call, prev will be updated to 1024 as
>>>> the previous range stored in prev could be extended. After this, the prev
>>>> will be stored to the user output buffer consuming only 1 struct of page_range.
>>>>
>>>> If we store prev back to output memory in every walk_page_range() call, we
>>>> wouldn't get 1 struct of page_range with length 1024. Instead we would get
>>>> 2 elements of page_range structs with half the length.
>>>
>>> I didn't mean to merge PREV for each pgtable walk.  What I meant is I think
>>> with such a pagemap_scan_deposit() you can rewrite it as:
>>>
>>> if (cpy && bitmap) {
>>>         if ((prev->len) && (prev->bitmap == bitmap) &&
>>>             (prev->start + prev->len * PAGE_SIZE == addr)) {
>>>                 prev->len += len;
>>>                 p->found_pages += len;
>>>         } else {
>>>                 if (pagemap_scan_deposit(p))
>>>                         return -ENOSPC;
>>>                 prev->start = addr;
>>>                 prev->len = len;
>>>                 prev->bitmap = bitmap;
>>>                 p->found_pages += len;
>>>         }
>>> }
>>>
>>> Then you can reuse pagemap_scan_deposit() when before returning to
>>> userspace, just to flush PREV to p->vec properly in a single helper.
>>> It also makes the code slightly easier to read.
>> Yeah, this would have worked as you have described. But in
>> pagemap_scan_output(), we are flushing prev to p->vec. But later in
>> export_prev_to_out() we need to flush prev to user_memory directly.
> 
> I think there's a loop to copy_to_user().  Could you use the new helper so
> the copy_to_user() loop will work without export_prev_to_out()?
> 
> I really hope we can get rid of export_prev_to_out().  Thanks,
I truly understand how you feel about export_prev_to_out(). It is really
difficult to understand. Even I had to made a hard try to come up with the
current code to avoid consuming a lot of kernel's memory while giving user
the compact output. I can surely map both of these with a dirty looking
macro. But I'm unable to find a decent macro to replace these. I think I'll
put a comment some where to explain whats going-on.


-- 
BR,
Muhammad Usama Anjum
