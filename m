Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391A775D0E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 19:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGURuj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 13:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGURuh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:50:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA81235B8;
        Fri, 21 Jul 2023 10:50:34 -0700 (PDT)
Received: from [192.168.10.12] (unknown [39.45.151.35])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 866C4660709D;
        Fri, 21 Jul 2023 18:50:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689961833;
        bh=y6jiMwQXaB7lq5JCcvxY7bZh62L+Sweg8TFuFVnYw9w=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Ji/upaSmBd4YbiiEWfbQP/dEVfxtlpgGFIaZ6XcnwdLm7m1k33y4MdPK3pCg0KZta
         NyOdjK7D/DXTb9RPq6NVt/u4dySnsMRnypIEmTdSejlfEZqX7gcamyNy+AVdRik6IN
         36cLPhDIms69apBUgyjlUUMeeJpHyNCDIFCUIqDjyguG5B/vhFXzO8qzzMlSZ5C8KR
         ancNTba3aST7O2BosfgnVf8CpvghxuLUM73ydJA5WhRA6ZYvGBpF7Q47YrpxvPCKwl
         aaV0dUIKrkoASRCTBmWRWYdPeeGC+BWL9aA+Mq/5XknndbTbc6clIbewrGLKuHif5J
         OsgH6P6vd5Njg==
Message-ID: <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com>
Date:   Fri, 21 Jul 2023 22:50:19 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
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
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
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
Subject: Re: fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com>
 <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
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

