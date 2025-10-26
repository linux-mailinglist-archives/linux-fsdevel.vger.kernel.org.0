Return-Path: <linux-fsdevel+bounces-65644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72C2C0B30C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 21:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B565C3B978D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 20:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275D2FF145;
	Sun, 26 Oct 2025 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QkMGmBFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C5026A0B9
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510981; cv=none; b=dJ/OvfAcywMK4z5qsCHSxHKA+8lruFwLsVpC5N7mRpVUQsFq+f5WsUTHzvYq0Gl07wzkHicTVQ7Hzcv44ZQofsJPD05YlZquUlPIkVTm5KFJIrd7dB2ND/DqUhBZay32cxHTQxwdO56tZeKGyvoEmFzFxjlwYoQuB5AgpOOq32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510981; c=relaxed/simple;
	bh=1C8UJH921Y8+41G/pTH0n+wxPE7HtTaNdf+uf6D79ho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R3pIyjaz/Mc8fUH16QpVSdJLKuepHjlqYdikvTl4LFWIn4AIyWxVUr3+auCfqyBXa4SSjSjy9kAANHs61G59gyEKnRACMLle0QMQOmL1W2TFSMtt+tLwr9r4iMufxKDIbSaI4aNubkDjWTVMqWj+m2erYMRZj9Hn52OzyFvAaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QkMGmBFX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a27837ead0so2359198b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761510978; x=1762115778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTAdKSDjiBuz/IUkvvi0g1dCHzDg2V9+X/PGIUX5cC4=;
        b=QkMGmBFX9XS3D3HJhaelCYzu8IYLdLx64Zigwzkxbx9bipDs8bcPfXvLN7HOJucS3U
         /eaWIA7nfIzgCAX8YtRNV3JORcuC9su0a19tK2fDV6hU/G0VFTE7E4IHLMM/uYO9mR7z
         mHggCJHSCcnEYatAvtfbUuqBMC/c6eJEIrgpLK14OAzvDQgUw9wg19gAixDzgc2JUKB6
         PJ7UTF+fhUwnVO3TBiNK2V3XuGJ8cGtilgf4Is76Sf/nLQPXXkZMqjGW6Utn4AfwCzrd
         ITevOWBQxeIhMm+0i65a6H4PdbrFBZPBwpxzTG96D9KT2WU+31qNDecvf8dVFFU/4hG/
         CxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510978; x=1762115778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTAdKSDjiBuz/IUkvvi0g1dCHzDg2V9+X/PGIUX5cC4=;
        b=jEyIqoVz8BtNpQ3zzSdOwxsaArtSIgaVXdNSPh1bFHNZWUzsycmrTa95h0DNa3ZSux
         LF6ezBmo2cRW+zyJMurK//EDtv+hLqM+NswuIi7astHYpE6svbKoq57eSG5qaILu4RHA
         A4rj459qHUxL8QB+++DFGcosIzkykBozdnyVPUBwp/YEul2lbPUE0X/WLEG+9hz1714L
         htetrR/Ir99pBryzWQevfIFsAY2k8fAlIeMZFKzsIn2xU/0RGrBea7Tubi+T09jNJZZ8
         i4X9pRJK40q60M7D46OX+lc0hN7tDwWDhf3rfedxjGAgwKRjVstmeyTHqdkSkgYGaUkk
         6FPw==
X-Forwarded-Encrypted: i=1; AJvYcCWQx3RrGI/ZuKWsTSBHDHmEB8IpF+ANoRzZVQ0Ziupc4P+MRH4OsGwDuNGrgg714cUJ02Rb2cZS2nscuN7e@vger.kernel.org
X-Gm-Message-State: AOJu0YztlmrLipnTkdE+s9SKLdqdfCk4y0x8978VEdFroUvZKphDuJpc
	uGXDUoPZTFOoahmzPKtbm2BnXKtVJ8+MyLvBPl83ydFAIerpbJrk44Ka5w2FDU9Y5ieusMX/spG
	2s62dww==
X-Google-Smtp-Source: AGHT+IEqdQSQ4N8X6/w1J1ekRXma+i0BojwGflPmtkgu5WcGSOzfRDXMTf8X59zGyHImXpMp3NeJWtoyKPo=
X-Received: from pjtz14.prod.google.com ([2002:a17:90a:cb0e:b0:33d:79bb:9fd5])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a1b:b0:2b6:3182:be1e
 with SMTP id adf61e73a8af0-334a85151e0mr49629682637.12.1761510977678; Sun, 26
 Oct 2025 13:36:17 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:36:04 -0700
In-Reply-To: <20251026203611.1608903-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251026203611.1608903-2-surenb@google.com>
Subject: [PATCH v2 1/8] mm: implement cleancache
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"

Cleancache can be thought of as a page-granularity victim cache for clean
pages that the kernel's pageframe replacement algorithm  would like to
keep around, but can't since there isn't enough memory. When the page
reclaim mechanism "evicts" a page, it first attempts to use cleancache
to put the data contained in that page into memory that is not directly
accessible or addressable by the kernel. Later, when the system needs to
access a page in a file on disk, it first checks cleancache to see if it
already contains it; if it does, the page of data is copied into the
kernel and a disk access is avoided.

