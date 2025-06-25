Return-Path: <linux-fsdevel+bounces-53031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1866AE92B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283523BF988
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BAC2E1C5D;
	Wed, 25 Jun 2025 23:28:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kanga.kvack.org (kanga.kvack.org [205.233.56.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B952DD5FE;
	Wed, 25 Jun 2025 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.233.56.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750894113; cv=none; b=tJHpoS0wg0shGbWFrKaDYC1ahp2IK/fbj3PVTJUsFvA/cr4j8LxE6haUdlYj2qa5PSKRHpGfqqMnqAgGhpL3fDBjdUnM3F2p3VAf019NYaOA8cLRKOG070eeUlKGkhdDMT4eZ8ZLsXahcctMFVwu+pR4dw2S09kHBn2t2IpDqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750894113; c=relaxed/simple;
	bh=VACyL9SVZH+oXMgnnFUVknN0C0rVL/YKqH0xVwx4xpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLgBs4jbUS5Pw6NmekQKx2+3E4jIt/NIuw3DbHFoIOefRjW5+jek+TkK9VZSnxWQh+aa0GfXw0XMB9eozsvrYw+hELZHYUEeoRz0fFOcNrVT9lKxnAHzPDTlpMQgLnMXhcGYQYA7R+AfC192mBSg6V44aHJLsaU9HWRli0W+UGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kvack.org; spf=pass smtp.mailfrom=kvack.org; arc=none smtp.client-ip=205.233.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kvack.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvack.org
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id 0A1446B00F8; Wed, 25 Jun 2025 19:26:53 -0400 (EDT)
Date: Wed, 25 Jun 2025 19:26:53 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 00/32] Live Update Orchestrator
Message-ID: <20250625232653.GJ369@kvack.org>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.4.2.2i

FYI: Every one of your emails to the list for this series was bounced by
all the recipients using @gmail.com email addresses.

		-ben (owner-linux-mm)

On Wed, Jun 25, 2025 at 11:17:47PM +0000, Pasha Tatashin wrote:
> This series introduces the LUO, a kernel subsystem designed to
> facilitate live kernel updates with minimal downtime,
> particularly in cloud delplyoments aiming to update without fully
> disrupting running virtual machines.
> 
> This series builds upon KHO framework by adding programmatic
> control over KHO's lifecycle and leveraging KHO for persisting LUO's
> own metadata across the kexec boundary. The git branch for this series
> can be found at:
> 
> https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v1
> 
> Changelog from rfc-v2:
> - Addressed review comments from Mike Rapoport, Pratyush Yadav,
>   David Matlack
> - Moved everything under kernel/liveupdate including KHO.
> - Added a number fixes to KHO that were discovered.
> - luo_files is not a registred as a subsystem.
> - Added sessions support to preserved files.
> - Added support for memfd (Pratyush Yadav)
> - Added libluo (proposed as RFC) (Pratyush Yadav)
> - Removed notifiers from KHO (Mike Rapoport)
> 
> What is Live Update?
> Live Update is a kexec based reboot process where selected kernel
> resources (memory, file descriptors, and eventually devices) are kept
> operational or their state preserved across a kernel transition. For
> certain resources, DMA and interrupt activity might continue with
> minimal interruption during the kernel reboot.
> 
> LUO provides a framework for coordinating live updates. It features:
> State Machine: Manages the live update process through states:
> NORMAL, PREPARED, FROZEN, UPDATED.
> 
> KHO Integration:
> 
> LUO programmatically drives KHO's finalization and abort sequences.
> KHO's debugfs interface is now optional configured via
> CONFIG_KEXEC_HANDOVER_DEBUG.
> 
> LUO preserves its own metadata via KHO's kho_add_subtree and
> kho_preserve_phys() mechanisms.
> 
> Subsystem Participation: A callback API liveupdate_register_subsystem()
> allows kernel subsystems (e.g., KVM, IOMMU, VFIO, PCI) to register
> handlers for LUO events (PREPARE, FREEZE, FINISH, CANCEL) and persist a
> u64 payload via the LUO FDT.
> 
> File Descriptor Preservation: Infrastructure
> liveupdate_register_filesystem, luo_register_file, luo_retrieve_file to
> allow specific types of file descriptors (e.g., memfd, vfio) to be
> preserved and restored.
> 
> Handlers for specific file types can be registered to manage their
> preservation and restoration, storing a u64 payload in the LUO FDT.
> 
> User-space Interface:
> 
> ioctl (/dev/liveupdate): The primary control interface for
> triggering LUO state transitions (prepare, freeze, finish, cancel)
> and managing the preservation/restoration of file descriptors.
> Access requires CAP_SYS_ADMIN.
> 
> sysfs (/sys/kernel/liveupdate/state): A read-only interface for
> monitoring the current LUO state. This allows userspace services to
> track progress and coordinate actions.
> 
> Selftests: Includes kernel-side hooks and userspace selftests to
> verify core LUO functionality, particularly subsystem registration and
> basic state transitions.
> 
> LUO State Machine and Events:
> 
> NORMAL:   Default operational state.
> PREPARED: Initial preparation complete after LIVEUPDATE_PREPARE
>           event. Subsystems have saved initial state.
> FROZEN:   Final "blackout window" state after LIVEUPDATE_FREEZE
>           event, just before kexec. Workloads must be suspended.
> UPDATED:  Next kernel has booted via live update. Awaiting restoration
>           and LIVEUPDATE_FINISH.
> 
> Events:
> LIVEUPDATE_PREPARE: Prepare for reboot, serialize state.
> LIVEUPDATE_FREEZE:  Final opportunity to save state before kexec.
> LIVEUPDATE_FINISH:  Post-reboot cleanup in the next kernel.
> LIVEUPDATE_CANCEL:  Abort prepare or freeze, revert changes.
> 
> RFC v1: https://lore.kernel.org/all/20250320024011.2995837-1-pasha.tatashin@soleen.com
> RFC v2: https://lore.kernel.org/all/20250515182322.117840-1-pasha.tatashin@soleen.com/
> 
> Changyuan Lyu (1):
>   kho: add interfaces to unpreserve folios and physical memory ranges
> 
> Mike Rapoport (Microsoft) (1):
>   kho: drop notifiers
> 
> Pasha Tatashin (22):
>   kho: init new_physxa->phys_bits to fix lockdep
>   kho: mm: Don't allow deferred struct page with KHO
>   kho: warn if KHO is disabled due to an error
>   kho: allow to drive kho from within kernel
>   kho: make debugfs interface optional
>   kho: don't unpreserve memory during abort
>   liveupdate: kho: move to kernel/liveupdate
>   liveupdate: luo_core: Live Update Orchestrator
>   liveupdate: luo_core: integrate with KHO
>   liveupdate: luo_subsystems: add subsystem registration
>   liveupdate: luo_subsystems: implement subsystem callbacks
>   liveupdate: luo_files: add infrastructure for FDs
>   liveupdate: luo_files: implement file systems callbacks
>   liveupdate: luo_ioctl: add ioctl interface
>   liveupdate: luo_sysfs: add sysfs state monitoring
>   reboot: call liveupdate_reboot() before kexec
>   liveupdate: luo_files: luo_ioctl: session-based file descriptor
>     tracking
>   kho: move kho debugfs directory to liveupdate
>   liveupdate: add selftests for subsystems un/registration
>   selftests/liveupdate: add subsystem/state tests
>   docs: add luo documentation
>   MAINTAINERS: add liveupdate entry
> 
> Pratyush Yadav (8):
>   mm: shmem: use SHMEM_F_* flags instead of VM_* flags
>   mm: shmem: allow freezing inode mapping
>   mm: shmem: export some functions to internal.h
>   luo: allow preserving memfd
>   docs: add documentation for memfd preservation via LUO
>   tools: introduce libluo
>   libluo: introduce luoctl
>   libluo: add tests
> 
>  .../ABI/testing/sysfs-kernel-liveupdate       |  51 +
>  Documentation/admin-guide/index.rst           |   1 +
>  Documentation/admin-guide/liveupdate.rst      |  16 +
>  Documentation/core-api/index.rst              |   1 +
>  Documentation/core-api/kho/concepts.rst       |   2 +-
>  Documentation/core-api/liveupdate.rst         |  57 ++
>  Documentation/mm/index.rst                    |   1 +
>  Documentation/mm/memfd_preservation.rst       | 138 +++
>  Documentation/userspace-api/index.rst         |   1 +
>  .../userspace-api/ioctl/ioctl-number.rst      |   2 +
>  Documentation/userspace-api/liveupdate.rst    |  25 +
>  MAINTAINERS                                   |  20 +-
>  include/linux/kexec_handover.h                |  53 +-
>  include/linux/liveupdate.h                    | 235 +++++
>  include/linux/shmem_fs.h                      |  23 +
>  include/uapi/linux/liveupdate.h               | 265 +++++
>  init/Kconfig                                  |   2 +
>  kernel/Kconfig.kexec                          |  14 -
>  kernel/Makefile                               |   2 +-
>  kernel/liveupdate/Kconfig                     |  90 ++
>  kernel/liveupdate/Makefile                    |  13 +
>  kernel/{ => liveupdate}/kexec_handover.c      | 556 +++++-----
>  kernel/liveupdate/kexec_handover_debug.c      | 222 ++++
>  kernel/liveupdate/kexec_handover_internal.h   |  45 +
>  kernel/liveupdate/luo_core.c                  | 525 ++++++++++
>  kernel/liveupdate/luo_files.c                 | 946 ++++++++++++++++++
>  kernel/liveupdate/luo_internal.h              |  47 +
>  kernel/liveupdate/luo_ioctl.c                 | 192 ++++
>  kernel/liveupdate/luo_selftests.c             | 344 +++++++
>  kernel/liveupdate/luo_selftests.h             |  84 ++
>  kernel/liveupdate/luo_subsystems.c            | 420 ++++++++
>  kernel/liveupdate/luo_sysfs.c                 |  92 ++
>  kernel/reboot.c                               |   4 +
>  mm/Makefile                                   |   1 +
>  mm/internal.h                                 |   6 +
>  mm/memblock.c                                 |  56 +-
>  mm/memfd_luo.c                                | 501 ++++++++++
>  mm/shmem.c                                    |  46 +-
>  tools/lib/luo/LICENSE                         | 165 +++
>  tools/lib/luo/Makefile                        |  45 +
>  tools/lib/luo/README.md                       | 166 +++
>  tools/lib/luo/cli/.gitignore                  |   1 +
>  tools/lib/luo/cli/Makefile                    |  18 +
>  tools/lib/luo/cli/luoctl.c                    | 178 ++++
>  tools/lib/luo/include/libluo.h                | 128 +++
>  tools/lib/luo/include/liveupdate.h            | 265 +++++
>  tools/lib/luo/libluo.c                        | 203 ++++
>  tools/lib/luo/tests/.gitignore                |   1 +
>  tools/lib/luo/tests/Makefile                  |  18 +
>  tools/lib/luo/tests/test.c                    | 848 ++++++++++++++++
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/liveupdate/.gitignore |   1 +
>  tools/testing/selftests/liveupdate/Makefile   |   7 +
>  tools/testing/selftests/liveupdate/config     |   6 +
>  .../testing/selftests/liveupdate/liveupdate.c | 356 +++++++
>  55 files changed, 7091 insertions(+), 415 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-liveupdate
>  create mode 100644 Documentation/admin-guide/liveupdate.rst
>  create mode 100644 Documentation/core-api/liveupdate.rst
>  create mode 100644 Documentation/mm/memfd_preservation.rst
>  create mode 100644 Documentation/userspace-api/liveupdate.rst
>  create mode 100644 include/linux/liveupdate.h
>  create mode 100644 include/uapi/linux/liveupdate.h
>  create mode 100644 kernel/liveupdate/Kconfig
>  create mode 100644 kernel/liveupdate/Makefile
>  rename kernel/{ => liveupdate}/kexec_handover.c (74%)
>  create mode 100644 kernel/liveupdate/kexec_handover_debug.c
>  create mode 100644 kernel/liveupdate/kexec_handover_internal.h
>  create mode 100644 kernel/liveupdate/luo_core.c
>  create mode 100644 kernel/liveupdate/luo_files.c
>  create mode 100644 kernel/liveupdate/luo_internal.h
>  create mode 100644 kernel/liveupdate/luo_ioctl.c
>  create mode 100644 kernel/liveupdate/luo_selftests.c
>  create mode 100644 kernel/liveupdate/luo_selftests.h
>  create mode 100644 kernel/liveupdate/luo_subsystems.c
>  create mode 100644 kernel/liveupdate/luo_sysfs.c
>  create mode 100644 mm/memfd_luo.c
>  create mode 100644 tools/lib/luo/LICENSE
>  create mode 100644 tools/lib/luo/Makefile
>  create mode 100644 tools/lib/luo/README.md
>  create mode 100644 tools/lib/luo/cli/.gitignore
>  create mode 100644 tools/lib/luo/cli/Makefile
>  create mode 100644 tools/lib/luo/cli/luoctl.c
>  create mode 100644 tools/lib/luo/include/libluo.h
>  create mode 100644 tools/lib/luo/include/liveupdate.h
>  create mode 100644 tools/lib/luo/libluo.c
>  create mode 100644 tools/lib/luo/tests/.gitignore
>  create mode 100644 tools/lib/luo/tests/Makefile
>  create mode 100644 tools/lib/luo/tests/test.c
>  create mode 100644 tools/testing/selftests/liveupdate/.gitignore
>  create mode 100644 tools/testing/selftests/liveupdate/Makefile
>  create mode 100644 tools/testing/selftests/liveupdate/config
>  create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c
> 
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

-- 
"Thought is the essence of where you are now."

