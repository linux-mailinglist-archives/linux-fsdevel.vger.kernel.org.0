Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF15B79F6FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 03:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjINB6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 21:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjINB5w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:57:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157272D76
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d77fa2e7771so603955276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656564; x=1695261364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0xZuxSvjNqdLSp6ZC4j5yUjHcPQeLv93P/PrP34/Z2I=;
        b=Ufaug8wTOv9hukpRcydfP2jWDZxTolqnl1NAyXz5wRRU1rFtPngJZE75cmzzNQBM9/
         j0UTcQEyoBPFFUk5pvuACeCIK57hUStYOLXU5G9jYzu3JgPTJhGQ75rFtEukhkOUADVO
         hMBchtGl3QIPOE4LIcaZkzvCM9m2N7N760zb/G/tNJu/IYhDFAISSGizv4RapN5mY9NN
         mAHU3NAcxWG3K6JDFGZ6jV4fkMXGnQLqWloDwJHYgQRazPFmhp8JQgdkPDkFkKeKvgsZ
         giZ58DK86xh996m59kMQefh44ITr/E5pEeqAOsbc0A8QSF9GSqTuWKAyle/pkLnr7bip
         JpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656564; x=1695261364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xZuxSvjNqdLSp6ZC4j5yUjHcPQeLv93P/PrP34/Z2I=;
        b=Wgv+pPO2DpzIZve1kEhKWj1qAG77wxLBgBRfQ/PqYMorR1xtV/ZRm4YqLa0SIOYND6
         YyA7zaAIazbHcvnnGYi8vga8i8YAj5kSSrLbxdNHk64zTJV4k6LsauvjfbWbAL7P3sdu
         wladE1h8jz9zB2a5wqffgyhoJW+0IFEXJhJroSnkgpwYWqMIQTNoH7ZX+VuDVgTA4DBT
         o/woR9lk21Gvi044y7/7w1q6Y9kM9ExsljTf5EQx/zTqlDskujwQMzhs85Lc+DdSTy0Y
         kuKY20EtqT8mzs2J1yYE/hnRb3un9ogLQUgQ44D7pAWILn5dvfXex/h6csUfI7JA9zeh
         KmmQ==
X-Gm-Message-State: AOJu0YxzxkiZ4z0fok8WKbKATkpOD61qkaEViWUjqSp/a9De/aS5/KJH
        1M38lIXZppaAo6er5er65dieTzV30WA=
X-Google-Smtp-Source: AGHT+IFUOIryDOCU+/5hEerl5iZde5CL20+1Yxt8GDISIc9Tx5mp6HRjdT4pBIqwkt3T5QOm51dkBscWUdY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1816:b0:d0e:e780:81b3 with SMTP id
 cf22-20020a056902181600b00d0ee78081b3mr102709ybb.2.1694656564588; Wed, 13 Sep
 2023 18:56:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:12 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-15-seanjc@google.com>
Subject: [RFC PATCH v12 14/33] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TODO

Cc: Fuad Tabba <tabba@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Maciej Szmigiero <mail@maciej.szmigiero.name>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Wang <wei.w.wang@intel.com>
Cc: Liam Merwick <liam.merwick@oracle.com>
Cc: Isaku Yamahata <isaku.yamahata@gmail.com>
Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h   |  48 +++
 include/uapi/linux/kvm.h   |  15 +-
 include/uapi/linux/magic.h |   1 +
 virt/kvm/Kconfig           |   4 +
 virt/kvm/Makefile.kvm      |   1 +
 virt/kvm/guest_mem.c       | 593 +++++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c        |  61 +++-
 virt/kvm/kvm_mm.h          |  38 +++
 8 files changed, 756 insertions(+), 5 deletions(-)
 create mode 100644 virt/kvm/guest_mem.c

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9b695391b11c..18d8f02a99a3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -591,8 +591,20 @@ struct kvm_memory_slot {
 	u32 flags;
 	short id;
 	u16 as_id;
+
+#ifdef CONFIG_KVM_PRIVATE_MEM
+	struct {
+		struct file __rcu *file;
+		pgoff_t pgoff;
+	} gmem;
+#endif
 };
 
