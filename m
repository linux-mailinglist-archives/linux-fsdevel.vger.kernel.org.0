Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A468484E1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 07:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiAEGPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 01:15:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:54822 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237759AbiAEGOy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641363294; x=1672899294;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=PVXfD4lgNSvF8Z6c3fwn5orJ3LA4pnhr3MXcpa5GxpM=;
  b=LNnjLIv1Y4sQkevOHxQKyLETFfcT7R2OocYM8lFG5A2Oh3s6idMRpoyT
   pSg3vTAD9UC5lmf18mn3SDXO+FIgo2I3xn26C4PdhgbHKHmo+WpCxz9B0
   dzwwo7JID5guBZeOCNCXlE3YaJ3HKUiRSlXL00vDxZTNUPhHLT6zqKLUR
   QXgeb6fwkYrVLHTwHWpYrwvCdvK2Y26dWoJZ+jnoQI3V9vqwwMmRJJA9b
   +vaX3PYD+/FMD9j506/fAO9VVb2nw5eP/kmjxPWwVp9/6qb3UndkWSPBE
   1HcHHN2T/COYczv7tShHSYL39lD83W+GbU82G19eXkehjq7KKrT9g3zfW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242335407"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242335407"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 22:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="526381831"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2022 22:14:44 -0800
Date:   Wed, 5 Jan 2022 14:14:10 +0800
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
Message-ID: <20220105061410.GA25283@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-12-chao.p.peng@linux.intel.com>
 <YcS6m9CieYaIGA3F@google.com>
 <20211224041351.GB44042@chaop.bj.intel.com>
 <20211231023334.GA7255@chaop.bj.intel.com>
 <YdSEcknuErGe0gQa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdSEcknuErGe0gQa@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 05:31:30PM +0000, Sean Christopherson wrote:
> On Fri, Dec 31, 2021, Chao Peng wrote:
> > On Fri, Dec 24, 2021 at 12:13:51PM +0800, Chao Peng wrote:
> > > On Thu, Dec 23, 2021 at 06:06:19PM +0000, Sean Christopherson wrote:
> > > > On Thu, Dec 23, 2021, Chao Peng wrote:
> > > > > This new function establishes the mapping in KVM page tables for a
> > > > > given gfn range. It can be used in the memory fallocate callback for
> > > > > memfd based memory to establish the mapping for KVM secondary MMU when
> > > > > the pages are allocated in the memory backend.
> > > > 
> > > > NAK, under no circumstance should KVM install SPTEs in response to allocating
> > > > memory in a file.   The correct thing to do is to invalidate the gfn range
> > > > associated with the newly mapped range, i.e. wipe out any shared SPTEs associated
> > > > with the memslot.
> > > 
> > > Right, thanks.
> > 
> > BTW, I think the current fallocate() callback is just useless as long as
> > we don't want to install KVM SPTEs in response to allocating memory in a
> > file. The invalidation of the shared SPTEs should be notified through 
> > mmu_notifier of the shared memory backend, not memfd_notifier of the
> > private memory backend.
> 
> No, because the private fd is the final source of truth as to whether or not a
> GPA is private, e.g. userspace may choose to not unmap the shared backing.
> KVM's rule per Paolo's/this proposoal is that a GPA is private if it has a private
> memslot and is present in the private backing store.  And the other core rule is
> that KVM must never map both the private and shared variants of a GPA into the
> guest.

That's true, but I'm wondering if zapping the shared variant can be
handled at the time when the private one gets mapped in the KVM page
fault. No bothering the backing store to dedicate a callback to tell
KVM.

Chao
