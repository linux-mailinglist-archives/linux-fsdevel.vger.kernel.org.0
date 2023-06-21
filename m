Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E10737BB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 09:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjFUHDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 03:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjFUHDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:03:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28061706;
        Wed, 21 Jun 2023 00:02:58 -0700 (PDT)
Received: from [192.168.10.54] (unknown [119.155.63.248])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4FAA76606F53;
        Wed, 21 Jun 2023 08:02:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687330977;
        bh=4zCIr0nvtkxqnHDb33CDUF+eZAo3KpOgtTvlUQMRH4s=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=LhFqo2R4ekMCMbK8KGAN+/1chKfL4dQnXPZ2PNnSBNfNs9YcMcyM35d9PR/QVaVS6
         UzSCaqmoNxu+FQHH+pd1yUdUWQC9zS6WESdMiRx49WnYVD3JbzieoMdit7+5eHOUaG
         5ZpcrybkUpQ0gM6n0rVDJUp/Mb8rcP/MQKSxtTHrUT+2V9el762YoHUkIDvytTEWJ/
         F+7dQ1xtLSi0sqHgF71p+oZhnRmiAUbP44ZmmqLVD6DCVsUI7CABQJMEXiWFh5oVJu
         3wboyArYZUkeGt0p4Z8cqg8EHWY4eSLfsS4Piyfc7faitrZYIlsr6xVpnGoYTYkGWU
         oYC6FAd+ndyXw==
