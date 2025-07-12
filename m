Return-Path: <linux-fsdevel+bounces-54739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D25B028F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 04:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CE1A47B8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 02:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78CB185B73;
	Sat, 12 Jul 2025 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="av1TVmsw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F413A3F7;
	Sat, 12 Jul 2025 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752287077; cv=none; b=CZGDjiVnbFDRIQDe59h/UJW+zzaCMda2FvKMMZu3EZAHoJPng5BLvYwrMzcMIiNnKLpwboVg0jVxwZPaM+/EzTSQDPjFGf0sfpuDObxyKNNuNgxo9OhVrZmL0E7DUEaEo97NTeD3ETn3avfKMetY30iVHmJhYKy37NbfY4Xz5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752287077; c=relaxed/simple;
	bh=srwbuo6oLhtB2Y60QESeAranhfADJUl4Ui29kqh/wTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkEMUFw4G6eQMDwQln4O/Bm2E53xLsa53DmdJL8rlUYDvZWJhsBDNyKcNN6xAn0tBVTndx2H/wncsnCNkWYdxvqAtxZwf4A0B/X25DI7J5JZhG44E/g6teOE5/lCffVkmwEzOSC4/enY4iumBv8CTPv7waQTNIj34rVqBAXXlGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=av1TVmsw; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=wPO8Xs4Ept5FLbMOvFJphq0xBYZ+N64aVMADpTngs70=;
	b=av1TVmswuDHTkJHp/SrcJInub1m4E5hmHgvp110jWjOYqC51q0ighkaNVwAHce
	63yLoxXf44Q9a2P93JBZMbUZAJZJoGPd/Wa/ZqbFWm8mx3WbrCeU5LGRMAvIQY79
	D7b2KYiBl+s5CX5LmS6yWETMeMUqXaZQMdBljCoine5eY=
Received: from [10.42.12.6] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDX96Ykx3Fo9tMsEQ--.9104S2;
	Sat, 12 Jul 2025 10:23:33 +0800 (CST)
Message-ID: <661ccfa4-a5ad-4370-a7f5-e17968d8a46e@163.com>
Date: Sat, 12 Jul 2025 10:23:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] readahead: Use folio_nr_pages() instead of shift
 operation
To: David Hildenbrand <david@redhat.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chi Zhiling <chizhiling@kylinos.cn>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20250710060451.3535957-1-chizhiling@163.com>
 <479b493c-92c4-424a-a5c0-1c29a4325d15@redhat.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <479b493c-92c4-424a-a5c0-1c29a4325d15@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX96Ykx3Fo9tMsEQ--.9104S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWUurW8Ary3Gw1UJFWDJwb_yoWDWrb_WF
	40yrn29F4UWF4Sga15GFZ3GFZYgws5CryUXrWDZryIq3yrWas7Z3Z0vr1Svr1DJr1akr43
	Jwn3XFWDuF13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj3fH5UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiTxCInWhxvFTGRgAAs7

On 2025/7/12 00:15, David Hildenbrand wrote:
> On 10.07.25 08:04, Chi Zhiling wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> folio_nr_pages() is faster helper function to get the number of pages
>> when NR_PAGES_IN_LARGE_FOLIO is enabled.
>>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> ---
>>   mm/readahead.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/readahead.c b/mm/readahead.c
>> index 95a24f12d1e7..406756d34309 100644
>> --- a/mm/readahead.c
>> +++ b/mm/readahead.c
>> @@ -649,7 +649,7 @@ void page_cache_async_ra(struct readahead_control 
>> *ractl,
>>        * Ramp up sizes, and push forward the readahead window.
>>        */
>>       expected = round_down(ra->start + ra->size - ra->async_size,
>> -            1UL << folio_order(folio));
>> +            folio_nr_pages(folio));
>>       if (index == expected) {
>>           ra->start += ra->size;
>>           /*
> 
> This should probably get squashed in Ryans commit?

I have no objection, it's up to Ryan.

> 
> LGTM

Thanks,

> 


