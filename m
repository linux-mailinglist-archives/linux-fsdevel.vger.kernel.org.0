Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE047EB14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 05:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351238AbhLXENR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 23:13:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:9701 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235118AbhLXENQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 23:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640319196; x=1671855196;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=EsRqF2wL7EbaIGBJmS33K3y/lg8UFHqvEvBQI19Vsxw=;
  b=R2xy+0nXJl5uXAfrgKR5PCWflkf7JV6+wrpOefq3crlpNldGsyIT8iW/
   pwp6UNCn27Nq49zj+u+mn8jqoxbiF2wce2mFk1pSFD4IPMqXEY5afCcJ1
   gGLBboBEwQAT3qaCf+CxHE68BR6SDodoABvQDhRcqz2aMHEeoKghG0nLM
   Ra9Rb4wvjoEbYaiDL1xMs1bgehahvMxKYwnmfSlZS3CV33uyjFWlPh+zG
   siONfCcOKMfG/izKWvVEsS+g+CQhT/rkpshs5XZZlUekRF4OtEKJr4e8T
   Xr/Ph29KRxMmmeRE+gpxhsuvECAXL4zkUTvvtrXAky31uGH2f3RTegFcg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="238461774"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="238461774"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 20:13:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="664765488"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 20:13:08 -0800
Date:   Fri, 24 Dec 2021 12:12:31 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v3 kvm/queue 06/16] KVM: Implement fd-based memory using
 MEMFD_OPS interfaces
Message-ID: <20211224041231.GA44042@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-7-chao.p.peng@linux.intel.com>
 <YcTBLpVlETdI8JHi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcTBLpVlETdI8JHi@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 06:34:22PM +0000, Sean Christopherson wrote:
> On Thu, Dec 23, 2021, Chao Peng wrote:
> > diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> > index 03b2ce34e7f4..86655cd660ca 100644
> > --- a/arch/x86/kvm/Kconfig
> > +++ b/arch/x86/kvm/Kconfig
> > @@ -46,6 +46,7 @@ config KVM
> >  	select SRCU
> >  	select INTERVAL_TREE
> >  	select HAVE_KVM_PM_NOTIFIER if PM
> > +	select MEMFD_OPS
> 
> MEMFD_OPS is a weird Kconfig name given that it's not just memfd() that can
> implement the ops.
> 
> >  	help
> >  	  Support hosting fully virtualized guest machines using hardware
> >  	  virtualization extensions.  You will need a fairly recent
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 3bd875f9669f..21f8b1880723 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -806,6 +806,12 @@ static inline void kvm_irqfd_exit(void)
> >  {
> >  }
> >  #endif
> > +
> > +int kvm_memfd_register(struct kvm *kvm, struct kvm_memory_slot *slot);
> > +void kvm_memfd_unregister(struct kvm_memory_slot *slot);
> > +long kvm_memfd_get_pfn(struct kvm_memory_slot *slot, gfn_t gfn, int *order);
> > +void kvm_memfd_put_pfn(kvm_pfn_t pfn);
> > +
> >  int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
> >  		  struct module *module);
> >  void kvm_exit(void);
> > diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
> > index ffdcad3cc97a..8842128d8429 100644
> > --- a/virt/kvm/Makefile.kvm
> > +++ b/virt/kvm/Makefile.kvm
> > @@ -5,7 +5,7 @@
> >  
> >  KVM ?= ../../../virt/kvm
> >  
> > -kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
> > +kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o $(KVM)/memfd.o
> 
> This should be
> 
>    kvm-$(CONFIG_MEMFD_OPS) += $(KVM)/memfd.o
> 
> with stubs provided in a header file as needed.  I also really dislike naming KVM's
> file memfd.c, though I don't have a good alternative off the top of my head.
> 
> >  kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
> >  kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
> >  kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
> 
> 
> > +#ifdef CONFIG_MEMFD_OPS
> > +static const struct memfd_pfn_ops *memfd_ops;
> 
> memfd_ops needs to be associated with the slot, e.g. userspace should be able to
> map multiple types of a backing stores into a single VM.

I considered this but gave up as I'm not so confident that we will
support other memory backends than memfd in the forthcoming future. 

>This doesn't even allow
> that for multiple VMs, and there are all kinds of ordering issues.

Current memfd kAPI actually returns the same set of callback pointer for
all the VMs. It supports multiple VMs via callback parameter inode,
assume one inode can be associated with only one VM.

> 
> > +void kvm_memfd_unregister(struct kvm_memory_slot *slot)
> > +{
> > +#ifdef CONFIG_MEMFD_OPS
> > +	if (slot->file) {
> > +		fput(slot->file);
> 
> Needs to actually unregister.

Good catch, thanks.
> 
> > +		slot->file = NULL;
> > +	}
> > +#endif
> > +}
> > -- 
> > 2.17.1
> > 
