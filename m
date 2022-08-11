Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B73B5905E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiHKR2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiHKR2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:28:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9806445071;
        Thu, 11 Aug 2022 10:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4wy2c4pVhpm8XUljrYQvafrs48UN6vS7YO+6/cqD3U2c1tdUxIwo7CGn5zOcFMbxULmsVpiMrKqZzproW6Et8bvaSc1DrV6UcFP81Cbfbr2c+AQII23zH50Vy3PthorZ2K3RFfr34lPt8Z/deF1dNljd4PQaAXtO5+sHvEU2+9Bu78nlFQbwpSWxWW3C4qOPZso0XUEyNdh4bFFs34UCAdsYvkeYZPP1NPMWk7L++/NPbsLcunUiJgmHr+U4DxCUEDHTAoBzo/s+dtw1VJh1NlEW2vnUdivei719zgIV0m3IAlEx+9IyXhwD13y9/EieIYGEoBdJ+hLSF5gKY2c5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvfW3M3x3mCTnzPfm5btmlj7WDP2Jgij/ApKeZ2DglA=;
 b=gk/tur6EV4hfRg0KqyWw1+9nE/JbpuCpdPxiFZmKf0gHiEz4N6aQuokV79mFhkiKicPEuzkSq8oNcEKujxUulQ1GI4XUN/TvlYvo2kXU+lEdJRLz70uUmnuYfEcLhwIrAcB9Cz2Y2557XS7TuEMVEFcjt/aZjt2jI608SqNb1+LcyXwJya4ASp9IQvjONV8qg9FjHNneOAw4jz6Jrs4VK0bR38aMWz7+8HNWcY7rv/PP33+TWItJkz4Ydsi9KvpyfRk4GrfU6Iob7acOHXR4QtYxUdkFW98VHzs19G+L1YHFCNNfnXgDqSRa4wOtUky5YiakjksOAnXj3j+Q2R8Csw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvfW3M3x3mCTnzPfm5btmlj7WDP2Jgij/ApKeZ2DglA=;
 b=Lji/BdTbR6eWQzfeK+l+VdWC+vhBwptW7xK+P62DuY0p5Absk8mBRPGAu4Q3tVWEfZBws+wXZkICPgPgJOjh3JLdSXhWAGa1FPyba6y0COKQDs8yATj+WzL5TVI3ZgH1CbCezp88LDsJf4VQroGCNqAxM9V+4jZrizIgwoBfmlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 BYAPR12MB3317.namprd12.prod.outlook.com (2603:10b6:a03:d8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Thu, 11 Aug 2022 17:28:44 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::d9f4:5879:843b:55da]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::d9f4:5879:843b:55da%9]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 17:28:44 +0000
