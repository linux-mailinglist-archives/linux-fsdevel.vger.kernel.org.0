Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A93D1BA24C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgD0LcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:32:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54623 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgD0LcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587987123; x=1619523123;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q7ij0sY0GjrLljZveJ+MuDsx8nRA9+l3MO7wXpTK4m0=;
  b=lSSih3RXMuaZu9EuRs7lZBDrhiPkwwTrJ7PQdsJvBNAAv3ZB40Dif0F5
   Y6mokMvd3zRxtJYokyYER33AwfijqTWxGU9v6KiG6CCw/xWGm2rIoCEgd
   kiTIq0IuLwL3AjrJArHit7AsjGA+Co/tpFmaOUiJe5PS7US3l+uxd3Ukc
   WXGKdi67lOuzI6+XieKQf8o1RRC2pzbGN2En+ZNSR15rjYNHXIaBcHWns
   vvht0WMRotp4N2rkKpyrlnr2KDr4Q800nquKoqwNwUjjgsuTuspXPE4vl
   ndT7bX5yj3jazQiIFO2dbD0Q8nCUrdZ4Fxjsy53s0MQKspx/bQmWyZvRB
   A==;
IronPort-SDR: NQwdMu5udgf5nXKvIa7v0dMRZmRBsFLAcIBD/0ulBKGOzj8AxIhv2mtHtixGynPkz9ufp95hVY
 YPSowJ6SHGPnlMZsmbGMESvf8HBXYPd+ZgS92Q81QQfmkwGr2b92/usW7jPU96dI+UhosB1fCE
 oKrQx41s01P7CKao5cbaLC1eu+SoKAxoqXTN1JyvNPapcPRARgXeR9tctaPLG+B2v1UDNnU0vc
 GHHez4k7uFpGX4EzfBgUjsz4euSlcgL8wpcQBWpB29QYlTD8TArqlATVJ4Wpawnl9a4jOGpv76
 5gc=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="136551970"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 19:32:03 +0800
IronPort-SDR: C09CucJzL/bHievRK+D5uNuVwaotWRvBA0fM1u5xP5XT+tXlM39QLGHgNSMhlZDV6PCR97i56I
 fu/itkLIgu3SpYj0fgIdCRPySM/i4Uyu0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 04:22:44 -0700
IronPort-SDR: XqBV1teriEp4kQ7rSLgP5qQEruB9Ugr4rYMkf0jD9PuU6LQtk8mEaHjVELkoTwbp7XFY6/BXmv
 mfAHqOOq7jZw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Apr 2020 04:32:01 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 00/11] Introduce Zone Append for writing to zoned block devices
Date:   Mon, 27 Apr 2020 20:31:42 +0900
Message-Id: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The upcoming NVMe ZNS Specification will define a new type of write
command for zoned block devices, zone append.

When when writing to a zoned block device using zone append, the start
sector of the write is pointing at the start LBA of the zone to write to.
Upon completion the block device will respond with the position the data
has been placed in the zone. This from a high level perspective can be
seen like a file system's block allocator, where the user writes to a
file and the file-system takes care of the data placement on the device.

In order to fully exploit the new zone append command in file-systems and
other interfaces above the block layer, we choose to emulate zone append
in SCSI and null_blk. This way we can have a single write path for both
file-systems and other interfaces above the block-layer, like io_uring on
zoned block devices, without having to care too much about the underlying
characteristics of the device itself.

The emulation works by providing a cache of each zone's write pointer, so
zone append issued to the disk can be translated to a write with a
starting LBA of the write pointer. This LBA is used as input zone number
for the write pointer lookup in the zone write pointer offset cache and
the cached offset is then added to the LBA to get the actual position to
write the data. In SCSI we then turn the REQ_OP_ZONE_APPEND request into a
WRITE(16) command. Upon successful completion of the WRITE(16), the cache
will be updated to the new write pointer location and the written sector
will be noted in the request. On error the cache entry will be marked as
invalid and on the next write an update of the write pointer will be
scheduled, before issuing the actual write.

In order to reduce memory consumption, the only cached item is the offset
of the write pointer from the start of the zone, everything else can be
calculated. On an example drive with 52156 zones, the additional memory
consumption of the cache is thus 52156 * 4 = 208624 Bytes or 51 4k Byte
pages. The performance impact is neglectable for a spinning drive.

