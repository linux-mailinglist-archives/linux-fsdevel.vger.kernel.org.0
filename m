Return-Path: <linux-fsdevel+bounces-18121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744958B5F85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE982824E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B838626C;
	Mon, 29 Apr 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC+zoKUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6D83CBA;
	Mon, 29 Apr 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410287; cv=none; b=MwN8hfsIm646+3zw01wUEB6ZW/nW3uMWJKXv7hP4mjE3D6//DKdqSIVTelHhWXkBm1QguDz1iP6Uqi8jO+v5xYaT9+kwBEmurHQ6VrCXoJbA4zwgiDHcQBW2+816OlKVcmDJSRLRqS69b9Eq6w1B0M1tje5GjNvwWWyUNcx+LOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410287; c=relaxed/simple;
	bh=406UyyCNXuQMSCeHMNLWEMWlQ3MJe0W5p67vimEObXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cgIDSFS4UhVhhcOEJgjxYas2+528KbU5Lo9S21+JrLsmfyh4Dwo3vhUVcG318m6jXwlWL/IOsfw/J9NCf2YDh7GwU7qjl5gX4Xo6+lTE/N/GYZprUeqAlrIg+YO36GtIFLuFGfzVvlFr637oJG3ajJcmSEXkg0WL1LAQja/kPIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aC+zoKUW; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6eb812370a5so3003151a34.0;
        Mon, 29 Apr 2024 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410283; x=1715015083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rgRul3U5v9acsobhaA3nd7aLEZVuwb++QdqBbnvaYQA=;
        b=aC+zoKUW9fmEF6UKjfrdJEqkOYxLi8hg9sIyC1rt/3Nb8uTBdQki0Sv5+YvBLgspFb
         7eTFXEJTJL4NDXCxpf72OL195X7ZtoJ/zNn2gswOPzTFnmCXCRMWlNHaITVZNjW4Zrnq
         jhO4+z+Og+iN3i3qI9quQi9PQAhZ1gZeR5V8e5l0tdIYs5XvpDKQqKDviF9USq6ZvKdW
         5rLzpEJiD4wXv7bXgjTIXOVPy5zD6bce4dITZgO/EfHbuEKz6UfWiGulqxAsB841Eyt+
         47XV04Ggl+MBCL+7fFbjC5SSn0zQUdx/npG/baTrhw4sQjL5Q+0NfzDPpLdG1xam4w+5
         dR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410283; x=1715015083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgRul3U5v9acsobhaA3nd7aLEZVuwb++QdqBbnvaYQA=;
        b=hxfLORXAHrDwLEO17akmgtMqa5I9u52lsbUfnmbn12ImGmXw1ZivtLNUKuBGi7+hlk
         E1n8iuAnpL4ubvxU/wzUX95tiutjuGjSxv9ZvQh2qCL+rusTeIou4kJhRsFp4aZf7LE4
         40qDP8HXufXnGIJf4PBfhJ7WdYhLNe/RZy3nQhscqYqc3lj1SC13zlb/Vb8j5IQX5XOS
         DGc8tXhuxMQJIoOXTt+YldNZjrPfB/+gybDxxF0NXNays/hDMf/rZ6BpCwjpbhxfPZVL
         yhMiKZ3zi4paWgkNnZ5RPxrLU8UnkuP/InuofxYma6PJo81qAae/gzlCFxazoOhFqHK3
         ZMyw==
X-Forwarded-Encrypted: i=1; AJvYcCW8ve05CQFCiubZUKtTNZ7A6Tdo8ffCN4U8uuj2YIi1rO1ppU6DvUAojLRVqk1iwvANpIqnGer+LxMKm4YUhZYbuTUqDXaIS2BIfuUHzs8v5/QJJFXLTo/OyERNWcF0xcIet3dWnJVeng==
X-Gm-Message-State: AOJu0YzHxfzIQyhiiHqxeUTtXb8nl2AaoHiJjaCLyHFbhieEk2Wpx6rl
	Cgd3BKXXD8Zl324y1C1b5IMCwEmEbEx1izgZ5PhbUjwBcLOUZ0A3
X-Google-Smtp-Source: AGHT+IFxPSSRzmHNvqw0KC8EJtbzVdvh4LgLWNJl5h5R7jiMGR0wrT/ik+s7kGuGqfjVdLGzzxHIjA==
X-Received: by 2002:a9d:5f04:0:b0:6eb:70c6:5aa4 with SMTP id f4-20020a9d5f04000000b006eb70c65aa4mr13203764oti.14.1714410283334;
        Mon, 29 Apr 2024 10:04:43 -0700 (PDT)
