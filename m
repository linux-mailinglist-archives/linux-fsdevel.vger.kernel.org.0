Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A6444D8E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 16:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhKKPLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 10:11:45 -0500
Received: from mail-eopbgr00057.outbound.protection.outlook.com ([40.107.0.57]:41441
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233810AbhKKPLo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:11:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGMZD/rpQMSo/uRBoLQr/f9IybLIr6CJNHO1GC4o95YlkVtfcPN3oFQQmZmdaQJ9sXoxE/K/aJPAgcN20666Yh05O27XSEcswtJlXVzDic3Uid9JRfK5QDLcL+obCwcTwqIhxPwAo6Fgvleg8KlSt9RENDoiX/7fNhUMwJBmTiBquYjl8bRIZweB+KkGKJeM+IZh0/6XPQfKa9ee0zwgQQRH+2ZGh4GasU04UAFaoDAmvP0weSEFEJA0JM3IJ+ThPyrJqZNRCfD0lkbH5qJpvJC5b1z4Vrwv5j0TeGmEF8M9vJ+lgj9/S75IFIG7UWzorodJ0oH5Xx4Ni2t5aFQKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2p6fw7DkmvDzLk58d6zYAtWqK2IUtndereM+K6G59E=;
 b=IMLCK47EnyhxlLdB09S2qoUr4toL5BhtYcT37B9GIXKnLYhuEXcvrM2TXjoslyj6QfY7HnqARDlZgfnWUsffeUoF4FgHgwkk0r6/em/edOUWhdUD8Kul8f4t9S6C5jhbzmY7p4dVYfPwP4tid/vZ+5rsA5sS3YhvM+q7nEy1nX3J6rImPvVHWTWqKAOBC3dh+7cn7+q5Ghb+Jm+4r8aDviPp/qfbC4bvztwX1fsqkcDXLzpnmz9F/VM0n2V/y4wYjb4vtprBrB4BUjpgl1lAc3lDDumTZXt7toROvdUTx9IJgsyjS5++oAPkUO074OpJvjywXcCwiFbqh+efG8AnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2p6fw7DkmvDzLk58d6zYAtWqK2IUtndereM+K6G59E=;
 b=Hl49hjHOiCUaA0HeuyFtbV5FQObgMmLlAwAbOYXFFY8dTZ3xDdq3ZtPPZWWkey8odMM1WClQyBnP9ENID0S3cscA/hYjnZ5/MjpWeZ4SqPJkSjphDmazjCJC9FB/S6qn5HQWN3XbSNfeVHoMUew64kDVdw6zjNHvj+8EvY+0Ovg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DB7PR03MB4555.eurprd03.prod.outlook.com (2603:10a6:10:1a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 11 Nov
 2021 15:08:52 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::78b9:c389:1d86:b28e]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::78b9:c389:1d86:b28e%8]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 15:08:52 +0000
Subject: Re: [RFC PATCH 5/6] kvm: x86: add KVM_EXIT_MEMORY_ERROR exit
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
 <20211111141352.26311-6-chao.p.peng@linux.intel.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <f7155c5b-fc87-c1a6-9ee7-06f08a25bdb4@nextfour.com>
Date:   Thu, 11 Nov 2021 17:08:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211111141352.26311-6-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0301CA0002.eurprd03.prod.outlook.com
 (2603:10a6:3:76::12) To DBAPR03MB6630.eurprd03.prod.outlook.com
 (2603:10a6:10:194::6)
