Return-Path: <linux-fsdevel+bounces-10976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA8C84F91D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DC91F239C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8790762D7;
	Fri,  9 Feb 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="czUBZDRI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC776030
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494604; cv=none; b=Mn6gni92JvsxtyHgeHguW7DK/oUlncDk6a2HDiWSlI8cBn36pUzGhO9bhWXNEAk/oiqAafiOU268uJrg7OXF22ZIqZxZOAWew8NrtQ+qtPvsAZKGuq+DpTelyNKuCyzYZp79FrkmnoFYsDDHK5lXpNlpmbusTuypO67HX4FIhKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494604; c=relaxed/simple;
	bh=vlQD8ZEEeMI1Uu1eigZ4Z6Cvst12jN+Wj4JCBQxSfU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F9dLbz6tDq0knxPnv50580XnpFIm2KNxGhgHCct+kFQtAwsfIZQlEDPqY4K6SYep0M/uKzq3Q56eZoy38ctte7zSAVoPF3RmSRHg44QupFXfvg2f6t0gg+ccvdrPe90jihEEG7NUha6rHYFL4VZRQJZJ5Pkdt2Ov8HvXuI8wzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=czUBZDRI; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707494599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=adgMAjwxJTvri5oreCpxlFPQcfsRb8fC7vO93bohN1g=;
	b=czUBZDRIbXmVrKBOv/iLkm5x0j/EmEM4r+HKvCkX8ETTDyDtlN6Hx1zo2AHe8oOPHTMV4w
	yjzDmbsbW+/Qmie5WWQk74AJBFBFamxLC+Er2CEmGPc1cFGyp8xeg1qSkhYSOveSZhFhGL
	IvTZlRjpf/52zr9B7py6ybyV109nccs=
From: Sergei Shtepa <sergei.shtepa@linux.dev>
To: axboe@kernel.dk,
	hch@infradead.org,
	corbet@lwn.net,
	snitzer@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 0/8] filtering and snapshots of a block devices
Date: Fri,  9 Feb 2024 17:01:56 +0100
Message-Id: <20240209160204.1471421-1-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all.

I am happy to offer an improved version of the block device filtering 
mechanism (blkfilter) and module for creating snapshots of block devices
(blksnap).

The filtering block device mechanism is implemented in the block layer.
This allows to attach and detach block device filters. Filters extend the
functionality of the block layer. See more in 
Documentation/block/blkfilter.rst.

The main purpose of snapshots of block devices is to provide backups of
them. See more in Documentation/block/blksnap.rst. The tool, library and
tests for working with blksnap can be found on github. 
Link: https://github.com/veeam/blksnap/tree/stable-v2.0
There is also documentation from which you can learn how to manage the
module using the library and the console tool.

Based on LK v6.8-rc3 with Christoph's patchset "clean up blk_mq_submit_bio".
Link: https://lore.kernel.org/linux-block/50fbe76b-d77d-4a7e-bda4-3a3b754fbd7e@kernel.org/T/#t

I express my appreciation and gratitude to Christoph. Thanks to his
attention to the project, it was possible to raise the quality of the code.
I probably wouldn't have made version 7 if it wasn't for his help.
I am sure that the blksnap module will improve the quality of backup tools
for Linux.

v7 changes:
- The location of the filtering of I/O units has been changed. This made it
  possible to remove the additional call bio_queue_enter().
- Remove configs BLKSNAP_DIFF_BLKDEV and BLKSNAP_CHUNK_DIFF_BIO_SYNC.
- To process the ioctl, the switch statement is used instead of a table
  with functions.
- Instead of a file descriptor, the module gets a path on the file system.
  This allows the kernel module to correctly open a file or block device
  with exclusive access rights.
- Fixed a bio leaking bugs.

