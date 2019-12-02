Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748DB10F344
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 00:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfLBXPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 18:15:10 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:49495 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbfLBXPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:15:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TjlWD-8_1575328498;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TjlWD-8_1575328498)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Dec 2019 07:15:06 +0800
Subject: Re: [RFC PATCH] mm: shmem: allow split THP when truncating THP
 partially
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>
Cc:     kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1574471132-55639-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191125093611.hlamtyo4hvefwibi@box>
 <3a35da3a-dff0-a8ca-8269-3018fff8f21b@linux.alibaba.com>
 <20191125183350.5gmcln6t3ofszbsy@box>
 <9a68b929-2f84-083d-0ac8-2ceb3eab8785@linux.alibaba.com>
 <14b7c24b-706e-79cf-6fbc-f3c042f30f06@linux.alibaba.com>
 <alpine.LSU.2.11.1911271718130.652@eggly.anvils>
 <20191128113456.5phjhd3ajgky3h3i@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a3af0afd-6b45-495d-8e88-abdef5204329@linux.alibaba.com>
Date:   Mon, 2 Dec 2019 15:14:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191128113456.5phjhd3ajgky3h3i@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/28/19 3:34 AM, Kirill A. Shutemov wrote:
> On Wed, Nov 27, 2019 at 07:06:01PM -0800, Hugh Dickins wrote:
>> On Tue, 26 Nov 2019, Yang Shi wrote:
>>> On 11/25/19 11:33 AM, Yang Shi wrote:
>>>> On 11/25/19 10:33 AM, Kirill A. Shutemov wrote:
>>>>> On Mon, Nov 25, 2019 at 10:24:38AM -0800, Yang Shi wrote:
>>>>>> On 11/25/19 1:36 AM, Kirill A. Shutemov wrote:
>>>>>>> On Sat, Nov 23, 2019 at 09:05:32AM +0800, Yang Shi wrote:
>>>>>>>> Currently when truncating shmem file, if the range is partial of
>>>>>>>> THP
>>>>>>>> (start or end is in the middle of THP), the pages actually will
>>>>>>>> just get
>>>>>>>> cleared rather than being freed unless the range cover the whole
>>>>>>>> THP.
>>>>>>>> Even though all the subpages are truncated (randomly or
>>>>>>>> sequentially),
>>>>>>>> the THP may still be kept in page cache.  This might be fine for
>>>>>>>> some
>>>>>>>> usecases which prefer preserving THP.
>>>>>>>>
>>>>>>>> But, when doing balloon inflation in QEMU, QEMU actually does hole
>>>>>>>> punch
>>>>>>>> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not
>>>>>>>> used.
>>>>>>>> So, when using shmem THP as memory backend QEMU inflation actually
>>>>>>>> doesn't
>>>>>>>> work as expected since it doesn't free memory.  But, the inflation
>>>>>>>> usecase really needs get the memory freed.  Anonymous THP will not
>>>>>>>> get
>>>>>>>> freed right away too but it will be freed eventually when all
>>>>>>>> subpages are
>>>>>>>> unmapped, but shmem THP would still stay in page cache.
>>>>>>>>
>>>>>>>> To protect the usecases which may prefer preserving THP, introduce
>>>>>>>> a
>>>>>>>> new fallocate mode: FALLOC_FL_SPLIT_HPAGE, which means spltting THP
>>>>>>>> is
>>>>>>>> preferred behavior if truncating partial THP.  This mode just makes
>>>>>>>> sense to tmpfs for the time being.
>> Sorry, I haven't managed to set aside enough time for this until now.
>>
>> First off, let me say that I firmly believe this punch-split behavior
>> should be the standard behavior (like in my huge tmpfs implementation),
>> and we should not need a special FALLOC_FL_SPLIT_HPAGE to do it.
>> But I don't know if I'll be able to persuade Kirill of that.
>>
>> If the caller wants to write zeroes into the file, she can do so with the
>> write syscall: the caller has asked to punch a hole or truncate the file,
>> and in our case, like your QEMU case, hopes that memory and memcg charge
>> will be freed by doing so.  I'll be surprised if changing the behavior
>> to yours and mine turns out to introduce a regression, but if it does,
>> I guess we'll then have to put it behind a sysctl or whatever.
>>
>> IIUC the reason that it's currently implemented by clearing the hole
>> is because split_huge_page() (unlike in older refcounting days) cannot
>> be guaranteed to succeed.  Which is unfortunate, and none of us is very
>> keen to build a filesystem on unreliable behavior; but the failure cases
>> appear in practice to be rare enough, that it's on balance better to give
>> the punch-hole-truncate caller what she asked for whenever possible.
> I don't have a firm position here. Maybe you are right and we should try
> to split pages right away.
>
> It might be useful to consider case wider than shmem.
>
> On traditional filesystem with a backing storage semantics of the same
> punch hole operation is somewhat different. It doesn't have explicit
> implications on memory footprint. It's about managing persistent storage.
> With shmem/tmpfs it is lumped together.
>
> It might be nice to write down pages that can be discarded under memory
> pressure and leave the huge page intact until then...

Sounds like another deferred split queue. It could be an option, but our 
usecase needs get memory freed right away since the memory might be 
reused by others very soon.

>
> [ I don't see a problem with your patch as long as we agree that it's
> desired semantics for the interface. ]
>

