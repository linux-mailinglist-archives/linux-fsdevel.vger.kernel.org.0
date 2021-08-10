Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9226C3E83E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhHJTtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 15:49:25 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:32944
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230077AbhHJTtY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ+3qyej49za+0VS+FD0wQ6mn8leKkX2WPHFmxDsYkJ3C99PZj6HMFOXtTlXIfB59M7CEZs6CxLLDfLbFeE7qYhIeEdozRBnnbstqaA7e2hj6JeFZWue83dfjNO4uX1zXIIP+M1xO3+aSKP7UBdYwFWvxy7dX7qc4VEJvtgzr14bC5kDmcp0hPwOvhiQdeUNknZIqQylUPK9lhmAiEDtAHR8HuMhmWt9b0FSh5hIfeXRXeRIquwBxMoj1QiJ+2I3cn7kfVR7i2tgxjZIuYA/7wxsab52xInwOjsMGNpYSB9w8eJi+AROIRlzyaPkOvLNpVdZAouQN6H367+E2zbuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh+wIW78M8BTE50i5ZnMzfjoH3JWoQ2z4zwDegZcjTw=;
 b=KDHD2sKkMdWQ9JMKZSZCWKf9fOX2IjzvRCFn5KIcvJq9QU/vKiHqh1wtOCUdvCyQpmbMoiBcaG7a6xasYRC8oWWtfSFFWIfuqc0WsqWxweIAnNuWaMwZ5Xj3HbAwql752qIijPSazho8hJGhbERZDZ2rA3x1PtP28AqbXaz8vjQuh0wIijsNW+N3WOZnn1/m8B/3+/dac0BaahP9PSXjCWCuK2Sbg0AhAAkZhHVQtsjAbTF+D1mpme4pq0t1OT5otqpqjXKg/uDJh6dXg/MOkm8lYYvR4/V6RIE9CAPKTUA5c//m4abSaAw9ZWnorwyThbnIpWICVfK39nQ+qe/IuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh+wIW78M8BTE50i5ZnMzfjoH3JWoQ2z4zwDegZcjTw=;
 b=RJ3Whm8Dil40S3MwjVoL8Ot4+SIib44VjBGVtC7vbK9LLgmdSb1XOzN/cOMTjxX+jdQjvpCVBElu3F3/rUUTir1zh9+UGitv4ZF3nm2mepQasce6vsuzSR4DEO6JQLK3W4kGGEjXW9jyUEmkD2JNkkgjbjn75FdHgV+hbHtkPAw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 19:48:57 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 19:48:57 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