v6 changes:
- The difference storage has been changed.
  In the previous version, the file was created only to reserve sector
  ranges on a block device. The data was stored directly to the block
  device in these sector ranges. Now saving and reading data is done using
  'VFS' using vfs_iter_write() and vfs_iter_read() functions. This allows
  not to depend on the filesystem and use, for example, tmpfs. Using an
  unnamed temporary file allows hiding it from other processes and
  automatically release it when the snapshot is closed.
  However, now the module does not allow adding a block device to the
  snapshot on which the difference storage is located. There is no way to
  ensure the immutability of file metadata when writing data to a file.
  This means that the metadata of the filesystem may change, which may
  cause damage to the snapshot.
- _IOW and _IOR were mixed up - fixed. 
- Protection against the use of the snapshots for block devices with
  hardware inline encryption and data integrity was implemented.
  Compatibility with them was not planned and has not been tested at the
  moment.

v5 changes:
- Rebase for "kernel/git/axboe/linux-block.git" branch "for-6.5/block".
  Link: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.5/block

v4 changes:
- Structures for describing the state of chunks are allocated dynamically.
  This reduces memory consumption, since the struct chunk is allocated only
  for those blocks for which the snapshot image state differs from the
  original block device.
- The algorithm for calculating the chunk size depending on the size of the
  block device has been changed. For large block devices, it is now
  possible to allocate a larger number of chunks, and their size is smaller.
- For block devices, a 'filter' file has been added to /sys/block/<device>.
  It displays the name of the filter that is attached to the block device.
- Fixed a problem with the lack of protection against re-adding a block
  device to a snapshot.
- Fixed a bug in the algorithm of allocating the next bio for a chunk.
  This problem was occurred on large disks, for which a chunk consists of
  at least two bio.
- The ownership mechanism of the diff_area structure has been changed.
  This fixed the error of prematurely releasing the diff_area structure
  when destroying the snapshot.
- Documentation corrected.
- The Sparse analyzer is passed.
- Use __u64 type instead pointers in UAPI.

v3 changes:
- New block device I/O controls BLKFILTER_ATTACH and BLKFILTER_DETACH allow
  to attach and detach filters.
- New block device I/O control BLKFILTER_CTL allow sending command to
  attached block device filter.
- The copy-on-write algorithm for processing I/O units has been optimized
  and has become asynchronous.
- The snapshot image reading algorithm has been optimized and has become
  asynchronous.
- Optimized the finite state machine for processing chunks.
- Fixed a tracking block size calculation bug.

v2 changes:
- Added documentation for Block Device Filtering Mechanism.
- Added documentation for Block Devices Snapshots Module (blksnap).
- The MAINTAINERS file has been updated.
- Optimized queue code for snapshot images.
- Fixed comments, log messages and code for better readability.

v1 changes:
- Forgotten "static" declarations have been added.
- The text of the comments has been corrected.
- It is possible to connect only one filter, since there are no others in
  upstream.
- Do not have additional locks for attach/detach filter.
- blksnap.h moved to include/uapi/.
- #pragma once and commented code removed.
- uuid_t removed from user API.
- Removed default values for module parameters from the configuration file.
- The debugging code for tracking memory leaks has been removed.
- Simplified Makefile.
- Optimized work with large memory buffers, CBT tables are now in virtual
  memory.
- The allocation code of minor numbers has been optimized.
- The implementation of the snapshot image block device has been
  simplified, now it is a bio-based block device.
- Removed initialization of global variables with null values.
- only one bio is used to copy one chunk.
- Checked on ppc64le.

