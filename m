Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F2847C25C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbhLUPMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:12:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:50940 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239049AbhLUPMl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099561; x=1671635561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=6+jEwSaQbRLyJYQpPbesRQbgqxxUkuctrfu8t5OfMl8=;
  b=l67JYQPb8okob34mZdHCbpVh6oE3x96QY1Eoz/ahhlOB3OH0+xa7ngxg
   Gkdl5WPRWuotpocqqeUWm/u66enaIIx5aIU1GjqiSd0RC7Vm7eH5K9hrA
   cqxfmBLojCLj/tRhwQaCCUBwSz3cOUg1kcIucPeaNidpSJKGc+2dzoKTb
   oIw3aSxmDuT4yuU794euZX2t63lkftA/V44rrx069AnM41Dml9hycZbXV
   mf4hhg7YOTEyIf6WzhHSpAw/IfAUNEOX7FMclAloPt91mp4dcZQF7rVbh
   AVwV7DZoaL2oG7za9swVY+HCEkEW2sJ0dx2IWYwm1ZxMxLHUDYeL/5dja
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="264601342"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="264601342"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:12:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688364"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:12:33 -0800
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
Subject: [PATCH v3 04/15] KVM: Extend the memslot to support fd-based private memory
Date:   Tue, 21 Dec 2021 23:11:14 +0800
Message-Id: <20211221151125.19446-5-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extend the memslot definition to provide fd-based private memory support
by adding two new fields(fd/ofs). The memslot then can maintain memory
for both shared and private pages in a single memslot. Shared pages are
provided in the existing way by using userspace_addr(hva) field and
get_user_pages() while private pages are provided through the new
fields(fd/ofs). Since there is no 'hva' concept anymore for private
memory we cannot call get_user_pages() to get a pfn, instead we rely on
the newly introduced MEMFD_OPS callbacks to do the same job.

This new extension is indicated by a new flag KVM_MEM_PRIVATE.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |  9 +++++++++
 include/uapi/linux/kvm.h | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 865a677baf52..96e46b288ecd 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -433,8 +433,17 @@ struct kvm_memory_slot {
 	u32 flags;
 	short id;
 	u16 as_id;
+	struct file *file;
+	u64 file_ofs;
 };
 
+static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
+{
+	if (slot && (slot->flags & KVM_MEM_PRIVATE))
+		return true;
+	return false;
+}
+
 static inline bool kvm_slot_dirty_track_enabled(struct kvm_memory_slot *slot)
 {
 	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e3706e574bd2..a2c1fb8c9843 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -103,6 +103,17 @@ struct kvm_userspace_memory_region {
 	__u64 userspace_addr; /* start of the userspace allocated memory */
 };
 
+struct kvm_userspace_memory_region_ext {
+	__u32 slot;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size; /* bytes */
+	__u64 userspace_addr; /* hva */
+	__u64 ofs; /* offset into fd */
+	__u32 fd;
+	__u32 padding[5];
+};
+
 /*
  * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
  * other bits are reserved for kvm internal use which are defined in
@@ -110,6 +121,7 @@ struct kvm_userspace_memory_region {
  */
 #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
 #define KVM_MEM_READONLY	(1UL << 1)
+#define KVM_MEM_PRIVATE		(1UL << 2)
 
 /* for KVM_IRQ_LINE */
 struct kvm_irq_level {
-- 
2.17.1

