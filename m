Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4557FC36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 11:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiGYJTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 05:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiGYJTL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:19:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B0415A04;
        Mon, 25 Jul 2022 02:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrzFT5MtCs2Btrdz0IkZRQzNnDlmXCtQL32KPXjhRvJxVFrnRbuUM9pn9jfA2J6Orf5U4WlWM3eayabxsnHDEgLqGMnykPklgRktvaz61DR7HZ6MmY5hpm57X1DtjyPbDujbD2WKltyrlYdPnkrxnLxpn+m4xs5FInHS7QcHoEqX3MRzJuZG/g/a6bhPES9j15iG9B5valLF2bqFb8sL7H6/k62/EgXqEdT7J7PjdmlHNRZYg4r5h5wwX4n4ixVEEuSeyN/NrtewRZgxl7KoyL1DBrOB4+emfmxKOBWelJ6ySMliyj098dXfQgVWbbzlmpksp7/+jwviq9+Z6J5TeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9gJz52bityA0G4eTEvfuw1EK4wdHbEs3XJxz071Qyc=;
 b=MPLdT8Xzz4+wMsAyK1E3RqK83Tbr0/8Y0BljTnr9WPWRbY1x6XI9EgNP1R7SEUu9rsRdaWTxIPZY1vPdTwooIxgsmrFk3ZH7k8iqKVHJ8uEfTBGpNEesX36fBJAlcPxWWYe5eIM73YBK0fJQkb3m3kVR6wgxFL7sKReQlN3QLyaBg2iw6F2tSTefDtOU2KrhjqPg75h3AXavIUTl/o/FshLDMIlNILSg/d3ZTRyVeowMeviFIKUKKfR8L6Amd6ZL7SyMW6t4MoeanTHEw6kyMFcV1HZV4XKKiE+XXyKybqkg+HRXtP0ouP7mqdqk98i3tY8LiC8J2g3Gdqr+lNm5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9gJz52bityA0G4eTEvfuw1EK4wdHbEs3XJxz071Qyc=;
 b=ivEYi1NKyxXbcSIPS5dLH/QOgXrK1TRmNxdRjlqcoH4P9eqA10vqfU4Q4eCcVZ4UGsOM3Ukp6zn1ttsMAElq22WZTq7U3gKtO+lJZLU2SA+2eXQaZJjibcjTHXfWUW94zgOZb8DlAtRWdLT8QR7kCJUs13eq8FzjnJQz8qvGmxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by BY5PR12MB4917.namprd12.prod.outlook.com
 (2603:10b6:a03:1d1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 09:19:06 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5458.024; Mon, 25 Jul
 2022 09:19:05 +0000
Message-ID: <17ce3189-5e88-3c9b-605d-e259dcedece3@amd.com>
Date:   Mon, 25 Jul 2022 11:19:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Steven Price <steven.price@arm.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        nikunj@amd.com, ashish.kalra@amd.com
References: <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com> <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com> <YkyEaYiL0BrDYcZv@google.com>
 <20220422105612.GB61987@chaop.bj.intel.com>
 <20220509223056.pyazfxjwjvipmytb@amd.com> <YnmjvX9ow4elYsY8@google.com>
 <c3ca63d6-db27-d783-40ca-486b3fbbced7@amd.com> <YtnCyqbI26QfRuOP@google.com>
 <2171cf37-ea82-25c5-ad85-a80519525045@kernel.org>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <2171cf37-ea82-25c5-ad85-a80519525045@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR1001CA0070.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::47) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fe40321-a29d-4fb4-40ac-08da6e1eb82b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4917:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSz2FxlVn7MaI5zGpyMLVRnxvM5rzwItupVpbKwUttGhbMZx6lCuOOLqSp3BL6MRxkNxJUZAdJNFWd4+zFkgmmIM71urdKNuIK1wEfvhNuUW/qTxPqVo6gGb+nUt4DoI3ge2xfKCpYgnJM9THIc5KeCN+sdRVwDSzc7aYkX4sxKPlCzTV6YSVkE4trUSwU1cAoJWnWUVqYW4l2ivp+cCaWZECDkmD72RlNC4BWugA9vl4cRz7NUtAuWiUi8E28pc6rIL1P+/K827e/4ywKPVaGmuoJbMlooGjvqSVIGEDqe51+/zQjpMT8lj635CWSs7bZ1PBBcStp1r4JkiU6+Z79txe0/z4ZVRAOKeEo5Oy5Wg/raE+SFXMwHrhEWowE4arrCXG3J8D+dAhqc+lUBqmWVry06DPN78ygfXFT4N8hFHKfXiSXBLQF7B8wKt1BqXSVz8PdDTjKyxJQnxpijkQtBZXwNswRNQDsPauwMRnR2VG95c9y1uspyOhyITNhrLnbBAtoMaZ6v+YvoQJfogehgu7VvV4BC88eyn24XyhTRTYisYo2iADsEDwPwYhbOdnM3BSJsjJtvGcK2eZoy6IoHauB3mbWSZH6h2DocoTsffyPMfcIC6eICHGNDBQgpEUXp5ntKSw1f+mAC6dbGUcFxuHYgMbjiS9svuGfv9hzsBZibosAe6XzGWLfJH+C1dDJjPSUq1ugPb2tT0+bycIjLrvs4aABoqZXzOk4HqMvOV02dpg/UuHVS+bjHW2czNNAGxt9y+ovLZHoPtyCGT405vI+5lQOuCNHfMFd0Q7T99tYkyOui9uNHChC6XOgS1CuBf7dxCVz7jW7BeaZ4PGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(31686004)(36756003)(83380400001)(8936002)(86362001)(31696002)(6512007)(38100700002)(2616005)(6506007)(186003)(478600001)(316002)(41300700001)(6666004)(110136005)(54906003)(6486002)(7406005)(5660300002)(7416002)(8676002)(66946007)(26005)(66476007)(66556008)(4326008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVVSWxzUUxzTzlLWDBycWtGZXkzZkt5U09FOXB4OTdxbVRpUWs0dmFRT0cy?=
 =?utf-8?B?Z21GSFhGdm84WFNkOXNCMzFuNVNnZllWTGtmMnZ0ZkJwUHZRcVBGajEraVpK?=
 =?utf-8?B?dTlFSjFGNkNjQ0svSm1UWUszbkY3T3lXNnFpbk9HdlVHRnpoM3N0NjhmNWNK?=
 =?utf-8?B?Y2xDYTFLcTI2Z1hqV0lDME5IL1g4SDkxb3U1UkpXSE1wOC92VjRLem1hLzkw?=
 =?utf-8?B?Sm85UkZ3eUg3NlBIbjhSdzNtMHo4ZGlpZEsxYnJvbXg5Zmo0TUJHTzVlNEVF?=
 =?utf-8?B?aE5ieEl0RUFSUnJHMXdZclU5Wjc0RTlLWjVjTDRCVDVYMFExaFFQRHlPY3Rj?=
 =?utf-8?B?THBkdkFKMS9iaUVmOUNWN1A1SEtBaXJiNXRqOFh4MS9acWJPYmVhd00vMklo?=
 =?utf-8?B?S0ZEK1dFNTAyazNZQlpiYVhRK1ppWkcxWktKb3JBWktxTGozMjNGcWZFbGFH?=
 =?utf-8?B?MjBVSG9pYzk1SlJZbElwVkswQUYwSkdmRTVaRStPa0J0endFdjdkOHFGTEJL?=
 =?utf-8?B?cXFwemNCeDkvdHU3Nm42ZzFlTFEySUpGa1lReDJwZ0VVRGZITEUxMzdGSXVR?=
 =?utf-8?B?T3RvbjVLN1RXZnZBV3dkR3RXSlBhQ1F3Q0VnYmt2WGppdCtqdUVFQUhTN29s?=
 =?utf-8?B?azhYY1h0WmVueENKZlJCNDQ2d21TNU1yVWMzRWQrZW0wL0ptSXE2ZitlNW5t?=
 =?utf-8?B?RXpaSUlJSiswWndXSTlRcUpsVjcxeDM4eGZKb05OV1hzeVZWSm1uNi9DT0lz?=
 =?utf-8?B?ZUhlYW5qcmxodVMxcHlkZldDeU1mWWJrTGNsSXFOd0ZRdkRTUGxIQU12Rlpy?=
 =?utf-8?B?TGhlekxEQVV1aFc3dEplYWVZNzBYZm1HdnNzN3phQVhYMENUMmxnMUlrTnNB?=
 =?utf-8?B?VDVqS2V5L0FzVnI0V1JwRWZ0cUlyaUczMGdoRk9vTnpjQ0VCK0FCbHo1cVlR?=
 =?utf-8?B?dGNoTGxWeVlZMXJ5dVIzMUtaY2o4MnB0OWhyUUc0NkJGL1lMck0yU0k1d0Ru?=
 =?utf-8?B?UXBsNUllSGcxQ3V3L2NKRS94djkzQUQzYlhPd0FkS3o1cGxuRktLU2svSkVU?=
 =?utf-8?B?NHZ1eUtWL2RGeGhtSGF6d1lTank1bkIxTjFvU1RwZEtFOTNvUVJxeWpFUHlv?=
 =?utf-8?B?NzhWeHRwZHh1ZHBmY2x2eUxZb09hVmZyWU1vQUp3Q0pWOUxscFNwdndiZ2Y2?=
 =?utf-8?B?S05SK1RwT0xRM1VhOU8ydEhLenFtZHFwM2hlb0o3NDJ0NGJiM2JENlV5bmwy?=
 =?utf-8?B?RjVzUTdzR2hKNmN0Zlk0WUxhRFZoZG5rekxmZWlUVnV1NmJFblI5V2xWWVdL?=
 =?utf-8?B?TFNEcjdCcUtJK2pRYnlhVnNhaTFaQnNsd2FzWFdTekRwL2JUWmczVUJXU0tk?=
 =?utf-8?B?RUk3RGdJcFlja3dicGxydmJvYmdMekdtTEhsTDBrU2k5MDJCRUFNOWpHbFJp?=
 =?utf-8?B?YWt1OTNUZWRTQUdGaWtPemtqS2o0TTlIVzlOMEtmN3Q4eWxUQ2QwaFY1RW5u?=
 =?utf-8?B?aDA5SmdNazRyd1ZlazdqNEJTd1p3UnJGWlRrbm9LZVpiRU9YUzBvbHQ3TjlF?=
 =?utf-8?B?K1hEdGVMRU9sS3d2NDAxUmFXdnFoK2RydmtQZ2F2dnc1UkgvRHYya0czN3Jl?=
 =?utf-8?B?OU1hNVdMR2Q2WHNwVEJraW9tYzFGUHlXSVRKMHlpWEx0dWdkeHVyWGNYcjh2?=
 =?utf-8?B?cVE3YThLSlZCaFB0SjJWSUtqU1hFbi9LYTBuWlpkZDJhUFlCN2pCQkdmbENk?=
 =?utf-8?B?Y1JXNFE2ZVo3YldGL2RTcHp6UTlGN0JVYlNRaytNMHdENTBqbDY3N3ZrajhE?=
 =?utf-8?B?aUJoS0p5NFdERTFvdHFzdVNENUMzTEFUOFQ0SXpCUDVaQXgvbUIvOFNEWm50?=
 =?utf-8?B?ditvNnZTcVMydzFqRGdhdGp3WFdlcWFXRU54eFV0aDJDUjVlSDZFNjNHN096?=
 =?utf-8?B?RUtMQU5wSlBGams5ZWdCVFV3cWV6UFd3UDNISVViR2xFYjB2dithVEdmVzJG?=
 =?utf-8?B?TWZGb01SalFPcjRuOFBGQzE1bnkxWFBaQVZIbGhLYTRaWUJoZEhROFA0cnZM?=
 =?utf-8?B?YkdOQlhYdW92SklTSUhXYnRvUG4wd1poUGZiZ2lWVEZzZlJvek1yTFBWOHZx?=
 =?utf-8?Q?MxFDuwSJaqD8Ijo94HQzPfzVL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe40321-a29d-4fb4-40ac-08da6e1eb82b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 09:19:04.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eu57ewKcRDTfEijcv744kG5B0ZilckD434KHF/4Fm5vDPDwGoq31MQ8Qr+k2by0ldLNCm51PMOzvD7avPO8zZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>> I view it as a performance problem because nothing stops KVM from 
>>>> copying from
>>>> userspace into the private fd during the SEV ioctl().  What's 
>>>> missing is the
>>>> ability for userspace to directly initialze the private fd, which 
>>>> may or may not
>>>> avoid an extra memcpy() depending on how clever userspace is.
>>> Can you please elaborate more what you see as a performance problem? And
>>> possible ways to solve it?
>>
>> Oh, I'm not saying there actually _is_ a performance problem.  What 
>> I'm saying is
>> that in-place encryption is not a functional requirement, which means 
>> it's purely
>> an optimization, and thus we should other bother supporting in-place 
>> encryption
>> _if_ it would solve a performane bottleneck.
> 
> Even if we end up having a performance problem, I think we need to 
> understand the workloads that we want to optimize before getting too 
> excited about designing a speedup.
> 
> In particular, there's (depending on the specific technology, perhaps, 
> and also architecture) a possible tradeoff between trying to reduce 
> copying and trying to reduce unmapping and the associated flushes.  If a 
> user program maps an fd, populates it, and then converts it in place 
> into private memory (especially if it doesn't do it in a single shot), 
> then that memory needs to get unmapped both from the user mm and 
> probably from the kernel direct map.  On the flip side, it's possible to 
> imagine an ioctl that does copy-and-add-to-private-fd that uses a 
> private mm and doesn't need any TLB IPIs.
> 
> All of this is to say that trying to optimize right now seems quite 
> premature to me.

Agree to it. Thank you for explaining!

Thanks,
Pankaj



