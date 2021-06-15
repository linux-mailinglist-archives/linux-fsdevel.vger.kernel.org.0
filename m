Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC383A7EBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 15:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhFONNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 09:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFONNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:13:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE99C061574;
        Tue, 15 Jun 2021 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=f5rKLTH/MaDrAUSw51FgcPP5sm+IRW9N0zipZ3/243o=; b=pAFqmWDVBXJS8iKAAnNYe0xc+B
        j6j4Doo14IrpP3USKBtOZY9t94N5M5y+9rIQ7wcxPMcevWn3KUc+EGiBq35zQAHiIl3GwQr0tyZ9m
        tXbu0+fvbEx7RYVekuLnY6y3X62ef8n/jOm56JVxwW1YhaxRubi442fQQR1fmVSuumrKTFCYsMAAJ
        RGwveiUv7G1ndVBVLP/++Pw+hPmqRo8go+r0C9zXWVEPOKw8TBwDNbrdQwNMOEiL4yVV/qrHABRNk
        rmX4xnd0jugZl1kWH+yT7kjduruNRgolTBi/HANLFWl5PgFC3jZ0SvrhDYe8kHF0ZfhyvW3LfWlig
        eKWjmylQ==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt8pv-006n7Y-8n; Tue, 15 Jun 2021 13:10:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: switch block layer polling to a bio based model v4
Date:   Tue, 15 Jun 2021 15:10:18 +0200
Message-Id: <20210615131034.752623-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This series clean up the block polling code a bit and changes the interface
to poll for a specific bio instead of a request_queue and cookie pair.

Polling for the bio itself leads to a few advantages:

  - the cookie construction can made entirely private in blk-mq.c
  - the caller does not need to remember the request_queue and cookie
    separately and thus sidesteps their lifetime issues
  - keeping the device and the cookie inside the bio allows to trivially
    support polling BIOs remapping by stacking drivers
  - a lot of code to propagate the cookie back up the submission path can
    removed entirely

The one major caveat is that this requires RCU freeing polled BIOs to make
sure the bio that contains the polling information is still alive when
io_uring tries to poll it through the iocb. For synchronous polling all the
callers have a bio reference anyway, so this is not an issue.

Git tree:

   git://git.infradead.org/users/hch/block.git bio-poll

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/bio-poll

Chances since v3:
 - rebased to the latests for-5.14/block tree
 - fix the refcount logic in __blkdev_direct_IO
 - split up a patch to make it easier to review
 - grab a queue reference in bio_poll
 - better document the RCU assumptions in bio_poll

Chances since v2:
 - remove support for writing to the poll attribute
 - better document the block_device life time assumptions in bio_poll
 - only set QUEUE_FLAG_POLL on nvme-multipath queues where it makes sense

Chances since v1:
 - use SLAB_TYPESAFE_BY_RCU to only free the pages backing the bio
   slabs bio RCU
 - split the spin argument to bio_poll to avoid sleeping under RCU from
   io_uring
 - add support for polling nvme multipath devices

Diffstat:
 arch/m68k/emu/nfblock.c             |    3 
 arch/xtensa/platforms/iss/simdisk.c |    3 
 block/bio.c                         |    4 
 block/blk-core.c                    |  129 ++++++++++++++++++++------
 block/blk-merge.c                   |    2 
 block/blk-mq-debugfs.c              |    2 
 block/blk-mq.c                      |  173 ++++++++++++++----------------------
 block/blk-mq.h                      |    6 -
 block/blk-sysfs.c                   |   23 ----
 drivers/block/brd.c                 |   12 +-
 drivers/block/drbd/drbd_int.h       |    2 
 drivers/block/drbd/drbd_req.c       |    3 
 drivers/block/n64cart.c             |   12 +-
 drivers/block/null_blk/main.c       |    3 
 drivers/block/pktcdvd.c             |    7 -
 drivers/block/ps3vram.c             |    6 -
 drivers/block/rsxx/dev.c            |    7 -
 drivers/block/zram/zram_drv.c       |   10 --
 drivers/lightnvm/pblk-init.c        |    6 -
 drivers/md/bcache/request.c         |   13 +-
 drivers/md/bcache/request.h         |    4 
 drivers/md/dm.c                     |   28 ++---
 drivers/md/md.c                     |   10 --
 drivers/nvdimm/blk.c                |    5 -
 drivers/nvdimm/btt.c                |    5 -
 drivers/nvdimm/pmem.c               |    3 
 drivers/nvme/host/core.c            |    4 
 drivers/nvme/host/multipath.c       |   17 ++-
 drivers/s390/block/dcssblk.c        |    7 -
 drivers/s390/block/xpram.c          |    5 -
 drivers/scsi/scsi_debug.c           |   10 +-
 fs/block_dev.c                      |   44 ++-------
 fs/btrfs/inode.c                    |    8 -
 fs/direct-io.c                      |   14 --
 fs/ext4/file.c                      |    2 
 fs/gfs2/file.c                      |    4 
 fs/io_uring.c                       |   14 +-
 fs/iomap/direct-io.c                |   56 ++++++-----
 fs/xfs/xfs_file.c                   |    2 
 fs/zonefs/super.c                   |    2 
 include/linux/bio.h                 |    4 
 include/linux/blk-mq.h              |   15 ---
 include/linux/blk_types.h           |   34 +------
 include/linux/blkdev.h              |   12 +-
 include/linux/bvec.h                |    2 
 include/linux/fs.h                  |    8 -
 include/linux/iomap.h               |    3 
 mm/page_io.c                        |   10 --
 48 files changed, 350 insertions(+), 408 deletions(-)