The patchset borrows the idea, some code and documentation from previous
cleancache implementation but as opposed to being a thin pass-through
layer, it now implements housekeeping code to associate cleancache pages
with their inodes and handling of page pools donated by the cleancache
backends. It also avoids intrusive hooks into filesystem code, limiting
itself to hooks in mm reclaim and page-in paths and two hooks to detect
new filesystem mount/unmount events.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Minchan Kim <minchan@google.com>
---
 MAINTAINERS                |   8 +
 block/bdev.c               |   6 +
 fs/super.c                 |   3 +
 include/linux/cleancache.h |  64 +++
 include/linux/fs.h         |   6 +
 include/linux/mm_types.h   |  12 +-
 include/linux/pagemap.h    |   1 +
 mm/Kconfig                 |  16 +
 mm/Makefile                |   1 +
 mm/cleancache.c            | 852 +++++++++++++++++++++++++++++++++++++
 mm/filemap.c               |  26 ++
 mm/truncate.c              |   4 +
 mm/vmscan.c                |   1 +
 13 files changed, 998 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/cleancache.h
 create mode 100644 mm/cleancache.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c1a1732df7b1..90a6fc0e742c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6053,6 +6053,14 @@ F:	scripts/Makefile.clang
 F:	scripts/clang-tools/
 K:	\b(?i:clang|llvm)\b
 
+CLEANCACHE
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Minchan Kim <minchan@google.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	include/linux/cleancache.h
+F:	mm/cleancache.c
+
 CLK API
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-clk@vger.kernel.org
diff --git a/block/bdev.c b/block/bdev.c
index 810707cca970..e1b785515520 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -28,6 +28,7 @@
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
 #include <linux/stat.h>
+#include <linux/cleancache.h>
 #include "../fs/internal.h"
 #include "blk.h"
 
@@ -101,6 +102,11 @@ void invalidate_bdev(struct block_device *bdev)
 		lru_add_drain_all();	/* make sure all lru add caches are flushed */
 		invalidate_mapping_pages(mapping, 0, -1);
 	}
+	/*
+	 * 99% of the time, we don't need to flush the cleancache on the bdev.
+	 * But, for the strange corners, lets be cautious
+	 */
+	cleancache_invalidate_inode(mapping->host);
 }
 EXPORT_SYMBOL(invalidate_bdev);
 
diff --git a/fs/super.c b/fs/super.c
index 5bab94fb7e03..5639dc069528 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -31,6 +31,7 @@
 #include <linux/mutex.h>
 #include <linux/backing-dev.h>
 #include <linux/rculist_bl.h>
+#include <linux/cleancache.h>
 #include <linux/fscrypt.h>
 #include <linux/fsnotify.h>
 #include <linux/lockdep.h>
@@ -374,6 +375,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_time_gran = 1000000000;
 	s->s_time_min = TIME64_MIN;
 	s->s_time_max = TIME64_MAX;
+	cleancache_add_fs(s);
 
 	s->s_shrink = shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
 				     "sb-%s", type->name);
@@ -469,6 +471,7 @@ void deactivate_locked_super(struct super_block *s)
 {
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
+		cleancache_remove_fs(s);
 		shrinker_free(s->s_shrink);
 		fs->kill_sb(s);
 
diff --git a/include/linux/cleancache.h b/include/linux/cleancache.h
new file mode 100644
index 000000000000..419faa183aba
--- /dev/null
+++ b/include/linux/cleancache.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CLEANCACHE_H
+#define _LINUX_CLEANCACHE_H
+
+#include <linux/fs.h>
+#include <linux/exportfs.h>
+#include <linux/mm.h>
+
+/* super_block->cleancache_id value for an invalid ID */
+#define CLEANCACHE_ID_INVALID	-1
+
+#define CLEANCACHE_KEY_MAX	6
+
+
+#ifdef CONFIG_CLEANCACHE
+
+/* Hooks into MM and FS */
+int cleancache_add_fs(struct super_block *sb);
+void cleancache_remove_fs(struct super_block *sb);
+bool cleancache_store_folio(struct inode *inode, struct folio *folio);
+bool cleancache_restore_folio(struct inode *inode, struct folio *folio);
+bool cleancache_invalidate_folio(struct inode *inode, struct folio *folio);
+bool cleancache_invalidate_inode(struct inode *inode);
+
+/*
+ * Backend API
+ *
+ * Cleancache does not touch folio references. Folio refcount should be 1 when
+ * folio is placed or returned into cleancache and folios obtained from
+ * cleancache will also have their refcount at 1.
+ */
+int cleancache_backend_register_pool(const char *name);
+int cleancache_backend_get_folio(int pool_id, struct folio *folio);
+int cleancache_backend_put_folio(int pool_id, struct folio *folio);
+int cleancache_backend_put_folios(int pool_id, struct list_head *folios);
+
+#else /* CONFIG_CLEANCACHE */
+
+static inline int cleancache_add_fs(struct super_block *sb)
+		{ return -EOPNOTSUPP; }
+static inline void cleancache_remove_fs(struct super_block *sb) {}
+static inline bool cleancache_store_folio(struct inode *inode,
+					  struct folio *folio)
+		{ return false; }
+static inline bool cleancache_restore_folio(struct inode *inode,
+					    struct folio *folio)
+		{ return false; }
+static inline bool cleancache_invalidate_folio(struct inode *inode,
+					       struct folio *folio)
+		{ return false; }
+static inline bool cleancache_invalidate_inode(struct inode *inode)
+		{ return false; }
+static inline int cleancache_backend_register_pool(const char *name)
+		{ return -EOPNOTSUPP; }
+static inline int cleancache_backend_get_folio(int pool_id, struct folio *folio)
+		{ return -EOPNOTSUPP; }
+static inline int cleancache_backend_put_folio(int pool_id, struct folio *folio)
+		{ return -EOPNOTSUPP; }
+static inline int cleancache_backend_put_folios(int pool_id, struct list_head *folios)
+		{ return -EOPNOTSUPP; }
+
+#endif /* CONFIG_CLEANCACHE */
+
+#endif /* _LINUX_CLEANCACHE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8cf9547a881c..a8ad021836ee 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1583,6 +1583,12 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+#ifdef CONFIG_CLEANCACHE
+	/*
+	 * Saved identifier for cleancache (CLEANCACHE_ID_INVALID means none)
+	 */
+	int cleancache_id;
+#endif
 } __randomize_layout;
 
 static inline struct user_namespace *i_user_ns(const struct inode *inode)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5021047485a9..720315e30c58 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -33,6 +33,7 @@
 struct address_space;
 struct futex_private_hash;
 struct mem_cgroup;
