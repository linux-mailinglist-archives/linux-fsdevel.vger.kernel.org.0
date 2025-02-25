Return-Path: <linux-fsdevel+bounces-42558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658BEA43B30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EE416640A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD52264A96;
	Tue, 25 Feb 2025 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SxPhmuMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E506118CC1C;
	Tue, 25 Feb 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478556; cv=none; b=Has9zV7HepeZIbDotD6NDMsQW6yTR8VAx8q1L/idYx4bavdS5OPIfkjw8AwEp8ao8Bb/dJCjUns4fTsykmLyG13YDhxJ9lbPnjBX1DjTlVhbNA4ZFlwEUh8pkLvusKm6JIYFQl8A3PAaALIG9UK4IdqhEcEAt7Pl8GlkVEy0HX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478556; c=relaxed/simple;
	bh=Zo0opcPKGQ/pu9FzDTV+Lkxg6BFsS3+OMq13Rm4Lons=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KSi+gs1zNsu6uUQH6CKgBZZnXe0Kn2oVdMK+e2eEQa7JIseb787pDU2MsYpIw2jKi78Wr3I5JsdeDtdUIUjDuY0ueFDJHK4KPIjwk/FmW4e7Ig6PlCLXAPu8/hxPylBVg/n6yAdjCDL99XbRzxZUCsH1IaO2nq8dzuMqw3gmHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SxPhmuMb; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740478549; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=G1//MzoBhkItqh36YQVUEyzPgpeaLo06j7nacJ5WR2A=;
	b=SxPhmuMbpdm03d0p7oT5Q9as3ev8gZYumVSVOXaSzm3UXMqzXC95R4KSnb3mWLHw4+KINEc1v20JB45F9S7ZajAD/by6/eOKVk49ByBNAS/wC1CDy3u7HMIUlhC4LStbUFjBBbAPH6Jl/fKvLgJ1zslgz7XbqxIRjF5v5DtFg+w=
