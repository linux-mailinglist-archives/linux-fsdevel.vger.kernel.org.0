Return-Path: <linux-fsdevel+bounces-11191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9FC851FCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D71F1C22DEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3412C4D9EE;
	Mon, 12 Feb 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3K8eOlS2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF954D5A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773976; cv=none; b=n7aNRok3E/1760Xo2CL+cNO0rRMaTndTFBint48HgrXGKfEwq6WhcdmUuwz8eqrhFW2pO0DCTeNBYo8vigWDkKGy0qi7xKb0AXHxzsVmHrR4wGrpn1+6v5aV7C+Ik/iE2JGokEPQ6uVvPV6s1mcpLyyL41XvRB+KvsraPN78E38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773976; c=relaxed/simple;
	bh=s3LEGYg8VUwRWvZpWWOEEverrgI0r872J86EZP7SPxw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dDndnqCt0YXZ/sXYNt9EdBgf1Zj1g6g+47xJ6gnT+KeUMeBCYR6AjSDr0riprLk/VcWis6dzxbkIO2BY782a4yJPtpMUXyf8TV21iAskswI2VWZltcggJXnXNHjortR+/UNd+fkipc1m+FQsi5SQy8zvgxjHT8thn9kp27XhGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3K8eOlS2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso5925798276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773972; x=1708378772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vA/ePHR05wabM4Y5MMpygOj0r4Hku8hMtHDwkSr6xQQ=;
        b=3K8eOlS2fg2MQ3a3n/2AUg6ViRTW1C6K26sF+QSzMvOShaxAmsfaYbHk5sC/5Xch04
         0IdRPV31S8TJxahklR+wQ3ZAVgmLTb0076g6n2bjDUKE1Ws5e8amDAzALSo5xl5+KCGk
         zLqFWFe7uH9lyCq53DUwEvjSVAHSuG78oWes9u5mRQf+zm471q8JcERFV9TsPlY4TQlt
         e0TFOnLdPCt7yQTpGfGRdFhky5LUaLBEYpyf/syXl91QqOM6Nf70VIPq7ceytPJM+aFc
         sMB/7Q/OChvpVpQ/PVfwvWCZUzBVaEWhTph96dE8EOZzHt8csRMnqfDTERv84ruw5bWg
         wPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773972; x=1708378772;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vA/ePHR05wabM4Y5MMpygOj0r4Hku8hMtHDwkSr6xQQ=;
        b=r5OZP64knxqbbCTWKu8N8W98KHxvnShx/z33dsEdeb/uTHYgFbiYx9d9xlyTpAHLVg
         l8NvMIczyzcreml2j4Ycd+GvIJt5II9MRT7rWvjXgFnEaWfXgBXsOs1pPfp0RELvfOeZ
         ypJP5LlI4wu+VnK/Hunm7F48W53fcAy8fpiqszqTUK9uzXpKY3SkSTYoXepOepmC/H6/
         ORXFyuXqCMKBvStBf1OncStTX0aEBoTdni0+Rxzdg4Ci/BM+CroGFysjCojJZksN+RBD
         tNlDVbLBuE9qSTpiE07M5Z/9JpN/ZSzZG+zLNPf5mAVZ03zBxLOw3jqtBO/59AAlbwrb
         iUsw==
X-Gm-Message-State: AOJu0YxohK8buTDteX9RzptUIar35xUmcYZUKoLUnMCKFsUGNmlRaSoq
	XaYneAnuvU3+BTkCOYrjBpCpYqFs9kosMS4BZ2oLmGq6UhZ1pRcn2ImcPF2Sd7LZRDySkr8KeaI
	79g==
X-Google-Smtp-Source: AGHT+IGYazuIgsgZwBWVLtlsmQQd5LxodV8fFUctMuX5ciXn0PoDOAWUoAo/h1A3Z0RCnVOsgEP5hOuPMuk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:6902:188c:b0:dbd:b165:441 with SMTP id
 cj12-20020a056902188c00b00dbdb1650441mr2291367ybb.0.1707773972271; Mon, 12
 Feb 2024 13:39:32 -0800 (PST)
Date: Mon, 12 Feb 2024 13:38:46 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-1-surenb@google.com>
Subject: [PATCH v3 00/35] Memory allocation profiling
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Memory allocation, v3 and final:

