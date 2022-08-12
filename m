Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D74590C60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 09:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbiHLHSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 03:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiHLHSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:18:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79010A4070;
        Fri, 12 Aug 2022 00:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoyJAFbukgktx1KE84vWdFAWBC8ECnj13PId0QtsyJp/bOFT0KABe2AOr5al4tmwWcsvmFXBKwhDNsT9MkWZi+KPBuqB+Xhv5Iq7P9JWyT3G51wJS+rnHtaT1D/dEsjXR4EBjwsWKqElDaHgiMUk1whKywm6wMr7PEl+X/t7ddNP0eCfOHiJTM1y09QuYf1ER18phfy6d0XV7CtV6a/jaaWvlg4Yy66J5qrQve+dGCK9jLSpmkkx6uz+Yb9huH7cC4PO0w3VYdHf+PKINnthtKQ9tC6PjpcfRGg3EKFf+5srT4fl9FwvvZSWCIIyqGYy2aoKBWS1XcoYlbLZlf1t4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zroFRIFSstLGh7tVw6PPD2YU1BYMpmjanw3iM1m45s=;
 b=m5iDjVakdi8Zsbi9V+BmgZNniy6sfPIYzFbTZ0xLyCBxhykaG3dRy9KbA8LnfbZmq+OeaAM6s1Mkjm1fiXVJbHa/8MHIv/qFbAswm4J1+pnjQfUyoZ/LxW8GuqRIB4r/Ndurz+zgK4JN5My9CnhaJLF032ay7liVAY65Nl1MuyNPYNWAyQ9As7SIfBat/yLlTCrOXrM/9Nm7oYs5sXJTFDX1AUud+PVCtUXyUXso8CO4MG/EmWppj8ZmZi427JAwZBlLFOWGsCCs2zlDsiJ4ARdh6ku06LXw8boOKp7q5b447sFTF9nT4xlbvoisVGiJ5QZzPAge+iIaHEhPdmAdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zroFRIFSstLGh7tVw6PPD2YU1BYMpmjanw3iM1m45s=;
 b=ebbBppl3+1MG/dUW9sKkOzvw4jsBBz4kvkLRSHbcgESKOoy8ClVOv7wsLc8PxIft/tGRaKNUAeQs3R2XP4Shc1T4mqasx9IC60q7ml4JGUebt4EcvC66Qnfl2/vtXpjMI1iPp2Qk/C6zuUNtsHEXHH3DEtG/g+U2XaotVCWNYro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by BN8PR12MB4627.namprd12.prod.outlook.com
 (2603:10b6:408:a9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Fri, 12 Aug
 2022 07:18:36 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5504.020; Fri, 12 Aug
 2022 07:18:36 +0000
Message-ID: <1136925c-2e37-6af4-acac-be8bed9f6ed5@amd.com>
Date:   Fri, 12 Aug 2022 09:18:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>,
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
In-Reply-To: <1407c70c-0c0b-6955-10bb-d44c5928f2d9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0469.eurprd06.prod.outlook.com
 (2603:10a6:20b:49a::34) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcf50e55-f6f3-49c1-3411-08da7c32df2d
X-MS-TrafficTypeDiagnostic: BN8PR12MB4627:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbeMoHOZildULAYOtEx8OeCt+fQTiY6SYA3Kvtg7CVFnVfICFb+LyptXuRL3+t9o13Lw/vxggKaMufjJjzvzXEVmnyWgzl2vUm9HG7pZ/x4FlOB7t0OQw9Ge4FVGFScCREo/z/KSVPvBRKjoZH41c13K1FHkOxBsc3TVjnxO9QreX0Q7OLXztEM+ci47Ajom9QLTox3V7UQWkXIpPcqG47fNGvTpEki3weL7dvhIMXhnDLK9Tm8JHhmMr5vhM8XLtRr6axUZuIJfF+HcSL+MSZqJHe78mMR/r7+t4ERlR27WtwGXQfjMSTFJLWZ7Cb7dP+6n62H+w6hkAoR/Xz69Qq94IXDc9WaYqUgA1f7cVKzwszHCv3g+5ubhNktE5t2UBKBQg+mT6HT2QFadvTFt12NthfQeU+ixxn6Xi30JFPmRTV0VKK+y0Uiq27jwhheU3a7iQXnYPOywNZ+BJ8Zwge7YS+vsEAah1v5NuhPyLO1mIFrFlrLhj1l4G+W2Q89BhwA0zl01Dx2dm2cibhm9Zd4r655jJAfiSMF2Esmyhx80PxW572EmIaiYs6Ik7m+0JjE5+F+8KGm6fXsOeQu0EQ/HvtFP6UuVoWShizysyQYhkJU/IoeZ4s4GodOLxtLKace6YkJG/DtghxOtlmDnWIb0MY8+XR3xACpNXzudzUFBl7FOdB7+WQKolRusKCFuk8fCcMU0IxLHjRquIe4FfH1bevE7yY+cb6FFQt7xfco3OQTYRBQXPIfvMNGoqvfAIvc2JR13bvxQ5KRhhvRPCcPjmb5uy/rJsTBGTYAsbA57JPcpis7Wh9AzOsRXpUAIT0KENYnm+YU+G/q8hx3LXPiyul9xzmkLaiV/IluyuFurZeGPek5LaLGnhvOup3neVOQUcuwuWmRHDo3lFFxuLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(186003)(5660300002)(2616005)(7416002)(7406005)(2906002)(83380400001)(316002)(966005)(6486002)(478600001)(54906003)(110136005)(6512007)(8936002)(26005)(6506007)(6666004)(66946007)(66556008)(66476007)(41300700001)(4326008)(8676002)(31696002)(36756003)(86362001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulc5cFo0aUdWZjlkYkVYYXd0M2ZSNktyc3cxUlUreCtwMzhkOUpqVExNTzZz?=
 =?utf-8?B?SjNXWDd6UUlrd2VpREcyQmtUL0NEb1Z6MW1mT1MrZ2hXdjRaUzBZd3lCMFJO?=
 =?utf-8?B?bW54NktaNmgzZmZ4Zlpnd09jdUo3OUM5djhyYXRGb3NYblQ2MkFUT3pHdDRo?=
 =?utf-8?B?MUtnWFhZQVJuYVlzWjdtdm1OeDVtL1g0NHBUWE1QWVJsaFh6UTZsT1hROVN3?=
 =?utf-8?B?c3hoY3lUd3gxQWpsWm5Pdk9RWkR3ZVBjQUZvMVdxODVrcTY5VE56b00waHQ1?=
 =?utf-8?B?MHQ0YWt1TFhPa2NsTi9GNzgxK0VweFJxQXpRdTV5eU5aSkh4K00zWEI0T1F4?=
 =?utf-8?B?Vmd0a0NENkE3aDdDODhsc2UvdkRCc2ZkOEowL1pwSXR4SjBDUUZaSDMyc291?=
 =?utf-8?B?bXJkSHB0d09SR2hXN25uRTlISWRqNjIvN2NyQTlOV2wwVWcyTGpnRTF1UHV6?=
 =?utf-8?B?ZWFtS3I0dUdBTVRrSjBscWNLVEVOUTVnemJEQnB5WWZNb29aYWxmdk5aR3F0?=
 =?utf-8?B?TEJkS0djd1pMMmJDSTZJVUliVlM4ZEl2dW9YRWI1b2RRRHJwYXBycm5HMGlT?=
 =?utf-8?B?Y1RRQmM3bnUvR2VUdTJPYzNaZkI4ZTNDbklJS0dnNTByQzEzOS9wcXhzbWJy?=
 =?utf-8?B?WE9HaWxUckd6dzFROCtLRlRMVTQ3YThJTEloMGRMaktjZkRSQ2RBbHFKcGRC?=
 =?utf-8?B?OEgwTGxIeFp5NW9zdmhWcEFpRmhiNWthdS9qT3lNcUpEcFpPRTYvcE1hUTlv?=
 =?utf-8?B?L0J1cnc4T1NIcnoxbTkzRm5qaW9WVDQ2Q1MzQlFmbFEwaUQ4RzF2UUZWY1o4?=
 =?utf-8?B?MlBoa0RVUHU1SC9HSWplRG9uQ1BIa05wL2tvQnZadmJJOXozaGdjbVRjZWRI?=
 =?utf-8?B?R0dvUTBZTDFJbzBkOGRMbGNGTDNSZUZHK2RpOTVKWjhYeUNFM0E3eUJ6aElm?=
 =?utf-8?B?aDdTdTFreStzcE1qVDZFQXpwTm0yNFlrTWlLbk1zUmp0SjJ0NVpDL2xadkx5?=
 =?utf-8?B?SEhkUHQ2OTM0M3VZcE0rQjVudzQ5eG1UTVpCRnFTcUUwcjdGQW9OK01LQ1VF?=
 =?utf-8?B?dlo2UnlTeDZUKy9mUEl4a3VGa1krMW1FakN6cUx5UkgzcUNvaTJNV09Qalhx?=
 =?utf-8?B?U3d2OW5oK09ZLzBKUEFFcS9MZWZRVE5zWEhPaWdHeFB5SkN0blUvcUpsNi80?=
 =?utf-8?B?YktTdUx1bGZ2Y3VSVmJ3ZnhobnUrTkZ5Sjh4dGpUMlBMZ1NVR29QTmdVUFZn?=
 =?utf-8?B?cmFDYXIxb1NuK0FzdEFyRERwTkRvTHB1cDRmVTVlYXQ4QUF3TnhOL2NFaU94?=
 =?utf-8?B?ZTlKZnZSSUs0UmwxaHBVWTM5REZMSGJrWjU1aFVJbzJMZnZBV3Vra1pSSUx1?=
 =?utf-8?B?dW9ncnFvUHh5RXk1cE1kZEsrUDVGZmphREtkTzdGdjhKYjBhRTBROHRQZ20w?=
 =?utf-8?B?c1JTMUh1cUNOVEdhR2dZL1NvUnYyOGRHa1pwbzB1N0dDbTBTL2lJNjQ3eVNM?=
 =?utf-8?B?RWpvUkwzUDcrSGxOZTdSRGJVanF6SDNURmlFVEQvZGR4M01IcGNibjBpR0Jq?=
 =?utf-8?B?QzRVdUhENy9tQ1l4S3pzYmZCbHA5aTVnNFQ1M2Uxa0N1WWxYOEF6KytGSnQy?=
 =?utf-8?B?b1V4QStnYWJJaVZnSTVsalpqdzkydit1NzR6YXRRbFkwMkNUT05sUWwwOU9U?=
 =?utf-8?B?eW1WRitvemNnZXB2MXdIM3FjQ0VFTE5JV1BKOTJ1OUhZQitaUHk3bzFSSkZB?=
 =?utf-8?B?QldBMWZ3WFFKS0w1U3lIVXFtY0RQRURTL3pEbjc3aVlrS3BRL0FpR1FDSWpw?=
 =?utf-8?B?RFZNVFBXRnhtYlU5ZnBTeG1aL2dqZ3NFRFZMaGplbEdFaUVock1iVDdxaEgx?=
 =?utf-8?B?bVdwYkRoNVBkVHdQS1ZtUkMvYlhpZksyaWlTdmc1bVBOVTF4UGw2TjMvQzhu?=
 =?utf-8?B?elFxWW9hL28rYys3b0gzNzBxL29iK09nZFh6TXdyc0s5YjZTTytTYlZNUGZB?=
 =?utf-8?B?V3hmaHl4NEpjc2JMTU9WUnVRbkFGNzFMbzg3OUord2NFTVVTa3pDUmtIUkRS?=
 =?utf-8?B?Y0RYaUJFWEwwMDZnTmY3d1o3Z3VlSFBaQ1luVmVnS0tvUHArVjhqejdwUjlN?=
 =?utf-8?Q?LP48=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf50e55-f6f3-49c1-3411-08da7c32df2d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:18:36.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o02ihr/6wRQDce5uZz/PSdUOBTYJTbwjsJAmb24/87PaW7H0lgzlbDEvhNmlIGvQHhVfa3pZHjxujmYHa4Gj4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4627
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>>> This is the v7 of this series which tries to implement the 
>>>>>> fd-based KVM
>>>>>> guest private memory. The patches are based on latest kvm/queue 
>>>>>> branch
>>>>>> commit:
>>>>>>
>>>>>>     b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
>>>>>> split_desc_cache only by default capacity
>>>>>>
>>>>>> Introduction
>>>>>> ------------
>>>>>> In general this patch series introduce fd-based memslot which 
>>>>>> provides
>>>>>> guest memory through memory file descriptor fd[offset,size] 
>>>>>> instead of
>>>>>> hva/size. The fd can be created from a supported memory filesystem
>>>>>> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
>>>>>> and the the memory backing store exchange callbacks when such memslot
>>>>>> gets created. At runtime KVM will call into callbacks provided by the
>>>>>> backing store to get the pfn with the fd+offset. Memory backing store
>>>>>> will also call into KVM callbacks when userspace punch hole on the fd
>>>>>> to notify KVM to unmap secondary MMU page table entries.
>>>>>>
>>>>>> Comparing to existing hva-based memslot, this new type of memslot 
>>>>>> allows
>>>>>> guest memory unmapped from host userspace like QEMU and even the 
>>>>>> kernel
>>>>>> itself, therefore reduce attack surface and prevent bugs.
>>>>>>
>>>>>> Based on this fd-based memslot, we can build guest private memory 
>>>>>> that
>>>>>> is going to be used in confidential computing environments such as 
>>>>>> Intel
>>>>>> TDX and AMD SEV. When supported, the memory backing store can provide
>>>>>> more enforcement on the fd and KVM can use a single memslot to 
>>>>>> hold both
>>>>>> the private and shared part of the guest memory.
>>>>>>
>>>>>> mm extension
>>>>>> ---------------------
>>>>>> Introduces new MFD_INACCESSIBLE flag for memfd_create(), the file
>>>>>> created with these flags cannot read(), write() or mmap() etc via 
>>>>>> normal
>>>>>> MMU operations. The file content can only be used with the newly
>>>>>> introduced memfile_notifier extension.
>>>>>>
>>>>>> The memfile_notifier extension provides two sets of callbacks for 
>>>>>> KVM to
>>>>>> interact with the memory backing store:
>>>>>>     - memfile_notifier_ops: callbacks for memory backing store to 
>>>>>> notify
>>>>>>       KVM when memory gets invalidated.
>>>>>>     - backing store callbacks: callbacks for KVM to call into memory
>>>>>>       backing store to request memory pages for guest private memory.
>>>>>>
>>>>>> The memfile_notifier extension also provides APIs for memory backing
>>>>>> store to register/unregister itself and to trigger the notifier 
>>>>>> when the
>>>>>> bookmarked memory gets invalidated.
>>>>>>
>>>>>> The patchset also introduces a new memfd seal F_SEAL_AUTO_ALLOCATE to
>>>>>> prevent double allocation caused by unintentional guest when we only
>>>>>> have a single side of the shared/private memfds effective.
>>>>>>
>>>>>> memslot extension
>>>>>> -----------------
>>>>>> Add the private fd and the fd offset to existing 'shared' memslot so
>>>>>> that both private/shared guest memory can live in one single memslot.
>>>>>> A page in the memslot is either private or shared. Whether a guest 
>>>>>> page
>>>>>> is private or shared is maintained through reusing existing SEV 
>>>>>> ioctls
>>>>>> KVM_MEMORY_ENCRYPT_{UN,}REG_REGION.
>>>>>>
>>>>>> Test
>>>>>> ----
>>>>>> To test the new functionalities of this patch TDX patchset is needed.
>>>>>> Since TDX patchset has not been merged so I did two kinds of test:
>>>>>>
>>>>>> -  Regresion test on kvm/queue (this patchset)
>>>>>>      Most new code are not covered. Code also in below repo:
>>>>>> https://github.com/chao-p/linux/tree/privmem-v7
>>>>>>
>>>>>>
>>>>>>
>>>>>> -  New Funational test on latest TDX code
>>>>>>      The patch is rebased to latest TDX code and tested the new
>>>>>>      funcationalities. See below repos:
>>>>>>      Linux: 
>>>>>> https://github.com/chao-p/linux/tree/privmem-v7-tdx
>>>>>>
>>>>>>
>>>>>>      QEMU: 
>>>>>> https://github.com/chao-p/qemu/tree/privmem-v7
>>>>>>
>>>>>>
>>>>>
>>>>> While debugging an issue with SEV+UPM, found that fallocate() returns
>>>>> an error in QEMU which is not handled (EINTR). With the below handling
>>>>> of EINTR subsequent fallocate() succeeds:
>>>>>
>>>>>
>>>>> diff --git a/backends/hostmem-memfd-private.c 
>>>>> b/backends/hostmem-memfd-private.c
>>>>> index af8fb0c957..e8597ed28d 100644
>>>>> --- a/backends/hostmem-memfd-private.c
>>>>> +++ b/backends/hostmem-memfd-private.c
>>>>> @@ -39,7 +39,7 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend 
>>>>> *backend, Error **errp)
>>>>>        MachineState *machine = MACHINE(qdev_get_machine());
>>>>>        uint32_t ram_flags;
>>>>>        char *name;
>>>>> -    int fd, priv_fd;
>>>>> +    int fd, priv_fd, ret;
>>>>>          if (!backend->size) {
>>>>>            error_setg(errp, "can't create backend with size 0");
>>>>> @@ -65,7 +65,15 @@ 
>>>>> priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error 
>>>>> **errp)
>>>>>                                       backend->size, ram_flags, fd, 
>>>>> 0, errp);
>>>>>        g_free(name);
>>>>>    -    fallocate(priv_fd, 0, 0, backend->size);
>>>>> +again:
>>>>> +    ret = fallocate(priv_fd, 0, 0, backend->size);
>>>>> +    if (ret) {
>>>>> +           perror("Fallocate failed: \n");
>>>>> +           if (errno == EINTR)
>>>>> +                   goto again;
>>>>> +           else
>>>>> +                   exit(1);
>>>>> +    }
>>>>>
>>>>> However, fallocate() preallocates full guest memory before starting 
>>>>> the guest.
>>>>> With this behaviour guest memory is *not* demand pinned. Is there a 
>>>>> way to
>>>>> prevent fallocate() from reserving full guest memory?
>>>>
>>>> Isn't the pinning being handled by the corresponding host memory 
>>>> backend with mmu > notifier and architecture support while doing the 
>>>> memory operations e.g page> migration and swapping/reclaim (not 
>>>> supported currently AFAIU). But yes, we need> to allocate entire 
>>>> guest memory with the new flags MEMFILE_F_{UNMOVABLE, UNRECLAIMABLE 
>>>> etc}.
>>>
>>> That is correct, but the question is when does the memory allocated, 
>>> as these flags are set,
>>> memory is neither moved nor reclaimed. In current scenario, if I 
>>> start a 32GB guest, all 32GB is
>>> allocated.
>>
>> I guess so if guest memory is private by default.
>>
>> Other option would be to allocate memory as shared by default and
>> handle on demand allocation and RMPUPDATE with page state change 
>> event. But still that would be done at guest boot time, IIUC.
> 
> Sorry! Don't want to hijack the other thread so replying here.
> 
> I thought the question is for SEV SNP. For SEV, maybe the hypercall with 
> the page state information can be used to allocate memory as we use it 
> or something like quota based memory allocation (just thinking).

But all this would have considerable performance overhead (if by default 
memory is shared) and used mostly at boot time. So, preallocating memory 
(default memory private) seems better approach for both SEV & SEV SNP 
with later page management (pinning, reclaim) taken care by host memory 
backend & architecture together.

Or maybe later we can think of something like allowing direct page fault 
on host memory access for *SEV* guest as there is no strict requirement 
for memory integrity guarantee and the performance overhead.

Don't know if it is feasible, just sharing my thoughts.

Thanks,
Pankaj

> 
>>
>> Might be missing some details on this. So, better to wait for someone 
>> more familiar to answer.
> 
> Same applies here :)
> 
> Thanks,
> Pankaj
> 
> 

