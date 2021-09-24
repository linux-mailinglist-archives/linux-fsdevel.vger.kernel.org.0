Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76804175CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 15:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346665AbhIXNd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 09:33:28 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:39863
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345378AbhIXNdZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:33:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaxjAC9EmAWBsh7zRULTA8AeJCx8enxji/OILEiCnQ43wxLbuUftgiwh6dzc6V4VFnm8sK8rf53PXiL+Lec17R35QMMdTcC8+F7uKiA/8be7IMyAAEP4Y9Snfsy62TDQJKeB0oLoJZVT0SqtgUMMYAXd6VwFGKIEP1vnIY3YK6z8K4P3LjrIh96WL9C4xRc/MPFvcJYT82Kk/W3vBjuENCozXGX9owlzAfpWdO69rTPMa6uQgeL1Mpyd1rLM1b7rUPmHeBK7uwdNHmNuftLzZPGxWIF9HeViTbjeRnaN9l/E7LwUFlt9yZa6AVkJ8Hfdq/AGG7u5qTVu/SDURi30aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pbiPm6dQwPY9o1IJZg6JJVINOZIQSwzE/cJ0+AdpetY=;
 b=Cs255WXViZoz7y7KyoVp6Bkf3svXCezQwhf/XYXz3sPm7WGxUoCtH8iZS789dQmx7WN6Ulfg6SzJgI/+Uafo9f4pRd93HIvEajnG9llnlc+gMFei11JG2KgAk2bRCV0vuLCbRmacy3B7zj9rg+H54dreMXafGXegGpCo/kWg/MPlZy6Po0Oh83EKpr/eqCsQifJUPqkCgv2bcye/JNyNAWOel+vWjChdAaDg6nuM9uF/AHlMiCCyE7H1RqG7evxgWnpv3nX3pnus2YGopPwDMAurbcHrx6uVKyRLPp1QgIuXrmoHpFKZuuTV1la8nnNp22zA6vLay+UeN36BG0yjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbiPm6dQwPY9o1IJZg6JJVINOZIQSwzE/cJ0+AdpetY=;
 b=i6sLgCLSBmcGjGWMy1Ie9Jqo0Xd67lR+LQQfX93WLgZjHnmfJ+xh7IM7DNn9/NcI0DopVks+2sLbbnJoTlV1U7D58nSJNHoinjyWjpy2TnjWx/NeIez0vOD2rdT5Yv3i1l8n2/9YC/wxiK0ji1fwZtYfhLcreCEZaiUgg12aWJM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 13:31:49 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%7]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 13:31:49 +0000
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
References: <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
 <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
 <20210922143015.vvxvh6ec73lffvkf@box.shutemov.name>
 <YUuJZ2qOgbdpfk6N@zn.tnic>
 <20210922210558.itofvu3725dap5xx@box.shutemov.name>
 <YUzFj+yH79XRc3F3@zn.tnic>
 <20210924094132.gxyqp4z3qdk5w4j6@box.shutemov.name>
 <YU2fsCblZVQpgMvC@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <8ed60226-b3f2-1226-3ce8-afc58acbe1e5@amd.com>
