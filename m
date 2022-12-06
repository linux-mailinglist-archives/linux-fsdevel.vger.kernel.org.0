Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA296447AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 16:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiLFPLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 10:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiLFPL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:11:27 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BC42FFF5
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Dec 2022 07:08:17 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f16so5880916ljc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Dec 2022 07:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N3JrFiF0rAtuchgjYbmIFuxDgx6mEH12hqcfPr0ZYRM=;
        b=FmaE5dMqzoau8LX9lh0HQhLHWUhd1cdHHPYwFYlaI8TyXEet1aRTl/mbuwkrSKQ3h7
         19MOJqeEn53RrqqBVugS8WByrvp/McL/LgDO5c8IuX106UhFD/ZmZWH5yk8v3CL/75Mq
         5oja2HybW1h+PL6fLIN8YEke3oR/PzfFdwBmmDT0dbMdr7CHx79urBhuSJwlo02c3wte
         6N9xpdy+hyDRk868c6y6Di3ToJJV69jS0oW5yqOg1BYEw5BLVfm8j3wM4PC9kDDfLg9a
         UV0GCggY/ViEHBeH4Zkkb982icVkKhp6IQkfLeKiCHpoQEtoVmDLhJzAA1EGa6iWggSs
         fLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3JrFiF0rAtuchgjYbmIFuxDgx6mEH12hqcfPr0ZYRM=;
        b=FYG9daTUl8C6Y8YkH1BQFjsdcyPsij5XXnA0TLQ3IVrAlVE8K3gulKWN9X0X0393pL
         pME/gTzyhgFW7g51xih28mH91H0OPuGeWIR1Qc3yYSAz1nCXiWIPhnhVumyuANIlhR5k
         ciN15utYREiqa7AHHXeFeEMTfIBzXG8V40FLsQU69/AcHt8RjvlSSlbMQEf1ONlB95AO
         cSyYszpAlz7cgRzlZ+AqvCpBqiF/xLTWgJH14SdYeWVtRSQ+sMRofC8FCNJ5TaeIi3+w
         YzGjebcuH5nXbCJjWZ4aamjCRlLIH8KPuAG4hAZvdrbBlYCmczEvPQAEvqCYYxnW7znk
         XIDA==
X-Gm-Message-State: ANoB5pn2YlstmplOqxXG2ZLOaNR/uOyf+/fYiLXLUBbOE+7I031eg+VY
        jFXKuwwSeddfeAT7kVMMp3Fjh/PoE/3qZ7aSEmyvQg==
X-Google-Smtp-Source: AA0mqf5hY77RFuRDBbWFwLRnjhLNEp3Lvwr0fAYvK0ywFrz/dAlnsmzvepDe9P9eI8LmdXQa29pElCjo5wEagjpT+f8=
X-Received: by 2002:a2e:a544:0:b0:278:f5b8:82c8 with SMTP id
 e4-20020a2ea544000000b00278f5b882c8mr23082400ljn.228.1670339284027; Tue, 06
 Dec 2022 07:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com> <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
In-Reply-To: <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 6 Dec 2022 15:07:27 +0000
Message-ID: <CA+EHjTxXOdzcP25F57Mtmnb1NWyG5DcyqeDPqzjEOzRUrqH8FQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
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

