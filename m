Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696E76149C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 12:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKALtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 07:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiKALsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:48:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15361AD9E;
        Tue,  1 Nov 2022 04:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667302929; x=1698838929;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=fVnmfE4aAQhJRses/HkLxskjBJG6DmPsjixSgyOEAeU=;
  b=iaEpHSu2YlKrBePJq2R96njxAhZwSqfv+Utube6tNxS7V3g0mfPRnEyo
   II8haeBgnH6asY85war8AEUZEgEXuX4iKwdX+gUHH0CfFP1BFZU8qlqEY
   NPZxIo1yvdJ2tnr1sla+K+UeEq5Og5VGGT38OCsDnGuGZp+JRU3RXH6C7
   9W4glB9p8bf6bpN0nOo9LXjoC+auMfdQH9gHi3bhDSF/9lEXnj/q8235T
   CCvHcEYtp5BT0kson7QeGAtS4ttYSQQPH1vX6iuvkCLBy+NQaJzYnj98w
   sfo49A6w/aUA21aUCPvU+9CaerDZN1vaZsF32+6VMhFPrWXqL1hYYkfSB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="373331312"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="373331312"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 04:42:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="628549426"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="628549426"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 01 Nov 2022 04:41:57 -0700
Date:   Tue, 1 Nov 2022 19:37:29 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Michael Roth <michael.roth@amd.com>
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        mhocko@suse.com, Muchun Song <songmuchun@bytedance.com>,
        wei.w.wang@intel.com
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221101113729.GA4015495@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031174738.fklhlia5fmaiinpe@amd.com>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 12:47:38PM -0500, Michael Roth wrote:
> On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > Introduce 'memfd_restricted' system call with the ability to create
> > memory areas that are restricted from userspace access through ordinary
> > MMU operations (e.g. read/write/mmap). The memory content is expected to
> > be used through a new in-kernel interface by a third kernel module.
> > 
> > memfd_restricted() is useful for scenarios where a file descriptor(fd)
> > can be used as an interface into mm but want to restrict userspace's
> > ability on the fd. Initially it is designed to provide protections for
> > KVM encrypted guest memory.
> > 
> > Normally KVM uses memfd memory via mmapping the memfd into KVM userspace
> > (e.g. QEMU) and then using the mmaped virtual address to setup the
> > mapping in the KVM secondary page table (e.g. EPT). With confidential
> > computing technologies like Intel TDX, the memfd memory may be encrypted
> > with special key for special software domain (e.g. KVM guest) and is not
> > expected to be directly accessed by userspace. Precisely, userspace
> > access to such encrypted memory may lead to host crash so should be
> > prevented.
> > 
> > memfd_restricted() provides semantics required for KVM guest encrypted
> > memory support that a fd created with memfd_restricted() is going to be
> > used as the source of guest memory in confidential computing environment
> > and KVM can directly interact with core-mm without the need to expose
> > the memoy content into KVM userspace.
> > 
> > KVM userspace is still in charge of the lifecycle of the fd. It should
> > pass the created fd to KVM. KVM uses the new restrictedmem_get_page() to
> > obtain the physical memory page and then uses it to populate the KVM
> > secondary page table entries.
> > 
> > The userspace restricted memfd can be fallocate-ed or hole-punched
> > from userspace. When these operations happen, KVM can get notified
> > through restrictedmem_notifier, it then gets chance to remove any
> > mapped entries of the range in the secondary page tables.
> > 
> > memfd_restricted() itself is implemented as a shim layer on top of real
> > memory file systems (currently tmpfs). Pages in restrictedmem are marked
> > as unmovable and unevictable, this is required for current confidential
> > usage. But in future this might be changed.
> > 
> > By default memfd_restricted() prevents userspace read, write and mmap.
> > By defining new bit in the 'flags', it can be extended to support other
> > restricted semantics in the future.
> > 
> > The system call is currently wired up for x86 arch.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
> >  include/linux/restrictedmem.h          |  62 ++++++
> >  include/linux/syscalls.h               |   1 +
> >  include/uapi/asm-generic/unistd.h      |   5 +-
> >  include/uapi/linux/magic.h             |   1 +
> >  kernel/sys_ni.c                        |   3 +
> >  mm/Kconfig                             |   4 +
> >  mm/Makefile                            |   1 +
> >  mm/restrictedmem.c                     | 250 +++++++++++++++++++++++++
> >  10 files changed, 328 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/restrictedmem.h
> >  create mode 100644 mm/restrictedmem.c
> > 
> > diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> > index 320480a8db4f..dc70ba90247e 100644
> > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > @@ -455,3 +455,4 @@
> >  448	i386	process_mrelease	sys_process_mrelease
> >  449	i386	futex_waitv		sys_futex_waitv
> >  450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
> > +451	i386	memfd_restricted	sys_memfd_restricted
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index c84d12608cd2..06516abc8318 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -372,6 +372,7 @@
> >  448	common	process_mrelease	sys_process_mrelease
> >  449	common	futex_waitv		sys_futex_waitv
> >  450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
> > +451	common	memfd_restricted	sys_memfd_restricted
> >  
> >  #
> >  # Due to a historical design error, certain syscalls are numbered differently
> > diff --git a/include/linux/restrictedmem.h b/include/linux/restrictedmem.h
> > new file mode 100644
> > index 000000000000..9c37c3ea3180
> > --- /dev/null
> > +++ b/include/linux/restrictedmem.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _LINUX_RESTRICTEDMEM_H
> > +
> > +#include <linux/file.h>
> > +#include <linux/magic.h>
> > +#include <linux/pfn_t.h>
> > +
> > +struct restrictedmem_notifier;
> > +
> > +struct restrictedmem_notifier_ops {
> > +	void (*invalidate_start)(struct restrictedmem_notifier *notifier,
> > +				 pgoff_t start, pgoff_t end);
> > +	void (*invalidate_end)(struct restrictedmem_notifier *notifier,
> > +			       pgoff_t start, pgoff_t end);
> > +};
> > +
> > +struct restrictedmem_notifier {
> > +	struct list_head list;
> > +	const struct restrictedmem_notifier_ops *ops;
> > +};
> > +
> > +#ifdef CONFIG_RESTRICTEDMEM
> > +
> > +void restrictedmem_register_notifier(struct file *file,
> > +				     struct restrictedmem_notifier *notifier);
> > +void restrictedmem_unregister_notifier(struct file *file,
> > +				       struct restrictedmem_notifier *notifier);
> > +
> > +int restrictedmem_get_page(struct file *file, pgoff_t offset,
> > +			   struct page **pagep, int *order);
> > +
> > +static inline bool file_is_restrictedmem(struct file *file)
> > +{
> > +	return file->f_inode->i_sb->s_magic == RESTRICTEDMEM_MAGIC;
> > +}
> > +
> > +#else
> > +
> > +static inline void restrictedmem_register_notifier(struct file *file,
> > +				     struct restrictedmem_notifier *notifier)
> > +{
> > +}
> > +
> > +static inline void restrictedmem_unregister_notifier(struct file *file,
> > +				       struct restrictedmem_notifier *notifier)
> > +{
> > +}
> > +
> > +static inline int restrictedmem_get_page(struct file *file, pgoff_t offset,
> > +					 struct page **pagep, int *order)
> > +{
> > +	return -1;
> > +}
> > +
> > +static inline bool file_is_restrictedmem(struct file *file)
> > +{
> > +	return false;
> > +}
> > +
> > +#endif /* CONFIG_RESTRICTEDMEM */
> > +
> > +#endif /* _LINUX_RESTRICTEDMEM_H */
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index a34b0f9a9972..f9e9e0c820c5 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -1056,6 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
> >  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
> >  					    unsigned long home_node,
> >  					    unsigned long flags);
> > +asmlinkage long sys_memfd_restricted(unsigned int flags);
> >  
> >  /*
> >   * Architecture-specific system calls
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index 45fa180cc56a..e93cd35e46d0 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
> >  #define __NR_set_mempolicy_home_node 450
> >  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
> >  
> > +#define __NR_memfd_restricted 451
> > +__SYSCALL(__NR_memfd_restricted, sys_memfd_restricted)
> > +
> >  #undef __NR_syscalls
> > -#define __NR_syscalls 451
> > +#define __NR_syscalls 452
> >  
> >  /*
> >   * 32 bit systems traditionally used different
> > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > index 6325d1d0e90f..8aa38324b90a 100644
> > --- a/include/uapi/linux/magic.h
> > +++ b/include/uapi/linux/magic.h
> > @@ -101,5 +101,6 @@
> >  #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
> >  #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
> >  #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
> > +#define RESTRICTEDMEM_MAGIC	0x5245534d	/* "RESM" */
> >  
> >  #endif /* __LINUX_MAGIC_H__ */
> > diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> > index 860b2dcf3ac4..7c4a32cbd2e7 100644
> > --- a/kernel/sys_ni.c
> > +++ b/kernel/sys_ni.c
> > @@ -360,6 +360,9 @@ COND_SYSCALL(pkey_free);
> >  /* memfd_secret */
> >  COND_SYSCALL(memfd_secret);
> >  
> > +/* memfd_restricted */
> > +COND_SYSCALL(memfd_restricted);
> > +
> >  /*
> >   * Architecture specific weak syscall entries.
> >   */
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 0331f1461f81..0177d53676c7 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1076,6 +1076,10 @@ config IO_MAPPING
> >  config SECRETMEM
> >  	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
> >  
> > +config RESTRICTEDMEM
> > +	bool
> > +	depends on TMPFS
> > +
> >  config ANON_VMA_NAME
> >  	bool "Anonymous VMA name support"
> >  	depends on PROC_FS && ADVISE_SYSCALLS && MMU
> > diff --git a/mm/Makefile b/mm/Makefile
> > index 9a564f836403..6cb6403ffd40 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -117,6 +117,7 @@ obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
> >  obj-$(CONFIG_PAGE_TABLE_CHECK) += page_table_check.o
> >  obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
> >  obj-$(CONFIG_SECRETMEM) += secretmem.o
> > +obj-$(CONFIG_RESTRICTEDMEM) += restrictedmem.o
> >  obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
> >  obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
> >  obj-$(CONFIG_IDLE_PAGE_TRACKING) += page_idle.o
> > diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> > new file mode 100644
> > index 000000000000..e5bf8907e0f8
> > --- /dev/null
> > +++ b/mm/restrictedmem.c
> > @@ -0,0 +1,250 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "linux/sbitmap.h"
> > +#include <linux/pagemap.h>
> > +#include <linux/pseudo_fs.h>
> > +#include <linux/shmem_fs.h>
> > +#include <linux/syscalls.h>
> > +#include <uapi/linux/falloc.h>
> > +#include <uapi/linux/magic.h>
> > +#include <linux/restrictedmem.h>
> > +
> > +struct restrictedmem_data {
> > +	struct mutex lock;
> > +	struct file *memfd;
> > +	struct list_head notifiers;
> > +};
> > +
> > +static void restrictedmem_notifier_invalidate(struct restrictedmem_data *data,
> > +				 pgoff_t start, pgoff_t end, bool notify_start)
> > +{
> > +	struct restrictedmem_notifier *notifier;
> > +
> > +	mutex_lock(&data->lock);
> > +	list_for_each_entry(notifier, &data->notifiers, list) {
> > +		if (notify_start)
> > +			notifier->ops->invalidate_start(notifier, start, end);
> > +		else
> > +			notifier->ops->invalidate_end(notifier, start, end);
> > +	}
> > +	mutex_unlock(&data->lock);
> > +}
> > +
> > +static int restrictedmem_release(struct inode *inode, struct file *file)
> > +{
> > +	struct restrictedmem_data *data = inode->i_mapping->private_data;
> > +
> > +	fput(data->memfd);
> > +	kfree(data);
> > +	return 0;
> > +}
> > +
> > +static long restrictedmem_fallocate(struct file *file, int mode,
> > +				    loff_t offset, loff_t len)
> > +{
> > +	struct restrictedmem_data *data = file->f_mapping->private_data;
> > +	struct file *memfd = data->memfd;
> > +	int ret;
> > +
> > +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> > +		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> > +			return -EINVAL;
> > +	}
> > +
> > +	restrictedmem_notifier_invalidate(data, offset, offset + len, true);
> > +	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> > +	restrictedmem_notifier_invalidate(data, offset, offset + len, false);
> > +	return ret;
> > +}
> 
> In v8 there was some discussion about potentially passing the page/folio
> and order as part of the invalidation callback, I ended up needing
> something similar for SEV-SNP, and think it might make sense for other
> platforms. This main reasoning is:

