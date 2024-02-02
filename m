Return-Path: <linux-fsdevel+bounces-9948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768378465FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 03:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A94B1F24883
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EA9BE79;
	Fri,  2 Feb 2024 02:47:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC3BE5A
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842023; cv=none; b=Z64DKhPBSbYs4lvJ3SJHTuEvVyeWMFVXNIJpzJBs0PlmaIrNEpzkcSi21Fluv2KocLpyI2qSyp4gM6H0wY0/WwB3BMTW37HkKgqxjlDmjJcnWha35kzVO8mhS7QVJAPTibJarbsKLRn5PiJPnIu7knX0m8ab4ybVz6bfVK9WB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842023; c=relaxed/simple;
	bh=u5ijFlyuwhKGPkpRs73/beXkWMuwf6BJu0iJixWbpnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XnySl9RAr8OB/2EUSGjaggZlfyluTWZkX4vxW3JwQUBLcW8COPeypPKXF8rCuHgCn5cTR+O0Ms+cJSY/VD5iWT6wvGMByKQjVx3EjNfb/1riXtCy/qgoCysNsp56p6vGhEDnMh2s2Deyfz7tamHWNTWXEeCGOZQEhm1uk01vUjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TR0Wl562yzNllG;
	Fri,  2 Feb 2024 10:45:55 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id E1E29140499;
	Fri,  2 Feb 2024 10:46:57 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 10:46:57 +0800
Message-ID: <875b1c69-680f-4128-b748-e238bfee3a4e@huawei.com>
Date: Fri, 2 Feb 2024 10:46:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 3/9] mm: migrate: remove migrate_folio_extra()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>, Tony Luck
	<tony.luck@intel.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>, Miaohe Lin
	<linmiaohe@huawei.com>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>
References: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
 <20240129070934.3717659-4-wangkefeng.wang@huawei.com>
 <Zbv6jSYvUhtNWlPk@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Zbv6jSYvUhtNWlPk@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/2/2 4:09, Matthew Wilcox wrote:
> On Mon, Jan 29, 2024 at 03:09:28PM +0800, Kefeng Wang wrote:
>> Convert migrate_folio_extra() to __migrate_folio() which will be used
>> by migrate_folio() and filemap_migrate_folio(), also directly call
>> folio_migrate_mapping() in __migrate_device_pages() to simplify code.
> 
> This feels like two patches?  First convert __migrate_device_pages()
> then do the other thing?

That will be better, will split it, thanks

> 
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/linux/migrate.h |  2 --
>>   mm/migrate.c            | 32 +++++++++++---------------------
>>   mm/migrate_device.c     | 13 +++++++------
>>   3 files changed, 18 insertions(+), 29 deletions(-)
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
>> index cdae25b7105f..a51ceebbe3b1 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -655,22 +655,24 @@ EXPORT_SYMBOL(folio_migrate_copy);
>>    *                    Migration functions
>>    ***********************************************************/
>>   
>> -int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
>> -		struct folio *src, enum migrate_mode mode, int extra_count)
>> +static int __migrate_folio(struct address_space *mapping, struct folio *dst,
>> +			   struct folio *src, enum migrate_mode mode,
>> +			   void *src_private)
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
>> +		folio_attach_private(dst, folio_detach_private(src));
>> +
>>   	if (mode != MIGRATE_SYNC_NO_COPY)
>>   		folio_migrate_copy(dst, src);
>>   	else
>>   		folio_migrate_flags(dst, src);
>> +
>>   	return MIGRATEPAGE_SUCCESS;
>>   }
>>   
>> @@ -689,7 +691,8 @@ int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
>>   int migrate_folio(struct address_space *mapping, struct folio *dst,
>>   		struct folio *src, enum migrate_mode mode)
>>   {
>> -	return migrate_folio_extra(mapping, dst, src, mode, 0);
>> +	BUG_ON(folio_test_writeback(src));	/* Writeback must be complete */
>> +	return __migrate_folio(mapping, dst, src, mode, NULL);
>>   }
>>   EXPORT_SYMBOL(migrate_folio);
>>   
>> @@ -843,20 +846,7 @@ EXPORT_SYMBOL_GPL(buffer_migrate_folio_norefs);
>>   int filemap_migrate_folio(struct address_space *mapping,
>>   		struct folio *dst, struct folio *src, enum migrate_mode mode)
>>   {
>> -	int ret;
>> -
>> -	ret = folio_migrate_mapping(mapping, dst, src, 0);
>> -	if (ret != MIGRATEPAGE_SUCCESS)
>> -		return ret;
>> -
>> -	if (folio_get_private(src))
>> -		folio_attach_private(dst, folio_detach_private(src));
>> -
>> -	if (mode != MIGRATE_SYNC_NO_COPY)
>> -		folio_migrate_copy(dst, src);
>> -	else
>> -		folio_migrate_flags(dst, src);
>> -	return MIGRATEPAGE_SUCCESS;
>> +	return __migrate_folio(mapping, dst, src, mode, folio_get_private(src));
>>   }
>>   EXPORT_SYMBOL_GPL(filemap_migrate_folio);
>>   
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index d49a48d87d72..bea71d69295a 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -695,7 +695,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>>   		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>>   		struct address_space *mapping;
>>   		struct folio *newfolio, *folio;
>> -		int r;
>> +		int r, extra_cnt = 0;
>>   
>>   		if (!newpage) {
>>   			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>> @@ -757,14 +757,15 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>>   			continue;
>>   		}
>>   
>> +		BUG_ON(folio_test_writeback(folio));
>> +
>>   		if (migrate && migrate->fault_page == page)
>> -			r = migrate_folio_extra(mapping, newfolio, folio,
>> -						MIGRATE_SYNC_NO_COPY, 1);
>> -		else
>> -			r = migrate_folio(mapping, newfolio, folio,
>> -					  MIGRATE_SYNC_NO_COPY);
>> +			extra_cnt = 1;
>> +		r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
>>   		if (r != MIGRATEPAGE_SUCCESS)
>>   			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>> +		else
>> +			folio_migrate_flags(newfolio, folio);
>>   	}
>>   
>>   	if (notified)
>> -- 
>> 2.27.0
>>

