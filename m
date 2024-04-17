Return-Path: <linux-fsdevel+bounces-17092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E7A8A7A3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 03:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908D41C214C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 01:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903CAD4C;
	Wed, 17 Apr 2024 01:43:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1248F72
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713318218; cv=none; b=NJv7M5rHnw8KMYgnFbK9mUAeMARRFTToodRzOc5QoOXserWQqeOwvqNtc3GH/yCT8w9u/Ay+wjMjXQ/a4sn0vUPacqNeRKKpp451yTeWAa56fbzPMGx0Z5opu2P4kLZLV3XbHSHW/zJVukFOUbkOKZq4thLTDMIKLp5nx1HD81g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713318218; c=relaxed/simple;
	bh=vNXh/Zh2ebR722szamtesw22IvqQWNGPakqRHCTqd14=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UrTNGMUIxGPa4BwGL+OUbcRxebbGBOsgFAAWlgY6l6dxo0WpMwzi4BxtztwHKw4UG0gJg56gz/leeVuJ/tDagrPF+zuf2OkB7KWD9Xy4KtbaYws4D3yhbS9EPUJAjLtuopazfr8bMlxhEWEI4GX5hkgwf8MVNBrvVi+slw+HQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VK3Wq1k6ZztX0J;
	Wed, 17 Apr 2024 09:40:39 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C1F318005D;
	Wed, 17 Apr 2024 09:43:31 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 09:43:30 +0800
Message-ID: <dc5feae2-11fa-446d-a23c-7cfd6541fd6c@huawei.com>
Date: Wed, 17 Apr 2024 09:43:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] mm: migrate: remove migrate_folio_extra()
Content-Language: en-US
To: Miaohe Lin <linmiaohe@huawei.com>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Matthew Wilcox <willy@infradead.org>, David
 Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>, Benjamin
 LaHaise <bcrl@kvack.org>, <jglisse@redhat.com>, <linux-aio@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>, Jiaqi Yan
	<jiaqiyan@google.com>, Hugh Dickins <hughd@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
 <20240321032747.87694-5-wangkefeng.wang@huawei.com>
 <c89ed21c-4068-9668-aede-a68c6a2ef7d2@huawei.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <c89ed21c-4068-9668-aede-a68c6a2ef7d2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/16 20:40, Miaohe Lin wrote:
> On 2024/3/21 11:27, Kefeng Wang wrote:
>> The migrate_folio_extra() only called in migrate.c now, convert it
>> a static function and take a new src_private argument which could
>> be shared by migrate_folio() and filemap_migrate_folio() to simplify
>> code a bit.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/linux/migrate.h |  2 --
>>   mm/migrate.c            | 33 +++++++++++----------------------
>>   2 files changed, 11 insertions(+), 24 deletions(-)
>>
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index 2ce13e8a309b..517f70b70620 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -63,8 +63,6 @@ extern const char *migrate_reason_names[MR_TYPES];
>>   #ifdef CONFIG_MIGRATION
>>   
>>   void putback_movable_pages(struct list_head *l);
>> -int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
>> -		struct folio *src, enum migrate_mode mode, int extra_count);
>>   int migrate_folio(struct address_space *mapping, struct folio *dst,
>>   		struct folio *src, enum migrate_mode mode);
>>   int migrate_pages(struct list_head *l, new_folio_t new, free_folio_t free,
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index cb4cbaa42a35..c006b0b44013 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -658,18 +658,19 @@ EXPORT_SYMBOL(folio_migrate_copy);
>>    *                    Migration functions
>>    ***********************************************************/
>>   
>> -int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
>> -		struct folio *src, enum migrate_mode mode, int extra_count)
>> +static int __migrate_folio(struct address_space *mapping, struct folio *dst,
>> +			   struct folio *src, void *src_private,
>> +			   enum migrate_mode mode)
>>   {
>>   	int rc;
>>   
>> -	BUG_ON(folio_test_writeback(src));	/* Writeback must be complete */
>> -
>> -	rc = folio_migrate_mapping(mapping, dst, src, extra_count);
>> -
>> +	rc = folio_migrate_mapping(mapping, dst, src, 0);
>>   	if (rc != MIGRATEPAGE_SUCCESS)
>>   		return rc;
>>   
>> +	if (src_private)
> 
> src_private seems unneeded. It can be replaced with folio_get_private(src)?
> 

__migrate_folio() is used by migrate_folio() and filemap_migrate_folio(),
but migrate_folio() is for LRU folio, when swapcache folio, the
folio->private is handled from folio_migrate_mapping(), we should not
try to call folio_detach_private/folio_attach_private().

> Thanks.
> .

