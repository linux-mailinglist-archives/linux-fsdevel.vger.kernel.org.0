Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F66F1FADA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfEOT1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:27:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfEOT1d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37CD030B96FD;
        Wed, 15 May 2019 19:27:32 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0D185D9CC;
        Wed, 15 May 2019 19:27:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 556DC220386; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 00/30] [RFC] virtio-fs: shared file system for virtual machines
Date:   Wed, 15 May 2019 15:26:45 -0400
Message-Id: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 15 May 2019 19:27:32 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Here are the RFC patches for V2 of virtio-fs. These patches apply on top
of 5.1 kernel. These patches are also available here.

https://github.com/rhvgoyal/linux/commits/virtio-fs-dev-5.1
  
Patches for V1 were posted here.
  
https://lwn.net/ml/linux-fsdevel/20181210171318.16998-1-vgoyal@redhat.com/

This is still work in progress. As of now one can passthrough a host
directory in to guest and it works reasonably well. pjdfstests test
suite passes and blogbench runs. But this dirctory can't be shared
between guests and host can't modify files in directory yet.  That's
still TBD.
  
Posting another version to gather feedback and comments on progress so far.
  
More information about the project can be found here.
  
https://virtio-fs.gitlab.io/

Changes from V1
===============
- Various bug fixes
- virtio-fs dax huge page size working, leading to improved performance.
- Fixed kernel automated tests warnings.
- Better handling of shared cache region reporting by virtio device.

Description from V1 posting
---------------------------
Problem Description
===================
We want to be able to take a directory tree on the host and share it with
guest[s]. Our goal is to be able to do it in a fast, consistent and secure
manner. Our primary use case is kata containers, but it should be usable in
other scenarios as well.

Containers may rely on local file system semantics for shared volumes,
read-write mounts that multiple containers access simultaneously.  File
system changes must be visible to other containers with the same consistency
expected of a local file system, including mmap MAP_SHARED.

Existing Solutions
==================
We looked at existing solutions and virtio-9p already provides basic shared
file system functionality although does not offer local file system semantics,
causing some workloads and test suites to fail. In addition, virtio-9p
performance has been an issue for Kata Containers and we believe this cannot
be alleviated without major changes that do not fit into the 9P protocol.

Design Overview
===============
With the goal of designing something with better performance and local file
system semantics, a bunch of ideas were proposed.

- Use fuse protocol (instead of 9p) for communication between guest
  and host. Guest kernel will be fuse client and a fuse server will
  run on host to serve the requests. Benchmark results are encouraging and
  show this approach performs well (2x to 8x improvement depending on test
  being run).

- For data access inside guest, mmap portion of file in QEMU address
  space and guest accesses this memory using dax. That way guest page
  cache is bypassed and there is only one copy of data (on host). This
  will also enable mmap(MAP_SHARED) between guests.

- For metadata coherency, there is a shared memory region which contains
  version number associated with metadata and any guest changing metadata
  updates version number and other guests refresh metadata on next
  access. This is yet to be implemented.

How virtio-fs differs from existing approaches
==============================================
The unique idea behind virtio-fs is to take advantage of the co-location
of the virtual machine and hypervisor to avoid communication (vmexits).

DAX allows file contents to be accessed without communication with the
hypervisor. The shared memory region for metadata avoids communication in
the common case where metadata is unchanged.

By replacing expensive communication with cheaper shared memory accesses,
we expect to achieve better performance than approaches based on network
file system protocols. In addition, this also makes it easier to achieve
local file system semantics (coherency).

These techniques are not applicable to network file system protocols since
the communications channel is bypassed by taking advantage of shared memory
on a local machine. This is why we decided to build virtio-fs rather than
focus on 9P or NFS.

HOWTO
======
We have put instructions on how to use it here.

https://virtio-fs.gitlab.io/

Caching Modes
=============
Like virtio-9p, different caching modes are supported which determine the
coherency level as well. The “cache=FOO” and “writeback” options control the
level of coherence between the guest and host filesystems. The “shared” option
only has an effect on coherence between virtio-fs filesystem instances
running inside different guests.

- cache=none
  metadata, data and pathname lookup are not cached in guest. They are always
  fetched from host and any changes are immediately pushed to host.

- cache=always
  metadata, data and pathname lookup are cached in guest and never expire.

- cache=auto
  metadata and pathname lookup cache expires after a configured amount of time
  (default is 1 second). Data is cached while the file is open (close to open
  consistency).

