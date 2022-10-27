Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131D660F558
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 12:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiJ0Kdd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 06:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbiJ0KdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:33:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD90422CA
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 03:32:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b2so1860224lfp.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 03:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w9inep0ICkxp/dh4usTOKJg2DS4O/PjgYL7PaxVj8nE=;
        b=He3KNTA1uzdE+/30x0YAVnNT5LBT5F0pcE0sreR/6bcka+epVOp76U2hyy/CJSoIWG
         JAihFvvF9sM2iIjsygXbKnpSRxID6/+2sxio+dS4ewdgbad1wi2NXa5tJu3x5tqeYAlv
         UtwVYg/Gcz+8DVhBpHR18MqsvICc+m4RrJNsqjJdudUlbeYy6aTkaIaf3eIv+ud8E0dS
         v0xM+7J9B5tIEL/Qk7yS0snDMleZCnQFQY8rFnBErl150YutcwpBck5S45m5SyeCV7IY
         /qppO0QgFlw/GYMI8ahdr8CaUo6HI4z+itdyiAxSpobBblxfNNpqOMXqWbb/ABnAhazV
         1utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9inep0ICkxp/dh4usTOKJg2DS4O/PjgYL7PaxVj8nE=;
        b=j7N+CnjkHSu9H8hjdaS2b/nwwF2DHAZzTYj0491WbC4WNi+WJn2DyOWPNykjaF4y1d
         mJSV/smFwLVHB8sQKq92ZGMo7GZ2aeheUMVYhfwdf6tQ3+3Xg98DFidAHMbXLSAse1du
         2uj7Y2zYL8alWtX4xc3sPCr9E7/7x/6YDIurZW2axCc7msHgXhL/Plj/spQAhXGEMDre
         w+U3auzSvl/+EhnF/pQdWjVTFNv0fK340xHvwKJ9say7U3SgPd+kSWU4JTmu822V5yA9
         m5MluXIxwDRy2OS7WD1ro061ea6KTNS0H481g93RaetG8xUk6ukg3ffMzAqPygiRO+5r
         J66g==
X-Gm-Message-State: ACrzQf3/bKeudNPyIT80cR44wH5tyAoVrS8XvoT54LivFGZcL9qe9OpJ
        /dV+jKWzcQxcC642NjNtzLp6UuzKbjF5ii/DHQmSJQ==
X-Google-Smtp-Source: AMsMyM5dAHAxPv2Bh6GmPPoRfi0elzyRurwu9CzNvbiRQf0ph34a5+/yC7zAjnQ5zj+Z1llGVrUaWyE+xmS18u2wiYI=
X-Received: by 2002:a05:6512:3119:b0:4a2:d749:ff82 with SMTP id
 n25-20020a056512311900b004a2d749ff82mr18771133lfb.637.1666866751285; Thu, 27
 Oct 2022 03:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com> <20221025151344.3784230-9-chao.p.peng@linux.intel.com>
In-Reply-To: <20221025151344.3784230-9-chao.p.peng@linux.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 27 Oct 2022 11:31:54 +0100
Message-ID: <CA+EHjTyL8A+dOMo98P0P-YMrAfYOyoBTeg=gwjfEe4mMxsSw2A@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] KVM: Enable and expose KVM_MEM_PRIVATE
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

On Tue, Oct 25, 2022 at 4:20 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> Expose KVM_MEM_PRIVATE and memslot fields restricted_fd/offset to
> userspace. KVM register/unregister private memslot to fd-based
> memory backing store and responses to invalidation event from
> restrictedmem_notifier to zap the existing memory mappings in the
> secondary page table.
>
> Whether KVM_MEM_PRIVATE is actually exposed to userspace is determined
> by architecture code which can turn on it by overriding the default
> kvm_arch_has_private_mem().
>
> A 'kvm' reference is added in memslot structure since in
> restrictedmem_notifier callback we can only obtain a memslot reference
> but 'kvm' is needed to do the zapping.
>
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/kvm_host.h |   3 +-
>  virt/kvm/kvm_main.c      | 174 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 171 insertions(+), 6 deletions(-)

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad


