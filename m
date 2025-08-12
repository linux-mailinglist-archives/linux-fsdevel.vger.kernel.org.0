Return-Path: <linux-fsdevel+bounces-57490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70575B2226B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBF27AFE80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5C12E8E12;
	Tue, 12 Aug 2025 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AwQHNZbH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894C2E8DEA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989788; cv=none; b=a6jHXIPuGJ9YnlSGt+O38MXH6tNGO6Enju+htN20A4bmSkA8bK1Y6i4qjQM6I4zCTvXPg+KUi+MsX/CIDkzLfjdHDDxuGB1yskGp0euPTmk94myRbfEosPxPcxPIDwQuZs4zR8xGmbF6wYEcgnmIo3krKGHqtCXu7P/g0T7GbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989788; c=relaxed/simple;
	bh=0BjIen841izdz7ukUFaG0EHw/ca657Egri5MYc8+hrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LotJtcfuK5mHh3flDDHS1V677Z/opuWfoZcGmohvFt9IGsOIa34san/GAKTsJQvh6c35ASx40eKf4YTd7TIjqJuUQdfRIZfeCyiCnvFp7AKk4FDZnaoPeyUkKT51rkLGZj4A+/asn5N/X4U93f5aaupthmNBpFbleAv6Ni68WXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AwQHNZbH; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <afff8170-eed3-4c5c-8cc7-1595ccd32052@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754989774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvPuDYryFL7cUaYS/PjWB+HY7NUvNXH7iSkNQMdvGkE=;
	b=AwQHNZbHINF4vxM3ao3O81fqjTvbi21jgVKBmiAPDTWachMSjdwVgAs1PoK+Z59lDMpa4B
	lhShlg3oKdC9/+6wt6wZ3qkF0ulnjIlUH8FIXcxfDdZwzbWHxuMgcaA6RKmp1FTYngSQoJ
	mmJAk7gMF8k6SBtmmcuq+ICUK7xo5L4=
Date: Tue, 12 Aug 2025 17:08:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/filemap: Align last_index to folio size
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, chizhiling@163.com,
 Youling Tang <tangyouling@kylinos.cn>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20250711055509.91587-1-youling.tang@linux.dev>
 <jk3sbqrkfmtvrzgant74jfm2n3yn6hzd7tefjhjys42yt2trnp@avx5stdnkfsc>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <jk3sbqrkfmtvrzgant74jfm2n3yn6hzd7tefjhjys42yt2trnp@avx5stdnkfsc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi, Jan
