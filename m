Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE277494F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 07:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjGFFRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 01:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGFFRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:17:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC288131;
        Wed,  5 Jul 2023 22:17:32 -0700 (PDT)
Received: from [192.168.10.54] (unknown [119.155.52.241])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C747E660585C;
        Thu,  6 Jul 2023 06:17:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688620651;
        bh=q4UGyIJqqzwWpndwRfGrl8koZCuNxBkVB317S/eWJaA=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Tcb6D60QYOcj5jT42ZAoKAoPs/BG7HzZGCJvmbJrEJjvgRcJlknbvA0Mq/M+hCu0Y
         pi6Xf3o/l4ifELvZynibFSHdjsytNy4GRaD6+wtKAzgtgmS0Kmogxlb/IfMJsP0Slu
         OCYTQmbY8ogEddxWIvbUJI34bTF4lemBdDuBCQ7IhW/ISCQCiL6SoxoS1ip4Yp8FWp
         qAO75uESGswyMsKW33DQfb7eKM8+WgAquqRSmaftloKn2ag1UeMyQBp3+dNcwcbVDH
         iRtRFc2s415IDgJIsuqUoCTvS4l0LSBaUg+JCCAHfs/693bhXAzPy1IyrYl6gaziwl
         6hUaQZmZQ6fGA==
Message-ID: <dcf5d655-b8e5-581c-a4fc-b4c7c7865106@collabora.com>
Date:   Thu, 6 Jul 2023 10:17:19 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Danylo Mocherniuk <mdanylo@google.com>,
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
To:     Andrei Vagin <avagin@gmail.com>
References: <20230628095426.1886064-1-usama.anjum@collabora.com>
 <20230628095426.1886064-3-usama.anjum@collabora.com>
 <ZJ7uOqPIJwMiCuOI@gmail.com>
 <49015b82-2f7f-fa34-d56a-2f427f38f28f@collabora.com>
 <ZKLkIpL7Ksr38VRb@gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZKLkIpL7Ksr38VRb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/3/23 8:07 PM, Andrei Vagin wrote:
