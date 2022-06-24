Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CACD558F5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 05:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiFXD6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 23:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiFXD6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:58:44 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2072.outbound.protection.outlook.com [40.107.96.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB7C5133F;
        Thu, 23 Jun 2022 20:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBbUfs6By4rccRUBs0bA9J7G6y0UoKUufJr8FQy/l+ai6BwkKqaGt0aORw3CTYVF8QPPonWjzYIaQBRtUBKWhGO5priMnjogkIwOLue3SMn08QvL5/7HEs8mJ1jegok4ZHHdvR0XVD5L55u3ry6sGTwn+Dijk5Su05MkV7gctb6HddyEsasYDleUZYhZ807f6exadOqtr/C/p9XHAH/Gz0QE6eihKQwu+0bg/+dIe6lMYWVlng6XeRp0OjJKTaq2OMnr7x4McZcWMtm4TQEklTKHDaC83nvJD4dSnyZmjud+L7sVuclwXb7q/X0hgC8OQmCiOPinEmiUw0nMyabK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJP4LIUvlKq7FfNkV4ttVe1WcyXFAPYc5bZwrObPNH8=;
 b=BKNbIskb50fh3QyqqUeakl0mASLgNAeJ8CvIdMTQeZKsVroIKey8D3q/3EU0/6IAHiWwTsqe9FKqwXgZM+8jZOL7S/EuO3Adxy2lBSfm5U794eODHHHnii9qromTTc1COmmlanC2drgWxT42ypaUSO0imqFnQL7rm4x+PFlzIcOrfRIqqLR5t1LBWn8zhB/1YlgzjolH3SCd8b6cRP6jPRKIpwWFYGel55EhgDQDKP/nu8X1DdnXl0V+i1JhEKM0OM4ToO9PZBuP7dgo3LmFzOtnsHgIHIWwpz25b8iY7Pj0oF9lnZX49ILAawiXJ9bJaHALct69VcElB9WRQsMg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJP4LIUvlKq7FfNkV4ttVe1WcyXFAPYc5bZwrObPNH8=;
 b=IdNs4r/A0X574XHxGxTAzyRzqT8qk5Hlj6uJNr3pZZUPV3XQeT4h96F2GLt56JLY4AEOMJtikF1ZLuDbI4IMx9BZqKfJZK6P2/jkIN0mp83m0W3D7u8hxhlRR3fLjTzMK1VZeQZ7b497ZpuIEs388E7ALJ6YRr0+B1fbDW37QHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 BN7PR12MB2801.namprd12.prod.outlook.com (2603:10b6:408:2d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.17; Fri, 24 Jun 2022 03:58:41 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::c874:85c6:2343:5b2f]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::c874:85c6:2343:5b2f%6]) with mapi id 15.20.5353.014; Fri, 24 Jun 2022
 03:58:41 +0000
