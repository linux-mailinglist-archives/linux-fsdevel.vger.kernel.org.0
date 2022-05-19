Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6217352D828
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 17:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbiESPm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbiESPlf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 11:41:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6050B1D0E6;
        Thu, 19 May 2022 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652974893; x=1684510893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FuITxsubo/0d+TgGyZwJzSfUuFmVrb3iu+Hq/HA4cm0=;
  b=cBdAGg4vDShEjSuZtt6qcbg3m/JcAIQt3pLwknhFoUeapLQld2fjmQW+
   Xs0AxMn8/PV7Ve2RjrAqG0vY4V6olmA9gPhjISLTxC6cI26NsTvBHXoxW
   MQi/0YH48IeObatJ+wiiHoHPWrwjfhP990h3ll4JwXaE61tq8tDhM2CLt
   sZYnPwPnVPtgFgber6CtPvgr66LR5ageiV2jBXu2YyDsRf0hZPX/ebwL9
   K40RmWPG37vRba0fSCXJhlwwhQJjBtXvdnScOzAf/lRna63HevGS+aE0r
   0cSHXV1VvwO7tOOLCx2iKMcr952dchk9CFCLYDgHSBsyrCi3kV+75U63x
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="269837649"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="269837649"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 08:41:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598635250"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 19 May 2022 08:41:22 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
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
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based private memory
Date:   Thu, 19 May 2022 23:37:09 +0800
Message-Id: <20220519153713.819591-5-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extend the memslot definition to provide guest private memory through a
file descriptor(fd) instead of userspace_addr(hva). Such guest private
memory(fd) may never be mapped into userspace so no userspace_addr(hva)
can be used. Instead add another two new fields
(private_fd/private_offset), plus the existing memory_size to represent
the private memory range. Such memslot can still have the existing
userspace_addr(hva). When use, a single memslot can maintain both
private memory through private fd(private_fd/private_offset) and shared
memory through hva(userspace_addr). A GPA is considered private by KVM
if the memslot has private fd and that corresponding page in the private
fd is populated, otherwise, it's shared.

Since there is no userspace mapping for private fd so we cannot
rely on get_user_pages() to get the pfn in KVM, instead we add a new
memfile_notifier in the memslot and rely on it to get pfn by interacting
its callbacks from memory backing store with the fd/offset.

This new extension is indicated by a new flag KVM_MEM_PRIVATE. At
compile time, a new config HAVE_KVM_PRIVATE_MEM is added and right now
it is selected on X86_64 for Intel TDX usage.

To make KVM easy, internally we use a binary compatible struct
kvm_user_mem_region to handle both the normal and the '_ext' variants.

Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 Documentation/virt/kvm/api.rst   | 38 ++++++++++++++++++++++++++------
 arch/mips/include/asm/kvm_host.h |  2 +-
 arch/x86/include/asm/kvm_host.h  |  2 +-
 arch/x86/kvm/Kconfig             |  2 ++
 arch/x86/kvm/x86.c               |  2 +-
 include/linux/kvm_host.h         | 19 +++++++++++-----
 include/uapi/linux/kvm.h         | 24 ++++++++++++++++++++
 virt/kvm/Kconfig                 |  3 +++
 virt/kvm/kvm_main.c              | 33 +++++++++++++++++++++------
 9 files changed, 103 insertions(+), 22 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 23baf7fce038..b959445b64cc 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1311,7 +1311,7 @@ yet and must be cleared on entry.
 :Capability: KVM_CAP_USER_MEMORY
 :Architectures: all
 :Type: vm ioctl
-:Parameters: struct kvm_userspace_memory_region (in)
+:Parameters: struct kvm_userspace_memory_region(_ext) (in)
 :Returns: 0 on success, -1 on error
 
 ::
@@ -1324,9 +1324,18 @@ yet and must be cleared on entry.
 	__u64 userspace_addr; /* start of the userspace allocated memory */
   };
 
+  struct kvm_userspace_memory_region_ext {
+	struct kvm_userspace_memory_region region;
+	__u64 private_offset;
+	__u32 private_fd;
+	__u32 pad1;
+	__u64 pad2[14];
+};
+
   /* for kvm_memory_region::flags */
   #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
   #define KVM_MEM_READONLY	(1UL << 1)
+  #define KVM_MEM_PRIVATE		(1UL << 2)
 
 This ioctl allows the user to create, modify or delete a guest physical
 memory slot.  Bits 0-15 of "slot" specify the slot id and this value
