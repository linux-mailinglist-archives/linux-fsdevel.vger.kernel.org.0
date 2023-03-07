Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361B06AF5AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 20:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjCGT23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 14:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbjCGT2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:28:09 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42B2B5FE7
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 11:14:09 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id q24-20020a17090a2e1800b00237c37964d4so8517377pjd.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 11:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678216446;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wt+tMy1RH9zC84sq0to0cY0x7+Xv2yMTzgsmC8ZQ7cM=;
        b=D+BRUMlsQmhPM7Km19r0cwtSovSQv0WAERIfkRDuEbsEadkI29Rz8sSQqIRpfAPEa/
         uCEsFKnPst88VAZKSkPZjffh5S3WZTxUmNU4Xw/KSiy4soV/n0dJgIrEl9OXSPbIfQQK
         KLOBXvGg6LH2ugOhFB2E2wpPrpDgxCLKWf0LPJlLMfhxqqsHvu6JPcw14TUVTqqyGFlZ
         BGsXgEkUEMCjAYmlzNQrRRX203Kz1uOE6SMPxmDIVc7khBpDDg6yCWpgZR7rxAtYpjv/
         SqkEiQXtopyaQBB3xjjHp9QzaFJ66vn2U3nSuUXKNCqd3tZoY5qhFiJPfWWt4zAY4ldo
         w8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678216446;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt+tMy1RH9zC84sq0to0cY0x7+Xv2yMTzgsmC8ZQ7cM=;
        b=Vuh1qXoXfcQcXlw1quu5KAFKreH5BPzV/ZtD3XwVwJnnEpNoN7gplba7wUYte6Y0yh
         SEGgwqtdipOsgLAtERICa39PsL6oRQdsIzzzjLY2vgZJHHTtaSu7pe+hQ9iOnwX6GQNm
         eGnK6X/qLMzNDwUHh2eCxKLW8K12BI14M9iWFUwJoJMl7zzA02wwB99jJRBnwTxmPBPF
         T/0SFDEfImru6aUGgvBuFx0RMdiM7sSxMc76HulZboVc3VoM/qUd8y9dgwDnHb5NVQHD
         0NBX6iSwQd5xNzRP3hNr91OV846WD8C/Xvxl0az+6zXSXxHAn6pvDYJgXAjqw3/Nfdoz
         MPsQ==
X-Gm-Message-State: AO0yUKXsBBoZmaqIXxwqiljBsx+Lvn6VBz+4HU/4Uc1BPJ0dXLeY8Ft4
        EOlZDma3gomhD56SzOHQ+KTflPcDyZ6ORAqlvQ==
X-Google-Smtp-Source: AK7set9XmMrWXZ6mpUlbpcFneSpuxawFmXBvqn5A78lIM65RH9bBDorwkD1ukffGVS/euOjwrQaunWK8N4egR11Vkw==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:8e83:b0:237:1fe0:b151 with
 SMTP id f3-20020a17090a8e8300b002371fe0b151mr5483530pjo.8.1678216446569; Tue,
 07 Mar 2023 11:14:06 -0800 (PST)
Date:   Tue, 07 Mar 2023 19:14:05 +0000
In-Reply-To: <20221202061347.1070246-10-chao.p.peng@linux.intel.com> (message
 from Chao Peng on Fri,  2 Dec 2022 14:13:47 +0800)
Mime-Version: 1.0
Message-ID: <diqzcz5kz85e.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
From:   Ackerley Tng <ackerleytng@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        pbonzini@redhat.com, corbet@lwn.net, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, arnd@arndb.de, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, x86@kernel.org, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, shuah@kernel.org, rppt@kernel.org,
        steven.price@arm.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        vannapurve@google.com, yu.c.zhang@linux.intel.com,
        chao.p.peng@linux.intel.com, kirill.shutemov@linux.intel.com,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com, qperret@google.com,
        tabba@google.com, michael.roth@amd.com, mhocko@suse.com,
        wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chao Peng <chao.p.peng@linux.intel.com> writes:

> Register/unregister private memslot to fd-based memory backing store
> restrictedmem and implement the callbacks for restrictedmem_notifier:
>    - invalidate_start()/invalidate_end() to zap the existing memory
>      mappings in the KVM page table.
>    - error() to request KVM_REQ_MEMORY_MCE and later exit to userspace
>      with KVM_EXIT_SHUTDOWN.

> Expose KVM_MEM_PRIVATE for memslot and KVM_MEMORY_ATTRIBUTE_PRIVATE for
> KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to userspace but either are
> controlled by kvm_arch_has_private_mem() which should be rewritten by
> architecture code.

