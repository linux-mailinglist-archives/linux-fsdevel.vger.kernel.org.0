Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C25F7735F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 03:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjHHBdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 21:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjHHBc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:32:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77B19B0
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 18:32:35 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKbHl3BQtzrSKq;
        Tue,  8 Aug 2023 09:31:15 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 09:32:25 +0800
Message-ID: <572aef88-4fea-4c54-983b-dbb61805722e@huawei.com>
Date:   Tue, 8 Aug 2023 09:32:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memtest: convert to memtest_report_meminfo()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
References: <20230808012156.88924-1-wangkefeng.wang@huawei.com>
 <ZNGWUHj2gA62ksA8@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZNGWUHj2gA62ksA8@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/8/8 9:11, Matthew Wilcox wrote:
> On Tue, Aug 08, 2023 at 09:21:56AM +0800, Kefeng Wang wrote:
>> @@ -117,3 +118,17 @@ void __init early_memtest(phys_addr_t start, phys_addr_t end)
>>   		do_one_pass(patterns[idx], start, end);
>>   	}
>>   }
>> +
>> +void memtest_report_meminfo(struct seq_file *m)
>> +{
>> +	unsigned long early_memtest_bad_size_kb;

   if (!IS_ENABLED(CONFIG_PROC_FS))
           return;

>> +
>> +	if (!early_memtest_done)
>> +		return;
>> +
>> +	early_memtest_bad_size_kb = early_memtest_bad_size >> 10;
>> +	if (early_memtest_bad_size && !early_memtest_bad_size_kb)
>> +		early_memtest_bad_size_kb = 1;
>> +	/* When 0 is reported, it means there actually was a successful test */
>> +	seq_printf(m, "EarlyMemtestBad:   %5lu kB\n", early_memtest_bad_size_kb);
>> +}
> 
> Doesn't this function need to be under CONFIG_PROC_FS ?

Thanks for reminder, will add above check to eliminate code by compiler
> 
