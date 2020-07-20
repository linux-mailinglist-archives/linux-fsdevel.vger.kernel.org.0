Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E182225953
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 09:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgGTHwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 03:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgGTHwB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:52:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54168C061794;
        Mon, 20 Jul 2020 00:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vvvfRy6KN2hjgDllD22K5RJhB99DHH+ZsJ+5mTbpBY0=; b=TBKmeTnDSCN2OLHgbkThxI71xC
        ceTXoyJZCq7Q7aqPvWXUlj9Oq7JgV1rVX3vOyKNtTVYLf1EpjbcvVdpOMGtHVvLn1DMS+cwH0tIUo
        z6c66YDSF+q0DGm5nZdMKDqko7sC+5MpUqYbnf1ufShxAdQI+ha0ezYgFM1+WG6AQWw35yuEKtDYP
        yLMEnIkrKmSFTQU57ecl+NSYiTi8odUUDykirEEMsC9O3kQmtehR2Rf0yx9+BgKPlK29w8HhOUZya
        mvn5fyfmWBnt3lUQBAXujLRyU7en2SDqXxw2Xurqa2QtH/Q4LLHjuwyziXIpJx5hhIyHsWKwcUame
        ZTANoRcQ==;
Received: from [2001:4bb8:105:4a81:5185:88fc:94bb:f8bf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxQaT-0003zB-8L; Mon, 20 Jul 2020 07:51:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: bdi cleanups
Date:   Mon, 20 Jul 2020 09:51:34 +0200
Message-Id: <20200720075148.172156-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
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

Note that this is based on top of the
"a fix and two cleanups around blk_stack_limits" series sent earlier.

Diffstat:
 block/blk-core.c              |    2 
 block/blk-integrity.c         |    4 
 block/blk-mq-debugfs.c        |    1 
 block/blk-settings.c          |    5 
 block/blk-sysfs.c             |  270 ++++++++++--------------------------------
 block/genhd.c                 |   13 +-
 drivers/block/aoe/aoeblk.c    |    2 
 drivers/block/brd.c           |    1 
 drivers/block/drbd/drbd_nl.c  |   18 --
 drivers/block/drbd/drbd_req.c |    4 
 drivers/block/rbd.c           |    2 
 drivers/block/zram/zram_drv.c |   17 --
 drivers/md/bcache/super.c     |    4 
 drivers/md/dm-table.c         |    9 -
 drivers/md/raid0.c            |   16 --
 drivers/md/raid10.c           |   46 ++-----
 drivers/md/raid5.c            |   31 ++--
 drivers/mmc/core/queue.c      |    3 
 drivers/nvdimm/btt.c          |    2 
 drivers/nvdimm/pmem.c         |    1 
 drivers/nvme/host/core.c      |    3 
 drivers/nvme/host/multipath.c |    9 -
 drivers/scsi/iscsi_tcp.c      |    4 
 fs/9p/vfs_file.c              |    2 
 fs/9p/vfs_super.c             |    4 
 fs/afs/super.c                |    1 
 fs/btrfs/disk-io.c            |    2 
 fs/fs-writeback.c             |    7 -
 fs/fuse/inode.c               |    4 
 fs/namei.c                    |    4 
 fs/nfs/super.c                |    9 -
 fs/super.c                    |    2 
 include/linux/backing-dev.h   |   76 +----------
 include/linux/blkdev.h        |    3 
 include/linux/drbd.h          |    1 
 include/linux/fs.h            |    2 
 mm/backing-dev.c              |   13 --
 mm/filemap.c                  |    4 
 mm/memcontrol.c               |    2 
 mm/memory-failure.c           |    2 
 mm/migrate.c                  |    2 
 mm/mmap.c                     |    2 
 mm/page-writeback.c           |   18 +-
 mm/page_io.c                  |    7 -
 mm/swapfile.c                 |    4 
 45 files changed, 180 insertions(+), 458 deletions(-)
