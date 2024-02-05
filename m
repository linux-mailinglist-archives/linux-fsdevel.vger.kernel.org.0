Return-Path: <linux-fsdevel+bounces-10270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD7E849978
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1000E28234A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAAD1B297;
	Mon,  5 Feb 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XhB2O2wL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937B1AACA;
	Mon,  5 Feb 2024 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134544; cv=none; b=mZCMKAL3i16hBOzkYph/+sZrzhLfYfR4pG8ZYSUwoWWnq5YkANAbStOdoR7v8ZqVRJAb8xo38o5h+Fr3fL0myFRlk/yW2g6LV3pEdE+a3DLe4sRkyMUBELNFeFDE+1xgyJq9JAP1q4ut3HumiBvL9a7BHxZFh8vifrvlfl2BJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134544; c=relaxed/simple;
	bh=9cueAwB0LumDfwRgOwQHZBfcrPxpJyw8wAQR4On/8Ck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nIUkcboiY/yUs1w8JVlIHoXREznAZ5FSSWCodQ9Zb+YLycRUdRVU1pbn40tjI22iFmcPVPblETg1RT0hIFin4DXz0G9qSK0+T7ctd1ul6fu3jGv9ai8kks7byby+BteLPGX/clqv65fR9hHwluxdvqwaL34OiofVh0vt1X0b5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XhB2O2wL; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134543; x=1738670543;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7MMrpZTVfPMVrVGIto5DFnqZuYB6wP8OFtd9k5c3mQY=;
  b=XhB2O2wLClUkXCGEJqYWZe6UjQdFuuR1nFOsv/WJfODSqA1hNN1s+wQD
   NVApEX+guwLwKZTUbYWuLrGfeL+CeHRTdbqxKvk2guyj2aokfF0GGiG/5
   9WUA/JZkAi9YGRVD9UZF+gj8XmqzRnyjK1y8CMCK8Svpv5r9ENL3T/kq2
   g=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="325148614"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:02:16 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:46990]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.186:2525] with esmtp (Farcaster)
 id 6f950021-4fed-4869-bff9-20388ff33e9a; Mon, 5 Feb 2024 12:02:14 +0000 (UTC)
X-Farcaster-Flow-ID: 6f950021-4fed-4869-bff9-20388ff33e9a
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:02:14 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:02:07 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: Eric Biederman <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	<kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, Alexander Graf <graf@amazon.com>, David Woodhouse
	<dwmw@amazon.co.uk>, "Jan H . Schoenherr" <jschoenh@amazon.de>, Usama Arif
	<usama.arif@bytedance.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	<madvenka@linux.microsoft.com>, <steven.sistare@oracle.com>,
	<yuleixzhang@tencent.com>
Subject: [RFC 00/18] Pkernfs: Support persistence for live update
Date: Mon, 5 Feb 2024 12:01:45 +0000
Message-ID: <20240205120203.60312-1-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

This RFC is to solicit feedback on the approach of implementing support for live
update via an in-memory filesystem responsible for storing all live update state
as files in the filesystem.

Hypervisor live update is a mechanism to support updating a hypervisor via kexec
in a way that has limited impact to running virtual machines. This is done by
pausing/serialising running VMs, kexec-ing into a new kernel, starting new VMM
processes and then deserialising/resuming the VMs so that they continue running
from where they were. Virtual machines can have PCI devices passed through and
in order to support live update it’s necessary to persist the IOMMU page tables
so that the devices can continue to do DMA to guest RAM during kexec.

This RFC is a follow-on from a discussion held during LPC 2023 KVM MC
which explored ways in which the live update problem could be tackled;
this was one of them:
https://lpc.events/event/17/contributions/1485/

The approach sketched out in this RFC introduces a new in-memory filesystem,
pkernfs. Pkernfs takes over ownership separate from Linux memory
management system RAM which is carved out from the normal MM allocator
and donated to pkernfs. Files are created in pkernfs for a few purposes:
There are a few things that need to be preserved and re-hydrated after
kexec to support this:

* Guest memory: to be able to restore the VM its memory must be
preserved.  This is achieved by using a regular file in pkernfs for guest RAM.
As this guest RAM is not part of the normal linux core mm allocator and
has no struct pages, it can be removed from the direct map which
improves security posture for guest RAM. Similar to memfd_secret.

* IOMMU root page tables: for the IOMMU to have any ability to do DMA
during kexec it needs root page tables to look up per-domain page
tables. IOMMU root page tables are stored in a special path in pkernfs:
iommu/root-pgtables.  The intel IOMMU driver is modified to hook into
pkernfs to get the chunk of memory that it can use to allocate root
pgtables.

