Return-Path: <linux-fsdevel+bounces-1609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED967DC45D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 03:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B0D2816DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 02:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283904C91;
	Tue, 31 Oct 2023 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzqfXbea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23C46B6;
	Tue, 31 Oct 2023 02:26:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CD5E4;
	Mon, 30 Oct 2023 19:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698719200; x=1730255200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1RxaiPSscGnriT5S1YWbGyKo7Yhdv1SBTp2kCHaOJTg=;
  b=lzqfXbea3Fak2kxKVwVBX2tCid17AqzoBpSJYL6nTbNtA9XBy8tsIntJ
   WebQmcaai0ZflO+qk66sHPHXUMyUeLkgaUZv56yEXTVhvUMiFm0EN+fe+
   HEl1Djoxao8IEVeW7rqCye+fyywJcK1yfKUYpYhqeriqC3TbGYyYhbieT
   womnNXkO0x+HUjh7V981e1kTukPsBqhOf/cP5kiTwu2dLyLrgHVzrkqxx
   gSoTVJWnrcvpfzbMOW8BiHfylFcVO+f9OzrOAHVuKCzV+zqlfPBXlVG3O
   viMYQm7xUMO6tFUjZOgET1NltLDG1IGxGNJsXUga0+WaK+lzJ1ohc0SVb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="373249634"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="373249634"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 19:26:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="8161358"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.9.145]) ([10.93.9.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 19:26:27 -0700
Message-ID: <2edd908a-9699-4d8e-9063-c655f1fc9712@intel.com>
Date: Tue, 31 Oct 2023 10:26:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 08/35] KVM: Introduce KVM_SET_USER_MEMORY_REGION2
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Xu Yilun <yilun.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Anish Moorthy <amoorthy@google.com>, David Matlack <dmatlack@google.com>,
 Yu Zhang <yu.c.zhang@linux.intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerley Tng <ackerleytng@google.com>,
 Maciej Szmigiero <mail@maciej.szmigiero.name>,
 David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>,
 Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>,
 Liam Merwick <liam.merwick@oracle.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-9-seanjc@google.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20231027182217.3615211-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/2023 2:21 AM, Sean Christopherson wrote:
> Introduce a "version 2" of KVM_SET_USER_MEMORY_REGION so that additional
> information can be supplied without setting userspace up to fail.  The
> padding in the new kvm_userspace_memory_region2 structure will be used to
> pass a file descriptor in addition to the userspace_addr, i.e. allow
> userspace to point at a file descriptor and map memory into a guest that
> is NOT mapped into host userspace.
> 
> Alternatively, KVM could simply add "struct kvm_userspace_memory_region2"
> without a new ioctl(), but as Paolo pointed out, adding a new ioctl()
> makes detection of bad flags a bit more robust, e.g. if the new fd field
> is guarded only by a flag and not a new ioctl(), then a userspace bug
> (setting a "bad" flag) would generate out-of-bounds access instead of an
> -EINVAL error.
> 
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   Documentation/virt/kvm/api.rst | 21 +++++++++++++++++++
>   arch/x86/kvm/x86.c             |  2 +-
>   include/linux/kvm_host.h       |  4 ++--
>   include/uapi/linux/kvm.h       | 13 ++++++++++++
>   virt/kvm/kvm_main.c            | 38 +++++++++++++++++++++++++++-------
>   5 files changed, 67 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 21a7578142a1..ace984acc125 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6070,6 +6070,27 @@ writes to the CNTVCT_EL0 and CNTPCT_EL0 registers using the SET_ONE_REG
>   interface. No error will be returned, but the resulting offset will not be
>   applied.
>   
> +4.139 KVM_SET_USER_MEMORY_REGION2
> +---------------------------------
> +
> +:Capability: KVM_CAP_USER_MEMORY2
> +:Architectures: all
> +:Type: vm ioctl
> +:Parameters: struct kvm_userspace_memory_region2 (in)
> +:Returns: 0 on success, -1 on error
> +
> +::
> +
> +  struct kvm_userspace_memory_region2 {
> +	__u32 slot;
> +	__u32 flags;
> +	__u64 guest_phys_addr;
> +	__u64 memory_size; /* bytes */
> +	__u64 userspace_addr; /* start of the userspace allocated memory */

missing

	__u64 pad[16];

> +  };
> +
> +See KVM_SET_USER_MEMORY_REGION.
> +
>   5. The kvm_run structure
>   ========================
>   
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 41cce5031126..6409914428ca 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12455,7 +12455,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
>   	}
>   
>   	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> -		struct kvm_userspace_memory_region m;
> +		struct kvm_userspace_memory_region2 m;
>   
>   		m.slot = id | (i << 16);
>   		m.flags = 0;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 5faba69403ac..4e741ff27af3 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1146,9 +1146,9 @@ enum kvm_mr_change {
>   };
>   
>   int kvm_set_memory_region(struct kvm *kvm,
> -			  const struct kvm_userspace_memory_region *mem);
> +			  const struct kvm_userspace_memory_region2 *mem);
>   int __kvm_set_memory_region(struct kvm *kvm,
> -			    const struct kvm_userspace_memory_region *mem);
> +			    const struct kvm_userspace_memory_region2 *mem);
>   void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
>   void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
>   int kvm_arch_prepare_memory_region(struct kvm *kvm,
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 13065dd96132..bd1abe067f28 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -95,6 +95,16 @@ struct kvm_userspace_memory_region {
>   	__u64 userspace_addr; /* start of the userspace allocated memory */
>   };
>   
> +/* for KVM_SET_USER_MEMORY_REGION2 */
> +struct kvm_userspace_memory_region2 {
> +	__u32 slot;
> +	__u32 flags;
> +	__u64 guest_phys_addr;
> +	__u64 memory_size;
> +	__u64 userspace_addr;
> +	__u64 pad[16];
> +};
> +
>   /*
>    * The bit 0 ~ bit 15 of kvm_userspace_memory_region::flags are visible for
>    * userspace, other bits are reserved for kvm internal use which are defined
> @@ -1192,6 +1202,7 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_CAP_COUNTER_OFFSET 227
>   #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
>   #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
> +#define KVM_CAP_USER_MEMORY2 230
>   
>   #ifdef KVM_CAP_IRQ_ROUTING
>   
> @@ -1473,6 +1484,8 @@ struct kvm_vfio_spapr_tce {
>   					struct kvm_userspace_memory_region)
>   #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
>   #define KVM_SET_IDENTITY_MAP_ADDR _IOW(KVMIO,  0x48, __u64)
> +#define KVM_SET_USER_MEMORY_REGION2 _IOW(KVMIO, 0x49, \
> +					 struct kvm_userspace_memory_region2)
>   
>   /* enable ucontrol for s390 */
>   struct kvm_s390_ucas_mapping {
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 6e708017064d..3f5b7c2c5327 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1578,7 +1578,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
>   	}
>   }
>   
> -static int check_memory_region_flags(const struct kvm_userspace_memory_region *mem)
> +static int check_memory_region_flags(const struct kvm_userspace_memory_region2 *mem)
>   {
>   	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
>   
> @@ -1980,7 +1980,7 @@ static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
>    * Must be called holding kvm->slots_lock for write.
>    */
>   int __kvm_set_memory_region(struct kvm *kvm,
> -			    const struct kvm_userspace_memory_region *mem)
> +			    const struct kvm_userspace_memory_region2 *mem)
>   {
>   	struct kvm_memory_slot *old, *new;
>   	struct kvm_memslots *slots;
> @@ -2084,7 +2084,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
>   
>   int kvm_set_memory_region(struct kvm *kvm,
> -			  const struct kvm_userspace_memory_region *mem)
> +			  const struct kvm_userspace_memory_region2 *mem)
>   {
>   	int r;
>   
> @@ -2096,7 +2096,7 @@ int kvm_set_memory_region(struct kvm *kvm,
>   EXPORT_SYMBOL_GPL(kvm_set_memory_region);
>   
>   static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
> -					  struct kvm_userspace_memory_region *mem)
> +					  struct kvm_userspace_memory_region2 *mem)
>   {
>   	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
>   		return -EINVAL;
> @@ -4566,6 +4566,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>   {
>   	switch (arg) {
>   	case KVM_CAP_USER_MEMORY:
> +	case KVM_CAP_USER_MEMORY2:
>   	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
>   	case KVM_CAP_JOIN_MEMORY_REGIONS_WORKS:
>   	case KVM_CAP_INTERNAL_ERROR_DATA:
> @@ -4821,6 +4822,14 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
>   	return fd;
>   }
>   
> +#define SANITY_CHECK_MEM_REGION_FIELD(field)					\
> +do {										\
> +	BUILD_BUG_ON(offsetof(struct kvm_userspace_memory_region, field) !=		\
> +		     offsetof(struct kvm_userspace_memory_region2, field));	\
> +	BUILD_BUG_ON(sizeof_field(struct kvm_userspace_memory_region, field) !=		\
> +		     sizeof_field(struct kvm_userspace_memory_region2, field));	\
> +} while (0)
> +
>   static long kvm_vm_ioctl(struct file *filp,
>   			   unsigned int ioctl, unsigned long arg)
>   {
> @@ -4843,15 +4852,28 @@ static long kvm_vm_ioctl(struct file *filp,
>   		r = kvm_vm_ioctl_enable_cap_generic(kvm, &cap);
>   		break;
>   	}
> +	case KVM_SET_USER_MEMORY_REGION2:
>   	case KVM_SET_USER_MEMORY_REGION: {
> -		struct kvm_userspace_memory_region kvm_userspace_mem;
> +		struct kvm_userspace_memory_region2 mem;
> +		unsigned long size;
> +
> +		if (ioctl == KVM_SET_USER_MEMORY_REGION)
> +			size = sizeof(struct kvm_userspace_memory_region);
> +		else
> +			size = sizeof(struct kvm_userspace_memory_region2);
> +
> +		/* Ensure the common parts of the two structs are identical. */
> +		SANITY_CHECK_MEM_REGION_FIELD(slot);
> +		SANITY_CHECK_MEM_REGION_FIELD(flags);
> +		SANITY_CHECK_MEM_REGION_FIELD(guest_phys_addr);
> +		SANITY_CHECK_MEM_REGION_FIELD(memory_size);
> +		SANITY_CHECK_MEM_REGION_FIELD(userspace_addr);
>   
>   		r = -EFAULT;
> -		if (copy_from_user(&kvm_userspace_mem, argp,
> -						sizeof(kvm_userspace_mem)))
> +		if (copy_from_user(&mem, argp, size))
>   			goto out;
>   
> -		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
> +		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
>   		break;
>   	}
>   	case KVM_GET_DIRTY_LOG: {


