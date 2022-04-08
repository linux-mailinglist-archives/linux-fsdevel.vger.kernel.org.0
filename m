Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50AC4F9693
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 15:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbiDHNXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 09:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiDHNX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:23:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8542625;
        Fri,  8 Apr 2022 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649424085; x=1680960085;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=yJ+a09qZfU8xn/sBjF/pizQ4GwvK+1hMB8dFu0xFHhY=;
  b=dks3rhWdqhN/8km+lLvg+eDM2BEZZbK2H3s8q69OoCP/q4UV0f+eQPOZ
   Km6RYRfbgCVECMao6ld7j5xW8JgV4XnWNJBux8jvNV5eadub/IbKKbt8S
   jJmKbZIY3yhs28LczHnujpMIyJA3QXJi4zDBJotXcmRx8rJGukYRZ0tkJ
   +VIYmbrYNj7wPbCWYDGQS1q9/x3rOt2iCVpJv8Zp0y9htysN22sieR6IK
   ndCd5euthEGR8dMpHCxOHuk/dLwEtT8ltxzWspjIunKla607T2WQWVjYn
   yWTLuZw1WdZ6CVvrfe8x+D/Vcr17yN+afyO3kAAmd028abI3x/H97Hd6R
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261582622"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261582622"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="571485977"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 08 Apr 2022 06:21:16 -0700
Date:   Fri, 8 Apr 2022 21:21:05 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 05/13] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20220408132105.GC57095@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-6-chao.p.peng@linux.intel.com>
 <YkIoRDNbwJH/IDeC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkIoRDNbwJH/IDeC@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 28, 2022 at 09:27:32PM +0000, Sean Christopherson wrote:
> On Thu, Mar 10, 2022, Chao Peng wrote:
> > Extend the memslot definition to provide fd-based private memory support
> > by adding two new fields (private_fd/private_offset). The memslot then
> > can maintain memory for both shared pages and private pages in a single
> > memslot. Shared pages are provided by existing userspace_addr(hva) field
> > and private pages are provided through the new private_fd/private_offset
> > fields.
> > 
> > Since there is no 'hva' concept anymore for private memory so we cannot
> > rely on get_user_pages() to get a pfn, instead we use the newly added
> > memfile_notifier to complete the same job.
> > 
> > This new extension is indicated by a new flag KVM_MEM_PRIVATE.
> > 
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> 
> Needs a Co-developed-by: for Yu, or a From: if Yu is the sole author.

Yes a Co-developed-by for Yu is needed, for all the patches throught the series.

> 
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  Documentation/virt/kvm/api.rst | 37 +++++++++++++++++++++++++++-------
> >  include/linux/kvm_host.h       |  7 +++++++
> >  include/uapi/linux/kvm.h       |  8 ++++++++
> >  3 files changed, 45 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index 3acbf4d263a5..f76ac598606c 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -1307,7 +1307,7 @@ yet and must be cleared on entry.
> >  :Capability: KVM_CAP_USER_MEMORY
> >  :Architectures: all
> >  :Type: vm ioctl
> > -:Parameters: struct kvm_userspace_memory_region (in)
> > +:Parameters: struct kvm_userspace_memory_region(_ext) (in)
> >  :Returns: 0 on success, -1 on error
> >  
> >  ::
> > @@ -1320,9 +1320,17 @@ yet and must be cleared on entry.
> >  	__u64 userspace_addr; /* start of the userspace allocated memory */
> >    };
> >  
> > +  struct kvm_userspace_memory_region_ext {
> > +	struct kvm_userspace_memory_region region;
> > +	__u64 private_offset;
> > +	__u32 private_fd;
> > +	__u32 padding[5];
> 
> Uber nit, I'd prefer we pad u32 for private_fd separate from padding the size of
> the structure for future expansion.
> 
> Regarding future expansion, any reason not to go crazy and pad like 128+ bytes?
> It'd be rather embarassing if the next memslot extension needs 3 u64s and we end
> up with region_ext2 :-)

OK, so maybe:
	__u64 private_offset;
	__u32 private_fd;
	__u32 pad1;
	__u32 pad2[28];
> 
> > +};
> > +
> >    /* for kvm_memory_region::flags */
> >    #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
> >    #define KVM_MEM_READONLY	(1UL << 1)
> > +  #define KVM_MEM_PRIVATE		(1UL << 2)
> >  
> >  This ioctl allows the user to create, modify or delete a guest physical
> >  memory slot.  Bits 0-15 of "slot" specify the slot id and this value
> 
> ...
> 
> > +static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
> 
> I 100% think we should usurp the name "private" for these memslots, but as prep
> work this series should first rename KVM_PRIVATE_MEM_SLOTS to avoid confusion.
> Maybe KVM_INTERNAL_MEM_SLOTS?

Oh, I didn't realized 'PRIVATE' is already taken.  KVM_INTERNAL_MEM_SLOTS
sounds good.

Thanks,
Chao
