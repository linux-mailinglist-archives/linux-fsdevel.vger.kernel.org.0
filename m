Return-Path: <linux-fsdevel+bounces-72931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24344D061F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 21:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 157BE3045491
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 20:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F22733032F;
	Thu,  8 Jan 2026 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CUBIwEtM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96339330648
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904718; cv=none; b=gNSdyFS1jyZfL2Hzf5t9+ZBAGH+jxhfKz2oaoxZvmNHZf67S6b7aK3ohlobWLRhdwQhY0t/RFpNHTs87ZQQnsMF+YREl6LwBWoo/i171CQtNlNrB/YpVLM/K6KYN6cASEu9xumNgvXZD1+M7qq1Wsh0BvmQPm8Yq/pb4Fwr6HPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904718; c=relaxed/simple;
	bh=c/gsoPA1qi7y8pLF+dvyA8iXUBOT9HWWVXTbFcFFRno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6YkBLieNDlN4LmPHcxRDdu1ZGZSJHh7WbZe7QKEDfbGfYGB2KIaTTYa2CJscVSjKVsLp4P+b3qkwxV4ADf2AKJLWUgIjT7G85g8stxN4ASIZ1XMg0jx/PWSFc7s/8n5C9duYwShCnGJTgQvgk+slGmejrvSGAmJM5rBMMtII78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CUBIwEtM; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ffc5fa3d14so8620731cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 12:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767904715; x=1768509515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+FiscnY2dd9CMZcfeOt+saJiVQsfJ0OYuH1fa+Xrtc=;
        b=CUBIwEtMezAFTsr7nKdE2cQFCpk8+sFgukBxxvy98gOP+Ou9aVyRIk8DtZaZa2auQv
         IQp62xbbbNyhCKmOwhgrKWVNQiRNwyIUMycw457dSeycl1vACd5fyfG9V1nC761MtleF
         iaOPjGPXOkkfezn4Ju8F3qsJEByOH6mePQ80qflBR3aXNfc2Xhh+Zc3dFXh1liLpeYyY
         9ZUj1Tb0m4FldfC643KR+MN0EaZQLIcZ8VY5nYdjOkHejho8vBiPKpl51fCjlfNY3h8+
         JhV50umCOdRf+N824YmBatKtTlMSgUOKxl2OAsEGu2H72zocV8GUgB9xGSDMxpvB5xS2
         SR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904715; x=1768509515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+FiscnY2dd9CMZcfeOt+saJiVQsfJ0OYuH1fa+Xrtc=;
        b=QD1xVD8q4kSuHc/Vz97cpKJXZw/I05cbr7b+QTW29mqomCmBVpJDSFtw5ZzQQYbvpp
         IqHEImpdIi0UUb8RTh/IPoXmV7FfYIPOTMXHiQij8XRXljbkdFU3RUyRgS+y9XcZbF/i
         1DdxFRapOkFaqzG261vdmKPKoJxjNiukwVLv1Fle1N+oEDd07wJ6zR/Vysx57N07JXUN
         Di2pB8C0hooKH8Sr9hD5rUnnT4fXenexnlq9epAUsHD17xxR/9NSZGv5z/PQzWcubEOO
         ryik8F1H8WkXX4Y/gTexJYIq1KdTpGbtcgAfa/wBtD25VdBvu61UWYa/8JW9hfjSGtjH
         gkBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHMHIz8X6kcSSyUG/5Uc/LNfDZtCRnulxEgN1kqV5JKkIfvYf5jNGH2n+rbDVry6MiIZLV3f9cIS534UTz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw47ZngwtF+43ZrZY8gx1CtmQNKqxcD7VPtEq6a8nweav27dC7L
	7b30Ynfhr81Vc0Z+0IJfA7Y/at4douFNC+hFFR4YTrAzMr/EsA6Amv9ePPW/97qXrUg=