- writeback/no_writeback
  These options control the writeback strategy.  If writeback is disabled,
  then normal writes will immediately be synchronized with the host fs. If
  writeback is enabled, then writes may be cached in the guest until the file
  is closed or an fsync(2) performed. This option has no effect on mmap-ed
  writes or writes going through the DAX mechanism.

- shared/no_shared
  These options control the  use of the shared version table. If shared mode
  is enabled then metadata and pathname lookup is cached in guest, but is
  refreshed due to changes in another virtio-fs instance.

DAX
===
- dax can be turned on/off when mounting virtio-fs inside guest.

TODO
====
- Implement "cache=shared" option.
- Improve error handling on host. If page fault on host fails, we need
  to propagate it into guest.
- Try to fine tune for performance.
- Bug fixes

RESULTS
=======
- pjdfstests are passing. Have tried cache=none/auto/always and dax on/off).

  https://github.com/pjd/pjdfstest

  (one symlink test fails and that seems to be due xfs on host. Yet to
   look into it).

- Ran blogbench and that works too.

Thanks
Vivek  

Miklos Szeredi (2):
  fuse: delete dentry if timeout is zero
  fuse: Use default_file_splice_read for direct IO

Sebastien Boeuf (3):
  virtio: Add get_shm_region method
  virtio: Implement get_shm_region for PCI transport
  virtio: Implement get_shm_region for MMIO transport

Stefan Hajnoczi (10):
  fuse: export fuse_end_request()
  fuse: export fuse_len_args()
  fuse: export fuse_get_unique()
  fuse: extract fuse_fill_super_common()
  fuse: add fuse_iqueue_ops callbacks
  virtio_fs: add skeleton virtio_fs.ko module
  dax: remove block device dependencies
  fuse, dax: add fuse_conn->dax_dev field
  virtio_fs, dax: Set up virtio_fs dax_device
  fuse, dax: add DAX mmap support

Vivek Goyal (15):
  fuse: Clear setuid bit even in cache=never path
  fuse: Export fuse_send_init_request()
  fuse: Separate fuse device allocation and installation in fuse_conn
  dax: Pass dax_dev to dax_writeback_mapping_range()
  fuse: Keep a list of free dax memory ranges
  fuse: Introduce setupmapping/removemapping commands
  fuse, dax: Implement dax read/write operations
  fuse: Define dax address space operations
  fuse, dax: Take ->i_mmap_sem lock during dax page fault
  fuse: Maintain a list of busy elements
  fuse: Add logic to free up a memory range
  fuse: Release file in process context
  fuse: Reschedule dax free work if too many EAGAIN attempts
  fuse: Take inode lock for dax inode truncation
  virtio-fs: Do not provide abort interface in fusectl

 drivers/dax/super.c                |    3 +-
 drivers/virtio/virtio_mmio.c       |   32 +
 drivers/virtio/virtio_pci_modern.c |  108 +++
 fs/dax.c                           |   23 +-
 fs/ext2/inode.c                    |    2 +-
 fs/ext4/inode.c                    |    2 +-
 fs/fuse/Kconfig                    |   11 +
 fs/fuse/Makefile                   |    1 +
 fs/fuse/control.c                  |    4 +-
 fs/fuse/cuse.c                     |    5 +-
 fs/fuse/dev.c                      |   80 +-
 fs/fuse/dir.c                      |   28 +-
 fs/fuse/file.c                     |  953 ++++++++++++++++++++++-
 fs/fuse/fuse_i.h                   |  206 ++++-
 fs/fuse/inode.c                    |  307 ++++++--
 fs/fuse/virtio_fs.c                | 1129 ++++++++++++++++++++++++++++
 fs/splice.c                        |    3 +-
 fs/xfs/xfs_aops.c                  |    2 +-
 include/linux/dax.h                |    6 +-
 include/linux/fs.h                 |    2 +
 include/linux/virtio_config.h      |   17 +
 include/uapi/linux/fuse.h          |   34 +
 include/uapi/linux/virtio_fs.h     |   44 ++
 include/uapi/linux/virtio_ids.h    |    1 +
 include/uapi/linux/virtio_mmio.h   |   11 +
 include/uapi/linux/virtio_pci.h    |   10 +
 26 files changed, 2875 insertions(+), 149 deletions(-)
 create mode 100644 fs/fuse/virtio_fs.c
 create mode 100644 include/uapi/linux/virtio_fs.h

-- 
2.20.1

