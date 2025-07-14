Return-Path: <linux-fsdevel+bounces-54816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69770B038FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019D617B41B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CF823C4ED;
	Mon, 14 Jul 2025 08:16:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F92E23BCF0;
	Mon, 14 Jul 2025 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480970; cv=none; b=RxHCSljb3ToEgzwkZ33EC+tKEbnl9CLr8qLAUx4y4Gwqw1jRq3Hh5+GSgnpyd9HzBTiPrSdZPuRzNDJwDg29r300H3VcTGjdkJ7ddsHCO6Sf8cp1489Ml+74hfgTtXGTMKD/NJke9mhLOicp29JBV4QLNMsnW2TZ6NWClM4itM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480970; c=relaxed/simple;
	bh=EexMReTv3q6l7NhAPQ60w5rxtxXATRRRQxcgGkUf1Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlwUESUJhE/DaI2WZx2tzReSTATbchzH+4ug+SDCC0bbYCjYBHFbJi6IUCfkco4fzSvqd0LsTod+hhPFp+wnzzTgbEA87W6doBB4HX3GMqnMAbZnoDm+jPPBSJ++JVs8CH+CSMZm+pLQFe3o10yGf4Y0+RnvyhH+UM0xpEJAr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BD351764;
	Mon, 14 Jul 2025 01:15:57 -0700 (PDT)