+static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
+{
+	return slot && (slot->flags & KVM_MEM_PRIVATE);
+}
+
 static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
 {
 	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
@@ -687,6 +699,17 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
+/*
+ * Arch code must define kvm_arch_has_private_mem if support for private memory
+ * is enabled.
+ */
+#if !defined(kvm_arch_has_private_mem) && !IS_ENABLED(CONFIG_KVM_PRIVATE_MEM)
+static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
+{
+	return false;
+}
+#endif
+
 struct kvm_memslots {
 	u64 generation;
 	atomic_long_t last_used_slot;
@@ -1401,6 +1424,7 @@ void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 void kvm_mmu_invalidate_begin(struct kvm *kvm);
 void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end);
 void kvm_mmu_invalidate_end(struct kvm *kvm);
+bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
 
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg);
@@ -2360,6 +2384,30 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
+
+static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
+{
+	return IS_ENABLED(CONFIG_KVM_PRIVATE_MEM) &&
+	       kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
+}
+#else
+static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
+{
+	return false;
+}
 #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
 
+#ifdef CONFIG_KVM_PRIVATE_MEM
+int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
+			      gfn_t gfn, kvm_pfn_t *pfn, int *max_order);
+#else
+static inline int kvm_gmem_get_pfn(struct kvm *kvm,
+				   struct kvm_memory_slot *slot, gfn_t gfn,
+				   kvm_pfn_t *pfn, int *max_order)
+{
+	KVM_BUG_ON(1, kvm);
+	return -EIO;
+}
+#endif /* CONFIG_KVM_PRIVATE_MEM */
+
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f8642ff2eb9d..b6f90a273e2e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -102,7 +102,10 @@ struct kvm_userspace_memory_region2 {
 	__u64 guest_phys_addr;
 	__u64 memory_size;
 	__u64 userspace_addr;
-	__u64 pad[16];
+	__u64 gmem_offset;
+	__u32 gmem_fd;
+	__u32 pad1;
+	__u64 pad2[14];
 };
 
 /*
@@ -112,6 +115,7 @@ struct kvm_userspace_memory_region2 {
  */
 #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
 #define KVM_MEM_READONLY	(1UL << 1)
