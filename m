Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D863630CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 17:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhDQPE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Apr 2021 11:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbhDQPE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Apr 2021 11:04:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42A4C061574;
        Sat, 17 Apr 2021 08:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaUx2pR6rjvJwjKXy+Sl2xh1kJ9MgTVm7tiYUlENY2NII9F/3G3hrVWL49VX/3OLhevuEYb/L8ZYk9/SxHZUGIJff/641S1LI92ZA26wxJPEr6Xbf4P8Jruc3lMIHpuDbac549H5Rj5bmO0ZWzbJqUeY5H7AuuItbnKp1AwCoYnmTvtsZKxpRwZhtkYjD1p+BhcNGdCDOW4M4fNCw4d2JdgF44DdmEQqgzHHbNWGMsJuzxdAyN4eMquUeuHszhpeAWY6v5cLqg1ajauxrxndMyrfeom7qSAqBmdcB1GDDg/Saciv7Fl4ieDy804KeZ2OK50GaA7CALzNK4k9FJrWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kp4ztWM7lXzkfWHj61qnw2P6A+AJFFVv9ngHnb0SVE=;
 b=BaAfJ/LjyLXkrfE9w//wDPuuv/xnYISb4NYA9MRhgG+XK1c6/A18B/Lr43vQv4629/1RvHHzgVyH38o/cZPinF3eNNQmBGq6oEnKUwqRXJYGMwmJNUAv6HHgLQSJfuWyIP2tShvJyfQ7HDeJrUFDbKaWs4MudyJmAwq9lHKx4Dl1DPrqgpKuyu64sIsb6weXpnV9BnAKt6uDTjOeHdro3y48hYxgyvv1SNI9NWQTMDM/KLlxNk8FizWWr2s/7vzsOY0TMHN4HM43USmTy36ngNx78oANBN+fM3pFWQ0Q3UPDfEmX7MzCu4M+G59zQPJGtybPX7VPT6/lysZuHs2HnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kp4ztWM7lXzkfWHj61qnw2P6A+AJFFVv9ngHnb0SVE=;
 b=bbZj7TFjiJg0fh1hBYU8FHlpk1KRxx2bI7kaDUhOE9DgRbfE/B8yAcqWYUKg5R2aHFo3LJE9K5U2rAFFcA2BrpN0a0S2akNnVYFctFUCqMNKNiGEl2hW/pujl4r+drn9WW9pb4IhzvbmTaswukiH9bk0tqbpCY+nLJlJSAmWkQ4=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Sat, 17 Apr
 2021 15:03:37 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4042.020; Sat, 17 Apr 2021
 15:03:37 +0000
