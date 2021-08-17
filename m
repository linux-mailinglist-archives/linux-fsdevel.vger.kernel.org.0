Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575F63EEF1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 17:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbhHQP07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 11:26:59 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:4457
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230369AbhHQP06 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNJEBnIEWA7/SPKOeEmjQnNL5g2GwSAziNK6GsfBPxpAE6e5lBPRBHY+yYJ/7VCsirt//mHpth1ONc3zm6K/XaXZL+uec1Av0sRBY4eLRkMN/i+aqUoeV6dOMJ7pGmv/Ya3ruXPulRGrbQuKEEDrxRAZRERpSzjG7Y5yXqTSFUEzNYoh9RBmrRDkW+BwuNQWTt4L9H34OJd6GoZgBYSvqOamMIFYIe7RWw3vEY7Jc+KemHmR9omSC1GpdNCVwbauamPg1ObGO92Ol0YXNjlnleAgwT/cd1vrDkB7z0wgwyXZlnJnROL7M7N9NVa5Bf9VYRp7mcDs2Bhal/pwPP775A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQPJ1r13ZbmsTStp7v4k18XezMw9EX6mezR1AYkkJdI=;
 b=eX+XVs0tKvgTptKT86GShf1Y63KLvsd8/dd4gDS7EjYBN714hvwwa3CBjWxqqorNL16/RGgQBGKCJKrxwMw1lHJcFhzGluklkpk00+OzMdby9rkb9HMMxXkDpsnW/XXxuykVk0gyZMWtwUWlYcvaARl2isWV0cU2ksCdFqFzBihdy8pXAzimum0IjN52ifQV85nPyvwIjNsSHuOVouuV3YfABPy0e0p39NPoIwEjU9x1UqCv1Up/TO0nPAdyYI5rF8SAFGh5FxbaLvLr6nK/8oedY0q+OXlKB3NZ6N7xWYdMXa+eUCU4mkxBWuztdFvDvyoeLQSbMjCrHQt7y2QxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQPJ1r13ZbmsTStp7v4k18XezMw9EX6mezR1AYkkJdI=;
 b=BEmMuc/X8GB74dwwiYccb84+OvdGUKWvA7CSew+W4mEFj9O8vIYEgLXAf0lRYZchbl6HoBTSWmKc0KohUeR15qjshZ0bm8zeUZ+X656hN6sAE51syRcJmi8DrprqDMY+C3o29yXr2Hqkong7HLdHL54cXKdKyUFJC2olQ0cYYgo=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 15:26:22 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:26:21 +0000
Subject: Re: [PATCH v2 06/12] x86/sev: Replace occurrences of sev_active()
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
        Ard Biesheuvel <ardb@kernel.org>,
        Joerg Roedel <jroedel@suse.de>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <2b3a8fc4659f2e7617399cecdcca549e0fa1dcb7.1628873970.git.thomas.lendacky@amd.com>
 <YRuJPqxFZ6ItZd++@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <b346ae1b-dbd3-cdbd-b5cd-b5ab9c304737@amd.com>
