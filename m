Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B3F44D809
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhKKOTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:19:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:48782 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233809AbhKKOTK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:19:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="231640028"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="231640028"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:16:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="492555963"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 06:16:08 -0800
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
Subject: [RFC PATCH 08/13] hostmem: Add guest private memory to memory backend
Date:   Thu, 11 Nov 2021 22:13:47 +0800
Message-Id: <20211111141352.26311-9-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently only memfd is supported.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 backends/hostmem-memfd.c | 12 +++++++++---
 backends/hostmem.c       | 24 ++++++++++++++++++++++++
 include/exec/memory.h    |  3 +++
 include/exec/ram_addr.h  |  3 ++-
 include/qemu/memfd.h     |  5 +++++
 include/sysemu/hostmem.h |  1 +
 softmmu/physmem.c        | 33 +++++++++++++++++++--------------
 util/memfd.c             | 32 +++++++++++++++++++++++++-------
 8 files changed, 88 insertions(+), 25 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 3fc85c3db8..ef057586a0 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -36,6 +36,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(backend);
     uint32_t ram_flags;
+    unsigned int seals;
     char *name;
     int fd;
 
@@ -44,10 +45,14 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return;
     }
 
+    seals = backend->guest_private ? F_SEAL_GUEST : 0;
+
+    if (m->seal) {
+        seals |= F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL;
+    }
+
     fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
-                           m->hugetlb, m->hugetlbsize, m->seal ?
-                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
-                           errp);
+                           m->hugetlb, m->hugetlbsize, seals, errp);
     if (fd == -1) {
         return;
     }
@@ -55,6 +60,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
+    ram_flags |= backend->guest_private ? RAM_GUEST_PRIVATE : 0;
     memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                    backend->size, ram_flags, fd, 0, errp);
     g_free(name);
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 4c05862ed5..a90d1be0a0 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -472,6 +472,23 @@ host_memory_backend_set_use_canonical_path(Object *obj, bool value,
     backend->use_canonical_path = value;
 }
 
