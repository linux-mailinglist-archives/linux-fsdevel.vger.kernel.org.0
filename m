Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8A727D7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 13:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjFHLD2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 07:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjFHLDZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:03:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0281A1BFF;
        Thu,  8 Jun 2023 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZbP7hXQRI/Aj4VCpv9zrKCDBjMGU2VGZgBFY72Z1NCc=; b=LUOnMXLSVD1p6lkYtJ26KCHu1S
        V6dPxDormv+9J/w9Uma0762E1UO3j86fg1Lc1t+v4Z7LQSP2yOlNCmpipsfI5f0cE7Xt52HQiCvrC
        dmNYFzRardxLX5pwa+i2hPb6Gi12cpV8Aud74B3OePRHPPQSpP7EtomSxZyoKymNpWp0jXiy2bVjQ
        jT7w4sAIy0A/vIdj5SZUlfCAnCfaWovzJkY1/FQ9/DezIQPpW2nzAd8CDkupWG0F4XQRlNbGoTo56
        tc0XmjN75anbfdfpuQaU7tHNwXCajy+BPhavgct+vcn8JjKg4cyAnWnqlH6jkWslvMfu15OvPQtRn
        nxSGdKFw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7DPx-0091cI-1M;
        Thu, 08 Jun 2023 11:03:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: decouple block open flags from fmode_t v2
Date:   Thu,  8 Jun 2023 13:02:28 +0200
Message-Id: <20230608110258.189493-1-hch@lst.de>
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

this series adds a new blk_mode_t for block open flags instead of abusing
fmode_t.  The block open flags work very different from the normal use of
fmode_t and only share the basic READ/WRITE flags with it.  None of the
other normal FMODE_* flags is used, but instead there are three
block-specific ones not used by anyone else, which can now be removed.

Note that I've only CCed maintainers and lists for drivers and file systems
that have non-trivial changes, as otherwise the series would spam literally
everyone in the block and file system world.

A git tree is available here:

    git://git.infradead.org/users/hch/block.git blk-open-release

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-open-release

Changes since v1:
 - drop "block: share code between disk_check_media_change and
   disk_force_media_change" for now as it conflicts with a fix in
   disk_force_media_change
 - add a few missing fmode_t -> blk_mode_t conversions
 - move the opened_for_data memeber in struct cdrom_device_info to a
   place that creates less padding
 - better document the magic floppy O_ACCMODE == O_WRONLY | O_RDWR case
 - better document the new usage of file->private_data for block devices
 - improve a few commit messages

