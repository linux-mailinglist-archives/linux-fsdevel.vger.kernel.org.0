Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE9719764
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjFAJp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjFAJpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:45:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF71DD7;
        Thu,  1 Jun 2023 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RgPQEJTrg1rM26x8tIHPsFz0jTbDPDxkcQcrRlHgraU=; b=vmPOM6LBHPBRi89knPe58DFAAX
        iNj7FQ0pznpRJtvZofXWhwXaSR5tgoxRW+KE2g6uRwONMst9+PX0sto3iuwFgXVVu8Osez/UIk6ic
        fNXZLubHe5yLauPrYvvZCIm/3rdTX9tkvodnaDJRueci0SXMFUeIiWAj8evLkd4OMnE5TJmBZnCF+
        kGuY7dhhl0em8nfGMKMaytkd8EvLKOI/1E/As8cMuDlaW9qpwClzMQtl0AdGF0NHMpCz6/NefGubW
        1sQG/OP8mkWmqoCtyvhUD8UBMFe2di/cHhy/iO4rpcxsJA4lQ5cwdoA8QFpFlRkqHG9HebW6sTfas
        CGzrzDiQ==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4ere-002lwh-1r;
        Thu, 01 Jun 2023 09:45:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: introduce bdev holder ops and a file system shutdown method v3
Date:   Thu,  1 Jun 2023 11:44:43 +0200
Message-Id: <20230601094459.1350643-1-hch@lst.de>
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

Changes since v2:
 - rename a method in xfs
 - add ext4 support

Changes since v1:
 - add a patch to refactor bd_may_claim
 - add a sanity check for mismatching holder ops in bd_may_claim
 - move partition removal later in del_gendisk so that partitions
   are still around for the shutdown notification
 - add SHUTDOWN_DEVICE_REMOVED to XFS_SHUTDOWN_STRINGS

Diffstat:
 block/bdev.c                        |  159 ++++++++++++++++++++----------------
 block/blk.h                         |    2 
 block/fops.c                        |    2 
 block/genhd.c                       |   78 +++++++++++++----
 block/ioctl.c                       |    3 
 block/partitions/core.c             |   31 +++----
 drivers/block/drbd/drbd_nl.c        |    3 
 drivers/block/loop.c                |    2 
 drivers/block/pktcdvd.c             |    5 -
 drivers/block/rnbd/rnbd-srv.c       |    2 
 drivers/block/xen-blkback/xenbus.c  |    2 
 drivers/block/zram/zram_drv.c       |    2 
 drivers/md/bcache/super.c           |    2 
 drivers/md/dm.c                     |    2 
 drivers/md/md.c                     |    2 
 drivers/mtd/devices/block2mtd.c     |    4 
 drivers/nvme/target/io-cmd-bdev.c   |    2 
 drivers/s390/block/dasd_genhd.c     |    2 
 drivers/target/target_core_iblock.c |    2 
 drivers/target/target_core_pscsi.c  |    3 
 fs/btrfs/dev-replace.c              |    2 
 fs/btrfs/volumes.c                  |    6 -
 fs/erofs/super.c                    |    2 
 fs/ext4/ext4.h                      |    1 
 fs/ext4/ioctl.c                     |   24 +++--
 fs/ext4/super.c                     |   18 +++-
 fs/f2fs/super.c                     |    4 
 fs/jfs/jfs_logmgr.c                 |    2 
 fs/nfs/blocklayout/dev.c            |    5 -
 fs/nilfs2/super.c                   |    2 
 fs/ocfs2/cluster/heartbeat.c        |    2 
 fs/reiserfs/journal.c               |    5 -
 fs/super.c                          |   21 ++++
 fs/xfs/xfs_fsops.c                  |    3 
 fs/xfs/xfs_mount.h                  |    4 
 fs/xfs/xfs_super.c                  |   21 ++++
 include/linux/blk_types.h           |    2 
 include/linux/blkdev.h              |   12 ++
 include/linux/fs.h                  |    1 
 kernel/power/swap.c                 |    4 
 mm/swapfile.c                       |    3 
 41 files changed, 297 insertions(+), 157 deletions(-)
