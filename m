Return-Path: <linux-fsdevel+bounces-15949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD418961EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 03:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E69BFB26BC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 01:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489712B77;
	Wed,  3 Apr 2024 01:23:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E666E56E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107409; cv=none; b=Zb5t+KMX/STk6JThlVezWe7wMBGXnHwftrVlNdYxCW+C/mcyC29LGBWGaJEi+XgFWjS6RQivdPaokO5rj7XmV7rGH3JkauY8EswsKrurkhghv362y74UiOs2yvmIxb/pCp3vFziojOnupV3DEnaBRH3jyzp2L9RmuyVLSEPsHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107409; c=relaxed/simple;
	bh=DXwQ8NSyoaNWBWymhROwa3+nTCXOrEXDfvqXy8+Bv7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PQBr1/NyqQbgSNTUzfqi2plpMxsgDoQHodLvnqdi92FO4jV/eKr+ZEOm95BBgyTRtYHV5XE8Gb8stOaDE+C2jYcAV8zNK7G/lwepzW0h0Yf6ljE9PZq3fKJbbPoXvv/OVWk+0ZcgF4xPAUrK4866dDVlFZW98ulnAJyDhLUdgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V8Rl94hWcz1R9x5;
	Wed,  3 Apr 2024 09:20:37 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FFAE140257;
	Wed,  3 Apr 2024 09:23:23 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 09:23:22 +0800
Message-ID: <3e17cb03-eb23-4e13-876a-53a62b6c59bb@huawei.com>
Date: Wed, 3 Apr 2024 09:23:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/11] mm: migrate_device: use more folio in
 __migrate_device_pages()
Content-Language: en-US
To: Vishal Moola <vishal.moola@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>, Tony Luck
	<tony.luck@intel.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>, Miaohe Lin
	<linmiaohe@huawei.com>, Matthew Wilcox <willy@infradead.org>, David
 Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>, Benjamin
 LaHaise <bcrl@kvack.org>, <jglisse@redhat.com>, <linux-aio@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>, Jiaqi Yan
	<jiaqiyan@google.com>, Hugh Dickins <hughd@google.com>
References: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
 <20240321032747.87694-3-wangkefeng.wang@huawei.com> <Zgr7fYRd1M6gnEBi@fedora>
 <9200de40-aee5-4aee-9b78-4b93e3442d5f@huawei.com>
 <CAOzc2pwXs1Vomy=yuQ0=mDF=oPfJVe720vPKfYP3Er7YhYtWww@mail.gmail.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAOzc2pwXs1Vomy=yuQ0=mDF=oPfJVe720vPKfYP3Er7YhYtWww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/2 23:54, Vishal Moola wrote:
> On Mon, Apr 1, 2024 at 11:21 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>>
>>
>> On 2024/4/2 2:22, Vishal Moola wrote:
>>> On Thu, Mar 21, 2024 at 11:27:38AM +0800, Kefeng Wang wrote:
>>>>
>>>>               if (!newpage) {
>>>> @@ -728,14 +729,13 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>>>>                       continue;
>>>>               }
>>>>
>>>> -            mapping = page_mapping(page);
>>>> +            newfolio = page_folio(newpage);
>>>
>>> You could save another compound_head() call by passing the folio through
>>> to migrate_vma_insert_page() and make it migrate_vma_insert_folio(),
>>> since its already converted to use folios.
>>
>> Sure, but let's do it later, we could convert more functions in
>> migrate_device.c to use folios, thanks for your review, do you
> 
> Makes sense to me. This patch looks fine to me:
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> 

Thanks,

>> mind to help to review other patches, hope that the poison recover
>> from migrate folio was merged firstly.
> 
> I'll take a look at it, I'm not too familiar with how that code works just
> yet.

That's great.

> 
>>>
>>>> +            folio = page_folio(page);
>>>> +            mapping = folio_mapping(folio);
>>>>
>>>

