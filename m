Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7445997F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 02:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhKWBKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 20:10:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:54361 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhKWBKl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 20:10:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="214950573"
X-IronPort-AV: E=Sophos;i="5.87,256,1631602800"; 
   d="scan'208";a="214950573"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 17:07:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,256,1631602800"; 
   d="scan'208";a="649751921"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2021 17:07:25 -0800
Date:   Tue, 23 Nov 2021 09:06:39 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wanpeng Li <wanpengli@tencent.com>, jun.nakajima@intel.com,
        kvm@vger.kernel.org, david@redhat.com, qemu-devel@nongnu.org,
        "J . Bruce Fields" <bfields@fieldses.org>, dave.hansen@intel.com,
        "H . Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Mattson <jmattson@google.com>, linux-mm@kvack.org,
        Sean Christopherson <seanjc@google.com>, susie.li@intel.com,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        john.ji@intel.com, Yu Zhang <yu.c.zhang@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC v2 PATCH 13/13] KVM: Enable memfd based page
 invalidation/fallocate
Message-ID: <20211123010639.GA32088@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-14-chao.p.peng@linux.intel.com>
 <20211122141647.3pcsywilrzcoqvbf@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122141647.3pcsywilrzcoqvbf@box.shutemov.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 05:16:47PM +0300, Kirill A. Shutemov wrote:
> On Fri, Nov 19, 2021 at 09:47:39PM +0800, Chao Peng wrote:
> > Since the memory backing store does not get notified when VM is
> > destroyed so need check if VM is still live in these callbacks.
> > 
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  virt/kvm/memfd.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/virt/kvm/memfd.c b/virt/kvm/memfd.c
> > index bd930dcb455f..bcfdc685ce22 100644
> > --- a/virt/kvm/memfd.c
> > +++ b/virt/kvm/memfd.c
> > @@ -12,16 +12,38 @@
> >  #include <linux/memfd.h>
> >  const static struct guest_mem_ops *memfd_ops;
> >  
> > +static bool vm_is_dead(struct kvm *vm)
> > +{
> > +	struct kvm *kvm;
> > +
> > +	list_for_each_entry(kvm, &vm_list, vm_list) {
> > +		if (kvm == vm)
> > +			return false;
> > +	}
> 
> I don't think this is enough. The struct kvm can be freed and re-allocated
> from the slab and this function will give false-negetive.

Right.

> 
> Maybe the kvm has to be tagged with a sequential id that incremented every
> allocation. This id can be checked here.

Sounds like a sequential id will be needed, no existing fields in struct
kvm can work for this.

> 
> > +
> > +	return true;
> > +}
> 
> -- 
>  Kirill A. Shutemov
