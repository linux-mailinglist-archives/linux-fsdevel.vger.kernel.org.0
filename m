Return-Path: <linux-fsdevel+bounces-13779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59008873E7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 19:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C458A1F22586
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FCB13EFE8;
	Wed,  6 Mar 2024 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKPO5f6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83113DB96
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749489; cv=none; b=GknBu9vOwectHg2dfNNV08I8CVwoTVXUOv5MDttr/0b1RTvIZPSU6RRvSw6+zCYE+3Gtxt535FazSeIvCF41MRLC2mxhVUujETRcqeLnTnvK3UWT11YiVHYFYzKKTkdn3EJjnDYTmTwFcDMIVO0zYrB+CEcUCupcH/vUPs+rcKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749489; c=relaxed/simple;
	bh=blX3Y28A7j/o5pvTG+xovM0sK0i27Mw46TmHlvlflKk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LauOHq15UWzrd5+P4c8VIJwUDWZVS/R8O0lBBemz2N739pWv6tXvmffmhGydUdj/ohu0DDFzxi7r3Ll9GyK2cNtHY28chKvjJzQsQH3KqOFzX05qglq5kK/bezYmxdzKIq2yNp1NA98pBQJ4/EqzfIhkaBahmwcF6IvG/OKk7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKPO5f6k; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so13924528276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 10:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749485; x=1710354285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RyFy+o939hhJJtOBz2smMq9dZDCMxXVMPA36WKy2XKs=;
        b=fKPO5f6kV2eJc01z/qP7My72z6YoTsY/z1AQQhnapbtFNJgE3TViOWtIvFTRikcm/Q
         tpONGUhXFjDWk4udUiHFuMtCNfpSJJZVHnRumMurSTyazcx/k3qiSB6iihFaOOsDzXJ6
         TP2KdMBZq8aKFpaFhFhlQ+nvqecYZqaDnw//1BFPeAEe1T/RtFayLHEFjQQoW8xKByHF
         p1ArCTMR7JxFNx1GauX3KklN/V9SKGwBdTHDfoqrqGKD+jz+VoIWohtg2rMq3E/Ouw5C
         Nrs9LdDaUD2uQh1YCu80RoCOoYTT1rCq5pUhARtuffCWnVDi4nSbUcAtwODPg7DUIRH2
         x5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749485; x=1710354285;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RyFy+o939hhJJtOBz2smMq9dZDCMxXVMPA36WKy2XKs=;
        b=dSqVdG/MVldWg7q6LMaK2OH7X0/veIPc0Hyhfr301rKGG9UjvsP3aTJeAm5F30oKhv
         KhpmlRpiIxEuz14N3mON40j0y2V66FgiUyhjU1RjM7uliwrE2zM5yMJWxxwhQOSGPcyY
         T0pmh+0ttLFIxpbq8RirDGanxemJNdqCMLYcOlNdKzsumDdzhN6NX+5gNAumTE2Uwu7I
         UrWkULZN/HcXcRE/hrV7LOwY2FV7gX5HWiHkNcionzNRgFIxKNBv51DzPws52x/K6+Vs
         fPLCrRysyS85xH2YEaHjCY5GxW81yuIhbljHZBTJN9GMC/NwRBO0UjHVHRUAuqi1SeQU
         WStQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGS1F4gnuH+EbYb72lGwOc/9Rcyg7aoQJnHATCdDs0SkhmG3kUWlVN3xhONyDXwskXSW2VB8LvSyjrc/wQ5DdzoET/MzXOo/uYSUBsrg==
X-Gm-Message-State: AOJu0Yyklkwih42ioytXs3ge3KxhHzMEcT7eJH/KwAzTwbEzPM7xgCE7
	OvIfcEogGLNjG+S4/k8NbsErzLaC55y3DUiNxJgyazLc/s+8lUa6jzcRc8xwUIl1wMo9K4epGFP
	S6A==
X-Google-Smtp-Source: AGHT+IFxWhscAtmHFqVARupfDbCnYirPYeuewmxRn+Ji3V4MrmINBlSy8mq1BztHmr3T3yFBdMS18fz4TYU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:1004:b0:dc2:3441:897f with SMTP id
 w4-20020a056902100400b00dc23441897fmr3842720ybt.6.1709749484713; Wed, 06 Mar
 2024 10:24:44 -0800 (PST)
Date: Wed,  6 Mar 2024 10:23:58 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-1-surenb@google.com>
Subject: [PATCH v5 00/37] Memory allocation profiling
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
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rebased over mm-unstable.

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

Since v4 [2]:
 - Added Reviewed-by, per Pasha Tatashin, Vlastimil Babka, Alice Ryhl
 - Changed slab_free_freelist_hook() to use __fastpath_inline,
   per Pasha Tatashin
 - Removed [3] as it is already Ack'ed and merged into in mm-unstable
 - Moved alloc_slab_obj_exts(), prepare_slab_obj_exts_hook() and
   alloc_tagging_slab_free_hook() into slub.c, per Vlastimil Babka
 - Removed drive-by spacing fixups, per Vlastimil Babka
 - Restored early memcg_kmem_online() check before calling
   free_slab_obj_exts(), per Vlastimil Babka
 - Added pr_warn() when module can't be unloaded, per Vlastimil Babka
 - Dropped __alloc_tag_sub() and alloc_tag_sub_noalloc(),
   per Vlastimil Babka
 - Fixed alloc_tag_add() to check for tag to be valid, per Vlastimil Babka
 - Moved alloc_tag_ref_set() where it's first used
 - Added a patch introducing a tristate early boot parameter,
   per Vlastimil Babka
 - Updated description for page splitting patch, per Vlastimil Babka
 - Added a patch fixing non-compound page accounting in __free_pages(),
   per Vlastimil Babka
 - Added early mem_alloc_profiling_enabled() checks in
   alloc_tagging_slab_free_hook() and prepare_slab_obj_exts_hook(),
   per Vlastimil Babka
 - Moved rust krealloc() helper patch before krealloc() is redefined,
   per Alice Ryhl
 - Replaced printk(KERN_NOTICE...) with pr_notice(), per Vlastimil Babka
 - Fixed codetag_{un}load_module() redefinition for CONFIG_MODULE=n,
   per kernel test robot
 - Updated documentation to describe new early boot parameter
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

[2] https://lore.kernel.org/all/20240221194052.927623-1-surenb@google.com/
[3] https://lore.kernel.org/all/20240221194052.927623-7-surenb@google.com/

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
 Documentation/mm/allocation-profiling.rst     |  91 +++++
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
 include/linux/slab.h                          | 175 +++++-----
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
 mm/page_alloc.c                               |  77 +++--
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
 123 files changed, 2305 insertions(+), 657 deletions(-)
 create mode 100644 Documentation/mm/allocation-profiling.rst
 create mode 100644 include/asm-generic/codetag.lds.h
 create mode 100644 include/linux/alloc_tag.h
 create mode 100644 include/linux/codetag.h
 create mode 100644 include/linux/pgalloc_tag.h
 create mode 100644 lib/alloc_tag.c
 create mode 100644 lib/codetag.c


base-commit: b38c34939fe4735b8716511f0a98814be3865a1b
-- 
2.44.0.278.ge034bb2e1d-goog