X-Gm-Gg: AY/fxX6nWS9fgkZpibOQmaw2zTiu1FnF1gYDtwwpVaQPQeYlQDsMRfMAPi6xZ0eg5O2
	x4DyYzRcwg2X5Vpu9kPrEvAxpf8QaahmPjSPk6HhMgY6u1jssi1go3QKtR0CTtUX4FL6kLakITV
	YZJP+MRsNiHfv28QM3OTG6+/jIfRtxgTjGMp3R2ok7ZgRw1xdy1czh0XMLovW+8yO8kCXw5T0F/
	cOvw0wd29PLCMjH+zbcbS2eJh2/6Iy52FNc0eCTTfGiW4/yVHepBr5RppW4Hzd/EojBO6QtT0gs
	/vhLFVgZ9RLcq598EIC1kFvTB81+wmGReM6D97LfDRFX5PA0Gol7P3gQ86ohJlrC7u/jZjG+SqC
	aDoNKf5SqYvE/NkI20FWczQkAMidmPQBRTzdswcDlqE1WPWdoxzRMmTHVm/O7QWYqYnd8dPf6JD
	4hfM6ucwej9iaVGwhRa9PYfI9ObxZ8bzWTcYCuBHMjKGF+Nrkv5aN5s08/KEzF+iZH2K+9aBQuv
	Yk=
X-Google-Smtp-Source: AGHT+IGgVKMRufuoIwNk6V89uYwrjMlLk/itQMcGhMZDRBQvLjiXAI9ku2u4EWxqz6DDG1P/QUPQlA==
X-Received: by 2002:a05:622a:181e:b0:4ee:49b8:fb81 with SMTP id d75a77b69052e-4ffb4a26a6dmr88539831cf.61.1767904715304;
        Thu, 08 Jan 2026 12:38:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm60483886d6.23.2026.01.08.12.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:38:34 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	ziy@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	osalvador@suse.de,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	zhengqi.arch@bytedance.com
Subject: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for device-managed memory
Date: Thu,  8 Jan 2026 15:37:47 -0500
Message-ID: <20260108203755.1163107-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces N_PRIVATE, a new node state for memory nodes 
whose memory is not intended for general system consumption.  Today,
device drivers (CXL, accelerators, etc.) hotplug their memory to access
mm/ services like page allocation and reclaim, but this exposes general
workloads to memory with different characteristics and reliability
guarantees than system RAM.

N_PRIVATE provides isolation by default while enabling explicit access
via __GFP_THISNODE for subsystems that understand how to manage these
specialized memory regions.

Motivation
==========

Several emerging memory technologies require kernel memory management
services but should not be used for general allocations:

  - CXL Compressed RAM (CRAM): Hardware-compressed memory where the
    effective capacity depends on data compressibility.  Uncontrolled
    use risks capacity exhaustion when compression ratios degrade.

  - Accelerator Memory: GPU/TPU-attached memory optimized for specific
    access patterns that are not intended for general allocation.

  - Tiered Memory: Memory intended only as a demotion target, not for
    initial allocations.

Currently, these devices either avoid hotplugging entirely (losing mm/
services) or hotplug as regular N_MEMORY (risking reliability issues).
N_PRIVATE solves this by creating an isolated node class.

Design
======

The series introduces:

  1. N_PRIVATE node state (mutually exclusive with N_MEMORY)
  2. private_memtype enum for policy-based access control
  3. cpuset.mems.sysram for user-visible isolation
  4. Integration points for subsystems (zswap demonstrated)
  5. A cxl private_region example to demonstrate full plumbing

Private Memory Types (private_memtype)
======================================

The private_memtype enum defines policy bits that control how different
kernel subsystems may access private nodes:

  enum private_memtype {
      NODE_MEM_NOTYPE,      /* No type assigned (invalid state) */
      NODE_MEM_ZSWAP,       /* Swap compression target */
      NODE_MEM_COMPRESSED,  /* General compressed RAM */
      NODE_MEM_ACCELERATOR, /* Accelerator-attached memory */
      NODE_MEM_DEMOTE_ONLY, /* Memory-tier demotion target only */
      NODE_MAX_MEMTYPE,
  };

These types serve as policy hints for subsystems:

NODE_MEM_ZSWAP
--------------
Nodes with this type are registered as zswap compression targets.  When
zswap compresses a page, it can allocate directly from ZSWAP-typed nodes
using __GFP_THISNODE, bypassing software compression if the device
provides hardware compression.

Example flow:
  1. CXL device creates private_region with type=zswap
  2. Driver calls node_register_private() with NODE_MEM_ZSWAP
  3. zswap_add_direct_node() registers the node as a compression target
  4. On swap-out, zswap allocates from the private node
  5. page_allocated() callback validates compression ratio headroom
  6. page_freed() callback zeros pages to improve device compression

