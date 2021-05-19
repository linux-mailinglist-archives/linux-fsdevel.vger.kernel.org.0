Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829BC388716
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 08:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhESGCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 02:02:36 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27036 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232157AbhESGCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 02:02:36 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGePduaDNy2aVBGflHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,311,1613404800"; 
   d="scan'208";a="108456993"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 May 2021 14:01:13 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B64B34D0BA82;
        Wed, 19 May 2021 14:01:10 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 19 May 2021 14:01:10 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 19 May 2021 14:00:47 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <viro@zeniv.linux.org.uk>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>
Subject: [PATCH v6 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
Date:   Wed, 19 May 2021 14:00:38 +0800
Message-ID: <20210519060045.1051226-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B64B34D0BA82.AF539
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is attempt to add CoW support for fsdax, and take XFS,
which has both reflink and fsdax feature, as an example.

Changes from V5:
 - Fix the lock order of xfs_inode in xfs_mmaplock_two_inodes_and_break_dax_layout()
 - move dax_remap_file_range_prep() to fs/dax.c
 - change type of length to uint64_t in dax_iomap_cow_copy()
 - fix mistake in dax_iomap_zero()

Changes from V4:
 - Fix the mistake of breaking dax layout for two inodes
 - Add CONFIG_FS_DAX judgement for fsdax code in remap_range.c
 - Fix other small problems and mistakes

One of the key mechanism need to be implemented in fsdax is CoW.  Copy
the data from srcmap before we actually write data to the destance
iomap.  And we just copy range in which data won't be changed.

Another mechanism is range comparison.  In page cache case, readpage()
is used to load data on disk to page cache in order to be able to
compare data.  In fsdax case, readpage() does not work.  So, we need
another compare data with direct access support.

With the two mechanisms implemented in fsdax, we are able to make reflink
and fsdax work together in XFS.

Some of the patches are picked up from Goldwyn's patchset.  I made some
changes to adapt to this patchset.


(Rebased on v5.13-rc2 and patchset[1])
[1]: https://lkml.org/lkml/2021/4/22/575

Shiyang Ruan (7):
  fsdax: Introduce dax_iomap_cow_copy()
  fsdax: Replace mmap entry in case of CoW
  fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
  iomap: Introduce iomap_apply2() for operations on two files
  fsdax: Dedup file range to use a compare function
  fs/xfs: Handle CoW for fsdax write() path
  fs/xfs: Add dax dedupe support

 fs/dax.c               | 216 ++++++++++++++++++++++++++++++++++++-----
 fs/iomap/apply.c       |  52 ++++++++++
 fs/iomap/buffered-io.c |   2 +-
 fs/remap_range.c       |  36 +++++--
 fs/xfs/xfs_bmap_util.c |   3 +-
 fs/xfs/xfs_file.c      |  11 +--
 fs/xfs/xfs_inode.c     |  57 +++++++++++
 fs/xfs/xfs_inode.h     |   1 +
 fs/xfs/xfs_iomap.c     |  38 +++++++-
 fs/xfs/xfs_iomap.h     |  24 +++++
 fs/xfs/xfs_iops.c      |   7 +-
 fs/xfs/xfs_reflink.c   |  15 +--
 include/linux/dax.h    |  11 ++-
 include/linux/fs.h     |  12 ++-
 include/linux/iomap.h  |   7 +-
 15 files changed, 431 insertions(+), 61 deletions(-)

-- 
2.31.1



