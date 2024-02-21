Return-Path: <linux-fsdevel+bounces-12313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B28E85E772
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7D91C21E2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A327786641;
	Wed, 21 Feb 2024 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fd/mjNC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5042A8E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544459; cv=none; b=KTVP7SUAlwNEVf+wuF7+3SwYhpPM/2JGPeicMUqmn61RyvUJUobupwUQGLLL1RtYFHlA+MBXVEO3zOubQPx0JO3WQYkgnbj3cmDAfGMB/tmdHMTtHFM4M9mtbhFUytgS0hPPf9Fnsr38+Er2n9X5qs+v2A9PYyD1liL91cy9Bkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544459; c=relaxed/simple;
	bh=emENr+X+uZ1Ul41ljZMgTYHv1iHycxehP2uqNKKO0d8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XGPPWd1WQvTjec92e8fFTv8Gl/s7Zk9VG92BH3uivyO0BpLIDqlOrvhdT/vJSD1PhCmRRIaZxKQsdIeF+DD/0Xw+FxC+2kpuy0ZnQboLHf9237RJ8adpgyfyJSqBWCt6BOJ2191YVHc9aszTTxmU6X1rBZ5YHoU8XD/Q49iHrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fd/mjNC/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608886b1a3aso15384507b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544456; x=1709149256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h6iKERH6ntSMYXEOBWW++ghbM5EttVzR7SwASxK2UGU=;
        b=Fd/mjNC/TECZcJAo2NLTjTiB+YRvd4/qVtMMjiePc9vISBXWLl9quEMapatwTYdzNo
         fJ2ND/DNlFmDZGCtreGx8lelrIAfHffeAoxyBuQ8chIjD59Q3mNYtAamSbOhpVB7vHBB
         f2b0pRBXPcEDqMtjsMwacTzoPUeAz7CVdmQ4ZnH5oFO01QPD6eQx8gKegfI4SaKlP9VN
         9rYN5PFoMdxzGpFhA7DLLb1PzWCBXVoXZDZzMhzwBjrt5BGhB9oIfxhCfocC6YNcNQSf
         GXcUroBLS3tysH5z7xa8PA7AuBzQoarwz22W3w5h5RED+BBYZtpEbviI0MJrN3XcbqIt
         QyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544456; x=1709149256;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6iKERH6ntSMYXEOBWW++ghbM5EttVzR7SwASxK2UGU=;
        b=NCceZKcxVb4sxtsVuAqnV1PTUvDkyuq2QWBzm52vxynAeQAKXpt8MnOhSAhTWWgNSu
         pfcD8Rgbns8UADWUx/PtGRRPysU9qKdT4WOlHWghBxUlB50Ek0UiLJ9I92KHtnLMlroU
         JMQu0I7x22RP5c4b043DkfdV2c1a9FgwgNfl1vFrlJyq5kSAiF6AiQEk0XtlEUhRLJd9
         B1XS22f7bCicMfv0FZo4M7c1NVdhRRCcMIPIlJuXHvlCntCLbhPDyMsptan8lpBbOkIV
         jqQuV+axJvUUIOb+ZV8ebZDdb82FARqcCy2ye6H2Yy9SPLQOxuEKZfDLOtYtK81FEQrw
         ekww==
X-Forwarded-Encrypted: i=1; AJvYcCXKX55ZIPhIDw6k+p8wV8XOGCG+0neJMuH66hU3ze6gZCL8UEilcCiiZbrzoNAyT1S5mIef74nWwbBDoLBDTM8zJBLCCXyjX4qJZQZHgQ==
X-Gm-Message-State: AOJu0Yw3SL7XFBtR7jVHpvVZwWme2EKrQKti1zTwM5tLTtd8hjNFwTM+
	0cJwLKkCTmPZn+X++W1/yNd7QL2kzkjt1Eu7cJ+nEzOaFnkSmEyoP9Dhe/YCyFeeHi2aws6dUa/
	usg==
X-Google-Smtp-Source: AGHT+IERtCiqJmpfE+kOOdfj1tQRATSlaGrV4xShe/vfh3pjWvq23/f72b3b+6kHY2joSvf7k2m+y0djO/k=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a81:92ce:0:b0:607:74b2:579c with SMTP id
 j197-20020a8192ce000000b0060774b2579cmr4971839ywg.1.1708544456179; Wed, 21
 Feb 2024 11:40:56 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:13 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-1-surenb@google.com>
Subject: [PATCH v4 00/36] Memory allocation profiling
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

