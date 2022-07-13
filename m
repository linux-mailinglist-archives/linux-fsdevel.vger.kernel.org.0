Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E7573465
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 12:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiGMKgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 06:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGMKgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:36:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAC2EDB67;
        Wed, 13 Jul 2022 03:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZk6du3pDuP8eb4YE5IaLPedMTcKeG3wNC/O1qGPmRq3sU4xItirNWDr6P3ZBwKKLSmYv6pxTKfQWw9G9OaxfuvUrv0Ni4ZxzhaXSDi8sUvuojf5qnHT9yxbmrhLVesrsDHsO7TvexgvH1wUfiga0iUGwpifblcTMH99KzFUq2/fY5CQ+uVggNqV9+D0z6TbMp3a7XP6Z0iUW1bNT1JGQq4DXwb54UuNjeJ+8KN1GTJYAvAHDcQ8IaoFv9X2U9adij/WNBYeKwLhdlwfr7vuWRQIouA+IEtfuWeCwsk/mXP8LbQhF5pf4+yDrIHVlDNMx4k+NtTKV9NsBBjhGf/TQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIMnWCP9hUPDix736g2y6bEJLIcVTXZxzkPSuAU2n0U=;
 b=d4pB0rBjfmBnB/kNg1/WKGtJ4KWkMorR8IK4PJY9O3hXH6lykmULTQyvfRUmq64dpVtk9x5Rn/BqQOqf3WNCTadTxFFCAFCgRo01lpMGVTmU0YuhrwJ3f9jtTRXLDIaB8JTbmyn64Dnqo5+fXWnccI/FEmVrb+xAywa2/WdLH8ekZMwunL3UK/0jC7o+BZw/OHEZhOVxfaESnIQjz8ITSkuFGRY1V9S27wQkT+lQztGh/xTkGXvV4gTbpO9gAkkuE/AeSgK7rI9/rtqEwBdoCJ2WOYbdunrzKZOii/UIsJAUYcJfERMbf+RyfYNKzcODssnHyQff6jv7r+Z84dHNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIMnWCP9hUPDix736g2y6bEJLIcVTXZxzkPSuAU2n0U=;
 b=ig4cSmBHN6MfLsJ/FQLnV2d+ZuzqHHWlcRyps36nNFl3+e3dDA/HlI0V9OZFlpgZ7B+fm7cCcj/u2Lj05VYRGQ9lIipj4D7j+08CaD3cykJEJhuDVMJ6ZtMkyuV4k1gaPV1Ne1ia1L+5W7WjdnU+WkimNV2JBZ4cMoxlzfxE1ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by CH2PR12MB4215.namprd12.prod.outlook.com
 (2603:10b6:610:ab::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 10:36:13 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5417.026; Wed, 13 Jul
 2022 10:36:13 +0000
Message-ID: <13d25d2e-ff79-5762-ddb8-87df56f5cbcf@amd.com>
Date:   Wed, 13 Jul 2022 12:35:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b1c12a4b-46f7-081b-242f-005a8824aad1@amd.com>
 <20220713075738.GC2831541@chaop.bj.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220713075738.GC2831541@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::16) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75961db9-8cb0-44ea-3a86-08da64bb819e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4215:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pto6FnxizdZN0zQfy3S4y2OXuQWc6x6e3/rLXYM4/vXtRAMhxXOiI2//UEWr6s4SANcKp0w/hipiERg3luLyDseUFef4vNAbeGtxvrcZPPl+ugeRNnBI2JCDl64ooa1V4eotGDHMmnfxBcUP3hdshXtRsv+tSlqi6eOJ1OvmkCzSLlHyZwQza8EQS0srK/LDYF5vv76tOCIlpESOf/0YdpPErThUw4Q3UrUSC2apyiQxTO9SZQDgkGUKR9iXGlpfLHp5xNTLZ3zy/ElFCBU0dptWHPT3B7hYjmLhSmXh+swcxCLuxZoNo3b21ZKk9WV8Tmu14l1IGksV0MdxBSMzo1xvht/1H0g3Wn7GSYutxM4MWU9JXW4d4H94R6f9jks4Hqcn3v3LqEqm7g9pKrHCdx67a3+CLD5y/2ruyoAAzgy9EqeQzQlNUkubGzKGTLqKU1pMAgBRAJDC4mML28xswb6ciS6o3EVm2d9riSfm5OkuVHWxcmDwsNKv50t2N/mfSr8WGTgjiPP1ra2KkbU+tDc2Th09UOPu5FFhNqjk7/wxMOVzo3e1S6SKZBBSG7ZR6y+vATJF7Q4B6ZRwhqm5fKwKfBWCJgCDfyaLEfgOovQf8/JBJ3GJveryxVxGJ/IffIEPAfBUYRk3MUDASZPcQ6gE7UufyK2e+cxslNcKL0hc24WAhBXEwCOdrB94OBT2F6LCQdgNYtVH89oBpHnnOXdk82WqLoDteO2DKNgf13auHJUoxSCObe6Vz8ozvRqvVUqKTuVZiyFZ/ei6v7E7FVep0LE2oSpsyIECqLu7+Aupb6QjdVYjecg+oPYxxYZkWk3spT6NJ20c6qnMwx0cfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(2616005)(31686004)(7406005)(38100700002)(5660300002)(8936002)(7416002)(2906002)(4326008)(66946007)(6916009)(478600001)(41300700001)(6666004)(66556008)(6506007)(54906003)(6486002)(86362001)(36756003)(31696002)(316002)(186003)(66476007)(26005)(6512007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2tybGJJQnA4bzlqaU42bkM4bSsvTitQVGI4QVNZUTZ1Q1k2azZ1dENnZllJ?=
 =?utf-8?B?VXo3ZGtKT1FxQk9lS3pYSmV5czkxbVJQM1FsZjdUSHQ4b2g1V3ExNkZwYjY3?=
 =?utf-8?B?QndIY1VnWVJHbjNjdkQ3NWdEQTBJVWlGZVNERFdLSCtCNnc2QVhaY0FXcysx?=
 =?utf-8?B?S21WekZ1OGM4M2ExdjJYSzdudHNPYlVsRFk3bWZEZUxxZ1RZdG9wbnBEdFVn?=
 =?utf-8?B?bnNCYVBTQ1ZwckN1RWlTSHhRd0EvZGwwTit4RmFLbXBkTEMrYjBYUm1RanBQ?=
 =?utf-8?B?TDN2UFZtajFMaWhmYjljZC9JemtxVURCZ1F6VzZaL29JbU1mKzcvQVZtbW1O?=
 =?utf-8?B?aUIxclR3SG1oZFBYSnhFL1VEVXlUMEU0eExHVEw1RUorcmlWRGJpdk81dzZE?=
 =?utf-8?B?dVdRV3RsM3pmcERGRmt2MVFLT21XQzNXMm4zVSs1Y3QrZHNOME5IZ1Z3MWJ2?=
 =?utf-8?B?UUZDVElxcnM5dE8rRmliZGUzUUlNOGNzWmdMNFhwQXFudGdwNTFLL3pDZ1dm?=
 =?utf-8?B?eVk0cUYraFVJV3VQMVNKUkE1Vys3R1dqRk94QTB2Vk92aC8vS3RHWDdYQ2lU?=
 =?utf-8?B?NUpGQVB3RnNOVWZYN2FjT09Ha1p1MVJ1QTlURkl3WlUvY1RkU3A1ZWY0YnF4?=
 =?utf-8?B?cXNlRDMrck5WSHoxQmVPZ3FIbHVubURZcUl6SlM4aHloc282QUUyUlptZFFw?=
 =?utf-8?B?bVFLSjVVTHFJeGc5YzV6SUV1ZlVqdUFkM24xckJhSG1HekoweXJ1VTJmRU05?=
 =?utf-8?B?emg1M1U3alZBVFhYQzJ2cHpTOHE3UlQ0R2tzOVVZM1AwcDBqeGdJRm1JZzVv?=
 =?utf-8?B?TzhPNzVjNDRlZFVDa2pqQVUyYnFwNGJVSkQ4RitDQVhtaTJNcEQ4ODhEa0Vp?=
 =?utf-8?B?NzBKRGFJY2c1R09WOVpKYWQzL25zcTZIM2lkYTFleVBYR3BVRi94SUlCU0ZV?=
 =?utf-8?B?UDg3eWpMbkJHVzEyOFB3bmNTSUtCcjR4NUdUdkQxRDhqZjAwTVJJZXFhNUwr?=
 =?utf-8?B?aEZzR0JHWFc4clpTNW9ZKzRTQnVGVWprQ0Mra2VnMkI1blJabWdwbG1UeFd5?=
 =?utf-8?B?Zm55S2hkM2xhaUJxVFUyenhNbjArb2h0VFVHT0NraHRKZjJLaitiell0QXNQ?=
 =?utf-8?B?M1lSMXliSlRFeEtZbU1xWDlSTEUwaW04WU1OMHl5eW5YbXp0bXRDMUdTaFRK?=
 =?utf-8?B?ZjQ5dnExdERHYk5aa2tHZ3BqenZ3a2d6dzBva3lTRi9aeURJT2tqQjRJWVNF?=
 =?utf-8?B?TzlZL0ZvcVl4RlpCQ2ZBRGtUc0J5TVBmQXlyQWlvLy8ySDhoSkwrRXc1am0x?=
 =?utf-8?B?VVVsVDk2a25uMzNTVnI1NzdFU1UwcTJ5bjNEd1dXL2lIUWJnUnlkY1l1UHdS?=
 =?utf-8?B?QWpxTHMyVU00V3lmZHkxR254dWdwVzlFU09OQWduSHNEYWoxNWt1THZtdUxp?=
 =?utf-8?B?TW1YQ2FTQlBkdDJCemRNQkRaRkIzNGFqbmtsRmE4VTFuWmc0elcxSzh6SFc0?=
 =?utf-8?B?QWhiMVRpemM2SmFNbzQ1QnpCRTdCRFhsUFhFYmI0V2ZKa3Q4bHdkWnBERGdy?=
 =?utf-8?B?NTlsS3dMRXFEVTBGdnZock5sVmxBNzdaTEp5S2Faby96KzNIV2tOdCtQYnYv?=
 =?utf-8?B?SWk4bzIvVUFtVlhOck4raElWdzNsb2VURVJiQXhadi85TmE4eFdGU0llYUZM?=
 =?utf-8?B?cGZCV3NoR0NRNzVReEtrbEROeUxKMkF3dzNmWXc3dkk2dStQOXRwZStLQ2lY?=
 =?utf-8?B?bURrUjF1VmhSaEp5UXNjVzJEbVVaejBJTXZ1Z2JaUktUczl4N1M0RFVWdHA0?=
 =?utf-8?B?cFFRTGk2dS9Mb3NPeUE4WXVydVZONnY3cmVvMXNlbTdmYythaXBpU1hKVzZz?=
 =?utf-8?B?NWFneTBFdmlCYmxkNWFIbnhxcXRvZlluWUlCaWhTS2ZxYm1uVUxTUG9BbTk4?=
 =?utf-8?B?Q0hTRDY4MDNWV05jK3l3MGhnVi96R0txbnhKOGVFTTNNamFmMzVDODRxMnFJ?=
 =?utf-8?B?a2VKakw2OER2WkU3QlBmVnpOTnc2UTNNZHFVNFE2UVBJcjJJWkNZekJhTTYv?=
 =?utf-8?B?WldJWW9BQklIRjRHMWZCNnI3WnNRdnV1b0E0dHNBWEJ1Y05qOWVsZHkraHpn?=
 =?utf-8?Q?cXcrXRs2GaX1ztBAyCjq/rJay?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75961db9-8cb0-44ea-3a86-08da64bb819e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 10:36:12.6232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ldn4TrdVyo0P6RQ1lHnqEyb23GKXkQLxfIM3Wyroq8WyABTq+sMK0Hdb72+6OJxtvO2V4tNfDWm0BwZO2taYog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> This is the v7 of this series which tries to implement the fd-based KVM
>>> guest private memory. The patches are based on latest kvm/queue branch
>>> commit:
>>>
>>>     b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
>>> split_desc_cache only by default capacity
>>>
>>> Introduction
>>> ------------
>>> In general this patch series introduce fd-based memslot which provides
>>> guest memory through memory file descriptor fd[offset,size] instead of
>>> hva/size. The fd can be created from a supported memory filesystem
>>> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
>>
>> Thinking a bit, As host side fd on tmpfs or shmem will store memory on host
>> page cache instead of mapping pages into userspace address space. Can we hit
>> double (un-coordinated) page cache problem with this when guest page cache
>> is also used?
> 
> This is my understanding: in host it will be indeed in page cache (in
> current shmem implementation) but that's just the way it allocates and
> provides the physical memory for the guest. In guest, guest OS will not
> see this fd (absolutely), it only sees guest memory, on top of which it
> can build its own page cache system for its own file-mapped content but
> that is unrelated to host page cache.

yes. If guest fills its page cache with file backed memory, this at host 
side(on shmem fd backend) will also fill the host page cache fast. This 
can have an impact on performance of guest VM's if host goes to memory 
pressure situation sooner. Or else we end up utilizing way less System 
RAM.

Thanks,
Pankaj