@@ -1357,12 +1366,27 @@ It is recommended that the lower 21 bits of guest_phys_addr and userspace_addr
 be identical.  This allows large pages in the guest to be backed by large
 pages in the host.
 
-The flags field supports two flags: KVM_MEM_LOG_DIRTY_PAGES and
-KVM_MEM_READONLY.  The former can be set to instruct KVM to keep track of
-writes to memory within the slot.  See KVM_GET_DIRTY_LOG ioctl to know how to
-use it.  The latter can be set, if KVM_CAP_READONLY_MEM capability allows it,
-to make a new slot read-only.  In this case, writes to this memory will be
-posted to userspace as KVM_EXIT_MMIO exits.
+kvm_userspace_memory_region_ext includes all the kvm_userspace_memory_region
+fields. It also includes additional fields for some specific features. See
+below description of flags field for more information. It's recommended to use
+kvm_userspace_memory_region_ext in new userspace code.
+
+The flags field supports below flags:
+
+- KVM_MEM_LOG_DIRTY_PAGES can be set to instruct KVM to keep track of writes to
+  memory within the slot.  See KVM_GET_DIRTY_LOG ioctl to know how to use it.
+
+- KVM_MEM_READONLY can be set, if KVM_CAP_READONLY_MEM capability allows it, to
+  make a new slot read-only.  In this case, writes to this memory will be posted
+  to userspace as KVM_EXIT_MMIO exits.
+
+- KVM_MEM_PRIVATE can be set to indicate a new slot has private memory backed by
+  a file descirptor(fd) and the content of the private memory is invisible to
+  userspace. In this case, userspace should use private_fd/private_offset in
+  kvm_userspace_memory_region_ext to instruct KVM to provide private memory to
+  guest. Userspace should guarantee not to map the same pfn indicated by
+  private_fd/private_offset to different gfns with multiple memslots. Failed to
+  do this may result undefined behavior.
 
 When the KVM_CAP_SYNC_MMU capability is available, changes in the backing of
 the memory region are automatically reflected into the guest.  For example, an
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 717716cc51c5..45a978c805bc 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -85,7 +85,7 @@
 
 #define KVM_MAX_VCPUS		16
 /* memory slots that does not exposed to userspace */
-#define KVM_PRIVATE_MEM_SLOTS	0
+#define KVM_INTERNAL_MEM_SLOTS	0
 
 #define KVM_HALT_POLL_NS_DEFAULT 500000
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c59fea4bdb6e..3f5e81ef77c8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -53,7 +53,7 @@
 #define KVM_MAX_VCPU_IDS (KVM_MAX_VCPUS * KVM_VCPU_ID_RATIO)
 
 /* memory slots that are not exposed to userspace */
-#define KVM_PRIVATE_MEM_SLOTS 3
+#define KVM_INTERNAL_MEM_SLOTS 3
 
 #define KVM_HALT_POLL_NS_DEFAULT 200000
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index e3cbd7706136..1f160801e2a7 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -48,6 +48,8 @@ config KVM
 	select SRCU
 	select INTERVAL_TREE
 	select HAVE_KVM_PM_NOTIFIER if PM
+	select HAVE_KVM_PRIVATE_MEM if X86_64
+	select MEMFILE_NOTIFIER if HAVE_KVM_PRIVATE_MEM
 	help
 	  Support hosting fully virtualized guest machines using hardware
 	  virtualization extensions.  You will need a fairly recent
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8ee8c91fa762..d873ae56b01a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11910,7 +11910,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	}
 
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
-		struct kvm_userspace_memory_region m;
+		struct kvm_user_mem_region m;
 
 		m.slot = id | (i << 16);
 		m.flags = 0;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f94f72bbd2d3..3fd168972ecd 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -44,6 +44,7 @@
 
 #include <asm/kvm_host.h>
 #include <linux/kvm_dirty_ring.h>
+#include <linux/memfile_notifier.h>
 
 #ifndef KVM_MAX_VCPU_IDS
 #define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
@@ -573,8 +574,16 @@ struct kvm_memory_slot {
 	u32 flags;
 	short id;
 	u16 as_id;
+	struct file *private_file;
+	loff_t private_offset;
+	struct memfile_notifier notifier;
 };
 