Message-ID: <b3ce0855-0e4b-782a-599c-26590df948dd@amd.com>
Date:   Fri, 24 Jun 2022 09:28:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
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
        Mike Rapoport <rppt@kernel.org>,
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
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 6/8] KVM: Handle page fault for private memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-7-chao.p.peng@linux.intel.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20220519153713.819591-7-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::13) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddcf06f2-70fb-471c-4ce3-08da5595d307
X-MS-TrafficTypeDiagnostic: BN7PR12MB2801:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBcOdEEFIb7sGlGqsvPI1a8XJXk/ZKgAtcx3y512Bm4Qa4tqB7Vah/CAouqBstzZdHD74T97rIcGAEG/figkQgfIphxFVQVMqO6UNaJweuE93CwZFKp7+EZ5zvNL9xh9X2Hq9Tqm5AhfVtzLNJ/7ITCBfOqSMk/lggyjru3MSucCBFD4+RkOxTB/zU0ZAe7oDqRXrIl39jd9gt4uyj3XOPWpeDP4PTBn9ZJ4UZdeD6v8Z7d186ebwvUwnI0SYiC/emvcIuOtLyBnaoy/p9NVSJ1htaPbr55GzTACjgaIR2pmdH4nS6gWQ7wVdMbjWUmQETfeIHigjr10mRlESYxtarOH8+kmII3YWKvv++qCjBZqRcg/zyX8H0MB/HTlkdNZvIPADNh1Szknm7GG8yk9P8LB864arF2q6+1GG2TK7l5csLQ8bXKMnPZgzVP35s/M1/zLlddk8CsHYR0n1v27rLJyFGFuTAFaklL8IVt6F+Dh65FwTt8ubGVJS3FbiaL29ZpeV7WawChWqu0pIPR50jeG0W65QweRsH5w+pB5CByVFPSSWTN1F0wLLLAC2o1NmHBFVn9XAN6D5e1b9OPTp4PqfjARvN9KqWnrtF2/Am3UKAGjVGIZmkr/iHQICmLRdksC8OzDDsHyTckaISREYkeAPWRBAmoqepo6IvuGI6UFTTM8HsZv2TITHFt5azN96BqdxKWiI//5/P5FjaK/Ai1LfRJtFZACZmr922QF9RIAb7U1UeUG+bHvIsJKLM3bt+qGxuX5VW7YcRJoNLwn1PxlC5069UCmoheZ8XAub0IWjpU/5iGjD+2SHJ4ELOpRry4fLBCOsItqh3jSdAuuRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(66946007)(8676002)(7406005)(83380400001)(6666004)(6486002)(4326008)(7416002)(66476007)(66556008)(5660300002)(54906003)(478600001)(8936002)(2906002)(38100700002)(6506007)(2616005)(31686004)(186003)(36756003)(31696002)(53546011)(26005)(6512007)(41300700001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2ZHZDhTcjNHRDVRb0R6SlVZYjh1RjNZNmlXTzZkRDdmcE11ODBZa3Z4TWZG?=
 =?utf-8?B?alhQdSt3TUFKYkI5RjBoWmNFanROOEVzSXZOU0xWdnNDVnVRczJCWk9Wa3ND?=
 =?utf-8?B?VXF0RlFBaC9oR3JCZnVoNjZBWGF2VmZaRnYzbjhXMmNFY1RnUmpFcGhzMGVa?=
 =?utf-8?B?ZUNOVFNVOUdYemVqZ0ticWRkN0svK3VOTVN2QndYN1pCQzVNQ2ROKzdjMlBY?=
 =?utf-8?B?NlNTT3IyRnZWMThMWXVUMmZkVzZ4dmIrcHF1VUVwZi9YbGZOeDdPQUJXcFR4?=
 =?utf-8?B?bmZmNnpmRHdPWWU0enJKYUtaRFFJVFl3OEgwWGN1c3RXRnVGamg3dUxWWDA3?=
 =?utf-8?B?bFd6WmFreFE2NUpVVVI0THpTSHJmdGp6UlZuWXcvOW5ubWRTVHlMbFZzRm40?=
 =?utf-8?B?NnRiY2N6bitaMDBOTVk5L3NuSzdFWGV2SFl1ZFNOd1h1NTFJTkN1WXlVM1Nw?=
 =?utf-8?B?alNBdzJBZ01aajdxemtobXlDWDA4ZTl1OGt5aFBEUkt3amJBWVB5c0IwSWRp?=
 =?utf-8?B?cW1kNjM0UG5vcnNHWnUxTUtYRlVpZGFkNG1uRk92V0xxYWdGUTV0VXlMR0xF?=
 =?utf-8?B?YnpFSldDWDRoRHE4UzFkb1dQeE5FMnJZOVlxYVllOWdqRHY4V2liUUk2SUxC?=
 =?utf-8?B?SFNHMWMrOWQ5dmRsaW4xdS85MTdCTWVjNllFTnJIcUlTV202NGl0TDc4TUh6?=
 =?utf-8?B?REV6M3hveE85MjNXYUFhTXNQajVkZEl1YVVMNGRkODNpSWQybjB6SERVSmFZ?=
 =?utf-8?B?WTNRdXczMXhXSW82WkxmVlRPaVpRTHRPWlZuNXVkNG5pcWMvMVlSZUM4TzNz?=
 =?utf-8?B?OHFJY3RjUlVyYi9jTDlWSGV3cDVjM3BLR1hDR081UmJLT1hmYXBtRFRsMnNK?=
 =?utf-8?B?ODVhRXRSTnJPUnppQ01xNThXR0NGRmUzam1EeHNzMm9vSzhsOStOQ3FlSzVQ?=
 =?utf-8?B?TGpsMTFPM21odEl1R2RrcXRkVll5QWNkK2FsazhHNmlHUXdYMVgrbGdDdE5K?=
 =?utf-8?B?TXpjeXdSZm8wVExjYncxNURUZUhodDROY29rZW1yamNNY256RzBSQWNYQzdH?=
 =?utf-8?B?MnhLMlIybzJpU3NqN1JwYTFNZHBLeEltekwyTkZEN3U5OWxTd1hSUTVSV29u?=
 =?utf-8?B?dFJnRGF2dFVZeXpJaVRuV2ZJb2xjUnV4WEI1TmU1SmlSa29oTDMwRGtKSm9D?=
 =?utf-8?B?cG1TMk15Skw0MC95WFgwNzh5WWp2bkkyTWc0bGNwVXhNaHg5bGNHeTUrbzcv?=
 =?utf-8?B?NzF3SmQ2anlrcUpnWU5WRHRObHFpZ2hIUk1QOXByMkh2VlFtWXVVSU9Vem1U?=
 =?utf-8?B?K0lSU0Q0aUFjbHYyZ2p6SGxMRnpiYXBTWDA0cWhyNVZnUmVPaG9ZMGFOdkVv?=
 =?utf-8?B?RStPNTRDVWZ1Ry9IUjFSYldWTlYxeHBiWEVBcG1FZTQzdXRnQVZJWTNIeW1T?=
 =?utf-8?B?YlFReUNLbHhQZUZTQkU2cFppUVhhQlJ1Q3JXbW5PcHZGMHZkeEVYckRVUzhv?=
 =?utf-8?B?eW12MndHY3JidS9NbDB6YXhkVGZxekZYd1VkMnY0MytySXU1NTgzYUM0a1RF?=
 =?utf-8?B?a3E5SDFlMCtxUm5rRDRWcm0wVW92emVSNFZURWtvMFF5M3Y0M05aakwzR3M4?=
 =?utf-8?B?cWtKWm1WVHVOY1B1WHVlTm15QlJReG1LSzBIMVU2MjNLTGZ3NHJMYTByNjNZ?=
 =?utf-8?B?eG1xMXNiYVcyVDl6WTFjZ2ZYQ2dnSzUvSjVFc20xL3JFZGtXYWNRYUJSU0JB?=
 =?utf-8?B?SkxvVTZpNVdxckYzQ2JaWTVySXVrMy83c0V3UGltYWJXdTRsRmRQRENHckRN?=
 =?utf-8?B?aDR1ZXpDc1h5eFM5a3p2aHZwUEFyOGUxcHgrRmhOWmRkVlNmTjllUzB5L09Z?=
 =?utf-8?B?NlNmMnljY2xLRXlJblorek0yYXN5Z2FucGhsQ2l4b1FDUWxFb1NaU1Bxa0wr?=
 =?utf-8?B?YW5PRXd6YUhJeE1zc1Z3NEIxbm1OeGFYbnQxcDFHYWFEZjFvYkhkVzFxSEZx?=
 =?utf-8?B?eGJqZVpxL1hyNzJHSU50TUYyaytZWThmZW56YVdlYUhKa3VKcitOKzhKZkF0?=
 =?utf-8?B?eDdYclFyR2ZvWHUrMXh1ZU1wVlNJMkpObENVQkl5MTdodkJFMis1ZnlScFE2?=
 =?utf-8?Q?TXzeKmZOuW4YX7pMbuNDyFDJm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcf06f2-70fb-471c-4ce3-08da5595d307
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 03:58:40.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0gAnpk4Id/KcOplibB78PfNNpFv5eIaBcwOSNRYcelKpeeDPvz1ZIbsgk6ZTwE0IR9PJZEsFvY3Jasg1xm1+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2801
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/19/2022 9:07 PM, Chao Peng wrote:
> A page fault can carry the information of whether the access if private
> or not for KVM_MEM_PRIVATE memslot, this can be filled by architecture
> code(like TDX code). To handle page faut for such access, KVM maps the
> page only when this private property matches host's view on this page
> which can be decided by checking whether the corresponding page is
> populated in the private fd or not. A page is considered as private when
> the page is populated in the private fd, otherwise it's shared.
> 
> For a successful match, private pfn is obtained with memfile_notifier
> callbacks from private fd and shared pfn is obtained with existing
> get_user_pages.
> 
> For a failed match, KVM causes a KVM_EXIT_MEMORY_FAULT exit to
> userspace. Userspace then can convert memory between private/shared from
> host's view then retry the access.
> 
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  arch/x86/kvm/mmu.h              |  1 +
>  arch/x86/kvm/mmu/mmu.c          | 70 +++++++++++++++++++++++++++++++--
>  arch/x86/kvm/mmu/mmu_internal.h | 17 ++++++++
>  arch/x86/kvm/mmu/mmutrace.h     |  1 +
>  arch/x86/kvm/mmu/paging_tmpl.h  |  5 ++-
>  include/linux/kvm_host.h        | 22 +++++++++++
>  6 files changed, 112 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 7e258cc94152..c84835762249 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -176,6 +176,7 @@ struct kvm_page_fault {
>  
>  	/* Derived from mmu and global state.  */
>  	const bool is_tdp;
> +	const bool is_private;
>  	const bool nx_huge_page_workaround_enabled;
>  
>  	/*
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index afe18d70ece7..e18460e0d743 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2899,6 +2899,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
>  	if (max_level == PG_LEVEL_4K)
>  		return PG_LEVEL_4K;
>  
> +	if (kvm_slot_is_private(slot))
> +		return max_level;

Can you explain the rationale behind the above change? 
AFAIU, this overrides the transparent_hugepage=never setting for both 
shared and private mappings.

>  	host_level = host_pfn_mapping_level(kvm, gfn, pfn, slot);
>  	return min(host_level, max_level);
>  }

Regards
Nikunj
