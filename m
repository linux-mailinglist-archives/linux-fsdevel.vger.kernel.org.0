Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA095760A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiGOLgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jul 2022 07:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiGOLgi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:36:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF945D5B6;
        Fri, 15 Jul 2022 04:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOQIMvXg2MI8rXw37AJQrM3iL9llCKnwD4iHmHGtzb7cdQkWbvCSCmD/I4giSN8oOflZ9f6qYrcLKsFEegewOxY9/y3rbaFAy5gQZ5o10jre5xFXCJAOXeqRBG9dy24XoDnDIpkCRmFt8MOzw5RNxGe1D6xPop3muK/EYb9xqdJs+cG49+MPCZAA8GgNnm5Uf7/0E2Dm8yPTDS1rQqiLfEb1VVkboxAPjIi4z5qGNGNIC8aypDjmf0yMyKpeKL4iYHdKCgLnJGNosoRyTyHDffEcZPkkpdIGyq9gwPuQhTgDCUrPC1PBqmTURgPPsPwz3w9dF5qoSyMXOW2g1B8T3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU4iKLUMltn02bbvHcIsyNpEg7kQtH6JDf34EHA2ZVk=;
 b=kYLjOzi8okcoGIOqoStIRAkVaMYj8G7ez/GtEbaYvVmKk1+jCQIAcY6RWwVciX/NDF3YH9r4sO8bgXIYVO2VnfTHwcsg5aJv0BJYQ0TJb4jW2I40QXFduza+27aHJ3WylZcZCdW4GmIKoUeg7LQkGH8sTUr/4JY3iB4XSZIhAFzPPRST37+YJ56j1WH7ei5A20raO5rF1Wso4lDdCygZkX+RC2WuOpRKYZpkM4PQmmPrYWNzrLnZzl9W+j5moGWjpRuPe4+cU550mdxv9g5zddi/O4e37uQbCkmHMTyIB3aJDx5m5j30ZLeJWblZfkjloEN+Vzh17bkkzuGoCU5QMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU4iKLUMltn02bbvHcIsyNpEg7kQtH6JDf34EHA2ZVk=;
 b=eSFXkilR9EbY+AXGYxMM+N89SQSq99F8G6h+faD1ddcFsLjVO5xxT8UhpQW7DAGf9kr0pvuc8pPbLuxY72Q719Jz2VL6hDjpqsRycgLIaxftwG8+lOoGv8fWE06Zn8oms3+j8vIJH9Mh9VXMJ1oh/fvGwf4mOQaOtdmh0cv+ooc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by BYAPR12MB3640.namprd12.prod.outlook.com
 (2603:10b6:a03:aa::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 11:36:34 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5438.019; Fri, 15 Jul
 2022 11:36:30 +0000
Message-ID: <d480a850-601b-cda2-b671-04d839c98429@amd.com>
Date:   Fri, 15 Jul 2022 13:36:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 07/14] KVM: Use gfn instead of hva for
 mmu_notifier_retry
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
 <20220706082016.2603916-8-chao.p.peng@linux.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220706082016.2603916-8-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::15) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1adc661-638d-4ca9-6a74-08da665642c8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3640:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVKGbbBCOVxKAa7HpHRPRvA1xAhSxEaRLbJCK/4akZYjTw/OpK+4dJZEP141+VmfrnKLtGzn+DRL7iEN/gDDnSzwhi9vwakOMpOu/ptoQbYrU7n+FN4dXc+K8Fy0pIY0PWNDRNR5UZ16Ij0oCd5XMRJXC9LDPpHHZFZALa6yxCRk5pxYx84uqt3xKTVsaq7H8dn03JGyStNlz9tJZ7IxJWm3NKJAfKd1Hous8p5yMGgLsSMls6XmVUAfn3GTG1rag3gOlQp6Fsv3qcSgDESZRlzO3/3QbGryRcfpCuTNuV8RF3WrB2xpw/MafIj7Wl/KjghE8tuo/isJuNLlJdvqNCBTjLmCjNtsUG31H+7oENTTDyplDoBCpObzFu5Des9rYi8/Pg7e55swNCU42exFLm9V/FlcWSWI1snyR6pd4K7/xMmtlEAyrTFgvDQItSFXssoR6CVsyl/Uvc/0ho/KTBJNmmgODrpfJRxgnTnAYf9bpjK+MxSr2vvFrGtRpqmas6qdvjffY+0RdPSy/38O1r/RZo+lSsh97PhCbIuPtv8qhlAqMlUmY2v1u0bXhHmodyUaIobwvlf3jQ8XJubVTP5uiKVS8ujEbPUp5GLaApwzEGvfkcp9ffME8LImhl/VLs636HHCwaaQsUL8hH5jza5/PZupnWft09rQzhiq8zHBlAjmKA9KKEC2cp15IxvJ0PW7fRY82oE+OHgecmMgLvgwa+lijuyNC1oCZ/eacm69ChHB/MEx5Yii7d/ASu1NX1TeK5LvxyCcN1vX16Auul/pO3X5aIbBHckjynxTifA6DHSv9SCSD3i4dkgR/54VMWBTxnydI5unhL0izeY6fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(31696002)(7406005)(478600001)(5660300002)(6512007)(6506007)(6486002)(66476007)(7416002)(66556008)(6666004)(66946007)(26005)(41300700001)(8936002)(4326008)(8676002)(186003)(38100700002)(2616005)(2906002)(31686004)(36756003)(316002)(54906003)(86362001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmdybVBZM2pKOHd6UmEwcWxuV2xjVFlpVWZHNVVmUWdwMkJ4R1FPKzhleEZB?=
 =?utf-8?B?UElUK1pCekRFaXBFU2Q4Ykk3WExxNGt2dFYrWkFVOXhxVmo5Z1dreFRSN1p6?=
 =?utf-8?B?YW8vLzk5TkVtUjdWdjc4bzVQSVh1QXhsSlpaeEc0V1F3TFFRcFlrc3hUdU93?=
 =?utf-8?B?c0pXTzUvOE1JalFLOWZXUVhkSHpYM3FKOTBNRm51MUNqRGVvQUpUcTF2c29p?=
 =?utf-8?B?M2F4eXF1WDRxYlJwL3JSNlloMEI5ZTU1bjVPcElIR0hOYm9DWTVJU25iRnFa?=
 =?utf-8?B?Y2dnYzlZRVZ3OG9Ib0MxQjlZd0Y3bkdLYS9IYmdQQmtqTDByNWFhTFBENlhC?=
 =?utf-8?B?Ymo5MDEzZnE0RU1MSU50N0RRNDhDVHoxZ0VOdmYvTTNnUlFQWUlBR1Z0dlRq?=
 =?utf-8?B?ODdDaEFBRmd0QmhtcjhCQ2VhVUVSemtmZVUxTUFHVTEvM0N0Q3JFY1UyVTZq?=
 =?utf-8?B?MVRyWVZBSk1SQ3liakVmdFVuc2xZTXNuc0lBZFI4WHo0c2NCanRtSG5QNlB2?=
 =?utf-8?B?SHdWVVlxVVNQMXN2ZHV3MUdxSzMyK1FXUGtNOGNPU1JxbWRqcUVyak9ZcDA3?=
 =?utf-8?B?SWZER01qUmxWVEk4YWlML25sd0V0eGViL0JQSkI4VExNUTQwR2JERWdRem1T?=
 =?utf-8?B?TnJZM0k1d0piNzVORUc4M2lwQW8vT3diWnRqNFZSQmwwbUQ3VGttMXpuOEhU?=
 =?utf-8?B?N1ZCNUFmUW1IQjBwU2RiSzdXaGhMeHBlcjlESWxlVm9lb1ZYZUVMOGQwL2g0?=
 =?utf-8?B?TDBUK1pUUjNhVStTcmhOdURQakRRcVpMODNHSWRzUmZzelRHUkFtOVROdGhw?=
 =?utf-8?B?U1hlY0JPUVM5dmJOWWZ0S2dHZk9qNUdFS3REUU5FWWdOQ0NyMk9sSzVKWVVv?=
 =?utf-8?B?dTRzb3Uxem80RGs3S3paNytlaFZ4b2hDSEhuWGdZZE5DY1pZTHNhR3hiZ2JF?=
 =?utf-8?B?VUZLNitFTldFS2dFYS9WZGJBalh0S29qT3ZuTVZoL0laTmxkdlh1dUkrcFIv?=
 =?utf-8?B?d2V4RTF0U1dsOFZLRWdKQWlKa2lKRkQvZ2dpMlVOYW84OGlyUEIyZ3p0YStj?=
 =?utf-8?B?VmJZdDI2b3JKbDdXdzZGRlhJaG0zcWsyNjdNZjVEcnpYZVhrOGNQUEtnQlU5?=
 =?utf-8?B?Rm9HVU5DazZ5L0RFRTMydWVnNVBvbU8vbWdNbWc2U3RJT29kZnNtVmRxQW9a?=
 =?utf-8?B?WEI4MDBVME1HN2wzNmNGWU9USlFpTkxkUEkxL1N6T1NXYWhJMGQ0bUZBWkNi?=
 =?utf-8?B?bEFUcitLUkhrWlZCbG9RQUo0SHVtN0drTzhsSzU4MWN1VFVxd3RGZ1RSSmlV?=
 =?utf-8?B?blFROGdOMXRRbkpFdDd3Zm9sRkpmM0ZSbmtvTTI1WGc3b1BuL3FMTjdZWTVn?=
 =?utf-8?B?MEdKcXN4ZzFLK09jajZNcmZHNWk5bW9mVTJSUGRnNG16QUlOaVJuM293YzRP?=
 =?utf-8?B?M09iNzBycllwQlIxcDJDeGtFbzBLUDE3NkVFUVV3Y212U05ubGpaZndtVUtK?=
 =?utf-8?B?R1lFeVc0djl3bmNGaHNxaWtjQ091UXVRVG95NlIyYWVqWCs2cExXNE1sV0hn?=
 =?utf-8?B?NDhkMVlBeU1BOXdyNWhoLzhjMWUwK3hUOVgzS0p3WEhCRmVrQnp5SGpTQ3FI?=
 =?utf-8?B?alluZTBzaUZLNnBkRzJaa0Y0TUdMbnBVRnM5Ry9hRjZDRVBhS0hESUU4VzNa?=
 =?utf-8?B?Smc3NXBKb3l1MFZ0TGZNSm11YTcrWjhEaFd6ay9Ibk92N2N5Z0lVMlQvenFu?=
 =?utf-8?B?L2ttV1dIdVg5RTRzQkh4ZGQvMlNlRUJPelNNODFKcEZLZWhYWk8vbnhuenNP?=
 =?utf-8?B?WGVLZ1g1MVVnM1ROVVJ1eElBaThWOGh2bmlwNi9WTVhZMktSS1BwRUp0dzFy?=
 =?utf-8?B?WmpNbFI4VFRjdG83WjlBa0gwUXlLRWFOMTFyZy9JZFVwRXRiSzN1UDZtbW05?=
 =?utf-8?B?RnhOZ2NtaFMxQ3VFcDZmNnhJL3FuWnVWNEp1Y3JHVjhta0wxaElTOTFUdUJK?=
 =?utf-8?B?bi9YN2xMRXhNOFpObzBUMzd4WWJIVGRVK3hObU5wVDk4ckpYUlE1MVFnUmlD?=
 =?utf-8?B?L3dtMTZEZmg1UG81OStzOUlRZEQzUDlpN05rSVVwVFJ2cG9jSHhIOFJvdHZH?=
 =?utf-8?Q?zLFesLhWXyR4hhivE2uY7X1do?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1adc661-638d-4ca9-6a74-08da665642c8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 11:36:30.3903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+f1/KruhoMG2zGDJ2cMcjuJcAYMxE0cVRgZWt+0DvK35dsX4wUFe4Oej8RyMfec6ySWtiWX7aqFhMiQCwP2Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3640
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Currently in mmu_notifier validate path, hva range is recorded and then
> checked in the mmu_notifier_retry_hva() from page fault path. However
> for the to be introduced private memory, a page fault may not have a hva

As this patch appeared in v7, just wondering did you see an actual bug 
because of it? And not having corresponding 'hva' occurs only with 
private memory because its not mapped to host userspace?

Thanks,
Pankaj

> associated, checking gfn(gpa) makes more sense. For existing non private
> memory case, gfn is expected to continue to work.
> 
> The patch also fixes a potential bug in kvm_zap_gfn_range() which has
> already been using gfn when calling kvm_inc/dec_notifier_count() in
> current code.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>   arch/x86/kvm/mmu/mmu.c   |  2 +-
>   include/linux/kvm_host.h | 18 ++++++++----------
>   virt/kvm/kvm_main.c      |  6 +++---
>   3 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index f7fa4c31b7c5..0d882fad4bc1 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4182,7 +4182,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
>   		return true;
>   
>   	return fault->slot &&
> -	       mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, fault->hva);
> +	       mmu_notifier_retry_gfn(vcpu->kvm, mmu_seq, fault->gfn);
>   }
>   
>   static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 0bdb6044e316..e9153b54e2a4 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -767,8 +767,8 @@ struct kvm {
>   	struct mmu_notifier mmu_notifier;
>   	unsigned long mmu_notifier_seq;
>   	long mmu_notifier_count;
> -	unsigned long mmu_notifier_range_start;
> -	unsigned long mmu_notifier_range_end;
> +	gfn_t mmu_notifier_range_start;
> +	gfn_t mmu_notifier_range_end;
>   #endif
>   	struct list_head devices;
>   	u64 manual_dirty_log_protect;
> @@ -1362,10 +1362,8 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
>   void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
>   #endif
>   
> -void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
> -				   unsigned long end);
> -void kvm_dec_notifier_count(struct kvm *kvm, unsigned long start,
> -				   unsigned long end);
> +void kvm_inc_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end);
> +void kvm_dec_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end);
>   
>   long kvm_arch_dev_ioctl(struct file *filp,
>   			unsigned int ioctl, unsigned long arg);
> @@ -1923,9 +1921,9 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
>   	return 0;
>   }
>   
> -static inline int mmu_notifier_retry_hva(struct kvm *kvm,
> +static inline int mmu_notifier_retry_gfn(struct kvm *kvm,
>   					 unsigned long mmu_seq,
> -					 unsigned long hva)
> +					 gfn_t gfn)
>   {
>   	lockdep_assert_held(&kvm->mmu_lock);
>   	/*
> @@ -1935,8 +1933,8 @@ static inline int mmu_notifier_retry_hva(struct kvm *kvm,
>   	 * positives, due to shortcuts when handing concurrent invalidations.
>   	 */
>   	if (unlikely(kvm->mmu_notifier_count) &&
> -	    hva >= kvm->mmu_notifier_range_start &&
> -	    hva < kvm->mmu_notifier_range_end)
> +	    gfn >= kvm->mmu_notifier_range_start &&
> +	    gfn < kvm->mmu_notifier_range_end)
>   		return 1;
>   	if (kvm->mmu_notifier_seq != mmu_seq)
>   		return 1;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index da263c370d00..4d7f0e72366f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -536,8 +536,7 @@ static void kvm_mmu_notifier_invalidate_range(struct mmu_notifier *mn,
>   
>   typedef bool (*hva_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
>   
> -typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
> -			     unsigned long end);
> +typedef void (*on_lock_fn_t)(struct kvm *kvm, gfn_t start, gfn_t end);
>   
>   typedef void (*on_unlock_fn_t)(struct kvm *kvm);
>   
> @@ -624,7 +623,8 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
>   				locked = true;
>   				KVM_MMU_LOCK(kvm);
>   				if (!IS_KVM_NULL_FN(range->on_lock))
> -					range->on_lock(kvm, range->start, range->end);
> +					range->on_lock(kvm, gfn_range.start,
> +							    gfn_range.end);
>   				if (IS_KVM_NULL_FN(range->handler))
>   					break;
>   			}

