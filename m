Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4A747EAF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 04:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351183AbhLXDxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 22:53:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:14585 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235118AbhLXDxX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 22:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640318003; x=1671854003;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=30o9I+HMm9QpTfhVoXmQEppb2S3jRTCTXgRvqUiy1sk=;
  b=K8w8oyuiqJ7mr6Bl/5F1X56o4LQWbF0ASNBLPsyetyK7aSmaUAdbx7oG
   EzrRyaxwjEv7E+6fIpTBkN+HZ8bQFzatl6Bb0GZswIL57ivKTL+8+tSgu
   TNzUmDaAtPOXX8N8Ow2kjpGqvBB2BOYd0VvUeE4Io/lzHNYCnYNXZF31q
   7xjQX/57EcdYDpbXegJEVtH2V6edf/e0NrBCkbRPsClWkMXHMIuCzghQD
   lgArwuvLrTKY5FWTnsyrKlZL8KGayzvMpTpO55ot/CEkA2q1vyYNl+IkF
   Lt/c4ijl7i2kIFRyTxLYjHmin6sOJs70UpCGpjueNruaxQe54Nq9UX6Kp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="304293601"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="304293601"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 19:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="614396414"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org) ([10.239.48.212])
  by fmsmga002.fm.intel.com with ESMTP; 23 Dec 2021 19:53:16 -0800
Message-ID: <95d13ac7da32aa1530d6883777ef3279e4ad825d.camel@linux.intel.com>
Subject: Re: [PATCH v3 kvm/queue 03/16] mm/memfd: Introduce MEMFD_OPS
From:   Robert Hoo <robert.hu@linux.intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Date:   Fri, 24 Dec 2021 11:53:15 +0800
In-Reply-To: <20211223123011.41044-4-chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
         <20211223123011.41044-4-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-12-23 at 20:29 +0800, Chao Peng wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> The patch introduces new MEMFD_OPS facility around file created by
