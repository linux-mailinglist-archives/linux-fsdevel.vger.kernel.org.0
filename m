Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBC67078EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 06:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjEREXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 00:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjEREXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 00:23:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA88B115;
        Wed, 17 May 2023 21:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=yXqzctwvrt2mzrQ8XZQ/YXlMgRwTYOTgMECAAuaBtIE=; b=aBwelQ6aSfvIL1vnjQjs7ZTrja
        yoNoJPXOx/mGnVfzhTxM1ON7llyBf7j7/k7VuyMQYQWvCuY+x+CgwjOLH/dpdWlz7nDRL12/G9uD6
        s84cpX5NhAhgOeP8+gILgTETrvqqx0ehr7h8OBBAYCAlXIqTZfqr2RXAOREE0ewe2nWDsXh8j1H00
        SYH1t/IU7vO6lR5RZrQEQkEKHVk69rtvp70BdO/clOS+QA9w2Yi07zZYZE4jf2kDtXS/dBs4AkKpE
        ZYsZ2m0zi00X7Mr/qyMQEXmALRGM8MhvBiF1REBEbDnlRg3tbFwKMucu9U1SCIPYkalQr8O72brMY
        7zd1mLEQ==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzVAi-00BqNS-2s;
        Thu, 18 May 2023 04:23:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: introduce bdev holder ops and a file system shutdown method v2
Date:   Thu, 18 May 2023 06:23:09 +0200
Message-Id: <20230518042323.663189-1-hch@lst.de>
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
 fs/ext4/super.c                     |    3 
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
 39 files changed, 266 insertions(+), 148 deletions(-)
