Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4166F48646C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 13:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiAFMgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 07:36:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:65187 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238831AbiAFMgM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641472572; x=1673008572;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=xyua25iDh4JWOKyPASiZgoHVEXaKTA4j0IhBTE9lILI=;
  b=g+0JuRYd3cvHmhaptbjo7EJrh69Uvxx17AHslnGcPNRxmLPhV7E+dZky
   Du6Q+wFJCouB+KxR5k4/2/Cl9mTU0FGk7mOdGxwjFz7nIUzLmHmWD9uvW
   m1BeAebZns8LrXLovnJc/L2qfzZi1FubXzdxM9cIEBew27ug+t8s413Jl
   eiiJ+o6eNa9ATgX+/4Elbw95lNTzTfKXN6EBgkdGLN2+qtP3EIJa1CRhd
   lDOaVqQoKVPqSX8XH47WKbfR0eK8lYJz7OK7BLpeRPyIAPkhYGEkyM7QI
   tPSrQdKq6CGAl+6Qak3WFQncqP3krlB/GSlWHzJDUfpntz077Wz0TMCh/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240196050"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="240196050"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 04:36:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="472880803"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga006.jf.intel.com with ESMTP; 06 Jan 2022 04:35:59 -0800
Date:   Thu, 6 Jan 2022 20:35:25 +0800
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
Subject: Re: [PATCH v3 kvm/queue 11/16] KVM: Add kvm_map_gfn_range
Message-ID: <20220106123525.GA43371@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-12-chao.p.peng@linux.intel.com>
 <YcS6m9CieYaIGA3F@google.com>
 <20211224041351.GB44042@chaop.bj.intel.com>
 <20211231023334.GA7255@chaop.bj.intel.com>
 <YdSEcknuErGe0gQa@google.com>
 <20220105061410.GA25283@chaop.bj.intel.com>
 <YdXPW+2hZDsgZD/a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdXPW+2hZDsgZD/a@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 05:03:23PM +0000, Sean Christopherson wrote:
> On Wed, Jan 05, 2022, Chao Peng wrote:
> > On Tue, Jan 04, 2022 at 05:31:30PM +0000, Sean Christopherson wrote:
> > > On Fri, Dec 31, 2021, Chao Peng wrote:
> > > > On Fri, Dec 24, 2021 at 12:13:51PM +0800, Chao Peng wrote:
> > > > > On Thu, Dec 23, 2021 at 06:06:19PM +0000, Sean Christopherson wrote:
> > > > > > On Thu, Dec 23, 2021, Chao Peng wrote:
> > > > > > > This new function establishes the mapping in KVM page tables for a
> > > > > > > given gfn range. It can be used in the memory fallocate callback for
> > > > > > > memfd based memory to establish the mapping for KVM secondary MMU when
> > > > > > > the pages are allocated in the memory backend.
> > > > > > 
> > > > > > NAK, under no circumstance should KVM install SPTEs in response to allocating
> > > > > > memory in a file.   The correct thing to do is to invalidate the gfn range
> > > > > > associated with the newly mapped range, i.e. wipe out any shared SPTEs associated
> > > > > > with the memslot.
> > > > > 
> > > > > Right, thanks.
> > > > 
> > > > BTW, I think the current fallocate() callback is just useless as long as
> > > > we don't want to install KVM SPTEs in response to allocating memory in a
> > > > file. The invalidation of the shared SPTEs should be notified through 
> > > > mmu_notifier of the shared memory backend, not memfd_notifier of the
> > > > private memory backend.
> > > 
> > > No, because the private fd is the final source of truth as to whether or not a
> > > GPA is private, e.g. userspace may choose to not unmap the shared backing.
> > > KVM's rule per Paolo's/this proposoal is that a GPA is private if it has a private
> > > memslot and is present in the private backing store.  And the other core rule is
> > > that KVM must never map both the private and shared variants of a GPA into the
> > > guest.
> > 
> > That's true, but I'm wondering if zapping the shared variant can be
> > handled at the time when the private one gets mapped in the KVM page
> > fault. No bothering the backing store to dedicate a callback to tell
> > KVM.
> 
> Hmm, I don't think that would work for the TDP MMU due to page faults taking
> mmu_lock for read.  E.g. if two vCPUs concurrently fault in both the shared and
> private variants, a race could exist where the private page fault sees the gfn
> as private and the shared page fault sees it as shared.  In that case, both faults
> will install a SPTE and KVM would end up running with both variants mapped into the
> guest.
> 
> There's also a performance penalty, as KVM would need to walk the shared EPT tree
> on every private page fault.

Make sense.

Thanks,
Chao
