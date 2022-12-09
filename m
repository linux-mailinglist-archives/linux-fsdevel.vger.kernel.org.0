Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD90647FEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 10:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiLIJLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Dec 2022 04:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiLIJLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:11:46 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3074461775
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Dec 2022 01:11:42 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a7so4271602ljq.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Dec 2022 01:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vVAuT2VAl8HSgBtmMoMcytfxocfU7OG7x60P/5jbFLQ=;
        b=lX5M+N/6bU4HIzuFDOOcutTJ/4Q4wYmGYE0aQSCJkT10nXdgln59BJXRkFyQvVtBfg
         5Tt+ADEuHwxHmYWoo9Avr1LCUAQ5cSF6A5zf8gI72s0fRtfnyf0vQUj3x8E1c2LjBzl0
         K60I9PxS15NPK0uquHBFD5VtNOw1H8O5dA3eHgkkIqlotUc7/39VG5f6pIvM2eG2i+CJ
         Lr4rd6idF3siurTwh8bixJsQbd3BYTtBz8sUkkIHej2slw5AjryLd9hFM3bIdZ78kB7W
         BwJe/q5Ph/mjCbzcRQAJJ2lfymeFTl0Bi7WPJQrQSAHK+WUOloI+x5ts/ZdjZovT9WRV
         q9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVAuT2VAl8HSgBtmMoMcytfxocfU7OG7x60P/5jbFLQ=;
        b=U3A1lU9nhO7W1+vWDrZT3NaQioUvB/BVnl6PXDdqymiGAYNbl17nzxFAi6Gdu7/HqW
         oz/5FiU4eFwqWkv9Vn3MQqKlOD3SFU4kmE1itlmGiWsj1Wp4hXr/DqEbOGxCpA2taOqh
         SBRUABTt3WWIYE4OM/3r6AtO45dsLq2OmDX2Yb48pT8Obgt8yJ+dXJBcxNiUbHY5Os5X
         hDoEEe8As6TJMDWikkMU3EkaWDhnu/ePamyfo0wi/8Y9JHCla8BBL0tFLPYzCAGRpRAZ
         FIa8meLMblubukO6EAYhE9+62PA1KoEiOduXb221+2Z8OAFm+ZTlR9ck0I7NqXpY/3Lw
         dK1Q==
X-Gm-Message-State: ANoB5pkIyUdtZuFK5I3u1jrsIho09i+Z1AExNPIFShA4kPp1AkNGL8/F
        ivVD/KE0AQXNE0H+VSGqIPrLEnixvIgwT4B1pRBxVg==
X-Google-Smtp-Source: AA0mqf7/rRxOZLXii+aeI9/qslxKjks6CQQi1s3lmRhVVbbNRaVxNPLR7lYmarjHgoPvJiZijDv4+WHvZ/AMjr/iK5c=
X-Received: by 2002:a2e:9256:0:b0:279:823d:77c7 with SMTP id
 v22-20020a2e9256000000b00279823d77c7mr18932642ljg.92.1670577100923; Fri, 09
 Dec 2022 01:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com> <20221202061347.1070246-10-chao.p.peng@linux.intel.com>
In-Reply-To: <20221202061347.1070246-10-chao.p.peng@linux.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 9 Dec 2022 09:11:04 +0000
Message-ID: <CA+EHjTzN1QGSnmT=JJuHwvrgBsD+Nev8+Db4DPPQoU-8k_432g@mail.gmail.com>
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
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
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        wei.w.wang@intel.com
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

On Fri, Dec 2, 2022 at 6:20 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> Register/unregister private memslot to fd-based memory backing store
> restrictedmem and implement the callbacks for restrictedmem_notifier:
>   - invalidate_start()/invalidate_end() to zap the existing memory
>     mappings in the KVM page table.
>   - error() to request KVM_REQ_MEMORY_MCE and later exit to userspace
>     with KVM_EXIT_SHUTDOWN.
>
> Expose KVM_MEM_PRIVATE for memslot and KVM_MEMORY_ATTRIBUTE_PRIVATE for
> KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to userspace but either are
> controlled by kvm_arch_has_private_mem() which should be rewritten by
> architecture code.
>
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>