+#define KVM_MEM_PRIVATE		(1UL << 2)
 
 /* for KVM_IRQ_LINE */
 struct kvm_irq_level {
@@ -1228,6 +1232,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
 #define KVM_CAP_USER_MEMORY2 230
 #define KVM_CAP_MEMORY_ATTRIBUTES 231
+#define KVM_CAP_GUEST_MEMFD 232
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -2307,4 +2312,12 @@ struct kvm_memory_attributes {
 
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
+#define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
+
+struct kvm_create_guest_memfd {
+	__u64 size;
+	__u64 flags;
+	__u64 reserved[6];
+};
+
 #endif /* __LINUX_KVM_H */
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 6325d1d0e90f..afe9c376c9a5 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -101,5 +101,6 @@
 #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
+#define KVM_GUEST_MEMORY_MAGIC	0x474d454d	/* "GMEM" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 5bd7fcaf9089..08afef022db9 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -100,3 +100,7 @@ config KVM_GENERIC_MMU_NOTIFIER
 config KVM_GENERIC_MEMORY_ATTRIBUTES
        select KVM_GENERIC_MMU_NOTIFIER
        bool
+
+config KVM_PRIVATE_MEM
+       select XARRAY_MULTI
+       bool
diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index 2c27d5d0c367..a5a61bbe7f4c 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -12,3 +12,4 @@ kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
 kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
 kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
 kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
+kvm-$(CONFIG_KVM_PRIVATE_MEM) += $(KVM)/guest_mem.o
diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
new file mode 100644
index 000000000000..0dd3f836cf9c
--- /dev/null
+++ b/virt/kvm/guest_mem.c
@@ -0,0 +1,593 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/backing-dev.h>
+#include <linux/falloc.h>
+#include <linux/kvm_host.h>
+#include <linux/pagemap.h>
+#include <linux/pseudo_fs.h>
+
+#include <uapi/linux/magic.h>
+
+#include "kvm_mm.h"
+
+static struct vfsmount *kvm_gmem_mnt;
+
+struct kvm_gmem {
+	struct kvm *kvm;
+	struct xarray bindings;
+	struct list_head entry;
+};
+
+static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)
+{
+	struct folio *folio;
+
+	/* TODO: Support huge pages. */
+	folio = filemap_grab_folio(file->f_mapping, index);
+	if (IS_ERR_OR_NULL(folio))
+		return NULL;
+
+	/*
+	 * Use the up-to-date flag to track whether or not the memory has been
+	 * zeroed before being handed off to the guest.  There is no backing
+	 * storage for the memory, so the folio will remain up-to-date until
+	 * it's removed.
+	 *
+	 * TODO: Skip clearing pages when trusted firmware will do it when
+	 * assigning memory to the guest.
+	 */
+	if (!folio_test_uptodate(folio)) {
+		unsigned long nr_pages = folio_nr_pages(folio);
+		unsigned long i;
+
+		for (i = 0; i < nr_pages; i++)
+			clear_highpage(folio_page(folio, i));
+
+		folio_mark_uptodate(folio);
+	}
+
+	/*
+	 * Ignore accessed, referenced, and dirty flags.  The memory is
+	 * unevictable and there is no storage to write back to.
+	 */
+	return folio;
+}
+
+static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
+				      pgoff_t end)
+{
+	struct kvm_memory_slot *slot;
+	struct kvm *kvm = gmem->kvm;
+	unsigned long index;
+	bool flush = false;
+
+	KVM_MMU_LOCK(kvm);
+
+	kvm_mmu_invalidate_begin(kvm);
+
+	xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
+		pgoff_t pgoff = slot->gmem.pgoff;
+
+		struct kvm_gfn_range gfn_range = {
+			.start = slot->base_gfn + max(pgoff, start) - pgoff,
+			.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
+			.slot = slot,
+			.may_block = true,
+		};
+
+		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
+	}
+
+	if (flush)
+		kvm_flush_remote_tlbs(kvm);
+
+	KVM_MMU_UNLOCK(kvm);
+}
+
+static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
+				    pgoff_t end)
+{
+	struct kvm *kvm = gmem->kvm;
+
+	KVM_MMU_LOCK(kvm);
+	if (xa_find(&gmem->bindings, &start, end - 1, XA_PRESENT))
+		kvm_mmu_invalidate_end(kvm);
+	KVM_MMU_UNLOCK(kvm);
+}
+
+static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
+{
+	struct list_head *gmem_list = &inode->i_mapping->private_list;
+	pgoff_t start = offset >> PAGE_SHIFT;
+	pgoff_t end = (offset + len) >> PAGE_SHIFT;
+	struct kvm_gmem *gmem;
+
+	/*
+	 * Bindings must stable across invalidation to ensure the start+end
+	 * are balanced.
+	 */
+	filemap_invalidate_lock(inode->i_mapping);
+
+	list_for_each_entry(gmem, gmem_list, entry) {
+		kvm_gmem_invalidate_begin(gmem, start, end);
+		kvm_gmem_invalidate_end(gmem, start, end);
+	}
+
+	filemap_invalidate_unlock(inode->i_mapping);
+
+	return 0;
+}
+
+static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
+{
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t start, index, end;
+	int r;
+
+	/* Dedicated guest is immutable by default. */
+	if (offset + len > i_size_read(inode))
+		return -EINVAL;
+
+	filemap_invalidate_lock_shared(mapping);
+
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len) >> PAGE_SHIFT;
+
+	r = 0;
+	for (index = start; index < end; ) {
+		struct folio *folio;
+
+		if (signal_pending(current)) {
+			r = -EINTR;
+			break;
+		}
+
+		folio = kvm_gmem_get_folio(inode, index);
+		if (!folio) {
+			r = -ENOMEM;
+			break;
+		}
+
+		index = folio_next_index(folio);
+
+		folio_unlock(folio);
+		folio_put(folio);
+
+		/* 64-bit only, wrapping the index should be impossible. */
+		if (WARN_ON_ONCE(!index))
+			break;
+
+		cond_resched();
+	}
+
+	filemap_invalidate_unlock_shared(mapping);
+
+	return r;
+}
+
+static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
+			       loff_t len)
+{
+	int ret;
+
+	if (!(mode & FALLOC_FL_KEEP_SIZE))
+		return -EOPNOTSUPP;
+
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
+		return -EOPNOTSUPP;
+
+	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
+		return -EINVAL;
+
+	if (mode & FALLOC_FL_PUNCH_HOLE)
+		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
+	else
+		ret = kvm_gmem_allocate(file_inode(file), offset, len);
+
+	if (!ret)
+		file_modified(file);
+	return ret;
+}
+
+static int kvm_gmem_release(struct inode *inode, struct file *file)
+{
+	struct kvm_gmem *gmem = file->private_data;
+	struct kvm_memory_slot *slot;
+	struct kvm *kvm = gmem->kvm;
+	unsigned long index;
+
+	/*
+	 * Prevent concurrent attempts to *unbind* a memslot.  This is the last
+	 * reference to the file and thus no new bindings can be created, but
+	 * dereferencing the slot for existing bindings needs to be protected
+	 * against memslot updates, specifically so that unbind doesn't race
+	 * and free the memslot (kvm_gmem_get_file() will return NULL).
+	 */
+	mutex_lock(&kvm->slots_lock);
+
+	filemap_invalidate_lock(inode->i_mapping);
+
+	xa_for_each(&gmem->bindings, index, slot)
+		rcu_assign_pointer(slot->gmem.file, NULL);
+
+	synchronize_rcu();
+
+	/*
+	 * All in-flight operations are gone and new bindings can be created.
+	 * Zap all SPTEs pointed at by this file.  Do not free the backing
+	 * memory, as its lifetime is associated with the inode, not the file.
+	 */
+	kvm_gmem_invalidate_begin(gmem, 0, -1ul);
+	kvm_gmem_invalidate_end(gmem, 0, -1ul);
+
+	list_del(&gmem->entry);
+
+	filemap_invalidate_unlock(inode->i_mapping);
+
+	mutex_unlock(&kvm->slots_lock);
+
+	xa_destroy(&gmem->bindings);
+	kfree(gmem);
+
+	kvm_put_kvm(kvm);
+
+	return 0;
+}
+
+static struct file *kvm_gmem_get_file(struct kvm_memory_slot *slot)
+{
+	struct file *file;
+
+	rcu_read_lock();
+
+	file = rcu_dereference(slot->gmem.file);
+	if (file && !get_file_rcu(file))
+		file = NULL;
+
+	rcu_read_unlock();
+
+	return file;
+}
+
+static const struct file_operations kvm_gmem_fops = {
+	.open		= generic_file_open,
+	.release	= kvm_gmem_release,
+	.fallocate	= kvm_gmem_fallocate,
+};
+
+static int kvm_gmem_migrate_folio(struct address_space *mapping,
+				  struct folio *dst, struct folio *src,
+				  enum migrate_mode mode)
+{
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+
+static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
+{
+	struct list_head *gmem_list = &mapping->private_list;
+	struct kvm_gmem *gmem;
+	pgoff_t start, end;
+
+	filemap_invalidate_lock_shared(mapping);
+
+	start = page->index;
+	end = start + thp_nr_pages(page);
+
+	list_for_each_entry(gmem, gmem_list, entry)
+		kvm_gmem_invalidate_begin(gmem, start, end);
+
+	/*
+	 * Do not truncate the range, what action is taken in response to the
+	 * error is userspace's decision (assuming the architecture supports
+	 * gracefully handling memory errors).  If/when the guest attempts to
+	 * access a poisoned page, kvm_gmem_get_pfn() will return -EHWPOISON,
+	 * at which point KVM can either terminate the VM or propagate the
+	 * error to userspace.
+	 */
+
+	list_for_each_entry(gmem, gmem_list, entry)
+		kvm_gmem_invalidate_end(gmem, start, end);
+
+	filemap_invalidate_unlock_shared(mapping);
+
+	return MF_DELAYED;
+}
+
+static const struct address_space_operations kvm_gmem_aops = {
+	.dirty_folio = noop_dirty_folio,
+#ifdef CONFIG_MIGRATION
+	.migrate_folio	= kvm_gmem_migrate_folio,
+#endif
+	.error_remove_page = kvm_gmem_error_page,
+};
+
+static int kvm_gmem_getattr(struct mnt_idmap *idmap, const struct path *path,
+			    struct kstat *stat, u32 request_mask,
+			    unsigned int query_flags)
+{
+	struct inode *inode = path->dentry->d_inode;
+
+	/* TODO */
+	generic_fillattr(idmap, request_mask, inode, stat);
+	return 0;
+}
+
+static int kvm_gmem_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			    struct iattr *attr)
+{
+	/* TODO */
+	return -EINVAL;
+}
+static const struct inode_operations kvm_gmem_iops = {
+	.getattr	= kvm_gmem_getattr,
+	.setattr	= kvm_gmem_setattr,
+};
+
+static int __kvm_gmem_create(struct kvm *kvm, loff_t size, struct vfsmount *mnt)
+{
+	const char *anon_name = "[kvm-gmem]";
+	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
+	struct kvm_gmem *gmem;
+	struct inode *inode;
+	struct file *file;
+	int fd, err;
+
+	inode = alloc_anon_inode(mnt->mnt_sb);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	err = security_inode_init_security_anon(inode, &qname, NULL);
+	if (err)
+		goto err_inode;
+
+	inode->i_private = (void *)(unsigned long)flags;
+	inode->i_op = &kvm_gmem_iops;
+	inode->i_mapping->a_ops = &kvm_gmem_aops;
+	inode->i_mode |= S_IFREG;
+	inode->i_size = size;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+	mapping_set_unmovable(inode->i_mapping);
+	/* Unmovable mappings are supposed to be marked unevictable as well. */
+	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+
+	fd = get_unused_fd_flags(0);
+	if (fd < 0) {
+		err = fd;
+		goto err_inode;
+	}
+
+	file = alloc_file_pseudo(inode, mnt, "kvm-gmem", O_RDWR, &kvm_gmem_fops);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_fd;
+	}
+
+	file->f_flags |= O_LARGEFILE;
+	file->f_mapping = inode->i_mapping;
+
+	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
+	if (!gmem) {
+		err = -ENOMEM;
+		goto err_file;
+	}
+
+	kvm_get_kvm(kvm);
+	gmem->kvm = kvm;
+	xa_init(&gmem->bindings);
+
+	file->private_data = gmem;
+
+	list_add(&gmem->entry, &inode->i_mapping->private_list);
+
+	fd_install(fd, file);
+	return fd;
+
+err_file:
+	fput(file);
+err_fd:
+	put_unused_fd(fd);
+err_inode:
+	iput(inode);
+	return err;
+}
+
+static bool kvm_gmem_is_valid_size(loff_t size, u64 flags)
+{
+	if (size < 0 || !PAGE_ALIGNED(size))
+		return false;
+
+	return true;
+}
+
+int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
+{
+	loff_t size = args->size;
+	u64 flags = args->flags;
+	u64 valid_flags = 0;
+
+	if (flags & ~valid_flags)
+		return -EINVAL;
+
+	if (!kvm_gmem_is_valid_size(size, flags))
+		return -EINVAL;
+
+	return __kvm_gmem_create(kvm, size, flags, kvm_gmem_mnt);
+}
+
+int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
+		  unsigned int fd, loff_t offset)
+{
+	loff_t size = slot->npages << PAGE_SHIFT;
+	unsigned long start, end, flags;
+	struct kvm_gmem *gmem;
+	struct inode *inode;
+	struct file *file;
+
+	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+
+	if (file->f_op != &kvm_gmem_fops)
+		goto err;
+
+	gmem = file->private_data;
+	if (gmem->kvm != kvm)
+		goto err;
+
+	inode = file_inode(file);
+	flags = (unsigned long)inode->i_private;
+
+	/*
+	 * For simplicity, require the offset into the file and the size of the
+	 * memslot to be aligned to the largest possible page size used to back
+	 * the file (same as the size of the file itself).
+	 */
+	if (!kvm_gmem_is_valid_size(offset, flags) ||
+	    !kvm_gmem_is_valid_size(size, flags))
+		goto err;
+
+	if (offset + size > i_size_read(inode))
+		goto err;
+
+	filemap_invalidate_lock(inode->i_mapping);
+
+	start = offset >> PAGE_SHIFT;
+	end = start + slot->npages;
+
+	if (!xa_empty(&gmem->bindings) &&
+	    xa_find(&gmem->bindings, &start, end - 1, XA_PRESENT)) {
+		filemap_invalidate_unlock(inode->i_mapping);
+		goto err;
+	}
+
+	/*
+	 * No synchronize_rcu() needed, any in-flight readers are guaranteed to
+	 * be see either a NULL file or this new file, no need for them to go
+	 * away.
+	 */
+	rcu_assign_pointer(slot->gmem.file, file);
+	slot->gmem.pgoff = start;
+
+	xa_store_range(&gmem->bindings, start, end - 1, slot, GFP_KERNEL);
+	filemap_invalidate_unlock(inode->i_mapping);
+
+	/*
+	 * Drop the reference to the file, even on success.  The file pins KVM,
+	 * not the other way 'round.  Active bindings are invalidated if the
+	 * file is closed before memslots are destroyed.
+	 */
+	fput(file);
+	return 0;
+
+err:
+	fput(file);
+	return -EINVAL;
+}
+
+void kvm_gmem_unbind(struct kvm_memory_slot *slot)
+{
+	unsigned long start = slot->gmem.pgoff;
+	unsigned long end = start + slot->npages;
+	struct kvm_gmem *gmem;
+	struct file *file;
+
+	/*
+	 * Nothing to do if the underlying file was already closed (or is being
+	 * closed right now), kvm_gmem_release() invalidates all bindings.
+	 */
+	file = kvm_gmem_get_file(slot);
+	if (!file)
+		return;
+
+	gmem = file->private_data;
+
+	filemap_invalidate_lock(file->f_mapping);
+	xa_store_range(&gmem->bindings, start, end - 1, NULL, GFP_KERNEL);
+	rcu_assign_pointer(slot->gmem.file, NULL);
+	synchronize_rcu();
+	filemap_invalidate_unlock(file->f_mapping);
+
+	fput(file);
+}
+
+int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
+		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
+{
+	pgoff_t index = gfn - slot->base_gfn + slot->gmem.pgoff;
+	struct kvm_gmem *gmem;
+	struct folio *folio;
+	struct page *page;
+	struct file *file;
+	int r;
+
+	file = kvm_gmem_get_file(slot);
+	if (!file)
+		return -EFAULT;
+
+	gmem = file->private_data;
+
+	if (WARN_ON_ONCE(xa_load(&gmem->bindings, index) != slot)) {
+		r = -EIO;
+		goto out_fput;
+	}
+
+	folio = kvm_gmem_get_folio(file_inode(file), index);
+	if (!folio) {
+		r = -ENOMEM;
+		goto out_fput;
+	}
+
+	if (folio_test_hwpoison(folio)) {
+		r = -EHWPOISON;
+		goto out_unlock;
+	}
+
+	page = folio_file_page(folio, index);
+
+	*pfn = page_to_pfn(page);
+	if (max_order)
+		*max_order = compound_order(compound_head(page));
+	r = 0;
+
+out_unlock:
+	folio_unlock(folio);
+out_fput:
+	fput(file);
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);
+
+static int kvm_gmem_init_fs_context(struct fs_context *fc)
+{
+	if (!init_pseudo(fc, KVM_GUEST_MEMORY_MAGIC))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static struct file_system_type kvm_gmem_fs = {
+	.name		 = "kvm_guest_memory",
+	.init_fs_context = kvm_gmem_init_fs_context,
+	.kill_sb	 = kill_anon_super,
+};
+
+int kvm_gmem_init(void)
+{
+	kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);
+	if (IS_ERR(kvm_gmem_mnt))
+		return PTR_ERR(kvm_gmem_mnt);
+
+	/* For giggles.  Userspace can never map this anyways. */
+	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
+
+	return 0;
+}
+
+void kvm_gmem_exit(void)
+{
+	kern_unmount(kvm_gmem_mnt);
+	kvm_gmem_mnt = NULL;
+}
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2726938b684b..68a6119e09e4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -796,7 +796,7 @@ void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
 	}
 }
 
