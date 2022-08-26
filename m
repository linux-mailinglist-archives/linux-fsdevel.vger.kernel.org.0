Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFB95A2B26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 17:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbiHZP0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344618AbiHZPZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:25:00 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564D91277A
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 08:20:20 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11cb3c811d9so2454322fac.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LnlaNj9B+L8qD8SySo98BdJRZqoZyjH1j0JfraClBGM=;
        b=jQZE1HQ8XUmOwTx9VuUTkQ1QwqFUeVcXUQlff84j+5TQwQhxOPRsn5W6Cu4Fv3eh5p
         uyPpCi2LkGOZKqJCRs21OAextO8U6SKuJwhV5ompgLa4wlhdDPOiBHhXZadbAkLA+o3a
         c7H0xlbJP2mYtvdXXIUXXrQmVBZHg5mxGh3a3l5O2z71IsJiVvP/6wnyAa7tccYmjsEX
         1LJCa0h1nRtqLn66C/7ECUb4kyK3d7KBDj8ETVCusgGq2CqoQPR/Q4uIpS8cwuBA5RDr
         lA/7WmZZQZEmqY6fXWmlSYuBwmltvYsjXuZqRNqHCh4H0xGjMxBI62rrjEvA9hKmt6BO
         ARAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LnlaNj9B+L8qD8SySo98BdJRZqoZyjH1j0JfraClBGM=;
        b=CSDCg6Hw+Djs6GSa4zywVJnDMfjvGx09Uy2FLz4cH4xKzITTQUTyzqTRJ18Bq1lxBf
         lpb1J/rImTW4qPnHUwj7luCdrOUQTIWXGbYxN5uUy7MTuHY9VkB/kdeea8GCCIH/trFQ
         FPdH9VR47cn8FtNdGVJujPqtJ7dNxkOvvCZ8MlCeta/WaxxhC2o+urFjS/2bLx+UQfyH
         7uDJCWkyuiGSqYA0MXYn+PnASMLhKsZcJ9c3HiCtgPS++vzsD76LnXQC1Z1PMPUO7Kxj
         iUkzUkcoeVpwalNp4wq5YP0Skmx5OegTXkPnRhHzNr4Z3QdkAFWz+K8QaS37Q3w8LV/q
         8xGA==
X-Gm-Message-State: ACgBeo3lTIeFGl12pNSkj828MmaAuNRj9ahfD/FErBKsDqEV5L9HyYww
        p/94LEZ967flE44y+wxywh9+BXusV2i9theKmZka8g==
X-Google-Smtp-Source: AA6agR5BjNA54yR5ubjbKCPHP2DNzdCCyee7ywOjXj0TFGhkwYoCmomAytD83Szy0S5pAQq5JMRFO+0AjDyPBydia5U=
X-Received: by 2002:a05:6870:4783:b0:118:81e3:27ec with SMTP id
 c3-20020a056870478300b0011881e327ecmr2068774oaq.146.1661527219813; Fri, 26
 Aug 2022 08:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com> <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
In-Reply-To: <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 26 Aug 2022 16:19:43 +0100
Message-ID: <CA+EHjTzpb2PcGBbN61YqMWdQ5f-55Lt12ALHQ0pdwtGvV8nS8g@mail.gmail.com>
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
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
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Chao,