Message-ID: <142856e7-cd65-166a-9207-804c2693b9d2@amd.com>
Date:   Thu, 11 Aug 2022 22:58:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, bharata@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-fsdevel@vger.kernel.org
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b21f41e5-0322-bbfb-b9c2-db102488592d@amd.com>
 <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
 <20220811133255.GB916119@chaop.bj.intel.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20220811133255.GB916119@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::16) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a038d8a-8f88-4eda-1bc8-08da7bbef0fc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1A32wH4kSykzrbS7+HlTQmB2gAGIPxh4WwpsHbact0RYg2jcukRQ32i/ec2408w+Q5VW2pMyPxF7lbr4BTIibUq4AXX2M2KsczUZk6gPcsVygL1duTJyNudgQJhGb3bkyDATIV84DCQIAcg0yPTXq8tK7b1uBXIiiuJk38WBrwvjl8oAd8qa3xlz+muhQ2ra3QPY6Iv2ZEsyP9gDim2QL8n3dZgZ8ZZ5IWyWX1o5EZWXtnyaC90ZCoGylhILAC4KBNM9tO7oldq8MhhqAnLEqqr2KTJbxRYmshtSkExKvmvMgLSkiWG8gJwJZoLzPn30hu4FlYdI/fPNvO+oZ6/ikRi6bn/QLd680onFWTTk/6cZzxszfmJIuU8VvnXvwFN0RbEgwuWS+ciGNg/+AUV4YXl+eFXgry/XBkJXUY5k0EGNu8p9aHqCjQkRcL6cqXNDYWHnIOmJJA7pUnsapRTFdTnUrJ44GkZxVSOrjn4OVnd2VD2g3c1qEigpnWgDD0qpC5/jWaEj/SifmLfOuhR4S6zWu+1LOcXSgczY9Nib2X5NcPrM4PBOGejZTUiwrDfuT5wJh+WT+p93ptAh6sQPAZn0imFv4GyfwwzXwXpqdxiHFZmq0DHLn7ot6qQHd+2RoQzpBzxr4LFUtIjjz3q/2p0i/E0RG4hhxWeNJNsCWJwyHvGrqIjreQ/dyQrGS6uVYRs65NuHYPOZWFRG4EAUH7aaUiGK7diiy4GuYcvmSyPJAd0Jno8ZdIb16NaZX53AgJ1/3bekRiMxtvWbKjGM7HInv/qSPjLvGcsmKkEPy6jGivnqi4mjj16IhkGoDUC//qBLI/6Z81ZGn2yxf56TdRlYrZ0/xbYXQM4MXc3hfZdq/0PvaoRccFxOq2JKU2DjJJPPHK8KxLSVl7brGCddMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(54906003)(110136005)(5660300002)(8676002)(478600001)(8936002)(4326008)(316002)(6636002)(2616005)(41300700001)(66556008)(7416002)(36756003)(31686004)(31696002)(6506007)(26005)(66946007)(7406005)(6666004)(66476007)(53546011)(6512007)(2906002)(6486002)(966005)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXVPUGpKL2RST1ZLa3lRajVINm1wZ2JUTjA4VS94eDdYbDZHTjAxN0Y2M0Vn?=
 =?utf-8?B?dDJsRUgvSHVBT2NSNUNFb3ZsQ2hsL0FoNnR4emxsRVBHM1NnYnc4QlM4bzJj?=
 =?utf-8?B?VExLSkNCN0VHblU5QU5xYTJxcE9OL1MyRjBaZm9BREVSUk1aTUtLeHRRa2d0?=
 =?utf-8?B?dXF1bXh1QkpqeGF1a1AybHFTT2JUYU1Zb3VqWWx1b2pTUGpYL09vUVc1OUFx?=
 =?utf-8?B?dzRuTEZXK3FUVTNMcVcwMGRQNk9VY25udjF1N1JVNWFjelFQK1hQcGpKS1B5?=
 =?utf-8?B?L2c1eFFVc09mZXdPMGV0SzJMK0NIQnJVQVBVdXQrd0FSYUF4NG5xdWtJTGpE?=
 =?utf-8?B?VkR0L0hHc2JyZ0syUlR3a2lVeUJtU2t4dVFDRkYrcXZjYkFNaWNMSGd6aGwv?=
 =?utf-8?B?TjFLdU1XbWpidlZvYmFVQTB0TUR2UjlPQXpDNG54bmwyVmNnaVhHdDdCanlu?=
 =?utf-8?B?YmhaVUJOSlRaWjVKTGRBZlFzczlDN1dWcEZtMzh6eUZRVzJjMCt0RWJ1eUJt?=
 =?utf-8?B?M25wYWI3ditoSDh3dWlGeVhHV2lKUldTMU10Kys3S2hYNUdJNmMvclhGVUh5?=
 =?utf-8?B?cThaWkxGT3RRcDB2aU00RE9ZcWlIeERVMkh3Tkx5aFRkU1VuNWZLTXVSZFRj?=
 =?utf-8?B?SDN2WjlCVGw5K3ZvalJabllKYkIrSy9CbUgvS0JRb3VUOUVYY1dNdVQ0ZlBZ?=
 =?utf-8?B?UEpOd3FHVUZRMlFkYmtZQm5UWVRoUC8rUWE2MmFnckVTMkZFSGdiN3ZPcW9I?=
 =?utf-8?B?MjFtSHNWb1QxS3NHQk1ndW9Lem1CVUFMUUJKVmc2T2xXcGhncDdxVmprb1d5?=
 =?utf-8?B?ei9LRld2Y1RXZHo4Sy9LNS9jS1NXUXF2ZlNTWW0wczNWcW9tVDFiSC9hN1k0?=
 =?utf-8?B?WVpJMFhXcGJCSWR6OVBSdDQyT0FuSU9wNHpLQ1hEall1K2E0a0FNRlBjcmx4?=
 =?utf-8?B?ODR1S1lLSFhncGJYYWRpSnMzUmNwVExrakh3UitNOG5hc2NmNVkxQlBzdkxu?=
 =?utf-8?B?OHl2V2dzQVMxSy85WjBkeExEUzNSUitOWlEwWWpmOHJkOVdxT3JkcTlKTFQw?=
 =?utf-8?B?Rk1rdWFlUVJDZjlRK2p0dWI4VlBEVmR0alJxR1hmU0FLZ1E4aDRmQlVBT2Ew?=
 =?utf-8?B?OWloQUcwZm80cHZVRDhBdXZ5YVYzYis5bjFNRE5IM203KzB5Wk9UaXJ4S3py?=
 =?utf-8?B?MlJ2emY5WUV5MzFQNmNDc1AraE9jZi90RGFDYy82NUFNdnJnaDdOTk1XMjFh?=
 =?utf-8?B?QnU3NXpKc2dQSUVuVWhxZHdERGxUNk5OZXJjWTVqR3RDbktXcStVMTdld3E0?=
 =?utf-8?B?dGVMREduSHowVG52TEFyT2RPYisvc0syS2pwUlhIdmtHYkc0b0tuSVp5TllY?=
 =?utf-8?B?ZFlGZVpMMEFYbGlrVUtTSnpIYkljOWtydXZrWmJCRzdEOEU3ODdzNi9Ub2hZ?=
 =?utf-8?B?VDNtMXo5UGxzdVNDaVRJV2trWDNnTkhMVForY2xtRmJLcDdrZ2dub0pZNHc1?=
 =?utf-8?B?YTJna3h1d3ZXOE9EOWNnQ3ZtZytVTTNIcTZuTFloUE5abElMWnNLQ09GZ3Jk?=
 =?utf-8?B?NklsZElGVjdXVm9ycXZDUFlPMFNoOXU3eC9vQno5eTYxK3IxV2I2WXRYOXFh?=
 =?utf-8?B?WkpwbVgrdHBQSFdmRDZqRnhvWm9xSDhTWFhxR0RlSjFuUkU0TE9KcE9EMmIy?=
 =?utf-8?B?ajBpNWJ0aHREankxZFlCZjBoaE1pY0VZRmswTEU0M3ZTS3hyMXRoZ2RxTXNz?=
 =?utf-8?B?elpLRzAxWkxENU9ONWFZbXNEdThUVDhlMzFHaEhDVWtjc0dPcjFjV0pVTEt4?=
 =?utf-8?B?bWlnMVl1WEJtSXRuT3ViZGx0SGxacDNSQWV2bVpvNjhFRFdqMVVmbXhWay9s?=
 =?utf-8?B?NDVEbEUwTTN0bnNXcnRkL1FJandXNEhhbUh2L2JLWkxKU3FjbmorYmRvaEcw?=
 =?utf-8?B?WFA2SDUzekhhR1FxUDBoVUNTM3pROUR3VUQrYVI2Q2l5anJvQTV4ZjR4SmNC?=
 =?utf-8?B?dUNiWkhCWThyRkJ2MWI2ZGdYeHQ5ZjB0OW9tZGJ3a3Z0VEgyV1RYdmV4SVBn?=
 =?utf-8?B?SVBGWURvTWcxbVpLaGw5Ty9UODZTejYwdVRDdUdzR0dXQkhIQ3dBVVRLb3Jm?=
 =?utf-8?Q?hwEZXR+NzaXR72ZE4IoVnM3ls?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a038d8a-8f88-4eda-1bc8-08da7bbef0fc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 17:28:44.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNymxG56lmJ7H6bKXrzYfO+o3Lx+Nu0J/ag+J4LlIJfz0Co60fI7A+1aodyt/PLtChtPo1vRjMP0iC1q9F8g8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3317
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/08/22 19:02, Chao Peng wrote:
> On Thu, Aug 11, 2022 at 01:30:06PM +0200, Gupta, Pankaj wrote:
>>