On 2025/7/14 17:33, Jan Kara wrote:
> On Fri 11-07-25 13:55:09, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> On XFS systems with pagesize=4K, blocksize=16K, and CONFIG_TRANSPARENT_HUGEPAGE
>> enabled, We observed the following readahead behaviors:
>>   # echo 3 > /proc/sys/vm/drop_caches
>>   # dd if=test of=/dev/null bs=64k count=1
>>   # ./tools/mm/page-types -r -L -f  /mnt/xfs/test
>>   foffset	offset	flags
>>   0	136d4c	__RU_l_________H______t_________________F_1
>>   1	136d4d	__RU_l__________T_____t_________________F_1
>>   2	136d4e	__RU_l__________T_____t_________________F_1
>>   3	136d4f	__RU_l__________T_____t_________________F_1
>>   ...
>>   c	136bb8	__RU_l_________H______t_________________F_1
>>   d	136bb9	__RU_l__________T_____t_________________F_1
>>   e	136bba	__RU_l__________T_____t_________________F_1
>>   f	136bbb	__RU_l__________T_____t_________________F_1   <-- first read
>>   10	13c2cc	___U_l_________H______t______________I__F_1   <-- readahead flag
>>   11	13c2cd	___U_l__________T_____t______________I__F_1
>>   12	13c2ce	___U_l__________T_____t______________I__F_1
>>   13	13c2cf	___U_l__________T_____t______________I__F_1
>>   ...
>>   1c	1405d4	___U_l_________H______t_________________F_1
>>   1d	1405d5	___U_l__________T_____t_________________F_1
>>   1e	1405d6	___U_l__________T_____t_________________F_1
>>   1f	1405d7	___U_l__________T_____t_________________F_1
>>   [ra_size = 32, req_count = 16, async_size = 16]
>>
>>   # echo 3 > /proc/sys/vm/drop_caches
>>   # dd if=test of=/dev/null bs=60k count=1
>>   # ./page-types -r -L -f  /mnt/xfs/test
>>   foffset	offset	flags
>>   0	136048	__RU_l_________H______t_________________F_1
>>   ...
>>   c	110a40	__RU_l_________H______t_________________F_1
>>   d	110a41	__RU_l__________T_____t_________________F_1
>>   e	110a42	__RU_l__________T_____t_________________F_1   <-- first read
>>   f	110a43	__RU_l__________T_____t_________________F_1   <-- first readahead flag
>>   10	13e7a8	___U_l_________H______t_________________F_1
>>   ...
>>   20	137a00	___U_l_________H______t_______P______I__F_1   <-- second readahead flag (20 - 2f)
>>   21	137a01	___U_l__________T_____t_______P______I__F_1
>>   ...
>>   3f	10d4af	___U_l__________T_____t_______P_________F_1
>>   [first readahead: ra_size = 32, req_count = 15, async_size = 17]
>>
>> When reading 64k data (same for 61-63k range, where last_index is page-aligned
>> in filemap_get_pages()), 128k readahead is triggered via page_cache_sync_ra()
>> and the PG_readahead flag is set on the next folio (the one containing 0x10 page).
>>
>> When reading 60k data, 128k readahead is also triggered via page_cache_sync_ra().
>> However, in this case the readahead flag is set on the 0xf page. Although the
>> requested read size (req_count) is 60k, the actual read will be aligned to
>> folio size (64k), which triggers the readahead flag and initiates asynchronous
>> readahead via page_cache_async_ra(). This results in two readahead operations
>> totaling 256k.
>>
>> The root cause is that when the requested size is smaller than the actual read
>> size (due to folio alignment), it triggers asynchronous readahead. By changing
>> last_index alignment from page size to folio size, we ensure the requested size
>> matches the actual read size, preventing the case where a single read operation
>> triggers two readahead operations.
>>
>> After applying the patch:
>>   # echo 3 > /proc/sys/vm/drop_caches
>>   # dd if=test of=/dev/null bs=60k count=1
>>   # ./page-types -r -L -f  /mnt/xfs/test
>>   foffset	offset	flags
>>   0	136d4c	__RU_l_________H______t_________________F_1
>>   1	136d4d	__RU_l__________T_____t_________________F_1
>>   2	136d4e	__RU_l__________T_____t_________________F_1
>>   3	136d4f	__RU_l__________T_____t_________________F_1
>>   ...
>>   c	136bb8	__RU_l_________H______t_________________F_1
>>   d	136bb9	__RU_l__________T_____t_________________F_1
>>   e	136bba	__RU_l__________T_____t_________________F_1   <-- first read
>>   f	136bbb	__RU_l__________T_____t_________________F_1
>>   10	13c2cc	___U_l_________H______t______________I__F_1   <-- readahead flag
>>   11	13c2cd	___U_l__________T_____t______________I__F_1
>>   12	13c2ce	___U_l__________T_____t______________I__F_1
>>   13	13c2cf	___U_l__________T_____t______________I__F_1
>>   ...
>>   1c	1405d4	___U_l_________H______t_________________F_1
>>   1d	1405d5	___U_l__________T_____t_________________F_1
>>   1e	1405d6	___U_l__________T_____t_________________F_1
>>   1f	1405d7	___U_l__________T_____t_________________F_1
>>   [ra_size = 32, req_count = 16, async_size = 16]
>>
>> The same phenomenon will occur when reading from 49k to 64k. Set the readahead
>> flag to the next folio.
>>
>> Because the minimum order of folio in address_space equals the block size (at
>> least in xfs and bcachefs that already support bs > ps), having request_count
>> aligned to block size will not cause overread.
>>
>> Co-developed-by: Chi Zhiling <chizhiling@kylinos.cn>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> I agree with analysis of the problem but not quite with the solution. See
> below.
>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 765dc5ef6d5a..56a8656b6f86 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -2584,8 +2584,9 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>>   	unsigned int flags;
>>   	int err = 0;
>>   
>> -	/* "last_index" is the index of the page beyond the end of the read */
>> -	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
>> +	/* "last_index" is the index of the folio beyond the end of the read */
>> +	last_index = round_up(iocb->ki_pos + count, mapping_min_folio_nrbytes(mapping));
>> +	last_index >>= PAGE_SHIFT;
> I think that filemap_get_pages() shouldn't be really trying to guess what
> readahead code needs and round last_index based on min folio order. After
> all the situation isn't special for LBS filesystems. It can also happen
> that the readahead mark ends up in the middle of large folio for other
> reasons. In fact, we already do have code in page_cache_ra_order() ->
> ra_alloc_folio() that handles rounding of index where mark should be placed
> so your changes essentially try to outsmart that code which is not good. I
> think the solution should really be placed in page_cache_ra_order() +
> ra_alloc_folio() instead.
>
> In fact the problem you are trying to solve was kind of introduced (or at
> least made more visible) by my commit ab4443fe3ca62 ("readahead: avoid
> multiple marked readahead pages"). There I've changed the code to round the
> index down because I've convinced myself it doesn't matter and rounding
> down is easier to handle in that place. But your example shows there are
> cases where rounding down has weird consequences and rounding up would have
> been better. So I think we need to come up with a method how to round up
> the index of marked folio to fix your case without reintroducing problems
> mentioned in commit ab4443fe3ca62.
Yes, I simply replaced round_up() in ra_alloc_folio() with round_down()
to avoid this phenomenon before submitting this patch.

But at present, I haven't found a suitable way to solve both of these 
problems
simultaneously. Do you have a better solution on your side?

Thanks,
Youling.
>
> 								Honza

