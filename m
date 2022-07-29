Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247AA585653
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 22:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiG2U6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 16:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiG2U6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:58:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC99C8AEE8
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 13:58:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s206so4892529pgs.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 13:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xSUX4n5EOZoO6EmWZ2h+wwgMii0Rl96zCog8KMwNDpE=;
        b=IQa/2kQ54sNuJFQTlEtNq5TKTdwkdwyj7A2Lk5GyapXGPHgft6Y4da5hKX8JyLKYUF
         dxIS0jRo9GG3npqy+Pg4Ln4aI12jIIGtLZP0/UBLco+CF9pVQjURcXwHKbpgIaL6oDo2
         oHPrpODdXTv5tU6hp5fnQVQaLEOG2clh+Dv38QypiPr2SiCugTXODzmnkYiEw9xwIygg
         /6eAHyLwoYiqcdVMdT02I9kG8osr3/FmkjgMjspXUgU4nrIqcp177Bu4fYi5UEuFgXNu
         aPQZj8BQskDnwF3+n8m72EOF8vqFzF/UzjAX2l1tE6KGgebsxuoKxNou4XR1uAj2Xvn9
         2H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xSUX4n5EOZoO6EmWZ2h+wwgMii0Rl96zCog8KMwNDpE=;
        b=hte03KAtRFVNhby7QJyVSeoAqng5fb5/FP9iYS7ae/dfpWtMTA7PwGscP411KQcckQ
         r7JliFTHy85Icp/Q/vMUyrVzM70dIctelu2EYd4s4IZCIBuMqepDGEW1OhQOCLbSedOZ
         hhy0D3amgKDHYB3WA1kQcGLW5lafypoy2iPtsvtvSP/OcIa2PoQVGIW3ytcG02vXimph
         uNTcwH8iRVLpKPfuW+HSu/zgiSlMe0y2FDkLtysN8gNyybN8KskqwvFG2+PSUyiffeTz
         AsFRP8gfJQQH7swBbO/V6siaAAwuEdDsxXR/dY6xu9QGMx2bikvabl2eN/Th74p3Z8Rj
         p5Ig==
X-Gm-Message-State: AJIora9tOqkejMorpJNCf0pZhbu3Eg4ZRgw6OadLMrfoN5Mt1gEWU7X4
        Zy3PKwn/j4qJvbpEqHebFGTtruJSSG8adQ==
X-Google-Smtp-Source: AGRyM1vN6zx5wsr5GVVc5ytEEhaS3cRKGvLGbuTs4y/gxM5vty96tVvmJRlSNJfUJgonhSJqKrn69g==
X-Received: by 2002:a63:535f:0:b0:41a:ee1c:a15f with SMTP id t31-20020a63535f000000b0041aee1ca15fmr4299865pgl.265.1659128325266;
        Fri, 29 Jul 2022 13:58:45 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709027e0a00b0016d295888e3sm3999789plm.241.2022.07.29.13.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 13:58:44 -0700 (PDT)
