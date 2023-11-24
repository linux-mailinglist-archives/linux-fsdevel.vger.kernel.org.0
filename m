Return-Path: <linux-fsdevel+bounces-3689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0DD7F78A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C45E5B21668
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2933CF4;
	Fri, 24 Nov 2023 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J7Lzh9/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E165A19B1;
	Fri, 24 Nov 2023 08:10:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700841908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDyOlhsQ3H7gKFA4WT2r4Df9eQ2QXv4dHEaGU3xXd2I=;
	b=J7Lzh9/scvaiTfqId+dWpkR4jUqnIolW7YbrwVLXhNkBnmOrZWjZBvWw9itFxUOAcgcQsT
	0nRQQ6HyJltwvPjVq60ecfPpzIOTTDROL8AsuhVyhb8WImgxb+YZvwixE4C17dW4sg8MMX
	RkcxedXWBcBfh/1Boj0DJqctWzlAmZE=
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
	Sergei Shtepa <sergei.shtepa@veeam.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Fabio Fantoni <fantonifabio@tiscali.it>
Subject: [PATCH v6 03/11] documentation: Block Devices Snapshots Module
Date: Fri, 24 Nov 2023 17:04:51 +0100
Message-Id: <20231124160459.26227-4-sergei.shtepa@linux.dev>
In-Reply-To: <20231124160459.26227-1-sergei.shtepa@linux.dev>
References: <20231124160459.26227-1-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Sergei Shtepa <sergei.shtepa@veeam.com>

The document contains:
* Describes the purpose of the mechanism
* Description of features
* Description of algorithms
* Recommendations about using the module from the user-space side
* Reference to module interface description

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Fabio Fantoni <fantonifabio@tiscali.it>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 Documentation/block/blksnap.rst | 352 ++++++++++++++++++++++++++++++++
 Documentation/block/index.rst   |   1 +
 MAINTAINERS                     |   6 +
 3 files changed, 359 insertions(+)
 create mode 100644 Documentation/block/blksnap.rst

