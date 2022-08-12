Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C7590DB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 10:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiHLItM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 04:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHLItJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:49:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C79A8CFB;
        Fri, 12 Aug 2022 01:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIIbbVcSTK0hrEDWiu/T1QatObSS2ZZvStn9Xpqwl3R8NSTD9n5uDVXNP6oB8bKEH/s9QTA4UHmbN60QnhRNS4XxoLcNi///Oq41tCnZCMB5gvmRyEMNVUK7wT/3YsI81oa0Th32xho/fHe3RD+n4jZjyjbmjBYnjPx7kLmQXrd8ag1p3ZhzNGzRxh/xQYhidfJBtfk/gmby9fespEIr3Bo/3ITCagtd1ws7UNhIkYaR3wNqhiLzbpKDidB25hpEda4ffmkoem9UbsgwlPqWnBpzrCl+JWLMIQEN3NLfrBQtRgcIuSK3xw/e2BYTgPZqTAkrGbCPR0zm7hbejlDncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbdCV2Ygct+BRmsibKIcSpi3M2XpGECL+BnEDza78a0=;
 b=OyiYz5SyR1JQ6CHUt9REWbbL4L96T0ryzr+RO2uo9YGTUTisPNaR72rrWUTJZEq2h0tktBfQfJJgdh1qEGLUyPmY2yYQayBrho4yIuWbDBHMLDk6DpUwxIqIDKSRjmIjK+95dC/sEgiVDjVK1PMKGMo0Xo9FTWv4zKw0/1GE/eNTd3yGkr5M/8Q+jYHYJZkAFdskpdA6t9T4p9gYgnTaXyVEmmFshUOFLj/L9IAzL+KaYQP31/6ni/MZH059+E37snHdOx3wCp0isnLkxiikFIsAImOzc6DcpibjAgTUPwziqVTGSySUIiJpL8Gvv4Y3Xx9UvLTSNerMDOGmonjXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbdCV2Ygct+BRmsibKIcSpi3M2XpGECL+BnEDza78a0=;
 b=AiS1lgLByPjNExEn8Ked2x3LPMCpZLCw/1rgz5tGVjr2WZR39NXfrU/H4ZDnd0t4rb0xugSDOguZadz1Eq58WFkDLuGA8ILTQSz02E7njMXOJtl9uURt61k92087UnW56ukBZPPrxTgF3RvFaK66SebBznl5LdTxL1qIpVIK9kU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Fri, 12 Aug 2022 08:49:06 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::d9f4:5879:843b:55da]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::d9f4:5879:843b:55da%9]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 08:49:06 +0000
Message-ID: <1b02db9d-f2f1-94dd-6f37-59481525abff@amd.com>
Date:   Fri, 12 Aug 2022 14:18:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
 <9dc91ce8-4cb6-37e6-4c25-27a72dc11dd0@amd.com>
 <422b9f97-fdf5-54bf-6c56-3c45eff5e174@amd.com>
 <1407c70c-0c0b-6955-10bb-d44c5928f2d9@amd.com>
 <1136925c-2e37-6af4-acac-be8bed9f6ed5@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <1136925c-2e37-6af4-acac-be8bed9f6ed5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::21) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b8ea4c5-7219-48d5-451e-08da7c3f838e
