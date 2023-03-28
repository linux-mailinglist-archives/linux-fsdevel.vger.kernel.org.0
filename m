Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A3F6CBCDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 12:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjC1KtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 06:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjC1KtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:49:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA6A1BC0;
        Tue, 28 Mar 2023 03:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680000550; x=1711536550;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=AseN6rlr5gwMYM5zhMJq+cjPxZAZKyFMZLKoTjj2S7w=;
  b=RUVD9MEmst1jITrfZs9/DT/PV0vpczqs7TuvEXdFcSBeNBtA1QtZtSBH
   qc2ws/fqgP85SX9IMZydBcISwuvlcAnbjl4MrqTcR9pXfydNGZPwg+SdO
   4r/UA/LT2U59icVUOuPhf/syfYSOteovi51yhUN43wW/FjmzWBdLS0Ccb
   24jYxM+QttAgeGaUvJqmjLHr9ISN4UHLKd5nupKb1UwUiMpUyo9StDVAD
   izlO/1hFMBp7ZUnPPSVrgu1uCuctztbjpUS79jg9D/cEpoMY7EDglbP5+
   x6geM7JCzPwk/EAp1dxCpsUXCtpS22GTmP2fHgYa7HA9pNyy+k0A1oXUl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="403144893"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="403144893"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:48:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="794757674"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="794757674"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2023 03:48:42 -0700
Date:   Tue, 28 Mar 2023 18:41:08 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Ackerley Tng <ackerleytng@google.com>, seanjc@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        pbonzini@redhat.com, corbet@lwn.net, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, arnd@arndb.de,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com, x86@kernel.org,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org, shuah@kernel.org,
        rppt@kernel.org, steven.price@arm.com, mail@maciej.szmigiero.name,
        vbabka@suse.cz, vannapurve@google.com, yu.c.zhang@linux.intel.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, qperret@google.com, tabba@google.com,
        michael.roth@amd.com, mhocko@suse.com, wei.w.wang@intel.com
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
Message-ID: <20230328104108.GB2909606@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20230128140030.GB700688@chaop.bj.intel.com>
 <diqz5ybc3xsr.fsf@ackerleytng-cloudtop.c.googlers.com>
 <20230308074026.GA2183207@chaop.bj.intel.com>
 <20230323004131.GA214881@ls.amr.corp.intel.com>
 <20230324021029.GA2774613@chaop.bj.intel.com>
 <6cf365a3-dddc-8b74-4d74-04666fbeb53d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf365a3-dddc-8b74-4d74-04666fbeb53d@intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:29:25AM +0800, Xiaoyao Li wrote:
