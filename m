Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8E57C55D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 09:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiGUHfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 03:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGUHfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:35:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7590D11B;
        Thu, 21 Jul 2022 00:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658388917; x=1689924917;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HDZ5ADD7H00ujzYo8f6UW7EI5DQuY8pQPtvATJDvm4I=;
  b=ipaVH0A1IdlCM4V/RRcDGYVjn28z9hgpjyJ5fTjgRtAUjrvQuOVd0TVd
   YhQJEBgvRh8MFAzOhGugYZwNo5KmfcybgQp8kf2TJfrJWYRmoLnl8SNaA
   cDvmVQJqB+4apfkhqjUDLu4PFyykYClif54JQUOIISzf6tP6+dCUZAUER
   b5xHxFYIawwVSEHUOQ533k2mNaTUXeVTVgpu7h/d00qaJp6VZU02U5FM5
   o43/eDAx0eV2kM4e150OHmagnEvgW8XCSQlrvMNb8uTGnIn4v+9E2bPPf
   qLOazo/vmb9apW0ZksEhrzkJRyim7RtZ4mtw4infkYF+HMXrtHzTsp3Rj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="350963821"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="350963821"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 00:35:16 -0700
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="626004190"
Received: from wangwei-desk.sh.intel.com (HELO [10.239.159.152]) ([10.239.159.152])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 00:35:06 -0700
Message-ID: <45ae9f57-d595-f202-abb5-26a03a2ca131@linux.intel.com>
Date:   Thu, 21 Jul 2022 15:34:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
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
From:   Wei Wang <wei.w.wang@linux.intel.com>
In-Reply-To: <YtgrkXqP/GIi9ujZ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/21/22 00:21, Sean Christopherson wrote:
> On Wed, Jul 20, 2022, Gupta, Pankaj wrote:
>>>>>>> +bool __weak kvm_arch_private_mem_supported(struct kvm *kvm)
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
>>>>>> this is to store private region metadata not only the encrypted region?
>>>>> Correct.
>>>> Sorry for not being clear, was suggesting name change of this function from:
>>>> "kvm_vm_ioctl_set_encrypted_region" to "kvm_vm_ioctl_set_private_region"
>>> Though I don't have strong reason to change it, I'm fine with this and
>> Yes, no strong reason, just thought "kvm_vm_ioctl_set_private_region" would
>> depict the actual functionality :)
>>
>>> this name matches the above kvm_arch_private_mem_supported perfectly.
>> BTW could not understand this, how "kvm_vm_ioctl_set_encrypted_region"
>> matches "kvm_arch_private_mem_supported"?
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
>
Maybe you could tag it with cgs for all the confidential guest support 
related stuff:
e.g. kvm_vm_ioctl_set_cgs_mem()

bool is_private = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION;
...
kvm_vm_ioctl_set_cgs_mem(, is_private)

