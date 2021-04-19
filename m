Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F15836485A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhDSQhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 12:37:52 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:19425
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233466AbhDSQhv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:37:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMIwll8sjfTblxn98JByu95PL+bQhH3ZD2dW3f8cPao7CBfnKi2sLeM3yMFKDaz9lr/Jkgk7H2xzrUvKrPEZpxYjgePvVtbHdieAcECK3WFvr5VoyV22t+V4O4MltOhCgwWEOGv9O9iROOSK7zM8nBRkiPX5wHN2UM3l89fLAo04jzuJj768HZPgb2N/sJO1CSEfAC/F0H7hHf2oTztln7YpSkZfv2WuUB1jAm8DPQ70unGlDXDuJ2XsWSYNHWgg2PAY0F/Lto5ynTklsMSTLYBrtQS6e8tCVEsoMtfHaffAUU0Vw/GkxVxkjEnv+uUC828Yez8L6+ChI2AmnJ32jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cUTKTWaVC1vqnQuTnkMNLLdwVl9DCeXd1QpcBZ5SCQ=;
 b=I16SituQH9ZUcGGknETRT4NrR0eUPoU52vYFBWBgUyLx+8efIzXCROBTjyj8sfqTJgU9tAKJNV2ug6hE0WxbCgKNoro8wHQ6/fTIALzzylpublxSwZo8fKaqc/RlHRFb/aTnED66FU0aNT07tihjCQEWTipvP+ZBGXxWdu6S+vnXYBdG9mRx5fCTVIm+XZEa04ygW9IIF/AurN5aNdrdQci5Q1VaOK2WlzOrDRgcneho06e6WacEqmuhtnQhuMGtTSinJbV337Wig32C0jDf99rV+LW1MTr4+tUTjdLgGulQNgjrZG+ofkKyGUGY3KAhIFvwhDRSiiExcetUhWpIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cUTKTWaVC1vqnQuTnkMNLLdwVl9DCeXd1QpcBZ5SCQ=;
 b=r1DL/IGZeVFJuIdVnwgtgfKKqLwn7/xRQQywlwKqdgBiV/hw8pmoYpVpXB3DVTaMXDwgeJYtdx+l+B2lDTniB6zUSdFExtxLz6dAYW+qAxJqj/xqgpBOG0ODUhu2Awa+IBXl09mfOpTnq4HbbBpyhoRHEJNlJaQeNX2jXrqjBF4=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 16:37:20 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 16:37:20 +0000
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
To:     Michal Hocko <mhocko@suse.com>
Cc:     Peter.Enderborg@sony.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sumit.semwal@linaro.org,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        neilb@suse.de, samitolvanen@google.com, rppt@kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, willy@infradead.org
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <YH10s/7MjxBBsjVL@dhcp22.suse.cz>
 <c3f0da9c-d127-5edf-dd21-50fd5298acef@sony.com>
 <YH2a9YfRBlfNnF+u@dhcp22.suse.cz>
 <23aa041b-0e7c-6f82-5655-836899973d66@sony.com>
 <d70efba0-c63d-b55a-c234-eb6d82ae813f@amd.com>
 <YH2ru642wYfqK5ne@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <07ed1421-89f8-8845-b254-21730207c185@amd.com>
