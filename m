Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21A9753E71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 17:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbjGNPJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 11:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjGNPJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:09:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B450C2700;
        Fri, 14 Jul 2023 08:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzLu1HMyzN+ZoAlkNMbninzZqYqDvgncbvm7AOcjk9+iXmZ16rJr2ksgwEUPHqmFmzC8QBbkopbepL/6Nd6siJUI4grQXCoGqgh+GgYFLMmQgmA8gDxj/x/Kbou/kp8lcmOkeUXuior/B6Hr7nG2t7J/l++mba3+SBSA3b7LHO/MHTDr0ccYPVTSfsb6a5K8AcudVNL4CdGfj3RrTWkhSMCLu/Fr1Uo68FUpI1BCFnUL5dAxGYKeUc1GI/cqF9rjT/HIttTjCA52bwyMOypRIotgtvLtJRTQ9izF0v1KapW85yprdN1eMIGmFwWgfNuGviQDEX2vhwd1OleGViuaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3xZF5J6hDeVTz38rQQZg0jtHyI4OckezjK3Y8a6Fdw=;
 b=Q+75TrHifaQjONKFwU6AKMJGuqS/13rhnOxkWus6ngw90NjIQ11afhj/qiaTkZ5Mdr0wlCoh+E7P+aCVjnvIQ1XGfYYYTzfX4k/sAzSmuWmXmfkzhGLDFn8fZPX0Xkf3DkxjFVWxH3bAXOSaC36CWexl9hv7JKC7xbBbIGXdcbe+bqMfxn/sQ5F8dmXcsM68iR5YkHzGtHyVGhcoZ9bVDc3pEALDJzWh+21hM/9SpaIy440nnUFs+xGh+UoN7OkIMtvJdLIeI6wdTa/nyeO8m2LmAfoW26S7X3huUmU+O9gBYmowdVt6NeOfNh70UjyYO+GI2FFa4c+G1eFBAF7UKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3xZF5J6hDeVTz38rQQZg0jtHyI4OckezjK3Y8a6Fdw=;
 b=dA5oczX2ivTgUY/jA45ZAEyZfb1wWxnAFkajWCtIaYCxkPOx1De7LNuKCPh1E2180nji0IjWXxi8tcj1penKDdlU0qDCY2rkp34bi/KYG5spqbueMhOiDaNflwnSoBhD7bJ89MPc8ZCgwrnAKbYTpg1q5Re3RWtn1NAP/VUdcx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.35; Fri, 14 Jul
 2023 15:09:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 15:09:38 +0000
Message-ID: <f6999021-fba6-c115-2dfc-1898b8355ea5@amd.com>
Date:   Fri, 14 Jul 2023 11:09:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] drm/amdkfd: use vma_is_stack() and vma_is_heap()
To:     Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
 <20230712143831.120701-4-wangkefeng.wang@huawei.com>
 <ZK671bHU1QLYagj8@infradead.org>
 <83f11260-cd26-5b46-e9d4-1ca97565a1d0@amd.com>
 <d11b6c3c-cbf8-a7dc-3cf9-e4e4dcf81fbc@suse.cz>
