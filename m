Return-Path: <linux-fsdevel+bounces-64109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF58BD93DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268951924762
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91703126CA;
	Tue, 14 Oct 2025 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GRcgBlLY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240E31282D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443815; cv=none; b=YPGqY2sDQDkZ/5yS+18Ov8vYvhQ14HzDd5I42IC56+WvP+02eMpeUkpD+Eci4OoqCELuhmP/Jty9ykVj9/Ercn6uLuRzx3rQ1KSQk0JzDue6T0ekRMAEK1ismh0F84WShgLfYOfLiIJgGKHYQ4sIcUe2RhxnoUGROfhGvq8D+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443815; c=relaxed/simple;
	bh=XLt1OQt5Z1A41rsu1zAu6iZKvY4alVXJiJaXxvwT/rY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=UkIVrA5ZMyqfddSQUGKHRu3wrAFOsamB9DpBk3qL0hMNf7HI3tzIOCv3AUBA+SjUkAADpWuBU3OgErqXjYsrXe2oi6ZFioVH9+0Usb/I2ryJeyTuZrmow09SZbx/Zx41IBudC+pLIW3hQ1PbKtJ0kx3sR3RHBeR05eRnYvzj1lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GRcgBlLY; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251014121001epoutp0350b95e90532da91417b87ce25c6a55ce~uWk9xH2Yf0346303463epoutp03T
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:10:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251014121001epoutp0350b95e90532da91417b87ce25c6a55ce~uWk9xH2Yf0346303463epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443801;
	bh=7WbTo3b87TcBxeQcwDkocdqHlwUoY6jjO0nBtSk6L5U=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GRcgBlLYxNu87I3PvSMG6Dx4PrFFyrG/RwaZ+XidMJv3bxIM44VDHh+QVtLc5Pw9C
	 GiGm5dW8gvNVYONT8gjs7Xd1iA/+vWtfqSMcuDuW8Q4aj04aU7i1BMiFKRToOouOQs
	 hlA59dPlHXulx17FxQl9mpUdsD33M3kevmK8n1nU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251014121000epcas5p370ee92deffaec925758512149fbf2723~uWk81_YMw2693726937epcas5p3q;
	Tue, 14 Oct 2025 12:10:00 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.87]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cmChR48YXz3hhTB; Tue, 14 Oct
	2025 12:09:59 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9~uWk7KDAhS1888418884epcas5p2o;
	Tue, 14 Oct 2025 12:09:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014120942epsmtip1ad7d573cabebcfc48960eafa87bdb869~uWkscrJqS1240212402epsmtip1J;
	Tue, 14 Oct 2025 12:09:42 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, kundan.kumar@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v2 00/16] Parallelizing filesystem writeback
Date: Tue, 14 Oct 2025 17:38:29 +0530
Message-Id: <20251014120845.2361-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>

Currently, pagecache writeback is performed by a single thread. Inodes
are added to a dirty list, and delayed writeback is triggered. The single
writeback thread then iterates through the dirty inode list, and executes
the writeback.

This series parallelizes the writeback by allowing multiple writeback
contexts per backing device (bdi). These writeback contexts are executed
as separate, independent threads, improving overall parallelism. Inodes
are distributed to these threads and are flushed in parallel.

This patchset applies cleanly on v6.17 kernel.

Design Overview
================
Following Jan Kara's suggestion [1], we have introduced a new bdi
writeback context within the backing_dev_info structure. Specifically,
we have created a new structure, bdi_writeback_context, which contains
its own set of members for each writeback context.

struct bdi_writeback_ctx {
        struct bdi_writeback wb;
        struct list_head wb_list; /* list of all wbs */
        struct radix_tree_root cgwb_tree;
        struct rw_semaphore wb_switch_rwsem;
        wait_queue_head_t wb_waitq;
};

There can be multiple writeback contexts in a bdi, which helps in
achieving writeback parallelism.

struct backing_dev_info {
...
        int nr_wb_ctx;
        struct bdi_writeback_ctx **wb_ctx;
...
};

FS geometry and filesystem fragmentation
========================================
The community was concerned that parallelizing writeback would impact
delayed allocation and increase filesystem fragmentation.
Our analysis of XFS delayed allocation behavior showed that merging of
extents occurs within a specific inode. Earlier experiments with multiple
writeback contexts [2] resulted in increased fragmentation due to the
same inode being processed by different threads.

To mitigate this issue, we ensure that an inode is always associated
with a specific writeback context, allowing delayed allocation to
function effectively.

Number of writeback contexts
============================
We've implemented two interfaces to manage the number of writeback
contexts:
1) Sysfs Interface: As suggested by Christoph, we've added a sysfs
   interface to allow users to adjust the number of writeback contexts
   dynamically.
2) Filesystem Superblock Interface: We've also introduced a filesystem
   superblock interface to retrieve the filesystem-specific number of
   writeback contexts. For XFS, this count is set equal to the
   allocation group count. When mounting a filesystem, we automatically
   increase the number of writeback threads to match this count.