>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 69300fc6d572..e27d62c30484 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -246,7 +246,7 @@ int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
>  #endif
>
>
> -#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_KVM_GENERIC_PRIVATE_MEM)
> +#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_HAVE_KVM_RESTRICTED_MEM)
>  struct kvm_gfn_range {
>         struct kvm_memory_slot *slot;
>         gfn_t start;
> @@ -583,6 +583,7 @@ struct kvm_memory_slot {
>         struct file *restricted_file;
>         loff_t restricted_offset;
>         struct restrictedmem_notifier notifier;
> +       struct kvm *kvm;
>  };
>
>  static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 13a37b4d9e97..dae6a2c196ad 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1028,6 +1028,111 @@ static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
>  }
>  #endif /* CONFIG_KVM_GENERIC_PRIVATE_MEM */
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
> +                                               &gfn_start, &gfn_end))
> +               return;
> +
> +       idx = srcu_read_lock(&kvm->srcu);
> +       KVM_MMU_LOCK(kvm);
> +
> +       kvm_mmu_invalidate_begin(kvm, gfn_start, gfn_end);
> +
> +       gfn_range.start = gfn_start;
> +       gfn_range.end = gfn_end;
> +       gfn_range.slot = slot;
> +       gfn_range.pte = __pte(0);
> +       gfn_range.may_block = true;
> +
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
> +                                               &gfn_start, &gfn_end))
> +               return;
> +
> +       KVM_MMU_LOCK(kvm);
> +       kvm_mmu_invalidate_end(kvm, gfn_start, gfn_end);
> +       KVM_MMU_UNLOCK(kvm);
> +}
> +
> +static struct restrictedmem_notifier_ops kvm_restrictedmem_notifier_ops = {
> +       .invalidate_start = kvm_restrictedmem_invalidate_begin,
> +       .invalidate_end = kvm_restrictedmem_invalidate_end,
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
> @@ -1072,6 +1177,11 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
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
> @@ -1643,10 +1753,16 @@ bool __weak kvm_arch_has_private_mem(struct kvm *kvm)
>         return false;
>  }
>
> -static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
> +static int check_memory_region_flags(struct kvm *kvm,
> +                                    const struct kvm_user_mem_region *mem)
>  {
>         u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
>
> +#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
> +       if (kvm_arch_has_private_mem(kvm))
> +               valid_flags |= KVM_MEM_PRIVATE;
> +#endif
> +
>  #ifdef __KVM_HAVE_READONLY_MEM
>         valid_flags |= KVM_MEM_READONLY;
>  #endif
> @@ -1722,6 +1838,9 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
>  {
>         int r;
>
> +       if (change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
> +               kvm_restrictedmem_register(new);
> +
>         /*
>          * If dirty logging is disabled, nullify the bitmap; the old bitmap
>          * will be freed on "commit".  If logging is enabled in both old and
> @@ -1750,6 +1869,9 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
>         if (r && new && new->dirty_bitmap && (!old || !old->dirty_bitmap))
>                 kvm_destroy_dirty_bitmap(new);
>
> +       if (r && change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
> +               kvm_restrictedmem_unregister(new);
> +
>         return r;
>  }
>
> @@ -2047,7 +2169,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>         int as_id, id;
>         int r;
>
> -       r = check_memory_region_flags(mem);
> +       r = check_memory_region_flags(kvm, mem);
>         if (r)
>                 return r;
>
> @@ -2066,6 +2188,10 @@ int __kvm_set_memory_region(struct kvm *kvm,
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
> @@ -2104,6 +2230,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
>                 if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
>                         return -EINVAL;
>         } else { /* Modify an existing slot. */
> +               /* Private memslots are immutable, they can only be deleted. */
> +               if (mem->flags & KVM_MEM_PRIVATE)
> +                       return -EINVAL;
>                 if ((mem->userspace_addr != old->userspace_addr) ||
>                     (npages != old->npages) ||
>                     ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
> @@ -2132,10 +2261,28 @@ int __kvm_set_memory_region(struct kvm *kvm,
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
> @@ -4604,6 +4751,11 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>         case KVM_CAP_BINARY_STATS_FD:
>         case KVM_CAP_SYSTEM_EVENT_DATA:
>                 return 1;
> +#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
> +       case KVM_CAP_PRIVATE_MEM:
> +               return 1;
> +#endif
> +
>         default:
>                 break;
>         }
> @@ -4795,16 +4947,28 @@ static long kvm_vm_ioctl(struct file *filp,
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