On Wed, Jul 6, 2022 at 9:27 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> If CONFIG_HAVE_KVM_PRIVATE_MEM=y, userspace can register/unregister the
> guest private memory regions through KVM_MEMORY_ENCRYPT_{UN,}REG_REGION
> ioctls. The patch reuses existing SEV ioctl but differs that the
> address in the region for private memory is gpa while SEV case it's hva.
>
> The private memory region is stored as xarray in KVM for memory
> efficiency in normal usages and zapping existing memory mappings is also
> a side effect of these two ioctls.
>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  Documentation/virt/kvm/api.rst  | 17 +++++++---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/Kconfig            |  1 +
>  arch/x86/kvm/mmu.h              |  2 --
>  include/linux/kvm_host.h        |  8 +++++
>  virt/kvm/kvm_main.c             | 57 +++++++++++++++++++++++++++++++++
>  6 files changed, 80 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 5ecfc7fbe0ee..dfb4caecab73 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -4715,10 +4715,19 @@ Documentation/virt/kvm/amd-memory-encryption.rst.
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
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index dae190e19fce..92120e3a224e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -37,6 +37,7 @@
>  #include <asm/hyperv-tlfs.h>
>
>  #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
> +#define __KVM_HAVE_ZAP_GFN_RANGE
>
>  #define KVM_MAX_VCPUS 1024
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 1f160801e2a7..05861b9656a4 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -50,6 +50,7 @@ config KVM
>         select HAVE_KVM_PM_NOTIFIER if PM
>         select HAVE_KVM_PRIVATE_MEM if X86_64
>         select MEMFILE_NOTIFIER if HAVE_KVM_PRIVATE_MEM
> +       select XARRAY_MULTI if HAVE_KVM_PRIVATE_MEM
>         help
>           Support hosting fully virtualized guest machines using hardware
>           virtualization extensions.  You will need a fairly recent
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index a99acec925eb..428cd2e88cbd 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -209,8 +209,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>         return -(u32)fault & errcode;
>  }
>
> -void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
> -
>  int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu);
>
>  int kvm_mmu_post_init_vm(struct kvm *kvm);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 1b203c8aa696..da33f8828456 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -260,6 +260,10 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
>  bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
>  #endif
>
> +#ifdef __KVM_HAVE_ZAP_GFN_RANGE
> +void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
> +#endif
> +
>  enum {
>         OUTSIDE_GUEST_MODE,
>         IN_GUEST_MODE,
> @@ -795,6 +799,9 @@ struct kvm {
>         struct notifier_block pm_notifier;
>  #endif
>         char stats_id[KVM_STATS_NAME_SIZE];
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +       struct xarray mem_attr_array;
> +#endif
>  };
>
>  #define kvm_err(fmt, ...) \
> @@ -1459,6 +1466,7 @@ bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
>  int kvm_arch_post_init_vm(struct kvm *kvm);
>  void kvm_arch_pre_destroy_vm(struct kvm *kvm);
>  int kvm_arch_create_vm_debugfs(struct kvm *kvm);
> +bool kvm_arch_private_mem_supported(struct kvm *kvm);
>
>  #ifndef __KVM_HAVE_ARCH_VM_ALLOC
>  /*
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 230c8ff9659c..bb714c2a4b06 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -914,6 +914,35 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>
>  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
>
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +#define KVM_MEM_ATTR_PRIVATE   0x0001
> +static int kvm_vm_ioctl_set_encrypted_region(struct kvm *kvm, unsigned int ioctl,
> +                                            struct kvm_enc_region *region)
> +{
> +       unsigned long start, end;
> +       void *entry;
> +       int r;
> +
> +       if (region->size == 0 || region->addr + region->size < region->addr)
> +               return -EINVAL;
> +       if (region->addr & (PAGE_SIZE - 1) || region->size & (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       start = region->addr >> PAGE_SHIFT;
> +       end = (region->addr + region->size - 1) >> PAGE_SHIFT;
> +
> +       entry = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION ?
> +                               xa_mk_value(KVM_MEM_ATTR_PRIVATE) : NULL;
> +
> +       r = xa_err(xa_store_range(&kvm->mem_attr_array, start, end,
> +                                       entry, GFP_KERNEL_ACCOUNT));
> +
> +       kvm_zap_gfn_range(kvm, start, end + 1);
> +
> +       return r;
> +}
> +#endif /* CONFIG_HAVE_KVM_PRIVATE_MEM */
> +
>  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>  static int kvm_pm_notifier_call(struct notifier_block *bl,
>                                 unsigned long state,
> @@ -1138,6 +1167,9 @@ static struct kvm *kvm_create_vm(unsigned long type)
>         spin_lock_init(&kvm->mn_invalidate_lock);
>         rcuwait_init(&kvm->mn_memslots_update_rcuwait);
>         xa_init(&kvm->vcpu_array);
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +       xa_init(&kvm->mem_attr_array);
> +#endif
>
>         INIT_LIST_HEAD(&kvm->gpc_list);
>         spin_lock_init(&kvm->gpc_lock);
> @@ -1305,6 +1337,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
>                 kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
>                 kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
>         }
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +       xa_destroy(&kvm->mem_attr_array);
> +#endif
>         cleanup_srcu_struct(&kvm->irq_srcu);
>         cleanup_srcu_struct(&kvm->srcu);
>         kvm_arch_free_vm(kvm);
> @@ -1508,6 +1543,11 @@ static void kvm_replace_memslot(struct kvm *kvm,
>         }
>  }
>
> +bool __weak kvm_arch_private_mem_supported(struct kvm *kvm)
> +{
> +       return false;
> +}
> +
>  static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
>  {
>         u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
> @@ -4689,6 +4729,22 @@ static long kvm_vm_ioctl(struct file *filp,
>                 r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
>                 break;
>         }
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +       case KVM_MEMORY_ENCRYPT_REG_REGION:
> +       case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
> +               struct kvm_enc_region region;
> +
> +               if (!kvm_arch_private_mem_supported(kvm))
> +                       goto arch_vm_ioctl;
> +
> +               r = -EFAULT;
> +               if (copy_from_user(&region, argp, sizeof(region)))
> +                       goto out;
> +
> +               r = kvm_vm_ioctl_set_encrypted_region(kvm, ioctl, &region);
> +               break;
> +       }
> +#endif
>         case KVM_GET_DIRTY_LOG: {
>                 struct kvm_dirty_log log;
>
> @@ -4842,6 +4898,7 @@ static long kvm_vm_ioctl(struct file *filp,
>                 r = kvm_vm_ioctl_get_stats_fd(kvm);
>                 break;
>         default:
> +arch_vm_ioctl:

It might be good to make this label conditional on
CONFIG_HAVE_KVM_PRIVATE_MEM, otherwise you get a warning if
CONFIG_HAVE_KVM_PRIVATE_MEM isn't defined.

+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
 arch_vm_ioctl:
+#endif

Cheers,
/fuad





>                 r = kvm_arch_vm_ioctl(filp, ioctl, arg);
>         }
>  out:
> --
> 2.25.1
>
