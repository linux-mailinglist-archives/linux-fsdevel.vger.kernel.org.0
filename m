Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6248E45A5BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 15:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbhKWOh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 09:37:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:26207 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhKWOh4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:37:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="215740373"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="215740373"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 06:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509430316"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 06:34:39 -0800
Date:   Tue, 23 Nov 2021 22:33:53 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Message-ID: <20211123143353.GD32088@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
 <6de78894-8269-ea3a-b4ee-a5cc4dad827e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6de78894-8269-ea3a-b4ee-a5cc4dad827e@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:06:02AM +0100, Paolo Bonzini wrote:
> On 11/19/21 16:39, David Hildenbrand wrote:
> > > If qmeu can put all the guest memory in a memfd and not map it, then
> > > I'd also like to see that the IOMMU can use this interface too so we
> > > can have VFIO working in this configuration.
> > 
> > In QEMU we usually want to (and must) be able to access guest memory
> > from user space, with the current design we wouldn't even be able to
> > temporarily mmap it -- which makes sense for encrypted memory only. The
> > corner case really is encrypted memory. So I don't think we'll see a
> > broad use of this feature outside of encrypted VMs in QEMU. I might be
> > wrong, most probably I am:)
> 
> It's not _that_ crazy an idea, but it's going to be some work to teach KVM
> that it has to kmap/kunmap around all memory accesses.
> 
> I think it's great that memfd hooks are usable by more than one subsystem,
> OTOH it's fair that whoever needs it does the work---and VFIO does not need
> it for confidential VMs, yet, so it should be fine for now to have a single
> user.
> 
> On the other hand, as I commented already, the lack of locking in the
> register/unregister functions has to be fixed even with a single user.
> Another thing we can do already is change the guest_ops/guest_mem_ops to
> something like memfd_falloc_notifier_ops/memfd_pfn_ops, and the
> register/unregister functions to memfd_register/unregister_falloc_notifier.

I'm satisified with this naming ;)

> 
> Chao, can you also put this under a new CONFIG such as "bool MEMFD_OPS", and
> select it from KVM?

Yes, reasonable.

> 
> Thanks,
> 
> Paolo