Overview:
Low overhead [1] per-callsite memory allocation profiling. Not just for debug
kernels, overhead low enough to be deployed in production.

We're aiming to get this in the next merge window, for 6.9. The feedback
we've gotten has been that even out of tree this patchset has already
been useful, and there's a significant amount of other work gated on the
code tagging functionality included in this patchset [2].

Example output:
  root@moria-kvm:~# sort -h /proc/allocinfo|tail
   3.11MiB     2850 fs/ext4/super.c:1408 module:ext4 func:ext4_alloc_inode
   3.52MiB      225 kernel/fork.c:356 module:fork func:alloc_thread_stack_node
   3.75MiB      960 mm/page_ext.c:270 module:page_ext func:alloc_page_ext
   4.00MiB        2 mm/khugepaged.c:893 module:khugepaged func:hpage_collapse_alloc_folio
   10.5MiB      168 block/blk-mq.c:3421 module:blk_mq func:blk_mq_alloc_rqs
   14.0MiB     3594 include/linux/gfp.h:295 module:filemap func:folio_alloc_noprof
   26.8MiB     6856 include/linux/gfp.h:295 module:memory func:folio_alloc_noprof
   64.5MiB    98315 fs/xfs/xfs_rmap_item.c:147 module:xfs func:xfs_rui_init
   98.7MiB    25264 include/linux/gfp.h:295 module:readahead func:folio_alloc_noprof
    125MiB     7357 mm/slub.c:2201 module:slub func:alloc_slab_page

Since v2:
 - tglx noticed a circular header dependency between sched.h and percpu.h;
   a bunch of header cleanups were merged into 6.8 to ameliorate this [3].

 - a number of improvements, moving alloc_hooks() annotations to the
   correct place for better tracking (mempool), and bugfixes.

 - looked at alternate hooking methods.
   There were suggestions on alternate methods (compiler attribute,
   trampolines), but they wouldn't have made the patchset any cleaner
   (we still need to have different function versions for accounting vs. no
   accounting to control at which point in a call chain the accounting
   happens), and they would have added a dependency on toolchain
   support.

Usage:
kconfig options:
 - CONFIG_MEM_ALLOC_PROFILING
 - CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
 - CONFIG_MEM_ALLOC_PROFILING_DEBUG
   adds warnings for allocations that weren't accounted because of a
   missing annotation

sysctl:
  /proc/sys/vm/mem_profiling

Runtime info:
  /proc/allocinfo

Notes:

[1]: Overhead
To measure the overhead we are comparing the following configurations:
(1) Baseline with CONFIG_MEMCG_KMEM=n
(2) Disabled by default (CONFIG_MEM_ALLOC_PROFILING=y &&
    CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=n)
(3) Enabled by default (CONFIG_MEM_ALLOC_PROFILING=y &&
    CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=y)
(4) Enabled at runtime (CONFIG_MEM_ALLOC_PROFILING=y &&
    CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=n && /proc/sys/vm/mem_profiling=1)
(5) Baseline with CONFIG_MEMCG_KMEM=y && allocating with __GFP_ACCOUNT

Performance overhead:
To evaluate performance we implemented an in-kernel test executing
multiple get_free_page/free_page and kmalloc/kfree calls with allocation
sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
affinity set to a specific CPU to minimize the noise. Below are results
from running the test on Ubuntu 22.04.2 LTS with 6.8.0-rc1 kernel on
56 core Intel Xeon:

                        kmalloc                 pgalloc
(1 baseline)            6.764s                  16.902s
(2 default disabled)    6.793s (+0.43%)         17.007s (+0.62%)
(3 default enabled)     7.197s (+6.40%)         23.666s (+40.02%)
(4 runtime enabled)     7.405s (+9.48%)         23.901s (+41.41%)
(5 memcg)               13.388s (+97.94%)       48.460s (+186.71%)

Memory overhead:
Kernel size:

   text           data        bss         dec         diff
(1) 26515311	      18890222    17018880    62424413
(2) 26524728	      19423818    16740352    62688898    264485
(3) 26524724	      19423818    16740352    62688894    264481
(4) 26524728	      19423818    16740352    62688898    264485
(5) 26541782	      18964374    16957440    62463596    39183