* IOMMU domain page tables: in order for VM-initiated DMA operations to
continue running while kexec is happening the IOVA to PA address
translations for persisted devices needs to continue to work. Similar to
root pgtables the per-domain page tables for persisted devices are
allocated from a pkernfs file so they they are also persisted across
kexec. This is done by using pkernfs files for IOMMU domain page
tables. Not all devices are persistent, so VFIO is updated to support
defining persistent page tables on passed through devices.

* Updates to IOMMU and PCI are needed to make device handover across
kexec work properly. Although not fully complete some of the changed
needed around avoiding device re-setting and re-probing are sketched
in this RFC.

Guest RAM and IOMMU state are just the first two things needed for live update.
Pkernfs opens the door for other kernel state which can improve kexec or add
more capabilities to live update to also be persisted as new files.

The main aspect we’re looking for feedback/opinions on here is the concept of
putting all persistent state in a single filesystem: combining guest RAM and
IOMMU pgtables in one store. Also, the question of a hard separation between
persistent memory and ephemeral memory, compared to allowing arbitrary pages to
be persisted. Pkernfs does it via a hard separation defined at boot time, other
approaches could make the carving out of persistent pages dynamic.

Sign-offs are intentionally omitted to make it clear that this is a
concept sketch RFC and not intended for merging.

On CC are folks who have sent RFCs around this problem space before, as
well as filesystem, kexec, IOMMU, MM and KVM lists and maintainers.

== Alternatives ==

There have been other RFCs which cover some aspect of the live update problem
space. So far, all public approaches with KVM neglected device assignment which
introduces a new dimension of problems. Prior art in this space includes:

1) Kexec Hand Over (KHO) [0]: This is a generic mechanism to pass kernel state
across kexec. It also supports specifying persisted memory page which could be
used to carve out IOMMU pgtable pages from the new kernel’s buddy allocator.

2) PKRAM [1]: Tmpfs-style filesystem which dynamically allocates memory which can
be used for guest RAM and is preserved across kexec by passing a pointer to the
root page.

3) DMEMFS [2]: Similar to pkernfs, DMEMFS is a filesystem on top of a reserved
chunk of memory specified via kernel cmdline parameter. It is not persistent but
aims to remove the need for struct page overhead.

4) Kernel memory pools [3, 4]: These provide a mechanism for kernel modules/drivers
to allocate persistent memory, and restore that memory after kexec. They do do
not attempt to provide the ability to store userspace accessible state or have a
filesystem interface.

== How to use ==

Use the mmemap and pkernfs cmd line args to carve memory out of system RAM and
donate it to pkernfs. For example to carve out 1 GiB of RAM starting at physical
offset 1 GiB:
  memmap=1G%1G nopat pkernfs=1G!1G

Mount pkernfs somewhere, for example:
  mount -t pkernfs /mnt/pkernfs

Allocate a file for guest RAM:
  touch /mnt/pkernfs/guest-ram
  truncate -s 100M /mnt/pkernfs/guest-ram

Add QEMU cmdline option to use this as guest RAM:
  -object memory-backend-file,id=pc.ram,size=100M,mem-path=/mnt/pkernfs/guest-ram,share=yes
  -M q35,memory-backend=pc.ram

Allocate a file for IOMMU domain page tables:
  touch /mnt/pkernfs/iommu/dom-0
  truncate -s 2M /mnt/pkernfs/iommu/dom-0

That file must be supplied to VFIO when creating the IOMMU container, via the
VFIO_CONTAINER_SET_PERSISTENT_PGTABLES ioctl. Example: [4]

After kexec, re-mount pkernfs, re-used those files for guest RAM and IOMMU
state. When doing DMA mapping specify the additional flag
VFIO_DMA_MAP_FLAG_LIVE_UPDATE to indicate that IOVAs are set up already.
Example: [5].

== Limitations ==

This is a RFC design to sketch out the concept so that there can be a discussion
about the general approach. There are many gaps and hacks; the idea is to keep
this RFC as simple as possible. Limitations include:

* Needing to supply the physical memory range for pkernfs as a kernel cmdline
parameter. Better would be to allocate memory for pkernfs dynamically on first
boot and pass that across kexec. Doing so would require additional integration
with memblocks and some ability to pass the dynamically allocated ranges
across. KHO [0] could support this.

* A single filesystem with no support for NUMA awareness. Better would be to
support multiple named pkernfs mounts which can cover different NUMA nodes.

* Skeletal filesystem code. There’s just enough functionality to make it usable to
demonstrate the concept of using files for guest RAM and IOMMU state.

* Use-after-frees for IOMMU mappings. Currently nothing stops the pkernfs guest
RAM files being deleted or resized while IOMMU mappings are set up which would
allow DMA to freed memory. Better integration with guest RAM files and
IOMMU/VFIO is necessary.

