Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A1198190
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfHURjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:39:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729460AbfHURiV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:38:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9162F309B686;
        Wed, 21 Aug 2019 17:38:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B3A760F88;
        Wed, 21 Aug 2019 17:38:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9779E223CFC; Wed, 21 Aug 2019 13:38:14 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH v3 00/13] virtio-fs: shared file system for virtual machines 
Date:   Wed, 21 Aug 2019 13:37:29 -0400
Message-Id: <20190821173742.24574-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 21 Aug 2019 17:38:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Here are the V3 patches for virtio-fs filesystem. This time I have
broken the patch series in two parts. This is first part which does
not contain DAX support. Second patch series will contain the patches
for DAX support.

I have also dropped RFC tag from first patch series as we believe its
in good enough shape that it should get a consideration for inclusion
upstream.

These patches apply on top of 5.3-rc5 kernel and are also available
here.

https://github.com/rhvgoyal/linux/commits/vivek-5.3-aug-21-2019

Patches for V1 and V2 were posted here.

https://lwn.net/ml/linux-fsdevel/20181210171318.16998-1-vgoyal@redhat.com/
http://lkml.iu.edu/hypermail/linux/kernel/1905.1/07232.html

More information about the project can be found here.

https://virtio-fs.gitlab.io

Changes from V2
===============
- Various bug fixes and performance improvements.

HOWTO
======
We have put instructions on how to use it here.

https://virtio-fs.gitlab.io/

Some Performance Numbers
========================
I have basically run bunch of fio jobs to get a sense of speed of
various operations. I wrote a simple wrapper script to run fio jobs
3 times and take their average and report it. These scripts are available
here.

https://github.com/rhvgoyal/virtiofs-tests

I set up a directory on ramfs on host and exported that directory inside
guest using virtio-9p and virtio-fs and ran tests inside guests. Ran
tests with cache=none both for virtio-9p and virtio-fs so that no caching
happens in guest. For virtio-fs, I ran an additional set of tests with
dax enabled. Dax is not part of first patch series but I included
results here because dax seems to get the maximum performance advantage
and its shows the real potential of virtio-fs.

Test Setup
-----------
- A fedora 28 host with 32G RAM, 2 sockets (6 cores per socket, 2
  threads per core)

- Using ramfs on host as backing store. 4 fio files of 2G each.

- Created a VM with 16 VCPUS and 8GB memory. An 8GB cache window (for dax
  mmap).

Test Results
------------
- Results in three configurations have been reported. 9p (cache=none),
  virtio-fs (cache=none) and virtio-fs (cache=none + dax).

  There are other caching modes as well but to me cache=none seemed most
  interesting for now because it does not cache anything in guest
  and provides strong coherence. Other modes which provide less strong
  coherence and hence are faster are yet to be benchmarked.

- Three fio ioengines psync, libaio and mmap have been used.

- I/O Workload of randread, radwrite, seqread and seqwrite have been run.

- Each file size is 2G. Block size 4K. iodepth=16 

- "multi" means same operation was done with 4 jobs and each job is
  operating on a file of size 2G. 

- Some results are "0 (KiB/s)". That means that particular operation is
  not supported in that configuration.

NAME                    I/O Operation           BW(Read/Write)

9p-cache-none           seqread-psync           27(MiB/s)
virtiofs-cache-none     seqread-psync           35(MiB/s)
virtiofs-dax-cache-none seqread-psync           245(MiB/s)

9p-cache-none           seqread-psync-multi     117(MiB/s)
virtiofs-cache-none     seqread-psync-multi     162(MiB/s)
virtiofs-dax-cache-none seqread-psync-multi     894(MiB/s)

9p-cache-none           seqread-mmap            24(MiB/s)
virtiofs-cache-none     seqread-mmap            0(KiB/s)
virtiofs-dax-cache-none seqread-mmap            168(MiB/s)

9p-cache-none           seqread-mmap-multi      115(MiB/s)
virtiofs-cache-none     seqread-mmap-multi      0(KiB/s)
virtiofs-dax-cache-none seqread-mmap-multi      614(MiB/s)

9p-cache-none           seqread-libaio          26(MiB/s)
virtiofs-cache-none     seqread-libaio          139(MiB/s)
virtiofs-dax-cache-none seqread-libaio          160(MiB/s)

9p-cache-none           seqread-libaio-multi    129(MiB/s)
virtiofs-cache-none     seqread-libaio-multi    142(MiB/s)
virtiofs-dax-cache-none seqread-libaio-multi    577(MiB/s)

9p-cache-none           randread-psync          29(MiB/s)
virtiofs-cache-none     randread-psync          34(MiB/s)
virtiofs-dax-cache-none randread-psync          256(MiB/s)

9p-cache-none           randread-psync-multi    139(MiB/s)
virtiofs-cache-none     randread-psync-multi    153(MiB/s)
virtiofs-dax-cache-none randread-psync-multi    245(MiB/s)

9p-cache-none           randread-mmap           22(MiB/s)
virtiofs-cache-none     randread-mmap           0(KiB/s)
virtiofs-dax-cache-none randread-mmap           162(MiB/s)

9p-cache-none           randread-mmap-multi     111(MiB/s)
virtiofs-cache-none     randread-mmap-multi     0(KiB/s)
virtiofs-dax-cache-none randread-mmap-multi     215(MiB/s)

9p-cache-none           randread-libaio         26(MiB/s)
virtiofs-cache-none     randread-libaio         135(MiB/s)
virtiofs-dax-cache-none randread-libaio         157(MiB/s)

