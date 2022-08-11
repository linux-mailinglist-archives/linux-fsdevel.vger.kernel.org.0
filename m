Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FBC5908DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 01:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiHKXDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 19:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbiHKXDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:03:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8FA6CF4E;
        Thu, 11 Aug 2022 16:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk8fgTA5OH7YX2hTlUvrStKm1NHoHCEy3AePMe5dHzZRuWOMXzUMnx0h95UNkbiX422Q4wtoYmICIqqqVxHeF7oWjnF77QG8PvEtFxz+taGjS6FhugYFEiVCyu6T3P5U6JwFuQK9H4FkGIrHmk5H0s+34Dton05Xj3ZZTAqKstOZ7ztcntx0uSrM2SuJyfrrpiZIPBJtargM5O7sW7lNRzDpS5+tocFvddO+2wFaV5qXcVG9WgSQdiJo2pBgSzm3RiGjOEzaDxPmH7CaqypZCDDxqjcOqesdOTRztMwM/11yYYRVmRxeURwCRXHcicXVb3NTE9KmiyzgmYkv9A9rtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha5P8ivs+Ipv0pAsGDwaPChk0pRJnaDI+qIlhXEl4YM=;
 b=Y6DxnHCZ8/xIj3MCXsMLOoOsDdXpStNjjb1UxXt9fQTz8O7TyDK1YPXuPjEGC4Wiuc7Ro1YPSNWbuudJA0xj3gztPSEPnewWQXdJKqNPKChJVUju27eUhNB09isekhoVluydwYJfK4yN2uNwzt/hV8WRUiFEek/sLgFrC3dN5BQLjx+j0Jyi1d/4ZYm9EJ6QWn0v+Ox09yiovuHV5t7IQnhfsQguXUBvvvUO7zRIAAWPAJSjC+FPDEvsuusOWqJsP8P89lE0aatqUqzMkPKXM0cXQKbzMnUn16t+PnW9gOVcUQ5t2NNDgFTFKDuvMMwsJqPZZ7mdyIah/DD4GNNY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha5P8ivs+Ipv0pAsGDwaPChk0pRJnaDI+qIlhXEl4YM=;
 b=Ba52b51gnhcpEJaOQWrIyKwJ25WXXB2nl0j8g3oUw8pHNG99eD1yxwK8BoiHNCCnuYqetIu+31FOQ4f0TUD6iCqOWKwmcMv7shXS+sTnSTZJ5Ec+MpBOfxAMQTl+3VqDBTj7D1vmzZ17WeYNyz+KwzF3idhMs1yZCUQ2z6LTv9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by SA1PR12MB6800.namprd12.prod.outlook.com
 (2603:10b6:806:25c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 23:03:06 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5504.020; Thu, 11 Aug
 2022 23:03:06 +0000
Message-ID: <422b9f97-fdf5-54bf-6c56-3c45eff5e174@amd.com>
Date:   Fri, 12 Aug 2022 01:02:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
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
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <9dc91ce8-4cb6-37e6-4c25-27a72dc11dd0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 459f5913-13f3-4ed3-e6f8-08da7beda67c
X-MS-TrafficTypeDiagnostic: SA1PR12MB6800:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPAwwIsSuTTf8ora47aFdBXNdiiNTJkJOovsbeL0hqtCKLEb0eY7JmhocaQwqAlW2F7y4WX3baUj8jG4rAgUOYedPttB3bLU1/0kFpPkh+kErYYqw1GGm8Gl1d2pjwQGyFAv+nweCfEyr25nGAehPYTHzd7WGogp0glZYX8Ea9hbUNyOPNTZjGCk0z31BqBdzBmkzVfzRvrueC5w2wyg5GkQJRJaDpgYUrBy3v7HrZSgBFfdqzWz8fJsD30dIGB9HsEsx6R/IjSQ6UdRpsDCxY0KnbFuy18QviF0rlL+mb2WaSnKcCdVkjakkNYljpvJyq3qZbiXabpJkdzXgHTUIWnfaq2mvZ9h/x5f7a5oYjLDnOdH7C3FUqi7ds+vxf43Mrw0yLrywcDL6T1NT055XvvgbUrY/lq3nAFaYTiX/uqN45H/9sqwH3d+mmPYrGdrz+jDEGPx6Qq1iXcb2JHkx/Aes8haQlQUdaD0Ap8LiaoziKZxHxEz0qHFLBVsZ6JQcEJhsqOQEm2rdRyh1OKTmccRO8WLT/CsJaxIPi56wz0x4Z/BYod7wUZO3mcjmMHaGQIS8ccSFxJ7ma7l00ZyPXRho0SB17NSc51FJukNheYkGI9r/upKSD5qogQelcXoCUJJ+HQDpXWdNMgI/v3PUYhHflkDxuri3k3vzj5wmCyyRKBun8+lqUWxyYWfiQouAi3xJyNP2Gcy6a90U1Bn+BjVeApUyrHKzmzle+kBawA++egflCmVVR1TqIcVmhdJ1ScJiIVH00Gu9l4G6TeS87Ts+3VBvrTsQkwYbw3hrkJ88RkdI4tvlrD/oMtsscFuU1qyUaSxjNJByUBmMJIgWMv5D50Kislu6AYkWayh3xGebqP2qeADibNBIt3M1CW/ey1M/KjR6QGADlNoNyCLOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(316002)(478600001)(6486002)(41300700001)(54906003)(4326008)(966005)(2906002)(66476007)(110136005)(8676002)(66556008)(38100700002)(66946007)(7416002)(5660300002)(8936002)(7406005)(31686004)(36756003)(31696002)(86362001)(2616005)(186003)(6506007)(26005)(83380400001)(53546011)(6512007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3hpV1ExVVpDM1ZaTkZ4MWswc21hQk9EdkZMd3JMYzAvTEZGSmR5dXRvYWxE?=
 =?utf-8?B?R01VT2xzYnRiNEswMzJWbEVkWlJBemN1OUZ1d2lUVXA5Tk5VaFB2YTdsdzF1?=
 =?utf-8?B?clhWRkVOVWljQ295U0E2cXYrdEJjVzNnQTdVb3IzclRwbktiYWl5TjhTaHVH?=
 =?utf-8?B?bGkyaGFuUnBiYXlkNlJhQlA5NmloRTZlVWFWaUpTc052NGJtZE5henZGTGtU?=
 =?utf-8?B?WWZuR2loSjRJZU9FOUQyUmZJK3V6TUZEUjJwVm9NaEcrYmtwY090YTQ0dlBE?=
 =?utf-8?B?S0J6U09DaWVrQzlDSVVUNUF4ZHpsSnZmZmFLNVVFbi9jQlBBMTUxd1RjL0s5?=
 =?utf-8?B?UTFrZUR1UjAyT3Z0VlhPQU4ra2VLMWF6L01Yc0lUUTFsVWxrRTVaNUhiNGVr?=
 =?utf-8?B?VkRhSjZjaXVHdHdjZ1JEYUp0dStkeGo0WjFONUJlenMyNXhrSmkzdStBU1Bm?=
 =?utf-8?B?MzUrRWFMaHBEYmRHOWxBbTBGTDFaYmZuZGlVOUg0UnE4NUJPcFZXUnRCbm1S?=
 =?utf-8?B?ei9pc1p4aURRMm1qSkZvaDA2aGxWRVBwNktWRFRia2F1MDFJR1FkMHFpQldp?=
 =?utf-8?B?ZEQ4NVRJYkpqVWNjOFNFVFhIc2tCbGx0djMyNmxxZ3hvUHNyVkQ3Q0hyVkw4?=
 =?utf-8?B?Z0Z6ZHlLRlFCMzNEellOYXBXckY0MzBCczZIRHRBRGg3d2Q4K0FCS2VmUGlJ?=
 =?utf-8?B?ekxzOXp6RjloK3NXcTVzK2lvVncxdDNud2JZYndQNUtzUVIxSHQyM2FydlVQ?=
 =?utf-8?B?eDlBZXZZMDRZQ3ZwbmN3U2FkRzFRcSswSHdKamVwZEpzMnN5TVZDQUxnUkF5?=
 =?utf-8?B?ZEczUHZ6SjRYcFFRL0RDRExKVGZPSTZTNmYxRDRwNjlrYU9tZ1R3VE43UW85?=
 =?utf-8?B?Q1Z5TjJQMFM3L0I2NzFKMnVYL2V6TVAxNUpkSEp5TzVLbS9NMXh6MGlxWGpW?=
 =?utf-8?B?czBJQW5iblpKK2s0RGtoUnFrRmVPZkZ5QmdtK2tQK1V1QzZFNlRUdjErWGtF?=
 =?utf-8?B?ZExIU0h2eHVBT2RPdFk0QnFOMis2c3FNaVV2a25objZuMmZJbFJ5eENRL0cr?=
 =?utf-8?B?SW9jeSt5N2lQeDJlMGcxZFh5b1Zqa3EzNkYwM1psTnEyVmlPTVluYllEZ1Zt?=
 =?utf-8?B?SGYxcnNXVCtwaTZvK3d1TmtPb2pwdWhBVElZZ0F5YmZNMnlmTzhDMzBnV3Er?=
 =?utf-8?B?N0sxOG43OUtmLy9LUXY1cUpNLzRCVkVKOEtWT1NYZERiTGhkcG84Q3R3NWZX?=
 =?utf-8?B?cVNpc2ZnQU4wbC9zZzhUVWI3Z1pIcVhkVStOSU5IR1ZHcFRGT2ZobWY3a0pu?=
 =?utf-8?B?QUpVdzdsVzlUZC81TFZwYTZjRVJmRnBvcFZQa3BzcUlzeVJHQU5UQUdYV1pY?=
 =?utf-8?B?cUNTNXQ4bFM5aTZYUnl0VDZ2Z2x3TTB0Ynk4WUVmSU5OeUlWYzFES3BuSUxU?=
 =?utf-8?B?V1h4TmF0N00wNUw5ZkpadHgrbmc0TWkrK3hrU3FzK1VxbFdXa1IxdW9yTVJr?=
 =?utf-8?B?RXNDZ1pQVXlSMFhPMEI4OXNtYmlEUURXMUxPSUtSa2l0YjZMMmFtMW9mSWdX?=
 =?utf-8?B?RzJScW1nY2c4S3hGb050c245ZXYyb0pCdHpnUzIydlgxeGRUeXo4MS9acTdU?=
 =?utf-8?B?b0d6R0lDYWZBSm5OV1ArM2szTWdEbE9JWFlpQkp2WFRhQU9hMXdrNitrRmdE?=
 =?utf-8?B?ek56bkxnTHRqYVI2dUI1N3JCeGhUTWpVWFNqcUdEYlQyeVVQNlY2blgrdUov?=
 =?utf-8?B?YUgvSkxCZkxzRGhwejJhcTZqY2I2R3o3SEdWcVd3aEVPNmRRNEowVkNHTW45?=
 =?utf-8?B?NTJKbmp4RUdQK0VGZkVGWUM0dGMxdVYvRHhpenFsZFdnbjhaT01nZmVKVjFn?=
 =?utf-8?B?OW0zYzMrem01QmxYdVZ1cnlpUkpyTjF3VWIxTFlTdnpHSlI2TWpoNi8xNkNu?=
 =?utf-8?B?L1R1Qm0vOHlGa1gxTmwwaUtjd3lBVHVxd1N6ZVdEV0gwallmVjBvOEpWT1Mz?=
 =?utf-8?B?UDcrcWVOSFFKdVI3cHB3RUFJU2owY3FjNW9kTTNoT3o3RzAvSTJDaW9GTk9Z?=
 =?utf-8?B?YjJWNnlTbGE5dHpSOXBKcUpDOUZGVnFmekVwUmdUWHNHMU5wL1B5bEVpRGp4?=
 =?utf-8?Q?prNg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459f5913-13f3-4ed3-e6f8-08da7beda67c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 23:03:06.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCUqrzyP/rhx/w+/rjFUzSkuHjtwA00GWL59q9u6LfNXQVOIsB4WDHvASZNeMYVj4F7PGb1zvsEzAeNVj/3Stg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/2022 7:18 PM, Nikunj A. Dadhania wrote:
> On 11/08/22 17:00, Gupta, Pankaj wrote:
>>
>>>> This is the v7 of this series which tries to implement the fd-based KVM
>>>> guest private memory. The patches are based on latest kvm/queue branch
>>>> commit:
>>>>
>>>>     b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
>>>> split_desc_cache only by default capacity
>>>>
>>>> Introduction
>>>> ------------
>>>> In general this patch series introduce fd-based memslot which provides
>>>> guest memory through memory file descriptor fd[offset,size] instead of
>>>> hva/size. The fd can be created from a supported memory filesystem
>>>> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
>>>> and the the memory backing store exchange callbacks when such memslot
>>>> gets created. At runtime KVM will call into callbacks provided by the
>>>> backing store to get the pfn with the fd+offset. Memory backing store
>>>> will also call into KVM callbacks when userspace punch hole on the fd
>>>> to notify KVM to unmap secondary MMU page table entries.
>>>>
>>>> Comparing to existing hva-based memslot, this new type of memslot allows
>>>> guest memory unmapped from host userspace like QEMU and even the kernel
>>>> itself, therefore reduce attack surface and prevent bugs.
>>>>
>>>> Based on this fd-based memslot, we can build guest private memory that
>>>> is going to be used in confidential computing environments such as Intel
>>>> TDX and AMD SEV. When supported, the memory backing store can provide
>>>> more enforcement on the fd and KVM can use a single memslot to hold both
>>>> the private and shared part of the guest memory.
>>>>
>>>> mm extension
>>>> ---------------------
>>>> Introduces new MFD_INACCESSIBLE flag for memfd_create(), the file
>>>> created with these flags cannot read(), write() or mmap() etc via normal
>>>> MMU operations. The file content can only be used with the newly
>>>> introduced memfile_notifier extension.
>>>>
>>>> The memfile_notifier extension provides two sets of callbacks for KVM to
>>>> interact with the memory backing store:
>>>>     - memfile_notifier_ops: callbacks for memory backing store to notify
>>>>       KVM when memory gets invalidated.
>>>>     - backing store callbacks: callbacks for KVM to call into memory
>>>>       backing store to request memory pages for guest private memory.
>>>>
>>>> The memfile_notifier extension also provides APIs for memory backing
>>>> store to register/unregister itself and to trigger the notifier when the
>>>> bookmarked memory gets invalidated.
>>>>
>>>> The patchset also introduces a new memfd seal F_SEAL_AUTO_ALLOCATE to
>>>> prevent double allocation caused by unintentional guest when we only
>>>> have a single side of the shared/private memfds effective.
>>>>
>>>> memslot extension
>>>> -----------------
>>>> Add the private fd and the fd offset to existing 'shared' memslot so
>>>> that both private/shared guest memory can live in one single memslot.
>>>> A page in the memslot is either private or shared. Whether a guest page
>>>> is private or shared is maintained through reusing existing SEV ioctls
>>>> KVM_MEMORY_ENCRYPT_{UN,}REG_REGION.
>>>>
>>>> Test
>>>> ----
>>>> To test the new functionalities of this patch TDX patchset is needed.
>>>> Since TDX patchset has not been merged so I did two kinds of test:
>>>>
>>>> -  Regresion test on kvm/queue (this patchset)
>>>>      Most new code are not covered. Code also in below repo:
>>>>      https://github.com/chao-p/linux/tree/privmem-v7
>>>>
>>>> -  New Funational test on latest TDX code
>>>>      The patch is rebased to latest TDX code and tested the new
>>>>      funcationalities. See below repos:
>>>>      Linux: https://github.com/chao-p/linux/tree/privmem-v7-tdx
>>>>      QEMU: https://github.com/chao-p/qemu/tree/privmem-v7
>>>
>>> While debugging an issue with SEV+UPM, found that fallocate() returns
>>> an error in QEMU which is not handled (EINTR). With the below handling
>>> of EINTR subsequent fallocate() succeeds:
>>>
>>>
>>> diff --git a/backends/hostmem-memfd-private.c b/backends/hostmem-memfd-private.c
>>> index af8fb0c957..e8597ed28d 100644
>>> --- a/backends/hostmem-memfd-private.c
>>> +++ b/backends/hostmem-memfd-private.c
>>> @@ -39,7 +39,7 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>>        MachineState *machine = MACHINE(qdev_get_machine());
>>>        uint32_t ram_flags;
>>>        char *name;
>>> -    int fd, priv_fd;
>>> +    int fd, priv_fd, ret;
>>>          if (!backend->size) {
>>>            error_setg(errp, "can't create backend with size 0");
>>> @@ -65,7 +65,15 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>>                                       backend->size, ram_flags, fd, 0, errp);
>>>        g_free(name);
>>>    -    fallocate(priv_fd, 0, 0, backend->size);
>>> +again:
>>> +    ret = fallocate(priv_fd, 0, 0, backend->size);
>>> +    if (ret) {
>>> +           perror("Fallocate failed: \n");
>>> +           if (errno == EINTR)
>>> +                   goto again;
>>> +           else
>>> +                   exit(1);
>>> +    }
>>>
>>> However, fallocate() preallocates full guest memory before starting the guest.
>>> With this behaviour guest memory is *not* demand pinned. Is there a way to
>>> prevent fallocate() from reserving full guest memory?
>>
>> Isn't the pinning being handled by the corresponding host memory backend with mmu > notifier and architecture support while doing the memory operations e.g page> migration and swapping/reclaim (not supported currently AFAIU). But yes, we need> to allocate entire guest memory with the new flags MEMFILE_F_{UNMOVABLE, UNRECLAIMABLE etc}.
> 
> That is correct, but the question is when does the memory allocated, as these flags are set,
> memory is neither moved nor reclaimed. In current scenario, if I start a 32GB guest, all 32GB is
> allocated.

I guess so if guest memory is private by default.

Other option would be to allocate memory as shared by default and
handle on demand allocation and RMPUPDATE with page state change event. 
But still that would be done at guest boot time, IIUC.

Might be missing some details on this. So, better to wait for someone 
more familiar to answer.

Thanks,
Pankaj