>>>> Test
>>>> ----
>>>> To test the new functionalities of this patch TDX patchset is needed.
>>>> Since TDX patchset has not been merged so I did two kinds of test:
>>>>
>>>> -  Regresion test on kvm/queue (this patchset)
>>>>     Most new code are not covered. Code also in below repo:
>>>>     https://github.com/chao-p/linux/tree/privmem-v7
>>>>
>>>> -  New Funational test on latest TDX code
>>>>     The patch is rebased to latest TDX code and tested the new
>>>>     funcationalities. See below repos:
>>>>     Linux: https://github.com/chao-p/linux/tree/privmem-v7-tdx
>>>>     QEMU: https://github.com/chao-p/qemu/tree/privmem-v7
>>>
>>> While debugging an issue with SEV+UPM, found that fallocate() returns
>>> an error in QEMU which is not handled (EINTR). With the below handling
>>> of EINTR subsequent fallocate() succeeds:
> 
> QEMU code has not well-tested so it's not strange you met problem. But
> from the man page, there is signal was caught for EINTR, do you know
> the signal number?

I haven't check that, but that should be fairly straight forward to get.
I presume that you are referring to signal_pending() in the shmem_fallocate()

> Thanks for you patch but before we change it in QEMU I want to make sure
> it's indeed a QEMU issue (e.g. not a kernel isssue).

As per the manual fallocate() can return EINTR, and this should be handled 
by the user space.

Regards
Nikunj
