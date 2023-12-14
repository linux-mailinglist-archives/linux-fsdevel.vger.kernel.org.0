Return-Path: <linux-fsdevel+bounces-6140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA78813BAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3747C1F223B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889213A264;
	Thu, 14 Dec 2023 20:42:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504046A34D;
	Thu, 14 Dec 2023 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d345b187bbso28553555ad.0;
        Thu, 14 Dec 2023 12:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586512; x=1703191312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqG9tJ7zxgQayQdCX9vHyACQ3e5VCk0VcwcnCVDKags=;
        b=TMCqCDyo4pbdXa2d2xpvL+q55dfMoC7tRtnV6lLrkU8/JGDtx5zuGbA0fE1kxmw7ew
         6tKtIB+otSbKXaMHD5ToQOUN7S+RXkbSPQAoGUQeAD2TPxg1KV15LN5oAhEVXJ9a+Fl8
         VdULMQUkPwKc7ffTlbeazM8NqwydJudaxWiDyjmTXoMwtXPF1sFdw7NBr2tTZqjk62nQ
         w+IaGjGIMrIdGwpmL+lRoUX7y0pgsTvJBOUFsdrV6J3b0cD6Qz6W2jugpMtArErKBe1D
         KqqMvWYCnwp+pjTPs/cr9qtKOrfwWOosyhKuM/C21Ng1zTTeHB46RsBiGQQE2yt909Wt
         Yg9w==
X-Gm-Message-State: AOJu0Yz18KZreARnRVNEg2T5C+xpld87aOzLeJUE2CI5MYpQL81BJpl7
	NgXuutWtvCIn/k5vHGGNcbNPtEPPPt8=
X-Google-Smtp-Source: AGHT+IH0koqdWEPlxxr8NmpgVeEwRQtR8MHg2PQCOxQa8cD/vGqgA7yxF6npfWXzuuIbtq4sCQeW1A==
X-Received: by 2002:a17:902:7ed0:b0:1d0:83af:fa0d with SMTP id p16-20020a1709027ed000b001d083affa0dmr8940524plb.112.1702586512001;
        Thu, 14 Dec 2023 12:41:52 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm5091640plb.275.2023.12.14.12.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:41:51 -0800 (PST)
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
Subject: [PATCH v6 00/20] Pass data lifetime information to SCSI disk devices
Date: Thu, 14 Dec 2023 12:40:33 -0800
Message-ID: <20231214204119.3670625-1-bvanassche@acm.org>
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

Bart Van Assche (20):
  fs: Fix rw_hint validation
  fs: Verify write lifetime constants at compile time
  fs: Split fcntl_rw_hint()
  fs: Move enum rw_hint into a new header file
  fs: Restore F_[GS]ET_FILE_RW_HINT support
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
 fs/fcntl.c                         | 100 +++++++---
 fs/inode.c                         |   1 +
 fs/iomap/buffered-io.c             |   2 +
 fs/iomap/direct-io.c               |   1 +
 fs/mpage.c                         |   1 +
 fs/open.c                          |   1 +
 include/linux/blk-mq.h             |   2 +
 include/linux/blk_types.h          |   2 +
 include/linux/fs.h                 |  26 ++-
 include/linux/rw_hint.h            |  21 +++
 include/scsi/scsi_device.h         |   1 +
 include/scsi/scsi_proto.h          |  78 ++++++++
 include/trace/events/f2fs.h        |   5 +-
 34 files changed, 859 insertions(+), 115 deletions(-)
 create mode 100644 drivers/scsi/scsi_proto_test.c
 create mode 100644 include/linux/rw_hint.h


