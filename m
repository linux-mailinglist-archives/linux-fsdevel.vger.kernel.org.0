Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E69C57D613
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 23:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiGUVgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 17:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGUVgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:36:23 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668A31C102;
        Thu, 21 Jul 2022 14:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKjQA7jIY+jX/99VpUchCQ79rh+yPX/q9wLLchreMvWyq9nqRqNeDplr/NtAmZaBp7RnelyjVlz/yIk5bSVehN/K1Qmig+ay4iR9MW6B//bn8by6//Zp54sv+UuPLWPpcezWdhy5icZc8JbbVZKV4jrAmbuguqR7AW7HfzLShkdWfq6q1kAiEGurH3y7sKxtEOqvWAghM1jfYAlG6O/RCnt6Ae9caOyGSA/3GCAlQw6zW8Pq+Sz7XDaWtsQO8bqIitLhJCSXqNqSv+sKO8+GwMsfSkuKqmZ2kUef9oNCEdTxOJLhZDn4Su/0/eUbnjAyl2QGUCK9ITUmU/4kz5IM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ObVw19QKlnGSQOIq+Wx2T3DuEwOipm6hnR+n3mEX7E=;
 b=BUOhY4T9nvi7lNOnTHR+lve0XWWZJlsc3hpnPCQk9ykN36rzUaZIfJJlKRdpeIx42+FCMCLO+8HFOvRY47udhoipHw55pzshn027Zs5CwwfJb4t2fxw+B+xp8ofX54xKOHDMBmPzhNsg4gISwzHpz9xocv00pWHL4Rt/LmAbbuHT9ibmSSVi0x8/OFu4RnFDoDRWV0M2wOjovbYDxDMRErslpGjM6M2hJ1tRfsaxKDt0lg4V5F3bBCsDxLoEt67JWwAsfSh3DU/gYBPE6fpGUiNfu6ub1NHADxl+Q7ETmgIdaRNLCQM5k7kS+LSe5Bx0FVtmc+KD1MQHZgys7Idw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ObVw19QKlnGSQOIq+Wx2T3DuEwOipm6hnR+n3mEX7E=;
 b=cm9RzlPzb3LQfP6iLveo0RU3YhnLFxMnDk6XbC7plimiY8LIUqExKyjLPJ6Vw1GHCiWuiMORT2UOE76InMjj+LlxHlF7UfdnDfp18PRZF1R2Ur0BOWxhmX2ebxao++rclBMY5wta6TASKDNhsqjvmFeu7QKrVjhvec/oQfovh4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by BN8PR12MB3490.namprd12.prod.outlook.com
 (2603:10b6:408:48::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 21:36:14 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5438.023; Thu, 21 Jul
 2022 21:36:14 +0000
Message-ID: <210c89b2-15a6-536d-b149-ea2d9f9fccda@amd.com>
Date:   Thu, 21 Jul 2022 23:36:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Andy Lutomirski <luto@kernel.org>,
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
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <YtnCyqbI26QfRuOP@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::7) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36ae7c10-47b5-486d-16d1-08da6b61097c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3490:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NlgUAH9CxSNqctLqi309zwVw2V4sTCDQAACDQFbWtpxSvqY77YHoBO0x5imqdh3q+oRzOjAiiwo0ZI/iR73afDIa7zz6bCdLKGUIeB36vh5Aa3CJRmeVJZHe9zba11WZwAtf6vrisv1ZC27vstzJ1TjPnFSaCfhWhiA/77X2RpMwcIa1p87gg97pr/n6mLWabjqmQVLy+EypsxGumK2vhOCaJNTo+n6S2xUAKCdx+WMEVqlqvUI+t6vdm8V3WqJpy8/8CUtn2rieH59huwM5UVWgc9X9P7peuPrzrLuY58iI1SYt7oeuubyieLiRmnLXFlVjCku0EvT2jlzvsIBCrUWQVMssZogMjYeyNOWxDQ15ZnNeZ8C7kvILGo6ddoQgX3o0ERtY98jfvaqSN9fN9mUsLoTD8zCvDA+S5jV0zL7vrFtdouvUDYCBFiWgvOiFsBTHE+YiMlkXab+1+bftTedrTXdW2qE98qrKIOxFeOb9s4+0iyIFUKBqHZkd8ZnzZu5RxDRArcyrVfwtsvVxT2SIoiRGHM6EUKOWo6JmP0NSZT7hur08yFllwqHoF4lC/DAjoIdiHDFE8GfInDq4hk4wpGDTfe0YlCMPDBaTTonCk1CZ9Z4GEt/P5O8HE/dSaG3URuQqxFO5SfGP8OLtpstwtIGZY6AoJjp5uhHUE1HXegG4ERrtgKRK2wYTBbU0HuAwPHYKgCd49aF6Sv5boqnRQgyYgMzDsFTf80JxArdRbEK01JBp4Ei9+1dmFXVqQ1tNoIHDS6OOJgW0+vV26c9/Ef+HGBAfkdzcl0X/QgoylPn0uoJ2udLR6b2dioUqImm8BmH/zGxt2naDn2FTOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(2906002)(7416002)(6486002)(66476007)(31686004)(6506007)(8936002)(6666004)(7406005)(41300700001)(36756003)(5660300002)(86362001)(2616005)(6916009)(186003)(54906003)(6512007)(31696002)(66556008)(316002)(478600001)(4326008)(38100700002)(66946007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkZZM1FkMVFuVmxaaml6VHFRSUxtYUZReXVOeDg3NEd0NFd4b3NhQXZDL1dO?=
 =?utf-8?B?V2I2QTM5YjRQSDBoUEZkOC9XL3lDMEY0TmRheGNuMjNFUUsvV1A5YkRpSU1r?=
 =?utf-8?B?ci9WTFhwUENDYlFWRVdibDJpcWZXdXBMODNuVkV4MDNpYnl3TWp5Wkpkb1Fk?=
 =?utf-8?B?VlZoUGFKdG85MU1UWHJ3SThQQVUrZ3BpOFRYSkNDcUNRZFBJQU1YeWJMWk0v?=
 =?utf-8?B?eWtnUHRNTHU3U3dFaWdHbzRicFBWNkhLdXZNYWZ0U1FReVJ3VkJ2bExVTEJ3?=
 =?utf-8?B?cUpsY2RsRE03SDJjVFhYVmlyYkxBRkpwRXFNaWtlMCtURXJWdFdPOW8wOENk?=
 =?utf-8?B?dnZyUjYzSG11L1AycEkrNFBuamlHeXIwbW9xQ3VnU0tFcVU0OTAzQlhXeWNi?=
 =?utf-8?B?NkFKTyt6WHhkUlk3SnBDUndLdUFFWVdDTGpVN0pyd2NUVDROSHlaUXdoRXQy?=
 =?utf-8?B?MCs3U1FJTnRRV3dwU1dMSEZGQkVWaXNxZzRDNDU2amtFdklNbWE4M1lnREUz?=
 =?utf-8?B?aTdqaW9RY2t4dHNwSEk0T0ZFM0hVTjdZVWtuMlJxQk1mN0c1WFJIbnQ3OTll?=
 =?utf-8?B?UlVaM2g2UWM1WUFod2gwQnNSSXBDMy83a0ZBRmtyRGpZeXhwYmRHa2trV3Fi?=
 =?utf-8?B?eWY5bVNoVHJpbGx1V1hxV3dVcERwOWE2NmtRd1Z4cnJ4bzB5RUl6c2U3bHFW?=
 =?utf-8?B?V2w3cVZtbW1xTGNQTGtIekxIZGg1SnhIUlErM05WcHlVdEV4ZmRoWDE4aE9l?=
 =?utf-8?B?SlowSEFBQ2VtV0VaZVltOGxKcmVacExiWTJFRWtaY3ZSbUJ3ZkFPMmw3VUNC?=
 =?utf-8?B?d1FSWUcwRkJBNGhHN1NYa29KSFB1Q1k3NTFzLzY5dkxuTmVhMEJEWkxxUDl1?=
 =?utf-8?B?Kzg5YUsxMlhCUWZPV2tGeW5XbHdYSklUQzh1dEE5ekQ1NExCNElxYnhHVmU4?=
 =?utf-8?B?YnJ2K3NWR05tSFpnU05KUU1RaFBQT3BlWWxFQWoxem8rQ0VlOEVGYi9BVDVE?=
 =?utf-8?B?QWoyOE40V2orUkUvUVp5L2gxRm9qQlNLTkUxeHdZM24zYmhkOEN5Y00rSkU5?=
 =?utf-8?B?dEFoZThlaXA4eU5SRTBpSzh4aDRMVEZ0cm1FK3VNUS8waDU0VTViRWJOTUl6?=
 =?utf-8?B?ZjQ5L3c4SmtnVTRPeXNCV0VYcnkrZXVkYjNIdHVEUWZlSHJWS2c0aVptZUtH?=
 =?utf-8?B?MzJXUDRPYlVlSTJ3eldxWUtHSUl6TnYxV0psN1lIMkZkOXJXd3lYVThZRW5R?=
 =?utf-8?B?VUhpVzFpT1N5VndDVStMcmwrWFEzalZxNkU0RXpiR2tXNWlnR3Z5R0VRY0ZY?=
 =?utf-8?B?YUt1QXl2ZzhwbVc2Vk9zcWhIc0wreXZjNDlVWlpwdnJDc2pxL2xNSVFWYng2?=
 =?utf-8?B?bVJ2Q251WWcxU2R1bHBtdGVPRCs3ejg5Uk5KZHphaTE5ejhEbXFWL2hWZitI?=
 =?utf-8?B?ZWtEUmdwUEg1cGltNm9kc0RpQUVhdHozbzlVNUdDMHZiV2Z3SkhUMTg5Y2R0?=
 =?utf-8?B?cjNyR25EcFFYaTIvOU01OWVGbzdKK1lLVGlxOE95V25mT09OTk9JOW8yMFZB?=
 =?utf-8?B?TXExdkUxL2t3STVJZE4ydkYwTlZ6ajhLRlJCWm01dkVjN1BGUW5Nd3RvY01N?=
 =?utf-8?B?R1A5SEI0VEJCdGpsVlhubXlBTktOMFkxM3FvUFZXZVR5RmNVc1ZFWEhIUVRQ?=
 =?utf-8?B?NzVnKzlUeUpsOTEvTE82NDhLdVY5Zlh0dDZMUWhBYkhWTlFxTEFCLzc2OFgv?=
 =?utf-8?B?YnBjSlRQNDZ1WHZmSTNPODk5dFF1a1RiaktuVDNQZ2NXcFAxelcrdk00M1NO?=
 =?utf-8?B?cFVsaEJqZUtVUDRLQ0FYdENWZTdKYS9xeXJtRVFrZ0NyV2dZazRya2ZySWo3?=
 =?utf-8?B?ZXNvZ2p2OVVabE5HYUJ6V2s4RVBNVThUYTlLYlFLOXBwd0g5L1l6Mnk5RWVp?=
 =?utf-8?B?Q2VkZHNkUEJJWXQ3TWZqZlBLV2hjeTk1WXNIMEEvcktGTkVia1d6M0xkbVRk?=
 =?utf-8?B?aElpd1IxWENtMEdObUg3UlIxVjFucktib3hzRUY1UVArUG52NEU4dk43bHN6?=
 =?utf-8?B?VG5OQnRhRDFGQlJIVEtLbnNvUy92NVV0MklMQ3lYK09TVkkybUZqRE1hN1Jj?=
 =?utf-8?B?a0gzQklZK1FINnpEU1VVcjdub0NwRS82YWJEWVVicGt1ZGNtVVdnMlJCZElE?=
 =?utf-8?Q?qKmCm9CUGfeKVnDlbZzMHcU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ae7c10-47b5-486d-16d1-08da6b61097c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 21:36:14.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLrCbP1RKq/ldTCiHzx4cnDQnyHqCz36UduLBdxvloASLGaW1F19/McYw69+SAyztSCIUuKSosgq9LrOSBrroQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3490
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>>       * The current patch should just work, but prefer to have pre-boot guest
>>>>>         payload/firmware population into private memory for performance.
>>>>
>>>> Not just performance in the case of SEV, it's needed there because firmware
>>>> only supports in-place encryption of guest memory, there's no mechanism to
>>>> provide a separate buffer to load into guest memory at pre-boot time. I
>>>> think you're aware of this but wanted to point that out just in case.
>>>
>>> I view it as a performance problem because nothing stops KVM from copying from
>>> userspace into the private fd during the SEV ioctl().  What's missing is the
>>> ability for userspace to directly initialze the private fd, which may or may not
>>> avoid an extra memcpy() depending on how clever userspace is.
>> Can you please elaborate more what you see as a performance problem? And
>> possible ways to solve it?
> 
> Oh, I'm not saying there actually _is_ a performance problem.  What I'm saying is
> that in-place encryption is not a functional requirement, which means it's purely
> an optimization, and thus we should other bother supporting in-place encryption
> _if_ it would solve a performane bottleneck.

Understood. Thank you!

Best regards,
Pankaj

