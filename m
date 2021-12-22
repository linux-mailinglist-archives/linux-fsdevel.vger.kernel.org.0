Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A930847CAB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Dec 2021 02:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbhLVBXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 20:23:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:32526 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234213AbhLVBXJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640136189; x=1671672189;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=soai/pmfaSqocLc0zgIUXqg4L+dRY+Q0ibdRNh+8JpM=;
  b=MDX1v/gFkcqRXhrIBBknWseLYvpOYRiWsAcnhDaPBejDJQNuKGHAMesf
   sjsHfFvAH4SLzzQHRLWmxRk9Ey0eFAb48EE00z3neHWBoCJv13l3aVn97
   U1ByIEliLUYGUdWMhEqMnlssHo+/qiGhlwkgHklJUJBZ6lBydw7vclyB6
   +kf/Ko+j7ZCQhpaZ0qVBu8/1iDrq5KrpF7/Ggyv4cgfPh/7ihH8j9/Jk3
   bOAR+pz/bViAi8f6XdPfGf4/zldp8+GBFonPkz1F3s8+nvjPZepAMUg57
   abgTvo1cNqJ8Umen20kyid4oSAvL60ecsANVjDeSeah2OPZtkBgZjSZcy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="227372590"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="227372590"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 17:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="521477368"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 21 Dec 2021 17:23:01 -0800
Date:   Wed, 22 Dec 2021 09:22:23 +0800
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
Subject: Re: [PATCH v3 00/15] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20211222012223.GA22448@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
 <YcH2aGNJn57pLihJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcH2aGNJn57pLihJ@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 03:44:40PM +0000, Sean Christopherson wrote:
> On Tue, Dec 21, 2021, Chao Peng wrote:
> > This is the third version of this series which try to implement the
> > fd-based KVM guest private memory.
> 
> ...
> 
> > Test
> > ----
> > This code has been tested with latest TDX code patches hosted at
> > (https://github.com/intel/tdx/tree/kvm-upstream) with minimal TDX
> > adaption and QEMU support.
> > 
> > Example QEMU command line:
> > -object tdx-guest,id=tdx \
> > -object memory-backend-memfd-private,id=ram1,size=2G \
> > -machine q35,kvm-type=tdx,pic=no,kernel_irqchip=split,memory-encryption=tdx,memory-backend=ram1
> > 
> > Changelog
> > ----------
> > v3:
> >   - Added locking protection when calling
> >     invalidate_page_range/fallocate callbacks.
> >   - Changed memslot structure to keep use useraddr for shared memory.
> >   - Re-organized F_SEAL_INACCESSIBLE and MEMFD_OPS.
> >   - Added MFD_INACCESSIBLE flag to force F_SEAL_INACCESSIBLE.
> >   - Commit message improvement.
> >   - Many small fixes for comments from the last version.
> 
> Can you rebase on top of kvm/queue and send a new version?  There's a massive
> overhaul of KVM's memslots code that's queued for 5.17, and the KVM core changes
> in this series conflict mightily.

Sure, will do the rebase and send a new version.

> 
> It's ok if the private memslot support isn't tested exactly as-is, it's not like
> any of us reviewers can test it anyways, but I would like to be able to apply
> cleanly and verify that the series doesn't break existing functionality.

Good, it will ease me if that is acceptable (e.g. test on the relative
new TDX codebase but send out the patch on latest kvm/queue which is not
verified for the new function). This gets rid of the 'chicken and egg'
dependency between this series and TDX patchset.

> 
> This version also appears to be based on an internal development branch, e.g. patch
> 12/15 has some bits from the TDX series.

Right, it's based on latest TDX code https://github.com/intel/tdx/tree/kvm-upstream.
I did this because this is the only way I can test the code. 

Thanks,
Chao
> 
> @@ -336,6 +348,7 @@ struct kvm_tdx_exit {
>  #define KVM_EXIT_X86_BUS_LOCK     33
>  #define KVM_EXIT_XEN              34
>  #define KVM_EXIT_RISCV_SBI        35
> +#define KVM_EXIT_MEMORY_ERROR     36
>  #define KVM_EXIT_TDX              50   /* dump number to avoid conflict. */
> 
>  /* For KVM_EXIT_INTERNAL_ERROR */
> @@ -554,6 +567,8 @@ struct kvm_run {
>                         unsigned long args[6];
>                         unsigned long ret[2];
>                 } riscv_sbi;
> +               /* KVM_EXIT_MEMORY_ERROR */
> +               struct kvm_memory_exit mem;
>                 /* KVM_EXIT_TDX_VMCALL */
>                 struct kvm_tdx_exit tdx;
>                 /* Fix the size of the union. */
