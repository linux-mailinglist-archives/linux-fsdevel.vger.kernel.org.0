Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B212294A3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 11:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437412AbgJUJNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 05:13:22 -0400
Received: from mx4.veeam.com ([104.41.138.86]:56796 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437398AbgJUJNV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:13:21 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2020 05:13:21 EDT
Received: from mail.veeam.com (spbmbx01.amust.local [172.17.17.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 8A0905C60C;
        Wed, 21 Oct 2020 12:04:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1603271066; bh=7pCinxh9CDdZ18baGj9Agc/InVPsneMyQj+wVyVjQ3I=;
        h=From:To:Subject:Date:From;
        b=D1RQaq6u5Gf6SP2mNiIVrCRlPSmaF6XvLmflwyZ7o4C8ia3u2i76fRSrT4beQCO05
         yBr95+z13pJlPECDmYUR+W1eG8IdFt5fuPpnyP0aknKPqEapJX7GFwzvbP1K4dY+5J
         IGFPiinN/RxRhRuxEA2BpzaqYdBybPJt1hCyn/4M=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 spbmbx01.amust.local (172.17.17.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.595.3;
 Wed, 21 Oct 2020 12:04:24 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <hch@infradead.org>,
        <darrick.wong@oracle.com>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <len.brown@intel.com>, <pavel@ucw.cz>, <akpm@linux-foundation.org>,
        <johannes.thumshirn@wdc.com>, <ming.lei@redhat.com>,
        <jack@suse.cz>, <tj@kernel.org>, <gustavo@embeddedor.com>,
        <bvanassche@acm.org>, <osandov@fb.com>, <koct9i@gmail.com>,
        <damien.lemoal@wdc.com>, <steve@sk2.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mm@kvack.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH 0/2] block layer filter and block device snapshot module
Date:   Wed, 21 Oct 2020 12:04:07 +0300
Message-ID: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: spbmbx01.amust.local (172.17.17.171) To
 spbmbx01.amust.local (172.17.17.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A295605D26A677562
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello everyone! Requesting for your comments and suggestions.

# blk-filter

Block layer filter allows to intercept BIO requests to a block device.

Interception is performed at the very beginning of the BIO request
processing, and therefore does not affect the operation of the request
processing queue. This also makes it possible to intercept requests from
a specific block device, rather than from the entire disk.

The logic of the submit_bio function has been changed - since the
function execution results are not processed anywhere (except for swap
and direct-io) the function won't return a value anymore.

Now the submit_bio_direct() function is called whenever the result of
the blk_qc_t function is required. submit_bio_direct() is not
intercepted by the block layer filter. This is logical for swap and
direct-io.

Block layer filter allows you to enable and disable the filter driver on
the fly. When a new block device is added, the filter driver can start
filtering this device. When you delete a device, the filter can remove
its own filter.

The idea of multiple altitudes had to be abandoned in order to simplify
implementation and make it more reliable. Different filter drivers can
work simultaneously, but each on its own block device.

# blk-snap

We propose a new kernel module - blk-snap. This module implements
snapshot and changed block tracking functionality. It is intended to
create backup copies of any block devices without usage of device mapper.
Snapshots are temporary and are destroyed after the backup process has
finished. Changed block tracking allows for incremental and differential
backup copies.

blk-snap uses block layer filter. Block layer filter provides a callback
to intercept bio-requests. If a block device disappears for whatever
reason, send a synchronous request to remove the device from filtering.

blk-snap kernel module is a product of a deep refactoring of the
out-of-tree kernel veeamsnap kernel module
(https://github.com/veeam/veeamsnap/):
* all conditional compilation branches that served for the purpose of
  compatibility with older kernels have been removed;
* linux kernel code style has been applied;
* blk-snap mostly takes advantage of the existing kernel code instead of
  reinventing the wheel;
* all redundant code (such as persistent cbt and snapstore collector)
  has been removed.

Several important things are still have to be done:
* refactor the module interface for interaction with a user-space code -
  it is already clear that the implementation of some calls can be
  improved.

Your feedback would be greatly appreciated!

Sergei Shtepa (2):
  Block layer filter - second version
  blk-snap - snapshots and change-tracking for block devices

 block/Kconfig                               |  11 +
 block/Makefile                              |   1 +
 block/blk-core.c                            |  52 +-
 block/blk-filter-internal.h                 |  29 +
 block/blk-filter.c                          | 286 ++++++
 block/partitions/core.c                     |  14 +-
 drivers/block/Kconfig                       |   2 +
 drivers/block/Makefile                      |   1 +
 drivers/block/blk-snap/Kconfig              |  24 +
 drivers/block/blk-snap/Makefile             |  28 +
 drivers/block/blk-snap/big_buffer.c         | 193 ++++
 drivers/block/blk-snap/big_buffer.h         |  24 +
 drivers/block/blk-snap/blk-snap-ctl.h       | 190 ++++
 drivers/block/blk-snap/blk_deferred.c       | 566 +++++++++++
 drivers/block/blk-snap/blk_deferred.h       |  67 ++
 drivers/block/blk-snap/blk_descr_file.c     |  82 ++
 drivers/block/blk-snap/blk_descr_file.h     |  26 +
 drivers/block/blk-snap/blk_descr_mem.c      |  66 ++
 drivers/block/blk-snap/blk_descr_mem.h      |  14 +
 drivers/block/blk-snap/blk_descr_multidev.c |  86 ++
 drivers/block/blk-snap/blk_descr_multidev.h |  25 +
 drivers/block/blk-snap/blk_descr_pool.c     | 190 ++++
 drivers/block/blk-snap/blk_descr_pool.h     |  38 +
 drivers/block/blk-snap/blk_redirect.c       | 507 ++++++++++
 drivers/block/blk-snap/blk_redirect.h       |  73 ++
 drivers/block/blk-snap/blk_util.c           |  33 +
 drivers/block/blk-snap/blk_util.h           |  33 +
 drivers/block/blk-snap/cbt_map.c            | 210 +++++
 drivers/block/blk-snap/cbt_map.h            |  62 ++
 drivers/block/blk-snap/common.h             |  31 +
 drivers/block/blk-snap/ctrl_fops.c          | 691 ++++++++++++++
 drivers/block/blk-snap/ctrl_fops.h          |  19 +
 drivers/block/blk-snap/ctrl_pipe.c          | 562 +++++++++++
 drivers/block/blk-snap/ctrl_pipe.h          |  34 +
 drivers/block/blk-snap/ctrl_sysfs.c         |  73 ++
 drivers/block/blk-snap/ctrl_sysfs.h         |   5 +
 drivers/block/blk-snap/defer_io.c           | 397 ++++++++
 drivers/block/blk-snap/defer_io.h           |  39 +
 drivers/block/blk-snap/main.c               |  82 ++
 drivers/block/blk-snap/params.c             |  58 ++
 drivers/block/blk-snap/params.h             |  29 +
 drivers/block/blk-snap/rangevector.c        |  85 ++
 drivers/block/blk-snap/rangevector.h        |  31 +
 drivers/block/blk-snap/snapimage.c          | 982 ++++++++++++++++++++
 drivers/block/blk-snap/snapimage.h          |  16 +
 drivers/block/blk-snap/snapshot.c           | 225 +++++
 drivers/block/blk-snap/snapshot.h           |  17 +
 drivers/block/blk-snap/snapstore.c          | 929 ++++++++++++++++++
 drivers/block/blk-snap/snapstore.h          |  68 ++
 drivers/block/blk-snap/snapstore_device.c   | 532 +++++++++++
 drivers/block/blk-snap/snapstore_device.h   |  63 ++
 drivers/block/blk-snap/snapstore_file.c     |  52 ++
 drivers/block/blk-snap/snapstore_file.h     |  15 +
 drivers/block/blk-snap/snapstore_mem.c      |  91 ++
 drivers/block/blk-snap/snapstore_mem.h      |  20 +
 drivers/block/blk-snap/snapstore_multidev.c | 118 +++
 drivers/block/blk-snap/snapstore_multidev.h |  22 +
 drivers/block/blk-snap/tracker.c            | 449 +++++++++
 drivers/block/blk-snap/tracker.h            |  38 +
 drivers/block/blk-snap/tracking.c           | 270 ++++++
 drivers/block/blk-snap/tracking.h           |  13 +
 drivers/block/blk-snap/version.h            |   7 +
 fs/block_dev.c                              |   6 +-
 fs/direct-io.c                              |   2 +-
 fs/iomap/direct-io.c                        |   2 +-
 include/linux/bio.h                         |   4 +-
 include/linux/blk-filter.h                  |  76 ++
 include/linux/genhd.h                       |   8 +-
 kernel/power/swap.c                         |   2 +-
 mm/page_io.c                                |   4 +-
 70 files changed, 9074 insertions(+), 26 deletions(-)
 create mode 100644 block/blk-filter-internal.h
 create mode 100644 block/blk-filter.c
 create mode 100644 drivers/block/blk-snap/Kconfig
 create mode 100644 drivers/block/blk-snap/Makefile
 create mode 100644 drivers/block/blk-snap/big_buffer.c
 create mode 100644 drivers/block/blk-snap/big_buffer.h
 create mode 100644 drivers/block/blk-snap/blk-snap-ctl.h
 create mode 100644 drivers/block/blk-snap/blk_deferred.c
 create mode 100644 drivers/block/blk-snap/blk_deferred.h
 create mode 100644 drivers/block/blk-snap/blk_descr_file.c
 create mode 100644 drivers/block/blk-snap/blk_descr_file.h
 create mode 100644 drivers/block/blk-snap/blk_descr_mem.c
 create mode 100644 drivers/block/blk-snap/blk_descr_mem.h
 create mode 100644 drivers/block/blk-snap/blk_descr_multidev.c
 create mode 100644 drivers/block/blk-snap/blk_descr_multidev.h
 create mode 100644 drivers/block/blk-snap/blk_descr_pool.c
 create mode 100644 drivers/block/blk-snap/blk_descr_pool.h
 create mode 100644 drivers/block/blk-snap/blk_redirect.c
 create mode 100644 drivers/block/blk-snap/blk_redirect.h
 create mode 100644 drivers/block/blk-snap/blk_util.c
 create mode 100644 drivers/block/blk-snap/blk_util.h
 create mode 100644 drivers/block/blk-snap/cbt_map.c
 create mode 100644 drivers/block/blk-snap/cbt_map.h
 create mode 100644 drivers/block/blk-snap/common.h
 create mode 100644 drivers/block/blk-snap/ctrl_fops.c
 create mode 100644 drivers/block/blk-snap/ctrl_fops.h
 create mode 100644 drivers/block/blk-snap/ctrl_pipe.c
 create mode 100644 drivers/block/blk-snap/ctrl_pipe.h
 create mode 100644 drivers/block/blk-snap/ctrl_sysfs.c
 create mode 100644 drivers/block/blk-snap/ctrl_sysfs.h
 create mode 100644 drivers/block/blk-snap/defer_io.c
 create mode 100644 drivers/block/blk-snap/defer_io.h
 create mode 100644 drivers/block/blk-snap/main.c
 create mode 100644 drivers/block/blk-snap/params.c
 create mode 100644 drivers/block/blk-snap/params.h
 create mode 100644 drivers/block/blk-snap/rangevector.c
 create mode 100644 drivers/block/blk-snap/rangevector.h
 create mode 100644 drivers/block/blk-snap/snapimage.c
 create mode 100644 drivers/block/blk-snap/snapimage.h
 create mode 100644 drivers/block/blk-snap/snapshot.c
 create mode 100644 drivers/block/blk-snap/snapshot.h
 create mode 100644 drivers/block/blk-snap/snapstore.c
 create mode 100644 drivers/block/blk-snap/snapstore.h
 create mode 100644 drivers/block/blk-snap/snapstore_device.c
 create mode 100644 drivers/block/blk-snap/snapstore_device.h
 create mode 100644 drivers/block/blk-snap/snapstore_file.c
 create mode 100644 drivers/block/blk-snap/snapstore_file.h
 create mode 100644 drivers/block/blk-snap/snapstore_mem.c
 create mode 100644 drivers/block/blk-snap/snapstore_mem.h
 create mode 100644 drivers/block/blk-snap/snapstore_multidev.c
 create mode 100644 drivers/block/blk-snap/snapstore_multidev.h
 create mode 100644 drivers/block/blk-snap/tracker.c
 create mode 100644 drivers/block/blk-snap/tracker.h
 create mode 100644 drivers/block/blk-snap/tracking.c
 create mode 100644 drivers/block/blk-snap/tracking.h
 create mode 100644 drivers/block/blk-snap/version.h
 create mode 100644 include/linux/blk-filter.h

--
2.20.1

