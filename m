Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41F244D813
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhKKOTb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:19:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:9380 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233893AbhKKOTa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:19:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="212952223"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="212952223"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:16:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="492556158"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 06:16:29 -0800
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
Subject: [RFC PATCH 10/13] softmmu/physmem: Add private memory address space
Date:   Thu, 11 Nov 2021 22:13:49 +0800
Message-Id: <20211111141352.26311-11-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/exec/address-spaces.h |  2 ++
 softmmu/physmem.c             | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/exec/address-spaces.h b/include/exec/address-spaces.h
index db8bfa9a92..b3f45001c0 100644
--- a/include/exec/address-spaces.h
+++ b/include/exec/address-spaces.h
@@ -27,6 +27,7 @@
  * until a proper bus interface is available.
  */
 MemoryRegion *get_system_memory(void);
+MemoryRegion *get_system_private_memory(void);
 
 /* Get the root I/O port region.  This interface should only be used
  * temporarily until a proper bus interface is available.
@@ -34,6 +35,7 @@ MemoryRegion *get_system_memory(void);
 MemoryRegion *get_system_io(void);
 
 extern AddressSpace address_space_memory;
+extern AddressSpace address_space_private_memory;
 extern AddressSpace address_space_io;
 
 #endif
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index f4d6eeaa17..a2d339fd88 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -85,10 +85,13 @@
 RAMList ram_list = { .blocks = QLIST_HEAD_INITIALIZER(ram_list.blocks) };
 
 static MemoryRegion *system_memory;
+static MemoryRegion *system_private_memory;
 static MemoryRegion *system_io;
 
 AddressSpace address_space_io;
 AddressSpace address_space_memory;
+AddressSpace address_space_private_memory;
+
 
 static MemoryRegion io_mem_unassigned;
 
@@ -2669,6 +2672,11 @@ static void memory_map_init(void)
     memory_region_init(system_memory, NULL, "system", UINT64_MAX);
     address_space_init(&address_space_memory, system_memory, "memory");
 
+    system_private_memory = g_malloc(sizeof(*system_private_memory));
+
+    memory_region_init(system_private_memory, NULL, "system-private", UINT64_MAX);
+    address_space_init(&address_space_private_memory, system_private_memory, "private-memory");
+
     system_io = g_malloc(sizeof(*system_io));
     memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io",
                           65536);
@@ -2680,6 +2688,11 @@ MemoryRegion *get_system_memory(void)
     return system_memory;
 }
 
+MemoryRegion *get_system_private_memory(void)
+{
+    return system_private_memory;
+}
+
 MemoryRegion *get_system_io(void)
 {
     return system_io;
-- 
2.17.1

