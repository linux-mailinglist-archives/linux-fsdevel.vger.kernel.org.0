Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D2D75D779
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jul 2023 00:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGUW1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 18:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjGUW1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:27:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A642F30C1;
        Fri, 21 Jul 2023 15:27:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-668709767b1so1713856b3a.2;
        Fri, 21 Jul 2023 15:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689978427; x=1690583227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDKyepYXyjRRch0BmZeah1kwkPDuydn93OQ8Q7H7q9k=;
        b=FysoijIrzywkPRpXms8d7t649/LAeMOJfcfBabgutkiGft+surAV7nj6eTDEc2XKW9
         gjALtuaWQa3zBKtZX7S/oEaLIF6CLCY53h5DgfWjLGLMPbnnWvMNmXDRrvJ++Vkw5FwU
         tpC1GfCpFg5tAqzwT9HC9bz9Q7ZjTAxT/T85kzevY64kQIHJn9yAWtMGSWnAH/acEYqw
         lrHUA3yYULrqPHuvHsRf3ACxsaQSruv+iqHLCjR6wvjogKozKzIPwh6upOm70oBclv8u
         nUkk9Av66XrahTP0EoN9Lke63Fdk5bz2DJyAKFDVc/n2eNw1wnGSCDIkKDUMYiFSTWvV
         Pbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689978427; x=1690583227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDKyepYXyjRRch0BmZeah1kwkPDuydn93OQ8Q7H7q9k=;
        b=Lw0ROtb+7dm413AhUsU28HENxwlY6q1J9cozd7psFXO1o0P+KL+maIfUGVK+V3FBHl
         IvJRFIxyEXbcO9iK+jTBsDhNBLIaiJJ37if92CXs2noHDuaUDfX7fbshCPCvP/950ow4
         BXPxefszABNYuqiiU9EUquJboNRELH0U2PVtzWJ49/T7Pj3dCmwOz87xnwb7oV+4VJ4k
         Tk5QScwjtYM8gcGFanYb8r7jRiBFUFRlOUi9m2vaYWZbXIiQ+39V1og8buTt7nL5vk6u
         z7u5JcG1cBJUucNWdwl/PHT8mUJn2P8o3t7CEJhP+xUvooRfAjkXcXiRWsS70FRDgKEg
         pHMw==
X-Gm-Message-State: ABy/qLbCjzVid72ynxRu8eIxqEvpi4gPmiLPBX5ECzWlD8Dz1cjxlPjc
        MBNArVPzE+GU1NM3xaQl3iA=
X-Google-Smtp-Source: APBJJlFqx5KBzbf+bcpJBIs8RKvjVeA0hMI7L53m0MptEpae0uUrLDbExBMYFr3bDfXWpEHeiuvheg==
X-Received: by 2002:a05:6a20:3216:b0:134:6839:c497 with SMTP id hl22-20020a056a20321600b001346839c497mr2694272pzc.11.1689978426895;
        Fri, 21 Jul 2023 15:27:06 -0700 (PDT)
Received: from localhost ([192.55.54.50])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902a51800b001b890b3bbb1sm3968363plq.211.2023.07.21.15.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:27:06 -0700 (PDT)
Date:   Fri, 21 Jul 2023 15:27:04 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Yuan Yao <yuan.yao@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl()
 for guest-specific backing memory
Message-ID: <20230721222704.GJ25699@ls.amr.corp.intel.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-13-seanjc@google.com>
 <20230721061314.3ls6stdawz53drv3@yy-desk-7060>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230721061314.3ls6stdawz53drv3@yy-desk-7060>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 21, 2023 at 02:13:14PM +0800,
Yuan Yao <yuan.yao@linux.intel.com> wrote:

