Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A2045DF3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 17:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357034AbhKYRBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 12:01:10 -0500
Received: from foss.arm.com ([217.140.110.172]:53222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356652AbhKYQ7J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:59:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 065761042;
        Thu, 25 Nov 2021 08:55:58 -0800 (PST)
Received: from [10.57.29.213] (unknown [10.57.29.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C75C3F73B;
        Thu, 25 Nov 2021 08:55:53 -0800 (PST)
Subject: Re: [RFC v2 PATCH 06/13] KVM: Register/unregister memfd backed
 memslot
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-7-chao.p.peng@linux.intel.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <aff496f2-da53-87ec-0b86-199445bb5159@arm.com>
Date:   Thu, 25 Nov 2021 16:55:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211119134739.20218-7-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/11/2021 13:47, Chao Peng wrote:
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  virt/kvm/kvm_main.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 271cef8d1cd0..b8673490d301 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1426,7 +1426,7 @@ static void update_memslots(struct kvm_memslots *slots,
>  static int check_memory_region_flags(struct kvm *kvm,
>  			     const struct kvm_userspace_memory_region_ext *mem)
>  {
> -	u32 valid_flags = 0;
> +	u32 valid_flags = KVM_MEM_FD;
>  
>  	if (!kvm->dirty_log_unsupported)
>  		valid_flags |= KVM_MEM_LOG_DIRTY_PAGES;
> @@ -1604,10 +1604,20 @@ static int kvm_set_memslot(struct kvm *kvm,
>  		kvm_copy_memslots(slots, __kvm_memslots(kvm, as_id));
>  	}
>  
> +	if (mem->flags & KVM_MEM_FD && change == KVM_MR_CREATE) {
> +		r = kvm_memfd_register(kvm, mem, new);
> +		if (r)
> +			goto out_slots;
> +	}
> +
>  	r = kvm_arch_prepare_memory_region(kvm, new, mem, change);
>  	if (r)
>  		goto out_slots;
>  
> +	if (mem->flags & KVM_MEM_FD && (r || change == KVM_MR_DELETE)) {
                                        ^
r will never be non-zero as the 'if' above will catch that case and jump
to out_slots.

I *think* the intention was that the "if (r)" code should be after this
check to clean up in the case of error from
kvm_arch_prepare_memory_region() (as well as an explicit MR_DELETE).

Steve

> +		kvm_memfd_unregister(kvm, new);
> +	}
> +
>  	update_memslots(slots, new, change);
>  	slots = install_new_memslots(kvm, as_id, slots);
>  
> @@ -1683,10 +1693,12 @@ int __kvm_set_memory_region(struct kvm *kvm,
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
> +	if (!(mem->flags & KVM_MEM_FD) &&
> +	    !access_ok((void __user *)(unsigned long)mem->userspace_addr,
>  			mem->memory_size))
>  		return -EINVAL;
>  	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
> @@ -1727,6 +1739,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  		new.dirty_bitmap = NULL;
>  		memset(&new.arch, 0, sizeof(new.arch));
>  	} else { /* Modify an existing slot. */
> +		/* Private memslots are immutable, they can only be deleted. */
> +		if (mem->flags & KVM_MEM_FD && mem->private_fd >= 0)
> +			return -EINVAL;
>  		if ((new.userspace_addr != old.userspace_addr) ||
>  		    (new.npages != old.npages) ||
>  		    ((new.flags ^ old.flags) & KVM_MEM_READONLY))
> 