On 7/21/23 4:23 PM, Michał Mirosław wrote:
> On Fri, Jul 21, 2023 at 03:48:22PM +0500, Muhammad Usama Anjum wrote:
>> On 7/21/23 12:28 AM, Michał Mirosław wrote:
>>> This is a massaged version of patch by Muhammad Usama Anjum [1]
>>> to illustrate my review comments and hopefully push the implementation
>>> efforts closer to conclusion. The changes are:
>> Thank you so much for this effort. I also want to reach conclusion. I'll
>> agree with all the changes which don't affect me. But some requirements
>> aren't being fulfilled with this current design.
>>
>>>
>>> 1. the API:
> [...]
>>>   b. rename match "flags" to 'page categories' everywhere - this makes
>>> 	it easier to differentiate the ioctl()s categorisation of pages
>>> 	from struct page flags;
>> I've no problem with it.
>>
>> #define PAGE_IS_WPASYNC		(1 << 0)
>> #define PAGE_IS_WRITTEN		(1 << 1)
>> You have another new flag PAGE_IS_WPASYNC. But there is no application of
>> PAGE_IS_WPASYNC. We must not add a flag which don't have any user.
> 
> Please see below.
> 
>>>   c. change {required + excluded} to {inverted + required}. This was
>>> 	rejected before, but I'd like to illustrate the difference.
>>> 	Old interface can be translated to the new by:
>>> 		categories_inverted = excluded_mask
>>> 		categories_mask = required_mask | excluded_mask
>>> 		categories_anyof_mask = anyof_mask
>>> 	The new way allows filtering by: A & (B | !C)
>>> 		categories_inverted = C
>>> 		categories_mask = A
>>> 		categories_anyof_mask = B | C
>> I'm still unable to get the idea of inverted masks. IIRC Andei had also not
>> supported/accepted this masking scheme. But I'll be okay with it if he
>> supports this masking.
> 
> Please note that the masks are not inverted -- the values are. Masks
> select which categories you want to filter on, and category_inverted
> invert the meaning of a match (match 0 instead of 1).
> 
>>>   d. change the ioctl to be a SCAN with optional WP. Addressing the
>>> 	original use-case, GetWriteWatch() can be implemented as:
>> As I've mentioned several times previously (without the name of
>> ResetWriteWatch()) that we need exclusive WP without GET. This could be
>> implemented with UFFDIO_WRITEPROTECT. But when we use UFFDIO_WRITEPROTECT,
>> we hit some special case and performance is very slow. So with UFFD WP
>> expert, Peter Xu we have decided to put exclusive WP in this IOCTL for
>> implementation of ResetWriteWatch().
>>
>> A lot of simplification of the patch is made possible because of not
>> keeping exclusive WP. (You have also written some quality code, more better.)
>>>
>>> 		memset(&args, 0, sizeof(args));
>>> 		args.start = lpBaseAddress;
>>> 		args.end = lpBaseAddress + dwRegionSize;
>>> 		args.max_pages = *lpdwCount;
>>> 		*lpdwGranularity = PAGE_SIZE;
>>> 		args.flags = PM_SCAN_CHECK_WPASYNC;
>>> 		if (dwFlags & WRITE_WATCH_FLAG_RESET)
>>> 			args.flags |= PM_SCAN_WP_MATCHED;
>>> 		args.categories_mask = PAGE_IS_WRITTEN;
>>> 		args.return_mask = PAGE_IS_WRITTEN;
> 
> For ResetWriteWatch() you would:
> 
> args.flags = PM_SCAN_WP_MATCHING;
> args.categories_mask = PAGE_IS_WPASYNC | PAGE_IS_WRITTEN;
> args.return_mask = 0;
> 
> Or (if you want to error out if the range doesn't have WP enabled):
> 
> args.flags = PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC;
> args.categories_mask = PAGE_IS_WRITTEN;
> args.return_mask = 0;
> 
> (PM_SCAN_CHECK_WPASYNC is effectively adding PAGE_IS_WPASYNC to the
> required categories.)
Right. But we don't want to perform GET in case of ResetWriteWatch(). It'll
be wasted effort to perform GET as well when we don't care about the dirty
status of the pages.


> 
> [...]
> 
>>> 2. the implementation:
>>>   a. gather the page-categorising and write-protecting code in one place;
>> Agreed.
>>
>>>   b. optimization: add whole-vma skipping for WP usecase;
>> I don't know who can benefit from it. Do you have any user in mind? When
>> the user come of this optimization, this can be added later.
> 
> This is for users of WP that want to ignore WP for non-registered ranges
> instead of erroring out on them. (I anticipate CRIU to use this.)
> 
>>>   c. extracted output limiting code to pagemap_scan_output();
>> If user passes half THP, current code wouldn't split huge page and WP the
>> whole THP. We would loose the dirty state of other half huge page. This is
>> bug. consoliding the output limiting code looks optimal, but we'll need to
>> same limiting code to detect if full THP hasn't been passed in case of THP
>> and HugeTLB.
> 
> For THP indeed - the code should check `end != start + HPAGE_SIZE`
> instead of `ret == -ENOSPC`.
Yeah, this need to be fixed.

> 
> For HugeTLB there is a check that returns EINVAL when trying to WP
> a partial page. I think I didn't change that part.
> 
>>>   d. extracted range coalescing to pagemap_scan_push_range();
>> My old pagemap_scan_output has become pagemap_scan_push_range().
> 
> Indeed. I did first push the max_pages check in, hence the 'extracting'
> later.
> 
>>>   e. extracted THP entry handling to pagemap_scan_thp_entry();
>> Good. But I didn't found value in seperating it just like other historic
>> pagemap code.
> 
> This is to avoid having to much indentation and long functions that do
> many things at once.
> 
>>>   f. added a shortcut for non-WP hugetlb scan; avoids conditional
>>> 	locking;
>> Yeah, some if conditions have been removed. But overall did couple of calls
>> to is_interesting and scan_output functions instead of just one.
> 
> Yes, there are now two pairs instead of one. I see that I haven't pushed
> the is_interesting calls into scan_output. This is now trivial:
> 	if (!interesting...) {
> 		*end = start;
> 		return 0;
> 	}
This can be the 3rd thing to fix.

Is it possible for you to fix the above mentioned 3 things and send the
patch for my testing:
1 Make GET optional
2 Detect partial THP WP operation and split
3 Optimization of moving this interesting logic to output() function

Please let me know if you cannot make the above fixes. I'll mix my patch
version and your patch and fix these things up.

> and could save some typing (but would need a different name for
> scan_output as it would do filter & output), but I'm not sure about
> readability.
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