In that context what we talked on is the inaccessible_get_pfn(), I was
not aware there is need for invalidation callback as well.

> 
>   1) restoring kernel directmap:
> 
>      Currently SNP (and I believe TDX) need to either split or remove kernel
>      direct mappings for restricted PFNs, since there is no guarantee that
>      other PFNs within a 2MB range won't be used for non-restricted
>      (which will cause an RMP #PF in the case of SNP since the 2MB
>      mapping overlaps with guest-owned pages)

Has the splitting and restoring been a well-discussed direction? I'm
just curious whether there is other options to solve this issue.

> 
>      Previously we were able to restore 2MB mappings to some degree
>      since both shared/restricted pages were all pinned, so anything
>      backed by a THP (or hugetlb page once that is implemented) at guest
>      teardown could be restored as 2MB direct mapping.
> 
>      Invalidation seems like the most logical time to have this happen,

Currently invalidation only happens at user-initiated fallocate(). It
does not cover the VM teardown case where the restoring might also be
expected to be handled.

>      but whether or not to restore as 2MB requires the order to be 2MB
>      or larger, and for GPA range being invalidated to cover the entire
>      2MB (otherwise it means the page was potentially split and some
>      subpages free back to host already, in which case it can't be
>      restored as 2MB).
> 
>   2) Potentially less invalidations:
>       
>      If we pass the entire folio or compound_page as part of
>      invalidation, we only needed to issue 1 invalidation per folio.

