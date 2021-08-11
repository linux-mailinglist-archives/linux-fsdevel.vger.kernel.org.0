Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA773E94B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhHKPkY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 11:40:24 -0400
Received: from mail-dm6nam08on2043.outbound.protection.outlook.com ([40.107.102.43]:22575
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232120AbhHKPkX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:40:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daLEHybPecI6ZRHIqH2cWATVIfPB+WooynNVSuvLkAtnRwsGnHNpn3k78Oh+gBP8L59PRPP2nBUqJt+Bfer9wZOhl4a1j4NqMFiiqXjL9O9YvADSKo8pjnU9IxV166s07Gm+zWT+JZzYXX59TlPnLlMCetnw/TKr/P48K9eCA1Z4I/sngLElIb9YUZavHVRKdrE1onEf7g6L3p9apkiSdy1wLbssK2NkXGgsoKSxZpaP30A0qur2zgFsflgJHxCzAKjjpKUxJjaUw4BHJ+FPQPTNen9QCCBJHgdLBNaaXxnuBm/cOdgnRp7JRZIJZq49/geQLv0nSy9tckgYqmRa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2evfU3JKF12i+CHIj3gsXs8GalyqMJpNfF6tW4wUq2o=;
 b=YsjP+FkVvQzAPeqmTMzAOI9rlxik8Fapr8uLmUgc8SPWzBmIuQn4tnloY0ZMtzyUVOXS2/PbcQgFxngzEp4BXlMeUWqoPbHInwGzG3tYh1Q7+eLhvnADEh9s4vzMPr+/i2S5syNC1WlBuTBkWLs53OHFdiVoLTg5RRWcxJKravJuwSlGyypN9InJ4gaZAzqBV7w/z0otj1uWX3e8uJskf3kRTnekM1TvaOOWC+hDjAvL7TGl6unufyADcbZn245m1QW6ZBjtvvHxNTvy4vFLPa26tlRkn5qLge2279CsTzc0CrM35z71XdN4gtgrT7cfh5lRzgzQv7m7WPHnQg9aRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2evfU3JKF12i+CHIj3gsXs8GalyqMJpNfF6tW4wUq2o=;
 b=V8IePYDNxlfzfQdtdtha00szkrEQwwgv+NXNgJ4tlOcyTgsoMxTTfNqSPuxFP4bN/zQGAQRtNV5NNFtUzM/pIdq7Ht70s1yUh2GO/1wQ8K8jEz/p4SqROPRsskmIsCdPkGCCewt+g4kMSH5+QqCD96gcEdUOr7HW0n3eDqs26Qg=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13; Wed, 11 Aug 2021 15:39:58 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 15:39:58 +0000
Subject: Re: [PATCH 01/11] mm: Introduce a function to check for
 virtualization protection features
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
        Tianyu Lan <Tianyu.Lan@microsoft.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
 <805946e3-5138-3565-65eb-3cb8ac6f0b3e@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e7208040-9ccc-b2df-b2d3-a06ed793908b@amd.com>
Date:   Wed, 11 Aug 2021 10:39:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <805946e3-5138-3565-65eb-3cb8ac6f0b3e@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:806:d0::25) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SA0PR11CA0050.namprd11.prod.outlook.com (2603:10b6:806:d0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Wed, 11 Aug 2021 15:39:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc406e1-0586-4eca-cb83-08d95cde45f9
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5447EBEF2583098748EDDEC9ECF89@DM8PR12MB5447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbpvZHrEktXDOQPMRWHMYiyUuTlNMQ6O97bArWsUpsez9UrKjNMsVtXUVMkdTpTToQA7kNzulOyAVG9RqiQKxhWV6tgQDqTBFPqpRZiAfHwsXEtAq1jVtjb1IC51fOHT2KR5+2gsHs+FvusJR9HkXxblK5nslI0w+2y9tHdH4kZatggMfQw+gskbQxLFMkYyCZ2Bmf4Zzoo7Y55zv8kx+f1XBXeqUj1G/KEkXimTbq/L0I4QxhDkeY/LT8D8Il2sFoELSVY4x7zNzPhqIWy2h2ADJfzSqguJAgpTSUQUfl0A2exnWt9qJmYqWFHfkkRCLStYlOWF9rsO397jYxDT4KdfEjpSaxI+CRle5jloFYCYQiQo+r+ZlVmiaDe6O1xFscV98V+BB455lX2cB1W1Zm2ku4WYNrNgY6WfeoguRM5i2yL2FAYiRgiBli6djLvYKGr9axkeZ5vxHMQZyBU0slxvA87yZIfln+Ot/yCrJh3bwS8Loc8+/60vUGJLhR53oPFxinWlZT4u2DchHPE87DWwM3oLo1zojFEbVfJmsATJERlD6EPdgGvDwauUpoV2Hte9wi5TgPNEvWqxm8yCyj7Pk4Wgjry5iXKfFgnDdhAcWCxAwvVtqirs1hurFf+8GhH4xNyqXulJWFHDyGsdNNCLWaZhWRjtBz9JjO/s6X1S7OyGsgcaem58mY/zbJTG6IWqjsaPgivu5mxJ3BlLfa+bJN8F+JL9/8IQ0eP4JC2IqVLn0+YAN+UFV4ClE5jL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(31686004)(26005)(478600001)(53546011)(54906003)(186003)(36756003)(16576012)(2906002)(2616005)(7416002)(4326008)(956004)(316002)(86362001)(5660300002)(921005)(38100700002)(66476007)(66946007)(8936002)(6486002)(8676002)(31696002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTJFanZpMUZGa3pNZ2hERXpwQlNsQTBxUTZNWWJQUDBaeUs0QVhSRXMwVDlL?=
 =?utf-8?B?Qmt3Y1hHUmVpYVo5QzVyczZvTlZ4VTBYTTZpdy9WS2dWdTh6SFVEaUt2R05s?=
 =?utf-8?B?YXozRm5hUVBYaTYxVzRMUWg2ZFAxOW5UbjhPOVlGQXd4Z21pYlFEbGpKR0kx?=
 =?utf-8?B?YUpadXE1NWRURUdiM2JIRjNyVUpPR1RQTnpuTW9PN1dhVGZJK1VCU2hqTkdK?=
 =?utf-8?B?dlhFWnFqOUMxY3VBUVpRR2pKRyt1TVVraXNtNk1jc3FMSVl4dWtPNk5ibDhS?=
 =?utf-8?B?WnpEdmxQMldBM0ZlZk1Pb1hDRzNaakVNaDVhWE50djBldW9NbWZORzduNE9W?=
 =?utf-8?B?MTFDcml4SUt5QnE3SGdBRE9iZHcwemgra0pKS3RSakl1b3hJbHovMlR3RFNW?=
 =?utf-8?B?VnpTelplT2tNVkcwMkpZVEtjTks2Tk5ZTmlacExBUCtDT1o4QnJKclozSlJ5?=
 =?utf-8?B?ZndLeXd2VFptdTBDVTdSbUdhcHM3a2RSOGtBUk9nc1AwajdkNVJDUERyMDU4?=
 =?utf-8?B?T1pqK0QzTEluRGkxYzMxczFFdXpSSFBib25MaTlVSzlxdkliTHpJTERzSXFN?=
 =?utf-8?B?VUJBelNQVUJ6VDZKQlhzK2s0bjZOai9sRDJMV1pXcVc2dnEycmJiM1hyV1ZQ?=
 =?utf-8?B?Wmp4cnAzeURjS0FENUlJRVNJb29zb1BKVXRyc2hUMFY4Y24vQlVyUStQNDZV?=
 =?utf-8?B?cFJxMWZxR2dGQ3J5ZU9FYjRrTkRXRlN6b2pxTzB2di9ycEd6ZUd6ajgrOGxI?=
 =?utf-8?B?bVROTmJzbGRuY2NaNHkwcFlidDA3U2VrUWdoU2xpaUk3dG1yclg2NkY4NEhI?=
 =?utf-8?B?STQ4NmUvN2xVSk5lZDQ1SFc0RE94RkdUbXBleEFhWVp4dnphRjBPVXhLTHhy?=
 =?utf-8?B?K3lZYVNiNDZsaTFUeE9WK1djblF6Y3Bhd1dyeEpoSUJnUnhGMjBEbHhPamJ6?=
 =?utf-8?B?UWNvcEUrMEJMNi8ySXQvaHdoNW8wUGo1L0ZqNkZnSHdoaWV6MllOU0NrVi9w?=
 =?utf-8?B?RkJodDV2Sk85aTcyOFRjOFRvVE4ydW5EczZLcnpaaHdscUNNK3FJelJVZDNk?=
 =?utf-8?B?WnVZVFVwMk9UVGE3OEF0d1dVcmp1cmZydUFuQVREdE9UU1pRQzJCM3FGeTg2?=
 =?utf-8?B?Ti9XMXdoQTl4TU1HM2FwU3FrTzZmTkVyRkNQd3pYYkRpSGR3WHFYeUJEbUlH?=
 =?utf-8?B?a055SnlIMGNxNFJ2KzdEbXQray9mU0JsVEZqb2xicDlMd0Q4YWxCR0grcGtl?=
 =?utf-8?B?cmhZV0xWOTNGK20vV3lwb1lpeWFlaEhYekpWdEVUTlgwME12UkNVZHNRblpk?=
 =?utf-8?B?Z05NcFU0am5yRWcrK2JyT3JMQ2xIeEp5cGlCejBYL3UwVmVQOTVqVCs0Y0dU?=
 =?utf-8?B?SURCeEZJTXFUMk0yc0JaM1RZMmNjNDF3UUJUYkhoSmlRYkFnbjVzV3AvTkpn?=
 =?utf-8?B?bWp2R3IrSnh6VytMWmw2RGNUdzVOdFpDWTJ2Y2RJUDdZT1lFVjhRZm5qZjFx?=
 =?utf-8?B?VVhkUVQxVytJdmdsVlpnOWZmZ05PZmplckJlUEh3bXJMUVNkSkt1YTk1L2xn?=
 =?utf-8?B?NWc1UWZSSk9jdVRsV1l6UHdySzNaNCtHQkVBNFNKV2UreTFlVzFyS3djMlhE?=
 =?utf-8?B?WnBxZSs5b2R5dlRVS2lNZWlpUVg5ZU1XUlRjSlc5cGJyWEhRY01YV0ZzRE1u?=
 =?utf-8?B?T3pUck1uTVpDNU94eTg3OXBSS3V2eWtJTzdsc3d6QWdiZk9mdk9XVTJTdkJy?=
 =?utf-8?Q?QoSrilrwpTZt6Dqeo2Wtk6LZbxABIZJ1LolbsoS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc406e1-0586-4eca-cb83-08d95cde45f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 15:39:57.9206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OELy2RTyEG0+9O72k8UtSUmgfgE4amU/1OUQMRVL6kZ0hhl35eyfyQBhQcHDk0XEIE1+XWScyv+bWtCGRlebiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5447
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/21 9:53 AM, Kuppuswamy, Sathyanarayanan wrote:
> On 7/27/21 3:26 PM, Tom Lendacky wrote:
>> diff --git a/include/linux/protected_guest.h
>> b/include/linux/protected_guest.h
>> new file mode 100644
>> index 000000000000..f8ed7b72967b
>> --- /dev/null
>> +++ b/include/linux/protected_guest.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Protected Guest (and Host) Capability checks
>> + *
>> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Tom Lendacky<thomas.lendacky@amd.com>
>> + */
>> +
>> +#ifndef _PROTECTED_GUEST_H
>> +#define _PROTECTED_GUEST_H
>> +
>> +#ifndef __ASSEMBLY__
> 
> Can you include headers for bool type and false definition?

Can do.

Thanks,
Tom

> 
> --- a/include/linux/protected_guest.h
> +++ b/include/linux/protected_guest.h
> @@ -12,6 +12,9 @@
> 
>  #ifndef __ASSEMBLY__
> 
> +#include <linux/types.h>
> +#include <linux/stddef.h>
> 
> Otherwise, I see following errors in multi-config auto testing.
> 
> include/linux/protected_guest.h:40:15: error: unknown type name 'bool'
> include/linux/protected_guest.h:40:63: error: 'false' undeclared (first
> use in this functi
> 
