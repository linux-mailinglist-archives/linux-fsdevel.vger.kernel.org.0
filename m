Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8D41795F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgCDQ71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:59:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56065 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730083AbgCDQ70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KqxwdR9zKaulXRhlk1T+G9VOHSY6Ymue2z8amR6F1KU=;
        b=Jat86Nd2/vP5Rqi153praOJL8pTGE4/jKqIJPvrmX+G10BRtIx3LlP3Qj2GSZ9aR0yCZDm
        m2j+kvAVpKV2eJddpmFoLpokFDqhTvIUVHxOd1dbVZbYaeaZA6ZoGhrk7XgcM5Inuj5x8b
        HBwGP+plEAipZwKdgzmWFA/r0nQXvz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-fJ9H8TuJPLCKuKyZqwwO-w-1; Wed, 04 Mar 2020 11:59:12 -0500
X-MC-Unique: fJ9H8TuJPLCKuKyZqwwO-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61817100550E;
        Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C9E97388D;
        Wed,  4 Mar 2020 16:59:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 334872257D2; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 00/20] virtiofs: Add DAX support
Date:   Wed,  4 Mar 2020 11:58:25 -0500
Message-Id: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This patch series adds DAX support to virtiofs filesystem. This allows
bypassing guest page cache and allows mapping host page cache directly
in guest address space.

When a page of file is needed, guest sends a request to map that page
(in host page cache) in qemu address space. Inside guest this is
a physical memory range controlled by virtiofs device. And guest
directly maps this physical address range using DAX and hence gets
access to file data on host.

This can speed up things considerably in many situations. Also this
can result in substantial memory savings as file data does not have
to be copied in guest and it is directly accessed from host page
cache.

Most of the changes are limited to fuse/virtiofs. There are couple
of changes needed in generic dax infrastructure and couple of changes
in virtio to be able to access shared memory region.

These patches apply on top of 5.6-rc4 and are also available here.

https://github.com/rhvgoyal/linux/commits/vivek-04-march-2020

Any review or feedback is welcome.

Performance
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I have basically run bunch of fio jobs to get a sense of speed of
various operations. I wrote a simple wrapper script to run fio jobs
3 times and take their average and report it. These scripts and fio
jobs are available here.

https://github.com/rhvgoyal/virtiofs-tests

I set up a directory on ramfs on host and exported that directory inside
guest using virtio-fs and ran tests inside guests. Ran tests with
cache=3Dnone both with dax enabled and disabled. cache=3Dnone option
enforces no caching happens in guest both for data and metadata.

Test Setup
-----------
- A fedora 29 host with 376Gi RAM, 2 sockets (20 cores per socket, 2
  threads per core)

- Using ramfs on host as backing store. 4 fio files of 8G each.

- Created a VM with 64 VCPUS and 64GB memory. An 64GB cache window (for d=
ax
  mmap).

Test Results
------------
- Results in two configurations have been reported.=20
  virtio-fs (cache=3Dnone) and virtio-fs (cache=3Dnone + dax).

  There are other caching modes as well but to me cache=3Dnone seemed mos=
t
  interesting for now because it does not cache anything in guest
  and provides strong coherence. Other modes which provide less strong
  coherence and hence are faster are yet to be benchmarked.

- Three fio ioengines psync, libaio and mmap have been used.

- I/O Workload of randread, radwrite, seqread and seqwrite have been run.

- Each file size is 8G. Block size 4K. iodepth=3D16=20

- "multi" means same operation was done with 4 jobs and each job is
  operating on a file of size 8G.=20

- Some results are "0 (KiB/s)". That means that particular operation is
  not supported in that configuration.

NAME                    I/O Operation           BW(Read/Write)
virtiofs-cache-none     seqread-psync           35(MiB/s)
virtiofs-cache-none-dax seqread-psync           643(MiB/s)

virtiofs-cache-none     seqread-psync-multi     219(MiB/s)
virtiofs-cache-none-dax seqread-psync-multi     2132(MiB/s)

virtiofs-cache-none     seqread-mmap            0(KiB/s)
virtiofs-cache-none-dax seqread-mmap            741(MiB/s)

virtiofs-cache-none     seqread-mmap-multi      0(KiB/s)
virtiofs-cache-none-dax seqread-mmap-multi      2530(MiB/s)

virtiofs-cache-none     seqread-libaio          293(MiB/s)
virtiofs-cache-none-dax seqread-libaio          425(MiB/s)

virtiofs-cache-none     seqread-libaio-multi    207(MiB/s)
virtiofs-cache-none-dax seqread-libaio-multi    1543(MiB/s)

virtiofs-cache-none     randread-psync          36(MiB/s)
virtiofs-cache-none-dax randread-psync          572(MiB/s)

virtiofs-cache-none     randread-psync-multi    211(MiB/s)
virtiofs-cache-none-dax randread-psync-multi    1764(MiB/s)