X-MS-TrafficTypeDiagnostic: CY5PR12MB6552:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OilCSi020CLS1TDndgn6MI1D/QbhdweB0NZYsnhK9xXjjwTv9j8T/2NrwTd3g1SZ32B/WU4LkXouO911sU1CWTdgMGPh3EsIN8Mehq+uMS+whXISBOb2eRkkbXwApX/J95jH/2BOG0zBavx1+swBT12RjFEuPYdTZ6xFUj+/mNnxUucHJYuuCuqdlHLjYaaztaI7j1JfrPuwSz24ZsGqDsX+8SPvjl/o1pwNoba4Z1wFiOxyHx4ke4TSmB1tx7WSNUgmxNTNC2EUwYiABtxc9l9vtYL+mQv28tIv/NB+TQAuqk9NOThcZ8V1epLsR775mysz5FAYzmfoepUJ/VpPchBJWAvoKx1J4wffjJp6/KeaPXSJDnE91hDVNWNf0FudkUH1wF5cOdLQdws6xBmQLh9hkpZDWs94/dO49waDmvnBi3aiAZIZKlZmLka0+oGupqosNzKj0tveqaBq706fJ1N4m2e5ICTvJuGCuCpg9eLTKVemP6FBznHmV0naac58Y1iBJYe8IvggJE0FwOMt6Sbzf7KGIpbjHtWUuV0IKkqn7AW5KDNYETarw0K1ufzQx2WGERYVmb9DnRCyiNq3+N3vAhJzYwK+neMrBY44gPx1+oXfj1Q2i8gCdwcWcTv4vevuRxeeHSsgLjsnjgxCfeQYju1H3hA1dge+Tj8Cx6CTiZK8q4iBe0WRZcLCaSqljNITld4SIj218jYRs5Z0Klhkf+sf+AVYUY848OdWzXVTbIrOhvTut8s0/gHFcZyg1ZeAV46bFBSY+biVxHmDrOSygdPUJiaBkORjgB3ls9cL60gfF5KsSk4zmBSD5ROEdPF0T/W+t5ks/lOJXiRetA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(316002)(7406005)(7416002)(66946007)(66556008)(66476007)(2906002)(6666004)(53546011)(6506007)(4326008)(26005)(8676002)(41300700001)(38100700002)(6512007)(5660300002)(186003)(31686004)(83380400001)(31696002)(478600001)(54906003)(8936002)(36756003)(110136005)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BzakVtWk5WelFHVGR4U2xHK1ZkSHJsQmpLTlRTOEtISXhpeUVLZ3BTVkxL?=
 =?utf-8?B?elpTZm1GRXhPeGtZTGIwdGw5SkZ6akY1VVBlWUNCVXRUSUxKTVQ4QmxHRFVs?=
 =?utf-8?B?VHEvVzdReEo4OXBQMjJvYjBITVAxbkY2bklSMjVER1FRQ1MvVUUxNjlWRXlL?=
 =?utf-8?B?NHFkRDNZNlpQd3hKaS9SalIrU0wxQ1AraElTa3pCV2dXRkVWNDVlTXZ2czhP?=
 =?utf-8?B?S2JVS0lMZWpHUE13UCtXZGhJbFVmaU04T2d3WmZod2dpSUVmeTJwb1IzeWw0?=
 =?utf-8?B?ajBZVnFXMnJuR05YWlZheWhIRS8zMTF3QVl4WUIvQnFSVzIvZGZhRGg0ZU9p?=
 =?utf-8?B?bSs0MEVESGRoK2VSTkZCWUJMbWR5WjVpN1dTcDd4b1luZ0s2ZWNta2xhSlZx?=
 =?utf-8?B?NitpbVhoSVhxTGdpckVqNC8yODNsdVVER053cGxWa3cxcGhhTGJ5UVJSK1hG?=
 =?utf-8?B?Vlk4b2dMdnNCM2ZvR01HcDh5L0c2T29XQi9ZY2JNRE1pU0pJR05rS3k2SWls?=
 =?utf-8?B?ZFJRYzBLNm8rWUVDZGg2OEhuaDhvaHA4NEdkVHRuNTJ3akpBNmNucU54RmZo?=
 =?utf-8?B?WFFldHVTUXZQeFNPdVdFTklJVGYzWW1jbkhPMnFXaEtnTnVvZkxML3dPL2NR?=
 =?utf-8?B?dWFqYzB6UkwrTHNSVCsyQ0NqSXFYek5pMWNEOFh0VnZlaTg4OGNNM2pra2Zl?=
 =?utf-8?B?M0JwT0R6dlgzVHoyRm5nSjAwck8rbGlUZjEva0ZXRzlZYUVOQnRUVXhMaVJj?=
 =?utf-8?B?dHJTODF4RFN1eWQrV2lRYS9GN1Z2RDNZOFFSM0paTTJGN3dmcVdSdzlhQUZ4?=
 =?utf-8?B?eDFoSlQxM0lFZ2NrWi93L0FwL2NUYitLTnFnQjNkVS8wR2JSZ0tNbCtMcGc3?=
 =?utf-8?B?Y3ZsaGg2NHNCOEN1NEQ1dzE2ZEEwbE84YnN2ZmRpOFlUN3lTUjFaby80QURh?=
 =?utf-8?B?RTdidEc2Zlg5eTVNR0U4U2ZqS0xpekJoeWFneU1lanZZdHdsMXY5QVNKNEYr?=
 =?utf-8?B?ME9DM2tLMFZJNnNkUXRyakNlYVNCQVhiYkdjckFJY2pGZld2MGRPWElZYk1J?=
 =?utf-8?B?bU96L2tpbzVVQUNnQ3d5cll3dEtlbXBaYk9aOXF0Nk9uTjJkMFpDYkVTK2hw?=
 =?utf-8?B?VHJ0WWg0eTIrY1VhZGJuZjFnREI0OVhmemRmSG9LL1NqZExyT01rcW1KbjZJ?=
 =?utf-8?B?UzhkWHFYSTlzRUN6VERTNzA2WnVDaG5UZ1ptajhwTHFQM2haSTMyQ05obEhS?=
 =?utf-8?B?QzBlMXRuRVRVakJ0Y0pJbm9WbXM0RnFOM2EyWk5yT0V2bnRxZUpxU1ZzaDJh?=
 =?utf-8?B?MmlGSWxxZzJETVZkVWFPaXNXdXFDdjlzKzlIUk51MHBFSDdodk5jdHBGZjJl?=
 =?utf-8?B?S1R0enZyYU1jSjJNZDdiS1lVV3RGUXc1Y2I3c3FYN1NxbHlNUGlHZHEwZEJF?=
 =?utf-8?B?K0k4aGNsTnc4d3pVZjhZSFJMaXkwMjVRVklTM24xQkxaT2NmY0ZGZVNIL3pM?=
 =?utf-8?B?QVZ5ZlJWVnJTNU5TU09CTnFHV1dmU1MxSGFwZlE1Qm55ZVVlSHBnR0JaL3Jt?=
 =?utf-8?B?K3pvWlZZZnExL3U3alpJdnhScFB4WXdkSmo1dG9venBKQXlPZ0FwT0lDSHRk?=
 =?utf-8?B?VEorbGZ5S2VBREE0REhaTDBnN1lLTmF0TUR3MkRFTWU2Ny9weUVWTEpnOVc1?=
 =?utf-8?B?Sm9tS2hQeVRtZ3I2TmU1K2J2UW5IVG5JN01GckE5Ykx2TGYxbDRsbk5oajJH?=
 =?utf-8?B?eXRwMVVDYzgwNEFCeE9BdWwzR3l3bjQveFRrMHZielJFQlZCZmplczNDY1RG?=
 =?utf-8?B?TkdlbGU0eGEwYm5nRUx0NjVMd2hteHBRT2VteksvV0VpTGh3ODlhYzJXblRh?=
 =?utf-8?B?K0s2UUJJTlpLbHRxSjZaUXRJdGp3cnF6bTltcE5vK1BEamxoMzBTS2FIUkJG?=
 =?utf-8?B?dmpWOE5mZ1FrdkVtaWw5eVdMNzJudTh3ZEhLOXQ0eVJKNURlZEVIeFBWbTRo?=
 =?utf-8?B?dExZZXFFWHRPaDNRTzNlTC9ESEhTdTBEMzdadWpPN0R3bjNCQW0zOGVmcGV6?=
 =?utf-8?B?bE5tMGFEenZvZjBaNDkyNlo4R1JyUmZJN1g4TEkvNUJWVmt3d0huVklwYUlr?=
 =?utf-8?Q?+dPjbCuPqix6bdwYb5Lq9p+zb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8ea4c5-7219-48d5-451e-08da7c3f838e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 08:49:06.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqIvmyWBuV56k8I8EjEpjXZhAHX/35B7BzOpMWW0Nny8mdgzuGFM6RqdI4JCI0PYFdsJ0WvRdm0M7D5hWh2iFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/08/22 12:48, Gupta, Pankaj wrote:
