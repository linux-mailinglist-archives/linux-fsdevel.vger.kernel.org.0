Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAE344E1B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 06:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhKLFy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 00:54:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:36075 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhKLFy0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 00:54:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="233325187"
X-IronPort-AV: E=Sophos;i="5.87,228,1631602800"; 
   d="scan'208";a="233325187"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 21:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,228,1631602800"; 
   d="scan'208";a="492855072"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 21:51:27 -0800
Date:   Fri, 12 Nov 2021 13:50:38 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Wanpeng Li <wanpengli@tencent.com>,
        luto@kernel.org, david@redhat.com,
        "J . Bruce Fields" <bfields@fieldses.org>, dave.hansen@intel.com,
        "H . Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        jun.nakajima@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>, susie.li@intel.com,
        Jeff Layton <jlayton@kernel.org>, john.ji@intel.com,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH 5/6] kvm: x86: add KVM_EXIT_MEMORY_ERROR exit
Message-ID: <20211112055038.GB27969@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
 <20211111141352.26311-6-chao.p.peng@linux.intel.com>
 <f7155c5b-fc87-c1a6-9ee7-06f08a25bdb4@nextfour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7155c5b-fc87-c1a6-9ee7-06f08a25bdb4@nextfour.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 11, 2021 at 05:08:47PM +0200, Mika Penttilä wrote:
> 
> 
> On 11.11.2021 16.13, Chao Peng wrote:
> > Currently support to exit to userspace for private/shared memory
> > conversion.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >   arch/x86/kvm/mmu/mmu.c   | 20 ++++++++++++++++++++
> >   include/uapi/linux/kvm.h | 15 +++++++++++++++
> >   2 files changed, 35 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index af5ecf4ef62a..780868888aa8 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3950,6 +3950,17 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
> >   	slot = __kvm_vcpu_gfn_to_memslot(vcpu, gfn, private);
> > +	/*
> > +	 * Exit to userspace to map the requested private/shared memory region
> > +	 * if there is no memslot and (a) the access is private or (b) there is
> > +	 * an existing private memslot.  Emulated MMIO must be accessed through
> > +	 * shared GPAs, thus a memslot miss on a private GPA is always handled
> > +	 * as an implicit conversion "request".
> > +	 */
> > +	if (!slot &&
> > +	    (private || __kvm_vcpu_gfn_to_memslot(vcpu, gfn, true)))
> > +		goto out_convert;
> > +
> >   	/* Don't expose aliases for no slot GFNs or private memslots */
> >   	if ((cr2_or_gpa & vcpu_gpa_stolen_mask(vcpu)) &&
> >   	    !kvm_is_visible_memslot(slot)) {
> > @@ -3994,6 +4005,15 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
> >   	*pfn = __gfn_to_pfn_memslot(slot, gfn, false, NULL,
> >   				    write, writable, hva);
> >   	return false;
> > +
> > +out_convert:
> > +	vcpu->run->exit_reason = KVM_EXIT_MEMORY_ERROR;
> > +	vcpu->run->mem.type = private ? KVM_EXIT_MEM_MAP_PRIVATE
> > +				      : KVM_EXIT_MEM_MAP_SHARE;
> > +	vcpu->run->mem.u.map.gpa = cr2_or_gpa;
> > +	vcpu->run->mem.u.map.size = PAGE_SIZE;
> > +	return true;
> > +
> I think this does just retry, no exit to user space?

Good catch, thanks.
Chao
> 
> 
> 
> 
> > }
> >   static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 8d20caae9180..470c472a9451 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -233,6 +233,18 @@ struct kvm_xen_exit {
> >   	} u;
> >   };
> > +struct kvm_memory_exit {
> > +#define KVM_EXIT_MEM_MAP_SHARE          1
> > +#define KVM_EXIT_MEM_MAP_PRIVATE        2
> > +	__u32 type;
> > +	union {
> > +		struct {
> > +			__u64 gpa;
> > +			__u64 size;
> > +		} map;
> > +	} u;
> > +};
> > +
> >   #define KVM_S390_GET_SKEYS_NONE   1
> >   #define KVM_S390_SKEYS_MAX        1048576
> > @@ -272,6 +284,7 @@ struct kvm_xen_exit {
> >   #define KVM_EXIT_X86_BUS_LOCK     33
> >   #define KVM_EXIT_XEN              34
> >   #define KVM_EXIT_TDVMCALL         35
> > +#define KVM_EXIT_MEMORY_ERROR	  36
> >   /* For KVM_EXIT_INTERNAL_ERROR */
> >   /* Emulate instruction failed. */
> > @@ -455,6 +468,8 @@ struct kvm_run {
> >   			__u64 subfunc;
> >   			__u64 param[4];
> >   		} tdvmcall;
> > +		/* KVM_EXIT_MEMORY_ERROR */
> > +		struct kvm_memory_exit mem;
> >   		/* Fix the size of the union. */
> >   		char padding[256];
> >   	};
> 
