Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CAE47EAFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 04:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351196AbhLXDzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 22:55:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:58265 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235118AbhLXDzH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 22:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640318107; x=1671854107;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=WZb4+/Ks4LDsAyLJCQPSXmUGHI2zwvNb+vAIAemyck0=;
  b=cKHle3yh+8o6CmixL0k7IbmoSnC3lEGZXXfGcf1gpZJuQpGe2WhiLp6H
   NZ/JNQgUGWiDkOY3u8/eeEKbyqQb0IvJxvfdd65yrEMza0/+AMVV+iMa4
   gfVhdAkT3zep1Xt/kZ6a0I3RPFk7npCnQDgg6wML8dbQgu4sgSHgvwPRB
   WzgwTbjcMYB5kqSLrFrfFfPSsGflRA1SDoETF7KBA75mcykUaI2L1FD1J
   aSwiNUqwNMZKcO7Or4eTWBaUuONUbpxH0KAtW6tRudamz99r/Pd/3s15e
   3h1mk476F0Rvxil1dSMiqKqtKMb94vra7pq789vEaXFLKMZK/C7H2DA1k
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="241146822"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="241146822"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 19:55:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="607950579"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Dec 2021 19:54:56 -0800
Date:   Fri, 24 Dec 2021 11:54:18 +0800
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
Message-ID: <20211224035418.GA43608@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-6-chao.p.peng@linux.intel.com>
 <YcS5uStTallwRs0G@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcS5uStTallwRs0G@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 06:02:33PM +0000, Sean Christopherson wrote:
> On Thu, Dec 23, 2021, Chao Peng wrote:
> > Similar to hva_tree for hva range, maintain interval tree ofs_tree for
> > offset range of a fd-based memslot so the lookup by offset range can be
> > faster when memslot count is high.
> 
> This won't work.  The hva_tree relies on there being exactly one virtual address
> space, whereas with private memory, userspace can map multiple files into the
> guest at different gfns, but with overlapping offsets.

OK, that's the point.

> 
> I also dislike hijacking __kvm_handle_hva_range() in patch 07.
> 
> KVM also needs to disallow mapping the same file+offset into multiple gfns, which
> I don't see anywhere in this series.

This can be checked against file+offset overlapping with existing slots
when register a new one.

> 
> In other words, there needs to be a 1:1 gfn:file+offset mapping.  Since userspace
> likely wants to allocate a single file for guest private memory and map it into
> multiple discontiguous slots, e.g. to skip the PCI hole, the best idea off the top
> of my head would be to register the notifier on a per-slot basis, not a per-VM
> basis.  It would require a 'struct kvm *' in 'struct kvm_memory_slot', but that's
> not a huge deal.
> 
> That way, KVM's notifier callback already knows the memslot and can compute overlap
> between the memslot and the range by reversing the math done by kvm_memfd_get_pfn().
> Then, armed with the gfn and slot, invalidation is just a matter of constructing
> a struct kvm_gfn_range and invoking kvm_unmap_gfn_range().

KVM is easy but the kernel bits would be difficulty, it has to maintain
fd+offset to memslot mapping because one fd can have multiple memslots,
it need decide which memslot needs to be notified.

Thanks,
Chao
