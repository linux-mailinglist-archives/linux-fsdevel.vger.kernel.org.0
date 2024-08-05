Return-Path: <linux-fsdevel+bounces-24977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22066947854
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627A6B21B22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7372C1537DA;
	Mon,  5 Aug 2024 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RplKCoy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBAE137932;
	Mon,  5 Aug 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850403; cv=none; b=dV8eW4p5jQPn6EetJCOAth8pwVwQlaroegqaF/rRsgn1JilRchx/m79w4eUq0atWt9FC2+ReN5lXsDWUEX/zBEbQZKJ8aIF5lfZjSdoxh/K6gb6eFHN5hIV9PBG/cuvskuQs6pgLm8RX6G22QB41/wYMcjYnsI4tL+RyqZQYzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850403; c=relaxed/simple;
	bh=WSbpP0Ku4d6U5dAt3TMZb4Tcs/Aav+4tPZKh7eaZ2g0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k2BoRYdsNC+EjrEIM3fDvoBqu8bnZDjgp2IHSLsLQ2nr5Ndksbq0rewQeTV5Da++dM2JbJK16lGKwRuXaeElGdKUlNeUysZvDToSSQjmFrScte1vK/6tm/vDT1PHUyB0NejOvVq2O+CpRAOnosg+mB76S25kbORZl83mHEsoD9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RplKCoy9; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722850403; x=1754386403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ysZOagAN9K1zsPHQ0+3bGUwQuaz+/zRHk10ZM4UgRVw=;
  b=RplKCoy9uHEbAKNkH/OaJptB9xTss2wCmKTwT6hZsadRMa2MkY0lVqCr
   kKEaO7BhrJH0OHn3tY94US/Y+EfqG6q8isY/hT5VovNHRdWTcZYy4u7V3
   wsgOXHhZkPGzKgkhZbsW6hWGXORYC3hUlEPi47Mg0y5kY/9g9WLa9//qD
   c=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716249600"; 
   d="scan'208";a="747198291"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 09:33:15 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:40744]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.164:2525] with esmtp (Farcaster)
 id 42289a65-0a12-41c0-a96c-f792eb8c9be8; Mon, 5 Aug 2024 09:33:13 +0000 (UTC)
X-Farcaster-Flow-ID: 42289a65-0a12-41c0-a96c-f792eb8c9be8
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:33:09 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.113) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:32:59 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: James Gowans <jgowans@amazon.com>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Steve Sistare <steven.sistare@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Anthony
 Yznaga" <anthony.yznaga@oracle.com>, Mike Rapoport <rppt@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <linux-mm@kvack.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, <linux-fsdevel@vger.kernel.org>, Usama Arif
	<usama.arif@bytedance.com>, <kvm@vger.kernel.org>, Alexander Graf
	<graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, Paul Durrant
	<pdurrant@amazon.co.uk>, Nicolas Saenz Julienne <nsaenz@amazon.es>
Subject: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
Date: Mon, 5 Aug 2024 11:32:35 +0200
Message-ID: <20240805093245.889357-1-jgowans@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

In this patch series a new in-memory filesystem designed specifically
for live update is implemented. Live update is a mechanism to support
updating a hypervisor in a way that has limited impact to running
virtual machines. This is done by pausing/serialising running VMs,
kexec-ing into a new kernel, starting new VMM processes and then
deserialising/resuming the VMs so that they continue running from where
they were. To support this, guest memory needs to be preserved.

Guestmemfs implements preservation acrosss kexec by carving out a large
contiguous block of host system RAM early in boot which is then used as
the data for the guestmemfs files. As well as preserving that large
block of data memory across kexec, the filesystem metadata is preserved
via the Kexec Hand Over (KHO) framework (still under review):
https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com/

Filesystem metadata is structured to make preservation across kexec
easy: inodes are one large contiguous array, and each inode has a
"mappings" block which defines which block from the filesystem data
memory corresponds to which offset in the file.

There are additional constraints/requirements which guestmemfs aims to
meet:

1. Secret hiding: all filesystem data is removed from the kernel direct
map so immune from speculative access. read()/write() are not supported;
the only way to get at the data is via mmap.

2. Struct page overhead elimination: the memory is not managed by the
buddy allocator and hence has no struct pages.

3. PMD and PUD level allocations for TLB performance: guestmemfs
allocates PMD-sized pages to back files which improves TLB perf (caveat
below!). PUD size allocations are a next step.

4. Device assignment: being able to use guestmemfs memory for
VFIO/iommufd mappings, and allow those mappings to survive and continue
to be used across kexec.


Next steps
=========

The idea is that this patch series implements a minimal filesystem to
provide the foundations for in-memory persistent across kexec files.
One this foundation is in place it will be extended:

1. Improve the filesystem to be more comprehensive - currently it's just
functional enough to demonstrate the main objective of reserved memory
and persistence via KHO.

2. Build support for iommufd IOAS and HWPT persistence, and integrate
that with guestmemfs. The idea is that if VMs have DMA devices assigned
to them, DMA should continue running across kexec. A future patch series
will add support for this in iommufd and connect iommufd to guestmemfs
so that guestmemfs files can remain mapped into the IOMMU during kexec.

