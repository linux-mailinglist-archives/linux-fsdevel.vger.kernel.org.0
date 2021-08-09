Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7F33E4F0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 00:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhHIWRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 18:17:11 -0400
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:56416
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233408AbhHIWRL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1b6fF+y6JsYt35N8A5iJVIWBft9UbgbAkiGbMH3O00bNBX1Y3vaYKpJ4rOXUXLS+/j7moEIjsrznEA/HajQXLBSCBUQorWtyA0iZ+A+r0OQkPOfcLSdrX8+zUA897hdH7j6a3jJNW5AuM+P+yqKgJNgJXtLvmjBBiXe2YuzE2m5ONh2Ts7D+ue5gtDJEw3KypQRWlHqhBG/vyVdYSQqThGvmg5CX9cg3QG+QIThKEtrqTRygDps4i67PrCRii/FG9IosQZIn7Nb0OVELbhhFzAE1LzN5NqLsG61Ifp+7/0lf0dbmakrbhfpWeZvZsO1Sq0FTl7JkYqIMKA8OnT/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+fwmX6Q39MkilgVtnsUqVDkLnT1mk/AV6fBAqAUqvU=;
 b=jTH1ZJv1jtriew0t4PW4Fd7LPv2hqwvotB+J47Xy5dO3fb/wXm1Tz/39HTH2z+M/d+rHcWcOqbQRekQTBWf2B76sIwZF8+lY8umIsUw9Jyf0xmyXloRtD6bOXADXe7ONou+8AKO/bnkNGRH0yfrLlZjmZbfhAkL+YEWqsgj37e+FOJS0OBKhtzurkcq0Ps9OGFBhkWLFK3ForbL7I47ZFwybwLhxcSREHIGCGCr2VG6vO03Z3Euxsxyf//9HRnxRrxWR/fvT721FDcKXmkB/h9Z/wkmdgCb108SvnEkCxbF4Tsd13oZCSt367yMEFudQMIMYXA12hpzeBHHO2PTu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+fwmX6Q39MkilgVtnsUqVDkLnT1mk/AV6fBAqAUqvU=;
 b=cSe52ps/4KuS1UjyZ0KB3W8Fnttajsj1EbYfiX12ISWEYg1dCgQuY699Guu1p7WgcRqIo7o5wqYK4FhSC5VMGNZ2PcIKAbc9W4ZvqjM6u06PBsITtW1mnPt0gTxhkledkfOgbCBCYxwQzAbYQ2frUKeXxV4N1ba8fFiYYWZEAoI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Mon, 9 Aug
 2021 22:16:47 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 22:16:47 +0000
