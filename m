Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0E3729A15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbjFIMc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbjFIMcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:32:52 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3713A85;
        Fri,  9 Jun 2023 05:32:17 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 1906141AA3;
        Fri,  9 Jun 2023 07:52:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1686311561;
        bh=krk8hUPrMmB198Ms1g5PyIDtLt0DcV19Jou6f4yAGwg=;
        h=From:To:CC:Subject:Date:From;
        b=IYJsg9N8eytz39WLMlcbPEK7OW3PSm2AGMBBVCJJGD1mONe+Zb3UBRqSPU+uPhwNt
         OBhPHWZGyx3G7CLm4z2WCWIFCcXfw79pW+GA/N8GcHMNF4aTPdpQ9NS0JWOu7USYBl
         OmQKvJBz+QstQ1cuEDSetc8+A5p2lKjIbwUAKV4xFut9efGMkpRb+jZvPozPwelxV+
         T3op1xFuVgVdlMVUjt0TCxce/4s64+MjNoA2yG23nlWnr3MBlHvrrIQK6llB4sPrZf
         GAAXmMbsEIgc3ui7YpZwA9swn2bT+ybsft1d0dNGb3P6Uumhr1YCFAUYOPI7yhU4/W
         50ki8aOclQMQA==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 13:52:39 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <dlemoal@kernel.org>, <wsa@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <ming.lei@redhat.com>,
        <gregkh@linuxfoundation.org>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <sergei.shtepa@veeam.com>
Subject: [PATCH v4 00/11] blksnap - block devices snapshots module
Date:   Fri, 9 Jun 2023 13:51:55 +0200
Message-ID: <20230609115206.4649-1-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554627C6B
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all.

I am happy to offer a improved version of the Block Devices Snapshots
Module. It allows to create non-persistent snapshots of any block devices.
The main purpose of such snapshots is to provide backups of block devices.
See more in Documentation/block/blksnap.rst.

The Block Device Filtering Mechanism is added to the block layer. This
allows to attach and detach block device filters to the block layer.
Filters allow to extend the functionality of the block layer.
See more in Documentation/block/blkfilter.rst.

The tool, library and tests for working with blksnap can be found on github.
Link: https://github.com/veeam/blksnap/tree/stable-v2.0

There are few changes in this patch version. The experience of using the
out-of-tree version of the blksnap module on real servers was taken into
account.

v4 changes:
- Structures for describing the state of chunks are allocated dynamically.
  This reduces memory consumption, since the struct chunk is allocated only
  for those blocks for which the snapshot image state differs from the
  original block device.
- The algorithm for calculating the chunk size depending on the size of the
  block device has been changed. For large block devices, it is now
  possible to allocate a larger number of chunks, and their size is smaller.
- For block devices, a 'filter' file has been added to /sys/block/<device>.
  It displays the name of the filter that is attached to the block device.
- Fixed a problem with the lack of protection against re-adding a block
  device to a snapshot.
- Fixed a bug in the algorithm of allocating the next bio for a chunk.
  This problem was accurred on large disks, for which a chunk consists of
  at least two bio.
- The ownership mechanism of the diff_area structure has been changed.
  This fixed the error of prematurely releasing the diff_area structure
  when destroying the snapshot.
- Documentation corrected.
- The Sparse analyzer is passed.
- Use __u64 type instead pointers in UAPI.

v3 changes:
- New block device I/O contols BLKFILTER_ATTACH and BLKFILTER_DETACH allow
  to attach and detach filters.
- New block device I/O contol BLKFILTER_CTL allow send command to attached
  block device filter.
- The copy-on-write algorithm for processing I/O units has been optimized
  and has become asynchronous.
- The snapshot image reading algorithm has been optimized and has become
  asynchronous.
- Optimized the finite state machine for processing chunks.
- Fixed a tracking block size calculation bug.

v2 changes:
- Added documentation for Block Device Filtering Mechanism.
- Added documentation for Block Devices Snapshots Module (blksnap).
- The MAINTAINERS file has been updated.
- Optimized queue code for snapshot images.
- Fixed comments, log messages and code for better readability.

