Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AEB5796CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 11:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbiGSJzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 05:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbiGSJzc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:55:32 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E3365FC;
        Tue, 19 Jul 2022 02:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx9RpAkE5S9DX1SyeP3DBYv521p4lBDT10/CvkVZ+qJJIeUnnQlD72zLHFfPDM852gGTAfhVN+8Ue9JphPF27RRbVKV3uJVWBlVRo6zZZSjz992dR54qHbILmscwZ/8+XaaBK4gnbbpHWPXrNTLIev2fw/AicsV3GcNjTm+Wocn/JUlq/LgqyRh/ekBF92SmmJm7p99bc7hLgLMmsDGF7HOq8+wXAcenYVpUSGsIorWAcli0+aIouHFRJHDfOCwcc7AjDjGbBD4EC6snTX/BcE/G30UHf9he8D0MW6W7dtgulB7UAQNa/YfGO1fBOYROZvajtNl3xf+lZ/0qlVm8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70hmuR1b7NLuxCTwSnix+Ee+8ZrWcZptdWeRZc6YCaA=;
 b=ZQZf6adb3nNeAdZqxTn6W3o06/9d3n37F/JlGcWyBScip4/GgCsj2LvlwStB5MZKsSyK1twlNuqnJTsUpv5rneocEiDuQTq1HVX24emxc3GXhydPzU8/zBq1BrfuqwXKa26l2aVVUnCyM4WecmCG71wQyHchR6A5lag8r7NxnAA5Pop9DFKGw4DD6QULFOvdd+lgK6U+pIeNWMpMbIdzUbgoXlASWFvw3069+cBwUwcx05oyodW5l2LazzmpoC+26IS93y2zJunixShTonvlV6I4EG5VxDX7K8AfHw/1kJyN6mASQa7gY+BDvSG7mu/AC572jO0QHpLi+t0bXaxRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70hmuR1b7NLuxCTwSnix+Ee+8ZrWcZptdWeRZc6YCaA=;
 b=BtJAAhPUzRS5OQ5bsXi8RlPG7CwKZfTNJ5pAt0lYP3+kL+Dw1JtMDv9Cn0+kiqpDqp3A5NITgbGveLnhr79dgpYhqQbVmRu8JPIBuwLJeuWJ8oJyeSae3vcDOIjO+xBThKXcuktSm5zwK4cvqJFml6g5nRZVMPPEsmwCKZm2HJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by SA0PR12MB4381.namprd12.prod.outlook.com
 (2603:10b6:806:70::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 09:55:27 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5438.023; Tue, 19 Jul
 2022 09:55:27 +0000
Message-ID: <de1e15b8-b7e7-d077-eff8-0992bd06e38a@amd.com>
Date:   Tue, 19 Jul 2022 11:55:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 13/14] KVM: Enable and expose KVM_MEM_PRIVATE
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
 <20220706082016.2603916-14-chao.p.peng@linux.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220706082016.2603916-14-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bd929cc-03f5-4b54-7dd4-08da696ccec1
