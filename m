Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDD737B4BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 05:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhELDyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 23:54:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2566 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhELDyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 23:54:35 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg16H2mXQzwSTD;
        Wed, 12 May 2021 11:50:47 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:53:22 +0800
Subject: Re: [PATCH 3/8] mm/debug: Factor PagePoisoned out of __dump_page
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <akpm@linux-foundation.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>
References: <20210430145549.2662354-1-willy@infradead.org>
 <20210430145549.2662354-4-willy@infradead.org>
 <2baf684e-f35d-5c42-fa11-1e061a12a81f@huawei.com>
 <YJtNxP5I8auBg/XL@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <83bcb26b-79ae-d47f-81c0-873e07d43f3b@huawei.com>
Date:   Wed, 12 May 2021 11:53:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YJtNxP5I8auBg/XL@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/5/12 11:38, Matthew Wilcox wrote:
> On Wed, May 12, 2021 at 11:29:06AM +0800, Kefeng Wang wrote:
>>>    void dump_page(struct page *page, const char *reason)
>>>    {
>>> -	__dump_page(page, reason);
>>> +	if (PagePoisoned(page))
>>> +		pr_warn("page:%p is uninitialized and poisoned", page);
>>> +	else
>>> +		__dump_page(page);
>>
>> Hi Matthew, dump_page_owenr() should be called when !PagePoisoned, right?
>>
>>
>>> +	if (reason)
>>> +		pr_warn("page dumped because: %s\n", reason);
>>>    	dump_page_owner(page);
>>>    }
>>>    EXPORT_SYMBOL(dump_page);
> 
> dump_page_owner() is called whether the page is Poisoned or not ...
> both before and after this patch.  Is there a problem with that?

struct page_ext *page_ext = lookup_page_ext(page);

   unsigned long pfn = page_to_pfn(page);
   struct mem_section *section = __pfn_to_section(pfn);
   if (!section->page_ext)

If page is Poisoned, I guess the section maybe NULL,
so section->page_ext may meet NULL pointer dereference,
is it possible?


> 
> .
> 