Received: from 30.74.144.116(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQEMMgT_1740478548 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 18:15:48 +0800
Message-ID: <af6122b4-2324-418b-b925-becf6036d9ab@linux.alibaba.com>
Date: Tue, 25 Feb 2025 18:15:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20250218235444.1543173-1-ziy@nvidia.com>
 <20250218235444.1543173-3-ziy@nvidia.com>
 <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
 <AD348832-5A6A-48F1-9735-924F144330F7@nvidia.com>
 <47d189c7-3143-4b59-a3af-477d4c46a8a0@linux.alibaba.com>
 <2e4b9927-562d-4cfa-9362-f23e3bcfc454@linux.alibaba.com>
 <42440332-96FF-4ECB-8553-9472125EB33F@nvidia.com>
 <37C4B6AC-0757-4B92-88F3-75F1B4DEFFC5@nvidia.com>
 <655589D4-7E13-4F5B-8968-3FCB71DCE0FC@nvidia.com>
 <bd30dc5e-880c-4daf-a86b-b814a1533931@linux.alibaba.com>
In-Reply-To: <bd30dc5e-880c-4daf-a86b-b814a1533931@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/2/25 17:20, Baolin Wang wrote:
> 
> 
> On 2025/2/21 10:38, Zi Yan wrote:
>> On 20 Feb 2025, at 21:33, Zi Yan wrote:
>>
>>> On 20 Feb 2025, at 8:06, Zi Yan wrote:
>>>
>>>> On 20 Feb 2025, at 4:27, Baolin Wang wrote:
>>>>
>>>>> On 2025/2/20 17:07, Baolin Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 2025/2/20 00:10, Zi Yan wrote:
>>>>>>> On 19 Feb 2025, at 5:04, Baolin Wang wrote:
>>>>>>>
>>>>>>>> Hi Zi,
>>>>>>>>
>>>>>>>> Sorry for the late reply due to being busy with other things:)
>>>>>>>
>>>>>>> Thank you for taking a look at the patches. :)
>>>>>>>
>>>>>>>>
>>>>>>>> On 2025/2/19 07:54, Zi Yan wrote:
>>>>>>>>> During shmem_split_large_entry(), large swap entries are 
>>>>>>>>> covering n slots
>>>>>>>>> and an order-0 folio needs to be inserted.
>>>>>>>>>
>>>>>>>>> Instead of splitting all n slots, only the 1 slot covered by 
>>>>>>>>> the folio
>>>>>>>>> need to be split and the remaining n-1 shadow entries can be 
>>>>>>>>> retained with
>>>>>>>>> orders ranging from 0 to n-1.  This method only requires
>>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
>>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
>>>>>>>>> xas_split_alloc() + xas_split() one.
>>>>>>>>>
>>>>>>>>> For example, to split an order-9 large swap entry (assuming 
>>>>>>>>> XA_CHUNK_SHIFT
>>>>>>>>> is 6), 1 xa_node is needed instead of 8.
>>>>>>>>>
>>>>>>>>> xas_try_split_min_order() is used to reduce the number of calls to
>>>>>>>>> xas_try_split() during split.
>>>>>>>>
>>>>>>>> For shmem swapin, if we cannot swap in the whole large folio by 
>>>>>>>> skipping the swap cache, we will split the large swap entry 
>>>>>>>> stored in the shmem mapping into order-0 swap entries, rather 
>>>>>>>> than splitting it into other orders of swap entries. This is 
>>>>>>>> because the next time we swap in a shmem folio through 
>>>>>>>> shmem_swapin_cluster(), it will still be an order 0 folio.
>>>>>>>
>>>>>>> Right. But the swapin is one folio at a time, right? 
>>>>>>> shmem_split_large_entry()
>>>>>>
>>>>>> Yes, now we always swapin an order-0 folio from the async swap 
>>>>>> device at a time. However, for sync swap device, we will skip the 
>>>>>> swapcache and swapin the whole large folio by commit 1dd44c0af4fa, 
>>>>>> so it will not call shmem_split_large_entry() in this case.
>>>>
>>>> Got it. I will check the commit.
>>>>
>>>>>>
>>>>>>> should split the large swap entry and give you a slot to store 
>>>>>>> the order-0 folio.
>>>>>>> For example, with an order-9 large swap entry, to swap in first 
>>>>>>> order-0 folio,
>>>>>>> the large swap entry will become order-0, order-0, order-1, 
>>>>>>> order-2,… order-8,
>>>>>>> after the split. Then the first order-0 swap entry can be used.
>>>>>>> Then, when a second order-0 is swapped in, the second order-0 can 
>>>>>>> be used.
>>>>>>> When the last order-0 is swapped in, the order-8 would be split to
>>>>>>> order-7,order-6,…,order-1,order-0, order-0, and the last order-0 
>>>>>>> will be used.
>>>>>>
>>>>>> Yes, understood. However, for the sequential swapin scenarios, 
>>>>>> where originally only one split operation is needed. However, your 
>>>>>> approach increases the number of split operations. Of course, I 
>>>>>> understand that in non-sequential swapin scenarios, your patch 
>>>>>> will save some xarray memory. It might be necessary to evaluate 
>>>>>> whether the increased split operations will have a significant 
>>>>>> impact on the performance of sequential swapin?
>>>>
>>>> Is there a shmem swapin test I can run to measure this? 
>>>> xas_try_split() should
>>>> performance similar operations as existing 
>>>> xas_split_alloc()+xas_split().
>>>>
>>>>>>
>>>>>>> Maybe the swapin assumes after shmem_split_large_entry(), all 
>>>>>>> swap entries
>>>>>>> are order-0, which can lead to issues. There should be some check 
>>>>>>> like
>>>>>>> if the swap entry order > folio_order, shmem_split_large_entry() 
>>>>>>> should
>>>>>>> be used.
>>>>>>>>
>>>>>>>> Moreover I did a quick test with swapping in order 6 shmem 
>>>>>>>> folios, however, my test hung, and the console was continuously 
>>>>>>>> filled with the following information. It seems there are some 
>>>>>>>> issues with shmem swapin handling. Anyway, I need more time to 
>>>>>>>> debug and test.
>>>>>>> To swap in order-6 folios, shmem_split_large_entry() does not 
>>>>>>> allocate
>>>>>>> any new xa_node, since XA_CHUNK_SHIFT is 6. It is weird to see OOM
>>>>>>> error below. Let me know if there is anything I can help.
>>>>>>
>>>>>> I encountered some issues while testing order 4 and order 6 swapin 
>>>>>> with your patches. And I roughly reviewed the patch, and it seems 
>>>>>> that the new swap entry stored in the shmem mapping was not 
>>>>>> correctly updated after the split.
>>>>>>
>>>>>> The following logic is to reset the swap entry after split, and I 
>>>>>> assume that the large swap entry is always split to order 0 
>>>>>> before. As your patch suggests, if a non-uniform split is used, 
>>>>>> then the logic for resetting the swap entry needs to be changed? 
>>>>>> Please correct me if I missed something.
>>>>>>
>>>>>> /*
>>>>>>    * Re-set the swap entry after splitting, and the swap
>>>>>>    * offset of the original large entry must be continuous.
>>>>>>    */
>>>>>> for (i = 0; i < 1 << order; i++) {
>>>>>>       pgoff_t aligned_index = round_down(index, 1 << order);
>>>>>>       swp_entry_t tmp;
>>>>>>
>>>>>>       tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
>>>>>>       __xa_store(&mapping->i_pages, aligned_index + i,
>>>>>>              swp_to_radix_entry(tmp), 0);
>>>>>> }
>>>>
>>>> Right. I will need to adjust swp_entry_t. Thanks for pointing this out.
>>>>
>>>>>
>>>>> In addition, after your patch, the shmem_split_large_entry() seems 
>>>>> always return 0 even though it splits a large swap entry, but we 
>>>>> still need re-calculate the swap entry value after splitting, 
>>>>> otherwise it may return errors due to shmem_confirm_swap() 
>>>>> validation failure.
>>>>>
>>>>> /*
>>>>>   * If the large swap entry has already been split, it is
>>>>>   * necessary to recalculate the new swap entry based on
>>>>>   * the old order alignment.
>>>>>   */
>>>>>   if (split_order > 0) {
>>>>>     pgoff_t offset = index - round_down(index, 1 << split_order);
>>>>>
>>>>>     swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
>>>>> }
>>>>
>>>> Got it. I will fix it.
>>>>
>>>> BTW, do you mind sharing your swapin tests so that I can test my new 
>>>> version
>>>> properly?
>>>
>>> The diff below adjusts the swp_entry_t and returns the right order after
>>> shmem_split_large_entry(). Let me know if it fixes your issue.
>>
>> Fixed the compilation error. It will be great if you can share a 
>> swapin test, so that
>> I can test locally. Thanks.
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index b35ba250c53d..bfc4ef511391 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2162,7 +2162,7 @@ static int shmem_split_large_entry(struct inode 
>> *inode, pgoff_t index,
>>   {
>>       struct address_space *mapping = inode->i_mapping;
>>       XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
>> -    int split_order = 0;
>> +    int split_order = 0, entry_order = 0;
>>       int i;
>>
>>       /* Convert user data gfp flags to xarray node gfp flags */
>> @@ -2180,6 +2180,7 @@ static int shmem_split_large_entry(struct inode 
>> *inode, pgoff_t index,
>>           }
>>
>>           order = xas_get_order(&xas);
>> +        entry_order = order;
>>
>>           /* Try to split large swap entry in pagecache */
>>           if (order > 0) {
>> @@ -2192,23 +2193,23 @@ static int shmem_split_large_entry(struct 
>> inode *inode, pgoff_t index,
>>                   xas_try_split(&xas, old, cur_order, GFP_NOWAIT);
>>                   if (xas_error(&xas))
>>                       goto unlock;
>> +
>> +                /*
>> +                 * Re-set the swap entry after splitting, and the swap
>> +                 * offset of the original large entry must be 
>> continuous.
>> +                 */
>> +                for (i = 0; i < 1 << cur_order; i += (1 << 
>> split_order)) {
>> +                    pgoff_t aligned_index = round_down(index, 1 << 
>> cur_order);
>> +                    swp_entry_t tmp;
>> +
>> +                    tmp = swp_entry(swp_type(swap), swp_offset(swap) 
>> + i);
>> +                    __xa_store(&mapping->i_pages, aligned_index + i,
>> +                           swp_to_radix_entry(tmp), 0);
>> +                }
>>                   cur_order = split_order;
>>                   split_order =
>>                       xas_try_split_min_order(split_order);
>>               }
> 
> This looks incorrect to me. Suppose we are splitting an order-9 swap 
> entry, in the first iteration of the loop, it splits the order-9 swap 
> entry into 8 order-6 swap entries. At this point, the order-6 swap 
> entries are reset, and everything seems fine.
> 
> However, in the second iteration, where an order-6 swap entry is split 
> into 63 order-0 swap entries, the split operation itself is correct. But 

typo: 64

> when resetting the order-0 swap entry, it seems incorrect. Now the 
> 'cur_order' = 6 and 'split_order' = 0, which means the range for the 
> reset index is always between 0 and 63 (see __xa_store()).

Sorry for confusing. The 'aligned_index' will be rounded down by 
'cur_order' (which is 6), so the index is correct. But the swap offset 
calculated by 'swp_offset(swap) + i' looks incorrect, cause the 'i' is 
always between 0 and 63.

>  > +for (i = 0; i < 1 << cur_order; i += (1 << split_order)) {
>  > +    pgoff_t aligned_index = round_down(index, 1 << cur_order);
>  > +    swp_entry_t tmp;
>  > +
>  > +    tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
>  > +    __xa_store(&mapping->i_pages, aligned_index + i,
>  > +        swp_to_radix_entry(tmp), 0);
>  > +}
> 
> However, if the index is greater than 63, it appears that it is not set 
> to the correct new swap entry after splitting. Please corect me if I 
> missed anyting.
> 
>> -
>> -            /*
>> -             * Re-set the swap entry after splitting, and the swap
>> -             * offset of the original large entry must be continuous.
>> -             */
>> -            for (i = 0; i < 1 << order; i++) {
>> -                pgoff_t aligned_index = round_down(index, 1 << order);
>> -                swp_entry_t tmp;
>> -
>> -                tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
>> -                __xa_store(&mapping->i_pages, aligned_index + i,
>> -                       swp_to_radix_entry(tmp), 0);
>> -            }
>>           }
>>
>>   unlock:
>> @@ -2221,7 +2222,7 @@ static int shmem_split_large_entry(struct inode 
>> *inode, pgoff_t index,
>>       if (xas_error(&xas))
>>           return xas_error(&xas);
>>
>> -    return split_order;
>> +    return entry_order;
>>   }
>>
>>   /*
>>
>>
>> Best Regards,
>> Yan, Zi