+static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
+{
+	return slot && (slot->flags & KVM_MEM_PRIVATE);
+}
+
 static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
 {
 	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
@@ -653,12 +662,12 @@ struct kvm_irq_routing_table {
 };
 #endif
 
-#ifndef KVM_PRIVATE_MEM_SLOTS
-#define KVM_PRIVATE_MEM_SLOTS 0
+#ifndef KVM_INTERNAL_MEM_SLOTS
+#define KVM_INTERNAL_MEM_SLOTS 0
 #endif
 
 #define KVM_MEM_SLOTS_NUM SHRT_MAX
-#define KVM_USER_MEM_SLOTS (KVM_MEM_SLOTS_NUM - KVM_PRIVATE_MEM_SLOTS)
+#define KVM_USER_MEM_SLOTS (KVM_MEM_SLOTS_NUM - KVM_INTERNAL_MEM_SLOTS)
 
 #ifndef __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
 static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
@@ -1087,9 +1096,9 @@ enum kvm_mr_change {
 };
 
 int kvm_set_memory_region(struct kvm *kvm,
-			  const struct kvm_userspace_memory_region *mem);
+			  const struct kvm_user_mem_region *mem);
 int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region *mem);
+			    const struct kvm_user_mem_region *mem);
 void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e10d131edd80..28cacd3656d4 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -103,6 +103,29 @@ struct kvm_userspace_memory_region {
 	__u64 userspace_addr; /* start of the userspace allocated memory */
 };
 
+struct kvm_userspace_memory_region_ext {
+	struct kvm_userspace_memory_region region;
+	__u64 private_offset;
+	__u32 private_fd;
+	__u32 pad1;
+	__u64 pad2[14];
+};
+
+#ifdef __KERNEL__
+/* Internal helper, the layout must match above user visible structures */
+struct kvm_user_mem_region {
+	__u32 slot;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size;
+	__u64 userspace_addr;
+	__u64 private_offset;
+	__u32 private_fd;
+	__u32 pad1;
+	__u64 pad2[14];
+};
+#endif
+
 /*
  * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
  * other bits are reserved for kvm internal use which are defined in
@@ -110,6 +133,7 @@ struct kvm_userspace_memory_region {
  */
 #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
 #define KVM_MEM_READONLY	(1UL << 1)
+#define KVM_MEM_PRIVATE		(1UL << 2)
 
 /* for KVM_IRQ_LINE */
 struct kvm_irq_level {
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index a8c5c9f06b3c..ccaff13cc5b8 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -72,3 +72,6 @@ config KVM_XFER_TO_GUEST_WORK
 
 config HAVE_KVM_PM_NOTIFIER
        bool
+
+config HAVE_KVM_PRIVATE_MEM
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e089db822c12..db9d39a2d3a6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1830,7 +1830,7 @@ static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
  * Must be called holding kvm->slots_lock for write.
  */
 int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region *mem)
+			    const struct kvm_user_mem_region *mem)
 {
 	struct kvm_memory_slot *old, *new;
 	struct kvm_memslots *slots;
@@ -1934,7 +1934,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
 
 int kvm_set_memory_region(struct kvm *kvm,
-			  const struct kvm_userspace_memory_region *mem)
+			  const struct kvm_user_mem_region *mem)
 {
 	int r;
 
@@ -1946,7 +1946,7 @@ int kvm_set_memory_region(struct kvm *kvm,
 EXPORT_SYMBOL_GPL(kvm_set_memory_region);
 
 static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
-					  struct kvm_userspace_memory_region *mem)
+					  struct kvm_user_mem_region *mem)
 {
 	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
 		return -EINVAL;
@@ -4500,14 +4500,33 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 	case KVM_SET_USER_MEMORY_REGION: {
-		struct kvm_userspace_memory_region kvm_userspace_mem;
+		struct kvm_user_mem_region mem;
+		unsigned long size;
+		u32 flags;
+
+		memset(&mem, 0, sizeof(mem));
 
 		r = -EFAULT;
-		if (copy_from_user(&kvm_userspace_mem, argp,
-						sizeof(kvm_userspace_mem)))
+
+		if (get_user(flags,
+			(u32 __user *)(argp + offsetof(typeof(mem), flags))))
+			goto out;
+
+		if (flags & KVM_MEM_PRIVATE) {
+			r = -EINVAL;
+			goto out;
+		}
+
+		size = sizeof(struct kvm_userspace_memory_region);
+
+		if (copy_from_user(&mem, argp, size))
+			goto out;
+
+		r = -EINVAL;
+		if ((flags ^ mem.flags) & KVM_MEM_PRIVATE)
 			goto out;
 
-		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
+		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
 		break;
 	}
 	case KVM_GET_DIRTY_LOG: {
-- 
2.25.1