* Needing to drive and re-hydrate the IOMMU page tables by defining an IOMMU file.
Really we should move the abstraction one level up and make the whole VFIO
container persistent via a pkernfs file. That way you’d "just" re-open the VFIO
container file and all of the DMA mappings inside VFIO would already be set up.

* Inefficient use of filesystem space. Every mappings block is 2 MiB which is both
wasteful and an hard upper limit on file size.

[0] https://lore.kernel.org/kexec/20231213000452.88295-1-graf@amazon.com/
[1] https://lore.kernel.org/kexec/1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com/
[2] https://lkml.org/lkml/2020/12/7/342
[3] https://lore.kernel.org/all/169645773092.11424.7258549771090599226.stgit@skinsburskii./
[4] https://lore.kernel.org/all/2023082506-enchanted-tripping-d1d5@gregkh/#t
[5] https://github.com/jgowans/qemu/commit/e84cfb8186d71f797ef1f72d57d873222a9b479e
[6] https://github.com/jgowans/qemu/commit/6e4f17f703eaf2a6f1e4cb2576d61683eaee02b0


James Gowans (18):
  pkernfs: Introduce filesystem skeleton
  pkernfs: Add persistent inodes hooked into directies
  pkernfs: Define an allocator for persistent pages
  pkernfs: support file truncation
  pkernfs: add file mmap callback
  init: Add liveupdate cmdline param
  pkernfs: Add file type for IOMMU root pgtables
  iommu: Add allocator for pgtables from persistent region
  intel-iommu: Use pkernfs for root/context pgtable pages
  iommu/intel: zap context table entries on kexec
  dma-iommu: Always enable deferred attaches for liveupdate
  pkernfs: Add IOMMU domain pgtables file
  vfio: add ioctl to define persistent pgtables on container
  intel-iommu: Allocate domain pgtable pages from pkernfs
  pkernfs: register device memory for IOMMU domain pgtables
  vfio: support not mapping IOMMU pgtables on live-update
  pci: Don't clear bus master is persistence enabled
  vfio-pci: Assume device working after liveupdate

 drivers/iommu/Makefile           |   1 +
 drivers/iommu/dma-iommu.c        |   2 +-
 drivers/iommu/intel/dmar.c       |   1 +
 drivers/iommu/intel/iommu.c      |  93 +++++++++++++---
 drivers/iommu/intel/iommu.h      |   5 +
 drivers/iommu/iommu.c            |  22 ++--
 drivers/iommu/pgtable_alloc.c    |  43 +++++++
 drivers/iommu/pgtable_alloc.h    |  10 ++
 drivers/pci/pci-driver.c         |   4 +-
 drivers/vfio/container.c         |  27 +++++
 drivers/vfio/pci/vfio_pci_core.c |  20 ++--
 drivers/vfio/vfio.h              |   2 +
 drivers/vfio/vfio_iommu_type1.c  |  51 ++++++---
 fs/Kconfig                       |   1 +
 fs/Makefile                      |   3 +
 fs/pkernfs/Kconfig               |   9 ++
 fs/pkernfs/Makefile              |   6 +
 fs/pkernfs/allocator.c           |  51 +++++++++
 fs/pkernfs/dir.c                 |  43 +++++++
 fs/pkernfs/file.c                |  93 ++++++++++++++++
 fs/pkernfs/inode.c               | 185 +++++++++++++++++++++++++++++++
 fs/pkernfs/iommu.c               | 163 +++++++++++++++++++++++++++
 fs/pkernfs/pkernfs.c             | 115 +++++++++++++++++++
 fs/pkernfs/pkernfs.h             |  61 ++++++++++
 include/linux/init.h             |   1 +
 include/linux/iommu.h            |   6 +-
 include/linux/pkernfs.h          |  38 +++++++
 include/uapi/linux/vfio.h        |  10 ++
 init/main.c                      |  10 ++
 29 files changed, 1029 insertions(+), 47 deletions(-)
 create mode 100644 drivers/iommu/pgtable_alloc.c
 create mode 100644 drivers/iommu/pgtable_alloc.h
 create mode 100644 fs/pkernfs/Kconfig
 create mode 100644 fs/pkernfs/Makefile
 create mode 100644 fs/pkernfs/allocator.c
 create mode 100644 fs/pkernfs/dir.c
 create mode 100644 fs/pkernfs/file.c
 create mode 100644 fs/pkernfs/inode.c
 create mode 100644 fs/pkernfs/iommu.c
 create mode 100644 fs/pkernfs/pkernfs.c
 create mode 100644 fs/pkernfs/pkernfs.h
 create mode 100644 include/linux/pkernfs.h

-- 
2.40.1


