Return-Path: <linux-fsdevel+bounces-4295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E827FE6F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0768281FE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E793134C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4785198;
	Wed, 29 Nov 2023 17:33:31 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c2b7ec93bbso370919a12.2;
        Wed, 29 Nov 2023 17:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308011; x=1701912811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDwp3WaBXHek3yls+ewc1h8qGWJkJUcufep7oMLO/Xg=;
        b=dlo/FhnZqPDiW5V/uasdMvMf0FK9eBAfH8HRlqALgI0hMjUrt59g70ZOsmnayA8lSE
         mH7FV90SQwgBd0iGWssZtBFXgzDiwdXKtULBv/5PIl+hRS5WiNdS05mIStJjWXqMRAn5
         iCASOE4t/IqpNQyY2j7zophMlU93ttSPmG7ZnNQRjJQ2DEmXdkS2Qo8tbZhTfLSFUxVw
         lLv9dfymUguNl0UejCTywE+eG6LZie72ueIXFpX7H8bCxUOaGNe+X6AwX8tit0kTl5gP
         0UauguNh1xmqJzRXRE8KNiwfcUdzZvtQWfUKN0qx65rsYitoHxAk6y3WhjJlEIjFI8tN
         6NMQ==
X-Gm-Message-State: AOJu0YxFow3jM+PF5MO4o5DQv+BxfFvr4+4ccy047oKfLgR62eSIaQ+G
	QcKSMPR6PdU+ET02zbaw4JY=
X-Google-Smtp-Source: AGHT+IGF22o1y1U+uKNTJ1FhKUNpjzhaUNA3Www79e7gS4POwdBnt6PucfdiAe1q9e/v/W/MOJS+YQ==
X-Received: by 2002:a05:6a21:339e:b0:18c:fa0a:d484 with SMTP id yy30-20020a056a21339e00b0018cfa0ad484mr6274421pzb.42.1701308010844;
        Wed, 29 Nov 2023 17:33:30 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:30 -0800 (PST)
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
Subject: [PATCH v5 00/17] Pass data lifetime information to SCSI disk devices
Date: Wed, 29 Nov 2023 17:33:05 -0800
Message-ID: <20231130013322.175290-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
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


Bart Van Assche (17):
  fs: Fix rw_hint validation
  fs: Move enum rw_hint into a new header file
  fs/f2fs: Restore the whint_mode mount option
  fs: Restore F_[GS]ET_FILE_RW_HINT support
  fs: Restore kiocb.ki_hint
  block: Restore the per-bio/request data lifetime fields
  block: Propagate write hints to the block device inode
  scsi: core: Query the Block Limits Extension VPD page
  scsi_proto: Add structures and constants related to I/O groups and
    streams
  sd: Translate data lifetime information
  scsi_debug: Reduce code duplication
  scsi_debug: Support the block limits extension VPD page
  scsi_debug: Rework page code error handling
  scsi_debug: Rework subpage code error handling
  scsi_debug: Implement the IO Advice Hints Grouping mode page
  scsi_debug: Implement GET STREAM STATUS
  scsi_debug: Maintain write statistics per group number

 Documentation/filesystems/f2fs.rst |  70 ++++++++
 block/bio.c                        |   2 +
 block/blk-crypto-fallback.c        |   1 +
 block/blk-merge.c                  |   8 +
 block/blk-mq.c                     |   2 +
 block/bounce.c                     |   1 +
 block/fops.c                       |  14 ++
 drivers/scsi/scsi.c                |   2 +
 drivers/scsi/scsi_debug.c          | 247 +++++++++++++++++++++--------
 drivers/scsi/scsi_sysfs.c          |  10 ++
 drivers/scsi/sd.c                  | 111 ++++++++++++-
 drivers/scsi/sd.h                  |   3 +
 fs/aio.c                           |   1 +
 fs/buffer.c                        |  12 +-
 fs/direct-io.c                     |   2 +
 fs/f2fs/data.c                     |   2 +
 fs/f2fs/f2fs.h                     |  10 ++
 fs/f2fs/file.c                     |   6 +
 fs/f2fs/segment.c                  |  95 +++++++++++
 fs/f2fs/super.c                    |  32 +++-
 fs/fcntl.c                         |  34 +++-
 fs/inode.c                         |   1 +
 fs/iomap/buffered-io.c             |   2 +
 fs/iomap/direct-io.c               |   1 +
 fs/mpage.c                         |   1 +
 fs/open.c                          |   1 +
 include/linux/blk-mq.h             |   2 +
 include/linux/blk_types.h          |   2 +
 include/linux/fs.h                 |  29 ++--
 include/linux/rw_hint.h            |  20 +++
 include/scsi/scsi_device.h         |   1 +
 include/scsi/scsi_proto.h          |  75 +++++++++
 include/trace/events/f2fs.h        |   5 +-
 io_uring/rw.c                      |   1 +
 34 files changed, 711 insertions(+), 95 deletions(-)
 create mode 100644 include/linux/rw_hint.h


