Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E6556815B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 10:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiGFIZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 04:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiGFIYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:24:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614581409F;
        Wed,  6 Jul 2022 01:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657095893; x=1688631893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HzvDsZFYJFjfwBhl27KbOiRZ4k+htychclP9Iyjwp74=;
  b=ZZ36cov+7fGTA2ia0KwyVTTr91YEKZs0khS8rBZ/6WekADN6vHL/bw/y
   9XPgw8V+135P63XiiYaHYrApq6Bbps3LEYF/ROr0HMK21aa6ZD0nf30Lf
   vryC5lmoO4FJ3MI3Trez7jPHAeq/y2KZPt7PQJfAoYEdfFfC8u5VIIPLv
   k25YASpUaqzZhCsjh3FpHYR5r4w8feYXYUPNehgBBw1AynstUChhzPdvf
   AhqBvz3zcifYclbkTlrD4Fj/HYgaCI4r788bjMyIPltGv8dSAWIEVTPdD
   R2U4efFrQyVzzpwDzCitlWAJJOphBG07SSq7Ab0D7okjhZBCduCbVevgQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="347665821"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="347665821"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 01:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="567967955"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 01:24:41 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
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
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 06/14] KVM: Rename KVM_PRIVATE_MEM_SLOTS to KVM_INTERNAL_MEM_SLOTS
Date:   Wed,  6 Jul 2022 16:20:08 +0800
Message-Id: <20220706082016.2603916-7-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KVM_INTERNAL_MEM_SLOTS better reflects the fact those slots are not
exposed to userspace and avoids confusion to real private slots that
is going to be added.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/mips/include/asm/kvm_host.h | 2 +-
 arch/x86/include/asm/kvm_host.h  | 2 +-
 include/linux/kvm_host.h         | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

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
index de5a149d0971..dae190e19fce 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -53,7 +53,7 @@
 #define KVM_MAX_VCPU_IDS (KVM_MAX_VCPUS * KVM_VCPU_ID_RATIO)
 
 /* memory slots that are not exposed to userspace */
-#define KVM_PRIVATE_MEM_SLOTS 3
+#define KVM_INTERNAL_MEM_SLOTS 3
 
 #define KVM_HALT_POLL_NS_DEFAULT 200000
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3b40f8d68fbb..0bdb6044e316 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -656,12 +656,12 @@ struct kvm_irq_routing_table {
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
-- 
2.25.1

