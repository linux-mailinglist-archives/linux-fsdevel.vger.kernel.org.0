Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8E63B560A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 02:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhF1AFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Jun 2021 20:05:25 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54538 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231748AbhF1AFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Jun 2021 20:05:24 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AV8gBeKG6lsoZXInUpLqEAMeALOsnbusQ8zAX?=
 =?us-ascii?q?P0AYc3Jom6uj5qSTdZUgpHjJYVkqOE3I9ertBEDiewK4yXcW2/hzAV7KZmCP0w?=
 =?us-ascii?q?HEEGgI1+rfKlPbdBEWjtQtt5uIbZIOc+HYPBxri9rg+gmkH5IFyNmDyqqhguDT?=
 =?us-ascii?q?1B5WPHhXQpAl/wFkERyaD0EzYAFHAKAyHJ2a6tECiCGnfR0sH7yGL0hAT+7evM?=
 =?us-ascii?q?fKiZ6jRRYHAiQs4A6IgSjtyJOSKWn/4isj?=
X-IronPort-AV: E=Sophos;i="5.83,304,1616428800"; 
   d="scan'208";a="110256323"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Jun 2021 08:02:57 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 28CF14D0BA69;
        Mon, 28 Jun 2021 08:02:53 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 28 Jun 2021 08:02:44 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 28 Jun 2021 08:02:22 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>
Subject: [PATCH v5 0/9] fsdax: introduce fs query to support reflink
Date:   Mon, 28 Jun 2021 08:02:09 +0800
Message-ID: <20210628000218.387833-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 28CF14D0BA69.A2AEF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is aimed to support shared pages tracking for fsdax.

Change from V4:
  - Add nr_pfns for ->memory_failure() to support range based notification
  - Remove struct bdev in dax_holder_notify_failure()
  - Add rwsem for dax_holder
  - Rename functions to (*_)notify_failure()
  - Remove sb->corrupted_range(), implement holder_ops in filesystem and
      MD driver instead
  - Reorganize the patchset, make it easy to review
  - Rebased to v5.13-rc7

This patchset moves owner tracking from dax_assocaite_entry() to pmem
device driver, by introducing an interface ->memory_failure() for struct
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
|* fsdax case
|------------
|pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
| dax_holder_notify_failure()      =>
|  dax_device->holder_ops->notify_failure() =>
|                                     - xfs_dax_notify_failure()
|                                     - md_dax_notify_failure()
|  |* xfs_dax_notify_failure()
|  |--------------------------
|  |   xfs_rmap_query_range()
|  |    xfs_currupt_helper()
|  |    * corrupted on metadata
|  |       try to recover data, call xfs_force_shutdown()
|  |    * corrupted on file data
|  |       try to recover data, call mf_dax_kill_procs()
|  |* md_dax_notify_failure()
|  |-------------------------
|      md_targets->iterate_devices()
|      md_targets->rmap()          => linear_rmap()
|       dax_holder_notify_failure()
|* normal case
|-------------
 mf_generic_kill_procs()

The fsdax & reflink support for XFS is not contained in this patchset.

(Rebased on v5.13-rc7)
==

Shiyang Ruan (9):
  pagemap: Introduce ->memory_failure()
  dax: Introduce holder for dax_device
  mm: factor helpers for memory_failure_dev_pagemap
  pmem,mm: Implement ->memory_failure in pmem driver
  mm: Introduce mf_dax_kill_procs() for fsdax case
  xfs: Implement ->corrupted_range() for XFS
  dm: Introduce ->rmap() to find bdev offset
  md: Implement dax_holder_operations
  fs/dax: Remove useless functions

 block/genhd.c                 |  30 +++++++
 drivers/dax/super.c           |  49 ++++++++++
 drivers/md/dm-linear.c        |  20 +++++
 drivers/md/dm.c               | 126 +++++++++++++++++++++++++-
 drivers/nvdimm/pmem.c         |  13 +++
 fs/dax.c                      |  73 ++++-----------
 fs/xfs/xfs_fsops.c            |   5 ++
 fs/xfs/xfs_mount.h            |   1 +
 fs/xfs/xfs_super.c            | 140 +++++++++++++++++++++++++++++
 include/linux/dax.h           |  27 ++++++
 include/linux/device-mapper.h |   5 ++
 include/linux/genhd.h         |   1 +
 include/linux/memremap.h      |   9 ++
 include/linux/mm.h            |  10 +++
 mm/memory-failure.c           | 165 ++++++++++++++++++++++------------
 15 files changed, 564 insertions(+), 110 deletions(-)

--
2.32.0



