Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86795414ADF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhIVNm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 09:42:26 -0400
Received: from mail-mw2nam10on2069.outbound.protection.outlook.com ([40.107.94.69]:16128
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233357AbhIVNmT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:42:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHWAW7mH0kmMH0avURL3Da/dfCOO5C5cd9Iq7KnbOnJos0w32zX+FLmotnLZmIkTpH/8B6HQvK0SWKC5OYU7lh0wcTdfO5yKJhEaLq4cPqXzxEoWNtp4xKP+B3H/JrV0xPG83zKHUa/KyxM8DyFCd8MBF7Rs5kfD3UYm8+V/s8Hp952n75DRzhcchquzCIAw9EibF2IUo/0aRx033OS96wnqtfYF5e2o7tlfhiVhwt77nWf6NIY7yI/dtl6H7x8XjKeK26KCG0xVmwuCOMdLnDb73OYss0GJURK79x3YJ2ypsQkLtZ+FdifHjq7LKq53T2iKmqeAb2+cA8doGi0SBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kczV+bsyzKfw/AOd0vHcQFHzYG83YqjWyI28eFPOe5E=;
 b=I7loZhdFgXlWWJLa3yekVn8xh4SkCKNfk2C2OfUmvMfP+pHfY+Jt/bEPTNPp/+GRqC7ikB4d9onimR40W8irXFT++Dg+4FWcYyWyCdAqJGMok1jnQiKiHO9FfhjLzA6ogrt2EOLvuEYntnyRzWf1mW2C4ykX7+HJUKX4atUxmqgdKcAj3Q3hUruJ/TCRIE/900eXAZLf1bIrLv7j9edMpWDcpyhqDfN8gVcNaeayu7JocziY0QPVZYWxnBbmja6zjRxdIqKb1g9UtH8UKApTuFyGEl2MGb+s8Rwktfwz7Ap0OyZIHlIY2W8nZI6H2g6jLhlh1YNotxOw0YsiuMXNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kczV+bsyzKfw/AOd0vHcQFHzYG83YqjWyI28eFPOe5E=;
 b=n5cnWUGzkbockvyaqButB1AhbebdKRCXEy4EQa5KBh2ooIOxARw1N4sutRIWWoRUYPOwSN2ilIYrztpoFNi7EdhA7FBrg2J3lyj9T/WH5aGb1XSqllQ/Z3JK4EEd9hIbIbQ0vs2t86fyq0vHyzzC0O9QKUjoN//7IteX8UaBanI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5376.namprd12.prod.outlook.com (2603:10b6:5:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 13:40:46 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%8]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 13:40:46 +0000
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com> <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
Date:   Wed, 22 Sep 2021 08:40:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:806:d1::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SA0PR11CA0097.namprd11.prod.outlook.com (2603:10b6:806:d1::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 13:40:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 962f08c3-6e68-4d0e-722d-08d97dce94bb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5376:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5376AADDD5A9E5F8B3CBBB9EECA29@DM4PR12MB5376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SUZAc30vVQ3ulvk93dOan28qKWd0xjO2n450QZOatA0Rg3/4+vd5u+8oWzbrR0UaNy2q/s6guD7rKNBr0fTdeuAITOMijc/2/sSwqcIlyOKduSxpVEpclG5X9R6y2f+gwR0pacFYMrOMKyEXLiMy0Vq4UOacgjZphDaPI/o+Ga3CG7Z1B0jd/RdAIFUzoL3QC2fD+mZhLgjT0iJ1upUxo+QuZdCZ1HNcuuGKZVlnZa5FlPcKnfmFA0et1jdBWjxBaf1FRD1rQB6mqBR3J40hKbZQJqzWPI8NYS5yAmPh5Nqfcn9KbBvpDxBI0huKhC0Z3FTEwtwdqJVG0ndxe1FrBAXdsXotb9/2uIQcGo4wYfi6AyMZJ5tTon5HMyoY3h9ysrAF2B3Q86UrAN1U7nJkMEBLl4rWBK/9UaImQyl0xE1zI29ZLF2HiyX+BGTAMBhPfz90N+vs05/9PEfEANL3FMRl/ZAhKz+mMLoK6hC/LJSypRPCsw3RojbQ1QxYiItsqT6CyDdAMS+qaSrZeGeUlMZi7ytAlUwo8mHj9yqhwgekgCEuTmq0AIxk/RyCXvEy6NUivlJgiMLUqQchUOdPzF2yrU0dimpesbg0bzBtkTnJ1mcykaxzUsIWBI/t56gR5bk46l2CyLMp3lbaqiMdwUMDQUWA7Yv5TFRPxw3xD5ge6O1kwY/8HfgrIX+LazHCKxmouJ3JVCrqFfIhwy6Z/YGCkn8QEHlsRn69OjZkqGHBQbQvoa8Qn/N+OqKyc7k1m1OX8u8bx5cQqMRaQ9BkHhnAGalQ4SJtq9PReQidYgsXrgR2P+OyLGximlEHX08
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(45080400002)(7416002)(86362001)(83380400001)(508600001)(66476007)(66556008)(8676002)(66946007)(6486002)(966005)(31696002)(38100700002)(2616005)(956004)(186003)(316002)(16576012)(5660300002)(8936002)(54906003)(4326008)(31686004)(2906002)(36756003)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGVVTkEwV09JWUxyMXBlM2haZ1h1YkR6VGRJdnJaSlowcTFXLzJZdG5kUUd2?=
 =?utf-8?B?azZVdEY2YklzVTdKbmsyREhIOTlFL01EMHhkSWxDMFZUL25hWXFOY2JHSUVo?=
 =?utf-8?B?ODkxcnozUmZlL0VabGdWT1NxdVV6RTdJalRwbXlzZWJSYnpJcWFqQ1FSSks4?=
 =?utf-8?B?SCtZS2xoZytKNW5VeW1BdW4wSlZLTmtCNVpKZjFjSHVHc0ZtaUkvRk83ajlO?=
 =?utf-8?B?U1Axa3U3YnFuQk9ZNUI0M1QxSXZodkdhZGx3bXIwNTZEL0JlTUk4a01uM1JJ?=
 =?utf-8?B?VmlvbWd1VzFHMnk0ZmJqRllFK0tEeVhCRFdhSThBeHhCblQxMFNHZm1jOXVn?=
 =?utf-8?B?b0x6eWI5YWZObDR5amtPQksrWlZmeFphVXdSMG1COVViN0tBclVSbnQwZVhD?=
 =?utf-8?B?TUZ4MzdGNmtaQTFhd05UU0N1Tk1SRElOSThnNlE2c0U5VmE2ZjRJd3JPOGRV?=
 =?utf-8?B?SDBmbHdPUVFMLzc5c2gzTUhDY2c1dHByZmlUeUxIQm5RODZkeUtBRnRKS0cz?=
 =?utf-8?B?dTZHaHI0djdsODNtS3plK3crWlI0MW9hR0orbmgyd0t6UFFoNkhuSllZVFBy?=
 =?utf-8?B?dEE5L3JpYWpYR1huQnAzRUkzY2FTTGNzU2c1UW1vWjVsVWZ0dEdjL2s3L1dG?=
 =?utf-8?B?UWlGNUx4WkY2eFUrRkZqS1ZFTS9aWXFQaG04YzAyc1VSZ3FES0VVT3lJTjFE?=
 =?utf-8?B?ME9Wc2R5clUwK1VvVTNNNkNZVGFpYmJxc0NjVzBRTXpaSjE3UGxQL1krbWZH?=
 =?utf-8?B?RGlzeGkyUjlGMUd0UGxBTisxS2hjRnBScE1ZN1Z6Z2xuMVpPU1lxRXAyQTFv?=
 =?utf-8?B?WFpzbTByY3dKb0swUWZzb0djUXdhMXlsSXRWOGU5ZUxxT2kweVUvbnRpcUVN?=
 =?utf-8?B?UkZoN2JaUlZDcWdjQTVFSmZhQk9CTGVPbjdSR0Z2V1NnVUU5UVh0c2R1WkF1?=
 =?utf-8?B?VDVKaS8ydHc1K2VNVnhCVS9vSlFIbVpsajJsZlVHdkFMU0ZONDhtM2IrVk91?=
 =?utf-8?B?RWs3cGZpUGJiYzBVdHk4Y1JiYmJOWkMvT0hlSlhFQmtUaUtla1U4dU1zZHpD?=
 =?utf-8?B?cUd6NlZCRWV4dWpQZVRzRWFyTHZmNkcrTlEybXZ2NW9KdUxJbXl6OGhuamts?=
 =?utf-8?B?UXhqTGNDWE5TYTMvVk8zUUl6aU5LRERHbkV5OEtNekhZRS9YVVVkRm5KVkF0?=
 =?utf-8?B?aEoyTTF0OVV1YWFGWHdTSW5aNmFkTVlUbHlpekd4TUVHd3JJeDU4WWcydTk3?=
 =?utf-8?B?c2htcG5xREhWN1h0N2w4L2h5YytHcHp0TW5WSFQ0Zm9EWDVzT2o4ayt0dnJu?=
 =?utf-8?B?TGgxQWtsYTBQeldRVVI1QXhGZ0l1cXlncmVmV29IVnpJVktsSllDMnE2ZFZT?=
 =?utf-8?B?RTlnVjl3dzZyZEdpT3EyQ0I5Q3haUXA4MUdLR3NZTkpCS0ZtU29wRTZUaU1t?=
 =?utf-8?B?cmpQMDNrdnNpaVZ3aEFidG1aSTR2ejVmdk9YY0FuNlRycTJnSTlSbVg3SUpq?=
 =?utf-8?B?S2dSUTMvSlFGVVZteUtJZ3FjYm5MSmQvaG55MURObWFiUU8vMkd3ZkJhekFZ?=
 =?utf-8?B?WEZyTGVtSW4vMTIreGx0M2UwQTdvejM5Y05idXloVkFRRm1ZcHJlQ1lGQkVy?=
 =?utf-8?B?cXkxOFVlTFBENlNwamRobEFVUEpWWUkxZnhVZlVtTUNSTFdKUThZZ0EzM3Yz?=
 =?utf-8?B?RnExczdjenNiZWpwTEQxNFpGR3RwWXptb3ljRXErd2dXSWMvZmcvRUdPYytI?=
 =?utf-8?Q?1ASInNOqJerRPhp4JciLJlkccorkNHlcfwyJoCE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962f08c3-6e68-4d0e-722d-08d97dce94bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 13:40:46.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/z7WrTCeKv9MglFoZ9KuZWgaTkiXC2OrjnMBxQu2WeFWiiFrfTKL/XjWjIQobPpp6yIkm37tE1R511i3IyQxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5376
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/21 4:58 PM, Kirill A. Shutemov wrote:
> On Tue, Sep 21, 2021 at 04:43:59PM -0500, Tom Lendacky wrote:
>> On 9/21/21 4:34 PM, Kirill A. Shutemov wrote:
>>> On Tue, Sep 21, 2021 at 11:27:17PM +0200, Borislav Petkov wrote:
>>>> On Wed, Sep 22, 2021 at 12:20:59AM +0300, Kirill A. Shutemov wrote:
>>>>> I still believe calling cc_platform_has() from __startup_64() is totally
>>>>> broken as it lacks proper wrapping while accessing global variables.
>>>>
>>>> Well, one of the issues on the AMD side was using boot_cpu_data too
>>>> early and the Intel side uses it too. Can you replace those checks with
>>>> is_tdx_guest() or whatever was the helper's name which would check
>>>> whether the the kernel is running as a TDX guest, and see if that helps?
>>>
>>> There's no need in Intel check this early. Only AMD need it. Maybe just
>>> opencode them?
>>
>> Any way you can put a gzipped/bzipped copy of your vmlinux file somewhere I
>> can grab it from and take a look at it?
> 
> You can find broken vmlinux and bzImage here:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdrive.google.com%2Fdrive%2Ffolders%2F1n74vUQHOGebnF70Im32qLFY8iS3wvjIs%3Fusp%3Dsharing&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7C1c7adf380cbe4c1a6bb708d97d4af6ff%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637678583935705530%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=gA30x%2Bfu97tUx0p2UqI8HgjiL8bxDbK1GqgJBbUrUE4%3D&amp;reserved=0
> 
> Let me know when I can remove it.

Looking at everything, it is all RIP relative addressing, so those
accesses should be fine. Your image has the intel_cc_platform_has()
function, does it work if you remove that call? Because I think it may be
the early call into that function which looks like it has instrumentation
that uses %gs in __sanitizer_cov_trace_pc and %gs is not setup properly
yet. And since boot_cpu_data.x86_vendor will likely be zero this early it
will match X86_VENDOR_INTEL and call into that function.

ffffffff8124f880 <intel_cc_platform_has>:
ffffffff8124f880:       e8 bb 64 06 00          callq  ffffffff812b5d40 <__fentry__>
ffffffff8124f885:       e8 36 ca 42 00          callq  ffffffff8167c2c0 <__sanitizer_cov_trace_pc>
ffffffff8124f88a:       31 c0                   xor    %eax,%eax
ffffffff8124f88c:       c3                      retq


ffffffff8167c2c0 <__sanitizer_cov_trace_pc>:
ffffffff8167c2c0:       65 8b 05 39 ad 9a 7e    mov    %gs:0x7e9aad39(%rip),%eax        # 27000 <__preempt_count>
ffffffff8167c2c7:       89 c6                   mov    %eax,%esi
ffffffff8167c2c9:       48 8b 0c 24             mov    (%rsp),%rcx
ffffffff8167c2cd:       81 e6 00 01 00 00       and    $0x100,%esi
ffffffff8167c2d3:       65 48 8b 14 25 40 70    mov    %gs:0x27040,%rdx

Thanks,
Tom

> 