Message-ID: <9af9a116-cab4-be02-4616-f809291f46e7@collabora.com>
Date:   Wed, 21 Jun 2023 12:02:46 +0500
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
Subject: Re: [PATCH v19 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     Andrei Vagin <avagin@gmail.com>
References: <20230615141144.665148-1-usama.anjum@collabora.com>
 <20230615141144.665148-3-usama.anjum@collabora.com>
 <ZI1VGsaOZ2a1HiKN@gmail.com>
 <212e331f-35b0-5ae7-6371-26caa577d637@collabora.com>
 <ZJKbxKrJRy/L2JuA@gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZJKbxKrJRy/L2JuA@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/21/23 11:42 AM, Andrei Vagin wrote:
> On Mon, Jun 19, 2023 at 11:06:36AM +0500, Muhammad Usama Anjum wrote:
>> On 6/17/23 11:39 AM, Andrei Vagin wrote:
>>> On Thu, Jun 15, 2023 at 07:11:41PM +0500, Muhammad Usama Anjum wrote:
>>>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>>>> +				  unsigned long end, struct mm_walk *walk)
>>>> +{
>>>> +	bool is_written, flush = false, is_interesting = true;
>>>> +	struct pagemap_scan_private *p = walk->private;
>>>> +	struct vm_area_struct *vma = walk->vma;
>>>> +	unsigned long bitmap, addr = end;
>>>> +	pte_t *pte, *orig_pte, ptent;
>>>> +	spinlock_t *ptl;
>>>> +	int ret = 0;
>>>> +
>>>> +	arch_enter_lazy_mmu_mode();
>>>> +
>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> +	ptl = pmd_trans_huge_lock(pmd, vma);
>>>> +	if (ptl) {
>>>> +		unsigned long n_pages = (end - start)/PAGE_SIZE;
>>>> +
>>>> +		if (p->max_pages && n_pages > p->max_pages - p->found_pages)
>>>> +			n_pages = p->max_pages - p->found_pages;
>>>> +
>>>> +		is_written = !is_pmd_uffd_wp(*pmd);
>>>> +
>>>> +		/*
>>>> +		 * Break huge page into small pages if the WP operation need to
>>>> +		 * be performed is on a portion of the huge page.
>>>> +		 */
>>>> +		if (is_written && IS_PM_SCAN_WP(p->flags) &&
>>>> +		    n_pages < HPAGE_SIZE/PAGE_SIZE) {
>>>> +			spin_unlock(ptl);
>>>> +
>>>> +			split_huge_pmd(vma, pmd, start);
>>>> +			goto process_smaller_pages;
>>>> +		}
>>>> +
>>>> +		bitmap = PM_SCAN_FLAGS(is_written, (bool)vma->vm_file,
>>>> +				       pmd_present(*pmd), is_swap_pmd(*pmd));
>>>> +
>>>> +		if (IS_PM_SCAN_GET(p->flags)) {
>>>> +			is_interesting = pagemap_scan_is_interesting_page(bitmap, p);
>>>> +			if (is_interesting)
>>>> +				ret = pagemap_scan_output(bitmap, p, start, n_pages);
>>>> +		}
>>>> +
>>>> +		if (IS_PM_SCAN_WP(p->flags) && is_written && is_interesting &&
>>>> +		    ret >= 0) {
>>>> +			make_uffd_wp_pmd(vma, start, pmd);
>>>> +			flush_tlb_range(vma, start, end);
>>>> +		}
>>>> +
>>>> +		spin_unlock(ptl);
>>>> +
>>>> +		arch_leave_lazy_mmu_mode();
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +process_smaller_pages:
>>>> +#endif
>>>> +
>>>> +	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
>>>> +	if (!pte) {
>>>
>>> Do we need to unlock ptl here?
>>>
>>> 		spin_unlock(ptl);
>> No, please look at these recently merged patches:
>> https://lore.kernel.org/all/c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com
>>
>>>
>>>> +		walk->action = ACTION_AGAIN;
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE) {
>>>> +		ptent = ptep_get(pte);
>>>> +		is_written = !is_pte_uffd_wp(ptent);
>>>> +
>>>> +		bitmap = PM_SCAN_FLAGS(is_written, (bool)vma->vm_file,
>>>> +				       pte_present(ptent), is_swap_pte(ptent));
>>>
>>> The vma->vm_file check isn't correct in this case. You can look when
>>> pte_to_pagemap_entry sets PM_FILE. This flag is used to detect what
>>> pages have a file backing store and what pages are anonymous.
>> I'll update.
>>
>>>
>>> I was trying to integrate this new interace into CRIU and I found
>>> one more thing that is required. We need to detect zero pages.
>> Should we name it ZERO_PFN_PRESENT_PAGE to be exact or what?
> 
> IMHO, ZERO_PFN_PRESENT_PAGE looks a bit monstrous.
> It looks like zero page is a proper noun in the kernel, so PAGE_IS_ZERO
> might be a good choice here, but it is up to you.
> 
>>
>>>
>>> It should look something like this:
>>>
>>> #define PM_SCAN_FLAGS(wt, file, present, swap, zero)   \
>>>        ((wt) | ((file) << 1) | ((present) << 2) | ((swap) << 3) | ((zero) << 4))
>>>
>>>
>>> bitmap = PM_SCAN_FLAGS(is_written, page && !PageAnon(page),
>>> 		      pte_present(ptent), is_swap_pte(ptent),
>>> 		      pte_present(ptent) && is_zero_pfn(pte_pfn(ptent)));
>> Okay. Can you please confirm my assumptions:
>> - A THP cannot be file backed. (PM_FILE isn't being set for THP case)
> 
> ```
> Currently THP only works for anonymous memory mappings and tmpfs/shmem.
> But in the future it can expand to other filesystems. 
> ```
> https://www.kernel.org/doc/html/next/admin-guide/mm/transhuge.html
> 
> so THP can be "file backed".
> 
>> - A hole is also not file backed.
>>
>> A hole isn't present in memory. So its pfn would be zero. But as it isn't
>> present, it shouldn't report zero page. Right? For hole::
>>
>> PM_SCAN_FLAGS(false, false, false, false, false)
> 
> This looks correct to me.
Thanks. I'll sent next version in a few minutes.


> 

-- 
BR,
Muhammad Usama Anjum
