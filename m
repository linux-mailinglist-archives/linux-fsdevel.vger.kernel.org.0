Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFEB6BC58A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 06:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCPFRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 01:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCPFRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 01:17:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5AFA3B62;
        Wed, 15 Mar 2023 22:17:28 -0700 (PDT)
Received: from [192.168.10.39] (unknown [39.37.168.222])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 259AF6603080;
        Thu, 16 Mar 2023 05:17:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678943846;
        bh=M2Z2/iT5OeTZwq4KV/ZUqlsT5FpvCp+6Ly3f9Y3ZLkE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=KXnEm+eScqZ6ev+nTGspMoKauD7BVBd17dPh9L/zb3HSaE6jgNeULO2m7TuHW2l20
         7LlbgiOgCsFuwpVaBBxTqMO3btyHel0uppBJFfYy3iooW/mBAVt2hw4Xp4/RDEbsSh
         3IM3VJhPwdD33JvIApOSRqw6M/zLCY0z8k2xyZvsGIn8m/ntFZhSo+KlhpDiL9l2gD
         BMbR8lQj6Nw9qlX1/LEYS3EZxPzn3gRjSZ8zEI33m2Sk5MzNM2rsxCWtXMMzVqJil7
         Dtv4e4tWAvKVkQSu5r1Nzvwav1Ffu8+rJF4Us58cuXOfDJZVQ9JpO8BI0R6yxptRL7
         E7dnbjHbF+AmA==
Message-ID: <1947fb8d-a307-ac47-a66b-d2dcdce9e850@collabora.com>
Date:   Thu, 16 Mar 2023 10:17:10 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
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
To:     Peter Xu <peterx@redhat.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-5-usama.anjum@collabora.com> <ZBHqjBjj6nn1xeTM@x1n>
 <3d2d1ba4-bfab-6b3d-f0d6-ae0920ebdcb0@collabora.com> <ZBIiSwmbOsuaImIf@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZBIiSwmbOsuaImIf@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/16/23 12:53 AM, Peter Xu wrote:
> On Wed, Mar 15, 2023 at 09:54:40PM +0500, Muhammad Usama Anjum wrote:
>> On 3/15/23 8:55 PM, Peter Xu wrote:
>>> On Thu, Mar 09, 2023 at 06:57:15PM +0500, Muhammad Usama Anjum wrote:
>>>> +	for (addr = start; !ret && addr < end; pte++, addr += PAGE_SIZE) {
>>>> +		pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>>>> +
>>>> +		is_writ = !is_pte_uffd_wp(*pte);
>>>> +		is_file = vma->vm_file;
>>>> +		is_pres = pte_present(*pte);
>>>> +		is_swap = is_swap_pte(*pte);
>>>> +
>>>> +		pte_unmap_unlock(pte, ptl);
>>>> +
>>>> +		ret = pagemap_scan_output(is_writ, is_file, is_pres, is_swap,
>>>> +					  p, addr, 1);
>>>> +		if (ret)
>>>> +			break;
>>>> +
>>>> +		if (PM_SCAN_OP_IS_WP(p) && is_writ &&
>>>> +		    uffd_wp_range(walk->mm, vma, addr, PAGE_SIZE, true) < 0)
>>>> +			ret = -EINVAL;
>>>> +	}
>>>
>>> This is not real atomic..
>>>
>>> Taking the spinlock for eacy pte is not only overkill but wrong in
>>> atomicity because the pte can change right after spinlock unlocked.
>> Let me explain. It seems like wrong, but it isn't. In my rigorous testing,
>> it didn't show any side-effect.  Here we are finding out if a page is
>> written. If page is written, only then we clear it. Lets look at the
>> different possibilities here:
>> - If a page isn't written, we'll not clear it.
>> - If a page is written and there isn't any race, we'll clear written-to
>> flag by write protecting it.
>> - If a page is written but before clearing it, data is written again to the
>> page. The page would remain written and we'll clear it.
>> - If a page is written but before clearing it, it gets write protected,
>> we'll still write protected it. There is double right protection here, but
>> no side-effect.
>>
>> Lets turn this into a truth table for easier understanding. Here first
>> coulmn and thrid column represents this above code. 2nd column represents
>> any other thread interacting with the page.
>>
>> If page is written/dirty	some other task interacts	wp_page
>> no				does nothing			no
>> no				writes to page			no
>> no				wp the page			no
>> yes				does nothing			yes
>> yes				write to page			yes
>> yes				wp the page			yes
>>
>> As you can see there isn't any side-effect happening. We aren't over doing
>> the wp or under-doing the write-protect.
>>
>> Even if we were doing something wrong here and I bring the lock over all of
>> this, the pages get become written or wp just after unlocking. It is
>> expected. This current implementation doesn't seem to be breaking this.
>>
>> Is my understanding wrong somewhere here? Can you point out?
> 
> Yes you're right.  With is_writ check it looks all fine.
> 
>>
>> Previous to this current locking design were either buggy or slower when
>> multiple threads were working on same pages. Current implementation removes
>> the limitations:
>> - The memcpy inside pagemap_scan_output is happening with pte unlocked.
> 
> Why this has anything to worry?  Isn't that memcpy only applies to a
> page_region struct?
Yeah, correct. I'm just saying that memcpy without pte lock is better than
memcpy with pte locked. :)

> 
>> - We are only wp a page if we have noted this page to be dirty
>> - No mm write lock is required. Only read lock works fine just like
>> userfaultfd_writeprotect() takes only read lock.
> 
> I didn't even notice you used to use write lock.  Yes I think read lock is
> suffice here.
> 
>>
>> There is only one con here that we are locking and unlocking the pte lock
>> again and again.
>>
>> Please have a look at my explanation and let me know what do you think.
> 
> I think this is fine as long as the semantics is correct, which I believe
> is the case.  The spinlock can be optimized, but it can be done on top if
> needs more involved changes.
> 
>>
>>>
>>> Unfortunately you also cannot reuse uffd_wp_range() because that's not
>>> atomic either, my fault here.  Probably I was thinking mostly from
>>> soft-dirty pov on batching the collect+reset.
>>>
>>> You need to take the spin lock, collect whatever bits, set/clear whatever
>>> bits, only until then release the spin lock.
>>>
>>> "Not atomic" means you can have some page got dirtied but you could miss
>>> it.  Depending on how strict you want, I think it'll break apps like CRIU
>>> if strict atomicity needed for migrating a process.  If we want to have a
>>> new interface anyway, IMHO we'd better do that in the strict way.
>> In my rigorous multi-threaded testing where a lots of threads are working
>> on same set of pages, we aren't losing even a single update. I can share
>> the test if you want.
> 
> Good to have tests covering that.  I'd say you can add the test into
> selftests along with the series when you repost if it's convenient.  It can
> be part of an existing test or it can be a new one under mm/.
Sure, I'll add it to the selftests.

Thank you for reviewing and asking the questions.

> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum
