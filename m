Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25EF7A9683
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 19:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjIURBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 13:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjIURBA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:01:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB1CDD;
        Thu, 21 Sep 2023 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695315562; x=1726851562;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oZ26NaKC2zv5YONE8y6jW8KHDfibqQbE4Lcj557476A=;
  b=Xkm+iGlBE6orJWszf3h/H4m+HtQA60DEUHwyUtmg9i5jaWDT1S9FR8hj
   YtEipiPub8bi9mHzl/Fr81HyOkvRvNtT0YrBXT+3HaBEzzQ1sUxwsaS6C
   pfHGU46eOVUiEDEZ3xb645ixhLZ5XlzmImCHNozhHQ/WlHR72aSrebSFc
   TxYc74ca32GhUTwfalEh0chny9CW4gkGVohFKopw0l0Iht8Tv4JsBnkWO
   hKQ/Fk8xJlhLWLLqa3LBD+Nq4ScdGTjikwcKLZBYF21Or2parWQ2yty81
   CBbWjQLqAU+4W7BZ7L7xXcz7UlbJalHuoJWQ44Gfcpm3XagCA84ek5F7u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="466734468"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="466734468"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 22:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="837187245"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="837187245"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.93.17.222]) ([10.93.17.222])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 22:51:36 -0700
Message-ID: <ef36db9d-bb9c-e042-2617-830cf44602de@linux.intel.com>
Date:   Thu, 21 Sep 2023 13:51:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v12 18/33] KVM: x86/mmu: Handle page fault for private
 memory
To:     Sean Christopherson <seanjc@google.com>,
        Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230914015531.1419405-1-seanjc@google.com>
 <20230914015531.1419405-19-seanjc@google.com>
 <ZQPuMK6D/7UzDH+D@yzhao56-desk.sh.intel.com> <ZQRpiOd1DNDDJQ3r@google.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ZQRpiOd1DNDDJQ3r@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/15/2023 10:26 PM, Sean Christopherson wrote:
> On Fri, Sep 15, 2023, Yan Zhao wrote:
>> On Wed, Sep 13, 2023 at 06:55:16PM -0700, Sean Christopherson wrote:
>> ....
>>> +static void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
>>> +					      struct kvm_page_fault *fault)
>>> +{
>>> +	kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
>>> +				      PAGE_SIZE, fault->write, fault->exec,
>>> +				      fault->is_private);
>>> +}
>>> +
>>> +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
>>> +				   struct kvm_page_fault *fault)
>>> +{
>>> +	int max_order, r;
>>> +
>>> +	if (!kvm_slot_can_be_private(fault->slot)) {
>>> +		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
>>> +		return -EFAULT;
>>> +	}
>>> +
>>> +	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
>>> +			     &max_order);
>>> +	if (r) {
>>> +		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
>>> +		return r;
>>> +	}
>>> +
>>> +	fault->max_level = min(kvm_max_level_for_order(max_order),
>>> +			       fault->max_level);
>>> +	fault->map_writable = !(fault->slot->flags & KVM_MEM_READONLY);
>>> +
>>> +	return RET_PF_CONTINUE;
>>> +}
>>> +
>>>   static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>>>   {
>>>   	struct kvm_memory_slot *slot = fault->slot;
>>> @@ -4293,6 +4356,14 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>>>   			return RET_PF_EMULATE;
>>>   	}
>>>   
>>> +	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
>> In patch 21,
>> fault->is_private is set as:
>> 	".is_private = kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT)",
>> then, the inequality here means memory attribute has been updated after
>> last check.
>> So, why an exit to user space for converting is required instead of a mere retry?
>>
>> Or, is it because how .is_private is assigned in patch 21 is subjected to change
>> in future?
> This.  Retrying on SNP or TDX would hang the guest.  I suppose we could special
> case VMs where .is_private is derived from the memory attributes, but the
> SW_PROTECTED_VM type is primary a development vehicle at this point.  I'd like to
> have it mimic SNP/TDX as much as possible; performance is a secondary concern.
So when .is_private is derived from the memory attributes, and if I 
didn't miss
anything, there is no explicit conversion mechanism introduced yet so 
far, does
it mean for pure sw-protected VM (withouth SNP/TDX), the page fault will be
handled according to the memory attributes setup by host/user vmm, no 
implicit
conversion will be triggered, right?


>
> E.g. userspace needs to be prepared for "spurious" exits due to races on SNP and
> TDX, which this can theoretically exercise.  Though the window is quite small so
> I doubt that'll actually happen in practice; which of course also makes it less
> important to retry instead of exiting.

