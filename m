Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EB76B0030
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 08:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCHHsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 02:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCHHsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:48:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449764ECD9;
        Tue,  7 Mar 2023 23:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678261696; x=1709797696;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=MPjpMnF2pYRp601r/CV/4rcJZOvf9VGuPDqjdu0MkGE=;
  b=laniImVi/D2OeyIXehqaJ1zzZgBwQv/O8iHVcJwyW9RnrGhjjeh5Iy06
   v/3ZjqzAybk9UYcf+LicxxLSkK/v8/0566QBATg8EKngSTM4qbxaDIgKt
   jrJ9v+tIdSTKVyt8CYxuU3dk3u84bx/6dlQ1jdYkTTqC17CYUes/7tpyl
   lv0EJXHvXfE8QxlbpXt36kY3AnpkJ6sKiC0TWYRX2DtpGa2l6MHBdKVKA
   ABEllsjxoS+0r4LeWFg47aYl6KFICzMzCW2SLHf9BDh2PnolOfzebFxPb
   lKAoeYqSQe0OalzGEQLRmmxgk7hRmQJkLcTwAjKk/K6tfKUDyFgXLJ+E8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="363727024"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="363727024"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:48:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="745821383"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="745821383"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2023 23:48:04 -0800
Date:   Wed, 8 Mar 2023 15:40:26 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     seanjc@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, pbonzini@redhat.com, corbet@lwn.net,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, arnd@arndb.de, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, x86@kernel.org, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, shuah@kernel.org, rppt@kernel.org,
        steven.price@arm.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        vannapurve@google.com, yu.c.zhang@linux.intel.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, qperret@google.com, tabba@google.com,
        michael.roth@amd.com, mhocko@suse.com, wei.w.wang@intel.com
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
Message-ID: <20230308074026.GA2183207@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20230128140030.GB700688@chaop.bj.intel.com>
 <diqz5ybc3xsr.fsf@ackerleytng-cloudtop.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <diqz5ybc3xsr.fsf@ackerleytng-cloudtop.c.googlers.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 08, 2023 at 12:13:24AM +0000, Ackerley Tng wrote:
> Chao Peng <chao.p.peng@linux.intel.com> writes:
> 
> > On Sat, Jan 14, 2023 at 12:01:01AM +0000, Sean Christopherson wrote:
> > > On Fri, Dec 02, 2022, Chao Peng wrote:
> > ...
> > > Strongly prefer to use similar logic to existing code that detects wraps:
> 
> > > 		mem->restricted_offset + mem->memory_size < mem->restricted_offset
> 
> > > This is also where I'd like to add the "gfn is aligned to offset"
> > > check, though
> > > my brain is too fried to figure that out right now.
> 
> > Used count_trailing_zeros() for this TODO, unsure we have other better
> > approach.
> 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index afc8c26fa652..fd34c5f7cd2f 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -56,6 +56,7 @@
> >   #include <asm/processor.h>
> >   #include <asm/ioctl.h>
> >   #include <linux/uaccess.h>
> > +#include <linux/count_zeros.h>
> 
> >   #include "coalesced_mmio.h"
> >   #include "async_pf.h"
> > @@ -2087,6 +2088,19 @@ static bool kvm_check_memslot_overlap(struct
> > kvm_memslots *slots, int id,
> >   	return false;
> >   }
> 
> > +/*
> > + * Return true when ALIGNMENT(offset) >= ALIGNMENT(gpa).
> > + */
> > +static bool kvm_check_rmem_offset_alignment(u64 offset, u64 gpa)
> > +{
> > +	if (!offset)
> > +		return true;
> > +	if (!gpa)
> > +		return false;
> > +
> > +	return !!(count_trailing_zeros(offset) >= count_trailing_zeros(gpa));
> 
> Perhaps we could do something like
> 
> #define lowest_set_bit(val) (val & -val)
> 
> and use
> 
> return lowest_set_bit(offset) >= lowest_set_bit(gpa);

I see kernel already has fls64(), that looks what we need ;)

> 
> Please help me to understand: why must ALIGNMENT(offset) >=
> ALIGNMENT(gpa)? Why is it not sufficient to have both gpa and offset be
> aligned to PAGE_SIZE?

Yes, it's sufficient. Here we just want to be conservative on the uAPI
as Sean explained this at [1]:

  I would rather reject memslot if the gfn has lesser alignment than the
  offset. I'm totally ok with this approach _if_ there's a use case. 
  Until such a use case presents itself, I would rather be conservative
  from a uAPI perspective.

[1] https://lore.kernel.org/all/Y8HldeHBrw+OOZVm@google.com/

Chao
> 
> > +}
> > +
> >   /*
> >    * Allocate some memory and give it an address in the guest physical
> > address
> >    * space.
> > @@ -2128,7 +2142,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >   	if (mem->flags & KVM_MEM_PRIVATE &&
> >   	    (mem->restrictedmem_offset & (PAGE_SIZE - 1) ||
> >   	     mem->restrictedmem_offset + mem->memory_size <
> > mem->restrictedmem_offset ||
> > -	     0 /* TODO: require gfn be aligned with restricted offset */))
> > +	     !kvm_check_rmem_offset_alignment(mem->restrictedmem_offset,
> > +					      mem->guest_phys_addr)))
> >   		return -EINVAL;
> >   	if (as_id >= kvm_arch_nr_memslot_as_ids(kvm) || id >= KVM_MEM_SLOTS_NUM)
> >   		return -EINVAL;
