Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8EF37B40A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 04:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhELCDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 22:03:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2780 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhELCDc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 22:03:32 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfydK2cnszmg9n;
        Wed, 12 May 2021 09:59:01 +0800 (CST)
Received: from [10.174.176.232] (10.174.176.232) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 10:02:16 +0800
Subject: Re: [PATCH v3 2/5] mm/huge_memory.c: use page->deferred_list
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <ziy@nvidia.com>,
        <william.kucharski@oracle.com>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <hughd@google.com>, <adobriyan@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20210511134857.1581273-1-linmiaohe@huawei.com>
 <20210511134857.1581273-3-linmiaohe@huawei.com>
 <YJsNRtg5IcMY7V/F@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b2b1f4e6-bc37-160b-5931-f64730d5ef53@huawei.com>
Date:   Wed, 12 May 2021 10:02:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YJsNRtg5IcMY7V/F@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.232]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/5/12 7:03, Matthew Wilcox wrote:
> On Tue, May 11, 2021 at 09:48:54PM +0800, Miaohe Lin wrote:
>> Now that we can represent the location of ->deferred_list instead of
>> ->mapping + ->index, make use of it to improve readability.
>>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/huge_memory.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 63ed6b25deaa..76ca1eb2a223 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2868,7 +2868,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>  	/* Take pin on all head pages to avoid freeing them under us */
>>  	list_for_each_safe(pos, next, &ds_queue->split_queue) {
>> -		page = list_entry((void *)pos, struct page, mapping);
>> +		page = list_entry((void *)pos, struct page, deferred_list);
>>  		page = compound_head(page);
> 
> This is an equivalent transformation, but it doesn't really go far
> enough.  I think you want something like this:
> 
> 	struct page *page, *next;
> 
> 	list_for_each_entry_safe(page, next, &ds_queue->split_queue,
> 							deferred_list) {
> 		struct page *head = page - 1;
> 		... then use head throughout ...
> 	}
> 

Many thanks for your time and reminder. list_for_each_entry_safe is equivalent
to list_for_each_safe + list_entry and there is many places using list_for_each_safe
+ list_entry, so I think it's ok to keep the code as it is.
Thanks again. :)

> .
> 

