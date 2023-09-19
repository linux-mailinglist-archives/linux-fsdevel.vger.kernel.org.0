Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6A57A5D37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjISJBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 05:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjISJBx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:01:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF64102;
        Tue, 19 Sep 2023 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695114107; x=1726650107;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3lbpMHnCnN4tgBMsnlxIOe9ua6EYGffh/u6hevJylxY=;
  b=QgfyaQEKqkUA78LLt4ACvbxztG+rDwxAXhUlnqRGeP8yg31t5m9a88pJ
   zYYdyxJuRlC2zkRcqVdJjnSDuiERgzNDAcx3w+/8TPMBYCkhlSaAFi3qk
   Cy/pP6qj2mlVWorpDwsUjalNl+pIk4FL5zN+bvyQtBDrpJT6GfMd3uPVd
   QJRRQB+RrpfNG6qZmZ6mMz4VmIHv68939bZUcJ04YeTkBkP29ZRYvEXR+
   49L59+6dJDUGuQ9dlZXHySMcPjHud85ybqNFVUe3D7CHyeEzhlBw1VQYd
   SV15XhdDtiwFtBZ2y4wXCxrKG069ehgmb51lSwWtr3x1PMSQPYFdkB9/S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="377201128"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="377201128"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:01:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="695833326"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="695833326"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.8.84]) ([10.238.8.84])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:01:36 -0700
Message-ID: <e397d30c-c6af-e68f-d18e-b4e3739c5389@linux.intel.com>
Date:   Tue, 19 Sep 2023 17:01:31 +0800
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
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20230914015531.1419405-15-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/14/2023 9:55 AM, Sean Christopherson wrote:
[...]
> +
> +static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> +				      pgoff_t end)
> +{
> +	struct kvm_memory_slot *slot;
> +	struct kvm *kvm = gmem->kvm;
> +	unsigned long index;
> +	bool flush = false;
> +
> +	KVM_MMU_LOCK(kvm);
> +
> +	kvm_mmu_invalidate_begin(kvm);
> +
> +	xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
> +		pgoff_t pgoff = slot->gmem.pgoff;
> +
> +		struct kvm_gfn_range gfn_range = {
> +			.start = slot->base_gfn + max(pgoff, start) - pgoff,
> +			.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
> +			.slot = slot,
> +			.may_block = true,
> +		};
> +
> +		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> +	}
> +
> +	if (flush)
> +		kvm_flush_remote_tlbs(kvm);
> +
> +	KVM_MMU_UNLOCK(kvm);
> +}
> +
> +static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
> +				    pgoff_t end)
> +{
> +	struct kvm *kvm = gmem->kvm;
> +
> +	KVM_MMU_LOCK(kvm);
> +	if (xa_find(&gmem->bindings, &start, end - 1, XA_PRESENT))
> +		kvm_mmu_invalidate_end(kvm);
kvm_mmu_invalidate_begin() is called unconditionally in 
kvm_gmem_invalidate_begin(),
but kvm_mmu_invalidate_end() is not here.
This makes the kvm_gmem_invalidate_{begin, end}() calls asymmetric.


> +	KVM_MMU_UNLOCK(kvm);
> +}
> +
> +static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> +{
> +	struct list_head *gmem_list = &inode->i_mapping->private_list;
> +	pgoff_t start = offset >> PAGE_SHIFT;
> +	pgoff_t end = (offset + len) >> PAGE_SHIFT;
> +	struct kvm_gmem *gmem;
> +
> +	/*
> +	 * Bindings must stable across invalidation to ensure the start+end
> +	 * are balanced.
> +	 */
> +	filemap_invalidate_lock(inode->i_mapping);
> +
> +	list_for_each_entry(gmem, gmem_list, entry) {
> +		kvm_gmem_invalidate_begin(gmem, start, end);
> +		kvm_gmem_invalidate_end(gmem, start, end);
> +	}
Why to loop for each gmem in gmem_list here?

IIUIC, offset is the offset according to the inode, it is only 
meaningful to the
inode passed in, i.e, it is only meaningful to the gmem binding with the 
inode,
not others.


> +
> +	filemap_invalidate_unlock(inode->i_mapping);
> +
> +	return 0;
> +}
> +
[...]