I'm not sure I agree, the current invalidation covers the whole range
that passed from userspace and the invalidation is invoked only once for
each usrspace fallocate().

> 
>   3) Potentially useful for hugetlbfs support:
> 
>      One issue with hugetlbfs is that we don't support splitting the
>      hugepage in such cases, which was a big obstacle prior to UPM. Now
>      however, we may have the option of doing "lazy" invalidations where
>      fallocate(PUNCH_HOLE, ...) won't free a shmem-allocate page unless
>      all the subpages within the 2M range are either hole-punched, or the
>      guest is shut down, so in that way we never have to split it. Sean
>      was pondering something similar in another thread:
> 
>        https://lore.kernel.org/linux-mm/YyGLXXkFCmxBfu5U@google.com/
> 
>      Issuing invalidations with folio-granularity ties in fairly well
>      with this sort of approach if we end up going that route.

There is semantics difference between the current one and the proposed
one: The invalidation range is exactly what userspace passed down to the
kernel (being fallocated) while the proposed one will be subset of that
(if userspace-provided addr/size is not aligned to power of two), I'm
not quite confident this difference has no side effect.

> 
> I need to rework things for v9, and we'll probably want to use struct
> folio instead of struct page now, but as a proof-of-concept of sorts this
> is what I'd added on top of v8 of your patchset to implement 1) and 2):
> 
>   https://github.com/mdroth/linux/commit/127e5ea477c7bd5e4107fd44a04b9dc9e9b1af8b
> 
> Does an approach like this seem reasonable? Should be work this into the
> base restricted memslot support?

If the above mentioned semantics difference is not a problem, I don't
have strong objection on this.

Sean, since you have much better understanding on this, what is your
take on this?

Chao
> 
> Thanks,
> 
> Mike
