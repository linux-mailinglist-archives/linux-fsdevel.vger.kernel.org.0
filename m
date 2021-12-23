Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181DF47E37A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 13:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348453AbhLWMcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 07:32:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:20726 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243706AbhLWMck (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640262760; x=1671798760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BEfM/tVOpaAZqZG+iExZFe2tWlUrZuoAMwYVM4OH/aE=;
  b=P6RAsWxWRgTlJZDqbR/hQQb+kVP+N3mnriYc8XCtpjSwre2+/ykhG1AR
   HXUM3fWhrCSjZQvTmhaZg57m4WYOUHGk7LlWcIQNkPs8dt6UGtQg07qT5
   4k0xhv0Z47jo26v+zrz+oHi/Wpk6Lz00VW3vj9m/ZMnxktsJP5qGth/pp
   20FexrlsE91wjX4eqM1Z10mG8ZHKBKztAWDXk9gz7NhaawUmXzc12lz1w
   uWg8EZQ3xgjdG44HnPfs6uJqhSL8VBvFJpH8F+GV+jGOtT8hKB5y+SdFy
   IQje7VIQa2iJzmX1c+KViPsEPemou6BCR9BhcP9J6cEumj7zY/GeHrN48
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="265026980"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="265026980"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:32:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="522079039"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2021 04:32:31 -0800
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
Subject: [PATCH v3 kvm/queue 13/16] KVM: Add KVM_EXIT_MEMORY_ERROR exit
Date:   Thu, 23 Dec 2021 20:30:08 +0800
Message-Id: <20211223123011.41044-14-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This new exit allows user space to handle memory-related errors.
Currently it supports two types (KVM_EXIT_MEM_MAP_SHARED/PRIVATE) of
errors which are used for shared memory <-> private memory conversion
in memory encryption usage.

After private memory is enabled, there are two places in KVM that can
exit to userspace to trigger private <-> shared conversion:
  - explicit conversion: happens when guest explicitly calls into KVM to
    map a range (as private or shared), KVM then exits to userspace to
    do the map/unmap operations.
  - implicit conversion: happens in KVM page fault handler.
    * if the fault is due to a private memory access then causes a
      userspace exit for a shared->private conversion request when the
      page has not been allocated in the private memory backend.
    * If the fault is due to a shared memory access then causes a
      userspace exit for a private->shared conversion request when the
      page has already been allocated in the private memory backend.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/uapi/linux/kvm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 41434322fa23..d68db3b2eeec 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -243,6 +243,18 @@ struct kvm_xen_exit {
 	} u;
 };
 
+struct kvm_memory_exit {
+#define KVM_EXIT_MEM_MAP_SHARED         1
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
 
@@ -282,6 +294,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_X86_BUS_LOCK     33
 #define KVM_EXIT_XEN              34
 #define KVM_EXIT_RISCV_SBI        35
+#define KVM_EXIT_MEMORY_ERROR     36
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -499,6 +512,8 @@ struct kvm_run {
 			unsigned long args[6];
 			unsigned long ret[2];
 		} riscv_sbi;
+		/* KVM_EXIT_MEMORY_ERROR */
+		struct kvm_memory_exit mem;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
-- 
2.17.1

