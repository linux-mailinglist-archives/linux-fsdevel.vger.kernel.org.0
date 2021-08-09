Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081EC3E4EE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 00:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhHIWEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 18:04:40 -0400
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com ([40.107.237.72]:11361
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232683AbhHIWEj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:04:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i46opE2vdbKf2ZrSprtprFOfqeG9cuPadsC969ro0jGirLoEqmGv1Pq8Ok7Agr3K0gNJJxkRQ7uEyrdz0yrHhOwzdM61T8KtnXLa9G5uisp5+mR7A//tdBVeUvqNEmOX2+UqNF2+f7BMlZy74/vSdtRFvjyaBb3HTciyEplA4h+vOS3Z6B8sfFvhpSQ8rxnHNUatg0Eo6D/CcU94BG0+iVF50SSmMYnqPB288PGR4XOQZ+O9PuZfkJYnLiJJv6+ctPGqP/I+CE24kxQMUPhCBTOjhFzEG3UzhaGjEypPYQ48tv+nOiOJhT5HM4GVat1JWikkCz0Sg+XAcv0/+taeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDDc72GiZm6dfKErrWYvKM6m/ePTnVVLaIb8Yz6Ehk4=;
 b=hT+0DFcf5clrassD1oRbJSgQ6y78lWxP90zJ+WbC2yEDLpBFh1mm4Xup2dx/Nf1oaA+8KPhAaMgYP2M06znaLrTQxSVV+HoWD3EgxqJoiOhxP7Pq+7QECVurjapITVJ04GCcgR4Z6Cb6C1LQ8YjVl+uQQ1LdrMLEbnpuwcLqRWRsxJrATdZ9SMNrao/uelaMK7S2FSrG+LpfPt++U9XC08JXZ9lErcGAQeO8yrdzCrKJi1TR6etE3FiBZqRDDxNmVQdvdh2pQxuhj0P/jcS+hRZwy/NjI8gpDiTljx9e8LqRE2lXXpx3rfUeFXF2bi6xZDZg1/sfFcehc1jqIsAERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDDc72GiZm6dfKErrWYvKM6m/ePTnVVLaIb8Yz6Ehk4=;
 b=E26kXdjn4tzuqwDepjlftxSfkzQiAIaO7cFrfeWCeKv1ky4fYpeEimh+mtZrp1OI1A0gpmZlrvEllzgCfWxMpCUlsqJr7dNZvy2aDOYq6InaM4LnOKp6B7d1UhMB6c4qyYtSMRA3LsMiw6JCzCDjZjhtVDvNPPzS0CpxONefbjk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5117.namprd12.prod.outlook.com (2603:10b6:5:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 22:04:14 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 22:04:14 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Daniel Vetter <daniel@ffwll.ch>, Baoquan He <bhe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <ab2b910b-cd2a-d63b-f080-987d0bb4b5a5@csgroup.eu>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <ef0e669e-9d08-993b-26d8-939692032cfb@amd.com>
Date:   Mon, 9 Aug 2021 17:04:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <ab2b910b-cd2a-d63b-f080-987d0bb4b5a5@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0139.namprd05.prod.outlook.com
 (2603:10b6:803:2c::17) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SN4PR0501CA0139.namprd05.prod.outlook.com (2603:10b6:803:2c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Mon, 9 Aug 2021 22:04:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1d08b08-348e-40d7-2dbe-08d95b819fd3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5117:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5117896FEA1FC51B6FB10D88ECF69@DM4PR12MB5117.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+3JPzPUggX8wii77JpckqdMUuJ42OcNOdsy0s1VqRinMmrGdveqyqqtPHJDVI1dbGHSGb0ceR+5MPYeGPE7ndIXkKzqmVmVv2t3qLJs/ZW4xGV+Q+i5k3ZW2HK1cJQmmSUL2GamnOBrEWprMITi2O2Fjy4Mp5xzoFMEDt4U2PKHjLH7auaM6o6Wjj1vh8qj6Z+MTax0sux9kVrv0wbKq9xHwuZpcEQYzHfa4vyH2mrRRp5JVY1PurS2zUkyR8J2fj0+XJTPIXD8Skpn2bXAuJzcZ3FQcPDF1k3dTEGVEXkYeh1iOkb5Gkv2qJA9Q3ASBxoahMD+G7kPPxZkcArlyC5K7QqJALypMC+bGSF1eJ+ZJj2Y9+yMthNQ5ErI2vIVO8/IwMuwq23LuzWHfDRo4ou6CSz31poq6n0bFC2sHK+R149o5213JkYrh/YamMbV2+QCe8q0V9G8bsvVn54vSEVQnH2v1nEP3Y99T2iIVj+po+zhImZ4vX7WVfHRQdMbayc1vVNqdI2j37KNl4n9Scu8iZ3d888hETBqhlzneGtBJFFJ1r3zO9dxLXJXLiG1oTAT3rr1WoYo378B2uFh9uzjUe4cjF88hLDHornZ5Iwh04uwj89AzWMqFFgm61pjhcm1vUG1pOxiSvPvVVN1UMqWM+0qIUgi0m37iatD+Pv1ZJNqdbXM1aCslM8lV1CZ/CTdnMX3Q+9qP9tXhTswd+5UAi5LG0sIv121xWyMJbjE/qRTaDVRb9uF0ft7LiA9mPAsKWAT5vPte8ZWavnJDKGOLrb5L/+GNfvBxmRRtYI2ORALPGK0Oon9xrMM/SJ9HwW7esfJSWq5G0eHjOpGyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(921005)(31696002)(2616005)(956004)(6486002)(38100700002)(316002)(2906002)(36756003)(31686004)(86362001)(16576012)(966005)(53546011)(45080400002)(30864003)(478600001)(8936002)(8676002)(5660300002)(66946007)(66476007)(66556008)(26005)(7416002)(7406005)(186003)(54906003)(66574015)(4326008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJtWVR0d28xUTIyNThoMzlvU3V0T0Vhc1lzTHcydkd4N0hxT1JjL0NHZWJI?=
 =?utf-8?B?blhIdGdON0FXZ3FDQnkvU2R4UUEyRGtKV3hLS1k3SiszbEw3cVdZbGg5L2VH?=
 =?utf-8?B?V1hFSU5hL1hmSHhvY01LdHVmcnZtZlF3eU5Pc3E4MURUM3krQzJ0WTgzZVVI?=
 =?utf-8?B?cHN5L0FPNnpaU1RiZ0tUY05iT20xNVJCRmFXN0QvcFM4bkFwOE9xVWdZUmdx?=
 =?utf-8?B?emZUaVM5MlpKZ2FQOHBBYURrS3JLcFZIYW5Iem1oaUc1ZkxPZE9XZWRDNW1u?=
 =?utf-8?B?NVdlZWx4NnFrNDdFbytkU2lGUG1ZdkVFeVdRMDB6a2ZQV0l5QXpnZWQrV2hH?=
 =?utf-8?B?R1hFQTRkU0hSNENWNnpnTStOcEE4STZ5MkRXSmptVkRVL1gvM1lnTG9JUEFY?=
 =?utf-8?B?MzRmczNDUVVPSWQyNlFEandhbzVBRVFwTDJ2NUZaN0Z6TVpPRFV3eml1ZzNM?=
 =?utf-8?B?dUtseVdpK1FkT2NWeExabHNvRXJYZDhqOThlWGxmK2hXd0JTam5lRkxwMlZF?=
 =?utf-8?B?WktLYytncGNyTHNxSElWWVhMTGNYZWxzQlNpbWcrTFF0L1RpQ0ZzY0tkelVn?=
 =?utf-8?B?S3RhY0FCcUk2R3JIN1RkbjFOL2JNK0pLVStSVHAvcDZHZEZMcUh6QWszN2Nz?=
 =?utf-8?B?dURXTWhSU0VjajJHaE4vd0RSb005dnlEM2ZhTHhJM0V5RHJyNm5NQkdhOVhk?=
 =?utf-8?B?dGZreExKZnY5VUovVEpSYi9GRlpMaEZzU2JQK2pNc1lKczBLUU1HRDF2UnMy?=
 =?utf-8?B?Q0xNN0pzVUZCN3ZoZVZNd204NTV5c1ZIWndGWVEydEErakFsSXlXVUdkMkRh?=
 =?utf-8?B?cHVWejBDTXJEenZ6dXVqbFVHZVY3aTlJZWc2Smh4RmRpV2owL29NN3QxazVh?=
 =?utf-8?B?WVMvN0doNWhuZSt2WDhLbzNOdDZiY2dZdWl4U1E5d0lTTzZJNVFLOGdkMmFv?=
 =?utf-8?B?UnhJdDFlNGxESXBvc1hoT3MyUW1EbW90dkFJeDJkNS9heFN0YzVDQ1NXTFdt?=
 =?utf-8?B?b0wyUEREQUNMZlV1Tit6eVFYRHBQTGo1QmpDUU84REdBNzJNQ1haZjlVR1Jj?=
 =?utf-8?B?NzZiWjYrQlJwa2VOVXpPcW5sY2ZpQS9qQkRtdUZ0NWVZM3Yvekdlb1Zyb1A0?=
 =?utf-8?B?TXZrT3hyS1VpdHd1UGo5TkxuZkRTVWg4dW8xamdTVEhJSUZhZVBvVnJrc1pP?=
 =?utf-8?B?NjQvOXZxR3BsUDFYVEx5ZVVVTlZ0U09uZHl4dm9DVjJTa0JtYi9rNGlDT3hh?=
 =?utf-8?B?WjNCU2xxUFBnTUhDZEdwbUNGbTRuYXJINDNBaWlMSFNSL1RlL3piL29pTVBX?=
 =?utf-8?B?L0FodC9BNTlBT2xJcmE2ZmR3SUd1RXBOVHZDNnJsbU5sZXhDRk14alVFeTBp?=
 =?utf-8?B?TXVMMjY5L2ZUa01BUzh5eW42Z2pKQ2ROTTk3eTF5aHhUcXFlMGNJVWxsNXkw?=
 =?utf-8?B?SGZMQTZodmprTzlnaWF0bFlWTmpXeUhxMXlQTFB0djE4R2hNemdTK0RoQjdz?=
 =?utf-8?B?WlFDWFpoUzdTWTFRbmpHOHpvUDVTOW1ZYWpSSWVQeWRKMzM5MVRWY01oaENr?=
 =?utf-8?B?KzdiMlJvMXBObTFEcEhkTWNwTEJtNXlLZkxxSWxOUE5jSnhrR25qZ1drOUZN?=
 =?utf-8?B?UDZpcVJvSEhET0JtaFpjTDQ4SWNLcjdBZDBBa0E4ZXRSVGtZUGFKK1ByV0tJ?=
 =?utf-8?B?RHh0T1dGMDQ3bG9nZ0JxMG9NODJvc0JRTTFOYjNrYTcyQVRoSE9TRXRCcHJN?=
 =?utf-8?Q?SDDEmkfuOVtLxQJR4qZvah4PjWqv3hzWzxgYwck?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d08b08-348e-40d7-2dbe-08d95b819fd3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 22:04:14.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nhfX73wvO9hcTAWN9QscMsaTxM8C0FcXniu7OsjFycerJJuEK62HlZfWznvt4AHUBScn5VYQjNAIDDgwPXj7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5117
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/2/21 7:42 AM, Christophe Leroy wrote:
> 
> 
> Le 28/07/2021 à 00:26, Tom Lendacky a écrit :
>> Replace occurrences of mem_encrypt_active() with calls to prot_guest_has()
>> with the PATTR_MEM_ENCRYPT attribute.
> 
> 
> What about
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Flinuxppc-dev%2Fpatch%2F20210730114231.23445-1-will%40kernel.org%2F&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7C1198d62463e04a27be5908d955b30433%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637635049667233612%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Erpu4Du05sVYkYuAfTkXdLvq48%2FlfLS2q%2FZW8DG3tFw%3D&amp;reserved=0> ?

Ah, looks like that just went into the PPC tree and isn't part of the tip
tree. I'll have to look into how to handle that one.

Thanks,
Tom

> 
> Christophe
> 
> 
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/kernel/head64.c                | 4 ++--
>>   arch/x86/mm/ioremap.c                   | 4 ++--
>>   arch/x86/mm/mem_encrypt.c               | 5 ++---
>>   arch/x86/mm/pat/set_memory.c            | 3 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
>>   drivers/gpu/drm/drm_cache.c             | 4 ++--
>>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     | 4 ++--
>>   drivers/gpu/drm/vmwgfx/vmwgfx_msg.c     | 6 +++---
>>   drivers/iommu/amd/iommu.c               | 3 ++-
>>   drivers/iommu/amd/iommu_v2.c            | 3 ++-
>>   drivers/iommu/iommu.c                   | 3 ++-
>>   fs/proc/vmcore.c                        | 6 +++---
>>   kernel/dma/swiotlb.c                    | 4 ++--
>>   13 files changed, 29 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
>> index de01903c3735..cafed6456d45 100644
>> --- a/arch/x86/kernel/head64.c
>> +++ b/arch/x86/kernel/head64.c
>> @@ -19,7 +19,7 @@
>>   #include <linux/start_kernel.h>
>>   #include <linux/io.h>
>>   #include <linux/memblock.h>
>> -#include <linux/mem_encrypt.h>
>> +#include <linux/protected_guest.h>
>>   #include <linux/pgtable.h>
>>     #include <asm/processor.h>
>> @@ -285,7 +285,7 @@ unsigned long __head __startup_64(unsigned long
>> physaddr,
>>        * there is no need to zero it after changing the memory encryption
>>        * attribute.
>>        */
>> -    if (mem_encrypt_active()) {
>> +    if (prot_guest_has(PATTR_MEM_ENCRYPT)) {
>>           vaddr = (unsigned long)__start_bss_decrypted;
>>           vaddr_end = (unsigned long)__end_bss_decrypted;
>>           for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index 0f2d5ace5986..5e1c1f5cbbe8 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -693,7 +693,7 @@ static bool __init
>> early_memremap_is_setup_data(resource_size_t phys_addr,
>>   bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned
>> long size,
>>                    unsigned long flags)
>>   {
>> -    if (!mem_encrypt_active())
>> +    if (!prot_guest_has(PATTR_MEM_ENCRYPT))
>>           return true;
>>         if (flags & MEMREMAP_ENC)
>> @@ -723,7 +723,7 @@ pgprot_t __init
>> early_memremap_pgprot_adjust(resource_size_t phys_addr,
>>   {
>>       bool encrypted_prot;
>>   -    if (!mem_encrypt_active())
>> +    if (!prot_guest_has(PATTR_MEM_ENCRYPT))
>>           return prot;
>>         encrypted_prot = true;
>> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
>> index 451de8e84fce..0f1533dbe81c 100644
>> --- a/arch/x86/mm/mem_encrypt.c
>> +++ b/arch/x86/mm/mem_encrypt.c
>> @@ -364,8 +364,7 @@ int __init early_set_memory_encrypted(unsigned long
>> vaddr, unsigned long size)
>>   /*
>>    * SME and SEV are very similar but they are not the same, so there are
>>    * times that the kernel will need to distinguish between SME and SEV.
>> The
>> - * sme_active() and sev_active() functions are used for this.  When a
>> - * distinction isn't needed, the mem_encrypt_active() function can be
>> used.
>> + * sme_active() and sev_active() functions are used for this.
>>    *
>>    * The trampoline code is a good example for this requirement.  Before
>>    * paging is activated, SME will access all memory as decrypted, but SEV
>> @@ -451,7 +450,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
>>        * The unused memory range was mapped decrypted, change the
>> encryption
>>        * attribute from decrypted to encrypted before freeing it.
>>        */
>> -    if (mem_encrypt_active()) {
>> +    if (sme_me_mask) {
>>           r = set_memory_encrypted(vaddr, npages);
>>           if (r) {
>>               pr_warn("failed to free unused decrypted pages\n");
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index ad8a5c586a35..6925f2bb4be1 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/libnvdimm.h>
>>   #include <linux/vmstat.h>
>>   #include <linux/kernel.h>
>> +#include <linux/protected_guest.h>
>>     #include <asm/e820/api.h>
>>   #include <asm/processor.h>
>> @@ -1986,7 +1987,7 @@ static int __set_memory_enc_dec(unsigned long
>> addr, int numpages, bool enc)
>>       int ret;
>>         /* Nothing to do if memory encryption is not active */
>> -    if (!mem_encrypt_active())
>> +    if (!prot_guest_has(PATTR_MEM_ENCRYPT))
>>           return 0;
>>         /* Should not be working on unaligned addresses */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index abb928894eac..8407224717df 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -38,6 +38,7 @@
>>   #include <drm/drm_probe_helper.h>
>>   #include <linux/mmu_notifier.h>
>>   #include <linux/suspend.h>
>> +#include <linux/protected_guest.h>
>>     #include "amdgpu.h"
>>   #include "amdgpu_irq.h"
>> @@ -1239,7 +1240,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>>        * however, SME requires an indirect IOMMU mapping because the
>> encryption
>>        * bit is beyond the DMA mask of the chip.
>>        */
>> -    if (mem_encrypt_active() && ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
>> +    if (prot_guest_has(PATTR_MEM_ENCRYPT) &&
>> +        ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
>>           dev_info(&pdev->dev,
>>                "SME is not compatible with RAVEN\n");
>>           return -ENOTSUPP;
>> diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
>> index 546599f19a93..4d01d44012fd 100644
>> --- a/drivers/gpu/drm/drm_cache.c
>> +++ b/drivers/gpu/drm/drm_cache.c
>> @@ -31,7 +31,7 @@
>>   #include <linux/dma-buf-map.h>
>>   #include <linux/export.h>
>>   #include <linux/highmem.h>
>> -#include <linux/mem_encrypt.h>
>> +#include <linux/protected_guest.h>
>>   #include <xen/xen.h>
>>     #include <drm/drm_cache.h>
>> @@ -204,7 +204,7 @@ bool drm_need_swiotlb(int dma_bits)
>>        * Enforce dma_alloc_coherent when memory encryption is active as
>> well
>>        * for the same reasons as for Xen paravirtual hosts.
>>        */
>> -    if (mem_encrypt_active())
>> +    if (prot_guest_has(PATTR_MEM_ENCRYPT))
>>           return true;
>>         for (tmp = iomem_resource.child; tmp; tmp = tmp->sibling)
>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
>> b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
>> index dde8b35bb950..06ec95a650ba 100644
>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
>> @@ -29,7 +29,7 @@
>>   #include <linux/dma-mapping.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>> -#include <linux/mem_encrypt.h>
>> +#include <linux/protected_guest.h>
>>     #include <drm/ttm/ttm_range_manager.h>
>>   #include <drm/drm_aperture.h>
>> @@ -634,7 +634,7 @@ static int vmw_dma_select_mode(struct vmw_private
>> *dev_priv)
>>           [vmw_dma_map_bind] = "Giving up DMA mappings early."};
>>         /* TTM currently doesn't fully support SEV encryption. */
>> -    if (mem_encrypt_active())
>> +    if (prot_guest_has(PATTR_MEM_ENCRYPT))
>>           return -EINVAL;
>>         if (vmw_force_coherent)
>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
>> b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
>> index 3d08f5700bdb..0c70573d3dce 100644
>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
>> @@ -28,7 +28,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/slab.h>
>> -#include <linux/mem_encrypt.h>
>> +#include <linux/protected_guest.h>
>>     #include <asm/hypervisor.h>
>>   @@ -153,7 +153,7 @@ static unsigned long vmw_port_hb_out(struct
>> rpc_channel *channel,
>>       unsigned long msg_len = strlen(msg);
>>         /* HB port can't access encrypted memory. */
>> -    if (hb && !mem_encrypt_active()) {
>> +    if (hb && !prot_guest_has(PATTR_MEM_ENCRYPT)) {
>>           unsigned long bp = channel->cookie_high;
>>             si = (uintptr_t) msg;
>> @@ -208,7 +208,7 @@ static unsigned long vmw_port_hb_in(struct
>> rpc_channel *channel, char *reply,
>>       unsigned long si, di, eax, ebx, ecx, edx;
>>         /* HB port can't access encrypted memory */
>> -    if (hb && !mem_encrypt_active()) {
>> +    if (hb && !prot_guest_has(PATTR_MEM_ENCRYPT)) {
>>           unsigned long bp = channel->cookie_low;
>>             si = channel->cookie_high;
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 811a49a95d04..def63a8deab4 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -31,6 +31,7 @@
>>   #include <linux/irqdomain.h>
>>   #include <linux/percpu.h>
>>   #include <linux/io-pgtable.h>
>> +#include <linux/protected_guest.h>
>>   #include <asm/irq_remapping.h>
>>   #include <asm/io_apic.h>
>>   #include <asm/apic.h>
>> @@ -2178,7 +2179,7 @@ static int amd_iommu_def_domain_type(struct device
>> *dev)
>>        * active, because some of those devices (AMD GPUs) don't have the
>>        * encryption bit in their DMA-mask and require remapping.
>>        */
>> -    if (!mem_encrypt_active() && dev_data->iommu_v2)
>> +    if (!prot_guest_has(PATTR_MEM_ENCRYPT) && dev_data->iommu_v2)
>>           return IOMMU_DOMAIN_IDENTITY;
>>         return 0;
>> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
>> index f8d4ad421e07..ac359bc98523 100644
>> --- a/drivers/iommu/amd/iommu_v2.c
>> +++ b/drivers/iommu/amd/iommu_v2.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/wait.h>
>>   #include <linux/pci.h>
>>   #include <linux/gfp.h>
>> +#include <linux/protected_guest.h>
>>     #include "amd_iommu.h"
>>   @@ -741,7 +742,7 @@ int amd_iommu_init_device(struct pci_dev *pdev,
>> int pasids)
>>        * When memory encryption is active the device is likely not in a
>>        * direct-mapped domain. Forbid using IOMMUv2 functionality for now.
>>        */
>> -    if (mem_encrypt_active())
>> +    if (prot_guest_has(PATTR_MEM_ENCRYPT))
>>           return -ENODEV;
>>         if (!amd_iommu_v2_supported())
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 5419c4b9f27a..ddbedb1b5b6b 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/property.h>
>>   #include <linux/fsl/mc.h>
>>   #include <linux/module.h>
>> +#include <linux/protected_guest.h>
>>   #include <trace/events/iommu.h>
>>     static struct kset *iommu_group_kset;
>> @@ -127,7 +128,7 @@ static int __init iommu_subsys_init(void)
>>           else
>>               iommu_set_default_translated(false);
>>   -        if (iommu_default_passthrough() && mem_encrypt_active()) {
>> +        if (iommu_default_passthrough() &&
>> prot_guest_has(PATTR_MEM_ENCRYPT)) {
>>               pr_info("Memory encryption detected - Disabling default
>> IOMMU Passthrough\n");
>>               iommu_set_default_translated(false);
>>           }
>> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
>> index 9a15334da208..b466f543dc00 100644
>> --- a/fs/proc/vmcore.c
>> +++ b/fs/proc/vmcore.c
>> @@ -26,7 +26,7 @@
>>   #include <linux/vmalloc.h>
>>   #include <linux/pagemap.h>
>>   #include <linux/uaccess.h>
>> -#include <linux/mem_encrypt.h>
>> +#include <linux/protected_guest.h>
>>   #include <asm/io.h>
>>   #include "internal.h"
>>   @@ -177,7 +177,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t
>> count, u64 *ppos)
>>    */
>>   ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
>>   {
>> -    return read_from_oldmem(buf, count, ppos, 0, mem_encrypt_active());
>> +    return read_from_oldmem(buf, count, ppos, 0,
>> prot_guest_has(PATTR_MEM_ENCRYPT));
>>   }
>>     /*
>> @@ -378,7 +378,7 @@ static ssize_t __read_vmcore(char *buffer, size_t
>> buflen, loff_t *fpos,
>>                           buflen);
>>               start = m->paddr + *fpos - m->offset;
>>               tmp = read_from_oldmem(buffer, tsz, &start,
>> -                           userbuf, mem_encrypt_active());
>> +                           userbuf, prot_guest_has(PATTR_MEM_ENCRYPT));
>>               if (tmp < 0)
>>                   return tmp;
>>               buflen -= tsz;
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index e50df8d8f87e..2e8dee23a624 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -34,7 +34,7 @@
>>   #include <linux/highmem.h>
>>   #include <linux/gfp.h>
>>   #include <linux/scatterlist.h>
>> -#include <linux/mem_encrypt.h>
>> +#include <linux/protected_guest.h>
>>   #include <linux/set_memory.h>
>>   #ifdef CONFIG_DEBUG_FS
>>   #include <linux/debugfs.h>
>> @@ -515,7 +515,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device
>> *dev, phys_addr_t orig_addr,
>>       if (!mem)
>>           panic("Can not allocate SWIOTLB buffer earlier and can't now
>> provide you with the DMA bounce buffer");
>>   -    if (mem_encrypt_active())
>> +    if (prot_guest_has(PATTR_MEM_ENCRYPT))
>>           pr_warn_once("Memory encryption is active and system is using
>> DMA bounce buffers\n");
>>         if (mapping_size > alloc_size) {
>>
