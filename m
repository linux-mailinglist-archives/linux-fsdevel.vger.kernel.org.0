Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9319B2DACD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 13:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgLOMPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 07:15:36 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22820 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726156AbgLOMPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:15:20 -0500
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="102420175"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Dec 2020 20:14:30 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 649AF4CE5CCA;
        Tue, 15 Dec 2020 20:14:29 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 15 Dec 2020 20:14:28 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 15 Dec 2020 20:14:28 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH v3 0/9] fsdax: introduce fs query to support reflink
Date:   Tue, 15 Dec 2020 20:14:05 +0800
Message-ID: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 649AF4CE5CCA.AE812
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is a try to resolve the problem of tracking shared page
for fsdax.

Change from v2:
  - Adjust the order of patches
  - Divide the infrastructure and the drivers that use it
  - Rebased to v5.10

Change from v1:
  - Introduce ->block_lost() for block device
  - Support mapped device
  - Add 'not available' warning for realtime device in XFS
  - Rebased to v5.10-rc1

This patchset moves owner tracking from dax_assocaite_entry() to pmem
device driver, by introducing an interface ->memory_failure() of struct
pagemap.  This interface is called by memory_failure() in mm, and
implemented by pmem device.  Then pmem device calls its ->corrupted_range()
to find the filesystem which the corrupted data located in, and call
filesystem handler to track files or metadata assocaited with this page.
Finally we are able to try to fix the corrupted data in filesystem and do
other necessary processing, such as killing processes who are using the
files affected.

The call trace is like this:
memory_failure()
 pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
  gendisk->fops->corrupted_range() => - pmem_corrupted_range()
                                      - md_blk_corrupted_range()
   sb->s_ops->currupted_range()    => xfs_fs_corrupted_range()
    xfs_rmap_query_range()
     xfs_currupt_helper()
      * corrupted on metadata
          try to recover data, call xfs_force_shutdown()
      * corrupted on file data 
          try to recover data, call mf_dax_mapping_kill_procs()

The fsdax & reflink support for XFS is not contained in this patchset.

(Rebased on v5.10)
--

Shiyang Ruan (9):
  pagemap: Introduce ->memory_failure()
  blk: Introduce ->corrupted_range() for block device
  fs: Introduce ->corrupted_range() for superblock
  mm, fsdax: Refactor memory-failure handler for dax mapping
  mm, pmem: Implement ->memory_failure() in pmem driver
  pmem: Implement ->corrupted_range() for pmem driver
  dm: Introduce ->rmap() to find bdev offset
  md: Implement ->corrupted_range()
  xfs: Implement ->corrupted_range() for XFS

 block/genhd.c                 |  12 +++
 drivers/md/dm-linear.c        |   8 ++
 drivers/md/dm.c               |  66 +++++++++++++++
 drivers/nvdimm/pmem.c         |  51 ++++++++++++
 fs/block_dev.c                |  21 +++++
 fs/dax.c                      |  24 +++---
 fs/xfs/xfs_fsops.c            |  10 +++
 fs/xfs/xfs_mount.h            |   2 +
 fs/xfs/xfs_super.c            |  93 +++++++++++++++++++++
 include/linux/blkdev.h        |   2 +
 include/linux/dax.h           |   5 +-
 include/linux/device-mapper.h |   2 +
 include/linux/fs.h            |   2 +
 include/linux/genhd.h         |   8 ++
 include/linux/memremap.h      |   8 ++
 include/linux/mm.h            |   9 ++
 mm/memory-failure.c           | 150 +++++++++++++++++++---------------
 17 files changed, 391 insertions(+), 82 deletions(-)

-- 
2.29.2



