Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1610257B9B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 17:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbiGTPcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbiGTPcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:32:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02BD61DBB;
        Wed, 20 Jul 2022 08:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntNxZ9KmwDGOzZyFOUzo1EpBQe38CHJKP1LgFext6aQvFiBkf3P5z2t8SZKQbmawVfYbhYy2wz7SqtxcdbIonfIbMePGZJgihP845yq2uwu7vE6G0KcvRcQFv1L8Vus0Gd4oQHr7SwmtL7ymjvulHEXBK5cSIzMcHEGtkHtcurU20qbowiH3dfSvh8dKe/tNUQJwZGmf9sEol4os/Y7w2NAXafRxArZpdei/PmHK77wLA/7JkH12c3Wuie2b7uljNLV45yZdisf0XpLbSJc/X3x6AaRFQ+ZzQtIkqLCf5GI/mEjhMSe0lYv61qpMBToOjiU35Uv4DO7DyDp3Dxzt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8pXgw62BxAIAwbrEYE97Y22msu6xhq7UAzzGX1PsXg=;
 b=Jnamp8t9ZMb8uSVdOyWB/YzpTNtT5LosQ5wLBIMc1RPktEWuV4gOHsqxNl82kqkt/LZ2U2mg2BTGWBOom3Yf39gBqQOUdYnTNjOz/WY+YiSqkDoSxnG0knqhTCQZ7JRpQDvkc0bPVgVZMgaxUsOdcMglE/21T1E/+z4x01GsJjUj0xi/P9om4KGCRvNmPN6g8CH3hDoL55rswYS6s1M4VGcx5hngxCmzkdtE+NM+QYzAyPys7DLi3DTdeU5T/7fUTVDzqLZl7ezYq4zFIngNlETd1pBKnb7flT/F/92MzSMV/mqLzT7wbm5Ulw2v6alOPhaxgwRbbNbGgZZ5lZsHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8pXgw62BxAIAwbrEYE97Y22msu6xhq7UAzzGX1PsXg=;
 b=afJ/mkAcEENKHjExurQ4I9eqUdS0i+KkCtD+vp7ExrLoAdNTebhiwNGcQcwosGfN1pV7wy27aW54Yww+pmtdNmoeG/I3pWNisdKWqGYWr51inGeEd12yjDwYkH3jrDhLQz+IHlYZOVJhhxVMDsOaJskWRXxbjuwRNXpO3wDf5Z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by MN2PR12MB3998.namprd12.prod.outlook.com
 (2603:10b6:208:16d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 15:31:51 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5438.023; Wed, 20 Jul
 2022 15:31:51 +0000
Message-ID: <d0fd229d-afa6-c66d-3e55-09ac5877453e@amd.com>
Date:   Wed, 20 Jul 2022 17:31:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
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
 <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
 <f02baa37-8d34-5d07-a0ae-300ffefc7fee@amd.com>
 <20220719140843.GA84779@chaop.bj.intel.com>
 <36e671d2-6b95-8e4f-c2ac-fee4b2670c6e@amd.com>
 <20220720150706.GB124133@chaop.bj.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220720150706.GB124133@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0140.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::25) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75962c63-7ae6-4e91-704b-08da6a64f763
