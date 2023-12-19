Return-Path: <linux-fsdevel+bounces-6437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B3817E68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459781C22EFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD9710E5;
	Tue, 19 Dec 2023 00:08:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE697F;
	Tue, 19 Dec 2023 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6cea0fd9b53so1938227b3a.1;
        Mon, 18 Dec 2023 16:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944500; x=1703549300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DleLb/GRWWWOUxltcEkKo/2njLT6s7G7nFWdrSHsRNU=;
        b=cSJlsQA0HgJ1KZ8QZjm5vvE0HWokJMKjEfnYcLcFLyDZCMk/McsxlWmQpQXR4IcbG1
         brVNOD/jNIaL08QDDIUZYpaiC7uiDp5dpt5MDLw0KTHJsBhetqW1Tm5tU5aaulyI28sk
         JCI8RT11E3eMkfib+Ipo+Ae7DhWDwEmUtxna18WX9ztpZM/NQzdhI54yTethgVJJeKO+
         2W5ZHwbUoDkWqLZJpb3Ph4rgIhZZ+qR1sqv4Orzg1vkQdIpdAB6Y0VBiJzOeG97jPsra
         kkWa6VNUAQzr+5+SvMRQ7/D0MWEvh171CEBuk5VQh8b73JlQRKQmw5fbCQzFvQJZfdmI
         dOlw==
X-Gm-Message-State: AOJu0YycXcB8HcHDHyM9z5sDgM7M7Q4sLc1FCHlms4b8fVirXDcMRsVv
	L/sGUBDdH7r98ZglB0TMNtQ=
X-Google-Smtp-Source: AGHT+IGXXrqCw0mder8OAzVsO+YAR5Rrbf/ckYX1QBTX8yeZcWqslQs+f+yu8qzbuyEdvn7gPPb1Pg==
X-Received: by 2002:a05:6a20:3d93:b0:18b:480:a0f3 with SMTP id s19-20020a056a203d9300b0018b0480a0f3mr9237678pzi.4.1702944500016;
        Mon, 18 Dec 2023 16:08:20 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:08:19 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v8 00/19] Pass data lifetime information to SCSI disk devices
Date: Mon, 18 Dec 2023 16:07:33 -0800
Message-ID: <20231219000815.2739120-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Martin,

UFS vendors need the data lifetime information to achieve good performance.
Providing data lifetime information to UFS devices can result in up to 40%
lower write amplification. Hence this patch series that adds support in F2FS
and also in the block layer for data lifetime information. The SCSI disk (sd)
driver is modified such that it passes write hint information to SCSI devices
via the GROUP NUMBER field.

Please consider this patch series for the next merge window.

Thank you,

Bart.

Changes compared to v7:
 - As requested by Dave Chinner, changed one occurrence of
   file_inode(dio->iocb->ki_filp)->i_write_hint into inode->i_write_hint.
 - Modified the description of patch 03/19 since the patch that restores
   F_[GS]ET_FILE_RW_HINT has been removed.
 - Added Reviewed-by tags from v6 of this patch series and that were missing
   when v7 was posted.

Changes compared to v6:
 - Dropped patch "fs: Restore F_[GS]ET_FILE_RW_HINT support".

Changes compared to v5:
 - Added compile-time tests that compare the WRITE_LIFE_* and RWH_* constants.
 - Split the F_[GS]ET_RW_HINT handlers.
 - Removed the structure member kiocb.ki_hint again. Instead, copy the data
   lifetime information directly from struct file into a bio.
 - Together with Doug Gilbert, fixed multiple bugs in the scsi_debug patches.
   Added Doug's Tested-by.
 - Changed the type of "rscs:1" from bool into unsigned.
 - Added unit tests for the new SCSI protocol data structures.
 - Improved multiple patch descriptions.
 
Changes compared to v4:
 - Dropped the patch that renames the WRITE_LIFE_* constants.
 - Added a fix for an argument check in fcntl_rw_hint().
 - Reordered the patches that restore data lifetime support.
 - Included a fix for data lifetime support for buffered I/O to raw block
   devices.

