Return-Path: <linux-fsdevel+bounces-60235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D07B42F53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 04:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616B43B2832
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC40813A3ED;
	Thu,  4 Sep 2025 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PBoO7+D9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72AE2566
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 02:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951504; cv=none; b=F/367SrzNGQ9xyh9HIpE3GUmMngek0eTFKqxRh2TT/jsE9sTsSjclRTs/nSfltmiqrlGqgxDS3rLoyQdmpk6LxwD+h3dPJ/Y5YknihH2ebTPLxc5RI+q7nATFI5Psta5ayH8YAav/LZncvYWWy8BslX9OPrMu1PCPEocRQqVaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951504; c=relaxed/simple;
	bh=HbQafQYrWlv/PtTeHwbKKjSuKAWqhrHtEM6EpL8Vb3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BerUfXNEQMSr/cmtmCP8Qp2MWJ82o25Xb4rtbhYGo/FTNszlDqRcaC17tmm/O/VoBUKcK7Bryh1QjWD4Z3Lm89eP9L+O4wXud+MPNZZ60fvtuCXG9BXnV+lBeRwHE7t9NNKdsi75IGIWSfSSQ0SnyuWfjJYIMM2QPkaTGkZi3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PBoO7+D9; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1bc6d342-37f3-41c8-a001-36f2784db1bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756951498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/dDcohtOSgVy/WDEh4unk/zCXlMwusIhig033JTFsg=;
	b=PBoO7+D9kyMr5jl78k+ypGDjwJJvjYFmS6gbmS67xly5UbTYlyse0Pb4Lwp1u2e1hH3L9i
	qEaP9jvhOh/IBt8kcCExCKmoVxbXlwqOlyKnJccXH/EE+ocNX/ktCyzAASU5bpGzSD8bay
	O2vwHG8gQJ0ObG49ZZJu4quvza2yu1Q=
Date: Thu, 4 Sep 2025 10:04:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/filemap: Align last_index to folio size
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, chizhiling@163.com,
 Youling Tang <tangyouling@kylinos.cn>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20250711055509.91587-1-youling.tang@linux.dev>
 <jk3sbqrkfmtvrzgant74jfm2n3yn6hzd7tefjhjys42yt2trnp@avx5stdnkfsc>
 <afff8170-eed3-4c5c-8cc7-1595ccd32052@linux.dev>
 <20250903155046.bd82ae87ab9d30fe32ace2a6@linux-foundation.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <20250903155046.bd82ae87ab9d30fe32ace2a6@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/9/4 06:50, Andrew Morton wrote:

> On Tue, 12 Aug 2025 17:08:53 +0800 Youling Tang <youling.tang@linux.dev> wrote:
>
>> Hi, Jan
>> On 2025/7/14 17:33, Jan Kara wrote:
>>> On Fri 11-07-25 13:55:09, Youling Tang wrote:
>>>> From: Youling Tang <tangyouling@kylinos.cn>
>> ...
>>
>>>> --- a/mm/filemap.c
>>>> +++ b/mm/filemap.c
>>>> @@ -2584,8 +2584,9 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>>>>    	unsigned int flags;
>>>>    	int err = 0;
>>>>    
>>>> -	/* "last_index" is the index of the page beyond the end of the read */
>>>> -	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
>>>> +	/* "last_index" is the index of the folio beyond the end of the read */
>>>> +	last_index = round_up(iocb->ki_pos + count, mapping_min_folio_nrbytes(mapping));
>>>> +	last_index >>= PAGE_SHIFT;
>>> I think that filemap_get_pages() shouldn't be really trying to guess what
>>> readahead code needs and round last_index based on min folio order. After
>>> all the situation isn't special for LBS filesystems. It can also happen
>>> that the readahead mark ends up in the middle of large folio for other
>>> reasons. In fact, we already do have code in page_cache_ra_order() ->
>>> ra_alloc_folio() that handles rounding of index where mark should be placed
>>> so your changes essentially try to outsmart that code which is not good. I
>>> think the solution should really be placed in page_cache_ra_order() +
>>> ra_alloc_folio() instead.
>>>
>>> In fact the problem you are trying to solve was kind of introduced (or at
>>> least made more visible) by my commit ab4443fe3ca62 ("readahead: avoid
>>> multiple marked readahead pages"). There I've changed the code to round the
>>> index down because I've convinced myself it doesn't matter and rounding
>>> down is easier to handle in that place. But your example shows there are
>>> cases where rounding down has weird consequences and rounding up would have
>>> been better. So I think we need to come up with a method how to round up
>>> the index of marked folio to fix your case without reintroducing problems
>>> mentioned in commit ab4443fe3ca62.
>> Yes, I simply replaced round_up() in ra_alloc_folio() with round_down()
>> to avoid this phenomenon before submitting this patch.
>>
>> But at present, I haven't found a suitable way to solve both of these
>> problems
>> simultaneously. Do you have a better solution on your side?
>>
> fyi, this patch remains stuck in mm.git awaiting resolution.
>
> Do we have any information regarding its importance?  Which means do we
> have any measurement of its effect upon any real-world workload?
No measurements were taken regarding the impact on real-world
workloads, this was merely a line of thinking triggered by unusual
readahead behavior.

Thanks,
Youling.
>
> Thanks.
>

