Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984E1695B80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 08:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjBNH5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 02:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjBNH5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:57:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D772C21A25;
        Mon, 13 Feb 2023 23:57:33 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.179.179])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EECDE660216F;
        Tue, 14 Feb 2023 07:57:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676361452;
        bh=bLuH3JNMnvAE/sd8bnRNmS8hADblvHZLNhfCr4oCcs0=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ok3IRdMKvUkFcuLuDpafb/xmh9qr1fWMpvlJCB9RJ37YXB1qHtxPPzQJBmrpYhXGb
         aUEnFVi4PZCGRImQcghZRjXGN4C1VYoLrv+mopvvN5yUn1XRKNKgzMvTbmVngYGGZN
         T6dv5VOmBAwkkde4WCYfqhU8xnu6VTRXL6kpa5AYGNFpsjDVHtoUob5yZBRWC7hqIJ
         Wo4bV6ZwlQcKRCih0/JMbH42HY826QLorvWUQOsD7jI0LXmLV6oHe9VnzepM7WifWL
         SAGOqaa2X3WXuQEoQtknmsZaAJZ3P35wR2zCczus7cm14240bL+hM+/JZvqKl/iuWn
         TqvN+F4jTROjA==
Message-ID: <39217d9a-ed7e-f1ff-59b9-4cbffa464999@collabora.com>
Date:   Tue, 14 Feb 2023 12:57:21 +0500
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
To:     Peter Xu <peterx@redhat.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com> <Y+QfDN4Y5Q10x8GQ@x1n>
 <8b2959fb-2a74-0a1f-8833-0b18eab142dc@collabora.com> <Y+qur8iIUQTLyE8f@x1n>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+qur8iIUQTLyE8f@x1n>
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

