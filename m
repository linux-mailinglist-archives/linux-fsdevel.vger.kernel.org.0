Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF6B66D4F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 04:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbjAQDV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 22:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjAQDV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:21:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E41ABCC;
        Mon, 16 Jan 2023 19:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673925685; x=1705461685;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dHN1vav1t5EnRUr6UdHotg6czTkkjwNiQkXgUEZ1z7k=;
  b=SQ76ztvQGzjauPOfWo3ZTEkYmOqHokdrJW5YQD8U7Wd6iPIoUE/FqTun
   7W9j6F2W3waLWAz2THxOG7bZuErHnj6MRWhZbj+SJJBxrHK4m1vIZTyGh
   PHeqHJ/zJOce2T9jFWIu7e0J/LLx3xV1mOPSIHXmADJAH8R2XkPqsCLxe
   KALbmIIXdO7qmFiMatGEpZxgvMuzrR7B+5+K3K1P8CwRfv0ZkkQrozTjD
   G/rG+VlAwCfXeGx4SNDtocXeTXbReEWqYp5gsKLSUCF2SE67D31O/7BZi
   DMR5MRWAUwcxxjp6aJbVhrjSJ3ryavTts7kfnBWzu20hsVLnaJhyWwHqJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="323298309"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="323298309"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 19:21:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783096609"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="783096609"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.249.170.151]) ([10.249.170.151])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 19:21:13 -0800
Message-ID: <c25f1f8c-f7c0-6a96-cd67-260df47f79a9@linux.intel.com>
Date:   Tue, 17 Jan 2023 11:21:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/2/2022 2:13 PM, Chao Peng wrote:
> In confidential computing usages, whether a page is private or shared is
> necessary information for KVM to perform operations like page fault
> handling, page zapping etc. There are other potential use cases for
> per-page memory attributes, e.g. to make memory read-only (or no-exec,
> or exec-only, etc.) without having to modify memslots.
>
> Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
> userspace to operate on the per-page memory attributes.
>    - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
>      a guest memory range.
>    - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
>      memory attributes.
>
> KVM internally uses xarray to store the per-page memory attributes.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com/
> ---
>   Documentation/virt/kvm/api.rst | 63 ++++++++++++++++++++++++++++
>   arch/x86/kvm/Kconfig           |  1 +
>   include/linux/kvm_host.h       |  3 ++
>   include/uapi/linux/kvm.h       | 17 ++++++++

Should the changes introduced in this file also need to be added in 
tools/include/uapi/linux/kvm.h ?



