Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197AD574467
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 07:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiGNFOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 01:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiGNFOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:14:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E521AF39;
        Wed, 13 Jul 2022 22:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=konCyrcv1WTttlX98x1x4ibySLYZ9wQSiW28Wm9Wvgtym2DKnikFoYLRpNCE3ajZdlaMbHwlH18XnMlHKhqReiRNeP4gpwIieOXQ6C7M8yos1TbXLrzj0GKp3EVUf8j55NjC5o9YaCC1RERwuOpTiAGD37RWwyAwvTrBiw92o5N1l9lMw0V+NtmrRsBBX1RJmO95l/0lgDNqaaGmwslCwmlrho9X5P2g8V2hus2bOU/r1W9sWM95hSzrCILZWDLiOgpIIw7ay43lZAaJ6VowhXwHcedznlEDTc8sQ5B2a9FLGiKTDPBaedVyaBVHsFE/BSjakc1NgjIT8+qV9TrLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD6U9IBmIvIpZco/ZjWYvMR6AW/yL3LBjjbeei/n1Fg=;
 b=YOWWOO0aLtPmACS0HhXe7Xw7k9NpQjF5wT9ol3xgY9n5KRB2erqQeQary01l0fRipxLFCOs7OkifHp3euF/2G7U7lO2qBJ0iXcUsXbUSYVzyrax0RaKv0Ept5/df2jpr8DNad8POvSJogexnbLF85/QpTgHq1yRa2NS7uefdkGs0zFcg52NQNTQgGHPoXM0OBu71kWMWbYnodiR8w6k2zrD03yLtJUgUz7UENsaOETLiiJeRrmcmQ+9L+YvkbV0HIApPksY5HwfUZm9sLG4vx8u3ajJSNNhT0/NI8BOCu4TKZksoUyFJm7Cj2/0J6+GHSNYpKTFD+56E1B43kkJjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD6U9IBmIvIpZco/ZjWYvMR6AW/yL3LBjjbeei/n1Fg=;
 b=Nj4tza8y8R+6LS9mn6xgNUM9+y+xAdj/FmdxMHvRKvb9kN/22XlyTzzrEKoU3MrE87/ZWzeuQhl6DNf8bDvV+j+ahpOb4/d3AuL831sRFc8tZjl0DqaqpU2slofBToDEwYIy6LV+ME6V1c9tBqYMT2AzrSuz2v7RPo21P1LABKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by MWHPR1201MB0125.namprd12.prod.outlook.com
 (2603:10b6:301:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 05:13:58 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5417.026; Thu, 14 Jul
 2022 05:13:58 +0000
Message-ID: <1ea62889-1919-bee9-2314-68ead1e72f06@amd.com>
Date:   Thu, 14 Jul 2022 07:13:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b1c12a4b-46f7-081b-242f-005a8824aad1@amd.com>
 <20220713075738.GC2831541@chaop.bj.intel.com>
 <13d25d2e-ff79-5762-ddb8-87df56f5cbcf@amd.com>
 <b0c726d4-2ad3-47e7-90cf-d67b36e7d59e@www.fastmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <b0c726d4-2ad3-47e7-90cf-d67b36e7d59e@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 645cd842-6567-4380-cfb1-08da6557a7d2
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0125:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4csyfLAYsd6P4UUfpRKifEt1TIWtD3v12UD4IJ3SdU8AwvR2XzNYjsDI931SmvAwrZXZBI9/W0ub4/9gctqYfM4mEHt0IM2V4Oumjhn4jHRmgNvv8OAnopZBYE7YsteXSBy/Nl9/yIft60mZ1nYkzuvS03l1As8/+KtmT4d2P0ohYAUQ99I4BsZoNTgCq37mHA4YOijYjT0hQgfgWP/0b+DZMtWGwTUC4XIIPFBee2YIiL1m+re+ylTo2sn93CxjWSa1AWkYbCDlrmabpXa2pOkabB5RzjYShaAAAFckBSHCz2pg+N2Ce8lIonEMKjT8s1yfa/x2WM6iR/auQWeko97YRsHxtj8uV+xff5qNkCOw7O5hUUizSv94vDYvUtpEhh+ITO0euzv6751dpB0yAsAZZ41otgktcn+XkxSQd3nCve6KB/44e8IeT7fkqEQ3YiaaQgv5MJFqgKGv8cXw3ds+1M/qYAgbHrLRQ9pM5nQECmLD0C4SW3YiugeT7U0cKvF7cwwIYDFdOHKKdf42WdxCgViguJjQn0TcnGPADG7CsFD5otrqT9pPeyHbYT3zNiQXZkpF2ChVjf5DZEtRdnc1ALYSMom3mHhCGyK1ZRJy1f4tkdhPClG8S+gOphetRjf2Fsp2oWx/XWrn3auNew0cMSP0Fo+Lj2PUQ8WHoI2V7V0tVwPOuolESuSk9++bodaZ3FPILPcuBGztQCq93QxoAFnE04gkzp98UOrj7G/Hur9rBXL5hHs5RhxhTNV10HaOeXuW8LZYyWPRESnqmjGRGlYe9cn9EVW7C8O0rBR1XoXhfNDSI0yCeGL7jhEobVpVywvwBStaNCOXu1DxEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(5660300002)(54906003)(6486002)(6506007)(478600001)(2906002)(316002)(6666004)(31686004)(26005)(41300700001)(6512007)(110136005)(36756003)(31696002)(2616005)(38100700002)(4326008)(66556008)(7416002)(8676002)(7406005)(86362001)(8936002)(186003)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0hFMkN6QmdCS2JtZ0hVTUdWSStrMTBqcWloTFJCeHVaLzk0dS81bzlNUzVl?=
 =?utf-8?B?SE9LSTNtMjBnQ1Zqb1E2ODhyOUhwYTlZMGRpZEt1bSs5QmhkS1Z0eHpEaUpZ?=
 =?utf-8?B?Ylp1SURWOFRJNzg0OEtpMTg3N3ZDaTZob1BxclptR1pmdUM5dVdvQXYvZ0RX?=
 =?utf-8?B?UmpuVTBxc014YVBFaURRVnU4WERwWHhkV3M0MUgxU2tYWEhuWVRyNGp5Y3lh?=
 =?utf-8?B?RS9paFhYUG5CNGRramNFWUZyOXZLdHBjVGVxcFlKQ2hnaWhtYlhJemJneDFW?=
 =?utf-8?B?NkE3SVg4NXA1MHZuZkRWbDc4QXFQN0NqRzVSRWV1NHhHOE0yNk84QUdBK1Nt?=
 =?utf-8?B?ZStHM08zWmVCakticFFjb1RqdU9WNnBpU0k3K2pmeDROTng1TDJLaVlWQ01y?=
 =?utf-8?B?SzhsTDZzazdQMnpvbGRXRzc5Qy9aeDA3UWFSSXlGMGxUMGQrNWd0UWtDNGFY?=
 =?utf-8?B?b2QzY0JWRzk3bmhIYUlhejFjWnM1QlRLekUrUlZQRUg4aExmV1RIZmdlSXZO?=
 =?utf-8?B?NWpJYUxuRDc2MysxN2Q5T3ZrNCtzeUF2bE9jRHhSREpPdGZvd2hZcWdkZjJq?=
 =?utf-8?B?djlIYXZyU2MwbDhVbjhkbnRtNGFYbVdKb1hNblM4NklKZ2NQN0VJcXhXTDIx?=
 =?utf-8?B?UjdUMTIzdVE2UHRmdGNwbnRHdGxlYkVEdEtldVd1ejNlb0ozaWlkWnJDcnlo?=
 =?utf-8?B?UVdUSC9DZkdXZHhUQkRuTit1REhtcGNsTVFzcC9HQkVWcXFwazFVVWtYL2g4?=
 =?utf-8?B?bmlLMnkvbEF1ZDMzZld0akd6T3RONExtUGVmcDNDZHI0UzJxeG9QeHJsVW1z?=
 =?utf-8?B?cVFGYXV4V3pkTjBOblJpalU2OVAvRlJlRTIza203MTVYeXg0VWYrRWs0VFhI?=
 =?utf-8?B?MTQwMFhWRmk0dU5tV0J4REU5Ujhwdk9QWkJoRFZDZUpHWTlVN3Y5dGI3TGRE?=
 =?utf-8?B?VXErdGhzNDZ2MzRUU2tLdmNrejBGS3VzTmdxUlU1eWdRSDRsOGFka0RlbHIw?=
 =?utf-8?B?dDUrSS8xMWNPQU1lS0VwTFlhK1E2TTU2eUlRZTkwSXZIbkRGczc0c3diVFNz?=
 =?utf-8?B?VlNCbGdHMVlJKzRDNHJYOXIrQnBMZGl3cVQ3MTluOFVqYzd4UnhJVWRpWWhI?=
 =?utf-8?B?VElkK3pCamdZS2NpcEdvam1oNDlFdEthR1RwejlSMmxkSVBFS3BmQVRiL2ZT?=
 =?utf-8?B?b0lmbjcraXl0THc1SXo1WE9LNGVMVlNjYmJXVkErSVhUaEFMUERjYTZCb244?=
 =?utf-8?B?bjZXNGo3T1VtYXEvMEd3WlRRUVJnbkpxNUx5RHZuZTNXdUFmenpaVlp4YXVx?=
 =?utf-8?B?N2k0bEk1S1pzNVV1S0xRVEw0dU9IS2lrckhyYnlGQ1htdE8yVTE2UCtCZ2Jw?=
 =?utf-8?B?ektlU29NcE1BTTNGQ3p6aFF1T0xiRlZTelhub2RmTHR4Uno5ckZGM2t3SmV5?=
 =?utf-8?B?N2JsZ05Va3ZtdzRHbXFhbWFjRG1UTlZtWllVSGJxVmZYRTZOZSs5Z3FVbkh3?=
 =?utf-8?B?SGFKK3g5MmFLMjZ3Tjg0U09nbENjRGFueVdRMlJYQkIrL0R4NnFSdUtRZXZ0?=
 =?utf-8?B?WkxTcGpQRjdKUzhULzZPUDArRDQwY0FYWnRwdllLQlF0UzdwTllVaThpRGhY?=
 =?utf-8?B?VGVmTFhQS2FuUUFNRTdpWFoxenlzQ1VNSWM1bjhTZ044dndKeXljS3RUVm9C?=
 =?utf-8?B?a1pqQkVwZEJBT1hTWFFWM0IwZGF6cnNCTmgrRU92ZURDNkxDdnFCdEVGVGJM?=
 =?utf-8?B?OXY1NEpTbkFudGJyb05pVlhZcFJZU1BKUk5mYUhKOW5JcUhSaFJGVVB1d05a?=
 =?utf-8?B?dkxLdDhGcGhkTmRkTEwzVWF1ZWwvOUtmQy9QdzhaMFZ5UEJnWEUyRjIyRUoy?=
 =?utf-8?B?ck9xRjhvaklUcWVRZmhUNFBXZ3dtUGFldDdLcDdzTCs2UkZ4aTNjdzBINlI1?=
 =?utf-8?B?ZnJLYTFlZHFKMkFLWmRIQURJYWNVTjB5cHhhM0l0cTRrVGR3QjJkZjJ6cjFz?=
 =?utf-8?B?dlZVczdlU2MwSVYySU41eEVURDc5bTV6eE1MbmI5TFl1VWNydzRIOEp5clZM?=
 =?utf-8?B?S1FXdURLL1d2OUF6U1ZWVXdVaE95UU1xS1YzaTlsVS9hcmpjc1h2WUd6aUkv?=
 =?utf-8?Q?NGB60gtRlVuHbAiAMW47wt3k2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645cd842-6567-4380-cfb1-08da6557a7d2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 05:13:58.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSo8tyoFrdbO1GSnn4cUz3L7p2d30PquK8O3PuhfZPdd7P3wQiUugSGJUn/F4Vnl7sMjVcB+4krFhCFhVQwOYw==
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


>>>>> This is the v7 of this series which tries to implement the fd-based KVM
>>>>> guest private memory. The patches are based on latest kvm/queue branch
>>>>> commit:
>>>>>
>>>>>      b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
>>>>> split_desc_cache only by default capacity
>>>>>
>>>>> Introduction
>>>>> ------------
>>>>> In general this patch series introduce fd-based memslot which provides
>>>>> guest memory through memory file descriptor fd[offset,size] instead of
>>>>> hva/size. The fd can be created from a supported memory filesystem
>>>>> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
>>>>
>>>> Thinking a bit, As host side fd on tmpfs or shmem will store memory on host
>>>> page cache instead of mapping pages into userspace address space. Can we hit
>>>> double (un-coordinated) page cache problem with this when guest page cache
>>>> is also used?
>>>
>>> This is my understanding: in host it will be indeed in page cache (in
>>> current shmem implementation) but that's just the way it allocates and
>>> provides the physical memory for the guest. In guest, guest OS will not
>>> see this fd (absolutely), it only sees guest memory, on top of which it
>>> can build its own page cache system for its own file-mapped content but
>>> that is unrelated to host page cache.
>>
>> yes. If guest fills its page cache with file backed memory, this at host
>> side(on shmem fd backend) will also fill the host page cache fast. This
>> can have an impact on performance of guest VM's if host goes to memory
>> pressure situation sooner. Or else we end up utilizing way less System
>> RAM.
> 
> Is this in any meaningful way different from a regular VM?

After thinking a bit, Seems 'No'. Except the reclaim decisions system 
would take under memory pressure and also will have to see how well this 
gets stitched with memory tiers in future. But all these are future topics.

Sorry! for the noise.

Thanks,
Pankaj