> 
>>>>>>
>>>>>> However, fallocate() preallocates full guest memory before starting the guest.
>>>>>> With this behaviour guest memory is *not* demand pinned. Is there a way to
>>>>>> prevent fallocate() from reserving full guest memory?
>>>>>
>>>>> Isn't the pinning being handled by the corresponding host memory backend with mmu > notifier and architecture support while doing the memory operations e.g page> migration and swapping/reclaim (not supported currently AFAIU). But yes, we need> to allocate entire guest memory with the new flags MEMFILE_F_{UNMOVABLE, UNRECLAIMABLE etc}.
>>>>
>>>> That is correct, but the question is when does the memory allocated, as these flags are set,
>>>> memory is neither moved nor reclaimed. In current scenario, if I start a 32GB guest, all 32GB is
>>>> allocated.
>>>
>>> I guess so if guest memory is private by default.
>>>
>>> Other option would be to allocate memory as shared by default and
>>> handle on demand allocation and RMPUPDATE with page state change event. But still that would be done at guest boot time, IIUC.
>>
>> Sorry! Don't want to hijack the other thread so replying here.
>>
>> I thought the question is for SEV SNP. For SEV, maybe the hypercall with the page state information can be used to allocate memory as we use it or something like quota based memory allocation (just thinking).
> 
> But all this would have considerable performance overhead (if by default memory is shared) and used mostly at boot time. 

> So, preallocating memory (default memory private) seems better approach for both SEV & SEV SNP with later page management (pinning, reclaim) taken care by host memory backend & architecture together.

I am not sure how will pre-allocating memory help, even if guest would not use full memory it will be pre-allocated. Which if I understand correctly is not expected.

Regards
Nikunj
