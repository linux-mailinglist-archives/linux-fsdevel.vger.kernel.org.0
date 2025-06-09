Return-Path: <linux-fsdevel+bounces-50956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E268FAD167F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 03:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDED13A9A63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 01:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B217DA6D;
	Mon,  9 Jun 2025 01:19:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE72222EE5;
	Mon,  9 Jun 2025 01:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749431981; cv=none; b=ouA8qkTBaXzdM6qQGWQ39CULGOpQSyM8rNXr21XkSDgCrRW4B3zWSBeXd2GgFpe2iMnhsZr1E5j8yzQH/rqUB9v+/R8O0YSPTDNWps18rv5vXskkRIuW8SzxrxQQ5BmG8xwiQkwce+4qHXnGm41DAXueal80vvcqdWsOgNCkszw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749431981; c=relaxed/simple;
	bh=z0922ITeEhQ+sXL79XfqSZQyDuRgrP1/m7SRovdmF8s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RJx7j3JnXGkZofceo6bViM4TIwsMslmkSY0VZS+8ooLRvGL2qgL3fv2C7ZJ5aOYFN4pz/xgVkC/trG60RBNOGqWVIPtkkdXpNjJPuVb/s9BJ4H44On4XLYPapYGQUngv8C0IkLsPItOgkFOhVZDeJR0MlLRtDGfeFjLfDA+NMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bFvGW12XVzKHNdh;
	Mon,  9 Jun 2025 09:19:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7CCAC1A084E;
	Mon,  9 Jun 2025 09:19:29 +0800 (CST)
Received: from [10.174.99.169] (unknown [10.174.99.169])
	by APP2 (Coremail) with SMTP id Syh0CgC3vmGfNkZorfJIOw--.44237S2;
	Mon, 09 Jun 2025 09:19:29 +0800 (CST)
Subject: Re: [PATCH 2/7] mm: shmem: avoid setting error on splited entries in
 shmem_set_folio_swapin_error()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, hughd@google.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
 <20250605221037.7872-3-shikemeng@huaweicloud.com>
 <c05b8612-83a6-47f7-84f8-72276c08a4ac@linux.alibaba.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <100d50f3-95df-86a3-7965-357d72390193@huaweicloud.com>
Date: Mon, 9 Jun 2025 09:19:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c05b8612-83a6-47f7-84f8-72276c08a4ac@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3vmGfNkZorfJIOw--.44237S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1xJFW8uw4UCw4fuw1rJFb_yoW5ur1rpF
	4kGFZ5JFW8WrZ2kr1xJ3WUJry5Z348Xa1UJryrWa43AFsrJry0qFWUXr1vgFyUCr4xJr40
	qF4jqryDur15XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 6/7/2025 2:20 PM, Baolin Wang wrote:
> 
> 
> On 2025/6/6 06:10, Kemeng Shi wrote:
>> When large entry is splited, the first entry splited from large entry
>> retains the same entry value and index as original large entry but it's
>> order is reduced. In shmem_set_folio_swapin_error(), if large entry is
>> splited before xa_cmpxchg_irq(), we may replace the first splited entry
>> with error entry while using the size of original large entry for release
>> operations. This could lead to a WARN_ON(i_blocks) due to incorrect
>> nr_pages used by shmem_recalc_inode() and could lead to used after free
>> due to incorrect nr_pages used by swap_free_nr().
> 
> I wonder if you have actually triggered this issue? When a large swap entry is split, it means the folio is already at order 0, so why would the size of the original large entry be used for release operations? Or is there another race condition?
All issues are found during review the code of shmem as I menthioned in
cover letter.
The folio could be allocated from shmem_swap_alloc_folio() and the folio
order will keep unchange when swap entry is split.

> 
>> Skip setting error if entry spliiting is detected to fix the issue. The
>> bad entry will be replaced with error entry anyway as we will still get
>> IO error when we swap in the bad entry at next time.
>>
>> Fixes: 12885cbe88ddf ("mm: shmem: split large entry if the swapin folio is not large")
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   mm/shmem.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index e27d19867e03..f1062910a4de 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2127,16 +2127,25 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>>       struct address_space *mapping = inode->i_mapping;
>>       swp_entry_t swapin_error;
>>       void *old;
>> -    int nr_pages;
>> +    int nr_pages = folio_nr_pages(folio);
>> +    int order;
>>         swapin_error = make_poisoned_swp_entry();
>> -    old = xa_cmpxchg_irq(&mapping->i_pages, index,
>> -                 swp_to_radix_entry(swap),
>> -                 swp_to_radix_entry(swapin_error), 0);
>> -    if (old != swp_to_radix_entry(swap))
>> +    xa_lock_irq(&mapping->i_pages);
>> +    order = xa_get_order(&mapping->i_pages, index);
>> +    if (nr_pages != (1 << order)) {
>> +        xa_unlock_irq(&mapping->i_pages);
>>           return;
>> +    }
>> +    old = __xa_cmpxchg(&mapping->i_pages, index,
>> +               swp_to_radix_entry(swap),
>> +               swp_to_radix_entry(swapin_error), 0);
>> +    if (old != swp_to_radix_entry(swap)) {
>> +        xa_unlock_irq(&mapping->i_pages);
>> +        return;
>> +    }
>> +    xa_unlock_irq(&mapping->i_pages);
>>   -    nr_pages = folio_nr_pages(folio);
>>       folio_wait_writeback(folio);
>>       if (!skip_swapcache)
>>           delete_from_swap_cache(folio);
> 


