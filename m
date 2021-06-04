Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AAE39AF7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 03:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFDBUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 21:20:47 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12799 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229973AbhFDBUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:20:43 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AA3bLW6jvnopU4Bnx6L9YoZtz3nBQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.83,246,1616428800"; 
   d="scan'208";a="109209787"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Jun 2021 09:18:54 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 31BEC4C369FE;
        Fri,  4 Jun 2021 09:18:49 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 4 Jun 2021 09:18:49 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 4 Jun 2021 09:18:48 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>
Subject: [PATCH v4 00/10] fsdax: introduce fs query to support reflink
Date:   Fri, 4 Jun 2021 09:18:34 +0800
Message-ID: <20210604011844.1756145-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 31BEC4C369FE.A3141
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is aimed to support shared pages tracking for fsdax.

Change from V3:
  - Introduce dax_device->holder to split dax specific issues from
    block device, instead of the ->corrupted_range() in
    block_device_operations
  - Other mistakes and problems fix
  - Rebased to v5.13-rc4

This patchset moves owner tracking from dax_assocaite_entry() to pmem
device driver, by introducing an interface ->memory_failure() of struct
pagemap.  This interface is called by memory_failure() in mm, and
implemented by pmem device.

Then call holder operations to find the filesystem which the corrupted
data located in, and call filesystem handler to track files or metadata
associated with this page.

Finally we are able to try to fix the corrupted data in filesystem and
do other necessary processing, such as killing processes who are using
the files affected.

The call trace is like this:
memory_failure()
 pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
  dax_device->holder_ops->corrupted_range() =>
                                      - fs_dax_corrupted_range()
                                      - md_dax_corrupted_range()
   sb->s_ops->currupted_range()    => xfs_fs_corrupted_range()
    xfs_rmap_query_range()
     xfs_currupt_helper()
      * corrupted on metadata
          try to recover data, call xfs_force_shutdown()
      * corrupted on file data
          try to recover data, call mf_dax_kill_procs()

The fsdax & reflink support for XFS is not contained in this patchset.

(Rebased on v5.13-rc4)
==


Shiyang Ruan (10):
  pagemap: Introduce ->memory_failure()
  dax: Introduce holder for dax_device
  fs: Introduce ->corrupted_range() for superblock
  mm, fsdax: Refactor memory-failure handler for dax mapping
  mm, pmem: Implement ->memory_failure() in pmem driver
  fs/dax: Implement dax_holder_operations
  dm: Introduce ->rmap() to find bdev offset
  md: Implement dax_holder_operations
  xfs: Implement ->corrupted_range() for XFS
  fs/dax: Remove useless functions

 block/genhd.c                 |  30 ++++++
 drivers/dax/super.c           |  38 ++++++++
 drivers/md/dm-linear.c        |  20 ++++
 drivers/md/dm.c               | 119 ++++++++++++++++++++++-
 drivers/nvdimm/pmem.c         |  14 +++
 fs/dax.c                      |  79 +++++++---------
 fs/xfs/xfs_fsops.c            |   5 +
 fs/xfs/xfs_mount.h            |   1 +
 fs/xfs/xfs_super.c            | 108 +++++++++++++++++++++
 include/linux/dax.h           |  13 +++
 include/linux/device-mapper.h |   5 +
 include/linux/fs.h            |   2 +
 include/linux/genhd.h         |   1 +
 include/linux/memremap.h      |   8 ++
 include/linux/mm.h            |   9 ++
 mm/memory-failure.c           | 173 ++++++++++++++++++++++------------
 16 files changed, 520 insertions(+), 105 deletions(-)

-- 
2.31.1