> On Mon, Jul 03, 2023 at 11:47:37AM +0500, Muhammad Usama Anjum wrote:
>> On 6/30/23 8:01 PM, Andrei Vagin wrote:
>>> On Wed, Jun 28, 2023 at 02:54:23PM +0500, Muhammad Usama Anjum wrote:
>>>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>>>> the info about page table entries. The following operations are supported
>>>> in this ioctl:
>>>> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>>>>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT), swapped
>>>>   (PAGE_IS_SWAPPED) or page has pfn zero (PAGE_IS_PFNZERO).
>>>> - Find pages which have been written-to and/or write protect the pages
>>>>   (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)
>>>>
>>>> This IOCTL can be extended to get information about more PTE bits. The
>>>> entire address range passed by user [start, end) is scanned until either
>>>> the user provided buffer is full or max_pages have been found.
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>
>>> <snip>
>>>
>>>> +
>>>> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long __arg)
>>>> +{
>>>> +	struct pm_scan_arg __user *uarg = (struct pm_scan_arg __user *)__arg;
>>>> +	unsigned long long start, end, walk_start, walk_end;
>>>> +	unsigned long empty_slots, vec_index = 0;
>>>> +	struct mmu_notifier_range range;
>>>> +	struct page_region __user *vec;
>>>> +	struct pagemap_scan_private p;
>>>> +	struct pm_scan_arg arg;
>>>> +	int ret = 0;
>>>> +
>>>> +	if (copy_from_user(&arg, uarg, sizeof(arg)))
>>>> +		return -EFAULT;
>>>> +
>>>> +	start = untagged_addr((unsigned long)arg.start);
>>>> +	end = untagged_addr((unsigned long)arg.end);
>>>> +	vec = (struct page_region __user *)untagged_addr((unsigned long)arg.vec);
>>>> +
>>>> +	ret = pagemap_scan_args_valid(&arg, start, end, vec);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	p.max_pages = (arg.max_pages) ? arg.max_pages : ULONG_MAX;
>>>> +	p.found_pages = 0;
>>>> +	p.required_mask = arg.required_mask;
>>>> +	p.anyof_mask = arg.anyof_mask;
>>>> +	p.excluded_mask = arg.excluded_mask;
>>>> +	p.return_mask = arg.return_mask;
>>>> +	p.flags = arg.flags;
>>>> +	p.flags |= ((p.required_mask | p.anyof_mask | p.excluded_mask) &
>>>> +		    PAGE_IS_WRITTEN) ? PM_SCAN_REQUIRE_UFFD : 0;
>>>> +	p.cur_buf.start = p.cur_buf.len = p.cur_buf.flags = 0;
>>>> +	p.vec_buf = NULL;
>>>> +	p.vec_buf_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
>>>> +
>>>> +	/*
>>>> +	 * Allocate smaller buffer to get output from inside the page walk
>>>> +	 * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
>>>> +	 * we want to return output to user in compact form where no two
>>>> +	 * consecutive regions should be continuous and have the same flags.
>>>> +	 * So store the latest element in p.cur_buf between different walks and
>>>> +	 * store the p.cur_buf at the end of the walk to the user buffer.
>>>> +	 */
>>>> +	if (IS_PM_SCAN_GET(p.flags)) {
>>>> +		p.vec_buf = kmalloc_array(p.vec_buf_len, sizeof(*p.vec_buf),
>>>> +					  GFP_KERNEL);
>>>> +		if (!p.vec_buf)
>>>> +			return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	if (IS_PM_SCAN_WP(p.flags)) {
>>>> +		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
>>>> +					mm, start, end);
>>>> +		mmu_notifier_invalidate_range_start(&range);
>>>> +	}
>>>> +
>>>> +	walk_start = walk_end = start;
>>>> +	while (walk_end < end && !ret) {
>>>> +		if (IS_PM_SCAN_GET(p.flags)) {
>>>> +			p.vec_buf_index = 0;
>>>> +
>>>> +			/*
>>>> +			 * All data is copied to cur_buf first. When more data
>>>> +			 * is found, we push cur_buf to vec_buf and copy new
>>>> +			 * data to cur_buf. Subtract 1 from length as the
>>>> +			 * index of cur_buf isn't counted in length.
>>>> +			 */
>>>> +			empty_slots = arg.vec_len - vec_index;
>>>> +			p.vec_buf_len = min(p.vec_buf_len, empty_slots - 1);
>>>> +		}
>>>> +
>>>> +		ret = mmap_read_lock_killable(mm);
>>>> +		if (ret)
>>>> +			goto return_status;
>>>> +
>>>> +		walk_end = min((walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK, end);
>>>> +
>>>> +		ret = walk_page_range(mm, walk_start, walk_end,
>>>> +				      &pagemap_scan_ops, &p);
>>>> +		mmap_read_unlock(mm);
>>>> +
>>>> +		if (ret && ret != PM_SCAN_FOUND_MAX_PAGES &&
>>>> +		    ret != PM_SCAN_END_WALK)
>>>> +			goto return_status;
>>>> +
>>>> +		walk_start = walk_end;
>>>> +		if (IS_PM_SCAN_GET(p.flags) && p.vec_buf_index) {
>>>> +			if (copy_to_user(&vec[vec_index], p.vec_buf,
>>>> +					 p.vec_buf_index * sizeof(*p.vec_buf))) {
>>>> +				/*
>>>> +				 * Return error even though the OP succeeded
>>>> +				 */
>>>> +				ret = -EFAULT;
>>>> +				goto return_status;
>>>> +			}
>>>> +			vec_index += p.vec_buf_index;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (p.cur_buf.len) {
>>>> +		if (copy_to_user(&vec[vec_index], &p.cur_buf, sizeof(p.cur_buf))) {
>>>> +			ret = -EFAULT;
>>>> +			goto return_status;
>>>> +		}
>>>> +		vec_index++;
>>>> +	}
>>>> +
>>>> +	ret = vec_index;
>>>> +
>>>> +return_status:
>>>> +	arg.start = (unsigned long)walk_end;
>>>
>>> This doesn't look right. pagemap_scan_pmd_entry can stop early. For
>>> example, it can happen when it hits the max_pages limit. Do I miss
>>> something?
>> The walk_page_range() calls pagemap_scan_pmd_entry(). So whatever status is
>> returned from pagemap_scan_pmd_entry(), walk_page_range() returns to this
>> function where we are handling the status code. After while loop starts,
>> there is only 1 return path. Hence there isn't any path missing where we'll
>> miss setting arg.start.
> 
> I mean walk_end isn't actually the end address. The end adress should be
> the next page after the last revised page. Here we don't know whether
> all pages in [walk_start, walk_end) has been revised.
Sorry, understood. Let me post the new patch series.

> 
>>
>>>
>>>> +	if (copy_to_user(&uarg->start, &arg.start, sizeof(arg.start)))
>>>> +		ret = -EFAULT;
>>>> +
>>>> +	if (IS_PM_SCAN_WP(p.flags))
>>>> +		mmu_notifier_invalidate_range_end(&range);
>>>> +
>>>> +	kfree(p.vec_buf);
>>>> +	return ret;
>>>> +}
>>>> +
>>
>> -- 
>> BR,
>> Muhammad Usama Anjum

-- 
BR,
Muhammad Usama Anjum
