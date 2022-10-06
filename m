Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B912A5F6320
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiJFI4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 04:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJFI4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:56:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0FD97D4D
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 01:56:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r14so1735570lfm.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8RWQt9ojmR/E6rIyncCNc1lkldnlcrhWpGJj6b8ZrYc=;
        b=CT6RezdGJy/c1bZ4bgfPFQfXqCiDu0v/WOsA307v8CFvFhgi19voYrWIWcsxOIPnhf
         vwveJYqsSqB06IoqvGtY8YudsLZamRzjo0TV3seGFnKkUWQwgYtsT2H3AMFdqYRlYnZw
         JKyz2b7Rq6PGw+1vT9xW+mW/fvS93l4+JyApHzipdasVIQOsfHisPBGOpvg1Sv3FPvHE
         hIyDCkvvuf9TAGDTx78+y8cLJ9H3X9rmEwuugBMzeD2q0WsEZQkaS0I1evYwVfSYo1Z8
         jdcOboANrbo6N9LEUHor3pEDD28xFPI5OZHMxznJ3gIo0VfMkfaPutpCR2QHwHAWpqew
         iFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8RWQt9ojmR/E6rIyncCNc1lkldnlcrhWpGJj6b8ZrYc=;
        b=47YpKWcTJl6f8sTUYQ/Cv9a9how3buRSO+/1ZAeiM7ZWaXONTNSfeZr2+DbdOPKcjS
         pjwWG8NiZ1wBlQMz2E6PXmq/ls+89L2tOTgfG6NukI63eFQ0QSzyZQdaFdimPP0d+PW3
         vooz/BKbHp+KxQilUGHgfhWs7FZE2KpWUtMaACOvnksKQHKpE9PQrQH9IenVjnDtHL99
         VVpIx0B/0xfJIqPLSZVw4uSrJ7K27P9QpX9wtSjZV0Ct8vonV35fraxDDO88Eorz8wMb
         hydmAq/sPKn4omTxzWMHp/u9zmek803qjGZfKqZO8T77pUpJSqcqdeoqwFGJQiHuWEXG
         XVuA==
X-Gm-Message-State: ACrzQf30pqiW9dV5tFKrPl0CFbVobem46vpC4ds5qzuJtr6PHdywsVph
        jIrVTCkDpqDBVCjCbbVw2oRBGWUhdjtcm8Ha/9lrK+KEb2IpRFMr
X-Google-Smtp-Source: AMsMyM4bXmvIdym2WfRsWMI/tnfkvrSWBJtmv0RTGXMOpDJoCTIS+z2+pspjnZVrMWsgpd4rCXyB56J9s0gj2AriU7w=
X-Received: by 2002:a05:6512:32c7:b0:4a2:4544:120d with SMTP id
 f7-20020a05651232c700b004a24544120dmr1589446lfg.598.1665046567768; Thu, 06
 Oct 2022 01:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com> <20220915142913.2213336-9-chao.p.peng@linux.intel.com>