On 2/14/23 2:42 AM, Peter Xu wrote:
> On Mon, Feb 13, 2023 at 05:55:19PM +0500, Muhammad Usama Anjum wrote:
>> On 2/9/23 3:15 AM, Peter Xu wrote:
>>> On Thu, Feb 02, 2023 at 04:29:12PM +0500, Muhammad Usama Anjum wrote:
>>>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>>>> the info about page table entries. The following operations are supported
>>>> in this ioctl:
>>>> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>>>>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>>>>   (PAGE_IS_SWAPPED).
>>>> - Write-protect the pages (PAGEMAP_WP_ENGAGE) to start finding which
>>>>   pages have been written-to.
>>>> - Find pages which have been written-to and write protect the pages
>>>>   (atomic PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE)
>>>>
>>>> To get information about which pages have been written-to and/or write
>>>> protect the pages, following must be performed first in order:
>>>> - The userfaultfd file descriptor is created with userfaultfd syscall.
>>>> - The UFFD_FEATURE_WP_ASYNC feature is set by UFFDIO_API IOCTL.
>>>> - The memory range is registered with UFFDIO_REGISTER_MODE_WP mode
>>>>   through UFFDIO_REGISTER IOCTL.
>>>> Then the any part of the registered memory or the whole memory region
>>>> can be write protected using the UFFDIO_WRITEPROTECT IOCTL or
>>>> PAGEMAP_SCAN IOCTL.
>>>>
>>>> struct pagemap_scan_args is used as the argument of the IOCTL. In this
>>>> struct:
>>>> - The range is specified through start and len.
>>>> - The output buffer of struct page_region array and size is specified as
>>>>   vec and vec_len.
>>>> - The optional maximum requested pages are specified in the max_pages.
>>>> - The flags can be specified in the flags field. The PAGEMAP_WP_ENGAGE
>>>>   is the only added flag at this time.
>>>> - The masks are specified in required_mask, anyof_mask, excluded_ mask
>>>>   and return_mask.
>>>>
>>>> This IOCTL can be extended to get information about more PTE bits. This
>>>> IOCTL doesn't support hugetlbs at the moment. No information about
>>>> hugetlb can be obtained. This patch has evolved from a basic patch from
>>>> Gabriel Krisman Bertazi.
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>> Changes in v10:
>>>> - move changes in tools/include/uapi/linux/fs.h to separate patch
>>>> - update commit message
>>>>
>>>> Change in v8:
>>>> - Correct is_pte_uffd_wp()
>>>> - Improve readability and error checks
>>>> - Remove some un-needed code
>>>>
>>>> Changes in v7:
>>>> - Rebase on top of latest next
>>>> - Fix some corner cases
>>>> - Base soft-dirty on the uffd wp async
>>>> - Update the terminologies
>>>> - Optimize the memory usage inside the ioctl
>>>>
>>>> Changes in v6:
>>>> - Rename variables and update comments
>>>> - Make IOCTL independent of soft_dirty config
>>>> - Change masks and bitmap type to _u64
>>>> - Improve code quality
>>>>
>>>> Changes in v5:
>>>> - Remove tlb flushing even for clear operation
>>>>
>>>> Changes in v4:
>>>> - Update the interface and implementation
>>>>
>>>> Changes in v3:
>>>> - Tighten the user-kernel interface by using explicit types and add more
>>>>   error checking
>>>>
>>>> Changes in v2:
>>>> - Convert the interface from syscall to ioctl
>>>> - Remove pidfd support as it doesn't make sense in ioctl
>>>> ---
>>>>  fs/proc/task_mmu.c      | 290 ++++++++++++++++++++++++++++++++++++++++
>>>>  include/uapi/linux/fs.h |  50 +++++++
>>>>  2 files changed, 340 insertions(+)
>>>>
>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>> index e35a0398db63..c6bde19d63d9 100644
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>>> @@ -19,6 +19,7 @@
>>>>  #include <linux/shmem_fs.h>
>>>>  #include <linux/uaccess.h>
>>>>  #include <linux/pkeys.h>
>>>> +#include <linux/minmax.h>
>>>>  
>>>>  #include <asm/elf.h>
>>>>  #include <asm/tlb.h>
>>>> @@ -1135,6 +1136,22 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
>>>>  }
>>>>  #endif
>>>>  
>>>> +static inline bool is_pte_uffd_wp(pte_t pte)
>>>> +{
>>>> +	if ((pte_present(pte) && pte_uffd_wp(pte)) ||
>>>> +	    (pte_swp_uffd_wp_any(pte)))
>>>> +		return true;
>>>> +	return false;
>>>
>>> Sorry I should have mentioned this earlier: you can directly return here.
>> No problem at all. I'm replacing these two helper functions with following
>> in next version so that !present pages don't show as dirty:
>>
>> static inline bool is_pte_written(pte_t pte)
>> {
>> 	if ((pte_present(pte) && pte_uffd_wp(pte)) ||
>> 	    (pte_swp_uffd_wp_any(pte)))
>> 		return false;
>> 	return (pte_present(pte) || is_swap_pte(pte));
>> }
> 
> Could you explain why you don't want to return dirty for !present?  A page
> can be written then swapped out.  Don't you want to know that happened
> (from dirty tracking POV)?
> 
> The code looks weird to me too..  We only have three types of ptes: (1)
> present, (2) swap, (3) none.
> 
> Then, "(pte_present() || is_swap_pte())" is the same as !pte_none().  Is
> that what you're really looking for?
Yes, this is what I've been trying to do. I'll use !pte_none() to make it
simpler.

> 
>>
>> static inline bool is_pmd_written(pmd_t pmd)
>> {
>> 	if ((pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
>> 	    (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd)))
>> 		return false;
>> 	return (pmd_present(pmd) || is_swap_pmd(pmd));
>> }
> 
> [...]
> 
>>>> +	bitmap = cur & p->return_mask;
>>>> +	if (cpy && bitmap) {
>>>> +		if ((prev->len) && (prev->bitmap == bitmap) &&
>>>> +		    (prev->start + prev->len * PAGE_SIZE == addr)) {
>>>> +			prev->len += len;
>>>> +			p->found_pages += len;
>>>> +		} else if (p->vec_index < p->vec_len) {
>>>> +			if (prev->len) {
>>>> +				memcpy(&p->vec[p->vec_index], prev, sizeof(struct page_region));
>>>> +				p->vec_index++;
>>>> +			}
>>>
>>> IIUC you can have:
>>>
>>>   int pagemap_scan_deposit(p)
>>>   {
>>>         if (p->vec_index >= p->vec_len)
>>>                 return -ENOSPC;
>>>
>>>         if (p->prev->len) {
>>>                 memcpy(&p->vec[p->vec_index], prev, sizeof(struct page_region));
>>>                 p->vec_index++;
>>>         }
>>>
>>>         return 0;
>>>   }
>>>
>>> Then call it here.  I think it can also be called below to replace
>>> export_prev_to_out().
>> No this isn't possible. We fill up prev until the next range doesn't merge
>> with it. At that point, we put prev into the output buffer and new range is
>> put into prev. Now that we have shifted to smaller page walks of <= 512
>> entries. We want to visit all ranges before finally putting the prev to
>> output. Sorry to have this some what complex method. The problem is that we
>> want to merge the consective matching regions into one entry in the output.
>> So to achieve this among multiple different page walks, the prev is being used.
>>
>> Lets suppose we want to visit memory from 0x7FFF00000000 to 7FFF00400000
>> having length of 1024 pages and all of the memory has been written.
>> walk_page_range() will be called 2 times. In the first call, prev will be
>> set having length of 512. In second call, prev will be updated to 1024 as
>> the previous range stored in prev could be extended. After this, the prev
>> will be stored to the user output buffer consuming only 1 struct of page_range.
>>
>> If we store prev back to output memory in every walk_page_range() call, we
>> wouldn't get 1 struct of page_range with length 1024. Instead we would get
>> 2 elements of page_range structs with half the length.
> 
> I didn't mean to merge PREV for each pgtable walk.  What I meant is I think
> with such a pagemap_scan_deposit() you can rewrite it as:
> 
> if (cpy && bitmap) {
>         if ((prev->len) && (prev->bitmap == bitmap) &&
>             (prev->start + prev->len * PAGE_SIZE == addr)) {
>                 prev->len += len;
>                 p->found_pages += len;
>         } else {
>                 if (pagemap_scan_deposit(p))
>                         return -ENOSPC;
>                 prev->start = addr;
>                 prev->len = len;
>                 prev->bitmap = bitmap;
>                 p->found_pages += len;
>         }
> }
> 
> Then you can reuse pagemap_scan_deposit() when before returning to
> userspace, just to flush PREV to p->vec properly in a single helper.
> It also makes the code slightly easier to read.
Yeah, this would have worked as you have described. But in
pagemap_scan_output(), we are flushing prev to p->vec. But later in
export_prev_to_out() we need to flush prev to user_memory directly.


> 

-- 
BR,
Muhammad Usama Anjum
