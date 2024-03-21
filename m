Return-Path: <linux-fsdevel+bounces-14978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA60885DA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE9A281C25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 16:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8741804C;
	Thu, 21 Mar 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u803RRbo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207D8BF3
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039033; cv=none; b=KPSp3okLwMDqA8KOoG2sxPECGZGdEglr87FdsLUA/G5AafHtNINKH32SIbLe8XEZ7mlg2Z4c5JJbyt19LmWiQHM5dZL+5hmY6R8QzfGfQfwQy1rYyoBY9aRoNUaqT2QK0ffyfys9fR50TUfyzDpUadVmU84x09ejwjhXTFlKGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039033; c=relaxed/simple;
	bh=nXfkaShWfd/omgr6oAsoNsZp6U4Qoov4BwwUpupeQWU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q4hLTo0j0uJUI7c4npYUZAoC/jO6EaGQLBC6YUEauiks8cikTVIbhjhRAv4KCp7F+Wkc0l5P5IlPsXNALLxyFT/qayVXntZkTjZat0uPPcWX3VzLhv4/s94eU5hCPdDGHO1vlNjkWSHIafaPLjMsbkS6zQBZUj+t7Q4wZ37JJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u803RRbo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so1520332276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039030; x=1711643830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZtzEdHMO1nsPqRyTOFCp2rzxqc4SYrWbhYHVl+Yksck=;
        b=u803RRboTmbeXp/Lp544dIKtYPZsmohtBlHOopJOZPTlQ085+hj5iMLhDK40ypxqOz
         vWaTrSy0nR0+ahRwgeFl+5NAUgOsh/V/jKORGGGhKEhKdskt+LJee+uQGreoCfoXNJPE
         E7/F0oGkkrzqaaCnzdkJVdmkRfAWp9QP03S3B09jEyZnCD3nnOGsJ0jXKY+lqrUGqyu2
         L8PwU6eR/STY4QHo0S2mGUkMwD/sk3Ab9Ocqbhey+N4WW3p6LMh5p1ljRRE7a5gnMWBB
         rnEM5nSLQG1tkOTkqmViP0Ab6sW97+8L92/Z+po+AZlmzYZKMIe9AHVFKJaPdSq63cNV
         c9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039030; x=1711643830;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtzEdHMO1nsPqRyTOFCp2rzxqc4SYrWbhYHVl+Yksck=;
        b=Rm1Q4dMKLgr633glRJtHxtQORqD0q6X6Z3JARh9TevCzmqb5pMRRk8EBEf3+uVQej8
         587xn8L1OGsUu7f2yfrnBh9s8KcQLYgNxIDa6JsjwKfUw17peBcLPCRg2rgqKl/PG1r5
         LNbCe/l6K7fRG6v+7l8qsiUnPQpcg9lKdRPdM5FVfca49Cpqv/a4htLHemCffMMHPPMw
         Npmg6x/OYxj5RhSQVb0ZyUkhsx1N4YVnYjDQo9EYty8hc/LN/QyDZFUr+8rwYnVyDS+F
         +hrbdn1tce+qcAwzbg8n/xIGMeBCkY23Uyk4ZmSc4GPMoj8E5KG3X/Te+KQbrlx2MD0+
         DFBw==
X-Forwarded-Encrypted: i=1; AJvYcCVN5wWM2CYlUEDMtKVXziRJPtVWwqJSGNB42r35vrwEmvDW4aNFoTN30Y+RrDP+QIK7DwRW3RDLMPIzBn1SjymOrYwpUWjBPsrZz+RpHA==
X-Gm-Message-State: AOJu0YwYlgUl6PeFogmOBuFoH1CQQ3Btu+nRx0MkVM8xGTdHTfXG9tUh
	cDnBZ7KC05petD/aHk8E/wTFQo2trxkpJyu1z/ZowWiXt8a96Z5nQT0bcdwvbi4cJxzVcv8yqmr
	nXQ==
X-Google-Smtp-Source: AGHT+IHC69SQYVxvQ0JKFgn+XWn9kaco/tScCGiE8oHLMd2EppB6ElBhL02cnw+DSbIGpnq6CyJeTlj0IbA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:11cc:b0:dd9:2789:17fb with SMTP id
 n12-20020a05690211cc00b00dd9278917fbmr720533ybu.3.1711039030449; Thu, 21 Mar
 2024 09:37:10 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:22 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-1-surenb@google.com>
