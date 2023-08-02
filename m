Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE8776D8B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 22:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjHBUb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 16:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjHBUbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:31:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68B526BB;
        Wed,  2 Aug 2023 13:31:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbdc05a93bso2300605ad.0;
        Wed, 02 Aug 2023 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691008282; x=1691613082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cVig7nVxAJnz5d000l87J4rtopwFhxXB+8Ok4r23Ka4=;
        b=s0Oex2eG7H06LbU+BJqKNRoDqdq6SwVlGg4mAPjExi760G3nVDGKHuQFwhOJMnirV1
         OKLik+MpcS8+IwYl3s3OejRgjqA6HtoV3QPNm1DEUoL3SzgMjQ00TPFsndCxIr3QW0RC
         WMDpGULuovGmqc69bhPGdXoIqbkhph2K3YUyE2dv1mhYnFSkQTtUqrpUma604U38aYr8
         9D7AXW+fVMz7xVm7jYpK10dbpi3cq8a3mFqPaCSb6NPtySxN/EUHo7wfBVJFWm+nWHlq
         kM91bY5x3tn/x/mUvpEp/WaK2AzxKcjD7XsK+rbwt0j14lHtrq8Pfrb4rvf3q+69F+Ed
         fwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691008282; x=1691613082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVig7nVxAJnz5d000l87J4rtopwFhxXB+8Ok4r23Ka4=;
        b=FLvmqhaPl6UVJI59WdwvkKtgYIdj/2p4M0okgyztZeV4THHFuLX32nuLVR0pux/3hB
         IsgKudrNzD25HhHnXUNCzfxxLrcM4mpXIvQPQlM4AxYDy9Ln1Hv4c2YhHVaOCQCwb0M6
         ILJYE6dAI8+idI2TH08M5kOYDdgxf4y8hbpcsl/s16+zsWwbflK3wrgvuiG1S/yI90wu
         4L8lMAv8BS1+aU5P536qw/n2eO2RzIC38deAbvG5/9/gaQ4iYdI87cknXiefXBAZOtqZ
         JSKzMIBVdivB80OwpqFkR4vDgUoHeP9E3g6I41t+170Ic+gLNXSUo1xge0YueUnEm8Y9
         8Brg==
X-Gm-Message-State: ABy/qLbkFHUP8PqpHmcEvi2VUxf77eRFyZLK7rAws1CHQP7WvVmefwtn
        /Heideq69zKQEue8d8m4pwE=
X-Google-Smtp-Source: APBJJlH5VQArJpLE0EyDQ3184KjZD6X3n94sC4DtbCtW1G2/IJAuWETgKgCABnbhQeEGgLwzvu5Ecw==
X-Received: by 2002:a17:903:485:b0:1b6:649b:92cc with SMTP id jj5-20020a170903048500b001b6649b92ccmr12847995plb.69.1691008281960;
        Wed, 02 Aug 2023 13:31:21 -0700 (PDT)
Received: from localhost ([192.55.55.51])
        by smtp.gmail.com with ESMTPSA id iy7-20020a170903130700b001b898595be7sm12815534plb.291.2023.08.02.13.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 13:31:21 -0700 (PDT)
Date:   Wed, 2 Aug 2023 13:31:19 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v11 08/29] KVM: Introduce per-page memory attributes
Message-ID: <20230802203119.GB2021422@ls.amr.corp.intel.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-9-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230718234512.1690985-9-seanjc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 04:44:51PM -0700,
Sean Christopherson <seanjc@google.com> wrote:

> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> In confidential computing usages, whether a page is private or shared is
> necessary information for KVM to perform operations like page fault
> handling, page zapping etc. There are other potential use cases for
> per-page memory attributes, e.g. to make memory read-only (or no-exec,
> or exec-only, etc.) without having to modify memslots.
> 
> Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
> userspace to operate on the per-page memory attributes.
>   - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
>     a guest memory range.
>   - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
>     memory attributes.
> 
> Use an xarray to store the per-page attributes internally, with a naive,
> not fully optimized implementation, i.e. prioritize correctness over
> performance for the initial implementation.
> 
> Because setting memory attributes is roughly analogous to mprotect() on
> memory that is mapped into the guest, zap existing mappings prior to
> updating the memory attributes.  Opportunistically provide an arch hook
> for the post-set path (needed to complete invalidation anyways) in
> anticipation of x86 needing the hook to update metadata related to
> determining whether or not a given gfn can be backed with various sizes
> of hugepages.
> 
> It's possible that future usages may not require an invalidation, e.g.
> if KVM ends up supporting RWX protections and userspace grants _more_
> protections, but again opt for simplicity and punt optimizations to
> if/when they are needed.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com
> Cc: Fuad Tabba <tabba@google.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  Documentation/virt/kvm/api.rst |  60 ++++++++++++
>  include/linux/kvm_host.h       |  14 +++
>  include/uapi/linux/kvm.h       |  14 +++
>  virt/kvm/Kconfig               |   4 +
>  virt/kvm/kvm_main.c            | 170 +++++++++++++++++++++++++++++++++
>  5 files changed, 262 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 34d4ce66e0c8..0ca8561775ac 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6068,6 +6068,56 @@ writes to the CNTVCT_EL0 and CNTPCT_EL0 registers using the SET_ONE_REG
>  interface. No error will be returned, but the resulting offset will not be
>  applied.
>  
> +4.139 KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES
> +-----------------------------------------
> +
> +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> +:Architectures: x86
> +:Type: vm ioctl
> +:Parameters: u64 memory attributes bitmask(out)
> +:Returns: 0 on success, <0 on error
> +
> +Returns supported memory attributes bitmask. Supported memory attributes will
> +have the corresponding bits set in u64 memory attributes bitmask.
> +
> +The following memory attributes are defined::
> +
> +  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> +
> +4.140 KVM_SET_MEMORY_ATTRIBUTES
> +-----------------------------------------
> +
> +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> +:Architectures: x86
> +:Type: vm ioctl
> +:Parameters: struct kvm_memory_attributes(in/out)
> +:Returns: 0 on success, <0 on error
> +
> +Sets memory attributes for pages in a guest memory range. Parameters are
> +specified via the following structure::
> +
> +  struct kvm_memory_attributes {
> +	__u64 address;
> +	__u64 size;
> +	__u64 attributes;
> +	__u64 flags;
> +  };
> +
> +The user sets the per-page memory attributes to a guest memory range indicated
> +by address/size, and in return KVM adjusts address and size to reflect the
> +actual pages of the memory range have been successfully set to the attributes.
> +If the call returns 0, "address" is updated to the last successful address + 1
> +and "size" is updated to the remaining address size that has not been set
> +successfully. The user should check the return value as well as the size to
> +decide if the operation succeeded for the whole range or not. The user may want
> +to retry the operation with the returned address/size if the previous range was
> +partially successful.
> +
> +Both address and size should be page aligned and the supported attributes can be
> +retrieved with KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES.
> +
> +The "flags" field may be used for future extensions and should be set to 0s.
> +
>  5. The kvm_run structure
>  ========================
>  
> @@ -8494,6 +8544,16 @@ block sizes is exposed in KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES as a
>  64-bit bitmap (each bit describing a block size). The default value is
>  0, to disable the eager page splitting.
>  
> +8.41 KVM_CAP_MEMORY_ATTRIBUTES
> +------------------------------
> +
> +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> +:Architectures: x86
> +:Type: vm
> +
> +This capability indicates KVM supports per-page memory attributes and ioctls
> +KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES/KVM_SET_MEMORY_ATTRIBUTES are available.
> +
>  9. Known KVM API problems
>  =========================
>  
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index e9ca49d451f3..97db63da6227 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -264,6 +264,7 @@ struct kvm_gfn_range {
>  	gfn_t end;
>  	union {
>  		pte_t pte;
> +		unsigned long attributes;
>  		u64 raw;
>  	} arg;
>  	bool may_block;
> @@ -809,6 +810,9 @@ struct kvm {
>  
>  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>  	struct notifier_block pm_notifier;
> +#endif
> +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> +	struct xarray mem_attr_array;
>  #endif
>  	char stats_id[KVM_STATS_NAME_SIZE];
>  };
> @@ -2301,4 +2305,14 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
>  /* Max number of entries allowed for each kvm dirty ring */
>  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
>  
> +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> +static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
> +{
> +	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
> +}
> +
> +bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> +					 struct kvm_gfn_range *range);
> +#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
> +
>  #endif
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6c6ed214b6ac..f065c57db327 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1211,6 +1211,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
>  #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
>  #define KVM_CAP_USER_MEMORY2 230
> +#define KVM_CAP_MEMORY_ATTRIBUTES 231
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> @@ -2270,4 +2271,17 @@ struct kvm_s390_zpci_op {
>  /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
>  #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
>  
> +/* Available with KVM_CAP_MEMORY_ATTRIBUTES */
> +#define KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES    _IOR(KVMIO,  0xd2, __u64)
> +#define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd3, struct kvm_memory_attributes)
> +
> +struct kvm_memory_attributes {
> +	__u64 address;
> +	__u64 size;
> +	__u64 attributes;
> +	__u64 flags;
> +};
> +
> +#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> +
>  #endif /* __LINUX_KVM_H */
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 2fa11bd26cfc..8375bc49f97d 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -99,3 +99,7 @@ config KVM_GENERIC_HARDWARE_ENABLING
>  config KVM_GENERIC_MMU_NOTIFIER
>         select MMU_NOTIFIER
>         bool
> +
> +config KVM_GENERIC_MEMORY_ATTRIBUTES
> +       select KVM_GENERIC_MMU_NOTIFIER
> +       bool
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index c14adf93daec..1a31bfa025b0 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -530,6 +530,7 @@ struct kvm_mmu_notifier_range {
>  	u64 end;
>  	union {
>  		pte_t pte;
> +		unsigned long attributes;
>  		u64 raw;
>  	} arg;
>  	gfn_handler_t handler;
> @@ -1175,6 +1176,9 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
>  	spin_lock_init(&kvm->mn_invalidate_lock);
>  	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
>  	xa_init(&kvm->vcpu_array);
> +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> +	xa_init(&kvm->mem_attr_array);
> +#endif
>  
>  	INIT_LIST_HEAD(&kvm->gpc_list);
>  	spin_lock_init(&kvm->gpc_lock);
> @@ -1346,6 +1350,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
>  		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
>  	}
> +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> +	xa_destroy(&kvm->mem_attr_array);
> +#endif
>  	cleanup_srcu_struct(&kvm->irq_srcu);
>  	cleanup_srcu_struct(&kvm->srcu);
>  	kvm_arch_free_vm(kvm);
> @@ -2346,6 +2353,145 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>  }
>  #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
>  
> +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> +static u64 kvm_supported_mem_attributes(struct kvm *kvm)
> +{
> +	return 0;
> +}
> +
> +static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
> +						 struct kvm_mmu_notifier_range *range)
> +{
> +	struct kvm_gfn_range gfn_range;
> +	struct kvm_memory_slot *slot;
> +	struct kvm_memslots *slots;
> +	struct kvm_memslot_iter iter;
> +	bool locked = false;
> +	bool ret = false;
> +	int i;
> +
> +	gfn_range.arg.raw = range->arg.raw;
> +	gfn_range.may_block = range->may_block;
> +
> +	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +		slots = __kvm_memslots(kvm, i);
> +
> +		kvm_for_each_memslot_in_gfn_range(&iter, slots, range->start, range->end) {
> +			slot = iter.slot;
> +			gfn_range.slot = slot;
> +
> +			gfn_range.start = max(range->start, slot->base_gfn);
> +			gfn_range.end = min(range->end, slot->base_gfn + slot->npages);
> +			if (gfn_range.start >= gfn_range.end)
> +				continue;
> +
> +			if (!locked) {
> +				locked = true;
> +				KVM_MMU_LOCK(kvm);
> +				if (!IS_KVM_NULL_FN(range->on_lock))
> +					range->on_lock(kvm);
> +			}
> +
> +			ret |= range->handler(kvm, &gfn_range);
> +		}
> +	}
> +
> +	if (range->flush_on_ret && ret)
> +		kvm_flush_remote_tlbs(kvm);
> +
> +	if (locked) {
> +		KVM_MMU_UNLOCK(kvm);
> +		if (!IS_KVM_NULL_FN(range->on_unlock))
> +			range->on_unlock(kvm);
> +	}
> +}
> +
> +static int kvm_vm_set_mem_attributes(struct kvm *kvm, unsigned long attributes,
> +				     gfn_t start, gfn_t end)
> +{
> +	struct kvm_mmu_notifier_range unmap_range = {
> +		.start = start,
> +		.end = end,
> +		.handler = kvm_mmu_unmap_gfn_range,
> +		.on_lock = kvm_mmu_invalidate_begin,
> +		.on_unlock = (void *)kvm_null_fn,
> +		.flush_on_ret = true,
> +		.may_block = true,
> +	};
> +	struct kvm_mmu_notifier_range post_set_range = {
> +		.start = start,
> +		.end = end,
> +		.arg.attributes = attributes,
> +		.handler = kvm_arch_post_set_memory_attributes,
> +		.on_lock = (void *)kvm_null_fn,
> +		.on_unlock = kvm_mmu_invalidate_end,


on_unlock is called after unlocking mmu_lock. So kvm::mmu_invalidate_in_progress
is touched out side of it.  Here is a quick fix.

 WARNING: CPU: 108 PID: 62218 at arch/x86/kvm/../../../virt/kvm/kvm_main.c:757 kvm_mmu_unmap_gfn_range+0x32/0x70 [kvm]
  ...
 RIP: 0010:kvm_mmu_unmap_gfn_range+0x32/0x70 [kvm]
  ...
 Call Trace:
  <TASK>
  kvm_gmem_invalidate_begin+0xd0/0x130 [kvm]
  kvm_gmem_fallocate+0x134/0x290 [kvm]
  vfs_fallocate+0x151/0x380
  __x64_sys_fallocate+0x3c/0x70
  do_syscall_64+0x40/0x90
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8


From c06084048271278d3508f534479b356f49f619ce Mon Sep 17 00:00:00 2001
Message-Id: <c06084048271278d3508f534479b356f49f619ce.1690873712.git.isaku.yamahata@intel.com>
From: Isaku Yamahata <isaku.yamahata@intel.com>
Date: Mon, 31 Jul 2023 22:58:15 -0700
Subject: [PATCH] KVM: guest_memfd(): protect kvm_mmu_invalidate_end()

kvm_mmu_invalidate_end() updates struct kvm::mmu_invalidate_in_progress
and it's protected by kvm::mmu_lock.  call kvm_mmu_invalidate_end() before
unlocking it. Not after the unlock.

Fixes: edd048ffeaf6 ("KVM: Introduce per-page memory attributes")
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 virt/kvm/kvm_main.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9b4759b6dd87..6947f776851b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -548,6 +548,7 @@ struct kvm_mmu_notifier_range {
 	} arg;
 	gfn_handler_t handler;
 	on_lock_fn_t on_lock;
+	on_unlock_fn_t before_unlock;
 	on_unlock_fn_t on_unlock;
 	bool flush_on_ret;
 	bool may_block;
@@ -644,6 +645,8 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 		kvm_flush_remote_tlbs(kvm);
 
 	if (locked) {
+		if (!IS_KVM_NULL_FN(range->before_unlock))
+			range->before_unlock(kvm);
 		KVM_MMU_UNLOCK(kvm);
 		if (!IS_KVM_NULL_FN(range->on_unlock))
 			range->on_unlock(kvm);
@@ -668,6 +671,7 @@ static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
 		.arg.pte	= pte,
 		.handler	= handler,
 		.on_lock	= (void *)kvm_null_fn,
+		.before_unlock	= (void *)kvm_null_fn,
 		.on_unlock	= (void *)kvm_null_fn,
 		.flush_on_ret	= true,
 		.may_block	= false,
@@ -687,6 +691,7 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
 		.end		= end,
 		.handler	= handler,
 		.on_lock	= (void *)kvm_null_fn,
+		.before_unlock	= (void *)kvm_null_fn,
 		.on_unlock	= (void *)kvm_null_fn,
 		.flush_on_ret	= false,
 		.may_block	= false,
@@ -791,6 +796,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 		.end		= range->end,
 		.handler	= kvm_mmu_unmap_gfn_range,
 		.on_lock	= kvm_mmu_invalidate_begin,
+		.before_unlock	= (void *)kvm_null_fn,
 		.on_unlock	= kvm_arch_guest_memory_reclaimed,
 		.flush_on_ret	= true,
 		.may_block	= mmu_notifier_range_blockable(range),
@@ -830,6 +836,8 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 
 void kvm_mmu_invalidate_end(struct kvm *kvm)
 {
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
 	/*
 	 * This sequence increase will notify the kvm page fault that
 	 * the page that is going to be mapped in the spte could have
@@ -861,6 +869,7 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 		.end		= range->end,
 		.handler	= (void *)kvm_null_fn,
 		.on_lock	= kvm_mmu_invalidate_end,
+		.before_unlock	= (void *)kvm_null_fn,
 		.on_unlock	= (void *)kvm_null_fn,
 		.flush_on_ret	= false,
 		.may_block	= mmu_notifier_range_blockable(range),
@@ -2466,6 +2475,8 @@ static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 		kvm_flush_remote_tlbs(kvm);
 
 	if (locked) {
+		if (!IS_KVM_NULL_FN(range->before_unlock))
+			range->before_unlock(kvm);
 		KVM_MMU_UNLOCK(kvm);
 		if (!IS_KVM_NULL_FN(range->on_unlock))
 			range->on_unlock(kvm);
@@ -2480,6 +2491,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, unsigned long attributes,
 		.end = end,
 		.handler = kvm_mmu_unmap_gfn_range,
 		.on_lock = kvm_mmu_invalidate_begin,
+		.before_unlock	= (void *)kvm_null_fn,
 		.on_unlock = (void *)kvm_null_fn,
 		.flush_on_ret = true,
 		.may_block = true,
@@ -2490,7 +2502,8 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, unsigned long attributes,
 		.arg.attributes = attributes,
 		.handler = kvm_arch_post_set_memory_attributes,
 		.on_lock = (void *)kvm_null_fn,
-		.on_unlock = kvm_mmu_invalidate_end,
+		.before_unlock = kvm_mmu_invalidate_end,
+		.on_unlock = (void *)kvm_null_fn,
 		.may_block = true,
 	};
 	unsigned long i;
-- 
2.25.1


-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