With the code to port it to pKVM/arm64:
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  arch/x86/include/asm/kvm_host.h |   1 +
>  arch/x86/kvm/x86.c              |  13 +++
>  include/linux/kvm_host.h        |   3 +
>  virt/kvm/kvm_main.c             | 179 +++++++++++++++++++++++++++++++-
>  4 files changed, 191 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 7772ab37ac89..27ef31133352 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -114,6 +114,7 @@
>         KVM_ARCH_REQ_FLAGS(31, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_HV_TLB_FLUSH \
>         KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> +#define KVM_REQ_MEMORY_MCE             KVM_ARCH_REQ(33)
>
>  #define CR0_RESERVED_BITS                                               \
>         (~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5aefcff614d2..c67e22f3e2ee 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6587,6 +6587,13 @@ int kvm_arch_pm_notifier(struct kvm *kvm, unsigned long state)
>  }
>  #endif /* CONFIG_HAVE_KVM_PM_NOTIFIER */
>
> +#ifdef CONFIG_HAVE_KVM_RESTRICTED_MEM
> +void kvm_arch_memory_mce(struct kvm *kvm)
> +{
> +       kvm_make_all_cpus_request(kvm, KVM_REQ_MEMORY_MCE);
> +}
> +#endif
> +
>  static int kvm_vm_ioctl_get_clock(struct kvm *kvm, void __user *argp)
>  {
>         struct kvm_clock_data data = { 0 };
> @@ -10357,6 +10364,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>
>                 if (kvm_check_request(KVM_REQ_UPDATE_CPU_DIRTY_LOGGING, vcpu))
>                         static_call(kvm_x86_update_cpu_dirty_logging)(vcpu);
> +
> +               if (kvm_check_request(KVM_REQ_MEMORY_MCE, vcpu)) {
> +                       vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
> +                       r = 0;
> +                       goto out;
> +               }
>         }
>
>         if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 153842bb33df..f032d878e034 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -590,6 +590,7 @@ struct kvm_memory_slot {
>         struct file *restricted_file;
>         loff_t restricted_offset;
>         struct restrictedmem_notifier notifier;
> +       struct kvm *kvm;
>  };
>
>  static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
> @@ -2363,6 +2364,8 @@ static inline int kvm_restricted_mem_get_pfn(struct kvm_memory_slot *slot,
>         *pfn = page_to_pfn(page);
>         return ret;
>  }
> +
> +void kvm_arch_memory_mce(struct kvm *kvm);
>  #endif /* CONFIG_HAVE_KVM_RESTRICTED_MEM */
>
>  #endif
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e107afea32f0..ac835fc77273 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -936,6 +936,121 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>
>  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
>
> +#ifdef CONFIG_HAVE_KVM_RESTRICTED_MEM
> +static bool restrictedmem_range_is_valid(struct kvm_memory_slot *slot,
> +                                        pgoff_t start, pgoff_t end,
> +                                        gfn_t *gfn_start, gfn_t *gfn_end)
> +{
> +       unsigned long base_pgoff = slot->restricted_offset >> PAGE_SHIFT;
> +
> +       if (start > base_pgoff)
> +               *gfn_start = slot->base_gfn + start - base_pgoff;
> +       else
> +               *gfn_start = slot->base_gfn;
> +
> +       if (end < base_pgoff + slot->npages)
> +               *gfn_end = slot->base_gfn + end - base_pgoff;
> +       else
> +               *gfn_end = slot->base_gfn + slot->npages;
> +
> +       if (*gfn_start >= *gfn_end)
> +               return false;
> +
> +       return true;
> +}
> +
> +static void kvm_restrictedmem_invalidate_begin(struct restrictedmem_notifier *notifier,
> +                                              pgoff_t start, pgoff_t end)
> +{
> +       struct kvm_memory_slot *slot = container_of(notifier,
> +                                                   struct kvm_memory_slot,
> +                                                   notifier);
> +       struct kvm *kvm = slot->kvm;
> +       gfn_t gfn_start, gfn_end;
> +       struct kvm_gfn_range gfn_range;
> +       int idx;
> +
> +       if (!restrictedmem_range_is_valid(slot, start, end,
> +                                         &gfn_start, &gfn_end))
> +               return;
> +
> +       gfn_range.start = gfn_start;
> +       gfn_range.end = gfn_end;
> +       gfn_range.slot = slot;
> +       gfn_range.pte = __pte(0);
> +       gfn_range.may_block = true;
> +
> +       idx = srcu_read_lock(&kvm->srcu);
> +       KVM_MMU_LOCK(kvm);
> +
> +       kvm_mmu_invalidate_begin(kvm);
> +       kvm_mmu_invalidate_range_add(kvm, gfn_start, gfn_end);
> +       if (kvm_unmap_gfn_range(kvm, &gfn_range))
> +               kvm_flush_remote_tlbs(kvm);
> +
> +       KVM_MMU_UNLOCK(kvm);
> +       srcu_read_unlock(&kvm->srcu, idx);
> +}
> +
> +static void kvm_restrictedmem_invalidate_end(struct restrictedmem_notifier *notifier,
> +                                            pgoff_t start, pgoff_t end)
> +{
> +       struct kvm_memory_slot *slot = container_of(notifier,
> +                                                   struct kvm_memory_slot,
> +                                                   notifier);
> +       struct kvm *kvm = slot->kvm;
> +       gfn_t gfn_start, gfn_end;
> +
> +       if (!restrictedmem_range_is_valid(slot, start, end,
> +                                         &gfn_start, &gfn_end))
> +               return;
> +
> +       KVM_MMU_LOCK(kvm);
> +       kvm_mmu_invalidate_end(kvm);
> +       KVM_MMU_UNLOCK(kvm);
> +}
> +
> +static void kvm_restrictedmem_error(struct restrictedmem_notifier *notifier,
> +                                   pgoff_t start, pgoff_t end)
> +{
> +       struct kvm_memory_slot *slot = container_of(notifier,
> +                                                   struct kvm_memory_slot,
> +                                                   notifier);
> +       kvm_arch_memory_mce(slot->kvm);
> +}
> +
> +static struct restrictedmem_notifier_ops kvm_restrictedmem_notifier_ops = {
> +       .invalidate_start = kvm_restrictedmem_invalidate_begin,
> +       .invalidate_end = kvm_restrictedmem_invalidate_end,
> +       .error = kvm_restrictedmem_error,
> +};
> +
> +static inline void kvm_restrictedmem_register(struct kvm_memory_slot *slot)
> +{
> +       slot->notifier.ops = &kvm_restrictedmem_notifier_ops;
> +       restrictedmem_register_notifier(slot->restricted_file, &slot->notifier);
> +}
> +
> +static inline void kvm_restrictedmem_unregister(struct kvm_memory_slot *slot)
> +{
> +       restrictedmem_unregister_notifier(slot->restricted_file,
> +                                         &slot->notifier);
> +}
> +
> +#else /* !CONFIG_HAVE_KVM_RESTRICTED_MEM */
> +
> +static inline void kvm_restrictedmem_register(struct kvm_memory_slot *slot)
> +{
> +       WARN_ON_ONCE(1);
> +}
> +
> +static inline void kvm_restrictedmem_unregister(struct kvm_memory_slot *slot)
> +{
> +       WARN_ON_ONCE(1);
> +}
> +
> +#endif /* CONFIG_HAVE_KVM_RESTRICTED_MEM */
> +
>  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>  static int kvm_pm_notifier_call(struct notifier_block *bl,
>                                 unsigned long state,
> @@ -980,6 +1095,11 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
>  /* This does not remove the slot from struct kvm_memslots data structures */
>  static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
>  {
> +       if (slot->flags & KVM_MEM_PRIVATE) {
> +               kvm_restrictedmem_unregister(slot);
> +               fput(slot->restricted_file);
> +       }
> +
>         kvm_destroy_dirty_bitmap(slot);
>
>         kvm_arch_free_memslot(kvm, slot);
> @@ -1551,10 +1671,14 @@ static void kvm_replace_memslot(struct kvm *kvm,
>         }
>  }
>
> -static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
> +static int check_memory_region_flags(struct kvm *kvm,
> +                                    const struct kvm_user_mem_region *mem)
>  {
>         u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
>
> +       if (kvm_arch_has_private_mem(kvm))
> +               valid_flags |= KVM_MEM_PRIVATE;
> +
>  #ifdef __KVM_HAVE_READONLY_MEM
>         valid_flags |= KVM_MEM_READONLY;
>  #endif
> @@ -1630,6 +1754,9 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
>  {
>         int r;
>
> +       if (change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
> +               kvm_restrictedmem_register(new);
> +
>         /*
>          * If dirty logging is disabled, nullify the bitmap; the old bitmap
>          * will be freed on "commit".  If logging is enabled in both old and
> @@ -1658,6 +1785,9 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
>         if (r && new && new->dirty_bitmap && (!old || !old->dirty_bitmap))
>                 kvm_destroy_dirty_bitmap(new);
>
> +       if (r && change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
> +               kvm_restrictedmem_unregister(new);
> +
>         return r;
>  }
>
> @@ -1963,7 +2093,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>         int as_id, id;
>         int r;
>
> -       r = check_memory_region_flags(mem);
> +       r = check_memory_region_flags(kvm, mem);
>         if (r)
>                 return r;
>
> @@ -1982,6 +2112,10 @@ int __kvm_set_memory_region(struct kvm *kvm,
>              !access_ok((void __user *)(unsigned long)mem->userspace_addr,
>                         mem->memory_size))
>                 return -EINVAL;
> +       if (mem->flags & KVM_MEM_PRIVATE &&
> +               (mem->restricted_offset & (PAGE_SIZE - 1) ||
> +                mem->restricted_offset > U64_MAX - mem->memory_size))
> +               return -EINVAL;
>         if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
>                 return -EINVAL;
>         if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
> @@ -2020,6 +2154,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
>                 if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
>                         return -EINVAL;
>         } else { /* Modify an existing slot. */
> +               /* Private memslots are immutable, they can only be deleted. */
> +               if (mem->flags & KVM_MEM_PRIVATE)
> +                       return -EINVAL;
>                 if ((mem->userspace_addr != old->userspace_addr) ||
>                     (npages != old->npages) ||
>                     ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
> @@ -2048,10 +2185,28 @@ int __kvm_set_memory_region(struct kvm *kvm,
>         new->npages = npages;
>         new->flags = mem->flags;
>         new->userspace_addr = mem->userspace_addr;
> +       if (mem->flags & KVM_MEM_PRIVATE) {
> +               new->restricted_file = fget(mem->restricted_fd);
> +               if (!new->restricted_file ||
> +                   !file_is_restrictedmem(new->restricted_file)) {
> +                       r = -EINVAL;
> +                       goto out;
> +               }
> +               new->restricted_offset = mem->restricted_offset;
> +       }
> +
> +       new->kvm = kvm;
>
>         r = kvm_set_memslot(kvm, old, new, change);
>         if (r)
> -               kfree(new);
> +               goto out;
> +
> +       return 0;
> +
> +out:
> +       if (new->restricted_file)
> +               fput(new->restricted_file);
> +       kfree(new);
>         return r;
>  }
>  EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
> @@ -2351,6 +2506,8 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>  #ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
>  static u64 kvm_supported_mem_attributes(struct kvm *kvm)
>  {
> +       if (kvm_arch_has_private_mem(kvm))
> +               return KVM_MEMORY_ATTRIBUTE_PRIVATE;
>         return 0;
>  }
>
> @@ -4822,16 +4979,28 @@ static long kvm_vm_ioctl(struct file *filp,
>         }
>         case KVM_SET_USER_MEMORY_REGION: {
>                 struct kvm_user_mem_region mem;
> -               unsigned long size = sizeof(struct kvm_userspace_memory_region);
> +               unsigned int flags_offset = offsetof(typeof(mem), flags);
> +               unsigned long size;
> +               u32 flags;
>
>                 kvm_sanity_check_user_mem_region_alias();
>
> +               memset(&mem, 0, sizeof(mem));
> +
>                 r = -EFAULT;
> +               if (get_user(flags, (u32 __user *)(argp + flags_offset)))
> +                       goto out;
> +
> +               if (flags & KVM_MEM_PRIVATE)
> +                       size = sizeof(struct kvm_userspace_memory_region_ext);
> +               else
> +                       size = sizeof(struct kvm_userspace_memory_region);
> +
>                 if (copy_from_user(&mem, argp, size))
>                         goto out;
>
>                 r = -EINVAL;
> -               if (mem.flags & KVM_MEM_PRIVATE)
> +               if ((flags ^ mem.flags) & KVM_MEM_PRIVATE)
>                         goto out;
>
>                 r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
> --
> 2.25.1
>