+struct cleancache_inode;
 
 typedef struct {
 	unsigned long f;
@@ -392,16 +393,23 @@ struct folio {
 	/* public: */
 				struct dev_pagemap *pgmap;
 			};
-			struct address_space *mapping;
+			union {
+				struct address_space *mapping;
+				struct cleancache_inode *cc_inode;
+			};
 			union {
 				pgoff_t index;
+				pgoff_t cc_index;
 				unsigned long share;
 			};
 			union {
 				void *private;
 				swp_entry_t swap;
 			};
-			atomic_t _mapcount;
+			union {
+				atomic_t _mapcount;
+				int cc_pool_id;
+			};
 			atomic_t _refcount;
 #ifdef CONFIG_MEMCG
 			unsigned long memcg_data;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 09b581c1d878..7d9fa68ad0c9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1269,6 +1269,7 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		pgoff_t index, gfp_t gfp);
 void filemap_remove_folio(struct folio *folio);
+void store_into_cleancache(struct address_space *mapping, struct folio *folio);
 void __filemap_remove_folio(struct folio *folio, void *shadow);
 void replace_page_cache_folio(struct folio *old, struct folio *new);
 void delete_from_page_cache_batch(struct address_space *mapping,
diff --git a/mm/Kconfig b/mm/Kconfig
index a5a90b169435..1255b543030b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1033,6 +1033,22 @@ config USE_PERCPU_NUMA_NODE_ID
 config HAVE_SETUP_PER_CPU_AREA
 	bool
 
+config CLEANCACHE
+	bool "Enable cleancache to cache clean pages"
+	help
+	  Cleancache can be thought of as a page-granularity victim cache for
+	  clean pages that the kernel's pageframe replacement algorithm would
+	  like to keep around, but can't since there isn't enough memory.
+	  When the page reclaim mechanism "evicts" a page, it first attempts to
+	  to put the data contained in that page into cleancache, backed by
+	  memory that is not directly accessible or addressable by the kernel
+	  and is of unknown and possibly time-varying size. When system wishes
+	  to access a page in a file on disk, it first checks cleancache to see
+	  if it already contains required data; if it does, the page is copied
+	  into the kernel and a disk access is avoided.
+
+	  If unsure, say N.
+
 config CMA
 	bool "Contiguous Memory Allocator"
 	depends on MMU
diff --git a/mm/Makefile b/mm/Makefile
index 21abb3353550..b78073b87aea 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -146,3 +146,4 @@ obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
+obj-$(CONFIG_CLEANCACHE) += cleancache.o
diff --git a/mm/cleancache.c b/mm/cleancache.c
new file mode 100644
index 000000000000..26fb91b987b7
--- /dev/null
+++ b/mm/cleancache.c
@@ -0,0 +1,852 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/cleancache.h>
+#include <linux/exportfs.h>
+#include <linux/fs.h>
+#include <linux/hashtable.h>
+#include <linux/highmem.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
+
+/*
+ * Lock nesting:
+ *	ccinode->folios.xa_lock
+ *		fs->hash_lock
+ *
+ *	ccinode->folios.xa_lock
+ *		pool->lock
+ */
+
+#define INODE_HASH_BITS		6
+
+/* represents each file system instance hosted by the cleancache */
+struct cleancache_fs {
+	refcount_t ref_count;
+	DECLARE_HASHTABLE(inode_hash, INODE_HASH_BITS);
+	spinlock_t hash_lock; /* protects inode_hash */
+	struct rcu_head rcu;
+};
+
+/*
+ * @cleancache_inode represents each ccinode in @cleancache_fs
+ *
+ * The cleancache_inode will be freed by RCU when the last folio from xarray
+ * is freed, except for invalidate_inode() case.
+ */
+struct cleancache_inode {
+	struct inode *inode;
+	struct hlist_node hash;
+	refcount_t ref_count;
+	struct xarray folios;
+	struct cleancache_fs *fs;
+	struct rcu_head rcu;
+};
+
+/* Cleancache backend memory pool */
+struct cleancache_pool {
+	struct list_head folio_list;
+	spinlock_t lock; /* protects folio_list */
+};
+
+#define CLEANCACHE_MAX_POOLS	64
+
+static DEFINE_XARRAY_ALLOC(fs_xa);
+static struct kmem_cache *slab_inode; /* cleancache_inode slab */
+static struct cleancache_pool pools[CLEANCACHE_MAX_POOLS];
+static atomic_t nr_pools = ATOMIC_INIT(0);
+static DEFINE_SPINLOCK(pools_lock); /* protects pools */
+
+static inline void init_cleancache_folio(struct folio *folio, int pool_id)
+{
+	/* Folio is being donated and has no refs. No locking is needed. */
+	VM_BUG_ON(folio_ref_count(folio) != 0);
+
+	folio->cc_pool_id = pool_id;
+	folio->cc_inode = NULL;
+	folio->cc_index = 0;
+}
+
+static inline void clear_cleancache_folio(struct folio *folio)
+{
+	/* Folio must be detached and not in the pool. No locking is needed. */
+	VM_BUG_ON(folio->cc_inode);
+
+	folio->cc_pool_id = -1;
+}
+
+static inline int folio_pool_id(struct folio *folio)
+{
+	return folio->cc_pool_id;
+}
+
+static inline struct cleancache_pool *folio_pool(struct folio *folio)
+{
+	return &pools[folio_pool_id(folio)];
+}
+
+static void attach_folio(struct folio *folio, struct cleancache_inode *ccinode,
+			 pgoff_t offset)
+{
+	lockdep_assert_held(&(folio_pool(folio)->lock));
+
+	folio->cc_inode = ccinode;
+	folio->cc_index = offset;
+}
+
+static void detach_folio(struct folio *folio)
+{
+	lockdep_assert_held(&(folio_pool(folio)->lock));
+
+	folio->cc_inode = NULL;
+	folio->cc_index = 0;
+}
+
+static void folio_attachment(struct folio *folio,
+			     struct cleancache_inode **ccinode, pgoff_t *offset)
+{
+	lockdep_assert_held(&(folio_pool(folio)->lock));
+
+	*ccinode = folio->cc_inode;
+	*offset = folio->cc_index;
+}
+
+static inline bool is_folio_attached(struct folio *folio)
+{
+	lockdep_assert_held(&(folio_pool(folio)->lock));
+
+	return folio->cc_inode != NULL;
+}
+
+/*
+ * Folio pool helpers.
+ *	Only detached folios are stored in the pool->folio_list.
+ *
+ * Locking:
+ *	pool->folio_list is accessed under pool->lock.
+ */
+static void add_folio_to_pool(struct folio *folio, struct cleancache_pool *pool)
+{
+	lockdep_assert_held(&pool->lock);
+	VM_BUG_ON(folio_pool(folio) != pool);
+	VM_BUG_ON(!list_empty(&folio->lru));
+	VM_BUG_ON(is_folio_attached(folio));
+
+	list_add(&folio->lru, &pool->folio_list);
+}
+
+static struct folio *remove_folio_from_pool(struct folio *folio, struct cleancache_pool *pool)
+{
+	lockdep_assert_held(&pool->lock);
+	VM_BUG_ON(folio_pool(folio) != pool);
+
+	if (is_folio_attached(folio))
+		return NULL;
+
+	list_del_init(&folio->lru);
+
+	return folio;
+}
+
+static struct folio *pick_folio_from_any_pool(void)
+{
+	struct cleancache_pool *pool;
+	struct folio *folio = NULL;
+	int count;
+
+	/* nr_pools can only increase, so the following loop is safe */
+	count = atomic_read_acquire(&nr_pools);
+	for (int i = 0; i < count; i++) {
+		pool = &pools[i];
+		spin_lock(&pool->lock);
+		if (!list_empty(&pool->folio_list)) {
+			folio = list_last_entry(&pool->folio_list,
+						struct folio, lru);
+			WARN_ON(!remove_folio_from_pool(folio, pool));
+			spin_unlock(&pool->lock);
+			break;
+		}
+		spin_unlock(&pool->lock);
+	}
+
+	return folio;
+}
+
+/* FS helpers */
+static struct cleancache_fs *get_fs(int fs_id)
+{
+	struct cleancache_fs *fs;
+
+	rcu_read_lock();
+	fs = xa_load(&fs_xa, fs_id);
+	if (fs && !refcount_inc_not_zero(&fs->ref_count))
+		fs = NULL;
+	rcu_read_unlock();
+
+	return fs;
+}
+
+static unsigned int invalidate_inode(struct cleancache_fs *fs,
+				     struct inode *inode);
+
+static void put_fs(struct cleancache_fs *fs)
+{
+	if (refcount_dec_and_test(&fs->ref_count)) {
+		struct cleancache_inode *ccinode;
+		struct hlist_node *tmp;
+		int cursor;
+
+		/*
+		 * There are no concurrent RCU walkers because they
+		 * would have taken fs reference.
+		 * We don't need to hold fs->hash_lock because there
+		 * are no other users and no way to reach fs.
+		 */
+		hash_for_each_safe(fs->inode_hash, cursor, tmp, ccinode, hash)
+			invalidate_inode(fs, ccinode->inode);
+		/*
+		 * Don't need to synchronize_rcu() and wait for all inodes to be
+		 * freed because RCU read walkers can't take fs refcount anymore
+		 * to start their walk.
+		 */
+		kfree_rcu(fs, rcu);
+	}
+}
+
+/* cleancache_inode helpers. */
+static struct cleancache_inode *alloc_cleancache_inode(struct cleancache_fs *fs,
+						       struct inode *inode)
+{
+	struct cleancache_inode *ccinode;
+
+	ccinode = kmem_cache_alloc(slab_inode, GFP_ATOMIC|__GFP_NOWARN);
+	if (ccinode) {
+		ccinode->inode = inode;
+		xa_init_flags(&ccinode->folios, XA_FLAGS_LOCK_IRQ);
+		INIT_HLIST_NODE(&ccinode->hash);
+		ccinode->fs = fs;
+		refcount_set(&ccinode->ref_count, 1);
+	}
+
+	return ccinode;
+}
+
+static void inode_free_rcu(struct rcu_head *rcu)
+{
+	struct cleancache_inode *ccinode;
+
+	ccinode = container_of(rcu, struct cleancache_inode, rcu);
+	VM_BUG_ON(!xa_empty(&ccinode->folios));
+	kmem_cache_free(slab_inode, ccinode);
+}
+
+static inline bool get_inode(struct cleancache_inode *ccinode)
+{
+	return refcount_inc_not_zero(&ccinode->ref_count);
+}
+
+static void put_inode(struct cleancache_inode *ccinode)
+{
+	VM_BUG_ON(refcount_read(&ccinode->ref_count) == 0);
+	if (!refcount_dec_and_test(&ccinode->ref_count))
+		return;
+
+	lockdep_assert_not_held(&ccinode->folios.xa_lock);
+	VM_BUG_ON(!xa_empty(&ccinode->folios));
+	call_rcu(&ccinode->rcu, inode_free_rcu);
+}
+
+static void remove_inode_if_empty(struct cleancache_inode *ccinode)
+{
+	struct cleancache_fs *fs = ccinode->fs;
+
+	lockdep_assert_held(&ccinode->folios.xa_lock);
+
+	if (!xa_empty(&ccinode->folios))
+		return;
+
+	spin_lock(&fs->hash_lock);
+	hlist_del_init_rcu(&ccinode->hash);
+	spin_unlock(&fs->hash_lock);
+	/*
+	 * Drop the refcount set in alloc_cleancache_inode(). Caller should
+	 * have taken an extra refcount to keep ccinode valid, so ccinode
+	 * will be freed once the caller releases it.
+	 */
+	put_inode(ccinode);
+}
+
+static bool store_folio_in_inode(struct cleancache_inode *ccinode,
+				 pgoff_t offset, struct folio *folio)
+{
+	struct cleancache_pool *pool = folio_pool(folio);
+	int err;
+
+	lockdep_assert_held(&ccinode->folios.xa_lock);
+	VM_BUG_ON(!list_empty(&folio->lru));
+
+	spin_lock(&pool->lock);
+	err = xa_err(__xa_store(&ccinode->folios, offset, folio,
+				GFP_ATOMIC|__GFP_NOWARN));
+	if (!err)
+		attach_folio(folio, ccinode, offset);
+	spin_unlock(&pool->lock);
+
+	return err == 0;
+}
+
+static void erase_folio_from_inode(struct cleancache_inode *ccinode,
+				   unsigned long offset, struct folio *folio)
+{
+	bool removed;
+
+	lockdep_assert_held(&ccinode->folios.xa_lock);
+
+	removed = __xa_erase(&ccinode->folios, offset);
+	VM_BUG_ON(!removed);
+	remove_inode_if_empty(ccinode);
+}
+
+static void move_folio_from_inode_to_pool(struct cleancache_inode *ccinode,
+					  unsigned long offset, struct folio *folio)
+{
+	struct cleancache_pool *pool = folio_pool(folio);
+
+	erase_folio_from_inode(ccinode, offset, folio);
+	spin_lock(&pool->lock);
+	detach_folio(folio);
+	add_folio_to_pool(folio, pool);
+	spin_unlock(&pool->lock);
+}
+
+static bool isolate_folio_from_inode(struct cleancache_inode *ccinode,
+				     unsigned long offset, struct folio *folio)
+{
+	bool isolated = false;
+
+	xa_lock(&ccinode->folios);
+	if (xa_load(&ccinode->folios, offset) == folio) {
+		struct cleancache_pool *pool = folio_pool(folio);
+
+		erase_folio_from_inode(ccinode, offset, folio);
+		spin_lock(&pool->lock);
+		detach_folio(folio);
+		spin_unlock(&pool->lock);
+		isolated = true;
+	}
+	xa_unlock(&ccinode->folios);
+
+	return isolated;
+}
+
+static unsigned int erase_folios_from_inode(struct cleancache_inode *ccinode,
+					    struct xa_state *xas)
+{
+	unsigned int ret = 0;
+	struct folio *folio;
+
+	lockdep_assert_held(&ccinode->folios.xa_lock);
+
+	xas_for_each(xas, folio, ULONG_MAX) {
+		move_folio_from_inode_to_pool(ccinode, xas->xa_index, folio);
+		ret++;
+	}
+
+	return ret;
+}
+
+static struct cleancache_inode *find_and_get_inode(struct cleancache_fs *fs,
+						   struct inode *inode)
+{
+	struct cleancache_inode *ccinode = NULL;
+	struct cleancache_inode *tmp;
+
+	rcu_read_lock();
+	hash_for_each_possible_rcu(fs->inode_hash, tmp, hash, inode->i_ino) {
+		if (tmp->inode != inode)
+			continue;
+
+		if (get_inode(tmp)) {
+			ccinode = tmp;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ccinode;
+}
+
+static struct cleancache_inode *add_and_get_inode(struct cleancache_fs *fs,
+						  struct inode *inode)
+{
+	struct cleancache_inode *ccinode, *tmp;
+
+	ccinode = alloc_cleancache_inode(fs, inode);
+	if (!ccinode)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock(&fs->hash_lock);
+	tmp = find_and_get_inode(fs, inode);
+	if (tmp) {
+		spin_unlock(&fs->hash_lock);
+		/* someone already added it */
+		put_inode(ccinode);
+		put_inode(tmp);
+		return ERR_PTR(-EEXIST);
+	}
+	hash_add_rcu(fs->inode_hash, &ccinode->hash, inode->i_ino);
+	get_inode(ccinode);
+	spin_unlock(&fs->hash_lock);
+
+	return ccinode;
+}
+
+static void copy_folio_content(struct folio *from, struct folio *to)
+{
+	void *src = kmap_local_folio(from, 0);
+	void *dst = kmap_local_folio(to, 0);
+
+	memcpy(dst, src, PAGE_SIZE);
+	kunmap_local(dst);
+	kunmap_local(src);
+}
+
+/*
+ * We want to store only workingset folios in the cleancache to increase hit
+ * ratio so there are four cases:
+ *
+ * @folio is workingset but cleancache doesn't have it: use new cleancache folio
+ * @folio is workingset and cleancache has it: overwrite the stale data
+ * @folio is !workingset and cleancache doesn't have it: just bail out
+ * @folio is !workingset and cleancache has it: remove the stale @folio
+ */
+static bool store_into_inode(struct cleancache_fs *fs,
+			     struct inode *inode,
+			     pgoff_t offset, struct folio *folio)
+{
+	bool workingset = folio_test_workingset(folio);
+	struct cleancache_inode *ccinode;
+	struct folio *stored_folio;
+	bool new_inode = false;
+	bool ret = false;
+
+find_inode:
+	ccinode = find_and_get_inode(fs, inode);
+	if (!ccinode) {
+		if (!workingset)
+			return false;
+
+		ccinode = add_and_get_inode(fs, inode);
+		if (IS_ERR_OR_NULL(ccinode)) {
+			/*
+			 * Retry if someone just added new ccinode from under us.
+			 */
+			if (PTR_ERR(ccinode) == -EEXIST)
+				goto find_inode;
+
+			return false;
+		}
+		new_inode = true;
+	}
+
+	xa_lock(&ccinode->folios);
+	stored_folio = xa_load(&ccinode->folios, offset);
+	if (stored_folio) {
+		if (!workingset) {
+			move_folio_from_inode_to_pool(ccinode, offset, stored_folio);
+			goto out_unlock;
+		}
+	} else {
+		if (!workingset)
+			goto out_unlock;
+
+		stored_folio = pick_folio_from_any_pool();
+		if (!stored_folio) {
+			/* No free folios, TODO: try reclaiming */
+			goto out_unlock;
+		}
+
+		if (!store_folio_in_inode(ccinode, offset, stored_folio)) {
+			struct cleancache_pool *pool = folio_pool(stored_folio);
+
+			/* Return stored_folio back into pool */
+			spin_lock(&pool->lock);
+			add_folio_to_pool(stored_folio, pool);
+			spin_unlock(&pool->lock);
+			goto out_unlock;
+		}
+	}
+	copy_folio_content(folio, stored_folio);
+
+	ret = true;
+out_unlock:
+	/* Free ccinode if it was created but no folio was stored in it. */
+	if (new_inode)
+		remove_inode_if_empty(ccinode);
+	xa_unlock(&ccinode->folios);
+	put_inode(ccinode);
+
+	return ret;
+}
+
+static bool load_from_inode(struct cleancache_fs *fs,
+			    struct inode *inode,
+			    pgoff_t offset, struct folio *folio)
+{
+	struct cleancache_inode *ccinode;
+	struct folio *stored_folio;
+	bool ret = false;
+
+	ccinode = find_and_get_inode(fs, inode);
+	if (!ccinode)
+		return false;
+
+	xa_lock(&ccinode->folios);
+	stored_folio = xa_load(&ccinode->folios, offset);
+	if (stored_folio) {
+		copy_folio_content(stored_folio, folio);
+		ret = true;
+	}
+	xa_unlock(&ccinode->folios);
+	put_inode(ccinode);
+
+	return ret;
+}
+
+static bool invalidate_folio(struct cleancache_fs *fs,
+			     struct inode *inode, pgoff_t offset)
+{
+	struct cleancache_inode *ccinode;
+	struct folio *folio;
+
+	ccinode = find_and_get_inode(fs, inode);
+	if (!ccinode)
+		return false;
+
+	xa_lock(&ccinode->folios);
+	folio = xa_load(&ccinode->folios, offset);
+	if (folio)
+		move_folio_from_inode_to_pool(ccinode, offset, folio);
+	xa_unlock(&ccinode->folios);
+	put_inode(ccinode);
+
+	return folio != NULL;
+}
+
+static unsigned int invalidate_inode(struct cleancache_fs *fs,
+				     struct inode *inode)
+{
+	struct cleancache_inode *ccinode;
+	unsigned int ret;
+
+	ccinode = find_and_get_inode(fs, inode);
+	if (ccinode) {
+		XA_STATE(xas, &ccinode->folios, 0);
+
+		xas_lock(&xas);
+		ret = erase_folios_from_inode(ccinode, &xas);
+		xas_unlock(&xas);
+		put_inode(ccinode);
+
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Hooks into MM and FS */
+int cleancache_add_fs(struct super_block *sb)
+{
+	struct cleancache_fs *fs;
+	int fs_id;
+	int ret;
+
+	fs = kzalloc(sizeof(struct cleancache_fs), GFP_KERNEL);
+	if (!fs) {
+		sb->cleancache_id = CLEANCACHE_ID_INVALID;
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&fs->hash_lock);
+	hash_init(fs->inode_hash);
+	refcount_set(&fs->ref_count, 1);
+	ret = xa_alloc(&fs_xa, &fs_id, fs, xa_limit_32b, GFP_KERNEL);
+	if (ret) {
+		if (ret == -EBUSY)
+			pr_warn("too many file systems\n");
+
+		sb->cleancache_id = CLEANCACHE_ID_INVALID;
+		kfree(fs);
+	} else {
+		sb->cleancache_id = fs_id;
+	}
+
+	return ret;
+}
+
+void cleancache_remove_fs(struct super_block *sb)
+{
+	int fs_id = sb->cleancache_id;
+	struct cleancache_fs *fs;
+
+	sb->cleancache_id = CLEANCACHE_ID_INVALID;
+	fs = get_fs(fs_id);
+	if (!fs)
+		return;
+
+	xa_erase(&fs_xa, fs_id);
+	put_fs(fs);
+
+	/* free the object */
+	put_fs(fs);
+}
+
+bool cleancache_store_folio(struct inode *inode, struct folio *folio)
+{
+	struct cleancache_fs *fs;
+	int fs_id;
+	bool ret;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	if (!inode)
+		return false;
+
+	/* Do not support large folios yet */
+	if (folio_test_large(folio))
+		return false;
+
+	fs_id = folio->mapping->host->i_sb->cleancache_id;
+	if (fs_id == CLEANCACHE_ID_INVALID)
+		return false;
+
+	fs = get_fs(fs_id);
+	if (!fs)
+		return false;
+
+	ret = store_into_inode(fs, inode, folio->index, folio);
+	put_fs(fs);
+
+	return ret;
+}
+
+bool cleancache_restore_folio(struct inode *inode, struct folio *folio)
+{
+	struct cleancache_fs *fs;
+	int fs_id;
+	bool ret;
+
+	if (!inode)
+		return false;
+
+	/* Do not support large folios yet */
+	if (folio_test_large(folio))
+		return false;
+
+	fs_id = folio->mapping->host->i_sb->cleancache_id;
+	if (fs_id == CLEANCACHE_ID_INVALID)
+		return false;
+
+	fs = get_fs(fs_id);
+	if (!fs)
+		return false;
+
+	ret = load_from_inode(fs, inode, folio->index, folio);
+	put_fs(fs);
+
+	return ret;
+}
+
+bool cleancache_invalidate_folio(struct inode *inode, struct folio *folio)
+{
+	struct cleancache_fs *fs;
+	int fs_id;
+	bool ret;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	if (!inode)
+		return false;
+
+	/* Do not support large folios yet */
+	if (folio_test_large(folio))
+		return false;
+
+	/* Careful, folio->mapping can be NULL */
+	fs_id = inode->i_sb->cleancache_id;
+	if (fs_id == CLEANCACHE_ID_INVALID)
+		return false;
+
+	fs = get_fs(fs_id);
+	if (!fs)
+		return false;
+
+	ret = invalidate_folio(fs, inode, folio->index);
+	put_fs(fs);
+
+	return ret;
+}
+
+bool cleancache_invalidate_inode(struct inode *inode)
+{
+	struct cleancache_fs *fs;
+	unsigned int count;
+	int fs_id;
+
+	if (!inode)
+		return false;
+
+	fs_id = inode->i_sb->cleancache_id;
+	if (fs_id == CLEANCACHE_ID_INVALID)
+		return false;
+
+	fs = get_fs(fs_id);
+	if (!fs)
+		return false;
+
+	count = invalidate_inode(fs, inode);
+	put_fs(fs);
+
+	return count > 0;
+}
+
+/* Backend API */
+/*
+ * Register a new backend and add its folios for cleancache to use.
+ * Returns pool id on success or a negative error code on failure.
+ */
+int cleancache_backend_register_pool(const char *name)
+{
+	struct cleancache_pool *pool;
+	int pool_id;
+
+	/* pools_lock prevents concurrent registrations */
+	spin_lock(&pools_lock);
+	pool_id = atomic_read(&nr_pools);
+	if (pool_id >= CLEANCACHE_MAX_POOLS) {
+		spin_unlock(&pools_lock);
+		return -ENOMEM;
+	}
+
+	pool = &pools[pool_id];
+	INIT_LIST_HEAD(&pool->folio_list);
+	spin_lock_init(&pool->lock);
+	/* Ensure above stores complete before we increase the count */
+	atomic_set_release(&nr_pools, pool_id + 1);
+	spin_unlock(&pools_lock);
+
+	pr_info("Registered \'%s\' cleancache backend, pool id %d\n",
+		name ? : "none", pool_id);
+
+	return pool_id;
+}
+EXPORT_SYMBOL(cleancache_backend_register_pool);
+
+int cleancache_backend_get_folio(int pool_id, struct folio *folio)
+{
+	struct cleancache_inode *ccinode;
+	struct cleancache_pool *pool;
+	pgoff_t offset;
+
+	/* Do not support large folios yet */
+	if (folio_test_large(folio))
+		return -EOPNOTSUPP;
+
+	/* Does the folio belong to the requesting backend */
+	if (folio_pool_id(folio) != pool_id)
+		return -EINVAL;
+
+	pool = &pools[pool_id];
+again:
+	spin_lock(&pool->lock);
+
+	/* If folio is free in the pool, return it */
+	if (remove_folio_from_pool(folio, pool)) {
+		spin_unlock(&pool->lock);
+		goto out;
+	}
+	/*
+	 * The folio is not free, therefore it has to belong
+	 * to a valid ccinode.
+	 */
+	folio_attachment(folio, &ccinode, &offset);
+	if (WARN_ON(!ccinode || !get_inode(ccinode))) {
+		spin_unlock(&pool->lock);
+		return -EINVAL;
+	}
+
+	spin_unlock(&pool->lock);
+
+	/* Retry if the folio got erased from the ccinode */
+	if (!isolate_folio_from_inode(ccinode, offset, folio)) {
+		put_inode(ccinode);
+		goto again;
+	}
+
+	put_inode(ccinode);
+out:
+	VM_BUG_ON_FOLIO(folio_ref_count(folio) != 0, (folio));
+	clear_cleancache_folio(folio);
+
+	return 0;
+}
+EXPORT_SYMBOL(cleancache_backend_get_folio);
+
+int cleancache_backend_put_folio(int pool_id, struct folio *folio)
+{
+	struct cleancache_pool *pool = &pools[pool_id];
+
+	/* Do not support large folios yet */
+	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
+
+	/* Can't put a still used folio into cleancache */
+	if (folio_ref_count(folio) != 0)
+		return -EINVAL;
+
+	/* Reset struct folio fields */
+	init_cleancache_folio(folio, pool_id);
+	INIT_LIST_HEAD(&folio->lru);
+	spin_lock(&pool->lock);
+	add_folio_to_pool(folio, pool);
+	spin_unlock(&pool->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(cleancache_backend_put_folio);
+
+int cleancache_backend_put_folios(int pool_id, struct list_head *folios)
+{
+	struct cleancache_pool *pool = &pools[pool_id];
+	LIST_HEAD(unused_folios);
+	struct folio *folio;
+	struct folio *tmp;
+
+	list_for_each_entry_safe(folio, tmp, folios, lru) {
+		/* Do not support large folios yet */
+		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
+		if (folio_ref_count(folio) != 0)
+			continue;
+
+		init_cleancache_folio(folio, pool_id);
+		list_move(&folio->lru, &unused_folios);
+	}
+
+	spin_lock(&pool->lock);
+	list_splice_init(&unused_folios, &pool->folio_list);
+	spin_unlock(&pool->lock);
+
+	return list_empty(folios) ? 0 : -EINVAL;
+}
+EXPORT_SYMBOL(cleancache_backend_put_folios);
+
+static int __init init_cleancache(void)
+{
+	slab_inode = KMEM_CACHE(cleancache_inode, 0);
+	if (!slab_inode)
+		return -ENOMEM;
+
+	return 0;
+}
+core_initcall(init_cleancache);
diff --git a/mm/filemap.c b/mm/filemap.c
index d78112183e79..d4a64179ec2d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -36,6 +36,7 @@
 #include <linux/cpuset.h>
 #include <linux/hugetlb.h>
 #include <linux/memcontrol.h>
+#include <linux/cleancache.h>
 #include <linux/shmem_fs.h>
 #include <linux/rmap.h>
 #include <linux/delayacct.h>
@@ -213,6 +214,19 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 		folio_account_cleaned(folio, inode_to_wb(mapping->host));
 }
 
+void store_into_cleancache(struct address_space *mapping, struct folio *folio)
+{
+	/*
+	 * If we're uptodate, flush out into the cleancache, otherwise
+	 * invalidate any existing cleancache entries.  We can't leave
+	 * stale data around in the cleancache once our page is gone.
+	 */
+	if (folio_test_uptodate(folio) && folio_test_mappedtodisk(folio))
+		cleancache_store_folio(mapping->host, folio);
+	else
+		cleancache_invalidate_folio(mapping->host, folio);
+}
+
 /*
  * Delete a page from the page cache and free it. Caller has to make
  * sure the page is locked and that nobody else uses it - or that usage
@@ -251,6 +265,9 @@ void filemap_remove_folio(struct folio *folio)
 	struct address_space *mapping = folio->mapping;
 
 	BUG_ON(!folio_test_locked(folio));
+
+	store_into_cleancache(mapping, folio);
+
 	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	__filemap_remove_folio(folio, NULL);
@@ -324,6 +341,9 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	if (!folio_batch_count(fbatch))
 		return;
 
+	for (i = 0; i < folio_batch_count(fbatch); i++)
+		store_into_cleancache(mapping, fbatch->folios[i]);
+
 	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
@@ -2438,6 +2458,12 @@ static int filemap_read_folio(struct file *file, filler_t filler,
 	unsigned long pflags;
 	int error;
 
+	if (cleancache_restore_folio(folio->mapping->host, folio)) {
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+		return 0;
+	}
+
 	/* Start the actual read. The read will unlock the page. */
 	if (unlikely(workingset))
 		psi_memstall_enter(&pflags);
diff --git a/mm/truncate.c b/mm/truncate.c
index 9210cf808f5c..31f8ebd32245 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -20,6 +20,7 @@
 #include <linux/pagevec.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/shmem_fs.h>
+#include <linux/cleancache.h>
 #include <linux/rmap.h>
 #include "internal.h"
 
@@ -136,6 +137,7 @@ void folio_invalidate(struct folio *folio, size_t offset, size_t length)
 {
 	const struct address_space_operations *aops = folio->mapping->a_ops;
 
+	cleancache_invalidate_folio(folio->mapping->host, folio);
 	if (aops->invalidate_folio)
 		aops->invalidate_folio(folio, offset, length);
 }
@@ -615,6 +617,8 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 	if (!filemap_release_folio(folio, gfp))
 		return -EBUSY;
 
+	cleancache_invalidate_folio(mapping->host, folio);
+
 	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	if (folio_test_dirty(folio))
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c922bad2b8fd..3f2f18715c3a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -716,6 +716,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 	if (folio_test_swapcache(folio)) {
 		ci = swap_cluster_get_and_lock_irq(folio);
 	} else {
+		store_into_cleancache(mapping, folio);
 		spin_lock(&mapping->host->i_lock);
 		xa_lock_irq(&mapping->i_pages);
 	}
-- 
2.51.1.851.g4ebd6896fd-goog


