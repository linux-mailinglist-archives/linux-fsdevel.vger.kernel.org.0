Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1F7572C12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 05:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiGMD6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 23:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiGMD6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:58:50 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2062.outbound.protection.outlook.com [40.107.96.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C4A52DEC;
        Tue, 12 Jul 2022 20:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Blw2btE3Uq1gYAQsUYbqXGphPKqG/DzF317aHWUQV9f2MM/301tAMgv81aPSdeiYrolEJskdmceUcy2MjzEMYOlBPA8Rk7i6K0OySFy1/MdmzBcue/dtpq8jcVvfwSbG2zkS1M5tueYTWeuHBNoTfbU+l2StmdqUgGfvPzVqFwVrtxRpxyBYqy+Ey+Y3WwC3IVeGXANvZxykZYQH4xSrqsbMxPWq1+5Gfbcu789G2Cr/yM7g4mAEjpW4E1+ATfjV6nHKpMRpfAbEcFUx6XV80ICpSfGj31Jui8M+h6wxbbtqL4fkNUj8dMJ7Ve+VRJwTSvc324yBSXCFuLDxTfh2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SodFMyVPcJa7FybyUCHay5E2NZFgaCtyB+WY1NDfmp8=;
 b=m8whgu531ia27TWL01bggwzl5Cw8wCtjQ02OBtzJx82nh3lUEMFU5E3FpZeZQgKsOObnbm1Ea8fD8QHEzx8adb6IKaTEcPse6FfqrJOxmHygNdwsTcmZ4aEJBu9q2ISWDq8DETEdsP0owWu9IZX9d5AXpzw9gbbHHE9wOyrFTfaMfbnOaT7JRDn/PIAcW/cDORAxdA4V1L/qvLBpmsRDYeRE46jey73ylp+7aZcVQlmO0X89deDhAI71722ArtRLosDKuzga9m1MNyW0SRPau6yYVJuWOSdb7v3Ados1Z1qaE1ThAuZwAePW5PjbY0vJLxYvY1QOw2ZmDWXUlUHnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SodFMyVPcJa7FybyUCHay5E2NZFgaCtyB+WY1NDfmp8=;
 b=bbbFT6ZBzILw9AXjR4MowTY3jGCYMaA8ymPXyWTMOukATVinTJd1tjdVP/eapg+L0enxMNeraB6hRbV8YqHTK1US9ZgdzFQ/4EtgJo0E/eCwPls6T+FwWYvG+E/VhcgFseS1UeOzvuI2JeAxpHLg0cg6OHe/PXsKLnwWG0Kxdgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by PH7PR12MB5879.namprd12.prod.outlook.com
 (2603:10b6:510:1d7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 03:58:43 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5417.026; Wed, 13 Jul
 2022 03:58:43 +0000
Message-ID: <b1c12a4b-46f7-081b-242f-005a8824aad1@amd.com>
Date:   Wed, 13 Jul 2022 05:58:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To CY4PR1201MB0181.namprd12.prod.outlook.com (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 351355f4-2fee-4698-d3dd-08da6483fa5a
X-MS-TrafficTypeDiagnostic: PH7PR12MB5879:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfLZxEzWCoySGn/NtdlOxwPjn2jH1srbQnAMMtmxOPaMCCwFW6plpklzm3Q6l7Vt9HtoyNb3TNkCqGOEb+btHSFwIToGvyCfoZqbZIQzZdSti73eBj6HjS/fztUgKA9QufDQJN8cZGf4+vHBK+qYNjqEj3pytk2pF/2sgqSOmZdRgIo3nmfFNtd0x0mIS/bvinqxQqssEFJ4Ilngd4I5LR8O1xidSLVJQbL7vrdhfOBxnFP5toyaZz5f72ZPweksTZoe6+mmrKyfjiVvj4oR7D9ERKYpA4tbWnSJdJmHDSw/OlS5Z8/+xRfygo73nRrxEi4eanEaxr3Wegnf4HWGLESC6FWlwRS/Oen1V76I2oKt5K99rKNJu4tBu3c5WMcQhLGy5Ee4LwWZi8Z1fOJeuucRv/vWL9dqYM30Tbtmih8RbNBCV/u4BX4ceD9me6DGHBdwVwvBWuHJdSbsET4Sul+DnfBrfIH+UloCvs2QS0ZynrwHkmbVCiSpTw+fE3FPEYsE7MGNSCJ6FmPrHqcYNNcKjKzSPUxL3hKmbIdrAKSkG708TDA5xbOQ+BJreOlpsT44tov3deqYJuJDm1jQkCluJXVK4wsT8ybBfHahiWsp9RSVScKiHXQK6V/6Igfb/8S5ZKJdqrCz4mm6BrlwhksAe8yy4/70a7Cqyz8qjenZOCmim5utvXZfFxrjESHmbWXVb16mBIuSTFqipzrrn2FoJtjk4L1/d71OinPw6dzvfBMMfYyTIC9rGotp9/KiPWsSMlnZIrFQepLudUUOROzowFhHRUvrENbXUXKzO3wpUtn6WeQsfXeLgRRSgo3LfzowweBSBWIEoDkGKEtBnVNqh7+WRQ3nmGZgeJPLH456jP6nRdZQwsQPymB9Nhb91kPr8uIOwkaegSoXYBd+KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(38100700002)(66556008)(2616005)(83380400001)(8676002)(8936002)(5660300002)(7406005)(4326008)(41300700001)(66946007)(66476007)(7416002)(6486002)(6666004)(6506007)(2906002)(478600001)(54906003)(6512007)(186003)(316002)(26005)(966005)(36756003)(31686004)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWtVM05QSzYzVnZIOUQvNXQzTDUwYU05aDNKc1NBMkdQaStSbHdScWQ2eFhY?=
 =?utf-8?B?ZSsxRTMwR0QxMUpBbFJrUDZXN1lhdmpSN0F6UWZBWWpmR28vUW5wSkthazRz?=
 =?utf-8?B?UFVWUGpoMGtsUG43M2xCR29YN0hKSUpvRzFERXpoQTZHbThXT2FFY1MyVU9V?=
 =?utf-8?B?MXphZUhzTHZVTTUzOWtuQllyaXp1em9qV0RGZEttK1RYMFdaVklMekJEUHRv?=
 =?utf-8?B?QXdzMVNmWHJ0TUNLa2pOQTdDRU5Jd0xvbTRXOHEvcFpObDZIdkZHR2VnSGJW?=
 =?utf-8?B?Z0ozbVdnOVBJaUxlcDh5QnpEdlVENHNFTDJZU1lBMDRUb0licHJaTWM4SFVX?=
 =?utf-8?B?MW9WZWJVNFc0RkJIT0VJNVdzUU5Xb0NUWjU5MTdMSnU0eXUxeTkxRVlWaGRp?=
 =?utf-8?B?bTZVTzQ2dU9MZFM2U2dzZ2QxUDd6b29nbzMwbnRtWDBhelh4UVZXK1hVNE90?=
 =?utf-8?B?Y0kySUQrRGlIWjN6eUppdXpBWm1GYjJSZUFNQmZ3NUZWWVVnSUxnNFNWWk1w?=
 =?utf-8?B?cEpHcEU2VnJXYzJ5SkpMREt2T2JLTVpmcnNBbG90YXNvVXp3V2MreTRmRXVi?=
 =?utf-8?B?YXgrVVA0YVg1SGd3UVloY3RvR1IzL21WMEp3NnhXSDhxMWhDSGV0Mk5rRHZs?=
 =?utf-8?B?Z3oyMTlDanRZZXo1ODlOa3hMMUZlMk1VYktBalVDTTgrQWc0KzN6akVnN01h?=
 =?utf-8?B?LzlXTzlCM1JhblA2Z2VpZTIwYmV0WXFQcWJqNU5vaGtZdXVkUEN3YXE4S0gy?=
 =?utf-8?B?NkNZUmdhS2JCNllubnhWUUNqc0o5ek8xVWxYY2RyMHRMSm01TDJrSFlRTHhk?=
 =?utf-8?B?Q3RmcGkyY2kzZ0Y2SzVnUmIrYWY4VHFVQldJcEl2dXM0RFF4WE9TelNGbElV?=
 =?utf-8?B?QVRVYmk2L0c1R2V3VUdMZmxGcWZVUVNoYW9PNkdyMmM5KzhwTUpqT1VuTXpY?=
 =?utf-8?B?STRBMU9meFNJbE9tZFo3VVhrcElBT2JqaXpqNjBESkRiL2F0UTJSenk3ak5j?=
 =?utf-8?B?NUx4QjBnMzVtRFlxNDdOMEUwSnFRbVgvbTcxMzNmOUwySGw1VHE1YkZOOGl3?=
 =?utf-8?B?VHBxT05EL0ZqdG1xSThaZjl6d1ZGTms4WXEzNWZYcTJvODQ5VWViY1IzUUZK?=
 =?utf-8?B?SlRnZ3Zpbm5SMThtWWV1cDdpZnFrMTQzckhsWVZhU3oxbFFKeUhwSzR3MVN6?=
 =?utf-8?B?blR6L3dtc29zcXd5bDlWSVVWZ056VHFuRUllRVFqelFHVDlwQ2pjM3piZHVL?=
 =?utf-8?B?UENzbHluazdXZFovMmZFb1dYUlljWlBYQVB2UzN0TCtLUFZmaWdnZFp6cjVu?=
 =?utf-8?B?b1kyb1Z5TWtwYWc4U3BlbDN2K1I5RjdhL05idWhyQS9hTVpmSTcrVytUQ3BC?=
 =?utf-8?B?WHpEWEVEMEhJQWhBUitjL1hjTm1ObUdMM3hGdnNNS01uRTZZSFJzSGRjaXlh?=
 =?utf-8?B?aThuUkNDeTV6THNkSzJFbW9EdHozdjVYc3NaYWpNUGU5REk2dGxQNVNtNHVi?=
 =?utf-8?B?cVgvWWxRNGxhT0FnWDJSSzJIQ3laTlNjWU5aaXI3TGQ5OXNBVXZPdVU5SGpQ?=
 =?utf-8?B?QzczSDJiMFA5RWN4eFJSR2lySWM4a052ODhyOEdXRkFteDZRblRFZWx6ZEhI?=
 =?utf-8?B?YllxN3pNRVNNSjAvanpWcjMwcG1QRUZmWitIMUJoUW1uRHJzTy8xNE8wRWV2?=
 =?utf-8?B?bkEyQ3RCdFcrZGZ2dmFna1dxamVtTTJ3V1ZQR0lCL0ZvczgxbndQa040K29m?=
 =?utf-8?B?azd0ajFRL2xQQ09FeVQ0NzF0STZGQkpMYXd0K0x2SU1wR3FaNTN1Rkg1b2R5?=
 =?utf-8?B?eXNQSEhtbHhtSW1GaVhGbWw0aWU1eFliOVA1R3N5ditiTXBuM2d3cnpMRkE0?=
 =?utf-8?B?SUFtbFpUYyszakhRQVFMSWYycE15QlZ0VExzMlVWdVlPYjREVGpvSDFUYjRG?=
 =?utf-8?B?dUN5U05SMGJOZlllM1hZTlJxWVZ5bk9kcXU4dVp0Ykh0bkQrTlNwdUp4Mkh0?=
 =?utf-8?B?NlQ1NDZvRXJkMlplUXFWZDQvZk9KSklMTkxzaUZWaHRLR05PNkdwdTZueHp4?=
 =?utf-8?B?SzFSR1RhTUx4ZGlKcHVIU3ZDdUJKYVdLS1hRK094MmxRWk45Q0V4TkE5RWM1?=
 =?utf-8?Q?oKPWBuhDG3yWEiGD4blOY1vS5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351355f4-2fee-4698-d3dd-08da6483fa5a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 03:58:43.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrHHhDscFNK+gYKSGF/rI2OXifKOUJBVQ+OcvX9Dk5a05TpsPNjzEaVUWGab7wVXR0Unguc+3RH5EMVsfggSdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> This is the v7 of this series which tries to implement the fd-based KVM
> guest private memory. The patches are based on latest kvm/queue branch
> commit:
> 
>    b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
> split_desc_cache only by default capacity
> 
> Introduction
> ------------
> In general this patch series introduce fd-based memslot which provides
> guest memory through memory file descriptor fd[offset,size] instead of
> hva/size. The fd can be created from a supported memory filesystem
> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM

Thinking a bit, As host side fd on tmpfs or shmem will store memory on 
host page cache instead of mapping pages into userspace address space. 
Can we hit double (un-coordinated) page cache problem with this when 
guest page cache is also used?

Thanks,
Pankaj

> and the the memory backing store exchange callbacks when such memslot
> gets created. At runtime KVM will call into callbacks provided by the
> backing store to get the pfn with the fd+offset. Memory backing store
> will also call into KVM callbacks when userspace punch hole on the fd
> to notify KVM to unmap secondary MMU page table entries.
> 
> Comparing to existing hva-based memslot, this new type of memslot allows
> guest memory unmapped from host userspace like QEMU and even the kernel
> itself, therefore reduce attack surface and prevent bugs.
> 
> Based on this fd-based memslot, we can build guest private memory that
> is going to be used in confidential computing environments such as Intel
> TDX and AMD SEV. When supported, the memory backing store can provide
> more enforcement on the fd and KVM can use a single memslot to hold both
> the private and shared part of the guest memory.
> 
> mm extension
> ---------------------
> Introduces new MFD_INACCESSIBLE flag for memfd_create(), the file
> created with these flags cannot read(), write() or mmap() etc via normal
> MMU operations. The file content can only be used with the newly
> introduced memfile_notifier extension.
> 
> The memfile_notifier extension provides two sets of callbacks for KVM to
> interact with the memory backing store:
>    - memfile_notifier_ops: callbacks for memory backing store to notify
>      KVM when memory gets invalidated.
>    - backing store callbacks: callbacks for KVM to call into memory
>      backing store to request memory pages for guest private memory.
> 
> The memfile_notifier extension also provides APIs for memory backing
> store to register/unregister itself and to trigger the notifier when the
> bookmarked memory gets invalidated.
> 
> The patchset also introduces a new memfd seal F_SEAL_AUTO_ALLOCATE to
> prevent double allocation caused by unintentional guest when we only
> have a single side of the shared/private memfds effective.
> 
> memslot extension
> -----------------
> Add the private fd and the fd offset to existing 'shared' memslot so
> that both private/shared guest memory can live in one single memslot.
> A page in the memslot is either private or shared. Whether a guest page
> is private or shared is maintained through reusing existing SEV ioctls
> KVM_MEMORY_ENCRYPT_{UN,}REG_REGION.
> 
> Test
> ----
> To test the new functionalities of this patch TDX patchset is needed.
> Since TDX patchset has not been merged so I did two kinds of test:
> 
> -  Regresion test on kvm/queue (this patchset)
>     Most new code are not covered. Code also in below repo:
>     https://github.com/chao-p/linux/tree/privmem-v7
> 
> -  New Funational test on latest TDX code
>     The patch is rebased to latest TDX code and tested the new
>     funcationalities. See below repos:
>     Linux: https://github.com/chao-p/linux/tree/privmem-v7-tdx
>     QEMU: https://github.com/chao-p/qemu/tree/privmem-v7
> 
> An example QEMU command line for TDX test:
> -object tdx-guest,id=tdx,debug=off,sept-ve-disable=off \
> -machine confidential-guest-support=tdx \
> -object memory-backend-memfd-private,id=ram1,size=${mem} \
> -machine memory-backend=ram1
> 
> Changelog
> ----------
> v7:
>    - Move the private/shared info from backing store to KVM.
>    - Introduce F_SEAL_AUTO_ALLOCATE to avoid double allocation.
>    - Rework on the sync mechanism between zap/page fault paths.
>    - Addressed other comments in v6.
> v6:
>    - Re-organzied patch for both mm/KVM parts.
>    - Added flags for memfile_notifier so its consumers can state their
>      features and memory backing store can check against these flags.
>    - Put a backing store reference in the memfile_notifier and move pfn_ops
>      into backing store.
>    - Only support boot time backing store register.
>    - Overall KVM part improvement suggested by Sean and some others.
> v5:
>    - Removed userspace visible F_SEAL_INACCESSIBLE, instead using an
>      in-kernel flag (SHM_F_INACCESSIBLE for shmem). Private fd can only
>      be created by MFD_INACCESSIBLE.
>    - Introduced new APIs for backing store to register itself to
>      memfile_notifier instead of direct function call.
>    - Added the accounting and restriction for MFD_INACCESSIBLE memory.
>    - Added KVM API doc for new memslot extensions and man page for the new
>      MFD_INACCESSIBLE flag.
>    - Removed the overlap check for mapping the same file+offset into
>      multiple gfns due to perf consideration, warned in document.
>    - Addressed other comments in v4.
> v4:
>    - Decoupled the callbacks between KVM/mm from memfd and use new
>      name 'memfile_notifier'.
>    - Supported register multiple memslots to the same backing store.
>    - Added per-memslot pfn_ops instead of per-system.
>    - Reworked the invalidation part.
>    - Improved new KVM uAPIs (private memslot extension and memory
>      error) per Sean's suggestions.
>    - Addressed many other minor fixes for comments from v3.
> v3:
>    - Added locking protection when calling
>      invalidate_page_range/fallocate callbacks.
>    - Changed memslot structure to keep use useraddr for shared memory.
>    - Re-organized F_SEAL_INACCESSIBLE and MEMFD_OPS.
>    - Added MFD_INACCESSIBLE flag to force F_SEAL_INACCESSIBLE.
>    - Commit message improvement.
>    - Many small fixes for comments from the last version.
> 
> Links to previous discussions
> -----------------------------
> [1] Original design proposal:
> https://lkml.kernel.org/kvm/20210824005248.200037-1-seanjc@google.com/
> [2] Updated proposal and RFC patch v1:
> https://lkml.kernel.org/linux-fsdevel/20211111141352.26311-1-chao.p.peng@linux.intel.com/
> [3] Patch v5: https://lkml.org/lkml/2022/5/19/861
> 
> Chao Peng (12):
>    mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
>    selftests/memfd: Add tests for F_SEAL_AUTO_ALLOCATE
>    mm: Introduce memfile_notifier
>    mm/memfd: Introduce MFD_INACCESSIBLE flag
>    KVM: Rename KVM_PRIVATE_MEM_SLOTS to KVM_INTERNAL_MEM_SLOTS
>    KVM: Use gfn instead of hva for mmu_notifier_retry
>    KVM: Rename mmu_notifier_*
>    KVM: Extend the memslot to support fd-based private memory
>    KVM: Add KVM_EXIT_MEMORY_FAULT exit
>    KVM: Register/unregister the guest private memory regions
>    KVM: Handle page fault for private memory
>    KVM: Enable and expose KVM_MEM_PRIVATE
> 
> Kirill A. Shutemov (1):
>    mm/shmem: Support memfile_notifier
> 
>   Documentation/virt/kvm/api.rst             |  77 +++++-
>   arch/arm64/kvm/mmu.c                       |   8 +-
>   arch/mips/include/asm/kvm_host.h           |   2 +-
>   arch/mips/kvm/mmu.c                        |  10 +-
>   arch/powerpc/include/asm/kvm_book3s_64.h   |   2 +-
>   arch/powerpc/kvm/book3s_64_mmu_host.c      |   4 +-
>   arch/powerpc/kvm/book3s_64_mmu_hv.c        |   4 +-
>   arch/powerpc/kvm/book3s_64_mmu_radix.c     |   6 +-
>   arch/powerpc/kvm/book3s_hv_nested.c        |   2 +-
>   arch/powerpc/kvm/book3s_hv_rm_mmu.c        |   8 +-
>   arch/powerpc/kvm/e500_mmu_host.c           |   4 +-
>   arch/riscv/kvm/mmu.c                       |   4 +-
>   arch/x86/include/asm/kvm_host.h            |   3 +-
>   arch/x86/kvm/Kconfig                       |   3 +
>   arch/x86/kvm/mmu.h                         |   2 -
>   arch/x86/kvm/mmu/mmu.c                     |  74 +++++-
>   arch/x86/kvm/mmu/mmu_internal.h            |  18 ++
>   arch/x86/kvm/mmu/mmutrace.h                |   1 +
>   arch/x86/kvm/mmu/paging_tmpl.h             |   4 +-
>   arch/x86/kvm/x86.c                         |   2 +-
>   include/linux/kvm_host.h                   | 105 +++++---
>   include/linux/memfile_notifier.h           |  91 +++++++
>   include/linux/shmem_fs.h                   |   2 +
>   include/uapi/linux/fcntl.h                 |   1 +
>   include/uapi/linux/kvm.h                   |  37 +++
>   include/uapi/linux/memfd.h                 |   1 +
>   mm/Kconfig                                 |   4 +
>   mm/Makefile                                |   1 +
>   mm/memfd.c                                 |  18 +-
>   mm/memfile_notifier.c                      | 123 ++++++++++
>   mm/shmem.c                                 | 125 +++++++++-
>   tools/testing/selftests/memfd/memfd_test.c | 166 +++++++++++++
>   virt/kvm/Kconfig                           |   3 +
>   virt/kvm/kvm_main.c                        | 272 ++++++++++++++++++---
>   virt/kvm/pfncache.c                        |  14 +-
>   35 files changed, 1074 insertions(+), 127 deletions(-)
>   create mode 100644 include/linux/memfile_notifier.h
>   create mode 100644 mm/memfile_notifier.c
> 