In-Reply-To: <20220915142913.2213336-9-chao.p.peng@linux.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 6 Oct 2022 09:55:31 +0100
Message-ID: <CA+EHjTwXPrHYb2us7+vrdS9jwYXv3j5UniG0bpb6dKgV77A=8A@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] KVM: Enable and expose KVM_MEM_PRIVATE
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Sep 15, 2022 at 3:37 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> Expose KVM_MEM_PRIVATE and memslot fields private_fd/offset to
> userspace. KVM will register/unregister private memslot to fd-based
> memory backing store and response to invalidation event from
> inaccessible_notifier to zap the existing memory mappings in the
> secondary page table.
>
> Whether KVM_MEM_PRIVATE is actually exposed to userspace is determined
> by architecture code which can turn on it by overriding the default
> kvm_arch_has_private_mem().
>
> A 'kvm' reference is added in memslot structure since in
> inaccessible_notifier callback we can only obtain a memslot reference
> but 'kvm' is needed to do the zapping.
>
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/kvm_host.h |   1 +
>  virt/kvm/kvm_main.c      | 116 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 111 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index b9906cdf468b..cb4eefac709c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -589,6 +589,7 @@ struct kvm_memory_slot {
>         struct file *private_file;
>         loff_t private_offset;
>         struct inaccessible_notifier notifier;
> +       struct kvm *kvm;
>  };
>
>  static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 97d893f7482c..87e239d35b96 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -983,6 +983,57 @@ static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
>                 xa_erase(&kvm->mem_attr_array, index);
>         return r;
>  }
> +
> +static void kvm_private_notifier_invalidate(struct inaccessible_notifier *notifier,
> +                                           pgoff_t start, pgoff_t end)
> +{
> +       struct kvm_memory_slot *slot = container_of(notifier,
> +                                                   struct kvm_memory_slot,
> +                                                   notifier);
> +       unsigned long base_pgoff = slot->private_offset >> PAGE_SHIFT;
> +       gfn_t start_gfn = slot->base_gfn;
> +       gfn_t end_gfn = slot->base_gfn + slot->npages;
> +
> +
> +       if (start > base_pgoff)
> +               start_gfn = slot->base_gfn + start - base_pgoff;
> +
> +       if (end < base_pgoff + slot->npages)
> +               end_gfn = slot->base_gfn + end - base_pgoff;
> +
> +       if (start_gfn >= end_gfn)
> +               return;
> +
> +       kvm_zap_gfn_range(slot->kvm, start_gfn, end_gfn);
> +}
> +
> +static struct inaccessible_notifier_ops kvm_private_notifier_ops = {
> +       .invalidate = kvm_private_notifier_invalidate,
> +};
> +
> +static inline void kvm_private_mem_register(struct kvm_memory_slot *slot)
> +{
> +       slot->notifier.ops = &kvm_private_notifier_ops;
> +       inaccessible_register_notifier(slot->private_file, &slot->notifier);
> +}
> +
> +static inline void kvm_private_mem_unregister(struct kvm_memory_slot *slot)
> +{
> +       inaccessible_unregister_notifier(slot->private_file, &slot->notifier);
> +}
> +
> +#else /* !CONFIG_HAVE_KVM_PRIVATE_MEM */
> +
> +static inline void kvm_private_mem_register(struct kvm_memory_slot *slot)
> +{
> +       WARN_ON_ONCE(1);
> +}
> +
> +static inline void kvm_private_mem_unregister(struct kvm_memory_slot *slot)
> +{
> +       WARN_ON_ONCE(1);
> +}
> +
>  #endif /* CONFIG_HAVE_KVM_PRIVATE_MEM */
>
>  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
> @@ -1029,6 +1080,11 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
>  /* This does not remove the slot from struct kvm_memslots data structures */
>  static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
>  {
> +       if (slot->flags & KVM_MEM_PRIVATE) {
> +               kvm_private_mem_unregister(slot);
> +               fput(slot->private_file);
> +       }
> +
>         kvm_destroy_dirty_bitmap(slot);
>
>         kvm_arch_free_memslot(kvm, slot);
> @@ -1600,10 +1656,16 @@ bool __weak kvm_arch_has_private_mem(struct kvm *kvm)
>         return false;
>  }
>
> -static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
> +static int check_memory_region_flags(struct kvm *kvm,
> +                                    const struct kvm_user_mem_region *mem)
>  {
>         u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
>
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +       if (kvm_arch_has_private_mem(kvm))
> +               valid_flags |= KVM_MEM_PRIVATE;
> +#endif
> +
>  #ifdef __KVM_HAVE_READONLY_MEM
>         valid_flags |= KVM_MEM_READONLY;
>  #endif
> @@ -1679,6 +1741,9 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
>  {
>         int r;
>
> +       if (change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
> +               kvm_private_mem_register(new);
> +

From the discussion I had with Kirill in the first patch *, should
this check that the private_fd is inaccessible?

[*] https://lore.kernel.org/all/20221003110129.bbee7kawhw5ed745@box.shutemov.name/

Cheers,
/fuad

>         /*
>          * If dirty logging is disabled, nullify the bitmap; the old bitmap
>          * will be freed on "commit".  If logging is enabled in both old and
> @@ -1707,6 +1772,9 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
>         if (r && new && new->dirty_bitmap && (!old || !old->dirty_bitmap))
>                 kvm_destroy_dirty_bitmap(new);
>
> +       if (r && change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
> +               kvm_private_mem_unregister(new);
> +
>         return r;
>  }
>
> @@ -2004,7 +2072,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>         int as_id, id;
>         int r;
>
> -       r = check_memory_region_flags(mem);
> +       r = check_memory_region_flags(kvm, mem);
>         if (r)
>                 return r;
>
> @@ -2023,6 +2091,10 @@ int __kvm_set_memory_region(struct kvm *kvm,
>              !access_ok((void __user *)(unsigned long)mem->userspace_addr,
>                         mem->memory_size))
>                 return -EINVAL;
> +       if (mem->flags & KVM_MEM_PRIVATE &&
> +               (mem->private_offset & (PAGE_SIZE - 1) ||
> +                mem->private_offset > U64_MAX - mem->memory_size))
> +               return -EINVAL;
>         if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
>                 return -EINVAL;
>         if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
> @@ -2061,6 +2133,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
>                 if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
>                         return -EINVAL;
>         } else { /* Modify an existing slot. */
> +               /* Private memslots are immutable, they can only be deleted. */
> +               if (mem->flags & KVM_MEM_PRIVATE)
> +                       return -EINVAL;
>                 if ((mem->userspace_addr != old->userspace_addr) ||
>                     (npages != old->npages) ||
>                     ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
> @@ -2089,10 +2164,27 @@ int __kvm_set_memory_region(struct kvm *kvm,
>         new->npages = npages;
>         new->flags = mem->flags;
>         new->userspace_addr = mem->userspace_addr;
> +       if (mem->flags & KVM_MEM_PRIVATE) {
> +               new->private_file = fget(mem->private_fd);
> +               if (!new->private_file) {
> +                       r = -EINVAL;
> +                       goto out;
> +               }
> +               new->private_offset = mem->private_offset;
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
> +       if (new->private_file)
> +               fput(new->private_file);
> +       kfree(new);
>         return r;
>  }
>  EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
> @@ -4747,16 +4839,28 @@ static long kvm_vm_ioctl(struct file *filp,
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
> -               if (copy_from_user(&mem, argp, size);
> +               if (get_user(flags, (u32 __user *)(argp + flags_offset)))
> +                       goto out;
> +
> +               if (flags & KVM_MEM_PRIVATE)
> +                       size = sizeof(struct kvm_userspace_memory_region_ext);
> +               else
> +                       size = sizeof(struct kvm_userspace_memory_region);
> +
> +               if (copy_from_user(&mem, argp, size))
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
