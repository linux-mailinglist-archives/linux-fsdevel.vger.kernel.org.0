Return-Path: <linux-fsdevel+bounces-42556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF84A43967
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B01F1662EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCA925B694;
	Tue, 25 Feb 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DIK3Ve0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97516257422;
	Tue, 25 Feb 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475536; cv=none; b=Wy7jAEoDhf7m/uFQJns+ad5jDirb9f6jBxfQlBeSX5MQwuq5Dp7Mm5/NhIO0mApVIHwtdNAPmXD8FIntPiK5n0sqXxQ1oPvxIW8ITlqnaNBK/d2XfKWlEtFa6Gpz/DpFpYjc78ZMEE8HBggmIJvKf6lvi/+d/76F0f3EDprAZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475536; c=relaxed/simple;
	bh=MI6J4EJ1qNZUeGGHV7eVqORjRJT9bWvPaKDjbTOIBqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbpTMk/xUaiX6ctN+w9DUIw+/0sOs4OlKZ66C7Khn+XusIvvCn6S8Z/2XFUs9suLtguFOAGLvE0VMjSVgk0d8PKPvZFLHGuWyZj3ZmvrmAgLqKjoswfs27H9McKmFrX1BeIVKdAupIUNfP5r39sLTLhr98Ag6B4MNzwKWFm/EC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DIK3Ve0j; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740475528; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kp7DHAHZqUNldKyIx09U3r22xBk4BnuCHAvUZRQ4RvQ=;
	b=DIK3Ve0jn0vcP5nObMq+zDR9nSz7QAUY4L2bjElHhOLWjl1Hmhz2T+dBHTVXY6lD6b2WcE//GSz0k5j2i6FoeSzn1EZHdtQKLl1hdkZ14BQ8LTl1M0TXB1c9cS7cYWBXTeGnuZ6gSufUZPX+m2M4j3Sali8C1GxZS1rVXohBLbk=
