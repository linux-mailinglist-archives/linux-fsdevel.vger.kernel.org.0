Return-Path: <linux-fsdevel+bounces-42154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43E3A3D4A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 10:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE0116D9A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2FA1EE035;
	Thu, 20 Feb 2025 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qenhCSUl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB61E9B37;
	Thu, 20 Feb 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043652; cv=none; b=VrC+un9xy6eDtgyuBwfcO4+6pafJXSlRIeKePqJuV3n37Uq8ozkODWfmk5RfYy+1Er6L9GC0KnAIyfiZqloAtTVi9yHSa1mqKiS1n93bd8h4TS+WW6x4j2bGoG7/XB8ZJAw7oa0Vyz7Xv29unTqXuCYOi/Ty5MG3oMlyo7SWiT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043652; c=relaxed/simple;
	bh=i5ItIZ6935P/3PPJ6OzXz0TbxkW9d5l893All5Hun7c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tcoYn6N1piLty2cxlsY4IMXne9YVSLbW5i+a8Qt8k2vaNSuS7KO6xAXwYxwkTSsotTHyisJUj3xP59E826PrARVIQibi4OlMdNGsQrGpSdfoOscnqepXMcZxCs/FpdUT8X+kNId9LYJLWoXJX9XOfUp6kvj4QoJI+uzrPQjAVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qenhCSUl; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740043640; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=d8JIasV6FYxBloLP1Agsk0fsHmC9VSz0DW7F8PsJKiE=;
	b=qenhCSUl5AmASUrV1mjkGgonY0xiVwgVugrkM6zZpNCIKtqEbXDftlY1XXnd+Vl1LkXmxlxwymN7XZZCCIbaz/tCBcGdGH9z8lT4cYq2uLllNsItzYWOvMV9EcZusOHOxpZS0z9BdqthBJMxgf2P4GJsxIiVVmsjxm1gvWXxEXs=
Received: from 30.74.144.124(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WPsDLQK_1740043639 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 20 Feb 2025 17:27:19 +0800
Message-ID: <2e4b9927-562d-4cfa-9362-f23e3bcfc454@linux.alibaba.com>
Date: Thu, 20 Feb 2025 17:27:19 +0800
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
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Kairui Song <kasong@tencent.com>,
 Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org
References: <20250218235444.1543173-1-ziy@nvidia.com>
 <20250218235444.1543173-3-ziy@nvidia.com>
 <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
 <AD348832-5A6A-48F1-9735-924F144330F7@nvidia.com>
 <47d189c7-3143-4b59-a3af-477d4c46a8a0@linux.alibaba.com>
In-Reply-To: <47d189c7-3143-4b59-a3af-477d4c46a8a0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/2/20 17:07, Baolin Wang wrote:
> 
> 
> On 2025/2/20 00:10, Zi Yan wrote:
>> On 19 Feb 2025, at 5:04, Baolin Wang wrote:
>>
>>> Hi Zi,
>>>
>>> Sorry for the late reply due to being busy with other things:)
>>
>> Thank you for taking a look at the patches. :)
>>
>>>
>>> On 2025/2/19 07:54, Zi Yan wrote:
>>>> During shmem_split_large_entry(), large swap entries are covering n 
>>>> slots
>>>> and an order-0 folio needs to be inserted.
>>>>
>>>> Instead of splitting all n slots, only the 1 slot covered by the folio
>>>> need to be split and the remaining n-1 shadow entries can be 
>>>> retained with
>>>> orders ranging from 0 to n-1.  This method only requires
>>>> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
>>>> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
>>>> xas_split_alloc() + xas_split() one.
>>>>
>>>> For example, to split an order-9 large swap entry (assuming 
>>>> XA_CHUNK_SHIFT
>>>> is 6), 1 xa_node is needed instead of 8.
>>>>
>>>> xas_try_split_min_order() is used to reduce the number of calls to
>>>> xas_try_split() during split.
>>>
>>> For shmem swapin, if we cannot swap in the whole large folio by 
>>> skipping the swap cache, we will split the large swap entry stored in 
>>> the shmem mapping into order-0 swap entries, rather than splitting it 
>>> into other orders of swap entries. This is because the next time we 
>>> swap in a shmem folio through shmem_swapin_cluster(), it will still 
>>> be an order 0 folio.
>>
>> Right. But the swapin is one folio at a time, right? 
>> shmem_split_large_entry()
> 
> Yes, now we always swapin an order-0 folio from the async swap device at 
> a time. However, for sync swap device, we will skip the swapcache and 
> swapin the whole large folio by commit 1dd44c0af4fa, so it will not call 
> shmem_split_large_entry() in this case.
> 
>> should split the large swap entry and give you a slot to store the 
>> order-0 folio.
>> For example, with an order-9 large swap entry, to swap in first 
>> order-0 folio,
>> the large swap entry will become order-0, order-0, order-1, order-2,… 
>> order-8,
>> after the split. Then the first order-0 swap entry can be used.
>> Then, when a second order-0 is swapped in, the second order-0 can be 
>> used.
>> When the last order-0 is swapped in, the order-8 would be split to
>> order-7,order-6,…,order-1,order-0, order-0, and the last order-0 will 
>> be used.
> 
> Yes, understood. However, for the sequential swapin scenarios, where 
> originally only one split operation is needed. However, your approach 
> increases the number of split operations. Of course, I understand that 
> in non-sequential swapin scenarios, your patch will save some xarray 
> memory. It might be necessary to evaluate whether the increased split 
> operations will have a significant impact on the performance of 
> sequential swapin?
> 
>> Maybe the swapin assumes after shmem_split_large_entry(), all swap 
>> entries
>> are order-0, which can lead to issues. There should be some check like
>> if the swap entry order > folio_order, shmem_split_large_entry() should
>> be used.
>>>
>>> Moreover I did a quick test with swapping in order 6 shmem folios, 
>>> however, my test hung, and the console was continuously filled with 
>>> the following information. It seems there are some issues with shmem 
>>> swapin handling. Anyway, I need more time to debug and test.
>> To swap in order-6 folios, shmem_split_large_entry() does not allocate
>> any new xa_node, since XA_CHUNK_SHIFT is 6. It is weird to see OOM
>> error below. Let me know if there is anything I can help.
> 
> I encountered some issues while testing order 4 and order 6 swapin with 
> your patches. And I roughly reviewed the patch, and it seems that the 
> new swap entry stored in the shmem mapping was not correctly updated 
> after the split.
> 
> The following logic is to reset the swap entry after split, and I assume 
> that the large swap entry is always split to order 0 before. As your 
> patch suggests, if a non-uniform split is used, then the logic for 
> resetting the swap entry needs to be changed? Please correct me if I 
> missed something.
> 
> /*
>   * Re-set the swap entry after splitting, and the swap
>   * offset of the original large entry must be continuous.
>   */
> for (i = 0; i < 1 << order; i++) {
>      pgoff_t aligned_index = round_down(index, 1 << order);
>      swp_entry_t tmp;
> 
>      tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
>      __xa_store(&mapping->i_pages, aligned_index + i,
>             swp_to_radix_entry(tmp), 0);
> }

In addition, after your patch, the shmem_split_large_entry() seems 
always return 0 even though it splits a large swap entry, but we still 
need re-calculate the swap entry value after splitting, otherwise it may 
return errors due to shmem_confirm_swap() validation failure.

/*
  * If the large swap entry has already been split, it is
  * necessary to recalculate the new swap entry based on
  * the old order alignment.
  */
  if (split_order > 0) {
	pgoff_t offset = index - round_down(index, 1 << split_order);

	swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
}

