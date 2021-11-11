Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11344D821
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhKKOUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:20:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:9423 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234019AbhKKOUD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:20:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="212952293"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="212952293"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:17:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="492556372"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 06:17:01 -0800
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
Subject: [RFC PATCH 13/13] machine: Add 'private-memory-backend' property
Date:   Thu, 11 Nov 2021 22:13:52 +0800
Message-Id: <20211111141352.26311-14-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 hw/core/machine.c   | 38 ++++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c        | 22 ++++++++++++++++------
 include/hw/boards.h |  2 ++
 softmmu/vl.c        | 16 ++++++++++------
 4 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 067f42b528..d092bf400b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -589,6 +589,22 @@ static void machine_set_memdev(Object *obj, const char *value, Error **errp)
     ms->ram_memdev_id = g_strdup(value);
 }
 
+static char *machine_get_private_memdev(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return g_strdup(ms->private_ram_memdev_id);
+}
+
+static void machine_set_private_memdev(Object *obj, const char *value,
+                                       Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    g_free(ms->private_ram_memdev_id);
+    ms->private_ram_memdev_id = g_strdup(value);
+}
+
 static void machine_init_notify(Notifier *notifier, void *data)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
@@ -962,6 +978,13 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "memory-backend",
                                           "Set RAM backend"
                                           "Valid value is ID of hostmem based backend");
+
+    object_class_property_add_str(oc, "private-memory-backend",
+                                  machine_get_private_memdev,
+                                  machine_set_private_memdev);
+    object_class_property_set_description(oc, "private-memory-backend",
+                                          "Set guest private RAM backend"
+                                          "Valid value is ID of hostmem based backend");
 }
 
 static void machine_class_base_init(ObjectClass *oc, void *data)
@@ -1208,6 +1231,21 @@ void machine_run_board_init(MachineState *machine)
         machine->ram = machine_consume_memdev(machine, MEMORY_BACKEND(o));
     }
 
+    if (machine->private_ram_memdev_id) {
+        Object *o;
+        HostMemoryBackend *backend;
+        o = object_resolve_path_type(machine->private_ram_memdev_id,
+                                     TYPE_MEMORY_BACKEND, NULL);
+        backend = MEMORY_BACKEND(o);
+        if (backend->guest_private) {
+            machine->private_ram = machine_consume_memdev(machine, backend);
+        } else {
+            error_report("memorybaend %s is not guest private memory.",
+                         object_get_canonical_path_component(OBJECT(backend)));
+            exit(EXIT_FAILURE);
+        }
+    }
+
     if (machine->numa_state) {
         numa_complete_configuration(machine);
         if (machine->numa_state->num_nodes) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1276bfeee4..e6209428c1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -865,30 +865,40 @@ void pc_memory_init(PCMachineState *pcms,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(pcms);
+    MemoryRegion *ram, *root_region;
 
     assert(machine->ram_size == x86ms->below_4g_mem_size +
                                 x86ms->above_4g_mem_size);
 
     linux_boot = (machine->kernel_filename != NULL);
 
+    *ram_memory = machine->ram;
+
+    /* Map private memory if set. Shared memory will be mapped per request. */
+    if (machine->private_ram) {
+        ram = machine->private_ram;
+        root_region = get_system_private_memory();
+    } else {
+        ram = machine->ram;
+        root_region = system_memory;
+    }
+
     /*
      * Split single memory region and use aliases to address portions of it,
      * done for backwards compatibility with older qemus.
      */
-    *ram_memory = machine->ram;
     ram_below_4g = g_malloc(sizeof(*ram_below_4g));
-    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine->ram,
+    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
                              0, x86ms->below_4g_mem_size);
-    memory_region_add_subregion(system_memory, 0, ram_below_4g);
+    memory_region_add_subregion(root_region, 0, ram_below_4g);
     e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
     if (x86ms->above_4g_mem_size > 0) {
         ram_above_4g = g_malloc(sizeof(*ram_above_4g));
         memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g",
-                                 machine->ram,
+                                 ram,
                                  x86ms->below_4g_mem_size,
                                  x86ms->above_4g_mem_size);
-        memory_region_add_subregion(system_memory, 0x100000000ULL,
-                                    ram_above_4g);
+        memory_region_add_subregion(root_region, 0x100000000ULL, ram_above_4g);
         e820_add_entry(0x100000000ULL, x86ms->above_4g_mem_size, E820_RAM);
     }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 463a5514f9..dd6a3a3e03 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -313,11 +313,13 @@ struct MachineState {
     bool enable_graphics;
     ConfidentialGuestSupport *cgs;
     char *ram_memdev_id;
+    char *private_ram_memdev_id;
     /*
      * convenience alias to ram_memdev_id backend memory region
      * or to numa container memory region
      */
     MemoryRegion *ram;
+    MemoryRegion *private_ram;
     DeviceMemoryState *device_memory;
 
     ram_addr_t ram_size;
diff --git a/softmmu/vl.c b/softmmu/vl.c
index ea05bb39c5..9665ccdb16 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1985,17 +1985,15 @@ static bool have_custom_ram_size(void)
     return !!qemu_opt_get_size(opts, "size", 0);
 }
 
-static void qemu_resolve_machine_memdev(void)
+static void check_memdev(char *id)
 {
-    if (current_machine->ram_memdev_id) {
+    if (id) {
         Object *backend;
         ram_addr_t backend_size;
 
-        backend = object_resolve_path_type(current_machine->ram_memdev_id,
-                                           TYPE_MEMORY_BACKEND, NULL);
+        backend = object_resolve_path_type(id, TYPE_MEMORY_BACKEND, NULL);
         if (!backend) {
-            error_report("Memory backend '%s' not found",
-                         current_machine->ram_memdev_id);
+            error_report("Memory backend '%s' not found", id);
             exit(EXIT_FAILURE);
         }
         backend_size = object_property_get_uint(backend, "size",  &error_abort);
@@ -2011,6 +2009,12 @@ static void qemu_resolve_machine_memdev(void)
         }
         ram_size = backend_size;
     }
+}
+
+static void qemu_resolve_machine_memdev(void)
+{
+    check_memdev(current_machine->ram_memdev_id);
+    check_memdev(current_machine->private_ram_memdev_id);
 
     if (!xen_enabled()) {
         /* On 32-bit hosts, QEMU is limited by virtual address space */
-- 
2.17.1

