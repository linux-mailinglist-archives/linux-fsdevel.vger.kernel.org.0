Return-Path: <linux-fsdevel+bounces-17988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3C78B4900
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 03:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77EF2B21EB5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 01:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DA6A5F;
	Sun, 28 Apr 2024 01:09:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7E7E2
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714266548; cv=none; b=kw0Q35yZeZLtVj1x0WwmBlO5Dy4wqXN4zqUrHbRsYf1YBDqMk2i+audP5Pk04ZpkiJcmEWKztmQZniCi0AfzSaEmCF3nVj1GJoIBi/LQnVq6Ddk1kJt2wZw7WKb3a8EWmvjU72S72NuKPWd+Ej/hfV9D45zs5jTCcqQ8GIFivDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714266548; c=relaxed/simple;
	bh=X1sXRCr05tBiWPyr7yjJQO+IR/q09WNlq+55NjPqLv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YNbZu4tXVbXTD8ziSIqHeh8naRZfAKtYVUoRs12adskPaenrj0v29JoL60gdFji2BmmySVeajlsLbEFtxGRuEad8ZAzFTEIStX/i1c2mW/BEraig/ylr67XB1ulvJSuiJDmnzsThNgi8O/KT8P/fiH858cO9bb0WmYQzklMXnAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VRpDZ447SzvPr0;
	Sun, 28 Apr 2024 09:05:50 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id F29FC1403D2;
	Sun, 28 Apr 2024 09:08:56 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Apr 2024 09:08:56 +0800
Message-ID: <38017f5c-a74a-4d66-9092-efa79ffebfb9@huawei.com>
Date: Sun, 28 Apr 2024 09:08:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: use memalloc_nofs_save() in page_cache_ra_order()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>, zhangyi
	<yi.zhang@huawei.com>
References: <20240426112938.124740-1-wangkefeng.wang@huawei.com>
 <20240426114905.216e3d41b97f9a59be26999e@linux-foundation.org>
 <Zix0zk2faI6HeG9D@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Zix0zk2faI6HeG9D@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/27 11:45, Matthew Wilcox wrote:
> On Fri, Apr 26, 2024 at 11:49:05AM -0700, Andrew Morton wrote:
>> On Fri, 26 Apr 2024 19:29:38 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>    io_schedule+0x24/0xa0
>>>    __folio_lock+0x130/0x300
>>>    migrate_pages_batch+0x378/0x918
>>>    migrate_pages+0x350/0x700
>>>    compact_zone+0x63c/0xb38
>>>    compact_zone_order+0xc0/0x118
>>>    try_to_compact_pages+0xb0/0x280
>>>    __alloc_pages_direct_compact+0x98/0x248
>>>    __alloc_pages+0x510/0x1110
>>>    alloc_pages+0x9c/0x130
>>>    folio_alloc+0x20/0x78
>>>    filemap_alloc_folio+0x8c/0x1b0
>>>    page_cache_ra_order+0x174/0x308
>>>    ondemand_readahead+0x1c8/0x2b8
>>
>> I'm thinking
>>
>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>> Cc: stable
> 
> I think it goes back earlier than that.
> https://lore.kernel.org/linux-mm/20200128060304.GA6615@bombadil.infradead.org/
> details how it can happen with the old readpages code.  It's just easier
> to hit now.
> 

The page_cache_ra_order() is introduced from 793917d997df, but previous
bugfix f2c817bed58d ("mm: use memalloc_nofs_save in readahead path")
don't Cc stable, so the previous patch should be posted to stable?

