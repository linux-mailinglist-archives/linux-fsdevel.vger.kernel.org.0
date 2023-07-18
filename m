Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF80758964
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 01:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjGRXu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 19:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjGRXuK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:50:10 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF072689
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:48:57 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55b2ab496ecso2843701a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724135; x=1692316135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=f3ZMxHz3bMEiGy82l1TdBjwnrB3pHfAW+Q0omz0gfYw=;
        b=zhy/akT4kfbyUvpFGWblDxiVv/JGWOIqXnPzBh1+KARzXZ0JdbGb2FpHwQHHv7fjN4
         RDXsPUednXcpnVF/r1u4hdUpljVX/ERAKeE327nave00WVGTxpK46soa9jLAB9FPvT4q
         8jimpKmgUX+C8gYa1RfRx79JVkYceWLWH64vhM96/MebP0lcjlofGvUPC5/UVTbwsCNC
         8S6jBqAKBjc5z4xMyB65XeSr51tF9P+a0Z5/lx9y5nY/Ct9xwVriJwHE6YEvRLt9PxRx
         EQOHbb6ekWltGOVu4UYPtNcnhBMnzOMmP1fXbS8gEE2+WMcZBZCG0a39Y0+pwJac0BhG
         QRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724135; x=1692316135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3ZMxHz3bMEiGy82l1TdBjwnrB3pHfAW+Q0omz0gfYw=;
        b=epsXNAmDZ3g71WanTY+BrS4y6HYam8C6M5kB9bqwmaMe1spUJ5J5AGeYHHo6tsxRrO
         ZYrgru8xrSE7nBly0yC6viA4Cm/6lI4bJmpaWnfeE2rCYzO4v22zMRig43TlHPAExI2G
         zFBWV5VYNeoe3El2Gj9bXgjeR1duP90CkAFJpq8mfa24mJ5QggsFgs5ozQHFQPz3uhIl
         xKpCozWa5o6mUR28IX02Ybd6guwFguKmm/VbvXIGZrfpV/b2qALI32TV7pV8OMrgQm/2
         /SKiDSqHhd0IMrjBN94OtbL5Lp4WqvTU8focdaOwNiIgzMHcKypVZFIGAilB0lzlxiGT
         b/Iw==
X-Gm-Message-State: ABy/qLYgZufAbOHZAvb+exVr1bEoFG28nbh3m9x3UaVV9qdaWCGAjo2y
        E/XHMIawLgtXbnU7ZtfG+6MjR1DATfs=
X-Google-Smtp-Source: APBJJlHWqYDCKk9l+6hhcyO0ycYtjkg7rAWcHEaP+HFNWvcqSq7I9U1NOWP+pyzb0Gx2BsDq432iOA7Ityg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6f8a:0:b0:557:33c6:603a with SMTP id
 k132-20020a636f8a000000b0055733c6603amr17649pgc.7.1689724134884; Tue, 18 Jul
 2023 16:48:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:44:55 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-13-seanjc@google.com>
Subject: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h   |  48 +++
 include/uapi/linux/kvm.h   |  14 +-
 include/uapi/linux/magic.h |   1 +
 virt/kvm/Kconfig           |   4 +
 virt/kvm/Makefile.kvm      |   1 +
 virt/kvm/guest_mem.c       | 591 +++++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c        |  58 +++-
 virt/kvm/kvm_mm.h          |  38 +++
 8 files changed, 750 insertions(+), 5 deletions(-)
 create mode 100644 virt/kvm/guest_mem.c

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 97db63da6227..0d1e2ee8ae7a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -592,8 +592,20 @@ struct kvm_memory_slot {
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
@@ -688,6 +700,17 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
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
@@ -1380,6 +1403,7 @@ void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 void kvm_mmu_invalidate_begin(struct kvm *kvm);
 void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end);
 void kvm_mmu_invalidate_end(struct kvm *kvm);
+bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
 
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg);
@@ -2313,6 +2337,30 @@ static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn
 
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
index f065c57db327..9b344fc98598 100644
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
@@ -2284,4 +2288,12 @@ struct kvm_memory_attributes {
 
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
index 6325d1d0e90f..15041aa7d9ae 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -101,5 +101,6 @@
 #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
+#define GUEST_MEMORY_MAGIC	0x474d454d	/* "GMEM" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 8375bc49f97d..3ee3205e0b39 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -103,3 +103,7 @@ config KVM_GENERIC_MMU_NOTIFIER
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
index 000000000000..1b705fd63fa8
--- /dev/null
+++ b/virt/kvm/guest_mem.c
@@ -0,0 +1,591 @@
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
+	if (!folio)
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
+	list_for_each_entry(gmem, gmem_list, entry)
+		kvm_gmem_invalidate_begin(gmem, start, end);
+
+	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
+
+	list_for_each_entry(gmem, gmem_list, entry)
+		kvm_gmem_invalidate_end(gmem, start, end);
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
+	filemap_invalidate_lock(inode->i_mapping);
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
+	mutex_unlock(&kvm->slots_lock);
+
+	list_del(&gmem->entry);
+
+	filemap_invalidate_unlock(inode->i_mapping);
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
+	struct kvm_memory_slot *slot;
+	struct kvm_gmem *gmem;
+	unsigned long index;
+	pgoff_t start, end;
+	gfn_t gfn;
+
+	filemap_invalidate_lock_shared(mapping);
+
+	start = page->index;
+	end = start + thp_nr_pages(page);
+
+	list_for_each_entry(gmem, gmem_list, entry) {
+		xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
+			for (gfn = start; gfn < end; gfn++) {
+				if (WARN_ON_ONCE(gfn < slot->base_gfn ||
+						gfn >= slot->base_gfn + slot->npages))
+					continue;
+
+				/*
+				 * FIXME: Tell userspace that the *private*
+				 * memory encountered an error.
+				 */
+				send_sig_mceerr(BUS_MCEERR_AR,
+						(void __user *)gfn_to_hva_memslot(slot, gfn),
+						PAGE_SHIFT, current);
+			}
+		}
+	}
+
+	filemap_invalidate_unlock_shared(mapping);
+
+	return 0;
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
+static int  kvm_gmem_getattr(struct mnt_idmap *idmap,
+			     const struct path *path, struct kstat *stat,
+			     u32 request_mask, unsigned int query_flags)
+{
+	struct inode *inode = path->dentry->d_inode;
+
+	/* TODO */
+	generic_fillattr(idmap, inode, stat);
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
+	mapping_set_unevictable(inode->i_mapping);
+	mapping_set_unmovable(inode->i_mapping);
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
+		return -EINVAL;
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
+
+	file = kvm_gmem_get_file(slot);
+	if (!file)
+		return -EFAULT;
+
+	gmem = file->private_data;
+
+	if (WARN_ON_ONCE(xa_load(&gmem->bindings, index) != slot)) {
+		fput(file);
+		return -EIO;
+	}
+
+	folio = kvm_gmem_get_folio(file_inode(file), index);
+	if (!folio) {
+		fput(file);
+		return -ENOMEM;
+	}
+
+	page = folio_file_page(folio, index);
+
+	*pfn = page_to_pfn(page);
+	*max_order = compound_order(compound_head(page));
+
+	folio_unlock(folio);
+	fput(file);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);
+
+static int kvm_gmem_init_fs_context(struct fs_context *fc)
+{
+	if (!init_pseudo(fc, GUEST_MEMORY_MAGIC))
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
index 1a31bfa025b0..a8686e8473a4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -761,7 +761,7 @@ void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
 	}
 }
 
-static bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
 	return kvm_unmap_gfn_range(kvm, range);
@@ -992,6 +992,9 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
 /* This does not remove the slot from struct kvm_memslots data structures */
 static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 {
+	if (slot->flags & KVM_MEM_PRIVATE)
+		kvm_gmem_unbind(slot);
+
 	kvm_destroy_dirty_bitmap(slot);
 
 	kvm_arch_free_memslot(kvm, slot);
@@ -1556,10 +1559,18 @@ static void kvm_replace_memslot(struct kvm *kvm,
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
@@ -1968,7 +1979,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	int as_id, id;
 	int r;
 
-	r = check_memory_region_flags(mem);
+	r = check_memory_region_flags(kvm, mem);
 	if (r)
 		return r;
 
@@ -1987,6 +1998,10 @@ int __kvm_set_memory_region(struct kvm *kvm,
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
@@ -2025,6 +2040,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
 			return -EINVAL;
 	} else { /* Modify an existing slot. */
+		/* Private memslots are immutable, they can only be deleted. */
+		if (mem->flags & KVM_MEM_PRIVATE)
+			return -EINVAL;
 		if ((mem->userspace_addr != old->userspace_addr) ||
 		    (npages != old->npages) ||
 		    ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
@@ -2053,10 +2071,23 @@ int __kvm_set_memory_region(struct kvm *kvm,
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
@@ -2356,6 +2387,8 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
+	if (kvm_arch_has_private_mem(kvm))
+		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
 	return 0;
 }
 
@@ -5134,6 +5167,16 @@ static long kvm_vm_ioctl(struct file *filp,
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
@@ -6255,12 +6298,17 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	if (r)
 		goto err_async_pf;
 
+	r = kvm_gmem_init();
+	if (r)
+		goto err_gmem;
+
 	kvm_chardev_ops.owner = module;
 
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
 	kvm_init_debug();
+	kvm_gmem_init();
 
 	r = kvm_vfio_ops_init();
 	if (WARN_ON_ONCE(r))
@@ -6281,6 +6329,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
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
2.41.0.255.g8b1d071c50-goog

