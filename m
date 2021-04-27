Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AB536C93B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhD0QVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbhD0QTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:19:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482FBC061756;
        Tue, 27 Apr 2021 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=sUaMl88hnaMnobQcmCcDUIj4nQUOb9OqnC8xCsa7oqc=; b=CzRsmoLNhdCinfU7qbt92eD1yE
        NZ+/ekeudRzjFLtmRiGSZqXIkqODYJc4PdJtqdPOQkWTLyBYfgDbVJ/13AKBVACLg/Gawj5rVWvf5
        vz6AkLS25BWK/CzmBXpb+Pa/gi+70PX6gEAwc4ggIj0LmgfDnrRltIE5xuGO2DFykCPQ8rPxD2Y2D
        fdqeU1O5owEajBU3LHc9Sn50Odqq2CnKm+Bt5NTxJuR8bANihEG8X7brEU5DupV/jBGZUiu/pHMTm
        ekRMDk1tYbVahQx34rG0mz2NQdjJtlW+470B+VKC3jMFj6dXBfpKADy2nXZCdzAiAC5FdOWs/bxlW
        lrvQsDVw==;
Received: from 089144202077.atnat0011.highway.a1.net ([89.144.202.77] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbQPy-00Gr3m-4j; Tue, 27 Apr 2021 16:18:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: switch block layer polling to a bio based model v2
Date:   Tue, 27 Apr 2021 18:16:04 +0200
Message-Id: <20210427161619.1294399-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
 block/blk-core.c                    |  118 +++++++++++++++++-------
 block/blk-merge.c                   |    2 
 block/blk-mq-debugfs.c              |    2 
 block/blk-mq.c                      |  177 +++++++++++++++---------------------
 block/blk-mq.h                      |    6 -
 block/blk-sysfs.c                   |    3 
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
 drivers/nvme/host/multipath.c       |   10 +-
 drivers/s390/block/dcssblk.c        |    7 -
 drivers/s390/block/xpram.c          |    5 -
 fs/block_dev.c                      |   54 +++-------
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
 include/linux/blk_types.h           |   34 +-----
 include/linux/blkdev.h              |   13 ++
 include/linux/bvec.h                |    2 
 include/linux/fs.h                  |    8 -
 include/linux/iomap.h               |    3 
 mm/page_io.c                        |   10 --
 47 files changed, 332 insertions(+), 393 deletions(-)
