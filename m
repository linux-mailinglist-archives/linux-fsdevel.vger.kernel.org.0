Return-Path: <linux-fsdevel+bounces-2004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C23BD7E14D5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 17:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307D31F2155D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29492199CE;
	Sun,  5 Nov 2023 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbQHfe+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357FE19453
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 16:32:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB07FF
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 08:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699201948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JW6MWV7ggVeSMblnueMAykpNKrW9E69j7p153d688oM=;
	b=UbQHfe+E5L182n13dysV4l3LIEigj4FdDF/v1Jpw6qbA5r0XLct/az6xZQ4+TVFTGtNwOp
	1uSnxb7+sTS+pXpnVnq8XAoIpeIXM1ttpMsIlIlESooo4wU9vUszBXnR2gY+/b6Zx3GkAU
	3/gRglsoh8ZMKf38v7q85Do3yfCTpuo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-1qNMyg5EPcizAR9tFcoIUw-1; Sun,
 05 Nov 2023 11:32:25 -0500
X-MC-Unique: 1qNMyg5EPcizAR9tFcoIUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFA5229ABA1A;
	Sun,  5 Nov 2023 16:32:22 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E636B2166B26;
	Sun,  5 Nov 2023 16:32:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Fuad Tabba <tabba@google.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Anish Moorthy <amoorthy@google.com>,
	David Matlack <dmatlack@google.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 12/34] KVM: Introduce per-page memory attributes
Date: Sun,  5 Nov 2023 17:30:15 +0100
Message-ID: <20231105163040.14904-13-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-1-pbonzini@redhat.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Chao Peng <chao.p.peng@linux.intel.com>

In confidential computing usages, whether a page is private or shared is
necessary information for KVM to perform operations like page fault
handling, page zapping etc. There are other potential use cases for
per-page memory attributes, e.g. to make memory read-only (or no-exec,
or exec-only, etc.) without having to modify memslots.

Introduce the KVM_SET_MEMORY_ATTRIBUTES ioctl, advertised by
KVM_CAP_MEMORY_ATTRIBUTES, to allow userspace to set the per-page memory
attributes to a guest memory range.

Use an xarray to store the per-page attributes internally, with a naive,
not fully optimized implementation, i.e. prioritize correctness over
performance for the initial implementation.

Use bit 3 for the PRIVATE attribute so that KVM can use bits 0-2 for RWX
attributes/protections in the future, e.g. to give userspace fine-grained
control over read, write, and execute protections for guest memory.

Provide arch hooks for handling attribute changes before and after common
code sets the new attributes, e.g. x86 will use the "pre" hook to zap all
relevant mappings, and the "post" hook to track whether or not hugepages
can be used to map the range.

To simplify the implementation wrap the entire sequence with
kvm_mmu_invalidate_{begin,end}() even though the operation isn't strictly
guaranteed to be an invalidation.  For the initial use case, x86 *will*
always invalidate memory, and preventing arch code from creating new
mappings while the attributes are in flux makes it much easier to reason
about the correctness of consuming attributes.

It's possible that future usages may not require an invalidation, e.g.
if KVM ends up supporting RWX protections and userspace grants _more_
protections, but again opt for simplicity and punt optimizations to
if/when they are needed.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com
Cc: Fuad Tabba <tabba@google.com>
Cc: Xu Yilun <yilun.xu@intel.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20231027182217.3615211-14-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst |  36 ++++++
 include/linux/kvm_host.h       |  19 +++
 include/uapi/linux/kvm.h       |  13 ++
 virt/kvm/Kconfig               |   4 +
 virt/kvm/kvm_main.c            | 216 +++++++++++++++++++++++++++++++++
 5 files changed, 288 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 481fb0e2ce90..083ed507e200 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6214,6 +6214,42 @@ superset of the features supported by the system.
 
 See KVM_SET_USER_MEMORY_REGION.
 