+static bool
+host_memory_backend_get_guest_private(Object *obj, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+
+    return backend->guest_private;
+
+}
+
+static void
+host_memory_backend_set_guest_private(Object *obj, bool value, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+
+    backend->guest_private = value;
+}
+
 static void
 host_memory_backend_class_init(ObjectClass *oc, void *data)
 {
@@ -542,6 +559,13 @@ host_memory_backend_class_init(ObjectClass *oc, void *data)
     object_class_property_add_bool(oc, "x-use-canonical-path-for-ramblock-id",
         host_memory_backend_get_use_canonical_path,
         host_memory_backend_set_use_canonical_path);
+
+    object_class_property_add_bool(oc, "guest-private",
+                                   host_memory_backend_get_guest_private,
+                                   host_memory_backend_set_guest_private);
+    object_class_property_set_description(oc, "guest-private",
+                                          "Guest private memory");
+
 }
 
 static const TypeInfo host_memory_backend_info = {
diff --git a/include/exec/memory.h b/include/exec/memory.h
index c3d417d317..ae9d3bc574 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -190,6 +190,9 @@ typedef struct IOMMUTLBEvent {
  */
 #define RAM_NORESERVE (1 << 7)
 
+/* RAM is guest private memory that can not be mmap-ed. */
+#define RAM_GUEST_PRIVATE (1 << 8)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 551876bed0..32768291de 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -74,7 +74,8 @@ static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
 
 static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
 {
-    return (b && b->host && offset < b->used_length) ? true : false;
+    return (b && (b->flags & RAM_GUEST_PRIVATE || b->host)
+		    && offset < b->used_length) ? true : false;
 }
 
 static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index 975b6bdb77..f021a0730a 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -14,6 +14,11 @@
 #define F_SEAL_SHRINK   0x0002  /* prevent file from shrinking */
 #define F_SEAL_GROW     0x0004  /* prevent file from growing */
 #define F_SEAL_WRITE    0x0008  /* prevent writes */
+
+#endif
+
+#ifndef F_SEAL_GUEST
+#define F_SEAL_GUEST    0x0020  /* guest private memory */
 #endif
 
 #ifndef MFD_CLOEXEC
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 9ff5c16963..ddf742a69b 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -65,6 +65,7 @@ struct HostMemoryBackend {
     uint64_t size;
     bool merge, dump, use_canonical_path;
     bool prealloc, is_mapped, share, reserve;
+    bool guest_private;
     uint32_t prealloc_threads;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
     HostMemPolicy policy;
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 23e77cb771..f4d6eeaa17 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1591,15 +1591,19 @@ static void *file_ram_alloc(RAMBlock *block,
         perror("ftruncate");
     }
 
-    qemu_map_flags = readonly ? QEMU_MAP_READONLY : 0;
-    qemu_map_flags |= (block->flags & RAM_SHARED) ? QEMU_MAP_SHARED : 0;
-    qemu_map_flags |= (block->flags & RAM_PMEM) ? QEMU_MAP_SYNC : 0;
-    qemu_map_flags |= (block->flags & RAM_NORESERVE) ? QEMU_MAP_NORESERVE : 0;
-    area = qemu_ram_mmap(fd, memory, block->mr->align, qemu_map_flags, offset);
-    if (area == MAP_FAILED) {
-        error_setg_errno(errp, errno,
-                         "unable to map backing store for guest RAM");
-        return NULL;
+    if (block->flags & RAM_GUEST_PRIVATE) {
+        area = (void*)offset;
+    } else {
+        qemu_map_flags = readonly ? QEMU_MAP_READONLY : 0;
+        qemu_map_flags |= (block->flags & RAM_SHARED) ? QEMU_MAP_SHARED : 0;
+        qemu_map_flags |= (block->flags & RAM_PMEM) ? QEMU_MAP_SYNC : 0;
+        qemu_map_flags |= (block->flags & RAM_NORESERVE) ? QEMU_MAP_NORESERVE : 0;
+        area = qemu_ram_mmap(fd, memory, block->mr->align, qemu_map_flags, offset);
+        if (area == MAP_FAILED) {
+            error_setg_errno(errp, errno,
+                             "unable to map backing store for guest RAM");
+            return NULL;
+        }
     }
 
     block->fd = fd;
@@ -1971,7 +1975,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     qemu_mutex_lock_ramlist();
     new_block->offset = find_ram_offset(new_block->max_length);
 
-    if (!new_block->host) {
+    if (!new_block->host && !(new_block->flags & RAM_GUEST_PRIVATE)) {
         if (xen_enabled()) {
             xen_ram_alloc(new_block->offset, new_block->max_length,
                           new_block->mr, &err);
@@ -2028,7 +2032,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                                         new_block->used_length,
                                         DIRTY_CLIENTS_ALL);
 
-    if (new_block->host) {
+    if (new_block->host && !(new_block->flags & RAM_GUEST_PRIVATE)) {
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
         /*
@@ -2055,7 +2059,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     int64_t file_size, file_align;
 
     /* Just support these ram flags by now. */
-    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE)) == 0);
+    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
+                          RAM_GUEST_PRIVATE)) == 0);
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
@@ -2092,7 +2097,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->flags = ram_flags;
     new_block->host = file_ram_alloc(new_block, size, fd, readonly,
                                      !file_size, offset, errp);
-    if (!new_block->host) {
+    if (!new_block->host && !(ram_flags & RAM_GUEST_PRIVATE)) {
         g_free(new_block);
         return NULL;
     }
@@ -2392,7 +2397,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
 
     RAMBLOCK_FOREACH(block) {
         /* This case append when the block is not mapped. */
-        if (block->host == NULL) {
+        if (block->host == NULL && !(block->flags & RAM_GUEST_PRIVATE)) {
             continue;
         }
         if (host - block->host < block->max_length) {
diff --git a/util/memfd.c b/util/memfd.c
index 4a3c07e0be..3b4b88d81e 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -76,14 +76,32 @@ int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
         goto err;
     }
 
-    if (ftruncate(mfd, size) == -1) {
-        error_setg_errno(errp, errno, "failed to resize memfd to %zu", size);
-        goto err;
-    }
 
-    if (seals && fcntl(mfd, F_ADD_SEALS, seals) == -1) {
-        error_setg_errno(errp, errno, "failed to add seals 0x%x", seals);
-        goto err;
+    /*
+     * The call sequence of F_ADD_SEALS and ftruncate matters here.
+     * For SEAL_GUEST, it requires the size to be 0 at the time of setting seal
+     * For SEAL_GROW/SHRINK, ftruncate should be called before setting seal.
+     */
+    if (seals & F_SEAL_GUEST) {
+        if (seals && fcntl(mfd, F_ADD_SEALS, seals) == -1) {
+            error_setg_errno(errp, errno, "failed to add seals 0x%x", seals);
+            goto err;
+        }
+
+        if (ftruncate(mfd, size) == -1) {
+            error_setg_errno(errp, errno, "failed to resize memfd to %zu", size);
+            goto err;
+        }
+    } else {
+        if (ftruncate(mfd, size) == -1) {
+            error_setg_errno(errp, errno, "failed to resize memfd to %zu", size);
+            goto err;
+        }
+
+        if (seals && fcntl(mfd, F_ADD_SEALS, seals) == -1) {
+            error_setg_errno(errp, errno, "failed to add seals 0x%x", seals);
+            goto err;
+        }
     }
 
     return mfd;
-- 
2.17.1