Memory consumption on a 56 core Intel CPU with 125GB of memory:
Code tags:           192 kB
PageExts:         262144 kB (256MB)
SlabExts:           9876 kB (9.6MB)
PcpuExts:            512 kB (0.5MB)

Total overhead is 0.2% of total memory.

[2]: Improved fault injection is the big one; the alloc_hooks() macro
this patchset introduces is also used for per-callsite fault injection
points in the dynamic fault injection patchset, which means we can
easily do fault injection on a per module or per file basis; this makes
it much easier to integrate memory fault injection into existing tests.

Vlastimil recently raised concerns about exposing GFP_NOWAIT as a
PF_MEMALLOC_* flag, as this might introduce GFP_NOWAIT to allocation
paths that have never had their failure paths tested - this is something
we need to address.

[3]: The circular dependency looks to be unavoidable; the issue is that
alloc_tag_save() -> current -> get_current() requires percpu.h, and
percpu.h requires sched.h because of course it does. But this doesn't
actually cause build errors because we're only using macros, so the main
concern is just not leaving a difficult-to-disentangle minefield for
later.
So, sched.h is now pretty close to being a types only header that
imports types and declares types - this is the header cleanups that were
merged for 6.8.


Kent Overstreet (11):
  lib/string_helpers: Add flags param to string_get_size()
  scripts/kallysms: Always include __start and __stop symbols
  fs: Convert alloc_inode_sb() to a macro
  mm/slub: Mark slab_free_freelist_hook() __always_inline
  mempool: Hook up to memory allocation profiling
  xfs: Memory allocation profiling fixups
  mm: percpu: Introduce pcpuobj_ext
  mm: percpu: Add codetag reference into pcpuobj_ext
  mm: vmalloc: Enable memory allocation profiling
  rhashtable: Plumb through alloc tag
  MAINTAINERS: Add entries for code tagging and memory allocation
    profiling