Received: from localhost.localdomain ([70.114.203.196])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6201000000b006ea20712e66sm4074448otj.17.2024.04.29.10.04.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 10:04:43 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John Groves <jgroves@micron.com>,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	Randy Dunlap <rdunlap@infradead.org>,
	Jerome Glisse <jglisse@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Ravi Shankar <venkataravis@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steve French <stfrench@microsoft.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Stanislav Fomichev <sdf@google.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	John Groves <john@groves.net>
Subject: [RFC PATCH v2 00/12] Introduce the famfs shared-memory file system
Date: Mon, 29 Apr 2024 12:04:16 -0500
Message-Id: <cover.1714409084.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set introduces famfs[1] - a special-purpose fs-dax file system
for sharable disaggregated or fabric-attached memory (FAM). Famfs is not
CXL-specific in anyway way.

* Famfs creates a simple access method for storing and sharing data in
  sharable memory. The memory is exposed and accessed as memory-mappable
  dax files.
* Famfs supports multiple hosts mounting the same file system from the
  same memory (something existing fs-dax file systems don't do).
* A famfs file system can be created on a /dev/dax device in devdax mode,
  which rests on dax functionality added in patches 2-7 of this series.

The famfs kernel file system is part the famfs framework; additional
components in user space[2] handle metadata and direct the famfs kernel
module to instantiate files that map to specific memory. The famfs user
space has documentation and a reasonably thorough test suite.

The famfs kernel module never accesses the shared memory directly (either
data or metadata). Because of this, shared memory managed by the famfs
framework does not create a RAS "blast radius" problem that should be able
to crash or de-stabilize the kernel. Poison or timeouts in famfs memory
can be expected to kill apps via SIGBUS and cause mounts to be disabled
due to memory failure notifications.

Famfs does not attempt to solve concurrency or coherency problems for apps,
although it does solve these problems in regard to its own data structures.
Apps may encounter hard concurrency problems, but there are use cases that
are imminently useful and uncomplicated from a concurrency perspective:
serial sharing is one (only one host at a time has access), and read-only
concurrent sharing is another (all hosts can read-cache without worry).

Contents:

* famfs kernel documentation [patch 1]. Note that evolving famfs user
  documentation is at [2]
* dev_dax_iomap patchset [patches 2-7] - This enables fs-dax to use the
  iomap interface via a character /dev/dax device (e.g. /dev/dax0.0). For
  historical reasons the iomap infrastructure was enabled only for
  /dev/pmem devices (which are dax block devices). As famfs is the first
  fs-dax file system that works on /dev/dax, this patch series fills in
  the bare minimum infrastructure to enable iomap api usage with /dev/dax.
* famfs patchset [patches 8-12] - this introduces the kernel component of
  famfs.

Note that there is a developing consensus that /dev/dax requires
some fundamental re-factoring (e.g. [3]) that is related but outside the
scope of this series.

Some observations about using sharable memory

* It does not make sense to online sharable memory as system-ram.
  System-ram gets zeroed when it is onlined, so sharing is basically
  nonsense.
* It does not make sense to put struct page's in sharable memory, because
  those can't be shared. However, separately providing non-sharable
  capacity to be used for struct page's might be a sensible approach if the
  size of struct page array for sharable memory is too large to put in
  conventional system-ram (albeit with possible RAS implications).
* Sharable memory is pmem-like, in that a host is likely to connect in
  order to gain access to data that is already in the memory. Moreover
  the power domain for shared memory is separate for that of the server.
  Having observed that, famfs is not intended for persistent storage. It is
  intended for sharing data sets in memory during a time frame where the
  memory and the compute nodes are expected to remain operational - such
  as during a clustered data analytics job.

Could we do this with FUSE?

The key performance requirement for famfs is efficient handling of VMA
faults. This requires caching the complete dax extent lists for all active
files so faults can be handled without upcalls, which FUSE does not do.
It would probably be possible to put this capability FUSE, but we think
that keeping famfs separate from FUSE is the simpler approach.

We will be discussing this topic at LSFMM 2024 [5] in a topic called "Famfs:
new userspace filesystem driver vs. improving FUSE/DAX" - but other famfs
related discussion will also be welcome!

This patch set is available as a branch at [6]

References

[1] https://lpc.events/event/17/contributions/1455/
[2] https://github.com/cxl-micron-reskit/famfs
[3] https://lore.kernel.org/all/166630293549.1017198.3833687373550679565.stgit@dwillia2-xfh.jf.intel.com/
[4] https://www.computeexpresslink.org/download-the-specification
[5] https://events.linuxfoundation.org/lsfmmbpf/program/schedule-at-a-glance/
[6] https://github.com/cxl-micron-reskit/famfs-linux/tree/famfs-v2


Changes since RFC v1:


* This patch series is a from-scratch refactor of the original. The code
  that maps a file to a dax device is almost identical, but a lot of
  cleanup has been done.
* The get_tree and backing device handling code has been ripped up and
  re-done (in the get-tree case, based on suggestions from Christian
  Brauner - thanks Christian; I hope I haven't done any new dumb stuff!)
  (Note this code has been extensively tested; after all known error cases
  famfs can be umounted and the module can be unloaded)
* Famfs now 'shuts down' if the dax device reports any memory errors. I/O
  and faults start reporting SIGBUS. Famfs detects memory errors via an
  iomap_ops->notify failure call from the devdax layer. This has been tested
  and appears to disable the famfs file system while leaving it able to
  dismount cleanly.
* Dropped fault counters
* Dropped support for symlinks wtihin a famfs file system; we don't think
  supporting symlinks makes sense with famfs, and it has some undesirable
  side effects, so it's out.
* Dropped support for mknod within a famfs file system (other than regular
  files and directories)
* Famfs magic number moved to magic.h
* Famfs ioctl opcodes now documented in
  Documentation/userspace-api/ioctl/ioctl-number.rst
* Dodgy kerneldoc comments cleaned up or removed; hopefully none added...
* Kconfig formatting cleaned up
* Dropped /dev/pmem support. Prior patch series would mount on either
  /dev/pmem or /dev/dax devices. This is unnecessary complexity since
  /ddev/pmem devices can be converted to /dev/dax. Famfs is, however, the
  first file system we know of that mounts from a character device.
* Famfs no longer does a filp_open() of the dax device. It finds the
  device by its dev_t and uses fs_dax_get() to effect exclusivity.
* Added a read-only module param famfs_kabi_version for checkout
  that user space was compiled for the same ABI version
* The famfs kernel module (the code in fs/famfs plus the uapi file
  famfs_ioctl.c dropped from 1030 lines of code in v1 to 760 in v2,
  according to "cloc".
* Fixed issues reported by the kernel test robot
* Many minor improvements in response to v1 code reviews


John Groves (12):
  famfs: Introduce famfs documentation
  dev_dax_iomap: Move dax_pgoff_to_phys() from device.c to bus.c
  dev_dax_iomap: Add fs_dax_get() func to prepare dax for fs-dax usage
  dev_dax_iomap: Save the kva from memremap
  dev_dax_iomap: Add dax_operations for use by fs-dax on devdax
  dev_dax_iomap: export dax_dev_get()
  famfs prep: Add fs/super.c:kill_char_super()
  famfs: module operations & fs_context
  famfs: Introduce inode_operations and super_operations
  famfs: Introduce file_operations read/write
  famfs: Introduce mmap and VM fault handling
  famfs: famfs_ioctl and core file-to-memory mapping logic & iomap_ops

 Documentation/filesystems/famfs.rst           | 135 ++++
 Documentation/filesystems/index.rst           |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |  11 +
 drivers/dax/Kconfig                           |   6 +
 drivers/dax/bus.c                             | 144 ++++-
 drivers/dax/dax-private.h                     |   1 +
 drivers/dax/device.c                          |  38 +-
 drivers/dax/super.c                           |  33 +-
 fs/Kconfig                                    |   2 +
 fs/Makefile                                   |   1 +
 fs/famfs/Kconfig                              |  10 +
 fs/famfs/Makefile                             |   5 +
 fs/famfs/famfs_file.c                         | 605 ++++++++++++++++++
 fs/famfs/famfs_inode.c                        | 452 +++++++++++++
 fs/famfs/famfs_internal.h                     |  52 ++
 fs/namei.c                                    |   1 +
 fs/super.c                                    |   9 +
 include/linux/dax.h                           |   6 +
 include/linux/fs.h                            |   1 +
 include/uapi/linux/famfs_ioctl.h              |  61 ++
 include/uapi/linux/magic.h                    |   1 +
 22 files changed, 1547 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/filesystems/famfs.rst
 create mode 100644 fs/famfs/Kconfig
 create mode 100644 fs/famfs/Makefile
 create mode 100644 fs/famfs/famfs_file.c
 create mode 100644 fs/famfs/famfs_inode.c
 create mode 100644 fs/famfs/famfs_internal.h
 create mode 100644 include/uapi/linux/famfs_ioctl.h


base-commit: ed30a4a51bb196781c8058073ea720133a65596f
-- 
2.43.0


