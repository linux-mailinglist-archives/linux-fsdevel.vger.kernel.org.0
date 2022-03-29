Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF224EB3F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 21:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbiC2TOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 15:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240872AbiC2TOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:14:50 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E52B716E
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 12:13:06 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bc27so15635982pgb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 12:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1sRXKTYViBqnNTxehrfiPd1DYbEATFyG4C7S2pQ8qtk=;
        b=pc8wAJj+CGPClFtc4+6SxMMF/hTDKxwPn6EK6m+9FfRx27Qyy31qCAugysYpXwlHiK
         a0kUGxK6Xfyusctttk3qEf0tK6tcNRZVC0ueQWru0qGnf/xQLnN9yB4UEhBh55GBLxLt
         cFjVzP27q2Jbjet5ZlPU3AzKv8YUQVETYTNGVpsh9BLXbZGgX7Laxe7Wbsh1pkzmNQd5
         RT1DHO3tEEfJFNloe7cH+mP9GhmOEje2wvBrJ7X8qHIVfsdTFM8N3zeTBWAQPouP/7Qc
         E+5bWo7OtgVpxMuq7z9X5OGWkMU+uUppgPyk83J8z1ADfUaMuhzNtfpxuM8aS7z8GBcU
         BCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1sRXKTYViBqnNTxehrfiPd1DYbEATFyG4C7S2pQ8qtk=;
        b=R9t1YWY/VwKjW7Qe71ctjuuUtTlpyClO7fwXVYISAkdqv5vFjfadFrpImk5eg4Ci8o
         7lfDLdXtnpwDXkCsA9y5Ojpu/XH+UM4j9MzqPBCnFYjaux0fsV39uOcyKegjv5GqBeQe
         YXCYaR2s8IqLNMpToc+J/7c+LvuDxpD5j2jk2yOp1uzbJbGkkirOLhNfprj3TAUthiju
         JShc/n5YgHV/PAuDPQUOwQ3ECc+8U01D2NJJZP/JzTwkY3jrTaTdQuE/RXzox1dw16zW
         TsdMB2w4rMzoUaAFwTyoerqv8gbRWmUOxht6YPGatVDLGnSItJJhFR78s7AGciqz3XKB
         yEvA==
X-Gm-Message-State: AOAM532NIWliDcakoN0OzJqrGRjYGi4UWZtXu9T4q9KMyRUi8WV10ZqT
        mVK5tkcsLVOmtsHtHKOWQBSajw==