Date:   Tue, 17 Aug 2021 10:26:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRuJPqxFZ6ItZd++@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Tue, 17 Aug 2021 15:26:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3752e99e-c7ea-4415-ca74-08d961935e0d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52294D53C50D3A9B4C9771B0ECFE9@DM4PR12MB5229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lvHGQZtTMlYFR7lDbSlMVxTdugFGj5v+ORF8qqYF6Z8vfz4wy3u/ZXwli0LWfyZKY6965SbVH/AbFm0/7ZpvGtpgDQLh/cIi0lH5evChXv+74Q2aFFIGOJklSmDGNHjurhlQPWISYwLMAZ9G5GbLcRJicarm8gSoq9V4Z2wOWKYwaI6vR+t3PICrGpAr/hIaowo8lSLxvec8OnO8YcZeWGldL/kH9nh43YQsCNrWASCHBvvvautM5ChYs3tTD0lc6uzB5zyGBeBV2WPCC6tD222HSeZRE5PL8wL/Ohe61eMcT837r7GkCZJ6h+A8CvrYwtFkq8t7S+Eo007T2vBrnNG53PUmNy4HzhoRmyPIwnBVOkV66BOrnIsmabOA+de/cNwv/Jjf3kFBMoBOgtQLy688EGoOtrZ7643rAfBmkGAszcERPgAl922v4Fo8hTK/jidEHttUUfDROAT69AuUPSZwEA4TVO1hPRhwfK2fRnr4M26I9eMjmTsvzQB9D1sb+axNB6yfVTOAZ93pQpESRU3aHLK3gzSEmn3n9+ffKzMTZXuZDA25AN7r/tSAc/KQLV/XthhCsTLd2+Na8T5+iDho2QzBjCbDuXcbWkPgXhrd13nK/rr1UgzgxpzHK/1fsxmfy8mCzYp2tx4kt0e6wo+HsaWrSTlY05gVOow7GC+PHD4rgXtO/8ZfndX/GWek3WvWivRZpIJwBhHoIpdZxLshjCXn2sfLRIdrWzmKYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(478600001)(7416002)(2616005)(8936002)(31686004)(4326008)(956004)(8676002)(38100700002)(6486002)(316002)(83380400001)(26005)(5660300002)(6916009)(54906003)(53546011)(186003)(16576012)(36756003)(2906002)(66556008)(31696002)(66946007)(86362001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGNVT1h0VnRzVlVRQVVaS0VrdGc5NGRXODdGQTIwWWRUekYyZlNzTFVmdFA3?=
 =?utf-8?B?NU5DSHg0T24yeW5aVjVOM1RRQWhqRTlZNFBYb0RZVTdDT0d0ci94YUVqZ2ZV?=
 =?utf-8?B?aVplMFlCSGxuR3RXQ2V4ellyaG5NVXg5UndFOVhPRXd5aEd0SXc5OFJwdng3?=
 =?utf-8?B?K2lvek9YdmsxcVkvb2l2bUxteWVsS1V4R3piSWt5blJ5aXovSGgzTXpheUo5?=
 =?utf-8?B?clYzR3NCZTdvTmR6QitNc21TMCtra0c3dWlaNzVhTXhpd0hUc0hSQW8xWGxN?=
 =?utf-8?B?cjYvbzVram1scGNzYTZtSEFYS2RPMk0weE5yd1kvbGRGUU5QaWdOalNpazBu?=
 =?utf-8?B?UjIvNWdGYjkyMmlvN3FTZ0xmMUlneEJsZDRLQ3IrZ2VLZzlIZzlLaVlSTzJn?=
 =?utf-8?B?SG5jaWpnRmJRbURVY0JPRDRWL0dCUDBOUG5sdkxvMkU5bDVxZy9CbGliZXcz?=
 =?utf-8?B?RkxSRm5JSnJwSThjS3U0Uk1jMW5BZ1JtdEp6RWdXUVBJNXdJcVZRSWc0WHZR?=
 =?utf-8?B?QTR2U1Z4Q2xpN0ZINkdxQWd0U3h2d1BvbjdqSTY1SkFkN21zOU9SdWJWbC8x?=
 =?utf-8?B?L2VyRUVaTkRWbGdmVmNGbEo2L3RVd2FLcFJOTkpJUnhXVjBQMDMyNXMybkFt?=
 =?utf-8?B?ZWNXR0lYN0NKQVFQKytra3FnU0JJekI0N3FPL053NlJISmg2ajduSmNKMWY2?=
 =?utf-8?B?ZlJ3akNTNWV2MnkyRU14SWlKM0FqbUZPV2dHMVFnRkxVSjRlVE1SbUpwTGFk?=
 =?utf-8?B?VG1OZEpqM3R3V3NxNFJURHNSQm5YanVpa0J2TnA3eERaL3c3b2hxaVIwVDVD?=
 =?utf-8?B?RGdLRFdQTkY3alJnUldqdHd5WUtoZ1dmQkNsVk1PWXg1L3M0S1ZYODFjdm5a?=
 =?utf-8?B?VFVRalUwK004OGVVRUtlZjFyN0hOaXZ5OUk0NjVENGowN3BOTzJTeXh4b3l1?=
 =?utf-8?B?L3R3MGt4U3RmNkl5N0lvK1hPSnhPUngrcHNYTEJHb2FVWWh1dXdOTmhPUGs1?=
 =?utf-8?B?YkZLTnV0UmxrU09HOVQ4QkZuNWM5VENYWHh5RUdIbndxTFFqSFc4ajZsNVpJ?=
 =?utf-8?B?aXRqSVV3SVdTRjBvMlQzdlZwRi9Wa2YvdFBSV2dzQklmVHdobE13R3hrenQ0?=
 =?utf-8?B?cjBVaUUvUno1L0xEUzYvMlpGV29CdmtXMlM1U2NqTjhOdFlXNE16S2FtQTFP?=
 =?utf-8?B?QmRaVVJic1dCL2hpQUFNZWhMMGpnSG42MHRPcmFhYmdtbUNYa0hYZmhKdnRK?=
 =?utf-8?B?elE1aTlFNTJtM0ZkdEhENFJ6SWtwTkFtZkhETGFxbzFLb1doLzF2QTVkSEhq?=
 =?utf-8?B?UXN3bk5aM1U0c3RFWjBsYWFMWHJEa2h5VzRqQTR4LzVyVHE4clk3T2dhOW91?=
 =?utf-8?B?TXBuTXJVdGZkN0VCMGhPaG5ld1p3SmZrZVZIYTJHS2ZxZ1hlZS9McmdQWnFs?=
 =?utf-8?B?Q3I5Wkx3U1ZiRmhoNEd6d3R2VmwwTFM3ZWJiajhCSFdiM0I3ZXRvRHVNRDVW?=
 =?utf-8?B?emVuVksrVk9aQjA5TUZmaUlleTZCTC9rbWs0ZGdtMTUzb2p4ZnVuaFJhOCtU?=
 =?utf-8?B?MlArZzhKbzE1T21kN25QWXd3Vyt3Y2R1KzI3Y2tTOFFJTWgxeFJKNnlZZFB6?=
 =?utf-8?B?UVIyZEtHbzNwRFNLQVNqR3lyNm5ySHN3WGhGNkRLZ2ZzUkNwWk5vdm41M3lU?=
 =?utf-8?B?ZThTcFRkWXBNUnFFUXB0NUxkeHNNRTAwaVU1a1FVT3BGZWdac0FXTTFmbVBx?=
 =?utf-8?Q?C8IV0ecZEe+V70/uBuIVBTsKtvc6eGQjtRyEUCI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3752e99e-c7ea-4415-ca74-08d961935e0d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 15:26:21.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTDMrMyZqD2GeGe64dHjAkEsLkzk/ccPvnOXBTHpNEdL5Vh8Obz3cWp3QJA/FkvvLx5zIyW+N11FZ4j/ZpmYlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/17/21 5:02 AM, Borislav Petkov wrote:
> On Fri, Aug 13, 2021 at 11:59:25AM -0500, Tom Lendacky wrote:
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index 8e7b517ad738..66ff788b79c9 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -167,7 +167,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
>>  	}
>>  	pte = pte_offset_kernel(pmd, vaddr);
>>  
>> -	if (sev_active())
>> +	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
>>  		prot = PAGE_KERNEL_EXEC;
>>  
>>  	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
>> @@ -207,7 +207,7 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>>  	level4p = (pgd_t *)__va(start_pgtable);
>>  	clear_page(level4p);
>>  
>> -	if (sev_active()) {
>> +	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT)) {
>>  		info.page_flag   |= _PAGE_ENC;
>>  		info.kernpg_flag |= _PAGE_ENC;
>>  	}
>> @@ -570,12 +570,12 @@ void arch_kexec_unprotect_crashkres(void)
>>   */
>>  int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
>>  {
>> -	if (sev_active())
>> +	if (!prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
>>  		return 0;
>>  
>>  	/*
>> -	 * If SME is active we need to be sure that kexec pages are
>> -	 * not encrypted because when we boot to the new kernel the
>> +	 * If host memory encryption is active we need to be sure that kexec
>> +	 * pages are not encrypted because when we boot to the new kernel the
>>  	 * pages won't be accessed encrypted (initially).
>>  	 */
> 
> That hunk belongs logically into the previous patch which removes
> sme_active().

I was trying to keep the sev_active() changes separate... so even though
it's an SME thing, I kept it here. But I can move it to the previous
patch, it just might look strange.

> 
>>  	return set_memory_decrypted((unsigned long)vaddr, pages);
>> @@ -583,12 +583,12 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
>>  
>>  void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
>>  {
>> -	if (sev_active())
>> +	if (!prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
>>  		return;
>>  
>>  	/*
>> -	 * If SME is active we need to reset the pages back to being
>> -	 * an encrypted mapping before freeing them.
>> +	 * If host memory encryption is active we need to reset the pages back
>> +	 * to being an encrypted mapping before freeing them.
>>  	 */
>>  	set_memory_encrypted((unsigned long)vaddr, pages);
>>  }
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index e8ccab50ebf6..b69f5ac622d5 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/pagemap.h>
>>  #include <linux/swap.h>
>>  #include <linux/rwsem.h>
>> +#include <linux/protected_guest.h>
>>  
>>  #include <asm/apic.h>
>>  #include <asm/perf_event.h>
>> @@ -457,7 +458,7 @@ static int has_svm(void)
>>  		return 0;
>>  	}
>>  
>> -	if (sev_active()) {
>> +	if (prot_guest_has(PATTR_SEV)) {
>>  		pr_info("KVM is unsupported when running as an SEV guest\n");
>>  		return 0;
> 
> Same question as for PATTR_SME. PATTR_GUEST_MEM_ENCRYPT should be enough.

Yup, I'll change them all.

> 
>> @@ -373,7 +373,7 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
>>   * up under SME the trampoline area cannot be encrypted, whereas under SEV
>>   * the trampoline area must be encrypted.
>>   */
>> -bool sev_active(void)
>> +static bool sev_active(void)
>>  {
>>  	return sev_status & MSR_AMD64_SEV_ENABLED;
>>  }
>> @@ -382,7 +382,6 @@ static bool sme_active(void)
>>  {
>>  	return sme_me_mask && !sev_active();
>>  }
>> -EXPORT_SYMBOL_GPL(sev_active);
> 
> Just get rid of it altogether.

Ok.

Thanks,
Tom

> 
> Thx.
> 
