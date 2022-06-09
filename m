Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F9544F0D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 16:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244976AbiFIO37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 10:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243439AbiFIO36 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:29:58 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED76A1EDD33;
        Thu,  9 Jun 2022 07:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lzv2rx70dIdUtR01WmJM2dDmScFYiFT5wfwVFh8f6c9WFxaRIcJVR2KMjZMbhKpaJDrftqN6C8SDujid1XM73rYjpppmbk68iMfiOXGBsOqwzCUPGCMJf1eIdJEu6xAsNuf2VntjWvG0l+R8R5BJmiXv4IMztjLelYPvd25BmGA9h6IqfcMchCnlSLjg7XmZf7+pDl4ctLvTjrxZPifdmNSiiRgIohaSRHvqCKuRsxgWCfR0e1LKIcRSyB1onVQb+9oAiRgvqaKv8Qd+5s49ABCQb32qnzKBQEWjdWyg5TP3NrljLKUlru03Jfu/R86k+2DkfOynNqubd4j0lpZhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/clUFfaHbe/6UVswTMCVE6ssoSsiiD5bk04vZJHDTs=;
 b=B+chv6ZIuGtu1C/fLKmuBPIW8StwVg71ggSdDqGcQrrBvvUYNrbciLuMgreFC8eo2o941PzRl+OO8sUVaT6Lvs/gBXrUt8sJcoWKD5hUPKqNgoUDGrC0pW3MSqBpKnhxEoAFhF9Zri/XNGJYvLleXhC8B1++BVc4JQQ5YjaGLTayVkNuU74OiBhc1p3eyFxKiyr+wG4WAr+Qx+mYbw+2BlfzZyKHhDgU7AvzhdfHbDLJ73uLODg0tmUfFM05dTw4RaPNVbBiHKBQwgUFCqHorW6J3jGY5c4JG1mpWS1ujQdglKVtGI7Sav7r5sq1fCE2bAAPfMAJz6viVDrQBfeCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/clUFfaHbe/6UVswTMCVE6ssoSsiiD5bk04vZJHDTs=;
 b=KnxJcDwBktv9vRsfrhh+WdG3Pz0WzDUxoUu0HF35dERQQ9pGY765Iam2r2z5S9s98ZTqkZ8f7OvPhcOHWiA1Mia+BgtMjaCc+HejjloG9J3woGwzGWQYNqopg0KKmfqydHzPDsesI+bGPRJ44MLI3E26sFcUKqljhR3bn3Kd1E4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY4PR1201MB0071.namprd12.prod.outlook.com (2603:10b6:910:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Thu, 9 Jun
 2022 14:29:53 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:29:53 +0000
Message-ID: <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
Date:   Thu, 9 Jun 2022 16:29:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
References: <20220531100007.174649-1-christian.koenig@amd.com>
 <20220531100007.174649-4-christian.koenig@amd.com>
 <YqG67sox6L64E6wV@dhcp22.suse.cz>
 <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
 <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
 <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0301CA0001.eurprd03.prod.outlook.com
 (2603:10a6:206:14::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71cbccbc-8ae7-401c-070e-08da4a2484b8
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0071:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0071CFA353E81AF17041CA9483A79@CY4PR1201MB0071.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvdW+L0/GbJE/cH0LzSzAgg8gravNlYhC7ukfEI+klAYhtZzMQmgopRzU0U4JpNVk2m+MDYHRjHxAXG3g7d3/pky4dkYuaPJeDeWTT4ArEMEP1fjYsTBr2LIKWvyS6FuwlyNmc4rcPDEw35CPGMQTEQ5j5fMBClCVFmJMLoFkCpp6fcwK0/2FS5F2cWbWmNwUXdKv5j8VfKuFA78gbrBrrPHd3JoE+xeWbI2Fb8Xp+wO9qn9Ka38QLL1Ciqsbl/8D0NdM50Quxvzzl6I5PrTW82XqD+Klg1IhSQyxaI6ib21b/iSy4EdPehxyRc87VIAn4GXuGed5kx/IKAHPCK7OLZvHLiIS0RHtqaBiTu+K5P0r+Z+1R3YlUyqWCZjnNZyq8hSETfck14j1ppU5NXCwWrMnQsr+Vepwi6K0L2OeOXDSbg801RhSr8UCmLtyBehY1p2i9qbumx9V2mu2E2q3Krco+2IJNtTI/GDVhYrXOLbBAJhimRf/F2P9Mik66cs9AWplJwYdMimoNW8XRZPjJGhS59vEhC+lh+uGBqoDw68/ibLTdtSe6BkrNk8IF1oykcsr+KhSl7E13+FSPGjp1apI/Cg6iWlrYpIxVwV/F9ZICiWcbxk8mnKu8VrM05RM+AcLXzvM/4bUdTTsWMnIDQQElXo/fVjkSMyNwFMxYoUB0ubADJEqcTMh+Sbg7TmwLtr79ipshdjKDLFan6OhBOL+sL1TksqVkBPG2vYi0fCxNshEhvo3WszLPF0hJ7W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(186003)(6486002)(36756003)(31696002)(38100700002)(2906002)(110136005)(316002)(31686004)(4326008)(66946007)(66476007)(2616005)(66556008)(8676002)(86362001)(5660300002)(83380400001)(508600001)(7416002)(8936002)(66574015)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NllGZ29EMmo0VGVUSElSWnUrN2tvTFNkL1dQVUlIa2ZLQjNYWkM0SGdOZWIz?=
 =?utf-8?B?bE05ZnE2RHFRZWNadjUxQjJDRXFuc25Xd3ZFdXRkQVRsOEJ5MEVqZjdYZCtq?=
 =?utf-8?B?TzhHZk4wc3JjZXJaYmZaWUJlclRocElHeDN6Smw1T1k3N3pEaml3aWlrd2pR?=
 =?utf-8?B?dGVkOGdVaWkrbGo5YXg2Z2JXZDRMNTBueUcyb1o5TVNsc1Fod0VoZjQyVnhI?=
 =?utf-8?B?WUF0Z2dIWUdYRGVMZkxkaVhpeVpwb2dmMDFTa00zKzEycGVqd0JNbTBQdDNQ?=
 =?utf-8?B?eVhCL0hQVWloZWtLaitCMUoyVlJzQWxIL3lCRjZPUzNKWXVDOTNZMDhoR1po?=
 =?utf-8?B?ckRqWUlpaEdXZHNjNEhTQVZMbElTVkltM3ZsVjZiK0hVVGZCdjB2RzlyOUI2?=
 =?utf-8?B?THVycG5aMlFiZ0FrQVBrcVNRVTRrempyUzFhcjZBbU9ER3VOVlY5S3J0NGRJ?=
 =?utf-8?B?NUFlVCs4TWdXMFBGdUM5RFlGTklQeWZpNzVwS0VxRVpVT0xKZUQvcVdncWh0?=
 =?utf-8?B?WUl1d0dwRS90TVBCbmJwbUVXU2FYb1JNbjdWWTFWWkRRcDZFbDBlSFoxemd4?=
 =?utf-8?B?MEp4MzNxKzcrbUhudGIvUkUxakRHYmtEUFVvZHlzMWRucFM2OFd1blVlZ09h?=
 =?utf-8?B?UVdJWS9IRkgvbzdneGk5b2ZzV0RrUnJQaTdyVEpvZVArcGVLUHBIMEk5WURW?=
 =?utf-8?B?dkVHN2V6YWFDcXNDclg0dzZiRXMwNDlmM0puWHNrQ0QrVkovMmM2V3V5WWJC?=
 =?utf-8?B?NDExOGtVSzR0SHI1ZFBvK3ozZ0FoOUMzMjlZV3JxSDYxcDdtc0tJU01qN0tY?=
 =?utf-8?B?RHNqdlhqV0dLYmJvZWFHc0lsY3E5YkhrdDdBbHg3aEVna3BUb01Sd3U2eUYz?=
 =?utf-8?B?TjAwY0NuN2NlZFo0cE0xWWxZcVNGRjFkQUd0NGVUdkcrbE1vK3hkTFVUVkFu?=
 =?utf-8?B?UWYxYzFzRkxINTY0RU8reExEemJlc3ZUSUFSbG5Vd21VZlQxbVVxdnRETVo5?=
 =?utf-8?B?MjBIVFJMSDlSeThJSDlsSWQ0blg2d3k1YUtFdDdXMVU5OWJEYW9rTjJBTGRS?=
 =?utf-8?B?N3FESUkyZmErbEdjcVZabGlYcGZoRTNxWDA5TkVxci9YMGJid1dROTh1eEh2?=
 =?utf-8?B?Umh3ZWNIZTRmV1ZRSy9xK0lKWGZvcU4zZGNYNlVWUnNRdVEzNnhicjV5dkV4?=
 =?utf-8?B?ODd5amYwVjkveEVvM3EvdE81ald0a3Y1MmozTXhmdTRqVzkzOVdWRjFualhx?=
 =?utf-8?B?TS9rcW9RQW42dmVvbkt6OVRWanA2LzM3enkwZkpGWm1XQzJjQS9IQ0hKWVZp?=
 =?utf-8?B?ZGRNdmwrQkZuWVlYT2xNK0o1ek1qYnNjeTJ6czN6N2NLa2ltMjBvVDhWNzBC?=
 =?utf-8?B?c3JhM3N6Njh3cmQ0L3B4R2R3djZidGJhSVdRTXJrNUl6bTFSeHo4TTlqdXpU?=
 =?utf-8?B?VERFdHFtQXZuMG5hckZxenFQT0RWZmJQMnNDckVrYzlXMmVDdFE4TloyeXVS?=
 =?utf-8?B?S3JsMzBIZDJjNTBhdFdHM1B3Tkg3Q0E5T0I5WFFkVUhvdlBaWTZyamRDVDBo?=
 =?utf-8?B?ZEgzQ2JnRnRlMU5YMTl1YUFHUm1CSTUzRkJzN25ldFB2YUdEaC9JRGoxNS9n?=
 =?utf-8?B?WUZhQ25LaXhIb0UzMUFVZUtFUjFDVUJLWWFxSHhVcXk4T3IzeUhXMXpIRVRS?=
 =?utf-8?B?MEx6RzlLR0todWYwcFo4TFdSeFJoK2JoeEp5eVpQTzlENXJidDVqZFBLcXB6?=
 =?utf-8?B?b0dpWGNBM1ZDNDhPQjBKNnVsVmJFU1U1NFg0OU5lQTNKbWl3TnR3aU9BL3py?=
 =?utf-8?B?bXJlT3ZzWUJuWTFOMGMxWnBobVZFMW84Qnc4OEp1bmJsY2xRY1VmeDFxUVNj?=
 =?utf-8?B?RkUzdHdCMzRUUk1tRDh6RHpuNXZLSGxza25GemlzNHBYS2d0ZmN4c0pSKzFE?=
 =?utf-8?B?WEdlakZPaEo1WW5DUmVtV2kvRzVrVXZydnZiUXJRMEpLNVRVWWJkd0dSUS9L?=
 =?utf-8?B?WnZOMFNXN0k5WXBwUVg1SGZIY0hDZ3NvMC9zTGlKRVhNenU1Um1xREh0S3px?=
 =?utf-8?B?Nm52ZVNoSmtCS3lnL3lkMEc0YVdQbUd1Rkp3ZDVpODU3c0wxaVI0RDBxMUR5?=
 =?utf-8?B?VGRmcyszZFFldVFLUGhJSURLeGR6cXUvWFlnelBFdHg5cmFrK2cvVUVIWW1N?=
 =?utf-8?B?UUFVR0NjQVVMdkF4d2lmOFp5UXQxQVJLT2REVHBibjd0cVlIaHVSaW9nMDBF?=
 =?utf-8?B?cEF1cFhvcWJOdUlBRzQrenI0SW82UC8veGhHdENIeTF0MVlBN2hRbTBPanpi?=
 =?utf-8?B?dmhtSEh3emxGR0dTSmg4K3FucmlLZ3crQzFnODZjWW4xbTUvQlJPbEIzWGsw?=
 =?utf-8?Q?fAgUi3NbE3KdNZOeap2TDTu9HY2gEwOLi5OaSCk6CNSZS?=
X-MS-Exchange-AntiSpam-MessageData-1: Pew/xJHfUKFYQA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cbccbc-8ae7-401c-070e-08da4a2484b8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:29:53.4464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0etqPElpk+SAOqxlRlAm6A5kwP0K//0IF+wqbiNsBYR0hJ1oYooOfx82uvcgdaw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0071
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 09.06.22 um 16:21 schrieb Michal Hocko:
> On Thu 09-06-22 16:10:33, Christian König wrote:
>> Am 09.06.22 um 14:57 schrieb Michal Hocko:
>>> On Thu 09-06-22 14:16:56, Christian König wrote:
>>>> Am 09.06.22 um 11:18 schrieb Michal Hocko:
>>>>> On Tue 31-05-22 11:59:57, Christian König wrote:
>>>>>> This gives the OOM killer an additional hint which processes are
>>>>>> referencing shmem files with potentially no other accounting for them.
>>>>>>
>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>>> ---
>>>>>>     mm/shmem.c | 6 ++++++
>>>>>>     1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>>> index 4b2fea33158e..a4ad92a16968 100644
>>>>>> --- a/mm/shmem.c
>>>>>> +++ b/mm/shmem.c
>>>>>> @@ -2179,6 +2179,11 @@ unsigned long shmem_get_unmapped_area(struct file *file,
>>>>>>     	return inflated_addr;
>>>>>>     }
>>>>>> +static long shmem_oom_badness(struct file *file)
>>>>>> +{
>>>>>> +	return i_size_read(file_inode(file)) >> PAGE_SHIFT;
>>>>>> +}
>>>>> This doesn't really represent the in memory size of the file, does it?
>>>> Well the file could be partially or fully swapped out as anonymous memory or
>>>> the address space only sparse populated, but even then just using the file
>>>> size as OOM badness sounded like the most straightforward approach to me.
>>> It covers hole as well, right?
>> Yes, exactly.
> So let's say I have a huge sparse shmem file. I will get killed because
> the oom_badness of such a file would be large as well...

Yes, correct. But I of hand don't see how we could improve that accounting.

>>>> What could happen is that the file is also mmaped and we double account.
>>>>
>>>>> Also the memcg oom handling could be considerably skewed if the file was
>>>>> shared between more memcgs.
>>>> Yes, and that's one of the reasons why I didn't touched the memcg by this
>>>> and only affected the classic OOM killer.
>>> oom_badness is for all oom handlers, including memcg. Maybe I have
>>> misread an earlier patch but I do not see anything specific to global
>>> oom handling.
>> As far as I can see the oom_badness() function is only used in
>> oom_kill.c and in procfs to return the oom score. Did I missed
>> something?
> oom_kill.c implements most of the oom killer functionality. Memcg oom
> killing is a part of that. Have a look at select_bad_process.

Ah! So mem_cgroup_scan_tasks() calls oom_evaluate_task for each task in 
the control group.

Thanks for pointing that out, that was absolutely not obvious to me.

Is that a show stopper? How should we address this?

Christian.