Resolving the Issue with Multiple Writebacks
============================================
For XFS, affining inodes to writeback threads resulted in a decline
in IOPS for certain devices. The issue was caused by AG lock contention
in xfs_end_io, where multiple writeback threads competed for the same
AG lock.
To address this, we now affine writeback threads to the allocation
group, resolving the contention issue. In best case allocation happens
from the same AG where inode metadata resides, avoiding lock contention.

Similar IOPS decline was observed with other filesystems under different
workloads. To avoid similar issues, we have decided to limit
parallelism to XFS only. Other filesystems can introduce parallelism
and distribute inodes as per their geometry.

IOPS and throughput
===================
With the affinity to allocation group we see significant improvement in
XFS when we write to multiple files in different directories(AGs).

Performance gains:
  A) Workload 12 files each of 1G in 12 directories(AGs) - numjobs = 12
    - NVMe device BM1743 SSD
        Base XFS                : 243 MiB/s
        Parallel Writeback XFS  : 759 MiB/s  (+212%)

    - NVMe device PM9A3 SSD
        Base XFS                : 368 MiB/s
        Parallel Writeback XFS  : 1634 MiB/s  (+344%)

  B) Workload 6 files each of 20G in 6 directories(AGs)  - numjobs = 6
    - NVMe device BM1743 SSD
        Base XFS                : 305 MiB/s
        Parallel Writeback XFS  : 706 MiB/s  (+131%)

    - NVMe device PM9A3 SSD
        Base XFS                : 315 MiB/s
        Parallel Writeback XFS  : 990 MiB/s  (+214%)

Filesystem fragmentation
========================
We also see that there is no increase in filesystem fragmentation
Number of extents per file:
  A) Workload 6 files each 1G in single directory(AG)   - numjobs = 1
        Base XFS                : 17
        Parallel Writeback XFS  : 17

  B) Workload 12 files each of 1G to 12 directories(AGs)- numjobs = 12
        Base XFS                : 166593
        Parallel Writeback XFS  : 161554

  C) Workload 6 files each of 20G to 6 directories(AGs) - numjobs = 6
        Base XFS                : 3173716
        Parallel Writeback XFS  : 3364984

Testing using kdevops
=====================
1. fstests passed for XFS all profiles.
2. fstests passed for EXT4 and BTRFS also, these were tested for sanity.

Changes since v1:
 - Parallel writeback enabled for XFS only for optimal performance
 - Made writeback threads affined to allocation groups
 - Increase the number of writebacks threads to AG count at mount
 - Added sysfs entry to change the number of writebacks for a
   bdi(Christoph)
 - Added a filesystem interface to fetch 64 bit inode numbers (Christoph)
 - Made common helpers to contain writeback specific changes, which were
   affecting f2fs, fuse, gfs2 and nfs (Christoph)
 - Changed name from wb_ctx_arr to wb_ctx (Andrew Morton)

Kundan Kumar (16):
  writeback: add infra for parallel writeback
  writeback: add support to initialize and free multiple writeback ctxs
  writeback: link bdi_writeback to its corresponding bdi_writeback_ctx
  writeback: affine inode to a writeback ctx within a bdi
  writeback: modify bdi_writeback search logic to search across all wb
    ctxs
  writeback: invoke all writeback contexts for flusher and dirtytime
    writeback
  writeback: modify sync related functions to iterate over all writeback
    contexts
  writeback: add support to collect stats for all writeback ctxs
  f2fs: add support in f2fs to handle multiple writeback contexts
  fuse: add support for multiple writeback contexts in fuse
  gfs2: add support in gfs2 to handle multiple writeback contexts
  nfs: add support in nfs to handle multiple writeback contexts
  writeback: configure the num of writeback contexts between 0 and
    number of online cpus
  writeback: segregated allocation and free of writeback contexts
  writeback: added support to change the number of writebacks using a
    sysfs attribute
  writeback: added XFS support for matching writeback count to
    allocation group count

 fs/f2fs/node.c                   |   4 +-
 fs/f2fs/segment.h                |   2 +-
 fs/fs-writeback.c                | 148 +++++++----
 fs/fuse/file.c                   |   7 +-
 fs/gfs2/super.c                  |   2 +-
 fs/nfs/internal.h                |   2 +-
 fs/nfs/write.c                   |   4 +-
 fs/super.c                       |  23 ++
 fs/xfs/xfs_super.c               |  15 ++
 include/linux/backing-dev-defs.h |  32 ++-
 include/linux/backing-dev.h      |  79 +++++-
 include/linux/fs.h               |   3 +-
 mm/backing-dev.c                 | 412 +++++++++++++++++++++++++------
 mm/page-writeback.c              |  13 +-
 14 files changed, 581 insertions(+), 165 deletions(-)

-- 
2.25.1


