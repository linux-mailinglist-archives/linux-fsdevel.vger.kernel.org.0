Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853C74F9777
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 15:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiDHOBD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 10:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbiDHOBA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:01:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA536B6D;
        Fri,  8 Apr 2022 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649426336; x=1680962336;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=6BtLWIQ6HuBMCGyioka43iSSXH1vNEmJNzU6an6OpK4=;
  b=MUy6c8elqHtJU50LU0Pe58FhovHVw3LEjd2H2w0LWoyCbJjieYepBTSz
   bCxvxlH/PiEFd1xgW6kuTskptc3y0xMkaIBf1k1r+jVg8JOsuKub7rKWr
   9oIy7/Ar/unsPr/x7YPe7vI1l7pABdsVhwPBpv8CzMicDxbPYtJBBemGu
   hfy6Acw/xhlIm2TSUsrLLt+pRwq18dYz1GTZMp4TVjo8U3BAJ3Vw2l24U
   4tGHsfA9lfEQClAcrnnHPykATAEnpOPHskps4X4tHytAAIofpOXYT8xOp
   r5QmdeN3ysfce3rN+6Ijb+OmF/Rhh2zDmlhQWm7ecTxNM5L0Cp1fyWweW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="324758505"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="324758505"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="698190122"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2022 06:58:48 -0700
Date:   Fri, 8 Apr 2022 21:58:37 +0800
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
Subject: Re: [PATCH v5 06/13] KVM: Use kvm_userspace_memory_region_ext
Message-ID: <20220408135837.GE57095@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-7-chao.p.peng@linux.intel.com>
 <YkI2Lyv9SJaGPDz+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkI2Lyv9SJaGPDz+@google.com>
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

On Mon, Mar 28, 2022 at 10:26:55PM +0000, Sean Christopherson wrote:
> On Thu, Mar 10, 2022, Chao Peng wrote:
> > @@ -4476,14 +4477,23 @@ static long kvm_vm_ioctl(struct file *filp,
> >  		break;
> >  	}
> >  	case KVM_SET_USER_MEMORY_REGION: {
> > -		struct kvm_userspace_memory_region kvm_userspace_mem;
> > +		struct kvm_userspace_memory_region_ext region_ext;
> 
> It's probably a good idea to zero initialize the full region to avoid consuming
> garbage stack data if there's a bug and an _ext field is accessed without first
> checking KVM_MEM_PRIVATE.  I'm usually opposed to unnecessary initialization, but
> this seems like something we could screw up quite easily.
> 
> >  		r = -EFAULT;
> > -		if (copy_from_user(&kvm_userspace_mem, argp,
> > -						sizeof(kvm_userspace_mem)))
> > +		if (copy_from_user(&region_ext, argp,
> > +				sizeof(struct kvm_userspace_memory_region)))
> >  			goto out;
> > +		if (region_ext.region.flags & KVM_MEM_PRIVATE) {
> > +			int offset = offsetof(
> > +				struct kvm_userspace_memory_region_ext,
> > +				private_offset);
> > +			if (copy_from_user(&region_ext.private_offset,
> > +					   argp + offset,
> > +					   sizeof(region_ext) - offset))
> 
> In this patch, KVM_MEM_PRIVATE should result in an -EINVAL as it's not yet
> supported.  Copying the _ext on KVM_MEM_PRIVATE belongs in the "Expose KVM_MEM_PRIVATE"
> patch.

Agreed.

> 
> Mechnically, what about first reading flags via get_user(), and then doing a single
> copy_from_user()?  It's technically more work in the common case, and requires an
> extra check to guard against TOCTOU attacks, but this isn't a fast path by any means
> and IMO the end result makes it easier to understand the relationship between
> KVM_MEM_PRIVATE and the two different structs.

Will use this code, thanks for typing.

Chao
> 
> E.g.
> 
> 	case KVM_SET_USER_MEMORY_REGION: {
> 		struct kvm_user_mem_region region;
> 		unsigned long size;
> 		u32 flags;
> 
> 		memset(&region, 0, sizeof(region));
> 
> 		r = -EFAULT;
> 		if (get_user(flags, (u32 __user *)(argp + offsetof(typeof(region), flags))))
> 			goto out;
> 
> 		if (flags & KVM_MEM_PRIVATE)
> 			size = sizeof(struct kvm_userspace_memory_region_ext);
> 		else
> 			size = sizeof(struct kvm_userspace_memory_region);
> 		if (copy_from_user(&region, argp, size))
> 			goto out;
> 
> 		r = -EINVAL;
> 		if ((flags ^ region.flags) & KVM_MEM_PRIVATE)
> 			goto out;
> 
> 		r = kvm_vm_ioctl_set_memory_region(kvm, &region);
> 		break;
> 	}
> 
> > +				goto out;
> > +		}
> >  
> > -		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
> > +		r = kvm_vm_ioctl_set_memory_region(kvm, &region_ext);
> >  		break;
> >  	}
> >  	case KVM_GET_DIRTY_LOG: {
> > -- 
> > 2.17.1
> > 