v1 changes:
- Forgotten "static" declarations have been added.
- The text of the comments has been corrected.
- It is possible to connect only one filter, since there are no others in
  upstream.
- Do not have additional locks for attach/detach filter.
- blksnap.h moved to include/uapi/.
- #pragma once and commented code removed.
- uuid_t removed from user API.
- Removed default values for module parameters from the configuration file.
- The debugging code for tracking memory leaks has been removed.
- Simplified Makefile.
- Optimized work with large memory buffers, CBT tables are now in virtual
  memory.
- The allocation code of minor numbers has been optimized.
- The implementation of the snapshot image block device has been
  simplified, now it is a bio-based block device.
- Removed initialization of global variables with null values.
- only one bio is used to copy one chunk.
- Checked on ppc64le.

Thanks for preparing v4 patch:
- Christoph Hellwig <hch@infradead.org> for his significant contribution
  to the project.
- Fabio Fantoni <fantonifabio@tiscali.it> for his participation in the
  project, useful advice and faith in the success of the project.
- Donald Buczek <buczek@molgen.mpg.de> for researching the module and
  user-space tool. His fresh look revealed a number of flaw.
- Bagas Sanjaya <bagasdotme@gmail.com> for comments on the documentation.

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
 Documentation/block/blksnap.rst      | 345 +++++++++++++++++
 Documentation/block/index.rst        |   2 +
 MAINTAINERS                          |  17 +
 block/Makefile                       |   2 +-
 block/bdev.c                         |   1 +
 block/blk-core.c                     |  27 ++
 block/blk-filter.c                   | 213 ++++++++++
 block/blk.h                          |  11 +
 block/genhd.c                        |  10 +
 block/ioctl.c                        |   7 +
 block/partitions/core.c              |  10 +
 drivers/block/Kconfig                |   2 +
 drivers/block/Makefile               |   2 +
 drivers/block/blksnap/Kconfig        |  12 +
 drivers/block/blksnap/Makefile       |  15 +
 drivers/block/blksnap/cbt_map.c      | 227 +++++++++++
 drivers/block/blksnap/cbt_map.h      |  90 +++++
 drivers/block/blksnap/chunk.c        | 454 ++++++++++++++++++++++
 drivers/block/blksnap/chunk.h        | 114 ++++++
 drivers/block/blksnap/diff_area.c    | 554 +++++++++++++++++++++++++++
 drivers/block/blksnap/diff_area.h    | 144 +++++++
 drivers/block/blksnap/diff_buffer.c  | 127 ++++++
 drivers/block/blksnap/diff_buffer.h  |  37 ++
 drivers/block/blksnap/diff_storage.c | 315 +++++++++++++++
 drivers/block/blksnap/diff_storage.h | 111 ++++++
 drivers/block/blksnap/event_queue.c  |  87 +++++
 drivers/block/blksnap/event_queue.h  |  65 ++++
 drivers/block/blksnap/main.c         | 483 +++++++++++++++++++++++
 drivers/block/blksnap/params.h       |  16 +
 drivers/block/blksnap/snapimage.c    | 124 ++++++
 drivers/block/blksnap/snapimage.h    |  10 +
 drivers/block/blksnap/snapshot.c     | 443 +++++++++++++++++++++
 drivers/block/blksnap/snapshot.h     |  68 ++++
 drivers/block/blksnap/tracker.c      | 339 ++++++++++++++++
 drivers/block/blksnap/tracker.h      |  75 ++++
 include/linux/blk-filter.h           |  51 +++
 include/linux/blk_types.h            |   2 +
 include/linux/blkdev.h               |   1 +
 include/uapi/linux/blk-filter.h      |  35 ++
 include/uapi/linux/blksnap.h         | 421 ++++++++++++++++++++
 include/uapi/linux/fs.h              |   3 +
 42 files changed, 5135 insertions(+), 1 deletion(-)
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

