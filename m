Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F007A69A929
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 11:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBQKkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 05:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBQKkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:40:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E048563588;
        Fri, 17 Feb 2023 02:40:14 -0800 (PST)
Received: from [192.168.10.28] (unknown [119.155.16.218])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3E169660212C;
        Fri, 17 Feb 2023 10:40:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676630413;
        bh=muRoWvrzI+VkpR0/7gju5miSZ34qepieMtohvfQ5Q/Y=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=kizgDAbQAuLysOg4zeyn+LwXWyMJwbCgs/bWZnd0SZuxzxGVWOw/bhJCefwK3P8fV
         P0OneNeMP9bRTIr9rQM89y/diQSNjuVa8EHaVnJ1j3WsM0BANeu5DomqeFfWDl//45
         vYwpVNL/jfc7tz9jBnEUe55oIbZJ5UfmSVTiL9IZbY5ijHnbbI6aeWmaKwcRe4ccjh
         gn807ZGsko9S0e181u8ffOeMfjPyn3B6axpUlMYh28fxrT8VoHeDKxNSqXuLxhmUYF
         43D3DWwWAHgme2zd3BNLmNBH6VJSRwQZoxreRH3LQmVmTT0LqCy9JE6THUUHSPToMP
         R6v9wPM/HPGoQ==
Message-ID: <a541e91b-2f41-6703-43c5-35d9f6d7334f@collabora.com>
Date:   Fri, 17 Feb 2023 15:39:55 +0500
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
 <884f5aa6-5d12-eecc-ed71-7d653828ca20@collabora.com> <Y+1KsQSYPYO/egvt@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+1KsQSYPYO/egvt@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/16/23 2:12 AM, Peter Xu wrote:
> On Wed, Feb 15, 2023 at 03:03:09PM +0500, Muhammad Usama Anjum wrote:
>> On 2/15/23 1:59 AM, Peter Xu wrote:
>> [..]
>>>>>> static inline bool is_pte_written(pte_t pte)
>>>>>> {
>>>>>> 	if ((pte_present(pte) && pte_uffd_wp(pte)) ||
>>>>>> 	    (pte_swp_uffd_wp_any(pte)))
>>>>>> 		return false;
>>>>>> 	return (pte_present(pte) || is_swap_pte(pte));
>>>>>> }
>>>>>
>>>>> Could you explain why you don't want to return dirty for !present?  A page
>>>>> can be written then swapped out.  Don't you want to know that happened
>>>>> (from dirty tracking POV)?
>>>>>
>>>>> The code looks weird to me too..  We only have three types of ptes: (1)
>>>>> present, (2) swap, (3) none.
>>>>>
>>>>> Then, "(pte_present() || is_swap_pte())" is the same as !pte_none().  Is
>>>>> that what you're really looking for?
>>>> Yes, this is what I've been trying to do. I'll use !pte_none() to make it
>>>> simpler.
>>>
>>> Ah I think I see what you wanted to do now.. But I'm afraid it won't work
>>> for all cases.
>>>
>>> So IIUC the problem is anon pte can be empty, but since uffd-wp bit doesn't
>>> persist on anon (but none) ptes, then we got it lost and we cannot identify
>>> it from pages being written.  Your solution will solve problem for
>>> anonymous, but I think it'll break file memories.
>>>
>>> Example:
>>>
>>> Consider one shmem page that got mapped, write protected (using UFFDIO_WP
>>> ioctl), written again (removing uffd-wp bit automatically), then zapped.
>>> The pte will be pte_none() but it's actually written, afaiu.
>>>
>>> Maybe it's time we should introduce UFFD_FEATURE_WP_ZEROPAGE, so we'll need
>>> to install pte markers for anonymous too (then it will work similarly like
>>> shmem/hugetlbfs, that we'll report writting to zero pages), then you'll
>>> need to have the new UFFD_FEATURE_WP_ASYNC depend on it.  With that I think
>>> you can keep using the old check and it should start to work.
>>>
>>> Please let me know if my understanding is correct above.
>> Thank you for identifying it. Your understanding seems on point. I'll have
>> research things up about PTE Markers. I'm looking at your patches about it
>> [1]. Can you refer me to "mm alignment sessions" discussion in form of
>> presentation or if any transcript is available?
> 
> No worry now, after a second thought I think zero page is better than pte
> markers, and I've got a patch that works for it here by injecting zero
> pages for anonymous:
> 
> https://lore.kernel.org/all/20230215210257.224243-1-peterx@redhat.com/
> 
> I think we'd also better to enforce your new WP_ASYNC feature bit to depend
> on this one, so fail the UFFDIO_API if WP_ASYNC && !WP_ZEROPAGE.
> 
> Could you please try by rebasing your work upon this one?  Hope it'll work
> for you already.  Note again that you'll need to go back to the old
> is_pte|pmd_written() to make things work always, I think.
Thank you so much for sending the ZEROPAGE patch. I've rebased my patches
on top of it and my all tests for anon memory are passing. Now we don't
need to touch the page before engaging wp. This is what we wanted to
achieve. So !wp flag can be easily translated to soft-dirty flag
(is_pte_soft_dirty = is_pte_wp).

I've only a few file mem and shmem tests. I'll write more tests.

> 
> [...]
> 
>> I truly understand how you feel about export_prev_to_out(). It is really
>> difficult to understand. Even I had to made a hard try to come up with the
>> current code to avoid consuming a lot of kernel's memory while giving user
>> the compact output. I can surely map both of these with a dirty looking
>> macro. But I'm unable to find a decent macro to replace these. I think I'll
>> put a comment some where to explain whats going-on.
> 
> So maybe I still missed something? I'll read the new version when it comes.
Lets reconvene in next patches if you feel like they can be improved.

> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum
