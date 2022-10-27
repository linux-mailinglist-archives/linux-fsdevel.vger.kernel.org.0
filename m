Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D280160F552
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 12:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiJ0Kc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 06:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiJ0Kcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:32:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EA7134AA4
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 03:32:07 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u11so1724751ljk.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 03:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jNSEaErO/uwx0UxPax4KC2vBkdxfs7VsIg1Le3NA31c=;
        b=SnrzAfFM96VcpdD6bFFDZcbhpgX0umktUo3F78F9iwrgguZgYZJpMI/grL4N7zv2h0
         4+qyORORi61vVI3BJAHhYy6aSTiyxAagys2s0ea0nz52MOJMv7bR1HgyLVgh6Kr68bxl
         TPtAY4eKo9D39CLRBTvvfhXPTNctl4CCU+DsvpEiLhZBqIznwsbuLsiuXly5YAxo64MV
         urR69tX55XZXFMqVDu6cf/x10OU9dV1C+u5m3S2majqPCmws/TwD+xlu6qYDopg3YKQl
         M+7VYGXns4OREB2CeJA+CXonTI9LaMeqNVu2l4L/hKfMLOvCVYITgNTMGWUsLW83Q/v+
         r3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNSEaErO/uwx0UxPax4KC2vBkdxfs7VsIg1Le3NA31c=;
        b=QupbhsQfQ0yTfgNAelfpw6YLXazVrdB6bb16aLzeHw95naYNp06+nUdFMTMnJf6lCT
         7g+uFP9gBnddLqI5acLrYsTHR493pfyp12eOaQ7JU1tVkKRWpLjyDlvKQyM9H/bKcB3l
         nSd1w5ivp77Wa3kLPvkniC6uIdxivDSYLA32rB2I5ePAzXo3IvoIFrLaYPSXQNXeY7lx
         d+5XbmHdRwYlKvCS6yYQb8JIvfNO5QmTR7Bdbtpo64VGF2sgA0GLWykMZaJVipx/crgK
         FJAxj3f4i0M6UL2DA5pYNxSX8k+0tBdXMY4dr3Tju1b/3hYvWr2m2/1VtZWMr3rnX+W9
         yyMA==
X-Gm-Message-State: ACrzQf0lNaqSzQ/OUOLpQ9JrPUNg34w4y4aLVJHPgAE0EQJklCK1XQQR
        M/2a4UOd5TieTZgQ09AftERQNvQVxzuCY1qyY+sZAg==
X-Google-Smtp-Source: AMsMyM6dLgZgNTmHkwgsr6goZfceFMnqtt4HLrVu8X5Y3mE4tRr1+vfYMYqrGqW99obRZ7LCxu6ZFc5bO9RO0LKS+4c=
X-Received: by 2002:a05:651c:1543:b0:26f:efb1:8119 with SMTP id
 y3-20020a05651c154300b0026fefb18119mr19262467ljp.159.1666866725607; Thu, 27
 Oct 2022 03:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com> <20221025151344.3784230-6-chao.p.peng@linux.intel.com>
