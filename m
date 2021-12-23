Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E7247E359
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 13:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348309AbhLWMb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 07:31:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:12270 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348323AbhLWMb1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640262687; x=1671798687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IqTe1DsTia+Q4UUoPBjuJEeqacZHw7Gxwc749Q8nzvA=;
  b=Mg6M0goPwbRTU/LzoJk6M5/9TgR7JbZcv75ZC345u2YWVtTnNNoqdM7F
   2jkqsLpTCNQr/X6X1q0gAkzuYuktyAwtnbvdSVRnu96J81VymewCooVUr
   DOCvOthTQvDlD+b9jnNyNM2yIlzdLsoeK2jfREj4KeJV4TerxKlkQ6kJE
   BG3Qs9QOsqkwmzWUsaLcgv2z/oqpws2sufiaNJfiRixA3vy1pByr6JW+e
   HlwhZoHy+0HBGc4mfQ9QWQTx1++OvkuYlEXMdsHtBO7fJISihGhCJlBNA
   hKwAj7oP1gt3xfZ8s+ljZjTXJqsoAWOkIo81TMPU+ew3NRydBtpXSdFz1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="228114613"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="228114613"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:31:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="522078644"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2021 04:31:19 -0800
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
Subject: [PATCH v3 kvm/queue 04/16] KVM: Extend the memslot to support fd-based private memory
Date:   Thu, 23 Dec 2021 20:29:59 +0800
Message-Id: <20211223123011.41044-5-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
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
 include/linux/kvm_host.h | 10 ++++++++++
 include/uapi/linux/kvm.h | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f8ed799e8674..2cd35560c44b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -460,8 +460,18 @@ struct kvm_memory_slot {
 	u32 flags;
 	short id;
 	u16 as_id;
+	u32 fd;
+	struct file *file;
+	u64 ofs;
 };
 
+static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
+{
+	if (slot && (slot->flags & KVM_MEM_PRIVATE))
+		return true;
+	return false;
+}
+
 static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
 {
 	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 1daa45268de2..41434322fa23 100644
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

