Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6827753A495
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 14:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349027AbiFAMMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 08:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344614AbiFAMMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:12:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CAC57992;
        Wed,  1 Jun 2022 05:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7lciPzUql6pkSVnHVCKtt2QS052r6ep/4mB4L965ecXmxJiF2jwdSDI7mDubBIs/kGeUks3XCZDBoAs9ET1sNTmVHS6+QV9NmoN+XvtsGw4L85GyR5al5xxO8lyX0e/nWX88NJ/gmHjfTPxYfxs2r3GC/OpmgmaMo4uUUKUvHrzGHG8zZc4vHd7ZJk4XOz0dDK8cgcC+OXzNVM1QRBiKH2pjeV6pc3HCMxk1q9wcVWwTy6NQ45Skf5b1lXRPH3lR41itcQ1l7LH/myQGTmtvLaQmntliDALmONLT2H0DSIteFPcAFHu0kWc+sVrGM7WyTA48q6ecfPS+iSzwDx/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2hQF5k5SioIo2Wu0oXzRSWkMlr5dOVAvTZlqQmKppY=;
 b=BQsaMaTMb4BGpgQrvzLiKU3frNkw33sd31K2nGoRoaW+EHuLA4juLb1QckJKy+4OEKekOwumWmptffoYwf+mSWhxSZYZ6xosOQB8NE7933eqGH5XD2zSSHFsTIq3XufTuD198nS05Ol5/f8uBc/1GvJEIh8jjP7h7HgjY9xHGUQSj0wJCDK4eY7UL6cOLKnYs80NAmB954iYur8OTUT1jz8ae6g+ZXxjqnyyCmHoECAyQyUmJEoDhi4Vje+EiiD68yxMCM425asPq6FlO74tLVfLU2w3s4oy5mPXa2Et0mTE4onZicQD5Nhv/FlZmcUSAeWfxR4VuCRACFQo26R59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2hQF5k5SioIo2Wu0oXzRSWkMlr5dOVAvTZlqQmKppY=;
 b=MVF7jUrCdve5xVN95lG2MHXJiXRajnZMtcJFtd7/NHRuWLghbehp2IXaaK78YLumpQCe1YaJ2aG0tNVYxIzjl9UA/O+q6yZ5DUDwRAmWJDJfpAKemrmH2vMkzMSSKWj/fo6QKjwM0PrvYP5kqI3nfVwMbe/sTpslEruMPawiTSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by BYAPR12MB4632.namprd12.prod.outlook.com
 (2603:10b6:a03:110::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Wed, 1 Jun
 2022 12:12:03 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad%3]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 12:12:03 +0000
Message-ID: <1f1b17e8-a16d-c029-88e0-01f522cc077a@amd.com>
Date:   Wed, 1 Jun 2022 14:11:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 3/8] mm/memfd: Introduce MFD_INACCESSIBLE flag
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-4-chao.p.peng@linux.intel.com>
 <CAGtprH8EMsPMMoOEzjRu0SMVKT0RqmkLk=n+6uXkBA6-wiRtUA@mail.gmail.com>
 <20220601101747.GA1255243@chaop.bj.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220601101747.GA1255243@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0098.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::39) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c212698-a87c-447c-44c4-08da43c7efdf
