Return-Path: <linux-fsdevel+bounces-51554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C405AD8368
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 08:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D492A3A0452
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 06:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B41925A351;
	Fri, 13 Jun 2025 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="waiDbM15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C92580D1;
	Fri, 13 Jun 2025 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749797806; cv=none; b=IhD2QPUmHNgpALJ9oNlBMkPGk8l5SC3fy+UYkLBye6y/8KEd//bcaPsLIlv006oy+ZYZyzx8zV5IhVRLjQIdf1k15gdddUBo9ef3cISh5xJtIq8BL0U59jxb5wogY7xSx0pkOuDrEKxSdjfGSPRf57QQUWf0+XVHDIHcBTe2vmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749797806; c=relaxed/simple;
	bh=GhfW6OpDp15omdr3afmq7V7jrbBZ4rWNSl+jEHnADD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GV8tG29QjdpimYwrc5IkP1tJKgLHAtjWQZnjr4lLvbnisTveMZDk1bzf5JTRconeXZi6H9QSTmSkBoZPFpFMHsDRyxe6h6GALGS78DHBLZOb0WdclNn/FJZCkY+sh5GwAA3GAWBrnoT3YBrwimYyWAhGA0DSX8mtL8lEWRcVSXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=waiDbM15; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749797793; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=st0G/jtNnigkjTuEzRjxuWPi77i46Gqsx9W7ef09lV8=;
	b=waiDbM15+Wy8c1gwRMSYuKT98bBtpQrqrhyZnm5TwpXHKCbiFMpWemLubcxsGtEnerfWF5POSvg38vhbmykS0r/6kzIGFdKtDYj31UX6DIwrQVrvKqx8GdrVB42q2dJ9T0J75SNoN7YWaLjOuF7zQ2n9j6Lz/oO4fX7T8BlbEz0=
Received: from 30.74.144.147(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdjYqSs_1749797792 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Jun 2025 14:56:33 +0800
Message-ID: <78c027ff-20f3-4678-9fd5-1884c9583fb1@linux.alibaba.com>
Date: Fri, 13 Jun 2025 14:56:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm: shmem: avoid setting error on splited entries in
 shmem_set_folio_swapin_error()
To: Kemeng Shi <shikemeng@huaweicloud.com>, hughd@google.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
 <20250605221037.7872-3-shikemeng@huaweicloud.com>
 <c05b8612-83a6-47f7-84f8-72276c08a4ac@linux.alibaba.com>
 <100d50f3-95df-86a3-7965-357d72390193@huaweicloud.com>
 <24580f79-c104-41aa-bbdb-e1ce120c28a0@linux.alibaba.com>
 <93336040-f457-d8a1-29df-f737efa8261c@huaweicloud.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <93336040-f457-d8a1-29df-f737efa8261c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/11 17:11, Kemeng Shi wrote:
> 
> 
> on 6/11/2025 3:41 PM, Baolin Wang wrote:
>>
>>
>> On 2025/6/9 09:19, Kemeng Shi wrote:
>>>
>>>
>>> on 6/7/2025 2:20 PM, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2025/6/6 06:10, Kemeng Shi wrote:
>>>>> When large entry is splited, the first entry splited from large entry
>>>>> retains the same entry value and index as original large entry but it's
>>>>> order is reduced. In shmem_set_folio_swapin_error(), if large entry is
>>>>> splited before xa_cmpxchg_irq(), we may replace the first splited entry
>>>>> with error entry while using the size of original large entry for release
>>>>> operations. This could lead to a WARN_ON(i_blocks) due to incorrect
>>>>> nr_pages used by shmem_recalc_inode() and could lead to used after free
>>>>> due to incorrect nr_pages used by swap_free_nr().
>>>>
>>>> I wonder if you have actually triggered this issue? When a large swap entry is split, it means the folio is already at order 0, so why would the size of the original large entry be used for release operations? Or is there another race condition?
>>> All issues are found during review the code of shmem as I menthioned in
>>> cover letter.
>>> The folio could be allocated from shmem_swap_alloc_folio() and the folio
>>> order will keep unchange when swap entry is split.
>>
>> Sorry, I did not get your point. If a large swap entry is split, we must ensure that the corresponding folio is order 0.
>>
>> However, I missed one potential case which was recently fixed by Kairui[1].
>>
>> [1] https://lore.kernel.org/all/20250610181645.45922-1-ryncsn@gmail.com/
>>
> Here is a possible code routine which I think could trigger the issue:
> shmem_swapin_folio          shmem_swapin_folio
> folio = swap_cache_get_folio()
> order = xa_get_order(&mapping->i_pages, index);
> if (!folio)
>   ...
>   /* suppose large folio allocation is failed, we will try to split large entry */
>   folio = shmem_swap_alloc_folio(..., order, ...)
> 
>                              folio = swap_cache_get_folio()
>                              order = xa_get_order(&mapping->i_pages, index);
>                              if (!folio)
>                               ...
>                               /* suppose large folio allocation is successful this time */
>                               folio = shmem_swap_alloc_folio(..., order, ...)
>                              ...
>                              /* suppose IO of large folio is failed, will set swapin error later */
>                              if (!folio_test_uptodate(folio)) {
>                               error = -EIO;
>                               goto failed:
>                              }
> 
>   ...
>   shmem_split_large_entry()
> 
>                              ...
>                              shmem_set_folio_swapin_error(..., folio, ...)

OK. I think this is a good example of a potiential race condition. 
Please include this information in the commit message to make it easier 
for others to understand. Thanks.

I will find some time to test your patch.

