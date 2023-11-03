Return-Path: <linux-fsdevel+bounces-1918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A17E0356
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 14:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F4B281E4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F053179A8;
	Fri,  3 Nov 2023 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DE91775E
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 13:07:52 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0979A111;
	Fri,  3 Nov 2023 06:07:49 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMLYk61CXzrRsT;
	Fri,  3 Nov 2023 21:04:42 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 21:07:47 +0800
Message-ID: <88a40128-e55a-4dde-b664-99ff3ead175b@huawei.com>
Date: Fri, 3 Nov 2023 21:07:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] fs/proc/page: use a folio in stable_page_flags()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, <gourry.memverge@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, David Hildenbrand
	<david@redhat.com>
References: <20231103072906.2000381-1-wangkefeng.wang@huawei.com>
 <20231103072906.2000381-5-wangkefeng.wang@huawei.com>
 <ZUTnf/hnbPqI9HSB@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZUTnf/hnbPqI9HSB@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected



On 2023/11/3 20:28, Matthew Wilcox wrote:
> On Fri, Nov 03, 2023 at 03:29:05PM +0800, Kefeng Wang wrote:
>> Replace ten compound_head() calls with one page_folio().
> 
> This is going to conflict with Gregory Price's work:
> 
> https://lore.kernel.org/linux-mm/ZUCD1dsbrFjdZgVv@memverge.com/
> 
> Perhaps the two of you can collaborate on a patch series?

Will check this patch.

> 
>>   	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
>> -	if (PageTail(page) && PageSlab(page))
>> +	if (PageTail(page) && folio_test_slab(folio))
>>   		u |= 1 << KPF_SLAB;
> 
> This doesn't make sense ...
> 

Yes, after commit dcb351cd095a ("page-flags: define behavior SL*B-
related flags on compound pages"), the slab could not be a tail,
I will drop this line.


