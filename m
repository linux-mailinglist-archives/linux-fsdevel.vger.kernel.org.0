Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32445743F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 06:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiGNE4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 00:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiGNEzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:55:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B25C643EF;
        Wed, 13 Jul 2022 21:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbhdvKZJNdyQATNtK8VNYXFora/+OLu12r7hGO+cyh9ZV6cjSfVPEPAMrwJe7Y9rXDvENCb8/omx4bLBysl900EyjL+1lXNsGAA/6cp6tOMwt4KN36o/by4jSDc1GjsZOEkEKKFL9XTlh9bFl9K7Si9md0wwW4GEa7c1oaAJXYd6ePWoRtskSgbdkDUJaSjxhBvpbo+oepAwnOmhbD1woBKg0f2ASNPJPsET+Fbrd6MN8PO3ZIjT6pMx78hXcXBUIBB9WFGPWCbBM6PJWWwQ3KXBVHGfzEhBD/FYft1F/BizVn7JUHsHy8RSHL7aE/IZKl8dq2f08M8UEEcOS9i7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiH++72cP6PvlniAvI81A14IGuMIsNrP70AVG88c3VE=;
 b=Ikbv8R5SK7EcqRfms0jKu8cS3iy9Hs2L87eFjggDtVMqsonQHA3EhbZ7MGfatj+rrv/BcZ45qy7d3L4BcuTmtyoCncan4E/RiNDIXky/gFahA38Z6nkQFdnSXZv3wjMTopR9SKlqzIPUfhir7Lidl6ULErtXi/VZ0xhyJxgPbS+IU7swlJ980VfSc9rYF3KUFZo74WqdoUMDxyerjCOD46ZXnMQlNWwnsMldWJ17OFW7EYw7i0rl9mVXyEh04VrMb7Xndgltb2Y6q13sxrAm/x586MglRdA7Q/pbzMgm8ipiPibTWC0/g5VxF/mAQ3GubRLHLaKbRvQNzgxBBDhZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiH++72cP6PvlniAvI81A14IGuMIsNrP70AVG88c3VE=;
 b=GcV40z1oIlNNKEoaDhe4B2vZPdREYwEz7Q7GPDg+po0Xf2AZOJgeMUo0yBs1kryIy4axlyeouSSGRz/MtJ+yAQGRxwV51UKyKsQVNrw2D6Tzk9Qm1ZjOyasExWcyLwBFvVk4UfJX5Inbei56XId4MLiLhUfg7nu+ufuukB/GxXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by DM6PR12MB4139.namprd12.prod.outlook.com
 (2603:10b6:5:214::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 04:39:50 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5417.026; Thu, 14 Jul
 2022 04:39:50 +0000
Message-ID: <9f868fd3-ae47-d44e-fd55-566793405121@amd.com>
Date:   Thu, 14 Jul 2022 06:39:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
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
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220713235922.GB2881285@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0601CA0067.eurprd06.prod.outlook.com
 (2603:10a6:206::32) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead61a78-b9f2-4e38-26ac-08da6552e31c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4139:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2nA99ESSA7nLrA3tjdi1twrBW1DeGkcb6vzB4pVRNw52Vade6QYBQ1IBGuuGa8YNZyI6Dw4jfxSNkCQfFuvcmOJQiCRXz3OR3B1zib/J4aIge06aHePD6eIJmDw4SMI8zQKiMq4XxT2O0jPbt0xqeDbRVrbPkdXIGThsKs2P+0J5c4JjtJx5IKdVWea6NCQwF4R7215zYpt/K4yGchY/j+U8X8TYy47jfhbr2MI4wJw+xULz9tpgGQPBc3hT6xp9+kJGAMu9CwVDFhj4AKJuE/tGcNjP2KX5+Gmwr+ocjXd+GhQASqqZdah+FzJsjmZrhDCvSqpJ5mxglKzm5OrvAbFXf7klah/2q0/xDynVMbo/BUjIZGhtVe661XgWp4aTmZhI/S5YZfBNLMCHxGThg1mDIb8u2lPIfcZAFGU9UuI4RDZSdVO+hO5XX55sFAPLG0AxIIsRO8aqYwD1nu6FPwAwpwNUo1JxKizVoK//IRXQhbVFCAkKYCbTkdwFAcLt2WGcmEXUddDxSYYA1ytMvKtR1X/KMY0zh86gypRd9TRYP/kN+ueV0DJTojXM10t8AXPXtB4WbpsRZPOD2Y1+r2KE3Npjc1eIBiUX3xrMefiFMt2Ez5qrJu354CMXQsiIqgjCtdEdV5qmbucipawuUGaaUz3NnWVuPBiSrLmWlM//P1Rbs126Ni4hmTqNRy9z14lWQlSkMmvuL5M4T5p5UEmXForllBLKz2UUowQ+HtMkQpMK7cn+ItBUUM6Voob5KQm2P6tRxeYGzQB73DQimt+6AxLGNq9IiSSPdAenEogX+lJPo7/7vQ2qWNxA2awm2eWZ4UM2FjHMhc1m/7JIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(66946007)(66476007)(2616005)(4326008)(8676002)(8936002)(186003)(5660300002)(86362001)(478600001)(36756003)(54906003)(316002)(7406005)(31696002)(31686004)(6486002)(7416002)(6916009)(2906002)(66556008)(41300700001)(6506007)(6666004)(6512007)(38100700002)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjJxMGZTRktkNDU3Q1ZVV0REZ3hpVlJOMjhJMkJMTS9JWlZjTHgvOWtVZDE4?=
 =?utf-8?B?S3RhWCtLL01yRzdCM0Uvc2h2bnVSaFVXZGJCUXVoNEExbTJLQ0RmMyt3anJ5?=
 =?utf-8?B?ekhUS3BkWm43eGdSUW1zVzQzeFlxaTU4bVhaeGYyakVVL3dVMVhpWGpTbS80?=
 =?utf-8?B?a2o2MEQ5YUdXVTR3NXRScnpJQ3JtQW1hSlNpWVo4VmtYOW8vNGQyN1JlR3dQ?=
 =?utf-8?B?M2RzRldoM0xoVmFDQ21SOCsvbFRNV2h1cTEyZ0dPRW4veHVTOC9ZNFBDQnEr?=
 =?utf-8?B?eEZReG9mZUM2WnQyN0tnSm1UUk9KTEl5OXVLVEZRbW5XV1RsamVvWk96RUMv?=
 =?utf-8?B?WU9zVGsvMkl2ZGgwNnRCWFQ0RVczZTg5OFJmZWFNUDljWEF4MDZVUVhjVEUz?=
 =?utf-8?B?c0NCQmZWd0svM3RITWtjZHBKeWFjOTVFUWgwNUtWSXNxRHdwRzByaXpsVmRr?=
 =?utf-8?B?cUp5ZHcxS2RSZVZnYTZJS2VnZTFFWnVSKzJjbDVPeVIyMUVMd2Nqc1Ewc2VB?=
 =?utf-8?B?UG5LQTFPQVJ6WUhBTXljdENQeEFxa2IzNDZSZjJXUmp4VzNkNnFUbUJVNXdK?=
 =?utf-8?B?UVNrUFJYMnNLdC9WUXFxZzJxZ25QRHVITUs2NE1NYXVlbmgxRkVFSm81UDZM?=
 =?utf-8?B?dC8rWVk4ZG1QRE9BakJxUlVOcnRKRWFpQWxGdXBLc1ZhNkV0N1M1Q1RUbmY1?=
 =?utf-8?B?WUYrV3hhT00yUk5xQUhhWjVUZ0pNYVdLem1DY3VCU2cvbFlvSHZvVkhjeGhV?=
 =?utf-8?B?bjdFeitrdzIxUE0yeHFKZVNJMmk2REcxb2Q1dlgvVnViZCtsS1BnZU9WM0kz?=
 =?utf-8?B?VXBHMEZ5TjQ2TWNMT1hCeGtSVnFjbVQ1bE0vc0tIV2syeWdCN1VaaUJvakk2?=
 =?utf-8?B?UFArK1EvQWY3MlA3R28zY0sxQTBQVGZpSGU2dEZ6a1htVHBIRVAybVpzblhx?=
 =?utf-8?B?cjNNYkV6cVhwZEtlOWx6TGhhMWhLaWQ1T3VaWE5FWDJNTGZ0UjMxL1lKU1pP?=
 =?utf-8?B?NGcvYmNHV1orZnI0WU4rV1hSK0l1RWsyMnJnc3NFdW41T2ljRUtnbWhaRnk0?=
 =?utf-8?B?MHhLdEg0Mi90d0tjUDlqVHk0VWt5QTk0eHp0Yjk1Y2dwRUhGeXlVcTJDRi9O?=
 =?utf-8?B?SFNPYmRJNlNJZXdkSWh4T1hXYWRSQkhUREVTblE0YWRFUEVqRVFvU0RPU0lY?=
 =?utf-8?B?YnVVSGt3a1Iwc0swUlZ6UHNsTjlEZlQ2TDk5dS9DRlFzT1FyNVE5dDVVaTdJ?=
 =?utf-8?B?TDdhc1NYNHhQc3d0eU93YmVRZFZ3eEdDQnF2d1R5enJYUzg3c0hXM1FXUWJF?=
 =?utf-8?B?OXR3VHdSMFlFVm0rVXQ3VS9FZ0gvZDh4OFJlVWh3aVlkWE9mUUxnR1ZYRlcw?=
 =?utf-8?B?NmQwRXFXdUd2cUM1aElpaktrK0NEZHI5NEtBdHVYbTdwOEhpYmJxTDM5YlFm?=
 =?utf-8?B?d3FvYUprQlY2allBZytkN0JWNG5rc3B3Tlk4QVFOUTJSVU5WQ0hLRjhkZ3hv?=
 =?utf-8?B?ZjBCWXRrOHpxMXc3eXdYcTNPSHQ0SnRKREZJUlBlUkE4Myt1SkgvdWVlcGpO?=
 =?utf-8?B?WStRRFhLd2lMN2l1N08yNUVlK0gzQ0JpN25uK09ZZEoza3FVb0twWkxDaC9E?=
 =?utf-8?B?TFUveSt3VUwzOE5ad1gvb1drN0pJSk9Fc3JlQUVlME1UMHVkSXNKM0RlWmlt?=
 =?utf-8?B?V25GTklvNzhCbUJKYVdLTktUSklNTzFRYlg1SWVSbGJnSE1CQThsWnN0bGlI?=
 =?utf-8?B?ejVoZU1tTUFFMXNSOEw3OUhBTWEvNjh3THVtMkJ3MEM0RVVFemRWazdkN2pp?=
 =?utf-8?B?NHFyWW9TL2hPZkoyb0xETmhlcHNMUjh4NHRTK1YxaUhrdk1YcmZvakxkRXA1?=
 =?utf-8?B?ZkF2VlR4RGhab2VtVW9mR2k0YUJURGpXSndhdEI0U09zMXVLTDUxQTNLNm9o?=
 =?utf-8?B?YzZLYjArc2NtYmdmSGJCYzlwUmxHd0wraERsb0JFVm9ZVjdoaFduU2hOWkdi?=
 =?utf-8?B?Z203OVpySXVteWoyQVNmOTZJQy82YTZUTlN0c3E3VHNiWlB4ODNUUlA0blBQ?=
 =?utf-8?B?aFc2T2VISlc0MHluK2paRlRaMGxtakErZ3k3bi9MM1FTRm9pOHlSbDBsN3Bw?=
 =?utf-8?Q?J0ApEf6WsLAOlIX1buvLtdaxQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead61a78-b9f2-4e38-26ac-08da6552e31c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 04:39:50.1780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxjmDwv+ndNmA8b/s9rWD17Gc/TJNq1Ppwthczdjs1HPNvU/iPKcNDyMpOE3jhjd3ftMB4D1HOXfjLqRYmHTag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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
>> side(on shmem fd backend) will also fill the host page cache fast. This can
>> have an impact on performance of guest VM's if host goes to memory pressure
>> situation sooner. Or else we end up utilizing way less System RAM.
> 
> (Currently), the file backed guest private memory is long-term pinned
> and not reclaimable, it's in page cache anyway once we allocated it for
> guest. This does not depend on how guest use it (e.g. use it for guest
> page cache or not).

Even if host shmem backed memory always be always un-reclaimable, we end 
up utilizing double RAM (both in guest & host page cache) for guest disk 
accesses?

I am considering this a serious design decision before we commit to this 
approach.

Happy to be enlightened on this and know the thoughts from others as well.

Thanks,
Pankaj

