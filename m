Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3684036474F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 17:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbhDSPox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 11:44:53 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:32897
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241324AbhDSPox (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:44:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu/ZII2nZcttI5bPel36puuX8v28GxUu0gVoU8+LYVNnbIiDI0ZvDKsdG2mRTPxHHiuLmUR2vDqI0SZ+QyslMaM/jgFH8yhPcp+K/6an0U9zAjc6ZDbl1GFareEv2bXNA81JwOz8ZozovVCJx0OoDyqShH5tFeQ1KlHb8tGdTOR1zunnNLLu2gdCBBZnq4zRd8GaJUFMKr2UbsQE2bonjYTeR/tE5nzYluNTJd2+D8oQCady2jzCrwOw+UdJqJGy23G2p6NyZw9v9PqqOyX1zkz0TAW6TnwkwxI8QGE8CmULyrGinKQkO5oFdD2Jlyp6V/y5mM51vWLfaZuKPyHi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sk19Q5PT636BCck0vsx1EQinxQNipqKTiyCPZKO6fg=;
 b=MKW30aLvb31Ps6WaQFPAnT/AKGxTM4NA93M8ayKsclH/d17PNLSGSFlAH4foIXIhRVy/JzB9oTlIjdLOqfjJXdVIyZ8Dc4soerwcg82FXyHl4ThsLTambB1rtyeE3Ll4lOrnhG3dLNZqq/F/fa8X+BG8yX12YYcR2EF4qCtzjZDoTAmnpwSFP7SVbd5rp0kRnBV5BTJyfJrJTiObaa1ri2ldfqZw3g6dEeI5RXbZEC9HrVYD/A7sxNyamoD6dnmrKsAj+/kOxOFY9f0/x/cb8MoM9IJP9SpH+Rz+Vf1G9pdDIWu3R3FVDL2ft9ZNoqnZP5ltjeYkBcxeL8yGqchWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sk19Q5PT636BCck0vsx1EQinxQNipqKTiyCPZKO6fg=;
 b=WveRNIAgDpLyvP74+QzwrfdKyO4zocdRtGbAwTORoq+vArTRqx+rHtO2pGfpbD3OzNzaUCMLgO+n49Jz/Xyaz1YWI3QoMu7/VWGvgb69mqDGoqw9/+zuIWffrqBVoKwnpZ9g9/KOsstKXdWjWgUKaAocUWgD1hiTRMfJnJfZwZg=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 15:44:21 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 15:44:21 +0000
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
To:     Peter.Enderborg@sony.com, mhocko@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        sumit.semwal@linaro.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, songmuchun@bytedance.com, guro@fb.com,
        shakeelb@google.com, neilb@suse.de, samitolvanen@google.com,
        rppt@kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        willy@infradead.org
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <YH10s/7MjxBBsjVL@dhcp22.suse.cz>
 <c3f0da9c-d127-5edf-dd21-50fd5298acef@sony.com>
 <YH2a9YfRBlfNnF+u@dhcp22.suse.cz>
 <23aa041b-0e7c-6f82-5655-836899973d66@sony.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d70efba0-c63d-b55a-c234-eb6d82ae813f@amd.com>
Date:   Mon, 19 Apr 2021 17:44:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <23aa041b-0e7c-6f82-5655-836899973d66@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:613d:4350:cf5f:466]
X-ClientProxiedBy: PR0P264CA0204.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:613d:4350:cf5f:466] (2a02:908:1252:fb60:613d:4350:cf5f:466) by PR0P264CA0204.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 15:44:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3862061-448d-403a-1b54-08d90349ffb6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4303:
X-Microsoft-Antispam-PRVS: <MN2PR12MB430329D1E47E7CE6C123DF4783499@MN2PR12MB4303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5wY/4oZKETffrGcfV+ZLGvbTyo4MXmJlqakUUrUw0v8DSmQxB0TLhAET9sqfIVAFqwTy8D6HJdctdmGYaUQ/xMAXXKbcaIU2hJWuJCfJkYVKiJSXUwk8H9lT6RQ4qviOYAhDyZPV4G09SrivJW1Fc14QJJQKqIUr+TAoCJiI4UTCiHgSZpcMGrYer9j3L5l3PE1fFNR2NtV6HHi5mT8o/doNWy55EqgA1epbmlZIVk1wXIHMZvV4efXnNq4Zqb1ZBAvkxKeCvSVtzOYNz6VWAB+TWNsZH/Udaba4KZooC3YeHOjMDPmdtiqHY/NIekeG2K+FC9D6q78xBcUPpikA/BeKS10c337I09YHEkV4nd7FresONQ/BwnDRvpccqMMLTvtITeteB1g1Y0X7ouPBNeb5Q9frhNBlZXnEjIuP5RR9dtOz5SCNghAm5c17HKMBk9ma9cKE+C92YIgzRrX1dGZNbDnCWbbh4kqy/2YlTdoKpyonpXedcwQcLmCKhBxitAcHYb0kVVoD7DhfJC9H79b+ajxNxilP3FBdtbshYIvtrgttyUxbwn692CIBg+SX7chWGgcsfxvZtCkYGq57y2Y9CJQFzIDM0HF/o78ovact5T0nA9HtsdlXOAi2jGymKIMPCk3EJ/FuRirkgBowQaWG/52NlFij7+6D87sCUpvZZ92xuWCtBMq7MGorooO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(53546011)(83380400001)(7416002)(316002)(8676002)(5660300002)(186003)(66476007)(6666004)(8936002)(2906002)(66556008)(2616005)(6486002)(52116002)(36756003)(31686004)(478600001)(38100700002)(31696002)(66946007)(16526019)(86362001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VGhBZHh0Ni9mZy9mTm56Rkx3RFl2eUZLWERTcTQ4azlqTUNqZFlCQWtaaGZ0?=
 =?utf-8?B?ZDNzNFdqUnYwamFCSlQ4aWdpY29zSjIrNkI1b1ptSWg4RHRhL3lOUlZVYlFX?=
 =?utf-8?B?alNJOTVsSXI0cHF5N0FOUnVVVUpCQ01MNFZWNCt6REs4OS9GRXZjZHRZV242?=
 =?utf-8?B?UCs0SHVFZXNhMElFMXhpYmNvR3o1Q2tHaTV2SmNxc2RPc2N4YjhqMnpCQ0ZH?=
 =?utf-8?B?MlZhVExQcWM2alBwMklPRjlLcS95ZWRSc20wZjNEbnpaSE5zSnc5YnJycEFY?=
 =?utf-8?B?VXU5N3R2MEF4bFBiNFZ6TlZIc2FiVU1SVFk1M2kveDdFZzBKaFNJT1RLakM5?=
 =?utf-8?B?UGFUYUs2MXlJQUNMWXMvSDRIM0cvVGJNb0FOMHd3d2srVHdKdzdmMzZOOFVz?=
 =?utf-8?B?cnhHWTh3c2h6dGZLRFdSSkMxTmJUa3FTU0tOTjhhV21VWVJDdDc1dFNCZjJU?=
 =?utf-8?B?UVpFSzNWeXFhMDV2MUhMYXBKZmpGVTZtT0haamUvZSs4YnZsRG83ZjhuWmFn?=
 =?utf-8?B?Vlg1NjI0aW1iaG5YTnkrYzhSVVVSNlFjOURzK2x5dTI2WVV0djF5M29PS1ZC?=
 =?utf-8?B?TGF2bHJES05XQnVaT3hrUTVMZWQ0QW5Obm0ySlRrbUJQbnNSS2p5eXhzVFRy?=
 =?utf-8?B?SUgzTk1VcFFEWklzRHFqK2lQaXU5ajY5UGxmdzNXb3lGS1l0Mm9Ia3hVUTZU?=
 =?utf-8?B?ZWpxaU5zWVVsNWszRUtxOWVpSC92NU12M3NWSTJJYndmaWZEclg5V1hmZ0Rh?=
 =?utf-8?B?ejJZZC9MaUVtaVNHZmtwZmEwRnpkOG5ha09meTJ3NFJIanVhZkZ3aWRDcm1j?=
 =?utf-8?B?ZHRYb09jbXlyS3JyWFlzVHpjcklyQnBleW5qSDBhNFVmYnl6eVpWblZBdU1C?=
 =?utf-8?B?L2UrNlV2L3U2RXpWTy9JUXh0OU4wbkM5QUxZTnRjMHFCdzhjS2R5ck5RaTIr?=
 =?utf-8?B?cE1XekxqbExjSGxSWWdCRllodFNoZ2V3Tk8wdDJLeXgxWjdMSTkxNWZ1THg5?=
 =?utf-8?B?TXliVXp6RE9KSTlEOHllMjB4VGxLSjdGM1NMdWtUVEJLdjVJR1RhOGZiSE5p?=
 =?utf-8?B?Y0djRXV5V0tKVk12R2hSTkhVaEc0eklFUmVUa0xCQmJ6WldLcjkyUTlnQmJF?=
 =?utf-8?B?QWR4U3Y2T1QzYXEwLzZlOGUyQ1Q5WWQ1eTdicHRFNjUxVVZVSERldnNBZi92?=
 =?utf-8?B?Y09qTFBWVGFka1g5V0pOVDBrcVg5dmlGdkNNUUVUOE13L2FIelprVVRsd2tY?=
 =?utf-8?B?OVdFSW12WHNRTUJIRzJGc3Jrd2FlRGpHWWJjUkRsUDZoRUNWc3hZdFFKMy9Q?=
 =?utf-8?B?Zm1uMVIrLzFKQ1ZRUTk3b2NITDBrTFpZYW5vZDhId0l5VlFITTJxWXRJUXVS?=
 =?utf-8?B?WTJ5R08rc3dMV3pOYmVIcHJHcmJzUHpnRFZrSTRuMWUzd0xwdzRrb2gvcXdY?=
 =?utf-8?B?dGhqMUQ4cUR1eFQwK3VNNkhZRnRSM3hURWkxam83aFE1ZGdBM2xGMjhhUUdr?=
 =?utf-8?B?ZTByWXZSZjZITEtWMGJMYmdiQlRvNjZGWTh3dXZoN2Exa0JIL0V6UkdKZVdn?=
 =?utf-8?B?OWVva3RwWnBqbEh3dkFMTmg4bmdJRkQyTEJvNlZHUWFwaHJsMk15dXFackhr?=
 =?utf-8?B?NHF3SCt3ZjhDSGFPOEtkaDgxYWZQN1FuMmZ2dlJmTk1nZTExd3AxVm1XNWls?=
 =?utf-8?B?U2Q1eWFSMzVmcU0zb005cTdKeUI0UnFaNHBmbUVLTE1KQnlrTkg1OGtyMk10?=
 =?utf-8?B?QjA1ZldoZXBVd2FRTDVtWGpScVNhODAwUWxXVURhKzRPZ0MzdzNMV3Rpci91?=
 =?utf-8?B?Y0RCTFVCbkdxcHB2QXBDRkdlYTVTSTNGczA2RTBtRmltNU5ScWFpRytSWE9h?=
 =?utf-8?Q?v2tb0NPbwyYAj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3862061-448d-403a-1b54-08d90349ffb6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 15:44:21.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSzXoAznVwcIcTHGWgfDCb3zAZmAw+9vTpW7ZaZwDGll4wHrEH1Jl72phA/pvYPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 19.04.21 um 17:19 schrieb Peter.Enderborg@sony.com:
> On 4/19/21 5:00 PM, Michal Hocko wrote:
>> On Mon 19-04-21 12:41:58, Peter.Enderborg@sony.com wrote:
>>> On 4/19/21 2:16 PM, Michal Hocko wrote:
>>>> On Sat 17-04-21 12:40:32, Peter Enderborg wrote:
>>>>> This adds a total used dma-buf memory. Details
>>>>> can be found in debugfs, however it is not for everyone
>>>>> and not always available. dma-buf are indirect allocated by
>>>>> userspace. So with this value we can monitor and detect
>>>>> userspace applications that have problems.
>>>> The changelog would benefit from more background on why this is needed,
>>>> and who is the primary consumer of that value.
>>>>
>>>> I cannot really comment on the dma-buf internals but I have two remarks.
>>>> Documentation/filesystems/proc.rst needs an update with the counter
>>>> explanation and secondly is this information useful for OOM situations
>>>> analysis? If yes then show_mem should dump the value as well.
>>>>
>>>>  From the implementation point of view, is there any reason why this
>>>> hasn't used the existing global_node_page_state infrastructure?
>>> I fix doc in next version.  Im not sure what you expect the commit message to include.
>> As I've said. Usual justification covers answers to following questions
>> 	- Why do we need it?
>> 	- Why the existing data is insuficient?
>> 	- Who is supposed to use the data and for what?
>>
>> I can see an answer for the first two questions (because this can be a
>> lot of memory and the existing infrastructure is not production suitable
>> - debugfs). But the changelog doesn't really explain who is going to use
>> the new data. Is this a monitoring to raise an early alarm when the
>> value grows? Is this for debugging misbehaving drivers? How is it
>> valuable for those?
>>
>>> The function of the meminfo is: (From Documentation/filesystems/proc.rst)
>>>
>>> "Provides information about distribution and utilization of memory."
>> True. Yet we do not export any random counters, do we?
>>
>>> Im not the designed of dma-buf, I think  global_node_page_state as a kernel
>>> internal.
>> It provides a node specific and optimized counters. Is this a good fit
>> with your new counter? Or the NUMA locality is of no importance?
> Sounds good to me, if Christian Koenig think it is good, I will use that.
> It is only virtio in drivers that use the global_node_page_state if
> that matters.

DMA-buf are not NUMA aware at all. On which node the pages are allocated 
(and if we use pages at all and not internal device memory) is up to the 
exporter and importer.

Christian.

>
>
>>> dma-buf is a device driver that provides a function so I might be
>>> on the outside. However I also see that it might be relevant for a OOM.
>>> It is memory that can be freed by killing userspace processes.
>>>
>>> The show_mem thing. Should it be a separate patch?
>> This is up to you but if you want to expose the counter then send it in
>> one series.
>>

