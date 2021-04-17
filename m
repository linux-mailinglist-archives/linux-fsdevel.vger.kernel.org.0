Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7058362FB7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 13:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbhDQLy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Apr 2021 07:54:56 -0400
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com ([40.107.237.80]:48318
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235901AbhDQLyw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:54:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpY05T5nEfeQB1K8MjrJkqLojQ6p8Cr6T1bbj+fIS8GXYdepJJjZJHoVa0LgQsit1sBVc/CLfJzstiNF1YFDfysjOY/SOSuzzuGwvhxC6WgbjEcez8a88B7zl3PrZeb6XKfqT+pMBt4qEESwBG2fSrZljvmtfGN8s2Rf8cSehNCJj0mrq26CmW/SsxnxYAwbThBS5KOjK19RODLJycvnnXY4p1J8bcVCo0bGIusJQfiQDcTCn/999FapaCmhyjCbEpWfCCE2Hqho+XF+5h/iOI20bsBxLEH4sRjt2Mb1ivvgD/f9T9/1jjvmMQt8HqI88w5Pb+kCoJIRP2I44/klSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQBjzIjLx0w0wr9I99EFQiTbt7XnI75XPu0IdHMizKo=;
 b=amOPy+y3LNCttir0+KU8RfC9gzREiIBWI5i+MSif0twD8+nkqtnd+E+zyU30xMmOdh94zSg3UoKMnCE5SBT/ca2Vk3Lpxg/HpRzf0f75tFuyCZtrv/GG+Jp1npqOgB5Y/ge587DvhdvzXslvXpP1DjqA4O5KZkMn12+wRNDVL4LXzBm0CZeFUTJ7eTZauFG1FTvZ0UVoz3Il8231ujqpg4QPTukUeHoJc57tdpr1UZK8+vJ/wQEJa+ZJpHq644vtYuPazRpSN8N9BaQ+nGhH5LFWYR+EPd9UrltiSUiuA3BeyypSMfnqnm6Q2JEtYmw+dtCrfRyZW4WdxS9NBpi9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQBjzIjLx0w0wr9I99EFQiTbt7XnI75XPu0IdHMizKo=;
 b=bwYYGRRWXAEJbUbRuto2VIMyjZbOcB1+KTqEktFcAHXvHvfxMWkKtrsobQfktaMV7mky+eUDp2bA2rUtX6KUSqaMHc6a/ws8YX4/0zqCr0AC8HbTXTrplXEaTo4CUNswxEDPAHp/gFIuzwr8809N0IqBNfJVn0JgqxNvZIKXM5o=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Sat, 17 Apr
 2021 11:54:23 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4042.020; Sat, 17 Apr 2021
 11:54:23 +0000
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
To:     Peter.Enderborg@sony.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sumit.semwal@linaro.org,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        mhocko@suse.com, neilb@suse.de, samitolvanen@google.com,
        rppt@kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        willy@infradead.org
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <d983aef9-3dde-54cc-59a0-d9d42130b513@amd.com>
 <d822adcc-2a3c-1923-0d1d-4ecabd76a0e5@sony.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2420ea7a-4746-b11a-3c0e-2f962059d071@amd.com>
Date:   Sat, 17 Apr 2021 13:54:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <d822adcc-2a3c-1923-0d1d-4ecabd76a0e5@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:748d:44e6:d01a:aa0f]
X-ClientProxiedBy: AM3PR07CA0119.eurprd07.prod.outlook.com
 (2603:10a6:207:7::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:748d:44e6:d01a:aa0f] (2a02:908:1252:fb60:748d:44e6:d01a:aa0f) by AM3PR07CA0119.eurprd07.prod.outlook.com (2603:10a6:207:7::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.7 via Frontend Transport; Sat, 17 Apr 2021 11:54:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bd11ce3-5783-403d-d131-08d901978ab1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3935:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3935A61DA168554734A7F478834B9@MN2PR12MB3935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Xw93LRvz1h7FL7aGpgxtvrpHTi7TS6DAY3TFgfzaPlAnMVofLaSPRzGXyp4ks0+8UqUI6yQFpc8ZAvlwpgrUWplj79MhDnzMBHrO+IN+UcC2dLea27eRJgBrFbql1/RANF5L9e7inKX9enCGiOXuLQdDW9RQd2plR7XIDixQNH6g5d2YIrdjQN46Zmxk9dZEDxbLSan+OOvD9JwMDfbKOWkoutpE0pq0MvVA6A9fbqgT1Ak2qou7mRBiHJCYdKuEE33hzRo/+yXMWDlqSzzV3aDVqBN+Mx8WF7sKcwLJ5L0xfcd60GFKE/vl2aR4BzMLiak8FaY6NRwx5REmYKFb6BGnzFAYFHyh6XMa56AG+07pkDwLxHQ4P62OhciPiNaqZd6942wmSBvdu+uKjtIOUc4LiosTVLGtv+nO/GnA2jNzoMlXYzHX+57oD2nPtqJAw4FNw4uFjbEi/HSxE3Q6Z4A+02EpukmPeKp8t6roDigHtbXCtLOuBLXQ4tEseT60duYK+sgP/w+D4KKYb7AfjuIQ3MWjioTj+lbz0ZU9Md6DiOBneWVng+KdfUtNSWvFRLGQT6UwAGUMSdbRp1vYhY7OMoQvs/iMkYIycjTVtLxdqK4vfAqRPbiDQaOQ6+Cvfswo1LcRyZ803GFQXFo1pGQGPd+qebEnxa0Hqt6z3RJz3+yuY6Toas5pHxCK4PS+5DjG9HGc4C26N4MQ9JWTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(6666004)(8936002)(8676002)(478600001)(2616005)(36756003)(16526019)(2906002)(52116002)(31696002)(7416002)(5660300002)(186003)(31686004)(6486002)(316002)(921005)(86362001)(38100700002)(83380400001)(66946007)(66556008)(53546011)(66574015)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eHR2b2ROT0JFVmFMMmliNTBWZkd4bjZwcVhBemVFQ1ByM2ErZXVQakRNbjBj?=
 =?utf-8?B?YjhqVHFOdHhBQ09kZTgwR01STExzUWRWWDBRbkYxb0IrbUsyKzBjRldXVVMv?=
 =?utf-8?B?b1VVcGtIWkFVVzV1UEc5THQxZ0xMdkxmdkZtQW5BVUhuNkNTZjhXNStOYXB6?=
 =?utf-8?B?K28vcEtqV0JNekIzWHNzd1FJUXBKSHppY2VCUE9tVDdXcVlCQW1oQktPUThz?=
 =?utf-8?B?blJPSlRNM1hIOUY0SGI1YlJpRHdHck5mUURwZEVIeCtHdFBiTGNRdVBNTDJp?=
 =?utf-8?B?VnZ1SFpKcjh5KzRmMlZDSFFUZEtCYmo3LzdwcWxCMnViRFd5OU9qYmxmM3gw?=
 =?utf-8?B?bnhrbnNzY1dBYlMyQTJlQXNaUWtoVk5ZQUpGQlc1TFNPZWRaK3lqVTM3Rms0?=
 =?utf-8?B?RzFUbVR2YXNHRDRyR1ZPdDJ4bUlQaXlLai9UTCt2cUladGJ3M2JjTWwvQmFp?=
 =?utf-8?B?VHRTbW82OHg3aVJjTk03SlNsWDdhd2x5WDFnUXdha1h1S2EyOXZiaStzcGZR?=
 =?utf-8?B?YXhJU01WZmNhNkdTQjBCWUxoTFVlNkFhZWpPMDM3UWpTcnJXdVJPa3FwT1k4?=
 =?utf-8?B?ZjlKV1l3Tm1JY0tCT3R3K0I5V0pNODRvVTl5TmVMWmllblRxdnNQWm85eDQr?=
 =?utf-8?B?ZjlXZUVPRGJaNklqT2NpWHpSeUNCVXlqUDdUSU9oeDd2L21pMDJFM2hFWmZG?=
 =?utf-8?B?cEhXVmVoaENpY3dlV0ltNFg1Q3VlUlFIclZDMXYzaDBvRVIyeEppTFBSTS9j?=
 =?utf-8?B?SE1HbkRqTmQ3N0xtYTZFcXA2UkdTQ2ZnQ0c3dlczTEtTZC8yQmRTUmJRNzlP?=
 =?utf-8?B?eWE0Y3JmV0FqT2VVeU1BbFhlbGo4MHRybHRVb01ORDg2K3VmUmVVd0g0dklJ?=
 =?utf-8?B?cm93MTRsTnBoRThHRDMycFN5VTA2OEEvdzA2eEFiNWJNTUZEbndmSUNNeDZh?=
 =?utf-8?B?MWhmb2d3VFlZVHRnSzNnZjNvQUZmZWdzWXVFdkF2ZlVXWlk3VXIxRlhGcEtw?=
 =?utf-8?B?WFZsank5OWw0TkdCQVp5eE1obEUraHlYVTMrdkFYOTEyRjFOa1Y0OFJjcHJQ?=
 =?utf-8?B?T1VGSzB2ZER5S3FrWDdCL2tnVVdTKzI2dk1YUlNneHc1aGxtNUF6OUJ2encx?=
 =?utf-8?B?Zk1BWjJwOVAzMlhnNXc3S3hTM2RURitFcnNtMzFrVUVRWHBNdnQ1bUNNTEgv?=
 =?utf-8?B?bVJkWGZLWUdLSmthUCtsM2FIUXd5N3FmUXI4ODVOa3ZIcXQ5MlRXWTZGbUZ5?=
 =?utf-8?B?SHVSUFNCdTBsemxJbzRrTDlmcVN6TlZJaWdKQjJFaFRQQkZXbE9SUHl0enRs?=
 =?utf-8?B?b3Voelo0ejh4cE5lWWFtL0xWcXh5OW1XWGhsa3llNzZDSkRYdTRXeHBtYmVK?=
 =?utf-8?B?L2t5V3BEY3lHa0JQcWhIOHlPb2xoakVjSlpQZ0VWRmp0SXZFekpybVBOVTFV?=
 =?utf-8?B?bzZ3MEJqTnkvMEhVclBLZmd1OXEvZGpneDZpYzFkVlpTR25QSy9zb21hSTky?=
 =?utf-8?B?YXBBWTVtaUp1K0Y5eEwyaUFZa21DVlBGdkErTDVTN3NmbHRuRnNWTXJMMTli?=
 =?utf-8?B?cGlvR1ZiUzBhOTFoSFpDM3dtQjNkYkNzcGRmREVoWXZ3YXdWcXpEYWlITTZa?=
 =?utf-8?B?WnZqZkxQVjRIeUxFR1plZkE0OE41N256WGVuTUEwTnREMVkwb1FuaHU1S20w?=
 =?utf-8?B?bTNSOE1waENTcTdGMVk1bmI1blE1bkM0a3FEMVZJdy96TWpqeWlmaUFxOThU?=
 =?utf-8?B?dEJhWWhkUFlZdmU5eFBvMkxaSVdCTjdPTEQ5UmZUVDVVKythVkZDVXg2N3VM?=
 =?utf-8?B?TWdXdHZXNEhQdFZWejJVV2IxdjU5RG1ienFQOUJZVlZVMlBMQi82KzlnQzYr?=
 =?utf-8?Q?9+Q3gPqrrK/sQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd11ce3-5783-403d-d131-08d901978ab1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2021 11:54:22.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXSOarw+qQbHr4VfSHULaNDK4O+eUHWfsrG+97QAj0BFj4QMGWhNveVF2HOxm23Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3935
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 17.04.21 um 13:20 schrieb Peter.Enderborg@sony.com:
> On 4/17/21 12:59 PM, Christian König wrote:
>> Am 17.04.21 um 12:40 schrieb Peter Enderborg:
>>> This adds a total used dma-buf memory. Details
>>> can be found in debugfs, however it is not for everyone
>>> and not always available. dma-buf are indirect allocated by
>>> userspace. So with this value we can monitor and detect
>>> userspace applications that have problems.
>>>
>>> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> How do you want to upstream this?
> I don't understand that question. The patch applies on Torvalds 5.12-rc7,
> but I guess 5.13 is what we work on right now.

Yeah, but how do you want to get it into Linus tree?

I can push it together with other DMA-buf patches through drm-misc-next 
and then Dave will send it to Linus for inclusion in 5.13.

But could be that you are pushing multiple changes towards Linus through 
some other branch. In this case I'm fine if you pick that way instead if 
you want to keep your patches together for some reason.

Christian.

>
>>> ---
>>>    drivers/dma-buf/dma-buf.c | 13 +++++++++++++
>>>    fs/proc/meminfo.c         |  5 ++++-
>>>    include/linux/dma-buf.h   |  1 +
>>>    3 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>> index f264b70c383e..197e5c45dd26 100644
>>> --- a/drivers/dma-buf/dma-buf.c
>>> +++ b/drivers/dma-buf/dma-buf.c
>>> @@ -37,6 +37,7 @@ struct dma_buf_list {
>>>    };
>>>      static struct dma_buf_list db_list;
>>> +static atomic_long_t dma_buf_global_allocated;
>>>      static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
>>>    {
>>> @@ -79,6 +80,7 @@ static void dma_buf_release(struct dentry *dentry)
>>>        if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
>>>            dma_resv_fini(dmabuf->resv);
>>>    +    atomic_long_sub(dmabuf->size, &dma_buf_global_allocated);
>>>        module_put(dmabuf->owner);
>>>        kfree(dmabuf->name);
>>>        kfree(dmabuf);
>>> @@ -586,6 +588,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>>>        mutex_lock(&db_list.lock);
>>>        list_add(&dmabuf->list_node, &db_list.head);
>>>        mutex_unlock(&db_list.lock);
>>> +    atomic_long_add(dmabuf->size, &dma_buf_global_allocated);
>>>          return dmabuf;
>>>    @@ -1346,6 +1349,16 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
>>>    }
>>>    EXPORT_SYMBOL_GPL(dma_buf_vunmap);
>>>    +/**
>>> + * dma_buf_allocated_pages - Return the used nr of pages
>>> + * allocated for dma-buf
>>> + */
>>> +long dma_buf_allocated_pages(void)
>>> +{
>>> +    return atomic_long_read(&dma_buf_global_allocated) >> PAGE_SHIFT;
>>> +}
>>> +EXPORT_SYMBOL_GPL(dma_buf_allocated_pages);
>>> +
>>>    #ifdef CONFIG_DEBUG_FS
>>>    static int dma_buf_debug_show(struct seq_file *s, void *unused)
>>>    {
>>> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
>>> index 6fa761c9cc78..ccc7c40c8db7 100644
>>> --- a/fs/proc/meminfo.c
>>> +++ b/fs/proc/meminfo.c
>>> @@ -16,6 +16,7 @@
>>>    #ifdef CONFIG_CMA
>>>    #include <linux/cma.h>
>>>    #endif
>>> +#include <linux/dma-buf.h>
>>>    #include <asm/page.h>
>>>    #include "internal.h"
>>>    @@ -145,7 +146,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>>        show_val_kb(m, "CmaFree:        ",
>>>                global_zone_page_state(NR_FREE_CMA_PAGES));
>>>    #endif
>>> -
>>> +#ifdef CONFIG_DMA_SHARED_BUFFER
>>> +    show_val_kb(m, "DmaBufTotal:    ", dma_buf_allocated_pages());
>>> +#endif
>>>        hugetlb_report_meminfo(m);
>>>          arch_report_meminfo(m);
>>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>>> index efdc56b9d95f..5b05816bd2cd 100644
>>> --- a/include/linux/dma-buf.h
>>> +++ b/include/linux/dma-buf.h
>>> @@ -507,4 +507,5 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
>>>             unsigned long);
>>>    int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
>>>    void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
>>> +long dma_buf_allocated_pages(void);
>>>    #endif /* __DMA_BUF_H__ */