Subject: [PATCH v6 00/37] Memory allocation profiling
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Overview:
Low overhead [1] per-callsite memory allocation profiling. Not just for
debug kernels, overhead low enough to be deployed in production.

Example output:
  root@moria-kvm:~# sort -rn /proc/allocinfo
   127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
    56373248     4737 mm/slub.c:2259 func:alloc_slab_page
    14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
    14417920     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
    13377536      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
    11718656     2861 mm/filemap.c:1919 func:__filemap_get_folio
     9192960     2800 kernel/fork.c:307 func:alloc_thread_stack_node
     4206592        4 net/netfilter/nf_conntrack_core.c:2567 func:nf_ct_alloc_hashtable
     4136960     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod] func:ctagmod_start
     3940352      962 mm/memory.c:4214 func:alloc_anon_folio
     2894464    22613 fs/kernfs/dir.c:615 func:__kernfs_new_node
     ...

Since v5 [2]:
- Added Reviewed-by and Acked-by, per Vlastimil Babka and Miguel Ojeda
- Changed pgalloc_tag_{add|sub} to use number of pages instead of order, per Matthew Wilcox
- Changed pgalloc_tag_sub_bytes to pgalloc_tag_sub_pages and adjusted the usage, per Matthew Wilcox
- Moved static key check before prepare_slab_obj_exts_hook(), per Vlastimil Babka
- Fixed RUST helper, per Miguel Ojeda
- Fixed documentation, per Randy Dunlap
- Rebased over mm-unstable

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
(6) Disabled by default (CONFIG_MEM_ALLOC_PROFILING=y &&
    CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=n)  && CONFIG_MEMCG_KMEM=y
(7) Enabled by default (CONFIG_MEM_ALLOC_PROFILING=y &&
    CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=y) && CONFIG_MEMCG_KMEM=y

Performance overhead:
To evaluate performance we implemented an in-kernel test executing
multiple get_free_page/free_page and kmalloc/kfree calls with allocation
sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
affinity set to a specific CPU to minimize the noise. Below are results
from running the test on Ubuntu 22.04.2 LTS with 6.8.0-rc1 kernel on
56 core Intel Xeon:

                        kmalloc                 pgalloc
(1 baseline)            6.764s                  16.902s
(2 default disabled)    6.793s  (+0.43%)        17.007s (+0.62%)
(3 default enabled)     7.197s  (+6.40%)        23.666s (+40.02%)
(4 runtime enabled)     7.405s  (+9.48%)        23.901s (+41.41%)
(5 memcg)               13.388s (+97.94%)       48.460s (+186.71%)
(6 def disabled+memcg)  13.332s (+97.10%)       48.105s (+184.61%)
(7 def enabled+memcg)   13.446s (+98.78%)       54.963s (+225.18%)

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

Benchmarks:

Hackbench tests run 100 times:
hackbench -s 512 -l 200 -g 15 -f 25 -P
      baseline       disabled profiling           enabled profiling
avg   0.3543         0.3559 (+0.0016)             0.3566 (+0.0023)
stdev 0.0137         0.0188                       0.0077


hackbench -l 10000
      baseline       disabled profiling           enabled profiling
avg   6.4218         6.4306 (+0.0088)             6.5077 (+0.0859)
stdev 0.0933         0.0286                       0.0489

stress-ng tests:
stress-ng --class memory --seq 4 -t 60
stress-ng --class cpu --seq 4 -t 60
Results posted at: https://evilpiepirate.org/~kent/memalloc_prof_v4_stress-ng/

[2] https://lore.kernel.org/all/20240306182440.2003814-1-surenb@google.com/

Kent Overstreet (13):
  fix missing vmalloc.h includes
  asm-generic/io.h: Kill vmalloc.h dependency
  mm/slub: Mark slab_free_freelist_hook() __always_inline
  scripts/kallysms: Always include __start and __stop symbols
  fs: Convert alloc_inode_sb() to a macro
  rust: Add a rust helper for krealloc()
  mempool: Hook up to memory allocation profiling
  mm: percpu: Introduce pcpuobj_ext
  mm: percpu: Add codetag reference into pcpuobj_ext
  mm: vmalloc: Enable memory allocation profiling
  rhashtable: Plumb through alloc tag
  MAINTAINERS: Add entries for code tagging and memory allocation
    profiling
  memprofiling: Documentation

