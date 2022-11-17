Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03F62DCAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 14:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbiKQNZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 08:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiKQNZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:25:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2952D59FF0;
        Thu, 17 Nov 2022 05:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668691507; x=1700227507;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=5axGlSLhPtmuHt4PaXeWSd8Q7yJdQcmlwNx/L+JedqY=;
  b=G0jX1NfP0lp2odylwesjoPP2pl+0mJ8+/CYe63ypDIp+8aiDkAk/Q5Sb
   EfUmZWtMdEio6BJgc56FsDnYbgFGmkcBkInRTsH7IqczVFoNWFglfHrNi
   l2uEFyF7CkNaRNVLBRRBAmgvo3+NOAJnpI+bwJfUdWSBF/xYQbXurHiLO
   szTFuy4EnR4fNNp+qO6R+WRjJXujP3ECZFgDJrCi/LF0QqNhl4APde3mc
   dQv5VkOuh9CGIFlKk3JX3eZ4L4tDBdd0kZoMfuCzE7azPKfxavMgueB6f
   c5VjfUTs/Wm3p54NlZMBqpkNsHZ/51wyQeoyqD+wj40maTUGdH9fKcIQR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="399136348"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="399136348"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 05:25:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="703331041"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="703331041"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2022 05:24:56 -0800
Date:   Thu, 17 Nov 2022 21:20:32 +0800
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
Message-ID: <20221117132032.GA422408@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-6-chao.p.peng@linux.intel.com>
 <Y3VjCxCiujCOLP7x@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3VjCxCiujCOLP7x@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:24:11PM +0000, Sean Christopherson wrote:
> On Tue, Oct 25, 2022, Chao Peng wrote:
> > +static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
> > +				     bool is_private)
> > +{
> > +	gfn_t start, end;
> > +	unsigned long i;
> > +	void *entry;
> > +	int idx;
> > +	int r = 0;
> > +
> > +	if (size == 0 || gpa + size < gpa)
> > +		return -EINVAL;
> > +	if (gpa & (PAGE_SIZE - 1) || size & (PAGE_SIZE - 1))
> > +		return -EINVAL;
> > +
> > +	start = gpa >> PAGE_SHIFT;
> > +	end = (gpa + size - 1 + PAGE_SIZE) >> PAGE_SHIFT;
> > +
> > +	/*
> > +	 * Guest memory defaults to private, kvm->mem_attr_array only stores
> > +	 * shared memory.
> > +	 */
> > +	entry = is_private ? NULL : xa_mk_value(KVM_MEM_ATTR_SHARED);
> > +
> > +	idx = srcu_read_lock(&kvm->srcu);
> > +	KVM_MMU_LOCK(kvm);
> > +	kvm_mmu_invalidate_begin(kvm, start, end);
> > +
> > +	for (i = start; i < end; i++) {
> > +		r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
> > +				    GFP_KERNEL_ACCOUNT));
> > +		if (r)
> > +			goto err;
> > +	}
> > +
> > +	kvm_unmap_mem_range(kvm, start, end);
> > +
> > +	goto ret;
> > +err:
> > +	for (; i > start; i--)
> > +		xa_erase(&kvm->mem_attr_array, i);
> 
> I don't think deleting previous entries is correct.  To unwind, the correct thing
> to do is restore the original values.  E.g. if userspace space is mapping a large
> range as shared, and some of the previous entries were shared, deleting them would
> incorrectly "convert" those entries to private.

Ah, right!

> 
> Tracking the previous state likely isn't the best approach, e.g. it would require
> speculatively allocating extra memory for a rare condition that is likely going to
> lead to OOM anyways.

Agree.

> 
> Instead of trying to unwind, what about updating the ioctl() params such that
> retrying with the updated addr+size would Just Work?  E.g.

Looks good to me. Thanks!

Chao
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 55b07aae67cc..f1de592a1a06 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1015,15 +1015,12 @@ static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
>  
>         kvm_unmap_mem_range(kvm, start, end, attr);
>  
> -       goto ret;
> -err:
> -       for (; i > start; i--)
> -               xa_erase(&kvm->mem_attr_array, i);
> -ret:
>         kvm_mmu_invalidate_end(kvm, start, end);
>         KVM_MMU_UNLOCK(kvm);
>         srcu_read_unlock(&kvm->srcu, idx);
>  
> +       <update gpa and size>
> +
>         return r;
>  }
>  #endif /* CONFIG_KVM_GENERIC_PRIVATE_MEM */
> @@ -4989,6 +4986,8 @@ static long kvm_vm_ioctl(struct file *filp,
>  
>                 r = kvm_vm_ioctl_set_mem_attr(kvm, region.addr,
>                                               region.size, set);
> +               if (copy_to_user(argp, &region, sizeof(region)) && !r)
> +                       r = -EFAULT
>                 break;
>         }
>  #endif
