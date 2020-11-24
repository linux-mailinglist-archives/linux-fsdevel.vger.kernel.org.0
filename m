Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A72C2739
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbgKXN20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388085AbgKXN2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C1FC0617A6;
        Tue, 24 Nov 2020 05:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hzV3z6SMaqyfIauoWZXz79MWtSUwimkTva+cu+wYxlA=; b=YcqovzdCTe1S4oEOtkiwBB1Lva
        tbtWR9C+DovWiWZoNJPHK9RQrYZjKUM7Drp1hnFw1GTX1Jvk04Hd3trxzQ+fyoxsP1futR8jAHh7G
        m++vI6ur7xxBWeJPKrJNK5QVX7l3+UeM6AjbiAjRATlrWkYizakQMYaATUwBbYrcERkSINRrED8sM
        txPsKX3pPj/UYI560klmFpFYMcMloF+t/eXLNLUVVvoEw3eCXzSegwCuUVDPpT8EfzdIKSLiqbIKa
        lxgMy3k+JWNbKkmnFS165gUjPgzeD07g2h5F4z1oEdlv0ay94Qn86TlwxjevvUAt6v+K6LwpveQ2I
        DtDCjJVg==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYML-0006U2-TO; Tue, 24 Nov 2020 13:27:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: merge struct block_device and struct hd_struct v2
Date:   Tue, 24 Nov 2020 14:27:06 +0100
Message-Id: <20201124132751.3747337-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

this series cleans up our main per-device node data structure by merging
the block_device and hd_struct data structures that have the same scope,
but different life times.  The main effect (besides removing lots of
code) is that instead of having two device sizes that need complex
synchronization there is just one now.

Note that this now includes the previous "misc cleanups" series as I had
to fix up a thing in there with the changed patch ordering.

The first patch already is in 5.10-rc, but not in for-5.11/block

A git tree is available here:

    git://git.infradead.org/users/hch/block.git bdev-lookup

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/bdev-lookup

Changes since v1:
 - spelling fixes
 - fix error unwinding in __alloc_disk_node
 - use bdev_is_partition in a few more places
 - don't send the RESIZE=1 uevent for hidden gendisks
 - rename __bdget_disk to disk_find_part
 - drop a bcache patch
 - some patch reordering
 - add more refactoring
 - use rcu protection to prevent racing with a disk going away
   in blkdev_get
 - split up some of the big patches into many small ones
 - clean up the freeze_bdev interface

Diffstat:
 block/bio.c                                  |    6 
 block/blk-cgroup.c                           |   50 -
 block/blk-core.c                             |   68 +-
 block/blk-flush.c                            |    2 
 block/blk-iocost.c                           |   36 -
 block/blk-lib.c                              |    2 
 block/blk-merge.c                            |    2 
 block/blk-mq.c                               |    9 
 block/blk-mq.h                               |    7 
 block/blk.h                                  |   84 ---
 block/genhd.c                                |  467 ++++-------------
 block/ioctl.c                                |   14 
 block/partitions/core.c                      |  252 +++------
 drivers/block/drbd/drbd_receiver.c           |    2 
 drivers/block/drbd/drbd_worker.c             |    3 
 drivers/block/loop.c                         |   24 
 drivers/block/mtip32xx/mtip32xx.c            |   15 
 drivers/block/mtip32xx/mtip32xx.h            |    2 
 drivers/block/nbd.c                          |    6 
 drivers/block/xen-blkback/common.h           |    4 
 drivers/block/xen-blkfront.c                 |   20 
 drivers/block/zram/zram_drv.c                |   87 ---
 drivers/block/zram/zram_drv.h                |    1 
 drivers/md/bcache/request.c                  |    4 
 drivers/md/bcache/super.c                    |   29 -
 drivers/md/dm-core.h                         |    7 
 drivers/md/dm-table.c                        |    9 
 drivers/md/dm.c                              |   45 -
 drivers/md/md.c                              |    8 
 drivers/mtd/mtdsuper.c                       |   17 
 drivers/nvme/target/admin-cmd.c              |   20 
 drivers/s390/block/dasd.c                    |    8 
 drivers/s390/block/dasd_ioctl.c              |    9 
 drivers/scsi/scsicam.c                       |    2 
 drivers/target/target_core_file.c            |    6 
 drivers/target/target_core_pscsi.c           |    7 
 drivers/usb/gadget/function/storage_common.c |    8 
 fs/block_dev.c                               |  730 +++++++++------------------
 fs/btrfs/sysfs.c                             |   15 
 fs/btrfs/volumes.c                           |   13 
 fs/buffer.c                                  |    2 
 fs/ext4/ioctl.c                              |    2 
 fs/ext4/super.c                              |   18 
 fs/ext4/sysfs.c                              |   10 
 fs/f2fs/checkpoint.c                         |    5 
 fs/f2fs/f2fs.h                               |    2 
 fs/f2fs/file.c                               |   14 
 fs/f2fs/super.c                              |    8 
 fs/f2fs/sysfs.c                              |    9 
 fs/inode.c                                   |    3 
 fs/internal.h                                |    7 
 fs/io_uring.c                                |   10 
 fs/pipe.c                                    |    5 
 fs/pstore/blk.c                              |    2 
 fs/quota/quota.c                             |   40 +
 fs/statfs.c                                  |    2 
 fs/super.c                                   |   86 ---
 fs/xfs/xfs_fsops.c                           |    7 
 include/linux/blk-cgroup.h                   |    4 
 include/linux/blk_types.h                    |   24 
 include/linux/blkdev.h                       |   27 
 include/linux/fs.h                           |    5 
 include/linux/genhd.h                        |  110 ----
 include/linux/part_stat.h                    |   45 -
 init/do_mounts.c                             |  271 ++++------
 kernel/trace/blktrace.c                      |   54 -
 mm/filemap.c                                 |   13 
 67 files changed, 957 insertions(+), 1928 deletions(-)