Date:   Tue, 10 Aug 2021 14:48:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:806:a7::8) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SA9PR10CA0003.namprd10.prod.outlook.com (2603:10b6:806:a7::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Tue, 10 Aug 2021 19:48:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7519805-b04f-44e9-0267-08d95c37e478
X-MS-TrafficTypeDiagnostic: DM4PR12MB5213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5213808E81BF3C9D4453E6ABECF79@DM4PR12MB5213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnNi92GSpZMslhiJrfA3rObWOy/Id+q1gKm6thqBC060XYwLZe3GyzbHxgGkUNk+wdDB54v7EICc2ePegDwKUVeIDWdwhvekpABUuvATXrDiMI61I+GaorVEfOjYCHuSMlsA9wDeZL1bLmuTZKQj5IFitAjkp4VMlkr2j+wwsgt88F2tEpfBvkezJV7bb1aA5jWOE68pfUkK/1yK0sSmRc0tWOgDhAJFZsvjpKYvendWlZxekxJMIHfk2V17Redu26emXLnu5ls/D8YeTO1cJG80QslBjpzrgZi03VKK5vkzwUs+WGDYRIjqwEP+tXOVZD2vNT/vAjy9VGPROLEV45Q+OKVJxuQL+uQcvptiOmRxvYeJhvI91mt77eGnYDif0Sfstz9v1mBaglWw397KFtF5JvHE/r+tRZbhPDa+bnMrAmWd3sR6CkI2pruLC+eak1Y2sSM5JPhVwTyGV65WccTsePjRbmXt9kdt717rld973FpbqYxeuAYtPCaoTRh2DhmHCzbA6Y7MPb0XnEHyGD4EzJd51+0p3jb9mXM1eL/zDZv+uiJ8+NjnOrfaG8QnhHX6DD+eLBcbDuMyN4dV11BriDVTj6t5cyPjnE3vlu3DDhVnolDffVc963g9xuGGR/uG5ElqGjGYS7bLialLp230ItD3vgYgjpy4ZqkxpkGM58VL4Fjc0+ffnOn0qfCoRUFv4nlqzIgg63QKSHzxF50VH0SiO9vCVIdhoq0F0ay6XaI4/+X2m/9MNYK24vmA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(2906002)(83380400001)(316002)(16576012)(26005)(53546011)(186003)(54906003)(508600001)(66476007)(36756003)(31696002)(86362001)(8936002)(8676002)(66556008)(921005)(66946007)(6486002)(7416002)(38100700002)(5660300002)(31686004)(2616005)(956004)(7406005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01YRS8ydDdKVjY4QmV4UStDYy94VjVRS1pOeXVleGNkdDBKd0xKM2FlR0xM?=
 =?utf-8?B?cDBMSUIxMHFHSXdURy9UY3JZVFN0VnE0NEt1cTBXU2Y3L3VoUFpVYnpWc0d4?=
 =?utf-8?B?VndNK3FHSytDdTRkbU5YZDRGTTNTNjZzU0pFdGI3TWhPRmhlYXVMREoxSmZi?=
 =?utf-8?B?WHpTSjBpLzFBVFBkdVl2Z0VCalIwc3J3QjB2Q1dkUjV0MFExMmRtSW5EbTUx?=
 =?utf-8?B?cG8rMkdWOGl1TmdVTGkzRE1ZQ09XQm8zWWVxeStnYXBGcTA3NmRGS0hRNzNE?=
 =?utf-8?B?c2w1ZlRjUmZYY1FReTZIcklnUWtGK0w3VjRYYlpYMG1JQ2NlZTEvTkhQY3BL?=
 =?utf-8?B?SVNtU1o1TlllNTZrS3ZrbGNIK25hNXZnSG1XbE9zMk5sUEZJNlB4Z2ZtNHBi?=
 =?utf-8?B?ODVWOGFDREtzdXptS3lvWDFnKzNQTXZubjRodExLQU0vZ05UeG9la2F0ckxi?=
 =?utf-8?B?NXdJSTd3eEhLZEU5Vit1WWdKenVXWjhVL0IybWRnREtUM1VtaEdNNnJGV2lL?=
 =?utf-8?B?UFNNY0ZIdWlRTXBXMzF1TStidjlYL2JHTFNJVm16SWY2OVBvRXZtYmk1djd2?=
 =?utf-8?B?SHJ5cFdGLzg4LytKS0JrcnA5SnhNU0U5MkVXbEVjcXd4MzhPVXNXc0dmaWxX?=
 =?utf-8?B?QWgvNldpVFRta2R0cVpPZ1dQK3U3eWMrTmlaa25MSHR3WDJCc25BL29EdytH?=
 =?utf-8?B?WWlOK3V4UDJMSlk5WGhCRWZDajk3NUlRKzRGRnZVNmdtY2dGRmlOY1NYTlpq?=
 =?utf-8?B?VUp1cEp5dHhjbUdNQUkrR1RpUzBUcmhDaVZLOGlDZVR6MTE3Z0I1M1c3a0t5?=
 =?utf-8?B?Z2NQamt6Ujl1QWlwMURxUVIxdmFteE83eEljMUtFRGdzekdKUi9BMkZnam51?=
 =?utf-8?B?bXViTjlrZWVXTHozcFpKY1lYaHVEZWJ6RVpzeG9zMnBaMHlBanc5Y1JoeCtq?=
 =?utf-8?B?eGJReU4wcTNBbUgrT1lqMllKQ1NKRUg1OVl1UnE4VmdFSjZ4VnVOQkd3aU9W?=
 =?utf-8?B?bkNudHhKSmJnZUVWd2Y0Ri9nc1lySkZHdEovNk1vRTdaMHhIWGU2NFNTTkhr?=
 =?utf-8?B?NlZGNEdEQy8welBLT1cvMmcvUW5ybVIvcitXdkdETlZyc2I1NWd2T1BYbk93?=
 =?utf-8?B?M3h6VnU1dWZnUlNDMXUzOVlOdzhENTZrK1F1bGpONm9YcVN3aWlrSSt2WHFm?=
 =?utf-8?B?REpOSFVLQ2swL1Y2YjdJZlBsby9MVjlSZHI4aE85blBURWVlOVhOY1llSTdp?=
 =?utf-8?B?TTJXdk5xa3JLanlBVEZhdzNTaUtJVzE4VnhORjlEcDVXam9RUmZHTTA1K2hZ?=
 =?utf-8?B?TCtiYklYV05oNGlCNFJteHN0S1d2M0REeXNXNXBHeUNneGdRbWhESDRsNEls?=
 =?utf-8?B?Ymw1SlZTRWoxZjVzMk5JRmxKUjZIQjVsWmZadUN5UjRtYXpzcGNxb1Y5ZElR?=
 =?utf-8?B?Z1l4OE94OWgvSmdEcGNteEJObUFTaW1IWHVBRTkvcThMb0wxaWJBM2FydVdo?=
 =?utf-8?B?UXpIczRZcmhzWjFGanNNbUtuWHl6TGxKSWtHTmZuWDVPTmVXaG8vc1h1VnNo?=
 =?utf-8?B?UC9qcUJPL2tTY0dsYm5tRytaeDhjdndzZmNTZGltdWw0S3N5Q0dkZWZwN01V?=
 =?utf-8?B?MTY0WWV1TmtERHZ6ZnlTZEE1ZitFMXRrQTF5a01WK1hDWHdDYXBOdFdtU2F3?=
 =?utf-8?B?NUVpUFRPTGwxeEI4Ti94V0QwYXJzbEcwUktJSmpuODRGNm1mdG1tM1NqYUNG?=
 =?utf-8?Q?fQ9evLIdYd8zEwDHlrF8On6CF1u6qb8BapODFJ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7519805-b04f-44e9-0267-08d95c37e478
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 19:48:57.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkQmC0BMFabM+hD+NZCRsqRDlnlmUWZdnM+SN3S137DV+6ebAPKAIvjN9s/s+GoNlwKXx1Ivo44BngEr7cMMzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/10/21 1:45 PM, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 7/27/21 3:26 PM, Tom Lendacky wrote:
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
> 
> 
> Since this change is specific to AMD, can you replace PATTR_MEM_ENCRYPT with
> prot_guest_has(PATTR_SME) || prot_guest_has(PATTR_SEV). It is not used in
> TDX.

This is a direct replacement for now. I think the change you're requesting
should be done as part of the TDX support patches so it's clear why it is
being changed.

But, wouldn't TDX still need to do something with this shared/unencrypted
area, though? Or since it is shared, there's actually nothing you need to
do (the bss decrpyted section exists even if CONFIG_AMD_MEM_ENCRYPT is not
configured)?

Thanks,
Tom

> 
