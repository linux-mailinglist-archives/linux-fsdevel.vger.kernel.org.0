Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C67484E02
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 07:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiAEGJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 01:09:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:59367 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbiAEGJ7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641362999; x=1672898999;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=neMYafxOw6RMBRe+E68I7vpqrbUkO5bFR8JYJ2KBVLo=;
  b=E+a2Ke4ba5LzzvVmnOgpw2dIuQg7kkWap8xK/vcFc6q1cXgNye97cqmt
   Pu21n/J0vytRy7/T2BZvd7mL/KAvUISjP7F0FRqx1pQkLvxYKIO5/7fgj
   6eEBCYHLU69PdpNlrrgR6/HDY91BqC5jN5h+eNTttKqRnw7s80T8pVdGt
   nQ5onFYiEI3pMDlWkS8uhIKrJEHefPGmj9NC5nigWzyzIMtWXylJujrex
   xQFS/qrk0RaOjNVHV+HXjQc+I1B6Bv7Un0vTqw0e6ZUGLe3ebd7Dd041U
   WICGdmIRvE3hBaJmIR5QfXPlCgqL3jF4H4CL1B5+bwNWadnCjSmbF0X4n
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242174797"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242174797"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 22:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="526380386"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2022 22:09:52 -0800
Date:   Wed, 5 Jan 2022 14:09:18 +0800
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
Message-ID: <20220105060918.GB25009@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-6-chao.p.peng@linux.intel.com>
 <YcS5uStTallwRs0G@google.com>
 <20211224035418.GA43608@chaop.bj.intel.com>
 <YcuGGCo5pR31GkZE@google.com>
 <20211231022636.GA7025@chaop.bj.intel.com>
 <YdSHViDXGkjz5t/Q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdSHViDXGkjz5t/Q@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 05:43:50PM +0000, Sean Christopherson wrote:
> On Fri, Dec 31, 2021, Chao Peng wrote:
> > On Tue, Dec 28, 2021 at 09:48:08PM +0000, Sean Christopherson wrote:
> > >KVM handles
> > > reverse engineering the memslot to get the offset and whatever else it needs.
> > > notify_fallocate() and other callbacks are unchanged, though they probably can
> > > drop the inode.
> > > 
> > > E.g. likely with bad math and handwaving on the overlap detection:
> > > 
> > > int kvm_private_fd_fallocate_range(void *owner, pgoff_t start, pgoff_t end)
> > > {
> > > 	struct kvm_memory_slot *slot = owner;
> > > 	struct kvm_gfn_range gfn_range = {
> > > 		.slot	   = slot,
> > > 		.start	   = (start - slot->private_offset) >> PAGE_SHIFT,
> > > 		.end	   = (end - slot->private_offset) >> PAGE_SHIFT,
> > > 		.may_block = true,
> > > 	};
> > > 
> > > 	if (!has_overlap(slot, start, end))
> > > 		return 0;
> > > 
> > > 	gfn_range.end = min(gfn_range.end, slot->base_gfn + slot->npages);
> > > 
> > > 	kvm_unmap_gfn_range(slot->kvm, &gfn_range);
> > > 	return 0;
> > > }
> > 
> > I understand this KVM side handling, but again one fd can have multiple
> > memslots. How shmem decides to notify which memslot from a list of
> > memslots when it invokes the notify_fallocate()? Or just notify all
> > the possible memslots then let KVM to check? 
> 
> Heh, yeah, those are the two choices.  :-)
> 
> Either the backing store needs to support registering callbacks for specific,
> arbitrary ranges, or it needs to invoke all registered callbacks.  Invoking all
> callbacks has my vote; it's much simpler to implement and is unlikely to incur
> meaningful overhead.  _Something_ has to find the overlapping ranges, that cost
> doesn't magically go away if it's pushed into the backing store.
> 
> Note, invoking all notifiers is also aligned with the mmu_notifier behavior.

Sounds a good reason. Then shmem side only needs to maintain a list of
users.

Chao
