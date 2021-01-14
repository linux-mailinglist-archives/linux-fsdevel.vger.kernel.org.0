Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2412F59A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 04:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbhANDxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 22:53:21 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61902 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726677AbhANDxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:53:21 -0500
X-IronPort-AV: E=Sophos;i="5.79,346,1602518400"; 
   d="scan'208";a="103466040"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Jan 2021 11:52:18 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 929244CE602D;
        Thu, 14 Jan 2021 11:52:16 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Jan
 2021 11:52:17 +0800
Subject: Re: [PATCH 04/10] mm, fsdax: Refactor memory-failure handler for dax
 mapping
To:     zhong jiang <zhongjiang-ali@linux.alibaba.com>,
        Jan Kara <jack@suse.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
 <20201230165601.845024-5-ruansy.fnst@cn.fujitsu.com>
 <20210106154132.GC29271@quack2.suse.cz>
 <75164044-bfdf-b2d6-dff0-d6a8d56d1f62@cn.fujitsu.com>
 <781f276b-afdd-091c-3dba-048e415431ab@linux.alibaba.com>
 <ef29ba5c-96d7-d0bb-e405-c7472a518b32@cn.fujitsu.com>
 <e2f7ad16-8162-4933-9091-72e690e9877e@linux.alibaba.com>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <4f184987-3cc2-c72d-0774-5d20ea2e1d49@cn.fujitsu.com>