-static bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
 	return kvm_unmap_gfn_range(kvm, range);
@@ -1034,6 +1034,9 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
 /* This does not remove the slot from struct kvm_memslots data structures */
 static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 {
+	if (slot->flags & KVM_MEM_PRIVATE)
+		kvm_gmem_unbind(slot);
+
 	kvm_destroy_dirty_bitmap(slot);
 
 	kvm_arch_free_memslot(kvm, slot);
@@ -1598,10 +1601,18 @@ static void kvm_replace_memslot(struct kvm *kvm,
 	}
 }
 
-static int check_memory_region_flags(const struct kvm_userspace_memory_region2 *mem)
+static int check_memory_region_flags(struct kvm *kvm,
+				     const struct kvm_userspace_memory_region2 *mem)
 {
 	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
 
+	if (kvm_arch_has_private_mem(kvm))
+		valid_flags |= KVM_MEM_PRIVATE;
+
+	/* Dirty logging private memory is not currently supported. */
+	if (mem->flags & KVM_MEM_PRIVATE)
+		valid_flags &= ~KVM_MEM_LOG_DIRTY_PAGES;
+
 #ifdef __KVM_HAVE_READONLY_MEM
 	valid_flags |= KVM_MEM_READONLY;
 #endif
@@ -2010,7 +2021,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	int as_id, id;
 	int r;
 
-	r = check_memory_region_flags(mem);
+	r = check_memory_region_flags(kvm, mem);
 	if (r)
 		return r;
 
@@ -2029,6 +2040,10 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
 			mem->memory_size))
 		return -EINVAL;