X-Google-Smtp-Source: ABdhPJyYp/V6OUPnq1zyxa80O7VCUFqnzL/BqLshFvCAlq+hazZ3NircvxGibV5N8Gx554xqH7ZZkA==
X-Received: by 2002:a05:6a00:1c95:b0:4fa:81f5:b9d4 with SMTP id y21-20020a056a001c9500b004fa81f5b9d4mr7825994pfw.49.1648581185482;
        Tue, 29 Mar 2022 12:13:05 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r11-20020a17090b050b00b001c741fd4890sm3627743pjz.9.2022.03.29.12.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 12:13:04 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:13:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
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
Subject: Re: [PATCH v5 12/13] KVM: Expose KVM_MEM_PRIVATE
Message-ID: <YkNaPLVLk/pO0zjr@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-13-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140911.50924-13-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022, Chao Peng wrote:
> KVM_MEM_PRIVATE is not exposed by default but architecture code can turn
> on it by implementing kvm_arch_private_memory_supported().
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/kvm_host.h |  1 +
>  virt/kvm/kvm_main.c      | 24 +++++++++++++++++++-----
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 186b9b981a65..0150e952a131 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1432,6 +1432,7 @@ bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
>  int kvm_arch_post_init_vm(struct kvm *kvm);
>  void kvm_arch_pre_destroy_vm(struct kvm *kvm);
>  int kvm_arch_create_vm_debugfs(struct kvm *kvm);
> +bool kvm_arch_private_memory_supported(struct kvm *kvm);
>  
>  #ifndef __KVM_HAVE_ARCH_VM_ALLOC
>  /*
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 52319f49d58a..df5311755a40 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1485,10 +1485,19 @@ static void kvm_replace_memslot(struct kvm *kvm,
>  	}
>  }
>  
> -static int check_memory_region_flags(const struct kvm_userspace_memory_region *mem)
> +bool __weak kvm_arch_private_memory_supported(struct kvm *kvm)
> +{
> +	return false;
> +}
> +
> +static int check_memory_region_flags(struct kvm *kvm,
> +				const struct kvm_userspace_memory_region *mem)
>  {
>  	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
>  
> +	if (kvm_arch_private_memory_supported(kvm))
> +		valid_flags |= KVM_MEM_PRIVATE;
> +
>  #ifdef __KVM_HAVE_READONLY_MEM
>  	valid_flags |= KVM_MEM_READONLY;
>  #endif
> @@ -1900,7 +1909,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  	int as_id, id;
>  	int r;
>  
> -	r = check_memory_region_flags(mem);
> +	r = check_memory_region_flags(kvm, mem);
>  	if (r)
>  		return r;
>  
> @@ -1913,10 +1922,12 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  		return -EINVAL;
>  	if (mem->guest_phys_addr & (PAGE_SIZE - 1))
>  		return -EINVAL;
> -	/* We can read the guest memory with __xxx_user() later on. */
>  	if ((mem->userspace_addr & (PAGE_SIZE - 1)) ||
> -	    (mem->userspace_addr != untagged_addr(mem->userspace_addr)) ||
> -	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
> +	    (mem->userspace_addr != untagged_addr(mem->userspace_addr)))
> +		return -EINVAL;
> +	/* We can read the guest memory with __xxx_user() later on. */
> +	if (!(mem->flags & KVM_MEM_PRIVATE) &&
> +	    !access_ok((void __user *)(unsigned long)mem->userspace_addr,

This should sanity check private_offset for private memslots.  At a bare minimum,
wrapping should be disallowed.

>  			mem->memory_size))
>  		return -EINVAL;
>  	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
> @@ -1957,6 +1968,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  		if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
>  			return -EINVAL;
>  	} else { /* Modify an existing slot. */
> +		/* Private memslots are immutable, they can only be deleted. */
> +		if (mem->flags & KVM_MEM_PRIVATE)
> +			return -EINVAL;

These sanity checks belong in "KVM: Register private memslot to memory backing store",
e.g. that patch is "broken" without the immutability restriction.  It's somewhat moot
because the code is unreachable, but it makes reviewing confusing/difficult.

But rather than move the sanity checks back, I think I'd prefer to pull all of patch 10
here.  I think it also makes sense to drop "KVM: Use memfile_pfn_ops to obtain pfn for
private pages" and add the pointer in "struct kvm_memory_slot" in patch "KVM: Extend the
memslot to support fd-based private memory", with the use of the ops folded into
"KVM: Handle page fault for private memory".  Adding code to KVM and KVM-x86 in a single
patch is ok, and overall makes things easier to review because the new helpers have a
user right away, especially since there will be #ifdeffery.

I.e. end up with something like:

  mm: Introduce memfile_notifier
  mm/shmem: Restrict MFD_INACCESSIBLE memory against RLIMIT_MEMLOCK
  KVM: Extend the memslot to support fd-based private memory
  KVM: Use kvm_userspace_memory_region_ext
  KVM: Add KVM_EXIT_MEMORY_ERROR exit
  KVM: Handle page fault for private memory
  KVM: Register private memslot to memory backing store
  KVM: Zap existing KVM mappings when pages changed in the private fd
  KVM: Enable and expose KVM_MEM_PRIVATE

>  		if ((mem->userspace_addr != old->userspace_addr) ||
>  		    (npages != old->npages) ||
>  		    ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
> -- 
> 2.17.1
> 
