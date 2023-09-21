Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58857AA310
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 23:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjIUVqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 17:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjIUVqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:46:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BA05158C;
        Thu, 21 Sep 2023 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316539; x=1726852539;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D2Ofh4NhqIgE7X1sOt5XtBxAR4C9rpdFRo7VG5iLwuA=;
  b=KHvCncRSrBruGvH+50Kzeqz0hI190vMoeAaMPYNqi/DKx6bH/+pwcu+T
   7ISPlgSAOpVv/9rAQ1AASpc3LdOc2ec90SoxCzTu8LfL7ORZE97YCK38+
   LPCEZIzg9RI7BB4jSnpCEvfcmED2C1PVm/raU41zajX11Crudp3clWwTe
   mSeTYJLXS7U3wbJ8czV5XhnqjiUQdYx8EQzWGn2XmPEV2003tRaJVFcYV
   R/H5YvNaDJvUyOH64W3we1R/l2tY0qolAyk42QfnVun/FuWlzezSY33Ny
   GIFb6FBEg2K+ZpDplNCdxU//pzcvuXI+qrnPySJkp5Obw0Tek+e7x+YXF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="380337398"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="380337398"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 22:58:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740494287"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="740494287"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.93.17.222]) ([10.93.17.222])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 22:58:02 -0700
Message-ID: <f9ca9457-ca64-484c-7306-97a3236210da@linux.intel.com>
Date:   Thu, 21 Sep 2023 13:58:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v12 14/33] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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
        "Serge E. Hallyn" <serge@hallyn.com>,
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
 <20230914015531.1419405-15-seanjc@google.com>
 <e397d30c-c6af-e68f-d18e-b4e3739c5389@linux.intel.com>
 <ZQsAiGuw/38jIOV7@google.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ZQsAiGuw/38jIOV7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/20/2023 10:24 PM, Sean Christopherson wrote:
> On Tue, Sep 19, 2023, Binbin Wu wrote:
>>
>> On 9/14/2023 9:55 AM, Sean Christopherson wrote:
>> [...]
>>> +
>>> +static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
>>> +				      pgoff_t end)
>>> +{
>>> +	struct kvm_memory_slot *slot;
>>> +	struct kvm *kvm = gmem->kvm;
>>> +	unsigned long index;
>>> +	bool flush = false;
>>> +
>>> +	KVM_MMU_LOCK(kvm);
>>> +
>>> +	kvm_mmu_invalidate_begin(kvm);
>>> +
>>> +	xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
>>> +		pgoff_t pgoff = slot->gmem.pgoff;
>>> +
>>> +		struct kvm_gfn_range gfn_range = {
>>> +			.start = slot->base_gfn + max(pgoff, start) - pgoff,
>>> +			.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
>>> +			.slot = slot,
>>> +			.may_block = true,
>>> +		};
>>> +
>>> +		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
>>> +	}
>>> +
>>> +	if (flush)
>>> +		kvm_flush_remote_tlbs(kvm);
>>> +
>>> +	KVM_MMU_UNLOCK(kvm);
>>> +}
>>> +
>>> +static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
>>> +				    pgoff_t end)
>>> +{
>>> +	struct kvm *kvm = gmem->kvm;
>>> +
>>> +	KVM_MMU_LOCK(kvm);
>>> +	if (xa_find(&gmem->bindings, &start, end - 1, XA_PRESENT))
>>> +		kvm_mmu_invalidate_end(kvm);
>> kvm_mmu_invalidate_begin() is called unconditionally in
>> kvm_gmem_invalidate_begin(),
>> but kvm_mmu_invalidate_end() is not here.
>> This makes the kvm_gmem_invalidate_{begin, end}() calls asymmetric.
> Another ouch :-(
>
> And there should be no need to acquire mmu_lock() unconditionally, the inode's
> mutex protects the bindings, not mmu_lock.
>
> I'll get a fix posted today.  I think KVM can also add a sanity check to detect
> unresolved invalidations, e.g.
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 7ba1ab1832a9..2a2d18070856 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1381,8 +1381,13 @@ static void kvm_destroy_vm(struct kvm *kvm)
>           * No threads can be waiting in kvm_swap_active_memslots() as the
>           * last reference on KVM has been dropped, but freeing
>           * memslots would deadlock without this manual intervention.
> +        *
> +        * If the count isn't unbalanced, i.e. KVM did NOT unregister between
> +        * a start() and end(), then there shouldn't be any in-progress
> +        * invalidations.
>           */
>          WARN_ON(rcuwait_active(&kvm->mn_memslots_update_rcuwait));
> +       WARN_ON(!kvm->mn_active_invalidate_count && kvm->mmu_invalidate_in_progress);
>          kvm->mn_active_invalidate_count = 0;
>   #else
>          kvm_flush_shadow_all(kvm);
>
>
> or an alternative style
>
> 	if (kvm->mn_active_invalidate_count)
> 		kvm->mn_active_invalidate_count = 0;
> 	else
> 		WARN_ON(kvm->mmu_invalidate_in_progress)
>
>>> +	KVM_MMU_UNLOCK(kvm);
>>> +}
>>> +
>>> +static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>>> +{
>>> +	struct list_head *gmem_list = &inode->i_mapping->private_list;
>>> +	pgoff_t start = offset >> PAGE_SHIFT;
>>> +	pgoff_t end = (offset + len) >> PAGE_SHIFT;
>>> +	struct kvm_gmem *gmem;
>>> +
>>> +	/*
>>> +	 * Bindings must stable across invalidation to ensure the start+end
>>> +	 * are balanced.
>>> +	 */
>>> +	filemap_invalidate_lock(inode->i_mapping);
>>> +
>>> +	list_for_each_entry(gmem, gmem_list, entry) {
>>> +		kvm_gmem_invalidate_begin(gmem, start, end);
>>> +		kvm_gmem_invalidate_end(gmem, start, end);
>>> +	}
>> Why to loop for each gmem in gmem_list here?
>>
>> IIUIC, offset is the offset according to the inode, it is only meaningful to
>> the inode passed in, i.e, it is only meaningful to the gmem binding with the
>> inode, not others.
> The code is structured to allow for multiple gmem instances per inode.  This isn't
> actually possible in the initial code base, but it's on the horizon[*].  I included
> the list-based infrastructure in this initial series to ensure that guest_memfd
> can actually support multiple files per inode, and to minimize the churn when the
> "link" support comes along.
>
> [*] https://lore.kernel.org/all/cover.1691446946.git.ackerleytng@google.com
Got it, thanks for the explanation!