Prototype Note:
  This patch set does not actually do compression ratio validation, as
  this requires an actual device to provide some kind of counter and/or
  interrupt to denote when allocations are safe.  The callbacks are
  left as stubs with TODOs for device vendors to pick up the next step
  (we'll continue with a QEMU example if reception is positive).

  For now, this always succeeds because compressed=real capacity.

NODE_MEM_COMPRESSED (CRAM)
--------------------------
For general compressed RAM devices.  Unlike ZSWAP nodes, CRAM nodes
could be exposed to subsystems that understand compression semantics:

  - vmscan: Could prefer demoting pages to CRAM nodes before swap
  - memory-tiering: Could place CRAM between DRAM and persistent memory
  - zram: Could use as backing store instead of or alongside zswap

Such a component (mm/cram.c) would differ from zswap or zram by allowing
the compressed pages to remain mapped Read-Only in the page table.

NODE_MEM_ACCELERATOR
--------------------
For GPU/TPU/accelerator-attached memory.  Policy implications:

  - Default allocations: Never (isolated from general page_alloc)
  - GPU drivers: Explicit allocation via __GFP_THISNODE
  - NUMA balancing: Excluded from automatic migration
  - Memory tiering: Not a demotion target

Some GPU vendors want management of their memory via NUMA nodes, but
don't want fallback or migration allocations to occur.  This enables
that pattern.

mm/mempolicy.c could be used to allow for N_PRIVATE nodes of this type
if the intent is per-vma access to accelerator memory (e.g. via mbind)
but this is omitted from this series from now to limit userland
exposure until first class examples are provided.

NODE_MEM_DEMOTE_ONLY
--------------------
For memory intended exclusively as a demotion target in memory tiering:

  - page_alloc: Never allocates initially (slab, page faults, etc.)
  - vmscan/reclaim: Valid demotion target during memory pressure
  - memory-tiering: Allow hotness monitoring/promotion for this region

This enables "cold storage" tiers using slower/cheaper memory (CXL-
attached DRAM, persistent memory in volatile mode) without the memory
appearing in allocation fast paths.

This also adds some additional bonus of enforcing memory placement on
these nodes to be movable allocations only (with all the normal caveats
around page pinning).

Subsystem Integration Points
============================

The private_node_ops structure provides callbacks for integration:

  struct private_node_ops {
      struct list_head list;
      resource_size_t res_start;
      resource_size_t res_end;
      enum private_memtype memtype;
      int (*page_allocated)(struct page *page, void *data);
      void (*page_freed)(struct page *page, void *data);
      void *data;
  };

page_allocated(): Called after allocation, returns 0 to accept or
-ENOSPC/-ENODEV to reject (caller retries elsewhere).  Enables:
  - Compression ratio enforcement for CRAM/zswap
  - Capacity tracking for accelerator memory
  - Rate limiting for demotion targets

page_freed(): Called on free, enables:
  - Zeroing for compression ratio recovery
  - Capacity accounting updates
  - Device-specific cleanup

Isolation Enforcement
=====================

The series modifies core allocators to respect N_PRIVATE isolation:

  - page_alloc: Constrains zone iteration to cpuset.mems.sysram
  - slub: Allocates only from N_MEMORY nodes
  - compaction: Skips N_PRIVATE nodes
  - mempolicy: Uses sysram_nodes for policy evaluation

__GFP_THISNODE bypasses isolation, enabling explicit access:

  page = alloc_pages_node(private_nid, GFP_KERNEL | __GFP_THISNODE, 0);

This pattern is used by zswap, and would be used by other subsystems
that explicitly opt into private node access.

User-Visible Changes
====================

cpuset gains cpuset.mems.sysram (read-only), shows N_MEMORY nodes.

ABI: /proc/<pid>/status Mems_allowed shows sysram nodes only.

Drivers create private regions via sysfs:
  echo region0 > /sys/bus/cxl/.../create_private_region
  echo zswap > /sys/bus/cxl/.../region0/private_type
  echo 1 > /sys/bus/cxl/.../region0/commit

Series Organization
===================

Patch 1: numa,memory_hotplug: create N_PRIVATE (Private Nodes)
  Core infrastructure: N_PRIVATE node state, node_mark_private(),
  private_memtype enum, and private_node_ops registration.

Patch 2: mm: constify oom_control, scan_control, and alloc_context 
nodemask
  Preparatory cleanup for enforcing that nodemasks don't change.

Patch 3: mm: restrict slub, compaction, and page_alloc to sysram
  Enforce N_MEMORY-only allocation for general paths.

Patch 4: cpuset: introduce cpuset.mems.sysram
  User-visible isolation via cpuset interface.

Patch 5: Documentation/admin-guide/cgroups: update docs for mems_allowed
  Document the new behavior and sysram_nodes.

Patch 6: drivers/cxl/core/region: add private_region
  CXL infrastructure for private regions.

Patch 7: mm/zswap: compressed ram direct integration
  Zswap integration demonstrating direct hardware compression.

Patch 8: drivers/cxl: add zswap private_region type
  Complete example: CXL region as zswap compression target.

Future Work
===========

This series provides the foundation.  Planned follow-ups include:

  - CRAM integration with vmscan for smart demotion
  - ACCELERATOR type for GPU memory management
  - Memory-tiering integration with DEMOTE_ONLY nodes

Testing
=======

All patches build cleanly.  Tested with:
  - CXL QEMU emulation with private regions
  - Zswap stress tests with private compression targets
  - Cpuset verification of mems.sysram isolation


Gregory Price (8):
  numa,memory_hotplug: create N_PRIVATE (Private Nodes)
  mm: constify oom_control, scan_control, and alloc_context nodemask
  mm: restrict slub, compaction, and page_alloc to sysram
  cpuset: introduce cpuset.mems.sysram
  Documentation/admin-guide/cgroups: update docs for mems_allowed
  drivers/cxl/core/region: add private_region
  mm/zswap: compressed ram direct integration
  drivers/cxl: add zswap private_region type

 .../admin-guide/cgroup-v1/cpusets.rst         |  19 +-
 Documentation/admin-guide/cgroup-v2.rst       |  26 ++-
 Documentation/filesystems/proc.rst            |   2 +-
 drivers/base/node.c                           | 199 ++++++++++++++++++
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/core.h                       |   4 +
 drivers/cxl/core/port.c                       |   4 +
 drivers/cxl/core/private_region/Makefile      |  12 ++
 .../cxl/core/private_region/private_region.c  | 129 ++++++++++++
 .../cxl/core/private_region/private_region.h  |  14 ++
 drivers/cxl/core/private_region/zswap.c       | 127 +++++++++++
 drivers/cxl/core/region.c                     |  63 +++++-
 drivers/cxl/cxl.h                             |  22 ++
 include/linux/cpuset.h                        |  24 ++-
 include/linux/gfp.h                           |   6 +
 include/linux/mm.h                            |   4 +-
 include/linux/mmzone.h                        |   6 +-
 include/linux/node.h                          |  60 ++++++
 include/linux/nodemask.h                      |   1 +
 include/linux/oom.h                           |   2 +-
 include/linux/swap.h                          |   2 +-
 include/linux/zswap.h                         |   5 +
 kernel/cgroup/cpuset-internal.h               |   8 +
 kernel/cgroup/cpuset-v1.c                     |   8 +
 kernel/cgroup/cpuset.c                        |  98 ++++++---
 mm/compaction.c                               |   6 +-
 mm/internal.h                                 |   2 +-
 mm/memcontrol.c                               |   2 +-
 mm/memory_hotplug.c                           |   2 +-
 mm/mempolicy.c                                |   6 +-
 mm/migrate.c                                  |   4 +-
 mm/mmzone.c                                   |   5 +-
 mm/page_alloc.c                               |  31 +--
 mm/show_mem.c                                 |   9 +-
 mm/slub.c                                     |   8 +-
 mm/vmscan.c                                   |   6 +-
 mm/zswap.c                                    | 106 +++++++++-
 37 files changed, 942 insertions(+), 91 deletions(-)
 create mode 100644 drivers/cxl/core/private_region/Makefile
 create mode 100644 drivers/cxl/core/private_region/private_region.c
 create mode 100644 drivers/cxl/core/private_region/private_region.h
 create mode 100644 drivers/cxl/core/private_region/zswap.c
---
base-commit: 803dd4b1159cf9864be17aab8a17653e6ecbbbb6

-- 
2.52.0