diff --git a/Documentation/block/blksnap.rst b/Documentation/block/blksnap.rst
new file mode 100644
index 000000000000..ef6010e46858
--- /dev/null
+++ b/Documentation/block/blksnap.rst
@@ -0,0 +1,352 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+Block Devices Snapshots Module (blksnap)
+========================================
+
+Introduction
+============
+
+At first glance, there is no novelty in the idea of creating snapshots for
+block devices. The Linux kernel already has mechanisms for creating snapshots.
+Device Mapper includes dm-snap, which allows to create snapshots of block
+devices. BTRFS supports snapshots at the filesystem level. However, both of
+these options have flaws that do not allow to use them as a universal tool for
+creating backups.
+
+The main properties that a backup tool should have are:
+
+- Simplicity and universality of use
+- Reliability
+- Minimal consumption of system resources during backup
+- Minimal time required for recovery or replication of the entire system
+
+Taking above properties into account, blksnap module features:
+
+- Change tracker
+- Snapshots at the block device level
+- Dynamic allocation of space for storing differences
+- Snapshot overflow resistance
+- Coherent snapshot of multiple block devices
+
+Features
+========
+
+Change tracker
+--------------
+
+The change tracker allows to determine which blocks were changed during the
+time between the last snapshot created and any of the previous snapshots.
+With a map of changes, it is enough to copy only the changed blocks, and no
+need to reread the entire block device completely. The change tracker allows
+to implement the logic of both incremental and differential backups.
+Incremental backup is critical for large file repositories whose size can be
+hundreds of terabytes and whose full backup time can take more than a day.
+On such servers, the use of backup tools without a change tracker becomes
+practically impossible.
+
+Snapshot at the block device level
+----------------------------------
+
+A snapshot at the block device level allows to simplify the backup algorithm
+and reduce consumption of system resources. It also allows to perform linear
+reading of disk space directly, which allows to achieve maximum reading speed
+with minimal use of processor time. At the same time, the universality of
+creating snapshots for any block device is achieved, regardless of the file
+system located on it. The exceptions are BTRFS, ZFS and cluster file systems.
+
+Dynamic allocation of storage space for differences
+---------------------------------------------------
+
+To store differences, the module does not require a pre-reserved space on
+filesystem. The space for storing differences can be allocated in file in any
+filesystem. In addition, the size of the difference storage can be increased
+after the snapshot is created, but only for a filesystem that supports
+fallocate. A shared difference storage for all images of snapshot block devices
+allows to optimize the use of storage space. However, there is one limitation.
+A snapshot cannot be taken from a block device on which the difference storage
+is located.
+
+Snapshot overflow resistance
+----------------------------
+
+To create images of snapshots of block devices, the module stores blocks
+of the original block device that have been changed since the snapshot
+was taken. To do this, the module handles write requests and reads blocks
+that need to be overwritten. This algorithm guarantees safety of the data
+of the original block device in the event of an overflow of the snapshot,
+and even in the case of unpredictable critical errors. If a problem occurs
+during backup, the difference storage is released, the snapshot is closed,
+no backup is created, but the server continues to work.
+
+Coherent snapshot of multiple block devices
+-------------------------------------------
+
+A snapshot is created simultaneously for all block devices for which a backup
+is being created, ensuring their coherent state.
+
+
+Algorithms
+==========
+
+Overview
+--------
+
+The blksnap module is a block-level filter. It handles all write I/O units.
+The filter is attached to the block device when the snapshot is created
+for the first time. The change tracker marks all overwritten blocks.
+Information about the history of changes on the block device is available
+while holding the snapshot. The module reads the blocks that need to be
+overwritten and stores them in the difference storage. When reading from
+a snapshot image, reading is performed either from the original device or
+from the difference storage.
+
+Change tracking
+---------------
+
+A change tracker map is created for each block device. One byte of this map
+corresponds to one block. The block size is set by the
+``tracking_block_minimum_shift`` and ``tracking_block_maximum_count``
+module parameters. The ``tracking_block_minimum_shift`` parameter limits
+the minimum block size for tracking, while ``tracking_block_maximum_count``
+defines the maximum allowed number of blocks. The size of the change tracker
+block is determined depending on the size of the block device when adding
+a tracking device, that is, when the snapshot is taken for the first time.
+The block size must be a power of two. The ``tracking_block_maximum_shift``
+module parameter allows to limit the maximum block size for tracking. If the
+block size reaches the allowable limit, the number of blocks will exceed the
+``tracking_block_maximum_count`` parameter.
+
+The byte of the change map stores a number from 0 to 255. This is the
+snapshot number, since the creation of which there have been changes in
+the block. Each time a snapshot is created, the number of the current
+snapshot is increased by one. This number is written to the cell of the
+change map when writing to the block. Thus, knowing the number of one of
+the previous snapshots and the number of the last snapshot, one can determine
+from the change map which blocks have been changed. When the number of the
+current change reaches the maximum allowed value for the map of 255, at the
+time when the next snapshot is created, the map of changes is reset to zero,
+and the number of the current snapshot is assigned the value 1. The change
+tracker is reset, and a new UUID is generated - a unique identifier of the
+snapshot generation. The snapshot generation identifier allows to identify
+that a change tracking reset has been performed.
+
+The change map has two copies. One copy is active, it tracks the current
+changes on the block device. The second copy is available for reading
+while the snapshot is being held, and contains the history up to the moment
+the snapshot is taken. Copies are synchronized at the moment of snapshot
+creation. After the snapshot is released, a second copy of the map is not
+needed, but it is not released, so as not to allocate memory for it again
+the next time the snapshot is created.
+
+Copy on write
+-------------
+
+Data is copied in blocks, or rather in chunks. The term "chunk" is used to
+avoid confusion with change tracker blocks and I/O blocks. In addition,
+the "chunk" in the blksnap module means about the same as the "chunk" in
+the dm-snap module.
+
+The size of the chunk is determined by the ``chunk_minimum_shift`` and
+``chunk_maximum_count`` module parameters. The ``chunk_minimum_shift``
+parameter limits the minimum size of the chunk, while ``chunk_maximum_count``
+defines the maximum allowed number of chunks. The size of the chunk is
+determined depending on the size of the block device at the time of taking the
+snapshot. The size of the chunk must be a power of two. The module parameter
+``chunk_maximum_shift`` allows to limit the maximum chunk size. If the chunk
+size reaches the allowable limit, the number of chunks will exceed the
+``chunk_maximum_count`` parameter.
+
+One chunk is described by the ``struct chunk`` structure. A map of structures
+is created for each block device. The structure contains all the necessary
+information to copy the chunks data from the original block device to the
+difference storage. This information allows to describe the snapshot image.
+A semaphore is located in the structure, which allows synchronization of threads
+accessing the chunk.
+
+The block level in Linux has a feature. If a read I/O unit was sent, and a
+write I/O unit was sent after it, then a write can be performed first, and only
+then a read. Therefore, the copy-on-write algorithm is executed synchronously.
+If the write request is handled, the execution of this I/O unit will be delayed
+until the overwritten chunks are read from the original device for later
+storing to the difference store. But if, when handling a write I/O unit, it
+turns out that the written range of sectors has already been prepared for
+storing to the difference storage, then the I/O unit is simply passed.
+
+This algorithm makes it possible to efficiently perform backup even systems
+with a Round-Robin databases. Such databases can be overwritten several times
+during the system backup. Of course, the value of a backup of the RRD monitoring
+system data can be questioned. However, it is often a task to make a backup
+of the entire enterprise infrastructure in order to restore or replicate it
+entirely in case of problems.
+
+There is also a flaw in the algorithm. When overwriting at least one sector,
+an entire chunk is copied. Thus, a situation of rapid filling of the difference
+storage when writing data to a block device in small portions in random order
+is possible. This situation is possible in case of strong fragmentation of
+data on the filesystem. But it must be borne in mind that with such data
+fragmentation, performance of systems usually degrades greatly. So, this
+problem does not occur on real servers, although it can easily be created
+by artificial tests.
+
+Difference storage
+------------------
+
+The difference storage can be a block device or it can be a file on a
+filesystem. Using a block device allows to achieve slightly higher performance,
+but in this case, the block device is used by the kernel module exclusively.
+Usually the disk space is marked up so that there is no available free space
+for backup purposes. Using a file allows to place the difference storage on a
+filesystem.
+
+The difference storage can be expanded already while the snapshot is being held,
+but only if the filesystem supports fallocate(). If the free space in the
+difference storage remains less than half of the value of the module parameter
+``diff_storage_minimum``, then the kernel module can expand the difference
+storage  file within the specified limits. This limit is set when creating a
+snapshot.
+
+If free space in the difference storage runs out, an event to user land is
+generated about the overflow of the snapshot. Such a snapshot is considered
+corrupted, and read I/O units to snapshot images will be terminated with an
+error code. The difference storage stores outdated data required for snapshot
+images, so when the snapshot is overflowed, the backup process is interrupted,
+but the system maintains its operability without data loss.
+
+The difference storage has a limitation. The device cannot be added to the
+snapshot where the difference storage is located. In this case, the difference
+storage can be located in virtual memory, which consists of RAM and a swap
+partition (or file). To do this, it is enough to use a file in /dev/shm, or a
+new tmpfs filesystem can be created for this purpose. Obviously, this variant
+can be useful if the system has a lot of RAM or a large swap. The good news is
+that the modern Linux kernel allows to increase the size of the swap file "on
+the fly" without changing the system configuration.
+
+A regular file or a block device file for the difference storage must be opened
+with the O_EXCL flag. If an unnamed file with the O_TMPFILE flag is created,
+then such a file will be automatically released when the snapshot is destroyed.
+In addition, the use of an unnamed temporary file ensures that no one can open
+this file and read its contents.
+
+Performing I/O for a snapshot image
+-----------------------------------
+
+To read snapshot data, when taking a snapshot, block devices of snapshot images
+are created. The snapshot image block devices support the write operation.
+This allows to perform additional data preparation on the filesystem before
+creating a backup.
+
+To process the I/O unit, clones of the I/O unit are created, which redirect
+the I/O unit either to the original block device or to the difference storage.
+When processing of cloned I/O units is completed, the original I/O unit is
+marked as completed too.
+
+An I/O unit can be partially processed without accessing to block devices if
+the I/O unit refers to a chunk that is in the queue for storing to the
+difference storage. In this case, the data is read or written in a buffer in
+memory.
+
+If, when processing the write I/O unit, it turns out that the data of the
+referred chunk has not yet been stored to the difference storage or has not
+even been read from the original device, then an I/O unit to read data from the
+original device is initiated beforehand. After the reading from original device
+is performed, their data from the I/O unit is partially overwritten directly in
+the buffer of the chunk in memory, and the chunk is scheduled to be saved to the
+difference storage.
+
+How to use
+==========
+
+Depending on the needs and the selected license, you can choose different
+options for managing the module:
+
+- Using ioctl directly
+- Using a static C++ library
+- Using the blksnap console tool
+
+Using a BLKFILTER_CTL for block device
+--------------------------------------
+
+BLKFILTER_CTL allows to send a filter-specific command to the filter on block
+device and get the result of its execution. The module provides the
+``include/uapi/blksnap.h`` header file with a description of the commands and
+their data structures.
+
+1. ``blkfilter_ctl_blksnap_cbtinfo`` allows to get information from the
+   change tracker.
+2. ``blkfilter_ctl_blksnap_cbtmap`` reads the change tracker table. If a write
+   operation was performed for the snapshot, then the change tracker takes this
+   into account. Therefore, it is necessary to receive tracker data after write
+   operations have been completed.
+3. ``blkfilter_ctl_blksnap_cbtdirty`` mark blocks as changed in the change
+   tracker table. This is necessary if post-processing is performed after the
+   backup is created, which changes the backup blocks.
+4. ``blkfilter_ctl_blksnap_snapshotadd`` adds a block device to the snapshot.
+5. ``blkfilter_ctl_blksnap_snapshotinfo`` allows to get the name of the snapshot
+   image block device and the presence of an error.
+
+Using ioctl
+-----------
+
+Using a BLKFILTER_CTL ioctl does not allow to fully implement the management of
+the blksnap module. A control file ``blksnap-control`` is created to manage
+snapshots. The control commands are also described in the file
+``include/uapi/blksnap.h``.
+
+1. ``blksnap_ioctl_version`` get the version number.
+2. ``blk_snap_ioctl_snapshot_create`` initiates the snapshot creation process.
+3. ``blk_snap_ioctl_snapshot_append_storage`` add the range of blocks to
+   difference storage.
+4. ``blk_snap_ioctl_snapshot_take`` creates block devices of block device
+   snapshot images.
+5. ``blk_snap_ioctl_snapshot_collect`` collect all created snapshots.
+6. ``blk_snap_ioctl_snapshot_wait_event`` allows to track the status of
+   snapshots and receive events about the requirement to expand the difference
+   storage or about snapshot overflow.
+7. ``blk_snap_ioctl_snapshot_destroy`` releases the snapshot.
+
+Static C++ library
+------------------
+
+The [#userspace_libs]_ library was created primarily to simplify creation of
+tests in C++, and it is also a good example of using the module interface.
+When creating applications, direct use of control calls is preferable.
+However, the library can be used in an application with a GPL-2+ license,
+or a library with an LGPL-2+ license can be created, with which even a
+proprietary application can be dynamically linked.
+
+blksnap console tool
+--------------------
+
+The blksnap [#userspace_tools]_ console tool allows to control the module from
+the command line. The tool contains detailed built-in help. To get list of
+commands with usage description, see ``blksnap --help`` command. The ``blksnap
+<command name> --help`` command allows to get detailed information about the
+parameters of each command call. This option may be convenient when creating
+proprietary software, as it allows not to compile with the open source code.
+At the same time, the blksnap tool can be used for creating backup scripts.
+For example, rsync can be called to synchronize files on the filesystem of
+the mounted snapshot image and files in the archive on a filesystem that
+supports compression.
+
+Tests
+-----
+
+A set of tests was created for regression testing [#userspace_tests]_.
+Tests with simple algorithms that use the ``blksnap`` console tool to
+control the module are written in Bash. More complex testing algorithms
+are implemented in C++.
+
+References
+==========
+
+.. [#userspace_libs] https://github.com/veeam/blksnap/tree/stable-v2.0/lib
+
+.. [#userspace_tools] https://github.com/veeam/blksnap/tree/stable-v2.0/tools
+
+.. [#userspace_tests] https://github.com/veeam/blksnap/tree/stable-v2.0/tests
+
+Module interface description
+============================
+
+.. kernel-doc:: include/uapi/linux/blksnap.h
diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index e9712f72cd6d..696ff150c6b7 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -11,6 +11,7 @@ Block
    biovecs
    blk-mq
    blkfilter
+   blksnap
    cmdline-partition
    data-integrity
    deadline-iosched
diff --git a/MAINTAINERS b/MAINTAINERS
index ef90cd0fec9c..9c81e4c83139 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3593,6 +3593,12 @@ F:	block/blk-filter.c
 F:	include/linux/blk-filter.h
 F:	include/uapi/linux/blk-filter.h
 
+BLOCK DEVICE SNAPSHOTS MODULE
+M:	Sergei Shtepa <sergei.shtepa@veeam.com>
+L:	linux-block@vger.kernel.org
+S:	Supported
+F:	Documentation/block/blksnap.rst
+
 BLOCK LAYER
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
-- 
2.20.1


