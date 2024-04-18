Return-Path: <linux-fsdevel+bounces-17218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D9A8A9133
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 04:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05C64B22025
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 02:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E6638F94;
	Thu, 18 Apr 2024 02:32:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171781EB46
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713407556; cv=none; b=rxxFajinuC4dALgHPN+Q2egPO01uI40nG8SICohYuaFPzPW9UyEKtkJKj7VlDYoeZ6s+WpU9PNQOQeUZzzSt641a4bUKuBgwRD4+7pL/EwFhoO7qYY5ZgvSZ/xEQ1ZvAEGP9opOJKtcQgAK/KSvFIBjo2fUIm2MSdq8E9rtdoxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713407556; c=relaxed/simple;
	bh=bLTfARLRi1VnFvpSmO1paVdHKGKasgiFf67eUFGMyP4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DUK/ItCye2ZGu1F60N6p/dBR5OYGBmWM/GPohD6KY4rglrVba9/PYlZtYSi2hurnq8cBFuL0secSgdV/MTH1H0g0/Jvui3KO4cNzx0MHnNvxOeyU68SvCaYoF08kLE1rMR9kcxKm36B3tFEttdx8QcYxUPCFUtc2Mq0OXMGD1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VKhYl3qMQz1hwQx;
	Thu, 18 Apr 2024 10:29:31 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 046111402CF;
	Thu, 18 Apr 2024 10:32:30 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:32:29 +0800
Subject: Re: [PATCH v1 04/11] mm: migrate: remove migrate_folio_extra()
To: Kefeng Wang <wangkefeng.wang@huawei.com>
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
 <dc5feae2-11fa-446d-a23c-7cfd6541fd6c@huawei.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <daeae886-7222-5a4f-45a1-b1b5abd7b6ed@huawei.com>
Date: Thu, 18 Apr 2024 10:32:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dc5feae2-11fa-446d-a23c-7cfd6541fd6c@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/17 9:43, Kefeng Wang wrote:
> 
> 
> On 2024/4/16 20:40, Miaohe Lin wrote:
>> On 2024/3/21 11:27, Kefeng Wang wrote:
>>> The migrate_folio_extra() only called in migrate.c now, convert it
>>> a static function and take a new src_private argument which could
>>> be shared by migrate_folio() and filemap_migrate_folio() to simplify
>>> code a bit.
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>   include/linux/migrate.h |  2 --
>>>   mm/migrate.c            | 33 +++++++++++----------------------
>>>   2 files changed, 11 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>> index 2ce13e8a309b..517f70b70620 100644
>>> --- a/include/linux/migrate.h
>>> +++ b/include/linux/migrate.h
>>> @@ -63,8 +63,6 @@ extern const char *migrate_reason_names[MR_TYPES];
>>>   #ifdef CONFIG_MIGRATION
>>>     void putback_movable_pages(struct list_head *l);
>>> -int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
>>> -        struct folio *src, enum migrate_mode mode, int extra_count);
>>>   int migrate_folio(struct address_space *mapping, struct folio *dst,
>>>           struct folio *src, enum migrate_mode mode);
>>>   int migrate_pages(struct list_head *l, new_folio_t new, free_folio_t free,
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index cb4cbaa42a35..c006b0b44013 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -658,18 +658,19 @@ EXPORT_SYMBOL(folio_migrate_copy);
>>>    *                    Migration functions
>>>    ***********************************************************/
>>>   -int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
>>> -        struct folio *src, enum migrate_mode mode, int extra_count)
>>> +static int __migrate_folio(struct address_space *mapping, struct folio *dst,
>>> +               struct folio *src, void *src_private,
>>> +               enum migrate_mode mode)
>>>   {
>>>       int rc;
>>>   -    BUG_ON(folio_test_writeback(src));    /* Writeback must be complete */
>>> -
>>> -    rc = folio_migrate_mapping(mapping, dst, src, extra_count);
>>> -
>>> +    rc = folio_migrate_mapping(mapping, dst, src, 0);
>>>       if (rc != MIGRATEPAGE_SUCCESS)
>>>           return rc;
>>>   +    if (src_private)
>>
>> src_private seems unneeded. It can be replaced with folio_get_private(src)?
>>
> 
> __migrate_folio() is used by migrate_folio() and filemap_migrate_folio(),
> but migrate_folio() is for LRU folio, when swapcache folio, the
> folio->private is handled from folio_migrate_mapping(), we should not
> try to call folio_detach_private/folio_attach_private().

I see. Swapcache folio will use private field while without using PagePrivate/PagePrivate2.
We can't handle this case if src_private is removed.
Thanks.
.

> 
>> Thanks.
>> .
> .