3. Support a guest_memfd interface to files so that they can be used for
confidential computing without needing to mmap into userspace.

3. Gigantic PUD level mappings for even better TLB perf.

Caveats
=======

There are a issues with the current implementation which should be
solved either in this patch series or soon in follow-on work:

1. Although PMD-size allocations are done, PTE-level page tables are
still created. This is because guestmemfs uses remap_pfn_range() to set
up userspace pgtables. Currently remap_pfn_range() only creates
PTE-level mappings. I suggest enhancing remap_pfn_range() to support
creating higher level mappings where possible, by adding pmd_special
and pud_special flags.

2. NUMA support is currently non-existent. To make this more generally
useful it's necessary to have NUMA-awareness. One thought on how to do
this is to be able to specify multiple allocations with wNUMA affinity
on the kernel cmdline and have multiple mount points, one per NUMA node.
Currently, for simplicity, only a single contiguous filesystem data
allocation and a single mount point is supported.

3. MCEs are currently not handled - we need to add functionality for
this to be able to track block ownership and deliver an MCE correctly.

4. Looking for reviews from filesystem experts to see if necessary
callbacks, refcounting, locking, etc, is done correctly.

Open questions
==============

It is not too clear if or how guestmemfs should use DAX as a source of
memory. Seeing as guestmemfs has an in-memory design, it seems that it
is not necessary to use DAX as a source of memory, but I am keen for
guidance/input on whether DAX should be used here.

The filesystem data memory is removed from the direct map for secret
hiding, but it is still necessary to mmap it to be accessible to KVM.
For improving secret hiding even more a guest_memfd-style interface
could be used to remove the need to mmap. That introduces a new problem
of the memory being completely inaccessible to KVM for this like MMIO
instruction emulation. How can this be handled?

Related Work
============

There are similarities to a few attempts at solving aspects of this
problem previously.

The original was probably PKRAM from Oracle; a tempfs filesystem with
persistence:
https://lore.kernel.org/kexec/1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com/
guestmemfs will additionally provide secret hiding, PMD/PUD allocations
and a path to DMA persistence and NUMA support.

Dmemfs from Tencent aimed to remove the need for struct page overhead:
https://lore.kernel.org/kvm/cover.1602093760.git.yuleixzhang@tencent.com/
Guestmemfs provides this benefit too, along with persistence across
kexec and secret hiding. 

Pkernfs attempted to solve guest memory persistence and IOMMU
persistence all in one:
https://lore.kernel.org/all/20240205120203.60312-1-jgowans@amazon.com/
Guestmemfs is a re-work of that to only persist guest RAM in the
filesystem, and to use KHO for filesystem metadata. IOMMU persistence
will be implemented independently with persistent iommufd domains via
KHO.

Testing
=======

The testing for this can be seen in the Documentation file in this patch
series. Essentially it is using a guestmemfs file for a QEMU VM's RAM,
doing a kexec, restoring the QEMU VM and confirming that the VM picked
up from where it left off.

James Gowans (10):
  guestmemfs: Introduce filesystem skeleton
  guestmemfs: add inode store, files and dirs
  guestmemfs: add persistent data block allocator
  guestmemfs: support file truncation
  guestmemfs: add file mmap callback
  kexec/kho: Add addr flag to not initialise memory
  guestmemfs: Persist filesystem metadata via KHO
  guestmemfs: Block modifications when serialised
  guestmemfs: Add documentation and usage instructions
  MAINTAINERS: Add maintainers for guestmemfs

 Documentation/filesystems/guestmemfs.rst |  87 +++++++
 MAINTAINERS                              |   8 +
 arch/x86/mm/init_64.c                    |   2 +
 fs/Kconfig                               |   1 +
 fs/Makefile                              |   1 +
 fs/guestmemfs/Kconfig                    |  11 +
 fs/guestmemfs/Makefile                   |   8 +
 fs/guestmemfs/allocator.c                |  40 +++
 fs/guestmemfs/dir.c                      |  43 ++++
 fs/guestmemfs/file.c                     | 106 ++++++++
 fs/guestmemfs/guestmemfs.c               | 160 ++++++++++++
 fs/guestmemfs/guestmemfs.h               |  60 +++++
 fs/guestmemfs/inode.c                    | 189 ++++++++++++++
 fs/guestmemfs/serialise.c                | 302 +++++++++++++++++++++++
 include/linux/guestmemfs.h               |  16 ++
 include/uapi/linux/kexec.h               |   6 +
 kernel/kexec_kho_in.c                    |  12 +-
 kernel/kexec_kho_out.c                   |   4 +
 18 files changed, 1055 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/guestmemfs.rst
 create mode 100644 fs/guestmemfs/Kconfig
 create mode 100644 fs/guestmemfs/Makefile
 create mode 100644 fs/guestmemfs/allocator.c
 create mode 100644 fs/guestmemfs/dir.c
 create mode 100644 fs/guestmemfs/file.c
 create mode 100644 fs/guestmemfs/guestmemfs.c
 create mode 100644 fs/guestmemfs/guestmemfs.h
 create mode 100644 fs/guestmemfs/inode.c
 create mode 100644 fs/guestmemfs/serialise.c
 create mode 100644 include/linux/guestmemfs.h

-- 
2.34.1


