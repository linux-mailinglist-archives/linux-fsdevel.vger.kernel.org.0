Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6456B482195
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 03:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbhLaCeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 21:34:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:24704 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237592AbhLaCeT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 21:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640918059; x=1672454059;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=3xgj6YPF/dL11Z/52845rvYXUsZ6jR0j7Y9+NOsvBzY=;
  b=E673iBEPfiETG4UJudFtRXdPEIG2QjOlhVs1izTPhy4O79QK0MLiUNmF
   QLG9FwmvTszTpqkl5a52gr/Y5ThMc3ZAMXQTVgaO1zH7+48m2HPrXRGb/
   6sK3Vro3InUz70cfwta4LNgXa1G4cZaAQ6QZealuXc6RlbHlrlIkrNtfI
   pXYq4NKwrUKVxR6uQBv7U9KHEIGVLiqLRhJz+0hDhtF1Xe/6owH0D+ieE
   vi+bOeA2gdlyT+DCmRjRW7Rd1MfYUTCIxJtX+c2LCfuaMdCSCcoFm/hNq
   +CK/ohQQUrkS0wBS7yRFxgaZLTiF5PCeYfFKzqUc/E6rYkMmHVg2aUg9b
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="241971104"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="241971104"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 18:34:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="666706992"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2021 18:34:10 -0800
Date:   Fri, 31 Dec 2021 10:33:34 +0800
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
Message-ID: <20211231023334.GA7255@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-12-chao.p.peng@linux.intel.com>
 <YcS6m9CieYaIGA3F@google.com>
 <20211224041351.GB44042@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224041351.GB44042@chaop.bj.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 24, 2021 at 12:13:51PM +0800, Chao Peng wrote:
> On Thu, Dec 23, 2021 at 06:06:19PM +0000, Sean Christopherson wrote:
> > On Thu, Dec 23, 2021, Chao Peng wrote:
> > > This new function establishes the mapping in KVM page tables for a
> > > given gfn range. It can be used in the memory fallocate callback for
> > > memfd based memory to establish the mapping for KVM secondary MMU when
> > > the pages are allocated in the memory backend.
> > 
> > NAK, under no circumstance should KVM install SPTEs in response to allocating
> > memory in a file.   The correct thing to do is to invalidate the gfn range
> > associated with the newly mapped range, i.e. wipe out any shared SPTEs associated
> > with the memslot.
> 
> Right, thanks.

BTW, I think the current fallocate() callback is just useless as long as
we don't want to install KVM SPTEs in response to allocating memory in a
file. The invalidation of the shared SPTEs should be notified through 
mmu_notifier of the shared memory backend, not memfd_notifier of the
private memory backend.

Thanks,
Chao