Received: from 30.74.144.116(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQEGWYx_1740475527 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 17:25:27 +0800
Message-ID: <ec0d6ec4-6295-46f5-a652-e294738c8c56@linux.alibaba.com>
Date: Tue, 25 Feb 2025 17:25:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
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
 <edd6e5fd-f6d1-420c-a895-2dae5fe746ef@linux.alibaba.com>
 <7090090D-4E74-4A6B-9B09-D2045AD616F0@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <7090090D-4E74-4A6B-9B09-D2045AD616F0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/2/22 07:47, Zi Yan wrote:
> On 21 Feb 2025, at 1:17, Baolin Wang wrote:
> 
>> On 2025/2/21 10:38, Zi Yan wrote:
>>> On 20 Feb 2025, at 21:33, Zi Yan wrote:
>>>
>>>> On 20 Feb 2025, at 8:06, Zi Yan wrote:
>>>>
>>>>> On 20 Feb 2025, at 4:27, Baolin Wang wrote:
>>>>>
>>>>>> On 2025/2/20 17:07, Baolin Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2025/2/20 00:10, Zi Yan wrote:
>>>>>>>> On 19 Feb 2025, at 5:04, Baolin Wang wrote:
>>>>>>>>
>>>>>>>>> Hi Zi,
>>>>>>>>>
>>>>>>>>> Sorry for the late reply due to being busy with other things:)
>>>>>>>>
>>>>>>>> Thank you for taking a look at the patches. :)
>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2025/2/19 07:54, Zi Yan wrote:
>>>>>>>>>> During shmem_split_large_entry(), large swap entries are covering n slots
>>>>>>>>>> and an order-0 folio needs to be inserted.
>>>>>>>>>>
>>>>>>>>>> Instead of splitting all n slots, only the 1 slot covered by the folio
>>>>>>>>>> need to be split and the remaining n-1 shadow entries can be retained with
>>>>>>>>>> orders ranging from 0 to n-1.  This method only requires
>>>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
>>>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
>>>>>>>>>> xas_split_alloc() + xas_split() one.
>>>>>>>>>>
>>>>>>>>>> For example, to split an order-9 large swap entry (assuming XA_CHUNK_SHIFT
>>>>>>>>>> is 6), 1 xa_node is needed instead of 8.
>>>>>>>>>>
>>>>>>>>>> xas_try_split_min_order() is used to reduce the number of calls to
>>>>>>>>>> xas_try_split() during split.
>>>>>>>>>
>>>>>>>>> For shmem swapin, if we cannot swap in the whole large folio by skipping the swap cache, we will split the large swap entry stored in the shmem mapping into order-0 swap entries, rather than splitting it into other orders of swap entries. This is because the next time we swap in a shmem folio through shmem_swapin_cluster(), it will still be an order 0 folio.
>>>>>>>>
>>>>>>>> Right. But the swapin is one folio at a time, right? shmem_split_large_entry()
>>>>>>>
>>>>>>> Yes, now we always swapin an order-0 folio from the async swap device at a time. However, for sync swap device, we will skip the swapcache and swapin the whole large folio by commit 1dd44c0af4fa, so it will not call shmem_split_large_entry() in this case.
>>>>>
>>>>> Got it. I will check the commit.
>>>>>
>>>>>>>
>>>>>>>> should split the large swap entry and give you a slot to store the order-0 folio.
>>>>>>>> For example, with an order-9 large swap entry, to swap in first order-0 folio,
>>>>>>>> the large swap entry will become order-0, order-0, order-1, order-2,… order-8,
>>>>>>>> after the split. Then the first order-0 swap entry can be used.
>>>>>>>> Then, when a second order-0 is swapped in, the second order-0 can be used.
>>>>>>>> When the last order-0 is swapped in, the order-8 would be split to
>>>>>>>> order-7,order-6,…,order-1,order-0, order-0, and the last order-0 will be used.
>>>>>>>
>>>>>>> Yes, understood. However, for the sequential swapin scenarios, where originally only one split operation is needed. However, your approach increases the number of split operations. Of course, I understand that in non-sequential swapin scenarios, your patch will save some xarray memory. It might be necessary to evaluate whether the increased split operations will have a significant impact on the performance of sequential swapin?
>>>>>
>>>>> Is there a shmem swapin test I can run to measure this? xas_try_split() should
>>>>> performance similar operations as existing xas_split_alloc()+xas_split().
>>
>> I think a simple sequential swapin case is enough? Anyway I can help to evaluate the performance impact with your new patch.
>>
>>>>>>>> Maybe the swapin assumes after shmem_split_large_entry(), all swap entries
>>>>>>>> are order-0, which can lead to issues. There should be some check like
>>>>>>>> if the swap entry order > folio_order, shmem_split_large_entry() should
>>>>>>>> be used.
>>>>>>>>>
>>>>>>>>> Moreover I did a quick test with swapping in order 6 shmem folios, however, my test hung, and the console was continuously filled with the following information. It seems there are some issues with shmem swapin handling. Anyway, I need more time to debug and test.
>>>>>>>> To swap in order-6 folios, shmem_split_large_entry() does not allocate
>>>>>>>> any new xa_node, since XA_CHUNK_SHIFT is 6. It is weird to see OOM
>>>>>>>> error below. Let me know if there is anything I can help.
>>>>>>>
>>>>>>> I encountered some issues while testing order 4 and order 6 swapin with your patches. And I roughly reviewed the patch, and it seems that the new swap entry stored in the shmem mapping was not correctly updated after the split.
>>>>>>>
>>>>>>> The following logic is to reset the swap entry after split, and I assume that the large swap entry is always split to order 0 before. As your patch suggests, if a non-uniform split is used, then the logic for resetting the swap entry needs to be changed? Please correct me if I missed something.
>>>>>>>
>>>>>>> /*
>>>>>>>     * Re-set the swap entry after splitting, and the swap
>>>>>>>     * offset of the original large entry must be continuous.
>>>>>>>     */
>>>>>>> for (i = 0; i < 1 << order; i++) {
>>>>>>>        pgoff_t aligned_index = round_down(index, 1 << order);
>>>>>>>        swp_entry_t tmp;
>>>>>>>
>>>>>>>        tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
>>>>>>>        __xa_store(&mapping->i_pages, aligned_index + i,
>>>>>>>               swp_to_radix_entry(tmp), 0);
>>>>>>> }
>>>>>
>>>>> Right. I will need to adjust swp_entry_t. Thanks for pointing this out.
>>>>>
>>>>>>
>>>>>> In addition, after your patch, the shmem_split_large_entry() seems always return 0 even though it splits a large swap entry, but we still need re-calculate the swap entry value after splitting, otherwise it may return errors due to shmem_confirm_swap() validation failure.
>>>>>>
>>>>>> /*
>>>>>>    * If the large swap entry has already been split, it is
>>>>>>    * necessary to recalculate the new swap entry based on
>>>>>>    * the old order alignment.
>>>>>>    */
>>>>>>    if (split_order > 0) {
>>>>>> 	pgoff_t offset = index - round_down(index, 1 << split_order);
>>>>>>
>>>>>> 	swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
>>>>>> }
>>>>>
>>>>> Got it. I will fix it.
>>>>>
>>>>> BTW, do you mind sharing your swapin tests so that I can test my new version
>>>>> properly?
>>>>
>>>> The diff below adjusts the swp_entry_t and returns the right order after
>>>> shmem_split_large_entry(). Let me know if it fixes your issue.
>>>
>>> Fixed the compilation error. It will be great if you can share a swapin test, so that
>>> I can test locally. Thanks.
>>
>> Sure. I've attached 3 test shmem swapin cases to see if they can help you with testing. I will also find time next week to review and test your patch.
>>
>> Additionally, you can use zram as a swap device and disable the skipping swapcache feature to test the split logic quickly:
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 745f130bfb4c..7374d5c1cdde 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2274,7 +2274,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>          folio = swap_cache_get_folio(swap, NULL, 0);
>>          if (!folio) {
>>                  int order = xa_get_order(&mapping->i_pages, index);
>> -               bool fallback_order0 = false;
>> +               bool fallback_order0 = true;
>>                  int split_order;
>>
>>                  /* Or update major stats only when swapin succeeds?? */
> 
> Thank you for the testing programs and the patch above. With zswap enabled,
> I do not see any crash. I also tried to mount a tmpfs, dd a file that
> is larger than total memory, and read the file out. The system crashed
> with my original patch but no longer crashes with my fix.
> 
> In terms of performance, I used your shmem_aligned_swapin.c and increased
> the shmem size from 1GB to 10GB and measured the time of memset at the
> end, which swaps in memory and triggers split large entry. I see no difference
> between with and without my patch.

OK. Great.

> I will wait for your results to confirm my fix. Really appreciate your help.

You are welcome:) and I commented your fixes.

> BTW, without zswap, it seems that madvise(MADV_PAGEOUT) does not write
> shmem to swapfile and during swapin, swap_cache_get_folio() always gets
> a folio. I wonder what is the difference between zswap and a swapfile.

Right, IIUC swapfile is not a sync swap device. You can set up zram as a 
swap device, which is a sync swap device:

modprobe -v zram
# setup 20G swap
echo 20G > /sys/block/zram0/disksize
mkswap /dev/zram0
swapon /dev/zram0
swapon -s