> On 3/24/2023 10:10 AM, Chao Peng wrote:
> > On Wed, Mar 22, 2023 at 05:41:31PM -0700, Isaku Yamahata wrote:
> > > On Wed, Mar 08, 2023 at 03:40:26PM +0800,
> > > Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > > 
> > > > On Wed, Mar 08, 2023 at 12:13:24AM +0000, Ackerley Tng wrote:
> > > > > Chao Peng <chao.p.peng@linux.intel.com> writes:
> > > > > 
> > > > > > On Sat, Jan 14, 2023 at 12:01:01AM +0000, Sean Christopherson wrote:
> > > > > > > On Fri, Dec 02, 2022, Chao Peng wrote:
> > > > > > ...
> > > > > > > Strongly prefer to use similar logic to existing code that detects wraps:
> > > > > 
> > > > > > > 		mem->restricted_offset + mem->memory_size < mem->restricted_offset
> > > > > 
> > > > > > > This is also where I'd like to add the "gfn is aligned to offset"
> > > > > > > check, though
> > > > > > > my brain is too fried to figure that out right now.
> > > > > 
> > > > > > Used count_trailing_zeros() for this TODO, unsure we have other better
> > > > > > approach.
> > > > > 
> > > > > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > > > > index afc8c26fa652..fd34c5f7cd2f 100644
> > > > > > --- a/virt/kvm/kvm_main.c
> > > > > > +++ b/virt/kvm/kvm_main.c
> > > > > > @@ -56,6 +56,7 @@
> > > > > >    #include <asm/processor.h>
> > > > > >    #include <asm/ioctl.h>
> > > > > >    #include <linux/uaccess.h>
> > > > > > +#include <linux/count_zeros.h>
> > > > > 
> > > > > >    #include "coalesced_mmio.h"
> > > > > >    #include "async_pf.h"
> > > > > > @@ -2087,6 +2088,19 @@ static bool kvm_check_memslot_overlap(struct
> > > > > > kvm_memslots *slots, int id,
> > > > > >    	return false;
> > > > > >    }
> > > > > 
> > > > > > +/*
> > > > > > + * Return true when ALIGNMENT(offset) >= ALIGNMENT(gpa).
> > > > > > + */
> > > > > > +static bool kvm_check_rmem_offset_alignment(u64 offset, u64 gpa)
> > > > > > +{
> > > > > > +	if (!offset)
> > > > > > +		return true;
> > > > > > +	if (!gpa)
> > > > > > +		return false;
> > > > > > +
> > > > > > +	return !!(count_trailing_zeros(offset) >= count_trailing_zeros(gpa));
> > > 
> > > This check doesn't work expected. For example, offset = 2GB, gpa=4GB
> > > this check fails.
> > 
> > This case is expected to fail as Sean initially suggested[*]:
> >    I would rather reject memslot if the gfn has lesser alignment than
> >    the offset. I'm totally ok with this approach _if_ there's a use case.
> >    Until such a use case presents itself, I would rather be conservative
> >    from a uAPI perspective.
> > 
> > I understand that we put tighter restriction on this but if you see such
> > restriction is really a big issue for real usage, instead of a
> > theoretical problem, then we can loosen the check here. But at that time
> > below code is kind of x86 specific and may need improve.
> > 
> > BTW, in latest code, I replaced count_trailing_zeros() with fls64():
> >    return !!(fls64(offset) >= fls64(gpa));
> 
> wouldn't it be !!(ffs64(offset) <= ffs64(gpa)) ?

As the function document explains, here we want to return true when
ALIGNMENT(offset) >= ALIGNMENT(gpa), so '>=' is what we need.

It's worthy clarifying that in Sean's original suggestion he actually
mentioned the opposite. He said 'reject memslot if the gfn has lesser
alignment than the offset', but I wonder this is his purpose, since
if ALIGNMENT(offset) < ALIGNMENT(gpa), we wouldn't be possible to map
the page as largepage. Consider we have below config:

  gpa=2M, offset=1M

In this case KVM tries to map gpa at 2M as 2M hugepage but the physical
page at the offset(1M) in private_fd cannot provide the 2M page due to
misalignment.

But as we discussed in the off-list thread, here we do find a real use
case indicating this check is too strict. i.e. QEMU immediately fails
when launch a guest > 2G memory. For this case QEMU splits guest memory
space into two slots:

  Slot#1(ram_below_4G): gpa=0x0, offset=0x0, size=2G
  Slot#2(ram_above_4G): gpa=4G,  offset=2G,  size=totalsize-2G

This strict alignment check fails for slot#2 because offset(2G) has less
alignment than gpa(4G). To allow this, one solution can revert to my
previous change in kvm_alloc_memslot_metadata() to disallow hugepage
only when the offset/gpa are not aligned to related page size.

Sean, How do you think?

Chao
> 
> > [*] https://lore.kernel.org/all/Y8HldeHBrw+OOZVm@google.com/
> > 
> > Chao
> > > I come up with the following.
> > > 
> > > >From ec87e25082f0497431b732702fae82c6a05071bf Mon Sep 17 00:00:00 2001
> > > Message-Id: <ec87e25082f0497431b732702fae82c6a05071bf.1679531995.git.isaku.yamahata@intel.com>
> > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > > Date: Wed, 22 Mar 2023 15:32:56 -0700
> > > Subject: [PATCH] KVM: Relax alignment check for restricted mem
> > > 
> > > kvm_check_rmem_offset_alignment() only checks based on offset alignment
> > > and GPA alignment.  However, the actual alignment for offset depends
> > > on architecture.  For x86 case, it can be 1G, 2M or 4K.  So even if
> > > GPA is aligned for 1G+, only 1G-alignment is required for offset.
> > > 
> > > Without this patch, gpa=4G, offset=2G results in failure of memory slot
> > > creation.
> > > 
> > > Fixes: edc8814b2c77 ("KVM: Require gfn be aligned with restricted offset")
> > > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > > ---
> > >   arch/x86/include/asm/kvm_host.h | 15 +++++++++++++++
> > >   virt/kvm/kvm_main.c             |  9 ++++++++-
> > >   2 files changed, 23 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > index 88e11dd3afde..03af44650f24 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -16,6 +16,7 @@
> > >   #include <linux/irq_work.h>
> > >   #include <linux/irq.h>
> > >   #include <linux/workqueue.h>
> > > +#include <linux/count_zeros.h>
> > >   #include <linux/kvm.h>
> > >   #include <linux/kvm_para.h>
> > > @@ -143,6 +144,20 @@
> > >   #define KVM_HPAGE_MASK(x)	(~(KVM_HPAGE_SIZE(x) - 1))
> > >   #define KVM_PAGES_PER_HPAGE(x)	(KVM_HPAGE_SIZE(x) / PAGE_SIZE)
> > > +#define kvm_arch_required_alignment	kvm_arch_required_alignment
> > > +static inline int kvm_arch_required_alignment(u64 gpa)
> > > +{
> > > +	int zeros = count_trailing_zeros(gpa);
> > > +
> > > +	WARN_ON_ONCE(!PAGE_ALIGNED(gpa));
> > > +	if (zeros >= KVM_HPAGE_SHIFT(PG_LEVEL_1G))
> > > +		return KVM_HPAGE_SHIFT(PG_LEVEL_1G);
> > > +	else if (zeros >= KVM_HPAGE_SHIFT(PG_LEVEL_2M))
> > > +		return KVM_HPAGE_SHIFT(PG_LEVEL_2M);
> > > +
> > > +	return PAGE_SHIFT;
> > > +}
> > > +
> > >   #define KVM_MEMSLOT_PAGES_TO_MMU_PAGES_RATIO 50
> > >   #define KVM_MIN_ALLOC_MMU_PAGES 64UL
> > >   #define KVM_MMU_HASH_SHIFT 12
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index c9c4eef457b0..f4ff96171d24 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -2113,6 +2113,13 @@ static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
> > >   	return false;
> > >   }
> > > +#ifndef kvm_arch_required_alignment
> > > +__weak int kvm_arch_required_alignment(u64 gpa)
> > > +{
> > > +	return PAGE_SHIFT
> > > +}
> > > +#endif
> > > +
> > >   /*
> > >    * Return true when ALIGNMENT(offset) >= ALIGNMENT(gpa).
> > >    */
> > > @@ -2123,7 +2130,7 @@ static bool kvm_check_rmem_offset_alignment(u64 offset, u64 gpa)
> > >   	if (!gpa)
> > >   		return false;
> > > -	return !!(count_trailing_zeros(offset) >= count_trailing_zeros(gpa));
> > > +	return !!(count_trailing_zeros(offset) >= kvm_arch_required_alignment(gpa));
> > >   }
> > >   /*
> > > -- 
> > > 2.25.1
> > > 
> > > 
> > > 
> > > -- 
> > > Isaku Yamahata <isaku.yamahata@gmail.com>
