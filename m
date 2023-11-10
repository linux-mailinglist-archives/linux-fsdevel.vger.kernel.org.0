Return-Path: <linux-fsdevel+bounces-2671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC07E76E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 02:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE1F281715
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 01:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90981100;
	Fri, 10 Nov 2023 01:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jX7rqwdo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486BEA4;
	Fri, 10 Nov 2023 01:54:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABE244BA;
	Thu,  9 Nov 2023 17:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699581246; x=1731117246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/ir+TT9QA0tCXZ0ZfOcG8EVOXV1LHqiUY1q9ig2bjkM=;
  b=jX7rqwdoy7re55PLg9fCkFgsZrw/Y22aXr0qfLW4DxllkCBSmkDDr3sW
   Ft1wJtq5axm8hHUbJIA8lwuMx84i9rYhnwQapqB2SoHijp9A7pcolWAx/
   EdZVHubIT7skNAe4+2++dWpqTRlPc5pnziWJBMkwMZEumhTEKx4/PFqER
   0QNGgg4DOCLXzRPXGEW59DQTHI/68No3V0vt2EO1ar4WjvQ6cjJyWWvex
   A3kVtKnVyN5dnl9VDqP6iOS0LY6WBtpPCTsWgdL023pIE2ejh5GiorVcK
   d0s4hVHKuvdx27RUaqC2vIVO0RbwuIYfyd7j1s/BjjjaZmJFqbw2VYEcA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="456612338"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="456612338"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 17:54:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="713510691"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="713510691"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.9.145]) ([10.93.9.145])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 17:53:48 -0800
Message-ID: <956d8ee3-8b63-4a2d-b0c4-c0d3d74a0f6f@intel.com>
Date: Fri, 10 Nov 2023 09:53:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/34] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Sean Christopherson <seanjc@google.com>,
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
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
 <20231105163040.14904-16-pbonzini@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20231105163040.14904-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/2023 12:30 AM, Paolo Bonzini wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Introduce an ioctl(), KVM_CREATE_GUEST_MEMFD, to allow creating file-based
