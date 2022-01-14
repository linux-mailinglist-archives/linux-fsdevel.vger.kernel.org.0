Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D65A48E40F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jan 2022 07:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbiANGK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jan 2022 01:10:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:41075 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234997AbiANGK7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642140659; x=1673676659;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=vFkrUx7JlBhH8tQHdr680ZVtcCkoqOiY56p9j5M74UM=;
  b=cjaPPKNK9hWLEikc2M+MeiR/Nr8cD17Ly/AEtI2UV2rh7b9Lw6QF0VXh
   MsaPvYPVsmV1o5dwpVk/mq9tAYDHSw2RVyoZQb7U25rq+amiBnVeVKDQg
   wozjzPLjV2ag33t6B+bBEroy8M9NYD/w9prrVdrcaDjQBGYXs0YgIk8ud
   AgfozJJXcnwo45gRPCZDprUYeGv2SND92NNb9py5gRWW727VJAn2luT7m
   T9WBI2S0FYYjdJN71zLM2A79TRavcNTlQqfPguJ1bNoTQROvzqKmDbmAh
   q1a70HqKWOWRYh4fhURXzksbsEJR2hcSASGcmjjDI9YynIA2xnFroEomL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="241751127"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="241751127"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 22:10:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="559370934"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 22:10:52 -0800
Date:   Fri, 14 Jan 2022 13:53:15 +0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v3 kvm/queue 14/16] KVM: Handle page fault for private
 memory
Message-ID: <20220114055315.GA29165@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-15-chao.p.peng@linux.intel.com>
 <20220104014629.GA2330@yzhao56-desk.sh.intel.com>
 <20220104091008.GA21806@chaop.bj.intel.com>
 <20220104100612.GA19947@yzhao56-desk.sh.intel.com>
 <20220105062810.GB25283@chaop.bj.intel.com>
 <20220105075356.GB19947@yzhao56-desk.sh.intel.com>
 <YdYFFzlPTvgFdSXL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdYFFzlPTvgFdSXL@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi Sean,
Sorry for the late reply. I just saw this mail in my mailbox.

On Wed, Jan 05, 2022 at 08:52:39PM +0000, Sean Christopherson wrote:
> On Wed, Jan 05, 2022, Yan Zhao wrote:
> > Sorry, maybe I didn't express it clearly.
> > 
> > As in the kvm_faultin_pfn_private(), 
> > static bool kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> > 				    struct kvm_page_fault *fault,
> > 				    bool *is_private_pfn, int *r)
> > {
> > 	int order;
> > 	int mem_convert_type;
> > 	struct kvm_memory_slot *slot = fault->slot;
> > 	long pfn = kvm_memfd_get_pfn(slot, fault->gfn, &order);
> > 	...
> > }
> > Currently, kvm_memfd_get_pfn() is called unconditionally.
> > However, if the backend of a private memslot is not memfd, and is device
> > fd for example, a different xxx_get_pfn() is required here.
> 
> Ya, I've complained about this in a different thread[*].  This should really be
> something like kvm_private_fd_get_pfn(), where the underlying ops struct can point
> at any compatible backing store.
> 
> https://lore.kernel.org/all/YcuMUemyBXFYyxCC@google.com/
>
ok. 

> > Further, though mapped to a private gfn, it might be ok for QEMU to
> > access the device fd in hva-based way (or call it MMU access way, e.g.
> > read/write/mmap), it's desired that it could use the traditional to get
> > pfn without convert the range to a shared one.
> 
> No, this is expressly forbidden.  The backing store for a private gfn must not
> be accessible by userspace.  It's possible a backing store could support both, but
> not concurrently, and any conversion must be done without KVM being involved.
> In other words, resolving a private gfn must either succeed or fail (exit to
> userspace), KVM cannot initiate any conversions.
>
When it comes to a device passthrough via VFIO, there might be more work
related to the device fd as a backend.

First, unlike memfd which can allocate one private fd for a set of PFNs,
and one shared fd for another set of PFNs, for device fd, it needs to open
the same physical device twice, one for shared fd, and one for private fd.

Then, for private device fd, now its ramblock has to use qemu_ram_alloc_from_fd()
instead of current qemu_ram_alloc_from_ptr().
And as in VFIO, this private fd is shared by several ramblocks (each locating from
a different base offset), the base offsets also need to be kept somewhere 
in order to call get_pfn successfully. (this info is kept in
vma through mmap() previously, so without mmap(), a new interface might
be required). 

Also, for shared device fd,  mmap() is required in order to allocate the
ramblock with qemu_ram_alloc_from_ptr(), and more importantly to make
the future gfn_to_hva, and hva_to_pfn possible.
But as the shared and private fds are based on the same physical device,
the vfio driver needs to record which vma ranges are allowed for the actual
mmap_fault, which vma area are not.

With the above changes, it only prevents the host user space from accessing
the device mapped to private GFNs.
For memory backends, host kernel space accessing is prevented via MKTME.
And for device, the device needs to the work to disallow host kernel
space access.
However, unlike memory side, the device side would not cause any MCE. 
Thereby, host user space access to the device also would not cause MCEs, either. 

So, I'm not sure if the above work is worthwhile to the device fd.


> > pfn = __gfn_to_pfn_memslot(slot, fault->gfn, ...)
> > 	|->addr = __gfn_to_hva_many (slot, gfn,...)
> > 	|  pfn = hva_to_pfn (addr,...)
> > 
> > 
> > So, is it possible to recognize such kind of backends in KVM, and to get
> > the pfn in traditional way without converting them to shared?
> > e.g.
> > - specify KVM_MEM_PRIVATE_NONPROTECT to memory regions with such kind
> > of backends, or
> > - detect the fd type and check if get_pfn is provided. if no, go the
> >   traditional way.
> 
> No, because the whole point of this is to make guest private memory inaccessible
> to host userspace.  Or did I misinterpret your questions?
I think the host unmap series is based on the assumption that host user
space access to the memory based to private guest GFNs would cause fatal
MCEs.
So, I hope for backends who will not bring this fatal error can keep
using traditional way to get pfn and be mapped to private GFNs at the
same time.

Thanks
Yan