In-Reply-To: <20221025151344.3784230-6-chao.p.peng@linux.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 27 Oct 2022 11:31:28 +0100
Message-ID: <CA+EHjTyLhkWq9EvvFtyMmHt+7fjHRpdbJ6RYOtrqdGvDWm4yhw@mail.gmail.com>
Subject: Re: [PATCH v9 5/8] KVM: Register/unregister the guest private memory regions
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, Oct 25, 2022 at 4:19 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> Introduce generic private memory register/unregister by reusing existing
> SEV ioctls KVM_MEMORY_ENCRYPT_{UN,}REG_REGION. It differs from SEV case
> by treating address in the region as gpa instead of hva. Which cases
> should these ioctls go is determined by the kvm_arch_has_private_mem().
> Architecture which supports KVM_PRIVATE_MEM should override this function.
>
> KVM internally defaults all guest memory as private memory and maintain
> the shared memory in 'mem_attr_array'. The above ioctls operate on this
> field and unmap existing mappings if any.
>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>  Documentation/virt/kvm/api.rst |  17 ++-
>  arch/x86/kvm/Kconfig           |   1 +
>  include/linux/kvm_host.h       |  10 +-
>  virt/kvm/Kconfig               |   4 +
>  virt/kvm/kvm_main.c            | 227 +++++++++++++++++++++++++--------
>  5 files changed, 198 insertions(+), 61 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 975688912b8c..08253cf498d1 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -4717,10 +4717,19 @@ Documentation/virt/kvm/x86/amd-memory-encryption.rst.
>  This ioctl can be used to register a guest memory region which may
>  contain encrypted data (e.g. guest RAM, SMRAM etc).
>
> -It is used in the SEV-enabled guest. When encryption is enabled, a guest
> -memory region may contain encrypted data. The SEV memory encryption
> -engine uses a tweak such that two identical plaintext pages, each at
> -different locations will have differing ciphertexts. So swapping or
> +Currently this ioctl supports registering memory regions for two usages:
> +private memory and SEV-encrypted memory.
> +
> +When private memory is enabled, this ioctl is used to register guest private
> +memory region and the addr/size of kvm_enc_region represents guest physical
> +address (GPA). In this usage, this ioctl zaps the existing guest memory
> +mappings in KVM that fallen into the region.
> +
> +When SEV-encrypted memory is enabled, this ioctl is used to register guest
> +memory region which may contain encrypted data for a SEV-enabled guest. The
> +addr/size of kvm_enc_region represents userspace address (HVA). The SEV
> +memory encryption engine uses a tweak such that two identical plaintext pages,
> +each at different locations will have differing ciphertexts. So swapping or
>  moving ciphertext of those pages will not result in plaintext being
>  swapped. So relocating (or migrating) physical backing pages for the SEV
>  guest will require some additional steps.
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 8d2bd455c0cd..73fdfa429b20 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -51,6 +51,7 @@ config KVM
>         select HAVE_KVM_PM_NOTIFIER if PM
>         select HAVE_KVM_RESTRICTED_MEM if X86_64
>         select RESTRICTEDMEM if HAVE_KVM_RESTRICTED_MEM
> +       select KVM_GENERIC_PRIVATE_MEM if HAVE_KVM_RESTRICTED_MEM
>         help
>           Support hosting fully virtualized guest machines using hardware
>           virtualization extensions.  You will need a fairly recent
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 79e5cbc35fcf..4ce98fa0153c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -245,7 +245,8 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
>  #endif
>
> -#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
> +
> +#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_KVM_GENERIC_PRIVATE_MEM)
>  struct kvm_gfn_range {
>         struct kvm_memory_slot *slot;
>         gfn_t start;
> @@ -254,6 +255,9 @@ struct kvm_gfn_range {
>         bool may_block;
>  };
>  bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
> +#endif
> +
> +#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
>  bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
>  bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
>  bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
> @@ -794,6 +798,9 @@ struct kvm {
>         struct notifier_block pm_notifier;
>  #endif
>         char stats_id[KVM_STATS_NAME_SIZE];
> +#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
> +       struct xarray mem_attr_array;
> +#endif
>  };
>
>  #define kvm_err(fmt, ...) \
> @@ -1453,6 +1460,7 @@ bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
>  int kvm_arch_post_init_vm(struct kvm *kvm);
>  void kvm_arch_pre_destroy_vm(struct kvm *kvm);
>  int kvm_arch_create_vm_debugfs(struct kvm *kvm);
> +bool kvm_arch_has_private_mem(struct kvm *kvm);
>
>  #ifndef __KVM_HAVE_ARCH_VM_ALLOC
>  /*
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 9ff164c7e0cc..69ca59e82149 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -89,3 +89,7 @@ config HAVE_KVM_PM_NOTIFIER
>
>  config HAVE_KVM_RESTRICTED_MEM
>         bool
> +
> +config KVM_GENERIC_PRIVATE_MEM
> +       bool
> +       depends on HAVE_KVM_RESTRICTED_MEM
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 09c9cdeb773c..fc3835826ace 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -520,6 +520,62 @@ void kvm_destroy_vcpus(struct kvm *kvm)
>  }
>  EXPORT_SYMBOL_GPL(kvm_destroy_vcpus);
>
> +static inline void update_invalidate_range(struct kvm *kvm, gfn_t start,
> +                                                           gfn_t end)
> +{
> +       if (likely(kvm->mmu_invalidate_in_progress == 1)) {
> +               kvm->mmu_invalidate_range_start = start;
> +               kvm->mmu_invalidate_range_end = end;
> +       } else {
> +               /*
> +                * Fully tracking multiple concurrent ranges has diminishing
> +                * returns. Keep things simple and just find the minimal range
> +                * which includes the current and new ranges. As there won't be
> +                * enough information to subtract a range after its invalidate
> +                * completes, any ranges invalidated concurrently will
> +                * accumulate and persist until all outstanding invalidates
> +                * complete.
> +                */
> +               kvm->mmu_invalidate_range_start =
> +                       min(kvm->mmu_invalidate_range_start, start);
> +               kvm->mmu_invalidate_range_end =
> +                       max(kvm->mmu_invalidate_range_end, end);
> +       }
> +}
> +
> +static void mark_invalidate_in_progress(struct kvm *kvm, gfn_t start, gfn_t end)
> +{
> +       /*
> +        * The count increase must become visible at unlock time as no
> +        * spte can be established without taking the mmu_lock and
> +        * count is also read inside the mmu_lock critical section.
> +        */
> +       kvm->mmu_invalidate_in_progress++;
> +}
> +
> +void kvm_mmu_invalidate_begin(struct kvm *kvm, gfn_t start, gfn_t end)
> +{
> +       mark_invalidate_in_progress(kvm, start, end);
> +       update_invalidate_range(kvm, start, end);
> +}
> +
> +void kvm_mmu_invalidate_end(struct kvm *kvm, gfn_t start, gfn_t end)
> +{
> +       /*
> +        * This sequence increase will notify the kvm page fault that
> +        * the page that is going to be mapped in the spte could have
> +        * been freed.
> +        */
> +       kvm->mmu_invalidate_seq++;
> +       smp_wmb();
> +       /*
> +        * The above sequence increase must be visible before the
> +        * below count decrease, which is ensured by the smp_wmb above
> +        * in conjunction with the smp_rmb in mmu_invalidate_retry().
> +        */
> +       kvm->mmu_invalidate_in_progress--;
> +}
> +
>  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
>  static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
>  {
> @@ -715,51 +771,12 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
>         kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
>  }
>
> -static inline void update_invalidate_range(struct kvm *kvm, gfn_t start,
> -                                                           gfn_t end)
> -{
> -       if (likely(kvm->mmu_invalidate_in_progress == 1)) {
> -               kvm->mmu_invalidate_range_start = start;
> -               kvm->mmu_invalidate_range_end = end;
> -       } else {
> -               /*
> -                * Fully tracking multiple concurrent ranges has diminishing
> -                * returns. Keep things simple and just find the minimal range
> -                * which includes the current and new ranges. As there won't be
> -                * enough information to subtract a range after its invalidate
> -                * completes, any ranges invalidated concurrently will
> -                * accumulate and persist until all outstanding invalidates
> -                * complete.
> -                */
> -               kvm->mmu_invalidate_range_start =
> -                       min(kvm->mmu_invalidate_range_start, start);
> -               kvm->mmu_invalidate_range_end =
> -                       max(kvm->mmu_invalidate_range_end, end);
> -       }
> -}
> -
> -static void mark_invalidate_in_progress(struct kvm *kvm, gfn_t start, gfn_t end)
> -{
> -       /*
> -        * The count increase must become visible at unlock time as no
> -        * spte can be established without taking the mmu_lock and
> -        * count is also read inside the mmu_lock critical section.
> -        */
> -       kvm->mmu_invalidate_in_progress++;
> -}
> -
>  static bool kvm_mmu_handle_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
>         update_invalidate_range(kvm, range->start, range->end);
>         return kvm_unmap_gfn_range(kvm, range);
>  }
>
> -void kvm_mmu_invalidate_begin(struct kvm *kvm, gfn_t start, gfn_t end)
> -{
> -       mark_invalidate_in_progress(kvm, start, end);
> -       update_invalidate_range(kvm, start, end);
> -}
> -
>  static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>                                         const struct mmu_notifier_range *range)
>  {
> @@ -807,23 +824,6 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>         return 0;
>  }
>
> -void kvm_mmu_invalidate_end(struct kvm *kvm, gfn_t start, gfn_t end)
> -{
> -       /*
> -        * This sequence increase will notify the kvm page fault that
> -        * the page that is going to be mapped in the spte could have
> -        * been freed.
> -        */
> -       kvm->mmu_invalidate_seq++;
> -       smp_wmb();
> -       /*
> -        * The above sequence increase must be visible before the
> -        * below count decrease, which is ensured by the smp_wmb above
> -        * in conjunction with the smp_rmb in mmu_invalidate_retry().
> -        */
> -       kvm->mmu_invalidate_in_progress--;
> -}
> -
>  static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
>                                         const struct mmu_notifier_range *range)
>  {
> @@ -937,6 +937,89 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>
>  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
>
> +#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
> +
> +static void kvm_unmap_mem_range(struct kvm *kvm, gfn_t start, gfn_t end)
> +{
> +       struct kvm_gfn_range gfn_range;
> +       struct kvm_memory_slot *slot;
> +       struct kvm_memslots *slots;
> +       struct kvm_memslot_iter iter;
> +       int i;
> +       int r = 0;
> +
> +       gfn_range.pte = __pte(0);
> +       gfn_range.may_block = true;
> +
> +       for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +               slots = __kvm_memslots(kvm, i);
> +
> +               kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
> +                       slot = iter.slot;
> +                       gfn_range.start = max(start, slot->base_gfn);
> +                       gfn_range.end = min(end, slot->base_gfn + slot->npages);
> +                       if (gfn_range.start >= gfn_range.end)
> +                               continue;
> +                       gfn_range.slot = slot;
> +
> +                       r |= kvm_unmap_gfn_range(kvm, &gfn_range);
> +               }
> +       }
> +
> +       if (r)
> +               kvm_flush_remote_tlbs(kvm);
> +}
> +
> +#define KVM_MEM_ATTR_SHARED    0x0001
> +static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
> +                                    bool is_private)
> +{
> +       gfn_t start, end;
> +       unsigned long i;
> +       void *entry;
> +       int idx;
> +       int r = 0;
> +
> +       if (size == 0 || gpa + size < gpa)
> +               return -EINVAL;
> +       if (gpa & (PAGE_SIZE - 1) || size & (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       start = gpa >> PAGE_SHIFT;
> +       end = (gpa + size - 1 + PAGE_SIZE) >> PAGE_SHIFT;
> +
> +       /*
> +        * Guest memory defaults to private, kvm->mem_attr_array only stores
> +        * shared memory.
> +        */
> +       entry = is_private ? NULL : xa_mk_value(KVM_MEM_ATTR_SHARED);
> +
> +       idx = srcu_read_lock(&kvm->srcu);
> +       KVM_MMU_LOCK(kvm);
> +       kvm_mmu_invalidate_begin(kvm, start, end);
> +
> +       for (i = start; i < end; i++) {
> +               r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
> +                                   GFP_KERNEL_ACCOUNT));
> +               if (r)
> +                       goto err;
> +       }
> +
> +       kvm_unmap_mem_range(kvm, start, end);
> +
> +       goto ret;
> +err:
> +       for (; i > start; i--)
> +               xa_erase(&kvm->mem_attr_array, i);
> +ret:
> +       kvm_mmu_invalidate_end(kvm, start, end);
> +       KVM_MMU_UNLOCK(kvm);
> +       srcu_read_unlock(&kvm->srcu, idx);
> +
> +       return r;
> +}
> +#endif /* CONFIG_KVM_GENERIC_PRIVATE_MEM */
> +
>  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>  static int kvm_pm_notifier_call(struct notifier_block *bl,
>                                 unsigned long state,
> @@ -1165,6 +1248,9 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
>         spin_lock_init(&kvm->mn_invalidate_lock);
>         rcuwait_init(&kvm->mn_memslots_update_rcuwait);
>         xa_init(&kvm->vcpu_array);
> +#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
> +       xa_init(&kvm->mem_attr_array);
> +#endif
>
>         INIT_LIST_HEAD(&kvm->gpc_list);
>         spin_lock_init(&kvm->gpc_lock);
> @@ -1338,6 +1424,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
>                 kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
>                 kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
>         }
> +#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
> +       xa_destroy(&kvm->mem_attr_array);
> +#endif
>         cleanup_srcu_struct(&kvm->irq_srcu);
>         cleanup_srcu_struct(&kvm->srcu);
>         kvm_arch_free_vm(kvm);
> @@ -1541,6 +1630,11 @@ static void kvm_replace_memslot(struct kvm *kvm,
>         }
>  }
>
> +bool __weak kvm_arch_has_private_mem(struct kvm *kvm)
> +{
> +       return false;
> +}
> +
>  static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
>  {
>         u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
> @@ -4708,6 +4802,24 @@ static long kvm_vm_ioctl(struct file *filp,
>                 r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
>                 break;
>         }
> +#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
> +       case KVM_MEMORY_ENCRYPT_REG_REGION:
> +       case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
> +               struct kvm_enc_region region;
> +               bool set = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION;
> +
> +               if (!kvm_arch_has_private_mem(kvm))
> +                       goto arch_vm_ioctl;
> +
> +               r = -EFAULT;
> +               if (copy_from_user(&region, argp, sizeof(region)))
> +                       goto out;
> +
> +               r = kvm_vm_ioctl_set_mem_attr(kvm, region.addr,
> +                                             region.size, set);
> +               break;
> +       }
> +#endif
>         case KVM_GET_DIRTY_LOG: {
>                 struct kvm_dirty_log log;
>
> @@ -4861,6 +4973,9 @@ static long kvm_vm_ioctl(struct file *filp,
>                 r = kvm_vm_ioctl_get_stats_fd(kvm);
>                 break;
>         default:
> +#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
> +arch_vm_ioctl:
> +#endif
>                 r = kvm_arch_vm_ioctl(filp, ioctl, arg);
>         }
>  out:
> --
> 2.25.1
>