+	if (mem->flags & KVM_MEM_PRIVATE &&
+	    (mem->gmem_offset & (PAGE_SIZE - 1) ||
+	     mem->gmem_offset + mem->memory_size < mem->gmem_offset))
+		return -EINVAL;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
 		return -EINVAL;
 	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
@@ -2067,6 +2082,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
 			return -EINVAL;
 	} else { /* Modify an existing slot. */
+		/* Private memslots are immutable, they can only be deleted. */
+		if (mem->flags & KVM_MEM_PRIVATE)
+			return -EINVAL;
 		if ((mem->userspace_addr != old->userspace_addr) ||
 		    (npages != old->npages) ||
 		    ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
@@ -2095,10 +2113,23 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	new->npages = npages;
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
+	if (mem->flags & KVM_MEM_PRIVATE) {
+		r = kvm_gmem_bind(kvm, new, mem->gmem_fd, mem->gmem_offset);
+		if (r)
+			goto out;
+	}
 
 	r = kvm_set_memslot(kvm, old, new, change);
 	if (r)
-		kfree(new);
+		goto out_restricted;
+
+	return 0;
+
+out_restricted:
+	if (mem->flags & KVM_MEM_PRIVATE)
+		kvm_gmem_unbind(new);
+out:
+	kfree(new);
 	return r;
 }
 EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
@@ -2434,6 +2465,8 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
+	if (kvm_arch_has_private_mem(kvm))
+		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
 	return 0;
 }
 