Subject: Re: [External] [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
To:     Muchun Song <songmuchun@bytedance.com>,
        Peter Enderborg <Peter.Enderborg@sony.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, Neil Brown <neilb@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Matthew Wilcox <willy@infradead.org>
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <CAMZfGtWZwXemox5peP738v2awsHxABcpYeqccPunLCZzRXynBQ@mail.gmail.com>
 <ac32baa5-94a5-bf7b-661e-aca66c0850bc@sony.com>
 <CAMZfGtVGvOp4NuAHcVjXB08gfkus+r=iE_oSiWThAXV6zdWBzg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4ae4e646-7e28-e389-50d1-681723d022e1@amd.com>
Date:   Sat, 17 Apr 2021 17:03:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAMZfGtVGvOp4NuAHcVjXB08gfkus+r=iE_oSiWThAXV6zdWBzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:9c98:eafc:2b67:a7e2]
X-ClientProxiedBy: FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:9c98:eafc:2b67:a7e2] (2a02:908:1252:fb60:9c98:eafc:2b67:a7e2) by FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.7 via Frontend Transport; Sat, 17 Apr 2021 15:03:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9804c3e5-bfcb-424e-eba7-08d901b1fa75
X-MS-TrafficTypeDiagnostic: MN2PR12MB4389:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4389E74815E4BF610239348B834B9@MN2PR12MB4389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpNIOUWEjEjk3YE8JeQI+oNvAiuQxG3LKLokq1jmGo0OjRCtpdgQJ6vewiXKiRbuYwBlgPZU4nP3qllAAw3PvUU0muHB5+CeHFTORMxdQDU7CC0b/EDxM0UnCP8N79btsOmdnlZjLBWzJGG2frsFBg1llkTihj8j7+USH6+OcXkLuO7RoBRkGrWmIBY4V1NVksxwxJO3z7nQtgb976Xj7qIVyLx3GTblIiUry4Y1ysQ3cuWJJ1Ba/zIvTaLrZMIW/nDkZyr38X1XlWqFxwynw/rYMNSjdRWEaA3LpWmYpEl0WMw13y1+lFw5qegDi6vz0lrDxWh+CYwNT5Tfyq8fhc09f8ELQq0G/hSdaNblCQ4agZDL5JdDTVc3B2Y6XzVS6lBAgxKiJIgk4/JBqYwGYyqeMa+6yjYFXj+7iV6bmtaxjIr2NKitW5GxPE3G3ZAdz+Wx0WziZrHXEUOh8r4oIi4PiJGOYh4ZlyloDLeACS83dsXq2vTTNKF9kbGkCRdqVqKcrbSB5PUmGaAeGwpuesz7EbA7KGlS+LpEVochMzPHHLq6yUoYRxtA9azWY1D0SiWOSy4w7ReDCR7eIEIg3LywtH/5F2Hfyg+uAXU9E30kshckG8Ye5Ij5Hkd6Tlg+AhjLcNjewA3wYVdVoxJB3LYZj1oJ1eDNe7NywcVmj80tslSXVVDfZ8RWKiE1dts6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(83380400001)(36756003)(478600001)(31696002)(8936002)(2616005)(316002)(6486002)(6666004)(110136005)(52116002)(8676002)(53546011)(7416002)(186003)(66476007)(66556008)(86362001)(66946007)(16526019)(31686004)(2906002)(38100700002)(5660300002)(54906003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bU9FTE45c09FYnpIbkpEYmlXTkZaZjhqMklucnhibzRhVEZhL0UwOFdkY1NU?=
 =?utf-8?B?R1pkTmN2MUl6NjlxMTd3TEtoNmU5NkRTcktOcmdYN3Q0cDJoUEVCUmR6OWJk?=
 =?utf-8?B?MHZTZ2VraDF3S2t6L1c3a085T1RXWTZuMEsvQjZVTFZ5U0loUUR5YzY3b3hR?=
 =?utf-8?B?NXJVK1kwMEhWbTJqdkJ0ejdzS2JmZlREak8wUEtFcXhnUHZaTXMyTk04YVQ3?=
 =?utf-8?B?ME9uZnFKNUlKb0VYWERSNG03QUhtN1VLQzkxZWtqSmRkamFGMERkZ293YVVw?=
 =?utf-8?B?Ry9HdGg0dmk2c2hDT2poR0R3c3JwWm5RM2EySHd0YWVvaW1oSGZwalpTeDN4?=
 =?utf-8?B?YVJ0ZURZWlpjWnpodTZMelYwQUw2UFhZNG5BU1lHcUVSK04valhVSU5xOHZ0?=
 =?utf-8?B?Qk9SZGlZQ3RBM0drWkFUaUkydEhlaHo3NER6cVd0TDhqcU5qWklOdFBkOVN5?=
 =?utf-8?B?Nm1IczEwb3c5L3FOZ0tjdHErQjAyWkc3T2Ftek4wM0xmbmhCeXBQc0pyaG9O?=
 =?utf-8?B?dmpZd0lZTGVKVWh5TTVGNUJpU1pvNXAwbWgzeVA2NXF5Q0UyVEVkcDRIOEY3?=
 =?utf-8?B?VzVGalczOUZIRG85MnhKeU9XRHdyRHB2ZmNSakdVaXBDNFRucFBvUFliSTZt?=
 =?utf-8?B?U1U1MEZrd3c3alVMaWNQK1NaU2VML3ZGbUtqNzNJdHZwVEYyME52cVdZcHp1?=
 =?utf-8?B?ZXpIZitRRXNEVHFPMGtzMER6ZklzUnM2cmVjeVlkbUZWTXVNcGNIc29JY1k1?=
 =?utf-8?B?Z3dtcjU3YTZCeTFsb2p3Z1dsN1BWdk9jM0ZVazQ0QW1PaU45UlNLNmMyZmlN?=
 =?utf-8?B?alB0dHMzOWFzenFSaUxHZHhOaS8yK2Z5YjAyRHhZd0NkQnVVemk1dTdQYnpW?=
 =?utf-8?B?UzI2eVJkblpNYWI4RFZ1NEFrOGRNakg2bWhsbmFOMkdGRVg0eWErU1ZkUENV?=
 =?utf-8?B?Q3RsZkl4cCs4UnpmcjNrQmUyZVpVcGwvUVE5UzFlNTRYYkIvTGI0dGdyeTRl?=
 =?utf-8?B?K0NLUllEWlk5NkUyU0xJdWJNTStqTW5zdUVoOTdWc1lwNFRlTkFFNHpqeHYr?=
 =?utf-8?B?SzU1YlUxaVUxRU5hZVkzNG5vamlEVFpPZzhFTndUdjJJVFZnanRsUEF5OXFp?=
 =?utf-8?B?bGdIOEZjc1BjNHRiUGJNVExDWExSdFFLeHFHNkZSblJNaFRnV3JhUTdtRTQ2?=
 =?utf-8?B?MVNOM05NU1E0TFNUOFJUZUlNS2wzemJqVWc4MEFSR0hkRGtncDU3T0d3aURI?=
 =?utf-8?B?bnpKUFV1Vi9RUkQ1YW9Ha1lsMUk2b1FiTXJ0bkFtc3NXd3lvS2VCL3phRHFw?=
 =?utf-8?B?eHgwQ3BFMWlZVTUxTmpmMTJDZlppWkNTMFlJeWZRUmhSWjJEYzBQYWM0cEli?=
 =?utf-8?B?V3NSMEZ1bHVEVlo3TFZYN1ZFcUxEaGYrSFhkektQb21VWU9tcWVmbWZtNHk3?=
 =?utf-8?B?Y2IyRTlWN0JzV0JZYjE0SW5Jd1k3RVpSRjZLWGNHLzJ1dUR2UE9rUWhtYlRm?=
 =?utf-8?B?Y05UZDJncUhRL3RkZlBBZGJRcW50MGtibTBjZWxUSG55N3RuV0Z2dDlETEZQ?=
 =?utf-8?B?RitUMXFDOXYxMEoyYUN4SXBpMkJWWWdMV1Z5OURZVUZvWVZOQzM5d1pla2lC?=
 =?utf-8?B?WmdDQk9YbzFaWFZTcjFnVkxXSnVVTkpkbTlkZE16UnlDTDNhU3RNUzFPRWUv?=
 =?utf-8?B?YUZVZDY3aVFtL1dGVjFmVDVCbGlhcjlFUVluSndhbFZpTXE0VVJZSFo3a2Zq?=
 =?utf-8?B?Z3Y4NjZvYUNUbytTRkFPaWZZMFd4b1d4c3RzVldnVEpUaHlsNlhCbnZvWXV4?=
 =?utf-8?B?NkhvVHRIRGdGaG5WTGxlSkxjM2p0aitqeXdYNlFRZ2NLM0R4aFhXNUt6ZXJx?=
 =?utf-8?Q?zLyS9WAIbjm3n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9804c3e5-bfcb-424e-eba7-08d901b1fa75
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2021 15:03:37.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOwDU0rmpTpH3+7DL7IpHVFEFhVKGjEt96WJWphEOSOtIvp1b50pNSi7ETph0NcJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 17.04.21 um 16:21 schrieb Muchun Song:
> On Sat, Apr 17, 2021 at 9:44 PM <Peter.Enderborg@sony.com> wrote:
>> On 4/17/21 3:07 PM, Muchun Song wrote:
>>> On Sat, Apr 17, 2021 at 6:41 PM Peter Enderborg
>>> <peter.enderborg@sony.com> wrote:
>>>> This adds a total used dma-buf memory. Details
>>>> can be found in debugfs, however it is not for everyone
>>>> and not always available. dma-buf are indirect allocated by
>>>> userspace. So with this value we can monitor and detect
>>>> userspace applications that have problems.
>>>>
>>>> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
>>>> ---
>>>>   drivers/dma-buf/dma-buf.c | 13 +++++++++++++
>>>>   fs/proc/meminfo.c         |  5 ++++-
>>>>   include/linux/dma-buf.h   |  1 +
>>>>   3 files changed, 18 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>>> index f264b70c383e..197e5c45dd26 100644
>>>> --- a/drivers/dma-buf/dma-buf.c
>>>> +++ b/drivers/dma-buf/dma-buf.c
>>>> @@ -37,6 +37,7 @@ struct dma_buf_list {
>>>>   };
>>>>
>>>>   static struct dma_buf_list db_list;
>>>> +static atomic_long_t dma_buf_global_allocated;
>>>>
>>>>   static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
>>>>   {
>>>> @@ -79,6 +80,7 @@ static void dma_buf_release(struct dentry *dentry)
>>>>          if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
>>>>                  dma_resv_fini(dmabuf->resv);
>>>>
>>>> +       atomic_long_sub(dmabuf->size, &dma_buf_global_allocated);
>>>>          module_put(dmabuf->owner);
>>>>          kfree(dmabuf->name);
>>>>          kfree(dmabuf);
>>>> @@ -586,6 +588,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>>>>          mutex_lock(&db_list.lock);
>>>>          list_add(&dmabuf->list_node, &db_list.head);
>>>>          mutex_unlock(&db_list.lock);
>>>> +       atomic_long_add(dmabuf->size, &dma_buf_global_allocated);
>>>>
>>>>          return dmabuf;
>>>>
>>>> @@ -1346,6 +1349,16 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(dma_buf_vunmap);
>>>>
>>>> +/**
>>>> + * dma_buf_allocated_pages - Return the used nr of pages
>>>> + * allocated for dma-buf
>>>> + */
>>>> +long dma_buf_allocated_pages(void)
>>>> +{
>>>> +       return atomic_long_read(&dma_buf_global_allocated) >> PAGE_SHIFT;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(dma_buf_allocated_pages);
>>> dma_buf_allocated_pages is only called from fs/proc/meminfo.c.
>>> I am confused why it should be exported. If it won't be called
>>> from the driver module, we should not export it.
>> Ah. I thought you did not want the GPL restriction. I don't have real
>> opinion about it. It's written to be following the rest of the module.
>> It is not needed for the usage of dma-buf in kernel module. But I
>> don't see any reason for hiding it either.
> The modules do not need dma_buf_allocated_pages, hiding it
> can prevent the module from calling it. So I think that
> EXPORT_SYMBOL_GPL is unnecessary. If one day someone
> want to call it from the module, maybe it’s not too late to export
> it at that time.

Yeah, that is a rather good point. Only symbols which should be used by 
modules/drivers should be exported.

Christian.

>
>>
>>> Thanks.
>>>
>>>> +
>>>>   #ifdef CONFIG_DEBUG_FS
>>>>   static int dma_buf_debug_show(struct seq_file *s, void *unused)
>>>>   {
>>>> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
>>>> index 6fa761c9cc78..ccc7c40c8db7 100644
>>>> --- a/fs/proc/meminfo.c
>>>> +++ b/fs/proc/meminfo.c
>>>> @@ -16,6 +16,7 @@
>>>>   #ifdef CONFIG_CMA
>>>>   #include <linux/cma.h>
>>>>   #endif
>>>> +#include <linux/dma-buf.h>
>>>>   #include <asm/page.h>
>>>>   #include "internal.h"
>>>>
>>>> @@ -145,7 +146,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>>>          show_val_kb(m, "CmaFree:        ",
>>>>                      global_zone_page_state(NR_FREE_CMA_PAGES));
>>>>   #endif
>>>> -
>>>> +#ifdef CONFIG_DMA_SHARED_BUFFER
>>>> +       show_val_kb(m, "DmaBufTotal:    ", dma_buf_allocated_pages());
>>>> +#endif
>>>>          hugetlb_report_meminfo(m);
>>>>
>>>>          arch_report_meminfo(m);
>>>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>>>> index efdc56b9d95f..5b05816bd2cd 100644
>>>> --- a/include/linux/dma-buf.h
>>>> +++ b/include/linux/dma-buf.h
>>>> @@ -507,4 +507,5 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
>>>>                   unsigned long);
>>>>   int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
>>>>   void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
>>>> +long dma_buf_allocated_pages(void);
>>>>   #endif /* __DMA_BUF_H__ */
>>>> --
>>>> 2.17.1
>>>>