Date:   Thu, 14 Jan 2021 11:52:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <e2f7ad16-8162-4933-9091-72e690e9877e@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 929244CE602D.ADB7E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/1/14 上午11:26, zhong jiang wrote:
> 
> On 2021/1/14 9:44 上午, Ruan Shiyang wrote:
>>
>>
>> On 2021/1/13 下午6:04, zhong jiang wrote:
>>>
>>> On 2021/1/12 10:55 上午, Ruan Shiyang wrote:
>>>>
>>>>
>>>> On 2021/1/6 下午11:41, Jan Kara wrote:
>>>>> On Thu 31-12-20 00:55:55, Shiyang Ruan wrote:
>>>>>> The current memory_failure_dev_pagemap() can only handle 
>>>>>> single-mapped
>>>>>> dax page for fsdax mode.  The dax page could be mapped by multiple 
>>>>>> files
>>>>>> and offsets if we let reflink feature & fsdax mode work together. So,
>>>>>> we refactor current implementation to support handle memory 
>>>>>> failure on
>>>>>> each file and offset.
>>>>>>
>>>>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
>>>>>
>>>>> Overall this looks OK to me, a few comments below.
>>>>>
>>>>>> ---
>>>>>>   fs/dax.c            | 21 +++++++++++
>>>>>>   include/linux/dax.h |  1 +
>>>>>>   include/linux/mm.h  |  9 +++++
>>>>>>   mm/memory-failure.c | 91 
>>>>>> ++++++++++++++++++++++++++++++++++-----------
>>>>>>   4 files changed, 100 insertions(+), 22 deletions(-)
>>>>
>>>> ...
>>>>
>>>>>>   @@ -345,9 +348,12 @@ static void add_to_kill(struct task_struct 
>>>>>> *tsk, struct page *p,
>>>>>>       }
>>>>>>         tk->addr = page_address_in_vma(p, vma);
>>>>>> -    if (is_zone_device_page(p))
>>>>>> -        tk->size_shift = dev_pagemap_mapping_shift(p, vma);
>>>>>> -    else
>>>>>> +    if (is_zone_device_page(p)) {
>>>>>> +        if (is_device_fsdax_page(p))
>>>>>> +            tk->addr = vma->vm_start +
>>>>>> +                    ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>>>>>
>>>>> It seems strange to use 'pgoff' for dax pages and not for any other 
>>>>> page.
>>>>> Why? I'd rather pass correct pgoff from all callers of 
>>>>> add_to_kill() and
>>>>> avoid this special casing...
>>>>
>>>> Because one fsdax page can be shared by multiple pgoffs.  I have to 
>>>> pass each pgoff in each iteration to calculate the address in vma 
>>>> (for tk->addr).  Other kinds of pages don't need this. They can get 
>>>> their unique address by calling "page_address_in_vma()".
>>>>
>>> IMO,   an fsdax page can be shared by multiple files rather than 
>>> multiple pgoffs if fs query support reflink.   Because an page only 
>>> located in an mapping(page->mapping is exclusive), hence it  only has 
>>> an pgoff or index pointing at the node.
>>>
>>>   or  I miss something for the feature ?  thanks,
>>
>> Yes, a fsdax page is shared by multiple files because of reflink. I 
>> think my description of 'pgoff' here is not correct.  This 'pgoff' 
>> means the offset within the a file.  (We use rmap to find out all the 
>> sharing files and their offsets.)  So, I said that "can be shared by 
>> multiple pgoffs".  It's my bad.
>>
>> I think I should name it another word to avoid misunderstandings.
>>
> IMO,  All the sharing files should be the same offset to share the fsdax 
> page.  why not that ? 

The dedupe operation can let different files share their same data 
extent, though offsets are not same.  So, files can share one fsdax page 
at different offset.

> As you has said,  a shared fadax page should be 
> inserted to different mapping files.  but page->index and page->mapping 
> is exclusive.  hence an page only should be placed in an mapping tree.

We can't use page->mapping and page->index here for reflink & fsdax. 
And that's this patchset aims to solve.  I introduced a series of 
->corrupted_range(), from mm to pmem driver to block device and finally 
to filesystem, to use rmap feature of filesystem to find out all files 
sharing same data extent (fsdax page).


--
Thanks,
Ruan Shiyang.

> 
> And In the current patch,  we failed to found out that all process use 
> the fsdax page shared by multiple files and kill them.
> 
> 
> Thanks,
> 
>> -- 
>> Thanks,
>> Ruan Shiyang.
>>
>>>
>>>> So, I added this fsdax case here.  This patchset only implemented 
>>>> the fsdax case, other cases also need to be added here if to be 
>>>> implemented.
>>>>
>>>>
>>>> -- 
>>>> Thanks,
>>>> Ruan Shiyang.
>>>>
>>>>>
>>>>>> +        tk->size_shift = dev_pagemap_mapping_shift(p, vma, 
>>>>>> tk->addr);
>>>>>> +    } else
>>>>>>           tk->size_shift = page_shift(compound_head(p));
>>>>>>         /*
>>>>>> @@ -495,7 +501,7 @@ static void collect_procs_anon(struct page 
>>>>>> *page, struct list_head *to_kill,
>>>>>>               if (!page_mapped_in_vma(page, vma))
>>>>>>                   continue;
>>>>>>               if (vma->vm_mm == t->mm)
>>>>>> -                add_to_kill(t, page, vma, to_kill);
>>>>>> +                add_to_kill(t, page, NULL, 0, vma, to_kill);
>>>>>>           }
>>>>>>       }
>>>>>>       read_unlock(&tasklist_lock);
>>>>>> @@ -505,24 +511,19 @@ static void collect_procs_anon(struct page 
>>>>>> *page, struct list_head *to_kill,
>>>>>>   /*
>>>>>>    * Collect processes when the error hit a file mapped page.
>>>>>>    */
>>>>>> -static void collect_procs_file(struct page *page, struct 
>>>>>> list_head *to_kill,
>>>>>> -                int force_early)
>>>>>> +static void collect_procs_file(struct page *page, struct 
>>>>>> address_space *mapping,
>>>>>> +        pgoff_t pgoff, struct list_head *to_kill, int force_early)
>>>>>>   {
>>>>>>       struct vm_area_struct *vma;
>>>>>>       struct task_struct *tsk;
>>>>>> -    struct address_space *mapping = page->mapping;
>>>>>> -    pgoff_t pgoff;
>>>>>>         i_mmap_lock_read(mapping);
>>>>>>       read_lock(&tasklist_lock);
>>>>>> -    pgoff = page_to_pgoff(page);
>>>>>>       for_each_process(tsk) {
>>>>>>           struct task_struct *t = task_early_kill(tsk, force_early);
>>>>>> -
>>>>>>           if (!t)
>>>>>>               continue;
>>>>>> -        vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff,
>>>>>> -                      pgoff) {
>>>>>> +        vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, 
>>>>>> pgoff) {
>>>>>>               /*
>>>>>>                * Send early kill signal to tasks where a vma covers
>>>>>>                * the page but the corrupted page is not necessarily
>>>>>> @@ -531,7 +532,7 @@ static void collect_procs_file(struct page 
>>>>>> *page, struct list_head *to_kill,
>>>>>>                * to be informed of all such data corruptions.
>>>>>>                */
>>>>>>               if (vma->vm_mm == t->mm)
>>>>>> -                add_to_kill(t, page, vma, to_kill);
>>>>>> +                add_to_kill(t, page, mapping, pgoff, vma, to_kill);
>>>>>>           }
>>>>>>       }
>>>>>>       read_unlock(&tasklist_lock);
>>>>>> @@ -550,7 +551,8 @@ static void collect_procs(struct page *page, 
>>>>>> struct list_head *tokill,
>>>>>>       if (PageAnon(page))
>>>>>>           collect_procs_anon(page, tokill, force_early);
>>>>>>       else
>>>>>> -        collect_procs_file(page, tokill, force_early);
>>>>>> +        collect_procs_file(page, page->mapping, page_to_pgoff(page),
>>>>>
>>>>> Why not use page_mapping() helper here? It would be safer for THPs 
>>>>> if they
>>>>> ever get here...
>>>>>
>>>>>                                 Honza
>>>>>
>>>>
>>>
>>>
>>
> 
> 


