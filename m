Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2056FA0FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 09:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjEHH1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 03:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjEHH1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 03:27:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0CA1FCA;
        Mon,  8 May 2023 00:27:45 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QFCSl1kRQz18LGH;
        Mon,  8 May 2023 15:23:35 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 15:27:42 +0800
Message-ID: <2ab0ddbb-f9a4-8963-b066-d9a93b5f01b3@huawei.com>
Date:   Mon, 8 May 2023 15:27:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 03/12] mm: page_alloc: move set_zone_contiguous() into
 mm_init.c
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
 <20230508071200.123962-4-wangkefeng.wang@huawei.com>
 <87jzxj9u0n.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <87jzxj9u0n.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/8 15:12, Huang, Ying wrote:
> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> 
>> set_zone_contiguous() is only used in mm init/hotplug, and
>> clear_zone_contiguous() only used in hotplug, move them from
>> page_alloc.c to the more appropriate file.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/linux/memory_hotplug.h |  3 --
>>   mm/internal.h                  |  7 +++
>>   mm/mm_init.c                   | 74 +++++++++++++++++++++++++++++++
>>   mm/page_alloc.c                | 79 ----------------------------------
>>   4 files changed, 81 insertions(+), 82 deletions(-)
>>
...
>>   
>> +/*
>> + * Check that the whole (or subset of) a pageblock given by the interval of
>> + * [start_pfn, end_pfn) is valid and within the same zone, before scanning it
>> + * with the migration of free compaction scanner.
>> + *
>> + * Return struct page pointer of start_pfn, or NULL if checks were not passed.
>> + *
>> + * It's possible on some configurations to have a setup like node0 node1 node0
>> + * i.e. it's possible that all pages within a zones range of pages do not
>> + * belong to a single zone. We assume that a border between node0 and node1
>> + * can occur within a single pageblock, but not a node0 node1 node0
>> + * interleaving within a single pageblock. It is therefore sufficient to check
>> + * the first and last page of a pageblock and avoid checking each individual
>> + * page in a pageblock.
>> + *
>> + * Note: the function may return non-NULL struct page even for a page block
>> + * which contains a memory hole (i.e. there is no physical memory for a subset
>> + * of the pfn range). For example, if the pageblock order is MAX_ORDER, which
>> + * will fall into 2 sub-sections, and the end pfn of the pageblock may be hole
>> + * even though the start pfn is online and valid. This should be safe most of
>> + * the time because struct pages are still initialized via init_unavailable_range()
>> + * and pfn walkers shouldn't touch any physical memory range for which they do
>> + * not recognize any specific metadata in struct pages.
>> + */
>> +struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>> +				     unsigned long end_pfn, struct zone *zone)
> 
> __pageblock_pfn_to_page() is also called by compaction code too (e.g.,
> isolate_freepages_range() -> pageblock_pfn_to_page() ->
> __pageblock_pfn_to_page()).
> 
> So, it is used not only by initialization and hotplug?
> 

I should drop the move of this function, thanks for your reminder.

> Best Regards,
> Huang, Ying