X-MS-TrafficTypeDiagnostic: MN2PR12MB3998:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/kbsMs1T0nfLKg/Sp4Q06kzwPXO8WR7RHeqONNmzln9heXT5t0tUwdyMI3K7HmzX1gYAWGecAvITErxnLFt6cUDG0KMoJgewDs25sJN3nY46fC0Cnyajpn7rhgX7iAtHq3nmOtaXO0NwpjPqftfoimFMG7erxRDZNYQA7mDa2jMJqH1DXXmiTF9eTKoqoPuqqGlcx/VxN5MMdSp35bux2UmRqlY8CyFh34W3Afhy8Fx7eGOG0sZPZ7nA9LX3UC0/eYws8vSyJ/C5lr+5j3vKyBcSZLTAsR3wgXvh58fW7PNk0o6jFE3zjgPaUpV5IAhQLHZUV7AgWX17snGdDYD+tjfBmLPpZfamXc4vIp0aFooaMT28kPJvczLo0TrJqEFnWDqusUedJL6GWZA4aZL++7Efd+q7RCXWVnmEc9v1bUjGi5E2lXwfsKxLXLW2lXi/ZYfdX0fYXfRVaGGgYeDTyJsb/Ho+DOnM5U+rChYpDnl69+Fomcvf9wXz7HyrpltgNoDMdGpseztuiOmY83Lo2aYN36fX7CWfTkeZhfXVR2SMY9joP7RdafCDC/St2wCHIMlFG8LE4/0LK/E+snl8Ssyt35L2xLoiJY11+PBLQTtNvubIQCFNglCcVr5mFLWEOpTe9rrvk8o6iqCVNDtwLR8Ym/pV+5xdNSiS1wOTPSBpYSagY3ql29oyA2fn2ZObLUfnhTi617VU8n8RysuWQplE4AoSsZtxjV7CwvHieBM4j52XsuTaPjXKaDAKy5Wek4qj7NqpY8OjvM3GgNNwtvj53CUH1Tms8M8n+GKGYmrlxpi87jx0Vlm7Q082AK4ZpaIREW1RuWyvbOlvBzJhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(316002)(54906003)(66476007)(6916009)(66946007)(66556008)(86362001)(186003)(8676002)(5660300002)(4326008)(7416002)(31696002)(7406005)(8936002)(6512007)(38100700002)(6486002)(26005)(2616005)(2906002)(31686004)(36756003)(6666004)(478600001)(41300700001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmJya1VmeE5OWS93NHBXT2xkMk4zWS9hODV4YUpBTFd1ZERoelRIYUNtQ0FU?=
 =?utf-8?B?ZHBPUG5SdFpaakVRSFhFTytSUU5pbDI5ak5wcVhaRWJGQmNmaE14OTFSOVdz?=
 =?utf-8?B?TjNZbjRkeDQ1dnBpQnJ2by9Jb2RNTVk3bGwweWppRnhTdzBvazdGTEoxNGFN?=
 =?utf-8?B?N3Zua2lWUW9KMUNmbzdCMzNGOWJiT2JoVERDYXhjVlRwbVNGakwwRXMwYVlW?=
 =?utf-8?B?bWU1U1BDWThsQTBUVnRKUFdwQ2hONDVDNjhNRHo5YlZIa2QyU1kvcm5YelFL?=
 =?utf-8?B?bFhJNTI5UDBiYlFwL3dGQWFoWEd2eHJMZ25xVU5OOUhYbndHS2hWQjlSTjZr?=
 =?utf-8?B?SjIrak1FZmtXaCtSV1ZTSXVnZU9VdDJjQjJUU3pYRStiOFIrRVdZYlFOc01K?=
 =?utf-8?B?bHQ2SXQ5dE1sQUVsRUxtWFUyUnNVbWdUdmxwN3Fyb1dBOXJPS1IvZnRuY09j?=
 =?utf-8?B?UE5wWERCMk8yV3QrT1ZmRzlqS2lNNE1FZ3lDRmV0RzJIdDFzbElqaTJmd1cw?=
 =?utf-8?B?d1k2T29YUFdvTkJYRXBiYUloSytOZ1E2YzRGVmZVK3A0RVZrTEo2VTdZcEVZ?=
 =?utf-8?B?OU9VZUJNT1VzQ2ppQTF3cTBTeG9jeUJoVzFrdno3RndwTHdXZVZZcUlPN1ZU?=
 =?utf-8?B?NS8xYnVzdEhUZytwMkdIcHE3UC90Mk1ObjhZVWtlTUtlYWM2enBZYWlzRDZt?=
 =?utf-8?B?OWVxdHVpZkxreWlsamFIMCs3b2MvVUdWTks0Y3hGZmliVm1tYzZwM0M2WU1N?=
 =?utf-8?B?dnF3MUVFN0QrdEZkdTVtVy9tNjFtVlVhanlSOGhFY1Y0bzBGTVZ0Z0FLL1BF?=
 =?utf-8?B?WnlTaGhHSEErcGV0SFgxNzVwdzBXYWpLaklhUGFEVEVPRDZvcnJ1alVmUUVs?=
 =?utf-8?B?R1JHSmEyaUVuT1FYaGk1WHY5b0o3WE5iczNxdGsxdFEzakcwUEx0Sko3cTB2?=
 =?utf-8?B?K3VFRXJiS2VQa3U4YlNlQU11dkUzZkdxZ1dQalloQWZtWkhZUmpKRVFjU3NW?=
 =?utf-8?B?VTRGdktFU2Y0MlVFUStPVlFlQy9yRTFWblFyNnZsM2ZIdmlxMWR0UlR1THZH?=
 =?utf-8?B?a3BKdjUvSjRkS2Vld3k4Z1VZaXY5YlhkM3ozTTZHQnFiWkdEazU3TmM3RVNN?=
 =?utf-8?B?R20wMGxvZVd2V2h2ZWRRYjlDdjRPNWF2UTk4YjVRK2hOZW90b0cxRkVlUG9v?=
 =?utf-8?B?M05HMTNxam5PYlJNQjBoSUo1Njkrend5bGUreUdNMVRKSFM3bEN2dE9BZEVQ?=
 =?utf-8?B?OXlJQkNqajE4ZVFBYXdydVB6Vmw0SkRDZWE1aG5XWG5sbWhGZDQyU3F4MmFF?=
 =?utf-8?B?bzE2RFF4VXZjZCtaNlgxMlRjSW5FbFN6bFk3QmFWSEp3UzVYNi9hNHQ4TzZy?=
 =?utf-8?B?SnA1Qi9wMWxDT0pmbXdrK3dHcVQreERSeGl6TWg4T2tlM3lyUkdPSjNlb1Jr?=
 =?utf-8?B?N0JWcVc3ejRBdjN2Yyt5cld5ZnhxZzBMWGh2eUJ4Y1JEdXJ6YklSbDBoK3do?=
 =?utf-8?B?OGV1YjAzVkRibHE3djJhVVJNWTFlSHYweFBKdWhVRVhEL0tyME1mUG10Vklo?=
 =?utf-8?B?QmdKZXpiSXMzdGgySEk2bHcvUk16aSsxM3FDRCtOU1laRk1KZW1VYTVjd2Ez?=
 =?utf-8?B?WkJBcUFBY3lIenQ2NDVib2NLUkE5d1pHVzZnVm9pTzNRdFNKcjV0V0IzVVhU?=
 =?utf-8?B?U3p5UWxaZnlnR3ZEazQyVytYUG15YjZMcklIcXQ0YnJUT3NPQlY3WGd3ejZ3?=
 =?utf-8?B?TEdFMmo4TWJpOWhEcXFSdnlpV0hYb2gxNDVKQnAvU0hGTjQvNHViTVhYQXlT?=
 =?utf-8?B?YS91UDB4VWxHdzUwTEl3dnZCakloWDdoaGF0anEvUmZIQkVRd0orOFk5TXJ2?=
 =?utf-8?B?YjFNbWtRVmNTRWhXakJlSjVqQy9tWUxJaFVld0hqb3RFYVhyWG84aklCWE54?=
 =?utf-8?B?TG5rczRSZm45MC9jREpKc1lRdnZJTHRVT0xtQXBOaDNlWnRGQUp0aGU3S0px?=
 =?utf-8?B?TUtYU3M0a2tGVUxaOXZmejRScWZYZDNUVnB1M3QvUVMyQ2FCQnRZUW52Ukc1?=
 =?utf-8?B?L2RJYlpyd0F3UVoxNVl0djZDWUdqc01JYmpod1BTZFZBQlJ2d3RzVTRjR2RG?=
 =?utf-8?Q?nGatqrFbk3ZMJUWdQLNUUYIY5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75962c63-7ae6-4e91-704b-08da6a64f763
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 15:31:50.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gv/YljjgkS8mtRrJbAASo80kTBH+j1nUXWWwtGyUWcr5UNs8rBKUXKunIkUgWPE7OATmANQceJBiN78kuJhBSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3998
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>> +bool __weak kvm_arch_private_mem_supported(struct kvm *kvm)
>>>>> +{
>>>>> +	return false;
>>>>> +}
>>>>
>>>> Does this function has to be overriden by SEV and TDX to support the private
>>>> regions?
>>>
>>> Yes it should be overridden by architectures which want to support it.
>>
>> o.k
>>>
>>>>
>>>>> +
>>>>>     static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
>>>>>     {
>>>>>     	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
>>>>> @@ -4689,6 +4729,22 @@ static long kvm_vm_ioctl(struct file *filp,
>>>>>     		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
>>>>>     		break;
>>>>>     	}
>>>>> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
>>>>> +	case KVM_MEMORY_ENCRYPT_REG_REGION:
>>>>> +	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
>>>>> +		struct kvm_enc_region region;
>>>>> +
>>>>> +		if (!kvm_arch_private_mem_supported(kvm))
>>>>> +			goto arch_vm_ioctl;
>>>>> +
>>>>> +		r = -EFAULT;
>>>>> +		if (copy_from_user(&region, argp, sizeof(region)))
>>>>> +			goto out;
>>>>> +
>>>>> +		r = kvm_vm_ioctl_set_encrypted_region(kvm, ioctl, &region);
>>>>
>>>> this is to store private region metadata not only the encrypted region?
>>>
>>> Correct.
>>
>> Sorry for not being clear, was suggesting name change of this function from:
>> "kvm_vm_ioctl_set_encrypted_region" to "kvm_vm_ioctl_set_private_region"
> 
> Though I don't have strong reason to change it, I'm fine with this and

Yes, no strong reason, just thought "kvm_vm_ioctl_set_private_region" 
would depict the actual functionality :)

> this name matches the above kvm_arch_private_mem_supported perfectly.
BTW could not understand this, how "kvm_vm_ioctl_set_encrypted_region"
matches "kvm_arch_private_mem_supported"?

Thanks,
Pankaj
