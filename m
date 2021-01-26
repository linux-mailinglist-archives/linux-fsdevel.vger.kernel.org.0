Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24943304122
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 15:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405997AbhAZO6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 09:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405967AbhAZO6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:58:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36854C0698C2;
        Tue, 26 Jan 2021 06:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DlGuhvUuF5545bhBTyuoYUED18e0Xo1tptPGH+ZCVWM=; b=jMQTwjqfgxOzhYVUlZs0z9WFMS
        HRM3mdeuPCtX41haFTd6hK9e25Otzz6mCyGNcv34gLl3lwXKlK5lNyLTebUWNNaFab+hdAbStB327
        6X13dSBciQr1C4yXzcvGmt62gd3mz/quTqo9WjsRSWJx4E4YtRztVJUQF2aYf33t7c4ozLh5cmFBq
        jtTnUIVw6VgPNfzXwq64Crdqp9Bei9fIWZOg+evdMuBCYdR8RMjwHbP99COwLm/oF7u4+vzFrU+Tm
        2WUpSisrQMH9uO9aOlv+vEiHmHKQMMIj8qQj2cijQqFQjcvZAiJ5jVKPz8liZXt3v3QT/yndTE765
        OTjGoq6g==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Pi4-005luv-Pc; Tue, 26 Jan 2021 14:53:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: misc bio allocation cleanups
Date:   Tue, 26 Jan 2021 15:52:30 +0100
Message-Id: <20210126145247.1964410-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

this series contains various cleanups for how bios are allocated or
initialized plus related fallout.

Diffstat:
 Documentation/filesystems/f2fs.rst |    1 
 block/bio.c                        |  167 ++++++++++++++++++-------------------
 block/blk-crypto-fallback.c        |    2 
 block/blk-flush.c                  |   17 +--
 drivers/block/drbd/drbd_actlog.c   |    2 
 drivers/block/drbd/drbd_bitmap.c   |    2 
 drivers/block/drbd/drbd_int.h      |    2 
 drivers/block/drbd/drbd_main.c     |   13 --
 drivers/block/drbd/drbd_req.c      |    5 -
 drivers/block/drbd/drbd_req.h      |   12 --
 drivers/block/drbd/drbd_worker.c   |    5 -
 drivers/md/dm-clone-target.c       |   14 ---
 drivers/md/dm-zoned-metadata.c     |    6 -
 drivers/md/md.c                    |   48 +++-------
 drivers/md/md.h                    |    2 
 drivers/md/raid1.c                 |    2 
 drivers/md/raid10.c                |    2 
 drivers/md/raid5-ppl.c             |    2 
 drivers/md/raid5.c                 |  108 +++++++++--------------
 drivers/nvme/target/io-cmd-bdev.c  |    2 
 fs/block_dev.c                     |    2 
 fs/btrfs/volumes.c                 |    2 
 fs/exfat/file.c                    |    2 
 fs/ext4/fast_commit.c              |    4 
 fs/ext4/fsync.c                    |    2 
 fs/ext4/ialloc.c                   |    2 
 fs/ext4/super.c                    |    2 
 fs/f2fs/data.c                     |   28 ------
 fs/f2fs/f2fs.h                     |    2 
 fs/f2fs/segment.c                  |   12 --
 fs/f2fs/super.c                    |    1 
 fs/fat/file.c                      |    2 
 fs/hfsplus/inode.c                 |    2 
 fs/hfsplus/super.c                 |    2 
 fs/jbd2/checkpoint.c               |    2 
 fs/jbd2/commit.c                   |    4 
 fs/jbd2/recovery.c                 |    2 
 fs/libfs.c                         |    2 
 fs/nfs/blocklayout/blocklayout.c   |    5 -
 fs/nilfs2/segbuf.c                 |    4 
 fs/nilfs2/the_nilfs.h              |    2 
 fs/ocfs2/file.c                    |    2 
 fs/reiserfs/file.c                 |    2 
 fs/xfs/xfs_super.c                 |    2 
 fs/zonefs/super.c                  |    4 
 include/linux/bio.h                |    6 -
 include/linux/blkdev.h             |    4 
 include/linux/swap.h               |    1 
 mm/page_io.c                       |   45 ++-------
 mm/swapfile.c                      |   10 --
 50 files changed, 213 insertions(+), 363 deletions(-)
