Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32993E9517
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 17:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhHKPx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 11:53:59 -0400
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com ([40.107.243.63]:57576
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233491AbhHKPxY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:53:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVxXJjaHSdRiohwAE+8zNVbsf3D54dQHusnRJVSSwi4FlpEM6/7A8MLTjQ8ByxSEs8bNYlvTx8hmaWEVY/PCx06TI7GboiiErn4WKFLfuFaOENpCcCoKbgDEBNyP+4K6TkJWZKtdZweUNlb5x2vfuYb8afG0nN2PebS9PhOLj3Bu35Mo65vXIlY76mNIPmZ+V1JivRGDt3ANe1vcYFb14gyJEdwPnbpsKFcHFuzptTMh9gU8rJJXNhYjl4l/puSwUuDPsDr1ZOSmqsJbB7QJPr0J6ZP6BDDixl29W90sgSn96S/iLiQ46pk1n+fKxuPiIngydBdw4ZBLWUHoIRcijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C49rqTyfz3/bdpRcw7lWMxc9BXCwJJccswQylOwMjKA=;
 b=RAqKTMcfArEHEAUu7QneQjF7TcJn1x6wgtwcpOT/7iy8vqK6M9LMcD8R60lIieMP33wo9ZCzC87YbWZo7klVfW2fzaNraEIE7pFfm8MBO5TNLEpQ3cPZz5MSDNRPzxstu27UnhRB9lrlVGNDxRZqof7ndWT05vKzKhkWgPA7DAVvwHe6FEfPWwfQMareaJD+J/5mps/q+/uxVzGUfjutgkbde6i3wK6gg8IZ2L4tqIaPzdJehcnPvjMzi+8tqc0I4FHkoVUUOm4z0/cfkr8Y6PRAvjlAYPuKAA9NKLB7qdKgGRjB961IQpj5WE+8YKu2n49OL0xYEL7BZC6OxSF4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C49rqTyfz3/bdpRcw7lWMxc9BXCwJJccswQylOwMjKA=;
 b=0L7NJW1lPcU0elmdj23auZMGESKK2ZOB1uoaFPWc5tkKmv26YZw3humrz816GR/KZ4Mnzjr4NswnpH22OuGrGFsFjX1CDWEcvq6LemIppHbCds9P1Jl74AzeylVmzMiKYwklN43zkQaRRMp+GivmZuKXEvk7g+ELQJMP6PfUs+8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Wed, 11 Aug 2021 15:52:58 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 15:52:58 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
 <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
 <20210811121917.ghxi7g4mctuybhbk@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <0a819549-e481-c004-7da8-82ba427b13ce@amd.com>
Date:   Wed, 11 Aug 2021 10:52:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210811121917.ghxi7g4mctuybhbk@box.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:802:20::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SN1PR12CA0061.namprd12.prod.outlook.com (2603:10b6:802:20::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 15:52:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e687563-770c-45e3-d65c-08d95ce0175c
X-MS-TrafficTypeDiagnostic: DM8PR12MB5431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB543199BEF36F29E3840ABFD6ECF89@DM8PR12MB5431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIs6pFyzfEbI1sSDg110Vyq4ekjEacZhpksNjWqlRVa3iscvvqsWl0yYG/1eyCmYp76Raq8v57Gb/CVJw3Azw8HEQVoEaq5Thx2vbGcOq+o252Owo5UvK6qWL25Zrxi8PuOD3hkirYlIuN16HwHgscJSl1gkfhWWJ+tgIjOCuy9IPlRr/w0GuiLta5pf3Pa5xgeet6tYJ4Bl0qidOz5Dg/DeXaiHaslXYoShv4gf36GqOZjt7OVBHL0CcUKLLE5BX9vEjcLs9L8xzJ3LIZNbgD6sF4TiQc1NVgI2If0QT0apr4XF7PVFWbuBKbMWORwiq/k3DVPSMmRvQJ0Sj4ajUMUfiYed3phlTw0ma14v/MLar3DXPEMPkoraDDkVTFqJCmqlLNaCMiJ7KWn4G7ABOiaOw/PtDkREBrgfp7y1pXpmiTAxJ37f8nv7FTSaIqwOQYle7zjdxABeFkOUGiKVWHAIV3VwjsPtva/gytPiDXBngieb9pNTfqjqslUcpbquE5VNNfzrQpo/mAUPWTCW7/Hu8mXZISL0/1jRU1di2XEp2fpD8BMclqx6M8wtgBunrnc/I0MFR3YU0rkTsHRNeKbOzP5toHxiiXBWgQ3YTYCUDO+cUAajBP/GCFAyXDaEU46ApzPiWI8GMXC3jj1A8O5dVEWbP8I9AF4Irnk5vptD4uwvHRigvbpgHaUrIYn47H+vNKBD29pKWeFXdsPc2Ndusema059/N0MezM6QHA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(26005)(2616005)(66476007)(66556008)(478600001)(38100700002)(186003)(66946007)(36756003)(54906003)(31696002)(6486002)(8676002)(8936002)(7406005)(4326008)(316002)(6916009)(2906002)(86362001)(7416002)(5660300002)(31686004)(83380400001)(956004)(53546011)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REY0eis4c2JROTJ4U0pDcCs5UWZGaVA1c2RGRkNPVm1JakVBWHRjRUt0aWpO?=
 =?utf-8?B?RHBlQkppQklNUWJVSEptUWtuc0xLaDlDRW13TUhlWjdBRDd2T29YQWZxOUNx?=
 =?utf-8?B?d2Q5VlBTYzVYVWYxMUd1eTlpajIyUlJqdlluL0pFMW8veDg0YlNqZDkvUGh0?=
 =?utf-8?B?S2d4aHFCS3pMUDJPS2trYitORnRkNTJ0ZWZrV3ZUR3FVcXBZUWVwcjV0djYw?=
 =?utf-8?B?M1dvRWxodmZOeGhXak1ZYXgyMms1YjZUUDMvbFNxeFRkY0NsUC8vNDVGMDA2?=
 =?utf-8?B?TjhaYnRvUUhnZEcvbkh5RHl0Y2N5L1pQZ0IzNzZLYTBDeEdHNXVueWJIQzRx?=
 =?utf-8?B?a1lFd1h0QnVnM0h2SC9HTFpZMXorMnZtNkdKZHREb0dFbzZyZXNOd29vVkx4?=
 =?utf-8?B?ZTFpTVgwV2NKcU50bTFsbjlJT1UwMTFsdnZlYkw1QzJrQ3YxTm96ZHZXZk5E?=
 =?utf-8?B?bU93UThGNmwzVGRGdFFiTURIS2xBcTJkQ1MwOUlTSGwwbDZIU0QrTzBHZVBx?=
 =?utf-8?B?WmhDZVZ3ZlNLcGt1Ujdsd0VRd0RwQVFHdjBIL09vOGtGMHZiMHpNNnVQc2Z3?=
 =?utf-8?B?R0NFVi9XVDNqWHlja01PMVdSdjA4cWVEVWtJKzdpV2JkUzJOZURRSmNTbnA3?=
 =?utf-8?B?RlVlT0xpQ2FNRkpQUUhNMHUyRHkrcENpSk55LzFWTTEzMGxQSlRNL3dBYVl1?=
 =?utf-8?B?ZjZTY09yb1AwMXI3T3dMT1lnakhscUVkYXl3WUNZOEJ4c3NFUjhMbDdKTE11?=
 =?utf-8?B?YU1oT1FVaGZiNGUvL29nRzM0RWE1Ujl5RXpwL2VwRVJtczl3Q2xLQldwdlQ0?=
 =?utf-8?B?L0wwU25xQjQ2NUVubDVZbUZIRUpUUks2MUUrKzBWZ1Vzak1KYk04V3hybTZM?=
 =?utf-8?B?RXZEQnNhMmtXTHE4Sm1LVjFlT3J2UFFuYVVGVXRxS3R4MUQzeHdLdGZYQk5F?=
 =?utf-8?B?YUk4ZFRaVUJVKzBCS0xTek56YzZRVzMrbndMb0RNYituWUZWMlJVZFc5bW00?=
 =?utf-8?B?WFBDRTJzMGZ1K0Vka0FxRng3QURCSjFLVkhoczF4dElOWWFrdjdUVm5Uekox?=
 =?utf-8?B?Sm5tbmRXUDNSUmdRWHNKdTNIS1ZhUDdCOS8zS2d5dlpSNzJ2Y2JYR2czdTFU?=
 =?utf-8?B?KytSTHByeEtQVEhtVXZHcFN4STQyaXRzbmFqSnYzbFdMeGVCdjgyd2VIOU1H?=
 =?utf-8?B?cjJJVjVXZUZCeWRTcnM3TFVHZHloYkRCQXFKcTBrTEtqbUtGeEMxYWl1YzlE?=
 =?utf-8?B?bUdocE55ZERNRGNXc2s2eGFxTVNaZEhEaldVbkRNMkZVODB5NjlHM1FKOEJ1?=
 =?utf-8?B?dDZ5eGpMMUFaOWZWV2NsMWRPMkhUN1Y3ZHZpNHdKcEVNZXVZRzM1UFhpcTQx?=
 =?utf-8?B?SFlhbUhOZGsvTmRoK2paWWZpUkNOSVl2T0JoUUxkMGlYUFlrV3dkcGw2VDZC?=
 =?utf-8?B?b0kxN2p5TUx4SVJIQmFxWnpmaURudU9RaU1MZW1uY1BqSitLR1FoZUtud0NC?=
 =?utf-8?B?Zkc2d1UvLzZ5YnZBQlhrem9iVnVOWkVMV3BTTmJTY01qdkxMNXRrYTVNMDhK?=
 =?utf-8?B?NHBMZGdWQU96b3pIamxYMGE0bk4wUjdTS1RiR2dnbTMyU3JpdXZlMS8wcTNa?=
 =?utf-8?B?Ykk3NGYvaFFEb1ROUTV2YUhsVDYxWUJhTkxBc2NWdEF6QXNxaTBoSXovSnEy?=
 =?utf-8?B?RkN6Y1ZCUEJTcTNOdmV6ZXRhZ3lGTlJUSUh6K0dwK3lrUnkxcENHZUpYY2s1?=
 =?utf-8?Q?ypRlcF5FeAfEhWsnoICXRzLomNBmaC1bm+lcTDj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e687563-770c-45e3-d65c-08d95ce0175c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 15:52:58.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 584esTti7o/5qkD1Os1NRjUfCdW4Sj5anUfUsR50eGnvfwGD5aGvUGjrOq3sJcZZ9e+qkr0NVlAYoU1YOAdy5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/21 7:19 AM, Kirill A. Shutemov wrote:
> On Tue, Aug 10, 2021 at 02:48:54PM -0500, Tom Lendacky wrote:
>> On 8/10/21 1:45 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>
>>>
>>> On 7/27/21 3:26 PM, Tom Lendacky wrote:
>>>> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
>>>> index de01903c3735..cafed6456d45 100644
>>>> --- a/arch/x86/kernel/head64.c
>>>> +++ b/arch/x86/kernel/head64.c
>>>> @@ -19,7 +19,7 @@
>>>>   #include <linux/start_kernel.h>
>>>>   #include <linux/io.h>
>>>>   #include <linux/memblock.h>
>>>> -#include <linux/mem_encrypt.h>
>>>> +#include <linux/protected_guest.h>
>>>>   #include <linux/pgtable.h>
>>>>     #include <asm/processor.h>
>>>> @@ -285,7 +285,7 @@ unsigned long __head __startup_64(unsigned long
>>>> physaddr,
>>>>        * there is no need to zero it after changing the memory encryption
>>>>        * attribute.
>>>>        */
>>>> -    if (mem_encrypt_active()) {
>>>> +    if (prot_guest_has(PATTR_MEM_ENCRYPT)) {
>>>>           vaddr = (unsigned long)__start_bss_decrypted;
>>>>           vaddr_end = (unsigned long)__end_bss_decrypted;
>>>
>>>
>>> Since this change is specific to AMD, can you replace PATTR_MEM_ENCRYPT with
>>> prot_guest_has(PATTR_SME) || prot_guest_has(PATTR_SEV). It is not used in
>>> TDX.
>>
>> This is a direct replacement for now.
> 
> With current implementation of prot_guest_has() for TDX it breaks boot for
> me.
> 
> Looking at code agains, now I *think* the reason is accessing a global
> variable from __startup_64() inside TDX version of prot_guest_has().
> 
> __startup_64() is special. If you access any global variable you need to
> use fixup_pointer(). See comment before __startup_64().
> 
> I'm not sure how you get away with accessing sme_me_mask directly from
> there. Any clues? Maybe just a luck and complier generates code just right
> for your case, I donno.

Hmm... yeah, could be that the compiler is using rip-relative addressing
for it because it lives in the .data section?

For the static variables in mem_encrypt_identity.c I did an assembler rip
relative LEA, but probably could have passed physaddr to sme_enable() and
used a fixup_pointer() style function, instead.

> 
> A separate point is that TDX version of prot_guest_has() relies on
> cpu_feature_enabled() which is not ready at this point.

Does TDX have to do anything special to make memory able to be shared with
the hypervisor?  You might have to use something that is available earlier
than cpu_feature_enabled() in that case (should you eventually support
kvmclock).

> 
> I think __bss_decrypted fixup has to be done if sme_me_mask is non-zero.
> Or just do it uncoditionally because it's NOP for sme_me_mask == 0.

For SNP, we'll have to additionally call the HV to update the RMP to make
the memory shared. But that could also be done unconditionally since the
early_snp_set_memory_shared() routine will check for SNP before doing
anything.

Thanks,
Tom

> 
>> I think the change you're requesting
>> should be done as part of the TDX support patches so it's clear why it is
>> being changed.
>>
>> But, wouldn't TDX still need to do something with this shared/unencrypted
>> area, though? Or since it is shared, there's actually nothing you need to
>> do (the bss decrpyted section exists even if CONFIG_AMD_MEM_ENCRYPT is not
>> configured)?
> 
> AFAICS, only kvmclock uses __bss_decrypted. We don't enable kvmclock in
> TDX at the moment. It may change in the future.
> 
