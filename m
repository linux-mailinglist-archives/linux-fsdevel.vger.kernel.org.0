Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6E757BCF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 19:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiGTRmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 13:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGTRmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:42:05 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6940747BA2;
        Wed, 20 Jul 2022 10:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUPiquQkCbucNL4gfajpOh6SNHyeVQz3odAvP8sQcKK//F1rfNuoKrPM703sWqODRMegv4RY1SvYQUIydIAZMJlrQzyc4nIz1TWI9BRXFtaDvxhEcCD4xNSq25+Y+MxK2KnxbNZSZEFlhOt9sMDW4LDWVWsBbthRwSs/E076U1sEiJOTPugs8HCsp5MEP4yMuAUfcifr7Q3UVO86Ka9DHpq2SOjv4m4uRFiShSGu4PfqCvMNLQY0PRK3C9/AgwZA8PymWNAbaoModNnik6b4nLGB8zYLyTqK9MEZGBB24EY8dWW7NYU66wkrlH+xX90xD2n3hPTOe0ZjNENyuQY0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94ff9HyOu4OR/xGKB4CsY5NOA7rnXp2gzJVjLTy8NHA=;
 b=oLXUX9Y8AI68BHiGyXzh6m3qRihPJpbHeqHRPBEb02V67kzBfxBiWxaSqZOu3lSabdwzOLpih3aPFvq4y/d6JEAAX2BlYAiOGuUO5F+FWdxuYOgFTXAWwXsA4EMt9UIlXWG3BTbEJNWp8Oh8P1akQfRm6XWLOfXw/v3UDWwy7nv2RcE/l/Ucr6l9EfbisCNDQD9vvmzgI0GoPZ+yKRuXLONbN38a/ZcMKzTOOoldF5lBLSqdvS26L9nCALIalV1jlmrFtQVv+PMBloSGb+vR82mzk/yi4tySsLkn4nD6VLT+uL4YtZsFRltOkx3/FV0sWhD+Ij+Ua5Wx3LDvluPTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94ff9HyOu4OR/xGKB4CsY5NOA7rnXp2gzJVjLTy8NHA=;
 b=3LgOVM5fSpfYp4spQMZgYqt5WkwgLlMQNcdqJd7qMFifRBtRplGkGUcmbIjFfrUP8qJu0A1NaA2VGHYKY7fYzzShN+mDw4uVu9/0gwaku71NFPiBkrhW26E3VrwRPSExXOXjKmvcWw12nTEik0s3bG6ud+pRtW3TDPdZXxUgJm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by DS7PR12MB6287.namprd12.prod.outlook.com
 (2603:10b6:8:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.24; Wed, 20 Jul
 2022 17:42:01 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5438.023; Wed, 20 Jul
 2022 17:42:01 +0000
Message-ID: <7bd3719e-c11d-9b52-8ae6-52603fc6a8c2@amd.com>
Date:   Wed, 20 Jul 2022 19:41:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
 <f02baa37-8d34-5d07-a0ae-300ffefc7fee@amd.com>
 <20220719140843.GA84779@chaop.bj.intel.com>
 <36e671d2-6b95-8e4f-c2ac-fee4b2670c6e@amd.com>
 <20220720150706.GB124133@chaop.bj.intel.com>
 <d0fd229d-afa6-c66d-3e55-09ac5877453e@amd.com> <YtgrkXqP/GIi9ujZ@google.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <YtgrkXqP/GIi9ujZ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0002.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::20) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7fe70e3-753c-4597-9b9c-08da6a772688