X-MS-TrafficTypeDiagnostic: SA0PR12MB4381:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /HMkfW1GcwHDi7cKT2ZWJBYwORhSPbBjSmLYi/iLf2IlaaMwkN/yTCS1qFNc8vRo+m3R9rE3cAkVVVk9Z+0AOzc38HmGtxjwc2Qc4p1YyC8YZSGyr2trMQ4S4X4K10HBXmZqCqqTkDsxmO79PFBtylS229s67pwzXTQae3QTORkEx/0eRK24JWUBPtcm+76IrZpPq0rk/xfNDvpLghvkCGQZe9Wxvem4l58F/HXFeNNVU6HZORiVvwcF5uwgBLc4jBECnS5YTXe/MNTyjbJoyGw4q2lUQ6p1mjAYI5Np7aftg42NO3JCL18LrCsVpCnBWyks7vw3LC2T3IgTjTeBruFE0XaNUrEPIXQeVfVbJMwlPhAkY89wUhICKg1grDBmPnwBgjEJ4UCK27J5qwpqGoMbhfLfT+YpFhqQ9NL19y1uI40NN0jbKxu/93dAPHuV8OXJchjo8xyq2PXE3Tk1BaimOorwTyV2puV2acfb2P2DvyNkMiD/Yf0WtBcSoC3jubaFxab2xOTWr+OLlBYgVEkf0AOejPWrodkOcnrwoVy0DBTAisL+E1BhKQGfeVlAIcipDqSRWpWAjjjPPCY6DeHlzDq8SkSRyW+RyL/UJP+YPxtLDYCy86ByAWUkc7P9465bRXydK3mkdjKj1RXLrOAEgQNittY4MyUM89otidbrct9QxDpFlY2P0Il7NOMZvSG+g1nvpNX1CeKICaoPC1HKzxLewhSBTvk1gGa7HO1eLYV2whq+J+50D980MIIGFMbrGruWnhEBkgb+bpEFggyv2G48FLUK1hRnN1dcn2/LbDQxRvE8OkbU+8dgPIJKe3PvxQrrDSlYGtLxr3yAVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(54906003)(316002)(36756003)(66556008)(31686004)(66946007)(4326008)(8676002)(66476007)(2906002)(41300700001)(6666004)(186003)(83380400001)(6512007)(7406005)(5660300002)(2616005)(7416002)(6486002)(38100700002)(8936002)(31696002)(86362001)(6506007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dldKZmN2RC8zT29tMEZsZmZiRGhlNVJuVTRuTitEWVlNS1Z3UmQrUDQ3Nk10?=
 =?utf-8?B?T3VSMGZ3OXljMEdJRHhXRjR4dnd6WDRHUU5GK2JXSTdjeHBwVEVpc0k2YkxD?=
 =?utf-8?B?NVZZQU5qK1hjKzJBcmdsZGFLT3dZYjdHTXlzOCtxT053ZUxiQTltUDBVZ2hJ?=
 =?utf-8?B?WjlaYWQ2WjRwblZXbGNjZ1Z4N3Qwayt4TEJOU0tnbE5pM3lLMUtSbFRiMkZO?=
 =?utf-8?B?YmdaeVZXTHo0OVEvSGI2R3pGa3FNMUtFcTZYOWhreXBvcXRaczVzRUFYQTg1?=
 =?utf-8?B?cXJhZjhXMjdtSUJ4bFJxR0FUZ0V2aVZFVHlhZkx4M3p1TEMxTjNRVFY2Y1Fw?=
 =?utf-8?B?OUlBamJ4UDBsVEdQWEZ1NWFadWlrWmxielc5dDVUNE5vZ2x2T1NwcjdyZzdm?=
 =?utf-8?B?SVZMaWJtTUptd09iaExBL1NvdHRYclhxcWYzVlNvVkg4b0lhaHIwUXl2VjlR?=
 =?utf-8?B?T1VxYzBuT3BLSkhYc1lUdGlJc0Q2SkNyaGhWUzVYQmlPTGlOVnQ2Z0VBM2xw?=
 =?utf-8?B?U1ljVno1Z2JzVXViTjVKYU9vUmpKTVdCc3BWOUJMdVQ1M01OMTA3TmFWMjV1?=
 =?utf-8?B?eWZ5YVk5bElmTnRIVHFqRG45WXdiK3VZR0dIbHU4Q2I3RWtyR00rVVR4ZGJ5?=
 =?utf-8?B?enl5d2V1ZHZLS1hYMG01SXhOWnRneGVNWnRnc2xtajF0emYvUnZPT0pNUmRh?=
 =?utf-8?B?UzloMm53Z1EreXJKOThwZ3lGLzBiRzhxVHNZQkE2dWVKMFlvUm5HekdMeTZt?=
 =?utf-8?B?OTMrVjB2Q0pEMXBCRTdqMnd6NHllTVZwbFRxNnpURDVZenlSQjM1dmtEdUV5?=
 =?utf-8?B?RERTVmptQUtWaThCM0tOU1g1dVgrVFBNa3U5UTFhZ3RzL3I1eFZaSlV0bGhK?=
 =?utf-8?B?SHovMnBpYzJib2NMd1d5SG9MWnhnVmg2Z1VFY3ZBdGR0S1M2d1lmU05INDdr?=
 =?utf-8?B?b1ZBMlljU1gyaDBSbGJMbC8vOERxRUtBVFRwK3R2RGp3OStWcEd6ejBTeTkr?=
 =?utf-8?B?VTJtR0w1b1o5Y042WGczaXJHSy9FNzl4aGZlbkZ5eEdDckI3aTRuaVFVZ1JN?=
 =?utf-8?B?T0RRUFd4aHNmMWVWUHFLOGZQTzgxUkY3MU1pY2hOemhZM0tZUmJhSjM3MXJj?=
 =?utf-8?B?V2Vtcms1Y1JqSDBpSWU2RnBaaDlhR1JQWHAvclVDa2VyalVOQm9wTFhXWVU3?=
 =?utf-8?B?WTBxanplWG9EeHI4N0xBNm51QWEra0l4Rk0wYmJpcXRYcFpwZWRJamp4NGZF?=
 =?utf-8?B?TG1rVU0yQm00M2p2ZngxbXRSbHFaV2FIUzkvYkdmRTFuV3lWaFZqS0hvK1ha?=
 =?utf-8?B?aEhVbDRkMGM2cmF2UTladHdISW1FYWpoSlY0d2JlUnl4WWJzblgrejNCTXhQ?=
 =?utf-8?B?TllWVGUyWHlzU21XcFQxUnA2UVR2bkZ5bmt1R0Q3RHZNOHUvZm9pNER3MzdN?=
 =?utf-8?B?N1AxbmpnM1dNVndHaENXazl2SEx4QlhXQ01xRk1JMjRUNTh3bGYrZlhjZk1h?=
 =?utf-8?B?V0NDelRrc2pNZGM4dnB2akNlZXhHbmwxVHQ3aW9QMlpkOU1YbVR5RmxIVUpQ?=
 =?utf-8?B?d01yRXhPeGxMZnFIQkNuOGtpZEIrcFBmMlM2V0pjQUlFRUZFUnVQbkxJdTVp?=
 =?utf-8?B?ZWhiRVAxV1lrN2FFbUtTdmlRWkpOelRXNjZOSm96VTUyYlk4UGkydlV1REZJ?=
 =?utf-8?B?UU1TcFVvRXZZN2VTdGJjMmduYXZMWkJ6Q0ZHSXAxck5NclEyeTNmWXBSUmJX?=
 =?utf-8?B?L2lYYU81d01WZXZ2aEdOOWliaTFLOWMvZ0VlUEZmZytTUUphZk5hWUt4WG85?=
 =?utf-8?B?NHZTSThkQWxPVVRMckthWjA1WHNueUw2WnRVYlN0VGhJeDA2K2xBZ0RIRmVT?=
 =?utf-8?B?T2tXaVJGcFpzUm9uU1pWRk9BYjJHbUpwZXduZGVvY3BwazduU2ZkT1dDVHlL?=
 =?utf-8?B?a2FWa08xQlJITGpwYjM5Tys3cEM0NWxBdVJyZVRRdlIycjRRcXlWeVBPeUxi?=
 =?utf-8?B?djg1N2RoUi9PR0dxNlFVYkNQK0FWQ2RXM3IzQVVzRml5cVVnZ1YwdnRGVmlo?=
 =?utf-8?B?VGxzL2tXZWJ6dGRYc1dQS1huSVdBZHNDSzYyck5NZVVmRE1kZ1llSm9YUkdt?=
 =?utf-8?B?MklqSks2VkVOMGw3Yld1SURkcXZTRDB1NDMvYk00VDRZV1FhLzlSdHpkSGJI?=
 =?utf-8?Q?I1zeQbV+9nPcIqUU5niE94qYCnBZcNz/ENzq1SoKLxN4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd929cc-03f5-4b54-7dd4-08da696ccec1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:55:27.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOIaFtjPSy7IQ1Lv5vvp8ZDHX5hJnliwD9TtquPTxyoyKY2pRmiudDDkheDyWe5gevgC3RyDmEHfHhiFXUtXnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Register private memslot to fd-based memory backing store and handle the
> memfile notifiers to zap the existing mappings.
> 
> Currently the register is happened at memslot creating time and the
> initial support does not include page migration/swap.
> 
> KVM_MEM_PRIVATE is not exposed by default, architecture code can turn
> on it by implementing kvm_arch_private_mem_supported().
> 
> A 'kvm' reference is added in memslot structure since in
> memfile_notifier callbacks we can only obtain a memslot reference while
> kvm is need to do the zapping.
> 
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>   include/linux/kvm_host.h |   1 +
>   virt/kvm/kvm_main.c      | 117 ++++++++++++++++++++++++++++++++++++---
>   2 files changed, 109 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 8f56426aa1e3..4e5a0db68799 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -584,6 +584,7 @@ struct kvm_memory_slot {
>   	struct file *private_file;
>   	loff_t private_offset;
>   	struct memfile_notifier notifier;
> +	struct kvm *kvm;
>   };
>   
>   static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index bb714c2a4b06..d6f7e074cab2 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -941,6 +941,63 @@ static int kvm_vm_ioctl_set_encrypted_region(struct kvm *kvm, unsigned int ioctl
>   
>   	return r;
>   }
> +
> +static void kvm_memfile_notifier_invalidate(struct memfile_notifier *notifier,
> +					    pgoff_t start, pgoff_t end)
> +{
> +	struct kvm_memory_slot *slot = container_of(notifier,
> +						    struct kvm_memory_slot,
> +						    notifier);
> +	unsigned long base_pgoff = slot->private_offset >> PAGE_SHIFT;
> +	gfn_t start_gfn = slot->base_gfn;
> +	gfn_t end_gfn = slot->base_gfn + slot->npages;
> +
> +
> +	if (start > base_pgoff)
> +		start_gfn = slot->base_gfn + start - base_pgoff;
> +
> +	if (end < base_pgoff + slot->npages)
> +		end_gfn = slot->base_gfn + end - base_pgoff;
> +
> +	if (start_gfn >= end_gfn)
> +		return;
> +
> +	kvm_zap_gfn_range(slot->kvm, start_gfn, end_gfn);
> +}
> +
> +static struct memfile_notifier_ops kvm_memfile_notifier_ops = {
> +	.invalidate = kvm_memfile_notifier_invalidate,
> +};
> +
> +#define KVM_MEMFILE_FLAGS (MEMFILE_F_USER_INACCESSIBLE | \
> +			   MEMFILE_F_UNMOVABLE | \
> +			   MEMFILE_F_UNRECLAIMABLE)
> +
> +static inline int kvm_private_mem_register(struct kvm_memory_slot *slot)
> +{
> +	slot->notifier.ops = &kvm_memfile_notifier_ops;
> +	return memfile_register_notifier(slot->private_file, KVM_MEMFILE_FLAGS,
> +					 &slot->notifier);
> +}
> +
> +static inline void kvm_private_mem_unregister(struct kvm_memory_slot *slot)
> +{
> +	memfile_unregister_notifier(&slot->notifier);
> +}
> +
> +#else /* !CONFIG_HAVE_KVM_PRIVATE_MEM */
> +
> +static inline int kvm_private_mem_register(struct kvm_memory_slot *slot)
> +{
> +	WARN_ON_ONCE(1);
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void kvm_private_mem_unregister(struct kvm_memory_slot *slot)
> +{
> +	WARN_ON_ONCE(1);
> +}
> +
>   #endif /* CONFIG_HAVE_KVM_PRIVATE_MEM */
>   
>   #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
> @@ -987,6 +1044,11 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
>   /* This does not remove the slot from struct kvm_memslots data structures */
>   static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
>   {
> +	if (slot->flags & KVM_MEM_PRIVATE) {
> +		kvm_private_mem_unregister(slot);
> +		fput(slot->private_file);
> +	}
> +
>   	kvm_destroy_dirty_bitmap(slot);
>   
>   	kvm_arch_free_memslot(kvm, slot);
> @@ -1548,10 +1610,16 @@ bool __weak kvm_arch_private_mem_supported(struct kvm *kvm)
>   	return false;
>   }
>   
> -static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
> +static int check_memory_region_flags(struct kvm *kvm,
> +				     const struct kvm_user_mem_region *mem)
>   {
>   	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
>   
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +	if (kvm_arch_private_mem_supported(kvm))
> +		valid_flags |= KVM_MEM_PRIVATE;
> +#endif
> +
>   #ifdef __KVM_HAVE_READONLY_MEM
>   	valid_flags |= KVM_MEM_READONLY;
>   #endif
> @@ -1627,6 +1695,12 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
>   {
>   	int r;
>   
> +	if (change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE) {
> +		r = kvm_private_mem_register(new);
> +		if (r)
> +			return r;
> +	}
> +
>   	/*
>   	 * If dirty logging is disabled, nullify the bitmap; the old bitmap
>   	 * will be freed on "commit".  If logging is enabled in both old and
> @@ -1655,6 +1729,9 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
>   	if (r && new && new->dirty_bitmap && (!old || !old->dirty_bitmap))
>   		kvm_destroy_dirty_bitmap(new);
>   
> +	if (r && change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
> +		kvm_private_mem_unregister(new);
> +
>   	return r;
>   }
>   
> @@ -1952,7 +2029,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   	int as_id, id;
>   	int r;
>   
> -	r = check_memory_region_flags(mem);
> +	r = check_memory_region_flags(kvm, mem);
>   	if (r)
>   		return r;
>   
> @@ -1971,6 +2048,10 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
>   			mem->memory_size))
>   		return -EINVAL;
> +	if (mem->flags & KVM_MEM_PRIVATE &&
> +		(mem->private_offset & (PAGE_SIZE - 1) ||
> +		 mem->private_offset > U64_MAX - mem->memory_size))
> +		return -EINVAL;
>   	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
>   		return -EINVAL;
>   	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
> @@ -2009,6 +2090,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   		if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
>   			return -EINVAL;
>   	} else { /* Modify an existing slot. */
> +		/* Private memslots are immutable, they can only be deleted. */
> +		if (mem->flags & KVM_MEM_PRIVATE)
> +			return -EINVAL;
>   		if ((mem->userspace_addr != old->userspace_addr) ||
>   		    (npages != old->npages) ||
>   		    ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
> @@ -2037,10 +2121,27 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   	new->npages = npages;
>   	new->flags = mem->flags;
>   	new->userspace_addr = mem->userspace_addr;
> +	if (mem->flags & KVM_MEM_PRIVATE) {
> +		new->private_file = fget(mem->private_fd);
> +		if (!new->private_file) {
> +			r = -EINVAL;
> +			goto out;
> +		}
> +		new->private_offset = mem->private_offset;
> +	}
> +
> +	new->kvm = kvm;
>   
>   	r = kvm_set_memslot(kvm, old, new, change);
>   	if (r)
> -		kfree(new);
> +		goto out;
> +
> +	return 0;
> +
> +out:
> +	if (new->private_file)
> +		fput(new->private_file);
> +	kfree(new);
>   	return r;
>   }
>   EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
> @@ -4712,12 +4813,10 @@ static long kvm_vm_ioctl(struct file *filp,
>   			(u32 __user *)(argp + offsetof(typeof(mem), flags))))
>   			goto out;
>   
> -		if (flags & KVM_MEM_PRIVATE) {
> -			r = -EINVAL;
> -			goto out;
> -		}
> -
> -		size = sizeof(struct kvm_userspace_memory_region);
> +		if (flags & KVM_MEM_PRIVATE)
> +			size = sizeof(struct kvm_userspace_memory_region_ext);

Not sure if we use kvm_userspace_memory_region_ext or 
kvm_user_mem_region, just for readability.

> +		else
> +			size = sizeof(struct kvm_userspace_memory_region);
>   
>   		if (copy_from_user(&mem, argp, size))
>   			goto out;

