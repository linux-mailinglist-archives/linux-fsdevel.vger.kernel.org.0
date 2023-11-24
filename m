Return-Path: <linux-fsdevel+bounces-3686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BBD7F789E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5831C20929
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7448234197;
	Fri, 24 Nov 2023 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ufUApXbk"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 325 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 08:10:32 PST
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ae])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A7C1B5
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 08:10:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700841904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9n3c1WXBz4lxlyB6dBEMGNuqryUbttK1iJefoc3GvV0=;
	b=ufUApXbkL4u8/4es/MN12fyBMDrWdeSuZO9T4Q4cExLIsNgxLNsikNO3pQoyjRxWphsZHt
	RPTGkMn6TAouyrZgF+bHYgVnl0El5K+X0TznhffRH0f3w6HUZCsG6AKZsm2DRoIiLuLgIw
	53LePh6Cp2om5pkGkFD0Jc1WCwg/6cE=
From: Sergei Shtepa <sergei.shtepa@linux.dev>
To: axboe@kernel.dk,
	hch@infradead.org,
	corbet@lwn.net,
	snitzer@kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	christian.koenig@amd.com,
	yi.l.liu@intel.com,
	jirislaby@kernel.org,
	stfrench@microsoft.com,
	jpanis@baylibre.com,
	jgg@ziepe.ca,
	contact@emersion.fr,
	dchinner@redhat.com,
	jack@suse.cz,
	linux@weissschuh.net,
	min15.li@samsung.com,
	dlemoal@kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v6 00/11] blksnap - block devices snapshots module
Date: Fri, 24 Nov 2023 17:04:48 +0100
Message-Id: <20231124160459.26227-1-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Sergei Shtepa <sergei.shtepa@veeam.com>

Hi all.

I am happy to offer an improved version of the Block Devices Snapshots
Module. It allows creating non-persistent snapshots of any block devices.
The main purpose of such snapshots is to provide backups of block devices.
See more in Documentation/block/blksnap.rst.

The Block Device Filtering Mechanism is added to the block layer. This
allows attaching and detaching block device filters to the block layer.
Filters allow extending the functionality of the block layer. See more
in Documentation/block/blkfilter.rst.

The tool, library and tests for working with blksnap can be found on github.
Link: https://github.com/veeam/blksnap/tree/stable-v2.0
From the documentation, it is possible to learn how to manage the module
using the library and console tool.

In the new version, the method of saving snapshot difference has been
changed. Why this should have been done, Dave Chinner <david@fromorbit.com>
described in detail in the comments to the previous version.
Link: https://lore.kernel.org/lkml/20230612135228.10702-1-sergei.shtepa@veeam.com/T/#mfe9b8f46833011deea4b24714212230ac38db978

The module is incompatible with features hardware inline encryption and
data integrity. Thanks to Eric Biggers <ebiggers@kernel.org>.
Link: https://lore.kernel.org/lkml/20230612135228.10702-1-sergei.shtepa@veeam.com/T/#m3f13e580876bff1d283eb2a79d1ecdef3b98cc42
Unfortunately, I didn't have a chance to check it, since I don't have such
equipment.

And it is impossible to determine the presence of a blk-crypto-fallback at
the block layer filter level. The filter receives already encrypted data.
The original device continues to work without problems, but the data in
the snapshot is encrypted. Perhaps they can be decrypted if specify the
correct key when mounting the file system for snapshot image.

Tested on amd64 and ppc64le with a page size of 64KiB and a storage block
size of 4KiB.

Based on LK v6.7-rc2.
Compatible with branch 'for-next'.
link: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git 

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


Sergei Shtepa (11):
  documentation: Block Device Filtering Mechanism
  block: Block Device Filtering Mechanism
  documentation: Block Devices Snapshots Module
  blksnap: header file of the module interface
  blksnap: module management interface functions
  blksnap: handling and tracking I/O units
  blksnap: difference storage and chunk
  blksnap: event queue from the difference storage
  blksnap: snapshot and snapshot image block device
  blksnap: Kconfig and Makefile
  blksnap: prevents using devices with data integrity or inline
    encryption

 Documentation/block/blkfilter.rst             |  66 ++
 Documentation/block/blksnap.rst               | 352 +++++++++
 Documentation/block/index.rst                 |   2 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |  17 +
 block/Makefile                                |   3 +-
 block/bdev.c                                  |   2 +
 block/blk-core.c                              |  35 +-
 block/blk-filter.c                            | 238 +++++++
 block/blk.h                                   |  11 +
 block/genhd.c                                 |  10 +
 block/ioctl.c                                 |   7 +
 block/partitions/core.c                       |   9 +
 drivers/block/Kconfig                         |   2 +
 drivers/block/Makefile                        |   2 +
 drivers/block/blksnap/Kconfig                 |  31 +
 drivers/block/blksnap/Makefile                |  15 +
 drivers/block/blksnap/cbt_map.c               | 228 ++++++
 drivers/block/blksnap/cbt_map.h               |  90 +++
 drivers/block/blksnap/chunk.c                 | 667 ++++++++++++++++++
 drivers/block/blksnap/chunk.h                 | 142 ++++
 drivers/block/blksnap/diff_area.c             | 601 ++++++++++++++++
 drivers/block/blksnap/diff_area.h             | 175 +++++
 drivers/block/blksnap/diff_buffer.c           | 115 +++
 drivers/block/blksnap/diff_buffer.h           |  37 +
 drivers/block/blksnap/diff_storage.c          | 291 ++++++++
 drivers/block/blksnap/diff_storage.h          | 104 +++
 drivers/block/blksnap/event_queue.c           |  81 +++
 drivers/block/blksnap/event_queue.h           |  64 ++
 drivers/block/blksnap/main.c                  | 475 +++++++++++++
 drivers/block/blksnap/params.h                |  16 +
 drivers/block/blksnap/snapimage.c             | 134 ++++
 drivers/block/blksnap/snapimage.h             |  10 +
 drivers/block/blksnap/snapshot.c              | 457 ++++++++++++
 drivers/block/blksnap/snapshot.h              |  64 ++
 drivers/block/blksnap/tracker.c               | 358 ++++++++++
 drivers/block/blksnap/tracker.h               |  78 ++
 include/linux/blk-filter.h                    |  51 ++
 include/linux/blk_types.h                     |   1 +
 include/linux/blkdev.h                        |   1 +
 include/linux/sched.h                         |   1 +
 include/uapi/linux/blk-filter.h               |  35 +
 include/uapi/linux/blksnap.h                  | 388 ++++++++++
 include/uapi/linux/fs.h                       |   3 +
 44 files changed, 5468 insertions(+), 2 deletions(-)
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
2.20.1