Diffstat:
 arch/um/drivers/ubd_kern.c          |   20 ++-----
 arch/xtensa/platforms/iss/simdisk.c |    6 +-
 block/bdev.c                        |   99 ++++++++++++++++++------------------
 block/blk-zoned.c                   |   12 ++--
 block/blk.h                         |   26 ++++++++-
 block/bsg-lib.c                     |    2 
 block/bsg.c                         |    8 +-
 block/disk-events.c                 |   18 +++---
 block/fops.c                        |   60 ++++++++++++++-------
 block/genhd.c                       |   13 ++--
 block/ioctl.c                       |   61 +++++++---------------
 drivers/block/amiflop.c             |   20 +++----
 drivers/block/aoe/aoeblk.c          |    8 +-
 drivers/block/ataflop.c             |   43 +++++++--------
 drivers/block/drbd/drbd_main.c      |   13 ++--
 drivers/block/drbd/drbd_nl.c        |   23 +++++---
 drivers/block/floppy.c              |   72 +++++++++++++-------------
 drivers/block/loop.c                |   24 ++++----
 drivers/block/mtip32xx/mtip32xx.c   |    4 -
 drivers/block/nbd.c                 |   12 ++--
 drivers/block/pktcdvd.c             |   36 ++++++-------
 drivers/block/rbd.c                 |    6 +-
 drivers/block/rnbd/rnbd-clt.c       |    8 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c |    3 -
 drivers/block/rnbd/rnbd-srv.c       |   23 ++++----
 drivers/block/rnbd/rnbd-srv.h       |    2 
 drivers/block/sunvdc.c              |    2 
 drivers/block/swim.c                |   24 ++++----
 drivers/block/swim3.c               |   33 +++++-------
 drivers/block/ublk_drv.c            |    4 -
 drivers/block/xen-blkback/xenbus.c  |    4 -
 drivers/block/xen-blkfront.c        |    2 
 drivers/block/z2ram.c               |    8 +-
 drivers/block/zram/zram_drv.c       |   21 +++----
 drivers/cdrom/cdrom.c               |   38 +++----------
 drivers/cdrom/gdrom.c               |   12 ++--
 drivers/md/bcache/bcache.h          |    2 
 drivers/md/bcache/request.c         |    4 -
 drivers/md/bcache/super.c           |   25 ++++-----
 drivers/md/dm-cache-target.c        |   12 ++--
 drivers/md/dm-clone-target.c        |   10 +--
 drivers/md/dm-core.h                |    7 +-
 drivers/md/dm-era-target.c          |    6 +-
 drivers/md/dm-ioctl.c               |   10 +--
 drivers/md/dm-snap.c                |    4 -
 drivers/md/dm-table.c               |   11 ++--
 drivers/md/dm-thin.c                |    9 +--
 drivers/md/dm-verity-fec.c          |    2 
 drivers/md/dm-verity-target.c       |    6 +-
 drivers/md/dm.c                     |   20 +++----
 drivers/md/dm.h                     |    2 
 drivers/md/md.c                     |   50 +++++++++---------
 drivers/mmc/core/block.c            |   12 ++--
 drivers/mtd/devices/block2mtd.c     |    6 +-
 drivers/mtd/mtd_blkdevs.c           |    8 +-
 drivers/mtd/mtdblock.c              |    2 
 drivers/mtd/ubi/block.c             |    9 +--
 drivers/nvme/host/core.c            |    6 +-
 drivers/nvme/host/ioctl.c           |   66 +++++++++++++-----------
 drivers/nvme/host/multipath.c       |    6 +-
 drivers/nvme/host/nvme.h            |    4 -
 drivers/nvme/target/io-cmd-bdev.c   |    4 -
 drivers/s390/block/dasd.c           |   10 +--
 drivers/s390/block/dasd_genhd.c     |    5 +
 drivers/s390/block/dasd_int.h       |    3 -
 drivers/s390/block/dasd_ioctl.c     |    2 
 drivers/s390/block/dcssblk.c        |   11 +---
 drivers/scsi/ch.c                   |    3 -
 drivers/scsi/scsi_bsg.c             |    4 -
 drivers/scsi/scsi_ioctl.c           |   38 ++++++-------
 drivers/scsi/sd.c                   |   39 ++++++--------
 drivers/scsi/sg.c                   |    7 +-
 drivers/scsi/sr.c                   |   22 ++++----
 drivers/scsi/st.c                   |    2 
 drivers/target/target_core_iblock.c |    9 +--
 drivers/target/target_core_pscsi.c  |   10 +--
 fs/btrfs/dev-replace.c              |    6 +-
 fs/btrfs/ioctl.c                    |   12 ++--
 fs/btrfs/super.c                    |   21 ++-----
 fs/btrfs/volumes.c                  |   55 +++++++++-----------
 fs/btrfs/volumes.h                  |   11 +---
 fs/erofs/super.c                    |    7 +-
 fs/ext4/super.c                     |   11 +---
 fs/f2fs/super.c                     |   12 ++--
 fs/jfs/jfs_logmgr.c                 |    6 +-
 fs/nfs/blocklayout/dev.c            |    9 +--
 fs/nilfs2/super.c                   |   12 +---
 fs/ocfs2/cluster/heartbeat.c        |    7 +-
 fs/reiserfs/journal.c               |   19 +++---
 fs/reiserfs/reiserfs.h              |    1 
 fs/super.c                          |   33 ++++--------
 fs/xfs/xfs_super.c                  |   15 ++---
 include/linux/blkdev.h              |   68 +++++++++++-------------
 include/linux/bsg.h                 |    2 
 include/linux/cdrom.h               |   12 ++--
 include/linux/device-mapper.h       |    8 +-
 include/linux/fs.h                  |    8 --
 include/linux/mtd/blktrans.h        |    2 
 include/scsi/scsi_ioctl.h           |    4 -
 kernel/power/hibernate.c            |   12 +---
 kernel/power/power.h                |    2 
 kernel/power/swap.c                 |   28 ++++------
 mm/swapfile.c                       |    7 +-
 103 files changed, 791 insertions(+), 837 deletions(-)