MIME-Version: 1.0
Received: from [192.168.1.121] (91.145.109.188) by HE1PR0301CA0002.eurprd03.prod.outlook.com (2603:10a6:3:76::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Thu, 11 Nov 2021 15:08:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa8fdd53-dac8-4ae7-6811-08d9a5252bee
X-MS-TrafficTypeDiagnostic: DB7PR03MB4555:
X-Microsoft-Antispam-PRVS: <DB7PR03MB45558F62B287310B1513CAD583949@DB7PR03MB4555.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Tw0iCr+aDloCh6+NFvOtaLYNlpBxrWczEa1Hvqkgbf499TIHyBzoSS98mK8B2FMV43Cpn1o1wOyCJQ7N8F0W7FwHefsasxaL0NvuUQ7ZlkeJh9izOxeIPZ6xXd6GjRyY2yfCp9e1bJm0+d7Yl+BrtLTMZPlf3Ojtx4X4VNfeoV9F+CYI0wnBKc9Y/It6xJz7e87PZEXl2dEf4qCN/0Mnu2a5jLf1Kf+YXNQVgTweIq9adZjZn3pRYGeaLO5KN5aKGnJw6WFK6+HuUYhW9gK/ki4VEMf+XylnCF0rI6ADoDeHtGsPbM/k4kJ9oD7AWndA2+x/7yhyaRUFiffIm3hCLpZo3nrkWBYLLSUVSvpkVA7cxeG2JFerG3brr0djEK2JuScDSZMi+1DfIizYIk2ypm2w7k/KMv39T4jXwWyCb02s44//VMNwnPvZ6BbLHxCcmETPF2kf97i0Di2LxvDPLMDXtJyfl78hsNLAUttDbNWrLrQaJC7EdxswpiFaYJdEsvv21FkA1Dj3g3FRu4yxfDDX1ppYqT9S5ofxZefx9Ww6xMt7wF3xhc1M4pImQtLQQQosZZM94VvRs39l2akeKc4B2v6EbxyOdV+M3CFG2NYSrHTYfng0HnKw/Ni2yOFENJqiyfxjDTb+oztkCEHGz+PlEx8Cc5BKzFE9eQq3T85gfjczqe6sEZ81JET1UPu0Gg2QJaq2H/51Fc4Yn3RbrCoRSamityRtO2V/EX1Y0azhE2S8ObISoxC+SfCPD7Y/BJRko+74mGBEkbhckjT7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR03MB6630.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39830400003)(396003)(346002)(86362001)(66556008)(66946007)(316002)(956004)(66476007)(8676002)(8936002)(7416002)(508600001)(52116002)(83380400001)(36756003)(31696002)(54906003)(2616005)(38100700002)(16576012)(26005)(186003)(2906002)(38350700002)(5660300002)(6486002)(4326008)(7406005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWRDNFJnL29hSk10N2JNSmxJdXRPWStNRnY5TXBLTlNjbEU5TVJVcVkzUzhr?=
 =?utf-8?B?T3ZrbE96bk1jRFNGeHJBSWlKVzFsNllvdnhBY25XcnZxNEVESnExK3BIVThu?=
 =?utf-8?B?Y0dXQ01SWEJ5Y0xVMnBEY0djdzFjMXFFWmg3U0w0bTlZM2JRbVFFcEVBdlZu?=
 =?utf-8?B?RHpOV3hyRktkY092WGQ1R29QeHFtZHczb2UwVVpJVDRKaHBma2RyNDZjUkhK?=
 =?utf-8?B?ZG45eExCNjkyY3lEWTRCRmJmUlhNY0dDVmFpbHdqbVBOQlpqcmMrRS80SVJX?=
 =?utf-8?B?cTJvMGNURU9tdzcxMW9xaGVZdVovTStUbWUwN0RBRTB4enkxMmpsZUpYVXBR?=
 =?utf-8?B?eDdLNXo2RjNtT1crcmZtN0R5d0E3OEI4b1lhRDFoM3UwdS9NTXZKYWRiVzJt?=
 =?utf-8?B?Uk55MHpmWkh6T0xTSVpDVEtjSWtjVEpsWm1nQmFaV0NDSkRNRCsxRGdCdVBH?=
 =?utf-8?B?eVhjeGhtYi91c3JaTVBzN0FKRk81MGRhQlhzd0I4Slk4RHRUNzVsQ2t6MG1s?=
 =?utf-8?B?VlJXUjYzYklnVTIvTlQ0bVZ6UFRLSUxRME5NS3dPbkpUMWlsTjFvK01QQUVN?=
 =?utf-8?B?KzZrYnlkcmdlMHlja3dIblRXYlRIR3dHMGVydlZldXE3YjRXMWZPN1U3OEl0?=
 =?utf-8?B?WDhoQXZndU1IbjJIeWkveitsdm5Qc3pNMStybko0MGhlMzBmOXJJUmlxSWFw?=
 =?utf-8?B?MFFvd2hEMFFXT2ZrT2swWUpkSTNOS3NFUDRReVB5aFBlZ3RmSjhUZmlTTXN3?=
 =?utf-8?B?dGpwNE8xMnZGS25FZlJBMWtuSTFXdEg0QUxleGNGZFVVV1FFT1RJM1hDd2lG?=
 =?utf-8?B?QWNWSHJmblhRVzRRZjBsSkg2VUhTSzNUVlpZc0pmMmZ3aDJiZEVkNDdzbFdR?=
 =?utf-8?B?a1lJRWJ2YW5mcENrR1VremFXejBtM1BoTFhyWnFKTjFjQ3FrTFQ2WGU1bnEy?=
 =?utf-8?B?eWdiOC91Mm9acndrNzFNUXNkT1RsdGN0VmoxNkRZTnZBcktzekY5dyt3Rmw2?=
 =?utf-8?B?b2pxK3JTWERLMDNLTWp0VE41cVByb29XOVc4NEpNYmVPem50RkRPekJmZW9v?=
 =?utf-8?B?M3VKbkEydWNMbUF6M1VuN1RnVkFnZVp6ck5DWUlSUEFrQko1b1Y1VFpOTE0z?=
 =?utf-8?B?K25Sblh4VTh5aFZ4SU82dVF1VGdHdGtyTm96aDJ5MXh5Tkw1K2N5dGVRV20w?=
 =?utf-8?B?WFlxeElLejg5NzNETkhvbC9nYjh0YkR4TnF6VjJDbGVrd2tGZlVycTRJQ1lK?=
 =?utf-8?B?Q3NYRTVyVmhSdVJhK3NRMHR3NnJ4Vmg0THg5dDlxQjlOQm1zUlhqM2xzV0Ix?=
 =?utf-8?B?UERETjlsMS9QOVRBVVVaREtIRmxJYkdmajFEeUVBMWpKZzZRVkNWOVgzRG81?=
 =?utf-8?B?WkJVMWFyVGZPVUV6QzVmdXB2dytCa2RMdE5zdDVyQ00rVUE0UW8wN3VVWEJQ?=
 =?utf-8?B?R1lEWVg1RFd0U0wzenl1ZUJCMDZqTUJxMDJSUXNialBHVDEzYjMrR3FOSjk1?=
 =?utf-8?B?eE9TTTFqUWxNVXJjaGgzQTUvNHhpenExbEg3dUdSRVcyUTRCNFNRVXBKL0NM?=
 =?utf-8?B?b3NyOURjQjJyajhSeENXYVFOcEhCWnBvS0YyU0NjZzQ5RXdRVGRRWVp5d1lW?=
 =?utf-8?B?SkZDUUwyc0MvWStiaGh6UEZLeFlQUUlWYzFHY1EyajV6Ri9PSWFOM08xckZy?=
 =?utf-8?B?elJEbVQ5ZWkwcTNEUkE3ZnQ3VGdVUzFwd0IyQ25TZ2w4d1A5bE5ISjEvZFdk?=
 =?utf-8?B?MUJlSmxEbGlqdkU1ejNIdFFETnFpRzRQZC90S1pJYS9Zd0oxMTlIMUV5eHFQ?=
 =?utf-8?B?Wm1ZUzZIZ0dXcXJHdHU5ZFhlTVlZQzRXY0RiMmRHc0gwVXFxdTRNQi9iN0ht?=
 =?utf-8?B?dnlISUxrbU1RcTBxYnJzR29vUFp6WnJ0UHFFZytIRk1rYmZVYURvdXIwZGVr?=
 =?utf-8?B?cW80NXdBeENkc2lGWjh5cXVBQ1g5QVlsMWtBS2tWOXhzMW1lWSsrbldPdEQw?=
 =?utf-8?B?eTQzaDNYN0JOc2RFODhmc0cwUC91aHJwVnU2K0hPN092MzRIazJrUTE1dlpP?=
 =?utf-8?B?NSt3SHMrd2xuTE5tNjZ4eU1nSEZ6K1VZaFFmY0xleVhhRjB3ZDZ4ZzNUMWNG?=
 =?utf-8?B?cExjdFRxNG5LdUY2cldxRGswcVNpRzBjcXhkaGVxWmNKYlNsRWwwcUJVcXkw?=
 =?utf-8?B?VXYydFZlMVdBc1JxWnk4ZUVzUUZ5TWNMViswUTFnUklWZkNpV2JOQmxYRmJU?=
 =?utf-8?B?bEt5Q3l0dVRWWXlvTExGY09SNUx3PT0=?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8fdd53-dac8-4ae7-6811-08d9a5252bee
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 15:08:52.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cR7DnEkqbCvUwfVTHP9piMh7t5Mvr9tvardi2QlTkKDMWj2d9kTRu7pXTjIDO0vcU4vxfeAlISYbwwvQAdv46oq4PwZAEPMwHPoOrBnAQWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4555
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11.11.2021 16.13, Chao Peng wrote:
> Currently support to exit to userspace for private/shared memory
> conversion.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>   arch/x86/kvm/mmu/mmu.c   | 20 ++++++++++++++++++++
>   include/uapi/linux/kvm.h | 15 +++++++++++++++
>   2 files changed, 35 insertions(+)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index af5ecf4ef62a..780868888aa8 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3950,6 +3950,17 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
>   
>   	slot = __kvm_vcpu_gfn_to_memslot(vcpu, gfn, private);
>   
> +	/*
> +	 * Exit to userspace to map the requested private/shared memory region
> +	 * if there is no memslot and (a) the access is private or (b) there is
> +	 * an existing private memslot.  Emulated MMIO must be accessed through
> +	 * shared GPAs, thus a memslot miss on a private GPA is always handled
> +	 * as an implicit conversion "request".
> +	 */
> +	if (!slot &&
> +	    (private || __kvm_vcpu_gfn_to_memslot(vcpu, gfn, true)))
> +		goto out_convert;
> +
>   	/* Don't expose aliases for no slot GFNs or private memslots */
>   	if ((cr2_or_gpa & vcpu_gpa_stolen_mask(vcpu)) &&
>   	    !kvm_is_visible_memslot(slot)) {
> @@ -3994,6 +4005,15 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
>   	*pfn = __gfn_to_pfn_memslot(slot, gfn, false, NULL,
>   				    write, writable, hva);
>   	return false;
> +
> +out_convert:
> +	vcpu->run->exit_reason = KVM_EXIT_MEMORY_ERROR;
> +	vcpu->run->mem.type = private ? KVM_EXIT_MEM_MAP_PRIVATE
> +				      : KVM_EXIT_MEM_MAP_SHARE;
> +	vcpu->run->mem.u.map.gpa = cr2_or_gpa;
> +	vcpu->run->mem.u.map.size = PAGE_SIZE;
> +	return true;
> +
>   
I think this does just retry, no exit to user space?




> }
>   
>   static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 8d20caae9180..470c472a9451 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -233,6 +233,18 @@ struct kvm_xen_exit {
>   	} u;
>   };
>   
> +struct kvm_memory_exit {
> +#define KVM_EXIT_MEM_MAP_SHARE          1
> +#define KVM_EXIT_MEM_MAP_PRIVATE        2
> +	__u32 type;
> +	union {
> +		struct {
> +			__u64 gpa;
> +			__u64 size;
> +		} map;
> +	} u;
> +};
> +
>   #define KVM_S390_GET_SKEYS_NONE   1
>   #define KVM_S390_SKEYS_MAX        1048576
>   
> @@ -272,6 +284,7 @@ struct kvm_xen_exit {
>   #define KVM_EXIT_X86_BUS_LOCK     33
>   #define KVM_EXIT_XEN              34
>   #define KVM_EXIT_TDVMCALL         35
> +#define KVM_EXIT_MEMORY_ERROR	  36
>   
>   /* For KVM_EXIT_INTERNAL_ERROR */
>   /* Emulate instruction failed. */
> @@ -455,6 +468,8 @@ struct kvm_run {
>   			__u64 subfunc;
>   			__u64 param[4];
>   		} tdvmcall;
> +		/* KVM_EXIT_MEMORY_ERROR */
> +		struct kvm_memory_exit mem;
>   		/* Fix the size of the union. */
>   		char padding[256];
>   	};

