Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2C054CB36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345057AbiFOOYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 10:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbiFOOYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:24:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E131C27FEC;
        Wed, 15 Jun 2022 07:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgzTBN0h7QNZa2tjMtPDbcFlbT45D2mPxyncu80oearDePXgJrJRIv9kqpT0XrOE2QKaHNrDH59hZC+MCfyzdl/DOIj3FmF4Pqt+7PYZXRLxE8nt7kJp35NHt8C+3XiTwfC3FuE3gxE93U/WOmlyDXNmRX432axOXMQMkV8w3HI8b2Tg+yRh3Pg2Z6PeSVYdpNW+jC4HKZK8Y578D3lluXkKtSnUVuZI3ABnpYnz8Ddp76CfLYQAJPlRD65Gg7c7v3zd4KdMjiPETp+0BhP9cXYFCWWGSUlufcH6yJ58FM3P3BKZCLrL7sV92c04VjCIrrM0jo/TWdR1rdnmsnuWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOvyYAqZDIMrja3KT4rYrszEU0Q89uhz/I9Lxm9kJhQ=;
 b=E4Gw8kkQATtkcytft9SOS8n2hPiDLgv3bt0QxzL2xvWVvMCme7d3ynxrTMk0Ro7y0+1CBQKPIETxw5LTuW9GhtpUWph9wvdnBV3Jpjhlf56qKn+9sp8r1Uwj4iKGRtr5CAK8Po0soPa0Q6CFhtA2AW7kQnRV3p8oEe8ljRI7VoPMLW3os47upaqZEHJ58/UYn8UbdjC0n4puNybkpyJdAa+XCUMNBp1yeiD7aRhKoegnQsRbO869xCqzXW03nkn/uF0MypasNDlf3jZIeDDhvuTfmLGmQHYpbeahNms7zp9i49SyO4biRf5/c4HrE21mHHSWyRcG660hqXx5AkOqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOvyYAqZDIMrja3KT4rYrszEU0Q89uhz/I9Lxm9kJhQ=;
 b=zkUqGdeXVGRlPcKY8qr8wGxfi78M1cEWcMmv77WCcmKOAYT8pzcrfJOwbZSGy+L3pl25KGWLcKOLliDUN6xM4Ka/8++hUK2OmbzV+7oh6UvNqcCq+5k5horr3RYON0005XiQv46e5/NWtkAt6vlY4m5I06YaHqeBcEldhFzomZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN6PR12MB2733.namprd12.prod.outlook.com (2603:10b6:805:77::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 14:24:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 14:24:17 +0000
Message-ID: <3ef8af8b-2dfa-79cf-e7cd-8a3e5ec20d6c@amd.com>
Date:   Wed, 15 Jun 2022 16:24:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
References: <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
 <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
 <YqNSSFQELx/LeEHR@dhcp22.suse.cz>
 <288528c3-411e-fb25-2f08-92d4bb9f1f13@gmail.com>
 <Yqbq/Q5jz2ou87Jx@dhcp22.suse.cz>
 <b8b9aba5-575e-8a34-e627-79bef4ed7f97@amd.com>
 <YqcpZY3Xx7Mk2ROH@dhcp22.suse.cz>
 <34daa8ab-a9f4-8f7b-0ea7-821bc36b9497@gmail.com>
 <YqdFkfLVFUD5K6EK@dhcp22.suse.cz>
 <9e170201-35df-cfcc-8d07-2f9693278829@amd.com>
 <Yqnba1E2FSRVUATY@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <Yqnba1E2FSRVUATY@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0491.eurprd06.prod.outlook.com
 (2603:10a6:20b:49b::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddedf206-058f-4d4e-f885-08da4edababa
X-MS-TrafficTypeDiagnostic: SN6PR12MB2733:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB27334D39829FDC2DBA46CF2983AD9@SN6PR12MB2733.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEA4IY3qFPQhQHHzX/H20resZd0FS60QETjfrGXtpwc7pntRPuIJGh86DjMRnz8XUyVZZfVFAEAHgxVY991ZzzHv2DOBGeI5+D5amaPL4C/AynkuY+z+BUUmn0hSxnsvDDyGocDr6c+vAn8CqsVoWnEfhKiQxoEblkH3mLhZKp9D9kl6+YfdMsp6RcFBcYtln5PKc5WixLjPDQaz83x9RCbyRgB/kECiX7Jjq+1PzOJr9RVz0d2mNgbkEf/fOfhbugXxpGlvKqUROIRFHKwEQ0p4gd42/IWmJoWEZK+/6GvfmBe+TmGim/bzgbNGl7iBRiZckNzg1uXnI5GmEw64LYuW0qRbP6BgnTQfd7u58hKvdocv/kWj9i7b3SIwfHT8U3KgQNJuMLvIwcRVBTSVQiUXlfk3TIBDGz6Bhy4VHkg4t9vB1mMchpNYc8MkMSq5V+3IHv0GtOUbwPSFm/Q8QCd037h516/LTbl7Ofykla8DvcVNGlz3G4lT1f4hvpOpSb09cTCUrd8lVxWGapiQkPzdvsZGs+mvgpswaQGoGTrhi68TAT31gRYqrIhKHZ7KYBUC4eaEcnnXjdNMaOcxoZPz1ZsYqu9da4MBv/eYne6ZqdegFaZznA01tAXjtt9iFNzi6JIkwf9FyJL0oHh9KU+qKtSuU20qyuEN7/RWwACPWBDvecb6Hofz71f/9i8HaN2kVUA08vq7AlIm2VZz5FgRgCX0oIuC0GrCXtdRfmqYA9tiHGmwNyHmaMiEBUot
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(7416002)(2906002)(31686004)(38100700002)(2616005)(36756003)(6486002)(508600001)(186003)(66476007)(66556008)(5660300002)(8936002)(6512007)(4326008)(83380400001)(6506007)(316002)(8676002)(6666004)(66946007)(6916009)(86362001)(66574015)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXREL0ZQZ1hQN2UzUm9HbWhlL1dwdy9FT04vNDBQWTBEcnd5Z1NvOUhFb01M?=
 =?utf-8?B?SXZmSnRIMUt0NTZlYTBJaWduN1NVRURsMkNLRisrYTBQZE96L3JhdForVG81?=
 =?utf-8?B?K285MktqeG1TUDVkTUhQaFRTTG42MGptZURTRTNBN005UXRvVENTa0lnblFE?=
 =?utf-8?B?cXQwRXNDMkRkRTN2Sk04T2pZT3hzNVNWczJiQnZ1aE5yZjQwVER3NytldFRP?=
 =?utf-8?B?UEFpZEoyTFkvR0dCM3I2RVBsNS9aenlrUWo0WERVQ0pna0NSdURnVzNRc2Fv?=
 =?utf-8?B?RlRxenpscU1HdmNBVzUvWEU2SGpLdnFGZ1FJZlhUTldHWHlWdFBTTEZYc3Rs?=
 =?utf-8?B?dnJLRXdpcUw3WWlSaHRSMzNNY09qZnc2eXNVUkdkUGIxVEk0bVlrV2JnblRY?=
 =?utf-8?B?NURLT0RwZEZpQXZHTEJSOFBLWEpVeFBmTHZzd29qcUpXeTg1ckV2T3QySDJj?=
 =?utf-8?B?eXRNN3R2UjUyby9GTWl1Y2ttQXV3QmlYcVdObVN4Q0x2Tnc5cmE3Y3J2TTVa?=
 =?utf-8?B?MWdoVFY2c1luV3dyaEEyN003T2trNjA4eSt3VXdZSlhFdzYwK04xdWNaNElL?=
 =?utf-8?B?YlhlN2xQYXgwamFvVmVmQ2dpc0RyU3dVTWNUUTBIUlo5RWRDbjVWZnI0UHJy?=
 =?utf-8?B?V3huNStWdkpuREJhUEFLaGJaT2gzTXUvNWxrZHUwVi9meUZoOEI1WEI4N04v?=
 =?utf-8?B?NWJEcmswOHVXWm1VWFJCamlhdzg1WWZreFRUOEpmTENseE5ibExTdVRBQzFR?=
 =?utf-8?B?ZjV1UXJZcFR3c24rSjFSVCtUSkJSV3BSWStkdkpPQXYzU0dBcTc0V2xzM0x4?=
 =?utf-8?B?dHdzZ09kU1dmdWN3Z3lmbzRMNW5JR0U3Y0sybkZLZGdUcThaUDZMdEtYSkJL?=
 =?utf-8?B?anRWV2I4d3FnYmtpa3ZaeWt6NE9idS9pRzN1UVdtRWFpbkNhUndzMlNZR3V0?=
 =?utf-8?B?dWoycm9teUtEWEZ6NjVHc05xcUoxODJjMmJ6VG1oTzF1QTZhZmFISC8vV2oy?=
 =?utf-8?B?NXdNYXdPMjgvQjcrQ2V0WUhmL1JYTWFTZy9BL1J1S0RmWHdOSnJHdGprbXNV?=
 =?utf-8?B?a1V0WXNKVW10VjJNR2xoNmpDTDhLekl0QTc1MC9PaDJVZlVqekZobHd1SHU4?=
 =?utf-8?B?U2d5RWZEeG92M1AvRmo1c3B1MkdodGFQbEdUWERGS1U3VDNJd0dJQ2JXOGp3?=
 =?utf-8?B?dWovZXdXcC9mSFF4K2xUek5vdmplS3ZpWjk4dFAxSXlhWlR0RUROd245NTc2?=
 =?utf-8?B?V3R2eDNXTnErbWdmemhlWFJWVVE4bDlKeWcrc3MvclZTdGxDZ0R1VSsraHlS?=
 =?utf-8?B?WXBxSUFYcHhRajIrWklwaHFteFNGTGZ1Q09WTHN6eEs4aUw5Y0pOZUo4Q3Bl?=
 =?utf-8?B?VFV0YmZPeCtObGdNLzFCVkJ0SC9nMTlmMDRmNSt5UG9mb1p1aEhPejNaYWVG?=
 =?utf-8?B?UHV6RVdwS0EvNVJ2UEREdnpodEVCU2hXMzRBZ0diUU1QaG8xUHRPemFwNWlw?=
 =?utf-8?B?ek96OUgzL3d5T0l6YjE2eUtmVTFJdDc5bnVueStkTktaYWwwK2FLbDJISWhy?=
 =?utf-8?B?RTRNUnNuenFBZjdHb1lSUUpTU2FHRUN5Zkhqb2JrWk5OTlZCWTRIdWhlRGp6?=
 =?utf-8?B?V3ppQTZOcVZrbXVaQ0g1QUZMajY2QlBwa2hRQzV4T29qL1h5bzVzcVg3Z2xP?=
 =?utf-8?B?bDVLeC9QMTlzS2hqTVgvNGxBbGdkSG9sRGVETHh0c0RFVTNwZHlwYXB2T2x3?=
 =?utf-8?B?V0RjN3dZb3JvSHFjK0w5NWxlMXFuSXZhNHZvYlQ0L1dNUUlrZXBEa3RiUVZj?=
 =?utf-8?B?Rk4yMTlwTFdSWEg4V3ZaUUtUdy9tWWhRSnpNTUZGbEIyajFVVm5yTUl0Z0dQ?=
 =?utf-8?B?MkVLWEJ5ZFBYTXBvU3BiZlJwVjc4ci90alhNSWdjeDFQYzgzNFFkMGJqVjBn?=
 =?utf-8?B?UGdUYUh5TThPaC9VdUJVbXZITnVaWnZqYklaaFdCR0U0WkJiQ3RqYTBMNzJS?=
 =?utf-8?B?ekpOUzBmSVdKQ3Q5ZnRXazZwVlFrRTc3MDFFYmw1L2pXMEFxdWJ0Rm5tUGNx?=
 =?utf-8?B?Z3JjTFY3NUIwUVhnLzE4QlY4OVpheHVwNDV5akF6emNXSHVHbjAzRU8zRnZQ?=
 =?utf-8?B?a3l4b2JCZ3QybWhqOEQvb09BTkpnUmVJTlI2WjJaUUs4RFByVWZ3eGxUUHY1?=
 =?utf-8?B?YnVBcms2Z2dSVy9uZlovTDNPMlNsTFlLWnVwbkNqdFRSb3JEUnFQM2JBUVRo?=
 =?utf-8?B?R3FMYy81MHVmeTRqWENUY0JFd1Bmdll0N2RPTC83QVBWYWZieEdObHppU3NH?=
 =?utf-8?B?SzEvYnJ5THQ2Z3g3MUhzVGU3UG5KTWNtd1QwUU9Fam1ndHczRnNod1Z1R3lE?=
 =?utf-8?Q?KUrew6soKrMkCyPCI9caBWzCEgnvxLE/7+TSFNj2rQ/KU?=
X-MS-Exchange-AntiSpam-MessageData-1: /Lro2J2aDa26xQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddedf206-058f-4d4e-f885-08da4edababa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 14:24:17.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0FmoRIJylMxGGYqevwxi4fBsLTyu90ftIgB8P9LV6lq/tMVAWixDRHYKfw6ItDD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2733
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 15.06.22 um 15:15 schrieb Michal Hocko:
> On Wed 15-06-22 14:35:22, Christian König wrote:
> [...]
>> Even the classic mm_struct based accounting includes MM_SHMEMPAGES into the
>> badness. So accounting shared resources as badness to make a decision is
>> nothing new here.
> Yeah, it is nothing really new but it also doesn't mean it is an example
> worth following as this doesn't really work currently. Also please note
> that MM_SHMEMPAGES is counting at least something process specific as
> those pages are mapped in to the process (and with enough of wishful
> thinking unmapping can drop the last reference and free something up
> actually) . With generic per-file memory this is even more detached from
> process.

But this is exactly the use case here. See I do have the 1% which is 
shared between processes, but 99% of the allocations only one process 
has a reference to them.

So that wishful thinking that we can drop the last reference when we 
kill this specific process is perfectly justified.

It can be that this doesn't fit all use cases for the shmem file, but it 
certainly does for DRM and DMA-buf.

>> The difference is that this time the badness doesn't come from the memory
>> management subsystem, but rather from the I/O subsystem.
>>
>>> This is also the reason why I am not really fan of the per file
>>> badness because it adds a notion of resource that is not process bound
>>> in general so it will add all sorts of weird runtime corner cases which
>>> are impossible to anticipate [*]. Maybe that will work in some scenarios
>>> but definitely not something to be done by default without users opting
>>> into that and being aware of consequences.
>> Would a kernel command line option to control the behavior be helpful here?
> I am not sure what would be the proper way to control that that would be
> future extensible. Kernel command line is certainly and option but if we
> want to extend that to module like or eBPF interface then it wouldn't
> stand a future test very quickly.

Well kernel command lines are not really meant to be stable, aren't they?

Regards,
Christian.