On Fri, Dec 2, 2022 at 6:18 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
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
> KVM internally uses xarray to store the per-page memory attributes.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com/
> ---
>  Documentation/virt/kvm/api.rst | 63 ++++++++++++++++++++++++++++
>  arch/x86/kvm/Kconfig           |  1 +
>  include/linux/kvm_host.h       |  3 ++
>  include/uapi/linux/kvm.h       | 17 ++++++++
>  virt/kvm/Kconfig               |  3 ++
>  virt/kvm/kvm_main.c            | 76 ++++++++++++++++++++++++++++++++++
>  6 files changed, 163 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 5617bc4f899f..bb2f709c0900 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5952,6 +5952,59 @@ delivery must be provided via the "reg_aen" struct.
>  The "pad" and "reserved" fields may be used for future extensions and should be
>  set to 0s by userspace.
>
> +4.138 KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES
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
> +  #define KVM_MEMORY_ATTRIBUTE_READ              (1ULL << 0)
> +  #define KVM_MEMORY_ATTRIBUTE_WRITE             (1ULL << 1)
> +  #define KVM_MEMORY_ATTRIBUTE_EXECUTE           (1ULL << 2)
> +  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> +
> +4.139 KVM_SET_MEMORY_ATTRIBUTES
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
> +       __u64 address;
> +       __u64 size;
> +       __u64 attributes;
> +       __u64 flags;
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
> @@ -8270,6 +8323,16 @@ structure.
>  When getting the Modified Change Topology Report value, the attr->addr
>  must point to a byte where the value will be stored or retrieved from.
>
> +8.40 KVM_CAP_MEMORY_ATTRIBUTES
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
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index fbeaa9ddef59..a8e379a3afee 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -49,6 +49,7 @@ config KVM
>         select SRCU
>         select INTERVAL_TREE
>         select HAVE_KVM_PM_NOTIFIER if PM
> +       select HAVE_KVM_MEMORY_ATTRIBUTES
>         help
>           Support hosting fully virtualized guest machines using hardware
>           virtualization extensions.  You will need a fairly recent
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 8f874a964313..a784e2b06625 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -800,6 +800,9 @@ struct kvm {
>
>  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>         struct notifier_block pm_notifier;
> +#endif
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +       struct xarray mem_attr_array;
>  #endif
>         char stats_id[KVM_STATS_NAME_SIZE];
>  };
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 64dfe9c07c87..5d0941acb5bb 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1182,6 +1182,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_CPU_TOPOLOGY 222
>  #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
>  #define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
> +#define KVM_CAP_MEMORY_ATTRIBUTES 225
>
>  #ifdef KVM_CAP_IRQ_ROUTING
>
> @@ -2238,4 +2239,20 @@ struct kvm_s390_zpci_op {
>  /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
>  #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
>
> +/* Available with KVM_CAP_MEMORY_ATTRIBUTES */
> +#define KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES    _IOR(KVMIO,  0xd2, __u64)
> +#define KVM_SET_MEMORY_ATTRIBUTES              _IOWR(KVMIO,  0xd3, struct kvm_memory_attributes)
> +
> +struct kvm_memory_attributes {
> +       __u64 address;
> +       __u64 size;
> +       __u64 attributes;
> +       __u64 flags;
> +};
> +
> +#define KVM_MEMORY_ATTRIBUTE_READ              (1ULL << 0)
> +#define KVM_MEMORY_ATTRIBUTE_WRITE             (1ULL << 1)
> +#define KVM_MEMORY_ATTRIBUTE_EXECUTE           (1ULL << 2)
> +#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)

nit: how about using the BIT() macro for these?

> +
>  #endif /* __LINUX_KVM_H */
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 800f9470e36b..effdea5dd4f0 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -19,6 +19,9 @@ config HAVE_KVM_IRQ_ROUTING
>  config HAVE_KVM_DIRTY_RING
>         bool
>
> +config HAVE_KVM_MEMORY_ATTRIBUTES
> +       bool
> +
>  # Only strongly ordered architectures can select this, as it doesn't
>  # put any explicit constraint on userspace ordering. They can also
>  # select the _ACQ_REL version.
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1782c4555d94..7f0f5e9f2406 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1150,6 +1150,9 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
>         spin_lock_init(&kvm->mn_invalidate_lock);
>         rcuwait_init(&kvm->mn_memslots_update_rcuwait);
>         xa_init(&kvm->vcpu_array);
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +       xa_init(&kvm->mem_attr_array);
> +#endif
>
>         INIT_LIST_HEAD(&kvm->gpc_list);
>         spin_lock_init(&kvm->gpc_lock);
> @@ -1323,6 +1326,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
>                 kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
>                 kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
>         }
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +       xa_destroy(&kvm->mem_attr_array);
> +#endif
>         cleanup_srcu_struct(&kvm->irq_srcu);
>         cleanup_srcu_struct(&kvm->srcu);
>         kvm_arch_free_vm(kvm);
> @@ -2323,6 +2329,49 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>  }
>  #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
>
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +static u64 kvm_supported_mem_attributes(struct kvm *kvm)
> +{
> +       return 0;
> +}
> +
> +static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> +                                          struct kvm_memory_attributes *attrs)
> +{
> +       gfn_t start, end;
> +       unsigned long i;
> +       void *entry;
> +       u64 supported_attrs = kvm_supported_mem_attributes(kvm);
> +
> +       /* flags is currently not used. */

nit: "is reserved"? I think it makes it a bit clearer what its purpose is.

> +       if (attrs->flags)
> +               return -EINVAL;
> +       if (attrs->attributes & ~supported_attrs)
> +               return -EINVAL;
> +       if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
> +               return -EINVAL;
> +       if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
> +               return -EINVAL;
> +
> +       start = attrs->address >> PAGE_SHIFT;
> +       end = (attrs->address + attrs->size - 1 + PAGE_SIZE) >> PAGE_SHIFT;

Would using existing helpers be better for getting the frame numbers?
Also, the code checks that the address and size are page aligned, so
the end rounding up seems redundant, and might even be wrong if the
address+size-1 is close to the gfn_t limit (which this code tries to
avoid in an earlier check).

> +       entry = attrs->attributes ? xa_mk_value(attrs->attributes) : NULL;
> +
> +       mutex_lock(&kvm->lock);
> +       for (i = start; i < end; i++)
> +               if (xa_err(xa_store(&kvm->mem_attr_array, i, entry,
> +                                   GFP_KERNEL_ACCOUNT)))
> +                       break;
> +       mutex_unlock(&kvm->lock);
> +
> +       attrs->address = i << PAGE_SHIFT;
> +       attrs->size = (end - i) << PAGE_SHIFT;

nit: helpers for these too?

With the end calculation fixed,

Reviewed-by: Fuad Tabba <tabba@google.com>
After adding the necessary configs for arm64 (on qemu/arm64):
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> +
> +       return 0;
> +}
> +#endif /* CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES */
> +
>  struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
>  {
>         return __gfn_to_memslot(kvm_memslots(kvm), gfn);
> @@ -4459,6 +4508,9 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>  #ifdef CONFIG_HAVE_KVM_MSI
>         case KVM_CAP_SIGNAL_MSI:
>  #endif
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +       case KVM_CAP_MEMORY_ATTRIBUTES:
> +#endif
>  #ifdef CONFIG_HAVE_KVM_IRQFD
>         case KVM_CAP_IRQFD:
>         case KVM_CAP_IRQFD_RESAMPLE:
> @@ -4804,6 +4856,30 @@ static long kvm_vm_ioctl(struct file *filp,
>                 break;
>         }
>  #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +       case KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES: {
> +               u64 attrs = kvm_supported_mem_attributes(kvm);
> +
> +               r = -EFAULT;
> +               if (copy_to_user(argp, &attrs, sizeof(attrs)))
> +                       goto out;
> +               r = 0;
> +               break;
> +       }
> +       case KVM_SET_MEMORY_ATTRIBUTES: {
> +               struct kvm_memory_attributes attrs;
> +
> +               r = -EFAULT;
> +               if (copy_from_user(&attrs, argp, sizeof(attrs)))
> +                       goto out;
> +
> +               r = kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);
> +
> +               if (!r && copy_to_user(argp, &attrs, sizeof(attrs)))
> +                       r = -EFAULT;
> +               break;
> +       }
> +#endif /* CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES */
>         case KVM_CREATE_DEVICE: {
>                 struct kvm_create_device cd;
>
> --
> 2.25.1
>