Date:   Fri, 24 Sep 2021 08:31:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YU2fsCblZVQpgMvC@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:806:120::14) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN7PR04CA0039.namprd04.prod.outlook.com (2603:10b6:806:120::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 13:31:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 562c0a4d-7f00-409b-5e44-08d97f5fa99b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5311DB3E6AA21B17B48078F3ECA49@DM4PR12MB5311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hVtvo18zjgOL1qHrWEFnWPX3eO6OKUF9sKIvfEmkkXSiV1oNEctI48mvtIMdtaIO5WErzTj+VIHjSVlJxsMEo8nLSpNaB3QqHzqKDDZoF6DYEEoIDrMt2OMMnx8677few5iwbXziUYlXvLs8vQbm6KJzBexZwkpeE4xSSaAIDZuk6OWokDnenGbhNz9iXQl2ahU0kWtVpccNBHj+1fS0qspjsrZ1ZpDVEz0fS7XO1wW1N6S8eCkGLrqSvotyHamANYDvYOqhKSHY8G06ozyki/W+01q4a6OkVxpJRTjLoSMcelXvxxkpd3CEjNPTaxLXZjGzcf3mFFb7h6H3vd2deGAYT8Ox9sHSSbmPMQdQsTeyCongaWLh8sB+LJreZJp63327vsvZ/P3XYErn9u289Ebl4MwnLYLYeuIGEAlRWvZpK4T1V6/+phOy/hVbYmmvh2ybujowstU96zB3wvGtw+QvRbRqiD7dIN/qpcUriQha0eLx2Vmgyc+wquDiNd7WJXClsUrQylu+6Qqt9z4iQZUZmA/9MBC7JNOLCv56jdtvjVdIFpveho+rKnQClwPIVdFJW75YmUdP9jgXefxVtbFHMEW9Rgkx84zfK7mgckLvZTy5vpDbtaxnkGVymYkYlJW9fKYiBgg9tVc6hTEDwvR+9oZVESXZHlxIQ50TOHHeqDSyB6g/gN80EWNCTmk9MqN19/As9jgBnAXXuoOSURe8bxmjXPxgcG/7zZAu3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(6506007)(38100700002)(86362001)(2906002)(2616005)(8936002)(8676002)(66946007)(6512007)(956004)(316002)(508600001)(5660300002)(83380400001)(54906003)(4326008)(6486002)(66556008)(186003)(31696002)(66476007)(53546011)(7416002)(6916009)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhlS2JEVUhjQ1JyN3Bwenk4Y2c0cDBCQzNZelV2VUIzZ0JNd0dJNEVtUFp4?=
 =?utf-8?B?aGJxVmZRaHFpQk5GV3RLL2Q4ek9BdFVEL1lmVEJaWjMrNm9jN2Z1YmxxWmdN?=
 =?utf-8?B?TnF2YXdibkNLSjRDdnp4WkFBUWpSbW9keUVMb3RBeUJkZGtJbGtCNTZtMy9T?=
 =?utf-8?B?NFB3ajlFeWUrS1AzamtjQjV2blIvaW1zdkllZEJxMERQTmVRK0Rzcm1FbG5L?=
 =?utf-8?B?TXR5NEVHd1VWdDlqSk5KQTAvdmUvTElrdDVwOXc3Ykgrb0gvdWk5VWhjbHRW?=
 =?utf-8?B?cmZTcDJBbURtTnV0emNpdHBiamR6WjQ5c1pGYnhtZWFsYXNreHZ0ZGpGT2VL?=
 =?utf-8?B?djhOaEhPUi8wNytxcGhoczlYaXRPSmlqSFk1S3ZVQVlVK2M2NTRVM0JTcU9Z?=
 =?utf-8?B?ZFY2NnhtbUtoUkxhb0RjQS96UU5iK3NTU2lraExyNElnTzdlNVBLWm1XUVcr?=
 =?utf-8?B?WEYrQ2pIcjcrTGx5NVNQNmJMcE9OWnRyMitpU2ZYUHcxUTcxb1g3UG5tWE5M?=
 =?utf-8?B?K2V6RDh5TlRObUFZZC9qeWdhb28zRlFackh2WDVDU1RoRGhuV0tjZHNSN0hz?=
 =?utf-8?B?V2ZJYlRjYVBSSit0d3VxcFo2TnJ2UTVzdDNPS0s3M04xWFpPL1g3WElweTJw?=
 =?utf-8?B?RXp3T2g5MlNNM0FWTzYreVRubTBUMndqOW0zekMvL2ZoSlRKUGpTaHhnUnVK?=
 =?utf-8?B?Qm5Qdy9PUTdpVlZPOExLZytIOVRIaURSK3NUTTdMZWFNRlBGTXZoclBRd2JB?=
 =?utf-8?B?YWFxdUI2RXNOYUtsME15cW5ESnVaRTdnMTczZVVQckkzR0FaeE0ySUlFd1FB?=
 =?utf-8?B?YWg3M0lnajdYRExBUXd2QUZLMGV5VzdaeVZlcS9vNDg3ZHVsUVZXUkRRYTlU?=
 =?utf-8?B?OHh5WjN3OUYrSEFiRjR5cXppYUpodG9sSmk4cTdlTG9IdVVuRVVkdVcycDNN?=
 =?utf-8?B?T1J5dnRzYTJUVkdLZk45M09ISHFLaFh6VUY0QzF4UzFjdHlJWGF2eXR2UU1w?=
 =?utf-8?B?eEd2Q0QzSUhpYzd1RGgwUXdKQkp2bnY1K1FCdGNjT3FGWEl6ek1wZVFxTHNR?=
 =?utf-8?B?SS9XTFNRNlZrcWZoamtvZWJQMkZtM25zVktPM2lsbExvNlhrRUQ4TGx3dWNo?=
 =?utf-8?B?ZllFcnRxWkFpenFlV1AvYm5EaVp5UmtwWVpTUENLY0U3TWFPOGEwbEVFMkdo?=
 =?utf-8?B?dXhPT0QyUTJkMWlwclE1MnJLUDZDcU85am1reEZ5M0FGOG1Hd3BTdUNBeWwy?=
 =?utf-8?B?VENGZmozcVpIT1hlMG9zVHRTMlRnUWpOSU5RcWc0Nld2KzRIMnBaWWMrYzR4?=
 =?utf-8?B?MlZQckxkcEhoM0J1U2lPQUZHZ1dzQ3F6bEFOL3ZBM2p1V2hzeTljalRrOHRF?=
 =?utf-8?B?ZEJLK2xPSnhIQlNGMys3SWNpcXllN0J1NngrdXR1a3NUeEpJbnV0a1RxakhL?=
 =?utf-8?B?RTR1aXgybUF0bnd5aHBENWJOTVByWVRncHhjaUFZeVZNdDVxSktCaiszQkx5?=
 =?utf-8?B?QmVIOHIwTWJJdDJnMU94Sm5PWnZZZHhjZmhGNDYrSW1NQ3ovR2RJZElyeFcx?=
 =?utf-8?B?NGFLeUtsa29JcFVYQjRuNEcvVk9iZjNka1E4L1hST256MndxTmtpYm1nSUNp?=
 =?utf-8?B?YXg2dFdUT0g2MENVNmRYZUhYb0thNXljYWtHL2RGTTl6VGRVYnFwSW5JZEFG?=
 =?utf-8?B?Qjg4bWkvbWhCcmlkNUlZdDVKTEdZVktsS0FOeXRRd29KM05FVS93NHlsVU1u?=
 =?utf-8?Q?3m7QisQgP7Q9ySV/qRvHgsMy89jxrkH4Wg7Po5b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562c0a4d-7f00-409b-5e44-08d97f5fa99b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 13:31:49.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3xaDD1HT2rXnyqGNye8q/oD5FbAfwb/GcGk71rNaG70mxtDRuobWwuL03mu++JQQ00ZCOgmP65D8dytClAlJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/24/21 4:51 AM, Borislav Petkov wrote:
> On Fri, Sep 24, 2021 at 12:41:32PM +0300, Kirill A. Shutemov wrote:
>> On Thu, Sep 23, 2021 at 08:21:03PM +0200, Borislav Petkov wrote:
>>> On Thu, Sep 23, 2021 at 12:05:58AM +0300, Kirill A. Shutemov wrote:
>>>> Unless we find other way to guarantee RIP-relative access, we must use
>>>> fixup_pointer() to access any global variables.
>>>
>>> Yah, I've asked compiler folks about any guarantees we have wrt
>>> rip-relative addresses but it doesn't look good. Worst case, we'd have
>>> to do the fixup_pointer() thing.
>>>
>>> In the meantime, Tom and I did some more poking at this and here's a
>>> diff ontop.
>>>
>>> The direction being that we'll stick both the AMD and Intel
>>> *cc_platform_has() call into cc_platform.c for which instrumentation
>>> will be disabled so no issues with that.
>>>
>>> And that will keep all that querying all together in a single file.
>>
>> And still do cc_platform_has() calls in __startup_64() codepath?
>>
>> It's broken.
>>
>> Intel detection in cc_platform_has() relies on boot_cpu_data.x86_vendor
>> which is not initialized until early_cpu_init() in setup_arch(). Given
>> that X86_VENDOR_INTEL is 0 it leads to false-positive.
> 
> Yeah, Tom, I had the same question yesterday.
> 
> /me looks in his direction.
> 

Yup, all the things we talked about.

But we also know that cc_platform_has() gets called a few other times 
before boot_cpu_data is initialized - so more false-positives. For 
cc_platform_has() to work properly, given the desire to consolidate the 
calls, IMO, Intel will have to come up with some early setting that can be 
enabled and checked in place of boot_cpu_data or else you live with 
false-positives.

Thanks,
Tom

> :-)
> 
