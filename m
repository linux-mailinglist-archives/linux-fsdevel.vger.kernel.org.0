Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1AD44D802
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhKKOS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:18:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:19227 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233299AbhKKOS5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:18:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="213642358"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="213642358"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:16:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="492555907"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 06:15:54 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: [RFC PATCH 07/13] linux-headers: Update
Date:   Thu, 11 Nov 2021 22:13:46 +0800
Message-Id: <20211111141352.26311-8-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 linux-headers/asm-x86/kvm.h |  5 +++++
 linux-headers/linux/kvm.h   | 29 +++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index a6c327f8ad..f9aadf0ebb 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -53,6 +53,10 @@
 /* Architectural interrupt line count. */
 #define KVM_NR_INTERRUPTS 256
 
+#define KVM_DEFAULT_ADDRESS_SPACE	0
+#define KVM_SMM_ADDRESS_SPACE		1
+#define KVM_PRIVATE_ADDRESS_SPACE	2
+
 struct kvm_memory_alias {
 	__u32 slot;  /* this has a different namespace than memory slots */
 	__u32 flags;
@@ -295,6 +299,7 @@ struct kvm_debug_exit_arch {
 #define KVM_GUESTDBG_USE_HW_BP		0x00020000
 #define KVM_GUESTDBG_INJECT_DB		0x00040000
 #define KVM_GUESTDBG_INJECT_BP		0x00080000
+#define KVM_GUESTDBG_BLOCKIRQ		0x00100000
 
 /* for KVM_SET_GUEST_DEBUG */
 struct kvm_guest_debug_arch {
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index bcaf66cc4d..0a43202c04 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -101,6 +101,9 @@ struct kvm_userspace_memory_region {
 	__u64 guest_phys_addr;
 	__u64 memory_size; /* bytes */
 	__u64 userspace_addr; /* start of the userspace allocated memory */
+#ifdef KVM_PRIVATE_ADDRESS_SPACE
+	__u32 fd; /* valid if memslot is guest private memory */
+#endif
 };
 
 /*
@@ -231,6 +234,18 @@ struct kvm_xen_exit {
 	} u;
 };
 
+struct kvm_memory_exit {
+#define KVM_EXIT_MEM_MAP_SHARE          1
+#define KVM_EXIT_MEM_MAP_PRIVATE        2
+	__u32 type;
+	union {
+		struct {
+			__u64 gpa;
+			__u64 size;
+		} map;
+	} u;
+};
+
 #define KVM_S390_GET_SKEYS_NONE   1
 #define KVM_S390_SKEYS_MAX        1048576
 
@@ -269,6 +284,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_AP_RESET_HOLD    32
 #define KVM_EXIT_X86_BUS_LOCK     33
 #define KVM_EXIT_XEN              34
+#define KVM_EXIT_MEMORY_ERROR     35
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -469,6 +485,8 @@ struct kvm_run {
 		} msr;
 		/* KVM_EXIT_XEN */
 		struct kvm_xen_exit xen;
+		/* KVM_EXIT_MEMORY_ERROR */
+		struct kvm_memory_exit mem;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -1965,7 +1983,9 @@ struct kvm_stats_header {
 #define KVM_STATS_TYPE_CUMULATIVE	(0x0 << KVM_STATS_TYPE_SHIFT)
 #define KVM_STATS_TYPE_INSTANT		(0x1 << KVM_STATS_TYPE_SHIFT)
 #define KVM_STATS_TYPE_PEAK		(0x2 << KVM_STATS_TYPE_SHIFT)
-#define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_PEAK
+#define KVM_STATS_TYPE_LINEAR_HIST	(0x3 << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_LOG_HIST		(0x4 << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_LOG_HIST
 
 #define KVM_STATS_UNIT_SHIFT		4
 #define KVM_STATS_UNIT_MASK		(0xF << KVM_STATS_UNIT_SHIFT)
@@ -1988,8 +2008,9 @@ struct kvm_stats_header {
  * @size: The number of data items for this stats.
  *        Every data item is of type __u64.
  * @offset: The offset of the stats to the start of stat structure in
- *          struture kvm or kvm_vcpu.
- * @unused: Unused field for future usage. Always 0 for now.
+ *          structure kvm or kvm_vcpu.
+ * @bucket_size: A parameter value used for histogram stats. It is only used
+ *		for linear histogram stats, specifying the size of the bucket;
  * @name: The name string for the stats. Its size is indicated by the
  *        &kvm_stats_header->name_size.
  */
@@ -1998,7 +2019,7 @@ struct kvm_stats_desc {
 	__s16 exponent;
 	__u16 size;
 	__u32 offset;
-	__u32 unused;
+	__u32 bucket_size;
 	char name[];
 };
 
-- 
2.17.1