> On Tue, Jul 18, 2023 at 04:44:55PM -0700, Sean Christopherson wrote:
> > TODO
> >
> > Cc: Fuad Tabba <tabba@google.com>
> > Cc: Vishal Annapurve <vannapurve@google.com>
> > Cc: Ackerley Tng <ackerleytng@google.com>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Maciej Szmigiero <mail@maciej.szmigiero.name>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Quentin Perret <qperret@google.com>
> > Cc: Michael Roth <michael.roth@amd.com>
> > Cc: Wang <wei.w.wang@intel.com>
> > Cc: Liam Merwick <liam.merwick@oracle.com>
> > Cc: Isaku Yamahata <isaku.yamahata@gmail.com>
> > Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  include/linux/kvm_host.h   |  48 +++
> >  include/uapi/linux/kvm.h   |  14 +-
> >  include/uapi/linux/magic.h |   1 +
> >  virt/kvm/Kconfig           |   4 +
> >  virt/kvm/Makefile.kvm      |   1 +
> >  virt/kvm/guest_mem.c       | 591 +++++++++++++++++++++++++++++++++++++
> >  virt/kvm/kvm_main.c        |  58 +++-
> >  virt/kvm/kvm_mm.h          |  38 +++
> >  8 files changed, 750 insertions(+), 5 deletions(-)
> >  create mode 100644 virt/kvm/guest_mem.c
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 97db63da6227..0d1e2ee8ae7a 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -592,8 +592,20 @@ struct kvm_memory_slot {
> >  	u32 flags;
> >  	short id;
> >  	u16 as_id;
> > +
> > +#ifdef CONFIG_KVM_PRIVATE_MEM
> > +	struct {
> > +		struct file __rcu *file;
> > +		pgoff_t pgoff;
> > +	} gmem;
> > +#endif
> >  };
> >
> > +static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
> > +{
> > +	return slot && (slot->flags & KVM_MEM_PRIVATE);
> > +}
> > +
> >  static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
> >  {
> >  	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
> > @@ -688,6 +700,17 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
> >  }
> >  #endif
> >
> > +/*
> > + * Arch code must define kvm_arch_has_private_mem if support for private memory
> > + * is enabled.
> > + */
> > +#if !defined(kvm_arch_has_private_mem) && !IS_ENABLED(CONFIG_KVM_PRIVATE_MEM)
> > +static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> >  struct kvm_memslots {
> >  	u64 generation;
> >  	atomic_long_t last_used_slot;
> > @@ -1380,6 +1403,7 @@ void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
> >  void kvm_mmu_invalidate_begin(struct kvm *kvm);
> >  void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end);
> >  void kvm_mmu_invalidate_end(struct kvm *kvm);
> > +bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
> >
> >  long kvm_arch_dev_ioctl(struct file *filp,
> >  			unsigned int ioctl, unsigned long arg);
> > @@ -2313,6 +2337,30 @@ static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn
> >
> >  bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> >  					 struct kvm_gfn_range *range);
> > +
> > +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> > +{
> > +	return IS_ENABLED(CONFIG_KVM_PRIVATE_MEM) &&
> > +	       kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> > +}
> > +#else
> > +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> > +{
> > +	return false;
> > +}
> >  #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
> >
> > +#ifdef CONFIG_KVM_PRIVATE_MEM
> > +int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> > +			      gfn_t gfn, kvm_pfn_t *pfn, int *max_order);
> > +#else
> > +static inline int kvm_gmem_get_pfn(struct kvm *kvm,
> > +				   struct kvm_memory_slot *slot, gfn_t gfn,
> > +				   kvm_pfn_t *pfn, int *max_order)
> > +{
> > +	KVM_BUG_ON(1, kvm);
> > +	return -EIO;
> > +}
> > +#endif /* CONFIG_KVM_PRIVATE_MEM */
> > +
> >  #endif
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index f065c57db327..9b344fc98598 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -102,7 +102,10 @@ struct kvm_userspace_memory_region2 {
> >  	__u64 guest_phys_addr;
> >  	__u64 memory_size;
> >  	__u64 userspace_addr;
> > -	__u64 pad[16];
> > +	__u64 gmem_offset;
> > +	__u32 gmem_fd;
> > +	__u32 pad1;
> > +	__u64 pad2[14];
> >  };
> >
> >  /*
> > @@ -112,6 +115,7 @@ struct kvm_userspace_memory_region2 {
> >   */
> >  #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
> >  #define KVM_MEM_READONLY	(1UL << 1)
> > +#define KVM_MEM_PRIVATE		(1UL << 2)
> >
> >  /* for KVM_IRQ_LINE */
> >  struct kvm_irq_level {
> > @@ -2284,4 +2288,12 @@ struct kvm_memory_attributes {
> >
> >  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> >
> > +#define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
> > +
> > +struct kvm_create_guest_memfd {
> > +	__u64 size;
> > +	__u64 flags;
> > +	__u64 reserved[6];
> > +};
> > +
> >  #endif /* __LINUX_KVM_H */
> > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > index 6325d1d0e90f..15041aa7d9ae 100644
> > --- a/include/uapi/linux/magic.h
> > +++ b/include/uapi/linux/magic.h
> > @@ -101,5 +101,6 @@
> >  #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
> >  #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
> >  #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
> > +#define GUEST_MEMORY_MAGIC	0x474d454d	/* "GMEM" */
> >
> >  #endif /* __LINUX_MAGIC_H__ */
> > diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> > index 8375bc49f97d..3ee3205e0b39 100644
> > --- a/virt/kvm/Kconfig
> > +++ b/virt/kvm/Kconfig
> > @@ -103,3 +103,7 @@ config KVM_GENERIC_MMU_NOTIFIER
> >  config KVM_GENERIC_MEMORY_ATTRIBUTES
> >         select KVM_GENERIC_MMU_NOTIFIER
> >         bool
> > +
> > +config KVM_PRIVATE_MEM
> > +       select XARRAY_MULTI
> > +       bool
> > diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
> > index 2c27d5d0c367..a5a61bbe7f4c 100644
> > --- a/virt/kvm/Makefile.kvm
> > +++ b/virt/kvm/Makefile.kvm
> > @@ -12,3 +12,4 @@ kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
> >  kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
> >  kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
> >  kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
> > +kvm-$(CONFIG_KVM_PRIVATE_MEM) += $(KVM)/guest_mem.o
> > diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
> > new file mode 100644
> > index 000000000000..1b705fd63fa8
> > --- /dev/null
> > +++ b/virt/kvm/guest_mem.c
> > @@ -0,0 +1,591 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/backing-dev.h>
> > +#include <linux/falloc.h>
> > +#include <linux/kvm_host.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/pseudo_fs.h>
> > +
> > +#include <uapi/linux/magic.h>
> > +
> > +#include "kvm_mm.h"
> > +
> > +static struct vfsmount *kvm_gmem_mnt;
> > +
> > +struct kvm_gmem {
> > +	struct kvm *kvm;
> > +	struct xarray bindings;
> > +	struct list_head entry;
> > +};
> > +
> > +static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)
> > +{
> > +	struct folio *folio;
> > +
> > +	/* TODO: Support huge pages. */
> > +	folio = filemap_grab_folio(file->f_mapping, index);
> > +	if (!folio)
> > +		return NULL;
> > +
> > +	/*
> > +	 * Use the up-to-date flag to track whether or not the memory has been
> > +	 * zeroed before being handed off to the guest.  There is no backing
> > +	 * storage for the memory, so the folio will remain up-to-date until
> > +	 * it's removed.
> > +	 *
> > +	 * TODO: Skip clearing pages when trusted firmware will do it when
> > +	 * assigning memory to the guest.
> > +	 */
> > +	if (!folio_test_uptodate(folio)) {
> > +		unsigned long nr_pages = folio_nr_pages(folio);
> > +		unsigned long i;
> > +
> > +		for (i = 0; i < nr_pages; i++)
> > +			clear_highpage(folio_page(folio, i));
> > +
> > +		folio_mark_uptodate(folio);
> > +	}
> > +
> > +	/*
> > +	 * Ignore accessed, referenced, and dirty flags.  The memory is
> > +	 * unevictable and there is no storage to write back to.
> > +	 */
> > +	return folio;
> > +}
> > +
> > +static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> > +				      pgoff_t end)
> > +{
> > +	struct kvm_memory_slot *slot;
> > +	struct kvm *kvm = gmem->kvm;
> > +	unsigned long index;
> > +	bool flush = false;
> > +
> > +	KVM_MMU_LOCK(kvm);
> > +
> > +	kvm_mmu_invalidate_begin(kvm);
> > +
> > +	xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
> > +		pgoff_t pgoff = slot->gmem.pgoff;
> > +
> > +		struct kvm_gfn_range gfn_range = {
> > +			.start = slot->base_gfn + max(pgoff, start) - pgoff,
> > +			.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
> > +			.slot = slot,
> > +			.may_block = true,
> > +		};
> > +
> > +		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> > +	}
> > +
> > +	if (flush)
> > +		kvm_flush_remote_tlbs(kvm);
> > +
> > +	KVM_MMU_UNLOCK(kvm);
> > +}
> > +
> > +static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
> > +				    pgoff_t end)
> > +{
> > +	struct kvm *kvm = gmem->kvm;
> > +
> > +	KVM_MMU_LOCK(kvm);
> > +	if (xa_find(&gmem->bindings, &start, end - 1, XA_PRESENT))
> > +		kvm_mmu_invalidate_end(kvm);
> > +	KVM_MMU_UNLOCK(kvm);
> > +}
> > +
> > +static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> > +{
> > +	struct list_head *gmem_list = &inode->i_mapping->private_list;
> > +	pgoff_t start = offset >> PAGE_SHIFT;
> > +	pgoff_t end = (offset + len) >> PAGE_SHIFT;
> > +	struct kvm_gmem *gmem;
> > +
> > +	/*
> > +	 * Bindings must stable across invalidation to ensure the start+end
> > +	 * are balanced.
> > +	 */
> > +	filemap_invalidate_lock(inode->i_mapping);
> > +
> > +	list_for_each_entry(gmem, gmem_list, entry)
> > +		kvm_gmem_invalidate_begin(gmem, start, end);
> > +
> > +	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
> > +
> > +	list_for_each_entry(gmem, gmem_list, entry)
> > +		kvm_gmem_invalidate_end(gmem, start, end);
> > +
> > +	filemap_invalidate_unlock(inode->i_mapping);
> > +
> > +	return 0;
> > +}
> > +
> > +static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
> > +{
> > +	struct address_space *mapping = inode->i_mapping;
> > +	pgoff_t start, index, end;
> > +	int r;
> > +
> > +	/* Dedicated guest is immutable by default. */
> > +	if (offset + len > i_size_read(inode))
> > +		return -EINVAL;
> > +
> > +	filemap_invalidate_lock_shared(mapping);
> > +
> > +	start = offset >> PAGE_SHIFT;
> > +	end = (offset + len) >> PAGE_SHIFT;
> > +
> > +	r = 0;
> > +	for (index = start; index < end; ) {
> > +		struct folio *folio;
> > +
> > +		if (signal_pending(current)) {
> > +			r = -EINTR;
> > +			break;
> > +		}
> > +
> > +		folio = kvm_gmem_get_folio(inode, index);
> > +		if (!folio) {
> > +			r = -ENOMEM;
> > +			break;
> > +		}
> > +
> > +		index = folio_next_index(folio);
> > +
> > +		folio_unlock(folio);
> > +		folio_put(folio);
> > +
> > +		/* 64-bit only, wrapping the index should be impossible. */
> > +		if (WARN_ON_ONCE(!index))
> > +			break;
> > +
> > +		cond_resched();
> > +	}
> > +
> > +	filemap_invalidate_unlock_shared(mapping);
> > +
> > +	return r;
> > +}
> > +
> > +static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
> > +			       loff_t len)
> > +{
> > +	int ret;
> > +
> > +	if (!(mode & FALLOC_FL_KEEP_SIZE))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> > +		return -EINVAL;
> > +
> > +	if (mode & FALLOC_FL_PUNCH_HOLE)
> > +		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
> > +	else
> > +		ret = kvm_gmem_allocate(file_inode(file), offset, len);
> > +
> > +	if (!ret)
> > +		file_modified(file);
> > +	return ret;
> > +}
> > +
> > +static int kvm_gmem_release(struct inode *inode, struct file *file)
> > +{
> > +	struct kvm_gmem *gmem = file->private_data;
> > +	struct kvm_memory_slot *slot;
> > +	struct kvm *kvm = gmem->kvm;
> > +	unsigned long index;
> > +
> > +	filemap_invalidate_lock(inode->i_mapping);
> > +
> > +	/*
> > +	 * Prevent concurrent attempts to *unbind* a memslot.  This is the last
> > +	 * reference to the file and thus no new bindings can be created, but
> > +	 * dereferencing the slot for existing bindings needs to be protected
> > +	 * against memslot updates, specifically so that unbind doesn't race
> > +	 * and free the memslot (kvm_gmem_get_file() will return NULL).
> > +	 */
> > +	mutex_lock(&kvm->slots_lock);
> > +
> > +	xa_for_each(&gmem->bindings, index, slot)
> > +		rcu_assign_pointer(slot->gmem.file, NULL);
> > +
> > +	synchronize_rcu();
> > +
> > +	/*
> > +	 * All in-flight operations are gone and new bindings can be created.
> > +	 * Zap all SPTEs pointed at by this file.  Do not free the backing
> > +	 * memory, as its lifetime is associated with the inode, not the file.
> > +	 */
> > +	kvm_gmem_invalidate_begin(gmem, 0, -1ul);
> > +	kvm_gmem_invalidate_end(gmem, 0, -1ul);
> > +
> > +	mutex_unlock(&kvm->slots_lock);
> > +
> > +	list_del(&gmem->entry);
> > +
> > +	filemap_invalidate_unlock(inode->i_mapping);
> > +
> > +	xa_destroy(&gmem->bindings);
> > +	kfree(gmem);
> > +
> > +	kvm_put_kvm(kvm);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct file *kvm_gmem_get_file(struct kvm_memory_slot *slot)
> > +{
> > +	struct file *file;
> > +
> > +	rcu_read_lock();
> > +
> > +	file = rcu_dereference(slot->gmem.file);
> > +	if (file && !get_file_rcu(file))
> > +		file = NULL;
> > +
> > +	rcu_read_unlock();
> > +
> > +	return file;
> > +}
> > +
> > +static const struct file_operations kvm_gmem_fops = {
> > +	.open		= generic_file_open,
> > +	.release	= kvm_gmem_release,
> > +	.fallocate	= kvm_gmem_fallocate,
> > +};
> > +
> > +static int kvm_gmem_migrate_folio(struct address_space *mapping,
> > +				  struct folio *dst, struct folio *src,
> > +				  enum migrate_mode mode)
> > +{
> > +	WARN_ON_ONCE(1);
> > +	return -EINVAL;
> > +}
> > +
> > +static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
> > +{
> > +	struct list_head *gmem_list = &mapping->private_list;
> > +	struct kvm_memory_slot *slot;
> > +	struct kvm_gmem *gmem;
> > +	unsigned long index;
> > +	pgoff_t start, end;
> > +	gfn_t gfn;
> > +
> > +	filemap_invalidate_lock_shared(mapping);
> > +
> > +	start = page->index;
> > +	end = start + thp_nr_pages(page);
> > +
> > +	list_for_each_entry(gmem, gmem_list, entry) {
> > +		xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
> > +			for (gfn = start; gfn < end; gfn++) {
> 
> Why the start end range used as gfn here ?
> 
> the page->index is offset of inode's page cache mapping and
> gmem address space, IIUC, gfn calculation should follow same
> way as kvm_gmem_invalidate_begin().

Also instead of sending signal multiple times, we can utilize lsb argument.
Something like this?

diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index a14eaac9dbad..8072ac901855 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -349,20 +349,35 @@ static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
        struct kvm_gmem *gmem;
        unsigned long index;
        pgoff_t start, end;
-       gfn_t gfn;
+       unsigned int order;
+       int nr_pages;
+       gfn_t gfn, gfn_end;
 
        filemap_invalidate_lock_shared(mapping);
 
        start = page->index;
        end = start + thp_nr_pages(page);
+       nr_pages = thp_nr_pages(page);
+       order = thp_order(page);
 
        list_for_each_entry(gmem, gmem_list, entry) {
                xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
-                       for (gfn = start; gfn < end; gfn++) {
-                               if (WARN_ON_ONCE(gfn < slot->base_gfn ||
-                                               gfn >= slot->base_gfn + slot->npages))
-                                       continue;
+                       gfn = slot->base_gfn + page->index - slot->gmem.pgoff;
 
+                       if (page->index + nr_pages <= slot->gmem.pgoff + slot->npages &&
+                           !(gfn & ~((1ULL << order) - 1))) {
+                               /*
+                                * FIXME: Tell userspace that the *private*
+                                * memory encountered an error.
+                                */
+                               send_sig_mceerr(BUS_MCEERR_AR,
+                                               (void __user *)gfn_to_hva_memslot(slot, gfn),
+                                               order, current);
+                               break;
+                       }
+
+                       gfn_end = min(gfn + nr_pages, slot->base_gfn + slot->npages);
+                       for (; gfn < gfn_end; gfn++) {
                                /*
                                 * FIXME: Tell userspace that the *private*
                                 * memory encountered an error.

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