Received: from [10.57.83.2] (unknown [10.57.83.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A368D3F66E;
	Mon, 14 Jul 2025 01:16:04 -0700 (PDT)
Message-ID: <86a82f42-918c-45f8-ac49-2b1f341ee0d3@arm.com>
Date: Mon, 14 Jul 2025 09:16:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: Align last_index to folio size
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Youling Tang <youling.tang@linux.dev>, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, chizhiling@163.com,
 Youling Tang <tangyouling@kylinos.cn>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20250711055509.91587-1-youling.tang@linux.dev>
 <e80c3fdd-782e-4857-810e-5b7384448154@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e80c3fdd-782e-4857-810e-5b7384448154@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/07/2025 17:08, David Hildenbrand wrote:
> CCing Ryan, who recently fiddled with readahead.
> 
> 
> On 11.07.25 07:55, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> On XFS systems with pagesize=4K, blocksize=16K, and CONFIG_TRANSPARENT_HUGEPAGE
>> enabled, We observed the following readahead behaviors:
>>   # echo 3 > /proc/sys/vm/drop_caches
>>   # dd if=test of=/dev/null bs=64k count=1
>>   # ./tools/mm/page-types -r -L -f  /mnt/xfs/test
>>   foffset    offset    flags
>>   0    136d4c    __RU_l_________H______t_________________F_1
>>   1    136d4d    __RU_l__________T_____t_________________F_1
>>   2    136d4e    __RU_l__________T_____t_________________F_1
>>   3    136d4f    __RU_l__________T_____t_________________F_1
>>   ...
>>   c    136bb8    __RU_l_________H______t_________________F_1
>>   d    136bb9    __RU_l__________T_____t_________________F_1
>>   e    136bba    __RU_l__________T_____t_________________F_1
>>   f    136bbb    __RU_l__________T_____t_________________F_1   <-- first read
>>   10    13c2cc    ___U_l_________H______t______________I__F_1   <-- readahead
>> flag
>>   11    13c2cd    ___U_l__________T_____t______________I__F_1
>>   12    13c2ce    ___U_l__________T_____t______________I__F_1
>>   13    13c2cf    ___U_l__________T_____t______________I__F_1
>>   ...
>>   1c    1405d4    ___U_l_________H______t_________________F_1
>>   1d    1405d5    ___U_l__________T_____t_________________F_1
>>   1e    1405d6    ___U_l__________T_____t_________________F_1
>>   1f    1405d7    ___U_l__________T_____t_________________F_1
>>   [ra_size = 32, req_count = 16, async_size = 16]
>>
>>   # echo 3 > /proc/sys/vm/drop_caches
>>   # dd if=test of=/dev/null bs=60k count=1
>>   # ./page-types -r -L -f  /mnt/xfs/test
>>   foffset    offset    flags
>>   0    136048    __RU_l_________H______t_________________F_1
>>   ...
>>   c    110a40    __RU_l_________H______t_________________F_1
>>   d    110a41    __RU_l__________T_____t_________________F_1
>>   e    110a42    __RU_l__________T_____t_________________F_1   <-- first read
>>   f    110a43    __RU_l__________T_____t_________________F_1   <-- first
>> readahead flag
>>   10    13e7a8    ___U_l_________H______t_________________F_1
>>   ...
>>   20    137a00    ___U_l_________H______t_______P______I__F_1   <-- second
>> readahead flag (20 - 2f)
>>   21    137a01    ___U_l__________T_____t_______P______I__F_1
>>   ...
>>   3f    10d4af    ___U_l__________T_____t_______P_________F_1
>>   [first readahead: ra_size = 32, req_count = 15, async_size = 17]
>>
>> When reading 64k data (same for 61-63k range, where last_index is page-aligned
>> in filemap_get_pages()), 128k readahead is triggered via page_cache_sync_ra()
>> and the PG_readahead flag is set on the next folio (the one containing 0x10
>> page).
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

I recently fiddled with mmap readahead paths, doing similar-ish things. I
haven't looked at the non-mmap paths so don't consider myself expert here. But
what you are saying makes sense and superficially the solution looks good to me, so:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

with one nit below...

>>
>> After applying the patch:
>>   # echo 3 > /proc/sys/vm/drop_caches
>>   # dd if=test of=/dev/null bs=60k count=1
>>   # ./page-types -r -L -f  /mnt/xfs/test
>>   foffset    offset    flags
>>   0    136d4c    __RU_l_________H______t_________________F_1
>>   1    136d4d    __RU_l__________T_____t_________________F_1
>>   2    136d4e    __RU_l__________T_____t_________________F_1
>>   3    136d4f    __RU_l__________T_____t_________________F_1
>>   ...
>>   c    136bb8    __RU_l_________H______t_________________F_1
>>   d    136bb9    __RU_l__________T_____t_________________F_1
>>   e    136bba    __RU_l__________T_____t_________________F_1   <-- first read
>>   f    136bbb    __RU_l__________T_____t_________________F_1
>>   10    13c2cc    ___U_l_________H______t______________I__F_1   <-- readahead
>> flag
>>   11    13c2cd    ___U_l__________T_____t______________I__F_1
>>   12    13c2ce    ___U_l__________T_____t______________I__F_1
>>   13    13c2cf    ___U_l__________T_____t______________I__F_1
>>   ...
>>   1c    1405d4    ___U_l_________H______t_________________F_1
>>   1d    1405d5    ___U_l__________T_____t_________________F_1
>>   1e    1405d6    ___U_l__________T_____t_________________F_1
>>   1f    1405d7    ___U_l__________T_____t_________________F_1
>>   [ra_size = 32, req_count = 16, async_size = 16]
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
>> ---
>>   include/linux/pagemap.h | 6 ++++++
>>   mm/filemap.c            | 5 +++--
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>> index e63fbfbd5b0f..447bb264fd94 100644
>> --- a/include/linux/pagemap.h
>> +++ b/include/linux/pagemap.h
>> @@ -480,6 +480,12 @@ mapping_min_folio_nrpages(struct address_space *mapping)
>>       return 1UL << mapping_min_folio_order(mapping);
>>   }
>>   +static inline unsigned long
>> +mapping_min_folio_nrbytes(struct address_space *mapping)
>> +{
>> +    return mapping_min_folio_nrpages(mapping) << PAGE_SHIFT;
>> +}
>> +
>>   /**
>>    * mapping_align_index() - Align index for this mapping.
>>    * @mapping: The address_space.
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 765dc5ef6d5a..56a8656b6f86 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -2584,8 +2584,9 @@ static int filemap_get_pages(struct kiocb *iocb, size_t
>> count,
>>       unsigned int flags;
>>       int err = 0;
>>   -    /* "last_index" is the index of the page beyond the end of the read */
>> -    last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
>> +    /* "last_index" is the index of the folio beyond the end of the read */

pedantic nit: I think you actually mean "the index of the first page within the
first minimum-sized folio beyond the end of the read"?

Thanks,
Ryan

>> +    last_index = round_up(iocb->ki_pos + count,
>> mapping_min_folio_nrbytes(mapping));
>> +    last_index >>= PAGE_SHIFT;
>>   retry:
>>       if (fatal_signal_pending(current))
>>           return -EINTR;
> 
> 


