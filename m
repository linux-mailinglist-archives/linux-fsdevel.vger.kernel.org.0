Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A812A3EC96B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 15:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhHONyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 09:54:10 -0400
Received: from mail-mw2nam08on2063.outbound.protection.outlook.com ([40.107.101.63]:27105
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231881AbhHONyI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 09:54:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD09H7ACZLLW4Ya1hw76VxrjSHKf3UidL7/Y8AiiP2imj5pK8f0IQ5LNfOQyps2VuNNqRAp+iidaU30foPeMNZFTOcDP3xIGBG55BzyiJxK+BWKwtFyEWCgMKroWef7ZMEcexOltTaiFjzrtoAnPSqZDkgAwOxMMqGanjqh2qjDO2c05hQws+6biedzI2mE+/JwKR2kYje2+F9ymgT1YlebAwMXDLGCPKfJ+grebOrPUplrinLBDWUWpINxEprqS93OeSa1/fVzOKzCZv1z1/0ZJkfjwZuiGs/PniVUCqOfLJCh5FMFcp0jQr2foIES/jerBQzDSgc43K3lkKaBzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgBzeP767FfdAsUtTu1keXcR8NHIOMRf8WfHH15zwJg=;
 b=DlIFlLYIsHlmBLIDkYk8Pq5LYLZVmE4Bdgb2/HQPRNb0WQyBIp2PNI1aUs2TGl5r/2ioXqe2yH9ocLehf6dxK+wuTjYaXP/Bo4YIOZ+VpEEgRxLNFP2YiX3lNQr9om8x/m0uom6TXZ5yEfiPj0yY/LYhY1eFlqLGbvb2mwSRIE5VRmmBl4tdNcRzkJ5R0gEUNVtwcdR5NHhrzTEPpnT9Dj1/WnGKCTBD+RXGxEv8Jwvo+1zDuaIKBHPi/Xnl2Rht5Jajkeum+EC3lgjy63m1fq84XHD+jeshMWf+leWWFrQQ8ak+1iZUnFhlu5pO2cTC9jgUdYB67p93SxcjOLGUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgBzeP767FfdAsUtTu1keXcR8NHIOMRf8WfHH15zwJg=;
 b=JKQSZG4rVXYLwXNe0kMuPA0I7Ql+p06XpYc9irhmBuMitbhI+9wXKlYJi/7kLv6TAphRauDFD3tp92QoNTw2Wbe6s5LjKwFYkeedQvkWF9InehRgstvkwLtTxbS0DVnyUKn+R6Xp7qLwsF/QU+OPwVTH3edP4DDz4e7p1H+vXOs=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Sun, 15 Aug
 2021 13:53:35 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.022; Sun, 15 Aug 2021
 13:53:35 +0000
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
 <YRgUxyhoqVJ0Kxvt@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <4710eb91-d054-7b31-5106-09e3e54bba9e@amd.com>
Date:   Sun, 15 Aug 2021 08:53:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRgUxyhoqVJ0Kxvt@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:805:de::31) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN6PR05CA0018.namprd05.prod.outlook.com (2603:10b6:805:de::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.8 via Frontend Transport; Sun, 15 Aug 2021 13:53:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eb6287c-128e-4f7c-ec57-08d95ff4133a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5088:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5088337C3B2E37D0E09FB26BECFC9@DM4PR12MB5088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyeFxy9hJwWytssLtxoeotOKS3TPFc7oNX+3W5BhC94AwynH9sUjWNo9IWW7AblQYEjNbeNLFTymYluQDdtE47RMGCS3Kktz+I134Jr9TymdiUQaDbnlgo1dfovTXjocXPa8luVX66ySJd5bEMzKh/DIdbRxwEwu3wnIMm2Zux+x2fNP/KT8K6TTNjpUd1XemTKagY9miFSrGkb5rrsKofHVr4J7nHssqZF7MTf+W/C1Y6t2OknfuDWAEDOM4jHybV70FTRvCDV9/OKO46DSIjjc3/yBfGtUGWWFag26UFZ5s8uYn3pkHsTv8zVk8IqALoERrfjLTQlNnr/TXjyKhpdRQSpIPOVUvfSkkJySaHXyvF7ICPMuMkSev8CNmprZI/S3Ttl+McUZwUAOeK16fRSrgyE+02Afkbvwr626oZgThYXSLxXXJOBnGZb4alzMQBI/Q4E2uEx9xYyXkaxhSHFpdtxgV755ck22GBVEhLiCgKxEbdN2IWwJloQhyVUQ3Evb5w3dhRLc+tZYP+dQHM158dpGbUFEtDN+xVUrFIs97vBNmDNhuIvDUjhhFFiGM+w9veZlLmejrPYQyi+G/WS0qeps1P6+3eyZvhtz6hRwcvo3o3RaDEEPqhjTLQRHzYO702QzQgmYBW0QTntojkLbgadtNskJfY2z2gPuwIQdksjyIR0tKm3374L03UU/Z5LTvBR3KXNHRefGOjVKecjZ1w2AlUiiyz8/BPbhGUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(53546011)(8676002)(5660300002)(38100700002)(66946007)(36756003)(31686004)(7416002)(2906002)(31696002)(26005)(66556008)(186003)(66476007)(86362001)(478600001)(6506007)(316002)(6512007)(6916009)(956004)(2616005)(8936002)(4326008)(54906003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlYRXVUWWtyTGF4dHlESVUvRmJKWCtuc05BbDJKa3lNQmx6UWExTVBaWGJx?=
 =?utf-8?B?RU1rbUNpUWNZOFc1N1puWmlJTXY0LysxWXdxZ1RnaHgxbjZxMWszVTVoL0dr?=
 =?utf-8?B?YStzazBuV1I1NThGNzh3VThRQ2dxOEhhZCtlK0xsLzE3ajBDQThGYlVZb0dN?=
 =?utf-8?B?SjlxVGQ1NGhqZ0hUaHQ5YkxjdzV6YVphZWJFV0w4R1dyem11WVk4VHAxQTBY?=
 =?utf-8?B?QTVKQW9hOGdUWExEL0hXWjhPdm1mMlEvY0FieHZDM2xnWWJsRjY2ZzYzRUZ0?=
 =?utf-8?B?a2lWdkdoaGpJS0dBK2N4S2I3UGNoQXNuSEVGV0tGb0VDYjJhclNVZDRXUVY1?=
 =?utf-8?B?WUZ1K2tNN1VGS212Y2JDa0NOS1ozOGNVTlZQSW9YNXEzR1NQaEw5a29wR1hj?=
 =?utf-8?B?QzBrMFpNWVhDOXZwcGZMRGFMdEJvZStnQmFmNlRzd0xJSzh4aDJGRFlWbFlk?=
 =?utf-8?B?bFZiMkZuZzhJUWZHeXAyaG5ScDdsbXgxbjhrcW01dHpxd29sQ1FYSXV5S3RJ?=
 =?utf-8?B?bnBzVzh5bERVNE5HdHdHOVFUQnh0N3VTeWZkcm5nY2lsYmpIMzlIcU4rT0Ji?=
 =?utf-8?B?dGh4dVhBZXRGRVBRWUs1cnlQcnlhYkVOcFFiKzVRbUw4Y2JvRWJab05Eamxy?=
 =?utf-8?B?emhTZllacU9hZkRjMG56SmFRN1NkampEazZlcFY4SndxZWkrdE9waXNMSWYy?=
 =?utf-8?B?TjZKTVRmdHkybEZmZWN5T2MxbmVrZzdoRDN6aVF0aStqVDM1aXc2RlNldGNF?=
 =?utf-8?B?TjJ4ckwxNUQyUTIyZjlDZVJjUTY3UytJalovWGVoZG5RZUNQSjhOdnRoUTVL?=
 =?utf-8?B?aTJFeVdETzNzcTkwSkd0MmxHOVE3YndrRmM1d2pLNisvOVlqNjV2WFVIb2Fa?=
 =?utf-8?B?UUpUSVJXZms4SWJmYkp6dk1JTHpNWTlFelBaNFByRFZjNUZYU0F0anJ5TzRv?=
 =?utf-8?B?N0x3ak8yd3FqbGw1N1hPeU1oRkVuR1QvWUptVFlmVkpQZTZzdzN5U3dhaERE?=
 =?utf-8?B?WlNqTG9HZ3k4ZjZOSWlHVnBpUmJhb2JOTWx6bURWQlBiTnh5RkdhSEpBMW1K?=
 =?utf-8?B?RkhXamZoWHBDck5FalBERnlINXpJZGRaY29tOEllTG43RGEvU1lJc0NoNEdn?=
 =?utf-8?B?SVFSNmltSGY0TWtOb3pxay9vOXBOUkJBMmZDTDBiZ3lVczNUdnIza2tpTnd6?=
 =?utf-8?B?dzROYUE5QndnRTJOVkNFZU95YTFDU1ZZQU9rY3JXQkozQWlUQm96dVZkNldW?=
 =?utf-8?B?OTk4Zll6T2dRemFWRE5NakVGWWhyQ2NJVElvS2Yrc2h3SStud2RkRW5qKzJX?=
 =?utf-8?B?VGpZNTRuMUlGZVM5VHhldTQyaS9veFZ1SDlGc1BqdFlOZERhcDhxMHFjRDdk?=
 =?utf-8?B?VzJIM21iSzlNak8yYnZMRW9DOExvVXhFM0h6SkRZY2d4T0xZYlFhS0FDbERP?=
 =?utf-8?B?RWdSaUtuN0tpck40djdzdlUvQ0RpaDZ3Nmx2YW84MFY1RUpjNWtaMEpTMEVq?=
 =?utf-8?B?azZLTG1NelJFNnpZTGlwY1I0VjJFdjJvY1lXcFZ2aHQvSU52UEFKNkNWbzBJ?=
 =?utf-8?B?Z0ZSOGdTUVdxWWdxamtvblZPZFdjaG9LNkhHcU9LbitZTDhlV09oUFhCVWJx?=
 =?utf-8?B?ZlFic1pkdGFrVGJJVTE3S0tHdEtxbFhtb3BzaDgyam9VNFNhendVbjVicGJM?=
 =?utf-8?B?OUQ0OTMyS1BGOHFiY244bGVMWWkraVo3Und6S01FWHA3WWcrc2d6R1FCQkw2?=
 =?utf-8?Q?lVdyHazwSPxRB5vwZICGA/LnrghO83oJZ28fR3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb6287c-128e-4f7c-ec57-08d95ff4133a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2021 13:53:35.3234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6b8qCAbrTrcSra3Y+hjtE9hXq34FkLJYPFHYwX1daMbk3M//EPUEldqIG3u0VR+4ZofGl+TZN2c0lHECwVH/7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/14/21 2:08 PM, Borislav Petkov wrote:
> On Fri, Aug 13, 2021 at 11:59:22AM -0500, Tom Lendacky wrote:
>> diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
>> new file mode 100644
>> index 000000000000..51e4eefd9542
>> --- /dev/null
>> +++ b/arch/x86/include/asm/protected_guest.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Protected Guest (and Host) Capability checks
>> + *
>> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
>> + */
>> +
>> +#ifndef _X86_PROTECTED_GUEST_H
>> +#define _X86_PROTECTED_GUEST_H
>> +
>> +#include <linux/mem_encrypt.h>
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +static inline bool prot_guest_has(unsigned int attr)
>> +{
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +	if (sme_me_mask)
>> +		return amd_prot_guest_has(attr);
>> +#endif
>> +
>> +	return false;
>> +}
>> +
>> +#endif	/* __ASSEMBLY__ */
>> +
>> +#endif	/* _X86_PROTECTED_GUEST_H */
> 
> I think this can be simplified more, diff ontop below:
> 
> - no need for the ifdeffery as amd_prot_guest_has() has versions for
> both when CONFIG_AMD_MEM_ENCRYPT is set or not.

Ugh, yeah, not sure why I put that in for this version since I have the 
static inline for when CONFIG_AMD_MEM_ENCRYPT is not set.

> 
> - the sme_me_mask check is pushed there too.
> 
> - and since this is vendor-specific, I'm checking the vendor bit. Yeah,
> yeah, cross-vendor but I don't really believe that.

It's not a cross-vendor thing as opposed to a KVM or other hypervisor 
thing where the family doesn't have to be reported as AMD or HYGON. That's 
why I made the if check be for sme_me_mask. I think that is the safer way 
to go.

Thanks,
Tom

> 
> ---
> diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
> index 51e4eefd9542..8541c76d5da4 100644
> --- a/arch/x86/include/asm/protected_guest.h
> +++ b/arch/x86/include/asm/protected_guest.h
> @@ -12,18 +12,13 @@
>   
>   #include <linux/mem_encrypt.h>
>   
> -#ifndef __ASSEMBLY__
> -
>   static inline bool prot_guest_has(unsigned int attr)
>   {
> -#ifdef CONFIG_AMD_MEM_ENCRYPT
> -	if (sme_me_mask)
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>   		return amd_prot_guest_has(attr);
> -#endif
>   
>   	return false;
>   }
>   
> -#endif	/* __ASSEMBLY__ */
> -
>   #endif	/* _X86_PROTECTED_GUEST_H */
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index edc67ddf065d..5a0442a6f072 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -392,6 +392,9 @@ bool noinstr sev_es_active(void)
>   
>   bool amd_prot_guest_has(unsigned int attr)
>   {
> +	if (!sme_me_mask)
> +		return false;
> +
>   	switch (attr) {
>   	case PATTR_MEM_ENCRYPT:
>   		return sme_me_mask != 0;
> 
