Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082AF3EEEBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbhHQOrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 10:47:39 -0400
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:31295
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237387AbhHQOri (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:47:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4j4u5m8vnlRwnvasdRSJv9ODjdi2yYrnMGiCkZDXX71u4Zbf4xHhGv9Qd7vIjSl/z7qI/pEAqoKIorcikHKVcf2gycQVYZcns9AnQie59xiy/gIhMQG3JXxlY3HCXOfVeR99kPDN066BC2x13c5yTSQcs6RykdETQn0gMoJQvHKLMZO+pB8arg6KaFQS5K+fsVAa05zLX13hS25kxVoC5fhRbnJsspgR/jfYcV79CoJqdMIQM0fd/mjI2rA/U96K7IN8xxK35aPfRuZS8Ypj1c/KTr+XfnJwQTQ8Q/lYnURHsvIiJ7SstApu3g3pp5hdECH4sXMh7R81OovUSdpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNeGmIs0HRkD/nGDS+V8QKCMCHsVsj/F4DJnOc7ySuA=;
 b=XqoMogiwkd4uczyCKRUUuZg6HaTCIBEbA0qV1kxMH3yDjZbjyNU16Pf7Wh9c+ShOYcIICFYojnrtUKNctkj+7YMQQ867g9OQL1zBDI02mveH6JMF0Da0G1ZA6CZBgOQ/YiKKCa9Pp2fXZ8VpGy8wRGgjwCv41KWfXyXnOpd9Uhb/U+XAFCKEwAhryjWJjn5T37IVznQ54+oOVJ8mSnJV2IbliOo1UlPiPqSpKBgPseYzzIm/1mAL8u57Fy3zhvRFDnGoHd86eSiphY9Al4bpShtHbyPAdviQsJkldG2A32G8CSjqTWdrR+jLxZEGiZC5WZ433hvlBf6j17aKb2tlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNeGmIs0HRkD/nGDS+V8QKCMCHsVsj/F4DJnOc7ySuA=;
 b=3Hc2Bngz6kDfrAdJ+4h217hnHJdTrGs/2OR3IHEGKbsgrrH/cQndzSh+IN+ji8aQOxYL+qW3k3VjQcpKC5wkNuMoFNMJPAkazbTlRCjFRaOUtPcYKxsnK8p6bvfkriOJLEmliloJnzTmwRE/pGqE5J10+t+r0XJuMlDrn028vLg=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 14:47:01 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 14:47:01 +0000
Subject: Re: [PATCH v2 05/12] x86/sme: Replace occurrences of sme_active()
 with prot_guest_has()
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
        Will Deacon <will@kernel.org>, Joerg Roedel <jroedel@suse.de>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <c6c38d6253dc78381f9ff0f1823b6ee5ddeefacc.1628873970.git.thomas.lendacky@amd.com>
 <YRt6yCNCBLwyyx5X@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <2996b1c8-1ea1-0e56-3aad-08b46fc207f0@amd.com>
Date:   Tue, 17 Aug 2021 09:46:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRt6yCNCBLwyyx5X@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:806:d0::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SA0PR11CA0040.namprd11.prod.outlook.com (2603:10b6:806:d0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Tue, 17 Aug 2021 14:47:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aef3fda-7508-4862-66c9-08d9618ddf55
X-MS-TrafficTypeDiagnostic: DM4PR12MB5296:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52965B6B0B441702BD868939ECFE9@DM4PR12MB5296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+QGaRM/3dD10YgWTVP85PG1drwqffmTULj/OIsn5l5V6THBW+mbaugJuHqPY+XGFvFaiwb+EK8w8RSNv5b0q5A+0xFnO5ZHrc2W7tUUXQJGdyI31Oyvrn9OnEpS8HKf6xr1kDHh8JVWj2O7oJvFsG6YNgZN+idHam8E+j76HgNQN0CQrffhk2Nzvp/8K6Nmd04ECNbp7zifGY27zzly4NNJOS2AQbctVXV1bicceU9wkmlqENESOKFLVCZKl3PL1M+rRUx963tpsXxJ9pPvN9cwnKcNY0AKYz4aH+SRHumsMsow0Ftqycb7pMCtTLs4IKqgBy6SMi8hmpRLY1HVQS4pJxKxzG2/N/wQ5rmhHS/MUkyxG0Vl7i/44wD7vDDZfYMODbiTRhAahpeQ/PQRIjlnX9va+KB55z4d38hvRBzB8Psxw0I6itGudWJOQOs3bJBAkyu+KlWHorLBmcco7IwtK8M3AM4StJAa5Lg0Yoyo7xGQNvBMT0uKjwRq5gEHGMLe4PDnBepP1cM+D6xErD/v++iSYjK8LQENm2f+nxfOCFJBEYHdV8LvNerGem9L0RgPrrQAFTA6Fp+2Ckvsa/MChPU/6DeTO2WDMXyjoKAl55VF4CoGGZDgpaSqbYmGuiA1Y2810I3bUkyyV4BGd9oVIHdjHiANvHVJ3yM517SMnbMsg7cPYPcMsN0SmLF3g8nQ3PZ2PW7zI2/0f4co1YUNFI7xtAZhyeo4eSfd+W0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(316002)(16576012)(54906003)(4326008)(31696002)(6916009)(66476007)(66556008)(6486002)(7416002)(5660300002)(26005)(2906002)(53546011)(956004)(2616005)(38100700002)(66946007)(36756003)(8936002)(478600001)(8676002)(186003)(83380400001)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3VXSDNxUk1FeWFkK1BqMWt2LzZqSzBnWXc3TGJ5RTVZK1l6RnJNYXA0d2Jr?=
 =?utf-8?B?RVBQSzJKOGxndW5od3huMEt1UHplWVVjNWhPWVVqSlZtOGdKcnZTQ0JDek5i?=
 =?utf-8?B?bkowNk5yV1pYd0JKcnYyU1YzVk9Ja2Qzb0VSQWhnaWx2VVc5TzVudlZnc3Uv?=
 =?utf-8?B?ZEt3TUppcE9oRnhzdmdZQWJwSktCai8rYmkreTFnRjVaaFhDVHVvRHhocFpt?=
 =?utf-8?B?TWJSU1Uxa29mc3NzNmR5S0dXVHE0eUJML3QzZ1dTVDZiWjBQSStxTWFOTC9F?=
 =?utf-8?B?dEtPZkJrTDc0dmYwNkZtWVAvTWw3T2h4VDBDdGl1b1NIemxrOUlxaDNmSzF3?=
 =?utf-8?B?OEt4cXF6cTFzQytSUzJlcGM0eVJRZmkrb2J0R01LelMrR1FPdnQvYUNXYVlz?=
 =?utf-8?B?NDNRL2JJd0tFY2JYcGtmYnBnMnRadmQrTnVIa3dKQ3U0cGg4TkphM0lUODhP?=
 =?utf-8?B?SysrcHRYN3BVNjhJVjJRN1ZrSFJ4M2FQK0tPNnh4ZUFFbUZxdlhiRTBmR21W?=
 =?utf-8?B?SnFHcEVRZEJ1cFRDQ1lYdUw2cVRkMy8weWJSZTZvSmY0d25uSTBNa0w2WnlS?=
 =?utf-8?B?ZFlneHZwaEMrNzloc1hQTFQxVmYzNHdPUHB1Smd2eXhTOXBtZnJXa2M2LzJh?=
 =?utf-8?B?a0FVNTEwNlUzak5Zak1aYnAzTExrODRLTjFyc09oZXhaSGRsRU5sVy94a05Q?=
 =?utf-8?B?ZlErb3g2Z3BialdqNTNnU2JaRnNBdEExVTJXbGYwZUZ0ZGxIa3pKalovRmFB?=
 =?utf-8?B?aUlBL0VEWmZ3RExaT0s4eFNJSlVzbGkzQ0lKOFdtNGxhNE9JUjVRczk4NkRM?=
 =?utf-8?B?a002WmxVNkVsNU5uQ0ZBSEk2bkp0YU9UdzRyWDJpdXF6cGJlVGlqTTdjeFVm?=
 =?utf-8?B?eXA0ZkR2V0pCSjIzcTE2WExRd254NVU4NWp6b1ZFWFVQVHd0RURlWFZ0VzBx?=
 =?utf-8?B?aDRCV3NRQ2UxRnRFRFFNRm10dlJLZTR2MStTbFVPdnl4dWpPRVVNNnhNcUtM?=
 =?utf-8?B?VHE0Z3Z3Yk9UTG91dzFnY1BRV1RFWWE3RlBlbzFaSGs1ZUNjTFFud1RGUnVu?=
 =?utf-8?B?NlhhUWh6aHlITmR3SjBVbGRHOVgvcjlaai83cHphbVpHclVKVmdjOHUyWE5p?=
 =?utf-8?B?UlY3S1JSa25uaHlyRm5ubHkyWVJnZnFveHppWFdLeE93djlURzJQaURBUjN3?=
 =?utf-8?B?V2E3U0xjSFZRSUVpeXhiQWVQV0E3d0Vua01uWkZHM0tXRnFlclJnS1Y0MElw?=
 =?utf-8?B?dUhNYkdoL0h5YWM0RDNxUWRaMDBJbTExNWFoQ0ZMUWdLMWdPck55TjVyVUVS?=
 =?utf-8?B?TTh3dW9ieHBHejZFdTBDdS94YkNzSUFLYXF3VmpGSHJOeVlac0VYNEhwN09o?=
 =?utf-8?B?RUN2c1FIczZPdHljb2hLeVB3amxkb2FtZmFpbDd4WVZodkZ3Z0RvN2FCQ0xL?=
 =?utf-8?B?T1RsczdkK1JHS1ZSd2VjQzNMcTNXZzlJaEVLTjFNUEJJMy81QnR2Z0NTb2tC?=
 =?utf-8?B?SVNsOHlyaldhOC9WTUJSVjJPSjJoYkNaZ3EvTVdxV1pPdzVUakVhQnE0VmNT?=
 =?utf-8?B?T3NXc2RGazNZeUpMcWh6R3U2Uko0VnRnM2Fwb0dQVlEwUGFMQ3JDb0VZbDVo?=
 =?utf-8?B?eGI4eUtTZEZqM1VJSVpPYnRSbnIrTkZscU0rdDdsYlBpaFI5aWJNcTU3VGt0?=
 =?utf-8?B?YlV0NHBKNXdkNXNnbndKUkxyRkxyeFYzcC91aGl3Tll0b2ZJUDNleTFEWDRD?=
 =?utf-8?Q?BqYpBJs+lNYPZCe/eUhp+KEVPxDy1jKWQKa0h4k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aef3fda-7508-4862-66c9-08d9618ddf55
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 14:47:01.6965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3Z9RvqJS33LCq0bI2exHo1PjsjgSFrxkRpRvWe2W66REonT1KP4K9iYlLvEJ3d2UutqJUW740LkVpG6OsEh2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/17/21 4:00 AM, Borislav Petkov wrote:
> On Fri, Aug 13, 2021 at 11:59:24AM -0500, Tom Lendacky wrote:
>> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
>> index edc67ddf065d..5635ca9a1fbe 100644
>> --- a/arch/x86/mm/mem_encrypt.c
>> +++ b/arch/x86/mm/mem_encrypt.c
>> @@ -144,7 +144,7 @@ void __init sme_unmap_bootdata(char *real_mode_data)
>>  	struct boot_params *boot_data;
>>  	unsigned long cmdline_paddr;
>>  
>> -	if (!sme_active())
>> +	if (!amd_prot_guest_has(PATTR_SME))
>>  		return;
>>  
>>  	/* Get the command line address before unmapping the real_mode_data */
>> @@ -164,7 +164,7 @@ void __init sme_map_bootdata(char *real_mode_data)
>>  	struct boot_params *boot_data;
>>  	unsigned long cmdline_paddr;
>>  
>> -	if (!sme_active())
>> +	if (!amd_prot_guest_has(PATTR_SME))
>>  		return;
>>  
>>  	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), true);
>> @@ -378,7 +378,7 @@ bool sev_active(void)
>>  	return sev_status & MSR_AMD64_SEV_ENABLED;
>>  }
>>  
>> -bool sme_active(void)
>> +static bool sme_active(void)
> 
> Just get rid of it altogether. Also, there's an
> 
> EXPORT_SYMBOL_GPL(sev_active);
> > which needs to go under the actual function. Here's a diff ontop:

