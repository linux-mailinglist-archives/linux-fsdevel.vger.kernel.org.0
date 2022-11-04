Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799C26192CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 09:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiKDIdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 04:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiKDIdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:33:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6368C17;
        Fri,  4 Nov 2022 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667550800; x=1699086800;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=LBhw6eQcS71AQTHPgtJidpmNdTMwoZDoM5imFH5VGeA=;
  b=VtuW8FrM4T9Pr7uZdJIrQ3z55NoK7YDpcRqyxOXaUIktGDj0O0kSKPc/
   Tr79ep6jfD59cgU1/e/YA9/fi4q+686UL25P3g6n0jqXJmLyzu9BdZiYu
   kbbxJi3qPRwkMwRHDV/pM6BmxYI9YkDU3EzQ74662jnALnicw1fJiLigs
   AylKZiiM4oRcOV/5RQGzhabQzUNIhe5MLREEVvZLovIilcqvwXpxXq8Ak
   6ffobuKuR1IyqbslUrxao3a6GCrpIuzIay8OeDhu4zuZ57LMEWjHFQWER
   XtOKe0tVuutRHiSvAR6xI/fIIAUYzXvlvTmr8QLPrze7X6JfjUhg0bN74
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="289632654"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="289632654"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 01:33:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="637512630"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="637512630"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga007.fm.intel.com with ESMTP; 04 Nov 2022 01:33:10 -0700
Date:   Fri, 4 Nov 2022 16:28:43 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 5/8] KVM: Register/unregister the guest private memory
 regions
Message-ID: <20221104082843.GA4142342@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-6-chao.p.peng@linux.intel.com>
 <Y2RJFWplouV2iF5E@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2RJFWplouV2iF5E@google.com>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:04:53PM +0000, Sean Christopherson wrote:
> On Tue, Oct 25, 2022, Chao Peng wrote:
> > @@ -4708,6 +4802,24 @@ static long kvm_vm_ioctl(struct file *filp,
> >  		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
> >  		break;
> >  	}
> > +#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
> > +	case KVM_MEMORY_ENCRYPT_REG_REGION:
> > +	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
> 
> I'm having second thoughts about usurping KVM_MEMORY_ENCRYPT_(UN)REG_REGION.  Aside
> from the fact that restricted/protected memory may not be encrypted, there are
> other potential use cases for per-page memory attributes[*], e.g. to make memory
> read-only (or no-exec, or exec-only, etc...) without having to modify memslots.
> 
> Any paravirt use case where the attributes of a page are effectively dictated by
> the guest is going to run into the exact same performance problems with memslots,
> which isn't suprising in hindsight since shared vs. private is really just an
> attribute, albeit with extra special semantics.
> 
> And if we go with a brand new ioctl(), maybe someday in the very distant future
> we can deprecate and delete KVM_MEMORY_ENCRYPT_(UN)REG_REGION.
> 
> Switching to a new ioctl() should be a minor change, i.e. shouldn't throw too big
> of a wrench into things.
> 
> Something like:
> 
>   KVM_SET_MEMORY_ATTRIBUTES
> 
>   struct kvm_memory_attributes {
> 	__u64 address;
> 	__u64 size;
> 	__u64 flags;
>   }

I like the idea of adding a new ioctl(). But putting all attributes into
a flags in uAPI sounds not good to me, e.g. forcing userspace to set all
attributes in one call can cause pain for userspace, probably for KVM
implementation as well. For private<->shared memory conversion, we
actually only care the KVM_MEM_ATTR_SHARED or KVM_MEM_ATTR_PRIVATE bit,
but we force userspace to set other irrelevant bits as well if use this
API.

I looked at kvm_device_attr, sounds we can do similar:

  KVM_SET_MEMORY_ATTR

  struct kvm_memory_attr {
	__u64 address;
	__u64 size;
#define KVM_MEM_ATTR_SHARED	BIT(0)
#define KVM_MEM_ATTR_READONLY	BIT(1)
#define KVM_MEM_ATTR_NOEXEC	BIT(2)
	__u32 attr;
	__u32 pad;
  }

I'm not sure if we need KVM_GET_MEMORY_ATTR/KVM_HAS_MEMORY_ATTR as well,
but sounds like we need a KVM_UNSET_MEMORY_ATTR.

Since we are exposing the attribute directly to userspace I also think
we'd better treat shared memory as the default, so even when the private
memory is not used, the bit can still be meaningful. So define BIT(0) as
KVM_MEM_ATTR_PRIVATE instead of KVM_MEM_ATTR_SHARED.

Thanks,
Chao

> 
> [*] https://lore.kernel.org/all/Y1a1i9vbJ%2FpVmV9r@google.com
> 
> > +		struct kvm_enc_region region;
> > +		bool set = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION;
> > +
> > +		if (!kvm_arch_has_private_mem(kvm))
> > +			goto arch_vm_ioctl;
> > +
> > +		r = -EFAULT;
> > +		if (copy_from_user(&region, argp, sizeof(region)))
> > +			goto out;
> > +
> > +		r = kvm_vm_ioctl_set_mem_attr(kvm, region.addr,
> > +					      region.size, set);
> > +		break;
> > +	}
> > +#endif
