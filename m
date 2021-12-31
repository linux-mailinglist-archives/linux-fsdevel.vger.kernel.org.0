Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001D848217E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 03:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbhLaC1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 21:27:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:14779 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhLaC1V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 21:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640917641; x=1672453641;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=GWTpTesJcb+925QqthMUbTz8/8tLtbXxt+lqNt52Aec=;
  b=AQ0+8iJghNMqDB+Y8FnQKy7cDdtA2gxWPiL+a0hND5hFQBzbwDoIixd2
   cRJCrITIh5/Scm5FtUJjF1nzyuk8u+flATutN9NatsBM/VGbjGaNSxET1
   KOWDJpt4ulYvXSoUQX2mRP6vvpNYlzZ5Ud4rw5g+j2hRljDuo+cE8YMk9
   d1SwOgE1pWiny72NaVsPPfX/KrdufVTiVkVBncTZN5011JsNta+OfwrcS
   R05uXzYaaNRHR2kLXgNmbDjbAnoxoJjMqWxyGBhlmI9yT6o3YUT/lXBF4
   DyMEru9SlYgBqkgbFRiJT2oceZuamHCkV6Ene+cqDDpQcOOF3QAlch+LT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="266011070"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="266011070"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 18:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="666705441"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2021 18:27:12 -0800
Date:   Fri, 31 Dec 2021 10:26:36 +0800
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
Subject: Re: [PATCH v3 kvm/queue 05/16] KVM: Maintain ofs_tree for fast
 memslot lookup by file offset
Message-ID: <20211231022636.GA7025@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-6-chao.p.peng@linux.intel.com>
 <YcS5uStTallwRs0G@google.com>
 <20211224035418.GA43608@chaop.bj.intel.com>
 <YcuGGCo5pR31GkZE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcuGGCo5pR31GkZE@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 28, 2021 at 09:48:08PM +0000, Sean Christopherson wrote:
> On Fri, Dec 24, 2021, Chao Peng wrote:
> > On Thu, Dec 23, 2021 at 06:02:33PM +0000, Sean Christopherson wrote:
> > > On Thu, Dec 23, 2021, Chao Peng wrote:
> > > 
> > > In other words, there needs to be a 1:1 gfn:file+offset mapping.  Since userspace
> > > likely wants to allocate a single file for guest private memory and map it into
> > > multiple discontiguous slots, e.g. to skip the PCI hole, the best idea off the top
> > > of my head would be to register the notifier on a per-slot basis, not a per-VM
> > > basis.  It would require a 'struct kvm *' in 'struct kvm_memory_slot', but that's
> > > not a huge deal.
> > > 
> > > That way, KVM's notifier callback already knows the memslot and can compute overlap
> > > between the memslot and the range by reversing the math done by kvm_memfd_get_pfn().
> > > Then, armed with the gfn and slot, invalidation is just a matter of constructing
> > > a struct kvm_gfn_range and invoking kvm_unmap_gfn_range().
> > 
> > KVM is easy but the kernel bits would be difficulty, it has to maintain
> > fd+offset to memslot mapping because one fd can have multiple memslots,
> > it need decide which memslot needs to be notified.
> 
> No, the kernel side maintains an opaque pointer like it does today,

But the opaque pointer will now become memslot, isn't it? That said,
kernel side should maintain a list of opaque pointer (memslot) instead
of one for each fd (inode) since a fd to memslot mapping is 1:M now.

>KVM handles
> reverse engineering the memslot to get the offset and whatever else it needs.
> notify_fallocate() and other callbacks are unchanged, though they probably can
> drop the inode.
> 
> E.g. likely with bad math and handwaving on the overlap detection:
> 
> int kvm_private_fd_fallocate_range(void *owner, pgoff_t start, pgoff_t end)
> {
> 	struct kvm_memory_slot *slot = owner;
> 	struct kvm_gfn_range gfn_range = {
> 		.slot	   = slot,
> 		.start	   = (start - slot->private_offset) >> PAGE_SHIFT,
> 		.end	   = (end - slot->private_offset) >> PAGE_SHIFT,
> 		.may_block = true,
> 	};
> 
> 	if (!has_overlap(slot, start, end))
> 		return 0;
> 
> 	gfn_range.end = min(gfn_range.end, slot->base_gfn + slot->npages);
> 
> 	kvm_unmap_gfn_range(slot->kvm, &gfn_range);
> 	return 0;
> }

I understand this KVM side handling, but again one fd can have multiple
memslots. How shmem decides to notify which memslot from a list of
memslots when it invokes the notify_fallocate()? Or just notify all
the possible memslots then let KVM to check? 

Thanks,
Chao