Suren Baghdasaryan (24):
  mm: enumerate all gfp flags
  mm: introduce slabobj_ext to support slab object extensions
  mm: introduce __GFP_NO_OBJ_EXT flag to selectively prevent slabobj_ext
    creation
  mm/slab: introduce SLAB_NO_OBJ_EXT to avoid obj_ext creation
  mm: prevent slabobj_ext allocations for slabobj_ext and kmem_cache
    objects
  slab: objext: introduce objext_flags as extension to
    page_memcg_data_flags
  lib: code tagging framework
  lib: code tagging module support
  lib: prevent module unloading if memory is not freed
  lib: add allocation tagging support for memory allocation profiling
  lib: introduce support for page allocation tagging
  mm: percpu: increase PERCPU_MODULE_RESERVE to accommodate allocation
    tags
  change alloc_pages name in dma_map_ops to avoid name conflicts
  mm: enable page allocation tagging
  mm: create new codetag references during page splitting
  mm/page_ext: enable early_page_ext when
    CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
  lib: add codetag reference into slabobj_ext
  mm/slab: add allocation accounting into slab allocation and free paths
  mm/slab: enable slab allocation tagging for kmalloc and friends
  mm: percpu: enable per-cpu allocation tagging
  lib: add memory allocations report in show_mem()
  codetag: debug: skip objext checking when it's for objext itself
  codetag: debug: mark codetags for reserved pages as empty
  codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext
    allocations

 Documentation/admin-guide/sysctl/vm.rst       |  16 ++
 Documentation/filesystems/proc.rst            |  28 ++
 MAINTAINERS                                   |  16 ++
 arch/alpha/kernel/pci_iommu.c                 |   2 +-
 arch/mips/jazz/jazzdma.c                      |   2 +-
 arch/powerpc/kernel/dma-iommu.c               |   2 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |   2 +-
 arch/powerpc/platforms/ps3/system-bus.c       |   4 +-
 arch/powerpc/platforms/pseries/vio.c          |   2 +-
 arch/x86/kernel/amd_gart_64.c                 |   2 +-
 drivers/block/virtio_blk.c                    |   4 +-
 drivers/gpu/drm/gud/gud_drv.c                 |   2 +-
 drivers/iommu/dma-iommu.c                     |   2 +-
 drivers/mmc/core/block.c                      |   4 +-
 drivers/mtd/spi-nor/debugfs.c                 |   6 +-
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.c    |   4 +-
 drivers/parisc/ccio-dma.c                     |   2 +-
 drivers/parisc/sba_iommu.c                    |   2 +-
 drivers/scsi/sd.c                             |   8 +-
 drivers/staging/media/atomisp/pci/hmm/hmm.c   |   2 +-
 drivers/xen/grant-dma-ops.c                   |   2 +-
 drivers/xen/swiotlb-xen.c                     |   2 +-
 fs/xfs/kmem.c                                 |   4 +-
 fs/xfs/kmem.h                                 |  10 +-
 include/asm-generic/codetag.lds.h             |  14 +
 include/asm-generic/vmlinux.lds.h             |   3 +
 include/linux/alloc_tag.h                     | 188 +++++++++++++
 include/linux/codetag.h                       |  83 ++++++
 include/linux/dma-map-ops.h                   |   2 +-
 include/linux/fortify-string.h                |   5 +-
 include/linux/fs.h                            |   6 +-
 include/linux/gfp.h                           | 126 +++++----
 include/linux/gfp_types.h                     | 101 +++++--
 include/linux/memcontrol.h                    |  56 +++-
 include/linux/mempool.h                       |  73 +++--
 include/linux/mm.h                            |   8 +
 include/linux/mm_types.h                      |   4 +-
 include/linux/page_ext.h                      |   1 -
 include/linux/pagemap.h                       |   9 +-
 include/linux/percpu.h                        |  27 +-
 include/linux/pgalloc_tag.h                   | 105 +++++++
 include/linux/rhashtable-types.h              |  11 +-
 include/linux/sched.h                         |  24 ++
 include/linux/slab.h                          | 184 +++++++------
 include/linux/string.h                        |   4 +-
 include/linux/string_helpers.h                |  11 +-
 include/linux/vmalloc.h                       |  60 +++-
 init/Kconfig                                  |   4 +
 kernel/dma/mapping.c                          |   4 +-
 kernel/kallsyms_selftest.c                    |   2 +-
 kernel/module/main.c                          |  25 +-
 lib/Kconfig.debug                             |  31 +++
 lib/Makefile                                  |   3 +
 lib/alloc_tag.c                               | 213 +++++++++++++++
 lib/codetag.c                                 | 258 ++++++++++++++++++
 lib/rhashtable.c                              |  52 +++-
 lib/string_helpers.c                          |  22 +-
 lib/test-string_helpers.c                     |   4 +-
 mm/compaction.c                               |   7 +-
 mm/filemap.c                                  |   6 +-
 mm/huge_memory.c                              |   2 +
 mm/hugetlb.c                                  |   8 +-
 mm/kfence/core.c                              |  14 +-
 mm/kfence/kfence.h                            |   4 +-
 mm/memcontrol.c                               |  56 +---
 mm/mempolicy.c                                |  52 ++--
 mm/mempool.c                                  |  36 +--
 mm/mm_init.c                                  |  10 +
 mm/page_alloc.c                               |  66 +++--
 mm/page_ext.c                                 |  13 +
 mm/page_owner.c                               |   2 +-
 mm/percpu-internal.h                          |  26 +-
 mm/percpu.c                                   | 120 ++++----
 mm/show_mem.c                                 |  15 +
 mm/slab.h                                     | 176 ++++++++++--
 mm/slab_common.c                              |  65 ++++-
 mm/slub.c                                     | 138 ++++++----
 mm/util.c                                     |  44 +--
 mm/vmalloc.c                                  |  88 +++---
 scripts/kallsyms.c                            |  13 +
 scripts/module.lds.S                          |   7 +
 81 files changed, 2126 insertions(+), 695 deletions(-)
 create mode 100644 include/asm-generic/codetag.lds.h
 create mode 100644 include/linux/alloc_tag.h
 create mode 100644 include/linux/codetag.h
 create mode 100644 include/linux/pgalloc_tag.h
 create mode 100644 lib/alloc_tag.c
 create mode 100644 lib/codetag.c

-- 
2.43.0.687.g38aa6559b0-goog


