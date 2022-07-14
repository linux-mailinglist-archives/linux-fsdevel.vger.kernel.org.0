Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330F2574438
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 07:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiGNFIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 01:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiGNFHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:07:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8702DCA;
        Wed, 13 Jul 2022 22:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPAvVW3kwFvt5TEpsVSffoRnbbwhJP7ZjTt2vomGLWcY+sbZmr4/xJnczuitUqBPSrguacnR1wn+y5mcgPdIvoGF2Ohjoqg/bBmZ+DVBapBfiJzBnHp9k6doq4gCXuwZzHbCkmW2wPe6oACmSDWf7arMQIoTvz2SlvWpx8gQypJf1HK6CDfNK7va9+BrXqIQSvptMjRMRqpDLy+hGCnMc13lMurTD+CjdtwRFS0foQprrgOfiuBKdPdXfpE78NERWqReGd4u7+v7oLW5m67+v7xN6wHhwt0YH7gm19S3BxTaCMJjpWpXDyKWigmeMaVPFgZiGxWc7KVdvZ28JUaahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYPzFgyLmA1aPeo1fYQuDuOTMDxYO6H6TAqiAsnHhjo=;
 b=ZP23Pl1NmJSnTTtROcDv9lZ8UWaqbEfbt4xTvjIbBRL86bnZWV4ZWS9NhKoVEd5lsJ3Df25p5vxR0GbpL5q2lUrrrd5MAbIVBMgs2y+oJ/kKdpkWfp6QKiElBNVUNHKFAzn6Vj3dVV7Vq2ZXDx287k1DJp0dPboHt9CSREAs5SIqE3FfLAdmVU9FxuGN4pcwf1OaRg+BrB9cHAttgVxEwkTfAZQpHBeX4Syewy/GOIE3hFW46nmHZWnzv60EUAH9iUOzuO/OM5G5+Y8MgRM09wA5YDtR6TbM+u1Dr4sy+lXTW078HKoy9Lr1y0an8nCA6yI6pctzx5sHWjgP0R7syg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYPzFgyLmA1aPeo1fYQuDuOTMDxYO6H6TAqiAsnHhjo=;
 b=RFDMOr8fwdGxw4fMVWC3204snP0DD8MsPX1e6GdrftXv0jZq3xVoSwTLEtzqZrNOwXu8rfADg+1XLnV2T4x+4CVmyA2Sk3vP2aKdI0F4O4mmCSDn/YlsP+sea7KeKESafUr5vnmeiz6TKa5FCRvDFpUtswjqPqLnQmXxK8/ZRFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by MWHPR1201MB0125.namprd12.prod.outlook.com
 (2603:10b6:301:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 05:06:55 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5417.026; Thu, 14 Jul
 2022 05:06:55 +0000
Message-ID: <666f8764-1681-1244-3b8d-e93bbcda5180@amd.com>
Date:   Thu, 14 Jul 2022 07:06:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b1c12a4b-46f7-081b-242f-005a8824aad1@amd.com>
 <20220713075738.GC2831541@chaop.bj.intel.com>
 <13d25d2e-ff79-5762-ddb8-87df56f5cbcf@amd.com>
 <20220713235922.GB2881285@chaop.bj.intel.com>
 <9f868fd3-ae47-d44e-fd55-566793405121@amd.com>
In-Reply-To: <9f868fd3-ae47-d44e-fd55-566793405121@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM7PR02CA0019.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::29) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 384d6231-4352-448a-4deb-08da6556ab9d
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0125:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvpBDozJ4LxwxOzdVJuEivQsrSCzyCNDM0OGrV4MTlbBUPmlGtOf4heNYR3lfa3n0y4tn1ju4Lz3iYvXkaOn9HHmR2Qv/5Ou750spodf2+IxXitArOUHq/CZMFzNl8nETeiAaW9uOSSywhnLaC8N/fLiPK49GYyVYdD2YSN9nHLr+TyQ3eQmEB8w71S6Eobn+onIxAmDdBkeUt3BeRZEbLQjXvaca/JT1CuYswN5r7LT5OlRyYoUWGV2TGx6wGlL/Y+kr/wKlsux8eHsxlUb0NrJJ+9W3iTGo0jwAmf7/iZ3TzYFBxWZbrGM3+A8onO2hDFQzmE2D5dTdf4j3lGsg3J5xDwwSbrWFMRUSf0jEPzMZkLmAgwylTqOjUx23olUykG3fIh3SzpZW0NsSCMYso/S5vo7eoUUVkooTZ//cfMYPn1dv7sHHiOQJZxaHTbSB3zef2IR5h0F7oLpUpJNrvoNHV0E/7w6TcYshibzZFCmG7NhnSlflKW/BoiuTU37QcOZy1tbFUnohPqQRvjmLBa3uluwRaNFxl4PblM1ZfR18WszlHiSMPjsaRdw/JISaBTdiGZyC8v4s0ItYh33aSf3ADCyUHwa8xZXaElMZAZ3cAvvhO0F038WcFbnFrMFDfhfSuI8khqWfWhYupQw0VP+bpQsnovxM4LugNsKtFj9aOfES+URfcJitNZAOmSCIyIOoaxfIemdtpXIWwCKEt+S3a6lta8hYbP6baAU3bG96MUyhbbZ7vPjjKj8rmJgxE/0/sxA+QB3wXg4TGSe7kGbCMtpgyf20baW/jklxIXLUKHz5yN+wzTZiI4mWWelr7Iq8fCDi6GPOkmLz2dLbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(5660300002)(54906003)(6486002)(6506007)(6916009)(478600001)(2906002)(316002)(6666004)(31686004)(26005)(41300700001)(6512007)(36756003)(31696002)(2616005)(38100700002)(4326008)(83380400001)(66556008)(7416002)(8676002)(7406005)(86362001)(8936002)(186003)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzYvdFErOEhMV010dExMejFxUWlyNzBRSEpUQjFvYjU5L3orQUQxVktnVUgv?=
 =?utf-8?B?bWY3ZjR0aEIvRXRmTzlHVlhvL0lYQVhrMGwwTFN1ZjdPSjhDZnZCc0QyMjRk?=
 =?utf-8?B?V3lGMys3SkZTMVlrWGkxd2krRXBwR0V4YUQ0SjJBVFpiWmx4OWNrVzRxMWFX?=
 =?utf-8?B?WGNMN0RuelVkV01keUZCR3RvZzRzSU9SYjBnL3lBN2p6ZWNOL2NWOHFkZzB0?=
 =?utf-8?B?QmZ3MU5mRi9DTk0wZHdFM3RieU15aWs3ajQvRk9laVNwR3RJSmNvdXowSzZ6?=
 =?utf-8?B?azJxUlVwOW1WcTBzbUNhY0RwZW9EamVINWlGcld4OXN0Q0ZGYi9hYTA4cVZt?=
 =?utf-8?B?bTFidk9MT0g0dEdsbWZkaER2R2hGVWUvc2JyVmJTUW1HRnVITGUrYXlMeXJZ?=
 =?utf-8?B?M2pyOVJySnVtY1lnNGMrTE1QTDYrQ2RKNmdUeGlhL1NlOWErelZtMGpxS0xJ?=
 =?utf-8?B?dDUwTURwb1VrQWVTcnpxZmFxNjBwaFI4VDl4dzJWN2xpZ2pRaytVTmVxRDVS?=
 =?utf-8?B?VWRqMjJYL2thU2hDcjVLV2hhZkd4ZFkweVN5UHlmSzlqZjdTalIrajlmTzJW?=
 =?utf-8?B?R2RyZ1hpa3VjaFVtSktZK0MzRll2ZGlvdWRXU29tdlppUzY4U043a0ZYQkVx?=
 =?utf-8?B?WnNmVFliUW0xWHFTSWFlODRiNWdYbXlWaUV3OStZbjRtcDRGSzc2NVovdDhi?=
 =?utf-8?B?SHRRMU81NW5jZ3dyZ3BxdTB1YnVrb1RRYzlOdlR5b29LV1NjRWRRek9xNXh1?=
 =?utf-8?B?MXZJTjV2bzlkTjl2UDBtUlRjVG1JeTFpeEtUSkR3R285YnpsbWtmWlN6MEF1?=
 =?utf-8?B?YUV6MVV6aWIyWkZrZmlZRlIzbkhmb21Mdmdnb1krTW5FRkJhZkZXUmg2UnYx?=
 =?utf-8?B?QXd3TFZ2Y2VBQUwrbTJhSjcydzBjTks1RVlvVGlndmtobm0rMklLQlpidklK?=
 =?utf-8?B?R1lsY3pmSlVkbGx6RFYwdnFlNzlzSlJvcVVpRlJxeURlVmJRTm5vUHJ0MjlB?=
 =?utf-8?B?ODEvN3FPTEhrcGZNcG42UXJEQ3czb2xRTklWQmlwcTI0dEhTV3lTemJiV3pl?=
 =?utf-8?B?UjNLSmo4dW5MNlAyYnFYdkI2M3VmazU3b1hWQjZTV3p4R1BERzhGTWxEbHd2?=
 =?utf-8?B?ZDJCQVQrNllzL01FOWpReVc1T05SVmVQbDBQSHZJNERuNHdwdU0vZXJTV3l0?=
 =?utf-8?B?amRjQ3BBZEJsK3RscmsrWFVjRTErUC8yTzdXMmxubGV1bzB4OE1VdEZzWjBu?=
 =?utf-8?B?Z0xmdmM5eDFQd29VeUxCVVlQNGFHTGkyNnNTdHQ4SDF2cGZxMG93dnF6RGc2?=
 =?utf-8?B?MHhOVzdrY1M2N0ZvVFJvdHd4MkhVbEczK3d3MkF0Y3hlRjdFTzJRTmppcDl6?=
 =?utf-8?B?RTZxb0Y0aHBSdGZGTVNFTHY0UjZ1bEF1NzZHb3F0N2tVQU5QNXB2NStKdXRu?=
 =?utf-8?B?c2VNemRSUENPNDcrQVNkUjVkZ1NETEFhQU5tVG1maGVyYUNKZGNoVGtGNVRN?=
 =?utf-8?B?OUZwOEVPbWVqYmJXQVYvQVk4SlpxbzkzWkxCL0xOMzNGWGc3NXV5REFmUjVB?=
 =?utf-8?B?cEJGMFJQNVZBKytOdlJ4MWhXVnduNG1UMGkzQ3JOdlJ5dFE0dGg2VlovWTJv?=
 =?utf-8?B?NkVJRWJLRmNBVzNtY1g5alk2MXVUU1VDbEd3ZzNXWVFISGY2Mk1MWEF3RGVs?=
 =?utf-8?B?T1FSN2lrZjMyb09TUUpjTUt6SmhFSzY1K0pFWHJ0d05SRXRrNGh3c0o2U0dz?=
 =?utf-8?B?dXpObDg2czhIOStaNTUyenBXM0JsV2pVOXZnZDRYVUxOL2NDTG5aazVoeVN2?=
 =?utf-8?B?MzJBUFY5K1AwWUViUlZyTVdFZ3VTZ0o3ekVnMWViQm1GMVJvQXR2RXRDdkEx?=
 =?utf-8?B?b2tjQmpXZUZmK2FNcmpycDlyeXg1anlsa1d5YVl2cEU1UzA5WGJjclNTemtl?=
 =?utf-8?B?eENXK0s2bWtSSkV2Rkk0eGdSVmU1aC93VGdvdlMvRUdnTkgxYUFpeG9WbGxW?=
 =?utf-8?B?NUdRcWpLRUVTSDVhWWFsaHI3cUs2RHR6ZTJmSWFCT0J4Sy9UbWRjVnFHTHU3?=
 =?utf-8?B?Mi9raUNxazRtWEtHaGpKZUJNVDRUT3J6b1F5aXVSSDdvRUlzQzhtMFE2WXpT?=
 =?utf-8?Q?0nguig1SUZ4nY2CKV7/rfY7Bv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384d6231-4352-448a-4deb-08da6556ab9d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 05:06:55.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CLw+SfWGM5uP2oXDw7M1trQhASw+oYnrEw1r8wqU3abPM3hCNiOomOhB4uHMvZI0hmv0/0BEA8HnuZgRalIKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>>> This is the v7 of this series which tries to implement the 
