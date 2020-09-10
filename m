Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29402651B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 23:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgIJU7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 16:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbgIJOsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:48:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5F6C06179A;
        Thu, 10 Sep 2020 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=G/ynTjiiaQImGikICL0Gi3SQqZvoYMtx3vuRG4L2Av0=; b=qOtT7aIVEPRamwsXqaXgrJlja8
        q2wS41r86uBmexZ/oqJQzqwyKpAFJXnGBEmvOQk5iJqrYtbDECr3uG2rXmaqm0KlEWHXxZo2RHcQy
        0ryEeRmnT6dbxMtwimADAon7dOEyWt5hJQSsPWE6p/JAwPBc8YUj6xx4fCFPJeHAAdBN+sM5S9MTg
        FowMF/Yyd3yg13KFYySdeZtHRrjTC7AE6aXk69XxPAfc8CnAwaBcAaGX3hEcgxs0NxH9mubGzqUma
        0rP4/e+qVoXjVmX1AxpSX++MdR/eFn4iF7Y/DBtWhBj3C+HnendB6PWzU0TdPvPX5Jy2Fu7b2tnFc
        EAdhi49A==;
Received: from [2001:4bb8:184:af1:3ecc:ac5b:136f:434a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGNsH-0006vT-Ul; Thu, 10 Sep 2020 14:48:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: bdi cleanups v4
Date:   Thu, 10 Sep 2020 16:48:20 +0200
Message-Id: <20200910144833.742260-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

this series contains a bunch of different BDI cleanups.  The biggest item
is to isolate block drivers from the BDI in preparation of changing the
lifetime of the block device BDI in a follow up series.


Changes since v3:
 - rebased on the lasted block tree, which has some of the prep
   changes merged
 - extend the ->ra_pages changes to ->io_pages
 - move initializing ->ra_pages and ->io_pages for block devices to
   blk_register_queue

Changes since v2:
 - fix a rw_page return value check
 - fix up various changelogs

Changes since v1:
 - rebased to the for-5.9/block-merge branch
 - explicitly set the readahead to 0 for ubifs, vboxsf and mtd
 - split the zram block_device operations
 - let rw_page users fall back to bios in swap_readpage


Diffstat:
 block/blk-core.c              |    3 -
 block/blk-integrity.c         |    4 +-
 block/blk-mq-debugfs.c        |    1 
 block/blk-settings.c          |    5 +-
 block/blk-sysfs.c             |    4 +-
 block/genhd.c                 |   13 +++++--
 drivers/block/aoe/aoeblk.c    |    2 -
 drivers/block/brd.c           |    1 
 drivers/block/drbd/drbd_nl.c  |   18 ---------
 drivers/block/drbd/drbd_req.c |    4 --
 drivers/block/rbd.c           |    2 -
 drivers/block/zram/zram_drv.c |   19 +++++++---
 drivers/md/bcache/super.c     |    4 --
 drivers/md/dm-table.c         |    9 +---
 drivers/md/raid0.c            |   16 --------
 drivers/md/raid10.c           |   46 ++++++++----------------
 drivers/md/raid5.c            |   31 +++++++---------
 drivers/mmc/core/queue.c      |    3 -
 drivers/mtd/mtdcore.c         |    2 +
 drivers/nvdimm/btt.c          |    2 -
 drivers/nvdimm/pmem.c         |    1 
 drivers/nvme/host/core.c      |    3 -
 drivers/nvme/host/multipath.c |   10 +----
 drivers/scsi/iscsi_tcp.c      |    4 +-
 fs/9p/vfs_file.c              |    2 -
 fs/9p/vfs_super.c             |    6 ++-
 fs/afs/super.c                |    1 
 fs/btrfs/disk-io.c            |    2 -
 fs/fs-writeback.c             |    7 ++-
 fs/fuse/inode.c               |    4 +-
 fs/namei.c                    |    4 +-
 fs/nfs/super.c                |    9 ----
 fs/super.c                    |    2 +
 fs/ubifs/super.c              |    2 +
 fs/vboxsf/super.c             |    2 +
 include/linux/backing-dev.h   |   78 +++++++-----------------------------------
 include/linux/blkdev.h        |    3 +
 include/linux/drbd.h          |    1 
 include/linux/fs.h            |    2 -
 mm/backing-dev.c              |   13 +++----
 mm/filemap.c                  |    4 +-
 mm/memcontrol.c               |    2 -
 mm/memory-failure.c           |    2 -
 mm/migrate.c                  |    2 -
 mm/mmap.c                     |    2 -
 mm/page-writeback.c           |   18 ++++-----
 mm/page_io.c                  |   18 +++++----
 mm/swapfile.c                 |    4 +-
 48 files changed, 144 insertions(+), 253 deletions(-)