For null_blk the emulation is way simpler, as null_blk's zoned block
device emulation support already caches the write pointer position, so we
only need to report the position back to the upper layers. Additional
caching is not needed here.

Furthermore we have converted zonefs to run use ZONE_APPEND for synchronous
direct I/Os. Asynchronous I/O still uses the normal path via iomap.

The series is based on Jens' for-5.8/block branch with HEAD:
8cf7961dab42 ("block: bypass ->make_request_fn for blk-mq drivers")

As Christoph asked for a branch I pushed it to a git repo at:
git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git zone-append.v8
https://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git/log/?h=zone-append.v8

Changes to v7:
- Rebased on Jens' for-5.8/block
- Fixed up stray whitespace change (Bart)
- Added Reviews from Bart and Christoph

Changes to v6:
- Added Daniel's Reviewed-by's
- Addressed Christoph's comment on whitespace changes in 4/11
- Renamed driver_cb in 6/11
- Fixed lines over 80 characters in 8/11
- Damien simplified sd_zbc_revalidate_zones() in 8/11

Changes to v5:
- Added patch to fix the memleak on failed scsi command setup
- Added prep patch from Christoph for bio_add_hw_page
- Added Christoph's suggestions for adding append pages to bios
- Fixed compile warning with !CONFIG_BLK_DEV_ZONED
- Damien re-worked revalidate zone
- Added Christoph's suggestions for rescanning write pointers to update cache

Changes to v4:
- Added page merging for zone-append bios (Christoph)
- Removed different locking schmes for zone management operations (Christoph)
- Changed wp_ofst assignment from blk_revalidate_zones (Christoph)
- Smaller nitpicks (Christoph)
- Documented my changes to Keith's patch so it's clear where I messed up so he
  doesn't get blamed
- Added Damien as a Co-developer to the sd emulation patch as he wrote as much
  code for it as I did (if not more)

Changes since v3:
- Remove impact of zone-append from bio_full() and bio_add_page()
  fast-path (Christoph)
- All of the zone write pointer offset caching is handled in SCSI now
  (Christoph) 
- Drop null_blk pathces that damien sent separately (Christoph)
- Use EXPORT_SYMBOL_GPL for new exports (Christoph)	

Changes since v2:
- Remove iomap implementation and directly issue zone-appends from within
  zonefs (Christoph)
- Drop already merged patch
- Rebase onto new for-next branch

Changes since v1:
- Too much to mention, treat as a completely new series.

Christoph Hellwig (1):
  block: rename __bio_add_pc_page to bio_add_hw_page

Damien Le Moal (2):
  block: Modify revalidate zones
  null_blk: Support REQ_OP_ZONE_APPEND

Johannes Thumshirn (7):
  scsi: free sgtables in case command setup fails
  block: provide fallbacks for blk_queue_zone_is_seq and
    blk_queue_zone_no
  block: introduce blk_req_zone_write_trylock
  scsi: sd_zbc: factor out sanity checks for zoned commands
  scsi: sd_zbc: emulate ZONE_APPEND commands
  block: export bio_release_pages and bio_iov_iter_get_pages
  zonefs: use REQ_OP_ZONE_APPEND for sync DIO

Keith Busch (1):
  block: Introduce REQ_OP_ZONE_APPEND

 block/bio.c                    | 124 +++++++---
 block/blk-core.c               |  52 +++++
 block/blk-map.c                |   5 +-
 block/blk-mq.c                 |  27 +++
 block/blk-settings.c           |  23 ++
 block/blk-sysfs.c              |  13 ++
 block/blk-zoned.c              |  23 +-
 block/blk.h                    |   4 +-
 drivers/block/null_blk_zoned.c |  39 +++-
 drivers/scsi/scsi_lib.c        |  17 +-
 drivers/scsi/sd.c              |  24 +-
 drivers/scsi/sd.h              |  43 +++-
 drivers/scsi/sd_zbc.c          | 397 +++++++++++++++++++++++++++++----
 fs/zonefs/super.c              |  80 ++++++-
 include/linux/blk_types.h      |  14 ++
 include/linux/blkdev.h         |  25 ++-
 16 files changed, 803 insertions(+), 107 deletions(-)

-- 
2.24.1