>>>>>> fd-based KVM
>>>>>> guest private memory. The patches are based on latest kvm/queue 
>>>>>> branch
>>>>>> commit:
>>>>>>
>>>>>>      b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
>>>>>> split_desc_cache only by default capacity
>>>>>>
>>>>>> Introduction
>>>>>> ------------
>>>>>> In general this patch series introduce fd-based memslot which 
>>>>>> provides
>>>>>> guest memory through memory file descriptor fd[offset,size] 
>>>>>> instead of
>>>>>> hva/size. The fd can be created from a supported memory filesystem
>>>>>> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
>>>>>
>>>>> Thinking a bit, As host side fd on tmpfs or shmem will store memory 
>>>>> on host
>>>>> page cache instead of mapping pages into userspace address space. 
>>>>> Can we hit
>>>>> double (un-coordinated) page cache problem with this when guest 
>>>>> page cache
>>>>> is also used?
>>>>
>>>> This is my understanding: in host it will be indeed in page cache (in
>>>> current shmem implementation) but that's just the way it allocates and
>>>> provides the physical memory for the guest. In guest, guest OS will not
>>>> see this fd (absolutely), it only sees guest memory, on top of which it
>>>> can build its own page cache system for its own file-mapped content but
>>>> that is unrelated to host page cache.
>>>
>>> yes. If guest fills its page cache with file backed memory, this at host
>>> side(on shmem fd backend) will also fill the host page cache fast. 
>>> This can
>>> have an impact on performance of guest VM's if host goes to memory 
>>> pressure
>>> situation sooner. Or else we end up utilizing way less System RAM.
>>
>> (Currently), the file backed guest private memory is long-term pinned
>> and not reclaimable, it's in page cache anyway once we allocated it for
>> guest. This does not depend on how guest use it (e.g. use it for guest
>> page cache or not).
> 
> Even if host shmem backed memory always be always un-reclaimable, we end 
> up utilizing double RAM (both in guest & host page cache) for guest disk 
> accesses?

Answering my own question:

We wont use double RAM, just view of guest & host structures would 
change as per the code path taken. If we we don't care about reclaim 
situations we should be good, else we have to think something to 
coordinate page cache between guest & host (that could be an 
optimization for later).

Thanks,
Pankaj