X-MS-TrafficTypeDiagnostic: BYAPR12MB4632:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4632D793BC79E2CC40152FD89BDF9@BYAPR12MB4632.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h94SS8upg9ZdoK5cqndiIAKatC3GIcePGRGF0XP3B72Etrt/3SNvyP5zbzRMc0wWFmk0bQauBOW2U3Y28aqz9oCP379+Y3SpNouUnx6m4FNlt78BThtHSMoA3IibvcPWAzHv8qqtHUcNSW/Q6J85fUPYRWrwnVtJmhzZ9pcb3vVIHUAZGj1ERPcDcPc2knhfLGhbIsQXWs0ytOa0hpMlWVfP0G5Q+wEXFdra1kwB1XAXaVLP9J5CmulCP5JKHTaMvMjLA79RlLdNbbUz5i4GGg8wIXEedDHPpESezu5xmakd45zzpaYW5xHE4e3hbk+hqbwxNkE/xjKTYqbTUXX251A4Z5Modbor+2je3TavkE8HshPUoQrce2wZXkW7VAPl6+M8wdYXeAuE+YUqqN7xwBAn1C3yLR1E9070nm3mGtG8bstoAg11LVVN6KBkvOFxj6Y+azRUfQcCluji9dCRusnqqRGa0qEmuymNGmTUtptYIwaMNJ1FboSTEOFnhWsddW+oVpBpMZzGmJRPuI0yw2jebAOG8zz3+3r+fD7ws72J8Z+vUUZudy6QNBoZYvxu8qvVG43ACPPM0gV3Ck6PzahrEHb8rrPEVY87DQ69Onbt3tCIJqVHz8LD9sb61KFEkDiCTQuoy69SiW/D4V0/BLYyEX9rFkPD+rdpMHke6OlpAvnyG5fZ4tpny8SeskrCa5yCpWwWBTFRl0aZ22+nnuzz7S+OhsGFvSFtDTlCBC/zScbldga9y6XAGvzbx6DoEWn+zzNdjs4YPGeOjOqHAhlobxBuF4UkuFdR07bahwNFXgJYPzhJK2Ycb0+zPiRf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2906002)(83380400001)(6486002)(36756003)(45080400002)(54906003)(508600001)(110136005)(31686004)(8676002)(316002)(66556008)(66476007)(4326008)(66946007)(966005)(6666004)(186003)(7416002)(5660300002)(6506007)(7406005)(2616005)(38100700002)(31696002)(8936002)(26005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2J3clBWeURsVzk1RHgzcnl4UEEvV1RKSTJBRnE0aGpZa1FMTkphRmE2a0pT?=
 =?utf-8?B?NDlVUG9vVkhOVVpvcCtyaGxQK1FvdzNKZWVueWJPbU0wdFRTdjk4WXhOcGRy?=
 =?utf-8?B?OUliakMvWFIxams5MkZWQ0JtRGk4YXdhOEZlM2NwRDJLUlE2YzJNdHZHSFMw?=
 =?utf-8?B?YUV1UTlQOVpZRVFGd044VWo4Ujc0V0k1N3VHczlSb2Z4R3JtTDZ4dlBCUGRu?=
 =?utf-8?B?bEZUckdnV21XV05HTklNc1ZtQ0JqdHN3d256OUlPQ2N4UEhmNXpISGVYeW42?=
 =?utf-8?B?SmJESDd5SHk5RjFVKzA1VUlwMjBPL042QXlwbmdFM1ZCY0gwZUliVlRSQXRo?=
 =?utf-8?B?RGhXald1cWxUQmhZNUNKaVhKVHhJQXVXbzdscDBiampUNUZGOVh4ZE9PaHpa?=
 =?utf-8?B?OGpCWHlhVlRMQ3ZSMzYrSDIrSkNhQVdxRDlnblcvc0E1cWNZUklGSEc5M0ZL?=
 =?utf-8?B?cGxSSE1XcU5UbnVSQmlGa1pVQ2NBVXA4MUF2SWM4ZWtoaUh1d0FocXBkdUsr?=
 =?utf-8?B?SEFoK0IzLy9zQmVkUjg2by9xaEdsTEszc3hTYVRuN2pMbVM2MUQ4TjZqWlF4?=
 =?utf-8?B?UzR0RDM2V1V3aDBNYlFOTjBzaTJMRnI5WjVQNk9QZzhyM0VTNlExOHpSdHJW?=
 =?utf-8?B?eDlTZC9udDVWT1NoeXdqRUhXampBaXQ2UVB6d0xueVdiM2FtejRYRnhvREJi?=
 =?utf-8?B?T21pMDYySGJCWkhZQ3RkQ0tWRXhYVU9HbjNIVTNWdmp4SUcrUmgwYmRiSGxT?=
 =?utf-8?B?SWcrSmlrdWFVa3hGQWhheXYveXZ1KzZxUGx4YWw4UFgxaUs3RWNUVlI3QUpO?=
 =?utf-8?B?MHg2WUJHMXdzQ1JRUmc5ZlVENnl3TVR5NjRlUGFsQmZ4bm9PVXZyMjNSM2xr?=
 =?utf-8?B?aHRwZXNCS2dMQ1U4eEFYL0ZkU2lPQTloUXVjOUcyOXFqQ2MzTFhpc1RhSEY4?=
 =?utf-8?B?MHRSZ1FwdkpIN2IyeHJNTzVGUUh3WVNHdit2NEREQUh5K2xGeUp1Q3ozdCs0?=
 =?utf-8?B?THZZeTM3bSs2S2dGSmswN1NMeHhLS2NDSUFUMDZIZTk5NzlGd3NIL2JaOVdw?=
 =?utf-8?B?U2g1c3dCTTJVc2VBbkFYaHgrRlJhTEF0UmVpcHhOQ0g1ZXRQNWIva1FGTjRM?=
 =?utf-8?B?RkQ3VWRBVk1MZjZsN3dQNFVvenM1dktLYlpuWmc4NEJLUTJjZC8ySXJId005?=
 =?utf-8?B?blZKRlZ1NmYvZE1pNHRsVU9yQWp6by9sSk5NU0NnQU13bVBmVE8ydkkvUmtM?=
 =?utf-8?B?VGsxYzJLOEJZZG5nN1J2dTN0bmhFZklHamEzMmkrTlFvMmJDcUdqb3BENzVK?=
 =?utf-8?B?dmZ6V1BYN1c2cDFFR2hxeDFiNzFYNDgwWldzVkFFQWl5ZnBQQmhnTGdhWmN2?=
 =?utf-8?B?ZFZvVjNrME05bHQ2aG1uMXdZUjVoVlorZkhYUTYvMmtqdU4zN3V0V3ExK3Za?=
 =?utf-8?B?VmlsQy8zYXJyOEhudXdGazRKbG1vd0Rsb2I4Q2pXTkRtQWpFcnBmaVVHZGI4?=
 =?utf-8?B?NERnRWsxcUsrK09Fb2pVZUFHaDZ2amw0U2FnZjFJL3R3TUNDV3JSWmRtcTNV?=
 =?utf-8?B?a0lUYWxkQm9NTW9WUkI3bXdPcUpYeUtYQnc0ZUJBbWJ2TlZaaU81Si9rbXFy?=
 =?utf-8?B?YU55MElqZTNLaXNLaklLTWJyTytuYmtIcnFSSDhKbE5abS9iRnk1bG1mZTY5?=
 =?utf-8?B?eHYzTkwwbFBObFlHU0JmbzdoY0hiQXdFdWhKT0lzWjlnK2tiQ0JvYkFqWFor?=
 =?utf-8?B?RU1qNGRzcHU5MzhXS0ZKUGVLZ1llVUQrQXVnN0lYVWlidkY5cFEyTTNqZUNu?=
 =?utf-8?B?Q3pMK0c5dGpOMnVMUDh2elpGcFpZVVo1QklIK0pEV09iM0ltYVhlMk03blFy?=
 =?utf-8?B?Nnd6dDRpdXk1RXN6UkhRaFA0N05TQ0dCeEZxTmNacTI5anNYZkxwNFBYTGRm?=
 =?utf-8?B?V3RYWnpMNVg5ejJPclErY1Fhd3dWYlBxbXhIUE9ybkVhUGxIdUl2SmZqd3dh?=
 =?utf-8?B?UWc4dWNsVUNzMVZTQkJsaU9NOTYxU1gwM2loT3dtVGdZOUcweGdVak52Wm9r?=
 =?utf-8?B?eGIzT2picDV2b3V3bFF3OU95aE9KaXJsN0x6SUN0bVZYdDRNVXBDU21WbnNj?=
 =?utf-8?B?V0J1VnZ4cFVyM21pYWt1MlNYYWg0YUMyVmJaQUxkY2lGRDQ5cndSajcvWEhz?=
 =?utf-8?B?bEZiSVB5cWlkb0ZzYjRUK3J1UkNQWUI5Z24rZlhPY2NBNHJNUy8wQ1YrY0NI?=
 =?utf-8?B?U0hMVnRCUVI1RWFmdmxqOUZMdFJlUmdMZk1qaVp4QVFISS9Jb3UvT0xQenV0?=
 =?utf-8?B?S1I0SVNYdGNmT0ZZTEVibjZ6bUo4c1VKWUwveSsya2xsN1RhenNnUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c212698-a87c-447c-44c4-08da43c7efdf
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 12:12:03.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzcpWe52ln0calTko1iUyhI071ydhemKuWaJUXRTE6uODmjf94t9beMAoF7Oz+wDGN6XMaFdymZXb8Zm1C+32w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4632
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> Introduce a new memfd_create() flag indicating the content of the
>>> created memfd is inaccessible from userspace through ordinary MMU
>>> access (e.g., read/write/mmap). However, the file content can be
>>> accessed via a different mechanism (e.g. KVM MMU) indirectly.
>>>
>>
>> SEV, TDX, pkvm and software-only VMs seem to have usecases to set up
>> initial guest boot memory with the needed blobs.
>> TDX already supports a KVM IOCTL to transfer contents to private
>> memory using the TDX module but rest of the implementations will need
>> to invent
>> a way to do this.
> 
> There are some discussions in https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2022%2F5%2F9%2F1292&amp;data=05%7C01%7Cpankaj.gupta%40amd.com%7Cb81ef334e2dd44c6143308da43b87d17%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637896756895977587%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=oQbM2Hj7GlhJTwnTM%2FPnwsfJlmTL7JR9ULBysAqm6V8%3D&amp;reserved=0
> already. I somehow agree with Sean. TDX is using an dedicated ioctl to
> copy guest boot memory to private fd so the rest can do that similarly.
> The concern is the performance (extra memcpy) but it's trivial since the
> initial guest payload is usually optimized in size.
> 
>>
>> Is there a plan to support a common implementation for either allowing
>> initial write access from userspace to private fd or adding a KVM
>> IOCTL to transfer contents to such a file,
>> as part of this series through future revisions?
> 
> Indeed, adding pre-boot private memory populating on current design
> isn't impossible, but there are still some opens, e.g. how to expose
> private fd to userspace for access, pKVM and CC usages may have
> different requirements. Before that's well-studied I would tend to not
> add that and instead use an ioctl to copy. Whether we need a generic
> ioctl or feature-specific ioctl, I don't have strong opinion here.
> Current TDX uses a feature-specific ioctl so it's not covered in this
> series.

Common function or ioctl to populate preboot private memory actually 
makes sense.

Sorry, did not follow much of TDX code yet, Is it possible to filter out
the current TDX specific ioctl to common function so that it can be used 
by other technologies?

Thanks,
Pankaj