Could we perhaps rename KVM_MEM_PRIVATE to KVM_MEM_PROTECTED, to be in
line with KVM_X86_PROTECTED_VM?

I feel that a memslot that has the KVM_MEM_PRIVATE flag need not always
be private; It can sometimes be providing memory that is shared and
also accessible from the host.

KVM_MEMORY_ATTRIBUTE_PRIVATE is fine as-is because this flag is set when
the guest memory is meant to be backed by private memory.

KVM_MEMORY_EXIT_FLAG_PRIVATE is also okay because the flag is used to
indicate when the memory error is caused by a private access (as opposed
to a shared access).

kvm_slot_can_be_private() could perhaps be renamed kvm_is_protected_slot()?


> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> ---
>   arch/x86/include/asm/kvm_host.h |   1 +
>   arch/x86/kvm/x86.c              |  13 +++
>   include/linux/kvm_host.h        |   3 +
>   virt/kvm/kvm_main.c             | 179 +++++++++++++++++++++++++++++++-
>   4 files changed, 191 insertions(+), 5 deletions(-)

> diff --git a/arch/x86/include/asm/kvm_host.h  
> b/arch/x86/include/asm/kvm_host.h
> index 7772ab37ac89..27ef31133352 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -114,6 +114,7 @@
>   	KVM_ARCH_REQ_FLAGS(31, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>   #define KVM_REQ_HV_TLB_FLUSH \
>   	KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> +#define KVM_REQ_MEMORY_MCE		KVM_ARCH_REQ(33)

>   #define CR0_RESERVED_BITS                                               \
>   	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5aefcff614d2..c67e22f3e2ee 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6587,6 +6587,13 @@ int kvm_arch_pm_notifier(struct kvm *kvm, unsigned  
> long state)
>   }
>   #endif /* CONFIG_HAVE_KVM_PM_NOTIFIER */

> +#ifdef CONFIG_HAVE_KVM_RESTRICTED_MEM
> +void kvm_arch_memory_mce(struct kvm *kvm)
> +{
> +	kvm_make_all_cpus_request(kvm, KVM_REQ_MEMORY_MCE);
> +}
> +#endif
> +
>   static int kvm_vm_ioctl_get_clock(struct kvm *kvm, void __user *argp)
>   {
>   	struct kvm_clock_data data = { 0 };
> @@ -10357,6 +10364,12 @@ static int vcpu_enter_guest(struct kvm_vcpu  
> *vcpu)

>   		if (kvm_check_request(KVM_REQ_UPDATE_CPU_DIRTY_LOGGING, vcpu))
>   			static_call(kvm_x86_update_cpu_dirty_logging)(vcpu);
> +
> +		if (kvm_check_request(KVM_REQ_MEMORY_MCE, vcpu)) {
> +			vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
> +			r = 0;
> +			goto out;
> +		}
>   	}

>   	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 153842bb33df..f032d878e034 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -590,6 +590,7 @@ struct kvm_memory_slot {
>   	struct file *restricted_file;
>   	loff_t restricted_offset;
>   	struct restrictedmem_notifier notifier;
> +	struct kvm *kvm;
>   };

>   static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot  
> *slot)
> @@ -2363,6 +2364,8 @@ static inline int kvm_restricted_mem_get_pfn(struct  
> kvm_memory_slot *slot,
>   	*pfn = page_to_pfn(page);
>   	return ret;
>   }
> +
> +void kvm_arch_memory_mce(struct kvm *kvm);
>   #endif /* CONFIG_HAVE_KVM_RESTRICTED_MEM */

>   #endif
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e107afea32f0..ac835fc77273 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -936,6 +936,121 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)

>   #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */

> +#ifdef CONFIG_HAVE_KVM_RESTRICTED_MEM
> +static bool restrictedmem_range_is_valid(struct kvm_memory_slot *slot,
> +					 pgoff_t start, pgoff_t end,
> +					 gfn_t *gfn_start, gfn_t *gfn_end)
> +{
> +	unsigned long base_pgoff = slot->restricted_offset >> PAGE_SHIFT;
> +
> +	if (start > base_pgoff)
> +		*gfn_start = slot->base_gfn + start - base_pgoff;
> +	else
> +		*gfn_start = slot->base_gfn;
> +
> +	if (end < base_pgoff + slot->npages)
> +		*gfn_end = slot->base_gfn + end - base_pgoff;
> +	else
> +		*gfn_end = slot->base_gfn + slot->npages;
> +
> +	if (*gfn_start >= *gfn_end)
> +		return false;
> +
> +	return true;
> +}
> +
> +static void kvm_restrictedmem_invalidate_begin(struct  
> restrictedmem_notifier *notifier,
> +					       pgoff_t start, pgoff_t end)
> +{
> +	struct kvm_memory_slot *slot = container_of(notifier,
> +						    struct kvm_memory_slot,
> +						    notifier);
> +	struct kvm *kvm = slot->kvm;
> +	gfn_t gfn_start, gfn_end;
> +	struct kvm_gfn_range gfn_range;
> +	int idx;
> +
> +	if (!restrictedmem_range_is_valid(slot, start, end,
> +					  &gfn_start, &gfn_end))
> +		return;
> +
> +	gfn_range.start = gfn_start;
> +	gfn_range.end = gfn_end;
> +	gfn_range.slot = slot;
> +	gfn_range.pte = __pte(0);
> +	gfn_range.may_block = true;
> +
> +	idx = srcu_read_lock(&kvm->srcu);
> +	KVM_MMU_LOCK(kvm);
> +
> +	kvm_mmu_invalidate_begin(kvm);
> +	kvm_mmu_invalidate_range_add(kvm, gfn_start, gfn_end);
> +	if (kvm_unmap_gfn_range(kvm, &gfn_range))
> +		kvm_flush_remote_tlbs(kvm);
> +
> +	KVM_MMU_UNLOCK(kvm);
> +	srcu_read_unlock(&kvm->srcu, idx);
> +}
> +
> +static void kvm_restrictedmem_invalidate_end(struct  
> restrictedmem_notifier *notifier,
> +					     pgoff_t start, pgoff_t end)
> +{
> +	struct kvm_memory_slot *slot = container_of(notifier,
> +						    struct kvm_memory_slot,
> +						    notifier);
> +	struct kvm *kvm = slot->kvm;
> +	gfn_t gfn_start, gfn_end;
> +
> +	if (!restrictedmem_range_is_valid(slot, start, end,
> +					  &gfn_start, &gfn_end))
> +		return;
> +
> +	KVM_MMU_LOCK(kvm);
> +	kvm_mmu_invalidate_end(kvm);
> +	KVM_MMU_UNLOCK(kvm);
> +}
> +
> +static void kvm_restrictedmem_error(struct restrictedmem_notifier  
> *notifier,
> +				    pgoff_t start, pgoff_t end)
> +{
> +	struct kvm_memory_slot *slot = container_of(notifier,
> +						    struct kvm_memory_slot,
> +						    notifier);
> +	kvm_arch_memory_mce(slot->kvm);
> +}
> +
> +static struct restrictedmem_notifier_ops kvm_restrictedmem_notifier_ops  
> = {
> +	.invalidate_start = kvm_restrictedmem_invalidate_begin,
> +	.invalidate_end = kvm_restrictedmem_invalidate_end,
> +	.error = kvm_restrictedmem_error,
> +};
> +
> +static inline void kvm_restrictedmem_register(struct kvm_memory_slot  
> *slot)
> +{
> +	slot->notifier.ops = &kvm_restrictedmem_notifier_ops;
> +	restrictedmem_register_notifier(slot->restricted_file, &slot->notifier);
> +}
> +
> +static inline void kvm_restrictedmem_unregister(struct kvm_memory_slot  
> *slot)
> +{
> +	restrictedmem_unregister_notifier(slot->restricted_file,
> +					  &slot->notifier);
> +}
> +
> +#else /* !CONFIG_HAVE_KVM_RESTRICTED_MEM */
> +
> +static inline void kvm_restrictedmem_register(struct kvm_memory_slot  
> *slot)
> +{
> +	WARN_ON_ONCE(1);
> +}
> +
> +static inline void kvm_restrictedmem_unregister(struct kvm_memory_slot  
> *slot)
> +{
> +	WARN_ON_ONCE(1);
> +}
> +
> +#endif /* CONFIG_HAVE_KVM_RESTRICTED_MEM */
> +
>   #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>   static int kvm_pm_notifier_call(struct notifier_block *bl,
>   				unsigned long state,
> @@ -980,6 +1095,11 @@ static void kvm_destroy_dirty_bitmap(struct  
> kvm_memory_slot *memslot)
>   /* This does not remove the slot from struct kvm_memslots data  
> structures */
>   static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot  
> *slot)
>   {
> +	if (slot->flags & KVM_MEM_PRIVATE) {
> +		kvm_restrictedmem_unregister(slot);
> +		fput(slot->restricted_file);
> +	}
> +
>   	kvm_destroy_dirty_bitmap(slot);

>   	kvm_arch_free_memslot(kvm, slot);
> @@ -1551,10 +1671,14 @@ static void kvm_replace_memslot(struct kvm *kvm,
>   	}
>   }