Since v3:
 - Dropped patch changing string_get_size() [2] as not needed
 - Dropped patch modifying xfs allocators [3] as non needed,
   per Dave Chinner
 - Added Reviewed-by, per Kees Cook
 - Moved prepare_slab_obj_exts_hook() and alloc_slab_obj_exts() where they
   are used, per Vlastimil Babka
 - Fixed SLAB_NO_OBJ_EXT definition to use unused bit, per Vlastimil Babka
 - Refactored patch [4] into other patches, per Vlastimil Babka
 - Replaced snprintf() with seq_buf_printf(), per Kees Cook
 - Changed output to report bytes, per Andrew Morton and Pasha Tatashin
 - Changed output to report [module] only for loadable modules,
   per Vlastimil Babka
 - Moved mem_alloc_profiling_enabled() check earlier, per Vlastimil Babka
 - Changed the code to handle page splitting to be more understandable,
   per Vlastimil Babka
 - Moved alloc_tagging_slab_free_hook(), mark_objexts_empty(),
   mark_failed_objexts_alloc() and handle_failed_objexts_alloc(),
   per Vlastimil Babka
 - Fixed loss of __alloc_size(1, 2) in kvmalloc functions,
   per Vlastimil Babka
 - Refactored the code in show_mem() to avoid memory allocations,
   per Michal Hocko
 - Changed to trylock in show_mem() to avoid blocking in atomic context,
   per Tetsuo Handa
 - Added mm mailing list into MAINTAINERS, per Kees Cook
 - Added base commit SHA, per Andy Shevchenko
 - Added a patch with documentation, per Jani Nikula
 - Fixed 0day bugs
 - Added benchmark results [5], per Steven Rostedt
 - Rebased over Linux 6.8-rc5

Items not yet addressed:
 - An early_boot option to prevent pageext overhead. We are looking into
   ways for using the same sysctr instead of adding additional early boot
   parameter.

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

[2] https://lore.kernel.org/all/20240212213922.783301-2-surenb@google.com/
[3] https://lore.kernel.org/all/20240212213922.783301-26-surenb@google.com/
[4] https://lore.kernel.org/all/20240212213922.783301-9-surenb@google.com/
[5] Benchmarks:

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

Suren Baghdasaryan (23):
  mm: enumerate all gfp flags
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

 Documentation/admin-guide/sysctl/vm.rst       |  16 +
 Documentation/filesystems/proc.rst            |  29 ++
 Documentation/mm/allocation-profiling.rst     |  86 ++++++
 MAINTAINERS                                   |  17 ++
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
 include/linux/alloc_tag.h                     | 195 ++++++++++++
 include/linux/codetag.h                       |  81 +++++
 include/linux/dma-map-ops.h                   |   2 +-
 include/linux/fortify-string.h                |   5 +-
 include/linux/fs.h                            |   6 +-
 include/linux/gfp.h                           | 126 +++++---
 include/linux/gfp_types.h                     | 101 +++++--
 include/linux/memcontrol.h                    |  56 +++-
 include/linux/mempool.h                       |  73 +++--
 include/linux/mm.h                            |   9 +
 include/linux/mm_types.h                      |   4 +-
 include/linux/page_ext.h                      |   1 -
 include/linux/pagemap.h                       |   9 +-
 include/linux/pds/pds_common.h                |   2 +
 include/linux/percpu.h                        |  27 +-
 include/linux/pgalloc_tag.h                   | 110 +++++++
 include/linux/rhashtable-types.h              |  11 +-
 include/linux/sched.h                         |  24 ++
 include/linux/slab.h                          | 175 +++++------
 include/linux/string.h                        |   4 +-
 include/linux/vmalloc.h                       |  60 +++-
 include/rdma/rdmavt_qp.h                      |   1 +
 init/Kconfig                                  |   4 +
 kernel/dma/mapping.c                          |   4 +-
 kernel/kallsyms_selftest.c                    |   2 +-
 kernel/module/main.c                          |  25 +-
 lib/Kconfig.debug                             |  31 ++
 lib/Makefile                                  |   3 +
 lib/alloc_tag.c                               | 204 +++++++++++++
 lib/codetag.c                                 | 283 ++++++++++++++++++
 lib/rhashtable.c                              |  28 +-
 mm/compaction.c                               |   7 +-
 mm/debug_vm_pgtable.c                         |   1 +
 mm/filemap.c                                  |   6 +-
 mm/huge_memory.c                              |   2 +
 mm/kfence/core.c                              |  14 +-
 mm/kfence/kfence.h                            |   4 +-
 mm/memcontrol.c                               |  56 +---
 mm/mempolicy.c                                |  52 ++--
 mm/mempool.c                                  |  36 +--
 mm/mm_init.c                                  |  13 +-
 mm/nommu.c                                    |  64 ++--
 mm/page_alloc.c                               |  66 ++--
 mm/page_ext.c                                 |  13 +
 mm/page_owner.c                               |   2 +-
 mm/percpu-internal.h                          |  26 +-
 mm/percpu.c                                   | 120 +++-----
 mm/show_mem.c                                 |  26 ++
 mm/slab.h                                     | 126 ++++++--
 mm/slab_common.c                              |   6 +-
 mm/slub.c                                     | 244 +++++++++++----
 mm/util.c                                     |  44 +--
 mm/vmalloc.c                                  |  88 +++---
 rust/helpers.c                                |   8 +
 scripts/kallsyms.c                            |  13 +
 scripts/module.lds.S                          |   7 +
 sound/pci/hda/cs35l41_hda.c                   |   1 +
 123 files changed, 2269 insertions(+), 682 deletions(-)
 create mode 100644 Documentation/mm/allocation-profiling.rst
 create mode 100644 include/asm-generic/codetag.lds.h
 create mode 100644 include/linux/alloc_tag.h
 create mode 100644 include/linux/codetag.h
 create mode 100644 include/linux/pgalloc_tag.h
 create mode 100644 lib/alloc_tag.c
 create mode 100644 lib/codetag.c


base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
-- 
2.44.0.rc0.258.g7320e95886-goog