Suren Baghdasaryan (24):
  mm: introduce slabobj_ext to support slab object extensions
  mm: introduce __GFP_NO_OBJ_EXT flag to selectively prevent slabobj_ext
    creation
  mm/slab: introduce SLAB_NO_OBJ_EXT to avoid obj_ext creation
  slab: objext: introduce objext_flags as extension to
    page_memcg_data_flags
  lib: code tagging framework
  lib: code tagging module support
  lib: prevent module unloading if memory is not freed
  lib: add allocation tagging support for memory allocation profiling
  lib: introduce support for page allocation tagging
  lib: introduce early boot parameter to avoid page_ext memory overhead
  mm: percpu: increase PERCPU_MODULE_RESERVE to accommodate allocation
    tags
  change alloc_pages name in dma_map_ops to avoid name conflicts
  mm: enable page allocation tagging
  mm: create new codetag references during page splitting
  mm: fix non-compound multi-order memory accounting in __free_pages
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

 Documentation/admin-guide/sysctl/vm.rst       |  16 +
 Documentation/filesystems/proc.rst            |  29 ++
 Documentation/mm/allocation-profiling.rst     | 100 ++++++
 Documentation/mm/index.rst                    |   1 +
 MAINTAINERS                                   |  17 +
 arch/alpha/kernel/pci_iommu.c                 |   2 +-
 arch/alpha/lib/checksum.c                     |   1 +
 arch/alpha/lib/fpreg.c                        |   1 +
 arch/alpha/lib/memcpy.c                       |   1 +
 arch/arm/kernel/irq.c                         |   1 +
 arch/arm/kernel/traps.c                       |   1 +
 arch/arm64/kernel/efi.c                       |   1 +
 arch/loongarch/include/asm/kfence.h           |   1 +
 arch/mips/jazz/jazzdma.c                      |   2 +-
 arch/powerpc/kernel/dma-iommu.c               |   2 +-
 arch/powerpc/kernel/iommu.c                   |   1 +
 arch/powerpc/mm/mem.c                         |   1 +
 arch/powerpc/platforms/ps3/system-bus.c       |   4 +-
 arch/powerpc/platforms/pseries/vio.c          |   2 +-
 arch/riscv/kernel/elf_kexec.c                 |   1 +
 arch/riscv/kernel/probes/kprobes.c            |   1 +
 arch/s390/kernel/cert_store.c                 |   1 +
 arch/s390/kernel/ipl.c                        |   1 +
 arch/x86/include/asm/io.h                     |   1 +
 arch/x86/kernel/amd_gart_64.c                 |   2 +-
 arch/x86/kernel/cpu/sgx/main.c                |   1 +
 arch/x86/kernel/irq_64.c                      |   1 +
 arch/x86/mm/fault.c                           |   1 +
 drivers/accel/ivpu/ivpu_mmu_context.c         |   1 +
 drivers/gpu/drm/gma500/mmu.c                  |   1 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     |   1 +
 .../gpu/drm/i915/gem/selftests/mock_dmabuf.c  |   1 +
 drivers/gpu/drm/i915/gt/shmem_utils.c         |   1 +
 drivers/gpu/drm/i915/gvt/firmware.c           |   1 +
 drivers/gpu/drm/i915/gvt/gtt.c                |   1 +
 drivers/gpu/drm/i915/gvt/handlers.c           |   1 +
 drivers/gpu/drm/i915/gvt/mmio.c               |   1 +
 drivers/gpu/drm/i915/gvt/vgpu.c               |   1 +
 drivers/gpu/drm/i915/intel_gvt.c              |   1 +
 drivers/gpu/drm/imagination/pvr_vm_mips.c     |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_gem.c        |   1 +
 drivers/gpu/drm/omapdrm/omap_gem.c            |   1 +
 drivers/gpu/drm/v3d/v3d_bo.c                  |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c       |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c           |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_devcaps.c       |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c       |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c         |   1 +
 drivers/gpu/drm/xen/xen_drm_front_gem.c       |   1 +
 drivers/hwtracing/coresight/coresight-trbe.c  |   1 +
 drivers/iommu/dma-iommu.c                     |   2 +-
 .../marvell/octeon_ep/octep_pfvf_mbox.c       |   1 +
 .../marvell/octeon_ep_vf/octep_vf_mbox.c      |   1 +
 .../net/ethernet/microsoft/mana/hw_channel.c  |   1 +
 drivers/parisc/ccio-dma.c                     |   2 +-
 drivers/parisc/sba_iommu.c                    |   2 +-
 drivers/platform/x86/uv_sysfs.c               |   1 +
 drivers/scsi/mpi3mr/mpi3mr_transport.c        |   2 +
 drivers/staging/media/atomisp/pci/hmm/hmm.c   |   2 +-
 drivers/vfio/pci/pds/dirty.c                  |   1 +
 drivers/virt/acrn/mm.c                        |   1 +
 drivers/virtio/virtio_mem.c                   |   1 +
 drivers/xen/grant-dma-ops.c                   |   2 +-
 drivers/xen/swiotlb-xen.c                     |   2 +-
 include/asm-generic/codetag.lds.h             |  14 +
 include/asm-generic/io.h                      |   1 -
 include/asm-generic/vmlinux.lds.h             |   3 +
 include/linux/alloc_tag.h                     | 205 +++++++++++
 include/linux/codetag.h                       |  81 +++++
 include/linux/dma-map-ops.h                   |   2 +-
 include/linux/fortify-string.h                |   5 +-
 include/linux/fs.h                            |   6 +-
 include/linux/gfp.h                           | 126 ++++---
 include/linux/gfp_types.h                     |  11 +
 include/linux/memcontrol.h                    |  56 ++-
 include/linux/mempool.h                       |  73 ++--
 include/linux/mm.h                            |   9 +
 include/linux/mm_types.h                      |   4 +-
 include/linux/page_ext.h                      |   1 -
 include/linux/pagemap.h                       |   9 +-
 include/linux/pds/pds_common.h                |   2 +
 include/linux/percpu.h                        |  27 +-
 include/linux/pgalloc_tag.h                   | 134 +++++++
 include/linux/rhashtable-types.h              |  11 +-
 include/linux/sched.h                         |  24 ++
 include/linux/slab.h                          | 179 +++++-----
 include/linux/string.h                        |   4 +-
 include/linux/vmalloc.h                       |  60 +++-
 include/rdma/rdmavt_qp.h                      |   1 +
 init/Kconfig                                  |   4 +
 kernel/dma/mapping.c                          |   4 +-
 kernel/kallsyms_selftest.c                    |   2 +-
 kernel/module/main.c                          |  29 +-
 lib/Kconfig.debug                             |  31 ++
 lib/Makefile                                  |   3 +
 lib/alloc_tag.c                               | 243 +++++++++++++
 lib/codetag.c                                 | 283 +++++++++++++++
 lib/rhashtable.c                              |  28 +-
 mm/compaction.c                               |   7 +-
 mm/debug_vm_pgtable.c                         |   1 +
 mm/filemap.c                                  |   6 +-
 mm/huge_memory.c                              |   2 +
 mm/kfence/core.c                              |  14 +-
 mm/kfence/kfence.h                            |   4 +-
 mm/memcontrol.c                               |  56 +--
 mm/mempolicy.c                                |  52 +--
 mm/mempool.c                                  |  36 +-
 mm/mm_init.c                                  |  13 +-
 mm/nommu.c                                    |  64 ++--
 mm/page_alloc.c                               |  71 ++--
 mm/page_ext.c                                 |  13 +
 mm/page_owner.c                               |   2 +-
 mm/percpu-internal.h                          |  26 +-
 mm/percpu.c                                   | 120 +++----
 mm/show_mem.c                                 |  26 ++
 mm/slab.h                                     |  51 ++-
 mm/slab_common.c                              |   6 +-
 mm/slub.c                                     | 327 +++++++++++++++---
 mm/util.c                                     |  44 +--
 mm/vmalloc.c                                  |  88 ++---
 rust/helpers.c                                |   8 +
 scripts/kallsyms.c                            |  13 +
 scripts/module.lds.S                          |   7 +
 sound/pci/hda/cs35l41_hda.c                   |   1 +
 125 files changed, 2319 insertions(+), 652 deletions(-)
 create mode 100644 Documentation/mm/allocation-profiling.rst
 create mode 100644 include/asm-generic/codetag.lds.h
 create mode 100644 include/linux/alloc_tag.h
 create mode 100644 include/linux/codetag.h
 create mode 100644 include/linux/pgalloc_tag.h
 create mode 100644 lib/alloc_tag.c
 create mode 100644 lib/codetag.c


base-commit: a824831a082f1d8f9b51a4c0598e633d38555fcf
-- 
2.44.0.291.gc1ea87d7ee-goog


