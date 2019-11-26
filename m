Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39AD810A722
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 00:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKZXev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 18:34:51 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39294 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726445AbfKZXev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 18:34:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TjAobng_1574811280;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TjAobng_1574811280)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Nov 2019 07:34:44 +0800
Subject: Re: [RFC PATCH] mm: shmem: allow split THP when truncating THP
 partially
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     hughd@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1574471132-55639-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191125093611.hlamtyo4hvefwibi@box>
 <3a35da3a-dff0-a8ca-8269-3018fff8f21b@linux.alibaba.com>
 <20191125183350.5gmcln6t3ofszbsy@box>
 <9a68b929-2f84-083d-0ac8-2ceb3eab8785@linux.alibaba.com>
Message-ID: <14b7c24b-706e-79cf-6fbc-f3c042f30f06@linux.alibaba.com>
Date:   Tue, 26 Nov 2019 15:34:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9a68b929-2f84-083d-0ac8-2ceb3eab8785@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/25/19 11:33 AM, Yang Shi wrote:
>
>
> On 11/25/19 10:33 AM, Kirill A. Shutemov wrote:
>> On Mon, Nov 25, 2019 at 10:24:38AM -0800, Yang Shi wrote:
>>>
>>> On 11/25/19 1:36 AM, Kirill A. Shutemov wrote:
>>>> On Sat, Nov 23, 2019 at 09:05:32AM +0800, Yang Shi wrote:
>>>>> Currently when truncating shmem file, if the range is partial of THP
>>>>> (start or end is in the middle of THP), the pages actually will 
>>>>> just get
>>>>> cleared rather than being freed unless the range cover the whole THP.
>>>>> Even though all the subpages are truncated (randomly or 
>>>>> sequentially),
>>>>> the THP may still be kept in page cache.  This might be fine for some
>>>>> usecases which prefer preserving THP.
>>>>>
>>>>> But, when doing balloon inflation in QEMU, QEMU actually does hole 
>>>>> punch
>>>>> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not 
>>>>> used.
>>>>> So, when using shmem THP as memory backend QEMU inflation actually 
>>>>> doesn't
>>>>> work as expected since it doesn't free memory.  But, the inflation
>>>>> usecase really needs get the memory freed.  Anonymous THP will not 
>>>>> get
>>>>> freed right away too but it will be freed eventually when all 
>>>>> subpages are
>>>>> unmapped, but shmem THP would still stay in page cache.
>>>>>
>>>>> To protect the usecases which may prefer preserving THP, introduce a
>>>>> new fallocate mode: FALLOC_FL_SPLIT_HPAGE, which means spltting 
>>>>> THP is
>>>>> preferred behavior if truncating partial THP.  This mode just makes
>>>>> sense to tmpfs for the time being.
>>>> We need to clarify interaction with khugepaged. This implementation
>>>> doesn't do anything to prevent khugepaged from collapsing the range 
>>>> back
>>>> to THP just after the split.
>>> Yes, it doesn't. Will clarify this in the commit log.
>> Okay, but I'm not sure that documention alone will be enough. We need
>> proper design.
>
> Maybe we could try to hold inode lock with read during 
> collapse_file(). The shmem fallocate does acquire inode lock with 
> write, this should be able to synchronize hole punch and khugepaged. 
> And, shmem just needs hold inode lock for llseek and fallocate, I'm 
> supposed they are should be called not that frequently to have impact 
> on khugepaged. The llseek might be often, but it should be quite fast. 
> However, they might get blocked by khugepaged.
>
> It sounds safe to hold a rwsem during collapsing THP.
>
> Or we could set VM_NOHUGEPAGE in shmem inode's flag with hole punch 
> and clear it after truncate, then check the flag before doing collapse 
> in khugepaged. khugepaged should not need hold the inode lock during 
> collapse since it could be released after the flag is checked.

By relooking the code, it looks the latter one (check VM_NOHUGEPAGE) 
doesn't make sense, it can't prevent khugepaged from collapsing THP in 
parallel.

>
>>
>>>>> @@ -976,8 +1022,31 @@ static void shmem_undo_range(struct inode 
>>>>> *inode, loff_t lstart, loff_t lend,
>>>>>                }
>>>>>                unlock_page(page);
>>>>>            }
>>>>> +rescan_split:
>>>>>            pagevec_remove_exceptionals(&pvec);
>>>>>            pagevec_release(&pvec);
>>>>> +
>>>>> +        if (split && PageTransCompound(page)) {
>>>>> +            /* The THP may get freed under us */
>>>>> +            if (!get_page_unless_zero(compound_head(page)))
>>>>> +                goto rescan_out;
>>>>> +
>>>>> +            lock_page(page);
>>>>> +
>>>>> +            /*
>>>>> +             * The extra pins from page cache lookup have been
>>>>> +             * released by pagevec_release().
>>>>> +             */
>>>>> +            if (!split_huge_page(page)) {
>>>>> +                unlock_page(page);
>>>>> +                put_page(page);
>>>>> +                /* Re-look up page cache from current index */
>>>>> +                goto again;
>>>>> +            }
>>>>> +            unlock_page(page);
>>>>> +            put_page(page);
>>>>> +        }
>>>>> +rescan_out:
>>>>>            index++;
>>>>>        }
>>>> Doing get_page_unless_zero() just after you've dropped the pin for the
>>>> page looks very suboptimal.
>>> If I don't drop the pins the THP can't be split. And, there might be 
>>> more
>>> than one pins from find_get_entries() if I read the code correctly. For
>>> example, truncate 8K length in the middle of THP, the THP's refcount 
>>> would
>>> get bumpped twice since  two sub pages would be returned.
>> Pin the page before pagevec_release() and avoid get_page_unless_zero().
>>
>> Current code is buggy. You need to check that the page is still 
>> belong to
>> the file after speculative lookup.
>
> Yes, I missed this point. Thanks for the suggestion.
>
>>
>