> memory that is tied to a specific KVM virtual machine and whose primary
> purpose is to serve guest memory.
> 
> A guest-first memory subsystem allows for optimizations and enhancements
> that are kludgy or outright infeasible to implement/support in a generic
> memory subsystem.  With guest_memfd, guest protections and mapping sizes
> are fully decoupled from host userspace mappings.   E.g. KVM currently
> doesn't support mapping memory as writable in the guest without it also
> being writable in host userspace, as KVM's ABI uses VMA protections to
> define the allow guest protection.  Userspace can fudge this by
> establishing two mappings, a writable mapping for the guest and readable
> one for itself, but that’s suboptimal on multiple fronts.
> 
> Similarly, KVM currently requires the guest mapping size to be a strict
> subset of the host userspace mapping size, e.g. KVM doesn’t support
> creating a 1GiB guest mapping unless userspace also has a 1GiB guest
> mapping.  Decoupling the mappings sizes would allow userspace to precisely
> map only what is needed without impacting guest performance, e.g. to
> harden against unintentional accesses to guest memory.
> 
> Decoupling guest and userspace mappings may also allow for a cleaner
> alternative to high-granularity mappings for HugeTLB, which has reached a
> bit of an impasse and is unlikely to ever be merged.
> 
> A guest-first memory subsystem also provides clearer line of sight to
> things like a dedicated memory pool (for slice-of-hardware VMs) and
> elimination of "struct page" (for offload setups where userspace _never_
> needs to mmap() guest memory).
> 
> More immediately, being able to map memory into KVM guests without mapping
> said memory into the host is critical for Confidential VMs (CoCo VMs), the
> initial use case for guest_memfd.  While AMD's SEV and Intel's TDX prevent
> untrusted software from reading guest private data by encrypting guest
> memory with a key that isn't usable by the untrusted host, projects such
> as Protected KVM (pKVM) provide confidentiality and integrity *without*
> relying on memory encryption.  And with SEV-SNP and TDX, accessing guest
> private memory can be fatal to the host, i.e. KVM must be prevent host
> userspace from accessing guest memory irrespective of hardware behavior.
> 
> Attempt #1 to support CoCo VMs was to add a VMA flag to mark memory as
> being mappable only by KVM (or a similarly enlightened kernel subsystem).
> That approach was abandoned largely due to it needing to play games with
> PROT_NONE to prevent userspace from accessing guest memory.
> 
> Attempt #2 to was to usurp PG_hwpoison to prevent the host from mapping
> guest private memory into userspace, but that approach failed to meet
> several requirements for software-based CoCo VMs, e.g. pKVM, as the kernel
> wouldn't easily be able to enforce a 1:1 page:guest association, let alone
> a 1:1 pfn:gfn mapping.  And using PG_hwpoison does not work for memory
> that isn't backed by 'struct page', e.g. if devices gain support for
> exposing encrypted memory regions to guests.
> 
> Attempt #3 was to extend the memfd() syscall and wrap shmem to provide
> dedicated file-based guest memory.  That approach made it as far as v10
> before feedback from Hugh Dickins and Christian Brauner (and others) led
> to it demise.
> 
> Hugh's objection was that piggybacking shmem made no sense for KVM's use
> case as KVM didn't actually *want* the features provided by shmem.  I.e.
> KVM was using memfd() and shmem to avoid having to manage memory directly,
> not because memfd() and shmem were the optimal solution, e.g. things like
> read/write/mmap in shmem were dead weight.
> 
> Christian pointed out flaws with implementing a partial overlay (wrapping
> only _some_ of shmem), e.g. poking at inode_operations or super_operations
> would show shmem stuff, but address_space_operations and file_operations
> would show KVM's overlay.  Paraphrashing heavily, Christian suggested KVM
> stop being lazy and create a proper API.
> 
> Link: https://lore.kernel.org/all/20201020061859.18385-1-kirill.shutemov@linux.intel.com
> Link: https://lore.kernel.org/all/20210416154106.23721-1-kirill.shutemov@linux.intel.com
> Link: https://lore.kernel.org/all/20210824005248.200037-1-seanjc@google.com
> Link: https://lore.kernel.org/all/20211111141352.26311-1-chao.p.peng@linux.intel.com
> Link: https://lore.kernel.org/all/20221202061347.1070246-1-chao.p.peng@linux.intel.com
> Link: https://lore.kernel.org/all/ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com
> Link: https://lore.kernel.org/all/20230418-anfallen-irdisch-6993a61be10b@brauner
> Link: https://lore.kernel.org/all/ZEM5Zq8oo+xnApW9@google.com
> Link: https://lore.kernel.org/linux-mm/20230306191944.GA15773@monkey
> Link: https://lore.kernel.org/linux-mm/ZII1p8ZHlHaQ3dDl@casper.infradead.org
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Vishal Annapurve <vannapurve@google.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Maciej Szmigiero <mail@maciej.szmigiero.name>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Quentin Perret <qperret@google.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Wang <wei.w.wang@intel.com>
> Cc: Liam Merwick <liam.merwick@oracle.com>
> Cc: Isaku Yamahata <isaku.yamahata@gmail.com>
> Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Co-developed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20231027182217.3615211-17-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   Documentation/virt/kvm/api.rst |  69 ++++-
>   fs/anon_inodes.c               |   1 +
>   include/linux/kvm_host.h       |  48 +++
>   include/uapi/linux/kvm.h       |  15 +-
>   virt/kvm/Kconfig               |   4 +
>   virt/kvm/Makefile.kvm          |   1 +
>   virt/kvm/guest_memfd.c         | 538 +++++++++++++++++++++++++++++++++
>   virt/kvm/kvm_main.c            |  59 +++-
>   virt/kvm/kvm_mm.h              |  26 ++
>   9 files changed, 754 insertions(+), 7 deletions(-)
>   create mode 100644 virt/kvm/guest_memfd.c
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 083ed507e200..6d681f45969e 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6202,6 +6202,15 @@ superset of the features supported by the system.
>   :Parameters: struct kvm_userspace_memory_region2 (in)
>   :Returns: 0 on success, -1 on error
>   
> +KVM_SET_USER_MEMORY_REGION2 is an extension to KVM_SET_USER_MEMORY_REGION that
> +allows mapping guest_memfd memory into a guest.  All fields shared with
> +KVM_SET_USER_MEMORY_REGION identically.  Userspace can set KVM_MEM_GUEST_MEMFD
> +in flags to have KVM bind the memory region to a given guest_memfd range of
> +[guest_memfd_offset, guest_memfd_offset + memory_size].  The target guest_memfd
> +must point at a file created via KVM_CREATE_GUEST_MEMFD on the current VM, and
> +the target range must not be bound to any other memory region.  All standard
> +bounds checks apply (use common sense).
> +
>   ::
>   
>     struct kvm_userspace_memory_region2 {
> @@ -6210,9 +6219,24 @@ superset of the features supported by the system.
>   	__u64 guest_phys_addr;
>   	__u64 memory_size; /* bytes */
>   	__u64 userspace_addr; /* start of the userspace allocated memory */
> +	__u64 guest_memfd_offset;
> +	__u32 guest_memfd;
> +	__u32 pad1;
> +	__u64 pad2[14];
>     };
>   
> -See KVM_SET_USER_MEMORY_REGION.
> +A KVM_MEM_GUEST_MEMFD region _must_ have a valid guest_memfd (private memory) and
> +userspace_addr (shared memory).  However, "valid" for userspace_addr simply
> +means that the address itself must be a legal userspace address.  The backing
> +mapping for userspace_addr is not required to be valid/populated at the time of
> +KVM_SET_USER_MEMORY_REGION2, e.g. shared memory can be lazily mapped/allocated
> +on-demand.
> +
> +When mapping a gfn into the guest, KVM selects shared vs. private, i.e consumes
> +userspace_addr vs. guest_memfd, based on the gfn's KVM_MEMORY_ATTRIBUTE_PRIVATE
> +state.  At VM creation time, all memory is shared, i.e. the PRIVATE attribute
> +is '0' for all gfns.  Userspace can control whether memory is shared/private by
> +toggling KVM_MEMORY_ATTRIBUTE_PRIVATE via KVM_SET_MEMORY_ATTRIBUTES as needed.
>   
>   4.141 KVM_SET_MEMORY_ATTRIBUTES
>   -------------------------------
> @@ -6250,6 +6274,49 @@ the state of a gfn/page as needed.
>   
>   The "flags" field is reserved for future extensions and must be '0'.
>   
> +4.142 KVM_CREATE_GUEST_MEMFD
> +----------------------------
> +
> +:Capability: KVM_CAP_GUEST_MEMFD
> +:Architectures: none
> +:Type: vm ioctl
> +:Parameters: struct kvm_create_guest_memfd(in)
> +:Returns: 0 on success, <0 on error
> +
> +KVM_CREATE_GUEST_MEMFD creates an anonymous file and returns a file descriptor
> +that refers to it.  guest_memfd files are roughly analogous to files created
> +via memfd_create(), e.g. guest_memfd files live in RAM, have volatile storage,
> +and are automatically released when the last reference is dropped.  Unlike
> +"regular" memfd_create() files, guest_memfd files are bound to their owning
> +virtual machine (see below), cannot be mapped, read, or written by userspace,
> +and cannot be resized  (guest_memfd files do however support PUNCH_HOLE).
> +
> +::
> +
> +  struct kvm_create_guest_memfd {
> +	__u64 size;
> +	__u64 flags;
> +	__u64 reserved[6];
> +  };
> +
> +Conceptually, the inode backing a guest_memfd file represents physical memory,
> +i.e. is coupled to the virtual machine as a thing, not to a "struct kvm".  The
> +file itself, which is bound to a "struct kvm", is that instance's view of the
> +underlying memory, e.g. effectively provides the translation of guest addresses
> +to host memory.  This allows for use cases where multiple KVM structures are
> +used to manage a single virtual machine, e.g. when performing intrahost
> +migration of a virtual machine.
> +
> +KVM currently only supports mapping guest_memfd via KVM_SET_USER_MEMORY_REGION2,
> +and more specifically via the guest_memfd and guest_memfd_offset fields in
> +"struct kvm_userspace_memory_region2", where guest_memfd_offset is the offset
> +into the guest_memfd instance.  For a given guest_memfd file, there can be at
> +most one mapping per page, i.e. binding multiple memory regions to a single
> +guest_memfd range is not allowed (any number of memory regions can be bound to
> +a single guest_memfd file, but the bound ranges must not overlap).
> +
> +See KVM_SET_USER_MEMORY_REGION2 for additional details.
> +
>   5. The kvm_run structure
>   ========================
>   
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 3d4a27f8b4fe..6f3d31b4d1e3 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -181,6 +181,7 @@ struct file *anon_inode_create_getfile(const char *name,
>   	return __anon_inode_getfile(name, fops, priv, flags,
>   				    context_inode, true);
>   }
> +EXPORT_SYMBOL_GPL(anon_inode_create_getfile);
>   
>   static int __anon_inode_getfd(const char *name,
>   			      const struct file_operations *fops,
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 68a144cb7dbc..a6de526c0426 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -589,8 +589,20 @@ struct kvm_memory_slot {
>   	u32 flags;
>   	short id;
>   	u16 as_id;
> +
> +#ifdef CONFIG_KVM_PRIVATE_MEM
> +	struct {
> +		struct file __rcu *file;
> +		pgoff_t pgoff;
> +	} gmem;
> +#endif
>   };
>   
> +static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
> +{
> +	return slot && (slot->flags & KVM_MEM_GUEST_MEMFD);
> +}
> +

maybe we can move this block and ...

<snip>

> @@ -2355,6 +2379,30 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>   					struct kvm_gfn_range *range);
>   bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>   					 struct kvm_gfn_range *range);
> +
> +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> +{
> +	return IS_ENABLED(CONFIG_KVM_PRIVATE_MEM) &&
> +	       kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +}
> +#else
> +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> +{
> +	return false;
> +}
>   #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */

this block to Patch 18?


<snip>

> @@ -4844,6 +4875,10 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>   #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>   	case KVM_CAP_MEMORY_ATTRIBUTES:
>   		return kvm_supported_mem_attributes(kvm);
> +#endif
> +#ifdef CONFIG_KVM_PRIVATE_MEM
> +	case KVM_CAP_GUEST_MEMFD:
> +		return !kvm || kvm_arch_has_private_mem(kvm);
>   #endif
>   	default:
>   		break;
> @@ -5277,6 +5312,18 @@ static long kvm_vm_ioctl(struct file *filp,
>   	case KVM_GET_STATS_FD:
>   		r = kvm_vm_ioctl_get_stats_fd(kvm);
>   		break;
> +#ifdef CONFIG_KVM_PRIVATE_MEM
> +	case KVM_CREATE_GUEST_MEMFD: {
> +		struct kvm_create_guest_memfd guest_memfd;

Do we need a guard of below?

		r = -EINVAL;
		if (!kvm_arch_has_private_mem(kvm))
			goto out;



> +		r = -EFAULT;
> +		if (copy_from_user(&guest_memfd, argp, sizeof(guest_memfd)))
> +			goto out;
> +
> +		r = kvm_gmem_create(kvm, &guest_memfd);
> +		break;
> +	}
> +#endif
>   	default:
>   		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
>   	}
> @@ -6409,6 +6456,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
>   	if (WARN_ON_ONCE(r))
>   		goto err_vfio;
>   
> +	kvm_gmem_init(module);
> +
>   	/*
>   	 * Registration _must_ be the very last thing done, as this exposes
>   	 * /dev/kvm to userspace, i.e. all infrastructure must be setup!
> diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
> index 180f1a09e6ba..ecefc7ec51af 100644
> --- a/virt/kvm/kvm_mm.h
> +++ b/virt/kvm/kvm_mm.h
> @@ -37,4 +37,30 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
>   }
>   #endif /* HAVE_KVM_PFNCACHE */
>   
> +#ifdef CONFIG_KVM_PRIVATE_MEM
> +void kvm_gmem_init(struct module *module);
> +int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
> +int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> +		  unsigned int fd, loff_t offset);
> +void kvm_gmem_unbind(struct kvm_memory_slot *slot);
> +#else
> +static inline void kvm_gmem_init(struct module *module)
> +{
> +
> +}
> +
> +static inline int kvm_gmem_bind(struct kvm *kvm,
> +					 struct kvm_memory_slot *slot,
> +					 unsigned int fd, loff_t offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return -EIO;
> +}
> +
> +static inline void kvm_gmem_unbind(struct kvm_memory_slot *slot)
> +{
> +	WARN_ON_ONCE(1);
> +}
> +#endif /* CONFIG_KVM_PRIVATE_MEM */
> +
>   #endif /* __KVM_MM_H__ */


