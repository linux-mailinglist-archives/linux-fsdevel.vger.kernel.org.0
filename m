Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A5B588A30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 12:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiHCKNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiHCKNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:13:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9961EC66;
        Wed,  3 Aug 2022 03:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659521614; x=1691057614;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=4YeFWA9rCTchi7DdItTLJ0V7fyTXQO9cGL0HxgJNFxA=;
  b=POv/H+iuNf1VbVPoCP9goCPl7SK97Hl30HYBRdHSmx1goj+dB5N7pnS+
   nuJ8HDH2mqaMkqSEz1dbKTDXU0PtG4Akso2A5jz846XhjoG1vZwiDPZg0
   birrRmTlPK4+AXB4WkVlJOR5thXuVZ1SyeNt+bTx6dUPli0xMvjQ3tXGU
   QbixHAgauHYtoIldJD1rQ03QqaEUti8ZMrsfruHmD3hjnnHYEd3yWCbJP
   uzM3aBmJjECmVqGZTisLk/DEHQKuf83+EdLAlVZpsz1dHaYUXA7ygxlMU
   RSD5L5jjdmv96VTyQuYpUP4SkoSyp1uuh0Jmc2ULGk5KmgrYobF6QIJ9j
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="270016189"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="270016189"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 03:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="631094289"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2022 03:13:22 -0700
Date:   Wed, 3 Aug 2022 18:08:35 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 09/14] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20220803100835.GD607465@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-10-chao.p.peng@linux.intel.com>
 <YuQ6QWcdZLdStkWl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuQ6QWcdZLdStkWl@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 29, 2022 at 07:51:29PM +0000, Sean Christopherson wrote:
> On Wed, Jul 06, 2022, Chao Peng wrote:
> > @@ -1332,9 +1332,18 @@ yet and must be cleared on entry.
> >  	__u64 userspace_addr; /* start of the userspace allocated memory */
> >    };
> >  
> > +  struct kvm_userspace_memory_region_ext {
> > +	struct kvm_userspace_memory_region region;
> > +	__u64 private_offset;
> > +	__u32 private_fd;
> > +	__u32 pad1;
> > +	__u64 pad2[14];
> > +};
> > +
> >    /* for kvm_memory_region::flags */
> >    #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
> >    #define KVM_MEM_READONLY	(1UL << 1)
> > +  #define KVM_MEM_PRIVATE		(1UL << 2)
> 
> Very belatedly following up on prior feedback...
> 
>   | I think a flag is still needed, the problem is private_fd can be safely
>   | accessed only when this flag is set, e.g. without this flag, we can't
>   | copy_from_user these new fields since they don't exist for previous
>   | kvm_userspace_memory_region callers.
> 
> I forgot about that aspect of things.  We don't technically need a dedicated
> PRIVATE flag to handle that, but it does seem to be the least awful soltuion.
> We could either add a generic KVM_MEM_EXTENDED_REGION or an entirely new
> ioctl(), e.g. KVM_SET_USER_MEMORY_REGION2, but in both approaches there's a decent
> chance that we'll end up needed individual "this field is valid" flags anways.
> 
> E.g. if KVM requires pad1 and pad2 to be zero to carve out future extensions,
> then we're right back here if some future extension needs to treat '0' as a legal
> input.

I had such practice (always rejecting none-zero 'pad' value when
introducing new user APIs) in other project previously, but I rarely
see that in KVM.

> 
> TL;DR: adding KVM_MEM_PRIVATE still seems like the best approach.
> 
> > @@ -4631,14 +4658,35 @@ static long kvm_vm_ioctl(struct file *filp,
> >  		break;
> >  	}
> >  	case KVM_SET_USER_MEMORY_REGION: {
> > -		struct kvm_userspace_memory_region kvm_userspace_mem;
> > +		struct kvm_user_mem_region mem;
> > +		unsigned long size;
> > +		u32 flags;
> > +
> > +		kvm_sanity_check_user_mem_region_alias();
> > +
> > +		memset(&mem, 0, sizeof(mem));
> >  
> >  		r = -EFAULT;
> > -		if (copy_from_user(&kvm_userspace_mem, argp,
> > -						sizeof(kvm_userspace_mem)))
> > +
> > +		if (get_user(flags,
> > +			(u32 __user *)(argp + offsetof(typeof(mem), flags))))
> > +			goto out;
> 
> 
> Indentation is funky.  It's hard to massage this into something short and
> readable  What about capturing the offset separately?  E.g.
> 
>                 struct kvm_user_mem_region mem;
>                 unsigned int flags_offset = offsetof(typeof(mem), flags));
>                 unsigned long size;
>                 u32 flags;
> 
>                 kvm_sanity_check_user_mem_region_alias();
> 
> 		memset(&mem, 0, sizeof(mem));
> 
>                 r = -EFAULT;
>                 if (get_user(flags, (u32 __user *)(argp + flags_offset)))
>                         goto out;
> 
> But this can actually be punted until KVM_MEM_PRIVATE is fully supported.  As of
> this patch, KVM doesn't read the extended size, so I believe the diff for this
> patch can simply be:

Looks good to me, Thanks.

Chao
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index da263c370d00..5194beb7b52f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4640,6 +4640,10 @@ static long kvm_vm_ioctl(struct file *filp,
>                                                 sizeof(kvm_userspace_mem)))
>                         goto out;
> 
> +               r = -EINVAL;
> +               if (mem.flags & KVM_MEM_PRIVATE)
> +                       goto out;
> +
>                 r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
>                 break;
>         }
