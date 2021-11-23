Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355FD45A595
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 15:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbhKWO2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 09:28:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:64722 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237624AbhKWO2X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:28:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="321261534"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="321261534"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 06:25:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509427091"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 06:25:06 -0800
Date:   Tue, 23 Nov 2021 22:24:20 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Jonathan Corbet <corbet@lwn.net>,
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
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [RFC v2 PATCH 09/13] KVM: Introduce kvm_memfd_invalidate_range
Message-ID: <20211123142420.GB32088@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-10-chao.p.peng@linux.intel.com>
 <4041d98a-23df-e9ed-b245-5edd7151fec5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4041d98a-23df-e9ed-b245-5edd7151fec5@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 09:46:34AM +0100, Paolo Bonzini wrote:
> On 11/19/21 14:47, Chao Peng wrote:
> > +
> > +	/* Prevent memslot modification */
> > +	spin_lock(&kvm->mn_invalidate_lock);
> > +	kvm->mn_active_invalidate_count++;
> > +	spin_unlock(&kvm->mn_invalidate_lock);
> > +
> > +	ret = __kvm_handle_useraddr_range(kvm, &useraddr_range);
> > +
> > +	spin_lock(&kvm->mn_invalidate_lock);
> > +	kvm->mn_active_invalidate_count--;
> > +	spin_unlock(&kvm->mn_invalidate_lock);
> > +
> 
> 
> You need to follow this with a rcuwait_wake_up as in
> kvm_mmu_notifier_invalidate_range_end.

Oh right.

> 
> It's probably best if you move the manipulations of
> mn_active_invalidate_count from kvm_mmu_notifier_invalidate_range_* to two
> separate functions.

Will do.

> 
> Paolo
