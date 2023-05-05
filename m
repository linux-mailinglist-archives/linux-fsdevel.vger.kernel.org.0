Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAEF6F880E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 19:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjEERwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 13:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjEERwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 13:52:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B397F1F4BF;
        Fri,  5 May 2023 10:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ifMkRij8nI82A7W3OrolnA1MZaZFLCyCuCFDtjFdqjg=; b=MHYRypZnxHGI6bvB89Ag3pPZ8M
        yHXC3IpteaKJGX/ZHiNjV698TU13wfd4xYcTnl7o4i55gGyms5+VTsaXdWGoCthKvx0DMFNjkyDuO
        h8w3+IaDhgXuqI8CLHkt8MQoc+BkSYhHp9eNQbHdfjhVyNEs3tVaS3v9XqR1fYoEAZrgeym6DiGX4
        4xu5ffXD+GhRcTs5mG1jfCRI0F/qO4Te6GAD3kXwXjk5haXFyQv189iDmOJKqRlJcdwW/dW/NqVlv
        +sGjWUa5Ez3B1/lKvxyTZJaA6QYiQEwPsMb3IR/wF9jskxppePnf/YiAFV7NRQXEF3zjxJhEE8Y9H
        zPm9Ev5A==;
Received: from 66-46-223-221.dedicated.allstream.net ([66.46.223.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puzao-00BSwG-0H;
        Fri, 05 May 2023 17:51:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: introduce bdev holder ops and a file system shutdown method
Date:   Fri,  5 May 2023 13:51:23 -0400
Message-Id: <20230505175132.2236632-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series fixes the long standing problem that we never had a good way
to communicate block device events to the user of the block device.

It fixes this by introducing a new set of holder ops registered at
blkdev_get_by_* time for the exclusive holder, and then wire that up
to a shutdown super operation to report the block device remove to the
file systems.

Diffstat:
 block/bdev.c                        |  106 ++++++++++++++++++++----------------
 block/fops.c                        |    2 
 block/genhd.c                       |   57 +++++++++++++------
 block/ioctl.c                       |    3 -
 drivers/block/drbd/drbd_nl.c        |    3 -
 drivers/block/pktcdvd.c             |    5 +
 drivers/block/rnbd/rnbd-srv.c       |    2 
 drivers/block/xen-blkback/xenbus.c  |    2 
 drivers/block/zram/zram_drv.c       |    2 
 drivers/md/bcache/super.c           |    2 
 drivers/md/dm.c                     |    2 
 drivers/md/md.c                     |    2 
 drivers/mtd/devices/block2mtd.c     |    4 -
 drivers/nvme/target/io-cmd-bdev.c   |    2 
 drivers/s390/block/dasd_genhd.c     |    2 
 drivers/target/target_core_iblock.c |    2 
 drivers/target/target_core_pscsi.c  |    3 -
 fs/btrfs/dev-replace.c              |    2 
 fs/btrfs/volumes.c                  |    6 +-
 fs/erofs/super.c                    |    2 
 fs/ext4/super.c                     |    3 -
 fs/f2fs/super.c                     |    4 -
 fs/jfs/jfs_logmgr.c                 |    2 
 fs/nfs/blocklayout/dev.c            |    5 +
 fs/nilfs2/super.c                   |    2 
 fs/ocfs2/cluster/heartbeat.c        |    2 
 fs/reiserfs/journal.c               |    5 +
 fs/super.c                          |   21 ++++++-
 fs/xfs/xfs_fsops.c                  |    3 +
 fs/xfs/xfs_mount.h                  |    1 
 fs/xfs/xfs_super.c                  |   21 ++++++-
 include/linux/blk_types.h           |    2 
 include/linux/blkdev.h              |    9 ++-
 include/linux/fs.h                  |    1 
 kernel/power/swap.c                 |    4 -
 mm/swapfile.c                       |    3 -
 36 files changed, 196 insertions(+), 103 deletions(-)
