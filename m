Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78C544D817
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhKKOTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:19:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:59265 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232823AbhKKOTu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:19:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="293740117"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="293740117"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:17:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="492556270"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 06:16:50 -0800
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
Subject: [RFC PATCH 12/13] kvm: handle private to shared memory conversion
Date:   Thu, 11 Nov 2021 22:13:51 +0800
Message-Id: <20211111141352.26311-13-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 accel/kvm/kvm-all.c    | 49 ++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/kvm.h   |  1 +
 target/arm/kvm.c       |  5 +++++
 target/i386/kvm/kvm.c  | 27 +++++++++++++++++++++++
 target/mips/kvm.c      |  5 +++++
 target/ppc/kvm.c       |  5 +++++
 target/s390x/kvm/kvm.c |  5 +++++
 7 files changed, 97 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d336458e9e..6feda9c89b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1445,6 +1445,38 @@ out:
     kvm_slots_unlock();
 }
 
+static int kvm_map_private_memory(hwaddr start, hwaddr size)
+{
+    return 0;
+}
+
+static int kvm_map_shared_memory(hwaddr start, hwaddr size)
+{
+    MemoryRegionSection section;
+    void *addr;
+    RAMBlock *rb;
+    ram_addr_t offset;
+
+    /* Punch a hole in private memory. */
+    section = memory_region_find(get_system_private_memory(), start, size);
+    if (section.mr) {
+        addr = memory_region_get_ram_ptr(section.mr) +
+               section.offset_within_region;
+        rb = qemu_ram_block_from_host(addr, false, &offset);
+        ram_block_discard_range(rb, offset, size);
+        memory_region_unref(section.mr);
+    }
+
+    /* Create new shared memory. */
+    section = memory_region_find(get_system_memory(), start, size);
+    if (section.mr) {
+        memory_region_unref(section.mr);
+        return -1; /*Already existed. */
+    }
+
+    return kvm_arch_map_shared_memory(start, size);
+}
+
 static void *kvm_dirty_ring_reaper_thread(void *data)
 {
     KVMState *s = data;
@@ -2957,6 +2989,23 @@ int kvm_cpu_exec(CPUState *cpu)
                 break;
             }
             break;
+	case KVM_EXIT_MEMORY_ERROR:
+            switch (run->mem.type) {
+            case KVM_EXIT_MEM_MAP_PRIVATE:
+                ret = kvm_map_private_memory(run->mem.u.map.gpa,
+                                             run->mem.u.map.size);
+                break;
+            case KVM_EXIT_MEM_MAP_SHARE:
+                ret = kvm_map_shared_memory(run->mem.u.map.gpa,
+                                            run->mem.u.map.size);
+                break;
+            default:
+                DPRINTF("kvm_arch_handle_exit\n");
+                ret = kvm_arch_handle_exit(cpu, run);
+                break;
+            }
+            break;
+
         default:
             DPRINTF("kvm_arch_handle_exit\n");
             ret = kvm_arch_handle_exit(cpu, run);
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a1ab1ee12d..5f00aa0ee0 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -547,4 +547,5 @@ bool kvm_cpu_check_are_resettable(void);
 
 bool kvm_arch_cpu_check_are_resettable(void);
 
+int kvm_arch_map_shared_memory(hwaddr start, hwaddr size);
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5d55de1a49..97e51b8b88 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1051,3 +1051,8 @@ bool kvm_arch_cpu_check_are_resettable(void)
 {
     return true;
 }
+
+int kvm_arch_map_shared_memory(hwaddr start, hwaddr size)
+{
+    return 0;
+}
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 500d2e0e68..b3209402bc 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4925,3 +4925,30 @@ bool kvm_arch_cpu_check_are_resettable(void)
 {
     return !sev_es_enabled();
 }
+
+int kvm_arch_map_shared_memory(hwaddr start, hwaddr size)
+{
+    MachineState *pcms = current_machine;
+    X86MachineState *x86ms = X86_MACHINE(pcms);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *region;
+    char name[134];
+    hwaddr offset;
+
+    if (start + size < x86ms->below_4g_mem_size) {
+       sprintf(name, "0x%lx@0x%lx", size, start);
+       region = g_malloc(sizeof(*region));
+       memory_region_init_alias(region, NULL, name, pcms->ram, start, size);
+       memory_region_add_subregion(system_memory, start, region);
+       return 0;
+    } else if (start > 0x100000000ULL){
+       sprintf(name, "0x%lx@0x%lx", size, start);
+       offset = start - 0x100000000ULL + x86ms->below_4g_mem_size;
+       region = g_malloc(sizeof(*region));
+       memory_region_init_alias(region, NULL, name, pcms->ram, offset, size);
+       memory_region_add_subregion(system_memory, start, region);
+       return 0;
+    }
+
+    return -1;
+}
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 086debd9f0..4aed54aa9f 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1295,3 +1295,8 @@ bool kvm_arch_cpu_check_are_resettable(void)
 {
     return true;
 }
+
+int kvm_arch_map_shared_memory(hwaddr start, hwaddr size)
+{
+    return 0;
+}
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index dc93b99189..cc31a7c38d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2959,3 +2959,8 @@ bool kvm_arch_cpu_check_are_resettable(void)
 {
     return true;
 }
+
+int kvm_arch_map_shared_memory(hwaddr start, hwaddr size)
+{
+    return 0;
+}
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 5b1fdb55c4..4a9161ba3a 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2562,3 +2562,8 @@ bool kvm_arch_cpu_check_are_resettable(void)
 {
     return true;
 }
+
+int kvm_arch_map_shared_memory(hwaddr start, hwaddr size)
+{
+    return 0;
+}
-- 
2.17.1