Date:   Fri, 29 Jul 2022 20:58:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
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
Subject: Re: [PATCH v7 12/14] KVM: Handle page fault for private memory
Message-ID: <YuRKAcT3cuEE4GgF@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-13-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706082016.2603916-13-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 06, 2022, Chao Peng wrote:
> A page fault can carry the private/shared information for
> KVM_MEM_PRIVATE memslot, this can be filled by architecture code(like
> TDX code). To handle page fault for such access, KVM maps the page only
> when this private property matches the host's view on the page.
> 
> For a successful match, private pfn is obtained with memfile_notifier
> callbacks from private fd and shared pfn is obtained with existing
> get_user_pages.
> 
> For a failed match, KVM causes a KVM_EXIT_MEMORY_FAULT exit to
> userspace. Userspace then can convert memory between private/shared from
> host's view then retry the access.
> 
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c          | 60 ++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/mmu/mmu_internal.h | 18 ++++++++++
>  arch/x86/kvm/mmu/mmutrace.h     |  1 +
>  include/linux/kvm_host.h        | 35 ++++++++++++++++++-
>  4 files changed, 112 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 545eb74305fe..27dbdd4fe8d1 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3004,6 +3004,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
>  	if (max_level == PG_LEVEL_4K)
>  		return PG_LEVEL_4K;
>  
> +	if (kvm_mem_is_private(kvm, gfn))
> +		return max_level;
> +
>  	host_level = host_pfn_mapping_level(kvm, gfn, pfn, slot);
>  	return min(host_level, max_level);
>  }
> @@ -4101,10 +4104,52 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
>  	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
>  }
>  
> +static inline u8 order_to_level(int order)
> +{
> +	enum pg_level level;
> +
> +	for (level = KVM_MAX_HUGEPAGE_LEVEL; level > PG_LEVEL_4K; level--)

Curly braces needed for the for-loop.

And I think it makes sense to take in the fault->max_level, that way this is
slightly more performant when the guest mapping is smaller than the host, e.g.

	for (level = max_level; level > PG_LEVEL_4K; level--)
		...

	return level;

Though I think I'd vote to avoid a loop entirely and do:

	BUILD_BUG_ON(KVM_MAX_HUGEPAGE_LEVEL > PG_LEVEL_1G);

	if (order > ???)
		return PG_LEVEL_1G;
	
	if (order > ???)
		return PG_LEVEL_2M;

	return PG_LEVEL_4K;


> +		if (order >= page_level_shift(level) - PAGE_SHIFT)
> +			return level;
> +	return level;
> +}
> +
> +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> +				   struct kvm_page_fault *fault)
> +{
> +	int order;
> +	struct kvm_memory_slot *slot = fault->slot;
> +	bool private_exist = kvm_mem_is_private(vcpu->kvm, fault->gfn);
> +
> +	if (fault->is_private != private_exist) {
> +		vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
> +		if (fault->is_private)
> +			vcpu->run->memory.flags = KVM_MEMORY_EXIT_FLAG_PRIVATE;
> +		else
> +			vcpu->run->memory.flags = 0;
> +		vcpu->run->memory.padding = 0;
> +		vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
> +		vcpu->run->memory.size = PAGE_SIZE;
> +		return RET_PF_USER;
> +	}
> +
> +	if (fault->is_private) {
> +		if (kvm_private_mem_get_pfn(slot, fault->gfn, &fault->pfn, &order))
> +			return RET_PF_RETRY;
> +		fault->max_level = min(order_to_level(order), fault->max_level);
> +		fault->map_writable = !(slot->flags & KVM_MEM_READONLY);
> +		return RET_PF_FIXED;
> +	}
> +
> +	/* Fault is shared, fallthrough. */
> +	return RET_PF_CONTINUE;
> +}
> +
>  static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  {
>  	struct kvm_memory_slot *slot = fault->slot;
>  	bool async;
> +	int r;
>  
>  	/*
>  	 * Retry the page fault if the gfn hit a memslot that is being deleted
> @@ -4133,6 +4178,12 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  			return RET_PF_EMULATE;
>  	}
>  
> +	if (kvm_slot_can_be_private(slot)) {
> +		r = kvm_faultin_pfn_private(vcpu, fault);
> +		if (r != RET_PF_CONTINUE)
> +			return r == RET_PF_FIXED ? RET_PF_CONTINUE : r;

I apologize if I've given you conflicting feedback in the past.  Now that this
returns RET_PF_* directly, I definitely think it makes sense to do:

	if (kvm_slot_can_be_private(slot) &&
	    fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
		vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
		if (fault->is_private)
			vcpu->run->memory.flags = KVM_MEMORY_EXIT_FLAG_PRIVATE;
		else
			vcpu->run->memory.flags = 0;
		vcpu->run->memory.padding = 0;
		vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
		vcpu->run->memory.size = PAGE_SIZE;
		return RET_PF_USER;
	}

	if (fault->is_private)
		return kvm_faultin_pfn_private(vcpu, fault);

That way kvm_faultin_pfn_private() only handles private faults, and this doesn't
need to play games with RET_PF_FIXED.


> +	}
> +
>  	async = false;
>  	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, &async,
>  					  fault->write, &fault->map_writable,
> @@ -4241,7 +4292,11 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  		read_unlock(&vcpu->kvm->mmu_lock);
>  	else
>  		write_unlock(&vcpu->kvm->mmu_lock);
> -	kvm_release_pfn_clean(fault->pfn);
> +
> +	if (fault->is_private)
> +		kvm_private_mem_put_pfn(fault->slot, fault->pfn);
> +	else
> +		kvm_release_pfn_clean(fault->pfn);

AFAIK, we never bottomed out on whether or not this is needed[*].  Can you follow
up with Kirill to get an answer before posting v8?

[*] https://lore.kernel.org/all/20220620141647.GC2016793@chaop.bj.intel.com