@@ -4824,6 +4857,10 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_BINARY_STATS_FD:
 	case KVM_CAP_SYSTEM_EVENT_DATA:
 		return 1;
+#ifdef CONFIG_KVM_PRIVATE_MEM
+	case KVM_CAP_GUEST_MEMFD:
+		return !kvm || kvm_arch_has_private_mem(kvm);
+#endif
 	default:
 		break;
 	}
@@ -5254,6 +5291,16 @@ static long kvm_vm_ioctl(struct file *filp,
 	case KVM_GET_STATS_FD:
 		r = kvm_vm_ioctl_get_stats_fd(kvm);
 		break;
+	case KVM_CREATE_GUEST_MEMFD: {
+		struct kvm_create_guest_memfd guest_memfd;
+
+		r = -EFAULT;
+		if (copy_from_user(&guest_memfd, argp, sizeof(guest_memfd)))
+			goto out;
+
+		r = kvm_gmem_create(kvm, &guest_memfd);
+		break;
+	}
 	default:
 		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
 	}
@@ -6375,6 +6422,10 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	if (r)
 		goto err_async_pf;
 
+	r = kvm_gmem_init();
+	if (r)
+		goto err_gmem;
+
 	kvm_chardev_ops.owner = module;
 
 	kvm_preempt_ops.sched_in = kvm_sched_in;
