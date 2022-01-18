Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD39492713
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242155AbiARNWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:22:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:1542 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243067AbiARNWf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642512155; x=1674048155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7+c1sXkb+YZ1mlaZZMzVLTAk9/05+2xQQ6wigpDTqW0=;
  b=P7Fz1SZWXfY7pJCjSoYMJzwT7zc/N5iFarJDQnJMx4E52hnyV9OCJDh+
   jXtW9643sl+ckOXcH4EObUEcRFnjLmhX8oiivYMycSBIFO72DUY3d5jWw
   sIFiIfyofPtGd3/xecpWwf70SN03VRmUFdCbqd/OFlA90wfmOwkVN+5cB
   xj1I7GkZez/Filt2NCMzJ2Zkl1Yo5O31O8c7mbXqLoZLLqwGM63gIhDub
   HOgVCTf2b7auiWM0JHA42LTW0OobQttrxFAzQP2ewvTagakWyEptyFZ1k
   v/AlUgLkunqk1RXbyBmr84NpEMriWrlaAgYHgopqTudTqobUwXpCMM4kk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="224791034"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="224791034"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 05:22:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="531791785"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2022 05:22:27 -0800
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
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v4 05/12] KVM: Extend the memslot to support fd-based private memory
Date:   Tue, 18 Jan 2022 21:21:14 +0800
Message-Id: <20220118132121.31388-6-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
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
 include/linux/kvm_host.h | 7 +++++++
 include/uapi/linux/kvm.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f079820f52b5..5011ac35bc50 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -458,8 +458,15 @@ struct kvm_memory_slot {
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
index fbfd70d965c6..5d6dceb1b93e 100644
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