Date:   Mon, 19 Apr 2021 18:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YH2ru642wYfqK5ne@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:613d:4350:cf5f:466]
X-ClientProxiedBy: AM9P192CA0005.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::10) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:613d:4350:cf5f:466] (2a02:908:1252:fb60:613d:4350:cf5f:466) by AM9P192CA0005.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 16:37:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7bdceb5-f00b-448e-927f-08d903516684
X-MS-TrafficTypeDiagnostic: MN2PR12MB4335:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43357700A54EC00F6A486E4883499@MN2PR12MB4335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXo3WcHaCqlr1sHKUBA0oZm2vPCiOyqV6WwkrT/LQw6+uhq0LuWrur5gzkPHkKySsc3slO0qW4DjKw5WfHmYHuLVDtgJAL0LWUB7bXJGJ3FGPXMLzFDOlqPNzxfFEt+dneLCp56X7Tuu289uCOW4vRj0dESYC90SXCH4eNe9CrV7mpZLEt1AG5kph8OD7v7xnltKcP+mgWRMiB7MNIlqkT/+12Vc8CFrGp5YNbj8oCCfMNelB/TpANmJdOq7lsJJwcoCmU+GUz1WKA7RmQjCcOwgocRibcMQrNMEd6zIXgYE//2PEVz8z0joxLund9sWImGvxSPSZnL8pNvK15DLfwQfSgAFUmqo6Qf2o7NdQflvzymlKA1ctbu0gc2K7OTjshxySUECq/wWB7XYuKzShe2GH/Q9gsnNiKx17mgFTBg6aLYfu6i2Pr6rWALjmXqzrdx2euh5ZDTvvBUIyfBvxPrZ6VGfrC3QQ0lNyiRxwyRuPIaqENwpzKab+MstpFXeBa7kFAC7H25qQJvrY2ez2oXEBSYNyZBk1zdUFqWzyruA7Cn9OvyBjzHrMwkfpQUb2JSdtRfu96TLeCCudnB3OehUiIH4srIw2FzwknatKAzwMaXRwNAdkxQMTFgr/UIzx4obS2lgAUzrYOaVKwVGvhz6+3wSVFvJg9D/UrkSv9WjqEO2dtK21YP/sexV6Npg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(66476007)(16526019)(8676002)(66946007)(6486002)(186003)(6916009)(2616005)(66556008)(478600001)(86362001)(7416002)(83380400001)(8936002)(2906002)(4326008)(31686004)(31696002)(5660300002)(66574015)(38100700002)(36756003)(316002)(53546011)(6666004)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dWp2YVFDeHJwYldOaFBYVzRCbzFiT1JvQ2MySlVOSHRwMkVhcC8yOG5Rcytj?=
 =?utf-8?B?NldpSzNxVlI2Wm10SE1iWWtpdVJFeVhOTVZHdkUzZlF1WUZDNElyWHpQZHBQ?=
 =?utf-8?B?MzB5aUhuNHQ2UUZrUW1qQmhRUDh1Z3VsdFk0cW0yOUgrT1kva0ZacmlXbitT?=
 =?utf-8?B?bXJDbk1XVkhhTnRGUVk2ZnpNZEo4aElwQ3BmYUNCbkg3aTlGWVlVZFptZUUr?=
 =?utf-8?B?RDZFcm0rNFJuSTQzS3lycGhSQVQ5WmZXaXIxL1ZkWDJkT2dqcllFRVV3SGJm?=
 =?utf-8?B?WlRidzJiNmExUzJNMVl6TEdNVUlTbmlFTnd1amR4MENPdkUvbUM0dUJndGFO?=
 =?utf-8?B?RDQwRTcySHlCTVRsdGgrVHZBVm5teWZMcFNvdlJVdkE1bXJFQTYyTTVJbEZO?=
 =?utf-8?B?b3ZvbS81QlN3eDBSWGM2TUJpaHBVcjdINU5rN3hoVHFuRnF0czFiWEtxOVJ6?=
 =?utf-8?B?UDdlMmxITHRqZTlxT21pR1hxOURUdklZb1g1UFVoZE5ubDVWajRERFdwWTdl?=
 =?utf-8?B?ektIUk1Lay9vTkxNNlVPN3ByNHdVZjdJYlo3YVdnMEFsTCtPblVjaFlYaXpH?=
 =?utf-8?B?d3BaWDVic21sR0JDaTZVT0xVLzlhSFVUK3hKaDUzL2lFNzJPckRqZE44aUlT?=
 =?utf-8?B?eUM0YnZlTXlLZGY5VzVGWmZEdDlERmFySlFSL2xMQ3UwTDhyV3R0b3Q0THM3?=
 =?utf-8?B?NkEwVnZoV2NJNTVkT3RmVWd1NHVCM0dTQlp2MWR4dGdpU0RhVG9rOHJMeTFM?=
 =?utf-8?B?Q3dNSEpRZC9sMEkzZFZSSGtWVUFHSFZabGRYanZSUVVOYXhaSWxqWFJNQmg2?=
 =?utf-8?B?Qkc3VjQ4WGlUQzNiUjVKWWx0OStPT2xsTVVBRHJpaGUrTlVrbHdyaUZwZzBj?=
 =?utf-8?B?ZHgvaEtSUUpUdE90TVA0REQwa1JJVlBHMWZBdkhuM0pHSHdISVN2RWZ6d0JP?=
 =?utf-8?B?UkU2YVVHQ2E5ZkE1OThkZ1lGYWNKREpQeDN4VUIzQkE5cld5dmlwL2EwcEZN?=
 =?utf-8?B?b0hxY0poa0pSbVdYWkFQRnhWaU5KeDZ0cEtNTENYUmY0OUExVXJObTZhZUdN?=
 =?utf-8?B?eE1Yd1NKWmo0NFVLUnJTckYxNnR3ak9yVThOa1l6TjY1U21ma1F5ZXpJcGNO?=
 =?utf-8?B?NGdJY3Fxd05YNXNFK1ZtM0ZDdUlUNTZvMVlXRjMwSHZ0UXpqOW5HWmlBR2g2?=
 =?utf-8?B?bHZQWlMyeEo0Vjh6TkJEY1U3YnJpeHNjSUtCM1dsdTVYaWF3Njk0WEFNNEZU?=
 =?utf-8?B?TzdNMHpCbENSemtLQ01jTU90RVVWMHUyM01nbXduYWFlVDdyVnNOVkN3dzda?=
 =?utf-8?B?dnA4VUZUZFdYWFk3ZEh4Uk9qZU0wNDFrRXRrT3Z4Wk1JSkpUR1N0UkhkbFpR?=
 =?utf-8?B?NStWQ0I3UHBRK04yT1JCaEMzZ24wS1ZXd0owcmlMTjU3V3VJRzRzWFY2R2tW?=
 =?utf-8?B?TXJydVRtdGZMWWY5elQvOTVXS0F5RlpkL2ZEamdUM1M0NUN3R2JscmFTOWxN?=
 =?utf-8?B?RTMyeTYzNlBtT2FUSjNRN0VWcDBObkFKM1BRSDhiVkwyVjNqWm8ya1pmT0ZY?=
 =?utf-8?B?dEtDc2FHcDBIVWxoZ1laSWt5WU1pYis2R20yUS9obFNPRVFRWkRsSWlTTTdI?=
 =?utf-8?B?SUc0Y3RqQVNTVmlRUG1laUtwK0tYbEZpUEhpVXNxWVhsR2NDbGxYcm9Bdy96?=
 =?utf-8?B?c0RjdnBrb05MVkMzRHR0Yk9IRk85cStuKzNnaGo2OCtZMlFrVWNOeGZFSHhl?=
 =?utf-8?B?ZlY3VGR1M2xDbVVXRHd0OHdzMHRyRnovczNuVWR3M1dxN3U2TzNPVWY3M2JC?=
 =?utf-8?B?aTExM0FXYVU3YzByd2IrRVZ2N1VEOFEvc2ozVGlnQm85eFRZbDduWEp6ODRo?=
 =?utf-8?Q?qFV2fB0kwoJL/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bdceb5-f00b-448e-927f-08d903516684
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 16:37:19.9712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDGqjhPbFOjOYv4ZLDtLrnZo66OP+T933ge0SmY0gPrekSZXjxYsdMltNbtQB1w7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Am 19.04.21 um 18:11 schrieb Michal Hocko:
> On Mon 19-04-21 17:44:13, Christian König wrote:
>> Am 19.04.21 um 17:19 schrieb Peter.Enderborg@sony.com:
>>> On 4/19/21 5:00 PM, Michal Hocko wrote:
>>>> On Mon 19-04-21 12:41:58, Peter.Enderborg@sony.com wrote:
>>>>> On 4/19/21 2:16 PM, Michal Hocko wrote:
>>>>>> On Sat 17-04-21 12:40:32, Peter Enderborg wrote:
>>>>>>> This adds a total used dma-buf memory. Details
>>>>>>> can be found in debugfs, however it is not for everyone
>>>>>>> and not always available. dma-buf are indirect allocated by
>>>>>>> userspace. So with this value we can monitor and detect
>>>>>>> userspace applications that have problems.
>>>>>> The changelog would benefit from more background on why this is needed,
>>>>>> and who is the primary consumer of that value.
>>>>>>
>>>>>> I cannot really comment on the dma-buf internals but I have two remarks.
>>>>>> Documentation/filesystems/proc.rst needs an update with the counter
>>>>>> explanation and secondly is this information useful for OOM situations
>>>>>> analysis? If yes then show_mem should dump the value as well.
>>>>>>
>>>>>>   From the implementation point of view, is there any reason why this
>>>>>> hasn't used the existing global_node_page_state infrastructure?
>>>>> I fix doc in next version.  Im not sure what you expect the commit message to include.
>>>> As I've said. Usual justification covers answers to following questions
>>>> 	- Why do we need it?
>>>> 	- Why the existing data is insuficient?
>>>> 	- Who is supposed to use the data and for what?
>>>>
>>>> I can see an answer for the first two questions (because this can be a
>>>> lot of memory and the existing infrastructure is not production suitable
>>>> - debugfs). But the changelog doesn't really explain who is going to use
>>>> the new data. Is this a monitoring to raise an early alarm when the
>>>> value grows? Is this for debugging misbehaving drivers? How is it
>>>> valuable for those?
>>>>
>>>>> The function of the meminfo is: (From Documentation/filesystems/proc.rst)
>>>>>
>>>>> "Provides information about distribution and utilization of memory."
>>>> True. Yet we do not export any random counters, do we?
>>>>
>>>>> Im not the designed of dma-buf, I think  global_node_page_state as a kernel
>>>>> internal.
>>>> It provides a node specific and optimized counters. Is this a good fit
>>>> with your new counter? Or the NUMA locality is of no importance?
>>> Sounds good to me, if Christian Koenig think it is good, I will use that.
>>> It is only virtio in drivers that use the global_node_page_state if
>>> that matters.
>> DMA-buf are not NUMA aware at all. On which node the pages are allocated
>> (and if we use pages at all and not internal device memory) is up to the
>> exporter and importer.
> The question is not whether it is NUMA aware but whether it is useful to
> know per-numa data for the purpose the counter is supposed to serve.

No, not at all. The pages of a single DMA-buf could even be from 
different NUMA nodes if the exporting driver decides that this is 
somehow useful.

Christian.