>   virt/kvm/Kconfig               |  3 ++
>   virt/kvm/kvm_main.c            | 76 ++++++++++++++++++++++++++++++++++
>   6 files changed, 163 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 5617bc4f899f..bb2f709c0900 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5952,6 +5952,59 @@ delivery must be provided via the "reg_aen" struct.
>   The "pad" and "reserved" fields may be used for future extensions and should be
>   set to 0s by userspace.
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
>   5. The kvm_run structure
>   ========================
>   
> @@ -8270,6 +8323,16 @@ structure.
>   When getting the Modified Change Topology Report value, the attr->addr
>   must point to a byte where the value will be stored or retrieved from.
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
>   9. Known KVM API problems
>   =========================
>   
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index fbeaa9ddef59..a8e379a3afee 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -49,6 +49,7 @@ config KVM
>   	select SRCU
>   	select INTERVAL_TREE
>   	select HAVE_KVM_PM_NOTIFIER if PM
> +	select HAVE_KVM_MEMORY_ATTRIBUTES
>   	help
>   	  Support hosting fully virtualized guest machines using hardware
>   	  virtualization extensions.  You will need a fairly recent
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 8f874a964313..a784e2b06625 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -800,6 +800,9 @@ struct kvm {
>   
>   #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>   	struct notifier_block pm_notifier;
> +#endif
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +	struct xarray mem_attr_array;
>   #endif
>   	char stats_id[KVM_STATS_NAME_SIZE];
>   };
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 64dfe9c07c87..5d0941acb5bb 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1182,6 +1182,7 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_CAP_S390_CPU_TOPOLOGY 222
>   #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
>   #define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
> +#define KVM_CAP_MEMORY_ATTRIBUTES 225
>   
>   #ifdef KVM_CAP_IRQ_ROUTING
>   
> @@ -2238,4 +2239,20 @@ struct kvm_s390_zpci_op {
>   /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
>   #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
>   
> +/* Available with KVM_CAP_MEMORY_ATTRIBUTES */
> +#define KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES    _IOR(KVMIO,  0xd2, __u64)
> +#define KVM_SET_MEMORY_ATTRIBUTES              _IOWR(KVMIO,  0xd3, struct kvm_memory_attributes)
> +
> +struct kvm_memory_attributes {
> +	__u64 address;
> +	__u64 size;
> +	__u64 attributes;
> +	__u64 flags;
> +};
> +
> +#define KVM_MEMORY_ATTRIBUTE_READ              (1ULL << 0)
> +#define KVM_MEMORY_ATTRIBUTE_WRITE             (1ULL << 1)
> +#define KVM_MEMORY_ATTRIBUTE_EXECUTE           (1ULL << 2)
> +#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> +
>   #endif /* __LINUX_KVM_H */
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 800f9470e36b..effdea5dd4f0 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -19,6 +19,9 @@ config HAVE_KVM_IRQ_ROUTING
>   config HAVE_KVM_DIRTY_RING
>          bool
>   
> +config HAVE_KVM_MEMORY_ATTRIBUTES
> +       bool
> +
>   # Only strongly ordered architectures can select this, as it doesn't
>   # put any explicit constraint on userspace ordering. They can also
>   # select the _ACQ_REL version.
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1782c4555d94..7f0f5e9f2406 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1150,6 +1150,9 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
>   	spin_lock_init(&kvm->mn_invalidate_lock);
>   	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
>   	xa_init(&kvm->vcpu_array);
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +	xa_init(&kvm->mem_attr_array);
> +#endif
>   
>   	INIT_LIST_HEAD(&kvm->gpc_list);
>   	spin_lock_init(&kvm->gpc_lock);
> @@ -1323,6 +1326,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
>   		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
>   		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
>   	}
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +	xa_destroy(&kvm->mem_attr_array);
> +#endif
>   	cleanup_srcu_struct(&kvm->irq_srcu);
>   	cleanup_srcu_struct(&kvm->srcu);
>   	kvm_arch_free_vm(kvm);
> @@ -2323,6 +2329,49 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>   }
>   #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
>   
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +static u64 kvm_supported_mem_attributes(struct kvm *kvm)
> +{
> +	return 0;
> +}
> +
> +static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> +					   struct kvm_memory_attributes *attrs)
> +{
> +	gfn_t start, end;
> +	unsigned long i;
> +	void *entry;
> +	u64 supported_attrs = kvm_supported_mem_attributes(kvm);
> +
> +	/* flags is currently not used. */
> +	if (attrs->flags)
> +		return -EINVAL;
> +	if (attrs->attributes & ~supported_attrs)
> +		return -EINVAL;
> +	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
> +		return -EINVAL;
> +	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
> +		return -EINVAL;
> +
> +	start = attrs->address >> PAGE_SHIFT;
> +	end = (attrs->address + attrs->size - 1 + PAGE_SIZE) >> PAGE_SHIFT;
> +
> +	entry = attrs->attributes ? xa_mk_value(attrs->attributes) : NULL;
> +
> +	mutex_lock(&kvm->lock);
> +	for (i = start; i < end; i++)
> +		if (xa_err(xa_store(&kvm->mem_attr_array, i, entry,
> +				    GFP_KERNEL_ACCOUNT)))
> +			break;
> +	mutex_unlock(&kvm->lock);
> +
> +	attrs->address = i << PAGE_SHIFT;
> +	attrs->size = (end - i) << PAGE_SHIFT;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES */
> +
>   struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
>   {
>   	return __gfn_to_memslot(kvm_memslots(kvm), gfn);
> @@ -4459,6 +4508,9 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>   #ifdef CONFIG_HAVE_KVM_MSI
>   	case KVM_CAP_SIGNAL_MSI:
>   #endif
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +	case KVM_CAP_MEMORY_ATTRIBUTES:
> +#endif
>   #ifdef CONFIG_HAVE_KVM_IRQFD
>   	case KVM_CAP_IRQFD:
>   	case KVM_CAP_IRQFD_RESAMPLE:
> @@ -4804,6 +4856,30 @@ static long kvm_vm_ioctl(struct file *filp,
>   		break;
>   	}
>   #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +	case KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES: {
> +		u64 attrs = kvm_supported_mem_attributes(kvm);
> +
> +		r = -EFAULT;
> +		if (copy_to_user(argp, &attrs, sizeof(attrs)))
> +			goto out;
> +		r = 0;
> +		break;
> +	}
> +	case KVM_SET_MEMORY_ATTRIBUTES: {
> +		struct kvm_memory_attributes attrs;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&attrs, argp, sizeof(attrs)))
> +			goto out;
> +
> +		r = kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);
> +
> +		if (!r && copy_to_user(argp, &attrs, sizeof(attrs)))
> +			r = -EFAULT;
> +		break;
> +	}
> +#endif /* CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES */
>   	case KVM_CREATE_DEVICE: {
>   		struct kvm_create_device cd;
>   
