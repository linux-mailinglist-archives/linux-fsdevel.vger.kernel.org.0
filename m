Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA2C6D8359
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 18:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjDEQOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 12:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjDEQOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:14:37 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E911E72A7;
        Wed,  5 Apr 2023 09:14:12 -0700 (PDT)
Received: from mx1.veeam.com (mx1.veeam.com [172.18.34.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 82F4F41A83;
        Wed,  5 Apr 2023 12:13:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1680711220;
        bh=OSK8IuFYxHwG6zPLaBYuaWrlVpckxHmP2+trnUr1Qyc=;
        h=From:To:CC:Subject:Date:From;
        b=FWJOw6141c5PR4x1ZbnnKbxAB03yi1/sB3mY/tXrm7vLbpuojkV9311g+snFPuZ6b
         cn3beggf1J18MCrdC/VzmbvRAYfxEspPI8//45cyxZKOrJVy8Tid9Xamatb+QgDKRg
         XcrNmlMGM10nJjVriRqW+XSkFKd547Nc26GAd9q2mXmIohNsWSzl7Z61/FReEJgVy1
         UI7SH/5mzEzZ9o1Xv2DpXxHAVEsv+vCLGb3TKpUtZTUp+LZY4hlWr8nJkgY6HiR02D
         65WB7xHTisPEWJmzwJUh3VfgoPvo63vf+dI63P7AIZmKKgl5wA15u22s98qb66FlHn
         OU8cHCEyN7bOw==
Received: from mx4.veeam.com (mx4.amust.local [172.31.224.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id C9D1C41E3C;
        Wed,  5 Apr 2023 06:09:15 -0400 (EDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 5E4EB7D499;
        Tue,  4 Apr 2023 17:09:00 +0300 (MSK)
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Apr 2023 16:08:55 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <kch@nvidia.com>,
        <martin.petersen@oracle.com>, <vkoul@kernel.org>,
        <ming.lei@redhat.com>, <gregkh@linuxfoundation.org>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v3 00/11] blksnap - block devices snapshots module
Date:   Tue, 4 Apr 2023 16:08:24 +0200
Message-ID: <20230404140835.25166-1-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554657367
X-Veeam-MMEX: True
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens. Hi Christoph. Hi Jonathan. Hi Mike. Hi all.

I am happy to offer a modified version of the Block Devices Snapshots
Module. It allows to create non-persistent snapshots of any block devices.
The main purpose of such snapshots is to provide backups of block devices.
See more in Documentation/block/blksnap.rst.

The Block Device Filtering Mechanism is added to the block layer. This
allows to attach and detach block device filters to the block layer.
Filters allow to extend the functionality of the block layer.
See more in Documentation/block/blkfilter.rst.

The tool, library and tests for working with blksnap can be found on github.
Link: https://github.com/veeam/blksnap/tree/stable-v2.0

The v2 version was suggested at 9 December 2022.
Link: https://patchwork.kernel.org/project/linux-block/list/?series=703315&archive=both
Since then, in collaboration with Christoph, work was carried out to optimize
COW algorithms for snapshots, the algorithm for reading images of snapshots,
and the control interface was redesigned.

Changes:
- new block device I/O contols BLKFILTER_ATTACH and BLKFILTER_DETACH allow 
  to attach and detach filters
- new block device I/O contol BLKFILTER_CTL allow send command to attached 
  block device filter
- the copy-on-write algorithm for processing I/O units has been optimized and
  has become asynchronous
- the snapshot image reading algorithm has been optimized and has become
  asynchronous
- optimized the finite state machine for processing chunks
- fixed a tracking block size calculation bug.

The v1 version was suggested at 2 November 2022.
Link: https://patchwork.kernel.org/project/linux-block/list/?series=691286&archive=both
Since then, documentation has been added describing the filtering mechanism and
the snapshot module of block devices. Many thanks to Fabio Fantoni for his for
his participation in the "blksnap" project on github and Jonathan Corbet for
his article.
Link: https://lwn.net/Articles/914031/.

Changes:
- added documentation for Block Device Filtering Mechanism
- added documentation for Block Devices Snapshots Module (blksnap)
- the MAINTAINERS file has been updated
- optimized queue code for snapshot images
- fixed comments, log messages and code for better readability.

The first version was suggested at 13 June 2022.
Link: https://patchwork.kernel.org/project/linux-block/list/?series=649931&archive=both
Many thanks to Christoph Hellwig and Randy Dunlap for the review of that
version.

Changes:
- forgotten "static" declarations have been added
- the text of the comments has been corrected.
- it is possible to connect only one filter, since there are no others in
  upstream.
- do not have additional locks for attach/detach filter.
- blksnap.h moved to include/uapi/.
- #pragma once and commented code removed.
- uuid_t removed from user API.
- removed default values for module parameters from the configuration file.
- the debugging code for tracking memory leaks has been removed.
- simplified Makefile.
- optimized work with large memory buffers, CBT tables are now in virtual
  memory.
- the allocation code of minor numbers has been optimized.
- the implementation of the snapshot image block device has been
  simplified, now it is a bio-based block device.
- removed initialization of global variables with null values.
- only one bio is used to copy one chunk.
- checked on ppc64le.

Sergei Shtepa (11):
  documentation: Block Device Filtering Mechanism
  block: Block Device Filtering Mechanism
  documentation: Block Devices Snapshots Module
  blksnap: header file of the module interface
  blksnap: module management interface functions
  blksnap: handling and tracking I/O units
  blksnap: minimum data storage unit of the original block device
  blksnap: difference storage
  blksnap: event queue from the difference storage
  blksnap: snapshot and snapshot image block device
  blksnap: Kconfig and Makefile

 Documentation/block/blkfilter.rst    |  64 ++++
 Documentation/block/blksnap.rst      | 345 ++++++++++++++++++++
 Documentation/block/index.rst        |   2 +
 MAINTAINERS                          |  17 +
 block/Makefile                       |   2 +-
 block/bdev.c                         |   1 +
 block/blk-core.c                     |  40 ++-
 block/blk-filter.c                   | 199 ++++++++++++
 block/blk.h                          |  10 +
 block/genhd.c                        |   2 +
 block/ioctl.c                        |   7 +
 block/partitions/core.c              |   2 +
 drivers/block/Kconfig                |   2 +
 drivers/block/Makefile               |   2 +
 drivers/block/blksnap/Kconfig        |  12 +
 drivers/block/blksnap/Makefile       |  15 +
 drivers/block/blksnap/cbt_map.c      | 228 +++++++++++++
 drivers/block/blksnap/cbt_map.h      |  90 +++++
 drivers/block/blksnap/chunk.c        | 470 +++++++++++++++++++++++++++
 drivers/block/blksnap/chunk.h        | 106 ++++++
 drivers/block/blksnap/diff_area.c    | 440 +++++++++++++++++++++++++
 drivers/block/blksnap/diff_area.h    | 133 ++++++++
 drivers/block/blksnap/diff_buffer.c  | 127 ++++++++
 drivers/block/blksnap/diff_buffer.h  |  37 +++
 drivers/block/blksnap/diff_storage.c | 329 +++++++++++++++++++
 drivers/block/blksnap/diff_storage.h | 111 +++++++
 drivers/block/blksnap/event_queue.c  |  87 +++++
 drivers/block/blksnap/event_queue.h  |  64 ++++
 drivers/block/blksnap/main.c         | 428 ++++++++++++++++++++++++
 drivers/block/blksnap/params.h       |  16 +
 drivers/block/blksnap/snapimage.c    | 120 +++++++
 drivers/block/blksnap/snapimage.h    |  10 +
 drivers/block/blksnap/snapshot.c     | 433 ++++++++++++++++++++++++
 drivers/block/blksnap/snapshot.h     |  68 ++++
 drivers/block/blksnap/tracker.c      | 320 ++++++++++++++++++
 drivers/block/blksnap/tracker.h      |  71 ++++
 include/linux/blk-filter.h           |  51 +++
 include/linux/blk_types.h            |   2 +
 include/linux/blkdev.h               |   1 +
 include/uapi/linux/blk-filter.h      |  35 ++
 include/uapi/linux/blksnap.h         | 421 ++++++++++++++++++++++++
 include/uapi/linux/fs.h              |   5 +
 42 files changed, 4922 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/block/blkfilter.rst
 create mode 100644 Documentation/block/blksnap.rst
 create mode 100644 block/blk-filter.c
 create mode 100644 drivers/block/blksnap/Kconfig
 create mode 100644 drivers/block/blksnap/Makefile
 create mode 100644 drivers/block/blksnap/cbt_map.c
 create mode 100644 drivers/block/blksnap/cbt_map.h
 create mode 100644 drivers/block/blksnap/chunk.c
 create mode 100644 drivers/block/blksnap/chunk.h
 create mode 100644 drivers/block/blksnap/diff_area.c
 create mode 100644 drivers/block/blksnap/diff_area.h
 create mode 100644 drivers/block/blksnap/diff_buffer.c
 create mode 100644 drivers/block/blksnap/diff_buffer.h
 create mode 100644 drivers/block/blksnap/diff_storage.c
 create mode 100644 drivers/block/blksnap/diff_storage.h
 create mode 100644 drivers/block/blksnap/event_queue.c
 create mode 100644 drivers/block/blksnap/event_queue.h
 create mode 100644 drivers/block/blksnap/main.c
 create mode 100644 drivers/block/blksnap/params.h
 create mode 100644 drivers/block/blksnap/snapimage.c
 create mode 100644 drivers/block/blksnap/snapimage.h
 create mode 100644 drivers/block/blksnap/snapshot.c
 create mode 100644 drivers/block/blksnap/snapshot.h
 create mode 100644 drivers/block/blksnap/tracker.c
 create mode 100644 drivers/block/blksnap/tracker.h
 create mode 100644 include/linux/blk-filter.h
 create mode 100644 include/uapi/linux/blk-filter.h
 create mode 100644 include/uapi/linux/blksnap.h

-- 
2.20.1

