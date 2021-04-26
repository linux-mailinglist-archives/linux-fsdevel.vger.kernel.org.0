Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C9D36B446
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhDZNvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDZNvY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:51:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353F5C061574;
        Mon, 26 Apr 2021 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6BQjEmz3xIT7u+aklofYoLr8R0T7nmZz9uuCT2MqVmI=; b=u29948gLvO4BaaIWFAWBN23Osn
        rqgtntih3IS05598IOpuqMT2/Bgs3ZrI4zJzG8Kxwcie9IM8DzmxGOFFEs83t1l9IHqPTTd024KsI
        qOixlsTr7IE0ErBbWO84fAwvaNf19bNiKQRsaJllK6Va1MKp2QD1xpDs4DrxcY9JyYA6HKEz9YAJx
        O2YI5f9o1CzyU3cfdoXLzoveUj7P3NXSGIuhruV71q2ADuFB1D1EFqTif9rtfb3kSwv3Ub47it/I0
        rR41mFRqV3+o2KhPcqRkKKjvcEJ4zSICXL5ZnnxGy2ZPlDbeJVSpMBTm92TmxUwbs5uA9yiB+rH9X
        XDGJ5iAQ==;
Received: from 089144202077.atnat0011.highway.a1.net ([89.144.202.77] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1dB-00Fzis-Tu; Mon, 26 Apr 2021 13:50:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: switch block layer polling to a bio based model
Date:   Mon, 26 Apr 2021 15:48:09 +0200
Message-Id: <20210426134821.2191160-1-hch@lst.de>
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

Diffstat:
 arch/m68k/emu/nfblock.c             |    3 
 arch/xtensa/platforms/iss/simdisk.c |    3 
 block/bio.c                         |   29 ++++--
 block/blk-core.c                    |  105 ++++++++++++++++-------
 block/blk-merge.c                   |    2 
 block/blk-mq-debugfs.c              |    2 
 block/blk-mq.c                      |  163 ++++++++++++++----------------------
 block/blk-mq.h                      |    6 -
 block/blk-wbt.c                     |    4 
 drivers/block/brd.c                 |   12 +-
 drivers/block/drbd/drbd_int.h       |    2 
 drivers/block/drbd/drbd_req.c       |    3 
 drivers/block/n64cart.c             |   12 +-
 drivers/block/null_blk/main.c       |    3 
 drivers/block/pktcdvd.c             |    7 -
 drivers/block/ps3vram.c             |    6 -
 drivers/block/rsxx/dev.c            |    7 -
 drivers/block/umem.c                |    4 
 drivers/block/zram/zram_drv.c       |   10 --
 drivers/lightnvm/pblk-init.c        |    6 -
 drivers/md/bcache/request.c         |   13 +-
 drivers/md/bcache/request.h         |    4 
 drivers/md/dm.c                     |   28 ++----
 drivers/md/md.c                     |   10 --
 drivers/nvdimm/blk.c                |    5 -
 drivers/nvdimm/btt.c                |    5 -
 drivers/nvdimm/pmem.c               |    3 
 drivers/nvme/host/core.c            |    4 
 drivers/nvme/host/multipath.c       |    6 -
 drivers/nvme/host/nvme.h            |    2 
 drivers/s390/block/dcssblk.c        |    7 -
 drivers/s390/block/xpram.c          |    5 -
 fs/block_dev.c                      |   54 +++--------
 fs/btrfs/inode.c                    |    8 -
 fs/direct-io.c                      |   14 ---
 fs/ext4/file.c                      |    2 
 fs/gfs2/file.c                      |    4 
 fs/iomap/direct-io.c                |   56 ++++++------
 fs/xfs/xfs_file.c                   |    2 
 fs/zonefs/super.c                   |    2 
 include/linux/bio.h                 |    4 
 include/linux/blk-mq.h              |   15 ---
 include/linux/blk_types.h           |   40 ++------
 include/linux/blkdev.h              |    8 +
 include/linux/bvec.h                |    2 
 include/linux/fs.h                  |    6 -
 include/linux/iomap.h               |    3 
 mm/page_io.c                        |   10 --
 48 files changed, 318 insertions(+), 393 deletions(-)
