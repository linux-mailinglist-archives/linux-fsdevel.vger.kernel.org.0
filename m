Return-Path: <linux-fsdevel+bounces-51236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB1AD4CA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0863A1BC0D54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3074B2309AF;
	Wed, 11 Jun 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xiQZmBbK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFEF8479;
	Wed, 11 Jun 2025 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749626992; cv=none; b=gsQwyd8qXjgZ8p1xg1VR5DZk0lbLiIBPs2CrHx12JH/eNMVlMxdvfVGI+1IlTO0asUbFlrVjeKWSF/FV/AKr5qRCS1F47reDU4ETM0YSr1AxckXr2/oVgYu7V984D8bQHRoYUjx9kLWjDCpTky/gu+jx2baRXBF8DTbiwEOaYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749626992; c=relaxed/simple;
	bh=mYZBsJ6GYh1XewL407567u+P//gORNwjo3hShaPaf2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TubXlIFbZ337hX/jFW5Fl1wV2ZhdNuwDBcumF4vKEbSdAPYU33wYNb2cpXtrocHcEAkOLw/ScX4bbypbAiU/Uhms02RTZZahzB6AsLgUA3rUHVGzFIunm97DnTwHbOxfVair7Lcu0ov0vDBVuJOIApHUc6jZ7R3jHTqObRMwYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xiQZmBbK; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749626981; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=d1U2XgNdXb5cHFagCjGiPIir0dmxEla+OjfhqgR0jG8=;
	b=xiQZmBbKEp+ZRz9fWzIcsi4ikmg+Ju4Cx51wdYP7EYy9A8+LesQz7wk2aiErhSVU/Ex/TP1GboeQv3RGoyGmXUfx/Sua4SBfWlOzhj1d1HgZx3bzu3NytUwzDBFBm080gF/IXTAo/ENIC+fW7q5/Sa0zsamTc0fOnC5pJSszp4o=
Received: from 30.74.144.128(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdcCEnV_1749626980 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Jun 2025 15:29:40 +0800
Message-ID: <cf70cde3-b4a4-4596-aefa-a510e082e129@linux.alibaba.com>
Date: Wed, 11 Jun 2025 15:29:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] mm: shmem: correctly pass alloced parameter to
 shmem_recalc_inode() to avoid WARN_ON()
To: Kemeng Shi <shikemeng@huaweicloud.com>, hughd@google.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
 <20250605221037.7872-2-shikemeng@huaweicloud.com>
 <3d07c68f-da11-43d8-a2da-6b200b2fa40a@linux.alibaba.com>
 <994283d9-2dc4-6887-5d46-247b834879b5@huaweicloud.com>
 <9e59f1f0-db3b-2182-4485-887ac7036bfd@huaweicloud.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <9e59f1f0-db3b-2182-4485-887ac7036bfd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/6/10 09:02, Kemeng Shi wrote:
> 
> 
> on 6/9/2025 8:46 AM, Kemeng Shi wrote:
>>
>>
>> on 6/7/2025 2:11 PM, Baolin Wang wrote:
>>>
>>>
>>> On 2025/6/6 06:10, Kemeng Shi wrote:
>>>> As noted in the comments, we need to release block usage for swap entry
>>>> which was replaced with poisoned swap entry. However, no block usage is
>>>> actually freed by calling shmem_recalc_inode(inode, -nr_pages, -nr_pages).
>>>> Instead, call shmem_recalc_inode(inode, 0, -nr_pages) can correctly release
>>>> the block usage.
>>>>
>>>> Fixes: 6cec2b95dadf7 ("mm/shmem: fix infinite loop when swap in shmem error at swapoff time")
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>> ---
>>>>    mm/shmem.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index 4b42419ce6b2..e27d19867e03 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -2145,7 +2145,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>>>>         * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
>>>>         * in shmem_evict_inode().
>>>>         */
>>>> -    shmem_recalc_inode(inode, -nr_pages, -nr_pages);
>>>> +    shmem_recalc_inode(inode, 0, -nr_pages);
>>>>        swap_free_nr(swap, nr_pages);
>>>>    }
>>>
>>> Have you tested your patch? When I inject an error to test your patch, the following issue will be triggered:As all issues are hard to trigger, I only run some simple test to ensure normal
>> process is fine. Could you share how to inject the error to trigger following
>> issue. I will have a deep look. Thanks
> Sorry that the message is truncated. I mean I only test normal process is fine.

Please also test the swapin error case you try to fix. Obviously your 
current patch is incorrect.

> Besides, I think there is another long-standing issue which could trigger the
> following issue. Here is the issue which is possible to blame:
> When swap entry is replaced with error entry in shmem_set_folio_swapin_error(),
> we will reduce info->swapped. Afterwards, error entry could be deleted in
> shmem_undo_range() and the info->swapped is reduced again. As a result, we
> reduce info->swapped twice for a single swap entry.

OK. So you should do something like in shmem_find_swap_entries() to 
avoid decreasing info->swapped again.

entry = radix_to_swp_entry(folio);
/*
* swapin error entries can be found in the mapping. But they're
* deliberately ignored here as we've done everything we can do.
*/
if (swp_type(entry) != type)
	continue;

> A simple way to confirm this is injecting error to original code. Could you
> share how to trigger the issue or could you do the same test to original code?

Yes, original code is good.

A simple test procedure is to allocate some shmem memory and swap them 
out, then swap in the shmem while injecting an error to trigger the 
swap-in error case, and finally unmap the program.

