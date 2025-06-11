Return-Path: <linux-fsdevel+bounces-51261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6235AAD4E99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1BE17AFF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560123F412;
	Wed, 11 Jun 2025 08:38:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2191B23E359;
	Wed, 11 Jun 2025 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631114; cv=none; b=LSeGNaZUoS7p+Ww7X+wZ8q2Yxbkd3mnuLg6Vsllki7YmfTWgjfZ1TEhTjsJISK3X6jV5OdWCzLmN/1gLUvvETslkHwx/d85Nz2eF5joSjnbLqwREPV8YTrxD0uihXVxcDwp9pIyWvZV/7ECyZasdfqX6b5ThyiEzclJi+XmKqWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631114; c=relaxed/simple;
	bh=aHulynXRVVHWpUyUXomIsK4Ep2mEimLnrKrGIEb43Rk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IpntorObZGYSFdnbIR94x+5IE7j8ouJ9sRXC+gbucb4hAPoJcA0BBPGtXbWdb8NxMcnjl7anmCs5mBhIBoICmdNIzVgtYe2D6sjL7f9rX/BVyeewEP/+CTmmzaVDjQU7T2vhDafjD8B29QH+jVTJfXKBtEsBVBebaL2l0uF/jaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bHJw52mcJzYQvTS;
	Wed, 11 Jun 2025 16:38:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5DDFD1A0A6C;
	Wed, 11 Jun 2025 16:38:28 +0800 (CST)
Received: from [10.174.99.169] (unknown [10.174.99.169])
	by APP2 (Coremail) with SMTP id Syh0CgCXoGOCQEloTNk1PA--.4547S2;
	Wed, 11 Jun 2025 16:38:28 +0800 (CST)
Subject: Re: [PATCH 1/7] mm: shmem: correctly pass alloced parameter to
 shmem_recalc_inode() to avoid WARN_ON()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, hughd@google.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
 <20250605221037.7872-2-shikemeng@huaweicloud.com>
 <3d07c68f-da11-43d8-a2da-6b200b2fa40a@linux.alibaba.com>
 <994283d9-2dc4-6887-5d46-247b834879b5@huaweicloud.com>
 <9e59f1f0-db3b-2182-4485-887ac7036bfd@huaweicloud.com>
 <cf70cde3-b4a4-4596-aefa-a510e082e129@linux.alibaba.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <1ded199d-149f-d64c-536d-21ce158a09d6@huaweicloud.com>
Date: Wed, 11 Jun 2025 16:38:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cf70cde3-b4a4-4596-aefa-a510e082e129@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXoGOCQEloTNk1PA--.4547S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryfuFyxur1xtryxZw4fXwb_yoW5try5pr
	W8Gas0yFZ8Jry0yFn2qF18Z3yaq3yrJa1UXrW5CFyxCan0qr1SgrWUKrWj9ryUCrWkGw4j
	qF47K3srZryUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFB
	T5DUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 6/11/2025 3:29 PM, Baolin Wang wrote:
> 
> 
> On 2025/6/10 09:02, Kemeng Shi wrote:
>>
>>
>> on 6/9/2025 8:46 AM, Kemeng Shi wrote:
>>>
>>>
>>> on 6/7/2025 2:11 PM, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2025/6/6 06:10, Kemeng Shi wrote:
>>>>> As noted in the comments, we need to release block usage for swap entry
>>>>> which was replaced with poisoned swap entry. However, no block usage is
>>>>> actually freed by calling shmem_recalc_inode(inode, -nr_pages, -nr_pages).
>>>>> Instead, call shmem_recalc_inode(inode, 0, -nr_pages) can correctly release
>>>>> the block usage.
>>>>>
>>>>> Fixes: 6cec2b95dadf7 ("mm/shmem: fix infinite loop when swap in shmem error at swapoff time")
>>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>>> ---
>>>>>    mm/shmem.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>> index 4b42419ce6b2..e27d19867e03 100644
>>>>> --- a/mm/shmem.c
>>>>> +++ b/mm/shmem.c
>>>>> @@ -2145,7 +2145,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>>>>>         * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
>>>>>         * in shmem_evict_inode().
>>>>>         */
>>>>> -    shmem_recalc_inode(inode, -nr_pages, -nr_pages);
>>>>> +    shmem_recalc_inode(inode, 0, -nr_pages);
>>>>>        swap_free_nr(swap, nr_pages);
>>>>>    }
>>>>
>>>> Have you tested your patch? When I inject an error to test your patch, the following issue will be triggered:As all issues are hard to trigger, I only run some simple test to ensure normal
>>> process is fine. Could you share how to inject the error to trigger following
>>> issue. I will have a deep look. Thanks
>> Sorry that the message is truncated. I mean I only test normal process is fine.
> 
> Please also test the swapin error case you try to fix. Obviously your current patch is incorrect.
> 
>> Besides, I think there is another long-standing issue which could trigger the
>> following issue. Here is the issue which is possible to blame:
>> When swap entry is replaced with error entry in shmem_set_folio_swapin_error(),
>> we will reduce info->swapped. Afterwards, error entry could be deleted in
>> shmem_undo_range() and the info->swapped is reduced again. As a result, we
>> reduce info->swapped twice for a single swap entry.
> 
> OK. So you should do something like in shmem_find_swap_entries() to avoid decreasing info->swapped again.
> 
> entry = radix_to_swp_entry(folio);
> /*
> * swapin error entries can be found in the mapping. But they're
> * deliberately ignored here as we've done everything we can do.
> */
> if (swp_type(entry) != type)
>     continue;
> 
>> A simple way to confirm this is injecting error to original code. Could you
>> share how to trigger the issue or could you do the same test to original code?
> 
> Yes, original code is good.
I still suspect that it's another long-standing issue which is triggerd by
this by accident.
> 
> A simple test procedure is to allocate some shmem memory and swap them out, then swap in the shmem while injecting an error to trigger the swap-in error case, and finally unmap the program.
> 
Sure, will fix the mentiond long-standing issue first and try to run this
test.
I will appreciate if you can share your test code if it's convenient.

Thanks