9p-cache-none           randread-libaio-multi   133(MiB/s)
virtiofs-cache-none     randread-libaio-multi   245(MiB/s)
virtiofs-dax-cache-none randread-libaio-multi   163(MiB/s)

9p-cache-none           seqwrite-psync          28(MiB/s)
virtiofs-cache-none     seqwrite-psync          34(MiB/s)
virtiofs-dax-cache-none seqwrite-psync          203(MiB/s)

9p-cache-none           seqwrite-psync-multi    128(MiB/s)
virtiofs-cache-none     seqwrite-psync-multi    155(MiB/s)
virtiofs-dax-cache-none seqwrite-psync-multi    717(MiB/s)

9p-cache-none           seqwrite-mmap           0(KiB/s)
virtiofs-cache-none     seqwrite-mmap           0(KiB/s)
virtiofs-dax-cache-none seqwrite-mmap           165(MiB/s)

9p-cache-none           seqwrite-mmap-multi     0(KiB/s)
virtiofs-cache-none     seqwrite-mmap-multi     0(KiB/s)
virtiofs-dax-cache-none seqwrite-mmap-multi     511(MiB/s)

9p-cache-none           seqwrite-libaio         27(MiB/s)
virtiofs-cache-none     seqwrite-libaio         128(MiB/s)
virtiofs-dax-cache-none seqwrite-libaio         141(MiB/s)

9p-cache-none           seqwrite-libaio-multi   119(MiB/s)
virtiofs-cache-none     seqwrite-libaio-multi   242(MiB/s)
virtiofs-dax-cache-none seqwrite-libaio-multi   505(MiB/s)

9p-cache-none           randwrite-psync         27(MiB/s)
virtiofs-cache-none     randwrite-psync         34(MiB/s)
virtiofs-dax-cache-none randwrite-psync         189(MiB/s)

9p-cache-none           randwrite-psync-multi   137(MiB/s)
virtiofs-cache-none     randwrite-psync-multi   150(MiB/s)
virtiofs-dax-cache-none randwrite-psync-multi   233(MiB/s)

9p-cache-none           randwrite-mmap          0(KiB/s)
virtiofs-cache-none     randwrite-mmap          0(KiB/s)
virtiofs-dax-cache-none randwrite-mmap          120(MiB/s)

9p-cache-none           randwrite-mmap-multi    0(KiB/s)
virtiofs-cache-none     randwrite-mmap-multi    0(KiB/s)
virtiofs-dax-cache-none randwrite-mmap-multi    200(MiB/s)

9p-cache-none           randwrite-libaio        25(MiB/s)
virtiofs-cache-none     randwrite-libaio        124(MiB/s)
virtiofs-dax-cache-none randwrite-libaio        131(MiB/s)

9p-cache-none           randwrite-libaio-multi  125(MiB/s)
virtiofs-cache-none     randwrite-libaio-multi  241(MiB/s)
virtiofs-dax-cache-none randwrite-libaio-multi  163(MiB/s)

Conclusions
===========
- In general virtio-fs seems faster than virtio-9p. Using dax makes it
  really interesting.

Note:
  Right now dax window is 8G and max fio file size is 8G as well (4
  files of 2G each). That means everything fits into dax window and no
  reclaim is needed. Dax window reclaim logic is slower and if file
  size is bigger than dax window size, performance slows down.

Description from previous postings
==================================

Design Overview
===============
With the goal of designing something with better performance and local file
system semantics, a bunch of ideas were proposed.

- Use fuse protocol (instead of 9p) for communication between guest
  and host. Guest kernel will be fuse client and a fuse server will
  run on host to serve the requests.

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

Caching Modes
=============
Like virtio-9p, different caching modes are supported which determine the
coherency level as well. The “cache=FOO” and “writeback” options control the
level of coherence between the guest and host filesystems.

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

Thanks
Vivek

Miklos Szeredi (2):
  fuse: delete dentry if timeout is zero
  fuse: Use default_file_splice_read for direct IO

Stefan Hajnoczi (6):
  fuse: export fuse_end_request()
  fuse: export fuse_len_args()
  fuse: export fuse_get_unique()
  fuse: extract fuse_fill_super_common()
  fuse: add fuse_iqueue_ops callbacks
  virtio_fs: add skeleton virtio_fs.ko module

Vivek Goyal (5):
  fuse: Export fuse_send_init_request()
  Export fuse_dequeue_forget() function
  fuse: Separate fuse device allocation and installation in fuse_conn
  virtio-fs: Do not provide abort interface in fusectl
  init/do_mounts.c: add virtio_fs root fs support

 fs/fuse/Kconfig                 |   11 +
 fs/fuse/Makefile                |    1 +
 fs/fuse/control.c               |    4 +-
 fs/fuse/cuse.c                  |    4 +-
 fs/fuse/dev.c                   |   89 ++-
 fs/fuse/dir.c                   |   26 +-
 fs/fuse/file.c                  |   15 +-
 fs/fuse/fuse_i.h                |  120 +++-
 fs/fuse/inode.c                 |  203 +++---
 fs/fuse/virtio_fs.c             | 1061 +++++++++++++++++++++++++++++++
 fs/splice.c                     |    3 +-
 include/linux/fs.h              |    2 +
 include/uapi/linux/virtio_fs.h  |   41 ++
 include/uapi/linux/virtio_ids.h |    1 +
 init/do_mounts.c                |   10 +
 15 files changed, 1462 insertions(+), 129 deletions(-)
 create mode 100644 fs/fuse/virtio_fs.c
 create mode 100644 include/uapi/linux/virtio_fs.h

-- 
2.20.1