virtiofs-cache-none     randread-mmap           0(KiB/s)
virtiofs-cache-none-dax randread-mmap           719(MiB/s)

virtiofs-cache-none     randread-mmap-multi     0(KiB/s)
virtiofs-cache-none-dax randread-mmap-multi     2005(MiB/s)

virtiofs-cache-none     randread-libaio         300(MiB/s)
virtiofs-cache-none-dax randread-libaio         413(MiB/s)

virtiofs-cache-none     randread-libaio-multi   327(MiB/s)
virtiofs-cache-none-dax randread-libaio-multi   1326(MiB/s)

virtiofs-cache-none     seqwrite-psync          34(MiB/s)
virtiofs-cache-none-dax seqwrite-psync          494(MiB/s)

virtiofs-cache-none     seqwrite-psync-multi    223(MiB/s)
virtiofs-cache-none-dax seqwrite-psync-multi    1680(MiB/s)

virtiofs-cache-none     seqwrite-mmap           0(KiB/s)
virtiofs-cache-none-dax seqwrite-mmap           1217(MiB/s)

virtiofs-cache-none     seqwrite-mmap-multi     0(KiB/s)
virtiofs-cache-none-dax seqwrite-mmap-multi     2359(MiB/s)

virtiofs-cache-none     seqwrite-libaio         282(MiB/s)
virtiofs-cache-none-dax seqwrite-libaio         348(MiB/s)

virtiofs-cache-none     seqwrite-libaio-multi   320(MiB/s)
virtiofs-cache-none-dax seqwrite-libaio-multi   1255(MiB/s)

virtiofs-cache-none     randwrite-psync         32(MiB/s)
virtiofs-cache-none-dax randwrite-psync         458(MiB/s)

virtiofs-cache-none     randwrite-psync-multi   213(MiB/s)
virtiofs-cache-none-dax randwrite-psync-multi   1343(MiB/s)

virtiofs-cache-none     randwrite-mmap          0(KiB/s)
virtiofs-cache-none-dax randwrite-mmap          663(MiB/s)

virtiofs-cache-none     randwrite-mmap-multi    0(KiB/s)
virtiofs-cache-none-dax randwrite-mmap-multi    1820(MiB/s)

virtiofs-cache-none     randwrite-libaio        292(MiB/s)
virtiofs-cache-none-dax randwrite-libaio        341(MiB/s)

virtiofs-cache-none     randwrite-libaio-multi  322(MiB/s)
virtiofs-cache-none-dax randwrite-libaio-multi  1094(MiB/s)

Conclusion
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- virtio-fs with dax enabled is significantly faster and memory
  effiecient as comapred to non-dax operation.

Note:
  Right now dax window is 64G and max fio file size is 32G as well (4
  files of 8G each). That means everything fits into dax window and no
  reclaim is needed. Dax window reclaim logic is slower and if file
  size is bigger than dax window size, performance slows down.

Thanks
Vivek

Sebastien Boeuf (3):
  virtio: Add get_shm_region method
  virtio: Implement get_shm_region for PCI transport
  virtio: Implement get_shm_region for MMIO transport

Stefan Hajnoczi (2):
  virtio_fs, dax: Set up virtio_fs dax_device
  fuse,dax: add DAX mmap support

Vivek Goyal (15):
  dax: Modify bdev_dax_pgoff() to handle NULL bdev
  dax: Create a range version of dax_layout_busy_page()
  virtiofs: Provide a helper function for virtqueue initialization
  fuse: Get rid of no_mount_options
  fuse,virtiofs: Add a mount option to enable dax
  fuse,virtiofs: Keep a list of free dax memory ranges
  fuse: implement FUSE_INIT map_alignment field
  fuse: Introduce setupmapping/removemapping commands
  fuse, dax: Implement dax read/write operations
  fuse, dax: Take ->i_mmap_sem lock during dax page fault
  fuse,virtiofs: Define dax address space operations
  fuse,virtiofs: Maintain a list of busy elements
  fuse: Release file in process context
  fuse: Take inode lock for dax inode truncation
  fuse,virtiofs: Add logic to free up a memory range

 drivers/dax/super.c                |    3 +-
 drivers/virtio/virtio_mmio.c       |   32 +
 drivers/virtio/virtio_pci_modern.c |  107 +++
 fs/dax.c                           |   66 +-
 fs/fuse/dir.c                      |    2 +
 fs/fuse/file.c                     | 1162 +++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h                   |  109 ++-
 fs/fuse/inode.c                    |  148 +++-
 fs/fuse/virtio_fs.c                |  250 +++++-
 include/linux/dax.h                |    6 +
 include/linux/virtio_config.h      |   17 +
 include/uapi/linux/fuse.h          |   42 +-
 include/uapi/linux/virtio_fs.h     |    3 +
 include/uapi/linux/virtio_mmio.h   |   11 +
 include/uapi/linux/virtio_pci.h    |   11 +-
 15 files changed, 1888 insertions(+), 81 deletions(-)

--=20
2.20.1

