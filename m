Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7915F9B19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 10:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiJJIfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 04:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiJJIft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:35:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BC565808;
        Mon, 10 Oct 2022 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665390948; x=1696926948;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=RGybB6W0aj8JXJpoXUjKNcVo6czdIa5pC/Wiclkx0F8=;
  b=NcHaVrVCqmzfIMb7eG3okL8I+r+vT94TC7ksfWaPmCsfBdv3wG1rOBP1
   zWl+yzjfx7ijk0Vbz7mHMZxthjsnooBTaRIJy0Cfd3EIsv8OolJnT+4Of
   PJtvZ7CiTqC+Elv5zgXojlmu6rICjO/PDw062a39UtG1IY4PUzlFDysHE
   grksZAvok95k1Q91/y7pFmPAVYyLV+c2OTn43OqZUxHF7TapXF83Nh5tH
   /PGsx2CCluVud+66jeK3HS9pdv6OHYyvYVFpDutthD1HX3+sPfnw8a82S
   ol8kLZIR6e7YEMc7idIYsPEg9+mQ+v+fm6zLxz6QwwA9RRRuaqt0aiNdL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="330638854"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="330638854"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 01:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="656854721"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="656854721"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 10 Oct 2022 01:35:37 -0700
Date:   Mon, 10 Oct 2022 16:31:04 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 8/8] KVM: Enable and expose KVM_MEM_PRIVATE
Message-ID: <20221010083104.GA3145236@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-9-chao.p.peng@linux.intel.com>
 <YzxJYAsIkKhpqeSb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzxJYAsIkKhpqeSb@kernel.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 04, 2022 at 05:55:28PM +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 15, 2022 at 10:29:13PM +0800, Chao Peng wrote:
> > Expose KVM_MEM_PRIVATE and memslot fields private_fd/offset to
> > userspace. KVM will register/unregister private memslot to fd-based
> > memory backing store and response to invalidation event from
> > inaccessible_notifier to zap the existing memory mappings in the
> > secondary page table.
> > 
> > Whether KVM_MEM_PRIVATE is actually exposed to userspace is determined
> > by architecture code which can turn on it by overriding the default
> > kvm_arch_has_private_mem().
> > 
> > A 'kvm' reference is added in memslot structure since in
> > inaccessible_notifier callback we can only obtain a memslot reference
> > but 'kvm' is needed to do the zapping.
> > 
> > Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> 
> ld: arch/x86/../../virt/kvm/kvm_main.o: in function `kvm_free_memslot':
> kvm_main.c:(.text+0x1385): undefined reference to `inaccessible_unregister_notifier'
> ld: arch/x86/../../virt/kvm/kvm_main.o: in function `kvm_set_memslot':
> kvm_main.c:(.text+0x1b86): undefined reference to `inaccessible_register_notifier'
> ld: kvm_main.c:(.text+0x1c85): undefined reference to `inaccessible_unregister_notifier'
> ld: arch/x86/kvm/mmu/mmu.o: in function `kvm_faultin_pfn':
> mmu.c:(.text+0x1e38): undefined reference to `inaccessible_get_pfn'
> ld: arch/x86/kvm/mmu/mmu.o: in function `direct_page_fault':
> mmu.c:(.text+0x67ca): undefined reference to `inaccessible_put_pfn'
> make: *** [Makefile:1169: vmlinux] Error 1
> 
> I attached kernel config for reproduction.
> 
> The problem is that CONFIG_MEMFD_CREATE does not get enabled:
> 
> mm/Makefile:obj-$(CONFIG_MEMFD_CREATE) += memfd.o memfd_inaccessible.o

Thanks for reporting. Yes there is a dependency issue needs to fix.

Chao