X-MS-TrafficTypeDiagnostic: DS7PR12MB6287:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0r21OZ+iQvy8C/a/3vh24lpnC1v6X9ovefdtTL1EPSJLau0XrxSPDngnef94P/Fl+5W9Hi1PhXObdk1aaUX/9gE5a1hme/zn4pS3S9TYAjRrYYFUhoewAnyPLXlTXAw9sRGhmidaG6t8iUZoIlcc3D1GtEkNec+BnhCUpoXrP9ZT/O95SXpw7oPIT//B1cOw/xjW2ygosGlQQ9ClJCBpnKm4fR3TwP/BFrrcE2lVlwOI1VbAsJT+kHGbh1U6FjZIl3A4Tehl7F/J3oasrO4RyLfk9r/p0fNeJSLDgUo7bikrcJ2WQnOPyavcIj78IXL4i/i2L2z0u3n+rvnfMRqxv1uG3LjWybkfG7+FAeqCowg5GudbgRAzOEFDT5HJRR4W1g9Mrlz5rM9Smx2gWFWqdFVpJiLimJffojTagmsnbAipMlaOdqnLEawhQpusRHvuqe/DhWkyd0zCol6rjurJ+V508npTtTO8XTXbMScg2QWcWa6tiPwbWTB8ct+pFVsZK08uZkcvJPWlGxkaG0urLtTQ6l9gnuu3L7C+hn/vGXPmkex4ykixucFAJrr5Q2wKW0LoTz2su89AIRBO5tN8VPmN6PPBHoh7r7KkOcbuMP2AbOUjmH8VKClQqYRusvQslSMaizCeAQ7GTDAEc8L+cj17nxS9trC6xKK2ur4+XfBG9/JkLRfemiRbX5SzG4+DVZzXBA94xgaI75i26ZHpjX+MiPAsyHF7J0gkmV7/OayWlXmpJpkd8p1YFwOiFRb6g1Q9bjXXcY07yHrtizeeoMedk2cygXfNZOcVjo6VoxyonEEnXuizn/RaHEKlS2omK9RKr1moRgVUrHR1ilPLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(6506007)(26005)(54906003)(66946007)(6512007)(31686004)(36756003)(316002)(6666004)(478600001)(6486002)(41300700001)(8676002)(31696002)(86362001)(4326008)(2616005)(8936002)(66476007)(66556008)(6916009)(7406005)(38100700002)(7416002)(186003)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTY3TXNNdmZ0eWhhVWF5VngzazVHN2F2M0o2MGFISXg0eVMyTXBlUEdvWkpi?=
 =?utf-8?B?MHJvb1FaRnNGRVV4T2tmN0RDWXdBb25BdjZ3OEs4QnNiZFJOeXV6Z1FNeE5L?=
 =?utf-8?B?VllVYVkySndQdERZcXZxRGF2RWJ2RjM0TkVMeERsZWdCM2FxcTd0clZYN2px?=
 =?utf-8?B?aXJIR3d2NUJYQ0ptdjhLaEYzWGRCb2RDN3VCVkkvUmkyY1p3WEtHa205dVBS?=
 =?utf-8?B?V1g1MWpsdTFiQTRTMDAwcFhUelVCVGFhWHc5emFXd3FEMEc1OTdrdStvL1Jm?=
 =?utf-8?B?TGtiV0FoZEN6c2hLZ3FGNjNVektXZ0xFeE5wS0RWTmkzNW5QYjJpdzNGUHRo?=
 =?utf-8?B?T2NiOHRzV25uNjJLSHJaUlpiRVp3RDNJY1JhTUFWT3hOQW1LNFJ1aGRpRkxJ?=
 =?utf-8?B?N0VpL1JDSjVqR2VTdU9lUlFJb1Vxa0dIQStHb3NZbk1rdDhQTVAyaVlJakFh?=
 =?utf-8?B?ekFzYzVZT2JWUUp1ODgwaFNMZ0JsMnk3SU1VWmhMUmswK2QvcmRuUXpOMnFx?=
 =?utf-8?B?T3NPREN3anlVQU5UWXVsRTZJcEJ0cnZzUDE0K0JKOFo2OHhScitTRnp5bWx3?=
 =?utf-8?B?V0Z3NHUyR3dGWHFobDdEZEI5dE56QTdGSUcrTHllQzlpNDQwUHV2NXhvN1NU?=
 =?utf-8?B?QnpqTTVBcGJ5a1dCb00razFOTFBZaG14Nm53QWRMVTFhK0RJbFQ1aHhKVHFl?=
 =?utf-8?B?c2piVUVHUXp3RHJYc0thZ3ZLVlV1MkF0eUdzbFd0cTdhZnVsYlhlM25yTEdt?=
 =?utf-8?B?SXhuLzBud1NhSlo1cXB3VGM2TDhGN2Y3RUxMMFE3dWxsM253eGtGOFlhc214?=
 =?utf-8?B?dHFtR3FKRnFYN291Mm5BVytLS0RGdHhGWm9JZ0JrZ1NRZWtoTnFQemp0TjZP?=
 =?utf-8?B?Ri9jSXhXRDRxZ3k3VnNsVU82eGtsRXlOTERJM3ZjZ2p0MGxQamdsOEJNOGN5?=
 =?utf-8?B?ZVZCb0VXemhVTjhZNHgxL2w1aTZkSkowaXZpdUVRUVV1OXhxMG9MWlhxd3BI?=
 =?utf-8?B?ZVVnTTdtYkQ1WHBobWhVZjA3NkN1K2pKNHg5WDlqbDVQbzRXd2ZXSDRCSVB3?=
 =?utf-8?B?NGJGTDNNZkU2M3RjeVZaQ3FRMUtYSG1FdTVVQjNyMGZFYUdMWVFBdDVheURs?=
 =?utf-8?B?SGpRbG5EeCtNUXl5di8yOEhqRkdWSHgzNnB2dGNxTzJLd2I0aEd6SllHYnBT?=
 =?utf-8?B?emRxb1ZsLzVybkhWS2JlOUpEVkh5YzcxblBqRDFLSisrNmMrWHdxK0VPT1Ni?=
 =?utf-8?B?Uy9kMWhGOUFaR2tlSE5hU1Q1emV0ZElBMWR3d0NHY0lkZmg0dDZ2MU0rZEh4?=
 =?utf-8?B?Ri9mWlFJNC8xS0F5WTdFK2swRDU3VGxuWkZDVnNLeW1IK05NWEhnQ3ZNTi9B?=
 =?utf-8?B?cXNwQVNPelMrTGF1SXV2d0lFdzVDOUs4TUZYdXRwK0hCSGpTdk5WL2tMcUxB?=
 =?utf-8?B?SVV5cC9SS0R5S3ZwMGFUZzcwWkZHdkRSMVZFVUZJL2ExQ0sxVHlLd1Zsd0ln?=
 =?utf-8?B?T1R1SWZ5RmxrSWJHWnVtNzBkNWhxSVF2YnpvZ1dVRzFZNDVyK2F5dk9NQmZ2?=
 =?utf-8?B?ZE1XRk1VNjlCSWo3UlR4N0gxaGUyNkFPOVZ3SlhFWmdFSHdacWxBQ1JxV2N0?=
 =?utf-8?B?eWprZ24wMXlPb3p0bFQySDA5cnZWNzN6Qkp1RW05eGJJK1RwMGRqT1JtaXNM?=
 =?utf-8?B?VXFsei9rakRqeTE5Q1QxVXJVSHN2R0w1aVIrZHpQZE0zcFlIeThRWDF6bk10?=
 =?utf-8?B?ajU3ZTlFaHJBZEZKS1kvRHA3ZGwxOFdKYkgzcEdMVWM3MnVVbkZPQjBTd0l3?=
 =?utf-8?B?ZFh5dThKV01GdkNCait2M0NTZjFUVXR5bHk1a3V2SmhkWURMY1pCWHR1M3pX?=
 =?utf-8?B?RjJXbzZZZlh4VEh1RUFTY1Y1L1J3eTFUWldEckxDd3RxU3FWVmYxL2c4VE1B?=
 =?utf-8?B?VFVBQlJHRXN1NGVPRlhnc2RDNVBPQi9DcUhvVXJDQXNRKzlWZzVaNUJsaTEz?=
 =?utf-8?B?UjdkS0kvTWNLZVVQK0JvcXVYcHh5NzhMTEl2bG5IendmWnVXQzVSUzdXMkJN?=
 =?utf-8?B?MXo5amQvMERrYitBUzU3L2Ftd3h1enZWTHN6L0RhNnByK2hrK0tVeERuYlhY?=
 =?utf-8?Q?jirBXhYg+VMxNOKn38f3pkgiw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fe70e3-753c-4597-9b9c-08da6a772688
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 17:42:00.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nRCuHrTnqwkOziaywEhYjVd+sO++quVmh1tJGC8cDAx61mcF2ArYGplmnO+xXXHTW8fo39Ix+UzzEE55YAYcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> Use kvm_arch_has_private_mem(), both because "has" makes it obvious this is checking
> a flag of sorts, and to align with other helpers of this nature (and with
> CONFIG_HAVE_KVM_PRIVATE_MEM).
> 
>    $ git grep kvm_arch | grep supported | wc -l
>    0
>    $ git grep kvm_arch | grep has | wc -l
>    26
> 
>>>>>>> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
>>>>>>> +	case KVM_MEMORY_ENCRYPT_REG_REGION:
>>>>>>> +	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
>>>>>>> +		struct kvm_enc_region region;
>>>>>>> +
>>>>>>> +		if (!kvm_arch_private_mem_supported(kvm))
>>>>>>> +			goto arch_vm_ioctl;
>>>>>>> +
>>>>>>> +		r = -EFAULT;
>>>>>>> +		if (copy_from_user(&region, argp, sizeof(region)))
>>>>>>> +			goto out;
>>>>>>> +
>>>>>>> +		r = kvm_vm_ioctl_set_encrypted_region(kvm, ioctl, &region);
>>>>>>
>>>>>> this is to store private region metadata not only the encrypted region?
>>>>>
>>>>> Correct.
>>>>
>>>> Sorry for not being clear, was suggesting name change of this function from:
>>>> "kvm_vm_ioctl_set_encrypted_region" to "kvm_vm_ioctl_set_private_region"
>>>
>>> Though I don't have strong reason to change it, I'm fine with this and
>>
>> Yes, no strong reason, just thought "kvm_vm_ioctl_set_private_region" would
>> depict the actual functionality :)
>>
>>> this name matches the above kvm_arch_private_mem_supported perfectly.
>> BTW could not understand this, how "kvm_vm_ioctl_set_encrypted_region"
>> matches "kvm_arch_private_mem_supported"?
> 
> Chao is saying that kvm_vm_ioctl_set_private_region() pairs nicely with
> kvm_arch_private_mem_supported(), not that the "encrypted" variant pairs nicely.
> 
> I also like using "private" instead of "encrypted", though we should probably
> find a different verb than "set", because calling "set_private" when making the
> region shared is confusing.  I'm struggling to come up with a good alternative
> though.
> 
> kvm_vm_ioctl_set_memory_region() is already taken by KVM_SET_USER_MEMORY_REGION,
> and that also means that anything with "memory_region" in the name is bound to be
> confusing.
> 
> Hmm, and if we move away from "encrypted", it probably makes sense to pass in
> addr+size instead of a kvm_enc_region.
> 
> Maybe this?
> 
> static int kvm_vm_ioctl_set_or_clear_mem_private(struct kvm *kvm, gpa_t gpa,
> 					         gpa_t size, bool set_private)
> 
> and then:
> 
> #ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> 	case KVM_MEMORY_ENCRYPT_REG_REGION:
> 	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
> 		bool set = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION;
> 		struct kvm_enc_region region;
> 
> 		if (!kvm_arch_private_mem_supported(kvm))
> 			goto arch_vm_ioctl;
> 
> 		r = -EFAULT;
> 		if (copy_from_user(&region, argp, sizeof(region)))
> 			goto out;
> 
> 		r = kvm_vm_ioctl_set_or_clear_mem_private(kvm, region.addr,
> 							  region.size, set);
> 		break;
> 	}
> #endif
> 
> I don't love it, so if someone has a better idea...

Both the suggestions look good to me. Bring more clarity.

Thanks,
Pankaj

