Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F56562814
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 03:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiGABVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 21:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGABVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 21:21:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C835A2CB;
        Thu, 30 Jun 2022 18:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656638512; x=1688174512;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G2fAQsutHSI8kLKVVakNXwxot1Yyc0ooUkqIi8b15IA=;
  b=c4QNRs3N2jhbkzCT0dIZHMMxEFx/ac7LUFsFEPsniCXGblAEkZvkybgD
   GDcHXRcw4VSAG6BT/4XWBSmDwWYayzar6sdrw1OFn63hYE7KeExTVe1ob
   y/EoKg6MikYiAmFGPgUIgwE+4grBZXLbqXJTK+0BWXUphaA1aGHapHbWL
   Q+l57jzMy09nd4vlmFN5QZCasEGtUtjOPkk1JU7YJDy2kjRntnGHTYhla
   xz+aJ+V+DURO1OpuqsP258meHj/yW5Ea4sJw8gOGEsCEUOa3XwalSv2QU
   GOqXG156DuYDjvCbwFV2UPXtV3BrVN5IMzmfJdQ/hAR32ytHnBmyCYuly
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="282547312"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="282547312"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 18:21:52 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="596042946"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.249.169.250]) ([10.249.169.250])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 18:21:42 -0700
Message-ID: <4fe3b47d-e94a-890a-5b87-6dfb7763bc7e@intel.com>
Date:   Fri, 1 Jul 2022 09:21:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v6 6/8] KVM: Handle page fault for private memory
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>,
        Vishal Annapurve <vannapurve@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, mhocko@suse.com
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-7-chao.p.peng@linux.intel.com>
 <b3ce0855-0e4b-782a-599c-26590df948dd@amd.com>
 <20220624090246.GA2181919@chaop.bj.intel.com>
 <CAGtprH82H_fjtRbL0KUxOkgOk4pgbaEbAydDYfZ0qxz41JCnAQ@mail.gmail.com>
 <20220630222140.of4md7bufd5jv5bh@amd.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20220630222140.of4md7bufd5jv5bh@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/1/2022 6:21 AM, Michael Roth wrote:
> On Thu, Jun 30, 2022 at 12:14:13PM -0700, Vishal Annapurve wrote:
>> With transparent_hugepages=always setting I see issues with the
>> current implementation.
>>
>> Scenario:
>> 1) Guest accesses a gfn range 0x800-0xa00 as private
>> 2) Guest calls mapgpa to convert the range 0x84d-0x86e as shared
>> 3) Guest tries to access recently converted memory as shared for the first time
>> Guest VM shutdown is observed after step 3 -> Guest is unable to
>> proceed further since somehow code section is not as expected
>>
>> Corresponding KVM trace logs after step 3:
>> VCPU-0-61883   [078] ..... 72276.115679: kvm_page_fault: address
>> 84d000 error_code 4
>> VCPU-0-61883   [078] ..... 72276.127005: kvm_mmu_spte_requested: gfn
>> 84d pfn 100b4a4d level 2
>> VCPU-0-61883   [078] ..... 72276.127008: kvm_tdp_mmu_spte_changed: as
>> id 0 gfn 800 level 2 old_spte 100b1b16827 new_spte 100b4a00ea7
>> VCPU-0-61883   [078] ..... 72276.127009: kvm_mmu_prepare_zap_page: sp
>> gen 0 gfn 800 l1 8-byte q0 direct wux nxe ad root 0 sync
>> VCPU-0-61883   [078] ..... 72276.127009: kvm_tdp_mmu_spte_changed: as
>> id 0 gfn 800 level 1 old_spte 1003eb27e67 new_spte 5a0
>> VCPU-0-61883   [078] ..... 72276.127010: kvm_tdp_mmu_spte_changed: as
>> id 0 gfn 801 level 1 old_spte 10056cc8e67 new_spte 5a0
>> VCPU-0-61883   [078] ..... 72276.127010: kvm_tdp_mmu_spte_changed: as
>> id 0 gfn 802 level 1 old_spte 10056fa2e67 new_spte 5a0
>> VCPU-0-61883   [078] ..... 72276.127010: kvm_tdp_mmu_spte_changed: as
>> id 0 gfn 803 level 1 old_spte 0 new_spte 5a0
>> ....
>>   VCPU-0-61883   [078] ..... 72276.127089: kvm_tdp_mmu_spte_changed: as
>> id 0 gfn 9ff level 1 old_spte 100a43f4e67 new_spte 5a0
>>   VCPU-0-61883   [078] ..... 72276.127090: kvm_mmu_set_spte: gfn 800
>> spte 100b4a00ea7 (rwxu) level 2 at 10052fa5020
>>   VCPU-0-61883   [078] ..... 72276.127091: kvm_fpu: unload
>>
>> Looks like with transparent huge pages enabled kvm tried to handle the
>> shared memory fault on 0x84d gfn by coalescing nearby 4K pages
>> to form a contiguous 2MB page mapping at gfn 0x800, since level 2 was
>> requested in kvm_mmu_spte_requested.
>> This caused the private memory contents from regions 0x800-0x84c and
>> 0x86e-0xa00 to get unmapped from the guest leading to guest vm
>> shutdown.
> 
> Interesting... seems like that wouldn't be an issue for non-UPM SEV, since
> the private pages would still be mapped as part of that 2M mapping, and
> it's completely up to the guest as to whether it wants to access as
> private or shared. But for UPM it makes sense this would cause issues.
> 
>>
>> Does getting the mapping level as per the fault access type help
>> address the above issue? Any such coalescing should not cross between
>> private to
>> shared or shared to private memory regions.
> 
> Doesn't seem like changing the check to fault->is_private would help in
> your particular case, since the subsequent host_pfn_mapping_level() call
> only seems to limit the mapping level to whatever the mapping level is
> for the HVA in the host page table.
> 
> Seems like with UPM we need some additional handling here that also
> checks that the entire 2M HVA range is backed by non-private memory.
> 
> Non-UPM SNP hypervisor patches already have a similar hook added to
> host_pfn_mapping_level() which implements such a check via RMP table, so
> UPM might need something similar:
> 
>    https://github.com/AMDESE/linux/commit/ae4475bc740eb0b9d031a76412b0117339794139
> 
> -Mike
> 

For TDX, we try to track the page type (shared, private, mixed) of each 
gfn at given level. Only when the type is shared/private, can it be 
mapped at that level. When it's mixed, i.e., it contains both shared 
pages and private pages at given level, it has to go to next smaller level.

https://github.com/intel/tdx/commit/ed97f4042eb69a210d9e972ccca6a84234028cad


