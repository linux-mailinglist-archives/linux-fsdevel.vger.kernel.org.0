Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E6D4D4915
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbiCJOLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242754AbiCJOLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:11:30 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E330E14F98A;
        Thu, 10 Mar 2022 06:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921429; x=1678457429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=R9N/T0uA9Epd8O0DLQkw3YWNAAFsUHVjLA2F5YkEzAE=;
  b=mxMgDjuFIY4HLmTks+qcX2ZI77cQWZO2uUIekh3dDwzO4YZ6q9Lmw5sv
   Ip81L6ugwoNKMLW4HEEfrEfEXpHT5+s3OfyocpN0tL9K9GyMu3tkN3dWe
   hpFK6PT9KHHH8hdZpzIxnqZpxIYuDlBagnzU5n4hm8Bv3W4yvIY8r3Idc
   sJ6uaZO7FTac3980jCB6gFHmZhLIdttWlQdJJUFgNj5Kjp7Sx6ijVeW9A
   T/bm1XDme6cZg3hjEZzyEuvkonbhOtLed34R2mMx8Xog05aSvoao1Dljg
   Jrc6kcQ92buiYxJvhx7HrC8i/71WYHN+qjuNwFHJ89TUUudVB5y5uSG7k
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235206016"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="235206016"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:10:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554654963"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:10:08 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org
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
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v5 05/13] KVM: Extend the memslot to support fd-based private memory
Date:   Thu, 10 Mar 2022 22:09:03 +0800
Message-Id: <20220310140911.50924-6-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extend the memslot definition to provide fd-based private memory support
by adding two new fields (private_fd/private_offset). The memslot then
can maintain memory for both shared pages and private pages in a single
memslot. Shared pages are provided by existing userspace_addr(hva) field
and private pages are provided through the new private_fd/private_offset
fields.

Since there is no 'hva' concept anymore for private memory so we cannot
rely on get_user_pages() to get a pfn, instead we use the newly added
memfile_notifier to complete the same job.

This new extension is indicated by a new flag KVM_MEM_PRIVATE.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 Documentation/virt/kvm/api.rst | 37 +++++++++++++++++++++++++++-------
 include/linux/kvm_host.h       |  7 +++++++
 include/uapi/linux/kvm.h       |  8 ++++++++
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 3acbf4d263a5..f76ac598606c 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1307,7 +1307,7 @@ yet and must be cleared on entry.
 :Capability: KVM_CAP_USER_MEMORY
 :Architectures: all
 :Type: vm ioctl
-:Parameters: struct kvm_userspace_memory_region (in)
+:Parameters: struct kvm_userspace_memory_region(_ext) (in)
 :Returns: 0 on success, -1 on error
 
 ::
@@ -1320,9 +1320,17 @@ yet and must be cleared on entry.
 	__u64 userspace_addr; /* start of the userspace allocated memory */
   };
 
+  struct kvm_userspace_memory_region_ext {
+	struct kvm_userspace_memory_region region;
+	__u64 private_offset;
+	__u32 private_fd;
+	__u32 padding[5];
+};
+
   /* for kvm_memory_region::flags */
   #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
   #define KVM_MEM_READONLY	(1UL << 1)
+  #define KVM_MEM_PRIVATE		(1UL << 2)
 
 This ioctl allows the user to create, modify or delete a guest physical
 memory slot.  Bits 0-15 of "slot" specify the slot id and this value
@@ -1353,12 +1361,27 @@ It is recommended that the lower 21 bits of guest_phys_addr and userspace_addr
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
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9536ffa0473b..3be8116079d4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -563,8 +563,15 @@ struct kvm_memory_slot {
 	u32 flags;
 	short id;
 	u16 as_id;
+	struct file *private_file;
+	loff_t private_offset;
 };
 
+static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
+{
+	return slot && (slot->flags & KVM_MEM_PRIVATE);
+}
+
 static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
 {
 	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 91a6fe4e02c0..a523d834efc8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -103,6 +103,13 @@ struct kvm_userspace_memory_region {
 	__u64 userspace_addr; /* start of the userspace allocated memory */
 };
 
+struct kvm_userspace_memory_region_ext {
+	struct kvm_userspace_memory_region region;
+	__u64 private_offset;
+	__u32 private_fd;
+	__u32 padding[5];
+};
+
 /*
  * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
  * other bits are reserved for kvm internal use which are defined in
@@ -110,6 +117,7 @@ struct kvm_userspace_memory_region {
  */
 #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
 #define KVM_MEM_READONLY	(1UL << 1)
+#define KVM_MEM_PRIVATE		(1UL << 2)
 
 /* for KVM_IRQ_LINE */
 struct kvm_irq_level {
-- 
2.17.1

