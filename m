Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0B4137F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhIURGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 13:06:35 -0400
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:34016
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229910AbhIURGe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:06:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4sWGYXm84pVI/goyWSt5fRG5v1L7eq35KgIX0BmgNCazum/1/zOYMg0pCyFVoIGtYSkm5S1qJzM3ILSg/A9JiU5f9eKkV2OHDdJqwDRo1PHVlWRR3UIZRL76V0yIZyJjPzh8nHAKuK4dB7415PMGiMfN6yC7Q8F6iA+BxwUqVM2q9YlejcWHsVBV9C3ba9cBbf3P9Dd8hA0YCJ9RDgscMtKaQvV46ZzliRmxKhyqrmXqmy1/S+LB/Ab0MWrjwzrp+XqgEH9r0bSNGHAfaT4uqO+bND6PB10HuC0S07bksXVt+cWhsQmX6uPC9GwHKg3MsCK+l1/44WcROUOMhcM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tmskHpWBT27LkjX1timk8SmhOkrxFAW/fShiR2ATI1M=;
 b=fvjlmnhKlcRFjkxoqm9fAz1vn+qX4ZuPbFNdVT6M6vAC4BkDS4dOwTTBdPbPWNpnZWRaGvQKisz/36ABkV0zYR1bqr5EjFoGONWQDjWXD+wfzeApDQsBdsHcwHe8+ER2JsDISYEIx8CTEEbMzjFs+wWMR2D68pMiW5tJS/Ar5LABGfAUqx8J1g92nHFl0fFeFokUDVGHJtXrTB7MvxemmQ0zj0h4yJfuhzml8/JmNjENgnSpYuCtvxozA0WTZs8LhoWtUHi83xvPoszFKCAa03WkMGAqsDZNuFLSRLqJKyicFgH2hoZ5MF8IQL5Zl74FXUa1tjyEVHg55JTIl2+BdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmskHpWBT27LkjX1timk8SmhOkrxFAW/fShiR2ATI1M=;
 b=eqaDAqn9B3pftlI/GiILMD3tSURgvmr0RaWFepHEwqsPA6wLz2uVmhvD8p+2CK72orXelQLTD8Bw/NZ9tm4bHpxDCwXo/NschABpqHKdCEt+CrKJLISlFGY51lOvhovsI5a0M1QCuylokXqdKiNrUjawvbw6TFokJbzZ9OvtuI0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 17:05:01 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%8]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 17:05:01 +0000
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
Date:   Tue, 21 Sep 2021 12:04:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:806:d0::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SA0PR11CA0053.namprd11.prod.outlook.com (2603:10b6:806:d0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 17:04:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 476e5302-0a8b-4f58-08f8-08d97d21f2bc
X-MS-TrafficTypeDiagnostic: DM4PR12MB5359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5359B47E0C5E773899E36CCAECA19@DM4PR12MB5359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLVlIBo1VpnAwFAfHBnQZcAiebI/akSNG3b6Ck0WScXmPQhj8v/WC7uzDObY4pzr9yzH2yaWbTFXiPPc/c3UQcIgVItYtQNCPy9QzAqiEjIw4d7IJ8RIJA5lSRD9WzzIZRbOU3e5mNfl3YeselEN+XaeGdbhM26oIMC8xxtMhIo4+FtCbPP3JlaSy3zS1tWKQ8BNpxKQL9NFvomGl1xsHvwCDVaHEUhCysG80Vt+LaVk2MfMXmGBaQNK09cMyF5RD8fGwkyKnwAWPfazp5MR3IEccAudjOFfKJKi6p4JZOkH8xo0sK7OgxdqUZotNlESK19oWe7OfRTzsQFeLSAWJdwqmAk0Dc7+F2nfqU7uGatFjTuAtaSLgDU5BVTy0vsOBxCB/ZE/70GNk0AglqI2jdIy4Q/Vv7AgtX+zM7ZYGnQd/sVN4hyeWGDJPIzLtis7NGrtcvPU/K5/ZuyB1zhnAXYeg5imDl2VXUKX3Z2k9buS2NHc8dv3YPrh0tdec4RLeOYDEusTEx52x3tALreZOCJTX2xHCZ9QzCsm27w9im50bIOc3hlaiiDgvFoe7C+I4Rx79xGAEo4yg4okllzVyxvsHWXMq9GfSjYRAuVAhDy4lfq570km+yozV2LX9otU6N9ebNKrlbXj2l+ievrOMaZtWgSQ23/PdVOmbEY9gB4h4tU2YG0cy1sJfFfsZ6J/yElRY7eTcttR0n13FJSlqYhMWvn+eMgNEazkl43z1aSxNuM5vtd1L8aP1aOHep9Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(2616005)(31696002)(956004)(38100700002)(2906002)(8936002)(508600001)(4326008)(66476007)(86362001)(66556008)(54906003)(36756003)(31686004)(66946007)(7416002)(316002)(8676002)(6916009)(53546011)(16576012)(186003)(6486002)(26005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0xSVksrdlFMMysvKzRuUEd4R3dOQVRVYloraS9UYlBralZScDlCalJYMkNJ?=
 =?utf-8?B?SFozU2NtL2tKQWVuZEhpend0QnUyNllmUHFOWUhQUEl6WjhFTlpIT2lyTFRZ?=
 =?utf-8?B?VE5rL2x0bWg0S0l5WWtuSCtuRDN1VG8xckx2bldreDJoT0pKVythSy8wdGs5?=
 =?utf-8?B?K0YzWDJuSzdjd2Jta0kyK1ppYWNSeHM5VWsrTy82cUUyeGQ0N3dWamxoaVp3?=
 =?utf-8?B?dUxnZmpXdVRqc2xSWGhodk93UGxiY21zVUVueEhRc2FhUmJQcUJ6enNWWlhM?=
 =?utf-8?B?RTN1bmxZQW9FYlNOUHlJZmNEbTAvK0dxc3FUWlF4Qm9RUGNmcEJMV0toVUJm?=
 =?utf-8?B?OUU5RUJ2UlRJOVhybThlWjhVd0ptVTdUa0JXZ2pGUk9UUzZOUHpjMUJNZ1NS?=
 =?utf-8?B?Wnc5MGtvdmZ5OGRXblR5cUJLcVNxbkR2K3REaWt0dzdDdi9JT21lQTRhcVQ1?=
 =?utf-8?B?MXB1SGw0YnlhamVua0hoV3hvdzd1ajhGemlOa1RlbnMrYTd2eE9iMk9wRzUr?=
 =?utf-8?B?eUhPNGFBTjdWMVlzSUJGT2RCZG5GMUEwUnZ0eFpydHhpK3RkV0U3RTN6SXp5?=
 =?utf-8?B?Z3RJVzA0c3RPSmFYdU9ITWpiZFE1K1g5d3M4dnN5ci9DWDNyQkEzOFBvb2VQ?=
 =?utf-8?B?SCtTUVlJUjc4c1Y0bmg1N05mRGszYjB3UTRKdjZvU2dxK29YaHMwOXZ5aTNs?=
 =?utf-8?B?djg0ZTl0ZU9qVm10Z2IvY24xK09IVXVxbWNTVW1qajQ1MjNQQUl6MFRLckJJ?=
 =?utf-8?B?SEkxTnVuU0Zzb09QNVZyWFhDTllrZ1ZjS0VjT1l4Y05QbGRTcnFLWUcxT3JR?=
 =?utf-8?B?SHV0L1dqS2M4bktvQjRmN292RzZGRklyN25QSGJsTDNhRXpwZUlLTDRrQngy?=
 =?utf-8?B?cHIxTVNzOUNBK2ErMS9JVTNFYzRCSDZpSmluQjU4TUZybkw0Q0NUUzk1VVZP?=
 =?utf-8?B?S2ErQ3lZSXd6eW80K0hBQVZITTNRZFJDZkFlZ2hRZTU2WWVVNldRV0VXK2R4?=
 =?utf-8?B?UXR0aytyOEdvUEVmaVBPa2dzbTc4SWF0ZVhVWlN5M2ZDZ29wcUthQzR4VllB?=
 =?utf-8?B?dGs5MXRPQjNmNmtjT05qYW1Wd0VENWNwSnE4VW9Pb3dxdW9WNkFob3Y4VHdv?=
 =?utf-8?B?amFjWDNlMFNWTnlPdUtHeHQ2Z09xOUI1WFVwVVdhL2xiV0QvU2NCRUx6dEFJ?=
 =?utf-8?B?WmpaUlJ0T2NvaDZBK3dOb0h4WURYMURPNk9VR3FxWm5VcExxUFk2N3dHVDYw?=
 =?utf-8?B?SFdyMmtvY2JiTUJMbFJya0FtYjNnVDRPNWpVYzJMME1ycm5LOC9vRmd5TXA0?=
 =?utf-8?B?cmFuRVdhS080QXBBS0UzbHc0N1ZlTnR5MTFtdlM2RWUvQzh0TTM5NUh2VG5i?=
 =?utf-8?B?K2I4TUFEN2tiMnZycmhRUHlEOXA3MlcxTG51VkRSZE1KQ1p3VU1uMjJyZExi?=
 =?utf-8?B?Z1REelVudTBXdXd0aDdRMGZVaFFlN2V1L1JLcHQrQUFHbFB3bzU3QmtYcnFM?=
 =?utf-8?B?N2pGblptYzllSVV6eEs3QTBVSmN4cXdyNW51VDBadlFFTnpTWTJNdUdIVXlD?=
 =?utf-8?B?KzBTUlFlaUN4MldJUGlleEwwUzlNMm91S3JaSWhLK0NIazVrem8zMldReHV5?=
 =?utf-8?B?OHo3Wjd2ekxsQWVkWUEyVldCYXVHQVJHN0R2Y2lGTTdNTHBnamVkWlVzdHhP?=
 =?utf-8?B?TFlEWmpYT3Jvd1FvZkxKWitQeFNSZU1IS0h0N2hqclBlZlAxcXF2dWJLTDJa?=
 =?utf-8?Q?n+FPj5tyPe50XUAR0Zqhwy0umG43ryuIn6Sp6h1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476e5302-0a8b-4f58-08f8-08d97d21f2bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 17:05:01.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwjZCE6+EDfeFZblRrrVDFdcYNSnvuOExFevMIa0+rp7VyN9bRBENOfcZKsjt7RlymBzClr5cKJ7rlx1R6Winw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/20/21 2:23 PM, Kirill A. Shutemov wrote:
> On Wed, Sep 08, 2021 at 05:58:36PM -0500, Tom Lendacky wrote:
>> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
>> index 470b20208430..eff4d19f9cb4 100644
>> --- a/arch/x86/mm/mem_encrypt_identity.c
>> +++ b/arch/x86/mm/mem_encrypt_identity.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/mm.h>
>>   #include <linux/mem_encrypt.h>
>> +#include <linux/cc_platform.h>
>>   
>>   #include <asm/setup.h>
>>   #include <asm/sections.h>
>> @@ -287,7 +288,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>>   	unsigned long pgtable_area_len;
>>   	unsigned long decrypted_base;
>>   
>> -	if (!sme_active())
>> +	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>>   		return;
>>   
>>   	/*
> 
> This change break boot for me (in KVM on Intel host). It only reproduces
> with allyesconfig. More reasonable config works fine, but I didn't try to
> find exact cause in config.

Looks like instrumentation during early boot. I worked with Boris offline 
to exclude arch/x86/kernel/cc_platform.c from some of the instrumentation 
and that allowed an allyesconfig to boot.

Thanks,
Tom

> 
> Convertion to cc_platform_has() in __startup_64() in 8/8 has the same
> effect.
> 
> I believe it caused by sme_me_mask access from __startup_64() without
> fixup_pointer() magic. I think __startup_64() requires special treatement
> and we should avoid cc_platform_has() there (or have a special version of
> the helper). Note that only AMD requires these cc_platform_has() to return
> true.
> 