Changes compared to v3:
 - Renamed the data lifetime constants (WRITE_LIFE_*).
 - Fixed a checkpatch complaint by changing "unsigned" into "unsigned int".
 - Rebased this patch series on top of kernel v6.7-rc1.
 
Changes compared to v2:
 - Instead of storing data lifetime information in bi_ioprio, introduce the
   new struct bio member bi_lifetime and also the struct request member
   'lifetime'.
 - Removed the bio_set_data_lifetime() and bio_get_data_lifetime() functions
   and replaced these with direct assignments.
 - Dropped all changes related to I/O priority.
 - Improved patch descriptions.

Changes compared to v1:
 - Use six bits from the ioprio field for data lifetime information. The
   bio->bi_write_hint / req->write_hint / iocb->ki_hint members that were
   introduced in v1 have been removed again.
 - The F_GET_FILE_RW_HINT and F_SET_FILE_RW_HINT fcntls have been removed.
 - In the SCSI disk (sd) driver, query the stream status and check the PERM bit.
 - The GET STREAM STATUS command has been implemented in the scsi_debug driver.

Bart Van Assche (19):
  fs: Fix rw_hint validation
  fs: Verify write lifetime constants at compile time
  fs: Split fcntl_rw_hint()
  fs: Move enum rw_hint into a new header file
  block, fs: Restore the per-bio/request data lifetime fields
  block, fs: Propagate write hints to the block device inode
  fs/f2fs: Restore the whint_mode mount option
  fs/f2fs: Restore support for tracing data lifetimes
  scsi: core: Query the Block Limits Extension VPD page
  scsi: scsi_proto: Add structures and constants related to I/O groups
    and streams
  scsi: sd: Translate data lifetime information
  scsi: scsi_debug: Reduce code duplication
  scsi: scsi_debug: Support the block limits extension VPD page
  scsi: scsi_debug: Rework page code error handling
  scsi: scsi_debug: Rework subpage code error handling
  scsi: scsi_debug: Allocate the MODE SENSE response from the heap
  scsi: scsi_debug: Implement the IO Advice Hints Grouping mode page
  scsi: scsi_debug: Implement GET STREAM STATUS
  scsi: scsi_debug: Maintain write statistics per group number

 Documentation/filesystems/f2fs.rst |  70 +++++++
 block/bio.c                        |   2 +
 block/blk-crypto-fallback.c        |   1 +
 block/blk-merge.c                  |   8 +
 block/blk-mq.c                     |   2 +
 block/bounce.c                     |   1 +
 block/fops.c                       |  14 ++
 drivers/scsi/Kconfig               |   5 +
 drivers/scsi/Makefile              |   2 +
 drivers/scsi/scsi.c                |   2 +
 drivers/scsi/scsi_debug.c          | 293 ++++++++++++++++++++++-------
 drivers/scsi/scsi_proto_test.c     |  56 ++++++
 drivers/scsi/scsi_sysfs.c          |  10 +
 drivers/scsi/sd.c                  | 111 ++++++++++-
 drivers/scsi/sd.h                  |   3 +
 fs/buffer.c                        |  12 +-
 fs/direct-io.c                     |   2 +
 fs/f2fs/data.c                     |   2 +
 fs/f2fs/f2fs.h                     |  10 +
 fs/f2fs/segment.c                  |  95 ++++++++++
 fs/f2fs/super.c                    |  32 +++-
 fs/fcntl.c                         |  63 ++++---
 fs/inode.c                         |   1 +
 fs/iomap/buffered-io.c             |   2 +
 fs/iomap/direct-io.c               |   1 +
 fs/mpage.c                         |   1 +
 include/linux/blk-mq.h             |   2 +
 include/linux/blk_types.h          |   2 +
 include/linux/fs.h                 |  17 +-
 include/linux/rw_hint.h            |  21 +++
 include/scsi/scsi_device.h         |   1 +
 include/scsi/scsi_proto.h          |  78 ++++++++
 include/trace/events/f2fs.h        |   6 +-
 33 files changed, 813 insertions(+), 115 deletions(-)
 create mode 100644 drivers/scsi/scsi_proto_test.c
 create mode 100644 include/linux/rw_hint.h