> memfd_create() to allow a third kernel component to make use of
> memory
> bookmarked in a memfd and gets notifier when the memory in the file
> is allocated/invalidated. It will be used for KVM to use memfd file
> descriptor as the guest memory backend and KVM will use MEMFD_OPS to
> interact with memfd subsystem. In the future there might be other
> consumers (e.g. VFIO with encrypted device memory).
> 
> It consists two set of callbacks:
>   - memfd_falloc_notifier: callbacks which provided by KVM and called
>     by memfd when memory gets allocated/invalidated through
> fallocate()
>     ioctl.
>   - memfd_pfn_ops: callbacks which provided by memfd and called by
> KVM
>     to request memory page from memfd.
> 
> Locking is needed for above callbacks to prevent race condition.
>   - get_owner/put_owner is used to ensure the owner is still alive in
>     the invalidate_page_range/fallocate callback handlers using a
>     reference mechanism.
>   - page is locked between get_lock_pfn/put_unlock_pfn to ensure pfn
> is
>     still valid when it's used (e.g. when KVM page fault handler uses
>     it to establish the mapping in the secondary MMU page tables).
> 
> Userspace is in charge of guest memory lifecycle: it can allocate the
> memory with fallocate() or punch hole to free memory from the guest.
> 
> The file descriptor passed down to KVM as guest memory backend. KVM
> registers itself as the owner of the memfd via
> memfd_register_falloc_notifier() and provides memfd_falloc_notifier
> callbacks that need to be called on fallocate() and punching hole.
> 
> memfd_register_falloc_notifier() returns memfd_pfn_ops callbacks that
> need to be used for requesting a new page from KVM.
> 
> At this time only shmem is supported.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/memfd.h    |  22 ++++++
>  include/linux/shmem_fs.h |  16 ++++
>  mm/Kconfig               |   4 +
>  mm/memfd.c               |  21 ++++++
>  mm/shmem.c               | 158
> +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 221 insertions(+)
> 
> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> index 4f1600413f91..0007073b53dc 100644
> --- a/include/linux/memfd.h
> +++ b/include/linux/memfd.h
> @@ -13,4 +13,26 @@ static inline long memfd_fcntl(struct file *f,
> unsigned int c, unsigned long a)
>  }
>  #endif
>  
> +#ifdef CONFIG_MEMFD_OPS
> +struct memfd_falloc_notifier {
> +	void (*invalidate_page_range)(struct inode *inode, void *owner,
> +				      pgoff_t start, pgoff_t end);
> +	void (*fallocate)(struct inode *inode, void *owner,
> +			  pgoff_t start, pgoff_t end);
> +	bool (*get_owner)(void *owner);
> +	void (*put_owner)(void *owner);
> +};
> +
> +struct memfd_pfn_ops {
> +	long (*get_lock_pfn)(struct inode *inode, pgoff_t offset, int
> *order);
> +	void (*put_unlock_pfn)(unsigned long pfn);
> +
> +};
> +
> +extern int memfd_register_falloc_notifier(struct inode *inode, void
> *owner,
> +				const struct memfd_falloc_notifier
> *notifier,
> +				const struct memfd_pfn_ops **pfn_ops);
> +extern void memfd_unregister_falloc_notifier(struct inode *inode);
> +#endif
> +
>  #endif /* __LINUX_MEMFD_H */
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 166158b6e917..503adc63728c 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -12,6 +12,11 @@
>  
>  /* inode in-kernel data */
>  
> +#ifdef CONFIG_MEMFD_OPS
> +struct memfd_falloc_notifier;
> +struct memfd_pfn_ops;
> +#endif
> +
>  struct shmem_inode_info {
>  	spinlock_t		lock;
>  	unsigned int		seals;		/* shmem seals */
> @@ -24,6 +29,10 @@ struct shmem_inode_info {
>  	struct shared_policy	policy;		/* NUMA memory alloc
> policy */
>  	struct simple_xattrs	xattrs;		/* list of xattrs */
>  	atomic_t		stop_eviction;	/* hold when working on inode
> */
> +#ifdef CONFIG_MEMFD_OPS
> +	void			*owner;
> +	const struct memfd_falloc_notifier *falloc_notifier;
> +#endif
>  	struct inode		vfs_inode;
>  };
>  
> @@ -96,6 +105,13 @@ extern unsigned long shmem_swap_usage(struct
> vm_area_struct *vma);
>  extern unsigned long shmem_partial_swap_usage(struct address_space
> *mapping,
>  						pgoff_t start, pgoff_t
> end);
>  
> +#ifdef CONFIG_MEMFD_OPS
> +extern int shmem_register_falloc_notifier(struct inode *inode, void
> *owner,
> +				const struct memfd_falloc_notifier
> *notifier,
> +				const struct memfd_pfn_ops **pfn_ops);
> +extern void shmem_unregister_falloc_notifier(struct inode *inode);
> +#endif
> +
>  /* Flag allocation requirements to shmem_getpage */
>  enum sgp_type {
>  	SGP_READ,	/* don't exceed i_size, don't allocate page */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 28edafc820ad..9989904d1b56 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -900,6 +900,10 @@ config IO_MAPPING
>  config SECRETMEM
>  	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
>  
> +config MEMFD_OPS
> +	bool
> +	depends on MEMFD_CREATE
> +
>  source "mm/damon/Kconfig"
>  
>  endmenu
> diff --git a/mm/memfd.c b/mm/memfd.c
> index c898a007fb76..41861870fc21 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -130,6 +130,27 @@ static unsigned int *memfd_file_seals_ptr(struct
> file *file)
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_MEMFD_OPS
> +int memfd_register_falloc_notifier(struct inode *inode, void *owner,
> +				   const struct memfd_falloc_notifier
> *notifier,
> +				   const struct memfd_pfn_ops
> **pfn_ops)
> +{
> +	if (shmem_mapping(inode->i_mapping))
> +		return shmem_register_falloc_notifier(inode, owner,
> +						      notifier,
> pfn_ops);
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(memfd_register_falloc_notifier);
> +
> +void memfd_unregister_falloc_notifier(struct inode *inode)
> +{
> +	if (shmem_mapping(inode->i_mapping))
> +		shmem_unregister_falloc_notifier(inode);
> +}
> +EXPORT_SYMBOL_GPL(memfd_unregister_falloc_notifier);
> +#endif
> +
>  #define F_ALL_SEALS (F_SEAL_SEAL | \
>  		     F_SEAL_SHRINK | \
>  		     F_SEAL_GROW | \
> diff --git a/mm/shmem.c b/mm/shmem.c
> index faa7e9b1b9bc..4d8a75c4d037 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -78,6 +78,7 @@ static struct vfsmount *shm_mnt;
>  #include <linux/userfaultfd_k.h>
>  #include <linux/rmap.h>
>  #include <linux/uuid.h>
> +#include <linux/memfd.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -906,6 +907,68 @@ static bool shmem_punch_compound(struct page
> *page, pgoff_t start, pgoff_t end)
>  	return split_huge_page(page) >= 0;
>  }
>  
> +static void notify_fallocate(struct inode *inode, pgoff_t start,
> pgoff_t end)
> +{
> +#ifdef CONFIG_MEMFD_OPS
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +	const struct memfd_falloc_notifier *notifier;
> +	void *owner;
> +	bool ret;
> +
> +	if (!info->falloc_notifier)
> +		return;
> +
> +	spin_lock(&info->lock);
> +	notifier = info->falloc_notifier;
> +	if (!notifier) {
> +		spin_unlock(&info->lock);
> +		return;
> +	}
> +
> +	owner = info->owner;
> +	ret = notifier->get_owner(owner);
> +	spin_unlock(&info->lock);
> +	if (!ret)
> +		return;
> +
> +	notifier->fallocate(inode, owner, start, end);

I see notifier->fallocate(), i.e. memfd_fallocate(), discards
kvm_memfd_fallocate_range()'s return value. Should it be checked?

> +	notifier->put_owner(owner);
> +#endif
> +}
> +
> +static void notify_invalidate_page(struct inode *inode, struct page
> *page,
> +				   pgoff_t start, pgoff_t end)
> +{
> +#ifdef CONFIG_MEMFD_OPS
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +	const struct memfd_falloc_notifier *notifier;
> +	void *owner;
> +	bool ret;
> +
> +	if (!info->falloc_notifier)
> +		return;
> +
> +	spin_lock(&info->lock);
> +	notifier = info->falloc_notifier;
> +	if (!notifier) {
> +		spin_unlock(&info->lock);
> +		return;
> +	}
> +
> +	owner = info->owner;
> +	ret = notifier->get_owner(owner);
> +	spin_unlock(&info->lock);
> +	if (!ret)
> +		return;
> +
> +	start = max(start, page->index);
> +	end = min(end, page->index + thp_nr_pages(page));
> +
> +	notifier->invalidate_page_range(inode, owner, start, end);
> +	notifier->put_owner(owner);
> +#endif
> +}
> +
>  /*
>   * Remove range of pages and swap entries from page cache, and free
> them.
>   * If !unfalloc, truncate or punch hole; if unfalloc, undo failed
> fallocate.
> @@ -949,6 +1012,8 @@ static void shmem_undo_range(struct inode
> *inode, loff_t lstart, loff_t lend,
>  			}
>  			index += thp_nr_pages(page) - 1;
>  
> +			notify_invalidate_page(inode, page, start,
> end);
> +
>  			if (!unfalloc || !PageUptodate(page))
>  				truncate_inode_page(mapping, page);
>  			unlock_page(page);
> @@ -1025,6 +1090,9 @@ static void shmem_undo_range(struct inode
> *inode, loff_t lstart, loff_t lend,
>  					index--;
>  					break;
>  				}
> +
> +				notify_invalidate_page(inode, page,
> start, end);
> +
>  				VM_BUG_ON_PAGE(PageWriteback(page),
> page);
>  				if (shmem_punch_compound(page, start,
> end))
>  					truncate_inode_page(mapping,
> page);
> @@ -2815,6 +2883,7 @@ static long shmem_fallocate(struct file *file,
> int mode, loff_t offset,
>  	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode-
> >i_size)
>  		i_size_write(inode, offset + len);
>  	inode->i_ctime = current_time(inode);
> +	notify_fallocate(inode, start, end);
>  undone:
>  	spin_lock(&inode->i_lock);
>  	inode->i_private = NULL;
> @@ -3784,6 +3853,20 @@ static void shmem_destroy_inodecache(void)
>  	kmem_cache_destroy(shmem_inode_cachep);
>  }
>  
> +#ifdef CONFIG_MIGRATION
> +int shmem_migrate_page(struct address_space *mapping, struct page
> *newpage,
> +		       struct page *page, enum migrate_mode mode)
> +{
> +#ifdef CONFIG_MEMFD_OPS
> +	struct inode *inode = mapping->host;
> +
> +	if (SHMEM_I(inode)->owner)
> +		return -EOPNOTSUPP;
> +#endif
> +	return migrate_page(mapping, newpage, page, mode);
> +}
> +#endif
> +
>  const struct address_space_operations shmem_aops = {
>  	.writepage	= shmem_writepage,
>  	.set_page_dirty	= __set_page_dirty_no_writeback,
> @@ -3798,6 +3881,81 @@ const struct address_space_operations
> shmem_aops = {
>  };
>  EXPORT_SYMBOL(shmem_aops);
>  
> +#ifdef CONFIG_MEMFD_OPS
> +static long shmem_get_lock_pfn(struct inode *inode, pgoff_t offset,
> int *order)
> +{
> +	struct page *page;
> +	int ret;
> +
> +	ret = shmem_getpage(inode, offset, &page, SGP_NOALLOC);
> +	if (ret)
> +		return ret;
> +
> +	*order = thp_order(compound_head(page));
> +
> +	return page_to_pfn(page);
> +}
> +
> +static void shmem_put_unlock_pfn(unsigned long pfn)
> +{
> +	struct page *page = pfn_to_page(pfn);
> +
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +
> +	set_page_dirty(page);
> +	unlock_page(page);
> +	put_page(page);
> +}
> +
> +static const struct memfd_pfn_ops shmem_pfn_ops = {
> +	.get_lock_pfn = shmem_get_lock_pfn,
> +	.put_unlock_pfn = shmem_put_unlock_pfn,
> +};
> +
> +int shmem_register_falloc_notifier(struct inode *inode, void *owner,
> +				const struct memfd_falloc_notifier
> *notifier,
> +				const struct memfd_pfn_ops **pfn_ops)
> +{
> +	gfp_t gfp;
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +
> +	if (!inode || !owner || !notifier || !pfn_ops ||
> +	    !notifier->invalidate_page_range ||
> +	    !notifier->fallocate ||
> +	    !notifier->get_owner ||
> +	    !notifier->put_owner)
> +		return -EINVAL;
> +
> +	spin_lock(&info->lock);
> +	if (info->owner && info->owner != owner) {
> +		spin_unlock(&info->lock);
> +		return -EPERM;
> +	}
> +
> +	info->owner = owner;
> +	info->falloc_notifier = notifier;
> +	spin_unlock(&info->lock);
> +
> +	gfp = mapping_gfp_mask(inode->i_mapping);
> +	gfp &= ~__GFP_MOVABLE;
> +	mapping_set_gfp_mask(inode->i_mapping, gfp);
> +	mapping_set_unevictable(inode->i_mapping);
> +
> +	*pfn_ops = &shmem_pfn_ops;
> +	return 0;
> +}
> +
> +void shmem_unregister_falloc_notifier(struct inode *inode)
> +{
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +
> +	spin_lock(&info->lock);
> +	info->owner = NULL;
> +	info->falloc_notifier = NULL;
> +	spin_unlock(&info->lock);
> +}
> +#endif
> +
>  static const struct file_operations shmem_file_operations = {
>  	.mmap		= shmem_mmap,
>  	.get_unmapped_area = shmem_get_unmapped_area,

