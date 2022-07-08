Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A641056B0EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 05:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiGHDaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 23:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbiGHDaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:30:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F7E747B5;
        Thu,  7 Jul 2022 20:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657251003; x=1688787003;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PT02IACBa7Wm0O3NAyqOHw8PuqCfYgWEKpI8T6m3E9Q=;
  b=gWBFJ8bKzkdleLNFzf1MYRu/9xaIowwykmV0ryKxUQJMp6NekZWLYtE7
   kmxCrg465f1yTjOiNVQuMExTbU8UecqXo8Fvj9rLEA0K4l6veTIk8g+8H
   iILMULRbXp+Ro/i7c4A+gHfXHdB064MiQCOb1n2ouCyRiTttUrnXZgfyD
   HQV1/5/XDurl4rNY1U8MYVhXQDV+0l+oQ701Ksk9qJr8Sp8ejWbJFWi0R
   mcJyAMS9Cu/mJ23qq0kpl/UdpwCh1pw6cRr/cJK1UflDcJ2fvjNUIaEBa
   ja4rAI3Cdvh1OxGxSicSuxFo+3yzMMp+9gHoUEwI4j/7Ff7m2WDDrXriB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="370492166"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="370492166"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 20:30:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="651398466"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.249.175.131]) ([10.249.175.131])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 20:29:51 -0700
Message-ID: <5d0b9341-78b5-0959-2517-0fb1fe83a205@intel.com>
Date:   Fri, 8 Jul 2022 11:29:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v6 6/8] KVM: Handle page fault for private memory
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Michael Roth <michael.roth@amd.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
 <4fe3b47d-e94a-890a-5b87-6dfb7763bc7e@intel.com>
 <Ysc9JDcVAnlVrGC8@google.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Ysc9JDcVAnlVrGC8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/8/2022 4:08 AM, Sean Christopherson wrote:
> On Fri, Jul 01, 2022, Xiaoyao Li wrote:
>> On 7/1/2022 6:21 AM, Michael Roth wrote:
>>> On Thu, Jun 30, 2022 at 12:14:13PM -0700, Vishal Annapurve wrote:
>>>> With transparent_hugepages=always setting I see issues with the
>>>> current implementation.
> 
> ...
> 
>>>> Looks like with transparent huge pages enabled kvm tried to handle the
>>>> shared memory fault on 0x84d gfn by coalescing nearby 4K pages
>>>> to form a contiguous 2MB page mapping at gfn 0x800, since level 2 was
>>>> requested in kvm_mmu_spte_requested.
>>>> This caused the private memory contents from regions 0x800-0x84c and
>>>> 0x86e-0xa00 to get unmapped from the guest leading to guest vm
>>>> shutdown.
>>>
>>> Interesting... seems like that wouldn't be an issue for non-UPM SEV, since
>>> the private pages would still be mapped as part of that 2M mapping, and
>>> it's completely up to the guest as to whether it wants to access as
>>> private or shared. But for UPM it makes sense this would cause issues.
>>>
>>>>
>>>> Does getting the mapping level as per the fault access type help
>>>> address the above issue? Any such coalescing should not cross between
>>>> private to
>>>> shared or shared to private memory regions.
>>>
>>> Doesn't seem like changing the check to fault->is_private would help in
>>> your particular case, since the subsequent host_pfn_mapping_level() call
>>> only seems to limit the mapping level to whatever the mapping level is
>>> for the HVA in the host page table.
>>>
>>> Seems like with UPM we need some additional handling here that also
>>> checks that the entire 2M HVA range is backed by non-private memory.
>>>
>>> Non-UPM SNP hypervisor patches already have a similar hook added to
>>> host_pfn_mapping_level() which implements such a check via RMP table, so
>>> UPM might need something similar:
>>>
>>>     https://github.com/AMDESE/linux/commit/ae4475bc740eb0b9d031a76412b0117339794139
>>>
>>> -Mike
>>>
>>
>> For TDX, we try to track the page type (shared, private, mixed) of each gfn
>> at given level. Only when the type is shared/private, can it be mapped at
>> that level. When it's mixed, i.e., it contains both shared pages and private
>> pages at given level, it has to go to next smaller level.
>>
>> https://github.com/intel/tdx/commit/ed97f4042eb69a210d9e972ccca6a84234028cad
> 
> Hmm, so a new slot->arch.page_attr array shouldn't be necessary, KVM can instead
> update slot->arch.lpage_info on shared<->private conversions.  Detecting whether
> a given range is partially mapped could get nasty if KVM defers tracking to the
> backing store, but if KVM itself does the tracking as was previously suggested[*],
> then updating lpage_info should be relatively straightfoward, e.g. use
> xa_for_each_range() to see if a given 2mb/1gb range is completely covered (fully
> shared) or not covered at all (fully private).
> 
> [*] https://lore.kernel.org/all/YofeZps9YXgtP3f1@google.com

Yes, slot->arch.page_attr was introduced to help identify whether a page 
is completely shared/private at given level. It seems XARRAY can serve 
the same purpose, though I know nothing about it. Looking forward to 
seeing the patch of using XARRAY.

yes, update slot->arch.lpage_info is good to utilize the existing logic 
and Isaku has applied it to slot->arch.lpage_info for 2MB support patches.