Sergei Shtepa (8):
  documentation: filtering and snapshots of a block devices
  block: filtering of a block devices
  block: header file of the blksnap module interface
  block: module management interface functions
  block: handling and tracking I/O units
  block: difference storage implementation
  block: snapshot and snapshot image block device
  block: Kconfig, Makefile and MAINTAINERS files

 Documentation/block/blkfilter.rst             |  66 ++
 Documentation/block/blksnap.rst               | 351 ++++++++++
 Documentation/block/index.rst                 |   2 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |  17 +
 block/Makefile                                |   3 +-
 block/bdev.c                                  |   2 +
 block/blk-core.c                              |  26 +-
 block/blk-filter.c                            | 257 +++++++
 block/blk-mq.c                                |   7 +-
 block/blk-mq.h                                |   2 +-
 block/blk.h                                   |  11 +
 block/genhd.c                                 |  10 +
 block/ioctl.c                                 |   7 +
 block/partitions/core.c                       |   9 +
 drivers/block/Kconfig                         |   2 +
 drivers/block/Makefile                        |   2 +
 drivers/block/blksnap/Kconfig                 |  12 +
 drivers/block/blksnap/Makefile                |  15 +
 drivers/block/blksnap/cbt_map.c               | 225 +++++++
 drivers/block/blksnap/cbt_map.h               |  90 +++
 drivers/block/blksnap/chunk.c                 | 631 ++++++++++++++++++
 drivers/block/blksnap/chunk.h                 | 134 ++++
 drivers/block/blksnap/diff_area.c             | 577 ++++++++++++++++
 drivers/block/blksnap/diff_area.h             | 175 +++++
 drivers/block/blksnap/diff_buffer.c           | 114 ++++
 drivers/block/blksnap/diff_buffer.h           |  37 +
 drivers/block/blksnap/diff_storage.c          | 290 ++++++++
 drivers/block/blksnap/diff_storage.h          | 103 +++
 drivers/block/blksnap/event_queue.c           |  81 +++
 drivers/block/blksnap/event_queue.h           |  64 ++
 drivers/block/blksnap/main.c                  | 481 +++++++++++++
 drivers/block/blksnap/params.h                |  16 +
 drivers/block/blksnap/snapimage.c             | 135 ++++
 drivers/block/blksnap/snapimage.h             |  10 +
 drivers/block/blksnap/snapshot.c              | 462 +++++++++++++
 drivers/block/blksnap/snapshot.h              |  65 ++
 drivers/block/blksnap/tracker.c               | 369 ++++++++++
 drivers/block/blksnap/tracker.h               |  78 +++
 include/linux/blk-filter.h                    |  72 ++
 include/linux/blk_types.h                     |   1 +
 include/linux/sched.h                         |   1 +
 include/uapi/linux/blk-filter.h               |  35 +
 include/uapi/linux/blksnap.h                  | 384 +++++++++++
 include/uapi/linux/fs.h                       |   3 +
 45 files changed, 5430 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/block/blkfilter.rst
 create mode 100644 Documentation/block/blksnap.rst
 create mode 100644 block/blk-filter.c
 create mode 100644 drivers/block/blksnap/Kconfig
 create mode 100644 drivers/block/blksnap/Makefile
 create mode 100644 drivers/block/blksnap/cbt_map.c
 create mode 100644 drivers/block/blksnap/cbt_map.h
 create mode 100644 drivers/block/blksnap/chunk.c
 create mode 100644 drivers/block/blksnap/chunk.h
 create mode 100644 drivers/block/blksnap/diff_area.c
 create mode 100644 drivers/block/blksnap/diff_area.h
 create mode 100644 drivers/block/blksnap/diff_buffer.c
 create mode 100644 drivers/block/blksnap/diff_buffer.h
 create mode 100644 drivers/block/blksnap/diff_storage.c
 create mode 100644 drivers/block/blksnap/diff_storage.h
 create mode 100644 drivers/block/blksnap/event_queue.c
 create mode 100644 drivers/block/blksnap/event_queue.h
 create mode 100644 drivers/block/blksnap/main.c
 create mode 100644 drivers/block/blksnap/params.h
 create mode 100644 drivers/block/blksnap/snapimage.c
 create mode 100644 drivers/block/blksnap/snapimage.h
 create mode 100644 drivers/block/blksnap/snapshot.c
 create mode 100644 drivers/block/blksnap/snapshot.h
 create mode 100644 drivers/block/blksnap/tracker.c
 create mode 100644 drivers/block/blksnap/tracker.h
 create mode 100644 include/linux/blk-filter.h
 create mode 100644 include/uapi/linux/blk-filter.h
 create mode 100644 include/uapi/linux/blksnap.h

-- 
2.34.1