Subject: Re: [PATCH 00/11] Implement generic prot_guest_has() helper function
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <0d75f283-50b7-460d-3165-185cb955bd70@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e4584e88-b0bf-175d-9494-4e133c03fc07@amd.com>
Date:   Mon, 9 Aug 2021 17:16:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <0d75f283-50b7-460d-3165-185cb955bd70@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0032.namprd11.prod.outlook.com
 (2603:10b6:806:d0::7) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SA0PR11CA0032.namprd11.prod.outlook.com (2603:10b6:806:d0::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Mon, 9 Aug 2021 22:16:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f92fe84-d210-466e-0e93-08d95b8360cf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5054F2315990F7A142DF5DC3ECF69@DM4PR12MB5054.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybCsYxUJ4J/W/kEe8EnRAOwTv7wTPXurQOm1eqvwpSoKf0FlQPV9oXkFda4GMnlJUYagHy+zU1i1aBeAumUd0/FS0fvHpruZxlnsH80WmEFKJjmbHj4/UMGbYxrvmvZ7qQJfAfAkwRDQc/gUr7SB5vqId0c5MuByGAlgf0aBw1tNLJepubwJDWEdOUfI4GgCBh78CqAmBbh1POA2nWbm08JI4s4Kh6Dmw1gy2tyxkwtIyAcRmykvZCCjQPu9uZKXxDUFU4+LAYa0jE6Ny5AiVqFfzRdw382yxi7hkaMnRFEmetLcBo0z9csPSf2c++oohCcIp7OXIy8Il9uglpyJb54al79quGzsEliE2bx6Sto/qdehhcyHnytL1tSq31MuSRKWt2QY9nXgNVX4jAKMb7TQOA+VQiKZoHko2CD7pjpri9WOe+R1rF3Xl0c0G16lFbVF2qpJrirUClm6Uf6xkAkfrzSUsHhFcQ4Fk6cdj+AnRvBIxQn9dRZEjB058zhAe6QH0vYWWXAjsTQOquiu+ltvRVJ04XCwO2N7EE1ymQKAtgigHd/6lcNyXavVBDXFMVJjMpWeXr9eXw0eG+xKa1hVvhrz8WMAI4U1qScGn07IXEDSvrJP9I8fwxgIYlbDg18lTx65RtdY9FpffXY72pfv2cjatK9ymVwQ90VV2ketO+5nBDJwj/oDtAY1lH0t151a3QY55LyDl8eAcwNxRdnvbqVTDF7pwOcNigoTWx9oaBi721w+DplDH8bh5VDQ3YGvgiY4qQFopsN3Dd2P/VG6Yy/YQ1PbtzOAunfpljqbMGNHpkuxCXYZhQeHL1NUG8CfvYC9DgGpIQ8BQnSWb6LDchEAzM0qFTeMUr1Je6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(53546011)(31686004)(66946007)(54906003)(8676002)(966005)(478600001)(66476007)(66556008)(16576012)(6486002)(83380400001)(8936002)(186003)(5660300002)(2906002)(26005)(86362001)(45080400002)(38100700002)(2616005)(7416002)(316002)(956004)(7406005)(36756003)(921005)(31696002)(4326008)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEM1WGl5SjdycFFsc0VHWmVoT3J4QUtKc2gyaUtRMmpVcEJuczU3aU43SnBM?=
 =?utf-8?B?a3YxL1JNaWc4REhyeTRMV2dCUEtyaHRaVnNrQXRPbGMxcUduM1JWTVN5OUpn?=
 =?utf-8?B?d2hQODU3R3Vqc1cwQUxLOG95dGVxTHQ4ZWtsbll5cW9LS0l2Z0VQajM2TEhG?=
 =?utf-8?B?cHJiMDRHWnE3dUdCT1plemgzTXB6Y29Hc1U0cktIMWNKdmFVb0ozQUMwTXpY?=
 =?utf-8?B?MndwL0FJUmlsSXR4aXI2bVBmV3ViR3hrUXkvSmplRm0rUTNuZjdUdENrVWVi?=
 =?utf-8?B?b1lPMzFsZjdwVjZEaDkwQlBjM2txVkZGK1pScmhSVXRydDBMV2tQalpNYTRh?=
 =?utf-8?B?TmJqVDVhRjB0dXJmSVpsT20xQmNrdzlXczZES0M1RVBhQmgwb3ZQUXlrQzl6?=
 =?utf-8?B?Q2hrUEhKc0dNaWpNaklhQmJ3elpieXBHQnJBWkJla2hlN2xTbk9UOWdVdHB6?=
 =?utf-8?B?NVd1RTVhSHhNdXlwSHlTejlEc0lacTV1ZklpTUd3eEtsYnFXWjJaN3Z5V3ZC?=
 =?utf-8?B?blBIekw0ampaWHNzR0F1WGRTeVhrMlM5MnFEamxueDZaVmRXUXd4Q0dPT3la?=
 =?utf-8?B?dnhpV01hSmxWeTVLTTNLL1lNTnB0L2NpOHBramVqZ1dHS3QvZ1hTbUhGY09O?=
 =?utf-8?B?cDJIdnVSelRZandjQ3lmcDAyNUg1eklMbTl1S0Q5L3E3Y1lyVUdiV2dROEJw?=
 =?utf-8?B?Qi9ENTJpUVlhYlJjYmRkaVZhd2dLOS84QWx2dlo4N1hKd053ODVZOU9IUHp3?=
 =?utf-8?B?Smg0VTZva0lKRUpweW1XYUtaZkdPbFRKd3QxOEdHVWY1cHROdEFVWUhvZFAw?=
 =?utf-8?B?QUZSRm1BcW1vano3aFdUOU5vcVZPTVdIYUgwMThaWE0yQXlHbWwraWVIM2JW?=
 =?utf-8?B?ZEp2YklRMkhXVXQzaDliM0wrNWJleXRIM1BCdGcvaHpUMmlxSXhFc1ZNQURO?=
 =?utf-8?B?ZlRHQTJSdEJBOTRKUG5sOXh1SnR0cXZDSTlqWFh1M2MwK1FrZGJhenVSZG5V?=
 =?utf-8?B?L3E5Qk1OdmJLazhJMVRma21rbnNWVjdZTCs3S2JKOURCT1E2dDEwWDRyelFq?=
 =?utf-8?B?bk45b2M3Qy9zTWVHTDRLMk40cmN3azFTZFkwOUU4OUJjMHJWeVNhb04yVHBK?=
 =?utf-8?B?Ump6KzF6bzVQYUw1WkN2clNxMzRVbThzcUVQU2ZzREl1Y2tRa2lmWmY0R3ds?=
 =?utf-8?B?MjJpLzlMcGhxY0VjSzlsSnltUjF3cVljOHdNKzlKL1p0ZVhLSWpqRTZzc3U1?=
 =?utf-8?B?RFJLVXZiQW9lb1Vwc2NyQWo2cVNPejc2ZzMxZTdxeUdjT0RXZHp2TWdhOU1U?=
 =?utf-8?B?NldCVjM5bzBWZ0t2R3RjalVlOWFYamhHa3VFYmI0NmJPNVJGNjZPaEV4bi9W?=
 =?utf-8?B?L2tuOTNxOHJxSWdnY0pHVmo2NU1NTDErWDU5THBpQzB5cllPanhob0ZRNHFY?=
 =?utf-8?B?eVQ0TFlhNitXdnhGbjF3RnoyNDlGSjFpdU5hYnpXeDhqeXBLc1dUWkhZekJS?=
 =?utf-8?B?TnVwcms3WCtISGhDYXhtdE5Tc0M5MmlKTk5STEpTY1kvYVorQmFNaTNsSWlv?=
 =?utf-8?B?azBOekxUcXBqblBFcjZDR2ltcWNwRG9hdFN5c0hEc2FwOEhpWFQvZTFOTFRZ?=
 =?utf-8?B?T2lDclp2cnlIMU5IKzJHd3RxNXd6RTMwdUtPcEpneTJrZEFKTFBma2RDLzBy?=
 =?utf-8?B?VlFJUFZzanpTekFWckNwNjJEeTFTdUZjdkdmWFhiVGlwYVFITW9YUnJrZDFO?=
 =?utf-8?Q?hsPIX0FzA5wl8+n6mtSbpcroiybnFiaSc2Zjg4b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f92fe84-d210-466e-0e93-08d95b8360cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 22:16:47.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWonoL3hzNeEn7iFofjcGCY0PgdwEHXOt2iYa+B5GGK7Xyg5Ta4xjEGJFIvdErQdiMFgJggx8W+URScsRqMA1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/21 8:41 PM, Kuppuswamy, Sathyanarayanan wrote:
> Hi Tom,
> 
> On 7/27/21 3:26 PM, Tom Lendacky wrote:
>> This patch series provides a generic helper function, prot_guest_has(),
>> to replace the sme_active(), sev_active(), sev_es_active() and
>> mem_encrypt_active() functions.
>>
>> It is expected that as new protected virtualization technologies are
>> added to the kernel, they can all be covered by a single function call
>> instead of a collection of specific function calls all called from the
>> same locations.
>>
>> The powerpc and s390 patches have been compile tested only. Can the
>> folks copied on this series verify that nothing breaks for them.
> 
> With this patch set, select ARCH_HAS_PROTECTED_GUEST and set
> CONFIG_AMD_MEM_ENCRYPT=n, creates following error.
> 
> ld: arch/x86/mm/ioremap.o: in function `early_memremap_is_setup_data':
> arch/x86/mm/ioremap.c:672: undefined reference to `early_memremap_decrypted'
> 
> It looks like early_memremap_is_setup_data() is not protected with
> appropriate config.

Ok, thanks for finding that. I'll fix that.

Thanks,
Tom

> 
> 
>>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
>> Cc: Will Deacon <will@kernel.org>
>>
>> ---
>>
>> Patches based on:
>>   
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7C563b5e30a3254f6739aa08d95ad6e242%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637640701228434514%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vx9v4EmYqVTsJ7KSr97gQaBWJ%2Fq%2BE9NOzXMhe3Fp7T8%3D&amp;reserved=0
>> master
>>    commit 79e920060fa7 ("Merge branch 'WIP/fixes'")
>>
>> Tom Lendacky (11):
>>    mm: Introduce a function to check for virtualization protection
>>      features
>>    x86/sev: Add an x86 version of prot_guest_has()
>>    powerpc/pseries/svm: Add a powerpc version of prot_guest_has()
>>    x86/sme: Replace occurrences of sme_active() with prot_guest_has()
>>    x86/sev: Replace occurrences of sev_active() with prot_guest_has()
>>    x86/sev: Replace occurrences of sev_es_active() with prot_guest_has()
>>    treewide: Replace the use of mem_encrypt_active() with
>>      prot_guest_has()
>>    mm: Remove the now unused mem_encrypt_active() function
>>    x86/sev: Remove the now unused mem_encrypt_active() function
>>    powerpc/pseries/svm: Remove the now unused mem_encrypt_active()
>>      function
>>    s390/mm: Remove the now unused mem_encrypt_active() function
>>
>>   arch/Kconfig                               |  3 ++
>>   arch/powerpc/include/asm/mem_encrypt.h     |  5 --
>>   arch/powerpc/include/asm/protected_guest.h | 30 +++++++++++
>>   arch/powerpc/platforms/pseries/Kconfig     |  1 +
>>   arch/s390/include/asm/mem_encrypt.h        |  2 -
>>   arch/x86/Kconfig                           |  1 +
>>   arch/x86/include/asm/kexec.h               |  2 +-
>>   arch/x86/include/asm/mem_encrypt.h         | 13 +----
>>   arch/x86/include/asm/protected_guest.h     | 27 ++++++++++
>>   arch/x86/kernel/crash_dump_64.c            |  4 +-
>>   arch/x86/kernel/head64.c                   |  4 +-
>>   arch/x86/kernel/kvm.c                      |  3 +-
>>   arch/x86/kernel/kvmclock.c                 |  4 +-
>>   arch/x86/kernel/machine_kexec_64.c         | 19 +++----
>>   arch/x86/kernel/pci-swiotlb.c              |  9 ++--
>>   arch/x86/kernel/relocate_kernel_64.S       |  2 +-
>>   arch/x86/kernel/sev.c                      |  6 +--
>>   arch/x86/kvm/svm/svm.c                     |  3 +-
>>   arch/x86/mm/ioremap.c                      | 16 +++---
>>   arch/x86/mm/mem_encrypt.c                  | 60 +++++++++++++++-------
>>   arch/x86/mm/mem_encrypt_identity.c         |  3 +-
>>   arch/x86/mm/pat/set_memory.c               |  3 +-
>>   arch/x86/platform/efi/efi_64.c             |  9 ++--
>>   arch/x86/realmode/init.c                   |  8 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
>>   drivers/gpu/drm/drm_cache.c                |  4 +-
>>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  4 +-
>>   drivers/gpu/drm/vmwgfx/vmwgfx_msg.c        |  6 +--
>>   drivers/iommu/amd/init.c                   |  7 +--
>>   drivers/iommu/amd/iommu.c                  |  3 +-
>>   drivers/iommu/amd/iommu_v2.c               |  3 +-
>>   drivers/iommu/iommu.c                      |  3 +-
>>   fs/proc/vmcore.c                           |  6 +--
>>   include/linux/mem_encrypt.h                |  4 --
>>   include/linux/protected_guest.h            | 37 +++++++++++++
>>   kernel/dma/swiotlb.c                       |  4 +-
>>   36 files changed, 218 insertions(+), 104 deletions(-)
>>   create mode 100644 arch/powerpc/include/asm/protected_guest.h
>>   create mode 100644 arch/x86/include/asm/protected_guest.h
>>   create mode 100644 include/linux/protected_guest.h
>>
> 
