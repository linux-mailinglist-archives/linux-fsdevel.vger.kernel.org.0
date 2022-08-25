Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260745A055A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 02:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiHYAtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 20:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiHYAtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 20:49:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3B1915EA;
        Wed, 24 Aug 2022 17:49:15 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MCkn960jfznTfr;
        Thu, 25 Aug 2022 08:46:53 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 08:49:13 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 08:49:12 +0800
Message-ID: <eb46de08-405b-8e3c-4d06-86d224f12ce7@huawei.com>
Date:   Thu, 25 Aug 2022 08:49:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
CC:     <mawupeng1@huawei.com>, <corbet@lwn.net>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <songmuchun@bytedance.com>, <mike.kravetz@oracle.com>,
        <osalvador@suse.de>, <rppt@kernel.org>, <surenb@google.com>,
        <jsavitz@redhat.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 1/2] mm: Cap zone movable's min wmark to small value
Content-Language: en-US
To:     <david@redhat.com>, <akpm@linux-foundation.org>
References: <20220819093025.105403-1-mawupeng1@huawei.com>
 <20220819093025.105403-2-mawupeng1@huawei.com>
 <96433a14-1d2c-739d-95fb-3e3339200dcf@redhat.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <96433a14-1d2c-739d-95fb-3e3339200dcf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/8/24 16:10, David Hildenbrand wrote:
> On 19.08.22 11:30, Wupeng Ma wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> Since min_free_kbytes is based on gfp_zone(GFP_USER) which does not include
>> zone movable. However zone movable will get its min share in
>> __setup_per_zone_wmarks() which does not make any sense.
>>
>> And like highmem pages, __GFP_HIGH and PF_MEMALLOC allocations usually
>> don't need movable pages, so there is no need to assign min pages for zone
>> movable.
>>
>> Let's cap pages_min for zone movable to a small value here just link
>> highmem pages.
>>
>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>> ---
>>  mm/page_alloc.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index e5486d47406e..ff644205370f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8638,7 +8638,7 @@ static void __setup_per_zone_wmarks(void)
>>  
>>  	/* Calculate total number of !ZONE_HIGHMEM pages */
>>  	for_each_zone(zone) {
>> -		if (!is_highmem(zone))
>> +		if (!is_highmem(zone) && zone_idx(zone) != ZONE_MOVABLE)
>>  			lowmem_pages += zone_managed_pages(zone);
>>  	}
>>  
>> @@ -8648,7 +8648,7 @@ static void __setup_per_zone_wmarks(void)
>>  		spin_lock_irqsave(&zone->lock, flags);
>>  		tmp = (u64)pages_min * zone_managed_pages(zone);
>>  		do_div(tmp, lowmem_pages);
>> -		if (is_highmem(zone)) {
>> +		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
>>  			/*
>>  			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
>>  			 * need highmem pages, so cap pages_min to a small
> 
> This kind-off makes sense to me, but I'm not completely sure about all
> implications. We most certainly should update the comment as well.

Yes, we should certainly do this.

Thanks for reviewing.

> 
