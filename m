Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC424F973B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 15:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiDHNtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 09:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbiDHNtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:49:06 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B6EECDB2;
        Fri,  8 Apr 2022 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649425621; x=1680961621;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Z2KoO20U5Gou3STOQQVbT5tvwIoJoZ5aoHHnzZT/K3Y=;
  b=lnGV7cx3CcSc5Tu8yNYSycT8snaDKM1NRA++nIJD8GQdPQSjWmBPG/Lk
   sa5pO9+DQybtJj9KxYhuuS62+mC96IZcFH3PG2pnJJsg+IytU+J4IgyGY
   wWygylp9bfl+0zqlGF36Qr3gPvY7TsNRWORWNJ3ddkPwpD4QRdltfRYJd
   3S2IApXEtDGitCaVKu9qZWOQCjMbGaPN+YGkuaqb3kEdMQPftx6Xe+1q+
   7Gjz6rKYuWdD4t4uCTfSNaBKYXsPgxpWwpWSujld66RZS3QeqvJFE7M6b
   vKegfmJA2YfYOSWwiLgsWVl4U7KKsm1sCUZC4Oy0b8OXuizPZajsm+iv4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="322283260"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322283260"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:47:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="698187600"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2022 06:46:52 -0700
Date:   Fri, 8 Apr 2022 21:46:41 +0800
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
Message-ID: <20220408134641.GD57095@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-6-chao.p.peng@linux.intel.com>
 <YkIvEeC3/lgKTLPt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkIvEeC3/lgKTLPt@google.com>
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

On Mon, Mar 28, 2022 at 09:56:33PM +0000, Sean Christopherson wrote:
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
> 
> Peeking ahead, the partial switch to the _ext variant is rather gross.  I would
> prefer that KVM use an entirely different, but binary compatible, struct internally.
> And once the kernel supports C11[*], I'm pretty sure we can make the "region" in
> _ext an anonymous struct, and make KVM's internal struct a #define of _ext.  That
> should minimize the churn (no need to get the embedded "region" field), reduce
> line lengths, and avoid confusion due to some flows taking the _ext but others
> dealing with only the "base" struct.

Will try that.

> 
> Maybe kvm_user_memory_region or kvm_user_mem_region?  Though it's tempting to be
> evil and usurp the old kvm_memory_region :-)
> 
> E.g. pre-C11 do
> 
> struct kvm_userspace_memory_region_ext {
> 	struct kvm_userspace_memory_region region;
> 	__u64 private_offset;
> 	__u32 private_fd;
> 	__u32 padding[5];
> };
> 
> #ifdef __KERNEL__
> struct kvm_user_mem_region {
> 	__u32 slot;
> 	__u32 flags;
> 	__u64 guest_phys_addr;
> 	__u64 memory_size; /* bytes */
> 	__u64 userspace_addr; /* start of the userspace allocated memory */
> 	__u64 private_offset;
> 	__u32 private_fd;
> 	__u32 padding[5];
> };
> #endif
> 
> and then post-C11 do
> 
> struct kvm_userspace_memory_region_ext {
> #ifdef __KERNEL__

Is this #ifndef? As I think anonymous struct is only for kernel?

Thanks,
Chao

> 	struct kvm_userspace_memory_region region;
> #else
> 	struct kvm_userspace_memory_region;
> #endif
> 	__u64 private_offset;
> 	__u32 private_fd;
> 	__u32 padding[5];
> };
> 
> #ifdef __KERNEL__
> #define kvm_user_mem_region kvm_userspace_memory_region_ext
> #endif
> 
> [*] https://lore.kernel.org/all/20220301145233.3689119-1-arnd@kernel.org
> 
> > +	__u64 private_offset;
> > +	__u32 private_fd;
> > +	__u32 padding[5];
> > +};