+4.141 KVM_SET_MEMORY_ATTRIBUTES
+-------------------------------
+
+:Capability: KVM_CAP_MEMORY_ATTRIBUTES
+:Architectures: x86
+:Type: vm ioctl
+:Parameters: struct kvm_memory_attributes (in)
+:Returns: 0 on success, <0 on error
+
+KVM_SET_MEMORY_ATTRIBUTES allows userspace to set memory attributes for a range
+of guest physical memory.
+
+::
+
+  struct kvm_memory_attributes {
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+  };
+
+  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+
+The address and size must be page aligned.  The supported attributes can be
+retrieved via ioctl(KVM_CHECK_EXTENSION) on KVM_CAP_MEMORY_ATTRIBUTES.  If
+executed on a VM, KVM_CAP_MEMORY_ATTRIBUTES precisely returns the attributes
+supported by that VM.  If executed at system scope, KVM_CAP_MEMORY_ATTRIBUTES
+returns all attributes supported by KVM.  The only attribute defined at this
+time is KVM_MEMORY_ATTRIBUTE_PRIVATE, which marks the associated gfn as being
+guest private memory.
+
+Note, there is no "get" API.  Userspace is responsible for explicitly tracking
+the state of a gfn/page as needed.
+
+The "flags" field is reserved for future extensions and must be '0'.
+
 5. The kvm_run structure
 ========================
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 96aa930536b1..68a144cb7dbc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -256,6 +256,7 @@ int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 union kvm_mmu_notifier_arg {
 	pte_t pte;
+	unsigned long attributes;
 };
 
 struct kvm_gfn_range {
@@ -806,6 +807,10 @@ struct kvm {
 
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 	struct notifier_block pm_notifier;
+#endif
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	/* Protected by slots_locks (for writes) and RCU (for reads) */
+	struct xarray mem_attr_array;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
 };
@@ -2338,4 +2343,18 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 	vcpu->run->memory_fault.flags = 0;
 }
 
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
+}
+
+bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+				     unsigned long attrs);
+bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
+					struct kvm_gfn_range *range);
+bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
+					 struct kvm_gfn_range *range);
+#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
+
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 59010a685007..e8d167e54980 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1220,6 +1220,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES 230
 #define KVM_CAP_USER_MEMORY2 231
 #define KVM_CAP_MEMORY_FAULT_INFO 232
+#define KVM_CAP_MEMORY_ATTRIBUTES 233
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -2288,4 +2289,16 @@ struct kvm_s390_zpci_op {
 /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
 #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
 
+/* Available with KVM_CAP_MEMORY_ATTRIBUTES */
+#define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd2, struct kvm_memory_attributes)
+
+struct kvm_memory_attributes {
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+};
+
+#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index ecae2914c97e..5bd7fcaf9089 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -96,3 +96,7 @@ config KVM_GENERIC_HARDWARE_ENABLING
 config KVM_GENERIC_MMU_NOTIFIER
        select MMU_NOTIFIER
        bool
+
+config KVM_GENERIC_MEMORY_ATTRIBUTES
+       select KVM_GENERIC_MMU_NOTIFIER
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7f3291dec7a6..f1a575d39b3b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1211,6 +1211,9 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	spin_lock_init(&kvm->mn_invalidate_lock);
 	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
 	xa_init(&kvm->vcpu_array);
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	xa_init(&kvm->mem_attr_array);
+#endif
 
 	INIT_LIST_HEAD(&kvm->gpc_list);
 	spin_lock_init(&kvm->gpc_lock);
@@ -1391,6 +1394,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	}
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	cleanup_srcu_struct(&kvm->srcu);
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	xa_destroy(&kvm->mem_attr_array);
+#endif
 	kvm_arch_free_vm(kvm);
 	preempt_notifier_dec();
 	hardware_disable_all();