@@ -6401,6 +6452,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 err_register:
 	kvm_vfio_ops_exit();
 err_vfio:
+	kvm_gmem_exit();
+err_gmem:
 	kvm_async_pf_deinit();
 err_async_pf:
 	kvm_irqfd_exit();
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 180f1a09e6ba..798f20d612bb 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -37,4 +37,42 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 }
 #endif /* HAVE_KVM_PFNCACHE */
 
+#ifdef CONFIG_KVM_PRIVATE_MEM
+int kvm_gmem_init(void);
+void kvm_gmem_exit(void);
+int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
+int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
+		  unsigned int fd, loff_t offset);
+void kvm_gmem_unbind(struct kvm_memory_slot *slot);
+#else
+static inline int kvm_gmem_init(void)
+{
+	return 0;
+}
+
+static inline void kvm_gmem_exit(void)
+{
+
+}
+
+static inline int kvm_gmem_create(struct kvm *kvm,
+				  struct kvm_create_guest_memfd *args)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int kvm_gmem_bind(struct kvm *kvm,
+					 struct kvm_memory_slot *slot,
+					 unsigned int fd, loff_t offset)
+{
+	WARN_ON_ONCE(1);
+	return -EIO;
+}
+
+static inline void kvm_gmem_unbind(struct kvm_memory_slot *slot)
+{
+	WARN_ON_ONCE(1);
+}
+#endif /* CONFIG_KVM_PRIVATE_MEM */
+
 #endif /* __KVM_MM_H__ */
-- 
2.42.0.283.g2d96d420d3-goog