> -static int check_memory_region_flags(const struct kvm_user_mem_region  
> *mem)
> +static int check_memory_region_flags(struct kvm *kvm,
> +				     const struct kvm_user_mem_region *mem)
>   {
>   	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;

> +	if (kvm_arch_has_private_mem(kvm))
> +		valid_flags |= KVM_MEM_PRIVATE;
> +
>   #ifdef __KVM_HAVE_READONLY_MEM
>   	valid_flags |= KVM_MEM_READONLY;
>   #endif
> @@ -1630,6 +1754,9 @@ static int kvm_prepare_memory_region(struct kvm  
> *kvm,
>   {
>   	int r;

> +	if (change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
> +		kvm_restrictedmem_register(new);
> +
>   	/*
>   	 * If dirty logging is disabled, nullify the bitmap; the old bitmap
>   	 * will be freed on "commit".  If logging is enabled in both old and
> @@ -1658,6 +1785,9 @@ static int kvm_prepare_memory_region(struct kvm  
> *kvm,
>   	if (r && new && new->dirty_bitmap && (!old || !old->dirty_bitmap))
>   		kvm_destroy_dirty_bitmap(new);

> +	if (r && change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
> +		kvm_restrictedmem_unregister(new);
> +
>   	return r;
>   }

> @@ -1963,7 +2093,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   	int as_id, id;
>   	int r;

> -	r = check_memory_region_flags(mem);
> +	r = check_memory_region_flags(kvm, mem);
>   	if (r)
>   		return r;

> @@ -1982,6 +2112,10 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
>   			mem->memory_size))
>   		return -EINVAL;
> +	if (mem->flags & KVM_MEM_PRIVATE &&
> +		(mem->restricted_offset & (PAGE_SIZE - 1) ||
> +		 mem->restricted_offset > U64_MAX - mem->memory_size))
> +		return -EINVAL;
>   	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
>   		return -EINVAL;
>   	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
> @@ -2020,6 +2154,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   		if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
>   			return -EINVAL;
>   	} else { /* Modify an existing slot. */
> +		/* Private memslots are immutable, they can only be deleted. */
> +		if (mem->flags & KVM_MEM_PRIVATE)
> +			return -EINVAL;
>   		if ((mem->userspace_addr != old->userspace_addr) ||
>   		    (npages != old->npages) ||
>   		    ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
> @@ -2048,10 +2185,28 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   	new->npages = npages;
>   	new->flags = mem->flags;
>   	new->userspace_addr = mem->userspace_addr;
> +	if (mem->flags & KVM_MEM_PRIVATE) {
> +		new->restricted_file = fget(mem->restricted_fd);
> +		if (!new->restricted_file ||
> +		    !file_is_restrictedmem(new->restricted_file)) {
> +			r = -EINVAL;
> +			goto out;
> +		}
> +		new->restricted_offset = mem->restricted_offset;
> +	}
> +
> +	new->kvm = kvm;

>   	r = kvm_set_memslot(kvm, old, new, change);
>   	if (r)
> -		kfree(new);
> +		goto out;
> +
> +	return 0;
> +
> +out:
> +	if (new->restricted_file)
> +		fput(new->restricted_file);
> +	kfree(new);
>   	return r;
>   }
>   EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
> @@ -2351,6 +2506,8 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm  
> *kvm,
>   #ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
>   static u64 kvm_supported_mem_attributes(struct kvm *kvm)
>   {
> +	if (kvm_arch_has_private_mem(kvm))
> +		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
>   	return 0;
>   }

> @@ -4822,16 +4979,28 @@ static long kvm_vm_ioctl(struct file *filp,
>   	}
>   	case KVM_SET_USER_MEMORY_REGION: {
>   		struct kvm_user_mem_region mem;
> -		unsigned long size = sizeof(struct kvm_userspace_memory_region);
> +		unsigned int flags_offset = offsetof(typeof(mem), flags);
> +		unsigned long size;
> +		u32 flags;

>   		kvm_sanity_check_user_mem_region_alias();

> +		memset(&mem, 0, sizeof(mem));
> +
>   		r = -EFAULT;
> +		if (get_user(flags, (u32 __user *)(argp + flags_offset)))
> +			goto out;
> +
> +		if (flags & KVM_MEM_PRIVATE)
> +			size = sizeof(struct kvm_userspace_memory_region_ext);
> +		else
> +			size = sizeof(struct kvm_userspace_memory_region);
> +
>   		if (copy_from_user(&mem, argp, size))
>   			goto out;

>   		r = -EINVAL;
> -		if (mem.flags & KVM_MEM_PRIVATE)
> +		if ((flags ^ mem.flags) & KVM_MEM_PRIVATE)
>   			goto out;

>   		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