@@ -2397,6 +2403,200 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
 
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+/*
+ * Returns true if _all_ gfns in the range [@start, @end) have attributes
+ * matching @attrs.
+ */
+bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+				     unsigned long attrs)
+{
+	XA_STATE(xas, &kvm->mem_attr_array, start);
+	unsigned long index;
+	bool has_attrs;
+	void *entry;
+
+	rcu_read_lock();
+
+	if (!attrs) {
+		has_attrs = !xas_find(&xas, end - 1);
+		goto out;
+	}
+
+	has_attrs = true;
+	for (index = start; index < end; index++) {
+		do {
+			entry = xas_next(&xas);
+		} while (xas_retry(&xas, entry));
+
+		if (xas.xa_index != index || xa_to_value(entry) != attrs) {
+			has_attrs = false;
+			break;
+		}
+	}
+
+out:
+	rcu_read_unlock();
+	return has_attrs;
+}
+
+static u64 kvm_supported_mem_attributes(struct kvm *kvm)
+{
+	if (!kvm)
+		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+
+	return 0;
+}
+
+static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
+						 struct kvm_mmu_notifier_range *range)
+{
+	struct kvm_gfn_range gfn_range;
+	struct kvm_memory_slot *slot;
+	struct kvm_memslots *slots;
+	struct kvm_memslot_iter iter;
+	bool found_memslot = false;
+	bool ret = false;
+	int i;
+
+	gfn_range.arg = range->arg;
+	gfn_range.may_block = range->may_block;
+
+	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+		slots = __kvm_memslots(kvm, i);
+
+		kvm_for_each_memslot_in_gfn_range(&iter, slots, range->start, range->end) {
+			slot = iter.slot;
+			gfn_range.slot = slot;
+
+			gfn_range.start = max(range->start, slot->base_gfn);
+			gfn_range.end = min(range->end, slot->base_gfn + slot->npages);
+			if (gfn_range.start >= gfn_range.end)
+				continue;
+
+			if (!found_memslot) {
+				found_memslot = true;
+				KVM_MMU_LOCK(kvm);
+				if (!IS_KVM_NULL_FN(range->on_lock))
+					range->on_lock(kvm);
+			}
+
+			ret |= range->handler(kvm, &gfn_range);
+		}
+	}
+
+	if (range->flush_on_ret && ret)
+		kvm_flush_remote_tlbs(kvm);
+
+	if (found_memslot)
+		KVM_MMU_UNLOCK(kvm);
+}
+
+static bool kvm_pre_set_memory_attributes(struct kvm *kvm,
+					  struct kvm_gfn_range *range)
+{
+	/*
+	 * Unconditionally add the range to the invalidation set, regardless of
+	 * whether or not the arch callback actually needs to zap SPTEs.  E.g.
+	 * if KVM supports RWX attributes in the future and the attributes are
+	 * going from R=>RW, zapping isn't strictly necessary.  Unconditionally
+	 * adding the range allows KVM to require that MMU invalidations add at
+	 * least one range between begin() and end(), e.g. allows KVM to detect
+	 * bugs where the add() is missed.  Relaxing the rule *might* be safe,
+	 * but it's not obvious that allowing new mappings while the attributes
+	 * are in flux is desirable or worth the complexity.
+	 */
+	kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
+
+	return kvm_arch_pre_set_memory_attributes(kvm, range);
+}
+
+/* Set @attributes for the gfn range [@start, @end). */
+static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+				     unsigned long attributes)
+{
+	struct kvm_mmu_notifier_range pre_set_range = {
+		.start = start,
+		.end = end,
+		.handler = kvm_pre_set_memory_attributes,
+		.on_lock = kvm_mmu_invalidate_begin,
+		.flush_on_ret = true,
+		.may_block = true,
+	};
+	struct kvm_mmu_notifier_range post_set_range = {
+		.start = start,
+		.end = end,
+		.arg.attributes = attributes,
+		.handler = kvm_arch_post_set_memory_attributes,
+		.on_lock = kvm_mmu_invalidate_end,
+		.may_block = true,
+	};
+	unsigned long i;
+	void *entry;
+	int r = 0;
+
+	entry = attributes ? xa_mk_value(attributes) : NULL;
+
+	mutex_lock(&kvm->slots_lock);
+
+	/* Nothing to do if the entire range as the desired attributes. */
+	if (kvm_range_has_memory_attributes(kvm, start, end, attributes))
+		goto out_unlock;
+
+	/*
+	 * Reserve memory ahead of time to avoid having to deal with failures
+	 * partway through setting the new attributes.
+	 */
+	for (i = start; i < end; i++) {
+		r = xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
+		if (r)
+			goto out_unlock;
+	}
+
+	kvm_handle_gfn_range(kvm, &pre_set_range);
+
+	for (i = start; i < end; i++) {
+		r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
+				    GFP_KERNEL_ACCOUNT));
+		KVM_BUG_ON(r, kvm);
+	}
+
+	kvm_handle_gfn_range(kvm, &post_set_range);
+
+out_unlock:
+	mutex_unlock(&kvm->slots_lock);
+
+	return r;
+}
+static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
+					   struct kvm_memory_attributes *attrs)
+{
+	gfn_t start, end;
+
+	/* flags is currently not used. */
+	if (attrs->flags)
+		return -EINVAL;
+	if (attrs->attributes & ~kvm_supported_mem_attributes(kvm))
+		return -EINVAL;
+	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
+		return -EINVAL;
+	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
+		return -EINVAL;
+
+	start = attrs->address >> PAGE_SHIFT;
+	end = (attrs->address + attrs->size) >> PAGE_SHIFT;
+
+	/*
+	 * xarray tracks data using "unsigned long", and as a result so does
+	 * KVM.  For simplicity, supports generic attributes only on 64-bit
+	 * architectures.
+	 */
+	BUILD_BUG_ON(sizeof(attrs->attributes) != sizeof(unsigned long));
+
+	return kvm_vm_set_mem_attributes(kvm, start, end, attrs->attributes);
+}
+#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
+
 struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
 {
 	return __gfn_to_memslot(kvm_memslots(kvm), gfn);
@@ -4641,6 +4841,10 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_BINARY_STATS_FD:
 	case KVM_CAP_SYSTEM_EVENT_DATA:
 		return 1;
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	case KVM_CAP_MEMORY_ATTRIBUTES:
+		return kvm_supported_mem_attributes(kvm);
+#endif
 	default:
 		break;
 	}
@@ -5034,6 +5238,18 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	case KVM_SET_MEMORY_ATTRIBUTES: {
+		struct kvm_memory_attributes attrs;
+
+		r = -EFAULT;
+		if (copy_from_user(&attrs, argp, sizeof(attrs)))
+			goto out;
+
+		r = kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);
+		break;
+	}
+#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
 	case KVM_CREATE_DEVICE: {
 		struct kvm_create_device cd;
 
-- 
2.39.1