Content-Language: en-US
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <d11b6c3c-cbf8-a7dc-3cf9-e4e4dcf81fbc@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0243.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bed051-13eb-4d3d-a9fc-08db847c5774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PiziPCUe8KlgSkOMx++jubN4GeWP4qc7fXA9KsKv08naxtp17ExuVBcOSpx0hbJdmgSGwUD+p+OOZuh/MAZHvJrs9EdWB8S0ZyS04AvcVyqng6ouo4h8BpJqPtNTauTLuuO4kc5TxmsUOGtXyOmup1C2BP+A4aLNFbARss3KPmhM2C8JEvNoTPS+9KTrqgKP8J4OAW/jI84Xap1sKhuMGfh3DeWfE09hkyoxEwZQc+txcH+IQfHEqyjiqQljSJ0IIBvH0qlLv62Tc/2NAZVlMfgc0LXGDN3SVtCvfh0RpkO6e7mNkhHw82MsuYFoTEnW8dnKhES4eRhGZuqgsEVa8LOkrDdaQvhiTJaXtJpYqvFRJv/ktd3E04tLWiRb32L72/9ukS2M//WNnlewTAgQt7K5evz2Hwk1cHD3y+jazg/s0QJdSxuVq85BDu2MuNBos3IjW48m53qR4n8b/GNYTvuFHPeUyLG8LF1564dgmMETWTKP/CJA8nDai8hwBTjlViBsEpFK1omXxLLowNpCXkdryW3gESj7oqQiPE8DwSKv1lOY0ynWUfu1Po1RpWuIcK8bAfNS+or0cdB6oQoWnUSpWFKF8SS5fPwmTpVtP7cyp0UXXxx/it/i5WgTjesVnVB4FRdQOTfbDB6OfANm3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(7416002)(44832011)(4326008)(66946007)(66556008)(66476007)(316002)(2906002)(41300700001)(478600001)(8676002)(110136005)(8936002)(31686004)(5660300002)(6666004)(6486002)(6512007)(53546011)(83380400001)(186003)(36756003)(38100700002)(6506007)(86362001)(2616005)(26005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXFYMW42V1dZZmpRQS92Tmx3V2pjNWpqTFNKVGpuWVpmWmt6YVVPTHVLUXQx?=
 =?utf-8?B?bEZ3OUtSaHdBUDZnSUxwZW5HQU9ManFRbk51K2dHRWhqbXFGczMzRUp2VkhF?=
 =?utf-8?B?WEFNSEtTK1JzdXhkY2N5V0VkdUEvTVpoakdGNEY5VXJ0eDhHQ1ViZlJmTFQv?=
 =?utf-8?B?aHl3WWpVRWVYK2xBYW5TRVIvMjlpWTJzclprQ0xVNmkxNzRVMzlxNTBZa3lI?=
 =?utf-8?B?V1lXd2x1VEQ0ZVVZMjZHaUZvSWwvdU5MeWY4bHVjWVNPM3E1emlPbU8rYi9l?=
 =?utf-8?B?ODNvM2Z5cG84MklaWGdiSVVFSkhaMUNsczN2SWxuK3RvSjFXSjN3Qi9LZVlj?=
 =?utf-8?B?TlFvcGFVaUR0TlZYNmhxL2psa3hNbWgxbzRJUHdSTzVVRkcvbUh2RUpOc2FI?=
 =?utf-8?B?a2xFcDBxRTJER3Y4REg3UW9yL3NzVDNZMThjNjVLdEIrOW1lRmZRcUNtL3JG?=
 =?utf-8?B?ZXVJcklLQWV3UHhXeTdWOUVoRGErZnFlSkdKTCt0ckh6RUFqVFJJVUQrZjVl?=
 =?utf-8?B?eUpYZVJOckVuVTZ2LzFFMGpCODR4RXdJUEh6SlJackNDV2JtNzlCc016NG1Q?=
 =?utf-8?B?eGVCU2I1UHM1Ujc1Sk1VNUpMVnBKVEk5bzhLQklCSkljKzgrT3pJSEc0ZTVm?=
 =?utf-8?B?RmU2RW1YQ0hnT21BMG5VRkl2Rlp3UmUwMGdjT2lDWllYbGNtdHBuaGFhVS9J?=
 =?utf-8?B?QVRZNEJJVmxlWGZmMXdHU2U4M0U3ZkFMMnQwVFZYeHpiRWsveHlHc3M1bVlX?=
 =?utf-8?B?S2p5OSswakQ4cmNTVktCZUE5cTd6MENpUm9tL01OdGtSM2dzbmRGbEhVaEdS?=
 =?utf-8?B?NGsyK0syNTdDNm5RS2lvL1F5aWlTWU5OMXUwRWFVUmlJZ1pYWTZibDJOazdk?=
 =?utf-8?B?TFhPQXZ4am51Ti9KWHV5eC90T2FGRUNYVklPc2ZBTkQ0NkNPSUZ1Qmg5MW1s?=
 =?utf-8?B?NkhZaUZPMll6LzZwL09jeHZ5VUFnQnN6dDBmVE1ENzJiN2VrQlBCTVVOL0Er?=
 =?utf-8?B?b09rYmJpakNwemdXTUY2Y1BNczQ0ajB3T0N4OW5kc051TkFCbm9lajloZGU5?=
 =?utf-8?B?emxtb2xGRXk0THhzQ2ZyMWRFdXhnMCtlM1RKNWcxTG9QQVZvbDlxWUhraWh5?=
 =?utf-8?B?YXFWRFNtbVdkOTlCRmZtWDFsbVJMYjl4SkRTVVRVeld1RlhPWk1BdlpIcGNC?=
 =?utf-8?B?SUs0VGR1Zk5KTzFwMHIwVXdkVVkweDFoaWlRVnh4YUhmanJ5c2l0SzFyNlJn?=
 =?utf-8?B?Yy9qQlp1S3IxYVI4M1cyYlNZV25oN01IY1JtQW5EN09PcHlDY0lJRW1yT3J5?=
 =?utf-8?B?MUx2Um90MGJHNzF0a3MyRjNrcnErUFhLYXorNFB1SzVzbEtoS2x1bUt0UTdZ?=
 =?utf-8?B?SDAwMXJyZlBnTng1Q1dURWFDL3ZwZW5YYWZFa25jU3pSaFU5VFE4ZEtuL2kv?=
 =?utf-8?B?NHhyN1FKRzcyaDkwNlA0VHJsUy9hdnJ6SXVmT1JsOUkwM2ZLUFJZOFF2dTFr?=
 =?utf-8?B?bzNJQjR4MlVrVFNuc2tFWFhZelU2RU04NzBWUDhxVkx0Q2RUN2R3czZoV0pp?=
 =?utf-8?B?R3h5OFhDY0pmME14dEljL1pBMkN2bmF1aVo0NjJ6K3ZHVWJpL0ZoQ1RWdGMz?=
 =?utf-8?B?aUE4ZjNJaEV0ZlpJOTNwVGF0dERIN1V3anZxM1RUdm0yZWRtSjJWN1F2NDE0?=
 =?utf-8?B?VDZaeEVBdkx0eVp2c2RXeVc1SEF0R3JIbFRDYkFiV1MwazJlVFk0bnBKSEsw?=
 =?utf-8?B?dlRicFpleWtCSnpsV1cya292VlAzbjFqNDRSYWMvdFpWbE9jRmV6SEtEeHh3?=
 =?utf-8?B?MVNXd0VpdTJxbzZvWVA0c1RGYzduejJMRTczTmFLSnR6RDNtRjlxSWNSY0JF?=
 =?utf-8?B?Z0JXMFExeE95Q0VOdmUrdE9Jd0o2Q2R6ejBmY1cyRFR2U2F0T2xpNUgxQ2Rx?=
 =?utf-8?B?c2JVSXM4RGxYYU5hc0ppRjdtbjMvQ05qaFJOM2hCR24xekZjUHlVRkxncktz?=
 =?utf-8?B?OU9uWGdjTWROQnV6ZUVRVGdNMXhKblR2dC9uVzVjT0s3Qy9tYWxVOHVEMWkv?=
 =?utf-8?B?MHdsV1RsSFdDL3hScDYyYTNZLzVlTEg0VUkxN1I2Q001eHdsbW9UT3E5d1h5?=
 =?utf-8?Q?GQLTHZGj1V5Bn6VIrEXWzEsls?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bed051-13eb-4d3d-a9fc-08db847c5774
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 15:09:38.3370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: so/LpKGYVX4XGsaTwWhNVMtoROZ30VofCZPFY1KqRuuBq93H4/hbCLTbklEbvGGGZFpmwY6afhjcxO1tbIXKbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 2023-07-14 um 10:26 schrieb Vlastimil Babka:
> On 7/12/23 18:24, Felix Kuehling wrote:
>> Allocations in the heap and stack tend to be small, with several
>> allocations sharing the same page. Sharing the same page for different
>> allocations with different access patterns leads to thrashing when we
>> migrate data back and forth on GPU and CPU access. To avoid this we
>> disable HMM migrations for head and stack VMAs.
> Wonder how well does it really work in practice? AFAIK "heaps" (malloc())
> today uses various arenas obtained by mmap() and not a single brk() managed
> space anymore? And programs might be multithreaded, thus have multiple
> stacks, while vma_is_stack() will recognize only the initial one...

Thanks for these pointers. I have not heard of such problems with mmap 
arenas and multiple thread stacks in practice. But I'll keep it in mind 
in case we observe unexpected thrashing in the future. FWIW, we once had 
the opposite problem of a custom malloc implementation that used sbrk 
for very large allocations. This disabled migrations of large buffers 
unexpectedly.

I agree that eventually we'll want a more dynamic way of detecting and 
suppressing thrashing that's based on observed memory access patterns. 
Getting this right is probably trickier than it sounds, so I'd prefer to 
have some more experience with real workloads to use as benchmarks. 
Compared to other things we're working on, this is fairly low on our 
priority list at the moment. Using the VMA flags is a simple and 
effective method for now, at least until we see it failing in real 
workloads.

Regards,
   Felix


>
> Vlastimil
>
>> Regards,
>>     Felix
>>
>>
>> Am 2023-07-12 um 10:42 schrieb Christoph Hellwig:
>>> On Wed, Jul 12, 2023 at 10:38:29PM +0800, Kefeng Wang wrote:
>>>> Use the helpers to simplify code.
>>> Nothing against your addition of a helper, but a GPU driver really
>>> should have no business even looking at this information..
>>>
>>>