Will do.

> 
> ---
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 5635ca9a1fbe..a3a2396362a5 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -364,8 +364,9 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
>  /*
>   * SME and SEV are very similar but they are not the same, so there are
>   * times that the kernel will need to distinguish between SME and SEV. The
> - * sme_active() and sev_active() functions are used for this.  When a
> - * distinction isn't needed, the mem_encrypt_active() function can be used.
> + * PATTR_HOST_MEM_ENCRYPT and PATTR_GUEST_MEM_ENCRYPT flags to
> + * amd_prot_guest_has() are used for this. When a distinction isn't needed,
> + * the mem_encrypt_active() function can be used.
>   *
>   * The trampoline code is a good example for this requirement.  Before
>   * paging is activated, SME will access all memory as decrypted, but SEV
> @@ -377,11 +378,6 @@ bool sev_active(void)
>  {
>  	return sev_status & MSR_AMD64_SEV_ENABLED;
>  }
> -
> -static bool sme_active(void)
> -{
> -	return sme_me_mask && !sev_active();
> -}
>  EXPORT_SYMBOL_GPL(sev_active);
>  
>  /* Needs to be called from non-instrumentable code */
> @@ -398,7 +394,7 @@ bool amd_prot_guest_has(unsigned int attr)
>  
>  	case PATTR_SME:
>  	case PATTR_HOST_MEM_ENCRYPT:
> -		return sme_active();
> +		return sme_me_mask && !sev_active();
>  
>  	case PATTR_SEV:
>  	case PATTR_GUEST_MEM_ENCRYPT:
> 
>>  {
>>  	return sme_me_mask && !sev_active();
>>  }
>> @@ -428,7 +428,7 @@ bool force_dma_unencrypted(struct device *dev)
>>  	 * device does not support DMA to addresses that include the
>>  	 * encryption mask.
>>  	 */
>> -	if (sme_active()) {
>> +	if (amd_prot_guest_has(PATTR_SME)) {
> 
> So I'm not sure: you add PATTR_SME which you call with
> amd_prot_guest_has() and PATTR_HOST_MEM_ENCRYPT which you call with
> prot_guest_has() and they both end up being the same thing on AMD.
> 
> So why even bother with PATTR_SME?
> 
> This is only going to cause confusion later and I'd say let's simply use
> prot_guest_has(PATTR_HOST_MEM_ENCRYPT) everywhere...

Ok, I can do that. I was trying to ensure that anything that is truly SME
or SEV specific would be called out now.

I'm ok with letting the TDX folks make changes to these calls to be SME or
SEV specific, if necessary, later.

Thanks,
Tom

> 
